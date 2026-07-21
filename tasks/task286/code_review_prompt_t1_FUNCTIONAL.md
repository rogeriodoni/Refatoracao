# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (12)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CONTAINER1. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [NAVEGACAO-PAGINA] Metodo 'Receber' faz ActivePage=2 mas NAO le dados de cursor nem chama CarregarHistorico/CarregarDados. Em forms OPERACIONAL, a navegacao para Page2 DEVE carregar dados da linha selecionada no grid de Page1 (padrao legado: cmd_consulta.Click le do cursor do grid).
- [GRID-HEADER] Header Caption ' Arquivo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Arquivo, Tamanho, Pasta Local, Pasta Host, Status, Memo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption ' Tamanho' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Arquivo, Tamanho, Pasta Local, Pasta Host, Status, Memo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption ' Pasta Local ' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Arquivo, Tamanho, Pasta Local, Pasta Host, Status, Memo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption ' Pasta Host' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Arquivo, Tamanho, Pasta Local, Pasta Host, Status, Memo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption ' Status' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Arquivo, Tamanho, Pasta Local, Pasta Host, Status, Memo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprftp.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2647 linhas total):

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

*-- Linhas 300 a 559:
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
319:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
320:                     loc_oControl.Visible = .T.
321:                 ENDIF
322:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
323:                    loc_oControl.ControlCount > 0
324:                     THIS.TornarControlesVisiveis(loc_oControl)
325:                 ENDIF
326:             ENDIF
327:         ENDFOR
328:     ENDPROC
329: 
330:     *==========================================================================
331:     * Inf - Adiciona mensagem ao cursor logftp (exibido no grd_4c_GrdInf)
332:     * par_cMensagem: texto da mensagem
333:     * par_cCor: "R"=vermelho(erro), "G"=verde(sucesso), "B"=azul(informativo)
334:     * Equivalente ao procedimento Inf() do legado sigprftp.SCX
335:     *==========================================================================
336:     PROCEDURE Inf(par_cMensagem, par_cCor)
337:         IF USED("logftp")
338:             SELECT logftp
339:             APPEND BLANK
340:             REPLACE memo WITH par_cMensagem
341:             REPLACE cor  WITH par_cCor
342:             GO BOTTOM IN logftp
343:             IF VARTYPE(THIS.grd_4c_GrdInf) = "O"
344:                 THIS.grd_4c_GrdInf.Refresh()
345:             ENDIF
346:         ENDIF
347:     ENDPROC
348: 
349:     *==========================================================================
350:     * ConfigurarPaginaLista - Orquestra criacao dos controles operacionais FTP.
351:     * Chamado de InicializarForm apos ConfigurarPageFrame.
352:     * Cria: botoes superiores, conteudo das paginas dos PageFrames,
353:     *        setas de transferencia individual, grid de log (grd_4c_GrdInf).
354:     *==========================================================================
355:     PROTECTED PROCEDURE ConfigurarPaginaLista
356:         *-- Grupo 1: Botoes de acao (superior, transferencia intermediaria, rodape)
357:         THIS.ConfigurarBotoesSuperiores()
358:         THIS.ConfigurarBotoesTransferencia()
359:         THIS.ConfigurarRodape()
360: 
361:         *-- Grupo 2: Areas de dados (conteudo das paginas + grids de log e progresso)
362:         THIS.ConfigurarPaginaDados()
363:     ENDPROC
364: 
365:     *==========================================================================
366:     * ConfigurarPaginaDados - Configura as areas de dados (conteudo) do form:
367:     *   - Conteudo do pgf_4c_Loc (ListBoxes de arquivos locais + paths + botoes ...)
368:     *   - Conteudo do pgf_4c_Ftp (ListBoxes de arquivos remotos + paths + botoes ...)
369:     *   - grd_4c_GrdInf (grid de log de operacoes/mensagens)
370:     *   - grd_4c_GrdProc (grid de progresso das transferencias)
371:     * Em forms OPERACIONAIS a "pagina de dados" nao segue o padrao CRUD
372:     * (Page1=Lista/Page2=Dados). Aqui "dados" = todas as areas que EXIBEM ou
373:     * MANIPULAM dados (arquivos, log, progresso), em oposicao as areas de
374:     * ACAO/COMANDO (botoes). Esta separacao facilita manutencao e permite
375:     * recriar apenas as areas de dados sem tocar nos botoes ja instanciados.
376:     *==========================================================================
377:     PROTECTED PROCEDURE ConfigurarPaginaDados
378:         *-- Conteudo do PageFrame LOCAL (pgfloc)
379:         *--   Page1 "A Enviar"    = txt_4c_Direnvftp + cmd_4c_Cmdbrowloc + lst_4c_Lstenvftp
380:         *--   Page2 "Recebidos"   = txt_4c_Dirrecftp + cmd_4c_Cmdbrowloc + lst_4c_Lstrecftp
381:         THIS.ConfigurarConteudoPgLoc()
382: 
383:         *-- Conteudo do PageFrame FTP (pgfftp)
384:         *--   Page1 "A Baixar"    = txt_4c_Dirrecloc + cmd_4c_Cmdbrowftp + lst_4c_Lstrecloc
385:         *--   Page2 "Enviados"    = txt_4c_Direnvloc + cmd_4c_Cmdbrowftp + lst_4c_Lstenvloc
386:         THIS.ConfigurarConteudoPgFtp()
387: 
388:         *-- Grid de log (GrdInf): mensagens de status coloridas (logftp.cor)
389:         THIS.ConfigurarGrdInf()
390: 
391:         *-- Grid de progresso (GrdProc): arquivo/tamanho/local/host/status (tmpprog)
392:         THIS.ConfigurarGrdProc()
393:     ENDPROC
394: 
395:     *==========================================================================
396:     * ConfigurarBotoesSuperiores - Cria botoes de acao no topo do form:
397:     *   cmd_4c_Cmdload  (Conecta - carrega listagens FTP e local)
398:     *   cmd_4c_Cmdtran  (Transfere - envia todos para FTP)
399:     *   cmd_4c_Cmdrec   (Recebe - baixa todos do FTP)
400:     *   cmd_4c_Cmdsair  (Encerrar - posicao canonica 917)
401:     *   shp_4c_Shape1   (Shape decorativo ao redor do Encerrar)
402:     * Posicoes proporcional ao SCX original (800px -> 1000px).
403:     *==========================================================================
404:     PROTECTED PROCEDURE ConfigurarBotoesSuperiores
405:         LOCAL loc_cIcones, loc_cBmps
406:         loc_cIcones = gc_4c_CaminhoIcones
407:         loc_cBmps   = gc_4c_CaminhoIcones + "..\vbmp\"
408: 
409:         *-- Shape decorativo ao redor do botao Encerrar
410:         THIS.AddObject("shp_4c_Shape1", "Shape")
411:         WITH THIS.shp_4c_Shape1
412:             .Top         = 7
413:             .Left        = 912
414:             .Width       = 90
415:             .Height      = 110
416:             .BackStyle   = 0
417:             .BorderStyle = 0
418:             .BorderColor = RGB(0, 0, 0)
419:             .Visible     = .T.
420:         ENDWITH
421: 
422:         *-- Botao Conecta (cmdload) - carrega listagens FTP e locais
423:         THIS.AddObject("cmd_4c_Cmdload", "CommandButton")
424:         WITH THIS.cmd_4c_Cmdload
425:             .Top             = 12
426:             .Left            = 23
427:             .Width           = 75
428:             .Height          = 75
429:             .Caption         = CHR(92) + "<Conecta"
430:             .FontName        = "Comic Sans MS"
431:             .FontSize        = 8
432:             .FontBold        = .T.
433:             .FontItalic      = .T.
434:             .ForeColor       = RGB(90, 90, 90)
435:             .BackColor       = RGB(255, 255, 255)
436:             .Themes          = .T.
437:             .SpecialEffect   = 0
438:             .WordWrap        = .T.
439:             .AutoSize        = .F.
440:             .PicturePosition = 13
441:             .MousePointer    = 15
442:             .Visible         = .T.
443:         ENDWITH
444:         BINDEVENT(THIS.cmd_4c_Cmdload, "Click", THIS, "CmdCmdloadClick")
445: 
446:         *-- Botao Transfere (cmdtran) - envia todos os arquivos para o FTP
447:         THIS.AddObject("cmd_4c_Cmdtran", "CommandButton")
448:         WITH THIS.cmd_4c_Cmdtran
449:             .Top             = 12
450:             .Left            = 103
451:             .Width           = 75
452:             .Height          = 75
453:             .Caption         = CHR(92) + "<Transfere"
454:             .FontName        = "Comic Sans MS"
455:             .FontSize        = 8
456:             .FontBold        = .T.
457:             .FontItalic      = .T.
458:             .ForeColor       = RGB(90, 90, 90)
459:             .BackColor       = RGB(255, 255, 255)
460:             .Themes          = .T.
461:             .SpecialEffect   = 0
462:             .WordWrap        = .T.
463:             .AutoSize        = .F.
464:             .PicturePosition = 13
465:             .MousePointer    = 15
466:             .Visible         = .T.
467:         ENDWITH
468:         BINDEVENT(THIS.cmd_4c_Cmdtran, "Click", THIS, "CmdCmdtranClick")
469: 
470:         *-- Botao Recebe (cmdrec) - baixa todos os arquivos do FTP
471:         THIS.AddObject("cmd_4c_Cmdrec", "CommandButton")
472:         WITH THIS.cmd_4c_Cmdrec
473:             .Top             = 12
474:             .Left            = 183
475:             .Width           = 75
476:             .Height          = 75
477:             .Caption         = CHR(92) + "<Recebe"
478:             .FontName        = "Comic Sans MS"
479:             .FontSize        = 8
480:             .FontBold        = .T.
481:             .FontItalic      = .T.
482:             .ForeColor       = RGB(90, 90, 90)
483:             .BackColor       = RGB(255, 255, 255)
484:             .Themes          = .T.
485:             .SpecialEffect   = 0
486:             .WordWrap        = .T.
487:             .AutoSize        = .F.
488:             .PicturePosition = 13
489:             .MousePointer    = 15
490:             .Visible         = .T.
491:         ENDWITH
492:         BINDEVENT(THIS.cmd_4c_Cmdrec, "Click", THIS, "CmdCmdrecClick")
493: 
494:         *-- Botao Encerrar (cmdsair) - posicao canonica CLAUDE.md
495:         THIS.AddObject("cmd_4c_Cmdsair", "CommandButton")
496:         WITH THIS.cmd_4c_Cmdsair
497:             .Top             = 12
498:             .Left            = 917
499:             .Width           = 75
500:             .Height          = 75
501:             .Caption         = "Encerrar"
502:             .Cancel          = .T.
503:             .Picture         = loc_cIcones + "cadastro_sair_60.jpg"
504:             .DisabledPicture = loc_cIcones + "cadastro_sair_60.jpg"
505:             .FontName        = "Comic Sans MS"
506:             .FontSize        = 8
507:             .FontBold        = .T.
508:             .FontItalic      = .T.
509:             .ForeColor       = RGB(90, 90, 90)
510:             .BackColor       = RGB(255, 255, 255)
511:             .Themes          = .T.
512:             .SpecialEffect   = 0
513:             .PicturePosition = 13
514:             .WordWrap        = .T.
515:             .AutoSize        = .F.
516:             .MousePointer    = 15
517:             .Visible         = .T.
518:         ENDWITH
519:         BINDEVENT(THIS.cmd_4c_Cmdsair, "Click", THIS, "CmdCmdsairClick")
520: 
521:         *-- Imagens dos botoes de acao (vbmp/ do legado)
522:         IF FILE(loc_cBmps + "a_arrow1.bmp")
523:             THIS.cmd_4c_Cmdload.Picture         = loc_cBmps + "a_arrow1.bmp"
524:             THIS.cmd_4c_Cmdload.DisabledPicture = loc_cBmps + "a_arrow1.bmp"
525:         ENDIF
526:         IF FILE(loc_cBmps + "baix_aut.bmp")
527:             THIS.cmd_4c_Cmdtran.Picture         = loc_cBmps + "baix_aut.bmp"
528:             THIS.cmd_4c_Cmdtran.DisabledPicture = loc_cBmps + "baix_aut.bmp"
529:         ENDIF
530:         IF FILE(loc_cBmps + "d_disk1.bmp")
531:             THIS.cmd_4c_Cmdrec.Picture         = loc_cBmps + "d_disk1.bmp"
532:             THIS.cmd_4c_Cmdrec.DisabledPicture = loc_cBmps + "d_disk1.bmp"
533:         ENDIF
534: 
535:         *-- Labels "MASTER" (decorativos, variam por empresa - ocultos por default)
536:         THIS.AddObject("lbl_4c_Label8", "Label")
537:         WITH THIS.lbl_4c_Label8
538:             .Top       = 138
539:             .Left      = 805
540:             .Caption   = "MASTER"
541:             .FontName  = "Verdana"
542:             .FontSize  = 8
543:             .FontBold  = .T.
544:             .ForeColor = RGB(0, 255, 0)
545:             .BackStyle = 0
546:             .Visible   = .F.
547:         ENDWITH
548: 
549:         THIS.AddObject("lbl_4c_Label9", "Label")
550:         WITH THIS.lbl_4c_Label9
551:             .Top       = 137
552:             .Left      = 804
553:             .Caption   = "MASTER"
554:             .FontName  = "Verdana"
555:             .FontSize  = 8
556:             .FontBold  = .T.
557:             .ForeColor = RGB(255, 0, 0)
558:             .BackStyle = 0
559:             .Visible   = .F.

*-- Linhas 566 a 736:
566:     *   Page2 ("Recebidos")   = arquivos locais recebidos do FTP
567:     * Cada pagina: TextBox (caminho) + botao "..." + ListBox (arquivos)
568:     *==========================================================================
569:     PROTECTED PROCEDURE ConfigurarConteudoPgLoc
570:         LOCAL loc_oPgLoc, loc_oPage1, loc_oPage2
571:         loc_oPgLoc = THIS.cnt_4c_Container1.pgf_4c_Loc
572: 
573:         *-- Captions e cores das abas (do SCX original)
574:         loc_oPgLoc.Page1.Caption   = "A Enviar"
575:         loc_oPgLoc.Page1.FontBold  = .T.
576:         loc_oPgLoc.Page1.FontName  = "Verdana"
577:         loc_oPgLoc.Page1.FontSize  = 8
578:         loc_oPgLoc.Page1.BackColor = RGB(255, 255, 255)
579:         loc_oPgLoc.Page1.ForeColor = RGB(0, 0, 255)
580:         loc_oPgLoc.Page2.Caption   = "Recebidos"
581:         loc_oPgLoc.Page2.FontBold  = .T.
582:         loc_oPgLoc.Page2.FontName  = "Verdana"
583:         loc_oPgLoc.Page2.FontSize  = 8
584:         loc_oPgLoc.Page2.BackColor = RGB(255, 255, 255)
585:         loc_oPgLoc.Page2.ForeColor = RGB(255, 0, 0)
586: 
587:         *-- PAGE 1: A Enviar (arquivos locais que serao enviados ao FTP)
588:         loc_oPage1 = loc_oPgLoc.Page1
589:         loc_oPage1.AddObject("txt_4c_Direnvftp", "TextBox")
590:         WITH loc_oPage1.txt_4c_Direnvftp
591:             .Top      = 2
592:             .Left     = 2
593:             .Width    = 217
594:             .Height   = 23
595:             .Value    = ""
596:             .FontName = "Verdana"
597:             .FontSize = 8
598:             .ReadOnly = .T.
599:             .Visible  = .T.
600:         ENDWITH
601: 
602:         loc_oPage1.AddObject("cmd_4c_BrowlocEnvio", "CommandButton")
603:         WITH loc_oPage1.cmd_4c_BrowlocEnvio
604:             .Top      = 2
605:             .Left     = 222
606:             .Width    = 22
607:             .Height   = 22
608:             .Caption  = "..."
609:             .Enabled  = .F.
610:             .FontName = "Verdana"
611:             .FontSize = 8
612:             .ForeColor = RGB(36, 84, 155)
613:             .BackColor = RGB(255, 255, 255)
614:             .Themes   = .F.
615:             .Visible  = .T.
616:         ENDWITH
617:         BINDEVENT(loc_oPage1.cmd_4c_BrowlocEnvio, "Click", THIS, "CmdBrowlocEnvioClick")
618: 
619:         loc_oPage1.AddObject("obj_4c_Lstenvftp", "ListBox")
620:         WITH loc_oPage1.obj_4c_Lstenvftp
621:             .Top          = 26
622:             .Left         = 2
623:             .Width        = 286
624:             .Height       = 130
625:             .ColumnCount  = 3
626:             .ColumnWidths = "130,62,83"
627:             .ColumnLines  = .T.
628:             .RowSourceType = 0
629:             .MultiSelect  = .T.
630:             .FontName     = "Verdana"
631:             .FontSize     = 8
632:             .Visible      = .T.
633:         ENDWITH
634: 
635:         *-- PAGE 2: Recebidos (destino local dos arquivos recebidos do FTP)
636:         loc_oPage2 = loc_oPgLoc.Page2
637:         loc_oPage2.AddObject("txt_4c_Dirrecftp", "TextBox")
638:         WITH loc_oPage2.txt_4c_Dirrecftp
639:             .Top      = 2
640:             .Left     = 2
641:             .Width    = 217
642:             .Height   = 23
643:             .Value    = ""
644:             .FontName = "Verdana"
645:             .FontSize = 8
646:             .ReadOnly = .T.
647:             .Visible  = .T.
648:         ENDWITH
649: 
650:         loc_oPage2.AddObject("cmd_4c_BrowlocReceb", "CommandButton")
651:         WITH loc_oPage2.cmd_4c_BrowlocReceb
652:             .Top      = 2
653:             .Left     = 222
654:             .Width    = 22
655:             .Height   = 22
656:             .Caption  = "..."
657:             .Enabled  = .F.
658:             .FontName = "Verdana"
659:             .FontSize = 8
660:             .ForeColor = RGB(36, 84, 155)
661:             .BackColor = RGB(255, 255, 255)
662:             .Themes   = .F.
663:             .Visible  = .T.
664:         ENDWITH
665:         BINDEVENT(loc_oPage2.cmd_4c_BrowlocReceb, "Click", THIS, "CmdBrowlocRecebClick")
666: 
667:         loc_oPage2.AddObject("obj_4c_Lstrecftp", "ListBox")
668:         WITH loc_oPage2.obj_4c_Lstrecftp
669:             .Top          = 26
670:             .Left         = 2
671:             .Width        = 286
672:             .Height       = 130
673:             .ColumnCount  = 3
674:             .ColumnWidths = "135,58,82"
675:             .ColumnLines  = .T.
676:             .RowSourceType = 0
677:             .MultiSelect  = .T.
678:             .FontName     = "Verdana"
679:             .FontSize     = 8
680:             .Visible      = .T.
681:         ENDWITH
682: 
683:         BINDEVENT(loc_oPgLoc.Page1, "Activate", THIS, "PgLocPage1Activate")
684:         BINDEVENT(loc_oPgLoc.Page2, "Activate", THIS, "PgLocPage2Activate")
685: 
686:         THIS.TornarControlesVisiveis(loc_oPage1)
687:         THIS.TornarControlesVisiveis(loc_oPage2)
688:     ENDPROC
689: 
690:     *==========================================================================
691:     * ConfigurarConteudoPgFtp - Popula as 2 paginas do pgf_4c_Ftp:
692:     *   Page1 ("Enviados")   = arquivos enviados / destino remoto FTP
693:     *   Page2 ("A Receber")  = arquivos remotos FTP disponiveis para baixar
694:     * Cada pagina: TextBox (caminho FTP) + botao "..." + ListBox
695:     *==========================================================================
696:     PROTECTED PROCEDURE ConfigurarConteudoPgFtp
697:         LOCAL loc_oPgFtp, loc_oPage1, loc_oPage2
698:         loc_oPgFtp = THIS.cnt_4c_Container1.pgf_4c_Ftp
699: 
700:         *-- Captions e cores das abas (do SCX original)
701:         loc_oPgFtp.Page1.Caption   = "Enviados"
702:         loc_oPgFtp.Page1.FontBold  = .T.
703:         loc_oPgFtp.Page1.FontName  = "Verdana"
704:         loc_oPgFtp.Page1.FontSize  = 8
705:         loc_oPgFtp.Page1.BackColor = RGB(255, 255, 255)
706:         loc_oPgFtp.Page1.ForeColor = RGB(0, 0, 255)
707:         loc_oPgFtp.Page2.Caption   = "A Receber"
708:         loc_oPgFtp.Page2.FontBold  = .T.
709:         loc_oPgFtp.Page2.FontName  = "Verdana"
710:         loc_oPgFtp.Page2.FontSize  = 8
711:         loc_oPgFtp.Page2.BackColor = RGB(255, 255, 255)
712:         loc_oPgFtp.Page2.ForeColor = RGB(255, 0, 0)
713: 
714:         *-- PAGE 1: Enviados (diretorio remoto FTP de destino dos enviados)
715:         loc_oPage1 = loc_oPgFtp.Page1
716:         loc_oPage1.AddObject("txt_4c_Dirrecloc", "TextBox")
717:         WITH loc_oPage1.txt_4c_Dirrecloc
718:             .Top      = 2
719:             .Left     = 2
720:             .Width    = 217
721:             .Height   = 23
722:             .Value    = ""
723:             .FontName = "Verdana"
724:             .FontSize = 8
725:             .ReadOnly = .T.
726:             .Visible  = .T.
727:         ENDWITH
728: 
729:         loc_oPage1.AddObject("cmd_4c_BrowftpEnviados", "CommandButton")
730:         WITH loc_oPage1.cmd_4c_BrowftpEnviados
731:             .Top      = 2
732:             .Left     = 223
733:             .Width    = 22
734:             .Height   = 22
735:             .Caption  = "..."
736:             .Enabled  = .F.

*-- Linhas 805 a 914:
805:             .Visible      = .T.
806:         ENDWITH
807: 
808:         BINDEVENT(loc_oPgFtp.Page1, "Activate", THIS, "PgFtpPage1Activate")
809:         BINDEVENT(loc_oPgFtp.Page2, "Activate", THIS, "PgFtpPage2Activate")
810: 
811:         THIS.TornarControlesVisiveis(loc_oPage1)
812:         THIS.TornarControlesVisiveis(loc_oPage2)
813:     ENDPROC
814: 
815:     *==========================================================================
816:     * ConfigurarBotoesTransferencia - Cria as setas de transferencia individual
817:     * dentro do cnt_4c_Container1 (entre pgf_4c_Loc e pgf_4c_Ftp):
818:     *   cmd_4c_Cmdtransfere (>) transfere arquivo selecionado local->FTP
819:     *   cmd_4c_Cmdrecebe    (<) recebe arquivo selecionado FTP->local
820:     *==========================================================================
821:     PROTECTED PROCEDURE ConfigurarBotoesTransferencia
822:         LOCAL loc_oCnt
823:         loc_oCnt = THIS.cnt_4c_Container1
824: 
825:         loc_oCnt.AddObject("cmd_4c_Cmdtransfere", "CommandButton")
826:         WITH loc_oCnt.cmd_4c_Cmdtransfere
827:             .Top         = 83
828:             .Left        = 299
829:             .Width       = 25
830:             .Height      = 24
831:             .Caption     = ""
832:             .ToolTipText = "Transfere para FTP"
833:             .FontName    = "Verdana"
834:             .FontSize    = 8
835:             .ForeColor   = RGB(36, 84, 155)
836:             .BackColor   = RGB(255, 255, 255)
837:             .Enabled     = .T.
838:             .Visible     = .T.
839:         ENDWITH
840:         BINDEVENT(loc_oCnt.cmd_4c_Cmdtransfere, "Click", THIS, "CmdCmdtransfereClick")
841: 
842:         loc_oCnt.AddObject("cmd_4c_Cmdrecebe", "CommandButton")
843:         WITH loc_oCnt.cmd_4c_Cmdrecebe
844:             .Top         = 116
845:             .Left        = 299
846:             .Width       = 25
847:             .Height      = 24
848:             .Caption     = ""
849:             .ToolTipText = "Recebe do FTP"
850:             .FontName    = "Verdana"
851:             .FontSize    = 8
852:             .ForeColor   = RGB(36, 84, 155)
853:             .BackColor   = RGB(255, 255, 255)
854:             .Enabled     = .F.
855:             .Visible     = .T.
856:         ENDWITH
857:         BINDEVENT(loc_oCnt.cmd_4c_Cmdrecebe, "Click", THIS, "CmdCmdrecebeClick")
858: 
859:         *-- Imagens das setas de transferencia individual (vbmp/ legado)
860:         LOCAL loc_cVbmp
861:         loc_cVbmp = gc_4c_CaminhoIcones + "..\vbmp\"
862:         IF FILE(loc_cVbmp + "b_arrow2.bmp")
863:             loc_oCnt.cmd_4c_Cmdtransfere.Picture = loc_cVbmp + "b_arrow2.bmp"
864:         ENDIF
865:         IF FILE(loc_cVbmp + "b_arrow1.bmp")
866:             loc_oCnt.cmd_4c_Cmdrecebe.Picture = loc_cVbmp + "b_arrow1.bmp"
867:         ENDIF
868:     ENDPROC
869: 
870:     *==========================================================================
871:     * ConfigurarGrdInf - Grid de log de operacoes FTP (equivalente ao GrdInf)
872:     * RecordSource = "logftp" | DynamicBackColor/ForeColor por cor (R/G/B)
873:     *==========================================================================
874:     PROTECTED PROCEDURE ConfigurarGrdInf
875:         LOCAL loc_oGrid
876:         THIS.AddObject("grd_4c_GrdInf", "Grid")
877:         loc_oGrid = THIS.grd_4c_GrdInf
878:         WITH loc_oGrid
879:             .Top                = 323
880:             .Left               = 89
881:             .Width              = 622
882:             .Height             = 52
883:             .ColumnCount        = 1
884:             .RecordMark         = .F.
885:             .DeleteMark         = .F.
886:             .GridLines          = 0
887:             .GridLineWidth      = 1
888:             .GridLineColor      = RGB(192, 192, 192)
889:             .HeaderHeight       = 0
890:             .HighlightStyle     = 2
891:             .HighlightBackColor = RGB(255, 255, 255)
892:             .ScrollBars         = 2
893:             .RowHeight          = 14
894:             .FontBold           = .T.
895:             .FontSize           = 8
896:             .ReadOnly           = .T.
897:             .TabStop            = .F.
898:             .RecordSource       = "logftp"
899:             .ForeColor          = RGB(0, 0, 0)
900:             .BackColor          = RGB(255, 255, 255)
901:             .Visible            = .T.
902:         ENDWITH
903:         WITH loc_oGrid.Column1
904:             .FontBold       = .T.
905:             .FontName       = "Arial"
906:             .FontSize       = 8
907:             .Alignment      = 0
908:             .Width          = 599
909:             .ControlSource  = "logftp.memo"
910:             .ReadOnly       = .T.
911:             .ForeColor      = RGB(0, 0, 0)
912:             .BackColor      = RGB(255, 255, 255)
913:             .Header1.FontBold  = .T.
914:             .Header1.FontName  = "Arial"

*-- Linhas 931 a 974:
931:     * RecordSource = "tmpprog" | 5 colunas: arquivo, tamanho, pasta local,
932:     *   pasta host, status
933:     *==========================================================================
934:     PROTECTED PROCEDURE ConfigurarGrdProc
935:         LOCAL loc_oGrid
936:         THIS.AddObject("grd_4c_GrdProc", "Grid")
937:         loc_oGrid = THIS.grd_4c_GrdProc
938:         WITH loc_oGrid
939:             .Top            = 376
940:             .Left           = 89
941:             .Width          = 622
942:             .Height         = 114
943:             .ColumnCount    = 5
944:             .RecordMark     = .F.
945:             .DeleteMark     = .F.
946:             .GridLines      = 0
947:             .HeaderHeight   = 15
948:             .RowHeight      = 15
949:             .FontSize       = 8
950:             .ReadOnly       = .T.
951:             .TabStop        = .F.
952:             .RecordSource   = "tmpprog"
953:             .ToolTipText    = "Progresso das Opera" + CHR(231) + CHR(245) + "es de Envio e Recebimento"
954:             .Visible        = .T.
955:         ENDWITH
956:         WITH loc_oGrid.Column1
957:             .FontSize      = 8
958:             .Width         = 81
959:             .ControlSource = "tmpprog.file"
960:             .ReadOnly      = .T.
961:             .ForeColor     = RGB(0, 0, 0)
962:             .BackColor     = RGB(255, 255, 255)
963:             .Header1.Caption = " Arquivo"
964:             .Header1.FontSize = 8
965:         ENDWITH
966:         WITH loc_oGrid.Column2
967:             .FontSize      = 8
968:             .Width         = 63
969:             .ControlSource = "tmpprog.size"
970:             .ReadOnly      = .T.
971:             .ForeColor     = RGB(0, 0, 0)
972:             .BackColor     = RGB(255, 255, 255)
973:             .Header1.Caption = " Tamanho"
974:             .Header1.FontSize = 8

*-- Linhas 1009 a 1318:
1009:     * ConfigurarRodape - Label de progresso, ComboBox de provedores Dial-Up
1010:     * e botao de conexao Dial-Up (cmdconect)
1011:     *==========================================================================
1012:     PROTECTED PROCEDURE ConfigurarRodape
1013:         *-- Label de progresso de operacoes (lblprog)
1014:         THIS.AddObject("lbl_4c_Lblprog", "Label")
1015:         WITH THIS.lbl_4c_Lblprog
1016:             .Top       = 512
1017:             .Left      = 245
1018:             .Width     = 437
1019:             .Height    = 16
1020:             .Caption   = ""
1021:             .FontBold  = .T.
1022:             .FontName  = "Verdana"
1023:             .FontSize  = 10
1024:             .BackStyle = 0
1025:             .ForeColor = RGB(36, 84, 155)
1026:             .TabStop   = .F.
1027:             .Visible   = .T.
1028:         ENDWITH
1029: 
1030:         *-- Botao Dial-Up (cmdconect) - conecta via RAS
1031:         THIS.AddObject("cmd_4c_Cmdconect", "CommandButton")
1032:         WITH THIS.cmd_4c_Cmdconect
1033:             .Top       = 534
1034:             .Left      = 332
1035:             .Width     = 76
1036:             .Height    = 54
1037:             .Caption   = "Rede " + CHR(92) + "<Dial-Up"
1038:             .FontBold  = .T.
1039:             .FontItalic = .T.
1040:             .FontName  = "Comic Sans MS"
1041:             .FontSize  = 7
1042:             .ForeColor = RGB(90, 90, 90)
1043:             .BackColor = RGB(255, 255, 255)
1044:             .Themes    = .F.
1045:             .PicturePosition = 13
1046:             .WordWrap  = .T.
1047:             .Visible   = .T.
1048:         ENDWITH
1049:         BINDEVENT(THIS.cmd_4c_Cmdconect, "Click", THIS, "CmdCmdconectClick")
1050: 
1051:         *-- Imagem do botao de conexao Dial-Up (vbmp/ legado)
1052:         LOCAL loc_cVbmp
1053:         loc_cVbmp = gc_4c_CaminhoIcones + "..\vbmp\"
1054:         IF FILE(loc_cVbmp + "c_comm1.bmp")
1055:             THIS.cmd_4c_Cmdconect.Picture         = loc_cVbmp + "c_comm1.bmp"
1056:             THIS.cmd_4c_Cmdconect.DisabledPicture = loc_cVbmp + "c_comm1.bmp"
1057:         ENDIF
1058: 
1059:         *-- ComboBox de provedores Dial-Up (CboProvedor)
1060:         THIS.AddObject("cbo_4c_CboProvedor", "ComboBox")
1061:         WITH THIS.cbo_4c_CboProvedor
1062:             .Top           = 550
1063:             .Left          = 90
1064:             .Width         = 235
1065:             .Height        = 24
1066:             .RowSourceType = 0
1067:             .Style         = 2
1068:             .Value         = 0
1069:             .FontName      = "Verdana"
1070:             .FontSize      = 8
1071:             .Visible       = .T.
1072:         ENDWITH
1073:         BINDEVENT(THIS.cbo_4c_CboProvedor, "InteractiveChange", THIS, "CboProvedorInteractiveChange")
1074:     ENDPROC
1075: 
1076:     *==========================================================================
1077:     * AlternarPagina - Sincroniza pgf_4c_Loc e pgf_4c_Ftp para mesma pagina
1078:     * e habilita/desabilita setas de transferencia individual:
1079:     *   par_nPagina=1  Envio (local->FTP): seta > habilitada
1080:     *   par_nPagina=2  Recebimento (FTP->local): seta < habilitada
1081:     * Guard this_lAlternandoPagina evita recursao entre Activate handlers.
1082:     *==========================================================================
1083:     PROCEDURE AlternarPagina(par_nPagina)
1084:         LOCAL loc_oCnt, loc_oErro
1085:         IF THIS.this_lAlternandoPagina OR par_nPagina < 1 OR par_nPagina > 2
1086:             RETURN
1087:         ENDIF
1088:         THIS.this_lAlternandoPagina = .T.
1089:         TRY
1090:             loc_oCnt = THIS.cnt_4c_Container1
1091:             IF loc_oCnt.pgf_4c_Loc.ActivePage != par_nPagina
1092:                 loc_oCnt.pgf_4c_Loc.ActivePage = par_nPagina
1093:             ENDIF
1094:             IF loc_oCnt.pgf_4c_Ftp.ActivePage != par_nPagina
1095:                 loc_oCnt.pgf_4c_Ftp.ActivePage = par_nPagina
1096:             ENDIF
1097:             loc_oCnt.cmd_4c_Cmdtransfere.Enabled = (par_nPagina = 1)
1098:             loc_oCnt.cmd_4c_Cmdrecebe.Enabled    = (par_nPagina = 2)
1099:         CATCH TO loc_oErro
1100:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
1101:         ENDTRY
1102:         THIS.this_lAlternandoPagina = .F.
1103:     ENDPROC
1104: 
1105:     *-- Handlers de sincronizacao de paginas (via BINDEVENT nos Activate das Pages)
1106:     PROCEDURE PgLocPage1Activate
1107:         THIS.AlternarPagina(1)
1108:     ENDPROC
1109: 
1110:     PROCEDURE PgLocPage2Activate
1111:         THIS.AlternarPagina(2)
1112:     ENDPROC
1113: 
1114:     PROCEDURE PgFtpPage1Activate
1115:         THIS.AlternarPagina(1)
1116:     ENDPROC
1117: 
1118:     PROCEDURE PgFtpPage2Activate
1119:         THIS.AlternarPagina(2)
1120:     ENDPROC
1121: 
1122:     *==========================================================================
1123:     * CmdCmdsairClick - Encerra o formulario FTP
1124:     *==========================================================================
1125:     PROCEDURE CmdCmdsairClick
1126:         THIS.Release()
1127:     ENDPROC
1128: 
1129:     *==========================================================================
1130:     * CmdBrowlocEnvioClick - Seleciona pasta local de onde serao enviados
1131:     *                        os arquivos ao FTP (direnvftp)
1132:     *==========================================================================
1133:     PROCEDURE CmdBrowlocEnvioClick
1134:         LOCAL loc_cDir
1135:         loc_cDir = GETDIRECTORY("Selecione a pasta de envio")
1136:         IF !EMPTY(loc_cDir)
1137:             THIS.cnt_4c_Container1.pgf_4c_Loc.Page1.txt_4c_Direnvftp.Value = loc_cDir
1138:             THIS.this_cDirEnvFtp = loc_cDir
1139:         ENDIF
1140:     ENDPROC
1141: 
1142:     *==========================================================================
1143:     * CmdBrowlocRecebClick - Seleciona pasta local de destino dos arquivos
1144:     *                        recebidos do FTP (dirrecftp)
1145:     *==========================================================================
1146:     PROCEDURE CmdBrowlocRecebClick
1147:         LOCAL loc_cDir
1148:         loc_cDir = GETDIRECTORY("Selecione a pasta de recebimento")
1149:         IF !EMPTY(loc_cDir)
1150:             THIS.cnt_4c_Container1.pgf_4c_Loc.Page2.txt_4c_Dirrecftp.Value = loc_cDir
1151:             THIS.this_cDirRecFtp = loc_cDir
1152:         ENDIF
1153:     ENDPROC
1154: 
1155:     *==========================================================================
1156:     * CmdCmdloadClick - Conecta e carrega listagens de arquivos:
1157:     *   1. Desabilita botao para evitar clique duplo
1158:     *   2. Chama MontarContainer (listagem FTP + local)
1159:     *   3. Reabilita botao
1160:     *==========================================================================
1161:     PROCEDURE CmdCmdloadClick
1162:         LOCAL loc_lOk, loc_nAtivas, loc_oErro
1163:         loc_lOk = .T.
1164:         THIS.cmd_4c_Cmdload.Enabled = .F.
1165:         TRY
1166:             DO CASE
1167:                 CASE THIS.this_cTpConnect = "D"
1168:                     PUBLIC ARRAY aAtivas(1)
1169:                     loc_nAtivas = THIS.RasAtivas("aAtivas")
1170:                     IF loc_nAtivas > 0
1171:                         THIS.Inf("Este computador j" + CHR(225) + " est" + CHR(225) + ;
1172:                                  " conectado " + CHR(224) + " INTERNET", "B")
1173:                         THIS.MontarContainer()
1174:                     ELSE
1175:                         THIS.Inf("Conex" + CHR(227) + "o " + CHR(224) + ;
1176:                                  " Internet N" + CHR(195) + "O detectada", "R")
1177:                         loc_lOk = .F.
1178:                     ENDIF
1179:                     IF TYPE("aAtivas") = "A"
1180:                         RELEASE aAtivas
1181:                     ENDIF
1182:                 OTHERWISE
1183:                     THIS.MontarContainer()
1184:             ENDCASE
1185:         CATCH TO loc_oErro
1186:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1187:                     " PROC=" + loc_oErro.Procedure, "Erro")
1188:             loc_lOk = .F.
1189:         ENDTRY
1190:         THIS.cmd_4c_Cmdload.Enabled = .T.
1191:         RETURN loc_lOk
1192:     ENDPROC
1193: 
1194:     *==========================================================================
1195:     * CmdCmdtranClick - Transfere TODOS os arquivos listados para o FTP
1196:     *==========================================================================
1197:     PROCEDURE CmdCmdtranClick
1198:         THIS.Transfere("A")
1199:     ENDPROC
1200: 
1201:     *==========================================================================
1202:     * CmdCmdrecClick - Recebe TODOS os arquivos listados do FTP
1203:     *==========================================================================
1204:     PROCEDURE CmdCmdrecClick
1205:         THIS.Receber("A")
1206:     ENDPROC
1207: 
1208:     *==========================================================================
1209:     * CmdCmdtransfereClick - Transfere apenas o arquivo SELECIONADO ao FTP
1210:     *==========================================================================
1211:     PROCEDURE CmdCmdtransfereClick
1212:         THIS.Transfere("I")
1213:     ENDPROC
1214: 
1215:     *==========================================================================
1216:     * CmdCmdrecebeClick - Recebe apenas o arquivo SELECIONADO do FTP
1217:     *==========================================================================
1218:     PROCEDURE CmdCmdrecebeClick
1219:         THIS.Receber("I")
1220:     ENDPROC
1221: 
1222:     *==========================================================================
1223:     * CmdCmdconectClick - Conecta via RAS Dial-Up (se _TpConnect = "D")
1224:     *==========================================================================
1225:     PROCEDURE CmdCmdconectClick
1226:         LOCAL loc_nAtivas, loc_cRun, loc_oErro
1227:         TRY
1228:             DO CASE
1229:                 CASE THIS.this_cTpConnect = "D"
1230:                     PUBLIC ARRAY aAtivas(1)
1231:                     loc_nAtivas = THIS.RasAtivas("aAtivas")
1232:                     IF loc_nAtivas > 0
1233:                         THIS.Inf("Este computador j" + CHR(225) + " est" + CHR(225) + ;
1234:                                  " conectado " + CHR(224) + " INTERNET", "B")
1235:                     ELSE
1236:                         THIS.Inf("Esperando por uma Conex" + CHR(227) + "o " + CHR(224) + ;
1237:                                  " Internet via Dial-UP", "B")
1238:                         IF !EMPTY(THIS.this_cProvedor) AND TYPE("aProvedor") = "A"
1239:                             loc_cRun = "RUN /N Rundll Rnaui.dll,RnaDial " + ALLTRIM(THIS.this_cProvedor)
1240:                             &loc_cRun.
1241:                         ELSE
1242:                             IF EMPTY(THIS.this_cProvedor)
1243:                             THIS.Inf("Nome de Provedor n" + CHR(227) + "o selecionado.", "R")
1244:                             ENDIF
1245:                         ENDIF
1246:                     ENDIF
1247:                     IF TYPE("aAtivas") = "A"
1248:                         RELEASE aAtivas
1249:                     ENDIF
1250:                 OTHERWISE
1251:                     THIS.Inf("Conex" + CHR(227) + "o Broadband: n" + CHR(227) + ;
1252:                              "o requer discagem.", "B")
1253:             ENDCASE
1254:         CATCH TO loc_oErro
1255:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
1256:         ENDTRY
1257:     ENDPROC
1258: 
1259:     *==========================================================================
1260:     * CboProvedorInteractiveChange - Atualiza provedor Dial-Up selecionado
1261:     * quando usuario escolhe diferente item no ComboBox de provedores
1262:     *==========================================================================
1263:     PROCEDURE CboProvedorInteractiveChange
1264:         IF VARTYPE(THIS.cbo_4c_CboProvedor) = "O"
1265:             THIS.this_nProvedor = THIS.cbo_4c_CboProvedor.ListIndex
1266:             THIS.this_cProvedor = ALLTRIM(THIS.cbo_4c_CboProvedor.DisplayValue)
1267:         ENDIF
1268:     ENDPROC
1269: 
1270:     *==========================================================================
1271:     * MontarContainer - Carrega listagens de arquivos FTP e locais nos ListBoxes
1272:     * Equivalente a MontaContainer() do legado SIGPRFTP.SCX
1273:     * Preenche:
1274:     *   pgf_4c_Loc.Page1 -> obj_4c_Lstenvftp  (arquivos locais para enviar)
1275:     *   pgf_4c_Ftp.Page2 -> obj_4c_Lstenvloc  (arquivos FTP a receber)
1276:     *   Caminhos nos TextBoxes de cada pagina
1277:     *==========================================================================
1278:     PROCEDURE MontarContainer
1279:         LOCAL loc_lOk, loc_oCnt, loc_oPgLoc, loc_oPgFtp, loc_oObj
1280:         LOCAL loc_i, loc_aArq, loc_nArq, loc_oErro
1281:         loc_lOk  = .T.
1282:         loc_oCnt   = THIS.cnt_4c_Container1
1283:         loc_oPgLoc = loc_oCnt.pgf_4c_Loc
1284:         loc_oPgFtp = loc_oCnt.pgf_4c_Ftp
1285: 
1286:         THIS.Inf("Carregando par" + CHR(226) + "metros da tela... Aguarde", "B")
1287: 
1288:         *-- Atualizar TextBoxes de caminhos configurados
1289:         IF !EMPTY(THIS.this_cDirEnvFtp)
1290:             loc_oPgLoc.Page1.txt_4c_Direnvftp.Value = THIS.this_cDirEnvFtp
1291:         ENDIF
1292:         IF !EMPTY(THIS.this_cDirRecFtp)
1293:             loc_oPgLoc.Page2.txt_4c_Dirrecftp.Value = THIS.this_cDirRecFtp
1294:         ENDIF
1295:         IF !EMPTY(THIS.this_cDirRecLoc)
1296:             loc_oPgFtp.Page1.txt_4c_Dirrecloc.Value = THIS.this_cDirRecLoc
1297:         ENDIF
1298:         IF !EMPTY(THIS.this_cDirEnvLoc)
1299:             loc_oPgFtp.Page2.txt_4c_Direnvloc.Value = THIS.this_cDirEnvLoc
1300:         ENDIF
1301: 
1302:         *-- [A RECEBER DO HOST] Listagem do FTP (diretorio de envio local)
1303:         IF !EMPTY(THIS.this_cDirEnvLoc)
1304:             THIS.Inf("Estabelecendo conex" + CHR(227) + "o com " + ;
1305:                      THIS.this_cFtpAdd + "...", "B")
1306:             IF THIS.GetFtpDirectory(THIS.this_cDirEnvLoc, "*.*")
1307:                 IF USED("FtpServer")
1308:                     loc_oObj = loc_oPgFtp.Page2.obj_4c_Lstenvloc
1309:                     FOR loc_i = loc_oObj.ListCount TO 1 STEP -1
1310:                         loc_oObj.RemoveItem(loc_i)
1311:                     ENDFOR
1312:                     SELECT FtpServer
1313:                     SCAN
1314:                         loc_oObj.AddItem(ALLTRIM(FtpServer.lcFileName))
1315:                     ENDSCAN
1316:                     THIS.Inf("FTP: " + TRANSFORM(loc_oObj.ListCount) + ;
1317:                              " arquivo(s) encontrado(s)", "G")
1318:                 ENDIF

*-- Linhas 1359 a 1402:
1359:     * par_cTipo: "A" = todos os arquivos | "I" = apenas selecionados
1360:     * Equivalente a transfere() do legado SIGPRFTP.SCX
1361:     *==========================================================================
1362:     PROCEDURE Transfere(par_cTipo)
1363:         LOCAL loc_lOk, loc_oObj, loc_i, loc_nQtd, loc_nTrans, loc_nFalha
1364:         LOCAL loc_cArqLocal, loc_cArqFtp, loc_oErro
1365:         loc_lOk    = .T.
1366:         loc_nTrans = 0
1367:         loc_nFalha = 0
1368: 
1369:         THIS.cnt_4c_Container1.pgf_4c_Loc.ActivePage = 1
1370:         loc_oObj = THIS.cnt_4c_Container1.pgf_4c_Loc.Page1.obj_4c_Lstenvftp
1371: 
1372:         IF loc_oObj.ListCount <= 0
1373:             THIS.Inf("N" + CHR(195) + "O existe nenhum arquivo a ser Transferido para o FTP.", "B")
1374:             RETURN .F.
1375:         ENDIF
1376: 
1377:         loc_nQtd = loc_oObj.ListCount
1378:         TRY
1379:             FOR loc_i = 1 TO loc_nQtd
1380:                 loc_cArqLocal = ALLTRIM(loc_oObj.List(loc_i))
1381:                 IF UPPER(par_cTipo) = "I" AND !loc_oObj.Selected(loc_i)
1382:                     LOOP
1383:                 ENDIF
1384:                 loc_cArqFtp = THIS.this_cDirRecLoc + loc_cArqLocal
1385:                 THIS.Inf("Transferindo " + loc_cArqLocal + " para FTP...", "B")
1386:                 IF THIS.RasftpPut(THIS.this_cFtpAdd, THIS.this_cFtpUser, ;
1387:                                   THIS.this_cFtpPass, ;
1388:                                   THIS.this_cDirEnvFtp + loc_cArqLocal, ;
1389:                                   loc_cArqFtp)
1390:                     loc_nTrans = loc_nTrans + 1
1391:                     IF THIS.this_lDelLocal
1392:                         IF FILE(THIS.this_cDirEnvFtp + loc_cArqLocal)
1393:                             DELETE FILE (THIS.this_cDirEnvFtp + loc_cArqLocal)
1394:                         ENDIF
1395:                     ENDIF
1396:                     THIS.Inf("OK: " + loc_cArqLocal, "G")
1397:                 ELSE
1398:                     loc_nFalha = loc_nFalha + 1
1399:                     THIS.Inf("Falha: " + loc_cArqLocal, "R")
1400:                     loc_lOk = .F.
1401:                 ENDIF
1402:             ENDFOR

*-- Linhas 1415 a 1458:
1415:     * par_cTipo: "A" = todos os arquivos | "I" = apenas selecionados
1416:     * Equivalente a recebe() do legado SIGPRFTP.SCX
1417:     *==========================================================================
1418:     PROCEDURE Receber(par_cTipo)
1419:         LOCAL loc_lOk, loc_oObj, loc_i, loc_nQtd, loc_nTrans, loc_nFalha
1420:         LOCAL loc_cArqFtp, loc_cArqLocal, loc_oErro
1421:         loc_lOk    = .T.
1422:         loc_nTrans = 0
1423:         loc_nFalha = 0
1424: 
1425:         THIS.cnt_4c_Container1.pgf_4c_Ftp.ActivePage = 2
1426:         loc_oObj = THIS.cnt_4c_Container1.pgf_4c_Ftp.Page2.obj_4c_Lstenvloc
1427: 
1428:         IF loc_oObj.ListCount <= 0
1429:             THIS.Inf("N" + CHR(195) + "O existe nenhum arquivo a ser recebido do FTP.", "B")
1430:             RETURN .F.
1431:         ENDIF
1432: 
1433:         loc_nQtd = loc_oObj.ListCount
1434:         TRY
1435:             FOR loc_i = 1 TO loc_nQtd
1436:                 loc_cArqFtp = ALLTRIM(loc_oObj.List(loc_i))
1437:                 IF UPPER(par_cTipo) = "I" AND !loc_oObj.Selected(loc_i)
1438:                     LOOP
1439:                 ENDIF
1440:                 loc_cArqLocal = THIS.this_cDirRecFtp + loc_cArqFtp
1441:                 THIS.Inf("Recebendo " + loc_cArqFtp + " do FTP...", "B")
1442:                 IF THIS.RasftpGet(THIS.this_cFtpAdd, THIS.this_cFtpUser, ;
1443:                                   THIS.this_cFtpPass, ;
1444:                                   THIS.this_cDirEnvLoc + loc_cArqFtp, ;
1445:                                   loc_cArqLocal)
1446:                     loc_nTrans = loc_nTrans + 1
1447:                     IF THIS.this_lDelHost
1448:                         THIS.DeleteFtpFile(THIS.this_cFtpAdd, THIS.this_cFtpUser, ;
1449:                                            THIS.this_cFtpPass, ;
1450:                                            THIS.this_cDirEnvLoc + loc_cArqFtp)
1451:                     ENDIF
1452:                     THIS.Inf("OK: " + loc_cArqFtp, "G")
1453:                 ELSE
1454:                     loc_nFalha = loc_nFalha + 1
1455:                     THIS.Inf("Falha: " + loc_cArqFtp, "R")
1456:                     loc_lOk = .F.
1457:                 ENDIF
1458:             ENDFOR

*-- Linhas 1474 a 1517:
1474:     * Retorno: .T. se sucesso
1475:     * Equivalente a GetFtpDirectory() do legado SIGPRFTP.SCX
1476:     *==========================================================================
1477:     PROCEDURE GetFtpDirectory(par_cDirFtp, par_cMask)
1478:         LOCAL loc_lOk, loc_nInternet, loc_nFtp, loc_nFind, loc_oErro
1479:         LOCAL loc_cStruct, loc_cNull, loc_cName, loc_cResult, loc_lContinuar
1480: 
1481:         loc_lOk      = .F.
1482:         loc_nInternet = 0
1483:         loc_nFtp      = 0
1484: 
1485:         #DEFINE INTERNET_OPEN_TYPE_PRECONFIG   0
1486:         #DEFINE INTERNET_OPEN_TYPE_DIRECT      1
1487:         #DEFINE INTERNET_DEFAULT_FTP_PORT     21
1488:         #DEFINE INTERNET_SERVICE_FTP           1
1489:         #DEFINE INTERNET_FLAG_PASSIVE   14217728
1490:         #DEFINE ERROR_NO_MORE_FILES           18
1491:         #DEFINE MAX_PATH                     260
1492: 
1493:         TRY
1494:             DECLARE Integer InternetOpen IN wininet ;
1495:                 String  sAgent, Integer nAccessType, String sProxy, ;
1496:                 String  sProxyBypass, Integer dwFlags
1497: 
1498:             DECLARE Integer InternetConnect IN wininet ;
1499:                 Integer hInternet, String lpszServerName, ;
1500:                 Integer nServerPort, String lpszUserName, ;
1501:                 String  lpszPassword, Integer dwService, ;
1502:                 Integer dwFlags, Integer dwContext
1503: 
1504:             DECLARE Integer FtpFindFirstFile IN wininet ;
1505:                 Integer hConnect, String lpszSearchFile, ;
1506:                 String @lpFindFileData, Integer dwFlags, Integer dwContext
1507: 
1508:             DECLARE Integer InternetFindNextFile IN wininet ;
1509:                 Integer hFind, String @lpFindFileData
1510: 
1511:             DECLARE Integer InternetCloseHandle IN wininet ;
1512:                 Integer hInet
1513: 
1514:             loc_cStruct = SPACE(592)
1515:             loc_cNull   = CHR(0)
1516: 
1517:             loc_nInternet = InternetOpen("VFP9/FTP", INTERNET_OPEN_TYPE_DIRECT, ;

*-- Linhas 1585 a 1628:
1585:     * Retorno: .T. se sucesso
1586:     * Equivalente a rasftpget() do legado SIGPRFTP.SCX
1587:     *==========================================================================
1588:     PROCEDURE RasftpGet(par_cFtpLoc, par_cFtpUsu, par_cFtpSen, par_cFtpRemArq, par_cFtpLocArq)
1589:         LOCAL loc_lOk, loc_nInternet, loc_nFtp, loc_oErro
1590: 
1591:         loc_lOk      = .F.
1592:         loc_nInternet = 0
1593:         loc_nFtp      = 0
1594: 
1595:         #DEFINE INTERNET_OPEN_TYPE_DIRECT      1
1596:         #DEFINE INTERNET_DEFAULT_FTP_PORT     21
1597:         #DEFINE INTERNET_SERVICE_FTP           1
1598:         #DEFINE INTERNET_FLAG_PASSIVE   14217728
1599:         #DEFINE FILE_ATTRIBUTE_NORMAL        128
1600:         #DEFINE FTP_TRANSFER_TYPE_BINARY       2
1601: 
1602:         TRY
1603:             DECLARE Integer InternetOpen IN wininet ;
1604:                 String  sAgent, Integer nAccessType, String sProxy, ;
1605:                 String  sProxyBypass, Integer dwFlags
1606: 
1607:             DECLARE Integer InternetConnect IN wininet ;
1608:                 Integer hInternet, String lpszServerName, ;
1609:                 Integer nServerPort, String lpszUserName, ;
1610:                 String  lpszPassword, Integer dwService, ;
1611:                 Integer dwFlags, Integer dwContext
1612: 
1613:             DECLARE Integer FtpGetFile IN wininet ;
1614:                 Integer hConnect, String lpszRemoteFile, ;
1615:                 String  lpszNewFile, Integer fFailIfExists, ;
1616:                 Integer dwFlagsAndAttributes, Integer dwFlags, Integer dwContext
1617: 
1618:             DECLARE Integer InternetCloseHandle IN wininet ;
1619:                 Integer hInet
1620: 
1621:             loc_nInternet = InternetOpen("VFP9/FTP", INTERNET_OPEN_TYPE_DIRECT, ;
1622:                                          CHR(0), CHR(0), 0)
1623:             IF loc_nInternet = 0
1624:                 THIS.Inf("Falha ao inicializar WinInet (GET)", "R")
1625:             ELSE
1626:                 loc_nFtp = InternetConnect(loc_nInternet, ;
1627:                                            par_cFtpLoc, ;
1628:                                            INTERNET_DEFAULT_FTP_PORT, ;

*-- Linhas 1666 a 1709:
1666:     * Retorno: .T. se sucesso
1667:     * Equivalente a rasftpPUT() do legado SIGPRFTP.SCX
1668:     *==========================================================================
1669:     PROCEDURE RasftpPut(par_cFtpLoc, par_cFtpUsu, par_cFtpSen, par_cFtpLocArq, par_cFtpRemArq)
1670:         LOCAL loc_lOk, loc_nInternet, loc_nFtp, loc_oErro
1671: 
1672:         loc_lOk      = .F.
1673:         loc_nInternet = 0
1674:         loc_nFtp      = 0
1675: 
1676:         #DEFINE INTERNET_OPEN_TYPE_DIRECT      1
1677:         #DEFINE INTERNET_DEFAULT_FTP_PORT     21
1678:         #DEFINE INTERNET_SERVICE_FTP           1
1679:         #DEFINE INTERNET_FLAG_PASSIVE   14217728
1680:         #DEFINE FTP_TRANSFER_TYPE_BINARY       2
1681: 
1682:         TRY
1683:             DECLARE Integer InternetOpen IN wininet ;
1684:                 String  sAgent, Integer nAccessType, String sProxy, ;
1685:                 String  sProxyBypass, Integer dwFlags
1686: 
1687:             DECLARE Integer InternetConnect IN wininet ;
1688:                 Integer hInternet, String lpszServerName, ;
1689:                 Integer nServerPort, String lpszUserName, ;
1690:                 String  lpszPassword, Integer dwService, ;
1691:                 Integer dwFlags, Integer dwContext
1692: 
1693:             DECLARE Integer FtpPutFile IN wininet ;
1694:                 Integer hConnect, String lpszLocalFile, ;
1695:                 String  lpszNewRemoteFile, Integer dwFlags, Integer dwContext
1696: 
1697:             DECLARE Integer InternetCloseHandle IN wininet ;
1698:                 Integer hInet
1699: 
1700:             IF !FILE(par_cFtpLocArq)
1701:                 THIS.Inf("Arquivo n" + CHR(227) + "o encontrado: " + par_cFtpLocArq, "R")
1702:             ELSE
1703:                 loc_nInternet = InternetOpen("VFP9/FTP", INTERNET_OPEN_TYPE_DIRECT, ;
1704:                                              CHR(0), CHR(0), 0)
1705:                 IF loc_nInternet = 0
1706:                     THIS.Inf("Falha ao inicializar WinInet (PUT)", "R")
1707:                 ELSE
1708:                     loc_nFtp = InternetConnect(loc_nInternet, ;
1709:                                                par_cFtpLoc, ;

*-- Linhas 1740 a 1783:
1740:     * par_cFtpArq: caminho completo do arquivo no FTP
1741:     * Retorno: .T. se sucesso
1742:     *==========================================================================
1743:     PROCEDURE DeleteFtpFile(par_cFtpLoc, par_cFtpUsu, par_cFtpSen, par_cFtpArq)
1744:         LOCAL loc_lOk, loc_nInternet, loc_nFtp, loc_oErro
1745: 
1746:         loc_lOk      = .F.
1747:         loc_nInternet = 0
1748:         loc_nFtp      = 0
1749: 
1750:         #DEFINE INTERNET_OPEN_TYPE_DIRECT     1
1751:         #DEFINE INTERNET_DEFAULT_FTP_PORT    21
1752:         #DEFINE INTERNET_SERVICE_FTP          1
1753:         #DEFINE INTERNET_FLAG_PASSIVE  14217728
1754: 
1755:         TRY
1756:             DECLARE Integer InternetOpen IN wininet ;
1757:                 String  sAgent, Integer nAccessType, String sProxy, ;
1758:                 String  sProxyBypass, Integer dwFlags
1759: 
1760:             DECLARE Integer InternetConnect IN wininet ;
1761:                 Integer hInternet, String lpszServerName, ;
1762:                 Integer nServerPort, String lpszUserName, ;
1763:                 String  lpszPassword, Integer dwService, ;
1764:                 Integer dwFlags, Integer dwContext
1765: 
1766:             DECLARE Integer FtpDeleteFile IN wininet ;
1767:                 Integer hConnect, String lpszFileName
1768: 
1769:             DECLARE Integer InternetCloseHandle IN wininet ;
1770:                 Integer hInet
1771: 
1772:             loc_nInternet = InternetOpen("VFP9/FTP", INTERNET_OPEN_TYPE_DIRECT, ;
1773:                                          CHR(0), CHR(0), 0)
1774:             IF loc_nInternet <> 0
1775:                 loc_nFtp = InternetConnect(loc_nInternet, par_cFtpLoc, ;
1776:                                            INTERNET_DEFAULT_FTP_PORT, ;
1777:                                            par_cFtpUsu, par_cFtpSen, ;
1778:                                            INTERNET_SERVICE_FTP, ;
1779:                                            INTERNET_FLAG_PASSIVE, 0)
1780:                 IF loc_nFtp <> 0
1781:                     loc_lOk = (FtpDeleteFile(loc_nFtp, par_cFtpArq) <> 0)
1782:                     IF !loc_lOk
1783:                         THIS.Inf("Falha ao remover FTP: " + par_cFtpArq, "R")

*-- Linhas 1798 a 1942:
1798:     * par_cBuffer: string de 4 bytes
1799:     * Retorno: inteiro equivalente
1800:     *==========================================================================
1801:     PROCEDURE CToWord(par_cBuffer)
1802:         RETURN ASC(SUBSTR(par_cBuffer, 1, 1)) + ;
1803:                ASC(SUBSTR(par_cBuffer, 2, 1)) * 256 + ;
1804:                ASC(SUBSTR(par_cBuffer, 3, 1)) * 65536 + ;
1805:                ASC(SUBSTR(par_cBuffer, 4, 1)) * 16777216
1806:     ENDPROC
1807: 
1808:     *==========================================================================
1809:     * WordToC - Converte numero inteiro em buffer de 4 bytes (little-endian DWORD)
1810:     * par_nNumber: inteiro a converter
1811:     * Retorno: string de 4 bytes
1812:     *==========================================================================
1813:     PROCEDURE WordToC(par_nNumber)
1814:         RETURN CHR(BITAND(255, par_nNumber)) + ;
1815:                CHR(BITAND(65280, par_nNumber) % 255) + ;
1816:                CHR(BITAND(16711680, par_nNumber) % 255) + ;
1817:                CHR(BITAND(4278190080, par_nNumber) % 255)
1818:     ENDPROC
1819: 
1820:     *==========================================================================
1821:     * SectToHour - Converte segundos em string legivel "Xh, Xm, Xs"
1822:     * par_nSecto: numero de segundos
1823:     * Retorno: string formatada (ex: "1 h, 2 m, 30 s")
1824:     *==========================================================================
1825:     PROCEDURE SectToHour(par_nSecto)
1826:         LOCAL loc_nHora, loc_nMinu, loc_nSeco
1827:         loc_nHora = INT(par_nSecto / 3600)
1828:         loc_nMinu = MOD(INT(par_nSecto / 60), 60)
1829:         loc_nSeco = MOD(par_nSecto, 60)
1830:         RETURN IIF(loc_nHora > 0, ALLTRIM(STR(loc_nHora)) + " h, ", "") + ;
1831:                IIF(loc_nMinu > 0, ALLTRIM(STR(loc_nMinu)) + " m, ", "") + ;
1832:                ALLTRIM(STR(loc_nSeco)) + " s"
1833:     ENDPROC
1834: 
1835:     *==========================================================================
1836:     * CrackAttributes - Extrai atributos de arquivo de buffer WIN32 DWORD (4 bytes)
1837:     * par_cBuffer: 4 primeiros bytes do WIN32_FIND_DATA
1838:     * Retorno: string com letras de atributos (R/H/S/D/A/N/T/C/O)
1839:     *==========================================================================
1840:     PROCEDURE CrackAttributes(par_cBuffer)
1841:         LOCAL loc_cAtributos, loc_nValor
1842:         loc_cAtributos = ""
1843:         loc_nValor = (ASC(SUBSTR(par_cBuffer, 1, 1)) * 1) + ;
1844:                      (ASC(SUBSTR(par_cBuffer, 2, 1)) * 256) + ;
1845:                      (ASC(SUBSTR(par_cBuffer, 3, 1)) * 65536) + ;
1846:                      (ASC(SUBSTR(par_cBuffer, 4, 1)) * 16777216)
1847:         DO CASE
1848:             CASE BITTEST(loc_nValor, 0)
1849:                 loc_cAtributos = loc_cAtributos + "R"
1850:             CASE BITTEST(loc_nValor, 1)
1851:                 loc_cAtributos = loc_cAtributos + "H"
1852:             CASE BITTEST(loc_nValor, 2)
1853:                 loc_cAtributos = loc_cAtributos + "S"
1854:             CASE BITTEST(loc_nValor, 4)
1855:                 loc_cAtributos = loc_cAtributos + "D"
1856:             CASE BITTEST(loc_nValor, 5)
1857:                 loc_cAtributos = loc_cAtributos + "A"
1858:             CASE BITTEST(loc_nValor, 7)
1859:                 loc_cAtributos = loc_cAtributos + "N"
1860:             CASE BITTEST(loc_nValor, 8)
1861:                 loc_cAtributos = loc_cAtributos + "T"
1862:             CASE BITTEST(loc_nValor, 11)
1863:                 loc_cAtributos = loc_cAtributos + "C"
1864:             CASE BITTEST(loc_nValor, 12)
1865:                 loc_cAtributos = loc_cAtributos + "O"
1866:         ENDCASE
1867:         RETURN loc_cAtributos
1868:     ENDPROC
1869: 
1870:     *==========================================================================
1871:     * CrackDate - Converte buffer FILETIME (8 bytes) em string de data dd/mm/aaaa
1872:     * par_cOutBuffer: 8 bytes FILETIME (little-endian Windows)
1873:     * Retorno: string "dd/mm/aaaa" ou "01/01/1901" em caso de falha
1874:     *==========================================================================
1875:     PROCEDURE CrackDate(par_cOutBuffer)
1876:         LOCAL loc_cInBuffer, loc_nResult, loc_nAno, loc_nMes, loc_nDia, loc_cData, loc_oErro
1877:         loc_cInBuffer = SPACE(16)
1878:         loc_cData     = "01/01/1901"
1879:         TRY
1880:             DECLARE Integer FileTimeToSystemTime IN Kernel32 ;
1881:                 String @lpcBuffer, String @lpcBuffer
1882:             loc_nResult = FileTimeToSystemTime(@par_cOutBuffer, @loc_cInBuffer)
1883:             IF loc_nResult <> 0
1884:                 loc_nAno  = ASC(SUBSTR(loc_cInBuffer, 1, 1)) + (ASC(SUBSTR(loc_cInBuffer, 2, 1)) * 256)
1885:                 loc_nMes  = ASC(SUBSTR(loc_cInBuffer, 3, 1)) + (ASC(SUBSTR(loc_cInBuffer, 4, 1)) * 256)
1886:                 loc_nDia  = ASC(SUBSTR(loc_cInBuffer, 7, 1)) + (ASC(SUBSTR(loc_cInBuffer, 8, 1)) * 256)
1887:                 loc_cData = PADL(ALLTRIM(STR(loc_nDia)), 2, "0") + "/" + ;
1888:                             PADL(ALLTRIM(STR(loc_nMes)), 2, "0") + "/" + ;
1889:                             ALLTRIM(STR(loc_nAno))
1890:             ENDIF
1891:         CATCH TO loc_oErro
1892:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro CrackDate")
1893:         ENDTRY
1894:         RETURN loc_cData
1895:     ENDPROC
1896: 
1897:     *==========================================================================
1898:     * CrackFile - Analisa buffer WIN32_FIND_DATA e insere registro no cursor FtpServer
1899:     * par_cBuffer: buffer binario de 319 bytes (WIN32_FIND_DATA)
1900:     * Resultado: INSERT no cursor FtpServer (campos: nome, Tipo, Tama, Data, Atri)
1901:     *==========================================================================
1902:     PROCEDURE CrackFile(par_cBuffer)
1903:         LOCAL loc_cNomeArq, loc_cNomeAlt, loc_nSizeHigh, loc_nSizeLow, loc_nTamanho
1904:         LOCAL loc_cAtributos, loc_cBuffTempo, loc_cDataEsc, loc_cTipo, loc_nAttr, loc_oErro
1905: 
1906:         #DEFINE LOC_MAX_PATH       260
1907:         #DEFINE LOC_MAXDWORD       4294967295
1908:         #DEFINE LOC_FILE_ATTR_DIR  16
1909: 
1910:         TRY
1911:             loc_cNomeArq = SUBSTR(par_cBuffer, 45, LOC_MAX_PATH)
1912:             loc_cNomeAlt = RIGHT(par_cBuffer, 14)
1913:             loc_cNomeArq = LEFT(loc_cNomeArq, AT(CHR(0), loc_cNomeArq) - 1)
1914:             loc_cNomeAlt = LEFT(loc_cNomeAlt, AT(CHR(0), loc_cNomeAlt) - 1)
1915: 
1916:             loc_nSizeHigh = (ASC(SUBSTR(par_cBuffer, 29, 1)) * 1) + ;
1917:                             (ASC(SUBSTR(par_cBuffer, 30, 1)) * 256) + ;
1918:                             (ASC(SUBSTR(par_cBuffer, 31, 1)) * 65536) + ;
1919:                             (ASC(SUBSTR(par_cBuffer, 32, 1)) * 16777216)
1920:             loc_nSizeLow  = (ASC(SUBSTR(par_cBuffer, 33, 1)) * 1) + ;
1921:                             (ASC(SUBSTR(par_cBuffer, 34, 1)) * 256) + ;
1922:                             (ASC(SUBSTR(par_cBuffer, 35, 1)) * 65536) + ;
1923:                             (ASC(SUBSTR(par_cBuffer, 36, 1)) * 16777216)
1924:             loc_nTamanho  = (loc_nSizeHigh * LOC_MAXDWORD) + loc_nSizeLow
1925: 
1926:             loc_nAttr = THIS.CToWord(SUBSTR(par_cBuffer, 1, 4))
1927:             IF loc_nAttr = LOC_FILE_ATTR_DIR
1928:                 loc_cTipo = "Diret" + CHR(243) + "rio"
1929:             ELSE
1930:                 loc_cTipo = "Arquivo"
1931:             ENDIF
1932: 
1933:             loc_cBuffTempo = SUBSTR(par_cBuffer, 21, 8)
1934:             loc_cDataEsc   = THIS.CrackDate(loc_cBuffTempo)
1935:             loc_cAtributos = THIS.CrackAttributes(LEFT(par_cBuffer, 4))
1936: 
1937:             SELECT FtpServer
1938:             INSERT INTO FtpServer VALUES (ALLTRIM(loc_cNomeArq), ;
1939:                                           ALLTRIM(loc_cTipo), ;
1940:                                           TRANSFORM(loc_nTamanho, "9999999999"), ;
1941:                                           loc_cDataEsc, ;
1942:                                           loc_cAtributos)

*-- Linhas 1952 a 2028:
1952:     * par_pTotal : total de passos (usado quando par_pStep eh numerico)
1953:     * par_pMessage: mensagem de status (opcional, tipo C)
1954:     *==========================================================================
1955:     PROCEDURE FileCtrlUp(par_pStep, par_pTotal, par_pMessage)
1956:         LOCAL loc_oErro
1957:         TRY
1958:             IF TYPE("par_pMessage") = "C"
1959:                 IF VARTYPE(THIS.lbl_4c_Lblprog) = "O"
1960:                     THIS.lbl_4c_Lblprog.Caption = par_pMessage
1961:                 ENDIF
1962:             ENDIF
1963:             IF TYPE("par_pStep") = "N" AND TYPE("par_pTotal") = "N" AND par_pTotal > 0
1964:                 IF VARTYPE(THIS.lbl_4c_Lblprog) = "O"
1965:                     THIS.lbl_4c_Lblprog.Caption = TRANSFORM(INT(par_pStep * 100 / par_pTotal)) + "% " + ;
1966:                                                   IIF(TYPE("par_pMessage") = "C", "- " + par_pMessage, "")
1967:                 ENDIF
1968:                 DOEVENTS
1969:             ENDIF
1970:         CATCH TO loc_oErro
1971:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro FileCtrlUp")
1972:         ENDTRY
1973:     ENDPROC
1974: 
1975:     *==========================================================================
1976:     * Processa - Rastreador de progresso chamado durante transferencias FTP
1977:     * Atualiza cursor tmpprog e lbl_4c_Lblprog com andamento da transferencia.
1978:     * par_cArquivo : nome do arquivo em transferencia
1979:     * par_nTamanho : tamanho total em bytes
1980:     * par_cLocal   : diretorio local
1981:     * par_cHost    : diretorio no host FTP
1982:     * par_nTransf  : bytes ja transferidos
1983:     * par_nBuffer  : tamanho do buffer utilizado
1984:     * par_nSecIni  : segundos no inicio (SECONDS())
1985:     * par_nSec     : segundos decorridos
1986:     * par_cStatus  : "I"=Iniciando | "A"=em Andamento | "C"=Concluido
1987:     *==========================================================================
1988:     PROCEDURE Processa(par_cArquivo, par_nTamanho, par_cLocal, par_cHost, ;
1989:                        par_nTransf, par_nBuffer, par_nSecIni, par_nSec, par_cStatus)
1990:         LOCAL loc_nSec, loc_cTiEst, loc_cTiEla, loc_i, loc_oObj, loc_nIdx
1991:         LOCAL loc_cEraseCmd, loc_oErro
1992:         loc_nSec = par_nSec
1993:         IF loc_nSec = 0
1994:             loc_nSec = 0.001
1995:         ENDIF
1996:         TRY
1997:             IF par_cStatus == "I"
1998:                 THIS.FileCtrlUp(.T., .T., "Iniciando a transfer" + CHR(234) + "ncia...")
1999:                 IF USED("tmpprog")
2000:                     SELECT tmpprog
2001:                     APPEND BLANK
2002:                     REPLACE file   WITH par_cArquivo
2003:                     REPLACE size   WITH par_nTamanho
2004:                     REPLACE local  WITH par_cLocal
2005:                     REPLACE host   WITH par_cHost
2006:                     REPLACE status WITH "0 bytes copiados, 0% completado"
2007:                 ENDIF
2008:             ENDIF
2009:             IF par_cStatus == "A"
2010:                 IF USED("tmpprog")
2011:                     SELECT tmpprog
2012:                     LOCATE FOR tmpprog.file = par_cArquivo
2013:                     IF FOUND()
2014:                         REPLACE status WITH TRANSFORM(par_nTransf) + " bytes copiados, " + ;
2015:                                             TRANSFORM(IIF(par_nTamanho > 0, par_nTransf * 100 / par_nTamanho, 0), "99.99") + ;
2016:                                             "% completado"
2017:                         loc_cTiEst = THIS.SectToHour(INT(IIF(par_nTransf > 0, ;
2018:                                           (par_nTamanho - par_nTransf) * loc_nSec / par_nTransf, 0)))
2019:                         loc_cTiEla = THIS.SectToHour(SECONDS() - par_nSecIni)
2020:                         THIS.FileCtrlUp(par_nTransf * 100 / IIF(par_nTamanho > 0, par_nTamanho, 1), ;
2021:                                         100, ;
2022:                                         TRANSFORM(par_nTransf / loc_nSec / 1024, "9999.99") + " Kbps")
2023:                         IF VARTYPE(THIS.lbl_4c_Lblprog) = "O"
2024:                             THIS.lbl_4c_Lblprog.Caption = "Tempo decorrido: " + loc_cTiEla + ;
2025:                                                           "   Tempo Estimado : " + loc_cTiEst
2026:                         ENDIF
2027:                     ENDIF
2028:                 ENDIF

*-- Linhas 2044 a 2105:
2044:                         ENDIF
2045:                         THIS.Inf("Arquivo Transferido...", "B")
2046:                         THIS.FileCtrlUp(.F., .F., "")
2047:                         *-- Atualiza listbox: arquivo enviado local->FTP
2048:                         IF par_cLocal == THIS.this_cDirEnvFtp
2049:                             loc_oObj = THIS.cnt_4c_Container1.pgf_4c_Ftp.Page1.obj_4c_Lstrecloc
2050:                             loc_nIdx = loc_oObj.ListCount + 1
2051:                             loc_oObj.AddItem(par_cArquivo, loc_nIdx, 1)
2052:                             loc_oObj.AddListItem(TRANSFORM(par_nTamanho), loc_nIdx, 2)
2053:                             loc_oObj.AddListItem(TRANSFORM(par_nTransf), loc_nIdx, 3)
2054:                             loc_oObj.Refresh()
2055:                             IF THIS.this_lDelLocal
2056:                                 IF FILE(THIS.this_cDirEnvFtp + par_cArquivo)
2057:                                     THIS.Inf("Excluindo arquivo local " + THIS.this_cDirEnvFtp + par_cArquivo, "B")
2058:                                     loc_cEraseCmd = "ERASE " + THIS.this_cDirEnvFtp + par_cArquivo
2059:                                     &loc_cEraseCmd
2060:                                     IF FILE(THIS.this_cDirEnvFtp + par_cArquivo)
2061:                                         THIS.Inf("Falha na exclus" + CHR(227) + "o do arquivo local " + par_cArquivo, "R")
2062:                                     ELSE
2063:                                         THIS.Inf("Arquivo local " + par_cArquivo + " exclu" + CHR(237) + "do.", "B")
2064:                                         FOR loc_i = 1 TO THIS.cnt_4c_Container1.pgf_4c_Loc.Page1.obj_4c_Lstenvftp.ListCount
2065:                                             IF UPPER(ALLTRIM(THIS.cnt_4c_Container1.pgf_4c_Loc.Page1.obj_4c_Lstenvftp.List(loc_i, 1))) = UPPER(par_cArquivo)
2066:                                                 THIS.cnt_4c_Container1.pgf_4c_Loc.Page1.obj_4c_Lstenvftp.RemoveItem(loc_i)
2067:                                                 EXIT
2068:                                             ENDIF
2069:                                         ENDFOR
2070:                                     ENDIF
2071:                                 ENDIF
2072:                             ENDIF
2073:                         ENDIF
2074:                         *-- Atualiza listbox: arquivo recebido FTP->local
2075:                         IF par_cHost == THIS.this_cDirEnvLoc
2076:                             loc_oObj = THIS.cnt_4c_Container1.pgf_4c_Loc.Page2.obj_4c_Lstrecftp
2077:                             loc_nIdx = loc_oObj.ListCount + 1
2078:                             loc_oObj.AddItem(par_cArquivo, loc_nIdx, 1)
2079:                             loc_oObj.AddListItem(TRANSFORM(par_nTamanho), loc_nIdx, 2)
2080:                             loc_oObj.AddListItem(TRANSFORM(par_nTransf), loc_nIdx, 3)
2081:                             loc_oObj.Refresh()
2082:                             IF THIS.this_lDelHost
2083:                                 THIS.Inf("Excluindo arquivo FTP " + THIS.this_cDirEnvLoc + par_cArquivo, "B")
2084:                                 IF THIS.DeleteFtpFile(THIS.this_cFtpAdd, THIS.this_cFtpUser, ;
2085:                                                       THIS.this_cFtpPass, ;
2086:                                                       THIS.this_cDirEnvLoc + par_cArquivo)
2087:                                     THIS.Inf("Arquivo FTP " + par_cArquivo + " exclu" + CHR(237) + "do.", "B")
2088:                                     FOR loc_i = 1 TO THIS.cnt_4c_Container1.pgf_4c_Ftp.Page2.obj_4c_Lstenvloc.ListCount
2089:                                         IF UPPER(ALLTRIM(THIS.cnt_4c_Container1.pgf_4c_Ftp.Page2.obj_4c_Lstenvloc.List(loc_i, 1))) = UPPER(par_cArquivo)
2090:                                             THIS.cnt_4c_Container1.pgf_4c_Ftp.Page2.obj_4c_Lstenvloc.RemoveItem(loc_i)
2091:                                             EXIT
2092:                                         ENDIF
2093:                                     ENDFOR
2094:                                 ELSE
2095:                                     THIS.Inf("Falha na exclus" + CHR(227) + "o FTP " + par_cArquivo, "R")
2096:                                 ENDIF
2097:                             ENDIF
2098:                         ENDIF
2099:                     ENDIF
2100:                 ENDIF
2101:             ENDIF
2102:             IF VARTYPE(THIS.grd_4c_GrdProc) = "O"
2103:                 THIS.grd_4c_GrdProc.Refresh()
2104:             ENDIF
2105:         CATCH TO loc_oErro

*-- Linhas 2112 a 2155:
2112:     * par_nErro: codigo de erro numerico (GetLastError / WinInet)
2113:     * Retorno: string formatada "[ NNN : NOME_DO_ERRO ]"
2114:     *==========================================================================
2115:     PROCEDURE InErrorCase(par_nErro)
2116:         LOCAL loc_cMensagem
2117:         DO CASE
2118:             CASE par_nErro = 12001
2119:                 loc_cMensagem = "ERROR_INTERNET_OUT_OF_HANDLES"
2120:             CASE par_nErro = 12002
2121:                 loc_cMensagem = "ERROR_INTERNET_TIMEOUT"
2122:             CASE par_nErro = 12003
2123:                 loc_cMensagem = "ERROR_INTERNET_EXTENDED_ERROR"
2124:             CASE par_nErro = 12004
2125:                 loc_cMensagem = "ERROR_INTERNET_INTERNAL_ERROR"
2126:             CASE par_nErro = 12005
2127:                 loc_cMensagem = "ERROR_INTERNET_INVALID_URL"
2128:             CASE par_nErro = 12006
2129:                 loc_cMensagem = "ERROR_INTERNET_UNRECOGNIZED_SCHEME"
2130:             CASE par_nErro = 12007
2131:                 loc_cMensagem = "ERROR_INTERNET_NAME_NOT_RESOLVED"
2132:             CASE par_nErro = 12008
2133:                 loc_cMensagem = "ERROR_INTERNET_PROTOCOL_NOT_FOUND"
2134:             CASE par_nErro = 12009
2135:                 loc_cMensagem = "ERROR_INTERNET_INVALID_OPTION"
2136:             CASE par_nErro = 12010
2137:                 loc_cMensagem = "ERROR_INTERNET_BAD_OPTION_LENGTH"
2138:             CASE par_nErro = 12011
2139:                 loc_cMensagem = "ERROR_INTERNET_OPTION_NOT_SETTABLE"
2140:             CASE par_nErro = 12012
2141:                 loc_cMensagem = "ERROR_INTERNET_SHUTDOWN"
2142:             CASE par_nErro = 12013
2143:                 loc_cMensagem = "ERROR_INTERNET_INCORRECT_USER_NAME"
2144:             CASE par_nErro = 12014
2145:                 loc_cMensagem = "ERROR_INTERNET_INCORRECT_PASSWORD"
2146:             CASE par_nErro = 12015
2147:                 loc_cMensagem = "ERROR_INTERNET_LOGIN_FAILURE"
2148:             CASE par_nErro = 12016
2149:                 loc_cMensagem = "ERROR_INTERNET_INVALID_OPERATION"
2150:             CASE par_nErro = 12017
2151:                 loc_cMensagem = "ERROR_INTERNET_OPERATION_CANCELLED"
2152:             CASE par_nErro = 12018
2153:                 loc_cMensagem = "ERROR_INTERNET_INCORRECT_HANDLE_TYPE"
2154:             CASE par_nErro = 12019
2155:                 loc_cMensagem = "ERROR_INTERNET_INCORRECT_HANDLE_STATE"

*-- Linhas 2269 a 2647:
2269:     *   [N,1]=handle hRasConn | [N,2]=nome | [N,3]=dispositivo | [N,4]=telefone
2270:     * Retorno: numero de conexoes ativas
2271:     *==========================================================================
2272:     PROCEDURE RasAtivas(par_cArrayRetorno)
2273:         LOCAL loc_cConexao, loc_cConexoes, loc_nSize, loc_nContagem, loc_nResult
2274:         LOCAL loc_nPos, loc_oErro
2275:         loc_nContagem = 0
2276:         TRY
2277:             DECLARE INTEGER RasEnumConnections ;
2278:                 IN RASAPI32.DLL ;
2279:                 STRING  @ RasConnectionsBuffer, ;
2280:                 INTEGER @ dwSize, ;
2281:                 INTEGER @ nCount
2282: 
2283:             loc_cConexao  = THIS.WordToC(412) + REPLICATE(CHR(0), 408)
2284:             loc_cConexoes = REPLICATE(loc_cConexao, 16)
2285:             loc_nSize     = LEN(loc_cConexoes)
2286:             loc_nContagem = 0
2287: 
2288:             loc_nResult = RasEnumConnections(@loc_cConexoes, @loc_nSize, @loc_nContagem)
2289: 
2290:             IF loc_nContagem > 0
2291:                 PUBLIC ARRAY &par_cArrayRetorno.[loc_nContagem, 4]
2292:                 FOR loc_nPos = 0 TO loc_nContagem - 1
2293:                     loc_cConexao = SUBSTR(loc_cConexoes, (loc_nPos * 412) + 1, 412)
2294:                     &par_cArrayRetorno.[loc_nPos + 1, 1] = THIS.CToWord(SUBSTR(loc_cConexao, 5, 4))
2295:                     &par_cArrayRetorno.[loc_nPos + 1, 2] = STRTRAN(SUBSTR(loc_cConexao, 9, 257), CHR(0))
2296:                     &par_cArrayRetorno.[loc_nPos + 1, 3] = STRTRAN(SUBSTR(loc_cConexao, 266, 17), CHR(0))
2297:                     &par_cArrayRetorno.[loc_nPos + 1, 4] = STRTRAN(SUBSTR(loc_cConexao, 283, 129), CHR(0))
2298:                 ENDFOR
2299:             ENDIF
2300:         CATCH TO loc_oErro
2301:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro RasAtivas")
2302:             loc_nContagem = 0
2303:         ENDTRY
2304:         RETURN loc_nContagem
2305:     ENDPROC
2306: 
2307:     *==========================================================================
2308:     * RasConexao - Lista entradas disponiveis no Phonebook RAS (RASAPI32.DLL)
2309:     * par_cArrayRetorno: nome (string) do array PUBLIC a preencher com [N]
2310:     *   Cada elemento = nome da entrada de discagem
2311:     * Retorno: numero de entradas encontradas
2312:     *==========================================================================
2313:     PROCEDURE RasConexao(par_cArrayRetorno)
2314:         LOCAL loc_cEntrada, loc_cEntradas, loc_nSize, loc_nTotal, loc_nResult
2315:         LOCAL loc_nCont, loc_cNomeEntrada, loc_oErro
2316:         loc_nTotal = 0
2317:         TRY
2318:             DECLARE INTEGER RasEnumEntries ;
2319:                 IN RASAPI32.DLL ;
2320:                 INTEGER   reserved, ;
2321:                 STRING    PhoneBox, ;
2322:                 STRING  @ RasEntryName, ;
2323:                 INTEGER @ SizeOfRasEntryName, ;
2324:                 INTEGER @ Entries
2325: 
2326:             loc_cEntrada  = THIS.WordToC(264) + REPLICATE(CHR(0), 256)
2327:             loc_cEntradas = REPLICATE(loc_cEntrada, 255)
2328:             loc_nSize     = LEN(loc_cEntradas)
2329:             loc_nTotal    = 0
2330: 
2331:             loc_nResult = RasEnumEntries(0, "", @loc_cEntradas, @loc_nSize, @loc_nTotal)
2332: 
2333:             IF loc_nTotal > 0
2334:                 RELEASE &par_cArrayRetorno.
2335:                 PUBLIC ARRAY &par_cArrayRetorno.[loc_nTotal]
2336:                 FOR loc_nCont = 0 TO loc_nTotal - 1
2337:                     loc_cNomeEntrada = SUBSTR(loc_cEntradas, 264 * loc_nCont + 1, 264)
2338:                     &par_cArrayRetorno.[loc_nCont + 1] = SUBSTR(loc_cNomeEntrada, 5, ;
2339:                         AT(CHR(0), SUBSTR(loc_cNomeEntrada, 5)) - 1)
2340:                 ENDFOR
2341:             ENDIF
2342:         CATCH TO loc_oErro
2343:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro RasConexao")
2344:             loc_nTotal = 0
2345:         ENDTRY
2346:         RETURN loc_nTotal
2347:     ENDPROC
2348: 
2349:     *==========================================================================
2350:     * RasDescon - Desconecta uma conexao RAS ativa via RasHangUp (RASAPI32.DLL)
2351:     * par_nRasConn: handle da conexao RAS a encerrar (obtido por RasAtivas)
2352:     * Retorno: resultado de RasHangUp (0 = sucesso)
2353:     *==========================================================================
2354:     PROCEDURE RasDescon(par_nRasConn)
2355:         LOCAL loc_nResult, loc_oErro
2356:         loc_nResult = -1
2357:         TRY
2358:             DECLARE Integer RasHangUp ;
2359:                 IN RASAPI32.DLL ;
2360:                 Integer hRasConn
2361:             DECLARE Integer Sleep ;
2362:                 IN Win32API ;
2363:                 Integer Milliseconds
2364:             THIS.Inf("Desconectando... ", "R")
2365:             loc_nResult = RasHangUp(par_nRasConn)
2366:             Sleep(3000)
2367:         CATCH TO loc_oErro
2368:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro RasDescon")
2369:         ENDTRY
2370:         RETURN loc_nResult
2371:     ENDPROC
2372: 
2373:     *==========================================================================
2374:     * CarregarConexoesDialUp - Popula cbo_4c_CboProvedor com entradas RAS
2375:     * Chamado automaticamente em CarregarParametros quando TpConnect = "D"
2376:     *==========================================================================
2377:     PROCEDURE CarregarConexoesDialUp
2378:         LOCAL loc_nTotal, loc_i, loc_oErro
2379:         TRY
2380:             IF VARTYPE(THIS.cbo_4c_CboProvedor) = "O"
2381:                 THIS.cbo_4c_CboProvedor.Clear()
2382:                 loc_nTotal = THIS.RasConexao("aProvedor")
2383:                 IF loc_nTotal > 0
2384:                     FOR loc_i = 1 TO loc_nTotal
2385:                         THIS.cbo_4c_CboProvedor.AddItem(aProvedor(loc_i))
2386:                     ENDFOR
2387:                     IF THIS.cbo_4c_CboProvedor.ListCount > 0
2388:                         THIS.cbo_4c_CboProvedor.ListIndex = 1
2389:                     ENDIF
2390:                 ENDIF
2391:             ENDIF
2392:         CATCH TO loc_oErro
2393:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro CarregarConexoesDialUp")
2394:         ENDTRY
2395:     ENDPROC
2396: 
2397:     *==========================================================================
2398:     * Destroy - Libera recursos ao encerrar o form
2399:     *==========================================================================
2400:     PROCEDURE Destroy
2401:         IF USED("logftp")
2402:             USE IN logftp
2403:         ENDIF
2404:         IF USED("tmpprog")
2405:             USE IN tmpprog
2406:         ENDIF
2407:         IF USED("FtpServer")
2408:             USE IN FtpServer
2409:         ENDIF
2410:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2411:             THIS.this_oBusinessObject = .NULL.
2412:         ENDIF
2413:         DODEFAULT()
2414:     ENDPROC
2415: 
2416:     *==========================================================================
2417:     * Adaptadores CRUD -> OPERACIONAL (FTP)
2418:     *
2419:     * Form operacional FTP: fluxo distinto do padrao CRUD (Incluir/Alterar/Visualizar/Excluir).
2420:     * Os botoes reais sao: Conecta (cmd_4c_Cmdload), Transfere (cmd_4c_Cmdtran),
2421:     * Recebe (cmd_4c_Cmdrec), Rede Dial-Up (cmd_4c_Cmdconect) e Encerrar
2422:     * (cmd_4c_Cmdsair), alem dos botoes por-arquivo cmd_4c_Cmdtransfere e
2423:     * cmd_4c_Cmdrecebe dentro do Container1.
2424:     *
2425:     * Os adaptadores abaixo mapeiam as intencoes CRUD (usadas por menus/pipeline)
2426:     * para as operacoes reais equivalentes do fluxo FTP, evitando codigo morto
2427:     * e mantendo compatibilidade com chamadores genericos.
2428:     *==========================================================================
2429: 
2430:     *-- BtnIncluirClick: iniciar nova sessao FTP (conectar + carregar listagens)
2431:     PROCEDURE BtnIncluirClick
2432:         RETURN THIS.CmdCmdloadClick()
2433:     ENDPROC
2434: 
2435:     *-- BtnAlterarClick: recarregar listagens FTP/local (refresh dos containers)
2436:     PROCEDURE BtnAlterarClick
2437:         RETURN THIS.CmdCmdloadClick()
2438:     ENDPROC
2439: 
2440:     *-- BtnVisualizarClick: exibir arquivos disponiveis para envio/recebimento
2441:     PROCEDURE BtnVisualizarClick
2442:         RETURN THIS.MontarContainer()
2443:     ENDPROC
2444: 
2445:     *-- BtnExcluirClick: excluir arquivo remoto selecionado no ListBox FTP
2446:     *-- Se nenhum arquivo estiver selecionado, o proprio metodo emite aviso.
2447:     PROCEDURE BtnExcluirClick
2448:         LOCAL loc_oObj, loc_cArquivo, loc_lOk, loc_oErro
2449:         loc_lOk = .F.
2450:         TRY
2451:             loc_oObj = THIS.cnt_4c_Container1.pgf_4c_Ftp.Page2.obj_4c_Lstenvloc
2452:             IF VARTYPE(loc_oObj) = "O" AND loc_oObj.ListIndex > 0
2453:                 loc_cArquivo = ALLTRIM(loc_oObj.List(loc_oObj.ListIndex, 1))
2454:                 IF !EMPTY(loc_cArquivo) AND MsgConfirma("Excluir arquivo remoto: " + ;
2455:                         loc_cArquivo + " ?", "Confirma" + CHR(231) + CHR(227) + "o")
2456:                     loc_lOk = THIS.DeleteFtpFile(THIS.this_cFtpAdd, THIS.this_cFtpUser, ;
2457:                                                   THIS.this_cFtpPass, loc_cArquivo)
2458:                     IF loc_lOk
2459:                         loc_oObj.RemoveItem(loc_oObj.ListIndex)
2460:                         THIS.Inf("Arquivo " + loc_cArquivo + " exclu" + CHR(237) + "do do FTP.", "B")
2461:                     ENDIF
2462:                 ENDIF
2463:             ELSE
2464:                 THIS.Inf("Selecione um arquivo remoto para excluir.", "R")
2465:             ENDIF
2466:         CATCH TO loc_oErro
2467:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
2468:                     " PROC=" + loc_oErro.Procedure, "Erro")
2469:             loc_lOk = .F.
2470:         ENDTRY
2471:         RETURN loc_lOk
2472:     ENDPROC
2473: 
2474:     *-- BtnBuscarClick: conectar e carregar listagens FTP/local
2475:     PROCEDURE BtnBuscarClick
2476:         RETURN THIS.CmdCmdloadClick()
2477:     ENDPROC
2478: 
2479:     *-- BtnEncerrarClick: encerrar o formulario FTP
2480:     PROCEDURE BtnEncerrarClick
2481:         THIS.Release()
2482:     ENDPROC
2483: 
2484:     *-- BtnSalvarClick: enviar todos os arquivos para o FTP
2485:     PROCEDURE BtnSalvarClick
2486:         RETURN THIS.Transfere("A")
2487:     ENDPROC
2488: 
2489:     *-- BtnCancelarClick: receber todos os arquivos do FTP
2490:     PROCEDURE BtnCancelarClick
2491:         RETURN THIS.Receber("A")
2492:     ENDPROC
2493: 
2494:     *==========================================================================
2495:     * FormParaBO - Transfere configuracao FTP do form para o BO
2496:     *==========================================================================
2497:     PROCEDURE FormParaBO
2498:         LOCAL loc_oBO
2499:         loc_oBO = THIS.this_oBusinessObject
2500:         IF VARTYPE(loc_oBO) != "O"
2501:             RETURN .F.
2502:         ENDIF
2503:         loc_oBO.this_cTpConexaoEmp = THIS.this_cTpConnect
2504:         loc_oBO.this_cFtpAddEmp    = THIS.this_cFtpAdd
2505:         loc_oBO.this_cFtpUserEmp   = THIS.this_cFtpUser
2506:         loc_oBO.this_cFtpPassEmp   = THIS.this_cFtpPass
2507:         loc_oBO.this_cDriveTs      = THIS.this_cDirEnvFtp
2508:         loc_oBO.this_cDriveLs      = THIS.this_cDirRecFtp
2509:         loc_oBO.this_cDirFtpTs     = THIS.this_cDirRecLoc
2510:         loc_oBO.this_cDirFtpLs     = THIS.this_cDirEnvLoc
2511:         loc_oBO.this_lLocDel       = THIS.this_lDelLocal
2512:         loc_oBO.this_lFtpDel       = THIS.this_lDelHost
2513:         RETURN .T.
2514:     ENDPROC
2515: 
2516:     *==========================================================================
2517:     * BOParaForm - Transfere configuracao FTP do BO para os controles do form
2518:     *==========================================================================
2519:     PROCEDURE BOParaForm
2520:         LOCAL loc_oBO, loc_oCnt, loc_oPgLoc, loc_oPgFtp, loc_oErro
2521:         TRY
2522:             loc_oBO = THIS.this_oBusinessObject
2523:             IF VARTYPE(loc_oBO) != "O"
2524:                 loc_lResultado = .F.
2525:             ENDIF
2526:             THIS.this_cTpConnect = UPPER(ALLTRIM(loc_oBO.this_cTpConexaoEmp))
2527:             THIS.this_cFtpAdd    = LOWER(ALLTRIM(loc_oBO.this_cFtpAddEmp))
2528:             THIS.this_cFtpUser   = LOWER(ALLTRIM(loc_oBO.this_cFtpUserEmp))
2529:             THIS.this_cFtpPass   = LOWER(ALLTRIM(loc_oBO.this_cFtpPassEmp))
2530:             THIS.this_cDirEnvFtp = LOWER(ALLTRIM(loc_oBO.this_cDriveTs))
2531:             THIS.this_cDirRecFtp = LOWER(ALLTRIM(loc_oBO.this_cDriveLs))
2532:             THIS.this_cDirRecLoc = LOWER(ALLTRIM(loc_oBO.this_cDirFtpTs))
2533:             THIS.this_cDirEnvLoc = LOWER(ALLTRIM(loc_oBO.this_cDirFtpLs))
2534:             THIS.this_lDelLocal  = loc_oBO.this_lLocDel
2535:             THIS.this_lDelHost   = loc_oBO.this_lFtpDel
2536:             *-- Atualizar TextBoxes de caminhos nos PageFrames
2537:             IF VARTYPE(THIS.cnt_4c_Container1) = "O"
2538:                 loc_oCnt   = THIS.cnt_4c_Container1
2539:                 loc_oPgLoc = loc_oCnt.pgf_4c_Loc
2540:                 loc_oPgFtp = loc_oCnt.pgf_4c_Ftp
2541:                 IF !EMPTY(THIS.this_cDirEnvFtp)
2542:                     loc_oPgLoc.Page1.txt_4c_Direnvftp.Value = THIS.this_cDirEnvFtp
2543:                 ENDIF
2544:                 IF !EMPTY(THIS.this_cDirRecFtp)
2545:                     loc_oPgLoc.Page2.txt_4c_Dirrecftp.Value = THIS.this_cDirRecFtp
2546:                 ENDIF
2547:                 IF !EMPTY(THIS.this_cDirRecLoc)
2548:                     loc_oPgFtp.Page1.txt_4c_Dirrecloc.Value = THIS.this_cDirRecLoc
2549:                 ENDIF
2550:                 IF !EMPTY(THIS.this_cDirEnvLoc)
2551:                     loc_oPgFtp.Page2.txt_4c_Direnvloc.Value = THIS.this_cDirEnvLoc
2552:                 ENDIF
2553:             ENDIF
2554:         CATCH TO loc_oErro
2555:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro BOParaForm")
2556:         ENDTRY
2557:         RETURN .T.
2558:     ENDPROC
2559: 
2560:     *==========================================================================
2561:     * HabilitarCampos - Habilita/desabilita botoes conforme modo de operacao
2562:     * par_lHabilitar: .T. = habilitar (respeitando restricoes de modo)
2563:     *==========================================================================
2564:     PROCEDURE HabilitarCampos(par_lHabilitar)
2565:         LOCAL loc_oErro
2566:         TRY
2567:             IF VARTYPE(THIS.cmd_4c_Cmdtran) = "O"
2568:                 THIS.cmd_4c_Cmdtran.Enabled = par_lHabilitar AND !THIS.this_lSomenteRecebimento
2569:             ENDIF
2570:             IF VARTYPE(THIS.cmd_4c_Cmdrec) = "O"
2571:                 THIS.cmd_4c_Cmdrec.Enabled = par_lHabilitar AND !THIS.this_lSomenteEnvio
2572:             ENDIF
2573:             IF VARTYPE(THIS.cmd_4c_Cmdload) = "O"
2574:                 THIS.cmd_4c_Cmdload.Enabled = par_lHabilitar
2575:             ENDIF
2576:             IF VARTYPE(THIS.cnt_4c_Container1) = "O"
2577:                 THIS.cnt_4c_Container1.cmd_4c_Cmdtransfere.Enabled = ;
2578:                     par_lHabilitar AND !THIS.this_lSomenteRecebimento
2579:                 THIS.cnt_4c_Container1.cmd_4c_Cmdrecebe.Enabled = ;
2580:                     par_lHabilitar AND !THIS.this_lSomenteEnvio
2581:             ENDIF
2582:         CATCH TO loc_oErro
2583:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro HabilitarCampos")
2584:         ENDTRY
2585:     ENDPROC
2586: 
2587:     *==========================================================================
2588:     * LimparCampos - Limpa ListBoxes de arquivos, log e cursor de progresso
2589:     *==========================================================================
2590:     PROCEDURE LimparCampos
2591:         LOCAL loc_oObj, loc_i, loc_oErro
2592:         TRY
2593:             IF VARTYPE(THIS.cnt_4c_Container1) = "O"
2594:                 loc_oObj = THIS.cnt_4c_Container1.pgf_4c_Loc.Page1.obj_4c_Lstenvftp
2595:                 FOR loc_i = loc_oObj.ListCount TO 1 STEP -1
2596:                     loc_oObj.RemoveItem(loc_i)
2597:                 ENDFOR
2598:                 loc_oObj = THIS.cnt_4c_Container1.pgf_4c_Loc.Page2.obj_4c_Lstrecftp
2599:                 FOR loc_i = loc_oObj.ListCount TO 1 STEP -1
2600:                     loc_oObj.RemoveItem(loc_i)
2601:                 ENDFOR
2602:                 loc_oObj = THIS.cnt_4c_Container1.pgf_4c_Ftp.Page1.obj_4c_Lstrecloc
2603:                 FOR loc_i = loc_oObj.ListCount TO 1 STEP -1
2604:                     loc_oObj.RemoveItem(loc_i)
2605:                 ENDFOR
2606:                 loc_oObj = THIS.cnt_4c_Container1.pgf_4c_Ftp.Page2.obj_4c_Lstenvloc
2607:                 FOR loc_i = loc_oObj.ListCount TO 1 STEP -1
2608:                     loc_oObj.RemoveItem(loc_i)
2609:                 ENDFOR
2610:             ENDIF
2611:             IF USED("logftp")
2612:                 SELECT logftp
2613:                 ZAP
2614:                 IF VARTYPE(THIS.grd_4c_GrdInf) = "O"
2615:                     THIS.grd_4c_GrdInf.Refresh()
2616:                 ENDIF
2617:             ENDIF
2618:             IF USED("tmpprog")
2619:                 SELECT tmpprog
2620:                 ZAP
2621:                 IF VARTYPE(THIS.grd_4c_GrdProc) = "O"
2622:                     THIS.grd_4c_GrdProc.Refresh()
2623:                 ENDIF
2624:             ENDIF
2625:             IF VARTYPE(THIS.lbl_4c_Lblprog) = "O"
2626:                 THIS.lbl_4c_Lblprog.Caption = ""
2627:             ENDIF
2628:         CATCH TO loc_oErro
2629:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro LimparCampos")
2630:         ENDTRY
2631:     ENDPROC
2632: 
2633:     *==========================================================================
2634:     * CarregarLista - Recarrega listagens FTP e local (adaptador CRUD)
2635:     *==========================================================================
2636:     PROCEDURE CarregarLista
2637:         RETURN THIS.MontarContainer()
2638:     ENDPROC
2639: 
2640:     *==========================================================================
2641:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo de operacao
2642:     *==========================================================================
2643:     PROCEDURE AjustarBotoesPorModo
2644:         THIS.HabilitarCampos(.T.)
2645:     ENDPROC
2646: 
2647: ENDDEFINE


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

