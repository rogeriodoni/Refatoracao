# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (9)
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TxtNovoGrupoLostFocus' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTxtNovoGrupoLostFocusValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigoporc.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (5176 linhas total):

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

*-- Linhas 179 a 400:
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
223: 	*-- Guarda de reentrancia do lookup de Get_NewGrp (regra #37/#47): o
224: 	*-- picker e MODAL e tira o foco, o que redispara o proprio LostFocus.
225: 	this_lEmLookupGrupo = .F.
226: 
227: 	*-- Guarda de reentrancia dos lookups de CELULA da grade de itens
228: 	*-- (unidade de venda/pedido, acabamento e produto). Mesmo motivo do
229: 	*-- this_lEmLookupGrupo: o FormBuscaAuxiliar e modal, tira o foco da
230: 	*-- celula e redispara o evento que abriu o picker. Uma flag por
231: 	*-- familia de lookup, para um picker nao bloquear o outro.
232: 	this_lEmLookupUnidade    = .F.
233: 	this_lEmLookupAcabamento = .F.
234: 	this_lEmLookupProduto    = .F.
235: 
236: 	*-- Canal de retorno dos metodos AbrirBusca* (VFP9 nao devolve par de
237: 	*-- valores): o metodo de busca grava aqui o codigo e a descricao
238: 	*-- escolhidos no picker, e o handler Validar* que o chamou le e
239: 	*-- aplica no cursor. Vazios quando o usuario cancelou (ESC) - mesma
240: 	*-- semantica do "If Lastkey() = 27" do legado.
241: 	this_cLookupCodigo    = ""
242: 	this_cLookupDescricao = ""
243: 
244: 	*==========================================================================
245: 	* Init - Armazena parametros recebidos do form pai antes de DODEFAULT
246: 	*==========================================================================
247: 	PROCEDURE Init(par_oFormPai, par_cEmps, par_cDopes, par_nNumes, ;
248: 			par_cMascNum, par_cOpEscolha)
249: 		LOCAL loc_lResultado
250: 		loc_lResultado = .F.
251: 
252: 		IF VARTYPE(par_oFormPai) = "O"
253: 			THIS.this_oFormPai = par_oFormPai
254: 		ENDIF
255: 
256: 		THIS.this_cEmps    = IIF(VARTYPE(par_cEmps) = "C", ALLTRIM(par_cEmps), "")
257: 		THIS.this_cDopes   = IIF(VARTYPE(par_cDopes) = "C", ALLTRIM(par_cDopes), "")
258: 		THIS.this_nNumes   = IIF(VARTYPE(par_nNumes) = "N", par_nNumes, 0)
259: 		THIS.this_cMascNum = IIF(VARTYPE(par_cMascNum) = "C", ALLTRIM(par_cMascNum), "")
260: 
261: 		*-- Legado: Op_Escolha = Iif(crSigCdOpe.DigItens = 5, 'CONSULTAR', poForm.pcEscolha)
262: 		*-- O ramo DigItens=5 depende do BO (SigCdOpe ainda nao carregado aqui) e
263: 		*-- fica resolvido em InicializarForm; por ora guarda so o valor do pai.
264: 		THIS.this_cOpEscolha = IIF(VARTYPE(par_cOpEscolha) = "C" AND !EMPTY(par_cOpEscolha), ;
265: 			UPPER(ALLTRIM(par_cOpEscolha)), "CONSULTAR")
266: 
267: 		loc_lResultado = DODEFAULT()
268: 		RETURN loc_lResultado
269: 	ENDPROC
270: 
271: 	*==========================================================================
272: 	* InicializarForm - Cria o BO e monta o cabecalho. As grades (itens/
273: 	* parcelas), os botoes e os campos de percentual/calculo ficam para
274: 	* as fases seguintes.
275: 	*==========================================================================
276: 	PROTECTED PROCEDURE InicializarForm()
277: 		LOCAL loc_lSucesso, loc_oErro, loc_lModoValidacaoOuTeste
278: 		loc_lSucesso = .F.
279: 		loc_lModoValidacaoOuTeste = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
280: 			(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
281: 
282: 		TRY
283: 			THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
284: 
285: 			THIS.this_oBusinessObject = CREATEOBJECT("sigoporcBO", ;
286: 				THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes, THIS.this_cMascNum)
287: 
288: 			IF VARTYPE(THIS.this_oBusinessObject) <> "O"
289: 				MsgErro("Erro ao criar sigoporcBO. VARTYPE retornou: " + ;
290: 					VARTYPE(THIS.this_oBusinessObject), "Formsigoporc.InicializarForm")
291: 			ELSE
292: 				*-- Legado: Thisform.Caption = Alltrim(Emps)+' '+Alltrim(Dopes)+' '+
293: 				*-- Alltrim(MascNum)+' - Itens'. Em validacao de UI / modo teste nao
294: 				*-- recalcula: o comparador confere contra o Caption ESTATICO do SCX
295: 				*-- ("Itens"), e Emps/Dopes/MascNum chegam vazios nesses modos (sem
296: 				*-- form pai nem conexao SQL) - recalcular so trocaria o texto fiel
297: 				*-- por outro tambem incorreto.
298: 				IF !loc_lModoValidacaoOuTeste
299: 					THIS.Caption = THIS.this_oBusinessObject.this_cCaption
300: 				ENDIF
301: 
302: 				IF !loc_lModoValidacaoOuTeste
303: 					THIS.this_oBusinessObject.CarregarConfiguracao()
304: 					IF THIS.this_oBusinessObject.this_nDigItens = 5
305: 						THIS.this_cOpEscolha = "CONSULTAR"
306: 					ENDIF
307: 				ENDIF
308: 
309: 				THIS.ConfigurarCabecalho()
310: 				THIS.ConfigurarGridItens()
311: 				THIS.ConfigurarBotoesItens()
312: 				THIS.ConfigurarGradeParcelas()
313: 				THIS.ConfigurarBotoesParcelas()
314: 				THIS.ConfigurarCamposPercentuais()
315: 				THIS.ConfigurarCampoNovoGrupo()
316: 				THIS.ConfigurarCampoBusca()
317: 				THIS.ConfigurarDescritivoRodape()
318: 				THIS.ConfigurarImagemProduto()
319: 				THIS.ConfigurarBotoesPrincipais()
320: 
321: 				*-- Chamado uma unica vez, depois que TODOS os controles que
322: 				*-- dependem do modo (busca/descritivo/imagem) ja existem -
323: 				*-- CarregarDados() tambem chama de novo mais abaixo, idempotente.
324: 				THIS.AtualizarModoCriacao()
325: 
326: 				*-- Mestre-detalhe: a troca de linha na grade de itens refaz o
327: 				*-- filtro da grade de parcelas. O BINDEVENT vem DEPOIS das duas
328: 				*-- grades existirem, porque o handler mexe em grd_4c_Parcelas.
329: 				BINDEVENT(THIS.grd_4c_Itens, "AfterRowColChange", ;
330: 					THIS, "GradeItensAfterRowColChange")
331: 
332: 				*-- FUNIL de carga (cria/vincula cursores, posiciona e repinta).
333: 				*-- Nao condicionado a loc_lModoValidacaoOuTeste: os cursores sao
334: 				*-- locais (CREATE CURSOR), nao dependem de conexao SQL, e sem a
335: 				*-- chamada as grades abririam com cabecalho "Column<N>" e largura
336: 				*-- default tambem na validacao de UI. Ele ja aplica o layout do
337: 				*-- modo (AtualizarModoCriacao -> HabilitarCampos +
338: 				*-- AjustarBotoesPorModo) e traz os percentuais do cabecalho
339: 				*-- (BOParaForm).
340: 				THIS.CarregarDados()
341: 
342: 				loc_lSucesso = .T.
343: 			ENDIF
344: 		CATCH TO loc_oErro
345: 			MsgErro(loc_oErro.Message + CHR(13) + ;
346: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
347: 				"Procedure: " + loc_oErro.Procedure, ;
348: 				"Erro em Formsigoporc.InicializarForm")
349: 		ENDTRY
350: 
351: 		RETURN loc_lSucesso
352: 	ENDPROC
353: 
354: 	*==========================================================================
355: 	* ConfigurarCabecalho - Faixa cinza do topo (cntSombra do legado), com
356: 	* os dois labels sobrepostos (sombra + titulo) exibindo o Caption
357: 	* calculado em InicializarForm. Filho DIRETO do form (sem PageFrame),
358: 	* igual ao SCX legado.
359: 	*==========================================================================
360: 	PROTECTED PROCEDURE ConfigurarCabecalho()
361: 		LOCAL loc_oCnt
362: 
363: 		THIS.AddObject("cnt_4c_Sombra", "Container")
364: 		loc_oCnt = THIS.cnt_4c_Sombra
365: 		WITH loc_oCnt
366: 			.Top         = 0
367: 			.Left        = 0
368: 			.Width       = THIS.Width
369: 			.Height      = 80
370: 			.BorderWidth = 0
371: 			.BackColor   = RGB(100, 100, 100)
372: 			.Visible     = .T.
373: 		ENDWITH
374: 
375: 		loc_oCnt.AddObject("lbl_4c_Sombra", "Label")
376: 		WITH loc_oCnt.lbl_4c_Sombra
377: 			.FontBold      = .T.
378: 			.FontName      = "Tahoma"
379: 			.FontSize      = 18
380: 			.FontUnderline = .F.
381: 			.WordWrap      = .T.
382: 			.Alignment     = 0
383: 			.BackStyle     = 0
384: 			.AutoSize      = .F.
385: 			.Caption       = THIS.Caption
386: 			.Height        = 40
387: 			.Left          = 10
388: 			.Top           = 18
389: 			.Width         = 769
390: 			.ForeColor     = RGB(0, 0, 0)
391: 			.Visible       = .T.
392: 		ENDWITH
393: 
394: 		loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
395: 		WITH loc_oCnt.lbl_4c_Titulo
396: 			.FontBold  = .T.
397: 			.FontName  = "Tahoma"
398: 			.FontSize  = 18
399: 			.WordWrap  = .T.
400: 			.Alignment = 0

*-- Linhas 474 a 517:
474: 	* e explicito, nao silencioso: inventar uma origem para essa coluna
475: 	* seria inventar regra de negocio (regra #17).
476: 	*==========================================================================
477: 	PROTECTED PROCEDURE CriarCursorItens()
478: 		LOCAL loc_cCursor
479: 		loc_cCursor = THIS.this_oBusinessObject.this_cCursorItens
480: 
481: 		IF USED(loc_cCursor)
482: 			USE IN (loc_cCursor)
483: 		ENDIF
484: 
485: 		SET NULL ON
486: 		CREATE CURSOR (loc_cCursor) ;
487: 			(cidchaves C(20), cblocos C(30), citens N(10,0), citem2 N(10,0), ;
488: 			 citem3 N(10,0), citagrs N(10,0), cpros C(14), dpros C(65), ;
489: 			 dpro2s M, qtds N(8,4), cunis C(3), dcunis C(20), pesos N(8,4), ;
490: 			 cunips C(3), dcunips C(20), codacabs C(3), ;
491: 			 fators N(8,4), units N(13,2), totas N(13,2), tota1s N(13,2), ;
492: 			 tota2s N(13,2), tota3s N(13,2), tota4s N(13,2), tota5s N(13,2), ;
493: 			 tota6s N(13,2), obs M, tota7s N(13,2), tota8s N(13,2), ;
494: 			 tota9s N(13,2), tota10s N(13,2), notas C(9), perc1s N(8,4), ;
495: 			 perc2s N(8,4), perc3s N(8,4), perc4s N(8,4), perc5s N(8,4), ;
496: 			 perc6s N(8,4), servicos L, debitos L, taxas L, dacabs C(40), ;
497: 			 vlbaixas N(13,2), emps C(3), dopes C(20), numes N(6,0), ;
498: 			 empdopnums C(29), pkchaves C(20), moedas C(3), moefats C(3), ;
499: 			 moevs C(3), opers C(1), tpesos N(8,4), univals N(13,2), ;
500: 			 utilizas N(2,0))
501: 		SET NULL OFF
502: 
503: 		INDEX ON citens TAG citens
504: 	ENDPROC
505: 
506: 	*==========================================================================
507: 	* ConfigurarGridItens - grd_4c_Itens, equivalente ao SIGOPORC.grdItem
508: 	* (30 colunas). ControlSource/Width/ColumnOrder/Header1.Caption
509: 	* TRANSCRITOS do dump (PROPRIEDADES DE: SIGOPORC.grdItem e do Init -
510: 	* "With ThisForm.grdItem"). Column1 mostra Dpros (nao "Item" - o
511: 	* Header1.Caption do dump e literalmente esse, apesar do nome sugerir
512: 	* outra coisa) e Column2 mostra Dpro2s - conferido nas DUAS fontes do
513: 	* dump (PROPRIEDADES + Init) porque batiam.
514: 	*
515: 	* FICA PARA FASE POSTERIOR (depende de crSigCdOpe/SigCdEmp, carregados
516: 	* pelo BO em fase propria - ver cabecalho de sigoporcBO.prg):
517: 	*   - ReadOnly fixo (.T.) de Column13/Column14, mascaras de Column3/

*-- Linhas 524 a 567:
524: 	*     valor quando o BO passar a montar cursor_4c_Itens com os joins
525: 	*     de unidade/acabamento.
526: 	*==========================================================================
527: 	PROTECTED PROCEDURE ConfigurarGridItens()
528: 		LOCAL loc_lSoLeitura
529: 		loc_lSoLeitura = (THIS.this_cOpEscolha = "CONSULTAR")
530: 
531: 		THIS.AddObject("grd_4c_Itens", "Grid")
532: 
533: 		*-- ColumnCount FORA do WITH: as colunas ainda nao existem no momento
534: 		*-- da compilacao do WITH abaixo (regra CLAUDE.md sobre WITH + Grid -
535: 		*-- "Unknown member COLUMN1"). RecordSource/ControlSource/Width/
536: 		*-- Header1.Caption NAO ficam aqui: vao em VincularGradeItens().
537: 		THIS.grd_4c_Itens.ColumnCount  = 30
538: 
539: 		WITH THIS.grd_4c_Itens
540: 			.Top          = 218
541: 			.Left         = 5
542: 			.Width        = 989
543: 			.Height       = 258
544: 			.FontSize     = 8
545: 			.HeaderHeight = 16
546: 			.RowHeight    = 16
547: 			.ScrollBars   = 3
548: 			.DeleteMark   = .F.
549: 			.RecordMark   = .F.
550: 			.TabIndex     = 13
551: 
552: 			*-- Column1 (Item/Dpros - descritivo do produto). Celula com
553: 			*-- LOOKUP (legado grdItem.Column1.Text1.Valid -> SigCdPro), por
554: 			*-- isso recebe TextBox proprio via AddObject + CurrentControl +
555: 			*-- Sparse = .F. (regra #18: sem CurrentControl a coluna continua
556: 			*-- desenhando o Text1 nativo e o lookup nunca e alcancado; sem
557: 			*-- Sparse = .F. o controle so aparece na linha ativa).
558: 			*-- MaxLength vem da LARGURA da coluna no schema (SigMvOrc.dpros
559: 			*-- char(65)), nunca do Width em pixels (regra #19).
560: 			.Column1.ColumnOrder     = 1
561: 			.Column1.FontSize        = 8
562: 			.Column1.Header1.Alignment = 2
563: 			.Column1.Header1.FontSize  = 8
564: 			.Column1.AddObject("txt_4c_DescricaoItem", "TextBox")
565: 			.Column1.txt_4c_DescricaoItem.BorderStyle = 0
566: 			.Column1.txt_4c_DescricaoItem.Margin      = 0
567: 			.Column1.txt_4c_DescricaoItem.ForeColor   = RGB(0, 0, 0)

*-- Linhas 929 a 1061:
929: 			.Visible = .T.
930: 		ENDWITH
931: 
932: 		*-- Lookups de celula (produto + unidade de venda/pedido + acabamento) - BINDEVENT
933: 		*-- FORA do WITH acima: regra #46 (Valid de celula vai no TextBox da
934: 		*-- Column, nunca em AfterRowColChange) + regra #34 (Controls(N) por
935: 		*-- indice, nunca por nome - aqui o caminho e qualificado explicito,
936: 		*-- sem usar Controls()). GotFocus guarda o valor anterior em .Tag,
937: 		*-- substituindo o "this.Tag = this.Value" que o legado faz no When
938: 		*-- (When nao e um evento vinculavel por BINDEVENT com efeito colateral
939: 		*-- confiavel em VFP9).
940: 		BINDEVENT(THIS.grd_4c_Itens.Column1.txt_4c_DescricaoItem, "GotFocus", THIS, "GuardarAntDpros")
941: 		BINDEVENT(THIS.grd_4c_Itens.Column1.txt_4c_DescricaoItem, "KeyPress", THIS, "ValidarProdutoItemKeyPress")
942: 		BINDEVENT(THIS.grd_4c_Itens.Column4.txt_4c_UnidadeVenda, "GotFocus", THIS, "GuardarTagUnidadeVenda")
943: 		BINDEVENT(THIS.grd_4c_Itens.Column4.txt_4c_UnidadeVenda, "KeyPress", THIS, "ValidarUnidadeVendaKeyPress")
944: 		BINDEVENT(THIS.grd_4c_Itens.Column6.txt_4c_UnidadePedido, "GotFocus", THIS, "GuardarTagUnidadePedido")
945: 		BINDEVENT(THIS.grd_4c_Itens.Column6.txt_4c_UnidadePedido, "KeyPress", THIS, "ValidarUnidadePedidoKeyPress")
946: 		BINDEVENT(THIS.grd_4c_Itens.Column30.txt_4c_Acabamento, "GotFocus", THIS, "GuardarTagAcabamento")
947: 		BINDEVENT(THIS.grd_4c_Itens.Column30.txt_4c_Acabamento, "KeyPress", THIS, "ValidarAcabamentoKeyPress")
948: 	ENDPROC
949: 
950: 	*==========================================================================
951: 	* GuardarTagUnidadeVenda/Pedido/Acabamento - substituem o "this.Tag =
952: 	* this.Value" que o legado faz dentro do PROCEDURE When (disparado a
953: 	* cada entrada no campo). Guardam o valor com que o usuario ENTROU na
954: 	* celula, para o Valid poder comparar e pular o lookup quando o
955: 	* usuario so passou pela celula sem alterar (regra do legado: "If Padr
956: 	* (this.Value,20) = Padr(this.Tag,20) / Return .t.").
957: 	*==========================================================================
958: 	*==========================================================================
959: 	* GuardarAntDpros - equivalente ao "thisform.antdpros = this.Value" que o
960: 	* legado faz no When de grdItem.Column1.Text1. Guarda, na property
961: 	* this_cAntDpros (mapeada de antdpros), a descricao com que o usuario
962: 	* ENTROU na celula, para o Valid poder sair sem reconsultar quando o
963: 	* valor nao mudou ("If Padr(This.Value,40) = Padr(Thisform.antdpros,40)").
964: 	*==========================================================================
965: 	PROCEDURE GuardarAntDpros()
966: 		THIS.this_cAntDpros = TratarNulo(THIS.grd_4c_Itens.Column1.txt_4c_DescricaoItem.Value, "")
967: 	ENDPROC
968: 
969: 	PROCEDURE GuardarTagUnidadeVenda()
970: 		THIS.grd_4c_Itens.Column4.txt_4c_UnidadeVenda.Tag = THIS.grd_4c_Itens.Column4.txt_4c_UnidadeVenda.Value
971: 	ENDPROC
972: 
973: 	PROCEDURE GuardarTagUnidadePedido()
974: 		THIS.grd_4c_Itens.Column6.txt_4c_UnidadePedido.Tag = THIS.grd_4c_Itens.Column6.txt_4c_UnidadePedido.Value
975: 	ENDPROC
976: 
977: 	PROCEDURE GuardarTagAcabamento()
978: 		THIS.grd_4c_Itens.Column30.txt_4c_Acabamento.Tag = THIS.grd_4c_Itens.Column30.txt_4c_Acabamento.Value
979: 	ENDPROC
980: 
981: 	*==========================================================================
982: 	* ValidarUnidadeVendaKeyPress / ValidarUnidadePedidoKeyPress - legado
983: 	* SIGOPORC.grdItem.Column4/Column6.Text1.Valid. O usuario digita a
984: 	* DESCRICAO da unidade (DCunis/DCunips); o metodo resolve o CODIGO
985: 	* (Cunis/Cunips) por busca exata e, faltando, abre o picker (padrao
986: 	* local do projeto - FormBuscaAuxiliar + DefinirCursor sobre o cursor
987: 	* JA populado, igual a TxtNovoGrupoLostFocus - nao o fwBuscaInt do
988: 	* legado, que nao foi portado). Delegam para ValidarUnidadeGenerica,
989: 	* que e a MESMA logica para os dois campos (so trocam coluna de
990: 	* descricao/codigo no cursor de itens).
991: 	*==========================================================================
992: 	PROCEDURE ValidarUnidadeVendaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
993: 		LOCAL loc_oTxt
994: 		IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
995: 			RETURN
996: 		ENDIF
997: 		loc_oTxt = THIS.grd_4c_Itens.Column4.txt_4c_UnidadeVenda
998: 		THIS.ValidarUnidadeGenerica(loc_oTxt, "dcunis", "cunis")
999: 	ENDPROC
1000: 
1001: 	PROCEDURE ValidarUnidadePedidoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1002: 		LOCAL loc_oTxt
1003: 		IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
1004: 			RETURN
1005: 		ENDIF
1006: 		loc_oTxt = THIS.grd_4c_Itens.Column6.txt_4c_UnidadePedido
1007: 		THIS.ValidarUnidadeGenerica(loc_oTxt, "dcunips", "cunips")
1008: 	ENDPROC
1009: 
1010: 	*==========================================================================
1011: 	* ValidarUnidadeGenerica - corpo compartilhado por ValidarUnidadeVenda/
1012: 	* PedidoKeyPress. par_oTxt e o TextBox da celula (Column4/Column6);
1013: 	* par_cCampoDesc/par_cCampoCod sao as colunas do cursor_4c_Itens a
1014: 	* atualizar (dcunis/cunis ou dcunips/cunips).
1015: 	*
1016: 	* O valor digitado FICA no TextBox (par_oTxt.Value) - o cursor so
1017: 	* recebe DEPOIS, via REPLACE (regra #46). Se o valor nao mudou desde
1018: 	* que o usuario entrou na celula (guardado em .Tag por GotFocus), sai
1019: 	* sem reconsultar - igual ao legado.
1020: 	*==========================================================================
1021: 	PROTECTED PROCEDURE ValidarUnidadeGenerica(par_oTxt, par_cCampoDesc, par_cCampoCod)
1022: 		LOCAL loc_cItens, loc_cValor, loc_cSQL, loc_nResultado, loc_cDescEscolhida, loc_cCodEscolhido
1023: 
1024: 		IF PADR(ALLTRIM(par_oTxt.Value), 20) = PADR(ALLTRIM(TratarNulo(par_oTxt.Tag, "")), 20)
1025: 			RETURN
1026: 		ENDIF
1027: 
1028: 		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
1029: 		IF !USED(loc_cItens)
1030: 			RETURN
1031: 		ENDIF
1032: 
1033: 		loc_cValor = ALLTRIM(par_oTxt.Value)
1034: 
1035: 		IF EMPTY(loc_cValor)
1036: 			SELECT (loc_cItens)
1037: 			REPLACE (par_cCampoCod) WITH ""
1038: 			RETURN
1039: 		ENDIF
1040: 
1041: 		IF USED("cursor_4c_TmpUnidade")
1042: 			USE IN cursor_4c_TmpUnidade
1043: 		ENDIF
1044: 		loc_cSQL = "SELECT Dunis, Cunis FROM SigCdUni WHERE Dunis LIKE " + ;
1045: 			EscaparSQL("%" + loc_cValor + "%") + " ORDER BY Cunis"
1046: 		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpUnidade")
1047: 
1048: 		IF loc_nResultado < 0
1049: 			MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
1050: 				"Falha na Conex" + CHR(227) + "o (SigCdUni)")
1051: 			RETURN
1052: 		ENDIF
1053: 
1054: 		loc_cDescEscolhida = ""
1055: 		loc_cCodEscolhido  = ""
1056: 
1057: 		IF USED("cursor_4c_TmpUnidade") AND RECCOUNT("cursor_4c_TmpUnidade") > 0
1058: 			SELECT cursor_4c_TmpUnidade
1059: 			GO TOP
1060: 			LOCATE FOR Dunis = PADR(loc_cValor, 20)
1061: 

*-- Linhas 1096 a 1139:
1096: 	* o usuario digitou - so o CODIGO (codacabs) fica vazio, diferente do
1097: 	* legado (que limpa os dois, this.Value incluido).
1098: 	*==========================================================================
1099: 	PROCEDURE ValidarAcabamentoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1100: 		LOCAL loc_oTxt, loc_cItens, loc_cValor, loc_cSQL, loc_nResultado
1101: 		LOCAL loc_cDescEscolhida, loc_cCodEscolhido
1102: 
1103: 		IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
1104: 			RETURN
1105: 		ENDIF
1106: 
1107: 		loc_oTxt = THIS.grd_4c_Itens.Column30.txt_4c_Acabamento
1108: 
1109: 		IF ALLTRIM(loc_oTxt.Value) == ALLTRIM(TratarNulo(loc_oTxt.Tag, ""))
1110: 			RETURN
1111: 		ENDIF
1112: 
1113: 		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
1114: 		IF !USED(loc_cItens)
1115: 			RETURN
1116: 		ENDIF
1117: 
1118: 		loc_cValor = ALLTRIM(loc_oTxt.Value)
1119: 
1120: 		IF EMPTY(loc_cValor)
1121: 			SELECT (loc_cItens)
1122: 			REPLACE codacabs WITH ""
1123: 			RETURN
1124: 		ENDIF
1125: 
1126: 		IF USED("cursor_4c_TmpAcabamento")
1127: 			USE IN cursor_4c_TmpAcabamento
1128: 		ENDIF
1129: 		loc_cSQL = "SELECT Cods, Descrs FROM SigCdAca WHERE Descrs LIKE " + EscaparSQL("%" + loc_cValor + "%")
1130: 		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpAcabamento")
1131: 
1132: 		IF loc_nResultado < 0
1133: 			MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), ;
1134: 				"Falha na Conex" + CHR(227) + "o (SigCdAca)")
1135: 			RETURN
1136: 		ENDIF
1137: 
1138: 		loc_cDescEscolhida = ""
1139: 		loc_cCodEscolhido  = ""

*-- Linhas 1146 a 1230:
1146: 			*-- Regra #50: universo vazio pode ser dado real (nenhum acabamento
1147: 			*-- com essa descricao) - avisar, mas NUNCA apagar o que o usuario
1148: 			*-- digitou (so o codigo, que de fato nao foi resolvido).
1149: 			MsgAviso("Acabamento n" + CHR(227) + "o encontrado.", "Aviso")
1150: 		ENDIF
1151: 
1152: 		IF USED("cursor_4c_TmpAcabamento")
1153: 			USE IN cursor_4c_TmpAcabamento
1154: 		ENDIF
1155: 
1156: 		SELECT (loc_cItens)
1157: 		IF !EMPTY(loc_cCodEscolhido)
1158: 			loc_oTxt.Value = loc_cDescEscolhida
1159: 			REPLACE dacabs WITH loc_cDescEscolhida, codacabs WITH loc_cCodEscolhido
1160: 		ELSE
1161: 			REPLACE codacabs WITH ""
1162: 		ENDIF
1163: 	ENDPROC
1164: 
1165: 	*==========================================================================
1166: 	* ValidarProdutoItemKeyPress - legado SIGOPORC.grdItem.Column1.Text1.
1167: 	* Valid (o trecho de LOOKUP; a precificacao automatica que vem depois
1168: 	* dele no dump depende de crSigCdOpe/crSigOpCdd, carregados em fase
1169: 	* propria do BO - ver cabecalho da classe).
1170: 	*
1171: 	* O usuario digita parte da DESCRICAO do produto (Dpros); o metodo
1172: 	* consulta SigCdPro com a restricao de SigCdRpo (Dopps = Dopes do
1173: 	* cabecalho) - quando a restricao existe, o legado faz INNER JOIN; sem
1174: 	* restricao, consulta SigCdPro direto. Resolve por busca exata e, se
1175: 	* nao casar, abre o picker.
1176: 	*
1177: 	* Guardas TRANSCRITAS do legado (regra #21b - a condicao que cerca a
1178: 	* validacao FAZ PARTE dela):
1179: 	*   - valor nao mudou desde a entrada na celula (this_cAntDpros,
1180: 	*     comparado com PADR(...,40) igual ao legado) -> sai sem consultar
1181: 	*   - linha de SUBTOTAL (citens = citem2) ou de marcador de nivel
1182: 	*     (citens = citem3) -> o legado NAO faz lookup: nessas linhas a
1183: 	*     descricao digitada e so o rotulo do bloco, propagado para o
1184: 	*     dpro2s das linhas de SUBTOTAL do mesmo agrupamento
1185: 	*
1186: 	* O valor digitado esta em .Value (o cursor so recebe DEPOIS, via
1187: 	* REPLACE - regra #46), e a descricao escolhida volta para .Value alem
1188: 	* do REPLACE, senao o texto digitado sobrescreveria o cursor.
1189: 	*==========================================================================
1190: 	PROCEDURE ValidarProdutoItemKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1191: 		LOCAL loc_oTxt, loc_cItens, loc_cValor, loc_cSQL, loc_nResultado
1192: 		LOCAL loc_cCodEscolhido, loc_cDescEscolhida, loc_cDescritivo
1193: 		LOCAL loc_cCunis, loc_cCunips, loc_lRestrito
1194: 		LOCAL loc_nItens, loc_nItem2, loc_nItem3
1195: 
1196: 		IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
1197: 			RETURN
1198: 		ENDIF
1199: 
1200: 		loc_oTxt   = THIS.grd_4c_Itens.Column1.txt_4c_DescricaoItem
1201: 		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
1202: 
1203: 		IF !USED(loc_cItens) OR EOF(loc_cItens)
1204: 			RETURN
1205: 		ENDIF
1206: 
1207: 		loc_cValor = ALLTRIM(TratarNulo(loc_oTxt.Value, ""))
1208: 
1209: 		SELECT (loc_cItens)
1210: 		loc_nItens = citens
1211: 		loc_nItem2 = citem2
1212: 		loc_nItem3 = citem3
1213: 
1214: 		*-- Linha de SUBTOTAL / marcador de nivel: sem lookup. O legado
1215: 		*-- propaga o rotulo digitado para o dpro2s das linhas de SUBTOTAL
1216: 		*-- do mesmo agrupamento e volta ao item corrente por SEEK no TAG
1217: 		*-- citens.
1218: 		IF loc_nItens = loc_nItem2 OR loc_nItens = loc_nItem3
1219: 			IF loc_nItens = loc_nItem2 AND loc_nItens = loc_nItem3
1220: 				REPLACE dpro2s WITH loc_cValor ;
1221: 					FOR citem3 = loc_nItens AND citem2 = citens AND cblocos = "SUBTOTAL" ;
1222: 					IN (loc_cItens)
1223: 			ELSE
1224: 				REPLACE dpro2s WITH loc_cValor ;
1225: 					FOR citem2 = loc_nItem2 AND cblocos = "SUBTOTAL" ;
1226: 					IN (loc_cItens)
1227: 			ENDIF
1228: 			SELECT (loc_cItens)
1229: 			=SEEK(loc_nItens, loc_cItens, "citens")
1230: 			THIS.this_cAntDpros = loc_cValor

*-- Linhas 1341 a 1570:
1341: 
1342: 	*==========================================================================
1343: 	* AbrirBuscaProdutoItem - picker do lookup de produto da celula
1344: 	* grd_4c_Itens.Column1 (legado: CreateObject([fwBuscaInt], [crTmpPro],
1345: 	* [Dpros], lcDPro, [Item], .t.) + os tres mAddColuna de DPros/CPros/
1346: 	* Dpro2s). Trabalha sobre cursor_4c_BuscaProduto, que o chamador JA
1347: 	* populou - mesmo contrato do fwBuscaInt legado, que recebe um cursor
1348: 	* local ja consultado.
1349: 	*
1350: 	* Devolve o par escolhido em this_cLookupCodigo/this_cLookupDescricao
1351: 	* (vazios quando o usuario cancelou - equivale ao "Lastkey() = 27" do
1352: 	* legado). Guarda de reentrancia porque o picker e MODAL (regra #37).
1353: 	*==========================================================================
1354: 	PROCEDURE AbrirBuscaProdutoItem()
1355: 		LOCAL loc_oBusca, loc_oErro
1356: 
1357: 		THIS.this_cLookupCodigo    = ""
1358: 		THIS.this_cLookupDescricao = ""
1359: 
1360: 		IF THIS.this_lEmLookupProduto OR !USED("cursor_4c_BuscaProduto")
1361: 			RETURN
1362: 		ENDIF
1363: 		THIS.this_lEmLookupProduto = .T.
1364: 
1365: 		TRY
1366: 			loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1367: 			loc_oBusca.DefinirCursor("cursor_4c_BuscaProduto", "Cpros", "Dpros", "Item")
1368: 			loc_oBusca.this_aColunas[1, 3] = "C" + CHR(243) + "digo"
1369: 			loc_oBusca.this_aColunas[2, 3] = "Descri" + CHR(231) + CHR(227) + "o"
1370: 			loc_oBusca.mAddColuna("Dpro2s", "", "Descritivo")
1371: 
1372: 			IF loc_oBusca.Mostrar()
1373: 				THIS.this_cLookupCodigo    = loc_oBusca.cCodigoSelecionado
1374: 				THIS.this_cLookupDescricao = loc_oBusca.cDescricaoSelecionada
1375: 			ENDIF
1376: 
1377: 			loc_oBusca.Release()
1378: 		CATCH TO loc_oErro
1379: 			MsgErro(loc_oErro.Message + CHR(13) + ;
1380: 				"Linha: " + TRANSFORM(loc_oErro.LineNo), ;
1381: 				"Erro em Formsigoporc.AbrirBuscaProdutoItem")
1382: 		ENDTRY
1383: 
1384: 		THIS.this_lEmLookupProduto = .F.
1385: 	ENDPROC
1386: 
1387: 	*==========================================================================
1388: 	* AbrirBuscaUnidade - picker do lookup de unidade das celulas
1389: 	* grd_4c_Itens.Column4/Column6 (legado: CreateObject([fwBuscaInt],
1390: 	* [crTmpUni], [Dunis], lcDuni, [Unidade], .t.) + mAddColuna de DUnis e
1391: 	* CUnis). Trabalha sobre cursor_4c_TmpUnidade, que
1392: 	* ValidarUnidadeGenerica JA populou com SigCdUni.
1393: 	*
1394: 	* Devolve o par em this_cLookupCodigo/this_cLookupDescricao (vazios no
1395: 	* cancelamento). Guarda de reentrancia: o picker e MODAL (regra #37).
1396: 	*==========================================================================
1397: 	PROCEDURE AbrirBuscaUnidade()
1398: 		LOCAL loc_oBusca, loc_oErro
1399: 
1400: 		THIS.this_cLookupCodigo    = ""
1401: 		THIS.this_cLookupDescricao = ""
1402: 
1403: 		IF THIS.this_lEmLookupUnidade OR !USED("cursor_4c_TmpUnidade")
1404: 			RETURN
1405: 		ENDIF
1406: 		THIS.this_lEmLookupUnidade = .T.
1407: 
1408: 		TRY
1409: 			loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1410: 			loc_oBusca.DefinirCursor("cursor_4c_TmpUnidade", "Cunis", "Dunis", "Unidade")
1411: 			loc_oBusca.this_aColunas[1, 3] = "C" + CHR(243) + "digo"
1412: 			loc_oBusca.this_aColunas[2, 3] = "Descri" + CHR(231) + CHR(227) + "o"
1413: 
1414: 			IF loc_oBusca.Mostrar()
1415: 				THIS.this_cLookupCodigo    = loc_oBusca.cCodigoSelecionado
1416: 				THIS.this_cLookupDescricao = loc_oBusca.cDescricaoSelecionada
1417: 			ENDIF
1418: 
1419: 			loc_oBusca.Release()
1420: 		CATCH TO loc_oErro
1421: 			MsgErro(loc_oErro.Message + CHR(13) + ;
1422: 				"Linha: " + TRANSFORM(loc_oErro.LineNo), ;
1423: 				"Erro em Formsigoporc.AbrirBuscaUnidade")
1424: 		ENDTRY
1425: 
1426: 		THIS.this_lEmLookupUnidade = .F.
1427: 	ENDPROC
1428: 
1429: 	*==========================================================================
1430: 	* AbrirBuscaAcabamento - picker do lookup de acabamento da celula
1431: 	* grd_4c_Itens.Column30 (legado: CreateObject([fwBuscaInt], [TmpCdAca],
1432: 	* [Descrs], Alltrim(this.Value), [Acabamento], .t.) + mAddColuna de
1433: 	* Descrs). Trabalha sobre cursor_4c_TmpAcabamento, que
1434: 	* ValidarAcabamentoKeyPress JA populou com SigCdAca.
1435: 	*
1436: 	* O legado declara apenas a coluna Descrs no picker; aqui o par
1437: 	* codigo/descricao e necessario porque e Cods que vai para codacabs -
1438: 	* a coluna de codigo entra junto (DefinirCursor exige as duas) e a
1439: 	* descricao continua sendo a chave visivel da escolha.
1440: 	*==========================================================================
1441: 	PROCEDURE AbrirBuscaAcabamento()
1442: 		LOCAL loc_oBusca, loc_oErro
1443: 
1444: 		THIS.this_cLookupCodigo    = ""
1445: 		THIS.this_cLookupDescricao = ""
1446: 
1447: 		IF THIS.this_lEmLookupAcabamento OR !USED("cursor_4c_TmpAcabamento")
1448: 			RETURN
1449: 		ENDIF
1450: 		THIS.this_lEmLookupAcabamento = .T.
1451: 
1452: 		TRY
1453: 			loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1454: 			loc_oBusca.DefinirCursor("cursor_4c_TmpAcabamento", "Cods", "Descrs", "Acabamento")
1455: 			loc_oBusca.this_aColunas[1, 3] = "C" + CHR(243) + "digo"
1456: 			loc_oBusca.this_aColunas[2, 3] = "Descri" + CHR(231) + CHR(227) + "o"
1457: 
1458: 			IF loc_oBusca.Mostrar()
1459: 				THIS.this_cLookupCodigo    = loc_oBusca.cCodigoSelecionado
1460: 				THIS.this_cLookupDescricao = loc_oBusca.cDescricaoSelecionada
1461: 			ENDIF
1462: 
1463: 			loc_oBusca.Release()
1464: 		CATCH TO loc_oErro
1465: 			MsgErro(loc_oErro.Message + CHR(13) + ;
1466: 				"Linha: " + TRANSFORM(loc_oErro.LineNo), ;
1467: 				"Erro em Formsigoporc.AbrirBuscaAcabamento")
1468: 		ENDTRY
1469: 
1470: 		THIS.this_lEmLookupAcabamento = .F.
1471: 	ENDPROC
1472: 
1473: 	*==========================================================================
1474: 	* AbrirBuscaNovoGrupo - picker do lookup de Grupo de Produto do campo
1475: 	* txt_4c_NovoGrupo (legado get_NewGrp.Valid: CreateObject([fwBuscaInt],
1476: 	* [TmpCdGpr], [Cgrus], This.Value, [Grupos], .t.) + mAddColuna de
1477: 	* CGrus e DGrus). Trabalha sobre cursor_4c_BuscaGrupo, que
1478: 	* TxtNovoGrupoLostFocus JA populou - com a restricao de SigCdRpo e, se
1479: 	* ela nao devolver nada, com a lista inteira de SigCdGrp (fallback
1480: 	* transcrito do legado).
1481: 	*
1482: 	* A guarda de reentrancia desta familia (this_lEmLookupGrupo) e ligada
1483: 	* pelo CHAMADOR: este metodo nao a liga de novo, senao devolveria sem
1484: 	* abrir nada (regra #47 - o funil liga a flag UMA vez).
1485: 	*==========================================================================
1486: 	PROCEDURE AbrirBuscaNovoGrupo()
1487: 		LOCAL loc_oBusca, loc_oErro
1488: 
1489: 		THIS.this_cLookupCodigo    = ""
1490: 		THIS.this_cLookupDescricao = ""
1491: 
1492: 		IF !USED("cursor_4c_BuscaGrupo")
1493: 			RETURN
1494: 		ENDIF
1495: 
1496: 		TRY
1497: 			loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1498: 			loc_oBusca.DefinirCursor("cursor_4c_BuscaGrupo", "Cgrus", "DGrus", ;
1499: 				"Grupo Para Cadastro de Produtos")
1500: 			loc_oBusca.this_aColunas[1, 3] = "Grupo"
1501: 			loc_oBusca.this_aColunas[2, 3] = "Descri" + CHR(231) + CHR(227) + "o"
1502: 
1503: 			IF loc_oBusca.Mostrar()
1504: 				THIS.this_cLookupCodigo    = loc_oBusca.cCodigoSelecionado
1505: 				THIS.this_cLookupDescricao = loc_oBusca.cDescricaoSelecionada
1506: 			ENDIF
1507: 
1508: 			loc_oBusca.Release()
1509: 		CATCH TO loc_oErro
1510: 			MsgErro(loc_oErro.Message + CHR(13) + ;
1511: 				"Linha: " + TRANSFORM(loc_oErro.LineNo), ;
1512: 				"Erro em Formsigoporc.AbrirBuscaNovoGrupo")
1513: 		ENDTRY
1514: 	ENDPROC
1515: 
1516: 	*==========================================================================
1517: 	* VincularGradeItens - Liga grd_4c_Itens ao cursor de itens. SEPARADO de
1518: 	* ConfigurarGridItens de proposito: atribuir RecordSource RESETA
1519: 	* Column.Width e Column.Header1.Caption (regra #41 / Problema 48), entao
1520: 	* os dois tem de ser reaplicados DEPOIS de cada bind - e o bind acontece
1521: 	* mais de uma vez (toda vez que o cursor de itens e recriado pelo funil
1522: 	* CarregarDados). Ordem canonica: RecordSource -> ControlSource ->
1523: 	* Width -> Header1.Caption.
1524: 	*
1525: 	* O bind e CONDICIONADO a USED(cursor): instanciado sem cursor (harness de
1526: 	* teste), atribuir RecordSource estouraria "Alias is not found". Width e
1527: 	* Header1.Caption sao aplicados SEMPRE, com ou sem alias aberto - senao a
1528: 	* grade apareceria com cabecalho "Column1" e largura default.
1529: 	*==========================================================================
1530: 	PROTECTED PROCEDURE VincularGradeItens()
1531: 		LOCAL loc_cCursor
1532: 		loc_cCursor = THIS.this_oBusinessObject.this_cCursorItens
1533: 
1534: 		WITH THIS.grd_4c_Itens
1535: 			IF USED(loc_cCursor)
1536: 				.RecordSource = loc_cCursor
1537: 
1538: 				.Column1.ControlSource = loc_cCursor + ".dpros"
1539: 				.Column2.ControlSource = loc_cCursor + ".dpro2s"
1540: 				.Column3.ControlSource = loc_cCursor + ".qtds"
1541: 				.Column4.ControlSource = loc_cCursor + ".dcunis"
1542: 				.Column5.ControlSource = loc_cCursor + ".pesos"
1543: 				.Column6.ControlSource = loc_cCursor + ".dcunips"
1544: 				.Column7.ControlSource = loc_cCursor + ".fators"
1545: 				.Column8.ControlSource = loc_cCursor + ".units"
1546: 				.Column9.ControlSource = loc_cCursor + ".totas"
1547: 				.Column10.ControlSource = loc_cCursor + ".tota1s"
1548: 				.Column11.ControlSource = loc_cCursor + ".tota2s"
1549: 				.Column12.ControlSource = loc_cCursor + ".tota3s"
1550: 				.Column13.ControlSource = loc_cCursor + ".tota4s"
1551: 				.Column14.ControlSource = loc_cCursor + ".tota5s"
1552: 				.Column15.ControlSource = loc_cCursor + ".tota6s"
1553: 				.Column16.ControlSource = loc_cCursor + ".obs"
1554: 				.Column17.ControlSource = loc_cCursor + ".tota7s"
1555: 				.Column18.ControlSource = loc_cCursor + ".tota8s"
1556: 				.Column19.ControlSource = loc_cCursor + ".tota9s"
1557: 				.Column20.ControlSource = loc_cCursor + ".tota10s"
1558: 				.Column21.ControlSource = loc_cCursor + ".notas"
1559: 				.Column22.ControlSource = loc_cCursor + ".perc4s"
1560: 				.Column23.ControlSource = loc_cCursor + ".perc5s"
1561: 				.Column24.ControlSource = loc_cCursor + ".perc6s"
1562: 				.Column25.ControlSource = loc_cCursor + ".perc2s"
1563: 				.Column26.ControlSource = loc_cCursor + ".perc3s"
1564: 				.Column27.ControlSource = loc_cCursor + ".servicos"
1565: 				.Column28.ControlSource = loc_cCursor + ".debitos"
1566: 				.Column29.ControlSource = loc_cCursor + ".taxas"
1567: 				.Column30.ControlSource = loc_cCursor + ".dacabs"
1568: 			ENDIF
1569: 
1570: 			*-- Width/Header1.Caption SEMPRE depois do bind (RecordSource reseta

*-- Linhas 1655 a 1815:
1655: 	* COLUNA vem DEPOIS do ReadOnly do GRID, senao o do grid sobrescreve
1656: 	* (regra #46).
1657: 	*==========================================================================
1658: 	PROTECTED PROCEDURE ReinstalarCelulasLookupItens()
1659: 		LOCAL loc_lSoLeitura
1660: 		loc_lSoLeitura = (THIS.this_cOpEscolha = "CONSULTAR")
1661: 
1662: 		WITH THIS.grd_4c_Itens
1663: 			IF !PEMSTATUS(.Column1, "txt_4c_DescricaoItem", 5)
1664: 				.Column1.AddObject("txt_4c_DescricaoItem", "TextBox")
1665: 				.Column1.txt_4c_DescricaoItem.BorderStyle = 0
1666: 				.Column1.txt_4c_DescricaoItem.Margin      = 0
1667: 				.Column1.txt_4c_DescricaoItem.ForeColor   = RGB(0, 0, 0)
1668: 				.Column1.txt_4c_DescricaoItem.BackColor   = RGB(255, 255, 255)
1669: 				.Column1.txt_4c_DescricaoItem.MaxLength   = 65
1670: 				BINDEVENT(.Column1.txt_4c_DescricaoItem, "GotFocus", THIS, "GuardarAntDpros")
1671: 				BINDEVENT(.Column1.txt_4c_DescricaoItem, "KeyPress", THIS, "ValidarProdutoItemKeyPress")
1672: 			ENDIF
1673: 			.Column1.CurrentControl = "txt_4c_DescricaoItem"
1674: 			.Column1.Sparse         = .F.
1675: 			.Column1.ReadOnly       = loc_lSoLeitura
1676: 
1677: 			IF !PEMSTATUS(.Column4, "txt_4c_UnidadeVenda", 5)
1678: 				.Column4.AddObject("txt_4c_UnidadeVenda", "TextBox")
1679: 				.Column4.txt_4c_UnidadeVenda.BorderStyle = 0
1680: 				.Column4.txt_4c_UnidadeVenda.Margin      = 0
1681: 				.Column4.txt_4c_UnidadeVenda.ForeColor   = RGB(0, 0, 0)
1682: 				.Column4.txt_4c_UnidadeVenda.BackColor   = RGB(255, 255, 255)
1683: 				.Column4.txt_4c_UnidadeVenda.MaxLength   = 20
1684: 				BINDEVENT(.Column4.txt_4c_UnidadeVenda, "GotFocus", THIS, "GuardarTagUnidadeVenda")
1685: 				BINDEVENT(.Column4.txt_4c_UnidadeVenda, "KeyPress", THIS, "ValidarUnidadeVendaKeyPress")
1686: 			ENDIF
1687: 			.Column4.CurrentControl = "txt_4c_UnidadeVenda"
1688: 			.Column4.Sparse         = .F.
1689: 			.Column4.ReadOnly       = loc_lSoLeitura
1690: 
1691: 			IF !PEMSTATUS(.Column6, "txt_4c_UnidadePedido", 5)
1692: 				.Column6.AddObject("txt_4c_UnidadePedido", "TextBox")
1693: 				.Column6.txt_4c_UnidadePedido.BorderStyle = 0
1694: 				.Column6.txt_4c_UnidadePedido.Margin      = 0
1695: 				.Column6.txt_4c_UnidadePedido.ForeColor   = RGB(0, 0, 0)
1696: 				.Column6.txt_4c_UnidadePedido.BackColor   = RGB(255, 255, 255)
1697: 				.Column6.txt_4c_UnidadePedido.MaxLength   = 20
1698: 				BINDEVENT(.Column6.txt_4c_UnidadePedido, "GotFocus", THIS, "GuardarTagUnidadePedido")
1699: 				BINDEVENT(.Column6.txt_4c_UnidadePedido, "KeyPress", THIS, "ValidarUnidadePedidoKeyPress")
1700: 			ENDIF
1701: 			.Column6.CurrentControl = "txt_4c_UnidadePedido"
1702: 			.Column6.Sparse         = .F.
1703: 			.Column6.ReadOnly       = loc_lSoLeitura
1704: 
1705: 			IF !PEMSTATUS(.Column30, "txt_4c_Acabamento", 5)
1706: 				.Column30.AddObject("txt_4c_Acabamento", "TextBox")
1707: 				.Column30.txt_4c_Acabamento.BorderStyle = 0
1708: 				.Column30.txt_4c_Acabamento.Margin      = 0
1709: 				.Column30.txt_4c_Acabamento.ForeColor   = RGB(0, 0, 0)
1710: 				.Column30.txt_4c_Acabamento.BackColor   = RGB(255, 255, 255)
1711: 				.Column30.txt_4c_Acabamento.MaxLength   = 20
1712: 				BINDEVENT(.Column30.txt_4c_Acabamento, "GotFocus", THIS, "GuardarTagAcabamento")
1713: 				BINDEVENT(.Column30.txt_4c_Acabamento, "KeyPress", THIS, "ValidarAcabamentoKeyPress")
1714: 			ENDIF
1715: 			.Column30.CurrentControl = "txt_4c_Acabamento"
1716: 			.Column30.Sparse         = .F.
1717: 			.Column30.ReadOnly       = loc_lSoLeitura
1718: 		ENDWITH
1719: 	ENDPROC
1720: 
1721: 	*==========================================================================
1722: 	* CriarCursorParcelas - Cursor da grade de parcelas/previsoes de pagamento
1723: 	* (grd_4c_Parcelas), equivalente ao crSigMvOrp que o legado compartilha
1724: 	* com o form pai via troca de DataSession. Colunas conferidas em
1725: 	* docs\schema.sql (tabela SigMvOrp): cidchaves/citens/datas/dopes/
1726: 	* empdopnums/emps/numes/percs/valos/vlbaixas/borderos/ifors/valcreds.
1727: 	*
1728: 	* dfors NAO e coluna de SigMvOrp - e PROJECAO: o legado liga
1729: 	* grdParcela.Column6 a crSigMvOrp.Dfors, que e a razao social do
1730: 	* fornecedor (SigCdCli.RClis) trazida pelo join em Ifors. Fica vazia
1731: 	* ate a fase do BO que monta a consulta com o join.
1732: 	*
1733: 	* A ORDEM DOS CAMPOS deste CREATE CURSOR e a unica do form (regra
1734: 	* OPERACIONAL #2): qualquer outro ponto que venha a recriar o cursor
1735: 	* tem de chamar ESTE metodo, nunca repetir o CREATE CURSOR.
1736: 	*==========================================================================
1737: 	PROTECTED PROCEDURE CriarCursorParcelas()
1738: 		LOCAL loc_cCursor
1739: 		loc_cCursor = THIS.this_oBusinessObject.this_cCursorParcelas
1740: 
1741: 		IF USED(loc_cCursor)
1742: 			USE IN (loc_cCursor)
1743: 		ENDIF
1744: 
1745: 		SET NULL ON
1746: 		CREATE CURSOR (loc_cCursor) ;
1747: 			(cidchaves C(20), citens N(10,0), datas D, dopes C(29), ;
1748: 			 empdopnums C(29), emps C(3), numes N(6,0), percs N(5,2), ;
1749: 			 valos N(13,2), vlbaixas N(12,2), borderos N(10,0), ;
1750: 			 ifors C(10), valcreds N(13,2), dfors C(50))
1751: 		SET NULL OFF
1752: 
1753: 		*-- Legado (fim do Init): Select crSigMvOrp / Set Order to / Set Order
1754: 		*-- to CItens - a grade de parcelas e sempre vista pela ordem do item,
1755: 		*-- porque e por essa chave que PosicionarParcelasDoItem filtra.
1756: 		INDEX ON citens TAG citens
1757: 	ENDPROC
1758: 
1759: 	*==========================================================================
1760: 	* ConfigurarGradeParcelas - grd_4c_Parcelas, equivalente ao
1761: 	* SIGOPORC.grdParcela (7 colunas). Geometria/fonte/cor/ColumnOrder
1762: 	* TRANSCRITOS do dump ("PROPRIEDADES DE: SIGOPORC.grdParcela").
1763: 	*
1764: 	* Igual a grade de itens, aqui fica SO o que nao depende de dado;
1765: 	* RecordSource/ControlSource/Width/Header1.Caption vao em
1766: 	* VincularGradeParcelas().
1767: 	*
1768: 	* ReadOnly por coluna transcrito do Init legado ("With ThisForm.grdParcela"):
1769: 	* Column4 (Fornecedor), Column6 (Descricao) e Column7 (Credito) sao
1770: 	* ReadOnly = .T. SEMPRE - sao projecao/valor calculado, nao entrada; as
1771: 	* demais seguem o modo (CONSULTAR = somente leitura). O ReadOnly da
1772: 	* COLUNA vem DEPOIS do ReadOnly do GRID, senao o do grid sobrescreve
1773: 	* (regra #46).
1774: 	*==========================================================================
1775: 	PROTECTED PROCEDURE ConfigurarGradeParcelas()
1776: 		LOCAL loc_lSoLeitura
1777: 		loc_lSoLeitura = (THIS.this_cOpEscolha = "CONSULTAR")
1778: 
1779: 		THIS.AddObject("grd_4c_Parcelas", "Grid")
1780: 
1781: 		*-- ColumnCount FORA do WITH (as Columns ainda nao existem dentro dele)
1782: 		THIS.grd_4c_Parcelas.ColumnCount = 7
1783: 
1784: 		WITH THIS.grd_4c_Parcelas
1785: 			.Top          = 504
1786: 			.Left         = 6
1787: 			.Width        = 946
1788: 			.Height       = 92
1789: 			.FontName     = "Tahoma"
1790: 			.FontSize     = 8
1791: 			.ForeColor    = RGB(90, 90, 90)
1792: 			.HeaderHeight = 16
1793: 			.RowHeight    = 16
1794: 			.Panel        = 1
1795: 			.ScrollBars   = 3
1796: 			.DeleteMark   = .F.
1797: 			.RecordMark   = .F.
1798: 			.TabIndex     = 25
1799: 			.ReadOnly     = loc_lSoLeitura
1800: 
1801: 			*-- Column1 (% - percs)
1802: 			.Column1.ColumnOrder       = 3
1803: 			.Column1.FontName          = "Tahoma"
1804: 			.Column1.FontSize          = 8
1805: 			.Column1.ForeColor         = RGB(90, 90, 90)
1806: 			.Column1.Header1.Alignment = 2
1807: 			.Column1.Header1.FontSize  = 8
1808: 			.Column1.ReadOnly          = loc_lSoLeitura
1809: 
1810: 			*-- Column2 (Data - datas)
1811: 			.Column2.ColumnOrder       = 4
1812: 			.Column2.FontName          = "Tahoma"
1813: 			.Column2.FontSize          = 8
1814: 			.Column2.ForeColor         = RGB(90, 90, 90)
1815: 			.Column2.Header1.Alignment = 2

*-- Linhas 1864 a 2138:
1864: 			.Visible = .T.
1865: 		ENDWITH
1866: 	ENDPROC
1867: 
1868: 	*==========================================================================
1869: 	* VincularGradeParcelas - Liga grd_4c_Parcelas ao cursor de parcelas.
1870: 	* Mesmo motivo da separacao em VincularGradeItens: RecordSource reseta
1871: 	* Width/Header1.Caption, entao os dois vem DEPOIS do bind e sao
1872: 	* aplicados SEMPRE, com ou sem alias aberto. Bind condicionado a
1873: 	* USED(cursor) para nao estourar "Alias is not found" no harness.
1874: 	* ControlSource transcrito do Init legado ("With ThisForm.grdParcela").
1875: 	*==========================================================================
1876: 	PROTECTED PROCEDURE VincularGradeParcelas()
1877: 		LOCAL loc_cCursor
1878: 		loc_cCursor = THIS.this_oBusinessObject.this_cCursorParcelas
1879: 
1880: 		WITH THIS.grd_4c_Parcelas
1881: 			IF USED(loc_cCursor)
1882: 				.RecordSource = loc_cCursor
1883: 
1884: 				.Column1.ControlSource = loc_cCursor + ".percs"
1885: 				.Column2.ControlSource = loc_cCursor + ".datas"
1886: 				.Column3.ControlSource = loc_cCursor + ".valos"
1887: 				.Column4.ControlSource = loc_cCursor + ".ifors"
1888: 				.Column5.ControlSource = loc_cCursor + ".vlbaixas"
1889: 				.Column6.ControlSource = loc_cCursor + ".dfors"
1890: 				.Column7.ControlSource = loc_cCursor + ".valcreds"
1891: 			ENDIF
1892: 
1893: 			*-- Width/Header1.Caption SEMPRE depois do bind. Transcritos do
1894: 			*-- dump (PROPRIEDADES DE: SIGOPORC.grdParcela + o Header1 de cada
1895: 			*-- Column no layout do legado).
1896: 			.Column1.Width           = 70
1897: 			.Column1.Header1.Caption = "%"
1898: 			.Column2.Width           = 70
1899: 			.Column2.Header1.Caption = "Data"
1900: 			.Column3.Width           = 122
1901: 			.Column3.Header1.Caption = "Previsto"
1902: 			.Column4.Width           = 80
1903: 			.Column4.Header1.Caption = "Fornecedor"
1904: 			.Column5.Width           = 122
1905: 			.Column5.Header1.Caption = "Realizado"
1906: 			.Column6.Width           = 290
1907: 			.Column6.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1908: 			.Column7.Width           = 122
1909: 			.Column7.Header1.Caption = "Cr" + CHR(233) + "dito"
1910: 		ENDWITH
1911: 	ENDPROC
1912: 
1913: 	*==========================================================================
1914: 	* ConfigurarBotoesParcelas - btnIncluirp/btnExcluirp do legado (fwbtnp,
1915: 	* standalone, SOMENTE ICONE - Caption = "" no dump). Top/Left/Picture/
1916: 	* ToolTipText TRANSCRITOS do dump; fwbtnp mede 40x40 (medido no VFP9 e
1917: 	* ja registrado em FormSigOpLoc.prg), o que confere com o espacamento
1918: 	* de 40px entre os dois (Top 516 e 556).
1919: 	*
1920: 	* Botao SO-ICONE nunca recebe .Enabled = .F.: com Caption vazio o VFP9
1921: 	* deixa de desenhar o Picture e o botao vira um retangulo vazio (regra
1922: 	* do CorretorAutomatico #106). O "When" do legado
1923: 	* (Inlist(Op_Escolha,[INSERIR],[ALTERAR])) virou guarda no inicio do
1924: 	* proprio handler - BINDEVENT descarta o retorno do delegate, entao um
1925: 	* When ligado por BINDEVENT nao bloquearia nada.
1926: 	*==========================================================================
1927: 	PROTECTED PROCEDURE ConfigurarBotoesParcelas()
1928: 		THIS.AddObject("cmd_4c_IncluirParcela", "CommandButton")
1929: 		WITH THIS.cmd_4c_IncluirParcela
1930: 			.Top             = 516
1931: 			.Left            = 954
1932: 			.Height          = 40
1933: 			.Width           = 40
1934: 			.Caption         = ""
1935: 			.ToolTipText     = "Inserir linha"
1936: 			.ForeColor       = RGB(90, 90, 90)
1937: 			.BackColor       = RGB(255, 255, 255)
1938: 			.Themes          = .T.
1939: 			.Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
1940: 			.DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
1941: 			.TabIndex        = 26
1942: 			.Visible         = .T.
1943: 		ENDWITH
1944: 		BINDEVENT(THIS.cmd_4c_IncluirParcela, "Click", THIS, "BtnIncluirParcelaClick")
1945: 
1946: 		THIS.AddObject("cmd_4c_ExcluirParcela", "CommandButton")
1947: 		WITH THIS.cmd_4c_ExcluirParcela
1948: 			.Top             = 556
1949: 			.Left            = 954
1950: 			.Height          = 40
1951: 			.Width           = 40
1952: 			.Caption         = ""
1953: 			.ToolTipText     = "Exclui linha"
1954: 			.ForeColor       = RGB(90, 90, 90)
1955: 			.BackColor       = RGB(255, 255, 255)
1956: 			.Themes          = .T.
1957: 			.Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1958: 			.DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1959: 			.TabIndex        = 28
1960: 			.Visible         = .T.
1961: 		ENDWITH
1962: 		BINDEVENT(THIS.cmd_4c_ExcluirParcela, "Click", THIS, "BtnExcluirParcelaClick")
1963: 	ENDPROC
1964: 
1965: 	*==========================================================================
1966: 	* BtnIncluirParcelaClick - legado SIGOPORC.btnIncluirp.Click. Insere uma
1967: 	* parcela/previsao em branco para o ITEM CORRENTE da grade de itens.
1968: 	*
1969: 	* As tres condicoes do legado sao regra de negocio e vao transcritas
1970: 	* juntas (regra #21b): a parcela so existe para item NORMAL - nao para
1971: 	* linha de subtotal (Citens = Citem2), nao para item sem produto
1972: 	* (Empty(Cpros)) e nao para linha de marcador (cBlocos IN SUBTOTAL/
1973: 	* BRANCO/SUBTOTAIS/TAXA/TOTAL/IMPOSTO/TOTALGERAL).
1974: 	*
1975: 	* Emps/Dopes/Numes vem das properties do form (equivalentes a
1976: 	* TprMvCab.Emps/Dopes/Numes do legado, que chegavam pela DataSession
1977: 	* compartilhada). Igual ao legado, a persistencia em SigMvOrp acontece
1978: 	* so na confirmacao do dialogo - aqui so o cursor e alterado.
1979: 	*==========================================================================
1980: 	PROCEDURE BtnIncluirParcelaClick()
1981: 		LOCAL loc_cItens, loc_cParcelas, loc_nItem, loc_lPodeIncluir
1982: 
1983: 		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
1984: 			RETURN
1985: 		ENDIF
1986: 
1987: 		loc_cItens    = THIS.this_oBusinessObject.this_cCursorItens
1988: 		loc_cParcelas = THIS.this_oBusinessObject.this_cCursorParcelas
1989: 
1990: 		IF !USED(loc_cItens) OR !USED(loc_cParcelas) OR EOF(loc_cItens)
1991: 			RETURN
1992: 		ENDIF
1993: 
1994: 		THIS.LockScreen = .T.
1995: 
1996: 		SELECT (loc_cItens)
1997: 		loc_lPodeIncluir = (citens <> citem2) AND !EMPTY(cpros) AND ;
1998: 			!INLIST(ALLTRIM(cblocos), "SUBTOTAL", "BRANCO", "SUBTOTAIS", ;
1999: 				"TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL")
2000: 		loc_nItem = citens
2001: 
2002: 		IF loc_lPodeIncluir
2003: 			INSERT INTO (loc_cParcelas) ;
2004: 				(emps, dopes, numes, citens, datas, valos, vlbaixas) ;
2005: 				VALUES (THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes, ;
2006: 					loc_nItem, CTOD(""), 0, 0)
2007: 
2008: 			SELECT (loc_cParcelas)
2009: 			GO BOTTOM
2010: 		ENDIF
2011: 
2012: 		THIS.grd_4c_Parcelas.Refresh()
2013: 		THIS.LockScreen = .F.
2014: 
2015: 		*-- Legado: thisform.grdParcela.column4.SetFocus()
2016: 		THIS.grd_4c_Parcelas.Column4.SetFocus()
2017: 	ENDPROC
2018: 
2019: 	*==========================================================================
2020: 	* BtnExcluirParcelaClick - legado SIGOPORC.btnExcluirp.Click. Exclui a
2021: 	* parcela corrente, recusando a exclusao quando ela JA FOI BAIXADA
2022: 	* (VlBaixas preenchido) - a regra e a mensagem sao do legado.
2023: 	*
2024: 	* O legado usa "Return .f." dentro do IF; aqui a estrutura e IF/ELSE,
2025: 	* que produz o mesmo efeito sem RETURN no meio do metodo.
2026: 	*==========================================================================
2027: 	PROCEDURE BtnExcluirParcelaClick()
2028: 		LOCAL loc_cParcelas
2029: 
2030: 		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
2031: 			RETURN
2032: 		ENDIF
2033: 
2034: 		loc_cParcelas = THIS.this_oBusinessObject.this_cCursorParcelas
2035: 
2036: 		IF !USED(loc_cParcelas)
2037: 			RETURN
2038: 		ENDIF
2039: 
2040: 		SELECT (loc_cParcelas)
2041: 
2042: 		IF !EMPTY(vlbaixas)
2043: 			*-- Legado: "A parcela ja joi autorizada!" - o "joi" e erro de
2044: 			*-- digitacao do original, visivel ao usuario; aqui sai "foi",
2045: 			*-- sem mudar o sentido da mensagem.
2046: 			MsgAviso("A parcela j" + CHR(225) + " foi autorizada!", ;
2047: 				"Imposs" + CHR(237) + "vel excluir")
2048: 		ELSE
2049: 			THIS.LockScreen = .T.
2050: 
2051: 			IF !EOF(loc_cParcelas)
2052: 				DELETE
2053: 				GO TOP
2054: 			ENDIF
2055: 
2056: 			THIS.grd_4c_Parcelas.Refresh()
2057: 			THIS.LockScreen = .F.
2058: 
2059: 			*-- Legado: thisform.grdParcela.column1.SetFocus()
2060: 			THIS.grd_4c_Parcelas.Column1.SetFocus()
2061: 		ENDIF
2062: 	ENDPROC
2063: 
2064: 	*==========================================================================
2065: 	* ConfigurarCamposPercentuais - Shape4 (moldura decorativa) + os 6
2066: 	* campos de percentual do cabecalho (say5/getPmargem .. Say6/
2067: 	* getPservico do legado). TRANSCRITOS do dump (bloco "PROPRIEDADES
2068: 	* DE: SIGOPORC.<nome>"), pareados por proximidade de Top (label.Top =
2069: 	* textbox.Top + 3, conferido um a um):
2070: 	*
2071: 	*   Say5 "Margem :...%"            (96)  <-> getPmargem      (93)  - SEM ControlSource; When sempre .F. (resultado calculado por TotalizarItn, nunca digitado)
2072: 	*   say4 "Contingente :...%"       (116) <-> getPtax2        (113) - ControlSource = TprMvCab.ptax2s (Perc1s)
2073: 	*   say1 "Ta\<xa Adm. :...%"       (136) <-> getPtaxa        (133) - ControlSource = TprMvCab.descs  (Perc2s)
2074: 	*   Say3 "BV :...%"                (156) <-> getPTax1        (153) - ControlSource = TprMvCab.ptax1s (Perc3s)
2075: 	*   say2 "Im\<posto :...%"         (176) <-> getPimposto     (173) - ControlSource = TprMvCab.acres  (Perc4s, item nao-servico)
2076: 	*   Say6 "Imposto sem ISS :...%"   (196) <-> getPservico     (193) - ControlSource = TprMvCab.ptax3s (Perc4s, item servico)
2077: 	*
2078: 	* Nenhum dos 5 TextBoxes editaveis usa ControlSource aqui: TprMvCab e
2079: 	* cursor do FORM PAI no legado (nao existe neste dialogo), e os 5
2080: 	* valores correspondentes (this_nPTax2s/this_nDescs/this_nPTax1s/
2081: 	* this_nAcres/this_nPTax3s) sao escalares do BO, repassados uma unica
2082: 	* vez na abertura (nao mudam por item) - a sincronizacao e manual
2083: 	* (.Value lido/escrito direto), igual ao padrao ja usado para
2084: 	* this_cEmps/this_cDopes/etc.
2085: 	*
2086: 	* SIMPLIFICACAO DOCUMENTADA: o legado guarda This.PEAntValue (property
2087: 	* da classe fwget) e so executa a cascata de Replace quando
2088: 	* "this.Value <> this.peantvalue" (evita reprocessar se o usuario so
2089: 	* passou pelo campo sem alterar). Como a cascata e IDEMPOTENTE (mesmo
2090: 	* valor de entrada sempre produz o mesmo resultado), replicar esse
2091: 	* guard exigiria 5 handlers de GotFocus extras so para guardar o
2092: 	* valor anterior em .Tag - trocado aqui por executar a cascata sempre
2093: 	* que o valor NAO esta vazio, no Enter/Tab (regra "BINDEVENT Valid nao
2094: 	* funciona em TextBox - usar KeyPress ENTER/TAB"). Resultado final
2095: 	* identico; custo e, no maximo, um SCAN redundante quando o usuario
2096: 	* nao mudou o valor.
2097: 	*==========================================================================
2098: 	PROTECTED PROCEDURE ConfigurarCamposPercentuais()
2099: 		LOCAL loc_lPodeEditar
2100: 		loc_lPodeEditar = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
2101: 
2102: 		THIS.AddObject("shp_4c_Painel", "Shape")
2103: 		WITH THIS.shp_4c_Painel
2104: 			.Top          = 106
2105: 			.Left         = 577
2106: 			.Height       = 93
2107: 			.Width        = 163
2108: 			.BackStyle    = 0
2109: 			.BorderWidth  = 2
2110: 			.SpecialEffect = 0
2111: 			.BorderColor  = RGB(90, 90, 90)
2112: 			.Visible      = .T.
2113: 		ENDWITH
2114: 
2115: 		*-- Margem (resultado calculado - sempre desabilitado, destaque amarelo)
2116: 		THIS.AddObject("lbl_4c_Margem", "Label")
2117: 		WITH THIS.lbl_4c_Margem
2118: 			.FontName  = "Tahoma"
2119: 			.FontSize  = 8
2120: 			.Alignment = 1
2121: 			.AutoSize  = .F.
2122: 			.Caption   = "Margem :                     %"
2123: 			.Top       = 96
2124: 			.Left      = 261
2125: 			.Width     = 192
2126: 			.Height    = 15
2127: 			.ForeColor = RGB(90, 90, 90)
2128: 			.Visible   = .T.
2129: 		ENDWITH
2130: 
2131: 		THIS.AddObject("txt_4c_Margem", "TextBox")
2132: 		WITH THIS.txt_4c_Margem
2133: 			.Top           = 93
2134: 			.Left          = 380
2135: 			.Width         = 59
2136: 			.Height        = 21
2137: 			.Alignment     = 3
2138: 			.FontBold      = .T.

*-- Linhas 2182 a 2582:
2182: 			.Enabled       = loc_lPodeEditar
2183: 			.Visible       = .T.
2184: 		ENDWITH
2185: 		BINDEVENT(THIS.txt_4c_Contingente, "KeyPress", THIS, "TxtContingenteKeyPress")
2186: 
2187: 		*-- Taxa Adm. (Perc2s - TprMvCab.Descs)
2188: 		THIS.AddObject("lbl_4c_TaxaAdm", "Label")
2189: 		WITH THIS.lbl_4c_TaxaAdm
2190: 			.FontName  = "Tahoma"
2191: 			.FontSize  = 8
2192: 			.Alignment = 1
2193: 			.AutoSize  = .F.
2194: 			.Caption   = "Ta\<xa Adm. :                     %"
2195: 			.Top       = 136
2196: 			.Left      = 261
2197: 			.Width     = 192
2198: 			.Height    = 15
2199: 			.ForeColor = RGB(90, 90, 90)
2200: 			.Visible   = .T.
2201: 		ENDWITH
2202: 
2203: 		THIS.AddObject("txt_4c_TaxaAdm", "TextBox")
2204: 		WITH THIS.txt_4c_TaxaAdm
2205: 			.Top           = 133
2206: 			.Left          = 380
2207: 			.Width         = 59
2208: 			.Height        = 21
2209: 			.Alignment     = 3
2210: 			.Format        = "K"
2211: 			.InputMask     = "999.99"
2212: 			.Margin        = 0
2213: 			.SpecialEffect = 1
2214: 			.ForeColor     = RGB(0, 0, 0)
2215: 			.BorderColor   = RGB(100, 100, 100)
2216: 			.Value         = THIS.this_oBusinessObject.this_nDescs
2217: 			.Enabled       = loc_lPodeEditar
2218: 			.Visible       = .T.
2219: 		ENDWITH
2220: 		BINDEVENT(THIS.txt_4c_TaxaAdm, "KeyPress", THIS, "TxtTaxaAdmKeyPress")
2221: 
2222: 		*-- BV (Perc3s - TprMvCab.Ptax1s)
2223: 		THIS.AddObject("lbl_4c_BV", "Label")
2224: 		WITH THIS.lbl_4c_BV
2225: 			.FontName  = "Tahoma"
2226: 			.FontSize  = 8
2227: 			.Alignment = 1
2228: 			.AutoSize  = .F.
2229: 			.Caption   = "BV :                     %"
2230: 			.Top       = 156
2231: 			.Left      = 261
2232: 			.Width     = 192
2233: 			.Height    = 15
2234: 			.ForeColor = RGB(90, 90, 90)
2235: 			.Visible   = .T.
2236: 		ENDWITH
2237: 
2238: 		THIS.AddObject("txt_4c_BV", "TextBox")
2239: 		WITH THIS.txt_4c_BV
2240: 			.Top           = 153
2241: 			.Left          = 380
2242: 			.Width         = 59
2243: 			.Height        = 21
2244: 			.Alignment     = 3
2245: 			.Format        = "K"
2246: 			.InputMask     = "999.99"
2247: 			.Margin        = 0
2248: 			.SpecialEffect = 1
2249: 			.ForeColor     = RGB(0, 0, 0)
2250: 			.BorderColor   = RGB(100, 100, 100)
2251: 			.Value         = THIS.this_oBusinessObject.this_nPTax1s
2252: 			.Enabled       = loc_lPodeEditar
2253: 			.Visible       = .T.
2254: 		ENDWITH
2255: 		BINDEVENT(THIS.txt_4c_BV, "KeyPress", THIS, "TxtBVKeyPress")
2256: 
2257: 		*-- Imposto cheio (Perc4s quando item NAO e servico - TprMvCab.Acres)
2258: 		THIS.AddObject("lbl_4c_Imposto", "Label")
2259: 		WITH THIS.lbl_4c_Imposto
2260: 			.FontName  = "Tahoma"
2261: 			.FontSize  = 8
2262: 			.Alignment = 1
2263: 			.AutoSize  = .F.
2264: 			.Caption   = "Im\<posto :                     %"
2265: 			.Top       = 176
2266: 			.Left      = 261
2267: 			.Width     = 192
2268: 			.Height    = 15
2269: 			.ForeColor = RGB(90, 90, 90)
2270: 			.Visible   = .T.
2271: 		ENDWITH
2272: 
2273: 		THIS.AddObject("txt_4c_Imposto", "TextBox")
2274: 		WITH THIS.txt_4c_Imposto
2275: 			.Top           = 173
2276: 			.Left          = 380
2277: 			.Width         = 59
2278: 			.Height        = 21
2279: 			.Alignment     = 3
2280: 			.Format        = "K"
2281: 			.InputMask     = "999.99"
2282: 			.Margin        = 0
2283: 			.SpecialEffect = 1
2284: 			.ForeColor     = RGB(0, 0, 0)
2285: 			.BorderColor   = RGB(100, 100, 100)
2286: 			.Value         = THIS.this_oBusinessObject.this_nAcres
2287: 			.Enabled       = loc_lPodeEditar
2288: 			.Visible       = .T.
2289: 		ENDWITH
2290: 		BINDEVENT(THIS.txt_4c_Imposto, "KeyPress", THIS, "TxtImpostoKeyPress")
2291: 
2292: 		*-- Imposto sem ISS (Perc4s quando item E servico - TprMvCab.Ptax3s)
2293: 		THIS.AddObject("lbl_4c_ImpostoServico", "Label")
2294: 		WITH THIS.lbl_4c_ImpostoServico
2295: 			.FontName  = "Tahoma"
2296: 			.FontSize  = 8
2297: 			.Alignment = 1
2298: 			.AutoSize  = .F.
2299: 			.Caption   = "Imposto sem ISS :                     %"
2300: 			.Top       = 196
2301: 			.Left      = 260
2302: 			.Width     = 192
2303: 			.Height    = 15
2304: 			.ForeColor = RGB(90, 90, 90)
2305: 			.Visible   = .T.
2306: 		ENDWITH
2307: 
2308: 		THIS.AddObject("txt_4c_ImpostoServico", "TextBox")
2309: 		WITH THIS.txt_4c_ImpostoServico
2310: 			.Top           = 193
2311: 			.Left          = 380
2312: 			.Width         = 59
2313: 			.Height        = 21
2314: 			.Alignment     = 3
2315: 			.Format        = "K"
2316: 			.InputMask     = "999.9999"
2317: 			.Margin        = 0
2318: 			.SpecialEffect = 1
2319: 			.ForeColor     = RGB(0, 0, 0)
2320: 			.BorderColor   = RGB(100, 100, 100)
2321: 			.Value         = THIS.this_oBusinessObject.this_nPTax3s
2322: 			.Enabled       = loc_lPodeEditar
2323: 			.Visible       = .T.
2324: 		ENDWITH
2325: 		BINDEVENT(THIS.txt_4c_ImpostoServico, "KeyPress", THIS, "TxtImpostoServicoKeyPress")
2326: 	ENDPROC
2327: 
2328: 	*==========================================================================
2329: 	* TxtContingenteKeyPress - legado SIGOPORC.getPtax2.Valid. Perc1s
2330: 	* ("Contingente") - aplicado em TODOS os itens quando P&G.
2331: 	*==========================================================================
2332: 	PROCEDURE TxtContingenteKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2333: 		LOCAL loc_cItens, loc_nItens, loc_nValor
2334: 
2335: 		IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
2336: 			RETURN
2337: 		ENDIF
2338: 		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
2339: 			RETURN
2340: 		ENDIF
2341: 		IF EMPTY(THIS.txt_4c_Contingente.Value)
2342: 			RETURN
2343: 		ENDIF
2344: 
2345: 		loc_nValor = THIS.txt_4c_Contingente.Value
2346: 		THIS.this_oBusinessObject.this_nPTax2s = loc_nValor
2347: 
2348: 		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
2349: 		IF USED(loc_cItens) AND THIS.this_oBusinessObject.this_nDivNotas = 2
2350: 			SELECT (loc_cItens)
2351: 			loc_nItens = citens
2352: 			SCAN
2353: 				REPLACE perc1s WITH loc_nValor, ;
2354: 					tota1s WITH (totas * loc_nValor) / 100, ;
2355: 					tota2s WITH ((totas + tota1s) * perc2s) / 100, ;
2356: 					tota3s WITH ((totas + tota1s + tota2s) * perc3s) / 100, ;
2357: 					tota4s WITH IIF(perc4s = 0, 0, ((totas + tota1s + tota2s + tota3s) / (1 - perc4s / 100)) - (totas + tota1s + tota2s + tota3s)), ;
2358: 					tota5s WITH totas + tota1s + tota2s + tota3s + tota4s
2359: 			ENDSCAN
2360: 			= SEEK(loc_nItens, loc_cItens, "citens")
2361: 		ENDIF
2362: 
2363: 		THIS.TotalizarItn()
2364: 	ENDPROC
2365: 
2366: 	*==========================================================================
2367: 	* TxtTaxaAdmKeyPress - legado SIGOPORC.getPtaxa.Valid. Perc2s
2368: 	* ("Taxa Adm./Lucro") quando P&G; quando SRCOM, aplica Perc1s/Perc2s/
2369: 	* Perc3s so na linha de bloco TAXA (fee da produtora).
2370: 	*==========================================================================
2371: 	PROCEDURE TxtTaxaAdmKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2372: 		LOCAL loc_cItens, loc_nItens, loc_nValor
2373: 
2374: 		IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
2375: 			RETURN
2376: 		ENDIF
2377: 		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
2378: 			RETURN
2379: 		ENDIF
2380: 		IF EMPTY(THIS.txt_4c_TaxaAdm.Value)
2381: 			RETURN
2382: 		ENDIF
2383: 
2384: 		loc_nValor = THIS.txt_4c_TaxaAdm.Value
2385: 		THIS.this_oBusinessObject.this_nDescs = loc_nValor
2386: 
2387: 		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
2388: 		IF USED(loc_cItens)
2389: 			SELECT (loc_cItens)
2390: 			loc_nItens = citens
2391: 
2392: 			IF THIS.this_oBusinessObject.this_nDivNotas = 2
2393: 				SCAN
2394: 					REPLACE perc2s WITH loc_nValor, ;
2395: 						tota2s WITH ((totas + tota1s) * loc_nValor) / 100, ;
2396: 						tota3s WITH ((totas + tota1s + tota2s) * perc3s) / 100, ;
2397: 						tota4s WITH IIF(perc4s = 0, 0, ((totas + tota1s + tota2s + tota3s) / (1 - perc4s / 100)) - (totas + tota1s + tota2s + tota3s)), ;
2398: 						tota5s WITH totas + tota1s + tota2s + tota3s + tota4s
2399: 				ENDSCAN
2400: 			ELSE
2401: 				GO TOP
2402: 				LOCATE FOR ALLTRIM(cblocos) == "TAXA"
2403: 				IF FOUND()
2404: 					REPLACE perc1s WITH loc_nValor, perc2s WITH loc_nValor, perc3s WITH loc_nValor
2405: 				ENDIF
2406: 			ENDIF
2407: 
2408: 			= SEEK(loc_nItens, loc_cItens, "citens")
2409: 		ENDIF
2410: 
2411: 		THIS.TotalizarItn()
2412: 	ENDPROC
2413: 
2414: 	*==========================================================================
2415: 	* TxtBVKeyPress - legado SIGOPORC.getPTax1.Valid. Perc3s ("BV") -
2416: 	* aplicado em TODOS os itens quando P&G.
2417: 	*==========================================================================
2418: 	PROCEDURE TxtBVKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2419: 		LOCAL loc_cItens, loc_nItens, loc_nValor
2420: 
2421: 		IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
2422: 			RETURN
2423: 		ENDIF
2424: 		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
2425: 			RETURN
2426: 		ENDIF
2427: 		IF EMPTY(THIS.txt_4c_BV.Value)
2428: 			RETURN
2429: 		ENDIF
2430: 
2431: 		loc_nValor = THIS.txt_4c_BV.Value
2432: 		THIS.this_oBusinessObject.this_nPTax1s = loc_nValor
2433: 
2434: 		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
2435: 		IF USED(loc_cItens) AND THIS.this_oBusinessObject.this_nDivNotas = 2
2436: 			SELECT (loc_cItens)
2437: 			loc_nItens = citens
2438: 			SCAN
2439: 				REPLACE perc3s WITH loc_nValor, ;
2440: 					tota3s WITH ((totas + tota1s + tota2s) * loc_nValor) / 100, ;
2441: 					tota4s WITH IIF(perc4s = 0, 0, ((totas + tota1s + tota2s + tota3s) / (1 - perc4s / 100)) - (totas + tota1s + tota2s + tota3s)), ;
2442: 					tota5s WITH totas + tota1s + tota2s + tota3s + tota4s
2443: 			ENDSCAN
2444: 			= SEEK(loc_nItens, loc_cItens, "citens")
2445: 		ENDIF
2446: 
2447: 		THIS.TotalizarItn()
2448: 	ENDPROC
2449: 
2450: 	*==========================================================================
2451: 	* TxtImpostoKeyPress - legado SIGOPORC.getPimposto.Valid. Perc4s
2452: 	* (imposto cheio) - aplicado em TODOS os itens quando P&G.
2453: 	*==========================================================================
2454: 	PROCEDURE TxtImpostoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2455: 		LOCAL loc_cItens, loc_nItens, loc_nValor
2456: 
2457: 		IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
2458: 			RETURN
2459: 		ENDIF
2460: 		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
2461: 			RETURN
2462: 		ENDIF
2463: 		IF EMPTY(THIS.txt_4c_Imposto.Value)
2464: 			RETURN
2465: 		ENDIF
2466: 
2467: 		loc_nValor = THIS.txt_4c_Imposto.Value
2468: 		THIS.this_oBusinessObject.this_nAcres = loc_nValor
2469: 
2470: 		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
2471: 		IF USED(loc_cItens) AND THIS.this_oBusinessObject.this_nDivNotas = 2
2472: 			SELECT (loc_cItens)
2473: 			loc_nItens = citens
2474: 			SCAN
2475: 				REPLACE perc4s WITH loc_nValor, ;
2476: 					tota4s WITH IIF(perc4s = 0, 0, ((totas + tota1s + tota2s + tota3s) / (1 - perc4s / 100)) - (totas + tota1s + tota2s + tota3s)), ;
2477: 					tota5s WITH totas + tota1s + tota2s + tota3s + tota4s
2478: 			ENDSCAN
2479: 			= SEEK(loc_nItens, loc_cItens, "citens")
2480: 		ENDIF
2481: 
2482: 		THIS.TotalizarItn()
2483: 	ENDPROC
2484: 
2485: 	*==========================================================================
2486: 	* TxtImpostoServicoKeyPress - legado SIGOPORC.getPservico.Valid.
2487: 	* Perc4s (imposto, variante "sem ISS") - aplicado SO nos itens
2488: 	* marcados como Servicos, quando P&G.
2489: 	*==========================================================================
2490: 	PROCEDURE TxtImpostoServicoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2491: 		LOCAL loc_cItens, loc_nItens, loc_nValor
2492: 
2493: 		IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
2494: 			RETURN
2495: 		ENDIF
2496: 		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
2497: 			RETURN
2498: 		ENDIF
2499: 		IF EMPTY(THIS.txt_4c_ImpostoServico.Value)
2500: 			RETURN
2501: 		ENDIF
2502: 
2503: 		loc_nValor = THIS.txt_4c_ImpostoServico.Value
2504: 		THIS.this_oBusinessObject.this_nPTax3s = loc_nValor
2505: 
2506: 		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
2507: 		IF USED(loc_cItens) AND THIS.this_oBusinessObject.this_nDivNotas = 2
2508: 			SELECT (loc_cItens)
2509: 			loc_nItens = citens
2510: 			SCAN FOR servicos
2511: 				REPLACE perc4s WITH loc_nValor, ;
2512: 					tota4s WITH IIF(perc4s = 0, 0, ((totas + tota1s + tota2s + tota3s) / (1 - perc4s / 100)) - (totas + tota1s + tota2s + tota3s)), ;
2513: 					tota5s WITH totas + tota1s + tota2s + tota3s + tota4s
2514: 			ENDSCAN
2515: 			= SEEK(loc_nItens, loc_cItens, "citens")
2516: 		ENDIF
2517: 
2518: 		THIS.TotalizarItn()
2519: 	ENDPROC
2520: 
2521: 	*==========================================================================
2522: 	* TotalizarItn - legado SIGOPORC.TotalizarItn. Motor de calculo
2523: 	* chamado por calc_valite (fase posterior) e pelos 5 campos de
2524: 	* percentual (acima). TRANSCRITO LITERALMENTE do dump
2525: 	* (PROCEDURE totalizaritn): consolida Tota1s..Tota10s do item
2526: 	* corrente (P&G ou SRCOM), depois os subtotais por bloco (Citem2),
2527: 	* sub-bloco (Citem3) e total geral (TOTALGERAL/Decupagem), e por fim
2528: 	* propaga o resultado para as parcelas do item (crSigMvOrp/
2529: 	* cursor_4c_Parcelas) via Valos.
2530: 	*
2531: 	* As linhas marcadoras (SUBTOTAL/SUBTOTAIS/TAXA/TOTAL/IMPOSTO/
2532: 	* TOTALGERAL) ainda nao sao criadas nesta fase (btnInsBlo/btnInsSub -
2533: 	* Fase 6): os LOCATE que as procuram nao encontram nada e os blocos
2534: 	* protegidos por "IF !EOF()"/"IF FOUND()" (que e exatamente como o
2535: 	* legado guarda esses trechos) ficam no-op em silencio, sem erro -
2536: 	* comportamento seguro e idempotente ate essas linhas existirem.
2537: 	*
2538: 	* perc1s..perc6s sao campos de TRABALHO do cursor (nao existem na
2539: 	* tabela SigMvOrc - ver comentario de CriarCursorItens); so
2540: 	* Tota1s..Tota10s sao persistidos pelo BO.
2541: 	*==========================================================================
2542: 	PROTECTED PROCEDURE TotalizarItn()
2543: 		LOCAL loc_cItens, loc_cParcelas, loc_nItens, loc_nItem2, loc_nItem3, loc_nItAgr, loc_nTaxa1, loc_nTaxa2, loc_nTaxa3, loc_nImpo1, loc_nImpo2, loc_nImpo3, loc_nSubtot
2544: 
2545: 		loc_cItens    = THIS.this_oBusinessObject.this_cCursorItens
2546: 		loc_cParcelas = THIS.this_oBusinessObject.this_cCursorParcelas
2547: 
2548: 		IF !USED(loc_cItens) OR EOF(loc_cItens)
2549: 			RETURN
2550: 		ENDIF
2551: 
2552: 		THIS.LockScreen = .T.
2553: 
2554: 		SELECT (loc_cItens)
2555: 		loc_nItens = citens
2556: 		loc_nItem2 = citem2
2557: 		loc_nItem3 = citem3
2558: 		loc_nItAgr = citagrs
2559: 
2560: 		IF THIS.this_oBusinessObject.this_nDivNotas = 2
2561: 			*-- P&G
2562: 			REPLACE tota1s WITH IIF(perc1s = 0, tota1s, (totas * perc1s) / 100), ;
2563: 				tota2s WITH IIF(perc2s = 0, tota2s, ((totas + tota1s) * perc2s) / 100), ;
2564: 				tota3s WITH IIF(perc3s = 0, tota3s, ((totas + tota1s + tota2s) * perc3s) / 100)
2565: 			REPLACE tota4s WITH IIF(perc4s = 0, 0, ((totas + tota1s + tota2s + tota3s) / (1 - perc4s / 100)) - (totas + tota1s + tota2s + tota3s))
2566: 			REPLACE tota5s WITH totas + tota1s + tota2s + tota3s + tota4s
2567: 		ELSE
2568: 			*-- SRCOM: total dos valores de NF SRCOM e fornecedor
2569: 			IF EMPTY(perc2s) AND EMPTY(perc3s)
2570: 				REPLACE tota1s WITH totas, tota2s WITH 0, tota3s WITH 0
2571: 			ELSE
2572: 				REPLACE tota1s WITH 0, tota2s WITH (perc2s * totas) / 100, tota3s WITH (perc3s * totas) / 100
2573: 			ENDIF
2574: 
2575: 			*-- Incentivos conforme o percentual informado
2576: 			REPLACE tota4s WITH (totas * perc4s) / 100, tota5s WITH (totas * perc5s) / 100, tota6s WITH (totas * perc6s) / 100
2577: 			*-- Saldo real SRCOM custos internos / fornecedor
2578: 			REPLACE tota9s WITH IIF(!EMPTY(tota1s), tota1s - tota8s, tota2s) - tota7s, ;
2579: 				tota10s WITH IIF(!EMPTY(tota1s), 0, tota3s - tota8s)
2580: 
2581: 			IF INT(VAL(SUBSTR(THIS.this_oBusinessObject.this_cConfigGers, 192, 1))) = 1
2582: 				*-- Decupagem

*-- Linhas 2743 a 2836:
2743: 	* nao existe em SigCdPro. Geometria/MaxLength/ToolTipText TRANSCRITOS
2744: 	* do dump.
2745: 	*==========================================================================
2746: 	PROTECTED PROCEDURE ConfigurarCampoNovoGrupo()
2747: 		LOCAL loc_lPodeEditar
2748: 		loc_lPodeEditar = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
2749: 
2750: 		THIS.AddObject("lbl_4c_NovoGrupo", "Label")
2751: 		WITH THIS.lbl_4c_NovoGrupo
2752: 			.FontName  = "Tahoma"
2753: 			.FontSize  = 8
2754: 			.Caption   = "\<Grupo"
2755: 			.Top       = 129
2756: 			.Left      = 499
2757: 			.Width     = 31
2758: 			.Height    = 15
2759: 			.ForeColor = RGB(90, 90, 90)
2760: 			.Visible   = .T.
2761: 		ENDWITH
2762: 
2763: 		THIS.AddObject("txt_4c_NovoGrupo", "TextBox")
2764: 		WITH THIS.txt_4c_NovoGrupo
2765: 			.Top           = 144
2766: 			.Left          = 495
2767: 			.Width         = 37
2768: 			.Height        = 23
2769: 			.FontBold      = .T.
2770: 			.MaxLength     = 3
2771: 			.SpecialEffect = 1
2772: 			.ToolTipText   = "Grupo Para Cadastro de Produtos"
2773: 			.ForeColor     = RGB(0, 0, 0)
2774: 			.BackColor     = RGB(255, 255, 232)
2775: 			.BorderColor   = RGB(100, 100, 100)
2776: 			.Value         = ""
2777: 			.Enabled       = loc_lPodeEditar
2778: 			.Visible       = .T.
2779: 		ENDWITH
2780: 		BINDEVENT(THIS.txt_4c_NovoGrupo, "LostFocus", THIS, "TxtNovoGrupoLostFocus")
2781: 	ENDPROC
2782: 
2783: 	*==========================================================================
2784: 	* TxtNovoGrupoLostFocus - legado SIGOPORC.get_NewGrp.Valid (+LostFocus,
2785: 	* que so move o foco - THIS.btnCadPro.SetFocus(), inalcancavel nesta
2786: 	* fase porque btnCadPro e Fase 6; por isso nao chamado aqui). Lookup
2787: 	* de Grupo de Produto, restrito por SigCdRpo (Dopps = Dopes do
2788: 	* cabecalho); se a restricao nao devolve nada, o legado cai para a
2789: 	* lista INTEIRA de SigCdGrp - transcrito literalmente.
2790: 	*
2791: 	* Regras #36/#37/#47: lookup em LostFocus (nao KeyPress), guarda de
2792: 	* reentrancia (o picker e modal), this_lAchouRegistro/Mostrar() ANTES
2793: 	* de decidir mostrar o dialogo, e NUNCA MsgAviso + apagar o digitado
2794: 	* quando a busca exata falha - so abre o picker (regra #50).
2795: 	*==========================================================================
2796: 	PROCEDURE TxtNovoGrupoLostFocus()
2797: 		LOCAL loc_cSQL, loc_nResultado, loc_cValorDigitado, loc_oErro
2798: 
2799: 		IF THIS.this_lEmLookupGrupo
2800: 			RETURN
2801: 		ENDIF
2802: 		THIS.this_lEmLookupGrupo = .T.
2803: 
2804: 		TRY
2805: 			loc_cValorDigitado = ALLTRIM(THIS.txt_4c_NovoGrupo.Value)
2806: 
2807: 			IF !EMPTY(loc_cValorDigitado)
2808: 				IF USED("cursor_4c_BuscaGrupo")
2809: 					USE IN cursor_4c_BuscaGrupo
2810: 				ENDIF
2811: 
2812: 				loc_cSQL = "SELECT a.Cgrus, a.DGrus FROM SigCdGrp a" + ;
2813: 					" INNER JOIN SigCdRpo b ON (a.Cgrus = b.Cgrus OR a.Mercs = b.Mercs)" + ;
2814: 					" WHERE b.Dopps = " + EscaparSQL(THIS.this_cDopes)
2815: 				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")
2816: 
2817: 				IF loc_nResultado <= 0 OR RECCOUNT("cursor_4c_BuscaGrupo") = 0
2818: 					IF USED("cursor_4c_BuscaGrupo")
2819: 						USE IN cursor_4c_BuscaGrupo
2820: 					ENDIF
2821: 					loc_nResultado = SQLEXEC(gnConnHandle, "SELECT a.Cgrus, a.DGrus FROM SigCdGrp a", "cursor_4c_BuscaGrupo")
2822: 				ENDIF
2823: 
2824: 				IF loc_nResultado > 0 AND USED("cursor_4c_BuscaGrupo")
2825: 					SELECT cursor_4c_BuscaGrupo
2826: 					GO TOP
2827: 					LOCATE FOR ALLTRIM(Cgrus) == loc_cValorDigitado
2828: 
2829: 					IF FOUND()
2830: 						THIS.txt_4c_NovoGrupo.Value = ALLTRIM(Cgrus)
2831: 					ELSE
2832: 						*-- Codigo digitado nao existe no universo restrito:
2833: 						*-- abre o picker (equivale ao fwBuscaInt do legado).
2834: 						*-- Regra #50: cancelando (ESC) o digitado PERMANECE,
2835: 						*-- nao se apaga o campo nem se exibe aviso.
2836: 						THIS.AbrirBuscaNovoGrupo()

*-- Linhas 2858 a 3114:
2858: 	*
2859: 	* getDpros (TextBox/fwget) e getDpro2s (EditBox/fwmemo, mapeamento.json
2860: 	* confirma a classe) SO ficam editaveis quando this_lProcura = .T.
2861: 	* (legado: "PROCEDURE When / Return thisform.lProcura") - fora do modo
2862: 	* de busca espelham a descricao do item corrente, escritas por
2863: 	* GradeItensAfterRowColChange. .Enabled, nao .ReadOnly: reproduz o
2864: 	* efeito do When (campo nao alcancavel por Tab/clique) sem inventar
2865: 	* estado novo.
2866: 	*==========================================================================
2867: 	PROTECTED PROCEDURE ConfigurarCampoBusca()
2868: 		THIS.AddObject("txt_4c_ProcuraDpros", "TextBox")
2869: 		WITH THIS.txt_4c_ProcuraDpros
2870: 			.Top           = 481
2871: 			.Left          = 16
2872: 			.Width         = 290
2873: 			.Height        = 21
2874: 			.FontSize      = 8
2875: 			.Alignment     = 3
2876: 			.Format        = "K"
2877: 			.Margin        = 0
2878: 			.SpecialEffect = 1
2879: 			.ForeColor     = RGB(0, 0, 0)
2880: 			.BorderColor   = RGB(100, 100, 100)
2881: 			.Value         = ""
2882: 			.Enabled       = .F.
2883: 			.Visible       = .T.
2884: 		ENDWITH
2885: 		BINDEVENT(THIS.txt_4c_ProcuraDpros, "KeyPress", THIS, "ProcuraDprosKeyPress")
2886: 		BINDEVENT(THIS.txt_4c_ProcuraDpros, "LostFocus", THIS, "ProcuraDprosLostFocus")
2887: 
2888: 		THIS.AddObject("edt_4c_ProcuraDpro2s", "EditBox")
2889: 		WITH THIS.edt_4c_ProcuraDpro2s
2890: 			.Top           = 481
2891: 			.Left          = 307
2892: 			.Width         = 290
2893: 			.Height        = 21
2894: 			.FontSize      = 8
2895: 			.SpecialEffect = 1
2896: 			.ForeColor     = RGB(0, 0, 0)
2897: 			.BorderColor   = RGB(100, 100, 100)
2898: 			.Value         = ""
2899: 			.Enabled       = .F.
2900: 			.Visible       = .T.
2901: 		ENDWITH
2902: 		BINDEVENT(THIS.edt_4c_ProcuraDpro2s, "KeyPress", THIS, "ProcuraDpro2sKeyPress")
2903: 		BINDEVENT(THIS.edt_4c_ProcuraDpro2s, "LostFocus", THIS, "ProcuraDpro2sLostFocus")
2904: 
2905: 		THIS.AddObject("cmd_4c_Procurar", "CommandButton")
2906: 		WITH THIS.cmd_4c_Procurar
2907: 			.Top             = 481
2908: 			.Left            = 600
2909: 			.Height          = 21
2910: 			.Width           = 40
2911: 			.Caption         = ""
2912: 			.ToolTipText     = "Procurar Item"
2913: 			.Picture         = gc_4c_CaminhoIcones + "geral_lupa_16.jpg"
2914: 			.DisabledPicture = gc_4c_CaminhoIcones + "geral_lupa_16.jpg"
2915: 			.Themes          = .T.
2916: 			.Visible         = .T.
2917: 		ENDWITH
2918: 		BINDEVENT(THIS.cmd_4c_Procurar, "Click", THIS, "BtnProcurarClick")
2919: 	ENDPROC
2920: 
2921: 	*==========================================================================
2922: 	* ProcuraDprosKeyPress / ProcuraDpro2sKeyPress - legado SIGOPORC.getDpros/
2923: 	* getDpro2s.Valid (disparado so com this_lProcura = .T., porque fora
2924: 	* disso os campos ficam Enabled = .F. e nao recebem KeyPress). Mesmo
2925: 	* comportamento do legado: LOCATE (sem SEEK/GO) move o registro
2926: 	* corrente da grade para a primeira linha cujo Dpros/Dpro2s contem o
2927: 	* texto digitado - o Refresh so repinta o que o LOCATE ja moveu.
2928: 	*==========================================================================
2929: 	PROCEDURE ProcuraDprosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2930: 		LOCAL loc_cItens, loc_cValor
2931: 
2932: 		IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
2933: 			RETURN
2934: 		ENDIF
2935: 
2936: 		loc_cValor = ALLTRIM(THIS.txt_4c_ProcuraDpros.Value)
2937: 		IF EMPTY(loc_cValor)
2938: 			RETURN
2939: 		ENDIF
2940: 
2941: 		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
2942: 		IF USED(loc_cItens)
2943: 			SELECT (loc_cItens)
2944: 			GO TOP
2945: 			LOCATE FOR LIKE("*" + loc_cValor + "*", dpros)
2946: 			THIS.grd_4c_Itens.Refresh()
2947: 		ENDIF
2948: 	ENDPROC
2949: 
2950: 	PROCEDURE ProcuraDpro2sKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2951: 		LOCAL loc_cItens, loc_cValor
2952: 
2953: 		IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
2954: 			RETURN
2955: 		ENDIF
2956: 
2957: 		loc_cValor = ALLTRIM(THIS.edt_4c_ProcuraDpro2s.Value)
2958: 		IF EMPTY(loc_cValor)
2959: 			RETURN
2960: 		ENDIF
2961: 
2962: 		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
2963: 		IF USED(loc_cItens)
2964: 			SELECT (loc_cItens)
2965: 			GO TOP
2966: 			LOCATE FOR LIKE("*" + loc_cValor + "*", dpro2s)
2967: 			THIS.grd_4c_Itens.Refresh()
2968: 		ENDIF
2969: 	ENDPROC
2970: 
2971: 	*==========================================================================
2972: 	* ProcuraDprosLostFocus / ProcuraDpro2sLostFocus - legado: "If !Empty
2973: 	* (this.Value) / thisform.btnprocura.SetFocus()". So move o foco (nao
2974: 	* dispara busca nenhuma) - a busca ja rodou no Enter/Tab acima.
2975: 	*==========================================================================
2976: 	PROCEDURE ProcuraDprosLostFocus()
2977: 		IF !EMPTY(THIS.txt_4c_ProcuraDpros.Value)
2978: 			THIS.cmd_4c_Procurar.SetFocus()
2979: 		ENDIF
2980: 	ENDPROC
2981: 
2982: 	PROCEDURE ProcuraDpro2sLostFocus()
2983: 		IF !EMPTY(THIS.edt_4c_ProcuraDpro2s.Value)
2984: 			THIS.cmd_4c_Procurar.SetFocus()
2985: 		ENDIF
2986: 	ENDPROC
2987: 
2988: 	*==========================================================================
2989: 	* BtnProcurarClick - legado SIGOPORC.btnProcura.Click. Botao de DUAS
2990: 	* fases, igual ao legado: 1o clique entra em modo de busca (habilita
2991: 	* os dois campos, limpa e foca); clique seguinte (ja em modo de busca)
2992: 	* EXECUTA a busca pelo campo preenchido - Dpros tem prioridade sobre
2993: 	* Dpro2s quando os dois estao preenchidos (legado: "Iif(!Empty(getDpros.
2994: 	* Value), getDpros.Value, getDpro2s.Value)"). this_lProcura SO volta a
2995: 	* .F. quando a grade troca de linha (GradeItensAfterRowColChange) -
2996: 	* exatamente como no legado, que nunca reseta a flag aqui dentro.
2997: 	*==========================================================================
2998: 	PROCEDURE BtnProcurarClick()
2999: 		LOCAL loc_cItens, loc_nItem, loc_cProcura, loc_lPorDpros
3000: 
3001: 		*-- "When" do legado (Inlist(Op_Escolha,[INSERIR],[ALTERAR])) como
3002: 		*-- guarda no handler: btnProcura e botao SO-ICONE (Caption = "" no
3003: 		*-- dump) e NAO pode receber .Enabled = .F. - com Caption vazio o
3004: 		*-- VFP9 deixa de desenhar o Picture e o botao vira um retangulo
3005: 		*-- vazio (CorretorAutomatico #106). BINDEVENT tambem descarta o
3006: 		*-- retorno do delegate, entao um When ligado por BINDEVENT nao
3007: 		*-- bloquearia nada.
3008: 		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
3009: 			RETURN
3010: 		ENDIF
3011: 
3012: 		IF !THIS.this_lProcura
3013: 			THIS.this_lProcura = .T.
3014: 
3015: 			THIS.txt_4c_ProcuraDpros.Enabled  = .T.
3016: 			THIS.edt_4c_ProcuraDpro2s.Enabled = .T.
3017: 			THIS.txt_4c_ProcuraDpros.Value    = ""
3018: 			THIS.edt_4c_ProcuraDpro2s.Value   = ""
3019: 
3020: 			THIS.txt_4c_ProcuraDpros.SetFocus()
3021: 		ELSE
3022: 			IF !EMPTY(THIS.txt_4c_ProcuraDpros.Value) OR !EMPTY(THIS.edt_4c_ProcuraDpro2s.Value)
3023: 				loc_lPorDpros = !EMPTY(THIS.txt_4c_ProcuraDpros.Value)
3024: 				loc_cProcura  = ALLTRIM(IIF(loc_lPorDpros, THIS.txt_4c_ProcuraDpros.Value, THIS.edt_4c_ProcuraDpro2s.Value))
3025: 
3026: 				loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
3027: 				IF USED(loc_cItens)
3028: 					SELECT (loc_cItens)
3029: 					loc_nItem = citens
3030: 					IF !EOF()
3031: 						SKIP
3032: 					ENDIF
3033: 					IF loc_lPorDpros
3034: 						LOCATE FOR LIKE("*" + loc_cProcura + "*", dpros) AND citens <> loc_nItem
3035: 					ELSE
3036: 						LOCATE FOR LIKE("*" + loc_cProcura + "*", dpro2s) AND citens <> loc_nItem
3037: 					ENDIF
3038: 					THIS.grd_4c_Itens.Refresh()
3039: 				ENDIF
3040: 			ENDIF
3041: 		ENDIF
3042: 	ENDPROC
3043: 
3044: 	*==========================================================================
3045: 	* ConfigurarImagemProduto - imgProds do legado: pre-visualizacao da foto
3046: 	* do produto do item corrente, oculta por padrao (Visible = .F. no
3047: 	* dump) - so aparece quando GradeItensAfterRowColChange encontra foto E
3048: 	* SigCdOpe.Imagems = 1 (this_nImagems, Fase posterior). Duplo clique
3049: 	* amplia (DblClick do legado - "Do Form SigOpZom"; SigOpZom nao foi
3050: 	* migrado, fallback ShellExecute igual ao de Formsigprccp.FigJpgDblClick).
3051: 	*==========================================================================
3052: 	PROTECTED PROCEDURE ConfigurarImagemProduto()
3053: 		THIS.AddObject("img_4c_Produto", "Image")
3054: 		WITH THIS.img_4c_Produto
3055: 			.Top         = 108
3056: 			.Left        = 579
3057: 			.Width       = 159
3058: 			.Height      = 89
3059: 			.Stretch     = 1
3060: 			.ToolTipText = "Imagem do Produto [Duplo Click Para Zoom]"
3061: 			.Picture     = ""
3062: 			.Visible     = .F.
3063: 		ENDWITH
3064: 		BINDEVENT(THIS.img_4c_Produto, "DblClick", THIS, "ImgProdutoDblClick")
3065: 	ENDPROC
3066: 
3067: 	*==========================================================================
3068: 	* ImgProdutoDblClick - legado SIGOPORC.imgProds.DblClick. Reextrai a
3069: 	* foto do PRODUTO CORRENTE para um arquivo temporario proprio e abre o
3070: 	* visualizador ampliado. Mesmo padrao canonico ja usado em
3071: 	* Formsigprccp.FigJpgDblClick (FormSigOpZom ainda nao foi migrado - o
3072: 	* fallback abre a imagem no visualizador do Windows via ShellExecute).
3073: 	*==========================================================================
3074: 	PROCEDURE ImgProdutoDblClick()
3075: 		LOCAL loc_cItens, loc_cCpros, loc_cDpros, loc_cSQL, loc_nResultado
3076: 		LOCAL loc_cFigJpgs, loc_cArqTemp, loc_cFoto, loc_cCaption, loc_oErro, loc_lProsseguir
3077: 		loc_lProsseguir = .T.
3078: 
3079: 		TRY
3080: 			loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
3081: 			IF !USED(loc_cItens) OR EOF(loc_cItens)
3082: 				loc_lProsseguir = .F.
3083: 			ENDIF
3084: 
3085: 			IF loc_lProsseguir
3086: 				loc_cCpros = ALLTRIM(TratarNulo(EVALUATE(loc_cItens + ".cpros"), ""))
3087: 				loc_cDpros = ALLTRIM(TratarNulo(EVALUATE(loc_cItens + ".dpros"), ""))
3088: 				IF EMPTY(loc_cCpros)
3089: 					loc_lProsseguir = .F.
3090: 				ENDIF
3091: 			ENDIF
3092: 
3093: 			IF loc_lProsseguir
3094: 				IF USED("cursor_4c_TmpFotoZom")
3095: 					USE IN cursor_4c_TmpFotoZom
3096: 				ENDIF
3097: 				loc_cSQL = "SELECT a.FigJpgs FROM SigCdPro a WHERE a.cpros = " + EscaparSQL(loc_cCpros)
3098: 				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpFotoZom")
3099: 
3100: 				IF loc_nResultado < 1 OR !USED("cursor_4c_TmpFotoZom") OR RECCOUNT("cursor_4c_TmpFotoZom") = 0
3101: 					loc_lProsseguir = .F.
3102: 				ENDIF
3103: 			ENDIF
3104: 
3105: 			IF loc_lProsseguir
3106: 				SELECT cursor_4c_TmpFotoZom
3107: 				GO TOP
3108: 				loc_cFigJpgs = TratarNulo(cursor_4c_TmpFotoZom.FigJpgs, "")
3109: 				USE IN cursor_4c_TmpFotoZom
3110: 
3111: 				IF !EMPTY(loc_cFigJpgs)
3112: 					loc_cArqTemp = SYS(2023) + "\" + SYS(2015) + ".jpg"
3113: 					loc_cFoto = STRCONV( ;
3114: 						STRTRAN(STRTRAN(STRTRAN(loc_cFigJpgs, ;

*-- Linhas 3144 a 3277:
3144: 			MsgErro("Erro ao ampliar a foto do produto:" + CHR(13) + ;
3145: 				loc_oErro.Message + CHR(13) + ;
3146: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3147: 				"Procedure: " + loc_oErro.Procedure, "Erro")
3148: 		ENDTRY
3149: 	ENDPROC
3150: 
3151: 	*==========================================================================
3152: 	* ConfigurarDescritivoRodape - getDescritivo do legado: memo de rodape,
3153: 	* largura TOTAL, abaixo das duas grades. Por padrao (ControlSource =
3154: 	* TprMvCab.Obses, dado de cabecalho que esta fora do escopo deste BO)
3155: 	* o Init legado deixa INVISIVEL fora do modo Criacao - unico estado
3156: 	* alcancavel nesta fase, porque this_nDigItens so e preenchido em
3157: 	* fase posterior (SigCdOpe - ver cabecalho do BO). AtualizarModoCriacao
3158: 	* fica pronto para quando DigItens chegar: troca o ControlSource para
3159: 	* o Dpro2s do item corrente e mostra o campo (regra transcrita do
3160: 	* Init: "If Inlist(DigItens,6,7) ... thisform.getDescritivo.
3161: 	* ControlSource = [crSigMvOrc.Dpro2s] Else ... .Visible = .f.").
3162: 	*==========================================================================
3163: 	PROTECTED PROCEDURE ConfigurarDescritivoRodape()
3164: 		THIS.AddObject("edt_4c_DescritivoRodape", "EditBox")
3165: 		WITH THIS.edt_4c_DescritivoRodape
3166: 			.Top           = 481
3167: 			.Left          = 5
3168: 			.Width         = 989
3169: 			.Height        = 115
3170: 			.FontSize      = 8
3171: 			.SpecialEffect = 1
3172: 			.ForeColor     = RGB(0, 0, 0)
3173: 			.DisabledBackColor = RGB(255, 255, 255)
3174: 			.BorderColor   = RGB(100, 100, 100)
3175: 			.Value         = ""
3176: 			.Enabled       = .F.
3177: 			.Visible       = .F.
3178: 		ENDWITH
3179: 	ENDPROC
3180: 
3181: 	*==========================================================================
3182: 	* AtualizarModoCriacao - transcricao do bloco de LAYOUT do Init legado:
3183: 	* o ramo "Inlist(crSigCdOpe.DigItens,6,7)" (modo Criacao) e, no ramo
3184: 	* normal, a bifurcacao "LocalEmp.DIVNOTAS = 2" (P&G) / Else (SRCOM).
3185: 	* Decide QUEM APARECE e com que legenda/geometria; quem fica EDITAVEL e
3186: 	* decidido por HabilitarCampos()/AjustarBotoesPorModo() (os "When" do
3187: 	* legado). Chamado em InicializarForm e por CarregarDados - e
3188: 	* IDEMPOTENTE de proposito: cada controle recebe Visible nos DOIS
3189: 	* sentidos, nunca so no ramo que o esconde.
3190: 	*
3191: 	* Fase 8/8 - COMPLETADO: ate a fase anterior este metodo cobria apenas
3192: 	* edt_4c_DescritivoRodape e o trio de busca. O bloco legado toca ainda
3193: 	* say1..say6 + os 6 getP* (os seis pares label/campo de percentual),
3194: 	* grdParcela, btnIncluirp/btnExcluirp, btnTotItens e btnIteSub - todos
3195: 	* ficavam VISIVEIS em modo Criacao (onde o legado os esconde), e as
3196: 	* duas legendas que o P&G troca ("Lucro"/"Imposto Cheio") nunca eram
3197: 	* aplicadas. Mapa label->objeto do legado, conferido no dump:
3198: 	*   say5 -> lbl_4c_Margem          say4 -> lbl_4c_Contingente
3199: 	*   say1 -> lbl_4c_TaxaAdm         say3 -> lbl_4c_BV
3200: 	*   say2 -> lbl_4c_Imposto         say6 -> lbl_4c_ImpostoServico
3201: 	*
3202: 	* DESVIO DOCUMENTADO (geometria do ramo P&G): o legado faz
3203: 	* "grdItem.Height = 444" junto com "getDpros/getDpro2s/btnProcura.Top
3204: 	* = 570". Os dois numeros sao INCOMPATIVEIS entre si - com grdItem.Top
3205: 	* = 218, a altura 444 leva a grade ate 662, ou seja a grade cobriria a
3206: 	* linha de busca em 570 (e passaria do rodape do form, de 600). O SCX
3207: 	* nao declara Height do form (a secao de propriedades do form vem
3208: 	* VAZIA no dump), entao 444 nao e verificavel; 570 e, e cabe. Aqui
3209: 	* vale o 570 do legado (linha de busca encostada no rodape) e a grade
3210: 	* cresce ATE ela - Height = 350 (218 + 350 = 568) - em vez de 444.
3211: 	* Transcrever 444 ao pe da letra soterraria tres controles (regra #30:
3212: 	* controle recortado/coberto some sem erro e sem aparecer em
3213: 	* screenshot).
3214: 	*==========================================================================
3215: 	PROTECTED PROCEDURE AtualizarModoCriacao()
3216: 		LOCAL loc_cItens, loc_lModoCriacao, loc_lPG, loc_lMostraPerc, ;
3217: 			loc_lPercSoPG, loc_lMostraParcelas
3218: 
3219: 		loc_cItens       = THIS.this_oBusinessObject.this_cCursorItens
3220: 		loc_lModoCriacao = INLIST(THIS.this_oBusinessObject.this_nDigItens, 6, 7)
3221: 		loc_lPG          = (THIS.this_oBusinessObject.this_nDivNotas = 2)
3222: 
3223: 		*-- Os 6 percentuais somem inteiros no modo Criacao. Fora dele,
3224: 		*-- Margem/Contingente/BV/Imposto sem ISS so existem em P&G
3225: 		*-- (o Else SRCOM do legado esconde esses quatro); Taxa Adm. e
3226: 		*-- Imposto aparecem nos dois.
3227: 		loc_lMostraPerc = !loc_lModoCriacao
3228: 		loc_lPercSoPG   = loc_lMostraPerc AND loc_lPG
3229: 
3230: 		*-- A grade de parcelas (e seus dois botoes) sai da tela tanto no
3231: 		*-- modo Criacao quanto em P&G - nos dois ramos o legado faz
3232: 		*-- "grdParcela.Visible = .f." + "btnIncluirp/btnExcluirp .Visible/
3233: 		*-- .Enabled = .f.". Previsao de pagamento so existe em SRCOM.
3234: 		loc_lMostraParcelas = !loc_lModoCriacao AND !loc_lPG
3235: 
3236: 		*-- Pares label/campo dos percentuais
3237: 		THIS.lbl_4c_Margem.Visible         = loc_lPercSoPG
3238: 		THIS.txt_4c_Margem.Visible         = loc_lPercSoPG
3239: 		THIS.lbl_4c_Contingente.Visible    = loc_lPercSoPG
3240: 		THIS.txt_4c_Contingente.Visible    = loc_lPercSoPG
3241: 		THIS.lbl_4c_BV.Visible             = loc_lPercSoPG
3242: 		THIS.txt_4c_BV.Visible             = loc_lPercSoPG
3243: 		THIS.lbl_4c_ImpostoServico.Visible = loc_lPercSoPG
3244: 		THIS.txt_4c_ImpostoServico.Visible = loc_lPercSoPG
3245: 
3246: 		THIS.lbl_4c_TaxaAdm.Visible        = loc_lMostraPerc
3247: 		THIS.txt_4c_TaxaAdm.Visible        = loc_lMostraPerc
3248: 		THIS.lbl_4c_Imposto.Visible        = loc_lMostraPerc
3249: 		THIS.txt_4c_Imposto.Visible        = loc_lMostraPerc
3250: 
3251: 		*-- Legendas que o ramo P&G troca (say1/say2 do legado)
3252: 		IF loc_lPG
3253: 			THIS.lbl_4c_TaxaAdm.Caption = "Lucro :                %"
3254: 			THIS.lbl_4c_Imposto.Caption = "Imposto Cheio :                %"
3255: 		ELSE
3256: 			THIS.lbl_4c_TaxaAdm.Caption = "Ta\<xa Adm. :                     %"
3257: 			THIS.lbl_4c_Imposto.Caption = "Im\<posto :                     %"
3258: 		ENDIF
3259: 
3260: 		*-- Grade de parcelas e seus botoes
3261: 		THIS.grd_4c_Parcelas.Visible       = loc_lMostraParcelas
3262: 		THIS.grd_4c_Parcelas.Enabled       = loc_lMostraParcelas
3263: 		THIS.cmd_4c_IncluirParcela.Visible = loc_lMostraParcelas
3264: 		THIS.cmd_4c_ExcluirParcela.Visible = loc_lMostraParcelas
3265: 
3266: 		*-- Botoes do rodape que o modo Criacao esconde
3267: 		THIS.cmd_4c_TotItens.Visible = !loc_lModoCriacao
3268: 		THIS.cmd_4c_IteSub.Visible   = !loc_lModoCriacao
3269: 
3270: 		IF loc_lModoCriacao
3271: 			*-- Criacao: o descritivo do rodape entra ligado ao item corrente
3272: 			*-- (legado: getDescritivo.ControlSource = [crSigMvOrc.Dpro2s]) e
3273: 			*-- a linha de busca sai inteira.
3274: 			THIS.edt_4c_DescritivoRodape.Visible = .T.
3275: 			IF USED(loc_cItens)
3276: 				THIS.edt_4c_DescritivoRodape.ControlSource = loc_cItens + ".dpro2s"
3277: 			ENDIF

*-- Linhas 3321 a 3565:
3321: 	* repinta a grade ligada a ele, por isso o Refresh fica no funil
3322: 	* CarregarDados e no handler de troca de linha (regra #21).
3323: 	*==========================================================================
3324: 	PROTECTED PROCEDURE PosicionarParcelasDoItem()
3325: 		LOCAL loc_cItens, loc_cParcelas, loc_nItem
3326: 		loc_cItens    = THIS.this_oBusinessObject.this_cCursorItens
3327: 		loc_cParcelas = THIS.this_oBusinessObject.this_cCursorParcelas
3328: 
3329: 		IF USED(loc_cParcelas)
3330: 			loc_nItem = 0
3331: 			IF USED(loc_cItens) AND !EOF(loc_cItens)
3332: 				loc_nItem = EVALUATE(loc_cItens + ".citens")
3333: 			ENDIF
3334: 
3335: 			SELECT (loc_cParcelas)
3336: 			SET ORDER TO
3337: 			SET ORDER TO TAG citens
3338: 			SET KEY TO loc_nItem
3339: 			GO TOP
3340: 		ENDIF
3341: 	ENDPROC
3342: 
3343: 	*==========================================================================
3344: 	* CarregarDados - FUNIL de carga da tela. PUBLIC de proposito: alem de
3345: 	* ser chamado pelo InicializarForm, o harness de teste
3346: 	* (TesteAutomatico.prg) o invoca de FORA da classe - com PROTECTED a
3347: 	* chamada estoura "Property CARREGARDADOS is not found", porque
3348: 	* PEMSTATUS(...,5) devolve .T. tambem para metodo protegido (regra #3).
3349: 	*
3350: 	* Ordem (a mesma do Init legado): garantir os cursores -> aplicar o
3351: 	* layout do modo (AtualizarModoCriacao) -> CarregarLista (vincular as
3352: 	* duas grades, ler do banco, posicionar os aliases e repintar) ->
3353: 	* BOParaForm (percentuais do cabecalho na tela).
3354: 	*
3355: 	* Fase 8/8: a parte de RECARGA saiu daqui para CarregarLista(), que e
3356: 	* o funil chamado tambem pelas recargas posteriores - antes a leitura
3357: 	* do banco + bind + reposicionamento + Refresh existiam SO aqui, e
3358: 	* quem precisasse reler teria de duplicar a sequencia. CarregarDados
3359: 	* continua PUBLIC e continua sendo o ponto de entrada do InicializarForm
3360: 	* e do harness.
3361: 	*
3362: 	* Nao estoura quando os cursores ainda nao existem (caso do harness, que
3363: 	* instancia o form sem chamador): o resultado sai por flag e o RETURN e
3364: 	* unico, depois do ENDTRY (regra #1).
3365: 	*==========================================================================
3366: 	PROCEDURE CarregarDados()
3367: 		LOCAL loc_lSucesso, loc_oErro, loc_cItens, loc_cParcelas
3368: 		loc_lSucesso = .F.
3369: 
3370: 		TRY
3371: 			loc_cItens    = THIS.this_oBusinessObject.this_cCursorItens
3372: 			loc_cParcelas = THIS.this_oBusinessObject.this_cCursorParcelas
3373: 
3374: 			IF !USED(loc_cItens)
3375: 				THIS.CriarCursorItens()
3376: 			ENDIF
3377: 
3378: 			IF !USED(loc_cParcelas)
3379: 				THIS.CriarCursorParcelas()
3380: 			ENDIF
3381: 
3382: 			*-- Layout (quem aparece) ANTES da carga: AtualizarModoCriacao
3383: 			*-- liga o ControlSource de edt_4c_DescritivoRodape ao cursor e
3384: 			*-- fecha chamando HabilitarCampos/AjustarBotoesPorModo.
3385: 			THIS.AtualizarModoCriacao()
3386: 
3387: 			*-- Legado: AddCursor('SigMvOrc',...)/AddCursor('SigMvOrp',...) no
3388: 			*-- Init. Vincular as grades, ler do banco, posicionar os aliases
3389: 			*-- e repintar ficam todos em CarregarLista (funil de recarga),
3390: 			*-- para a primeira carga e as recargas seguintes seguirem
3391: 			*-- exatamente o mesmo caminho.
3392: 			loc_lSucesso = THIS.CarregarLista()
3393: 
3394: 			*-- Valores do cabecalho (percentuais) para a tela - no legado
3395: 			*-- vinham sozinhos pelo ControlSource = TprMvCab.<coluna>
3396: 			THIS.BOParaForm()
3397: 		CATCH TO loc_oErro
3398: 			MsgErro(loc_oErro.Message + CHR(13) + ;
3399: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3400: 				"Procedure: " + loc_oErro.Procedure, ;
3401: 				"Erro em Formsigoporc.CarregarDados")
3402: 		ENDTRY
3403: 
3404: 		RETURN loc_lSucesso
3405: 	ENDPROC
3406: 
3407: 	*==========================================================================
3408: 	* GradeItensAfterRowColChange - Troca de linha na grade de itens: refaz
3409: 	* o filtro da grade de parcelas (mestre-detalhe), espelha a descricao
3410: 	* do item nos campos de busca, reseta o modo de busca e atualiza a
3411: 	* pre-visualizacao da foto do produto. Ligado por BINDEVENT, por isso
3412: 	* declara o parametro do evento (regra #3: handler sem parametro
3413: 	* ligado a AfterRowColChange estoura).
3414: 	*
3415: 	* Uso CORRETO de AfterRowColChange - carregar o DETALHE da linha
3416: 	* corrente, SEM filtrar por coluna (regra #46). Validacao de celula nao
3417: 	* entra aqui: vai no Valid do TextBox da Column.
3418: 	*
3419: 	* O grdItem.AfterRowColChange do legado faz mais coisas, que dependem de
3420: 	* btnCadPro/Get_NewGrp (Fase 7 - precisam de SigCdOpe.CadProds/CadProDs,
3421: 	* ainda nao carregados) e da troca do DynamicForeColor pelo CitAgrs.
3422: 	*==========================================================================
3423: 	PROCEDURE GradeItensAfterRowColChange(par_nColIndex)
3424: 		LOCAL loc_cItens, loc_cDpros, loc_cDpro2s
3425: 
3426: 		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
3427: 
3428: 		*-- Legado: thisform.cItAgr = crSigMvOrc.CitAgrs (agrupador da linha
3429: 		*-- corrente, usado pelo realce de decupagem)
3430: 		IF USED(loc_cItens) AND !EOF(loc_cItens)
3431: 			THIS.this_nCItAgr = EVALUATE(loc_cItens + ".citagrs")
3432: 		ENDIF
3433: 
3434: 		*-- Legado: "thisform.lProcura = .f." + imgProds.Visible=.f./Picture=[]
3435: 		*-- no inicio do AfterRowColChange - toda troca de linha sai do modo
3436: 		*-- de busca e esconde a foto do produto anterior.
3437: 		THIS.this_lProcura = .F.
3438: 		THIS.img_4c_Produto.Visible = .F.
3439: 		THIS.img_4c_Produto.Picture = ""
3440: 
3441: 		*-- Legado: "thisform.getDPros.Value = crSigMvOrc.Dpros" / "getDPro2s.
3442: 		*-- Value = crSigMvOrc.Dpro2s" - fora do modo de busca os dois campos
3443: 		*-- so espelham a descricao do item corrente (ficam Enabled = .F.,
3444: 		*-- ver AtualizarModoCriacao).
3445: 		loc_cDpros  = ""
3446: 		loc_cDpro2s = ""
3447: 		IF USED(loc_cItens) AND !EOF(loc_cItens)
3448: 			loc_cDpros  = TratarNulo(EVALUATE(loc_cItens + ".dpros"), "")
3449: 			loc_cDpro2s = TratarNulo(EVALUATE(loc_cItens + ".dpro2s"), "")
3450: 		ENDIF
3451: 		THIS.txt_4c_ProcuraDpros.Enabled  = .F.
3452: 		THIS.edt_4c_ProcuraDpro2s.Enabled = .F.
3453: 		THIS.txt_4c_ProcuraDpros.Value    = loc_cDpros
3454: 		THIS.edt_4c_ProcuraDpro2s.Value   = loc_cDpro2s
3455: 
3456: 		THIS.CarregarImagemProdutoCorrente()
3457: 
3458: 		*-- Fase 7/8 - legado: "With ThisForm.btnCadPro / llVis = (InList(
3459: 		*-- crSigCdOpe.CadProds,1,3,4,5)) And fChecaAcesso('SigCdPro',
3460: 		*-- 'INSERIR') And InList(ThisForm.Op_Escolha,'INSERIR','ALTERAR') /
3461: 		*-- .Enabled = llVis And Not Eof(...) And (...)". CadProDs do legado
3462: 		*-- e a MESMA coluna que CadProds (VFP e case-insensitive) - this_nCadProds
3463: 		*-- cobre as duas grafias.
3464: 		THIS.AtualizarEstadoCadastroProduto()
3465: 
3466: 		THIS.PosicionarParcelasDoItem()
3467: 		THIS.grd_4c_Parcelas.Refresh()
3468: 	ENDPROC
3469: 
3470: 	*==========================================================================
3471: 	* AtualizarEstadoCadastroProduto - Habilita/desabilita cmd_4c_CadPro
3472: 	* (btnCadPro) e o par txt_4c_NovoGrupo/lbl_4c_NovoGrupo conforme a linha
3473: 	* corrente da grade de itens e SigCdOpe.CadProds - transcrito do final
3474: 	* do AfterRowColChange legado (fica em metodo proprio, chamado tambem
3475: 	* de BtnCadastroProdutoClick depois de confirmar um produto novo).
3476: 	*==========================================================================
3477: 	PROCEDURE AtualizarEstadoCadastroProduto()
3478: 		LOCAL loc_cItens, loc_lVisivel, loc_cCpros, loc_nCitens, loc_nCitem2, loc_cBlocos, loc_lLinhaNormal
3479: 
3480: 		IF !PEMSTATUS(THIS, "cmd_4c_CadPro", 5)
3481: 			RETURN
3482: 		ENDIF
3483: 
3484: 		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
3485: 
3486: 		loc_lVisivel = INLIST(THIS.this_oBusinessObject.this_nCadProds, 1, 3, 4, 5) AND ;
3487: 			fChecaAcesso("SigCdPro", "INSERIR") AND ;
3488: 			INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
3489: 
3490: 		IF !USED(loc_cItens) OR EOF(loc_cItens)
3491: 			THIS.cmd_4c_CadPro.Enabled = .F.
3492: 			RETURN
3493: 		ENDIF
3494: 
3495: 		loc_cCpros  = TratarNulo(EVALUATE(loc_cItens + ".cpros"), "")
3496: 		loc_nCitens = EVALUATE(loc_cItens + ".citens")
3497: 		loc_nCitem2 = EVALUATE(loc_cItens + ".citem2")
3498: 		loc_cBlocos = ALLTRIM(TratarNulo(EVALUATE(loc_cItens + ".cblocos"), ""))
3499: 
3500: 		loc_lLinhaNormal = (loc_nCitens <> loc_nCitem2) AND ;
3501: 			!INLIST(loc_cBlocos, "SUBTOTAL", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "BRANCO", "TOTALGERAL")
3502: 
3503: 		THIS.cmd_4c_CadPro.Enabled = loc_lVisivel AND ;
3504: 			( ;
3505: 				(EMPTY(loc_cCpros) AND THIS.this_oBusinessObject.this_nCadProds = 1 AND loc_lLinhaNormal) OR ;
3506: 				(!EMPTY(loc_cCpros) AND THIS.this_oBusinessObject.this_nCadProds = 3 AND loc_lLinhaNormal) OR ;
3507: 				INLIST(THIS.this_oBusinessObject.this_nCadProds, 4, 5) ;
3508: 			)
3509: 
3510: 		IF THIS.this_oBusinessObject.this_nCadProds = 4
3511: 			THIS.txt_4c_NovoGrupo.Enabled = EMPTY(loc_cCpros)
3512: 			THIS.lbl_4c_NovoGrupo.Enabled = EMPTY(loc_cCpros)
3513: 			THIS.txt_4c_NovoGrupo.Value   = ""
3514: 		ENDIF
3515: 	ENDPROC
3516: 
3517: 	*==========================================================================
3518: 	* CarregarImagemProdutoCorrente - legado: trecho final do AfterRowColChange
3519: 	* que consulta SigCdPro.FigJpgs do item corrente e mostra a foto SE
3520: 	* SigCdOpe.Imagems = 1 E Confes <> 1 (this_nImagems/this_nConfes - Fase
3521: 	* posterior; com o default 0 este metodo e no-op, igual ao
3522: 	* comportamento seguro ja documentado para DigItens/DivNotas). Decode
3523: 	* UNICO de base64->JPEG (regra: nunca aplicar STRCONV(...,14) duas vezes).
3524: 	*==========================================================================
3525: 	PROTECTED PROCEDURE CarregarImagemProdutoCorrente()
3526: 		LOCAL loc_cItens, loc_cCpros, loc_cSQL, loc_nResultado, loc_cFigJpgs, loc_cFoto, loc_cArqTemp, loc_oErro
3527: 
3528: 		IF THIS.this_oBusinessObject.this_nImagems <> 1 OR THIS.this_oBusinessObject.this_nConfes = 1
3529: 			RETURN
3530: 		ENDIF
3531: 
3532: 		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
3533: 		IF !USED(loc_cItens) OR EOF(loc_cItens)
3534: 			RETURN
3535: 		ENDIF
3536: 
3537: 		loc_cCpros = ALLTRIM(TratarNulo(EVALUATE(loc_cItens + ".cpros"), ""))
3538: 		IF EMPTY(loc_cCpros)
3539: 			RETURN
3540: 		ENDIF
3541: 
3542: 		TRY
3543: 			IF USED("cursor_4c_TmpFotoItem")
3544: 				USE IN cursor_4c_TmpFotoItem
3545: 			ENDIF
3546: 			loc_cSQL = "SELECT a.FigJpgs FROM SigCdPro a WHERE a.cpros = " + EscaparSQL(loc_cCpros)
3547: 			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpFotoItem")
3548: 
3549: 			IF loc_nResultado >= 1 AND USED("cursor_4c_TmpFotoItem") AND RECCOUNT("cursor_4c_TmpFotoItem") > 0
3550: 				SELECT cursor_4c_TmpFotoItem
3551: 				GO TOP
3552: 				loc_cFigJpgs = TratarNulo(cursor_4c_TmpFotoItem.FigJpgs, "")
3553: 				USE IN cursor_4c_TmpFotoItem
3554: 
3555: 				IF !EMPTY(loc_cFigJpgs)
3556: 					loc_cArqTemp = SYS(2023) + "\" + go_4c_Sistema.Sys2015Tmp + "SigOpPro.jpg"
3557: 					loc_cFoto = STRCONV( ;
3558: 						STRTRAN(STRTRAN(STRTRAN(loc_cFigJpgs, ;
3559: 							"data:image/png;base64,", ""), ;
3560: 							"data:image/jpeg;base64,", ""), ;
3561: 							"data:image/jpg;base64,", ""), 14)
3562: 
3563: 					IF STRTOFILE(loc_cFoto, loc_cArqTemp) > 0
3564: 						THIS.img_4c_Produto.Picture = loc_cArqTemp
3565: 						THIS.img_4c_Produto.Visible = .T.

*-- Linhas 3585 a 3696:
3585: 	* Themes=.T. + DisabledPicture obrigatorios em standalone com Picture
3586: 	* (regra CLAUDE.md - sem isso o icone some quando Enabled=.F.).
3587: 	*==========================================================================
3588: 	PROTECTED PROCEDURE ConfigurarBotoesItens()
3589: 		LOCAL loc_lPodeEditar
3590: 		loc_lPodeEditar = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
3591: 
3592: 		THIS.AddObject("cmd_4c_IncluirLinha", "CommandButton")
3593: 		WITH THIS.cmd_4c_IncluirLinha
3594: 			.Top            = 3
3595: 			.Left           = 700
3596: 			.Height         = 75
3597: 			.Width          = 75
3598: 			.FontBold       = .T.
3599: 			.FontItalic     = .T.
3600: 			.FontName       = "Comic Sans MS"
3601: 			.FontSize       = 8
3602: 			.WordWrap       = .F.
3603: 			.Caption        = "Inserir Linha"
3604: 			.ToolTipText    = "Inserir linha"
3605: 			.PicturePosition = 13
3606: 			.ForeColor      = RGB(90, 90, 90)
3607: 			.BackColor      = RGB(255, 255, 255)
3608: 			.Themes         = .T.
3609: 			.Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
3610: 			.DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
3611: 			.Enabled        = loc_lPodeEditar
3612: 			.Visible        = .T.
3613: 		ENDWITH
3614: 		BINDEVENT(THIS.cmd_4c_IncluirLinha, "Click", THIS, "BtnIncluirLinhaClick")
3615: 
3616: 		THIS.AddObject("cmd_4c_ExcluirLinha", "CommandButton")
3617: 		WITH THIS.cmd_4c_ExcluirLinha
3618: 			.Top            = 3
3619: 			.Left           = 775
3620: 			.Height         = 75
3621: 			.Width          = 75
3622: 			.FontBold       = .T.
3623: 			.FontItalic     = .T.
3624: 			.FontName       = "Comic Sans MS"
3625: 			.FontSize       = 8
3626: 			.Caption        = "Excluir"
3627: 			.ToolTipText    = "Exclui linha"
3628: 			.ForeColor      = RGB(90, 90, 90)
3629: 			.BackColor      = RGB(255, 255, 255)
3630: 			.Themes         = .T.
3631: 			.Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
3632: 			.DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
3633: 			.Enabled        = loc_lPodeEditar
3634: 			.Visible        = .T.
3635: 		ENDWITH
3636: 		BINDEVENT(THIS.cmd_4c_ExcluirLinha, "Click", THIS, "BtnExcluirLinhaClick")
3637: 	ENDPROC
3638: 
3639: 	*==========================================================================
3640: 	* BtnIncluirLinhaClick - legado SIGOPORC.btnIncluir.Click. Insere uma
3641: 	* linha em branco IMEDIATAMENTE DEPOIS do item corrente, renumerando
3642: 	* Citens/Citem2/Citem3/CitAgrs de todas as linhas seguintes (igual ao
3643: 	* legado). Transcrito 1-para-1 na parte que opera so sobre a grade de
3644: 	* itens (cursor_4c_Itens).
3645: 	*
3646: 	* FICA PARA FASE POSTERIOR (precisa de cursor_4c_Parcelas/SigOpCdd/
3647: 	* LocalEmp, ainda nao carregados nesta fase):
3648: 	*   - renumeracao espelhada em crSigMvOrp (parcelas do item deslocado);
3649: 	*   - ramo de decupagem (SigOpCdd.ConfigGers) e copia de percentuais
3650: 	*     default do cabecalho quando LocalEmp.DivNotas = 2 (P&G).
3651: 	* A persistencia em SQL (BO.Inserir) acontece so no fechamento/
3652: 	* confirmacao do dialogo (fase propria) - igual ao legado, que so
3653: 	* grava a grade inteira ao sair ("Zap In crTpmMvItn ... Insert into
3654: 	* crTpmMvItn from Memvar").
3655: 	*==========================================================================
3656: 	PROCEDURE BtnIncluirLinhaClick()
3657: 		LOCAL loc_cCursor, loc_nItem, loc_nItem2, loc_nItem3, loc_nItAgr, loc_cBloco
3658: 
3659: 		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
3660: 			RETURN
3661: 		ENDIF
3662: 
3663: 		loc_cCursor = THIS.this_oBusinessObject.this_cCursorItens
3664: 		IF !USED(loc_cCursor)
3665: 			RETURN
3666: 		ENDIF
3667: 
3668: 		SELECT (loc_cCursor)
3669: 		IF EOF() OR INLIST(ALLTRIM(NVL(cblocos, "")), "SUBTOTAL", "BRANCO", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL")
3670: 			RETURN
3671: 		ENDIF
3672: 
3673: 		THIS.LockScreen = .T.
3674: 
3675: 		loc_nItem  = citens
3676: 		loc_nItem2 = citem2
3677: 		loc_nItem3 = citem3
3678: 		loc_nItAgr = citagrs
3679: 		loc_cBloco = cblocos
3680: 
3681: 		*-- Legado: "Select crSigMvOrc / Set Order To" ANTES do Scan - sem
3682: 		*-- remover a ordem controladora, atualizar a propria chave (Citens)
3683: 		*-- durante o Scan faria o VFP reprocessar/pular registros.
3684: 		SET ORDER TO
3685: 		SCAN FOR citens > loc_nItem
3686: 			REPLACE citem3 WITH IIF(citem3 = loc_nItem3, citem3, citem3 + 1), ;
3687: 				citem2 WITH IIF(citem2 = loc_nItem2, citem2, citem2 + 1), ;
3688: 				citens WITH citens + 1, ;
3689: 				citagrs WITH IIF(EMPTY(citagrs) OR citagrs = loc_nItAgr, citagrs, citagrs + 1)
3690: 		ENDSCAN
3691: 
3692: 		APPEND BLANK
3693: 		REPLACE citens WITH loc_nItem + 1, citem2 WITH loc_nItem2, citem3 WITH loc_nItem3, ;
3694: 			cblocos WITH loc_cBloco, taxas WITH .T.
3695: 
3696: 		SET ORDER TO TAG citens

*-- Linhas 3713 a 3756:
3713: 	* nao carregados): renumeracao espelhada em crSigMvOrp e a troca de TAG
3714: 	* de ordenacao (Citens x CitenCria) conforme modo Criacao.
3715: 	*==========================================================================
3716: 	PROCEDURE BtnExcluirLinhaClick()
3717: 		LOCAL loc_cCursor, loc_nItem, loc_nItem2, loc_nItem3, loc_nItAgr, loc_nTotalItens
3718: 
3719: 		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
3720: 			RETURN
3721: 		ENDIF
3722: 
3723: 		loc_cCursor = THIS.this_oBusinessObject.this_cCursorItens
3724: 		IF !USED(loc_cCursor)
3725: 			RETURN
3726: 		ENDIF
3727: 
3728: 		SELECT (loc_cCursor)
3729: 		IF EOF() OR INLIST(ALLTRIM(NVL(cblocos, "")), "SUBTOTAL", "BRANCO", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL")
3730: 			RETURN
3731: 		ENDIF
3732: 
3733: 		THIS.LockScreen = .T.
3734: 
3735: 		IF citens = citem2
3736: 			*-- Cabecalho de BLOCO ou SUB-BLOCO
3737: 			loc_nItem  = citens
3738: 			loc_nItem2 = citem2
3739: 			loc_nItem3 = citem3
3740: 
3741: 			IF loc_nItem = loc_nItem2 AND loc_nItem = loc_nItem3
3742: 				*-- BLOCO: so apaga se nao houver NENHUM item real dentro dele
3743: 				SELECT COUNT(1) AS nitem FROM (loc_cCursor) ;
3744: 					WHERE citem3 = loc_nItem3 ;
3745: 					AND !INLIST(ALLTRIM(NVL(cblocos, "")), "SUBTOTAL", "BRANCO", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL") ;
3746: 					AND !EMPTY(cpros) ;
3747: 					GROUP BY citem3 INTO CURSOR cursor_4c_TmpBloco
3748: 
3749: 				IF !USED("cursor_4c_TmpBloco") OR cursor_4c_TmpBloco.nitem = 0
3750: 					SELECT COUNT(1) AS nitem FROM (loc_cCursor) WHERE citem3 = loc_nItem3 INTO CURSOR cursor_4c_TmpBloco
3751: 					loc_nTotalItens = cursor_4c_TmpBloco.nitem
3752: 
3753: 					SELECT (loc_cCursor)
3754: 					DELETE FOR citem3 = loc_nItem3 ;
3755: 						AND !INLIST(ALLTRIM(NVL(cblocos, "")), "BRANCO", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL")
3756: 

*-- Linhas 3802 a 4164:
3802: 
3803: 			IF !EMPTY(vlbaixas)
3804: 				THIS.LockScreen = .F.
3805: 				MsgAviso("Item possui parcela j" + CHR(225) + " autorizada!", "Imposs" + CHR(237) + "vel excluir")
3806: 				RETURN
3807: 			ENDIF
3808: 
3809: 			DELETE FOR citens = loc_nItem
3810: 
3811: 			SET ORDER TO
3812: 			SCAN FOR citens > loc_nItem
3813: 				REPLACE citem3 WITH IIF(citem3 = loc_nItem3, citem3, citem3 - 1), ;
3814: 					citem2 WITH IIF(citem2 = loc_nItem2, citem2, citem2 - 1), ;
3815: 					citens WITH citens - 1, ;
3816: 					citagrs WITH IIF(EMPTY(citagrs) OR citagrs = loc_nItem, 0, citagrs - 1)
3817: 			ENDSCAN
3818: 
3819: 			SET ORDER TO TAG citens
3820: 			= SEEK(loc_nItem)
3821: 		ENDIF
3822: 
3823: 		THIS.grd_4c_Itens.Refresh()
3824: 		THIS.LockScreen = .F.
3825: 		THIS.grd_4c_Itens.Column1.SetFocus()
3826: 	ENDPROC
3827: 
3828: 	*==========================================================================
3829: 	* ConfigurarBotoesPrincipais - Fase 7/8: os botoes de ACAO do rodape que
3830: 	* faltavam (btnIteSub/btnTotItens/btnInsBlo/btnInsSub/btnCadPro/OK do
3831: 	* legado). Posicao/Picture/Caption/ToolTipText TRANSCRITOS do dump
3832: 	* ("PROPRIEDADES DE: SIGOPORC.<nome>"). Mesma familia visual dos botoes
3833: 	* de linha ja criados em ConfigurarBotoesItens (Comic Sans MS, ForeColor
3834: 	* RGB(90,90,90), Themes=.T.+DisabledPicture - regra do standalone com
3835: 	* Picture).
3836: 	*
3837: 	* obj_4c_OK (CommandGroup, ButtonCount=1) e o unico botao de COMANDO DE
3838: 	* GRUPO desta tela - o legado usa commandgroup so para herdar o
3839: 	* comportamento de Cancel=.T. (ESC fecha o dialogo). BINDEVENT vai no
3840: 	* proprio Buttons(1) (regra: WITH .Buttons(N) DENTRO do WITH que abre o
3841: 	* grupo e seguro).
3842: 	*
3843: 	* btnTotItens NAO tem PROCEDURE When no dump (fica sempre habilitado,
3844: 	* mesmo em CONSULTAR - ver totais nao exige direito de edicao); os
3845: 	* demais repetem o guard INSERIR/ALTERAR ja usado pelos outros botoes de
3846: 	* acao desta tela. cmd_4c_CadPro nasce Enabled=.F. - o estado real
3847: 	* depende da linha corrente (AtualizarEstadoCadastroProduto, chamado
3848: 	* pelo AfterRowColChange e pelo CarregarDados).
3849: 	*==========================================================================
3850: 	PROTECTED PROCEDURE ConfigurarBotoesPrincipais()
3851: 		LOCAL loc_lPodeEditar
3852: 		loc_lPodeEditar = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
3853: 
3854: 		THIS.AddObject("cmd_4c_TotItens", "CommandButton")
3855: 		WITH THIS.cmd_4c_TotItens
3856: 			.Top             = 3
3857: 			.Left            = 400
3858: 			.Height          = 75
3859: 			.Width           = 75
3860: 			.FontBold        = .T.
3861: 			.FontItalic      = .T.
3862: 			.FontName        = "Comic Sans MS"
3863: 			.FontSize        = 8
3864: 			.WordWrap        = .T.
3865: 			.Caption         = "Total"
3866: 			.ToolTipText     = "Total"
3867: 			.PicturePosition = 13
3868: 			.ForeColor       = RGB(90, 90, 90)
3869: 			.BackColor       = RGB(255, 255, 255)
3870: 			.Themes          = .T.
3871: 			.Picture         = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
3872: 			.DisabledPicture = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
3873: 			.Enabled         = .T.
3874: 			.Visible         = .T.
3875: 		ENDWITH
3876: 		BINDEVENT(THIS.cmd_4c_TotItens, "Click", THIS, "BtnTotalItensClick")
3877: 
3878: 		THIS.AddObject("cmd_4c_IteSub", "CommandButton")
3879: 		WITH THIS.cmd_4c_IteSub
3880: 			.Top             = 3
3881: 			.Left            = 475
3882: 			.Height          = 75
3883: 			.Width           = 75
3884: 			.FontBold        = .T.
3885: 			.FontItalic      = .T.
3886: 			.FontName        = "Comic Sans MS"
3887: 			.FontSize        = 8
3888: 			.WordWrap        = .T.
3889: 			.Caption         = "Itens Subn" + CHR(237) + "vel"
3890: 			.ToolTipText     = ""
3891: 			.PicturePosition = 13
3892: 			.ForeColor       = RGB(90, 90, 90)
3893: 			.BackColor       = RGB(255, 255, 255)
3894: 			.Themes          = .T.
3895: 			.Picture         = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
3896: 			.DisabledPicture = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
3897: 			.Enabled         = loc_lPodeEditar
3898: 			.Visible         = .T.
3899: 		ENDWITH
3900: 		BINDEVENT(THIS.cmd_4c_IteSub, "Click", THIS, "BtnItensSubnivelClick")
3901: 
3902: 		THIS.AddObject("cmd_4c_InsBlo", "CommandButton")
3903: 		WITH THIS.cmd_4c_InsBlo
3904: 			.Top             = 3
3905: 			.Left            = 550
3906: 			.Height          = 75
3907: 			.Width           = 75
3908: 			.FontBold        = .T.
3909: 			.FontItalic      = .T.
3910: 			.FontName        = "Comic Sans MS"
3911: 			.FontSize        = 8
3912: 			.WordWrap        = .F.
3913: 			.Caption         = "Inserir Bloco"
3914: 			.ToolTipText     = "Inserir linha"
3915: 			.PicturePosition = 13
3916: 			.ForeColor       = RGB(90, 90, 90)
3917: 			.BackColor       = RGB(255, 255, 255)
3918: 			.Themes          = .T.
3919: 			.Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
3920: 			.DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
3921: 			.Enabled         = loc_lPodeEditar
3922: 			.Visible         = .T.
3923: 		ENDWITH
3924: 		BINDEVENT(THIS.cmd_4c_InsBlo, "Click", THIS, "BtnInserirBlocoClick")
3925: 
3926: 		THIS.AddObject("cmd_4c_InsSub", "CommandButton")
3927: 		WITH THIS.cmd_4c_InsSub
3928: 			.Top             = 3
3929: 			.Left            = 625
3930: 			.Height          = 75
3931: 			.Width           = 75
3932: 			.FontBold        = .T.
3933: 			.FontItalic      = .T.
3934: 			.FontName        = "Comic Sans MS"
3935: 			.FontSize        = 8
3936: 			.WordWrap        = .T.
3937: 			.Caption         = "Inserir Sub-bloco"
3938: 			.ToolTipText     = "Inserir linha"
3939: 			.PicturePosition = 13
3940: 			.ForeColor       = RGB(90, 90, 90)
3941: 			.BackColor       = RGB(255, 255, 255)
3942: 			.Themes          = .T.
3943: 			.Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
3944: 			.DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
3945: 			.Enabled         = loc_lPodeEditar
3946: 			.Visible         = .T.
3947: 		ENDWITH
3948: 		BINDEVENT(THIS.cmd_4c_InsSub, "Click", THIS, "BtnInserirSubBlocoClick")
3949: 
3950: 		THIS.AddObject("cmd_4c_CadPro", "CommandButton")
3951: 		WITH THIS.cmd_4c_CadPro
3952: 			.Top             = 3
3953: 			.Left            = 850
3954: 			.Height          = 75
3955: 			.Width           = 75
3956: 			.FontBold        = .T.
3957: 			.FontItalic      = .T.
3958: 			.FontName        = "Comic Sans MS"
3959: 			.FontSize        = 8
3960: 			.WordWrap        = .T.
3961: 			.Caption         = "Cadastro de Produtos"
3962: 			.ToolTipText     = "Cadastro de Produtos"
3963: 			.PicturePosition = 13
3964: 			.ForeColor       = RGB(90, 90, 90)
3965: 			.BackColor       = RGB(255, 255, 255)
3966: 			.Themes          = .T.
3967: 			.Picture         = gc_4c_CaminhoIcones + "geral_produtos_60.jpg"
3968: 			.DisabledPicture = gc_4c_CaminhoIcones + "geral_produtos_60.jpg"
3969: 			.Enabled         = .F.
3970: 			.Visible         = .T.
3971: 		ENDWITH
3972: 		BINDEVENT(THIS.cmd_4c_CadPro, "Click", THIS, "BtnCadastroProdutoClick")
3973: 
3974: 		THIS.AddObject("obj_4c_OK", "CommandGroup")
3975: 		WITH THIS.obj_4c_OK
3976: 			.ButtonCount = 1
3977: 			.Top         = -2
3978: 			.Left        = 920
3979: 			.Height      = 85
3980: 			.Width       = 85
3981: 			.BackStyle   = 0
3982: 			.BorderStyle = 0
3983: 			.Themes      = .T.
3984: 			WITH .Buttons(1)
3985: 				.Top             = 5
3986: 				.Left            = 5
3987: 				.Height          = 75
3988: 				.Width           = 75
3989: 				.FontBold        = .T.
3990: 				.FontItalic      = .T.
3991: 				.FontName        = "Comic Sans MS"
3992: 				.FontSize        = 8
3993: 				.WordWrap        = .T.
3994: 				.Cancel          = .T.
3995: 				.Caption         = "Retornar"
3996: 				.ToolTipText     = "[Esc] Voltar Para a Tela Principal da Opera" + CHR(231) + CHR(227) + "o"
3997: 				.PicturePosition = 13
3998: 				.ForeColor       = RGB(90, 90, 90)
3999: 				.BackColor       = RGB(255, 255, 255)
4000: 				.Themes          = .T.
4001: 				.Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
4002: 				.DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
4003: 			ENDWITH
4004: 			.Visible = .T.
4005: 		ENDWITH
4006: 		BINDEVENT(THIS.obj_4c_OK.Buttons(1), "Click", THIS, "BtnSalvarClick")
4007: 	ENDPROC
4008: 
4009: 	*==========================================================================
4010: 	* BtnSalvarClick - legado SIGOPORC.OK.btnSair.Click. Fora do modo
4011: 	* CONSULTAR, valida (percentuais de NF/incentivo <= 100%, previsao de
4012: 	* pagamento completa, decupagem com previsao batendo com o Real) e, se
4013: 	* tudo passar, APAGA as linhas em branco e GRAVA cada linha remanescente
4014: 	* no SQL Server.
4015: 	*
4016: 	* DIFERENCA ARQUITETURAL DOCUMENTADA: o legado acumula tudo num cursor
4017: 	* intermediario do FORM PAI (crTpmMvItn) e EXCLUI os marcadores de
4018: 	* bloco/subtotal dessa lista - a gravacao real em lote e feita pelo
4019: 	* pai, em outro momento. Esta migracao grava CADA linha direto no SQL
4020: 	* Server, sem cursor intermediario nem form pai para delegar o lote;
4021: 	* por isso TODAS as linhas remanescentes (inclusive marcadores) sao
4022: 	* persistidas aqui - sem isso, a estrutura de blocos/subtotais do
4023: 	* orcamento se perderia a cada vez que o dialogo fosse reaberto.
4024: 	*
4025: 	* Falha de gravacao NUNCA fecha o dialogo em silencio (regra #20/#1):
4026: 	* BO.Inserir/Atualizar ja exibem o erro; o loc_lContinuar=.F. so evita
4027: 	* chamadas em cascata e mantem o dialogo aberto para o usuario tentar
4028: 	* de novo.
4029: 	*==========================================================================
4030: 	PROCEDURE BtnSalvarClick()
4031: 		LOCAL loc_cItens, loc_cParcelas, loc_lContinuar, loc_oErro, loc_nItem, ;
4032: 			loc_cDpros, loc_lItemOk, loc_cSQL, loc_nResultado, loc_cChaveNova, ;
4033: 			loc_cPkChaveNova
4034: 
4035: 		*-- Legado: fora de INSERIR/ALTERAR o Click pula TODO o bloco de
4036: 		*-- validacao/gravacao e cai direto em "ThisForm.release()" - e
4037: 		*-- exatamente o que BtnCancelarClick faz (saida sem persistir).
4038: 		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
4039: 			THIS.BtnCancelarClick()
4040: 			RETURN
4041: 		ENDIF
4042: 
4043: 		loc_cItens    = THIS.this_oBusinessObject.this_cCursorItens
4044: 		loc_cParcelas = THIS.this_oBusinessObject.this_cCursorParcelas
4045: 
4046: 		IF !USED(loc_cItens) OR !USED(loc_cParcelas)
4047: 			THIS.BtnCancelarClick()
4048: 			RETURN
4049: 		ENDIF
4050: 
4051: 		*-- TELA -> BO antes de qualquer validacao/gravacao: no legado os 5
4052: 		*-- percentuais do topo chegavam ao cabecalho sozinhos (ControlSource
4053: 		*-- = TprMvCab.<coluna>); aqui a transferencia e manual e passa por
4054: 		*-- FormParaBO (ver cabecalho dele).
4055: 		IF !THIS.FormParaBO()
4056: 			RETURN
4057: 		ENDIF
4058: 
4059: 		loc_lContinuar = .T.
4060: 
4061: 		TRY
4062: 			*-- Legado: as validacoes abaixo SO correm fora do modo P&G
4063: 			*-- (LocalEmp.DivNotas <> 2)
4064: 			IF THIS.this_oBusinessObject.this_nDivNotas <> 2
4065: 				SELECT (loc_cItens)
4066: 				SET ORDER TO TAG citens
4067: 				GO TOP
4068: 				LOCATE FOR perc2s + perc3s > 100
4069: 				IF FOUND()
4070: 					MsgAviso("Existe item com percentual de NF maior que 100%.", "Aviso")
4071: 					THIS.grd_4c_Itens.Column25.SetFocus()
4072: 					loc_lContinuar = .F.
4073: 				ENDIF
4074: 
4075: 				IF loc_lContinuar
4076: 					SELECT (loc_cItens)
4077: 					GO TOP
4078: 					LOCATE FOR perc4s + perc5s + perc6s > 100
4079: 					IF FOUND()
4080: 						MsgAviso("Existe item com percentual de incentivos maior que 100%.", "Aviso")
4081: 						THIS.grd_4c_Itens.Column22.SetFocus()
4082: 						loc_lContinuar = .F.
4083: 					ENDIF
4084: 				ENDIF
4085: 
4086: 				IF loc_lContinuar
4087: 					*-- Previsao de pagamento incompleta - varre TODAS as
4088: 					*-- parcelas (nao so as do item corrente): desliga o SET
4089: 					*-- KEY temporariamente e restaura no final.
4090: 					SELECT (loc_cParcelas)
4091: 					SET ORDER TO TAG citens
4092: 					SET KEY TO
4093: 					GO TOP
4094: 					SCAN
4095: 						IF !(EMPTY(ifors) AND EMPTY(percs) AND EMPTY(datas)) AND ;
4096: 								(EMPTY(ifors) OR EMPTY(percs) OR EMPTY(datas))
4097: 							loc_nItem  = citens
4098: 							loc_cDpros = ""
4099: 							IF SEEK(loc_nItem, loc_cItens, "citens")
4100: 								loc_cDpros = ALLTRIM(TratarNulo(EVALUATE(loc_cItens + ".dpros"), ""))
4101: 							ENDIF
4102: 							MsgAviso("Existe previs" + CHR(227) + "o de pagamento no item '" + ;
4103: 								loc_cDpros + "' incompleta.", "Aviso")
4104: 							loc_lContinuar = .F.
4105: 							EXIT
4106: 						ENDIF
4107: 					ENDSCAN
4108: 					THIS.PosicionarParcelasDoItem()
4109: 				ENDIF
4110: 
4111: 				IF loc_lContinuar AND INT(VAL(SUBSTR(THIS.this_oBusinessObject.this_cConfigGers, 192, 1))) = 1
4112: 					IF USED("cursor_4c_TmpTotPrev")
4113: 						USE IN cursor_4c_TmpTotPrev
4114: 					ENDIF
4115: 					SELECT a.citens, a.dpros, (a.tota7s + a.tota8s) AS totreal, ;
4116: 							SUM(NVL(b.valos, 0)) AS totprev ;
4117: 						FROM (loc_cItens) a LEFT JOIN (loc_cParcelas) b ON a.citens = b.citens ;
4118: 						WHERE !EMPTY(a.cpros) ;
4119: 						GROUP BY a.citens, a.dpros, 3 ;
4120: 						HAVING totreal > 0 AND (ISNULL(totprev) OR totprev <> totreal) ;
4121: 						INTO CURSOR cursor_4c_TmpTotPrev
4122: 
4123: 					IF USED("cursor_4c_TmpTotPrev") AND RECCOUNT("cursor_4c_TmpTotPrev") > 0
4124: 						MsgAviso("Existe previs" + CHR(227) + "o de pagamento no item '" + ;
4125: 							ALLTRIM(cursor_4c_TmpTotPrev.dpros) + "' " + CHR(13) + ;
4126: 							"n" + CHR(227) + "o informada ou com valor diferente do Real Custos Internos + Real Fornecedor", ;
4127: 							"Aviso")
4128: 						THIS.grd_4c_Itens.Column1.SetFocus()
4129: 						loc_lContinuar = .F.
4130: 					ENDIF
4131: 
4132: 					IF USED("cursor_4c_TmpTotPrev")
4133: 						USE IN cursor_4c_TmpTotPrev
4134: 					ENDIF
4135: 				ENDIF
4136: 			ENDIF
4137: 
4138: 			IF loc_lContinuar
4139: 				*-- Legado: "Delete For Empty(Dpros) And Citens<>Citem2 And cBlocos<>[BRANCO]"
4140: 				SELECT (loc_cItens)
4141: 				DELETE FOR EMPTY(dpros) AND citens <> citem2 AND ALLTRIM(cblocos) <> "BRANCO"
4142: 
4143: 				*-- Legado: "Delete For Empty(Ifors) And Empty(Percs) And Empty(Datas)"
4144: 				SELECT (loc_cParcelas)
4145: 				SET KEY TO
4146: 				DELETE FOR EMPTY(ifors) AND EMPTY(percs) AND EMPTY(datas)
4147: 
4148: 				*-- Persiste TODOS os itens remanescentes (ver nota da
4149: 				*-- diferenca arquitetural no cabecalho do metodo)
4150: 				SELECT (loc_cItens)
4151: 				SET ORDER TO TAG citens
4152: 				GO TOP
4153: 				SCAN
4154: 					THIS.this_oBusinessObject.CarregarDoCursor(loc_cItens)
4155: 					THIS.this_oBusinessObject.this_cEmps  = THIS.this_cEmps
4156: 					THIS.this_oBusinessObject.this_cDopes = THIS.this_cDopes
4157: 					THIS.this_oBusinessObject.this_nNumes = THIS.this_nNumes
4158: 
4159: 					IF EMPTY(ALLTRIM(NVL(THIS.this_oBusinessObject.this_cCidchaves, "")))
4160: 						loc_lItemOk = THIS.this_oBusinessObject.Inserir()
4161: 					ELSE
4162: 						loc_lItemOk = THIS.this_oBusinessObject.Atualizar()
4163: 					ENDIF
4164: 

*-- Linhas 4247 a 4332:
4247: 		CATCH TO loc_oErro
4248: 			MsgErro(loc_oErro.Message + CHR(13) + ;
4249: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4250: 				"Procedure: " + loc_oErro.Procedure, ;
4251: 				"Erro em Formsigoporc.BtnSalvarClick")
4252: 			loc_lContinuar = .F.
4253: 		ENDTRY
4254: 
4255: 		IF !loc_lContinuar
4256: 			THIS.PosicionarParcelasDoItem()
4257: 			THIS.grd_4c_Parcelas.Refresh()
4258: 			THIS.grd_4c_Itens.Refresh()
4259: 			RETURN
4260: 		ENDIF
4261: 
4262: 		*-- Legado: "ThisForm.ParentForm.totite = fTotalizarItn(...)" +
4263: 		*-- "ThisForm.ParentForm.atuatot()" - best-effort: o form de
4264: 		*-- cabecalho do Orcamento pode nao ter esse metodo ainda (fora do
4265: 		*-- escopo desta task) - a chamada so acontece se o metodo existir,
4266: 		*-- para nao impedir o fechamento do dialogo.
4267: 		IF VARTYPE(THIS.this_oFormPai) = "O"
4268: 			IF PEMSTATUS(THIS.this_oFormPai, "AtualizarTotaisOrcamento", 5)
4269: 				THIS.this_oFormPai.AtualizarTotaisOrcamento()
4270: 			ENDIF
4271: 		ENDIF
4272: 
4273: 		THIS.Release()
4274: 	ENDPROC
4275: 
4276: 	*==========================================================================
4277: 	* BtnInserirBlocoClick - legado SIGOPORC.btnInsBlo.Click. Insere um novo
4278: 	* BLOCO (par de linhas: cabecalho + SUBTOTAL) IMEDIATAMENTE DEPOIS do
4279: 	* subtotal do bloco atual (ou depois do item corrente, se o bloco ainda
4280: 	* nao tiver subtotal), renumerando Citens/Citem2/Citem3 de tudo que vem
4281: 	* depois (igual ao legado) e espelhando a renumeracao nas parcelas do
4282: 	* item deslocado (cursor_4c_Parcelas, via o mesmo truque de negativar/
4283: 	* voltar ao positivo que evita colisao de chave durante o SCAN).
4284: 	*
4285: 	* NAO PORTADO: o ramo "Inlist(crSigCdOpe.DigItens,6,7)" do legado insere
4286: 	* sub-itens lendo crSigOpCdI.JOB_MV_BLO - a tabela SigOpCdI NAO EXISTE
4287: 	* no schema canonico (docs\schema.sql, regra #14 - zero ocorrencias,
4288: 	* nao e falso-negativo de encoding). Sem a fonte de dados, esse ramo e
4289: 	* impossivel de transcrever; o bloco sempre nasce com as 2 linhas
4290: 	* (cabecalho + SUBTOTAL), igual ao caso "nao-Criacao" do legado.
4291: 	*==========================================================================
4292: 	PROCEDURE BtnInserirBlocoClick()
4293: 		LOCAL loc_cItens, loc_cParcelas, loc_nItem, loc_nItem2, loc_nItem3, ;
4294: 			loc_cBloco, loc_nItAnt, loc_oErro
4295: 
4296: 		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
4297: 			RETURN
4298: 		ENDIF
4299: 
4300: 		loc_cItens    = THIS.this_oBusinessObject.this_cCursorItens
4301: 		loc_cParcelas = THIS.this_oBusinessObject.this_cCursorParcelas
4302: 
4303: 		IF !USED(loc_cItens) OR EOF(loc_cItens)
4304: 			RETURN
4305: 		ENDIF
4306: 
4307: 		SELECT (loc_cItens)
4308: 		IF INLIST(ALLTRIM(NVL(cblocos, "")), "SUBTOTAL", "BRANCO", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL")
4309: 			RETURN
4310: 		ENDIF
4311: 
4312: 		THIS.LockScreen = .T.
4313: 
4314: 		TRY
4315: 			SET ORDER TO TAG citens
4316: 
4317: 			loc_nItem  = IIF(EMPTY(citens), 0, citens)
4318: 			loc_nItem2 = IIF(EMPTY(citem2), 0, citem2)
4319: 			loc_nItem3 = IIF(EMPTY(citem3), 0, citem3)
4320: 			loc_cBloco = cblocos
4321: 
4322: 			SELECT MAX(citens) AS citens FROM (loc_cItens) WHERE citem3 = loc_nItem3 INTO CURSOR cursor_4c_TmpSub
4323: 			IF USED("cursor_4c_TmpSub") AND !EOF("cursor_4c_TmpSub") AND !EMPTY(cursor_4c_TmpSub.citens)
4324: 				IF SEEK(cursor_4c_TmpSub.citens, loc_cItens, "citens")
4325: 					loc_nItem  = EVALUATE(loc_cItens + ".citens")
4326: 					loc_nItem2 = EVALUATE(loc_cItens + ".citem2")
4327: 					loc_nItem3 = EVALUATE(loc_cItens + ".citem3")
4328: 					loc_cBloco = ""
4329: 				ENDIF
4330: 			ENDIF
4331: 			IF USED("cursor_4c_TmpSub")
4332: 				USE IN cursor_4c_TmpSub

*-- Linhas 4386 a 4447:
4386: 		CATCH TO loc_oErro
4387: 			MsgErro(loc_oErro.Message + CHR(13) + ;
4388: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4389: 				"Procedure: " + loc_oErro.Procedure, ;
4390: 				"Erro em Formsigoporc.BtnInserirBlocoClick")
4391: 		ENDTRY
4392: 
4393: 		THIS.grd_4c_Itens.Refresh()
4394: 		THIS.grd_4c_Parcelas.Refresh()
4395: 		THIS.LockScreen = .F.
4396: 		THIS.grd_4c_Itens.Column1.SetFocus()
4397: 	ENDPROC
4398: 
4399: 	*==========================================================================
4400: 	* BtnInserirSubBlocoClick - legado SIGOPORC.btnInsSub.Click. Mesma ideia
4401: 	* de BtnInserirBlocoClick, mas agrupando por SUB-BLOCO (Citem2) dentro
4402: 	* do bloco atual (Citem3) - desloca so +2 (cabecalho + SUBTOTAL do
4403: 	* sub-bloco), sem o +2 extra de JOB_MV_BLO que so existe no modo
4404: 	* Criacao - nao portado pelo mesmo motivo de BtnInserirBlocoClick
4405: 	* (SigOpCdI nao existe no schema).
4406: 	*==========================================================================
4407: 	PROCEDURE BtnInserirSubBlocoClick()
4408: 		LOCAL loc_cItens, loc_cParcelas, loc_nItem, loc_nItem2, loc_nItem3, ;
4409: 			loc_cBloco, loc_nItAnt, loc_oErro
4410: 
4411: 		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
4412: 			RETURN
4413: 		ENDIF
4414: 
4415: 		loc_cItens    = THIS.this_oBusinessObject.this_cCursorItens
4416: 		loc_cParcelas = THIS.this_oBusinessObject.this_cCursorParcelas
4417: 
4418: 		IF !USED(loc_cItens) OR EOF(loc_cItens)
4419: 			RETURN
4420: 		ENDIF
4421: 
4422: 		SELECT (loc_cItens)
4423: 		IF INLIST(ALLTRIM(NVL(cblocos, "")), "SUBTOTAL", "BRANCO", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL")
4424: 			RETURN
4425: 		ENDIF
4426: 
4427: 		THIS.LockScreen = .T.
4428: 
4429: 		TRY
4430: 			SET ORDER TO TAG citens
4431: 
4432: 			loc_nItem  = IIF(EMPTY(citens), 0, citens)
4433: 			loc_nItem2 = IIF(EMPTY(citem2), 0, citem2)
4434: 			loc_nItem3 = IIF(EMPTY(citem3), 0, citem3)
4435: 			loc_cBloco = cblocos
4436: 
4437: 			SELECT MAX(citens) AS citens FROM (loc_cItens) ;
4438: 				WHERE citem3 = loc_nItem3 AND citem2 = loc_nItem2 AND ALLTRIM(cblocos) == "SUBTOTAL" ;
4439: 				INTO CURSOR cursor_4c_TmpSub
4440: 			IF USED("cursor_4c_TmpSub") AND !EOF("cursor_4c_TmpSub") AND !EMPTY(cursor_4c_TmpSub.citens)
4441: 				IF SEEK(cursor_4c_TmpSub.citens, loc_cItens, "citens")
4442: 					loc_nItem  = EVALUATE(loc_cItens + ".citens")
4443: 					loc_nItem2 = EVALUATE(loc_cItens + ".citem2")
4444: 					loc_nItem3 = EVALUATE(loc_cItens + ".citem3")
4445: 					loc_cBloco = ""
4446: 				ENDIF
4447: 			ENDIF

*-- Linhas 4503 a 4721:
4503: 		CATCH TO loc_oErro
4504: 			MsgErro(loc_oErro.Message + CHR(13) + ;
4505: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4506: 				"Procedure: " + loc_oErro.Procedure, ;
4507: 				"Erro em Formsigoporc.BtnInserirSubBlocoClick")
4508: 		ENDTRY
4509: 
4510: 		THIS.grd_4c_Itens.Refresh()
4511: 		THIS.grd_4c_Parcelas.Refresh()
4512: 		THIS.LockScreen = .F.
4513: 		THIS.grd_4c_Itens.Column1.SetFocus()
4514: 	ENDPROC
4515: 
4516: 	*==========================================================================
4517: 	* BtnItensSubnivelClick / BtnTotalItensClick - legado SIGOPORC.btnIteSub/
4518: 	* btnTotItens.Click ("ThisForm.Enabled = .f. / Do Form SigOpTor With
4519: 	* ThisForm, ThisForm.DataSessionId[, 'I']"). SigOpTor e um dialogo
4520: 	* LEGADO SEPARADO (detalhe de itens em subnivel / totalizacao) que
4521: 	* NUNCA foi migrado para este projeto (sem task propria, sem
4522: 	* FormSigOpTor em nenhuma pasta de forms).
4523: 	*
4524: 	* NAO E POSSIVEL abrir algo que nao existe. Em vez de inventar um
4525: 	* dialogo substituto (violaria o PILAR 2/3 - arquitetura e
4526: 	* comportamento fabricados, sem fonte no legado) ou fingir sucesso
4527: 	* silenciosamente, o clique avisa explicitamente que a funcionalidade
4528: 	* depende de uma migracao propria (SigOpTor) ainda nao feita - mesmo
4529: 	* espirito do wrapper "NAO PORTADA" ja documentado no projeto (regra
4530: 	* #27), aqui para um FORM em vez de uma funcao global.
4531: 	*==========================================================================
4532: 	PROCEDURE BtnItensSubnivelClick()
4533: 		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
4534: 			RETURN
4535: 		ENDIF
4536: 		THIS.AvisarSigOpTorPendente("I")
4537: 	ENDPROC
4538: 
4539: 	PROCEDURE BtnTotalItensClick()
4540: 		THIS.AvisarSigOpTorPendente("")
4541: 	ENDPROC
4542: 
4543: 	*==========================================================================
4544: 	* AvisarSigOpTorPendente - ver cabecalho de BtnItensSubnivelClick/
4545: 	* BtnTotalItensClick. par_cModo = "I" (Itens em Subnivel) ou ""
4546: 	* (Total de Itens) - equivale ao 3o parametro do "Do Form SigOpTor" do
4547: 	* legado, sem uso aqui alem de escolher a mensagem.
4548: 	*==========================================================================
4549: 	PROTECTED PROCEDURE AvisarSigOpTorPendente(par_cModo)
4550: 		MsgAviso("Esta funcionalidade depende do dialogo SigOpTor (" + ;
4551: 			IIF(EMPTY(par_cModo), "Total de Itens", "Itens em Subn" + CHR(237) + "vel") + ;
4552: 			"), que ainda n" + CHR(227) + "o foi migrado para o sistema novo.", ;
4553: 			"Funcionalidade pendente")
4554: 	ENDPROC
4555: 
4556: 	*==========================================================================
4557: 	* BtnCadastroProdutoClick - legado SIGOPORC.btnCadPro.Click. Resolve o
4558: 	* fornecedor padrao (conta de origem/destino conforme SigCdOpe.Opers/
4559: 	* Origems/Destinos) e o grupo do produto novo (do item corrente, se ja
4560: 	* tiver Cpros, ou de txt_4c_NovoGrupo), igual ao legado.
4561: 	*
4562: 	* ESCOPO REDUZIDO, DOCUMENTADO: o legado abre SigCdPro.Scx com SETE
4563: 	* parametros posicionais e RECEBE de volta o codigo do produto criado
4564: 	* na MESMA chamada ("Do Form ... To lcCodProduto"), para em seguida
4565: 	* rodar uma cascata de precificacao automatica (SigCdOpe.PrecoAuts/
4566: 	* PrecoPs) e preencher o item sozinho. FormProduto (CRUD ja migrado em
4567: 	* task propria) usa o padrao de Init PADRAO do projeto (sem
4568: 	* parametros, sem retorno sincrono) - mudar a assinatura de
4569: 	* FormProduto para aceitar esse contrato extenderia o escopo desta
4570: 	* task (781) para dentro da task de FormProduto.
4571: 	*
4572: 	* Por isso: valida o guard (igual ao legado), resolve e mostra o
4573: 	* grupo/fornecedor, abre FormProduto em modo INCLUIR normal e - depois
4574: 	* do form fechar - pede ao usuario para digitar o codigo do produto
4575: 	* recem-cadastrado no campo da grade (aciona ValidarProdutoItemKeyPress/
4576: 	* AbrirBuscaProdutoItem, ja existentes da Fase 6). A cascata de
4577: 	* precificacao automatica NAO RODA neste fluxo - o lookup normal
4578: 	* preenche Dpros/Cunis/CuniPs, mas nao a moeda/preco automatico que so
4579: 	* o retorno sincrono do legado disparava.
4580: 	*==========================================================================
4581: 	PROCEDURE BtnCadastroProdutoClick()
4582: 		LOCAL loc_cItens, loc_cCodFornec, loc_cGrupo, loc_cSQL, loc_nResultado, loc_oForm, loc_oErro
4583: 
4584: 		IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
4585: 			RETURN
4586: 		ENDIF
4587: 
4588: 		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
4589: 		IF !USED(loc_cItens) OR EOF(loc_cItens)
4590: 			RETURN
4591: 		ENDIF
4592: 
4593: 		loc_cCodFornec = ""
4594: 		IF THIS.this_oBusinessObject.this_nOpers = 1 AND THIS.this_oBusinessObject.this_nOrigems = 1
4595: 			loc_cCodFornec = THIS.this_oBusinessObject.this_cContaOs
4596: 		ELSE
4597: 			IF THIS.this_oBusinessObject.this_nOpers = 2 AND THIS.this_oBusinessObject.this_nDestinos = 1
4598: 				loc_cCodFornec = THIS.this_oBusinessObject.this_cContaDs
4599: 			ELSE
4600: 				IF THIS.this_oBusinessObject.this_nOrigems = 1
4601: 					loc_cCodFornec = THIS.this_oBusinessObject.this_cContaOs
4602: 				ELSE
4603: 					IF THIS.this_oBusinessObject.this_nDestinos = 1
4604: 						loc_cCodFornec = THIS.this_oBusinessObject.this_cContaDs
4605: 					ENDIF
4606: 				ENDIF
4607: 			ENDIF
4608: 		ENDIF
4609: 
4610: 		IF !INLIST(THIS.this_oBusinessObject.this_nCadProds, 0, 2)
4611: 			SELECT (loc_cItens)
4612: 			IF EMPTY(cpros) AND EMPTY(THIS.txt_4c_NovoGrupo.Value)
4613: 				MsgAviso("Informe o grupo de produto para ser cadastrado!", "Aviso")
4614: 				IF THIS.txt_4c_NovoGrupo.Enabled
4615: 					THIS.txt_4c_NovoGrupo.SetFocus()
4616: 				ENDIF
4617: 				RETURN
4618: 			ENDIF
4619: 
4620: 			TRY
4621: 				loc_cGrupo = ""
4622: 				IF !EMPTY(cpros)
4623: 					IF USED("cursor_4c_TmpGruPro")
4624: 						USE IN cursor_4c_TmpGruPro
4625: 					ENDIF
4626: 					loc_cSQL = "SELECT Cgrus FROM SigCdPro WHERE cpros = " + EscaparSQL(cpros)
4627: 					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpGruPro")
4628: 					IF loc_nResultado > 0 AND USED("cursor_4c_TmpGruPro") AND RECCOUNT("cursor_4c_TmpGruPro") > 0
4629: 						loc_cGrupo = ALLTRIM(TratarNulo(cursor_4c_TmpGruPro.Cgrus, ""))
4630: 					ENDIF
4631: 					IF USED("cursor_4c_TmpGruPro")
4632: 						USE IN cursor_4c_TmpGruPro
4633: 					ENDIF
4634: 				ELSE
4635: 					loc_cGrupo = ALLTRIM(THIS.txt_4c_NovoGrupo.Value)
4636: 				ENDIF
4637: 
4638: 				MsgInfo("Grupo de produto: " + loc_cGrupo + CHR(13) + ;
4639: 					"Fornecedor padr" + CHR(227) + "o: " + loc_cCodFornec + CHR(13) + CHR(13) + ;
4640: 					"Ap" + CHR(243) + "s cadastrar, digite o c" + CHR(243) + "digo do produto novo no item da grade.", ;
4641: 					"Cadastro de Produtos")
4642: 
4643: 				GarantirClasse("FormProduto")
4644: 				loc_oForm = CREATEOBJECT("FormProduto")
4645: 				IF VARTYPE(loc_oForm) = "O"
4646: 					loc_oForm.Show()
4647: 				ENDIF
4648: 			CATCH TO loc_oErro
4649: 				MsgErro(loc_oErro.Message, "Erro em Formsigoporc.BtnCadastroProdutoClick")
4650: 			ENDTRY
4651: 		ENDIF
4652: 
4653: 		THIS.grd_4c_Itens.Column1.SetFocus()
4654: 	ENDPROC
4655: 
4656: 	*==========================================================================
4657: 	* CarregarLista - FUNIL de RECARGA das duas grades a partir do banco.
4658: 	* PUBLIC de proposito (o harness TesteAutomatico.prg chama metodos de
4659: 	* carga de FORA da classe, e PROTECTED estouraria "Property
4660: 	* CARREGARLISTA is not found" - regra #3).
4661: 	*
4662: 	* Equivale ao par AddCursor('SigMvOrc',...)/AddCursor('SigMvOrp',...)
4663: 	* do Init legado toda vez que ele e reexecutado: le de novo SigMvOrc/
4664: 	* SigMvOrp (BO.CarregarItens/CarregarParcelas, que usam cursor
4665: 	* temporario + ZAP + APPEND FROM DBF - nunca SQLEXEC direto no alias do
4666: 	* Grid), revincula as duas grades, reposiciona e repinta.
4667: 	*
4668: 	* PRESERVA A LINHA CORRENTE: guarda o Citens do item em que o usuario
4669: 	* estava e faz SEEK depois da recarga - sem isso toda recarga jogaria o
4670: 	* usuario de volta para o primeiro item. Cai em GO TOP quando a linha
4671: 	* nao existe mais (ex.: item recem-excluido) ou na primeira carga.
4672: 	*
4673: 	* O SET KEY do mestre-detalhe (PosicionarParcelasDoItem) e DESFEITO
4674: 	* antes da recarga e reposto depois: com filtro pendurado, a releitura
4675: 	* das parcelas enxergaria so a fatia do item corrente.
4676: 	*
4677: 	* Fecha com THIS.Refresh() + Refresh() das duas grades porque popular
4678: 	* cursor NAO repinta a grade ligada a ele, e trocar ordem/chave do
4679: 	* alias tampouco (regra #21).
4680: 	*==========================================================================
4681: 	PROCEDURE CarregarLista()
4682: 		LOCAL loc_lSucesso, loc_oErro, loc_cItens, loc_cParcelas, ;
4683: 			loc_nItemAtual, loc_lAchou, loc_lModoValidacaoOuTeste
4684: 		loc_lSucesso = .F.
4685: 		loc_lModoValidacaoOuTeste = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
4686: 			(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
4687: 
4688: 		TRY
4689: 			loc_cItens    = THIS.this_oBusinessObject.this_cCursorItens
4690: 			loc_cParcelas = THIS.this_oBusinessObject.this_cCursorParcelas
4691: 
4692: 			*-- Linha corrente, para reposicionar depois da recarga
4693: 			loc_nItemAtual = 0
4694: 			IF USED(loc_cItens) AND !EOF(loc_cItens)
4695: 				loc_nItemAtual = EVALUATE(loc_cItens + ".citens")
4696: 			ENDIF
4697: 
4698: 			IF USED(loc_cParcelas)
4699: 				SELECT (loc_cParcelas)
4700: 				SET KEY TO
4701: 			ENDIF
4702: 
4703: 			*-- Pulado em validacao de UI / modo teste: sem conexao SQL real
4704: 			*-- (os cursores existem, so ficam vazios - mesma decisao do
4705: 			*-- CarregarDados desde a Fase 4).
4706: 			IF !loc_lModoValidacaoOuTeste
4707: 				THIS.this_oBusinessObject.CarregarItens()
4708: 				THIS.this_oBusinessObject.CarregarParcelas()
4709: 			ENDIF
4710: 
4711: 			*-- ZAP + APPEND FROM preserva estrutura/RecordSource/
4712: 			*-- CurrentControl, mas Width e Header1.Caption se perdem a cada
4713: 			*-- (re)atribuicao de RecordSource (regra #41) - os dois
4714: 			*-- Vincular* reaplicam tudo e sao idempotentes.
4715: 			THIS.VincularGradeItens()
4716: 			THIS.VincularGradeParcelas()
4717: 
4718: 			loc_lAchou = .F.
4719: 			IF USED(loc_cItens)
4720: 				SELECT (loc_cItens)
4721: 				SET ORDER TO TAG citens

*-- Linhas 4730 a 4781:
4730: 			THIS.PosicionarParcelasDoItem()
4731: 			THIS.AtualizarEstadoCadastroProduto()
4732: 
4733: 			THIS.Refresh()
4734: 			THIS.grd_4c_Itens.Refresh()
4735: 			THIS.grd_4c_Parcelas.Refresh()
4736: 
4737: 			loc_lSucesso = USED(loc_cItens)
4738: 		CATCH TO loc_oErro
4739: 			MsgErro(loc_oErro.Message + CHR(13) + ;
4740: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4741: 				"Procedure: " + loc_oErro.Procedure, ;
4742: 				"Erro em Formsigoporc.CarregarLista")
4743: 		ENDTRY
4744: 
4745: 		RETURN loc_lSucesso
4746: 	ENDPROC
4747: 
4748: 	*==========================================================================
4749: 	* NumeroDoCampo - coercao defensiva de .Value de TextBox para NUMERICO.
4750: 	* Os 5 campos de percentual nascem com .Value = 0 (numerico), mas o
4751: 	* valor pode voltar como CARACTERE quando o usuario digita num campo
4752: 	* com Format/InputMask e o VFP devolve a string da mascara - e ai
4753: 	* qualquer aritmetica estoura "Operator/operand type mismatch". Mesma
4754: 	* defesa ja usada em TotalizarItn para os campos do topo.
4755: 	*==========================================================================
4756: 	PROTECTED FUNCTION NumeroDoCampo(par_uValor)
4757: 		LOCAL loc_nValor
4758: 		loc_nValor = 0
4759: 
4760: 		DO CASE
4761: 			CASE VARTYPE(par_uValor) = "N"
4762: 				loc_nValor = par_uValor
4763: 			CASE VARTYPE(par_uValor) = "C"
4764: 				loc_nValor = VAL(ALLTRIM(par_uValor))
4765: 			CASE VARTYPE(par_uValor) = "L"
4766: 				loc_nValor = IIF(par_uValor, 1, 0)
4767: 		ENDCASE
4768: 
4769: 		RETURN loc_nValor
4770: 	ENDFUNC
4771: 
4772: 	*==========================================================================
4773: 	* FormParaBO - TELA -> BO. Transfere os campos que sao do DIALOGO (nao
4774: 	* da grade) para as properties do Business Object, e carrega nele o
4775: 	* item da linha corrente da grade.
4776: 	*
4777: 	* No legado esses 5 campos tem ControlSource apontando para o cursor de
4778: 	* CABECALHO do form PAI (conferido um a um no dump):
4779: 	*   getPtax2    -> TprMvCab.ptax2s  -> this_nPTax2s  (Contingente/Perc1s)
4780: 	*   getPtaxa    -> TprMvCab.descs   -> this_nDescs   (Taxa Adm./Lucro, Perc2s)
4781: 	*   getPTax1    -> TprMvCab.ptax1s  -> this_nPTax1s  (BV/Perc3s)

*-- Linhas 4831 a 4948:
4831: 		CATCH TO loc_oErro
4832: 			MsgErro(loc_oErro.Message + CHR(13) + ;
4833: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4834: 				"Procedure: " + loc_oErro.Procedure, ;
4835: 				"Erro em Formsigoporc.FormParaBO")
4836: 			loc_lSucesso = .F.
4837: 		ENDTRY
4838: 
4839: 		RETURN loc_lSucesso
4840: 	ENDFUNC
4841: 
4842: 	*==========================================================================
4843: 	* BOParaForm - BO -> TELA. Espelha nos 5 campos de percentual os valores
4844: 	* que o BO leu de SigMvCab em CarregarConfiguracao (acres/ptax1s/
4845: 	* ptax2s/ptax3s/descs), que no legado chegavam sozinhos pelo
4846: 	* ControlSource = TprMvCab.<coluna>.
4847: 	*
4848: 	* Fase 8/8 - SEM ESTE METODO os 5 campos abriam SEMPRE em 0,00, mesmo
4849: 	* com o cabecalho do orcamento tendo percentuais gravados: nada no
4850: 	* form lia essas properties do BO. Alem de exibir errado, isso
4851: 	* contaminava o calculo - os handlers Txt*KeyPress aplicam o valor do
4852: 	* CAMPO em perc1s..perc6s de cada item, entao o primeiro Enter num
4853: 	* campo zerado zeraria o percentual de todos os itens.
4854: 	*
4855: 	* Nao toca txt_4c_Margem (resultado calculado por TotalizarItn, ver
4856: 	* FormParaBO) nem a grade: os itens/parcelas vem por CarregarLista.
4857: 	*==========================================================================
4858: 	FUNCTION BOParaForm()
4859: 		LOCAL loc_lSucesso, loc_oErro
4860: 		loc_lSucesso = .F.
4861: 
4862: 		IF VARTYPE(THIS.this_oBusinessObject) <> "O"
4863: 			RETURN .F.
4864: 		ENDIF
4865: 
4866: 		TRY
4867: 			THIS.txt_4c_Contingente.Value    = THIS.NumeroDoCampo(THIS.this_oBusinessObject.this_nPTax2s)
4868: 			THIS.txt_4c_TaxaAdm.Value        = THIS.NumeroDoCampo(THIS.this_oBusinessObject.this_nDescs)
4869: 			THIS.txt_4c_BV.Value             = THIS.NumeroDoCampo(THIS.this_oBusinessObject.this_nPTax1s)
4870: 			THIS.txt_4c_Imposto.Value        = THIS.NumeroDoCampo(THIS.this_oBusinessObject.this_nAcres)
4871: 			THIS.txt_4c_ImpostoServico.Value = THIS.NumeroDoCampo(THIS.this_oBusinessObject.this_nPTax3s)
4872: 
4873: 			loc_lSucesso = .T.
4874: 		CATCH TO loc_oErro
4875: 			MsgErro(loc_oErro.Message + CHR(13) + ;
4876: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4877: 				"Procedure: " + loc_oErro.Procedure, ;
4878: 				"Erro em Formsigoporc.BOParaForm")
4879: 		ENDTRY
4880: 
4881: 		RETURN loc_lSucesso
4882: 	ENDFUNC
4883: 
4884: 	*==========================================================================
4885: 	* HabilitarCampos - centraliza o .Enabled dos CAMPOS do dialogo (os
4886: 	* botoes ficam em AjustarBotoesPorModo). Transcreve os "When" do dump:
4887: 	*
4888: 	*   getPtax2/getPtaxa/getPTax1/getPimposto/getPservico/get_NewGrp
4889: 	*                 -> Inlist(thisform.Op_Escolha,[INSERIR],[ALTERAR])
4890: 	*   getPmargem    -> Return .f.            (NUNCA editavel)
4891: 	*   getDpros/getDpro2s -> Return thisform.lProcura
4892: 	*   getDescritivo -> Inlist(Op_Escolha,[INSERIR],[ALTERAR]) And
4893: 	*                    <linha normal> And Empty(VlBaixas)
4894: 	*
4895: 	* par_lHabilitar e OPCIONAL: omitido, o estado sai do MODO do dialogo
4896: 	* (o que o legado faz nos When). Passado, forca os campos editaveis -
4897: 	* usado pelo harness e por quem precisa travar a tela durante uma
4898: 	* operacao longa. PCOUNT() distingue "nao passou" de "passou .F."
4899: 	* (VARTYPE de logico e "L" nos dois casos).
4900: 	*
4901: 	* .Enabled no lugar de .ReadOnly reproduz o efeito do When (campo nao
4902: 	* alcancavel por Tab nem por clique) sem inventar estado novo. As
4903: 	* CELULAS das duas grades seguem o ReadOnly por coluna aplicado em
4904: 	* ConfigurarGridItens/ConfigurarGradeParcelas (cada Column tem o seu
4905: 	* proprio When no legado, e varias admitem CONSULTAR) - nao sao
4906: 	* mexidas aqui.
4907: 	*==========================================================================
4908: 	PROCEDURE HabilitarCampos(par_lHabilitar)
4909: 		LOCAL loc_lPodeEditar, loc_lModoCriacao
4910: 
4911: 		IF PCOUNT() >= 1 AND VARTYPE(par_lHabilitar) = "L"
4912: 			loc_lPodeEditar = par_lHabilitar
4913: 		ELSE
4914: 			loc_lPodeEditar = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
4915: 		ENDIF
4916: 
4917: 		loc_lModoCriacao = INLIST(THIS.this_oBusinessObject.this_nDigItens, 6, 7)
4918: 
4919: 		*-- Percentuais editaveis (When = Inlist(Op_Escolha,INSERIR,ALTERAR))
4920: 		THIS.txt_4c_Contingente.Enabled    = loc_lPodeEditar
4921: 		THIS.txt_4c_TaxaAdm.Enabled        = loc_lPodeEditar
4922: 		THIS.txt_4c_BV.Enabled             = loc_lPodeEditar
4923: 		THIS.txt_4c_Imposto.Enabled        = loc_lPodeEditar
4924: 		THIS.txt_4c_ImpostoServico.Enabled = loc_lPodeEditar
4925: 
4926: 		*-- getPmargem.When = .f. - resultado calculado, nunca digitado
4927: 		THIS.txt_4c_Margem.Enabled = .F.
4928: 
4929: 		*-- get_NewGrp (When = Inlist(Op_Escolha,INSERIR,ALTERAR)). O ramo
4930: 		*-- CadProds = 4 do AfterRowColChange legado refina isso por linha
4931: 		*-- (AtualizarEstadoCadastroProduto), por isso ele roda depois.
4932: 		THIS.txt_4c_NovoGrupo.Enabled = loc_lPodeEditar
4933: 
4934: 		*-- getDpros/getDpro2s.When = thisform.lProcura (o par so abre
4935: 		*-- quando btnProcura entra em modo de busca). Em modo Criacao os
4936: 		*-- dois nem aparecem na tela (AtualizarModoCriacao).
4937: 		THIS.txt_4c_ProcuraDpros.Enabled  = loc_lPodeEditar AND THIS.this_lProcura AND !loc_lModoCriacao
4938: 		THIS.edt_4c_ProcuraDpro2s.Enabled = loc_lPodeEditar AND THIS.this_lProcura AND !loc_lModoCriacao
4939: 
4940: 		*-- getDescritivo: so existe no modo Criacao e so edita em
4941: 		*-- INSERIR/ALTERAR (o refino por linha - linha normal e
4942: 		*-- Empty(VlBaixas) - fica no When da propria coluna da grade,
4943: 		*-- igual ao legado)
4944: 		THIS.edt_4c_DescritivoRodape.Enabled = loc_lPodeEditar AND loc_lModoCriacao
4945: 
4946: 		*-- Refino por LINHA do botao/campo de cadastro de produto
4947: 		THIS.AtualizarEstadoCadastroProduto()
4948: 	ENDPROC

*-- Linhas 4967 a 5176:
4967: 	* btnExcluirp e btnProcura) NAO recebem .Enabled = .F.: com Caption
4968: 	* vazio o VFP9 deixa de desenhar o Picture e o botao vira um retangulo
4969: 	* vazio (regra do CorretorAutomatico #106). Para esses tres o "When"
4970: 	* virou guarda no inicio do proprio handler - BINDEVENT descarta o
4971: 	* retorno do delegate, entao um When ligado por BINDEVENT nao
4972: 	* bloquearia nada mesmo.
4973: 	*
4974: 	* PUBLIC de proposito: o harness chama AjustarBotoesPorModo de FORA da
4975: 	* classe (regra #3 - PEMSTATUS devolve .T. tambem para metodo
4976: 	* PROTECTED, entao a chamada compila e estoura em runtime).
4977: 	*==========================================================================
4978: 	PROCEDURE AjustarBotoesPorModo()
4979: 		LOCAL loc_lPodeEditar
4980: 		loc_lPodeEditar = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
4981: 
4982: 		*-- Botoes de linha da grade de itens
4983: 		THIS.cmd_4c_IncluirLinha.Enabled = loc_lPodeEditar
4984: 		THIS.cmd_4c_ExcluirLinha.Enabled = loc_lPodeEditar
4985: 
4986: 		*-- Botoes de estrutura (bloco / sub-bloco) e navegacao de subnivel
4987: 		THIS.cmd_4c_InsBlo.Enabled = loc_lPodeEditar
4988: 		THIS.cmd_4c_InsSub.Enabled = loc_lPodeEditar
4989: 		THIS.cmd_4c_IteSub.Enabled = loc_lPodeEditar
4990: 
4991: 		*-- btnTotItens e o OK nao tem When no legado
4992: 		THIS.cmd_4c_TotItens.Enabled = .T.
4993: 		THIS.obj_4c_OK.Enabled       = .T.
4994: 
4995: 		*-- btnCadPro depende do modo E da linha corrente: quem resolve as
4996: 		*-- duas coisas (incluindo CadProds/fChecaAcesso) e o metodo de
4997: 		*-- refino, que ja trata cursor ausente/EOF.
4998: 		THIS.AtualizarEstadoCadastroProduto()
4999: 	ENDPROC
5000: 
5001: 	*==========================================================================
5002: 	* LimparCampos - devolve os campos do DIALOGO ao estado de abertura.
5003: 	*
5004: 	* Nao ha "novo registro" neste form: o legado SIGOPORC nao tem botao
5005: 	* Incluir de CABECALHO (o Incluir dele e de LINHA da grade, ver
5006: 	* BtnIncluirLinhaClick) - o dialogo sempre edita os itens de UM
5007: 	* orcamento que ja existe. Entao LimparCampos NAO zera as grades: os
5008: 	* itens/parcelas pertencem ao orcamento, nao a um registro em digitacao
5009: 	* (zerar seria perda silenciosa de dado). O que ele limpa e exatamente
5010: 	* o estado AUXILIAR da tela, o mesmo que o legado reseta ao trocar de
5011: 	* linha (AfterRowColChange) e ao ligar o modo de busca (btnProcura):
5012: 	*   - a linha de busca (getDpros/getDpro2s) e a flag lProcura
5013: 	*   - o campo de grupo novo (get_NewGrp)
5014: 	*   - a pre-visualizacao da foto do produto (imgProds)
5015: 	*   - os valores anteriores usados pelos Valid (antdpros/oldpreco) e o
5016: 	*     canal de retorno dos lookups
5017: 	* Os 5 percentuais voltam ao que o BO leu do cabecalho (BOParaForm), nao
5018: 	* a zero - zerar inventaria valor e, no primeiro Enter num deles,
5019: 	* zeraria o percentual de todos os itens.
5020: 	*==========================================================================
5021: 	PROCEDURE LimparCampos()
5022: 		LOCAL loc_oErro
5023: 
5024: 		TRY
5025: 			*-- Linha de busca + flag do botao de duas fases
5026: 			THIS.this_lProcura = .F.
5027: 			THIS.txt_4c_ProcuraDpros.Value  = ""
5028: 			THIS.edt_4c_ProcuraDpro2s.Value = ""
5029: 
5030: 			*-- Grupo do produto novo (legado: AfterRowColChange zera
5031: 			*-- Get_NewGrp.Value quando CadProds = 4)
5032: 			THIS.txt_4c_NovoGrupo.Value = ""
5033: 
5034: 			*-- Foto do produto (legado: imgProds.Visible = .f. /
5035: 			*-- imgProds.Picture = [] no topo do AfterRowColChange)
5036: 			THIS.img_4c_Produto.Visible = .F.
5037: 			THIS.img_4c_Produto.Picture = ""
5038: 
5039: 			*-- Valores anteriores comparados pelos Valid e canal de retorno
5040: 			*-- dos metodos AbrirBusca*
5041: 			THIS.this_cAntDpros        = ""
5042: 			THIS.this_nOldPreco        = 0
5043: 			THIS.this_lAutPreco        = .F.
5044: 			THIS.this_cLookupCodigo    = ""
5045: 			THIS.this_cLookupDescricao = ""
5046: 
5047: 			*-- Percentuais voltam ao valor do cabecalho, nao a zero
5048: 			THIS.BOParaForm()
5049: 
5050: 			*-- Reaplica Visible/Enabled (a flag lProcura mudou). O proprio
5051: 			*-- AtualizarModoCriacao fecha chamando HabilitarCampos e
5052: 			*-- AjustarBotoesPorModo.
5053: 			THIS.AtualizarModoCriacao()
5054: 		CATCH TO loc_oErro
5055: 			MsgErro(loc_oErro.Message + CHR(13) + ;
5056: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
5057: 				"Procedure: " + loc_oErro.Procedure, ;
5058: 				"Erro em Formsigoporc.LimparCampos")
5059: 		ENDTRY
5060: 	ENDPROC
5061: 
5062: 	*==========================================================================
5063: 	* BtnCancelarClick - FUNIL de ABANDONO: fecha o dialogo SEM persistir
5064: 	* nada e devolve o controle ao form pai.
5065: 	*
5066: 	* O SIGOPORC legado NAO TEM botao de abandono - o CommandGroup "OK" e
5067: 	* o unico botao de saida (ButtonCount = 1 no dump) e nenhum objeto do
5068: 	* SCX tem Caption/Picture de Cancelar. Por isso aqui NAO se cria botao
5069: 	* nenhum (inventar um violaria o PILAR 1): este metodo e o CAMINHO que
5070: 	* o legado ja percorre quando o dialogo esta em CONSULTAR - o
5071: 	* OK.btnSair.Click pula todo o bloco "If Inlist(op_escolha,[INSERIR],
5072: 	* [ALTERAR])" e cai direto em "ThisForm.release()", sem gravar nada.
5073: 	* BtnSalvarClick delega a ele exatamente nesse ramo, para o caminho de
5074: 	* saida sem gravacao existir num lugar so.
5075: 	*
5076: 	* Fechar os dois cursores aqui e o que DESCARTA as edicoes em memoria:
5077: 	* eles sao LOCAIS do dialogo (CREATE CURSOR em CriarCursorItens/
5078: 	* CriarCursorParcelas), nao aliases emprestados do chamador, e a
5079: 	* persistencia acontece unicamente em BtnSalvarClick - reabrir o
5080: 	* dialogo depois disso le tudo de novo de SigMvOrc/SigMvOrp. O SET KEY
5081: 	* do mestre-detalhe sai antes, para nao deixar filtro pendurado.
5082: 	*
5083: 	* NAO pede confirmacao: o legado nao pergunta nada em nenhum caminho de
5084: 	* saida, e inventar um dialogo de confirmacao mudaria a UX (PILAR 1).
5085: 	*==========================================================================
5086: 	PROCEDURE BtnCancelarClick()
5087: 		LOCAL loc_oErro, loc_cItens, loc_cParcelas
5088: 
5089: 		TRY
5090: 			IF VARTYPE(THIS.this_oBusinessObject) = "O"
5091: 				loc_cItens    = THIS.this_oBusinessObject.this_cCursorItens
5092: 				loc_cParcelas = THIS.this_oBusinessObject.this_cCursorParcelas
5093: 
5094: 				IF USED(loc_cParcelas)
5095: 					SELECT (loc_cParcelas)
5096: 					SET KEY TO
5097: 					USE IN (loc_cParcelas)
5098: 				ENDIF
5099: 
5100: 				IF USED(loc_cItens)
5101: 					USE IN (loc_cItens)
5102: 				ENDIF
5103: 			ENDIF
5104: 		CATCH TO loc_oErro
5105: 			MsgErro(loc_oErro.Message + CHR(13) + ;
5106: 				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
5107: 				"Procedure: " + loc_oErro.Procedure, ;
5108: 				"Erro em Formsigoporc.BtnCancelarClick")
5109: 		ENDTRY
5110: 
5111: 		*-- Devolve o controle ao pai (legado: "Procedure Unload" -
5112: 		*-- ThisForm.Parentform.Enabled = .t.). Destroy repete isso para
5113: 		*-- cobrir tambem o fechamento pela barra de janela; as duas
5114: 		*-- atribuicoes sao idempotentes.
5115: 		IF VARTYPE(THIS.this_oFormPai) = "O"
5116: 			IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
5117: 				THIS.this_oFormPai.Enabled = .T.
5118: 			ENDIF
5119: 		ENDIF
5120: 
5121: 		THIS.Release()
5122: 	ENDPROC
5123: 
5124: 	*==========================================================================
5125: 	* Destroy - Devolve o controle ao form pai (legado: "Procedure Unload" -
5126: 	* ThisForm.Parentform.Enabled = .t., desfazendo o ThisForm.Enabled = .f.
5127: 	* que o pai aplica antes de abrir este dialogo) e solta a referencia,
5128: 	* para o dialogo filho nao manter vivo quem o abriu.
5129: 	*
5130: 	* DODEFAULT() na ULTIMA linha e obrigatorio: e o FormBase.Destroy que
5131: 	* libera o Business Object e reconstroi os popups do menu principal.
5132: 	*
5133: 	* O "Procedure Load" do legado (=fConfigGeral()) fica de fora pela mesma
5134: 	* decisao ja documentada em FormSigOpEnt.prg/FormSIGPRMEI.prg: fConfigGeral
5135: 	* era funcao GLOBAL do legado (sig.prg/SIGFUNCS.PRG) que nao veio no
5136: 	* acervo; o wrapper NO-OP em projeto\app\utils\fconfiggeral.prg existe so
5137: 	* para o p-code dos VCX legado continuar resolvendo o nome, e em codigo
5138: 	* NOSSO nunca se chama fConfigGeral.
5139: 	*==========================================================================
5140: 	PROCEDURE Destroy()
5141: 		LOCAL loc_oErro
5142: 
5143: 		TRY
5144: 			IF VARTYPE(THIS.this_oFormPai) = "O"
5145: 				IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
5146: 					THIS.this_oFormPai.Enabled = .T.
5147: 				ENDIF
5148: 			ENDIF
5149: 
5150: 			*-- Os dois cursores sao LOCAIS deste dialogo (CREATE CURSOR em
5151: 			*-- CriarCursorItens/CriarCursorParcelas), nao aliases emprestados
5152: 			*-- do chamador - por isso podem e devem ser fechados aqui. Antes
5153: 			*-- de fechar o de parcelas, desfaz o SET KEY aplicado por
5154: 			*-- PosicionarParcelasDoItem, para nao deixar filtro pendurado.
5155: 			IF VARTYPE(THIS.this_oBusinessObject) = "O"
5156: 				IF USED(THIS.this_oBusinessObject.this_cCursorParcelas)
5157: 					SELECT (THIS.this_oBusinessObject.this_cCursorParcelas)
5158: 					SET KEY TO
5159: 					USE IN (THIS.this_oBusinessObject.this_cCursorParcelas)
5160: 				ENDIF
5161: 
5162: 				IF USED(THIS.this_oBusinessObject.this_cCursorItens)
5163: 					USE IN (THIS.this_oBusinessObject.this_cCursorItens)
5164: 				ENDIF
5165: 			ENDIF
5166: 
5167: 			THIS.this_oFormPai = .NULL.
5168: 			THIS.this_oObjExt1 = .NULL.
5169: 		CATCH TO loc_oErro
5170: 			MsgErro(loc_oErro.Message, "Erro em Formsigoporc.Destroy")
5171: 		ENDTRY
5172: 
5173: 		DODEFAULT()
5174: 	ENDPROC
5175: 
5176: ENDDEFINE


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

