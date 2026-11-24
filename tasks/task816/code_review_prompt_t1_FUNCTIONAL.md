# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (12)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [METODO-INEXISTENTE] Metodo 'THIS.ValidarFaixaConsulta()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ResolverFaixaMFD()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.CarregarCupomDeArquivo()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterDiretorioDaruma()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGOPVCI.cntAguarde): Top original=7 vs migrado 'lbl_4c_Label1' Top=96 (diff=89px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGOPVCI.cntAguarde): Left original=87 vs migrado 'lbl_4c_Label1' Left=240 (diff=153px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGOPVCI.cntAguarde): Top original=24 vs migrado 'lbl_4c_Label2' Top=119 (diff=95px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGOPVCI.cntAguarde): Left original=46 vs migrado 'lbl_4c_Label2' Left=225 (diff=179px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup1' (parent: SIGOPVCI): Top original=90 vs migrado 'obj_4c_Optiongroup1' Top=4 (diff=86px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup1' (parent: SIGOPVCI): Left original=271 vs migrado 'obj_4c_Optiongroup1' Left=5 (diff=266px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopvci.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1725 linhas total):

*-- Linhas 13 a 98:
13: *
14: * FASE 4/8 - CONTROLES E BOTOES DE ACAO: alem do cabecalho e Destroy da
15: * Fase 3, esta fase acrescenta TODOS os controles de entrada/exibicao do
16: * corpo do form (Optiongroup1, Text1-4, Check1, Edit1, Labels, cntAguarde)
17: * e o Commandgroup1 (equivalente aos botoes CRUD do padrao cadastro - aqui
18: * sao "Consultar"/"Encerrar", os unicos botoes do legado). Os controles sao
19: * criados com as propriedades visuais EXATAS do SCX (PILAR 1).
20: *
21: * FASE 5/8 - VINCULO COM O BO: este form nao tem Page1/Page2 (layout PLANO,
22: * ver acima), entao nao ha ConfigurarPaginaDados - o equivalente aqui e
23: * FormParaBO()/BOParaForm(), que ligam os controles do corpo (obj_4c_
24: * Optiongroup1, txt_4c_Text1-4, chk_4c_Check1, edt_4c_Edit1) as properties
25: * this_* do sigopvciBO criadas na Fase 1. BOParaForm() roda no fim de
26: * InicializarForm() para o BO permanecer fonte unica do criterio (mesmo
27: * default que ConfigurarControles ja aplica). BINDEVENT dos eventos quando/
28: * lostfocus (Fase 6) e os metodos Click reais (Fases 7-8) entram nas fases
29: * seguintes - criar o controle e ligar ao BO antes de ligar o evento nao e
30: * stub, e a divisao que o processamento multi-fase adota para este tipo de
31: * form (OPERACIONAL sem lista/grade - dialogo de captura).
32: *
33: * FASE 6/8 - CAMPOS RESTANTES E LOOKUPS: o SCX legado NAO POSSUI LOOKUP
34: * ALGUM - a varredura do dump (sigopvci_form_codigo_fonte.txt, 9 metodos com
35: * codigo) devolve ZERO ocorrencia de fwBuscaExt/fwBuscaSel/fwBuscaInt,
36: * mAddColuna, sigacess()/Acesso*() e FormBuscaAuxiliar, e nenhum dos 4
37: * TextBox tem Valid que abra browse: os campos sao faixa de numero de cupom
38: * e faixa de data, digitados a mao. Criar AbrirLookup*/AbrirBusca* aqui
39: * exigiria INVENTAR tabela de referencia que o legado nao consulta, o que
40: * viola o PILAR 1 e a regra "NUNCA inventar tabelas de lookup que nao
41: * existem no original". Pelo mesmo motivo nao existe cnt_4c_BotoesAcao com
42: * Salvar/Cancelar: este form nao grava registro (ver cabecalho do
43: * sigopvciBO.prg) e os UNICOS botoes do legado sao Consultar/Encerrar, ja
44: * criados na Fase 4 em cmg_4c_Botoes.
45: *
46: * O que esta fase entrega, portanto, sao os EVENTOS dos campos que a Fase 5
47: * deixou explicitamente para ca - as 6 procedures de evento dos TextBox do
48: * legado (sigopvci_form_codigo_fonte.txt:940-1010):
49: *   - 4x When   (Text1/Text2 so acessiveis com Optiongroup1.Value = 1;
50: *                Text3/Text4 so acessiveis com Optiongroup1.Value = 2)
51: *     -> ValidarCriterioBusca(), metodo PUBLIC unico de dependencia, ligado
52: *        ao Optiongroup1 por BINDEVENT e chamado no fim de BOParaForm.
53: *        NAO se liga "When" por BINDEVENT: o BINDEVENT DESCARTA o retorno do
54: *        delegate, entao um When ligado assim nao bloqueia nada - a forma que
55: *        reproduz o legado (campo inalcancavel) e' .Enabled.
56: *   - 2x LostFocus (Text1/Text2 normalizam o numero digitado com
57: *                Transform(Val(This.Value), '@L 999999'))
58: *     -> ValidarNumeroInicial()/ValidarNumeroFinal(), ligados por BINDEVENT
59: *        em "LostFocus" (o evento do legado), delegando ao formatador unico
60: *        FormatarNumeroCupom() para a regra ficar em UM lugar so.
61: *
62: * A validacao de FAIXA (Text1 > Text2, Text3 > Text4, faixa vazia) NAO entra
63: * aqui de proposito: no legado ela mora dentro do Commandgroup1.CmdInserir.
64: * Click (sigopvci_form_codigo_fonte.txt:601+), junto com a leitura da MFD,
65: * e portanto acompanha o metodo Click real nas Fases 7-8 - antecipa-la aqui
66: * duplicaria a regra em dois lugares.
67: *
68: * FASE 7/8 - EVENTOS PRINCIPAIS DOS BOTOES: o SCX legado tem EXATAMENTE DOIS
69: * botoes, os Command1/Command2 do Commandgroup1, e os Name deles MENTEM -
70: * "CmdInserir" e "CmdExcluir" num form que nao inclui nem exclui registro
71: * algum. Os handlers sao nomeados pela ACAO, que e' o Caption que o usuario LE
72: * (sigopvci_form_codigo_fonte.txt:228 e 242):
73: *
74: *   Command1 "\<Consultar" (CmdInserir.Click, 320 linhas) -> BtnConsultarClick
75: *   Command2 "Encerrar"    (CmdExcluir.Click, "Release Windows") -> BtnEncerrarClick
76: *
77: * NAO existem BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick:
78: * esses quatro nomes sao a barra CRUD do frmcadastro, e este legado herda de
79: * "form" PURO - zero frmcadastro, zero Grupo_Op, zero pcEscolha no dump
80: * inteiro. Cria-los exigiria INVENTAR botao que o legado nao tem (viola o
81: * PILAR 1) ou deixar metodo vazio (proibido pela regra de completude).
82: *
83: * O Consultar foi quebrado em metodos na MESMA ordem do Click legado, porque
84: * porta-lo num unico corpo de 320 linhas tornaria ilegiveis os quatro ramos de
85: * impressora fiscal:
86: *
87: *   BtnConsultarClick       guarda de reentrancia + TRY (libera a flag sempre)
88: *   BtnConsultarClickExec   fluxo do Click legado, passo a passo
89: *   ValidarFaixaConsulta    as 4 validacoes de faixa do inicio do Click
90: *   AguardarPintura         a espera de 2s que deixa o "Aguarde..." aparecer
91: *   ResolverFaixaMFD        monta lcTipo/lcInic/lcFim conforme o modelo
92: *   ExtrairCupomBematech    ramo BEMA8501 (BemaFI32.dll -> DOWNLOAD.TXT)
93: *   ExtrairCupomDaruma      ramo DARUMA   (DarumaFramework.dll -> espelho_mfd.TXT)
94: *   ExtrairCupomNsweda      ramo NSWEDA   (LeMFD -> c:\Retorno.TXT)
95: *   ExtrairCupomEpson       ramo EPSON    (InterfaceEpson.dll -> C:\SAIDA_ESP.TXT)
96: *   CarregarCupomDeArquivo  fonte unica do cursor SDF -> Edit1 (comum aos 4)
97: *   ObterDiretorioDaruma    <LocalArquivos> do darumaframework.xml
98: *   CarregarConfiguracaoFiscal  pre-requisito: o "=fLerFiscal()" do Init legado

*-- Linhas 109 a 175:
109: * maquina em 2026-11-19) - sem a guarda o erro subiria e fecharia a tela.
110: *
111: * FASE 8/8 - CONSOLIDACAO FINAL: auditoria campo a campo contra o dump
112: * (sigopvci_form_codigo_fonte.txt) confirma os 9/9 metodos com codigo
113: * legado (Init, CmdInserir.Click, CmdExcluir.Click, 2x Text.LostFocus,
114: * 4x Text.When) portados, e os 18 objetos do mapeamento.json (cnt_4c_Sombra
115: * +2 labels, cmg_4c_Botoes, edt_4c_Edit1, obj_4c_Optiongroup1, txt_4c_Text1-4,
116: * chk_4c_Check1, cnt_4c_Aguarde +2 labels, lbl_4c_Label1-5) criados com as
117: * propriedades visuais exatas do SCX. Test-CompletudeCodigo (sem TODO/stub/
118: * procedure vazia) e COMPILE (sem erro) confirmados nesta maquina em
119: * 2026-11-19.
120: *
121: * O QUE NAO SE APLICA A ESTE FORM (e por que inventar violaria o PILAR 1):
122: *   - BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick/
123: *     BtnSalvarClick/BtnCancelarClick: a barra CRUD do frmcadastro.
124: *     Este legado herda de "form" puro (zero frmcadastro, zero Grupo_Op,
125: *     zero pcEscolha no dump inteiro) e os UNICOS botoes sao Consultar
126: *     (BtnConsultarClick, Fase 7) e Encerrar (BtnEncerrarClick, Fase 7).
127: *   - BtnBuscarClick: o nome generico nao se aplica - a acao de buscar/ler
128: *     o cupom na impressora fiscal JA e' o botao "\<Consultar" (Caption do
129: *     legado), migrado como BtnConsultarClick.
130: *   - CarregarLista/AjustarBotoesPorModo/HabilitarCampos/LimparCampos: todos
131: *     pressupoem Page1=Lista + grid de registros. Este form e' FLAT (sem
132: *     PageFrame), nao lista nem edita registro - o cupom e' lido da MFD da
133: *     impressora fiscal e so exibido (ver cabecalho do sigopvciBO.prg).
134: *     ValidarCriterioBusca (Fase 6/7) e' o equivalente real a HabilitarCampos
135: *     aqui: habilita a faixa de numero OU a de data conforme Optiongroup1.
136: *
137: * Integracao (fora de escopo desta fase - mesmo padrao do FormSigOpTop.prg/
138: * FormSigOpTrf.prg, familia de ~230 dialogos "SigOp*" OPERACIONAL):
139: *   - config.prg: NADA a acrescentar (carga sob demanda, GarantirClasse +
140: *     start\indice_classes.txt - ja indexado automaticamente nesta maquina).
141: *   - menu.prg: NADA a acrescentar - nenhum dos outros ~230 forms "SigOp*"
142: *     (incluindo os irmaos da mesma leva, FormSIGOPTOR/FormSigOpTop/
143: *     FormSigOpTot/FormSigOpTrf/FormSigoptrp) tem item de menu proprio;
144: *     o Init legado recebe par_cFormulario (PARAMETERS poFormulario) e e'
145: *     chamado por outra tela do acervo legado (provavelmente a configuracao
146: *     de caixa/impressora fiscal), nao pelo popup principal. Inventar um
147: *     DEFINE BAR/ON SELECTION aqui criaria navegacao que o legado nao tem.
148: *------------------------------------------------------------------------------
149: DEFINE CLASS Formsigopvci AS FormBase
150: 
151:     *-- Propriedades visuais (original SIGOPVCI.SCX: DataSession=2, Height=500,
152:     *-- Width=800, BorderStyle=2, ControlBox=.F., TitleBar=0, WindowType=1)
153:     this_cMensagemErro = ""
154:     DataSession = 2
155:     ShowWindow = 1
156:     Top         = 0
157:     Left        = 0
158:     Height      = 500
159:     Width       = 800
160:     BorderStyle = 2
161:     AutoCenter  = .T.
162:     TitleBar    = 0
163:     ShowWindow  = 0
164:     WindowType  = 1
165:     ControlBox  = .F.
166:     MaxButton   = .F.
167:     MinButton   = .F.
168:     Caption     = "Vizualiza" + CHR(231) + CHR(227) + "o de Cupom Impresso"
169:     FontName    = "Tahoma"
170:     FontSize    = 8
171: 
172:     *-- Business Object
173:     this_oBusinessObject = .NULL.
174: 
175:     *-- FASE 7/8 - estado do botao Consultar (CmdInserir.Click do legado).

*-- Linhas 189 a 289:
189:     this_lEmConsulta = .F.
190: 
191:     *==========================================================================
192:     PROCEDURE Init()
193:     *==========================================================================
194:         RETURN DODEFAULT()
195:     ENDPROC
196: 
197:     *==========================================================================
198:     * InicializarForm - Chamado por FormBase.Init via DODEFAULT
199:     *==========================================================================
200:     PROTECTED PROCEDURE InicializarForm()
201:         LOCAL loc_lSucesso, loc_oErro
202:         loc_lSucesso = .F.
203: 
204:         TRY
205:             THIS.this_oBusinessObject = CREATEOBJECT("sigopvciBO")
206: 
207:             IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
208:                 IF gnConnHandle <= 0
209:                     MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
210:                             "o Com o Servidor de Banco de Dados...", ;
211:                             "Conex" + CHR(227) + "o")
212:                     loc_lSucesso = .F.
213:                 ENDIF
214:             ENDIF
215: 
216:             THIS.ConfigurarPageFrame()
217:             THIS.ConfigurarControles()
218:             THIS.ConfigurarBotoes()
219:             THIS.TornarControlesVisiveis()
220:             THIS.ConfigurarEventos()
221:             THIS.BOParaForm()
222: 
223:             *-- FASE 7/8: pre-requisito do botao Consultar - o legado le a
224:             *-- configuracao da impressora fiscal no PROPRIO Init
225:             *-- ("=fLerFiscal()", sigopvci_form_codigo_fonte.txt:548) e todo o
226:             *-- CmdInserir.Click se ramifica por crSigFiFis.Imps. Sem esta
227:             *-- carga o botao nao teria por onde decidir o modelo.
228:             THIS.CarregarConfiguracaoFiscal()
229: 
230:             loc_lSucesso = .T.
231: 
232:         CATCH TO loc_oErro
233:             THIS.this_cMensagemErro = loc_oErro.Message
234:             MsgErro(loc_oErro.Message + CHR(13) + ;
235:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
236:                 "Procedure: " + loc_oErro.Procedure, ;
237:                 "Erro InicializarForm")
238:         ENDTRY
239: 
240:         RETURN loc_lSucesso
241:     ENDPROC
242: 
243:     *==========================================================================
244:     * ConfigurarPageFrame - Constroi o cabecalho cinza superior do form e o
245:     * fundo padrao (textura new_background.jpg, igual ao SCX legado). Forms
246:     * OPERACIONAIS nao usam PageFrame CRUD - o cabecalho e um container
247:     * direto no form, equivalente ao cntSombra do framework legado.
248:     *==========================================================================
249:     PROTECTED PROCEDURE ConfigurarPageFrame()
250:         LOCAL loc_oErro
251: 
252:         TRY
253:             IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
254:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
255:             ENDIF
256: 
257:             THIS.AddObject("cnt_4c_Sombra", "Container")
258:             WITH THIS.cnt_4c_Sombra
259:                 .Top         = 0
260:                 .Left        = 0
261:                 .Width       = THIS.Width
262:                 .Height      = 80
263:                 .BackColor   = RGB(100, 100, 100)
264:                 .BackStyle   = 1
265:                 .BorderWidth = 0
266: 
267:                 .AddObject("lbl_4c_LblSombra", "Label")
268:                 WITH .lbl_4c_LblSombra
269:                     .Top       = 18
270:                     .Left      = 10
271:                     .Width     = THIS.Width
272:                     .Height    = 40
273:                     .FontBold  = .T.
274:                     .FontName  = "Tahoma"
275:                     .FontSize  = 18
276:                     .AutoSize  = .F.
277:                     .BackStyle = 0
278:                     .WordWrap  = .T.
279:                     .Alignment = 0
280:                     .ForeColor = RGB(0, 0, 0)
281:                     .Caption   = THIS.Caption
282:                 ENDWITH
283: 
284:                 .AddObject("lbl_4c_LblTitulo", "Label")
285:                 WITH .lbl_4c_LblTitulo
286:                     .Top       = 17
287:                     .Left      = 10
288:                     .Width     = THIS.Width
289:                     .Height    = 46

*-- Linhas 305 a 390:
305:             THIS.this_cMensagemErro = loc_oErro.Message
306:             MsgErro(loc_oErro.Message + CHR(13) + ;
307:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
308:                 "Procedure: " + loc_oErro.Procedure, ;
309:                 "Erro ConfigurarPageFrame")
310:         ENDTRY
311:     ENDPROC
312: 
313:     *==========================================================================
314:     * ConfigurarControles - Cria os controles de entrada/exibicao do corpo
315:     * do form, com as propriedades visuais EXATAS do SCX legado (sigopvci_
316:     * form_codigo_fonte.txt:385-519). Nao vincula ControlSource/BO (Fase 5)
317:     * nem BINDEVENT de evento (Fase 6) - so geometria/fonte/cor, igual ao
318:     * padrao de ConfigurarPaginaLista/ConfigurarPaginaDados (regra #41).
319:     *
320:     * obj_4c_Optiongroup1 (Tipo de busca: Cupom/Data) controla via When() dos
321:     * TextBoxes legado quais campos (faixa de numero x faixa de data) estao
322:     * habilitados - os Whens serao religados na Fase 6/7 junto com os demais
323:     * handlers; aqui o Value = 1 ja reproduz o default do legado (Optiongroup1.
324:     * Value = 1 no dump, Option1 = "Cupom").
325:     *==========================================================================
326:     PROTECTED PROCEDURE ConfigurarControles()
327:         LOCAL loc_oErro
328: 
329:         TRY
330:             *-- Label1 "Tipo :" (SIGOPVCI.Label1)
331:             THIS.AddObject("lbl_4c_Label1", "Label")
332:             WITH THIS.lbl_4c_Label1
333:                 .Top       = 96
334:                 .Left      = 240
335:                 .Width     = 32
336:                 .Height    = 15
337:                 .AutoSize  = .F.
338:                 .Alignment = 0
339:                 .BackStyle = 0
340:                 .FontBold  = .T.
341:                 .FontName  = "Tahoma"
342:                 .FontSize  = 8
343:                 .ForeColor = RGB(90, 90, 90)
344:                 .Caption   = "Tipo :"
345:                 .Visible   = .T.
346:             ENDWITH
347: 
348:             *-- Optiongroup1 (criterio de busca: Cupom x Data)
349:             THIS.AddObject("obj_4c_Optiongroup1", "OptionGroup")
350:             WITH THIS.obj_4c_Optiongroup1
351:                 .ButtonCount  = 2
352:                 .BackStyle    = 0
353:                 .BorderStyle  = 0
354:                 .Top          = 90
355:                 .Left         = 271
356:                 .Width        = 180
357:                 .Height       = 26
358:                 .Value        = 1
359: 
360:                 WITH .Buttons(1)
361:                     .FontName  = "Comic Sans MS"
362:                     .FontSize  = 8
363:                     .BackStyle = 0
364:                     .Caption   = " Cupom"
365:                     .Value     = 1
366:                     .Top       = 4
367:                     .Left      = 5
368:                     .Width     = 61
369:                     .Height    = 17
370:                     .ForeColor = RGB(90, 90, 90)
371:                 ENDWITH
372: 
373:                 WITH .Buttons(2)
374:                     .FontName  = "Comic Sans MS"
375:                     .FontSize  = 8
376:                     .BackStyle = 0
377:                     .Caption   = " Data"
378:                     .Top       = 4
379:                     .Left      = 84
380:                     .Width     = 61
381:                     .Height    = 17
382:                     .ForeColor = RGB(90, 90, 90)
383:                 ENDWITH
384: 
385:                 .Visible = .T.
386:             ENDWITH
387: 
388:             *-- Label2 "Cupom :" + Text1/Text2 (faixa de numero de cupom)
389:             THIS.AddObject("lbl_4c_Label2", "Label")
390:             WITH THIS.lbl_4c_Label2

*-- Linhas 599 a 656:
599:             THIS.this_cMensagemErro = loc_oErro.Message
600:             MsgErro(loc_oErro.Message + CHR(13) + ;
601:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
602:                 "Procedure: " + loc_oErro.Procedure, ;
603:                 "Erro ConfigurarControles")
604:         ENDTRY
605:     ENDPROC
606: 
607:     *==========================================================================
608:     * ConfigurarBotoes - Cria o Commandgroup1 do legado (unico bloco de
609:     * botoes do form - nao ha CRUD aqui, so a acao de ler o cupom na
610:     * impressora fiscal e a de encerrar a tela). Propriedades EXATAS do
611:     * SCX (sigopvci_form_codigo_fonte.txt:203-250). Os Click reais
612:     * (CmdInserir.Click/CmdExcluir.Click do legado) entram nas Fases 7-8;
613:     * aqui so a casca visual, igual ao padrao CRUD de criar o botao antes
614:     * de ligar o evento.
615:     *==========================================================================
616:     PROTECTED PROCEDURE ConfigurarBotoes()
617:         LOCAL loc_oErro
618: 
619:         TRY
620:             THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
621:             WITH THIS.cmg_4c_Botoes
622:                 .ButtonCount    = 2
623:                 .BackStyle      = 0
624:                 .BorderStyle    = 0
625:                 .SpecialEffect  = 1
626:                 .BorderColor    = RGB(136, 189, 188)
627:                 .AutoSize       = .T.
628:                 .Top            = -2
629:                 .Left           = 645
630:                 .Width          = 160
631:                 .Height         = 85
632:                 .Value          = 1
633: 
634:                 WITH .Buttons(1)
635:                     .Top        = 5
636:                     .Left       = 5
637:                     .Width      = 75
638:                     .Height     = 75
639:                     .FontBold   = .T.
640:                     .FontItalic = .T.
641:                     .FontName   = "Comic Sans MS"
642:                     .FontSize   = 8
643:                     .WordWrap   = .T.
644:                     .ForeColor  = RGB(90, 90, 90)
645:                     .BackColor  = RGB(255, 255, 255)
646:                     .Themes     = .F.
647:                     .Caption    = "\<Consultar"
648:                     IF FILE(gc_4c_CaminhoIcones + "geral_procura_60.jpg")
649:                         .Picture = gc_4c_CaminhoIcones + "geral_procura_60.jpg"
650:                     ENDIF
651:                 ENDWITH
652: 
653:                 WITH .Buttons(2)
654:                     .Top        = 5
655:                     .Left       = 80
656:                     .Width      = 75

*-- Linhas 677 a 1264:
677:             THIS.this_cMensagemErro = loc_oErro.Message
678:             MsgErro(loc_oErro.Message + CHR(13) + ;
679:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
680:                 "Procedure: " + loc_oErro.Procedure, ;
681:                 "Erro ConfigurarBotoes")
682:         ENDTRY
683:     ENDPROC
684: 
685:     *==========================================================================
686:     * FormParaBO - Transfere os valores digitados nos controles do corpo do
687:     * form para as properties this_* do Business Object (vinculo Form->BO,
688:     * Fase 5/8 - ver comentario de ConfigurarControles). Chamado pelos
689:     * metodos Click reais (Fases 7-8) antes de acionar a extracao do cupom
690:     * na impressora fiscal - a validacao de faixa (Text1>Text2, Text3>Text4,
691:     * faixa vazia) e exclusiva do Commandgroup1.Click do legado e entra
692:     * junto com o metodo Click real, nao aqui.
693:     *
694:     * obj_4c_Optiongroup1.Value e txt_4c_Text1-4/chk_4c_Check1.Value sao
695:     * copiados DIRETO (regra #188 - ControlSource numerico = indice 1-based,
696:     * sem +1/-1); txt_4c_Text1/Text2 guardam o numero de cupom como STRING
697:     * (ver LostFocus do legado: Transform(Val(This.Value),'@L 999999')), por
698:     * isso a conversao para this_nNumeroInicial/Final usa VAL(ALLTRIM(...)).
699:     *==========================================================================
700:     PROTECTED PROCEDURE FormParaBO()
701:         WITH THIS.this_oBusinessObject
702:             .this_nTipoBusca = THIS.obj_4c_Optiongroup1.Value
703: 
704:             .this_nNumeroInicial = ALLTRIM(THIS.txt_4c_Text1.Value)
705:             .this_nNumeroFinal   = ALLTRIM(THIS.txt_4c_Text2.Value)
706: 
707:             .this_dDataInicial = THIS.txt_4c_Text3.Value
708:             .this_dDataFinal   = THIS.txt_4c_Text4.Value
709: 
710:             .this_lGeraArquivo = (THIS.chk_4c_Check1.Value = 1)
711: 
712:             .this_cConteudoCupom = THIS.edt_4c_Edit1.Value
713:         ENDWITH
714:     ENDPROC
715: 
716:     *==========================================================================
717:     * BOParaForm - Transfere as properties this_* do Business Object para os
718:     * controles do corpo do form (vinculo BO->Form, Fase 5/8). Chamado no
719:     * fim de InicializarForm (espelha os defaults this_nTipoBusca=1/
720:     * this_lGeraArquivo=.F. ja setados em ConfigurarControles - mantem o BO
721:     * como fonte unica do criterio) e sera reusado pelos metodos Click reais
722:     * (Fases 7-8) apos THIS.this_oBusinessObject.this_cConteudoCupom receber
723:     * o retorno da leitura da impressora fiscal.
724:     *==========================================================================
725:     PROTECTED PROCEDURE BOParaForm()
726:         WITH THIS.this_oBusinessObject
727:             THIS.obj_4c_Optiongroup1.Value = IIF(BETWEEN(.this_nTipoBusca, 1, 2), .this_nTipoBusca, 1)
728: 
729:             THIS.txt_4c_Text1.Value = IIF(.this_nNumeroInicial = 0, "", TRANSFORM(.this_nNumeroInicial, "@L 999999"))
730:             THIS.txt_4c_Text2.Value = IIF(.this_nNumeroFinal = 0, "", TRANSFORM(.this_nNumeroFinal, "@L 999999"))
731: 
732:             THIS.txt_4c_Text3.Value = .this_dDataInicial
733:             THIS.txt_4c_Text4.Value = .this_dDataFinal
734: 
735:             THIS.chk_4c_Check1.Value = IIF(.this_lGeraArquivo, 1, 0)
736: 
737:             THIS.edt_4c_Edit1.Value = .this_cConteudoCupom
738:         ENDWITH
739: 
740:         *-- Estado inicial de habilitacao igual ao do legado (ver ValidarCriterioBusca):
741:         *-- o criterio recem-espelhado do BO decide qual faixa fica acessivel.
742:         THIS.ValidarCriterioBusca()
743:     ENDPROC
744: 
745:     *==========================================================================
746:     * ConfigurarEventos - Liga por BINDEVENT os eventos dos campos de entrada
747:     * que o SCX legado implementava nas procedures de evento dos TextBox
748:     * (sigopvci_form_codigo_fonte.txt:940-1010). Rodado em InicializarForm
749:     * DEPOIS de ConfigurarControles/ConfigurarBotoes (os controles-alvo tem de
750:     * existir: BINDEVENT com delegate ou alvo inexistente estoura no proprio
751:     * bind) e ANTES de BOParaForm, que fecha chamando ValidarCriterioBusca()
752:     * para o estado inicial de habilitacao ja sair igual ao do legado.
753:     *
754:     * Optiongroup1 -> ValidarCriterioBusca nos DOIS eventos: "InteractiveChange"
755:     * cobre a troca pelo teclado (setas) e "Click" a troca pelo mouse. O metodo
756:     * e' idempotente (so reatribui .Enabled), entao o disparo duplo que o mouse
757:     * provoca e' inofensivo.
758:     *
759:     * Text1/Text2 -> ValidarNumeroInicial/ValidarNumeroFinal em "LostFocus",
760:     * que e' o MESMO evento do legado (regra: lookup/normalizacao de campo vai
761:     * em LostFocus, nunca em KeyPress sem testar a tecla). Handlers de LostFocus
762:     * NAO recebem parametro - por isso os metodos sao sem argumento.
763:     * Text3/Text4 nao recebem BINDEVENT: no legado eles tem SO o When, nenhum
764:     * LostFocus (a faixa de data nao e' reformatada).
765:     *==========================================================================
766:     PROTECTED PROCEDURE ConfigurarEventos()
767:         LOCAL loc_oErro
768: 
769:         TRY
770:             BINDEVENT(THIS.obj_4c_Optiongroup1, "InteractiveChange", THIS, "ValidarCriterioBusca")
771:             BINDEVENT(THIS.obj_4c_Optiongroup1, "Click", THIS, "ValidarCriterioBusca")
772: 
773:             BINDEVENT(THIS.txt_4c_Text1, "LostFocus", THIS, "ValidarNumeroInicial")
774:             BINDEVENT(THIS.txt_4c_Text2, "LostFocus", THIS, "ValidarNumeroFinal")
775: 
776:             *-- FASE 7/8 - os DOIS unicos botoes do SCX legado. Os Name do
777:             *-- legado MENTEM (CmdInserir/CmdExcluir num form que nao inclui
778:             *-- nem exclui nada): os handlers sao nomeados pela ACAO, que eh o
779:             *-- Caption que o usuario LE - "\<Consultar" e "Encerrar"
780:             *-- (sigopvci_form_codigo_fonte.txt:228 e 242).
781:             BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnConsultarClick")
782:             BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnEncerrarClick")
783: 
784:         CATCH TO loc_oErro
785:             THIS.this_cMensagemErro = loc_oErro.Message
786:             MsgErro(loc_oErro.Message + CHR(13) + ;
787:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
788:                 "Procedure: " + loc_oErro.Procedure, ;
789:                 "Erro ConfigurarEventos")
790:         ENDTRY
791:     ENDPROC
792: 
793:     *==========================================================================
794:     * ValidarCriterioBusca - Metodo PUBLIC unico de dependencia entre controles.
795:     * Reproduz as QUATRO procedures When dos TextBox do legado:
796:     *
797:     *     Text1.When -> Return(ThisForm.Optiongroup1.Value = 1)
798:     *     Text2.When -> Return(ThisForm.Optiongroup1.Value = 1)
799:     *     Text3.When -> Return(ThisForm.Optiongroup1.Value = 2)
800:     *     Text4.When -> Return(ThisForm.Optiongroup1.Value = 2)
801:     *
802:     * Ou seja: escolhido "Cupom" (Value = 1) so a faixa de NUMERO e' acessivel;
803:     * escolhido "Data" (Value = 2) so a faixa de DATA e'. O When do legado e'
804:     * reavaliado pelo VFP a cada tentativa de entrar no campo e, devolvendo .F.,
805:     * torna o campo INALCANCAVEL - o equivalente em runtime e' .Enabled, porque
806:     * BINDEVENT DESCARTA o retorno do delegate e um "When" ligado por BINDEVENT
807:     * nao bloquearia edicao nenhuma.
808:     *
809:     * NAO limpa o valor do campo desabilitado: o legado tambem nao limpa (o When
810:     * so barra o foco), e apagar o que o usuario digitou ao trocar de criterio
811:     * e ir e voltar perderia a faixa ja preenchida.
812:     *
813:     * PUBLIC (sem PROTECTED) porque e' alvo de BINDEVENT.
814:     *==========================================================================
815:     PROCEDURE ValidarCriterioBusca()
816:         LOCAL loc_lPorCupom, loc_lPorData
817: 
818:         loc_lPorCupom = (THIS.obj_4c_Optiongroup1.Value = 1)
819:         loc_lPorData  = (THIS.obj_4c_Optiongroup1.Value = 2)
820: 
821:         THIS.txt_4c_Text1.Enabled = loc_lPorCupom
822:         THIS.txt_4c_Text2.Enabled = loc_lPorCupom
823: 
824:         THIS.txt_4c_Text3.Enabled = loc_lPorData
825:         THIS.txt_4c_Text4.Enabled = loc_lPorData
826:     ENDPROC
827: 
828:     *==========================================================================
829:     * ValidarNumeroInicial - Porte do Text1.LostFocus do legado:
830:     *
831:     *     If Val(This.Value) <> 0
832:     *         This.Value = Transform(Val(This.Value), '@L 999999')
833:     *     Endif
834:     *
835:     * PUBLIC (alvo de BINDEVENT) e sem parametro (LostFocus nao passa nenhum).
836:     *==========================================================================
837:     PROCEDURE ValidarNumeroInicial()
838:         THIS.FormatarNumeroCupom(THIS.txt_4c_Text1)
839:     ENDPROC
840: 
841:     *==========================================================================
842:     * ValidarNumeroFinal - Porte do Text2.LostFocus do legado (identico ao do
843:     * Text1 - ver ValidarNumeroInicial).
844:     *==========================================================================
845:     PROCEDURE ValidarNumeroFinal()
846:         THIS.FormatarNumeroCupom(THIS.txt_4c_Text2)
847:     ENDPROC
848: 
849:     *==========================================================================
850:     * FormatarNumeroCupom - Fonte UNICA da normalizacao do numero de cupom,
851:     * transcrita LITERALMENTE do LostFocus do legado: zero (ou campo vazio,
852:     * cujo Val() tambem e' 0) fica como esta; qualquer outro numero e'
853:     * reescrito com '@L 999999', que preenche a esquerda com zeros ("12" vira
854:     * "000012"). O par Format/InputMask dos TextBox ja vem do SCX (InputMask =
855:     * "999999"), entao aqui nao se inventa mascara nova.
856:     *
857:     * O .Value de txt_4c_Text1/Text2 nasce CHARACTER em ConfigurarControles
858:     * (.Value = "") e BOParaForm tambem atribui string; o guard de VARTYPE
859:     * existe porque este metodo recebe o controle por parametro e VAL() sobre
860:     * valor nao-character dispara o erro 11 do VFP9.
861:     *==========================================================================
862:     PROTECTED PROCEDURE FormatarNumeroCupom(par_oTextBox)
863:         LOCAL loc_nNumero
864: 
865:         IF VARTYPE(par_oTextBox) != "O"
866:             RETURN
867:         ENDIF
868: 
869:         IF VARTYPE(par_oTextBox.Value) != "C"
870:             RETURN
871:         ENDIF
872: 
873:         loc_nNumero = VAL(par_oTextBox.Value)
874: 
875:         IF loc_nNumero != 0
876:             par_oTextBox.Value = TRANSFORM(loc_nNumero, "@L 999999")
877:         ENDIF
878:     ENDPROC
879: 
880:     *==========================================================================
881:     * CarregarConfiguracaoFiscal - Porte do trecho do Init legado que prepara a
882:     * comunicacao com a impressora fiscal (sigopvci_form_codigo_fonte.txt:
883:     * 548-588), pre-requisito do botao Consultar:
884:     *
885:     *   =fLerFiscal()                         -> popula crSigFiFis (Imps/Portas)
886:     *   lcFile = GetEnv("SystemRoot") + '\system32\BEMAFI32.INI'
887:     *   If File(lcFile) ... StrToFile(...)    -> grava a porta configurada no INI
888:     *   If crSigFiFis.Imps = 'NSWEDA' ...     -> alarga Edit1/cntAguarde
889:     *   ThisForm.cntAguarde.Visible = .F.
890:     *
891:     * fLerFiscal() e' funcao GLOBAL do Fortyus que NAO veio no acervo (regra
892:     * CLAUDE.md #13/#27): quem le SigFiFis aqui e' o BO, em
893:     * sigopvciBO.CarregarConfiguracaoFiscal().
894:     *
895:     * O patch do BEMAFI32.INI fica em TRY/CATCH PROPRIO: ele grava em
896:     * %SystemRoot%\system32, que em Windows atual exige elevacao, e uma falha
897:     * ali NAO pode impedir o form de abrir - so a porta do driver Bematech
898:     * deixa de ser sincronizada. Na estacao sem o driver o arquivo nao existe e
899:     * o bloco inteiro e' pulado, igual ao legado (o IF File() e' do legado).
900:     *==========================================================================
901:     PROTECTED PROCEDURE CarregarConfiguracaoFiscal()
902:         LOCAL loc_oErro, loc_cArquivoIni, loc_cConfig, loc_cPortaAtual
903:         LOCAL loc_cPorta, loc_cNovoConfig
904: 
905:         TRY
906:             *-- Sem conexao (ValidarUIFidelity / probe headless) nao ha SigFiFis
907:             *-- a ler: o botao Consultar reporta a configuracao ausente quando
908:             *-- for acionado, em vez de impedir a tela de abrir.
909:             IF (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
910:                TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
911:                 *-- nada a carregar neste ambiente
912:             ELSE
913:                 THIS.this_oBusinessObject.CarregarConfiguracaoFiscal()
914:             ENDIF
915: 
916:             *-- NSWEDA usa cupom de 63 colunas: o legado alarga Edit1 e
917:             *-- recentraliza os rotulos do painel "Aguarde..."
918:             IF UPPER(ALLTRIM(THIS.this_oBusinessObject.this_cImpressora)) == "NSWEDA"
919:                 THIS.edt_4c_Edit1.Width                = 450
920:                 THIS.cnt_4c_Aguarde.Width              = 320
921:                 THIS.cnt_4c_Aguarde.lbl_4c_Label1.Left = 132
922:                 THIS.cnt_4c_Aguarde.lbl_4c_Label2.Left = 97
923:             ENDIF
924: 
925:             THIS.cnt_4c_Aguarde.Visible = .F.
926: 
927:         CATCH TO loc_oErro
928:             THIS.this_cMensagemErro = loc_oErro.Message
929:             MsgErro(loc_oErro.Message + CHR(13) + ;
930:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
931:                 "Procedure: " + loc_oErro.Procedure, ;
932:                 "Erro CarregarConfiguracaoFiscal")
933:         ENDTRY
934: 
935:         *-- Sincroniza a porta configurada em SigFiFis.Portas com o INI do
936:         *-- driver Bematech. Porta 9 significa USB (comentario do legado:
937:         *-- "mena - 27/02/2015 - se porta = 9 considera USB").
938:         TRY
939:             loc_cArquivoIni = GETENV("SystemRoot") + "\system32\BEMAFI32.INI"
940: 
941:             IF FILE(loc_cArquivoIni)
942:                 loc_cConfig     = FILETOSTR(loc_cArquivoIni)
943:                 loc_cPortaAtual = STREXTRACT(loc_cConfig, "Porta", CHR(13) + CHR(10), 1, 1)
944:                 loc_cPorta      = ALLTRIM(STR(THIS.this_oBusinessObject.this_nPortas))
945:                 loc_cNovoConfig = STRTRAN(loc_cConfig, ;
946:                     "Porta" + loc_cPortaAtual, ;
947:                     IIF(loc_cPorta == "9", "Porta=USB", "Porta=COM" + loc_cPorta), ;
948:                     -1, 1, 1)
949: 
950:                 STRTOFILE(loc_cNovoConfig, loc_cArquivoIni)
951:             ENDIF
952: 
953:         CATCH TO loc_oErro
954:             MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel sincronizar a porta " + ;
955:                 "da impressora fiscal em BEMAFI32.INI." + CHR(13) + CHR(13) + ;
956:                 loc_oErro.Message + CHR(13) + ;
957:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
958:                 "Procedure: " + loc_oErro.Procedure, ;
959:                 "Configura" + CHR(231) + CHR(227) + "o da Impressora Fiscal")
960:         ENDTRY
961:     ENDPROC
962: 
963:     *==========================================================================
964:     * BtnConsultarClick - Porte do Commandgroup1.CmdInserir.Click do legado
965:     * (sigopvci_form_codigo_fonte.txt:599-920), o botao "\<Consultar": le o
966:     * cupom da MFD (Memoria de Fita-Detalhe) da impressora fiscal e exibe o
967:     * conteudo em Edit1.
968:     *
969:     * O Name legado ("CmdInserir") MENTE - este form nao inclui nada; o handler
970:     * e' nomeado pela ACAO, que e' o Caption que o usuario LE.
971:     *
972:     * Este wrapper existe por causa da GUARDA DE REENTRANCIA: a extracao leva
973:     * segundos e exibe dialogos que devolvem o foco ao botao, e o corpo tem
974:     * saidas antecipadas (RETURN apos validacao). Com set/clear no proprio
975:     * corpo, um RETURN deixaria a flag presa em .T. e MATARIA o botao pelo
976:     * resto da vida do form - por isso o corpo mora em BtnConsultarClickExec()
977:     * e quem libera a flag e' o wrapper, sempre (inclusive via CATCH).
978:     *
979:     * PUBLIC (sem PROTECTED) porque e' alvo de BINDEVENT.
980:     *==========================================================================
981:     PROCEDURE BtnConsultarClick()
982:         LOCAL loc_oErro
983: 
984:         IF THIS.this_lEmConsulta
985:             RETURN
986:         ENDIF
987: 
988:         THIS.this_lEmConsulta = .T.
989: 
990:         TRY
991:             THIS.BtnConsultarClickExec()
992: 
993:         CATCH TO loc_oErro
994:             THIS.this_cMensagemErro = loc_oErro.Message
995:             THIS.cnt_4c_Aguarde.Visible = .F.
996:             MsgErro(loc_oErro.Message + CHR(13) + ;
997:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
998:                 "Procedure: " + loc_oErro.Procedure, ;
999:                 "Erro ao consultar cupom")
1000:         ENDTRY
1001: 
1002:         THIS.this_lEmConsulta = .F.
1003:     ENDPROC
1004: 
1005:     *==========================================================================
1006:     * BtnConsultarClickExec - Corpo do Consultar, na MESMA ordem do legado:
1007:     *
1008:     *   1. lnNoFabr = LeituraFab(ThisForm.poFormulario)
1009:     *   2. ThisForm.Edit1.Value = [] / Edit1.Refresh
1010:     *   3. validacao da faixa (numero ou data) - aborta sem ler a impressora
1011:     *   4. cntAguarde visivel + ZOrder(0) + Draw + Refresh + espera de 2s
1012:     *   5. monta lcTipo/lcInic/lcFim conforme o modelo
1013:     *   6. ramo por modelo: BEMA8501 / DARUMA / NSWEDA / EPSON
1014:     *   7. cntAguarde oculto + Refresh
1015:     *
1016:     * Os DECLARE das DLLs ficaram em cada metodo ExtrairCupom*, nao aqui: no
1017:     * legado eles estao no topo do Click mas dentro de "If crSigFiFis.Imps =
1018:     * <modelo>" MUTUAMENTE EXCLUSIVOS, entao declarar junto da chamada e'
1019:     * equivalente - e evita rodar o "CLEAR DLLS" do ramo Daruma numa estacao
1020:     * Bematech.
1021:     *
1022:     * Ha UMA divergencia deliberada do legado, marcada em cada ponto: modelo
1023:     * nao atendido ou falha de extracao AVISA o usuario. O legado cai no fim do
1024:     * Click em silencio nesses casos, e o botao "nao faz nada" - exatamente o
1025:     * sintoma que a regra CLAUDE.md #27 manda tornar VISIVEL. A mensagem usada
1026:     * e' a que o PROPRIO legado tem para essa condicao nos ramos DARUMA/NSWEDA
1027:     * ("Problemas na Leitura do Cupom !!!").
1028:     *==========================================================================
1029:     PROTECTED PROCEDURE BtnConsultarClickExec()
1030:         LOCAL loc_cModelo
1031: 
1032:         *-- Numero de fabricacao do ECF. LeituraFab() e' wrapper documentado em
1033:         *-- utils\leiturafab.prg (protocolo da ECF ausente do acervo, devolve "").
1034:         THIS.this_cNumFabricacao = LeituraFab(THIS.this_oBusinessObject.this_cFormulario)
1035:         IF VARTYPE(THIS.this_cNumFabricacao) != "C"
1036:             THIS.this_cNumFabricacao = ""
1037:         ENDIF
1038: 
1039:         THIS.edt_4c_Edit1.Value = ""
1040:         THIS.edt_4c_Edit1.Refresh()
1041: 
1042:         IF !THIS.ValidarFaixaConsulta()
1043:             RETURN
1044:         ENDIF
1045: 
1046:         *-- O criterio e a faixa validados viram estado do BO (fonte unica)
1047:         THIS.FormParaBO()
1048: 
1049:         THIS.cnt_4c_Aguarde.Visible = .T.
1050:         THIS.cnt_4c_Aguarde.ZOrder(0)
1051:         THIS.cnt_4c_Aguarde.Draw()
1052:         THIS.Refresh()
1053:         THIS.AguardarPintura()
1054: 
1055:         IF THIS.ResolverFaixaMFD()
1056:             loc_cModelo = UPPER(ALLTRIM(THIS.this_oBusinessObject.this_cImpressora))
1057: 
1058:             DO CASE
1059:                 CASE loc_cModelo == "BEMA8501"
1060:                     THIS.ExtrairCupomBematech()
1061: 
1062:                 CASE loc_cModelo == "DARUMA"
1063:                     THIS.ExtrairCupomDaruma()
1064: 
1065:                 CASE loc_cModelo == "NSWEDA"
1066:                     THIS.ExtrairCupomNsweda()
1067: 
1068:                 CASE loc_cModelo == "EPSON"
1069:                     THIS.ExtrairCupomEpson()
1070: 
1071:                 OTHERWISE
1072:                     *-- DIVERGENCIA DELIBERADA (ver cabecalho): o legado nao
1073:                     *-- tem ramo para modelo desconhecido/vazio e sai calado.
1074:                     THIS.cnt_4c_Aguarde.Visible = .F.
1075:                     MsgAviso("Impressora fiscal n" + CHR(227) + "o configurada " + ;
1076:                         "ou modelo n" + CHR(227) + "o atendido: [" + loc_cModelo + "]." + ;
1077:                         CHR(13) + "Verifique o cadastro de Configura" + CHR(231) + CHR(227) + ;
1078:                         "o Fiscal antes de consultar o cupom.", "")
1079:             ENDCASE
1080:         ENDIF
1081: 
1082:         THIS.cnt_4c_Aguarde.Visible = .F.
1083:         THIS.cnt_4c_Aguarde.Refresh()
1084:     ENDPROC
1085: 
1086:     *==========================================================================
1087:     * BtnEncerrarClick - Porte do Commandgroup1.CmdExcluir.Click do legado
1088:     * (sigopvci_form_codigo_fonte.txt:924-927), cujo corpo inteiro e':
1089:     *
1090:     *     Release Windows
1091:     *
1092:     * O Name legado ("CmdExcluir") MENTE - nada e' excluido; o Caption e'
1093:     * "Encerrar" e Cancel = .T., entao o ESC tambem cai aqui, como no legado.
1094:     *
1095:     * "Release Windows" do legado derruba a janela; o equivalente no sistema
1096:     * novo e' THIS.Release(), que passa por QueryUnload/Destroy - e e' o Destroy
1097:     * que fecha o BO e reconstroi o menu principal via DODEFAULT().
1098:     *
1099:     * PUBLIC (sem PROTECTED) porque e' alvo de BINDEVENT.
1100:     *==========================================================================
1101:     PROCEDURE BtnEncerrarClick()
1102:         THIS.Release()
1103:     ENDPROC
1104: 
1105:     *==========================================================================
1106:     * ValidarFaixaConsulta - Porte LITERAL das QUATRO validacoes do inicio do
1107:     * CmdInserir.Click legado (sigopvci_form_codigo_fonte.txt:646-680):
1108:     *
1109:     *   If ThisForm.Optiongroup1.Value = 1
1110:     *       If Val(Text1.Value) > Val(Text2.Value)  -> 'Numero Final Maior Que Inicial !!!'
1111:     *       If Val(Text1.Value) = 0 Or Val(Text2.Value) = 0 -> 'Faixa Invalida !!!'
1112:     *   Else
1113:     *       If Text3.Value > Text4.Value            -> 'Data Final Maior Que Inicial !!!'
1114:     *       If Empty(Text3.Value) Or Empty(Text4.Value) -> 'Faixa Invalida !!!'
1115:     *   Endif
1116:     *
1117:     * As mensagens estao transcritas EXATAMENTE como o legado as escreve - sem
1118:     * acento em "Numero"/"Invalida", porque e' o texto que o usuario conhece
1119:     * (PILAR 1). Cada ramo repete o trio do legado: avisa, devolve o foco ao
1120:     * PRIMEIRO campo da faixa e oculta o painel "Aguarde...".
1121:     *
1122:     * A ordem importa: o teste de ORDEM vem antes do de faixa VAZIA, igual ao
1123:     * legado - com os dois campos em branco (Val = 0, nao ha ">"), quem acusa
1124:     * e' o segundo teste.
1125:     *
1126:     * PUBLIC: chamado por BtnConsultarClickExec, que e' do proprio form, mas
1127:     * tambem e' o ponto unico de validacao reusado pela Fase 8.
1128:     *==========================================================================
1129:     FUNCTION ValidarFaixaConsulta()
1130:         LOCAL loc_lValido
1131: 
1132:         loc_lValido = .T.
1133: 
1134:         IF THIS.obj_4c_Optiongroup1.Value = 1
1135:             *-- Faixa por NUMERO de cupom (Text1/Text2 guardam string)
1136:             IF VAL(THIS.txt_4c_Text1.Value) > VAL(THIS.txt_4c_Text2.Value)
1137:                 MsgAviso("Numero Final Maior Que Inicial !!!", "")
1138:                 THIS.txt_4c_Text1.SetFocus()
1139:                 THIS.cnt_4c_Aguarde.Visible = .F.
1140:                 loc_lValido = .F.
1141:             ENDIF
1142: 
1143:             IF loc_lValido AND ;
1144:                (VAL(THIS.txt_4c_Text1.Value) = 0 OR VAL(THIS.txt_4c_Text2.Value) = 0)
1145:                 MsgAviso("Faixa Invalida !!!", "")
1146:                 THIS.txt_4c_Text1.SetFocus()
1147:                 THIS.cnt_4c_Aguarde.Visible = .F.
1148:                 loc_lValido = .F.
1149:             ENDIF
1150:         ELSE
1151:             *-- Faixa por DATA (Text3/Text4 guardam DATE)
1152:             IF THIS.txt_4c_Text3.Value > THIS.txt_4c_Text4.Value
1153:                 MsgAviso("Data Final Maior Que Inicial !!!", "")
1154:                 THIS.txt_4c_Text3.SetFocus()
1155:                 THIS.cnt_4c_Aguarde.Visible = .F.
1156:                 loc_lValido = .F.
1157:             ENDIF
1158: 
1159:             IF loc_lValido AND ;
1160:                (EMPTY(THIS.txt_4c_Text3.Value) OR EMPTY(THIS.txt_4c_Text4.Value))
1161:                 MsgAviso("Faixa Invalida !!!", "")
1162:                 THIS.txt_4c_Text3.SetFocus()
1163:                 THIS.cnt_4c_Aguarde.Visible = .F.
1164:                 loc_lValido = .F.
1165:             ENDIF
1166:         ENDIF
1167: 
1168:         RETURN loc_lValido
1169:     ENDFUNC
1170: 
1171:     *==========================================================================
1172:     * AguardarPintura - Porte literal da espera do legado
1173:     * (sigopvci_form_codigo_fonte.txt:687-689):
1174:     *
1175:     *     xDAteT = Datetime()
1176:     *     DO While Datetime() - xDateT < 2
1177:     *     Enddo
1178:     *
1179:     * Da ao painel "Aguarde... Processando Dados..." tempo de aparecer antes de
1180:     * a leitura da impressora bloquear a interface. A subtracao de DATETIME em
1181:     * VFP9 devolve SEGUNDOS, por isso o "< 2" literal do legado vale aqui sem
1182:     * conversao. Mantida como laco de espera ativa, igual ao legado - trocar
1183:     * por INKEY()/WAIT mudaria o comportamento de teclado da tela.
1184:     *==========================================================================
1185:     PROTECTED PROCEDURE AguardarPintura()
1186:         LOCAL loc_tInicio
1187: 
1188:         loc_tInicio = DATETIME()
1189: 
1190:         DO WHILE DATETIME() - loc_tInicio < 2
1191:         ENDDO
1192:     ENDPROC
1193: 
1194:     *==========================================================================
1195:     * ResolverFaixaMFD - Monta lcTipo/lcInic/lcFim do legado
1196:     * (sigopvci_form_codigo_fonte.txt:691-729). Cada modelo de impressora
1197:     * fiscal espera a faixa num formato PROPRIO, e isso e' regra de negocio
1198:     * transcrita literalmente (regra CLAUDE.md #17):
1199:     *
1200:     *   Optiongroup1 = 1 (por CUPOM)  -> lcTipo = '2', faixa = Text1/Text2 cruas
1201:     *   Optiongroup1 = 2 (por DATA)   -> lcTipo = '1' e, por modelo:
1202:     *       BEMA8501        DDMMAA  (Transform(Day,'@L 99') + Month + Right(Year,2))
1203:     *       NSWEDA/DARUMA   faixa de SEQUENCIA lida das Reducoes Z em SigFiRx
1204:     *                       (BO.ResolverSequenciaPorData - o SQL mora no BO)
1205:     *       EPSON           lcTipo = '0' e Strtran(Dtoc(data), '/', '')
1206:     *
1207:     * O ramo EPSON usa DTOC() como o legado escreveu. Note que a largura do
1208:     * resultado segue o SET CENTURY vigente (ON neste projeto, por FormBase.
1209:     * Init - regra CLAUDE.md #9.4), portanto DDMMAAAA; e o proprio legado
1210:     * ainda passa esse valor por Alltrim(Str(Val(...))) na chamada da DLL, o
1211:     * que descarta zero a esquerda. Nao "corrigido" aqui de proposito:
1212:     * reescrever a expressao seria inventar formato que o legado nao usa.
1213:     *==========================================================================
1214:     FUNCTION ResolverFaixaMFD()
1215:         LOCAL loc_lResultado, loc_cModelo, loc_dInicial, loc_dFinal
1216: 
1217:         loc_lResultado = .T.
1218:         loc_cModelo    = UPPER(ALLTRIM(THIS.this_oBusinessObject.this_cImpressora))
1219: 
1220:         THIS.this_cTipoMFD   = ""
1221:         THIS.this_cInicioMFD = ""
1222:         THIS.this_cFimMFD    = ""
1223: 
1224:         IF THIS.obj_4c_Optiongroup1.Value = 1
1225:             THIS.this_cTipoMFD   = "2"
1226:             THIS.this_cInicioMFD = THIS.txt_4c_Text1.Value
1227:             THIS.this_cFimMFD    = THIS.txt_4c_Text2.Value
1228:         ELSE
1229:             *-- Default do legado antes do DO CASE: so EPSON o sobrescreve
1230:             THIS.this_cTipoMFD = "1"
1231: 
1232:             loc_dInicial = ConverterParaData(THIS.txt_4c_Text3.Value)
1233:             loc_dFinal   = ConverterParaData(THIS.txt_4c_Text4.Value)
1234: 
1235:             DO CASE
1236:                 CASE loc_cModelo == "BEMA8501"
1237:                     THIS.this_cInicioMFD = TRANSFORM(DAY(loc_dInicial), "@L 99") + ;
1238:                         TRANSFORM(MONTH(loc_dInicial), "@L 99") + ;
1239:                         RIGHT(TRANSFORM(YEAR(loc_dInicial), "@L 9999"), 2)
1240: 
1241:                     THIS.this_cFimMFD = TRANSFORM(DAY(loc_dFinal), "@L 99") + ;
1242:                         TRANSFORM(MONTH(loc_dFinal), "@L 99") + ;
1243:                         RIGHT(TRANSFORM(YEAR(loc_dFinal), "@L 9999"), 2)
1244: 
1245:                 CASE loc_cModelo == "NSWEDA" OR loc_cModelo == "DARUMA"
1246:                     IF THIS.this_oBusinessObject.ResolverSequenciaPorData(THIS.this_cNumFabricacao)
1247:                         THIS.this_cInicioMFD = THIS.this_oBusinessObject.this_cSequenciaInicial
1248:                         THIS.this_cFimMFD    = THIS.this_oBusinessObject.this_cSequenciaFinal
1249:                     ELSE
1250:                         *-- O legado nao tem caminho de falha aqui (o
1251:                         *-- poDataMgr.SqlExecute estouraria cru). Reportar a
1252:                         *-- mensagem que o BO deixou e' o que torna a falha
1253:                         *-- de consulta VISIVEL em vez de gerar faixa vazia.
1254:                         IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
1255:                             MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
1256:                                 "Erro ao resolver faixa de cupom")
1257:                         ENDIF
1258:                         loc_lResultado = .F.
1259:                     ENDIF
1260: 
1261:                 CASE loc_cModelo == "EPSON"
1262:                     THIS.this_cTipoMFD   = "0"
1263:                     THIS.this_cInicioMFD = STRTRAN(DTOC(loc_dInicial), "/", "")
1264:                     THIS.this_cFimMFD    = STRTRAN(DTOC(loc_dFinal), "/", "")

*-- Linhas 1283 a 1326:
1283:     * O legado DESCARTA o retorno das duas funcoes da DLL (iRetorno nunca e'
1284:     * testado) e decide pelo File('DOWNLOAD.TXT') - transcrito assim.
1285:     *==========================================================================
1286:     PROTECTED PROCEDURE ExtrairCupomBematech()
1287:         LOCAL loc_lDisponivel, loc_nRetorno, loc_oErro
1288: 
1289:         loc_lDisponivel = .F.
1290: 
1291:         TRY
1292:             DECLARE INTEGER Bematech_FI_DownloadMFD IN "BemaFI32.dll" ;
1293:                 STRING cFile, STRING cTipo, STRING cInicio, STRING cFinal, STRING cProp
1294: 
1295:             DECLARE INTEGER Bematech_FI_FormatoDadosMFD IN "BemaFI32.dll" ;
1296:                 STRING cFile, STRING cDest, STRING cZero, STRING cTipo, ;
1297:                 STRING cInicio, STRING cFinal, STRING cProp
1298: 
1299:             loc_lDisponivel = .T.
1300: 
1301:         CATCH TO loc_oErro
1302:             THIS.cnt_4c_Aguarde.Visible = .F.
1303:             MsgErro("Problemas na Leitura do Cupom !!!" + CHR(13) + CHR(13) + ;
1304:                 "A biblioteca BemaFI32.dll da impressora fiscal Bematech n" + ;
1305:                 CHR(227) + "o est" + CHR(225) + " dispon" + CHR(237) + "vel nesta esta" + ;
1306:                 CHR(231) + CHR(227) + "o." + CHR(13) + CHR(13) + loc_oErro.Message, ;
1307:                 "Impressora Fiscal")
1308:         ENDTRY
1309: 
1310:         IF loc_lDisponivel
1311:             IF FILE("DOWNLOAD.MFD")
1312:                 ERASE ("DOWNLOAD.MFD")
1313:             ENDIF
1314: 
1315:             IF FILE("DOWNLOAD.TXT")
1316:                 ERASE ("DOWNLOAD.TXT")
1317:             ENDIF
1318: 
1319:             loc_nRetorno = Bematech_FI_DownloadMFD("DOWNLOAD.MFD", ;
1320:                 THIS.this_cTipoMFD, THIS.this_cInicioMFD, THIS.this_cFimMFD, "1")
1321: 
1322:             loc_nRetorno = Bematech_FI_FormatoDadosMFD("DOWNLOAD.MFD", "DOWNLOAD.TXT", ;
1323:                 "0", THIS.this_cTipoMFD, THIS.this_cInicioMFD, THIS.this_cFimMFD, "1")
1324: 
1325:             IF FILE("DOWNLOAD.TXT")
1326:                 IF THIS.CarregarCupomDeArquivo("DOWNLOAD.TXT", 50)

*-- Linhas 1360 a 1436:
1360:     *     reordenada por Dtos como DDMMAAAA;
1361:     *   - a unica checagem de erro do ramo e' "lnRetorno <> 1".
1362:     *==========================================================================
1363:     PROTECTED PROCEDURE ExtrairCupomDaruma()
1364:         LOCAL loc_lDisponivel, loc_nRetorno, loc_oErro
1365:         LOCAL loc_cArquivo, loc_cTipoRel, loc_cDtIni, loc_cDtFim, loc_cIni, loc_cFim
1366: 
1367:         loc_lDisponivel = .F.
1368: 
1369:         TRY
1370:             CLEAR DLLS
1371: 
1372:             DECLARE INTEGER rGerarEspelhoMFD_ECF_Daruma IN "DarumaFramework.dll" ;
1373:                 STRING tp, STRING pnic, STRING pfim
1374: 
1375:             DECLARE INTEGER rGerarRelatorio_ECF_Daruma IN "DarumaFramework.dll" ;
1376:                 STRING szRelatorio, STRING szTipo, STRING szInicial, STRING szFinal
1377: 
1378:             loc_lDisponivel = .T.
1379: 
1380:         CATCH TO loc_oErro
1381:             THIS.cnt_4c_Aguarde.Visible = .F.
1382:             MsgErro("Problemas na Leitura do Cupom !!!" + CHR(13) + CHR(13) + ;
1383:                 "A biblioteca DarumaFramework.dll da impressora fiscal n" + CHR(227) + ;
1384:                 "o est" + CHR(225) + " dispon" + CHR(237) + "vel nesta esta" + ;
1385:                 CHR(231) + CHR(227) + "o." + CHR(13) + CHR(13) + loc_oErro.Message, ;
1386:                 "Impressora Fiscal")
1387:         ENDTRY
1388: 
1389:         IF loc_lDisponivel
1390:             loc_cArquivo = THIS.ObterDiretorioDaruma() + "espelho_mfd.TXT"
1391: 
1392:             IF FILE(loc_cArquivo)
1393:                 ERASE (loc_cArquivo)
1394:             ENDIF
1395: 
1396:             loc_cTipoRel = IIF(THIS.obj_4c_Optiongroup1.Value = 1, "COO", "DATAM")
1397: 
1398:             *-- Dtos devolve AAAAMMDD; o legado reordena para DDMMAAAA
1399:             loc_cDtIni = DTOS(ConverterParaData(THIS.txt_4c_Text3.Value))
1400:             loc_cDtIni = SUBSTR(loc_cDtIni, 7, 2) + SUBSTR(loc_cDtIni, 5, 2) + ;
1401:                 SUBSTR(loc_cDtIni, 1, 4)
1402: 
1403:             loc_cDtFim = DTOS(ConverterParaData(THIS.txt_4c_Text4.Value))
1404:             loc_cDtFim = SUBSTR(loc_cDtFim, 7, 2) + SUBSTR(loc_cDtFim, 5, 2) + ;
1405:                 SUBSTR(loc_cDtFim, 1, 4)
1406: 
1407:             loc_cIni = IIF(THIS.this_cTipoMFD == "2", THIS.this_cInicioMFD, loc_cDtIni)
1408:             loc_cFim = IIF(THIS.this_cTipoMFD == "2", THIS.this_cFimMFD, loc_cDtFim)
1409: 
1410:             *-- "mena - 24/02/2015 - ajustado parametro do espelho"
1411:             loc_nRetorno = rGerarRelatorio_ECF_Daruma("ESPELHO", loc_cTipoRel, ;
1412:                 loc_cIni, loc_cFim)
1413: 
1414:             IF loc_nRetorno != 1
1415:                 THIS.cnt_4c_Aguarde.Visible = .F.
1416:                 MsgErro("Problemas na Leitura do Cupom - Erro:" + ;
1417:                     ALLTRIM(STR(loc_nRetorno)), "")
1418:             ELSE
1419:                 IF FILE(loc_cArquivo)
1420:                     IF THIS.CarregarCupomDeArquivo(loc_cArquivo, 50)
1421:                         IF THIS.chk_4c_Check1.Value = 0
1422:                             ERASE (loc_cArquivo)
1423:                         ELSE
1424:                             MsgInfo("Arquivo " + loc_cArquivo + " Gerado !", "")
1425:                         ENDIF
1426:                     ENDIF
1427:                 ELSE
1428:                     *-- DIVERGENCIA DELIBERADA: o legado sai calado quando a DLL
1429:                     *-- devolve 1 e o espelho nao aparece no disco.
1430:                     THIS.cnt_4c_Aguarde.Visible = .F.
1431:                     MsgErro("Problemas na Leitura do Cupom !!!", "Impressora Fiscal")
1432:                 ENDIF
1433:             ENDIF
1434:         ENDIF
1435:     ENDPROC
1436: 

*-- Linhas 1447 a 1534:
1447:     * rotina fica VISIVEL ao usuario, sem cupom em branco silencioso
1448:     * (regra CLAUDE.md #27).
1449:     *==========================================================================
1450:     PROTECTED PROCEDURE ExtrairCupomNsweda()
1451:         LOCAL loc_nRetorno
1452: 
1453:         loc_nRetorno = LeMFD(THIS.this_cInicioMFD, THIS.this_cFimMFD, ;
1454:             THIS.this_oBusinessObject.this_cFormulario)
1455: 
1456:         IF !FILE("c:\Retorno.TXT")
1457:             THIS.cnt_4c_Aguarde.Visible = .F.
1458:             MsgErro("Problemas na Leitura do Cupom !!!", "")
1459:         ELSE
1460:             IF THIS.CarregarCupomDeArquivo("c:\RETORNO.TXT", 63)
1461:                 IF THIS.chk_4c_Check1.Value = 0
1462:                     ERASE ("c:\RETORNO.TXT")
1463:                 ELSE
1464:                     MsgInfo("Arquivo c:\Retorno.TXT Gerado !", "")
1465:                 ENDIF
1466:             ENDIF
1467:         ENDIF
1468:     ENDPROC
1469: 
1470:     *==========================================================================
1471:     * ExtrairCupomEpson - Ramo "If crSigFiFis.Imps = 'EPSON'" do legado
1472:     * (sigopvci_form_codigo_fonte.txt:863-917): verifica a porta, liga o log da
1473:     * InterfaceEpson.dll, pede os dados da MF/MFD para C:\SAIDA e carrega
1474:     * C:\SAIDA_ESP.TXT (63 colunas) em Edit1.
1475:     *
1476:     * Tres particularidades do legado, transcritas como estao:
1477:     *   - o teste de erro da DLL e' "lnRetorno = 1" (1 = falha nesta
1478:     *     interface), nao "<> 1" como no ramo Daruma;
1479:     *   - com Check1 MARCADO o legado so AVISA que gerou o arquivo e NAO
1480:     *     carrega o Edit1 - ao contrario dos outros tres ramos, que exibem o
1481:     *     cupom nos dois casos;
1482:     *   - o caminho de saida e' escrito [C:\\SAIDA], com DUAS barras; em VFP os
1483:     *     delimitadores [ ] nao processam escape, entao o valor passado a DLL
1484:     *     tem mesmo as duas barras. Mantido literal.
1485:     *
1486:     * VerifPorta()/RotStatus()/FecharPorta() sao funcoes GLOBAIS do Fortyus
1487:     * ausentes do acervo (wrappers documentados em utils\). verifporta.prg
1488:     * devolve .F. - "porta nao disponivel", a direcao segura -, portanto nesta
1489:     * instalacao o ramo RECUSA a leitura em vez de acionar a DLL sobre uma
1490:     * porta de estado desconhecido. A recusa e' REPORTADA com a mensagem que o
1491:     * proprio legado usa para falha de comunicacao, para o botao nao ficar
1492:     * "sem fazer nada" (regra CLAUDE.md #27).
1493:     *==========================================================================
1494:     PROTECTED PROCEDURE ExtrairCupomEpson()
1495:         LOCAL loc_lDisponivel, loc_lPortaOk, loc_nRetorno, loc_oErro
1496: 
1497:         loc_lPortaOk = VerifPorta()
1498: 
1499:         IF !loc_lPortaOk
1500:             RotStatus(.T.)
1501:             THIS.cnt_4c_Aguarde.Visible = .F.
1502:             MsgErro("Problemas na Leitura do Cupom !!!" + CHR(13) + CHR(13) + ;
1503:                 "N" + CHR(227) + "o foi poss" + CHR(237) + "vel verificar a porta de " + ;
1504:                 "comunica" + CHR(231) + CHR(227) + "o com a impressora fiscal EPSON " + ;
1505:                 "nesta esta" + CHR(231) + CHR(227) + "o.", "Impressora Fiscal")
1506:         ELSE
1507:             loc_lDisponivel = .F.
1508: 
1509:             TRY
1510:                 DECLARE INTEGER EPSON_Sys_Log IN "InterfaceEpson.dll" ;
1511:                     STRING pszPath, INTEGER dwAction
1512: 
1513:                 DECLARE INTEGER EPSON_Obter_Dados_MF_MFD IN "InterfaceEpson.dll" ;
1514:                     STRING pszInicio, STRING pszFinal, INTEGER dwTipoEntrada, ;
1515:                     INTEGER dwEspelhos, INTEGER dwAtoCotepe, INTEGER dwSintegra, ;
1516:                     STRING pszArquivoSaida
1517: 
1518:                 loc_lDisponivel = .T.
1519: 
1520:             CATCH TO loc_oErro
1521:                 THIS.cnt_4c_Aguarde.Visible = .F.
1522:                 MsgErro("Problemas na Leitura do Cupom !!!" + CHR(13) + CHR(13) + ;
1523:                     "A biblioteca InterfaceEpson.dll n" + CHR(227) + "o est" + CHR(225) + ;
1524:                     " dispon" + CHR(237) + "vel nesta esta" + CHR(231) + CHR(227) + "o." + ;
1525:                     CHR(13) + CHR(13) + loc_oErro.Message, "Impressora Fiscal")
1526:             ENDTRY
1527: 
1528:             IF loc_lDisponivel
1529:                 loc_nRetorno = EPSON_Sys_Log("C:\", 1)
1530: 
1531:                 loc_nRetorno = EPSON_Obter_Dados_MF_MFD( ;
1532:                     ALLTRIM(STR(VAL(THIS.this_cInicioMFD))), ;
1533:                     ALLTRIM(STR(VAL(THIS.this_cFimMFD))), ;
1534:                     VAL(THIS.this_cTipoMFD), 65535, 0, 0, "C:\\SAIDA")

*-- Linhas 1620 a 1725:
1620:             MsgErro("Problemas na Leitura do Cupom !!!" + CHR(13) + CHR(13) + ;
1621:                 loc_oErro.Message + CHR(13) + ;
1622:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1623:                 "Procedure: " + loc_oErro.Procedure, ;
1624:                 "Impressora Fiscal")
1625:             loc_lResultado = .F.
1626:         ENDTRY
1627: 
1628:         RETURN loc_lResultado
1629:     ENDFUNC
1630: 
1631:     *==========================================================================
1632:     * ObterDiretorioDaruma - Porte do trecho do legado que descobre onde o
1633:     * DarumaFramework grava os arquivos gerados
1634:     * (sigopvci_form_codigo_fonte.txt:630-635):
1635:     *
1636:     *     lcDir = 'C:\'
1637:     *     IF FILE('darumaframework.xml')
1638:     *         lcXml = FILETOSTR('darumaframework.xml')
1639:     *         lcDir = STREXTRACT(lcXml,[<LocalArquivos>],[</LocalArquivos>])
1640:     *     ENDIF
1641:     *
1642:     * Mantida a concatenacao direta do legado (lcDir + 'espelho_mfd.TXT'), sem
1643:     * ADDBS: o default 'C:\' ja traz a barra, e acrescentar ADDBS mudaria o
1644:     * caminho que o legado monta quando o XML traz o diretorio com barra.
1645:     *==========================================================================
1646:     FUNCTION ObterDiretorioDaruma()
1647:         LOCAL loc_cDir, loc_cXml
1648: 
1649:         loc_cDir = "C:\"
1650: 
1651:         IF FILE("darumaframework.xml")
1652:             loc_cXml = FILETOSTR("darumaframework.xml")
1653:             loc_cDir = STREXTRACT(loc_cXml, "<LocalArquivos>", "</LocalArquivos>")
1654:         ENDIF
1655: 
1656:         RETURN loc_cDir
1657:     ENDFUNC
1658: 
1659:     *==========================================================================
1660:     * TornarControlesVisiveis - Torna visiveis os controles de nivel raiz
1661:     * do form. cnt_4c_Sombra ja tem Visible=.T. definido em ConfigurarPageFrame.
1662:     *==========================================================================
1663:     PROTECTED PROCEDURE TornarControlesVisiveis()
1664:         LOCAL loc_oErro
1665: 
1666:         TRY
1667:             THIS.TornarVisivelRecursivo(THIS)
1668: 
1669:         CATCH TO loc_oErro
1670:             THIS.this_cMensagemErro = loc_oErro.Message
1671:             MsgErro(loc_oErro.Message + CHR(13) + ;
1672:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1673:                 "Procedure: " + loc_oErro.Procedure, ;
1674:                 "Erro TornarControlesVisiveis")
1675:         ENDTRY
1676:     ENDPROC
1677: 
1678:     *==========================================================================
1679:     * TornarVisivelRecursivo - Percorre container recursivamente tornando
1680:     * visiveis os controles. cnt_4c_Aguarde (fase 4+) sera adicionado a lista
1681:     * de excecao quando for criado, pois nasce Visible=.F. de proposito.
1682:     *==========================================================================
1683:     PROTECTED PROCEDURE TornarVisivelRecursivo(par_oContainer)
1684:         LOCAL loc_i, loc_oCtrl
1685:         FOR loc_i = 1 TO par_oContainer.ControlCount
1686:             loc_oCtrl = par_oContainer.Controls(loc_i)
1687:             IF VARTYPE(loc_oCtrl) = "O"
1688:                 IF INLIST(UPPER(loc_oCtrl.Name), "CNT_4C_AGUARDE")
1689:                     IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND ;
1690:                        loc_oCtrl.ControlCount > 0
1691:                         THIS.TornarVisivelRecursivo(loc_oCtrl)
1692:                     ENDIF
1693:                     LOOP
1694:                 ENDIF
1695:                 IF PEMSTATUS(loc_oCtrl, "Visible", 5)
1696:                     loc_oCtrl.Visible = .T.
1697:                 ENDIF
1698:                 IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND ;
1699:                    loc_oCtrl.ControlCount > 0
1700:                     THIS.TornarVisivelRecursivo(loc_oCtrl)
1701:                 ENDIF
1702:             ENDIF
1703:         ENDFOR
1704:     ENDPROC
1705: 
1706:     *==========================================================================
1707:     PROCEDURE Destroy()
1708:     *==========================================================================
1709:         *-- cursor_4c_Mfd e' fechado pelo proprio CarregarCupomDeArquivo no
1710:         *-- caminho normal; aqui cobre o caso em que o CATCH dele interrompeu a
1711:         *-- leitura com o cursor ainda aberto.
1712:         IF USED("cursor_4c_Mfd")
1713:             USE IN cursor_4c_Mfd
1714:         ENDIF
1715:         IF USED("cursor_4c_RelX")
1716:             USE IN cursor_4c_RelX
1717:         ENDIF
1718: 
1719:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1720:             THIS.this_oBusinessObject = .NULL.
1721:         ENDIF
1722:         DODEFAULT()
1723:     ENDPROC
1724: 
1725: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigopvciBO.prg):
*====================================================================
* sigopvciBO.prg
*
* Business Object para Formsigopvci (Visualizacao de Cupom Impresso)
* Form OPERACIONAL sem tabela principal propria: o cupom fiscal e lido
* diretamente da memoria da impressora fiscal (MFD) via DLL do
* fabricante (Bematech/Daruma/Epson) ou de arquivo de retorno
* (NSWEDA) - o resultado e apenas EXIBIDO na tela, nao persistido em
* tabela do SQL Server.
*
* O BO resolve a configuracao da impressora fiscal corrente
* (SigFiFis.Imps/Portas) e os parametros de faixa (numero de cupom ou
* data) escolhidos pelo usuario, que alimentam a extracao do cupom.
*
* Tabela: (nenhuma - form nao persiste registro proprio)
*====================================================================

DEFINE CLASS sigopvciBO AS BusinessBase

	*-- Parametro recebido no Init do form legado (PARAMETERS poFormulario)
	*-- identifica a estacao/PDV chamador e e repassado as rotinas
	*-- LeituraFab(ThisForm.poFormulario) e LeMFD(lcInic, lcFim,
	*-- ThisForm.poFormulario) que leem o numero de fabricacao do ECF e o
	*-- conteudo do cupom da impressora NSWEDA.
	this_cFormulario = ""

	*-- Configuracao da impressora fiscal corrente (SigFiFis), lida pelo
	*-- fLerFiscal() do legado. Define qual ramo de extracao (Bematech/
	*-- Daruma/NSWEDA/Epson) e usado nos botoes Consultar.
	this_cImpressora = ""      && SigFiFis.Imps  - modelo da impressora fiscal (ex.: BEMA8501, DARUMA, NSWEDA, EPSON)
	this_nPortas = 0           && SigFiFis.Portas - numero da porta serial/USB configurada
	this_cCidChaves = ""       && SigFiFis.Cidchaves - chave unica do registro de configuracao fiscal (PK)

	*-- Numero de fabricacao do ECF (serifab), devolvido por
	*-- LeituraFab(poFormulario) e usado nas consultas a SigFiRx.
	this_cNumFabricacao = ""

	*-- Criterio de busca escolhido em Optiongroup1 ("Cupom"/"Data").
	*-- ControlSource numerico do legado grava o INDICE do botao (1 ou 2),
	*-- nunca booleano - regra #188.
	this_nTipoBusca = 1        && Optiongroup1.Value (1=Cupom por faixa de numero, 2=Cupom por faixa de Data)

	*-- Faixa de numero de cupom (Text1/Text2), usada quando this_nTipoBusca = 1
	this_nNumeroInicial = 0    && Text1.Value
	this_nNumeroFinal = 0      && Text2.Value

	*-- Faixa de data (Text3/Text4), usada quando this_nTipoBusca = 2
	this_dDataInicial = {}     && Text3.Value
	this_dDataFinal = {}       && Text4.Value

	*-- Check1.Value - gera tambem o arquivo com os cupons extraidos no
	*-- diretorio do sistema, alem de exibir na tela
	this_lGeraArquivo = .F.

	*-- Edit1.Value - conteudo do cupom extraido da impressora fiscal,
	*-- exibido em tela (somente leitura)
	this_cConteudoCupom = ""

	*-- Faixa de SEQUENCIA de cupom resolvida a partir da faixa de DATA,
	*-- para os modelos NSWEDA/DARUMA (ver ResolverSequenciaPorData).
	*-- O legado guarda isso nas PRIVATE lcInic/lcFim do CmdInserir.Click.
	this_cSequenciaInicial = ""
	this_cSequenciaFinal = ""

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()

		*-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
		*-- Nao ha tabela principal: o cupom e lido da impressora fiscal
		*-- (MFD) e apenas exibido, sem persistencia propria em banco
		THIS.this_cTabela = ""
		THIS.this_cCampoChave = ""

		RETURN .T.
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia para as properties this_* a configuracao
	* da impressora fiscal corrente lida de SigFiFis (regra CLAUDE.md #9:
	* SELECT (alias) antes de acessar campo, nunca <cursor>.<campo> direto
	* com alias em variavel).
	*
	* O cupom em si (this_cConteudoCupom) NAO passa por aqui: ele vem do
	* retorno da DLL da impressora fiscal (Bematech/Daruma/NSWEDA/Epson),
	* fora do SQL Server - escopo das fases de integracao com hardware
	* (6-8/8), nao de carga de cursor.
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lResultado

		loc_lResultado = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)

			THIS.this_cCidChaves  = TratarNulo(cidchaves, "")
			THIS.this_cImpressora = TratarNulo(imps, "")
			THIS.this_nPortas     = TratarNulo(portas, 0)

			loc_lResultado = .T.
		ENDIF

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* CarregarConfiguracaoFiscal - Equivalente a fLerFiscal() do legado
	* (sigopvci_form_codigo_fonte.txt:548 - "=fLerFiscal()", chamada no
	* Init do form antes de ler crSigFiFis.Imps/Portas).
	*
	* fLerFiscal() e funcao GLOBAL do Fortyus (sig.prg/SIGFUNCS.PRG) que
	* NAO veio no acervo e NAO foi portada (regra CLAUDE.md #13/#27 -
	* nunca chamar helper que nao foi definido; a chamada direta so
	* estouraria em RUNTIME com "File 'flerfiscal.prg' does not exist").
	*
	* SigFiFis e tabela do SQL Server (docs/schema.sql: dtrs bit, hands
	* char(20), portas numeric(1,0), rtss bit, settings char(20), imps
	* char(20), cidchaves char(20) PK) e NAO tem coluna de empresa - e
	* configuracao global da impressora fiscal da instalacao (mesmo
	* parametro que FisBO/FormFis permite editar), nao por empresa/caixa.
	* Sem outro criterio de selecao disponivel no dump legado, le o
	* PRIMEIRO registro cadastrado (SELECT TOP 1 ... ORDER BY cidchaves).
	*====================================================================
	FUNCTION CarregarConfiguracaoFiscal()
		LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_oErro

		loc_lResultado = .F.

		TRY
			IF USED("cursor_4c_SigFiFis")
				USE IN cursor_4c_SigFiFis
			ENDIF

			loc_cSQL = "SELECT TOP 1 cidchaves, imps, portas " + ;
				"FROM SigFiFis ORDER BY cidchaves"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigFiFis")

			IF loc_nResultado > 0 AND USED("cursor_4c_SigFiFis") AND RECCOUNT("cursor_4c_SigFiFis") > 0
				loc_lResultado = THIS.CarregarDoCursor("cursor_4c_SigFiFis")
			ELSE
				THIS.this_cMensagemErro = "Configura" + CHR(231) + CHR(227) + "o de impressora fiscal n" + CHR(227) + "o encontrada em SigFiFis."
			ENDIF

			IF USED("cursor_4c_SigFiFis")
				USE IN cursor_4c_SigFiFis
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, ;
				"Erro ao carregar configura" + CHR(231) + CHR(227) + "o fiscal")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDFUNC

	*====================================================================
	* ResolverSequenciaPorData - Converte a faixa de DATA escolhida pelo
	* usuario na faixa de SEQUENCIA de cupom que a MFD das impressoras
	* NSWEDA/DARUMA espera, consultando as Reducoes Z gravadas em SigFiRx.
	*
	* Transcricao do ramo "Case crSigFiFis.Imps = 'NSWEDA' Or
	* crSigFiFis.Imps = 'DARUMA'" do CmdInserir.Click legado
	* (sigopvci_form_codigo_fonte.txt:703-720):
	*
	*   ldDtIni  = ThisForm.Text3.Value
	*   lcQryIni = [Select Top 1 dtredzs, SeqFinal2 from SigFiRx Where
	*              serifab = '] + lnNoFabr + [' And dtredzs < ?ldDtIni
	*              Order by DtRedzs Desc]
	*   Select csTmpRelX
	*   If Eof()
	*       lcInic = '000001'
	*   Else
	*       lcInic = Transform(Val(SeqFinal2)+1,'@L 999999')
	*   Endif
	*   ldDtIni  = ThisForm.Text4.Value
	*   lcQryIni = [Select Top 1 dtredzs, SeqFinal2 from SigFiRx Where
	*              serifab = '] + lnNoFabr + [' And dtredzs >= ?ldDtIni]
	*   Select csTmpRelX
	*   If Eof()
	*       lcFim = '999999'
	*   Else
	*       lcFim = Transform(Val(SeqFinal2),'@L 999999')
	*   EndIf
	*
	* A LOGICA e os LITERAIS ('000001' no inicio, '999999' no fim, o +1 no
	* SeqFinal2 da reducao ANTERIOR) sao regra de negocio e estao
	* transcritos literalmente - regra CLAUDE.md #17. A SEGUNDA consulta
	* NAO tem ORDER BY no legado e tambem nao recebe um aqui: acrescentar
	* mudaria o registro escolhido.
	*
	* Colunas conferidas no schema canonico (docs/schema.sql, UTF-16 - regra
	* CLAUDE.md #14): SigFiRx.serifab char(20), SigFiRx.dtredzs datetime
	* NULL, SigFiRx.seqfinal2 char(6).
	*====================================================================
	FUNCTION ResolverSequenciaPorData(par_cNumFabricacao)
		LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_cFab, loc_oErro

		loc_lResultado = .F.
		THIS.this_cSequenciaInicial = ""
		THIS.this_cSequenciaFinal   = ""

		loc_cFab = IIF(VARTYPE(par_cNumFabricacao) = "C", ALLTRIM(par_cNumFabricacao), "")

		TRY
			*-- Inicio da faixa: SeqFinal2 da ULTIMA Reducao Z ANTERIOR a data
			*-- inicial, somada de 1; sem reducao anterior, o primeiro cupom.
			IF USED("cursor_4c_RelX")
				IF CURSORGETPROP("Buffering", "cursor_4c_RelX") > 1
					TABLEREVERT(.T., "cursor_4c_RelX")
				ENDIF
				USE IN cursor_4c_RelX
			ENDIF

			loc_cSQL = "SELECT TOP 1 dtredzs, seqfinal2 FROM SigFiRx" + ;
				" WHERE serifab = " + EscaparSQL(loc_cFab) + ;
				" AND dtredzs < " + FormatarDataSQL(THIS.this_dDataInicial) + ;
				" ORDER BY dtredzs DESC"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RelX")

			IF loc_nResultado < 0
				THIS.this_cMensagemErro = "Erro ao consultar Redu" + CHR(231) + CHR(245) + ;
					"es Z (SigFiRx)." + CHR(13) + CapturarErroSQL()
			ELSE
				IF USED("cursor_4c_RelX") AND RECCOUNT("cursor_4c_RelX") > 0
					SELECT cursor_4c_RelX
					GO TOP
					THIS.this_cSequenciaInicial = TRANSFORM(VAL(TratarNulo(seqfinal2, "")) + 1, "@L 999999")
				ELSE
					THIS.this_cSequenciaInicial = "000001"
				ENDIF

				IF USED("cursor_4c_RelX")
					USE IN cursor_4c_RelX
				ENDIF

				*-- Fim da faixa: SeqFinal2 da PRIMEIRA Reducao Z em ou apos a
				*-- data final; sem reducao posterior, o ultimo cupom possivel.
				loc_cSQL = "SELECT TOP 1 dtredzs, seqfinal2 FROM SigFiRx" + ;
					" WHERE serifab = " + EscaparSQL(loc_cFab) + ;
					" AND dtredzs >= " + FormatarDataSQL(THIS.this_dDataFinal)

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RelX")

				IF loc_nResultado < 0
					THIS.this_cMensagemErro = "Erro ao consultar Redu" + CHR(231) + CHR(245) + ;
						"es Z (SigFiRx)." + CHR(13) + CapturarErroSQL()
				ELSE
					IF USED("cursor_4c_RelX") AND RECCOUNT("cursor_4c_RelX") > 0
						SELECT cursor_4c_RelX
						GO TOP
						THIS.this_cSequenciaFinal = TRANSFORM(VAL(TratarNulo(seqfinal2, "")), "@L 999999")
					ELSE
						THIS.this_cSequenciaFinal = "999999"
					ENDIF

					loc_lResultado = .T.
				ENDIF
			ENDIF

			IF USED("cursor_4c_RelX")
				USE IN cursor_4c_RelX
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, ;
				"Erro ao resolver faixa de cupom")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDFUNC

	*====================================================================
	* ObterChavePrimaria - Este BO nao persiste registro proprio (o cupom
	* e lido da impressora fiscal, fora do SQL Server - ver cabecalho
	* deste arquivo). A chave mais proxima de "registro em edicao" e a
	* PK da configuracao de impressora fiscal corrente (SigFiFis.
	* Cidchaves), usada so por completude de contrato - RegistrarAuditoria
	* nunca e chamado, porque Inserir/Atualizar nao sao sobrescritos.
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCidChaves)
	ENDPROC

	*====================================================================
	* Inserir() / Atualizar() / ExecutarExclusao() - este formulario nao
	* grava registro proprio no banco (o cupom e extraido da memoria da
	* impressora fiscal via DLL do fabricante e apenas exibido em tela -
	* ver cabecalho deste arquivo); o comportamento padrao herdado de
	* BusinessBase ja eh o correto para este BO, entao esses tres metodos
	* nao sao sobrescritos aqui.
	*====================================================================

ENDDEFINE

