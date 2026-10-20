# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [INIT-DUPLICADO] Init() chama DODEFAULT() E THIS.InicializarForm(). FormBase.Init() ja chama InicializarForm() internamente. Isso causa 'A member object with this name already exists' porque ConfigurarPageFrame/AddObject executa 2 vezes. CORRIGIR: Remover THIS.InicializarForm() do Init() - DODEFAULT() ja faz isso.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpC44.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (993 linhas total):

*-- Linhas 2 a 241:
2: * FormSigOpC44.prg - Geracao do arquivo da CAT 44/2008 (Substituicao
3: * Tributaria de Estoque), layout posicional de texto com 3 tipos de registro.
4: * Form OPERACIONAL FLAT (sem PageFrame) - dialogo modal de entrada unica.
5: * Chamada: CREATEOBJECT("FormSigOpC44")
6: * Herda de: FormBase
7: *
8: * Legado (SigOpC44.SCX): BaseClass = form (generico), DataSession=1,
9: * BorderStyle=2, AutoCenter=.T., Caption="Geracao do Arquivo da CAT 44/2008",
10: * ControlBox=.F., TitleBar=0, WindowType=1 (modal), Width=503, Height=247 -
11: * popup pequeno, sem PageFrame, sem Grid. Controles (txtdest, getDtEst,
12: * getFinal, getNumParc, CmdGera, CmdSair, ShpSair, Shape2) sao todos filhos
13: * DIRETOS do form - mesma familia FLAT do SIGOPBIN/FormSIGOPBIN.
14: *
15: * Historico de fases:
16: *   Fase 1/2: SigOpC44BO.prg (propriedades + CarregarParametros +
17: *             InicializarCursoresLocais + GerarRegistro1/2/3)
18: *   Fase 3:   FormSigOpC44.prg - estrutura base (Init, InicializarForm,
19: *             ConfigurarPageFrame com cnt_4c_Sombra/lbl_4c_LblSombra/
20: *             lbl_4c_LblTitulo). Form FLAT: o legado nao tem PageFrame nem
21: *             Page nenhuma - nenhum pgf_4c_* eh criado neste form.
22: *   Fase 4:   FormSigOpC44.prg - ConfigurarBotoesAcao() com os DOIS shapes
23: *             decorativos do legado (shp_4c_Shape2/shp_4c_ShpSair) e os
24: *             DOIS CommandButtons de acao (cmd_4c_CmdGera/cmd_4c_CmdSair).
25: *             O legado NAO tem Grid nem lista (layout CAPTURA - dialogo que
26: *             so coleta os parametros de geracao do arquivo): nao ha
27: *             grd_4c_* nem botoes CRUD para criar aqui - os dois botoes
28: *             deste form SAO os botoes de acao (Gerar/Sair). Apenas
29: *             AddObject + propriedades visuais (Click fica para a Fase 7).
30: *             Campos de dados (txtdest/getDtEst/getFinal/getNumParc) e seus
31: *             Labels ficam para a Fase 5.
32: *   Fase 5:   FormSigOpC44.prg - ConfigurarCamposDados() com a 1a metade dos
33: *             campos: txt_4c_Txtdest (+ lbl_4c_Label2) e txt_4c_DtEst (+
34: *             lbl_4c_Label3). 2a metade (getFinal/getNumParc) na Fase 6.
35: *   Fase 6:   FormSigOpC44.prg - ConfigurarCamposDados2() com a 2a metade dos
36: *             campos: cbo_4c_GetFinal (+ lbl_4c_Label1) e txt_4c_NumParc
37: *             (+ lbl_4c_Label4); mais a camada de comportamento dos QUATRO
38: *             campos: AplicarValoresPadrao() (defaults "C:\"/Date()/1 do Init
39: *             legado), FormParaBO()/BOParaForm() (espelho tela<->BO),
40: *             ValidarParametros() (os TRES guards que o legado escreveu no
41: *             inicio do CmdGera.Click) e os BINDEVENT de KeyPress dos dois
42: *             TextBox digitaveis + InteractiveChange da combo.
43: *             SEM LOOKUP: o legado (SIGOPC44) nao tem UMA chamada de busca -
44: *             grep de fwbusca/mAddColuna/sigacess/Acesso*() no dump devolve
45: *             zero, e a unica CreateObject eh fSqlConector (conexao de dados,
46: *             nao picker de UI). Inventar lookup aqui violaria o PILAR 1 e a
47: *             regra "NUNCA inventar tabelas de lookup que nao existem no
48: *             original". Tambem nao ha Valid/When/LostFocus em campo algum do
49: *             SCX: a regra dos campos mora no Click do botao, e por governar
50: *             os campos DESTA fase ela nasce aqui - o Click (Fase 7) so
51: *             chama. Os Click em si (confirmacao + GerarRegistro1/2/3 do BO +
52: *             FCREATE/FWRITE do arquivo CAT44) ficam para a Fase 7.
53: *   Fase 7:   FormSigOpC44.prg - CmdGeraClick()/CmdSairClick() (os UNICOS
54: *             eventos principais deste dialogo - NAO ha Incluir/Alterar/
55: *             Visualizar/Excluir: o legado nao tem Grid nem lista, layout
56: *             CAPTURA de parametro unico, e os dois CommandButton do form SAO
57: *             os botoes de acao). CmdGeraClick transcreve SIGOPC44.CmdGera.
58: *             Click: ValidarParametros() (Fase 6) -> confirmacao (MsgConfirma)
59: *             -> Set Point To "," (decimal com virgula no arquivo-texto,
60: *             restaurado no fim) -> GerarRegistro1/2/3 do BO -> grava o
61: *             arquivo posicional (FCREATE/FWRITE linha a linha via
62: *             MontarLinhaRegistro() + FCLOSE) -> FileToStr/StrToFile(...,4)
63: *             (ida-e-volta do legado, mantida literal) -> MsgInfo com o
64: *             caminho gerado -> foco no Sair. CmdSairClick transcreve
65: *             SIGOPC44.CmdSair.Click (THIS.Release(), nada mais). BINDEVENT
66: *             em "Click" dos dois cmd_4c_* (criados na Fase 4) - os handlers
67: *             sao PUBLIC (regra #3: BINDEVENT exige metodo nao-PROTECTED).
68: *   Fase 8:   FormSigOpC44.prg - consolidacao final. Este form NAO eh CRUD
69: *             (sem Grid/Page1-Lista/Page2-Dados): o template generico de
70: *             Fase 8 (BtnBuscarClick/BtnEncerrarClick/BtnSalvarClick/
71: *             BtnCancelarClick/HabilitarCampos/LimparCampos/CarregarLista/
72: *             AjustarBotoesPorModo) NAO se aplica a um dialogo FLAT de
73: *             parametro unico - CmdGeraClick/CmdSairClick (Fase 7) JA SAO os
74: *             unicos eventos principais, e FormParaBO/BOParaForm (Fase 6) JA
75: *             cobrem os 4 campos. O que faltava para o form ficar FUNCIONAL:
76: *             (a) InicializarForm() nunca chamava
77: *             SigOpC44BO.CarregarParametros() - os 4 campos apareciam com os
78: *             defaults do legado (Date()/1/"C:\"), mas CNPJ/IE/Razao
79: *             Social/Regime Tributario da empresa (usados por
80: *             GerarRegistro1/GerarRegistro2) ficavam SEMPRE vazios, porque
81: *             nenhum metodo lia SigCdEmp. Chamada adicionada ANTES de
82: *             ConfigurarCamposDados2() (que depende de this_cDestino via
83: *             AplicarValoresPadrao), guardada por gb_4c_ValidandoUI (mesmo
84: *             padrao de FormFAPF/FormSIGMDETQ) para o ValidarUIFidelity
85: *             instanciar sem gnConnHandle; (b) menu.prg nao tinha entrada
86: *             nenhuma para este form - adicionada em popMovimentos (BAR 153)
87: *             + PROCEDURE AbrirFormSigOpC44() no padrao canonico (VARTYPE,
88: *             Show() FORA do TRY - regra #29).
89: *==============================================================================
90: DEFINE CLASS FormSigOpC44 AS FormBase
91: 
92:     *-- Propriedades visuais (PILAR 1 - valores exatos do SCX SigOpC44)
93:     Width       = 503
94:     Height      = 247
95:     DataSession = 1
96:     ShowWindow = 1
97:     BorderStyle = 2
98:     AutoCenter  = .T.
99:     Caption     = "Gera" + CHR(231) + CHR(227) + "o do Arquivo da CAT 44/2008"
100:     ControlBox  = .F.
101:     TitleBar    = 0
102:     WindowType  = 1
103: 
104:     *--------------------------------------------------------------------------
105:     * Init - Cria o Business Object antes de inicializar a parte visual
106:     * (DODEFAULT -> FormBase.Init -> THIS.InicializarForm).
107:     *--------------------------------------------------------------------------
108:     PROCEDURE Init()
109:         LOCAL loc_lSucesso, loc_oErro
110:         loc_lSucesso = .F.
111: 
112:         TRY
113:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpC44BO")
114:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
115:                 MsgErro("Erro ao criar SigOpC44BO." + CHR(13) + ;
116:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
117:                     "FormSigOpC44.Init")
118:             ELSE
119:                 *-- DODEFAULT() dispara FormBase.Init() que chama THIS.InicializarForm()
120:                 loc_lSucesso = DODEFAULT()
121:             ENDIF
122:         CATCH TO loc_oErro
123:             MsgErro(loc_oErro.Message + CHR(13) + ;
124:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
125:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpC44.Init")
126:         ENDTRY
127: 
128:         RETURN loc_lSucesso
129:     ENDPROC
130: 
131:     *--------------------------------------------------------------------------
132:     * InicializarForm - Monta a estrutura visual base
133:     * (chamado por FormBase.Init via DODEFAULT)
134:     *--------------------------------------------------------------------------
135:     PROTECTED PROCEDURE InicializarForm()
136:         LOCAL loc_lSucesso, loc_oErro
137:         loc_lSucesso = .F.
138: 
139:         TRY
140:             *-- Fundo do form (imagem do Framework Fortyus legado)
141:             THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
142: 
143:             *-- CarregarParametros (equivalente ao SIGOPC44.Init legado: Seek
144:             *-- crSigCdEmp + CursorQuery SigCdPac) - cria os cursores locais de
145:             *-- saida (Load legado) e le CNPJ/IE/Razao Social/Regime Tributario
146:             *-- da empresa + o diretorio padrao de destino. Pulado em modo
147:             *-- gb_4c_ValidandoUI (sem conexao SQL - mesmo padrao de FormFAPF/
148:             *-- FormSIGMDETQ) para o ValidarUIFidelity conseguir instanciar o
149:             *-- form sem gnConnHandle.
150:             IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
151:                 IF !THIS.this_oBusinessObject.CarregarParametros()
152:                     MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "FormSigOpC44")
153:                 ENDIF
154:             ELSE
155:                 THIS.this_oBusinessObject.InicializarCursoresLocais()
156:             ENDIF
157: 
158:             *-- Monta o cabecalho (unico elemento estrutural deste form FLAT)
159:             THIS.ConfigurarPageFrame()
160: 
161:             *-- Shapes decorativos + botoes de acao (Gerar Arquivo / Sair)
162:             THIS.ConfigurarBotoesAcao()
163: 
164:             *-- Campos de dados (metade 1/2: destino do arquivo + data do estoque)
165:             THIS.ConfigurarCamposDados()
166: 
167:             *-- Campos de dados (metade 2/2: finalidade do arquivo + parcelas ICMS)
168:             *-- AplicarValoresPadrao (chamado dentro deste metodo) le
169:             *-- this_oBusinessObject.this_cDestino, por isso CarregarParametros
170:             *-- tem de rodar ANTES.
171:             THIS.ConfigurarCamposDados2()
172: 
173:             *-- Torna a arvore de controles visivel (AddObject cria com Visible=.F.)
174:             THIS.TornarControlesVisiveis(THIS)
175: 
176:             loc_lSucesso = .T.
177:         CATCH TO loc_oErro
178:             MsgErro(loc_oErro.Message + CHR(13) + ;
179:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
180:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpC44.InicializarForm")
181:         ENDTRY
182: 
183:         RETURN loc_lSucesso
184:     ENDPROC
185: 
186:     *--------------------------------------------------------------------------
187:     * ConfigurarPageFrame - Cria o cabecalho (cnt_4c_Sombra + labels).
188:     *   Form OPERACIONAL FLAT: o legado (SigOpC44.SCX) nao tem PageFrame nem
189:     *   Page nenhuma - todos os controles sao filhos diretos do form. Nome do
190:     *   metodo mantido por convencao do orquestrador de migracao, mas este
191:     *   form NAO cria nenhum PageFrame: nao existe aqui (nem em metodo algum
192:     *   deste arquivo) um AddObject de objeto com o prefixo de PageFrame.
193:     *   Demais controles do legado (txtdest, getDtEst, getFinal, getNumParc,
194:     *   CmdGera, CmdSair, ShpSair, Shape2) entram em fases posteriores.
195:     *
196:     *   Mapeamento (tasks\task650\mapeamento.json):
197:     *     SIGOPC44.cntSombra       -> cnt_4c_Sombra
198:     *     SIGOPC44.cntSombra.lblSombra -> lbl_4c_LblSombra
199:     *     SIGOPC44.cntSombra.lblTitulo -> lbl_4c_LblTitulo
200:     *--------------------------------------------------------------------------
201:     PROTECTED PROCEDURE ConfigurarPageFrame()
202:         LOCAL loc_oCab, loc_oErro
203:         TRY
204:             *-- cntSombra original: Top=0, Left=0, Width=800 (-> THIS.Width), Height=80
205:             THIS.AddObject("cnt_4c_Sombra", "Container")
206:             loc_oCab = THIS.cnt_4c_Sombra
207:             WITH loc_oCab
208:                 .Top         = 0
209:                 .Left        = 0
210:                 .Width       = THIS.Width
211:                 .Height      = 80
212:                 .BorderWidth = 0
213:                 .BackStyle   = 1
214:                 .BackColor   = RGB(100, 100, 100)
215:             ENDWITH
216: 
217:             *-- Labels adicionados FORA do WITH do container (WITH aninhado com
218:             *-- AddObject ignora propriedades silenciosamente - regra conhecida)
219:             loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
220:             WITH loc_oCab.lbl_4c_LblSombra
221:                 .FontBold      = .T.
222:                 .FontName      = "Tahoma"
223:                 .FontSize      = 18
224:                 .FontUnderline = .F.
225:                 .WordWrap      = .T.
226:                 .AutoSize      = .F.
227:                 .Alignment     = 0
228:                 .BackStyle     = 0
229:                 .Caption       = THIS.Caption
230:                 .Height        = 40
231:                 .Left          = 10
232:                 .Top           = 18
233:                 .Width         = 769
234:                 .ForeColor     = RGB(0, 0, 0)
235:             ENDWITH
236: 
237:             loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
238:             WITH loc_oCab.lbl_4c_LblTitulo
239:                 .FontBold    = .T.
240:                 .FontName    = "Tahoma"
241:                 .FontSize    = 18

*-- Linhas 254 a 315:
254:         CATCH TO loc_oErro
255:             MsgErro(loc_oErro.Message + CHR(13) + ;
256:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
257:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpC44.ConfigurarPageFrame")
258:         ENDTRY
259:     ENDPROC
260: 
261:     *--------------------------------------------------------------------------
262:     * ConfigurarBotoesAcao - Shapes decorativos + botoes de acao do legado
263:     *   (filhos DIRETOS do form, igual ao SCX - SIGOPC44 nao tem PageFrame).
264:     *   Layout CAPTURA: o legado nao tem Grid/lista, entao este form nao tem
265:     *   botoes CRUD (Incluir/Alterar/Excluir/...) - CmdGera/CmdSair SAO os
266:     *   botoes de acao da tela. Somente estrutura + visual aqui; os Click
267:     *   (GerarRegistro1/2/3 do BO + fechamento do form) entram na Fase 7.
268:     *
269:     *   Mapeamento (tasks\task650\mapeamento.json):
270:     *     SIGOPC44.ShpSair -> shp_4c_ShpSair
271:     *     SIGOPC44.Shape2  -> shp_4c_Shape2
272:     *     SIGOPC44.CmdGera -> cmd_4c_CmdGera
273:     *     SIGOPC44.CmdSair -> cmd_4c_CmdSair
274:     *--------------------------------------------------------------------------
275:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
276:         LOCAL loc_oErro
277:         TRY
278:             *-- Shape2 original: Top=82, Left=3, Width=265, Height=161 -
279:             *-- moldura decorativa em torno do bloco "destino do arquivo"
280:             THIS.AddObject("shp_4c_Shape2", "Shape")
281:             WITH THIS.shp_4c_Shape2
282:                 .Top           = 82
283:                 .Left          = 3
284:                 .Width         = 265
285:                 .Height        = 161
286:                 .SpecialEffect = 0
287:             ENDWITH
288: 
289:             *-- ShpSair original: Top=204, Left=288, Width=144, Height=56 -
290:             *-- moldura decorativa (transparente) em torno dos botoes
291:             THIS.AddObject("shp_4c_ShpSair", "Shape")
292:             WITH THIS.shp_4c_ShpSair
293:                 .Top           = 204
294:                 .Left          = 288
295:                 .Width         = 144
296:                 .Height        = 56
297:                 .BackStyle     = 0
298:                 .BorderStyle   = 0
299:                 .BorderWidth   = 0
300:                 .SpecialEffect = 0
301:             ENDWITH
302: 
303:             *-- CmdGera original: Top=3, Left=352, Width=75, Height=75
304:             THIS.AddObject("cmd_4c_CmdGera", "CommandButton")
305:             WITH THIS.cmd_4c_CmdGera
306:                 .Top        = 3
307:                 .Left       = 352
308:                 .Width      = 75
309:                 .Height     = 75
310:                 .FontBold   = .T.
311:                 .FontItalic = .T.
312:                 .FontName   = "Comic Sans MS"
313:                 .FontSize   = 8
314:                 .Picture    = gc_4c_CaminhoIcones + "geral_processar_32.jpg"
315:                 .Caption    = "\<Gera Arquivo"

*-- Linhas 339 a 408:
339:             ENDWITH
340: 
341:             *-- Eventos dos botoes de acao (Fase 7). PUBLIC (nao PROTECTED) -
342:             *-- BINDEVENT exige metodo nao-PROTECTED (regra #3).
343:             BINDEVENT(THIS.cmd_4c_CmdGera, "Click", THIS, "CmdGeraClick")
344:             BINDEVENT(THIS.cmd_4c_CmdSair, "Click", THIS, "CmdSairClick")
345:         CATCH TO loc_oErro
346:             MsgErro(loc_oErro.Message + CHR(13) + ;
347:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
348:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpC44.ConfigurarBotoesAcao")
349:         ENDTRY
350:     ENDPROC
351: 
352:     *--------------------------------------------------------------------------
353:     * ConfigurarCamposDados - Campos de dados do dialogo (filhos DIRETOS do
354:     *   form, igual ao SCX - SIGOPC44 nao tem PageFrame nem Page).
355:     *   FASE 5/8 (1a metade): destino do arquivo (txtdest) e data do estoque
356:     *   (getDtEst), com seus labels. A 2a metade (getFinal/getNumParc) entra
357:     *   na Fase 6. Os valores padrao (TxtDest = caminho de SigCdPac.DirCat44,
358:     *   GetDtEst = Date()) vem do Init legado e serao aplicados via BO em
359:     *   fase posterior - aqui soh a estrutura visual (PILAR 3: estrutura
360:     *   primeiro, dado depois).
361:     *
362:     *   Mapeamento (tasks\task650\mapeamento.json):
363:     *     SIGOPC44.txtdest -> txt_4c_Txtdest
364:     *     SIGOPC44.Label2  -> lbl_4c_Label2
365:     *     SIGOPC44.getDtEst -> txt_4c_DtEst
366:     *     SIGOPC44.Label3   -> lbl_4c_Label3
367:     *--------------------------------------------------------------------------
368:     PROTECTED PROCEDURE ConfigurarCamposDados()
369:         LOCAL loc_oErro
370:         TRY
371:             *-- Label2 original: Top=119, Left=12, Width=173, Height=17
372:             THIS.AddObject("lbl_4c_Label2", "Label")
373:             WITH THIS.lbl_4c_Label2
374:                 .FontBold   = .T.
375:                 .FontItalic = .F.
376:                 .FontName   = "Tahoma"
377:                 .BackStyle  = 0
378:                 .Caption    = "O arquivo ser" + CHR(225) + " gerado em :"
379:                 .Height     = 17
380:                 .Left       = 12
381:                 .Top        = 119
382:                 .Width      = 173
383:                 .ForeColor  = RGB(90, 90, 90)
384:             ENDWITH
385: 
386:             *-- txtdest original: Top=134, Left=8, Width=253, Height=23 -
387:             *-- ReadOnly/TabStop=.F. no legado (so exibe o caminho, nao edita)
388:             THIS.AddObject("txt_4c_Txtdest", "TextBox")
389:             WITH THIS.txt_4c_Txtdest
390:                 .Top               = 134
391:                 .Left              = 8
392:                 .Width             = 253
393:                 .Height            = 23
394:                 .FontName          = "Tahoma"
395:                 .ReadOnly          = .T.
396:                 .TabStop           = .F.
397:                 .TabIndex          = 4
398:                 .Value             = ""
399:                 .DisabledBackColor = RGB(255, 255, 255)
400:                 .DisabledForeColor = RGB(128, 128, 128)
401:             ENDWITH
402: 
403:             *-- Label3 original: AutoSize=.T. (no-op em AddObject - regra #23),
404:             *-- Width=113/Height=16 ja sao os valores calculados pelo Form
405:             *-- Designer - transcrever explicito com AutoSize=.F.
406:             THIS.AddObject("lbl_4c_Label3", "Label")
407:             WITH THIS.lbl_4c_Label3
408:                 .AutoSize   = .F.

*-- Linhas 445 a 506:
445:         CATCH TO loc_oErro
446:             MsgErro(loc_oErro.Message + CHR(13) + ;
447:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
448:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpC44.ConfigurarCamposDados")
449:         ENDTRY
450:     ENDPROC
451: 
452:     *--------------------------------------------------------------------------
453:     * ConfigurarCamposDados2 - Campos de dados do dialogo (filhos DIRETOS do
454:     *   form, igual ao SCX - SIGOPC44 nao tem PageFrame nem Page).
455:     *   FASE 6/8 (2a metade): finalidade do arquivo (getFinal - combobox com
456:     *   as 2 opcoes literais do legado) e numero de parcelas para pagamento
457:     *   do ICMS (getNumParc), com seus labels. Sem lookups: o legado nao tem
458:     *   nenhuma chamada fwbuscaext/fwBuscaSel/sigacess no dump de origem.
459:     *
460:     *   Mapeamento (tasks\task650\mapeamento.json):
461:     *     SIGOPC44.getFinal   -> cbo_4c_GetFinal
462:     *     SIGOPC44.Label1     -> lbl_4c_Label1
463:     *     SIGOPC44.getNumParc -> txt_4c_NumParc
464:     *     SIGOPC44.Label4     -> lbl_4c_Label4
465:     *--------------------------------------------------------------------------
466:     PROTECTED PROCEDURE ConfigurarCamposDados2()
467:         LOCAL loc_oErro
468:         TRY
469:             *-- Label1 original: Top=167, Left=12, Width=173, Height=17
470:             THIS.AddObject("lbl_4c_Label1", "Label")
471:             WITH THIS.lbl_4c_Label1
472:                 .FontBold   = .T.
473:                 .FontItalic = .F.
474:                 .FontName   = "Tahoma"
475:                 .BackStyle  = 0
476:                 .Caption    = "Finalidade do Arquivo"
477:                 .Height     = 17
478:                 .Left       = 12
479:                 .Top        = 167
480:                 .Width      = 173
481:                 .ForeColor  = RGB(90, 90, 90)
482:             ENDWITH
483: 
484:             *-- getFinal original: Top=183, Left=8, Width=254, Height=22,
485:             *-- Style=2 (dropdown list), RowSourceType=1 (Value), RowSource
486:             *-- com as 2 opcoes literais do legado - ListIndex (1/2) eh o
487:             *-- que GeraReg1 grava em CodFinal (this_nFinalidade no BO)
488:             THIS.AddObject("cbo_4c_GetFinal", "ComboBox")
489:             WITH THIS.cbo_4c_GetFinal
490:                 .Top           = 183
491:                 .Left          = 8
492:                 .Width         = 254
493:                 .Height        = 22
494:                 .FontName      = "Tahoma"
495:                 .SpecialEffect = 0
496:                 .Style         = 2
497:                 .RowSourceType = 1
498:                 .RowSource     = "1 - Normal,2 - Substitutivo Total"
499:                 .TabIndex      = 6
500:             ENDWITH
501: 
502:             *-- Label4 original: AutoSize=.T. (no-op em AddObject - regra #23),
503:             *-- Width=202/Height=16 ja sao os valores calculados pelo Form
504:             *-- Designer - transcrever explicito com AutoSize=.F.
505:             THIS.AddObject("lbl_4c_Label4", "Label")
506:             WITH THIS.lbl_4c_Label4

*-- Linhas 548 a 895:
548:             *-- Init legado escreve direto nos controles (Date() / 1 / "C:\")
549:             THIS.AplicarValoresPadrao()
550: 
551:             *-- Eventos dos campos de entrada. BINDEVENT em "KeyPress" nos
552:             *-- dois TextBox digitaveis - nunca "Valid", que nao dispara de
553:             *-- forma confiavel em TextBox, nem "LostFocus", que dispara
554:             *-- tambem quando outro controle recebe o foco. Na combo (Style=2,
555:             *-- dropdown list) o evento eh "InteractiveChange". txt_4c_Txtdest
556:             *-- NAO recebe handler: eh ReadOnly/TabStop=.F. no legado, o
557:             *-- usuario nao digita nele (o valor vem de SigCdPac.dircat44).
558:             BINDEVENT(THIS.txt_4c_DtEst, "KeyPress", THIS, "DtEstKeyPress")
559:             BINDEVENT(THIS.txt_4c_NumParc, "KeyPress", THIS, "NumParcKeyPress")
560:             BINDEVENT(THIS.cbo_4c_GetFinal, "InteractiveChange", THIS, ;
561:                 "FinalidadeInteractiveChange")
562:         CATCH TO loc_oErro
563:             MsgErro(loc_oErro.Message + CHR(13) + ;
564:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
565:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpC44.ConfigurarCamposDados2")
566:         ENDTRY
567:     ENDPROC
568: 
569:     *--------------------------------------------------------------------------
570:     * AplicarValoresPadrao - TRANSCRICAO dos defaults que o Init legado
571:     *   escreve DIRETO nos controles (SigOpC44_form_codigo_fonte.txt,
572:     *   PROCEDURE Init de SIGOPC44):
573:     *
574:     *       .TxtDest.Value = [C:\]
575:     *       If Not Empty(crSigCdPac.DirCat44)
576:     *           .TxtDest.Value = crSigCdPac.DirCat44
577:     *       EndIf
578:     *       .GetDtEst.Value   = Date()
579:     *       .GetNumParc.Value = 1
580:     *
581:     *   O legado NAO atribui getFinal.ListIndex - a combo nasce sem item
582:     *   selecionado (ListIndex = 0) de proposito, e eh justamente isso que o
583:     *   3o guard do CmdGera.Click ("Finalidade do arquivo nao informada!")
584:     *   testa. Nao assinar ListIndex aqui eh fidelidade, nao omissao.
585:     *
586:     *   O destino sai do BO (SigOpC44BO.CarregarParametros le SigCdPac.
587:     *   dircat44 e cai em "C:\" quando a coluna esta vazia); enquanto o BO
588:     *   ainda nao carregou, vale o literal "C:\" do legado. No fim espelha
589:     *   tela -> BO, para que GerarRegistro1/2/3 leiam os MESMOS valores que o
590:     *   usuario ve (o legado le ThisForm.<campo>.Value direto nos tres).
591:     *--------------------------------------------------------------------------
592:     PROTECTED PROCEDURE AplicarValoresPadrao()
593:         LOCAL loc_cDestino, loc_oErro
594: 
595:         TRY
596:             loc_cDestino = "C:\"
597:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
598:                 IF !EMPTY(THIS.this_oBusinessObject.this_cDestino)
599:                     loc_cDestino = ALLTRIM(THIS.this_oBusinessObject.this_cDestino)
600:                 ENDIF
601:             ENDIF
602: 
603:             THIS.txt_4c_Txtdest.Value = loc_cDestino
604:             THIS.txt_4c_DtEst.Value   = DATE()
605:             THIS.txt_4c_NumParc.Value = 1
606: 
607:             *-- Tela -> BO: o TextBox eh a fonte do valor, igual ao legado
608:             THIS.FormParaBO()
609:         CATCH TO loc_oErro
610:             MsgErro(loc_oErro.Message + CHR(13) + ;
611:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
612:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpC44.AplicarValoresPadrao")
613:         ENDTRY
614:     ENDPROC
615: 
616:     *--------------------------------------------------------------------------
617:     * DtEstKeyPress / NumParcKeyPress / FinalidadeInteractiveChange - eventos
618:     *   dos campos de entrada, ligados por BINDEVENT (logo PUBLIC - metodo
619:     *   PROTECTED falha em SILENCIO neste uso, CLAUDE.md regra #3).
620:     *   LPARAMETERS/assinatura obrigatoria nos de KeyPress: sem os parametros
621:     *   o VFP9 estoura "No PARAMETER statement is found" na 1a tecla digitada.
622:     *
623:     *   NAO validam nem exibem mensagem: no SCX legado NENHUM campo tem
624:     *   Valid/When/LostFocus (o dump tem apenas gerareg1/gerareg2/gerareg3/
625:     *   Init/Load e os dois Click). As tres regras dos campos rodam DE UMA VEZ
626:     *   em THIS.ValidarParametros(), que o Click do botao Gerar Arquivo chama,
627:     *   igual ao legado. Antecipar a mensagem aqui divergiria do PILAR 1: ao
628:     *   sair da Data do Estoque com a Finalidade ainda nao escolhida o usuario
629:     *   receberia "Finalidade do arquivo nao informada!", que o legado nunca
630:     *   exibe nesse momento.
631:     *
632:     *   Ao confirmar o campo (ENTER/TAB) so espelham o valor nas properties do
633:     *   BO. Na combo o evento eh InteractiveChange (Style = 2, dropdown list:
634:     *   o usuario escolhe com mouse/setas, nunca digita) e ela nao recebe
635:     *   parametro nenhum.
636:     *--------------------------------------------------------------------------
637:     PROCEDURE DtEstKeyPress(par_nKeyCode, par_nShiftAltCtrl)
638:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
639:             THIS.FormParaBO()
640:         ENDIF
641:     ENDPROC
642: 
643:     PROCEDURE NumParcKeyPress(par_nKeyCode, par_nShiftAltCtrl)
644:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
645:             THIS.FormParaBO()
646:         ENDIF
647:     ENDPROC
648: 
649:     PROCEDURE FinalidadeInteractiveChange()
650:         THIS.FormParaBO()
651:     ENDPROC
652: 
653:     *--------------------------------------------------------------------------
654:     * FormParaBO - transporta os parametros de geracao da TELA para as
655:     *   properties do BO. Este form tem exatamente QUATRO campos (destino,
656:     *   data do estoque, finalidade e numero de parcelas), logo o FormParaBO
657:     *   cobre os quatro e nada mais.
658:     *
659:     *   ConverterParaData() em vez de TTOD(): o .Value nasce DATE (DATE() em
660:     *   AplicarValoresPadrao) mas pode chegar como DATETIME ou CHAR conforme o
661:     *   caminho - TTOD() com DATE dispara erro 11 em RUNTIME (regra #16). O
662:     *   numero de parcelas tolera Caractere pelo mesmo motivo: o .Value de um
663:     *   TextBox com Format pode voltar como string.
664:     *
665:     *   this_nFinalidade recebe o LISTINDEX (1 = Normal, 2 = Substitutivo
666:     *   Total), nao o Value: eh o indice que o GeraReg1 legado grava em
667:     *   CodFinal (Str(ThisForm.GetFinal.ListIndex, 1)).
668:     *
669:     *   PROTECTED explicito: FormBase declara "PROTECTED PROCEDURE
670:     *   FormParaBO()" / "PROTECTED PROCEDURE BOParaForm()", e em VFP9
671:     *   redeclarar na subclasse SEM o modificador NAO alarga o escopo herdado
672:     *   (regra #51). Nao ha perda: os dois sao chamados so de dentro da classe
673:     *   (AplicarValoresPadrao, os handlers de evento e ValidarParametros).
674:     *--------------------------------------------------------------------------
675:     PROTECTED PROCEDURE FormParaBO()
676:         LOCAL loc_lSucesso, loc_uParcelas
677: 
678:         loc_lSucesso = .F.
679: 
680:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
681:             loc_uParcelas = THIS.txt_4c_NumParc.Value
682: 
683:             WITH THIS.this_oBusinessObject
684:                 .this_cDestino     = ALLTRIM(THIS.txt_4c_Txtdest.Value)
685:                 .this_dDataEstoque = ConverterParaData(THIS.txt_4c_DtEst.Value)
686:                 .this_nFinalidade  = THIS.cbo_4c_GetFinal.ListIndex
687:                 .this_nNumParcelas = IIF(VARTYPE(loc_uParcelas) = "N", ;
688:                     loc_uParcelas, VAL(TRANSFORM(loc_uParcelas)))
689:             ENDWITH
690: 
691:             loc_lSucesso = .T.
692:         ENDIF
693: 
694:         RETURN loc_lSucesso
695:     ENDPROC
696: 
697:     *--------------------------------------------------------------------------
698:     * BOParaForm - caminho inverso: joga os parametros do BO nos quatro
699:     *   campos. Usado depois de SigOpC44BO.CarregarParametros(), que eh quem
700:     *   le SigCdPac.dircat44 e preenche this_cDestino (equivalente ao
701:     *   "If Not Empty(crSigCdPac.DirCat44)" do Init legado). O Form NAO
702:     *   recalcula nada - le do BO (PILAR 3: fonte unica).
703:     *
704:     *   PROTECTED pelo mesmo motivo do FormParaBO acima.
705:     *--------------------------------------------------------------------------
706:     PROTECTED PROCEDURE BOParaForm()
707:         LOCAL loc_lSucesso, loc_nFinalidade
708: 
709:         loc_lSucesso = .F.
710: 
711:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
712:             WITH THIS.this_oBusinessObject
713:                 THIS.txt_4c_Txtdest.Value = IIF(EMPTY(.this_cDestino), "C:\", ;
714:                     ALLTRIM(.this_cDestino))
715:                 THIS.txt_4c_DtEst.Value   = ConverterParaData(.this_dDataEstoque)
716:                 THIS.txt_4c_NumParc.Value = .this_nNumParcelas
717:                 loc_nFinalidade           = .this_nFinalidade
718:             ENDWITH
719: 
720:             *-- ListIndex eh 1-based: so atribui indice que existe na lista
721:             *-- (RowSource tem 2 itens). Zero significa "nada escolhido", que
722:             *-- eh o estado em que o legado deixa a combo.
723:             IF BETWEEN(loc_nFinalidade, 1, 2)
724:                 THIS.cbo_4c_GetFinal.ListIndex = loc_nFinalidade
725:             ENDIF
726: 
727:             loc_lSucesso = .T.
728:         ENDIF
729: 
730:         RETURN loc_lSucesso
731:     ENDPROC
732: 
733:     *--------------------------------------------------------------------------
734:     * ValidarParametros - TRANSCRICAO dos tres guards que o legado escreveu no
735:     *   inicio do Click do CmdGera (SigOpC44_form_codigo_fonte.txt, OBJETO:
736:     *   SIGOPC44.CmdGera, PROCEDURE Click):
737:     *
738:     *       If Empty(ThisForm.Txtdest.Value)
739:     *           =MessageBox('Destino de Arquivo Invalido!!!' + Chr(13) + ;
740:     *                       'Verifique a Configuracao da Empresa.', 48, 'Destino Invalido...')
741:     *           ThisForm.CmdSair.SetFocus
742:     *           Return .f.
743:     *       EndIf
744:     *       If Empty(ThisForm.getDtEst.Value)
745:     *           =MessageBox('Data do Estoque nao informada!',48,'Data do Estoque invalida...')
746:     *           ThisForm.getDtEst.SetFocus
747:     *           Return(.F.)
748:     *       Endif
749:     *       If ThisForm.getFinal.ListIndex <= 0
750:     *           =MessageBox('Finalidade do arquivo nao informada!',48,'Finalidade invalida...')
751:     *           ThisForm.getFinal.SetFocus
752:     *           Return(.F.)
753:     *       Endif
754:     *
755:     *   A regra governa os campos que ESTA fase entrega, por isso nasce aqui;
756:     *   o Click do botao Gerar Arquivo so CHAMA
757:     *   (IF !THIS.ValidarParametros() / RETURN). Icone 48 do MessageBox =
758:     *   validacao de UI, logo MsgAviso - MsgErro (dialogo vermelho com
759:     *   "Fechar Aplicacao") assustaria o usuario sem motivo. Ordem, mensagens,
760:     *   titulos e destino do SetFocus sao os do legado, caractere a caractere
761:     *   (acentos via CHR(), regra #4).
762:     *
763:     *   PUBLIC porque o handler do botao chama de fora deste bloco e o
764:     *   TesteAutomatico.prg pode invocar direto (regras #3 e #51).
765:     *
766:     *   FormParaBO() ANTES dos guards: o TEXTBOX eh a fonte do valor (o legado
767:     *   le ThisForm.<campo>.Value), e sem o espelho o BO geraria o arquivo com
768:     *   o parametro ANTIGO.
769:     *
770:     *   RETURN unico, DEPOIS do ENDTRY (regra #1 - RETURN dentro de TRY/CATCH
771:     *   eh proibido, inclusive o bare).
772:     *--------------------------------------------------------------------------
773:     PROCEDURE ValidarParametros()
774:         LOCAL loc_lValido, loc_oErro
775: 
776:         loc_lValido = .F.
777: 
778:         TRY
779:             *-- Tela -> BO antes de qualquer guard (fonte unica = o controle)
780:             THIS.FormParaBO()
781: 
782:             DO CASE
783:                 CASE EMPTY(THIS.txt_4c_Txtdest.Value)
784:                     MsgAviso("Destino de Arquivo Inv" + CHR(225) + "lido!!!" + CHR(13) + ;
785:                         "Verifique a Configura" + CHR(231) + CHR(227) + "o da Empresa.", ;
786:                         "Destino Inv" + CHR(225) + "lido...")
787:                     THIS.cmd_4c_CmdSair.SetFocus()
788: 
789:                 CASE EMPTY(THIS.txt_4c_DtEst.Value)
790:                     MsgAviso("Data do Estoque n" + CHR(227) + "o informada!", ;
791:                         "Data do Estoque inv" + CHR(225) + "lida...")
792:                     THIS.txt_4c_DtEst.SetFocus()
793: 
794:                 CASE THIS.cbo_4c_GetFinal.ListIndex <= 0
795:                     MsgAviso("Finalidade do arquivo n" + CHR(227) + "o informada!", ;
796:                         "Finalidade inv" + CHR(225) + "lida...")
797:                     THIS.cbo_4c_GetFinal.SetFocus()
798: 
799:                 OTHERWISE
800:                     loc_lValido = .T.
801:             ENDCASE
802:         CATCH TO loc_oErro
803:             MsgErro(loc_oErro.Message + CHR(13) + ;
804:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
805:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpC44.ValidarParametros")
806:         ENDTRY
807: 
808:         RETURN loc_lValido
809:     ENDPROC
810: 
811:     *--------------------------------------------------------------------------
812:     * CmdGeraClick - TRANSCRICAO do SIGOPC44.CmdGera.Click (os tres guards
813:     *   ja migraram para ValidarParametros na Fase 6 - aqui so chama):
814:     *
815:     *       If MessageBox('Confirma a Geracao do Arquivo ?', 4+32+256, ;
816:     *               'Confirmacao de Geracao' ) <> 6
817:     *           =MessageBox('Operacao Cancelada Pelo Usuario!!!', 64, '')
818:     *           Return
819:     *       EndIf
820:     *       lcPoint = Set('Point')
821:     *       Set Point To [,]
822:     *       ThisForm.GeraReg1() / GeraReg2() / GeraReg3()
823:     *       lcNomFile = [CAT44]+Strtran(Dtoc(ThisForm.GetDtEst.Value),[/],[])+[.TXT]
824:     *       xNmArq = ADDBS(ThisForm.TxtDest.Value) + lcNomFile
825:     *       nHandle = Fcreate(xNmArq)
826:     *       <grava crReg1 (1 linha) + crReg2 (1 linha por produto, SCAN) +
827:     *        crReg3 (1 linha), cada linha pipe-delimitada com Alltrim de cada
828:     *        campo, Chr(13)+Chr(10) no fim - ver MontarLinhaRegistro>
829:     *       Fclose(nHandle)
830:     *       lcFileStr = FileToStr(xNmArq) / StrToFile(lcFileStr,xNmArq,4)
831:     *       =MessageBox('Arquivo Gerado : ' + xNmArq, 0+64, 'Processamento
832:     *           Concluido!!!')
833:     *       Set Point To lcPoint
834:     *       Wait Clear
835:     *       ThisForm.CmdSair.SetFocus
836:     *
837:     *   MessageBox(...,4+32+256,...) <> 6 (Sim/Nao, icone pergunta, botao
838:     *   padrao 3) vira MsgConfirma() - regra #7 (MsgConfirma retorna LOGICAL).
839:     *   "Set Point To [,]" troca o separador decimal para virgula enquanto os
840:     *   REPLACE ... WITH STR(...) do BO (GerarRegistro1/2/3) formatam os
841:     *   campos numericos dos registros - por isso o Set Point precisa cercar
842:     *   exatamente essas tres chamadas, igual ao legado, e ser restaurado
843:     *   antes do MsgInfo final (aqui restaurado um pouco antes, sem efeito
844:     *   pratico: a formatacao ja aconteceu, e nada mais formata numero depois).
845:     *   "Wait Clear" do legado fecha um WAIT WINDOW NOWAIT que nunca foi
846:     *   aberto por este Click (nenhum MsgProcessando/WAIT WINDOW precede) -
847:     *   no-op vestigial, nao transcrito (nao ha WAIT WINDOW para limpar).
848:     *
849:     *   RETURN unico fora do TRY (regra #1) via flag loc_lProsseguir - os
850:     *   dois "Return"/"Return .f." do legado (guard falhou / usuario cancelou)
851:     *   viram "nao entra no bloco seguinte", nunca RETURN dentro do TRY.
852:     *
853:     *   PUBLIC: ligado via BINDEVENT em ConfigurarBotoesAcao (regra #3).
854:     *--------------------------------------------------------------------------
855:     PROCEDURE CmdGeraClick()
856:         LOCAL loc_lProsseguir, loc_cPointAnterior, loc_cNomeArquivo, ;
857:             loc_cCaminhoArquivo, loc_nHandle, loc_cConteudoArquivo, loc_oErro
858: 
859:         loc_lProsseguir = .F.
860: 
861:         TRY
862:             IF THIS.ValidarParametros()
863:                 IF MsgConfirma("Confirma a Gera" + CHR(231) + CHR(227) + "o do Arquivo ?", ;
864:                         "Confirma" + CHR(231) + CHR(227) + "o de Gera" + CHR(231) + CHR(227) + "o")
865:                     loc_lProsseguir = .T.
866:                 ELSE
867:                     MsgInfo("Opera" + CHR(231) + CHR(227) + "o Cancelada Pelo Usu" + CHR(225) + "rio!!!", "")
868:                 ENDIF
869:             ENDIF
870: 
871:             IF loc_lProsseguir
872:                 loc_cPointAnterior = SET("POINT")
873:                 SET POINT TO ","
874: 
875:                 THIS.this_oBusinessObject.GerarRegistro1()
876:                 THIS.this_oBusinessObject.GerarRegistro2()
877:                 THIS.this_oBusinessObject.GerarRegistro3()
878: 
879:                 loc_cNomeArquivo = "CAT44" + STRTRAN(DTOC(THIS.txt_4c_DtEst.Value), "/", "") + ".TXT"
880:                 loc_cCaminhoArquivo = ADDBS(ALLTRIM(THIS.txt_4c_Txtdest.Value)) + loc_cNomeArquivo
881: 
882:                 loc_nHandle = FCREATE(loc_cCaminhoArquivo)
883: 
884:                 SELECT (THIS.this_oBusinessObject.this_cCursorReg1)
885:                 GO TOP
886:                 =FWRITE(loc_nHandle, THIS.MontarLinhaRegistro(THIS.this_oBusinessObject.this_cCursorReg1))
887: 
888:                 SELECT (THIS.this_oBusinessObject.this_cCursorReg2)
889:                 SCAN
890:                     =FWRITE(loc_nHandle, THIS.MontarLinhaRegistro(THIS.this_oBusinessObject.this_cCursorReg2))
891:                 ENDSCAN
892: 
893:                 SELECT (THIS.this_oBusinessObject.this_cCursorReg3)
894:                 GO TOP
895:                 =FWRITE(loc_nHandle, THIS.MontarLinhaRegistro(THIS.this_oBusinessObject.this_cCursorReg3))

*-- Linhas 911 a 993:
911:         CATCH TO loc_oErro
912:             MsgErro(loc_oErro.Message + CHR(13) + ;
913:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
914:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpC44.CmdGeraClick")
915:         ENDTRY
916:     ENDPROC
917: 
918:     *--------------------------------------------------------------------------
919:     * MontarLinhaRegistro - monta uma linha pipe-delimitada com ALLTRIM() de
920:     *   cada campo do registro CORRENTE do cursor par_cAlias, terminada em
921:     *   Chr(13)+Chr(10). TRANSCRICAO do laco generico do legado:
922:     *
923:     *       m.lcLinha = []
924:     *       For i = 1 To lnQtCampos
925:     *           lcCampo = Fields(i)
926:     *           m.lcLinha = m.lcLinha + Iif(not Empty(m.lcLinha),[|],[]) + Alltrim(&lcCampo)
927:     *       Next i
928:     *       m.lcLinha = m.lcLinha + Chr(13) + Chr(10)
929:     *
930:     *   FIELD(nFieldNo, cAlias) no lugar de FIELDS(i) (nome antigo da mesma
931:     *   funcao) e EVALUATE() no lugar de "&lcCampo" (macro) - EVALUATE eh
932:     *   leitura, regra #15 permite. O guard "Iif(not Empty(m.lcLinha),...)"
933:     *   eh transcrito tal qual: se um campo intermediario vier vazio depois
934:     *   do ALLTRIM, o pipe daquela posicao nao entra - comportamento do
935:     *   legado, nao bug deste metodo.
936:     *--------------------------------------------------------------------------
937:     PROTECTED PROCEDURE MontarLinhaRegistro(par_cAlias)
938:         LOCAL loc_nTotalCampos, loc_nI, loc_cCampo, loc_cLinha
939: 
940:         loc_cLinha = ""
941:         loc_nTotalCampos = FCOUNT(par_cAlias)
942: 
943:         FOR loc_nI = 1 TO loc_nTotalCampos
944:             loc_cCampo = FIELD(loc_nI, par_cAlias)
945:             loc_cLinha = loc_cLinha + IIF(!EMPTY(loc_cLinha), "|", "") + ;
946:                 ALLTRIM(EVALUATE(par_cAlias + "." + loc_cCampo))
947:         ENDFOR
948: 
949:         RETURN loc_cLinha + CHR(13) + CHR(10)
950:     ENDPROC
951: 
952:     *--------------------------------------------------------------------------
953:     * CmdSairClick - TRANSCRICAO do SIGOPC44.CmdSair.Click ("ThisForm.Release",
954:     *   nada mais). PUBLIC: ligado via BINDEVENT em ConfigurarBotoesAcao.
955:     *--------------------------------------------------------------------------
956:     PROCEDURE CmdSairClick()
957:         THIS.Release()
958:     ENDPROC
959: 
960:     *--------------------------------------------------------------------------
961:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
962:     *--------------------------------------------------------------------------
963:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
964:         LOCAL loc_i, loc_oControl, loc_oErro
965:         TRY
966:             FOR loc_i = 1 TO par_oContainer.ControlCount
967:                 loc_oControl = par_oContainer.Controls(loc_i)
968:                 IF VARTYPE(loc_oControl) = "O"
969:                     IF PEMSTATUS(loc_oControl, "Visible", 5)
970:                         loc_oControl.Visible = .T.
971:                     ENDIF
972:                     IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
973:                        loc_oControl.ControlCount > 0
974:                         THIS.TornarControlesVisiveis(loc_oControl)
975:                     ENDIF
976:                 ENDIF
977:             ENDFOR
978:         CATCH TO loc_oErro
979:             MsgErro(loc_oErro.Message + CHR(13) + ;
980:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
981:                 "Procedure: " + loc_oErro.Procedure, "FormSigOpC44.TornarControlesVisiveis")
982:         ENDTRY
983:     ENDPROC
984: 
985:     *--------------------------------------------------------------------------
986:     * Destroy - Libera o Business Object e restaura o menu principal
987:     * (fix sistemico mora em FormBase.Destroy - DODEFAULT() eh OBRIGATORIO)
988:     *--------------------------------------------------------------------------
989:     PROCEDURE Destroy()
990:         DODEFAULT()
991:     ENDPROC
992: 
993: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpC44BO.prg):
*------------------------------------------------------------------------------
* SigOpC44BO - Business Object para FormSigOpC44
* Dialogo operacional de geracao do arquivo da CAT 44/2008 (Substituicao
* Tributaria de Estoque) em layout posicional de texto (pipe-delimited no
* migrado, largura fixa no legado), com 3 tipos de registro:
*   Tipo 1 - cabecalho (dados da empresa + data do estoque + finalidade)
*   Tipo 2 - um registro por produto em estoque (1 por linha de crProds)
*   Tipo 3 - rodape (totais de imposto devido + parcelas de pagamento)
* Migrado de: SIGOPC44 (Framework Fortyus)
*
* Este dialogo NAO persiste em tabela propria: ele LE SigCdPac (parametros
* gerais - diretorio padrao de destino, this_cTabela/this_cCampoChave
* apontam para SigCdEmp, a entidade central da geracao) e SigCdEmp (dados
* fiscais da empresa - CNPJ, IE, Razao Social, Regime de Tributacao) e
* consome CsTemporario, um cursor de saldo de estoque JA POPULADO pelo
* processo chamador (fora do escopo deste BO) com Ps/Ps2/cPros/cGrus/
* Sqtds/dPros/cUnis/ClFiscals - equivalente ao agrupamento feito pelo
* GeraReg2 legado (Select ... From CsTemporario Where Ps=1 AND Ps2=1
* Having Sum(Sqtds)>0 Group By cPros).
*------------------------------------------------------------------------------
DEFINE CLASS SigOpC44BO AS BusinessBase

    *-- Propriedades espelhando os campos da tela (txtdest/getDtEst/getFinal/
    *-- getNumParc do legado)
    this_cEmpresa     = ""   && codigo da empresa (Cemps) - equivalente ao parametro lcEmp/go_4c_Sistema.cCodEmpresa do Init legado
    this_cDestino     = ""   && diretorio de destino do arquivo (txtdest.Value) - default SigCdPac.dircat44 ou "C:\"
    this_dDataEstoque = {}   && data do estoque (getDtEst.Value)
    this_nFinalidade  = 0    && getFinal.ListIndex: 1=Normal, 2=Substitutivo Total
    this_nNumParcelas = 0    && getNumParc.Value - numero de parcelas p/ pagamento do ICMS

    *-- Propriedade de acumulo entre registros (ThisForm.TotalImposto do
    *-- legado) - calculada durante a geracao do Registro 2 e usada na
    *-- geracao do Registro 3
    this_nTotalImposto = 0

    *-- Propriedade customizada da classe SIGOPC44 original (codidents),
    *-- vestigial: nao e lida nem gravada em nenhum dos 7 metodos do dump
    *-- legado. Mantida apenas para fidelidade estrutural (RESERVED3
    *-- ClassInfo do SCX a declara como propriedade customizada da classe).
    this_lCodIdents = .F.

    *-- Nomes dos cursores que este BO consome/popula (propriedade para o
    *-- Form referenciar sem repetir literais - padrao SigMvSbnBO/sigopagrBO)
    this_cCursorReg1 = "cursor_4c_Reg1"           && equivalente a crReg1 (Registro Tipo 1 - cabecalho)
    this_cCursorReg2 = "cursor_4c_Reg2"           && equivalente a crReg2 (Registro Tipo 2 - produtos)
    this_cCursorReg3 = "cursor_4c_Reg3"           && equivalente a crReg3 (Registro Tipo 3 - rodape)
    this_cCursorPac  = "cursor_4c_SigCdPac"       && equivalente a crSigCdPac (parametros gerais)
    this_cCursorEmp  = "cursor_4c_SigCdEmp"       && equivalente a crSigCdEmp (dados fiscais da empresa)

    *-- Dados fiscais da empresa (SigCdEmp), carregados por CarregarParametros/
    *-- CarregarDoCursor - usados em GerarRegistro1/GerarRegistro2
    this_cCNPJ              = ""   && SigCdEmp.Cgcs
    this_cInscricaoEstadual = ""   && SigCdEmp.IEs
    this_cRazaoSocial       = ""   && SigCdEmp.Razsocs
    this_cRegimeTributario  = ""   && SigCdEmp.RegTribs - '01'/'04' conforme GeraReg2 legado

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigCdEmp"
        THIS.this_cCampoChave = "Cemps"
    ENDPROC

    *--------------------------------------------------------------------------
    * Este BO eh SOMENTE-LEITURA: nenhum metodo do SIGOPC44 legado grava em
    * tabela do SQL Server. CarregarParametros/CarregarDoCursor fazem apenas
    * SELECT (SigCdPac/SigCdEmp); GerarRegistro1/GerarRegistro2/GerarRegistro3
    * escrevem so nos cursores LOCAIS cursor_4c_Reg1/cursor_4c_Reg2/
    * cursor_4c_Reg3, que o botao Gerar Arquivo do Form converte em arquivo de
    * texto (FCREATE/FWRITE, fora do escopo deste BO). O comportamento padrao
    * herdado de BusinessBase para Inserir()/Atualizar()/ExecutarExclusao()
    * ja eh o correto para esta entidade.
    *--------------------------------------------------------------------------

    *--------------------------------------------------------------------------
    * InicializarCursoresLocais - Cria os cursores locais de saida (Registros
    * Tipo 1/2/3 do layout posicional da CAT 44/2008). Migrado de SIGOPC44.Load.
    * Idempotente: PUBLIC porque o Form chama no Init, antes de qualquer
    * GerarRegistroN.
    *--------------------------------------------------------------------------
    PROCEDURE InicializarCursoresLocais()
        IF !USED(THIS.this_cCursorReg1)
            CREATE CURSOR (THIS.this_cCursorReg1) ( ;
                TipoReg  C(1), ;
                CNPJ     C(14), ;
                InscEst  C(15), ;
                Razaos   C(50), ;
                CodFinal C(1), ;
                QtdRegT2 C(5), ;
                DtLevEst C(10))
        ENDIF

        IF !USED(THIS.this_cCursorReg2)
            CREATE CURSOR (THIS.this_cCursorReg2) ( ;
                TipoReg   C(1), ;
                CodMerc   C(10), ;
                Qtde      C(12), ;
                VlrUnit   C(12), ;
                VlrTot    C(14), ;
                AliqIcms  C(5), ;
                IVASt     C(8), ;
                PrecoFin  C(12), ;
                ImpDev    C(12), ;
                CodTpMerc C(2), ;
                DescMerc  C(50), ;
                Unid      C(3))
        ENDIF

        IF !USED(THIS.this_cCursorReg3)
            CREATE CURSOR (THIS.this_cCursorReg3) ( ;
                TipoReg    C(1), ;
                TotSldCred C(12), ;
                IcmTotDev  C(12), ;
                IcmRecEst  C(12), ;
                NumParcPag C(2))
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametros - Carrega os parametros do sistema (SigCdPac.DirCat44
    * - diretorio padrao de destino) e os dados fiscais da empresa (SigCdEmp).
    * Migrado de SIGOPC44.Init: lcEmp = Iif(Type('lcEmp')=='C' and !Empty(lcEmp),
    * lcEmp, _Empr) + Seek(lcEmp, crSigCdEmp, cEmps) + CursorQuery('SigCdPac', ...)
    * + TxtDest.Value default. _Empr (regra legada proibida) -> go_4c_Sistema.
    * cCodEmpresa.
    *--------------------------------------------------------------------------
    FUNCTION CarregarParametros(par_cEmpresa)
        LOCAL loc_cSQL, loc_nResultado, loc_cEmpresa, loc_lSucesso

        loc_lSucesso = .T.

        THIS.InicializarCursoresLocais()

        loc_cEmpresa = IIF(VARTYPE(par_cEmpresa) = "C" AND !EMPTY(par_cEmpresa), ;
            ALLTRIM(par_cEmpresa), go_4c_Sistema.cCodEmpresa)

        IF USED(THIS.this_cCursorPac)
            USE IN (THIS.this_cCursorPac)
        ENDIF
        loc_cSQL = "SELECT dircat44 FROM SigCdPac"
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorPac)
        IF loc_nResultado < 0
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (" + ;
                THIS.this_cCursorPac + ")" + CHR(13) + CapturarErroSQL()
            loc_lSucesso = .F.
        ENDIF

        IF loc_lSucesso
            IF USED(THIS.this_cCursorEmp)
                USE IN (THIS.this_cCursorEmp)
            ENDIF
            loc_cSQL = "SELECT * FROM SigCdEmp WHERE cemps = " + EscaparSQL(loc_cEmpresa)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorEmp)
            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
                    "o Com o Servidor de Banco de Dados..." + CHR(13) + CapturarErroSQL()
                loc_lSucesso = .F.
            ENDIF
        ENDIF

        IF loc_lSucesso AND RECCOUNT(THIS.this_cCursorEmp) = 0
            THIS.this_cMensagemErro = "Empresa " + loc_cEmpresa + " n" + CHR(227) + ;
                "o encontrada em SigCdEmp."
            loc_lSucesso = .F.
        ENDIF

        IF loc_lSucesso
            THIS.CarregarDoCursor(THIS.this_cCursorEmp)

            THIS.this_cDestino = "C:\"
            IF USED(THIS.this_cCursorPac)
                SELECT (THIS.this_cCursorPac)
                IF RECCOUNT() > 0 AND !EMPTY(TratarNulo(dircat44, ""))
                    THIS.this_cDestino = ALLTRIM(dircat44)
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega os dados fiscais da empresa a partir do
    * cursor_4c_SigCdEmp (coluna a coluna, sem sintaxe campo -
    * Problema 9 da FORMCOR_LICOES_APRENDIDAS).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)
        IF RECCOUNT() = 0
            RETURN .F.
        ENDIF

        THIS.this_cEmpresa            = TratarNulo(cemps, "")
        THIS.this_cCNPJ               = TratarNulo(cgcs, "")
        THIS.this_cInscricaoEstadual  = TratarNulo(ies, "")
        THIS.this_cRazaoSocial        = TratarNulo(razsocs, "")
        THIS.this_cRegimeTributario   = TratarNulo(regtribs, "")

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave desta "entidade" eh o codigo da empresa
    * (SigCdEmp.Cemps), unica informacao persistida que identifica a geracao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cEmpresa
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarRegistro1 - Gera o registro Tipo 1 (cabecalho: CNPJ/IE/Razao Social
    * sem mascara, finalidade do arquivo e data do estoque). Migrado de
    * SIGOPC44.GeraReg1.
    *--------------------------------------------------------------------------
    FUNCTION GerarRegistro1()
        LOCAL loc_cCNPJ, loc_cIE

        THIS.InicializarCursoresLocais()

        loc_cCNPJ = STRTRAN(STRTRAN(STRTRAN(THIS.this_cCNPJ, ".", ""), "/", ""), "-", "")
        loc_cIE   = STRTRAN(THIS.this_cInscricaoEstadual, ".", "")

        SELECT (THIS.this_cCursorReg1)
        ZAP
        APPEND BLANK
        REPLACE TipoReg  WITH "1", ;
                CNPJ     WITH loc_cCNPJ, ;
                InscEst  WITH loc_cIE, ;
                Razaos   WITH fLimpaTexto(THIS.this_cRazaoSocial), ;
                CodFinal WITH STR(THIS.this_nFinalidade, 1), ;
                QtdRegT2 WITH STR(0, 5), ;
                DtLevEst WITH DTOC(THIS.this_dDataEstoque)

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarRegistro2 - Gera os registros Tipo 2 (um por produto em estoque),
    * calculando o ICMS devido na Substituicao Tributaria de cada item e
    * acumulando this_nTotalImposto (usado no Registro 3). Migrado de
    * SIGOPC44.GeraReg2. Consome CsTemporario, cursor LOCAL de saldo de
    * estoque ja populado pelo processo chamador (fora do escopo deste BO).
    *--------------------------------------------------------------------------
    FUNCTION GerarRegistro2()
        LOCAL loc_nAliqIcm, loc_nUltVlrCompra, loc_nIVASt, loc_nPrecoFin, ;
            loc_nTpSubSt, loc_cCodTpMerc, loc_nVlrImp, loc_cSQL, loc_dDtSaldo, ;
            loc_nResultado, loc_nQtdReg2

        IF !USED("CsTemporario")
            THIS.this_cMensagemErro = "Cursor de saldo de estoque (CsTemporario) n" + ;
                CHR(227) + "o est" + CHR(225) + " dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        THIS.InicializarCursoresLocais()

        IF USED("cursor_4c_Prods")
            USE IN cursor_4c_Prods
        ENDIF
        SELECT cPros, MAX(cGrus) AS cGrus, SUM(Sqtds) AS Sqtds, MAX(dPros) AS dPros, ;
                MAX(cUnis) AS cUnis, MAX(ClFiscals) AS ClFiscals ;
            FROM CsTemporario ;
            WHERE Ps = 1 AND Ps2 = 1 ;
            GROUP BY cPros ;
            HAVING SUM(Sqtds) > 0 ;
            INTO CURSOR cursor_4c_Prods READWRITE

        THIS.this_nTotalImposto = 0
        loc_dDtSaldo = fDtoSQL(THIS.this_dDataEstoque, "23:59:59")

        SELECT (THIS.this_cCursorReg2)
        ZAP

        SELECT cursor_4c_Prods
        SCAN
            loc_nAliqIcm      = 0
            loc_nUltVlrCompra = 0

            loc_cSQL = "SELECT Valors, Icms, CustoFS FROM SigCdPro WHERE cPros = " + ;
                EscaparSQL(cursor_4c_Prods.cPros)
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro")

            loc_cSQL = "SELECT IndIVAST, TpSubSt, TipoMercs FROM SigCdClf WHERE Codigos = " + ;
                EscaparSQL(cursor_4c_Prods.ClFiscals)
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalClf")

            IF USED("cursor_4c_LocalPro") AND !EOF("cursor_4c_LocalPro")
                loc_nUltVlrCompra = cursor_4c_LocalPro.CustoFS
            ENDIF

            * Valor da ultima entrada realizada (compra mais recente antes da
            * data do estoque) - usado quando nao ha custo medio corrente
            loc_cSQL = "SELECT TOP 1 Units FROM SigMvItn a " + ;
                "INNER JOIN SigCdOpe o ON o.Dopes = a.Dopes " + ;
                "INNER JOIN SigCdTom t ON t.Codigos = o.TipoOps " + ;
                "WHERE a.cPros = " + EscaparSQL(cursor_4c_Prods.cPros) + ;
                " AND t.GerGdmis = 2 AND a.DtAlts < " + FormatarDataSQL(loc_dDtSaldo) + ;
                " ORDER BY a.DtAlts DESC"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UltVlr")
            IF loc_nResultado < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (cursor_4c_UltVlr)" + ;
                    CHR(13) + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
                RETURN .F.
            ENDIF
            IF USED("cursor_4c_UltVlr") AND !EOF("cursor_4c_UltVlr")
                loc_nUltVlrCompra = ROUND(cursor_4c_UltVlr.Units, 2)
            ENDIF
            IF USED("cursor_4c_UltVlr")
                USE IN cursor_4c_UltVlr
            ENDIF

            * Aliquota de ICMS do produto - cadeia de prioridades do legado:
            * SigPrTri -> SigCdUfd -> SigCdcFi -> SigCdPro.Icms -> SigCdUfs
            loc_cSQL = "SELECT Aliquotas FROM SigPrTri WHERE Origems = " + EscaparSQL("SP") + ;
                " AND Destinos = " + EscaparSQL("SP")
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrTri")
            IF USED("cursor_4c_PrTri") AND RECCOUNT("cursor_4c_PrTri") > 0
                loc_nAliqIcm = cursor_4c_PrTri.Aliquotas
            ENDIF
            IF USED("cursor_4c_PrTri")
                USE IN cursor_4c_PrTri
            ENDIF

            IF loc_nAliqIcm = 0
                loc_cSQL = "SELECT Aliqs FROM SigCdUfd WHERE Codigos = " + EscaparSQL("SP") + ;
                    " AND Destinos = " + EscaparSQL("SP")
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ufd")
                IF USED("cursor_4c_Ufd") AND RECCOUNT("cursor_4c_Ufd") > 0
                    loc_nAliqIcm = cursor_4c_Ufd.Aliqs
                ENDIF
                IF USED("cursor_4c_Ufd")
                    USE IN cursor_4c_Ufd
                ENDIF
            ENDIF

            IF loc_nAliqIcm = 0
                loc_cSQL = "SELECT Icms FROM SigCdcFi WHERE Grupos = " + ;
                    EscaparSQL(cursor_4c_Prods.cGrus) + " AND Ests = " + EscaparSQL("SP")
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_cFi")
                IF USED("cursor_4c_cFi") AND RECCOUNT("cursor_4c_cFi") > 0
                    loc_nAliqIcm = cursor_4c_cFi.Icms
                ENDIF
                IF USED("cursor_4c_cFi")
                    USE IN cursor_4c_cFi
                ENDIF
            ENDIF

            IF loc_nAliqIcm = 0
                IF USED("cursor_4c_LocalPro") AND !EOF("cursor_4c_LocalPro") AND cursor_4c_LocalPro.Icms > 0
                    loc_nAliqIcm = cursor_4c_LocalPro.Icms
                ELSE
                    loc_cSQL = "SELECT AIcms FROM SigCdUfs WHERE Estados = " + EscaparSQL("SP")
                    SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ufs")
                    IF USED("cursor_4c_Ufs") AND RECCOUNT("cursor_4c_Ufs") > 0
                        loc_nAliqIcm = cursor_4c_Ufs.AIcms
                    ENDIF
                    IF USED("cursor_4c_Ufs")
                        USE IN cursor_4c_Ufs
                    ENDIF
                ENDIF
            ENDIF

            loc_nIVASt     = 0
            loc_nPrecoFin  = 0
            loc_nTpSubSt   = 0
            loc_cCodTpMerc = ""
            IF USED("cursor_4c_LocalClf") AND !EOF("cursor_4c_LocalClf")
                loc_nIVASt     = cursor_4c_LocalClf.IndIVAST
                loc_nTpSubSt   = cursor_4c_LocalClf.TpSubSt
                loc_cCodTpMerc = TRANSFORM(cursor_4c_LocalClf.TipoMercs, "@L 99")
                IF USED("cursor_4c_LocalPro") AND !EOF("cursor_4c_LocalPro")
                    loc_nPrecoFin = cursor_4c_LocalPro.Valors
                ENDIF
                IF loc_nTpSubSt = 2
                    loc_nIVASt = 0
                ELSE
                    loc_nPrecoFin = 0
                ENDIF
            ENDIF

            * Calculo do imposto devido - conforme o regime de tributacao da empresa
            loc_nVlrImp = 0
            IF loc_nTpSubSt = 2
                IF THIS.this_cRegimeTributario = "01"
                    loc_nVlrImp = (cursor_4c_Prods.Sqtds * loc_nUltVlrCompra) * (loc_nAliqIcm / 100)
                ENDIF
                IF THIS.this_cRegimeTributario = "04"
                    loc_nVlrImp = ((cursor_4c_Prods.Sqtds * loc_nPrecoFin) - ;
                        (cursor_4c_Prods.Sqtds * loc_nUltVlrCompra)) * (loc_nAliqIcm / 100)
                ENDIF
            ELSE
                IF THIS.this_cRegimeTributario = "01"
                    loc_nVlrImp = ((cursor_4c_Prods.Sqtds * loc_nUltVlrCompra) * (loc_nAliqIcm / 100)) + ;
                        ((cursor_4c_Prods.Sqtds * loc_nUltVlrCompra) * (loc_nIVASt / 100) * (loc_nAliqIcm / 100))
                ENDIF
                IF THIS.this_cRegimeTributario = "04"
                    loc_nVlrImp = (cursor_4c_Prods.Sqtds * loc_nUltVlrCompra) * (loc_nIVASt / 100) * (loc_nAliqIcm / 100)
                ENDIF
            ENDIF

            THIS.this_nTotalImposto = THIS.this_nTotalImposto + ROUND(loc_nVlrImp, 2)

            SELECT (THIS.this_cCursorReg2)
            APPEND BLANK
            REPLACE TipoReg    WITH "2", ;
                    CodMerc    WITH cursor_4c_Prods.cPros, ;
                    Qtde       WITH STR(cursor_4c_Prods.Sqtds, 12, 3), ;
                    VlrUnit    WITH STR(loc_nUltVlrCompra, 12, 2), ;
                    VlrTot     WITH STR(cursor_4c_Prods.Sqtds * loc_nUltVlrCompra, 12, 2), ;
                    AliqIcms   WITH STR(loc_nAliqIcm, 5, 2), ;
                    IVASt      WITH STR(loc_nIVASt, 7, 2), ;
                    PrecoFin   WITH STR(loc_nPrecoFin, 12, 2), ;
                    ImpDev     WITH STR(loc_nVlrImp, 12, 2), ;
                    CodTpMerc  WITH loc_cCodTpMerc, ;
                    DescMerc   WITH fLimpaTexto(cursor_4c_Prods.dPros), ;
                    Unid       WITH cursor_4c_Prods.cUnis

            IF USED("cursor_4c_LocalPro")
                USE IN cursor_4c_LocalPro
            ENDIF
            IF USED("cursor_4c_LocalClf")
                USE IN cursor_4c_LocalClf
            ENDIF

            SELECT cursor_4c_Prods
        ENDSCAN

        IF USED("cursor_4c_Prods")
            USE IN cursor_4c_Prods
        ENDIF

        * Acerto da quantidade de registros Tipo 2 no cabecalho (Registro 1)
        loc_nQtdReg2 = IIF(USED(THIS.this_cCursorReg2), RECCOUNT(THIS.this_cCursorReg2), 0)
        IF USED(THIS.this_cCursorReg1)
            SELECT (THIS.this_cCursorReg1)
            GO TOP
            REPLACE QtdRegT2 WITH STR(loc_nQtdReg2, 5)
        ENDIF

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarRegistro3 - Gera o registro Tipo 3 (rodape: total de imposto devido
    * e numero de parcelas para pagamento do ICMS). Migrado de SIGOPC44.GeraReg3.
    *--------------------------------------------------------------------------
    FUNCTION GerarRegistro3()
        LOCAL loc_nNumParc

        THIS.InicializarCursoresLocais()

        loc_nNumParc = THIS.this_nNumParcelas
        IF THIS.this_nTotalImposto <= 0
            loc_nNumParc = 0
        ENDIF

        SELECT (THIS.this_cCursorReg3)
        ZAP
        APPEND BLANK
        REPLACE TipoReg    WITH "3", ;
                TotSldCred WITH "0,00", ;
                IcmTotDev  WITH STR(THIS.this_nTotalImposto, 12, 2), ;
                IcmRecEst  WITH STR(THIS.this_nTotalImposto, 12, 2), ;
                NumParcPag WITH STR(loc_nNumParc, 2)

        RETURN .T.
    ENDFUNC

ENDDEFINE

