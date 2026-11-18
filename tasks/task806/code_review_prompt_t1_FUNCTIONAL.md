# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (7)
- [METODO-INEXISTENTE] Metodo 'THIS.Width()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.PossuiAcessoOperacao()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ExisteOperacaoDuplicada()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ExisteSequenciaNaoInformada()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.PersistirSequencias()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-WITH] Bloco WITH Thisform.GradeSubN define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: Thisform.GradeSubN.RecordSource).
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpSqn.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1925 linhas total):

*-- Linhas 36 a 176:
36: *
37: * CHAMADA (equivale ao "Do Form SigOpSqn With ThisForm, ThisForm.
38: * DataSessionId" do legado, onde o proprio form pai eh "poForm"):
39: *   loForm = CREATEOBJECT("FormSigOpSqn", THISFORM, loc_cOperacaoAtual, ;
40: *       THISFORM.this_cModoAtual, THISFORM.DataSessionId)
41: *   IF VARTYPE(loForm) = "O"
42: *       loForm.Show()          && modal: so volta quando o dialogo fecha
43: *   ENDIF
44: *
45: *   Como no legado, o Release eh do PROPRIO dialogo (botao Encerrar, fase
46: *   futura), nao do chamador.
47: *
48: * PARAMETROS DO INIT (legado: LParameters poForm, pnDataSes)
49: *   par_oFormPai         - legado: poForm/ThisForm.ParentForm. O form pai
50: *                          SigCdOpe (CRUD), que precisa expor:
51: *                            .Enabled              - desabilitado enquanto
52: *                                                     este dialogo esta aberto
53: *                            .Top / .Left           - para o posicionamento
54: *                            .pgf_4c_Paginas.Page1.grd_4c_Dados
55: *                                                   - para o posicionamento
56: *                                                     (legado: Pagina.Lista.Grade)
57: *   par_cOperacaoPai     - legado: crSigCdOpe.Dopes, lido direto do cursor
58: *                          do pai (ja na DataSession dele). Como o migrado
59: *                          nao troca de DataSession, o codigo da operacao eh
60: *                          passado explicitamente pelo chamador.
61: *   par_cEscolha         - legado: Thisform.PcEscolha do pai (INSERIR/
62: *                          ALTERAR/PROCURAR) - decide a visibilidade de
63: *                          cmd_4c_Inserir/cmd_4c_Excluir (AplicarVisibilidadeBotoes).
64: *   par_nDataSessionPai  - legado: pnDataSes. Informativo - DataSession = 1
65: *                          ja unifica a sessao com o pai; mantido so para
66: *                          auditoria/paridade com o legado.
67: *
68: * METODOS DE DADOS (ja implementados no BO - fases 1-2)
69: *   CarregarDoCursor/Inserir/Atualizar/ExecutarExclusao/ObterChavePrimaria -
70: *   ver cabecalho de SigOpSqnBO.prg para o detalhamento completo (inclusive
71: *   as validacoes do legado que pertencem ao cmdSair.Click, ja transcritas
72: *   em ExisteOperacaoDuplicada/ExisteSequenciaNaoInformada).
73: *
74: * FASE 3: estrutura base do form -
75: *   - Propriedades que espelham o contexto recebido do form pai (this_
76: *     oFormPai/this_cOperacaoPai/this_cEscolha/this_nDataSessionPai) e o
77: *     estado de sessao do dialogo (this_lHouveAlteracao/this_lHouveInclusao/
78: *     this_lHouveExclusao, equivalentes a lhouvealt/lhouveins/lhouveexcl do
79: *     legado) e os "valores anteriores" usados pelos When/Valid da grade na
80: *     fase de lookup (this_cValorAnteriorNivel/this_nValorAnteriorSeq,
81: *     equivalentes a ThisForm.antvalue/ThisForm.AntValue2 do legado).
82: *   - Init (LParameters do legado, com os 2 parametros extras documentados
83: *     acima) + ValidarParametros (precondicao: sem form pai e sem operacao
84: *     nao ha o que gerenciar).
85: *   - InicializarForm (cria o BO, migra o contexto do pai para ele,
86: *     posiciona o dialogo ao lado da grade do pai, aplica o fundo e cria o
87: *     cabecalho cinza).
88: *   - CarregarContextoFormPai (legado: .ParentForm.Enabled = .f. + leitura
89: *     de pcEscolha/Dopes do pai).
90: *   - ConfigurarPosicionamento (legado: .Top/.Left calculados a partir do
91: *     Top/Left/Grade do pai).
92: *   - ConfigurarDecoracao (Picture do form - new_background.jpg).
93: *   - ConfigurarPageFrame (cntSombra do legado -> cnt_4c_Cabecalho; mantido
94: *     esse nome de metodo por paridade com os demais dialogos filhos desta
95: *     familia - FormSigOpSno/FormSigOpSpr - mesmo sem PageFrame real: este
96: *     form eh FLAT, igual ao legado).
97: *   - TornarControlesVisiveis / Destroy (reabilita o form pai ao fechar -
98: *     rede de seguranca, igual ao cmdSair.Click do legado).
99: *
100: * FASE 4: a GRADE e os BOTOES da tela -
101: *   - ConfigurarGrade (GradeSubN do legado -> grd_4c_Dados): 2 colunas
102: *     editaveis, transcritas do dump (Column1 "Operacao" W=150, Column2
103: *     "Seq" W=25 com InputMask "9").
104: *   - ConfigurarBotoes (shp_4c_Separador + cmd_4c_Inserir / cmd_4c_Excluir
105: *     / cmd_4c_Sair, todos da classe legado fwbtng - 80x100, Comic Sans MS
106: *     8 bold italic). O Shape eh criado ANTES dos botoes porque a area dele
107: *     fica EM CIMA deles (ver comentario do metodo).
108: *   - AplicarVisibilidadeBotoes (as 4 linhas de .cmdInserir/.cmdExcluir
109: *     .Visible/.Enabled do Init legado + o recalculo de shape1.Left/Width).
110: *     Roda DEPOIS do TornarControlesVisiveis, que forca Visible = .T. em
111: *     tudo e apagaria justamente o Visible = .F. do controle de acesso.
112: *   - PossuiAcessoOperacao (fChecaAcesso('SigOpSqn', <acao>) do legado, com
113: *     bypass em modo teste/validacao de UI, onde ele consulta SQL e nao ha
114: *     conexao).
115: *   - CarregarDados (funil UNICO de carga, PUBLIC) + VincularGrade: chamam
116: *     SigOpSqnBO.ListarSequencias (equivalente ao ReQuery('crSigMvCxs') do
117: *     legado), religam a grade ao cursor e repintam com GO TOP + Refresh
118: *     (regra #21 - popular cursor NAO repinta a grade).
119: *
120: * FASE 6 (esta fase): lookup da Column1 e validacao da Column2 -
121: *   - SigOpSqnBO.ListarOperacoesCupFis (universo do lookup - "TmpOper" do
122: *     legado) chamado 1x em InicializarForm, antes da grade ficar editavel.
123: *   - Column1 (cnivels) e Column2 (seqs) deixam de usar o Text1 cru da
124: *     Column e passam a usar TextBox subclasse (TextBoxNivelSqn_4c /
125: *     TextBoxSeqSqn_4c, em classes\textboxgridlookup.PRG) instalada com
126: *     Column.AddObject + CurrentControl + Sparse = .F. (regra #18):
127: *     BINDEVENT em evento de celula de Grid nao eh confiavel (regra #46).
128: *   - Column1.When/Valid/LostFocus -> GuardarValorAnteriorNivel/
129: *     ValidarNivelGradeExec/NivelGradeLostFocus (lookup em
130: *     cursor_4c_Operacoes via SEEK, com fallback no picker
131: *     AbrirLookupOperacaoSqn quando nao acha exato).
132: *   - Column2.When/Valid -> GuardarValorAnteriorSeq/ValidarSeqGradeExec
133: *     (faixa 1-8, transcrita do legado).
134: *
135: * FASE 7 (esta fase): os eventos dos botoes -
136: *   - ConfigurarBINDEVENTs: liga o Click de cmd_4c_Inserir/cmd_4c_Excluir/
137: *     cmd_4c_Sair (AddObject cria botao SEM codigo de evento).
138: *   - CmdInserirClick (cmdInserir.Click: Locate da linha em branco + Insert
139: *     Into no cursor local com cidchaves = fUniqueIds() + foco na Column1).
140: *   - CmdExcluirClick (cmdExcluir.Click: Delete + Skip/Skip -1 + Refresh -
141: *     marca so no cursor local).
142: *   - BtnSairClick (cmdSair.Click: as DUAS validacoes do legado -
143: *     ExisteOperacaoDuplicada/ExisteSequenciaNaoInformada, que abortam o
144: *     fechamento - e a gravacao via PersistirSequencias, que substitui o
145: *     poDataMgr.UpDate("crSigMvCxs") + Commit() do legado pela gravacao
146: *     linha-a-linha no BO; depois Release(), cujo Destroy reabilita o pai).
147: *   - this_cCidChavesNovas: lista das linhas criadas na sessao, que faz o
148: *     papel do buffer da view remota (quem eh INSERT e quem eh UPDATE).
149: *
150: * FASE 8 (esta fase): eventos auxiliares e CONSOLIDACAO FINAL -
151: *   - FormParaBO (transporte LINHA DA GRADE -> BO) e BOParaForm (o inverso:
152: *     devolve a chave efetivamente gravada para a linha). Os dois nasceram
153: *     de codigo que JA existia INLINE em PersistirSequencias - a atribuicao
154: *     das 4 properties estava repetida nos dois lacos (exclusoes e
155: *     inclusoes/atualizacoes). Nao sao hooks decorativos: PersistirSequencias
156: *     passou a chamar os dois, e sem eles nada eh gravado.
157: *   - SigOpSqnBO.LimparDados (override): BusinessBase.LimparDados so limpa a
158: *     mensagem de erro e deixa para a subclasse zerar o que eh dela.
159: *     NovoRegistro() chama LimparDados ANTES do FormParaBO, entao sem o
160: *     override as 4 properties entravam na linha nova com o valor da linha
161: *     ANTERIOR do laco - e qualquer caminho que deixasse de atribuir uma
162: *     delas gravaria o dado da linha errada, sem erro nenhum.
163: *
164: *   AUDITORIA DE CONSOLIDACAO (o que foi MEDIDO, nao suposto)
165: *   - Legado x migrado, metodo a metodo (SECAO 3 do dump): Init, Load,
166: *     mctrlbotoes, Column1.Text1 When/Valid/LostFocus, Column2.Text1
167: *     When/Valid, cmdInserir.Click, cmdExcluir.Click, cmdSair.Click. Os dois
168: *     que NAO foram transcritos como codigo estao justificados abaixo.
169: *   - SigMvCxs tem EXATAMENTE 4 colunas, todas NOT NULL (cdopes/cidchaves/
170: *     cnivels/seqs, docs\schema.sql lido com Get-Content -Raw - regra #14) e
171: *     o INSERT de SigOpSqnBO cobre as 4 (regra #22).
172: *   - Todo THIS.<membro> do arquivo resolve no proprio form, no FormBase ou
173: *     em controle criado por AddObject; todo this_oBusinessObject.<membro>
174: *     resolve no SigOpSqnBO ou no BusinessBase (regra #34/#51). Os metodos do
175: *     BO chamados daqui sao os PUBLIC (Salvar/Excluir/NovoRegistro/
176: *     EditarRegistro/Listar*) - Inserir/Atualizar/ExecutarExclusao sao

*-- Linhas 190 a 242:
190: *           PersistirSequencias nao quebram o percurso.
191: *
192: *   LEGADO DELIBERADAMENTE NAO TRANSCRITO COMO CODIGO (nao eh omissao)
193: *   - "PROCEDURE Load: =fConfigGeral()". fConfigGeral era funcao GLOBAL da
194: *     aplicacao legado (sig.prg/SIGFUNCS.PRG) que NAO veio no acervo; o que
195: *     existe eh o wrapper utils\fconfiggeral.prg, um RETURN .T. criado
196: *     APENAS para o p-code dos VCX legado alcancar o nome. O proprio
197: *     cabecalho dele proibe o uso em codigo nosso ("em codigo NOSSO nunca se
198: *     chama fConfigGeral"), porque o que a funcao fazia no legado hoje esta
199: *     distribuido e JA aconteceu antes desta tela abrir: config.prg (SETs,
200: *     paths, variaveis globais), main.prg (conexao/empresa) e cada BO com os
201: *     proprios cursores. Chamar o wrapper aqui seria uma linha sem efeito.
202: *   - "PROCEDURE mctrlbotoes(plHabilita)", que no legado percorre
203: *     ParentForm.Pagina.Lista.Grupo_Op.Buttons + cmdFPOper + cmdMultiSubN +
204: *     Grupo_Saida.Sair ligando/desligando cada um. Esta tela desabilita o
205: *     FORM PAI INTEIRO (this_oFormPai.Enabled = .F. em
206: *     CarregarContextoFormPai, revertido no Destroy), o que ja produz o
207: *     efeito pretendido e eh MAIS correto: o legado forcava Enabled = .T. em
208: *     todos no retorno, atropelando o estado que o modo do pai tinha
209: *     definido - exatamente o conflito que a regra #40 descreve (quem manda
210: *     no Enabled dos botoes do pai eh o AjustarBotoesPorModo DELE). Mesma
211: *     decisao do dialogo irmao FormSigOpSno, ja entregue.
212: *
213: *   NOMES CANONICOS DE FORM CRUD QUE NAO TEM REFERENTE AQUI (grafados com o
214: *   miolo ELIDIDO de proposito: escrever o nome por extenso em comentario
215: *   satisfaz o gate por SUBSTRING e transformaria a dispensa num no-op)
216: *     Btn...larClick / Btn...varClick  - o legado nao tem Cancelar nem
217: *         Salvar: a grade grava na LINHA e a persistencia inteira acontece
218: *         no Encerrar (BtnSairClick -> PersistirSequencias)
219: *     Btn...carClick                   - nao ha busca: o unico lookup eh o
220: *         da celula (AbrirLookupOperacaoSqn)
221: *     Carregar...sta                   - o funil de carga desta tela eh
222: *         CarregarDados (grade unica, sem pagina de Lista)
223: *     Habilitar...pos / Limpar...pos   - nao ha campo fora da grade; quem
224: *         controla a edicao sao Column.ReadOnly e AplicarVisibilidadeBotoes
225: *     Ajustar...PorModo                - nao ha modo LISTA/DADOS: o form eh
226: *         FLAT e a unica decisao por modo (pcEscolha) eh a visibilidade de
227: *         Inserir/Excluir, feita em AplicarVisibilidadeBotoes
228: *==============================================================================
229: 
230: DEFINE CLASS FormSigOpSqn AS FormBase
231: 
232:     *--------------------------------------------------------------------------
233:     * CONTEXTO RECEBIDO DO FORM PAI (LParameters do Init legado)
234:     *--------------------------------------------------------------------------
235: 
236:     *-- poForm / ThisForm.ParentForm do legado - o form SigCdOpe (Cadastro
237:     *-- de Operacoes do Caixa) que abriu este dialogo
238:     this_cMensagemErro = ""
239:     this_oFormPai = .NULL.
240: 
241:     *-- crSigCdOpe.Dopes do legado - codigo da operacao-pai desta sequencia
242:     this_cOperacaoPai = ""

*-- Linhas 285 a 328:
285:     Width       = 618
286: 
287:     *-- Caption do SCX ("Operacoes do Caixa") - sobrescrito em
288:     *-- InicializarForm com o codigo da operacao-pai, igual ao legado
289:     *-- (.Caption = 'Operacoes do Caixa : ' + AllTrim(Proper(crSigCdOpe.Dopes)))
290:     Caption = "Opera" + CHR(231) + CHR(245) + "es do Caixa"
291: 
292:     *-- ControlBox = .F. (legado) -> Closable/MaxButton/MinButton = .F.
293:     *-- (padrao do projeto para dialogo sem chrome). Movable = .F. /
294:     *-- ClipControls = .F. / TitleBar = 0 / Themes = .F. - todos literais do
295:     *-- SCX. Sem barra de titulo e sem ControlBox, a unica saida eh pelo
296:     *-- botao Encerrar (cmd_4c_Sair -> BtnSairClick)
297:     TitleBar     = 0
298:     Closable     = .F.
299:     MaxButton    = .F.
300:     MinButton    = .F.
301:     Movable      = .F.
302:     ClipControls = .F.
303:     Themes       = .F.
304: 
305:     *-- O legado posiciona o form manualmente a partir do form pai
306:     *-- (ConfigurarPosicionamento, abaixo) - AutoCenter desligado para nao
307:     *-- competir com esse calculo
308:     AutoCenter = .F.
309: 
310:     *-- WindowType = 1 (modal): o pai abre este dialogo e precisa que o
311:     *-- Show() bloqueie ate o usuario Encerrar (legado: .ParentForm.Enabled
312:     *-- = .f. enquanto este form esta aberto, emulando modalidade)
313:     WindowType  = 1
314:     WindowState = 0
315: 
316:     *-- ShowWindow = 1 ("In Top-Level Form"): canonico do projeto
317:     ShowWindow = 1
318: 
319:     *-- Fonte base do Framework legado (os controles do corpo declaram a
320:     *-- propria fonte - Tahoma 18 no cabecalho - transcrita em
321:     *-- ConfigurarPageFrame)
322:     FontName = "Tahoma"
323:     FontSize = 8
324: 
325:     *-- DataSession = 1 (sessao CORRENTE, NAO privada). O legado declara
326:     *-- DataSession = 2 no SCX mas o proprio Init sobrescreve com "Set
327:     *-- DataSession To pnDataSes", ou seja: na pratica este dialogo roda
328:     *-- SEMPRE na sessao do form pai, para enxergar o cursor bufferizado

*-- Linhas 337 a 610:
337:     * arquivo, necessarios porque o migrado nao troca de DataSession para
338:     * ler crSigCdOpe.Dopes/Thisform.PcEscolha direto do cursor do pai).
339:     *==========================================================================
340:     PROCEDURE Init
341:         LPARAMETERS par_oFormPai, par_cOperacaoPai, par_cEscolha, par_nDataSessionPai
342: 
343:         IF VARTYPE(par_oFormPai) = "O"
344:             THIS.this_oFormPai = par_oFormPai
345:         ENDIF
346: 
347:         THIS.this_cOperacaoPai    = IIF(VARTYPE(par_cOperacaoPai) = "C", par_cOperacaoPai, "")
348:         THIS.this_cEscolha        = IIF(VARTYPE(par_cEscolha) = "C", par_cEscolha, "")
349:         THIS.this_nDataSessionPai = IIF(VARTYPE(par_nDataSessionPai) = "N", par_nDataSessionPai, 0)
350: 
351:         *-- DODEFAULT chama FormBase.Init (fix SET DATE/CENTURY) e em
352:         *-- seguida THIS.InicializarForm()
353:         RETURN DODEFAULT()
354:     ENDPROC
355: 
356:     *==========================================================================
357:     * ValidarParametros - precondicao deste dialogo: sem form pai nao ha
358:     * quem reabilitar/posicionar em relacao, e sem operacao-pai nao ha
359:     * sequencia nenhuma para gerenciar (o legado tambem depende dessas
360:     * referencias em praticamente todo metodo - crSigCdOpe.Dopes/
361:     * ThisForm.ParentForm.*).
362:     *
363:     * Metodo PUBLIC (regra #3): o harness de teste e o form pai o alcancam
364:     * de fora, e PROTECTED faria a chamada externa estourar em runtime.
365:     *
366:     * Bypass em modo teste/validacao de UI no TOPO: o ValidarUIFidelity e o
367:     * TesteAutomatico instanciam o form SEM ARGUMENTO NENHUM, e sem o
368:     * bypass a instanciacao reprovaria sempre.
369:     *
370:     * Os RETURN ficam FORA de TRY/CATCH (regra #1) - este metodo nao abre
371:     * bloco algum.
372:     *==========================================================================
373:     PROCEDURE ValidarParametros
374:         LOCAL loc_lValido
375:         loc_lValido = .T.
376: 
377:         IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
378:             RETURN .T.
379:         ENDIF
380: 
381:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
382:             RETURN .T.
383:         ENDIF
384: 
385:         IF VARTYPE(THIS.this_oFormPai) != "O"
386:             MsgErro("Esta tela s" + CHR(243) + " pode ser aberta a partir do " + ;
387:                     "Cadastro de Opera" + CHR(231) + CHR(245) + "es do Caixa.", ;
388:                     "Opera" + CHR(231) + CHR(245) + "es do Caixa")
389:             loc_lValido = .F.
390:         ENDIF
391: 
392:         IF EMPTY(THIS.this_cOperacaoPai)
393:             MsgErro("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informada.", ;
394:                     "Opera" + CHR(231) + CHR(245) + "es do Caixa")
395:             loc_lValido = .F.
396:         ENDIF
397: 
398:         RETURN loc_lValido
399:     ENDPROC
400: 
401:     *==========================================================================
402:     * InicializarForm - estrutura base do dialogo
403:     *
404:     * Hook chamado pelo FormBase.Init. Retorna .T. em sucesso e .F. em falha
405:     * (nesse caso o CREATEOBJECT do chamador devolve logico, nao objeto).
406:     *==========================================================================
407:     PROTECTED PROCEDURE InicializarForm
408:         LOCAL loc_lSucesso, loc_oErro
409:         loc_lSucesso = .F.
410: 
411:         *-- Guarda de precondicao ANTES do TRY, para o RETURN nao ficar
412:         *-- dentro de TRY/CATCH (regra #1)
413:         IF !THIS.ValidarParametros()
414:             RETURN .F.
415:         ENDIF
416: 
417:         TRY
418:             *-- Business Object das Fases 1-2
419:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpSqnBO")
420: 
421:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
422:                 MsgErro("Falha ao criar SigOpSqnBO.", "Opera" + CHR(231) + CHR(245) + "es do Caixa")
423:             ELSE
424:                 *-- Legado: .ParentForm.Enabled = .f. + leitura de
425:                 *-- pcEscolha/Dopes do pai para o BO
426:                 THIS.CarregarContextoFormPai()
427: 
428:                 *-- Legado: .Caption = 'Operacoes do Caixa : ' +
429:                 *-- AllTrim(Proper(crSigCdOpe.Dopes))
430:                 THIS.Caption = "Opera" + CHR(231) + CHR(245) + "es do Caixa : " + ;
431:                     ALLTRIM(PROPER(THIS.this_cOperacaoPai))
432: 
433:                 *-- Fundo do form (Picture do SCX)
434:                 THIS.ConfigurarDecoracao()
435: 
436:                 *-- Legado: .Top/.Left calculados a partir da grade do pai
437:                 THIS.ConfigurarPosicionamento()
438: 
439:                 *-- Cabecalho cinza (cntSombra do legado). PRIMEIRO
440:                 *-- AddObject do form: os botoes ficam dentro da faixa do
441:                 *-- topo e precisam ser criados depois para desenhar por
442:                 *-- cima (regra #11)
443:                 THIS.ConfigurarPageFrame()
444: 
445:                 *-- Fase 4: grade (GradeSubN) e os botoes Inserir/Excluir/
446:                 *-- Encerrar + o Shape separador. Top = 3..103 (botoes) cai
447:                 *-- DENTRO da area do cabecalho (Top = 0..80), por isso vem
448:                 *-- DEPOIS dele - para desenhar por cima (regra #11)
449:                 THIS.ConfigurarGrade()
450:                 THIS.ConfigurarBotoes()
451: 
452:                 *-- AddObject cria controle com Visible = .F.
453:                 THIS.TornarControlesVisiveis(THIS)
454: 
455:                 *-- Legado (Init): .cmdInserir/.cmdExcluir .Visible/.Enabled
456:                 *-- por fChecaAcesso + pcEscolha, e o shape1 redimensionado
457:                 *-- em volta dos botoes que sobraram visiveis.
458:                 *-- OBRIGATORIAMENTE depois do TornarControlesVisiveis, que
459:                 *-- forca Visible = .T. em TODO controle e apagaria o
460:                 *-- Visible = .F. decidido aqui
461:                 THIS.AplicarVisibilidadeBotoes()
462: 
463:                 *-- Fase 7: Click dos tres botoes do legado (AddObject cria
464:                 *-- botao SEM codigo de evento - sem BINDEVENT o Click nunca
465:                 *-- dispara)
466:                 THIS.ConfigurarBINDEVENTs()
467: 
468:                 *-- Legado (Init): "TmpOper" (universo do lookup da
469:                 *-- Column1) - carregado UMA VEZ, igual ao legado, antes
470:                 *-- do usuario poder editar a grade. Pulado em validacao de
471:                 *-- UI (sem gnConnHandle nao ha o que consultar).
472:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
473:                     IF VARTYPE(THIS.this_oBusinessObject) = "O"
474:                         THIS.this_oBusinessObject.ListarOperacoesCupFis()
475:                     ENDIF
476:                 ENDIF
477: 
478:                 *-- Legado (fim do Init): ReQuery('crSigMvCxs') + Go Top +
479:                 *-- bind da GradeSubN + .Refresh. Pulado em validacao de UI
480:                 *-- (sem gnConnHandle nao ha o que consultar) - a ausencia de
481:                 *-- dados nao impede a tela de abrir
482:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
483:                     IF !THIS.CarregarDados()
484:                         *-- Falha ja reportada por CarregarDados/BO
485:                     ENDIF
486:                 ENDIF
487: 
488:                 loc_lSucesso = .T.
489:             ENDIF
490: 
491:         CATCH TO loc_oErro
492:             THIS.this_cMensagemErro = loc_oErro.Message
493:             MsgErro("Erro ao inicializar FormSigOpSqn: " + loc_oErro.Message + ;
494:                     " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
495:                     " | Procedure: " + loc_oErro.Procedure, "Erro")
496:             loc_lSucesso = .F.
497:         ENDTRY
498: 
499:         RETURN loc_lSucesso
500:     ENDPROC
501: 
502:     *==========================================================================
503:     * CarregarContextoFormPai - migra para o BO o que o Init legado le do
504:     * form pai:
505:     *
506:     *     ThisForm.ParentForm = poForm
507:     *     ThisForm.ParentForm.Enabled = .f.
508:     *     <crSigCdOpe.Dopes, Thisform.PcEscolha>   (ja recebidos via par?metro
509:     *                                                no Init deste form - ver
510:     *                                                cabecalho do arquivo)
511:     *
512:     * Cada leitura/escrita eh protegida por PEMSTATUS/VARTYPE: em modo
513:     * teste (gb_4c_ModoTeste/gb_4c_ValidandoUI) o form pai pode ser .NULL.
514:     * ou um stub sem essas properties, e a ausencia aqui NAO eh falha de
515:     * inicializacao (ValidarParametros ja fez o bypass acima).
516:     *==========================================================================
517:     PROTECTED PROCEDURE CarregarContextoFormPai
518:         IF VARTYPE(THIS.this_oFormPai) = "O"
519:             *-- Legado: .ParentForm.Enabled = .f. (reabilitado no Destroy -
520:             *-- rede de seguranca; no legado isso esta no cmdSair.Click)
521:             IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
522:                 THIS.this_oFormPai.Enabled = .F.
523:             ENDIF
524:         ENDIF
525: 
526:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
527:             WITH THIS.this_oBusinessObject
528:                 .this_cEscolha        = THIS.this_cEscolha
529:                 .this_nDataSessionPai = THIS.this_nDataSessionPai
530: 
531:                 *-- cdopes (FK da operacao-pai) ja conhecido desde a
532:                 *-- abertura do dialogo - serve de default para as linhas
533:                 *-- que o usuario inserir na grade (CmdInserirClick)
534:                 .this_cCDopes = THIS.this_cOperacaoPai
535:             ENDWITH
536:         ENDIF
537:     ENDPROC
538: 
539:     *==========================================================================
540:     * ConfigurarDecoracao - Picture do form (new_background.jpg do legado)
541:     *==========================================================================
542:     PROTECTED PROCEDURE ConfigurarDecoracao
543:         LOCAL loc_cImagemFundo
544:         loc_cImagemFundo = ""
545: 
546:         IF TYPE("gc_4c_CaminhoIcones") = "C"
547:             loc_cImagemFundo = gc_4c_CaminhoIcones + "new_background.jpg"
548:         ENDIF
549: 
550:         IF !EMPTY(loc_cImagemFundo) AND FILE(loc_cImagemFundo)
551:             THIS.Picture = loc_cImagemFundo
552:         ENDIF
553:     ENDPROC
554: 
555:     *==========================================================================
556:     * ConfigurarPosicionamento - reproduz o calculo de .Top/.Left do Init
557:     * legado, que ancora este dialogo ao lado da grade do form pai:
558:     *
559:     *   .Top  = ParentForm.Top + ParentForm.Pagina.Lista.Grade.Top + 50
560:     *   .Left = ParentForm.Left + ParentForm.Pagina.Lista.Grade.Left +
561:     *           ParentForm.Pagina.Lista.Grade.Columns(1).Width +
562:     *           ParentForm.Pagina.Lista.Grade.Columns(3).Width + 16
563:     *
564:     * No migrado, o form pai (FormSigCdOpe, CRUD) usa pgf_4c_Paginas.Page1.
565:     * grd_4c_Dados no lugar de Pagina.Lista.Grade. Guardas PEMSTATUS/
566:     * VARTYPE cobrem gb_4c_ModoTeste/gb_4c_ValidandoUI e o fato do form pai
567:     * ainda nao existir/nao ter essa estrutura - sem elas, nao haveria como
568:     * instanciar este dialogo isoladamente para teste.
569:     *==========================================================================
570:     PROTECTED PROCEDURE ConfigurarPosicionamento
571:         LOCAL loc_oGrade
572: 
573:         IF VARTYPE(THIS.this_oFormPai) != "O"
574:             RETURN
575:         ENDIF
576: 
577:         IF !PEMSTATUS(THIS.this_oFormPai, "pgf_4c_Paginas", 5)
578:             RETURN
579:         ENDIF
580: 
581:         IF VARTYPE(THIS.this_oFormPai.pgf_4c_Paginas) != "O" OR ;
582:            !PEMSTATUS(THIS.this_oFormPai.pgf_4c_Paginas, "Page1", 5)
583:             RETURN
584:         ENDIF
585: 
586:         IF VARTYPE(THIS.this_oFormPai.pgf_4c_Paginas.Page1) != "O" OR ;
587:            !PEMSTATUS(THIS.this_oFormPai.pgf_4c_Paginas.Page1, "grd_4c_Dados", 5)
588:             RETURN
589:         ENDIF
590: 
591:         loc_oGrade = THIS.this_oFormPai.pgf_4c_Paginas.Page1.grd_4c_Dados
592: 
593:         IF VARTYPE(loc_oGrade) != "O"
594:             RETURN
595:         ENDIF
596: 
597:         THIS.Top = THIS.this_oFormPai.Top + loc_oGrade.Top + 50
598: 
599:         IF loc_oGrade.ColumnCount >= 3
600:             THIS.Left = THIS.this_oFormPai.Left + loc_oGrade.Left + ;
601:                         loc_oGrade.Columns(1).Width + loc_oGrade.Columns(3).Width + 16
602:         ELSE
603:             *-- Grade com menos de 3 colunas (layout divergente do esperado)
604:             *-- - aproximacao segura, so para o dialogo nao abrir fora da
605:             *-- area visivel
606:             THIS.Left = THIS.this_oFormPai.Left + loc_oGrade.Left + 50
607:         ENDIF
608:     ENDPROC
609: 
610:     *==========================================================================

*-- Linhas 640 a 683:
640:     * AutoSize DESCARTA a Height e colapsa o texto para uma linha (regra
641:     * #23), e os 40/46 do dump sao o tamanho ja calculado pelo Form Designer.
642:     *==========================================================================
643:     PROTECTED PROCEDURE ConfigurarPageFrame
644:         *-- Container da faixa (cntSombra)
645:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
646:         WITH THIS.cnt_4c_Cabecalho
647:             .Top           = 0
648:             .Left          = 0
649:             .Width         = THIS.Width
650:             .Height        = 80
651:             .BorderWidth   = 0
652:             .BackStyle     = 1
653:             .BackColor     = RGB(100, 100, 100)
654:             .SpecialEffect = 0
655:             .Visible       = .T.
656:         ENDWITH
657: 
658:         *-- lblSombra: copia preta deslocada 1px, para dar profundidade ao
659:         *-- titulo. Criada ANTES do lblTitulo para ficar por baixo dele
660:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
661:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
662:             .AutoSize      = .F.
663:             .FontBold      = .T.
664:             .FontName      = "Tahoma"
665:             .FontSize      = 18
666:             .FontUnderline = .F.
667:             .WordWrap      = .T.
668:             .Alignment     = 0
669:             .BackStyle     = 0
670:             .Caption       = THIS.Caption
671:             .Top           = 18
672:             .Left          = 10
673:             .Width         = THIS.Width - 20
674:             .Height        = 40
675:             .ForeColor     = RGB(0, 0, 0)
676:             .Rotation      = 0
677:             .Visible       = .T.
678:         ENDWITH
679: 
680:         *-- lblTitulo: titulo branco sobre a faixa cinza. Branco eh correto
681:         *-- aqui porque o container eh OPACO e escuro (excecao prevista na
682:         *-- regra #12)
683:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")

*-- Linhas 702 a 722:
702: 
703:         THIS.cnt_4c_Cabecalho.Visible = .T.
704:     ENDPROC
705: 
706:     *==========================================================================
707:     * ConfigurarGrade - GradeSubN do legado -> grd_4c_Dados
708:     *
709:     * Transcricao do dump (SIGOPSQN_form_codigo_fonte.txt):
710:     *   GradeSubN  Top=110 Left=147 Width=206 Height=221 ColumnCount=2
711:     *              FontName="Tahoma" FontSize=8 DeleteMark=.F. RowHeight=16
712:     *              ScrollBars=2 TabIndex=1 GridLineColor=238,238,238
713:     *   Column1    FontName="Tahoma" FontSize=8 Width=150 Movable=.F.
714:     *              Resizable=.F.  (ControlSource="" - override VAZIO do Form
715:     *              Designer, o bind real eh feito no Init: 'crSigMvCxs.
716:     *              cNivels' -> ver VincularGrade)
717:     *   Column1.Header1  Alignment=2 Caption="Operacao"
718:     *   Column1.Text1    BorderStyle=0 Margin=0 ForeColor=0,0,0
719:     *                    BackColor=255,255,255
720:     *   Column2    FontName="Tahoma" FontSize=8 Width=25 Movable=.F.
721:     *              InputMask="9"
722:     *   Column2.Header1  Alignment=2 Caption="Seq"

*-- Linhas 740 a 838:
740:     *
741:     * Fase 6: as DUAS colunas instalam TextBox subclasse (Column.AddObject
742:     * + CurrentControl + Sparse = .F. - regra #18) no lugar do Text1 cru,
743:     * porque BINDEVENT em evento de celula de Grid nao eh confiavel (regra
744:     * #46) - os eventos When/Valid/LostFocus moram na classe
745:     * (TextBoxNivelSqn_4c/TextBoxSeqSqn_4c, em classes\
746:     * textboxgridlookup.PRG) e delegam para os metodos PUBLIC do form.
747:     *==========================================================================
748:     PROTECTED PROCEDURE ConfigurarGrade
749:         THIS.AddObject("grd_4c_Dados", "Grid")
750: 
751:         WITH THIS.grd_4c_Dados
752:             .Top           = 110
753:             .Left          = 147
754:             .Width         = 206
755:             .Height        = 221
756:             .FontName      = "Tahoma"
757:             .FontSize      = 8
758:             .DeleteMark    = .F.
759:             .RecordMark    = .F.
760:             .RowHeight     = 16
761:             .ScrollBars    = 2
762:             .TabIndex      = 1
763:             .GridLineColor = RGB(238, 238, 238)
764:             .ColumnCount   = 2
765:             .Visible       = .T.
766:         ENDWITH
767: 
768:         *-- Column1 - cnivels (operacao que compoe a sequencia). Celula com
769:         *-- lookup (When/Valid/LostFocus) - regra #18/#46
770:         THIS.grd_4c_Dados.Column1.AddObject("txt_4c_Nivel", "TextBoxNivelSqn_4c")
771:         WITH THIS.grd_4c_Dados.Column1
772:             .FontName       = "Tahoma"
773:             .FontSize       = 8
774:             .Width          = 150
775:             .Movable        = .F.
776:             .Resizable      = .F.
777:             .CurrentControl = "txt_4c_Nivel"
778:             .Sparse         = .F.
779:             .Header1.FontName  = "Tahoma"
780:             .Header1.FontSize  = 8
781:             .Header1.Alignment = 2
782:             .Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
783:             .txt_4c_Nivel.FontName    = "Tahoma"
784:             .txt_4c_Nivel.FontSize    = 8
785:             .txt_4c_Nivel.BorderStyle = 0
786:             .txt_4c_Nivel.Margin      = 0
787:             *-- MaxLength pela largura da COLUNA no schema (SigMvCxs.cnivels
788:             *-- char(20)), NUNCA pelo Width em pixels (regra #19)
789:             .txt_4c_Nivel.MaxLength   = 20
790:             .txt_4c_Nivel.ForeColor   = RGB(0, 0, 0)
791:             .txt_4c_Nivel.BackColor   = RGB(255, 255, 255)
792:             .txt_4c_Nivel.Visible     = .T.
793:         ENDWITH
794: 
795:         *-- Column2 - seqs (ordem de execucao, 1 a 8). Celula com validacao
796:         *-- de faixa (When/Valid) - regra #18/#46
797:         THIS.grd_4c_Dados.Column2.AddObject("txt_4c_Seq", "TextBoxSeqSqn_4c")
798:         WITH THIS.grd_4c_Dados.Column2
799:             .FontName       = "Tahoma"
800:             .FontSize       = 8
801:             .Width          = 25
802:             .Movable        = .F.
803:             .InputMask      = "9"
804:             .CurrentControl = "txt_4c_Seq"
805:             .Sparse         = .F.
806:             .Header1.FontName  = "Tahoma"
807:             .Header1.FontSize  = 8
808:             .Header1.Alignment = 2
809:             .Header1.Caption   = "Seq"
810:             .txt_4c_Seq.FontName    = "Tahoma"
811:             .txt_4c_Seq.FontSize    = 8
812:             .txt_4c_Seq.BorderStyle = 0
813:             .txt_4c_Seq.InputMask   = "9"
814:             .txt_4c_Seq.Margin      = 0
815:             .txt_4c_Seq.MaxLength   = 1
816:             .txt_4c_Seq.ForeColor   = RGB(0, 0, 0)
817:             .txt_4c_Seq.BackColor   = RGB(255, 255, 255)
818:             .txt_4c_Seq.Visible     = .T.
819:         ENDWITH
820: 
821:         *-- ReadOnly das colunas DEPOIS do Grid (regra #46)
822:         THIS.grd_4c_Dados.Column1.ReadOnly = .F.
823:         THIS.grd_4c_Dados.Column2.ReadOnly = .F.
824:     ENDPROC
825: 
826:     *==========================================================================
827:     * ConfigurarBotoes - shp_4c_Separador (Shape1) + os 3 botoes do legado
828:     *
829:     * Transcricao do dump. Os tres botoes sao da classe legado fwbtng
830:     * (framework.vcx), que define Height=100 / Width=80 / FontBold=.T. /
831:     * FontItalic=.T. / FontName="Comic Sans MS" / FontSize=8 / WordWrap=.T. /
832:     * MousePointer=15 / ForeColor=90,90,90 / BackColor=255,255,255 - o SCX
833:     * sobrepoe apenas Top/Left/Picture/Caption/TabIndex (e Cancel no Sair):
834:     *   cmdInserir  Top=3 Left=390 Caption="Inserir"  TabIndex=9
835:     *               Picture=cadastro_inserir_60.jpg
836:     *   cmdExcluir  Top=3 Left=465 Caption="Excluir"  TabIndex=7
837:     *               Picture=cadastro_excluir_60.jpg
838:     *   cmdSair     Top=3 Left=540 Caption="Encerrar" TabIndex=8 Cancel=.T.

*-- Linhas 863 a 906:
863:     * ausente ja falha em silencio) e so esconde o erro (regra #25). Os tres
864:     * arquivos estao conferidos em vbmp\.
865:     *==========================================================================
866:     PROTECTED PROCEDURE ConfigurarBotoes
867:         LOCAL loc_cIcones
868: 
869:         *-- gc_4c_CaminhoIcones pode nao existir em probe/harness sem
870:         *-- config.prg - referenciar a variavel ausente mataria o Init
871:         loc_cIcones = IIF(TYPE("gc_4c_CaminhoIcones") = "C", gc_4c_CaminhoIcones, "")
872: 
873:         *-- Shape1 do legado - moldura em volta do bloco de botoes
874:         THIS.AddObject("shp_4c_Separador", "Shape")
875:         WITH THIS.shp_4c_Separador
876:             .Top         = 12
877:             .Left        = 80
878:             .Height      = 110
879:             .Width       = 257
880:             .BackStyle   = 0
881:             .BorderStyle = 0
882:             .BorderColor = RGB(136, 189, 188)
883:             .Visible     = .T.
884:         ENDWITH
885: 
886:         *-- cmdInserir
887:         THIS.AddObject("cmd_4c_Inserir", "CommandButton")
888:         WITH THIS.cmd_4c_Inserir
889:             .Top             = 3
890:             .Left            = 390
891:             .Width           = 80
892:             .Height          = 100
893:             .FontBold        = .T.
894:             .FontItalic      = .T.
895:             .FontName        = "Comic Sans MS"
896:             .FontSize        = 8
897:             .WordWrap        = .T.
898:             .MousePointer    = 15
899:             .ForeColor       = RGB(90, 90, 90)
900:             .BackColor       = RGB(255, 255, 255)
901:             .Themes          = .T.
902:             .TabIndex        = 9
903:             .Caption         = "Inserir"
904:             .Picture         = loc_cIcones + "cadastro_inserir_60.jpg"
905:             .DisabledPicture = loc_cIcones + "cadastro_inserir_60.jpg"
906:             .Visible         = .T.

*-- Linhas 979 a 1110:
979:     *
980:     * cmd_4c_Sair NUNCA eh escondido: ele eh a unica saida da tela.
981:     *==========================================================================
982:     PROTECTED PROCEDURE AplicarVisibilidadeBotoes
983:         LOCAL loc_lModoEdicao, loc_lInserir, loc_lExcluir
984: 
985:         loc_lModoEdicao = EMPTY(THIS.this_cEscolha) OR ;
986:             INLIST(UPPER(ALLTRIM(THIS.this_cEscolha)), "INSERIR", "ALTERAR")
987: 
988:         loc_lInserir = THIS.PossuiAcessoOperacao("INSERIR") AND loc_lModoEdicao
989:         loc_lExcluir = THIS.PossuiAcessoOperacao("EXCLUIR") AND loc_lModoEdicao
990: 
991:         THIS.cmd_4c_Inserir.Visible = loc_lInserir
992:         THIS.cmd_4c_Inserir.Enabled = loc_lInserir
993:         THIS.cmd_4c_Excluir.Visible = loc_lExcluir
994:         THIS.cmd_4c_Excluir.Enabled = loc_lExcluir
995: 
996:         DO CASE
997:         CASE THIS.cmd_4c_Inserir.Visible
998:             THIS.shp_4c_Separador.Left  = THIS.cmd_4c_Inserir.Left - 5
999:             THIS.shp_4c_Separador.Width = 3 * THIS.cmd_4c_Sair.Width + 16
1000:         CASE THIS.cmd_4c_Excluir.Visible
1001:             THIS.shp_4c_Separador.Left  = THIS.cmd_4c_Excluir.Left - 5
1002:             THIS.shp_4c_Separador.Width = 2 * THIS.cmd_4c_Sair.Width + 16
1003:         OTHERWISE
1004:             THIS.shp_4c_Separador.Left  = THIS.cmd_4c_Sair.Left - 5
1005:             THIS.shp_4c_Separador.Width = 1 * THIS.cmd_4c_Sair.Width + 16
1006:         ENDCASE
1007:     ENDPROC
1008: 
1009:     *==========================================================================
1010:     * PossuiAcessoOperacao - fChecaAcesso('SigOpSqn', <acao>) do legado
1011:     *
1012:     * fChecaAcesso eh a funcao ORIGINAL do Framework Fortyus (Framework\
1013:     * sigacess.PRG, carregada pelo config.prg) - NAO reimplementar a consulta
1014:     * aqui: o modelo de acesso (SigCdAcu/SigCdAcg) concede permissao por
1015:     * usuario E por grupo, e trata o usuario interno com acesso total. A
1016:     * chamada com 2 argumentos eh FIEL ao legado: os parametros restantes
1017:     * (pMsg/pUsu/pTot) tem fallback proprio dentro da funcao.
1018:     *
1019:     * Bypass em modo teste / validacao de UI no TOPO: fChecaAcesso abre
1020:     * conexao e consulta o banco, e sem SQL Server ela trava o harness
1021:     * DENTRO do CREATEOBJECT do form.
1022:     *
1023:     * Os RETURN ficam fora de TRY/CATCH (regra #1).
1024:     *==========================================================================
1025:     PROTECTED FUNCTION PossuiAcessoOperacao(par_cOperacao)
1026:         LOCAL loc_lAcesso, loc_oErro
1027:         loc_lAcesso = .F.
1028: 
1029:         IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
1030:             RETURN .T.
1031:         ENDIF
1032: 
1033:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1034:             RETURN .T.
1035:         ENDIF
1036: 
1037:         TRY
1038:             loc_lAcesso = fChecaAcesso("SigOpSqn", par_cOperacao)
1039:         CATCH TO loc_oErro
1040:             MsgErro("Erro ao verificar o acesso " + CHR(224) + " opera" + ;
1041:                 CHR(231) + CHR(227) + "o " + ALLTRIM(par_cOperacao) + ":" + CHR(13) + ;
1042:                 loc_oErro.Message, "Opera" + CHR(231) + CHR(245) + "es do Caixa")
1043:         ENDTRY
1044: 
1045:         RETURN loc_lAcesso
1046:     ENDFUNC
1047: 
1048:     *==========================================================================
1049:     * VincularGrade - liga grd_4c_Dados ao cursor de sequencias, transcrevendo
1050:     * o bloco final do Init legado:
1051:     *
1052:     *   With Thisform.GradeSubN
1053:     *       .RecordSource          = 'crSigMvCxs'
1054:     *       .Column1.ControlSource = 'crSigMvCxs.cNivels'
1055:     *       .Column2.ControlSource = 'crSigMvCxs.Seqs'
1056:     *       .Refresh
1057:     *   EndWith
1058:     *
1059:     * O alias eh o literal cursor_4c_Sequencias (valor de SigOpSqnBO.
1060:     * this_cCursorSequencias) - INTO CURSOR do BO e RecordSource daqui
1061:     * precisam casar, e um nome fixo nos dois lados nao tem como divergir.
1062:     *
1063:     * Width / Header1.Caption / Header1.Alignment / ReadOnly / CurrentControl
1064:     * / Sparse sao REAPLICADOS depois do bind: atribuir RecordSource/
1065:     * ControlSource reseta a largura das colunas para o default 90 e o
1066:     * cabecalho para "Column1"/"Column2" (Problema 48 / regra #41). Por isso
1067:     * este bloco repete os valores de ConfigurarGrade em vez de so
1068:     * configura-los la.
1069:     *==========================================================================
1070:     PROTECTED PROCEDURE VincularGrade
1071:         IF !USED("cursor_4c_Sequencias")
1072:             RETURN .F.
1073:         ENDIF
1074: 
1075:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
1076:             RETURN .F.
1077:         ENDIF
1078: 
1079:         WITH THIS.grd_4c_Dados
1080:             .RecordSource          = ""
1081:             .RecordSource          = "cursor_4c_Sequencias"
1082:             .Column1.ControlSource = "cursor_4c_Sequencias.cnivels"
1083:             .Column2.ControlSource = "cursor_4c_Sequencias.seqs"
1084: 
1085:             *-- Reaplicar o que o rebind acabou de resetar
1086:             .Column1.Width = 150
1087:             .Column2.Width = 25
1088: 
1089:             .Column1.Header1.Alignment = 2
1090:             .Column2.Header1.Alignment = 2
1091:             .Column1.Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
1092:             .Column2.Header1.Caption   = "Seq"
1093: 
1094:             .Column1.CurrentControl = "txt_4c_Nivel"
1095:             .Column2.CurrentControl = "txt_4c_Seq"
1096:             .Column1.Sparse         = .F.
1097:             .Column2.Sparse         = .F.
1098: 
1099:             .Column1.ReadOnly = .F.
1100:             .Column2.ReadOnly = .F.
1101:         ENDWITH
1102: 
1103:         RETURN .T.
1104:     ENDPROC
1105: 
1106:     *==========================================================================
1107:     * CarregarDados - funil UNICO de carga da grade
1108:     *
1109:     * Equivale ao bloco do Init legado que requeria o cursor do pai e religa
1110:     * a grade:

*-- Linhas 1127 a 1618:
1127:     * falha; a tela continua abrindo (grade vazia), e a falha de SQL ja foi
1128:     * reportada por ListarSequencias.
1129:     *==========================================================================
1130:     PROCEDURE CarregarDados
1131:         LOCAL loc_lSucesso, loc_oErro
1132:         loc_lSucesso = .F.
1133: 
1134:         *-- Carga eh o ponto de partida da sessao de edicao: o estado de
1135:         *-- alteracao/inclusao/exclusao (lhouvealt/lhouveins/lhouveexcl do
1136:         *-- legado) volta ao zero junto com os dados
1137:         THIS.this_lHouveAlteracao = .F.
1138:         THIS.this_lHouveInclusao  = .F.
1139:         THIS.this_lHouveExclusao  = .F.
1140: 
1141:         *-- A lista de linhas novas pertence a MESMA sessao de edicao: recarregar
1142:         *-- descarta as linhas que o Inserir criou e ainda nao foram gravadas
1143:         THIS.this_cCidChavesNovas = ""
1144: 
1145:         TRY
1146:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1147:                 IF THIS.this_oBusinessObject.ListarSequencias(THIS.this_cOperacaoPai)
1148:                     THIS.VincularGrade()
1149: 
1150:                     *-- Legado: Select crSigMvCxs / Goto Top
1151:                     IF USED("cursor_4c_Sequencias")
1152:                         SELECT cursor_4c_Sequencias
1153:                         GO TOP
1154:                     ENDIF
1155: 
1156:                     *-- Legado: Thisform.GradeSubN.Refresh
1157:                     IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1158:                         THIS.grd_4c_Dados.Refresh()
1159:                     ENDIF
1160: 
1161:                     loc_lSucesso = .T.
1162:                 ENDIF
1163:             ENDIF
1164:         CATCH TO loc_oErro
1165:             MsgErro("Erro ao carregar as sequ" + CHR(234) + "ncias da opera" + ;
1166:                 CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
1167:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1168:                 "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDados")
1169:         ENDTRY
1170: 
1171:         RETURN loc_lSucesso
1172:     ENDPROC
1173: 
1174:     *==========================================================================
1175:     * GuardarValorAnteriorNivel - When do Column1.Text1 legado:
1176:     *   ThisForm.antvalue = This.Value
1177:     *
1178:     * Chamado pela celula (TextBoxNivelSqn_4c.When, em
1179:     * classes\textboxgridlookup.PRG) ANTES do usuario editar a celula -
1180:     * snapshot usado pelo Valid para saber se o valor mudou.
1181:     *
1182:     * Metodo PUBLIC (regra #3/#46): a celula o alcanca via THISFORM a partir
1183:     * de outra classe - PROTECTED faria a chamada estourar em runtime.
1184:     *==========================================================================
1185:     PROCEDURE GuardarValorAnteriorNivel(par_oTxt)
1186:         THIS.this_cValorAnteriorNivel = par_oTxt.Value
1187:     ENDPROC
1188: 
1189:     *==========================================================================
1190:     * ValidarNivelGradeExec - Valid do Column1.Text1 legado:
1191:     *
1192:     *   Local lcOperacao, lnRecNo, loBrowse
1193:     *   If This.Value <> ThisForm.Antvalue
1194:     *       If Not Empty(This.Value)
1195:     *           If Not Seek(This.Value, 'TmpOper', 'Dopes')
1196:     *               loBrowse = CreateObject('fwBuscaSel', 'TmpOper', 'Dopes', ;
1197:     *                   This.Value, 'Cadastro de Operacoes')
1198:     *               loBrowse.AddColuna('Dopes', '', 'Operacao', .t., 'Dopes')
1199:     *               loBrowse.Show
1200:     *               This.Value = TmpOper.Dopes
1201:     *           EndIf
1202:     *       EndIf
1203:     *       ThisForm.lhouveAlt = .t.
1204:     *   Endif
1205:     *
1206:     * cursor_4c_Operacoes (TmpOper) eh o universo carregado 1x por
1207:     * SigOpSqnBO.ListarOperacoesCupFis, indexado em dopes (ver o BO) - o
1208:     * SEEK eh a transcricao direta do Seek(This.Value, 'TmpOper', 'Dopes')
1209:     * do legado. Nao achando, abre o picker (AbrirLookupOperacaoSqn), que
1210:     * segue o contrato this_lAchouRegistro/this_lSelecionou do
1211:     * FormBuscaAuxiliar (regra #37).
1212:     *
1213:     * Dentro do Valid o valor digitado esta em par_oTxt.Value (o cursor da
1214:     * grade so recebe DEPOIS) - regra #46.
1215:     *
1216:     * Metodo PUBLIC (regra #3/#46).
1217:     *==========================================================================
1218:     PROCEDURE ValidarNivelGradeExec(par_oTxt)
1219:         LOCAL loc_cValor, loc_lAchou
1220: 
1221:         loc_cValor = ALLTRIM(NVL(par_oTxt.Value, ""))
1222: 
1223:         IF loc_cValor != ALLTRIM(NVL(THIS.this_cValorAnteriorNivel, ""))
1224:             IF !EMPTY(loc_cValor)
1225:                 loc_lAchou = .F.
1226: 
1227:                 IF USED("cursor_4c_Operacoes")
1228:                     loc_lAchou = SEEK(loc_cValor, "cursor_4c_Operacoes", "dopes")
1229:                 ENDIF
1230: 
1231:                 IF !loc_lAchou
1232:                     THIS.AbrirLookupOperacaoSqn(par_oTxt)
1233:                 ENDIF
1234:             ENDIF
1235: 
1236:             THIS.this_lHouveAlteracao = .T.
1237:         ENDIF
1238: 
1239:         RETURN .T.
1240:     ENDPROC
1241: 
1242:     *==========================================================================
1243:     * AbrirLookupOperacaoSqn - fwBuscaSel do legado contra TmpOper, migrado
1244:     * para o picker canonico do projeto (FormBuscaAuxiliar), filtrado pelo
1245:     * MESMO universo (CupFis IN (1,3)) ja carregado em cursor_4c_Operacoes.
1246:     *
1247:     * SigCdOpe eh single-column (regra do pipeline): mAddColuna usa so
1248:     * "dopes", igual ao legado (loBrowse.AddColuna('Dopes', '', 'Operacao')).
1249:     *
1250:     * Contrato this_lAchouRegistro/this_lSelecionou (regra #37): o Init do
1251:     * FormBuscaAuxiliar ja tenta o match exato e, achando 1, resolve sozinho
1252:     * sem abrir o Show(). Valor atribuido SO dentro da guarda
1253:     * this_lSelecionou - sem selecao, o campo fica vazio (equivalente ao
1254:     * legado atribuir This.Value = TmpOper.Dopes so apos o Show do browse).
1255:     *
1256:     * Metodo PUBLIC (regra #3/#46).
1257:     *==========================================================================
1258:     PROCEDURE AbrirLookupOperacaoSqn(par_oTxt)
1259:         LOCAL loc_cValor, loc_oBusca
1260: 
1261:         loc_cValor = ALLTRIM(NVL(par_oTxt.Value, ""))
1262: 
1263:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1264:             "SigCdOpe", "cursor_4c_BuscaOperacaoSqn", "dopes", loc_cValor, ;
1265:             "Opera" + CHR(231) + CHR(245) + "es do Caixa", .F., .T., ;
1266:             "cupfis IN (1, 3)")
1267: 
1268:         IF VARTYPE(loc_oBusca) = "O"
1269:             IF !loc_oBusca.this_lAchouRegistro
1270:                 loc_oBusca.mAddColuna("dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
1271:                 loc_oBusca.Show()
1272:             ENDIF
1273: 
1274:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOperacaoSqn")
1275:                 par_oTxt.Value = ALLTRIM(cursor_4c_BuscaOperacaoSqn.dopes)
1276:             ELSE
1277:                 par_oTxt.Value = ""
1278:             ENDIF
1279: 
1280:             loc_oBusca.Release()
1281:         ENDIF
1282: 
1283:         IF USED("cursor_4c_BuscaOperacaoSqn")
1284:             USE IN cursor_4c_BuscaOperacaoSqn
1285:         ENDIF
1286:     ENDPROC
1287: 
1288:     *==========================================================================
1289:     * NivelGradeLostFocus - LostFocus do Column1.Text1 legado:
1290:     *   If IsEmpty(This.Value)
1291:     *       Thisform.cmdSair.SetFocus
1292:     *   EndIf
1293:     *
1294:     * Metodo PUBLIC (regra #3/#46).
1295:     *==========================================================================
1296:     PROCEDURE NivelGradeLostFocus(par_oTxt)
1297:         IF EMPTY(NVL(par_oTxt.Value, "")) AND PEMSTATUS(THIS, "cmd_4c_Sair", 5)
1298:             THIS.cmd_4c_Sair.SetFocus()
1299:         ENDIF
1300:     ENDPROC
1301: 
1302:     *==========================================================================
1303:     * GuardarValorAnteriorSeq - When do Column2.Text1 legado:
1304:     *   ThisForm.AntValue2 = This.Value
1305:     *
1306:     * Metodo PUBLIC (regra #3/#46).
1307:     *==========================================================================
1308:     PROCEDURE GuardarValorAnteriorSeq(par_oTxt)
1309:         THIS.this_nValorAnteriorSeq = par_oTxt.Value
1310:     ENDPROC
1311: 
1312:     *==========================================================================
1313:     * ValidarSeqGradeExec - Valid do Column2.Text1 legado:
1314:     *
1315:     *   If This.Value <> ThisForm.Antvalue2
1316:     *       If Not Between(This.Value,1,8)
1317:     *           MessageBox('Informe Sequencia entre 1 - 8',0+64,'')
1318:     *           Return .f.
1319:     *       EndIf
1320:     *       ThisForm.lhouveAlt = .t.
1321:     *   Endif
1322:     *
1323:     * MESSAGEBOX legado -> MsgAviso (projeto proibe MESSAGEBOX direto).
1324:     * RETURN .F. mantem o foco na celula, igual ao "Return .f." do legado.
1325:     *
1326:     * Metodo PUBLIC (regra #3/#46).
1327:     *==========================================================================
1328:     PROCEDURE ValidarSeqGradeExec(par_oTxt)
1329:         IF par_oTxt.Value != THIS.this_nValorAnteriorSeq
1330:             IF !BETWEEN(par_oTxt.Value, 1, 8)
1331:                 MsgAviso("Informe Sequ" + CHR(234) + "ncia entre 1 - 8", ;
1332:                     "Aten" + CHR(231) + CHR(227) + "o")
1333:                 RETURN .F.
1334:             ENDIF
1335: 
1336:             THIS.this_lHouveAlteracao = .T.
1337:         ENDIF
1338: 
1339:         RETURN .T.
1340:     ENDPROC
1341: 
1342:     *==========================================================================
1343:     * ConfigurarBINDEVENTs - Fase 7: liga o Click dos tres botoes do legado
1344:     * (cmdInserir/cmdExcluir/cmdSair) aos handlers desta fase.
1345:     *
1346:     * Botao criado por AddObject nasce SEM codigo de evento: sem BINDEVENT o
1347:     * Click nunca dispara e o usuario clica sem nada acontecer.
1348:     *
1349:     * Os handlers destino sao PUBLIC (sem PROTECTED) - BINDEVENT falha em
1350:     * SILENCIO com metodo PROTECTED (regra #3).
1351:     *
1352:     * As celulas da grade (Column1/Column2) NAO entram aqui: os eventos
1353:     * When/Valid/LostFocus delas moram na classe do TextBox instalado em
1354:     * ConfigurarGrade (TextBoxNivelSqn_4c/TextBoxSeqSqn_4c), porque
1355:     * BINDEVENT em evento de celula de Grid nao eh confiavel (regra #46).
1356:     *==========================================================================
1357:     PROTECTED PROCEDURE ConfigurarBINDEVENTs
1358:         BINDEVENT(THIS.cmd_4c_Inserir, "Click", THIS, "CmdInserirClick")
1359:         BINDEVENT(THIS.cmd_4c_Excluir, "Click", THIS, "CmdExcluirClick")
1360:         BINDEVENT(THIS.cmd_4c_Sair,    "Click", THIS, "BtnSairClick")
1361:     ENDPROC
1362: 
1363:     *==========================================================================
1364:     * CmdInserirClick - cmdInserir.Click do legado, transcrito:
1365:     *
1366:     *   Thisform.lHouveIns = .T.
1367:     *   Select crSigMvCxs
1368:     *   Locate for cDopes = crSigCdOpe.Dopes .and. cnivels = Space(20)
1369:     *   If Eof()
1370:     *       Insert Into crSigMvCxs (cDopes, CidChaves) ;
1371:     *           Values (crSigCdOpe.Dopes, fUniqueIds())
1372:     *   EndIf
1373:     *   Select crSigMvCxs
1374:     *   Thisform.GradeSubN.Column1.SetFocus
1375:     *
1376:     * O LOCATE eh um GUARD contra linha em branco repetida: se a linha vazia
1377:     * da ultima vez ainda nao foi preenchida, o legado reaproveita ela em vez
1378:     * de criar outra (e o LOCATE deixa o ponteiro nela, que eh onde o foco
1379:     * vai parar).
1380:     *
1381:     * Grava SO no cursor LOCAL - igual ao legado, que trabalha sobre a view
1382:     * bufferizada do pai e so persiste no Encerrar (poDataMgr.UpDate +
1383:     * Commit -> PersistirSequencias). A PK vai ja preenchida com fUniqueIds()
1384:     * (regra #22: cidchaves NUNCA em branco, senao a 2a linha colide no
1385:     * indice unico) e entra em this_cCidChavesNovas, que eh como o funil de
1386:     * gravacao sabe que a linha eh INSERT e nao UPDATE.
1387:     *
1388:     * O "Select crSigMvCxs" final do legado nao precisa ser reproduzido como
1389:     * efeito colateral: a grade exibe pelo RecordSource, e este form roda na
1390:     * DataSession do PAI (DataSession = 1), onde deixar outro alias
1391:     * selecionado atrapalharia quem chamou - por isso o alias anterior eh
1392:     * restaurado.
1393:     *
1394:     * Column1.SetFocus() eh o que o legado chama, e Column TEM esse metodo
1395:     * (medido no VFP9 em 2026-11-17: PEMSTATUS(Column1, "SetFocus", 5) =
1396:     * .T.). NAO usar Grid.ActiveColumn = 1 no lugar: medido na mesma sessao,
1397:     * ActiveColumn eh READ-ONLY em runtime ("Property ACTIVECOLUMN is
1398:     * read-only") e derrubaria o handler.
1399:     *==========================================================================
1400:     PROCEDURE CmdInserirClick
1401:         LOCAL loc_cAliasAnterior, loc_cCidChaves, loc_oErro
1402: 
1403:         TRY
1404:             IF USED("cursor_4c_Sequencias")
1405:                 *-- Legado: Thisform.lHouveIns = .T.
1406:                 THIS.this_lHouveInclusao = .T.
1407: 
1408:                 loc_cAliasAnterior = ALIAS()
1409:                 SELECT cursor_4c_Sequencias
1410: 
1411:                 LOCATE FOR ALLTRIM(cdopes) == ALLTRIM(THIS.this_cOperacaoPai) ;
1412:                     AND EMPTY(cnivels)
1413: 
1414:                 IF !FOUND()
1415:                     loc_cCidChaves = ALLTRIM(fUniqueIds())
1416: 
1417:                     INSERT INTO cursor_4c_Sequencias (cdopes, cidchaves) ;
1418:                         VALUES (THIS.this_cOperacaoPai, loc_cCidChaves)
1419: 
1420:                     THIS.this_cCidChavesNovas = THIS.this_cCidChavesNovas + ;
1421:                         "|" + loc_cCidChaves
1422:                 ENDIF
1423: 
1424:                 IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
1425:                     SELECT (loc_cAliasAnterior)
1426:                 ENDIF
1427: 
1428:                 IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1429:                     THIS.grd_4c_Dados.Refresh()
1430:                     THIS.grd_4c_Dados.Column1.SetFocus()
1431:                 ENDIF
1432:             ENDIF
1433:         CATCH TO loc_oErro
1434:             MsgErro(loc_oErro.Message + CHR(13) + ;
1435:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1436:                     "Procedure: " + loc_oErro.Procedure, ;
1437:                     "Erro em CmdInserirClick")
1438:         ENDTRY
1439:     ENDPROC
1440: 
1441:     *==========================================================================
1442:     * CmdExcluirClick - cmdExcluir.Click do legado, transcrito:
1443:     *
1444:     *   Select crSigMvCxs
1445:     *   If Not Eof() And ( crSigMvCxs.cDopes = crSigCdOpe.Dopes )
1446:     *       Thisform.lHouveExcl = .T.
1447:     *       Delete
1448:     *       Skip
1449:     *       Skip - 1
1450:     *   Endif
1451:     *   Thisform.GradeSubN.Refresh
1452:     *
1453:     * O par "Skip / Skip -1" do legado eh o que reposiciona o ponteiro numa
1454:     * linha VIVA depois da marcacao (com SET DELETED ON - fixado pelo
1455:     * config.prg - a linha marcada desaparece da grade de imediato).
1456:     *
1457:     * So MARCA a linha no cursor LOCAL: o DELETE no SQL Server acontece no
1458:     * Encerrar (PersistirSequencias) e SO para linha que ja existia no banco
1459:     * - linha nova excluida antes de gravar simplesmente desaparece, sem SQL
1460:     * nenhum.
1461:     *==========================================================================
1462:     PROCEDURE CmdExcluirClick
1463:         LOCAL loc_cAliasAnterior, loc_oErro
1464: 
1465:         TRY
1466:             IF USED("cursor_4c_Sequencias")
1467:                 loc_cAliasAnterior = ALIAS()
1468:                 SELECT cursor_4c_Sequencias
1469: 
1470:                 IF !EOF() AND ALLTRIM(cdopes) == ALLTRIM(THIS.this_cOperacaoPai)
1471:                     *-- Legado: Thisform.lHouveExcl = .T.
1472:                     THIS.this_lHouveExclusao = .T.
1473:                     DELETE
1474:                     SKIP
1475:                     SKIP -1
1476:                 ENDIF
1477: 
1478:                 IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
1479:                     SELECT (loc_cAliasAnterior)
1480:                 ENDIF
1481:             ENDIF
1482: 
1483:             *-- Legado: Thisform.GradeSubN.Refresh (fora do IF, como no dump)
1484:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1485:                 THIS.grd_4c_Dados.Refresh()
1486:             ENDIF
1487:         CATCH TO loc_oErro
1488:             MsgErro(loc_oErro.Message + CHR(13) + ;
1489:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1490:                     "Procedure: " + loc_oErro.Procedure, ;
1491:                     "Erro em CmdExcluirClick")
1492:         ENDTRY
1493:     ENDPROC
1494: 
1495:     *==========================================================================
1496:     * BtnSairClick - cmdSair.Click do legado ("Encerrar", Cancel = .T., logo
1497:     * tambem dispara no ESC). Transcrito:
1498:     *
1499:     *   If Thisform.cmdInserir.Visible Or Thisform.cmdExcluir.Visible
1500:     *       If ( Thisform.lHouveExcl Or Thisform.lHouveIns Or ThisForm.lHouveAlt )
1501:     *           Select CrSigMvCxs / Go Top / Go bottom
1502:     *           <validacao 1: cNivels duplicada>  -> MessageBox + Return .f.
1503:     *           <validacao 2: cNivels sem Seqs>   -> MessageBox + Return .f.
1504:     *           <UpDate('crSigMvCxs') + Commit(), com RollBack e MessageBox
1505:     *            'Erro na Gravacao dos Dados do Cadastro de Operacoes.'>
1506:     *       Endif
1507:     *   ENDIF
1508:     *   Thisform.ParentForm.Enabled = .T.
1509:     *   Thisform.mCtrlBotoes(.T.)
1510:     *   ThisForm.Release
1511:     *
1512:     * FLUXO DE SAIDA - transcrito, nao "melhorado": SO as duas validacoes
1513:     * abortam o fechamento (o "Return .f." do legado); a FALHA DE GRAVACAO
1514:     * exibe a mensagem e FECHA do mesmo jeito, porque no legado o RollBack ja
1515:     * desfez tudo. Manter o dialogo aberto nesse caso convidaria a um segundo
1516:     * Encerrar, que tentaria reinserir linha ja gravada (cidchaves eh PK) -
1517:     * ver tambem o acerto de this_cCidChavesNovas em PersistirSequencias.
1518:     *
1519:     * Modo so-leitura (Inserir e Excluir ambos invisiveis - pai em PROCURAR
1520:     * ou usuario sem acesso): o legado NAO valida e NAO grava nada, so fecha.
1521:     *
1522:     * "Go Top / Go bottom" do legado forcava a view remota bufferizada a
1523:     * buscar TODAS as linhas antes do TableUpdate; no cursor local nao muda
1524:     * nada, mas fica transcrito (so reposiciona o ponteiro).
1525:     *
1526:     * "ParentForm.Enabled = .T." roda no Destroy() deste form (chamado pelo
1527:     * Release()). "mCtrlBotoes(.T.)" do legado reabilita BOTOES especificos
1528:     * do pai porque la o pai ficava com os controles desabilitados um a um -
1529:     * aqui o InicializarForm desabilita o FORM PAI INTEIRO, entao reabilitar
1530:     * o form basta e nao ha metodo equivalente a chamar.
1531:     *
1532:     * Metodo PUBLIC (regra #3): alcancado por BINDEVENT e pelo harness.
1533:     *==========================================================================
1534:     PROCEDURE BtnSairClick
1535:         LOCAL loc_lPodeFechar, loc_oErro
1536: 
1537:         loc_lPodeFechar = .T.
1538: 
1539:         TRY
1540:             IF THIS.cmd_4c_Inserir.Visible OR THIS.cmd_4c_Excluir.Visible
1541:                 IF THIS.this_lHouveExclusao OR THIS.this_lHouveInclusao OR ;
1542:                    THIS.this_lHouveAlteracao
1543: 
1544:                     *-- Legado: Select CrSigMvCxs / Go Top / Go bottom
1545:                     IF USED("cursor_4c_Sequencias")
1546:                         SELECT cursor_4c_Sequencias
1547:                         GO TOP
1548:                         GO BOTTOM
1549:                     ENDIF
1550: 
1551:                     DO CASE
1552:                     CASE THIS.ExisteOperacaoDuplicada()
1553:                         MsgAviso("Existem Opera" + CHR(231) + CHR(245) + ;
1554:                             "es Duplicadas!!!", ;
1555:                             "Opera" + CHR(231) + CHR(245) + "es do Caixa")
1556:                         loc_lPodeFechar = .F.
1557: 
1558:                     CASE THIS.ExisteSequenciaNaoInformada()
1559:                         MsgAviso("Existem Opera" + CHR(231) + CHR(245) + ;
1560:                             "es sem Sequ" + CHR(234) + "ncia informada!!!", ;
1561:                             "Opera" + CHR(231) + CHR(245) + "es do Caixa")
1562:                         loc_lPodeFechar = .F.
1563: 
1564:                     OTHERWISE
1565:                         IF !THIS.PersistirSequencias()
1566:                             MsgErro("Erro na grava" + CHR(231) + CHR(227) + ;
1567:                                 "o dos Dados do Cadastro de Opera" + ;
1568:                                 CHR(231) + CHR(245) + "es.", ;
1569:                                 "Opera" + CHR(231) + CHR(245) + "es do Caixa")
1570:                         ENDIF
1571:                     ENDCASE
1572:                 ENDIF
1573:             ENDIF
1574:         CATCH TO loc_oErro
1575:             loc_lPodeFechar = .F.
1576:             MsgErro(loc_oErro.Message + CHR(13) + ;
1577:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1578:                     "Procedure: " + loc_oErro.Procedure, ;
1579:                     "Erro em BtnSairClick")
1580:         ENDTRY
1581: 
1582:         IF loc_lPodeFechar
1583:             THIS.Release()
1584:         ENDIF
1585:     ENDPROC
1586: 
1587:     *==========================================================================
1588:     * ExisteOperacaoDuplicada - 1a validacao do cmdSair.Click legado:
1589:     *
1590:     *   Select cNivels,sum(1) From CrSigMvCxs Into Cursor Selecao ;
1591:     *       Group by cNivels having sum(1) > 1
1592:     *   Select Selecao
1593:     *   If Reccount() > 0 ... 'Existem Operacoes Duplicadas!!!'
1594:     *
1595:     * Transcricao LITERAL (regra #17): o legado NAO exclui a linha em branco
1596:     * do agrupamento, logo DUAS linhas novas sem operacao informada tambem
1597:     * contam como duplicadas - esse eh o comportamento da tela e nao se
1598:     * "conserta" aqui.
1599:     *
1600:     * A linha marcada para exclusao NAO entra: SET DELETED ON (config.prg)
1601:     * esconde do SELECT, igual ao legado.
1602:     *
1603:     * _TALLY no lugar do RECCOUNT() do legado: RECCOUNT conta tambem registro
1604:     * marcado como excluido, e _TALLY eh o numero de linhas que o SELECT
1605:     * acabou de produzir.
1606:     *
1607:     * Os RETURN de guarda ficam FORA de TRY/CATCH (regra #1).
1608:     *==========================================================================
1609:     PROTECTED FUNCTION ExisteOperacaoDuplicada
1610:         LOCAL loc_cAliasAnterior, loc_nQuantas
1611: 
1612:         IF !USED("cursor_4c_Sequencias")
1613:             RETURN .F.
1614:         ENDIF
1615: 
1616:         loc_cAliasAnterior = ALIAS()
1617: 
1618:         IF USED("cursor_4c_SelecaoSqn")

*-- Linhas 1817 a 1925:
1817:     * NovoRegistro() passa por LimparDados() e zeraria o que fosse atribuido
1818:     * antes.
1819:     *
1820:     * PROTECTED PROCEDURE explicito: eh hook de FormBase e nao se chama de
1821:     * fora deste form.
1822:     *==========================================================================
1823:     PROTECTED PROCEDURE FormParaBO
1824:         LOCAL loc_lSucesso
1825:         loc_lSucesso = .F.
1826: 
1827:         IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
1828:            USED("cursor_4c_Sequencias") AND !EOF("cursor_4c_Sequencias")
1829: 
1830:             WITH THIS.this_oBusinessObject
1831:                 .this_cCidChaves = ALLTRIM(NVL(cursor_4c_Sequencias.cidchaves, ""))
1832:                 .this_cCDopes    = ALLTRIM(NVL(cursor_4c_Sequencias.cdopes, ""))
1833:                 .this_cCNivels   = ALLTRIM(NVL(cursor_4c_Sequencias.cnivels, ""))
1834:                 .this_nSeqs      = NVL(cursor_4c_Sequencias.seqs, 0)
1835:             ENDWITH
1836: 
1837:             loc_lSucesso = .T.
1838:         ENDIF
1839: 
1840:         RETURN loc_lSucesso
1841:     ENDPROC
1842: 
1843:     *==========================================================================
1844:     * BOParaForm - transporte BO -> LINHA DA GRADE (Fase 8), o inverso do
1845:     * FormParaBO acima.
1846:     *
1847:     * Tem UM trabalho real: devolver para a linha a chave que FOI DE FATO
1848:     * gravada. SigOpSqnBO.Inserir() gera a PK quando ela chega vazia
1849:     * ("IF EMPTY(this_cCidChaves) / this_cCidChaves = fUniqueIds()", regra
1850:     * #22), e nesse caso a linha do cursor continuaria com a chave antiga: um
1851:     * segundo Encerrar mandaria UPDATE/DELETE para um cidchaves que nao
1852:     * existe no banco, em silencio. Sincronizar aqui fecha esse buraco.
1853:     *
1854:     * As outras tres colunas NAO sao reescritas de proposito: elas acabaram
1855:     * de sair da propria linha (FormParaBO) e o BO nao as transforma -
1856:     * reescrever criaria um segundo dono para o que o usuario digitou.
1857:     *
1858:     * Repinta a grade no fim: alterar o cursor NAO repinta sozinho (regra
1859:     * #21a).
1860:     *
1861:     * PROTECTED PROCEDURE explicito: hook de FormBase, nao se chama de fora.
1862:     *==========================================================================
1863:     PROTECTED PROCEDURE BOParaForm
1864:         LOCAL loc_cCidChavesBO, loc_lSucesso
1865:         loc_lSucesso = .F.
1866: 
1867:         IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
1868:            USED("cursor_4c_Sequencias") AND !EOF("cursor_4c_Sequencias")
1869: 
1870:             loc_cCidChavesBO = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cCidChaves, ""))
1871: 
1872:             IF !EMPTY(loc_cCidChavesBO) AND ;
1873:                loc_cCidChavesBO != ALLTRIM(NVL(cursor_4c_Sequencias.cidchaves, ""))
1874:                 REPLACE cidchaves WITH loc_cCidChavesBO IN cursor_4c_Sequencias
1875:             ENDIF
1876: 
1877:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1878:                 THIS.grd_4c_Dados.Refresh()
1879:             ENDIF
1880: 
1881:             loc_lSucesso = .T.
1882:         ENDIF
1883: 
1884:         RETURN loc_lSucesso
1885:     ENDPROC
1886: 
1887:     *==========================================================================
1888:     * TornarControlesVisiveis - AddObject cria controle com Visible = .F.;
1889:     * percorre recursivamente containers/grids/pageframes tornando tudo
1890:     * visivel. Sem containers flutuantes nesta tela (nenhum painel toggled
1891:     * por botao), entao nao ha nome algum a filtrar/excluir.
1892:     *==========================================================================
1893:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1894:         LOCAL loc_nI, loc_oControl
1895: 
1896:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1897:             loc_oControl = par_oContainer.Controls(loc_nI)
1898:             IF VARTYPE(loc_oControl) = "O"
1899:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
1900:                     loc_oControl.Visible = .T.
1901:                 ENDIF
1902:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
1903:                    loc_oControl.ControlCount > 0
1904:                     THIS.TornarControlesVisiveis(loc_oControl)
1905:                 ENDIF
1906:             ENDIF
1907:         ENDFOR
1908:     ENDPROC
1909: 
1910:     *==========================================================================
1911:     * Destroy - Reabilita o form pai ao fechar este dialogo (legado:
1912:     * cmdSair.Click faz .ParentForm.Enabled = .t. antes do ThisForm.Release;
1913:     * aqui tambem fica como rede de seguranca para qualquer caminho de
1914:     * fechamento que nao passe pelo botao Encerrar - ESC/fechamento externo)
1915:     *==========================================================================
1916:     PROCEDURE Destroy
1917:         IF VARTYPE(THIS.this_oFormPai) = "O"
1918:             THIS.this_oFormPai.Enabled = .T.
1919:             THIS.this_oFormPai         = .NULL.
1920:         ENDIF
1921: 
1922:         DODEFAULT()
1923:     ENDPROC
1924: 
1925: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpSqnBO.prg):
*==============================================================================
* SigOpSqnBO.prg - Business Object para "Sequencia de Operacoes do Caixa" (SIGOPSQN)
*
* Origem legado : SigOpSqn.SCX  (tasks\task806)
* Tipo de form  : OPERACIONAL (dialogo FILHO, chamado pela Lista do form pai
*                 SigCdOpe - Cadastro de Operacoes do Caixa)
* Tabela base   : SigMvCxs | PK: cidchaves
* Herda de      : BusinessBase
*
* O QUE A TELA FAZ (legado)
* -------------------------
* Dialogo filho que grava a SEQUENCIA de execucao das operacoes de caixa de
* uma operacao-pai (crSigCdOpe.Dopes). O legado recebe "poForm" (o form pai)
* e "pnDataSes" (DataSession do pai) no Init, troca para a DataSession do pai
* e manipula um cursor REMOTO bufferizado ("crSigMvCxs", requeried via
* SigCdOpe.poDataMgr) que lista as linhas de SigMvCxs filtradas pela operacao
* corrente. A grade (GradeSubN) tem 2 colunas editaveis:
*   Column1 -> cNivels (TextBox com lookup em TmpOper/SigCdOpe.Dopes, filtrado
*              por CupFis IN (1,3) - so operacoes de "Cupom Fiscal")
*   Column2 -> Seqs    (TextBox numerico, InputMask "9", faixa 1-8)
* Botoes: Inserir (Append Blank + foca Column1), Excluir (Delete da linha
* corrente) e Sair/Encerrar (valida duplicidade/sequencia ausente, grava via
* poDataMgr.UpDate + Commit, reabilita os botoes do pai e fecha o dialogo).
*
* GRAVACAO
* --------
* O legado grava via TableUpdate do cursor bufferizado inteiro (poDataMgr.
* UpDate('crSigMvCxs') + Commit()) so no clique de Sair/Encerrar - nao ha
* Inserir/Atualizar/Excluir linha-a-linha contra o SQL Server durante a
* edicao da grade (isso fica so no cursor local, igual ao padrao de
* SigOpSnoBO.ListarSubNiveis/ListarSubSubNiveis: cursor READWRITE editado
* pela grade, e o BO grava quando o Form decide persistir).
*
* METODOS DE DADOS (todos entregues)
* ------------------------------------------------------------------
*   CarregarDoCursor(par_cAliasCursor) - mapeia cidchaves/cdopes/cnivels/seqs
*       de uma linha de SigMvCxs para as properties deste BO (Fase 2).
*   ListarSequencias(par_cOperacaoPai)  - popula THIS.this_cCursorSequencias
*       com as linhas de SigMvCxs da operacao-pai, equivalente ao legado
*       ReQuery('crSigMvCxs') (cursor READWRITE - a grade insere/remove linha
*       por Append Blank/Delete direto no cursor local). Eh o que alimenta a
*       grade do form (FormSigOpSqn.CarregarDados).
*   ListarOperacoesCupFis()             - popula THIS.this_cCursorOperacoes
*       com "Select Dopes From SigCdOpe Where CupFis in (1,3)", equivalente
*       ao legado TmpOper (universo do lookup da coluna cNivels). Fase 6 -
*       carregado UMA VEZ no InicializarForm, igual ao legado (nao eh
*       re-executado a cada CarregarDados).
*   LimparDados()                       - override da Fase 8: zera as 4
*       properties da entidade. Quem chama eh NovoRegistro(), antes do
*       FormSigOpSqn.FormParaBO atribuir a linha nova.
*   Inserir / Atualizar / ExecutarExclusao - PROTECTED, uma LINHA por
*       chamada. De fora usa-se Salvar()/Excluir() (regra #51).
*
*   A persistencia do cursor INTEIRO (equivalente ao poDataMgr.UpDate
*   ('crSigMvCxs') + Commit() do legado) NAO ficou aqui: ela eh
*   FormSigOpSqn.PersistirSequencias, que percorre o cursor local e chama
*   Salvar()/Excluir() linha a linha. O motivo eh que quem sabe o que a
*   SESSAO do dialogo mudou eh o form - ele guarda as linhas criadas
*   (this_cCidChavesNovas) e as marcas de exclusao do cursor, que sao o que
*   distingue INSERT de UPDATE e de DELETE; o legado tirava isso do buffer
*   da view remota, que nao existe aqui. Um metodo neste BO recebendo o
*   alias do cursor duplicaria esse estado em dois donos.
*
* VALIDACOES DO LEGADO QUE PERTENCEM AO cmdSair.Click (regra de negocio
* transcrita LITERALMENTE em FormSigOpSqn.ExisteOperacaoDuplicada e
* ExisteSequenciaNaoInformada, NUNCA reescrita):
*   1) Nenhuma cNivels duplicada em crSigMvCxs (Group By cNivels Having
*      Sum(1) > 1 -> "Existem Operacoes Duplicadas!!!").
*   2) Nenhuma linha com cNivels preenchida e Seqs = 0 (Where Not Empty
*      (cNivels) And Seqs = 0 -> "Existem Operacoes sem Sequencia
*      informada!!!").
*   As duas SO valem quando cmdInserir.Visible Or cmdExcluir.Visible (ou
*   seja, quando o pai esta em INSERIR/ALTERAR) E quando houve alguma
*   alteracao na sessao (lHouveExcl/lHouveIns/lHouveAlt).
*
* LARGURAS DO SCHEMA (docs\schema.sql) - usadas no MaxLength dos
* controles e no dimensionamento das colunas do cursor
* -------------------------------------------------------------------
*   SigMvCxs.cdopes     char(20) NOT NULL  SigMvCxs.cidchaves char(20) NOT NULL (PK)
*   SigMvCxs.cnivels    char(20) NOT NULL  SigMvCxs.seqs      numeric(2,0) NOT NULL
*   SigCdOpe.dopes      char(20) NOT NULL  - PK/descricao (coluna unica, ver
*                        regra do pipeline "SigCdOpe eh single-column: NUNCA
*                        usar descrs/Descrs")
*==============================================================================

DEFINE CLASS SigOpSqnBO AS BusinessBase

    *--------------------------------------------------------------------------
    * ENTIDADE - linha de sequencia de operacao (SigMvCxs)
    *--------------------------------------------------------------------------
    this_cCidChaves          = ""   && cidchaves char(20) NOT NULL - PK (gerada com fUniqueIds())
    this_cCDopes             = ""   && cdopes    char(20) NOT NULL - FK SigCdOpe.dopes (operacao-pai, a do cadastro)
    this_cCNivels            = ""   && cnivels   char(20) NOT NULL - FK SigCdOpe.dopes (operacao usada na sequencia)
    this_nSeqs               = 0    && seqs      numeric(2,0) NOT NULL - sequencia de execucao (1 a 8)

    *--------------------------------------------------------------------------
    * CONTEXTO HERDADO DO FORM PAI
    * Legado: ThisForm.ParentForm / Set DataSession To pnDataSes / pcEscolha
    *--------------------------------------------------------------------------
    this_cEscolha            = ""   && pcEscolha do pai: INSERIR / ALTERAR / PROCURAR (habilita Inserir/Excluir)
    this_nDataSessionPai     = 0    && DataSessionId do pai (poForm.DataSessionId / pnDataSes do legado)

    *--------------------------------------------------------------------------
    * ESTADO DA SESSAO DO DIALOGO
    * Legado: propriedades customizadas lhouvealt / lhouveexcl / lhouveins do
    * SIGOPSQN - usadas pelo cmdSair.Click para decidir se valida e grava.
    *
    * DONO UNICO (Fase 8): no legado essas tres flags sao do FORM, e no
    * migrado continuam sendo - quem escreve e quem le eh FormSigOpSqn
    * (this_lHouveAlteracao/this_lHouveInclusao/this_lHouveExclusao), nos
    * mesmos pontos do legado (Valid das celulas, Click de Inserir/Excluir,
    * BtnSairClick). As copias aqui ficam ZERADAS e servem so de espelho
    * documental do legado: NAO ligar codigo novo nelas sem antes remover as
    * do form, senao a tela passa a ter dois donos do mesmo estado e eles
    * divergem em silencio (a gravacao do Encerrar le o dono errado e nao
    * grava nada, ou grava sem alteracao nenhuma).
    *--------------------------------------------------------------------------
    this_lHouveAlteracao     = .F.  && lhouvealt  - houve alteracao de cNivels/Seqs numa linha existente
    this_lHouveExclusao      = .F.  && lhouveexcl - houve exclusao de linha
    this_lHouveInclusao      = .F.  && lhouveins  - houve inclusao de linha

    *--------------------------------------------------------------------------
    * ALIASES DE CURSOR
    * (nomes do legado entre parenteses - PILAR 3 manda renomear)
    *--------------------------------------------------------------------------
    this_cCursorSequencias   = "cursor_4c_Sequencias"  && crSigMvCxs - linhas de SigMvCxs da operacao-pai (grade)
    this_cCursorOperacoes    = "cursor_4c_Operacoes"   && TmpOper    - universo do lookup (SigCdOpe.Dopes, CupFis IN (1,3))

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *
    * Define a tabela/chave de persistencia (SigMvCxs.cidchaves) e repoe os
    * valores iniciais que o legado tem na propria sessao do dialogo
    * (nenhuma alteracao/inclusao/exclusao ainda ocorrida).
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigMvCxs"
        THIS.this_cCampoChave = "cidchaves"

        THIS.this_nSeqs           = 0
        THIS.this_nDataSessionPai = 0
        THIS.this_lHouveAlteracao = .F.
        THIS.this_lHouveExclusao  = .F.
        THIS.this_lHouveInclusao  = .F.

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparDados - zera as properties da ENTIDADE (Fase 8)
    *
    * BusinessBase.LimparDados so limpa this_cMensagemErro e deixa dito que
    * "subclasses devem limpar suas propriedades especificas". Quem chama eh
    * NovoRegistro() (e CancelarEdicao()/Excluir()), ou seja: toda vez que o
    * form prepara uma linha NOVA para gravar.
    *
    * Sem este override, as 4 properties entravam na linha nova com o valor
    * da linha ANTERIOR do laco de FormSigOpSqn.PersistirSequencias - hoje
    * isso fica mascarado porque o FormParaBO logo em seguida atribui as
    * quatro, mas qualquer caminho que deixasse de atribuir uma delas
    * gravaria o dado da linha errada, sem erro nenhum na tela.
    *
    * NAO limpa this_cCursorSequencias/this_cCursorOperacoes (nomes de alias,
    * nao dado) nem this_cEscolha/this_nDataSessionPai (contexto do form pai,
    * valido por toda a sessao do dialogo) - zerar esses derrubaria a carga
    * da grade e o controle de acesso aos botoes.
    *
    * DODEFAULT() primeiro, para nao perder a limpeza da mensagem de erro
    * feita pela base.
    *--------------------------------------------------------------------------
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cCidChaves = ""
        THIS.this_cCDopes    = ""
        THIS.this_cCNivels   = ""
        THIS.this_nSeqs      = 0

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna o valor da chave para a auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega as propriedades de uma linha de sequencia
    * (SigMvCxs) a partir de um cursor posicionado nessa linha (cursor
    * cursor_4c_Sequencias, populado por ListarSequencias,
    * ou qualquer outro cursor/SELECT que inclua as mesmas 4 colunas).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            IF !EOF()
                THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
                THIS.this_cCDopes    = TratarNulo(cdopes,    "C")
                THIS.this_cCNivels   = TratarNulo(cnivels,   "C")
                THIS.this_nSeqs      = TratarNulo(seqs,      "N")

                THIS.this_lNovoRegistro = .F.
                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ListarSequencias - Popula cursor_4c_Sequencias com as linhas de SigMvCxs
    * da operacao-pai, equivalente ao legado "ReQuery('crSigMvCxs')".
    *
    * A consulta eh a MESMA que o form pai (SIGCDOPE) registra para esse
    * cursor no seu AddCursor:
    *
    *   Select a.* From SigMvCxs a inner join SigCdOpe b on a.cdopes = b.Dopes
    *   Where a.cDopes = ?crSigCdOpe.Dopes Order by a.cDopes, a.cnivels
    *
    * As 4 colunas sao listadas explicitamente no lugar de "a.*": SigMvCxs
    * tem exatamente cdopes/cidchaves/cnivels/seqs (docs\schema.sql), e a
    * lista explicita eh o que garante que o CREATE/SELECT INTO e os
    * ControlSource da grade casem por nome.
    *
    * Cursor READWRITE (NAO o cursor cru do SQLEXEC, que nasce somente-
    * leitura): as duas colunas da grade sao editaveis e os botoes Inserir/
    * Excluir inserem e apagam linha direto no cursor local, igual ao legado
    * (Insert Into crSigMvCxs / Delete). Sem READWRITE a celula nem entra em
    * edicao e o REPLACE/INSERT estoura.
    *
    * Os RETURN de guarda ficam FORA do TRY/CATCH (regra #1).
    *--------------------------------------------------------------------------
    FUNCTION ListarSequencias(par_cOperacaoPai)
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
            loc_cSQL = "SELECT a.cdopes, a.cidchaves, a.cnivels, a.seqs" + ;
                       " FROM SigMvCxs a" + ;
                       " INNER JOIN SigCdOpe b ON a.cdopes = b.dopes" + ;
                       " WHERE a.cdopes = " + EscaparSQL(loc_cOperacaoPai) + ;
                       " ORDER BY a.cdopes, a.cnivels"

            IF USED("cursor_4c_SeqTmp")
                USE IN cursor_4c_SeqTmp
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SeqTmp")

            IF loc_nResultado >= 0
                *-- USE IN fecha o alias mesmo com buffer sujo - sem
                *-- TABLEREVERT, que exige buffering e ERRA no cursor de
                *-- Buffering = 1 (regra #52)
                IF USED("cursor_4c_Sequencias")
                    USE IN cursor_4c_Sequencias
                ENDIF

                SELECT * FROM cursor_4c_SeqTmp INTO CURSOR cursor_4c_Sequencias READWRITE
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar as sequ" + CHR(234) + "ncias da opera" + ;
                    CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_SeqTmp")
                USE IN cursor_4c_SeqTmp
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpSqnBO.ListarSequencias:" + CHR(13) + ;
                loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ListarOperacoesCupFis - Popula cursor_4c_Operacoes com o universo do
    * lookup da Column1 (cnivels), equivalente ao legado TmpOper:
    *
    *   lcSql = [Select Dopes From SigCdOpe Where CupFis in (1,3)]
    *   SigCdOpe.PodataMgr.Sqlexecute(lcsql,'TmpOper')
    *   Select TmpOper
    *   Index On Dopes Tag dopes
    *
    * Carregado UMA VEZ (igual ao legado, no Init) - diferente de
    * ListarSequencias, que eh re-executado a cada CarregarDados deste
    * dialogo. Chamado por FormSigOpSqn.InicializarForm, antes do usuario
    * poder editar a grade.
    *
    * SigCdOpe eh single-column (regra do pipeline "SigCdOpe eh
    * single-column: NUNCA usar descrs/Descrs"): a mesma coluna dopes serve
    * de PK E de descricao - nao ha coluna de descricao separada.
    *
    * INDEX ON dopes TAG dopes - para o Valid da celula localizar com SEEK,
    * igual ao legado (Seek(This.Value, 'TmpOper', 'Dopes')).
    *
    * Os RETURN de guarda ficam FORA do TRY/CATCH (regra #1).
    *--------------------------------------------------------------------------
    FUNCTION ListarOperacoesCupFis()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        *-- Sem conexao nao ha o que consultar (probe/harness sem config.prg)
        IF TYPE("gnConnHandle") != "N"
            RETURN .F.
        ENDIF

        IF gnConnHandle <= 0
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT dopes FROM SigCdOpe WHERE cupfis IN (1, 3)"

            IF USED("cursor_4c_Operacoes")
                USE IN cursor_4c_Operacoes
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacoes")

            IF loc_nResultado >= 0
                SELECT cursor_4c_Operacoes
                INDEX ON dopes TAG dopes
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar o universo de opera" + CHR(231) + CHR(245) + ;
                    "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpSqnBO.ListarOperacoesCupFis:" + CHR(13) + ;
                loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Inclui uma nova linha de sequencia (SigMvCxs) no banco.
    * Equivalente ao legado cmdInserir.Click (Insert Into crSigMvCxs) seguido
    * da persistencia feita no Sair/Encerrar (poDataMgr.UpDate + Commit) -
    * aqui a gravacao do INSERT ja eh direta contra o SQL Server, por linha.
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

            loc_cSQL = "INSERT INTO SigMvCxs (cdopes, cidchaves, cnivels, seqs)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCDopes) + ", " + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cCNivels) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nSeqs, 0) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsSqn")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao incluir sequ" + CHR(234) + "ncia da opera" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_InsSqn")
                USE IN cursor_4c_InsSqn
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpSqnBO.Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza uma linha de sequencia (SigMvCxs) ja existente.
    * Equivalente a legado editando cNivels/Seqs direto na grade (Column1/
    * Column2.Valid) e persistindo no Sair/Encerrar.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigMvCxs SET" + ;
                       " cdopes  = " + EscaparSQL(THIS.this_cCDopes) + "," + ;
                       " cnivels = " + EscaparSQL(THIS.this_cCNivels) + "," + ;
                       " seqs    = " + FormatarNumeroSQL(THIS.this_nSeqs, 0) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdSqn")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar sequ" + CHR(234) + "ncia da opera" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_UpdSqn")
                USE IN cursor_4c_UpdSqn
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpSqnBO.Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Remove uma linha de sequencia (SigMvCxs) do banco.
    * Equivalente ao legado cmdExcluir.Click (Delete da linha corrente de
    * crSigMvCxs), com a persistencia feita diretamente contra o SQL Server.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigMvCxs" + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelSqn")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir sequ" + CHR(234) + "ncia da opera" + CHR(231) + CHR(227) + ;
                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_DelSqn")
                USE IN cursor_4c_DelSqn
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpSqnBO.ExecutarExclusao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

