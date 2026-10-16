# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [METODO-INEXISTENTE] Metodo 'THIS.MouseSobreBotaoSair()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRMEI.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (829 linhas total):

*-- Linhas 11 a 175:
11: *   (nao editavel) continuar resolvendo o nome; em codigo NOSSO nunca se chama
12: *   fConfigGeral. O que ela fazia (configuracao global) ja ocorre ANTES deste
13: *   form abrir: config.prg (SETs/paths/aliases), main.prg (conexao) e o
14: *   proprio SIGPRMEIBO (SigCdPam via InicializarForm). Mesmo padrao de
15: *   FormSigMvExp.prg/FormSigPrCar.prg.
16: *
17: *   Destroy (ThisForm.PoDataMgr.Release + DoDefault) - poDataMgr era o
18: *   data manager do Framework legado (fSqlConector); equivalente no migrado
19: *   eh THIS.this_oBusinessObject, liberado em Destroy() abaixo.
20: *==============================================================================
21: SET SAFETY OFF
22: SET RESOURCE OFF
23: 
24: DEFINE CLASS FormSIGPRMEI AS FormBase
25: 
26:     *-- Dimensoes (PILAR 1: identico ao legado SIGPRMEI.SCX)
27:     Width       = 500
28:     Height      = 147
29:     AutoCenter  = .T.
30:     TitleBar    = 0
31:     ShowWindow = 1
32:     WindowType = 1
33:     ControlBox  = .F.
34:     FontBold    = .F.          && SCX: SIGPRMEI.FontBold
35:     Closable    = .F.
36:     MaxButton   = .F.
37:     MinButton   = .F.
38:     KeyPreview  = .T.
39:     DataSession = 2
40:     AlwaysOnTop = .T.
41:     BorderStyle = 2
42: 
43:     *-- Business Object
44:     this_oBusinessObject = .NULL.
45: 
46:     *-- Modo automatico: .T. = iniciado por scheduler sem interface interativa
47:     this_lParametrizado  = .F.
48: 
49:     *--------------------------------------------------------------------------
50:     PROCEDURE Init()
51:     *--------------------------------------------------------------------------
52:         LPARAMETERS par_lParametrizado
53:         THIS.this_lParametrizado = IIF(VARTYPE(par_lParametrizado) = "L", par_lParametrizado, .F.)
54:         RETURN DODEFAULT()
55:     ENDPROC
56: 
57:     *--------------------------------------------------------------------------
58:     * ConfigurarPageFrame - Background e fontes do dialogo
59:     *--------------------------------------------------------------------------
60:     PROTECTED PROCEDURE ConfigurarPageFrame()
61:         THIS.ScrollBars = 0
62:         THIS.ShowTips   = .T.
63:         THIS.SetAll("FontName", "Tahoma")
64:         THIS.SetAll("FontSize", 8)
65:         THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
66:     ENDPROC
67: 
68:     *--------------------------------------------------------------------------
69:     * InicializarForm - Cria BO, carrega config SigCdPam e monta controles
70:     *--------------------------------------------------------------------------
71:     PROTECTED PROCEDURE InicializarForm()
72:         LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nRet
73:         loc_lSucesso = .F.
74: 
75:         TRY
76:             THIS.this_oBusinessObject = CREATEOBJECT("SIGPRMEIBO")
77: 
78:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
79: 
80:                 *-- Titulo com acentuacao via CHR (PILAR 1: fidelidade ao caption legado)
81:                 THIS.Caption = "Integra" + CHR(231) + CHR(227) + "o SIS E-Commerce"
82: 
83:                 *-- Carregar configuracoes operacionais de SigCdPam
84:                 IF gnConnHandle > 0
85:                     loc_cSQL = "SELECT DirLivrosV, CdChepSais, Mascnums, CdChepEnts FROM SigCdPam"
86:                     loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPam")
87:                     IF loc_nRet > 0
88:                         SELECT cursor_4c_SigCdPam
89:                         GO TOP
90:                         IF !EOF("cursor_4c_SigCdPam")
91:                             THIS.this_oBusinessObject.this_cDirLivros  = ALLTRIM(cursor_4c_SigCdPam.DirLivrosV)
92:                             THIS.this_oBusinessObject.this_cDirSaida   = ALLTRIM(cursor_4c_SigCdPam.CdChepSais)
93:                             THIS.this_oBusinessObject.this_cMascNums   = ALLTRIM(cursor_4c_SigCdPam.Mascnums)
94:                             THIS.this_oBusinessObject.this_cDirEntrada = ALLTRIM(cursor_4c_SigCdPam.CdChepEnts)
95:                         ENDIF
96:                         USE IN SELECT("cursor_4c_SigCdPam")
97:                     ELSE
98:                         MsgErro("Erro ao carregar configura" + CHR(231) + CHR(245) + "es de SigCdPam.", "FormSIGPRMEI.InicializarForm")
99:                     ENDIF
100:                 ENDIF
101: 
102:                 THIS.this_oBusinessObject.this_lParametrizado = THIS.this_lParametrizado
103: 
104:                 THIS.ConfigurarPageFrame()
105:                 THIS.ConfigurarCabecalho()
106:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
107:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
108:                 THIS.ConfigurarBotoes()
109:                 THIS.ConfigurarLabels()
110: 
111:                 *-- TabIndex: DEPOIS de todos os AddObject (regra: atribuir em
112:                 *-- controle inexistente derruba o Init)
113:                 THIS.ConfigurarPaginaLista()
114:                 THIS.ConfigurarPaginaDados()
115: 
116:                 THIS.TornarControlesVisiveis(THIS)
117: 
118:                 loc_lSucesso = .T.
119:             ELSE
120:                 MsgErro("Erro ao criar Business Object SIGPRMEIBO." + CHR(13) + ;
121:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
122:             ENDIF
123:         CATCH TO loc_oErro
124:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
125:                 " PROC=" + loc_oErro.Procedure, "FormSIGPRMEI.InicializarForm")
126:             loc_lSucesso = .F.
127:         ENDTRY
128: 
129:         RETURN loc_lSucesso
130:     ENDPROC
131: 
132:     *--------------------------------------------------------------------------
133:     * ConfigurarCabecalho - Container cinza escuro com titulo em sombra e branco
134:     *--------------------------------------------------------------------------
135:     PROTECTED PROCEDURE ConfigurarCabecalho()
136:         LOCAL loc_oCab
137: 
138:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
139:         WITH THIS.cnt_4c_Cabecalho
140:             .Top         = 0
141:             .Left        = 0
142:             .Width       = THIS.Width
143:             .Height      = 80
144:             .BackStyle   = 1
145:             .BackColor   = RGB(100, 100, 100)
146:             .BorderWidth = 0
147:             .Visible     = .T.
148:         ENDWITH
149: 
150:         loc_oCab = THIS.cnt_4c_Cabecalho
151: 
152:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
153:         WITH loc_oCab.lbl_4c_Sombra
154:             .Top           = 18
155:             .Left          = 10
156:             .Width         = THIS.Width
157:             .Height        = 40
158:             .AutoSize      = .F.
159:             .FontBold      = .T.
160:             .FontName      = "Tahoma"
161:             .FontSize      = 18
162:             .FontUnderline = .F.
163:             .WordWrap      = .T.
164:             .Alignment     = 0
165:             .BackStyle     = 0
166:             .ForeColor     = RGB(0, 0, 0)
167:             .Rotation      = 0                      && SCX: lblSombra.Rotation
168:             .Caption       = THIS.Caption
169:             .Visible       = .T.
170:         ENDWITH
171: 
172:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
173:         WITH loc_oCab.lbl_4c_Titulo
174:             .Top          = 17
175:             .Left         = 10

*-- Linhas 193 a 348:
193:     *--------------------------------------------------------------------------
194:     * ConfigurarBotoes - Botoes Processar e Encerrar sobrepostos ao cabecalho
195:     *--------------------------------------------------------------------------
196:     PROTECTED PROCEDURE ConfigurarBotoes()
197: 
198:         *-- Botao Processar
199:         THIS.AddObject("btn_4c_Processar", "CommandButton")
200:         WITH THIS.btn_4c_Processar
201:             .Top             = 3
202:             .Left            = 350                && SCX: cmdBtnForm.Left=345 + Command1.Left=5
203:             .Width           = 75
204:             .Height          = 75
205:             .Caption         = "Processar"
206:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
207:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
208:             .ToolTipText     = "Processar"
209:             .FontBold        = .T.
210:             .FontItalic      = .T.
211:             .FontName        = "Comic Sans MS"     && SCX: Command1.FontName
212:             .FontSize        = 8
213:             .ForeColor       = RGB(90, 90, 90)
214:             .BackColor       = RGB(255, 255, 255)
215:             .Themes          = .T.
216:             .WordWrap        = .T.
217:             .AutoSize        = .F.
218:             .PicturePosition = 13
219:             .SpecialEffect   = 0
220:             .MousePointer    = 15
221:             .Visible         = .T.
222:         ENDWITH
223:         BINDEVENT(THIS.btn_4c_Processar, "Click", THIS, "BtnProcessarClick")
224: 
225:         *-- Botao Encerrar
226:         THIS.AddObject("btn_4c_Encerrar", "CommandButton")
227:         WITH THIS.btn_4c_Encerrar
228:             .Top             = 3
229:             .Left            = 425                && SCX: cmdBtnForm.Left=345 + Command2.Left=80
230:             .Width           = 75
231:             .Height          = 75
232:             .Caption         = "Encerrar"
233:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
234:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
235:             .Cancel          = .T.
236:             .ToolTipText     = "[ESC] Sair"
237:             .FontBold        = .T.
238:             .FontItalic      = .T.
239:             .FontName        = "Comic Sans MS"     && SCX: Command2.FontName
240:             .FontSize        = 8
241:             .ForeColor       = RGB(90, 90, 90)
242:             .BackColor       = RGB(255, 255, 255)
243:             .Themes          = .T.
244:             .WordWrap        = .T.
245:             .AutoSize        = .F.
246:             .PicturePosition = 13
247:             .SpecialEffect   = 0
248:             .MousePointer    = 15
249:             .Visible         = .T.
250:         ENDWITH
251:         BINDEVENT(THIS.btn_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
252:     ENDPROC
253: 
254:     *--------------------------------------------------------------------------
255:     * ConfigurarLabels - Label de identificacao e label de status dinamico
256:     *--------------------------------------------------------------------------
257:     PROTECTED PROCEDURE ConfigurarLabels()
258: 
259:         *-- Label de identificacao do sistema (Label2 no legado)
260:         THIS.AddObject("lbl_4c_Info", "Label")
261:         WITH THIS.lbl_4c_Info
262:             .FontBold    = .T.
263:             .FontName    = "Tahoma"
264:             .FontSize    = 8
265:             .BackStyle   = 0
266:             .BorderStyle = 0
267:             .Caption     = "Integra" + CHR(231) + CHR(227) + "o Sis e-Commerce"
268:             .Height      = 20
269:             .Left        = 147
270:             .Top         = 96
271:             .Width       = 205
272:             .ForeColor   = RGB(90, 90, 90)
273:             .BackColor   = RGB(255, 255, 234)
274:             .Visible     = .T.
275:         ENDWITH
276: 
277:         *-- Label de status do processamento (Label1 no legado - atualizado dinamicamente)
278:         THIS.AddObject("lbl_4c_Status", "Label")
279:         WITH THIS.lbl_4c_Status
280:             .FontBold    = .T.
281:             .FontName    = "Tahoma"
282:             .FontSize    = 8
283:             .BackStyle   = 0
284:             .BorderStyle = 0
285:             .Caption     = ""
286:             .Height      = 20
287:             .Left        = 56
288:             .Top         = 114
289:             .Width       = 387
290:             .ForeColor   = RGB(90, 90, 90)
291:             .BackColor   = RGB(255, 255, 234)
292:             .Visible     = .T.
293:         ENDWITH
294:     ENDPROC
295: 
296:     *--------------------------------------------------------------------------
297:     * Activate - Auto-inicia processamento em modo automatico (Parametrizado)
298:     *--------------------------------------------------------------------------
299:     PROCEDURE Activate()
300:         IF THIS.this_lParametrizado
301:             THIS.BtnProcessarClick()
302:         ENDIF
303:     ENDPROC
304: 
305:     *--------------------------------------------------------------------------
306:     * BtnProcessarClick - Loop de processamento: LerArquivos + GravarArquivos
307:     *--------------------------------------------------------------------------
308:     PROCEDURE BtnProcessarClick()
309:         LOCAL loc_llOk1, loc_llOk2, loc_lnMov, loc_lnKey, loc_lnError, loc_lcErro
310:         LOCAL loc_lSaiuPeloBotao
311: 
312:         loc_lSaiuPeloBotao = .F.
313: 
314:         THIS.btn_4c_Processar.Enabled = .F.
315:         SET CURSOR OFF
316: 
317:         *-- SCX btnCopiar.Click: Keyboard [{LEFTARROW}] - tira o foco do botao que
318:         *-- acabou de perder o Enabled, para que o INKEY(.5, "M") do loop capture
319:         *-- mouse e teclado em vez de a tecla ficar presa no controle desabilitado.
320:         KEYBOARD "{LEFTARROW}"
321: 
322:         loc_lnMov = 1
323:         DO WHILE .T.
324:             THIS.btn_4c_Encerrar.Enabled = .F.
325:             THIS.lbl_4c_Status.Caption = "Aguardando Arquivos Para Processar" + REPLICATE(".", loc_lnMov)
326:             loc_lnMov = IIF(loc_lnMov < 5, loc_lnMov + 1, 1)
327: 
328:             loc_llOk1 = THIS.this_oBusinessObject.LerArquivos()
329:             loc_llOk2 = THIS.this_oBusinessObject.GravarArquivos()
330: 
331:             IF !EMPTY(THIS.this_oBusinessObject.this_cUltStatus)
332:                 THIS.lbl_4c_Status.Caption = THIS.this_oBusinessObject.this_cUltStatus
333:             ENDIF
334: 
335:             THIS.btn_4c_Encerrar.Enabled = .T.
336: 
337:             *-- Aguardar 0.5s capturando input do usuario
338:             loc_lnError = 0
339:             loc_lcErro  = ON("Error")
340:             ON ERROR loc_lnError = 1
341: 
342:             loc_lnKey = INKEY(.5, "M")
343: 
344:             IF loc_lnError <> 0
345:                 loc_lnKey = 0
346:             ENDIF
347:             ON ERROR &loc_lcErro.
348: 

*-- Linhas 384 a 427:
384:     *--------------------------------------------------------------------------
385:     * BtnEncerrarClick - Fecha o formulario
386:     *--------------------------------------------------------------------------
387:     PROCEDURE BtnEncerrarClick()
388:         THIS.Release()
389:     ENDPROC
390: 
391:     *--------------------------------------------------------------------------
392:     * MouseSobreBotaoSair - O ponteiro do mouse esta sobre o botao de saida?
393:     *
394:     * O SCX legado CHAMA ThisForm.MouseSobreBotaoSair(...) no loop do
395:     * btnCopiar.Click mas NUNCA a define: a ClassInfo do SCX (RESERVED3) lista
396:     * apenas desabotao / gravararquivos / habilitabotao / lerarquivos, e a classe
397:     * do form eh "form" PURA, sem VCX de onde herdar. Transcrever a chamada sem
398:     * definir o metodo cairia na regra #13 do CLAUDE.md: nome desconhecido nao eh
399:     * erro de compilacao - o VFP procura mousesobrebotaosair.prg no PATH e so
400:     * estoura em RUNTIME, dentro do loop de processamento. Por isso o metodo eh
401:     * IMPLEMENTADO aqui, com a semantica que o call site exige.
402:     *
403:     * par_nCol / par_nRow : posicao do ponteiro em PIXELS dentro da janela do
404:     *                       form (MCOL/MROW com nScaleMode = 3)
405:     * par_oBotao          : o CommandButton de saida a testar
406:     *--------------------------------------------------------------------------
407:     FUNCTION MouseSobreBotaoSair(par_nCol, par_nRow, par_oBotao)
408:         LOCAL loc_nLeft, loc_nTop, loc_oPai, loc_nNivel, loc_lSobre
409: 
410:         loc_lSobre = .F.
411: 
412:         IF VARTYPE(par_oBotao) = "O" AND VARTYPE(par_nCol) = "N" AND VARTYPE(par_nRow) = "N"
413: 
414:             *-- Left/Top sao RELATIVOS ao pai: somar a cadeia de containers ate o
415:             *-- Form da a posicao ABSOLUTA na janela, que eh o referencial de
416:             *-- MCOL/MROW. Hoje os dois botoes sao filhos diretos do Form (o
417:             *-- cmdBtnForm do legado foi desmembrado em dois CommandButton), mas
418:             *-- somar a cadeia mantem o teste correto se algum deles voltar para
419:             *-- dentro de um container.
420:             loc_nLeft  = par_oBotao.Left
421:             loc_nTop   = par_oBotao.Top
422:             loc_oPai   = par_oBotao.Parent
423:             loc_nNivel = 0
424: 
425:             *-- Guarda de profundidade: evita laco infinito se a cadeia de Parent
426:             *-- vier ciclica ou nunca alcancar o Form.
427:             DO WHILE VARTYPE(loc_oPai) = "O" AND loc_nNivel < 20

*-- Linhas 454 a 829:
454:     * dos XMLs em fila ("incluir novo lote de movimentos"), sem entrar no
455:     * loop continuo do BtnProcessar. Util para operacao manual pontual.
456:     *--------------------------------------------------------------------------
457:     PROCEDURE BtnIncluirClick()
458:         LOCAL loc_llOk1, loc_llOk2, loc_oErro
459: 
460:         THIS.btn_4c_Processar.Enabled = .F.
461:         THIS.btn_4c_Encerrar.Enabled  = .F.
462:         THIS.lbl_4c_Status.Caption    = "Processando novo lote..."
463: 
464:         TRY
465:             loc_llOk1 = THIS.this_oBusinessObject.LerArquivos()
466:             loc_llOk2 = THIS.this_oBusinessObject.GravarArquivos()
467: 
468:             IF !EMPTY(THIS.this_oBusinessObject.this_cUltStatus)
469:                 THIS.lbl_4c_Status.Caption = THIS.this_oBusinessObject.this_cUltStatus
470:             ELSE
471:                 THIS.lbl_4c_Status.Caption = IIF(loc_llOk1 AND loc_llOk2, ;
472:                     "Lote processado com sucesso.", ;
473:                     "Falha no processamento do lote.")
474:             ENDIF
475:         CATCH TO loc_oErro
476:             THIS.lbl_4c_Status.Caption = "Erro: " + loc_oErro.Message
477:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
478:                 " PROC=" + loc_oErro.Procedure, "FormSIGPRMEI.BtnIncluirClick")
479:         ENDTRY
480: 
481:         THIS.btn_4c_Processar.Enabled = .T.
482:         THIS.btn_4c_Encerrar.Enabled  = .T.
483:     ENDPROC
484: 
485:     *--------------------------------------------------------------------------
486:     * BtnAlterarClick - Reprocessa: releitura imediata de arquivos em fila
487:     *
488:     * Em forms CRUD, este botao edita registro. Neste form OPERACIONAL, forca
489:     * releitura imediata dos XMLs ? util quando o operador corrigiu arquivos
490:     * no diretorio de entrada e nao quer esperar o polling do BtnProcessar.
491:     * Delega para BtnIncluirClick (mesma operacao de ciclo unico).
492:     *--------------------------------------------------------------------------
493:     PROCEDURE BtnAlterarClick()
494:         THIS.BtnIncluirClick()
495:     ENDPROC
496: 
497:     *--------------------------------------------------------------------------
498:     * BtnVisualizarClick - Exibe configuracoes ativas da integracao SIS
499:     *
500:     * Em forms CRUD, este botao visualiza registro. Neste form OPERACIONAL,
501:     * mostra as configuracoes carregadas de SigCdPam (diretorios de entrada/
502:     * saida, mascara de numeracao) ? permite ao operador confirmar caminhos
503:     * antes de iniciar processamento.
504:     *--------------------------------------------------------------------------
505:     PROCEDURE BtnVisualizarClick()
506:         LOCAL loc_cMsg, loc_oBO
507: 
508:         loc_oBO = THIS.this_oBusinessObject
509: 
510:         loc_cMsg = "Configura" + CHR(231) + CHR(245) + "es de Integra" + ;
511:                    CHR(231) + CHR(227) + "o SIS E-Commerce:" + CHR(13) + CHR(13)
512:         loc_cMsg = loc_cMsg + "Diret" + CHR(243) + "rio de Livros (XMLs de venda web):" + CHR(13)
513:         loc_cMsg = loc_cMsg + "  " + ALLTRIM(loc_oBO.this_cDirLivros) + CHR(13) + CHR(13)
514:         loc_cMsg = loc_cMsg + "Diret" + CHR(243) + "rio de Sa" + CHR(237) + "da (estoque.xml):" + CHR(13)
515:         loc_cMsg = loc_cMsg + "  " + ALLTRIM(loc_oBO.this_cDirSaida) + CHR(13) + CHR(13)
516:         loc_cMsg = loc_cMsg + "Diret" + CHR(243) + "rio de Entrada:" + CHR(13)
517:         loc_cMsg = loc_cMsg + "  " + ALLTRIM(loc_oBO.this_cDirEntrada) + CHR(13) + CHR(13)
518:         loc_cMsg = loc_cMsg + "M" + CHR(225) + "scara Num" + CHR(233) + "rica: " + ALLTRIM(loc_oBO.this_cMascNums) + CHR(13)
519:         loc_cMsg = loc_cMsg + "Arquivos processados na sess" + CHR(227) + "o: " + ;
520:                    TRANSFORM(loc_oBO.this_nArqProcessados)
521: 
522:         MsgInfo(loc_cMsg, "Configura" + CHR(231) + CHR(245) + "es")
523:     ENDPROC
524: 
525:     *--------------------------------------------------------------------------
526:     * BtnExcluirClick - Aborta processamento em andamento e encerra
527:     *
528:     * Em forms CRUD, este botao exclui registro. Neste form OPERACIONAL, aborta
529:     * qualquer polling ativo (desliga modo parametrizado), restaura estado dos
530:     * botoes e fecha o dialogo ? equivalente a "cancelar integracao e sair".
531:     *--------------------------------------------------------------------------
532:     PROCEDURE BtnExcluirClick()
533:         LOCAL loc_lConfirma
534: 
535:         loc_lConfirma = MsgConfirma("Deseja realmente cancelar a integra" + ;
536:             CHR(231) + CHR(227) + "o e encerrar?", "Confirma" + CHR(231) + CHR(227) + "o")
537: 
538:         IF !loc_lConfirma
539:             RETURN
540:         ENDIF
541: 
542:         THIS.this_lParametrizado = .F.
543:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
544:             THIS.this_oBusinessObject.this_lParametrizado = .F.
545:             THIS.this_oBusinessObject.this_lProcessando   = .F.
546:         ENDIF
547: 
548:         THIS.btn_4c_Processar.Enabled = .T.
549:         THIS.btn_4c_Encerrar.Enabled  = .T.
550:         THIS.lbl_4c_Status.Caption    = ""
551: 
552:         THIS.Release()
553:     ENDPROC
554: 
555:     *--------------------------------------------------------------------------
556:     * ConfigurarPaginaLista - N/A para OPERACIONAL sem PageFrame
557:     *
558:     * FormSIGPRMEI eh um dialogo de processamento (500x147) sem PageFrame,
559:     * portanto nao ha Page1/Lista/Grid como em forms CRUD (frmcadastro).
560:     * Metodo mantido pela interface do pipeline de migracao. A construcao
561:     * real dos controles ocorre em ConfigurarCabecalho + ConfigurarBotoes
562:     * + ConfigurarLabels chamados por InicializarForm.
563:     *
564:     * Efeito real: limpa o rotulo de status (equivalente a "recarregar a
565:     * lista" nos forms CRUD - devolve o dialogo ao estado inicial).
566:     *--------------------------------------------------------------------------
567:     PROTECTED PROCEDURE ConfigurarPaginaLista()
568:         IF PEMSTATUS(THIS, "lbl_4c_Status", 5)
569:             THIS.lbl_4c_Status.Caption = ""
570:         ENDIF
571:         IF PEMSTATUS(THIS, "btn_4c_Processar", 5)
572:             THIS.btn_4c_Processar.Enabled = .T.
573:         ENDIF
574:         IF PEMSTATUS(THIS, "btn_4c_Encerrar", 5)
575:             THIS.btn_4c_Encerrar.Enabled = .T.
576:         ENDIF
577:     ENDPROC
578: 
579:     *--------------------------------------------------------------------------
580:     * ConfigurarPaginaDados - Ordem de tabulacao transcrita do SCX legado
581:     *
582:     * FormSIGPRMEI eh um dialogo de processamento (500x147) sem PageFrame: o SCX
583:     * legado nao tem TextBox/EditBox/ComboBox/Grid algum (arvore completa =
584:     * cntSombra + lblSombra/lblTitulo, cmdBtnForm com 2 botoes, Label2, Label1),
585:     * entao nao existe campo de dados a criar - analise.json confirma campos,
586:     * lookups e labels vazios. O trabalho real desta fase eh o TabIndex, que o
587:     * migrador descarta: com AddObject o VFP9 numera pela ORDEM DE CRIACAO, que
588:     * nao tem relacao com a ordem do legado, e isso nao gera erro nem log.
589:     *
590:     * TabIndex declarado no SCX:
591:     *   cmdBtnForm           = 4   CommandGroup - sem TabStop, nao focalizavel
592:     *   cmdBtnForm.Command1  = 2   -> btn_4c_Processar  (Processar)
593:     *   cmdBtnForm.Command2  = 3   -> btn_4c_Encerrar   (Encerrar)
594:     *   Label2 / Label1      = 4   Label nao tem TabStop - TabIndex inerte
595:     *
596:     * Numerar SO os focalizaveis: Label nao tem TabStop (nao recebe foco), logo
597:     * transcrever o TabIndex dos labels seria inerte e ainda EMBARALHARIA a
598:     * sequencia dos controles que de fato param o Tab - por isso os tres "4"
599:     * duplicados do SCX (cmdBtnForm/Label2/Label1) nao sao reproduzidos. Entre
600:     * os dois focalizaveis nao ha empate, e a ordem relativa do legado
601:     * (Command1=2 antes de Command2=3) fica preservada.
602:     *
603:     * Atribuicao em ordem ASCENDENTE: cada atribuicao poe o controle na posicao
604:     * pedida e empurra os demais para tras. Chamado por InicializarForm DEPOIS
605:     * de todos os AddObject - antes disso atribuiria em controle inexistente.
606:     *--------------------------------------------------------------------------
607:     PROTECTED PROCEDURE ConfigurarPaginaDados()
608:         IF PEMSTATUS(THIS, "btn_4c_Processar", 5)
609:             THIS.btn_4c_Processar.TabIndex = 1
610:         ENDIF
611:         IF PEMSTATUS(THIS, "btn_4c_Encerrar", 5)
612:             THIS.btn_4c_Encerrar.TabIndex = 2
613:         ENDIF
614:     ENDPROC
615: 
616:     *--------------------------------------------------------------------------
617:     * AlternarPagina - N/A para OPERACIONAL sem PageFrame
618:     *
619:     * FormSIGPRMEI nao possui PageFrame. Metodo mantido pela interface do
620:     * pipeline de migracao. O parametro representa o modo do dialogo:
621:     *   1 = OCIOSO       (Processar habilitado, aguardando comando do usuario)
622:     *   2 = PROCESSANDO  (Processar desabilitado durante loop de leitura/gravacao)
623:     *--------------------------------------------------------------------------
624:     PROCEDURE AlternarPagina(par_nPagina)
625:         LOCAL loc_lProcessando
626:         loc_lProcessando = (par_nPagina = 2)
627:         IF PEMSTATUS(THIS, "btn_4c_Processar", 5)
628:             THIS.btn_4c_Processar.Enabled = !loc_lProcessando
629:         ENDIF
630:         IF PEMSTATUS(THIS, "btn_4c_Encerrar", 5)
631:             THIS.btn_4c_Encerrar.Enabled = .T.
632:         ENDIF
633:     ENDPROC
634: 
635:     *--------------------------------------------------------------------------
636:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
637:     *--------------------------------------------------------------------------
638:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
639:         LOCAL loc_i, loc_oControl
640: 
641:         FOR loc_i = 1 TO par_oContainer.ControlCount
642:             loc_oControl = par_oContainer.Controls(loc_i)
643:             IF VARTYPE(loc_oControl) = "O"
644:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
645:                     loc_oControl.Visible = .T.
646:                 ENDIF
647:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
648:                     THIS.TornarControlesVisiveis(loc_oControl)
649:                 ENDIF
650:             ENDIF
651:         ENDFOR
652:     ENDPROC
653: 
654:     *--------------------------------------------------------------------------
655:     * BtnBuscarClick - Verifica XMLs em fila no diretorio de entrada
656:     *
657:     * Em forms CRUD, este botao abre busca por registro. Neste form OPERACIONAL,
658:     * varre o diretorio de livros (XMLs de pedidos web) e informa quantos
659:     * arquivos aguardam processamento ? util para diagnostico antes de processar.
660:     *--------------------------------------------------------------------------
661:     PROCEDURE BtnBuscarClick()
662:         LOCAL loc_laDirs[1], loc_lnArq, loc_cDir, loc_cMsg, loc_oBO, loc_oErro, loc_lProsseguir
663:         loc_lProsseguir = .T.
664:         TRY
665:             loc_oBO  = THIS.this_oBusinessObject
666:             loc_cDir = ALLTRIM(loc_oBO.this_cDirLivros)
667: 
668:             IF EMPTY(loc_cDir)
669:                 MsgAviso("Diret" + CHR(243) + "rio de entrada n" + CHR(227) + "o configurado." + CHR(13) + ;
670:                     "Verifique as configura" + CHR(231) + CHR(245) + "es de SigCdPam.", ;
671:                     "Buscar Pedidos")
672:                 loc_lProsseguir = .F.
673:             ENDIF
674: 
675:             IF loc_lProsseguir
676:                 IF RIGHT(loc_cDir, 1) <> "\"
677:                     loc_cDir = loc_cDir + "\"
678:                 ENDIF
679: 
680:                 loc_lnArq = ADIR(loc_laDirs, loc_cDir + "*.XML")
681: 
682:                 IF loc_lnArq = 0
683:                     loc_cMsg = "Nenhum pedido em fila de processamento." + CHR(13) + CHR(13) + ;
684:                         "Diret" + CHR(243) + "rio: " + loc_cDir + CHR(13) + CHR(13) + ;
685:                         "Total processado na sess" + CHR(227) + "o: " + TRANSFORM(loc_oBO.this_nArqProcessados)
686:                     MsgInfo(loc_cMsg, "Buscar Pedidos")
687:                 ELSE
688:                     loc_cMsg = TRANSFORM(loc_lnArq) + " pedido(s) web aguardando processamento." + CHR(13) + CHR(13) + ;
689:                         "Diret" + CHR(243) + "rio: " + loc_cDir + CHR(13) + CHR(13) + ;
690:                         "Total processado na sess" + CHR(227) + "o: " + TRANSFORM(loc_oBO.this_nArqProcessados) + CHR(13) + CHR(13) + ;
691:                         "Clique em Processar para importar os pedidos."
692:                     MsgInfo(loc_cMsg, "Buscar Pedidos")
693:                 ENDIF
694:             ENDIF
695:         CATCH TO loc_oErro
696:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
697:                 " PROC=" + loc_oErro.Procedure, "FormSIGPRMEI.BtnBuscarClick")
698:         ENDTRY
699:     ENDPROC
700: 
701:     *--------------------------------------------------------------------------
702:     * BtnSalvarClick - Executa um ciclo de processamento (equivalente a Processar)
703:     *
704:     * Em forms CRUD, salva dados editados. Neste form OPERACIONAL, executa
705:     * imediatamente UM ciclo de leitura+gravacao (LerArquivos + GravarArquivos),
706:     * sem entrar no loop continuo do BtnProcessar ? para uso manual pontual.
707:     *--------------------------------------------------------------------------
708:     PROCEDURE BtnSalvarClick()
709:         THIS.BtnIncluirClick()
710:     ENDPROC
711: 
712:     *--------------------------------------------------------------------------
713:     * BtnCancelarClick - Interrompe processamento em andamento
714:     *
715:     * Em forms CRUD, cancela edicao em curso. Neste form OPERACIONAL, desativa
716:     * o modo automatico (parametrizado) para que o loop do BtnProcessar encerre
717:     * no proximo ciclo, restaurando o dialogo ao estado de repouso.
718:     *--------------------------------------------------------------------------
719:     PROCEDURE BtnCancelarClick()
720:         THIS.this_lParametrizado = .F.
721:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
722:             THIS.this_oBusinessObject.this_lParametrizado = .F.
723:             THIS.this_oBusinessObject.this_lProcessando   = .F.
724:         ENDIF
725:         IF PEMSTATUS(THIS, "lbl_4c_Status", 5)
726:             THIS.lbl_4c_Status.Caption = "Processamento cancelado."
727:         ENDIF
728:         THIS.AjustarBotoesPorModo()
729:     ENDPROC
730: 
731:     *--------------------------------------------------------------------------
732:     * FormParaBO - Sincroniza estado do form para o BO
733:     *
734:     * Form OPERACIONAL sem campos de entrada: sincroniza apenas o flag de
735:     * modo automatico (this_lParametrizado) entre o dialogo e o BO.
736:     *--------------------------------------------------------------------------
737:     PROTECTED PROCEDURE FormParaBO()
738:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
739:             THIS.this_oBusinessObject.this_lParametrizado = THIS.this_lParametrizado
740:         ENDIF
741:         RETURN .T.
742:     ENDPROC
743: 
744:     *--------------------------------------------------------------------------
745:     * BOParaForm - Sincroniza estado do BO para o form
746:     *
747:     * Form OPERACIONAL sem campos editaveis: atualiza o label de status com
748:     * a ultima mensagem gerada pelo BO durante o processamento.
749:     *--------------------------------------------------------------------------
750:     PROTECTED PROCEDURE BOParaForm()
751:         LOCAL loc_oBO
752:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
753:             loc_oBO = THIS.this_oBusinessObject
754:             IF PEMSTATUS(THIS, "lbl_4c_Status", 5) AND !EMPTY(ALLTRIM(loc_oBO.this_cUltStatus))
755:                 THIS.lbl_4c_Status.Caption = loc_oBO.this_cUltStatus
756:             ENDIF
757:         ENDIF
758:         RETURN .T.
759:     ENDPROC
760: 
761:     *--------------------------------------------------------------------------
762:     * HabilitarCampos - Habilita/desabilita botoes conforme modo de operacao
763:     *
764:     * par_cModo: "IDLE"        -> Processar habilitado, aguardando
765:     *            "PROCESSANDO" -> Processar desabilitado durante loop
766:     *--------------------------------------------------------------------------
767:     PROTECTED PROCEDURE HabilitarCampos(par_cModo)
768:         LOCAL loc_lIdle
769:         loc_lIdle = (UPPER(ALLTRIM(par_cModo)) = "IDLE" OR EMPTY(par_cModo))
770: 
771:         IF PEMSTATUS(THIS, "btn_4c_Processar", 5)
772:             THIS.btn_4c_Processar.Enabled = loc_lIdle
773:         ENDIF
774:         IF PEMSTATUS(THIS, "btn_4c_Encerrar", 5)
775:             THIS.btn_4c_Encerrar.Enabled = .T.
776:         ENDIF
777:     ENDPROC
778: 
779:     *--------------------------------------------------------------------------
780:     * LimparCampos - Reseta o status do dialogo para o estado inicial
781:     *--------------------------------------------------------------------------
782:     PROTECTED PROCEDURE LimparCampos()
783:         IF PEMSTATUS(THIS, "lbl_4c_Status", 5)
784:             THIS.lbl_4c_Status.Caption = ""
785:         ENDIF
786:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
787:             THIS.this_oBusinessObject.this_cUltStatus = ""
788:         ENDIF
789:     ENDPROC
790: 
791:     *--------------------------------------------------------------------------
792:     * CarregarLista - Atualiza o dialogo com estado atual do BO
793:     *
794:     * Forms CRUD usam este metodo para recarregar o grid. Neste form
795:     * OPERACIONAL, sincroniza o status label com o ultimo estado do BO
796:     * e restaura os botoes para o modo de repouso (IDLE).
797:     *--------------------------------------------------------------------------
798:     PROCEDURE CarregarLista()
799:         THIS.BOParaForm()
800:         THIS.AjustarBotoesPorModo()
801:         RETURN .T.
802:     ENDPROC
803: 
804:     *--------------------------------------------------------------------------
805:     * AjustarBotoesPorModo - Restaura botoes ao modo de repouso (IDLE)
806:     *
807:     * Em forms CRUD, ajusta botoes conforme modo INCLUIR/ALTERAR/VISUALIZAR.
808:     * Neste form OPERACIONAL, restaura sempre ao estado IDLE (Processar
809:     * habilitado, Encerrar habilitado) apos conclusao de qualquer operacao.
810:     *--------------------------------------------------------------------------
811:     PROCEDURE AjustarBotoesPorModo()
812:         THIS.HabilitarCampos("IDLE")
813:     ENDPROC
814: 
815:     *--------------------------------------------------------------------------
816:     PROCEDURE Destroy()
817:     *--------------------------------------------------------------------------
818:         LOCAL loc_oErro
819:         TRY
820:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
821:                 THIS.this_oBusinessObject = .NULL.
822:             ENDIF
823:         CATCH TO loc_oErro
824:             MsgErro(loc_oErro.Message, "FormSIGPRMEI.Destroy")
825:         ENDTRY
826:         DODEFAULT()
827:     ENDPROC
828: 
829: ENDDEFINE

