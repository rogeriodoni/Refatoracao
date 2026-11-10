# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (7)
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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopinf.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (3573 linhas total):

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

*-- Linhas 282 a 499:
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
297:     *--------------------------------------------------------------------------
298:     * this_cUltimoCodObsLostFocusValidado - mesmo guard acima, para
299:     * CodObsLostFocus. O campo ja tem o guard por Tag (CodObsGotFocus/
300:     * CodObsLostFocus, transcricao literal do "This.Tag = Str(This.Value,10)"
301:     * legado), e esta propriedade reforca a mesma checagem pelo padrao
302:     * canonico do projeto (this_cUltimo<Campo>LostFocusValidado).
303:     *--------------------------------------------------------------------------
304:     this_cUltimoCodObsLostFocusValidado = ""
305: 
306:     *==========================================================================
307:     * Init - Recebe os 4 parametros do form pai e delega a FormBase.Init()
308:     *
309:     * A ordem posicional e IDENTICA ao Lparameters do legado
310:     *   (pForm, pData, plAltDireta, plAutomatico)
311:     * para que a chamada da tela de movimentacao
312:     *   CREATEOBJECT("Formsigopinf", THIS, <sessao>, <direta>, <automatico>)
313:     * seja transcricao direta do "Do Form SIGOPINF With ..." legado.
314:     *
315:     * Todos os argumentos sao OPCIONAIS: o harness de teste e os probes
316:     * headless instanciam o form sem nenhum deles, e nesse caso cada
317:     * propriedade mantem o default declarado acima.
318:     *
319:     * par_lDireta/par_lAutomatico usam PCOUNT() no guard, nao so VARTYPE: em
320:     * VFP9 parametro declarado e NAO passado chega como .F. LOGICO, de modo
321:     * que VARTYPE(par_lDireta) = "L" e verdade tanto para "nao passou" quanto
322:     * para "passou .F." - com default .F. o resultado coincide, mas o PCOUNT
323:     * deixa a intencao explicita e protege de uma futura troca de default.
324:     *==========================================================================
325:     PROCEDURE Init(par_oFormPai, par_nDataSessionPai, par_lDireta, par_lAutomatico)
326: 
327:         IF VARTYPE(par_oFormPai) = "O"
328:             THIS.this_oFormPai = par_oFormPai
329:         ENDIF
330: 
331:         IF VARTYPE(par_nDataSessionPai) = "N"
332:             THIS.this_nDataSessionPai = par_nDataSessionPai
333:         ENDIF
334: 
335:         IF PCOUNT() >= 3 AND VARTYPE(par_lDireta) = "L"
336:             THIS.this_lDireta = par_lDireta
337:         ENDIF
338: 
339:         IF PCOUNT() >= 4 AND VARTYPE(par_lAutomatico) = "L"
340:             THIS.this_lAutomatico = par_lAutomatico
341:         ENDIF
342: 
343:         *-- DODEFAULT() ja chama InicializarForm() atraves do FormBase.Init()
344:         RETURN DODEFAULT()
345:     ENDPROC
346: 
347:     *==========================================================================
348:     * InicializarForm - Cria o Business Object e monta a casca visual base
349:     *
350:     * Equivale ao trecho inicial do Init legado (captions do cabecalho,
351:     * ParentForm.Enabled = .f. e LockScreen) - a parte de CursorQuery/SQL do
352:     * Init legado pertence as fases de dados (4 em diante).
353:     *
354:     * RETURN unico DEPOIS do ENDTRY, com flag loc_lSucesso: RETURN dentro de
355:     * TRY/CATCH e proibido em VFP9.
356:     *==========================================================================
357:     PROTECTED PROCEDURE InicializarForm()
358:         LOCAL loc_lSucesso, loc_oErro
359:         loc_lSucesso = .F.
360: 
361:         THIS.LockScreen = .T.
362:         TRY
363:             THIS.this_oBusinessObject = CREATEOBJECT("sigopinfBO")
364: 
365:             IF VARTYPE(THIS.this_oBusinessObject) <> "O"
366:                 MsgErro("Erro ao criar sigopinfBO. VARTYPE retornou: " + ;
367:                     VARTYPE(THIS.this_oBusinessObject), "Formsigopinf.InicializarForm")
368:             ELSE
369:                 THIS.SincronizarEscolhaPai()
370:                 THIS.DesabilitarFormPai()
371:                 THIS.CarregarCursoresOperacao()
372:                 THIS.ConfigurarCabecalho()
373:                 THIS.ConfigurarBotoesAcao()
374:                 THIS.ConfigurarCamposDocumentos()
375:                 THIS.ConfigurarCamposDatas()
376:                 THIS.ConfigurarVolumes()
377:                 THIS.ConfigurarObservacao()
378:                 THIS.ConfigurarProtocolo()
379:                 THIS.ConfigurarEntrega()
380:                 THIS.ConfigurarPedido()
381:                 THIS.ConfigurarObs2()
382:                 THIS.ConfigurarLivre()
383:                 THIS.TornarControlesVisiveis(THIS)
384:                 THIS.AtualizarVisibilidadePorOperacao()
385:                 THIS.AjustarPosicaoCampos()
386: 
387:                 loc_lSucesso = .T.
388:             ENDIF
389:         CATCH TO loc_oErro
390:             MsgErro(loc_oErro.Message + CHR(13) + ;
391:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
392:                 "Procedure: " + loc_oErro.Procedure, "Erro em Formsigopinf.InicializarForm")
393:         ENDTRY
394:         THIS.LockScreen = .F.
395: 
396:         RETURN loc_lSucesso
397:     ENDPROC
398: 
399:     *==========================================================================
400:     * SincronizarEscolhaPai - copia this_cModoAtual do form pai, reproduzindo
401:     * ".pcEscolha = ThisForm.ParentForm.pcEscolha" do Init legado. Guardado
402:     * por PEMSTATUS porque o form pai e OPCIONAL (probe headless) e porque
403:     * nesta arquitetura o nome da propriedade de modo e this_cModoAtual
404:     * (FormBase), nao o "pcEscolha" literal do legado.
405:     *==========================================================================
406:     PROTECTED PROCEDURE SincronizarEscolhaPai()
407:         IF VARTYPE(THIS.this_oFormPai) = "O" ;
408:            AND PEMSTATUS(THIS.this_oFormPai, "this_cModoAtual", 5)
409:             THIS.this_cPcEscolha = THIS.this_oFormPai.this_cModoAtual
410:         ENDIF
411:     ENDPROC
412: 
413:     *==========================================================================
414:     * DesabilitarFormPai - "ThisForm.ParentForm.Enabled = .f." do Init legado.
415:     * Este dialogo nao e modal (o dump nao declara WindowType = 1), e o
416:     * legado impede a interacao com o pai desabilitando-o manualmente
417:     * enquanto a tela de informacoes esta aberta. Revertido em
418:     * ReabilitarFormPai(), chamado no Destroy().
419:     *==========================================================================
420:     PROTECTED PROCEDURE DesabilitarFormPai()
421:         IF VARTYPE(THIS.this_oFormPai) = "O"
422:             THIS.this_oFormPai.Enabled = .F.
423:         ENDIF
424:     ENDPROC
425: 
426:     *==========================================================================
427:     * ReabilitarFormPai - reverso de DesabilitarFormPai, chamado no Destroy().
428:     *==========================================================================
429:     PROTECTED PROCEDURE ReabilitarFormPai()
430:         IF VARTYPE(THIS.this_oFormPai) = "O"
431:             THIS.this_oFormPai.Enabled = .T.
432:         ENDIF
433:     ENDPROC
434: 
435:     *==========================================================================
436:     * ConfigurarCabecalho - Faixa cinza do topo (cntSombra do legado) com o
437:     * titulo do form desenhado duas vezes: lblSombra em preto atras e
438:     * lblTitulo em branco por cima, 1px acima, o que produz o relevo -
439:     * exatamente como o Init legado faz nas duas primeiras linhas:
440:     *   ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption
441:     *   ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption
442:     *
443:     * Geometria transcrita do dump (layout.json), com UMA correcao
444:     * deliberada de Width: o SCX declara cntSombra.Width = 1100 e os dois
445:     * labels com Width = 769, enquanto o proprio Form tem Width = 1000 - o
446:     * container do cabecalho foi desenhado no Form Designer mais largo que a
447:     * janela (sobreposicao herdada do SCX, regra #28/#30). Copiar os
448:     * literais deixaria uma faixa clara exposta a direita ou cortaria o
449:     * titulo. Por isso o container acompanha THIS.Width e os labels ficam em
450:     * THIS.Width - 20, que com Left = 10 fecha exatamente na borda.
451:     * Top/Height/Font/ForeColor/Alignment/BackStyle seguem o dump.
452:     *
453:     * AutoSize = .F. explicito: o dump declara WordWrap = .T. nos dois
454:     * labels, e AutoSize em Label criado por AddObject e no-op para a
455:     * largura e, com WordWrap, chega a DESCARTAR a Height - a legenda
456:     * colapsaria para uma linha (regra #23). Width e Height vem do dump, que
457:     * ja sao o auto-size calculado pelo Form Designer.
458:     *==========================================================================
459:     PROTECTED PROCEDURE ConfigurarCabecalho()
460:         LOCAL loc_oCnt
461: 
462:         THIS.AddObject("cnt_4c_Sombra", "Container")
463:         loc_oCnt = THIS.cnt_4c_Sombra
464:         WITH loc_oCnt
465:             .Top         = 0
466:             .Left        = 0
467:             .Width       = THIS.Width
468:             .Height      = 80
469:             .BorderWidth = 0
470:             .BackColor   = RGB(100, 100, 100)
471:             .Visible     = .T.
472:         ENDWITH
473: 
474:         loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
475:         WITH loc_oCnt.lbl_4c_LblSombra
476:             .FontBold  = .T.
477:             .FontName  = "Tahoma"
478:             .FontSize  = 18
479:             .WordWrap  = .T.
480:             .Alignment = 0
481:             .BackStyle = 0
482:             .AutoSize  = .F.
483:             .Caption   = THIS.Caption
484:             .Left      = 10
485:             .Top       = 18
486:             .Width     = THIS.Width - 20
487:             .Height    = 40
488:             .ForeColor = RGB(0, 0, 0)
489:             .Visible   = .T.
490:         ENDWITH
491: 
492:         loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
493:         WITH loc_oCnt.lbl_4c_LblTitulo
494:             .FontBold  = .T.
495:             .FontName  = "Tahoma"
496:             .FontSize  = 18
497:             .WordWrap  = .T.
498:             .Alignment = 0
499:             .BackStyle = 0

*-- Linhas 528 a 702:
528:     * (FormSigPrCtc/FormSigOpEnt) e tem Click com logica COMPLETA nesta
529:     * fase - nao dependem de nenhum container criado em fase posterior.
530:     *==========================================================================
531:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
532:         LOCAL loc_oGrp
533: 
534:         *-- obj_4c_CntBotoes: botao "Salvar" (Click -> BtnSalvarClick, Fase 8)
535:         THIS.AddObject("obj_4c_CntBotoes", "CommandGroup")
536:         loc_oGrp = THIS.obj_4c_CntBotoes
537:         WITH loc_oGrp
538:             .Top           = -2
539:             .Left          = 920
540:             .Width         = 85
541:             .Height        = 85
542:             .ButtonCount   = 1
543:             .BackStyle     = 0
544:             .BorderStyle   = 0
545:             .SpecialEffect = 1
546:             .Visible       = .T.
547:         ENDWITH
548:         WITH loc_oGrp.Buttons(1)
549:             .Top             = 5
550:             .Left            = 5
551:             .Width           = 75
552:             .Height          = 75
553:             .FontBold        = .T.
554:             .FontItalic      = .T.
555:             .FontName        = "Tahoma"
556:             .FontSize        = 8
557:             .WordWrap        = .T.
558:             .PicturePosition = 13
559:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
560:             .Caption         = "\<Salvar"
561:             .MousePointer    = 15
562:             .ToolTipText     = "Gravar os Dados Informados"
563:             .SpecialEffect   = 0
564:             .ForeColor       = RGB(90, 90, 90)
565:             .BackColor       = RGB(255, 255, 255)
566:             .Themes          = .F.
567:         ENDWITH
568:         BINDEVENT(loc_oGrp, "Click", THIS, "BtnSalvarClick")
569: 
570:         *-- obj_4c_CmdCotacao: abre FormSigPrCtc (cmdCotacao.Valid legado)
571:         THIS.AddObject("obj_4c_CmdCotacao", "CommandGroup")
572:         loc_oGrp = THIS.obj_4c_CmdCotacao
573:         WITH loc_oGrp
574:             .Top           = -2
575:             .Left          = 845
576:             .Width         = 85
577:             .Height        = 85
578:             .ButtonCount   = 1
579:             .BackStyle     = 0
580:             .BorderStyle   = 0
581:             .SpecialEffect = 1
582:             .Visible       = .T.
583:         ENDWITH
584:         WITH loc_oGrp.Buttons(1)
585:             .Top             = 5
586:             .Left            = 5
587:             .Width           = 75
588:             .Height          = 75
589:             .FontBold        = .T.
590:             .FontItalic      = .T.
591:             .FontName        = "Tahoma"
592:             .FontSize        = 8
593:             .WordWrap        = .T.
594:             .PicturePosition = 13
595:             .Picture         = gc_4c_CaminhoIcones + "geral_cambio_60.jpg"
596:             .Caption         = "\<Cota" + CHR(231) + CHR(227) + "o"
597:             .MousePointer    = 15
598:             .ToolTipText     = "Alterar Cota" + CHR(231) + CHR(227) + "o Informativa"
599:             .SpecialEffect   = 0
600:             .ForeColor       = RGB(90, 90, 90)
601:             .BackColor       = RGB(255, 255, 255)
602:             .Themes          = .F.
603:         ENDWITH
604:         BINDEVENT(loc_oGrp, "Click", THIS, "CmdCotacaoClick")
605: 
606:         *-- obj_4c_CmdEntrega: abre FormSigOpEnt (cmdEntrega.Valid legado)
607:         THIS.AddObject("obj_4c_CmdEntrega", "CommandGroup")
608:         loc_oGrp = THIS.obj_4c_CmdEntrega
609:         WITH loc_oGrp
610:             .Top           = -2
611:             .Left          = 770
612:             .Width         = 85
613:             .Height        = 85
614:             .ButtonCount   = 1
615:             .BackStyle     = 0
616:             .BorderStyle   = 0
617:             .SpecialEffect = 1
618:             .Visible       = .T.
619:         ENDWITH
620:         WITH loc_oGrp.Buttons(1)
621:             .Top             = 5
622:             .Left            = 5
623:             .Width           = 75
624:             .Height          = 75
625:             .FontBold        = .T.
626:             .FontItalic      = .T.
627:             .FontName        = "Comic Sans MS"
628:             .FontSize        = 8
629:             .WordWrap        = .T.
630:             .PicturePosition = 13
631:             .Picture         = gc_4c_CaminhoIcones + "geral_relogio_60.jpg"
632:             .Caption         = "\<Entrega"
633:             .MousePointer    = 15
634:             .ToolTipText     = "Alterar Prazo de Entrega <F3>"
635:             .SpecialEffect   = 0
636:             .ForeColor       = RGB(90, 90, 90)
637:             .BackColor       = RGB(255, 255, 255)
638:             .Themes          = .F.
639:         ENDWITH
640:         BINDEVENT(loc_oGrp, "Click", THIS, "CmdEntregaClick")
641: 
642:         THIS.AtualizarVisibilidadeCmdEntrega()
643:     ENDPROC
644: 
645:     *==========================================================================
646:     * ConfigurarCamposDocumentos - cntCodigos/cntDocumentos/cntEcfs/cntNemps
647:     * (layout.json/mapeamento.json: cnt_4c_Codigos/cnt_4c_Documentos/
648:     * cnt_4c_Ecfs/cnt_4c_Nemps). Geometria e propriedades transcritas do
649:     * dump (SECAO 2 de sigopinf_form_codigo_fonte.txt) - containers com
650:     * BackStyle = 0 (transparentes, mostram o BackColor cinza do Form) e
651:     * labels classe "say" com ForeColor = RGB(90,90,90) EXPLICITO no dump
652:     * (nao e o default inferido da regra #12 - aqui o legado DECLARA esse
653:     * valor, entao e so transcricao).
654:     *
655:     * Todos os TextBox tem ControlSource = "TprMvCab.<col>" - igual ao
656:     * legado, estes controles escrevem direto no cursor de trabalho do
657:     * form pai. Sem TprMvCab aberto (harness/probe headless), a atribuicao
658:     * de ControlSource e pulada (regra: Alias inexistente estoura ao
659:     * atribuir ControlSource, nao so ao exibir) e os campos ficam sem
660:     * binding, inofensivo fora do fluxo real.
661:     *==========================================================================
662:     PROTECTED PROCEDURE ConfigurarCamposDocumentos()
663:         LOCAL loc_oCnt, loc_lTemCursorPai
664:         loc_lTemCursorPai = USED("TprMvCab")
665: 
666:         *-- cnt_4c_Codigos (legado: cntCodigos) -----------------------------
667:         THIS.AddObject("cnt_4c_Codigos", "Container")
668:         loc_oCnt = THIS.cnt_4c_Codigos
669:         WITH loc_oCnt
670:             .Top         = 96
671:             .Left        = 2
672:             .Width       = 67
673:             .Height      = 45
674:             .BackStyle   = 0
675:             .BorderWidth = 0
676:             .Visible     = .T.
677:         ENDWITH
678: 
679:         loc_oCnt.AddObject("lbl_4c_LblCodigos", "Label")
680:         WITH loc_oCnt.lbl_4c_LblCodigos
681:             .FontBold  = .F.
682:             .FontName  = "Tahoma"
683:             .FontSize  = 8
684:             .BackStyle = 0
685:             .Alignment = 0
686:             .AutoSize  = .F.
687:             .Caption   = "C" + CHR(243) + "digo "
688:             .Left      = 3
689:             .Top       = 3
690:             .Width     = 61
691:             .ForeColor = RGB(90, 90, 90)
692:             .Visible   = .T.
693:         ENDWITH
694: 
695:         loc_oCnt.AddObject("txt_4c_Codigos", "TextBox")
696:         WITH loc_oCnt.txt_4c_Codigos
697:             .FontBold      = .T.
698:             .FontSize      = 8
699:             .Left          = 3
700:             .Top           = 20
701:             .Width         = 61
702:             .MaxLength     = 10

*-- Linhas 708 a 831:
708:         IF loc_lTemCursorPai
709:             loc_oCnt.txt_4c_Codigos.ControlSource = "TprMvCab.mascnum"
710:         ENDIF
711:         BINDEVENT(loc_oCnt.txt_4c_Codigos, "When", THIS, "CodigosWhen")
712: 
713:         *-- cnt_4c_Documentos (legado: cntDocumentos) -----------------------
714:         THIS.AddObject("cnt_4c_Documentos", "Container")
715:         loc_oCnt = THIS.cnt_4c_Documentos
716:         WITH loc_oCnt
717:             .Top         = 96
718:             .Left        = 69
719:             .Width       = 170
720:             .Height      = 45
721:             .BackStyle   = 0
722:             .BorderWidth = 0
723:             .Visible     = .T.
724:         ENDWITH
725: 
726:         loc_oCnt.AddObject("lbl_4c_LblDocumentos", "Label")
727:         WITH loc_oCnt.lbl_4c_LblDocumentos
728:             .FontBold  = .F.
729:             .FontName  = "Tahoma"
730:             .FontSize  = 8
731:             .BackStyle = 0
732:             .Alignment = 0
733:             .AutoSize  = .F.
734:             .Caption   = "Documento"
735:             .Left      = 3
736:             .Top       = 3
737:             .Width     = 56
738:             .ForeColor = RGB(90, 90, 90)
739:             .Visible   = .T.
740:         ENDWITH
741: 
742:         loc_oCnt.AddObject("txt_4c_Documentos", "TextBox")
743:         WITH loc_oCnt.txt_4c_Documentos
744:             .Left          = 3
745:             .Top           = 20
746:             .Width         = 67
747:             .Margin        = 0
748:             .MaxLength     = 6
749:             .SpecialEffect = 1
750:             .ForeColor     = RGB(0, 0, 0)
751:             .BorderColor   = RGB(100, 100, 100)
752:             .Visible       = .T.
753:         ENDWITH
754:         IF loc_lTemCursorPai
755:             loc_oCnt.txt_4c_Documentos.ControlSource = "TprMvCab.notas"
756:         ENDIF
757:         BINDEVENT(loc_oCnt.txt_4c_Documentos, "When", THIS, "DocumentosWhen")
758: 
759:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
760:         WITH loc_oCnt.lbl_4c_Label1
761:             .FontBold  = .F.
762:             .FontName  = "Tahoma"
763:             .FontSize  = 8
764:             .BackStyle = 0
765:             .Alignment = 0
766:             .AutoSize  = .F.
767:             .Caption   = "Nota"
768:             .Left      = 73
769:             .Top       = 3
770:             .Width     = 25
771:             .ForeColor = RGB(90, 90, 90)
772:             .Visible   = .T.
773:         ENDWITH
774: 
775:         loc_oCnt.AddObject("txt_4c_NumeroNota", "TextBox")
776:         WITH loc_oCnt.txt_4c_NumeroNota
777:             .Left          = 73
778:             .Top           = 20
779:             .Width         = 94
780:             .Height        = 23
781:             .Margin        = 0
782:             .MaxLength     = 10
783:             .SpecialEffect = 1
784:             .ForeColor     = RGB(0, 0, 0)
785:             .BorderColor   = RGB(100, 100, 100)
786:             .Visible       = .T.
787:         ENDWITH
788:         IF loc_lTemCursorPai
789:             loc_oCnt.txt_4c_NumeroNota.ControlSource = "TprMvCab.NumeroNota"
790:         ENDIF
791:         BINDEVENT(loc_oCnt.txt_4c_NumeroNota, "When", THIS, "DocumentosWhen")
792: 
793:         *-- cnt_4c_Ecfs (legado: cntEcfs) ------------------------------------
794:         THIS.AddObject("cnt_4c_Ecfs", "Container")
795:         loc_oCnt = THIS.cnt_4c_Ecfs
796:         WITH loc_oCnt
797:             .Top         = 96
798:             .Left        = 240
799:             .Width       = 65
800:             .Height      = 45
801:             .BackStyle   = 0
802:             .BorderWidth = 0
803:             .Visible     = .T.
804:         ENDWITH
805: 
806:         loc_oCnt.AddObject("lbl_4c_LblEcfs", "Label")
807:         WITH loc_oCnt.lbl_4c_LblEcfs
808:             .FontBold  = .F.
809:             .FontName  = "Tahoma"
810:             .FontSize  = 8
811:             .BackStyle = 0
812:             .Alignment = 0
813:             .AutoSize  = .F.
814:             .Caption   = "ECF  "
815:             .Left      = 3
816:             .Top       = 3
817:             .Width     = 27
818:             .Height    = 15
819:             .ForeColor = RGB(90, 90, 90)
820:             .Visible   = .T.
821:         ENDWITH
822: 
823:         loc_oCnt.AddObject("txt_4c_Ecfs", "TextBox")
824:         WITH loc_oCnt.txt_4c_Ecfs
825:             .Left          = 3
826:             .Top           = 20
827:             .Width         = 59
828:             .Height        = 23
829:             .Margin        = 0
830:             .InputMask     = "9999999"
831:             .MaxLength     = 7

*-- Linhas 837 a 1301:
837:         IF loc_lTemCursorPai
838:             loc_oCnt.txt_4c_Ecfs.ControlSource = "TprMvCab.ecfs"
839:         ENDIF
840:         BINDEVENT(loc_oCnt.txt_4c_Ecfs, "When", THIS, "PadraoIncluirAlterarWhen")
841: 
842:         *-- cnt_4c_Nemps (legado: cntNemps) ----------------------------------
843:         THIS.AddObject("cnt_4c_Nemps", "Container")
844:         loc_oCnt = THIS.cnt_4c_Nemps
845:         WITH loc_oCnt
846:             .Top         = 96
847:             .Left        = 305
848:             .Width       = 156
849:             .Height      = 45
850:             .BackStyle   = 0
851:             .BorderWidth = 0
852:             .Visible     = .T.
853:         ENDWITH
854: 
855:         loc_oCnt.AddObject("lbl_4c_LblNemps", "Label")
856:         WITH loc_oCnt.lbl_4c_LblNemps
857:             .FontBold  = .F.
858:             .FontName  = "Tahoma"
859:             .FontSize  = 8
860:             .BackStyle = 0
861:             .Alignment = 0
862:             .AutoSize  = .F.
863:             .Caption   = "N" + CHR(186) + " S" + CHR(233) + "rie Imp."
864:             .Left      = 3
865:             .Top       = 3
866:             .Width     = 66
867:             .Height    = 15
868:             .ForeColor = RGB(90, 90, 90)
869:             .Visible   = .T.
870:         ENDWITH
871: 
872:         loc_oCnt.AddObject("txt_4c_Nemps", "TextBox")
873:         WITH loc_oCnt.txt_4c_Nemps
874:             .Left          = 3
875:             .Top           = 20
876:             .Width         = 150
877:             .Height        = 23
878:             .Margin        = 0
879:             .MaxLength     = 20
880:             .SpecialEffect = 1
881:             .ForeColor     = RGB(0, 0, 0)
882:             .BorderColor   = RGB(100, 100, 100)
883:             .Visible       = .T.
884:         ENDWITH
885:         IF loc_lTemCursorPai
886:             loc_oCnt.txt_4c_Nemps.ControlSource = "TprMvCab.nemps"
887:         ENDIF
888:         BINDEVENT(loc_oCnt.txt_4c_Nemps, "When",      THIS, "PadraoIncluirAlterarWhen")
889:         BINDEVENT(loc_oCnt.txt_4c_Nemps, "LostFocus",  THIS, "NempsLostFocus")
890:     ENDPROC
891: 
892:     *==========================================================================
893:     * CodigosWhen - "Return .f." do legado (getCodigos.When): o campo
894:     * Codigo/MascNum e so exibicao, nunca editavel em nenhum modo.
895:     *
896:     * PUBLIC: alvo de BINDEVENT("When").
897:     *==========================================================================
898:     FUNCTION CodigosWhen()
899:         RETURN .F.
900:     ENDFUNC
901: 
902:     *==========================================================================
903:     * DocumentosWhen - "Return ( Inlist( ThisForm.pcEscolha, 'INSERIR',
904:     * 'ALTERAR' ) And Not InList(crSigCdOpe.NFiscals,1,2) And Not
905:     * InList(CrSigCdOpe.DigDoc,4,5) )" do legado - compartilhado por
906:     * getDocumentos.When e GetNumeroNota.When (texto identico no dump).
907:     * crSigCdOpe e o cursor que o CursorQuery do Init legado popula (ainda
908:     * nao portado - fases seguintes); sem ele, falso seguro (campo fica
909:     * nao-editavel).
910:     *
911:     * PUBLIC: alvo de BINDEVENT("When").
912:     *==========================================================================
913:     FUNCTION DocumentosWhen()
914:         LOCAL loc_lPermite
915:         loc_lPermite = .F.
916: 
917:         IF INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR") AND USED("crSigCdOpe")
918:             loc_lPermite = !INLIST(crSigCdOpe.NFiscals, 1, 2) ;
919:                 AND !INLIST(crSigCdOpe.DigDoc, 4, 5)
920:         ENDIF
921: 
922:         RETURN loc_lPermite
923:     ENDFUNC
924: 
925:     *==========================================================================
926:     * PadraoIncluirAlterarWhen - "Return Inlist(ThisForm.pcEscolha,
927:     * 'INSERIR', 'ALTERAR')" do legado - texto IDENTICO em getEcfs.When,
928:     * getNemps.When, getEmiss.When, getRecepcaos.When e getPrzEnts.When
929:     * (compartilhado pelos cinco).
930:     *
931:     * PUBLIC: alvo de BINDEVENT("When").
932:     *==========================================================================
933:     FUNCTION PadraoIncluirAlterarWhen()
934:         RETURN INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
935:     ENDFUNC
936: 
937:     *==========================================================================
938:     * NempsLostFocus - "If Not Empty(This.Value) / lnNoFabr = This.Value /
939:     * lcImpf = fDecriptografar(alltrim(lnNoFabr)) / lcWhere = [Select *
940:     * From SIGFIMPF Where cimpfabs = ?lcImpf ] / ... MessageBox / Return
941:     * .f." do legado (getNemps.Valid). fDecriptografar e o wrapper de
942:     * utils/fdecriptografar.prg (regra #27 - algoritmo original fora do
943:     * acervo, pass-through seguro). Equivalente ao "ao sair do campo" do
944:     * Valid legado - ver regra #47 (lookup/validacao de TextBox solto vai
945:     * em LostFocus, nao em KeyPress).
946:     *
947:     * PUBLIC: alvo de BINDEVENT("LostFocus").
948:     *==========================================================================
949:     PROCEDURE NempsLostFocus()
950:         LOCAL loc_oTxt, loc_cImpf, loc_cSQL, loc_nErro, loc_oErro
951: 
952:         loc_oTxt = THIS.cnt_4c_Nemps.txt_4c_Nemps
953: 
954:         IF !EMPTY(loc_oTxt.Value)
955:             TRY
956:                 loc_cImpf = fDecriptografar(ALLTRIM(loc_oTxt.Value))
957:                 loc_cSQL  = "SELECT * FROM SIGFIMPF WHERE cimpfabs = " + EscaparSQL(loc_cImpf)
958:                 loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigFiMpF")
959: 
960:                 IF loc_nErro < 1
961:                     MsgErro("Favor reinicializar o processo." + CHR(13) + ;
962:                         "Falha na Conex" + CHR(227) + "o (SIGFIMPF)", "Erro")
963:                 ELSE
964:                     IF RECCOUNT("cursor_4c_SigFiMpF") = 0
965:                         MsgAviso("Impressora Fiscal n" + CHR(227) + "o Cadastrada!!", ;
966:                             "Aten" + CHR(231) + CHR(227) + "o")
967:                     ENDIF
968:                     IF USED("cursor_4c_SigFiMpF")
969:                         USE IN cursor_4c_SigFiMpF
970:                     ENDIF
971:                 ENDIF
972:             CATCH TO loc_oErro
973:                 MsgErro(loc_oErro.Message + CHR(13) + ;
974:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
975:                     "Erro ao validar N" + CHR(186) + " S" + CHR(233) + "rie")
976:             ENDTRY
977:         ENDIF
978:     ENDPROC
979: 
980:     *==========================================================================
981:     * ConfigurarCamposDatas - cntEmiss/cntEntregas/cntRecepcaos/cntPrzEnts
982:     * (cnt_4c_Emiss/cnt_4c_Entregas/cnt_4c_Recepcaos/cnt_4c_PrzEnts).
983:     * Classe "fweditdata" no legado -> TextBox com NullDisplay = "//" (data
984:     * vazia exibe barras, nao branco - propriedade nativa do TextBox,
985:     * confirmada em automation/propriedades_baseclasses.txt).
986:     *==========================================================================
987:     PROTECTED PROCEDURE ConfigurarCamposDatas()
988:         LOCAL loc_oCnt, loc_lTemCursorPai
989:         loc_lTemCursorPai = USED("TprMvCab")
990: 
991:         *-- cnt_4c_Emiss (legado: cntEmiss) ----------------------------------
992:         THIS.AddObject("cnt_4c_Emiss", "Container")
993:         loc_oCnt = THIS.cnt_4c_Emiss
994:         WITH loc_oCnt
995:             .Top         = 147
996:             .Left        = 2
997:             .Width       = 86
998:             .Height      = 45
999:             .BackStyle   = 0
1000:             .BorderWidth = 0
1001:             .Visible     = .T.
1002:         ENDWITH
1003: 
1004:         loc_oCnt.AddObject("lbl_4c_LblEmiss", "Label")
1005:         WITH loc_oCnt.lbl_4c_LblEmiss
1006:             .FontBold  = .F.
1007:             .FontName  = "Tahoma"
1008:             .FontSize  = 8
1009:             .BackStyle = 0
1010:             .Alignment = 0
1011:             .AutoSize  = .F.
1012:             .Caption   = "Data Emiss" + CHR(227) + "o "
1013:             .Left      = 3
1014:             .Top       = 3
1015:             .Width     = 80
1016:             .ForeColor = RGB(90, 90, 90)
1017:             .Visible   = .T.
1018:         ENDWITH
1019: 
1020:         loc_oCnt.AddObject("txt_4c_Emiss", "TextBox")
1021:         WITH loc_oCnt.txt_4c_Emiss
1022:             .Left          = 3
1023:             .Top           = 20
1024:             .Width         = 80
1025:             .Margin        = 0
1026:             .SpecialEffect = 1
1027:             .ForeColor     = RGB(0, 0, 0)
1028:             .BorderColor   = RGB(100, 100, 100)
1029:             .NullDisplay   = "//"
1030:             .Visible       = .T.
1031:         ENDWITH
1032:         IF loc_lTemCursorPai
1033:             loc_oCnt.txt_4c_Emiss.ControlSource = "TprMvCab.dtemis"
1034:         ENDIF
1035:         BINDEVENT(loc_oCnt.txt_4c_Emiss, "When",      THIS, "PadraoIncluirAlterarWhen")
1036:         BINDEVENT(loc_oCnt.txt_4c_Emiss, "LostFocus",  THIS, "EmissLostFocus")
1037: 
1038:         *-- cnt_4c_Entregas (legado: cntEntregas) ----------------------------
1039:         THIS.AddObject("cnt_4c_Entregas", "Container")
1040:         loc_oCnt = THIS.cnt_4c_Entregas
1041:         WITH loc_oCnt
1042:             .Top         = 147
1043:             .Left        = 88
1044:             .Width       = 86
1045:             .Height      = 45
1046:             .BackStyle   = 0
1047:             .BorderWidth = 0
1048:             .Visible     = .T.
1049:         ENDWITH
1050: 
1051:         loc_oCnt.AddObject("lbl_4c_LblEntregas", "Label")
1052:         WITH loc_oCnt.lbl_4c_LblEntregas
1053:             .FontBold  = .F.
1054:             .FontName  = "Tahoma"
1055:             .FontSize  = 8
1056:             .BackStyle = 0
1057:             .Alignment = 0
1058:             .AutoSize  = .F.
1059:             .Caption   = "Prz. Entrega "
1060:             .Left      = 3
1061:             .Top       = 3
1062:             .Width     = 80
1063:             .ForeColor = RGB(90, 90, 90)
1064:             .Visible   = .T.
1065:         ENDWITH
1066: 
1067:         loc_oCnt.AddObject("txt_4c_Entregas", "TextBox")
1068:         WITH loc_oCnt.txt_4c_Entregas
1069:             .Left          = 3
1070:             .Top           = 20
1071:             .Width         = 80
1072:             .Margin        = 0
1073:             .SpecialEffect = 1
1074:             .ForeColor     = RGB(0, 0, 0)
1075:             .BorderColor   = RGB(100, 100, 100)
1076:             .NullDisplay   = "//"
1077:             .Visible       = .T.
1078:         ENDWITH
1079:         IF loc_lTemCursorPai
1080:             loc_oCnt.txt_4c_Entregas.ControlSource = "TprMvCab.prazoents"
1081:         ENDIF
1082:         BINDEVENT(loc_oCnt.txt_4c_Entregas, "When",     THIS, "EntregasWhen")
1083:         BINDEVENT(loc_oCnt.txt_4c_Entregas, "LostFocus", THIS, "EntregasLostFocus")
1084: 
1085:         *-- cnt_4c_Recepcaos (legado: cntRecepcaos) --------------------------
1086:         THIS.AddObject("cnt_4c_Recepcaos", "Container")
1087:         loc_oCnt = THIS.cnt_4c_Recepcaos
1088:         WITH loc_oCnt
1089:             .Top         = 147
1090:             .Left        = 174
1091:             .Width       = 86
1092:             .Height      = 45
1093:             .BackStyle   = 0
1094:             .BorderWidth = 0
1095:             .Visible     = .T.
1096:         ENDWITH
1097: 
1098:         loc_oCnt.AddObject("lbl_4c_LblRecepcaos", "Label")
1099:         WITH loc_oCnt.lbl_4c_LblRecepcaos
1100:             .FontBold  = .F.
1101:             .FontName  = "Tahoma"
1102:             .FontSize  = 8
1103:             .BackStyle = 0
1104:             .Alignment = 0
1105:             .AutoSize  = .F.
1106:             .Caption   = "Recep" + CHR(231) + CHR(227) + "o "
1107:             .Left      = 3
1108:             .Top       = 3
1109:             .Width     = 80
1110:             .ForeColor = RGB(90, 90, 90)
1111:             .Visible   = .T.
1112:         ENDWITH
1113: 
1114:         loc_oCnt.AddObject("txt_4c_Recepcaos", "TextBox")
1115:         WITH loc_oCnt.txt_4c_Recepcaos
1116:             .Left          = 3
1117:             .Top           = 20
1118:             .Width         = 80
1119:             .Margin        = 0
1120:             .SpecialEffect = 1
1121:             .ForeColor     = RGB(0, 0, 0)
1122:             .BorderColor   = RGB(100, 100, 100)
1123:             .NullDisplay   = "//"
1124:             .Visible       = .T.
1125:         ENDWITH
1126:         IF loc_lTemCursorPai
1127:             loc_oCnt.txt_4c_Recepcaos.ControlSource = "TprMvCab.dtrecs"
1128:         ENDIF
1129:         BINDEVENT(loc_oCnt.txt_4c_Recepcaos, "When",     THIS, "PadraoIncluirAlterarWhen")
1130:         BINDEVENT(loc_oCnt.txt_4c_Recepcaos, "LostFocus", THIS, "RecepcaosLostFocus")
1131: 
1132:         *-- cnt_4c_PrzEnts (legado: cntPrzEnts) ------------------------------
1133:         THIS.AddObject("cnt_4c_PrzEnts", "Container")
1134:         loc_oCnt = THIS.cnt_4c_PrzEnts
1135:         WITH loc_oCnt
1136:             .Top         = 147
1137:             .Left        = 260
1138:             .Width       = 86
1139:             .Height      = 45
1140:             .BackStyle   = 0
1141:             .BorderWidth = 0
1142:             .Visible     = .T.
1143:         ENDWITH
1144: 
1145:         loc_oCnt.AddObject("lbl_4c_LblPrzEnts", "Label")
1146:         WITH loc_oCnt.lbl_4c_LblPrzEnts
1147:             .FontBold  = .F.
1148:             .FontName  = "Tahoma"
1149:             .FontSize  = 8
1150:             .BackStyle = 0
1151:             .Alignment = 0
1152:             .AutoSize  = .F.
1153:             .Caption   = "Dt. Prometida"
1154:             .Left      = 3
1155:             .Top       = 3
1156:             .Width     = 80
1157:             .ForeColor = RGB(90, 90, 90)
1158:             .Visible   = .T.
1159:         ENDWITH
1160: 
1161:         loc_oCnt.AddObject("txt_4c_PrzEnts", "TextBox")
1162:         WITH loc_oCnt.txt_4c_PrzEnts
1163:             .Left          = 3
1164:             .Top           = 20
1165:             .Width         = 80
1166:             .Margin        = 0
1167:             .SpecialEffect = 1
1168:             .ForeColor     = RGB(0, 0, 0)
1169:             .BorderColor   = RGB(100, 100, 100)
1170:             .NullDisplay   = "//"
1171:             .Visible       = .T.
1172:         ENDWITH
1173:         IF loc_lTemCursorPai
1174:             loc_oCnt.txt_4c_PrzEnts.ControlSource = "TprMvCab.PRZCLIS"
1175:         ENDIF
1176:         BINDEVENT(loc_oCnt.txt_4c_PrzEnts, "When",     THIS, "PadraoIncluirAlterarWhen")
1177:         BINDEVENT(loc_oCnt.txt_4c_PrzEnts, "LostFocus", THIS, "PrzEntsLostFocus")
1178:     ENDPROC
1179: 
1180:     *==========================================================================
1181:     * EntregasWhen - "Return Inlist(ThisForm.pcEscolha, 'INSERIR')" do
1182:     * legado (getEntregas.When) - UNICO dos 4 campos de data desta fase que
1183:     * so libera em INSERIR (os outros liberam INSERIR E ALTERAR). Depois do
1184:     * registro incluido, Prz. Entrega so muda pelo cmdEntrega (Fase 4,
1185:     * CmdEntregaClick), que grava TprMvCab.PrazoEnts e espelha no campo.
1186:     *
1187:     * PUBLIC: alvo de BINDEVENT("When").
1188:     *==========================================================================
1189:     FUNCTION EntregasWhen()
1190:         RETURN INLIST(THIS.this_cPcEscolha, "INSERIR")
1191:     ENDFUNC
1192: 
1193:     *==========================================================================
1194:     * ValidarDataMinima - "If Not IsEmpty(This.Value) And This.Value <
1195:     * Ctod('01/01/1900') / MessageBox('Data incorreta. Informe uma data
1196:     * Valida!!!!',0+16,'') / Return .f. / Endif" do legado - texto IDENTICO
1197:     * em getEmiss.Valid, getEntregas.Valid, getRecepcaos.Valid e
1198:     * getPrzEnts.Valid (compartilhado pelos quatro). MESSAGEBOX legado ->
1199:     * MsgAviso (validacao de UI, nao erro tecnico - regra do projeto).
1200:     *
1201:     * PROTECTED: chamado pelos handlers de LostFocus abaixo, nunca alvo
1202:     * direto de BINDEVENT.
1203:     *==========================================================================
1204:     PROTECTED FUNCTION ValidarDataMinima(par_oTxt)
1205:         LOCAL loc_lValido
1206:         loc_lValido = .T.
1207: 
1208:         IF !EMPTY(par_oTxt.Value) AND par_oTxt.Value < CTOD("01/01/1900")
1209:             MsgAviso("Data incorreta. Informe uma data v" + CHR(225) + "lida!!!!", ;
1210:                 "Aten" + CHR(231) + CHR(227) + "o")
1211:             loc_lValido = .F.
1212:         ENDIF
1213: 
1214:         RETURN loc_lValido
1215:     ENDFUNC
1216: 
1217:     *==========================================================================
1218:     * EmissLostFocus/EntregasLostFocus/RecepcaosLostFocus/PrzEntsLostFocus -
1219:     * equivalentes ao Valid legado (ao sair do campo - regra #47), cada um
1220:     * delegando a ValidarDataMinima() com o TextBox correspondente.
1221:     *
1222:     * PUBLIC: alvo de BINDEVENT("LostFocus").
1223:     *==========================================================================
1224:     PROCEDURE EmissLostFocus()
1225:         THIS.ValidarDataMinima(THIS.cnt_4c_Emiss.txt_4c_Emiss)
1226:     ENDPROC
1227: 
1228:     PROCEDURE EntregasLostFocus()
1229:         THIS.ValidarDataMinima(THIS.cnt_4c_Entregas.txt_4c_Entregas)
1230:     ENDPROC
1231: 
1232:     PROCEDURE RecepcaosLostFocus()
1233:         THIS.ValidarDataMinima(THIS.cnt_4c_Recepcaos.txt_4c_Recepcaos)
1234:     ENDPROC
1235: 
1236:     PROCEDURE PrzEntsLostFocus()
1237:         THIS.ValidarDataMinima(THIS.cnt_4c_PrzEnts.txt_4c_PrzEnts)
1238:     ENDPROC
1239: 
1240:     *==========================================================================
1241:     * AvisarLegadoNaoPortado - mesmo padrao de FormSigOpChi/Formsigopfis: a
1242:     * acao depende de um "Do Form"/funcao do legado que nao veio no acervo
1243:     * desta migracao. Usado so DEPOIS de tentar de verdade (CREATEOBJECT no
1244:     * CATCH, ou guarda explicita) - nunca no lugar da tentativa.
1245:     *==========================================================================
1246:     PROTECTED PROCEDURE AvisarLegadoNaoPortado(par_cDependencia, par_cAcao)
1247:         MsgAviso("Esta a" + CHR(231) + CHR(227) + "o depende de " + ;
1248:             ALLTRIM(par_cDependencia) + ", que n" + CHR(227) + "o veio no " + ;
1249:             "acervo migrado." + CHR(13) + CHR(13) + ;
1250:             "N" + CHR(227) + "o realizado: " + ALLTRIM(par_cAcao) + ".", ;
1251:             "Recurso Indispon" + CHR(237) + "vel")
1252:     ENDPROC
1253: 
1254:     *==========================================================================
1255:     * ConfigurarVolumes - cntVolumes (cnt_4c_Volumes): "Transporte" - 5
1256:     * campos de peso/volume do movimento. Geometria do dump (layout.json/
1257:     * sigopinf_form_codigo_fonte.txt SECAO 2). Todos com Alignment = 3
1258:     * (automatico - numerico alinha a direita) e ControlSource direto em
1259:     * TprMvCab, como no legado.
1260:     *==========================================================================
1261:     PROTECTED PROCEDURE ConfigurarVolumes()
1262:         LOCAL loc_oCnt, loc_lTemCursorPai
1263:         loc_lTemCursorPai = USED("TprMvCab")
1264: 
1265:         THIS.AddObject("cnt_4c_Volumes", "Container")
1266:         loc_oCnt = THIS.cnt_4c_Volumes
1267:         WITH loc_oCnt
1268:             .Top         = 264
1269:             .Left        = 488
1270:             .Width       = 509
1271:             .Height      = 66
1272:             .BackStyle   = 0
1273:             .BorderWidth = 0
1274:             .Visible     = .T.
1275:         ENDWITH
1276: 
1277:         loc_oCnt.AddObject("lbl_4c_Label16", "Label")
1278:         WITH loc_oCnt.lbl_4c_Label16
1279:             .FontBold  = .T.
1280:             .FontName  = "Tahoma"
1281:             .FontSize  = 8
1282:             .BackStyle = 0
1283:             .Alignment = 0
1284:             .AutoSize  = .F.
1285:             .Caption   = "Transporte"
1286:             .Left      = 3
1287:             .Top       = 3
1288:             .Width     = 100
1289:             .ForeColor = RGB(90, 90, 90)
1290:             .Visible   = .T.
1291:         ENDWITH
1292: 
1293:         loc_oCnt.AddObject("lbl_4c_LblQtds", "Label")
1294:         WITH loc_oCnt.lbl_4c_LblQtds
1295:             .FontName  = "Tahoma"
1296:             .FontSize  = 8
1297:             .BackStyle = 0
1298:             .Alignment = 0
1299:             .AutoSize  = .F.
1300:             .Caption   = "Qtde."
1301:             .Left      = 3

*-- Linhas 1324 a 1524:
1324:         IF loc_lTemCursorPai
1325:             loc_oCnt.txt_4c_Qtds.ControlSource = "TprMvCab.Qtdes"
1326:         ENDIF
1327:         BINDEVENT(loc_oCnt.txt_4c_Qtds, "When", THIS, "VolumesWhen")
1328: 
1329:         loc_oCnt.AddObject("lbl_4c_LblEspes", "Label")
1330:         WITH loc_oCnt.lbl_4c_LblEspes
1331:             .FontName  = "Tahoma"
1332:             .FontSize  = 8
1333:             .BackStyle = 0
1334:             .Alignment = 0
1335:             .AutoSize  = .F.
1336:             .Caption   = "Esp" + CHR(233) + "cie"
1337:             .Left      = 57
1338:             .Top       = 23
1339:             .Width     = 85
1340:             .ForeColor = RGB(90, 90, 90)
1341:             .Visible   = .T.
1342:         ENDWITH
1343: 
1344:         loc_oCnt.AddObject("txt_4c_Espes", "TextBox")
1345:         WITH loc_oCnt.txt_4c_Espes
1346:             .Alignment     = 3
1347:             .MaxLength     = 10
1348:             .Left          = 57
1349:             .Top           = 40
1350:             .Width         = 87
1351:             .Height        = 23
1352:             .Margin        = 0
1353:             .SpecialEffect = 1
1354:             .ForeColor     = RGB(0, 0, 0)
1355:             .BorderColor   = RGB(100, 100, 100)
1356:             .Visible       = .T.
1357:         ENDWITH
1358:         IF loc_lTemCursorPai
1359:             loc_oCnt.txt_4c_Espes.ControlSource = "TprMvCab.Espes"
1360:         ENDIF
1361:         BINDEVENT(loc_oCnt.txt_4c_Espes, "When", THIS, "VolumesWhen")
1362: 
1363:         loc_oCnt.AddObject("lbl_4c_LblPLiqs", "Label")
1364:         WITH loc_oCnt.lbl_4c_LblPLiqs
1365:             .FontName  = "Tahoma"
1366:             .FontSize  = 8
1367:             .BackStyle = 0
1368:             .Alignment = 0
1369:             .AutoSize  = .F.
1370:             .Caption   = "Peso L" + CHR(237) + "quido"
1371:             .Left      = 147
1372:             .Top       = 23
1373:             .Width     = 75
1374:             .ForeColor = RGB(90, 90, 90)
1375:             .Visible   = .T.
1376:         ENDWITH
1377: 
1378:         loc_oCnt.AddObject("txt_4c_PLiqs", "TextBox")
1379:         WITH loc_oCnt.txt_4c_PLiqs
1380:             .Alignment     = 3
1381:             .InputMask     = "99,999.99"
1382:             .Left          = 147
1383:             .Top           = 40
1384:             .Width         = 73
1385:             .Height        = 23
1386:             .Margin        = 0
1387:             .SpecialEffect = 1
1388:             .ForeColor     = RGB(0, 0, 0)
1389:             .BorderColor   = RGB(100, 100, 100)
1390:             .Visible       = .T.
1391:         ENDWITH
1392:         IF loc_lTemCursorPai
1393:             loc_oCnt.txt_4c_PLiqs.ControlSource = "TprMvCab.PLiqs"
1394:         ENDIF
1395:         BINDEVENT(loc_oCnt.txt_4c_PLiqs, "When", THIS, "VolumesWhen")
1396: 
1397:         loc_oCnt.AddObject("lbl_4c_LblPBrus", "Label")
1398:         WITH loc_oCnt.lbl_4c_LblPBrus
1399:             .FontName  = "Tahoma"
1400:             .FontSize  = 8
1401:             .BackStyle = 0
1402:             .Alignment = 0
1403:             .AutoSize  = .F.
1404:             .Caption   = "Peso Bruto"
1405:             .Left      = 223
1406:             .Top       = 23
1407:             .Width     = 75
1408:             .ForeColor = RGB(90, 90, 90)
1409:             .Visible   = .T.
1410:         ENDWITH
1411: 
1412:         loc_oCnt.AddObject("txt_4c_PBrus", "TextBox")
1413:         WITH loc_oCnt.txt_4c_PBrus
1414:             .Alignment     = 3
1415:             .InputMask     = "99,999.99"
1416:             .Left          = 223
1417:             .Top           = 40
1418:             .Width         = 73
1419:             .Height        = 23
1420:             .Margin        = 0
1421:             .SpecialEffect = 1
1422:             .ForeColor     = RGB(0, 0, 0)
1423:             .BorderColor   = RGB(100, 100, 100)
1424:             .Visible       = .T.
1425:         ENDWITH
1426:         IF loc_lTemCursorPai
1427:             loc_oCnt.txt_4c_PBrus.ControlSource = "TprMvCab.PBrus"
1428:         ENDIF
1429:         BINDEVENT(loc_oCnt.txt_4c_PBrus, "When", THIS, "VolumesWhen")
1430: 
1431:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
1432:         WITH loc_oCnt.lbl_4c_Label1
1433:             .FontName  = "Tahoma"
1434:             .FontSize  = 8
1435:             .BackStyle = 0
1436:             .Alignment = 0
1437:             .AutoSize  = .F.
1438:             .Caption   = "Valor Transporte"
1439:             .Left      = 299
1440:             .Top       = 23
1441:             .Width     = 100
1442:             .ForeColor = RGB(90, 90, 90)
1443:             .Visible   = .T.
1444:         ENDWITH
1445: 
1446:         loc_oCnt.AddObject("txt_4c_ValTrans", "TextBox")
1447:         WITH loc_oCnt.txt_4c_ValTrans
1448:             .Alignment     = 3
1449:             .InputMask     = "999,999.99"
1450:             .Left          = 299
1451:             .Top           = 40
1452:             .Width         = 90
1453:             .Height        = 23
1454:             .Margin        = 0
1455:             .SpecialEffect = 1
1456:             .ForeColor     = RGB(0, 0, 0)
1457:             .BorderColor   = RGB(100, 100, 100)
1458:             .Visible       = .T.
1459:         ENDWITH
1460:         IF loc_lTemCursorPai
1461:             loc_oCnt.txt_4c_ValTrans.ControlSource = "TprMvCab.ValTrans"
1462:         ENDIF
1463:         BINDEVENT(loc_oCnt.txt_4c_ValTrans, "When", THIS, "VolumesWhen")
1464:     ENDPROC
1465: 
1466:     *==========================================================================
1467:     * VolumesWhen - "Return Inlist(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')"
1468:     * do legado, texto IDENTICO nos 5 campos de cntVolumes (getQtds/getEspes/
1469:     * getPLiqs/getPBrus/getValTrans.When). Mesmo texto de PadraoIncluirAlterarWhen,
1470:     * mas com nome proprio para documentar a origem (grep direto pelo nome do
1471:     * container na auditoria).
1472:     *
1473:     * PUBLIC: alvo de BINDEVENT("When").
1474:     *==========================================================================
1475:     FUNCTION VolumesWhen()
1476:         RETURN INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
1477:     ENDFUNC
1478: 
1479:     *==========================================================================
1480:     * ConfigurarObservacao - cntObservacao (cnt_4c_Observacao): campo de
1481:     * codigo/texto da observacao do movimento + botao de multiplas
1482:     * observacoes. Geometria do dump.
1483:     *==========================================================================
1484:     PROTECTED PROCEDURE ConfigurarObservacao()
1485:         LOCAL loc_oCnt, loc_lTemCursorPai
1486:         loc_lTemCursorPai = USED("TprMvCab")
1487: 
1488:         THIS.AddObject("cnt_4c_Observacao", "Container")
1489:         loc_oCnt = THIS.cnt_4c_Observacao
1490:         WITH loc_oCnt
1491:             .Top         = 228
1492:             .Left        = 12
1493:             .Width       = 528
1494:             .Height      = 303
1495:             .BackStyle   = 0
1496:             .BorderWidth = 0
1497:             .Visible     = .T.
1498:         ENDWITH
1499: 
1500:         loc_oCnt.AddObject("lbl_4c_LblObservas", "Label")
1501:         WITH loc_oCnt.lbl_4c_LblObservas
1502:             .FontBold  = .T.
1503:             .FontName  = "Tahoma"
1504:             .FontSize  = 8
1505:             .BackStyle = 0
1506:             .Alignment = 0
1507:             .AutoSize  = .F.
1508:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
1509:             .Left      = 3
1510:             .Top       = 23
1511:             .Width     = 85
1512:             .ForeColor = RGB(90, 90, 90)
1513:             .Visible   = .T.
1514:         ENDWITH
1515: 
1516:         loc_oCnt.AddObject("txt_4c_CodObs", "TextBox")
1517:         WITH loc_oCnt.txt_4c_CodObs
1518:             .Alignment     = 3
1519:             .InputMask     = "999"
1520:             .Left          = 92
1521:             .Top           = 19
1522:             .Width         = 32
1523:             .Height        = 23
1524:             .Margin        = 0

*-- Linhas 1531 a 1851:
1531:         IF loc_lTemCursorPai
1532:             loc_oCnt.txt_4c_CodObs.ControlSource = "TprMvCab.CodObs"
1533:         ENDIF
1534:         BINDEVENT(loc_oCnt.txt_4c_CodObs, "GotFocus",  THIS, "CodObsGotFocus")
1535:         BINDEVENT(loc_oCnt.txt_4c_CodObs, "LostFocus", THIS, "CodObsLostFocus")
1536:         BINDEVENT(loc_oCnt.txt_4c_CodObs, "When",      THIS, "CodObsWhen")
1537: 
1538:         loc_oCnt.AddObject("obj_4c_GetDesObs", "EditBox")
1539:         WITH loc_oCnt.obj_4c_GetDesObs
1540:             .FontSize      = 8
1541:             .Left          = 3
1542:             .Top           = 46
1543:             .Width         = 453
1544:             .Height        = 254
1545:             .SpecialEffect = 1
1546:             .ForeColor     = RGB(0, 0, 0)
1547:             .BorderColor   = RGB(100, 100, 100)
1548:             .Visible       = .T.
1549:         ENDWITH
1550:         IF loc_lTemCursorPai
1551:             loc_oCnt.obj_4c_GetDesObs.ControlSource = "TprMvCab.obses"
1552:         ENDIF
1553:         BINDEVENT(loc_oCnt.obj_4c_GetDesObs, "When", THIS, "DesObsWhen")
1554: 
1555:         loc_oCnt.AddObject("cmd_4c_BtnMultObs", "CommandButton")
1556:         WITH loc_oCnt.cmd_4c_BtnMultObs
1557:             .Top          = 20
1558:             .Left         = 135
1559:             .Width        = 24
1560:             .Height       = 24
1561:             .Caption      = ""
1562:             .Picture      = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1563:             .ToolTipText  = "Selecionar M" + CHR(250) + "ltiplas Observa" + CHR(231) + CHR(245) + "es"
1564:             .Themes       = .T.
1565:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1566:             .Visible      = .T.
1567:         ENDWITH
1568:         BINDEVENT(loc_oCnt.cmd_4c_BtnMultObs, "Click", THIS, "BtnMultObsObservacaoClick")
1569:     ENDPROC
1570: 
1571:     *==========================================================================
1572:     * CodObsGotFocus - "This.Tag = Str(This.Value, 10)" do legado (getCodObs.
1573:     * GotFocus): guarda o valor de entrada no Tag para o LostFocus saber se
1574:     * o usuario realmente alterou o codigo (evita reabrir o lookup so por
1575:     * entrar/sair do campo sem digitar nada).
1576:     *
1577:     * PUBLIC: alvo de BINDEVENT("GotFocus").
1578:     *==========================================================================
1579:     PROCEDURE CodObsGotFocus()
1580:         LOCAL loc_oTxt
1581:         loc_oTxt = THIS.cnt_4c_Observacao.txt_4c_CodObs
1582:         loc_oTxt.Tag = STR(loc_oTxt.Value, 10)
1583:     ENDPROC
1584: 
1585:     *==========================================================================
1586:     * CodObsWhen - "ThisForm.Antvalu = This.Value / Return Inlist(
1587:     * ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')" do legado (getCodObs.When).
1588:     * Antvalu e bookkeeping do legado (ClassInfo do SIGOPINF - SECAO 4 do
1589:     * dump) sem nenhum consumidor nas secoes de codigo transcritas nesta
1590:     * migracao - a parte que importa (o gate INSERIR/ALTERAR, igual ao dos
1591:     * demais campos) e a unica preservada.
1592:     *
1593:     * PUBLIC: alvo de BINDEVENT("When").
1594:     *==========================================================================
1595:     FUNCTION CodObsWhen()
1596:         RETURN INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
1597:     ENDFUNC
1598: 
1599:     *==========================================================================
1600:     * CodObsLostFocus - equivalente ao getCodObs.Valid legado (regra #47 -
1601:     * lookup de TextBox vai em LostFocus, nao em Valid/KeyPress):
1602:     *
1603:     *   If Not Empty(This.Value) And Not (This.Tag = Str(This.Value, 10))
1604:     *       <monta faixa ObsIni/ObsFins de SigCdOpe/SigCdOop>
1605:     *       <Select Codigos, Descrs From SigCdObs Where Codigos Between ...>
1606:     *       Set Near On / If Not Seek(...) -> fwBuscaSel / Set Near Off
1607:     *       This.Value = crLocalObs.Codigos
1608:     *       ThisForm.MontaObs(...)
1609:     *   EndIf
1610:     *
1611:     * A faixa SigCdOop (override por CFOP, dependente de crSigMvNfi/
1612:     * crSigOpCdd) nao esta disponivel nesta tela ainda (cursores de fases
1613:     * seguintes) - falso seguro: a faixa fica so com o ObsIni/ObsFins de
1614:     * SigCdOpe. fwBuscaSel -> FormBuscaAuxiliar (padrao do projeto).
1615:     *
1616:     * PUBLIC: alvo de BINDEVENT("LostFocus").
1617:     *==========================================================================
1618:     PROCEDURE CodObsLostFocus()
1619:         LOCAL loc_oTxt, loc_nPIni, loc_nPFim, loc_cSQL, loc_nErro, ;
1620:               loc_oBusca, loc_oErro, loc_lAchou, loc_cValor
1621: 
1622:         loc_oTxt   = THIS.cnt_4c_Observacao.txt_4c_CodObs
1623:         loc_cValor = TRANSFORM(loc_oTxt.Value)
1624: 
1625:         IF loc_cValor == THIS.this_cUltimoCodObsLostFocusValidado
1626:             RETURN
1627:         ENDIF
1628:         THIS.this_cUltimoCodObsLostFocusValidado = loc_cValor
1629: 
1630:         IF EMPTY(loc_oTxt.Value) OR loc_oTxt.Tag == STR(loc_oTxt.Value, 10)
1631:             RETURN
1632:         ENDIF
1633: 
1634:         loc_nPIni = 0
1635:         loc_nPFim = 999
1636:         IF USED("TprMvCab")
1637:             loc_cSQL = "SELECT ObsPads, ObsInis, ObsFins FROM SigCdOpe " + ;
1638:                 "WHERE Dopes = " + EscaparSQL(TprMvCab.Dopes)
1639:             loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalOpe")
1640: 
1641:             IF loc_nErro >= 1 AND RECCOUNT("cursor_4c_LocalOpe") > 0
1642:                 loc_nPIni = IIF(!EMPTY(cursor_4c_LocalOpe.ObsInis), cursor_4c_LocalOpe.ObsInis, 0)
1643:                 loc_nPFim = IIF(!EMPTY(cursor_4c_LocalOpe.ObsFins), cursor_4c_LocalOpe.ObsFins, 999)
1644:             ENDIF
1645:             IF USED("cursor_4c_LocalOpe")
1646:                 USE IN cursor_4c_LocalOpe
1647:             ENDIF
1648:         ENDIF
1649: 
1650:         loc_cSQL = "SELECT Codigos, Descrs FROM SigCdObs WHERE Codigos BETWEEN " + ;
1651:             FormatarNumeroSQL(loc_nPIni, 0) + " AND " + FormatarNumeroSQL(loc_nPFim, 0)
1652:         loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalObs")
1653: 
1654:         IF loc_nErro < 1
1655:             MsgErro("Favor reinicializar o processo." + CHR(13) + ;
1656:                 "Falha na conex" + CHR(227) + "o (cursor_4c_LocalObs)", "Erro")
1657:             RETURN
1658:         ENDIF
1659: 
1660:         loc_lAchou = .F.
1661:         IF USED("cursor_4c_LocalObs")
1662:             SELECT cursor_4c_LocalObs
1663:             LOCATE FOR Codigos = loc_oTxt.Value
1664:             loc_lAchou = FOUND()
1665:         ENDIF
1666: 
1667:         IF !loc_lAchou
1668:             loc_oBusca = .NULL.
1669:             TRY
1670:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1671:                     "SigCdObs", "cursor_4c_BuscaObs", "Codigos", ;
1672:                     TRANSFORM(loc_oTxt.Value), "Observa" + CHR(231) + CHR(245) + "es", ;
1673:                     .F., .F., ;
1674:                     "Codigos BETWEEN " + FormatarNumeroSQL(loc_nPIni, 0) + " AND " + ;
1675:                         FormatarNumeroSQL(loc_nPFim, 0))
1676:             CATCH TO loc_oErro
1677:                 MsgErro(loc_oErro.Message, "Erro ao abrir busca de observa" + CHR(231) + CHR(245) + "es")
1678:                 loc_oBusca = .NULL.
1679:             ENDTRY
1680: 
1681:             IF VARTYPE(loc_oBusca) = "O"
1682:                 IF !loc_oBusca.this_lAchouRegistro
1683:                     loc_oBusca.mAddColuna("Codigos", "999", "C" + CHR(243) + "d.")
1684:                     loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
1685:                     loc_oBusca.Show()
1686:                 ENDIF
1687: 
1688:                 IF loc_oBusca.this_lSelecionou
1689:                     loc_oTxt.Value = VAL(loc_oBusca.cCodigoSelecionado)
1690:                 ELSE
1691:                     loc_oTxt.Value = 0
1692:                 ENDIF
1693: 
1694:                 IF USED("cursor_4c_BuscaObs")
1695:                     USE IN cursor_4c_BuscaObs
1696:                 ENDIF
1697:                 loc_oBusca.Release()
1698:             ENDIF
1699:         ENDIF
1700: 
1701:         IF USED("cursor_4c_LocalObs")
1702:             USE IN cursor_4c_LocalObs
1703:         ENDIF
1704: 
1705:         IF !EMPTY(loc_oTxt.Value)
1706:             THIS.MontarObservacaoPadrao(loc_oTxt.Value)
1707:         ENDIF
1708: 
1709:         *-- Valor final (pode ter mudado pelo picker) - evita reabrir o
1710:         *-- lookup se o usuario so entrar/sair do campo de novo sem digitar.
1711:         THIS.this_cUltimoCodObsLostFocusValidado = TRANSFORM(loc_oTxt.Value)
1712:     ENDPROC
1713: 
1714:     *==========================================================================
1715:     * MontarObservacaoPadrao - "ThisForm.MontaObs(ThisForm.ParentForm.
1716:     * poDataMgr)" do legado: le SigCdObs.Observas do codigo escolhido e
1717:     * grava em getDesObs. As 4 macros (# $ % !) do legado completam o texto
1718:     * com dados da grade de itens do movimento (TmpOperacao, equivalente a
1719:     * fMontaObs() - regra CLAUDE.md #27) - a grade ainda nao existe nesta
1720:     * tela (fases seguintes); sem ela, o texto CRU (sem expansao) e gravado
1721:     * e o usuario e avisado, nunca silenciosamente vazio.
1722:     *
1723:     * PROTECTED: chamado so por CodObsLostFocus.
1724:     *==========================================================================
1725:     PROTECTED PROCEDURE MontarObservacaoPadrao(par_nCodObs)
1726:         LOCAL loc_cSQL, loc_nErro, loc_cObs, loc_oTxtDesc
1727: 
1728:         loc_cSQL = "SELECT Codigos, Observas FROM SigCdObs WHERE Codigos = " + ;
1729:             FormatarNumeroSQL(par_nCodObs, 0)
1730:         loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdObs")
1731: 
1732:         IF loc_nErro >= 1 AND RECCOUNT("cursor_4c_SigCdObs") > 0
1733:             loc_cObs     = ALLTRIM(TratarNulo(cursor_4c_SigCdObs.Observas, "C"))
1734:             loc_oTxtDesc = THIS.cnt_4c_Observacao.obj_4c_GetDesObs
1735: 
1736:             IF "#" $ loc_cObs OR "$" $ loc_cObs OR "%" $ loc_cObs OR "!" $ loc_cObs
1737:                 THIS.AvisarLegadoNaoPortado("fMontaObs() / grade de itens (TmpOperacao)", ;
1738:                     "completar a observa" + CHR(231) + CHR(227) + "o padr" + CHR(227) + "o com os dados da grade")
1739:             ENDIF
1740: 
1741:             loc_oTxtDesc.Value = loc_cObs
1742:             loc_oTxtDesc.Refresh()
1743:         ENDIF
1744: 
1745:         IF USED("cursor_4c_SigCdObs")
1746:             USE IN cursor_4c_SigCdObs
1747:         ENDIF
1748:     ENDPROC
1749: 
1750:     *==========================================================================
1751:     * DesObsWhen - getDesObs.When legado:
1752:     *   IF fChecaAcesso( padl(crSigCdOpe.nDopes,8,'0'), 'ALTINFO' )
1753:     *       Return !InList(ThisForm.pcEscolha,'EXCLUIR')
1754:     *   Else
1755:     *       Dodefault()     && equivalente ao When padrao do fwmemo -
1756:     *                          mesmo texto dos demais campos (INSERIR/ALTERAR)
1757:     *   Endif
1758:     * Sem crSigCdOpe (cursor do Init legado, fases seguintes), cai direto
1759:     * no ramo "Dodefault()" - e exatamente o que o legado faria se a
1760:     * checagem nao pudesse ser avaliada.
1761:     *
1762:     * PUBLIC: alvo de BINDEVENT("When").
1763:     *==========================================================================
1764:     FUNCTION DesObsWhen()
1765:         IF USED("crSigCdOpe") AND fChecaAcesso(PADL(TRANSFORM(crSigCdOpe.nDopes), 8, "0"), "ALTINFO")
1766:             RETURN !INLIST(THIS.this_cPcEscolha, "EXCLUIR")
1767:         ENDIF
1768: 
1769:         RETURN THIS.VolumesWhen()
1770:     ENDFUNC
1771: 
1772:     *==========================================================================
1773:     * BtnMultObsObservacaoClick - btnMultObs.Valid de cntObservacao (evento
1774:     * "Valid" num fwbtnp - mesma convencao ja adotada na Fase 4 para
1775:     * cmdCotacao/cmdEntrega: bind no "Click", nao no "Valid"):
1776:     *
1777:     *   If (TprMvCab.CodObs > 0)
1778:     *       MessageBox('Para Selecionar Multiplas Observacoes Nao Pode Ser
1779:     *                    Informado o Codigo de Observacao')
1780:     *       ThisForm.cntObservacao.getCodObs.SetFocus
1781:     *       Return .f.
1782:     *   EndIf
1783:     *   Do Form SigOpIns With ThisForm.ParentForm.poDataMgr
1784:     *   ThisForm.cntObservacao.getDesObs.Refresh
1785:     *
1786:     * SigOpIns nao veio no acervo - AvisarLegadoNaoPortado().
1787:     *
1788:     * PUBLIC: alvo de BINDEVENT("Click").
1789:     *==========================================================================
1790:     PROCEDURE BtnMultObsObservacaoClick()
1791:         LOCAL loc_oTxtCod
1792:         loc_oTxtCod = THIS.cnt_4c_Observacao.txt_4c_CodObs
1793: 
1794:         IF loc_oTxtCod.Value > 0
1795:             MsgAviso("Para Selecionar M" + CHR(250) + "ltiplas Observa" + CHR(231) + CHR(245) + "es N" + CHR(227) + "o " + ;
1796:                 "Pode Ser Informado o C" + CHR(243) + "digo de Observa" + CHR(231) + CHR(227) + "o", ;
1797:                 "Aten" + CHR(231) + CHR(227) + "o")
1798:             loc_oTxtCod.SetFocus()
1799:             RETURN
1800:         ENDIF
1801: 
1802:         THIS.AvisarLegadoNaoPortado("Tela de Sele" + CHR(231) + CHR(227) + "o de Observa" + CHR(231) + CHR(245) + "es (SigOpIns)", ;
1803:             "selecionar m" + CHR(250) + "ltiplas observa" + CHR(231) + CHR(245) + "es")
1804:     ENDPROC
1805: 
1806:     *==========================================================================
1807:     * ConfigurarProtocolo - cntProtocolo (cnt_4c_Protocolo): campo unico de
1808:     * protocolo. When identico ao texto de PadraoIncluirAlterarWhen (regra
1809:     * #47/Fase5) - reaproveitado sem duplicar.
1810:     *==========================================================================
1811:     PROTECTED PROCEDURE ConfigurarProtocolo()
1812:         LOCAL loc_oCnt, loc_lTemCursorPai
1813:         loc_lTemCursorPai = USED("TprMvCab")
1814: 
1815:         THIS.AddObject("cnt_4c_Protocolo", "Container")
1816:         loc_oCnt = THIS.cnt_4c_Protocolo
1817:         WITH loc_oCnt
1818:             .Top         = 96
1819:             .Left        = 461
1820:             .Width       = 61
1821:             .Height      = 45
1822:             .BackStyle   = 0
1823:             .BorderWidth = 0
1824:             .Visible     = .T.
1825:         ENDWITH
1826: 
1827:         loc_oCnt.AddObject("lbl_4c_LblProtocolos", "Label")
1828:         WITH loc_oCnt.lbl_4c_LblProtocolos
1829:             .FontName  = "Tahoma"
1830:             .FontSize  = 8
1831:             .BackStyle = 0
1832:             .Alignment = 0
1833:             .AutoSize  = .F.
1834:             .Caption   = "Protocolo"
1835:             .Left      = 3
1836:             .Top       = 3
1837:             .Width     = 55
1838:             .ForeColor = RGB(90, 90, 90)
1839:             .Visible   = .T.
1840:         ENDWITH
1841: 
1842:         loc_oCnt.AddObject("txt_4c_Protocolos", "TextBox")
1843:         WITH loc_oCnt.txt_4c_Protocolos
1844:             .Alignment     = 3
1845:             .Format        = "K"
1846:             .InputMask     = "999999"
1847:             .MaxLength     = 6
1848:             .Left          = 3
1849:             .Top           = 20
1850:             .Width         = 55
1851:             .Height        = 23

*-- Linhas 1858 a 1910:
1858:         IF loc_lTemCursorPai
1859:             loc_oCnt.txt_4c_Protocolos.ControlSource = "TprMvCab.protats"
1860:         ENDIF
1861:         BINDEVENT(loc_oCnt.txt_4c_Protocolos, "When", THIS, "PadraoIncluirAlterarWhen")
1862:     ENDPROC
1863: 
1864:     *==========================================================================
1865:     * ConfigurarEntrega - cntEntrega (cnt_4c_Entrega): conta/nome/cpf-cnpj
1866:     * do destinatario da entrega + botao "Local de Entrega". Os tres campos
1867:     * de conta sao intercambiaveis no legado (preencher um resolve os
1868:     * outros dois) - ver ContasLostFocus/DContaLostFocus/CpfsLostFocus.
1869:     *==========================================================================
1870:     PROTECTED PROCEDURE ConfigurarEntrega()
1871:         LOCAL loc_oCnt, loc_lTemCursorPai
1872:         loc_lTemCursorPai = USED("TprMvCab")
1873: 
1874:         THIS.AddObject("cnt_4c_Entrega", "Container")
1875:         loc_oCnt = THIS.cnt_4c_Entrega
1876:         WITH loc_oCnt
1877:             .Top         = 192
1878:             .Left        = 489
1879:             .Width       = 504
1880:             .Height      = 66
1881:             .BackStyle   = 0
1882:             .BorderWidth = 0
1883:             .Visible     = .T.
1884:         ENDWITH
1885: 
1886:         loc_oCnt.AddObject("lbl_4c_LblEntregas", "Label")
1887:         WITH loc_oCnt.lbl_4c_LblEntregas
1888:             .FontBold  = .T.
1889:             .FontName  = "Tahoma"
1890:             .FontSize  = 8
1891:             .BackStyle = 0
1892:             .Alignment = 0
1893:             .AutoSize  = .F.
1894:             .Caption   = "Entrega"
1895:             .Left      = 3
1896:             .Top       = 3
1897:             .Width     = 85
1898:             .ForeColor = RGB(90, 90, 90)
1899:             .Visible   = .T.
1900:         ENDWITH
1901: 
1902:         loc_oCnt.AddObject("lbl_4c_LblContas", "Label")
1903:         WITH loc_oCnt.lbl_4c_LblContas
1904:             .FontName  = "Tahoma"
1905:             .FontSize  = 8
1906:             .BackStyle = 0
1907:             .Alignment = 0
1908:             .AutoSize  = .F.
1909:             .Caption   = "Conta"
1910:             .Left      = 3

*-- Linhas 1962 a 2201:
1962:         IF loc_lTemCursorPai
1963:             loc_oCnt.txt_4c_Contas.ControlSource = "TprMvCab.contaes"
1964:         ENDIF
1965:         BINDEVENT(loc_oCnt.txt_4c_Contas, "LostFocus", THIS, "ContasLostFocus")
1966:         BINDEVENT(loc_oCnt.txt_4c_Contas, "When",      THIS, "PadraoIncluirAlterarWhen")
1967: 
1968:         loc_oCnt.AddObject("txt_4c_Cpfs", "TextBox")
1969:         WITH loc_oCnt.txt_4c_Cpfs
1970:             .Left          = 77
1971:             .Top           = 40
1972:             .Width         = 131
1973:             .Height        = 23
1974:             .Margin        = 0
1975:             .SpecialEffect = 1
1976:             .ForeColor     = RGB(0, 0, 0)
1977:             .BorderColor   = RGB(100, 100, 100)
1978:             .Visible       = .T.
1979:         ENDWITH
1980:         BINDEVENT(loc_oCnt.txt_4c_Cpfs, "LostFocus", THIS, "CpfsLostFocus")
1981:         BINDEVENT(loc_oCnt.txt_4c_Cpfs, "When",      THIS, "EntregaCamposLiberadosWhen")
1982: 
1983:         loc_oCnt.AddObject("txt_4c_DConta", "TextBox")
1984:         WITH loc_oCnt.txt_4c_DConta
1985:             .Left          = 210
1986:             .Top           = 40
1987:             .Width         = 285
1988:             .Height        = 23
1989:             .Margin        = 0
1990:             .SpecialEffect = 1
1991:             .ForeColor     = RGB(0, 0, 0)
1992:             .BorderColor   = RGB(100, 100, 100)
1993:             .Visible       = .T.
1994:         ENDWITH
1995:         BINDEVENT(loc_oCnt.txt_4c_DConta, "LostFocus", THIS, "DContaLostFocus")
1996:         BINDEVENT(loc_oCnt.txt_4c_DConta, "When",      THIS, "EntregaCamposLiberadosWhen")
1997: 
1998:         loc_oCnt.AddObject("cmd_4c_CmdEntrega", "CommandButton")
1999:         WITH loc_oCnt.cmd_4c_CmdEntrega
2000:             .Top             = 20
2001:             .Left            = 455
2002:             .Width           = 24
2003:             .Height          = 24
2004:             .Caption         = ""
2005:             .Picture         = gc_4c_CaminhoIcones + "geral_relogio_26.jpg"
2006:             .ToolTipText     = "Local de Entrega"
2007:             .Themes          = .T.
2008:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_relogio_26.jpg"
2009:             .Visible         = .T.
2010:         ENDWITH
2011:         BINDEVENT(loc_oCnt.cmd_4c_CmdEntrega, "Click", THIS, "EntregaLocalClick")
2012:     ENDPROC
2013: 
2014:     *==========================================================================
2015:     * ContasLostFocus/DContaLostFocus/CpfsLostFocus - equivalentes ao Valid/
2016:     * LostFocus legado de getContas/getDConta/getCpfs (regra #47). Os tres
2017:     * campos sao intercambiaveis: preencher QUALQUER um localiza a conta em
2018:     * SigCdCli e preenche os outros dois.
2019:     *
2020:     * fAcessoContas(..., pSt1=.NULL., pSt2=.NULL.) - modo BACKEND (regra do
2021:     * projeto: AcessoContas() NUNCA em modo lookup-UI, que auto-popula com o
2022:     * PRIMEIRO registro que contem o valor digitado - aqui ele so confere
2023:     * ACESSO, sem objeto de TextBox nenhum).
2024:     *
2025:     * Guard this_cUltimo<X>LostFocusValidado: LostFocus dispara mesmo sem o
2026:     * usuario mudar o valor (diferente do Valid legado, que so dispara na
2027:     * mudanca) - sem o guard, sair e voltar ao campo sem digitar nada
2028:     * revalidaria o acesso e reabriria o lookup a cada vez.
2029:     *
2030:     * PUBLIC: alvo de BINDEVENT("LostFocus").
2031:     *==========================================================================
2032:     PROCEDURE ContasLostFocus()
2033:         LOCAL loc_oTxt, loc_cValor
2034: 
2035:         loc_oTxt   = THIS.cnt_4c_Entrega.txt_4c_Contas
2036:         loc_cValor = ALLTRIM(TRANSFORM(loc_oTxt.Value))
2037: 
2038:         IF loc_cValor == THIS.this_cUltimoContasLostFocusValidado
2039:             RETURN
2040:         ENDIF
2041: 
2042:         IF EMPTY(loc_cValor)
2043:             THIS.LimparContaEntrega()
2044:             THIS.this_cUltimoContasLostFocusValidado = loc_cValor
2045:             RETURN
2046:         ENDIF
2047: 
2048:         IF !fAcessoContas(gc_4c_UsuarioLogado, "", "C", loc_cValor, .NULL., .NULL.)
2049:             MsgAviso("Acesso Negado!!!", "Aten" + CHR(231) + CHR(227) + "o")
2050:             THIS.LimparContaEntrega()
2051:             THIS.this_cUltimoContasLostFocusValidado = loc_cValor
2052:             RETURN
2053:         ENDIF
2054: 
2055:         IF !THIS.BuscarContaEntrega("IClis", loc_cValor)
2056:             THIS.AbrirBuscaContaEntrega(loc_cValor, "IClis")
2057:         ENDIF
2058: 
2059:         THIS.this_cUltimoContasLostFocusValidado = loc_cValor
2060:     ENDPROC
2061: 
2062:     PROCEDURE DContaLostFocus()
2063:         LOCAL loc_oTxt, loc_cValor
2064: 
2065:         loc_oTxt   = THIS.cnt_4c_Entrega.txt_4c_DConta
2066:         loc_cValor = ALLTRIM(TRANSFORM(loc_oTxt.Value))
2067: 
2068:         IF loc_cValor == THIS.this_cUltimoDContaLostFocusValidado
2069:             RETURN
2070:         ENDIF
2071: 
2072:         IF EMPTY(loc_cValor)
2073:             THIS.this_cUltimoDContaLostFocusValidado = loc_cValor
2074:             RETURN
2075:         ENDIF
2076: 
2077:         IF !fAcessoContas(gc_4c_UsuarioLogado, "", "D", loc_cValor, .NULL., .NULL.)
2078:             MsgAviso("Acesso Negado!!!", "Aten" + CHR(231) + CHR(227) + "o")
2079:             THIS.LimparContaEntrega()
2080:             THIS.this_cUltimoDContaLostFocusValidado = loc_cValor
2081:             RETURN
2082:         ENDIF
2083: 
2084:         IF !THIS.BuscarContaEntrega("RClis", loc_cValor)
2085:             THIS.AbrirBuscaContaEntrega(loc_cValor, "RClis")
2086:         ENDIF
2087: 
2088:         THIS.this_cUltimoDContaLostFocusValidado = loc_cValor
2089:     ENDPROC
2090: 
2091:     PROCEDURE CpfsLostFocus()
2092:         LOCAL loc_oTxt, loc_cCgc, loc_cCgcFmt
2093: 
2094:         loc_oTxt = THIS.cnt_4c_Entrega.txt_4c_Cpfs
2095:         loc_cCgc = STRTRAN(STRTRAN(STRTRAN(ALLTRIM(TRANSFORM(loc_oTxt.Value)), ".", ""), "-", ""), "/", "")
2096: 
2097:         IF loc_cCgc == THIS.this_cUltimoCpfsLostFocusValidado
2098:             RETURN
2099:         ENDIF
2100: 
2101:         IF EMPTY(loc_cCgc)
2102:             THIS.this_cUltimoCpfsLostFocusValidado = loc_cCgc
2103:             RETURN
2104:         ENDIF
2105: 
2106:         loc_cCgcFmt = IIF(LEN(loc_cCgc) <> 14, TRANSFORM(loc_cCgc, "@R 999.999.999-99"), ;
2107:             TRANSFORM(loc_cCgc, "@R 99.999.999/9999-99"))
2108:         loc_oTxt.Value = loc_cCgcFmt
2109: 
2110:         IF !THIS.BuscarContaEntrega("Cpfs", loc_cCgcFmt)
2111:             THIS.AbrirBuscaContaEntrega(loc_cCgcFmt, "Cpfs")
2112:         ENDIF
2113: 
2114:         THIS.this_cUltimoCpfsLostFocusValidado = loc_cCgc
2115:     ENDPROC
2116: 
2117:     *==========================================================================
2118:     * BuscarContaEntrega - match EXATO em SigCdCli pelo campo informado
2119:     * (Iclis/Rclis/Cpfs) - equivalente ao "Cursorquery('SigCdCli', 'CrTmpCli',
2120:     * <campo>, <valor>)" do legado. Devolve .T. se achou (e ja preencheu os
2121:     * tres campos, sob as checagens de ValidarContaEntregaEncontrada).
2122:     *
2123:     * PROTECTED: chamado so pelos LostFocus acima.
2124:     *==========================================================================
2125:     PROTECTED FUNCTION BuscarContaEntrega(par_cCampo, par_cValor)
2126:         LOCAL loc_cSQL, loc_nErro, loc_lAchou
2127:         loc_lAchou = .F.
2128: 
2129:         loc_cSQL = "SELECT TOP 1 IClis, RClis, Cpfs, Situas FROM SigCdCli WHERE " + ;
2130:             par_cCampo + " = " + EscaparSQL(par_cValor)
2131:         loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaContaEntrega")
2132: 
2133:         IF loc_nErro >= 1 AND RECCOUNT("cursor_4c_BuscaContaEntrega") > 0
2134:             IF THIS.ValidarContaEntregaEncontrada("cursor_4c_BuscaContaEntrega")
2135:                 THIS.PreencherContaEntrega(ALLTRIM(cursor_4c_BuscaContaEntrega.IClis), ;
2136:                     ALLTRIM(cursor_4c_BuscaContaEntrega.RClis), ALLTRIM(cursor_4c_BuscaContaEntrega.Cpfs))
2137:             ELSE
2138:                 THIS.LimparContaEntrega()
2139:             ENDIF
2140:             loc_lAchou = .T.
2141:         ENDIF
2142: 
2143:         IF USED("cursor_4c_BuscaContaEntrega")
2144:             USE IN cursor_4c_BuscaContaEntrega
2145:         ENDIF
2146: 
2147:         RETURN loc_lAchou
2148:     ENDFUNC
2149: 
2150:     *==========================================================================
2151:     * AbrirBuscaContaEntrega - sem match exato, abre o picker canonico
2152:     * (regra #36/#37) com busca parcial pelo mesmo campo.
2153:     *
2154:     * PROTECTED: chamado so pelos LostFocus acima.
2155:     *==========================================================================
2156:     PROTECTED PROCEDURE AbrirBuscaContaEntrega(par_cValor, par_cCampo)
2157:         LOCAL loc_oBusca, loc_oErro
2158: 
2159:         loc_oBusca = .NULL.
2160:         TRY
2161:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2162:                 "SigCdCli", "cursor_4c_BuscaContaEntrega", par_cCampo, par_cValor, ;
2163:                 "Conta de Entrega")
2164:         CATCH TO loc_oErro
2165:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de contas")
2166:             loc_oBusca = .NULL.
2167:         ENDTRY
2168: 
2169:         IF VARTYPE(loc_oBusca) = "O"
2170:             IF !loc_oBusca.this_lAchouRegistro
2171:                 loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
2172:                 loc_oBusca.mAddColuna("RClis", "", "Nome")
2173:                 loc_oBusca.mAddColuna("Cpfs",  "", "CPF/CNPJ")
2174:                 loc_oBusca.Show()
2175:             ENDIF
2176: 
2177:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaContaEntrega")
2178:                 IF THIS.ValidarContaEntregaEncontrada("cursor_4c_BuscaContaEntrega")
2179:                     THIS.PreencherContaEntrega(ALLTRIM(cursor_4c_BuscaContaEntrega.IClis), ;
2180:                         ALLTRIM(cursor_4c_BuscaContaEntrega.RClis), ALLTRIM(cursor_4c_BuscaContaEntrega.Cpfs))
2181:                 ELSE
2182:                     THIS.LimparContaEntrega()
2183:                 ENDIF
2184:             ELSE
2185:                 THIS.LimparContaEntrega()
2186:             ENDIF
2187: 
2188:             IF USED("cursor_4c_BuscaContaEntrega")
2189:                 USE IN cursor_4c_BuscaContaEntrega
2190:             ENDIF
2191:             loc_oBusca.Release()
2192:         ENDIF
2193:     ENDPROC
2194: 
2195:     *==========================================================================
2196:     * ValidarContaEntregaEncontrada - as duas checagens extras do legado
2197:     * ("If crSigCdOpe.ExibSits=4" - situacao da conta em SigCdCst, e
2198:     * "If CrSigOpCdc.ChCtEntrs" - conta de entrega tem que ser diferente da
2199:     * conta de origem/destino). Ambas dependem de cursores que esta tela
2200:     * ainda nao carrega (CursorQuery do Init legado, fases seguintes) -
2201:     * falso seguro: sem o cursor, a checagem fica de fora e a conta e

*-- Linhas 2220 a 2405:
2220:                     IF cursor_4c_SituacaoConta.DispMovs = 1
2221:                         loc_cMsg = ALLTRIM(IIF(!EMPTY(cursor_4c_SituacaoConta.Descr2s), ;
2222:                             cursor_4c_SituacaoConta.Descr2s, cursor_4c_SituacaoConta.Descrs))
2223:                         MsgAviso(loc_cSituas + " - " + loc_cMsg, "Situa" + CHR(231) + CHR(227) + "o")
2224: 
2225:                         IF cursor_4c_SituacaoConta.BlqMovs = 1
2226:                             MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o Bloqueada pela Situa" + CHR(231) + CHR(227) + "o da Conta...", ;
2227:                                 "Aten" + CHR(231) + CHR(227) + "o")
2228:                             loc_lAceita = .F.
2229:                         ENDIF
2230:                     ENDIF
2231: 
2232:                     IF loc_lAceita AND USED("TprMvCab") AND TprMvCab.ValVars < 0 AND cursor_4c_SituacaoConta.BlqDescs = 1
2233:                         loc_cMsg = ALLTRIM(IIF(!EMPTY(cursor_4c_SituacaoConta.Descr2s), ;
2234:                             cursor_4c_SituacaoConta.Descr2s, cursor_4c_SituacaoConta.Descrs))
2235:                         MsgAviso(loc_cSituas + " - " + loc_cMsg + CHR(13) + ;
2236:                             "Desconto Bloqueado Pela Situa" + CHR(231) + CHR(227) + "o da Conta", "Situa" + CHR(231) + CHR(227) + "o")
2237:                         loc_lAceita = .F.
2238:                     ENDIF
2239:                 ENDIF
2240: 
2241:                 IF USED("cursor_4c_SituacaoConta")
2242:                     USE IN cursor_4c_SituacaoConta
2243:                 ENDIF
2244:             ENDIF
2245:         ENDIF
2246: 
2247:         IF loc_lAceita AND USED("crSigOpCdc") AND USED("TprMvCab") AND USED(par_cCursor)
2248:             loc_cIClis = ALLTRIM(TratarNulo(EVALUATE(par_cCursor + ".IClis"), "C"))
2249: 
2250:             IF (crSigOpCdc.ChCtEntrs = 1 AND loc_cIClis == ALLTRIM(TprMvCab.ContaDs)) ;
2251:                OR (crSigOpCdc.ChCtEntrs = 2 AND loc_cIClis == ALLTRIM(TprMvCab.ContaOs))
2252:                 MsgAviso("Conta de Entrega Tem que ser diferente da Conta de " + ;
2253:                     IIF(crSigOpCdc.ChCtEntrs = 1, "Destino", "Origem"), "Aten" + CHR(231) + CHR(227) + "o")
2254:                 loc_lAceita = .F.
2255:             ENDIF
2256:         ENDIF
2257: 
2258:         RETURN loc_lAceita
2259:     ENDFUNC
2260: 
2261:     *==========================================================================
2262:     * PreencherContaEntrega/LimparContaEntrega - preenche/limpa os tres
2263:     * campos do container E a propria TprMvCab.ContaEs (os tres campos
2264:     * sincronizados, igual ao ".Refresh" dos tres no final de cada Valid
2265:     * legado).
2266:     *
2267:     * PROTECTED: chamados pelos metodos de busca acima.
2268:     *==========================================================================
2269:     PROTECTED PROCEDURE PreencherContaEntrega(par_cIClis, par_cRClis, par_cCpfs)
2270:         THIS.cnt_4c_Entrega.txt_4c_Contas.Value = par_cIClis
2271:         THIS.cnt_4c_Entrega.txt_4c_DConta.Value = par_cRClis
2272:         THIS.cnt_4c_Entrega.txt_4c_Cpfs.Value   = par_cCpfs
2273: 
2274:         IF USED("TprMvCab")
2275:             REPLACE ContaEs WITH par_cIClis IN TprMvCab
2276:         ENDIF
2277:     ENDPROC
2278: 
2279:     PROTECTED PROCEDURE LimparContaEntrega()
2280:         THIS.cnt_4c_Entrega.txt_4c_Contas.Value = ""
2281:         THIS.cnt_4c_Entrega.txt_4c_DConta.Value = ""
2282:         THIS.cnt_4c_Entrega.txt_4c_Cpfs.Value   = ""
2283: 
2284:         IF USED("TprMvCab")
2285:             REPLACE ContaEs WITH "" IN TprMvCab
2286:         ENDIF
2287:     ENDPROC
2288: 
2289:     *==========================================================================
2290:     * EntregaCamposLiberadosWhen - "Return Inlist(ThisForm.pcEscolha,
2291:     * 'INSERIR', 'ALTERAR') And Empty(ThisForm.cntEntrega.getContas.Value)"
2292:     * do legado - texto IDENTICO em getDConta.When e getCpfs.When: so
2293:     * liberados quando a Conta (codigo) ainda nao foi preenchida (os tres
2294:     * campos sao intercambiaveis, mas o legado da preferencia ao codigo).
2295:     *
2296:     * PUBLIC: alvo de BINDEVENT("When").
2297:     *==========================================================================
2298:     FUNCTION EntregaCamposLiberadosWhen()
2299:         RETURN INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR") ;
2300:             AND EMPTY(THIS.cnt_4c_Entrega.txt_4c_Contas.Value)
2301:     ENDFUNC
2302: 
2303:     *==========================================================================
2304:     * EntregaLocalClick - cntEntrega.cmdEntrega.Valid legado ("Local de
2305:     * Entrega" - mesma convencao da Fase 4 de ligar "Valid" de fwbtnp a
2306:     * "Click"), com o guard do When embutido (CommandButton nao tem When em
2307:     * VFP9 nativo - "Return InList(pcEscolha,'INSERIR','ALTERAR',
2308:     * 'CONSULTAR')" do legado vira guard no topo do handler):
2309:     *
2310:     *   Cursorquery('SigCdCli','crDCompCli','Iclis',TprMvCab.ContaEs,
2311:     *       'Grupos, IClis, RClis')
2312:     *   Do Form SigCdEnd With ..., TprMvCab.LocalEnts
2313:     *   If InList(pcEscolha,'INSERIR','ALTERAR')
2314:     *       fEndEntrega(@laArray, poDataMgr) -> Replace LocalEnts
2315:     *   EndIf
2316:     *
2317:     * SigCdEnd nao veio no acervo - AvisarLegadoNaoPortado() no CATCH da
2318:     * tentativa real. fEndEntrega() resolveria LocalEnts a partir do
2319:     * RESULTADO de SigCdEnd - sem a tela, nao ha resultado confiavel para
2320:     * gravar (o aviso acima ja cobre a ausencia).
2321:     *
2322:     * PUBLIC: alvo de BINDEVENT("Click").
2323:     *==========================================================================
2324:     PROCEDURE EntregaLocalClick()
2325:         LOCAL loc_cSQL, loc_nErro, loc_cGrupos, loc_cIClis, loc_cRClis, loc_oDlg, loc_oErro
2326: 
2327:         IF !INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR", "CONSULTAR") ;
2328:            OR !USED("TprMvCab")
2329:             RETURN
2330:         ENDIF
2331: 
2332:         loc_cSQL = "SELECT Grupos, IClis, RClis FROM SigCdCli WHERE IClis = " + ;
2333:             EscaparSQL(ALLTRIM(TprMvCab.ContaEs))
2334:         loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DCompCli")
2335: 
2336:         IF loc_nErro < 1 OR RECCOUNT("cursor_4c_DCompCli") = 0
2337:             MsgErro("Favor reinicializar o processo." + CHR(13) + ;
2338:                 "Falha na conex" + CHR(227) + "o (SigCdCli)", "Erro")
2339:         ELSE
2340:             loc_cGrupos = ALLTRIM(cursor_4c_DCompCli.Grupos)
2341:             loc_cIClis  = ALLTRIM(cursor_4c_DCompCli.IClis)
2342:             loc_cRClis  = ALLTRIM(cursor_4c_DCompCli.RClis)
2343: 
2344:             TRY
2345:                 loc_oDlg = CREATEOBJECT("FormSigCdEnd", loc_cGrupos, loc_cIClis, loc_cRClis, ;
2346:                     THIS.this_cPcEscolha, TprMvCab.LocalEnts)
2347:                 IF VARTYPE(loc_oDlg) = "O"
2348:                     loc_oDlg.Show()
2349:                 ENDIF
2350:             CATCH TO loc_oErro
2351:                 THIS.AvisarLegadoNaoPortado("Tela de Endere" + CHR(231) + "o de Entrega (SigCdEnd)", ;
2352:                     "informar/alterar o local de entrega")
2353:             ENDTRY
2354:         ENDIF
2355: 
2356:         IF USED("cursor_4c_DCompCli")
2357:             USE IN cursor_4c_DCompCli
2358:         ENDIF
2359:     ENDPROC
2360: 
2361:     *==========================================================================
2362:     * ConfigurarPedido - cntPedido (cnt_4c_Pedido): numero do pedido do
2363:     * cliente.
2364:     *==========================================================================
2365:     PROTECTED PROCEDURE ConfigurarPedido()
2366:         LOCAL loc_oCnt, loc_lTemCursorPai
2367:         loc_lTemCursorPai = USED("TprMvCab")
2368: 
2369:         THIS.AddObject("cnt_4c_Pedido", "Container")
2370:         loc_oCnt = THIS.cnt_4c_Pedido
2371:         WITH loc_oCnt
2372:             .Top         = 96
2373:             .Left        = 522
2374:             .Width       = 61
2375:             .Height      = 45
2376:             .BackStyle   = 0
2377:             .BorderWidth = 0
2378:             .Visible     = .T.
2379:         ENDWITH
2380: 
2381:         loc_oCnt.AddObject("lbl_4c_LblPedido", "Label")
2382:         WITH loc_oCnt.lbl_4c_LblPedido
2383:             .FontName  = "Tahoma"
2384:             .FontSize  = 8
2385:             .BackStyle = 0
2386:             .Alignment = 0
2387:             .AutoSize  = .F.
2388:             .Caption   = "Pedido"
2389:             .Left      = 3
2390:             .Top       = 3
2391:             .Width     = 55
2392:             .ForeColor = RGB(90, 90, 90)
2393:             .Visible   = .T.
2394:         ENDWITH
2395: 
2396:         loc_oCnt.AddObject("txt_4c_Pedido", "TextBox")
2397:         WITH loc_oCnt.txt_4c_Pedido
2398:             .Alignment     = 3
2399:             .Format        = "K"
2400:             .InputMask     = "999999"
2401:             .MaxLength     = 6
2402:             .Left          = 3
2403:             .Top           = 20
2404:             .Width         = 55
2405:             .Height        = 23

*-- Linhas 2412 a 2545:
2412:         IF loc_lTemCursorPai
2413:             loc_oCnt.txt_4c_Pedido.ControlSource = "TprMvCab.nPedClis"
2414:         ENDIF
2415:         BINDEVENT(loc_oCnt.txt_4c_Pedido, "When", THIS, "PedidoWhen")
2416:     ENDPROC
2417: 
2418:     *==========================================================================
2419:     * PedidoWhen - "Return Inlist(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')
2420:     * And Not (crSigCdOpe.PedClis = 5)" do legado (getPedido.When). Sem
2421:     * crSigCdOpe (fases seguintes), falso seguro - mesmo criterio de
2422:     * DocumentosWhen (bloqueia at? o dado confirmar que pode liberar).
2423:     *
2424:     * PUBLIC: alvo de BINDEVENT("When").
2425:     *==========================================================================
2426:     FUNCTION PedidoWhen()
2427:         LOCAL loc_lPermite
2428:         loc_lPermite = .F.
2429: 
2430:         IF INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR") AND USED("crSigCdOpe")
2431:             loc_lPermite = !(crSigCdOpe.PedClis = 5)
2432:         ENDIF
2433: 
2434:         RETURN loc_lPermite
2435:     ENDFUNC
2436: 
2437:     *==========================================================================
2438:     * ConfigurarObs2 - CntObs2 (cnt_4c_Obs2): "Finalidade" - botao que abre
2439:     * a mesma tela de multiplas observacoes (SigOpIns), mas gravando em
2440:     * CodObs2 em vez de CodObs.
2441:     *==========================================================================
2442:     PROTECTED PROCEDURE ConfigurarObs2()
2443:         LOCAL loc_oCnt
2444: 
2445:         THIS.AddObject("cnt_4c_Obs2", "Container")
2446:         loc_oCnt = THIS.cnt_4c_Obs2
2447:         WITH loc_oCnt
2448:             .Top         = 96
2449:             .Left        = 582
2450:             .Width       = 66
2451:             .Height      = 64
2452:             .BackStyle   = 0
2453:             .BorderWidth = 0
2454:             .Visible     = .T.
2455:         ENDWITH
2456: 
2457:         loc_oCnt.AddObject("lbl_4c_LblPedido", "Label")
2458:         WITH loc_oCnt.lbl_4c_LblPedido
2459:             .FontName  = "Tahoma"
2460:             .FontSize  = 8
2461:             .BackStyle = 0
2462:             .Alignment = 0
2463:             .AutoSize  = .F.
2464:             .Caption   = "Finalidade"
2465:             .Left      = 3
2466:             .Top       = 3
2467:             .Width     = 60
2468:             .ForeColor = RGB(90, 90, 90)
2469:             .Visible   = .T.
2470:         ENDWITH
2471: 
2472:         loc_oCnt.AddObject("cmd_4c_BtnMultObs", "CommandButton")
2473:         WITH loc_oCnt.cmd_4c_BtnMultObs
2474:             .Top             = 20
2475:             .Left            = 3
2476:             .Width           = 24
2477:             .Height          = 24
2478:             .Caption         = ""
2479:             .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
2480:             .ToolTipText     = "Selecionar Finalidade da opera" + CHR(231) + CHR(227) + "o para ser usada no relat" + CHR(243) + "rio de opera" + CHR(231) + CHR(245) + "es."
2481:             .Themes          = .T.
2482:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
2483:             .Visible         = .T.
2484:         ENDWITH
2485:         BINDEVENT(loc_oCnt.cmd_4c_BtnMultObs, "Click", THIS, "BtnMultObsFinalidadeClick")
2486:     ENDPROC
2487: 
2488:     *==========================================================================
2489:     * BtnMultObsFinalidadeClick - CntObs2.btnMultObs.Valid legado:
2490:     *   Do Form SigOpIns With ThisForm.ParentForm.poDataMgr, TprMvCab.CodObs2
2491:     *   replace CodObs2 with ALLTRIM(listaObs) in TprMvCab
2492:     * SigOpIns nao veio no acervo - sem a tela (e sem a lista que ela
2493:     * devolveria em listaObs), nao ha resultado para gravar em CodObs2.
2494:     *
2495:     * PUBLIC: alvo de BINDEVENT("Click").
2496:     *==========================================================================
2497:     PROCEDURE BtnMultObsFinalidadeClick()
2498:         THIS.AvisarLegadoNaoPortado("Tela de Sele" + CHR(231) + CHR(227) + "o de Finalidade (SigOpIns)", ;
2499:             "selecionar a finalidade da opera" + CHR(231) + CHR(227) + "o")
2500:     ENDPROC
2501: 
2502:     *==========================================================================
2503:     * ConfigurarLivre - cntLivre (cnt_4c_Livre): numero do lacre.
2504:     *==========================================================================
2505:     PROTECTED PROCEDURE ConfigurarLivre()
2506:         LOCAL loc_oCnt, loc_lTemCursorPai
2507:         loc_lTemCursorPai = USED("TprMvCab")
2508: 
2509:         THIS.AddObject("cnt_4c_Livre", "Container")
2510:         loc_oCnt = THIS.cnt_4c_Livre
2511:         WITH loc_oCnt
2512:             .Top         = 189
2513:             .Left        = 2
2514:             .Width       = 352
2515:             .Height      = 45
2516:             .BackStyle   = 0
2517:             .BorderWidth = 0
2518:             .Visible     = .T.
2519:         ENDWITH
2520: 
2521:         loc_oCnt.AddObject("lbl_4c_LblNLivDg", "Label")
2522:         WITH loc_oCnt.lbl_4c_LblNLivDg
2523:             .FontName  = "Tahoma"
2524:             .FontSize  = 8
2525:             .BackStyle = 0
2526:             .Alignment = 0
2527:             .AutoSize  = .F.
2528:             .Caption   = "Lacre"
2529:             .Left      = 3
2530:             .Top       = 3
2531:             .Width     = 60
2532:             .Height    = 15
2533:             .ForeColor = RGB(90, 90, 90)
2534:             .Visible   = .T.
2535:         ENDWITH
2536: 
2537:         loc_oCnt.AddObject("txt_4c_NLivDg", "TextBox")
2538:         WITH loc_oCnt.txt_4c_NLivDg
2539:             .Alignment     = 3
2540:             .MaxLength     = 15
2541:             .Value         = 0
2542:             .Left          = 3
2543:             .Top           = 20
2544:             .Width         = 169
2545:             .Height        = 23

*-- Linhas 2552 a 2849:
2552:         IF loc_lTemCursorPai
2553:             loc_oCnt.txt_4c_NLivDg.ControlSource = "TprMvCab.NLivDg"
2554:         ENDIF
2555:         BINDEVENT(loc_oCnt.txt_4c_NLivDg, "When", THIS, "PadraoIncluirAlterarWhen")
2556:     ENDPROC
2557: 
2558:     *==========================================================================
2559:     * AtualizarVisibilidadeCmdEntrega - "ThisForm.cmdEntrega.Visible =
2560:     * InList(crSigCdOpe.DtEntrs,1,4,6) And Not InList(ThisForm.pcEscolha,
2561:     * 'INSERIR','EXCLUIR')" do Init legado (linha 2100). crSigCdOpe e
2562:     * carregado pelo CursorQuery do Init legado, ainda nao portado (fases
2563:     * seguintes) - sem o cursor, o botao fica oculto (falso seguro); quem
2564:     * popular crSigCdOpe numa fase posterior deve chamar este metodo de
2565:     * novo para o botao assumir o estado real.
2566:     *
2567:     * PUBLIC: reutilizavel por fases/metodos futuros que alterem
2568:     * this_cPcEscolha ou recarreguem crSigCdOpe.
2569:     *==========================================================================
2570:     PROCEDURE AtualizarVisibilidadeCmdEntrega()
2571:         LOCAL loc_lVisivel
2572:         loc_lVisivel = .F.
2573: 
2574:         IF USED("crSigCdOpe")
2575:             loc_lVisivel = INLIST(crSigCdOpe.DtEntrs, 1, 4, 6) ;
2576:                 AND !INLIST(THIS.this_cPcEscolha, "INSERIR", "EXCLUIR")
2577:         ENDIF
2578: 
2579:         IF PEMSTATUS(THIS, "obj_4c_CmdEntrega", 5)
2580:             THIS.obj_4c_CmdEntrega.Visible = loc_lVisivel
2581:         ENDIF
2582:     ENDPROC
2583: 
2584:     *==========================================================================
2585:     * CmdCotacaoClick - "Do Form SigPrCtc With Thisform, ThisForm.DataSessionId,
2586:     * ThisForm.pcescolha, TprMvCab.Emps, TprMvCab.Dopes, TprMvCab.Numes" do
2587:     * legado (cmdCotacao.Valid). FormSigPrCtc.Init ja descarta o
2588:     * DataSessionId (arquitetura nova nao precisa dele): assinatura e
2589:     * (par_oFormPai, par_cEscolha, par_cEmps, par_cDopes, par_nNumes).
2590:     * FormSigPrCtc.BtnSairClick fecha com THIS.Release() - nao ha nada a
2591:     * ler nem a liberar depois do Show() aqui.
2592:     *
2593:     * PUBLIC: alvo de BINDEVENT("Click").
2594:     *==========================================================================
2595:     PROCEDURE CmdCotacaoClick()
2596:         LOCAL loc_oDlg, loc_oErro
2597:         loc_oDlg = .NULL.
2598: 
2599:         IF !USED("TprMvCab")
2600:             RETURN
2601:         ENDIF
2602: 
2603:         TRY
2604:             loc_oDlg = CREATEOBJECT("FormSigPrCtc", THIS, THIS.this_cPcEscolha, ;
2605:                 TprMvCab.Emps, TprMvCab.Dopes, TprMvCab.Numes)
2606:         CATCH TO loc_oErro
2607:             MsgErro(loc_oErro.Message + CHR(13) + ;
2608:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
2609:                 "Erro ao abrir Cota" + CHR(231) + CHR(227) + "o")
2610:             loc_oDlg = .NULL.
2611:         ENDTRY
2612: 
2613:         IF VARTYPE(loc_oDlg) = "O"
2614:             loc_oDlg.Show()
2615:         ENDIF
2616:     ENDPROC
2617: 
2618:     *==========================================================================
2619:     * CmdEntregaClick - "Local ldDat, lnMin, ldEst / ldDat = Iif(IsEmpty(
2620:     * TprMvCab.PrazoEnts), Date(), TprMvCab.PrazoEnts) / lnMin = Iif(IsEmpty(
2621:     * crSigOpCdc.NMinEnts), 0, crSigOpCdc.NMinEnts) / lnMax = Iif(IsEmpty(
2622:     * CrSigOpCdc.nMaxEnts), 0, CrSigOpCdc.nMaxEnts) / ldEst = Ttod(fDtoSQL(
2623:     * Nvl(TprMvCab.Datas, Date()))) / Do Form SigOpEnt With TprMvCab.Emps,
2624:     * TprMvCab.Dopes, TprMvCab.Numes, ldDat, ThisForm, lnMin, ldEst, .f.,
2625:     * lnMax" do legado (cmdEntrega.Valid). FormSigOpEnt fecha com Hide()
2626:     * (FecharDialogo) e devolve o resultado por ObterPrazoConfirmado() -
2627:     * ver comentario daquele metodo em FormSigOpEnt.prg. O campo "Entregas"
2628:     * (cnt_4c_Entregas.txt_4c_Entregas) e criado numa fase posterior - a
2629:     * atribuicao e guardada por PEMSTATUS/VARTYPE e nao falha enquanto o
2630:     * container nao existir.
2631:     *
2632:     * PUBLIC: alvo de BINDEVENT("Click").
2633:     *==========================================================================
2634:     PROCEDURE CmdEntregaClick()
2635:         LOCAL loc_oDlg, loc_oErro, loc_dAtual, loc_nMin, loc_nMax, loc_dEst, ;
2636:               loc_dConfirmado
2637: 
2638:         IF !USED("TprMvCab")
2639:             RETURN
2640:         ENDIF
2641: 
2642:         loc_dAtual = IIF(EMPTY(TprMvCab.PrazoEnts), DATE(), TprMvCab.PrazoEnts)
2643: 
2644:         loc_nMin = 0
2645:         loc_nMax = 0
2646:         IF USED("crSigOpCdc")
2647:             loc_nMin = IIF(EMPTY(crSigOpCdc.NMinEnts), 0, crSigOpCdc.NMinEnts)
2648:             loc_nMax = IIF(EMPTY(crSigOpCdc.NMaxEnts), 0, crSigOpCdc.NMaxEnts)
2649:         ENDIF
2650:         loc_dEst = TTOD(fDtoSQL(NVL(TprMvCab.Datas, DATE())))
2651: 
2652:         loc_oDlg = .NULL.
2653:         TRY
2654:             loc_oDlg = CREATEOBJECT("FormSigOpEnt", TprMvCab.Emps, TprMvCab.Dopes, ;
2655:                 TprMvCab.Numes, loc_dAtual, THIS, loc_nMin, loc_dEst, .F., loc_nMax)
2656:         CATCH TO loc_oErro
2657:             MsgErro(loc_oErro.Message + CHR(13) + ;
2658:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
2659:                 "Erro ao abrir Prazo de Entrega")
2660:             loc_oDlg = .NULL.
2661:         ENDTRY
2662: 
2663:         IF VARTYPE(loc_oDlg) = "O"
2664:             loc_oDlg.Show()
2665: 
2666:             loc_dConfirmado = loc_oDlg.ObterPrazoConfirmado()
2667:             IF !EMPTY(loc_dConfirmado)
2668:                 REPLACE PrazoEnts WITH loc_dConfirmado IN TprMvCab
2669: 
2670:                 IF PEMSTATUS(THIS, "cnt_4c_Entregas", 5) AND VARTYPE(THIS.cnt_4c_Entregas) = "O"
2671:                     IF PEMSTATUS(THIS.cnt_4c_Entregas, "txt_4c_Entregas", 5) ;
2672:                        AND VARTYPE(THIS.cnt_4c_Entregas.txt_4c_Entregas) = "O"
2673:                         THIS.cnt_4c_Entregas.txt_4c_Entregas.Value = loc_dConfirmado
2674:                         THIS.cnt_4c_Entregas.txt_4c_Entregas.Refresh()
2675:                     ENDIF
2676:                 ENDIF
2677:             ENDIF
2678: 
2679:             loc_oDlg.Release()
2680:         ENDIF
2681:     ENDPROC
2682: 
2683:     *==========================================================================
2684:     * CarregarCursoresOperacao - "With ThisForm.ParentForm.poDataMgr /
2685:     * .Cursorquery('SigCdOpe','CrSigCdOpe','Dopes',TprMvCab.Dopes) /
2686:     * .Cursorquery('SigOpCdc','CrSigOpCdc','Dopes',TprMvCab.Dopes) /
2687:     * .Cursorquery('SigOpCdd','CrSigOpCdd','Dopes',TprMvCab.Dopes)" do Init
2688:     * legado - os tres cursores que destravam os varios "falso seguro"
2689:     * espalhados pelas Fases 4/5/6 (USED("crSigCdOpe")/USED("CrSigOpCdc")).
2690:     * A 4a CursorQuery do legado (SigCdEmp/CrEmp) fica de fora - so e usada
2691:     * no bloco "Carrega Dados da Conta", fora do escopo desta fase (ver
2692:     * comentario de cabecalho do arquivo).
2693:     *
2694:     * PROTECTED: chamado uma unica vez, por InicializarForm().
2695:     *==========================================================================
2696:     PROTECTED PROCEDURE CarregarCursoresOperacao()
2697:         LOCAL loc_cSQL, loc_nErro
2698: 
2699:         IF !USED("TprMvCab")
2700:             RETURN
2701:         ENDIF
2702: 
2703:         IF USED("crSigCdOpe")
2704:             USE IN crSigCdOpe
2705:         ENDIF
2706:         loc_cSQL  = "SELECT * FROM SigCdOpe WHERE Dopes = " + EscaparSQL(TprMvCab.Dopes)
2707:         loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdOpe")
2708:         IF loc_nErro < 1
2709:             MsgErro("Favor reinicializar o processo." + CHR(13) + ;
2710:                 "Falha na conex" + CHR(227) + "o (SigCdOpe)", "Erro")
2711:         ENDIF
2712: 
2713:         IF USED("CrSigOpCdc")
2714:             USE IN CrSigOpCdc
2715:         ENDIF
2716:         loc_cSQL  = "SELECT * FROM SigOpCdc WHERE Dopes = " + EscaparSQL(TprMvCab.Dopes)
2717:         loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigOpCdc")
2718:         IF loc_nErro < 1
2719:             MsgErro("Favor reinicializar o processo." + CHR(13) + ;
2720:                 "Falha na conex" + CHR(227) + "o (SigOpCdc)", "Erro")
2721:         ENDIF
2722: 
2723:         IF USED("CrSigOpCdd")
2724:             USE IN CrSigOpCdd
2725:         ENDIF
2726:         loc_cSQL  = "SELECT * FROM SigOpCdd WHERE Dopes = " + EscaparSQL(TprMvCab.Dopes)
2727:         loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigOpCdd")
2728:         IF loc_nErro < 1
2729:             MsgErro("Favor reinicializar o processo." + CHR(13) + ;
2730:                 "Falha na conex" + CHR(227) + "o (SigOpCdd)", "Erro")
2731:         ENDIF
2732:     ENDPROC
2733: 
2734:     *==========================================================================
2735:     * CarregarPrazoEntregaPadrao - "PROCEDURE carregaprzent" do legado:
2736:     * sugere data de entrega padrao QUANDO o campo ainda esta vazio ou
2737:     * ainda e hoje - nunca sobrescreve um prazo que o usuario ja moveu.
2738:     *
2739:     *   If (InList(crSigCdOpe.DtEntrs,1,4,6) And InList(pcEscolha,
2740:     *      'INSERIR','ALTERAR') And (IsEmpty(PrazoEnts) Or
2741:     *      Dtos(PrazoEnts)=Dtos(Date())))
2742:     *       lcCta = Iif(crSigCdOpe.COpers=1, ContaDs, ContaOs)
2743:     *       If IsEmpty(PrazoEnts)
2744:     *           ldDat = Date()
2745:     *           If NMinEnts = NMaxEnts -> ldDat = Date()+NMinEnts
2746:     *       Else
2747:     *           ldDat = <PrazoEnts atual>
2748:     *       CursorQuery('SigCdCli','LocalCli','IClis',lcCta,'PrazoEnts')
2749:     *       If LocalCli.PrazoEnts > 0 -> ldDat = ldDat + LocalCli.PrazoEnts
2750:     *   EndIf
2751:     *
2752:     * PROTECTED: chamado so por AtualizarVisibilidadePorOperacao().
2753:     *==========================================================================
2754:     PROTECTED PROCEDURE CarregarPrazoEntregaPadrao()
2755:         LOCAL loc_cConta, loc_dPrazo, loc_cSQL, loc_nErro
2756: 
2757:         IF !USED("TprMvCab") OR !USED("crSigCdOpe")
2758:             RETURN
2759:         ENDIF
2760: 
2761:         IF !INLIST(crSigCdOpe.DtEntrs, 1, 4, 6) ;
2762:            OR !INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR") ;
2763:            OR (!EMPTY(TprMvCab.PrazoEnts) ;
2764:                AND DTOS(ConverterParaData(TprMvCab.PrazoEnts)) <> DTOS(DATE()))
2765:             RETURN
2766:         ENDIF
2767: 
2768:         loc_cConta = ALLTRIM(IIF(crSigCdOpe.COpers = 1, TprMvCab.ContaDs, TprMvCab.ContaOs))
2769: 
2770:         IF EMPTY(TprMvCab.PrazoEnts)
2771:             loc_dPrazo = DATE()
2772:             IF USED("CrSigOpCdc") AND CrSigOpCdc.NMinEnts = CrSigOpCdc.NMaxEnts
2773:                 loc_dPrazo = DATE() + CrSigOpCdc.NMinEnts
2774:                 REPLACE PrazoEnts WITH loc_dPrazo IN TprMvCab
2775:             ENDIF
2776:         ELSE
2777:             loc_dPrazo = ConverterParaData(TprMvCab.PrazoEnts)
2778:         ENDIF
2779: 
2780:         IF !EMPTY(loc_cConta)
2781:             loc_cSQL  = "SELECT PrazoEnts FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cConta)
2782:             loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrazoCliente")
2783: 
2784:             IF loc_nErro >= 1 AND RECCOUNT("cursor_4c_PrazoCliente") > 0 ;
2785:                AND cursor_4c_PrazoCliente.PrazoEnts > 0
2786:                 loc_dPrazo = loc_dPrazo + cursor_4c_PrazoCliente.PrazoEnts
2787:                 REPLACE PrazoEnts WITH loc_dPrazo IN TprMvCab
2788:             ENDIF
2789: 
2790:             IF USED("cursor_4c_PrazoCliente")
2791:                 USE IN cursor_4c_PrazoCliente
2792:             ENDIF
2793:         ENDIF
2794:     ENDPROC
2795: 
2796:     *==========================================================================
2797:     * AtualizarVisibilidadePorOperacao - o corpo do Init legado que liga
2798:     * Visible/Caption de cada container ao tipo de operacao corrente
2799:     * (crSigCdOpe/CrSigOpCdc/CrSigOpCdd, carregados por
2800:     * CarregarCursoresOperacao()). Chamada DEPOIS de
2801:     * TornarControlesVisiveis(THIS): esse metodo reescreve Visible = .T.
2802:     * em CADA AddObject recursivamente, entao a regra de negocio desta
2803:     * tela so vale se for aplicada POR CIMA dele, nao antes.
2804:     *
2805:     * PUBLIC: reutilizavel por fases/metodos futuros que recarreguem os
2806:     * cursores de operacao (mesmo padrao de AtualizarVisibilidadeCmdEntrega,
2807:     * Fase 4) - chamada de novo no final daqui pela mesma razao.
2808:     *==========================================================================
2809:     PROCEDURE AtualizarVisibilidadePorOperacao()
2810:         LOCAL loc_lFiscal
2811: 
2812:         IF !USED("TprMvCab") OR !USED("crSigCdOpe")
2813:             RETURN
2814:         ENDIF
2815: 
2816:         *** Digita Observacao / Digita Entrega / CntObs2
2817:         THIS.cnt_4c_Observacao.Visible = INLIST(crSigCdOpe.DigObs, 1, 3)
2818:         THIS.cnt_4c_Entrega.Visible    = INLIST(crSigCdOpe.DtEntrs, 3, 4, 5, 6)
2819: 
2820:         IF USED("CrSigOpCdd") AND PEMSTATUS(THIS, "cnt_4c_Obs2", 5)
2821:             THIS.cnt_4c_Obs2.Visible = (INT(VAL(SUBSTR(CrSigOpCdd.ConfigGers, 209, 1))) = 1)
2822:         ENDIF
2823: 
2824:         *** Digita Dados Fiscais
2825:         loc_lFiscal = (crSigCdOpe.CupFis = 4)
2826:         THIS.cnt_4c_Ecfs.Visible  = loc_lFiscal
2827:         THIS.cnt_4c_Nemps.Visible = loc_lFiscal
2828: 
2829:         THIS.cnt_4c_Volumes.Visible = (crSigCdOpe.DadosNotas = 1)
2830:         THIS.cnt_4c_Pedido.Visible  = INLIST(crSigCdOpe.PedClis, 1, 3, 4, 5)
2831: 
2832:         IF USED("CrSigOpCdc")
2833:             THIS.cnt_4c_Protocolo.Visible = (CrSigOpCdc.EditProts = 1)
2834:         ENDIF
2835: 
2836:         *-- Carrega Dados da Conta (crSigCdOpe.Opers = 2): o legado busca o
2837:         *-- valor inicial em ThisForm.ParentForm.Pagina.Dados.pgfprincipal.
2838:         *-- pgcontas.Destino.Get_Conta (pagina do form pai) e no cursor
2839:         *-- TmpOperacao (grade de itens) - nenhum dos dois pertence a este
2840:         *-- dialogo. Falso seguro parcial: ao menos confirma/preenche
2841:         *-- Nome e CPF/CNPJ a partir do codigo JA presente em
2842:         *-- TprMvCab.ContaEs, igual ao "lcCliente = TprMvCab.ContaEs /
2843:         *-- CursorQuery(...) / getDConta.Value = ... / getCpfs.Value = ..."
2844:         *-- que fecha esse trecho do Init legado.
2845:         IF !EMPTY(TprMvCab.ContaEs)
2846:             THIS.BuscarContaEntrega("IClis", ALLTRIM(TprMvCab.ContaEs))
2847:         ENDIF
2848: 
2849:         *** Digita Documento / Data de Emissao

*-- Linhas 2877 a 2935:
2877:         *-- Reaplica por cima do que ConfigurarBotoesAcao (Fase 4) ja tinha
2878:         *-- calculado antes dos cursores existirem - e o que faz a
2879:         *-- visibilidade real do botao de atalho de Prazo de Entrega valer
2880:         *-- depois do TornarControlesVisiveis.
2881:         THIS.AtualizarVisibilidadeCmdEntrega()
2882:     ENDPROC
2883: 
2884:     *==========================================================================
2885:     * AjustarPosicaoCampos - "PROCEDURE ajustaobjs" do legado: reflui os
2886:     * containers da 1a linha (Ecfs/Nemps/Protocolo/Pedido, a partir de
2887:     * cnt_4c_Codigos+cnt_4c_Documentos), da 2a linha (Emiss/Entregas/
2888:     * Recepcaos/PrzEnts/Livre) e dos containers empilhados por baixo
2889:     * (Observacao/Entrega/Volumes), preenchendo o espaco dos que a
2890:     * AtualizarVisibilidadePorOperacao() acabou de ocultar. Chamada por
2891:     * ultimo em InicializarForm(), com a visibilidade ja definitiva.
2892:     *
2893:     * PROTECTED: chamado uma unica vez, por InicializarForm().
2894:     *==========================================================================
2895:     PROTECTED PROCEDURE AjustarPosicaoCampos()
2896:         LOCAL loc_nLf0, loc_nTp0, loc_nLft, loc_nTop
2897: 
2898:         loc_nLf0 = THIS.cnt_4c_Codigos.Left
2899:         loc_nTp0 = THIS.cnt_4c_Codigos.Top
2900: 
2901:         *-- Ajustando Primeira Linha de Campos
2902:         loc_nLft = loc_nLf0 + THIS.cnt_4c_Documentos.Width + THIS.cnt_4c_Codigos.Width
2903:         loc_nTop = loc_nTp0
2904: 
2905:         IF THIS.cnt_4c_Ecfs.Visible
2906:             THIS.cnt_4c_Ecfs.Left = loc_nLft
2907:             THIS.cnt_4c_Ecfs.Top  = loc_nTop
2908:             loc_nLft = loc_nLft + THIS.cnt_4c_Ecfs.Width
2909:         ENDIF
2910: 
2911:         IF THIS.cnt_4c_Nemps.Visible
2912:             THIS.cnt_4c_Nemps.Left = loc_nLft
2913:             THIS.cnt_4c_Nemps.Top  = loc_nTop
2914:             loc_nLft = loc_nLft + THIS.cnt_4c_Nemps.Width
2915:         ENDIF
2916: 
2917:         IF THIS.cnt_4c_Protocolo.Visible
2918:             THIS.cnt_4c_Protocolo.Left = loc_nLft
2919:             THIS.cnt_4c_Protocolo.Top  = loc_nTop
2920:             loc_nLft = loc_nLft + THIS.cnt_4c_Protocolo.Width
2921:         ENDIF
2922: 
2923:         IF THIS.cnt_4c_Pedido.Visible
2924:             THIS.cnt_4c_Pedido.Left = loc_nLft
2925:             THIS.cnt_4c_Pedido.Top  = loc_nTop
2926:             loc_nLft = loc_nLft + THIS.cnt_4c_Pedido.Width
2927:         ENDIF
2928: 
2929:         loc_nLft = loc_nLf0
2930:         loc_nTop = loc_nTp0 + THIS.cnt_4c_Codigos.Height + 1
2931: 
2932:         *-- Ajustando Segunda Linha de Campos
2933:         IF THIS.cnt_4c_Emiss.Visible
2934:             THIS.cnt_4c_Emiss.Left = loc_nLft
2935:             THIS.cnt_4c_Emiss.Top  = loc_nTop

*-- Linhas 3002 a 3232:
3002:     * Form receber o KeyPress ANTES dos controles - exigido para capturar
3003:     * F2/F3 em qualquer campo focado, como no legado.
3004:     *==========================================================================
3005:     PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
3006:         IF PEMSTATUS(THIS, "cnt_4c_Entrega", 5) AND VARTYPE(THIS.cnt_4c_Entrega) = "O"
3007:             IF THIS.cnt_4c_Entrega.cmd_4c_CmdEntrega.Visible AND par_nKeyCode = -1
3008:                 THIS.EntregaLocalClick()
3009:                 NODEFAULT
3010:                 RETURN
3011:             ENDIF
3012:         ENDIF
3013: 
3014:         IF PEMSTATUS(THIS, "obj_4c_CmdEntrega", 5) AND VARTYPE(THIS.obj_4c_CmdEntrega) = "O"
3015:             IF THIS.obj_4c_CmdEntrega.Visible AND par_nKeyCode = -2
3016:                 THIS.CmdEntregaClick()
3017:                 NODEFAULT
3018:             ENDIF
3019:         ENDIF
3020:     ENDPROC
3021: 
3022:     *==========================================================================
3023:     * TornarControlesVisiveis - Torna visiveis, recursivamente, os controles
3024:     * criados por AddObject (que nascem com Visible = .F.). Percorre tambem
3025:     * Pages de eventuais PageFrames filhos (nenhum nesta tela, mas o metodo
3026:     * fica generico para as proximas fases).
3027:     *==========================================================================
3028:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
3029:         LOCAL loc_nI, loc_oObjeto, loc_nP
3030: 
3031:         FOR loc_nI = 1 TO par_oContainer.ControlCount
3032:             loc_oObjeto = par_oContainer.Controls(loc_nI)
3033: 
3034:             IF VARTYPE(loc_oObjeto) = "O"
3035:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
3036:                     loc_oObjeto.Visible = .T.
3037:                 ENDIF
3038: 
3039:                 IF PEMSTATUS(loc_oObjeto, "BaseClass", 5) ;
3040:                    AND UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
3041:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
3042:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
3043:                     ENDFOR
3044:                 ENDIF
3045: 
3046:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
3047:                     THIS.TornarControlesVisiveis(loc_oObjeto)
3048:                 ENDIF
3049:             ENDIF
3050:         ENDFOR
3051:     ENDPROC
3052: 
3053:     *==========================================================================
3054:     * Destroy - Reabilita o form pai (ver DesabilitarFormPai) e segue para o
3055:     * fechamento canonico do FormBase (restauracao do menu principal).
3056:     *==========================================================================
3057:     PROCEDURE Destroy()
3058:         THIS.ReabilitarFormPai()
3059:         DODEFAULT()
3060:     ENDPROC
3061: 
3062:     *==========================================================================
3063:     * BtnSalvarClick - "PROCEDURE btnSelItens.Click" do legado (170 linhas):
3064:     *
3065:     *   If Inlist(pcEscolha,'INSERIR','ALTERAR')
3066:     *       [observacao obrigatoria / data de emissao / prazo de entrega +
3067:     *        recalculo de vencimentos + liberacao Min/Max / recepcao /
3068:     *        cupom fiscal-ECF / EditDocs=4]
3069:     *   Else
3070:     *       If fChecaAcesso(..., 'ALTINFO') And pcEscolha = 'CONSULTAR'
3071:     *           Update SigMvCab Set obses = ... Where CidChaves = ...
3072:     *       Endif
3073:     *   Endif
3074:     *   ThisForm.Return
3075:     *
3076:     * Cada "Return"/"Return .f." do legado (saida ANTECIPADA, sem gravar) e
3077:     * um RETURN bare deste metodo - so o CAMINHO FELIZ (fim de qualquer dos
3078:     * dois ramos) chama THIS.FecharDialogo(), equivalente ao "ThisForm.
3079:     * Return" final do legado.
3080:     *
3081:     * Guard de topo: sem TprMvCab/crSigCdOpe (cursores do form pai/Init
3082:     * legado) nao ha o que validar nem gravar - mesmo "falso seguro" das
3083:     * Fases 5-7 (CarregarPrazoEntregaPadrao, AtualizarVisibilidadePorOperacao).
3084:     *
3085:     * PUBLIC: alvo de BINDEVENT("Click") em ConfigurarBotoesAcao (Fase 4).
3086:     *==========================================================================
3087:     PROCEDURE BtnSalvarClick()
3088:         LOCAL loc_dLimiteMin, loc_dLimiteMax, loc_dData, loc_cHora
3089: 
3090:         IF !USED("TprMvCab") OR !USED("crSigCdOpe")
3091:             RETURN
3092:         ENDIF
3093: 
3094:         IF INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
3095: 
3096:             *-- Observacao obrigatoria (DigObs = 3)
3097:             IF crSigCdOpe.DigObs = 3 AND (EMPTY(TprMvCab.CodObs) OR EMPTY(TprMvCab.Obses))
3098:                 MsgAviso("Obrigat" + CHR(243) + "rio Informar " + ;
3099:                     IIF(EMPTY(TprMvCab.CodObs), "C" + CHR(243) + "digo da ", "") + ;
3100:                     "Observa" + CHR(231) + CHR(227) + "o para essa Opera" + CHR(231) + ;
3101:                     CHR(227) + "o ... ", ;
3102:                     "Observa" + CHR(231) + CHR(227) + "o " + CHR(233) + " Informa" + ;
3103:                     CHR(231) + CHR(227) + "o Obrigat" + CHR(243) + "ria")
3104:                 IF EMPTY(TprMvCab.CodObs)
3105:                     THIS.cnt_4c_Observacao.txt_4c_CodObs.SetFocus()
3106:                 ELSE
3107:                     THIS.cnt_4c_Observacao.obj_4c_GetDesObs.SetFocus()
3108:                 ENDIF
3109:                 RETURN
3110:             ENDIF
3111: 
3112:             *-- Data de Emissao obrigatoria (DtEmis = 3)
3113:             IF EMPTY(TprMvCab.DtEmis) AND crSigCdOpe.DtEmis = 3
3114:                 MsgAviso("Data de Emiss" + CHR(227) + "o do Documento precisa ser " + ;
3115:                     "informada ... ", ;
3116:                     "Data de Emiss" + CHR(227) + "o : Informa" + CHR(231) + CHR(227) + ;
3117:                     "o Obrigat" + CHR(243) + "ria")
3118:                 THIS.cnt_4c_Emiss.txt_4c_Emiss.SetFocus()
3119:                 RETURN
3120:             ENDIF
3121: 
3122:             *-- Prazo de Entrega preenchido: grava com hora + recalcula
3123:             *-- vencimentos das parcelas (xPar - cursor do form pai, falso
3124:             *-- seguro via USED() dentro de RecalcularVencimentosParcelas)
3125:             IF !EMPTY(TprMvCab.PrazoEnts)
3126:                 loc_dData = ConverterParaData(TprMvCab.PrazoEnts)
3127:                 loc_cHora = TIME(TprMvCab.PrazoEnts)
3128:                 REPLACE PrazoEnts WITH fDtoSQL(loc_dData, loc_cHora) IN TprMvCab
3129:                 THIS.cnt_4c_Entregas.txt_4c_Entregas.Refresh()
3130: 
3131:                 THIS.RecalcularVencimentosParcelas("xPar", .F.)
3132:             ENDIF
3133: 
3134:             *-- Prazo de Entrega: obrigatoriedade + faixa Minima/Maxima
3135:             IF INLIST(crSigCdOpe.DtEntrs, 1, 4, 6)
3136:                 IF EMPTY(TprMvCab.PrazoEnts)
3137:                     MsgAviso("Prazo de Entrega deve ser informado...", "")
3138:                     THIS.cnt_4c_Entregas.txt_4c_Entregas.SetFocus()
3139:                     RETURN
3140:                 ENDIF
3141: 
3142:                 IF ConverterParaData(TprMvCab.PrazoEnts) < ConverterParaData(TprMvCab.Datas)
3143:                     MsgAviso("Prazo de Entrega deve ser maior que a Data da " + ;
3144:                         "Movimenta" + CHR(231) + CHR(227) + "o...", "")
3145:                     THIS.cnt_4c_Entregas.txt_4c_Entregas.SetFocus()
3146:                     RETURN
3147:                 ENDIF
3148: 
3149:                 IF USED("CrSigOpCdc") AND CrSigOpCdc.NMinEnts > 0 AND !THIS.this_lValidOk
3150:                     loc_dLimiteMin = ConverterParaData(TprMvCab.Datas) + CrSigOpCdc.NMinEnts
3151:                     IF ConverterParaData(TprMvCab.PrazoEnts) < loc_dLimiteMin
3152:                         IF !THIS.SolicitarLiberacaoPrazoEntrega(loc_dLimiteMin, ;
3153:                                 ConverterParaData(TprMvCab.PrazoEnts), "M" + CHR(237) + "nimo")
3154:                             THIS.cnt_4c_Entregas.txt_4c_Entregas.Value = loc_dLimiteMin
3155:                             THIS.cnt_4c_Entregas.txt_4c_Entregas.SetFocus()
3156:                             RETURN
3157:                         ENDIF
3158:                     ENDIF
3159:                 ENDIF
3160: 
3161:                 IF USED("CrSigOpCdc") AND CrSigOpCdc.NMaxEnts > 0 AND !THIS.this_lValidOk
3162:                     loc_dLimiteMax = ConverterParaData(TprMvCab.Datas) + CrSigOpCdc.NMaxEnts
3163:                     IF ConverterParaData(TprMvCab.PrazoEnts) > loc_dLimiteMax
3164:                         IF !THIS.SolicitarLiberacaoPrazoEntrega(loc_dLimiteMax, ;
3165:                                 ConverterParaData(TprMvCab.PrazoEnts), "M" + CHR(225) + "ximo")
3166:                             THIS.cnt_4c_Entregas.txt_4c_Entregas.Value = loc_dLimiteMax
3167:                             THIS.cnt_4c_Entregas.txt_4c_Entregas.SetFocus()
3168:                             RETURN
3169:                         ENDIF
3170:                     ENDIF
3171:                 ENDIF
3172:             ENDIF
3173: 
3174:             *-- Data de Recepcao obrigatoria (DigRecs = 1)
3175:             IF crSigCdOpe.DigRecs = 1
3176:                 IF EMPTY(TprMvCab.DtRecs)
3177:                     MsgAviso("Data de Recep" + CHR(231) + CHR(227) + "o deve ser " + ;
3178:                         "informada ...", "")
3179:                     THIS.cnt_4c_Recepcaos.txt_4c_Recepcaos.SetFocus()
3180:                     RETURN
3181:                 ENDIF
3182:             ENDIF
3183: 
3184:             *-- Cupom Fiscal/ECF obrigatorios (CupFis = 4)
3185:             IF crSigCdOpe.CupFis = 4
3186:                 IF EMPTY(TprMvCab.Ecfs)
3187:                     MsgAviso("N" + CHR(250) + "mero do ECF Precisa Ser Informado...", "")
3188:                     THIS.cnt_4c_Ecfs.txt_4c_Ecfs.SetFocus()
3189:                     RETURN
3190:                 ENDIF
3191:                 IF EMPTY(TprMvCab.Nemps)
3192:                     MsgAviso("N" + CHR(250) + "mero de S" + CHR(233) + "rie da " + ;
3193:                         "Impressora Precisa Ser Informado...", "")
3194:                     THIS.cnt_4c_Nemps.txt_4c_Nemps.SetFocus()
3195:                     RETURN
3196:                 ENDIF
3197:             ENDIF
3198: 
3199:             *-- EditDocs = 4: numero da nota reformatado na grade de itens do
3200:             *-- movimento (crTpmMvItn) - cursor do form pai, falso seguro:
3201:             *-- sem ele (nenhum caller desta tela no acervo) fica de fora.
3202:             IF crSigCdOpe.EditDocs = 4 AND USED("crTpmMvItn")
3203:                 REPLACE ALL Notas WITH TRANSFORM(VAL(TprMvCab.Notas), "@L 999999") IN crTpmMvItn
3204:             ENDIF
3205: 
3206:         ELSE
3207:             *-- CONSULTAR com acesso ALTINFO liberado: confirma a observacao
3208:             *-- (mesmo gate de DesObsWhen, Fase 6)
3209:             IF fChecaAcesso(PADL(TRANSFORM(crSigCdOpe.nDopes), 8, "0"), "ALTINFO") ;
3210:                AND THIS.this_cPcEscolha = "CONSULTAR"
3211:                 THIS.this_oBusinessObject.this_cObses     = ALLTRIM(TprMvCab.Obses)
3212:                 THIS.this_oBusinessObject.this_cCidChaves = TprMvCab.CidChaves
3213:                 IF !THIS.this_oBusinessObject.Atualizar()
3214:                     RETURN
3215:                 ENDIF
3216:             ENDIF
3217:         ENDIF
3218: 
3219:         THIS.FecharDialogo()
3220:     ENDPROC
3221: 
3222:     *==========================================================================
3223:     * SolicitarLiberacaoPrazoEntrega - "Do Form SigOpSen With 'LIBPRZENT',
3224:     * 'Libera Prazo de Entrega' To _Retorno" do btnSelItens.Click legado,
3225:     * repetido para o limite Minimo e para o Maximo (so o rotulo/valor
3226:     * mudam):
3227:     *
3228:     *   Do Form SigOpSen With 'LIBPRZENT', 'Libera Prazo de Entrega' To _Retorno
3229:     *   llOk = ( Left( _Retorno, 1 ) = "*" )
3230:     *   lcUsuLib = Substr( _Retorno, 2 )
3231:     *   If !llOk -> Messagebox(...) / Return .f.
3232:     *   Else -> thisform.validok = .t. / fGravarLog('T', Dopes, 'LIBPRZENT', ...)

*-- Linhas 3277 a 3320:
3277:             THIS.this_lValidOk = .T.
3278:         ELSE
3279:             IF loc_lDialogoAbriu
3280:                 MsgAviso("Prazo de Entrega " + par_cRotulo + " " + CHR(233) + " " + ;
3281:                     DTOC(par_dLimite) + "...", "")
3282:             ELSE
3283:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel abrir a tela " + ;
3284:                     "de autoriza" + CHR(231) + CHR(227) + "o (SigOpSen)." + CHR(13) + ;
3285:                     "O prazo de entrega N" + CHR(195) + "O foi liberado." + CHR(13) + ;
3286:                     CHR(13) + "Detalhe: " + loc_cFalhaDialogo, "Libera Prazo de Entrega")
3287:             ENDIF
3288:         ENDIF
3289: 
3290:         RETURN loc_lAutorizado
3291:     ENDFUNC
3292: 
3293:     *==========================================================================
3294:     * RecalcularVencimentosParcelas - laco de recalculo de vencimentos do
3295:     * btnSelItens.Click legado (disparado quando o Prazo de Entrega muda):
3296:     *
3297:     *   Select xPar / Index on Fpags+cnidTefs+Str(Parcs,2) Tag FpagV / Scan
3298:     *       =CursorQuery('SigOpFp','LocalFpag','fpags',xPar.Fpags,
3299:     *           [TpVencs,Entradas,Dias,tVens])
3300:     *       If LocalFpag.TpVencs = 2
3301:     *           DVenc = (Ttod(TprMvCab.PrazoEnts) + LocalFpag.Entradas)
3302:     *           Scan While Fpags=_lcFpg And cnIdTefs=_lcIdT
3303:     *               [laco de feriados] / Replace Vencs With DVenc
3304:     *               DVenc = Iif(TVen='F', GoMonth(DVenc,1), DVenc+NDia)
3305:     *           EndScan
3306:     *           Skip -1
3307:     *       Endif
3308:     *   EndScan
3309:     *
3310:     * par_cCursor: alias do cursor de parcelas a recalcular, agrupado por
3311:     * Fpags+CnIdTefs (colunas Fpags/CnIdTefs/Parcs/Vencs/CidChaves). "xPar"
3312:     * (parcelas do lancamento corrente, BtnSalvarClick) e "LocalPar"
3313:     * (parcelas de SigMvPar no lancamento direto, ProcessarLancamentoDireto)
3314:     * usam este MESMO metodo - layout de colunas identico, so a origem
3315:     * difere. Falso seguro: sem o cursor (par_cCursor), nao ha o que
3316:     * recalcular.
3317:     *
3318:     * par_lAtualizarBanco = .T. (LocalPar) tambem grava o vencimento no SQL
3319:     * Server ("Update SigMvPar Set Vencs = ... Where CidChaves = ..."),
3320:     * como o legado faz nesse caminho; .F. (xPar) e so cursor em memoria do

*-- Linhas 3327 a 3370:
3327:     *
3328:     * PROTECTED: chamado so por BtnSalvarClick() e ProcessarLancamentoDireto().
3329:     *==========================================================================
3330:     PROTECTED PROCEDURE RecalcularVencimentosParcelas(par_cCursor, par_lAtualizarBanco)
3331:         LOCAL loc_dVenc, loc_nDias, loc_cTipoVenc, loc_cFpgAtual, loc_cIdTefAtual
3332:         LOCAL loc_cSQLFpg, loc_nErro, loc_cSQLUpdate, loc_cCidChave
3333: 
3334:         IF !USED(par_cCursor) OR !USED("TprMvCab") OR EMPTY(TprMvCab.PrazoEnts)
3335:             RETURN
3336:         ENDIF
3337: 
3338:         SELECT (par_cCursor)
3339:         INDEX ON Fpags + CnIdTefs + STR(Parcs, 2) TAG FpagV
3340:         SCAN
3341:             loc_cFpgAtual = Fpags
3342: 
3343:             IF USED("cursor_4c_FpgVenc")
3344:                 USE IN cursor_4c_FpgVenc
3345:             ENDIF
3346:             loc_cSQLFpg = "SELECT TpVencs, Entradas, Dias, tVens FROM SigOpFp " + ;
3347:                 "WHERE Fpags = " + EscaparSQL(loc_cFpgAtual)
3348:             loc_nErro   = SQLEXEC(gnConnHandle, loc_cSQLFpg, "cursor_4c_FpgVenc")
3349:             SELECT (par_cCursor)
3350: 
3351:             IF loc_nErro >= 1 AND USED("cursor_4c_FpgVenc") AND cursor_4c_FpgVenc.TpVencs = 2
3352:                 loc_dVenc       = ConverterParaData(TprMvCab.PrazoEnts) + cursor_4c_FpgVenc.Entradas
3353:                 loc_nDias       = cursor_4c_FpgVenc.Dias
3354:                 loc_cTipoVenc   = cursor_4c_FpgVenc.tVens
3355:                 loc_cFpgAtual   = Fpags
3356:                 loc_cIdTefAtual = CnIdTefs
3357: 
3358:                 SCAN WHILE Fpags = loc_cFpgAtual AND CnIdTefs = loc_cIdTefAtual
3359:                     loc_dVenc = THIS.AvancarAlemDosFeriados(loc_dVenc)
3360:                     REPLACE Vencs WITH loc_dVenc IN (par_cCursor)
3361: 
3362:                     IF par_lAtualizarBanco
3363:                         loc_cCidChave  = CidChaves
3364:                         loc_cSQLUpdate = "UPDATE SigMvPar SET Vencs = " + ;
3365:                             FormatarDataSQL(loc_dVenc) + " WHERE CidChaves = " + ;
3366:                             EscaparSQL(loc_cCidChave)
3367:                         IF SQLEXEC(gnConnHandle, loc_cSQLUpdate) < 1
3368:                             MsgErro("Favor reinicializar o processo." + CHR(13) + ;
3369:                                 "Falha na conex" + CHR(227) + "o (Update SigMvPar)", "Erro")
3370:                         ENDIF

*-- Linhas 3386 a 3429:
3386:     * ("|AAAAMMDD|..."), mesmo padrao de FormSigOpFpg.CarregarFeriados -
3387:     * evita um SELECT por parcela dentro do laco de recalculo.
3388:     *==========================================================================
3389:     PROTECTED PROCEDURE CarregarFeriados()
3390:         LOCAL loc_cSQL, loc_nResultado, loc_cLista, loc_oErro
3391: 
3392:         IF THIS.this_lFeriadosCarregados
3393:             RETURN .T.
3394:         ENDIF
3395: 
3396:         loc_cLista = "|"
3397: 
3398:         TRY
3399:             IF USED("cursor_4c_FerLoad")
3400:                 USE IN SELECT("cursor_4c_FerLoad")
3401:             ENDIF
3402: 
3403:             loc_cSQL = "SELECT DISTINCT datas FROM SigCdFer"
3404: 
3405:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FerLoad")
3406: 
3407:             IF loc_nResultado > 0 AND USED("cursor_4c_FerLoad")
3408:                 SELECT cursor_4c_FerLoad
3409:                 SCAN
3410:                     IF !ISNULL(datas) AND !EMPTY(datas)
3411:                         loc_cLista = loc_cLista + DTOS(ConverterParaData(datas)) + "|"
3412:                     ENDIF
3413:                 ENDSCAN
3414:                 USE IN SELECT("cursor_4c_FerLoad")
3415:             ENDIF
3416: 
3417:             THIS.this_cFeriadosCache      = loc_cLista
3418:             THIS.this_lFeriadosCarregados = .T.
3419:         CATCH TO loc_oErro
3420:             THIS.this_cFeriadosCache = "|"
3421:         ENDTRY
3422: 
3423:         RETURN .T.
3424:     ENDPROC
3425: 
3426:     *==========================================================================
3427:     * AvancarAlemDosFeriados - laco de feriados do btnSelItens.Click legado:
3428:     *
3429:     *   lnFer = 0 / Verd = .t.

*-- Linhas 3468 a 3573:
3468:     ENDFUNC
3469: 
3470:     *==========================================================================
3471:     * FecharDialogo - "PROCEDURE return" do legado:
3472:     *
3473:     *   If ThisForm.Direta
3474:     *       [ver ProcessarLancamentoDireto()]
3475:     *   Endif
3476:     *   ThisForm.parentform.enabled = .T.
3477:     *   thisform.parentform.validok = thisform.validok
3478:     *   ThisForm.parentform.pagina.dados.dados.setfocus
3479:     *   ThisForm.release
3480:     *
3481:     * "ThisForm.parentform.enabled = .T." ja acontece em Destroy()
3482:     * (ReabilitarFormPai(), Fase 3) - Release() dispara Destroy() antes de
3483:     * destruir o objeto, entao nao duplicado aqui.
3484:     *
3485:     * "ThisForm.parentform.pagina.dados.dados.setfocus" refere-se a um
3486:     * controle especifico do form pai (frmcadastro legado) sem equivalente
3487:     * conhecido nesta migracao - nenhum caller de Formsigopinf existe no
3488:     * acervo (ver cabecalho do arquivo) para definir esse equivalente.
3489:     * Omitido, documentado, nao inventado.
3490:     *
3491:     * THIS.Release() (nao Hide()): esta classe NAO isola DataSession (fica
3492:     * no default = 1, ver comentario de cabecalho "DataSession") - ao
3493:     * contrario de FormSigOpFpg (DataSession = 2), nao ha razao para
3494:     * sobreviver ao fechamento, e Release() e transcricao fiel do
3495:     * "ThisForm.release" legado.
3496:     *
3497:     * PUBLIC: alvo de chamada de BtnSalvarClick() (fim de cada ramo) e do
3498:     * form pai, se precisar fechar o dialogo por codigo.
3499:     *==========================================================================
3500:     PROCEDURE FecharDialogo()
3501:         THIS.ProcessarLancamentoDireto()
3502: 
3503:         IF VARTYPE(THIS.this_oFormPai) = "O" ;
3504:            AND PEMSTATUS(THIS.this_oFormPai, "this_lValidOk", 5)
3505:             THIS.this_oFormPai.this_lValidOk = THIS.this_lValidOk
3506:         ENDIF
3507: 
3508:         THIS.Release()
3509:     ENDPROC
3510: 
3511:     *==========================================================================
3512:     * ProcessarLancamentoDireto - ramo "If ThisForm.Direta" do "PROCEDURE
3513:     * return" legado:
3514:     *
3515:     *   Select CrSigMvCab / Zap / Select TprMvCab / Scatter Memvar memo /
3516:     *   Select CrSigMvCab / Append Blank / Gather Memvar Memo
3517:     *   lcSql = Select a.*, b.TpVencs,b.Entradas,b.dias,b.tVens From SigMvPar a,
3518:     *       SigOpFp b where a.EmpDopNums = <TprMvCab.EmpDopNums> And a.Fpags = b.fpags
3519:     *   Select LocalPar / Index on Fpags+cnidTefs+Str(Parcs,2) Tag FpagV / Scan
3520:     *       [recalculo de vencimentos + Update SigMvPar - ver
3521:     *        RecalcularVencimentosParcelas]
3522:     *   EndScan
3523:     *   llOk = UpDate('CrSigMvCab') And Commit() > 0 / If !llOk -> RollBack()
3524:     *   Select TprMvCab / Zap
3525:     *
3526:     * CrSigMvCab (cursor de BATCH do lancamento direto) e o commit em lote
3527:     * (ThisForm.ParentForm.PoDataMgr.UpDate/Commit/RollBack) pertencem ao
3528:     * form PAI/orquestrador da operacao, inexistente nesta migracao (nenhum
3529:     * caller de Formsigopinf no acervo - ver cabecalho do arquivo). Falso
3530:     * seguro: sem CrSigMvCab, o bloco INTEIRO fica de fora - inclusive o
3531:     * recalculo de SigMvPar (que so faz sentido acoplado ao commit em lote)
3532:     * e o "Select TprMvCab / Zap" final, que SEM o lote persistido em outro
3533:     * lugar destruiria os dados do usuario (regra CLAUDE.md #17 - nao
3534:     * reproduzir so a metade de uma formula/fluxo que depende do resto).
3535:     *
3536:     * PROTECTED: so FecharDialogo(), desta mesma classe, chama.
3537:     *==========================================================================
3538:     PROTECTED PROCEDURE ProcessarLancamentoDireto()
3539:         LOCAL loc_cSQL, loc_nErro
3540: 
3541:         IF !THIS.this_lDireta OR !USED("CrSigMvCab") OR !USED("TprMvCab")
3542:             RETURN
3543:         ENDIF
3544: 
3545:         IF EMPTY(TprMvCab.EmpDopNums)
3546:             RETURN
3547:         ENDIF
3548: 
3549:         IF USED("LocalPar")
3550:             USE IN LocalPar
3551:         ENDIF
3552:         loc_cSQL = "SELECT a.*, b.TpVencs, b.Entradas, b.Dias, b.tVens " + ;
3553:             "FROM SigMvPar a, SigOpFp b " + ;
3554:             "WHERE a.EmpDopNums = " + EscaparSQL(TprMvCab.EmpDopNums) + " " + ;
3555:             "AND a.Fpags = b.Fpags"
3556:         loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "LocalPar")
3557:         IF loc_nErro < 1
3558:             MsgErro("Favor reinicializar o processo." + CHR(13) + ;
3559:                 "Falha na conex" + CHR(227) + "o ( LocalPar )", "Erro")
3560:             RETURN
3561:         ENDIF
3562: 
3563:         THIS.RecalcularVencimentosParcelas("LocalPar", .T.)
3564: 
3565:         IF USED("LocalPar")
3566:             USE IN LocalPar
3567:         ENDIF
3568: 
3569:         *-- Commit em lote (CrSigMvCab) fora do escopo desta migracao - ver
3570:         *-- comentario de cabecalho do metodo.
3571:     ENDPROC
3572: 
3573: ENDDEFINE


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

