# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (7)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CONTAINER1. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [NAVEGACAO-PAGINA] Metodo 'Receber' faz ActivePage=2 mas NAO le dados de cursor nem chama CarregarHistorico/CarregarDados. Em forms OPERACIONAL, a navegacao para Page2 DEVE carregar dados da linha selecionada no grid de Page1 (padrao legado: cmd_consulta.Click le do cursor do grid).
- [LAYOUT-POSITION] Controle 'cmdtran' (parent: SIGPRFTP): Top original=12 vs migrado 'cmd_4c_Cmdtransfere' Top=83 (diff=71px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'cmdtran' (parent: SIGPRFTP): Left original=99 vs migrado 'cmd_4c_Cmdtransfere' Left=299 (diff=200px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'cmdsair' (parent: SIGPRFTP): Left original=701 vs migrado 'cmd_4c_Cmdsair' Left=917 (diff=216px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'cmdrec' (parent: SIGPRFTP): Top original=12 vs migrado 'cmd_4c_Cmdrecebe' Top=116 (diff=104px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'cmdrec' (parent: SIGPRFTP): Left original=174 vs migrado 'cmd_4c_Cmdrecebe' Left=299 (diff=125px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprftp.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2654 linhas total):

*-- Linhas 11 a 54:
11: *   CODE -> arquitetura em camadas (FormBase / sigprftpBO)
12: *
13: * CHAMADA (via menu.prg):
14: *   loForm = CREATEOBJECT("Formsigprftp")
15: *   IF VARTYPE(loForm) = "O"
16: *       loForm.Show()
17: *   ENDIF
18: *
19: * IMPLEMENTACAO COMPLETA (fases 3-5):
20: *   Estrutura base, controles visuais, grids, botoes, handlers de eventos
21: *   (Transfere, Receber, MontarContainer, GetFtpDirectory, RasftpGet/Put)
22: *==============================================================================
23: 
24: DEFINE CLASS Formsigprftp AS FormBase
25: 
26:     *-- Dimensoes do form (1000px - padrao do sistema, adaptado do legado 800px)
27:     this_cMensagemErro = ""
28:     Width    = 1000
29:     Height   = 600
30: 
31:     *-- Propriedades visuais herdadas do legado (identico ao SCX original)
32:     AutoCenter  = .T.
33:     ShowTips    = .T.
34:     TitleBar    = 0
35:     ShowWindow = 1
36:     ControlBox  = .F.
37:     Closable    = .F.
38:     MaxButton   = .F.
39:     MinButton   = .F.
40:     WindowType  = 1
41:     Themes      = .F.
42:     KeyPreview  = .T.
43:     DataSession = 1
44: 
45:     *-- Business Object
46:     this_oBusinessObject = .NULL.
47: 
48:     *-- Configuracao de conexao FTP
49:     this_cTpConnect  = ""    && "D"=Dial-Up  "B"=Broadband/Direto
50:     this_cFtpAdd     = ""    && endereco do servidor FTP
51:     this_cFtpUser    = ""    && usuario FTP
52:     this_cFtpPass    = ""    && senha FTP
53: 
54:     *-- Diretorios locais (drive/pasta no PC)

*-- Linhas 82 a 216:
82:     this_lAlternandoPagina = .F.
83: 
84:     *==========================================================================
85:     PROCEDURE Init
86:     *==========================================================================
87:         RETURN DODEFAULT()
88:     ENDPROC
89: 
90:     *==========================================================================
91:     PROTECTED PROCEDURE InicializarForm
92:     *==========================================================================
93:         LOCAL loc_lSucesso, loc_oErro
94:         loc_lSucesso = .F.
95:         TRY
96:             *-- 1. Criar cursores de log (logftp) e progresso (tmpprog)
97:             THIS.CriarCursores()
98: 
99:             *-- 2. Criar Business Object
100:             THIS.this_oBusinessObject = CREATEOBJECT("sigprftpBO")
101:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
102: 
103:                 *-- 3. Aplicar propriedades visuais do form
104:                 THIS.ConfigurarForm()
105: 
106:                 *-- 4. Criar estrutura base: Container principal com 2 PageFrames
107:                 *--    (pgfloc = arquivos locais, pgfftp = arquivos remotos FTP)
108:                 THIS.ConfigurarPageFrame()
109: 
110:                 *-- 5. Configurar controles operacionais (botoes, grids, conteudo das paginas)
111:                 THIS.ConfigurarPaginaLista()
112: 
113:                 *-- 6. Carregar parametros FTP do banco (pular em modo validacao UI)
114:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
115:                     THIS.CarregarParametros()
116:                 ENDIF
117: 
118:                 loc_lSucesso = .T.
119:             ELSE
120:                 THIS.this_cMensagemErro = "Erro ao criar sigprftpBO"
121:             ENDIF
122:         CATCH TO loc_oErro
123:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
124:                     " PROC=" + loc_oErro.Procedure, "Erro")
125:             loc_lSucesso = .F.
126:         ENDTRY
127:         RETURN loc_lSucesso
128:     ENDPROC
129: 
130:     *==========================================================================
131:     * CriarCursores - Cria cursores de log e progresso utilizados pelo form
132:     * Equivalente ao evento Load() do legado (sigprftp.SCX)
133:     * Cursores:
134:     *   logftp  (memo C(254), cor C(1))     - log de operacoes do FTP
135:     *   tmpprog (file/size/local/host/status) - progresso das transferencias
136:     *==========================================================================
137:     PROTECTED PROCEDURE CriarCursores
138:         IF !USED("logftp")
139:             SELECT 0
140:             CREATE CURSOR logftp (memo C(254), cor C(1))
141:         ENDIF
142:         IF !USED("tmpprog")
143:             SELECT 0
144:             CREATE CURSOR tmpprog (file   C(254), ;
145:                                    Size   N(12),  ;
146:                                    Local  C(254), ;
147:                                    Host   C(254), ;
148:                                    Status C(50))
149:         ENDIF
150:     ENDPROC
151: 
152:     *==========================================================================
153:     * ConfigurarForm - Define propriedades visuais do form (background, fonte)
154:     *==========================================================================
155:     PROTECTED PROCEDURE ConfigurarForm
156:         LOCAL loc_cBackground
157:         loc_cBackground = gc_4c_CaminhoIcones + "new_background.jpg"
158:         WITH THIS
159:             .FontName  = "Tahoma"
160:             .FontSize  = 8
161:             .BackColor = RGB(100, 100, 100)
162:             IF FILE(loc_cBackground)
163:                 .Picture = loc_cBackground
164:             ENDIF
165:         ENDWITH
166:     ENDPROC
167: 
168:     *==========================================================================
169:     * ConfigurarPageFrame - Cria estrutura base do form OPERACIONAL:
170:     *   cnt_4c_Container1 (Container principal - abriga PageFrames)
171:     *     pgf_4c_Loc  (2 paginas: envio local, recebimento local)
172:     *     pgf_4c_Ftp  (2 paginas: recebimento FTP, envio FTP)
173:     * Layout replicado do legado (Container1 no SCX original)
174:     * Fases posteriores populam ListBoxes, TextBoxes e botoes de navegacao.
175:     *==========================================================================
176:     PROTECTED PROCEDURE ConfigurarPageFrame
177:         LOCAL loc_oCnt, loc_oPgLoc, loc_oPgFtp
178: 
179:         *-- Container principal (equivalente ao Container1 do legado)
180:         THIS.AddObject("cnt_4c_Container1", "Container")
181:         loc_oCnt = THIS.cnt_4c_Container1
182:         WITH loc_oCnt
183:             .Top         = 128
184:             .Left        = 88
185:             .Width       = 620
186:             .Height      = 194
187:             .BackStyle   = 0
188:             .BorderWidth = 0
189:             .Visible     = .T.
190:         ENDWITH
191: 
192:         *-- PageFrame LOCAL (pgfloc - pastas locais do PC)
193:         *--   Page1 = Envio Local (arquivos para enviar ao FTP)
194:         *--   Page2 = Recebimento Local (destino de arquivos vindos do FTP)
195:         loc_oCnt.AddObject("pgf_4c_Loc", "PageFrame")
196:         loc_oPgLoc = loc_oCnt.pgf_4c_Loc
197:         WITH loc_oPgLoc
198:             .Top        = 4
199:             .Left       = 3
200:             .Width      = 294
201:             .Height     = 186
202:             .PageCount  = 2
203:             .Tabs       = .T.
204:             .TabStyle   = 0
205:             .Themes     = .F.
206:             .Visible    = .T.
207:         ENDWITH
208:         loc_oPgLoc.Page1.Caption = "Envio Local"
209:         loc_oPgLoc.Page2.Caption = "Recebimento Local"
210: 
211:         *-- PageFrame FTP (pgfftp - pastas remotas no servidor FTP)
212:         *--   Page1 = Recebimento FTP (arquivos remotos p/ baixar)
213:         *--   Page2 = Envio FTP (destino remoto de arquivos enviados)
214:         loc_oCnt.AddObject("pgf_4c_Ftp", "PageFrame")
215:         loc_oPgFtp = loc_oCnt.pgf_4c_Ftp
216:         WITH loc_oPgFtp

*-- Linhas 228 a 283:
228:         loc_oPgFtp.Page2.Caption = "Envio FTP"
229: 
230:         *-- Tornar filhos visiveis (AddObject cria com Visible=.F.)
231:         THIS.TornarControlesVisiveis(loc_oCnt)
232:     ENDPROC
233: 
234:     *==========================================================================
235:     * CarregarParametros - Carrega configuracao FTP do banco via sigprftpBO
236:     * Sequencia:
237:     *   1. Parametros globais de SigCdPam (empresa master, grupos, etc.)
238:     *   2. Configuracao FTP da empresa corrente de SigCdEmp
239:     *   3. Normaliza separadores de diretorio
240:     *   4. Detecta modo de operacao (so envio / so recebimento)
241:     * Retorno: .T. se configuracao carregada com sucesso
242:     *==========================================================================
243:     PROTECTED PROCEDURE CarregarParametros
244:         LOCAL loc_lSucesso, loc_oBO, loc_oErro
245:         loc_lSucesso = .F.
246:         TRY
247:             loc_oBO = THIS.this_oBusinessObject
248: 
249:             *-- Carregar parametros globais de SigCdPam (nao critico - pode nao ter)
250:             IF !loc_oBO.CarregarParametrosSistema()
251:                 THIS.Inf("Aviso: " + loc_oBO.this_cMensagemErro, "R")
252:             ENDIF
253: 
254:             *-- Carregar configuracao FTP da empresa corrente de SigCdEmp
255:             IF loc_oBO.CarregarConfiguracaoEmpresa(go_4c_Sistema.cCodEmpresa)
256: 
257:                 *-- Transferir propriedades do BO para o form
258:                 THIS.this_cTpConnect = UPPER(ALLTRIM(loc_oBO.this_cTpConexaoEmp))
259:                 THIS.this_cFtpAdd    = LOWER(ALLTRIM(loc_oBO.this_cFtpAddEmp))
260:                 THIS.this_cFtpUser   = LOWER(ALLTRIM(loc_oBO.this_cFtpUserEmp))
261:                 THIS.this_cFtpPass   = LOWER(ALLTRIM(loc_oBO.this_cFtpPassEmp))
262:                 THIS.this_cDirEnvFtp = LOWER(ALLTRIM(loc_oBO.this_cDriveTs))
263:                 THIS.this_cDirRecFtp = LOWER(ALLTRIM(loc_oBO.this_cDriveLs))
264:                 THIS.this_cDirRecLoc = LOWER(ALLTRIM(loc_oBO.this_cDirFtpTs))
265:                 THIS.this_cDirEnvLoc = LOWER(ALLTRIM(loc_oBO.this_cDirFtpLs))
266:                 THIS.this_lDelLocal  = loc_oBO.this_lLocDel
267:                 THIS.this_lDelHost   = loc_oBO.this_lFtpDel
268: 
269:                 *-- Normalizar separador de diretorio local (trailing backslash)
270:                 IF !EMPTY(THIS.this_cDirEnvFtp)
271:                     THIS.this_cDirEnvFtp = ADDBS(THIS.this_cDirEnvFtp)
272:                 ENDIF
273:                 IF !EMPTY(THIS.this_cDirRecFtp)
274:                     THIS.this_cDirRecFtp = ADDBS(THIS.this_cDirRecFtp)
275:                 ENDIF
276: 
277:                 *-- Normalizar separador de diretorio remoto FTP (trailing slash)
278:                 IF !EMPTY(THIS.this_cDirRecLoc) AND RIGHT(THIS.this_cDirRecLoc, 1) <> "/"
279:                     THIS.this_cDirRecLoc = THIS.this_cDirRecLoc + "/"
280:                 ENDIF
281:                 IF !EMPTY(THIS.this_cDirEnvLoc) AND RIGHT(THIS.this_cDirEnvLoc, 1) <> "/"
282:                     THIS.this_cDirEnvLoc = THIS.this_cDirEnvLoc + "/"
283:                 ENDIF

*-- Linhas 300 a 562:
300:             ENDIF
301:         CATCH TO loc_oErro
302:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
303:                     " PROC=" + loc_oErro.Procedure, "Erro")
304:             loc_lSucesso = .F.
305:         ENDTRY
306:         RETURN loc_lSucesso
307:     ENDPROC
308: 
309:     *==========================================================================
310:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
311:     * Utilizacao: chamar apos AddObject das pages/containers
312:     * par_oContainer: container (Page, Container) cujos filhos serao ativados
313:     *==========================================================================
314:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
315:         LOCAL loc_i, loc_oControl
316:         FOR loc_i = 1 TO par_oContainer.ControlCount
317:             loc_oControl = par_oContainer.Controls(loc_i)
318:             IF VARTYPE(loc_oControl) = "O"
319:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
320:                    loc_oControl.ControlCount > 0
321:                     THIS.TornarControlesVisiveis(loc_oControl)
322:                 ENDIF
323:                 IF INLIST(UPPER(loc_oControl.Name), "CNT_4C_CONTAINER1")
324:                     LOOP
325:                 ENDIF
326:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
327:                     loc_oControl.Visible = .T.
328:                 ENDIF
329:             ENDIF
330:         ENDFOR
331:     ENDPROC
332: 
333:     *==========================================================================
334:     * Inf - Adiciona mensagem ao cursor logftp (exibido no grd_4c_GrdInf)
335:     * par_cMensagem: texto da mensagem
336:     * par_cCor: "R"=vermelho(erro), "G"=verde(sucesso), "B"=azul(informativo)
337:     * Equivalente ao procedimento Inf() do legado sigprftp.SCX
338:     *==========================================================================
339:     PROCEDURE Inf(par_cMensagem, par_cCor)
340:         IF USED("logftp")
341:             SELECT logftp
342:             APPEND BLANK
343:             REPLACE memo WITH par_cMensagem
344:             REPLACE cor  WITH par_cCor
345:             GO BOTTOM IN logftp
346:             IF VARTYPE(THIS.grd_4c_GrdInf) = "O"
347:                 THIS.grd_4c_GrdInf.Refresh()
348:             ENDIF
349:         ENDIF
350:     ENDPROC
351: 
352:     *==========================================================================
353:     * ConfigurarPaginaLista - Orquestra criacao dos controles operacionais FTP.
354:     * Chamado de InicializarForm apos ConfigurarPageFrame.
355:     * Cria: botoes superiores, conteudo das paginas dos PageFrames,
356:     *        setas de transferencia individual, grid de log (grd_4c_GrdInf).
357:     *==========================================================================
358:     PROTECTED PROCEDURE ConfigurarPaginaLista
359:         *-- Grupo 1: Botoes de acao (superior, transferencia intermediaria, rodape)
360:         THIS.ConfigurarBotoesSuperiores()
361:         THIS.ConfigurarBotoesTransferencia()
362:         THIS.ConfigurarRodape()
363: 
364:         *-- Grupo 2: Areas de dados (conteudo das paginas + grids de log e progresso)
365:         THIS.ConfigurarPaginaDados()
366:     ENDPROC
367: 
368:     *==========================================================================
369:     * ConfigurarPaginaDados - Configura as areas de dados (conteudo) do form:
370:     *   - Conteudo do pgf_4c_Loc (ListBoxes de arquivos locais + paths + botoes ...)
371:     *   - Conteudo do pgf_4c_Ftp (ListBoxes de arquivos remotos + paths + botoes ...)
372:     *   - grd_4c_GrdInf (grid de log de operacoes/mensagens)
373:     *   - grd_4c_GrdProc (grid de progresso das transferencias)
374:     * Em forms OPERACIONAIS a "pagina de dados" nao segue o padrao CRUD
375:     * (Page1=Lista/Page2=Dados). Aqui "dados" = todas as areas que EXIBEM ou
376:     * MANIPULAM dados (arquivos, log, progresso), em oposicao as areas de
377:     * ACAO/COMANDO (botoes). Esta separacao facilita manutencao e permite
378:     * recriar apenas as areas de dados sem tocar nos botoes ja instanciados.
379:     *==========================================================================
380:     PROTECTED PROCEDURE ConfigurarPaginaDados
381:         *-- Conteudo do PageFrame LOCAL (pgfloc)
382:         *--   Page1 "A Enviar"    = txt_4c_Direnvftp + cmd_4c_Cmdbrowloc + lst_4c_Lstenvftp
383:         *--   Page2 "Recebidos"   = txt_4c_Dirrecftp + cmd_4c_Cmdbrowloc + lst_4c_Lstrecftp
384:         THIS.ConfigurarConteudoPgLoc()
385: 
386:         *-- Conteudo do PageFrame FTP (pgfftp)
387:         *--   Page1 "A Baixar"    = txt_4c_Dirrecloc + cmd_4c_Cmdbrowftp + lst_4c_Lstrecloc
388:         *--   Page2 "Enviados"    = txt_4c_Direnvloc + cmd_4c_Cmdbrowftp + lst_4c_Lstenvloc
389:         THIS.ConfigurarConteudoPgFtp()
390: 
391:         *-- Grid de log (GrdInf): mensagens de status coloridas (logftp.cor)
392:         THIS.ConfigurarGrdInf()
393: 
394:         *-- Grid de progresso (GrdProc): arquivo/tamanho/local/host/status (tmpprog)
395:         THIS.ConfigurarGrdProc()
396:     ENDPROC
397: 
398:     *==========================================================================
399:     * ConfigurarBotoesSuperiores - Cria botoes de acao no topo do form:
400:     *   cmd_4c_Cmdload  (Conecta - carrega listagens FTP e local)
401:     *   cmd_4c_Cmdtran  (Transfere - envia todos para FTP)
402:     *   cmd_4c_Cmdrec   (Recebe - baixa todos do FTP)
403:     *   cmd_4c_Cmdsair  (Encerrar - posicao canonica 917)
404:     *   shp_4c_Shape1   (Shape decorativo ao redor do Encerrar)
405:     * Posicoes proporcional ao SCX original (800px -> 1000px).
406:     *==========================================================================
407:     PROTECTED PROCEDURE ConfigurarBotoesSuperiores
408:         LOCAL loc_cIcones, loc_cBmps
409:         loc_cIcones = gc_4c_CaminhoIcones
410:         loc_cBmps   = gc_4c_CaminhoIcones + "..\vbmp\"
411: 
412:         *-- Shape decorativo ao redor do botao Encerrar
413:         THIS.AddObject("shp_4c_Shape1", "Shape")
414:         WITH THIS.shp_4c_Shape1
415:             .Top         = 7
416:             .Left        = 912
417:             .Width       = 90
418:             .Height      = 110
419:             .BackStyle   = 0
420:             .BorderStyle = 0
421:             .BorderColor = RGB(0, 0, 0)
422:             .Visible     = .T.
423:         ENDWITH
424: 
425:         *-- Botao Conecta (cmdload) - carrega listagens FTP e locais
426:         THIS.AddObject("cmd_4c_Cmdload", "CommandButton")
427:         WITH THIS.cmd_4c_Cmdload
428:             .Top             = 12
429:             .Left            = 23
430:             .Width           = 75
431:             .Height          = 75
432:             .Caption         = CHR(92) + "<Conecta"
433:             .FontName        = "Tahoma"
434:             .FontSize        = 8
435:             .FontBold        = .T.
436:             .FontItalic      = .T.
437:             .ForeColor       = RGB(90, 90, 90)
438:             .BackColor       = RGB(255, 255, 255)
439:             .Themes          = .T.
440:             .SpecialEffect   = 0
441:             .WordWrap        = .T.
442:             .AutoSize        = .F.
443:             .PicturePosition = 13
444:             .MousePointer    = 15
445:             .Visible         = .T.
446:         ENDWITH
447:         BINDEVENT(THIS.cmd_4c_Cmdload, "Click", THIS, "CmdCmdloadClick")
448: 
449:         *-- Botao Transfere (cmdtran) - envia todos os arquivos para o FTP
450:         THIS.AddObject("cmd_4c_Cmdtran", "CommandButton")
451:         WITH THIS.cmd_4c_Cmdtran
452:             .Top             = 12
453:             .Left            = 103
454:             .Width           = 75
455:             .Height          = 75
456:             .Caption         = CHR(92) + "<Transfere"
457:             .FontName        = "Tahoma"
458:             .FontSize        = 8
459:             .FontBold        = .T.
460:             .FontItalic      = .T.
461:             .ForeColor       = RGB(90, 90, 90)
462:             .BackColor       = RGB(255, 255, 255)
463:             .Themes          = .T.
464:             .SpecialEffect   = 0
465:             .WordWrap        = .T.
466:             .AutoSize        = .F.
467:             .PicturePosition = 13
468:             .MousePointer    = 15
469:             .Visible         = .T.
470:         ENDWITH
471:         BINDEVENT(THIS.cmd_4c_Cmdtran, "Click", THIS, "CmdCmdtranClick")
472: 
473:         *-- Botao Recebe (cmdrec) - baixa todos os arquivos do FTP
474:         THIS.AddObject("cmd_4c_Cmdrec", "CommandButton")
475:         WITH THIS.cmd_4c_Cmdrec
476:             .Top             = 12
477:             .Left            = 183
478:             .Width           = 75
479:             .Height          = 75
480:             .Caption         = CHR(92) + "<Recebe"
481:             .FontName        = "Tahoma"
482:             .FontSize        = 8
483:             .FontBold        = .T.
484:             .FontItalic      = .T.
485:             .ForeColor       = RGB(90, 90, 90)
486:             .BackColor       = RGB(255, 255, 255)
487:             .Themes          = .T.
488:             .SpecialEffect   = 0
489:             .WordWrap        = .T.
490:             .AutoSize        = .F.
491:             .PicturePosition = 13
492:             .MousePointer    = 15
493:             .Visible         = .T.
494:         ENDWITH
495:         BINDEVENT(THIS.cmd_4c_Cmdrec, "Click", THIS, "CmdCmdrecClick")
496: 
497:         *-- Botao Encerrar (cmdsair) - posicao canonica CLAUDE.md
498:         THIS.AddObject("cmd_4c_Cmdsair", "CommandButton")
499:         WITH THIS.cmd_4c_Cmdsair
500:             .Top             = 12
501:             .Left            = 917
502:             .Width           = 75
503:             .Height          = 75
504:             .Caption         = "Encerrar"
505:             .Cancel          = .T.
506:             .Picture         = loc_cIcones + "cadastro_sair_60.jpg"
507:             .DisabledPicture = loc_cIcones + "cadastro_sair_60.jpg"
508:             .FontName        = "Tahoma"
509:             .FontSize        = 8
510:             .FontBold        = .T.
511:             .FontItalic      = .T.
512:             .ForeColor       = RGB(90, 90, 90)
513:             .BackColor       = RGB(255, 255, 255)
514:             .Themes          = .T.
515:             .SpecialEffect   = 0
516:             .PicturePosition = 13
517:             .WordWrap        = .T.
518:             .AutoSize        = .F.
519:             .MousePointer    = 15
520:             .Visible         = .T.
521:         ENDWITH
522:         BINDEVENT(THIS.cmd_4c_Cmdsair, "Click", THIS, "CmdCmdsairClick")
523: 
524:         *-- Imagens dos botoes de acao (vbmp/ do legado)
525:         IF FILE(loc_cBmps + "a_arrow1.bmp")
526:             THIS.cmd_4c_Cmdload.Picture         = loc_cBmps + "a_arrow1.bmp"
527:             THIS.cmd_4c_Cmdload.DisabledPicture = loc_cBmps + "a_arrow1.bmp"
528:         ENDIF
529:         IF FILE(loc_cBmps + "baix_aut.bmp")
530:             THIS.cmd_4c_Cmdtran.Picture         = loc_cBmps + "baix_aut.bmp"
531:             THIS.cmd_4c_Cmdtran.DisabledPicture = loc_cBmps + "baix_aut.bmp"
532:         ENDIF
533:         IF FILE(loc_cBmps + "d_disk1.bmp")
534:             THIS.cmd_4c_Cmdrec.Picture         = loc_cBmps + "d_disk1.bmp"
535:             THIS.cmd_4c_Cmdrec.DisabledPicture = loc_cBmps + "d_disk1.bmp"
536:         ENDIF
537: 
538:         *-- Labels "MASTER" (decorativos, variam por empresa - ocultos por default)
539:         THIS.AddObject("lbl_4c_Label8", "Label")
540:         WITH THIS.lbl_4c_Label8
541:             .Top       = 138
542:             .Left      = 805
543:             .Caption   = "MASTER"
544:             .FontName  = "Verdana"
545:             .FontSize  = 8
546:             .FontBold  = .T.
547:             .ForeColor = RGB(0, 255, 0)
548:             .BackStyle = 0
549:             .Visible   = .F.
550:         ENDWITH
551: 
552:         THIS.AddObject("lbl_4c_Label9", "Label")
553:         WITH THIS.lbl_4c_Label9
554:             .Top       = 137
555:             .Left      = 804
556:             .Caption   = "MASTER"
557:             .FontName  = "Verdana"
558:             .FontSize  = 8
559:             .FontBold  = .T.
560:             .ForeColor = RGB(255, 0, 0)
561:             .BackStyle = 0
562:             .Visible   = .F.

*-- Linhas 569 a 739:
569:     *   Page2 ("Recebidos")   = arquivos locais recebidos do FTP
570:     * Cada pagina: TextBox (caminho) + botao "..." + ListBox (arquivos)
571:     *==========================================================================
572:     PROTECTED PROCEDURE ConfigurarConteudoPgLoc
573:         LOCAL loc_oPgLoc, loc_oPage1, loc_oPage2
574:         loc_oPgLoc = THIS.cnt_4c_Container1.pgf_4c_Loc
575: 
576:         *-- Captions e cores das abas (do SCX original)
577:         loc_oPgLoc.Page1.Caption   = "A Enviar"
578:         loc_oPgLoc.Page1.FontBold  = .T.
579:         loc_oPgLoc.Page1.FontName  = "Verdana"
580:         loc_oPgLoc.Page1.FontSize  = 8
581:         loc_oPgLoc.Page1.BackColor = RGB(255, 255, 255)
582:         loc_oPgLoc.Page1.ForeColor = RGB(0, 0, 255)
583:         loc_oPgLoc.Page2.Caption   = "Recebidos"
584:         loc_oPgLoc.Page2.FontBold  = .T.
585:         loc_oPgLoc.Page2.FontName  = "Verdana"
586:         loc_oPgLoc.Page2.FontSize  = 8
587:         loc_oPgLoc.Page2.BackColor = RGB(255, 255, 255)
588:         loc_oPgLoc.Page2.ForeColor = RGB(255, 0, 0)
589: 
590:         *-- PAGE 1: A Enviar (arquivos locais que serao enviados ao FTP)
591:         loc_oPage1 = loc_oPgLoc.Page1
592:         loc_oPage1.AddObject("txt_4c_Direnvftp", "TextBox")
593:         WITH loc_oPage1.txt_4c_Direnvftp
594:             .Top      = 2
595:             .Left     = 2
596:             .Width    = 217
597:             .Height   = 23
598:             .Value    = ""
599:             .FontName = "Verdana"
600:             .FontSize = 8
601:             .ReadOnly = .T.
602:             .Visible  = .T.
603:         ENDWITH
604: 
605:         loc_oPage1.AddObject("cmd_4c_BrowlocEnvio", "CommandButton")
606:         WITH loc_oPage1.cmd_4c_BrowlocEnvio
607:             .Top      = 2
608:             .Left     = 222
609:             .Width    = 22
610:             .Height   = 22
611:             .Caption  = "..."
612:             .Enabled  = .F.
613:             .FontName = "Verdana"
614:             .FontSize = 8
615:             .ForeColor = RGB(36, 84, 155)
616:             .BackColor = RGB(255, 255, 255)
617:             .Themes   = .F.
618:             .Visible  = .T.
619:         ENDWITH
620:         BINDEVENT(loc_oPage1.cmd_4c_BrowlocEnvio, "Click", THIS, "CmdBrowlocEnvioClick")
621: 
622:         loc_oPage1.AddObject("obj_4c_Lstenvftp", "ListBox")
623:         WITH loc_oPage1.obj_4c_Lstenvftp
624:             .Top          = 26
625:             .Left         = 2
626:             .Width        = 286
627:             .Height       = 130
628:             .ColumnCount  = 3
629:             .ColumnWidths = "130,62,83"
630:             .ColumnLines  = .T.
631:             .RowSourceType = 0
632:             .MultiSelect  = .T.
633:             .FontName     = "Verdana"
634:             .FontSize     = 8
635:             .Visible      = .T.
636:         ENDWITH
637: 
638:         *-- PAGE 2: Recebidos (destino local dos arquivos recebidos do FTP)
639:         loc_oPage2 = loc_oPgLoc.Page2
640:         loc_oPage2.AddObject("txt_4c_Dirrecftp", "TextBox")
641:         WITH loc_oPage2.txt_4c_Dirrecftp
642:             .Top      = 2
643:             .Left     = 2
644:             .Width    = 217
645:             .Height   = 23
646:             .Value    = ""
647:             .FontName = "Verdana"
648:             .FontSize = 8
649:             .ReadOnly = .T.
650:             .Visible  = .T.
651:         ENDWITH
652: 
653:         loc_oPage2.AddObject("cmd_4c_BrowlocReceb", "CommandButton")
654:         WITH loc_oPage2.cmd_4c_BrowlocReceb
655:             .Top      = 2
656:             .Left     = 222
657:             .Width    = 22
658:             .Height   = 22
659:             .Caption  = "..."
660:             .Enabled  = .F.
661:             .FontName = "Verdana"
662:             .FontSize = 8
663:             .ForeColor = RGB(36, 84, 155)
664:             .BackColor = RGB(255, 255, 255)
665:             .Themes   = .F.
666:             .Visible  = .T.
667:         ENDWITH
668:         BINDEVENT(loc_oPage2.cmd_4c_BrowlocReceb, "Click", THIS, "CmdBrowlocRecebClick")
669: 
670:         loc_oPage2.AddObject("obj_4c_Lstrecftp", "ListBox")
671:         WITH loc_oPage2.obj_4c_Lstrecftp
672:             .Top          = 26
673:             .Left         = 2
674:             .Width        = 286
675:             .Height       = 130
676:             .ColumnCount  = 3
677:             .ColumnWidths = "135,58,82"
678:             .ColumnLines  = .T.
679:             .RowSourceType = 0
680:             .MultiSelect  = .T.
681:             .FontName     = "Verdana"
682:             .FontSize     = 8
683:             .Visible      = .T.
684:         ENDWITH
685: 
686:         BINDEVENT(loc_oPgLoc.Page1, "Activate", THIS, "PgLocPage1Activate")
687:         BINDEVENT(loc_oPgLoc.Page2, "Activate", THIS, "PgLocPage2Activate")
688: 
689:         THIS.TornarControlesVisiveis(loc_oPage1)
690:         THIS.TornarControlesVisiveis(loc_oPage2)
691:     ENDPROC
692: 
693:     *==========================================================================
694:     * ConfigurarConteudoPgFtp - Popula as 2 paginas do pgf_4c_Ftp:
695:     *   Page1 ("Enviados")   = arquivos enviados / destino remoto FTP
696:     *   Page2 ("A Receber")  = arquivos remotos FTP disponiveis para baixar
697:     * Cada pagina: TextBox (caminho FTP) + botao "..." + ListBox
698:     *==========================================================================
699:     PROTECTED PROCEDURE ConfigurarConteudoPgFtp
700:         LOCAL loc_oPgFtp, loc_oPage1, loc_oPage2
701:         loc_oPgFtp = THIS.cnt_4c_Container1.pgf_4c_Ftp
702: 
703:         *-- Captions e cores das abas (do SCX original)
704:         loc_oPgFtp.Page1.Caption   = "Enviados"
705:         loc_oPgFtp.Page1.FontBold  = .T.
706:         loc_oPgFtp.Page1.FontName  = "Verdana"
707:         loc_oPgFtp.Page1.FontSize  = 8
708:         loc_oPgFtp.Page1.BackColor = RGB(255, 255, 255)
709:         loc_oPgFtp.Page1.ForeColor = RGB(0, 0, 255)
710:         loc_oPgFtp.Page2.Caption   = "A Receber"
711:         loc_oPgFtp.Page2.FontBold  = .T.
712:         loc_oPgFtp.Page2.FontName  = "Verdana"
713:         loc_oPgFtp.Page2.FontSize  = 8
714:         loc_oPgFtp.Page2.BackColor = RGB(255, 255, 255)
715:         loc_oPgFtp.Page2.ForeColor = RGB(255, 0, 0)
716: 
717:         *-- PAGE 1: Enviados (diretorio remoto FTP de destino dos enviados)
718:         loc_oPage1 = loc_oPgFtp.Page1
719:         loc_oPage1.AddObject("txt_4c_Dirrecloc", "TextBox")
720:         WITH loc_oPage1.txt_4c_Dirrecloc
721:             .Top      = 2
722:             .Left     = 2
723:             .Width    = 217
724:             .Height   = 23
725:             .Value    = ""
726:             .FontName = "Verdana"
727:             .FontSize = 8
728:             .ReadOnly = .T.
729:             .Visible  = .T.
730:         ENDWITH
731: 
732:         loc_oPage1.AddObject("cmd_4c_BrowftpEnviados", "CommandButton")
733:         WITH loc_oPage1.cmd_4c_BrowftpEnviados
734:             .Top      = 2
735:             .Left     = 223
736:             .Width    = 22
737:             .Height   = 22
738:             .Caption  = "..."
739:             .Enabled  = .F.

*-- Linhas 808 a 917:
808:             .Visible      = .T.
809:         ENDWITH
810: 
811:         BINDEVENT(loc_oPgFtp.Page1, "Activate", THIS, "PgFtpPage1Activate")
812:         BINDEVENT(loc_oPgFtp.Page2, "Activate", THIS, "PgFtpPage2Activate")
813: 
814:         THIS.TornarControlesVisiveis(loc_oPage1)
815:         THIS.TornarControlesVisiveis(loc_oPage2)
816:     ENDPROC
817: 
818:     *==========================================================================
819:     * ConfigurarBotoesTransferencia - Cria as setas de transferencia individual
820:     * dentro do cnt_4c_Container1 (entre pgf_4c_Loc e pgf_4c_Ftp):
821:     *   cmd_4c_Cmdtransfere (>) transfere arquivo selecionado local->FTP
822:     *   cmd_4c_Cmdrecebe    (<) recebe arquivo selecionado FTP->local
823:     *==========================================================================
824:     PROTECTED PROCEDURE ConfigurarBotoesTransferencia
825:         LOCAL loc_oCnt
826:         loc_oCnt = THIS.cnt_4c_Container1
827: 
828:         loc_oCnt.AddObject("cmd_4c_Cmdtransfere", "CommandButton")
829:         WITH loc_oCnt.cmd_4c_Cmdtransfere
830:             .Top         = 83
831:             .Left        = 299
832:             .Width       = 25
833:             .Height      = 24
834:             .Caption     = ""
835:             .ToolTipText = "Transfere para FTP"
836:             .FontName    = "Verdana"
837:             .FontSize    = 8
838:             .ForeColor   = RGB(36, 84, 155)
839:             .BackColor   = RGB(255, 255, 255)
840:             .Enabled     = .T.
841:             .Visible     = .T.
842:         ENDWITH
843:         BINDEVENT(loc_oCnt.cmd_4c_Cmdtransfere, "Click", THIS, "CmdCmdtransfereClick")
844: 
845:         loc_oCnt.AddObject("cmd_4c_Cmdrecebe", "CommandButton")
846:         WITH loc_oCnt.cmd_4c_Cmdrecebe
847:             .Top         = 116
848:             .Left        = 299
849:             .Width       = 25
850:             .Height      = 24
851:             .Caption     = ""
852:             .ToolTipText = "Recebe do FTP"
853:             .FontName    = "Verdana"
854:             .FontSize    = 8
855:             .ForeColor   = RGB(36, 84, 155)
856:             .BackColor   = RGB(255, 255, 255)
857:             .Enabled     = .F.
858:             .Visible     = .T.
859:         ENDWITH
860:         BINDEVENT(loc_oCnt.cmd_4c_Cmdrecebe, "Click", THIS, "CmdCmdrecebeClick")
861: 
862:         *-- Imagens das setas de transferencia individual (vbmp/ legado)
863:         LOCAL loc_cVbmp
864:         loc_cVbmp = gc_4c_CaminhoIcones + "..\vbmp\"
865:         IF FILE(loc_cVbmp + "b_arrow2.bmp")
866:             loc_oCnt.cmd_4c_Cmdtransfere.Picture = loc_cVbmp + "b_arrow2.bmp"
867:         ENDIF
868:         IF FILE(loc_cVbmp + "b_arrow1.bmp")
869:             loc_oCnt.cmd_4c_Cmdrecebe.Picture = loc_cVbmp + "b_arrow1.bmp"
870:         ENDIF
871:     ENDPROC
872: 
873:     *==========================================================================
874:     * ConfigurarGrdInf - Grid de log de operacoes FTP (equivalente ao GrdInf)
875:     * RecordSource = "logftp" | DynamicBackColor/ForeColor por cor (R/G/B)
876:     *==========================================================================
877:     PROTECTED PROCEDURE ConfigurarGrdInf
878:         LOCAL loc_oGrid
879:         THIS.AddObject("grd_4c_GrdInf", "Grid")
880:         loc_oGrid = THIS.grd_4c_GrdInf
881:         WITH loc_oGrid
882:             .Top                = 323
883:             .Left               = 89
884:             .Width              = 622
885:             .Height             = 52
886:             .ColumnCount        = 1
887:             .RecordMark         = .F.
888:             .DeleteMark         = .F.
889:             .GridLines          = 0
890:             .GridLineWidth      = 1
891:             .GridLineColor      = RGB(192, 192, 192)
892:             .HeaderHeight       = 0
893:             .HighlightStyle     = 2
894:             .HighlightBackColor = RGB(255, 255, 255)
895:             .ScrollBars         = 2
896:             .RowHeight          = 14
897:             .FontBold           = .T.
898:             .FontSize           = 8
899:             .ReadOnly           = .T.
900:             .TabStop            = .F.
901:             .RecordSource       = "logftp"
902:             .ForeColor          = RGB(0, 0, 0)
903:             .BackColor          = RGB(255, 255, 255)
904:             .Visible            = .T.
905:         ENDWITH
906:         WITH loc_oGrid.Column1
907:             .FontBold       = .T.
908:             .FontName       = "Arial"
909:             .FontSize       = 8
910:             .Alignment      = 0
911:             .Width          = 599
912:             .ControlSource  = "logftp.memo"
913:             .ReadOnly       = .T.
914:             .ForeColor      = RGB(0, 0, 0)
915:             .BackColor      = RGB(255, 255, 255)
916:             .Header1.FontBold  = .T.
917:             .Header1.FontName  = "Arial"

*-- Linhas 934 a 977:
934:     * RecordSource = "tmpprog" | 5 colunas: arquivo, tamanho, pasta local,
935:     *   pasta host, status
936:     *==========================================================================
937:     PROTECTED PROCEDURE ConfigurarGrdProc
938:         LOCAL loc_oGrid
939:         THIS.AddObject("grd_4c_GrdProc", "Grid")
940:         loc_oGrid = THIS.grd_4c_GrdProc
941:         WITH loc_oGrid
942:             .Top            = 376
943:             .Left           = 89
944:             .Width          = 622
945:             .Height         = 114
946:             .ColumnCount    = 5
947:             .RecordMark     = .F.
948:             .DeleteMark     = .F.
949:             .GridLines      = 0
950:             .HeaderHeight   = 15
951:             .RowHeight      = 15
952:             .FontSize       = 8
953:             .ReadOnly       = .T.
954:             .TabStop        = .F.
955:             .RecordSource   = "tmpprog"
956:             .ToolTipText    = "Progresso das Opera" + CHR(231) + CHR(245) + "es de Envio e Recebimento"
957:             .Visible        = .T.
958:         ENDWITH
959:         WITH loc_oGrid.Column1
960:             .FontSize      = 8
961:             .Width         = 81
962:             .ControlSource = "tmpprog.file"
963:             .ReadOnly      = .T.
964:             .ForeColor     = RGB(0, 0, 0)
965:             .BackColor     = RGB(255, 255, 255)
966:             .Header1.Caption = "Arquivo"
967:             .Header1.FontSize = 8
968:         ENDWITH
969:         WITH loc_oGrid.Column2
970:             .FontSize      = 8
971:             .Width         = 63
972:             .ControlSource = "tmpprog.size"
973:             .ReadOnly      = .T.
974:             .ForeColor     = RGB(0, 0, 0)
975:             .BackColor     = RGB(255, 255, 255)
976:             .Header1.Caption = "Tamanho"
977:             .Header1.FontSize = 8

*-- Linhas 1012 a 1321:
1012:     * ConfigurarRodape - Label de progresso, ComboBox de provedores Dial-Up
1013:     * e botao de conexao Dial-Up (cmdconect)
1014:     *==========================================================================
1015:     PROTECTED PROCEDURE ConfigurarRodape
1016:         *-- Label de progresso de operacoes (lblprog)
1017:         THIS.AddObject("lbl_4c_Lblprog", "Label")
1018:         WITH THIS.lbl_4c_Lblprog
1019:             .Top       = 512
1020:             .Left      = 245
1021:             .Width     = 437
1022:             .Height    = 16
1023:             .Caption   = ""
1024:             .FontBold  = .T.
1025:             .FontName  = "Verdana"
1026:             .FontSize  = 10
1027:             .BackStyle = 0
1028:             .ForeColor = RGB(36, 84, 155)
1029:             .TabStop   = .F.
1030:             .Visible   = .T.
1031:         ENDWITH
1032: 
1033:         *-- Botao Dial-Up (cmdconect) - conecta via RAS
1034:         THIS.AddObject("cmd_4c_Cmdconect", "CommandButton")
1035:         WITH THIS.cmd_4c_Cmdconect
1036:             .Top       = 534
1037:             .Left      = 332
1038:             .Width     = 76
1039:             .Height    = 54
1040:             .Caption   = "Rede " + CHR(92) + "<Dial-Up"
1041:             .FontBold  = .T.
1042:             .FontItalic = .T.
1043:             .FontName  = "Tahoma"
1044:             .FontSize  = 7
1045:             .ForeColor = RGB(90, 90, 90)
1046:             .BackColor = RGB(255, 255, 255)
1047:             .Themes    = .F.
1048:             .PicturePosition = 13
1049:             .WordWrap  = .T.
1050:             .Visible   = .T.
1051:         ENDWITH
1052:         BINDEVENT(THIS.cmd_4c_Cmdconect, "Click", THIS, "CmdCmdconectClick")
1053: 
1054:         *-- Imagem do botao de conexao Dial-Up (vbmp/ legado)
1055:         LOCAL loc_cVbmp
1056:         loc_cVbmp = gc_4c_CaminhoIcones + "..\vbmp\"
1057:         IF FILE(loc_cVbmp + "c_comm1.bmp")
1058:             THIS.cmd_4c_Cmdconect.Picture         = loc_cVbmp + "c_comm1.bmp"
1059:             THIS.cmd_4c_Cmdconect.DisabledPicture = loc_cVbmp + "c_comm1.bmp"
1060:         ENDIF
1061: 
1062:         *-- ComboBox de provedores Dial-Up (CboProvedor)
1063:         THIS.AddObject("cbo_4c_CboProvedor", "ComboBox")
1064:         WITH THIS.cbo_4c_CboProvedor
1065:             .Top           = 550
1066:             .Left          = 90
1067:             .Width         = 235
1068:             .Height        = 24
1069:             .RowSourceType = 0
1070:             .Style         = 2
1071:             .Value         = 0
1072:             .FontName      = "Verdana"
1073:             .FontSize      = 8
1074:             .Visible       = .T.
1075:         ENDWITH
1076:         BINDEVENT(THIS.cbo_4c_CboProvedor, "InteractiveChange", THIS, "CboProvedorInteractiveChange")
1077:     ENDPROC
1078: 
1079:     *==========================================================================
1080:     * AlternarPagina - Sincroniza pgf_4c_Loc e pgf_4c_Ftp para mesma pagina
1081:     * e habilita/desabilita setas de transferencia individual:
1082:     *   par_nPagina=1  Envio (local->FTP): seta > habilitada
1083:     *   par_nPagina=2  Recebimento (FTP->local): seta < habilitada
1084:     * Guard this_lAlternandoPagina evita recursao entre Activate handlers.
1085:     *==========================================================================
1086:     PROCEDURE AlternarPagina(par_nPagina)
1087:         LOCAL loc_oCnt, loc_oErro
1088:         IF THIS.this_lAlternandoPagina OR par_nPagina < 1 OR par_nPagina > 2
1089:             RETURN
1090:         ENDIF
1091:         THIS.this_lAlternandoPagina = .T.
1092:         TRY
1093:             loc_oCnt = THIS.cnt_4c_Container1
1094:             IF loc_oCnt.pgf_4c_Loc.ActivePage != par_nPagina
1095:                 loc_oCnt.pgf_4c_Loc.ActivePage = par_nPagina
1096:             ENDIF
1097:             IF loc_oCnt.pgf_4c_Ftp.ActivePage != par_nPagina
1098:                 loc_oCnt.pgf_4c_Ftp.ActivePage = par_nPagina
1099:             ENDIF
1100:             loc_oCnt.cmd_4c_Cmdtransfere.Enabled = (par_nPagina = 1)
1101:             loc_oCnt.cmd_4c_Cmdrecebe.Enabled    = (par_nPagina = 2)
1102:         CATCH TO loc_oErro
1103:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
1104:         ENDTRY
1105:         THIS.this_lAlternandoPagina = .F.
1106:     ENDPROC
1107: 
1108:     *-- Handlers de sincronizacao de paginas (via BINDEVENT nos Activate das Pages)
1109:     PROCEDURE PgLocPage1Activate
1110:         THIS.AlternarPagina(1)
1111:     ENDPROC
1112: 
1113:     PROCEDURE PgLocPage2Activate
1114:         THIS.AlternarPagina(2)
1115:     ENDPROC
1116: 
1117:     PROCEDURE PgFtpPage1Activate
1118:         THIS.AlternarPagina(1)
1119:     ENDPROC
1120: 
1121:     PROCEDURE PgFtpPage2Activate
1122:         THIS.AlternarPagina(2)
1123:     ENDPROC
1124: 
1125:     *==========================================================================
1126:     * CmdCmdsairClick - Encerra o formulario FTP
1127:     *==========================================================================
1128:     PROCEDURE CmdCmdsairClick
1129:         THIS.Release()
1130:     ENDPROC
1131: 
1132:     *==========================================================================
1133:     * CmdBrowlocEnvioClick - Seleciona pasta local de onde serao enviados
1134:     *                        os arquivos ao FTP (direnvftp)
1135:     *==========================================================================
1136:     PROCEDURE CmdBrowlocEnvioClick
1137:         LOCAL loc_cDir
1138:         loc_cDir = GETDIRECTORY("Selecione a pasta de envio")
1139:         IF !EMPTY(loc_cDir)
1140:             THIS.cnt_4c_Container1.pgf_4c_Loc.Page1.txt_4c_Direnvftp.Value = loc_cDir
1141:             THIS.this_cDirEnvFtp = loc_cDir
1142:         ENDIF
1143:     ENDPROC
1144: 
1145:     *==========================================================================
1146:     * CmdBrowlocRecebClick - Seleciona pasta local de destino dos arquivos
1147:     *                        recebidos do FTP (dirrecftp)
1148:     *==========================================================================
1149:     PROCEDURE CmdBrowlocRecebClick
1150:         LOCAL loc_cDir
1151:         loc_cDir = GETDIRECTORY("Selecione a pasta de recebimento")
1152:         IF !EMPTY(loc_cDir)
1153:             THIS.cnt_4c_Container1.pgf_4c_Loc.Page2.txt_4c_Dirrecftp.Value = loc_cDir
1154:             THIS.this_cDirRecFtp = loc_cDir
1155:         ENDIF
1156:     ENDPROC
1157: 
1158:     *==========================================================================
1159:     * CmdCmdloadClick - Conecta e carrega listagens de arquivos:
1160:     *   1. Desabilita botao para evitar clique duplo
1161:     *   2. Chama MontarContainer (listagem FTP + local)
1162:     *   3. Reabilita botao
1163:     *==========================================================================
1164:     PROCEDURE CmdCmdloadClick
1165:         LOCAL loc_lOk, loc_nAtivas, loc_oErro
1166:         loc_lOk = .T.
1167:         THIS.cmd_4c_Cmdload.Enabled = .F.
1168:         TRY
1169:             DO CASE
1170:                 CASE THIS.this_cTpConnect = "D"
1171:                     PUBLIC ARRAY aAtivas(1)
1172:                     loc_nAtivas = THIS.RasAtivas("aAtivas")
1173:                     IF loc_nAtivas > 0
1174:                         THIS.Inf("Este computador j" + CHR(225) + " est" + CHR(225) + ;
1175:                                  " conectado " + CHR(224) + " INTERNET", "B")
1176:                         THIS.MontarContainer()
1177:                     ELSE
1178:                         THIS.Inf("Conex" + CHR(227) + "o " + CHR(224) + ;
1179:                                  " Internet N" + CHR(195) + "O detectada", "R")
1180:                         loc_lOk = .F.
1181:                     ENDIF
1182:                     IF TYPE("aAtivas") = "A"
1183:                         RELEASE aAtivas
1184:                     ENDIF
1185:                 OTHERWISE
1186:                     THIS.MontarContainer()
1187:             ENDCASE
1188:         CATCH TO loc_oErro
1189:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1190:                     " PROC=" + loc_oErro.Procedure, "Erro")
1191:             loc_lOk = .F.
1192:         ENDTRY
1193:         THIS.cmd_4c_Cmdload.Enabled = .T.
1194:         RETURN loc_lOk
1195:     ENDPROC
1196: 
1197:     *==========================================================================
1198:     * CmdCmdtranClick - Transfere TODOS os arquivos listados para o FTP
1199:     *==========================================================================
1200:     PROCEDURE CmdCmdtranClick
1201:         THIS.Transfere("A")
1202:     ENDPROC
1203: 
1204:     *==========================================================================
1205:     * CmdCmdrecClick - Recebe TODOS os arquivos listados do FTP
1206:     *==========================================================================
1207:     PROCEDURE CmdCmdrecClick
1208:         THIS.Receber("A")
1209:     ENDPROC
1210: 
1211:     *==========================================================================
1212:     * CmdCmdtransfereClick - Transfere apenas o arquivo SELECIONADO ao FTP
1213:     *==========================================================================
1214:     PROCEDURE CmdCmdtransfereClick
1215:         THIS.Transfere("I")
1216:     ENDPROC
1217: 
1218:     *==========================================================================
1219:     * CmdCmdrecebeClick - Recebe apenas o arquivo SELECIONADO do FTP
1220:     *==========================================================================
1221:     PROCEDURE CmdCmdrecebeClick
1222:         THIS.Receber("I")
1223:     ENDPROC
1224: 
1225:     *==========================================================================
1226:     * CmdCmdconectClick - Conecta via RAS Dial-Up (se _TpConnect = "D")
1227:     *==========================================================================
1228:     PROCEDURE CmdCmdconectClick
1229:         LOCAL loc_nAtivas, loc_cRun, loc_oErro
1230:         TRY
1231:             DO CASE
1232:                 CASE THIS.this_cTpConnect = "D"
1233:                     PUBLIC ARRAY aAtivas(1)
1234:                     loc_nAtivas = THIS.RasAtivas("aAtivas")
1235:                     IF loc_nAtivas > 0
1236:                         THIS.Inf("Este computador j" + CHR(225) + " est" + CHR(225) + ;
1237:                                  " conectado " + CHR(224) + " INTERNET", "B")
1238:                     ELSE
1239:                         THIS.Inf("Esperando por uma Conex" + CHR(227) + "o " + CHR(224) + ;
1240:                                  " Internet via Dial-UP", "B")
1241:                         IF !EMPTY(THIS.this_cProvedor) AND TYPE("aProvedor") = "A"
1242:                             loc_cRun = "RUN /N Rundll Rnaui.dll,RnaDial " + ALLTRIM(THIS.this_cProvedor)
1243:                             &loc_cRun.
1244:                         ELSE
1245:                             IF EMPTY(THIS.this_cProvedor)
1246:                             THIS.Inf("Nome de Provedor n" + CHR(227) + "o selecionado.", "R")
1247:                             ENDIF
1248:                         ENDIF
1249:                     ENDIF
1250:                     IF TYPE("aAtivas") = "A"
1251:                         RELEASE aAtivas
1252:                     ENDIF
1253:                 OTHERWISE
1254:                     THIS.Inf("Conex" + CHR(227) + "o Broadband: n" + CHR(227) + ;
1255:                              "o requer discagem.", "B")
1256:             ENDCASE
1257:         CATCH TO loc_oErro
1258:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
1259:         ENDTRY
1260:     ENDPROC
1261: 
1262:     *==========================================================================
1263:     * CboProvedorInteractiveChange - Atualiza provedor Dial-Up selecionado
1264:     * quando usuario escolhe diferente item no ComboBox de provedores
1265:     *==========================================================================
1266:     PROCEDURE CboProvedorInteractiveChange
1267:         IF VARTYPE(THIS.cbo_4c_CboProvedor) = "O"
1268:             THIS.this_nProvedor = THIS.cbo_4c_CboProvedor.ListIndex
1269:             THIS.this_cProvedor = ALLTRIM(THIS.cbo_4c_CboProvedor.DisplayValue)
1270:         ENDIF
1271:     ENDPROC
1272: 
1273:     *==========================================================================
1274:     * MontarContainer - Carrega listagens de arquivos FTP e locais nos ListBoxes
1275:     * Equivalente a MontaContainer() do legado SIGPRFTP.SCX
1276:     * Preenche:
1277:     *   pgf_4c_Loc.Page1 -> obj_4c_Lstenvftp  (arquivos locais para enviar)
1278:     *   pgf_4c_Ftp.Page2 -> obj_4c_Lstenvloc  (arquivos FTP a receber)
1279:     *   Caminhos nos TextBoxes de cada pagina
1280:     *==========================================================================
1281:     PROCEDURE MontarContainer
1282:         LOCAL loc_lOk, loc_oCnt, loc_oPgLoc, loc_oPgFtp, loc_oObj
1283:         LOCAL loc_i, loc_aArq, loc_nArq, loc_oErro
1284:         loc_lOk  = .T.
1285:         loc_oCnt   = THIS.cnt_4c_Container1
1286:         loc_oPgLoc = loc_oCnt.pgf_4c_Loc
1287:         loc_oPgFtp = loc_oCnt.pgf_4c_Ftp
1288: 
1289:         THIS.Inf("Carregando par" + CHR(226) + "metros da tela... Aguarde", "B")
1290: 
1291:         *-- Atualizar TextBoxes de caminhos configurados
1292:         IF !EMPTY(THIS.this_cDirEnvFtp)
1293:             loc_oPgLoc.Page1.txt_4c_Direnvftp.Value = THIS.this_cDirEnvFtp
1294:         ENDIF
1295:         IF !EMPTY(THIS.this_cDirRecFtp)
1296:             loc_oPgLoc.Page2.txt_4c_Dirrecftp.Value = THIS.this_cDirRecFtp
1297:         ENDIF
1298:         IF !EMPTY(THIS.this_cDirRecLoc)
1299:             loc_oPgFtp.Page1.txt_4c_Dirrecloc.Value = THIS.this_cDirRecLoc
1300:         ENDIF
1301:         IF !EMPTY(THIS.this_cDirEnvLoc)
1302:             loc_oPgFtp.Page2.txt_4c_Direnvloc.Value = THIS.this_cDirEnvLoc
1303:         ENDIF
1304: 
1305:         *-- [A RECEBER DO HOST] Listagem do FTP (diretorio de envio local)
1306:         IF !EMPTY(THIS.this_cDirEnvLoc)
1307:             THIS.Inf("Estabelecendo conex" + CHR(227) + "o com " + ;
1308:                      THIS.this_cFtpAdd + "...", "B")
1309:             IF THIS.GetFtpDirectory(THIS.this_cDirEnvLoc, "*.*")
1310:                 IF USED("FtpServer")
1311:                     loc_oObj = loc_oPgFtp.Page2.obj_4c_Lstenvloc
1312:                     FOR loc_i = loc_oObj.ListCount TO 1 STEP -1
1313:                         loc_oObj.RemoveItem(loc_i)
1314:                     ENDFOR
1315:                     SELECT FtpServer
1316:                     SCAN
1317:                         loc_oObj.AddItem(ALLTRIM(FtpServer.lcFileName))
1318:                     ENDSCAN
1319:                     THIS.Inf("FTP: " + TRANSFORM(loc_oObj.ListCount) + ;
1320:                              " arquivo(s) encontrado(s)", "G")
1321:                 ENDIF

*-- Linhas 1362 a 1405:
1362:     * par_cTipo: "A" = todos os arquivos | "I" = apenas selecionados
1363:     * Equivalente a transfere() do legado SIGPRFTP.SCX
1364:     *==========================================================================
1365:     PROCEDURE Transfere(par_cTipo)
1366:         LOCAL loc_lOk, loc_oObj, loc_i, loc_nQtd, loc_nTrans, loc_nFalha
1367:         LOCAL loc_cArqLocal, loc_cArqFtp, loc_oErro
1368:         loc_lOk    = .T.
1369:         loc_nTrans = 0
1370:         loc_nFalha = 0
1371: 
1372:         THIS.cnt_4c_Container1.pgf_4c_Loc.ActivePage = 1
1373:         loc_oObj = THIS.cnt_4c_Container1.pgf_4c_Loc.Page1.obj_4c_Lstenvftp
1374: 
1375:         IF loc_oObj.ListCount <= 0
1376:             THIS.Inf("N" + CHR(195) + "O existe nenhum arquivo a ser Transferido para o FTP.", "B")
1377:             RETURN .F.
1378:         ENDIF
1379: 
1380:         loc_nQtd = loc_oObj.ListCount
1381:         TRY
1382:             FOR loc_i = 1 TO loc_nQtd
1383:                 loc_cArqLocal = ALLTRIM(loc_oObj.List(loc_i))
1384:                 IF UPPER(par_cTipo) = "I" AND !loc_oObj.Selected(loc_i)
1385:                     LOOP
1386:                 ENDIF
1387:                 loc_cArqFtp = THIS.this_cDirRecLoc + loc_cArqLocal
1388:                 THIS.Inf("Transferindo " + loc_cArqLocal + " para FTP...", "B")
1389:                 IF THIS.RasftpPut(THIS.this_cFtpAdd, THIS.this_cFtpUser, ;
1390:                                   THIS.this_cFtpPass, ;
1391:                                   THIS.this_cDirEnvFtp + loc_cArqLocal, ;
1392:                                   loc_cArqFtp)
1393:                     loc_nTrans = loc_nTrans + 1
1394:                     IF THIS.this_lDelLocal
1395:                         IF FILE(THIS.this_cDirEnvFtp + loc_cArqLocal)
1396:                             DELETE FILE (THIS.this_cDirEnvFtp + loc_cArqLocal)
1397:                         ENDIF
1398:                     ENDIF
1399:                     THIS.Inf("OK: " + loc_cArqLocal, "G")
1400:                 ELSE
1401:                     loc_nFalha = loc_nFalha + 1
1402:                     THIS.Inf("Falha: " + loc_cArqLocal, "R")
1403:                     loc_lOk = .F.
1404:                 ENDIF
1405:             ENDFOR

*-- Linhas 1418 a 1461:
1418:     * par_cTipo: "A" = todos os arquivos | "I" = apenas selecionados
1419:     * Equivalente a recebe() do legado SIGPRFTP.SCX
1420:     *==========================================================================
1421:     PROCEDURE Receber(par_cTipo)
1422:         LOCAL loc_lOk, loc_oObj, loc_i, loc_nQtd, loc_nTrans, loc_nFalha
1423:         LOCAL loc_cArqFtp, loc_cArqLocal, loc_oErro
1424:         loc_lOk    = .T.
1425:         loc_nTrans = 0
1426:         loc_nFalha = 0
1427: 
1428:         THIS.cnt_4c_Container1.pgf_4c_Ftp.ActivePage = 2
1429:         loc_oObj = THIS.cnt_4c_Container1.pgf_4c_Ftp.Page2.obj_4c_Lstenvloc
1430: 
1431:         IF loc_oObj.ListCount <= 0
1432:             THIS.Inf("Carregando listagem do FTP...", "B")
1433:             THIS.MontarContainer()
1434:         ENDIF
1435:         IF loc_oObj.ListCount <= 0
1436:             THIS.Inf("N" + CHR(195) + "O existe nenhum arquivo a ser recebido do FTP.", "B")
1437:             RETURN .F.
1438:         ENDIF
1439: 
1440:         loc_nQtd = loc_oObj.ListCount
1441:         TRY
1442:             FOR loc_i = 1 TO loc_nQtd
1443:                 loc_cArqFtp = ALLTRIM(loc_oObj.List(loc_i))
1444:                 IF UPPER(par_cTipo) = "I" AND !loc_oObj.Selected(loc_i)
1445:                     LOOP
1446:                 ENDIF
1447:                 loc_cArqLocal = THIS.this_cDirRecFtp + loc_cArqFtp
1448:                 THIS.Inf("Recebendo " + loc_cArqFtp + " do FTP...", "B")
1449:                 IF THIS.RasftpGet(THIS.this_cFtpAdd, THIS.this_cFtpUser, ;
1450:                                   THIS.this_cFtpPass, ;
1451:                                   THIS.this_cDirEnvLoc + loc_cArqFtp, ;
1452:                                   loc_cArqLocal)
1453:                     loc_nTrans = loc_nTrans + 1
1454:                     IF THIS.this_lDelHost
1455:                         THIS.DeleteFtpFile(THIS.this_cFtpAdd, THIS.this_cFtpUser, ;
1456:                                            THIS.this_cFtpPass, ;
1457:                                            THIS.this_cDirEnvLoc + loc_cArqFtp)
1458:                     ENDIF
1459:                     THIS.Inf("OK: " + loc_cArqFtp, "G")
1460:                 ELSE
1461:                     loc_nFalha = loc_nFalha + 1

*-- Linhas 1481 a 1524:
1481:     * Retorno: .T. se sucesso
1482:     * Equivalente a GetFtpDirectory() do legado SIGPRFTP.SCX
1483:     *==========================================================================
1484:     PROCEDURE GetFtpDirectory(par_cDirFtp, par_cMask)
1485:         LOCAL loc_lOk, loc_nInternet, loc_nFtp, loc_nFind, loc_oErro
1486:         LOCAL loc_cStruct, loc_cNull, loc_cName, loc_cResult, loc_lContinuar
1487: 
1488:         loc_lOk      = .F.
1489:         loc_nInternet = 0
1490:         loc_nFtp      = 0
1491: 
1492:         #DEFINE INTERNET_OPEN_TYPE_PRECONFIG   0
1493:         #DEFINE INTERNET_OPEN_TYPE_DIRECT      1
1494:         #DEFINE INTERNET_DEFAULT_FTP_PORT     21
1495:         #DEFINE INTERNET_SERVICE_FTP           1
1496:         #DEFINE INTERNET_FLAG_PASSIVE   14217728
1497:         #DEFINE ERROR_NO_MORE_FILES           18
1498:         #DEFINE MAX_PATH                     260
1499: 
1500:         TRY
1501:             DECLARE Integer InternetOpen IN wininet ;
1502:                 String  sAgent, Integer nAccessType, String sProxy, ;
1503:                 String  sProxyBypass, Integer dwFlags
1504: 
1505:             DECLARE Integer InternetConnect IN wininet ;
1506:                 Integer hInternet, String lpszServerName, ;
1507:                 Integer nServerPort, String lpszUserName, ;
1508:                 String  lpszPassword, Integer dwService, ;
1509:                 Integer dwFlags, Integer dwContext
1510: 
1511:             DECLARE Integer FtpFindFirstFile IN wininet ;
1512:                 Integer hConnect, String lpszSearchFile, ;
1513:                 String @lpFindFileData, Integer dwFlags, Integer dwContext
1514: 
1515:             DECLARE Integer InternetFindNextFile IN wininet ;
1516:                 Integer hFind, String @lpFindFileData
1517: 
1518:             DECLARE Integer InternetCloseHandle IN wininet ;
1519:                 Integer hInet
1520: 
1521:             loc_cStruct = SPACE(592)
1522:             loc_cNull   = CHR(0)
1523: 
1524:             loc_nInternet = InternetOpen("VFP9/FTP", INTERNET_OPEN_TYPE_DIRECT, ;

*-- Linhas 1592 a 1635:
1592:     * Retorno: .T. se sucesso
1593:     * Equivalente a rasftpget() do legado SIGPRFTP.SCX
1594:     *==========================================================================
1595:     PROCEDURE RasftpGet(par_cFtpLoc, par_cFtpUsu, par_cFtpSen, par_cFtpRemArq, par_cFtpLocArq)
1596:         LOCAL loc_lOk, loc_nInternet, loc_nFtp, loc_oErro
1597: 
1598:         loc_lOk      = .F.
1599:         loc_nInternet = 0
1600:         loc_nFtp      = 0
1601: 
1602:         #DEFINE INTERNET_OPEN_TYPE_DIRECT      1
1603:         #DEFINE INTERNET_DEFAULT_FTP_PORT     21
1604:         #DEFINE INTERNET_SERVICE_FTP           1
1605:         #DEFINE INTERNET_FLAG_PASSIVE   14217728
1606:         #DEFINE FILE_ATTRIBUTE_NORMAL        128
1607:         #DEFINE FTP_TRANSFER_TYPE_BINARY       2
1608: 
1609:         TRY
1610:             DECLARE Integer InternetOpen IN wininet ;
1611:                 String  sAgent, Integer nAccessType, String sProxy, ;
1612:                 String  sProxyBypass, Integer dwFlags
1613: 
1614:             DECLARE Integer InternetConnect IN wininet ;
1615:                 Integer hInternet, String lpszServerName, ;
1616:                 Integer nServerPort, String lpszUserName, ;
1617:                 String  lpszPassword, Integer dwService, ;
1618:                 Integer dwFlags, Integer dwContext
1619: 
1620:             DECLARE Integer FtpGetFile IN wininet ;
1621:                 Integer hConnect, String lpszRemoteFile, ;
1622:                 String  lpszNewFile, Integer fFailIfExists, ;
1623:                 Integer dwFlagsAndAttributes, Integer dwFlags, Integer dwContext
1624: 
1625:             DECLARE Integer InternetCloseHandle IN wininet ;
1626:                 Integer hInet
1627: 
1628:             loc_nInternet = InternetOpen("VFP9/FTP", INTERNET_OPEN_TYPE_DIRECT, ;
1629:                                          CHR(0), CHR(0), 0)
1630:             IF loc_nInternet = 0
1631:                 THIS.Inf("Falha ao inicializar WinInet (GET)", "R")
1632:             ELSE
1633:                 loc_nFtp = InternetConnect(loc_nInternet, ;
1634:                                            par_cFtpLoc, ;
1635:                                            INTERNET_DEFAULT_FTP_PORT, ;

*-- Linhas 1673 a 1716:
1673:     * Retorno: .T. se sucesso
1674:     * Equivalente a rasftpPUT() do legado SIGPRFTP.SCX
1675:     *==========================================================================
1676:     PROCEDURE RasftpPut(par_cFtpLoc, par_cFtpUsu, par_cFtpSen, par_cFtpLocArq, par_cFtpRemArq)
1677:         LOCAL loc_lOk, loc_nInternet, loc_nFtp, loc_oErro
1678: 
1679:         loc_lOk      = .F.
1680:         loc_nInternet = 0
1681:         loc_nFtp      = 0
1682: 
1683:         #DEFINE INTERNET_OPEN_TYPE_DIRECT      1
1684:         #DEFINE INTERNET_DEFAULT_FTP_PORT     21
1685:         #DEFINE INTERNET_SERVICE_FTP           1
1686:         #DEFINE INTERNET_FLAG_PASSIVE   14217728
1687:         #DEFINE FTP_TRANSFER_TYPE_BINARY       2
1688: 
1689:         TRY
1690:             DECLARE Integer InternetOpen IN wininet ;
1691:                 String  sAgent, Integer nAccessType, String sProxy, ;
1692:                 String  sProxyBypass, Integer dwFlags
1693: 
1694:             DECLARE Integer InternetConnect IN wininet ;
1695:                 Integer hInternet, String lpszServerName, ;
1696:                 Integer nServerPort, String lpszUserName, ;
1697:                 String  lpszPassword, Integer dwService, ;
1698:                 Integer dwFlags, Integer dwContext
1699: 
1700:             DECLARE Integer FtpPutFile IN wininet ;
1701:                 Integer hConnect, String lpszLocalFile, ;
1702:                 String  lpszNewRemoteFile, Integer dwFlags, Integer dwContext
1703: 
1704:             DECLARE Integer InternetCloseHandle IN wininet ;
1705:                 Integer hInet
1706: 
1707:             IF !FILE(par_cFtpLocArq)
1708:                 THIS.Inf("Arquivo n" + CHR(227) + "o encontrado: " + par_cFtpLocArq, "R")
1709:             ELSE
1710:                 loc_nInternet = InternetOpen("VFP9/FTP", INTERNET_OPEN_TYPE_DIRECT, ;
1711:                                              CHR(0), CHR(0), 0)
1712:                 IF loc_nInternet = 0
1713:                     THIS.Inf("Falha ao inicializar WinInet (PUT)", "R")
1714:                 ELSE
1715:                     loc_nFtp = InternetConnect(loc_nInternet, ;
1716:                                                par_cFtpLoc, ;

*-- Linhas 1747 a 1790:
1747:     * par_cFtpArq: caminho completo do arquivo no FTP
1748:     * Retorno: .T. se sucesso
1749:     *==========================================================================
1750:     PROCEDURE DeleteFtpFile(par_cFtpLoc, par_cFtpUsu, par_cFtpSen, par_cFtpArq)
1751:         LOCAL loc_lOk, loc_nInternet, loc_nFtp, loc_oErro
1752: 
1753:         loc_lOk      = .F.
1754:         loc_nInternet = 0
1755:         loc_nFtp      = 0
1756: 
1757:         #DEFINE INTERNET_OPEN_TYPE_DIRECT     1
1758:         #DEFINE INTERNET_DEFAULT_FTP_PORT    21
1759:         #DEFINE INTERNET_SERVICE_FTP          1
1760:         #DEFINE INTERNET_FLAG_PASSIVE  14217728
1761: 
1762:         TRY
1763:             DECLARE Integer InternetOpen IN wininet ;
1764:                 String  sAgent, Integer nAccessType, String sProxy, ;
1765:                 String  sProxyBypass, Integer dwFlags
1766: 
1767:             DECLARE Integer InternetConnect IN wininet ;
1768:                 Integer hInternet, String lpszServerName, ;
1769:                 Integer nServerPort, String lpszUserName, ;
1770:                 String  lpszPassword, Integer dwService, ;
1771:                 Integer dwFlags, Integer dwContext
1772: 
1773:             DECLARE Integer FtpDeleteFile IN wininet ;
1774:                 Integer hConnect, String lpszFileName
1775: 
1776:             DECLARE Integer InternetCloseHandle IN wininet ;
1777:                 Integer hInet
1778: 
1779:             loc_nInternet = InternetOpen("VFP9/FTP", INTERNET_OPEN_TYPE_DIRECT, ;
1780:                                          CHR(0), CHR(0), 0)
1781:             IF loc_nInternet <> 0
1782:                 loc_nFtp = InternetConnect(loc_nInternet, par_cFtpLoc, ;
1783:                                            INTERNET_DEFAULT_FTP_PORT, ;
1784:                                            par_cFtpUsu, par_cFtpSen, ;
1785:                                            INTERNET_SERVICE_FTP, ;
1786:                                            INTERNET_FLAG_PASSIVE, 0)
1787:                 IF loc_nFtp <> 0
1788:                     loc_lOk = (FtpDeleteFile(loc_nFtp, par_cFtpArq) <> 0)
1789:                     IF !loc_lOk
1790:                         THIS.Inf("Falha ao remover FTP: " + par_cFtpArq, "R")

*-- Linhas 1805 a 1949:
1805:     * par_cBuffer: string de 4 bytes
1806:     * Retorno: inteiro equivalente
1807:     *==========================================================================
1808:     PROCEDURE CToWord(par_cBuffer)
1809:         RETURN ASC(SUBSTR(par_cBuffer, 1, 1)) + ;
1810:                ASC(SUBSTR(par_cBuffer, 2, 1)) * 256 + ;
1811:                ASC(SUBSTR(par_cBuffer, 3, 1)) * 65536 + ;
1812:                ASC(SUBSTR(par_cBuffer, 4, 1)) * 16777216
1813:     ENDPROC
1814: 
1815:     *==========================================================================
1816:     * WordToC - Converte numero inteiro em buffer de 4 bytes (little-endian DWORD)
1817:     * par_nNumber: inteiro a converter
1818:     * Retorno: string de 4 bytes
1819:     *==========================================================================
1820:     PROCEDURE WordToC(par_nNumber)
1821:         RETURN CHR(BITAND(255, par_nNumber)) + ;
1822:                CHR(BITAND(65280, par_nNumber) % 255) + ;
1823:                CHR(BITAND(16711680, par_nNumber) % 255) + ;
1824:                CHR(BITAND(4278190080, par_nNumber) % 255)
1825:     ENDPROC
1826: 
1827:     *==========================================================================
1828:     * SectToHour - Converte segundos em string legivel "Xh, Xm, Xs"
1829:     * par_nSecto: numero de segundos
1830:     * Retorno: string formatada (ex: "1 h, 2 m, 30 s")
1831:     *==========================================================================
1832:     PROCEDURE SectToHour(par_nSecto)
1833:         LOCAL loc_nHora, loc_nMinu, loc_nSeco
1834:         loc_nHora = INT(par_nSecto / 3600)
1835:         loc_nMinu = MOD(INT(par_nSecto / 60), 60)
1836:         loc_nSeco = MOD(par_nSecto, 60)
1837:         RETURN IIF(loc_nHora > 0, ALLTRIM(STR(loc_nHora)) + " h, ", "") + ;
1838:                IIF(loc_nMinu > 0, ALLTRIM(STR(loc_nMinu)) + " m, ", "") + ;
1839:                ALLTRIM(STR(loc_nSeco)) + " s"
1840:     ENDPROC
1841: 
1842:     *==========================================================================
1843:     * CrackAttributes - Extrai atributos de arquivo de buffer WIN32 DWORD (4 bytes)
1844:     * par_cBuffer: 4 primeiros bytes do WIN32_FIND_DATA
1845:     * Retorno: string com letras de atributos (R/H/S/D/A/N/T/C/O)
1846:     *==========================================================================
1847:     PROCEDURE CrackAttributes(par_cBuffer)
1848:         LOCAL loc_cAtributos, loc_nValor
1849:         loc_cAtributos = ""
1850:         loc_nValor = (ASC(SUBSTR(par_cBuffer, 1, 1)) * 1) + ;
1851:                      (ASC(SUBSTR(par_cBuffer, 2, 1)) * 256) + ;
1852:                      (ASC(SUBSTR(par_cBuffer, 3, 1)) * 65536) + ;
1853:                      (ASC(SUBSTR(par_cBuffer, 4, 1)) * 16777216)
1854:         DO CASE
1855:             CASE BITTEST(loc_nValor, 0)
1856:                 loc_cAtributos = loc_cAtributos + "R"
1857:             CASE BITTEST(loc_nValor, 1)
1858:                 loc_cAtributos = loc_cAtributos + "H"
1859:             CASE BITTEST(loc_nValor, 2)
1860:                 loc_cAtributos = loc_cAtributos + "S"
1861:             CASE BITTEST(loc_nValor, 4)
1862:                 loc_cAtributos = loc_cAtributos + "D"
1863:             CASE BITTEST(loc_nValor, 5)
1864:                 loc_cAtributos = loc_cAtributos + "A"
1865:             CASE BITTEST(loc_nValor, 7)
1866:                 loc_cAtributos = loc_cAtributos + "N"
1867:             CASE BITTEST(loc_nValor, 8)
1868:                 loc_cAtributos = loc_cAtributos + "T"
1869:             CASE BITTEST(loc_nValor, 11)
1870:                 loc_cAtributos = loc_cAtributos + "C"
1871:             CASE BITTEST(loc_nValor, 12)
1872:                 loc_cAtributos = loc_cAtributos + "O"
1873:         ENDCASE
1874:         RETURN loc_cAtributos
1875:     ENDPROC
1876: 
1877:     *==========================================================================
1878:     * CrackDate - Converte buffer FILETIME (8 bytes) em string de data dd/mm/aaaa
1879:     * par_cOutBuffer: 8 bytes FILETIME (little-endian Windows)
1880:     * Retorno: string "dd/mm/aaaa" ou "01/01/1901" em caso de falha
1881:     *==========================================================================
1882:     PROCEDURE CrackDate(par_cOutBuffer)
1883:         LOCAL loc_cInBuffer, loc_nResult, loc_nAno, loc_nMes, loc_nDia, loc_cData, loc_oErro
1884:         loc_cInBuffer = SPACE(16)
1885:         loc_cData     = "01/01/1901"
1886:         TRY
1887:             DECLARE Integer FileTimeToSystemTime IN Kernel32 ;
1888:                 String @lpcBuffer, String @lpcBuffer
1889:             loc_nResult = FileTimeToSystemTime(@par_cOutBuffer, @loc_cInBuffer)
1890:             IF loc_nResult <> 0
1891:                 loc_nAno  = ASC(SUBSTR(loc_cInBuffer, 1, 1)) + (ASC(SUBSTR(loc_cInBuffer, 2, 1)) * 256)
1892:                 loc_nMes  = ASC(SUBSTR(loc_cInBuffer, 3, 1)) + (ASC(SUBSTR(loc_cInBuffer, 4, 1)) * 256)
1893:                 loc_nDia  = ASC(SUBSTR(loc_cInBuffer, 7, 1)) + (ASC(SUBSTR(loc_cInBuffer, 8, 1)) * 256)
1894:                 loc_cData = PADL(ALLTRIM(STR(loc_nDia)), 2, "0") + "/" + ;
1895:                             PADL(ALLTRIM(STR(loc_nMes)), 2, "0") + "/" + ;
1896:                             ALLTRIM(STR(loc_nAno))
1897:             ENDIF
1898:         CATCH TO loc_oErro
1899:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro CrackDate")
1900:         ENDTRY
1901:         RETURN loc_cData
1902:     ENDPROC
1903: 
1904:     *==========================================================================
1905:     * CrackFile - Analisa buffer WIN32_FIND_DATA e insere registro no cursor FtpServer
1906:     * par_cBuffer: buffer binario de 319 bytes (WIN32_FIND_DATA)
1907:     * Resultado: INSERT no cursor FtpServer (campos: nome, Tipo, Tama, Data, Atri)
1908:     *==========================================================================
1909:     PROCEDURE CrackFile(par_cBuffer)
1910:         LOCAL loc_cNomeArq, loc_cNomeAlt, loc_nSizeHigh, loc_nSizeLow, loc_nTamanho
1911:         LOCAL loc_cAtributos, loc_cBuffTempo, loc_cDataEsc, loc_cTipo, loc_nAttr, loc_oErro
1912: 
1913:         #DEFINE LOC_MAX_PATH       260
1914:         #DEFINE LOC_MAXDWORD       4294967295
1915:         #DEFINE LOC_FILE_ATTR_DIR  16
1916: 
1917:         TRY
1918:             loc_cNomeArq = SUBSTR(par_cBuffer, 45, LOC_MAX_PATH)
1919:             loc_cNomeAlt = RIGHT(par_cBuffer, 14)
1920:             loc_cNomeArq = LEFT(loc_cNomeArq, AT(CHR(0), loc_cNomeArq) - 1)
1921:             loc_cNomeAlt = LEFT(loc_cNomeAlt, AT(CHR(0), loc_cNomeAlt) - 1)
1922: 
1923:             loc_nSizeHigh = (ASC(SUBSTR(par_cBuffer, 29, 1)) * 1) + ;
1924:                             (ASC(SUBSTR(par_cBuffer, 30, 1)) * 256) + ;
1925:                             (ASC(SUBSTR(par_cBuffer, 31, 1)) * 65536) + ;
1926:                             (ASC(SUBSTR(par_cBuffer, 32, 1)) * 16777216)
1927:             loc_nSizeLow  = (ASC(SUBSTR(par_cBuffer, 33, 1)) * 1) + ;
1928:                             (ASC(SUBSTR(par_cBuffer, 34, 1)) * 256) + ;
1929:                             (ASC(SUBSTR(par_cBuffer, 35, 1)) * 65536) + ;
1930:                             (ASC(SUBSTR(par_cBuffer, 36, 1)) * 16777216)
1931:             loc_nTamanho  = (loc_nSizeHigh * LOC_MAXDWORD) + loc_nSizeLow
1932: 
1933:             loc_nAttr = THIS.CToWord(SUBSTR(par_cBuffer, 1, 4))
1934:             IF loc_nAttr = LOC_FILE_ATTR_DIR
1935:                 loc_cTipo = "Diret" + CHR(243) + "rio"
1936:             ELSE
1937:                 loc_cTipo = "Arquivo"
1938:             ENDIF
1939: 
1940:             loc_cBuffTempo = SUBSTR(par_cBuffer, 21, 8)
1941:             loc_cDataEsc   = THIS.CrackDate(loc_cBuffTempo)
1942:             loc_cAtributos = THIS.CrackAttributes(LEFT(par_cBuffer, 4))
1943: 
1944:             SELECT FtpServer
1945:             INSERT INTO FtpServer VALUES (ALLTRIM(loc_cNomeArq), ;
1946:                                           ALLTRIM(loc_cTipo), ;
1947:                                           TRANSFORM(loc_nTamanho, "9999999999"), ;
1948:                                           loc_cDataEsc, ;
1949:                                           loc_cAtributos)

*-- Linhas 1959 a 2035:
1959:     * par_pTotal : total de passos (usado quando par_pStep eh numerico)
1960:     * par_pMessage: mensagem de status (opcional, tipo C)
1961:     *==========================================================================
1962:     PROCEDURE FileCtrlUp(par_pStep, par_pTotal, par_pMessage)
1963:         LOCAL loc_oErro
1964:         TRY
1965:             IF TYPE("par_pMessage") = "C"
1966:                 IF VARTYPE(THIS.lbl_4c_Lblprog) = "O"
1967:                     THIS.lbl_4c_Lblprog.Caption = par_pMessage
1968:                 ENDIF
1969:             ENDIF
1970:             IF TYPE("par_pStep") = "N" AND TYPE("par_pTotal") = "N" AND par_pTotal > 0
1971:                 IF VARTYPE(THIS.lbl_4c_Lblprog) = "O"
1972:                     THIS.lbl_4c_Lblprog.Caption = TRANSFORM(INT(par_pStep * 100 / par_pTotal)) + "% " + ;
1973:                                                   IIF(TYPE("par_pMessage") = "C", "- " + par_pMessage, "")
1974:                 ENDIF
1975:                 DOEVENTS
1976:             ENDIF
1977:         CATCH TO loc_oErro
1978:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro FileCtrlUp")
1979:         ENDTRY
1980:     ENDPROC
1981: 
1982:     *==========================================================================
1983:     * Processa - Rastreador de progresso chamado durante transferencias FTP
1984:     * Atualiza cursor tmpprog e lbl_4c_Lblprog com andamento da transferencia.
1985:     * par_cArquivo : nome do arquivo em transferencia
1986:     * par_nTamanho : tamanho total em bytes
1987:     * par_cLocal   : diretorio local
1988:     * par_cHost    : diretorio no host FTP
1989:     * par_nTransf  : bytes ja transferidos
1990:     * par_nBuffer  : tamanho do buffer utilizado
1991:     * par_nSecIni  : segundos no inicio (SECONDS())
1992:     * par_nSec     : segundos decorridos
1993:     * par_cStatus  : "I"=Iniciando | "A"=em Andamento | "C"=Concluido
1994:     *==========================================================================
1995:     PROCEDURE Processa(par_cArquivo, par_nTamanho, par_cLocal, par_cHost, ;
1996:                        par_nTransf, par_nBuffer, par_nSecIni, par_nSec, par_cStatus)
1997:         LOCAL loc_nSec, loc_cTiEst, loc_cTiEla, loc_i, loc_oObj, loc_nIdx
1998:         LOCAL loc_cEraseCmd, loc_oErro
1999:         loc_nSec = par_nSec
2000:         IF loc_nSec = 0
2001:             loc_nSec = 0.001
2002:         ENDIF
2003:         TRY
2004:             IF par_cStatus == "I"
2005:                 THIS.FileCtrlUp(.T., .T., "Iniciando a transfer" + CHR(234) + "ncia...")
2006:                 IF USED("tmpprog")
2007:                     SELECT tmpprog
2008:                     APPEND BLANK
2009:                     REPLACE file   WITH par_cArquivo
2010:                     REPLACE size   WITH par_nTamanho
2011:                     REPLACE local  WITH par_cLocal
2012:                     REPLACE host   WITH par_cHost
2013:                     REPLACE status WITH "0 bytes copiados, 0% completado"
2014:                 ENDIF
2015:             ENDIF
2016:             IF par_cStatus == "A"
2017:                 IF USED("tmpprog")
2018:                     SELECT tmpprog
2019:                     LOCATE FOR tmpprog.file = par_cArquivo
2020:                     IF FOUND()
2021:                         REPLACE status WITH TRANSFORM(par_nTransf) + " bytes copiados, " + ;
2022:                                             TRANSFORM(IIF(par_nTamanho > 0, par_nTransf * 100 / par_nTamanho, 0), "99.99") + ;
2023:                                             "% completado"
2024:                         loc_cTiEst = THIS.SectToHour(INT(IIF(par_nTransf > 0, ;
2025:                                           (par_nTamanho - par_nTransf) * loc_nSec / par_nTransf, 0)))
2026:                         loc_cTiEla = THIS.SectToHour(SECONDS() - par_nSecIni)
2027:                         THIS.FileCtrlUp(par_nTransf * 100 / IIF(par_nTamanho > 0, par_nTamanho, 1), ;
2028:                                         100, ;
2029:                                         TRANSFORM(par_nTransf / loc_nSec / 1024, "9999.99") + " Kbps")
2030:                         IF VARTYPE(THIS.lbl_4c_Lblprog) = "O"
2031:                             THIS.lbl_4c_Lblprog.Caption = "Tempo decorrido: " + loc_cTiEla + ;
2032:                                                           "   Tempo Estimado : " + loc_cTiEst
2033:                         ENDIF
2034:                     ENDIF
2035:                 ENDIF

*-- Linhas 2051 a 2112:
2051:                         ENDIF
2052:                         THIS.Inf("Arquivo Transferido...", "B")
2053:                         THIS.FileCtrlUp(.F., .F., "")
2054:                         *-- Atualiza listbox: arquivo enviado local->FTP
2055:                         IF par_cLocal == THIS.this_cDirEnvFtp
2056:                             loc_oObj = THIS.cnt_4c_Container1.pgf_4c_Ftp.Page1.obj_4c_Lstrecloc
2057:                             loc_nIdx = loc_oObj.ListCount + 1
2058:                             loc_oObj.AddItem(par_cArquivo, loc_nIdx, 1)
2059:                             loc_oObj.AddListItem(TRANSFORM(par_nTamanho), loc_nIdx, 2)
2060:                             loc_oObj.AddListItem(TRANSFORM(par_nTransf), loc_nIdx, 3)
2061:                             loc_oObj.Refresh()
2062:                             IF THIS.this_lDelLocal
2063:                                 IF FILE(THIS.this_cDirEnvFtp + par_cArquivo)
2064:                                     THIS.Inf("Excluindo arquivo local " + THIS.this_cDirEnvFtp + par_cArquivo, "B")
2065:                                     loc_cEraseCmd = "ERASE " + THIS.this_cDirEnvFtp + par_cArquivo
2066:                                     &loc_cEraseCmd
2067:                                     IF FILE(THIS.this_cDirEnvFtp + par_cArquivo)
2068:                                         THIS.Inf("Falha na exclus" + CHR(227) + "o do arquivo local " + par_cArquivo, "R")
2069:                                     ELSE
2070:                                         THIS.Inf("Arquivo local " + par_cArquivo + " exclu" + CHR(237) + "do.", "B")
2071:                                         FOR loc_i = 1 TO THIS.cnt_4c_Container1.pgf_4c_Loc.Page1.obj_4c_Lstenvftp.ListCount
2072:                                             IF UPPER(ALLTRIM(THIS.cnt_4c_Container1.pgf_4c_Loc.Page1.obj_4c_Lstenvftp.List(loc_i, 1))) = UPPER(par_cArquivo)
2073:                                                 THIS.cnt_4c_Container1.pgf_4c_Loc.Page1.obj_4c_Lstenvftp.RemoveItem(loc_i)
2074:                                                 EXIT
2075:                                             ENDIF
2076:                                         ENDFOR
2077:                                     ENDIF
2078:                                 ENDIF
2079:                             ENDIF
2080:                         ENDIF
2081:                         *-- Atualiza listbox: arquivo recebido FTP->local
2082:                         IF par_cHost == THIS.this_cDirEnvLoc
2083:                             loc_oObj = THIS.cnt_4c_Container1.pgf_4c_Loc.Page2.obj_4c_Lstrecftp
2084:                             loc_nIdx = loc_oObj.ListCount + 1
2085:                             loc_oObj.AddItem(par_cArquivo, loc_nIdx, 1)
2086:                             loc_oObj.AddListItem(TRANSFORM(par_nTamanho), loc_nIdx, 2)
2087:                             loc_oObj.AddListItem(TRANSFORM(par_nTransf), loc_nIdx, 3)
2088:                             loc_oObj.Refresh()
2089:                             IF THIS.this_lDelHost
2090:                                 THIS.Inf("Excluindo arquivo FTP " + THIS.this_cDirEnvLoc + par_cArquivo, "B")
2091:                                 IF THIS.DeleteFtpFile(THIS.this_cFtpAdd, THIS.this_cFtpUser, ;
2092:                                                       THIS.this_cFtpPass, ;
2093:                                                       THIS.this_cDirEnvLoc + par_cArquivo)
2094:                                     THIS.Inf("Arquivo FTP " + par_cArquivo + " exclu" + CHR(237) + "do.", "B")
2095:                                     FOR loc_i = 1 TO THIS.cnt_4c_Container1.pgf_4c_Ftp.Page2.obj_4c_Lstenvloc.ListCount
2096:                                         IF UPPER(ALLTRIM(THIS.cnt_4c_Container1.pgf_4c_Ftp.Page2.obj_4c_Lstenvloc.List(loc_i, 1))) = UPPER(par_cArquivo)
2097:                                             THIS.cnt_4c_Container1.pgf_4c_Ftp.Page2.obj_4c_Lstenvloc.RemoveItem(loc_i)
2098:                                             EXIT
2099:                                         ENDIF
2100:                                     ENDFOR
2101:                                 ELSE
2102:                                     THIS.Inf("Falha na exclus" + CHR(227) + "o FTP " + par_cArquivo, "R")
2103:                                 ENDIF
2104:                             ENDIF
2105:                         ENDIF
2106:                     ENDIF
2107:                 ENDIF
2108:             ENDIF
2109:             IF VARTYPE(THIS.grd_4c_GrdProc) = "O"
2110:                 THIS.grd_4c_GrdProc.Refresh()
2111:             ENDIF
2112:         CATCH TO loc_oErro

*-- Linhas 2119 a 2162:
2119:     * par_nErro: codigo de erro numerico (GetLastError / WinInet)
2120:     * Retorno: string formatada "[ NNN : NOME_DO_ERRO ]"
2121:     *==========================================================================
2122:     PROCEDURE InErrorCase(par_nErro)
2123:         LOCAL loc_cMensagem
2124:         DO CASE
2125:             CASE par_nErro = 12001
2126:                 loc_cMensagem = "ERROR_INTERNET_OUT_OF_HANDLES"
2127:             CASE par_nErro = 12002
2128:                 loc_cMensagem = "ERROR_INTERNET_TIMEOUT"
2129:             CASE par_nErro = 12003
2130:                 loc_cMensagem = "ERROR_INTERNET_EXTENDED_ERROR"
2131:             CASE par_nErro = 12004
2132:                 loc_cMensagem = "ERROR_INTERNET_INTERNAL_ERROR"
2133:             CASE par_nErro = 12005
2134:                 loc_cMensagem = "ERROR_INTERNET_INVALID_URL"
2135:             CASE par_nErro = 12006
2136:                 loc_cMensagem = "ERROR_INTERNET_UNRECOGNIZED_SCHEME"
2137:             CASE par_nErro = 12007
2138:                 loc_cMensagem = "ERROR_INTERNET_NAME_NOT_RESOLVED"
2139:             CASE par_nErro = 12008
2140:                 loc_cMensagem = "ERROR_INTERNET_PROTOCOL_NOT_FOUND"
2141:             CASE par_nErro = 12009
2142:                 loc_cMensagem = "ERROR_INTERNET_INVALID_OPTION"
2143:             CASE par_nErro = 12010
2144:                 loc_cMensagem = "ERROR_INTERNET_BAD_OPTION_LENGTH"
2145:             CASE par_nErro = 12011
2146:                 loc_cMensagem = "ERROR_INTERNET_OPTION_NOT_SETTABLE"
2147:             CASE par_nErro = 12012
2148:                 loc_cMensagem = "ERROR_INTERNET_SHUTDOWN"
2149:             CASE par_nErro = 12013
2150:                 loc_cMensagem = "ERROR_INTERNET_INCORRECT_USER_NAME"
2151:             CASE par_nErro = 12014
2152:                 loc_cMensagem = "ERROR_INTERNET_INCORRECT_PASSWORD"
2153:             CASE par_nErro = 12015
2154:                 loc_cMensagem = "ERROR_INTERNET_LOGIN_FAILURE"
2155:             CASE par_nErro = 12016
2156:                 loc_cMensagem = "ERROR_INTERNET_INVALID_OPERATION"
2157:             CASE par_nErro = 12017
2158:                 loc_cMensagem = "ERROR_INTERNET_OPERATION_CANCELLED"
2159:             CASE par_nErro = 12018
2160:                 loc_cMensagem = "ERROR_INTERNET_INCORRECT_HANDLE_TYPE"
2161:             CASE par_nErro = 12019
2162:                 loc_cMensagem = "ERROR_INTERNET_INCORRECT_HANDLE_STATE"

*-- Linhas 2276 a 2654:
2276:     *   [N,1]=handle hRasConn | [N,2]=nome | [N,3]=dispositivo | [N,4]=telefone
2277:     * Retorno: numero de conexoes ativas
2278:     *==========================================================================
2279:     PROCEDURE RasAtivas(par_cArrayRetorno)
2280:         LOCAL loc_cConexao, loc_cConexoes, loc_nSize, loc_nContagem, loc_nResult
2281:         LOCAL loc_nPos, loc_oErro
2282:         loc_nContagem = 0
2283:         TRY
2284:             DECLARE INTEGER RasEnumConnections ;
2285:                 IN RASAPI32.DLL ;
2286:                 STRING  @ RasConnectionsBuffer, ;
2287:                 INTEGER @ dwSize, ;
2288:                 INTEGER @ nCount
2289: 
2290:             loc_cConexao  = THIS.WordToC(412) + REPLICATE(CHR(0), 408)
2291:             loc_cConexoes = REPLICATE(loc_cConexao, 16)
2292:             loc_nSize     = LEN(loc_cConexoes)
2293:             loc_nContagem = 0
2294: 
2295:             loc_nResult = RasEnumConnections(@loc_cConexoes, @loc_nSize, @loc_nContagem)
2296: 
2297:             IF loc_nContagem > 0
2298:                 PUBLIC ARRAY &par_cArrayRetorno.[loc_nContagem, 4]
2299:                 FOR loc_nPos = 0 TO loc_nContagem - 1
2300:                     loc_cConexao = SUBSTR(loc_cConexoes, (loc_nPos * 412) + 1, 412)
2301:                     &par_cArrayRetorno.[loc_nPos + 1, 1] = THIS.CToWord(SUBSTR(loc_cConexao, 5, 4))
2302:                     &par_cArrayRetorno.[loc_nPos + 1, 2] = STRTRAN(SUBSTR(loc_cConexao, 9, 257), CHR(0))
2303:                     &par_cArrayRetorno.[loc_nPos + 1, 3] = STRTRAN(SUBSTR(loc_cConexao, 266, 17), CHR(0))
2304:                     &par_cArrayRetorno.[loc_nPos + 1, 4] = STRTRAN(SUBSTR(loc_cConexao, 283, 129), CHR(0))
2305:                 ENDFOR
2306:             ENDIF
2307:         CATCH TO loc_oErro
2308:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro RasAtivas")
2309:             loc_nContagem = 0
2310:         ENDTRY
2311:         RETURN loc_nContagem
2312:     ENDPROC
2313: 
2314:     *==========================================================================
2315:     * RasConexao - Lista entradas disponiveis no Phonebook RAS (RASAPI32.DLL)
2316:     * par_cArrayRetorno: nome (string) do array PUBLIC a preencher com [N]
2317:     *   Cada elemento = nome da entrada de discagem
2318:     * Retorno: numero de entradas encontradas
2319:     *==========================================================================
2320:     PROCEDURE RasConexao(par_cArrayRetorno)
2321:         LOCAL loc_cEntrada, loc_cEntradas, loc_nSize, loc_nTotal, loc_nResult
2322:         LOCAL loc_nCont, loc_cNomeEntrada, loc_oErro
2323:         loc_nTotal = 0
2324:         TRY
2325:             DECLARE INTEGER RasEnumEntries ;
2326:                 IN RASAPI32.DLL ;
2327:                 INTEGER   reserved, ;
2328:                 STRING    PhoneBox, ;
2329:                 STRING  @ RasEntryName, ;
2330:                 INTEGER @ SizeOfRasEntryName, ;
2331:                 INTEGER @ Entries
2332: 
2333:             loc_cEntrada  = THIS.WordToC(264) + REPLICATE(CHR(0), 256)
2334:             loc_cEntradas = REPLICATE(loc_cEntrada, 255)
2335:             loc_nSize     = LEN(loc_cEntradas)
2336:             loc_nTotal    = 0
2337: 
2338:             loc_nResult = RasEnumEntries(0, "", @loc_cEntradas, @loc_nSize, @loc_nTotal)
2339: 
2340:             IF loc_nTotal > 0
2341:                 RELEASE &par_cArrayRetorno.
2342:                 PUBLIC ARRAY &par_cArrayRetorno.[loc_nTotal]
2343:                 FOR loc_nCont = 0 TO loc_nTotal - 1
2344:                     loc_cNomeEntrada = SUBSTR(loc_cEntradas, 264 * loc_nCont + 1, 264)
2345:                     &par_cArrayRetorno.[loc_nCont + 1] = SUBSTR(loc_cNomeEntrada, 5, ;
2346:                         AT(CHR(0), SUBSTR(loc_cNomeEntrada, 5)) - 1)
2347:                 ENDFOR
2348:             ENDIF
2349:         CATCH TO loc_oErro
2350:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro RasConexao")
2351:             loc_nTotal = 0
2352:         ENDTRY
2353:         RETURN loc_nTotal
2354:     ENDPROC
2355: 
2356:     *==========================================================================
2357:     * RasDescon - Desconecta uma conexao RAS ativa via RasHangUp (RASAPI32.DLL)
2358:     * par_nRasConn: handle da conexao RAS a encerrar (obtido por RasAtivas)
2359:     * Retorno: resultado de RasHangUp (0 = sucesso)
2360:     *==========================================================================
2361:     PROCEDURE RasDescon(par_nRasConn)
2362:         LOCAL loc_nResult, loc_oErro
2363:         loc_nResult = -1
2364:         TRY
2365:             DECLARE Integer RasHangUp ;
2366:                 IN RASAPI32.DLL ;
2367:                 Integer hRasConn
2368:             DECLARE Integer Sleep ;
2369:                 IN Win32API ;
2370:                 Integer Milliseconds
2371:             THIS.Inf("Desconectando... ", "R")
2372:             loc_nResult = RasHangUp(par_nRasConn)
2373:             Sleep(3000)
2374:         CATCH TO loc_oErro
2375:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro RasDescon")
2376:         ENDTRY
2377:         RETURN loc_nResult
2378:     ENDPROC
2379: 
2380:     *==========================================================================
2381:     * CarregarConexoesDialUp - Popula cbo_4c_CboProvedor com entradas RAS
2382:     * Chamado automaticamente em CarregarParametros quando TpConnect = "D"
2383:     *==========================================================================
2384:     PROCEDURE CarregarConexoesDialUp
2385:         LOCAL loc_nTotal, loc_i, loc_oErro
2386:         TRY
2387:             IF VARTYPE(THIS.cbo_4c_CboProvedor) = "O"
2388:                 THIS.cbo_4c_CboProvedor.Clear()
2389:                 loc_nTotal = THIS.RasConexao("aProvedor")
2390:                 IF loc_nTotal > 0
2391:                     FOR loc_i = 1 TO loc_nTotal
2392:                         THIS.cbo_4c_CboProvedor.AddItem(aProvedor(loc_i))
2393:                     ENDFOR
2394:                     IF THIS.cbo_4c_CboProvedor.ListCount > 0
2395:                         THIS.cbo_4c_CboProvedor.ListIndex = 1
2396:                     ENDIF
2397:                 ENDIF
2398:             ENDIF
2399:         CATCH TO loc_oErro
2400:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro CarregarConexoesDialUp")
2401:         ENDTRY
2402:     ENDPROC
2403: 
2404:     *==========================================================================
2405:     * Destroy - Libera recursos ao encerrar o form
2406:     *==========================================================================
2407:     PROCEDURE Destroy
2408:         IF USED("logftp")
2409:             USE IN logftp
2410:         ENDIF
2411:         IF USED("tmpprog")
2412:             USE IN tmpprog
2413:         ENDIF
2414:         IF USED("FtpServer")
2415:             USE IN FtpServer
2416:         ENDIF
2417:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2418:             THIS.this_oBusinessObject = .NULL.
2419:         ENDIF
2420:         DODEFAULT()
2421:     ENDPROC
2422: 
2423:     *==========================================================================
2424:     * Adaptadores CRUD -> OPERACIONAL (FTP)
2425:     *
2426:     * Form operacional FTP: fluxo distinto do padrao CRUD (Incluir/Alterar/Visualizar/Excluir).
2427:     * Os botoes reais sao: Conecta (cmd_4c_Cmdload), Transfere (cmd_4c_Cmdtran),
2428:     * Recebe (cmd_4c_Cmdrec), Rede Dial-Up (cmd_4c_Cmdconect) e Encerrar
2429:     * (cmd_4c_Cmdsair), alem dos botoes por-arquivo cmd_4c_Cmdtransfere e
2430:     * cmd_4c_Cmdrecebe dentro do Container1.
2431:     *
2432:     * Os adaptadores abaixo mapeiam as intencoes CRUD (usadas por menus/pipeline)
2433:     * para as operacoes reais equivalentes do fluxo FTP, evitando codigo morto
2434:     * e mantendo compatibilidade com chamadores genericos.
2435:     *==========================================================================
2436: 
2437:     *-- BtnIncluirClick: iniciar nova sessao FTP (conectar + carregar listagens)
2438:     PROCEDURE BtnIncluirClick
2439:         RETURN THIS.CmdCmdloadClick()
2440:     ENDPROC
2441: 
2442:     *-- BtnAlterarClick: recarregar listagens FTP/local (refresh dos containers)
2443:     PROCEDURE BtnAlterarClick
2444:         RETURN THIS.CmdCmdloadClick()
2445:     ENDPROC
2446: 
2447:     *-- BtnVisualizarClick: exibir arquivos disponiveis para envio/recebimento
2448:     PROCEDURE BtnVisualizarClick
2449:         RETURN THIS.MontarContainer()
2450:     ENDPROC
2451: 
2452:     *-- BtnExcluirClick: excluir arquivo remoto selecionado no ListBox FTP
2453:     *-- Se nenhum arquivo estiver selecionado, o proprio metodo emite aviso.
2454:     PROCEDURE BtnExcluirClick
2455:         LOCAL loc_oObj, loc_cArquivo, loc_lOk, loc_oErro
2456:         loc_lOk = .F.
2457:         TRY
2458:             loc_oObj = THIS.cnt_4c_Container1.pgf_4c_Ftp.Page2.obj_4c_Lstenvloc
2459:             IF VARTYPE(loc_oObj) = "O" AND loc_oObj.ListIndex > 0
2460:                 loc_cArquivo = ALLTRIM(loc_oObj.List(loc_oObj.ListIndex, 1))
2461:                 IF !EMPTY(loc_cArquivo) AND MsgConfirma("Excluir arquivo remoto: " + ;
2462:                         loc_cArquivo + " ?", "Confirma" + CHR(231) + CHR(227) + "o")
2463:                     loc_lOk = THIS.DeleteFtpFile(THIS.this_cFtpAdd, THIS.this_cFtpUser, ;
2464:                                                   THIS.this_cFtpPass, loc_cArquivo)
2465:                     IF loc_lOk
2466:                         loc_oObj.RemoveItem(loc_oObj.ListIndex)
2467:                         THIS.Inf("Arquivo " + loc_cArquivo + " exclu" + CHR(237) + "do do FTP.", "B")
2468:                     ENDIF
2469:                 ENDIF
2470:             ELSE
2471:                 THIS.Inf("Selecione um arquivo remoto para excluir.", "R")
2472:             ENDIF
2473:         CATCH TO loc_oErro
2474:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
2475:                     " PROC=" + loc_oErro.Procedure, "Erro")
2476:             loc_lOk = .F.
2477:         ENDTRY
2478:         RETURN loc_lOk
2479:     ENDPROC
2480: 
2481:     *-- BtnBuscarClick: conectar e carregar listagens FTP/local
2482:     PROCEDURE BtnBuscarClick
2483:         RETURN THIS.CmdCmdloadClick()
2484:     ENDPROC
2485: 
2486:     *-- BtnEncerrarClick: encerrar o formulario FTP
2487:     PROCEDURE BtnEncerrarClick
2488:         THIS.Release()
2489:     ENDPROC
2490: 
2491:     *-- BtnSalvarClick: enviar todos os arquivos para o FTP
2492:     PROCEDURE BtnSalvarClick
2493:         RETURN THIS.Transfere("A")
2494:     ENDPROC
2495: 
2496:     *-- BtnCancelarClick: receber todos os arquivos do FTP
2497:     PROCEDURE BtnCancelarClick
2498:         RETURN THIS.Receber("A")
2499:     ENDPROC
2500: 
2501:     *==========================================================================
2502:     * FormParaBO - Transfere configuracao FTP do form para o BO
2503:     *==========================================================================
2504:     PROCEDURE FormParaBO
2505:         LOCAL loc_oBO
2506:         loc_oBO = THIS.this_oBusinessObject
2507:         IF VARTYPE(loc_oBO) != "O"
2508:             RETURN .F.
2509:         ENDIF
2510:         loc_oBO.this_cTpConexaoEmp = THIS.this_cTpConnect
2511:         loc_oBO.this_cFtpAddEmp    = THIS.this_cFtpAdd
2512:         loc_oBO.this_cFtpUserEmp   = THIS.this_cFtpUser
2513:         loc_oBO.this_cFtpPassEmp   = THIS.this_cFtpPass
2514:         loc_oBO.this_cDriveTs      = THIS.this_cDirEnvFtp
2515:         loc_oBO.this_cDriveLs      = THIS.this_cDirRecFtp
2516:         loc_oBO.this_cDirFtpTs     = THIS.this_cDirRecLoc
2517:         loc_oBO.this_cDirFtpLs     = THIS.this_cDirEnvLoc
2518:         loc_oBO.this_lLocDel       = THIS.this_lDelLocal
2519:         loc_oBO.this_lFtpDel       = THIS.this_lDelHost
2520:         RETURN .T.
2521:     ENDPROC
2522: 
2523:     *==========================================================================
2524:     * BOParaForm - Transfere configuracao FTP do BO para os controles do form
2525:     *==========================================================================
2526:     PROCEDURE BOParaForm
2527:         LOCAL loc_oBO, loc_oCnt, loc_oPgLoc, loc_oPgFtp, loc_oErro
2528:         TRY
2529:             loc_oBO = THIS.this_oBusinessObject
2530:             IF VARTYPE(loc_oBO) != "O"
2531:                 loc_lResultado = .F.
2532:             ENDIF
2533:             THIS.this_cTpConnect = UPPER(ALLTRIM(loc_oBO.this_cTpConexaoEmp))
2534:             THIS.this_cFtpAdd    = LOWER(ALLTRIM(loc_oBO.this_cFtpAddEmp))
2535:             THIS.this_cFtpUser   = LOWER(ALLTRIM(loc_oBO.this_cFtpUserEmp))
2536:             THIS.this_cFtpPass   = LOWER(ALLTRIM(loc_oBO.this_cFtpPassEmp))
2537:             THIS.this_cDirEnvFtp = LOWER(ALLTRIM(loc_oBO.this_cDriveTs))
2538:             THIS.this_cDirRecFtp = LOWER(ALLTRIM(loc_oBO.this_cDriveLs))
2539:             THIS.this_cDirRecLoc = LOWER(ALLTRIM(loc_oBO.this_cDirFtpTs))
2540:             THIS.this_cDirEnvLoc = LOWER(ALLTRIM(loc_oBO.this_cDirFtpLs))
2541:             THIS.this_lDelLocal  = loc_oBO.this_lLocDel
2542:             THIS.this_lDelHost   = loc_oBO.this_lFtpDel
2543:             *-- Atualizar TextBoxes de caminhos nos PageFrames
2544:             IF VARTYPE(THIS.cnt_4c_Container1) = "O"
2545:                 loc_oCnt   = THIS.cnt_4c_Container1
2546:                 loc_oPgLoc = loc_oCnt.pgf_4c_Loc
2547:                 loc_oPgFtp = loc_oCnt.pgf_4c_Ftp
2548:                 IF !EMPTY(THIS.this_cDirEnvFtp)
2549:                     loc_oPgLoc.Page1.txt_4c_Direnvftp.Value = THIS.this_cDirEnvFtp
2550:                 ENDIF
2551:                 IF !EMPTY(THIS.this_cDirRecFtp)
2552:                     loc_oPgLoc.Page2.txt_4c_Dirrecftp.Value = THIS.this_cDirRecFtp
2553:                 ENDIF
2554:                 IF !EMPTY(THIS.this_cDirRecLoc)
2555:                     loc_oPgFtp.Page1.txt_4c_Dirrecloc.Value = THIS.this_cDirRecLoc
2556:                 ENDIF
2557:                 IF !EMPTY(THIS.this_cDirEnvLoc)
2558:                     loc_oPgFtp.Page2.txt_4c_Direnvloc.Value = THIS.this_cDirEnvLoc
2559:                 ENDIF
2560:             ENDIF
2561:         CATCH TO loc_oErro
2562:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro BOParaForm")
2563:         ENDTRY
2564:         RETURN .T.
2565:     ENDPROC
2566: 
2567:     *==========================================================================
2568:     * HabilitarCampos - Habilita/desabilita botoes conforme modo de operacao
2569:     * par_lHabilitar: .T. = habilitar (respeitando restricoes de modo)
2570:     *==========================================================================
2571:     PROCEDURE HabilitarCampos(par_lHabilitar)
2572:         LOCAL loc_oErro
2573:         TRY
2574:             IF VARTYPE(THIS.cmd_4c_Cmdtran) = "O"
2575:                 THIS.cmd_4c_Cmdtran.Enabled = par_lHabilitar AND !THIS.this_lSomenteRecebimento
2576:             ENDIF
2577:             IF VARTYPE(THIS.cmd_4c_Cmdrec) = "O"
2578:                 THIS.cmd_4c_Cmdrec.Enabled = par_lHabilitar AND !THIS.this_lSomenteEnvio
2579:             ENDIF
2580:             IF VARTYPE(THIS.cmd_4c_Cmdload) = "O"
2581:                 THIS.cmd_4c_Cmdload.Enabled = par_lHabilitar
2582:             ENDIF
2583:             IF VARTYPE(THIS.cnt_4c_Container1) = "O"
2584:                 THIS.cnt_4c_Container1.cmd_4c_Cmdtransfere.Enabled = ;
2585:                     par_lHabilitar AND !THIS.this_lSomenteRecebimento
2586:                 THIS.cnt_4c_Container1.cmd_4c_Cmdrecebe.Enabled = ;
2587:                     par_lHabilitar AND !THIS.this_lSomenteEnvio
2588:             ENDIF
2589:         CATCH TO loc_oErro
2590:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro HabilitarCampos")
2591:         ENDTRY
2592:     ENDPROC
2593: 
2594:     *==========================================================================
2595:     * LimparCampos - Limpa ListBoxes de arquivos, log e cursor de progresso
2596:     *==========================================================================
2597:     PROCEDURE LimparCampos
2598:         LOCAL loc_oObj, loc_i, loc_oErro
2599:         TRY
2600:             IF VARTYPE(THIS.cnt_4c_Container1) = "O"
2601:                 loc_oObj = THIS.cnt_4c_Container1.pgf_4c_Loc.Page1.obj_4c_Lstenvftp
2602:                 FOR loc_i = loc_oObj.ListCount TO 1 STEP -1
2603:                     loc_oObj.RemoveItem(loc_i)
2604:                 ENDFOR
2605:                 loc_oObj = THIS.cnt_4c_Container1.pgf_4c_Loc.Page2.obj_4c_Lstrecftp
2606:                 FOR loc_i = loc_oObj.ListCount TO 1 STEP -1
2607:                     loc_oObj.RemoveItem(loc_i)
2608:                 ENDFOR
2609:                 loc_oObj = THIS.cnt_4c_Container1.pgf_4c_Ftp.Page1.obj_4c_Lstrecloc
2610:                 FOR loc_i = loc_oObj.ListCount TO 1 STEP -1
2611:                     loc_oObj.RemoveItem(loc_i)
2612:                 ENDFOR
2613:                 loc_oObj = THIS.cnt_4c_Container1.pgf_4c_Ftp.Page2.obj_4c_Lstenvloc
2614:                 FOR loc_i = loc_oObj.ListCount TO 1 STEP -1
2615:                     loc_oObj.RemoveItem(loc_i)
2616:                 ENDFOR
2617:             ENDIF
2618:             IF USED("logftp")
2619:                 SELECT logftp
2620:                 ZAP
2621:                 IF VARTYPE(THIS.grd_4c_GrdInf) = "O"
2622:                     THIS.grd_4c_GrdInf.Refresh()
2623:                 ENDIF
2624:             ENDIF
2625:             IF USED("tmpprog")
2626:                 SELECT tmpprog
2627:                 ZAP
2628:                 IF VARTYPE(THIS.grd_4c_GrdProc) = "O"
2629:                     THIS.grd_4c_GrdProc.Refresh()
2630:                 ENDIF
2631:             ENDIF
2632:             IF VARTYPE(THIS.lbl_4c_Lblprog) = "O"
2633:                 THIS.lbl_4c_Lblprog.Caption = ""
2634:             ENDIF
2635:         CATCH TO loc_oErro
2636:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro LimparCampos")
2637:         ENDTRY
2638:     ENDPROC
2639: 
2640:     *==========================================================================
2641:     * CarregarLista - Recarrega listagens FTP e local (adaptador CRUD)
2642:     *==========================================================================
2643:     PROCEDURE CarregarLista
2644:         RETURN THIS.MontarContainer()
2645:     ENDPROC
2646: 
2647:     *==========================================================================
2648:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo de operacao
2649:     *==========================================================================
2650:     PROCEDURE AjustarBotoesPorModo
2651:         THIS.HabilitarCampos(.T.)
2652:     ENDPROC
2653: 
2654: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigprftpBO.prg):
*==============================================================================
* sigprftpBO.prg - Business Object para Transferencia FTP
* Data: 2026-07-16
* Form Operacional: Transferencia e Recebimento de Arquivos via FTP
* Tabelas: SigCdPam (parametros globais), SigCdEmp (config. por empresa)
*==============================================================================

DEFINE CLASS sigprftpBO AS BusinessBase

    *-- Configuracao de conexao FTP (carregados de SigCdPam/SigCdEmp)
    this_cTpConnect  = ""    && Tipo de conexao: "D"=Dial-Up, "B"=Broadband/Direto
    this_cFtpAdd     = ""    && Endereco do servidor FTP
    this_cFtpUser    = ""    && Usuario FTP
    this_cFtpPass    = ""    && Senha FTP
    this_cDirEnvFtp  = ""    && Dir local de origem para envio ao FTP (_direnvftp)
    this_cDirRecFtp  = ""    && Dir local de destino ao receber do FTP (_dirrecftp)
    this_cDirEnvLoc  = ""    && Dir remoto FTP de origem para recebimento (_direnvloc)
    this_cDirRecLoc  = ""    && Dir remoto FTP de destino para envio (_dirrecloc)
    this_lDelLocal   = .F.   && Excluir arquivo local apos transferencia
    this_lDelHost    = .F.   && Excluir arquivo no FTP apos recebimento
    this_cTpEnv      = ""    && Mascara de arquivos para envio (ex: "*.*")
    this_cTpRec      = ""    && Mascara de arquivos para recebimento (ex: "*.*")
    this_nTpConect   = 0     && Tipo execucao: 0=manual, 1=auto-envio, 2=auto-recebimento

    *-- Parametros globais do sistema (SigCdPam)
    this_cTpTrans    = ""    && tptrans    char(6)  - Tipo de transacao
    this_cEmpMasters = ""    && empmasters char(3)  - Empresa master
    this_cGruMccrs   = ""    && grumccrs   char(10) - Grupo Mercosul
    this_cConMccrs   = ""    && conmccrs   char(10) - Conta Mercosul
    this_cVendNts    = ""    && vendnts    char(10) - Vendas NTS

    *-- Configuracao FTP da empresa (SigCdEmp)
    this_cTpConexaoEmp = ""  && tpconexao  char(1)  - Tipo de conexao da empresa
    this_cFtpAddEmp    = ""  && ftpend     char(50) - Endereco FTP da empresa
    this_cFtpUserEmp   = ""  && ftpusuario char(50) - Usuario FTP da empresa
    this_cFtpPassEmp   = ""  && ftpsenha   char(20) - Senha FTP da empresa (criptografada)
    this_cDriveTs      = ""  && drivets    char(60) - Drive/dir local de envio para FTP
    this_cDriveLs      = ""  && drivels    char(60) - Drive/dir local de recebimento do FTP
    this_cDirFtpTs     = ""  && dirftpts   char(60) - Diretorio remoto FTP de destino (envio)
    this_cDirFtpLs     = ""  && dirftpls   char(60) - Diretorio remoto FTP de origem (recebimento)
    this_lLocDel       = .F. && locdel     bit      - Excluir local apos transferencia
    this_lFtpDel       = .F. && ftpdel     bit      - Excluir do FTP apos recebimento

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdPam"
        THIS.this_cCampoChave = ""
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametrosSistema - Carrega parametros globais de SigCdPam
    * Retorno: .T. se sucesso
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametrosSistema()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT TOP 1 " + ;
                       "TpTrans, EmpMasters, GruMccrs, ConMccrs, VendNts " + ;
                       "FROM SigCdPam"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam") > 0
                IF USED("cursor_4c_Pam") AND RECCOUNT("cursor_4c_Pam") > 0
                    SELECT cursor_4c_Pam
                    THIS.this_cTpTrans    = TratarNulo(TpTrans,    "C")
                    THIS.this_cEmpMasters = TratarNulo(EmpMasters, "C")
                    THIS.this_cGruMccrs   = TratarNulo(GruMccrs,   "C")
                    THIS.this_cConMccrs   = TratarNulo(ConMccrs,   "C")
                    THIS.this_cVendNts    = TratarNulo(VendNts,    "C")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Par" + CHR(226) + "metros do sistema (SigCdPam) n" + CHR(227) + "o encontrados"
                ENDIF
                IF USED("cursor_4c_Pam")
                    USE IN cursor_4c_Pam
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Erro ao consultar SigCdPam"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarConfiguracaoEmpresa - Carrega config FTP de SigCdEmp
    * par_cCodEmp: codigo da empresa (Cemps)
    * Retorno: .T. se sucesso
    *--------------------------------------------------------------------------
    PROCEDURE CarregarConfiguracaoEmpresa(par_cCodEmp)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT TOP 1 " + ;
                       "TpConexao, FtpEnd, FtpUsuario, FtpSenha, " + ;
                       "DriveTs, DriveLs, DirFtpTs, DirFtpLs, " + ;
                       "LocDel, FtpDel " + ;
                       "FROM SigCdEmp " + ;
                       "WHERE Cemps = " + EscaparSQL(par_cCodEmp)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emp") > 0
                IF USED("cursor_4c_Emp") AND RECCOUNT("cursor_4c_Emp") > 0
                    THIS.CarregarDoCursor("cursor_4c_Emp")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Empresa " + ALLTRIM(par_cCodEmp) + ;
                                              " n" + CHR(227) + "o cadastrada"
                ENDIF
                IF USED("cursor_4c_Emp")
                    USE IN cursor_4c_Emp
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Erro ao consultar SigCdEmp"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega config FTP do cursor SigCdEmp para this_*
    * par_cAliasCursor: nome do cursor com dados de SigCdEmp
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cTpConexaoEmp = TratarNulo(TpConexao,  "C")
                THIS.this_cFtpAddEmp    = TratarNulo(FtpEnd,     "C")
                THIS.this_cFtpUserEmp   = TratarNulo(FtpUsuario, "C")
                THIS.this_cFtpPassEmp   = TratarNulo(FtpSenha,   "C")
                THIS.this_cDriveTs      = TratarNulo(DriveTs,    "C")
                THIS.this_cDriveLs      = TratarNulo(DriveLs,    "C")
                THIS.this_cDirFtpTs     = TratarNulo(DirFtpTs,   "C")
                THIS.this_cDirFtpLs     = TratarNulo(DirFtpLs,   "C")
                THIS.this_lLocDel       = IIF(VARTYPE(LocDel) = "L", LocDel, .F.)
                THIS.this_lFtpDel       = IIF(VARTYPE(FtpDel) = "L", FtpDel, .F.)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Nao aplicavel (form operacional sem CRUD direto)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel (form operacional - sem INSERT em tabela propria)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel (form operacional - sem UPDATE em tabela propria)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        RETURN .T.
    ENDPROC

ENDDEFINE

