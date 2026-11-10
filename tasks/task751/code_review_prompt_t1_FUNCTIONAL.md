# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (11)
- [LOSTFOCUS-SEM-GUARDIA] Handler 'CodObsLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoCodObsLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ContasLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoContasLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'CpfsLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoCpfsLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'DContaLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoDContaLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopinf.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (3513 linhas total):

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

*-- Linhas 287 a 477:
287:     * A ordem posicional e IDENTICA ao Lparameters do legado
288:     *   (pForm, pData, plAltDireta, plAutomatico)
289:     * para que a chamada da tela de movimentacao
290:     *   CREATEOBJECT("Formsigopinf", THIS, <sessao>, <direta>, <automatico>)
291:     * seja transcricao direta do "Do Form SIGOPINF With ..." legado.
292:     *
293:     * Todos os argumentos sao OPCIONAIS: o harness de teste e os probes
294:     * headless instanciam o form sem nenhum deles, e nesse caso cada
295:     * propriedade mantem o default declarado acima.
296:     *
297:     * par_lDireta/par_lAutomatico usam PCOUNT() no guard, nao so VARTYPE: em
298:     * VFP9 parametro declarado e NAO passado chega como .F. LOGICO, de modo
299:     * que VARTYPE(par_lDireta) = "L" e verdade tanto para "nao passou" quanto
300:     * para "passou .F." - com default .F. o resultado coincide, mas o PCOUNT
301:     * deixa a intencao explicita e protege de uma futura troca de default.
302:     *==========================================================================
303:     PROCEDURE Init(par_oFormPai, par_nDataSessionPai, par_lDireta, par_lAutomatico)
304: 
305:         IF VARTYPE(par_oFormPai) = "O"
306:             THIS.this_oFormPai = par_oFormPai
307:         ENDIF
308: 
309:         IF VARTYPE(par_nDataSessionPai) = "N"
310:             THIS.this_nDataSessionPai = par_nDataSessionPai
311:         ENDIF
312: 
313:         IF PCOUNT() >= 3 AND VARTYPE(par_lDireta) = "L"
314:             THIS.this_lDireta = par_lDireta
315:         ENDIF
316: 
317:         IF PCOUNT() >= 4 AND VARTYPE(par_lAutomatico) = "L"
318:             THIS.this_lAutomatico = par_lAutomatico
319:         ENDIF
320: 
321:         *-- DODEFAULT() ja chama InicializarForm() atraves do FormBase.Init()
322:         RETURN DODEFAULT()
323:     ENDPROC
324: 
325:     *==========================================================================
326:     * InicializarForm - Cria o Business Object e monta a casca visual base
327:     *
328:     * Equivale ao trecho inicial do Init legado (captions do cabecalho,
329:     * ParentForm.Enabled = .f. e LockScreen) - a parte de CursorQuery/SQL do
330:     * Init legado pertence as fases de dados (4 em diante).
331:     *
332:     * RETURN unico DEPOIS do ENDTRY, com flag loc_lSucesso: RETURN dentro de
333:     * TRY/CATCH e proibido em VFP9.
334:     *==========================================================================
335:     PROTECTED PROCEDURE InicializarForm()
336:         LOCAL loc_lSucesso, loc_oErro
337:         loc_lSucesso = .F.
338: 
339:         THIS.LockScreen = .T.
340:         TRY
341:             THIS.this_oBusinessObject = CREATEOBJECT("sigopinfBO")
342: 
343:             IF VARTYPE(THIS.this_oBusinessObject) <> "O"
344:                 MsgErro("Erro ao criar sigopinfBO. VARTYPE retornou: " + ;
345:                     VARTYPE(THIS.this_oBusinessObject), "Formsigopinf.InicializarForm")
346:             ELSE
347:                 THIS.SincronizarEscolhaPai()
348:                 THIS.DesabilitarFormPai()
349:                 THIS.CarregarCursoresOperacao()
350:                 THIS.ConfigurarCabecalho()
351:                 THIS.ConfigurarBotoesAcao()
352:                 THIS.ConfigurarCamposDocumentos()
353:                 THIS.ConfigurarCamposDatas()
354:                 THIS.ConfigurarVolumes()
355:                 THIS.ConfigurarObservacao()
356:                 THIS.ConfigurarProtocolo()
357:                 THIS.ConfigurarEntrega()
358:                 THIS.ConfigurarPedido()
359:                 THIS.ConfigurarObs2()
360:                 THIS.ConfigurarLivre()
361:                 THIS.TornarControlesVisiveis(THIS)
362:                 THIS.AtualizarVisibilidadePorOperacao()
363:                 THIS.AjustarPosicaoCampos()
364: 
365:                 loc_lSucesso = .T.
366:             ENDIF
367:         CATCH TO loc_oErro
368:             MsgErro(loc_oErro.Message + CHR(13) + ;
369:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
370:                 "Procedure: " + loc_oErro.Procedure, "Erro em Formsigopinf.InicializarForm")
371:         ENDTRY
372:         THIS.LockScreen = .F.
373: 
374:         RETURN loc_lSucesso
375:     ENDPROC
376: 
377:     *==========================================================================
378:     * SincronizarEscolhaPai - copia this_cModoAtual do form pai, reproduzindo
379:     * ".pcEscolha = ThisForm.ParentForm.pcEscolha" do Init legado. Guardado
380:     * por PEMSTATUS porque o form pai e OPCIONAL (probe headless) e porque
381:     * nesta arquitetura o nome da propriedade de modo e this_cModoAtual
382:     * (FormBase), nao o "pcEscolha" literal do legado.
383:     *==========================================================================
384:     PROTECTED PROCEDURE SincronizarEscolhaPai()
385:         IF VARTYPE(THIS.this_oFormPai) = "O" ;
386:            AND PEMSTATUS(THIS.this_oFormPai, "this_cModoAtual", 5)
387:             THIS.this_cPcEscolha = THIS.this_oFormPai.this_cModoAtual
388:         ENDIF
389:     ENDPROC
390: 
391:     *==========================================================================
392:     * DesabilitarFormPai - "ThisForm.ParentForm.Enabled = .f." do Init legado.
393:     * Este dialogo nao e modal (o dump nao declara WindowType = 1), e o
394:     * legado impede a interacao com o pai desabilitando-o manualmente
395:     * enquanto a tela de informacoes esta aberta. Revertido em
396:     * ReabilitarFormPai(), chamado no Destroy().
397:     *==========================================================================
398:     PROTECTED PROCEDURE DesabilitarFormPai()
399:         IF VARTYPE(THIS.this_oFormPai) = "O"
400:             THIS.this_oFormPai.Enabled = .F.
401:         ENDIF
402:     ENDPROC
403: 
404:     *==========================================================================
405:     * ReabilitarFormPai - reverso de DesabilitarFormPai, chamado no Destroy().
406:     *==========================================================================
407:     PROTECTED PROCEDURE ReabilitarFormPai()
408:         IF VARTYPE(THIS.this_oFormPai) = "O"
409:             THIS.this_oFormPai.Enabled = .T.
410:         ENDIF
411:     ENDPROC
412: 
413:     *==========================================================================
414:     * ConfigurarCabecalho - Faixa cinza do topo (cntSombra do legado) com o
415:     * titulo do form desenhado duas vezes: lblSombra em preto atras e
416:     * lblTitulo em branco por cima, 1px acima, o que produz o relevo -
417:     * exatamente como o Init legado faz nas duas primeiras linhas:
418:     *   ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption
419:     *   ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption
420:     *
421:     * Geometria transcrita do dump (layout.json), com UMA correcao
422:     * deliberada de Width: o SCX declara cntSombra.Width = 1100 e os dois
423:     * labels com Width = 769, enquanto o proprio Form tem Width = 1000 - o
424:     * container do cabecalho foi desenhado no Form Designer mais largo que a
425:     * janela (sobreposicao herdada do SCX, regra #28/#30). Copiar os
426:     * literais deixaria uma faixa clara exposta a direita ou cortaria o
427:     * titulo. Por isso o container acompanha THIS.Width e os labels ficam em
428:     * THIS.Width - 20, que com Left = 10 fecha exatamente na borda.
429:     * Top/Height/Font/ForeColor/Alignment/BackStyle seguem o dump.
430:     *
431:     * AutoSize = .F. explicito: o dump declara WordWrap = .T. nos dois
432:     * labels, e AutoSize em Label criado por AddObject e no-op para a
433:     * largura e, com WordWrap, chega a DESCARTAR a Height - a legenda
434:     * colapsaria para uma linha (regra #23). Width e Height vem do dump, que
435:     * ja sao o auto-size calculado pelo Form Designer.
436:     *==========================================================================
437:     PROTECTED PROCEDURE ConfigurarCabecalho()
438:         LOCAL loc_oCnt
439: 
440:         THIS.AddObject("cnt_4c_Sombra", "Container")
441:         loc_oCnt = THIS.cnt_4c_Sombra
442:         WITH loc_oCnt
443:             .Top         = 0
444:             .Left        = 0
445:             .Width       = THIS.Width
446:             .Height      = 80
447:             .BorderWidth = 0
448:             .BackColor   = RGB(100, 100, 100)
449:             .Visible     = .T.
450:         ENDWITH
451: 
452:         loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
453:         WITH loc_oCnt.lbl_4c_LblSombra
454:             .FontBold  = .T.
455:             .FontName  = "Tahoma"
456:             .FontSize  = 18
457:             .WordWrap  = .T.
458:             .Alignment = 0
459:             .BackStyle = 0
460:             .AutoSize  = .F.
461:             .Caption   = THIS.Caption
462:             .Left      = 10
463:             .Top       = 18
464:             .Width     = THIS.Width - 20
465:             .Height    = 40
466:             .ForeColor = RGB(0, 0, 0)
467:             .Visible   = .T.
468:         ENDWITH
469: 
470:         loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
471:         WITH loc_oCnt.lbl_4c_LblTitulo
472:             .FontBold  = .T.
473:             .FontName  = "Tahoma"
474:             .FontSize  = 18
475:             .WordWrap  = .T.
476:             .Alignment = 0
477:             .BackStyle = 0

*-- Linhas 506 a 680:
506:     * (FormSigPrCtc/FormSigOpEnt) e tem Click com logica COMPLETA nesta
507:     * fase - nao dependem de nenhum container criado em fase posterior.
508:     *==========================================================================
509:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
510:         LOCAL loc_oGrp
511: 
512:         *-- obj_4c_CntBotoes: botao "Salvar" (Click -> BtnSalvarClick, Fase 8)
513:         THIS.AddObject("obj_4c_CntBotoes", "CommandGroup")
514:         loc_oGrp = THIS.obj_4c_CntBotoes
515:         WITH loc_oGrp
516:             .Top           = -2
517:             .Left          = 920
518:             .Width         = 85
519:             .Height        = 85
520:             .ButtonCount   = 1
521:             .BackStyle     = 0
522:             .BorderStyle   = 0
523:             .SpecialEffect = 1
524:             .Visible       = .T.
525:         ENDWITH
526:         WITH loc_oGrp.Buttons(1)
527:             .Top             = 5
528:             .Left            = 5
529:             .Width           = 75
530:             .Height          = 75
531:             .FontBold        = .T.
532:             .FontItalic      = .T.
533:             .FontName        = "Tahoma"
534:             .FontSize        = 8
535:             .WordWrap        = .T.
536:             .PicturePosition = 13
537:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
538:             .Caption         = "\<Salvar"
539:             .MousePointer    = 15
540:             .ToolTipText     = "Gravar os Dados Informados"
541:             .SpecialEffect   = 0
542:             .ForeColor       = RGB(90, 90, 90)
543:             .BackColor       = RGB(255, 255, 255)
544:             .Themes          = .F.
545:         ENDWITH
546:         BINDEVENT(loc_oGrp, "Click", THIS, "BtnSalvarClick")
547: 
548:         *-- obj_4c_CmdCotacao: abre FormSigPrCtc (cmdCotacao.Valid legado)
549:         THIS.AddObject("obj_4c_CmdCotacao", "CommandGroup")
550:         loc_oGrp = THIS.obj_4c_CmdCotacao
551:         WITH loc_oGrp
552:             .Top           = -2
553:             .Left          = 845
554:             .Width         = 85
555:             .Height        = 85
556:             .ButtonCount   = 1
557:             .BackStyle     = 0
558:             .BorderStyle   = 0
559:             .SpecialEffect = 1
560:             .Visible       = .T.
561:         ENDWITH
562:         WITH loc_oGrp.Buttons(1)
563:             .Top             = 5
564:             .Left            = 5
565:             .Width           = 75
566:             .Height          = 75
567:             .FontBold        = .T.
568:             .FontItalic      = .T.
569:             .FontName        = "Tahoma"
570:             .FontSize        = 8
571:             .WordWrap        = .T.
572:             .PicturePosition = 13
573:             .Picture         = gc_4c_CaminhoIcones + "geral_cambio_60.jpg"
574:             .Caption         = "\<Cota" + CHR(231) + CHR(227) + "o"
575:             .MousePointer    = 15
576:             .ToolTipText     = "Alterar Cota" + CHR(231) + CHR(227) + "o Informativa"
577:             .SpecialEffect   = 0
578:             .ForeColor       = RGB(90, 90, 90)
579:             .BackColor       = RGB(255, 255, 255)
580:             .Themes          = .F.
581:         ENDWITH
582:         BINDEVENT(loc_oGrp, "Click", THIS, "CmdCotacaoClick")
583: 
584:         *-- obj_4c_CmdEntrega: abre FormSigOpEnt (cmdEntrega.Valid legado)
585:         THIS.AddObject("obj_4c_CmdEntrega", "CommandGroup")
586:         loc_oGrp = THIS.obj_4c_CmdEntrega
587:         WITH loc_oGrp
588:             .Top           = -2
589:             .Left          = 770
590:             .Width         = 85
591:             .Height        = 85
592:             .ButtonCount   = 1
593:             .BackStyle     = 0
594:             .BorderStyle   = 0
595:             .SpecialEffect = 1
596:             .Visible       = .T.
597:         ENDWITH
598:         WITH loc_oGrp.Buttons(1)
599:             .Top             = 5
600:             .Left            = 5
601:             .Width           = 75
602:             .Height          = 75
603:             .FontBold        = .T.
604:             .FontItalic      = .T.
605:             .FontName        = "Comic Sans MS"
606:             .FontSize        = 8
607:             .WordWrap        = .T.
608:             .PicturePosition = 13
609:             .Picture         = gc_4c_CaminhoIcones + "geral_relogio_60.jpg"
610:             .Caption         = "\<Entrega"
611:             .MousePointer    = 15
612:             .ToolTipText     = "Alterar Prazo de Entrega <F3>"
613:             .SpecialEffect   = 0
614:             .ForeColor       = RGB(90, 90, 90)
615:             .BackColor       = RGB(255, 255, 255)
616:             .Themes          = .F.
617:         ENDWITH
618:         BINDEVENT(loc_oGrp, "Click", THIS, "CmdEntregaClick")
619: 
620:         THIS.AtualizarVisibilidadeCmdEntrega()
621:     ENDPROC
622: 
623:     *==========================================================================
624:     * ConfigurarCamposDocumentos - cntCodigos/cntDocumentos/cntEcfs/cntNemps
625:     * (layout.json/mapeamento.json: cnt_4c_Codigos/cnt_4c_Documentos/
626:     * cnt_4c_Ecfs/cnt_4c_Nemps). Geometria e propriedades transcritas do
627:     * dump (SECAO 2 de sigopinf_form_codigo_fonte.txt) - containers com
628:     * BackStyle = 0 (transparentes, mostram o BackColor cinza do Form) e
629:     * labels classe "say" com ForeColor = RGB(90,90,90) EXPLICITO no dump
630:     * (nao e o default inferido da regra #12 - aqui o legado DECLARA esse
631:     * valor, entao e so transcricao).
632:     *
633:     * Todos os TextBox tem ControlSource = "TprMvCab.<col>" - igual ao
634:     * legado, estes controles escrevem direto no cursor de trabalho do
635:     * form pai. Sem TprMvCab aberto (harness/probe headless), a atribuicao
636:     * de ControlSource e pulada (regra: Alias inexistente estoura ao
637:     * atribuir ControlSource, nao so ao exibir) e os campos ficam sem
638:     * binding, inofensivo fora do fluxo real.
639:     *==========================================================================
640:     PROTECTED PROCEDURE ConfigurarCamposDocumentos()
641:         LOCAL loc_oCnt, loc_lTemCursorPai
642:         loc_lTemCursorPai = USED("TprMvCab")
643: 
644:         *-- cnt_4c_Codigos (legado: cntCodigos) -----------------------------
645:         THIS.AddObject("cnt_4c_Codigos", "Container")
646:         loc_oCnt = THIS.cnt_4c_Codigos
647:         WITH loc_oCnt
648:             .Top         = 96
649:             .Left        = 2
650:             .Width       = 67
651:             .Height      = 45
652:             .BackStyle   = 0
653:             .BorderWidth = 0
654:             .Visible     = .T.
655:         ENDWITH
656: 
657:         loc_oCnt.AddObject("lbl_4c_LblCodigos", "Label")
658:         WITH loc_oCnt.lbl_4c_LblCodigos
659:             .FontBold  = .F.
660:             .FontName  = "Tahoma"
661:             .FontSize  = 8
662:             .BackStyle = 0
663:             .Alignment = 0
664:             .AutoSize  = .F.
665:             .Caption   = "C" + CHR(243) + "digo "
666:             .Left      = 3
667:             .Top       = 3
668:             .Width     = 61
669:             .ForeColor = RGB(90, 90, 90)
670:             .Visible   = .T.
671:         ENDWITH
672: 
673:         loc_oCnt.AddObject("txt_4c_Codigos", "TextBox")
674:         WITH loc_oCnt.txt_4c_Codigos
675:             .FontBold      = .T.
676:             .FontSize      = 8
677:             .Left          = 3
678:             .Top           = 20
679:             .Width         = 61
680:             .MaxLength     = 10

*-- Linhas 686 a 809:
686:         IF loc_lTemCursorPai
687:             loc_oCnt.txt_4c_Codigos.ControlSource = "TprMvCab.mascnum"
688:         ENDIF
689:         BINDEVENT(loc_oCnt.txt_4c_Codigos, "When", THIS, "CodigosWhen")
690: 
691:         *-- cnt_4c_Documentos (legado: cntDocumentos) -----------------------
692:         THIS.AddObject("cnt_4c_Documentos", "Container")
693:         loc_oCnt = THIS.cnt_4c_Documentos
694:         WITH loc_oCnt
695:             .Top         = 96
696:             .Left        = 69
697:             .Width       = 170
698:             .Height      = 45
699:             .BackStyle   = 0
700:             .BorderWidth = 0
701:             .Visible     = .T.
702:         ENDWITH
703: 
704:         loc_oCnt.AddObject("lbl_4c_LblDocumentos", "Label")
705:         WITH loc_oCnt.lbl_4c_LblDocumentos
706:             .FontBold  = .F.
707:             .FontName  = "Tahoma"
708:             .FontSize  = 8
709:             .BackStyle = 0
710:             .Alignment = 0
711:             .AutoSize  = .F.
712:             .Caption   = "Documento"
713:             .Left      = 3
714:             .Top       = 3
715:             .Width     = 56
716:             .ForeColor = RGB(90, 90, 90)
717:             .Visible   = .T.
718:         ENDWITH
719: 
720:         loc_oCnt.AddObject("txt_4c_Documentos", "TextBox")
721:         WITH loc_oCnt.txt_4c_Documentos
722:             .Left          = 3
723:             .Top           = 20
724:             .Width         = 67
725:             .Margin        = 0
726:             .MaxLength     = 6
727:             .SpecialEffect = 1
728:             .ForeColor     = RGB(0, 0, 0)
729:             .BorderColor   = RGB(100, 100, 100)
730:             .Visible       = .T.
731:         ENDWITH
732:         IF loc_lTemCursorPai
733:             loc_oCnt.txt_4c_Documentos.ControlSource = "TprMvCab.notas"
734:         ENDIF
735:         BINDEVENT(loc_oCnt.txt_4c_Documentos, "When", THIS, "DocumentosWhen")
736: 
737:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
738:         WITH loc_oCnt.lbl_4c_Label1
739:             .FontBold  = .F.
740:             .FontName  = "Tahoma"
741:             .FontSize  = 8
742:             .BackStyle = 0
743:             .Alignment = 0
744:             .AutoSize  = .F.
745:             .Caption   = "Nota"
746:             .Left      = 73
747:             .Top       = 3
748:             .Width     = 25
749:             .ForeColor = RGB(90, 90, 90)
750:             .Visible   = .T.
751:         ENDWITH
752: 
753:         loc_oCnt.AddObject("txt_4c_NumeroNota", "TextBox")
754:         WITH loc_oCnt.txt_4c_NumeroNota
755:             .Left          = 73
756:             .Top           = 20
757:             .Width         = 94
758:             .Height        = 23
759:             .Margin        = 0
760:             .MaxLength     = 10
761:             .SpecialEffect = 1
762:             .ForeColor     = RGB(0, 0, 0)
763:             .BorderColor   = RGB(100, 100, 100)
764:             .Visible       = .T.
765:         ENDWITH
766:         IF loc_lTemCursorPai
767:             loc_oCnt.txt_4c_NumeroNota.ControlSource = "TprMvCab.NumeroNota"
768:         ENDIF
769:         BINDEVENT(loc_oCnt.txt_4c_NumeroNota, "When", THIS, "DocumentosWhen")
770: 
771:         *-- cnt_4c_Ecfs (legado: cntEcfs) ------------------------------------
772:         THIS.AddObject("cnt_4c_Ecfs", "Container")
773:         loc_oCnt = THIS.cnt_4c_Ecfs
774:         WITH loc_oCnt
775:             .Top         = 96
776:             .Left        = 240
777:             .Width       = 65
778:             .Height      = 45
779:             .BackStyle   = 0
780:             .BorderWidth = 0
781:             .Visible     = .T.
782:         ENDWITH
783: 
784:         loc_oCnt.AddObject("lbl_4c_LblEcfs", "Label")
785:         WITH loc_oCnt.lbl_4c_LblEcfs
786:             .FontBold  = .F.
787:             .FontName  = "Tahoma"
788:             .FontSize  = 8
789:             .BackStyle = 0
790:             .Alignment = 0
791:             .AutoSize  = .F.
792:             .Caption   = "ECF  "
793:             .Left      = 3
794:             .Top       = 3
795:             .Width     = 27
796:             .Height    = 15
797:             .ForeColor = RGB(90, 90, 90)
798:             .Visible   = .T.
799:         ENDWITH
800: 
801:         loc_oCnt.AddObject("txt_4c_Ecfs", "TextBox")
802:         WITH loc_oCnt.txt_4c_Ecfs
803:             .Left          = 3
804:             .Top           = 20
805:             .Width         = 59
806:             .Height        = 23
807:             .Margin        = 0
808:             .InputMask     = "9999999"
809:             .MaxLength     = 7

*-- Linhas 815 a 1279:
815:         IF loc_lTemCursorPai
816:             loc_oCnt.txt_4c_Ecfs.ControlSource = "TprMvCab.ecfs"
817:         ENDIF
818:         BINDEVENT(loc_oCnt.txt_4c_Ecfs, "When", THIS, "PadraoIncluirAlterarWhen")
819: 
820:         *-- cnt_4c_Nemps (legado: cntNemps) ----------------------------------
821:         THIS.AddObject("cnt_4c_Nemps", "Container")
822:         loc_oCnt = THIS.cnt_4c_Nemps
823:         WITH loc_oCnt
824:             .Top         = 96
825:             .Left        = 305
826:             .Width       = 156
827:             .Height      = 45
828:             .BackStyle   = 0
829:             .BorderWidth = 0
830:             .Visible     = .T.
831:         ENDWITH
832: 
833:         loc_oCnt.AddObject("lbl_4c_LblNemps", "Label")
834:         WITH loc_oCnt.lbl_4c_LblNemps
835:             .FontBold  = .F.
836:             .FontName  = "Tahoma"
837:             .FontSize  = 8
838:             .BackStyle = 0
839:             .Alignment = 0
840:             .AutoSize  = .F.
841:             .Caption   = "N" + CHR(186) + " S" + CHR(233) + "rie Imp."
842:             .Left      = 3
843:             .Top       = 3
844:             .Width     = 66
845:             .Height    = 15
846:             .ForeColor = RGB(90, 90, 90)
847:             .Visible   = .T.
848:         ENDWITH
849: 
850:         loc_oCnt.AddObject("txt_4c_Nemps", "TextBox")
851:         WITH loc_oCnt.txt_4c_Nemps
852:             .Left          = 3
853:             .Top           = 20
854:             .Width         = 150
855:             .Height        = 23
856:             .Margin        = 0
857:             .MaxLength     = 20
858:             .SpecialEffect = 1
859:             .ForeColor     = RGB(0, 0, 0)
860:             .BorderColor   = RGB(100, 100, 100)
861:             .Visible       = .T.
862:         ENDWITH
863:         IF loc_lTemCursorPai
864:             loc_oCnt.txt_4c_Nemps.ControlSource = "TprMvCab.nemps"
865:         ENDIF
866:         BINDEVENT(loc_oCnt.txt_4c_Nemps, "When",      THIS, "PadraoIncluirAlterarWhen")
867:         BINDEVENT(loc_oCnt.txt_4c_Nemps, "LostFocus",  THIS, "NempsLostFocus")
868:     ENDPROC
869: 
870:     *==========================================================================
871:     * CodigosWhen - "Return .f." do legado (getCodigos.When): o campo
872:     * Codigo/MascNum e so exibicao, nunca editavel em nenhum modo.
873:     *
874:     * PUBLIC: alvo de BINDEVENT("When").
875:     *==========================================================================
876:     FUNCTION CodigosWhen()
877:         RETURN .F.
878:     ENDFUNC
879: 
880:     *==========================================================================
881:     * DocumentosWhen - "Return ( Inlist( ThisForm.pcEscolha, 'INSERIR',
882:     * 'ALTERAR' ) And Not InList(crSigCdOpe.NFiscals,1,2) And Not
883:     * InList(CrSigCdOpe.DigDoc,4,5) )" do legado - compartilhado por
884:     * getDocumentos.When e GetNumeroNota.When (texto identico no dump).
885:     * crSigCdOpe e o cursor que o CursorQuery do Init legado popula (ainda
886:     * nao portado - fases seguintes); sem ele, falso seguro (campo fica
887:     * nao-editavel).
888:     *
889:     * PUBLIC: alvo de BINDEVENT("When").
890:     *==========================================================================
891:     FUNCTION DocumentosWhen()
892:         LOCAL loc_lPermite
893:         loc_lPermite = .F.
894: 
895:         IF INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR") AND USED("crSigCdOpe")
896:             loc_lPermite = !INLIST(crSigCdOpe.NFiscals, 1, 2) ;
897:                 AND !INLIST(crSigCdOpe.DigDoc, 4, 5)
898:         ENDIF
899: 
900:         RETURN loc_lPermite
901:     ENDFUNC
902: 
903:     *==========================================================================
904:     * PadraoIncluirAlterarWhen - "Return Inlist(ThisForm.pcEscolha,
905:     * 'INSERIR', 'ALTERAR')" do legado - texto IDENTICO em getEcfs.When,
906:     * getNemps.When, getEmiss.When, getRecepcaos.When e getPrzEnts.When
907:     * (compartilhado pelos cinco).
908:     *
909:     * PUBLIC: alvo de BINDEVENT("When").
910:     *==========================================================================
911:     FUNCTION PadraoIncluirAlterarWhen()
912:         RETURN INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
913:     ENDFUNC
914: 
915:     *==========================================================================
916:     * NempsLostFocus - "If Not Empty(This.Value) / lnNoFabr = This.Value /
917:     * lcImpf = fDecriptografar(alltrim(lnNoFabr)) / lcWhere = [Select *
918:     * From SIGFIMPF Where cimpfabs = ?lcImpf ] / ... MessageBox / Return
919:     * .f." do legado (getNemps.Valid). fDecriptografar e o wrapper de
920:     * utils/fdecriptografar.prg (regra #27 - algoritmo original fora do
921:     * acervo, pass-through seguro). Equivalente ao "ao sair do campo" do
922:     * Valid legado - ver regra #47 (lookup/validacao de TextBox solto vai
923:     * em LostFocus, nao em KeyPress).
924:     *
925:     * PUBLIC: alvo de BINDEVENT("LostFocus").
926:     *==========================================================================
927:     PROCEDURE NempsLostFocus()
928:         LOCAL loc_oTxt, loc_cImpf, loc_cSQL, loc_nErro, loc_oErro
929: 
930:         loc_oTxt = THIS.cnt_4c_Nemps.txt_4c_Nemps
931: 
932:         IF !EMPTY(loc_oTxt.Value)
933:             TRY
934:                 loc_cImpf = fDecriptografar(ALLTRIM(loc_oTxt.Value))
935:                 loc_cSQL  = "SELECT * FROM SIGFIMPF WHERE cimpfabs = " + EscaparSQL(loc_cImpf)
936:                 loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigFiMpF")
937: 
938:                 IF loc_nErro < 1
939:                     MsgErro("Favor reinicializar o processo." + CHR(13) + ;
940:                         "Falha na Conex" + CHR(227) + "o (SIGFIMPF)", "Erro")
941:                 ELSE
942:                     IF RECCOUNT("cursor_4c_SigFiMpF") = 0
943:                         MsgAviso("Impressora Fiscal n" + CHR(227) + "o Cadastrada!!", ;
944:                             "Aten" + CHR(231) + CHR(227) + "o")
945:                     ENDIF
946:                     IF USED("cursor_4c_SigFiMpF")
947:                         USE IN cursor_4c_SigFiMpF
948:                     ENDIF
949:                 ENDIF
950:             CATCH TO loc_oErro
951:                 MsgErro(loc_oErro.Message + CHR(13) + ;
952:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
953:                     "Erro ao validar N" + CHR(186) + " S" + CHR(233) + "rie")
954:             ENDTRY
955:         ENDIF
956:     ENDPROC
957: 
958:     *==========================================================================
959:     * ConfigurarCamposDatas - cntEmiss/cntEntregas/cntRecepcaos/cntPrzEnts
960:     * (cnt_4c_Emiss/cnt_4c_Entregas/cnt_4c_Recepcaos/cnt_4c_PrzEnts).
961:     * Classe "fweditdata" no legado -> TextBox com NullDisplay = "//" (data
962:     * vazia exibe barras, nao branco - propriedade nativa do TextBox,
963:     * confirmada em automation/propriedades_baseclasses.txt).
964:     *==========================================================================
965:     PROTECTED PROCEDURE ConfigurarCamposDatas()
966:         LOCAL loc_oCnt, loc_lTemCursorPai
967:         loc_lTemCursorPai = USED("TprMvCab")
968: 
969:         *-- cnt_4c_Emiss (legado: cntEmiss) ----------------------------------
970:         THIS.AddObject("cnt_4c_Emiss", "Container")
971:         loc_oCnt = THIS.cnt_4c_Emiss
972:         WITH loc_oCnt
973:             .Top         = 147
974:             .Left        = 2
975:             .Width       = 86
976:             .Height      = 45
977:             .BackStyle   = 0
978:             .BorderWidth = 0
979:             .Visible     = .T.
980:         ENDWITH
981: 
982:         loc_oCnt.AddObject("lbl_4c_LblEmiss", "Label")
983:         WITH loc_oCnt.lbl_4c_LblEmiss
984:             .FontBold  = .F.
985:             .FontName  = "Tahoma"
986:             .FontSize  = 8
987:             .BackStyle = 0
988:             .Alignment = 0
989:             .AutoSize  = .F.
990:             .Caption   = "Data Emiss" + CHR(227) + "o "
991:             .Left      = 3
992:             .Top       = 3
993:             .Width     = 80
994:             .ForeColor = RGB(90, 90, 90)
995:             .Visible   = .T.
996:         ENDWITH
997: 
998:         loc_oCnt.AddObject("txt_4c_Emiss", "TextBox")
999:         WITH loc_oCnt.txt_4c_Emiss
1000:             .Left          = 3
1001:             .Top           = 20
1002:             .Width         = 80
1003:             .Margin        = 0
1004:             .SpecialEffect = 1
1005:             .ForeColor     = RGB(0, 0, 0)
1006:             .BorderColor   = RGB(100, 100, 100)
1007:             .NullDisplay   = "//"
1008:             .Visible       = .T.
1009:         ENDWITH
1010:         IF loc_lTemCursorPai
1011:             loc_oCnt.txt_4c_Emiss.ControlSource = "TprMvCab.dtemis"
1012:         ENDIF
1013:         BINDEVENT(loc_oCnt.txt_4c_Emiss, "When",      THIS, "PadraoIncluirAlterarWhen")
1014:         BINDEVENT(loc_oCnt.txt_4c_Emiss, "LostFocus",  THIS, "EmissLostFocus")
1015: 
1016:         *-- cnt_4c_Entregas (legado: cntEntregas) ----------------------------
1017:         THIS.AddObject("cnt_4c_Entregas", "Container")
1018:         loc_oCnt = THIS.cnt_4c_Entregas
1019:         WITH loc_oCnt
1020:             .Top         = 147
1021:             .Left        = 88
1022:             .Width       = 86
1023:             .Height      = 45
1024:             .BackStyle   = 0
1025:             .BorderWidth = 0
1026:             .Visible     = .T.
1027:         ENDWITH
1028: 
1029:         loc_oCnt.AddObject("lbl_4c_LblEntregas", "Label")
1030:         WITH loc_oCnt.lbl_4c_LblEntregas
1031:             .FontBold  = .F.
1032:             .FontName  = "Tahoma"
1033:             .FontSize  = 8
1034:             .BackStyle = 0
1035:             .Alignment = 0
1036:             .AutoSize  = .F.
1037:             .Caption   = "Prz. Entrega "
1038:             .Left      = 3
1039:             .Top       = 3
1040:             .Width     = 80
1041:             .ForeColor = RGB(90, 90, 90)
1042:             .Visible   = .T.
1043:         ENDWITH
1044: 
1045:         loc_oCnt.AddObject("txt_4c_Entregas", "TextBox")
1046:         WITH loc_oCnt.txt_4c_Entregas
1047:             .Left          = 3
1048:             .Top           = 20
1049:             .Width         = 80
1050:             .Margin        = 0
1051:             .SpecialEffect = 1
1052:             .ForeColor     = RGB(0, 0, 0)
1053:             .BorderColor   = RGB(100, 100, 100)
1054:             .NullDisplay   = "//"
1055:             .Visible       = .T.
1056:         ENDWITH
1057:         IF loc_lTemCursorPai
1058:             loc_oCnt.txt_4c_Entregas.ControlSource = "TprMvCab.prazoents"
1059:         ENDIF
1060:         BINDEVENT(loc_oCnt.txt_4c_Entregas, "When",     THIS, "EntregasWhen")
1061:         BINDEVENT(loc_oCnt.txt_4c_Entregas, "LostFocus", THIS, "EntregasLostFocus")
1062: 
1063:         *-- cnt_4c_Recepcaos (legado: cntRecepcaos) --------------------------
1064:         THIS.AddObject("cnt_4c_Recepcaos", "Container")
1065:         loc_oCnt = THIS.cnt_4c_Recepcaos
1066:         WITH loc_oCnt
1067:             .Top         = 147
1068:             .Left        = 174
1069:             .Width       = 86
1070:             .Height      = 45
1071:             .BackStyle   = 0
1072:             .BorderWidth = 0
1073:             .Visible     = .T.
1074:         ENDWITH
1075: 
1076:         loc_oCnt.AddObject("lbl_4c_LblRecepcaos", "Label")
1077:         WITH loc_oCnt.lbl_4c_LblRecepcaos
1078:             .FontBold  = .F.
1079:             .FontName  = "Tahoma"
1080:             .FontSize  = 8
1081:             .BackStyle = 0
1082:             .Alignment = 0
1083:             .AutoSize  = .F.
1084:             .Caption   = "Recep" + CHR(231) + CHR(227) + "o "
1085:             .Left      = 3
1086:             .Top       = 3
1087:             .Width     = 80
1088:             .ForeColor = RGB(90, 90, 90)
1089:             .Visible   = .T.
1090:         ENDWITH
1091: 
1092:         loc_oCnt.AddObject("txt_4c_Recepcaos", "TextBox")
1093:         WITH loc_oCnt.txt_4c_Recepcaos
1094:             .Left          = 3
1095:             .Top           = 20
1096:             .Width         = 80
1097:             .Margin        = 0
1098:             .SpecialEffect = 1
1099:             .ForeColor     = RGB(0, 0, 0)
1100:             .BorderColor   = RGB(100, 100, 100)
1101:             .NullDisplay   = "//"
1102:             .Visible       = .T.
1103:         ENDWITH
1104:         IF loc_lTemCursorPai
1105:             loc_oCnt.txt_4c_Recepcaos.ControlSource = "TprMvCab.dtrecs"
1106:         ENDIF
1107:         BINDEVENT(loc_oCnt.txt_4c_Recepcaos, "When",     THIS, "PadraoIncluirAlterarWhen")
1108:         BINDEVENT(loc_oCnt.txt_4c_Recepcaos, "LostFocus", THIS, "RecepcaosLostFocus")
1109: 
1110:         *-- cnt_4c_PrzEnts (legado: cntPrzEnts) ------------------------------
1111:         THIS.AddObject("cnt_4c_PrzEnts", "Container")
1112:         loc_oCnt = THIS.cnt_4c_PrzEnts
1113:         WITH loc_oCnt
1114:             .Top         = 147
1115:             .Left        = 260
1116:             .Width       = 86
1117:             .Height      = 45
1118:             .BackStyle   = 0
1119:             .BorderWidth = 0
1120:             .Visible     = .T.
1121:         ENDWITH
1122: 
1123:         loc_oCnt.AddObject("lbl_4c_LblPrzEnts", "Label")
1124:         WITH loc_oCnt.lbl_4c_LblPrzEnts
1125:             .FontBold  = .F.
1126:             .FontName  = "Tahoma"
1127:             .FontSize  = 8
1128:             .BackStyle = 0
1129:             .Alignment = 0
1130:             .AutoSize  = .F.
1131:             .Caption   = "Dt. Prometida"
1132:             .Left      = 3
1133:             .Top       = 3
1134:             .Width     = 80
1135:             .ForeColor = RGB(90, 90, 90)
1136:             .Visible   = .T.
1137:         ENDWITH
1138: 
1139:         loc_oCnt.AddObject("txt_4c_PrzEnts", "TextBox")
1140:         WITH loc_oCnt.txt_4c_PrzEnts
1141:             .Left          = 3
1142:             .Top           = 20
1143:             .Width         = 80
1144:             .Margin        = 0
1145:             .SpecialEffect = 1
1146:             .ForeColor     = RGB(0, 0, 0)
1147:             .BorderColor   = RGB(100, 100, 100)
1148:             .NullDisplay   = "//"
1149:             .Visible       = .T.
1150:         ENDWITH
1151:         IF loc_lTemCursorPai
1152:             loc_oCnt.txt_4c_PrzEnts.ControlSource = "TprMvCab.PRZCLIS"
1153:         ENDIF
1154:         BINDEVENT(loc_oCnt.txt_4c_PrzEnts, "When",     THIS, "PadraoIncluirAlterarWhen")
1155:         BINDEVENT(loc_oCnt.txt_4c_PrzEnts, "LostFocus", THIS, "PrzEntsLostFocus")
1156:     ENDPROC
1157: 
1158:     *==========================================================================
1159:     * EntregasWhen - "Return Inlist(ThisForm.pcEscolha, 'INSERIR')" do
1160:     * legado (getEntregas.When) - UNICO dos 4 campos de data desta fase que
1161:     * so libera em INSERIR (os outros liberam INSERIR E ALTERAR). Depois do
1162:     * registro incluido, Prz. Entrega so muda pelo cmdEntrega (Fase 4,
1163:     * CmdEntregaClick), que grava TprMvCab.PrazoEnts e espelha no campo.
1164:     *
1165:     * PUBLIC: alvo de BINDEVENT("When").
1166:     *==========================================================================
1167:     FUNCTION EntregasWhen()
1168:         RETURN INLIST(THIS.this_cPcEscolha, "INSERIR")
1169:     ENDFUNC
1170: 
1171:     *==========================================================================
1172:     * ValidarDataMinima - "If Not IsEmpty(This.Value) And This.Value <
1173:     * Ctod('01/01/1900') / MessageBox('Data incorreta. Informe uma data
1174:     * Valida!!!!',0+16,'') / Return .f. / Endif" do legado - texto IDENTICO
1175:     * em getEmiss.Valid, getEntregas.Valid, getRecepcaos.Valid e
1176:     * getPrzEnts.Valid (compartilhado pelos quatro). MESSAGEBOX legado ->
1177:     * MsgAviso (validacao de UI, nao erro tecnico - regra do projeto).
1178:     *
1179:     * PROTECTED: chamado pelos handlers de LostFocus abaixo, nunca alvo
1180:     * direto de BINDEVENT.
1181:     *==========================================================================
1182:     PROTECTED FUNCTION ValidarDataMinima(par_oTxt)
1183:         LOCAL loc_lValido
1184:         loc_lValido = .T.
1185: 
1186:         IF !EMPTY(par_oTxt.Value) AND par_oTxt.Value < CTOD("01/01/1900")
1187:             MsgAviso("Data incorreta. Informe uma data v" + CHR(225) + "lida!!!!", ;
1188:                 "Aten" + CHR(231) + CHR(227) + "o")
1189:             loc_lValido = .F.
1190:         ENDIF
1191: 
1192:         RETURN loc_lValido
1193:     ENDFUNC
1194: 
1195:     *==========================================================================
1196:     * EmissLostFocus/EntregasLostFocus/RecepcaosLostFocus/PrzEntsLostFocus -
1197:     * equivalentes ao Valid legado (ao sair do campo - regra #47), cada um
1198:     * delegando a ValidarDataMinima() com o TextBox correspondente.
1199:     *
1200:     * PUBLIC: alvo de BINDEVENT("LostFocus").
1201:     *==========================================================================
1202:     PROCEDURE EmissLostFocus()
1203:         THIS.ValidarDataMinima(THIS.cnt_4c_Emiss.txt_4c_Emiss)
1204:     ENDPROC
1205: 
1206:     PROCEDURE EntregasLostFocus()
1207:         THIS.ValidarDataMinima(THIS.cnt_4c_Entregas.txt_4c_Entregas)
1208:     ENDPROC
1209: 
1210:     PROCEDURE RecepcaosLostFocus()
1211:         THIS.ValidarDataMinima(THIS.cnt_4c_Recepcaos.txt_4c_Recepcaos)
1212:     ENDPROC
1213: 
1214:     PROCEDURE PrzEntsLostFocus()
1215:         THIS.ValidarDataMinima(THIS.cnt_4c_PrzEnts.txt_4c_PrzEnts)
1216:     ENDPROC
1217: 
1218:     *==========================================================================
1219:     * AvisarLegadoNaoPortado - mesmo padrao de FormSigOpChi/Formsigopfis: a
1220:     * acao depende de um "Do Form"/funcao do legado que nao veio no acervo
1221:     * desta migracao. Usado so DEPOIS de tentar de verdade (CREATEOBJECT no
1222:     * CATCH, ou guarda explicita) - nunca no lugar da tentativa.
1223:     *==========================================================================
1224:     PROTECTED PROCEDURE AvisarLegadoNaoPortado(par_cDependencia, par_cAcao)
1225:         MsgAviso("Esta a" + CHR(231) + CHR(227) + "o depende de " + ;
1226:             ALLTRIM(par_cDependencia) + ", que n" + CHR(227) + "o veio no " + ;
1227:             "acervo migrado." + CHR(13) + CHR(13) + ;
1228:             "N" + CHR(227) + "o realizado: " + ALLTRIM(par_cAcao) + ".", ;
1229:             "Recurso Indispon" + CHR(237) + "vel")
1230:     ENDPROC
1231: 
1232:     *==========================================================================
1233:     * ConfigurarVolumes - cntVolumes (cnt_4c_Volumes): "Transporte" - 5
1234:     * campos de peso/volume do movimento. Geometria do dump (layout.json/
1235:     * sigopinf_form_codigo_fonte.txt SECAO 2). Todos com Alignment = 3
1236:     * (automatico - numerico alinha a direita) e ControlSource direto em
1237:     * TprMvCab, como no legado.
1238:     *==========================================================================
1239:     PROTECTED PROCEDURE ConfigurarVolumes()
1240:         LOCAL loc_oCnt, loc_lTemCursorPai
1241:         loc_lTemCursorPai = USED("TprMvCab")
1242: 
1243:         THIS.AddObject("cnt_4c_Volumes", "Container")
1244:         loc_oCnt = THIS.cnt_4c_Volumes
1245:         WITH loc_oCnt
1246:             .Top         = 264
1247:             .Left        = 488
1248:             .Width       = 509
1249:             .Height      = 66
1250:             .BackStyle   = 0
1251:             .BorderWidth = 0
1252:             .Visible     = .T.
1253:         ENDWITH
1254: 
1255:         loc_oCnt.AddObject("lbl_4c_Label16", "Label")
1256:         WITH loc_oCnt.lbl_4c_Label16
1257:             .FontBold  = .T.
1258:             .FontName  = "Tahoma"
1259:             .FontSize  = 8
1260:             .BackStyle = 0
1261:             .Alignment = 0
1262:             .AutoSize  = .F.
1263:             .Caption   = "Transporte"
1264:             .Left      = 3
1265:             .Top       = 3
1266:             .Width     = 100
1267:             .ForeColor = RGB(90, 90, 90)
1268:             .Visible   = .T.
1269:         ENDWITH
1270: 
1271:         loc_oCnt.AddObject("lbl_4c_LblQtds", "Label")
1272:         WITH loc_oCnt.lbl_4c_LblQtds
1273:             .FontName  = "Tahoma"
1274:             .FontSize  = 8
1275:             .BackStyle = 0
1276:             .Alignment = 0
1277:             .AutoSize  = .F.
1278:             .Caption   = "Qtde."
1279:             .Left      = 3

*-- Linhas 1302 a 1502:
1302:         IF loc_lTemCursorPai
1303:             loc_oCnt.txt_4c_Qtds.ControlSource = "TprMvCab.Qtdes"
1304:         ENDIF
1305:         BINDEVENT(loc_oCnt.txt_4c_Qtds, "When", THIS, "VolumesWhen")
1306: 
1307:         loc_oCnt.AddObject("lbl_4c_LblEspes", "Label")
1308:         WITH loc_oCnt.lbl_4c_LblEspes
1309:             .FontName  = "Tahoma"
1310:             .FontSize  = 8
1311:             .BackStyle = 0
1312:             .Alignment = 0
1313:             .AutoSize  = .F.
1314:             .Caption   = "Esp" + CHR(233) + "cie"
1315:             .Left      = 57
1316:             .Top       = 23
1317:             .Width     = 85
1318:             .ForeColor = RGB(90, 90, 90)
1319:             .Visible   = .T.
1320:         ENDWITH
1321: 
1322:         loc_oCnt.AddObject("txt_4c_Espes", "TextBox")
1323:         WITH loc_oCnt.txt_4c_Espes
1324:             .Alignment     = 3
1325:             .MaxLength     = 10
1326:             .Left          = 57
1327:             .Top           = 40
1328:             .Width         = 87
1329:             .Height        = 23
1330:             .Margin        = 0
1331:             .SpecialEffect = 1
1332:             .ForeColor     = RGB(0, 0, 0)
1333:             .BorderColor   = RGB(100, 100, 100)
1334:             .Visible       = .T.
1335:         ENDWITH
1336:         IF loc_lTemCursorPai
1337:             loc_oCnt.txt_4c_Espes.ControlSource = "TprMvCab.Espes"
1338:         ENDIF
1339:         BINDEVENT(loc_oCnt.txt_4c_Espes, "When", THIS, "VolumesWhen")
1340: 
1341:         loc_oCnt.AddObject("lbl_4c_LblPLiqs", "Label")
1342:         WITH loc_oCnt.lbl_4c_LblPLiqs
1343:             .FontName  = "Tahoma"
1344:             .FontSize  = 8
1345:             .BackStyle = 0
1346:             .Alignment = 0
1347:             .AutoSize  = .F.
1348:             .Caption   = "Peso L" + CHR(237) + "quido"
1349:             .Left      = 147
1350:             .Top       = 23
1351:             .Width     = 75
1352:             .ForeColor = RGB(90, 90, 90)
1353:             .Visible   = .T.
1354:         ENDWITH
1355: 
1356:         loc_oCnt.AddObject("txt_4c_PLiqs", "TextBox")
1357:         WITH loc_oCnt.txt_4c_PLiqs
1358:             .Alignment     = 3
1359:             .InputMask     = "99,999.99"
1360:             .Left          = 147
1361:             .Top           = 40
1362:             .Width         = 73
1363:             .Height        = 23
1364:             .Margin        = 0
1365:             .SpecialEffect = 1
1366:             .ForeColor     = RGB(0, 0, 0)
1367:             .BorderColor   = RGB(100, 100, 100)
1368:             .Visible       = .T.
1369:         ENDWITH
1370:         IF loc_lTemCursorPai
1371:             loc_oCnt.txt_4c_PLiqs.ControlSource = "TprMvCab.PLiqs"
1372:         ENDIF
1373:         BINDEVENT(loc_oCnt.txt_4c_PLiqs, "When", THIS, "VolumesWhen")
1374: 
1375:         loc_oCnt.AddObject("lbl_4c_LblPBrus", "Label")
1376:         WITH loc_oCnt.lbl_4c_LblPBrus
1377:             .FontName  = "Tahoma"
1378:             .FontSize  = 8
1379:             .BackStyle = 0
1380:             .Alignment = 0
1381:             .AutoSize  = .F.
1382:             .Caption   = "Peso Bruto"
1383:             .Left      = 223
1384:             .Top       = 23
1385:             .Width     = 75
1386:             .ForeColor = RGB(90, 90, 90)
1387:             .Visible   = .T.
1388:         ENDWITH
1389: 
1390:         loc_oCnt.AddObject("txt_4c_PBrus", "TextBox")
1391:         WITH loc_oCnt.txt_4c_PBrus
1392:             .Alignment     = 3
1393:             .InputMask     = "99,999.99"
1394:             .Left          = 223
1395:             .Top           = 40
1396:             .Width         = 73
1397:             .Height        = 23
1398:             .Margin        = 0
1399:             .SpecialEffect = 1
1400:             .ForeColor     = RGB(0, 0, 0)
1401:             .BorderColor   = RGB(100, 100, 100)
1402:             .Visible       = .T.
1403:         ENDWITH
1404:         IF loc_lTemCursorPai
1405:             loc_oCnt.txt_4c_PBrus.ControlSource = "TprMvCab.PBrus"
1406:         ENDIF
1407:         BINDEVENT(loc_oCnt.txt_4c_PBrus, "When", THIS, "VolumesWhen")
1408: 
1409:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
1410:         WITH loc_oCnt.lbl_4c_Label1
1411:             .FontName  = "Tahoma"
1412:             .FontSize  = 8
1413:             .BackStyle = 0
1414:             .Alignment = 0
1415:             .AutoSize  = .F.
1416:             .Caption   = "Valor Transporte"
1417:             .Left      = 299
1418:             .Top       = 23
1419:             .Width     = 100
1420:             .ForeColor = RGB(90, 90, 90)
1421:             .Visible   = .T.
1422:         ENDWITH
1423: 
1424:         loc_oCnt.AddObject("txt_4c_ValTrans", "TextBox")
1425:         WITH loc_oCnt.txt_4c_ValTrans
1426:             .Alignment     = 3
1427:             .InputMask     = "999,999.99"
1428:             .Left          = 299
1429:             .Top           = 40
1430:             .Width         = 90
1431:             .Height        = 23
1432:             .Margin        = 0
1433:             .SpecialEffect = 1
1434:             .ForeColor     = RGB(0, 0, 0)
1435:             .BorderColor   = RGB(100, 100, 100)
1436:             .Visible       = .T.
1437:         ENDWITH
1438:         IF loc_lTemCursorPai
1439:             loc_oCnt.txt_4c_ValTrans.ControlSource = "TprMvCab.ValTrans"
1440:         ENDIF
1441:         BINDEVENT(loc_oCnt.txt_4c_ValTrans, "When", THIS, "VolumesWhen")
1442:     ENDPROC
1443: 
1444:     *==========================================================================
1445:     * VolumesWhen - "Return Inlist(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')"
1446:     * do legado, texto IDENTICO nos 5 campos de cntVolumes (getQtds/getEspes/
1447:     * getPLiqs/getPBrus/getValTrans.When). Mesmo texto de PadraoIncluirAlterarWhen,
1448:     * mas com nome proprio para documentar a origem (grep direto pelo nome do
1449:     * container na auditoria).
1450:     *
1451:     * PUBLIC: alvo de BINDEVENT("When").
1452:     *==========================================================================
1453:     FUNCTION VolumesWhen()
1454:         RETURN INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
1455:     ENDFUNC
1456: 
1457:     *==========================================================================
1458:     * ConfigurarObservacao - cntObservacao (cnt_4c_Observacao): campo de
1459:     * codigo/texto da observacao do movimento + botao de multiplas
1460:     * observacoes. Geometria do dump.
1461:     *==========================================================================
1462:     PROTECTED PROCEDURE ConfigurarObservacao()
1463:         LOCAL loc_oCnt, loc_lTemCursorPai
1464:         loc_lTemCursorPai = USED("TprMvCab")
1465: 
1466:         THIS.AddObject("cnt_4c_Observacao", "Container")
1467:         loc_oCnt = THIS.cnt_4c_Observacao
1468:         WITH loc_oCnt
1469:             .Top         = 228
1470:             .Left        = 12
1471:             .Width       = 528
1472:             .Height      = 303
1473:             .BackStyle   = 0
1474:             .BorderWidth = 0
1475:             .Visible     = .T.
1476:         ENDWITH
1477: 
1478:         loc_oCnt.AddObject("lbl_4c_LblObservas", "Label")
1479:         WITH loc_oCnt.lbl_4c_LblObservas
1480:             .FontBold  = .T.
1481:             .FontName  = "Tahoma"
1482:             .FontSize  = 8
1483:             .BackStyle = 0
1484:             .Alignment = 0
1485:             .AutoSize  = .F.
1486:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
1487:             .Left      = 3
1488:             .Top       = 23
1489:             .Width     = 85
1490:             .ForeColor = RGB(90, 90, 90)
1491:             .Visible   = .T.
1492:         ENDWITH
1493: 
1494:         loc_oCnt.AddObject("txt_4c_CodObs", "TextBox")
1495:         WITH loc_oCnt.txt_4c_CodObs
1496:             .Alignment     = 3
1497:             .InputMask     = "999"
1498:             .Left          = 92
1499:             .Top           = 19
1500:             .Width         = 32
1501:             .Height        = 23
1502:             .Margin        = 0

*-- Linhas 1509 a 1682:
1509:         IF loc_lTemCursorPai
1510:             loc_oCnt.txt_4c_CodObs.ControlSource = "TprMvCab.CodObs"
1511:         ENDIF
1512:         BINDEVENT(loc_oCnt.txt_4c_CodObs, "GotFocus",  THIS, "CodObsGotFocus")
1513:         BINDEVENT(loc_oCnt.txt_4c_CodObs, "LostFocus", THIS, "CodObsLostFocus")
1514:         BINDEVENT(loc_oCnt.txt_4c_CodObs, "When",      THIS, "CodObsWhen")
1515: 
1516:         loc_oCnt.AddObject("obj_4c_GetDesObs", "EditBox")
1517:         WITH loc_oCnt.obj_4c_GetDesObs
1518:             .FontSize      = 8
1519:             .Left          = 3
1520:             .Top           = 46
1521:             .Width         = 453
1522:             .Height        = 254
1523:             .SpecialEffect = 1
1524:             .ForeColor     = RGB(0, 0, 0)
1525:             .BorderColor   = RGB(100, 100, 100)
1526:             .Visible       = .T.
1527:         ENDWITH
1528:         IF loc_lTemCursorPai
1529:             loc_oCnt.obj_4c_GetDesObs.ControlSource = "TprMvCab.obses"
1530:         ENDIF
1531:         BINDEVENT(loc_oCnt.obj_4c_GetDesObs, "When", THIS, "DesObsWhen")
1532: 
1533:         loc_oCnt.AddObject("cmd_4c_BtnMultObs", "CommandButton")
1534:         WITH loc_oCnt.cmd_4c_BtnMultObs
1535:             .Top          = 5
1536:             .Left         = 135
1537:             .Width        = 24
1538:             .Height       = 24
1539:             .Caption      = ""
1540:             .Picture      = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1541:             .ToolTipText  = "Selecionar M" + CHR(250) + "ltiplas Observa" + CHR(231) + CHR(245) + "es"
1542:             .Themes       = .T.
1543:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1544:             .Visible      = .T.
1545:         ENDWITH
1546:         BINDEVENT(loc_oCnt.cmd_4c_BtnMultObs, "Click", THIS, "BtnMultObsObservacaoClick")
1547:     ENDPROC
1548: 
1549:     *==========================================================================
1550:     * CodObsGotFocus - "This.Tag = Str(This.Value, 10)" do legado (getCodObs.
1551:     * GotFocus): guarda o valor de entrada no Tag para o LostFocus saber se
1552:     * o usuario realmente alterou o codigo (evita reabrir o lookup so por
1553:     * entrar/sair do campo sem digitar nada).
1554:     *
1555:     * PUBLIC: alvo de BINDEVENT("GotFocus").
1556:     *==========================================================================
1557:     PROCEDURE CodObsGotFocus()
1558:         LOCAL loc_oTxt
1559:         loc_oTxt = THIS.cnt_4c_Observacao.txt_4c_CodObs
1560:         loc_oTxt.Tag = STR(loc_oTxt.Value, 10)
1561:     ENDPROC
1562: 
1563:     *==========================================================================
1564:     * CodObsWhen - "ThisForm.Antvalu = This.Value / Return Inlist(
1565:     * ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')" do legado (getCodObs.When).
1566:     * Antvalu e bookkeeping do legado (ClassInfo do SIGOPINF - SECAO 4 do
1567:     * dump) sem nenhum consumidor nas secoes de codigo transcritas nesta
1568:     * migracao - a parte que importa (o gate INSERIR/ALTERAR, igual ao dos
1569:     * demais campos) e a unica preservada.
1570:     *
1571:     * PUBLIC: alvo de BINDEVENT("When").
1572:     *==========================================================================
1573:     FUNCTION CodObsWhen()
1574:         RETURN INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
1575:     ENDFUNC
1576: 
1577:     *==========================================================================
1578:     * CodObsLostFocus - equivalente ao getCodObs.Valid legado (regra #47 -
1579:     * lookup de TextBox vai em LostFocus, nao em Valid/KeyPress):
1580:     *
1581:     *   If Not Empty(This.Value) And Not (This.Tag = Str(This.Value, 10))
1582:     *       <monta faixa ObsIni/ObsFins de SigCdOpe/SigCdOop>
1583:     *       <Select Codigos, Descrs From SigCdObs Where Codigos Between ...>
1584:     *       Set Near On / If Not Seek(...) -> fwBuscaSel / Set Near Off
1585:     *       This.Value = crLocalObs.Codigos
1586:     *       ThisForm.MontaObs(...)
1587:     *   EndIf
1588:     *
1589:     * A faixa SigCdOop (override por CFOP, dependente de crSigMvNfi/
1590:     * crSigOpCdd) nao esta disponivel nesta tela ainda (cursores de fases
1591:     * seguintes) - falso seguro: a faixa fica so com o ObsIni/ObsFins de
1592:     * SigCdOpe. fwBuscaSel -> FormBuscaAuxiliar (padrao do projeto).
1593:     *
1594:     * PUBLIC: alvo de BINDEVENT("LostFocus").
1595:     *==========================================================================
1596:     PROCEDURE CodObsLostFocus()
1597:         LOCAL loc_oTxt, loc_nPIni, loc_nPFim, loc_cSQL, loc_nErro, ;
1598:               loc_oBusca, loc_oErro, loc_lAchou
1599: 
1600:         loc_oTxt = THIS.cnt_4c_Observacao.txt_4c_CodObs
1601: 
1602:         IF EMPTY(loc_oTxt.Value) OR loc_oTxt.Tag == STR(loc_oTxt.Value, 10)
1603:             RETURN
1604:         ENDIF
1605: 
1606:         loc_nPIni = 0
1607:         loc_nPFim = 999
1608:         IF USED("TprMvCab")
1609:             loc_cSQL = "SELECT ObsPads, ObsInis, ObsFins FROM SigCdOpe " + ;
1610:                 "WHERE Dopes = " + EscaparSQL(TprMvCab.Dopes)
1611:             loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalOpe")
1612: 
1613:             IF loc_nErro >= 1 AND RECCOUNT("cursor_4c_LocalOpe") > 0
1614:                 loc_nPIni = IIF(!EMPTY(cursor_4c_LocalOpe.ObsInis), cursor_4c_LocalOpe.ObsInis, 0)
1615:                 loc_nPFim = IIF(!EMPTY(cursor_4c_LocalOpe.ObsFins), cursor_4c_LocalOpe.ObsFins, 999)
1616:             ENDIF
1617:             IF USED("cursor_4c_LocalOpe")
1618:                 USE IN cursor_4c_LocalOpe
1619:             ENDIF
1620:         ENDIF
1621: 
1622:         loc_cSQL = "SELECT Codigos, Descrs FROM SigCdObs WHERE Codigos BETWEEN " + ;
1623:             FormatarNumeroSQL(loc_nPIni, 0) + " AND " + FormatarNumeroSQL(loc_nPFim, 0)
1624:         loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalObs")
1625: 
1626:         IF loc_nErro < 1
1627:             MsgErro("Favor reinicializar o processo." + CHR(13) + ;
1628:                 "Falha na conex" + CHR(227) + "o (cursor_4c_LocalObs)", "Erro")
1629:             RETURN
1630:         ENDIF
1631: 
1632:         loc_lAchou = .F.
1633:         IF USED("cursor_4c_LocalObs")
1634:             SELECT cursor_4c_LocalObs
1635:             LOCATE FOR Codigos = loc_oTxt.Value
1636:             loc_lAchou = FOUND()
1637:         ENDIF
1638: 
1639:         IF !loc_lAchou
1640:             loc_oBusca = .NULL.
1641:             TRY
1642:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1643:                     "SigCdObs", "cursor_4c_BuscaObs", "Codigos", ;
1644:                     TRANSFORM(loc_oTxt.Value), "Observa" + CHR(231) + CHR(245) + "es", ;
1645:                     .F., .F., ;
1646:                     "Codigos BETWEEN " + FormatarNumeroSQL(loc_nPIni, 0) + " AND " + ;
1647:                         FormatarNumeroSQL(loc_nPFim, 0))
1648:             CATCH TO loc_oErro
1649:                 MsgErro(loc_oErro.Message, "Erro ao abrir busca de observa" + CHR(231) + CHR(245) + "es")
1650:                 loc_oBusca = .NULL.
1651:             ENDTRY
1652: 
1653:             IF VARTYPE(loc_oBusca) = "O"
1654:                 IF !loc_oBusca.this_lAchouRegistro
1655:                     loc_oBusca.mAddColuna("Codigos", "999", "C" + CHR(243) + "d.")
1656:                     loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
1657:                     loc_oBusca.Show()
1658:                 ENDIF
1659: 
1660:                 IF loc_oBusca.this_lSelecionou
1661:                     loc_oTxt.Value = VAL(loc_oBusca.cCodigoSelecionado)
1662:                 ELSE
1663:                     loc_oTxt.Value = 0
1664:                 ENDIF
1665: 
1666:                 IF USED("cursor_4c_BuscaObs")
1667:                     USE IN cursor_4c_BuscaObs
1668:                 ENDIF
1669:                 loc_oBusca.Release()
1670:             ENDIF
1671:         ENDIF
1672: 
1673:         IF USED("cursor_4c_LocalObs")
1674:             USE IN cursor_4c_LocalObs
1675:         ENDIF
1676: 
1677:         IF !EMPTY(loc_oTxt.Value)
1678:             THIS.MontarObservacaoPadrao(loc_oTxt.Value)
1679:         ENDIF
1680:     ENDPROC
1681: 
1682:     *==========================================================================

*-- Linhas 1690 a 1819:
1690:     *
1691:     * PROTECTED: chamado so por CodObsLostFocus.
1692:     *==========================================================================
1693:     PROTECTED PROCEDURE MontarObservacaoPadrao(par_nCodObs)
1694:         LOCAL loc_cSQL, loc_nErro, loc_cObs, loc_oTxtDesc
1695: 
1696:         loc_cSQL = "SELECT Codigos, Observas FROM SigCdObs WHERE Codigos = " + ;
1697:             FormatarNumeroSQL(par_nCodObs, 0)
1698:         loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdObs")
1699: 
1700:         IF loc_nErro >= 1 AND RECCOUNT("cursor_4c_SigCdObs") > 0
1701:             loc_cObs     = ALLTRIM(TratarNulo(cursor_4c_SigCdObs.Observas, "C"))
1702:             loc_oTxtDesc = THIS.cnt_4c_Observacao.obj_4c_GetDesObs
1703: 
1704:             IF "#" $ loc_cObs OR "$" $ loc_cObs OR "%" $ loc_cObs OR "!" $ loc_cObs
1705:                 THIS.AvisarLegadoNaoPortado("fMontaObs() / grade de itens (TmpOperacao)", ;
1706:                     "completar a observa" + CHR(231) + CHR(227) + "o padr" + CHR(227) + "o com os dados da grade")
1707:             ENDIF
1708: 
1709:             loc_oTxtDesc.Value = loc_cObs
1710:             loc_oTxtDesc.Refresh()
1711:         ENDIF
1712: 
1713:         IF USED("cursor_4c_SigCdObs")
1714:             USE IN cursor_4c_SigCdObs
1715:         ENDIF
1716:     ENDPROC
1717: 
1718:     *==========================================================================
1719:     * DesObsWhen - getDesObs.When legado:
1720:     *   IF fChecaAcesso( padl(crSigCdOpe.nDopes,8,'0'), 'ALTINFO' )
1721:     *       Return !InList(ThisForm.pcEscolha,'EXCLUIR')
1722:     *   Else
1723:     *       Dodefault()     && equivalente ao When padrao do fwmemo -
1724:     *                          mesmo texto dos demais campos (INSERIR/ALTERAR)
1725:     *   Endif
1726:     * Sem crSigCdOpe (cursor do Init legado, fases seguintes), cai direto
1727:     * no ramo "Dodefault()" - e exatamente o que o legado faria se a
1728:     * checagem nao pudesse ser avaliada.
1729:     *
1730:     * PUBLIC: alvo de BINDEVENT("When").
1731:     *==========================================================================
1732:     FUNCTION DesObsWhen()
1733:         IF USED("crSigCdOpe") AND fChecaAcesso(PADL(TRANSFORM(crSigCdOpe.nDopes), 8, "0"), "ALTINFO")
1734:             RETURN !INLIST(THIS.this_cPcEscolha, "EXCLUIR")
1735:         ENDIF
1736: 
1737:         RETURN THIS.VolumesWhen()
1738:     ENDFUNC
1739: 
1740:     *==========================================================================
1741:     * BtnMultObsObservacaoClick - btnMultObs.Valid de cntObservacao (evento
1742:     * "Valid" num fwbtnp - mesma convencao ja adotada na Fase 4 para
1743:     * cmdCotacao/cmdEntrega: bind no "Click", nao no "Valid"):
1744:     *
1745:     *   If (TprMvCab.CodObs > 0)
1746:     *       MessageBox('Para Selecionar Multiplas Observacoes Nao Pode Ser
1747:     *                    Informado o Codigo de Observacao')
1748:     *       ThisForm.cntObservacao.getCodObs.SetFocus
1749:     *       Return .f.
1750:     *   EndIf
1751:     *   Do Form SigOpIns With ThisForm.ParentForm.poDataMgr
1752:     *   ThisForm.cntObservacao.getDesObs.Refresh
1753:     *
1754:     * SigOpIns nao veio no acervo - AvisarLegadoNaoPortado().
1755:     *
1756:     * PUBLIC: alvo de BINDEVENT("Click").
1757:     *==========================================================================
1758:     PROCEDURE BtnMultObsObservacaoClick()
1759:         LOCAL loc_oTxtCod
1760:         loc_oTxtCod = THIS.cnt_4c_Observacao.txt_4c_CodObs
1761: 
1762:         IF loc_oTxtCod.Value > 0
1763:             MsgAviso("Para Selecionar M" + CHR(250) + "ltiplas Observa" + CHR(231) + CHR(245) + "es N" + CHR(227) + "o " + ;
1764:                 "Pode Ser Informado o C" + CHR(243) + "digo de Observa" + CHR(231) + CHR(227) + "o", ;
1765:                 "Aten" + CHR(231) + CHR(227) + "o")
1766:             loc_oTxtCod.SetFocus()
1767:             RETURN
1768:         ENDIF
1769: 
1770:         THIS.AvisarLegadoNaoPortado("Tela de Sele" + CHR(231) + CHR(227) + "o de Observa" + CHR(231) + CHR(245) + "es (SigOpIns)", ;
1771:             "selecionar m" + CHR(250) + "ltiplas observa" + CHR(231) + CHR(245) + "es")
1772:     ENDPROC
1773: 
1774:     *==========================================================================
1775:     * ConfigurarProtocolo - cntProtocolo (cnt_4c_Protocolo): campo unico de
1776:     * protocolo. When identico ao texto de PadraoIncluirAlterarWhen (regra
1777:     * #47/Fase5) - reaproveitado sem duplicar.
1778:     *==========================================================================
1779:     PROTECTED PROCEDURE ConfigurarProtocolo()
1780:         LOCAL loc_oCnt, loc_lTemCursorPai
1781:         loc_lTemCursorPai = USED("TprMvCab")
1782: 
1783:         THIS.AddObject("cnt_4c_Protocolo", "Container")
1784:         loc_oCnt = THIS.cnt_4c_Protocolo
1785:         WITH loc_oCnt
1786:             .Top         = 96
1787:             .Left        = 461
1788:             .Width       = 61
1789:             .Height      = 45
1790:             .BackStyle   = 0
1791:             .BorderWidth = 0
1792:             .Visible     = .T.
1793:         ENDWITH
1794: 
1795:         loc_oCnt.AddObject("lbl_4c_LblProtocolos", "Label")
1796:         WITH loc_oCnt.lbl_4c_LblProtocolos
1797:             .FontName  = "Tahoma"
1798:             .FontSize  = 8
1799:             .BackStyle = 0
1800:             .Alignment = 0
1801:             .AutoSize  = .F.
1802:             .Caption   = "Protocolo"
1803:             .Left      = 3
1804:             .Top       = 3
1805:             .Width     = 55
1806:             .ForeColor = RGB(90, 90, 90)
1807:             .Visible   = .T.
1808:         ENDWITH
1809: 
1810:         loc_oCnt.AddObject("txt_4c_Protocolos", "TextBox")
1811:         WITH loc_oCnt.txt_4c_Protocolos
1812:             .Alignment     = 3
1813:             .Format        = "K"
1814:             .InputMask     = "999999"
1815:             .MaxLength     = 6
1816:             .Left          = 3
1817:             .Top           = 20
1818:             .Width         = 55
1819:             .Height        = 23

*-- Linhas 1826 a 1878:
1826:         IF loc_lTemCursorPai
1827:             loc_oCnt.txt_4c_Protocolos.ControlSource = "TprMvCab.protats"
1828:         ENDIF
1829:         BINDEVENT(loc_oCnt.txt_4c_Protocolos, "When", THIS, "PadraoIncluirAlterarWhen")
1830:     ENDPROC
1831: 
1832:     *==========================================================================
1833:     * ConfigurarEntrega - cntEntrega (cnt_4c_Entrega): conta/nome/cpf-cnpj
1834:     * do destinatario da entrega + botao "Local de Entrega". Os tres campos
1835:     * de conta sao intercambiaveis no legado (preencher um resolve os
1836:     * outros dois) - ver ContasLostFocus/DContaLostFocus/CpfsLostFocus.
1837:     *==========================================================================
1838:     PROTECTED PROCEDURE ConfigurarEntrega()
1839:         LOCAL loc_oCnt, loc_lTemCursorPai
1840:         loc_lTemCursorPai = USED("TprMvCab")
1841: 
1842:         THIS.AddObject("cnt_4c_Entrega", "Container")
1843:         loc_oCnt = THIS.cnt_4c_Entrega
1844:         WITH loc_oCnt
1845:             .Top         = 192
1846:             .Left        = 489
1847:             .Width       = 504
1848:             .Height      = 66
1849:             .BackStyle   = 0
1850:             .BorderWidth = 0
1851:             .Visible     = .T.
1852:         ENDWITH
1853: 
1854:         loc_oCnt.AddObject("lbl_4c_LblEntregas", "Label")
1855:         WITH loc_oCnt.lbl_4c_LblEntregas
1856:             .FontBold  = .T.
1857:             .FontName  = "Tahoma"
1858:             .FontSize  = 8
1859:             .BackStyle = 0
1860:             .Alignment = 0
1861:             .AutoSize  = .F.
1862:             .Caption   = "Entrega"
1863:             .Left      = 3
1864:             .Top       = 3
1865:             .Width     = 85
1866:             .ForeColor = RGB(90, 90, 90)
1867:             .Visible   = .T.
1868:         ENDWITH
1869: 
1870:         loc_oCnt.AddObject("lbl_4c_LblContas", "Label")
1871:         WITH loc_oCnt.lbl_4c_LblContas
1872:             .FontName  = "Tahoma"
1873:             .FontSize  = 8
1874:             .BackStyle = 0
1875:             .Alignment = 0
1876:             .AutoSize  = .F.
1877:             .Caption   = "Conta"
1878:             .Left      = 3

*-- Linhas 1930 a 2078:
1930:         IF loc_lTemCursorPai
1931:             loc_oCnt.txt_4c_Contas.ControlSource = "TprMvCab.contaes"
1932:         ENDIF
1933:         BINDEVENT(loc_oCnt.txt_4c_Contas, "LostFocus", THIS, "ContasLostFocus")
1934:         BINDEVENT(loc_oCnt.txt_4c_Contas, "When",      THIS, "PadraoIncluirAlterarWhen")
1935: 
1936:         loc_oCnt.AddObject("txt_4c_Cpfs", "TextBox")
1937:         WITH loc_oCnt.txt_4c_Cpfs
1938:             .Left          = 77
1939:             .Top           = 40
1940:             .Width         = 131
1941:             .Height        = 23
1942:             .Margin        = 0
1943:             .SpecialEffect = 1
1944:             .ForeColor     = RGB(0, 0, 0)
1945:             .BorderColor   = RGB(100, 100, 100)
1946:             .Visible       = .T.
1947:         ENDWITH
1948:         BINDEVENT(loc_oCnt.txt_4c_Cpfs, "LostFocus", THIS, "CpfsLostFocus")
1949:         BINDEVENT(loc_oCnt.txt_4c_Cpfs, "When",      THIS, "EntregaCamposLiberadosWhen")
1950: 
1951:         loc_oCnt.AddObject("txt_4c_DConta", "TextBox")
1952:         WITH loc_oCnt.txt_4c_DConta
1953:             .Left          = 210
1954:             .Top           = 40
1955:             .Width         = 285
1956:             .Height        = 23
1957:             .Margin        = 0
1958:             .SpecialEffect = 1
1959:             .ForeColor     = RGB(0, 0, 0)
1960:             .BorderColor   = RGB(100, 100, 100)
1961:             .Visible       = .T.
1962:         ENDWITH
1963:         BINDEVENT(loc_oCnt.txt_4c_DConta, "LostFocus", THIS, "DContaLostFocus")
1964:         BINDEVENT(loc_oCnt.txt_4c_DConta, "When",      THIS, "EntregaCamposLiberadosWhen")
1965: 
1966:         loc_oCnt.AddObject("cmd_4c_CmdEntrega", "CommandButton")
1967:         WITH loc_oCnt.cmd_4c_CmdEntrega
1968:             .Top             = 0
1969:             .Left            = 455
1970:             .Width           = 24
1971:             .Height          = 24
1972:             .Caption         = ""
1973:             .Picture         = gc_4c_CaminhoIcones + "geral_relogio_26.jpg"
1974:             .ToolTipText     = "Local de Entrega"
1975:             .Themes          = .T.
1976:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_relogio_26.jpg"
1977:             .Visible         = .T.
1978:         ENDWITH
1979:         BINDEVENT(loc_oCnt.cmd_4c_CmdEntrega, "Click", THIS, "EntregaLocalClick")
1980:     ENDPROC
1981: 
1982:     *==========================================================================
1983:     * ContasLostFocus/DContaLostFocus/CpfsLostFocus - equivalentes ao Valid/
1984:     * LostFocus legado de getContas/getDConta/getCpfs (regra #47). Os tres
1985:     * campos sao intercambiaveis: preencher QUALQUER um localiza a conta em
1986:     * SigCdCli e preenche os outros dois.
1987:     *
1988:     * fAcessoContas(..., pSt1=.NULL., pSt2=.NULL.) - modo BACKEND (regra do
1989:     * projeto: AcessoContas() NUNCA em modo lookup-UI, que auto-popula com o
1990:     * PRIMEIRO registro que contem o valor digitado - aqui ele so confere
1991:     * ACESSO, sem objeto de TextBox nenhum).
1992:     *
1993:     * PUBLIC: alvo de BINDEVENT("LostFocus").
1994:     *==========================================================================
1995:     PROCEDURE ContasLostFocus()
1996:         LOCAL loc_oTxt, loc_cValor
1997: 
1998:         loc_oTxt   = THIS.cnt_4c_Entrega.txt_4c_Contas
1999:         loc_cValor = ALLTRIM(TRANSFORM(loc_oTxt.Value))
2000: 
2001:         IF EMPTY(loc_cValor)
2002:             THIS.LimparContaEntrega()
2003:             RETURN
2004:         ENDIF
2005: 
2006:         IF !fAcessoContas(gc_4c_UsuarioLogado, "", "C", loc_cValor, .NULL., .NULL.)
2007:             MsgAviso("Acesso Negado!!!", "Aten" + CHR(231) + CHR(227) + "o")
2008:             THIS.LimparContaEntrega()
2009:             RETURN
2010:         ENDIF
2011: 
2012:         IF !THIS.BuscarContaEntrega("IClis", loc_cValor)
2013:             THIS.AbrirBuscaContaEntrega(loc_cValor, "IClis")
2014:         ENDIF
2015:     ENDPROC
2016: 
2017:     PROCEDURE DContaLostFocus()
2018:         LOCAL loc_oTxt, loc_cValor
2019: 
2020:         loc_oTxt   = THIS.cnt_4c_Entrega.txt_4c_DConta
2021:         loc_cValor = ALLTRIM(TRANSFORM(loc_oTxt.Value))
2022: 
2023:         IF EMPTY(loc_cValor)
2024:             RETURN
2025:         ENDIF
2026: 
2027:         IF !fAcessoContas(gc_4c_UsuarioLogado, "", "D", loc_cValor, .NULL., .NULL.)
2028:             MsgAviso("Acesso Negado!!!", "Aten" + CHR(231) + CHR(227) + "o")
2029:             THIS.LimparContaEntrega()
2030:             RETURN
2031:         ENDIF
2032: 
2033:         IF !THIS.BuscarContaEntrega("RClis", loc_cValor)
2034:             THIS.AbrirBuscaContaEntrega(loc_cValor, "RClis")
2035:         ENDIF
2036:     ENDPROC
2037: 
2038:     PROCEDURE CpfsLostFocus()
2039:         LOCAL loc_oTxt, loc_cCgc, loc_cCgcFmt
2040: 
2041:         loc_oTxt = THIS.cnt_4c_Entrega.txt_4c_Cpfs
2042:         loc_cCgc = STRTRAN(STRTRAN(STRTRAN(ALLTRIM(TRANSFORM(loc_oTxt.Value)), ".", ""), "-", ""), "/", "")
2043: 
2044:         IF EMPTY(loc_cCgc)
2045:             RETURN
2046:         ENDIF
2047: 
2048:         loc_cCgcFmt = IIF(LEN(loc_cCgc) <> 14, TRANSFORM(loc_cCgc, "@R 999.999.999-99"), ;
2049:             TRANSFORM(loc_cCgc, "@R 99.999.999/9999-99"))
2050:         loc_oTxt.Value = loc_cCgcFmt
2051: 
2052:         IF !THIS.BuscarContaEntrega("Cpfs", loc_cCgcFmt)
2053:             THIS.AbrirBuscaContaEntrega(loc_cCgcFmt, "Cpfs")
2054:         ENDIF
2055:     ENDPROC
2056: 
2057:     *==========================================================================
2058:     * BuscarContaEntrega - match EXATO em SigCdCli pelo campo informado
2059:     * (Iclis/Rclis/Cpfs) - equivalente ao "Cursorquery('SigCdCli', 'CrTmpCli',
2060:     * <campo>, <valor>)" do legado. Devolve .T. se achou (e ja preencheu os
2061:     * tres campos, sob as checagens de ValidarContaEntregaEncontrada).
2062:     *
2063:     * PROTECTED: chamado so pelos LostFocus acima.
2064:     *==========================================================================
2065:     PROTECTED FUNCTION BuscarContaEntrega(par_cCampo, par_cValor)
2066:         LOCAL loc_cSQL, loc_nErro, loc_lAchou
2067:         loc_lAchou = .F.
2068: 
2069:         loc_cSQL = "SELECT TOP 1 IClis, RClis, Cpfs, Situas FROM SigCdCli WHERE " + ;
2070:             par_cCampo + " = " + EscaparSQL(par_cValor)
2071:         loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaContaEntrega")
2072: 
2073:         IF loc_nErro >= 1 AND RECCOUNT("cursor_4c_BuscaContaEntrega") > 0
2074:             IF THIS.ValidarContaEntregaEncontrada("cursor_4c_BuscaContaEntrega")
2075:                 THIS.PreencherContaEntrega(ALLTRIM(cursor_4c_BuscaContaEntrega.IClis), ;
2076:                     ALLTRIM(cursor_4c_BuscaContaEntrega.RClis), ALLTRIM(cursor_4c_BuscaContaEntrega.Cpfs))
2077:             ELSE
2078:                 THIS.LimparContaEntrega()

*-- Linhas 2093 a 2141:
2093:     *
2094:     * PROTECTED: chamado so pelos LostFocus acima.
2095:     *==========================================================================
2096:     PROTECTED PROCEDURE AbrirBuscaContaEntrega(par_cValor, par_cCampo)
2097:         LOCAL loc_oBusca, loc_oErro
2098: 
2099:         loc_oBusca = .NULL.
2100:         TRY
2101:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2102:                 "SigCdCli", "cursor_4c_BuscaContaEntrega", par_cCampo, par_cValor, ;
2103:                 "Conta de Entrega")
2104:         CATCH TO loc_oErro
2105:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de contas")
2106:             loc_oBusca = .NULL.
2107:         ENDTRY
2108: 
2109:         IF VARTYPE(loc_oBusca) = "O"
2110:             IF !loc_oBusca.this_lAchouRegistro
2111:                 loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
2112:                 loc_oBusca.mAddColuna("RClis", "", "Nome")
2113:                 loc_oBusca.mAddColuna("Cpfs",  "", "CPF/CNPJ")
2114:                 loc_oBusca.Show()
2115:             ENDIF
2116: 
2117:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaContaEntrega")
2118:                 IF THIS.ValidarContaEntregaEncontrada("cursor_4c_BuscaContaEntrega")
2119:                     THIS.PreencherContaEntrega(ALLTRIM(cursor_4c_BuscaContaEntrega.IClis), ;
2120:                         ALLTRIM(cursor_4c_BuscaContaEntrega.RClis), ALLTRIM(cursor_4c_BuscaContaEntrega.Cpfs))
2121:                 ELSE
2122:                     THIS.LimparContaEntrega()
2123:                 ENDIF
2124:             ELSE
2125:                 THIS.LimparContaEntrega()
2126:             ENDIF
2127: 
2128:             IF USED("cursor_4c_BuscaContaEntrega")
2129:                 USE IN cursor_4c_BuscaContaEntrega
2130:             ENDIF
2131:             loc_oBusca.Release()
2132:         ENDIF
2133:     ENDPROC
2134: 
2135:     *==========================================================================
2136:     * ValidarContaEntregaEncontrada - as duas checagens extras do legado
2137:     * ("If crSigCdOpe.ExibSits=4" - situacao da conta em SigCdCst, e
2138:     * "If CrSigOpCdc.ChCtEntrs" - conta de entrega tem que ser diferente da
2139:     * conta de origem/destino). Ambas dependem de cursores que esta tela
2140:     * ainda nao carrega (CursorQuery do Init legado, fases seguintes) -
2141:     * falso seguro: sem o cursor, a checagem fica de fora e a conta e

*-- Linhas 2160 a 2345:
2160:                     IF cursor_4c_SituacaoConta.DispMovs = 1
2161:                         loc_cMsg = ALLTRIM(IIF(!EMPTY(cursor_4c_SituacaoConta.Descr2s), ;
2162:                             cursor_4c_SituacaoConta.Descr2s, cursor_4c_SituacaoConta.Descrs))
2163:                         MsgAviso(loc_cSituas + " - " + loc_cMsg, "Situa" + CHR(231) + CHR(227) + "o")
2164: 
2165:                         IF cursor_4c_SituacaoConta.BlqMovs = 1
2166:                             MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o Bloqueada pela Situa" + CHR(231) + CHR(227) + "o da Conta...", ;
2167:                                 "Aten" + CHR(231) + CHR(227) + "o")
2168:                             loc_lAceita = .F.
2169:                         ENDIF
2170:                     ENDIF
2171: 
2172:                     IF loc_lAceita AND USED("TprMvCab") AND TprMvCab.ValVars < 0 AND cursor_4c_SituacaoConta.BlqDescs = 1
2173:                         loc_cMsg = ALLTRIM(IIF(!EMPTY(cursor_4c_SituacaoConta.Descr2s), ;
2174:                             cursor_4c_SituacaoConta.Descr2s, cursor_4c_SituacaoConta.Descrs))
2175:                         MsgAviso(loc_cSituas + " - " + loc_cMsg + CHR(13) + ;
2176:                             "Desconto Bloqueado Pela Situa" + CHR(231) + CHR(227) + "o da Conta", "Situa" + CHR(231) + CHR(227) + "o")
2177:                         loc_lAceita = .F.
2178:                     ENDIF
2179:                 ENDIF
2180: 
2181:                 IF USED("cursor_4c_SituacaoConta")
2182:                     USE IN cursor_4c_SituacaoConta
2183:                 ENDIF
2184:             ENDIF
2185:         ENDIF
2186: 
2187:         IF loc_lAceita AND USED("crSigOpCdc") AND USED("TprMvCab") AND USED(par_cCursor)
2188:             loc_cIClis = ALLTRIM(TratarNulo(EVALUATE(par_cCursor + ".IClis"), "C"))
2189: 
2190:             IF (crSigOpCdc.ChCtEntrs = 1 AND loc_cIClis == ALLTRIM(TprMvCab.ContaDs)) ;
2191:                OR (crSigOpCdc.ChCtEntrs = 2 AND loc_cIClis == ALLTRIM(TprMvCab.ContaOs))
2192:                 MsgAviso("Conta de Entrega Tem que ser diferente da Conta de " + ;
2193:                     IIF(crSigOpCdc.ChCtEntrs = 1, "Destino", "Origem"), "Aten" + CHR(231) + CHR(227) + "o")
2194:                 loc_lAceita = .F.
2195:             ENDIF
2196:         ENDIF
2197: 
2198:         RETURN loc_lAceita
2199:     ENDFUNC
2200: 
2201:     *==========================================================================
2202:     * PreencherContaEntrega/LimparContaEntrega - preenche/limpa os tres
2203:     * campos do container E a propria TprMvCab.ContaEs (os tres campos
2204:     * sincronizados, igual ao ".Refresh" dos tres no final de cada Valid
2205:     * legado).
2206:     *
2207:     * PROTECTED: chamados pelos metodos de busca acima.
2208:     *==========================================================================
2209:     PROTECTED PROCEDURE PreencherContaEntrega(par_cIClis, par_cRClis, par_cCpfs)
2210:         THIS.cnt_4c_Entrega.txt_4c_Contas.Value = par_cIClis
2211:         THIS.cnt_4c_Entrega.txt_4c_DConta.Value = par_cRClis
2212:         THIS.cnt_4c_Entrega.txt_4c_Cpfs.Value   = par_cCpfs
2213: 
2214:         IF USED("TprMvCab")
2215:             REPLACE ContaEs WITH par_cIClis IN TprMvCab
2216:         ENDIF
2217:     ENDPROC
2218: 
2219:     PROTECTED PROCEDURE LimparContaEntrega()
2220:         THIS.cnt_4c_Entrega.txt_4c_Contas.Value = ""
2221:         THIS.cnt_4c_Entrega.txt_4c_DConta.Value = ""
2222:         THIS.cnt_4c_Entrega.txt_4c_Cpfs.Value   = ""
2223: 
2224:         IF USED("TprMvCab")
2225:             REPLACE ContaEs WITH "" IN TprMvCab
2226:         ENDIF
2227:     ENDPROC
2228: 
2229:     *==========================================================================
2230:     * EntregaCamposLiberadosWhen - "Return Inlist(ThisForm.pcEscolha,
2231:     * 'INSERIR', 'ALTERAR') And Empty(ThisForm.cntEntrega.getContas.Value)"
2232:     * do legado - texto IDENTICO em getDConta.When e getCpfs.When: so
2233:     * liberados quando a Conta (codigo) ainda nao foi preenchida (os tres
2234:     * campos sao intercambiaveis, mas o legado da preferencia ao codigo).
2235:     *
2236:     * PUBLIC: alvo de BINDEVENT("When").
2237:     *==========================================================================
2238:     FUNCTION EntregaCamposLiberadosWhen()
2239:         RETURN INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR") ;
2240:             AND EMPTY(THIS.cnt_4c_Entrega.txt_4c_Contas.Value)
2241:     ENDFUNC
2242: 
2243:     *==========================================================================
2244:     * EntregaLocalClick - cntEntrega.cmdEntrega.Valid legado ("Local de
2245:     * Entrega" - mesma convencao da Fase 4 de ligar "Valid" de fwbtnp a
2246:     * "Click"), com o guard do When embutido (CommandButton nao tem When em
2247:     * VFP9 nativo - "Return InList(pcEscolha,'INSERIR','ALTERAR',
2248:     * 'CONSULTAR')" do legado vira guard no topo do handler):
2249:     *
2250:     *   Cursorquery('SigCdCli','crDCompCli','Iclis',TprMvCab.ContaEs,
2251:     *       'Grupos, IClis, RClis')
2252:     *   Do Form SigCdEnd With ..., TprMvCab.LocalEnts
2253:     *   If InList(pcEscolha,'INSERIR','ALTERAR')
2254:     *       fEndEntrega(@laArray, poDataMgr) -> Replace LocalEnts
2255:     *   EndIf
2256:     *
2257:     * SigCdEnd nao veio no acervo - AvisarLegadoNaoPortado() no CATCH da
2258:     * tentativa real. fEndEntrega() resolveria LocalEnts a partir do
2259:     * RESULTADO de SigCdEnd - sem a tela, nao ha resultado confiavel para
2260:     * gravar (o aviso acima ja cobre a ausencia).
2261:     *
2262:     * PUBLIC: alvo de BINDEVENT("Click").
2263:     *==========================================================================
2264:     PROCEDURE EntregaLocalClick()
2265:         LOCAL loc_cSQL, loc_nErro, loc_cGrupos, loc_cIClis, loc_cRClis, loc_oDlg, loc_oErro
2266: 
2267:         IF !INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR", "CONSULTAR") ;
2268:            OR !USED("TprMvCab")
2269:             RETURN
2270:         ENDIF
2271: 
2272:         loc_cSQL = "SELECT Grupos, IClis, RClis FROM SigCdCli WHERE IClis = " + ;
2273:             EscaparSQL(ALLTRIM(TprMvCab.ContaEs))
2274:         loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DCompCli")
2275: 
2276:         IF loc_nErro < 1 OR RECCOUNT("cursor_4c_DCompCli") = 0
2277:             MsgErro("Favor reinicializar o processo." + CHR(13) + ;
2278:                 "Falha na conex" + CHR(227) + "o (SigCdCli)", "Erro")
2279:         ELSE
2280:             loc_cGrupos = ALLTRIM(cursor_4c_DCompCli.Grupos)
2281:             loc_cIClis  = ALLTRIM(cursor_4c_DCompCli.IClis)
2282:             loc_cRClis  = ALLTRIM(cursor_4c_DCompCli.RClis)
2283: 
2284:             TRY
2285:                 loc_oDlg = CREATEOBJECT("FormSigCdEnd", loc_cGrupos, loc_cIClis, loc_cRClis, ;
2286:                     THIS.this_cPcEscolha, TprMvCab.LocalEnts)
2287:                 IF VARTYPE(loc_oDlg) = "O"
2288:                     loc_oDlg.Show()
2289:                 ENDIF
2290:             CATCH TO loc_oErro
2291:                 THIS.AvisarLegadoNaoPortado("Tela de Endere" + CHR(231) + "o de Entrega (SigCdEnd)", ;
2292:                     "informar/alterar o local de entrega")
2293:             ENDTRY
2294:         ENDIF
2295: 
2296:         IF USED("cursor_4c_DCompCli")
2297:             USE IN cursor_4c_DCompCli
2298:         ENDIF
2299:     ENDPROC
2300: 
2301:     *==========================================================================
2302:     * ConfigurarPedido - cntPedido (cnt_4c_Pedido): numero do pedido do
2303:     * cliente.
2304:     *==========================================================================
2305:     PROTECTED PROCEDURE ConfigurarPedido()
2306:         LOCAL loc_oCnt, loc_lTemCursorPai
2307:         loc_lTemCursorPai = USED("TprMvCab")
2308: 
2309:         THIS.AddObject("cnt_4c_Pedido", "Container")
2310:         loc_oCnt = THIS.cnt_4c_Pedido
2311:         WITH loc_oCnt
2312:             .Top         = 96
2313:             .Left        = 522
2314:             .Width       = 61
2315:             .Height      = 45
2316:             .BackStyle   = 0
2317:             .BorderWidth = 0
2318:             .Visible     = .T.
2319:         ENDWITH
2320: 
2321:         loc_oCnt.AddObject("lbl_4c_LblPedido", "Label")
2322:         WITH loc_oCnt.lbl_4c_LblPedido
2323:             .FontName  = "Tahoma"
2324:             .FontSize  = 8
2325:             .BackStyle = 0
2326:             .Alignment = 0
2327:             .AutoSize  = .F.
2328:             .Caption   = "Pedido"
2329:             .Left      = 3
2330:             .Top       = 3
2331:             .Width     = 55
2332:             .ForeColor = RGB(90, 90, 90)
2333:             .Visible   = .T.
2334:         ENDWITH
2335: 
2336:         loc_oCnt.AddObject("txt_4c_Pedido", "TextBox")
2337:         WITH loc_oCnt.txt_4c_Pedido
2338:             .Alignment     = 3
2339:             .Format        = "K"
2340:             .InputMask     = "999999"
2341:             .MaxLength     = 6
2342:             .Left          = 3
2343:             .Top           = 20
2344:             .Width         = 55
2345:             .Height        = 23

*-- Linhas 2352 a 2485:
2352:         IF loc_lTemCursorPai
2353:             loc_oCnt.txt_4c_Pedido.ControlSource = "TprMvCab.nPedClis"
2354:         ENDIF
2355:         BINDEVENT(loc_oCnt.txt_4c_Pedido, "When", THIS, "PedidoWhen")
2356:     ENDPROC
2357: 
2358:     *==========================================================================
2359:     * PedidoWhen - "Return Inlist(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR')
2360:     * And Not (crSigCdOpe.PedClis = 5)" do legado (getPedido.When). Sem
2361:     * crSigCdOpe (fases seguintes), falso seguro - mesmo criterio de
2362:     * DocumentosWhen (bloqueia at? o dado confirmar que pode liberar).
2363:     *
2364:     * PUBLIC: alvo de BINDEVENT("When").
2365:     *==========================================================================
2366:     FUNCTION PedidoWhen()
2367:         LOCAL loc_lPermite
2368:         loc_lPermite = .F.
2369: 
2370:         IF INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR") AND USED("crSigCdOpe")
2371:             loc_lPermite = !(crSigCdOpe.PedClis = 5)
2372:         ENDIF
2373: 
2374:         RETURN loc_lPermite
2375:     ENDFUNC
2376: 
2377:     *==========================================================================
2378:     * ConfigurarObs2 - CntObs2 (cnt_4c_Obs2): "Finalidade" - botao que abre
2379:     * a mesma tela de multiplas observacoes (SigOpIns), mas gravando em
2380:     * CodObs2 em vez de CodObs.
2381:     *==========================================================================
2382:     PROTECTED PROCEDURE ConfigurarObs2()
2383:         LOCAL loc_oCnt
2384: 
2385:         THIS.AddObject("cnt_4c_Obs2", "Container")
2386:         loc_oCnt = THIS.cnt_4c_Obs2
2387:         WITH loc_oCnt
2388:             .Top         = 96
2389:             .Left        = 582
2390:             .Width       = 66
2391:             .Height      = 64
2392:             .BackStyle   = 0
2393:             .BorderWidth = 0
2394:             .Visible     = .T.
2395:         ENDWITH
2396: 
2397:         loc_oCnt.AddObject("lbl_4c_LblPedido", "Label")
2398:         WITH loc_oCnt.lbl_4c_LblPedido
2399:             .FontName  = "Tahoma"
2400:             .FontSize  = 8
2401:             .BackStyle = 0
2402:             .Alignment = 0
2403:             .AutoSize  = .F.
2404:             .Caption   = "Finalidade"
2405:             .Left      = 3
2406:             .Top       = 3
2407:             .Width     = 60
2408:             .ForeColor = RGB(90, 90, 90)
2409:             .Visible   = .T.
2410:         ENDWITH
2411: 
2412:         loc_oCnt.AddObject("cmd_4c_BtnMultObs", "CommandButton")
2413:         WITH loc_oCnt.cmd_4c_BtnMultObs
2414:             .Top             = 20
2415:             .Left            = 3
2416:             .Width           = 24
2417:             .Height          = 24
2418:             .Caption         = ""
2419:             .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
2420:             .ToolTipText     = "Selecionar Finalidade da opera" + CHR(231) + CHR(227) + "o para ser usada no relat" + CHR(243) + "rio de opera" + CHR(231) + CHR(245) + "es."
2421:             .Themes          = .T.
2422:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
2423:             .Visible         = .T.
2424:         ENDWITH
2425:         BINDEVENT(loc_oCnt.cmd_4c_BtnMultObs, "Click", THIS, "BtnMultObsFinalidadeClick")
2426:     ENDPROC
2427: 
2428:     *==========================================================================
2429:     * BtnMultObsFinalidadeClick - CntObs2.btnMultObs.Valid legado:
2430:     *   Do Form SigOpIns With ThisForm.ParentForm.poDataMgr, TprMvCab.CodObs2
2431:     *   replace CodObs2 with ALLTRIM(listaObs) in TprMvCab
2432:     * SigOpIns nao veio no acervo - sem a tela (e sem a lista que ela
2433:     * devolveria em listaObs), nao ha resultado para gravar em CodObs2.
2434:     *
2435:     * PUBLIC: alvo de BINDEVENT("Click").
2436:     *==========================================================================
2437:     PROCEDURE BtnMultObsFinalidadeClick()
2438:         THIS.AvisarLegadoNaoPortado("Tela de Sele" + CHR(231) + CHR(227) + "o de Finalidade (SigOpIns)", ;
2439:             "selecionar a finalidade da opera" + CHR(231) + CHR(227) + "o")
2440:     ENDPROC
2441: 
2442:     *==========================================================================
2443:     * ConfigurarLivre - cntLivre (cnt_4c_Livre): numero do lacre.
2444:     *==========================================================================
2445:     PROTECTED PROCEDURE ConfigurarLivre()
2446:         LOCAL loc_oCnt, loc_lTemCursorPai
2447:         loc_lTemCursorPai = USED("TprMvCab")
2448: 
2449:         THIS.AddObject("cnt_4c_Livre", "Container")
2450:         loc_oCnt = THIS.cnt_4c_Livre
2451:         WITH loc_oCnt
2452:             .Top         = 189
2453:             .Left        = 2
2454:             .Width       = 352
2455:             .Height      = 45
2456:             .BackStyle   = 0
2457:             .BorderWidth = 0
2458:             .Visible     = .T.
2459:         ENDWITH
2460: 
2461:         loc_oCnt.AddObject("lbl_4c_LblNLivDg", "Label")
2462:         WITH loc_oCnt.lbl_4c_LblNLivDg
2463:             .FontName  = "Tahoma"
2464:             .FontSize  = 8
2465:             .BackStyle = 0
2466:             .Alignment = 0
2467:             .AutoSize  = .F.
2468:             .Caption   = "Lacre"
2469:             .Left      = 3
2470:             .Top       = 3
2471:             .Width     = 60
2472:             .Height    = 15
2473:             .ForeColor = RGB(90, 90, 90)
2474:             .Visible   = .T.
2475:         ENDWITH
2476: 
2477:         loc_oCnt.AddObject("txt_4c_NLivDg", "TextBox")
2478:         WITH loc_oCnt.txt_4c_NLivDg
2479:             .Alignment     = 3
2480:             .MaxLength     = 15
2481:             .Value         = 0
2482:             .Left          = 3
2483:             .Top           = 20
2484:             .Width         = 169
2485:             .Height        = 23

*-- Linhas 2492 a 2789:
2492:         IF loc_lTemCursorPai
2493:             loc_oCnt.txt_4c_NLivDg.ControlSource = "TprMvCab.NLivDg"
2494:         ENDIF
2495:         BINDEVENT(loc_oCnt.txt_4c_NLivDg, "When", THIS, "PadraoIncluirAlterarWhen")
2496:     ENDPROC
2497: 
2498:     *==========================================================================
2499:     * AtualizarVisibilidadeCmdEntrega - "ThisForm.cmdEntrega.Visible =
2500:     * InList(crSigCdOpe.DtEntrs,1,4,6) And Not InList(ThisForm.pcEscolha,
2501:     * 'INSERIR','EXCLUIR')" do Init legado (linha 2100). crSigCdOpe e
2502:     * carregado pelo CursorQuery do Init legado, ainda nao portado (fases
2503:     * seguintes) - sem o cursor, o botao fica oculto (falso seguro); quem
2504:     * popular crSigCdOpe numa fase posterior deve chamar este metodo de
2505:     * novo para o botao assumir o estado real.
2506:     *
2507:     * PUBLIC: reutilizavel por fases/metodos futuros que alterem
2508:     * this_cPcEscolha ou recarreguem crSigCdOpe.
2509:     *==========================================================================
2510:     PROCEDURE AtualizarVisibilidadeCmdEntrega()
2511:         LOCAL loc_lVisivel
2512:         loc_lVisivel = .F.
2513: 
2514:         IF USED("crSigCdOpe")
2515:             loc_lVisivel = INLIST(crSigCdOpe.DtEntrs, 1, 4, 6) ;
2516:                 AND !INLIST(THIS.this_cPcEscolha, "INSERIR", "EXCLUIR")
2517:         ENDIF
2518: 
2519:         IF PEMSTATUS(THIS, "obj_4c_CmdEntrega", 5)
2520:             THIS.obj_4c_CmdEntrega.Visible = loc_lVisivel
2521:         ENDIF
2522:     ENDPROC
2523: 
2524:     *==========================================================================
2525:     * CmdCotacaoClick - "Do Form SigPrCtc With Thisform, ThisForm.DataSessionId,
2526:     * ThisForm.pcescolha, TprMvCab.Emps, TprMvCab.Dopes, TprMvCab.Numes" do
2527:     * legado (cmdCotacao.Valid). FormSigPrCtc.Init ja descarta o
2528:     * DataSessionId (arquitetura nova nao precisa dele): assinatura e
2529:     * (par_oFormPai, par_cEscolha, par_cEmps, par_cDopes, par_nNumes).
2530:     * FormSigPrCtc.BtnSairClick fecha com THIS.Release() - nao ha nada a
2531:     * ler nem a liberar depois do Show() aqui.
2532:     *
2533:     * PUBLIC: alvo de BINDEVENT("Click").
2534:     *==========================================================================
2535:     PROCEDURE CmdCotacaoClick()
2536:         LOCAL loc_oDlg, loc_oErro
2537:         loc_oDlg = .NULL.
2538: 
2539:         IF !USED("TprMvCab")
2540:             RETURN
2541:         ENDIF
2542: 
2543:         TRY
2544:             loc_oDlg = CREATEOBJECT("FormSigPrCtc", THIS, THIS.this_cPcEscolha, ;
2545:                 TprMvCab.Emps, TprMvCab.Dopes, TprMvCab.Numes)
2546:         CATCH TO loc_oErro
2547:             MsgErro(loc_oErro.Message + CHR(13) + ;
2548:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
2549:                 "Erro ao abrir Cota" + CHR(231) + CHR(227) + "o")
2550:             loc_oDlg = .NULL.
2551:         ENDTRY
2552: 
2553:         IF VARTYPE(loc_oDlg) = "O"
2554:             loc_oDlg.Show()
2555:         ENDIF
2556:     ENDPROC
2557: 
2558:     *==========================================================================
2559:     * CmdEntregaClick - "Local ldDat, lnMin, ldEst / ldDat = Iif(IsEmpty(
2560:     * TprMvCab.PrazoEnts), Date(), TprMvCab.PrazoEnts) / lnMin = Iif(IsEmpty(
2561:     * crSigOpCdc.NMinEnts), 0, crSigOpCdc.NMinEnts) / lnMax = Iif(IsEmpty(
2562:     * CrSigOpCdc.nMaxEnts), 0, CrSigOpCdc.nMaxEnts) / ldEst = Ttod(fDtoSQL(
2563:     * Nvl(TprMvCab.Datas, Date()))) / Do Form SigOpEnt With TprMvCab.Emps,
2564:     * TprMvCab.Dopes, TprMvCab.Numes, ldDat, ThisForm, lnMin, ldEst, .f.,
2565:     * lnMax" do legado (cmdEntrega.Valid). FormSigOpEnt fecha com Hide()
2566:     * (FecharDialogo) e devolve o resultado por ObterPrazoConfirmado() -
2567:     * ver comentario daquele metodo em FormSigOpEnt.prg. O campo "Entregas"
2568:     * (cnt_4c_Entregas.txt_4c_Entregas) e criado numa fase posterior - a
2569:     * atribuicao e guardada por PEMSTATUS/VARTYPE e nao falha enquanto o
2570:     * container nao existir.
2571:     *
2572:     * PUBLIC: alvo de BINDEVENT("Click").
2573:     *==========================================================================
2574:     PROCEDURE CmdEntregaClick()
2575:         LOCAL loc_oDlg, loc_oErro, loc_dAtual, loc_nMin, loc_nMax, loc_dEst, ;
2576:               loc_dConfirmado
2577: 
2578:         IF !USED("TprMvCab")
2579:             RETURN
2580:         ENDIF
2581: 
2582:         loc_dAtual = IIF(EMPTY(TprMvCab.PrazoEnts), DATE(), TprMvCab.PrazoEnts)
2583: 
2584:         loc_nMin = 0
2585:         loc_nMax = 0
2586:         IF USED("crSigOpCdc")
2587:             loc_nMin = IIF(EMPTY(crSigOpCdc.NMinEnts), 0, crSigOpCdc.NMinEnts)
2588:             loc_nMax = IIF(EMPTY(crSigOpCdc.NMaxEnts), 0, crSigOpCdc.NMaxEnts)
2589:         ENDIF
2590:         loc_dEst = TTOD(fDtoSQL(NVL(TprMvCab.Datas, DATE())))
2591: 
2592:         loc_oDlg = .NULL.
2593:         TRY
2594:             loc_oDlg = CREATEOBJECT("FormSigOpEnt", TprMvCab.Emps, TprMvCab.Dopes, ;
2595:                 TprMvCab.Numes, loc_dAtual, THIS, loc_nMin, loc_dEst, .F., loc_nMax)
2596:         CATCH TO loc_oErro
2597:             MsgErro(loc_oErro.Message + CHR(13) + ;
2598:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
2599:                 "Erro ao abrir Prazo de Entrega")
2600:             loc_oDlg = .NULL.
2601:         ENDTRY
2602: 
2603:         IF VARTYPE(loc_oDlg) = "O"
2604:             loc_oDlg.Show()
2605: 
2606:             loc_dConfirmado = loc_oDlg.ObterPrazoConfirmado()
2607:             IF !EMPTY(loc_dConfirmado)
2608:                 REPLACE PrazoEnts WITH loc_dConfirmado IN TprMvCab
2609: 
2610:                 IF PEMSTATUS(THIS, "cnt_4c_Entregas", 5) AND VARTYPE(THIS.cnt_4c_Entregas) = "O"
2611:                     IF PEMSTATUS(THIS.cnt_4c_Entregas, "txt_4c_Entregas", 5) ;
2612:                        AND VARTYPE(THIS.cnt_4c_Entregas.txt_4c_Entregas) = "O"
2613:                         THIS.cnt_4c_Entregas.txt_4c_Entregas.Value = loc_dConfirmado
2614:                         THIS.cnt_4c_Entregas.txt_4c_Entregas.Refresh()
2615:                     ENDIF
2616:                 ENDIF
2617:             ENDIF
2618: 
2619:             loc_oDlg.Release()
2620:         ENDIF
2621:     ENDPROC
2622: 
2623:     *==========================================================================
2624:     * CarregarCursoresOperacao - "With ThisForm.ParentForm.poDataMgr /
2625:     * .Cursorquery('SigCdOpe','CrSigCdOpe','Dopes',TprMvCab.Dopes) /
2626:     * .Cursorquery('SigOpCdc','CrSigOpCdc','Dopes',TprMvCab.Dopes) /
2627:     * .Cursorquery('SigOpCdd','CrSigOpCdd','Dopes',TprMvCab.Dopes)" do Init
2628:     * legado - os tres cursores que destravam os varios "falso seguro"
2629:     * espalhados pelas Fases 4/5/6 (USED("crSigCdOpe")/USED("CrSigOpCdc")).
2630:     * A 4a CursorQuery do legado (SigCdEmp/CrEmp) fica de fora - so e usada
2631:     * no bloco "Carrega Dados da Conta", fora do escopo desta fase (ver
2632:     * comentario de cabecalho do arquivo).
2633:     *
2634:     * PROTECTED: chamado uma unica vez, por InicializarForm().
2635:     *==========================================================================
2636:     PROTECTED PROCEDURE CarregarCursoresOperacao()
2637:         LOCAL loc_cSQL, loc_nErro
2638: 
2639:         IF !USED("TprMvCab")
2640:             RETURN
2641:         ENDIF
2642: 
2643:         IF USED("crSigCdOpe")
2644:             USE IN crSigCdOpe
2645:         ENDIF
2646:         loc_cSQL  = "SELECT * FROM SigCdOpe WHERE Dopes = " + EscaparSQL(TprMvCab.Dopes)
2647:         loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdOpe")
2648:         IF loc_nErro < 1
2649:             MsgErro("Favor reinicializar o processo." + CHR(13) + ;
2650:                 "Falha na conex" + CHR(227) + "o (SigCdOpe)", "Erro")
2651:         ENDIF
2652: 
2653:         IF USED("CrSigOpCdc")
2654:             USE IN CrSigOpCdc
2655:         ENDIF
2656:         loc_cSQL  = "SELECT * FROM SigOpCdc WHERE Dopes = " + EscaparSQL(TprMvCab.Dopes)
2657:         loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigOpCdc")
2658:         IF loc_nErro < 1
2659:             MsgErro("Favor reinicializar o processo." + CHR(13) + ;
2660:                 "Falha na conex" + CHR(227) + "o (SigOpCdc)", "Erro")
2661:         ENDIF
2662: 
2663:         IF USED("CrSigOpCdd")
2664:             USE IN CrSigOpCdd
2665:         ENDIF
2666:         loc_cSQL  = "SELECT * FROM SigOpCdd WHERE Dopes = " + EscaparSQL(TprMvCab.Dopes)
2667:         loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigOpCdd")
2668:         IF loc_nErro < 1
2669:             MsgErro("Favor reinicializar o processo." + CHR(13) + ;
2670:                 "Falha na conex" + CHR(227) + "o (SigOpCdd)", "Erro")
2671:         ENDIF
2672:     ENDPROC
2673: 
2674:     *==========================================================================
2675:     * CarregarPrazoEntregaPadrao - "PROCEDURE carregaprzent" do legado:
2676:     * sugere data de entrega padrao QUANDO o campo ainda esta vazio ou
2677:     * ainda e hoje - nunca sobrescreve um prazo que o usuario ja moveu.
2678:     *
2679:     *   If (InList(crSigCdOpe.DtEntrs,1,4,6) And InList(pcEscolha,
2680:     *      'INSERIR','ALTERAR') And (IsEmpty(PrazoEnts) Or
2681:     *      Dtos(PrazoEnts)=Dtos(Date())))
2682:     *       lcCta = Iif(crSigCdOpe.COpers=1, ContaDs, ContaOs)
2683:     *       If IsEmpty(PrazoEnts)
2684:     *           ldDat = Date()
2685:     *           If NMinEnts = NMaxEnts -> ldDat = Date()+NMinEnts
2686:     *       Else
2687:     *           ldDat = <PrazoEnts atual>
2688:     *       CursorQuery('SigCdCli','LocalCli','IClis',lcCta,'PrazoEnts')
2689:     *       If LocalCli.PrazoEnts > 0 -> ldDat = ldDat + LocalCli.PrazoEnts
2690:     *   EndIf
2691:     *
2692:     * PROTECTED: chamado so por AtualizarVisibilidadePorOperacao().
2693:     *==========================================================================
2694:     PROTECTED PROCEDURE CarregarPrazoEntregaPadrao()
2695:         LOCAL loc_cConta, loc_dPrazo, loc_cSQL, loc_nErro
2696: 
2697:         IF !USED("TprMvCab") OR !USED("crSigCdOpe")
2698:             RETURN
2699:         ENDIF
2700: 
2701:         IF !INLIST(crSigCdOpe.DtEntrs, 1, 4, 6) ;
2702:            OR !INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR") ;
2703:            OR (!EMPTY(TprMvCab.PrazoEnts) ;
2704:                AND DTOS(ConverterParaData(TprMvCab.PrazoEnts)) <> DTOS(DATE()))
2705:             RETURN
2706:         ENDIF
2707: 
2708:         loc_cConta = ALLTRIM(IIF(crSigCdOpe.COpers = 1, TprMvCab.ContaDs, TprMvCab.ContaOs))
2709: 
2710:         IF EMPTY(TprMvCab.PrazoEnts)
2711:             loc_dPrazo = DATE()
2712:             IF USED("CrSigOpCdc") AND CrSigOpCdc.NMinEnts = CrSigOpCdc.NMaxEnts
2713:                 loc_dPrazo = DATE() + CrSigOpCdc.NMinEnts
2714:                 REPLACE PrazoEnts WITH loc_dPrazo IN TprMvCab
2715:             ENDIF
2716:         ELSE
2717:             loc_dPrazo = ConverterParaData(TprMvCab.PrazoEnts)
2718:         ENDIF
2719: 
2720:         IF !EMPTY(loc_cConta)
2721:             loc_cSQL  = "SELECT PrazoEnts FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cConta)
2722:             loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrazoCliente")
2723: 
2724:             IF loc_nErro >= 1 AND RECCOUNT("cursor_4c_PrazoCliente") > 0 ;
2725:                AND cursor_4c_PrazoCliente.PrazoEnts > 0
2726:                 loc_dPrazo = loc_dPrazo + cursor_4c_PrazoCliente.PrazoEnts
2727:                 REPLACE PrazoEnts WITH loc_dPrazo IN TprMvCab
2728:             ENDIF
2729: 
2730:             IF USED("cursor_4c_PrazoCliente")
2731:                 USE IN cursor_4c_PrazoCliente
2732:             ENDIF
2733:         ENDIF
2734:     ENDPROC
2735: 
2736:     *==========================================================================
2737:     * AtualizarVisibilidadePorOperacao - o corpo do Init legado que liga
2738:     * Visible/Caption de cada container ao tipo de operacao corrente
2739:     * (crSigCdOpe/CrSigOpCdc/CrSigOpCdd, carregados por
2740:     * CarregarCursoresOperacao()). Chamada DEPOIS de
2741:     * TornarControlesVisiveis(THIS): esse metodo reescreve Visible = .T.
2742:     * em CADA AddObject recursivamente, entao a regra de negocio desta
2743:     * tela so vale se for aplicada POR CIMA dele, nao antes.
2744:     *
2745:     * PUBLIC: reutilizavel por fases/metodos futuros que recarreguem os
2746:     * cursores de operacao (mesmo padrao de AtualizarVisibilidadeCmdEntrega,
2747:     * Fase 4) - chamada de novo no final daqui pela mesma razao.
2748:     *==========================================================================
2749:     PROCEDURE AtualizarVisibilidadePorOperacao()
2750:         LOCAL loc_lFiscal
2751: 
2752:         IF !USED("TprMvCab") OR !USED("crSigCdOpe")
2753:             RETURN
2754:         ENDIF
2755: 
2756:         *** Digita Observacao / Digita Entrega / CntObs2
2757:         THIS.cnt_4c_Observacao.Visible = INLIST(crSigCdOpe.DigObs, 1, 3)
2758:         THIS.cnt_4c_Entrega.Visible    = INLIST(crSigCdOpe.DtEntrs, 3, 4, 5, 6)
2759: 
2760:         IF USED("CrSigOpCdd") AND PEMSTATUS(THIS, "cnt_4c_Obs2", 5)
2761:             THIS.cnt_4c_Obs2.Visible = (INT(VAL(SUBSTR(CrSigOpCdd.ConfigGers, 209, 1))) = 1)
2762:         ENDIF
2763: 
2764:         *** Digita Dados Fiscais
2765:         loc_lFiscal = (crSigCdOpe.CupFis = 4)
2766:         THIS.cnt_4c_Ecfs.Visible  = loc_lFiscal
2767:         THIS.cnt_4c_Nemps.Visible = loc_lFiscal
2768: 
2769:         THIS.cnt_4c_Volumes.Visible = (crSigCdOpe.DadosNotas = 1)
2770:         THIS.cnt_4c_Pedido.Visible  = INLIST(crSigCdOpe.PedClis, 1, 3, 4, 5)
2771: 
2772:         IF USED("CrSigOpCdc")
2773:             THIS.cnt_4c_Protocolo.Visible = (CrSigOpCdc.EditProts = 1)
2774:         ENDIF
2775: 
2776:         *-- Carrega Dados da Conta (crSigCdOpe.Opers = 2): o legado busca o
2777:         *-- valor inicial em ThisForm.ParentForm.Pagina.Dados.pgfprincipal.
2778:         *-- pgcontas.Destino.Get_Conta (pagina do form pai) e no cursor
2779:         *-- TmpOperacao (grade de itens) - nenhum dos dois pertence a este
2780:         *-- dialogo. Falso seguro parcial: ao menos confirma/preenche
2781:         *-- Nome e CPF/CNPJ a partir do codigo JA presente em
2782:         *-- TprMvCab.ContaEs, igual ao "lcCliente = TprMvCab.ContaEs /
2783:         *-- CursorQuery(...) / getDConta.Value = ... / getCpfs.Value = ..."
2784:         *-- que fecha esse trecho do Init legado.
2785:         IF !EMPTY(TprMvCab.ContaEs)
2786:             THIS.BuscarContaEntrega("IClis", ALLTRIM(TprMvCab.ContaEs))
2787:         ENDIF
2788: 
2789:         *** Digita Documento / Data de Emissao

*-- Linhas 2817 a 2875:
2817:         *-- Reaplica por cima do que ConfigurarBotoesAcao (Fase 4) ja tinha
2818:         *-- calculado antes dos cursores existirem - e o que faz a
2819:         *-- visibilidade real do botao de atalho de Prazo de Entrega valer
2820:         *-- depois do TornarControlesVisiveis.
2821:         THIS.AtualizarVisibilidadeCmdEntrega()
2822:     ENDPROC
2823: 
2824:     *==========================================================================
2825:     * AjustarPosicaoCampos - "PROCEDURE ajustaobjs" do legado: reflui os
2826:     * containers da 1a linha (Ecfs/Nemps/Protocolo/Pedido, a partir de
2827:     * cnt_4c_Codigos+cnt_4c_Documentos), da 2a linha (Emiss/Entregas/
2828:     * Recepcaos/PrzEnts/Livre) e dos containers empilhados por baixo
2829:     * (Observacao/Entrega/Volumes), preenchendo o espaco dos que a
2830:     * AtualizarVisibilidadePorOperacao() acabou de ocultar. Chamada por
2831:     * ultimo em InicializarForm(), com a visibilidade ja definitiva.
2832:     *
2833:     * PROTECTED: chamado uma unica vez, por InicializarForm().
2834:     *==========================================================================
2835:     PROTECTED PROCEDURE AjustarPosicaoCampos()
2836:         LOCAL loc_nLf0, loc_nTp0, loc_nLft, loc_nTop
2837: 
2838:         loc_nLf0 = THIS.cnt_4c_Codigos.Left
2839:         loc_nTp0 = THIS.cnt_4c_Codigos.Top
2840: 
2841:         *-- Ajustando Primeira Linha de Campos
2842:         loc_nLft = loc_nLf0 + THIS.cnt_4c_Documentos.Width + THIS.cnt_4c_Codigos.Width
2843:         loc_nTop = loc_nTp0
2844: 
2845:         IF THIS.cnt_4c_Ecfs.Visible
2846:             THIS.cnt_4c_Ecfs.Left = loc_nLft
2847:             THIS.cnt_4c_Ecfs.Top  = loc_nTop
2848:             loc_nLft = loc_nLft + THIS.cnt_4c_Ecfs.Width
2849:         ENDIF
2850: 
2851:         IF THIS.cnt_4c_Nemps.Visible
2852:             THIS.cnt_4c_Nemps.Left = loc_nLft
2853:             THIS.cnt_4c_Nemps.Top  = loc_nTop
2854:             loc_nLft = loc_nLft + THIS.cnt_4c_Nemps.Width
2855:         ENDIF
2856: 
2857:         IF THIS.cnt_4c_Protocolo.Visible
2858:             THIS.cnt_4c_Protocolo.Left = loc_nLft
2859:             THIS.cnt_4c_Protocolo.Top  = loc_nTop
2860:             loc_nLft = loc_nLft + THIS.cnt_4c_Protocolo.Width
2861:         ENDIF
2862: 
2863:         IF THIS.cnt_4c_Pedido.Visible
2864:             THIS.cnt_4c_Pedido.Left = loc_nLft
2865:             THIS.cnt_4c_Pedido.Top  = loc_nTop
2866:             loc_nLft = loc_nLft + THIS.cnt_4c_Pedido.Width
2867:         ENDIF
2868: 
2869:         loc_nLft = loc_nLf0
2870:         loc_nTop = loc_nTp0 + THIS.cnt_4c_Codigos.Height + 1
2871: 
2872:         *-- Ajustando Segunda Linha de Campos
2873:         IF THIS.cnt_4c_Emiss.Visible
2874:             THIS.cnt_4c_Emiss.Left = loc_nLft
2875:             THIS.cnt_4c_Emiss.Top  = loc_nTop

*-- Linhas 2942 a 3172:
2942:     * Form receber o KeyPress ANTES dos controles - exigido para capturar
2943:     * F2/F3 em qualquer campo focado, como no legado.
2944:     *==========================================================================
2945:     PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
2946:         IF PEMSTATUS(THIS, "cnt_4c_Entrega", 5) AND VARTYPE(THIS.cnt_4c_Entrega) = "O"
2947:             IF THIS.cnt_4c_Entrega.cmd_4c_CmdEntrega.Visible AND par_nKeyCode = -1
2948:                 THIS.EntregaLocalClick()
2949:                 NODEFAULT
2950:                 RETURN
2951:             ENDIF
2952:         ENDIF
2953: 
2954:         IF PEMSTATUS(THIS, "obj_4c_CmdEntrega", 5) AND VARTYPE(THIS.obj_4c_CmdEntrega) = "O"
2955:             IF THIS.obj_4c_CmdEntrega.Visible AND par_nKeyCode = -2
2956:                 THIS.CmdEntregaClick()
2957:                 NODEFAULT
2958:             ENDIF
2959:         ENDIF
2960:     ENDPROC
2961: 
2962:     *==========================================================================
2963:     * TornarControlesVisiveis - Torna visiveis, recursivamente, os controles
2964:     * criados por AddObject (que nascem com Visible = .F.). Percorre tambem
2965:     * Pages de eventuais PageFrames filhos (nenhum nesta tela, mas o metodo
2966:     * fica generico para as proximas fases).
2967:     *==========================================================================
2968:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2969:         LOCAL loc_nI, loc_oObjeto, loc_nP
2970: 
2971:         FOR loc_nI = 1 TO par_oContainer.ControlCount
2972:             loc_oObjeto = par_oContainer.Controls(loc_nI)
2973: 
2974:             IF VARTYPE(loc_oObjeto) = "O"
2975:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
2976:                     loc_oObjeto.Visible = .T.
2977:                 ENDIF
2978: 
2979:                 IF PEMSTATUS(loc_oObjeto, "BaseClass", 5) ;
2980:                    AND UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
2981:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
2982:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
2983:                     ENDFOR
2984:                 ENDIF
2985: 
2986:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
2987:                     THIS.TornarControlesVisiveis(loc_oObjeto)
2988:                 ENDIF
2989:             ENDIF
2990:         ENDFOR
2991:     ENDPROC
2992: 
2993:     *==========================================================================
2994:     * Destroy - Reabilita o form pai (ver DesabilitarFormPai) e segue para o
2995:     * fechamento canonico do FormBase (restauracao do menu principal).
2996:     *==========================================================================
2997:     PROCEDURE Destroy()
2998:         THIS.ReabilitarFormPai()
2999:         DODEFAULT()
3000:     ENDPROC
3001: 
3002:     *==========================================================================
3003:     * BtnSalvarClick - "PROCEDURE btnSelItens.Click" do legado (170 linhas):
3004:     *
3005:     *   If Inlist(pcEscolha,'INSERIR','ALTERAR')
3006:     *       [observacao obrigatoria / data de emissao / prazo de entrega +
3007:     *        recalculo de vencimentos + liberacao Min/Max / recepcao /
3008:     *        cupom fiscal-ECF / EditDocs=4]
3009:     *   Else
3010:     *       If fChecaAcesso(..., 'ALTINFO') And pcEscolha = 'CONSULTAR'
3011:     *           Update SigMvCab Set obses = ... Where CidChaves = ...
3012:     *       Endif
3013:     *   Endif
3014:     *   ThisForm.Return
3015:     *
3016:     * Cada "Return"/"Return .f." do legado (saida ANTECIPADA, sem gravar) e
3017:     * um RETURN bare deste metodo - so o CAMINHO FELIZ (fim de qualquer dos
3018:     * dois ramos) chama THIS.FecharDialogo(), equivalente ao "ThisForm.
3019:     * Return" final do legado.
3020:     *
3021:     * Guard de topo: sem TprMvCab/crSigCdOpe (cursores do form pai/Init
3022:     * legado) nao ha o que validar nem gravar - mesmo "falso seguro" das
3023:     * Fases 5-7 (CarregarPrazoEntregaPadrao, AtualizarVisibilidadePorOperacao).
3024:     *
3025:     * PUBLIC: alvo de BINDEVENT("Click") em ConfigurarBotoesAcao (Fase 4).
3026:     *==========================================================================
3027:     PROCEDURE BtnSalvarClick()
3028:         LOCAL loc_dLimiteMin, loc_dLimiteMax, loc_dData, loc_cHora
3029: 
3030:         IF !USED("TprMvCab") OR !USED("crSigCdOpe")
3031:             RETURN
3032:         ENDIF
3033: 
3034:         IF INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
3035: 
3036:             *-- Observacao obrigatoria (DigObs = 3)
3037:             IF crSigCdOpe.DigObs = 3 AND (EMPTY(TprMvCab.CodObs) OR EMPTY(TprMvCab.Obses))
3038:                 MsgAviso("Obrigat" + CHR(243) + "rio Informar " + ;
3039:                     IIF(EMPTY(TprMvCab.CodObs), "C" + CHR(243) + "digo da ", "") + ;
3040:                     "Observa" + CHR(231) + CHR(227) + "o para essa Opera" + CHR(231) + ;
3041:                     CHR(227) + "o ... ", ;
3042:                     "Observa" + CHR(231) + CHR(227) + "o " + CHR(233) + " Informa" + ;
3043:                     CHR(231) + CHR(227) + "o Obrigat" + CHR(243) + "ria")
3044:                 IF EMPTY(TprMvCab.CodObs)
3045:                     THIS.cnt_4c_Observacao.txt_4c_CodObs.SetFocus()
3046:                 ELSE
3047:                     THIS.cnt_4c_Observacao.obj_4c_GetDesObs.SetFocus()
3048:                 ENDIF
3049:                 RETURN
3050:             ENDIF
3051: 
3052:             *-- Data de Emissao obrigatoria (DtEmis = 3)
3053:             IF EMPTY(TprMvCab.DtEmis) AND crSigCdOpe.DtEmis = 3
3054:                 MsgAviso("Data de Emiss" + CHR(227) + "o do Documento precisa ser " + ;
3055:                     "informada ... ", ;
3056:                     "Data de Emiss" + CHR(227) + "o : Informa" + CHR(231) + CHR(227) + ;
3057:                     "o Obrigat" + CHR(243) + "ria")
3058:                 THIS.cnt_4c_Emiss.txt_4c_Emiss.SetFocus()
3059:                 RETURN
3060:             ENDIF
3061: 
3062:             *-- Prazo de Entrega preenchido: grava com hora + recalcula
3063:             *-- vencimentos das parcelas (xPar - cursor do form pai, falso
3064:             *-- seguro via USED() dentro de RecalcularVencimentosParcelas)
3065:             IF !EMPTY(TprMvCab.PrazoEnts)
3066:                 loc_dData = ConverterParaData(TprMvCab.PrazoEnts)
3067:                 loc_cHora = TIME(TprMvCab.PrazoEnts)
3068:                 REPLACE PrazoEnts WITH fDtoSQL(loc_dData, loc_cHora) IN TprMvCab
3069:                 THIS.cnt_4c_Entregas.txt_4c_Entregas.Refresh()
3070: 
3071:                 THIS.RecalcularVencimentosParcelas("xPar", .F.)
3072:             ENDIF
3073: 
3074:             *-- Prazo de Entrega: obrigatoriedade + faixa Minima/Maxima
3075:             IF INLIST(crSigCdOpe.DtEntrs, 1, 4, 6)
3076:                 IF EMPTY(TprMvCab.PrazoEnts)
3077:                     MsgAviso("Prazo de Entrega deve ser informado...", "")
3078:                     THIS.cnt_4c_Entregas.txt_4c_Entregas.SetFocus()
3079:                     RETURN
3080:                 ENDIF
3081: 
3082:                 IF ConverterParaData(TprMvCab.PrazoEnts) < ConverterParaData(TprMvCab.Datas)
3083:                     MsgAviso("Prazo de Entrega deve ser maior que a Data da " + ;
3084:                         "Movimenta" + CHR(231) + CHR(227) + "o...", "")
3085:                     THIS.cnt_4c_Entregas.txt_4c_Entregas.SetFocus()
3086:                     RETURN
3087:                 ENDIF
3088: 
3089:                 IF USED("CrSigOpCdc") AND CrSigOpCdc.NMinEnts > 0 AND !THIS.this_lValidOk
3090:                     loc_dLimiteMin = ConverterParaData(TprMvCab.Datas) + CrSigOpCdc.NMinEnts
3091:                     IF ConverterParaData(TprMvCab.PrazoEnts) < loc_dLimiteMin
3092:                         IF !THIS.SolicitarLiberacaoPrazoEntrega(loc_dLimiteMin, ;
3093:                                 ConverterParaData(TprMvCab.PrazoEnts), "M" + CHR(237) + "nimo")
3094:                             THIS.cnt_4c_Entregas.txt_4c_Entregas.Value = loc_dLimiteMin
3095:                             THIS.cnt_4c_Entregas.txt_4c_Entregas.SetFocus()
3096:                             RETURN
3097:                         ENDIF
3098:                     ENDIF
3099:                 ENDIF
3100: 
3101:                 IF USED("CrSigOpCdc") AND CrSigOpCdc.NMaxEnts > 0 AND !THIS.this_lValidOk
3102:                     loc_dLimiteMax = ConverterParaData(TprMvCab.Datas) + CrSigOpCdc.NMaxEnts
3103:                     IF ConverterParaData(TprMvCab.PrazoEnts) > loc_dLimiteMax
3104:                         IF !THIS.SolicitarLiberacaoPrazoEntrega(loc_dLimiteMax, ;
3105:                                 ConverterParaData(TprMvCab.PrazoEnts), "M" + CHR(225) + "ximo")
3106:                             THIS.cnt_4c_Entregas.txt_4c_Entregas.Value = loc_dLimiteMax
3107:                             THIS.cnt_4c_Entregas.txt_4c_Entregas.SetFocus()
3108:                             RETURN
3109:                         ENDIF
3110:                     ENDIF
3111:                 ENDIF
3112:             ENDIF
3113: 
3114:             *-- Data de Recepcao obrigatoria (DigRecs = 1)
3115:             IF crSigCdOpe.DigRecs = 1
3116:                 IF EMPTY(TprMvCab.DtRecs)
3117:                     MsgAviso("Data de Recep" + CHR(231) + CHR(227) + "o deve ser " + ;
3118:                         "informada ...", "")
3119:                     THIS.cnt_4c_Recepcaos.txt_4c_Recepcaos.SetFocus()
3120:                     RETURN
3121:                 ENDIF
3122:             ENDIF
3123: 
3124:             *-- Cupom Fiscal/ECF obrigatorios (CupFis = 4)
3125:             IF crSigCdOpe.CupFis = 4
3126:                 IF EMPTY(TprMvCab.Ecfs)
3127:                     MsgAviso("N" + CHR(250) + "mero do ECF Precisa Ser Informado...", "")
3128:                     THIS.cnt_4c_Ecfs.txt_4c_Ecfs.SetFocus()
3129:                     RETURN
3130:                 ENDIF
3131:                 IF EMPTY(TprMvCab.Nemps)
3132:                     MsgAviso("N" + CHR(250) + "mero de S" + CHR(233) + "rie da " + ;
3133:                         "Impressora Precisa Ser Informado...", "")
3134:                     THIS.cnt_4c_Nemps.txt_4c_Nemps.SetFocus()
3135:                     RETURN
3136:                 ENDIF
3137:             ENDIF
3138: 
3139:             *-- EditDocs = 4: numero da nota reformatado na grade de itens do
3140:             *-- movimento (crTpmMvItn) - cursor do form pai, falso seguro:
3141:             *-- sem ele (nenhum caller desta tela no acervo) fica de fora.
3142:             IF crSigCdOpe.EditDocs = 4 AND USED("crTpmMvItn")
3143:                 REPLACE ALL Notas WITH TRANSFORM(VAL(TprMvCab.Notas), "@L 999999") IN crTpmMvItn
3144:             ENDIF
3145: 
3146:         ELSE
3147:             *-- CONSULTAR com acesso ALTINFO liberado: confirma a observacao
3148:             *-- (mesmo gate de DesObsWhen, Fase 6)
3149:             IF fChecaAcesso(PADL(TRANSFORM(crSigCdOpe.nDopes), 8, "0"), "ALTINFO") ;
3150:                AND THIS.this_cPcEscolha = "CONSULTAR"
3151:                 THIS.this_oBusinessObject.this_cObses     = ALLTRIM(TprMvCab.Obses)
3152:                 THIS.this_oBusinessObject.this_cCidChaves = TprMvCab.CidChaves
3153:                 IF !THIS.this_oBusinessObject.Atualizar()
3154:                     RETURN
3155:                 ENDIF
3156:             ENDIF
3157:         ENDIF
3158: 
3159:         THIS.FecharDialogo()
3160:     ENDPROC
3161: 
3162:     *==========================================================================
3163:     * SolicitarLiberacaoPrazoEntrega - "Do Form SigOpSen With 'LIBPRZENT',
3164:     * 'Libera Prazo de Entrega' To _Retorno" do btnSelItens.Click legado,
3165:     * repetido para o limite Minimo e para o Maximo (so o rotulo/valor
3166:     * mudam):
3167:     *
3168:     *   Do Form SigOpSen With 'LIBPRZENT', 'Libera Prazo de Entrega' To _Retorno
3169:     *   llOk = ( Left( _Retorno, 1 ) = "*" )
3170:     *   lcUsuLib = Substr( _Retorno, 2 )
3171:     *   If !llOk -> Messagebox(...) / Return .f.
3172:     *   Else -> thisform.validok = .t. / fGravarLog('T', Dopes, 'LIBPRZENT', ...)

*-- Linhas 3217 a 3260:
3217:             THIS.this_lValidOk = .T.
3218:         ELSE
3219:             IF loc_lDialogoAbriu
3220:                 MsgAviso("Prazo de Entrega " + par_cRotulo + " " + CHR(233) + " " + ;
3221:                     DTOC(par_dLimite) + "...", "")
3222:             ELSE
3223:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel abrir a tela " + ;
3224:                     "de autoriza" + CHR(231) + CHR(227) + "o (SigOpSen)." + CHR(13) + ;
3225:                     "O prazo de entrega N" + CHR(195) + "O foi liberado." + CHR(13) + ;
3226:                     CHR(13) + "Detalhe: " + loc_cFalhaDialogo, "Libera Prazo de Entrega")
3227:             ENDIF
3228:         ENDIF
3229: 
3230:         RETURN loc_lAutorizado
3231:     ENDFUNC
3232: 
3233:     *==========================================================================
3234:     * RecalcularVencimentosParcelas - laco de recalculo de vencimentos do
3235:     * btnSelItens.Click legado (disparado quando o Prazo de Entrega muda):
3236:     *
3237:     *   Select xPar / Index on Fpags+cnidTefs+Str(Parcs,2) Tag FpagV / Scan
3238:     *       =CursorQuery('SigOpFp','LocalFpag','fpags',xPar.Fpags,
3239:     *           [TpVencs,Entradas,Dias,tVens])
3240:     *       If LocalFpag.TpVencs = 2
3241:     *           DVenc = (Ttod(TprMvCab.PrazoEnts) + LocalFpag.Entradas)
3242:     *           Scan While Fpags=_lcFpg And cnIdTefs=_lcIdT
3243:     *               [laco de feriados] / Replace Vencs With DVenc
3244:     *               DVenc = Iif(TVen='F', GoMonth(DVenc,1), DVenc+NDia)
3245:     *           EndScan
3246:     *           Skip -1
3247:     *       Endif
3248:     *   EndScan
3249:     *
3250:     * par_cCursor: alias do cursor de parcelas a recalcular, agrupado por
3251:     * Fpags+CnIdTefs (colunas Fpags/CnIdTefs/Parcs/Vencs/CidChaves). "xPar"
3252:     * (parcelas do lancamento corrente, BtnSalvarClick) e "LocalPar"
3253:     * (parcelas de SigMvPar no lancamento direto, ProcessarLancamentoDireto)
3254:     * usam este MESMO metodo - layout de colunas identico, so a origem
3255:     * difere. Falso seguro: sem o cursor (par_cCursor), nao ha o que
3256:     * recalcular.
3257:     *
3258:     * par_lAtualizarBanco = .T. (LocalPar) tambem grava o vencimento no SQL
3259:     * Server ("Update SigMvPar Set Vencs = ... Where CidChaves = ..."),
3260:     * como o legado faz nesse caminho; .F. (xPar) e so cursor em memoria do

*-- Linhas 3267 a 3310:
3267:     *
3268:     * PROTECTED: chamado so por BtnSalvarClick() e ProcessarLancamentoDireto().
3269:     *==========================================================================
3270:     PROTECTED PROCEDURE RecalcularVencimentosParcelas(par_cCursor, par_lAtualizarBanco)
3271:         LOCAL loc_dVenc, loc_nDias, loc_cTipoVenc, loc_cFpgAtual, loc_cIdTefAtual
3272:         LOCAL loc_cSQLFpg, loc_nErro, loc_cSQLUpdate, loc_cCidChave
3273: 
3274:         IF !USED(par_cCursor) OR !USED("TprMvCab") OR EMPTY(TprMvCab.PrazoEnts)
3275:             RETURN
3276:         ENDIF
3277: 
3278:         SELECT (par_cCursor)
3279:         INDEX ON Fpags + CnIdTefs + STR(Parcs, 2) TAG FpagV
3280:         SCAN
3281:             loc_cFpgAtual = Fpags
3282: 
3283:             IF USED("cursor_4c_FpgVenc")
3284:                 USE IN cursor_4c_FpgVenc
3285:             ENDIF
3286:             loc_cSQLFpg = "SELECT TpVencs, Entradas, Dias, tVens FROM SigOpFp " + ;
3287:                 "WHERE Fpags = " + EscaparSQL(loc_cFpgAtual)
3288:             loc_nErro   = SQLEXEC(gnConnHandle, loc_cSQLFpg, "cursor_4c_FpgVenc")
3289:             SELECT (par_cCursor)
3290: 
3291:             IF loc_nErro >= 1 AND USED("cursor_4c_FpgVenc") AND cursor_4c_FpgVenc.TpVencs = 2
3292:                 loc_dVenc       = ConverterParaData(TprMvCab.PrazoEnts) + cursor_4c_FpgVenc.Entradas
3293:                 loc_nDias       = cursor_4c_FpgVenc.Dias
3294:                 loc_cTipoVenc   = cursor_4c_FpgVenc.tVens
3295:                 loc_cFpgAtual   = Fpags
3296:                 loc_cIdTefAtual = CnIdTefs
3297: 
3298:                 SCAN WHILE Fpags = loc_cFpgAtual AND CnIdTefs = loc_cIdTefAtual
3299:                     loc_dVenc = THIS.AvancarAlemDosFeriados(loc_dVenc)
3300:                     REPLACE Vencs WITH loc_dVenc IN (par_cCursor)
3301: 
3302:                     IF par_lAtualizarBanco
3303:                         loc_cCidChave  = CidChaves
3304:                         loc_cSQLUpdate = "UPDATE SigMvPar SET Vencs = " + ;
3305:                             FormatarDataSQL(loc_dVenc) + " WHERE CidChaves = " + ;
3306:                             EscaparSQL(loc_cCidChave)
3307:                         IF SQLEXEC(gnConnHandle, loc_cSQLUpdate) < 1
3308:                             MsgErro("Favor reinicializar o processo." + CHR(13) + ;
3309:                                 "Falha na conex" + CHR(227) + "o (Update SigMvPar)", "Erro")
3310:                         ENDIF

*-- Linhas 3326 a 3369:
3326:     * ("|AAAAMMDD|..."), mesmo padrao de FormSigOpFpg.CarregarFeriados -
3327:     * evita um SELECT por parcela dentro do laco de recalculo.
3328:     *==========================================================================
3329:     PROTECTED PROCEDURE CarregarFeriados()
3330:         LOCAL loc_cSQL, loc_nResultado, loc_cLista, loc_oErro
3331: 
3332:         IF THIS.this_lFeriadosCarregados
3333:             RETURN .T.
3334:         ENDIF
3335: 
3336:         loc_cLista = "|"
3337: 
3338:         TRY
3339:             IF USED("cursor_4c_FerLoad")
3340:                 USE IN SELECT("cursor_4c_FerLoad")
3341:             ENDIF
3342: 
3343:             loc_cSQL = "SELECT DISTINCT datas FROM SigCdFer WHERE datas IS NOT NULL"
3344: 
3345:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FerLoad")
3346: 
3347:             IF loc_nResultado > 0 AND USED("cursor_4c_FerLoad")
3348:                 SELECT cursor_4c_FerLoad
3349:                 SCAN
3350:                     IF !ISNULL(datas) AND !EMPTY(datas)
3351:                         loc_cLista = loc_cLista + DTOS(ConverterParaData(datas)) + "|"
3352:                     ENDIF
3353:                 ENDSCAN
3354:                 USE IN SELECT("cursor_4c_FerLoad")
3355:             ENDIF
3356: 
3357:             THIS.this_cFeriadosCache      = loc_cLista
3358:             THIS.this_lFeriadosCarregados = .T.
3359:         CATCH TO loc_oErro
3360:             THIS.this_cFeriadosCache = "|"
3361:         ENDTRY
3362: 
3363:         RETURN .T.
3364:     ENDPROC
3365: 
3366:     *==========================================================================
3367:     * AvancarAlemDosFeriados - laco de feriados do btnSelItens.Click legado:
3368:     *
3369:     *   lnFer = 0 / Verd = .t.

*-- Linhas 3408 a 3513:
3408:     ENDFUNC
3409: 
3410:     *==========================================================================
3411:     * FecharDialogo - "PROCEDURE return" do legado:
3412:     *
3413:     *   If ThisForm.Direta
3414:     *       [ver ProcessarLancamentoDireto()]
3415:     *   Endif
3416:     *   ThisForm.parentform.enabled = .T.
3417:     *   thisform.parentform.validok = thisform.validok
3418:     *   ThisForm.parentform.pagina.dados.dados.setfocus
3419:     *   ThisForm.release
3420:     *
3421:     * "ThisForm.parentform.enabled = .T." ja acontece em Destroy()
3422:     * (ReabilitarFormPai(), Fase 3) - Release() dispara Destroy() antes de
3423:     * destruir o objeto, entao nao duplicado aqui.
3424:     *
3425:     * "ThisForm.parentform.pagina.dados.dados.setfocus" refere-se a um
3426:     * controle especifico do form pai (frmcadastro legado) sem equivalente
3427:     * conhecido nesta migracao - nenhum caller de Formsigopinf existe no
3428:     * acervo (ver cabecalho do arquivo) para definir esse equivalente.
3429:     * Omitido, documentado, nao inventado.
3430:     *
3431:     * THIS.Release() (nao Hide()): esta classe NAO isola DataSession (fica
3432:     * no default = 1, ver comentario de cabecalho "DataSession") - ao
3433:     * contrario de FormSigOpFpg (DataSession = 2), nao ha razao para
3434:     * sobreviver ao fechamento, e Release() e transcricao fiel do
3435:     * "ThisForm.release" legado.
3436:     *
3437:     * PUBLIC: alvo de chamada de BtnSalvarClick() (fim de cada ramo) e do
3438:     * form pai, se precisar fechar o dialogo por codigo.
3439:     *==========================================================================
3440:     PROCEDURE FecharDialogo()
3441:         THIS.ProcessarLancamentoDireto()
3442: 
3443:         IF VARTYPE(THIS.this_oFormPai) = "O" ;
3444:            AND PEMSTATUS(THIS.this_oFormPai, "this_lValidOk", 5)
3445:             THIS.this_oFormPai.this_lValidOk = THIS.this_lValidOk
3446:         ENDIF
3447: 
3448:         THIS.Release()
3449:     ENDPROC
3450: 
3451:     *==========================================================================
3452:     * ProcessarLancamentoDireto - ramo "If ThisForm.Direta" do "PROCEDURE
3453:     * return" legado:
3454:     *
3455:     *   Select CrSigMvCab / Zap / Select TprMvCab / Scatter Memvar memo /
3456:     *   Select CrSigMvCab / Append Blank / Gather Memvar Memo
3457:     *   lcSql = Select a.*, b.TpVencs,b.Entradas,b.dias,b.tVens From SigMvPar a,
3458:     *       SigOpFp b where a.EmpDopNums = <TprMvCab.EmpDopNums> And a.Fpags = b.fpags
3459:     *   Select LocalPar / Index on Fpags+cnidTefs+Str(Parcs,2) Tag FpagV / Scan
3460:     *       [recalculo de vencimentos + Update SigMvPar - ver
3461:     *        RecalcularVencimentosParcelas]
3462:     *   EndScan
3463:     *   llOk = UpDate('CrSigMvCab') And Commit() > 0 / If !llOk -> RollBack()
3464:     *   Select TprMvCab / Zap
3465:     *
3466:     * CrSigMvCab (cursor de BATCH do lancamento direto) e o commit em lote
3467:     * (ThisForm.ParentForm.PoDataMgr.UpDate/Commit/RollBack) pertencem ao
3468:     * form PAI/orquestrador da operacao, inexistente nesta migracao (nenhum
3469:     * caller de Formsigopinf no acervo - ver cabecalho do arquivo). Falso
3470:     * seguro: sem CrSigMvCab, o bloco INTEIRO fica de fora - inclusive o
3471:     * recalculo de SigMvPar (que so faz sentido acoplado ao commit em lote)
3472:     * e o "Select TprMvCab / Zap" final, que SEM o lote persistido em outro
3473:     * lugar destruiria os dados do usuario (regra CLAUDE.md #17 - nao
3474:     * reproduzir so a metade de uma formula/fluxo que depende do resto).
3475:     *
3476:     * PROTECTED: so FecharDialogo(), desta mesma classe, chama.
3477:     *==========================================================================
3478:     PROTECTED PROCEDURE ProcessarLancamentoDireto()
3479:         LOCAL loc_cSQL, loc_nErro
3480: 
3481:         IF !THIS.this_lDireta OR !USED("CrSigMvCab") OR !USED("TprMvCab")
3482:             RETURN
3483:         ENDIF
3484: 
3485:         IF EMPTY(TprMvCab.EmpDopNums)
3486:             RETURN
3487:         ENDIF
3488: 
3489:         IF USED("LocalPar")
3490:             USE IN LocalPar
3491:         ENDIF
3492:         loc_cSQL = "SELECT a.*, b.TpVencs, b.Entradas, b.Dias, b.tVens " + ;
3493:             "FROM SigMvPar a, SigOpFp b " + ;
3494:             "WHERE a.EmpDopNums = " + EscaparSQL(TprMvCab.EmpDopNums) + " " + ;
3495:             "AND a.Fpags = b.Fpags"
3496:         loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "LocalPar")
3497:         IF loc_nErro < 1
3498:             MsgErro("Favor reinicializar o processo." + CHR(13) + ;
3499:                 "Falha na conex" + CHR(227) + "o ( LocalPar )", "Erro")
3500:             RETURN
3501:         ENDIF
3502: 
3503:         THIS.RecalcularVencimentosParcelas("LocalPar", .T.)
3504: 
3505:         IF USED("LocalPar")
3506:             USE IN LocalPar
3507:         ENDIF
3508: 
3509:         *-- Commit em lote (CrSigMvCab) fora do escopo desta migracao - ver
3510:         *-- comentario de cabecalho do metodo.
3511:     ENDPROC
3512: 
3513: ENDDEFINE


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

