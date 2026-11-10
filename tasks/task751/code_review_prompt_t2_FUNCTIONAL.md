# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (8)
- [LOSTFOCUS-SEM-GUARDIA] Handler 'CodObsLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoCodObsLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [METODO-INEXISTENTE] Metodo 'THIS.ValidarDataMinima()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.VolumesWhen()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.BuscarContaEntrega()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ValidarContaEntregaEncontrada()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.SolicitarLiberacaoPrazoEntrega()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.AvancarAlemDosFeriados()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [LAYOUT-POSITION] Controle 'btnMultObs' (parent: SIGOPINF.cntObservacao): Left original=135 vs migrado 'cmd_4c_BtnMultObs' Left=3 (diff=132px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopinf.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (3554 linhas total):

*-- Linhas 23 a 230:
23: *     (Width/Height/Caption/BackColor/FontName/FontSize - analise.json)
24: *   - Init(): recebe os 4 parametros do form pai na MESMA ordem posicional do
25: *     Lparameters legado, guarda-os e delega a FormBase.Init() por
26: *     DODEFAULT(), que chama InicializarForm()
27: *   - InicializarForm(): instancia o sigopinfBO das Fases 1-2 e monta a casca
28: *     visual (cabecalho)
29: *   - SincronizarEscolhaPai(): copia o modo do form pai (this_cModoAtual), tal
30: *     como o Init legado faz com ".pcEscolha = ThisForm.ParentForm.pcEscolha"
31: *     - leitura UNICA no momento da abertura, nao referencia viva
32: *   - DesabilitarFormPai()/ReabilitarFormPai(): o
33: *     "ThisForm.ParentForm.Enabled = .f." do Init legado e o reverso no
34: *     fechamento - este dialogo nao e modal (WindowType nao declarado no
35: *     dump), e o legado impede a interacao com o pai manualmente
36: *   - ConfigurarCabecalho(): a faixa cinza do topo (cntSombra do legado) com
37: *     o titulo duplicado - sombra preta atras, texto branco por cima
38: *   - TornarControlesVisiveis() e Destroy()
39: *
40: * FASE 4/8 - BOTOES DE ACAO. Entrega:
41: *   - ConfigurarBotoesAcao(): os 3 CommandGroup de botao unico que o dump
42: *     pendura direto no Form (cntBotoes/cmdCotacao/cmdEntrega ->
43: *     obj_4c_CntBotoes/obj_4c_CmdCotacao/obj_4c_CmdEntrega), criados DEPOIS
44: *     do cabecalho para desenhar por cima da faixa (Top=-2)
45: *   - CmdCotacaoClick()/CmdEntregaClick(): logica COMPLETA (abrem os
46: *     dialogos JA MIGRADOS FormSigPrCtc/FormSigOpEnt, transcricao de
47: *     cmdCotacao.Valid/cmdEntrega.Valid do legado) - nao dependem de
48: *     nenhum container criado em fase posterior
49: *   - AtualizarVisibilidadeCmdEntrega(): "cmdEntrega.Visible =
50: *     InList(crSigCdOpe.DtEntrs,1,4,6) And Not InList(pcEscolha,'INSERIR',
51: *     'EXCLUIR')" do Init legado - crSigCdOpe ainda nao e carregado nesta
52: *     fase (CursorQuery do Init legado, fases seguintes), entao o botao
53: *     comeca oculto (falso seguro) at? alguma fase futura popular o cursor
54: *     e chamar este metodo de novo
55: *   - obj_4c_CntBotoes ("Salvar") e criado so visualmente: o Click dele
56: *     (SIGOPINF.cntBotoes.Click, 170 linhas) depende de containers
57: *     (cntObservacao/cntEmiss/cntEntregas/cntRecepcaos/cntEcfs/cntNemps)
58: *     e cursores (crSigCdOpe/CrSigOpCdc/xPar/crTpmMvItn) ainda nao
59: *     existentes - a acao principal da tela fica para a Fase 8
60: *
61: * FASE 5/8 - CAMPOS PRINCIPAIS (PARTE 1). Entrega a primeira metade dos
62: * containers de dados que pendulam direto no Form (layout.json), todos
63: * COM ControlSource = "TprMvCab.<col>" (igual ao legado - estes controles
64: * escrevem direto no cursor de trabalho do form pai, nao no BO):
65: *   - ConfigurarCamposDocumentos(): cntCodigos/cntDocumentos/cntEcfs/
66: *     cntNemps (mapeamento.json: cnt_4c_Codigos/cnt_4c_Documentos/
67: *     cnt_4c_Ecfs/cnt_4c_Nemps). getCodigos.When sempre .F. (campo nunca
68: *     editavel - MascNum e so exibicao); getDocumentos/GetNumeroNota.When
69: *     depende de crSigCdOpe (cursor do Init legado, ainda nao portado -
70: *     falso seguro ate existir); getNemps.Valid consulta SIGFIMPF via
71: *     fDecriptografar (wrapper utils/fdecriptografar.prg)
72: *   - ConfigurarCamposDatas(): cntEmiss/cntEntregas/cntRecepcaos/
73: *     cntPrzEnts (cnt_4c_Emiss/cnt_4c_Entregas/cnt_4c_Recepcaos/
74: *     cnt_4c_PrzEnts). Os 4 compartilham o mesmo Valid (data minima
75: *     01/01/1900) via ValidarDataMinima(); getEntregas.When e o UNICO
76: *     que so libera em INSERIR (os outros tres liberam em INSERIR E
77: *     ALTERAR) - Prz. Entrega so e alteravel depois pelo cmdEntrega
78: *     (Fase 4, CmdEntregaClick)
79: * FASE 6/8 - CAMPOS RESTANTES E LOOKUPS (PARTE 2). Entrega os 7 containers
80: * que faltavam (todos ainda com ControlSource = "TprMvCab.<col>", como no
81: * legado):
82: *   - ConfigurarVolumes(): cntVolumes (5 campos de transporte), When
83: *     compartilhado (VolumesWhen)
84: *   - ConfigurarObservacao(): cntObservacao - getCodObs com o lookup
85: *     completo do legado (faixa ObsIni/ObsFins de SigCdOpe, fallback
86: *     FormBuscaAuxiliar em SigCdObs), getDesObs com o gate ALTINFO
87: *     (fChecaAcesso) e btnMultObs (abre SigOpIns - fora do acervo,
88: *     AvisarLegadoNaoPortado)
89: *   - ConfigurarProtocolo(): cntProtocolo (reaproveita PadraoIncluirAlterarWhen)
90: *   - ConfigurarEntrega(): cntEntrega - getContas/getDConta/getCpfs com o
91: *     lookup de conta em SigCdCli (checagem de acesso via fAcessoContas em
92: *     modo BACKEND - sem pSt1/pSt2 - regra do projeto contra auto-load de
93: *     UI, FormBuscaAuxiliar para o restante) e cmdEntrega ("Local de
94: *     Entrega", abre SigCdEnd - fora do acervo, AvisarLegadoNaoPortado)
95: *   - ConfigurarPedido()/ConfigurarObs2()/ConfigurarLivre(): cntPedido,
96: *     CntObs2 (abre SigOpIns - fora do acervo) e cntLivre
97: *   - KeyPress do Form (F2/F3 do legado) para os dois botoes de navegacao
98: *     por atalho, agora que cntEntrega.cmd_4c_CmdEntrega existe
99: *
100: * FASE 7/8 - EVENTOS PRINCIPAIS DO CICLO DE VIDA. Este dialogo NAO tem
101: * botoes de Incluir/Alterar/Visualizar/Excluir (nao e form CRUD - ver
102: * comentario de cabecalho acima, "Tipo: OPERACIONAL"); o template generico
103: * de Fase 7 (BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/
104: * BtnExcluirClick) nao se aplica aqui e NAO foi criado - inventar esses
105: * quatro metodos seria codigo morto, sem botao nenhum para dispara-los, e
106: * violaria o PILAR 1 (o legado nao tem essas acoes nesta tela). Os
107: * "eventos principais" reais desta tela sao o que falta do Init legado
108: * (205 linhas) para o form deixar de operar em modo falso-seguro. Entrega:
109: *   - CarregarCursoresOperacao(): "With ThisForm.ParentForm.poDataMgr /
110: *     .Cursorquery('SigCdOpe','CrSigCdOpe','Dopes',TprMvCab.Dopes) /
111: *     .Cursorquery('SigOpCdc','CrSigOpCdc','Dopes',TprMvCab.Dopes) /
112: *     .Cursorquery('SigOpCdd','CrSigOpCdd','Dopes',TprMvCab.Dopes)" do Init
113: *     legado (a 4a CursorQuery, SigCdEmp/CrEmp, fica de fora - so e usada
114: *     no bloco "Carrega Dados da Conta", que depende de
115: *     ThisForm.ParentForm.pEmps, propriedade do form pai fora do escopo
116: *     desta tela). Chamada ANTES de ConfigurarBotoesAcao() para que
117: *     AtualizarVisibilidadeCmdEntrega() (Fase 4) ja tenha crSigCdOpe
118: *     carregado na primeira passada.
119: *   - AtualizarVisibilidadePorOperacao(): o corpo do Init legado que liga
120: *     Visible/Caption de cada container ao tipo de operacao (DigObs,
121: *     DtEntrs, CupFis, DadosNotas, PedClis, EditProts, DigDoc, DtEmis,
122: *     DigRecs, PrzLjs, ConfigGers). Chamada DEPOIS de
123: *     TornarControlesVisiveis(THIS) - este ultimo reescreve Visible=.T. em
124: *     CADA AddObject recursivamente, entao aplicar a regra de negocio
125: *     ANTES dele seria desfeita; depois dele e que a visibilidade real do
126: *     tipo de operacao prevalece. Reaplica AtualizarVisibilidadeCmdEntrega()
127: *     no fim, pela mesma razao.
128: *   - CarregarPrazoEntregaPadrao(): "PROCEDURE carregaprzent" do legado -
129: *     sugere data de entrega padrao (hoje, ou hoje + prazo minimo/maximo
130: *     do tipo de operacao, ou hoje + prazo de entrega cadastrado na conta
131: *     em SigCdCli.PrazoEnts) quando o campo ainda esta vazio ou e hoje.
132: *   - AjustarPosicaoCampos(): "PROCEDURE ajustaobjs" do legado - reflui os
133: *     containers da 1a/2a linha e os de baixo (Observacao/Entrega/Volumes)
134: *     preenchendo o espaco dos que ficaram ocultos pela visibilidade
135: *     calculada acima - mesma formula, Left/Top acumulados a partir da
136: *     origem de cnt_4c_Codigos.
137: *
138: * DELIBERADAMENTE FORA DESTA FASE (falso seguro documentado nos proprios
139: * metodos novos, nao omitido em silencio):
140: *   - Bloco "Carrega Dados da Conta" do Init (crSigCdOpe.Opers=2): le
141: *     ThisForm.ParentForm.Pagina.Dados.pgfprincipal.pgcontas.Destino.
142: *     Get_Conta/Get_DConta/Get_Cpf e o cursor TmpOperacao (grade de itens
143: *     do movimento) - nenhum dos dois pertence a este dialogo nem esta
144: *     disponivel nele.
145: *   - Override do ObsPads por CFOP (SigCdOop + crSigMvNfi.CfoSubs/Cfis):
146: *     so se aplica quando CrSigOpCdd.ChkCFOP <> 2; sem crSigMvNfi (grade
147: *     de itens, fora desta tela), a observacao padrao usa direto
148: *     crSigCdOpe.ObsPads - que E o comportamento do legado quando
149: *     ChkCFOP = 2, entao nao e invencao, e uma reproducao parcial e fiel.
150: * SigCdEnd e SigOpIns (Do Form do legado) NAO vieram no acervo desta
151: * migracao - AvisarLegadoNaoPortado() tenta de verdade (CREATEOBJECT) e so
152: * avisa (MsgAviso) se a classe realmente nao existir, igual ao padrao de
153: * FormSigOpChi/FormSigOpCpo/Formsigopfis.
154: *
155: * As checagens que dependem de crSigCdOpe/CrSigOpCdc (situacao da conta,
156: * faixa de observacoes, PedClis=5, ALTINFO) seguem o "falso seguro" ja
157: * estabelecido na Fase 5: USED() guarda cada bloco, e sem o cursor a
158: * checagem extra fica de fora (a tela nao bloqueia por um dado que ainda
159: * nao existe nela) - esses CursorQuery pertencem ao Init legado.
160: *
161: * FASE 8/8 - ACAO PRINCIPAL (SALVAR) E ENCERRAMENTO. Entrega:
162: *   - BtnSalvarClick(): transcricao de "PROCEDURE btnSelItens.Click" (170
163: *     linhas) - as validacoes de INSERIR/ALTERAR (observacao obrigatoria,
164: *     data de emissao, prazo de entrega minimo/maximo com liberacao via
165: *     SigOpSen, recepcao, cupom fiscal/ECF) e, no ramo ELSE (CONSULTAR),
166: *     o UPDATE pontual de Obses via sigopinfBO.Atualizar() (Fases 1-2) sob
167: *     o mesmo gate ALTINFO (fChecaAcesso) de DesObsWhen (Fase 6). Termina
168: *     chamando THIS.FecharDialogo() - identico ao "ThisForm.Return" do
169: *     final de cada ramo legado.
170: *   - SolicitarLiberacaoPrazoEntrega(): "Do Form SigOpSen With 'LIBPRZENT',
171: *     ... To _Retorno" repetido para os limites Minimo/Maximo - SigOpSen
172: *     NAO existe na nova arquitetura (memoria
173: *     feedback_sigopsen_ausente_gate_autorizacao); tratado FAIL-CLOSED,
174: *     mesmo padrao canonico de FormSigOpEnt.SolicitarLiberacaoPrazo.
175: *   - RecalcularVencimentosParcelas()/CarregarFeriados()/
176: *     AvancarAlemDosFeriados(): laco de feriados do btnSelItens.Click
177: *     (recalculo de vencimento das parcelas em "xPar" quando o Prazo de
178: *     Entrega muda), mesmo padrao de FormSigOpFpg.CarregarFeriados -
179: *     guardado por USED("xPar"): esse cursor pertence ao form PAI (grade
180: *     de parcelas da operacao), que nao existe no acervo desta migracao
181: *     (nenhum caller de Formsigopinf - ver DataSession abaixo); sem ele o
182: *     recalculo fica de fora, falso seguro documentado.
183: *   - FecharDialogo(): "PROCEDURE return" do legado - propaga
184: *     this_lValidOk ao form pai (thisform.parentform.validok) e fecha com
185: *     THIS.Release() (nao Hide(): esta classe nao isola DataSession, ver
186: *     comentario abaixo, entao Release() e seguro e fiel ao
187: *     "ThisForm.release" legado). A reabilitacao do pai ja acontece em
188: *     Destroy() (Fase 3) - Release() dispara Destroy() antes de destruir
189: *     o objeto.
190: *   - ProcessarLancamentoDireto(): ramo "If ThisForm.Direta" do "PROCEDURE
191: *     return" legado (empilha TprMvCab em CrSigMvCab para commit em lote
192: *     + recalculo de SigMvPar). CrSigMvCab e o commit em lote (antigo
193: *     ThisForm.ParentForm.PoDataMgr.UpDate/Commit/RollBack) pertencem ao
194: *     form PAI/orquestrador da operacao, inexistente no acervo - guardado
195: *     por USED("CrSigMvCab"), falso seguro documentado (nao se arrisca
196: *     ZAP em TprMvCab sem ter onde o lote foi persistido).
197: *
198: * NAO ha ConfigurarPageFrame/ConfigurarPaginaLista/ConfigurarPaginaDados nem
199: * AlternarPagina aqui: o SCX legado nao declara PageFrame (nenhuma linha
200: * "BaseClass: pageframe" no dump) e portanto nao ha pagina para configurar
201: * nem para alternar. Inventar Page1=Lista/Page2=Dados que o legado nao tem
202: * violaria o PILAR 1. O layout e FLAT: todos os containers penduram DIRETO
203: * no Form, como no dump (layout.json).
204: *
205: * DataSession: o Init legado faz "Set DataSession To pData" para operar na
206: * MESMA sessao do form pai (edita o cursor TprMvCab dele). Esta classe NAO
207: * sobrescreve DataSession (fica no default VFP9 = 1, "Default"), que e o
208: * equivalente OOP mais proximo - o form nasce na sessao ativa de quem o
209: * instancia, normalmente o proprio form pai. O numero pData recebido e
210: * guardado em this_nDataSessionPai so para as fases seguintes decidirem como
211: * alcancar o cursor do pai (o sigopinfBO.CarregarDoCursor(par_cAliasCursor)
212: * das Fases 1-2 ja recebe o NOME do alias, nao um numero de sessao).
213: *==============================================================================
214: 
215: DEFINE CLASS Formsigopinf AS FormBase
216: 	ShowWindow = 1
217: 	WindowType = 1
218: 
219:     *--------------------------------------------------------------------------
220:     * PROPRIEDADES VISUAIS - transcritas do dump (analise.json/layout.json)
221:     *--------------------------------------------------------------------------
222:     Width       = 1000
223:     Height      = 600
224:     BackColor   = RGB(100, 100, 100)
225:     FontName    = "Tahoma"
226:     FontSize    = 8
227:     Caption     = "Informa" + CHR(231) + CHR(245) + "es Gerais"
228:     KeyPreview  = .T.    && dump: KeyPreview = .T. - Form intercepta F2/F3 antes dos controles (Fase 6, KeyPress)
229: 
230:     *--------------------------------------------------------------------------

*-- Linhas 282 a 490:
282:     this_lFeriadosCarregados = .F.
283: 
284:     *--------------------------------------------------------------------------
285:     * this_cUltimoContasLostFocusValidado/this_cUltimoDContaLostFocusValidado/
286:     * this_cUltimoCpfsLostFocusValidado - guardam o valor ja processado por
287:     * ContasLostFocus/DContaLostFocus/CpfsLostFocus. LostFocus dispara TODA
288:     * vez que o campo perde o foco, mesmo sem o usuario ter digitado nada -
289:     * diferente do Valid legado, que so dispara quando o valor MUDA. Sem
290:     * este guard, sair e voltar ao campo sem alterar o valor reabriria o
291:     * lookup/revalidaria o acesso a cada vez.
292:     *--------------------------------------------------------------------------
293:     this_cUltimoContasLostFocusValidado = ""
294:     this_cUltimoDContaLostFocusValidado = ""
295:     this_cUltimoCpfsLostFocusValidado   = ""
296: 
297:     *==========================================================================
298:     * Init - Recebe os 4 parametros do form pai e delega a FormBase.Init()
299:     *
300:     * A ordem posicional e IDENTICA ao Lparameters do legado
301:     *   (pForm, pData, plAltDireta, plAutomatico)
302:     * para que a chamada da tela de movimentacao
303:     *   CREATEOBJECT("Formsigopinf", THIS, <sessao>, <direta>, <automatico>)
304:     * seja transcricao direta do "Do Form SIGOPINF With ..." legado.
305:     *
306:     * Todos os argumentos sao OPCIONAIS: o harness de teste e os probes
307:     * headless instanciam o form sem nenhum deles, e nesse caso cada
308:     * propriedade mantem o default declarado acima.
309:     *
310:     * par_lDireta/par_lAutomatico usam PCOUNT() no guard, nao so VARTYPE: em
311:     * VFP9 parametro declarado e NAO passado chega como .F. LOGICO, de modo
312:     * que VARTYPE(par_lDireta) = "L" e verdade tanto para "nao passou" quanto
313:     * para "passou .F." - com default .F. o resultado coincide, mas o PCOUNT
314:     * deixa a intencao explicita e protege de uma futura troca de default.
315:     *==========================================================================
316:     PROCEDURE Init(par_oFormPai, par_nDataSessionPai, par_lDireta, par_lAutomatico)
317: 
318:         IF VARTYPE(par_oFormPai) = "O"
319:             THIS.this_oFormPai = par_oFormPai
320:         ENDIF
321: 
322:         IF VARTYPE(par_nDataSessionPai) = "N"
323:             THIS.this_nDataSessionPai = par_nDataSessionPai
324:         ENDIF
325: 
326:         IF PCOUNT() >= 3 AND VARTYPE(par_lDireta) = "L"
327:             THIS.this_lDireta = par_lDireta
328:         ENDIF
329: 
330:         IF PCOUNT() >= 4 AND VARTYPE(par_lAutomatico) = "L"
331:             THIS.this_lAutomatico = par_lAutomatico
332:         ENDIF
333: 
334:         *-- DODEFAULT() ja chama InicializarForm() atraves do FormBase.Init()
335:         RETURN DODEFAULT()
336:     ENDPROC
337: 
338:     *==========================================================================
339:     * InicializarForm - Cria o Business Object e monta a casca visual base
340:     *
341:     * Equivale ao trecho inicial do Init legado (captions do cabecalho,
342:     * ParentForm.Enabled = .f. e LockScreen) - a parte de CursorQuery/SQL do
343:     * Init legado pertence as fases de dados (4 em diante).
344:     *
345:     * RETURN unico DEPOIS do ENDTRY, com flag loc_lSucesso: RETURN dentro de
346:     * TRY/CATCH e proibido em VFP9.
347:     *==========================================================================
348:     PROTECTED PROCEDURE InicializarForm()
349:         LOCAL loc_lSucesso, loc_oErro
350:         loc_lSucesso = .F.
351: 
352:         THIS.LockScreen = .T.
353:         TRY
354:             THIS.this_oBusinessObject = CREATEOBJECT("sigopinfBO")
355: 
356:             IF VARTYPE(THIS.this_oBusinessObject) <> "O"
357:                 MsgErro("Erro ao criar sigopinfBO. VARTYPE retornou: " + ;
358:                     VARTYPE(THIS.this_oBusinessObject), "Formsigopinf.InicializarForm")
359:             ELSE
360:                 THIS.SincronizarEscolhaPai()
361:                 THIS.DesabilitarFormPai()
362:                 THIS.CarregarCursoresOperacao()
363:                 THIS.ConfigurarCabecalho()
364:                 THIS.ConfigurarBotoesAcao()
365:                 THIS.ConfigurarCamposDocumentos()
366:                 THIS.ConfigurarCamposDatas()
367:                 THIS.ConfigurarVolumes()
368:                 THIS.ConfigurarObservacao()
369:                 THIS.ConfigurarProtocolo()
370:                 THIS.ConfigurarEntrega()
371:                 THIS.ConfigurarPedido()
372:                 THIS.ConfigurarObs2()
373:                 THIS.ConfigurarLivre()
374:                 THIS.TornarControlesVisiveis(THIS)
375:                 THIS.AtualizarVisibilidadePorOperacao()
376:                 THIS.AjustarPosicaoCampos()
377: 
378:                 loc_lSucesso = .T.
379:             ENDIF
380:         CATCH TO loc_oErro
381:             MsgErro(loc_oErro.Message + CHR(13) + ;
382:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
383:                 "Procedure: " + loc_oErro.Procedure, "Erro em Formsigopinf.InicializarForm")
384:         ENDTRY
385:         THIS.LockScreen = .F.
386: 
387:         RETURN loc_lSucesso
388:     ENDPROC
389: 
390:     *==========================================================================
391:     * SincronizarEscolhaPai - copia this_cModoAtual do form pai, reproduzindo
392:     * ".pcEscolha = ThisForm.ParentForm.pcEscolha" do Init legado. Guardado
393:     * por PEMSTATUS porque o form pai e OPCIONAL (probe headless) e porque
394:     * nesta arquitetura o nome da propriedade de modo e this_cModoAtual
395:     * (FormBase), nao o "pcEscolha" literal do legado.
396:     *==========================================================================
397:     PROTECTED PROCEDURE SincronizarEscolhaPai()
398:         IF VARTYPE(THIS.this_oFormPai) = "O" ;
399:            AND PEMSTATUS(THIS.this_oFormPai, "this_cModoAtual", 5)
400:             THIS.this_cPcEscolha = THIS.this_oFormPai.this_cModoAtual
401:         ENDIF
402:     ENDPROC
403: 
404:     *==========================================================================
405:     * DesabilitarFormPai - "ThisForm.ParentForm.Enabled = .f." do Init legado.
406:     * Este dialogo nao e modal (o dump nao declara WindowType = 1), e o
407:     * legado impede a interacao com o pai desabilitando-o manualmente
408:     * enquanto a tela de informacoes esta aberta. Revertido em
409:     * ReabilitarFormPai(), chamado no Destroy().
410:     *==========================================================================
411:     PROTECTED PROCEDURE DesabilitarFormPai()
412:         IF VARTYPE(THIS.this_oFormPai) = "O"
413:             THIS.this_oFormPai.Enabled = .F.
414:         ENDIF
415:     ENDPROC
416: 
417:     *==========================================================================
418:     * ReabilitarFormPai - reverso de DesabilitarFormPai, chamado no Destroy().
419:     *==========================================================================
420:     PROTECTED PROCEDURE ReabilitarFormPai()
421:         IF VARTYPE(THIS.this_oFormPai) = "O"
422:             THIS.this_oFormPai.Enabled = .T.
423:         ENDIF
424:     ENDPROC
425: 
426:     *==========================================================================
427:     * ConfigurarCabecalho - Faixa cinza do topo (cntSombra do legado) com o
428:     * titulo do form desenhado duas vezes: lblSombra em preto atras e
429:     * lblTitulo em branco por cima, 1px acima, o que produz o relevo -
430:     * exatamente como o Init legado faz nas duas primeiras linhas:
431:     *   ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption
432:     *   ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption
433:     *
434:     * Geometria transcrita do dump (layout.json), com UMA correcao
435:     * deliberada de Width: o SCX declara cntSombra.Width = 1100 e os dois
436:     * labels com Width = 769, enquanto o proprio Form tem Width = 1000 - o
437:     * container do cabecalho foi desenhado no Form Designer mais largo que a
438:     * janela (sobreposicao herdada do SCX, regra #28/#30). Copiar os
439:     * literais deixaria uma faixa clara exposta a direita ou cortaria o
440:     * titulo. Por isso o container acompanha THIS.Width e os labels ficam em
441:     * THIS.Width - 20, que com Left = 10 fecha exatamente na borda.
442:     * Top/Height/Font/ForeColor/Alignment/BackStyle seguem o dump.
443:     *
444:     * AutoSize = .F. explicito: o dump declara WordWrap = .T. nos dois
445:     * labels, e AutoSize em Label criado por AddObject e no-op para a
446:     * largura e, com WordWrap, chega a DESCARTAR a Height - a legenda
447:     * colapsaria para uma linha (regra #23). Width e Height vem do dump, que
448:     * ja sao o auto-size calculado pelo Form Designer.
449:     *==========================================================================
450:     PROTECTED PROCEDURE ConfigurarCabecalho()
451:         LOCAL loc_oCnt
452: 
453:         THIS.AddObject("cnt_4c_Sombra", "Container")
454:         loc_oCnt = THIS.cnt_4c_Sombra
455:         WITH loc_oCnt
456:             .Top         = 0
457:             .Left        = 0
458:             .Width       = THIS.Width
459:             .Height      = 80
460:             .BorderWidth = 0
461:             .BackColor   = RGB(100, 100, 100)
462:             .Visible     = .T.
463:         ENDWITH
464: 
465:         loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
466:         WITH loc_oCnt.lbl_4c_LblSombra
467:             .FontBold  = .T.
468:             .FontName  = "Tahoma"
469:             .FontSize  = 18
470:             .WordWrap  = .T.
471:             .Alignment = 0
472:             .BackStyle = 0
473:             .AutoSize  = .F.
474:             .Caption   = THIS.Caption
475:             .Left      = 10
476:             .Top       = 18
477:             .Width     = THIS.Width - 20
478:             .Height    = 40
479:             .ForeColor = RGB(0, 0, 0)
480:             .Visible   = .T.
481:         ENDWITH
482: 
483:         loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
484:         WITH loc_oCnt.lbl_4c_LblTitulo
485:             .FontBold  = .T.
486:             .FontName  = "Tahoma"
487:             .FontSize  = 18
488:             .WordWrap  = .T.
489:             .Alignment = 0
490:             .BackStyle = 0

*-- Linhas 519 a 693:
519:     * (FormSigPrCtc/FormSigOpEnt) e tem Click com logica COMPLETA nesta
520:     * fase - nao dependem de nenhum container criado em fase posterior.
521:     *==========================================================================
522:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
523:         LOCAL loc_oGrp
524: 
525:         *-- obj_4c_CntBotoes: botao "Salvar" (Click -> BtnSalvarClick, Fase 8)
526:         THIS.AddObject("obj_4c_CntBotoes", "CommandGroup")
527:         loc_oGrp = THIS.obj_4c_CntBotoes
528:         WITH loc_oGrp
529:             .Top           = -2
530:             .Left          = 920
531:             .Width         = 85
532:             .Height        = 85
533:             .ButtonCount   = 1
534:             .BackStyle     = 0
535:             .BorderStyle   = 0
536:             .SpecialEffect = 1
537:             .Visible       = .T.
538:         ENDWITH
539:         WITH loc_oGrp.Buttons(1)
540:             .Top             = 5
541:             .Left            = 5
542:             .Width           = 75
543:             .Height          = 75
544:             .FontBold        = .T.
545:             .FontItalic      = .T.
546:             .FontName        = "Tahoma"
547:             .FontSize        = 8
548:             .WordWrap        = .T.
549:             .PicturePosition = 13
550:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
551:             .Caption         = "\<Salvar"
552:             .MousePointer    = 15
553:             .ToolTipText     = "Gravar os Dados Informados"
554:             .SpecialEffect   = 0
555:             .ForeColor       = RGB(90, 90, 90)
556:             .BackColor       = RGB(255, 255, 255)
557:             .Themes          = .F.
558:         ENDWITH
559:         BINDEVENT(loc_oGrp, "Click", THIS, "BtnSalvarClick")
560: 
561:         *-- obj_4c_CmdCotacao: abre FormSigPrCtc (cmdCotacao.Valid legado)
562:         THIS.AddObject("obj_4c_CmdCotacao", "CommandGroup")
563:         loc_oGrp = THIS.obj_4c_CmdCotacao
564:         WITH loc_oGrp
565:             .Top           = -2
566:             .Left          = 845
567:             .Width         = 85
568:             .Height        = 85
569:             .ButtonCount   = 1
570:             .BackStyle     = 0
571:             .BorderStyle   = 0
572:             .SpecialEffect = 1
573:             .Visible       = .T.
574:         ENDWITH
575:         WITH loc_oGrp.Buttons(1)
576:             .Top             = 5
577:             .Left            = 5
578:             .Width           = 75
579:             .Height          = 75
580:             .FontBold        = .T.
581:             .FontItalic      = .T.
582:             .FontName        = "Tahoma"
583:             .FontSize        = 8
584:             .WordWrap        = .T.
585:             .PicturePosition = 13
586:             .Picture         = gc_4c_CaminhoIcones + "geral_cambio_60.jpg"
587:             .Caption         = "\<Cota" + CHR(231) + CHR(227) + "o"
588:             .MousePointer    = 15
589:             .ToolTipText     = "Alterar Cota" + CHR(231) + CHR(227) + "o Informativa"
590:             .SpecialEffect   = 0
591:             .ForeColor       = RGB(90, 90, 90)
592:             .BackColor       = RGB(255, 255, 255)
593:             .Themes          = .F.
594:         ENDWITH
595:         BINDEVENT(loc_oGrp, "Click", THIS, "CmdCotacaoClick")
596: 
597:         *-- obj_4c_CmdEntrega: abre FormSigOpEnt (cmdEntrega.Valid legado)
598:         THIS.AddObject("obj_4c_CmdEntrega", "CommandGroup")
599:         loc_oGrp = THIS.obj_4c_CmdEntrega
600:         WITH loc_oGrp
601:             .Top           = -2
602:             .Left          = 770
603:             .Width         = 85
604:             .Height        = 85
605:             .ButtonCount   = 1
606:             .BackStyle     = 0
607:             .BorderStyle   = 0
608:             .SpecialEffect = 1
609:             .Visible       = .T.
610:         ENDWITH
611:         WITH loc_oGrp.Buttons(1)
612:             .Top             = 5
613:             .Left            = 5
614:             .Width           = 75
615:             .Height          = 75
616:             .FontBold        = .T.
617:             .FontItalic      = .T.
618:             .FontName        = "Comic Sans MS"
619:             .FontSize        = 8
620:             .WordWrap        = .T.
621:             .PicturePosition = 13
622:             .Picture         = gc_4c_CaminhoIcones + "geral_relogio_60.jpg"
623:             .Caption         = "\<Entrega"
624:             .MousePointer    = 15
625:             .ToolTipText     = "Alterar Prazo de Entrega <F3>"
626:             .SpecialEffect   = 0
627:             .ForeColor       = RGB(90, 90, 90)
628:             .BackColor       = RGB(255, 255, 255)
629:             .Themes          = .F.
630:         ENDWITH
631:         BINDEVENT(loc_oGrp, "Click", THIS, "CmdEntregaClick")
632: 
633:         THIS.AtualizarVisibilidadeCmdEntrega()
634:     ENDPROC
635: 
636:     *==========================================================================
637:     * ConfigurarCamposDocumentos - cntCodigos/cntDocumentos/cntEcfs/cntNemps
638:     * (layout.json/mapeamento.json: cnt_4c_Codigos/cnt_4c_Documentos/
639:     * cnt_4c_Ecfs/cnt_4c_Nemps). Geometria e propriedades transcritas do
640:     * dump (SECAO 2 de sigopinf_form_codigo_fonte.txt) - containers com
641:     * BackStyle = 0 (transparentes, mostram o BackColor cinza do Form) e
642:     * labels classe "say" com ForeColor = RGB(90,90,90) EXPLICITO no dump
643:     * (nao e o default inferido da regra #12 - aqui o legado DECLARA esse
644:     * valor, entao e so transcricao).
645:     *
646:     * Todos os TextBox tem ControlSource = "TprMvCab.<col>" - igual ao
647:     * legado, estes controles escrevem direto no cursor de trabalho do
648:     * form pai. Sem TprMvCab aberto (harness/probe headless), a atribuicao
649:     * de ControlSource e pulada (regra: Alias inexistente estoura ao
650:     * atribuir ControlSource, nao so ao exibir) e os campos ficam sem
651:     * binding, inofensivo fora do fluxo real.
652:     *==========================================================================
653:     PROTECTED PROCEDURE ConfigurarCamposDocumentos()
654:         LOCAL loc_oCnt, loc_lTemCursorPai
655:         loc_lTemCursorPai = USED("TprMvCab")
656: 
657:         *-- cnt_4c_Codigos (legado: cntCodigos) -----------------------------
658:         THIS.AddObject("cnt_4c_Codigos", "Container")
659:         loc_oCnt = THIS.cnt_4c_Codigos
660:         WITH loc_oCnt
661:             .Top         = 96
662:             .Left        = 2
663:             .Width       = 67
664:             .Height      = 45
665:             .BackStyle   = 0
666:             .BorderWidth = 0
667:             .Visible     = .T.
668:         ENDWITH
669: 
670:         loc_oCnt.AddObject("lbl_4c_LblCodigos", "Label")
671:         WITH loc_oCnt.lbl_4c_LblCodigos
672:             .FontBold  = .F.
673:             .FontName  = "Tahoma"
674:             .FontSize  = 8
675:             .BackStyle = 0
676:             .Alignment = 0
677:             .AutoSize  = .F.
678:             .Caption   = "C" + CHR(243) + "digo "
679:             .Left      = 3
680:             .Top       = 3
681:             .Width     = 61
682:             .ForeColor = RGB(90, 90, 90)
683:             .Visible   = .T.
684:         ENDWITH
685: 
686:         loc_oCnt.AddObject("txt_4c_Codigos", "TextBox")
687:         WITH loc_oCnt.txt_4c_Codigos
688:             .FontBold      = .T.
689:             .FontSize      = 8
690:             .Left          = 3
691:             .Top           = 20
692:             .Width         = 61
693:             .MaxLength     = 10

*-- Linhas 699 a 822:
699:         IF loc_lTemCursorPai
700:             loc_oCnt.txt_4c_Codigos.ControlSource = "TprMvCab.mascnum"
701:         ENDIF
702:         BINDEVENT(loc_oCnt.txt_4c_Codigos, "When", THIS, "CodigosWhen")
703: 
704:         *-- cnt_4c_Documentos (legado: cntDocumentos) -----------------------
705:         THIS.AddObject("cnt_4c_Documentos", "Container")
706:         loc_oCnt = THIS.cnt_4c_Documentos
707:         WITH loc_oCnt
708:             .Top         = 96
709:             .Left        = 69
710:             .Width       = 170
711:             .Height      = 45
712:             .BackStyle   = 0
713:             .BorderWidth = 0
714:             .Visible     = .T.
715:         ENDWITH
716: 
717:         loc_oCnt.AddObject("lbl_4c_LblDocumentos", "Label")
718:         WITH loc_oCnt.lbl_4c_LblDocumentos
719:             .FontBold  = .F.
720:             .FontName  = "Tahoma"
721:             .FontSize  = 8
722:             .BackStyle = 0
723:             .Alignment = 0
724:             .AutoSize  = .F.
725:             .Caption   = "Documento"
726:             .Left      = 3
727:             .Top       = 3
728:             .Width     = 56
729:             .ForeColor = RGB(90, 90, 90)
730:             .Visible   = .T.
731:         ENDWITH
732: 
733:         loc_oCnt.AddObject("txt_4c_Documentos", "TextBox")
734:         WITH loc_oCnt.txt_4c_Documentos
735:             .Left          = 3
736:             .Top           = 20
737:             .Width         = 67
738:             .Margin        = 0
739:             .MaxLength     = 6
740:             .SpecialEffect = 1
741:             .ForeColor     = RGB(0, 0, 0)
742:             .BorderColor   = RGB(100, 100, 100)
743:             .Visible       = .T.
744:         ENDWITH
745:         IF loc_lTemCursorPai
746:             loc_oCnt.txt_4c_Documentos.ControlSource = "TprMvCab.notas"
747:         ENDIF
748:         BINDEVENT(loc_oCnt.txt_4c_Documentos, "When", THIS, "DocumentosWhen")
749: 
750:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
751:         WITH loc_oCnt.lbl_4c_Label1
752:             .FontBold  = .F.
753:             .FontName  = "Tahoma"
754:             .FontSize  = 8
755:             .BackStyle = 0
756:             .Alignment = 0
757:             .AutoSize  = .F.
758:             .Caption   = "Nota"
759:             .Left      = 73
760:             .Top       = 3
761:             .Width     = 25
762:             .ForeColor = RGB(90, 90, 90)
763:             .Visible   = .T.
764:         ENDWITH
765: 
766:         loc_oCnt.AddObject("txt_4c_NumeroNota", "TextBox")
767:         WITH loc_oCnt.txt_4c_NumeroNota
768:             .Left          = 73
769:             .Top           = 20
770:             .Width         = 94
771:             .Height        = 23
772:             .Margin        = 0
773:             .MaxLength     = 10
774:             .SpecialEffect = 1
775:             .ForeColor     = RGB(0, 0, 0)
776:             .BorderColor   = RGB(100, 100, 100)
777:             .Visible       = .T.
778:         ENDWITH
779:         IF loc_lTemCursorPai
780:             loc_oCnt.txt_4c_NumeroNota.ControlSource = "TprMvCab.NumeroNota"
781:         ENDIF
782:         BINDEVENT(loc_oCnt.txt_4c_NumeroNota, "When", THIS, "DocumentosWhen")
783: 
784:         *-- cnt_4c_Ecfs (legado: cntEcfs) ------------------------------------
785:         THIS.AddObject("cnt_4c_Ecfs", "Container")
786:         loc_oCnt = THIS.cnt_4c_Ecfs
787:         WITH loc_oCnt
788:             .Top         = 96
789:             .Left        = 240
790:             .Width       = 65
791:             .Height      = 45
792:             .BackStyle   = 0
793:             .BorderWidth = 0
794:             .Visible     = .T.
795:         ENDWITH
796: 
797:         loc_oCnt.AddObject("lbl_4c_LblEcfs", "Label")
798:         WITH loc_oCnt.lbl_4c_LblEcfs
799:             .FontBold  = .F.
800:             .FontName  = "Tahoma"
801:             .FontSize  = 8
802:             .BackStyle = 0
803:             .Alignment = 0
804:             .AutoSize  = .F.
805:             .Caption   = "ECF  "
806:             .Left      = 3
807:             .Top       = 3
808:             .Width     = 27
809:             .Height    = 15
810:             .ForeColor = RGB(90, 90, 90)
811:             .Visible   = .T.
812:         ENDWITH
813: 
814:         loc_oCnt.AddObject("txt_4c_Ecfs", "TextBox")
815:         WITH loc_oCnt.txt_4c_Ecfs
816:             .Left          = 3
817:             .Top           = 20
818:             .Width         = 59
819:             .Height        = 23
820:             .Margin        = 0
821:             .InputMask     = "9999999"
822:             .MaxLength     = 7

*-- Linhas 828 a 1292:
828:         IF loc_lTemCursorPai
829:             loc_oCnt.txt_4c_Ecfs.ControlSource = "TprMvCab.ecfs"
830:         ENDIF
831:         BINDEVENT(loc_oCnt.txt_4c_Ecfs, "When", THIS, "PadraoIncluirAlterarWhen")
832: 
833:         *-- cnt_4c_Nemps (legado: cntNemps) ----------------------------------
834:         THIS.AddObject("cnt_4c_Nemps", "Container")
835:         loc_oCnt = THIS.cnt_4c_Nemps
836:         WITH loc_oCnt
837:             .Top         = 96
838:             .Left        = 305
839:             .Width       = 156
840:             .Height      = 45
841:             .BackStyle   = 0
842:             .BorderWidth = 0
843:             .Visible     = .T.
844:         ENDWITH
845: 
846:         loc_oCnt.AddObject("lbl_4c_LblNemps", "Label")
847:         WITH loc_oCnt.lbl_4c_LblNemps
848:             .FontBold  = .F.
849:             .FontName  = "Tahoma"
850:             .FontSize  = 8
851:             .BackStyle = 0
852:             .Alignment = 0
853:             .AutoSize  = .F.
854:             .Caption   = "N" + CHR(186) + " S" + CHR(233) + "rie Imp."
855:             .Left      = 3
856:             .Top       = 3
857:             .Width     = 66
858:             .Height    = 15
859:             .ForeColor = RGB(90, 90, 90)
860:             .Visible   = .T.
861:         ENDWITH
862: 
863:         loc_oCnt.AddObject("txt_4c_Nemps", "TextBox")
864:         WITH loc_oCnt.txt_4c_Nemps
865:             .Left          = 3
866:             .Top           = 20
867:             .Width         = 150
868:             .Height        = 23
869:             .Margin        = 0
870:             .MaxLength     = 20
871:             .SpecialEffect = 1
872:             .ForeColor     = RGB(0, 0, 0)
873:             .BorderColor   = RGB(100, 100, 100)
874:             .Visible       = .T.
875:         ENDWITH
876:         IF loc_lTemCursorPai
877:             loc_oCnt.txt_4c_Nemps.ControlSource = "TprMvCab.nemps"
878:         ENDIF
879:         BINDEVENT(loc_oCnt.txt_4c_Nemps, "When",      THIS, "PadraoIncluirAlterarWhen")
880:         BINDEVENT(loc_oCnt.txt_4c_Nemps, "LostFocus",  THIS, "NempsLostFocus")
881:     ENDPROC
882: 
883:     *==========================================================================
884:     * CodigosWhen - "Return .f." do legado (getCodigos.When): o campo
885:     * Codigo/MascNum e so exibicao, nunca editavel em nenhum modo.
886:     *
887:     * PUBLIC: alvo de BINDEVENT("When").
888:     *==========================================================================
889:     FUNCTION CodigosWhen()
890:         RETURN .F.
891:     ENDFUNC
892: 
893:     *==========================================================================
894:     * DocumentosWhen - "Return ( Inlist( ThisForm.pcEscolha, 'INSERIR',
895:     * 'ALTERAR' ) And Not InList(crSigCdOpe.NFiscals,1,2) And Not
896:     * InList(CrSigCdOpe.DigDoc,4,5) )" do legado - compartilhado por
897:     * getDocumentos.When e GetNumeroNota.When (texto identico no dump).
898:     * crSigCdOpe e o cursor que o CursorQuery do Init legado popula (ainda
899:     * nao portado - fases seguintes); sem ele, falso seguro (campo fica
900:     * nao-editavel).
901:     *
902:     * PUBLIC: alvo de BINDEVENT("When").
903:     *==========================================================================
904:     FUNCTION DocumentosWhen()
905:         LOCAL loc_lPermite
906:         loc_lPermite = .F.
907: 
908:         IF INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR") AND USED("crSigCdOpe")
909:             loc_lPermite = !INLIST(crSigCdOpe.NFiscals, 1, 2) ;
910:                 AND !INLIST(crSigCdOpe.DigDoc, 4, 5)
911:         ENDIF
912: 
913:         RETURN loc_lPermite
914:     ENDFUNC
915: 
916:     *==========================================================================
917:     * PadraoIncluirAlterarWhen - "Return Inlist(ThisForm.pcEscolha,
918:     * 'INSERIR', 'ALTERAR')" do legado - texto IDENTICO em getEcfs.When,
919:     * getNemps.When, getEmiss.When, getRecepcaos.When e getPrzEnts.When
920:     * (compartilhado pelos cinco).
921:     *
922:     * PUBLIC: alvo de BINDEVENT("When").
923:     *==========================================================================
924:     FUNCTION PadraoIncluirAlterarWhen()
925:         RETURN INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
926:     ENDFUNC
927: 
928:     *==========================================================================
929:     * NempsLostFocus - "If Not Empty(This.Value) / lnNoFabr = This.Value /
930:     * lcImpf = fDecriptografar(alltrim(lnNoFabr)) / lcWhere = [Select *
931:     * From SIGFIMPF Where cimpfabs = ?lcImpf ] / ... MessageBox / Return
932:     * .f." do legado (getNemps.Valid). fDecriptografar e o wrapper de
933:     * utils/fdecriptografar.prg (regra #27 - algoritmo original fora do
934:     * acervo, pass-through seguro). Equivalente ao "ao sair do campo" do
935:     * Valid legado - ver regra #47 (lookup/validacao de TextBox solto vai
936:     * em LostFocus, nao em KeyPress).
937:     *
938:     * PUBLIC: alvo de BINDEVENT("LostFocus").
939:     *==========================================================================
940:     PROCEDURE NempsLostFocus()
941:         LOCAL loc_oTxt, loc_cImpf, loc_cSQL, loc_nErro, loc_oErro
942: 
943:         loc_oTxt = THIS.cnt_4c_Nemps.txt_4c_Nemps
944: 
945:         IF !EMPTY(loc_oTxt.Value)
946:             TRY
947:                 loc_cImpf = fDecriptografar(ALLTRIM(loc_oTxt.Value))
948:                 loc_cSQL  = "SELECT * FROM SIGFIMPF WHERE cimpfabs = " + EscaparSQL(loc_cImpf)
949:                 loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigFiMpF")
950: 
951:                 IF loc_nErro < 1
952:                     MsgErro("Favor reinicializar o processo." + CHR(13) + ;
953:                         "Falha na Conex" + CHR(227) + "o (SIGFIMPF)", "Erro")
954:                 ELSE
955:                     IF RECCOUNT("cursor_4c_SigFiMpF") = 0
956:                         MsgAviso("Impressora Fiscal n" + CHR(227) + "o Cadastrada!!", ;
957:                             "Aten" + CHR(231) + CHR(227) + "o")
958:                     ENDIF
959:                     IF USED("cursor_4c_SigFiMpF")
960:                         USE IN cursor_4c_SigFiMpF
961:                     ENDIF
962:                 ENDIF
963:             CATCH TO loc_oErro
964:                 MsgErro(loc_oErro.Message + CHR(13) + ;
965:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
966:                     "Erro ao validar N" + CHR(186) + " S" + CHR(233) + "rie")
967:             ENDTRY
968:         ENDIF
969:     ENDPROC
970: 
971:     *==========================================================================
972:     * ConfigurarCamposDatas - cntEmiss/cntEntregas/cntRecepcaos/cntPrzEnts
973:     * (cnt_4c_Emiss/cnt_4c_Entregas/cnt_4c_Recepcaos/cnt_4c_PrzEnts).
974:     * Classe "fweditdata" no legado -> TextBox com NullDisplay = "//" (data
975:     * vazia exibe barras, nao branco - propriedade nativa do TextBox,
976:     * confirmada em automation/propriedades_baseclasses.txt).
977:     *==========================================================================
978:     PROTECTED PROCEDURE ConfigurarCamposDatas()
979:         LOCAL loc_oCnt, loc_lTemCursorPai
980:         loc_lTemCursorPai = USED("TprMvCab")
981: 
982:         *-- cnt_4c_Emiss (legado: cntEmiss) ----------------------------------
983:         THIS.AddObject("cnt_4c_Emiss", "Container")
984:         loc_oCnt = THIS.cnt_4c_Emiss
985:         WITH loc_oCnt
986:             .Top         = 147
987:             .Left        = 2
988:             .Width       = 86
989:             .Height      = 45
990:             .BackStyle   = 0
991:             .BorderWidth = 0
992:             .Visible     = .T.
993:         ENDWITH
994: 
995:         loc_oCnt.AddObject("lbl_4c_LblEmiss", "Label")
996:         WITH loc_oCnt.lbl_4c_LblEmiss
997:             .FontBold  = .F.
998:             .FontName  = "Tahoma"
999:             .FontSize  = 8
1000:             .BackStyle = 0
1001:             .Alignment = 0
1002:             .AutoSize  = .F.
1003:             .Caption   = "Data Emiss" + CHR(227) + "o "
1004:             .Left      = 3
1005:             .Top       = 3
1006:             .Width     = 80
1007:             .ForeColor = RGB(90, 90, 90)
1008:             .Visible   = .T.
1009:         ENDWITH
1010: 
1011:         loc_oCnt.AddObject("txt_4c_Emiss", "TextBox")
1012:         WITH loc_oCnt.txt_4c_Emiss
1013:             .Left          = 3
1014:             .Top           = 20
1015:             .Width         = 80
1016:             .Margin        = 0
1017:             .SpecialEffect = 1
1018:             .ForeColor     = RGB(0, 0, 0)
1019:             .BorderColor   = RGB(100, 100, 100)
1020:             .NullDisplay   = "//"
1021:             .Visible       = .T.
1022:         ENDWITH
1023:         IF loc_lTemCursorPai
1024:             loc_oCnt.txt_4c_Emiss.ControlSource = "TprMvCab.dtemis"
1025:         ENDIF
1026:         BINDEVENT(loc_oCnt.txt_4c_Emiss, "When",      THIS, "PadraoIncluirAlterarWhen")
1027:         BINDEVENT(loc_oCnt.txt_4c_Emiss, "LostFocus",  THIS, "EmissLostFocus")
1028: 
1029:         *-- cnt_4c_Entregas (legado: cntEntregas) ----------------------------
1030:         THIS.AddObject("cnt_4c_Entregas", "Container")
1031:         loc_oCnt = THIS.cnt_4c_Entregas
1032:         WITH loc_oCnt
1033:             .Top         = 147
1034:             .Left        = 88
1035:             .Width       = 86
1036:             .Height      = 45
1037:             .BackStyle   = 0
1038:             .BorderWidth = 0
1039:             .Visible     = .T.
1040:         ENDWITH
1041: 
1042:         loc_oCnt.AddObject("lbl_4c_LblEntregas", "Label")
1043:         WITH loc_oCnt.lbl_4c_LblEntregas
1044:             .FontBold  = .F.
1045:             .FontName  = "Tahoma"
1046:             .FontSize  = 8
1047:             .BackStyle = 0
1048:             .Alignment = 0
1049:             .AutoSize  = .F.
1050:             .Caption   = "Prz. Entrega "
1051:             .Left      = 3
1052:             .Top       = 3
1053:             .Width     = 80
1054:             .ForeColor = RGB(90, 90, 90)
1055:             .Visible   = .T.
1056:         ENDWITH
1057: 
1058:         loc_oCnt.AddObject("txt_4c_Entregas", "TextBox")
1059:         WITH loc_oCnt.txt_4c_Entregas
1060:             .Left          = 3
1061:             .Top           = 20
1062:             .Width         = 80
1063:             .Margin        = 0
1064:             .SpecialEffect = 1
1065:             .ForeColor     = RGB(0, 0, 0)
1066:             .BorderColor   = RGB(100, 100, 100)
1067:             .NullDisplay   = "//"
1068:             .Visible       = .T.
1069:         ENDWITH
1070:         IF loc_lTemCursorPai
1071:             loc_oCnt.txt_4c_Entregas.ControlSource = "TprMvCab.prazoents"
1072:         ENDIF
1073:         BINDEVENT(loc_oCnt.txt_4c_Entregas, "When",     THIS, "EntregasWhen")
1074:         BINDEVENT(loc_oCnt.txt_4c_Entregas, "LostFocus", THIS, "EntregasLostFocus")
1075: 
1076:         *-- cnt_4c_Recepcaos (legado: cntRecepcaos) --------------------------
1077:         THIS.AddObject("cnt_4c_Recepcaos", "Container")
1078:         loc_oCnt = THIS.cnt_4c_Recepcaos
1079:         WITH loc_oCnt
1080:             .Top         = 147
1081:             .Left        = 174
1082:             .Width       = 86
1083:             .Height      = 45
1084:             .BackStyle   = 0
1085:             .BorderWidth = 0
1086:             .Visible     = .T.
1087:         ENDWITH
1088: 
1089:         loc_oCnt.AddObject("lbl_4c_LblRecepcaos", "Label")
1090:         WITH loc_oCnt.lbl_4c_LblRecepcaos
1091:             .FontBold  = .F.
1092:             .FontName  = "Tahoma"
1093:             .FontSize  = 8
1094:             .BackStyle = 0
1095:             .Alignment = 0
1096:             .AutoSize  = .F.
1097:             .Caption   = "Recep" + CHR(231) + CHR(227) + "o "
1098:             .Left      = 3
1099:             .Top       = 3
1100:             .Width     = 80
1101:             .ForeColor = RGB(90, 90, 90)
1102:             .Visible   = .T.
1103:         ENDWITH
1104: 
1105:         loc_oCnt.AddObject("txt_4c_Recepcaos", "TextBox")
1106:         WITH loc_oCnt.txt_4c_Recepcaos
1107:             .Left          = 3
1108:             .Top           = 20
1109:             .Width         = 80
1110:             .Margin        = 0
1111:             .SpecialEffect = 1
1112:             .ForeColor     = RGB(0, 0, 0)
1113:             .BorderColor   = RGB(100, 100, 100)
1114:             .NullDisplay   = "//"
1115:             .Visible       = .T.
1116:         ENDWITH
1117:         IF loc_lTemCursorPai
1118:             loc_oCnt.txt_4c_Recepcaos.ControlSource = "TprMvCab.dtrecs"
1119:         ENDIF
1120:         BINDEVENT(loc_oCnt.txt_4c_Recepcaos, "When",     THIS, "PadraoIncluirAlterarWhen")
1121:         BINDEVENT(loc_oCnt.txt_4c_Recepcaos, "LostFocus", THIS, "RecepcaosLostFocus")
1122: 
1123:         *-- cnt_4c_PrzEnts (legado: cntPrzEnts) ------------------------------
1124:         THIS.AddObject("cnt_4c_PrzEnts", "Container")
1125:         loc_oCnt = THIS.cnt_4c_PrzEnts
1126:         WITH loc_oCnt
1127:             .Top         = 147
1128:             .Left        = 260
1129:             .Width       = 86
1130:             .Height      = 45
1131:             .BackStyle   = 0
1132:             .BorderWidth = 0
1133:             .Visible     = .T.
1134:         ENDWITH
1135: 
1136:         loc_oCnt.AddObject("lbl_4c_LblPrzEnts", "Label")
1137:         WITH loc_oCnt.lbl_4c_LblPrzEnts
1138:             .FontBold  = .F.
1139:             .FontName  = "Tahoma"
1140:             .FontSize  = 8
1141:             .BackStyle = 0
1142:             .Alignment = 0
1143:             .AutoSize  = .F.
1144:             .Caption   = "Dt. Prometida"
1145:             .Left      = 3
1146:             .Top       = 3
1147:             .Width     = 80
1148:             .ForeColor = RGB(90, 90, 90)
1149:             .Visible   = .T.
1150:         ENDWITH
1151: 
1152:         loc_oCnt.AddObject("txt_4c_PrzEnts", "TextBox")
1153:         WITH loc_oCnt.txt_4c_PrzEnts
1154:             .Left          = 3
1155:             .Top           = 20
1156:             .Width         = 80
1157:             .Margin        = 0
1158:             .SpecialEffect = 1
1159:             .ForeColor     = RGB(0, 0, 0)
1160:             .BorderColor   = RGB(100, 100, 100)
1161:             .NullDisplay   = "//"
1162:             .Visible       = .T.
1163:         ENDWITH
1164:         IF loc_lTemCursorPai
1165:             loc_oCnt.txt_4c_PrzEnts.ControlSource = "TprMvCab.PRZCLIS"
1166:         ENDIF
1167:         BINDEVENT(loc_oCnt.txt_4c_PrzEnts, "When",     THIS, "PadraoIncluirAlterarWhen")
1168:         BINDEVENT(loc_oCnt.txt_4c_PrzEnts, "LostFocus", THIS, "PrzEntsLostFocus")
1169:     ENDPROC
1170: 
1171:     *==========================================================================
1172:     * EntregasWhen - "Return Inlist(ThisForm.pcEscolha, 'INSERIR')" do
1173:     * legado (getEntregas.When) - UNICO dos 4 campos de data desta fase que
1174:     * so libera em INSERIR (os outros liberam INSERIR E ALTERAR). Depois do
1175:     * registro incluido, Prz. Entrega so muda pelo cmdEntrega (Fase 4,
1176:     * CmdEntregaClick), que grava TprMvCab.PrazoEnts e espelha no campo.
1177:     *
1178:     * PUBLIC: alvo de BINDEVENT("When").
1179:     *==========================================================================
1180:     FUNCTION EntregasWhen()
1181:         RETURN INLIST(THIS.this_cPcEscolha, "INSERIR")
1182:     ENDFUNC
1183: 
1184:     *==========================================================================
1185:     * ValidarDataMinima - "If Not IsEmpty(This.Value) And This.Value <
1186:     * Ctod('01/01/1900') / MessageBox('Data incorreta. Informe uma data
1187:     * Valida!!!!',0+16,'') / Return .f. / Endif" do legado - texto IDENTICO
1188:     * em getEmiss.Valid, getEntregas.Valid, getRecepcaos.Valid e
1189:     * getPrzEnts.Valid (compartilhado pelos quatro). MESSAGEBOX legado ->
1190:     * MsgAviso (validacao de UI, nao erro tecnico - regra do projeto).
1191:     *
1192:     * PROTECTED: chamado pelos handlers de LostFocus abaixo, nunca alvo
1193:     * direto de BINDEVENT.
1194:     *==========================================================================
1195:     PROTECTED FUNCTION ValidarDataMinima(par_oTxt)
1196:         LOCAL loc_lValido
1197:         loc_lValido = .T.
1198: 
1199:         IF !EMPTY(par_oTxt.Value) AND par_oTxt.Value < CTOD("01/01/1900")
1200:             MsgAviso("Data incorreta. Informe uma data v" + CHR(225) + "lida!!!!", ;
1201:                 "Aten" + CHR(231) + CHR(227) + "o")
1202:             loc_lValido = .F.
1203:         ENDIF
1204: 
1205:         RETURN loc_lValido
1206:     ENDFUNC
1207: 
1208:     *==========================================================================
1209:     * EmissLostFocus/EntregasLostFocus/RecepcaosLostFocus/PrzEntsLostFocus -
1210:     * equivalentes ao Valid legado (ao sair do campo - regra #47), cada um
1211:     * delegando a ValidarDataMinima() com o TextBox correspondente.
1212:     *
1213:     * PUBLIC: alvo de BINDEVENT("LostFocus").
1214:     *==========================================================================
1215:     PROCEDURE EmissLostFocus()
1216:         THIS.ValidarDataMinima(THIS.cnt_4c_Emiss.txt_4c_Emiss)
1217:     ENDPROC
1218: 
1219:     PROCEDURE EntregasLostFocus()
1220:         THIS.ValidarDataMinima(THIS.cnt_4c_Entregas.txt_4c_Entregas)
1221:     ENDPROC
1222: 
1223:     PROCEDURE RecepcaosLostFocus()
1224:         THIS.ValidarDataMinima(THIS.cnt_4c_Recepcaos.txt_4c_Recepcaos)
1225:     ENDPROC
1226: 
1227:     PROCEDURE PrzEntsLostFocus()
1228:         THIS.ValidarDataMinima(THIS.cnt_4c_PrzEnts.txt_4c_PrzEnts)
1229:     ENDPROC
1230: 
1231:     *==========================================================================
1232:     * AvisarLegadoNaoPortado - mesmo padrao de FormSigOpChi/Formsigopfis: a
1233:     * acao depende de um "Do Form"/funcao do legado que nao veio no acervo
1234:     * desta migracao. Usado so DEPOIS de tentar de verdade (CREATEOBJECT no
1235:     * CATCH, ou guarda explicita) - nunca no lugar da tentativa.
1236:     *==========================================================================
1237:     PROTECTED PROCEDURE AvisarLegadoNaoPortado(par_cDependencia, par_cAcao)
1238:         MsgAviso("Esta a" + CHR(231) + CHR(227) + "o depende de " + ;
1239:             ALLTRIM(par_cDependencia) + ", que n" + CHR(227) + "o veio no " + ;
1240:             "acervo migrado." + CHR(13) + CHR(13) + ;
1241:             "N" + CHR(227) + "o realizado: " + ALLTRIM(par_cAcao) + ".", ;
1242:             "Recurso Indispon" + CHR(237) + "vel")
1243:     ENDPROC
1244: 
1245:     *==========================================================================
1246:     * ConfigurarVolumes - cntVolumes (cnt_4c_Volumes): "Transporte" - 5
1247:     * campos de peso/volume do movimento. Geometria do dump (layout.json/
1248:     * sigopinf_form_codigo_fonte.txt SECAO 2). Todos com Alignment = 3
1249:     * (automatico - numerico alinha a direita) e ControlSource direto em
1250:     * TprMvCab, como no legado.
1251:     *==========================================================================
1252:     PROTECTED PROCEDURE ConfigurarVolumes()
1253:         LOCAL loc_oCnt, loc_lTemCursorPai
1254:         loc_lTemCursorPai = USED("TprMvCab")
1255: 
1256:         THIS.AddObject("cnt_4c_Volumes", "Container")
1257:         loc_oCnt = THIS.cnt_4c_Volumes
1258:         WITH loc_oCnt
1259:             .Top         = 264
1260:             .Left        = 488
1261:             .Width       = 509
1262:             .Height      = 66
1263:             .BackStyle   = 0
1264:             .BorderWidth = 0
1265:             .Visible     = .T.
1266:         ENDWITH
1267: 
1268:         loc_oCnt.AddObject("lbl_4c_Label16", "Label")
1269:         WITH loc_oCnt.lbl_4c_Label16
1270:             .FontBold  = .T.
1271:             .FontName  = "Tahoma"
1272:             .FontSize  = 8
1273:             .BackStyle = 0
1274:             .Alignment = 0
1275:             .AutoSize  = .F.
1276:             .Caption   = "Transporte"
1277:             .Left      = 3
1278:             .Top       = 3
1279:             .Width     = 100
1280:             .ForeColor = RGB(90, 90, 90)
1281:             .Visible   = .T.
1282:         ENDWITH
1283: 
1284:         loc_oCnt.AddObject("lbl_4c_LblQtds", "Label")
1285:         WITH loc_oCnt.lbl_4c_LblQtds
1286:             .FontName  = "Tahoma"
1287:             .FontSize  = 8
1288:             .BackStyle = 0
1289:             .Alignment = 0
1290:             .AutoSize  = .F.
1291:             .Caption   = "Qtde."
1292:             .Left      = 3

*-- Linhas 1315 a 1515:
1315:         IF loc_lTemCursorPai
1316:             loc_oCnt.txt_4c_Qtds.ControlSource = "TprMvCab.Qtdes"
1317:         ENDIF
1318:         BINDEVENT(loc_oCnt.txt_4c_Qtds, "When", THIS, "VolumesWhen")
1319: 
1320:         loc_oCnt.AddObject("lbl_4c_LblEspes", "Label")
1321:         WITH loc_oCnt.lbl_4c_LblEspes
1322:             .FontName  = "Tahoma"
1323:             .FontSize  = 8
1324:             .BackStyle = 0
1325:             .Alignment = 0
1326:             .AutoSize  = .F.
1327:             .Caption   = "Esp" + CHR(233) + "cie"
1328:             .Left      = 57
1329:             .Top       = 23
1330:             .Width     = 85
1331:             .ForeColor = RGB(90, 90, 90)
1332:             .Visible   = .T.
1333:         ENDWITH
1334: 
1335:         loc_oCnt.AddObject("txt_4c_Espes", "TextBox")
1336:         WITH loc_oCnt.txt_4c_Espes
1337:             .Alignment     = 3
1338:             .MaxLength     = 10
1339:             .Left          = 57
1340:             .Top           = 40
1341:             .Width         = 87
1342:             .Height        = 23
1343:             .Margin        = 0
1344:             .SpecialEffect = 1
1345:             .ForeColor     = RGB(0, 0, 0)
1346:             .BorderColor   = RGB(100, 100, 100)
1347:             .Visible       = .T.
1348:         ENDWITH
1349:         IF loc_lTemCursorPai
1350:             loc_oCnt.txt_4c_Espes.ControlSource = "TprMvCab.Espes"
1351:         ENDIF
1352:         BINDEVENT(loc_oCnt.txt_4c_Espes, "When", THIS, "VolumesWhen")
1353: 
1354:         loc_oCnt.AddObject("lbl_4c_LblPLiqs", "Label")
1355:         WITH loc_oCnt.lbl_4c_LblPLiqs
1356:             .FontName  = "Tahoma"
1357:             .FontSize  = 8
1358:             .BackStyle = 0
1359:             .Alignment = 0
1360:             .AutoSize  = .F.
1361:             .Caption   = "Peso L" + CHR(237) + "quido"
1362:             .Left      = 147
1363:             .Top       = 23
1364:             .Width     = 75
1365:             .ForeColor = RGB(90, 90, 90)
1366:             .Visible   = .T.
1367:         ENDWITH
1368: 
1369:         loc_oCnt.AddObject("txt_4c_PLiqs", "TextBox")
1370:         WITH loc_oCnt.txt_4c_PLiqs
1371:             .Alignment     = 3
1372:             .InputMask     = "99,999.99"
1373:             .Left          = 147
1374:             .Top           = 40
1375:             .Width         = 73
1376:             .Height        = 23
1377:             .Margin        = 0
1378:             .SpecialEffect = 1
1379:             .ForeColor     = RGB(0, 0, 0)
1380:             .BorderColor   = RGB(100, 100, 100)
1381:             .Visible       = .T.
1382:         ENDWITH
1383:         IF loc_lTemCursorPai
1384:             loc_oCnt.txt_4c_PLiqs.ControlSource = "TprMvCab.PLiqs"
1385:         ENDIF
1386:         BINDEVENT(loc_oCnt.txt_4c_PLiqs, "When", THIS, "VolumesWhen")
1387: 
1388:         loc_oCnt.AddObject("lbl_4c_LblPBrus", "Label")
1389:         WITH loc_oCnt.lbl_4c_LblPBrus
1390:             .FontName  = "Tahoma"
1391:             .FontSize  = 8
1392:             .BackStyle = 0
1393:             .Alignment = 0
1394:             .AutoSize  = .F.
1395:             .Caption   = "Peso Bruto"
1396:             .Left      = 223
1397:             .Top       = 23
1398:             .Width     = 75
1399:             .ForeColor = RGB(90, 90, 90)
1400:             .Visible   = .T.
1401:         ENDWITH
1402: 
1403:         loc_oCnt.AddObject("txt_4c_PBrus", "TextBox")
1404:         WITH loc_oCnt.txt_4c_PBrus
1405:             .Alignment     = 3
1406:             .InputMask     = "99,999.99"
1407:             .Left          = 223
1408:             .Top           = 40
1409:             .Width         = 73
1410:             .Height        = 23
1411:             .Margin        = 0
1412:             .SpecialEffect = 1
1413:             .ForeColor     = RGB(0, 0, 0)
1414:             .BorderColor   = RGB(100, 100, 100)
1415:             .Visible       = .T.
1416:         ENDWITH
1417:         IF loc_lTemCursorPai
1418:             loc_oCnt.txt_4c_PBrus.ControlSource = "TprMvCab.PBrus"
1419:         ENDIF
1420:         BINDEVENT(loc_oCnt.txt_4c_PBrus, "When", THIS, "VolumesWhen")
1421: 
1422:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
1423:         WITH loc_oCnt.lbl_4c_Label1
1424:             .FontName  = "Tahoma"
1425:             .FontSize  = 8
1426:             .BackStyle = 0
1427:             .Alignment = 0
1428:             .AutoSize  = .F.
1429:             .Caption   = "Valor Transporte"
1430:             .Left      = 299
1431:             .Top       = 23
1432:             .Width     = 100
1433:             .ForeColor = RGB(90, 90, 90)
1434:             .Visible   = .T.
1435:         ENDWITH
1436: 
1437:         loc_oCnt.AddObject("txt_4c_ValTrans", "TextBox")
1438:         WITH loc_oCnt.txt_4c_ValTrans
1439:             .Alignment     = 3
1440:             .InputMask     = "999,999.99"
1441:             .Left          = 299
1442:             .Top           = 40
1443:             .Width         = 90
1444:             .Height        = 23
1445:             .Margin        = 0
1446:             .SpecialEffect = 1
1447:             .ForeColor     = RGB(0, 0, 0)
1448:             .BorderColor   = RGB(100, 100, 100)
1449:             .Visible       = .T.
1450:         ENDWITH
1451:         IF loc_lTemCursorPai
1452:             loc_oCnt.txt_4c_ValTrans.ControlSource = "TprMvCab.ValTrans"
1453:         ENDIF
1454:         BINDEVENT(loc_oCnt.txt_4c_ValTrans, "When", THIS, "VolumesWhen")
1455:     ENDPROC
1456: 
1457:     *==========================================================================
1458:     * VolumesWhen - "Return Inlist(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')"
1459:     * do legado, texto IDENTICO nos 5 campos de cntVolumes (getQtds/getEspes/
1460:     * getPLiqs/getPBrus/getValTrans.When). Mesmo texto de PadraoIncluirAlterarWhen,
1461:     * mas com nome proprio para documentar a origem (grep direto pelo nome do
1462:     * container na auditoria).
1463:     *
1464:     * PUBLIC: alvo de BINDEVENT("When").
1465:     *==========================================================================
1466:     FUNCTION VolumesWhen()
1467:         RETURN INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
1468:     ENDFUNC
1469: 
1470:     *==========================================================================
1471:     * ConfigurarObservacao - cntObservacao (cnt_4c_Observacao): campo de
1472:     * codigo/texto da observacao do movimento + botao de multiplas
1473:     * observacoes. Geometria do dump.
1474:     *==========================================================================
1475:     PROTECTED PROCEDURE ConfigurarObservacao()
1476:         LOCAL loc_oCnt, loc_lTemCursorPai
1477:         loc_lTemCursorPai = USED("TprMvCab")
1478: 
1479:         THIS.AddObject("cnt_4c_Observacao", "Container")
1480:         loc_oCnt = THIS.cnt_4c_Observacao
1481:         WITH loc_oCnt
1482:             .Top         = 228
1483:             .Left        = 12
1484:             .Width       = 528
1485:             .Height      = 303
1486:             .BackStyle   = 0
1487:             .BorderWidth = 0
1488:             .Visible     = .T.
1489:         ENDWITH
1490: 
1491:         loc_oCnt.AddObject("lbl_4c_LblObservas", "Label")
1492:         WITH loc_oCnt.lbl_4c_LblObservas
1493:             .FontBold  = .T.
1494:             .FontName  = "Tahoma"
1495:             .FontSize  = 8
1496:             .BackStyle = 0
1497:             .Alignment = 0
1498:             .AutoSize  = .F.
1499:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
1500:             .Left      = 3
1501:             .Top       = 23
1502:             .Width     = 85
1503:             .ForeColor = RGB(90, 90, 90)
1504:             .Visible   = .T.
1505:         ENDWITH
1506: 
1507:         loc_oCnt.AddObject("txt_4c_CodObs", "TextBox")
1508:         WITH loc_oCnt.txt_4c_CodObs
1509:             .Alignment     = 3
1510:             .InputMask     = "999"
1511:             .Left          = 92
1512:             .Top           = 19
1513:             .Width         = 32
1514:             .Height        = 23
1515:             .Margin        = 0

*-- Linhas 1522 a 1695:
1522:         IF loc_lTemCursorPai
1523:             loc_oCnt.txt_4c_CodObs.ControlSource = "TprMvCab.CodObs"
1524:         ENDIF
1525:         BINDEVENT(loc_oCnt.txt_4c_CodObs, "GotFocus",  THIS, "CodObsGotFocus")
1526:         BINDEVENT(loc_oCnt.txt_4c_CodObs, "LostFocus", THIS, "CodObsLostFocus")
1527:         BINDEVENT(loc_oCnt.txt_4c_CodObs, "When",      THIS, "CodObsWhen")
1528: 
1529:         loc_oCnt.AddObject("obj_4c_GetDesObs", "EditBox")
1530:         WITH loc_oCnt.obj_4c_GetDesObs
1531:             .FontSize      = 8
1532:             .Left          = 3
1533:             .Top           = 46
1534:             .Width         = 453
1535:             .Height        = 254
1536:             .SpecialEffect = 1
1537:             .ForeColor     = RGB(0, 0, 0)
1538:             .BorderColor   = RGB(100, 100, 100)
1539:             .Visible       = .T.
1540:         ENDWITH
1541:         IF loc_lTemCursorPai
1542:             loc_oCnt.obj_4c_GetDesObs.ControlSource = "TprMvCab.obses"
1543:         ENDIF
1544:         BINDEVENT(loc_oCnt.obj_4c_GetDesObs, "When", THIS, "DesObsWhen")
1545: 
1546:         loc_oCnt.AddObject("cmd_4c_BtnMultObs", "CommandButton")
1547:         WITH loc_oCnt.cmd_4c_BtnMultObs
1548:             .Top          = 5
1549:             .Left         = 135
1550:             .Width        = 24
1551:             .Height       = 24
1552:             .Caption      = ""
1553:             .Picture      = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1554:             .ToolTipText  = "Selecionar M" + CHR(250) + "ltiplas Observa" + CHR(231) + CHR(245) + "es"
1555:             .Themes       = .T.
1556:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1557:             .Visible      = .T.
1558:         ENDWITH
1559:         BINDEVENT(loc_oCnt.cmd_4c_BtnMultObs, "Click", THIS, "BtnMultObsObservacaoClick")
1560:     ENDPROC
1561: 
1562:     *==========================================================================
1563:     * CodObsGotFocus - "This.Tag = Str(This.Value, 10)" do legado (getCodObs.
1564:     * GotFocus): guarda o valor de entrada no Tag para o LostFocus saber se
1565:     * o usuario realmente alterou o codigo (evita reabrir o lookup so por
1566:     * entrar/sair do campo sem digitar nada).
1567:     *
1568:     * PUBLIC: alvo de BINDEVENT("GotFocus").
1569:     *==========================================================================
1570:     PROCEDURE CodObsGotFocus()
1571:         LOCAL loc_oTxt
1572:         loc_oTxt = THIS.cnt_4c_Observacao.txt_4c_CodObs
1573:         loc_oTxt.Tag = STR(loc_oTxt.Value, 10)
1574:     ENDPROC
1575: 
1576:     *==========================================================================
1577:     * CodObsWhen - "ThisForm.Antvalu = This.Value / Return Inlist(
1578:     * ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')" do legado (getCodObs.When).
1579:     * Antvalu e bookkeeping do legado (ClassInfo do SIGOPINF - SECAO 4 do
1580:     * dump) sem nenhum consumidor nas secoes de codigo transcritas nesta
1581:     * migracao - a parte que importa (o gate INSERIR/ALTERAR, igual ao dos
1582:     * demais campos) e a unica preservada.
1583:     *
1584:     * PUBLIC: alvo de BINDEVENT("When").
1585:     *==========================================================================
1586:     FUNCTION CodObsWhen()
1587:         RETURN INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
1588:     ENDFUNC
1589: 
1590:     *==========================================================================
1591:     * CodObsLostFocus - equivalente ao getCodObs.Valid legado (regra #47 -
1592:     * lookup de TextBox vai em LostFocus, nao em Valid/KeyPress):
1593:     *
1594:     *   If Not Empty(This.Value) And Not (This.Tag = Str(This.Value, 10))
1595:     *       <monta faixa ObsIni/ObsFins de SigCdOpe/SigCdOop>
1596:     *       <Select Codigos, Descrs From SigCdObs Where Codigos Between ...>
1597:     *       Set Near On / If Not Seek(...) -> fwBuscaSel / Set Near Off
1598:     *       This.Value = crLocalObs.Codigos
1599:     *       ThisForm.MontaObs(...)
1600:     *   EndIf
1601:     *
1602:     * A faixa SigCdOop (override por CFOP, dependente de crSigMvNfi/
1603:     * crSigOpCdd) nao esta disponivel nesta tela ainda (cursores de fases
1604:     * seguintes) - falso seguro: a faixa fica so com o ObsIni/ObsFins de
1605:     * SigCdOpe. fwBuscaSel -> FormBuscaAuxiliar (padrao do projeto).
1606:     *
1607:     * PUBLIC: alvo de BINDEVENT("LostFocus").
1608:     *==========================================================================
1609:     PROCEDURE CodObsLostFocus()
1610:         LOCAL loc_oTxt, loc_nPIni, loc_nPFim, loc_cSQL, loc_nErro, ;
1611:               loc_oBusca, loc_oErro, loc_lAchou
1612: 
1613:         loc_oTxt = THIS.cnt_4c_Observacao.txt_4c_CodObs
1614: 
1615:         IF EMPTY(loc_oTxt.Value) OR loc_oTxt.Tag == STR(loc_oTxt.Value, 10)
1616:             RETURN
1617:         ENDIF
1618: 
1619:         loc_nPIni = 0
1620:         loc_nPFim = 999
1621:         IF USED("TprMvCab")
1622:             loc_cSQL = "SELECT ObsPads, ObsInis, ObsFins FROM SigCdOpe " + ;
1623:                 "WHERE Dopes = " + EscaparSQL(TprMvCab.Dopes)
1624:             loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalOpe")
1625: 
1626:             IF loc_nErro >= 1 AND RECCOUNT("cursor_4c_LocalOpe") > 0
1627:                 loc_nPIni = IIF(!EMPTY(cursor_4c_LocalOpe.ObsInis), cursor_4c_LocalOpe.ObsInis, 0)
1628:                 loc_nPFim = IIF(!EMPTY(cursor_4c_LocalOpe.ObsFins), cursor_4c_LocalOpe.ObsFins, 999)
1629:             ENDIF
1630:             IF USED("cursor_4c_LocalOpe")
1631:                 USE IN cursor_4c_LocalOpe
1632:             ENDIF
1633:         ENDIF
1634: 
1635:         loc_cSQL = "SELECT Codigos, Descrs FROM SigCdObs WHERE Codigos BETWEEN " + ;
1636:             FormatarNumeroSQL(loc_nPIni, 0) + " AND " + FormatarNumeroSQL(loc_nPFim, 0)
1637:         loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalObs")
1638: 
1639:         IF loc_nErro < 1
1640:             MsgErro("Favor reinicializar o processo." + CHR(13) + ;
1641:                 "Falha na conex" + CHR(227) + "o (cursor_4c_LocalObs)", "Erro")
1642:             RETURN
1643:         ENDIF
1644: 
1645:         loc_lAchou = .F.
1646:         IF USED("cursor_4c_LocalObs")
1647:             SELECT cursor_4c_LocalObs
1648:             LOCATE FOR Codigos = loc_oTxt.Value
1649:             loc_lAchou = FOUND()
1650:         ENDIF
1651: 
1652:         IF !loc_lAchou
1653:             loc_oBusca = .NULL.
1654:             TRY
1655:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1656:                     "SigCdObs", "cursor_4c_BuscaObs", "Codigos", ;
1657:                     TRANSFORM(loc_oTxt.Value), "Observa" + CHR(231) + CHR(245) + "es", ;
1658:                     .F., .F., ;
1659:                     "Codigos BETWEEN " + FormatarNumeroSQL(loc_nPIni, 0) + " AND " + ;
1660:                         FormatarNumeroSQL(loc_nPFim, 0))
1661:             CATCH TO loc_oErro
1662:                 MsgErro(loc_oErro.Message, "Erro ao abrir busca de observa" + CHR(231) + CHR(245) + "es")
1663:                 loc_oBusca = .NULL.
1664:             ENDTRY
1665: 
1666:             IF VARTYPE(loc_oBusca) = "O"
1667:                 IF !loc_oBusca.this_lAchouRegistro
1668:                     loc_oBusca.mAddColuna("Codigos", "999", "C" + CHR(243) + "d.")
1669:                     loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
1670:                     loc_oBusca.Show()
1671:                 ENDIF
1672: 
1673:                 IF loc_oBusca.this_lSelecionou
1674:                     loc_oTxt.Value = VAL(loc_oBusca.cCodigoSelecionado)
1675:                 ELSE
1676:                     loc_oTxt.Value = 0
1677:                 ENDIF
1678: 
1679:                 IF USED("cursor_4c_BuscaObs")
1680:                     USE IN cursor_4c_BuscaObs
1681:                 ENDIF
1682:                 loc_oBusca.Release()
1683:             ENDIF
1684:         ENDIF
1685: 
1686:         IF USED("cursor_4c_LocalObs")
1687:             USE IN cursor_4c_LocalObs
1688:         ENDIF
1689: 
1690:         IF !EMPTY(loc_oTxt.Value)
1691:             THIS.MontarObservacaoPadrao(loc_oTxt.Value)
1692:         ENDIF
1693:     ENDPROC
1694: 
1695:     *==========================================================================

*-- Linhas 1703 a 1832:
1703:     *
1704:     * PROTECTED: chamado so por CodObsLostFocus.
1705:     *==========================================================================
1706:     PROTECTED PROCEDURE MontarObservacaoPadrao(par_nCodObs)
1707:         LOCAL loc_cSQL, loc_nErro, loc_cObs, loc_oTxtDesc
1708: 
1709:         loc_cSQL = "SELECT Codigos, Observas FROM SigCdObs WHERE Codigos = " + ;
1710:             FormatarNumeroSQL(par_nCodObs, 0)
1711:         loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdObs")
1712: 
1713:         IF loc_nErro >= 1 AND RECCOUNT("cursor_4c_SigCdObs") > 0
1714:             loc_cObs     = ALLTRIM(TratarNulo(cursor_4c_SigCdObs.Observas, "C"))
1715:             loc_oTxtDesc = THIS.cnt_4c_Observacao.obj_4c_GetDesObs
1716: 
1717:             IF "#" $ loc_cObs OR "$" $ loc_cObs OR "%" $ loc_cObs OR "!" $ loc_cObs
1718:                 THIS.AvisarLegadoNaoPortado("fMontaObs() / grade de itens (TmpOperacao)", ;
1719:                     "completar a observa" + CHR(231) + CHR(227) + "o padr" + CHR(227) + "o com os dados da grade")
1720:             ENDIF
1721: 
1722:             loc_oTxtDesc.Value = loc_cObs
1723:             loc_oTxtDesc.Refresh()
1724:         ENDIF
1725: 
1726:         IF USED("cursor_4c_SigCdObs")
1727:             USE IN cursor_4c_SigCdObs
1728:         ENDIF
1729:     ENDPROC
1730: 
1731:     *==========================================================================
1732:     * DesObsWhen - getDesObs.When legado:
1733:     *   IF fChecaAcesso( padl(crSigCdOpe.nDopes,8,'0'), 'ALTINFO' )
1734:     *       Return !InList(ThisForm.pcEscolha,'EXCLUIR')
1735:     *   Else
1736:     *       Dodefault()     && equivalente ao When padrao do fwmemo -
1737:     *                          mesmo texto dos demais campos (INSERIR/ALTERAR)
1738:     *   Endif
1739:     * Sem crSigCdOpe (cursor do Init legado, fases seguintes), cai direto
1740:     * no ramo "Dodefault()" - e exatamente o que o legado faria se a
1741:     * checagem nao pudesse ser avaliada.
1742:     *
1743:     * PUBLIC: alvo de BINDEVENT("When").
1744:     *==========================================================================
1745:     FUNCTION DesObsWhen()
1746:         IF USED("crSigCdOpe") AND fChecaAcesso(PADL(TRANSFORM(crSigCdOpe.nDopes), 8, "0"), "ALTINFO")
1747:             RETURN !INLIST(THIS.this_cPcEscolha, "EXCLUIR")
1748:         ENDIF
1749: 
1750:         RETURN THIS.VolumesWhen()
1751:     ENDFUNC
1752: 
1753:     *==========================================================================
1754:     * BtnMultObsObservacaoClick - btnMultObs.Valid de cntObservacao (evento
1755:     * "Valid" num fwbtnp - mesma convencao ja adotada na Fase 4 para
1756:     * cmdCotacao/cmdEntrega: bind no "Click", nao no "Valid"):
1757:     *
1758:     *   If (TprMvCab.CodObs > 0)
1759:     *       MessageBox('Para Selecionar Multiplas Observacoes Nao Pode Ser
1760:     *                    Informado o Codigo de Observacao')
1761:     *       ThisForm.cntObservacao.getCodObs.SetFocus
1762:     *       Return .f.
1763:     *   EndIf
1764:     *   Do Form SigOpIns With ThisForm.ParentForm.poDataMgr
1765:     *   ThisForm.cntObservacao.getDesObs.Refresh
1766:     *
1767:     * SigOpIns nao veio no acervo - AvisarLegadoNaoPortado().
1768:     *
1769:     * PUBLIC: alvo de BINDEVENT("Click").
1770:     *==========================================================================
1771:     PROCEDURE BtnMultObsObservacaoClick()
1772:         LOCAL loc_oTxtCod
1773:         loc_oTxtCod = THIS.cnt_4c_Observacao.txt_4c_CodObs
1774: 
1775:         IF loc_oTxtCod.Value > 0
1776:             MsgAviso("Para Selecionar M" + CHR(250) + "ltiplas Observa" + CHR(231) + CHR(245) + "es N" + CHR(227) + "o " + ;
1777:                 "Pode Ser Informado o C" + CHR(243) + "digo de Observa" + CHR(231) + CHR(227) + "o", ;
1778:                 "Aten" + CHR(231) + CHR(227) + "o")
1779:             loc_oTxtCod.SetFocus()
1780:             RETURN
1781:         ENDIF
1782: 
1783:         THIS.AvisarLegadoNaoPortado("Tela de Sele" + CHR(231) + CHR(227) + "o de Observa" + CHR(231) + CHR(245) + "es (SigOpIns)", ;
1784:             "selecionar m" + CHR(250) + "ltiplas observa" + CHR(231) + CHR(245) + "es")
1785:     ENDPROC
1786: 
1787:     *==========================================================================
1788:     * ConfigurarProtocolo - cntProtocolo (cnt_4c_Protocolo): campo unico de
1789:     * protocolo. When identico ao texto de PadraoIncluirAlterarWhen (regra
1790:     * #47/Fase5) - reaproveitado sem duplicar.
1791:     *==========================================================================
1792:     PROTECTED PROCEDURE ConfigurarProtocolo()
1793:         LOCAL loc_oCnt, loc_lTemCursorPai
1794:         loc_lTemCursorPai = USED("TprMvCab")
1795: 
1796:         THIS.AddObject("cnt_4c_Protocolo", "Container")
1797:         loc_oCnt = THIS.cnt_4c_Protocolo
1798:         WITH loc_oCnt
1799:             .Top         = 96
1800:             .Left        = 461
1801:             .Width       = 61
1802:             .Height      = 45
1803:             .BackStyle   = 0
1804:             .BorderWidth = 0
1805:             .Visible     = .T.
1806:         ENDWITH
1807: 
1808:         loc_oCnt.AddObject("lbl_4c_LblProtocolos", "Label")
1809:         WITH loc_oCnt.lbl_4c_LblProtocolos
1810:             .FontName  = "Tahoma"
1811:             .FontSize  = 8
1812:             .BackStyle = 0
1813:             .Alignment = 0
1814:             .AutoSize  = .F.
1815:             .Caption   = "Protocolo"
1816:             .Left      = 3
1817:             .Top       = 3
1818:             .Width     = 55
1819:             .ForeColor = RGB(90, 90, 90)
1820:             .Visible   = .T.
1821:         ENDWITH
1822: 
1823:         loc_oCnt.AddObject("txt_4c_Protocolos", "TextBox")
1824:         WITH loc_oCnt.txt_4c_Protocolos
1825:             .Alignment     = 3
1826:             .Format        = "K"
1827:             .InputMask     = "999999"
1828:             .MaxLength     = 6
1829:             .Left          = 3
1830:             .Top           = 20
1831:             .Width         = 55
1832:             .Height        = 23

*-- Linhas 1839 a 1891:
1839:         IF loc_lTemCursorPai
1840:             loc_oCnt.txt_4c_Protocolos.ControlSource = "TprMvCab.protats"
1841:         ENDIF
1842:         BINDEVENT(loc_oCnt.txt_4c_Protocolos, "When", THIS, "PadraoIncluirAlterarWhen")
1843:     ENDPROC
1844: 
1845:     *==========================================================================
1846:     * ConfigurarEntrega - cntEntrega (cnt_4c_Entrega): conta/nome/cpf-cnpj
1847:     * do destinatario da entrega + botao "Local de Entrega". Os tres campos
1848:     * de conta sao intercambiaveis no legado (preencher um resolve os
1849:     * outros dois) - ver ContasLostFocus/DContaLostFocus/CpfsLostFocus.
1850:     *==========================================================================
1851:     PROTECTED PROCEDURE ConfigurarEntrega()
1852:         LOCAL loc_oCnt, loc_lTemCursorPai
1853:         loc_lTemCursorPai = USED("TprMvCab")
1854: 
1855:         THIS.AddObject("cnt_4c_Entrega", "Container")
1856:         loc_oCnt = THIS.cnt_4c_Entrega
1857:         WITH loc_oCnt
1858:             .Top         = 192
1859:             .Left        = 489
1860:             .Width       = 504
1861:             .Height      = 66
1862:             .BackStyle   = 0
1863:             .BorderWidth = 0
1864:             .Visible     = .T.
1865:         ENDWITH
1866: 
1867:         loc_oCnt.AddObject("lbl_4c_LblEntregas", "Label")
1868:         WITH loc_oCnt.lbl_4c_LblEntregas
1869:             .FontBold  = .T.
1870:             .FontName  = "Tahoma"
1871:             .FontSize  = 8
1872:             .BackStyle = 0
1873:             .Alignment = 0
1874:             .AutoSize  = .F.
1875:             .Caption   = "Entrega"
1876:             .Left      = 3
1877:             .Top       = 3
1878:             .Width     = 85
1879:             .ForeColor = RGB(90, 90, 90)
1880:             .Visible   = .T.
1881:         ENDWITH
1882: 
1883:         loc_oCnt.AddObject("lbl_4c_LblContas", "Label")
1884:         WITH loc_oCnt.lbl_4c_LblContas
1885:             .FontName  = "Tahoma"
1886:             .FontSize  = 8
1887:             .BackStyle = 0
1888:             .Alignment = 0
1889:             .AutoSize  = .F.
1890:             .Caption   = "Conta"
1891:             .Left      = 3

*-- Linhas 1943 a 2182:
1943:         IF loc_lTemCursorPai
1944:             loc_oCnt.txt_4c_Contas.ControlSource = "TprMvCab.contaes"
1945:         ENDIF
1946:         BINDEVENT(loc_oCnt.txt_4c_Contas, "LostFocus", THIS, "ContasLostFocus")
1947:         BINDEVENT(loc_oCnt.txt_4c_Contas, "When",      THIS, "PadraoIncluirAlterarWhen")
1948: 
1949:         loc_oCnt.AddObject("txt_4c_Cpfs", "TextBox")
1950:         WITH loc_oCnt.txt_4c_Cpfs
1951:             .Left          = 77
1952:             .Top           = 40
1953:             .Width         = 131
1954:             .Height        = 23
1955:             .Margin        = 0
1956:             .SpecialEffect = 1
1957:             .ForeColor     = RGB(0, 0, 0)
1958:             .BorderColor   = RGB(100, 100, 100)
1959:             .Visible       = .T.
1960:         ENDWITH
1961:         BINDEVENT(loc_oCnt.txt_4c_Cpfs, "LostFocus", THIS, "CpfsLostFocus")
1962:         BINDEVENT(loc_oCnt.txt_4c_Cpfs, "When",      THIS, "EntregaCamposLiberadosWhen")
1963: 
1964:         loc_oCnt.AddObject("txt_4c_DConta", "TextBox")
1965:         WITH loc_oCnt.txt_4c_DConta
1966:             .Left          = 210
1967:             .Top           = 40
1968:             .Width         = 285
1969:             .Height        = 23
1970:             .Margin        = 0
1971:             .SpecialEffect = 1
1972:             .ForeColor     = RGB(0, 0, 0)
1973:             .BorderColor   = RGB(100, 100, 100)
1974:             .Visible       = .T.
1975:         ENDWITH
1976:         BINDEVENT(loc_oCnt.txt_4c_DConta, "LostFocus", THIS, "DContaLostFocus")
1977:         BINDEVENT(loc_oCnt.txt_4c_DConta, "When",      THIS, "EntregaCamposLiberadosWhen")
1978: 
1979:         loc_oCnt.AddObject("cmd_4c_CmdEntrega", "CommandButton")
1980:         WITH loc_oCnt.cmd_4c_CmdEntrega
1981:             .Top             = 0
1982:             .Left            = 455
1983:             .Width           = 24
1984:             .Height          = 24
1985:             .Caption         = ""
1986:             .Picture         = gc_4c_CaminhoIcones + "geral_relogio_26.jpg"
1987:             .ToolTipText     = "Local de Entrega"
1988:             .Themes          = .T.
1989:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_relogio_26.jpg"
1990:             .Visible         = .T.
1991:         ENDWITH
1992:         BINDEVENT(loc_oCnt.cmd_4c_CmdEntrega, "Click", THIS, "EntregaLocalClick")
1993:     ENDPROC
1994: 
1995:     *==========================================================================
1996:     * ContasLostFocus/DContaLostFocus/CpfsLostFocus - equivalentes ao Valid/
1997:     * LostFocus legado de getContas/getDConta/getCpfs (regra #47). Os tres
1998:     * campos sao intercambiaveis: preencher QUALQUER um localiza a conta em
1999:     * SigCdCli e preenche os outros dois.
2000:     *
2001:     * fAcessoContas(..., pSt1=.NULL., pSt2=.NULL.) - modo BACKEND (regra do
2002:     * projeto: AcessoContas() NUNCA em modo lookup-UI, que auto-popula com o
2003:     * PRIMEIRO registro que contem o valor digitado - aqui ele so confere
2004:     * ACESSO, sem objeto de TextBox nenhum).
2005:     *
2006:     * Guard this_cUltimo<X>LostFocusValidado: LostFocus dispara mesmo sem o
2007:     * usuario mudar o valor (diferente do Valid legado, que so dispara na
2008:     * mudanca) - sem o guard, sair e voltar ao campo sem digitar nada
2009:     * revalidaria o acesso e reabriria o lookup a cada vez.
2010:     *
2011:     * PUBLIC: alvo de BINDEVENT("LostFocus").
2012:     *==========================================================================
2013:     PROCEDURE ContasLostFocus()
2014:         LOCAL loc_oTxt, loc_cValor
2015: 
2016:         loc_oTxt   = THIS.cnt_4c_Entrega.txt_4c_Contas
2017:         loc_cValor = ALLTRIM(TRANSFORM(loc_oTxt.Value))
2018: 
2019:         IF loc_cValor == THIS.this_cUltimoContasLostFocusValidado
2020:             RETURN
2021:         ENDIF
2022: 
2023:         IF EMPTY(loc_cValor)
2024:             THIS.LimparContaEntrega()
2025:             THIS.this_cUltimoContasLostFocusValidado = loc_cValor
2026:             RETURN
2027:         ENDIF
2028: 
2029:         IF !fAcessoContas(gc_4c_UsuarioLogado, "", "C", loc_cValor, .NULL., .NULL.)
2030:             MsgAviso("Acesso Negado!!!", "Aten" + CHR(231) + CHR(227) + "o")
2031:             THIS.LimparContaEntrega()
2032:             THIS.this_cUltimoContasLostFocusValidado = loc_cValor
2033:             RETURN
2034:         ENDIF
2035: 
2036:         IF !THIS.BuscarContaEntrega("IClis", loc_cValor)
2037:             THIS.AbrirBuscaContaEntrega(loc_cValor, "IClis")
2038:         ENDIF
2039: 
2040:         THIS.this_cUltimoContasLostFocusValidado = loc_cValor
2041:     ENDPROC
2042: 
2043:     PROCEDURE DContaLostFocus()
2044:         LOCAL loc_oTxt, loc_cValor
2045: 
2046:         loc_oTxt   = THIS.cnt_4c_Entrega.txt_4c_DConta
2047:         loc_cValor = ALLTRIM(TRANSFORM(loc_oTxt.Value))
2048: 
2049:         IF loc_cValor == THIS.this_cUltimoDContaLostFocusValidado
2050:             RETURN
2051:         ENDIF
2052: 
2053:         IF EMPTY(loc_cValor)
2054:             THIS.this_cUltimoDContaLostFocusValidado = loc_cValor
2055:             RETURN
2056:         ENDIF
2057: 
2058:         IF !fAcessoContas(gc_4c_UsuarioLogado, "", "D", loc_cValor, .NULL., .NULL.)
2059:             MsgAviso("Acesso Negado!!!", "Aten" + CHR(231) + CHR(227) + "o")
2060:             THIS.LimparContaEntrega()
2061:             THIS.this_cUltimoDContaLostFocusValidado = loc_cValor
2062:             RETURN
2063:         ENDIF
2064: 
2065:         IF !THIS.BuscarContaEntrega("RClis", loc_cValor)
2066:             THIS.AbrirBuscaContaEntrega(loc_cValor, "RClis")
2067:         ENDIF
2068: 
2069:         THIS.this_cUltimoDContaLostFocusValidado = loc_cValor
2070:     ENDPROC
2071: 
2072:     PROCEDURE CpfsLostFocus()
2073:         LOCAL loc_oTxt, loc_cCgc, loc_cCgcFmt
2074: 
2075:         loc_oTxt = THIS.cnt_4c_Entrega.txt_4c_Cpfs
2076:         loc_cCgc = STRTRAN(STRTRAN(STRTRAN(ALLTRIM(TRANSFORM(loc_oTxt.Value)), ".", ""), "-", ""), "/", "")
2077: 
2078:         IF loc_cCgc == THIS.this_cUltimoCpfsLostFocusValidado
2079:             RETURN
2080:         ENDIF
2081: 
2082:         IF EMPTY(loc_cCgc)
2083:             THIS.this_cUltimoCpfsLostFocusValidado = loc_cCgc
2084:             RETURN
2085:         ENDIF
2086: 
2087:         loc_cCgcFmt = IIF(LEN(loc_cCgc) <> 14, TRANSFORM(loc_cCgc, "@R 999.999.999-99"), ;
2088:             TRANSFORM(loc_cCgc, "@R 99.999.999/9999-99"))
2089:         loc_oTxt.Value = loc_cCgcFmt
2090: 
2091:         IF !THIS.BuscarContaEntrega("Cpfs", loc_cCgcFmt)
2092:             THIS.AbrirBuscaContaEntrega(loc_cCgcFmt, "Cpfs")
2093:         ENDIF
2094: 
2095:         THIS.this_cUltimoCpfsLostFocusValidado = loc_cCgc
2096:     ENDPROC
2097: 
2098:     *==========================================================================
2099:     * BuscarContaEntrega - match EXATO em SigCdCli pelo campo informado
2100:     * (Iclis/Rclis/Cpfs) - equivalente ao "Cursorquery('SigCdCli', 'CrTmpCli',
2101:     * <campo>, <valor>)" do legado. Devolve .T. se achou (e ja preencheu os
2102:     * tres campos, sob as checagens de ValidarContaEntregaEncontrada).
2103:     *
2104:     * PROTECTED: chamado so pelos LostFocus acima.
2105:     *==========================================================================
2106:     PROTECTED FUNCTION BuscarContaEntrega(par_cCampo, par_cValor)
2107:         LOCAL loc_cSQL, loc_nErro, loc_lAchou
2108:         loc_lAchou = .F.
2109: 
2110:         loc_cSQL = "SELECT TOP 1 IClis, RClis, Cpfs, Situas FROM SigCdCli WHERE " + ;
2111:             par_cCampo + " = " + EscaparSQL(par_cValor)
2112:         loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaContaEntrega")
2113: 
2114:         IF loc_nErro >= 1 AND RECCOUNT("cursor_4c_BuscaContaEntrega") > 0
2115:             IF THIS.ValidarContaEntregaEncontrada("cursor_4c_BuscaContaEntrega")
2116:                 THIS.PreencherContaEntrega(ALLTRIM(cursor_4c_BuscaContaEntrega.IClis), ;
2117:                     ALLTRIM(cursor_4c_BuscaContaEntrega.RClis), ALLTRIM(cursor_4c_BuscaContaEntrega.Cpfs))
2118:             ELSE
2119:                 THIS.LimparContaEntrega()
2120:             ENDIF
2121:             loc_lAchou = .T.
2122:         ENDIF
2123: 
2124:         IF USED("cursor_4c_BuscaContaEntrega")
2125:             USE IN cursor_4c_BuscaContaEntrega
2126:         ENDIF
2127: 
2128:         RETURN loc_lAchou
2129:     ENDFUNC
2130: 
2131:     *==========================================================================
2132:     * AbrirBuscaContaEntrega - sem match exato, abre o picker canonico
2133:     * (regra #36/#37) com busca parcial pelo mesmo campo.
2134:     *
2135:     * PROTECTED: chamado so pelos LostFocus acima.
2136:     *==========================================================================
2137:     PROTECTED PROCEDURE AbrirBuscaContaEntrega(par_cValor, par_cCampo)
2138:         LOCAL loc_oBusca, loc_oErro
2139: 
2140:         loc_oBusca = .NULL.
2141:         TRY
2142:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2143:                 "SigCdCli", "cursor_4c_BuscaContaEntrega", par_cCampo, par_cValor, ;
2144:                 "Conta de Entrega")
2145:         CATCH TO loc_oErro
2146:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de contas")
2147:             loc_oBusca = .NULL.
2148:         ENDTRY
2149: 
2150:         IF VARTYPE(loc_oBusca) = "O"
2151:             IF !loc_oBusca.this_lAchouRegistro
2152:                 loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
2153:                 loc_oBusca.mAddColuna("RClis", "", "Nome")
2154:                 loc_oBusca.mAddColuna("Cpfs",  "", "CPF/CNPJ")
2155:                 loc_oBusca.Show()
2156:             ENDIF
2157: 
2158:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaContaEntrega")
2159:                 IF THIS.ValidarContaEntregaEncontrada("cursor_4c_BuscaContaEntrega")
2160:                     THIS.PreencherContaEntrega(ALLTRIM(cursor_4c_BuscaContaEntrega.IClis), ;
2161:                         ALLTRIM(cursor_4c_BuscaContaEntrega.RClis), ALLTRIM(cursor_4c_BuscaContaEntrega.Cpfs))
2162:                 ELSE
2163:                     THIS.LimparContaEntrega()
2164:                 ENDIF
2165:             ELSE
2166:                 THIS.LimparContaEntrega()
2167:             ENDIF
2168: 
2169:             IF USED("cursor_4c_BuscaContaEntrega")
2170:                 USE IN cursor_4c_BuscaContaEntrega
2171:             ENDIF
2172:             loc_oBusca.Release()
2173:         ENDIF
2174:     ENDPROC
2175: 
2176:     *==========================================================================
2177:     * ValidarContaEntregaEncontrada - as duas checagens extras do legado
2178:     * ("If crSigCdOpe.ExibSits=4" - situacao da conta em SigCdCst, e
2179:     * "If CrSigOpCdc.ChCtEntrs" - conta de entrega tem que ser diferente da
2180:     * conta de origem/destino). Ambas dependem de cursores que esta tela
2181:     * ainda nao carrega (CursorQuery do Init legado, fases seguintes) -
2182:     * falso seguro: sem o cursor, a checagem fica de fora e a conta e

*-- Linhas 2201 a 2386:
2201:                     IF cursor_4c_SituacaoConta.DispMovs = 1
2202:                         loc_cMsg = ALLTRIM(IIF(!EMPTY(cursor_4c_SituacaoConta.Descr2s), ;
2203:                             cursor_4c_SituacaoConta.Descr2s, cursor_4c_SituacaoConta.Descrs))
2204:                         MsgAviso(loc_cSituas + " - " + loc_cMsg, "Situa" + CHR(231) + CHR(227) + "o")
2205: 
2206:                         IF cursor_4c_SituacaoConta.BlqMovs = 1
2207:                             MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o Bloqueada pela Situa" + CHR(231) + CHR(227) + "o da Conta...", ;
2208:                                 "Aten" + CHR(231) + CHR(227) + "o")
2209:                             loc_lAceita = .F.
2210:                         ENDIF
2211:                     ENDIF
2212: 
2213:                     IF loc_lAceita AND USED("TprMvCab") AND TprMvCab.ValVars < 0 AND cursor_4c_SituacaoConta.BlqDescs = 1
2214:                         loc_cMsg = ALLTRIM(IIF(!EMPTY(cursor_4c_SituacaoConta.Descr2s), ;
2215:                             cursor_4c_SituacaoConta.Descr2s, cursor_4c_SituacaoConta.Descrs))
2216:                         MsgAviso(loc_cSituas + " - " + loc_cMsg + CHR(13) + ;
2217:                             "Desconto Bloqueado Pela Situa" + CHR(231) + CHR(227) + "o da Conta", "Situa" + CHR(231) + CHR(227) + "o")
2218:                         loc_lAceita = .F.
2219:                     ENDIF
2220:                 ENDIF
2221: 
2222:                 IF USED("cursor_4c_SituacaoConta")
2223:                     USE IN cursor_4c_SituacaoConta
2224:                 ENDIF
2225:             ENDIF
2226:         ENDIF
2227: 
2228:         IF loc_lAceita AND USED("crSigOpCdc") AND USED("TprMvCab") AND USED(par_cCursor)
2229:             loc_cIClis = ALLTRIM(TratarNulo(EVALUATE(par_cCursor + ".IClis"), "C"))
2230: 
2231:             IF (crSigOpCdc.ChCtEntrs = 1 AND loc_cIClis == ALLTRIM(TprMvCab.ContaDs)) ;
2232:                OR (crSigOpCdc.ChCtEntrs = 2 AND loc_cIClis == ALLTRIM(TprMvCab.ContaOs))
2233:                 MsgAviso("Conta de Entrega Tem que ser diferente da Conta de " + ;
2234:                     IIF(crSigOpCdc.ChCtEntrs = 1, "Destino", "Origem"), "Aten" + CHR(231) + CHR(227) + "o")
2235:                 loc_lAceita = .F.
2236:             ENDIF
2237:         ENDIF
2238: 
2239:         RETURN loc_lAceita
2240:     ENDFUNC
2241: 
2242:     *==========================================================================
2243:     * PreencherContaEntrega/LimparContaEntrega - preenche/limpa os tres
2244:     * campos do container E a propria TprMvCab.ContaEs (os tres campos
2245:     * sincronizados, igual ao ".Refresh" dos tres no final de cada Valid
2246:     * legado).
2247:     *
2248:     * PROTECTED: chamados pelos metodos de busca acima.
2249:     *==========================================================================
2250:     PROTECTED PROCEDURE PreencherContaEntrega(par_cIClis, par_cRClis, par_cCpfs)
2251:         THIS.cnt_4c_Entrega.txt_4c_Contas.Value = par_cIClis
2252:         THIS.cnt_4c_Entrega.txt_4c_DConta.Value = par_cRClis
2253:         THIS.cnt_4c_Entrega.txt_4c_Cpfs.Value   = par_cCpfs
2254: 
2255:         IF USED("TprMvCab")
2256:             REPLACE ContaEs WITH par_cIClis IN TprMvCab
2257:         ENDIF
2258:     ENDPROC
2259: 
2260:     PROTECTED PROCEDURE LimparContaEntrega()
2261:         THIS.cnt_4c_Entrega.txt_4c_Contas.Value = ""
2262:         THIS.cnt_4c_Entrega.txt_4c_DConta.Value = ""
2263:         THIS.cnt_4c_Entrega.txt_4c_Cpfs.Value   = ""
2264: 
2265:         IF USED("TprMvCab")
2266:             REPLACE ContaEs WITH "" IN TprMvCab
2267:         ENDIF
2268:     ENDPROC
2269: 
2270:     *==========================================================================
2271:     * EntregaCamposLiberadosWhen - "Return Inlist(ThisForm.pcEscolha,
2272:     * 'INSERIR', 'ALTERAR') And Empty(ThisForm.cntEntrega.getContas.Value)"
2273:     * do legado - texto IDENTICO em getDConta.When e getCpfs.When: so
2274:     * liberados quando a Conta (codigo) ainda nao foi preenchida (os tres
2275:     * campos sao intercambiaveis, mas o legado da preferencia ao codigo).
2276:     *
2277:     * PUBLIC: alvo de BINDEVENT("When").
2278:     *==========================================================================
2279:     FUNCTION EntregaCamposLiberadosWhen()
2280:         RETURN INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR") ;
2281:             AND EMPTY(THIS.cnt_4c_Entrega.txt_4c_Contas.Value)
2282:     ENDFUNC
2283: 
2284:     *==========================================================================
2285:     * EntregaLocalClick - cntEntrega.cmdEntrega.Valid legado ("Local de
2286:     * Entrega" - mesma convencao da Fase 4 de ligar "Valid" de fwbtnp a
2287:     * "Click"), com o guard do When embutido (CommandButton nao tem When em
2288:     * VFP9 nativo - "Return InList(pcEscolha,'INSERIR','ALTERAR',
2289:     * 'CONSULTAR')" do legado vira guard no topo do handler):
2290:     *
2291:     *   Cursorquery('SigCdCli','crDCompCli','Iclis',TprMvCab.ContaEs,
2292:     *       'Grupos, IClis, RClis')
2293:     *   Do Form SigCdEnd With ..., TprMvCab.LocalEnts
2294:     *   If InList(pcEscolha,'INSERIR','ALTERAR')
2295:     *       fEndEntrega(@laArray, poDataMgr) -> Replace LocalEnts
2296:     *   EndIf
2297:     *
2298:     * SigCdEnd nao veio no acervo - AvisarLegadoNaoPortado() no CATCH da
2299:     * tentativa real. fEndEntrega() resolveria LocalEnts a partir do
2300:     * RESULTADO de SigCdEnd - sem a tela, nao ha resultado confiavel para
2301:     * gravar (o aviso acima ja cobre a ausencia).
2302:     *
2303:     * PUBLIC: alvo de BINDEVENT("Click").
2304:     *==========================================================================
2305:     PROCEDURE EntregaLocalClick()
2306:         LOCAL loc_cSQL, loc_nErro, loc_cGrupos, loc_cIClis, loc_cRClis, loc_oDlg, loc_oErro
2307: 
2308:         IF !INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR", "CONSULTAR") ;
2309:            OR !USED("TprMvCab")
2310:             RETURN
2311:         ENDIF
2312: 
2313:         loc_cSQL = "SELECT Grupos, IClis, RClis FROM SigCdCli WHERE IClis = " + ;
2314:             EscaparSQL(ALLTRIM(TprMvCab.ContaEs))
2315:         loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DCompCli")
2316: 
2317:         IF loc_nErro < 1 OR RECCOUNT("cursor_4c_DCompCli") = 0
2318:             MsgErro("Favor reinicializar o processo." + CHR(13) + ;
2319:                 "Falha na conex" + CHR(227) + "o (SigCdCli)", "Erro")
2320:         ELSE
2321:             loc_cGrupos = ALLTRIM(cursor_4c_DCompCli.Grupos)
2322:             loc_cIClis  = ALLTRIM(cursor_4c_DCompCli.IClis)
2323:             loc_cRClis  = ALLTRIM(cursor_4c_DCompCli.RClis)
2324: 
2325:             TRY
2326:                 loc_oDlg = CREATEOBJECT("FormSigCdEnd", loc_cGrupos, loc_cIClis, loc_cRClis, ;
2327:                     THIS.this_cPcEscolha, TprMvCab.LocalEnts)
2328:                 IF VARTYPE(loc_oDlg) = "O"
2329:                     loc_oDlg.Show()
2330:                 ENDIF
2331:             CATCH TO loc_oErro
2332:                 THIS.AvisarLegadoNaoPortado("Tela de Endere" + CHR(231) + "o de Entrega (SigCdEnd)", ;
2333:                     "informar/alterar o local de entrega")
2334:             ENDTRY
2335:         ENDIF
2336: 
2337:         IF USED("cursor_4c_DCompCli")
2338:             USE IN cursor_4c_DCompCli
2339:         ENDIF
2340:     ENDPROC
2341: 
2342:     *==========================================================================
2343:     * ConfigurarPedido - cntPedido (cnt_4c_Pedido): numero do pedido do
2344:     * cliente.
2345:     *==========================================================================
2346:     PROTECTED PROCEDURE ConfigurarPedido()
2347:         LOCAL loc_oCnt, loc_lTemCursorPai
2348:         loc_lTemCursorPai = USED("TprMvCab")
2349: 
2350:         THIS.AddObject("cnt_4c_Pedido", "Container")
2351:         loc_oCnt = THIS.cnt_4c_Pedido
2352:         WITH loc_oCnt
2353:             .Top         = 96
2354:             .Left        = 522
2355:             .Width       = 61
2356:             .Height      = 45
2357:             .BackStyle   = 0
2358:             .BorderWidth = 0
2359:             .Visible     = .T.
2360:         ENDWITH
2361: 
2362:         loc_oCnt.AddObject("lbl_4c_LblPedido", "Label")
2363:         WITH loc_oCnt.lbl_4c_LblPedido
2364:             .FontName  = "Tahoma"
2365:             .FontSize  = 8
2366:             .BackStyle = 0
2367:             .Alignment = 0
2368:             .AutoSize  = .F.
2369:             .Caption   = "Pedido"
2370:             .Left      = 3
2371:             .Top       = 3
2372:             .Width     = 55
2373:             .ForeColor = RGB(90, 90, 90)
2374:             .Visible   = .T.
2375:         ENDWITH
2376: 
2377:         loc_oCnt.AddObject("txt_4c_Pedido", "TextBox")
2378:         WITH loc_oCnt.txt_4c_Pedido
2379:             .Alignment     = 3
2380:             .Format        = "K"
2381:             .InputMask     = "999999"
2382:             .MaxLength     = 6
2383:             .Left          = 3
2384:             .Top           = 20
2385:             .Width         = 55
2386:             .Height        = 23

*-- Linhas 2393 a 2526:
2393:         IF loc_lTemCursorPai
2394:             loc_oCnt.txt_4c_Pedido.ControlSource = "TprMvCab.nPedClis"
2395:         ENDIF
2396:         BINDEVENT(loc_oCnt.txt_4c_Pedido, "When", THIS, "PedidoWhen")
2397:     ENDPROC
2398: 
2399:     *==========================================================================
2400:     * PedidoWhen - "Return Inlist(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')
2401:     * And Not (crSigCdOpe.PedClis = 5)" do legado (getPedido.When). Sem
2402:     * crSigCdOpe (fases seguintes), falso seguro - mesmo criterio de
2403:     * DocumentosWhen (bloqueia at? o dado confirmar que pode liberar).
2404:     *
2405:     * PUBLIC: alvo de BINDEVENT("When").
2406:     *==========================================================================
2407:     FUNCTION PedidoWhen()
2408:         LOCAL loc_lPermite
2409:         loc_lPermite = .F.
2410: 
2411:         IF INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR") AND USED("crSigCdOpe")
2412:             loc_lPermite = !(crSigCdOpe.PedClis = 5)
2413:         ENDIF
2414: 
2415:         RETURN loc_lPermite
2416:     ENDFUNC
2417: 
2418:     *==========================================================================
2419:     * ConfigurarObs2 - CntObs2 (cnt_4c_Obs2): "Finalidade" - botao que abre
2420:     * a mesma tela de multiplas observacoes (SigOpIns), mas gravando em
2421:     * CodObs2 em vez de CodObs.
2422:     *==========================================================================
2423:     PROTECTED PROCEDURE ConfigurarObs2()
2424:         LOCAL loc_oCnt
2425: 
2426:         THIS.AddObject("cnt_4c_Obs2", "Container")
2427:         loc_oCnt = THIS.cnt_4c_Obs2
2428:         WITH loc_oCnt
2429:             .Top         = 96
2430:             .Left        = 582
2431:             .Width       = 66
2432:             .Height      = 64
2433:             .BackStyle   = 0
2434:             .BorderWidth = 0
2435:             .Visible     = .T.
2436:         ENDWITH
2437: 
2438:         loc_oCnt.AddObject("lbl_4c_LblPedido", "Label")
2439:         WITH loc_oCnt.lbl_4c_LblPedido
2440:             .FontName  = "Tahoma"
2441:             .FontSize  = 8
2442:             .BackStyle = 0
2443:             .Alignment = 0
2444:             .AutoSize  = .F.
2445:             .Caption   = "Finalidade"
2446:             .Left      = 3
2447:             .Top       = 3
2448:             .Width     = 60
2449:             .ForeColor = RGB(90, 90, 90)
2450:             .Visible   = .T.
2451:         ENDWITH
2452: 
2453:         loc_oCnt.AddObject("cmd_4c_BtnMultObs", "CommandButton")
2454:         WITH loc_oCnt.cmd_4c_BtnMultObs
2455:             .Top             = 20
2456:             .Left            = 3
2457:             .Width           = 24
2458:             .Height          = 24
2459:             .Caption         = ""
2460:             .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
2461:             .ToolTipText     = "Selecionar Finalidade da opera" + CHR(231) + CHR(227) + "o para ser usada no relat" + CHR(243) + "rio de opera" + CHR(231) + CHR(245) + "es."
2462:             .Themes          = .T.
2463:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
2464:             .Visible         = .T.
2465:         ENDWITH
2466:         BINDEVENT(loc_oCnt.cmd_4c_BtnMultObs, "Click", THIS, "BtnMultObsFinalidadeClick")
2467:     ENDPROC
2468: 
2469:     *==========================================================================
2470:     * BtnMultObsFinalidadeClick - CntObs2.btnMultObs.Valid legado:
2471:     *   Do Form SigOpIns With ThisForm.ParentForm.poDataMgr, TprMvCab.CodObs2
2472:     *   replace CodObs2 with ALLTRIM(listaObs) in TprMvCab
2473:     * SigOpIns nao veio no acervo - sem a tela (e sem a lista que ela
2474:     * devolveria em listaObs), nao ha resultado para gravar em CodObs2.
2475:     *
2476:     * PUBLIC: alvo de BINDEVENT("Click").
2477:     *==========================================================================
2478:     PROCEDURE BtnMultObsFinalidadeClick()
2479:         THIS.AvisarLegadoNaoPortado("Tela de Sele" + CHR(231) + CHR(227) + "o de Finalidade (SigOpIns)", ;
2480:             "selecionar a finalidade da opera" + CHR(231) + CHR(227) + "o")
2481:     ENDPROC
2482: 
2483:     *==========================================================================
2484:     * ConfigurarLivre - cntLivre (cnt_4c_Livre): numero do lacre.
2485:     *==========================================================================
2486:     PROTECTED PROCEDURE ConfigurarLivre()
2487:         LOCAL loc_oCnt, loc_lTemCursorPai
2488:         loc_lTemCursorPai = USED("TprMvCab")
2489: 
2490:         THIS.AddObject("cnt_4c_Livre", "Container")
2491:         loc_oCnt = THIS.cnt_4c_Livre
2492:         WITH loc_oCnt
2493:             .Top         = 189
2494:             .Left        = 2
2495:             .Width       = 352
2496:             .Height      = 45
2497:             .BackStyle   = 0
2498:             .BorderWidth = 0
2499:             .Visible     = .T.
2500:         ENDWITH
2501: 
2502:         loc_oCnt.AddObject("lbl_4c_LblNLivDg", "Label")
2503:         WITH loc_oCnt.lbl_4c_LblNLivDg
2504:             .FontName  = "Tahoma"
2505:             .FontSize  = 8
2506:             .BackStyle = 0
2507:             .Alignment = 0
2508:             .AutoSize  = .F.
2509:             .Caption   = "Lacre"
2510:             .Left      = 3
2511:             .Top       = 3
2512:             .Width     = 60
2513:             .Height    = 15
2514:             .ForeColor = RGB(90, 90, 90)
2515:             .Visible   = .T.
2516:         ENDWITH
2517: 
2518:         loc_oCnt.AddObject("txt_4c_NLivDg", "TextBox")
2519:         WITH loc_oCnt.txt_4c_NLivDg
2520:             .Alignment     = 3
2521:             .MaxLength     = 15
2522:             .Value         = 0
2523:             .Left          = 3
2524:             .Top           = 20
2525:             .Width         = 169
2526:             .Height        = 23

*-- Linhas 2533 a 2830:
2533:         IF loc_lTemCursorPai
2534:             loc_oCnt.txt_4c_NLivDg.ControlSource = "TprMvCab.NLivDg"
2535:         ENDIF
2536:         BINDEVENT(loc_oCnt.txt_4c_NLivDg, "When", THIS, "PadraoIncluirAlterarWhen")
2537:     ENDPROC
2538: 
2539:     *==========================================================================
2540:     * AtualizarVisibilidadeCmdEntrega - "ThisForm.cmdEntrega.Visible =
2541:     * InList(crSigCdOpe.DtEntrs,1,4,6) And Not InList(ThisForm.pcEscolha,
2542:     * 'INSERIR','EXCLUIR')" do Init legado (linha 2100). crSigCdOpe e
2543:     * carregado pelo CursorQuery do Init legado, ainda nao portado (fases
2544:     * seguintes) - sem o cursor, o botao fica oculto (falso seguro); quem
2545:     * popular crSigCdOpe numa fase posterior deve chamar este metodo de
2546:     * novo para o botao assumir o estado real.
2547:     *
2548:     * PUBLIC: reutilizavel por fases/metodos futuros que alterem
2549:     * this_cPcEscolha ou recarreguem crSigCdOpe.
2550:     *==========================================================================
2551:     PROCEDURE AtualizarVisibilidadeCmdEntrega()
2552:         LOCAL loc_lVisivel
2553:         loc_lVisivel = .F.
2554: 
2555:         IF USED("crSigCdOpe")
2556:             loc_lVisivel = INLIST(crSigCdOpe.DtEntrs, 1, 4, 6) ;
2557:                 AND !INLIST(THIS.this_cPcEscolha, "INSERIR", "EXCLUIR")
2558:         ENDIF
2559: 
2560:         IF PEMSTATUS(THIS, "obj_4c_CmdEntrega", 5)
2561:             THIS.obj_4c_CmdEntrega.Visible = loc_lVisivel
2562:         ENDIF
2563:     ENDPROC
2564: 
2565:     *==========================================================================
2566:     * CmdCotacaoClick - "Do Form SigPrCtc With Thisform, ThisForm.DataSessionId,
2567:     * ThisForm.pcescolha, TprMvCab.Emps, TprMvCab.Dopes, TprMvCab.Numes" do
2568:     * legado (cmdCotacao.Valid). FormSigPrCtc.Init ja descarta o
2569:     * DataSessionId (arquitetura nova nao precisa dele): assinatura e
2570:     * (par_oFormPai, par_cEscolha, par_cEmps, par_cDopes, par_nNumes).
2571:     * FormSigPrCtc.BtnSairClick fecha com THIS.Release() - nao ha nada a
2572:     * ler nem a liberar depois do Show() aqui.
2573:     *
2574:     * PUBLIC: alvo de BINDEVENT("Click").
2575:     *==========================================================================
2576:     PROCEDURE CmdCotacaoClick()
2577:         LOCAL loc_oDlg, loc_oErro
2578:         loc_oDlg = .NULL.
2579: 
2580:         IF !USED("TprMvCab")
2581:             RETURN
2582:         ENDIF
2583: 
2584:         TRY
2585:             loc_oDlg = CREATEOBJECT("FormSigPrCtc", THIS, THIS.this_cPcEscolha, ;
2586:                 TprMvCab.Emps, TprMvCab.Dopes, TprMvCab.Numes)
2587:         CATCH TO loc_oErro
2588:             MsgErro(loc_oErro.Message + CHR(13) + ;
2589:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
2590:                 "Erro ao abrir Cota" + CHR(231) + CHR(227) + "o")
2591:             loc_oDlg = .NULL.
2592:         ENDTRY
2593: 
2594:         IF VARTYPE(loc_oDlg) = "O"
2595:             loc_oDlg.Show()
2596:         ENDIF
2597:     ENDPROC
2598: 
2599:     *==========================================================================
2600:     * CmdEntregaClick - "Local ldDat, lnMin, ldEst / ldDat = Iif(IsEmpty(
2601:     * TprMvCab.PrazoEnts), Date(), TprMvCab.PrazoEnts) / lnMin = Iif(IsEmpty(
2602:     * crSigOpCdc.NMinEnts), 0, crSigOpCdc.NMinEnts) / lnMax = Iif(IsEmpty(
2603:     * CrSigOpCdc.nMaxEnts), 0, CrSigOpCdc.nMaxEnts) / ldEst = Ttod(fDtoSQL(
2604:     * Nvl(TprMvCab.Datas, Date()))) / Do Form SigOpEnt With TprMvCab.Emps,
2605:     * TprMvCab.Dopes, TprMvCab.Numes, ldDat, ThisForm, lnMin, ldEst, .f.,
2606:     * lnMax" do legado (cmdEntrega.Valid). FormSigOpEnt fecha com Hide()
2607:     * (FecharDialogo) e devolve o resultado por ObterPrazoConfirmado() -
2608:     * ver comentario daquele metodo em FormSigOpEnt.prg. O campo "Entregas"
2609:     * (cnt_4c_Entregas.txt_4c_Entregas) e criado numa fase posterior - a
2610:     * atribuicao e guardada por PEMSTATUS/VARTYPE e nao falha enquanto o
2611:     * container nao existir.
2612:     *
2613:     * PUBLIC: alvo de BINDEVENT("Click").
2614:     *==========================================================================
2615:     PROCEDURE CmdEntregaClick()
2616:         LOCAL loc_oDlg, loc_oErro, loc_dAtual, loc_nMin, loc_nMax, loc_dEst, ;
2617:               loc_dConfirmado
2618: 
2619:         IF !USED("TprMvCab")
2620:             RETURN
2621:         ENDIF
2622: 
2623:         loc_dAtual = IIF(EMPTY(TprMvCab.PrazoEnts), DATE(), TprMvCab.PrazoEnts)
2624: 
2625:         loc_nMin = 0
2626:         loc_nMax = 0
2627:         IF USED("crSigOpCdc")
2628:             loc_nMin = IIF(EMPTY(crSigOpCdc.NMinEnts), 0, crSigOpCdc.NMinEnts)
2629:             loc_nMax = IIF(EMPTY(crSigOpCdc.NMaxEnts), 0, crSigOpCdc.NMaxEnts)
2630:         ENDIF
2631:         loc_dEst = TTOD(fDtoSQL(NVL(TprMvCab.Datas, DATE())))
2632: 
2633:         loc_oDlg = .NULL.
2634:         TRY
2635:             loc_oDlg = CREATEOBJECT("FormSigOpEnt", TprMvCab.Emps, TprMvCab.Dopes, ;
2636:                 TprMvCab.Numes, loc_dAtual, THIS, loc_nMin, loc_dEst, .F., loc_nMax)
2637:         CATCH TO loc_oErro
2638:             MsgErro(loc_oErro.Message + CHR(13) + ;
2639:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
2640:                 "Erro ao abrir Prazo de Entrega")
2641:             loc_oDlg = .NULL.
2642:         ENDTRY
2643: 
2644:         IF VARTYPE(loc_oDlg) = "O"
2645:             loc_oDlg.Show()
2646: 
2647:             loc_dConfirmado = loc_oDlg.ObterPrazoConfirmado()
2648:             IF !EMPTY(loc_dConfirmado)
2649:                 REPLACE PrazoEnts WITH loc_dConfirmado IN TprMvCab
2650: 
2651:                 IF PEMSTATUS(THIS, "cnt_4c_Entregas", 5) AND VARTYPE(THIS.cnt_4c_Entregas) = "O"
2652:                     IF PEMSTATUS(THIS.cnt_4c_Entregas, "txt_4c_Entregas", 5) ;
2653:                        AND VARTYPE(THIS.cnt_4c_Entregas.txt_4c_Entregas) = "O"
2654:                         THIS.cnt_4c_Entregas.txt_4c_Entregas.Value = loc_dConfirmado
2655:                         THIS.cnt_4c_Entregas.txt_4c_Entregas.Refresh()
2656:                     ENDIF
2657:                 ENDIF
2658:             ENDIF
2659: 
2660:             loc_oDlg.Release()
2661:         ENDIF
2662:     ENDPROC
2663: 
2664:     *==========================================================================
2665:     * CarregarCursoresOperacao - "With ThisForm.ParentForm.poDataMgr /
2666:     * .Cursorquery('SigCdOpe','CrSigCdOpe','Dopes',TprMvCab.Dopes) /
2667:     * .Cursorquery('SigOpCdc','CrSigOpCdc','Dopes',TprMvCab.Dopes) /
2668:     * .Cursorquery('SigOpCdd','CrSigOpCdd','Dopes',TprMvCab.Dopes)" do Init
2669:     * legado - os tres cursores que destravam os varios "falso seguro"
2670:     * espalhados pelas Fases 4/5/6 (USED("crSigCdOpe")/USED("CrSigOpCdc")).
2671:     * A 4a CursorQuery do legado (SigCdEmp/CrEmp) fica de fora - so e usada
2672:     * no bloco "Carrega Dados da Conta", fora do escopo desta fase (ver
2673:     * comentario de cabecalho do arquivo).
2674:     *
2675:     * PROTECTED: chamado uma unica vez, por InicializarForm().
2676:     *==========================================================================
2677:     PROTECTED PROCEDURE CarregarCursoresOperacao()
2678:         LOCAL loc_cSQL, loc_nErro
2679: 
2680:         IF !USED("TprMvCab")
2681:             RETURN
2682:         ENDIF
2683: 
2684:         IF USED("crSigCdOpe")
2685:             USE IN crSigCdOpe
2686:         ENDIF
2687:         loc_cSQL  = "SELECT * FROM SigCdOpe WHERE Dopes = " + EscaparSQL(TprMvCab.Dopes)
2688:         loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdOpe")
2689:         IF loc_nErro < 1
2690:             MsgErro("Favor reinicializar o processo." + CHR(13) + ;
2691:                 "Falha na conex" + CHR(227) + "o (SigCdOpe)", "Erro")
2692:         ENDIF
2693: 
2694:         IF USED("CrSigOpCdc")
2695:             USE IN CrSigOpCdc
2696:         ENDIF
2697:         loc_cSQL  = "SELECT * FROM SigOpCdc WHERE Dopes = " + EscaparSQL(TprMvCab.Dopes)
2698:         loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigOpCdc")
2699:         IF loc_nErro < 1
2700:             MsgErro("Favor reinicializar o processo." + CHR(13) + ;
2701:                 "Falha na conex" + CHR(227) + "o (SigOpCdc)", "Erro")
2702:         ENDIF
2703: 
2704:         IF USED("CrSigOpCdd")
2705:             USE IN CrSigOpCdd
2706:         ENDIF
2707:         loc_cSQL  = "SELECT * FROM SigOpCdd WHERE Dopes = " + EscaparSQL(TprMvCab.Dopes)
2708:         loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigOpCdd")
2709:         IF loc_nErro < 1
2710:             MsgErro("Favor reinicializar o processo." + CHR(13) + ;
2711:                 "Falha na conex" + CHR(227) + "o (SigOpCdd)", "Erro")
2712:         ENDIF
2713:     ENDPROC
2714: 
2715:     *==========================================================================
2716:     * CarregarPrazoEntregaPadrao - "PROCEDURE carregaprzent" do legado:
2717:     * sugere data de entrega padrao QUANDO o campo ainda esta vazio ou
2718:     * ainda e hoje - nunca sobrescreve um prazo que o usuario ja moveu.
2719:     *
2720:     *   If (InList(crSigCdOpe.DtEntrs,1,4,6) And InList(pcEscolha,
2721:     *      'INSERIR','ALTERAR') And (IsEmpty(PrazoEnts) Or
2722:     *      Dtos(PrazoEnts)=Dtos(Date())))
2723:     *       lcCta = Iif(crSigCdOpe.COpers=1, ContaDs, ContaOs)
2724:     *       If IsEmpty(PrazoEnts)
2725:     *           ldDat = Date()
2726:     *           If NMinEnts = NMaxEnts -> ldDat = Date()+NMinEnts
2727:     *       Else
2728:     *           ldDat = <PrazoEnts atual>
2729:     *       CursorQuery('SigCdCli','LocalCli','IClis',lcCta,'PrazoEnts')
2730:     *       If LocalCli.PrazoEnts > 0 -> ldDat = ldDat + LocalCli.PrazoEnts
2731:     *   EndIf
2732:     *
2733:     * PROTECTED: chamado so por AtualizarVisibilidadePorOperacao().
2734:     *==========================================================================
2735:     PROTECTED PROCEDURE CarregarPrazoEntregaPadrao()
2736:         LOCAL loc_cConta, loc_dPrazo, loc_cSQL, loc_nErro
2737: 
2738:         IF !USED("TprMvCab") OR !USED("crSigCdOpe")
2739:             RETURN
2740:         ENDIF
2741: 
2742:         IF !INLIST(crSigCdOpe.DtEntrs, 1, 4, 6) ;
2743:            OR !INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR") ;
2744:            OR (!EMPTY(TprMvCab.PrazoEnts) ;
2745:                AND DTOS(ConverterParaData(TprMvCab.PrazoEnts)) <> DTOS(DATE()))
2746:             RETURN
2747:         ENDIF
2748: 
2749:         loc_cConta = ALLTRIM(IIF(crSigCdOpe.COpers = 1, TprMvCab.ContaDs, TprMvCab.ContaOs))
2750: 
2751:         IF EMPTY(TprMvCab.PrazoEnts)
2752:             loc_dPrazo = DATE()
2753:             IF USED("CrSigOpCdc") AND CrSigOpCdc.NMinEnts = CrSigOpCdc.NMaxEnts
2754:                 loc_dPrazo = DATE() + CrSigOpCdc.NMinEnts
2755:                 REPLACE PrazoEnts WITH loc_dPrazo IN TprMvCab
2756:             ENDIF
2757:         ELSE
2758:             loc_dPrazo = ConverterParaData(TprMvCab.PrazoEnts)
2759:         ENDIF
2760: 
2761:         IF !EMPTY(loc_cConta)
2762:             loc_cSQL  = "SELECT PrazoEnts FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cConta)
2763:             loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrazoCliente")
2764: 
2765:             IF loc_nErro >= 1 AND RECCOUNT("cursor_4c_PrazoCliente") > 0 ;
2766:                AND cursor_4c_PrazoCliente.PrazoEnts > 0
2767:                 loc_dPrazo = loc_dPrazo + cursor_4c_PrazoCliente.PrazoEnts
2768:                 REPLACE PrazoEnts WITH loc_dPrazo IN TprMvCab
2769:             ENDIF
2770: 
2771:             IF USED("cursor_4c_PrazoCliente")
2772:                 USE IN cursor_4c_PrazoCliente
2773:             ENDIF
2774:         ENDIF
2775:     ENDPROC
2776: 
2777:     *==========================================================================
2778:     * AtualizarVisibilidadePorOperacao - o corpo do Init legado que liga
2779:     * Visible/Caption de cada container ao tipo de operacao corrente
2780:     * (crSigCdOpe/CrSigOpCdc/CrSigOpCdd, carregados por
2781:     * CarregarCursoresOperacao()). Chamada DEPOIS de
2782:     * TornarControlesVisiveis(THIS): esse metodo reescreve Visible = .T.
2783:     * em CADA AddObject recursivamente, entao a regra de negocio desta
2784:     * tela so vale se for aplicada POR CIMA dele, nao antes.
2785:     *
2786:     * PUBLIC: reutilizavel por fases/metodos futuros que recarreguem os
2787:     * cursores de operacao (mesmo padrao de AtualizarVisibilidadeCmdEntrega,
2788:     * Fase 4) - chamada de novo no final daqui pela mesma razao.
2789:     *==========================================================================
2790:     PROCEDURE AtualizarVisibilidadePorOperacao()
2791:         LOCAL loc_lFiscal
2792: 
2793:         IF !USED("TprMvCab") OR !USED("crSigCdOpe")
2794:             RETURN
2795:         ENDIF
2796: 
2797:         *** Digita Observacao / Digita Entrega / CntObs2
2798:         THIS.cnt_4c_Observacao.Visible = INLIST(crSigCdOpe.DigObs, 1, 3)
2799:         THIS.cnt_4c_Entrega.Visible    = INLIST(crSigCdOpe.DtEntrs, 3, 4, 5, 6)
2800: 
2801:         IF USED("CrSigOpCdd") AND PEMSTATUS(THIS, "cnt_4c_Obs2", 5)
2802:             THIS.cnt_4c_Obs2.Visible = (INT(VAL(SUBSTR(CrSigOpCdd.ConfigGers, 209, 1))) = 1)
2803:         ENDIF
2804: 
2805:         *** Digita Dados Fiscais
2806:         loc_lFiscal = (crSigCdOpe.CupFis = 4)
2807:         THIS.cnt_4c_Ecfs.Visible  = loc_lFiscal
2808:         THIS.cnt_4c_Nemps.Visible = loc_lFiscal
2809: 
2810:         THIS.cnt_4c_Volumes.Visible = (crSigCdOpe.DadosNotas = 1)
2811:         THIS.cnt_4c_Pedido.Visible  = INLIST(crSigCdOpe.PedClis, 1, 3, 4, 5)
2812: 
2813:         IF USED("CrSigOpCdc")
2814:             THIS.cnt_4c_Protocolo.Visible = (CrSigOpCdc.EditProts = 1)
2815:         ENDIF
2816: 
2817:         *-- Carrega Dados da Conta (crSigCdOpe.Opers = 2): o legado busca o
2818:         *-- valor inicial em ThisForm.ParentForm.Pagina.Dados.pgfprincipal.
2819:         *-- pgcontas.Destino.Get_Conta (pagina do form pai) e no cursor
2820:         *-- TmpOperacao (grade de itens) - nenhum dos dois pertence a este
2821:         *-- dialogo. Falso seguro parcial: ao menos confirma/preenche
2822:         *-- Nome e CPF/CNPJ a partir do codigo JA presente em
2823:         *-- TprMvCab.ContaEs, igual ao "lcCliente = TprMvCab.ContaEs /
2824:         *-- CursorQuery(...) / getDConta.Value = ... / getCpfs.Value = ..."
2825:         *-- que fecha esse trecho do Init legado.
2826:         IF !EMPTY(TprMvCab.ContaEs)
2827:             THIS.BuscarContaEntrega("IClis", ALLTRIM(TprMvCab.ContaEs))
2828:         ENDIF
2829: 
2830:         *** Digita Documento / Data de Emissao

*-- Linhas 2858 a 2916:
2858:         *-- Reaplica por cima do que ConfigurarBotoesAcao (Fase 4) ja tinha
2859:         *-- calculado antes dos cursores existirem - e o que faz a
2860:         *-- visibilidade real do botao de atalho de Prazo de Entrega valer
2861:         *-- depois do TornarControlesVisiveis.
2862:         THIS.AtualizarVisibilidadeCmdEntrega()
2863:     ENDPROC
2864: 
2865:     *==========================================================================
2866:     * AjustarPosicaoCampos - "PROCEDURE ajustaobjs" do legado: reflui os
2867:     * containers da 1a linha (Ecfs/Nemps/Protocolo/Pedido, a partir de
2868:     * cnt_4c_Codigos+cnt_4c_Documentos), da 2a linha (Emiss/Entregas/
2869:     * Recepcaos/PrzEnts/Livre) e dos containers empilhados por baixo
2870:     * (Observacao/Entrega/Volumes), preenchendo o espaco dos que a
2871:     * AtualizarVisibilidadePorOperacao() acabou de ocultar. Chamada por
2872:     * ultimo em InicializarForm(), com a visibilidade ja definitiva.
2873:     *
2874:     * PROTECTED: chamado uma unica vez, por InicializarForm().
2875:     *==========================================================================
2876:     PROTECTED PROCEDURE AjustarPosicaoCampos()
2877:         LOCAL loc_nLf0, loc_nTp0, loc_nLft, loc_nTop
2878: 
2879:         loc_nLf0 = THIS.cnt_4c_Codigos.Left
2880:         loc_nTp0 = THIS.cnt_4c_Codigos.Top
2881: 
2882:         *-- Ajustando Primeira Linha de Campos
2883:         loc_nLft = loc_nLf0 + THIS.cnt_4c_Documentos.Width + THIS.cnt_4c_Codigos.Width
2884:         loc_nTop = loc_nTp0
2885: 
2886:         IF THIS.cnt_4c_Ecfs.Visible
2887:             THIS.cnt_4c_Ecfs.Left = loc_nLft
2888:             THIS.cnt_4c_Ecfs.Top  = loc_nTop
2889:             loc_nLft = loc_nLft + THIS.cnt_4c_Ecfs.Width
2890:         ENDIF
2891: 
2892:         IF THIS.cnt_4c_Nemps.Visible
2893:             THIS.cnt_4c_Nemps.Left = loc_nLft
2894:             THIS.cnt_4c_Nemps.Top  = loc_nTop
2895:             loc_nLft = loc_nLft + THIS.cnt_4c_Nemps.Width
2896:         ENDIF
2897: 
2898:         IF THIS.cnt_4c_Protocolo.Visible
2899:             THIS.cnt_4c_Protocolo.Left = loc_nLft
2900:             THIS.cnt_4c_Protocolo.Top  = loc_nTop
2901:             loc_nLft = loc_nLft + THIS.cnt_4c_Protocolo.Width
2902:         ENDIF
2903: 
2904:         IF THIS.cnt_4c_Pedido.Visible
2905:             THIS.cnt_4c_Pedido.Left = loc_nLft
2906:             THIS.cnt_4c_Pedido.Top  = loc_nTop
2907:             loc_nLft = loc_nLft + THIS.cnt_4c_Pedido.Width
2908:         ENDIF
2909: 
2910:         loc_nLft = loc_nLf0
2911:         loc_nTop = loc_nTp0 + THIS.cnt_4c_Codigos.Height + 1
2912: 
2913:         *-- Ajustando Segunda Linha de Campos
2914:         IF THIS.cnt_4c_Emiss.Visible
2915:             THIS.cnt_4c_Emiss.Left = loc_nLft
2916:             THIS.cnt_4c_Emiss.Top  = loc_nTop

*-- Linhas 2983 a 3213:
2983:     * Form receber o KeyPress ANTES dos controles - exigido para capturar
2984:     * F2/F3 em qualquer campo focado, como no legado.
2985:     *==========================================================================
2986:     PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
2987:         IF PEMSTATUS(THIS, "cnt_4c_Entrega", 5) AND VARTYPE(THIS.cnt_4c_Entrega) = "O"
2988:             IF THIS.cnt_4c_Entrega.cmd_4c_CmdEntrega.Visible AND par_nKeyCode = -1
2989:                 THIS.EntregaLocalClick()
2990:                 NODEFAULT
2991:                 RETURN
2992:             ENDIF
2993:         ENDIF
2994: 
2995:         IF PEMSTATUS(THIS, "obj_4c_CmdEntrega", 5) AND VARTYPE(THIS.obj_4c_CmdEntrega) = "O"
2996:             IF THIS.obj_4c_CmdEntrega.Visible AND par_nKeyCode = -2
2997:                 THIS.CmdEntregaClick()
2998:                 NODEFAULT
2999:             ENDIF
3000:         ENDIF
3001:     ENDPROC
3002: 
3003:     *==========================================================================
3004:     * TornarControlesVisiveis - Torna visiveis, recursivamente, os controles
3005:     * criados por AddObject (que nascem com Visible = .F.). Percorre tambem
3006:     * Pages de eventuais PageFrames filhos (nenhum nesta tela, mas o metodo
3007:     * fica generico para as proximas fases).
3008:     *==========================================================================
3009:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
3010:         LOCAL loc_nI, loc_oObjeto, loc_nP
3011: 
3012:         FOR loc_nI = 1 TO par_oContainer.ControlCount
3013:             loc_oObjeto = par_oContainer.Controls(loc_nI)
3014: 
3015:             IF VARTYPE(loc_oObjeto) = "O"
3016:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
3017:                     loc_oObjeto.Visible = .T.
3018:                 ENDIF
3019: 
3020:                 IF PEMSTATUS(loc_oObjeto, "BaseClass", 5) ;
3021:                    AND UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
3022:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
3023:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
3024:                     ENDFOR
3025:                 ENDIF
3026: 
3027:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
3028:                     THIS.TornarControlesVisiveis(loc_oObjeto)
3029:                 ENDIF
3030:             ENDIF
3031:         ENDFOR
3032:     ENDPROC
3033: 
3034:     *==========================================================================
3035:     * Destroy - Reabilita o form pai (ver DesabilitarFormPai) e segue para o
3036:     * fechamento canonico do FormBase (restauracao do menu principal).
3037:     *==========================================================================
3038:     PROCEDURE Destroy()
3039:         THIS.ReabilitarFormPai()
3040:         DODEFAULT()
3041:     ENDPROC
3042: 
3043:     *==========================================================================
3044:     * BtnSalvarClick - "PROCEDURE btnSelItens.Click" do legado (170 linhas):
3045:     *
3046:     *   If Inlist(pcEscolha,'INSERIR','ALTERAR')
3047:     *       [observacao obrigatoria / data de emissao / prazo de entrega +
3048:     *        recalculo de vencimentos + liberacao Min/Max / recepcao /
3049:     *        cupom fiscal-ECF / EditDocs=4]
3050:     *   Else
3051:     *       If fChecaAcesso(..., 'ALTINFO') And pcEscolha = 'CONSULTAR'
3052:     *           Update SigMvCab Set obses = ... Where CidChaves = ...
3053:     *       Endif
3054:     *   Endif
3055:     *   ThisForm.Return
3056:     *
3057:     * Cada "Return"/"Return .f." do legado (saida ANTECIPADA, sem gravar) e
3058:     * um RETURN bare deste metodo - so o CAMINHO FELIZ (fim de qualquer dos
3059:     * dois ramos) chama THIS.FecharDialogo(), equivalente ao "ThisForm.
3060:     * Return" final do legado.
3061:     *
3062:     * Guard de topo: sem TprMvCab/crSigCdOpe (cursores do form pai/Init
3063:     * legado) nao ha o que validar nem gravar - mesmo "falso seguro" das
3064:     * Fases 5-7 (CarregarPrazoEntregaPadrao, AtualizarVisibilidadePorOperacao).
3065:     *
3066:     * PUBLIC: alvo de BINDEVENT("Click") em ConfigurarBotoesAcao (Fase 4).
3067:     *==========================================================================
3068:     PROCEDURE BtnSalvarClick()
3069:         LOCAL loc_dLimiteMin, loc_dLimiteMax, loc_dData, loc_cHora
3070: 
3071:         IF !USED("TprMvCab") OR !USED("crSigCdOpe")
3072:             RETURN
3073:         ENDIF
3074: 
3075:         IF INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
3076: 
3077:             *-- Observacao obrigatoria (DigObs = 3)
3078:             IF crSigCdOpe.DigObs = 3 AND (EMPTY(TprMvCab.CodObs) OR EMPTY(TprMvCab.Obses))
3079:                 MsgAviso("Obrigat" + CHR(243) + "rio Informar " + ;
3080:                     IIF(EMPTY(TprMvCab.CodObs), "C" + CHR(243) + "digo da ", "") + ;
3081:                     "Observa" + CHR(231) + CHR(227) + "o para essa Opera" + CHR(231) + ;
3082:                     CHR(227) + "o ... ", ;
3083:                     "Observa" + CHR(231) + CHR(227) + "o " + CHR(233) + " Informa" + ;
3084:                     CHR(231) + CHR(227) + "o Obrigat" + CHR(243) + "ria")
3085:                 IF EMPTY(TprMvCab.CodObs)
3086:                     THIS.cnt_4c_Observacao.txt_4c_CodObs.SetFocus()
3087:                 ELSE
3088:                     THIS.cnt_4c_Observacao.obj_4c_GetDesObs.SetFocus()
3089:                 ENDIF
3090:                 RETURN
3091:             ENDIF
3092: 
3093:             *-- Data de Emissao obrigatoria (DtEmis = 3)
3094:             IF EMPTY(TprMvCab.DtEmis) AND crSigCdOpe.DtEmis = 3
3095:                 MsgAviso("Data de Emiss" + CHR(227) + "o do Documento precisa ser " + ;
3096:                     "informada ... ", ;
3097:                     "Data de Emiss" + CHR(227) + "o : Informa" + CHR(231) + CHR(227) + ;
3098:                     "o Obrigat" + CHR(243) + "ria")
3099:                 THIS.cnt_4c_Emiss.txt_4c_Emiss.SetFocus()
3100:                 RETURN
3101:             ENDIF
3102: 
3103:             *-- Prazo de Entrega preenchido: grava com hora + recalcula
3104:             *-- vencimentos das parcelas (xPar - cursor do form pai, falso
3105:             *-- seguro via USED() dentro de RecalcularVencimentosParcelas)
3106:             IF !EMPTY(TprMvCab.PrazoEnts)
3107:                 loc_dData = ConverterParaData(TprMvCab.PrazoEnts)
3108:                 loc_cHora = TIME(TprMvCab.PrazoEnts)
3109:                 REPLACE PrazoEnts WITH fDtoSQL(loc_dData, loc_cHora) IN TprMvCab
3110:                 THIS.cnt_4c_Entregas.txt_4c_Entregas.Refresh()
3111: 
3112:                 THIS.RecalcularVencimentosParcelas("xPar", .F.)
3113:             ENDIF
3114: 
3115:             *-- Prazo de Entrega: obrigatoriedade + faixa Minima/Maxima
3116:             IF INLIST(crSigCdOpe.DtEntrs, 1, 4, 6)
3117:                 IF EMPTY(TprMvCab.PrazoEnts)
3118:                     MsgAviso("Prazo de Entrega deve ser informado...", "")
3119:                     THIS.cnt_4c_Entregas.txt_4c_Entregas.SetFocus()
3120:                     RETURN
3121:                 ENDIF
3122: 
3123:                 IF ConverterParaData(TprMvCab.PrazoEnts) < ConverterParaData(TprMvCab.Datas)
3124:                     MsgAviso("Prazo de Entrega deve ser maior que a Data da " + ;
3125:                         "Movimenta" + CHR(231) + CHR(227) + "o...", "")
3126:                     THIS.cnt_4c_Entregas.txt_4c_Entregas.SetFocus()
3127:                     RETURN
3128:                 ENDIF
3129: 
3130:                 IF USED("CrSigOpCdc") AND CrSigOpCdc.NMinEnts > 0 AND !THIS.this_lValidOk
3131:                     loc_dLimiteMin = ConverterParaData(TprMvCab.Datas) + CrSigOpCdc.NMinEnts
3132:                     IF ConverterParaData(TprMvCab.PrazoEnts) < loc_dLimiteMin
3133:                         IF !THIS.SolicitarLiberacaoPrazoEntrega(loc_dLimiteMin, ;
3134:                                 ConverterParaData(TprMvCab.PrazoEnts), "M" + CHR(237) + "nimo")
3135:                             THIS.cnt_4c_Entregas.txt_4c_Entregas.Value = loc_dLimiteMin
3136:                             THIS.cnt_4c_Entregas.txt_4c_Entregas.SetFocus()
3137:                             RETURN
3138:                         ENDIF
3139:                     ENDIF
3140:                 ENDIF
3141: 
3142:                 IF USED("CrSigOpCdc") AND CrSigOpCdc.NMaxEnts > 0 AND !THIS.this_lValidOk
3143:                     loc_dLimiteMax = ConverterParaData(TprMvCab.Datas) + CrSigOpCdc.NMaxEnts
3144:                     IF ConverterParaData(TprMvCab.PrazoEnts) > loc_dLimiteMax
3145:                         IF !THIS.SolicitarLiberacaoPrazoEntrega(loc_dLimiteMax, ;
3146:                                 ConverterParaData(TprMvCab.PrazoEnts), "M" + CHR(225) + "ximo")
3147:                             THIS.cnt_4c_Entregas.txt_4c_Entregas.Value = loc_dLimiteMax
3148:                             THIS.cnt_4c_Entregas.txt_4c_Entregas.SetFocus()
3149:                             RETURN
3150:                         ENDIF
3151:                     ENDIF
3152:                 ENDIF
3153:             ENDIF
3154: 
3155:             *-- Data de Recepcao obrigatoria (DigRecs = 1)
3156:             IF crSigCdOpe.DigRecs = 1
3157:                 IF EMPTY(TprMvCab.DtRecs)
3158:                     MsgAviso("Data de Recep" + CHR(231) + CHR(227) + "o deve ser " + ;
3159:                         "informada ...", "")
3160:                     THIS.cnt_4c_Recepcaos.txt_4c_Recepcaos.SetFocus()
3161:                     RETURN
3162:                 ENDIF
3163:             ENDIF
3164: 
3165:             *-- Cupom Fiscal/ECF obrigatorios (CupFis = 4)
3166:             IF crSigCdOpe.CupFis = 4
3167:                 IF EMPTY(TprMvCab.Ecfs)
3168:                     MsgAviso("N" + CHR(250) + "mero do ECF Precisa Ser Informado...", "")
3169:                     THIS.cnt_4c_Ecfs.txt_4c_Ecfs.SetFocus()
3170:                     RETURN
3171:                 ENDIF
3172:                 IF EMPTY(TprMvCab.Nemps)
3173:                     MsgAviso("N" + CHR(250) + "mero de S" + CHR(233) + "rie da " + ;
3174:                         "Impressora Precisa Ser Informado...", "")
3175:                     THIS.cnt_4c_Nemps.txt_4c_Nemps.SetFocus()
3176:                     RETURN
3177:                 ENDIF
3178:             ENDIF
3179: 
3180:             *-- EditDocs = 4: numero da nota reformatado na grade de itens do
3181:             *-- movimento (crTpmMvItn) - cursor do form pai, falso seguro:
3182:             *-- sem ele (nenhum caller desta tela no acervo) fica de fora.
3183:             IF crSigCdOpe.EditDocs = 4 AND USED("crTpmMvItn")
3184:                 REPLACE ALL Notas WITH TRANSFORM(VAL(TprMvCab.Notas), "@L 999999") IN crTpmMvItn
3185:             ENDIF
3186: 
3187:         ELSE
3188:             *-- CONSULTAR com acesso ALTINFO liberado: confirma a observacao
3189:             *-- (mesmo gate de DesObsWhen, Fase 6)
3190:             IF fChecaAcesso(PADL(TRANSFORM(crSigCdOpe.nDopes), 8, "0"), "ALTINFO") ;
3191:                AND THIS.this_cPcEscolha = "CONSULTAR"
3192:                 THIS.this_oBusinessObject.this_cObses     = ALLTRIM(TprMvCab.Obses)
3193:                 THIS.this_oBusinessObject.this_cCidChaves = TprMvCab.CidChaves
3194:                 IF !THIS.this_oBusinessObject.Atualizar()
3195:                     RETURN
3196:                 ENDIF
3197:             ENDIF
3198:         ENDIF
3199: 
3200:         THIS.FecharDialogo()
3201:     ENDPROC
3202: 
3203:     *==========================================================================
3204:     * SolicitarLiberacaoPrazoEntrega - "Do Form SigOpSen With 'LIBPRZENT',
3205:     * 'Libera Prazo de Entrega' To _Retorno" do btnSelItens.Click legado,
3206:     * repetido para o limite Minimo e para o Maximo (so o rotulo/valor
3207:     * mudam):
3208:     *
3209:     *   Do Form SigOpSen With 'LIBPRZENT', 'Libera Prazo de Entrega' To _Retorno
3210:     *   llOk = ( Left( _Retorno, 1 ) = "*" )
3211:     *   lcUsuLib = Substr( _Retorno, 2 )
3212:     *   If !llOk -> Messagebox(...) / Return .f.
3213:     *   Else -> thisform.validok = .t. / fGravarLog('T', Dopes, 'LIBPRZENT', ...)

*-- Linhas 3258 a 3301:
3258:             THIS.this_lValidOk = .T.
3259:         ELSE
3260:             IF loc_lDialogoAbriu
3261:                 MsgAviso("Prazo de Entrega " + par_cRotulo + " " + CHR(233) + " " + ;
3262:                     DTOC(par_dLimite) + "...", "")
3263:             ELSE
3264:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel abrir a tela " + ;
3265:                     "de autoriza" + CHR(231) + CHR(227) + "o (SigOpSen)." + CHR(13) + ;
3266:                     "O prazo de entrega N" + CHR(195) + "O foi liberado." + CHR(13) + ;
3267:                     CHR(13) + "Detalhe: " + loc_cFalhaDialogo, "Libera Prazo de Entrega")
3268:             ENDIF
3269:         ENDIF
3270: 
3271:         RETURN loc_lAutorizado
3272:     ENDFUNC
3273: 
3274:     *==========================================================================
3275:     * RecalcularVencimentosParcelas - laco de recalculo de vencimentos do
3276:     * btnSelItens.Click legado (disparado quando o Prazo de Entrega muda):
3277:     *
3278:     *   Select xPar / Index on Fpags+cnidTefs+Str(Parcs,2) Tag FpagV / Scan
3279:     *       =CursorQuery('SigOpFp','LocalFpag','fpags',xPar.Fpags,
3280:     *           [TpVencs,Entradas,Dias,tVens])
3281:     *       If LocalFpag.TpVencs = 2
3282:     *           DVenc = (Ttod(TprMvCab.PrazoEnts) + LocalFpag.Entradas)
3283:     *           Scan While Fpags=_lcFpg And cnIdTefs=_lcIdT
3284:     *               [laco de feriados] / Replace Vencs With DVenc
3285:     *               DVenc = Iif(TVen='F', GoMonth(DVenc,1), DVenc+NDia)
3286:     *           EndScan
3287:     *           Skip -1
3288:     *       Endif
3289:     *   EndScan
3290:     *
3291:     * par_cCursor: alias do cursor de parcelas a recalcular, agrupado por
3292:     * Fpags+CnIdTefs (colunas Fpags/CnIdTefs/Parcs/Vencs/CidChaves). "xPar"
3293:     * (parcelas do lancamento corrente, BtnSalvarClick) e "LocalPar"
3294:     * (parcelas de SigMvPar no lancamento direto, ProcessarLancamentoDireto)
3295:     * usam este MESMO metodo - layout de colunas identico, so a origem
3296:     * difere. Falso seguro: sem o cursor (par_cCursor), nao ha o que
3297:     * recalcular.
3298:     *
3299:     * par_lAtualizarBanco = .T. (LocalPar) tambem grava o vencimento no SQL
3300:     * Server ("Update SigMvPar Set Vencs = ... Where CidChaves = ..."),
3301:     * como o legado faz nesse caminho; .F. (xPar) e so cursor em memoria do

*-- Linhas 3308 a 3351:
3308:     *
3309:     * PROTECTED: chamado so por BtnSalvarClick() e ProcessarLancamentoDireto().
3310:     *==========================================================================
3311:     PROTECTED PROCEDURE RecalcularVencimentosParcelas(par_cCursor, par_lAtualizarBanco)
3312:         LOCAL loc_dVenc, loc_nDias, loc_cTipoVenc, loc_cFpgAtual, loc_cIdTefAtual
3313:         LOCAL loc_cSQLFpg, loc_nErro, loc_cSQLUpdate, loc_cCidChave
3314: 
3315:         IF !USED(par_cCursor) OR !USED("TprMvCab") OR EMPTY(TprMvCab.PrazoEnts)
3316:             RETURN
3317:         ENDIF
3318: 
3319:         SELECT (par_cCursor)
3320:         INDEX ON Fpags + CnIdTefs + STR(Parcs, 2) TAG FpagV
3321:         SCAN
3322:             loc_cFpgAtual = Fpags
3323: 
3324:             IF USED("cursor_4c_FpgVenc")
3325:                 USE IN cursor_4c_FpgVenc
3326:             ENDIF
3327:             loc_cSQLFpg = "SELECT TpVencs, Entradas, Dias, tVens FROM SigOpFp " + ;
3328:                 "WHERE Fpags = " + EscaparSQL(loc_cFpgAtual)
3329:             loc_nErro   = SQLEXEC(gnConnHandle, loc_cSQLFpg, "cursor_4c_FpgVenc")
3330:             SELECT (par_cCursor)
3331: 
3332:             IF loc_nErro >= 1 AND USED("cursor_4c_FpgVenc") AND cursor_4c_FpgVenc.TpVencs = 2
3333:                 loc_dVenc       = ConverterParaData(TprMvCab.PrazoEnts) + cursor_4c_FpgVenc.Entradas
3334:                 loc_nDias       = cursor_4c_FpgVenc.Dias
3335:                 loc_cTipoVenc   = cursor_4c_FpgVenc.tVens
3336:                 loc_cFpgAtual   = Fpags
3337:                 loc_cIdTefAtual = CnIdTefs
3338: 
3339:                 SCAN WHILE Fpags = loc_cFpgAtual AND CnIdTefs = loc_cIdTefAtual
3340:                     loc_dVenc = THIS.AvancarAlemDosFeriados(loc_dVenc)
3341:                     REPLACE Vencs WITH loc_dVenc IN (par_cCursor)
3342: 
3343:                     IF par_lAtualizarBanco
3344:                         loc_cCidChave  = CidChaves
3345:                         loc_cSQLUpdate = "UPDATE SigMvPar SET Vencs = " + ;
3346:                             FormatarDataSQL(loc_dVenc) + " WHERE CidChaves = " + ;
3347:                             EscaparSQL(loc_cCidChave)
3348:                         IF SQLEXEC(gnConnHandle, loc_cSQLUpdate) < 1
3349:                             MsgErro("Favor reinicializar o processo." + CHR(13) + ;
3350:                                 "Falha na conex" + CHR(227) + "o (Update SigMvPar)", "Erro")
3351:                         ENDIF

*-- Linhas 3367 a 3410:
3367:     * ("|AAAAMMDD|..."), mesmo padrao de FormSigOpFpg.CarregarFeriados -
3368:     * evita um SELECT por parcela dentro do laco de recalculo.
3369:     *==========================================================================
3370:     PROTECTED PROCEDURE CarregarFeriados()
3371:         LOCAL loc_cSQL, loc_nResultado, loc_cLista, loc_oErro
3372: 
3373:         IF THIS.this_lFeriadosCarregados
3374:             RETURN .T.
3375:         ENDIF
3376: 
3377:         loc_cLista = "|"
3378: 
3379:         TRY
3380:             IF USED("cursor_4c_FerLoad")
3381:                 USE IN SELECT("cursor_4c_FerLoad")
3382:             ENDIF
3383: 
3384:             loc_cSQL = "SELECT DISTINCT datas FROM SigCdFer"
3385: 
3386:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FerLoad")
3387: 
3388:             IF loc_nResultado > 0 AND USED("cursor_4c_FerLoad")
3389:                 SELECT cursor_4c_FerLoad
3390:                 SCAN
3391:                     IF !ISNULL(datas) AND !EMPTY(datas)
3392:                         loc_cLista = loc_cLista + DTOS(ConverterParaData(datas)) + "|"
3393:                     ENDIF
3394:                 ENDSCAN
3395:                 USE IN SELECT("cursor_4c_FerLoad")
3396:             ENDIF
3397: 
3398:             THIS.this_cFeriadosCache      = loc_cLista
3399:             THIS.this_lFeriadosCarregados = .T.
3400:         CATCH TO loc_oErro
3401:             THIS.this_cFeriadosCache = "|"
3402:         ENDTRY
3403: 
3404:         RETURN .T.
3405:     ENDPROC
3406: 
3407:     *==========================================================================
3408:     * AvancarAlemDosFeriados - laco de feriados do btnSelItens.Click legado:
3409:     *
3410:     *   lnFer = 0 / Verd = .t.

*-- Linhas 3449 a 3554:
3449:     ENDFUNC
3450: 
3451:     *==========================================================================
3452:     * FecharDialogo - "PROCEDURE return" do legado:
3453:     *
3454:     *   If ThisForm.Direta
3455:     *       [ver ProcessarLancamentoDireto()]
3456:     *   Endif
3457:     *   ThisForm.parentform.enabled = .T.
3458:     *   thisform.parentform.validok = thisform.validok
3459:     *   ThisForm.parentform.pagina.dados.dados.setfocus
3460:     *   ThisForm.release
3461:     *
3462:     * "ThisForm.parentform.enabled = .T." ja acontece em Destroy()
3463:     * (ReabilitarFormPai(), Fase 3) - Release() dispara Destroy() antes de
3464:     * destruir o objeto, entao nao duplicado aqui.
3465:     *
3466:     * "ThisForm.parentform.pagina.dados.dados.setfocus" refere-se a um
3467:     * controle especifico do form pai (frmcadastro legado) sem equivalente
3468:     * conhecido nesta migracao - nenhum caller de Formsigopinf existe no
3469:     * acervo (ver cabecalho do arquivo) para definir esse equivalente.
3470:     * Omitido, documentado, nao inventado.
3471:     *
3472:     * THIS.Release() (nao Hide()): esta classe NAO isola DataSession (fica
3473:     * no default = 1, ver comentario de cabecalho "DataSession") - ao
3474:     * contrario de FormSigOpFpg (DataSession = 2), nao ha razao para
3475:     * sobreviver ao fechamento, e Release() e transcricao fiel do
3476:     * "ThisForm.release" legado.
3477:     *
3478:     * PUBLIC: alvo de chamada de BtnSalvarClick() (fim de cada ramo) e do
3479:     * form pai, se precisar fechar o dialogo por codigo.
3480:     *==========================================================================
3481:     PROCEDURE FecharDialogo()
3482:         THIS.ProcessarLancamentoDireto()
3483: 
3484:         IF VARTYPE(THIS.this_oFormPai) = "O" ;
3485:            AND PEMSTATUS(THIS.this_oFormPai, "this_lValidOk", 5)
3486:             THIS.this_oFormPai.this_lValidOk = THIS.this_lValidOk
3487:         ENDIF
3488: 
3489:         THIS.Release()
3490:     ENDPROC
3491: 
3492:     *==========================================================================
3493:     * ProcessarLancamentoDireto - ramo "If ThisForm.Direta" do "PROCEDURE
3494:     * return" legado:
3495:     *
3496:     *   Select CrSigMvCab / Zap / Select TprMvCab / Scatter Memvar memo /
3497:     *   Select CrSigMvCab / Append Blank / Gather Memvar Memo
3498:     *   lcSql = Select a.*, b.TpVencs,b.Entradas,b.dias,b.tVens From SigMvPar a,
3499:     *       SigOpFp b where a.EmpDopNums = <TprMvCab.EmpDopNums> And a.Fpags = b.fpags
3500:     *   Select LocalPar / Index on Fpags+cnidTefs+Str(Parcs,2) Tag FpagV / Scan
3501:     *       [recalculo de vencimentos + Update SigMvPar - ver
3502:     *        RecalcularVencimentosParcelas]
3503:     *   EndScan
3504:     *   llOk = UpDate('CrSigMvCab') And Commit() > 0 / If !llOk -> RollBack()
3505:     *   Select TprMvCab / Zap
3506:     *
3507:     * CrSigMvCab (cursor de BATCH do lancamento direto) e o commit em lote
3508:     * (ThisForm.ParentForm.PoDataMgr.UpDate/Commit/RollBack) pertencem ao
3509:     * form PAI/orquestrador da operacao, inexistente nesta migracao (nenhum
3510:     * caller de Formsigopinf no acervo - ver cabecalho do arquivo). Falso
3511:     * seguro: sem CrSigMvCab, o bloco INTEIRO fica de fora - inclusive o
3512:     * recalculo de SigMvPar (que so faz sentido acoplado ao commit em lote)
3513:     * e o "Select TprMvCab / Zap" final, que SEM o lote persistido em outro
3514:     * lugar destruiria os dados do usuario (regra CLAUDE.md #17 - nao
3515:     * reproduzir so a metade de uma formula/fluxo que depende do resto).
3516:     *
3517:     * PROTECTED: so FecharDialogo(), desta mesma classe, chama.
3518:     *==========================================================================
3519:     PROTECTED PROCEDURE ProcessarLancamentoDireto()
3520:         LOCAL loc_cSQL, loc_nErro
3521: 
3522:         IF !THIS.this_lDireta OR !USED("CrSigMvCab") OR !USED("TprMvCab")
3523:             RETURN
3524:         ENDIF
3525: 
3526:         IF EMPTY(TprMvCab.EmpDopNums)
3527:             RETURN
3528:         ENDIF
3529: 
3530:         IF USED("LocalPar")
3531:             USE IN LocalPar
3532:         ENDIF
3533:         loc_cSQL = "SELECT a.*, b.TpVencs, b.Entradas, b.Dias, b.tVens " + ;
3534:             "FROM SigMvPar a, SigOpFp b " + ;
3535:             "WHERE a.EmpDopNums = " + EscaparSQL(TprMvCab.EmpDopNums) + " " + ;
3536:             "AND a.Fpags = b.Fpags"
3537:         loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "LocalPar")
3538:         IF loc_nErro < 1
3539:             MsgErro("Favor reinicializar o processo." + CHR(13) + ;
3540:                 "Falha na conex" + CHR(227) + "o ( LocalPar )", "Erro")
3541:             RETURN
3542:         ENDIF
3543: 
3544:         THIS.RecalcularVencimentosParcelas("LocalPar", .T.)
3545: 
3546:         IF USED("LocalPar")
3547:             USE IN LocalPar
3548:         ENDIF
3549: 
3550:         *-- Commit em lote (CrSigMvCab) fora do escopo desta migracao - ver
3551:         *-- comentario de cabecalho do metodo.
3552:     ENDPROC
3553: 
3554: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigopinfBO.prg):
*====================================================================
* sigopinfBO.prg
*
* Business Object para o dialogo "Informacoes Gerais" (SIGOPINF)
* Entidade base: SigMvCab (cabecalho do movimento/operacao)
* Herda de: BusinessBase
*
* NOTA: SIGOPINF e um dialogo FILHO, aberto pelo form de cabecalho da
* operacao (ParentForm) e que edita um SUBCONJUNTO de colunas do cursor
* TprMvCab (cursor de trabalho do pai, equivalente a SigMvCab). Este BO
* nao persiste diretamente em SigMvCab - quem grava o cabecalho e o
* form pai, quando a operacao principal e salva (os controles desta
* tela ja escrevem direto em TprMvCab via ControlSource).
*
* O UNICO caminho de gravacao direta no legado (SIGOPINF.cntBotoes.Click,
* ramo Else) acontece em modo CONSULTAR, quando o usuario tem acesso
* ALTINFO liberado: um UPDATE pontual da coluna Obses, pela chave
* CidChaves. E esse caminho que Atualizar() reproduz aqui.
*
* Nomes de coluna confirmados em docs/schema.sql (UTF-16) e no dump
* SIGOPINF.ControlSource (tasks/task751/sigopinf_form_codigo_fonte.txt):
*   cntVolumes.getQtds      -> Qtdes       (numeric)
*   cntVolumes.getEspes     -> Espes       (char)
*   cntVolumes.getPLiqs     -> PLiqs       (numeric)
*   cntVolumes.getPBrus     -> PBrus       (numeric)
*   cntVolumes.getValTrans  -> ValTrans    (numeric)
*   cntObservacao.getCodObs -> CodObs      (numeric)
*   cntObservacao.getDesObs -> Obses       (text/memo)
*   CntObs2.btnMultObs      -> CodObs2     (char)
*   cntProtocolo.getProtocolos -> Protats  (numeric)
*   cntEntrega.getContas    -> ContaEs     (char)
*   cntCodigos.getCodigos   -> MascNum     (char)
*   cntDocumentos.getDocumentos -> Notas   (char)
*   cntDocumentos.GetNumeroNota -> NumeroNota (char)
*   cntEcfs.getEcfs         -> Ecfs        (char)
*   cntNemps.getNemps       -> Nemps       (char)
*   cntEmiss.getEmiss       -> DtEmis      (datetime)
*   cntEntregas.getEntregas -> PrazoEnts   (datetime)
*   cntRecepcaos.getRecepcaos -> DtRecs    (datetime)
*   cntPrzEnts.getPrzEnts   -> PrzClis     (datetime)
*   cntPedido.getPedido     -> nPedClis    (numeric)
*   cntLivre.getNLivDg      -> NLivDg      (numeric)
*====================================================================

DEFINE CLASS sigopinfBO AS BusinessBase

    *-- Identificacao do movimento (TprMvCab - chave posicional)
    this_cEmps        = ""    && TprMvCab.Emps char(3) - empresa
    this_cDopes       = ""    && TprMvCab.Dopes char(20) - tipo de documento/operacao
    this_nNumes       = 0     && TprMvCab.Numes numeric - numero do documento
    this_cEmpDopNums  = ""    && TprMvCab.EmpDopNums char(29) - chave posicional (Emps + Dopes + Str(Numes,6))
    this_cCidChaves   = ""    && TprMvCab.CidChaves char - chave do registro, usada no UPDATE pontual de Obses (modo CONSULTAR + acesso ALTINFO)

    *-- Datas (containers cntEmiss/cntEntregas/cntPrzEnts/cntRecepcaos)
    this_dDatas       = {}    && TprMvCab.Datas - data do movimento (usada em validacoes de prazo; nao editavel nesta tela)
    this_dDtEmis      = {}    && TprMvCab.DtEmis - data de emissao do documento
    this_dPrazoEnts   = {}    && TprMvCab.PrazoEnts - prazo de entrega
    this_dPrzClis     = {}    && TprMvCab.PrzClis - data prometida ao cliente
    this_dRecepcaos   = {}    && TprMvCab.DtRecs - data de recepcao

    *-- Contas (container cntEntrega - conta/nome/cpf-cnpj da entrega)
    this_cContaDs     = ""    && TprMvCab.ContaDs - conta (duplicata)
    this_cContaOs     = ""    && TprMvCab.ContaOs - conta (ordem de servico)
    this_cContaEs     = ""    && TprMvCab.ContaEs - conta de entrega
    this_cDescContaEs = ""    && Nome/razao social da conta de entrega (consulta auxiliar SigCdCli - NAO persistido em TprMvCab)
    this_cCpfContaEs  = ""    && CPF/CNPJ da conta de entrega (consulta auxiliar SigCdCli - NAO persistido em TprMvCab)

    *-- Observacoes (container cntObservacao/CntObs2)
    this_nCodObs      = 0     && TprMvCab.CodObs - codigo da observacao (crSigCdObs.Codigos)
    this_cObses       = ""    && TprMvCab.Obses - texto da observacao (memo)
    this_cCodObs2     = ""    && TprMvCab.CodObs2 - codigos de observacoes de finalidade (lista concatenada)

    *-- Entrega/protocolo/documentos
    this_nLocalEnts   = 0     && TprMvCab.LocalEnts numeric - codigo do endereco alternativo de entrega (SigCdCee.Codigos)
    this_nProtocolos  = 0     && TprMvCab.Protats numeric - protocolo
    this_cCodigos     = ""    && TprMvCab.MascNum - mascara/codigo de referencia da tela (cntCodigos)
    this_cDocumentos  = ""    && TprMvCab.Notas - numero do documento
    this_cNumeroNota  = ""    && TprMvCab.NumeroNota - numero da nota fiscal
    this_cEcfs        = ""    && TprMvCab.Ecfs - identificacao do ECF
    this_cNemps       = ""    && TprMvCab.Nemps - numero de serie da impressora fiscal (criptografado)
    this_nPedido      = 0     && TprMvCab.nPedClis numeric - numero do pedido
    this_nNLivDg      = 0     && TprMvCab.NLivDg numeric - numero do lacre

    *-- Volumes/transporte (container cntVolumes)
    this_nQtds        = 0     && TprMvCab.Qtdes - quantidade de volumes
    this_cEspes       = ""    && TprMvCab.Espes - especie do volume
    this_nPLiqs       = 0     && TprMvCab.PLiqs - peso liquido
    this_nPBrus       = 0     && TprMvCab.PBrus - peso bruto
    this_nValTrans    = 0     && TprMvCab.ValTrans - valor do transporte

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigMvCab"
            THIS.this_cCampoChave = "CidChaves"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - chave do registro corrente (TprMvCab.CidChaves)
    * Usada por RegistrarAuditoria() apos o UPDATE pontual de Obses.
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega as propriedades do BO a partir do cursor
    * de trabalho do form pai (TprMvCab). Cada campo e lido sob guarda de
    * TYPE() porque o alias recebido pode trazer so um subconjunto das
    * colunas (ex.: cursor de teste automatizado).
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                *-- Identificacao do movimento
                IF TYPE("Emps") != "U"
                    THIS.this_cEmps = TratarNulo(Emps, "C")
                ENDIF
                IF TYPE("Dopes") != "U"
                    THIS.this_cDopes = TratarNulo(Dopes, "C")
                ENDIF
                IF TYPE("Numes") != "U"
                    THIS.this_nNumes = TratarNulo(Numes, "N")
                ENDIF
                IF TYPE("EmpDopNums") != "U"
                    THIS.this_cEmpDopNums = TratarNulo(EmpDopNums, "C")
                ENDIF
                IF TYPE("CidChaves") != "U"
                    THIS.this_cCidChaves = TratarNulo(CidChaves, "C")
                ENDIF

                *-- Datas
                IF TYPE("Datas") != "U"
                    THIS.this_dDatas = TratarNulo(Datas, "D")
                ENDIF
                IF TYPE("DtEmis") != "U"
                    THIS.this_dDtEmis = TratarNulo(DtEmis, "D")
                ENDIF
                IF TYPE("PrazoEnts") != "U"
                    THIS.this_dPrazoEnts = TratarNulo(PrazoEnts, "D")
                ENDIF
                IF TYPE("PrzClis") != "U"
                    THIS.this_dPrzClis = TratarNulo(PrzClis, "D")
                ENDIF
                IF TYPE("DtRecs") != "U"
                    THIS.this_dRecepcaos = TratarNulo(DtRecs, "D")
                ENDIF

                *-- Contas
                IF TYPE("ContaDs") != "U"
                    THIS.this_cContaDs = TratarNulo(ContaDs, "C")
                ENDIF
                IF TYPE("ContaOs") != "U"
                    THIS.this_cContaOs = TratarNulo(ContaOs, "C")
                ENDIF
                IF TYPE("ContaEs") != "U"
                    THIS.this_cContaEs = TratarNulo(ContaEs, "C")
                ENDIF

                *-- Observacoes
                IF TYPE("CodObs") != "U"
                    THIS.this_nCodObs = TratarNulo(CodObs, "N")
                ENDIF
                IF TYPE("Obses") != "U"
                    THIS.this_cObses = TratarNulo(Obses, "C")
                ENDIF
                IF TYPE("CodObs2") != "U"
                    THIS.this_cCodObs2 = TratarNulo(CodObs2, "C")
                ENDIF

                *-- Entrega/protocolo/documentos
                IF TYPE("LocalEnts") != "U"
                    THIS.this_nLocalEnts = TratarNulo(LocalEnts, "N")
                ENDIF
                IF TYPE("Protats") != "U"
                    THIS.this_nProtocolos = TratarNulo(Protats, "N")
                ENDIF
                IF TYPE("MascNum") != "U"
                    THIS.this_cCodigos = TratarNulo(MascNum, "C")
                ENDIF
                IF TYPE("Notas") != "U"
                    THIS.this_cDocumentos = TratarNulo(Notas, "C")
                ENDIF
                IF TYPE("NumeroNota") != "U"
                    THIS.this_cNumeroNota = TratarNulo(NumeroNota, "C")
                ENDIF
                IF TYPE("Ecfs") != "U"
                    THIS.this_cEcfs = TratarNulo(Ecfs, "C")
                ENDIF
                IF TYPE("Nemps") != "U"
                    THIS.this_cNemps = TratarNulo(Nemps, "C")
                ENDIF
                IF TYPE("nPedClis") != "U"
                    THIS.this_nPedido = TratarNulo(nPedClis, "N")
                ENDIF
                IF TYPE("NLivDg") != "U"
                    THIS.this_nNLivDg = TratarNulo(NLivDg, "N")
                ENDIF

                *-- Volumes/transporte
                IF TYPE("Qtdes") != "U"
                    THIS.this_nQtds = TratarNulo(Qtdes, "N")
                ENDIF
                IF TYPE("Espes") != "U"
                    THIS.this_cEspes = TratarNulo(Espes, "C")
                ENDIF
                IF TYPE("PLiqs") != "U"
                    THIS.this_nPLiqs = TratarNulo(PLiqs, "N")
                ENDIF
                IF TYPE("PBrus") != "U"
                    THIS.this_nPBrus = TratarNulo(PBrus, "N")
                ENDIF
                IF TYPE("ValTrans") != "U"
                    THIS.this_nValTrans = TratarNulo(ValTrans, "N")
                ENDIF

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * Inserir - Nao aplicavel a este dialogo. O cabecalho do movimento
    * (SigMvCab) e criado pelo form PAI (operacao principal) quando a
    * operacao e salva; SIGOPINF so edita colunas do cursor TprMvCab
    * (ja atualizado em memoria pelos proprios controles via
    * ControlSource) e devolve o controle com ThisForm.Return.
    *====================================================================
    PROCEDURE Inserir()
        RETURN .F.
    ENDPROC

    *====================================================================
    * Atualizar - Reproduz o UNICO caminho de gravacao direta do legado
    * (SIGOPINF.cntBotoes.Click, ramo Else): em modo CONSULTAR, com
    * acesso ALTINFO liberado, confirma apenas a observacao (Obses) do
    * cabecalho, pela chave CidChaves. O Form e quem decide, antes de
    * chamar Salvar()/Atualizar(), se o acesso ALTINFO permite a acao -
    * este metodo so executa a gravacao em si.
    *====================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.
        TRY
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cMensagemErro = "Chave do registro n" + CHR(227) + "o informada."
            ELSE
                loc_cSQL = "UPDATE SigMvCab SET " + ;
                           "Obses = " + EscaparSQL(ALLTRIM(THIS.this_cObses)) + " " + ;
                           "WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChaves)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Erro ao atualizar a observa" + CHR(231) + CHR(227) + "o do movimento."
                    MsgErro(THIS.this_cMensagemErro, "Erro")
                ELSE
                    THIS.RegistrarAuditoria("A")
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

