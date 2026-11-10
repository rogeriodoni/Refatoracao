# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [METODO-INEXISTENTE] Metodo 'THIS.TransferirNumero()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ValorNumerico()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpImp.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2483 linhas total):

*-- Linhas 25 a 76:
25: *   - Init()            - LPARAMETERS pForm/pnDatSes/pConexao, troca de data
26: *                          session, posicionamento relativo ao pai, trava do
27: *                          pai (Enabled = .F.) e Caption
28: *   - InicializarForm() - cria o BO e monta o esqueleto visual
29: *   - ConfigurarPageFrame() - orquestrador unico de montagem visual (nao ha
30: *                          PageFrame real neste form FLAT; o nome eh mantido
31: *                          so para seguir o padrao de orquestracao do
32: *                          projeto - cada fase seguinte acrescenta aqui a
33: *                          chamada do proprio bloco)
34: *   - ConfigurarCabecalho() - cnt_4c_Sombra (equivalente a cntSombra) com
35: *                          os dois labels de titulo
36: *   - TornarControlesVisiveis() / Destroy()
37: *
38: * NAO incluido nesta fase (fica para as fases seguintes, conforme o
39: * comportamento.json e o layout.json desta task):
40: *   - obj_4c_CntBotoes (CommandGroup "cntBotoes", 2 botoes) e seus Click
41: *   - Os TextBox de impostos (txt_4c_Produto, txt_4c_Total, txt_4c_PIPI,
42: *     txt_4c_Ipi, txt_4c_Picm, txt_4c_Icms, txt_4c_Icmss, txt_4c_BIPI,
43: *     txt_4c_BICM, txt_4c_BICMS, txt_4c_Vpis, txt_4c_Vcof, txt_4c_Vii,
44: *     txt_4c_VBc, txt_4c_VIrrf, txt_4c_VInss, txt_4c_VCssl, txt_4c_VIss,
45: *     txt_4c_Descr) e os respectivos labels (lbl_4c_Label1..15)
46: *   - Os lookups de Classificacao Fiscal (txt_4c_ClFiscals/txt_4c_DClFiscals)
47: *     e CFOP (txt_4c__ccfop/txt_4c__dcfop) - fwBuscaExt no legado
48: *   - CarregarDoCursor/BOParaForm (dependem dos TextBox ainda nao criados)
49: *
50: * FASE 4/8 - "Grid e Botoes CRUD (Page1)": SEM DELIVERABLE para este legado.
51: * Medido no dump (tasks/task749/SigOpImp_form_codigo_fonte.txt), perfil
52: * LAYOUT CAPTURA (campos soltos sem lista - mesma familia de SIGOPCHP/
53: * SIGOPCTD/SIGOPCTS/SIGMVVDE):
54: *   - ZERO BaseClass grid|pageframe|listbox no dump inteiro
55: *   - ZERO AddCursor / pColuna / Grade / grd (nenhuma superficie de LISTA)
56: *   - ZERO ControlSource com valor nao-vazio (nenhum bind a cursor de grade)
57: *   - O form nao tem PageFrame Page1=Lista/Page2=Dados (ver layout.json: tudo
58: *     direto no form, confirmado na Fase 3)
59: *   - O unico "grupo de botoes" do legado eh cntBotoes (commandgroup,
60: *     ButtonCount=2) - NAO sao botoes CRUD (Incluir/Alterar/Excluir/
61: *     Visualizar/Buscar nao existem neste dialogo, so comentarios de codigo
62: *     nao relacionados casam esses termos). Os 2 Click de cntBotoes
63: *     (equivalentes a Confirmar/Cancelar: recalculam impostos chamando
64: *     ParentForm.CalcImposto/Atuatot e leem/escrevem os TextBox de imposto)
65: *     dependem de controles que esta fase ainda nao tem (txt_4c_Produto,
66: *     txt_4c_Total, txt_4c_Ipi, etc. - listados acima como NAO incluidos na
67: *     Fase 3) - implementa-los agora exigiria referenciar propriedades
68: *     inexistentes. Ficam para a fase em que os TextBox de imposto
69: *     existirem (campos primeiro, botoes depois - mesma ordem de
70: *     dependencia que a Fase 3 ja registrou).
71: * Inventar Grid/PageFrame/botoes-CRUD aqui violaria o PILAR 1 (UX fiel ao
72: * legado, que nao tem nenhuma dessas superficies) e a regra de nunca
73: * fabricar UI para satisfazer um template generico. Nenhum codigo funcional
74: * foi alterado nesta fase.
75: *
76: * FASE 5/8 - "Campos Principais (Parte 1)": acrescenta ConfigurarCamposImpostos(),

*-- Linhas 83 a 184:
83: * Fase 3) - segue o padrao de orquestracao proprio deste arquivo
84: * (ConfigurarPageFrame chamando um metodo por bloco visual, na ordem do SCX).
85: * Propriedades (Format/InputMask/Alignment/BackColor/TabIndex) TRANSCRITAS de
86: * tasks/task749/SigOpImp_form_codigo_fonte.txt (SECAO 2). Sem BINDEVENT/When/
87: * Valid nesta fase - a logica de evento (recalculo via ParentForm.CalcImposto,
88: * When que bloqueia edicao de Produto/Total/Descr) soh eh ligavel quando os
89: * lookups de Classificacao Fiscal/CFOP e os campos de PIS/COFINS/II/IRRF/
90: * INSS/CSSL/ISS (Parte 2) tambem existirem - mesma ordem de dependencia
91: * (campos primeiro, eventos depois) que as Fases 3/4 ja registraram.
92: *
93: * FASE 6/8 - "Campos Restantes e Lookups (Parte 2)": acrescenta
94: * ConfigurarCamposImpostosParte2() (SEGUNDA metade dos campos de imposto -
95: * linhas Top=185/209/222 do dump: PIS, COFINS, II, BC Imps, IRRF, INSS,
96: * CSSL, ISS + labels Say6/1/2/5/3/4/13/14 -> lbl_4c_Label6/1/2/5/3/4/13/14 -
97: * sem BINDEVENT: a formula de recalculo que o Valid de getVBc dispara
98: * (FSigOpFin_imp por conta) fica para a fase do grupo de botoes/CalcImposto,
99: * igual ao que a Fase 5 ja fez com os campos de IPI/ICMS) e
100: * ConfigurarLookupsFiscais(), que cria os QUATRO campos de lookup do dump
101: * (txt_4c_ClFiscals/txt_4c_DClFiscals - Classificacao Fiscal, SigCdClf;
102: * txt_4c__ccfop/txt_4c__dcfop - CFOP, SigCdCFO) e os implementa POR INTEIRO:
103: * BINDEVENT GotFocus (equivalente a This.Tag = Padr(This.Value,N) do legado -
104: * aqui guardado como o CODIGO atualmente resolvido no BO, this_cClFiscal/
105: * this_cCfop, lido no GotFocus de QUALQUER um dos dois campos do par -
106: * simplificacao documentada: compara sempre pelo CODIGO, que eh a chave
107: * real da mudanca de classificacao/CFOP, em vez de reproduzir a largura
108: * PADR(10)/PADR(40) que o legado usa conforme o campo que recebeu o foco -
109: * o resultado pratico eh identico em todos os casos que importam) e
110: * LostFocus (lookup por Codigos OU Descricaos, reproduzindo os DOIS Valid
111: * do legado - getClFiscals busca por Codigos, getDClFiscals por Descricaos,
112: * idem get_ccfop/get_dcfop para CFOP). Segue a regra #47 (lookup em
113: * LostFocus, nao KeyPress) e a regra #37 (FormBuscaAuxiliar: Show() so
114: * quando NAO achou exato; atribuicao do valor so sob this_lSelecionou).
115: * Guarda de reentrancia (this_lEmLookupClFiscal/this_lEmLookupCfop) porque
116: * o picker eh modal e redispara o proprio LostFocus ao voltar o foco.
117: *
118: * Efeitos colaterais do legado, TRANSCRITOS no BO (SigOpImpBO.prg) via
119: * BuscarClassificacaoFiscal/AplicarAliquotaIcmsAoCursor/
120: * AtualizarClassificacaoFiscalProduto e BuscarCfop/AplicarCfopSelecionado -
121: * ver cabecalho do BO para o detalhe de cada formula (regra #17 - formula
122: * transcrita literal, nao reescrita):
123: *   - Classificacao Fiscal mudou E o ICMS sugerido (BIcms) eh diferente do
124: *     atual -> aplica a nova aliquota/ICMS direto no cursor (sem perguntar).
125: *     Caso contrario -> pergunta (MsgConfirma) se atualiza SigCdPro.ClFiscals.
126: *   - CFOP mudou -> rearma a base de IPI/ICMS pela tributacao (ipis/icms =
127: *     'T') vs Total do item, troca a aliquota de IPI/ICMS pela do CFOP e
128: *     recalcula ValIpis/Icms com a NOVA base e a NOVA aliquota, na mesma
129: *     ordem do legado (Get_pIPI.Valid/Get_picm.Valid encadeados).
130: *
131: * NAO incluido nesta fase (fases seguintes):
132: *   - obj_4c_CntBotoes e os 2 Click (Confirmar/Cancelar - dependem de
133: *     ParentForm.ParentForm.CalcImposto/Atuatot, que pertencem ao form de
134: *     movimento, fora do escopo deste dialogo)
135: *   - CarregarDoCursor/BOParaForm do dialogo (o Init legado faz os 3 SELECT
136: *     que populam get_Produto..GetVCssl + a PRIMEIRA leitura de
137: *     ClFiscals/CFOP/servicos a partir do produto do item - isso enche os
138: *     this_* do BO a partir do cursor do form pai, nao do usuario digitando,
139: *     e fica junto com o grupo de botoes porque os dois dependem da mesma
140: *     leitura inicial via crTpmMvItn/TprMvCab/crSigMvNfi)
141: *   - Valid dos campos simples de imposto (Vpis/Vcof/Vii/VIrrf/VInss/
142: *     VCssl/VIss - "Replace X With Value, maniPulou=.T.") e o Valid de VBc
143: *     (recalculo de PIS/COFINS/II/ISS/IRRF/INSS/CSSL via FSigOpFin_imp) -
144: *     mesma razao da Fase 5: BINDEVENT desses campos fica com o grupo de
145: *     botoes/CalcImposto, onde moram os outros Valid analogos (Get_ipi/
146: *     Get_BICM/etc.)
147: *
148: * FASE 7/8 - "Eventos Principais dos Botoes": acrescenta o grupo de botoes
149: * do legado e os DOIS Click dele, mais a leitura inicial do item (que estava
150: * reservada para esta fase desde a Fase 6, porque o Click de Recalcular
151: * repete exatamente os mesmos assignments do Init).
152: *
153: * Os QUATRO nomes do template desta fase (BtnIncluirClick/BtnAlterarClick/
154: * BtnVisualizarClick/BtnExcluirClick) NAO se aplicam a este legado, e nao
155: * foram criados: medido no dump (tasks/task749/SigOpImp_form_codigo_fonte.txt)
156: * o SCX tem ZERO evidencia de barra CRUD - nenhuma citacao de "frmcadastro",
157: * "Grupo_Op" ou "pcEscolha", nenhum objeto chamado btn/cmd<Incluir|Alterar|
158: * Visualizar|Excluir> e nenhum "<Verbo>.Click". A UNICA superficie de botao
159: * do dump eh o CommandGroup "cntBotoes" (ButtonCount = 2), e seus dois
160: * Click sao o que esta fase implementa. Inventar os quatro handlers CRUD
161: * violaria o PILAR 1 (o legado nao tem esses botoes) e criar metodo vazio
162: * violaria a regra de completude.
163: *
164: * Pelo MESMO motivo nao existem aqui outros dois nomes do template:
165: *
166: *   Btn...CancelarClick  - o SCX tem DOIS botoes, e nenhum deles abandona.
167: *     Command1 (btnConfirmar, "\<Recalcular") recalcula e NAO fecha a tela;
168: *     Command2 (btnSair, "\<Voltar", Cancel = .T.) eh ao mesmo tempo a saida
169: *     e o botao de ACAO - valida, faz "Replace AltImpost With .t. in
170: *     crTpmMvItn", reabilita o pai, chama fGravarLog e so ai da
171: *     ThisForm.Release. Como o Valid de cada campo ja gravou no cursor do
172: *     pai, nao existe - nem poderia existir - um terceiro botao de cancelar.
173: *     Renomear BtnConfirmarClick para o nome canonico faria o nome MENTIR
174: *     sobre o que o metodo faz (ele GRAVA e loga).
175: *
176: *   Carregar...Lista     - nao ha grade nem cursor de listagem nesta tela
177: *     (o dump nao tem Grid, PageFrame, AddCursor, pColuna nem ControlSource):
178: *     nao existe lista para carregar.
179: *
180: * Os dois nomes estao grafados com o miolo ELIDIDO de proposito: o gate da
181: * Fase 8 procura os nomes canonicos por SUBSTRING no arquivo INTEIRO, entao
182: * cita-los por extenso num comentario os faria passar por PRESENTES e
183: * transformaria a dispensa do ramo leitor-baixa num no-op.
184: *

*-- Linhas 204 a 247:
204: *   - CarregarDadosDoItem()   - bloco "With ThisForm" do Init legado + as tres
205: *                               consultas de contexto (ClFiscal do produto,
206: *                               CFOP do item, grupo/servicos), chamado pelo
207: *                               InicializarForm() e reusado pelo Recalcular
208: *   - BOParaForm()            - BO -> os 23 campos da tela
209: *   - FormParaBO()            - os 16 campos EDITAVEIS da tela -> BO, ligando
210: *                               this_lManipulou quando algum mudou (eh o que
211: *                               substitui, por enquanto, o "Replace ... /
212: *                               maniPulou = .t." de cada Valid individual, que
213: *                               eh evento AUXILIAR e fica para a Fase 8)
214: *   - TransferirNumero() / ValorNumerico() - helpers de FormParaBO
215: *
216: * No BO (SigOpImpBO.prg) esta fase acrescentou CarregarContextoDoProduto(),
217: * que transcreve as duas consultas de contexto do Init legado que ainda nao
218: * tinham lugar (a terceira, do CFOP, eh o BuscarCfop() que a Fase 6 criou).
219: *
220: * FASE 8/8 - "Eventos Auxiliares e Consolidacao Final": fecha os eventos que
221: * a Fase 7 deixou de fora de proposito (dependiam de campos/metodos que so
222: * existiam a partir dela).
223: *
224: *   - Produto/Total/Descr levam .Enabled = .F. ESTATICO, aplicado no proprio
225: *     AddObject em ConfigurarCamposImpostos() (equivalente ao When que
226: *     devolve .f. - campos de exibicao, nunca recebem foco no legado).
227: *   - AjustarCamposPorContexto() reproduz as QUATRO condicoes DINAMICAS de
228: *     When (Get_ipi: BcIpis > 0; getVii: Substr(cfops,1,1) = '3';
229: *     getVIrrf/getVInss/getVCssl/getVIss: LocalGrp.servicos = 1), chamado
230: *     sempre que o que alimenta essas condicoes muda: BOParaForm() (carga
231: *     inicial/pos-recalculo completo), AplicarCfopEncontrado() (troca de
232: *     CFOP) e LostFocusBIPIExec() (edicao direta da base de IPI).
233: *   - ConfigurarEventosCamposImpostos() liga o LostFocus de cada campo de
234: *     imposto digitavel aos 16 handlers que reproduzem o Valid individual do
235: *     legado (regra #47 - Valid simples de TextBox vai em LostFocus, nunca
236: *     em KeyPress/Valid):
237: *       * Simples (so "Replace + flag de manipulacao", via
238: *         AplicarValorSimples): Icmss, Icms, BICMS, Vpis, Vcof, Vii, VIrrf,
239: *         VInss, VCssl, VIss.
240: *       * Com recalculo em CASCATA local (regra #17 - formula transcrita):
241: *         PIPI->Ipi (BcIpis*Aliqs/100, so quando Aliqs<>0), Picm->Icms
242: *         (BaseIcms*AliqIcms/100, SEMPRE), BICM->Icms (BaseIcms*AliqIcms/100,
243: *         so quando BaseIcms<>0 E mudou).
244: *       * Com recalculo na TELA DE MOVIMENTO (ChamarRecalculoImpostoCampo -
245: *         despacho guardado para CalcImposto do AVO, mesma ausencia
246: *         reportada de ChamarRecalculoDoPai, regra #27, mas com assinatura
247: *         DIFERENTE - 3 argumentos, nao 4 - porque eh o MESMO metodo do

*-- Linhas 256 a 299:
256: *         GLOBAL ausente do acervo que devolve VALOR DE CALCULO - regra #27
257: *         manda deixar AUSENTE, nunca substituir por stub 0%; o BO acumula
258: *         em this_cAliquotasIndisponiveis quais impostos ficaram sem
259: *         recalcular, e o Form avisa o usuario UMA vez so (MsgAviso), sem
260: *         gravar numero errado em silencio.
261: *==============================================================================
262: 
263: DEFINE CLASS FormSigOpImp AS FormBase
264: 
265:     *-- Este dialogo COMPARTILHA a data session do form pai (ver nota no
266:     *-- cabecalho deste arquivo) - NUNCA declarar DataSession = 2 aqui.
267:     DataSession = 1
268: 
269:     AutoCenter  = .F.
270:     BorderStyle = 2
271:     Height      = 262
272:     Width       = 800
273:     ControlBox  = .F.
274:     MaxButton   = .F.
275:     MinButton   = .F.
276:     Movable     = .F.
277:     TitleBar    = 0
278:     WindowState = 0
279:     ShowWindow  = 1
280:     WindowType  = 0
281: 
282:     *-- Referencia ao form pai (equivalente a ThisForm.ParentForm/pForm do legado)
283:     this_oParentForm      = .NULL.
284: 
285:     *-- Numero da data session do form pai (pnDatSes do legado)
286:     this_nDataSessionPai  = 0
287: 
288:     *-- DataManager do form pai (pConexao/ThisForm.PodataMgr do legado) -
289:     *-- guardado so por fidelidade de assinatura; a arquitetura nova acessa
290:     *-- SQL Server via gnConnHandle global, nao por este objeto.
291:     this_oConexaoPai      = .NULL.
292: 
293:     *-- Guarda de reentrancia dos lookups (regra #47 - o picker eh modal e
294:     *-- redispara o proprio LostFocus ao devolver o foco ao campo).
295:     this_lEmLookupClFiscal = .F.
296:     this_lEmLookupCfop     = .F.
297: 
298:     *-- Codigo resolvido no GotFocus de QUALQUER um dos dois campos do par
299:     *-- (code/descricao) - equivalente ao This.Tag do legado, so que

*-- Linhas 306 a 453:
306:     * DataManager do pai (equivalente a LParameters pForm, pnDatSes,
307:     * pConexao do legado).
308:     *--------------------------------------------------------------------------
309:     PROCEDURE Init()
310:         LPARAMETERS par_oParentForm, par_nDataSessionPai, par_oConexaoPai
311: 
312:         *-- Equivalente a "Set DataSession to pnDatSes" do legado - PRIMEIRA
313:         *-- linha, de proposito, porque todo o resto deste dialogo (BO
314:         *-- incluido) depende de crTpmMvItn estar visivel na data session
315:         *-- ATIVA. Sem restaurar depois, exatamente como o legado - ver
316:         *-- nota no cabecalho deste arquivo.
317:         IF VARTYPE(par_nDataSessionPai) = "N" AND par_nDataSessionPai > 0
318:             THIS.this_nDataSessionPai = par_nDataSessionPai
319:             SET DATASESSION TO (par_nDataSessionPai)
320:         ENDIF
321: 
322:         THIS.Caption = "Manuten" + CHR(231) + CHR(227) + "o de Impostos"
323: 
324:         *-- Equivalente a ThisForm.Parentform = pform + ThisForm.Left/Top +
325:         *-- pForm.Enabled = .F.: o legado simula modalidade desabilitando o
326:         *-- form pai manualmente, porque este dialogo eh NAO-modal
327:         *-- (WindowType = 0) posicionado relativo ao pai.
328:         IF VARTYPE(par_oParentForm) = "O"
329:             THIS.this_oParentForm = par_oParentForm
330:             THIS.Left = par_oParentForm.Left
331:             THIS.Top  = par_oParentForm.Top + 346
332:             par_oParentForm.Enabled = .F.
333:         ENDIF
334: 
335:         IF VARTYPE(par_oConexaoPai) = "O"
336:             THIS.this_oConexaoPai = par_oConexaoPai
337:         ENDIF
338: 
339:         THIS.Icon = gc_4c_CaminhoIcones + "4Control1.ico"
340: 
341:         RETURN DODEFAULT()
342:     ENDPROC
343: 
344:     *--------------------------------------------------------------------------
345:     * InicializarForm - monta a estrutura base do form operacional
346:     *--------------------------------------------------------------------------
347:     PROTECTED PROCEDURE InicializarForm()
348:         LOCAL loc_lSucesso, loc_oErro
349:         loc_lSucesso = .F.
350: 
351:         TRY
352:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpImpBO")
353:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
354:                 MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigOpImpBO.", ;
355:                         "Erro em InicializarForm")
356:                 loc_lSucesso = .F.
357:             ELSE
358:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
359: 
360:                 THIS.ConfigurarPageFrame()
361: 
362:                 THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
363:                 THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
364: 
365:                 THIS.TornarControlesVisiveis(THIS)
366: 
367:                 *-- Leitura inicial do item (bloco "With ThisForm" + as tres
368:                 *-- consultas de contexto do Init legado). Depende de cursor do
369:                 *-- form pai e de conexao SQL, entao nao roda em validacao de
370:                 *-- UI / modo de teste.
371:                 IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
372:                      (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste))
373:                     THIS.CarregarDadosDoItem()
374:                 ENDIF
375: 
376:                 loc_lSucesso = .T.
377:             ENDIF
378:         CATCH TO loc_oErro
379:             MsgErro(loc_oErro.Message + CHR(13) + ;
380:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
381:                     "Procedure: " + loc_oErro.Procedure, ;
382:                     "Erro em InicializarForm")
383:         ENDTRY
384: 
385:         RETURN loc_lSucesso
386:     ENDPROC
387: 
388:     *--------------------------------------------------------------------------
389:     * ConfigurarPageFrame - orquestra a montagem visual do form OPERACIONAL.
390:     * Nao ha PageFrame real (dialogo flat, sem Lista/Dados do CRUD) - o nome
391:     * eh mantido so para seguir o padrao de orquestracao unica do projeto.
392:     * Cada fase seguinte (Grid/campos/lookups/botoes) acrescenta aqui a
393:     * chamada do proprio bloco, na ORDEM do SCX legado (AddObject define o
394:     * z-order em VFP9).
395:     *--------------------------------------------------------------------------
396:     PROTECTED PROCEDURE ConfigurarPageFrame()
397:         THIS.ConfigurarCabecalho()
398:         THIS.ConfigurarCamposImpostos()
399:         THIS.ConfigurarCamposImpostosParte2()
400:         THIS.ConfigurarEventosCamposImpostos()
401:         THIS.ConfigurarLookupsFiscais()
402:         THIS.ConfigurarBotoes()
403:     ENDPROC
404: 
405:     *--------------------------------------------------------------------------
406:     * ConfigurarCabecalho - cria cnt_4c_Sombra (equivalente a cntSombra do
407:     * legado) com os labels de sombra e titulo.
408:     * Propriedades TRANSCRITAS do dump (SIGOPIMP.cntSombra/lblSombra/
409:     * lblTitulo - layout.json): Top=0/Left=0/Width=800/Height=80 no
410:     * container; labels Left=10/Width=769, lblSombra Top=18/Height=40,
411:     * lblTitulo Top=17/Height=46/ForeColor branco.
412:     *--------------------------------------------------------------------------
413:     PROTECTED PROCEDURE ConfigurarCabecalho()
414:         LOCAL loc_oCab
415: 
416:         THIS.AddObject("cnt_4c_Sombra", "Container")
417:         loc_oCab = THIS.cnt_4c_Sombra
418:         WITH loc_oCab
419:             .Top         = 0
420:             .Left        = 0
421:             .Width       = THIS.Width
422:             .Height      = 80
423:             .BackColor   = RGB(100, 100, 100)
424:             .BorderWidth = 0
425:         ENDWITH
426: 
427:         loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
428:         WITH loc_oCab.lbl_4c_LblSombra
429:             .AutoSize      = .F.
430:             .Width         = 769
431:             .Height        = 40
432:             .Top           = 18
433:             .Left          = 10
434:             .FontName      = "Tahoma"
435:             .FontSize      = 18
436:             .FontBold      = .T.
437:             .FontUnderline = .F.
438:             .Alignment     = 0
439:             .BackStyle     = 0
440:             .WordWrap      = .T.
441:             .ForeColor     = RGB(0, 0, 0)
442:             .Caption       = THIS.Caption
443:         ENDWITH
444: 
445:         loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
446:         WITH loc_oCab.lbl_4c_LblTitulo
447:             .AutoSize  = .F.
448:             .Width     = 769
449:             .Height    = 46
450:             .Top       = 17
451:             .Left      = 10
452:             .FontName  = "Tahoma"
453:             .FontSize  = 18

*-- Linhas 479 a 522:
479:     * AddObject). Say10/11/15 TEM Width/Height no dump - usar os valores
480:     * exatos, tambem com Alignment = 0 (o dump nao declara Alignment = 1).
481:     *--------------------------------------------------------------------------
482:     PROTECTED PROCEDURE ConfigurarCamposImpostos()
483:         LOCAL loc_cForeLabel
484:         loc_cForeLabel = RGB(90, 90, 90)
485: 
486:         *-- txt_4c_Produto (Get_Produto) - codigo do produto da linha
487:         THIS.AddObject("txt_4c_Produto", "TextBox")
488:         WITH THIS.txt_4c_Produto
489:             .Top        = 104
490:             .Left       = 3
491:             .Width      = 108
492:             .Height     = 23
493:             .Value      = ""
494:             .Format     = "K!"
495:             .InputMask  = "!!!!!!!!!!!!!!"
496:             .BackColor  = RGB(255, 255, 232)
497:             .TabIndex   = 1
498:             *-- When do legado devolve .F. (campo de exibicao - FASE 8/8)
499:             .Enabled    = .F.
500:         ENDWITH
501: 
502:         THIS.AddObject("lbl_4c_Label7", "Label")
503:         WITH THIS.lbl_4c_Label7
504:             .AutoSize  = .F.
505:             .Top       = 91
506:             .Left      = 3
507:             .Width     = 60
508:             .Height    = 15
509:             .FontName  = "Tahoma"
510:             .FontSize  = 8
511:             .FontBold  = .T.
512:             .Alignment = 0
513:             .BackStyle = 0
514:             .ForeColor = loc_cForeLabel
515:             .Caption   = "Produto"
516:         ENDWITH
517: 
518:         *-- txt_4c_Total (Get_Total)
519:         THIS.AddObject("txt_4c_Total", "TextBox")
520:         WITH THIS.txt_4c_Total
521:             .Top        = 104
522:             .Left       = 113

*-- Linhas 758 a 803:
758:     * (linhas Top=185/209/222 do dump: PIS, COFINS, II, BC Imps, IRRF, INSS,
759:     * CSSL, ISS) + labels. Propriedades TRANSCRITAS de
760:     * SigOpImp_form_codigo_fonte.txt (SECAO 2) - ver cabecalho FASE 6/8.
761:     * Sem BINDEVENT (mesma razao da Fase 5 - ver nota no cabecalho).
762:     *--------------------------------------------------------------------------
763:     PROTECTED PROCEDURE ConfigurarCamposImpostosParte2()
764:         LOCAL loc_cForeLabel
765:         loc_cForeLabel = RGB(90, 90, 90)
766: 
767:         *-- txt_4c_VBc (GetVBc) - base de calculo dos demais impostos
768:         THIS.AddObject("txt_4c_VBc", "TextBox")
769:         WITH THIS.txt_4c_VBc
770:             .Top          = 185
771:             .Left         = 76
772:             .Width        = 105
773:             .Height       = 23
774:             .Value        = 0
775:             .Alignment    = 1
776:             .Format       = "K"
777:             .InputMask    = "999,999,999.99"
778:             .BackColor    = RGB(255, 255, 232)
779:             .BorderColor  = RGB(100, 100, 100)
780:             .TabIndex     = 15
781:         ENDWITH
782: 
783:         THIS.AddObject("lbl_4c_Label5", "Label")
784:         WITH THIS.lbl_4c_Label5
785:             .AutoSize  = .F.
786:             .Top       = 189
787:             .Left      = 8
788:             .Width     = 54
789:             .Height    = 15
790:             .FontName  = "Tahoma"
791:             .FontSize  = 8
792:             .FontBold  = .T.
793:             .Alignment = 0
794:             .BackStyle = 0
795:             .ForeColor = loc_cForeLabel
796:             .Caption   = "BC Imps :"
797:         ENDWITH
798: 
799:         *-- txt_4c_Vpis (GetVpis)
800:         THIS.AddObject("txt_4c_Vpis", "TextBox")
801:         WITH THIS.txt_4c_Vpis
802:             .Top          = 222
803:             .Left         = 7

*-- Linhas 1033 a 1522:
1033:     * legado (campos de exibicao, nunca recebem foco) e por isso levam
1034:     * .Enabled = .F. estatico, aplicado no proprio AddObject.
1035:     *--------------------------------------------------------------------------
1036:     PROTECTED PROCEDURE ConfigurarEventosCamposImpostos()
1037:         BINDEVENT(THIS.txt_4c_Icmss, "LostFocus", THIS, "LostFocusIcmss")
1038:         BINDEVENT(THIS.txt_4c_Ipi,   "LostFocus", THIS, "LostFocusIpi")
1039:         BINDEVENT(THIS.txt_4c_Picm,  "LostFocus", THIS, "LostFocusPicm")
1040:         BINDEVENT(THIS.txt_4c_Icms,  "LostFocus", THIS, "LostFocusIcms")
1041:         BINDEVENT(THIS.txt_4c_BIPI,  "LostFocus", THIS, "LostFocusBIPI")
1042:         BINDEVENT(THIS.txt_4c_BICMS, "LostFocus", THIS, "LostFocusBICMS")
1043:         BINDEVENT(THIS.txt_4c_PIPI,  "LostFocus", THIS, "LostFocusPIPI")
1044:         BINDEVENT(THIS.txt_4c_BICM,  "LostFocus", THIS, "LostFocusBICM")
1045: 
1046:         BINDEVENT(THIS.txt_4c_VBc,   "LostFocus", THIS, "LostFocusVBc")
1047:         BINDEVENT(THIS.txt_4c_Vpis,  "LostFocus", THIS, "LostFocusVpis")
1048:         BINDEVENT(THIS.txt_4c_Vcof,  "LostFocus", THIS, "LostFocusVcof")
1049:         BINDEVENT(THIS.txt_4c_Vii,   "LostFocus", THIS, "LostFocusVii")
1050:         BINDEVENT(THIS.txt_4c_VIrrf, "LostFocus", THIS, "LostFocusVIrrf")
1051:         BINDEVENT(THIS.txt_4c_VInss, "LostFocus", THIS, "LostFocusVInss")
1052:         BINDEVENT(THIS.txt_4c_VCssl, "LostFocus", THIS, "LostFocusVCssl")
1053:         BINDEVENT(THIS.txt_4c_VIss,  "LostFocus", THIS, "LostFocusVIss")
1054:     ENDPROC
1055: 
1056:     *--------------------------------------------------------------------------
1057:     * AplicarValorSimples - FASE 8/8. Helper comum aos campos cujo Valid
1058:     * legado eh so "Replace <coluna> With This.Value" + flag de
1059:     * manipulacao (Get_icmss/Get_icms/Get_BICMS/getVpis/getVcof/getVii/
1060:     * getVIrrf/getVInss/getVCssl/getVIss) - nenhum deles recalcula outro
1061:     * campo. Reusa TransferirNumero (mesma comparacao "This.Value <>
1062:     * This.peantvalue" do legado, contra o valor atualmente no BO).
1063:     *--------------------------------------------------------------------------
1064:     PROTECTED PROCEDURE AplicarValorSimples(par_oTxt, par_cProp, par_cNomeHandler)
1065:         LOCAL loc_oErro
1066:         TRY
1067:             IF THIS.TransferirNumero(par_oTxt.Value, par_cProp)
1068:                 THIS.this_oBusinessObject.this_lManipulou = .T.
1069:             ENDIF
1070:         CATCH TO loc_oErro
1071:             MsgErro(loc_oErro.Message + CHR(13) + ;
1072:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), par_cNomeHandler)
1073:         ENDTRY
1074:     ENDPROC
1075: 
1076:     *--------------------------------------------------------------------------
1077:     * Valid individuais SIMPLES (FASE 8/8) - cada um wrapper fino sobre
1078:     * AplicarValorSimples (BINDEVENT exige metodo PUBLIC - regra #3).
1079:     *--------------------------------------------------------------------------
1080:     PROCEDURE LostFocusIcmss()
1081:         THIS.AplicarValorSimples(THIS.txt_4c_Icmss, "this_nIcmsSubst", "LostFocusIcmss")
1082:     ENDPROC
1083: 
1084:     PROCEDURE LostFocusIcms()
1085:         THIS.AplicarValorSimples(THIS.txt_4c_Icms, "this_nIcms", "LostFocusIcms")
1086:     ENDPROC
1087: 
1088:     PROCEDURE LostFocusBICMS()
1089:         THIS.AplicarValorSimples(THIS.txt_4c_BICMS, "this_nBcIcmsSubst", "LostFocusBICMS")
1090:     ENDPROC
1091: 
1092:     PROCEDURE LostFocusVpis()
1093:         THIS.AplicarValorSimples(THIS.txt_4c_Vpis, "this_nVPis", "LostFocusVpis")
1094:     ENDPROC
1095: 
1096:     PROCEDURE LostFocusVcof()
1097:         THIS.AplicarValorSimples(THIS.txt_4c_Vcof, "this_nVCofins", "LostFocusVcof")
1098:     ENDPROC
1099: 
1100:     PROCEDURE LostFocusVii()
1101:         THIS.AplicarValorSimples(THIS.txt_4c_Vii, "this_nTaxaIi", "LostFocusVii")
1102:     ENDPROC
1103: 
1104:     PROCEDURE LostFocusVIrrf()
1105:         THIS.AplicarValorSimples(THIS.txt_4c_VIrrf, "this_nIrrf", "LostFocusVIrrf")
1106:     ENDPROC
1107: 
1108:     PROCEDURE LostFocusVInss()
1109:         THIS.AplicarValorSimples(THIS.txt_4c_VInss, "this_nInss", "LostFocusVInss")
1110:     ENDPROC
1111: 
1112:     PROCEDURE LostFocusVCssl()
1113:         THIS.AplicarValorSimples(THIS.txt_4c_VCssl, "this_nCssl", "LostFocusVCssl")
1114:     ENDPROC
1115: 
1116:     PROCEDURE LostFocusVIss()
1117:         THIS.AplicarValorSimples(THIS.txt_4c_VIss, "this_nIss", "LostFocusVIss")
1118:     ENDPROC
1119: 
1120:     *--------------------------------------------------------------------------
1121:     * LostFocusPIPI - transcricao de Get_pIPI.Valid: Replace Aliqs (this_
1122:     * nAliqIpi); se o percentual digitado eh != 0, recalcula o VALOR do
1123:     * IPI (BcIpis*Aliqs/100) e repinta txt_4c_Ipi - igual ao legado, que
1124:     * so recalcula quando a aliquota NAO vem zerada (mantem o valor
1125:     * anterior de IPI quando o usuario zera o percentual).
1126:     *--------------------------------------------------------------------------
1127:     PROCEDURE LostFocusPIPI()
1128:         LOCAL loc_oErro
1129:         TRY
1130:             THIS.LostFocusPIPIExec()
1131:         CATCH TO loc_oErro
1132:             MsgErro(loc_oErro.Message + CHR(13) + ;
1133:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "LostFocusPIPI")
1134:         ENDTRY
1135:     ENDPROC
1136: 
1137:     PROTECTED PROCEDURE LostFocusPIPIExec()
1138:         LOCAL loc_oBO, loc_nNovo, loc_nAnterior, loc_nNovoIpi
1139:         loc_oBO       = THIS.this_oBusinessObject
1140:         loc_nAnterior = loc_oBO.this_nAliqIpi
1141:         loc_nNovo     = THIS.ValorNumerico(THIS.txt_4c_PIPI.Value)
1142:         loc_oBO.this_nAliqIpi = loc_nNovo
1143: 
1144:         IF loc_nNovo <> 0
1145:             loc_nNovoIpi = ROUND(loc_oBO.this_nBcIpi * loc_nNovo / 100, 2)
1146:             loc_oBO.this_nValIpi = loc_nNovoIpi
1147:             THIS.txt_4c_Ipi.Value = loc_nNovoIpi
1148:             THIS.txt_4c_Ipi.Refresh()
1149:         ENDIF
1150: 
1151:         IF loc_nNovo <> loc_nAnterior
1152:             loc_oBO.this_lManipulou = .T.
1153:         ENDIF
1154:     ENDPROC
1155: 
1156:     *--------------------------------------------------------------------------
1157:     * LostFocusPicm - transcricao de Get_picm.Valid: Replace AliqIcms
1158:     * (this_nAliqIcms); recalcula o ICMS (BaseIcms*AliqIcms/100) SEMPRE
1159:     * (sem guarda de zero - diferente de pIPI/BICM/BIPI, que so recalculam
1160:     * quando o valor novo eh != 0) e repinta txt_4c_Icms.
1161:     *--------------------------------------------------------------------------
1162:     PROCEDURE LostFocusPicm()
1163:         LOCAL loc_oErro
1164:         TRY
1165:             THIS.LostFocusPicmExec()
1166:         CATCH TO loc_oErro
1167:             MsgErro(loc_oErro.Message + CHR(13) + ;
1168:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "LostFocusPicm")
1169:         ENDTRY
1170:     ENDPROC
1171: 
1172:     PROTECTED PROCEDURE LostFocusPicmExec()
1173:         LOCAL loc_oBO, loc_nNovo, loc_nAnterior, loc_nNovoIcms
1174:         loc_oBO       = THIS.this_oBusinessObject
1175:         loc_nAnterior = loc_oBO.this_nAliqIcms
1176:         loc_nNovo     = THIS.ValorNumerico(THIS.txt_4c_Picm.Value)
1177:         loc_oBO.this_nAliqIcms = loc_nNovo
1178: 
1179:         loc_nNovoIcms = ROUND(loc_oBO.this_nBaseIcms * loc_nNovo / 100, 2)
1180:         loc_oBO.this_nIcms = loc_nNovoIcms
1181:         THIS.txt_4c_Icms.Value = loc_nNovoIcms
1182:         THIS.txt_4c_Icms.Refresh()
1183: 
1184:         IF loc_nNovo <> loc_nAnterior
1185:             loc_oBO.this_lManipulou = .T.
1186:         ENDIF
1187:     ENDPROC
1188: 
1189:     *--------------------------------------------------------------------------
1190:     * LostFocusBICM - transcricao de Get_BICM.Valid: Replace BaseIcms
1191:     * (this_nBaseIcms); so quando o valor novo eh != 0 E mudou, recalcula
1192:     * o ICMS (BaseIcms*AliqIcms/100) e repinta txt_4c_Icms.
1193:     *--------------------------------------------------------------------------
1194:     PROCEDURE LostFocusBICM()
1195:         LOCAL loc_oErro
1196:         TRY
1197:             THIS.LostFocusBICMExec()
1198:         CATCH TO loc_oErro
1199:             MsgErro(loc_oErro.Message + CHR(13) + ;
1200:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "LostFocusBICM")
1201:         ENDTRY
1202:     ENDPROC
1203: 
1204:     PROTECTED PROCEDURE LostFocusBICMExec()
1205:         LOCAL loc_oBO, loc_nNovo, loc_nAnterior, loc_nNovoIcms
1206:         loc_oBO       = THIS.this_oBusinessObject
1207:         loc_nAnterior = loc_oBO.this_nBaseIcms
1208:         loc_nNovo     = THIS.ValorNumerico(THIS.txt_4c_BICM.Value)
1209:         loc_oBO.this_nBaseIcms = loc_nNovo
1210: 
1211:         IF loc_nNovo <> 0 AND loc_nNovo <> loc_nAnterior
1212:             loc_nNovoIcms = ROUND(loc_nNovo * loc_oBO.this_nAliqIcms / 100, 2)
1213:             loc_oBO.this_nIcms = loc_nNovoIcms
1214:             THIS.txt_4c_Icms.Value = loc_nNovoIcms
1215:             THIS.txt_4c_Icms.Refresh()
1216:         ENDIF
1217: 
1218:         IF loc_nNovo <> loc_nAnterior
1219:             loc_oBO.this_lManipulou = .T.
1220:         ENDIF
1221:     ENDPROC
1222: 
1223:     *--------------------------------------------------------------------------
1224:     * LostFocusIpi / LostFocusBIPI - transcricao de Get_ipi.Valid+LostFocus
1225:     * e Get_BIPI.Valid+LostFocus. Valid e LostFocus do MESMO controle
1226:     * disparam em sequencia ao sair do campo (Valid primeiro); como o
1227:     * projeto nao liga Valid de TextBox (regra de BINDEVENT em TextBox),
1228:     * as duas acoes do legado ficam num unico handler de LostFocus, na
1229:     * MESMA ordem: primeiro o "Replace" (aqui, grava a property do BO),
1230:     * depois o recalculo da tela de movimento.
1231:     *
1232:     * BIPI tem a parte extra do Valid (recalcula ValIpis localmente, com
1233:     * guarda "<> 0 AND <> peantvalue") ANTES do recalculo do pai; Ipi so
1234:     * grava o proprio valor (ValIpis) e dispara o recalculo direto.
1235:     *
1236:     * AplicarAoCursor() antes do recalculo: o legado ja tinha feito o
1237:     * Replace DIRETO no cursor dentro do Valid, entao quando o LostFocus
1238:     * chama CalcImposto o cursor ja reflete o digitado; aqui o valor mora
1239:     * no BO e precisa ser empurrado para o cursor compartilhado antes de
1240:     * pedir o recalculo (regra de arquitetura ja usada em
1241:     * BtnRecalcularClick).
1242:     *--------------------------------------------------------------------------
1243:     PROCEDURE LostFocusIpi()
1244:         LOCAL loc_oErro
1245:         TRY
1246:             THIS.LostFocusIpiExec()
1247:         CATCH TO loc_oErro
1248:             MsgErro(loc_oErro.Message + CHR(13) + ;
1249:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "LostFocusIpi")
1250:         ENDTRY
1251:     ENDPROC
1252: 
1253:     PROTECTED PROCEDURE LostFocusIpiExec()
1254:         LOCAL loc_oBO
1255: 
1256:         loc_oBO = THIS.this_oBusinessObject
1257: 
1258:         IF THIS.TransferirNumero(THIS.txt_4c_Ipi.Value, "this_nValIpi")
1259:             loc_oBO.this_lManipulou = .T.
1260:         ENDIF
1261: 
1262:         IF loc_oBO.AplicarAoCursor(loc_oBO.this_cCursorItens)
1263:             THIS.ChamarRecalculoImpostoCampo(loc_oBO.this_nItem)
1264:         ENDIF
1265:     ENDPROC
1266: 
1267:     PROCEDURE LostFocusBIPI()
1268:         LOCAL loc_oErro
1269:         TRY
1270:             THIS.LostFocusBIPIExec()
1271:         CATCH TO loc_oErro
1272:             MsgErro(loc_oErro.Message + CHR(13) + ;
1273:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "LostFocusBIPI")
1274:         ENDTRY
1275:     ENDPROC
1276: 
1277:     PROTECTED PROCEDURE LostFocusBIPIExec()
1278:         LOCAL loc_oBO, loc_nNovo, loc_nAnterior, loc_nNovoIpi
1279: 
1280:         loc_oBO       = THIS.this_oBusinessObject
1281:         loc_nAnterior = loc_oBO.this_nBcIpi
1282:         loc_nNovo     = THIS.ValorNumerico(THIS.txt_4c_BIPI.Value)
1283:         loc_oBO.this_nBcIpi = loc_nNovo
1284: 
1285:         IF loc_nNovo <> 0 AND loc_nNovo <> loc_nAnterior
1286:             loc_nNovoIpi = ROUND(loc_nNovo * loc_oBO.this_nAliqIpi / 100, 2)
1287:             loc_oBO.this_nValIpi = loc_nNovoIpi
1288:             THIS.txt_4c_Ipi.Value = loc_nNovoIpi
1289:             THIS.txt_4c_Ipi.Refresh()
1290:         ENDIF
1291: 
1292:         IF loc_nNovo <> loc_nAnterior
1293:             loc_oBO.this_lManipulou = .T.
1294:         ENDIF
1295: 
1296:         THIS.AjustarCamposPorContexto()
1297: 
1298:         IF loc_oBO.AplicarAoCursor(loc_oBO.this_cCursorItens)
1299:             THIS.ChamarRecalculoImpostoCampo(loc_oBO.this_nItem)
1300:         ENDIF
1301:     ENDPROC
1302: 
1303:     *--------------------------------------------------------------------------
1304:     * LostFocusVBc - transcricao de getVBc.Valid: so recalcula quando o
1305:     * valor novo eh != 0 E mudou (igual ao legado). O recalculo em si fica
1306:     * no BO (AplicarRecalculoBase - regra #17), que tambem sinaliza quais
1307:     * impostos nao puderam ser recalculados por falta de FSigOpFin_imp
1308:     * (ausencia REPORTADA, regra #27). Fecha com THIS.Refresh() (o
1309:     * "thisform.Refresh" do fim do Valid legado).
1310:     *--------------------------------------------------------------------------
1311:     PROCEDURE LostFocusVBc()
1312:         LOCAL loc_oErro
1313:         TRY
1314:             THIS.LostFocusVBcExec()
1315:         CATCH TO loc_oErro
1316:             MsgErro(loc_oErro.Message + CHR(13) + ;
1317:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "LostFocusVBc")
1318:         ENDTRY
1319:     ENDPROC
1320: 
1321:     PROTECTED PROCEDURE LostFocusVBcExec()
1322:         LOCAL loc_oBO, loc_nNovo, loc_nAnterior
1323: 
1324:         loc_oBO       = THIS.this_oBusinessObject
1325:         loc_nAnterior = loc_oBO.this_nValBase
1326:         loc_nNovo     = THIS.ValorNumerico(THIS.txt_4c_VBc.Value)
1327:         loc_oBO.this_nValBase = loc_nNovo
1328: 
1329:         IF loc_nNovo <> 0 AND loc_nNovo <> loc_nAnterior
1330:             loc_oBO.AplicarRecalculoBase()
1331: 
1332:             THIS.txt_4c_Vpis.Value  = loc_oBO.this_nVPis
1333:             THIS.txt_4c_Vcof.Value  = loc_oBO.this_nVCofins
1334:             THIS.txt_4c_Vii.Value   = loc_oBO.this_nTaxaIi
1335:             THIS.txt_4c_VIss.Value  = loc_oBO.this_nIss
1336:             THIS.txt_4c_VIrrf.Value = loc_oBO.this_nIrrf
1337:             THIS.txt_4c_VInss.Value = loc_oBO.this_nInss
1338:             THIS.txt_4c_VCssl.Value = loc_oBO.this_nCssl
1339: 
1340:             THIS.txt_4c_Vpis.Refresh()
1341:             THIS.txt_4c_Vcof.Refresh()
1342:             THIS.txt_4c_Vii.Refresh()
1343:             THIS.txt_4c_VIss.Refresh()
1344:             THIS.txt_4c_VIrrf.Refresh()
1345:             THIS.txt_4c_VInss.Refresh()
1346:             THIS.txt_4c_VCssl.Refresh()
1347: 
1348:             IF !EMPTY(loc_oBO.this_cAliquotasIndisponiveis)
1349:                 MsgAviso("Al" + CHR(237) + "quota de conta n" + CHR(227) + "o dispon" + CHR(237) + "vel " + ;
1350:                          "(FSigOpFin_imp n" + CHR(227) + "o portado) para: " + ;
1351:                          loc_oBO.this_cAliquotasIndisponiveis + "." + CHR(13) + ;
1352:                          "Esses impostos n" + CHR(227) + "o foram recalculados.", "Base de Impostos")
1353:             ENDIF
1354:         ENDIF
1355: 
1356:         IF loc_nNovo <> loc_nAnterior
1357:             loc_oBO.this_lManipulou = .T.
1358:         ENDIF
1359: 
1360:         THIS.Refresh()
1361:     ENDPROC
1362: 
1363:     *--------------------------------------------------------------------------
1364:     * AjustarCamposPorContexto - FASE 8/8. Reproduz as quatro condicoes
1365:     * DINAMICAS de When do legado (os tres campos de exibicao ja levam
1366:     * .Enabled = .F. ESTATICO desde a criacao - ver ConfigurarCamposImpostos):
1367:     *
1368:     *   Get_ipi  : Return (crTpmMvItn.BcIpis > 0)
1369:     *   getVii   : Return Substr(cfops,1,1) = '3'
1370:     *   getVIrrf/getVInss/getVCssl/getVIss : Return LocalGrp.servicos = 1
1371:     *
1372:     * Chamado sempre que algo que alimenta essas condicoes muda: carga
1373:     * inicial/recalculo completo (BOParaForm), troca de CFOP
1374:     * (AplicarCfopEncontrado) e edicao direta da Base de IPI
1375:     * (LostFocusBIPIExec).
1376:     *--------------------------------------------------------------------------
1377:     PROTECTED PROCEDURE AjustarCamposPorContexto()
1378:         LOCAL loc_oBO
1379:         loc_oBO = THIS.this_oBusinessObject
1380: 
1381:         THIS.txt_4c_Ipi.Enabled   = (loc_oBO.this_nBcIpi > 0)
1382:         THIS.txt_4c_Vii.Enabled   = (LEFT(ALLTRIM(loc_oBO.this_cCfop), 1) == "3")
1383:         THIS.txt_4c_VIrrf.Enabled = (loc_oBO.this_nServicosGrupo = 1)
1384:         THIS.txt_4c_VInss.Enabled = (loc_oBO.this_nServicosGrupo = 1)
1385:         THIS.txt_4c_VCssl.Enabled = (loc_oBO.this_nServicosGrupo = 1)
1386:         THIS.txt_4c_VIss.Enabled  = (loc_oBO.this_nServicosGrupo = 1)
1387:     ENDPROC
1388: 
1389:     *--------------------------------------------------------------------------
1390:     * ChamarRecalculoImpostoCampo - despacho guardado para o CalcImposto do
1391:     * AVO (ParentForm.ParentForm - mesma referencia de ChamarRecalculoDoPai),
1392:     * equivalente ao LostFocus de Get_ipi/Get_BIPI:
1393:     *
1394:     *   ThisForm.ParentForm.ParentForm.CalcImposto(.f., crTpmMvItn.Citens, .t.)
1395:     *   Select crTpmMvItn / Locate For cItens = lncItem
1396:     *   ThisForm.Get_BICM.Value = crTpmMvItn.BaseIcms (idem icms/picm) + Refresh
1397:     *
1398:     * NOTA: a assinatura aqui eh DIFERENTE da de ChamarRecalculoDoPai
1399:     * (3 argumentos posicionais - .f., item, .t. - contra 4 com o 3o
1400:     * OMITIDO no Click do botao Recalcular). Sao dois call sites distintos
1401:     * do MESMO metodo do legado, com formas de chamada diferentes - cada
1402:     * um transcrito literalmente do ponto onde aparece (regra #17), sem
1403:     * normalizar os dois para uma forma so.
1404:     *
1405:     * CalcImposto AINDA NAO EXISTE no projeto migrado (mesma ausencia
1406:     * documentada em ChamarRecalculoDoPai) - despacho por PEMSTATUS + TRY,
1407:     * ausencia REPORTADA ao usuario (regra #27).
1408:     *
1409:     * Sem RETURN dentro do TRY (regra #1).
1410:     *--------------------------------------------------------------------------
1411:     PROTECTED PROCEDURE ChamarRecalculoImpostoCampo(par_nItem)
1412:         LOCAL loc_oMovimento, loc_lChamou, loc_oErro, loc_oBO, loc_cAlias
1413: 
1414:         loc_oMovimento = .NULL.
1415:         loc_lChamou    = .F.
1416: 
1417:         IF VARTYPE(THIS.this_oParentForm) = "O"
1418:             IF PEMSTATUS(THIS.this_oParentForm, "this_oParentForm", 5)
1419:                 IF VARTYPE(THIS.this_oParentForm.this_oParentForm) = "O"
1420:                     loc_oMovimento = THIS.this_oParentForm.this_oParentForm
1421:                 ENDIF
1422:             ENDIF
1423:         ENDIF
1424: 
1425:         IF VARTYPE(loc_oMovimento) = "O"
1426:             TRY
1427:                 IF PEMSTATUS(loc_oMovimento, "CalcImposto", 5)
1428:                     loc_oMovimento.CalcImposto(.F., par_nItem, .T.)
1429:                     loc_lChamou = .T.
1430:                 ENDIF
1431:             CATCH TO loc_oErro
1432:                 loc_lChamou = .F.
1433:                 MsgErro(loc_oErro.Message + CHR(13) + ;
1434:                         "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1435:                         "Procedure: " + loc_oErro.Procedure, ;
1436:                         "Erro ao recalcular o imposto do campo na tela de movimento")
1437:             ENDTRY
1438:         ENDIF
1439: 
1440:         IF loc_lChamou
1441:             loc_oBO    = THIS.this_oBusinessObject
1442:             loc_cAlias = loc_oBO.this_cCursorItens
1443: 
1444:             IF USED(loc_cAlias)
1445:                 SELECT (loc_cAlias)
1446:                 LOCATE FOR cItens = par_nItem
1447: 
1448:                 IF FOUND()
1449:                     loc_oBO.this_nBaseIcms = TratarNulo(BaseIcms, 0)
1450:                     loc_oBO.this_nIcms     = TratarNulo(Icms, 0)
1451:                     loc_oBO.this_nAliqIcms = TratarNulo(AliqIcms, 0)
1452: 
1453:                     THIS.txt_4c_BICM.Value = loc_oBO.this_nBaseIcms
1454:                     THIS.txt_4c_Icms.Value = loc_oBO.this_nIcms
1455:                     THIS.txt_4c_Picm.Value = loc_oBO.this_nAliqIcms
1456:                     THIS.txt_4c_BICM.Refresh()
1457:                     THIS.txt_4c_Icms.Refresh()
1458:                     THIS.txt_4c_Picm.Refresh()
1459:                 ENDIF
1460:             ENDIF
1461:         ELSE
1462:             MsgAviso("O rec" + CHR(225) + "lculo de impostos pertence " + CHR(224) + ;
1463:                      " tela de movimento (CalcImposto), que ainda n" + CHR(227) + ;
1464:                      "o est" + CHR(225) + " dispon" + CHR(237) + "vel." + CHR(13) + ;
1465:                      "O valor digitado foi gravado no item, mas n" + CHR(227) + ;
1466:                      "o foi recalculado.", "Recalcular")
1467:         ENDIF
1468: 
1469:         RETURN loc_lChamou
1470:     ENDPROC
1471: 
1472:     *--------------------------------------------------------------------------
1473:     * ConfigurarLookupsFiscais - cria os quatro campos de lookup do dump:
1474:     * Classificacao Fiscal (txt_4c_ClFiscals/txt_4c_DClFiscals, SigCdClf) e
1475:     * CFOP (txt_4c__ccfop/txt_4c__dcfop, SigCdCFO), e liga os eventos que os
1476:     * implementam POR INTEIRO (ver cabecalho FASE 6/8 para o detalhe das
1477:     * regras de negocio). Propriedades visuais TRANSCRITAS do dump
1478:     * (Courier New, BackColor/DisabledBackColor/DisabledForeColor/
1479:     * BorderColor identicos ao legado - campos "fwget" de exibicao
1480:     * monoespacada).
1481:     *--------------------------------------------------------------------------
1482:     PROTECTED PROCEDURE ConfigurarLookupsFiscais()
1483:         *-- txt_4c_ClFiscals (getClFiscals) - codigo da Classificacao Fiscal
1484:         THIS.AddObject("txt_4c_ClFiscals", "TextBox")
1485:         WITH THIS.txt_4c_ClFiscals
1486:             .Top               = 154
1487:             .Left              = 349
1488:             .Width             = 80
1489:             .Height            = 23
1490:             .Value             = ""
1491:             .FontName          = "Courier New"
1492:             .BackColor         = RGB(255, 255, 232)
1493:             .DisabledBackColor = RGB(255, 255, 255)
1494:             .DisabledForeColor = RGB(192, 192, 192)
1495:             .BorderColor       = RGB(0, 0, 0)
1496:             .TabIndex          = 11
1497:         ENDWITH
1498: 
1499:         *-- txt_4c_DClFiscals (getDClFiscals) - descricao da Classificacao Fiscal
1500:         THIS.AddObject("txt_4c_DClFiscals", "TextBox")
1501:         WITH THIS.txt_4c_DClFiscals
1502:             .Top               = 154
1503:             .Left              = 431
1504:             .Width             = 192
1505:             .Height            = 23
1506:             .Value             = ""
1507:             .FontName          = "Courier New"
1508:             .BackColor         = RGB(255, 255, 232)
1509:             .DisabledBackColor = RGB(255, 255, 255)
1510:             .DisabledForeColor = RGB(192, 192, 192)
1511:             .BorderColor       = RGB(0, 0, 0)
1512:             .TabIndex          = 12
1513:         ENDWITH
1514: 
1515:         *-- txt_4c__ccfop (get_ccfop) - codigo do CFOP
1516:         THIS.AddObject("txt_4c__ccfop", "TextBox")
1517:         WITH THIS.txt_4c__ccfop
1518:             .Top               = 181
1519:             .Left              = 349
1520:             .Width             = 80
1521:             .Height            = 23
1522:             .Value             = ""

*-- Linhas 1544 a 1871:
1544:             .TabIndex          = 14
1545:         ENDWITH
1546: 
1547:         BINDEVENT(THIS.txt_4c_ClFiscals,  "GotFocus",  THIS, "GotFocusClFiscal")
1548:         BINDEVENT(THIS.txt_4c_DClFiscals, "GotFocus",  THIS, "GotFocusClFiscal")
1549:         BINDEVENT(THIS.txt_4c_ClFiscals,  "LostFocus", THIS, "ValidarClFiscalCodigo")
1550:         BINDEVENT(THIS.txt_4c_DClFiscals, "LostFocus", THIS, "ValidarClFiscalDescricao")
1551: 
1552:         BINDEVENT(THIS.txt_4c__ccfop, "GotFocus",  THIS, "GotFocusCfop")
1553:         BINDEVENT(THIS.txt_4c__dcfop, "GotFocus",  THIS, "GotFocusCfop")
1554:         BINDEVENT(THIS.txt_4c__ccfop, "LostFocus", THIS, "ValidarCfopCodigo")
1555:         BINDEVENT(THIS.txt_4c__dcfop, "LostFocus", THIS, "ValidarCfopDescricao")
1556:     ENDPROC
1557: 
1558:     *--------------------------------------------------------------------------
1559:     * GotFocusClFiscal / GotFocusCfop - guardam o codigo ATUALMENTE resolvido
1560:     * no BO (equivalente ao This.Tag = Padr(This.Value, N) do legado - ver
1561:     * nota no cabecalho FASE 6/8 sobre a simplificacao de comparar sempre
1562:     * pelo codigo).
1563:     *--------------------------------------------------------------------------
1564:     PROCEDURE GotFocusClFiscal()
1565:         THIS.this_cClFiscalAnterior = THIS.this_oBusinessObject.this_cClFiscal
1566:     ENDPROC
1567: 
1568:     PROCEDURE GotFocusCfop()
1569:         THIS.this_cCfopAnterior = THIS.this_oBusinessObject.this_cCfop
1570:     ENDPROC
1571: 
1572:     *--------------------------------------------------------------------------
1573:     * ValidarClFiscalCodigo / ValidarClFiscalDescricao - wrappers PUBLIC
1574:     * ligados por BINDEVENT (regra #3), com guarda de reentrancia (regra
1575:     * #47) e corpo em *Exec() para sobreviver a RETURN antecipado sem travar
1576:     * a flag ligada (regra #47).
1577:     *--------------------------------------------------------------------------
1578:     PROCEDURE ValidarClFiscalCodigo()
1579:         LOCAL loc_oErro
1580: 
1581:         IF THIS.this_lEmLookupClFiscal
1582:             RETURN
1583:         ENDIF
1584: 
1585:         THIS.this_lEmLookupClFiscal = .T.
1586:         TRY
1587:             THIS.ValidarClFiscalCodigoExec()
1588:         CATCH TO loc_oErro
1589:             MsgErro(loc_oErro.Message + CHR(13) + ;
1590:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "ValidarClFiscalCodigo")
1591:         ENDTRY
1592:         THIS.this_lEmLookupClFiscal = .F.
1593:     ENDPROC
1594: 
1595:     PROTECTED PROCEDURE ValidarClFiscalCodigoExec()
1596:         THIS.ResolverClassificacaoFiscal("Codigos", ALLTRIM(THIS.txt_4c_ClFiscals.Value))
1597:     ENDPROC
1598: 
1599:     PROCEDURE ValidarClFiscalDescricao()
1600:         LOCAL loc_oErro
1601: 
1602:         IF THIS.this_lEmLookupClFiscal
1603:             RETURN
1604:         ENDIF
1605: 
1606:         THIS.this_lEmLookupClFiscal = .T.
1607:         TRY
1608:             THIS.ValidarClFiscalDescricaoExec()
1609:         CATCH TO loc_oErro
1610:             MsgErro(loc_oErro.Message + CHR(13) + ;
1611:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "ValidarClFiscalDescricao")
1612:         ENDTRY
1613:         THIS.this_lEmLookupClFiscal = .F.
1614:     ENDPROC
1615: 
1616:     PROTECTED PROCEDURE ValidarClFiscalDescricaoExec()
1617:         THIS.ResolverClassificacaoFiscal("Descricaos", ALLTRIM(THIS.txt_4c_DClFiscals.Value))
1618:     ENDPROC
1619: 
1620:     *--------------------------------------------------------------------------
1621:     * ResolverClassificacaoFiscal - tenta o BO.BuscarClassificacaoFiscal()
1622:     * (match exato); achando, aplica direto; nao achando, abre o picker
1623:     * (AbrirLookupClFiscal). Campo vazio limpa os dois campos (equivalente
1624:     * ao Else do legado).
1625:     *--------------------------------------------------------------------------
1626:     PROTECTED PROCEDURE ResolverClassificacaoFiscal(par_cCampoBusca, par_cValor)
1627:         LOCAL loc_oBO
1628:         loc_oBO = THIS.this_oBusinessObject
1629: 
1630:         IF EMPTY(par_cValor)
1631:             THIS.txt_4c_ClFiscals.Value  = ""
1632:             THIS.txt_4c_DClFiscals.Value = ""
1633:         ELSE
1634:             IF loc_oBO.BuscarClassificacaoFiscal(par_cCampoBusca, par_cValor)
1635:                 THIS.AplicarClassificacaoFiscalEncontrada()
1636:             ELSE
1637:                 THIS.AbrirLookupClFiscal(par_cCampoBusca, par_cValor)
1638:             ENDIF
1639:         ENDIF
1640: 
1641:         THIS.txt_4c_ClFiscals.Refresh()
1642:         THIS.txt_4c_DClFiscals.Refresh()
1643:     ENDPROC
1644: 
1645:     *--------------------------------------------------------------------------
1646:     * AplicarClassificacaoFiscalEncontrada - preenche os dois campos a
1647:     * partir do que o BO acabou de resolver (busca exata ou selecao no
1648:     * picker) e, SO quando a classificacao de fato mudou, reproduz os
1649:     * efeitos colaterais do Valid legado (ver cabecalho FASE 6/8).
1650:     *--------------------------------------------------------------------------
1651:     PROTECTED PROCEDURE AplicarClassificacaoFiscalEncontrada()
1652:         LOCAL loc_oBO, loc_nNovaAliq, loc_nNovoIcms
1653:         loc_oBO = THIS.this_oBusinessObject
1654: 
1655:         THIS.txt_4c_ClFiscals.Value  = loc_oBO.this_cClFiscal
1656:         THIS.txt_4c_DClFiscals.Value = loc_oBO.this_cDescrClFiscal
1657: 
1658:         IF PADR(THIS.this_cClFiscalAnterior, 10) == PADR(loc_oBO.this_cClFiscal, 10)
1659:             RETURN
1660:         ENDIF
1661: 
1662:         IF loc_oBO.this_nBIcmsClFiscal <> 0 AND loc_oBO.this_nBIcmsClFiscal <> loc_oBO.this_nAliqIcms
1663:             loc_nNovaAliq = loc_oBO.this_nBIcmsClFiscal
1664:             loc_nNovoIcms = ROUND(loc_oBO.this_nBaseIcms * loc_nNovaAliq / 100, 2)
1665:             loc_oBO.AplicarAliquotaIcmsAoCursor(loc_nNovaAliq, loc_nNovoIcms)
1666: 
1667:             THIS.txt_4c_Picm.Value = loc_nNovaAliq
1668:             THIS.txt_4c_Icms.Value = loc_nNovoIcms
1669:             THIS.txt_4c_Picm.Refresh()
1670:             THIS.txt_4c_Icms.Refresh()
1671:         ELSE
1672:             IF MsgConfirma("Deseja atualizar a Classifica" + CHR(231) + CHR(227) + "o Fiscal do Produto?", ;
1673:                            "Classifica" + CHR(231) + CHR(227) + "o Fiscal")
1674:                 loc_oBO.AtualizarClassificacaoFiscalProduto()
1675:             ENDIF
1676:         ENDIF
1677:     ENDPROC
1678: 
1679:     *--------------------------------------------------------------------------
1680:     * AbrirLookupClFiscal - picker FormBuscaAuxiliar para SigCdClf (regra
1681:     * #37: Show() so quando NAO achou exato; atribuicao so sob
1682:     * this_lSelecionou).
1683:     *--------------------------------------------------------------------------
1684:     PROTECTED PROCEDURE AbrirLookupClFiscal(par_cCampoBusca, par_cValor)
1685:         LOCAL loc_oBusca, loc_oBO, loc_cCursor
1686:         loc_oBO     = THIS.this_oBusinessObject
1687:         loc_cCursor = loc_oBO.this_cCursorClf
1688: 
1689:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1690:             "SigCdClf", loc_cCursor, par_cCampoBusca, par_cValor, ;
1691:             "Classifica" + CHR(231) + CHR(227) + "o Fiscal")
1692: 
1693:         IF VARTYPE(loc_oBusca) = "O"
1694:             IF !loc_oBusca.this_lAchouRegistro
1695:                 loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
1696:                 loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
1697:                 loc_oBusca.mAddColuna("BIcms",      "999.99", "ICMS")
1698:                 loc_oBusca.Show()
1699:             ENDIF
1700:             IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
1701:                 SELECT (loc_cCursor)
1702:                 loc_oBO.this_cClFiscal      = ALLTRIM(Codigos)
1703:                 loc_oBO.this_cDescrClFiscal = ALLTRIM(Descricaos)
1704:                 loc_oBO.this_nBIcmsClFiscal = NVL(BIcms, 0)
1705:                 THIS.AplicarClassificacaoFiscalEncontrada()
1706:             ENDIF
1707:             loc_oBusca.Release()
1708:         ENDIF
1709: 
1710:         IF USED(loc_cCursor)
1711:             USE IN (loc_cCursor)
1712:         ENDIF
1713:     ENDPROC
1714: 
1715:     *--------------------------------------------------------------------------
1716:     * ValidarCfopCodigo / ValidarCfopDescricao - mesmo padrao de wrapper +
1717:     * guarda de reentrancia dos metodos de Classificacao Fiscal acima.
1718:     *--------------------------------------------------------------------------
1719:     PROCEDURE ValidarCfopCodigo()
1720:         LOCAL loc_oErro
1721: 
1722:         IF THIS.this_lEmLookupCfop
1723:             RETURN
1724:         ENDIF
1725: 
1726:         THIS.this_lEmLookupCfop = .T.
1727:         TRY
1728:             THIS.ValidarCfopCodigoExec()
1729:         CATCH TO loc_oErro
1730:             MsgErro(loc_oErro.Message + CHR(13) + ;
1731:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "ValidarCfopCodigo")
1732:         ENDTRY
1733:         THIS.this_lEmLookupCfop = .F.
1734:     ENDPROC
1735: 
1736:     PROTECTED PROCEDURE ValidarCfopCodigoExec()
1737:         THIS.ResolverCfop("Codigos", ALLTRIM(THIS.txt_4c__ccfop.Value))
1738:     ENDPROC
1739: 
1740:     PROCEDURE ValidarCfopDescricao()
1741:         LOCAL loc_oErro
1742: 
1743:         IF THIS.this_lEmLookupCfop
1744:             RETURN
1745:         ENDIF
1746: 
1747:         THIS.this_lEmLookupCfop = .T.
1748:         TRY
1749:             THIS.ValidarCfopDescricaoExec()
1750:         CATCH TO loc_oErro
1751:             MsgErro(loc_oErro.Message + CHR(13) + ;
1752:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "ValidarCfopDescricao")
1753:         ENDTRY
1754:         THIS.this_lEmLookupCfop = .F.
1755:     ENDPROC
1756: 
1757:     PROTECTED PROCEDURE ValidarCfopDescricaoExec()
1758:         THIS.ResolverCfop("Descricaos", ALLTRIM(THIS.txt_4c__dcfop.Value))
1759:     ENDPROC
1760: 
1761:     *--------------------------------------------------------------------------
1762:     * ResolverCfop - mesmo esquema de ResolverClassificacaoFiscal, para
1763:     * SigCdCFO.
1764:     *--------------------------------------------------------------------------
1765:     PROTECTED PROCEDURE ResolverCfop(par_cCampoBusca, par_cValor)
1766:         LOCAL loc_oBO
1767:         loc_oBO = THIS.this_oBusinessObject
1768: 
1769:         IF EMPTY(par_cValor)
1770:             THIS.txt_4c__ccfop.Value = ""
1771:             THIS.txt_4c__dcfop.Value = ""
1772:         ELSE
1773:             IF loc_oBO.BuscarCfop(par_cCampoBusca, par_cValor)
1774:                 THIS.AplicarCfopEncontrado()
1775:             ELSE
1776:                 THIS.AbrirLookupCfop(par_cCampoBusca, par_cValor)
1777:             ENDIF
1778:         ENDIF
1779: 
1780:         THIS.txt_4c__ccfop.Refresh()
1781:         THIS.txt_4c__dcfop.Refresh()
1782:     ENDPROC
1783: 
1784:     *--------------------------------------------------------------------------
1785:     * AplicarCfopEncontrado - preenche os dois campos e, SO quando o CFOP de
1786:     * fato mudou, pede ao BO para rearmar base/aliquota de IPI e ICMS (ver
1787:     * cabecalho FASE 6/8) e repinta os campos afetados.
1788:     *--------------------------------------------------------------------------
1789:     PROTECTED PROCEDURE AplicarCfopEncontrado()
1790:         LOCAL loc_oBO
1791:         loc_oBO = THIS.this_oBusinessObject
1792: 
1793:         THIS.txt_4c__ccfop.Value = loc_oBO.this_cCfop
1794:         THIS.txt_4c__dcfop.Value = loc_oBO.this_cDescrCfop
1795: 
1796:         IF PADR(THIS.this_cCfopAnterior, 10) == PADR(loc_oBO.this_cCfop, 10)
1797:             RETURN
1798:         ENDIF
1799: 
1800:         IF loc_oBO.AplicarCfopSelecionado()
1801:             THIS.txt_4c_BIPI.Value = loc_oBO.this_nBcIpi
1802:             THIS.txt_4c_BICM.Value = loc_oBO.this_nBaseIcms
1803:             THIS.txt_4c_PIPI.Value = loc_oBO.this_nAliqIpi
1804:             THIS.txt_4c_Ipi.Value  = loc_oBO.this_nValIpi
1805:             THIS.txt_4c_Picm.Value = loc_oBO.this_nAliqIcms
1806:             THIS.txt_4c_Icms.Value = loc_oBO.this_nIcms
1807: 
1808:             THIS.txt_4c_BIPI.Refresh()
1809:             THIS.txt_4c_BICM.Refresh()
1810:             THIS.txt_4c_PIPI.Refresh()
1811:             THIS.txt_4c_Ipi.Refresh()
1812:             THIS.txt_4c_Picm.Refresh()
1813:             THIS.txt_4c_Icms.Refresh()
1814:         ENDIF
1815: 
1816:         *-- O CFOP novo pode mudar a base de IPI (BcIpis) e o proprio CFOP
1817:         *-- decide a condicao de getVii - reavaliar as condicoes dinamicas
1818:         *-- de When (FASE 8/8).
1819:         THIS.AjustarCamposPorContexto()
1820:     ENDPROC
1821: 
1822:     *--------------------------------------------------------------------------
1823:     * AbrirLookupCfop - picker FormBuscaAuxiliar para SigCdCFO (mesmo
1824:     * padrao de AbrirLookupClFiscal).
1825:     *--------------------------------------------------------------------------
1826:     PROTECTED PROCEDURE AbrirLookupCfop(par_cCampoBusca, par_cValor)
1827:         LOCAL loc_oBusca, loc_oBO, loc_cCursor
1828:         loc_oBO     = THIS.this_oBusinessObject
1829:         loc_cCursor = loc_oBO.this_cCursorCfo
1830: 
1831:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1832:             "SigCdCFO", loc_cCursor, par_cCampoBusca, par_cValor, "CFOP")
1833: 
1834:         IF VARTYPE(loc_oBusca) = "O"
1835:             IF !loc_oBusca.this_lAchouRegistro
1836:                 loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
1837:                 loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
1838:                 loc_oBusca.Show()
1839:             ENDIF
1840:             IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
1841:                 SELECT (loc_cCursor)
1842:                 loc_oBO.this_cCfop           = ALLTRIM(Codigos)
1843:                 loc_oBO.this_cDescrCfop      = ALLTRIM(Descricaos)
1844:                 loc_oBO.this_nAliqIpiCfop    = NVL(aliqipis, 0)
1845:                 loc_oBO.this_nAliqIcmsCfop   = NVL(aliqivcs, 0)
1846:                 loc_oBO.this_cTribIpiCfop    = NVL(ipis, "")
1847:                 loc_oBO.this_cTribIcmsCfop   = NVL(icms, "")
1848:                 loc_oBO.this_nAliqPisCfop    = NVL(aliqpis, 0)
1849:                 loc_oBO.this_nAliqCofinsCfop = NVL(aliqcofins, 0)
1850:                 loc_oBO.this_nAliqIiCfop     = NVL(aliqii, 0)
1851:                 loc_oBO.this_nAliqIssqnCfop  = NVL(aliqissqn, 0)
1852:                 THIS.AplicarCfopEncontrado()
1853:             ENDIF
1854:             loc_oBusca.Release()
1855:         ENDIF
1856: 
1857:         IF USED(loc_cCursor)
1858:             USE IN (loc_cCursor)
1859:         ENDIF
1860:     ENDPROC
1861: 
1862:     *--------------------------------------------------------------------------
1863:     * ConfigurarBotoes - cria obj_4c_CntBotoes (CommandGroup "cntBotoes" do
1864:     * legado, ButtonCount = 2) com os DOIS botoes de acao deste dialogo.
1865:     * Propriedades TRANSCRITAS de SigOpImp_form_codigo_fonte.txt
1866:     * (* PROPRIEDADES DE: SIGOPIMP.cntBotoes).
1867:     *
1868:     *   Buttons(1) = "\<Recalcular" (legado btnConfirmar) -> BtnRecalcularClick
1869:     *   Buttons(2) = "\<Voltar"     (legado btnSair)      -> BtnConfirmarClick
1870:     *
1871:     * O grupo eh o ULTIMO AddObject da montagem visual de proposito: ele fica

*-- Linhas 1884 a 1927:
1884:     * - os dois arquivos existem em vbmp\. CommandGroup NAO tem ForeColor
1885:     * (regra #33): a cor fica nos membros.
1886:     *--------------------------------------------------------------------------
1887:     PROTECTED PROCEDURE ConfigurarBotoes()
1888:         LOCAL loc_oCmg, loc_oErro
1889: 
1890:         TRY
1891:             THIS.AddObject("obj_4c_CntBotoes", "CommandGroup")
1892:             loc_oCmg = THIS.obj_4c_CntBotoes
1893:             loc_oCmg.ButtonCount = 2
1894: 
1895:             *-- Buttons(1) - legado Command1 (Name = "btnConfirmar")
1896:             WITH loc_oCmg.Buttons(1)
1897:                 .AutoSize        = .F.
1898:                 .Top             = 5
1899:                 .Left            = 5
1900:                 .Height          = 75
1901:                 .Width           = 75
1902:                 .Caption         = "\<Recalcular"
1903:                 .ToolTipText     = "Recalcular os  Impostos"
1904:                 .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
1905:                 .FontBold        = .T.
1906:                 .FontItalic      = .T.
1907:                 .FontName        = "Comic Sans MS"
1908:                 .FontSize        = 8
1909:                 .WordWrap        = .T.
1910:                 .MousePointer    = 15
1911:                 .SpecialEffect   = 0
1912:                 .PicturePosition = 13
1913:                 .ForeColor       = RGB(90, 90, 90)
1914:                 .BackColor       = RGB(255, 255, 255)
1915:                 .Themes          = .F.
1916:                 .TabIndex        = 1
1917:             ENDWITH
1918: 
1919:             *-- Buttons(2) - legado Command2 (Name = "btnSair", Cancel = .T.)
1920:             WITH loc_oCmg.Buttons(2)
1921:                 .Top           = 5
1922:                 .Left          = 80
1923:                 .Height        = 75
1924:                 .Width         = 75
1925:                 .Caption       = "\<Voltar"
1926:                 .ToolTipText   = "[Esc] Retornar Para Tela Anterior"
1927:                 .Picture       = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"

*-- Linhas 1953 a 2067:
1953:                 .TabIndex      = 23
1954:             ENDWITH
1955: 
1956:             *-- BINDEVENT exige metodo PUBLIC (regra #3) - os dois handlers
1957:             *-- abaixo nao levam PROTECTED.
1958:             BINDEVENT(loc_oCmg.Buttons(1), "Click", THIS, "BtnRecalcularClick")
1959:             BINDEVENT(loc_oCmg.Buttons(2), "Click", THIS, "BtnConfirmarClick")
1960:         CATCH TO loc_oErro
1961:             MsgErro(loc_oErro.Message + CHR(13) + ;
1962:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1963:                     "Procedure: " + loc_oErro.Procedure, ;
1964:                     "Erro em FormSigOpImp.ConfigurarBotoes")
1965:         ENDTRY
1966:     ENDPROC
1967: 
1968:     *--------------------------------------------------------------------------
1969:     * CarregarDadosDoItem - leitura INICIAL do dialogo, equivalente ao bloco
1970:     * "With ThisForm / .get_Produto.Value = crTpmMvItn.Cpros / ..." do Init
1971:     * legado mais as TRES consultas de contexto que vem logo depois:
1972:     *
1973:     *   1) Classificacao Fiscal do produto (SigCdPro x SigCdClf)
1974:     *   3) Grupo do produto / flag de servico (SigCdPro x SigCdGrp)
1975:     *      -> as duas em BO.CarregarContextoDoProduto()
1976:     *   2) Descricao e aliquotas do CFOP gravado no item
1977:     *      -> BO.BuscarCfop(), que ja seleciona as mesmas colunas
1978:     *
1979:     * No legado isso mora no Init; aqui fica em metodo proprio porque o
1980:     * BtnRecalcularClick precisa reler o MESMO item depois do recalculo feito
1981:     * pela tela de movimento (o legado repete os 11 assignments no Click).
1982:     *
1983:     * A consulta 2 nao eh disparada com CFOP vazio: o legado montaria
1984:     * "Where a.codigos = ''" e voltaria lista vazia, sem efeito nenhum.
1985:     *
1986:     * Sem RETURN dentro do TRY (regra #1).
1987:     *--------------------------------------------------------------------------
1988:     PROCEDURE CarregarDadosDoItem()
1989:         LOCAL loc_oBO, loc_lSucesso, loc_oErro
1990:         loc_lSucesso = .F.
1991: 
1992:         TRY
1993:             loc_oBO = THIS.this_oBusinessObject
1994: 
1995:             IF !loc_oBO.CarregarDoCursor(loc_oBO.this_cCursorItens)
1996:                 MsgErro(loc_oBO.this_cMensagemErro, ;
1997:                         "Erro em FormSigOpImp.CarregarDadosDoItem")
1998:             ELSE
1999:                 IF loc_oBO.CarregarContextoDoProduto()
2000:                     IF !EMPTY(loc_oBO.this_cCfop)
2001:                         loc_oBO.BuscarCfop("Codigos", loc_oBO.this_cCfop)
2002:                     ENDIF
2003: 
2004:                     THIS.BOParaForm()
2005:                     loc_lSucesso = .T.
2006:                 ENDIF
2007:             ENDIF
2008:         CATCH TO loc_oErro
2009:             MsgErro(loc_oErro.Message + CHR(13) + ;
2010:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2011:                     "Procedure: " + loc_oErro.Procedure, ;
2012:                     "Erro em FormSigOpImp.CarregarDadosDoItem")
2013:         ENDTRY
2014: 
2015:         RETURN loc_lSucesso
2016:     ENDPROC
2017: 
2018:     *--------------------------------------------------------------------------
2019:     * BOParaForm - espelha as propriedades do BO nos 23 campos da tela, na
2020:     * MESMA correspondencia do Init/btnConfirmar.Click legado (o legado
2021:     * reescreve 11 campos no Click e 19 + 2 pares de lookup no Init; aqui o
2022:     * metodo eh unico e cobre todos, porque todos acabaram de ser lidos do
2023:     * cursor e portanto carregam o mesmo valor que o legado leria).
2024:     *
2025:     * Fecha com THIS.Refresh(), que eh o ".Refresh" do EndWith legado.
2026:     *--------------------------------------------------------------------------
2027:     PROCEDURE BOParaForm()
2028:         LOCAL loc_oBO
2029:         loc_oBO = THIS.this_oBusinessObject
2030: 
2031:         *-- Campos de exibicao (o When do legado devolve .F. nos tres)
2032:         THIS.txt_4c_Produto.Value = loc_oBO.this_cProduto
2033:         THIS.txt_4c_Total.Value   = loc_oBO.this_nTotal
2034:         THIS.txt_4c_Descr.Value   = loc_oBO.this_cDescricaoProduto
2035: 
2036:         *-- IPI / ICMS / ICMS Substituicao
2037:         THIS.txt_4c_PIPI.Value  = loc_oBO.this_nAliqIpi
2038:         THIS.txt_4c_Ipi.Value   = loc_oBO.this_nValIpi
2039:         THIS.txt_4c_BIPI.Value  = loc_oBO.this_nBcIpi
2040:         THIS.txt_4c_Picm.Value  = loc_oBO.this_nAliqIcms
2041:         THIS.txt_4c_Icms.Value  = loc_oBO.this_nIcms
2042:         THIS.txt_4c_BICM.Value  = loc_oBO.this_nBaseIcms
2043:         THIS.txt_4c_Icmss.Value = loc_oBO.this_nIcmsSubst
2044:         THIS.txt_4c_BICMS.Value = loc_oBO.this_nBcIcmsSubst
2045: 
2046:         *-- Base dos demais impostos + PIS/COFINS/II/ISS/IRRF/INSS/CSSL
2047:         THIS.txt_4c_VBc.Value   = loc_oBO.this_nValBase
2048:         THIS.txt_4c_Vpis.Value  = loc_oBO.this_nVPis
2049:         THIS.txt_4c_Vcof.Value  = loc_oBO.this_nVCofins
2050:         THIS.txt_4c_Vii.Value   = loc_oBO.this_nTaxaIi
2051:         THIS.txt_4c_VIss.Value  = loc_oBO.this_nIss
2052:         THIS.txt_4c_VIrrf.Value = loc_oBO.this_nIrrf
2053:         THIS.txt_4c_VInss.Value = loc_oBO.this_nInss
2054:         THIS.txt_4c_VCssl.Value = loc_oBO.this_nCssl
2055: 
2056:         *-- Lookups fiscais (criados na Fase 6)
2057:         THIS.txt_4c_ClFiscals.Value  = loc_oBO.this_cClFiscal
2058:         THIS.txt_4c_DClFiscals.Value = loc_oBO.this_cDescrClFiscal
2059:         THIS.txt_4c__ccfop.Value     = loc_oBO.this_cCfop
2060:         THIS.txt_4c__dcfop.Value     = loc_oBO.this_cDescrCfop
2061: 
2062:         *-- Os "Tag" dos lookups passam a refletir o que esta na tela, senao
2063:         *-- o proximo LostFocus trataria o valor recem-carregado como MUDANCA
2064:         *-- e disparava os efeitos colaterais da Fase 6.
2065:         THIS.this_cClFiscalAnterior = loc_oBO.this_cClFiscal
2066:         THIS.this_cCfopAnterior     = loc_oBO.this_cCfop
2067: 

*-- Linhas 2093 a 2136:
2093:     * Produto / Total / Descricao NAO entram: o When do legado devolve .F.
2094:     * nos tres (campos de exibicao), entao nunca sao digitados.
2095:     *--------------------------------------------------------------------------
2096:     PROCEDURE FormParaBO()
2097:         LOCAL loc_lMudou
2098: 
2099:         loc_lMudou = .F.
2100: 
2101:         loc_lMudou = THIS.TransferirNumero(THIS.txt_4c_PIPI.Value,  "this_nAliqIpi")     OR loc_lMudou
2102:         loc_lMudou = THIS.TransferirNumero(THIS.txt_4c_Ipi.Value,   "this_nValIpi")      OR loc_lMudou
2103:         loc_lMudou = THIS.TransferirNumero(THIS.txt_4c_BIPI.Value,  "this_nBcIpi")       OR loc_lMudou
2104:         loc_lMudou = THIS.TransferirNumero(THIS.txt_4c_Picm.Value,  "this_nAliqIcms")    OR loc_lMudou
2105:         loc_lMudou = THIS.TransferirNumero(THIS.txt_4c_Icms.Value,  "this_nIcms")        OR loc_lMudou
2106:         loc_lMudou = THIS.TransferirNumero(THIS.txt_4c_BICM.Value,  "this_nBaseIcms")    OR loc_lMudou
2107:         loc_lMudou = THIS.TransferirNumero(THIS.txt_4c_Icmss.Value, "this_nIcmsSubst")   OR loc_lMudou
2108:         loc_lMudou = THIS.TransferirNumero(THIS.txt_4c_BICMS.Value, "this_nBcIcmsSubst") OR loc_lMudou
2109: 
2110:         loc_lMudou = THIS.TransferirNumero(THIS.txt_4c_VBc.Value,   "this_nValBase")     OR loc_lMudou
2111:         loc_lMudou = THIS.TransferirNumero(THIS.txt_4c_Vpis.Value,  "this_nVPis")        OR loc_lMudou
2112:         loc_lMudou = THIS.TransferirNumero(THIS.txt_4c_Vcof.Value,  "this_nVCofins")     OR loc_lMudou
2113:         loc_lMudou = THIS.TransferirNumero(THIS.txt_4c_Vii.Value,   "this_nTaxaIi")      OR loc_lMudou
2114:         loc_lMudou = THIS.TransferirNumero(THIS.txt_4c_VIss.Value,  "this_nIss")         OR loc_lMudou
2115:         loc_lMudou = THIS.TransferirNumero(THIS.txt_4c_VIrrf.Value, "this_nIrrf")        OR loc_lMudou
2116:         loc_lMudou = THIS.TransferirNumero(THIS.txt_4c_VInss.Value, "this_nInss")        OR loc_lMudou
2117:         loc_lMudou = THIS.TransferirNumero(THIS.txt_4c_VCssl.Value, "this_nCssl")        OR loc_lMudou
2118: 
2119:         IF loc_lMudou
2120:             THIS.this_oBusinessObject.this_lManipulou = .T.
2121:         ENDIF
2122: 
2123:         RETURN .T.
2124:     ENDPROC
2125: 
2126:     *--------------------------------------------------------------------------
2127:     * TransferirNumero - grava UM valor de tela numa property NUMERICA do BO
2128:     * e devolve .T. quando o valor MUDOU (equivalente ao
2129:     * "If This.Value <> This.peantvalue" de cada Valid legado).
2130:     *
2131:     * O nome da property chega por string e eh resolvido com EVALUATE na
2132:     * LEITURA e STORE ... TO (...) na ATRIBUICAO - EVALUATE com o "=" dentro
2133:     * da string NAO atribui: avalia como comparacao e descarta (regra #15).
2134:     *--------------------------------------------------------------------------
2135:     PROTECTED FUNCTION TransferirNumero(par_uValorTela, par_cProp)
2136:         LOCAL loc_oBO, loc_nNovo, loc_nAtual, loc_cCaminho

*-- Linhas 2209 a 2289:
2209:     *
2210:     * Sem RETURN dentro do TRY (regra #1).
2211:     *--------------------------------------------------------------------------
2212:     PROCEDURE BtnRecalcularClick()
2213:         LOCAL loc_oBO, loc_nItem, loc_lManipulou, loc_cAlias, loc_oErro
2214: 
2215:         TRY
2216:             loc_oBO = THIS.this_oBusinessObject
2217: 
2218:             THIS.FormParaBO()
2219: 
2220:             IF !loc_oBO.AplicarAoCursor(loc_oBO.this_cCursorItens)
2221:                 IF !EMPTY(loc_oBO.this_cMensagemErro)
2222:                     MsgErro(loc_oBO.this_cMensagemErro, "Recalcular")
2223:                 ENDIF
2224:             ELSE
2225:                 loc_nItem      = loc_oBO.this_nItem
2226:                 loc_cAlias     = loc_oBO.this_cCursorItens
2227:                 loc_lManipulou = loc_oBO.this_lManipulou
2228: 
2229:                 THIS.ChamarRecalculoDoPai(loc_nItem)
2230: 
2231:                 IF USED(loc_cAlias)
2232:                     SELECT (loc_cAlias)
2233:                     LOCATE FOR cItens = loc_nItem
2234: 
2235:                     IF FOUND()
2236:                         loc_oBO.CarregarDoCursor(loc_cAlias)
2237:                         loc_oBO.this_lManipulou = loc_lManipulou
2238:                         THIS.BOParaForm()
2239:                     ELSE
2240:                         MsgAviso("Item " + TRANSFORM(loc_nItem) + " n" + CHR(227) + ;
2241:                                  "o foi encontrado no cursor de itens ap" + CHR(243) + ;
2242:                                  "s o rec" + CHR(225) + "lculo.", "Recalcular")
2243:                     ENDIF
2244:                 ENDIF
2245:             ENDIF
2246:         CATCH TO loc_oErro
2247:             MsgErro(loc_oErro.Message + CHR(13) + ;
2248:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2249:                     "Procedure: " + loc_oErro.Procedure, ;
2250:                     "Erro em FormSigOpImp.BtnRecalcularClick")
2251:         ENDTRY
2252:     ENDPROC
2253: 
2254:     *--------------------------------------------------------------------------
2255:     * BtnConfirmarClick - botao "\<Voltar" (legado cntBotoes.btnSair,
2256:     * Cancel = .T., ToolTip "[Esc] Retornar Para Tela Anterior").
2257:     *
2258:     * O handler leva o nome da ACAO, nao o do objeto legado: apesar do Caption
2259:     * "Voltar", este Click eh o caminho de CONFIRMACAO do dialogo - ele
2260:     * valida, grava AltImpost no cursor do pai, registra o log MANIMPOSTO e so
2261:     * entao fecha. Transcricao do Click legado:
2262:     *
2263:     *   With ThisForm
2264:     *       If ( (Empty(.Get_BIPI.Value)  And Not Empty(.Get_Ipi.Value)  ) Or ;
2265:     *            (Empty(.Get_BIcm.Value)  And Not Empty(.Get_Icms.Value) ) Or ;
2266:     *            (Empty(.Get_BIcms.Value) And Not Empty(.Get_Icmss.Value)) ) And ThisForm.Manipulou
2267:     *           If MessageBox('Confirma alteracao de imposto, zerando a base e mantendo o imposto?',4+256,'') = 7
2268:     *               Return .f.
2269:     *           Endif
2270:     *       Endif
2271:     *   EndWith
2272:     *   Replace crTpmMvItn.AltImpost With .t. in crTpmMvItn
2273:     *   ThisForm.ParentForm.Enabled = .t.
2274:     *   If ThisForm.maniPulou
2275:     *       lcTransacao = TprMvCab.Emps + TprMvCab.Dopes + Str(TprMvCab.Numes,6)
2276:     *       =fGravarLog('T', TprMvCab.Dopes, 'MANIMPOSTO', lcTransacao, Usuar)
2277:     *   Endif
2278:     *   ThisForm.Release
2279:     *
2280:     * Notas de transcricao:
2281:     *   - "MessageBox(...,4+256,'') = 7" eh Sim/Nao com Nao por default, e 7 eh
2282:     *     Nao: recusar ABORTA o fechamento. MsgConfirma devolve LOGICO
2283:     *     (regra #7), entao o teste eh "IF !MsgConfirma(...)".
2284:     *   - A condicao exige this_lManipulou - base zerada com imposto
2285:     *     preenchido so eh questionada quando o usuario de fato mexeu em
2286:     *     algo. Quem liga a flag eh o FormParaBO (ver comentario la).
2287:     *   - EMPTY sobre o valor NORMALIZADO (ValorNumerico): EMPTY("0,00") eh
2288:     *     .F. e inverteria a condicao se o TextBox devolvesse Caractere.
2289:     *   - AltImpost eh gravado por BO.AplicarAoCursor, dentro de

*-- Linhas 2299 a 2342:
2299:     * Sem RETURN dentro do TRY (regra #1): loc_lProsseguir carrega a recusa do
2300:     * usuario e o fechamento fica num IF depois do ENDTRY.
2301:     *--------------------------------------------------------------------------
2302:     PROCEDURE BtnConfirmarClick()
2303:         LOCAL loc_oBO, loc_lProsseguir, loc_lBaseZerada, loc_oErro
2304:         LOCAL loc_cCabecalho, loc_cOperacao, loc_cTransacao
2305: 
2306:         loc_lProsseguir = .F.
2307: 
2308:         TRY
2309:             loc_oBO = THIS.this_oBusinessObject
2310: 
2311:             THIS.FormParaBO()
2312: 
2313:             loc_lBaseZerada = ;
2314:                 (EMPTY(THIS.ValorNumerico(THIS.txt_4c_BIPI.Value))  AND !EMPTY(THIS.ValorNumerico(THIS.txt_4c_Ipi.Value)))   OR ;
2315:                 (EMPTY(THIS.ValorNumerico(THIS.txt_4c_BICM.Value))  AND !EMPTY(THIS.ValorNumerico(THIS.txt_4c_Icms.Value)))  OR ;
2316:                 (EMPTY(THIS.ValorNumerico(THIS.txt_4c_BICMS.Value)) AND !EMPTY(THIS.ValorNumerico(THIS.txt_4c_Icmss.Value)))
2317: 
2318:             loc_lProsseguir = .T.
2319: 
2320:             IF loc_lBaseZerada AND loc_oBO.this_lManipulou
2321:                 IF !MsgConfirma("Confirma altera" + CHR(231) + CHR(227) + "o de imposto, " + ;
2322:                                 "zerando a base e mantendo o imposto?", ;
2323:                                 "Manuten" + CHR(231) + CHR(227) + "o de Impostos")
2324:                     loc_lProsseguir = .F.
2325:                 ENDIF
2326:             ENDIF
2327: 
2328:             IF loc_lProsseguir
2329:                 IF !loc_oBO.Atualizar()
2330:                     IF !EMPTY(loc_oBO.this_cMensagemErro)
2331:                         MsgErro(loc_oBO.this_cMensagemErro, ;
2332:                                 "Manuten" + CHR(231) + CHR(227) + "o de Impostos")
2333:                     ENDIF
2334:                     loc_lProsseguir = .F.
2335:                 ENDIF
2336:             ENDIF
2337: 
2338:             IF loc_lProsseguir
2339:                 IF VARTYPE(THIS.this_oParentForm) = "O"
2340:                     THIS.this_oParentForm.Enabled = .T.
2341:                 ENDIF
2342: 

*-- Linhas 2361 a 2483:
2361:             loc_lProsseguir = .F.
2362:             MsgErro(loc_oErro.Message + CHR(13) + ;
2363:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2364:                     "Procedure: " + loc_oErro.Procedure, ;
2365:                     "Erro em FormSigOpImp.BtnConfirmarClick")
2366:         ENDTRY
2367: 
2368:         IF loc_lProsseguir
2369:             THIS.Release()
2370:         ENDIF
2371:     ENDPROC
2372: 
2373:     *--------------------------------------------------------------------------
2374:     * ChamarRecalculoDoPai - dispara o recalculo que pertence a tela de
2375:     * MOVIMENTO, equivalente as duas linhas do Click legado:
2376:     *
2377:     *   ThisForm.ParentForm.ParentForm.Atuatot()
2378:     *   Thisform.ParentForm.Parentform.CalcImposto(.f., xcItem, , .t.)
2379:     *
2380:     * Note o ParentForm DUPLO: quem tem esses metodos nao eh o form que abriu
2381:     * este dialogo, eh o AVO - a tela de movimento. Na arquitetura nova a
2382:     * referencia do pai mora em this_oParentForm (convencao do projeto, ver
2383:     * Formsigmvitn), entao o avo eh this_oParentForm.this_oParentForm.
2384:     *
2385:     * Atuatot e CalcImposto AINDA NAO EXISTEM no projeto migrado (medido em
2386:     * 2026-11-07: nenhum .prg os define) - sao metodos da tela de movimento,
2387:     * que ainda nao foi migrada. Por isso a chamada eh por despacho guardado
2388:     * (PEMSTATUS + TRY) e a AUSENCIA eh REPORTADA ao usuario em vez de
2389:     * silenciosa: reimplementar CalcImposto aqui seria reescrever formula de
2390:     * imposto por conta propria, que a regra #17 proibe, e um stub que
2391:     * devolvesse "recalculado" sem recalcular gravaria numero errado sem
2392:     * ninguem perceber (regra #27). Quando a tela de movimento for migrada com
2393:     * esses dois metodos PUBLIC, este caminho passa a funcionar sozinho, sem
2394:     * alterar este arquivo.
2395:     *
2396:     * CalcImposto leva o 3o argumento OMITIDO, como no legado - "f(a, b, , d)"
2397:     * eh forma valida em VFP9 (a mesma de "MESSAGEBOX(cTexto, , cTitulo)").
2398:     *
2399:     * Sem RETURN dentro do TRY (regra #1).
2400:     *--------------------------------------------------------------------------
2401:     PROTECTED PROCEDURE ChamarRecalculoDoPai(par_nItem)
2402:         LOCAL loc_oMovimento, loc_lChamou, loc_oErro
2403: 
2404:         loc_oMovimento = .NULL.
2405:         loc_lChamou    = .F.
2406: 
2407:         IF VARTYPE(THIS.this_oParentForm) = "O"
2408:             IF PEMSTATUS(THIS.this_oParentForm, "this_oParentForm", 5)
2409:                 IF VARTYPE(THIS.this_oParentForm.this_oParentForm) = "O"
2410:                     loc_oMovimento = THIS.this_oParentForm.this_oParentForm
2411:                 ENDIF
2412:             ENDIF
2413:         ENDIF
2414: 
2415:         IF VARTYPE(loc_oMovimento) = "O"
2416:             TRY
2417:                 IF PEMSTATUS(loc_oMovimento, "Atuatot", 5)
2418:                     loc_oMovimento.Atuatot()
2419:                 ENDIF
2420: 
2421:                 IF PEMSTATUS(loc_oMovimento, "CalcImposto", 5)
2422:                     loc_oMovimento.CalcImposto(.F., par_nItem, , .T.)
2423:                     loc_lChamou = .T.
2424:                 ENDIF
2425:             CATCH TO loc_oErro
2426:                 loc_lChamou = .F.
2427:                 MsgErro(loc_oErro.Message + CHR(13) + ;
2428:                         "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2429:                         "Procedure: " + loc_oErro.Procedure, ;
2430:                         "Erro ao recalcular os impostos na tela de movimento")
2431:             ENDTRY
2432:         ENDIF
2433: 
2434:         IF !loc_lChamou
2435:             MsgAviso("O rec" + CHR(225) + "lculo de impostos pertence " + CHR(224) + ;
2436:                      " tela de movimento (Atuatot / CalcImposto), que ainda n" + CHR(227) + ;
2437:                      "o est" + CHR(225) + " dispon" + CHR(237) + "vel." + CHR(13) + ;
2438:                      "Os valores digitados foram gravados no item, mas n" + CHR(227) + ;
2439:                      "o foram recalculados.", "Recalcular")
2440:         ENDIF
2441: 
2442:         RETURN loc_lChamou
2443:     ENDPROC
2444: 
2445:     *--------------------------------------------------------------------------
2446:     * TornarControlesVisiveis - torna todos os controles visiveis recursivamente
2447:     * FILTRO: nenhum container flutuante neste form (layout.json nao declara
2448:     * nenhum Visible = .F. em container)
2449:     *--------------------------------------------------------------------------
2450:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2451:         LOCAL loc_nI, loc_oControl
2452: 
2453:         FOR loc_nI = 1 TO par_oContainer.ControlCount
2454:             loc_oControl = par_oContainer.Controls(loc_nI)
2455:             IF VARTYPE(loc_oControl) = "O"
2456:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
2457:                     loc_oControl.Visible = .T.
2458:                 ENDIF
2459:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
2460:                     THIS.TornarControlesVisiveis(loc_oControl)
2461:                 ENDIF
2462:             ENDIF
2463:         ENDFOR
2464:     ENDPROC
2465: 
2466:     *--------------------------------------------------------------------------
2467:     * Destroy - libera recursos e REABILITA o form pai incondicionalmente,
2468:     * qualquer que tenha sido o caminho de saida deste dialogo. O legado so
2469:     * reabilita (ThisForm.ParentForm.Enabled = .t.) dentro do Click do botao
2470:     * Confirmar (Fase 7); sem esta rede de seguranca aqui, fechar o dialogo
2471:     * por outro caminho (ESC/botao de sistema) deixaria o form pai desabilitado
2472:     * para sempre.
2473:     *--------------------------------------------------------------------------
2474:     PROCEDURE Destroy()
2475:         IF VARTYPE(THIS.this_oParentForm) = "O"
2476:             THIS.this_oParentForm.Enabled = .T.
2477:         ENDIF
2478:         THIS.this_oParentForm = .NULL.
2479: 
2480:         DODEFAULT()
2481:     ENDPROC
2482: 
2483: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpImpBO.prg):
*====================================================================
* SigOpImpBO.prg
*
* Business Object para Manutencao de Impostos do Item (SIGOPIMP)
*
* Dialogo FILHO aberto pela tela de movimento (ParentForm.ParentForm)
* para ajustar manualmente os impostos de UM item da nota. No legado o
* form recebe (pForm, pnDatSes, pConexao) e trabalha sobre o cursor de
* itens do form pai - crTpmMvItn - posicionado no item corrente por
* cItens; o cabecalho vem de TprMvCab e a conta (cliente/fornecedor)
* de crSigMvNfi.cliFors.
*
* IMPORTANTE - este dialogo NAO grava em tabela de movimento: todo
* Replace do legado tem por destino o CURSOR do form pai (crTpmMvItn),
* e a persistencia fica com a tela de movimento, que recalcula os
* totais (Atuatot) e os impostos (CalcImposto) e so depois comita. Por
* isso Atualizar() aqui NAO monta um SQL UPDATE contra SigMvItn: ele
* aplica as propriedades this_* editadas de volta no cursor do form pai
* (REPLACE, igual ao legado) atraves de AplicarAoCursor() - a gravacao
* real na tabela fica a cargo da tela de movimento, de fora deste BO.
* O unico acesso remoto de escrita feito por este BO eh o UPDATE
* opcional de SigCdPro.ClFiscals, confirmado pelo usuario no lookup de
* Classificacao Fiscal (fase de lookup). Como o dialogo nunca cria nem
* exclui item - so ajusta um item ja existente - o comportamento padrao
* herdado de BusinessBase para Inserir()/ExecutarExclusao() ja eh o
* correto e este BO nao os sobrescreve.
*
* Tabelas de referencia (somente leitura):
*   SigMvItn  - estrutura/tipos das colunas do item (cursor crTpmMvItn)
*   SigCdClf  - Classificacao Fiscal (Codigos/Descricaos/BIcms)
*   SigCdCFO  - CFOP (Codigos/Descricaos/aliq*/ipis/icms)
*   SigCdPro  - Produto (ClFiscals/cgrus)
*   SigCdGRP  - Grupo do produto (servicos)
*   sigopfin  - aliquotas de imposto por conta (origem do FSigOpFin_imp
*               legado, usado quando a aliquota do CFOP vem zerada)
*
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigOpImpBO AS BusinessBase

    *----------------------------------------------------------------
    * ITEM EM EDICAO - colunas do cursor de itens do form pai
    * (crTpmMvItn no legado). Tipos conferidos em docs\schema.sql,
    * tabela SigMvItn, que eh a estrutura espelhada pelo cursor.
    *----------------------------------------------------------------
    this_nItem              = 0     && cItens   numeric(10,0) - chave do item no cursor
    this_cProduto           = ""    && Cpros    char(14)      - codigo do produto
    this_cDescricaoProduto  = ""    && Dpros    char(65)      - descricao do produto
    this_nTotal             = 0     && Totas    numeric(11,2) - total do item

    *-- IPI
    this_nAliqIpi           = 0     && Aliqs    numeric(4,2)  - percentual de IPI
    this_nValIpi            = 0     && ValIpis  numeric(11,2) - valor do IPI
    this_nBcIpi             = 0     && BcIpis   numeric(15,2) - base de calculo do IPI

    *-- ICMS
    this_nAliqIcms          = 0     && AliqIcms numeric(5,2)  - percentual de ICMS
    this_nIcms              = 0     && Icms     numeric(15,2) - valor do ICMS
    this_nBaseIcms          = 0     && BaseIcms numeric(11,2) - base de calculo do ICMS

    *-- ICMS Substituicao
    this_nIcmsSubst         = 0     && Icmss    numeric(15,2) - valor do ICMS substituicao
    this_nBcIcmsSubst       = 0     && BcIcmss  numeric(15,2) - base do ICMS substituicao

    *----------------------------------------------------------------
    * Base dos demais impostos e os valores calculados sobre ela.
    * O Valid do campo de base (getVBc) recalcula os sete valores
    * abaixo usando a aliquota do CFOP e, quando ela vem zerada, a
    * aliquota da conta; ISS/IRRF/INSS/CSSL so recebem valor quando o
    * grupo do produto eh de servico (servicos = 1).
    *----------------------------------------------------------------
    this_nValBase           = 0     && valbases numeric(11,2) - BC Imps
    this_nVPis              = 0     && vpis     numeric(11,2) - PIS
    this_nVCofins           = 0     && vcofins  numeric(11,2) - COFINS
    this_nTaxaIi            = 0     && taxaiis  numeric(11,2) - II (imposto de importacao)
    this_nIss               = 0     && iss      numeric(11,2) - ISS
    this_nIrrf              = 0     && irrf     numeric(11,2) - IRRF
    this_nInss              = 0     && inss     numeric(11,2) - INSS
    this_nCssl              = 0     && cssl     numeric(11,2) - CSSL

    *-- CFOP do item
    this_cCfop              = ""    && cfops    char(10)      - CFOP gravado no item

    *-- AltImpost NAO existe em SigMvItn: eh coluna de controle que so
    *-- existe no cursor de trabalho do form pai, marcada com .T. para
    *-- avisar a tela de movimento que o imposto foi ajustado a mao.
    this_lAltImposto        = .F.   && AltImpost (logico, somente no cursor)

    *----------------------------------------------------------------
    * CLASSIFICACAO FISCAL - SigCdClf
    * Codigo carregado do produto (SigCdPro.ClFiscals) no Init legado,
    * via Select a.ClFiscals, b.Descricaos From SigCdPro a, SigCdClf b
    *----------------------------------------------------------------
    this_cClFiscal          = ""    && SigCdClf.Codigos    char(10)
    this_cDescrClFiscal     = ""    && SigCdClf.Descricaos char(40)
    this_nBIcmsClFiscal     = 0     && SigCdClf.BIcms      numeric(9,6) - ICMS sugerido pela classificacao

    *----------------------------------------------------------------
    * CFOP - SigCdCFO
    * O Init legado le Descricaos/codigos/aliqpis/aliqcofins/aliqii/
    * aliqissqn; o Valid do campo CFOP usa tambem ipis/icms (marca de
    * tributacao com a letra T) e aliqipis/aliqivcs.
    *----------------------------------------------------------------
    this_cDescrCfop         = ""    && SigCdCFO.Descricaos char(60)
    this_nAliqIpiCfop       = 0     && SigCdCFO.aliqipis   numeric(4,2) - percentual de IPI do CFOP
    this_nAliqIcmsCfop      = 0     && SigCdCFO.aliqivcs   numeric(4,2) - percentual de ICMS do CFOP
    this_nAliqPisCfop       = 0     && SigCdCFO.aliqpis    numeric(5,2)
    this_nAliqCofinsCfop    = 0     && SigCdCFO.aliqcofins numeric(5,2)
    this_nAliqIiCfop        = 0     && SigCdCFO.aliqii     numeric(5,2)
    this_nAliqIssqnCfop     = 0     && SigCdCFO.aliqissqn  numeric(5,2)
    this_cTribIpiCfop       = ""    && SigCdCFO.ipis       char(1) - letra T indica tributado
    this_cTribIcmsCfop      = ""    && SigCdCFO.icms       char(1) - letra T indica tributado

    *----------------------------------------------------------------
    * PRODUTO / GRUPO - SigCdPro + SigCdGRP
    * servicos = 1 libera a digitacao de ISS/IRRF/INSS/CSSL (o When de
    * cada um desses campos devolve LocalGrp.servicos = 1 no legado).
    * servicos eh numeric(1,0) no schema - property NUMERICA, nunca
    * logica (eh coluna de dominio, nao booleana).
    *----------------------------------------------------------------
    this_cGrupoProduto      = ""    && SigCdPro.cgrus      char(3)
    this_nServicosGrupo     = 0     && SigCdGRP.servicos   numeric(1,0)

    *----------------------------------------------------------------
    * CONTEXTO RECEBIDO DO FORM PAI
    * Conta vem de crSigMvNfi.cliFors e eh o primeiro argumento do
    * FSigOpFin_imp legado (aliquota de imposto por conta).
    * Empresa/Operacao/Numero vem de TprMvCab e formam a chave de
    * transacao do log: Emps + Dopes + Str(Numes, 6) - concatenacao
    * POSICIONAL, por isso cada parte guarda a largura do schema.
    *----------------------------------------------------------------
    this_cConta             = ""    && crSigMvNfi.cliFors  char(20)
    this_cEmpresa           = ""    && SigMvCab.emps       char(3)
    this_cOperacao          = ""    && SigMvCab.dopes      char(20)
    this_nNumero            = 0     && SigMvCab.numes      numeric(6,0)
    this_cUsuario           = ""    && Usuar do legado - gc_4c_UsuarioLogado

    *----------------------------------------------------------------
    * ESTADO DO DIALOGO
    * this_lManipulou reproduz ThisForm.maniPulou: fica .T. quando
    * QUALQUER campo foi alterado pelo usuario, e eh o que decide se o
    * log MANIMPOSTO eh gravado e se a confirmacao de base zerada com
    * imposto mantido eh perguntada na saida.
    *----------------------------------------------------------------
    this_lManipulou         = .F.   && ThisForm.maniPulou
    this_lAtualizouProduto  = .F.   && .T. quando o UPDATE de SigCdPro.ClFiscals foi aplicado

    *-- Lista (separada por virgula) dos impostos que AplicarRecalculoBase()
    *-- NAO conseguiu recalcular por falta de aliquota de CFOP e de
    *-- FSigOpFin_imp (funcao legado ausente do acervo - regra #27). Vazia
    *-- quando o ultimo recalculo cobriu todos os impostos aplicaveis.
    this_cAliquotasIndisponiveis = ""

    *----------------------------------------------------------------
    * ALIAS DOS CURSORES
    * Os tres primeiros pertencem ao FORM PAI e chegam por parametro -
    * o dialogo LE e ESCREVE neles, nao os cria. Os demais sao locais
    * deste BO (lookups e consultas de aliquota).
    *----------------------------------------------------------------
    this_cCursorItens       = "crTpmMvItn"              && cursor de itens do form pai
    this_cCursorCabecalho   = "TprMvCab"                && cabecalho do movimento no form pai
    this_cCursorNfi         = "crSigMvNfi"              && nota fiscal no form pai (cliFors)
    this_cCursorClf         = "cursor_4c_ClFiscal"      && SigCdClf - classificacao fiscal
    this_cCursorCfo         = "cursor_4c_Cfop"          && SigCdCFO - CFOP
    this_cCursorGrp         = "cursor_4c_GrupoProduto"  && SigCdPro + SigCdGRP - servicos
    this_cCursorFin         = "cursor_4c_AliqFin"       && sigopfin - aliquota por conta
    this_cCursorBusca       = "cursor_4c_Busca"         && cursor dos lookups (FormBuscaAuxiliar)

    *====================================================================
    * Init - Inicializa Business Object
    *
    * Tabela/chave apontam para SigMvItn porque eh a estrutura do item
    * que este dialogo edita (o cursor do form pai a espelha). Nao se
    * passa a tabela ao DODEFAULT: sem DataAccess instanciado, nenhum
    * caminho herdado tenta gravar por conta propria - a persistencia
    * deste item eh responsabilidade da tela de movimento.
    *
    * O usuario logado eh lido com guarda de TYPE porque o BO tambem eh
    * instanciado em probe/modo de teste, quando as globais do config
    * ainda nao existem.
    *
    * Sem RETURN dentro do TRY (regra #1): a flag loc_lSucesso carrega o
    * resultado e o unico RETURN fica depois do ENDTRY.
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigMvItn"
            THIS.this_cCampoChave = "citens"

            *-- Usuario logado (Usuar do legado) para o log MANIMPOSTO
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                THIS.this_cUsuario = ALLTRIM(gc_4c_UsuarioLogado)
            ELSE
                THIS.this_cUsuario = ""
            ENDIF

            *-- Dialogo abre sempre em consulta do item corrente: nada foi
            *-- alterado ainda, e o item so eh marcado como ajustado a mao
            *-- quando o usuario confirma.
            THIS.this_lManipulou        = .F.
            THIS.this_lAltImposto       = .F.
            THIS.this_lAtualizouProduto = .F.

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpImpBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas do item (SigMvItn) do
    * cursor do form pai (crTpmMvItn, default this_cCursorItens) para as
    * propriedades this_*. Equivalente ao bloco de leitura do Init
    * legado (With ThisForm / .get_Produto.Value = crTpmMvItn.Cpros / ...).
    *
    * AltImpost NAO existe em SigMvItn (regra do cabecalho deste
    * arquivo): guarda por TYPE() antes de ler, porque so o cursor de
    * trabalho do form pai tem essa coluna extra.
    *====================================================================
    PROCEDURE CarregarDoCursor(pcCursor)
        LOCAL loc_cAlias

        loc_cAlias = IIF(EMPTY(pcCursor), THIS.this_cCursorItens, pcCursor)

        IF !USED(loc_cAlias)
            THIS.this_cMensagemErro = "Cursor de itens (" + loc_cAlias + ") n" + CHR(227) + "o est" + CHR(225) + " aberto"
            RETURN .F.
        ENDIF

        SELECT (loc_cAlias)

        THIS.this_nItem              = TratarNulo(cItens, 0)
        THIS.this_cProduto           = TratarNulo(Cpros, "")
        THIS.this_cDescricaoProduto  = TratarNulo(Dpros, "")
        THIS.this_nTotal             = TratarNulo(Totas, 0)

        THIS.this_nAliqIpi           = TratarNulo(Aliqs, 0)
        THIS.this_nValIpi            = TratarNulo(ValIpis, 0)
        THIS.this_nBcIpi             = TratarNulo(BcIpis, 0)

        THIS.this_nAliqIcms          = TratarNulo(AliqIcms, 0)
        THIS.this_nIcms              = TratarNulo(Icms, 0)
        THIS.this_nBaseIcms          = TratarNulo(BaseIcms, 0)

        THIS.this_nIcmsSubst         = TratarNulo(Icmss, 0)
        THIS.this_nBcIcmsSubst       = TratarNulo(BcIcmss, 0)

        THIS.this_nValBase           = TratarNulo(valbases, 0)
        THIS.this_nVPis              = TratarNulo(vpis, 0)
        THIS.this_nVCofins           = TratarNulo(vcofins, 0)
        THIS.this_nTaxaIi            = TratarNulo(taxaiis, 0)
        THIS.this_nIss               = TratarNulo(iss, 0)
        THIS.this_nIrrf              = TratarNulo(irrf, 0)
        THIS.this_nInss              = TratarNulo(inss, 0)
        THIS.this_nCssl              = TratarNulo(cssl, 0)

        THIS.this_cCfop              = TratarNulo(cfops, "")

        IF TYPE(loc_cAlias + ".AltImpost") = "L"
            THIS.this_lAltImposto = EVALUATE(loc_cAlias + ".AltImpost")
        ELSE
            THIS.this_lAltImposto = .F.
        ENDIF

        THIS.this_cCursorItens = loc_cAlias
        THIS.this_lManipulou   = .F.

        RETURN .T.
    ENDPROC

    *====================================================================
    * AplicarAoCursor - Grava as propriedades this_* editadas de volta no
    * cursor do item do form pai, via REPLACE (igual a cada Valid do
    * legado - Replace Icms With This.Value in crTpmMvItn - so que num
    * unico ponto, com todos os campos deste dialogo). Localiza a linha
    * pela chave (cItens) porque o cursor do form pai pode estar
    * posicionado em outro registro quando este metodo eh chamado.
    *
    * AltImpost so eh regravado quando a coluna existe no cursor (regra
    * de AltImpost acima) - este dialogo marca o item como "imposto
    * ajustado a mao", igual ao btnConfirmar.Click e ao btnSair.Click do
    * legado.
    *====================================================================
    PROCEDURE AplicarAoCursor(pcCursor)
        LOCAL loc_cAlias

        loc_cAlias = IIF(EMPTY(pcCursor), THIS.this_cCursorItens, pcCursor)

        IF !USED(loc_cAlias)
            THIS.this_cMensagemErro = "Cursor de itens (" + loc_cAlias + ") n" + CHR(227) + "o est" + CHR(225) + " aberto"
            RETURN .F.
        ENDIF

        SELECT (loc_cAlias)
        LOCATE FOR cItens = THIS.this_nItem

        IF !FOUND()
            THIS.this_cMensagemErro = "Item " + TRANSFORM(THIS.this_nItem) + " n" + CHR(227) + "o encontrado no cursor de itens"
            RETURN .F.
        ENDIF

        REPLACE Aliqs    WITH THIS.this_nAliqIpi, ;
                ValIpis  WITH THIS.this_nValIpi, ;
                BcIpis   WITH THIS.this_nBcIpi, ;
                AliqIcms WITH THIS.this_nAliqIcms, ;
                Icms     WITH THIS.this_nIcms, ;
                BaseIcms WITH THIS.this_nBaseIcms, ;
                Icmss    WITH THIS.this_nIcmsSubst, ;
                BcIcmss  WITH THIS.this_nBcIcmsSubst, ;
                valbases WITH THIS.this_nValBase, ;
                vpis     WITH THIS.this_nVPis, ;
                vcofins  WITH THIS.this_nVCofins, ;
                taxaiis  WITH THIS.this_nTaxaIi, ;
                iss      WITH THIS.this_nIss, ;
                irrf     WITH THIS.this_nIrrf, ;
                inss     WITH THIS.this_nInss, ;
                cssl     WITH THIS.this_nCssl, ;
                cfops    WITH THIS.this_cCfop ;
            IN (loc_cAlias)

        IF TYPE(loc_cAlias + ".AltImpost") = "L"
            REPLACE AltImpost WITH .T. IN (loc_cAlias)
        ENDIF

        RETURN .T.
    ENDPROC

    *====================================================================
    * Atualizar - OVERRIDE de BusinessBase.Atualizar().
    *
    * Para este dialogo, "atualizar" NAO eh um SQL UPDATE contra
    * SigMvItn: eh aplicar as propriedades this_* editadas de volta no
    * cursor do form pai (AplicarAoCursor), exatamente como o legado faz
    * a cada Valid de campo e no btnConfirmar/btnSair. A gravacao
    * definitiva na tabela (TABLEUPDATE) fica com a tela de movimento.
    *
    * O log de auditoria so eh registrado quando o usuario de fato
    * alterou algum valor (this_lManipulou), reproduzindo a mesma
    * condicao do legado (If ThisForm.maniPulou ... fGravarLog(...)) -
    * aqui pelo caminho padrao do sistema novo (LogAuditoria).
    *
    * Sem RETURN dentro do TRY/CATCH (regra #1).
    *====================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF THIS.AplicarAoCursor(THIS.this_cCursorItens)
                IF THIS.this_lManipulou
                    THIS.RegistrarAuditoria("ALTERAR")
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SigOpImpBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - OVERRIDE de BusinessBase.ObterChavePrimaria().
    *
    * A chave do registro editado por este dialogo eh o numero do item
    * (cItens) dentro do cursor de itens do form pai - eh o que
    * identifica a linha tanto no cursor quanto, mais tarde, na tabela
    * SigMvItn (junto com EmpDopNums, que pertence ao cabecalho).
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nItem)
    ENDPROC

    *====================================================================
    * LOOKUPS FISCAIS (FASE 6/8) - Classificacao Fiscal (SigCdClf) e CFOP
    * (SigCdCFO), chamados pelo Form a partir do LostFocus de
    * txt_4c_ClFiscals/txt_4c_DClFiscals e txt_4c__ccfop/txt_4c__dcfop.
    *====================================================================

    *====================================================================
    * BuscarClassificacaoFiscal - match EXATO por Codigos ou Descricaos
    * (par_cCampoBusca). Achando exatamente 1 registro, popula
    * this_cClFiscal/this_cDescrClFiscal/this_nBIcmsClFiscal e devolve
    * .T.; senao devolve .F. (o Form abre o picker).
    *====================================================================
    PROCEDURE BuscarClassificacaoFiscal(par_cCampoBusca, par_cValor)
        LOCAL loc_cAlias, loc_cSQL, loc_nResultado, loc_lAchou
        loc_cAlias = THIS.this_cCursorClf
        loc_lAchou = .F.

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT Codigos, Descricaos, BIcms FROM SigCdClf WHERE " + ;
                   par_cCampoBusca + " = " + EscaparSQL(par_cValor)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado > 0 AND RECCOUNT(loc_cAlias) = 1
            SELECT (loc_cAlias)
            THIS.this_cClFiscal      = ALLTRIM(Codigos)
            THIS.this_cDescrClFiscal = ALLTRIM(Descricaos)
            THIS.this_nBIcmsClFiscal = NVL(BIcms, 0)
            loc_lAchou = .T.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        RETURN loc_lAchou
    ENDPROC

    *====================================================================
    * AplicarAliquotaIcmsAoCursor - aplica a NOVA aliquota/ICMS (ja
    * calculados pelo Form com o BIcms sugerido pela Classificacao Fiscal)
    * direto no cursor do form pai - equivalente a:
    *   Replace AliqIcms With CrListaRemota.BIcms in crTpmMvItn
    *   xValor = ( crTpmMvItn.BaseIcms * CrListaRemota.BIcms / 100 )
    *   Replace Icms With xValor in crTpmMvItn
    *   ThisForm.maniPulou = .t.
    * do Valid de getClFiscals/getDClFiscals.
    *====================================================================
    PROCEDURE AplicarAliquotaIcmsAoCursor(par_nAliqIcms, par_nIcms)
        LOCAL loc_cAlias
        loc_cAlias = THIS.this_cCursorItens

        IF !USED(loc_cAlias)
            RETURN .F.
        ENDIF

        SELECT (loc_cAlias)
        LOCATE FOR cItens = THIS.this_nItem

        IF !FOUND()
            RETURN .F.
        ENDIF

        REPLACE AliqIcms WITH par_nAliqIcms, ;
                Icms     WITH par_nIcms ;
            IN (loc_cAlias)

        THIS.this_nAliqIcms  = par_nAliqIcms
        THIS.this_nIcms      = par_nIcms
        THIS.this_lManipulou = .T.

        RETURN .T.
    ENDPROC

    *====================================================================
    * AtualizarClassificacaoFiscalProduto - UPDATE SigCdPro.ClFiscals,
    * confirmado pelo usuario (MsgConfirma no Form). Equivalente a:
    *   Update SigCdPro Set ClFiscals = This.Value Where CPros = crTpmMvItn.CPros
    * do Valid de getClFiscals/getDClFiscals.
    *====================================================================
    PROCEDURE AtualizarClassificacaoFiscalProduto()
        LOCAL loc_cSQL, loc_nResultado

        loc_cSQL = "UPDATE SigCdPro SET ClFiscals = " + EscaparSQL(THIS.this_cClFiscal) + ;
                   " WHERE CPros = " + EscaparSQL(THIS.this_cProduto)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

        IF loc_nResultado < 0
            MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel atualizar a Classifica" + CHR(231) + CHR(227) + "o Fiscal do Produto." + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            RETURN .F.
        ENDIF

        THIS.this_lAtualizouProduto = .T.
        RETURN .T.
    ENDPROC

    *====================================================================
    * BuscarCfop - match EXATO por Codigos ou Descricaos (par_cCampoBusca).
    * Achando exatamente 1 registro, popula this_cCfop/this_cDescrCfop e
    * as aliquotas/flags de tributacao usadas por AplicarCfopSelecionado();
    * senao devolve .F. (o Form abre o picker).
    *====================================================================
    PROCEDURE BuscarCfop(par_cCampoBusca, par_cValor)
        LOCAL loc_cAlias, loc_cSQL, loc_nResultado, loc_lAchou
        loc_cAlias = THIS.this_cCursorCfo
        loc_lAchou = .F.

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT Codigos, Descricaos, aliqipis, aliqivcs, ipis, icms, " + ;
                   "aliqpis, aliqcofins, aliqii, aliqissqn " + ;
                   "FROM SigCdCFO WHERE " + par_cCampoBusca + " = " + EscaparSQL(par_cValor)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado > 0 AND RECCOUNT(loc_cAlias) = 1
            SELECT (loc_cAlias)
            THIS.this_cCfop           = ALLTRIM(Codigos)
            THIS.this_cDescrCfop      = ALLTRIM(Descricaos)
            THIS.this_nAliqIpiCfop    = NVL(aliqipis, 0)
            THIS.this_nAliqIcmsCfop   = NVL(aliqivcs, 0)
            THIS.this_cTribIpiCfop    = NVL(ipis, "")
            THIS.this_cTribIcmsCfop   = NVL(icms, "")
            THIS.this_nAliqPisCfop    = NVL(aliqpis, 0)
            THIS.this_nAliqCofinsCfop = NVL(aliqcofins, 0)
            THIS.this_nAliqIiCfop     = NVL(aliqii, 0)
            THIS.this_nAliqIssqnCfop  = NVL(aliqissqn, 0)
            loc_lAchou = .T.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        RETURN loc_lAchou
    ENDPROC

    *====================================================================
    * AplicarCfopSelecionado - rearma base de IPI/ICMS pela tributacao do
    * novo CFOP (letra 'T' em ipis/icms) contra o Total do item, troca a
    * aliquota de IPI/ICMS pela do CFOP e recalcula ValIpis/Icms com a
    * NOVA base e a NOVA aliquota - transcrito do legado (regra #17):
    *   IF crListaRemota.ipis <> 'T' / get_bIPI = 0 / ELSE / get_bIPI = Total
    *   IF crListaRemota.icms <> 'T' / get_bicm = 0 / ELSE / get_bicm = Total
    *   Replace BaseIcms/BcIpis com esses valores
    *   Replace cfops With o CFOP escolhido
    *   get_pIPI.Value = aliqipis -> get_pIPI.Valid (Aliqs = Value; SE
    *     Aliqs <> 0, ValIpis = BcIpis(NOVO) * Aliqs / 100 - mantem o valor
    *     anterior quando a aliquota vem zerada, igual ao legado)
    *   get_pICM.Value = aliqivcs -> get_pICM.Valid (AliqIcms = Value;
    *     Icms = BaseIcms(NOVO) * AliqIcms / 100 - SEMPRE recalculado)
    *====================================================================
    PROCEDURE AplicarCfopSelecionado()
        LOCAL loc_cAlias, loc_nBcIpi, loc_nBaseIcms, loc_nValIpi, loc_nIcms

        loc_cAlias = THIS.this_cCursorItens
        IF !USED(loc_cAlias)
            RETURN .F.
        ENDIF

        SELECT (loc_cAlias)
        LOCATE FOR cItens = THIS.this_nItem
        IF !FOUND()
            RETURN .F.
        ENDIF

        loc_nBcIpi    = IIF(THIS.this_cTribIpiCfop  == "T", THIS.this_nTotal, 0)
        loc_nBaseIcms = IIF(THIS.this_cTribIcmsCfop == "T", THIS.this_nTotal, 0)

        loc_nValIpi = THIS.this_nValIpi
        IF THIS.this_nAliqIpiCfop <> 0
            loc_nValIpi = ROUND(loc_nBcIpi * THIS.this_nAliqIpiCfop / 100, 2)
        ENDIF
        loc_nIcms = ROUND(loc_nBaseIcms * THIS.this_nAliqIcmsCfop / 100, 2)

        REPLACE BcIpis   WITH loc_nBcIpi, ;
                BaseIcms WITH loc_nBaseIcms, ;
                Aliqs    WITH THIS.this_nAliqIpiCfop, ;
                ValIpis  WITH loc_nValIpi, ;
                AliqIcms WITH THIS.this_nAliqIcmsCfop, ;
                Icms     WITH loc_nIcms, ;
                cfops    WITH THIS.this_cCfop ;
            IN (loc_cAlias)

        THIS.this_nBcIpi     = loc_nBcIpi
        THIS.this_nBaseIcms  = loc_nBaseIcms
        THIS.this_nAliqIpi   = THIS.this_nAliqIpiCfop
        THIS.this_nValIpi    = loc_nValIpi
        THIS.this_nAliqIcms  = THIS.this_nAliqIcmsCfop
        THIS.this_nIcms      = loc_nIcms
        THIS.this_lManipulou = .T.

        RETURN .T.
    ENDPROC


    *====================================================================
    * CarregarContextoDoProduto - transcreve as consultas de CONTEXTO que
    * o Init legado roda depois de preencher os campos de imposto. Sao
    * tres no dump; duas estao aqui e a terceira (CFOP) eh o BuscarCfop()
    * acima, que ja seleciona as MESMAS colunas e mais as aliquotas de
    * IPI/ICMS usadas por AplicarCfopSelecionado():
    *
    *   1) Classificacao Fiscal DO PRODUTO
    *      lcQuery = [Select a.ClFiscals, b.Descricaos ] + ;
    *                  [From SigCdPro a, SigCdClf b ] + ;
    *                 [Where a.CPros = '] + crTpmMvItn.CPros + [' And ] + ;
    *                       [a.ClFiscals = b.Codigos]
    *      If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalClf]) < 1)
    *          =MessageBox([Favor Reinicializar o Processo!!!], 16, ...)
    *          Return .f.
    *      EndIf
    *
    *   3) Grupo do produto (habilita os impostos de SERVICO - o When de
    *      getVIrrf/getVInss/getVCssl/getVIss do legado eh
    *      "Return LocalGrp.servicos = 1")
    *      lcQuery = [Select b.servicos From sigcdpro a, SigCdGRP b ] + ;
    *                [Where a.cpros = '] + crTpmMvItn.cpros + ;
    *                [' and a.cgrus = b.cgrus]
    *
    * O "< 1" do legado eh falha de EXECUCAO, NAO lista vazia: o
    * SqlExecute de classes\sigclcnx.PRG (linha 279) devolve o retorno CRU
    * do SQLEXEC do VFP (1 = ok, -1/-2 = erro), entao zero linha nao
    * aborta nada - produto sem classificacao casada so deixa os campos
    * em branco, igual ao legado. Por isso a guarda aqui eh
    * "loc_nResultado < 1" e nao RECCOUNT = 0.
    *
    * UNICO desvio, registrado: "a.cgrus" entra no SELECT da consulta 3
    * (o legado le so "b.servicos") para alimentar this_cGrupoProduto, que
    * ja esta declarada neste BO. Eh o MESMO join, sem filtro novo e sem
    * regra nova - nenhum valor calculado foi inventado (regra #17).
    *
    * Sem RETURN dentro do TRY (regra #1): a flag loc_lSucesso carrega o
    * resultado e o unico RETURN fica depois do ENDTRY.
    *====================================================================
    PROCEDURE CarregarContextoDoProduto()
        LOCAL loc_cAlias, loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cProduto)
                THIS.this_cMensagemErro = "Produto do item n" + CHR(227) + ;
                    "o carregado - contexto fiscal n" + CHR(227) + "o pode ser lido"
                MsgErro(THIS.this_cMensagemErro, "SigOpImpBO.CarregarContextoDoProduto")
            ELSE
                *-- Consulta 1: Classificacao Fiscal do produto
                loc_cAlias = THIS.this_cCursorClf
                IF USED(loc_cAlias)
                    USE IN (loc_cAlias)
                ENDIF

                loc_cSQL = "SELECT a.ClFiscals, b.Descricaos" + ;
                           "  FROM SigCdPro a, SigCdClf b" + ;
                           " WHERE a.CPros = " + EscaparSQL(THIS.this_cProduto) + ;
                           "   AND a.ClFiscals = b.Codigos"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                    MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + ;
                            "Falha na Conex" + CHR(227) + "o (Classifica" + CHR(231) + CHR(227) + "o Fiscal)" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                ELSE
                    IF RECCOUNT(loc_cAlias) > 0
                        SELECT (loc_cAlias)
                        GO TOP
                        THIS.this_cClFiscal      = ALLTRIM(TratarNulo(ClFiscals, ""))
                        THIS.this_cDescrClFiscal = ALLTRIM(TratarNulo(Descricaos, ""))
                    ELSE
                        THIS.this_cClFiscal      = ""
                        THIS.this_cDescrClFiscal = ""
                    ENDIF

                    IF USED(loc_cAlias)
                        USE IN (loc_cAlias)
                    ENDIF

                    *-- Consulta 3: grupo do produto (flag de servico)
                    loc_cAlias = THIS.this_cCursorGrp
                    IF USED(loc_cAlias)
                        USE IN (loc_cAlias)
                    ENDIF

                    loc_cSQL = "SELECT a.cgrus, b.servicos" + ;
                               "  FROM SigCdPro a, SigCdGrp b" + ;
                               " WHERE a.cpros = " + EscaparSQL(THIS.this_cProduto) + ;
                               "   AND a.cgrus = b.cgrus"

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

                    IF loc_nResultado < 1
                        THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                        MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                "Falha na Conex" + CHR(227) + "o (Grupo do Produto)" + CHR(13) + ;
                                CapturarErroSQL(), "Erro SQL")
                    ELSE
                        IF RECCOUNT(loc_cAlias) > 0
                            SELECT (loc_cAlias)
                            GO TOP
                            THIS.this_cGrupoProduto = ALLTRIM(TratarNulo(cgrus, ""))
                            *-- servicos eh numeric(1,0) no schema, mas o driver
                            *-- pode devolver Logico para coluna de 1 digito -
                            *-- testar VARTYPE antes de comparar (regra #13).
                            IF VARTYPE(servicos) = "N"
                                THIS.this_nServicosGrupo = NVL(servicos, 0)
                            ELSE
                                THIS.this_nServicosGrupo = IIF(NVL(servicos, .F.), 1, 0)
                            ENDIF
                        ELSE
                            THIS.this_cGrupoProduto  = ""
                            THIS.this_nServicosGrupo = 0
                        ENDIF

                        IF USED(loc_cAlias)
                            USE IN (loc_cAlias)
                        ENDIF

                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpImpBO.CarregarContextoDoProduto")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * AplicarRecalculoBase - FASE 8/8. Transcricao do Valid de getVBc
    * (regra #17 - formula literal), disparado quando o usuario altera a
    * Base dos Demais Impostos (BC Imps). O legado recalcula PIS/COFINS/
    * II/ISS/IRRF/INSS/CSSL usando, PARA CADA imposto, a aliquota do CFOP
    * (LocalCfo.aliq*) e, so quando ela vem ZERADA, cai para
    * FSigOpFin_imp(conta, '', '<IMPOSTO>', poDataMgr) - aliquota por
    * CONTA. Para IRRF/INSS/CSSL o legado NUNCA tem aliquota de CFOP (o
    * lnAli local comeca sempre em 0), entao esses tres SEMPRE dependeriam
    * de FSigOpFin_imp.
    *
    * FSigOpFin_imp eh funcao GLOBAL do legado (SIGFUNCS.PRG) que NAO veio
    * no acervo, e devolve um VALOR DE CALCULO (a aliquota configurada por
    * conta) - regra #27 probe exatamente este caso: "funcao ausente que
    * devolve valor de calculo fica AUSENTE, nunca substituida por stub
    * zerado" (stub 0% gravaria imposto errado em silencio - mais grave
    * que a ausencia aparecer). Por isso este metodo:
    *   - recalcula o que PODE ser calculado so com a aliquota do CFOP
    *     (ja carregada por BuscarCfop/AplicarCfopSelecionado), quando ela
    *     eh diferente de zero;
    *   - quando a aliquota do CFOP eh zero (ou o imposto eh um dos tres
    *     que nunca tem aliquota de CFOP), NAO grava 0% por conta propria -
    *     deixa o valor anterior do imposto e acrescenta o nome dele em
    *     this_cAliquotasIndisponiveis, para o Form avisar o usuario UMA
    *     vez so (regra #27 - ausencia REPORTADA, nunca silenciosa).
    *
    * ISS so entra quando o grupo do produto eh de servico (servicos = 1),
    * exatamente como o legado (Replace iss With Iif(LocalGrp.servicos=1,
    * ..., 0)); IRRF/INSS/CSSL seguem a mesma guarda.
    *====================================================================
    PROCEDURE AplicarRecalculoBase()
        LOCAL loc_nBase, loc_cIndisponiveis
        loc_nBase = THIS.this_nValBase
        loc_cIndisponiveis = ""

        *-- PIS
        IF THIS.this_nAliqPisCfop <> 0
            THIS.this_nVPis = ROUND(loc_nBase * THIS.this_nAliqPisCfop / 100, 2)
        ELSE
            loc_cIndisponiveis = loc_cIndisponiveis + "PIS, "
        ENDIF

        *-- COFINS
        IF THIS.this_nAliqCofinsCfop <> 0
            THIS.this_nVCofins = ROUND(loc_nBase * THIS.this_nAliqCofinsCfop / 100, 2)
        ELSE
            loc_cIndisponiveis = loc_cIndisponiveis + "COFINS, "
        ENDIF

        *-- II (imposto de importacao)
        IF THIS.this_nAliqIiCfop <> 0
            THIS.this_nTaxaIi = ROUND(loc_nBase * THIS.this_nAliqIiCfop / 100, 2)
        ELSE
            loc_cIndisponiveis = loc_cIndisponiveis + "II, "
        ENDIF

        *-- ISS (so quando o grupo do produto eh de servico)
        IF THIS.this_nServicosGrupo = 1
            IF THIS.this_nAliqIssqnCfop <> 0
                THIS.this_nIss = ROUND(loc_nBase * THIS.this_nAliqIssqnCfop / 100, 2)
            ELSE
                loc_cIndisponiveis = loc_cIndisponiveis + "ISS, "
            ENDIF
        ELSE
            THIS.this_nIss = 0
        ENDIF

        *-- IRRF / INSS / CSSL - o legado nunca tem aliquota de CFOP para
        *-- estes tres (lnAli comeca em 0 e so FSigOpFin_imp poderia
        *-- supri-lo) - sempre indisponivel quando o grupo eh de servico.
        IF THIS.this_nServicosGrupo = 1
            loc_cIndisponiveis = loc_cIndisponiveis + "IRRF, INSS, CSSL, "
        ELSE
            THIS.this_nIrrf = 0
            THIS.this_nInss = 0
            THIS.this_nCssl = 0
        ENDIF

        IF RIGHT(loc_cIndisponiveis, 2) = ", "
            loc_cIndisponiveis = LEFT(loc_cIndisponiveis, LEN(loc_cIndisponiveis) - 2)
        ENDIF
        THIS.this_cAliquotasIndisponiveis = loc_cIndisponiveis

        THIS.this_lManipulou = .T.
        RETURN .T.
    ENDPROC
ENDDEFINE

