# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (13)
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 4 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 4 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [METODO-INEXISTENTE] Metodo 'THIS.this_cOpEscolha()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-WITH] Bloco WITH loc_oGrid define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrid.RecordSource).
- [LAYOUT-POSITION] Controle 'btnRetCash' (parent: SIGOPPAG): Left original=672 vs migrado 'cmd_4c_BtnRetCash' Left=12 (diff=660px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Apaga' (parent: SIGOPPAG): Left original=748 vs migrado 'cmd_4c_Apaga' Left=88 (diff=660px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Ok' (parent: SIGOPPAG): Left original=898 vs migrado 'cmd_4c_Ok' Left=238 (diff=660px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'TotForma' (parent: SIGOPPAG): Top original=420 vs migrado 'txt_4c_TotForma' Top=459 (diff=39px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'TotForma' (parent: SIGOPPAG): Left original=445 vs migrado 'txt_4c_TotForma' Left=182 (diff=263px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Cancela' (parent: SIGOPPAG): Left original=973 vs migrado 'cmd_4c_Cancela' Left=313 (diff=660px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Desconto' (parent: SIGOPPAG): Top original=88 vs migrado 'lbl_4c_DescontoPercent' Top=514 (diff=426px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'totite' (parent: SIGOPPAG): Left original=823 vs migrado 'cmd_4c_Totite' Left=163 (diff=660px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigoppag.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2950 linhas total):

*-- Linhas 19 a 194:
19: * Page1=Lista/Page2=Dados do CRUD - PILAR 3 arquitetural, mas o layout
20: * visual (PILAR 1) e flat como o legado.
21: *
22: * Fase 3/8 - estrutura base: propriedades, Init()/InicializarForm(),
23: * e so os containers estruturais do cabecalho/area de botoes (prova de
24: * "casca" exigida pelo gate da Fase 3 para form OPERACIONAL com
25: * Container no legado). Grid de condicoes, os containers flutuantes de
26: * forma de pagamento e os botoes de acao entram nas fases seguintes.
27: *
28: * Fase 4/8 - GRADE + BOTOES DE ACAO (layout FLAT, sem PageFrame):
29: *   1) ConfigurarGrid(): Grid legado "Grade" -> grd_4c_Condicoes, criado
30: *      direto em THIS (este form OPERACIONAL nao tem PageFrame, logo NAO
31: *      ha compensacao +29 de Top nem os metodos de pagina/alternancia do
32: *      padrao CRUD - exigi-los obrigaria a inventar um PageFrame que o
33: *      legado nao tem, violando o PILAR 1). As 6 colunas transcritas do
34: *      dump (Verdana 8, HeaderHeight 18, RowHeight 16, ReadOnly = .F.,
35: *      larguras 148/120/78/30/80/90, ColumnOrder de venc = 5, InputMask
36: *      de valor/cambio/desconto).
37: *   2) ConfigurarBotoesAcao(): os 5 CommandButton de acao que o legado
38: *      REALMENTE tem na barra superior - btnRetCash/Apaga/totite/Ok/
39: *      Cancela (Top 3, 75x75, Comic Sans MS 8 bold italic). NAO existem
40: *      no SIGOPPAG os botoes genericos Incluir/Visualizar/Alterar/
41: *      Excluir/Buscar do padrao CRUD, e inventa-los violaria o PILAR 1.
42: *   3) CarregarLista(): metodo UNICO de carga/repintura da grade, com o
43: *      bind canonico ColumnCount -> RecordSource -> ControlSource ->
44: *      Width -> Header1.Caption (RecordSource RESETA Width/Caption) e
45: *      fechando com GO TOP + Refresh (regra #21a: popular cursor NAO
46: *      repinta a grade).
47: *
48: * Fase 5/8 - CAMPOS PRINCIPAIS (PARTE 1/2):
49: *   ConfigurarCamposCondicao(): primeira metade dos campos soltos do
50: *   dump que ficam direto em SIGOPPAG (fora de qualquer container
51: *   flutuante) - o bloco "Condicao/Parcelas/Vencimento/Moeda/Valor
52: *   Original" que alimenta a linha da grade em edicao. Transcritos
53: *   Top/Left/Width/Height do dump; sem Format/InputMask porque o dump
54: *   nao declara nenhum para estes controles (regra #49 - "" no dump e
55: *   override vazio do Form Designer, nao se transcreve). A segunda
56: *   metade (bloco de Totais/Saldo/Variacao/checkboxes/avisos de porta)
57: *   entrou na Fase 6/8, abaixo.
58: *
59: * Fase 6/8 - CAMPOS RESTANTES (PARTE 2/2) E LOOKUPS:
60: *   ConfigurarCamposTotais(): segunda metade dos campos soltos do dump -
61: *   o bloco "Valores Totais/Saldo/Variacao/Desconto%/Cambio/Bonus" e os
62: *   checkboxes de atalho (Bot_TotForma/Bot_TotItem/Bot_Cotacoes/Bot_Cpg/
63: *   btnMascPgto/btnCash) e os 6 avisos de porta (AvisoPorta*), ainda fora
64: *   dos containers flutuantes de forma de pagamento (esses continuam na
65: *   Fase 7/8, junto com os Click/When/InteractiveChange).
66: *
67: *   ConfigurarLookups(): os DOIS lookups que o dump tem em controle
68: *   FILHO DIRETO do form - txt_4c_Modfpg (moeda da forma de pagamento,
69: *   SigCdMoe, legado Get_modfpg.Valid) e txt_4c_Fpg (forma de pagamento,
70: *   SigOpFp, legado Get_fpg.Valid). Os outros seis lookups do dump
71: *   (getModalidade/getFormas/getAdquirente/getbandeira/getGrupo do
72: *   container cntFundo.cntMascPgto e get_adquire do container cntnsu)
73: *   pertencem a controles de containers FLUTUANTES que a Fase 7/8 cria -
74: *   BINDEVENT em objeto que ainda nao existe estoura no proprio bind,
75: *   logo eles acompanham a criacao dos seus containers. Observacao fiel
76: *   ao legado: cntMascPgto.getGrupo tem "PROCEDURE When / Return .F.",
77: *   isto e, o campo nunca recebe foco e o Valid dele nunca dispara.
78: *
79: *   Arquitetura dos lookups (funil unico por campo, regra #47 + contrato
80: *   de nome AbrirBusca*/AbrirLookup* dos patterns #114/#215/#217 do
81: *   CorretorAutomatico):
82: *     Validar<X>LostFocus  - wrapper FINO da guarda this_lEmLookup<X>,
83: *                            ligado por BINDEVENT "LostFocus"; libera a
84: *                            flag DEPOIS do corpo, para que RETURN
85: *                            antecipado la dentro nao trave o lookup
86: *     Validar<X>Corpo      - decide (valor digitado + conexao viva) e
87: *                            chama o funil
88: *     Modfpg/FpgKeyPress   - F4/F5 com guarda de tecla (INLIST 115/116),
89: *                            save/restore da flag
90: *     Modfpg/FpgDblClick   - duplo clique, save/restore da flag
91: *     AbrirBusca<X>        - o PICKER (FormBuscaAuxiliar), metodo PUBLIC
92: *                            proprio; regra #36 (1o argumento e o handle
93: *                            gnConnHandle) e regra #37 (Show() so sob
94: *                            !this_lAchouRegistro, atribuicao so sob
95: *                            this_lSelecionou, USE IN + Release())
96: *   As quatro portas desaguam no MESMO AbrirBusca<X>, guardado pela
97: *   flag, entao nao ha risco de dois pickers empilhados. O lookup de
98: *   Fpg usa um cursor local filtrado (CarregarFormasPagamento(), porta
99: *   PARCIAL do mGetcsSigFpag legado - linha 4136 do dump): o filtro por
100: *   Empresa + Moeda e a exclusao da forma de pagamento padrao da
101: *   operacao (SigCdOpe.FpagOpCrs) sao aplicados; o filtro de GRUPO
102: *   EMPRESARIAL (crSigCdEmp.grupo) e o de MASCARA de cartao (plMasc,
103: *   ligado ao container flutuante cntFundo.cntMascPgto, Fase 7/8) ficam
104: *   fora - dependem de cursores/containers que so entram depois. A
105: *   extensa validacao de negocio que vem apos o lookup no Valid legado
106: *   (parcelas, CPF, tabela de desconto, bonus, autorizacao via
107: *   SigOpSen) e regra de GRAVACAO, nao de lookup - fica para a Fase 7/8.
108: *
109: * Fase 7/8 - EVENTOS DOS 5 BOTOES REAIS DE ACAO (cmd_4c_BtnRetCash/Apaga/
110: * Totite/Ok/Cancela - NAO os genericos Incluir/Alterar/Visualizar/Excluir
111: * do padrao CRUD, que este form OPERACIONAL nao tem, regra do cabecalho):
112: *   ConfigurarEventosBotoes(): BINDEVENT do Click dos 5 botoes a metodos
113: *   PUBLIC (regra #3). btnRetCash tambem tem When no dump, mas CommandButton
114: *   do VFP9 nao tem evento When nativo (era campo GET da base fwbutton do
115: *   legado) - BtnRetCashWhen() fica PUBLIC e disponivel, sem BINDEVENT, para
116: *   quando um futuro "AjustarBotoesPorModo" (regra #40) for escrito aqui.
117: *
118: *   BtnExcluirCondicaoClick()/BtnConfirmarClick()/BtnCancelarClick()/BtnTotalProdutosClick()/BtnRetCashClick() -
119: *   portas fieis das 5 Click do dump, com tres pendencias EXPLICITAS
120: *   (documentadas em cada metodo, nunca omitidas em silencio - REGRA
121: *   FUNDAMENTAL do CLAUDE.md):
122: *     1) totite ("Total dos Produtos") abre "DO FORM SigOpTot" no legado;
123: *        SigOpTot NAO foi migrado (fora do escopo desta task) e "DO FORM"
124: *        nunca abre dialogo filho no projeto novo - o Click avisa o usuario
125: *        em vez de tentar um stub silencioso;
126: *     2) btnRetCash ("Retorna Bonus") depende de ThisForm.parentform.OpenCash,
127: *        metodo do FORM PAI (cabecalho do movimento) que ainda nao existe -
128: *        nenhum form do acervo cria "Formsigoppag" ainda. O Click confere
129: *        PEMSTATUS antes de chamar (forward-compatible) e avisa quando
130: *        ausente, em vez de quebrar a regra #13;
131: *     3) Apaga/Ok dependem de pecas que outras fases ainda nao construiram:
132: *        os containers .Desconto/.Acrescimo, FSigOpFin_NF (imposto de
133: *        servico), ThisForm.ParentForm.Cotacao()/CalcServico()/CalcImposto()/
134: *        Procrateio()/Totpar() e a autorizacao via "DO FORM SigOpSen"
135: *        (gate de autorizacao ausente, mesma pendencia de outras tasks do
136: *        projeto). Cada bloco que falta fica comentado no proprio metodo,
137: *        com o recalculo SIMPLIFICADO (soma direta, sem conversao de
138: *        cotacao entre moedas) documentado como desvio.
139: *
140: *   BtnCancelarClick() chama VerifTef() (funcao GLOBAL do legado, sem definicao
141: *   no acervo - wrapper no-op documentado em utils\verifteF.prg, regra #27)
142: *   e fecha o dialogo; BtnConfirmarClick() valida TODAS as condicoes ja lancadas na
143: *   grade (cheque duplicado, situacao do cliente bloqueando desconto,
144: *   campos obrigatorios por forma de pagamento, percentual de SigCdTif),
145: *   persiste cada linha via THIS.this_oBusinessObject.Inserir()/Atualizar()
146: *   e so entao fecha - a montagem da linha a partir dos campos soltos
147: *   (txt_4c_Fpg/Npar/Vpar/DataVenc) pertence ao Valid de Dataget_venc no
148: *   legado (dump linha 7552), que NAO e um dos 5 botoes desta fase.
149: *
150: * Fase 8/8 - EVENTOS AUXILIARES E CONSOLIDACAO FINAL:
151: *   AjustarBotoesPorModo(): centraliza o Enabled dos 5 botoes de acao
152: *   conforme this_cOpEscolha (regra #40 - quem desabilita no funil de
153: *   ida reabilita no de volta; aqui so ha "ida", chamado uma vez no
154: *   InicializarForm(), porque this_cOpEscolha nao muda durante a vida
155: *   deste dialogo modal).
156: *
157: *   HabilitarCampos()/LimparCampos(): portam os When() do dump que
158: *   dependem SO de this_cOpEscolha + preenchimento de Fpg (campos
159: *   totalizadores sao Return(.F.) no dump em QUALQUER modo). PENDENCIA
160: *   EXPLICITA (REGRA FUNDAMENTAL - nunca omitir em silencio): tres
161: *   When() do legado dependem de estado nao portado por fase alguma -
162: *   Thisform.Digpar (Get_npar), ThisForm.AplicaVariacao (Get_TVaria/
163: *   Get_pVaria) e o Seek em crSigCdCrg/CrSigCdMoe.Cotas (Get_COTACAO/
164: *   alteracotacao) - documentado dentro de HabilitarCampos(), nao
165: *   inventado.
166: *
167: *   FormParaBO()/BOParaForm() NAO SE APLICAM a este dialogo: o padrao
168: *   CRUD generico pressupoe UM registro em edicao espelhado 1-para-1
169: *   entre Form e BO, mas aqui cada linha da GRADE e uma condicao
170: *   independente, e o par funcional equivalente (BO.CarregarDoCursor()/
171: *   PersistirCondicoes(), Fase 2 e 7/8) ja transfere TODAS as colunas de
172: *   SigMvPar entre o cursor da grade e o BO a cada SCAN - inventar um
173: *   FormParaBO() que leia so os campos soltos (Fpg/Npar/Vpar/DataVenc)
174: *   duplicaria esse caminho sem cobrir as ~60 colunas que a grade nao
175: *   exibe (regra #22), e NAO seria chamado por nenhum fluxo real, dado
176: *   que a montagem da linha a partir dos campos soltos (Valid de
177: *   Dataget_venc, dump linha 7552) permanece fora de escopo (ver
178: *   BtnConfirmarClick, acima).
179: *
180: * Herda de: FormBase
181: *====================================================================
182: 
183: DEFINE CLASS Formsigoppag AS FormBase
184:     this_cMensagemErro = ""
185: 	ShowWindow = 1
186: 
187: 	*-- Propriedades visuais (dump do SCX legado - layout.json: Width
188: 	*-- 1050, Height 615, Caption "Recebimento")
189: 	Width = 1050
190: 	Height = 615
191: 	Caption = "Recebimento"
192: 	WindowType = 1              && Modal - form filho do cabecalho do movimento
193: 	AutoCenter = .T.
194: 	BorderStyle = 2

*-- Linhas 232 a 338:
232: 	*-- "ALTERAR": o proprio comentario da Fase 6/8 (CarregarFormasPagamento,
233: 	*-- acima) ja registra que "este form filho so abre" em INSERIR/ALTERAR;
234: 	*-- nenhum form do acervo ainda cria "Formsigoppag" (grep confirmado -
235: 	*-- zero CREATEOBJECT), entao nao ha, por ora, uma property real do pai
236: 	*-- para ler - Init() tenta "pcEscolha" via PEMSTATUS e so sobrescreve o
237: 	*-- default quando ela existir.
238: 	this_cOpEscolha = "ALTERAR"
239: 
240: 	*-- Guarda de reentrancia do fechamento do dialogo (Ok/Cancela) - evita
241: 	*-- Release() duplicado se o usuario conseguir disparar os dois botoes
242: 	*-- em sequencia muito rapida (ex.: Enter + Cancel do mesmo clique).
243: 	this_lFechando = .F.
244: 
245: 	*====================================================================
246: 	* Init - recebe o form pai, a DataSession compartilhada por ele e as
247: 	* duas flags de comportamento (equivalente ao Lparameters do Init
248: 	* legado). DODEFAULT() aciona FormBase.Init(), que chama o hook
249: 	*====================================================================
250: 	PROCEDURE Init(par_oFormPai, par_nDataSessionPai, par_lAltDireta, par_lAutomatico)
251: 		IF VARTYPE(par_oFormPai) = "O"
252: 			THIS.this_oFormPai = par_oFormPai
253: 
254: 			*-- Legado: ".Op_Escolha = pForm.pcEscolha" (dump linha 4999). So
255: 			*-- sobrescreve o default "ALTERAR" quando o pai de fato expoe a
256: 			*-- property - nenhum form do acervo ainda a declara.
257: 			IF PEMSTATUS(par_oFormPai, "pcEscolha", 5) AND VARTYPE(par_oFormPai.pcEscolha) = "C" AND !EMPTY(par_oFormPai.pcEscolha)
258: 				THIS.this_cOpEscolha = UPPER(ALLTRIM(par_oFormPai.pcEscolha))
259: 			ENDIF
260: 		ENDIF
261: 
262: 		IF VARTYPE(par_nDataSessionPai) = "N" AND par_nDataSessionPai > 0
263: 			THIS.this_nDataSessionPai = par_nDataSessionPai
264: 			SET DATASESSION TO (par_nDataSessionPai)
265: 		ENDIF
266: 
267: 		IF VARTYPE(par_lAltDireta) = "L"
268: 			THIS.this_lAltDireta = par_lAltDireta
269: 		ENDIF
270: 
271: 		IF VARTYPE(par_lAutomatico) = "L"
272: 			THIS.this_lAutomatico = par_lAutomatico
273: 		ENDIF
274: 
275: 		RETURN DODEFAULT()
276: 	ENDPROC
277: 
278: 	*====================================================================
279: 	* InicializarForm - hook chamado por FormBase.Init(). Le os escalares
280: 	* do cabecalho do movimento (TprMvCab, aberto pelo form pai na MESMA
281: 	* DataSession), instancia o BO com eles e monta o layout.
282: 	*====================================================================
283: 	PROTECTED PROCEDURE InicializarForm()
284: 		LOCAL loc_lSucesso, loc_cEmps, loc_cDopes, loc_nNumes
285: 
286: 		loc_lSucesso = .F.
287: 		loc_cEmps  = ""
288: 		loc_cDopes = ""
289: 		loc_nNumes = 0
290: 
291: 		IF USED("TprMvCab")
292: 			SELECT TprMvCab
293: 			loc_cEmps  = TratarNulo(Emps, "")
294: 			loc_cDopes = TratarNulo(Dopes, "")
295: 			loc_nNumes = TratarNulo(Numes, 0)
296: 		ENDIF
297: 
298: 		THIS.this_oBusinessObject = CREATEOBJECT("sigoppagBO", loc_cEmps, loc_cDopes, ;
299: 			loc_nNumes, THIS.this_lAltDireta, THIS.this_lAutomatico)
300: 
301: 		*-- Regra OPERACIONAL #4/precedente do projeto: SET DELETED ON global
302: 		*-- (start\config.prg) pode nao valer na DataSession deste form (ex.:
303: 		*-- rodando isolado, antes do SET DATASESSION TO do pai) - reposto
304: 		*-- aqui para que BtnExcluirCondicaoClick()/DELETE some da grade sem precisar de
305: 		*-- PACK (Fase 7/8).
306: 		SET DELETED ON
307: 
308: 		IF VARTYPE(THIS.this_oBusinessObject) = "O"
309: 			THIS.ConfigurarLayout()
310: 			THIS.ConfigurarBotoesAcao()
311: 			THIS.ConfigurarGrid()
312: 			THIS.ConfigurarCamposCondicao()
313: 			THIS.ConfigurarCamposTotais()
314: 			THIS.ConfigurarLookups()
315: 			THIS.ConfigurarEventosBotoes()
316: 
317: 			*-- Fase 7/8: cabecalho do movimento (TprMvCab/SigMvCab) +
318: 			*-- configuracao da operacao (SigCdOpe), usados pelos Click dos 5
319: 			*-- botoes de acao. Roda tambem em modo de validacao de UI (so
320: 			*-- faz leitura; sem gnConnHandle valido o SQLEXEC de SigCdOpe
321: 			*-- simplesmente nao preenche as propriedades *Ope, que ficam no
322: 			*-- default ja declarado).
323: 			THIS.this_oBusinessObject.CarregarConfiguracao()
324: 
325: 			*-- Fase 8/8: Enabled dos botoes de acao e dos campos soltos
326: 			*-- (depende de this_oBusinessObject.this_nParAutosOpe, logo
327: 			*-- roda SO depois de CarregarConfiguracao() acima).
328: 			THIS.AjustarBotoesPorModo()
329: 			THIS.HabilitarCampos()
330: 
331: 			*-- So busca SigMvPar por conta propria quando xPar (o cursor do
332: 			*-- form PAI) nao esta disponivel - replicar aqui com o pai
333: 			*-- presente duplicaria/sobrescreveria o buffer compartilhado
334: 			*-- dele (regra #21/comentario de CarregarLista abaixo).
335: 			IF !USED(THIS.this_cCursorLegado)
336: 				THIS.this_oBusinessObject.CarregarCondicoes()
337: 			ENDIF
338: 

*-- Linhas 359 a 402:
359: 	* botao ficam em Top = 0..80, DENTRO da area da faixa, e so desenham
360: 	* por cima dela se criados DEPOIS.
361: 	*====================================================================
362: 	PROTECTED PROCEDURE ConfigurarLayout()
363: 		THIS.AddObject("cnt_4c_Cabecalho", "Container")
364: 		WITH THIS.cnt_4c_Cabecalho
365: 			.Top = 0
366: 			.Left = 0
367: 			.Width = THIS.Width
368: 			.Height = 80
369: 			.BackStyle = 1
370: 			.BackColor = RGB(100, 100, 100)
371: 			.BorderWidth = 0
372: 			.SpecialEffect = 0
373: 			.Visible = .T.
374: 
375: 			.AddObject("lbl_4c_Sombra", "Label")
376: 			WITH .lbl_4c_Sombra
377: 				.Top = 15
378: 				.Left = 10
379: 				.Width = THIS.Width
380: 				.Height = 40
381: 				.FontName = "Tahoma"
382: 				.FontSize = 16
383: 				.FontBold = .T.
384: 				.ForeColor = RGB(0, 0, 0)
385: 				.BackStyle = 0
386: 				.AutoSize = .F.
387: 				.Caption = THIS.Caption
388: 				.Visible = .T.
389: 			ENDWITH
390: 
391: 			.AddObject("lbl_4c_Titulo", "Label")
392: 			WITH .lbl_4c_Titulo
393: 				.Top = 18
394: 				.Left = 10
395: 				.Width = THIS.Width
396: 				.Height = 46
397: 				.FontName = "Tahoma"
398: 				.FontSize = 16
399: 				.FontBold = .T.
400: 				.ForeColor = RGB(255, 255, 255)
401: 				.BackStyle = 0
402: 				.AutoSize = .F.

*-- Linhas 443 a 546:
443: 	*
444: 	* Os Click/When entram nas Fases 7-8 (esta fase entrega os controles).
445: 	*====================================================================
446: 	PROTECTED PROCEDURE ConfigurarBotoesAcao()
447: 		LOCAL loc_oCnt
448: 
449: 		loc_oCnt = THIS.cnt_4c_Botoes
450: 
451: 		*-- btnRetCash "Retorna Bonus" - nasce INVISIVEL no legado
452: 		*-- (Visible = .F. no dump); so aparece quando a operacao tem
453: 		*-- bonus/cashback liberado.
454: 		loc_oCnt.AddObject("cmd_4c_BtnRetCash", "CommandButton")
455: 		WITH loc_oCnt.cmd_4c_BtnRetCash
456: 			.Top = 3
457: 			.Left = 12
458: 			.Width = 75
459: 			.Height = 75
460: 			.FontName = "Comic Sans MS"
461: 			.FontSize = 8
462: 			.FontBold = .T.
463: 			.FontItalic = .T.
464: 			.ForeColor = RGB(90, 90, 90)
465: 			.BackColor = RGB(255, 255, 255)
466: 			.Themes = .T.
467: 			.SpecialEffect = 0
468: 			.AutoSize = .F.
469: 			.WordWrap = .T.
470: 			.MousePointer = 15
471: 			.PicturePosition = 7
472: 			.Picture = gc_4c_CaminhoIcones + "geral_calculadora_26.jpg"
473: 			.DisabledPicture = gc_4c_CaminhoIcones + "geral_calculadora_26.jpg"
474: 			.Caption = "Retorna B" + CHR(244) + "nus"
475: 			.ToolTipText = "Retorna B" + CHR(244) + "nus"
476: 			.Visible = .F.
477: 		ENDWITH
478: 
479: 		*-- Apaga "Excluir Condicao" - remove a condicao selecionada na grade
480: 		loc_oCnt.AddObject("cmd_4c_Apaga", "CommandButton")
481: 		WITH loc_oCnt.cmd_4c_Apaga
482: 			.Top = 3
483: 			.Left = 88
484: 			.Width = 75
485: 			.Height = 75
486: 			.FontName = "Comic Sans MS"
487: 			.FontSize = 8
488: 			.FontBold = .T.
489: 			.FontItalic = .T.
490: 			.ForeColor = RGB(90, 90, 90)
491: 			.BackColor = RGB(255, 255, 255)
492: 			.Themes = .T.
493: 			.SpecialEffect = 0
494: 			.AutoSize = .F.
495: 			.WordWrap = .T.
496: 			.PicturePosition = 7
497: 			.Picture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
498: 			.DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
499: 			.Caption = "Excluir Condi" + CHR(231) + CHR(227) + "o"
500: 			.ToolTipText = "Apagar Condi" + CHR(231) + CHR(227) + "o de Pagamento"
501: 			.Visible = .T.
502: 		ENDWITH
503: 
504: 		*-- totite "Total dos Produtos"
505: 		loc_oCnt.AddObject("cmd_4c_Totite", "CommandButton")
506: 		WITH loc_oCnt.cmd_4c_Totite
507: 			.Top = 3
508: 			.Left = 163
509: 			.Width = 75
510: 			.Height = 75
511: 			.FontName = "Comic Sans MS"
512: 			.FontSize = 8
513: 			.FontBold = .T.
514: 			.FontItalic = .T.
515: 			.ForeColor = RGB(90, 90, 90)
516: 			.BackColor = RGB(255, 255, 255)
517: 			.Themes = .T.
518: 			.SpecialEffect = 0
519: 			.AutoSize = .F.
520: 			.WordWrap = .T.
521: 			.PicturePosition = 7
522: 			.Picture = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
523: 			.DisabledPicture = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
524: 			.Caption = "Total dos Produtos"
525: 			.ToolTipText = "Total da Movimenta" + CHR(231) + CHR(227) + "o"
526: 			.Visible = .T.
527: 		ENDWITH
528: 
529: 		*-- Ok "Confirmar" - o "\<" do dump e o marcador de tecla de acesso
530: 		loc_oCnt.AddObject("cmd_4c_Ok", "CommandButton")
531: 		WITH loc_oCnt.cmd_4c_Ok
532: 			.Top = 3
533: 			.Left = 238
534: 			.Width = 75
535: 			.Height = 75
536: 			.FontName = "Comic Sans MS"
537: 			.FontSize = 8
538: 			.FontBold = .T.
539: 			.FontItalic = .T.
540: 			.ForeColor = RGB(90, 90, 90)
541: 			.BackColor = RGB(255, 255, 255)
542: 			.Themes = .T.
543: 			.SpecialEffect = 0
544: 			.AutoSize = .F.
545: 			.PicturePosition = 13
546: 			.Picture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"

*-- Linhas 553 a 574:
553: 		*-- Cancela "Encerrar" - criado DEPOIS do Ok de proposito: o dump
554: 		*-- traz Cancel = .T. nos DOIS botoes e, em VFP9, o ultimo a
555: 		*-- receber Cancel = .T. e quem responde ao ESC. Mantendo a ordem
556: 		*-- do legado, o ESC continua fechando a tela ([ESC] Sair no
557: 		*-- ToolTipText do proprio dump).
558: 		loc_oCnt.AddObject("cmd_4c_Cancela", "CommandButton")
559: 		WITH loc_oCnt.cmd_4c_Cancela
560: 			.Top = 3
561: 			.Left = 313
562: 			.Width = 75
563: 			.Height = 75
564: 			.FontName = "Comic Sans MS"
565: 			.FontSize = 8
566: 			.FontBold = .T.
567: 			.FontItalic = .T.
568: 			.ForeColor = RGB(90, 90, 90)
569: 			.BackColor = RGB(255, 255, 255)
570: 			.Themes = .T.
571: 			.SpecialEffect = 0
572: 			.AutoSize = .F.
573: 			.PicturePosition = 13
574: 			.Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"

*-- Linhas 607 a 650:
607: 	* ReadOnly = .F.). Column1 e a UNICA ReadOnly = .T., e isso e aplicado
608: 	* DEPOIS do ReadOnly do Grid, que propaga para as colunas.
609: 	*====================================================================
610: 	PROTECTED PROCEDURE ConfigurarGrid()
611: 		LOCAL loc_cCursor
612: 
613: 		loc_cCursor = THIS.this_cCursorCondicoes
614: 
615: 		IF !USED(loc_cCursor)
616: 			SET NULL ON
617: 			CREATE CURSOR (loc_cCursor) ;
618: 				(cidchaves C(20) NULL, emps C(3) NULL, dopes C(20) NULL, ;
619: 				 numes N(6, 0) NULL, fpags C(12) NULL, valos N(11, 2) NULL, ;
620: 				 vencs T NULL, moefpgs C(3) NULL, cotfpgs N(11, 4) NULL, ;
621: 				 valdescs N(11, 2) NULL, inschs L NULL, numchqs C(8) NULL, ;
622: 				 nidcheps N(10, 0) NULL, trocos N(1, 0) NULL)
623: 			SET NULL OFF
624: 		ENDIF
625: 
626: 		THIS.AddObject("grd_4c_Condicoes", "Grid")
627: 		WITH THIS.grd_4c_Condicoes
628: 			.Top = 107
629: 			.Left = 444
630: 			.Width = 573
631: 			.Height = 246
632: 			.FontName = "Verdana"
633: 			.FontSize = 8
634: 			.HeaderHeight = 18
635: 			.RowHeight = 16
636: 			.ReadOnly = .F.
637: 			.RecordMark = .F.
638: 			.DeleteMark = .F.
639: 			.ChildOrder = ""
640: 			.ScrollBars = 2
641: 			.GridLines = 1
642: 			.GridLineColor = RGB(238, 238, 238)
643: 			.HighlightBackColor = RGB(255, 255, 255)
644: 			.HighlightForeColor = RGB(15, 41, 104)
645: 			.HighlightStyle = 2
646: 			.Visible = .T.
647: 
648: 			*-- Propriedades das colunas que NAO dependem do cursor. As que
649: 			*-- dependem (ControlSource) e as que o RecordSource RESETA
650: 			*-- (Width, Header1.Caption) ficam em CarregarLista().

*-- Linhas 718 a 761:
718: 	*   Line1          -> lin_4c_Line1        (292,41,370,1)   divisor
719: 	*   Shape1         -> shp_4c_Shape1       (9,640,1,27)     divisor
720: 	*====================================================================
721: 	PROTECTED PROCEDURE ConfigurarCamposCondicao()
722: 		*-- Condicao (fpags - char(12)) + modalidade da forma de pgto
723: 		THIS.AddObject("lbl_4c_Condicao", "Label")
724: 		WITH THIS.lbl_4c_Condicao
725: 			.Top = 147
726: 			.Left = 96
727: 			.Width = 78
728: 			.AutoSize = .F.
729: 			.Alignment = 0
730: 			.FontName = "Tahoma"
731: 			.FontSize = 8
732: 			.ForeColor = RGB(90, 90, 90)
733: 			.BackStyle = 0
734: 			.Caption = "Condi" + CHR(231) + CHR(227) + "o :"
735: 			.Visible = .T.
736: 		ENDWITH
737: 
738: 		THIS.AddObject("txt_4c_Modfpg", "TextBox")
739: 		WITH THIS.txt_4c_Modfpg
740: 			.Top = 142
741: 			.Left = 178
742: 			.Width = 36
743: 			.Height = 25
744: 			.FontName = "Tahoma"
745: 			.FontSize = 8
746: 			.Value = 0
747: 			.Visible = .T.
748: 		ENDWITH
749: 
750: 		THIS.AddObject("txt_4c_Fpg", "TextBox")
751: 		WITH THIS.txt_4c_Fpg
752: 			.Top = 142
753: 			.Left = 218
754: 			.Width = 147
755: 			.Height = 25
756: 			.FontName = "Tahoma"
757: 			.FontSize = 8
758: 			.Value = ""
759: 			.Visible = .T.
760: 		ENDWITH
761: 

*-- Linhas 962 a 1030:
962: 	*   Get_valtot     -> txt_4c_ValTot        (432,182,146,25) numeric
963: 	*   Get_pVaria     -> txt_4c_PVaria        (513,182,146,25) numeric
964: 	*   Say3           -> lbl_4c_DescontoPercent (514,90,88,16) "Desconto (%) :"
965: 	*   Get_Saldo      -> txt_4c_Saldo         (486,182,146,25) numeric
966: 	*   Say1           -> lbl_4c_Saldo         (491,134) "Saldo :"
967: 	*   Get_TotForma   -> txt_4c_TotForma      (459,182,146,25) numeric
968: 	*   Say4           -> lbl_4c_DescontoCifrao (545,95,83,16) "Desconto ($) :"
969: 	*   Get_TVaria     -> txt_4c_TVaria        (540,182,146,25) numeric
970: 	*   Get_pDescP     -> txt_4c_PDescP        (570,769,71,23) numeric
971: 	*   Get_VDescP     -> txt_4c_VDescP        (570,858,111,23) numeric
972: 	*   Label2         -> lbl_4c_PercentVDescP (575,750,16,15) "%"
973: 	*   Label1         -> lbl_4c_CifraoVDescP  (575,845,10,15) "$"
974: 	*   lblValUtiCsh   -> lbl_4c_ValUtiCsh     (86,758) "Bonus :"
975: 	*   getValUtiCsh   -> txt_4c_ValUtiCsh     (82,805,117,25) numeric
976: 	*   btnCash        -> chk_4c_BtnCash       (83,924,111,23) "Aplicar Bonus"
977: 	*   Get_COTACAO    -> txt_4c_Cotacao       (196,178,100,25) numeric - oculto no dump
978: 	*   alteracotacao  -> cmd_4c_AlteraCotacao (196,281,26,26) "\<C$" - oculto no dump
979: 	*   Say_Cotacao    -> lbl_4c_Cambio        (201,123) "Cambio :" - oculto no dump
980: 	*   Bot_Cpg        -> chk_4c_BotCpg        (142,368,26,26) "$"
981: 	*   Bot_Cotacoes   -> chk_4c_BotCotacoes   (297,220,33,26)
982: 	*   Bot_TotItem    -> chk_4c_BotTotItem    (324,331,33,26)
983: 	*   Bot_TotForma   -> chk_4c_BotTotForma   (459,331,33,26)
984: 	*   btnMascPgto    -> chk_4c_BtnMascPgto   (142,397,26,26) "..." - oculto no dump
985: 	*   Say10          -> lbl_4c_Movimentacao  (437,90) "Movimentacao :"
986: 	*   Say23          -> lbl_4c_Recebimento   (464,96) "Recebimento :"
987: 	*   lbl_Mensagem   -> lbl_4c_Mensagem      (85,444,276,18) "Mensagem" - oculto no dump
988: 	*   AvisoPortaS/M/T/C/A/K -> txt_4c_AvisoPorta<X> (108/132/156/180/204/228, 1020,20,23)
989: 	*====================================================================
990: 	PROTECTED PROCEDURE ConfigurarCamposTotais()
991: 		*-- Titulo da secao "Valores Totais" (Say6 - classe say pura, sem
992: 		*-- Width/Alignment declarados no dump, regra #23)
993: 		THIS.AddObject("lbl_4c_ValoresTotais", "Label")
994: 		WITH THIS.lbl_4c_ValoresTotais
995: 			.Top = 273
996: 			.Left = 70
997: 			.Width = 87
998: 			.Height = 16
999: 			.AutoSize = .F.
1000: 			.Alignment = 0
1001: 			.FontName = "Tahoma"
1002: 			.FontSize = 8
1003: 			.ForeColor = RGB(90, 90, 90)
1004: 			.BackStyle = 0
1005: 			.Caption = "Valores Totais"
1006: 			.Visible = .T.
1007: 		ENDWITH
1008: 
1009: 		*-- Total de servicos (Get_TotServico)
1010: 		THIS.AddObject("lbl_4c_Servicos", "Label")
1011: 		WITH THIS.lbl_4c_Servicos
1012: 			.Top = 356
1013: 			.Left = 124
1014: 			.Width = 55
1015: 			.AutoSize = .F.
1016: 			.Alignment = 0
1017: 			.FontName = "Tahoma"
1018: 			.FontSize = 8
1019: 			.ForeColor = RGB(90, 90, 90)
1020: 			.BackStyle = 0
1021: 			.Caption = "Servi" + CHR(231) + "os :"
1022: 			.Visible = .T.
1023: 		ENDWITH
1024: 
1025: 		THIS.AddObject("txt_4c_TotServico", "TextBox")
1026: 		WITH THIS.txt_4c_TotServico
1027: 			.Top = 351
1028: 			.Left = 182
1029: 			.Width = 146
1030: 			.Height = 25

*-- Linhas 1102 a 1123:
1102: 			.Value = 0
1103: 			.Visible = .T.
1104: 		ENDWITH
1105: 
1106: 		*-- Total das formas de pagamento ja lancadas (Get_TotForma)
1107: 		THIS.AddObject("txt_4c_TotForma", "TextBox")
1108: 		WITH THIS.txt_4c_TotForma
1109: 			.Top = 459
1110: 			.Left = 182
1111: 			.Width = 146
1112: 			.Height = 25
1113: 			.FontName = "Tahoma"
1114: 			.FontSize = 8
1115: 			.Value = 0
1116: 			.Visible = .T.
1117: 		ENDWITH
1118: 
1119: 		*-- Saldo a distribuir (Get_Saldo)
1120: 		THIS.AddObject("lbl_4c_Saldo", "Label")
1121: 		WITH THIS.lbl_4c_Saldo
1122: 			.Top = 491
1123: 			.Left = 134

*-- Linhas 1574 a 1617:
1574: 	* (regra #3 - PEMSTATUS nao verifica escopo e a chamada falharia em
1575: 	* runtime com "Property CARREGARLISTA is not found").
1576: 	*====================================================================
1577: 	PROCEDURE CarregarLista()
1578: 		LOCAL loc_lSucesso, loc_cAlias, loc_oGrid, loc_cDynFore, loc_oErro
1579: 
1580: 		loc_lSucesso = .F.
1581: 
1582: 		TRY
1583: 			*-- Fonte: xPar do form pai quando disponivel; senao o
1584: 			*-- cursor local de apoio, de mesma estrutura.
1585: 			loc_cAlias = THIS.this_cCursorLegado
1586: 			IF !USED(loc_cAlias)
1587: 				loc_cAlias = THIS.this_cCursorCondicoes
1588: 			ENDIF
1589: 
1590: 			IF USED(loc_cAlias) AND PEMSTATUS(THIS, "grd_4c_Condicoes", 5)
1591: 				loc_oGrid = THIS.grd_4c_Condicoes
1592: 
1593: 				SELECT (loc_cAlias)
1594: 				SET ORDER TO
1595: 				GO TOP
1596: 
1597: 				WITH loc_oGrid
1598: 					*-- 1) ColumnCount (sempre antes do RecordSource, para o
1599: 					*-- Grid nao auto-expandir para todas as colunas do cursor)
1600: 					.ColumnCount = 6
1601: 
1602: 					*-- 2) RecordSource
1603: 					.RecordSource = loc_cAlias
1604: 
1605: 					*-- 3) ControlSource (dump: Fpags/Valos/Vencs/MoeFPgs/
1606: 					*-- CotFPgs/ValDescs)
1607: 					.Column1.ControlSource = loc_cAlias + ".fpags"
1608: 					.Column2.ControlSource = loc_cAlias + ".valos"
1609: 					.Column3.ControlSource = loc_cAlias + ".vencs"
1610: 					.Column4.ControlSource = loc_cAlias + ".moefpgs"
1611: 					.Column5.ControlSource = loc_cAlias + ".cotfpgs"
1612: 					.Column6.ControlSource = loc_cAlias + ".valdescs"
1613: 
1614: 					*-- 4) Width (o RecordSource acima zera para o default 90)
1615: 					.Column1.Width = 148
1616: 					.Column2.Width = 120
1617: 					.Column3.Width = 78

*-- Linhas 1695 a 2175:
1695: 			MsgErro("Erro ao carregar a grade de condi" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
1696: 				loc_oErro.Message + CHR(13) + ;
1697: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1698: 				"Procedure: " + loc_oErro.Procedure, "Erro")
1699: 		ENDTRY
1700: 
1701: 		RETURN loc_lSucesso
1702: 	ENDPROC
1703: 
1704: 	*====================================================================
1705: 	* ConfigurarLookups - liga os DOIS lookups identificados no dump
1706: 	* (analise.json) em "LostFocus" (regra #47 - o legado valida os dois
1707: 	* no Valid do TextBox, ao SAIR do campo; nunca em "KeyPress" sem
1708: 	* testar a tecla).
1709: 	*====================================================================
1710: 	PROTECTED PROCEDURE ConfigurarLookups()
1711: 		*-- Porta principal: o legado valida no Valid, isto e, ao SAIR do
1712: 		*-- campo (regra #47 - nunca "KeyPress" sem testar a tecla).
1713: 		BINDEVENT(THIS.txt_4c_Modfpg, "LostFocus", THIS, "ValidarModfpgLostFocus")
1714: 		BINDEVENT(THIS.txt_4c_Fpg, "LostFocus", THIS, "ValidarFpgLostFocus")
1715: 
1716: 		*-- Portas auxiliares do padrao do projeto para abrir o picker com o
1717: 		*-- campo ainda vazio: F4/F5 (com guarda de tecla) e duplo clique.
1718: 		BINDEVENT(THIS.txt_4c_Modfpg, "KeyPress", THIS, "ModfpgKeyPress")
1719: 		BINDEVENT(THIS.txt_4c_Modfpg, "DblClick", THIS, "ModfpgDblClick")
1720: 		BINDEVENT(THIS.txt_4c_Fpg, "KeyPress", THIS, "FpgKeyPress")
1721: 		BINDEVENT(THIS.txt_4c_Fpg, "DblClick", THIS, "FpgDblClick")
1722: 	ENDPROC
1723: 
1724: 	*====================================================================
1725: 	* ValidarModfpgLostFocus - lookup da MOEDA da forma de pagamento
1726: 	* (txt_4c_Modfpg -> SigCdMoe.cmoes/dmoes), porta de
1727: 	* SIGOPPAG.Get_modfpg.Valid (dump linha ~9032): o legado tenta match
1728: 	* exato via fwbuscaext e so abre o picker se nao achar; aqui o
1729: 	* proprio Init do FormBuscaAuxiliar (regra #36) ja faz o match exato,
1730: 	* e o Show() so roda em cima dele quando necessario.
1731: 	*
1732: 	* Este metodo e o WRAPPER FINO da guarda de reentrancia: o picker e
1733: 	* MODAL, tira o foco e redispara o proprio LostFocus, entao a flag
1734: 	* this_lEmLookupModfpg tem de ser liberada DEPOIS do corpo - por isso
1735: 	* o corpo mora em ValidarModfpgCorpo(), onde os RETURN antecipados
1736: 	* nao conseguem travar a flag ligada.
1737: 	*
1738: 	* PUBLIC (regra #3 - BINDEVENT so dispara metodo PUBLIC).
1739: 	*====================================================================
1740: 	PROCEDURE ValidarModfpgLostFocus()
1741: 		IF THIS.this_lEmLookupModfpg
1742: 			RETURN
1743: 		ENDIF
1744: 
1745: 		THIS.this_lEmLookupModfpg = .T.
1746: 		THIS.ValidarModfpgCorpo()
1747: 		THIS.this_lEmLookupModfpg = .F.
1748: 	ENDPROC
1749: 
1750: 	*====================================================================
1751: 	* ValidarModfpgCorpo - decide se ha o que buscar (legado: o Valid
1752: 	* inteiro esta dentro de "If Not Empty(This.Value)") e chama o funil
1753: 	* do picker. gnConnHandle > 0 e guarda do modo de teste/UI, onde o
1754: 	* handle vale -1 (regra do gb_4c_ValidandoUI).
1755: 	*====================================================================
1756: 	PROCEDURE ValidarModfpgCorpo()
1757: 		IF EMPTY(ALLTRIM(TRANSFORM(THIS.txt_4c_Modfpg.Value)))
1758: 			RETURN
1759: 		ENDIF
1760: 
1761: 		IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
1762: 			RETURN
1763: 		ENDIF
1764: 
1765: 		THIS.AbrirBuscaMoeda()
1766: 	ENDPROC
1767: 
1768: 	*====================================================================
1769: 	* ModfpgKeyPress - F4/F5 abrem o picker com o campo ainda vazio.
1770: 	* Guarda de tecla OBRIGATORIA (regra #47 - handler ligado a
1771: 	* "KeyPress" sem testar a tecla abre o dialogo a CADA caractere e o
1772: 	* usuario nao consegue terminar de digitar o codigo).
1773: 	*
1774: 	* A flag usa save/restore (nao set/clear): este handler e um IRMAO do
1775: 	* funil e pode ser alcancado de dentro dele.
1776: 	*====================================================================
1777: 	PROCEDURE ModfpgKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1778: 		LOCAL loc_lEmLookupAnt
1779: 
1780: 		IF !INLIST(par_nKeyCode, 115, 116)
1781: 			RETURN
1782: 		ENDIF
1783: 
1784: 		IF THIS.this_lEmLookupModfpg
1785: 			RETURN
1786: 		ENDIF
1787: 
1788: 		IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
1789: 			RETURN
1790: 		ENDIF
1791: 
1792: 		loc_lEmLookupAnt = THIS.this_lEmLookupModfpg
1793: 		THIS.this_lEmLookupModfpg = .T.
1794: 		THIS.AbrirBuscaMoeda()
1795: 		THIS.this_lEmLookupModfpg = loc_lEmLookupAnt
1796: 	ENDPROC
1797: 
1798: 	*====================================================================
1799: 	* ModfpgDblClick - duplo clique abre o picker (mesmo funil).
1800: 	*====================================================================
1801: 	PROCEDURE ModfpgDblClick()
1802: 		LOCAL loc_lEmLookupAnt
1803: 
1804: 		IF THIS.this_lEmLookupModfpg
1805: 			RETURN
1806: 		ENDIF
1807: 
1808: 		IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
1809: 			RETURN
1810: 		ENDIF
1811: 
1812: 		loc_lEmLookupAnt = THIS.this_lEmLookupModfpg
1813: 		THIS.this_lEmLookupModfpg = .T.
1814: 		THIS.AbrirBuscaMoeda()
1815: 		THIS.this_lEmLookupModfpg = loc_lEmLookupAnt
1816: 	ENDPROC
1817: 
1818: 	*====================================================================
1819: 	* AbrirBuscaMoeda - FUNIL UNICO do picker de moeda da forma de
1820: 	* pagamento. Porta de SIGOPPAG.Get_modfpg.Valid (dump linha ~9032):
1821: 	*
1822: 	*   xBrox = CreateObject('fwbuscaext', ..., 'SigCdMoe',
1823: 	*                        'CrListaRemota', 'CMOES', This.Value, ...)
1824: 	*   If Not xBrox.plAchouRegistro
1825: 	*       xBrox.mAddColuna('CMOES','XXXXXX','Codigo',.t.)
1826: 	*       xBrox.mAddColuna('DMOES','','Descricao',.T.)
1827: 	*       xBrox.Show()
1828: 	*   EndIf
1829: 	*
1830: 	* O Init do FormBuscaAuxiliar (regra #36 - 1o argumento e o HANDLE
1831: 	* gnConnHandle) ja faz o match exato e marca this_lAchouRegistro,
1832: 	* exatamente como o plAchouRegistro do fwbuscaext; o Show() so roda
1833: 	* em cima dele (regra #37).
1834: 	*
1835: 	* DESVIO DELIBERADO do legado, por causa da regra #37: o legado
1836: 	* atribui "This.value = evaluate('CrListaRemota.CMOES')" FORA de
1837: 	* qualquer guarda, o que ZERA o campo quando o usuario dispensa o
1838: 	* picker sem escolher. Aqui a atribuicao fica sob this_lSelecionou e
1839: 	* o codigo digitado e PRESERVADO (regra #50 - universo vazio nao e
1840: 	* erro: sem aviso e sem apagar o que o usuario digitou).
1841: 	*
1842: 	* PUBLIC - e o funil chamado pelas quatro portas.
1843: 	*====================================================================
1844: 	PROCEDURE AbrirBuscaMoeda()
1845: 		LOCAL loc_cValor, loc_oBusca, loc_oErro
1846: 
1847: 		loc_cValor = ALLTRIM(TRANSFORM(THIS.txt_4c_Modfpg.Value))
1848: 
1849: 		TRY
1850: 			loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1851: 				"SigCdMoe", "cursor_4c_BuscaMoeda", "cmoes", loc_cValor, ;
1852: 				"Sele" + CHR(231) + CHR(227) + "o")
1853: 
1854: 			IF VARTYPE(loc_oBusca) = "O"
1855: 				IF !loc_oBusca.this_lAchouRegistro
1856: 					loc_oBusca.mAddColuna("cmoes", "XXXXXX", "C" + CHR(243) + "digo")
1857: 					loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1858: 					loc_oBusca.Show()
1859: 				ENDIF
1860: 
1861: 				IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
1862: 					SELECT cursor_4c_BuscaMoeda
1863: 					THIS.txt_4c_Modfpg.Value = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
1864: 				ENDIF
1865: 
1866: 				IF USED("cursor_4c_BuscaMoeda")
1867: 					USE IN cursor_4c_BuscaMoeda
1868: 				ENDIF
1869: 
1870: 				loc_oBusca.Release()
1871: 			ENDIF
1872: 		CATCH TO loc_oErro
1873: 			MsgErro("Erro ao localizar moeda:" + CHR(13) + ;
1874: 				loc_oErro.Message + CHR(13) + ;
1875: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1876: 				"Procedure: " + loc_oErro.Procedure, "Erro")
1877: 		ENDTRY
1878: 
1879: 		*-- Legado: "This.refresh" no fim do Valid
1880: 		THIS.txt_4c_Modfpg.Refresh()
1881: 	ENDPROC
1882: 
1883: 	*====================================================================
1884: 	* ValidarFpgLostFocus - lookup da FORMA DE PAGAMENTO (txt_4c_Fpg ->
1885: 	* SigOpFp.fpags/descrs/moefpgs/fparcs), porta de
1886: 	* SIGOPPAG.Get_fpg.Valid (dump linha 6914): Thisform.mGetcsSigFpag()
1887: 	* seguido de Seek/fwbuscasel sobre csSigOpFp - aqui,
1888: 	* CarregarFormasPagamento() (porta parcial de mGetcsSigFpag) + SEEK
1889: 	* no cursor local + FormBuscaAuxiliar Pattern A (DefinirCursor sobre
1890: 	* cursor JA filtrado, regra #37 "FALLBACK MANUAL").
1891: 	*
1892: 	* Como no irmao Modfpg, este metodo e so o WRAPPER FINO da guarda de
1893: 	* reentrancia - o corpo mora em ValidarFpgCorpo() para que RETURN
1894: 	* antecipado nao deixe a flag presa em .T. (regra #47).
1895: 	*
1896: 	* PUBLIC (regra #3 - BINDEVENT so dispara metodo PUBLIC).
1897: 	*====================================================================
1898: 	PROCEDURE ValidarFpgLostFocus()
1899: 		IF THIS.this_lEmLookupFpg
1900: 			RETURN
1901: 		ENDIF
1902: 
1903: 		THIS.this_lEmLookupFpg = .T.
1904: 		THIS.ValidarFpgCorpo()
1905: 		THIS.this_lEmLookupFpg = .F.
1906: 	ENDPROC
1907: 
1908: 	*====================================================================
1909: 	* ValidarFpgCorpo - decide e chama o funil. O legado envolve todo o
1910: 	* bloco em "If !Empty( This.Value )" (dump: Get_fpg.Valid).
1911: 	*====================================================================
1912: 	PROCEDURE ValidarFpgCorpo()
1913: 		IF EMPTY(ALLTRIM(THIS.txt_4c_Fpg.Value))
1914: 			RETURN
1915: 		ENDIF
1916: 
1917: 		IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
1918: 			RETURN
1919: 		ENDIF
1920: 
1921: 		THIS.AbrirBuscaFormaPagamento()
1922: 	ENDPROC
1923: 
1924: 	*====================================================================
1925: 	* FpgKeyPress - F4/F5, com guarda de tecla obrigatoria (regra #47).
1926: 	* Flag em save/restore porque este handler e irmao do funil.
1927: 	*====================================================================
1928: 	PROCEDURE FpgKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1929: 		LOCAL loc_lEmLookupAnt
1930: 
1931: 		IF !INLIST(par_nKeyCode, 115, 116)
1932: 			RETURN
1933: 		ENDIF
1934: 
1935: 		IF THIS.this_lEmLookupFpg
1936: 			RETURN
1937: 		ENDIF
1938: 
1939: 		IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
1940: 			RETURN
1941: 		ENDIF
1942: 
1943: 		loc_lEmLookupAnt = THIS.this_lEmLookupFpg
1944: 		THIS.this_lEmLookupFpg = .T.
1945: 		THIS.AbrirBuscaFormaPagamento()
1946: 		THIS.this_lEmLookupFpg = loc_lEmLookupAnt
1947: 	ENDPROC
1948: 
1949: 	*====================================================================
1950: 	* FpgDblClick - duplo clique abre o picker (mesmo funil).
1951: 	*====================================================================
1952: 	PROCEDURE FpgDblClick()
1953: 		LOCAL loc_lEmLookupAnt
1954: 
1955: 		IF THIS.this_lEmLookupFpg
1956: 			RETURN
1957: 		ENDIF
1958: 
1959: 		IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
1960: 			RETURN
1961: 		ENDIF
1962: 
1963: 		loc_lEmLookupAnt = THIS.this_lEmLookupFpg
1964: 		THIS.this_lEmLookupFpg = .T.
1965: 		THIS.AbrirBuscaFormaPagamento()
1966: 		THIS.this_lEmLookupFpg = loc_lEmLookupAnt
1967: 	ENDPROC
1968: 
1969: 	*====================================================================
1970: 	* AbrirBuscaFormaPagamento - FUNIL UNICO do picker de forma de
1971: 	* pagamento. Porta de SIGOPPAG.Get_fpg.Valid (dump linha 6914):
1972: 	*
1973: 	*   Thisform.mGetcsSigFpag()
1974: 	*   If !Seek( This.Value, 'csSigOpFp', 'FPags' )
1975: 	*       loBrowse = CreateObject('fwbuscasel','csSigOpFp','FPags',...)
1976: 	*       loBrowse.AddColuna( 'FPags',  '', 'Codigo',    .t., 'FPags' )
1977: 	*       loBrowse.AddColuna( 'Descrs', '', 'Descricao', ... )
1978: 	*       ...
1979: 	*
1980: 	* Como o legado busca num cursor LOCAL ja filtrado (csSigOpFp, feito
1981: 	* por mGetcsSigFpag), aqui o padrao e o Pattern A da regra #37:
1982: 	* CarregarFormasPagamento() monta o cursor, SEEK tenta o match exato
1983: 	* e o FormBuscaAuxiliar recebe o cursor por DefinirCursor (sem SQL
1984: 	* automatica, porque o universo ja esta filtrado).
1985: 	*
1986: 	* Regra #50: quando o SEEK falha, NAO ha MsgAviso nem limpeza do
1987: 	* campo - o picker aberto JA e o retorno visual, e o codigo digitado
1988: 	* e preservado como filtro. Se o usuario dispensar o picker, o valor
1989: 	* digitado permanece (o legado tambem nao o apaga aqui).
1990: 	*
1991: 	* PUBLIC - e o funil chamado pelas quatro portas.
1992: 	*====================================================================
1993: 	PROCEDURE AbrirBuscaFormaPagamento()
1994: 		LOCAL loc_cValor, loc_oBusca, loc_oErro
1995: 
1996: 		loc_cValor = ALLTRIM(THIS.txt_4c_Fpg.Value)
1997: 
1998: 		TRY
1999: 			THIS.CarregarFormasPagamento()
2000: 
2001: 			IF USED(THIS.this_cCursorFormasPagamento)
2002: 				IF !EMPTY(loc_cValor) AND ;
2003: 				   SEEK(loc_cValor, THIS.this_cCursorFormasPagamento, "fpags")
2004: 					SELECT (THIS.this_cCursorFormasPagamento)
2005: 					THIS.txt_4c_Fpg.Value = ALLTRIM(EVALUATE(THIS.this_cCursorFormasPagamento + ".fpags"))
2006: 				ELSE
2007: 					loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2008: 
2009: 					IF VARTYPE(loc_oBusca) = "O"
2010: 						loc_oBusca.DefinirCursor(THIS.this_cCursorFormasPagamento, ;
2011: 							"fpags", "descrs", "Cadastro de Forma de Pagamento")
2012: 
2013: 						*-- DefinirCursor usa o NOME do campo como titulo das
2014: 						*-- duas primeiras colunas; zerar o contador faz
2015: 						*-- mAddColuna remontar a lista com os titulos e as
2016: 						*-- mascaras do legado (AddColuna de Get_fpg.Valid,
2017: 						*-- dump linhas 6931-6934).
2018: 						loc_oBusca.this_nColunas = 0
2019: 						loc_oBusca.mAddColuna("fpags", "", "C" + CHR(243) + "digo")
2020: 						loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
2021: 						loc_oBusca.mAddColuna("moefpgs", "XXXXX", "Moeda")
2022: 						loc_oBusca.mAddColuna("fparcs", "99", " #")
2023: 
2024: 						IF loc_oBusca.Mostrar()
2025: 							THIS.txt_4c_Fpg.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
2026: 						ENDIF
2027: 
2028: 						loc_oBusca.Release()
2029: 					ENDIF
2030: 				ENDIF
2031: 
2032: 				IF USED(THIS.this_cCursorFormasPagamento)
2033: 					USE IN (THIS.this_cCursorFormasPagamento)
2034: 				ENDIF
2035: 			ENDIF
2036: 		CATCH TO loc_oErro
2037: 			MsgErro("Erro ao localizar forma de pagamento:" + CHR(13) + ;
2038: 				loc_oErro.Message + CHR(13) + ;
2039: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2040: 				"Procedure: " + loc_oErro.Procedure, "Erro")
2041: 		ENDTRY
2042: 
2043: 		*-- Fase 8/8: Npar/Vpar/Porc/DataVenc dependem de Fpg preenchido
2044: 		*-- (ver HabilitarCampos()) - reavaliar agora que o lookup pode ter
2045: 		*-- alterado o valor, independente de qual das quatro portas
2046: 		*-- (LostFocus/KeyPress/DblClick) chamou este funil.
2047: 		THIS.HabilitarCampos()
2048: 
2049: 		THIS.txt_4c_Fpg.Refresh()
2050: 	ENDPROC
2051: 
2052: 	*====================================================================
2053: 	* CarregarFormasPagamento - porta PARCIAL de mGetcsSigFpag (dump
2054: 	* linha 4136), ramo INSERIR/ALTERAR (regra #35/cabecalho - este form
2055: 	* filho so abre nesses dois modos). Filtra SigOpFp por Empresa +
2056: 	* Moeda (ja digitada em txt_4c_Modfpg) e exclui a forma de pagamento
2057: 	* padrao/credito da operacao (SigCdOpe.FpagOpCrs).
2058: 	*
2059: 	* FORA de escopo nesta fase (ficam para a Fase 7/8, quando os
2060: 	* cursores/containers correspondentes existirem):
2061: 	*   - filtro de GRUPO EMPRESARIAL (crSigCdEmp.grupo);
2062: 	*   - filtro de MASCARA de cartao (plMasc, ligado ao container
2063: 	*     flutuante cntFundo.cntMascPgto);
2064: 	*   - exclusao de formas ja usadas em xPar / bloqueio por desconto
2065: 	*     financeiro (SigMvItd) - regra de GRAVACAO, nao de lookup.
2066: 	*
2067: 	* PROTECTED - chamado so internamente por ValidarFpgLostFocus().
2068: 	*====================================================================
2069: 	PROTECTED PROCEDURE CarregarFormasPagamento()
2070: 		LOCAL loc_cEmps, loc_cDopes, loc_cMoeda, loc_cSQL, loc_nResultado
2071: 
2072: 		IF USED(THIS.this_cCursorFormasPagamento)
2073: 			USE IN (THIS.this_cCursorFormasPagamento)
2074: 		ENDIF
2075: 
2076: 		loc_cEmps  = THIS.this_oBusinessObject.this_cEmps
2077: 		loc_cDopes = THIS.this_oBusinessObject.this_cDopes
2078: 		loc_cMoeda = ALLTRIM(TRANSFORM(THIS.txt_4c_Modfpg.Value))
2079: 
2080: 		TEXT TO loc_cSQL TEXTMERGE NOSHOW
2081: 			SELECT a.fpags, a.descrs, a.moefpgs, a.fparcs, a.situas
2082: 			FROM SigOpFp a
2083: 			WHERE a.emps IN (<<EscaparSQL(loc_cEmps)>>, '   ')
2084: 			<<IIF(!EMPTY(loc_cMoeda), " AND a.moefpgs = " + EscaparSQL(loc_cMoeda), "")>>
2085: 			<<IIF(!EMPTY(loc_cDopes), " AND a.fpags <> ISNULL((SELECT fpagopcrs FROM SigCdOpe WHERE dopes = " + EscaparSQL(loc_cDopes) + "), '')", "")>>
2086: 			ORDER BY a.fpags
2087: 		ENDTEXT
2088: 
2089: 		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorFormasPagamento)
2090: 
2091: 		IF loc_nResultado >= 0 AND USED(THIS.this_cCursorFormasPagamento)
2092: 			SELECT (THIS.this_cCursorFormasPagamento)
2093: 			INDEX ON fpags TAG fpags
2094: 			GO TOP
2095: 		ENDIF
2096: 
2097: 		RETURN (loc_nResultado >= 0)
2098: 	ENDPROC
2099: 
2100: 	*====================================================================
2101: 	* ConfigurarEventosBotoes - liga o Click dos 5 CommandButton REAIS de
2102: 	* acao (regra #3 - BINDEVENT so dispara metodo PUBLIC) aos handlers da
2103: 	* Fase 7/8. btnRetCash.When do dump NAO e ligado aqui: CommandButton do
2104: 	* VFP9 nao tem evento When nativo (ver BtnRetCashWhen() abaixo).
2105: 	*====================================================================
2106: 	PROTECTED PROCEDURE ConfigurarEventosBotoes()
2107: 		LOCAL loc_oCnt
2108: 
2109: 		loc_oCnt = THIS.cnt_4c_Botoes
2110: 
2111: 		BINDEVENT(loc_oCnt.cmd_4c_BtnRetCash, "Click", THIS, "BtnRetCashClick")
2112: 		BINDEVENT(loc_oCnt.cmd_4c_Apaga, "Click", THIS, "BtnExcluirCondicaoClick")
2113: 		BINDEVENT(loc_oCnt.cmd_4c_Totite, "Click", THIS, "BtnTotalProdutosClick")
2114: 		BINDEVENT(loc_oCnt.cmd_4c_Ok, "Click", THIS, "BtnConfirmarClick")
2115: 		BINDEVENT(loc_oCnt.cmd_4c_Cancela, "Click", THIS, "BtnCancelarClick")
2116: 	ENDPROC
2117: 
2118: 	*====================================================================
2119: 	* AjustarBotoesPorModo - Fase 8/8: centraliza o Enabled dos 5 botoes de
2120: 	* acao conforme THIS.this_cOpEscolha (equivalente ao modo pcEscolha do
2121: 	* form pai, regra #40 do CLAUDE.md - quem desabilita no funil de ida
2122: 	* tem de reabilitar no de volta). So o btnRetCash tem When() explicito
2123: 	* no dump (dump linha 6448, ja portado em BtnRetCashWhen()); os demais
2124: 	* gateiam a ACAO dentro do proprio Click (INLIST(this_cOpEscolha,...),
2125: 	* desde a Fase 7/8) - aqui o Enabled do CONTROLE passa a refletir a
2126: 	* MESMA condicao, para o botao aparecer cinza em vez de clicavel-mas-
2127: 	* inerte quando a tela abrir em modo CONSULTAR.
2128: 	*
2129: 	* this_cOpEscolha e fixado em Init() (regra #35/cabecalho - replica
2130: 	* ThisForm.Op_Escolha = pForm.pcEscolha) e nao muda durante a vida
2131: 	* deste dialogo modal - por isso uma unica chamada em InicializarForm()
2132: 	* basta; o metodo e mantido PUBLIC para reaproveitamento caso um dia
2133: 	* exista um caminho que troque o modo em runtime.
2134: 	*====================================================================
2135: 	PROCEDURE AjustarBotoesPorModo()
2136: 		LOCAL loc_oCnt, loc_lEdicao
2137: 
2138: 		IF !PEMSTATUS(THIS, "cnt_4c_Botoes", 5)
2139: 			RETURN
2140: 		ENDIF
2141: 
2142: 		loc_oCnt    = THIS.cnt_4c_Botoes
2143: 		loc_lEdicao = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
2144: 
2145: 		*-- btnRetCash: Enabled pelo proprio When ja portado (3 valores no
2146: 		*-- Click do dump - linha 6432 - contra 2 no When do botao; sao
2147: 		*-- regras DIFERENTES do mesmo controle, nao inconsistencia).
2148: 		loc_oCnt.cmd_4c_BtnRetCash.Enabled = THIS.BtnRetCashWhen()
2149: 
2150: 		*-- Apaga/Ok: o Click dos dois exige INSERIR/ALTERAR (regra #40) -
2151: 		*-- refletir no Enabled evita o clique inerte em modo CONSULTAR.
2152: 		loc_oCnt.cmd_4c_Apaga.Enabled = loc_lEdicao
2153: 		loc_oCnt.cmd_4c_Ok.Enabled    = loc_lEdicao
2154: 
2155: 		*-- Totite (sem When no dump) e Cancela (precisa fechar a tela
2156: 		*-- mesmo em CONSULTAR) ficam sempre habilitados.
2157: 		loc_oCnt.cmd_4c_Totite.Enabled  = .T.
2158: 		loc_oCnt.cmd_4c_Cancela.Enabled = .T.
2159: 	ENDPROC
2160: 
2161: 	*====================================================================
2162: 	* HabilitarCampos - Fase 8/8: habilita/desabilita os campos soltos do
2163: 	* bloco "Condicao" conforme o modo do form pai e o preenchimento da
2164: 	* forma de pagamento, portando os When() do dump que dependem SO desse
2165: 	* par (this_cOpEscolha + Fpg preenchido):
2166: 	*   Get_modfpg.When / Get_fpg.When: "Inlist(...,'INSERIR','ALTERAR')
2167: 	*                                    And CrSigCdOpe.ParAutos <> 5"
2168: 	*   GetPorc.When / Get_npar.When / Get_vpar.When (parte comum):
2169: 	*                                    "Inlist(...) And
2170: 	*                                    !Empty(Thisform.Get_fpg.Value)"
2171: 	*
2172: 	* PENDENCIA EXPLICITA (REGRA FUNDAMENTAL - nunca omitir em silencio):
2173: 	* tres When() do dump dependem de estado que NENHUMA fase anterior
2174: 	* portou, e este metodo NAO inventa valor para eles:
2175: 	*   - Get_npar.When tambem exige "Thisform.Digpar" (flag setada DENTRO

*-- Linhas 2186 a 2416:
2186: 	*     cmd_4c_AlteraCotacao seguem Visible = .F., como no dump (Fase
2187: 	*     6/8), e nao sao tocados aqui.
2188: 	*
2189: 	* PUBLIC - chamado por InicializarForm() e por AbrirBuscaFormaPagamento()
2190: 	* (o valor de Fpg so e conhecido depois do lookup resolver) e por
2191: 	* LimparCampos() (abaixo).
2192: 	*====================================================================
2193: 	PROCEDURE HabilitarCampos()
2194: 		LOCAL loc_lEdicao, loc_lTemFpg
2195: 
2196: 		loc_lEdicao = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR") AND ;
2197: 			THIS.this_oBusinessObject.this_nParAutosOpe != 5
2198: 		loc_lTemFpg = !EMPTY(ALLTRIM(THIS.txt_4c_Fpg.Value))
2199: 
2200: 		THIS.txt_4c_Modfpg.Enabled = loc_lEdicao
2201: 		THIS.txt_4c_Fpg.Enabled    = loc_lEdicao
2202: 
2203: 		THIS.txt_4c_Npar.Enabled     = loc_lEdicao AND loc_lTemFpg
2204: 		THIS.txt_4c_Vpar.Enabled     = loc_lEdicao AND loc_lTemFpg
2205: 		THIS.txt_4c_Porc.Enabled     = loc_lEdicao AND loc_lTemFpg
2206: 		THIS.txt_4c_DataVenc.Enabled = loc_lEdicao AND loc_lTemFpg
2207: 
2208: 		*-- Dias (Get_Dias) e sempre resultado de calculo entre Vencimento
2209: 		*-- e a data base do movimento - nao ha Valid/When habilitando
2210: 		*-- digitacao direta nele no dump.
2211: 		THIS.txt_4c_Dias.Enabled = .F.
2212: 
2213: 		*-- Campos totalizadores/computados - When() = "Return(.F.)" no
2214: 		*-- dump para TODOS (Get_valtot/Get_Saldo/Get_TotForma/
2215: 		*-- Get_valinic/Get_pDescP/Get_VDescP/Get_moeoper/getValTrans):
2216: 		*-- nunca digitaveis, em qualquer modo.
2217: 		THIS.txt_4c_MoeOper.Enabled    = .F.
2218: 		THIS.txt_4c_ValInic.Enabled    = .F.
2219: 		THIS.txt_4c_TotServico.Enabled = .F.
2220: 		THIS.txt_4c_ValTrans.Enabled   = .F.
2221: 		THIS.txt_4c_Variacao.Enabled   = .F.
2222: 		THIS.txt_4c_ValTot.Enabled     = .F.
2223: 		THIS.txt_4c_TotForma.Enabled   = .F.
2224: 		THIS.txt_4c_Saldo.Enabled      = .F.
2225: 		THIS.txt_4c_PDescP.Enabled     = .F.
2226: 		THIS.txt_4c_VDescP.Enabled     = .F.
2227: 	ENDPROC
2228: 
2229: 	*====================================================================
2230: 	* LimparCampos - Fase 8/8: funil UNICO de limpeza dos campos soltos do
2231: 	* bloco Condicao apos excluir uma linha (BtnExcluirCondicaoClick, que
2232: 	* antes desta fase limpava so 5 campos em linha, inline) ou apos
2233: 	* qualquer outro caminho que precise devolver a tela ao estado
2234: 	* "nenhuma condicao em edicao". NAO toca na grade (CarregarLista() e
2235: 	* quem repinta) nem nos totalizadores ja recalculados por
2236: 	* AtualizarTotaisPosExclusao() (Saldo/TotForma), para nao desfazer o
2237: 	* recalculo que o chamador acabou de fazer.
2238: 	*
2239: 	* Termina chamando HabilitarCampos(): com Fpg vazio, Npar/Vpar/Porc/
2240: 	* DataVenc tem de voltar a ficar desabilitados (regra #40 - quem
2241: 	* limpa o campo tem de refletir isso no Enabled tambem).
2242: 	*
2243: 	* PUBLIC - mesma razao de CarregarLista() (regra #3): reaproveitavel
2244: 	* por qualquer caminho de limpeza, dentro ou fora da classe.
2245: 	*====================================================================
2246: 	PROCEDURE LimparCampos()
2247: 		THIS.txt_4c_Fpg.Value      = ""
2248: 		THIS.txt_4c_Modfpg.Value   = 0
2249: 		THIS.txt_4c_Npar.Value     = 0
2250: 		THIS.txt_4c_Vpar.Value     = 0
2251: 		THIS.txt_4c_Porc.Value     = 0
2252: 		THIS.txt_4c_Dias.Value     = 0
2253: 		THIS.txt_4c_DataVenc.Value = {}
2254: 		THIS.txt_4c_Cotacao.Value  = 0
2255: 
2256: 		THIS.HabilitarCampos()
2257: 	ENDPROC
2258: 
2259: 	*====================================================================
2260: 	* BtnRetCashWhen - porta de SIGOPPAG.btnRetCash.When (dump linha 6448).
2261: 	* CommandButton do VFP9 nao tem evento When nativo (era campo GET da
2262: 	* base fwbutton do legado) - nao ha como BINDEVENT isto a um disparo
2263: 	* automatico. Metodo mantido PUBLIC e funcional para quando um futuro
2264: 	* "AjustarBotoesPorModo" (regra #40 do CLAUDE.md) for escrito para este
2265: 	* form e precisar consultar esta condicao antes de habilitar o botao.
2266: 	*====================================================================
2267: 	PROCEDURE BtnRetCashWhen()
2268: 		RETURN INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
2269: 	ENDPROC
2270: 
2271: 	*====================================================================
2272: 	* BtnRetCashClick - porta de SIGOPPAG.btnRetCash.Click (dump linha
2273: 	* 6428) - "Retorna Bonus": abre o dialogo de utilizacao de bonus/
2274: 	* cashback do cliente, que vive no FORM PAI:
2275: 	*
2276: 	*   =ThisForm.parentform.OpenCash(TprMvCab.Contads, .T.)
2277: 	*   If ThisForm.BlqPossuiBonus
2278: 	*       ThisForm.getValUtiCsh.Value = 0
2279: 	*   EndIf
2280: 	*
2281: 	* PENDENCIA EXPLICITA: OpenCash() e um metodo do FORM PAI (cabecalho do
2282: 	* movimento). Nenhum form do acervo migrado ainda cria
2283: 	* CREATEOBJECT("Formsigoppag") - o pai nem esta wireado para abrir este
2284: 	* filho - logo OpenCash() nao existe em lugar nenhum do projeto hoje.
2285: 	* Chamar um metodo inexistente quebraria a regra #13 (nunca chamar
2286: 	* helper nao definido) e derrubaria a tela (regra #29). O PEMSTATUS
2287: 	* abaixo deixa o Click FORWARD-COMPATIVEL: se um dia o pai ganhar
2288: 	* OpenCash(), este botao passa a funcionar sem precisar tocar aqui de
2289: 	* novo; enquanto isso, avisa o usuario em vez de quebrar.
2290: 	*
2291: 	* "ThisForm.BlqPossuiBonus" (flag setada no Init legado, dump linha
2292: 	* 5045) tambem nao foi portado - depende do mesmo Init gigantesco do
2293: 	* form pai citado no cabecalho deste arquivo. Sem ela, o zeramento
2294: 	* condicional de getValUtiCsh fica fora desta fase (documentado, nao
2295: 	* omitido em silencio).
2296: 	*====================================================================
2297: 	PROCEDURE BtnRetCashClick()
2298: 		LOCAL loc_oErro
2299: 
2300: 		*-- Legado: "If Inlist( ThisForm.Op_Escolha, 'INSERIR', 'ALTERAR',
2301: 		*-- 'CONSULTAR' )" (dump linha 6432) - TRES valores aqui, diferente
2302: 		*-- do When() (regra de guarda do proprio botao, so 2 valores).
2303: 		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR", "CONSULTAR")
2304: 			RETURN
2305: 		ENDIF
2306: 
2307: 		TRY
2308: 			IF VARTYPE(THIS.this_oFormPai) = "O" AND PEMSTATUS(THIS.this_oFormPai, "OpenCash", 5)
2309: 				THIS.this_oFormPai.OpenCash(THIS.this_oBusinessObject.this_cContaDsCab, .T.)
2310: 				THIS.txt_4c_ValUtiCsh.Refresh()
2311: 			ELSE
2312: 				MsgAviso("A devolu" + CHR(231) + CHR(227) + "o de B" + CHR(244) + "nus depende da tela de cabe" + CHR(231) + CHR(227) + "o do movimento," + CHR(13) + ;
2313: 					"que ainda n" + CHR(227) + "o disponibiliza esta integra" + CHR(231) + CHR(227) + "o no sistema novo.", "Funcionalidade Pendente")
2314: 			ENDIF
2315: 		CATCH TO loc_oErro
2316: 			MsgErro("Erro ao retornar b" + CHR(244) + "nus:" + CHR(13) + ;
2317: 				loc_oErro.Message + CHR(13) + ;
2318: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2319: 				"Procedure: " + loc_oErro.Procedure, "Erro")
2320: 		ENDTRY
2321: 	ENDPROC
2322: 
2323: 	*====================================================================
2324: 	* BtnTotalProdutosClick - porta de SIGOPPAG.totite.Click (dump linha 8791) -
2325: 	* "Total dos Produtos":
2326: 	*
2327: 	*   Thisform.enabled=.f.
2328: 	*   do form SigOpTot with thisform,Thisform.datasessionId
2329: 	*
2330: 	* PENDENCIA EXPLICITA (fora do escopo da task782): SigOpTot NAO foi
2331: 	* migrado para o projeto novo (zero arquivos "SigOpTot*" em
2332: 	* projeto\app) e "DO FORM" nunca abre dialogo filho no sistema novo
2333: 	* (memoria do projeto). Em vez de um stub silencioso ou de tentar
2334: 	* reproduzir o DO FORM literal (o que quebraria a tela), avisa o
2335: 	* usuario que a funcionalidade ainda nao esta disponivel.
2336: 	*====================================================================
2337: 	PROCEDURE BtnTotalProdutosClick()
2338: 		MsgAviso("A tela de Total dos Produtos (SigOpTot) ainda n" + CHR(227) + "o foi migrada para o sistema novo." + CHR(13) + ;
2339: 			"Esta funcionalidade ser" + CHR(225) + " disponibilizada em uma pr" + CHR(243) + "xima atualiza" + CHR(231) + CHR(227) + "o.", "Funcionalidade Pendente")
2340: 	ENDPROC
2341: 
2342: 	*====================================================================
2343: 	* BtnExcluirCondicaoClick - porta de SIGOPPAG.Apaga.Click (dump linha 6655) -
2344: 	* "Excluir Condicao": remove a linha CORRENTE de xPar/
2345: 	* cursor_4c_Condicoes, com os mesmos bloqueios do legado (forma
2346: 	* automatica, InsChs em ALTERAR, InsChs com cheque sem banco OU forma
2347: 	* igual a FPagOpCrs, InsChs com ParAutos=4, cupom nao fiscal).
2348: 	*
2349: 	* PENDENCIAS desta fase (documentadas, nao silenciadas - REGRA
2350: 	* FUNDAMENTAL do CLAUDE.md):
2351: 	*   - recalculo de Desconto/Acrescimo (containers .Desconto/.Acrescimo
2352: 	*     ainda nao criados) e dos impostos de servico (FSigOpFin_NF -
2353: 	*     funcao global do legado nao portada);
2354: 	*   - ThisForm.ParentForm.Cotacao()/CalcServico()/CalcImposto() e
2355: 	*     "getValUtiCsh = ParentForm.OpenValorLimiteCash" - metodos do FORM
2356: 	*     PAI, ainda nao wireado a este filho (mesma pendencia do
2357: 	*     BtnRetCashClick). AtualizarTotaisPosExclusao() (abaixo) soma
2358: 	*     this_nValos direto, SEM a conversao de cotacao entre moedas que
2359: 	*     ThisForm.ParentForm.Cotacao() fazia - desvio documentado.
2360: 	*====================================================================
2361: 	PROCEDURE BtnExcluirCondicaoClick()
2362: 		LOCAL loc_cAlias, loc_cMsg, loc_cCaption, loc_cFpagAtual, loc_lInschsAtual, ;
2363: 			loc_cCidchavesAtual, loc_cNumChqsAtual, loc_cBancosAtual, loc_cOperAutos, ;
2364: 			loc_cSQL, loc_nResultado, loc_lFechou, loc_oErro
2365: 
2366: 		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
2367: 			RETURN
2368: 		ENDIF
2369: 
2370: 		loc_cAlias = THIS.this_cAliasGrade
2371: 		IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
2372: 			loc_cAlias = THIS.this_cCursorCondicoes
2373: 		ENDIF
2374: 
2375: 		IF !USED(loc_cAlias) OR EOF(loc_cAlias)
2376: 			MsgAviso("Nenhuma Condi" + CHR(231) + CHR(227) + "o de Pagamento Selecionada para Apagar ... ", "Nada a Fazer")
2377: 			RETURN
2378: 		ENDIF
2379: 
2380: 		loc_cMsg     = ""
2381: 		loc_cCaption = ""
2382: 		loc_lFechou  = .F.
2383: 
2384: 		SELECT (loc_cAlias)
2385: 		loc_cFpagAtual      = TratarNulo(fpags, "")
2386: 		loc_lInschsAtual    = ConverterParaLogico(inschs)
2387: 		loc_cCidchavesAtual = TratarNulo(cidchaves, "")
2388: 		loc_cNumChqsAtual   = IIF(TYPE(loc_cAlias + ".numchqs") != "U", TratarNulo(numchqs, ""), "")
2389: 		loc_cBancosAtual    = IIF(TYPE(loc_cAlias + ".bancos")  != "U", TratarNulo(bancos, ""),  "")
2390: 
2391: 		TRY
2392: 			loc_cOperAutos = ""
2393: 
2394: 			IF USED("cursor_4c_ApagaFp")
2395: 				USE IN cursor_4c_ApagaFp
2396: 			ENDIF
2397: 
2398: 			IF !EMPTY(loc_cFpagAtual)
2399: 				TEXT TO loc_cSQL TEXTMERGE NOSHOW
2400: 					SELECT operautos FROM SigOpFp WHERE fpags = <<EscaparSQL(loc_cFpagAtual)>>
2401: 				ENDTEXT
2402: 
2403: 				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ApagaFp")
2404: 				IF loc_nResultado >= 0 AND USED("cursor_4c_ApagaFp") AND !EOF("cursor_4c_ApagaFp")
2405: 					loc_cOperAutos = TratarNulo(cursor_4c_ApagaFp.operautos, "")
2406: 				ENDIF
2407: 
2408: 				IF USED("cursor_4c_ApagaFp")
2409: 					USE IN cursor_4c_ApagaFp
2410: 				ENDIF
2411: 			ENDIF
2412: 
2413: 			DO CASE
2414: 			CASE !EMPTY(loc_cOperAutos) AND loc_cFpagAtual == loc_cOperAutos
2415: 				loc_cMsg     = "Condi" + CHR(231) + CHR(227) + "o de Pagamento Autom" + CHR(225) + "tica ... "
2416: 				loc_cCaption = "Exclus" + CHR(227) + "o de Condi" + CHR(231) + CHR(227) + "o de Pagamento N" + CHR(227) + "o Permitida"

*-- Linhas 2450 a 2533:
2450: 
2451: 			IF !loc_lFechou
2452: 				IF !EMPTY(loc_cMsg)
2453: 					MsgAviso(loc_cMsg, loc_cCaption)
2454: 				ELSE
2455: 					IF !EMPTY(loc_cCidchavesAtual)
2456: 						THIS.this_oBusinessObject.ExcluirCondicao(loc_cCidchavesAtual)
2457: 					ENDIF
2458: 
2459: 					SELECT (loc_cAlias)
2460: 					DELETE
2461: 
2462: 					THIS.AtualizarTotaisPosExclusao(loc_cAlias)
2463: 
2464: 					*-- Fase 8/8: funil unico de limpeza (ver LimparCampos()) -
2465: 					*-- substitui o clear inline de 5 campos desta fase.
2466: 					THIS.LimparCampos()
2467: 
2468: 					THIS.CarregarLista()
2469: 					THIS.txt_4c_Fpg.SetFocus()
2470: 				ENDIF
2471: 			ENDIF
2472: 		CATCH TO loc_oErro
2473: 			MsgErro("Erro ao excluir condi" + CHR(231) + CHR(227) + "o de pagamento:" + CHR(13) + ;
2474: 				loc_oErro.Message + CHR(13) + ;
2475: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2476: 				"Procedure: " + loc_oErro.Procedure, "Erro")
2477: 		ENDTRY
2478: 
2479: 		IF loc_lFechou
2480: 			THIS.FecharDialogo()
2481: 		ENDIF
2482: 	ENDPROC
2483: 
2484: 	*====================================================================
2485: 	* AtualizarTotaisPosExclusao - recalculo SIMPLIFICADO do total das
2486: 	* formas de pagamento ja lancadas, apos BtnExcluirCondicaoClick() remover uma linha.
2487: 	* Legado: soma xpar.valos * (xpar.cotfpgs * indice) / cotacao-da-moeda-
2488: 	* da-operacao (ThisForm.ParentForm.Cotacao()), com troco subtraindo em
2489: 	* vez de somar. ParentForm.Cotacao() nao existe ainda (pendencia
2490: 	* documentada em BtnExcluirCondicaoClick()) - aqui a soma e DIRETA em this_nValos,
2491: 	* sem conversao entre moedas.
2492: 	*====================================================================
2493: 	PROTECTED PROCEDURE AtualizarTotaisPosExclusao(par_cAlias)
2494: 		LOCAL loc_nTotForma, loc_oErro
2495: 
2496: 		loc_nTotForma = 0
2497: 
2498: 		TRY
2499: 			IF USED("cursor_4c_ApagaTot")
2500: 				USE IN cursor_4c_ApagaTot
2501: 			ENDIF
2502: 
2503: 			SELECT SUM(IIF(trocos = 1, -valos, valos)) AS total FROM (par_cAlias) INTO CURSOR cursor_4c_ApagaTot
2504: 
2505: 			IF USED("cursor_4c_ApagaTot")
2506: 				loc_nTotForma = TratarNulo(cursor_4c_ApagaTot.total, 0)
2507: 				USE IN cursor_4c_ApagaTot
2508: 			ENDIF
2509: 
2510: 			THIS.txt_4c_TotForma.Value = loc_nTotForma
2511: 			THIS.txt_4c_Saldo.Value    = THIS.txt_4c_ValTot.Value - loc_nTotForma
2512: 		CATCH TO loc_oErro
2513: 			MsgErro("Erro ao recalcular totais da condi" + CHR(231) + CHR(227) + "o de pagamento:" + CHR(13) + loc_oErro.Message, "Erro")
2514: 		ENDTRY
2515: 	ENDPROC
2516: 
2517: 	*====================================================================
2518: 	* BtnConfirmarClick - porta de SIGOPPAG.Ok.Click (dump linha 7869) - "Confirmar":
2519: 	* valida TODAS as condicoes de pagamento JA lancadas na grade e, se
2520: 	* nenhuma falhar, persiste cada uma via BO e fecha o dialogo.
2521: 	*
2522: 	* PENDENCIAS desta fase (documentadas em cada helper abaixo - REGRA
2523: 	* FUNDAMENTAL do CLAUDE.md, nunca omitir em silencio):
2524: 	*   1) ThisForm.plFPagObrigs (obrigatoriedade de forma de pagamento)
2525: 	*      depende do catalogo SigOpFp x SigOpFpo x SigCdEmp.grupo que
2526: 	*      CarregarFormasPagamento() (Fase 6/8) ja documentou como fora de
2527: 	*      escopo (mesma limitacao - "filtro de GRUPO EMPRESARIAL... fica
2528: 	*      fora");
2529: 	*   2) o bloco "AlterouGrade" (limite maximo por forma, SigOpFpI + DO
2530: 	*      FORM SigOpSen para autorizacao) - SigOpSen nao foi migrado (gate
2531: 	*      de autorizacao ausente, mesma pendencia de outras tasks do
2532: 	*      projeto). Nao ha rastreamento de "a grade foi alterada" nesta
2533: 	*      fase, logo este bloco fica inerte por ora;

*-- Linhas 2545 a 2950:
2545: 	* VFP9 nao faz short-circuit e chamaria os helpers seguintes mesmo apos
2546: 	* uma falha.
2547: 	*====================================================================
2548: 	PROCEDURE BtnConfirmarClick()
2549: 		LOCAL loc_cAlias, loc_lOk
2550: 
2551: 		loc_lOk = .F.
2552: 
2553: 		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
2554: 			RETURN
2555: 		ENDIF
2556: 
2557: 		loc_cAlias = THIS.this_cAliasGrade
2558: 		IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
2559: 			loc_cAlias = THIS.this_cCursorCondicoes
2560: 		ENDIF
2561: 
2562: 		IF THIS.ValidarSituacaoClienteBloqueiaDesconto()
2563: 			IF THIS.ValidarChequesDuplicados(loc_cAlias)
2564: 				IF THIS.ValidarCondicoesLancadas(loc_cAlias)
2565: 					IF THIS.PersistirCondicoes(loc_cAlias)
2566: 						THIS.CarregarLista()
2567: 						loc_lOk = .T.
2568: 					ENDIF
2569: 				ENDIF
2570: 			ENDIF
2571: 		ENDIF
2572: 
2573: 		IF loc_lOk
2574: 			THIS.FecharDialogo()
2575: 		ENDIF
2576: 	ENDPROC
2577: 
2578: 	*====================================================================
2579: 	* ValidarSituacaoClienteBloqueiaDesconto - porta do bloco inicial do
2580: 	* Ok.Click (dump linhas 7873-7893): com TprMvCab.ValVars < 0 (desconto
2581: 	* negativo no movimento), verifica se a situacao da conta de destino
2582: 	* (ou, na falta, a de origem) bloqueia desconto (SigCdCli.Situas ->
2583: 	* SigCdCst.BlqDescs = 1). Devolve .F. quando bloqueado (mensagem ja
2584: 	* exibida); .T. caso contrario.
2585: 	*====================================================================
2586: 	PROTECTED PROCEDURE ValidarSituacaoClienteBloqueiaDesconto()
2587: 		LOCAL loc_lOk
2588: 
2589: 		loc_lOk = .T.
2590: 
2591: 		IF THIS.this_oBusinessObject.this_nValVarsCab < 0
2592: 			IF THIS.ContaTemDescontoBloqueado(THIS.this_oBusinessObject.this_cContaDsCab)
2593: 				loc_lOk = .F.
2594: 			ELSE
2595: 				IF !EMPTY(THIS.this_oBusinessObject.this_cContaOsCab)
2596: 					IF THIS.ContaTemDescontoBloqueado(THIS.this_oBusinessObject.this_cContaOsCab)
2597: 						loc_lOk = .F.
2598: 					ENDIF
2599: 				ENDIF
2600: 			ENDIF
2601: 		ENDIF
2602: 
2603: 		RETURN loc_lOk
2604: 	ENDPROC
2605: 
2606: 	*====================================================================
2607: 	* ContaTemDescontoBloqueado - SigCdCli.Situas -> SigCdCst.BlqDescs,
2608: 	* consulta direta via SQLEXEC (substitui o
2609: 	* ThisForm.parentform.PoDataMgr.CursorQuery do legado, que nao existe
2610: 	* no projeto novo). Exibe o MsgAviso do proprio legado quando bloqueado.
2611: 	*====================================================================
2612: 	PROTECTED PROCEDURE ContaTemDescontoBloqueado(par_cConta)
2613: 		LOCAL loc_lBloqueado, loc_cSQL, loc_nResultado, loc_oErro
2614: 
2615: 		loc_lBloqueado = .F.
2616: 
2617: 		IF EMPTY(par_cConta)
2618: 			RETURN loc_lBloqueado
2619: 		ENDIF
2620: 
2621: 		TRY
2622: 			IF USED("cursor_4c_SituacaoCliente")
2623: 				USE IN cursor_4c_SituacaoCliente
2624: 			ENDIF
2625: 
2626: 			TEXT TO loc_cSQL TEXTMERGE NOSHOW
2627: 				SELECT c.descrs, c.blqdescs
2628: 				FROM SigCdCli a
2629: 				INNER JOIN SigCdCst c ON c.codigos = a.situas
2630: 				WHERE a.iclis = <<EscaparSQL(par_cConta)>>
2631: 			ENDTEXT
2632: 
2633: 			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SituacaoCliente")
2634: 
2635: 			IF loc_nResultado >= 0 AND USED("cursor_4c_SituacaoCliente") AND !EOF("cursor_4c_SituacaoCliente")
2636: 				IF cursor_4c_SituacaoCliente.blqdescs = 1
2637: 					loc_lBloqueado = .T.
2638: 					MsgAviso(ALLTRIM(TratarNulo(cursor_4c_SituacaoCliente.descrs, "")) + CHR(13) + ;
2639: 						"Desconto Bloqueado Pela Situa" + CHR(231) + CHR(227) + "o a Conta", "Situa" + CHR(231) + CHR(227) + "o")
2640: 				ENDIF
2641: 			ENDIF
2642: 
2643: 			IF USED("cursor_4c_SituacaoCliente")
2644: 				USE IN cursor_4c_SituacaoCliente
2645: 			ENDIF
2646: 		CATCH TO loc_oErro
2647: 			MsgErro("Erro ao verificar situa" + CHR(231) + CHR(227) + "o do cliente:" + CHR(13) + loc_oErro.Message, "Erro")
2648: 		ENDTRY
2649: 
2650: 		RETURN loc_lBloqueado
2651: 	ENDPROC
2652: 
2653: 	*====================================================================
2654: 	* ValidarChequesDuplicados - porta literal do bloco "Select
2655: 	* Bancos+Agencias+Contas+Numeros..." do Ok.Click (dump linhas 7895-
2656: 	* 7904). Campos bancos/agencias/contas/numeros so existem no xPar
2657: 	* completo do form pai - no cursor placeholder (modo de teste) o TYPE()
2658: 	* devolve "U" e a checagem e pulada (sem crash, sem falso bloqueio).
2659: 	*====================================================================
2660: 	PROTECTED PROCEDURE ValidarChequesDuplicados(par_cAlias)
2661: 		LOCAL loc_lOk, loc_oErro
2662: 
2663: 		loc_lOk = .T.
2664: 
2665: 		IF TYPE(par_cAlias + ".bancos") == "U" OR TYPE(par_cAlias + ".agencias") == "U" OR ;
2666: 				TYPE(par_cAlias + ".contas") == "U" OR TYPE(par_cAlias + ".numeros") == "U"
2667: 			RETURN loc_lOk
2668: 		ENDIF
2669: 
2670: 		TRY
2671: 			IF USED("cursor_4c_VerChq")
2672: 				USE IN cursor_4c_VerChq
2673: 			ENDIF
2674: 
2675: 			SELECT bancos + agencias + contas + numeros AS cheque, COUNT(1) AS ntotal ;
2676: 				FROM (par_cAlias) ;
2677: 				WHERE !EMPTY(bancos + agencias + contas + numeros) ;
2678: 				INTO CURSOR cursor_4c_VerChq ;
2679: 				GROUP BY 1
2680: 
2681: 			IF USED("cursor_4c_VerChq")
2682: 				SELECT cursor_4c_VerChq
2683: 				LOCATE FOR ntotal > 1
2684: 				IF FOUND()
2685: 					loc_lOk = .F.
2686: 					MsgAviso("Existem Cheques Lan" + CHR(231) + CHR(227) + "ados em Duplicidade Nessa Movimenta" + CHR(231) + CHR(227) + "o", "Aten" + CHR(231) + CHR(227) + "o")
2687: 				ENDIF
2688: 				USE IN cursor_4c_VerChq
2689: 			ENDIF
2690: 		CATCH TO loc_oErro
2691: 			MsgErro("Erro ao verificar cheques duplicados:" + CHR(13) + loc_oErro.Message, "Erro")
2692: 		ENDTRY
2693: 
2694: 		RETURN loc_lOk
2695: 	ENDPROC
2696: 
2697: 	*====================================================================
2698: 	* ValidarCondicoesLancadas - porta do SCAN principal do Ok.Click (dump
2699: 	* linhas 7906-7978): vencimento obrigatorio, # do credito (EmiVales=3),
2700: 	* observacao obrigatoria (Obs=3), autorizacao/adquirente (Autoriza=3),
2701: 	* NSU/adquirente (nsu=3), e o percentual de SigCdTif (Sim/Nao). O
2702: 	* catalogo de formas usadas e buscado de UMA vez so (nao por linha,
2703: 	* como o legado) - mesma adaptacao de CarregarFormasPagamento (Fase
2704: 	* 6/8) para o padrao de consulta unica deste projeto.
2705: 	*
2706: 	* PENDENCIA documentada: plFPagObrigs (obrigatoriedade de forma) nao
2707: 	* entra aqui - depende do catalogo SigOpFp x SigOpFpo x
2708: 	* SigCdEmp.grupo, fora de escopo (ver cabecalho de BtnConfirmarClick).
2709: 	*====================================================================
2710: 	PROTECTED PROCEDURE ValidarCondicoesLancadas(par_cAlias)
2711: 		LOCAL loc_lOk, loc_cFpagsIn, loc_cSQL, loc_nResultado, loc_nTotSim, ;
2712: 			loc_nTotNao, loc_nTtMaxSim, loc_nTtMaxNao, loc_oErro
2713: 
2714: 		loc_lOk     = .T.
2715: 		loc_nTotSim = 0
2716: 		loc_nTotNao = 0
2717: 
2718: 		TRY
2719: 			loc_cFpagsIn = ""
2720: 
2721: 			IF USED("cursor_4c_FormasUsadas")
2722: 				USE IN cursor_4c_FormasUsadas
2723: 			ENDIF
2724: 
2725: 			SELECT DISTINCT fpags FROM (par_cAlias) WHERE !EMPTY(fpags) INTO CURSOR cursor_4c_FormasUsadas
2726: 
2727: 			IF USED("cursor_4c_FormasUsadas") AND RECCOUNT("cursor_4c_FormasUsadas") > 0
2728: 				SELECT cursor_4c_FormasUsadas
2729: 				SCAN
2730: 					loc_cFpagsIn = loc_cFpagsIn + IIF(EMPTY(loc_cFpagsIn), "", ",") + EscaparSQL(ALLTRIM(fpags))
2731: 				ENDSCAN
2732: 				USE IN cursor_4c_FormasUsadas
2733: 			ENDIF
2734: 
2735: 			IF USED("cursor_4c_SigOpFpAtual")
2736: 				USE IN cursor_4c_SigOpFpAtual
2737: 			ENDIF
2738: 
2739: 			IF !EMPTY(loc_cFpagsIn)
2740: 				TEXT TO loc_cSQL TEXTMERGE NOSHOW
2741: 					SELECT fpags, emivales, obs, autoriza, nsu, opcsnas
2742: 					FROM SigOpFp
2743: 					WHERE fpags IN (<<loc_cFpagsIn>>)
2744: 				ENDTEXT
2745: 
2746: 				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigOpFpAtual")
2747: 				IF loc_nResultado >= 0 AND USED("cursor_4c_SigOpFpAtual")
2748: 					SELECT cursor_4c_SigOpFpAtual
2749: 					INDEX ON fpags TAG fpags
2750: 				ENDIF
2751: 			ENDIF
2752: 
2753: 			SELECT (par_cAlias)
2754: 			SCAN
2755: 				IF !EMPTY(fpags) AND EMPTY(vencs)
2756: 					loc_lOk = .F.
2757: 					MsgAviso("Vencimento Inv" + CHR(225) + "lido !", "Aten" + CHR(231) + CHR(227) + "o")
2758: 					EXIT
2759: 				ENDIF
2760: 
2761: 				IF USED("cursor_4c_SigOpFpAtual") AND SEEK(ALLTRIM(fpags), "cursor_4c_SigOpFpAtual", "fpags")
2762: 					IF cursor_4c_SigOpFpAtual.emivales = 3 AND TYPE(par_cAlias + ".outros") != "U" AND EMPTY(EVALUATE(par_cAlias + ".outros"))
2763: 						loc_lOk = .F.
2764: 						MsgAviso("Obrigat" + CHR(243) + "rio Informar # do Cr" + CHR(233) + "dito Utilizado", "Informa" + CHR(231) + CHR(227) + "o Obrigat" + CHR(243) + "ria")
2765: 						EXIT
2766: 					ENDIF
2767: 
2768: 					IF cursor_4c_SigOpFpAtual.obs = 3 AND TYPE(par_cAlias + ".obs") != "U" AND EMPTY(EVALUATE(par_cAlias + ".obs"))
2769: 						loc_lOk = .F.
2770: 						MsgAviso("Obrigat" + CHR(243) + "rio Digitar Observa" + CHR(231) + CHR(227) + "o", "Informa" + CHR(231) + CHR(227) + "o Obrigat" + CHR(243) + "ria")
2771: 						EXIT
2772: 					ENDIF
2773: 
2774: 					IF cursor_4c_SigOpFpAtual.autoriza = 3 AND TYPE(par_cAlias + ".autoriza") != "U" AND TYPE(par_cAlias + ".adquirente") != "U" AND ;
2775: 							(EMPTY(EVALUATE(par_cAlias + ".autoriza")) OR EMPTY(EVALUATE(par_cAlias + ".adquirente")))
2776: 						loc_lOk = .F.
2777: 						MsgAviso("Obrigat" + CHR(243) + "rio Digitar N" + CHR(250) + "meros Autoriza" + CHR(231) + CHR(227) + "o/Adquirente do Cart" + CHR(227) + "o", "Informa" + CHR(231) + CHR(227) + "o Obrigat" + CHR(243) + "ria")
2778: 						EXIT
2779: 					ENDIF
2780: 
2781: 					IF cursor_4c_SigOpFpAtual.nsu = 3 AND TYPE(par_cAlias + ".nsu") != "U" AND TYPE(par_cAlias + ".adquirente") != "U" AND ;
2782: 							(EMPTY(EVALUATE(par_cAlias + ".nsu")) OR EMPTY(EVALUATE(par_cAlias + ".adquirente")))
2783: 						loc_lOk = .F.
2784: 						MsgAviso("Obrigat" + CHR(243) + "rio Digitar N" + CHR(250) + "meros NSU/Adquirente do Cart" + CHR(227) + "o", "Informa" + CHR(231) + CHR(227) + "o Obrigat" + CHR(243) + "ria")
2785: 						EXIT
2786: 					ENDIF
2787: 
2788: 					loc_nTotSim = loc_nTotSim + IIF(cursor_4c_SigOpFpAtual.opcsnas = 1, valos, 0)
2789: 					loc_nTotNao = loc_nTotNao + IIF(cursor_4c_SigOpFpAtual.opcsnas = 2, valos, 0)
2790: 				ENDIF
2791: 
2792: 				SELECT (par_cAlias)
2793: 			ENDSCAN
2794: 
2795: 			IF loc_lOk AND !EMPTY(THIS.this_oBusinessObject.this_cTpFatsCab)
2796: 				IF USED("cursor_4c_SigCdTifAtual")
2797: 					USE IN cursor_4c_SigCdTifAtual
2798: 				ENDIF
2799: 
2800: 				TEXT TO loc_cSQL TEXTMERGE NOSHOW
2801: 					SELECT pvalors, opcsnas FROM SigCdTif WHERE codigos = <<EscaparSQL(THIS.this_oBusinessObject.this_cTpFatsCab)>>
2802: 				ENDTEXT
2803: 
2804: 				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdTifAtual")
2805: 
2806: 				IF loc_nResultado >= 0 AND USED("cursor_4c_SigCdTifAtual") AND !EOF("cursor_4c_SigCdTifAtual")
2807: 					IF cursor_4c_SigCdTifAtual.pvalors != 0 AND INLIST(cursor_4c_SigCdTifAtual.opcsnas, 1, 2) AND ;
2808: 							INLIST(THIS.this_oBusinessObject.this_nAptpfatsOpe, 2, 6)
2809: 
2810: 						loc_nTtMaxSim = ROUND(THIS.this_oBusinessObject.this_nValosCab * cursor_4c_SigCdTifAtual.pvalors / 100, 2)
2811: 						loc_nTtMaxNao = ROUND(THIS.this_oBusinessObject.this_nValosCab * (100 - cursor_4c_SigCdTifAtual.pvalors) / 100, 2)
2812: 
2813: 						IF ABS(loc_nTtMaxSim - loc_nTotSim) > 1 OR ABS(loc_nTtMaxNao - loc_nTotNao) > 1
2814: 							loc_lOk = .F.
2815: 							MsgAviso("Valores divergentes para condi" + CHR(231) + CHR(227) + "o de Pagamento Sim / N" + CHR(227) + "o", "Aten" + CHR(231) + CHR(227) + "o")
2816: 						ENDIF
2817: 					ENDIF
2818: 				ENDIF
2819: 
2820: 				IF USED("cursor_4c_SigCdTifAtual")
2821: 					USE IN cursor_4c_SigCdTifAtual
2822: 				ENDIF
2823: 			ENDIF
2824: 		CATCH TO loc_oErro
2825: 			MsgErro("Erro ao validar condi" + CHR(231) + CHR(245) + "es de pagamento:" + CHR(13) + ;
2826: 				loc_oErro.Message + CHR(13) + ;
2827: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2828: 				"Procedure: " + loc_oErro.Procedure, "Erro")
2829: 			loc_lOk = .F.
2830: 		ENDTRY
2831: 
2832: 		IF USED("cursor_4c_FormasUsadas")
2833: 			USE IN cursor_4c_FormasUsadas
2834: 		ENDIF
2835: 		IF USED("cursor_4c_SigOpFpAtual")
2836: 			USE IN cursor_4c_SigOpFpAtual
2837: 		ENDIF
2838: 		IF USED("cursor_4c_SigCdTifAtual")
2839: 			USE IN cursor_4c_SigCdTifAtual
2840: 		ENDIF
2841: 
2842: 		RETURN loc_lOk
2843: 	ENDPROC
2844: 
2845: 	*====================================================================
2846: 	* PersistirCondicoes - grava cada linha de par_cAlias em SigMvPar via
2847: 	* THIS.this_oBusinessObject (Inserir() quando cidchaves ainda esta
2848: 	* vazio - linha nova; Atualizar() quando ja existe). A base ja exibe
2849: 	* MsgErro em qualquer falha de SQL (regra #20) - sem ELSE aqui.
2850: 	*====================================================================
2851: 	PROTECTED PROCEDURE PersistirCondicoes(par_cAlias)
2852: 		LOCAL loc_lOk, loc_nRecno
2853: 
2854: 		loc_lOk    = .T.
2855: 		loc_nRecno = 0
2856: 
2857: 		SELECT (par_cAlias)
2858: 		IF !EOF() AND !BOF()
2859: 			loc_nRecno = RECNO()
2860: 		ENDIF
2861: 
2862: 		SELECT (par_cAlias)
2863: 		SCAN WHILE loc_lOk
2864: 			IF THIS.this_oBusinessObject.CarregarDoCursor(par_cAlias)
2865: 				IF EMPTY(THIS.this_oBusinessObject.this_cCidchaves)
2866: 					loc_lOk = THIS.this_oBusinessObject.Inserir()
2867: 				ELSE
2868: 					loc_lOk = THIS.this_oBusinessObject.Atualizar()
2869: 				ENDIF
2870: 			ELSE
2871: 				loc_lOk = .F.
2872: 			ENDIF
2873: 
2874: 			SELECT (par_cAlias)
2875: 		ENDSCAN
2876: 
2877: 		IF loc_nRecno > 0 AND BETWEEN(loc_nRecno, 1, RECCOUNT(par_cAlias))
2878: 			SELECT (par_cAlias)
2879: 			GOTO loc_nRecno
2880: 		ENDIF
2881: 
2882: 		RETURN loc_lOk
2883: 	ENDPROC
2884: 
2885: 	*====================================================================
2886: 	* BtnCancelarClick - porta literal de SIGOPPAG.Cancela.Click (dump linha
2887: 	* 8468): confirma/libera a transacao TEF em aberto (VerifTef - funcao GLOBAL do
2888: 	* legado sem definicao no acervo migrado; wrapper no-op documentado em
2889: 	* utils\verifteF.prg, regra #27), reabilita o form pai e fecha este
2890: 	* dialogo.
2891: 	*====================================================================
2892: 	PROCEDURE BtnCancelarClick()
2893: 		THIS.FecharDialogo()
2894: 	ENDPROC
2895: 
2896: 	*====================================================================
2897: 	* FecharDialogo - funil unico de fechamento (Ok/Cancela), com guarda de
2898: 	* reentrancia (this_lFechando) contra Release() duplicado. Legado:
2899: 	*
2900: 	*   Cancela.Click:  =VerifTef(thisform.parentform)
2901: 	*                   Thisform.parentform.enabled = .T.
2902: 	*                   Thisform.release
2903: 	*   Ok.Click:       (termina com "ThisForm.Return" - metodo de uma
2904: 	*                   classe-base do VCX legado que nao esta no acervo;
2905: 	*                   aqui o fechamento segue o MESMO padrao observavel
2906: 	*                   do Cancela - reabilita o pai e libera a tela -
2907: 	*                   desvio documentado, nao uma transcricao literal).
2908: 	*====================================================================
2909: 	PROTECTED PROCEDURE FecharDialogo()
2910: 		LOCAL loc_oErro
2911: 
2912: 		IF THIS.this_lFechando
2913: 			RETURN
2914: 		ENDIF
2915: 
2916: 		THIS.this_lFechando = .T.
2917: 
2918: 		TRY
2919: 			VerifTef(THIS.this_oFormPai)
2920: 
2921: 			IF VARTYPE(THIS.this_oFormPai) = "O" AND PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
2922: 				THIS.this_oFormPai.Enabled = .T.
2923: 			ENDIF
2924: 
2925: 			THIS.Release()
2926: 		CATCH TO loc_oErro
2927: 			MsgErro("Erro ao encerrar a tela de condi" + CHR(231) + CHR(245) + "es de pagamento:" + CHR(13) + loc_oErro.Message, "Erro")
2928: 			THIS.this_lFechando = .F.
2929: 		ENDTRY
2930: 	ENDPROC
2931: 
2932: 	*====================================================================
2933: 	* Destroy - DODEFAULT() OBRIGATORIO (FormBase.Destroy restaura o
2934: 	* menu principal apos form filho fechar - regra do "menu encolhendo").
2935: 	* Fecha apenas o cursor placeholder criado por este form: xPar pertence
2936: 	* ao form PAI (DataSession compartilhada) e NAO pode ser fechado aqui.
2937: 	*====================================================================
2938: 	PROCEDURE Destroy()
2939: 		IF USED(THIS.this_cCursorCondicoes)
2940: 			USE IN (THIS.this_cCursorCondicoes)
2941: 		ENDIF
2942: 
2943: 		IF USED(THIS.this_cCursorFormasPagamento)
2944: 			USE IN (THIS.this_cCursorFormasPagamento)
2945: 		ENDIF
2946: 
2947: 		DODEFAULT()
2948: 	ENDPROC
2949: 
2950: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigoppagBO.prg):
*====================================================================
* sigoppagBO.prg
*
* Business Object do dialogo OPERACIONAL "SIGOPPAG" ("Recebimento" -
* condicoes de pagamento/recebimento de um movimento). O legado abre
* este form como FILHO do form de cabecalho do movimento (Lparameters
* pForm, datses, plAltDireta, plAutomatico - Set Datasession To datses,
* isto e, o filho passa a compartilhar a MESMA data session do pai, com
* os cursores xPar/TprMvCab/crSigCdOpe/crSigMvNfi/crSigCdCfo/crSigCdPam
* ja abertos por ele).
*
* Tabelas envolvidas: SigMvPar (condicoes de pagamento/parcelas do
* movimento - cursor legado xPar, chave cidchaves), SigMvCab (cabecalho
* do movimento - espelhado no cursor temporario TprMvCab do pai),
* SigCdOpe (configuracao da operacao), SigOpFp (catalogo de formas de
* pagamento), SigCdMoe (moedas), SigCdCrt (bandeiras de cartao),
* SigCdCad (adquirentes/modalidades - tipocads = 'ADQUIRENTE'),
* SigCdMod (modalidades de pagamento), SigCqChm/SigChe (protocolo e
* cheque), SigCdCtt (protocolo de cartao de credito).
*
* Referencias legado -> BO (linha do xPar sendo incluida/alterada,
* mapeamento 1-para-1 para SigMvPar):
*   xPar.Agencias/Bancos/Cartaos/Contas/CotFPgs/Dopes/EmpOs/FPags/
*   InsChs/MoeFPgs/NCarnes/NCarts/NoCreditos/Nsu/NumChqs/Numeros/Numes/
*   NumOlds/Obs/Outros/Trocos/ValDescs/Valos/Vencs/adquirente/autoriza/
*   cnIdTefs/nIdCheps/Parcs/TParcs/VPags ->
*       this_cAgencias/this_cBancos/this_cCartaos/this_cContas/
*       this_nCotfpgs/this_cDopes/this_cEmpos/this_cFpags/this_lInschs/
*       this_cMoefpgs/this_cNcarnes/this_nNcarts/this_cNocreditos/
*       this_cNsu/this_cNumchqs/this_cNumeros/this_nNumes/
*       this_nNumolds/this_cObs/this_cOutros/this_nTrocos/
*       this_nValdescs/this_nValos/this_dVencs/this_cAdquirente/
*       this_cAutoriza/this_cCnidtefs/this_nNidcheps/this_nParcs/
*       this_nTparcs/this_nVpags
*   (demais colunas de SigMvPar sem uso direto no codigo analisado -
*   declaradas do mesmo jeito, para paridade de schema/INSERT futuro:
*   this_nEcNumes/this_cGrclis/this_cIclis/this_cImpcars/this_cLocals/
*   this_nNcopias/this_nNopers/this_nNrecs/this_nNtrans/this_cCotusus/
*   this_cCnnsuparcs/this_nNumlotechs/this_cCidchaves/this_nValocurs/
*   this_cEmpdopnums/this_cPagos/this_dDtalts/this_cCpfs/
*   this_cDigagencs/this_cDigchqs/this_cDigcontas/this_cPracas/
*   this_cCodbcrts/this_lLcancelas/this_nVcofins/this_nVcsll/this_nVirf/
*   this_nVlrtrbfs/this_nVpis/this_cChaveexterna/this_dDatas/
*   this_dDatatrans/this_cDcarts/this_dDpags/this_dDtdeps/this_cEmps)
*
* Cabecalho do movimento (TprMvCab/SigMvCab), lido via Emps+Dopes+Numes
* (this_cEmps/this_cDopes/this_nNumes abaixo). Sufixo "Cab" evita colisao
* com propriedades de mesmo nome da linha de SigMvPar (ex.: this_nValos
* e o valor da PARCELA; this_nValosCab e o total do movimento):
*   TprMvCab.ContaOs/ContaDs/Datas/Notas/PrazoEnts/TabDs/TpFats/ValDevs/
*   ValEncs/ValInis/ValServs/ValTrans/ValUtiCsh/ValVarPs/ValVars/Valos/
*   VarTots/Vars -> this_cContaOsCab/this_cContaDsCab/this_dDatasCab/
*   this_cNotasCab/this_dPrazoEntsCab/this_cTabDsCab/this_cTpFatsCab/
*   this_nValDevsCab/this_nValEncsCab/this_nValInisCab/this_nValServsCab/
*   this_nValTransCab/this_nValUtiCshCab/this_nValVarPsCab/
*   this_nValVarsCab/this_nValosCab/this_nVarTotsCab/this_nVarsCab
*   (TabDs/TpFats corrigidos para CHAR na Fase 7/8 - docs\schema.sql mostra
*   SigMvCab.tabds char(10) e tpfats char(3); a Fase 1 os declarara como
*   numeric por engano e nenhum outro arquivo do projeto os referenciava
*   ainda, regra #19 - MaxLength/tipo vem do schema, nunca de palpite)
*
* Configuracao da operacao (SigCdOpe), lida via Dopes = this_cDopes.
* Sufixo "Ope" pelo mesmo motivo (SigCdOpe.Vars/parcs tambem colidiriam
* com propriedades de SigMvPar/outro config):
*   SigCdOpe.BlqDatas/CMoes/COpers/Caixas/Confes/Deacrs/DtEntrs/EdComis/
*   FPagOpCrs/HabServs/LPrecos/Opers/ParRecals/parcs/PesoVts/PrecoAuts/
*   PrecoVts/ValPres/Vars/aptpfats/cheqs/cupfis ->
*       this_nBlqDatasOpe/this_cCMoesOpe/this_nCopersOpe/this_nCaixasOpe/
*       this_nConfesOpe/this_nDeacrsOpe/this_nDtEntrsOpe/this_nEdComisOpe/
*       this_cFPagOpCrsOpe/this_nHabServsOpe/this_nLPrecosOpe/
*       this_nOpersOpe/this_nParRecalsOpe/this_nParcsOpe/this_nPesoVtsOpe/
*       this_nPrecoAutsOpe/this_nPrecoVtsOpe/this_nValPresOpe/
*       this_nVarsOpe/this_nAptpfatsOpe/this_nCheqsOpe/this_nCupfisOpe
*
* Flags recebidas do form pai na abertura (legado: plAltDireta,
* plAutomatico) -> this_lAltDireta/this_lAutomatico. poForm (referencia
* de UI) e a troca de DataSession ficam no FORM.
*
* Herda de: BusinessBase
*
* Fase 1/8 - propriedades e Init(). A leitura de SigMvCab/SigCdOpe (os
* campos *Cab/*Ope acima) sera carregada por metodo proprio em fase
* posterior - os valores abaixo ficam com o default ate la.
*
* Fase 2/8 - CarregarDoCursor()/Inserir()/Atualizar()/ObterChavePrimaria()
* para a CONDICAO/PARCELA de SigMvPar (chave cidchaves), com
* RegistrarAuditoria() (herdado de BusinessBase) chamado em
* Inserir/Atualizar. cidchaves e a chave Fortyus (fUniqueIds(), regra
* #22) gerada no Inserir quando ainda vazia; empdopnums e a chave
* posicional Emps(3)+Dopes(20)+Str(Numes,6) (regra #42 - PADR explicito,
* nunca ALLTRIM nas partes).
*
* Fase 7/8 - CarregarConfiguracao() (SigMvCab/SigCdOpe, equivalentes aos
* cursores que o FORM PAI legado ja tinha abertos - regra #35/cabecalho
* acima), CarregarCondicoes() (leitura de SigMvPar para a grade - o
* legado faz isso via AddCursor no Init do pai; aqui e feito por SQLEXEC
* em cursor temporario + ZAP/APPEND no cursor ja ligado ao Grid, regra
* "SQLEXEC sobre alias de grid zera o ColumnCount") e ExcluirCondicao()
* (DELETE por cidchaves, chamado pelo Apaga.Click do form quando a linha
* corrente ja foi persistida em SigMvPar).
*====================================================================

DEFINE CLASS sigoppagBO AS BusinessBase

	*-- Flags recebidas do form pai na abertura (legado: Lparameters
	*-- pForm, datses, plAltDireta, plAutomatico). poForm (referencia de
	*-- UI) e a troca de DataSession ficam no Form.
	this_lAltDireta = .F.           && plAltDireta - fluxo de alteracao direta da condicao (pula parte da validacao de limite)
	this_lAutomatico = .F.          && plAutomatico - fluxo automatico (sem interacao do usuario, ex.: TEF/cartao processado por integracao)

	*-- Identificacao do cabecalho do movimento (legado: TprMvCab.Emps/
	*-- Dopes/Numes, compartilhados pela DataSession do pai). O form
	*-- migrado repassa so os valores escalares - mesmos valores que
	*-- aparecem tambem em cada linha de SigMvPar (emps/dopes/numes).
	this_cEmps = ""                 && Empresa do movimento (TprMvCab.Emps / SigMvCab.emps / SigMvPar.emps)
	this_cDopes = ""                && Documento de Operacao (TprMvCab.Dopes / SigMvCab.dopes / SigMvPar.dopes)
	this_nNumes = 0                 && Numero do movimento (TprMvCab.Numes / SigMvCab.numes / SigMvPar.numes)

	*-- Cabecalho do movimento (TprMvCab/SigMvCab), lido via Emps+Dopes+
	*-- Numes acima. Sufixo "Cab" para nao colidir com propriedade de
	*-- mesmo nome da linha de SigMvPar (ex.: valos). Populados em fase
	*-- posterior (leitura via SQLEXEC); default abaixo.
	this_cContaOsCab = ""           && TprMvCab.ContaOs - conta de origem do movimento (credito a estornar/base de calculo)
	this_cContaDsCab = ""           && TprMvCab.ContaDs - conta de destino do movimento (cliente/fornecedor, usado em Chklimite/CursorQuery de SigCdCli)
	this_dDatasCab = {}             && TprMvCab.Datas - data do movimento, base do vencimento default da parcela
	this_cNotasCab = ""             && TprMvCab.Notas - numero/mascara da nota fiscal do movimento (usado na mensagem de confirmacao do Ok.Click)
	this_dPrazoEntsCab = {}         && TprMvCab.PrazoEnts - prazo de entrega, usado como base alternativa do vencimento quando CrSigOpFp.TpVencs = 2
	this_cTabDsCab = ""             && TprMvCab.TabDs - tabela de preco de destino (char(10) no schema - SigMvCab.tabds)
	this_cTpFatsCab = ""            && TprMvCab.TpFats - tipo de faturamento do movimento (char(3) no schema - SigMvCab.tpfats; chave de SigCdTif.Codigos no Ok.Click)
	this_nValDevsCab = 0            && TprMvCab.ValDevs - valor de devolucao (usado no calculo do total a receber quando Vars = 4)
	this_nValEncsCab = 0            && TprMvCab.ValEncs - valor de encargos do movimento
	this_nValInisCab = 0            && TprMvCab.ValInis - valor inicial do movimento (base de calculo de desconto/acrescimo)
	this_nValServsCab = 0           && TprMvCab.ValServs - valor total de servicos do movimento (somado ao valor de produto no calculo de variacao)
	this_nValTransCab = 0           && TprMvCab.ValTrans - valor de transporte/frete do movimento
	this_nValUtiCshCab = 0          && TprMvCab.ValUtiCsh - valor de cashback/bonus utilizado no movimento
	this_nValVarPsCab = 0           && TprMvCab.ValVarPs - percentual de variacao (desconto/acrescimo) aplicado ao movimento
	this_nValVarsCab = 0            && TprMvCab.ValVars - valor de variacao (desconto negativo/acrescimo positivo) do movimento
	this_nValosCab = 0              && TprMvCab.Valos - valor total do movimento (a ratear entre as condicoes de pagamento)
	this_nVarTotsCab = 0            && TprMvCab.VarTots - total de variacao acumulado do movimento
	this_nVarsCab = 0               && TprMvCab.Vars - percentual de variacao do movimento (espelha ValVarPs em alguns pontos do legado)

	*-- Configuracao da operacao (SigCdOpe), lida via Dopes = this_cDopes.
	*-- Sufixo "Ope" pelo mesmo motivo de colisao de nomes (Vars/parcs
	*-- tambem existem em outras origens). Populados em fase posterior;
	*-- default abaixo.
	this_nBlqDatasOpe = 0           && SigCdOpe.BlqDatas - bloqueia alteracao de vencimento (1=sempre, 3=so para tras) no Valid de Dataget_venc
	this_cCMoesOpe = ""             && SigCdOpe.CMoes - moeda padrao da operacao (usada na cotacao de moeda da operacao x moeda de pagamento)
	this_nCopersOpe = 0             && SigCdOpe.COpers - tipo de calculo de troco/complemento (1=debita da conta, 2=credita)
	this_nCaixasOpe = 0             && SigCdOpe.Caixas - 1 = operacao movimenta caixa (habilita protocolo de cheque obrigatorio)
	this_nConfesOpe = 0             && SigCdOpe.Confes - 1 = condicao de pagamento ja confirmada (desabilita cartao de credito manual)
	this_nDeacrsOpe = 0             && SigCdOpe.Deacrs - habilita os containers de desconto/acrescimo manual (Get_PorcVariacao/Get_TotVariacao)
	this_nDtEntrsOpe = 0            && SigCdOpe.DtEntrs - habilita uso do prazo de entrega como base alternativa do vencimento (confirmar tipo exato no schema)
	this_nEdComisOpe = 0            && SigCdOpe.EdComis - habilita edicao manual do numero de parcelas (Get_npar)
	this_cFPagOpCrsOpe = ""         && SigCdOpe.FPagOpCrs - forma de pagamento padrao/credito da operacao (usada em Apaga.Click/comparacoes de forma)
	this_nHabServsOpe = 0           && SigCdOpe.HabServs - habilita o campo de total de servicos (Get_TotServico)
	this_nLPrecosOpe = 0            && SigCdOpe.LPrecos - operacao usa lista de precos (afeta regra de variacao/desconto)
	this_nOpersOpe = 0              && SigCdOpe.Opers - 1=Entrada/2=Saida, direcao da operacao
	this_nParRecalsOpe = 0          && SigCdOpe.ParRecals - recalcula parcelas automaticamente ao mudar o valor
	this_nParcsOpe = 0              && SigCdOpe.parcs - 1 = operacao permite parcelamento (habilita Get_npar/Get_vpar)
	this_nPesoVtsOpe = 0            && SigCdOpe.PesoVts - operacao totaliza por peso (usado em Bot_TotItem.Click)
	this_nPrecoAutsOpe = 0          && SigCdOpe.PrecoAuts - autoriza precificacao automatica (espelha o uso em outros BOs de item)
	this_nPrecoVtsOpe = 0           && SigCdOpe.PrecoVts - operacao totaliza por valor de venda (usado em Bot_TotItem.Click)
	this_nValPresOpe = 0            && SigCdOpe.ValPres - operacao exige valor presente (desconta juros/calcula a valor presente)
	this_nVarsOpe = 0               && SigCdOpe.Vars - tipo de variacao permitido na operacao (3 = bloqueia Desconto/Acrescimo)
	this_nAptpfatsOpe = 0           && SigCdOpe.aptpfats - tipo de fatura/apuracao da operacao
	this_nCheqsOpe = 0              && SigCdOpe.cheqs - operacao aceita cheque como forma de pagamento
	this_nCupfisOpe = 0             && SigCdOpe.cupfis - 3 = cupom fiscal/nao fiscal (regras de TEF e bloqueio de valor zero)
	this_nParAutosOpe = 0           && SigCdOpe.parautos - 4 = bloqueia exclusao de condicao InsChs (Apaga.Click); 5 = bloqueia o proprio botao Apaga (regra externa ao Click, nao portada nesta fase)

	*-- Nome do cursor que este BO popula/consome (constante, para o Form
	*-- referenciar sem repetir literal - equivalente ao alias global do
	*-- legado xPar)
	this_cCursorCondicoes = "cursor_4c_Condicoes"  && Grade de condicoes de pagamento do movimento (SigMvPar)

	*-- Propriedades da entidade (mapeamento 1-para-1 para a tabela
	*-- SigMvPar - uma CONDICAO/PARCELA de pagamento do movimento, chave
	*-- cidchaves). this_cEmps/this_cDopes/this_nNumes acima JA cobrem as
	*-- colunas emps/dopes/numes - nao duplicar.
	this_cAgencias     = ""   && agencias char(4) - agencia bancaria do cheque
	this_cBancos       = ""   && bancos char(3) - banco do cheque
	this_cCartaos      = ""   && cartaos char(20) - numero do cartao de credito
	this_cContas       = ""   && contas char(10) - conta bancaria do cheque
	this_nCotfpgs      = 0    && cotfpgs numeric(11,4) - cotacao da moeda de pagamento na data da condicao
	this_dDatas        = {}   && datas datetime - data da condicao (preenchimento conforme regra de negocio da operacao)
	this_dDatatrans    = {}   && datatrans datetime - data da transacao (TEF/cartao)
	this_cDcarts       = ""   && dcarts char(12) - data de validade do cartao (MM/AAAA ou similar, mascara do legado)
	this_nEcNumes      = 0    && ec_numes numeric(6,0) - numero do comprovante eletronico de cheque (DOC/TED)
	this_cFpags        = ""   && fpags char(12) - codigo da forma de pagamento (SigOpFp.Fpags)
	this_cGrclis       = ""   && grclis char(10) - grupo do cliente/conta na data da condicao
	this_cIclis        = ""   && iclis char(10) - codigo da conta (cliente/fornecedor) associada a condicao
	this_cImpcars      = ""   && impcars char(1) - indicador de impressao do carne/boleto
	this_lInschs       = .F.  && inschs bit - condicao inserida via leitor de cheque (insercao automatica)
	this_cLocals       = ""   && locals char(10) - local/filial de recebimento
	this_cMoefpgs      = ""   && moefpgs char(3) - moeda da forma de pagamento
	this_cNcarnes      = ""   && ncarnes char(11) - numero do carne de pagamento
	this_nNcarts       = 0    && ncarts numeric(10,0) - numero sequencial de protocolo do cartao de credito
	this_nNcopias      = 0    && ncopias numeric(6,0) - numero de copias impressas do comprovante
	this_cNocreditos   = ""   && nocreditos char(10) - numero/codigo de aprovacao do credito (cartao/cheque pre-datado)
	this_nNopers       = 0    && nopers numeric(7,0) - numero da operacao de TEF/cartao
	this_nNrecs        = 0    && nrecs numeric(11,0) - numero do recibo gerado para a condicao
	this_nNtrans       = 0    && ntrans numeric(6,0) - numero da transacao (TEF)
	this_cNumchqs      = ""   && numchqs char(8) - numero do cheque
	this_cNumeros      = ""   && numeros char(6) - numero da conta bancaria do cheque (complemento de contas)
	this_nNumolds      = 0    && numolds numeric(6,0) - numero antigo/sequencia de regravacao da condicao (controle de aprovacao)
	this_cOutros       = ""   && outros char(20) - campo livre complementar da condicao
	this_nValos        = 0    && valos numeric(11,2) - valor da parcela/condicao de pagamento
	this_dVencs        = {}   && vencs datetime - data de vencimento da parcela
	this_nVpags        = 0    && vpags numeric(11,2) - valor efetivamente pago/recebido da parcela
	this_cCotusus      = ""   && cotusus char(30) - usuario que autorizou a cotacao manual
	this_cObs          = ""   && obs text - observacao da condicao de pagamento
	this_nParcs        = 0    && parcs numeric(2,0) - numero da parcela (sequencial dentro do total de parcelas)
	this_cCnidtefs     = ""   && cnidtefs char(10) - identificador da transacao TEF
	this_cCnnsuparcs   = ""   && cnnsuparcs char(12) - NSU da parcela (TEF/cartao)
	this_nNumlotechs   = 0    && numlotechs numeric(8,0) - numero do lote de cheques
	this_nNidcheps     = 0    && nidcheps numeric(10,0) - identificador do cheque pre-datado associado
	this_cEmpos        = ""   && empos char(3) - empresa de origem (quando a condicao se refere a outra empresa do grupo)
	this_cCidchaves    = ""   && cidchaves char(20) - PK (fUniqueIds())
	this_nValocurs     = 0    && valocurs numeric(11,2) - valor da condicao convertido na moeda corrente
	this_nTrocos       = 0    && trocos numeric(1,0) - 1 = condicao representa troco/complemento devolvido ao cliente
	this_cEmpdopnums   = ""   && empdopnums char(29) - Emps(3)+Dopes(20)+Str(Numes,6), chave posicional que liga a condicao ao cabecalho (regra #42)
	this_cPagos        = ""   && pagos char(1) - indicador S/N de condicao ja liquidada
	this_dDtalts       = {}   && dtalts datetime - data da ultima alteracao da condicao
	this_cCpfs         = ""   && cpfs char(20) - CPF/CNPJ do titular do cartao/cheque, quando divergente da conta
	this_cDigagencs    = ""   && digagencs char(1) - digito verificador da agencia bancaria
	this_cDigchqs      = ""   && digchqs char(1) - digito verificador do cheque
	this_cDigcontas    = ""   && digcontas char(1) - digito verificador da conta bancaria
	this_cPracas       = ""   && pracas char(3) - praca bancaria do cheque
	this_nTparcs       = 0    && tparcs numeric(2,0) - total de parcelas da condicao (denominador de Parcs)
	this_nValdescs     = 0    && valdescs numeric(11,2) - valor de desconto aplicado a esta condicao
	this_cCodbcrts     = ""   && codbcrts char(5) - codigo da bandeira do cartao (SigCdCrt)
	this_lLcancelas    = .F.  && lcancelas bit - condicao cancelada (exclusao logica)
	this_nVcofins      = 0    && vcofins numeric(14,2) - valor de COFINS retido na condicao
	this_nVcsll        = 0    && vcsll numeric(14,2) - valor de CSLL retido na condicao
	this_nVirf         = 0    && virf numeric(14,2) - valor de IRF retido na condicao
	this_nVlrtrbfs     = 0    && vlrtrbfs numeric(14,2) - valor de tributo federal retido na condicao
	this_nVpis         = 0    && vpis numeric(14,2) - valor de PIS retido na condicao
	this_cAdquirente   = ""   && adquirente char(8) - codigo da adquirente do cartao (SigCdCad, tipocads = 'ADQUIRENTE')
	this_cAutoriza     = ""   && autoriza char(6) - codigo de autorizacao da transacao de cartao
	this_cNsu          = ""   && nsu char(50) - NSU (Numero Sequencial Unico) da transacao de cartao/TEF
	this_cChaveexterna = ""   && chaveexterna char(33) - chave de integracao externa (TEF/adquirente)

	*====================================================================
	* Init - Inicializa Business Object
	* Parametros equivalentes ao Lparameters pForm, datses, plAltDireta,
	* plAutomatico do Init do form legado - o form migrado repassa os
	* valores escalares que identificam o cabecalho do movimento
	* (par_cEmps/par_cDopes/par_nNumes, lidos pelo form a partir do
	* chamador) alem das duas flags de comportamento (poForm/datses, que
	* sao referencia de UI e troca de DataSession, ficam no Form).
	*====================================================================
	PROCEDURE Init(par_cEmps, par_cDopes, par_nNumes, par_lAltDireta, par_lAutomatico)
		DODEFAULT()

		*-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
		THIS.this_cTabela = "SigMvPar"
		THIS.this_cCampoChave = "cidchaves"

		IF VARTYPE(par_cEmps) = "C"
			THIS.this_cEmps = par_cEmps
		ENDIF

		IF VARTYPE(par_cDopes) = "C"
			THIS.this_cDopes = par_cDopes
		ENDIF

		IF VARTYPE(par_nNumes) = "N"
			THIS.this_nNumes = par_nNumes
		ENDIF

		IF VARTYPE(par_lAltDireta) = "L"
			THIS.this_lAltDireta = par_lAltDireta
		ENDIF

		IF VARTYPE(par_lAutomatico) = "L"
			THIS.this_lAutomatico = par_lAutomatico
		ENDIF

		RETURN .T.
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia uma linha de SigMvPar (cursor populado por
	* SQLEXEC, ex.: this_cCursorCondicoes) para as properties desta
	* condicao/parcela. NAO eh PROTECTED (regra #51 - BusinessBase declara
	* publico e o Form chama direto ao posicionar a linha da grade).
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lResultado
		loc_lResultado = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)

			THIS.this_cEmps         = TratarNulo(emps, "")
			THIS.this_cDopes        = TratarNulo(dopes, "")
			THIS.this_nNumes        = TratarNulo(numes, 0)
			THIS.this_cAgencias     = TratarNulo(agencias, "")
			THIS.this_cBancos       = TratarNulo(bancos, "")
			THIS.this_cCartaos      = TratarNulo(cartaos, "")
			THIS.this_cContas       = TratarNulo(contas, "")
			THIS.this_nCotfpgs      = TratarNulo(cotfpgs, 0)
			THIS.this_dDatas        = TratarNulo(datas, {})
			THIS.this_dDatatrans    = TratarNulo(datatrans, {})
			THIS.this_cDcarts       = TratarNulo(dcarts, "")
			THIS.this_nEcNumes      = TratarNulo(ec_numes, 0)
			THIS.this_cFpags        = TratarNulo(fpags, "")
			THIS.this_cGrclis       = TratarNulo(grclis, "")
			THIS.this_cIclis        = TratarNulo(iclis, "")
			THIS.this_cImpcars      = TratarNulo(impcars, "")
			THIS.this_lInschs       = ConverterParaLogico(inschs)
			THIS.this_cLocals       = TratarNulo(locals, "")
			THIS.this_cMoefpgs      = TratarNulo(moefpgs, "")
			THIS.this_cNcarnes      = TratarNulo(ncarnes, "")
			THIS.this_nNcarts       = TratarNulo(ncarts, 0)
			THIS.this_nNcopias      = TratarNulo(ncopias, 0)
			THIS.this_cNocreditos   = TratarNulo(nocreditos, "")
			THIS.this_nNopers       = TratarNulo(nopers, 0)
			THIS.this_nNrecs        = TratarNulo(nrecs, 0)
			THIS.this_nNtrans       = TratarNulo(ntrans, 0)
			THIS.this_cNumchqs      = TratarNulo(numchqs, "")
			THIS.this_cNumeros      = TratarNulo(numeros, "")
			THIS.this_nNumolds      = TratarNulo(numolds, 0)
			THIS.this_cOutros       = TratarNulo(outros, "")
			THIS.this_nValos        = TratarNulo(valos, 0)
			THIS.this_dVencs        = TratarNulo(vencs, {})
			THIS.this_nVpags        = TratarNulo(vpags, 0)
			THIS.this_cCotusus      = TratarNulo(cotusus, "")
			THIS.this_cObs          = TratarNulo(obs, "")
			THIS.this_nParcs        = TratarNulo(parcs, 0)
			THIS.this_cCnidtefs     = TratarNulo(cnidtefs, "")
			THIS.this_cCnnsuparcs   = TratarNulo(cnnsuparcs, "")
			THIS.this_nNumlotechs   = TratarNulo(numlotechs, 0)
			THIS.this_nNidcheps     = TratarNulo(nidcheps, 0)
			THIS.this_cEmpos        = TratarNulo(empos, "")
			THIS.this_cCidchaves    = TratarNulo(cidchaves, "")
			THIS.this_nValocurs     = TratarNulo(valocurs, 0)
			THIS.this_nTrocos       = TratarNulo(trocos, 0)
			THIS.this_cEmpdopnums   = TratarNulo(empdopnums, "")
			THIS.this_cPagos        = TratarNulo(pagos, "")
			THIS.this_dDtalts       = TratarNulo(dtalts, {})
			THIS.this_cCpfs         = TratarNulo(cpfs, "")
			THIS.this_cDigagencs    = TratarNulo(digagencs, "")
			THIS.this_cDigchqs      = TratarNulo(digchqs, "")
			THIS.this_cDigcontas    = TratarNulo(digcontas, "")
			THIS.this_cPracas       = TratarNulo(pracas, "")
			THIS.this_nTparcs       = TratarNulo(tparcs, 0)
			THIS.this_nValdescs     = TratarNulo(valdescs, 0)
			THIS.this_cCodbcrts     = TratarNulo(codbcrts, "")
			THIS.this_lLcancelas    = ConverterParaLogico(lcancelas)
			THIS.this_nVcofins      = TratarNulo(vcofins, 0)
			THIS.this_nVcsll        = TratarNulo(vcsll, 0)
			THIS.this_nVirf         = TratarNulo(virf, 0)
			THIS.this_nVlrtrbfs     = TratarNulo(vlrtrbfs, 0)
			THIS.this_nVpis         = TratarNulo(vpis, 0)
			THIS.this_cAdquirente   = TratarNulo(adquirente, "")
			THIS.this_cAutoriza     = TratarNulo(autoriza, "")
			THIS.this_cNsu          = TratarNulo(nsu, "")
			THIS.this_cChaveexterna = TratarNulo(chaveexterna, "")

			loc_lResultado = .T.
		ENDIF

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - cidchaves (PK Fortyus, regra #22). PROTECTED:
	* nunca chamado de fora (so por RegistrarAuditoria/ExecutarExclusao).
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN THIS.this_cCidchaves
	ENDPROC

	*====================================================================
	* Inserir - INSERT completo em SigMvPar (condicao/parcela do
	* movimento). cidchaves (PK) e gerada aqui se ainda vazia (regra #22
	* - fUniqueIds(), NUNCA string vazia). empdopnums e a chave posicional
	* Emps(3)+Dopes(20)+Str(Numes,6) (regra #42 - PADR explicito, NUNCA
	* ALLTRIM nas partes). dpags/dtdeps (datetime NULL, sem uso no
	* codigo legado analisado) ficam fora da lista - SQL Server grava
	* NULL por omissao, o que e permitido pelo schema.
	*====================================================================
	PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

		loc_lSucesso = .F.

		IF EMPTY(THIS.this_cCidchaves)
			THIS.this_cCidchaves = fUniqueIds()
		ENDIF

		THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + ;
			PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				INSERT INTO SigMvPar (
					emps, dopes, numes, agencias, bancos, cartaos, contas, cotfpgs,
					datas, datatrans, dcarts, ec_numes, fpags, grclis, iclis, impcars,
					inschs, locals, moefpgs, ncarnes, ncarts, ncopias, nocreditos,
					nopers, nrecs, ntrans, numchqs, numeros, numolds, outros, valos,
					vencs, vpags, cotusus, obs, parcs, cnidtefs, cnnsuparcs,
					numlotechs, nidcheps, empos, cidchaves, valocurs, trocos,
					empdopnums, pagos, dtalts, cpfs, digagencs, digchqs, digcontas,
					pracas, tparcs, valdescs, codbcrts, lcancelas, vcofins, vcsll,
					virf, vlrtrbfs, vpis, adquirente, autoriza, nsu, chaveexterna
				)
				VALUES (
					<<EscaparSQL(LEFT(THIS.this_cEmps, 3))>>,
					<<EscaparSQL(LEFT(THIS.this_cDopes, 20))>>,
					<<FormatarNumeroSQL(THIS.this_nNumes, 0)>>,
					<<EscaparSQL(LEFT(THIS.this_cAgencias, 4))>>,
					<<EscaparSQL(LEFT(THIS.this_cBancos, 3))>>,
					<<EscaparSQL(LEFT(THIS.this_cCartaos, 20))>>,
					<<EscaparSQL(LEFT(THIS.this_cContas, 10))>>,
					<<FormatarNumeroSQL(THIS.this_nCotfpgs, 4)>>,
					<<FormatarDataSQL(THIS.this_dDatas)>>,
					<<FormatarDataSQL(THIS.this_dDatatrans)>>,
					<<EscaparSQL(LEFT(THIS.this_cDcarts, 12))>>,
					<<FormatarNumeroSQL(THIS.this_nEcNumes, 0)>>,
					<<EscaparSQL(LEFT(THIS.this_cFpags, 12))>>,
					<<EscaparSQL(LEFT(THIS.this_cGrclis, 10))>>,
					<<EscaparSQL(LEFT(THIS.this_cIclis, 10))>>,
					<<EscaparSQL(LEFT(THIS.this_cImpcars, 1))>>,
					<<IIF(THIS.this_lInschs, "1", "0")>>,
					<<EscaparSQL(LEFT(THIS.this_cLocals, 10))>>,
					<<EscaparSQL(LEFT(THIS.this_cMoefpgs, 3))>>,
					<<EscaparSQL(LEFT(THIS.this_cNcarnes, 11))>>,
					<<FormatarNumeroSQL(THIS.this_nNcarts, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nNcopias, 0)>>,
					<<EscaparSQL(LEFT(THIS.this_cNocreditos, 10))>>,
					<<FormatarNumeroSQL(THIS.this_nNopers, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nNrecs, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nNtrans, 0)>>,
					<<EscaparSQL(LEFT(THIS.this_cNumchqs, 8))>>,
					<<EscaparSQL(LEFT(THIS.this_cNumeros, 6))>>,
					<<FormatarNumeroSQL(THIS.this_nNumolds, 0)>>,
					<<EscaparSQL(LEFT(THIS.this_cOutros, 20))>>,
					<<FormatarNumeroSQL(THIS.this_nValos, 2)>>,
					<<FormatarDataSQL(THIS.this_dVencs)>>,
					<<FormatarNumeroSQL(THIS.this_nVpags, 2)>>,
					<<EscaparSQL(LEFT(THIS.this_cCotusus, 30))>>,
					<<EscaparSQL(THIS.this_cObs)>>,
					<<FormatarNumeroSQL(THIS.this_nParcs, 0)>>,
					<<EscaparSQL(LEFT(THIS.this_cCnidtefs, 10))>>,
					<<EscaparSQL(LEFT(THIS.this_cCnnsuparcs, 12))>>,
					<<FormatarNumeroSQL(THIS.this_nNumlotechs, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nNidcheps, 0)>>,
					<<EscaparSQL(LEFT(THIS.this_cEmpos, 3))>>,
					<<EscaparSQL(LEFT(THIS.this_cCidchaves, 20))>>,
					<<FormatarNumeroSQL(THIS.this_nValocurs, 2)>>,
					<<FormatarNumeroSQL(THIS.this_nTrocos, 0)>>,
					<<EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29))>>,
					<<EscaparSQL(LEFT(THIS.this_cPagos, 1))>>,
					<<FormatarDataSQL(THIS.this_dDtalts)>>,
					<<EscaparSQL(LEFT(THIS.this_cCpfs, 20))>>,
					<<EscaparSQL(LEFT(THIS.this_cDigagencs, 1))>>,
					<<EscaparSQL(LEFT(THIS.this_cDigchqs, 1))>>,
					<<EscaparSQL(LEFT(THIS.this_cDigcontas, 1))>>,
					<<EscaparSQL(LEFT(THIS.this_cPracas, 3))>>,
					<<FormatarNumeroSQL(THIS.this_nTparcs, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nValdescs, 2)>>,
					<<EscaparSQL(LEFT(THIS.this_cCodbcrts, 5))>>,
					<<IIF(THIS.this_lLcancelas, "1", "0")>>,
					<<FormatarNumeroSQL(THIS.this_nVcofins, 2)>>,
					<<FormatarNumeroSQL(THIS.this_nVcsll, 2)>>,
					<<FormatarNumeroSQL(THIS.this_nVirf, 2)>>,
					<<FormatarNumeroSQL(THIS.this_nVlrtrbfs, 2)>>,
					<<FormatarNumeroSQL(THIS.this_nVpis, 2)>>,
					<<EscaparSQL(LEFT(THIS.this_cAdquirente, 8))>>,
					<<EscaparSQL(LEFT(THIS.this_cAutoriza, 6))>>,
					<<EscaparSQL(LEFT(THIS.this_cNsu, 50))>>,
					<<EscaparSQL(LEFT(THIS.this_cChaveexterna, 33))>>
				)
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERIR")
				loc_lSucesso = .T.
			ELSE
				THIS.this_cMensagemErro = CapturarErroSQL()
				MostrarErro("Erro ao inserir condi" + CHR(231) + CHR(227) + "o de pagamento:" + CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
			ENDIF

		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MostrarErro("Erro ao inserir condi" + CHR(231) + CHR(227) + "o de pagamento:" + CHR(13) + loc_oErro.Message, "sigoppagBO.Inserir")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE completo em SigMvPar pela PK cidchaves. emps/
	* dopes/numes/cidchaves identificam o registro e NAO entram no SET.
	*====================================================================
	PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

		loc_lSucesso = .F.

		THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + ;
			PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				UPDATE SigMvPar SET
					agencias     = <<EscaparSQL(LEFT(THIS.this_cAgencias, 4))>>,
					bancos       = <<EscaparSQL(LEFT(THIS.this_cBancos, 3))>>,
					cartaos      = <<EscaparSQL(LEFT(THIS.this_cCartaos, 20))>>,
					contas       = <<EscaparSQL(LEFT(THIS.this_cContas, 10))>>,
					cotfpgs      = <<FormatarNumeroSQL(THIS.this_nCotfpgs, 4)>>,
					datas        = <<FormatarDataSQL(THIS.this_dDatas)>>,
					datatrans    = <<FormatarDataSQL(THIS.this_dDatatrans)>>,
					dcarts       = <<EscaparSQL(LEFT(THIS.this_cDcarts, 12))>>,
					ec_numes     = <<FormatarNumeroSQL(THIS.this_nEcNumes, 0)>>,
					fpags        = <<EscaparSQL(LEFT(THIS.this_cFpags, 12))>>,
					grclis       = <<EscaparSQL(LEFT(THIS.this_cGrclis, 10))>>,
					iclis        = <<EscaparSQL(LEFT(THIS.this_cIclis, 10))>>,
					impcars      = <<EscaparSQL(LEFT(THIS.this_cImpcars, 1))>>,
					inschs       = <<IIF(THIS.this_lInschs, "1", "0")>>,
					locals       = <<EscaparSQL(LEFT(THIS.this_cLocals, 10))>>,
					moefpgs      = <<EscaparSQL(LEFT(THIS.this_cMoefpgs, 3))>>,
					ncarnes      = <<EscaparSQL(LEFT(THIS.this_cNcarnes, 11))>>,
					ncarts       = <<FormatarNumeroSQL(THIS.this_nNcarts, 0)>>,
					ncopias      = <<FormatarNumeroSQL(THIS.this_nNcopias, 0)>>,
					nocreditos   = <<EscaparSQL(LEFT(THIS.this_cNocreditos, 10))>>,
					nopers       = <<FormatarNumeroSQL(THIS.this_nNopers, 0)>>,
					nrecs        = <<FormatarNumeroSQL(THIS.this_nNrecs, 0)>>,
					ntrans       = <<FormatarNumeroSQL(THIS.this_nNtrans, 0)>>,
					numchqs      = <<EscaparSQL(LEFT(THIS.this_cNumchqs, 8))>>,
					numeros      = <<EscaparSQL(LEFT(THIS.this_cNumeros, 6))>>,
					numolds      = <<FormatarNumeroSQL(THIS.this_nNumolds, 0)>>,
					outros       = <<EscaparSQL(LEFT(THIS.this_cOutros, 20))>>,
					valos        = <<FormatarNumeroSQL(THIS.this_nValos, 2)>>,
					vencs        = <<FormatarDataSQL(THIS.this_dVencs)>>,
					vpags        = <<FormatarNumeroSQL(THIS.this_nVpags, 2)>>,
					cotusus      = <<EscaparSQL(LEFT(THIS.this_cCotusus, 30))>>,
					obs          = <<EscaparSQL(THIS.this_cObs)>>,
					parcs        = <<FormatarNumeroSQL(THIS.this_nParcs, 0)>>,
					cnidtefs     = <<EscaparSQL(LEFT(THIS.this_cCnidtefs, 10))>>,
					cnnsuparcs   = <<EscaparSQL(LEFT(THIS.this_cCnnsuparcs, 12))>>,
					numlotechs   = <<FormatarNumeroSQL(THIS.this_nNumlotechs, 0)>>,
					nidcheps     = <<FormatarNumeroSQL(THIS.this_nNidcheps, 0)>>,
					empos        = <<EscaparSQL(LEFT(THIS.this_cEmpos, 3))>>,
					valocurs     = <<FormatarNumeroSQL(THIS.this_nValocurs, 2)>>,
					trocos       = <<FormatarNumeroSQL(THIS.this_nTrocos, 0)>>,
					empdopnums   = <<EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29))>>,
					pagos        = <<EscaparSQL(LEFT(THIS.this_cPagos, 1))>>,
					dtalts       = <<FormatarDataSQL(THIS.this_dDtalts)>>,
					cpfs         = <<EscaparSQL(LEFT(THIS.this_cCpfs, 20))>>,
					digagencs    = <<EscaparSQL(LEFT(THIS.this_cDigagencs, 1))>>,
					digchqs      = <<EscaparSQL(LEFT(THIS.this_cDigchqs, 1))>>,
					digcontas    = <<EscaparSQL(LEFT(THIS.this_cDigcontas, 1))>>,
					pracas       = <<EscaparSQL(LEFT(THIS.this_cPracas, 3))>>,
					tparcs       = <<FormatarNumeroSQL(THIS.this_nTparcs, 0)>>,
					valdescs     = <<FormatarNumeroSQL(THIS.this_nValdescs, 2)>>,
					codbcrts     = <<EscaparSQL(LEFT(THIS.this_cCodbcrts, 5))>>,
					lcancelas    = <<IIF(THIS.this_lLcancelas, "1", "0")>>,
					vcofins      = <<FormatarNumeroSQL(THIS.this_nVcofins, 2)>>,
					vcsll        = <<FormatarNumeroSQL(THIS.this_nVcsll, 2)>>,
					virf         = <<FormatarNumeroSQL(THIS.this_nVirf, 2)>>,
					vlrtrbfs     = <<FormatarNumeroSQL(THIS.this_nVlrtrbfs, 2)>>,
					vpis         = <<FormatarNumeroSQL(THIS.this_nVpis, 2)>>,
					adquirente   = <<EscaparSQL(LEFT(THIS.this_cAdquirente, 8))>>,
					autoriza     = <<EscaparSQL(LEFT(THIS.this_cAutoriza, 6))>>,
					nsu          = <<EscaparSQL(LEFT(THIS.this_cNsu, 50))>>,
					chaveexterna = <<EscaparSQL(LEFT(THIS.this_cChaveexterna, 33))>>
				WHERE cidchaves = <<EscaparSQL(LEFT(THIS.this_cCidchaves, 20))>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("ALTERAR")
				loc_lSucesso = .T.
			ELSE
				THIS.this_cMensagemErro = CapturarErroSQL()
				MostrarErro("Erro ao atualizar condi" + CHR(231) + CHR(227) + "o de pagamento:" + CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
			ENDIF

		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MostrarErro("Erro ao atualizar condi" + CHR(231) + CHR(227) + "o de pagamento:" + CHR(13) + loc_oErro.Message, "sigoppagBO.Atualizar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarConfiguracao - le o cabecalho do movimento (TprMvCab, cursor
	* que o FORM PAI legado ja deixa aberto na DataSession compartilhada -
	* regra #35/cabecalho do topo deste arquivo) e a configuracao da
	* operacao (SigCdOpe, via SQLEXEC por Dopes). Chamado pelo Form logo
	* apos instanciar o BO, ANTES de CarregarCondicoes()/CarregarLista().
	*
	* TprMvCab e um cursor MONTADO pelo form pai (nao necessariamente
	* 1-para-1 com as colunas de SigMvCab) - por isso cada leitura e
	* guardada por TYPE() != "U": campo ausente la NAO e erro aqui, so
	* mantem o default ja declarado na propriedade.
	*====================================================================
	PROCEDURE CarregarConfiguracao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro

		loc_lSucesso = .F.

		TRY
			IF USED("TprMvCab")
				SELECT TprMvCab
				IF RECCOUNT() > 0 AND !EOF()
					IF TYPE("TprMvCab.contaos") != "U"
						THIS.this_cContaOsCab = TratarNulo(contaos, "")
					ENDIF
					IF TYPE("TprMvCab.contads") != "U"
						THIS.this_cContaDsCab = TratarNulo(contads, "")
					ENDIF
					IF TYPE("TprMvCab.datas") != "U"
						THIS.this_dDatasCab = TratarNulo(datas, {})
					ENDIF
					IF TYPE("TprMvCab.notas") != "U"
						THIS.this_cNotasCab = TratarNulo(notas, "")
					ENDIF
					IF TYPE("TprMvCab.prazoents") != "U"
						THIS.this_dPrazoEntsCab = TratarNulo(prazoents, {})
					ENDIF
					IF TYPE("TprMvCab.tabds") != "U"
						THIS.this_cTabDsCab = TratarNulo(tabds, "")
					ENDIF
					IF TYPE("TprMvCab.tpfats") != "U"
						THIS.this_cTpFatsCab = TratarNulo(tpfats, "")
					ENDIF
					IF TYPE("TprMvCab.valdevs") != "U"
						THIS.this_nValDevsCab = TratarNulo(valdevs, 0)
					ENDIF
					IF TYPE("TprMvCab.valencs") != "U"
						THIS.this_nValEncsCab = TratarNulo(valencs, 0)
					ENDIF
					IF TYPE("TprMvCab.valinis") != "U"
						THIS.this_nValInisCab = TratarNulo(valinis, 0)
					ENDIF
					IF TYPE("TprMvCab.valservs") != "U"
						THIS.this_nValServsCab = TratarNulo(valservs, 0)
					ENDIF
					IF TYPE("TprMvCab.valtrans") != "U"
						THIS.this_nValTransCab = TratarNulo(valtrans, 0)
					ENDIF
					IF TYPE("TprMvCab.valuticsh") != "U"
						THIS.this_nValUtiCshCab = TratarNulo(valuticsh, 0)
					ENDIF
					IF TYPE("TprMvCab.valvarps") != "U"
						THIS.this_nValVarPsCab = TratarNulo(valvarps, 0)
					ENDIF
					IF TYPE("TprMvCab.valvars") != "U"
						THIS.this_nValVarsCab = TratarNulo(valvars, 0)
					ENDIF
					IF TYPE("TprMvCab.valos") != "U"
						THIS.this_nValosCab = TratarNulo(valos, 0)
					ENDIF
					IF TYPE("TprMvCab.vartots") != "U"
						THIS.this_nVarTotsCab = TratarNulo(vartots, 0)
					ENDIF
					IF TYPE("TprMvCab.vars") != "U"
						THIS.this_nVarsCab = TratarNulo(vars, 0)
					ENDIF
				ENDIF
			ENDIF

			IF USED("cursor_4c_SigCdOpeTmp")
				USE IN cursor_4c_SigCdOpeTmp
			ENDIF

			IF !EMPTY(THIS.this_cDopes)
				TEXT TO loc_cSQL TEXTMERGE NOSHOW
					SELECT blqdatas, cmoes, copers, caixas, confes, deacrs, dtentrs,
						   edcomis, fpagopcrs, habservs, lprecos, opers, parrecals,
						   parcs, pesovts, precoauts, precovts, valpres, vars,
						   aptpfats, cheqs, cupfis, parautos
					FROM SigCdOpe
					WHERE dopes = <<EscaparSQL(THIS.this_cDopes)>>
				ENDTEXT

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdOpeTmp")

				IF loc_nResultado >= 0 AND USED("cursor_4c_SigCdOpeTmp") AND !EOF("cursor_4c_SigCdOpeTmp")
					SELECT cursor_4c_SigCdOpeTmp
					THIS.this_nBlqDatasOpe  = TratarNulo(blqdatas, 0)
					THIS.this_cCMoesOpe     = TratarNulo(cmoes, "")
					THIS.this_nCopersOpe    = TratarNulo(copers, 0)
					THIS.this_nCaixasOpe    = TratarNulo(caixas, 0)
					THIS.this_nConfesOpe    = TratarNulo(confes, 0)
					THIS.this_nDeacrsOpe    = TratarNulo(deacrs, 0)
					THIS.this_nDtEntrsOpe   = TratarNulo(dtentrs, 0)
					THIS.this_nEdComisOpe   = TratarNulo(edcomis, 0)
					THIS.this_cFPagOpCrsOpe = TratarNulo(fpagopcrs, "")
					THIS.this_nHabServsOpe  = TratarNulo(habservs, 0)
					THIS.this_nLPrecosOpe   = TratarNulo(lprecos, 0)
					THIS.this_nOpersOpe     = TratarNulo(opers, 0)
					THIS.this_nParRecalsOpe = TratarNulo(parrecals, 0)
					THIS.this_nParcsOpe     = TratarNulo(parcs, 0)
					THIS.this_nPesoVtsOpe   = TratarNulo(pesovts, 0)
					THIS.this_nPrecoAutsOpe = TratarNulo(precoauts, 0)
					THIS.this_nPrecoVtsOpe  = TratarNulo(precovts, 0)
					THIS.this_nValPresOpe   = TratarNulo(valpres, 0)
					THIS.this_nVarsOpe      = TratarNulo(vars, 0)
					THIS.this_nAptpfatsOpe  = TratarNulo(aptpfats, 0)
					THIS.this_nCheqsOpe     = TratarNulo(cheqs, 0)
					THIS.this_nCupfisOpe    = TratarNulo(cupfis, 0)
					THIS.this_nParAutosOpe  = TratarNulo(parautos, 0)
				ENDIF

				IF USED("cursor_4c_SigCdOpeTmp")
					USE IN cursor_4c_SigCdOpeTmp
				ENDIF
			ENDIF

			loc_lSucesso = .T.
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MostrarErro("Erro ao carregar configura" + CHR(231) + CHR(227) + "o do movimento:" + CHR(13) + loc_oErro.Message, "sigoppagBO.CarregarConfiguracao")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarCondicoes - porta PARCIAL do carregamento de condicoes de
	* SigMvPar para a grade. No legado isso e feito pelo FORM PAI, via
	* AddCursor no seu proprio Init, deixando xPar ja aberto e
	* compartilhado com este form filho (regra #35/cabecalho). Quando este
	* form roda ISOLADO (sem pai - modo de teste/validacao de UI), xPar
	* nao existe: este metodo busca SigMvPar por Emps+Dopes+Numes via
	* SQLEXEC e substitui o CONTEUDO do cursor_4c_Condicoes (ja criado e
	* ligado ao Grid por Formsigoppag::ConfigurarGrid) SEM refazer a
	* estrutura - SQLEXEC direto no alias do grid zeraria o ColumnCount.
	*====================================================================
	PROCEDURE CarregarCondicoes()
		LOCAL loc_cSQL, loc_nResultado, loc_cCursorTmp, loc_lSucesso, loc_oErro

		loc_lSucesso   = .F.
		loc_cCursorTmp = "cursor_4c_CondicoesTmp"

		IF !USED(THIS.this_cCursorCondicoes)
			RETURN loc_lSucesso
		ENDIF

		TRY
			IF USED(loc_cCursorTmp)
				USE IN (loc_cCursorTmp)
			ENDIF

			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				SELECT cidchaves, emps, dopes, numes, fpags, valos, vencs,
					   moefpgs, cotfpgs, valdescs, inschs, numchqs, nidcheps, trocos
				FROM SigMvPar
				WHERE emps = <<EscaparSQL(THIS.this_cEmps)>>
				  AND dopes = <<EscaparSQL(THIS.this_cDopes)>>
				  AND numes = <<FormatarNumeroSQL(THIS.this_nNumes, 0)>>
				ORDER BY vencs
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTmp)

			IF loc_nResultado >= 0 AND USED(loc_cCursorTmp)
				SELECT (THIS.this_cCursorCondicoes)
				ZAP
				APPEND FROM (DBF(loc_cCursorTmp))

				USE IN (loc_cCursorTmp)

				SELECT (THIS.this_cCursorCondicoes)
				GO TOP

				loc_lSucesso = .T.
			ELSE
				THIS.this_cMensagemErro = CapturarErroSQL()
				MostrarErro("Erro ao carregar condi" + CHR(231) + CHR(245) + "es de pagamento:" + CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MostrarErro("Erro ao carregar condi" + CHR(231) + CHR(245) + "es de pagamento:" + CHR(13) + loc_oErro.Message, "sigoppagBO.CarregarCondicoes")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExcluirCondicao - DELETE direto em SigMvPar pela PK cidchaves, usado
	* pelo Apaga.Click do form (regra #22 - cidchaves e a PK Fortyus).
	* Linha que nunca foi persistida (cidchaves ainda vazio) nao precisa de
	* DELETE remoto - retorna sucesso sem tocar no banco.
	*====================================================================
	PROCEDURE ExcluirCondicao(par_cCidchaves)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro

		loc_lSucesso = .F.

		IF EMPTY(par_cCidchaves)
			RETURN .T.
		ENDIF

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				DELETE FROM SigMvPar WHERE cidchaves = <<EscaparSQL(LEFT(par_cCidchaves, 20))>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				THIS.this_cMensagemErro = CapturarErroSQL()
				MostrarErro("Erro ao excluir condi" + CHR(231) + CHR(227) + "o de pagamento:" + CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MostrarErro("Erro ao excluir condi" + CHR(231) + CHR(227) + "o de pagamento:" + CHR(13) + loc_oErro.Message, "sigoppagBO.ExcluirCondicao")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

