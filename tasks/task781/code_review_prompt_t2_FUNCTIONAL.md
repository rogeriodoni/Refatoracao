# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (8)
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [METODO-INEXISTENTE] Metodo 'THIS.PEAntValue()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.NumeroDoCampo()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-WITH] Bloco WITH loc_cCodEscolhido define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_cCodEscolhido.RecordSource).
- [GRID-WITH] Bloco WITH THIS.grd_4c_Parcelas define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Parcelas.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigoporc.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (5195 linhas total):

*-- Linhas 25 a 68:
25: * reproduzido aqui como cnt_4c_Sombra.
26: *
27: * FASE 3/8 - ESTRUTURA BASE: esqueleto do form (propriedades visuais,
28: * Init/InicializarForm, BO e o cabecalho).
29: *
30: * FASE 4/8 - GRADES E BOTOES DE LINHA: as DUAS grades do legado e os
31: * botoes que operam linha nelas, mais o funil de carga:
32: *   grdItem    -> grd_4c_Itens     (30 colunas) + cmd_4c_IncluirLinha /
33: *                                    cmd_4c_ExcluirLinha (btnIncluir/
34: *                                    btnExcluir do legado)
35: *   grdParcela -> grd_4c_Parcelas  (7 colunas)  + cmd_4c_IncluirParcela /
36: *                                    cmd_4c_ExcluirParcela (btnIncluirp/
37: *                                    btnExcluirp do legado)
38: *
39: * Cada grade tem o par Configurar<X> (so o que NAO depende de dado) +
40: * Vincular<X> (RecordSource/ControlSource sob USED, e depois deles
41: * Width/Header1.Caption) - separados porque atribuir RecordSource RESETA
42: * Width e Header1.Caption (regra #41/Problema 48) e o bind acontece mais
43: * de uma vez. CarregarDados() e o FUNIL (PUBLIC) que garante os cursores,
44: * vincula, posiciona os aliases e repinta - transcrevendo o fecho do Init
45: * legado (Set Order/Set Key/Go Top + thisform.Refresh + Grade.Refresh).
46: *
47: * FASE 5/8 - CAMPOS PRINCIPAIS (PARTE 1): os campos de percentual/calculo
48: * do topo (Say5/getPmargem, say4/getPtax2, say1/getPtaxa, Say3/getPTax1,
49: * say2/getPimposto, Say6/getPservico - migrados para
50: * lbl_4c_Margem/txt_4c_Margem, lbl_4c_Contingente/txt_4c_Contingente,
51: * lbl_4c_TaxaAdm/txt_4c_TaxaAdm, lbl_4c_BV/txt_4c_BV, lbl_4c_Imposto/
52: * txt_4c_Imposto, lbl_4c_ImpostoServico/txt_4c_ImpostoServico) + Shape4
53: * (shp_4c_Painel) + get_NewGrp/Say_NewGrp (txt_4c_NovoGrupo/
54: * lbl_4c_NovoGrupo, com o lookup de Grupo transcrito) + getDescritivo
55: * (edt_4c_DescritivoRodape) + TotalizarItn() (motor de calculo chamado
56: * pelos 5 campos editaveis).
57: *
58: * FASE 6/8 - CAMPOS RESTANTES E LOOKUPS (PARTE 2): getDpros/getDpro2s/
59: * btnProcura (busca textual na grade de itens, migrados para
60: * txt_4c_ProcuraDpros/edt_4c_ProcuraDpro2s/cmd_4c_Procurar) + imgProds
61: * (pre-visualizacao da foto do produto, migrado para img_4c_Produto,
62: * com zoom via ImgProdutoDblClick - SigOpZom nao migrado, fallback
63: * ShellExecute igual ao de Formsigprccp.FigJpgDblClick) + os lookups de
64: * CELULA de unidade (grdItem.Column4/Column6 - SigCdUni, compartilhando
65: * ValidarUnidadeGenerica) e de acabamento (grdItem.Column30 - SigCdAca).
66: * this_nImagems/this_nConfes (novas no BO) seguem o padrao "populado em
67: * fase posterior" de this_nCadProds/etc.
68: *

*-- Linhas 88 a 131:
88: * editar (PILAR 1).
89: *
90: * FASE 7/8 - FORM: leitura de SigCdOpe/SigCdEmp/SigOpCdd/SigMvCab
91: * (BO.CarregarConfiguracao, chamada em InicializarForm antes de qualquer
92: * Configurar*() que dependa do modo), carga real dos itens/parcelas do
93: * orcamento (BO.CarregarItens/CarregarParcelas, chamadas em
94: * CarregarDados - ate aqui os cursores existiam mas ficavam sempre
95: * vazios), os botoes de acao do rodape (btnIteSub/btnTotItens/btnInsBlo/
96: * btnInsSub/btnCadPro/OK -> cmd_4c_IteSub/cmd_4c_TotItens/cmd_4c_InsBlo/
97: * cmd_4c_InsSub/cmd_4c_CadPro/obj_4c_OK) e a gravacao da grade inteira no
98: * SQL Server ao confirmar (BtnSalvarClick).
99: *
100: * DOIS GAPS DOCUMENTADOS (nao silenciosos - ver cabecalho de cada
101: * metodo):
102: *   - btnIteSub/btnTotItens abrem "SigOpTor", dialogo legado SEPARADO
103: *     nunca migrado para este projeto (sem task propria) - o clique
104: *     avisa a pendencia (AvisarSigOpTorPendente) em vez de inventar uma
105: *     tela sem fonte no legado.
106: *   - btnCadPro NAO reproduz o contrato sincrono do legado ("Do Form
107: *     SigCdPro ... To lcCodProduto" + cascata de precificacao
108: *     automatica) - abre FormProduto (CRUD ja migrado, task propria) no
109: *     padrao de Init do projeto, sem retorno sincrono; o usuario digita
110: *     o codigo do produto novo no item depois de cadastra-lo.
111: *   - btnInsBlo/btnInsSub NAO reproduzem o ramo "Inlist(crSigCdOpe.
112: *     DigItens,6,7)" do legado (sub-itens de crSigOpCdI.JOB_MV_BLO) - a
113: *     tabela SigOpCdI NAO EXISTE no schema canonico (docs\schema.sql,
114: *     regra #14), e sem ela esse ramo e impossivel de transcrever.
115: *
116: * FASE 8/8 - EVENTOS AUXILIARES E CONSOLIDACAO FINAL:
117: *   - CarregarLista()        funil de RECARGA das duas grades (saiu de
118: *                            dentro de CarregarDados, que agora delega) -
119: *                            rele SigMvOrc/SigMvOrp, revincula, PRESERVA a
120: *                            linha corrente (SEEK por Citens) e repinta
121: *   - FormParaBO()/BOParaForm()  sincronizacao manual dos 5 percentuais do
122: *                            topo, que no legado era automatica pelo
123: *                            ControlSource = TprMvCab.<coluna> (ptax2s/
124: *                            descs/ptax1s/acres/ptax3s). Sem BOParaForm os
125: *                            campos abriam sempre em 0,00 e o primeiro
126: *                            Enter num deles zerava o percentual de TODOS
127: *                            os itens
128: *   - HabilitarCampos()      os "When" dos CAMPOS num lugar so
129: *   - AjustarBotoesPorModo() os "When" dos BOTOES num lugar so
130: *   - LimparCampos()         reset do estado auxiliar da tela (busca/
131: *                            grupo novo/foto/valores anteriores)

*-- Linhas 179 a 222:
179: *   par_cMascNum   - TprMvCab.MascNum (repassado ao BO, usado no Caption)
180: *   par_cOpEscolha - poForm.pcEscolha (modo herdado do pai; "CONSULTAR"
181: *                    quando SigCdOpe.DigItens = 5 - resolvido em
182: *                    InicializarForm, apos o BO carregar DigItens)
183: *====================================================================
184: 
185: DEFINE CLASS Formsigoporc AS FormBase
186: 
187: 	*-- Propriedades visuais (pixel-perfect SCX original - PILAR 1)
188: 	Width        = 1000
189: 	Height       = 600
190: 	AutoCenter   = .T.
191: 	Caption      = "Itens"
192: 	ShowWindow   = 1
193: 	WindowType   = 1
194: 	ControlBox   = .F.
195: 	MaxButton    = .F.
196: 	MinButton    = .F.
197: 	TitleBar     = 0
198: 	BorderStyle  = 2
199: 	ShowTips     = .T.
200: 	DataSession  = 1
201: 
202: 	*-- Referencia ao form pai e BO
203: 	this_oFormPai        = .NULL.
204: 	this_oBusinessObject = .NULL.
205: 
206: 	*-- Parametros recebidos do form pai (equivalentes a TprMvCab.Emps/
207: 	*-- Dopes/Numes/MascNum do legado, repassados ao BO no Init)
208: 	this_cEmps     = ""
209: 	this_cDopes    = ""
210: 	this_nNumes    = 0
211: 	this_cMascNum  = ""
212: 
213: 	*-- Propriedades customizadas do SCX legado (ver cabecalho acima)
214: 	this_oObjExt1   = .NULL.
215: 	this_cOpEscolha = ""
216: 	this_lAutPreco  = .F.
217: 	this_lProcura   = .F.
218: 	this_cAntDpros  = ""
219: 	this_nOldPreco  = 0
220: 	this_nCItAgr    = 0
221: 	this_nCItem     = 0
222: 

*-- Linhas 229 a 407:
229: 	*-- dispara SEMPRE, inclusive sem digitacao nova. Guarda o ultimo
230: 	*-- valor ja processado para a proxima perda de foco sem mudanca sair
231: 	*-- sem reconsultar/reabrir o picker.
232: 	this_cUltimoTxtNovoGrupoLostFocusValidado = ""
233: 
234: 	*-- Guarda de reentrancia dos lookups de CELULA da grade de itens
235: 	*-- (unidade de venda/pedido, acabamento e produto). Mesmo motivo do
236: 	*-- this_lEmLookupGrupo: o FormBuscaAuxiliar e modal, tira o foco da
237: 	*-- celula e redispara o evento que abriu o picker. Uma flag por
238: 	*-- familia de lookup, para um picker nao bloquear o outro.
239: 	this_lEmLookupUnidade    = .F.
240: 	this_lEmLookupAcabamento = .F.
241: 	this_lEmLookupProduto    = .F.
242: 
243: 	*-- Canal de retorno dos metodos AbrirBusca* (VFP9 nao devolve par de
244: 	*-- valores): o metodo de busca grava aqui o codigo e a descricao
245: 	*-- escolhidos no picker, e o handler Validar* que o chamou le e
246: 	*-- aplica no cursor. Vazios quando o usuario cancelou (ESC) - mesma
247: 	*-- semantica do "If Lastkey() = 27" do legado.
248: 	this_cLookupCodigo    = ""
249: 	this_cLookupDescricao = ""
250: 
251: 	*==========================================================================
252: 	* Init - Armazena parametros recebidos do form pai antes de DODEFAULT
253: 	*==========================================================================
254: 	PROCEDURE Init(par_oFormPai, par_cEmps, par_cDopes, par_nNumes, ;
255: 			par_cMascNum, par_cOpEscolha)
256: 		LOCAL loc_lResultado
257: 		loc_lResultado = .F.
258: 
259: 		IF VARTYPE(par_oFormPai) = "O"
260: 			THIS.this_oFormPai = par_oFormPai
261: 		ENDIF
262: 
263: 		THIS.this_cEmps    = IIF(VARTYPE(par_cEmps) = "C", ALLTRIM(par_cEmps), "")
264: 		THIS.this_cDopes   = IIF(VARTYPE(par_cDopes) = "C", ALLTRIM(par_cDopes), "")
265: 		THIS.this_nNumes   = IIF(VARTYPE(par_nNumes) = "N", par_nNumes, 0)
266: 		THIS.this_cMascNum = IIF(VARTYPE(par_cMascNum) = "C", ALLTRIM(par_cMascNum), "")
267: 
268: 		*-- Legado: Op_Escolha = Iif(crSigCdOpe.DigItens = 5, 'CONSULTAR', poForm.pcEscolha)
269: 		*-- O ramo DigItens=5 depende do BO (SigCdOpe ainda nao carregado aqui) e
270: 		*-- fica resolvido em InicializarForm; por ora guarda so o valor do pai.
271: 		THIS.this_cOpEscolha = IIF(VARTYPE(par_cOpEscolha) = "C" AND !EMPTY(par_cOpEscolha), ;
272: 			UPPER(ALLTRIM(par_cOpEscolha)), "CONSULTAR")
273: 
274: 		loc_lResultado = DODEFAULT()
275: 		RETURN loc_lResultado
276: 	ENDPROC
277: 
278: 	*==========================================================================
279: 	* InicializarForm - Cria o BO e monta o cabecalho. As grades (itens/
280: 	* parcelas), os botoes e os campos de percentual/calculo ficam para
281: 	* as fases seguintes.
282: 	*==========================================================================
283: 	PROTECTED PROCEDURE InicializarForm()
284: 		LOCAL loc_lSucesso, loc_oErro, loc_lModoValidacaoOuTeste
285: 		loc_lSucesso = .F.
286: 		loc_lModoValidacaoOuTeste = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
287: 			(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
288: 
289: 		TRY
290: 			THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
291: 
292: 			THIS.this_oBusinessObject = CREATEOBJECT("sigoporcBO", ;
293: 				THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes, THIS.this_cMascNum)
294: 
295: 			IF VARTYPE(THIS.this_oBusinessObject) <> "O"
296: 				MsgErro("Erro ao criar sigoporcBO. VARTYPE retornou: " + ;
297: 					VARTYPE(THIS.this_oBusinessObject), "Formsigoporc.InicializarForm")
298: 			ELSE
299: 				*-- Legado: Thisform.Caption = Alltrim(Emps)+' '+Alltrim(Dopes)+' '+
300: 				*-- Alltrim(MascNum)+' - Itens'. Em validacao de UI / modo teste nao
301: 				*-- recalcula: o comparador confere contra o Caption ESTATICO do SCX
302: 				*-- ("Itens"), e Emps/Dopes/MascNum chegam vazios nesses modos (sem
303: 				*-- form pai nem conexao SQL) - recalcular so trocaria o texto fiel
304: 				*-- por outro tambem incorreto.
305: 				IF !loc_lModoValidacaoOuTeste
306: 					THIS.Caption = THIS.this_oBusinessObject.this_cCaption
307: 				ENDIF
308: 
309: 				IF !loc_lModoValidacaoOuTeste
310: 					THIS.this_oBusinessObject.CarregarConfiguracao()
311: 					IF THIS.this_oBusinessObject.this_nDigItens = 5
312: 						THIS.this_cOpEscolha = "CONSULTAR"
313: 					ENDIF
314: 				ENDIF
315: 
316: 				THIS.ConfigurarCabecalho()
317: 				THIS.ConfigurarGridItens()
318: 				THIS.ConfigurarBotoesItens()
319: 				THIS.ConfigurarGradeParcelas()
320: 				THIS.ConfigurarBotoesParcelas()
321: 				THIS.ConfigurarCamposPercentuais()
322: 				THIS.ConfigurarCampoNovoGrupo()
323: 				THIS.ConfigurarCampoBusca()
324: 				THIS.ConfigurarDescritivoRodape()
325: 				THIS.ConfigurarImagemProduto()
326: 				THIS.ConfigurarBotoesPrincipais()
327: 
328: 				*-- Chamado uma unica vez, depois que TODOS os controles que
329: 				*-- dependem do modo (busca/descritivo/imagem) ja existem -
330: 				*-- CarregarDados() tambem chama de novo mais abaixo, idempotente.
331: 				THIS.AtualizarModoCriacao()
332: 
333: 				*-- Mestre-detalhe: a troca de linha na grade de itens refaz o
334: 				*-- filtro da grade de parcelas. O BINDEVENT vem DEPOIS das duas
335: 				*-- grades existirem, porque o handler mexe em grd_4c_Parcelas.
336: 				BINDEVENT(THIS.grd_4c_Itens, "AfterRowColChange", ;
337: 					THIS, "GradeItensAfterRowColChange")
338: 
339: 				*-- FUNIL de carga (cria/vincula cursores, posiciona e repinta).
340: 				*-- Nao condicionado a loc_lModoValidacaoOuTeste: os cursores sao
341: 				*-- locais (CREATE CURSOR), nao dependem de conexao SQL, e sem a
342: 				*-- chamada as grades abririam com cabecalho "Column<N>" e largura
343: 				*-- default tambem na validacao de UI. Ele ja aplica o layout do
344: 				*-- modo (AtualizarModoCriacao -> HabilitarCampos +
345: 				*-- AjustarBotoesPorModo) e traz os percentuais do cabecalho
346: 				*-- (BOParaForm).
347: 				THIS.CarregarDados()
348: 
349: 				loc_lSucesso = .T.
350: 			ENDIF
351: 		CATCH TO loc_oErro
352: 			MsgErro(loc_oErro.Message + CHR(13) + ;
353: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
354: 				"Procedure: " + loc_oErro.Procedure, ;
355: 				"Erro em Formsigoporc.InicializarForm")
356: 		ENDTRY
357: 
358: 		RETURN loc_lSucesso
359: 	ENDPROC
360: 
361: 	*==========================================================================
362: 	* ConfigurarCabecalho - Faixa cinza do topo (cntSombra do legado), com
363: 	* os dois labels sobrepostos (sombra + titulo) exibindo o Caption
364: 	* calculado em InicializarForm. Filho DIRETO do form (sem PageFrame),
365: 	* igual ao SCX legado.
366: 	*==========================================================================
367: 	PROTECTED PROCEDURE ConfigurarCabecalho()
368: 		LOCAL loc_oCnt
369: 
370: 		THIS.AddObject("cnt_4c_Sombra", "Container")
371: 		loc_oCnt = THIS.cnt_4c_Sombra
372: 		WITH loc_oCnt
373: 			.Top         = 0
374: 			.Left        = 0
375: 			.Width       = THIS.Width
376: 			.Height      = 80
377: 			.BorderWidth = 0
378: 			.BackColor   = RGB(100, 100, 100)
379: 			.Visible     = .T.
380: 		ENDWITH
381: 
382: 		loc_oCnt.AddObject("lbl_4c_Sombra", "Label")
383: 		WITH loc_oCnt.lbl_4c_Sombra
384: 			.FontBold      = .T.
385: 			.FontName      = "Tahoma"
386: 			.FontSize      = 18
387: 			.FontUnderline = .F.
388: 			.WordWrap      = .T.
389: 			.Alignment     = 0
390: 			.BackStyle     = 0
391: 			.AutoSize      = .F.
392: 			.Caption       = THIS.Caption
393: 			.Height        = 40
394: 			.Left          = 10
395: 			.Top           = 18
396: 			.Width         = 769
397: 			.ForeColor     = RGB(0, 0, 0)
398: 			.Visible       = .T.
399: 		ENDWITH
400: 
401: 		loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
402: 		WITH loc_oCnt.lbl_4c_Titulo
403: 			.FontBold  = .T.
404: 			.FontName  = "Tahoma"
405: 			.FontSize  = 18
406: 			.WordWrap  = .T.
407: 			.Alignment = 0

*-- Linhas 481 a 524:
481: 	* e explicito, nao silencioso: inventar uma origem para essa coluna
482: 	* seria inventar regra de negocio (regra #17).
483: 	*==========================================================================
484: 	PROTECTED PROCEDURE CriarCursorItens()
485: 		LOCAL loc_cCursor
486: 		loc_cCursor = THIS.this_oBusinessObject.this_cCursorItens
487: 
488: 		IF USED(loc_cCursor)
489: 			USE IN (loc_cCursor)
490: 		ENDIF
491: 
492: 		SET NULL ON
493: 		CREATE CURSOR (loc_cCursor) ;
494: 			(cidchaves C(20), cblocos C(30), citens N(10,0), citem2 N(10,0), ;
495: 			 citem3 N(10,0), citagrs N(10,0), cpros C(14), dpros C(65), ;
496: 			 dpro2s M, qtds N(8,4), cunis C(3), dcunis C(20), pesos N(8,4), ;
497: 			 cunips C(3), dcunips C(20), codacabs C(3), ;
498: 			 fators N(8,4), units N(13,2), totas N(13,2), tota1s N(13,2), ;
499: 			 tota2s N(13,2), tota3s N(13,2), tota4s N(13,2), tota5s N(13,2), ;
500: 			 tota6s N(13,2), obs M, tota7s N(13,2), tota8s N(13,2), ;
501: 			 tota9s N(13,2), tota10s N(13,2), notas C(9), perc1s N(8,4), ;
502: 			 perc2s N(8,4), perc3s N(8,4), perc4s N(8,4), perc5s N(8,4), ;
503: 			 perc6s N(8,4), servicos L, debitos L, taxas L, dacabs C(40), ;
504: 			 vlbaixas N(13,2), emps C(3), dopes C(20), numes N(6,0), ;
505: 			 empdopnums C(29), pkchaves C(20), moedas C(3), moefats C(3), ;
506: 			 moevs C(3), opers C(1), tpesos N(8,4), univals N(13,2), ;
507: 			 utilizas N(2,0))
508: 		SET NULL OFF
509: 
510: 		INDEX ON citens TAG citens
511: 	ENDPROC
512: 
513: 	*==========================================================================
514: 	* ConfigurarGridItens - grd_4c_Itens, equivalente ao SIGOPORC.grdItem
515: 	* (30 colunas). ControlSource/Width/ColumnOrder/Header1.Caption
516: 	* TRANSCRITOS do dump (PROPRIEDADES DE: SIGOPORC.grdItem e do Init -
517: 	* "With ThisForm.grdItem"). Column1 mostra Dpros (nao "Item" - o
518: 	* Header1.Caption do dump e literalmente esse, apesar do nome sugerir
519: 	* outra coisa) e Column2 mostra Dpro2s - conferido nas DUAS fontes do
520: 	* dump (PROPRIEDADES + Init) porque batiam.
521: 	*
522: 	* FICA PARA FASE POSTERIOR (depende de crSigCdOpe/SigCdEmp, carregados
523: 	* pelo BO em fase propria - ver cabecalho de sigoporcBO.prg):
524: 	*   - ReadOnly fixo (.T.) de Column13/Column14, mascaras de Column3/

*-- Linhas 531 a 574:
531: 	*     valor quando o BO passar a montar cursor_4c_Itens com os joins
532: 	*     de unidade/acabamento.
533: 	*==========================================================================
534: 	PROTECTED PROCEDURE ConfigurarGridItens()
535: 		LOCAL loc_lSoLeitura
536: 		loc_lSoLeitura = (THIS.this_cOpEscolha = "CONSULTAR")
537: 
538: 		THIS.AddObject("grd_4c_Itens", "Grid")
539: 
540: 		*-- ColumnCount FORA do WITH: as colunas ainda nao existem no momento
541: 		*-- da compilacao do WITH abaixo (regra CLAUDE.md sobre WITH + Grid -
542: 		*-- "Unknown member COLUMN1"). RecordSource/ControlSource/Width/
543: 		*-- Header1.Caption NAO ficam aqui: vao em VincularGradeItens().
544: 		THIS.grd_4c_Itens.ColumnCount  = 30
545: 
546: 		WITH THIS.grd_4c_Itens
547: 			.Top          = 218
548: 			.Left         = 5
549: 			.Width        = 989
550: 			.Height       = 258
551: 			.FontSize     = 8
552: 			.HeaderHeight = 16
553: 			.RowHeight    = 16
554: 			.ScrollBars   = 3
555: 			.DeleteMark   = .F.
556: 			.RecordMark   = .F.
557: 			.TabIndex     = 13
558: 
559: 			*-- Column1 (Item/Dpros - descritivo do produto). Celula com
560: 			*-- LOOKUP (legado grdItem.Column1.Text1.Valid -> SigCdPro), por
561: 			*-- isso recebe TextBox proprio via AddObject + CurrentControl +
562: 			*-- Sparse = .F. (regra #18: sem CurrentControl a coluna continua
563: 			*-- desenhando o Text1 nativo e o lookup nunca e alcancado; sem
564: 			*-- Sparse = .F. o controle so aparece na linha ativa).
565: 			*-- MaxLength vem da LARGURA da coluna no schema (SigMvOrc.dpros
566: 			*-- char(65)), nunca do Width em pixels (regra #19).
567: 			.Column1.ColumnOrder     = 1
568: 			.Column1.FontSize        = 8
569: 			.Column1.Header1.Alignment = 2
570: 			.Column1.Header1.FontSize  = 8
571: 			.Column1.AddObject("txt_4c_DescricaoItem", "TextBox")
572: 			.Column1.txt_4c_DescricaoItem.BorderStyle = 0
573: 			.Column1.txt_4c_DescricaoItem.Margin      = 0
574: 			.Column1.txt_4c_DescricaoItem.ForeColor   = RGB(0, 0, 0)

*-- Linhas 936 a 1068:
936: 			.Visible = .T.
937: 		ENDWITH
938: 
939: 		*-- Lookups de celula (produto + unidade de venda/pedido + acabamento) - BINDEVENT
940: 		*-- FORA do WITH acima: regra #46 (Valid de celula vai no TextBox da
941: 		*-- Column, nunca em AfterRowColChange) + regra #34 (Controls(N) por
942: 		*-- indice, nunca por nome - aqui o caminho e qualificado explicito,
943: 		*-- sem usar Controls()). GotFocus guarda o valor anterior em .Tag,
944: 		*-- substituindo o "this.Tag = this.Value" que o legado faz no When
945: 		*-- (When nao e um evento vinculavel por BINDEVENT com efeito colateral
946: 		*-- confiavel em VFP9).
947: 		BINDEVENT(THIS.grd_4c_Itens.Column1.txt_4c_DescricaoItem, "GotFocus", THIS, "GuardarAntDpros")
948: 		BINDEVENT(THIS.grd_4c_Itens.Column1.txt_4c_DescricaoItem, "KeyPress", THIS, "ValidarProdutoItemKeyPress")
949: 		BINDEVENT(THIS.grd_4c_Itens.Column4.txt_4c_UnidadeVenda, "GotFocus", THIS, "GuardarTagUnidadeVenda")
950: 		BINDEVENT(THIS.grd_4c_Itens.Column4.txt_4c_UnidadeVenda, "KeyPress", THIS, "ValidarUnidadeVendaKeyPress")
951: 		BINDEVENT(THIS.grd_4c_Itens.Column6.txt_4c_UnidadePedido, "GotFocus", THIS, "GuardarTagUnidadePedido")
952: 		BINDEVENT(THIS.grd_4c_Itens.Column6.txt_4c_UnidadePedido, "KeyPress", THIS, "ValidarUnidadePedidoKeyPress")
953: 		BINDEVENT(THIS.grd_4c_Itens.Column30.txt_4c_Acabamento, "GotFocus", THIS, "GuardarTagAcabamento")
954: 		BINDEVENT(THIS.grd_4c_Itens.Column30.txt_4c_Acabamento, "KeyPress", THIS, "ValidarAcabamentoKeyPress")
955: 	ENDPROC
956: 
957: 	*==========================================================================
958: 	* GuardarTagUnidadeVenda/Pedido/Acabamento - substituem o "this.Tag =
959: 	* this.Value" que o legado faz dentro do PROCEDURE When (disparado a
960: 	* cada entrada no campo). Guardam o valor com que o usuario ENTROU na
961: 	* celula, para o Valid poder comparar e pular o lookup quando o
962: 	* usuario so passou pela celula sem alterar (regra do legado: "If Padr
963: 	* (this.Value,20) = Padr(this.Tag,20) / Return .t.").
964: 	*==========================================================================
965: 	*==========================================================================
966: 	* GuardarAntDpros - equivalente ao "thisform.antdpros = this.Value" que o
967: 	* legado faz no When de grdItem.Column1.Text1. Guarda, na property
968: 	* this_cAntDpros (mapeada de antdpros), a descricao com que o usuario
969: 	* ENTROU na celula, para o Valid poder sair sem reconsultar quando o
970: 	* valor nao mudou ("If Padr(This.Value,40) = Padr(Thisform.antdpros,40)").
971: 	*==========================================================================
972: 	PROCEDURE GuardarAntDpros()
973: 		THIS.this_cAntDpros = TratarNulo(THIS.grd_4c_Itens.Column1.txt_4c_DescricaoItem.Value, "")
974: 	ENDPROC
975: 
976: 	PROCEDURE GuardarTagUnidadeVenda()
977: 		THIS.grd_4c_Itens.Column4.txt_4c_UnidadeVenda.Tag = THIS.grd_4c_Itens.Column4.txt_4c_UnidadeVenda.Value
978: 	ENDPROC
979: 
980: 	PROCEDURE GuardarTagUnidadePedido()
981: 		THIS.grd_4c_Itens.Column6.txt_4c_UnidadePedido.Tag = THIS.grd_4c_Itens.Column6.txt_4c_UnidadePedido.Value
982: 	ENDPROC
983: 
984: 	PROCEDURE GuardarTagAcabamento()
985: 		THIS.grd_4c_Itens.Column30.txt_4c_Acabamento.Tag = THIS.grd_4c_Itens.Column30.txt_4c_Acabamento.Value
986: 	ENDPROC
987: 
988: 	*==========================================================================
989: 	* ValidarUnidadeVendaKeyPress / ValidarUnidadePedidoKeyPress - legado
990: 	* SIGOPORC.grdItem.Column4/Column6.Text1.Valid. O usuario digita a
991: 	* DESCRICAO da unidade (DCunis/DCunips); o metodo resolve o CODIGO
992: 	* (Cunis/Cunips) por busca exata e, faltando, abre o picker (padrao
993: 	* local do projeto - FormBuscaAuxiliar + DefinirCursor sobre o cursor
994: 	* JA populado, igual a TxtNovoGrupoLostFocus - nao o fwBuscaInt do
995: 	* legado, que nao foi portado). Delegam para ValidarUnidadeGenerica,
996: 	* que e a MESMA logica para os dois campos (so trocam coluna de
997: 	* descricao/codigo no cursor de itens).
998: 	*==========================================================================
999: 	PROCEDURE ValidarUnidadeVendaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1000: 		LOCAL loc_oTxt
1001: 		IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
1002: 			RETURN
1003: 		ENDIF
1004: 		loc_oTxt = THIS.grd_4c_Itens.Column4.txt_4c_UnidadeVenda
1005: 		THIS.ValidarUnidadeGenerica(loc_oTxt, "dcunis", "cunis")
1006: 	ENDPROC
1007: 
1008: 	PROCEDURE ValidarUnidadePedidoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1009: 		LOCAL loc_oTxt
1010: 		IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
1011: 			RETURN
1012: 		ENDIF
1013: 		loc_oTxt = THIS.grd_4c_Itens.Column6.txt_4c_UnidadePedido
1014: 		THIS.ValidarUnidadeGenerica(loc_oTxt, "dcunips", "cunips")
1015: 	ENDPROC
1016: 
1017: 	*==========================================================================
1018: 	* ValidarUnidadeGenerica - corpo compartilhado por ValidarUnidadeVenda/
1019: 	* PedidoKeyPress. par_oTxt e o TextBox da celula (Column4/Column6);
1020: 	* par_cCampoDesc/par_cCampoCod sao as colunas do cursor_4c_Itens a
1021: 	* atualizar (dcunis/cunis ou dcunips/cunips).
1022: 	*
1023: 	* O valor digitado FICA no TextBox (par_oTxt.Value) - o cursor so
1024: 	* recebe DEPOIS, via REPLACE (regra #46). Se o valor nao mudou desde
1025: 	* que o usuario entrou na celula (guardado em .Tag por GotFocus), sai
1026: 	* sem reconsultar - igual ao legado.
1027: 	*==========================================================================
1028: 	PROTECTED PROCEDURE ValidarUnidadeGenerica(par_oTxt, par_cCampoDesc, par_cCampoCod)
1029: 		LOCAL loc_cItens, loc_cValor, loc_cSQL, loc_nResultado, loc_cDescEscolhida, loc_cCodEscolhido
1030: 
1031: 		IF PADR(ALLTRIM(par_oTxt.Value), 20) = PADR(ALLTRIM(TratarNulo(par_oTxt.Tag, "")), 20)
1032: 			RETURN
1033: 		ENDIF
1034: 
1035: 		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
1036: 		IF !USED(loc_cItens)
1037: 			RETURN
1038: 		ENDIF
1039: 
1040: 		loc_cValor = ALLTRIM(par_oTxt.Value)
1041: 
1042: 		IF EMPTY(loc_cValor)
1043: 			SELECT (loc_cItens)
1044: 			REPLACE (par_cCampoCod) WITH ""
1045: 			RETURN
1046: 		ENDIF
1047: 
1048: 		IF USED("cursor_4c_TmpUnidade")
1049: 			USE IN cursor_4c_TmpUnidade
1050: 		ENDIF
1051: 		loc_cSQL = "SELECT Dunis, Cunis FROM SigCdUni WHERE Dunis LIKE " + ;
1052: 			EscaparSQL("%" + loc_cValor + "%") + " ORDER BY Cunis"
1053: 		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpUnidade")
1054: 
1055: 		IF loc_nResultado < 0
1056: 			MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
1057: 				"Falha na Conex" + CHR(227) + "o (SigCdUni)")
1058: 			RETURN
1059: 		ENDIF
1060: 
1061: 		loc_cDescEscolhida = ""
1062: 		loc_cCodEscolhido  = ""
1063: 
1064: 		IF USED("cursor_4c_TmpUnidade") AND RECCOUNT("cursor_4c_TmpUnidade") > 0
1065: 			SELECT cursor_4c_TmpUnidade
1066: 			GO TOP
1067: 			LOCATE FOR Dunis = PADR(loc_cValor, 20)
1068: 

*-- Linhas 1103 a 1146:
1103: 	* o usuario digitou - so o CODIGO (codacabs) fica vazio, diferente do
1104: 	* legado (que limpa os dois, this.Value incluido).
1105: 	*==========================================================================
1106: 	PROCEDURE ValidarAcabamentoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1107: 		LOCAL loc_oTxt, loc_cItens, loc_cValor, loc_cSQL, loc_nResultado
1108: 		LOCAL loc_cDescEscolhida, loc_cCodEscolhido
1109: 
1110: 		IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
1111: 			RETURN
1112: 		ENDIF
1113: 
1114: 		loc_oTxt = THIS.grd_4c_Itens.Column30.txt_4c_Acabamento
1115: 
1116: 		IF ALLTRIM(loc_oTxt.Value) == ALLTRIM(TratarNulo(loc_oTxt.Tag, ""))
1117: 			RETURN
1118: 		ENDIF
1119: 
1120: 		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
1121: 		IF !USED(loc_cItens)
1122: 			RETURN
1123: 		ENDIF
1124: 
1125: 		loc_cValor = ALLTRIM(loc_oTxt.Value)
1126: 
1127: 		IF EMPTY(loc_cValor)
1128: 			SELECT (loc_cItens)
1129: 			REPLACE codacabs WITH ""
1130: 			RETURN
1131: 		ENDIF
1132: 
1133: 		IF USED("cursor_4c_TmpAcabamento")
1134: 			USE IN cursor_4c_TmpAcabamento
1135: 		ENDIF
1136: 		loc_cSQL = "SELECT Cods, Descrs FROM SigCdAca WHERE Descrs LIKE " + EscaparSQL("%" + loc_cValor + "%")
1137: 		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpAcabamento")
1138: 
1139: 		IF loc_nResultado < 0
1140: 			MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
1141: 				"Falha na Conex" + CHR(227) + "o (SigCdAca)")
1142: 			RETURN
1143: 		ENDIF
1144: 
1145: 		loc_cDescEscolhida = ""
1146: 		loc_cCodEscolhido  = ""

*-- Linhas 1153 a 1237:
1153: 			*-- Regra #50: universo vazio pode ser dado real (nenhum acabamento
1154: 			*-- com essa descricao) - avisar, mas NUNCA apagar o que o usuario
1155: 			*-- digitou (so o codigo, que de fato nao foi resolvido).
1156: 			MsgAviso("Acabamento n" + CHR(227) + "o encontrado.", "Aviso")
1157: 		ENDIF
1158: 
1159: 		IF USED("cursor_4c_TmpAcabamento")
1160: 			USE IN cursor_4c_TmpAcabamento
1161: 		ENDIF
1162: 
1163: 		SELECT (loc_cItens)
1164: 		IF !EMPTY(loc_cCodEscolhido)
1165: 			loc_oTxt.Value = loc_cDescEscolhida
1166: 			REPLACE dacabs WITH loc_cDescEscolhida, codacabs WITH loc_cCodEscolhido
1167: 		ELSE
1168: 			REPLACE codacabs WITH ""
1169: 		ENDIF
1170: 	ENDPROC
1171: 
1172: 	*==========================================================================
1173: 	* ValidarProdutoItemKeyPress - legado SIGOPORC.grdItem.Column1.Text1.
1174: 	* Valid (o trecho de LOOKUP; a precificacao automatica que vem depois
1175: 	* dele no dump depende de crSigCdOpe/crSigOpCdd, carregados em fase
1176: 	* propria do BO - ver cabecalho da classe).
1177: 	*
1178: 	* O usuario digita parte da DESCRICAO do produto (Dpros); o metodo
1179: 	* consulta SigCdPro com a restricao de SigCdRpo (Dopps = Dopes do
1180: 	* cabecalho) - quando a restricao existe, o legado faz INNER JOIN; sem
1181: 	* restricao, consulta SigCdPro direto. Resolve por busca exata e, se
1182: 	* nao casar, abre o picker.
1183: 	*
1184: 	* Guardas TRANSCRITAS do legado (regra #21b - a condicao que cerca a
1185: 	* validacao FAZ PARTE dela):
1186: 	*   - valor nao mudou desde a entrada na celula (this_cAntDpros,
1187: 	*     comparado com PADR(...,40) igual ao legado) -> sai sem consultar
1188: 	*   - linha de SUBTOTAL (citens = citem2) ou de marcador de nivel
1189: 	*     (citens = citem3) -> o legado NAO faz lookup: nessas linhas a
1190: 	*     descricao digitada e so o rotulo do bloco, propagado para o
1191: 	*     dpro2s das linhas de SUBTOTAL do mesmo agrupamento
1192: 	*
1193: 	* O valor digitado esta em .Value (o cursor so recebe DEPOIS, via
1194: 	* REPLACE - regra #46), e a descricao escolhida volta para .Value alem
1195: 	* do REPLACE, senao o texto digitado sobrescreveria o cursor.
1196: 	*==========================================================================
1197: 	PROCEDURE ValidarProdutoItemKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1198: 		LOCAL loc_oTxt, loc_cItens, loc_cValor, loc_cSQL, loc_nResultado
1199: 		LOCAL loc_cCodEscolhido, loc_cDescEscolhida, loc_cDescritivo
1200: 		LOCAL loc_cCunis, loc_cCunips, loc_lRestrito
1201: 		LOCAL loc_nItens, loc_nItem2, loc_nItem3
1202: 
1203: 		IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
1204: 			RETURN
1205: 		ENDIF
1206: 
1207: 		loc_oTxt   = THIS.grd_4c_Itens.Column1.txt_4c_DescricaoItem
1208: 		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
1209: 
1210: 		IF !USED(loc_cItens) OR EOF(loc_cItens)
1211: 			RETURN
1212: 		ENDIF
1213: 
1214: 		loc_cValor = ALLTRIM(TratarNulo(loc_oTxt.Value, ""))
1215: 
1216: 		SELECT (loc_cItens)
1217: 		loc_nItens = citens
1218: 		loc_nItem2 = citem2
1219: 		loc_nItem3 = citem3
1220: 
1221: 		*-- Linha de SUBTOTAL / marcador de nivel: sem lookup. O legado
1222: 		*-- propaga o rotulo digitado para o dpro2s das linhas de SUBTOTAL
1223: 		*-- do mesmo agrupamento e volta ao item corrente por SEEK no TAG
1224: 		*-- citens.
1225: 		IF loc_nItens = loc_nItem2 OR loc_nItens = loc_nItem3
1226: 			IF loc_nItens = loc_nItem2 AND loc_nItens = loc_nItem3
1227: 				REPLACE dpro2s WITH loc_cValor ;
1228: 					FOR citem3 = loc_nItens AND citem2 = citens AND cblocos = "SUBTOTAL" ;
1229: 					IN (loc_cItens)
1230: 			ELSE
1231: 				REPLACE dpro2s WITH loc_cValor ;
1232: 					FOR citem2 = loc_nItem2 AND cblocos = "SUBTOTAL" ;
1233: 					IN (loc_cItens)
1234: 			ENDIF
1235: 			SELECT (loc_cItens)
1236: 			=SEEK(loc_nItens, loc_cItens, "citens")
1237: 			THIS.this_cAntDpros = loc_cValor

*-- Linhas 1348 a 1577:
1348: 
1349: 	*==========================================================================
1350: 	* AbrirBuscaProdutoItem - picker do lookup de produto da celula
1351: 	* grd_4c_Itens.Column1 (legado: CreateObject([fwBuscaInt], [crTmpPro],
1352: 	* [Dpros], lcDPro, [Item], .t.) + os tres mAddColuna de DPros/CPros/
1353: 	* Dpro2s). Trabalha sobre cursor_4c_BuscaProduto, que o chamador JA
1354: 	* populou - mesmo contrato do fwBuscaInt legado, que recebe um cursor
1355: 	* local ja consultado.
1356: 	*
1357: 	* Devolve o par escolhido em this_cLookupCodigo/this_cLookupDescricao
1358: 	* (vazios quando o usuario cancelou - equivale ao "Lastkey() = 27" do
1359: 	* legado). Guarda de reentrancia porque o picker e MODAL (regra #37).
1360: 	*==========================================================================
1361: 	PROCEDURE AbrirBuscaProdutoItem()
1362: 		LOCAL loc_oBusca, loc_oErro
1363: 
1364: 		THIS.this_cLookupCodigo    = ""
1365: 		THIS.this_cLookupDescricao = ""
1366: 
1367: 		IF THIS.this_lEmLookupProduto OR !USED("cursor_4c_BuscaProduto")
1368: 			RETURN
1369: 		ENDIF
1370: 		THIS.this_lEmLookupProduto = .T.
1371: 
1372: 		TRY
1373: 			loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1374: 			loc_oBusca.DefinirCursor("cursor_4c_BuscaProduto", "Cpros", "Dpros", "Item")
1375: 			loc_oBusca.this_aColunas[1, 3] = "C" + CHR(243) + "digo"
1376: 			loc_oBusca.this_aColunas[2, 3] = "Descri" + CHR(231) + CHR(227) + "o"
1377: 			loc_oBusca.mAddColuna("Dpro2s", "", "Descritivo")
1378: 
1379: 			IF loc_oBusca.Mostrar()
1380: 				THIS.this_cLookupCodigo    = loc_oBusca.cCodigoSelecionado
1381: 				THIS.this_cLookupDescricao = loc_oBusca.cDescricaoSelecionada
1382: 			ENDIF
1383: 
1384: 			loc_oBusca.Release()
1385: 		CATCH TO loc_oErro
1386: 			MsgErro(loc_oErro.Message + CHR(13) + ;
1387: 				"Linha: " + TRANSFORM(loc_oErro.LineNo), ;
1388: 				"Erro em Formsigoporc.AbrirBuscaProdutoItem")
1389: 		ENDTRY
1390: 
1391: 		THIS.this_lEmLookupProduto = .F.
1392: 	ENDPROC
1393: 
1394: 	*==========================================================================
1395: 	* AbrirBuscaUnidade - picker do lookup de unidade das celulas
1396: 	* grd_4c_Itens.Column4/Column6 (legado: CreateObject([fwBuscaInt],
1397: 	* [crTmpUni], [Dunis], lcDuni, [Unidade], .t.) + mAddColuna de DUnis e
1398: 	* CUnis). Trabalha sobre cursor_4c_TmpUnidade, que
1399: 	* ValidarUnidadeGenerica JA populou com SigCdUni.
1400: 	*
1401: 	* Devolve o par em this_cLookupCodigo/this_cLookupDescricao (vazios no
1402: 	* cancelamento). Guarda de reentrancia: o picker e MODAL (regra #37).
1403: 	*==========================================================================
1404: 	PROCEDURE AbrirBuscaUnidade()
1405: 		LOCAL loc_oBusca, loc_oErro
1406: 
1407: 		THIS.this_cLookupCodigo    = ""
1408: 		THIS.this_cLookupDescricao = ""
1409: 
1410: 		IF THIS.this_lEmLookupUnidade OR !USED("cursor_4c_TmpUnidade")
1411: 			RETURN
1412: 		ENDIF
1413: 		THIS.this_lEmLookupUnidade = .T.
1414: 
1415: 		TRY
1416: 			loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1417: 			loc_oBusca.DefinirCursor("cursor_4c_TmpUnidade", "Cunis", "Dunis", "Unidade")
1418: 			loc_oBusca.this_aColunas[1, 3] = "C" + CHR(243) + "digo"
1419: 			loc_oBusca.this_aColunas[2, 3] = "Descri" + CHR(231) + CHR(227) + "o"
1420: 
1421: 			IF loc_oBusca.Mostrar()
1422: 				THIS.this_cLookupCodigo    = loc_oBusca.cCodigoSelecionado
1423: 				THIS.this_cLookupDescricao = loc_oBusca.cDescricaoSelecionada
1424: 			ENDIF
1425: 
1426: 			loc_oBusca.Release()
1427: 		CATCH TO loc_oErro
1428: 			MsgErro(loc_oErro.Message + CHR(13) + ;
1429: 				"Linha: " + TRANSFORM(loc_oErro.LineNo), ;
1430: 				"Erro em Formsigoporc.AbrirBuscaUnidade")
1431: 		ENDTRY
1432: 
1433: 		THIS.this_lEmLookupUnidade = .F.
1434: 	ENDPROC
1435: 
1436: 	*==========================================================================
1437: 	* AbrirBuscaAcabamento - picker do lookup de acabamento da celula
1438: 	* grd_4c_Itens.Column30 (legado: CreateObject([fwBuscaInt], [TmpCdAca],
1439: 	* [Descrs], Alltrim(this.Value), [Acabamento], .t.) + mAddColuna de
1440: 	* Descrs). Trabalha sobre cursor_4c_TmpAcabamento, que
1441: 	* ValidarAcabamentoKeyPress JA populou com SigCdAca.
1442: 	*
1443: 	* O legado declara apenas a coluna Descrs no picker; aqui o par
1444: 	* codigo/descricao e necessario porque e Cods que vai para codacabs -
1445: 	* a coluna de codigo entra junto (DefinirCursor exige as duas) e a
1446: 	* descricao continua sendo a chave visivel da escolha.
1447: 	*==========================================================================
1448: 	PROCEDURE AbrirBuscaAcabamento()
1449: 		LOCAL loc_oBusca, loc_oErro
1450: 
1451: 		THIS.this_cLookupCodigo    = ""
1452: 		THIS.this_cLookupDescricao = ""
1453: 
1454: 		IF THIS.this_lEmLookupAcabamento OR !USED("cursor_4c_TmpAcabamento")
1455: 			RETURN
1456: 		ENDIF
1457: 		THIS.this_lEmLookupAcabamento = .T.
1458: 
1459: 		TRY
1460: 			loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1461: 			loc_oBusca.DefinirCursor("cursor_4c_TmpAcabamento", "Cods", "Descrs", "Acabamento")
1462: 			loc_oBusca.this_aColunas[1, 3] = "C" + CHR(243) + "digo"
1463: 			loc_oBusca.this_aColunas[2, 3] = "Descri" + CHR(231) + CHR(227) + "o"
1464: 
1465: 			IF loc_oBusca.Mostrar()
1466: 				THIS.this_cLookupCodigo    = loc_oBusca.cCodigoSelecionado
1467: 				THIS.this_cLookupDescricao = loc_oBusca.cDescricaoSelecionada
1468: 			ENDIF
1469: 
1470: 			loc_oBusca.Release()
1471: 		CATCH TO loc_oErro
1472: 			MsgErro(loc_oErro.Message + CHR(13) + ;
1473: 				"Linha: " + TRANSFORM(loc_oErro.LineNo), ;
1474: 				"Erro em Formsigoporc.AbrirBuscaAcabamento")
1475: 		ENDTRY
1476: 
1477: 		THIS.this_lEmLookupAcabamento = .F.
1478: 	ENDPROC
1479: 
1480: 	*==========================================================================
1481: 	* AbrirBuscaNovoGrupo - picker do lookup de Grupo de Produto do campo
1482: 	* txt_4c_NovoGrupo (legado get_NewGrp.Valid: CreateObject([fwBuscaInt],
1483: 	* [TmpCdGpr], [Cgrus], This.Value, [Grupos], .t.) + mAddColuna de
1484: 	* CGrus e DGrus). Trabalha sobre cursor_4c_BuscaGrupo, que
1485: 	* TxtNovoGrupoLostFocus JA populou - com a restricao de SigCdRpo e, se
1486: 	* ela nao devolver nada, com a lista inteira de SigCdGrp (fallback
1487: 	* transcrito do legado).
1488: 	*
1489: 	* A guarda de reentrancia desta familia (this_lEmLookupGrupo) e ligada
1490: 	* pelo CHAMADOR: este metodo nao a liga de novo, senao devolveria sem
1491: 	* abrir nada (regra #47 - o funil liga a flag UMA vez).
1492: 	*==========================================================================
1493: 	PROCEDURE AbrirBuscaNovoGrupo()
1494: 		LOCAL loc_oBusca, loc_oErro
1495: 
1496: 		THIS.this_cLookupCodigo    = ""
1497: 		THIS.this_cLookupDescricao = ""
1498: 
1499: 		IF !USED("cursor_4c_BuscaGrupo")
1500: 			RETURN
1501: 		ENDIF
1502: 
1503: 		TRY
1504: 			loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1505: 			loc_oBusca.DefinirCursor("cursor_4c_BuscaGrupo", "Cgrus", "DGrus", ;
1506: 				"Grupo Para Cadastro de Produtos")
1507: 			loc_oBusca.this_aColunas[1, 3] = "Grupo"
1508: 			loc_oBusca.this_aColunas[2, 3] = "Descri" + CHR(231) + CHR(227) + "o"
1509: 
1510: 			IF loc_oBusca.Mostrar()
1511: 				THIS.this_cLookupCodigo    = loc_oBusca.cCodigoSelecionado
1512: 				THIS.this_cLookupDescricao = loc_oBusca.cDescricaoSelecionada
1513: 			ENDIF
1514: 
1515: 			loc_oBusca.Release()
1516: 		CATCH TO loc_oErro
1517: 			MsgErro(loc_oErro.Message + CHR(13) + ;
1518: 				"Linha: " + TRANSFORM(loc_oErro.LineNo), ;
1519: 				"Erro em Formsigoporc.AbrirBuscaNovoGrupo")
1520: 		ENDTRY
1521: 	ENDPROC
1522: 
1523: 	*==========================================================================
1524: 	* VincularGradeItens - Liga grd_4c_Itens ao cursor de itens. SEPARADO de
1525: 	* ConfigurarGridItens de proposito: atribuir RecordSource RESETA
1526: 	* Column.Width e Column.Header1.Caption (regra #41 / Problema 48), entao
1527: 	* os dois tem de ser reaplicados DEPOIS de cada bind - e o bind acontece
1528: 	* mais de uma vez (toda vez que o cursor de itens e recriado pelo funil
1529: 	* CarregarDados). Ordem canonica: RecordSource -> ControlSource ->
1530: 	* Width -> Header1.Caption.
1531: 	*
1532: 	* O bind e CONDICIONADO a USED(cursor): instanciado sem cursor (harness de
1533: 	* teste), atribuir RecordSource estouraria "Alias is not found". Width e
1534: 	* Header1.Caption sao aplicados SEMPRE, com ou sem alias aberto - senao a
1535: 	* grade apareceria com cabecalho "Column1" e largura default.
1536: 	*==========================================================================
1537: 	PROTECTED PROCEDURE VincularGradeItens()
1538: 		LOCAL loc_cCursor
1539: 		loc_cCursor = THIS.this_oBusinessObject.this_cCursorItens
1540: 
1541: 		WITH THIS.grd_4c_Itens
1542: 			IF USED(loc_cCursor)
1543: 				.RecordSource = loc_cCursor
1544: 
1545: 				.Column1.ControlSource = loc_cCursor + ".dpros"
1546: 				.Column2.ControlSource = loc_cCursor + ".dpro2s"
1547: 				.Column3.ControlSource = loc_cCursor + ".qtds"
1548: 				.Column4.ControlSource = loc_cCursor + ".dcunis"
1549: 				.Column5.ControlSource = loc_cCursor + ".pesos"
1550: 				.Column6.ControlSource = loc_cCursor + ".dcunips"
1551: 				.Column7.ControlSource = loc_cCursor + ".fators"
1552: 				.Column8.ControlSource = loc_cCursor + ".units"
1553: 				.Column9.ControlSource = loc_cCursor + ".totas"
1554: 				.Column10.ControlSource = loc_cCursor + ".tota1s"
1555: 				.Column11.ControlSource = loc_cCursor + ".tota2s"
1556: 				.Column12.ControlSource = loc_cCursor + ".tota3s"
1557: 				.Column13.ControlSource = loc_cCursor + ".tota4s"
1558: 				.Column14.ControlSource = loc_cCursor + ".tota5s"
1559: 				.Column15.ControlSource = loc_cCursor + ".tota6s"
1560: 				.Column16.ControlSource = loc_cCursor + ".obs"
1561: 				.Column17.ControlSource = loc_cCursor + ".tota7s"
1562: 				.Column18.ControlSource = loc_cCursor + ".tota8s"
1563: 				.Column19.ControlSource = loc_cCursor + ".tota9s"
1564: 				.Column20.ControlSource = loc_cCursor + ".tota10s"
1565: 				.Column21.ControlSource = loc_cCursor + ".notas"
1566: 				.Column22.ControlSource = loc_cCursor + ".perc4s"
1567: 				.Column23.ControlSource = loc_cCursor + ".perc5s"
1568: 				.Column24.ControlSource = loc_cCursor + ".perc6s"
1569: 				.Column25.ControlSource = loc_cCursor + ".perc2s"
1570: 				.Column26.ControlSource = loc_cCursor + ".perc3s"
1571: 				.Column27.ControlSource = loc_cCursor + ".servicos"
1572: 				.Column28.ControlSource = loc_cCursor + ".debitos"
1573: 				.Column29.ControlSource = loc_cCursor + ".taxas"
1574: 				.Column30.ControlSource = loc_cCursor + ".dacabs"
1575: 			ENDIF
1576: 
1577: 			*-- Width/Header1.Caption SEMPRE depois do bind (RecordSource reseta

*-- Linhas 1662 a 1822:
1662: 	* COLUNA vem DEPOIS do ReadOnly do GRID, senao o do grid sobrescreve
1663: 	* (regra #46).
1664: 	*==========================================================================
1665: 	PROTECTED PROCEDURE ReinstalarCelulasLookupItens()
1666: 		LOCAL loc_lSoLeitura
1667: 		loc_lSoLeitura = (THIS.this_cOpEscolha = "CONSULTAR")
1668: 
1669: 		WITH THIS.grd_4c_Itens
1670: 			IF !PEMSTATUS(.Column1, "txt_4c_DescricaoItem", 5)
1671: 				.Column1.AddObject("txt_4c_DescricaoItem", "TextBox")
1672: 				.Column1.txt_4c_DescricaoItem.BorderStyle = 0
1673: 				.Column1.txt_4c_DescricaoItem.Margin      = 0
1674: 				.Column1.txt_4c_DescricaoItem.ForeColor   = RGB(0, 0, 0)
1675: 				.Column1.txt_4c_DescricaoItem.BackColor   = RGB(255, 255, 255)
1676: 				.Column1.txt_4c_DescricaoItem.MaxLength   = 65
1677: 				BINDEVENT(.Column1.txt_4c_DescricaoItem, "GotFocus", THIS, "GuardarAntDpros")
1678: 				BINDEVENT(.Column1.txt_4c_DescricaoItem, "KeyPress", THIS, "ValidarProdutoItemKeyPress")
1679: 			ENDIF
1680: 			.Column1.CurrentControl = "txt_4c_DescricaoItem"
1681: 			.Column1.Sparse         = .F.
1682: 			.Column1.ReadOnly       = loc_lSoLeitura
1683: 
1684: 			IF !PEMSTATUS(.Column4, "txt_4c_UnidadeVenda", 5)
1685: 				.Column4.AddObject("txt_4c_UnidadeVenda", "TextBox")
1686: 				.Column4.txt_4c_UnidadeVenda.BorderStyle = 0
1687: 				.Column4.txt_4c_UnidadeVenda.Margin      = 0
1688: 				.Column4.txt_4c_UnidadeVenda.ForeColor   = RGB(0, 0, 0)
1689: 				.Column4.txt_4c_UnidadeVenda.BackColor   = RGB(255, 255, 255)
1690: 				.Column4.txt_4c_UnidadeVenda.MaxLength   = 20
1691: 				BINDEVENT(.Column4.txt_4c_UnidadeVenda, "GotFocus", THIS, "GuardarTagUnidadeVenda")
1692: 				BINDEVENT(.Column4.txt_4c_UnidadeVenda, "KeyPress", THIS, "ValidarUnidadeVendaKeyPress")
1693: 			ENDIF
1694: 			.Column4.CurrentControl = "txt_4c_UnidadeVenda"
1695: 			.Column4.Sparse         = .F.
1696: 			.Column4.ReadOnly       = loc_lSoLeitura
1697: 
1698: 			IF !PEMSTATUS(.Column6, "txt_4c_UnidadePedido", 5)
1699: 				.Column6.AddObject("txt_4c_UnidadePedido", "TextBox")
1700: 				.Column6.txt_4c_UnidadePedido.BorderStyle = 0
1701: 				.Column6.txt_4c_UnidadePedido.Margin      = 0
1702: 				.Column6.txt_4c_UnidadePedido.ForeColor   = RGB(0, 0, 0)
1703: 				.Column6.txt_4c_UnidadePedido.BackColor   = RGB(255, 255, 255)
1704: 				.Column6.txt_4c_UnidadePedido.MaxLength   = 20
1705: 				BINDEVENT(.Column6.txt_4c_UnidadePedido, "GotFocus", THIS, "GuardarTagUnidadePedido")
1706: 				BINDEVENT(.Column6.txt_4c_UnidadePedido, "KeyPress", THIS, "ValidarUnidadePedidoKeyPress")
1707: 			ENDIF
1708: 			.Column6.CurrentControl = "txt_4c_UnidadePedido"
1709: 			.Column6.Sparse         = .F.
1710: 			.Column6.ReadOnly       = loc_lSoLeitura
1711: 
1712: 			IF !PEMSTATUS(.Column30, "txt_4c_Acabamento", 5)
1713: 				.Column30.AddObject("txt_4c_Acabamento", "TextBox")
1714: 				.Column30.txt_4c_Acabamento.BorderStyle = 0
1715: 				.Column30.txt_4c_Acabamento.Margin      = 0
1716: 				.Column30.txt_4c_Acabamento.ForeColor   = RGB(0, 0, 0)
1717: 				.Column30.txt_4c_Acabamento.BackColor   = RGB(255, 255, 255)
1718: 				.Column30.txt_4c_Acabamento.MaxLength   = 20
1719: 				BINDEVENT(.Column30.txt_4c_Acabamento, "GotFocus", THIS, "GuardarTagAcabamento")
1720: 				BINDEVENT(.Column30.txt_4c_Acabamento, "KeyPress", THIS, "ValidarAcabamentoKeyPress")
1721: 			ENDIF
1722: 			.Column30.CurrentControl = "txt_4c_Acabamento"
1723: 			.Column30.Sparse         = .F.
1724: 			.Column30.ReadOnly       = loc_lSoLeitura
1725: 		ENDWITH
1726: 	ENDPROC
1727: 
1728: 	*==========================================================================
1729: 	* CriarCursorParcelas - Cursor da grade de parcelas/previsoes de pagamento
1730: 	* (grd_4c_Parcelas), equivalente ao crSigMvOrp que o legado compartilha
1731: 	* com o form pai via troca de DataSession. Colunas conferidas em
1732: 	* docs\schema.sql (tabela SigMvOrp): cidchaves/citens/datas/dopes/
1733: 	* empdopnums/emps/numes/percs/valos/vlbaixas/borderos/ifors/valcreds.
1734: 	*
1735: 	* dfors NAO e coluna de SigMvOrp - e PROJECAO: o legado liga
1736: 	* grdParcela.Column6 a crSigMvOrp.Dfors, que e a razao social do
1737: 	* fornecedor (SigCdCli.RClis) trazida pelo join em Ifors. Fica vazia
1738: 	* ate a fase do BO que monta a consulta com o join.
1739: 	*
1740: 	* A ORDEM DOS CAMPOS deste CREATE CURSOR e a unica do form (regra
1741: 	* OPERACIONAL #2): qualquer outro ponto que venha a recriar o cursor
1742: 	* tem de chamar ESTE metodo, nunca repetir o CREATE CURSOR.
1743: 	*==========================================================================
1744: 	PROTECTED PROCEDURE CriarCursorParcelas()
1745: 		LOCAL loc_cCursor
1746: 		loc_cCursor = THIS.this_oBusinessObject.this_cCursorParcelas
1747: 
1748: 		IF USED(loc_cCursor)
1749: 			USE IN (loc_cCursor)
1750: 		ENDIF
1751: 
1752: 		SET NULL ON
1753: 		CREATE CURSOR (loc_cCursor) ;
1754: 			(cidchaves C(20), citens N(10,0), datas D, dopes C(29), ;
1755: 			 empdopnums C(29), emps C(3), numes N(6,0), percs N(5,2), ;
1756: 			 valos N(13,2), vlbaixas N(12,2), borderos N(10,0), ;
1757: 			 ifors C(10), valcreds N(13,2), dfors C(50))
1758: 		SET NULL OFF
1759: 
1760: 		*-- Legado (fim do Init): Select crSigMvOrp / Set Order to / Set Order
1761: 		*-- to CItens - a grade de parcelas e sempre vista pela ordem do item,
1762: 		*-- porque e por essa chave que PosicionarParcelasDoItem filtra.
1763: 		INDEX ON citens TAG citens
1764: 	ENDPROC
1765: 
1766: 	*==========================================================================
1767: 	* ConfigurarGradeParcelas - grd_4c_Parcelas, equivalente ao
1768: 	* SIGOPORC.grdParcela (7 colunas). Geometria/fonte/cor/ColumnOrder
1769: 	* TRANSCRITOS do dump ("PROPRIEDADES DE: SIGOPORC.grdParcela").
1770: 	*
1771: 	* Igual a grade de itens, aqui fica SO o que nao depende de dado;
1772: 	* RecordSource/ControlSource/Width/Header1.Caption vao em
1773: 	* VincularGradeParcelas().
1774: 	*
1775: 	* ReadOnly por coluna transcrito do Init legado ("With ThisForm.grdParcela"):
1776: 	* Column4 (Fornecedor), Column6 (Descricao) e Column7 (Credito) sao
1777: 	* ReadOnly = .T. SEMPRE - sao projecao/valor calculado, nao entrada; as
1778: 	* demais seguem o modo (CONSULTAR = somente leitura). O ReadOnly da
1779: 	* COLUNA vem DEPOIS do ReadOnly do GRID, senao o do grid sobrescreve
1780: 	* (regra #46).
1781: 	*==========================================================================
1782: 	PROTECTED PROCEDURE ConfigurarGradeParcelas()
1783: 		LOCAL loc_lSoLeitura
1784: 		loc_lSoLeitura = (THIS.this_cOpEscolha = "CONSULTAR")
1785: 
1786: 		THIS.AddObject("grd_4c_Parcelas", "Grid")
1787: 
1788: 		*-- ColumnCount FORA do WITH (as Columns ainda nao existem dentro dele)
1789: 		THIS.grd_4c_Parcelas.ColumnCount = 7
1790: 
1791: 		WITH THIS.grd_4c_Parcelas
1792: 			.Top          = 504
1793: 			.Left         = 6
1794: 			.Width        = 946
1795: 			.Height       = 92
1796: 			.FontName     = "Tahoma"
1797: 			.FontSize     = 8
1798: 			.ForeColor    = RGB(90, 90, 90)
1799: 			.HeaderHeight = 16
1800: 			.RowHeight    = 16
1801: 			.Panel        = 1
1802: 			.ScrollBars   = 3
1803: 			.DeleteMark   = .F.
1804: 			.RecordMark   = .F.
1805: 			.TabIndex     = 25
1806: 			.ReadOnly     = loc_lSoLeitura
1807: 
1808: 			*-- Column1 (% - percs)
1809: 			.Column1.ColumnOrder       = 3
1810: 			.Column1.FontName          = "Tahoma"
1811: 			.Column1.FontSize          = 8
1812: 			.Column1.ForeColor         = RGB(90, 90, 90)
1813: 			.Column1.Header1.Alignment = 2
1814: 			.Column1.Header1.FontSize  = 8
1815: 			.Column1.ReadOnly          = loc_lSoLeitura
1816: 
1817: 			*-- Column2 (Data - datas)
1818: 			.Column2.ColumnOrder       = 4
1819: 			.Column2.FontName          = "Tahoma"
1820: 			.Column2.FontSize          = 8
1821: 			.Column2.ForeColor         = RGB(90, 90, 90)
1822: 			.Column2.Header1.Alignment = 2

*-- Linhas 1871 a 2145:
1871: 			.Visible = .T.
1872: 		ENDWITH
1873: 	ENDPROC
1874: 
1875: 	*==========================================================================
1876: 	* VincularGradeParcelas - Liga grd_4c_Parcelas ao cursor de parcelas.
1877: 	* Mesmo motivo da separacao em VincularGradeItens: RecordSource reseta
1878: 	* Width/Header1.Caption, entao os dois vem DEPOIS do bind e sao
1879: 	* aplicados SEMPRE, com ou sem alias aberto. Bind condicionado a
1880: 	* USED(cursor) para nao estourar "Alias is not found" no harness.
1881: 	* ControlSource transcrito do Init legado ("With ThisForm.grdParcela").
1882: 	*==========================================================================
1883: 	PROTECTED PROCEDURE VincularGradeParcelas()
1884: 		LOCAL loc_cCursor
1885: 		loc_cCursor = THIS.this_oBusinessObject.this_cCursorParcelas
1886: 
1887: 		WITH THIS.grd_4c_Parcelas
1888: 			IF USED(loc_cCursor)
1889: 				.RecordSource = loc_cCursor
1890: 
1891: 				.Column1.ControlSource = loc_cCursor + ".percs"
1892: 				.Column2.ControlSource = loc_cCursor + ".datas"
1893: 				.Column3.ControlSource = loc_cCursor + ".valos"
1894: 				.Column4.ControlSource = loc_cCursor + ".ifors"
1895: 				.Column5.ControlSource = loc_cCursor + ".vlbaixas"
1896: 				.Column6.ControlSource = loc_cCursor + ".dfors"
1897: 				.Column7.ControlSource = loc_cCursor + ".valcreds"
1898: 			ENDIF
1899: 
1900: 			*-- Width/Header1.Caption SEMPRE depois do bind. Transcritos do
1901: 			*-- dump (PROPRIEDADES DE: SIGOPORC.grdParcela + o Header1 de cada
1902: 			*-- Column no layout do legado).
1903: 			.Column1.Width           = 70
1904: 			.Column1.Header1.Caption = "%"
1905: 			.Column2.Width           = 70
1906: 			.Column2.Header1.Caption = "Data"
1907: 			.Column3.Width           = 122
1908: 			.Column3.Header1.Caption = "Previsto"
1909: 			.Column4.Width           = 80
1910: 			.Column4.Header1.Caption = "Fornecedor"
1911: 			.Column5.Width           = 122
1912: 			.Column5.Header1.Caption = "Realizado"
1913: 			.Column6.Width           = 290
1914: 			.Column6.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1915: 			.Column7.Width           = 122
1916: 			.Column7.Header1.Caption = "Cr" + CHR(233) + "dito"
1917: 		ENDWITH
1918: 	ENDPROC
1919: 
1920: 	*==========================================================================
1921: 	* ConfigurarBotoesParcelas - btnIncluirp/btnExcluirp do legado (fwbtnp,
1922: 	* standalone, SOMENTE ICONE - Caption = "" no dump). Top/Left/Picture/
1923: 	* ToolTipText TRANSCRITOS do dump; fwbtnp mede 40x40 (medido no VFP9 e
1924: 	* ja registrado em FormSigOpLoc.prg), o que confere com o espacamento
1925: 	* de 40px entre os dois (Top 516 e 556).
1926: 	*
1927: 	* Botao SO-ICONE nunca recebe .Enabled = .F.: com Caption vazio o VFP9
1928: 	* deixa de desenhar o Picture e o botao vira um retangulo vazio (regra
1929: 	* do CorretorAutomatico #106). O "When" do legado
1930: 	* (Inlist(Op_Escolha,[INSERIR],[ALTERAR])) virou guarda no inicio do
1931: 	* proprio handler - BINDEVENT descarta o retorno do delegate, entao um
1932: 	* When ligado por BINDEVENT nao bloquearia nada.
1933: 	*==========================================================================
1934: 	PROTECTED PROCEDURE ConfigurarBotoesParcelas()
1935: 		THIS.AddObject("cmd_4c_IncluirParcela", "CommandButton")
1936: 		WITH THIS.cmd_4c_IncluirParcela
1937: 			.Top             = 516
1938: 			.Left            = 954
1939: 			.Height          = 40
1940: 			.Width           = 40
1941: 			.Caption         = ""
1942: 			.ToolTipText     = "Inserir linha"
1943: 			.ForeColor       = RGB(90, 90, 90)
1944: 			.BackColor       = RGB(255, 255, 255)
1945: 			.Themes          = .T.
1946: 			.Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
1947: 			.DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
1948: 			.TabIndex        = 26
1949: 			.Visible         = .T.
1950: 		ENDWITH
1951: 		BINDEVENT(THIS.cmd_4c_IncluirParcela, "Click", THIS, "BtnIncluirParcelaClick")
1952: 
1953: 		THIS.AddObject("cmd_4c_ExcluirParcela", "CommandButton")
1954: 		WITH THIS.cmd_4c_ExcluirParcela
1955: 			.Top             = 556
1956: 			.Left            = 954
1957: 			.Height          = 40
1958: 			.Width           = 40
1959: 			.Caption         = ""
1960: 			.ToolTipText     = "Exclui linha"
1961: 			.ForeColor       = RGB(90, 90, 90)
1962: 			.BackColor       = RGB(255, 255, 255)
1963: 			.Themes          = .T.
1964: 			.Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1965: 			.DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1966: 			.TabIndex        = 28
1967: 			.Visible         = .T.
1968: 		ENDWITH
1969: 		BINDEVENT(THIS.cmd_4c_ExcluirParcela, "Click", THIS, "BtnExcluirParcelaClick")
1970: 	ENDPROC
1971: 
1972: 	*==========================================================================
1973: 	* BtnIncluirParcelaClick - legado SIGOPORC.btnIncluirp.Click. Insere uma
1974: 	* parcela/previsao em branco para o ITEM CORRENTE da grade de itens.
1975: 	*
1976: 	* As tres condicoes do legado sao regra de negocio e vao transcritas
1977: 	* juntas (regra #21b): a parcela so existe para item NORMAL - nao para
1978: 	* linha de subtotal (Citens = Citem2), nao para item sem produto
1979: 	* (Empty(Cpros)) e nao para linha de marcador (cBlocos IN SUBTOTAL/
1980: 	* BRANCO/SUBTOTAIS/TAXA/TOTAL/IMPOSTO/TOTALGERAL).
1981: 	*
1982: 	* Emps/Dopes/Numes vem das properties do form (equivalentes a
1983: 	* TprMvCab.Emps/Dopes/Numes do legado, que chegavam pela DataSession
1984: 	* compartilhada). Igual ao legado, a persistencia em SigMvOrp acontece
1985: 	* so na confirmacao do dialogo - aqui so o cursor e alterado.
1986: 	*==========================================================================
1987: 	PROCEDURE BtnIncluirParcelaClick()
1988: 		LOCAL loc_cItens, loc_cParcelas, loc_nItem, loc_lPodeIncluir
1989: 
1990: 		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
1991: 			RETURN
1992: 		ENDIF
1993: 
1994: 		loc_cItens    = THIS.this_oBusinessObject.this_cCursorItens
1995: 		loc_cParcelas = THIS.this_oBusinessObject.this_cCursorParcelas
1996: 
1997: 		IF !USED(loc_cItens) OR !USED(loc_cParcelas) OR EOF(loc_cItens)
1998: 			RETURN
1999: 		ENDIF
2000: 
2001: 		THIS.LockScreen = .T.
2002: 
2003: 		SELECT (loc_cItens)
2004: 		loc_lPodeIncluir = (citens <> citem2) AND !EMPTY(cpros) AND ;
2005: 			!INLIST(ALLTRIM(cblocos), "SUBTOTAL", "BRANCO", "SUBTOTAIS", ;
2006: 				"TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL")
2007: 		loc_nItem = citens
2008: 
2009: 		IF loc_lPodeIncluir
2010: 			INSERT INTO (loc_cParcelas) ;
2011: 				(emps, dopes, numes, citens, datas, valos, vlbaixas) ;
2012: 				VALUES (THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes, ;
2013: 					loc_nItem, CTOD(""), 0, 0)
2014: 
2015: 			SELECT (loc_cParcelas)
2016: 			GO BOTTOM
2017: 		ENDIF
2018: 
2019: 		THIS.grd_4c_Parcelas.Refresh()
2020: 		THIS.LockScreen = .F.
2021: 
2022: 		*-- Legado: thisform.grdParcela.column4.SetFocus()
2023: 		THIS.grd_4c_Parcelas.Column4.SetFocus()
2024: 	ENDPROC
2025: 
2026: 	*==========================================================================
2027: 	* BtnExcluirParcelaClick - legado SIGOPORC.btnExcluirp.Click. Exclui a
2028: 	* parcela corrente, recusando a exclusao quando ela JA FOI BAIXADA
2029: 	* (VlBaixas preenchido) - a regra e a mensagem sao do legado.
2030: 	*
2031: 	* O legado usa "Return .f." dentro do IF; aqui a estrutura e IF/ELSE,
2032: 	* que produz o mesmo efeito sem RETURN no meio do metodo.
2033: 	*==========================================================================
2034: 	PROCEDURE BtnExcluirParcelaClick()
2035: 		LOCAL loc_cParcelas
2036: 
2037: 		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
2038: 			RETURN
2039: 		ENDIF
2040: 
2041: 		loc_cParcelas = THIS.this_oBusinessObject.this_cCursorParcelas
2042: 
2043: 		IF !USED(loc_cParcelas)
2044: 			RETURN
2045: 		ENDIF
2046: 
2047: 		SELECT (loc_cParcelas)
2048: 
2049: 		IF !EMPTY(vlbaixas)
2050: 			*-- Legado: "A parcela ja joi autorizada!" - o "joi" e erro de
2051: 			*-- digitacao do original, visivel ao usuario; aqui sai "foi",
2052: 			*-- sem mudar o sentido da mensagem.
2053: 			MsgAviso("A parcela j" + CHR(225) + " foi autorizada!", ;
2054: 				"Imposs" + CHR(237) + "vel excluir")
2055: 		ELSE
2056: 			THIS.LockScreen = .T.
2057: 
2058: 			IF !EOF(loc_cParcelas)
2059: 				DELETE
2060: 				GO TOP
2061: 			ENDIF
2062: 
2063: 			THIS.grd_4c_Parcelas.Refresh()
2064: 			THIS.LockScreen = .F.
2065: 
2066: 			*-- Legado: thisform.grdParcela.column1.SetFocus()
2067: 			THIS.grd_4c_Parcelas.Column1.SetFocus()
2068: 		ENDIF
2069: 	ENDPROC
2070: 
2071: 	*==========================================================================
2072: 	* ConfigurarCamposPercentuais - Shape4 (moldura decorativa) + os 6
2073: 	* campos de percentual do cabecalho (say5/getPmargem .. Say6/
2074: 	* getPservico do legado). TRANSCRITOS do dump (bloco "PROPRIEDADES
2075: 	* DE: SIGOPORC.<nome>"), pareados por proximidade de Top (label.Top =
2076: 	* textbox.Top + 3, conferido um a um):
2077: 	*
2078: 	*   Say5 "Margem :...%"            (96)  <-> getPmargem      (93)  - SEM ControlSource; When sempre .F. (resultado calculado por TotalizarItn, nunca digitado)
2079: 	*   say4 "Contingente :...%"       (116) <-> getPtax2        (113) - ControlSource = TprMvCab.ptax2s (Perc1s)
2080: 	*   say1 "Ta\<xa Adm. :...%"       (136) <-> getPtaxa        (133) - ControlSource = TprMvCab.descs  (Perc2s)
2081: 	*   Say3 "BV :...%"                (156) <-> getPTax1        (153) - ControlSource = TprMvCab.ptax1s (Perc3s)
2082: 	*   say2 "Im\<posto :...%"         (176) <-> getPimposto     (173) - ControlSource = TprMvCab.acres  (Perc4s, item nao-servico)
2083: 	*   Say6 "Imposto sem ISS :...%"   (196) <-> getPservico     (193) - ControlSource = TprMvCab.ptax3s (Perc4s, item servico)
2084: 	*
2085: 	* Nenhum dos 5 TextBoxes editaveis usa ControlSource aqui: TprMvCab e
2086: 	* cursor do FORM PAI no legado (nao existe neste dialogo), e os 5
2087: 	* valores correspondentes (this_nPTax2s/this_nDescs/this_nPTax1s/
2088: 	* this_nAcres/this_nPTax3s) sao escalares do BO, repassados uma unica
2089: 	* vez na abertura (nao mudam por item) - a sincronizacao e manual
2090: 	* (.Value lido/escrito direto), igual ao padrao ja usado para
2091: 	* this_cEmps/this_cDopes/etc.
2092: 	*
2093: 	* SIMPLIFICACAO DOCUMENTADA: o legado guarda This.PEAntValue (property
2094: 	* da classe fwget) e so executa a cascata de Replace quando
2095: 	* "this.Value <> this.peantvalue" (evita reprocessar se o usuario so
2096: 	* passou pelo campo sem alterar). Como a cascata e IDEMPOTENTE (mesmo
2097: 	* valor de entrada sempre produz o mesmo resultado), replicar esse
2098: 	* guard exigiria 5 handlers de GotFocus extras so para guardar o
2099: 	* valor anterior em .Tag - trocado aqui por executar a cascata sempre
2100: 	* que o valor NAO esta vazio, no Enter/Tab (regra "BINDEVENT Valid nao
2101: 	* funciona em TextBox - usar KeyPress ENTER/TAB"). Resultado final
2102: 	* identico; custo e, no maximo, um SCAN redundante quando o usuario
2103: 	* nao mudou o valor.
2104: 	*==========================================================================
2105: 	PROTECTED PROCEDURE ConfigurarCamposPercentuais()
2106: 		LOCAL loc_lPodeEditar
2107: 		loc_lPodeEditar = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
2108: 
2109: 		THIS.AddObject("shp_4c_Painel", "Shape")
2110: 		WITH THIS.shp_4c_Painel
2111: 			.Top          = 106
2112: 			.Left         = 577
2113: 			.Height       = 93
2114: 			.Width        = 163
2115: 			.BackStyle    = 0
2116: 			.BorderWidth  = 2
2117: 			.SpecialEffect = 0
2118: 			.BorderColor  = RGB(90, 90, 90)
2119: 			.Visible      = .T.
2120: 		ENDWITH
2121: 
2122: 		*-- Margem (resultado calculado - sempre desabilitado, destaque amarelo)
2123: 		THIS.AddObject("lbl_4c_Margem", "Label")
2124: 		WITH THIS.lbl_4c_Margem
2125: 			.FontName  = "Tahoma"
2126: 			.FontSize  = 8
2127: 			.Alignment = 1
2128: 			.AutoSize  = .F.
2129: 			.Caption   = "Margem :                     %"
2130: 			.Top       = 96
2131: 			.Left      = 261
2132: 			.Width     = 192
2133: 			.Height    = 15
2134: 			.ForeColor = RGB(90, 90, 90)
2135: 			.Visible   = .T.
2136: 		ENDWITH
2137: 
2138: 		THIS.AddObject("txt_4c_Margem", "TextBox")
2139: 		WITH THIS.txt_4c_Margem
2140: 			.Top           = 93
2141: 			.Left          = 380
2142: 			.Width         = 59
2143: 			.Height        = 21
2144: 			.Alignment     = 3
2145: 			.FontBold      = .T.

*-- Linhas 2189 a 2589:
2189: 			.Enabled       = loc_lPodeEditar
2190: 			.Visible       = .T.
2191: 		ENDWITH
2192: 		BINDEVENT(THIS.txt_4c_Contingente, "KeyPress", THIS, "TxtContingenteKeyPress")
2193: 
2194: 		*-- Taxa Adm. (Perc2s - TprMvCab.Descs)
2195: 		THIS.AddObject("lbl_4c_TaxaAdm", "Label")
2196: 		WITH THIS.lbl_4c_TaxaAdm
2197: 			.FontName  = "Tahoma"
2198: 			.FontSize  = 8
2199: 			.Alignment = 1
2200: 			.AutoSize  = .F.
2201: 			.Caption   = "Ta\<xa Adm. :                     %"
2202: 			.Top       = 136
2203: 			.Left      = 261
2204: 			.Width     = 192
2205: 			.Height    = 15
2206: 			.ForeColor = RGB(90, 90, 90)
2207: 			.Visible   = .T.
2208: 		ENDWITH
2209: 
2210: 		THIS.AddObject("txt_4c_TaxaAdm", "TextBox")
2211: 		WITH THIS.txt_4c_TaxaAdm
2212: 			.Top           = 133
2213: 			.Left          = 380
2214: 			.Width         = 59
2215: 			.Height        = 21
2216: 			.Alignment     = 3
2217: 			.Format        = "K"
2218: 			.InputMask     = "999.99"
2219: 			.Margin        = 0
2220: 			.SpecialEffect = 1
2221: 			.ForeColor     = RGB(0, 0, 0)
2222: 			.BorderColor   = RGB(100, 100, 100)
2223: 			.Value         = THIS.this_oBusinessObject.this_nDescs
2224: 			.Enabled       = loc_lPodeEditar
2225: 			.Visible       = .T.
2226: 		ENDWITH
2227: 		BINDEVENT(THIS.txt_4c_TaxaAdm, "KeyPress", THIS, "TxtTaxaAdmKeyPress")
2228: 
2229: 		*-- BV (Perc3s - TprMvCab.Ptax1s)
2230: 		THIS.AddObject("lbl_4c_BV", "Label")
2231: 		WITH THIS.lbl_4c_BV
2232: 			.FontName  = "Tahoma"
2233: 			.FontSize  = 8
2234: 			.Alignment = 1
2235: 			.AutoSize  = .F.
2236: 			.Caption   = "BV :                     %"
2237: 			.Top       = 156
2238: 			.Left      = 261
2239: 			.Width     = 192
2240: 			.Height    = 15
2241: 			.ForeColor = RGB(90, 90, 90)
2242: 			.Visible   = .T.
2243: 		ENDWITH
2244: 
2245: 		THIS.AddObject("txt_4c_BV", "TextBox")
2246: 		WITH THIS.txt_4c_BV
2247: 			.Top           = 153
2248: 			.Left          = 380
2249: 			.Width         = 59
2250: 			.Height        = 21
2251: 			.Alignment     = 3
2252: 			.Format        = "K"
2253: 			.InputMask     = "999.99"
2254: 			.Margin        = 0
2255: 			.SpecialEffect = 1
2256: 			.ForeColor     = RGB(0, 0, 0)
2257: 			.BorderColor   = RGB(100, 100, 100)
2258: 			.Value         = THIS.this_oBusinessObject.this_nPTax1s
2259: 			.Enabled       = loc_lPodeEditar
2260: 			.Visible       = .T.
2261: 		ENDWITH
2262: 		BINDEVENT(THIS.txt_4c_BV, "KeyPress", THIS, "TxtBVKeyPress")
2263: 
2264: 		*-- Imposto cheio (Perc4s quando item NAO e servico - TprMvCab.Acres)
2265: 		THIS.AddObject("lbl_4c_Imposto", "Label")
2266: 		WITH THIS.lbl_4c_Imposto
2267: 			.FontName  = "Tahoma"
2268: 			.FontSize  = 8
2269: 			.Alignment = 1
2270: 			.AutoSize  = .F.
2271: 			.Caption   = "Im\<posto :                     %"
2272: 			.Top       = 176
2273: 			.Left      = 261
2274: 			.Width     = 192
2275: 			.Height    = 15
2276: 			.ForeColor = RGB(90, 90, 90)
2277: 			.Visible   = .T.
2278: 		ENDWITH
2279: 
2280: 		THIS.AddObject("txt_4c_Imposto", "TextBox")
2281: 		WITH THIS.txt_4c_Imposto
2282: 			.Top           = 173
2283: 			.Left          = 380
2284: 			.Width         = 59
2285: 			.Height        = 21
2286: 			.Alignment     = 3
2287: 			.Format        = "K"
2288: 			.InputMask     = "999.99"
2289: 			.Margin        = 0
2290: 			.SpecialEffect = 1
2291: 			.ForeColor     = RGB(0, 0, 0)
2292: 			.BorderColor   = RGB(100, 100, 100)
2293: 			.Value         = THIS.this_oBusinessObject.this_nAcres
2294: 			.Enabled       = loc_lPodeEditar
2295: 			.Visible       = .T.
2296: 		ENDWITH
2297: 		BINDEVENT(THIS.txt_4c_Imposto, "KeyPress", THIS, "TxtImpostoKeyPress")
2298: 
2299: 		*-- Imposto sem ISS (Perc4s quando item E servico - TprMvCab.Ptax3s)
2300: 		THIS.AddObject("lbl_4c_ImpostoServico", "Label")
2301: 		WITH THIS.lbl_4c_ImpostoServico
2302: 			.FontName  = "Tahoma"
2303: 			.FontSize  = 8
2304: 			.Alignment = 1
2305: 			.AutoSize  = .F.
2306: 			.Caption   = "Imposto sem ISS :                     %"
2307: 			.Top       = 196
2308: 			.Left      = 260
2309: 			.Width     = 192
2310: 			.Height    = 15
2311: 			.ForeColor = RGB(90, 90, 90)
2312: 			.Visible   = .T.
2313: 		ENDWITH
2314: 
2315: 		THIS.AddObject("txt_4c_ImpostoServico", "TextBox")
2316: 		WITH THIS.txt_4c_ImpostoServico
2317: 			.Top           = 193
2318: 			.Left          = 380
2319: 			.Width         = 59
2320: 			.Height        = 21
2321: 			.Alignment     = 3
2322: 			.Format        = "K"
2323: 			.InputMask     = "999.9999"
2324: 			.Margin        = 0
2325: 			.SpecialEffect = 1
2326: 			.ForeColor     = RGB(0, 0, 0)
2327: 			.BorderColor   = RGB(100, 100, 100)
2328: 			.Value         = THIS.this_oBusinessObject.this_nPTax3s
2329: 			.Enabled       = loc_lPodeEditar
2330: 			.Visible       = .T.
2331: 		ENDWITH
2332: 		BINDEVENT(THIS.txt_4c_ImpostoServico, "KeyPress", THIS, "TxtImpostoServicoKeyPress")
2333: 	ENDPROC
2334: 
2335: 	*==========================================================================
2336: 	* TxtContingenteKeyPress - legado SIGOPORC.getPtax2.Valid. Perc1s
2337: 	* ("Contingente") - aplicado em TODOS os itens quando P&G.
2338: 	*==========================================================================
2339: 	PROCEDURE TxtContingenteKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2340: 		LOCAL loc_cItens, loc_nItens, loc_nValor
2341: 
2342: 		IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
2343: 			RETURN
2344: 		ENDIF
2345: 		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
2346: 			RETURN
2347: 		ENDIF
2348: 		IF EMPTY(THIS.txt_4c_Contingente.Value)
2349: 			RETURN
2350: 		ENDIF
2351: 
2352: 		loc_nValor = THIS.txt_4c_Contingente.Value
2353: 		THIS.this_oBusinessObject.this_nPTax2s = loc_nValor
2354: 
2355: 		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
2356: 		IF USED(loc_cItens) AND THIS.this_oBusinessObject.this_nDivNotas = 2
2357: 			SELECT (loc_cItens)
2358: 			loc_nItens = citens
2359: 			SCAN
2360: 				REPLACE perc1s WITH loc_nValor, ;
2361: 					tota1s WITH (totas * loc_nValor) / 100, ;
2362: 					tota2s WITH ((totas + tota1s) * perc2s) / 100, ;
2363: 					tota3s WITH ((totas + tota1s + tota2s) * perc3s) / 100, ;
2364: 					tota4s WITH IIF(perc4s = 0, 0, ((totas + tota1s + tota2s + tota3s) / (1 - perc4s / 100)) - (totas + tota1s + tota2s + tota3s)), ;
2365: 					tota5s WITH totas + tota1s + tota2s + tota3s + tota4s
2366: 			ENDSCAN
2367: 			= SEEK(loc_nItens, loc_cItens, "citens")
2368: 		ENDIF
2369: 
2370: 		THIS.TotalizarItn()
2371: 	ENDPROC
2372: 
2373: 	*==========================================================================
2374: 	* TxtTaxaAdmKeyPress - legado SIGOPORC.getPtaxa.Valid. Perc2s
2375: 	* ("Taxa Adm./Lucro") quando P&G; quando SRCOM, aplica Perc1s/Perc2s/
2376: 	* Perc3s so na linha de bloco TAXA (fee da produtora).
2377: 	*==========================================================================
2378: 	PROCEDURE TxtTaxaAdmKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2379: 		LOCAL loc_cItens, loc_nItens, loc_nValor
2380: 
2381: 		IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
2382: 			RETURN
2383: 		ENDIF
2384: 		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
2385: 			RETURN
2386: 		ENDIF
2387: 		IF EMPTY(THIS.txt_4c_TaxaAdm.Value)
2388: 			RETURN
2389: 		ENDIF
2390: 
2391: 		loc_nValor = THIS.txt_4c_TaxaAdm.Value
2392: 		THIS.this_oBusinessObject.this_nDescs = loc_nValor
2393: 
2394: 		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
2395: 		IF USED(loc_cItens)
2396: 			SELECT (loc_cItens)
2397: 			loc_nItens = citens
2398: 
2399: 			IF THIS.this_oBusinessObject.this_nDivNotas = 2
2400: 				SCAN
2401: 					REPLACE perc2s WITH loc_nValor, ;
2402: 						tota2s WITH ((totas + tota1s) * loc_nValor) / 100, ;
2403: 						tota3s WITH ((totas + tota1s + tota2s) * perc3s) / 100, ;
2404: 						tota4s WITH IIF(perc4s = 0, 0, ((totas + tota1s + tota2s + tota3s) / (1 - perc4s / 100)) - (totas + tota1s + tota2s + tota3s)), ;
2405: 						tota5s WITH totas + tota1s + tota2s + tota3s + tota4s
2406: 				ENDSCAN
2407: 			ELSE
2408: 				GO TOP
2409: 				LOCATE FOR ALLTRIM(cblocos) == "TAXA"
2410: 				IF FOUND()
2411: 					REPLACE perc1s WITH loc_nValor, perc2s WITH loc_nValor, perc3s WITH loc_nValor
2412: 				ENDIF
2413: 			ENDIF
2414: 
2415: 			= SEEK(loc_nItens, loc_cItens, "citens")
2416: 		ENDIF
2417: 
2418: 		THIS.TotalizarItn()
2419: 	ENDPROC
2420: 
2421: 	*==========================================================================
2422: 	* TxtBVKeyPress - legado SIGOPORC.getPTax1.Valid. Perc3s ("BV") -
2423: 	* aplicado em TODOS os itens quando P&G.
2424: 	*==========================================================================
2425: 	PROCEDURE TxtBVKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2426: 		LOCAL loc_cItens, loc_nItens, loc_nValor
2427: 
2428: 		IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
2429: 			RETURN
2430: 		ENDIF
2431: 		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
2432: 			RETURN
2433: 		ENDIF
2434: 		IF EMPTY(THIS.txt_4c_BV.Value)
2435: 			RETURN
2436: 		ENDIF
2437: 
2438: 		loc_nValor = THIS.txt_4c_BV.Value
2439: 		THIS.this_oBusinessObject.this_nPTax1s = loc_nValor
2440: 
2441: 		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
2442: 		IF USED(loc_cItens) AND THIS.this_oBusinessObject.this_nDivNotas = 2
2443: 			SELECT (loc_cItens)
2444: 			loc_nItens = citens
2445: 			SCAN
2446: 				REPLACE perc3s WITH loc_nValor, ;
2447: 					tota3s WITH ((totas + tota1s + tota2s) * loc_nValor) / 100, ;
2448: 					tota4s WITH IIF(perc4s = 0, 0, ((totas + tota1s + tota2s + tota3s) / (1 - perc4s / 100)) - (totas + tota1s + tota2s + tota3s)), ;
2449: 					tota5s WITH totas + tota1s + tota2s + tota3s + tota4s
2450: 			ENDSCAN
2451: 			= SEEK(loc_nItens, loc_cItens, "citens")
2452: 		ENDIF
2453: 
2454: 		THIS.TotalizarItn()
2455: 	ENDPROC
2456: 
2457: 	*==========================================================================
2458: 	* TxtImpostoKeyPress - legado SIGOPORC.getPimposto.Valid. Perc4s
2459: 	* (imposto cheio) - aplicado em TODOS os itens quando P&G.
2460: 	*==========================================================================
2461: 	PROCEDURE TxtImpostoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2462: 		LOCAL loc_cItens, loc_nItens, loc_nValor
2463: 
2464: 		IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
2465: 			RETURN
2466: 		ENDIF
2467: 		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
2468: 			RETURN
2469: 		ENDIF
2470: 		IF EMPTY(THIS.txt_4c_Imposto.Value)
2471: 			RETURN
2472: 		ENDIF
2473: 
2474: 		loc_nValor = THIS.txt_4c_Imposto.Value
2475: 		THIS.this_oBusinessObject.this_nAcres = loc_nValor
2476: 
2477: 		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
2478: 		IF USED(loc_cItens) AND THIS.this_oBusinessObject.this_nDivNotas = 2
2479: 			SELECT (loc_cItens)
2480: 			loc_nItens = citens
2481: 			SCAN
2482: 				REPLACE perc4s WITH loc_nValor, ;
2483: 					tota4s WITH IIF(perc4s = 0, 0, ((totas + tota1s + tota2s + tota3s) / (1 - perc4s / 100)) - (totas + tota1s + tota2s + tota3s)), ;
2484: 					tota5s WITH totas + tota1s + tota2s + tota3s + tota4s
2485: 			ENDSCAN
2486: 			= SEEK(loc_nItens, loc_cItens, "citens")
2487: 		ENDIF
2488: 
2489: 		THIS.TotalizarItn()
2490: 	ENDPROC
2491: 
2492: 	*==========================================================================
2493: 	* TxtImpostoServicoKeyPress - legado SIGOPORC.getPservico.Valid.
2494: 	* Perc4s (imposto, variante "sem ISS") - aplicado SO nos itens
2495: 	* marcados como Servicos, quando P&G.
2496: 	*==========================================================================
2497: 	PROCEDURE TxtImpostoServicoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2498: 		LOCAL loc_cItens, loc_nItens, loc_nValor
2499: 
2500: 		IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
2501: 			RETURN
2502: 		ENDIF
2503: 		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
2504: 			RETURN
2505: 		ENDIF
2506: 		IF EMPTY(THIS.txt_4c_ImpostoServico.Value)
2507: 			RETURN
2508: 		ENDIF
2509: 
2510: 		loc_nValor = THIS.txt_4c_ImpostoServico.Value
2511: 		THIS.this_oBusinessObject.this_nPTax3s = loc_nValor
2512: 
2513: 		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
2514: 		IF USED(loc_cItens) AND THIS.this_oBusinessObject.this_nDivNotas = 2
2515: 			SELECT (loc_cItens)
2516: 			loc_nItens = citens
2517: 			SCAN FOR servicos
2518: 				REPLACE perc4s WITH loc_nValor, ;
2519: 					tota4s WITH IIF(perc4s = 0, 0, ((totas + tota1s + tota2s + tota3s) / (1 - perc4s / 100)) - (totas + tota1s + tota2s + tota3s)), ;
2520: 					tota5s WITH totas + tota1s + tota2s + tota3s + tota4s
2521: 			ENDSCAN
2522: 			= SEEK(loc_nItens, loc_cItens, "citens")
2523: 		ENDIF
2524: 
2525: 		THIS.TotalizarItn()
2526: 	ENDPROC
2527: 
2528: 	*==========================================================================
2529: 	* TotalizarItn - legado SIGOPORC.TotalizarItn. Motor de calculo
2530: 	* chamado por calc_valite (fase posterior) e pelos 5 campos de
2531: 	* percentual (acima). TRANSCRITO LITERALMENTE do dump
2532: 	* (PROCEDURE totalizaritn): consolida Tota1s..Tota10s do item
2533: 	* corrente (P&G ou SRCOM), depois os subtotais por bloco (Citem2),
2534: 	* sub-bloco (Citem3) e total geral (TOTALGERAL/Decupagem), e por fim
2535: 	* propaga o resultado para as parcelas do item (crSigMvOrp/
2536: 	* cursor_4c_Parcelas) via Valos.
2537: 	*
2538: 	* As linhas marcadoras (SUBTOTAL/SUBTOTAIS/TAXA/TOTAL/IMPOSTO/
2539: 	* TOTALGERAL) ainda nao sao criadas nesta fase (btnInsBlo/btnInsSub -
2540: 	* Fase 6): os LOCATE que as procuram nao encontram nada e os blocos
2541: 	* protegidos por "IF !EOF()"/"IF FOUND()" (que e exatamente como o
2542: 	* legado guarda esses trechos) ficam no-op em silencio, sem erro -
2543: 	* comportamento seguro e idempotente ate essas linhas existirem.
2544: 	*
2545: 	* perc1s..perc6s sao campos de TRABALHO do cursor (nao existem na
2546: 	* tabela SigMvOrc - ver comentario de CriarCursorItens); so
2547: 	* Tota1s..Tota10s sao persistidos pelo BO.
2548: 	*==========================================================================
2549: 	PROTECTED PROCEDURE TotalizarItn()
2550: 		LOCAL loc_cItens, loc_cParcelas, loc_nItens, loc_nItem2, loc_nItem3, loc_nItAgr, loc_nTaxa1, loc_nTaxa2, loc_nTaxa3, loc_nImpo1, loc_nImpo2, loc_nImpo3, loc_nSubtot
2551: 
2552: 		loc_cItens    = THIS.this_oBusinessObject.this_cCursorItens
2553: 		loc_cParcelas = THIS.this_oBusinessObject.this_cCursorParcelas
2554: 
2555: 		IF !USED(loc_cItens) OR EOF(loc_cItens)
2556: 			RETURN
2557: 		ENDIF
2558: 
2559: 		THIS.LockScreen = .T.
2560: 
2561: 		SELECT (loc_cItens)
2562: 		loc_nItens = citens
2563: 		loc_nItem2 = citem2
2564: 		loc_nItem3 = citem3
2565: 		loc_nItAgr = citagrs
2566: 
2567: 		IF THIS.this_oBusinessObject.this_nDivNotas = 2
2568: 			*-- P&G
2569: 			REPLACE tota1s WITH IIF(perc1s = 0, tota1s, (totas * perc1s) / 100), ;
2570: 				tota2s WITH IIF(perc2s = 0, tota2s, ((totas + tota1s) * perc2s) / 100), ;
2571: 				tota3s WITH IIF(perc3s = 0, tota3s, ((totas + tota1s + tota2s) * perc3s) / 100)
2572: 			REPLACE tota4s WITH IIF(perc4s = 0, 0, ((totas + tota1s + tota2s + tota3s) / (1 - perc4s / 100)) - (totas + tota1s + tota2s + tota3s))
2573: 			REPLACE tota5s WITH totas + tota1s + tota2s + tota3s + tota4s
2574: 		ELSE
2575: 			*-- SRCOM: total dos valores de NF SRCOM e fornecedor
2576: 			IF EMPTY(perc2s) AND EMPTY(perc3s)
2577: 				REPLACE tota1s WITH totas, tota2s WITH 0, tota3s WITH 0
2578: 			ELSE
2579: 				REPLACE tota1s WITH 0, tota2s WITH (perc2s * totas) / 100, tota3s WITH (perc3s * totas) / 100
2580: 			ENDIF
2581: 
2582: 			*-- Incentivos conforme o percentual informado
2583: 			REPLACE tota4s WITH (totas * perc4s) / 100, tota5s WITH (totas * perc5s) / 100, tota6s WITH (totas * perc6s) / 100
2584: 			*-- Saldo real SRCOM custos internos / fornecedor
2585: 			REPLACE tota9s WITH IIF(!EMPTY(tota1s), tota1s - tota8s, tota2s) - tota7s, ;
2586: 				tota10s WITH IIF(!EMPTY(tota1s), 0, tota3s - tota8s)
2587: 
2588: 			IF INT(VAL(SUBSTR(THIS.this_oBusinessObject.this_cConfigGers, 192, 1))) = 1
2589: 				*-- Decupagem

*-- Linhas 2750 a 2854:
2750: 	* nao existe em SigCdPro. Geometria/MaxLength/ToolTipText TRANSCRITOS
2751: 	* do dump.
2752: 	*==========================================================================
2753: 	PROTECTED PROCEDURE ConfigurarCampoNovoGrupo()
2754: 		LOCAL loc_lPodeEditar
2755: 		loc_lPodeEditar = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
2756: 
2757: 		THIS.AddObject("lbl_4c_NovoGrupo", "Label")
2758: 		WITH THIS.lbl_4c_NovoGrupo
2759: 			.FontName  = "Tahoma"
2760: 			.FontSize  = 8
2761: 			.Caption   = "\<Grupo"
2762: 			.Top       = 129
2763: 			.Left      = 499
2764: 			.Width     = 31
2765: 			.Height    = 15
2766: 			.ForeColor = RGB(90, 90, 90)
2767: 			.Visible   = .T.
2768: 		ENDWITH
2769: 
2770: 		THIS.AddObject("txt_4c_NovoGrupo", "TextBox")
2771: 		WITH THIS.txt_4c_NovoGrupo
2772: 			.Top           = 144
2773: 			.Left          = 495
2774: 			.Width         = 37
2775: 			.Height        = 23
2776: 			.FontBold      = .T.
2777: 			.MaxLength     = 3
2778: 			.SpecialEffect = 1
2779: 			.ToolTipText   = "Grupo Para Cadastro de Produtos"
2780: 			.ForeColor     = RGB(0, 0, 0)
2781: 			.BackColor     = RGB(255, 255, 232)
2782: 			.BorderColor   = RGB(100, 100, 100)
2783: 			.Value         = ""
2784: 			.Enabled       = loc_lPodeEditar
2785: 			.Visible       = .T.
2786: 		ENDWITH
2787: 		BINDEVENT(THIS.txt_4c_NovoGrupo, "LostFocus", THIS, "TxtNovoGrupoLostFocus")
2788: 	ENDPROC
2789: 
2790: 	*==========================================================================
2791: 	* TxtNovoGrupoLostFocus - legado SIGOPORC.get_NewGrp.Valid (+LostFocus,
2792: 	* que so move o foco - THIS.btnCadPro.SetFocus(), inalcancavel nesta
2793: 	* fase porque btnCadPro e Fase 6; por isso nao chamado aqui). Lookup
2794: 	* de Grupo de Produto, restrito por SigCdRpo (Dopps = Dopes do
2795: 	* cabecalho); se a restricao nao devolve nada, o legado cai para a
2796: 	* lista INTEIRA de SigCdGrp - transcrito literalmente.
2797: 	*
2798: 	* Regras #36/#37/#47: lookup em LostFocus (nao KeyPress), guarda de
2799: 	* reentrancia (o picker e modal), this_lAchouRegistro/Mostrar() ANTES
2800: 	* de decidir mostrar o dialogo, e NUNCA MsgAviso + apagar o digitado
2801: 	* quando a busca exata falha - so abre o picker (regra #50).
2802: 	*==========================================================================
2803: 	PROCEDURE TxtNovoGrupoLostFocus()
2804: 		LOCAL loc_cSQL, loc_nResultado, loc_cValorDigitado, loc_oErro
2805: 
2806: 		IF THIS.this_lEmLookupGrupo
2807: 			RETURN
2808: 		ENDIF
2809: 
2810: 		*-- LostFocus dispara SEMPRE (o Valid do legado so dispara quando o
2811: 		*-- valor MUDA) - sem esta guarda, so passar pelo campo sem digitar
2812: 		*-- nada reconsulta o SQL (ou reabre o picker) a cada perda de foco.
2813: 		loc_cValorDigitado = ALLTRIM(THIS.txt_4c_NovoGrupo.Value)
2814: 		IF loc_cValorDigitado == THIS.this_cUltimoTxtNovoGrupoLostFocusValidado
2815: 			RETURN
2816: 		ENDIF
2817: 
2818: 		THIS.this_lEmLookupGrupo = .T.
2819: 
2820: 		TRY
2821: 			IF !EMPTY(loc_cValorDigitado)
2822: 				IF USED("cursor_4c_BuscaGrupo")
2823: 					USE IN cursor_4c_BuscaGrupo
2824: 				ENDIF
2825: 
2826: 				loc_cSQL = "SELECT a.Cgrus, a.DGrus FROM SigCdGrp a" + ;
2827: 					" INNER JOIN SigCdRpo b ON (a.Cgrus = b.Cgrus OR a.Mercs = b.Mercs)" + ;
2828: 					" WHERE b.Dopps = " + EscaparSQL(THIS.this_cDopes)
2829: 				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")
2830: 
2831: 				IF loc_nResultado <= 0 OR RECCOUNT("cursor_4c_BuscaGrupo") = 0
2832: 					IF USED("cursor_4c_BuscaGrupo")
2833: 						USE IN cursor_4c_BuscaGrupo
2834: 					ENDIF
2835: 					loc_nResultado = SQLEXEC(gnConnHandle, "SELECT a.Cgrus, a.DGrus FROM SigCdGrp a", "cursor_4c_BuscaGrupo")
2836: 				ENDIF
2837: 
2838: 				IF loc_nResultado > 0 AND USED("cursor_4c_BuscaGrupo")
2839: 					SELECT cursor_4c_BuscaGrupo
2840: 					GO TOP
2841: 					LOCATE FOR ALLTRIM(Cgrus) == loc_cValorDigitado
2842: 
2843: 					IF FOUND()
2844: 						THIS.txt_4c_NovoGrupo.Value = ALLTRIM(Cgrus)
2845: 					ELSE
2846: 						*-- Codigo digitado nao existe no universo restrito:
2847: 						*-- abre o picker (equivale ao fwBuscaInt do legado).
2848: 						*-- Regra #50: cancelando (ESC) o digitado PERMANECE,
2849: 						*-- nao se apaga o campo nem se exibe aviso.
2850: 						THIS.AbrirBuscaNovoGrupo()
2851: 						IF !EMPTY(THIS.this_cLookupCodigo)
2852: 							THIS.txt_4c_NovoGrupo.Value = THIS.this_cLookupCodigo
2853: 						ENDIF
2854: 					ENDIF

*-- Linhas 2860 a 3133:
2860: 			*-- Registra o valor final do campo (digitado, resolvido pela
2861: 			*-- busca exata ou escolhido no picker) como "ja validado" -
2862: 			*-- a proxima perda de foco sem mudanca sai pela guarda acima.
2863: 			THIS.this_cUltimoTxtNovoGrupoLostFocusValidado = ALLTRIM(THIS.txt_4c_NovoGrupo.Value)
2864: 		CATCH TO loc_oErro
2865: 			MsgErro(loc_oErro.Message, "Erro em Formsigoporc.TxtNovoGrupoLostFocus")
2866: 		ENDTRY
2867: 
2868: 		THIS.this_lEmLookupGrupo = .F.
2869: 	ENDPROC
2870: 
2871: 	*==========================================================================
2872: 	* ConfigurarCampoBusca - getDpros/getDpro2s/btnProcura do legado: busca
2873: 	* textual na grade de itens, no rodape (mesma faixa Top=481 onde fica
2874: 	* edt_4c_DescritivoRodape - mutuamente exclusivos por this_nDigItens,
2875: 	* resolvido em AtualizarModoCriacao). Geometria/Picture TRANSCRITOS do
2876: 	* dump ("PROPRIEDADES DE: SIGOPORC.getDpros/getDpro2s/btnProcura").
2877: 	*
2878: 	* getDpros (TextBox/fwget) e getDpro2s (EditBox/fwmemo, mapeamento.json
2879: 	* confirma a classe) SO ficam editaveis quando this_lProcura = .T.
2880: 	* (legado: "PROCEDURE When / Return thisform.lProcura") - fora do modo
2881: 	* de busca espelham a descricao do item corrente, escritas por
2882: 	* GradeItensAfterRowColChange. .Enabled, nao .ReadOnly: reproduz o
2883: 	* efeito do When (campo nao alcancavel por Tab/clique) sem inventar
2884: 	* estado novo.
2885: 	*==========================================================================
2886: 	PROTECTED PROCEDURE ConfigurarCampoBusca()
2887: 		THIS.AddObject("txt_4c_ProcuraDpros", "TextBox")
2888: 		WITH THIS.txt_4c_ProcuraDpros
2889: 			.Top           = 481
2890: 			.Left          = 16
2891: 			.Width         = 290
2892: 			.Height        = 21
2893: 			.FontSize      = 8
2894: 			.Alignment     = 3
2895: 			.Format        = "K"
2896: 			.Margin        = 0
2897: 			.SpecialEffect = 1
2898: 			.ForeColor     = RGB(0, 0, 0)
2899: 			.BorderColor   = RGB(100, 100, 100)
2900: 			.Value         = ""
2901: 			.Enabled       = .F.
2902: 			.Visible       = .T.
2903: 		ENDWITH
2904: 		BINDEVENT(THIS.txt_4c_ProcuraDpros, "KeyPress", THIS, "ProcuraDprosKeyPress")
2905: 		BINDEVENT(THIS.txt_4c_ProcuraDpros, "LostFocus", THIS, "ProcuraDprosLostFocus")
2906: 
2907: 		THIS.AddObject("edt_4c_ProcuraDpro2s", "EditBox")
2908: 		WITH THIS.edt_4c_ProcuraDpro2s
2909: 			.Top           = 481
2910: 			.Left          = 307
2911: 			.Width         = 290
2912: 			.Height        = 21
2913: 			.FontSize      = 8
2914: 			.SpecialEffect = 1
2915: 			.ForeColor     = RGB(0, 0, 0)
2916: 			.BorderColor   = RGB(100, 100, 100)
2917: 			.Value         = ""
2918: 			.Enabled       = .F.
2919: 			.Visible       = .T.
2920: 		ENDWITH
2921: 		BINDEVENT(THIS.edt_4c_ProcuraDpro2s, "KeyPress", THIS, "ProcuraDpro2sKeyPress")
2922: 		BINDEVENT(THIS.edt_4c_ProcuraDpro2s, "LostFocus", THIS, "ProcuraDpro2sLostFocus")
2923: 
2924: 		THIS.AddObject("cmd_4c_Procurar", "CommandButton")
2925: 		WITH THIS.cmd_4c_Procurar
2926: 			.Top             = 481
2927: 			.Left            = 600
2928: 			.Height          = 21
2929: 			.Width           = 40
2930: 			.Caption         = ""
2931: 			.ToolTipText     = "Procurar Item"
2932: 			.Picture         = gc_4c_CaminhoIcones + "geral_lupa_16.jpg"
2933: 			.DisabledPicture = gc_4c_CaminhoIcones + "geral_lupa_16.jpg"
2934: 			.Themes          = .T.
2935: 			.Visible         = .T.
2936: 		ENDWITH
2937: 		BINDEVENT(THIS.cmd_4c_Procurar, "Click", THIS, "BtnProcurarClick")
2938: 	ENDPROC
2939: 
2940: 	*==========================================================================
2941: 	* ProcuraDprosKeyPress / ProcuraDpro2sKeyPress - legado SIGOPORC.getDpros/
2942: 	* getDpro2s.Valid (disparado so com this_lProcura = .T., porque fora
2943: 	* disso os campos ficam Enabled = .F. e nao recebem KeyPress). Mesmo
2944: 	* comportamento do legado: LOCATE (sem SEEK/GO) move o registro
2945: 	* corrente da grade para a primeira linha cujo Dpros/Dpro2s contem o
2946: 	* texto digitado - o Refresh so repinta o que o LOCATE ja moveu.
2947: 	*==========================================================================
2948: 	PROCEDURE ProcuraDprosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2949: 		LOCAL loc_cItens, loc_cValor
2950: 
2951: 		IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
2952: 			RETURN
2953: 		ENDIF
2954: 
2955: 		loc_cValor = ALLTRIM(THIS.txt_4c_ProcuraDpros.Value)
2956: 		IF EMPTY(loc_cValor)
2957: 			RETURN
2958: 		ENDIF
2959: 
2960: 		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
2961: 		IF USED(loc_cItens)
2962: 			SELECT (loc_cItens)
2963: 			GO TOP
2964: 			LOCATE FOR LIKE("*" + loc_cValor + "*", dpros)
2965: 			THIS.grd_4c_Itens.Refresh()
2966: 		ENDIF
2967: 	ENDPROC
2968: 
2969: 	PROCEDURE ProcuraDpro2sKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2970: 		LOCAL loc_cItens, loc_cValor
2971: 
2972: 		IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
2973: 			RETURN
2974: 		ENDIF
2975: 
2976: 		loc_cValor = ALLTRIM(THIS.edt_4c_ProcuraDpro2s.Value)
2977: 		IF EMPTY(loc_cValor)
2978: 			RETURN
2979: 		ENDIF
2980: 
2981: 		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
2982: 		IF USED(loc_cItens)
2983: 			SELECT (loc_cItens)
2984: 			GO TOP
2985: 			LOCATE FOR LIKE("*" + loc_cValor + "*", dpro2s)
2986: 			THIS.grd_4c_Itens.Refresh()
2987: 		ENDIF
2988: 	ENDPROC
2989: 
2990: 	*==========================================================================
2991: 	* ProcuraDprosLostFocus / ProcuraDpro2sLostFocus - legado: "If !Empty
2992: 	* (this.Value) / thisform.btnprocura.SetFocus()". So move o foco (nao
2993: 	* dispara busca nenhuma) - a busca ja rodou no Enter/Tab acima.
2994: 	*==========================================================================
2995: 	PROCEDURE ProcuraDprosLostFocus()
2996: 		IF !EMPTY(THIS.txt_4c_ProcuraDpros.Value)
2997: 			THIS.cmd_4c_Procurar.SetFocus()
2998: 		ENDIF
2999: 	ENDPROC
3000: 
3001: 	PROCEDURE ProcuraDpro2sLostFocus()
3002: 		IF !EMPTY(THIS.edt_4c_ProcuraDpro2s.Value)
3003: 			THIS.cmd_4c_Procurar.SetFocus()
3004: 		ENDIF
3005: 	ENDPROC
3006: 
3007: 	*==========================================================================
3008: 	* BtnProcurarClick - legado SIGOPORC.btnProcura.Click. Botao de DUAS
3009: 	* fases, igual ao legado: 1o clique entra em modo de busca (habilita
3010: 	* os dois campos, limpa e foca); clique seguinte (ja em modo de busca)
3011: 	* EXECUTA a busca pelo campo preenchido - Dpros tem prioridade sobre
3012: 	* Dpro2s quando os dois estao preenchidos (legado: "Iif(!Empty(getDpros.
3013: 	* Value), getDpros.Value, getDpro2s.Value)"). this_lProcura SO volta a
3014: 	* .F. quando a grade troca de linha (GradeItensAfterRowColChange) -
3015: 	* exatamente como no legado, que nunca reseta a flag aqui dentro.
3016: 	*==========================================================================
3017: 	PROCEDURE BtnProcurarClick()
3018: 		LOCAL loc_cItens, loc_nItem, loc_cProcura, loc_lPorDpros
3019: 
3020: 		*-- "When" do legado (Inlist(Op_Escolha,[INSERIR],[ALTERAR])) como
3021: 		*-- guarda no handler: btnProcura e botao SO-ICONE (Caption = "" no
3022: 		*-- dump) e NAO pode receber .Enabled = .F. - com Caption vazio o
3023: 		*-- VFP9 deixa de desenhar o Picture e o botao vira um retangulo
3024: 		*-- vazio (CorretorAutomatico #106). BINDEVENT tambem descarta o
3025: 		*-- retorno do delegate, entao um When ligado por BINDEVENT nao
3026: 		*-- bloquearia nada.
3027: 		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
3028: 			RETURN
3029: 		ENDIF
3030: 
3031: 		IF !THIS.this_lProcura
3032: 			THIS.this_lProcura = .T.
3033: 
3034: 			THIS.txt_4c_ProcuraDpros.Enabled  = .T.
3035: 			THIS.edt_4c_ProcuraDpro2s.Enabled = .T.
3036: 			THIS.txt_4c_ProcuraDpros.Value    = ""
3037: 			THIS.edt_4c_ProcuraDpro2s.Value   = ""
3038: 
3039: 			THIS.txt_4c_ProcuraDpros.SetFocus()
3040: 		ELSE
3041: 			IF !EMPTY(THIS.txt_4c_ProcuraDpros.Value) OR !EMPTY(THIS.edt_4c_ProcuraDpro2s.Value)
3042: 				loc_lPorDpros = !EMPTY(THIS.txt_4c_ProcuraDpros.Value)
3043: 				loc_cProcura  = ALLTRIM(IIF(loc_lPorDpros, THIS.txt_4c_ProcuraDpros.Value, THIS.edt_4c_ProcuraDpro2s.Value))
3044: 
3045: 				loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
3046: 				IF USED(loc_cItens)
3047: 					SELECT (loc_cItens)
3048: 					loc_nItem = citens
3049: 					IF !EOF()
3050: 						SKIP
3051: 					ENDIF
3052: 					IF loc_lPorDpros
3053: 						LOCATE FOR LIKE("*" + loc_cProcura + "*", dpros) AND citens <> loc_nItem
3054: 					ELSE
3055: 						LOCATE FOR LIKE("*" + loc_cProcura + "*", dpro2s) AND citens <> loc_nItem
3056: 					ENDIF
3057: 					THIS.grd_4c_Itens.Refresh()
3058: 				ENDIF
3059: 			ENDIF
3060: 		ENDIF
3061: 	ENDPROC
3062: 
3063: 	*==========================================================================
3064: 	* ConfigurarImagemProduto - imgProds do legado: pre-visualizacao da foto
3065: 	* do produto do item corrente, oculta por padrao (Visible = .F. no
3066: 	* dump) - so aparece quando GradeItensAfterRowColChange encontra foto E
3067: 	* SigCdOpe.Imagems = 1 (this_nImagems, Fase posterior). Duplo clique
3068: 	* amplia (DblClick do legado - "Do Form SigOpZom"; SigOpZom nao foi
3069: 	* migrado, fallback ShellExecute igual ao de Formsigprccp.FigJpgDblClick).
3070: 	*==========================================================================
3071: 	PROTECTED PROCEDURE ConfigurarImagemProduto()
3072: 		THIS.AddObject("img_4c_Produto", "Image")
3073: 		WITH THIS.img_4c_Produto
3074: 			.Top         = 108
3075: 			.Left        = 579
3076: 			.Width       = 159
3077: 			.Height      = 89
3078: 			.Stretch     = 1
3079: 			.ToolTipText = "Imagem do Produto [Duplo Click Para Zoom]"
3080: 			.Picture     = ""
3081: 			.Visible     = .F.
3082: 		ENDWITH
3083: 		BINDEVENT(THIS.img_4c_Produto, "DblClick", THIS, "ImgProdutoDblClick")
3084: 	ENDPROC
3085: 
3086: 	*==========================================================================
3087: 	* ImgProdutoDblClick - legado SIGOPORC.imgProds.DblClick. Reextrai a
3088: 	* foto do PRODUTO CORRENTE para um arquivo temporario proprio e abre o
3089: 	* visualizador ampliado. Mesmo padrao canonico ja usado em
3090: 	* Formsigprccp.FigJpgDblClick (FormSigOpZom ainda nao foi migrado - o
3091: 	* fallback abre a imagem no visualizador do Windows via ShellExecute).
3092: 	*==========================================================================
3093: 	PROCEDURE ImgProdutoDblClick()
3094: 		LOCAL loc_cItens, loc_cCpros, loc_cDpros, loc_cSQL, loc_nResultado
3095: 		LOCAL loc_cFigJpgs, loc_cArqTemp, loc_cFoto, loc_cCaption, loc_oErro, loc_lProsseguir
3096: 		loc_lProsseguir = .T.
3097: 
3098: 		TRY
3099: 			loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
3100: 			IF !USED(loc_cItens) OR EOF(loc_cItens)
3101: 				loc_lProsseguir = .F.
3102: 			ENDIF
3103: 
3104: 			IF loc_lProsseguir
3105: 				loc_cCpros = ALLTRIM(TratarNulo(EVALUATE(loc_cItens + ".cpros"), ""))
3106: 				loc_cDpros = ALLTRIM(TratarNulo(EVALUATE(loc_cItens + ".dpros"), ""))
3107: 				IF EMPTY(loc_cCpros)
3108: 					loc_lProsseguir = .F.
3109: 				ENDIF
3110: 			ENDIF
3111: 
3112: 			IF loc_lProsseguir
3113: 				IF USED("cursor_4c_TmpFotoZom")
3114: 					USE IN cursor_4c_TmpFotoZom
3115: 				ENDIF
3116: 				loc_cSQL = "SELECT a.FigJpgs FROM SigCdPro a WHERE a.cpros = " + EscaparSQL(loc_cCpros)
3117: 				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpFotoZom")
3118: 
3119: 				IF loc_nResultado < 1 OR !USED("cursor_4c_TmpFotoZom") OR RECCOUNT("cursor_4c_TmpFotoZom") = 0
3120: 					loc_lProsseguir = .F.
3121: 				ENDIF
3122: 			ENDIF
3123: 
3124: 			IF loc_lProsseguir
3125: 				SELECT cursor_4c_TmpFotoZom
3126: 				GO TOP
3127: 				loc_cFigJpgs = TratarNulo(cursor_4c_TmpFotoZom.FigJpgs, "")
3128: 				USE IN cursor_4c_TmpFotoZom
3129: 
3130: 				IF !EMPTY(loc_cFigJpgs)
3131: 					loc_cArqTemp = SYS(2023) + "\" + SYS(2015) + ".jpg"
3132: 					loc_cFoto = STRCONV( ;
3133: 						STRTRAN(STRTRAN(STRTRAN(loc_cFigJpgs, ;

*-- Linhas 3163 a 3296:
3163: 			MsgErro("Erro ao ampliar a foto do produto:" + CHR(13) + ;
3164: 				loc_oErro.Message + CHR(13) + ;
3165: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3166: 				"Procedure: " + loc_oErro.Procedure, "Erro")
3167: 		ENDTRY
3168: 	ENDPROC
3169: 
3170: 	*==========================================================================
3171: 	* ConfigurarDescritivoRodape - getDescritivo do legado: memo de rodape,
3172: 	* largura TOTAL, abaixo das duas grades. Por padrao (ControlSource =
3173: 	* TprMvCab.Obses, dado de cabecalho que esta fora do escopo deste BO)
3174: 	* o Init legado deixa INVISIVEL fora do modo Criacao - unico estado
3175: 	* alcancavel nesta fase, porque this_nDigItens so e preenchido em
3176: 	* fase posterior (SigCdOpe - ver cabecalho do BO). AtualizarModoCriacao
3177: 	* fica pronto para quando DigItens chegar: troca o ControlSource para
3178: 	* o Dpro2s do item corrente e mostra o campo (regra transcrita do
3179: 	* Init: "If Inlist(DigItens,6,7) ... thisform.getDescritivo.
3180: 	* ControlSource = [crSigMvOrc.Dpro2s] Else ... .Visible = .f.").
3181: 	*==========================================================================
3182: 	PROTECTED PROCEDURE ConfigurarDescritivoRodape()
3183: 		THIS.AddObject("edt_4c_DescritivoRodape", "EditBox")
3184: 		WITH THIS.edt_4c_DescritivoRodape
3185: 			.Top           = 481
3186: 			.Left          = 5
3187: 			.Width         = 989
3188: 			.Height        = 115
3189: 			.FontSize      = 8
3190: 			.SpecialEffect = 1
3191: 			.ForeColor     = RGB(0, 0, 0)
3192: 			.DisabledBackColor = RGB(255, 255, 255)
3193: 			.BorderColor   = RGB(100, 100, 100)
3194: 			.Value         = ""
3195: 			.Enabled       = .F.
3196: 			.Visible       = .F.
3197: 		ENDWITH
3198: 	ENDPROC
3199: 
3200: 	*==========================================================================
3201: 	* AtualizarModoCriacao - transcricao do bloco de LAYOUT do Init legado:
3202: 	* o ramo "Inlist(crSigCdOpe.DigItens,6,7)" (modo Criacao) e, no ramo
3203: 	* normal, a bifurcacao "LocalEmp.DIVNOTAS = 2" (P&G) / Else (SRCOM).
3204: 	* Decide QUEM APARECE e com que legenda/geometria; quem fica EDITAVEL e
3205: 	* decidido por HabilitarCampos()/AjustarBotoesPorModo() (os "When" do
3206: 	* legado). Chamado em InicializarForm e por CarregarDados - e
3207: 	* IDEMPOTENTE de proposito: cada controle recebe Visible nos DOIS
3208: 	* sentidos, nunca so no ramo que o esconde.
3209: 	*
3210: 	* Fase 8/8 - COMPLETADO: ate a fase anterior este metodo cobria apenas
3211: 	* edt_4c_DescritivoRodape e o trio de busca. O bloco legado toca ainda
3212: 	* say1..say6 + os 6 getP* (os seis pares label/campo de percentual),
3213: 	* grdParcela, btnIncluirp/btnExcluirp, btnTotItens e btnIteSub - todos
3214: 	* ficavam VISIVEIS em modo Criacao (onde o legado os esconde), e as
3215: 	* duas legendas que o P&G troca ("Lucro"/"Imposto Cheio") nunca eram
3216: 	* aplicadas. Mapa label->objeto do legado, conferido no dump:
3217: 	*   say5 -> lbl_4c_Margem          say4 -> lbl_4c_Contingente
3218: 	*   say1 -> lbl_4c_TaxaAdm         say3 -> lbl_4c_BV
3219: 	*   say2 -> lbl_4c_Imposto         say6 -> lbl_4c_ImpostoServico
3220: 	*
3221: 	* DESVIO DOCUMENTADO (geometria do ramo P&G): o legado faz
3222: 	* "grdItem.Height = 444" junto com "getDpros/getDpro2s/btnProcura.Top
3223: 	* = 570". Os dois numeros sao INCOMPATIVEIS entre si - com grdItem.Top
3224: 	* = 218, a altura 444 leva a grade ate 662, ou seja a grade cobriria a
3225: 	* linha de busca em 570 (e passaria do rodape do form, de 600). O SCX
3226: 	* nao declara Height do form (a secao de propriedades do form vem
3227: 	* VAZIA no dump), entao 444 nao e verificavel; 570 e, e cabe. Aqui
3228: 	* vale o 570 do legado (linha de busca encostada no rodape) e a grade
3229: 	* cresce ATE ela - Height = 350 (218 + 350 = 568) - em vez de 444.
3230: 	* Transcrever 444 ao pe da letra soterraria tres controles (regra #30:
3231: 	* controle recortado/coberto some sem erro e sem aparecer em
3232: 	* screenshot).
3233: 	*==========================================================================
3234: 	PROTECTED PROCEDURE AtualizarModoCriacao()
3235: 		LOCAL loc_cItens, loc_lModoCriacao, loc_lPG, loc_lMostraPerc, ;
3236: 			loc_lPercSoPG, loc_lMostraParcelas
3237: 
3238: 		loc_cItens       = THIS.this_oBusinessObject.this_cCursorItens
3239: 		loc_lModoCriacao = INLIST(THIS.this_oBusinessObject.this_nDigItens, 6, 7)
3240: 		loc_lPG          = (THIS.this_oBusinessObject.this_nDivNotas = 2)
3241: 
3242: 		*-- Os 6 percentuais somem inteiros no modo Criacao. Fora dele,
3243: 		*-- Margem/Contingente/BV/Imposto sem ISS so existem em P&G
3244: 		*-- (o Else SRCOM do legado esconde esses quatro); Taxa Adm. e
3245: 		*-- Imposto aparecem nos dois.
3246: 		loc_lMostraPerc = !loc_lModoCriacao
3247: 		loc_lPercSoPG   = loc_lMostraPerc AND loc_lPG
3248: 
3249: 		*-- A grade de parcelas (e seus dois botoes) sai da tela tanto no
3250: 		*-- modo Criacao quanto em P&G - nos dois ramos o legado faz
3251: 		*-- "grdParcela.Visible = .f." + "btnIncluirp/btnExcluirp .Visible/
3252: 		*-- .Enabled = .f.". Previsao de pagamento so existe em SRCOM.
3253: 		loc_lMostraParcelas = !loc_lModoCriacao AND !loc_lPG
3254: 
3255: 		*-- Pares label/campo dos percentuais
3256: 		THIS.lbl_4c_Margem.Visible         = loc_lPercSoPG
3257: 		THIS.txt_4c_Margem.Visible         = loc_lPercSoPG
3258: 		THIS.lbl_4c_Contingente.Visible    = loc_lPercSoPG
3259: 		THIS.txt_4c_Contingente.Visible    = loc_lPercSoPG
3260: 		THIS.lbl_4c_BV.Visible             = loc_lPercSoPG
3261: 		THIS.txt_4c_BV.Visible             = loc_lPercSoPG
3262: 		THIS.lbl_4c_ImpostoServico.Visible = loc_lPercSoPG
3263: 		THIS.txt_4c_ImpostoServico.Visible = loc_lPercSoPG
3264: 
3265: 		THIS.lbl_4c_TaxaAdm.Visible        = loc_lMostraPerc
3266: 		THIS.txt_4c_TaxaAdm.Visible        = loc_lMostraPerc
3267: 		THIS.lbl_4c_Imposto.Visible        = loc_lMostraPerc
3268: 		THIS.txt_4c_Imposto.Visible        = loc_lMostraPerc
3269: 
3270: 		*-- Legendas que o ramo P&G troca (say1/say2 do legado)
3271: 		IF loc_lPG
3272: 			THIS.lbl_4c_TaxaAdm.Caption = "Lucro :                %"
3273: 			THIS.lbl_4c_Imposto.Caption = "Imposto Cheio :                %"
3274: 		ELSE
3275: 			THIS.lbl_4c_TaxaAdm.Caption = "Ta\<xa Adm. :                     %"
3276: 			THIS.lbl_4c_Imposto.Caption = "Im\<posto :                     %"
3277: 		ENDIF
3278: 
3279: 		*-- Grade de parcelas e seus botoes
3280: 		THIS.grd_4c_Parcelas.Visible       = loc_lMostraParcelas
3281: 		THIS.grd_4c_Parcelas.Enabled       = loc_lMostraParcelas
3282: 		THIS.cmd_4c_IncluirParcela.Visible = loc_lMostraParcelas
3283: 		THIS.cmd_4c_ExcluirParcela.Visible = loc_lMostraParcelas
3284: 
3285: 		*-- Botoes do rodape que o modo Criacao esconde
3286: 		THIS.cmd_4c_TotItens.Visible = !loc_lModoCriacao
3287: 		THIS.cmd_4c_IteSub.Visible   = !loc_lModoCriacao
3288: 
3289: 		IF loc_lModoCriacao
3290: 			*-- Criacao: o descritivo do rodape entra ligado ao item corrente
3291: 			*-- (legado: getDescritivo.ControlSource = [crSigMvOrc.Dpro2s]) e
3292: 			*-- a linha de busca sai inteira.
3293: 			THIS.edt_4c_DescritivoRodape.Visible = .T.
3294: 			IF USED(loc_cItens)
3295: 				THIS.edt_4c_DescritivoRodape.ControlSource = loc_cItens + ".dpro2s"
3296: 			ENDIF

*-- Linhas 3340 a 3584:
3340: 	* repinta a grade ligada a ele, por isso o Refresh fica no funil
3341: 	* CarregarDados e no handler de troca de linha (regra #21).
3342: 	*==========================================================================
3343: 	PROTECTED PROCEDURE PosicionarParcelasDoItem()
3344: 		LOCAL loc_cItens, loc_cParcelas, loc_nItem
3345: 		loc_cItens    = THIS.this_oBusinessObject.this_cCursorItens
3346: 		loc_cParcelas = THIS.this_oBusinessObject.this_cCursorParcelas
3347: 
3348: 		IF USED(loc_cParcelas)
3349: 			loc_nItem = 0
3350: 			IF USED(loc_cItens) AND !EOF(loc_cItens)
3351: 				loc_nItem = EVALUATE(loc_cItens + ".citens")
3352: 			ENDIF
3353: 
3354: 			SELECT (loc_cParcelas)
3355: 			SET ORDER TO
3356: 			SET ORDER TO TAG citens
3357: 			SET KEY TO loc_nItem
3358: 			GO TOP
3359: 		ENDIF
3360: 	ENDPROC
3361: 
3362: 	*==========================================================================
3363: 	* CarregarDados - FUNIL de carga da tela. PUBLIC de proposito: alem de
3364: 	* ser chamado pelo InicializarForm, o harness de teste
3365: 	* (TesteAutomatico.prg) o invoca de FORA da classe - com PROTECTED a
3366: 	* chamada estoura "Property CARREGARDADOS is not found", porque
3367: 	* PEMSTATUS(...,5) devolve .T. tambem para metodo protegido (regra #3).
3368: 	*
3369: 	* Ordem (a mesma do Init legado): garantir os cursores -> aplicar o
3370: 	* layout do modo (AtualizarModoCriacao) -> CarregarLista (vincular as
3371: 	* duas grades, ler do banco, posicionar os aliases e repintar) ->
3372: 	* BOParaForm (percentuais do cabecalho na tela).
3373: 	*
3374: 	* Fase 8/8: a parte de RECARGA saiu daqui para CarregarLista(), que e
3375: 	* o funil chamado tambem pelas recargas posteriores - antes a leitura
3376: 	* do banco + bind + reposicionamento + Refresh existiam SO aqui, e
3377: 	* quem precisasse reler teria de duplicar a sequencia. CarregarDados
3378: 	* continua PUBLIC e continua sendo o ponto de entrada do InicializarForm
3379: 	* e do harness.
3380: 	*
3381: 	* Nao estoura quando os cursores ainda nao existem (caso do harness, que
3382: 	* instancia o form sem chamador): o resultado sai por flag e o RETURN e
3383: 	* unico, depois do ENDTRY (regra #1).
3384: 	*==========================================================================
3385: 	PROCEDURE CarregarDados()
3386: 		LOCAL loc_lSucesso, loc_oErro, loc_cItens, loc_cParcelas
3387: 		loc_lSucesso = .F.
3388: 
3389: 		TRY
3390: 			loc_cItens    = THIS.this_oBusinessObject.this_cCursorItens
3391: 			loc_cParcelas = THIS.this_oBusinessObject.this_cCursorParcelas
3392: 
3393: 			IF !USED(loc_cItens)
3394: 				THIS.CriarCursorItens()
3395: 			ENDIF
3396: 
3397: 			IF !USED(loc_cParcelas)
3398: 				THIS.CriarCursorParcelas()
3399: 			ENDIF
3400: 
3401: 			*-- Layout (quem aparece) ANTES da carga: AtualizarModoCriacao
3402: 			*-- liga o ControlSource de edt_4c_DescritivoRodape ao cursor e
3403: 			*-- fecha chamando HabilitarCampos/AjustarBotoesPorModo.
3404: 			THIS.AtualizarModoCriacao()
3405: 
3406: 			*-- Legado: AddCursor('SigMvOrc',...)/AddCursor('SigMvOrp',...) no
3407: 			*-- Init. Vincular as grades, ler do banco, posicionar os aliases
3408: 			*-- e repintar ficam todos em CarregarLista (funil de recarga),
3409: 			*-- para a primeira carga e as recargas seguintes seguirem
3410: 			*-- exatamente o mesmo caminho.
3411: 			loc_lSucesso = THIS.CarregarLista()
3412: 
3413: 			*-- Valores do cabecalho (percentuais) para a tela - no legado
3414: 			*-- vinham sozinhos pelo ControlSource = TprMvCab.<coluna>
3415: 			THIS.BOParaForm()
3416: 		CATCH TO loc_oErro
3417: 			MsgErro(loc_oErro.Message + CHR(13) + ;
3418: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3419: 				"Procedure: " + loc_oErro.Procedure, ;
3420: 				"Erro em Formsigoporc.CarregarDados")
3421: 		ENDTRY
3422: 
3423: 		RETURN loc_lSucesso
3424: 	ENDPROC
3425: 
3426: 	*==========================================================================
3427: 	* GradeItensAfterRowColChange - Troca de linha na grade de itens: refaz
3428: 	* o filtro da grade de parcelas (mestre-detalhe), espelha a descricao
3429: 	* do item nos campos de busca, reseta o modo de busca e atualiza a
3430: 	* pre-visualizacao da foto do produto. Ligado por BINDEVENT, por isso
3431: 	* declara o parametro do evento (regra #3: handler sem parametro
3432: 	* ligado a AfterRowColChange estoura).
3433: 	*
3434: 	* Uso CORRETO de AfterRowColChange - carregar o DETALHE da linha
3435: 	* corrente, SEM filtrar por coluna (regra #46). Validacao de celula nao
3436: 	* entra aqui: vai no Valid do TextBox da Column.
3437: 	*
3438: 	* O grdItem.AfterRowColChange do legado faz mais coisas, que dependem de
3439: 	* btnCadPro/Get_NewGrp (Fase 7 - precisam de SigCdOpe.CadProds/CadProDs,
3440: 	* ainda nao carregados) e da troca do DynamicForeColor pelo CitAgrs.
3441: 	*==========================================================================
3442: 	PROCEDURE GradeItensAfterRowColChange(par_nColIndex)
3443: 		LOCAL loc_cItens, loc_cDpros, loc_cDpro2s
3444: 
3445: 		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
3446: 
3447: 		*-- Legado: thisform.cItAgr = crSigMvOrc.CitAgrs (agrupador da linha
3448: 		*-- corrente, usado pelo realce de decupagem)
3449: 		IF USED(loc_cItens) AND !EOF(loc_cItens)
3450: 			THIS.this_nCItAgr = EVALUATE(loc_cItens + ".citagrs")
3451: 		ENDIF
3452: 
3453: 		*-- Legado: "thisform.lProcura = .f." + imgProds.Visible=.f./Picture=[]
3454: 		*-- no inicio do AfterRowColChange - toda troca de linha sai do modo
3455: 		*-- de busca e esconde a foto do produto anterior.
3456: 		THIS.this_lProcura = .F.
3457: 		THIS.img_4c_Produto.Visible = .F.
3458: 		THIS.img_4c_Produto.Picture = ""
3459: 
3460: 		*-- Legado: "thisform.getDPros.Value = crSigMvOrc.Dpros" / "getDPro2s.
3461: 		*-- Value = crSigMvOrc.Dpro2s" - fora do modo de busca os dois campos
3462: 		*-- so espelham a descricao do item corrente (ficam Enabled = .F.,
3463: 		*-- ver AtualizarModoCriacao).
3464: 		loc_cDpros  = ""
3465: 		loc_cDpro2s = ""
3466: 		IF USED(loc_cItens) AND !EOF(loc_cItens)
3467: 			loc_cDpros  = TratarNulo(EVALUATE(loc_cItens + ".dpros"), "")
3468: 			loc_cDpro2s = TratarNulo(EVALUATE(loc_cItens + ".dpro2s"), "")
3469: 		ENDIF
3470: 		THIS.txt_4c_ProcuraDpros.Enabled  = .F.
3471: 		THIS.edt_4c_ProcuraDpro2s.Enabled = .F.
3472: 		THIS.txt_4c_ProcuraDpros.Value    = loc_cDpros
3473: 		THIS.edt_4c_ProcuraDpro2s.Value   = loc_cDpro2s
3474: 
3475: 		THIS.CarregarImagemProdutoCorrente()
3476: 
3477: 		*-- Fase 7/8 - legado: "With ThisForm.btnCadPro / llVis = (InList(
3478: 		*-- crSigCdOpe.CadProds,1,3,4,5)) And fChecaAcesso('SigCdPro',
3479: 		*-- 'INSERIR') And InList(ThisForm.Op_Escolha,'INSERIR','ALTERAR') /
3480: 		*-- .Enabled = llVis And Not Eof(...) And (...)". CadProDs do legado
3481: 		*-- e a MESMA coluna que CadProds (VFP e case-insensitive) - this_nCadProds
3482: 		*-- cobre as duas grafias.
3483: 		THIS.AtualizarEstadoCadastroProduto()
3484: 
3485: 		THIS.PosicionarParcelasDoItem()
3486: 		THIS.grd_4c_Parcelas.Refresh()
3487: 	ENDPROC
3488: 
3489: 	*==========================================================================
3490: 	* AtualizarEstadoCadastroProduto - Habilita/desabilita cmd_4c_CadPro
3491: 	* (btnCadPro) e o par txt_4c_NovoGrupo/lbl_4c_NovoGrupo conforme a linha
3492: 	* corrente da grade de itens e SigCdOpe.CadProds - transcrito do final
3493: 	* do AfterRowColChange legado (fica em metodo proprio, chamado tambem
3494: 	* de BtnCadastroProdutoClick depois de confirmar um produto novo).
3495: 	*==========================================================================
3496: 	PROCEDURE AtualizarEstadoCadastroProduto()
3497: 		LOCAL loc_cItens, loc_lVisivel, loc_cCpros, loc_nCitens, loc_nCitem2, loc_cBlocos, loc_lLinhaNormal
3498: 
3499: 		IF !PEMSTATUS(THIS, "cmd_4c_CadPro", 5)
3500: 			RETURN
3501: 		ENDIF
3502: 
3503: 		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
3504: 
3505: 		loc_lVisivel = INLIST(THIS.this_oBusinessObject.this_nCadProds, 1, 3, 4, 5) AND ;
3506: 			fChecaAcesso("SigCdPro", "INSERIR") AND ;
3507: 			INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
3508: 
3509: 		IF !USED(loc_cItens) OR EOF(loc_cItens)
3510: 			THIS.cmd_4c_CadPro.Enabled = .F.
3511: 			RETURN
3512: 		ENDIF
3513: 
3514: 		loc_cCpros  = TratarNulo(EVALUATE(loc_cItens + ".cpros"), "")
3515: 		loc_nCitens = EVALUATE(loc_cItens + ".citens")
3516: 		loc_nCitem2 = EVALUATE(loc_cItens + ".citem2")
3517: 		loc_cBlocos = ALLTRIM(TratarNulo(EVALUATE(loc_cItens + ".cblocos"), ""))
3518: 
3519: 		loc_lLinhaNormal = (loc_nCitens <> loc_nCitem2) AND ;
3520: 			!INLIST(loc_cBlocos, "SUBTOTAL", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "BRANCO", "TOTALGERAL")
3521: 
3522: 		THIS.cmd_4c_CadPro.Enabled = loc_lVisivel AND ;
3523: 			( ;
3524: 				(EMPTY(loc_cCpros) AND THIS.this_oBusinessObject.this_nCadProds = 1 AND loc_lLinhaNormal) OR ;
3525: 				(!EMPTY(loc_cCpros) AND THIS.this_oBusinessObject.this_nCadProds = 3 AND loc_lLinhaNormal) OR ;
3526: 				INLIST(THIS.this_oBusinessObject.this_nCadProds, 4, 5) ;
3527: 			)
3528: 
3529: 		IF THIS.this_oBusinessObject.this_nCadProds = 4
3530: 			THIS.txt_4c_NovoGrupo.Enabled = EMPTY(loc_cCpros)
3531: 			THIS.lbl_4c_NovoGrupo.Enabled = EMPTY(loc_cCpros)
3532: 			THIS.txt_4c_NovoGrupo.Value   = ""
3533: 		ENDIF
3534: 	ENDPROC
3535: 
3536: 	*==========================================================================
3537: 	* CarregarImagemProdutoCorrente - legado: trecho final do AfterRowColChange
3538: 	* que consulta SigCdPro.FigJpgs do item corrente e mostra a foto SE
3539: 	* SigCdOpe.Imagems = 1 E Confes <> 1 (this_nImagems/this_nConfes - Fase
3540: 	* posterior; com o default 0 este metodo e no-op, igual ao
3541: 	* comportamento seguro ja documentado para DigItens/DivNotas). Decode
3542: 	* UNICO de base64->JPEG (regra: nunca aplicar STRCONV(...,14) duas vezes).
3543: 	*==========================================================================
3544: 	PROTECTED PROCEDURE CarregarImagemProdutoCorrente()
3545: 		LOCAL loc_cItens, loc_cCpros, loc_cSQL, loc_nResultado, loc_cFigJpgs, loc_cFoto, loc_cArqTemp, loc_oErro
3546: 
3547: 		IF THIS.this_oBusinessObject.this_nImagems <> 1 OR THIS.this_oBusinessObject.this_nConfes = 1
3548: 			RETURN
3549: 		ENDIF
3550: 
3551: 		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
3552: 		IF !USED(loc_cItens) OR EOF(loc_cItens)
3553: 			RETURN
3554: 		ENDIF
3555: 
3556: 		loc_cCpros = ALLTRIM(TratarNulo(EVALUATE(loc_cItens + ".cpros"), ""))
3557: 		IF EMPTY(loc_cCpros)
3558: 			RETURN
3559: 		ENDIF
3560: 
3561: 		TRY
3562: 			IF USED("cursor_4c_TmpFotoItem")
3563: 				USE IN cursor_4c_TmpFotoItem
3564: 			ENDIF
3565: 			loc_cSQL = "SELECT a.FigJpgs FROM SigCdPro a WHERE a.cpros = " + EscaparSQL(loc_cCpros)
3566: 			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpFotoItem")
3567: 
3568: 			IF loc_nResultado >= 1 AND USED("cursor_4c_TmpFotoItem") AND RECCOUNT("cursor_4c_TmpFotoItem") > 0
3569: 				SELECT cursor_4c_TmpFotoItem
3570: 				GO TOP
3571: 				loc_cFigJpgs = TratarNulo(cursor_4c_TmpFotoItem.FigJpgs, "")
3572: 				USE IN cursor_4c_TmpFotoItem
3573: 
3574: 				IF !EMPTY(loc_cFigJpgs)
3575: 					loc_cArqTemp = SYS(2023) + "\" + go_4c_Sistema.Sys2015Tmp + "SigOpPro.jpg"
3576: 					loc_cFoto = STRCONV( ;
3577: 						STRTRAN(STRTRAN(STRTRAN(loc_cFigJpgs, ;
3578: 							"data:image/png;base64,", ""), ;
3579: 							"data:image/jpeg;base64,", ""), ;
3580: 							"data:image/jpg;base64,", ""), 14)
3581: 
3582: 					IF STRTOFILE(loc_cFoto, loc_cArqTemp) > 0
3583: 						THIS.img_4c_Produto.Picture = loc_cArqTemp
3584: 						THIS.img_4c_Produto.Visible = .T.

*-- Linhas 3604 a 3715:
3604: 	* Themes=.T. + DisabledPicture obrigatorios em standalone com Picture
3605: 	* (regra CLAUDE.md - sem isso o icone some quando Enabled=.F.).
3606: 	*==========================================================================
3607: 	PROTECTED PROCEDURE ConfigurarBotoesItens()
3608: 		LOCAL loc_lPodeEditar
3609: 		loc_lPodeEditar = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
3610: 
3611: 		THIS.AddObject("cmd_4c_IncluirLinha", "CommandButton")
3612: 		WITH THIS.cmd_4c_IncluirLinha
3613: 			.Top            = 3
3614: 			.Left           = 700
3615: 			.Height         = 75
3616: 			.Width          = 75
3617: 			.FontBold       = .T.
3618: 			.FontItalic     = .T.
3619: 			.FontName       = "Comic Sans MS"
3620: 			.FontSize       = 8
3621: 			.WordWrap       = .F.
3622: 			.Caption        = "Inserir Linha"
3623: 			.ToolTipText    = "Inserir linha"
3624: 			.PicturePosition = 13
3625: 			.ForeColor      = RGB(90, 90, 90)
3626: 			.BackColor      = RGB(255, 255, 255)
3627: 			.Themes         = .T.
3628: 			.Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
3629: 			.DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
3630: 			.Enabled        = loc_lPodeEditar
3631: 			.Visible        = .T.
3632: 		ENDWITH
3633: 		BINDEVENT(THIS.cmd_4c_IncluirLinha, "Click", THIS, "BtnIncluirLinhaClick")
3634: 
3635: 		THIS.AddObject("cmd_4c_ExcluirLinha", "CommandButton")
3636: 		WITH THIS.cmd_4c_ExcluirLinha
3637: 			.Top            = 3
3638: 			.Left           = 775
3639: 			.Height         = 75
3640: 			.Width          = 75
3641: 			.FontBold       = .T.
3642: 			.FontItalic     = .T.
3643: 			.FontName       = "Comic Sans MS"
3644: 			.FontSize       = 8
3645: 			.Caption        = "Excluir"
3646: 			.ToolTipText    = "Exclui linha"
3647: 			.ForeColor      = RGB(90, 90, 90)
3648: 			.BackColor      = RGB(255, 255, 255)
3649: 			.Themes         = .T.
3650: 			.Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
3651: 			.DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
3652: 			.Enabled        = loc_lPodeEditar
3653: 			.Visible        = .T.
3654: 		ENDWITH
3655: 		BINDEVENT(THIS.cmd_4c_ExcluirLinha, "Click", THIS, "BtnExcluirLinhaClick")
3656: 	ENDPROC
3657: 
3658: 	*==========================================================================
3659: 	* BtnIncluirLinhaClick - legado SIGOPORC.btnIncluir.Click. Insere uma
3660: 	* linha em branco IMEDIATAMENTE DEPOIS do item corrente, renumerando
3661: 	* Citens/Citem2/Citem3/CitAgrs de todas as linhas seguintes (igual ao
3662: 	* legado). Transcrito 1-para-1 na parte que opera so sobre a grade de
3663: 	* itens (cursor_4c_Itens).
3664: 	*
3665: 	* FICA PARA FASE POSTERIOR (precisa de cursor_4c_Parcelas/SigOpCdd/
3666: 	* LocalEmp, ainda nao carregados nesta fase):
3667: 	*   - renumeracao espelhada em crSigMvOrp (parcelas do item deslocado);
3668: 	*   - ramo de decupagem (SigOpCdd.ConfigGers) e copia de percentuais
3669: 	*     default do cabecalho quando LocalEmp.DivNotas = 2 (P&G).
3670: 	* A persistencia em SQL (BO.Inserir) acontece so no fechamento/
3671: 	* confirmacao do dialogo (fase propria) - igual ao legado, que so
3672: 	* grava a grade inteira ao sair ("Zap In crTpmMvItn ... Insert into
3673: 	* crTpmMvItn from Memvar").
3674: 	*==========================================================================
3675: 	PROCEDURE BtnIncluirLinhaClick()
3676: 		LOCAL loc_cCursor, loc_nItem, loc_nItem2, loc_nItem3, loc_nItAgr, loc_cBloco
3677: 
3678: 		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
3679: 			RETURN
3680: 		ENDIF
3681: 
3682: 		loc_cCursor = THIS.this_oBusinessObject.this_cCursorItens
3683: 		IF !USED(loc_cCursor)
3684: 			RETURN
3685: 		ENDIF
3686: 
3687: 		SELECT (loc_cCursor)
3688: 		IF EOF() OR INLIST(ALLTRIM(NVL(cblocos, "")), "SUBTOTAL", "BRANCO", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL")
3689: 			RETURN
3690: 		ENDIF
3691: 
3692: 		THIS.LockScreen = .T.
3693: 
3694: 		loc_nItem  = citens
3695: 		loc_nItem2 = citem2
3696: 		loc_nItem3 = citem3
3697: 		loc_nItAgr = citagrs
3698: 		loc_cBloco = cblocos
3699: 
3700: 		*-- Legado: "Select crSigMvOrc / Set Order To" ANTES do Scan - sem
3701: 		*-- remover a ordem controladora, atualizar a propria chave (Citens)
3702: 		*-- durante o Scan faria o VFP reprocessar/pular registros.
3703: 		SET ORDER TO
3704: 		SCAN FOR citens > loc_nItem
3705: 			REPLACE citem3 WITH IIF(citem3 = loc_nItem3, citem3, citem3 + 1), ;
3706: 				citem2 WITH IIF(citem2 = loc_nItem2, citem2, citem2 + 1), ;
3707: 				citens WITH citens + 1, ;
3708: 				citagrs WITH IIF(EMPTY(citagrs) OR citagrs = loc_nItAgr, citagrs, citagrs + 1)
3709: 		ENDSCAN
3710: 
3711: 		APPEND BLANK
3712: 		REPLACE citens WITH loc_nItem + 1, citem2 WITH loc_nItem2, citem3 WITH loc_nItem3, ;
3713: 			cblocos WITH loc_cBloco, taxas WITH .T.
3714: 
3715: 		SET ORDER TO TAG citens

*-- Linhas 3732 a 3775:
3732: 	* nao carregados): renumeracao espelhada em crSigMvOrp e a troca de TAG
3733: 	* de ordenacao (Citens x CitenCria) conforme modo Criacao.
3734: 	*==========================================================================
3735: 	PROCEDURE BtnExcluirLinhaClick()
3736: 		LOCAL loc_cCursor, loc_nItem, loc_nItem2, loc_nItem3, loc_nItAgr, loc_nTotalItens
3737: 
3738: 		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
3739: 			RETURN
3740: 		ENDIF
3741: 
3742: 		loc_cCursor = THIS.this_oBusinessObject.this_cCursorItens
3743: 		IF !USED(loc_cCursor)
3744: 			RETURN
3745: 		ENDIF
3746: 
3747: 		SELECT (loc_cCursor)
3748: 		IF EOF() OR INLIST(ALLTRIM(NVL(cblocos, "")), "SUBTOTAL", "BRANCO", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL")
3749: 			RETURN
3750: 		ENDIF
3751: 
3752: 		THIS.LockScreen = .T.
3753: 
3754: 		IF citens = citem2
3755: 			*-- Cabecalho de BLOCO ou SUB-BLOCO
3756: 			loc_nItem  = citens
3757: 			loc_nItem2 = citem2
3758: 			loc_nItem3 = citem3
3759: 
3760: 			IF loc_nItem = loc_nItem2 AND loc_nItem = loc_nItem3
3761: 				*-- BLOCO: so apaga se nao houver NENHUM item real dentro dele
3762: 				SELECT COUNT(1) AS nitem FROM (loc_cCursor) ;
3763: 					WHERE citem3 = loc_nItem3 ;
3764: 					AND !INLIST(ALLTRIM(NVL(cblocos, "")), "SUBTOTAL", "BRANCO", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL") ;
3765: 					AND !EMPTY(cpros) ;
3766: 					GROUP BY citem3 INTO CURSOR cursor_4c_TmpBloco
3767: 
3768: 				IF !USED("cursor_4c_TmpBloco") OR cursor_4c_TmpBloco.nitem = 0
3769: 					SELECT COUNT(1) AS nitem FROM (loc_cCursor) WHERE citem3 = loc_nItem3 INTO CURSOR cursor_4c_TmpBloco
3770: 					loc_nTotalItens = cursor_4c_TmpBloco.nitem
3771: 
3772: 					SELECT (loc_cCursor)
3773: 					DELETE FOR citem3 = loc_nItem3 ;
3774: 						AND !INLIST(ALLTRIM(NVL(cblocos, "")), "BRANCO", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL")
3775: 

*-- Linhas 3821 a 4183:
3821: 
3822: 			IF !EMPTY(vlbaixas)
3823: 				THIS.LockScreen = .F.
3824: 				MsgAviso("Item possui parcela j" + CHR(225) + " autorizada!", "Imposs" + CHR(237) + "vel excluir")
3825: 				RETURN
3826: 			ENDIF
3827: 
3828: 			DELETE FOR citens = loc_nItem
3829: 
3830: 			SET ORDER TO
3831: 			SCAN FOR citens > loc_nItem
3832: 				REPLACE citem3 WITH IIF(citem3 = loc_nItem3, citem3, citem3 - 1), ;
3833: 					citem2 WITH IIF(citem2 = loc_nItem2, citem2, citem2 - 1), ;
3834: 					citens WITH citens - 1, ;
3835: 					citagrs WITH IIF(EMPTY(citagrs) OR citagrs = loc_nItem, 0, citagrs - 1)
3836: 			ENDSCAN
3837: 
3838: 			SET ORDER TO TAG citens
3839: 			= SEEK(loc_nItem)
3840: 		ENDIF
3841: 
3842: 		THIS.grd_4c_Itens.Refresh()
3843: 		THIS.LockScreen = .F.
3844: 		THIS.grd_4c_Itens.Column1.SetFocus()
3845: 	ENDPROC
3846: 
3847: 	*==========================================================================
3848: 	* ConfigurarBotoesPrincipais - Fase 7/8: os botoes de ACAO do rodape que
3849: 	* faltavam (btnIteSub/btnTotItens/btnInsBlo/btnInsSub/btnCadPro/OK do
3850: 	* legado). Posicao/Picture/Caption/ToolTipText TRANSCRITOS do dump
3851: 	* ("PROPRIEDADES DE: SIGOPORC.<nome>"). Mesma familia visual dos botoes
3852: 	* de linha ja criados em ConfigurarBotoesItens (Comic Sans MS, ForeColor
3853: 	* RGB(90,90,90), Themes=.T.+DisabledPicture - regra do standalone com
3854: 	* Picture).
3855: 	*
3856: 	* obj_4c_OK (CommandGroup, ButtonCount=1) e o unico botao de COMANDO DE
3857: 	* GRUPO desta tela - o legado usa commandgroup so para herdar o
3858: 	* comportamento de Cancel=.T. (ESC fecha o dialogo). BINDEVENT vai no
3859: 	* proprio Buttons(1) (regra: WITH .Buttons(N) DENTRO do WITH que abre o
3860: 	* grupo e seguro).
3861: 	*
3862: 	* btnTotItens NAO tem PROCEDURE When no dump (fica sempre habilitado,
3863: 	* mesmo em CONSULTAR - ver totais nao exige direito de edicao); os
3864: 	* demais repetem o guard INSERIR/ALTERAR ja usado pelos outros botoes de
3865: 	* acao desta tela. cmd_4c_CadPro nasce Enabled=.F. - o estado real
3866: 	* depende da linha corrente (AtualizarEstadoCadastroProduto, chamado
3867: 	* pelo AfterRowColChange e pelo CarregarDados).
3868: 	*==========================================================================
3869: 	PROTECTED PROCEDURE ConfigurarBotoesPrincipais()
3870: 		LOCAL loc_lPodeEditar
3871: 		loc_lPodeEditar = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
3872: 
3873: 		THIS.AddObject("cmd_4c_TotItens", "CommandButton")
3874: 		WITH THIS.cmd_4c_TotItens
3875: 			.Top             = 3
3876: 			.Left            = 400
3877: 			.Height          = 75
3878: 			.Width           = 75
3879: 			.FontBold        = .T.
3880: 			.FontItalic      = .T.
3881: 			.FontName        = "Comic Sans MS"
3882: 			.FontSize        = 8
3883: 			.WordWrap        = .T.
3884: 			.Caption         = "Total"
3885: 			.ToolTipText     = "Total"
3886: 			.PicturePosition = 13
3887: 			.ForeColor       = RGB(90, 90, 90)
3888: 			.BackColor       = RGB(255, 255, 255)
3889: 			.Themes          = .T.
3890: 			.Picture         = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
3891: 			.DisabledPicture = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
3892: 			.Enabled         = .T.
3893: 			.Visible         = .T.
3894: 		ENDWITH
3895: 		BINDEVENT(THIS.cmd_4c_TotItens, "Click", THIS, "BtnTotalItensClick")
3896: 
3897: 		THIS.AddObject("cmd_4c_IteSub", "CommandButton")
3898: 		WITH THIS.cmd_4c_IteSub
3899: 			.Top             = 3
3900: 			.Left            = 475
3901: 			.Height          = 75
3902: 			.Width           = 75
3903: 			.FontBold        = .T.
3904: 			.FontItalic      = .T.
3905: 			.FontName        = "Comic Sans MS"
3906: 			.FontSize        = 8
3907: 			.WordWrap        = .T.
3908: 			.Caption         = "Itens Subn" + CHR(237) + "vel"
3909: 			.ToolTipText     = ""
3910: 			.PicturePosition = 13
3911: 			.ForeColor       = RGB(90, 90, 90)
3912: 			.BackColor       = RGB(255, 255, 255)
3913: 			.Themes          = .T.
3914: 			.Picture         = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
3915: 			.DisabledPicture = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
3916: 			.Enabled         = loc_lPodeEditar
3917: 			.Visible         = .T.
3918: 		ENDWITH
3919: 		BINDEVENT(THIS.cmd_4c_IteSub, "Click", THIS, "BtnItensSubnivelClick")
3920: 
3921: 		THIS.AddObject("cmd_4c_InsBlo", "CommandButton")
3922: 		WITH THIS.cmd_4c_InsBlo
3923: 			.Top             = 3
3924: 			.Left            = 550
3925: 			.Height          = 75
3926: 			.Width           = 75
3927: 			.FontBold        = .T.
3928: 			.FontItalic      = .T.
3929: 			.FontName        = "Comic Sans MS"
3930: 			.FontSize        = 8
3931: 			.WordWrap        = .F.
3932: 			.Caption         = "Inserir Bloco"
3933: 			.ToolTipText     = "Inserir linha"
3934: 			.PicturePosition = 13
3935: 			.ForeColor       = RGB(90, 90, 90)
3936: 			.BackColor       = RGB(255, 255, 255)
3937: 			.Themes          = .T.
3938: 			.Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
3939: 			.DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
3940: 			.Enabled         = loc_lPodeEditar
3941: 			.Visible         = .T.
3942: 		ENDWITH
3943: 		BINDEVENT(THIS.cmd_4c_InsBlo, "Click", THIS, "BtnInserirBlocoClick")
3944: 
3945: 		THIS.AddObject("cmd_4c_InsSub", "CommandButton")
3946: 		WITH THIS.cmd_4c_InsSub
3947: 			.Top             = 3
3948: 			.Left            = 625
3949: 			.Height          = 75
3950: 			.Width           = 75
3951: 			.FontBold        = .T.
3952: 			.FontItalic      = .T.
3953: 			.FontName        = "Comic Sans MS"
3954: 			.FontSize        = 8
3955: 			.WordWrap        = .T.
3956: 			.Caption         = "Inserir Sub-bloco"
3957: 			.ToolTipText     = "Inserir linha"
3958: 			.PicturePosition = 13
3959: 			.ForeColor       = RGB(90, 90, 90)
3960: 			.BackColor       = RGB(255, 255, 255)
3961: 			.Themes          = .T.
3962: 			.Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
3963: 			.DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
3964: 			.Enabled         = loc_lPodeEditar
3965: 			.Visible         = .T.
3966: 		ENDWITH
3967: 		BINDEVENT(THIS.cmd_4c_InsSub, "Click", THIS, "BtnInserirSubBlocoClick")
3968: 
3969: 		THIS.AddObject("cmd_4c_CadPro", "CommandButton")
3970: 		WITH THIS.cmd_4c_CadPro
3971: 			.Top             = 3
3972: 			.Left            = 850
3973: 			.Height          = 75
3974: 			.Width           = 75
3975: 			.FontBold        = .T.
3976: 			.FontItalic      = .T.
3977: 			.FontName        = "Comic Sans MS"
3978: 			.FontSize        = 8
3979: 			.WordWrap        = .T.
3980: 			.Caption         = "Cadastro de Produtos"
3981: 			.ToolTipText     = "Cadastro de Produtos"
3982: 			.PicturePosition = 13
3983: 			.ForeColor       = RGB(90, 90, 90)
3984: 			.BackColor       = RGB(255, 255, 255)
3985: 			.Themes          = .T.
3986: 			.Picture         = gc_4c_CaminhoIcones + "geral_produtos_60.jpg"
3987: 			.DisabledPicture = gc_4c_CaminhoIcones + "geral_produtos_60.jpg"
3988: 			.Enabled         = .F.
3989: 			.Visible         = .T.
3990: 		ENDWITH
3991: 		BINDEVENT(THIS.cmd_4c_CadPro, "Click", THIS, "BtnCadastroProdutoClick")
3992: 
3993: 		THIS.AddObject("obj_4c_OK", "CommandGroup")
3994: 		WITH THIS.obj_4c_OK
3995: 			.ButtonCount = 1
3996: 			.Top         = -2
3997: 			.Left        = 920
3998: 			.Height      = 85
3999: 			.Width       = 85
4000: 			.BackStyle   = 0
4001: 			.BorderStyle = 0
4002: 			.Themes      = .T.
4003: 			WITH .Buttons(1)
4004: 				.Top             = 5
4005: 				.Left            = 5
4006: 				.Height          = 75
4007: 				.Width           = 75
4008: 				.FontBold        = .T.
4009: 				.FontItalic      = .T.
4010: 				.FontName        = "Comic Sans MS"
4011: 				.FontSize        = 8
4012: 				.WordWrap        = .T.
4013: 				.Cancel          = .T.
4014: 				.Caption         = "Retornar"
4015: 				.ToolTipText     = "[Esc] Voltar Para a Tela Principal da Opera" + CHR(231) + CHR(227) + "o"
4016: 				.PicturePosition = 13
4017: 				.ForeColor       = RGB(90, 90, 90)
4018: 				.BackColor       = RGB(255, 255, 255)
4019: 				.Themes          = .T.
4020: 				.Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
4021: 				.DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
4022: 			ENDWITH
4023: 			.Visible = .T.
4024: 		ENDWITH
4025: 		BINDEVENT(THIS.obj_4c_OK.Buttons(1), "Click", THIS, "BtnSalvarClick")
4026: 	ENDPROC
4027: 
4028: 	*==========================================================================
4029: 	* BtnSalvarClick - legado SIGOPORC.OK.btnSair.Click. Fora do modo
4030: 	* CONSULTAR, valida (percentuais de NF/incentivo <= 100%, previsao de
4031: 	* pagamento completa, decupagem com previsao batendo com o Real) e, se
4032: 	* tudo passar, APAGA as linhas em branco e GRAVA cada linha remanescente
4033: 	* no SQL Server.
4034: 	*
4035: 	* DIFERENCA ARQUITETURAL DOCUMENTADA: o legado acumula tudo num cursor
4036: 	* intermediario do FORM PAI (crTpmMvItn) e EXCLUI os marcadores de
4037: 	* bloco/subtotal dessa lista - a gravacao real em lote e feita pelo
4038: 	* pai, em outro momento. Esta migracao grava CADA linha direto no SQL
4039: 	* Server, sem cursor intermediario nem form pai para delegar o lote;
4040: 	* por isso TODAS as linhas remanescentes (inclusive marcadores) sao
4041: 	* persistidas aqui - sem isso, a estrutura de blocos/subtotais do
4042: 	* orcamento se perderia a cada vez que o dialogo fosse reaberto.
4043: 	*
4044: 	* Falha de gravacao NUNCA fecha o dialogo em silencio (regra #20/#1):
4045: 	* BO.Inserir/Atualizar ja exibem o erro; o loc_lContinuar=.F. so evita
4046: 	* chamadas em cascata e mantem o dialogo aberto para o usuario tentar
4047: 	* de novo.
4048: 	*==========================================================================
4049: 	PROCEDURE BtnSalvarClick()
4050: 		LOCAL loc_cItens, loc_cParcelas, loc_lContinuar, loc_oErro, loc_nItem, ;
4051: 			loc_cDpros, loc_lItemOk, loc_cSQL, loc_nResultado, loc_cChaveNova, ;
4052: 			loc_cPkChaveNova
4053: 
4054: 		*-- Legado: fora de INSERIR/ALTERAR o Click pula TODO o bloco de
4055: 		*-- validacao/gravacao e cai direto em "ThisForm.release()" - e
4056: 		*-- exatamente o que BtnCancelarClick faz (saida sem persistir).
4057: 		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
4058: 			THIS.BtnCancelarClick()
4059: 			RETURN
4060: 		ENDIF
4061: 
4062: 		loc_cItens    = THIS.this_oBusinessObject.this_cCursorItens
4063: 		loc_cParcelas = THIS.this_oBusinessObject.this_cCursorParcelas
4064: 
4065: 		IF !USED(loc_cItens) OR !USED(loc_cParcelas)
4066: 			THIS.BtnCancelarClick()
4067: 			RETURN
4068: 		ENDIF
4069: 
4070: 		*-- TELA -> BO antes de qualquer validacao/gravacao: no legado os 5
4071: 		*-- percentuais do topo chegavam ao cabecalho sozinhos (ControlSource
4072: 		*-- = TprMvCab.<coluna>); aqui a transferencia e manual e passa por
4073: 		*-- FormParaBO (ver cabecalho dele).
4074: 		IF !THIS.FormParaBO()
4075: 			RETURN
4076: 		ENDIF
4077: 
4078: 		loc_lContinuar = .T.
4079: 
4080: 		TRY
4081: 			*-- Legado: as validacoes abaixo SO correm fora do modo P&G
4082: 			*-- (LocalEmp.DivNotas <> 2)
4083: 			IF THIS.this_oBusinessObject.this_nDivNotas <> 2
4084: 				SELECT (loc_cItens)
4085: 				SET ORDER TO TAG citens
4086: 				GO TOP
4087: 				LOCATE FOR perc2s + perc3s > 100
4088: 				IF FOUND()
4089: 					MsgAviso("Existe item com percentual de NF maior que 100%.", "Aviso")
4090: 					THIS.grd_4c_Itens.Column25.SetFocus()
4091: 					loc_lContinuar = .F.
4092: 				ENDIF
4093: 
4094: 				IF loc_lContinuar
4095: 					SELECT (loc_cItens)
4096: 					GO TOP
4097: 					LOCATE FOR perc4s + perc5s + perc6s > 100
4098: 					IF FOUND()
4099: 						MsgAviso("Existe item com percentual de incentivos maior que 100%.", "Aviso")
4100: 						THIS.grd_4c_Itens.Column22.SetFocus()
4101: 						loc_lContinuar = .F.
4102: 					ENDIF
4103: 				ENDIF
4104: 
4105: 				IF loc_lContinuar
4106: 					*-- Previsao de pagamento incompleta - varre TODAS as
4107: 					*-- parcelas (nao so as do item corrente): desliga o SET
4108: 					*-- KEY temporariamente e restaura no final.
4109: 					SELECT (loc_cParcelas)
4110: 					SET ORDER TO TAG citens
4111: 					SET KEY TO
4112: 					GO TOP
4113: 					SCAN
4114: 						IF !(EMPTY(ifors) AND EMPTY(percs) AND EMPTY(datas)) AND ;
4115: 								(EMPTY(ifors) OR EMPTY(percs) OR EMPTY(datas))
4116: 							loc_nItem  = citens
4117: 							loc_cDpros = ""
4118: 							IF SEEK(loc_nItem, loc_cItens, "citens")
4119: 								loc_cDpros = ALLTRIM(TratarNulo(EVALUATE(loc_cItens + ".dpros"), ""))
4120: 							ENDIF
4121: 							MsgAviso("Existe previs" + CHR(227) + "o de pagamento no item '" + ;
4122: 								loc_cDpros + "' incompleta.", "Aviso")
4123: 							loc_lContinuar = .F.
4124: 							EXIT
4125: 						ENDIF
4126: 					ENDSCAN
4127: 					THIS.PosicionarParcelasDoItem()
4128: 				ENDIF
4129: 
4130: 				IF loc_lContinuar AND INT(VAL(SUBSTR(THIS.this_oBusinessObject.this_cConfigGers, 192, 1))) = 1
4131: 					IF USED("cursor_4c_TmpTotPrev")
4132: 						USE IN cursor_4c_TmpTotPrev
4133: 					ENDIF
4134: 					SELECT a.citens, a.dpros, (a.tota7s + a.tota8s) AS totreal, ;
4135: 							SUM(NVL(b.valos, 0)) AS totprev ;
4136: 						FROM (loc_cItens) a LEFT JOIN (loc_cParcelas) b ON a.citens = b.citens ;
4137: 						WHERE !EMPTY(a.cpros) ;
4138: 						GROUP BY a.citens, a.dpros, 3 ;
4139: 						HAVING totreal > 0 AND (ISNULL(totprev) OR totprev <> totreal) ;
4140: 						INTO CURSOR cursor_4c_TmpTotPrev
4141: 
4142: 					IF USED("cursor_4c_TmpTotPrev") AND RECCOUNT("cursor_4c_TmpTotPrev") > 0
4143: 						MsgAviso("Existe previs" + CHR(227) + "o de pagamento no item '" + ;
4144: 							ALLTRIM(cursor_4c_TmpTotPrev.dpros) + "' " + CHR(13) + ;
4145: 							"n" + CHR(227) + "o informada ou com valor diferente do Real Custos Internos + Real Fornecedor", ;
4146: 							"Aviso")
4147: 						THIS.grd_4c_Itens.Column1.SetFocus()
4148: 						loc_lContinuar = .F.
4149: 					ENDIF
4150: 
4151: 					IF USED("cursor_4c_TmpTotPrev")
4152: 						USE IN cursor_4c_TmpTotPrev
4153: 					ENDIF
4154: 				ENDIF
4155: 			ENDIF
4156: 
4157: 			IF loc_lContinuar
4158: 				*-- Legado: "Delete For Empty(Dpros) And Citens<>Citem2 And cBlocos<>[BRANCO]"
4159: 				SELECT (loc_cItens)
4160: 				DELETE FOR EMPTY(dpros) AND citens <> citem2 AND ALLTRIM(cblocos) <> "BRANCO"
4161: 
4162: 				*-- Legado: "Delete For Empty(Ifors) And Empty(Percs) And Empty(Datas)"
4163: 				SELECT (loc_cParcelas)
4164: 				SET KEY TO
4165: 				DELETE FOR EMPTY(ifors) AND EMPTY(percs) AND EMPTY(datas)
4166: 
4167: 				*-- Persiste TODOS os itens remanescentes (ver nota da
4168: 				*-- diferenca arquitetural no cabecalho do metodo)
4169: 				SELECT (loc_cItens)
4170: 				SET ORDER TO TAG citens
4171: 				GO TOP
4172: 				SCAN
4173: 					THIS.this_oBusinessObject.CarregarDoCursor(loc_cItens)
4174: 					THIS.this_oBusinessObject.this_cEmps  = THIS.this_cEmps
4175: 					THIS.this_oBusinessObject.this_cDopes = THIS.this_cDopes
4176: 					THIS.this_oBusinessObject.this_nNumes = THIS.this_nNumes
4177: 
4178: 					IF EMPTY(ALLTRIM(NVL(THIS.this_oBusinessObject.this_cCidchaves, "")))
4179: 						loc_lItemOk = THIS.this_oBusinessObject.Inserir()
4180: 					ELSE
4181: 						loc_lItemOk = THIS.this_oBusinessObject.Atualizar()
4182: 					ENDIF
4183: 

*-- Linhas 4266 a 4351:
4266: 		CATCH TO loc_oErro
4267: 			MsgErro(loc_oErro.Message + CHR(13) + ;
4268: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4269: 				"Procedure: " + loc_oErro.Procedure, ;
4270: 				"Erro em Formsigoporc.BtnSalvarClick")
4271: 			loc_lContinuar = .F.
4272: 		ENDTRY
4273: 
4274: 		IF !loc_lContinuar
4275: 			THIS.PosicionarParcelasDoItem()
4276: 			THIS.grd_4c_Parcelas.Refresh()
4277: 			THIS.grd_4c_Itens.Refresh()
4278: 			RETURN
4279: 		ENDIF
4280: 
4281: 		*-- Legado: "ThisForm.ParentForm.totite = fTotalizarItn(...)" +
4282: 		*-- "ThisForm.ParentForm.atuatot()" - best-effort: o form de
4283: 		*-- cabecalho do Orcamento pode nao ter esse metodo ainda (fora do
4284: 		*-- escopo desta task) - a chamada so acontece se o metodo existir,
4285: 		*-- para nao impedir o fechamento do dialogo.
4286: 		IF VARTYPE(THIS.this_oFormPai) = "O"
4287: 			IF PEMSTATUS(THIS.this_oFormPai, "AtualizarTotaisOrcamento", 5)
4288: 				THIS.this_oFormPai.AtualizarTotaisOrcamento()
4289: 			ENDIF
4290: 		ENDIF
4291: 
4292: 		THIS.Release()
4293: 	ENDPROC
4294: 
4295: 	*==========================================================================
4296: 	* BtnInserirBlocoClick - legado SIGOPORC.btnInsBlo.Click. Insere um novo
4297: 	* BLOCO (par de linhas: cabecalho + SUBTOTAL) IMEDIATAMENTE DEPOIS do
4298: 	* subtotal do bloco atual (ou depois do item corrente, se o bloco ainda
4299: 	* nao tiver subtotal), renumerando Citens/Citem2/Citem3 de tudo que vem
4300: 	* depois (igual ao legado) e espelhando a renumeracao nas parcelas do
4301: 	* item deslocado (cursor_4c_Parcelas, via o mesmo truque de negativar/
4302: 	* voltar ao positivo que evita colisao de chave durante o SCAN).
4303: 	*
4304: 	* NAO PORTADO: o ramo "Inlist(crSigCdOpe.DigItens,6,7)" do legado insere
4305: 	* sub-itens lendo crSigOpCdI.JOB_MV_BLO - a tabela SigOpCdI NAO EXISTE
4306: 	* no schema canonico (docs\schema.sql, regra #14 - zero ocorrencias,
4307: 	* nao e falso-negativo de encoding). Sem a fonte de dados, esse ramo e
4308: 	* impossivel de transcrever; o bloco sempre nasce com as 2 linhas
4309: 	* (cabecalho + SUBTOTAL), igual ao caso "nao-Criacao" do legado.
4310: 	*==========================================================================
4311: 	PROCEDURE BtnInserirBlocoClick()
4312: 		LOCAL loc_cItens, loc_cParcelas, loc_nItem, loc_nItem2, loc_nItem3, ;
4313: 			loc_cBloco, loc_nItAnt, loc_oErro
4314: 
4315: 		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
4316: 			RETURN
4317: 		ENDIF
4318: 
4319: 		loc_cItens    = THIS.this_oBusinessObject.this_cCursorItens
4320: 		loc_cParcelas = THIS.this_oBusinessObject.this_cCursorParcelas
4321: 
4322: 		IF !USED(loc_cItens) OR EOF(loc_cItens)
4323: 			RETURN
4324: 		ENDIF
4325: 
4326: 		SELECT (loc_cItens)
4327: 		IF INLIST(ALLTRIM(NVL(cblocos, "")), "SUBTOTAL", "BRANCO", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL")
4328: 			RETURN
4329: 		ENDIF
4330: 
4331: 		THIS.LockScreen = .T.
4332: 
4333: 		TRY
4334: 			SET ORDER TO TAG citens
4335: 
4336: 			loc_nItem  = IIF(EMPTY(citens), 0, citens)
4337: 			loc_nItem2 = IIF(EMPTY(citem2), 0, citem2)
4338: 			loc_nItem3 = IIF(EMPTY(citem3), 0, citem3)
4339: 			loc_cBloco = cblocos
4340: 
4341: 			SELECT MAX(citens) AS citens FROM (loc_cItens) WHERE citem3 = loc_nItem3 INTO CURSOR cursor_4c_TmpSub
4342: 			IF USED("cursor_4c_TmpSub") AND !EOF("cursor_4c_TmpSub") AND !EMPTY(cursor_4c_TmpSub.citens)
4343: 				IF SEEK(cursor_4c_TmpSub.citens, loc_cItens, "citens")
4344: 					loc_nItem  = EVALUATE(loc_cItens + ".citens")
4345: 					loc_nItem2 = EVALUATE(loc_cItens + ".citem2")
4346: 					loc_nItem3 = EVALUATE(loc_cItens + ".citem3")
4347: 					loc_cBloco = ""
4348: 				ENDIF
4349: 			ENDIF
4350: 			IF USED("cursor_4c_TmpSub")
4351: 				USE IN cursor_4c_TmpSub

*-- Linhas 4405 a 4466:
4405: 		CATCH TO loc_oErro
4406: 			MsgErro(loc_oErro.Message + CHR(13) + ;
4407: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4408: 				"Procedure: " + loc_oErro.Procedure, ;
4409: 				"Erro em Formsigoporc.BtnInserirBlocoClick")
4410: 		ENDTRY
4411: 
4412: 		THIS.grd_4c_Itens.Refresh()
4413: 		THIS.grd_4c_Parcelas.Refresh()
4414: 		THIS.LockScreen = .F.
4415: 		THIS.grd_4c_Itens.Column1.SetFocus()
4416: 	ENDPROC
4417: 
4418: 	*==========================================================================
4419: 	* BtnInserirSubBlocoClick - legado SIGOPORC.btnInsSub.Click. Mesma ideia
4420: 	* de BtnInserirBlocoClick, mas agrupando por SUB-BLOCO (Citem2) dentro
4421: 	* do bloco atual (Citem3) - desloca so +2 (cabecalho + SUBTOTAL do
4422: 	* sub-bloco), sem o +2 extra de JOB_MV_BLO que so existe no modo
4423: 	* Criacao - nao portado pelo mesmo motivo de BtnInserirBlocoClick
4424: 	* (SigOpCdI nao existe no schema).
4425: 	*==========================================================================
4426: 	PROCEDURE BtnInserirSubBlocoClick()
4427: 		LOCAL loc_cItens, loc_cParcelas, loc_nItem, loc_nItem2, loc_nItem3, ;
4428: 			loc_cBloco, loc_nItAnt, loc_oErro
4429: 
4430: 		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
4431: 			RETURN
4432: 		ENDIF
4433: 
4434: 		loc_cItens    = THIS.this_oBusinessObject.this_cCursorItens
4435: 		loc_cParcelas = THIS.this_oBusinessObject.this_cCursorParcelas
4436: 
4437: 		IF !USED(loc_cItens) OR EOF(loc_cItens)
4438: 			RETURN
4439: 		ENDIF
4440: 
4441: 		SELECT (loc_cItens)
4442: 		IF INLIST(ALLTRIM(NVL(cblocos, "")), "SUBTOTAL", "BRANCO", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL")
4443: 			RETURN
4444: 		ENDIF
4445: 
4446: 		THIS.LockScreen = .T.
4447: 
4448: 		TRY
4449: 			SET ORDER TO TAG citens
4450: 
4451: 			loc_nItem  = IIF(EMPTY(citens), 0, citens)
4452: 			loc_nItem2 = IIF(EMPTY(citem2), 0, citem2)
4453: 			loc_nItem3 = IIF(EMPTY(citem3), 0, citem3)
4454: 			loc_cBloco = cblocos
4455: 
4456: 			SELECT MAX(citens) AS citens FROM (loc_cItens) ;
4457: 				WHERE citem3 = loc_nItem3 AND citem2 = loc_nItem2 AND ALLTRIM(cblocos) == "SUBTOTAL" ;
4458: 				INTO CURSOR cursor_4c_TmpSub
4459: 			IF USED("cursor_4c_TmpSub") AND !EOF("cursor_4c_TmpSub") AND !EMPTY(cursor_4c_TmpSub.citens)
4460: 				IF SEEK(cursor_4c_TmpSub.citens, loc_cItens, "citens")
4461: 					loc_nItem  = EVALUATE(loc_cItens + ".citens")
4462: 					loc_nItem2 = EVALUATE(loc_cItens + ".citem2")
4463: 					loc_nItem3 = EVALUATE(loc_cItens + ".citem3")
4464: 					loc_cBloco = ""
4465: 				ENDIF
4466: 			ENDIF

*-- Linhas 4522 a 4740:
4522: 		CATCH TO loc_oErro
4523: 			MsgErro(loc_oErro.Message + CHR(13) + ;
4524: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4525: 				"Procedure: " + loc_oErro.Procedure, ;
4526: 				"Erro em Formsigoporc.BtnInserirSubBlocoClick")
4527: 		ENDTRY
4528: 
4529: 		THIS.grd_4c_Itens.Refresh()
4530: 		THIS.grd_4c_Parcelas.Refresh()
4531: 		THIS.LockScreen = .F.
4532: 		THIS.grd_4c_Itens.Column1.SetFocus()
4533: 	ENDPROC
4534: 
4535: 	*==========================================================================
4536: 	* BtnItensSubnivelClick / BtnTotalItensClick - legado SIGOPORC.btnIteSub/
4537: 	* btnTotItens.Click ("ThisForm.Enabled = .f. / Do Form SigOpTor With
4538: 	* ThisForm, ThisForm.DataSessionId[, 'I']"). SigOpTor e um dialogo
4539: 	* LEGADO SEPARADO (detalhe de itens em subnivel / totalizacao) que
4540: 	* NUNCA foi migrado para este projeto (sem task propria, sem
4541: 	* FormSigOpTor em nenhuma pasta de forms).
4542: 	*
4543: 	* NAO E POSSIVEL abrir algo que nao existe. Em vez de inventar um
4544: 	* dialogo substituto (violaria o PILAR 2/3 - arquitetura e
4545: 	* comportamento fabricados, sem fonte no legado) ou fingir sucesso
4546: 	* silenciosamente, o clique avisa explicitamente que a funcionalidade
4547: 	* depende de uma migracao propria (SigOpTor) ainda nao feita - mesmo
4548: 	* espirito do wrapper "NAO PORTADA" ja documentado no projeto (regra
4549: 	* #27), aqui para um FORM em vez de uma funcao global.
4550: 	*==========================================================================
4551: 	PROCEDURE BtnItensSubnivelClick()
4552: 		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
4553: 			RETURN
4554: 		ENDIF
4555: 		THIS.AvisarSigOpTorPendente("I")
4556: 	ENDPROC
4557: 
4558: 	PROCEDURE BtnTotalItensClick()
4559: 		THIS.AvisarSigOpTorPendente("")
4560: 	ENDPROC
4561: 
4562: 	*==========================================================================
4563: 	* AvisarSigOpTorPendente - ver cabecalho de BtnItensSubnivelClick/
4564: 	* BtnTotalItensClick. par_cModo = "I" (Itens em Subnivel) ou ""
4565: 	* (Total de Itens) - equivale ao 3o parametro do "Do Form SigOpTor" do
4566: 	* legado, sem uso aqui alem de escolher a mensagem.
4567: 	*==========================================================================
4568: 	PROTECTED PROCEDURE AvisarSigOpTorPendente(par_cModo)
4569: 		MsgAviso("Esta funcionalidade depende do dialogo SigOpTor (" + ;
4570: 			IIF(EMPTY(par_cModo), "Total de Itens", "Itens em Subn" + CHR(237) + "vel") + ;
4571: 			"), que ainda n" + CHR(227) + "o foi migrado para o sistema novo.", ;
4572: 			"Funcionalidade pendente")
4573: 	ENDPROC
4574: 
4575: 	*==========================================================================
4576: 	* BtnCadastroProdutoClick - legado SIGOPORC.btnCadPro.Click. Resolve o
4577: 	* fornecedor padrao (conta de origem/destino conforme SigCdOpe.Opers/
4578: 	* Origems/Destinos) e o grupo do produto novo (do item corrente, se ja
4579: 	* tiver Cpros, ou de txt_4c_NovoGrupo), igual ao legado.
4580: 	*
4581: 	* ESCOPO REDUZIDO, DOCUMENTADO: o legado abre SigCdPro.Scx com SETE
4582: 	* parametros posicionais e RECEBE de volta o codigo do produto criado
4583: 	* na MESMA chamada ("Do Form ... To lcCodProduto"), para em seguida
4584: 	* rodar uma cascata de precificacao automatica (SigCdOpe.PrecoAuts/
4585: 	* PrecoPs) e preencher o item sozinho. FormProduto (CRUD ja migrado em
4586: 	* task propria) usa o padrao de Init PADRAO do projeto (sem
4587: 	* parametros, sem retorno sincrono) - mudar a assinatura de
4588: 	* FormProduto para aceitar esse contrato extenderia o escopo desta
4589: 	* task (781) para dentro da task de FormProduto.
4590: 	*
4591: 	* Por isso: valida o guard (igual ao legado), resolve e mostra o
4592: 	* grupo/fornecedor, abre FormProduto em modo INCLUIR normal e - depois
4593: 	* do form fechar - pede ao usuario para digitar o codigo do produto
4594: 	* recem-cadastrado no campo da grade (aciona ValidarProdutoItemKeyPress/
4595: 	* AbrirBuscaProdutoItem, ja existentes da Fase 6). A cascata de
4596: 	* precificacao automatica NAO RODA neste fluxo - o lookup normal
4597: 	* preenche Dpros/Cunis/CuniPs, mas nao a moeda/preco automatico que so
4598: 	* o retorno sincrono do legado disparava.
4599: 	*==========================================================================
4600: 	PROCEDURE BtnCadastroProdutoClick()
4601: 		LOCAL loc_cItens, loc_cCodFornec, loc_cGrupo, loc_cSQL, loc_nResultado, loc_oForm, loc_oErro
4602: 
4603: 		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
4604: 			RETURN
4605: 		ENDIF
4606: 
4607: 		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
4608: 		IF !USED(loc_cItens) OR EOF(loc_cItens)
4609: 			RETURN
4610: 		ENDIF
4611: 
4612: 		loc_cCodFornec = ""
4613: 		IF THIS.this_oBusinessObject.this_nOpers = 1 AND THIS.this_oBusinessObject.this_nOrigems = 1
4614: 			loc_cCodFornec = THIS.this_oBusinessObject.this_cContaOs
4615: 		ELSE
4616: 			IF THIS.this_oBusinessObject.this_nOpers = 2 AND THIS.this_oBusinessObject.this_nDestinos = 1
4617: 				loc_cCodFornec = THIS.this_oBusinessObject.this_cContaDs
4618: 			ELSE
4619: 				IF THIS.this_oBusinessObject.this_nOrigems = 1
4620: 					loc_cCodFornec = THIS.this_oBusinessObject.this_cContaOs
4621: 				ELSE
4622: 					IF THIS.this_oBusinessObject.this_nDestinos = 1
4623: 						loc_cCodFornec = THIS.this_oBusinessObject.this_cContaDs
4624: 					ENDIF
4625: 				ENDIF
4626: 			ENDIF
4627: 		ENDIF
4628: 
4629: 		IF !INLIST(THIS.this_oBusinessObject.this_nCadProds, 0, 2)
4630: 			SELECT (loc_cItens)
4631: 			IF EMPTY(cpros) AND EMPTY(THIS.txt_4c_NovoGrupo.Value)
4632: 				MsgAviso("Informe o grupo de produto para ser cadastrado!", "Aviso")
4633: 				IF THIS.txt_4c_NovoGrupo.Enabled
4634: 					THIS.txt_4c_NovoGrupo.SetFocus()
4635: 				ENDIF
4636: 				RETURN
4637: 			ENDIF
4638: 
4639: 			TRY
4640: 				loc_cGrupo = ""
4641: 				IF !EMPTY(cpros)
4642: 					IF USED("cursor_4c_TmpGruPro")
4643: 						USE IN cursor_4c_TmpGruPro
4644: 					ENDIF
4645: 					loc_cSQL = "SELECT Cgrus FROM SigCdPro WHERE cpros = " + EscaparSQL(cpros)
4646: 					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpGruPro")
4647: 					IF loc_nResultado > 0 AND USED("cursor_4c_TmpGruPro") AND RECCOUNT("cursor_4c_TmpGruPro") > 0
4648: 						loc_cGrupo = ALLTRIM(TratarNulo(cursor_4c_TmpGruPro.Cgrus, ""))
4649: 					ENDIF
4650: 					IF USED("cursor_4c_TmpGruPro")
4651: 						USE IN cursor_4c_TmpGruPro
4652: 					ENDIF
4653: 				ELSE
4654: 					loc_cGrupo = ALLTRIM(THIS.txt_4c_NovoGrupo.Value)
4655: 				ENDIF
4656: 
4657: 				MsgInfo("Grupo de produto: " + loc_cGrupo + CHR(13) + ;
4658: 					"Fornecedor padr" + CHR(227) + "o: " + loc_cCodFornec + CHR(13) + CHR(13) + ;
4659: 					"Ap" + CHR(243) + "s cadastrar, digite o c" + CHR(243) + "digo do produto novo no item da grade.", ;
4660: 					"Cadastro de Produtos")
4661: 
4662: 				GarantirClasse("FormProduto")
4663: 				loc_oForm = CREATEOBJECT("FormProduto")
4664: 				IF VARTYPE(loc_oForm) = "O"
4665: 					loc_oForm.Show()
4666: 				ENDIF
4667: 			CATCH TO loc_oErro
4668: 				MsgErro(loc_oErro.Message, "Erro em Formsigoporc.BtnCadastroProdutoClick")
4669: 			ENDTRY
4670: 		ENDIF
4671: 
4672: 		THIS.grd_4c_Itens.Column1.SetFocus()
4673: 	ENDPROC
4674: 
4675: 	*==========================================================================
4676: 	* CarregarLista - FUNIL de RECARGA das duas grades a partir do banco.
4677: 	* PUBLIC de proposito (o harness TesteAutomatico.prg chama metodos de
4678: 	* carga de FORA da classe, e PROTECTED estouraria "Property
4679: 	* CARREGARLISTA is not found" - regra #3).
4680: 	*
4681: 	* Equivale ao par AddCursor('SigMvOrc',...)/AddCursor('SigMvOrp',...)
4682: 	* do Init legado toda vez que ele e reexecutado: le de novo SigMvOrc/
4683: 	* SigMvOrp (BO.CarregarItens/CarregarParcelas, que usam cursor
4684: 	* temporario + ZAP + APPEND FROM DBF - nunca SQLEXEC direto no alias do
4685: 	* Grid), revincula as duas grades, reposiciona e repinta.
4686: 	*
4687: 	* PRESERVA A LINHA CORRENTE: guarda o Citens do item em que o usuario
4688: 	* estava e faz SEEK depois da recarga - sem isso toda recarga jogaria o
4689: 	* usuario de volta para o primeiro item. Cai em GO TOP quando a linha
4690: 	* nao existe mais (ex.: item recem-excluido) ou na primeira carga.
4691: 	*
4692: 	* O SET KEY do mestre-detalhe (PosicionarParcelasDoItem) e DESFEITO
4693: 	* antes da recarga e reposto depois: com filtro pendurado, a releitura
4694: 	* das parcelas enxergaria so a fatia do item corrente.
4695: 	*
4696: 	* Fecha com THIS.Refresh() + Refresh() das duas grades porque popular
4697: 	* cursor NAO repinta a grade ligada a ele, e trocar ordem/chave do
4698: 	* alias tampouco (regra #21).
4699: 	*==========================================================================
4700: 	PROCEDURE CarregarLista()
4701: 		LOCAL loc_lSucesso, loc_oErro, loc_cItens, loc_cParcelas, ;
4702: 			loc_nItemAtual, loc_lAchou, loc_lModoValidacaoOuTeste
4703: 		loc_lSucesso = .F.
4704: 		loc_lModoValidacaoOuTeste = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
4705: 			(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
4706: 
4707: 		TRY
4708: 			loc_cItens    = THIS.this_oBusinessObject.this_cCursorItens
4709: 			loc_cParcelas = THIS.this_oBusinessObject.this_cCursorParcelas
4710: 
4711: 			*-- Linha corrente, para reposicionar depois da recarga
4712: 			loc_nItemAtual = 0
4713: 			IF USED(loc_cItens) AND !EOF(loc_cItens)
4714: 				loc_nItemAtual = EVALUATE(loc_cItens + ".citens")
4715: 			ENDIF
4716: 
4717: 			IF USED(loc_cParcelas)
4718: 				SELECT (loc_cParcelas)
4719: 				SET KEY TO
4720: 			ENDIF
4721: 
4722: 			*-- Pulado em validacao de UI / modo teste: sem conexao SQL real
4723: 			*-- (os cursores existem, so ficam vazios - mesma decisao do
4724: 			*-- CarregarDados desde a Fase 4).
4725: 			IF !loc_lModoValidacaoOuTeste
4726: 				THIS.this_oBusinessObject.CarregarItens()
4727: 				THIS.this_oBusinessObject.CarregarParcelas()
4728: 			ENDIF
4729: 
4730: 			*-- ZAP + APPEND FROM preserva estrutura/RecordSource/
4731: 			*-- CurrentControl, mas Width e Header1.Caption se perdem a cada
4732: 			*-- (re)atribuicao de RecordSource (regra #41) - os dois
4733: 			*-- Vincular* reaplicam tudo e sao idempotentes.
4734: 			THIS.VincularGradeItens()
4735: 			THIS.VincularGradeParcelas()
4736: 
4737: 			loc_lAchou = .F.
4738: 			IF USED(loc_cItens)
4739: 				SELECT (loc_cItens)
4740: 				SET ORDER TO TAG citens

*-- Linhas 4749 a 4800:
4749: 			THIS.PosicionarParcelasDoItem()
4750: 			THIS.AtualizarEstadoCadastroProduto()
4751: 
4752: 			THIS.Refresh()
4753: 			THIS.grd_4c_Itens.Refresh()
4754: 			THIS.grd_4c_Parcelas.Refresh()
4755: 
4756: 			loc_lSucesso = USED(loc_cItens)
4757: 		CATCH TO loc_oErro
4758: 			MsgErro(loc_oErro.Message + CHR(13) + ;
4759: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4760: 				"Procedure: " + loc_oErro.Procedure, ;
4761: 				"Erro em Formsigoporc.CarregarLista")
4762: 		ENDTRY
4763: 
4764: 		RETURN loc_lSucesso
4765: 	ENDPROC
4766: 
4767: 	*==========================================================================
4768: 	* NumeroDoCampo - coercao defensiva de .Value de TextBox para NUMERICO.
4769: 	* Os 5 campos de percentual nascem com .Value = 0 (numerico), mas o
4770: 	* valor pode voltar como CARACTERE quando o usuario digita num campo
4771: 	* com Format/InputMask e o VFP devolve a string da mascara - e ai
4772: 	* qualquer aritmetica estoura "Operator/operand type mismatch". Mesma
4773: 	* defesa ja usada em TotalizarItn para os campos do topo.
4774: 	*==========================================================================
4775: 	PROTECTED FUNCTION NumeroDoCampo(par_uValor)
4776: 		LOCAL loc_nValor
4777: 		loc_nValor = 0
4778: 
4779: 		DO CASE
4780: 			CASE VARTYPE(par_uValor) = "N"
4781: 				loc_nValor = par_uValor
4782: 			CASE VARTYPE(par_uValor) = "C"
4783: 				loc_nValor = VAL(ALLTRIM(par_uValor))
4784: 			CASE VARTYPE(par_uValor) = "L"
4785: 				loc_nValor = IIF(par_uValor, 1, 0)
4786: 		ENDCASE
4787: 
4788: 		RETURN loc_nValor
4789: 	ENDFUNC
4790: 
4791: 	*==========================================================================
4792: 	* FormParaBO - TELA -> BO. Transfere os campos que sao do DIALOGO (nao
4793: 	* da grade) para as properties do Business Object, e carrega nele o
4794: 	* item da linha corrente da grade.
4795: 	*
4796: 	* No legado esses 5 campos tem ControlSource apontando para o cursor de
4797: 	* CABECALHO do form PAI (conferido um a um no dump):
4798: 	*   getPtax2    -> TprMvCab.ptax2s  -> this_nPTax2s  (Contingente/Perc1s)
4799: 	*   getPtaxa    -> TprMvCab.descs   -> this_nDescs   (Taxa Adm./Lucro, Perc2s)
4800: 	*   getPTax1    -> TprMvCab.ptax1s  -> this_nPTax1s  (BV/Perc3s)

*-- Linhas 4850 a 4967:
4850: 		CATCH TO loc_oErro
4851: 			MsgErro(loc_oErro.Message + CHR(13) + ;
4852: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4853: 				"Procedure: " + loc_oErro.Procedure, ;
4854: 				"Erro em Formsigoporc.FormParaBO")
4855: 			loc_lSucesso = .F.
4856: 		ENDTRY
4857: 
4858: 		RETURN loc_lSucesso
4859: 	ENDFUNC
4860: 
4861: 	*==========================================================================
4862: 	* BOParaForm - BO -> TELA. Espelha nos 5 campos de percentual os valores
4863: 	* que o BO leu de SigMvCab em CarregarConfiguracao (acres/ptax1s/
4864: 	* ptax2s/ptax3s/descs), que no legado chegavam sozinhos pelo
4865: 	* ControlSource = TprMvCab.<coluna>.
4866: 	*
4867: 	* Fase 8/8 - SEM ESTE METODO os 5 campos abriam SEMPRE em 0,00, mesmo
4868: 	* com o cabecalho do orcamento tendo percentuais gravados: nada no
4869: 	* form lia essas properties do BO. Alem de exibir errado, isso
4870: 	* contaminava o calculo - os handlers Txt*KeyPress aplicam o valor do
4871: 	* CAMPO em perc1s..perc6s de cada item, entao o primeiro Enter num
4872: 	* campo zerado zeraria o percentual de todos os itens.
4873: 	*
4874: 	* Nao toca txt_4c_Margem (resultado calculado por TotalizarItn, ver
4875: 	* FormParaBO) nem a grade: os itens/parcelas vem por CarregarLista.
4876: 	*==========================================================================
4877: 	FUNCTION BOParaForm()
4878: 		LOCAL loc_lSucesso, loc_oErro
4879: 		loc_lSucesso = .F.
4880: 
4881: 		IF VARTYPE(THIS.this_oBusinessObject) <> "O"
4882: 			RETURN .F.
4883: 		ENDIF
4884: 
4885: 		TRY
4886: 			THIS.txt_4c_Contingente.Value    = THIS.NumeroDoCampo(THIS.this_oBusinessObject.this_nPTax2s)
4887: 			THIS.txt_4c_TaxaAdm.Value        = THIS.NumeroDoCampo(THIS.this_oBusinessObject.this_nDescs)
4888: 			THIS.txt_4c_BV.Value             = THIS.NumeroDoCampo(THIS.this_oBusinessObject.this_nPTax1s)
4889: 			THIS.txt_4c_Imposto.Value        = THIS.NumeroDoCampo(THIS.this_oBusinessObject.this_nAcres)
4890: 			THIS.txt_4c_ImpostoServico.Value = THIS.NumeroDoCampo(THIS.this_oBusinessObject.this_nPTax3s)
4891: 
4892: 			loc_lSucesso = .T.
4893: 		CATCH TO loc_oErro
4894: 			MsgErro(loc_oErro.Message + CHR(13) + ;
4895: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4896: 				"Procedure: " + loc_oErro.Procedure, ;
4897: 				"Erro em Formsigoporc.BOParaForm")
4898: 		ENDTRY
4899: 
4900: 		RETURN loc_lSucesso
4901: 	ENDFUNC
4902: 
4903: 	*==========================================================================
4904: 	* HabilitarCampos - centraliza o .Enabled dos CAMPOS do dialogo (os
4905: 	* botoes ficam em AjustarBotoesPorModo). Transcreve os "When" do dump:
4906: 	*
4907: 	*   getPtax2/getPtaxa/getPTax1/getPimposto/getPservico/get_NewGrp
4908: 	*                 -> Inlist(thisform.Op_Escolha,[INSERIR],[ALTERAR])
4909: 	*   getPmargem    -> Return .f.            (NUNCA editavel)
4910: 	*   getDpros/getDpro2s -> Return thisform.lProcura
4911: 	*   getDescritivo -> Inlist(Op_Escolha,[INSERIR],[ALTERAR]) And
4912: 	*                    <linha normal> And Empty(VlBaixas)
4913: 	*
4914: 	* par_lHabilitar e OPCIONAL: omitido, o estado sai do MODO do dialogo
4915: 	* (o que o legado faz nos When). Passado, forca os campos editaveis -
4916: 	* usado pelo harness e por quem precisa travar a tela durante uma
4917: 	* operacao longa. PCOUNT() distingue "nao passou" de "passou .F."
4918: 	* (VARTYPE de logico e "L" nos dois casos).
4919: 	*
4920: 	* .Enabled no lugar de .ReadOnly reproduz o efeito do When (campo nao
4921: 	* alcancavel por Tab nem por clique) sem inventar estado novo. As
4922: 	* CELULAS das duas grades seguem o ReadOnly por coluna aplicado em
4923: 	* ConfigurarGridItens/ConfigurarGradeParcelas (cada Column tem o seu
4924: 	* proprio When no legado, e varias admitem CONSULTAR) - nao sao
4925: 	* mexidas aqui.
4926: 	*==========================================================================
4927: 	PROCEDURE HabilitarCampos(par_lHabilitar)
4928: 		LOCAL loc_lPodeEditar, loc_lModoCriacao
4929: 
4930: 		IF PCOUNT() >= 1 AND VARTYPE(par_lHabilitar) = "L"
4931: 			loc_lPodeEditar = par_lHabilitar
4932: 		ELSE
4933: 			loc_lPodeEditar = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
4934: 		ENDIF
4935: 
4936: 		loc_lModoCriacao = INLIST(THIS.this_oBusinessObject.this_nDigItens, 6, 7)
4937: 
4938: 		*-- Percentuais editaveis (When = Inlist(Op_Escolha,INSERIR,ALTERAR))
4939: 		THIS.txt_4c_Contingente.Enabled    = loc_lPodeEditar
4940: 		THIS.txt_4c_TaxaAdm.Enabled        = loc_lPodeEditar
4941: 		THIS.txt_4c_BV.Enabled             = loc_lPodeEditar
4942: 		THIS.txt_4c_Imposto.Enabled        = loc_lPodeEditar
4943: 		THIS.txt_4c_ImpostoServico.Enabled = loc_lPodeEditar
4944: 
4945: 		*-- getPmargem.When = .f. - resultado calculado, nunca digitado
4946: 		THIS.txt_4c_Margem.Enabled = .F.
4947: 
4948: 		*-- get_NewGrp (When = Inlist(Op_Escolha,INSERIR,ALTERAR)). O ramo
4949: 		*-- CadProds = 4 do AfterRowColChange legado refina isso por linha
4950: 		*-- (AtualizarEstadoCadastroProduto), por isso ele roda depois.
4951: 		THIS.txt_4c_NovoGrupo.Enabled = loc_lPodeEditar
4952: 
4953: 		*-- getDpros/getDpro2s.When = thisform.lProcura (o par so abre
4954: 		*-- quando btnProcura entra em modo de busca). Em modo Criacao os
4955: 		*-- dois nem aparecem na tela (AtualizarModoCriacao).
4956: 		THIS.txt_4c_ProcuraDpros.Enabled  = loc_lPodeEditar AND THIS.this_lProcura AND !loc_lModoCriacao
4957: 		THIS.edt_4c_ProcuraDpro2s.Enabled = loc_lPodeEditar AND THIS.this_lProcura AND !loc_lModoCriacao
4958: 
4959: 		*-- getDescritivo: so existe no modo Criacao e so edita em
4960: 		*-- INSERIR/ALTERAR (o refino por linha - linha normal e
4961: 		*-- Empty(VlBaixas) - fica no When da propria coluna da grade,
4962: 		*-- igual ao legado)
4963: 		THIS.edt_4c_DescritivoRodape.Enabled = loc_lPodeEditar AND loc_lModoCriacao
4964: 
4965: 		*-- Refino por LINHA do botao/campo de cadastro de produto
4966: 		THIS.AtualizarEstadoCadastroProduto()
4967: 	ENDPROC

*-- Linhas 4986 a 5195:
4986: 	* btnExcluirp e btnProcura) NAO recebem .Enabled = .F.: com Caption
4987: 	* vazio o VFP9 deixa de desenhar o Picture e o botao vira um retangulo
4988: 	* vazio (regra do CorretorAutomatico #106). Para esses tres o "When"
4989: 	* virou guarda no inicio do proprio handler - BINDEVENT descarta o
4990: 	* retorno do delegate, entao um When ligado por BINDEVENT nao
4991: 	* bloquearia nada mesmo.
4992: 	*
4993: 	* PUBLIC de proposito: o harness chama AjustarBotoesPorModo de FORA da
4994: 	* classe (regra #3 - PEMSTATUS devolve .T. tambem para metodo
4995: 	* PROTECTED, entao a chamada compila e estoura em runtime).
4996: 	*==========================================================================
4997: 	PROCEDURE AjustarBotoesPorModo()
4998: 		LOCAL loc_lPodeEditar
4999: 		loc_lPodeEditar = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
5000: 
5001: 		*-- Botoes de linha da grade de itens
5002: 		THIS.cmd_4c_IncluirLinha.Enabled = loc_lPodeEditar
5003: 		THIS.cmd_4c_ExcluirLinha.Enabled = loc_lPodeEditar
5004: 
5005: 		*-- Botoes de estrutura (bloco / sub-bloco) e navegacao de subnivel
5006: 		THIS.cmd_4c_InsBlo.Enabled = loc_lPodeEditar
5007: 		THIS.cmd_4c_InsSub.Enabled = loc_lPodeEditar
5008: 		THIS.cmd_4c_IteSub.Enabled = loc_lPodeEditar
5009: 
5010: 		*-- btnTotItens e o OK nao tem When no legado
5011: 		THIS.cmd_4c_TotItens.Enabled = .T.
5012: 		THIS.obj_4c_OK.Enabled       = .T.
5013: 
5014: 		*-- btnCadPro depende do modo E da linha corrente: quem resolve as
5015: 		*-- duas coisas (incluindo CadProds/fChecaAcesso) e o metodo de
5016: 		*-- refino, que ja trata cursor ausente/EOF.
5017: 		THIS.AtualizarEstadoCadastroProduto()
5018: 	ENDPROC
5019: 
5020: 	*==========================================================================
5021: 	* LimparCampos - devolve os campos do DIALOGO ao estado de abertura.
5022: 	*
5023: 	* Nao ha "novo registro" neste form: o legado SIGOPORC nao tem botao
5024: 	* Incluir de CABECALHO (o Incluir dele e de LINHA da grade, ver
5025: 	* BtnIncluirLinhaClick) - o dialogo sempre edita os itens de UM
5026: 	* orcamento que ja existe. Entao LimparCampos NAO zera as grades: os
5027: 	* itens/parcelas pertencem ao orcamento, nao a um registro em digitacao
5028: 	* (zerar seria perda silenciosa de dado). O que ele limpa e exatamente
5029: 	* o estado AUXILIAR da tela, o mesmo que o legado reseta ao trocar de
5030: 	* linha (AfterRowColChange) e ao ligar o modo de busca (btnProcura):
5031: 	*   - a linha de busca (getDpros/getDpro2s) e a flag lProcura
5032: 	*   - o campo de grupo novo (get_NewGrp)
5033: 	*   - a pre-visualizacao da foto do produto (imgProds)
5034: 	*   - os valores anteriores usados pelos Valid (antdpros/oldpreco) e o
5035: 	*     canal de retorno dos lookups
5036: 	* Os 5 percentuais voltam ao que o BO leu do cabecalho (BOParaForm), nao
5037: 	* a zero - zerar inventaria valor e, no primeiro Enter num deles,
5038: 	* zeraria o percentual de todos os itens.
5039: 	*==========================================================================
5040: 	PROCEDURE LimparCampos()
5041: 		LOCAL loc_oErro
5042: 
5043: 		TRY
5044: 			*-- Linha de busca + flag do botao de duas fases
5045: 			THIS.this_lProcura = .F.
5046: 			THIS.txt_4c_ProcuraDpros.Value  = ""
5047: 			THIS.edt_4c_ProcuraDpro2s.Value = ""
5048: 
5049: 			*-- Grupo do produto novo (legado: AfterRowColChange zera
5050: 			*-- Get_NewGrp.Value quando CadProds = 4)
5051: 			THIS.txt_4c_NovoGrupo.Value = ""
5052: 
5053: 			*-- Foto do produto (legado: imgProds.Visible = .f. /
5054: 			*-- imgProds.Picture = [] no topo do AfterRowColChange)
5055: 			THIS.img_4c_Produto.Visible = .F.
5056: 			THIS.img_4c_Produto.Picture = ""
5057: 
5058: 			*-- Valores anteriores comparados pelos Valid e canal de retorno
5059: 			*-- dos metodos AbrirBusca*
5060: 			THIS.this_cAntDpros        = ""
5061: 			THIS.this_nOldPreco        = 0
5062: 			THIS.this_lAutPreco        = .F.
5063: 			THIS.this_cLookupCodigo    = ""
5064: 			THIS.this_cLookupDescricao = ""
5065: 
5066: 			*-- Percentuais voltam ao valor do cabecalho, nao a zero
5067: 			THIS.BOParaForm()
5068: 
5069: 			*-- Reaplica Visible/Enabled (a flag lProcura mudou). O proprio
5070: 			*-- AtualizarModoCriacao fecha chamando HabilitarCampos e
5071: 			*-- AjustarBotoesPorModo.
5072: 			THIS.AtualizarModoCriacao()
5073: 		CATCH TO loc_oErro
5074: 			MsgErro(loc_oErro.Message + CHR(13) + ;
5075: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
5076: 				"Procedure: " + loc_oErro.Procedure, ;
5077: 				"Erro em Formsigoporc.LimparCampos")
5078: 		ENDTRY
5079: 	ENDPROC
5080: 
5081: 	*==========================================================================
5082: 	* BtnCancelarClick - FUNIL de ABANDONO: fecha o dialogo SEM persistir
5083: 	* nada e devolve o controle ao form pai.
5084: 	*
5085: 	* O SIGOPORC legado NAO TEM botao de abandono - o CommandGroup "OK" e
5086: 	* o unico botao de saida (ButtonCount = 1 no dump) e nenhum objeto do
5087: 	* SCX tem Caption/Picture de Cancelar. Por isso aqui NAO se cria botao
5088: 	* nenhum (inventar um violaria o PILAR 1): este metodo e o CAMINHO que
5089: 	* o legado ja percorre quando o dialogo esta em CONSULTAR - o
5090: 	* OK.btnSair.Click pula todo o bloco "If Inlist(op_escolha,[INSERIR],
5091: 	* [ALTERAR])" e cai direto em "ThisForm.release()", sem gravar nada.
5092: 	* BtnSalvarClick delega a ele exatamente nesse ramo, para o caminho de
5093: 	* saida sem gravacao existir num lugar so.
5094: 	*
5095: 	* Fechar os dois cursores aqui e o que DESCARTA as edicoes em memoria:
5096: 	* eles sao LOCAIS do dialogo (CREATE CURSOR em CriarCursorItens/
5097: 	* CriarCursorParcelas), nao aliases emprestados do chamador, e a
5098: 	* persistencia acontece unicamente em BtnSalvarClick - reabrir o
5099: 	* dialogo depois disso le tudo de novo de SigMvOrc/SigMvOrp. O SET KEY
5100: 	* do mestre-detalhe sai antes, para nao deixar filtro pendurado.
5101: 	*
5102: 	* NAO pede confirmacao: o legado nao pergunta nada em nenhum caminho de
5103: 	* saida, e inventar um dialogo de confirmacao mudaria a UX (PILAR 1).
5104: 	*==========================================================================
5105: 	PROCEDURE BtnCancelarClick()
5106: 		LOCAL loc_oErro, loc_cItens, loc_cParcelas
5107: 
5108: 		TRY
5109: 			IF VARTYPE(THIS.this_oBusinessObject) = "O"
5110: 				loc_cItens    = THIS.this_oBusinessObject.this_cCursorItens
5111: 				loc_cParcelas = THIS.this_oBusinessObject.this_cCursorParcelas
5112: 
5113: 				IF USED(loc_cParcelas)
5114: 					SELECT (loc_cParcelas)
5115: 					SET KEY TO
5116: 					USE IN (loc_cParcelas)
5117: 				ENDIF
5118: 
5119: 				IF USED(loc_cItens)
5120: 					USE IN (loc_cItens)
5121: 				ENDIF
5122: 			ENDIF
5123: 		CATCH TO loc_oErro
5124: 			MsgErro(loc_oErro.Message + CHR(13) + ;
5125: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
5126: 				"Procedure: " + loc_oErro.Procedure, ;
5127: 				"Erro em Formsigoporc.BtnCancelarClick")
5128: 		ENDTRY
5129: 
5130: 		*-- Devolve o controle ao pai (legado: "Procedure Unload" -
5131: 		*-- ThisForm.Parentform.Enabled = .t.). Destroy repete isso para
5132: 		*-- cobrir tambem o fechamento pela barra de janela; as duas
5133: 		*-- atribuicoes sao idempotentes.
5134: 		IF VARTYPE(THIS.this_oFormPai) = "O"
5135: 			IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
5136: 				THIS.this_oFormPai.Enabled = .T.
5137: 			ENDIF
5138: 		ENDIF
5139: 
5140: 		THIS.Release()
5141: 	ENDPROC
5142: 
5143: 	*==========================================================================
5144: 	* Destroy - Devolve o controle ao form pai (legado: "Procedure Unload" -
5145: 	* ThisForm.Parentform.Enabled = .t., desfazendo o ThisForm.Enabled = .f.
5146: 	* que o pai aplica antes de abrir este dialogo) e solta a referencia,
5147: 	* para o dialogo filho nao manter vivo quem o abriu.
5148: 	*
5149: 	* DODEFAULT() na ULTIMA linha e obrigatorio: e o FormBase.Destroy que
5150: 	* libera o Business Object e reconstroi os popups do menu principal.
5151: 	*
5152: 	* O "Procedure Load" do legado (=fConfigGeral()) fica de fora pela mesma
5153: 	* decisao ja documentada em FormSigOpEnt.prg/FormSIGPRMEI.prg: fConfigGeral
5154: 	* era funcao GLOBAL do legado (sig.prg/SIGFUNCS.PRG) que nao veio no
5155: 	* acervo; o wrapper NO-OP em projeto\app\utils\fconfiggeral.prg existe so
5156: 	* para o p-code dos VCX legado continuar resolvendo o nome, e em codigo
5157: 	* NOSSO nunca se chama fConfigGeral.
5158: 	*==========================================================================
5159: 	PROCEDURE Destroy()
5160: 		LOCAL loc_oErro
5161: 
5162: 		TRY
5163: 			IF VARTYPE(THIS.this_oFormPai) = "O"
5164: 				IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
5165: 					THIS.this_oFormPai.Enabled = .T.
5166: 				ENDIF
5167: 			ENDIF
5168: 
5169: 			*-- Os dois cursores sao LOCAIS deste dialogo (CREATE CURSOR em
5170: 			*-- CriarCursorItens/CriarCursorParcelas), nao aliases emprestados
5171: 			*-- do chamador - por isso podem e devem ser fechados aqui. Antes
5172: 			*-- de fechar o de parcelas, desfaz o SET KEY aplicado por
5173: 			*-- PosicionarParcelasDoItem, para nao deixar filtro pendurado.
5174: 			IF VARTYPE(THIS.this_oBusinessObject) = "O"
5175: 				IF USED(THIS.this_oBusinessObject.this_cCursorParcelas)
5176: 					SELECT (THIS.this_oBusinessObject.this_cCursorParcelas)
5177: 					SET KEY TO
5178: 					USE IN (THIS.this_oBusinessObject.this_cCursorParcelas)
5179: 				ENDIF
5180: 
5181: 				IF USED(THIS.this_oBusinessObject.this_cCursorItens)
5182: 					USE IN (THIS.this_oBusinessObject.this_cCursorItens)
5183: 				ENDIF
5184: 			ENDIF
5185: 
5186: 			THIS.this_oFormPai = .NULL.
5187: 			THIS.this_oObjExt1 = .NULL.
5188: 		CATCH TO loc_oErro
5189: 			MsgErro(loc_oErro.Message, "Erro em Formsigoporc.Destroy")
5190: 		ENDTRY
5191: 
5192: 		DODEFAULT()
5193: 	ENDPROC
5194: 
5195: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigoporcBO.prg):
*====================================================================
* sigoporcBO.prg
*
* Business Object do dialogo OPERACIONAL "SIGOPORC" (grade de Itens de
* um Orcamento). O legado abre este form como filho do form de
* cabecalho do movimento (Lparameters poForm, pnDatSes - Set
* Datasession To pnDatSes, isto e, o filho passa a compartilhar a MESMA
* data session do pai, com os cursores crSigMvOrc/crSigMvOrp/TprMvCab/
* crSigCdOpe/LocalEmp ja abertos por ele).
*
* Tabelas envolvidas: SigMvOrc (itens do orcamento), SigMvOrp
* (parcelas/previsoes de pagamento do item), SigMvCab (cabecalho do
* movimento - espelhado no cursor temporario TprMvCab do pai), SigCdOpe
* (configuracao da operacao), SigCdEmp (configuracao da empresa).
*
* Referencias legado -> BO:
*   TprMvCab.Emps/Dopes/Numes/MascNum -> this_cEmps/this_cDopes/
*                                        this_nNumes/this_cMascNum
*   crSigCdOpe.DigItens/CadProds/Opers/Origems/Destinos/OpePads ->
*                                        this_nDigItens/this_nCadProds/
*                                        this_nOpers/this_nOrigems/
*                                        this_nDestinos/this_cOpePads
*   LocalEmp.DivNotas (CursorQuery de SigCdEmp) -> this_nDivNotas
*   TprMvCab.ContaOs/ContaDs -> this_cContaOs/this_cContaDs
*   TprMvCab.Acres/PTax1s/PTax2s/PTax3s/Descs -> this_nAcres/this_nPTax1s/
*                                          this_nPTax2s/this_nPTax3s/this_nDescs
*   SigOpCdd.ConfigGers -> this_cConfigGers
*   Thisform.Caption -> this_cCaption
*   crSigMvOrc (grade de itens) -> this_cCursorItens ("cursor_4c_Itens")
*   crSigMvOrp (grade de parcelas) -> this_cCursorParcelas
*                                     ("cursor_4c_Parcelas")
*
* Thisform.ParentForm, Thisform.poObjExt1 (referencia ao form externo de
* pesquisa de produtos SigOpCgp) e o controle de DataSession permanecem
* no FORM (sao referencias/estado de UI, fora da responsabilidade do
* Business Object).
*
* Herda de: BusinessBase
*
* Fase 1/8 - propriedades e Init(). A leitura de SigCdOpe/SigCdEmp
* (DigItens/CadProds/Opers/Origems/Destinos/OpePads/DivNotas) e as
* colunas de TprMvCab (ContaOs/ContaDs/Acres/PTax1s/PTax2s/PTax3s) serao
* carregadas por metodo proprio em fase posterior - os valores abaixo
* ficam com o default ate la.
*
* Fase 2/8 - CarregarDoCursor()/Inserir()/Atualizar()/ObterChavePrimaria()
* para o ITEM de SigMvOrc (chave cidchaves), com RegistrarAuditoria()
* (herdado de BusinessBase) chamado em Inserir/Atualizar. cidchaves e
* pkchaves sao as duas chaves Fortyus (fUniqueIds(), regra #22) geradas
* no Inserir quando ainda vazias. Buscar() nao e sobrescrito aqui: a
* listagem de itens (SELECT com joins de produto/unidade) fica na fase do
* BO que monta o cursor da grade (CarregarItens), porque a consulta tem
* joins e nao cabe no Buscar() generico herdado de BusinessBase.
*
* Fase 7/8 - CarregarConfiguracao() (SigCdOpe/SigCdEmp/SigOpCdd/SigMvCab,
* equivalentes aos cursores que o FORM PAI legado ja tinha abertos -
* regra #35/cabecalho acima), CarregarItens()/CarregarParcelas() (leitura
* de SigMvOrc/SigMvOrp para as duas grades - o legado faz isso via
* AddCursor no Init; aqui e feito por SQLEXEC em cursor temporario +
* ZAP/APPEND no cursor ja ligado ao Grid, regra "SQLEXEC sobre alias de
* grid zera o ColumnCount").
*
* Modo Criacao do legado (SigCdOpe.DigItens IN (6,7), com sub-blocos
* lidos de SigOpCdI.JOB_MV_BLO em btnInsBlo/btnInsSub) NAO E PORTADO: a
* tabela SigOpCdI NAO EXISTE no schema canonico (conferido em
* docs\schema.sql, regra #14 - zero ocorrencias, nao e falso-negativo de
* encoding). This_nDigItens continua sendo lido e comparado (para nao
* quebrar os outros ramos que dependem dele, como DigItens=5->CONSULTAR),
* mas o ramo exclusivo de DigItens IN (6,7) que insere sub-itens de
* JOB_MV_BLO fica de fora em btnInsBlo/btnInsSub, com o motivo documentado
* la (nao e omissao silenciosa - rule "SEMPRE FUNCIONALIDADE COMPLETA",
* mas a fonte de dados do legado para essa sub-feature nao existe mais).
*====================================================================

DEFINE CLASS sigoporcBO AS BusinessBase

	*-- Parametros recebidos do form pai na abertura do dialogo (legado:
	*-- Lparameters poForm, pnDatSes). O form migrado repassa so os
	*-- valores escalares que identificam o cabecalho do movimento
	*-- (TprMvCab/SigMvCab); poForm (referencia de UI) e a troca de
	*-- DataSession ficam no Form.
	this_cEmps = ""                 && Empresa do movimento (TprMvCab.Emps / SigMvCab.emps)
	this_cDopes = ""                && Documento de Operacao (TprMvCab.Dopes / SigMvCab.dopes)
	this_nNumes = 0                 && Numero do movimento (TprMvCab.Numes / SigMvCab.numes)
	this_cMascNum = ""              && Mascara/numero formatado do documento (TprMvCab.MascNum) - usado no Caption "Itens"

	*-- Configuracao da operacao (SigCdOpe), referente ao Dopes acima.
	*-- Controla ramos de negocio usados pelos botoes/grades desta tela.
	*-- Populados em fase posterior (leitura via SQLEXEC); default abaixo.
	this_nDigItens = 0              && SigCdOpe.DigItens - 5 forca modo CONSULTAR independente do pai (Op_Escolha)
	this_nCadProds = 0              && SigCdOpe.CadProds - habilita o botao "Cadastro de Produtos" (btnCadPro)
	this_nOpers = 0                 && SigCdOpe.Opers - 1=Entrada/2=Saida, usado para resolver o fornecedor padrao
	this_nOrigems = 0               && SigCdOpe.Origems - .T. quando a conta de origem (TprMvCab.ContaOs) e obrigatoria
	this_nDestinos = 0              && SigCdOpe.Destinos - .T. quando a conta de destino (TprMvCab.ContaDs) e obrigatoria
	this_cOpePads = ""              && SigCdOpe.OpePads - padrao de operacao usado no cadastro de produtos
	this_nImagems = 0               && SigCdOpe.Imagems - habilita a pre-visualizacao da foto do produto no AfterRowColChange (grdItem.imgProds)
	this_nConfes = 0                && SigCdOpe.Confes - quando = 1, suprime a pre-visualizacao mesmo com Imagems = 1
	this_nPrecoAuts = 0             && SigCdOpe.PrecoAuts - autoriza a precificacao automatica em btnCadPro.Click
	this_nPrecoPs = 0               && SigCdOpe.PrecoPs - origem do preco automatico (1/10=venda ou ideal, 2=custo, 5=valors, 7=ultima compra, 8/9=custo medio, 11=custo total)
	this_nPrecops = 0               && SigCdOpe.Precops - moeda/fator de venda(1) ou custo(2) a copiar do cadastro de produto
	this_cCMoes = ""                && SigCdOpe.CMoes - moeda padrao da operacao (fallback quando nao ha precificacao automatica)

	*-- Configuracao da empresa (SigCdEmp), lida via Cemps = this_cEmps
	*-- (legado: CursorQuery([SigCdEmp],[LocalEmp],[Cemps],TprMvCab.Emps,[DivNotas])).
	*-- Populada em fase posterior; default abaixo.
	this_nDivNotas = 0              && SigCdEmp.DivNotas - 1=Preco&Gerencial(P&G) / 2=SRCOM - decide a formula de rateio dos percentuais do item

	*-- Contas de origem/destino do cabecalho (TprMvCab/SigMvCab), usadas
	*-- em btnCadPro.Click para resolver o fornecedor do produto novo.
	*-- Populadas em fase posterior; default abaixo.
	this_cContaOs = ""              && Conta de Origem (TprMvCab.ContaOs)
	this_cContaDs = ""              && Conta de Destino (TprMvCab.ContaDs)

	*-- Percentuais/indices do cabecalho (TprMvCab/SigMvCab), usados como
	*-- semente dos campos de percentual do item recem-incluido.
	*-- Populados em fase posterior; default abaixo.
	this_nAcres = 0                 && TprMvCab.Acres - imposto cheio (usado quando o item NAO e servico)
	this_nPTax1s = 0                && TprMvCab.PTax1s - percentual default de BV (Perc3s)
	this_nPTax2s = 0                && TprMvCab.PTax2s - percentual default de despesa operacional/contingente (Perc1s)
	this_nPTax3s = 0                && TprMvCab.PTax3s - percentual default de imposto de servico (Perc4s quando Servicos)
	this_nDescs = 0                 && TprMvCab.Descs - percentual default de lucro/"Taxa Adm." (Perc2s)

	*-- Mascara de configuracoes gerais da operacao (SigOpCdd.ConfigGers),
	*-- lida via Dopes = this_cDopes. Posicao 192 (1 char) = flag de
	*-- Decupagem (Int(Val(Substr(ConfigGers,192,1))) = 1), usada em
	*-- TotalizarItn(). Populada em fase posterior; default "" faz a
	*-- checagem de Decupagem avaliar sempre .F. (SUBSTR/VAL de string
	*-- vazia devolve 0), que e o comportamento seguro ate a config
	*-- chegar.
	this_cConfigGers = ""
	this_nChkIfors = 0              && SigOpCdd.ChkIfors - 1/2 habilita a resolucao de preco por SigPrFnc (tabela de fornecedor) antes do padrao de SigCdMoe

	*-- Titulo montado para a tela (legado: Thisform.Caption)
	this_cCaption = ""              && "<Emps> <Dopes> <MascNum> - Itens"

	*-- Nomes dos cursores que este BO popula/consome (constantes, para o
	*-- Form referenciar sem repetir literais - equivalentes aos aliases
	*-- globais do legado crSigMvOrc/crSigMvOrp)
	this_cCursorItens = "cursor_4c_Itens"        && Grade de itens do orcamento (SigMvOrc)
	this_cCursorParcelas = "cursor_4c_Parcelas"  && Grade de parcelas/previsoes do item selecionado (SigMvOrp)

	*-- Propriedades da entidade (mapeamento 1-para-1 para a tabela SigMvOrc -
	*-- um ITEM da grade de orcamento, chave cidchaves). this_cEmps/
	*-- this_cDopes/this_nNumes acima (recebidos no Init) JA cobrem as
	*-- colunas emps/dopes/numes - nao duplicar.
	this_cCblocos    = ""   && cblocos char(30) - marcador de linha (SUBTOTAL/BRANCO/SUBTOTAIS/TAXA/TOTAL/IMPOSTO/TOTALGERAL ou vazio = item normal)
	this_nCitem2     = 0    && citem2 numeric(10,0) - item do bloco (subtotal pai)
	this_nCitens     = 0    && citens numeric(10,0) - numero do item (PK logica dentro do orcamento)
	this_cCpros      = ""   && cpros char(14) - codigo do produto
	this_cCunips     = ""   && cunips char(3) - unidade de compra/pedido
	this_cCunis      = ""   && cunis char(3) - unidade de venda
	this_cDpro2s     = ""   && dpro2s text NULL - descricao complementar do produto
	this_cDpros      = ""   && dpros char(65) - descricao do produto/bloco
	this_cEmpdopnums = ""   && empdopnums char(29) - Emps(3)+Dopes(20)+Str(Numes,6), chave posicional que liga o item ao cabecalho
	this_nFators     = 0    && fators numeric(8,4) - fator de conversao de unidade
	this_nPesos      = 0    && pesos numeric(8,4) - peso unitario
	this_cPkchaves   = ""   && pkchaves char(20) - chave unica Fortyus (fUniqueIds(), independente de cidchaves)
	this_nQtds       = 0    && qtds numeric(8,4) - quantidade
	this_nTotas      = 0    && totas numeric(13,2) - total do item
	this_nUnits      = 0    && units numeric(13,2) - valor unitario
	this_cCidchaves  = ""   && cidchaves char(20) - PK (fUniqueIds())
	this_cMoedas     = ""   && moedas char(3) - moeda do total de custo
	this_cMoefats    = ""   && moefats char(3) - moeda de faturamento
	this_cMoevs      = ""   && moevs char(3) - moeda de venda
	this_cNotas      = ""   && notas char(9) - numero/mascara da nota associada
	this_cObs        = ""   && obs text NULL - observacao do item
	this_cOpers      = ""   && opers char(1) - tipo de operacao do item (distinto de this_nOpers, que e config de SigCdOpe)
	this_nTota1s     = 0    && tota1s numeric(13,2) - despesa operacional (Perc1s)
	this_nTota2s     = 0    && tota2s numeric(13,2) - lucro (Perc2s)
	this_nTota3s     = 0    && tota3s numeric(13,2) - BV (Perc3s)
	this_nTota4s     = 0    && tota4s numeric(13,2) - imposto/servico (Perc4s)
	this_nTota5s     = 0    && tota5s numeric(13,2) - incentivo 1 (Perc5s)
	this_nTota6s     = 0    && tota6s numeric(13,2) - incentivo 2 (Perc6s)
	this_nTota7s     = 0    && tota7s numeric(13,2) - custo interno SRCOM
	this_nTota8s     = 0    && tota8s numeric(13,2) - valor fornecedor
	this_nTota9s     = 0    && tota9s numeric(13,2) - saldo real custo interno SRCOM
	this_nTota10s    = 0    && tota10s numeric(13,2) - saldo real fornecedor
	this_nTpesos     = 0    && tpesos numeric(8,4) - peso total
	this_nUnivals    = 0    && univals numeric(13,2) - valor unitario de venda
	this_nUtilizas   = 0    && utilizas numeric(2,0) - controle de utilizacao (fluxo de preco autorizado)
	this_lServicos   = .F.  && servicos bit - item e servico (troca a regra de calculo do imposto)
	this_nCitagrs    = 0    && citagrs numeric(10,0) - item do agrupador (decupagem)
	this_nCitem3     = 0    && citem3 numeric(10,0) - item do sub-bloco (subtotal de 2o nivel)
	this_cCodacabs   = ""   && codacabs char(3) - codigo de acabamento (SigCdAca)
	this_lDebitos    = .F.  && debitos bit - item gerado a debito (bloqueia imposto cheio)
	this_lTaxas      = .F.  && taxas bit - item e taxa (fee)

	*====================================================================
	* Init - Inicializa Business Object
	* Parametros equivalentes ao Lparameters poForm, pnDatSes do Init do
	* form legado - o form migrado repassa so os valores escalares que
	* identificam o cabecalho do movimento (poForm/pnDatSes, que sao
	* referencia de UI e troca de DataSession, ficam no Form).
	*====================================================================
	PROCEDURE Init(par_cEmps, par_cDopes, par_nNumes, par_cMascNum)
		DODEFAULT()

		*-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
		THIS.this_cTabela = "SigMvOrc"
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

		IF VARTYPE(par_cMascNum) = "C"
			THIS.this_cMascNum = par_cMascNum
		ENDIF

		*-- Legado: Thisform.Caption = Alltrim(Emps)+' '+Alltrim(Dopes)+' '+Alltrim(MascNum)+' - Itens'
		THIS.this_cCaption = ALLTRIM(THIS.this_cEmps) + " " + ALLTRIM(THIS.this_cDopes) + ;
			" " + ALLTRIM(THIS.this_cMascNum) + " - Itens"

		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna a chave primaria (cidchaves) do item
	* corrente, para uso em RegistrarAuditoria()
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCidchaves)
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia TODAS as colunas de um item de SigMvOrc
	* (cursor_4c_Itens/crSigMvOrc) para as propriedades do BO. SEMPRE usar
	* SELECT (par_cAliasCursor) antes de acessar os campos (regra #8).
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)

				THIS.this_cCblocos = TratarNulo(cblocos, "C")
				THIS.this_nCitem2 = TratarNulo(citem2, "N")
				THIS.this_nCitens = TratarNulo(citens, "N")
				THIS.this_cCpros = TratarNulo(cpros, "C")
				THIS.this_cCunips = TratarNulo(cunips, "C")
				THIS.this_cCunis = TratarNulo(cunis, "C")
				THIS.this_cDopes = TratarNulo(dopes, "C")
				THIS.this_cDpro2s = TratarNulo(dpro2s, "C")
				THIS.this_cDpros = TratarNulo(dpros, "C")
				THIS.this_cEmpdopnums = TratarNulo(empdopnums, "C")
				THIS.this_cEmps = TratarNulo(emps, "C")
				THIS.this_nFators = TratarNulo(fators, "N")
				THIS.this_nNumes = TratarNulo(numes, "N")
				THIS.this_nPesos = TratarNulo(pesos, "N")
				THIS.this_cPkchaves = TratarNulo(pkchaves, "C")
				THIS.this_nQtds = TratarNulo(qtds, "N")
				THIS.this_nTotas = TratarNulo(totas, "N")
				THIS.this_nUnits = TratarNulo(units, "N")
				THIS.this_cCidchaves = TratarNulo(cidchaves, "C")
				THIS.this_cMoedas = TratarNulo(moedas, "C")
				THIS.this_cMoefats = TratarNulo(moefats, "C")
				THIS.this_cMoevs = TratarNulo(moevs, "C")
				THIS.this_cNotas = TratarNulo(notas, "C")
				THIS.this_cObs = TratarNulo(obs, "C")
				THIS.this_cOpers = TratarNulo(opers, "C")
				THIS.this_nTota1s = TratarNulo(tota1s, "N")
				THIS.this_nTota2s = TratarNulo(tota2s, "N")
				THIS.this_nTota3s = TratarNulo(tota3s, "N")
				THIS.this_nTota4s = TratarNulo(tota4s, "N")
				THIS.this_nTota5s = TratarNulo(tota5s, "N")
				THIS.this_nTota6s = TratarNulo(tota6s, "N")
				THIS.this_nTota7s = TratarNulo(tota7s, "N")
				THIS.this_nTota8s = TratarNulo(tota8s, "N")
				THIS.this_nTota9s = TratarNulo(tota9s, "N")
				THIS.this_nTota10s = TratarNulo(tota10s, "N")
				THIS.this_nTpesos = TratarNulo(tpesos, "N")
				THIS.this_nUnivals = TratarNulo(univals, "N")
				THIS.this_nUtilizas = TratarNulo(utilizas, "N")
				IF VARTYPE(servicos) = "L"
					THIS.this_lServicos = servicos
				ELSE
					THIS.this_lServicos = (NVL(servicos, 0) = 1)
				ENDIF
				THIS.this_nCitagrs = TratarNulo(citagrs, "N")
				THIS.this_nCitem3 = TratarNulo(citem3, "N")
				THIS.this_cCodacabs = TratarNulo(codacabs, "C")
				IF VARTYPE(debitos) = "L"
					THIS.this_lDebitos = debitos
				ELSE
					THIS.this_lDebitos = (NVL(debitos, 0) = 1)
				ENDIF
				IF VARTYPE(taxas) = "L"
					THIS.this_lTaxas = taxas
				ELSE
					THIS.this_lTaxas = (NVL(taxas, 0) = 1)
				ENDIF

				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message, "Erro em sigoporcBO.CarregarDoCursor")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - Insere novo item (linha) em SigMvOrc
	* PK (cidchaves) e pkchaves gerados via fUniqueIds() se ainda vazios
	* (regra #22 - PK Fortyus NUNCA pode ser string vazia)
	*====================================================================
	PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(ALLTRIM(NVL(THIS.this_cCidchaves, "")))
				THIS.this_cCidchaves = LEFT(fUniqueIds(), 20)
			ENDIF

			IF EMPTY(ALLTRIM(NVL(THIS.this_cPkchaves, "")))
				THIS.this_cPkchaves = LEFT(fUniqueIds(), 20)
			ENDIF

			*-- Campo computado: Emps + Dopes + Numes (chave posicional que liga
			*-- o item ao cabecalho - regra #42, NUNCA ALLTRIM nas partes)
			THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

			*-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
			*-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
			*-- com limite de 8192 caracteres ("Line is too long" em runtime).
			loc_cSQL = "INSERT INTO SigMvOrc ("
			loc_cSQL = loc_cSQL + "cblocos, citem2, citens, cpros, cunips, cunis, dopes, dpro2s,"
			loc_cSQL = loc_cSQL + "dpros, empdopnums, emps, fators, numes, pesos, pkchaves, qtds,"
			loc_cSQL = loc_cSQL + "totas, units, cidchaves, moedas, moefats, moevs, notas, obs,"
			loc_cSQL = loc_cSQL + "opers, tota10s, tota1s, tota2s, tota3s, tota4s, tota5s, tota6s,"
			loc_cSQL = loc_cSQL + "tota7s, tota8s, tota9s, tpesos, univals, utilizas, servicos, citagrs,"
			loc_cSQL = loc_cSQL + "citem3, codacabs, debitos, taxas"
			loc_cSQL = loc_cSQL + ") VALUES ("
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCblocos, 30)) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCitem2, 0) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCitens, 0) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCpros, 14)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCunips, 3)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCunis, 3)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cDpro2s) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDpros, 65)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nFators, 4) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPesos, 4) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cPkchaves, 20)) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nQtds, 4) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTotas, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nUnits, 2) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCidchaves, 20)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cMoedas, 3)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cMoefats, 3)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cMoevs, 3)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNotas, 9)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cObs) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cOpers, 1)) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota10s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota1s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota2s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota3s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota4s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota5s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota6s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota7s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota8s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota9s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTpesos, 4) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nUnivals, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nUtilizas, 0) + ","
			loc_cSQL = loc_cSQL + IIF(THIS.this_lServicos, "1", "0") + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCitagrs, 0) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCitem3, 0) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCodacabs, 3)) + ","
			loc_cSQL = loc_cSQL + IIF(THIS.this_lDebitos, "1", "0") + ","
			loc_cSQL = loc_cSQL + IIF(THIS.this_lTaxas, "1", "0") + ")"

			IF USED("cursor_4c_Insert")
				USE IN cursor_4c_Insert
			ENDIF

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")

			IF loc_nResult < 0
				MsgErro("Erro ao inserir item do or" + CHR(231) + "amento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				THIS.RegistrarAuditoria("INSERT")
				IF USED("cursor_4c_Insert")
					USE IN cursor_4c_Insert
				ENDIF
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message, "Erro em sigoporcBO.Inserir")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - Atualiza item existente em SigMvOrc (por cidchaves)
	*====================================================================
	PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			*-- Campo computado: Emps + Dopes + Numes (chave posicional - regra #42)
			THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

			*-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
			*-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
			*-- com limite de 8192 caracteres ("Line is too long" em runtime).
			loc_cSQL = "UPDATE SigMvOrc SET"
			loc_cSQL = loc_cSQL + " cblocos = " + EscaparSQL(LEFT(THIS.this_cCblocos, 30)) + ","
			loc_cSQL = loc_cSQL + " citem2 = " + FormatarNumeroSQL(THIS.this_nCitem2, 0) + ","
			loc_cSQL = loc_cSQL + " citens = " + FormatarNumeroSQL(THIS.this_nCitens, 0) + ","
			loc_cSQL = loc_cSQL + " cpros = " + EscaparSQL(LEFT(THIS.this_cCpros, 14)) + ","
			loc_cSQL = loc_cSQL + " cunips = " + EscaparSQL(LEFT(THIS.this_cCunips, 3)) + ","
			loc_cSQL = loc_cSQL + " cunis = " + EscaparSQL(LEFT(THIS.this_cCunis, 3)) + ","
			loc_cSQL = loc_cSQL + " dopes = " + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
			loc_cSQL = loc_cSQL + " dpro2s = " + EscaparSQL(THIS.this_cDpro2s) + ","
			loc_cSQL = loc_cSQL + " dpros = " + EscaparSQL(LEFT(THIS.this_cDpros, 65)) + ","
			loc_cSQL = loc_cSQL + " empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ","
			loc_cSQL = loc_cSQL + " emps = " + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
			loc_cSQL = loc_cSQL + " fators = " + FormatarNumeroSQL(THIS.this_nFators, 4) + ","
			loc_cSQL = loc_cSQL + " numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
			loc_cSQL = loc_cSQL + " pesos = " + FormatarNumeroSQL(THIS.this_nPesos, 4) + ","
			loc_cSQL = loc_cSQL + " pkchaves = " + EscaparSQL(LEFT(THIS.this_cPkchaves, 20)) + ","
			loc_cSQL = loc_cSQL + " qtds = " + FormatarNumeroSQL(THIS.this_nQtds, 4) + ","
			loc_cSQL = loc_cSQL + " totas = " + FormatarNumeroSQL(THIS.this_nTotas, 2) + ","
			loc_cSQL = loc_cSQL + " units = " + FormatarNumeroSQL(THIS.this_nUnits, 2) + ","
			loc_cSQL = loc_cSQL + " moedas = " + EscaparSQL(LEFT(THIS.this_cMoedas, 3)) + ","
			loc_cSQL = loc_cSQL + " moefats = " + EscaparSQL(LEFT(THIS.this_cMoefats, 3)) + ","
			loc_cSQL = loc_cSQL + " moevs = " + EscaparSQL(LEFT(THIS.this_cMoevs, 3)) + ","
			loc_cSQL = loc_cSQL + " notas = " + EscaparSQL(LEFT(THIS.this_cNotas, 9)) + ","
			loc_cSQL = loc_cSQL + " obs = " + EscaparSQL(THIS.this_cObs) + ","
			loc_cSQL = loc_cSQL + " opers = " + EscaparSQL(LEFT(THIS.this_cOpers, 1)) + ","
			loc_cSQL = loc_cSQL + " tota10s = " + FormatarNumeroSQL(THIS.this_nTota10s, 2) + ","
			loc_cSQL = loc_cSQL + " tota1s = " + FormatarNumeroSQL(THIS.this_nTota1s, 2) + ","
			loc_cSQL = loc_cSQL + " tota2s = " + FormatarNumeroSQL(THIS.this_nTota2s, 2) + ","
			loc_cSQL = loc_cSQL + " tota3s = " + FormatarNumeroSQL(THIS.this_nTota3s, 2) + ","
			loc_cSQL = loc_cSQL + " tota4s = " + FormatarNumeroSQL(THIS.this_nTota4s, 2) + ","
			loc_cSQL = loc_cSQL + " tota5s = " + FormatarNumeroSQL(THIS.this_nTota5s, 2) + ","
			loc_cSQL = loc_cSQL + " tota6s = " + FormatarNumeroSQL(THIS.this_nTota6s, 2) + ","
			loc_cSQL = loc_cSQL + " tota7s = " + FormatarNumeroSQL(THIS.this_nTota7s, 2) + ","
			loc_cSQL = loc_cSQL + " tota8s = " + FormatarNumeroSQL(THIS.this_nTota8s, 2) + ","
			loc_cSQL = loc_cSQL + " tota9s = " + FormatarNumeroSQL(THIS.this_nTota9s, 2) + ","
			loc_cSQL = loc_cSQL + " tpesos = " + FormatarNumeroSQL(THIS.this_nTpesos, 4) + ","
			loc_cSQL = loc_cSQL + " univals = " + FormatarNumeroSQL(THIS.this_nUnivals, 2) + ","
			loc_cSQL = loc_cSQL + " utilizas = " + FormatarNumeroSQL(THIS.this_nUtilizas, 0) + ","
			loc_cSQL = loc_cSQL + " servicos = " + IIF(THIS.this_lServicos, "1", "0") + ","
			loc_cSQL = loc_cSQL + " citagrs = " + FormatarNumeroSQL(THIS.this_nCitagrs, 0) + ","
			loc_cSQL = loc_cSQL + " citem3 = " + FormatarNumeroSQL(THIS.this_nCitem3, 0) + ","
			loc_cSQL = loc_cSQL + " codacabs = " + EscaparSQL(LEFT(THIS.this_cCodacabs, 3)) + ","
			loc_cSQL = loc_cSQL + " debitos = " + IIF(THIS.this_lDebitos, "1", "0") + ","
			loc_cSQL = loc_cSQL + " taxas = " + IIF(THIS.this_lTaxas, "1", "0")
			loc_cSQL = loc_cSQL + " WHERE cidchaves = " + EscaparSQL(LEFT(THIS.this_cCidchaves, 20))

			IF USED("cursor_4c_Update")
				USE IN cursor_4c_Update
			ENDIF

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

			IF loc_nResult < 0
				MsgErro("Erro ao atualizar item do or" + CHR(231) + "amento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				THIS.RegistrarAuditoria("UPDATE")
				IF USED("cursor_4c_Update")
					USE IN cursor_4c_Update
				ENDIF
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message, "Erro em sigoporcBO.Atualizar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarConfiguracao - Le SigCdOpe (por Dopes), SigCdEmp (por Cemps -
	* regra SigCdEmp usa Cemps, NUNCA Cemps), SigOpCdd (por Dopes) e os
	* percentuais/contas do cabecalho em SigMvCab (por Emps+Dopes+Numes).
	* Equivalente ao bloco de cursores que o FORM PAI legado ja mantinha
	* abertos (crSigCdOpe/LocalEmp/crSigOpCdd/TprMvCab) - aqui cada valor e
	* lido direto do SQL Server, uma unica vez, na abertura do dialogo.
	*
	* Chamada em Formsigoporc.InicializarForm, logo apos CREATEOBJECT do
	* BO e ANTES de qualquer Configurar*() que dependa de this_cOpEscolha
	* (o Form recalcula this_cOpEscolha com this_nDigItens depois desta
	* chamada - regra do legado: DigItens=5 forca CONSULTAR).
	*====================================================================
	PROCEDURE CarregarConfiguracao()
		LOCAL loc_cSQL, loc_lSucesso
		loc_lSucesso = .T.

		TRY
			*-- SigCdOpe (configuracao da operacao, chave Dopes)
			IF USED("cursor_4c_CfgOpe")
				USE IN cursor_4c_CfgOpe
			ENDIF
			loc_cSQL = "SELECT DigItens, CadProds, Opers, Origems, Destinos, OpePads,"
			loc_cSQL = loc_cSQL + " Imagems, Confes, PrecoAuts, PrecoPs, Precops, CMoes"
			loc_cSQL = loc_cSQL + " FROM SigCdOpe WHERE Dopes = " + EscaparSQL(THIS.this_cDopes)
			IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfgOpe") > 0 AND USED("cursor_4c_CfgOpe") AND RECCOUNT("cursor_4c_CfgOpe") > 0
				SELECT cursor_4c_CfgOpe
				THIS.this_nDigItens  = TratarNulo(DigItens, "N")
				THIS.this_nCadProds  = TratarNulo(CadProds, "N")
				THIS.this_nOpers     = TratarNulo(Opers, "N")
				THIS.this_nOrigems   = TratarNulo(Origems, "N")
				THIS.this_nDestinos  = TratarNulo(Destinos, "N")
				THIS.this_cOpePads   = TratarNulo(OpePads, "C")
				THIS.this_nImagems   = TratarNulo(Imagems, "N")
				THIS.this_nConfes    = TratarNulo(Confes, "N")
				THIS.this_nPrecoAuts = TratarNulo(PrecoAuts, "N")
				THIS.this_nPrecoPs   = TratarNulo(PrecoPs, "N")
				THIS.this_nPrecops   = TratarNulo(Precops, "N")
				THIS.this_cCMoes     = TratarNulo(CMoes, "C")
			ENDIF
			IF USED("cursor_4c_CfgOpe")
				USE IN cursor_4c_CfgOpe
			ENDIF

			*-- SigCdEmp (configuracao da empresa, chave Cemps)
			IF USED("cursor_4c_CfgEmp")
				USE IN cursor_4c_CfgEmp
			ENDIF
			loc_cSQL = "SELECT DivNotas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(THIS.this_cEmps)
			IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfgEmp") > 0 AND USED("cursor_4c_CfgEmp") AND RECCOUNT("cursor_4c_CfgEmp") > 0
				THIS.this_nDivNotas = TratarNulo(cursor_4c_CfgEmp.DivNotas, "N")
			ENDIF
			IF USED("cursor_4c_CfgEmp")
				USE IN cursor_4c_CfgEmp
			ENDIF

			*-- SigOpCdd (configuracao-detalhe da operacao, chave Dopes)
			IF USED("cursor_4c_CfgOpd")
				USE IN cursor_4c_CfgOpd
			ENDIF
			loc_cSQL = "SELECT ConfigGers, ChkIfors FROM SigOpCdd WHERE Dopes = " + EscaparSQL(THIS.this_cDopes)
			IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfgOpd") > 0 AND USED("cursor_4c_CfgOpd") AND RECCOUNT("cursor_4c_CfgOpd") > 0
				THIS.this_cConfigGers = TratarNulo(cursor_4c_CfgOpd.ConfigGers, "C")
				THIS.this_nChkIfors   = TratarNulo(cursor_4c_CfgOpd.ChkIfors, "N")
			ENDIF
			IF USED("cursor_4c_CfgOpd")
				USE IN cursor_4c_CfgOpd
			ENDIF

			*-- SigMvCab (cabecalho do movimento, chave Emps+Dopes+Numes) -
			*-- percentuais default (semente do item novo) e contas de
			*-- origem/destino (usadas por btnCadPro.Click)
			IF USED("cursor_4c_CfgCab")
				USE IN cursor_4c_CfgCab
			ENDIF
			loc_cSQL = "SELECT Acres, PTax1s, PTax2s, PTax3s, Descs, ContaOs, ContaDs"
			loc_cSQL = loc_cSQL + " FROM SigMvCab WHERE Emps = " + EscaparSQL(THIS.this_cEmps)
			loc_cSQL = loc_cSQL + " AND Dopes = " + EscaparSQL(THIS.this_cDopes)
			loc_cSQL = loc_cSQL + " AND Numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0)
			IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfgCab") > 0 AND USED("cursor_4c_CfgCab") AND RECCOUNT("cursor_4c_CfgCab") > 0
				SELECT cursor_4c_CfgCab
				THIS.this_nAcres   = TratarNulo(Acres, "N")
				THIS.this_nPTax1s  = TratarNulo(PTax1s, "N")
				THIS.this_nPTax2s  = TratarNulo(PTax2s, "N")
				THIS.this_nPTax3s  = TratarNulo(PTax3s, "N")
				THIS.this_nDescs   = TratarNulo(Descs, "N")
				THIS.this_cContaOs = TratarNulo(ContaOs, "C")
				THIS.this_cContaDs = TratarNulo(ContaDs, "C")
			ENDIF
			IF USED("cursor_4c_CfgCab")
				USE IN cursor_4c_CfgCab
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message, "Erro em sigoporcBO.CarregarConfiguracao")
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarItens - Popula cursor_4c_Itens (grade de itens) a partir de
	* SigMvOrc, filtrado por Emps/Dopes/Numes e ordenado por Citens -
	* equivalente ao AddCursor('SigMvOrc','citens','CrSigMvOrc',...) do
	* Init legado. SQLEXEC vai para um cursor TEMPORARIO; cursor_4c_Itens
	* (ja ligado ao Grid, com colunas de lookup instaladas via AddObject)
	* e recarregado com ZAP + APPEND FROM DBF() - NUNCA SQLEXEC direto nele
	* (regra: SQLEXEC sobre alias de grid zera o ColumnCount).
	*====================================================================
	PROCEDURE CarregarItens()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED("cursor_4c_ItensTmp")
				USE IN cursor_4c_ItensTmp
			ENDIF

			loc_cSQL = "SELECT o.cblocos, o.citem2, o.citens, o.cpros, o.cunips, o.cunis, o.dopes,"
			loc_cSQL = loc_cSQL + " o.dpro2s, o.dpros, o.empdopnums, o.emps, o.fators, o.numes, o.pesos,"
			loc_cSQL = loc_cSQL + " o.pkchaves, o.qtds, o.totas, o.units, o.cidchaves, o.moedas, o.moefats,"
			loc_cSQL = loc_cSQL + " o.moevs, o.notas, o.obs, o.opers, o.tota10s, o.tota1s, o.tota2s, o.tota3s,"
			loc_cSQL = loc_cSQL + " o.tota4s, o.tota5s, o.tota6s, o.tota7s, o.tota8s, o.tota9s, o.tpesos,"
			loc_cSQL = loc_cSQL + " o.univals, o.utilizas, o.servicos, o.citagrs, o.citem3, o.codacabs,"
			loc_cSQL = loc_cSQL + " o.debitos, o.taxas,"
			*-- Descricoes de lookup exibidas nas Columns 4/6/30 da grade de itens
			*-- (legado: crSigMvOrc.DcUnis/DcUnips/DAcabs - colunas PROJETADAS pela
			*-- query do form PAI, nao colunas de SigMvOrc). Sem estes tres joins a
			*-- grade abriria com Unidade/Unidade(pedido)/Acabamento em BRANCO,
			*-- mesmo com cunis/cunips/codacabs gravados.
			loc_cSQL = loc_cSQL + " NVL(uv.dunis, '')  AS dcunis,"
			loc_cSQL = loc_cSQL + " NVL(up.dunis, '')  AS dcunips,"
			loc_cSQL = loc_cSQL + " NVL(ac.descrs, '') AS dacabs"
			loc_cSQL = loc_cSQL + " FROM SigMvOrc o"
			loc_cSQL = loc_cSQL + " LEFT JOIN SigCdUni uv ON RTRIM(uv.cunis) = RTRIM(o.cunis)"
			loc_cSQL = loc_cSQL + " LEFT JOIN SigCdUni up ON RTRIM(up.cunis) = RTRIM(o.cunips)"
			loc_cSQL = loc_cSQL + " LEFT JOIN SigCdAca ac ON RTRIM(ac.cods)  = RTRIM(o.codacabs)"
			loc_cSQL = loc_cSQL + " WHERE o.emps = " + EscaparSQL(THIS.this_cEmps)
			loc_cSQL = loc_cSQL + " AND o.dopes = " + EscaparSQL(THIS.this_cDopes)
			loc_cSQL = loc_cSQL + " AND o.numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0)
			loc_cSQL = loc_cSQL + " ORDER BY o.citens"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItensTmp")

			IF loc_nResultado < 0
				MsgErro("Erro ao carregar itens do or" + CHR(231) + "amento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				IF USED(THIS.this_cCursorItens)
					SELECT (THIS.this_cCursorItens)
					ZAP
					IF USED("cursor_4c_ItensTmp") AND RECCOUNT("cursor_4c_ItensTmp") > 0
						APPEND FROM DBF("cursor_4c_ItensTmp")
					ENDIF
				ENDIF
				loc_lSucesso = .T.
			ENDIF

			IF USED("cursor_4c_ItensTmp")
				USE IN cursor_4c_ItensTmp
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message, "Erro em sigoporcBO.CarregarItens")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarParcelas - Popula cursor_4c_Parcelas (grade de parcelas) a
	* partir de SigMvOrp, filtrado por Emps/Dopes/Numes e ordenado por
	* Citens - equivalente ao AddCursor('SigMvOrp','citens','CrSigMvOrp',
	* ...) do Init legado. dfors (descricao do fornecedor, Column6 de
	* grd_4c_Parcelas, SEMPRE ReadOnly) e projetado via LEFT JOIN em
	* SigCdCli.Iclis/Rclis - mesma tabela de conta usada pelo lookup
	* fAcessoContas do legado (ver cabecalho de ConfigurarGradeParcelas).
	* Mesmo padrao grid-safe de CarregarItens (cursor temporario + ZAP +
	* APPEND FROM DBF no cursor ja ligado ao Grid).
	*====================================================================
	PROCEDURE CarregarParcelas()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED("cursor_4c_ParcelasTmp")
				USE IN cursor_4c_ParcelasTmp
			ENDIF

			loc_cSQL = "SELECT p.cidchaves, p.citens, p.datas, p.dopes, p.empdopnums,"
			loc_cSQL = loc_cSQL + " p.emps, p.numes, p.percs, p.valos, p.vlbaixas,"
			loc_cSQL = loc_cSQL + " p.borderos, p.ifors, p.valcreds,"
			loc_cSQL = loc_cSQL + " NVL(f.rclis, '') AS dfors"
			loc_cSQL = loc_cSQL + " FROM SigMvOrp p LEFT JOIN SigCdCli f ON f.iclis = p.ifors"
			loc_cSQL = loc_cSQL + " WHERE p.emps = " + EscaparSQL(THIS.this_cEmps)
			loc_cSQL = loc_cSQL + " AND p.dopes = " + EscaparSQL(THIS.this_cDopes)
			loc_cSQL = loc_cSQL + " AND p.numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0)
			loc_cSQL = loc_cSQL + " ORDER BY p.citens"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ParcelasTmp")

			IF loc_nResultado < 0
				MsgErro("Erro ao carregar parcelas do or" + CHR(231) + "amento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				IF USED(THIS.this_cCursorParcelas)
					SELECT (THIS.this_cCursorParcelas)
					ZAP
					IF USED("cursor_4c_ParcelasTmp") AND RECCOUNT("cursor_4c_ParcelasTmp") > 0
						APPEND FROM DBF("cursor_4c_ParcelasTmp")
					ENDIF
				ENDIF
				loc_lSucesso = .T.
			ENDIF

			IF USED("cursor_4c_ParcelasTmp")
				USE IN cursor_4c_ParcelasTmp
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message, "Erro em sigoporcBO.CarregarParcelas")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

