# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (6)
- [METODO-INEXISTENTE] Metodo 'THIS.DevolverPesoTotalAoPai()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.RepintarGrade()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.Width()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.VincularGrade()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterAliasGrade()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.CarregarDadosGrade()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpEmb.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1299 linhas total):

*-- Linhas 7 a 192:
7: *          quantidade de cada embalagem cadastrada (SigCdEmb) e devolver
8: *          o peso total ao form pai.
9: *
10: * Chamada: CREATEOBJECT("FormSigOpEmb", par_oFormPai, par_nCitens, ;
11: *              par_cEmps, par_cDopes, par_nNumes)
12: *          (equivale ao legado "LParameters poForm, pCnx" - sem pCnx, que
13: *          nao existe mais neste ambiente, ja que o BO usa o handle
14: *          global gnConnHandle; o contexto da movimentacao (Emps/Dopes/
15: *          Numes/Citens), que o legado lia direto de crTpmMvItn/
16: *          TprMvCab por estarem na mesma data session do form pai, chega
17: *          aqui por PARAMETRO)
18: *
19: * Historico de fases:
20: *   Fase 1/2: SigOpEmbBO.prg (propriedades + CRUD completo)
21: *   Fase 3:   FormSigOpEmb.prg - estrutura base (Init, InicializarForm,
22: *             ConfigurarPageFrame, ConfigurarCabecalho,
23: *             TornarControlesVisiveis, Destroy)
24: *   Fase 4:   grade de embalagens (grd_4c_Dados, 4 colunas) + CommandGroup
25: *             de confirmacao (cmg_4c_Botoes, 1 botao) + funil de carga
26: *             (CarregarLista/VincularGrade/RepintarGrade) + Valid da
27: *             celula de quantidade + devolucao do peso total ao form pai
28: *   Fase 5/6: auditoria propriedade-a-propriedade contra a SECAO 2 do dump
29: *             (flags de janela que faltavam) + trava das colunas
30: *             calculadas. NAO havia campo nem lookup a acrescentar - ver
31: *             as duas secoes abaixo, que registram a MEDICAO.
32: *   Fase 7:   auditoria de EVENTOS PRINCIPAIS - nada a acrescentar, ver
33: *             secao abaixo.
34: *   Fase 8:   consolidacao final. Fechado o unico trecho do legado que
35: *             ainda estava pela metade - as TRES primeiras linhas do
36: *             PROCEDURE Release (desvinculo da grade ANTES de fechar o
37: *             cursor), hoje em DesvincularGrade; e o Destroy deixou de
38: *             repetir os nomes de cursor em literal, passando a le-los
39: *             das properties do BO (FecharCursoresDoDialogo). Ver a
40: *             secao "CONSOLIDACAO (Fase 8)" abaixo, que registra a
41: *             MEDICAO do resto.
42: *
43: * CONSOLIDACAO (Fase 8): BtnBuscarClick / BtnEncerrarClick /
44: *     BtnSalvarClick / BtnCancelarClick / HabilitarCampos / LimparCampos /
45: *     AjustarBotoesPorModo NAO existem aqui, e FormParaBO / BOParaForm
46: *     ficam com o hook VAZIO herdado de FormBase. Nao eh omissao - eh o
47: *     que a tela tem:
48: *
49: *     - UM botao, provado pela SECAO 1/2 do dump (cntBotoes,
50: *       ButtonCount = 1). Nao ha Buscar, nao ha Salvar separado do
51: *       Encerrar e nao ha Cancelar: o Caption eh "\<Encerrar", o
52: *       ToolTipText eh "Confirmar a Selecao" e o Click GRAVA. Com
53: *       Closable = .F. e Cancel = .T. nesse mesmo botao, o ESC tambem
54: *       CONFIRMA - esta tela nao tem como desistir, e isso eh do legado.
55: *       O handler existe desde a Fase 4 batizado pela ACAO
56: *       (BtnConfirmarClick), nao pelo rotulo da tecla.
57: *     - NENHUM modo: o legado nao tem pcEscolha, nao e' frmcadastro e nao
58: *       tem Grupo_Op. Sem INCLUIR/ALTERAR/VISUALIZAR nao ha o que
59: *       HabilitarCampos habilitar nem o que AjustarBotoesPorModo ajustar,
60: *       e LimparCampos (chamado por FormBase.Novo) nao tem registro novo
61: *       para limpar - a grade ja abre com as quantidades gravadas do item
62: *       (o LEFT JOIN do Init legado).
63: *     - FormParaBO/BOParaForm mapeiam CAMPO A CAMPO uma ficha de Page2.
64: *       Aqui nao ha campo fora da grade (medido na Fase 5, secao CAMPOS
65: *       abaixo) e a grade esta ligada DIRETO ao cursor que o BO cria e
66: *       possui, entao nao existe par tela<->property para espelhar: a
67: *       transferencia form -> BO acontece por ARGUMENTO
68: *       (ValidarQuantidadeGrade passa par_oTxt.Value a
69: *       SigOpEmbBO.AtualizarPesoLinha, e o Init passa o contexto
70: *       Citens/Emps/Dopes/Numes), e a volta BO -> tela eh o proprio
71: *       cursor, repintado por RepintarGrade. Preencher os dois hooks
72: *       aqui seria codigo MORTO: quem os chama eh FormBase.Salvar e
73: *       FormBase.Cancelar, e esta tela nao usa nenhum dos dois (grava por
74: *       BtnConfirmarClick -> SigOpEmbBO.GravarEmbalagensDoItem).
75: *
76: *     Criar os sete como stub violaria a regra de completude; criar como
77: *     logica real inventaria botao, modo e ficha que o legado nao tem,
78: *     violando o PILAR 1. Registrado por extenso porque a ausencia
79: *     deles, sem esta nota, parece fase inacabada.
80: *
81: *     MEDIDO em VFP9 nesta fase (automation\ProbeEmb728Fase8.prg,
82: *     instanciando o form - "a tela abre" nao se prova lendo codigo):
83: *     CREATEOBJECT devolve objeto; a grade abre com ColumnCount = 4,
84: *     RecordSource ligado e as larguras/headers/InputMask do dump
85: *     (52/130/87/87 e Qtde/Embalagem/Peso/Peso Total); o When das celulas
86: *     da .T./.F./.F./.F. como o SCX; os seis metodos chamados de FORA da
87: *     classe estao PUBLIC (regras #3/#51); o Valid recalcula
88: *     pesos = qtds * pesoembs (4 x 2,50 -> 10,000); o total usa o
89: *     criterio Qtds > 0 do legado (12,500 em 3 linhas, uma com zero); o
90: *     Init zera "pesoemb" no form pai; e o encerramento fecha o cursor da
91: *     grade.
92: *
93: * EVENTOS PRINCIPAIS (Fase 7): nao existe BtnIncluirClick/BtnAlterarClick/
94: *     BtnVisualizarClick/BtnExcluirClick porque o legado NAO tem CRUD -
95: *     SIGOEMB nao e' frmcadastro, nao tem pcEscolha, nao tem Grupo_Op e a
96: *     SECAO 1 do dump prova UM botao so (cntBotoes, ButtonCount = 1,
97: *     BaseClass: commandgroup). Os 9 metodos da SECAO 3
98: *     (tasks\task728\SigOpEmb_form_codigo_fonte.txt e
99: *     comportamento.json) sao Init/Load/Release do form,
100: *     cntBotoes.Click, Grade.Column1.Text1.Valid e os quatro When das
101: *     colunas - nenhum deles e' Incluir/Alterar/Visualizar/Excluir. O
102: *     EVENTO PRINCIPAL desta tela (cntBotoes.Click) ja foi implementado
103: *     na Fase 4 como BtnConfirmarClick -> ConfirmarEmbalagensExec
104: *     (confirma a quantidade digitada, grava via BO, devolve o peso ao
105: *     form pai e fecha o dialogo) - repeti-lo aqui duplicaria o bind do
106: *     BINDEVENT em ConfigurarBotoesConfirmar. Criar os quatro handlers
107: *     CRUD como stub vazio violaria a regra de completude (proibido
108: *     metodo sem logica real); criar como logica real inventaria
109: *     comportamento que o legado nunca teve, violando o PILAR 1.
110: *
111: * CAMPOS: nao existe campo FORA da grade (nada a acrescentar nas Fases 5/6)
112: *     Contado na arvore de objetos do dump: os 4 "BaseClass: textbox" do
113: *     form tem Parent SIGOEMB.Grade.Column1..Column4, ou seja sao os Text1
114: *     NATIVOS das colunas (regra #18), entregues junto com a propria grade
115: *     na Fase 4. Fora deles o form tem: 1 grid, 1 container (cntSombra),
116: *     2 labels (lblSombra/lblTitulo - os dois do cabecalho), 1
117: *     commandgroup e 4 headers. Zero TextBox/EditBox/ComboBox/CheckBox/
118: *     Spinner avulso. Reproduzir um "campo solto" aqui exigiria duplicar a
119: *     celula de uma coluna como controle fantasma (nunca visivel, nao
120: *     reproduz nada do legado) ou inventar campo que o legado nao tem -
121: *     viola o PILAR 1 nos dois casos.
122: *
123: * LOOKUPS: o legado NAO tem lookup algum (nada a acrescentar na Fase 6)
124: *     Medido no dump, zero ocorrencia (case-insensitive) de: fwBuscaExt,
125: *     fwBuscaSel, fwBuscaInt, sigacess, AcessoEmpresa/Contas/Produto,
126: *     fSqlConector, mAddColuna, CreateObject e Seek. Os 9 metodos da
127: *     SECAO 3 sao: Init / Load / Release do form, btnConfirmar.Click,
128: *     Column1.Text1.Valid e os quatro When das colunas - nenhum deles
129: *     abre browse de selecao. Os unicos dados de referencia da tela
130: *     (codigo, descricao e peso unitario da embalagem) chegam pela
131: *     CONSULTA que monta a grade (SELECT ... FROM SigCdEmb, no BO), e nao
132: *     por picker: o usuario nao escolhe embalagem, ele digita a
133: *     quantidade de cada uma das que ja estao listadas. Criar aqui um
134: *     FormBuscaAuxiliar seria inventar tabela de lookup que o legado
135: *     nunca consultou.
136: *
137: * "Load -> =fConfigGeral()" do legado: deliberadamente NAO reproduzido como
138: *     chamada. fConfigGeral era funcao GLOBAL da aplicacao legado (sig.prg /
139: *     SIGFUNCS.PRG) que nao veio no acervo; o projeto tem
140: *     utils\fconfiggeral.prg, mas esse arquivo e' um wrapper que existe
141: *     SO para o p-code dos VCX legado o alcancar pelo PATH, e o proprio
142: *     cabecalho dele manda nao chama-lo de codigo nosso. O que a funcao
143: *     fazia era configuracao GLOBAL, que nesta arquitetura acontece antes
144: *     e em outro lugar: SETs/paths/variaveis globais em config.prg,
145: *     conexao e empresa em main.prg, e os cursores desta tela em
146: *     SigOpEmbBO (CriarCursorEmbalagens/CarregarCadastroEmbalagens/
147: *     CarregarLinhasDoItem). Este dialogo nao le nada que fConfigGeral
148: *     criasse - a unica tabela de referencia dele e' SigCdEmb, consultada
149: *     pelo proprio BO.
150: *
151: * CONTRATO DE CONSUMO (como abrir e ler o resultado):
152: *     loc_oDlg = CREATEOBJECT("FormSigOpEmb", THIS, <Citens>, ;
153: *                    <Emps>, <Dopes>, <Numes>)
154: *     IF VARTYPE(loc_oDlg) = "O"
155: *         loc_oDlg.Show()                              && modal: bloqueia
156: *         loc_nPeso = loc_oDlg.ObterPesoTotalEmbalagens()
157: *     ENDIF
158: * A tela fecha com Hide() (ver FecharDialogo) para o chamador ainda poder
159: * ler o peso; quando o form pai eh passado, o valor tambem chega nele pela
160: * property "pesoemb", como no legado.
161: *
162: * PILAR 1 (UX): dialogo pequeno e modal, 650x239, Caption "Quantidade de
163: * embalagens" (sem acentos). As propriedades de janela NAO foram
164: * deduzidas por analogia com os outros dialogos desta familia: o
165: * layout.json nao as captura, mas a SECAO 2 do dump
166: * (tasks\task728\SigOpEmb_form_codigo_fonte.txt, "PROPRIEDADES DE:
167: * SIGOEMB") declara TODAS uma a uma, e estao transcritas do dump no bloco
168: * de propriedades da classe abaixo. Registrado aqui porque a versao
169: * anterior deste cabecalho dizia o contrario, e "inferido por analogia"
170: * convida um sweep futuro a "corrigir" valor que e' do legado.
171: *
172: * PILAR 3 (arquitetura): o legado (SIGOEMB) e um form FLAT do VFP - SEM
173: * PageFrame, SEM Container alem do cntSombra (header). A arvore de
174: * objetos (layout.json) tem exatamente: form + cntSombra (com
175: * lblSombra/lblTitulo) + cntBotoes (CommandGroup, 1 botao) + Grade (4
176: * colunas). Nao ha Page1/Lista nem Page2/Dados - inventa-los violaria o
177: * PILAR 1. cntBotoes e a Grade entram na Fase 4 (fora do escopo desta
178: * fase, que e so a ESTRUTURA BASE).
179: *==============================================================================
180: 
181: DEFINE CLASS FormSigOpEmb AS FormBase
182: 
183:     *-- Business Object
184:     this_oBusinessObject = .NULL.
185: 
186:     *-- Contexto recebido do form PAI no Init (equivalente a poForm e aos
187:     *-- valores que o legado lia direto de crTpmMvItn/TprMvCab, por
188:     *-- estarem na mesma data session do form pai)
189:     this_oFormPai = .NULL.   && poForm - referencia ao form pai (item de movimento); usada para devolver o peso total (thisform.parentform.pesoemb do legado)
190:     this_nCitens  = 0        && crTpmMvItn.Citens - item corrente da movimentacao
191:     this_cEmps    = ""       && TprMvCab.Emps - empresa da movimentacao
192:     this_cDopes   = ""       && TprMvCab.Dopes - operacao da movimentacao

*-- Linhas 210 a 431:
210:     *--
211:     *-- Ficam de fora apenas DoCreate (propriedade de design-time do Form
212:     *-- Designer, sem efeito em classe de .prg) e Picture, que depende de
213:     *-- gc_4c_CaminhoFramework e por isso e' atribuida em InicializarForm.
214:     Width        = 650
215:     Height       = 239
216:     AutoCenter   = .T.
217:     TitleBar     = 0
218:     WindowType   = 1
219:     ShowWindow   = 1
220:     ControlBox   = .F.
221:     MaxButton    = .F.
222:     MinButton    = .F.
223:     Movable      = .F.
224:     BorderStyle  = 2
225:     ClipControls = .F.
226:     Themes       = .F.
227:     ShowTips     = .T.
228:     AlwaysOnTop  = .T.
229:     FontName     = "Verdana"
230:     FontSize     = 8
231:     Caption      = "Quantidade de embalagens"
232: 
233:     *-- DataSession = 1 do dump. Vale o default do VFP, mas esta EXPLICITO
234:     *-- de proposito: "1" significa a data session CORRENTE (a do form que
235:     *-- abriu este dialogo), nao "a sessao global numero 1". Esta tela
236:     *-- EXISTE para ler e reescrever os cursores do form pai (crSigMvIte /
237:     *-- crTpmMvItn, ver SigOpEmbBO), que so sao visiveis aqui por causa
238:     *-- disso. Trocar para 2 daria a este form uma sessao PRIVADA: os
239:     *-- cursores do pai desapareceriam, a grade abriria vazia e o peso
240:     *-- voltaria sempre zero - sem erro e sem log. A linha existe para que
241:     *-- um sweep de "forms sem DataSession" nao acrescente o 2.
242:     DataSession  = 1
243: 
244:     *-- KeyPreview = .T. do dump: INERTE nesta tela, como no legado - o SCX
245:     *-- nao declara PROCEDURE KeyPress nem no form nem em controle nenhum
246:     *-- (SECAO 3 do dump tem 9 metodos, nenhum deles KeyPress). Quem
247:     *-- responde ao ESC e' o Cancel = .T. do botao (ConfigurarBotoesConfirmar),
248:     *-- que funciona independente desta flag. Transcrita porque o dump a
249:     *-- declara, e nao para habilitar comportamento novo.
250:     KeyPreview   = .T.
251: 
252:     *-- Closable = .F. do dump (SECAO 2). TRANSCRITO, nao inventado - a
253:     *-- distincao importa: com TitleBar = 0 nao ha botao de fechar para
254:     *-- desenhar, mas Closable continua governando o Alt+F4, e aqui ele
255:     *-- fica bloqueado. Consequencia: a UNICA saida e' o botao, que GRAVA
256:     *-- (btnConfirmar) - ou seja esta tela nao tem como "desistir", e isso
257:     *-- e' comportamento do LEGADO, nao desvio. O efeito pratico e' menor
258:     *-- do que parece: a grade abre JA com as quantidades gravadas do item
259:     *-- (LEFT JOIN do Init legado), entao confirmar sem mexer em nada
260:     *-- regrava os mesmos valores e devolve o mesmo peso. Se o dump nao
261:     *-- declarasse esta propriedade, ela NAO poderia ser acrescentada por
262:     *-- coerencia com TitleBar/ControlBox, justamente porque o unico botao
263:     *-- commita.
264:     Closable     = .F.
265: 
266:     *--------------------------------------------------------------------------
267:     * Init - Armazena o contexto do item de movimento pai, cria o BO e
268:     * dispara FormBase.Init() (que chama THIS.InicializarForm() via
269:     * DODEFAULT()).
270:     *--------------------------------------------------------------------------
271:     PROCEDURE Init(par_oFormPai, par_nCitens, par_cEmps, par_cDopes, par_nNumes)
272:         LOCAL loc_lSucesso, loc_oErro
273:         loc_lSucesso = .F.
274: 
275:         TRY
276:             THIS.this_oFormPai = IIF(VARTYPE(par_oFormPai) = "O", par_oFormPai, .NULL.)
277:             THIS.this_nCitens  = IIF(VARTYPE(par_nCitens) = "N", par_nCitens, 0)
278:             THIS.this_cEmps    = IIF(VARTYPE(par_cEmps)   = "C", ALLTRIM(par_cEmps),  "")
279:             THIS.this_cDopes   = IIF(VARTYPE(par_cDopes)  = "C", ALLTRIM(par_cDopes), "")
280:             THIS.this_nNumes   = IIF(VARTYPE(par_nNumes)  = "N", par_nNumes, 0)
281: 
282:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpEmbBO")
283:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
284:                 MsgErro("Erro ao criar Business Object SigOpEmbBO." + CHR(13) + ;
285:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
286:                     "FormSigOpEmb.Init")
287:             ELSE
288:                 *-- Contexto da movimentacao propagado para o BO ANTES do
289:                 *-- DODEFAULT(), que dispara InicializarForm().
290:                 THIS.this_oBusinessObject.this_nCitens = THIS.this_nCitens
291:                 THIS.this_oBusinessObject.this_cEmps   = THIS.this_cEmps
292:                 THIS.this_oBusinessObject.this_cDopes  = THIS.this_cDopes
293:                 THIS.this_oBusinessObject.this_nNumes  = THIS.this_nNumes
294: 
295:                 *-- DODEFAULT() dispara FormBase.Init() que chama THIS.InicializarForm()
296:                 loc_lSucesso = DODEFAULT()
297:             ENDIF
298:         CATCH TO loc_oErro
299:             MsgErro(loc_oErro.Message + CHR(13) + ;
300:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
301:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpEmb.Init")
302:         ENDTRY
303: 
304:         RETURN loc_lSucesso
305:     ENDPROC
306: 
307:     *--------------------------------------------------------------------------
308:     * InicializarForm - Monta a estrutura visual base (cabecalho).
309:     * Chamado automaticamente por FormBase.Init() via DODEFAULT().
310:     *--------------------------------------------------------------------------
311:     PROTECTED PROCEDURE InicializarForm()
312:         LOCAL loc_lSucesso, loc_oErro
313:         loc_lSucesso = .F.
314: 
315:         TRY
316:             *-- Fundo do form (imagem do Framework Fortyus legado)
317:             THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
318: 
319:             *-- "thisform.parentform.pesoemb = 0" do Init legado, na mesma
320:             *-- posicao (antes da consulta que monta a grade): se a tela for
321:             *-- fechada pelo X/Esc sem confirmar, o pai fica com ZERO em vez
322:             *-- do peso de uma abertura anterior
323:             THIS.DevolverPesoTotalAoPai(0)
324: 
325:             THIS.ConfigurarPageFrame()
326: 
327:             *-- Propaga o titulo para os labels do cabecalho (equivalente a
328:             *-- ThisForm.cntSombra.lblSombra/lblTitulo.Caption = ThisForm.Caption)
329:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
330:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
331: 
332:             *-- Torna a arvore de controles visivel (AddObject cria com Visible=.F.)
333:             THIS.TornarControlesVisiveis(THIS)
334: 
335:             loc_lSucesso = .T.
336:         CATCH TO loc_oErro
337:             MsgErro(loc_oErro.Message + CHR(13) + ;
338:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
339:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpEmb.InicializarForm")
340:         ENDTRY
341: 
342:         RETURN loc_lSucesso
343:     ENDPROC
344: 
345:     *--------------------------------------------------------------------------
346:     * ConfigurarPageFrame - Orquestrador de layout base.
347:     * SIGOEMB original eh flat OPERACIONAL (sem PageFrame nativo) - popup
348:     * modal aberto a partir de um item de movimento. Nome mantido por
349:     * convencao do orquestrador multi-fase (mesmo padrao de
350:     * FormSigOpDet.ConfigurarPageFrame).
351:     *
352:     * ORDEM OBRIGATORIA:
353:     *   1. cabecalho PRIMEIRO - cmg_4c_Botoes fica em Top = -2, DENTRO da
354:     *      area da faixa (Top 0..80), e so desenha por cima dela se for
355:     *      criado DEPOIS (regra #11);
356:     *   2. CarregarLista ANTES da grade - Column.ControlSource estoura
357:     *      "Alias not found" se o cursor nao existir (regra #41), e
358:     *      SigOpEmbBO.CriarCursorEmbalagens() pode recriar o alias, o que
359:     *      derrubaria um bind ja feito;
360:     *   3. grade e botoes;
361:     *   4. RepintarGrade por ULTIMO - popular o cursor NAO repinta a grade
362:     *      (regra #21).
363:     *
364:     * NAO EXISTEM ConfigurarPaginaLista/AlternarPagina proprios nesta tela:
365:     * o SIGOEMB legado eh FLAT (a arvore do dump tem form + cntSombra +
366:     * cntBotoes + Grade, sem PageFrame nenhum), entao nao ha Page1/Lista
367:     * para configurar nem paginas para alternar. Criar os dois obrigaria a
368:     * INVENTAR um PageFrame e 6 botoes CRUD que o legado nao tem (viola o
369:     * PILAR 1) ou a deixar metodo vazio (proibido pela regra de
370:     * completude). O AlternarPagina herdado de FormBase ja eh inocuo
371:     * quando nao existe pgf_4c_Paginas, e por isso tambem nao eh
372:     * sobrescrito.
373:     *--------------------------------------------------------------------------
374:     PROTECTED PROCEDURE ConfigurarPageFrame()
375:         THIS.ConfigurarCabecalho()
376:         THIS.CarregarLista()
377:         THIS.ConfigurarGrade()
378:         THIS.ConfigurarBotoesConfirmar()
379:         THIS.RepintarGrade()
380:     ENDPROC
381: 
382:     *--------------------------------------------------------------------------
383:     * ConfigurarCabecalho - Container cnt_4c_Cabecalho (cntSombra do
384:     * legado) com os dois labels do titulo. Largura do container segue
385:     * THIS.Width (regra CLAUDE.md #11 - nunca hardcoded); a largura dos
386:     * labels e derivada de THIS.Width (e nao do 769 fixo do dump, que
387:     * pertence a classe generica de 800px do Framework e, copiado
388:     * literalmente, ultrapassaria os 650px deste form e seria recortado
389:     * pelo container - regra CLAUDE.md #30).
390:     *--------------------------------------------------------------------------
391:     PROTECTED PROCEDURE ConfigurarCabecalho()
392:         LOCAL loc_oCab, loc_nLarguraLabel
393: 
394:         loc_nLarguraLabel = THIS.Width - 20
395: 
396:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
397:         loc_oCab = THIS.cnt_4c_Cabecalho
398:         WITH loc_oCab
399:             .Top         = 0
400:             .Left        = 0
401:             .Width       = THIS.Width
402:             .Height      = 80
403:             .BorderWidth = 0
404:             .BackStyle   = 1
405:             .BackColor   = RGB(100, 100, 100)
406:         ENDWITH
407: 
408:         *-- Labels adicionados FORA do WITH do container: WITH aninhado com
409:         *-- AddObject ignora propriedades silenciosamente (CLAUDE.md #33)
410:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
411:         WITH loc_oCab.lbl_4c_Sombra
412:             .FontBold  = .T.
413:             .FontName  = "Tahoma"
414:             .FontSize  = 18
415:             .WordWrap  = .T.
416:             .AutoSize  = .F.
417:             .Alignment = 0
418:             .BackStyle = 0
419:             .Caption   = ""
420:             .Height    = 40
421:             .Left      = 10
422:             .Top       = 18
423:             .Width     = loc_nLarguraLabel
424:             .ForeColor = RGB(0, 0, 0)
425:         ENDWITH
426: 
427:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
428:         WITH loc_oCab.lbl_4c_Titulo
429:             .FontBold  = .T.
430:             .FontName  = "Tahoma"
431:             .FontSize  = 18

*-- Linhas 464 a 507:
464:     * eh FONTE UNICA compartilhada com CarregarLista - duas copias do bind
465:     * divergiriam em silencio na primeira coluna nova (regra #44, item 6).
466:     *--------------------------------------------------------------------------
467:     PROTECTED PROCEDURE ConfigurarGrade()
468:         LOCAL loc_oGrade
469: 
470:         THIS.AddObject("grd_4c_Dados", "Grid")
471:         loc_oGrade = THIS.grd_4c_Dados
472:         WITH loc_oGrade
473:             .Top          = 84
474:             .Left         = 84
475:             .Width        = 380
476:             .Height       = 143
477:             .FontName     = "Verdana"
478:             .FontSize     = 8
479:             .HeaderHeight = 22
480:             .RowHeight    = 20
481:             .ScrollBars   = 2
482:             .Panel        = 1
483:             .TabIndex     = 1
484:             .RecordMark   = .F.
485:             .DeleteMark   = .F.
486:         ENDWITH
487: 
488:         THIS.VincularGrade()
489:     ENDPROC
490: 
491:     *--------------------------------------------------------------------------
492:     * VincularGrade - bind COMPLETO da grade ao cursor das embalagens.
493:     * FONTE UNICA: chamado por ConfigurarGrade (criacao) e por CarregarLista
494:     * (recarga).
495:     *
496:     * Precisa ser reaplicado INTEIRO a cada recarga porque atribuir
497:     * RecordSource reseta Column.Width, Header1.Caption, Sparse e
498:     * CurrentControl (regra #48).
499:     *
500:     * ColumnCount so eh tocado quando esta diferente de 4: reatribui-lo
501:     * DESTROI os objetos Column e com eles os TextBox postos por AddObject.
502:     *
503:     * ControlSource das 4 colunas, transcrito do Init legado:
504:     *   Column1 -> LocalEmb.Qtds      (quantidade digitada - unica editavel)
505:     *   Column2 -> LocalEmb.Descs     (descricao da embalagem)
506:     *   Column3 -> LocalEmb.PesoEmbs  (peso unitario do cadastro)
507:     *   Column4 -> LocalEmb.Pesos     (Qtds * PesoEmbs)

*-- Linhas 591 a 651:
591:     * EMBUTIDOS (fim deste arquivo), instalada com AddObject +
592:     * CurrentControl + Sparse = .F. - sem o CurrentControl a Column continua
593:     * desenhando o Text1 nativo e o controle nunca aparece (regra #18); e
594:     * BINDEVENT em Valid/When de TextBox dentro de Column nao dispara de
595:     * forma confiavel (regra #46).
596:     *
597:     * O controle interno eh alcancado por EVALUATE porque o nome dele chega
598:     * como STRING: Controls() eh indexado por NUMERO e passar o nome estoura
599:     * "CONTROLS is not an object" dentro de WITH (regra #34).
600:     *
601:     * par_cInputMaskColuna / par_cInputMaskControle - os dois vem do dump e
602:     * sao DIFERENTES na Column1 ("999999" na Column, "999" no Text1). Quem
603:     * governa a digitacao eh o do CONTROLE, entao transcrever so o da Column
604:     * mudaria o limite que o usuario enxerga. Vazio = o SCX nao declara, e
605:     * nada eh atribuido (regra #49: InputMask ausente nao se inventa).
606:     *
607:     * Ordem obrigatoria no fim: ControlSource -> InputMask -> Width ->
608:     * Header1.Caption. Mexer na fonte do dado reseta largura e cabecalho
609:     * (regra #48).
610:     *--------------------------------------------------------------------------
611:     PROTECTED PROCEDURE VincularColunaEmb(par_oColuna, par_cNomeControle, ;
612:             par_cClasseControle, par_cControlSource, par_nWidth, par_cCaption, ;
613:             par_cInputMaskColuna, par_cInputMaskControle)
614: 
615:         IF !PEMSTATUS(par_oColuna, par_cNomeControle, 5)
616:             par_oColuna.AddObject(par_cNomeControle, par_cClasseControle)
617:         ENDIF
618: 
619:         par_oColuna.CurrentControl = par_cNomeControle
620:         par_oColuna.Sparse         = .F.
621: 
622:         *-- Propriedades do TextBox da celula (Column<N>.Text1 do dump:
623:         *-- BorderStyle=0, Margin=0, ForeColor=0,0,0, BackColor=255,255,255)
624:         WITH EVALUATE("par_oColuna." + par_cNomeControle)
625:             .FontName    = "Verdana"
626:             .FontSize    = 8
627:             .BorderStyle = 0
628:             .Margin      = 0
629:             .ForeColor   = RGB(0, 0, 0)
630:             .BackColor   = RGB(255, 255, 255)
631:             .Visible     = .T.
632: 
633:             IF !EMPTY(par_cInputMaskControle)
634:                 .InputMask = par_cInputMaskControle
635:             ENDIF
636:         ENDWITH
637: 
638:         WITH par_oColuna
639:             .ControlSource = par_cControlSource
640:             .FontName      = "Verdana"
641:             .FontSize      = 8
642: 
643:             IF !EMPTY(par_cInputMaskColuna)
644:                 .InputMask = par_cInputMaskColuna
645:             ENDIF
646: 
647:             .Width             = par_nWidth
648:             .Header1.Caption   = par_cCaption
649:             .Header1.Alignment = 2
650:             .Header1.FontName  = "Verdana"
651:             .Header1.FontSize  = 8

*-- Linhas 684 a 770:
684:     * fica DENTRO da area da faixa e so desenha por cima dela se for o
685:     * AddObject posterior (regra #11).
686:     *--------------------------------------------------------------------------
687:     PROTECTED PROCEDURE ConfigurarBotoesConfirmar()
688:         LOCAL loc_oGrp
689: 
690:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
691:         loc_oGrp = THIS.cmg_4c_Botoes
692:         WITH loc_oGrp
693:             .ButtonCount   = 1
694:             .Top           = -2
695:             .Left          = 567
696:             .Width         = 85
697:             .Height        = 85
698:             .BackStyle     = 0
699:             .BorderStyle   = 0
700:             .Value         = 0
701:             .TabIndex      = 2
702:             .SpecialEffect = 1
703:             .BorderColor   = RGB(136, 189, 188)
704:             .Themes        = .F.
705:         ENDWITH
706: 
707:         *-- Buttons(1) = btnConfirmar do legado
708:         WITH loc_oGrp.Buttons(1)
709:             .Top          = 5
710:             .Left         = 5
711:             .Height       = 75
712:             .Width        = 75
713:             .AutoSize     = .F.
714:             .FontBold     = .T.
715:             .FontItalic   = .T.
716:             .FontName     = "Comic Sans MS"
717:             .FontSize     = 8
718:             .WordWrap     = .T.
719:             .Picture      = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
720:             .Caption      = "\<Encerrar"
721:             .Cancel       = .T.
722:             .MousePointer = 15
723:             .TabIndex     = 1
724:             .ToolTipText  = "Confirmar a Sele" + CHR(231) + CHR(227) + "o"
725:             .ForeColor    = RGB(90, 90, 90)
726:             .BackColor    = RGB(255, 255, 255)
727:             .Themes       = .F.
728:         ENDWITH
729: 
730:         BINDEVENT(loc_oGrp.Buttons(1), "Click", THIS, "BtnConfirmarClick")
731:     ENDPROC
732: 
733:     *--------------------------------------------------------------------------
734:     * ObterAliasGrade - nome do alias que alimenta a grade.
735:     *
736:     * Lido do BO (this_cCursorEmbalagens), que eh o DONO da estrutura e o
737:     * ponto UNICO de CREATE CURSOR desta tela - repetir o literal aqui
738:     * criaria uma segunda fonte de verdade para o nome, e um renomeio no BO
739:     * passaria a bindar a grade num alias que ninguem popula. O literal
740:     * entra SO como ultimo recurso (BO ausente), para o metodo nunca
741:     * devolver string vazia e fazer USED("") estourar.
742:     *--------------------------------------------------------------------------
743:     PROTECTED FUNCTION ObterAliasGrade()
744:         LOCAL loc_cAlias
745:         loc_cAlias = ""
746: 
747:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
748:             loc_cAlias = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cCursorEmbalagens, ""))
749:         ENDIF
750: 
751:         IF EMPTY(loc_cAlias)
752:             loc_cAlias = "cursor_4c_Embalagens"
753:         ENDIF
754: 
755:         RETURN loc_cAlias
756:     ENDFUNC
757: 
758:     *--------------------------------------------------------------------------
759:     * CarregarDadosGrade - popula o cursor da grade ANTES de ela existir.
760:     *
761:     * Equivale ao trecho do Init legado que roda a consulta do cadastro
762:     * (LocalCdEmb) e monta o LEFT JOIN com as linhas do item (LocalEmb) -
763:     * aqui tudo isso mora em SigOpEmbBO.CarregarEmbalagensDoItem().
764:     *
765:     * Em validacao de UI / modo teste (gnConnHandle = -1) a carga real NAO
766:     * eh tentada: SigOpEmbBO.CarregarCadastroEmbalagens() exibe "Favor
767:     * Reinicializar o Processo!!!" sem conexao, e um MsgErro modal numa
768:     * instanciacao automatizada PENDURA o processo. Nesse caso so o cursor
769:     * VAZIO eh criado (CriarCursorEmbalagens), suficiente para a grade
770:     * bindar sem estourar.

*-- Linhas 818 a 1299:
818:     * ConfigurarPageFrame) a grade ainda nao existe e o rebind eh pulado
819:     * pela guarda de VincularGrade.
820:     *--------------------------------------------------------------------------
821:     PROCEDURE CarregarLista()
822:         LOCAL loc_lSucesso
823: 
824:         loc_lSucesso = THIS.CarregarDadosGrade()
825: 
826:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
827:             THIS.VincularGrade()
828:             THIS.RepintarGrade()
829:         ENDIF
830: 
831:         RETURN loc_lSucesso
832:     ENDPROC
833: 
834:     *--------------------------------------------------------------------------
835:     * RepintarGrade - "Select LocalEmb / Go Top" + Refresh do fim do Init
836:     * legado.
837:     *
838:     * Popular o cursor NAO repinta a grade (regra #21): sem o GO TOP a
839:     * grade pode abrir posicionada em EOF e parecer VAZIA com o cursor
840:     * cheio, e o sintoma reportado ("a tela nao traz as embalagens") manda
841:     * o diagnostico para SQL/cursor/permissao, onde nao ha defeito nenhum.
842:     *--------------------------------------------------------------------------
843:     PROTECTED FUNCTION RepintarGrade()
844:         LOCAL loc_lSucesso, loc_cAlias
845: 
846:         loc_lSucesso = .F.
847:         loc_cAlias   = THIS.ObterAliasGrade()
848: 
849:         IF USED(loc_cAlias) AND PEMSTATUS(THIS, "grd_4c_Dados", 5)
850:             SELECT (loc_cAlias)
851:             GO TOP
852:             THIS.grd_4c_Dados.Refresh()
853:             loc_lSucesso = .T.
854:         ENDIF
855: 
856:         RETURN loc_lSucesso
857:     ENDFUNC
858: 
859:     *--------------------------------------------------------------------------
860:     * BtnConfirmarClick - alvo do BINDEVENT do unico botao da tela. PUBLIC:
861:     * BINDEVENT ignora metodo PROTECTED em silencio (regra #3).
862:     *--------------------------------------------------------------------------
863:     PROCEDURE BtnConfirmarClick()
864:         THIS.ConfirmarEmbalagensExec()
865:     ENDPROC
866: 
867:     *--------------------------------------------------------------------------
868:     * ConfirmarEmbalagensExec - corpo do btnConfirmar.Click legado, na mesma
869:     * ordem:
870:     *   1. soma o peso total das embalagens (lnTotP);
871:     *   2. regrava as linhas do item;
872:     *   3. devolve o total ao pai (thisform.parentform.pesoemb = lnTotP);
873:     *   4. fecha a tela (ThisForm.Release()).
874:     * Os passos 1 e 2 sao do BO (GravarEmbalagensDoItem); 3 e 4 sao da TELA
875:     * e ficam aqui.
876:     *
877:     * DIVERGENCIA DELIBERADA, registrada para nao ser "consertada" num sweep
878:     * futuro: o legado NAO tem caminho de falha - ele escreve no cursor
879:     * remoto do pai sem conferir nada e SEMPRE faz Release. O BO migrado
880:     * DETECTA falha (sem item para enderecar a gravacao, erro do SQL Server,
881:     * lote revertido), e nesse caso a tela PERMANECE ABERTA: fechar
882:     * devolveria ao pai um peso que nao corresponde a nada gravado, e o
883:     * usuario veria o valor mudar na tela dele e perder tudo depois.
884:     * O peso so eh devolvido no caminho de SUCESSO, pela mesma razao.
885:     *--------------------------------------------------------------------------
886:     PROTECTED PROCEDURE ConfirmarEmbalagensExec()
887:         LOCAL loc_oErro
888: 
889:         TRY
890:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
891:                 IF THIS.this_oBusinessObject.GravarEmbalagensDoItem()
892:                     THIS.DevolverPesoTotalAoPai( ;
893:                         THIS.this_oBusinessObject.this_nPesoTotalEmbalagens)
894:                     THIS.FecharDialogo()
895:                 ELSE
896:                     *-- BusinessBase/BO ja reportam a falha e marcam
897:                     *-- this_lErroExibido; a mensagem so eh repetida aqui se
898:                     *-- sobrou texto SEM ter sido exibido (regra #20)
899:                     IF !THIS.this_oBusinessObject.this_lErroExibido ;
900:                         AND !EMPTY(ALLTRIM(NVL(THIS.this_oBusinessObject.this_cMensagemErro, "")))
901:                         MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
902:                             "Quantidade de Embalagens")
903:                     ENDIF
904: 
905:                     *-- A tela continua aberta: repintar devolve a grade ao
906:                     *-- topo para o usuario localizar o que corrigir
907:                     THIS.RepintarGrade()
908:                 ENDIF
909:             ELSE
910:                 *-- Sem BO nao ha o que gravar (instanciacao automatizada):
911:                 *-- o dialogo apenas fecha, devolvendo peso zero
912:                 THIS.DevolverPesoTotalAoPai(0)
913:                 THIS.FecharDialogo()
914:             ENDIF
915:         CATCH TO loc_oErro
916:             MsgErro(loc_oErro.Message + CHR(13) + ;
917:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
918:                 "Procedure: " + loc_oErro.Procedure, ;
919:                 "FormSigOpEmb.ConfirmarEmbalagensExec")
920:         ENDTRY
921:     ENDPROC
922: 
923:     *--------------------------------------------------------------------------
924:     * DevolverPesoTotalAoPai - "thisform.parentform.pesoemb = <peso>" do
925:     * legado, que roda duas vezes: zerando no Init e com o total no
926:     * btnConfirmar.Click.
927:     *
928:     * O valor eh guardado ANTES em this_nPesoTotalEmbalagens, que eh o que
929:     * ObterPesoTotalEmbalagens() devolve - o caminho de leitura de quem abre
930:     * o dialogo com CREATEOBJECT + Show() (ver o contrato no cabecalho deste
931:     * arquivo). A copia para o pai NAO pode ficar no Destroy: FecharDialogo
932:     * usa Hide() e o Destroy so roda quando o chamador liberar o objeto,
933:     * tarde demais para quem le logo apos o Show().
934:     *
935:     * AddProperty quando o pai nao tem "pesoemb": eh o que o proprio
936:     * framework legado faz com as properties que espera do form
937:     * (If Type('ThisForm.<x>') == 'U' / ThisForm.AddProperty(...)), e sem
938:     * isso a atribuicao estouraria "Property PESOEMB is not found" num pai
939:     * migrado que ainda nao declare a property.
940:     *
941:     * Refresh no pai, NAO recarga: as linhas do item foram reescritas no
942:     * cursor que o pai ja tem aberto (SigOpEmbBO.SincronizarCursorItensMov)
943:     * - chamar um CarregarLista dele RECONSULTARIA o banco e descartaria
944:     * justamente essas alteracoes ainda nao comitadas. Falha aqui NAO eh
945:     * fatal: a gravacao ja aconteceu, entao o erro eh avisado e o fluxo
946:     * segue.
947:     *--------------------------------------------------------------------------
948:     PROTECTED FUNCTION DevolverPesoTotalAoPai(par_nPeso)
949:         LOCAL loc_lSucesso, loc_nPeso, loc_oErro
950: 
951:         loc_lSucesso = .F.
952:         loc_nPeso    = IIF(VARTYPE(par_nPeso) = "N", par_nPeso, 0)
953: 
954:         THIS.this_nPesoTotalEmbalagens = loc_nPeso
955: 
956:         IF VARTYPE(THIS.this_oFormPai) = "O"
957:             TRY
958:                 IF !PEMSTATUS(THIS.this_oFormPai, "pesoemb", 5)
959:                     THIS.this_oFormPai.AddProperty("pesoemb", 0)
960:                 ENDIF
961: 
962:                 THIS.this_oFormPai.pesoemb = loc_nPeso
963:                 THIS.this_oFormPai.Refresh()
964: 
965:                 loc_lSucesso = .T.
966:             CATCH TO loc_oErro
967:                 MsgAviso("As embalagens foram gravadas, mas o peso total n" + ;
968:                     CHR(227) + "o p" + CHR(244) + "de ser devolvido " + ;
969:                     CHR(224) + " tela da movimenta" + CHR(231) + CHR(227) + "o:" + ;
970:                     CHR(13) + loc_oErro.Message, "Quantidade de Embalagens")
971:             ENDTRY
972:         ENDIF
973: 
974:         RETURN loc_lSucesso
975:     ENDFUNC
976: 
977:     *--------------------------------------------------------------------------
978:     * ObterPesoTotalEmbalagens - leitura do resultado por quem abriu o
979:     * dialogo. PUBLIC: eh o contrato da tela.
980:     *--------------------------------------------------------------------------
981:     FUNCTION ObterPesoTotalEmbalagens()
982:         RETURN THIS.this_nPesoTotalEmbalagens
983:     ENDFUNC
984: 
985:     *--------------------------------------------------------------------------
986:     * FecharDialogo - ponto UNICO de encerramento da janela.
987:     *
988:     * Hide(), NAO Release(): medido no VFP9, Release() destroi o objeto
989:     * mesmo com o chamador segurando a referencia, e a leitura seguinte
990:     * (ObterPesoTotalEmbalagens) estoura "is not an object" - o dialogo
991:     * ficaria sem como devolver o peso que ele existe para calcular. O
992:     * legado entrega o resultado escrevendo no form pai, caminho que aqui
993:     * continua existindo (DevolverPesoTotalAoPai) mas que nao cobre quem
994:     * abre sem passar o pai. Em form modal o Hide tambem devolve o Show,
995:     * entao para o usuario a tela fecha igual (PILAR 1 preservado): muda so
996:     * o tempo de vida do objeto, que eh PILAR 3. O Release fica com o
997:     * CHAMADOR, como em FormBuscaAuxiliar.
998:     *
999:     * PUBLIC: chamado de dentro (ConfirmarEmbalagensExec) e pelo harness de
1000:     * teste automatico, que procura FecharDialogo quando nao ha
1001:     * BtnEncerrarClick/BtnFecharClick/BtnSairClick.
1002:     *--------------------------------------------------------------------------
1003:     PROCEDURE FecharDialogo()
1004:         THIS.Hide()
1005:     ENDPROC
1006: 
1007:     *--------------------------------------------------------------------------
1008:     * ValidarQuantidadeGrade - Grade.Column1.Text1.Valid do legado:
1009:     *     Select LocalEmb
1010:     *     Replace Qtds With This.Value,
1011:     *             Pesos with Localemb.Qtds * LocalEmb.PesoEmbs
1012:     *     thisform.grade.Refresh()
1013:     *
1014:     * A gravacao no cursor e o recalculo moram no BO (AtualizarPesoLinha);
1015:     * aqui fica so o Refresh, que eh da TELA.
1016:     *
1017:     * O valor digitado vem de par_oTxt.Value, NAO do cursor: dentro do Valid
1018:     * o cursor ainda tem o valor ANTIGO (regra #46) - ler dali recalcularia
1019:     * o peso com a quantidade anterior.
1020:     *
1021:     * Retorna SEMPRE .T.: o Valid legado nao tem RETURN (e procedure sem
1022:     * RETURN devolve .T. em VFP9), ou seja ele nunca prende o usuario na
1023:     * celula. Devolver .F. numa falha mudaria o comportamento da tela.
1024:     *
1025:     * PUBLIC: chamado de FORA da classe, pelo Valid do TextBox da celula.
1026:     *--------------------------------------------------------------------------
1027:     PROCEDURE ValidarQuantidadeGrade(par_oTxt)
1028:         LOCAL loc_oErro
1029: 
1030:         TRY
1031:             IF VARTYPE(THIS.this_oBusinessObject) = "O" AND VARTYPE(par_oTxt) = "O"
1032:                 THIS.this_oBusinessObject.AtualizarPesoLinha(par_oTxt.Value)
1033:             ENDIF
1034: 
1035:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1036:                 THIS.grd_4c_Dados.Refresh()
1037:             ENDIF
1038:         CATCH TO loc_oErro
1039:             MsgErro(loc_oErro.Message + CHR(13) + ;
1040:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1041:                 "Procedure: " + loc_oErro.Procedure, ;
1042:                 "FormSigOpEmb.ValidarQuantidadeGrade")
1043:         ENDTRY
1044: 
1045:         RETURN .T.
1046:     ENDPROC
1047: 
1048:     *--------------------------------------------------------------------------
1049:     * Activate - "This.Grade.Column1.SetFocus()" do fim do Init legado.
1050:     *
1051:     * No Init do form migrado a janela ainda nao esta visivel e SetFocus em
1052:     * controle invisivel falha; o Activate roda quando a tela aparece, que eh
1053:     * o instante em que o legado (DoCreate = .T., tela ja montada) tinha o
1054:     * foco aplicado.
1055:     *--------------------------------------------------------------------------
1056:     PROCEDURE Activate()
1057:         THIS.PosicionarFocoQuantidade()
1058:     ENDPROC
1059: 
1060:     *--------------------------------------------------------------------------
1061:     * PosicionarFocoQuantidade - corpo do Activate, com trava de uma unica
1062:     * execucao: o legado posiciona o cursor UMA vez, na abertura. Sem a
1063:     * trava, cada reativacao da janela puxaria o foco de volta para a
1064:     * primeira celula e tiraria o usuario da linha em que ele estava.
1065:     *
1066:     * TRY/CATCH silencioso de proposito: foco eh conveniencia, nao funcao -
1067:     * um SetFocus recusado (grade vazia, celula nao editavel, janela ainda
1068:     * sem foco) nao pode render dialogo de erro na abertura da tela.
1069:     *--------------------------------------------------------------------------
1070:     PROTECTED PROCEDURE PosicionarFocoQuantidade()
1071:         LOCAL loc_oErro
1072: 
1073:         IF !THIS.this_lFocoInicialAplicado
1074:             THIS.this_lFocoInicialAplicado = .T.
1075: 
1076:             TRY
1077:                 IF PEMSTATUS(THIS, "grd_4c_Dados", 5) ;
1078:                     AND THIS.grd_4c_Dados.ColumnCount >= 1 ;
1079:                     AND THIS.grd_4c_Dados.Visible
1080:                     THIS.grd_4c_Dados.Column1.SetFocus()
1081:                 ENDIF
1082:             CATCH TO loc_oErro
1083:                 *-- Foco recusado: a tela continua utilizavel, o usuario so
1084:                 *-- precisa clicar na celula. Nao ha o que reportar.
1085:             ENDTRY
1086:         ENDIF
1087:     ENDPROC
1088: 
1089:     *--------------------------------------------------------------------------
1090:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
1091:     * (AddObject cria controles com Visible=.F. por padrao)
1092:     *--------------------------------------------------------------------------
1093:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1094:         LOCAL loc_i, loc_oCtrl
1095: 
1096:         FOR loc_i = 1 TO par_oContainer.ControlCount
1097:             loc_oCtrl = par_oContainer.Controls(loc_i)
1098:             IF VARTYPE(loc_oCtrl) = "O"
1099:                 IF PEMSTATUS(loc_oCtrl, "Visible", 5)
1100:                     loc_oCtrl.Visible = .T.
1101:                 ENDIF
1102:                 IF UPPER(loc_oCtrl.BaseClass) = "PAGEFRAME"
1103:                     LOCAL loc_p
1104:                     FOR loc_p = 1 TO loc_oCtrl.PageCount
1105:                         THIS.TornarControlesVisiveis(loc_oCtrl.Pages(loc_p))
1106:                     ENDFOR
1107:                 ENDIF
1108:                 IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
1109:                     THIS.TornarControlesVisiveis(loc_oCtrl)
1110:                 ENDIF
1111:             ENDIF
1112:         ENDFOR
1113:     ENDPROC
1114: 
1115:     *--------------------------------------------------------------------------
1116:     * DesvincularGrade - as TRES primeiras linhas do PROCEDURE Release
1117:     * legado, que a migracao tinha deixado de fora:
1118:     *     This.Grade.RecordSource          = []
1119:     *     This.Grade.Column1.ControlSource = []
1120:     *     This.Grade.Column2.ControlSource = []
1121:     *
1122:     * O legado solta o bind ANTES do "Use In LocalEmb", e a ordem eh o
1123:     * ponto: fechar o alias com a grade ainda apontando para ele deixa o
1124:     * Grid com RecordSource/ControlSource para um alias morto. Nao estoura
1125:     * no encerramento (medido - o cursor fecha sem erro), mas um Refresh
1126:     * que ainda chegue a grade nesse intervalo - repaint da janela a
1127:     * caminho, Destroy do pai, Timer - pinta a partir de alias inexistente.
1128:     * Soltar o bind primeiro eh o que o legado faz e custa tres linhas.
1129:     *
1130:     * Aqui o laco cobre as QUATRO colunas, nao as duas do legado: o SCX
1131:     * declarava ControlSource nas quatro (Qtds/Descs/PesoEmbs/Pesos) e
1132:     * limpava so duas, o que eh descuido do proprio legado e nao regra -
1133:     * deixar Column3/Column4 ligadas reproduziria o descuido sem
1134:     * reproduzir nenhum comportamento observavel.
1135:     *
1136:     * Idempotente e silencioso de proposito: roda no caminho de
1137:     * encerramento, onde um dialogo de erro nao tem a quem avisar e
1138:     * impediria o Destroy de concluir.
1139:     *--------------------------------------------------------------------------
1140:     PROTECTED PROCEDURE DesvincularGrade()
1141:         LOCAL loc_nCol, loc_oErro
1142: 
1143:         TRY
1144:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1145:                 FOR loc_nCol = 1 TO THIS.grd_4c_Dados.ColumnCount
1146:                     STORE "" TO ("THIS.grd_4c_Dados.Column" + ;
1147:                         TRANSFORM(loc_nCol) + ".ControlSource")
1148:                 ENDFOR
1149: 
1150:                 THIS.grd_4c_Dados.RecordSource = ""
1151:             ENDIF
1152:         CATCH TO loc_oErro
1153:             *-- Encerramento: nao ha a quem reportar, e insistir abortaria o
1154:             *-- fechamento dos cursores logo abaixo.
1155:         ENDTRY
1156:     ENDPROC
1157: 
1158:     *--------------------------------------------------------------------------
1159:     * FecharCursoresDoDialogo - "Use In LocalEmb" do PROCEDURE Release
1160:     * legado, estendido aos cursores auxiliares que o BO abre.
1161:     *
1162:     * Os nomes vem das PROPERTIES do BO, nao de literais repetidos aqui:
1163:     * o BO eh o dono da estrutura e o ponto unico de CREATE CURSOR desta
1164:     * tela (mesmo argumento de ObterAliasGrade). Com os literais
1165:     * duplicados, renomear um cursor no BO deixava este metodo fechando
1166:     * alias que nao existe mais e VAZANDO o que passou a existir - sem
1167:     * erro, sem log, e o vazamento so apareceria na proxima abertura, na
1168:     * forma de estrutura antiga reaproveitada.
1169:     *
1170:     * NAO fecha this_cCursorItensMov (crSigMvIte) nem
1171:     * this_cCursorItemCorrente (crTpmMvItn): esses dois sao do form PAI e
1172:     * so estao visiveis aqui por DataSession = 1. Fecha-los mataria a
1173:     * movimentacao em edicao do chamador - exatamente o que o legado nao
1174:     * faz (o Release dele toca unicamente em LocalEmb).
1175:     *
1176:     * Os literais entram SO como ultimo recurso (BO ja liberado quando o
1177:     * Destroy roda), para o cursor nao ficar aberto nesse caminho.
1178:     *--------------------------------------------------------------------------
1179:     PROTECTED PROCEDURE FecharCursoresDoDialogo()
1180:         LOCAL loc_nI, loc_cAlias, loc_oBO, loc_oErro
1181:         LOCAL ARRAY loc_aCursores[4]
1182: 
1183:         *-- Fallback: os nomes atuais das properties do BO
1184:         loc_aCursores[1] = "cursor_4c_Embalagens"
1185:         loc_aCursores[2] = "cursor_4c_CadEmb"
1186:         loc_aCursores[3] = "cursor_4c_LinhasItem"
1187:         loc_aCursores[4] = "cursor_4c_EmbTemp"
1188: 
1189:         TRY
1190:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1191:                 loc_oBO = THIS.this_oBusinessObject
1192: 
1193:                 IF PEMSTATUS(loc_oBO, "this_cCursorEmbalagens", 5)
1194:                     loc_aCursores[1] = ALLTRIM(NVL(loc_oBO.this_cCursorEmbalagens, loc_aCursores[1]))
1195:                 ENDIF
1196:                 IF PEMSTATUS(loc_oBO, "this_cCursorCadEmb", 5)
1197:                     loc_aCursores[2] = ALLTRIM(NVL(loc_oBO.this_cCursorCadEmb, loc_aCursores[2]))
1198:                 ENDIF
1199:                 IF PEMSTATUS(loc_oBO, "this_cCursorLinhasItem", 5)
1200:                     loc_aCursores[3] = ALLTRIM(NVL(loc_oBO.this_cCursorLinhasItem, loc_aCursores[3]))
1201:                 ENDIF
1202:                 IF PEMSTATUS(loc_oBO, "this_cCursorTemp", 5)
1203:                     loc_aCursores[4] = ALLTRIM(NVL(loc_oBO.this_cCursorTemp, loc_aCursores[4]))
1204:                 ENDIF
1205:             ENDIF
1206:         CATCH TO loc_oErro
1207:             *-- BO indisponivel: segue com os nomes de fallback acima.
1208:         ENDTRY
1209: 
1210:         FOR loc_nI = 1 TO ALEN(loc_aCursores)
1211:             loc_cAlias = loc_aCursores[loc_nI]
1212: 
1213:             IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
1214:                 USE IN (loc_cAlias)
1215:             ENDIF
1216:         ENDFOR
1217:     ENDPROC
1218: 
1219:     *--------------------------------------------------------------------------
1220:     * Destroy - PROCEDURE Release legado, na MESMA ordem dele: solta o bind
1221:     * da grade e so DEPOIS fecha os cursores.
1222:     *
1223:     * DODEFAULT() por ultimo: FormBase.Destroy restaura os popups do menu
1224:     * principal apos fechar form modal - sem isso por ultimo, o rendering
1225:     * dos popups fica corrompido (CLAUDE.md).
1226:     *--------------------------------------------------------------------------
1227:     PROCEDURE Destroy()
1228:         THIS.DesvincularGrade()
1229:         THIS.FecharCursoresDoDialogo()
1230: 
1231:         DODEFAULT()
1232:     ENDPROC
1233: 
1234: ENDDEFINE
1235: 
1236: *==============================================================================
1237: * TextBoxQtdeEmb_4c - celula "Qtde" (Column1) da grade de embalagens.
1238: *
1239: * Transcreve SIGOEMB.Grade.Column1.Text1 do legado:
1240: *   When  -> Return .T.                       (unica coluna editavel)
1241: *   Valid -> Replace Qtds/Pesos + Grade.Refresh  (-> ValidarQuantidadeGrade)
1242: *
1243: * Eventos EMBUTIDOS na classe, nao por BINDEVENT: BINDEVENT em Valid/When de
1244: * TextBox dentro de Column nao dispara de forma confiavel (regra #46, e o
1245: * cabecalho de classes\TextBoxGridLookup.prg). Mesmo padrao de
1246: * TextBoxProdutoLpr_4c (FormLpr.prg) e das celulas de FormSigOpDet.
1247: *
1248: * O guard PEMSTATUS protege a classe de ser instalada num form que nao
1249: * implemente o metodo (ela so existe para este, mas o custo eh uma linha e
1250: * evita derrubar a tela em runtime).
1251: *==============================================================================
1252: DEFINE CLASS TextBoxQtdeEmb_4c AS TextBox
1253: 
1254:     PROCEDURE When()
1255:         *-- "Return .T." do Column1.Text1.When legado: a quantidade eh o
1256:         *-- unico campo que o usuario digita nesta tela, e o legado nao
1257:         *-- condiciona a edicao a modo nenhum (o dialogo so existe dentro de
1258:         *-- uma movimentacao em edicao)
1259:         RETURN .T.
1260:     ENDPROC
1261: 
1262:     PROCEDURE Valid()
1263:         LOCAL loc_lRetorno
1264:         loc_lRetorno = .T.
1265: 
1266:         IF PEMSTATUS(THISFORM, "ValidarQuantidadeGrade", 5)
1267:             loc_lRetorno = THISFORM.ValidarQuantidadeGrade(THIS)
1268:         ENDIF
1269: 
1270:         RETURN loc_lRetorno
1271:     ENDPROC
1272: 
1273: ENDDEFINE
1274: 
1275: *==============================================================================
1276: * TextBoxLeituraEmb_4c - celulas Embalagem (Column2), Peso (Column3) e Peso
1277: * Total (Column4) da grade de embalagens.
1278: *
1279: * Transcreve o "When -> Return .F." que SIGOEMB.Grade.Column2/3/4.Text1
1280: * declaram no dump: as tres sao calculadas ou vindas do cadastro, e o legado
1281: * impede que a celula receba foco - nao apenas que seja editada.
1282: *
1283: * O When eh a protecao PRIMARIA e eh o que reproduz a UX do legado: ele recusa
1284: * o FOCO, enquanto Column.ReadOnly deixaria a celula receber foco e so recusar
1285: * a digitacao - com o When ativo o usuario nunca chega a esse ponto, e a
1286: * navegacao por Tab fica igual a do legado.
1287: *
1288: * O Column.ReadOnly = .T. que VincularGrade poe nestas tres colunas eh a rede
1289: * de baixo, para o caso de a Column ser recriada e perder esta subclasse (ver
1290: * o comentario de VincularGrade): sem ele, Peso e Peso Total - que sao
1291: * CALCULADOS - voltariam a aceitar digitacao.
1292: *==============================================================================
1293: DEFINE CLASS TextBoxLeituraEmb_4c AS TextBox
1294: 
1295:     PROCEDURE When()
1296:         RETURN .F.
1297:     ENDPROC
1298: 
1299: ENDDEFINE

