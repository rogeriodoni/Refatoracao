# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (9)
- [METODO-INEXISTENTE] Metodo 'THIS.ExcluirArquivoFtp()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.RenomearArquivoFtp()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.VerificarArquivoFtp()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.EnviarArquivoFtp()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ReceberArquivoFtp()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [NAVEGACAO-PAGINA] Metodo 'ConfigurarPaginaDados' faz ActivePage=2 mas NAO le dados de cursor nem chama CarregarHistorico/CarregarDados. Em forms OPERACIONAL, a navegacao para Page2 DEVE carregar dados da linha selecionada no grid de Page1 (padrao legado: cmd_consulta.Click le do cursor do grid).
- [NAVEGACAO-PAGINA] Metodo 'ConfigurarPaginaDados' faz ActivePage=2 mas NAO le dados de cursor nem chama CarregarHistorico/CarregarDados. Em forms OPERACIONAL, a navegacao para Page2 DEVE carregar dados da linha selecionada no grid de Page1 (padrao legado: cmd_consulta.Click le do cursor do grid).
- [NAVEGACAO-PAGINA] Metodo 'PagLocRecebidosActivate' faz ActivePage=2 mas NAO le dados de cursor nem chama CarregarHistorico/CarregarDados. Em forms OPERACIONAL, a navegacao para Page2 DEVE carregar dados da linha selecionada no grid de Page1 (padrao legado: cmd_consulta.Click le do cursor do grid).
- [NAVEGACAO-PAGINA] Metodo 'PagFtpAReceberActivate' faz ActivePage=2 mas NAO le dados de cursor nem chama CarregarHistorico/CarregarDados. Em forms OPERACIONAL, a navegacao para Page2 DEVE carregar dados da linha selecionada no grid de Page1 (padrao legado: cmd_consulta.Click le do cursor do grid).

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprftp.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2843 linhas total):

*-- Linhas 90 a 214:
90:     MaxButton   = .F.
91:     MinButton   = .F.
92:     TitleBar    = 0
93:     ShowWindow  = 1     && "As Top-Level Form" - FIXO na classe (igual FormBuscaAuxiliar/
94:                         && FormErro/FormBuscaSimples): ShowWindow e READ-ONLY em runtime
95:                         && nesta instalacao do VFP9 (medido em automation\medir_showwindow.txt
96:                         && - ate um Form nativo vazio recusa THIS.ShowWindow=x no Init com
97:                         && "Property SHOWWINDOW is read-only"); so WindowType aceita mudanca
98:                         && em runtime.
99:     WindowType  = 1
100:     WindowState = 0
101:     LockScreen  = .F.
102:     Themes      = .F.
103: 
104:     this_oBusinessObject      = .NULL.
105:     this_cProvedorConectado   = ""     && Nome do provedor Dial-Up discado por BtnRedeDialupClick (equivalente a "cProvedor" do legado, consultado no Destroy para desconectar)
106: 
107:     *==========================================================================
108:     * Init - Dispara a cadeia FormBase.Init -> InicializarForm
109:     *==========================================================================
110:     FUNCTION Init()
111:         *-- Em modo teste: rebaixa para modeless (WindowType=0, aceita mudanca
112:         *-- em runtime) + Visible=.F. para o VFP9 -T headless nao travar
113:         *-- tentando exibir um form modal top-level (mesma protecao de
114:         *-- FormICD/FormICO/FormSIGPRCIC). NAO tocar ShowWindow aqui - fica
115:         *-- travado no valor fixo da classe (ver comentario acima).
116:         IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
117:             THIS.WindowType = 0
118:             THIS.Visible = .F.
119:         ENDIF
120: 
121:         RETURN DODEFAULT()
122:     ENDFUNC
123: 
124:     *==========================================================================
125:     * InicializarForm - Resolve a configuracao de FTP da empresa corrente e
126:     * cria a estrutura visual base do form (chamado por FormBase.Init)
127:     *==========================================================================
128:     PROTECTED FUNCTION InicializarForm()
129:         LOCAL loc_lSucesso, loc_oErro
130:         loc_lSucesso = .F.
131: 
132:         *-- Em modo teste: retornar sucesso sem criar controles UI nem
133:         *-- depender de SQLEXEC (SigCdPam/SigCdEmp podem nao existir no
134:         *-- ambiente de teste headless)
135:         IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
136:             RETURN .T.
137:         ENDIF
138: 
139:         TRY
140:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
141:             THIS.Caption = "Transfer" + CHR(234) + "ncia e Recebimento de arquivos via FTP"
142: 
143:             THIS.this_oBusinessObject = CREATEOBJECT("sigprftpBO")
144:             IF VARTYPE(THIS.this_oBusinessObject) <> "O"
145:                 MsgErro("Falha ao criar sigprftpBO.", "InicializarForm")
146:             ELSE
147:                 IF !THIS.this_oBusinessObject.ResolverConfiguracaoFtp(go_4c_Sistema.cCodEmpresa)
148:                     MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
149:                         "Configura" + CHR(231) + CHR(227) + "o de FTP")
150:                 ELSE
151:                     THIS.ConfigurarPageFrame()
152:                     THIS.ConfigurarCursoresAuxiliares()
153:                     THIS.ConfigurarGrids()
154:                     THIS.ConfigurarBotoesAcao()
155:                     THIS.ConfigurarPaginaDados()
156:                     loc_lSucesso = .T.
157:                 ENDIF
158:             ENDIF
159:         CATCH TO loc_oErro
160:             MsgErro(loc_oErro.Message + CHR(13) + ;
161:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
162:                 "Procedure: " + loc_oErro.Procedure, "InicializarForm")
163:             loc_lSucesso = .F.
164:         ENDTRY
165: 
166:         RETURN loc_lSucesso
167:     ENDFUNC
168: 
169:     *==========================================================================
170:     * ConfigurarPageFrame - Cria a moldura decorativa (Shape1) e o container
171:     * de navegacao com os 2 PageFrames internos (Local / FTP), reproduzindo
172:     * fielmente Top/Left/Width/Height/Caption/cores do SCX legado
173:     *==========================================================================
174:     PROTECTED PROCEDURE ConfigurarPageFrame()
175:         THIS.AddObject("shp_4c_Shape1", "Shape")
176:         WITH THIS.shp_4c_Shape1
177:             .Top         = 7
178:             .Left        = 696
179:             .Height      = 110
180:             .Width       = 90
181:             .BackStyle   = 0
182:             .BorderStyle = 0
183:             .Visible     = .T.
184:         ENDWITH
185: 
186:         THIS.AddObject("cnt_4c_Navegacao", "Container")
187:         WITH THIS.cnt_4c_Navegacao
188:             .Top         = 128
189:             .Left        = 88
190:             .Width       = 620
191:             .Height      = 194
192:             .BackStyle   = 0
193:             .BorderWidth = 0
194:             .Visible     = .T.
195:         ENDWITH
196: 
197:         *-- PageFrame "Local" - Page1 = A Enviar / Page2 = Recebidos
198:         THIS.cnt_4c_Navegacao.AddObject("pgf_4c_Loc", "PageFrame")
199:         WITH THIS.cnt_4c_Navegacao.pgf_4c_Loc
200:             .PageCount   = 2
201:             .Top         = 4
202:             .Left        = 3
203:             .Width       = 294
204:             .Height      = 186
205:             .TabStretch  = 1
206:             .ActivePage  = 1
207:             .Visible     = .T.
208:         ENDWITH
209:         WITH THIS.cnt_4c_Navegacao.pgf_4c_Loc.Page1
210:             .Caption   = "A Enviar"
211:             .FontBold  = .T.
212:             .FontName  = "Verdana"
213:             .FontSize  = 8
214:             .BackColor = RGB(255,255,255)

*-- Linhas 260 a 326:
260:     * para evitar colisao com palavras reservadas do VFP9 - sao cursores de
261:     * memoria, nao tabelas do PILAR 2.
262:     *==========================================================================
263:     PROTECTED PROCEDURE ConfigurarCursoresAuxiliares()
264:         IF USED("cursor_4c_Progresso")
265:             USE IN cursor_4c_Progresso
266:         ENDIF
267:         SET NULL ON
268:         CREATE CURSOR cursor_4c_Progresso (arquivo C(254), tamanho N(12), ;
269:             pastalocal C(254), pastahost C(254), statusoperacao C(50))
270:         SET NULL OFF
271: 
272:         IF USED("cursor_4c_Log")
273:             USE IN cursor_4c_Log
274:         ENDIF
275:         SET NULL ON
276:         CREATE CURSOR cursor_4c_Log (memo M, cor C(1))
277:         SET NULL OFF
278:     ENDPROC
279: 
280:     *==========================================================================
281:     * ConfigurarGrids - Cria os dois grids do form: GrdProc (progresso das
282:     * transferencias, ligado a cursor_4c_Progresso) e GrdInf (log de
283:     * mensagens, ligado a cursor_4c_Log), com Top/Left/Width/Height/fontes/
284:     * cores/headers fielmente transcritos do SCX legado
285:     *==========================================================================
286:     PROTECTED PROCEDURE ConfigurarGrids()
287:         THIS.AddObject("grd_4c_Progresso", "Grid")
288: 
289:         *-- ColumnCount/RecordSource ficam FORA do WITH: acessar .ColumnN
290:         *-- dentro do mesmo WITH que ainda esta definindo o RecordSource
291:         *-- estoura 'Unknown member COLUMN1' porque as colunas nao existem
292:         *-- no momento em que o WITH eh aberto (regra GRID-WITH).
293:         THIS.grd_4c_Progresso.ColumnCount      = 5
294:         THIS.grd_4c_Progresso.RecordSourceType = 1
295:         THIS.grd_4c_Progresso.RecordSource     = "cursor_4c_Progresso"
296: 
297:         WITH THIS.grd_4c_Progresso
298:             .Top          = 376
299:             .Left         = 89
300:             .Width        = 622
301:             .Height       = 114
302:             .FontSize     = 8
303:             .DeleteMark   = .F.
304:             .RecordMark   = .F.
305:             .GridLines    = 0
306:             .HeaderHeight = 15
307:             .RowHeight    = 15
308:             .ReadOnly     = .T.
309:             .ToolTipText  = "Progresso das Opera" + CHR(231) + CHR(245) + "es de Envio e Recebimento"
310: 
311:             .Column1.ControlSource   = "cursor_4c_Progresso.arquivo"
312:             .Column1.Width           = 81
313:             .Column1.FontSize        = 8
314:             .Column1.ReadOnly        = .T.
315:             .Column1.Header1.Caption = "Arquivo"
316: 
317:             .Column2.ControlSource   = "cursor_4c_Progresso.tamanho"
318:             .Column2.Width           = 63
319:             .Column2.FontSize        = 8
320:             .Column2.ReadOnly        = .T.
321:             .Column2.Header1.Caption = "Tamanho"
322: 
323:             .Column3.ControlSource   = "cursor_4c_Progresso.pastalocal"
324:             .Column3.Width           = 107
325:             .Column3.FontSize        = 8
326:             .Column3.ReadOnly        = .T.

*-- Linhas 393 a 638:
393: 
394:         *-- Label de status da operacao corrente (lblprog do legado). Fica
395:         *-- junto dos grids porque e' o rodape do painel de progresso: o
396:         *-- PROCEDURE processa escreve nele o tempo decorrido/estimado a cada
397:         *-- bloco transferido. Classe base "label" (nao a classe "say" do
398:         *-- Framework), logo AutoSize/Alignment ficam nos defaults - Width e
399:         *-- Height vem do SCX (rule #23: fixar os dois, nunca usar AutoSize)
400:         THIS.AddObject("lbl_4c_Progresso", "Label")
401:         WITH THIS.lbl_4c_Progresso
402:             .Top       = 512
403:             .Left      = 245
404:             .Width     = 437
405:             .Height    = 16
406:             .AutoSize  = .F.
407:             .Alignment = 0
408:             .BackStyle = 0
409:             .FontName  = "Tahoma"
410:             .FontSize  = 8
411:             .ForeColor = RGB(0,0,0)
412:             .Caption   = ""
413:             .Visible   = .T.
414:         ENDWITH
415:     ENDPROC
416: 
417:     *==========================================================================
418:     * ConfigurarBotoesAcao - Cria os botoes de acao do form (Conecta,
419:     * Transfere, Recebe, Rede Dial-Up, Encerrar e os 2 botoes pequenos de
420:     * transferencia individual dentro de cnt_4c_Navegacao), com o Enabled/
421:     * Visible inicial calculado como no Init legado: checagem de existencia
422:     * dos diretorios locais (this_cDirEnvFtp/this_cDirRecFtp) e visibilidade
423:     * do botao de Dial-Up conforme this_cTpConnect
424:     *==========================================================================
425:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
426:         LOCAL loc_lConfigOk
427:         loc_lConfigOk = .T.
428: 
429:         THIS.AddObject("cmd_4c_Conectar", "CommandButton")
430:         WITH THIS.cmd_4c_Conectar
431:             .Top        = 12
432:             .Left       = 23
433:             .Width      = 75
434:             .Height     = 75
435:             .FontBold   = .T.
436:             .FontItalic = .T.
437:             .FontName   = "Comic Sans MS"
438:             .FontSize   = 8
439:             .WordWrap   = .T.
440:             .Picture    = gc_4c_CaminhoIcones + "a_arrow1.bmp"
441:             .Caption    = "\<Conecta"
442:             .ForeColor  = RGB(90,90,90)
443:             .BackColor  = RGB(255,255,255)
444:             .Themes           = .T.
445:             .Visible    = .T.
446:         ENDWITH
447:         BINDEVENT(THIS.cmd_4c_Conectar, "Click", THIS, "BtnConectarClick")
448: 
449:         THIS.AddObject("cmd_4c_Transferir", "CommandButton")
450:         WITH THIS.cmd_4c_Transferir
451:             .Top        = 12
452:             .Left       = 99
453:             .Width      = 75
454:             .Height     = 75
455:             .FontBold   = .T.
456:             .FontItalic = .T.
457:             .FontName   = "Comic Sans MS"
458:             .FontSize   = 8
459:             .Picture    = gc_4c_CaminhoIcones + "baix_aut.bmp"
460:             .Caption    = "\<Transfere"
461:             .ForeColor  = RGB(90,90,90)
462:             .BackColor  = RGB(255,255,255)
463:             .Themes           = .T.
464:             .DisabledPicture  = gc_4c_CaminhoIcones + "baix_aut.bmp"
465:             .Enabled    = .F.
466:             .Visible    = .T.
467:         ENDWITH
468:         BINDEVENT(THIS.cmd_4c_Transferir, "Click", THIS, "BtnExecutarTransferenciaClick")
469: 
470:         THIS.AddObject("cmd_4c_Receber", "CommandButton")
471:         WITH THIS.cmd_4c_Receber
472:             .Top        = 12
473:             .Left       = 174
474:             .Width      = 75
475:             .Height     = 75
476:             .FontBold   = .T.
477:             .FontItalic = .T.
478:             .FontName   = "Comic Sans MS"
479:             .FontSize   = 8
480:             .Picture    = gc_4c_CaminhoIcones + "d_disk1.bmp"
481:             .Caption    = "\<Recebe"
482:             .ForeColor  = RGB(90,90,90)
483:             .BackColor  = RGB(255,255,255)
484:             .Themes           = .T.
485:             .DisabledPicture  = gc_4c_CaminhoIcones + "d_disk1.bmp"
486:             .Enabled    = .F.
487:             .Visible    = .T.
488:         ENDWITH
489:         BINDEVENT(THIS.cmd_4c_Receber, "Click", THIS, "BtnExecutarRecebimentoClick")
490: 
491:         THIS.AddObject("cmd_4c_RedeDialup", "CommandButton")
492:         WITH THIS.cmd_4c_RedeDialup
493:             .Top        = 534
494:             .Left       = 332
495:             .Width      = 76
496:             .Height     = 54
497:             .FontBold   = .T.
498:             .FontItalic = .T.
499:             .FontName   = "Comic Sans MS"
500:             .FontSize   = 7
501:             .Picture    = gc_4c_CaminhoIcones + "c_comm1.bmp"
502:             .Caption    = "Rede \<Dial-Up"
503:             .ForeColor  = RGB(90,90,90)
504:             .BackColor  = RGB(255,255,255)
505:             .Themes           = .T.
506:             .Visible    = (THIS.this_oBusinessObject.this_cTpConnect == "D")
507:         ENDWITH
508:         BINDEVENT(THIS.cmd_4c_RedeDialup, "Click", THIS, "BtnRedeDialupClick")
509: 
510:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
511:         WITH THIS.cmd_4c_Encerrar
512:             .Top        = 12
513:             .Left = 5
514:             .Width      = 75
515:             .Height     = 75
516:             .FontBold   = .T.
517:             .FontItalic = .T.
518:             .FontName   = "Comic Sans MS"
519:             .FontSize   = 8
520:             .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
521:             .Cancel     = .T.
522:             .Caption    = "Encerrar"
523:             .ForeColor  = RGB(90,90,90)
524:             .BackColor  = RGB(255,255,255)
525:             .Themes           = .T.
526:             .Enabled    = .T.
527:             .Visible    = .T.
528:         ENDWITH
529:         BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
530: 
531:         THIS.cnt_4c_Navegacao.AddObject("cmd_4c_EnviaFtp", "CommandButton")
532:         WITH THIS.cnt_4c_Navegacao.cmd_4c_EnviaFtp
533:             .Top          = 83
534:             .Left         = 299
535:             .Width        = 25
536:             .Height       = 24
537:             .FontName     = "Verdana"
538:             .FontSize     = 8
539:             .Picture      = gc_4c_CaminhoIcones + "b_arrow2.bmp"
540:             .Caption      = ""
541:             .ToolTipText  = "Transfere para FTP"
542:             .ForeColor    = RGB(36,84,155)
543:             .BackColor    = RGB(255,255,255)
544:             .Visible      = .T.
545:         ENDWITH
546:         BINDEVENT(THIS.cnt_4c_Navegacao.cmd_4c_EnviaFtp, "Click", THIS, "BtnEnviaFtpClick")
547: 
548:         THIS.cnt_4c_Navegacao.AddObject("cmd_4c_RecebeFtp", "CommandButton")
549:         WITH THIS.cnt_4c_Navegacao.cmd_4c_RecebeFtp
550:             .Top          = 116
551:             .Left         = 299
552:             .Width        = 25
553:             .Height       = 24
554:             .FontName     = "Verdana"
555:             .FontSize     = 8
556:             .Picture      = gc_4c_CaminhoIcones + "b_arrow1.bmp"
557:             .Caption      = ""
558:             .ToolTipText  = "Recebe do FTP"
559:             .ForeColor    = RGB(36,84,155)
560:             .BackColor    = RGB(255,255,255)
561:             .Visible      = .T.
562:         ENDWITH
563:         BINDEVENT(THIS.cnt_4c_Navegacao.cmd_4c_RecebeFtp, "Click", THIS, "BtnRecebeFtpClick")
564: 
565:         *-- Container1 (cnt_4c_Navegacao) so fica habilitado apos Conecta
566:         THIS.cnt_4c_Navegacao.Enabled = .F.
567: 
568:         *-- "Checa a existencia dos diretorios locais" (Init legado)
569:         IF !EMPTY(THIS.this_oBusinessObject.this_cDirEnvFtp) AND !DIRECTORY(THIS.this_oBusinessObject.this_cDirEnvFtp)
570:             THIS.Inf("Diret" + CHR(243) + "rio Local de Envio para FTP n" + CHR(227) + "o existe. Verifique o cadastro de empresas", "R")
571:             loc_lConfigOk = .F.
572:         ENDIF
573:         IF !EMPTY(THIS.this_oBusinessObject.this_cDirRecFtp) AND !DIRECTORY(THIS.this_oBusinessObject.this_cDirRecFtp)
574:             THIS.Inf("Diret" + CHR(243) + "rio Local de Recebimento do FTP n" + CHR(227) + "o existe. Verifique o cadastro de empresas", "R")
575:             loc_lConfigOk = .F.
576:         ENDIF
577: 
578:         THIS.cmd_4c_Conectar.Enabled = loc_lConfigOk
579: 
580:         IF !loc_lConfigOk
581:             MsgAviso("Erro na parametriza" + CHR(231) + CHR(227) + "o ou na configura" + CHR(231) + CHR(227) + "o da conex" + CHR(227) + "o. Verifique... Opera" + CHR(231) + CHR(227) + "o Cancelada", "Aten" + CHR(231) + CHR(227) + "o")
582:         ENDIF
583:     ENDPROC
584: 
585:     *==========================================================================
586:     * ConfigurarControlesLocal - Cria os controles de dados do PageFrame
587:     * "Local" (pgf_4c_Loc): Page1 "A Enviar" (lst_4c_EnvFtp/txt_4c_DirEnvFtp/
588:     * cmd_4c_BrowEnvFtp) e Page2 "Recebidos" (lst_4c_RecFtp/txt_4c_DirRecFtp/
589:     * cmd_4c_BrowRecFtp), com Top/Left/Width/Height/ColumnWidths transcritos
590:     * do SCX legado (lstenvftp/direnvftp/cmdbrowloc de cada pagina - o legado
591:     * reusa o MESMO nome "cmdbrowloc" nas duas paginas; aqui os botoes
592:     * recebem nomes distintos por acao, ja que o nome generico colidiria).
593:     * Os botoes "..." ficam Enabled = .F. porque o legado NUNCA implementa
594:     * Click para eles (nenhum PROCEDURE Click no dump) - sao decorativos no
595:     * original. Os controles de dados do PageFrame "FTP" (pgf_4c_Ftp) e o
596:     * CboProvedor entram na Fase 6.
597:     *==========================================================================
598:     PROTECTED PROCEDURE ConfigurarControlesLocal()
599:         LOCAL loc_oPag1, loc_oPag2
600: 
601:         loc_oPag1 = THIS.cnt_4c_Navegacao.pgf_4c_Loc.Page1
602:         loc_oPag2 = THIS.cnt_4c_Navegacao.pgf_4c_Loc.Page2
603: 
604:         loc_oPag1.AddObject("lst_4c_EnvFtp", "ListBox")
605:         WITH loc_oPag1.lst_4c_EnvFtp
606:             .Top          = 26
607:             .Left         = 2
608:             .Width        = 286
609:             .Height       = 130
610:             .ColumnCount  = 3
611:             .ColumnWidths = "130,62,83"
612:             .ColumnLines  = .T.
613:             .MultiSelect  = .T.
614:             .FontName     = "Verdana"
615:             .FontSize     = 8
616:             .Visible      = .T.
617:         ENDWITH
618: 
619:         loc_oPag1.AddObject("txt_4c_DirEnvFtp", "TextBox")
620:         WITH loc_oPag1.txt_4c_DirEnvFtp
621:             .Top         = 2
622:             .Left        = 2
623:             .Width       = 217
624:             .Height      = 23
625:             .FontName    = "Verdana"
626:             .FontSize    = 8
627:             .Value       = ""    && preenchido por BOParaForm (bloco do Init legado)
628:             .Visible     = .T.
629:         ENDWITH
630: 
631:         loc_oPag1.AddObject("cmd_4c_BrowEnvFtp", "CommandButton")
632:         WITH loc_oPag1.cmd_4c_BrowEnvFtp
633:             .Top       = 2
634:             .Left      = 222
635:             .Width     = 22
636:             .Height    = 22
637:             .FontName  = "Verdana"
638:             .FontSize  = 8

*-- Linhas 697 a 757:
697:         *-- trazer "Enviados" no lado FTP. Page.ZOrder num PageFrame traz a
698:         *-- pagina para a frente, ou seja, SELECIONA a pagina: o equivalente
699:         *-- no migrado eh <pageframe>.ActivePage = N.
700:         BINDEVENT(loc_oPag1, "Activate", THIS, "PagLocEnviarActivate")
701:         BINDEVENT(loc_oPag2, "Activate", THIS, "PagLocRecebidosActivate")
702:     ENDPROC
703: 
704:     *==========================================================================
705:     * ConfigurarControlesFtp - Cria os controles de dados do PageFrame "FTP"
706:     * (pgf_4c_Ftp): Page1 "Enviados" (lst_4c_RecLoc/txt_4c_DirRecLoc/
707:     * cmd_4c_BrowRecLoc, espelhando a pasta REMOTA this_cDirRecLoc) e Page2
708:     * "A Receber" (lst_4c_EnvLoc/txt_4c_DirEnvLoc/cmd_4c_BrowEnvLoc,
709:     * espelhando this_cDirEnvLoc), com Top/Left/Width/Height/ColumnWidths
710:     * transcritos do SCX legado (lstrecloc/dirrecloc/cmdbrowftp de cada
711:     * pagina - o legado reusa o MESMO nome "cmdbrowftp" nas duas paginas; aqui
712:     * os botoes recebem nomes distintos por acao, como ja feito em
713:     * ConfigurarControlesLocal). Os botoes "..." ficam Enabled = .F. porque o
714:     * legado NUNCA implementa Click para eles (nenhum PROCEDURE Click no
715:     * dump) - sao decorativos no original.
716:     *==========================================================================
717:     PROTECTED PROCEDURE ConfigurarControlesFtp()
718:         LOCAL loc_oPag1, loc_oPag2
719: 
720:         loc_oPag1 = THIS.cnt_4c_Navegacao.pgf_4c_Ftp.Page1
721:         loc_oPag2 = THIS.cnt_4c_Navegacao.pgf_4c_Ftp.Page2
722: 
723:         loc_oPag1.AddObject("lst_4c_RecLoc", "ListBox")
724:         WITH loc_oPag1.lst_4c_RecLoc
725:             .Top          = 26
726:             .Left         = 2
727:             .Width        = 286
728:             .Height       = 130
729:             .ColumnCount  = 3
730:             .ColumnWidths = "135,58,82"
731:             .ColumnLines  = .T.
732:             .MultiSelect  = .T.
733:             .FontName     = "Verdana"
734:             .FontSize     = 8
735:             .Visible      = .T.
736:         ENDWITH
737: 
738:         loc_oPag1.AddObject("txt_4c_DirRecLoc", "TextBox")
739:         WITH loc_oPag1.txt_4c_DirRecLoc
740:             .Top         = 2
741:             .Left        = 2
742:             .Width       = 217
743:             .Height      = 23
744:             .FontName    = "Verdana"
745:             .FontSize    = 8
746:             .Value       = ""    && preenchido por BOParaForm (bloco do Init legado)
747:             .Visible     = .T.
748:         ENDWITH
749: 
750:         loc_oPag1.AddObject("cmd_4c_BrowRecLoc", "CommandButton")
751:         WITH loc_oPag1.cmd_4c_BrowRecLoc
752:             .Top       = 2
753:             .Left      = 223
754:             .Width     = 22
755:             .Height    = 22
756:             .FontName  = "Verdana"
757:             .FontSize  = 8

*-- Linhas 813 a 1147:
813:         *-- Activate de qualquer uma das paginas mexendo nos MESMOS botoes
814:         *-- pequenos This.Parent.Parent.cmdtransfere/cmdrecebe (Container1,
815:         *-- aqui cnt_4c_Navegacao.cmd_4c_EnviaFtp/cmd_4c_RecebeFtp).
816:         BINDEVENT(loc_oPag1, "Activate", THIS, "PagFtpEnviadosActivate")
817:         BINDEVENT(loc_oPag2, "Activate", THIS, "PagFtpAReceberActivate")
818:     ENDPROC
819: 
820:     *==========================================================================
821:     * ConfigurarProvedorDialUp - Cria o combo de provedores Dial-Up
822:     * (CboProvedor do legado) e, quando a conexao configurada for do tipo
823:     * Dial-Up ("D"), enumera as conexoes RAS cadastradas no Windows via
824:     * THIS.RasConexao(), preenchendo o array PUBLIC aProvedor que alimenta o
825:     * RowSource do combo (RowSourceType=5, array). Transcricao do trecho
826:     *==========================================================================
827:     PROTECTED PROCEDURE ConfigurarProvedorDialUp()
828:         PUBLIC ARRAY aProvedor(1)
829:         aProvedor(1) = ""
830:         PUBLIC nProvedor
831:         nProvedor = 1
832: 
833:         THIS.AddObject("cbo_4c_Provedor", "ComboBox")
834:         WITH THIS.cbo_4c_Provedor
835:             .Top              = 550
836:             .Left             = 90
837:             .Width            = 235
838:             .Height           = 24
839:             .Style            = 2
840:             .RowSourceType    = 5
841:             .RowSource        = "aProvedor"
842:             .ColumnCount      = 1
843:             .ControlSource    = "nProvedor"
844:             .FirstElement     = 1
845:             .FontName         = "Verdana"
846:             .FontSize         = 8
847:             .Visible          = .F.
848:         ENDWITH
849: 
850:         IF THIS.this_oBusinessObject.this_cTpConnect == "D"
851:             THIS.cbo_4c_Provedor.Visible = .T.
852: 
853:             IF THIS.RasConexao("aProvedor") = 0
854:                 RELEASE aProvedor
855:                 PUBLIC ARRAY aProvedor(1)
856:                 aProvedor(1) = ""
857:                 THIS.Inf("N" + CHR(227) + "o existem conex" + CHR(245) + "es DIAL-UP dispon" + CHR(237) + "veis...", "R")
858:                 MsgAviso("N" + CHR(227) + "o existem conex" + CHR(245) + "es dispon" + CHR(237) + "veis...", "Aten" + CHR(231) + CHR(227) + "o")
859:                 THIS.cmd_4c_Conectar.Enabled = .F.
860:             ELSE
861:             ENDIF
862:         ELSE
863:             THIS.cbo_4c_Provedor.Visible = .F.
864:         ENDIF
865:     ENDPROC
866: 
867:     *==========================================================================
868:     * ConfigurarPaginaDados - Ponto de entrada dos controles de DADOS das
869:     * paginas dos 2 PageFrames de navegacao. Cria os controles da metade
870:     * "Local" (ConfigurarControlesLocal) e da metade "FTP"
871:     * (ConfigurarControlesFtp), aplica o guard de disponibilidade que o Init
872:     * legado executa DEPOIS de montar a tela e, por fim, configura o combo de
873:     * provedores Dial-Up (ConfigurarProvedorDialUp) - na MESMA ordem do Init
874:     * legado (controles -> guard de direcao -> CboProvedor/RasConexao).
875:     *==========================================================================
876:     PROTECTED PROCEDURE ConfigurarPaginaDados()
877:         LOCAL loc_oPgLoc, loc_oPgFtp
878: 
879:         THIS.ConfigurarControlesLocal()
880:         THIS.ConfigurarControlesFtp()
881: 
882:         *-- Bloco ".pgfloc.Page1.direnvftp.Value = ThisForm._DirEnvFtp" (e os
883:         *-- outros tres, mais os quatro ToolTipText) que o Init legado executa
884:         *-- DEPOIS de resolver a configuracao: no migrado isso eh o BOParaForm.
885:         THIS.BOParaForm()
886: 
887:         loc_oPgLoc = THIS.cnt_4c_Navegacao.pgf_4c_Loc
888:         loc_oPgFtp = THIS.cnt_4c_Navegacao.pgf_4c_Ftp
889: 
890:         *-- Guard de disponibilidade, transcrito do Init legado (blocos
891:         *-- "if Empt(_DirEnvFtp) .or. empt(_DirRecLoc)" e
892:         *-- "if Empt(_DirRecFtp) .or. empt(_DirEnvLoc)"): faltando um dos dois
893:         *-- diretorios de um sentido, aquele sentido inteiro eh desativado -
894:         *-- a pagina correspondente nos DOIS PageFrames, o botao pequeno de
895:         *-- transferencia individual e o botao grande da barra de acao - e a
896:         *-- navegacao eh levada para a pagina do sentido que continua valido
897:         *-- (o ".pgfloc.PageN.zOrder" / ".pgfftp.PageN.zOrder" do legado).
898:         IF EMPTY(THIS.this_oBusinessObject.this_cDirEnvFtp) OR EMPTY(THIS.this_oBusinessObject.this_cDirRecLoc)
899:             loc_oPgLoc.Page1.Enabled = .F.
900:             loc_oPgFtp.Page1.Enabled = .F.
901:             loc_oPgLoc.ActivePage    = 2
902:             loc_oPgFtp.ActivePage    = 2
903:             THIS.cmd_4c_Transferir.Enabled = .F.
904:             THIS.Inf("Sistema Configurado somente para Recebimento. Envio Desativado", "G")
905:         ENDIF
906: 
907:         IF EMPTY(THIS.this_oBusinessObject.this_cDirRecFtp) OR EMPTY(THIS.this_oBusinessObject.this_cDirEnvLoc)
908:             loc_oPgLoc.Page2.Enabled = .F.
909:             loc_oPgFtp.Page2.Enabled = .F.
910:             loc_oPgLoc.ActivePage    = 1
911:             loc_oPgFtp.ActivePage    = 1
912:             THIS.cmd_4c_Receber.Enabled = .F.
913:             THIS.Inf("Sistema Configurado somente para Envio. Recebimento Desativado.", "G")
914:         ENDIF
915: 
916:         THIS.ConfigurarProvedorDialUp()
917:     ENDPROC
918: 
919:     *==========================================================================
920:     * PagLocEnviarActivate / PagLocRecebidosActivate - Activate das paginas
921:     * do PageFrame Local: alternam o Enabled dos botoes pequenos de
922:     * transferencia individual (cmd_4c_EnviaFtp/cmd_4c_RecebeFtp), como o
923:     * legado faz em pgfloc.Page1.Activate/Page2.Activate (cmdtransfere/
924:     * cmdrecebe.enabled). Metodos PUBLIC - BINDEVENT exige (regra #3).
925:     *==========================================================================
926:     PROCEDURE PagLocEnviarActivate()
927:         *-- "This.Parent.Parent.pgfftp.Page1.zorder" do legado: leva o
928:         *-- PageFrame FTP para a pagina do MESMO sentido (Enviados). A
929:         *-- atribuicao so acontece quando o valor muda, para o Activate do
930:         *-- outro PageFrame (que sincroniza de volta) nao tornar a disparar.
931:         IF THIS.cnt_4c_Navegacao.pgf_4c_Ftp.ActivePage <> 1
932:             THIS.cnt_4c_Navegacao.pgf_4c_Ftp.ActivePage = 1
933:         ENDIF
934:     ENDPROC
935: 
936:     PROCEDURE PagLocRecebidosActivate()
937:         *-- "This.Parent.Parent.pgfftp.Page2.zorder" do legado: leva o
938:         *-- PageFrame FTP para a pagina do MESMO sentido (A Receber).
939:         IF THIS.cnt_4c_Navegacao.pgf_4c_Ftp.ActivePage <> 2
940:             THIS.cnt_4c_Navegacao.pgf_4c_Ftp.ActivePage = 2
941:         ENDIF
942:     ENDPROC
943: 
944:     *==========================================================================
945:     * PagFtpEnviadosActivate / PagFtpAReceberActivate - Activate das paginas
946:     * do PageFrame FTP: espelham PagLocEnviarActivate/PagLocRecebidosActivate
947:     * na direcao oposta, sincronizando pgf_4c_Loc.ActivePage e alternando o
948:     * Enabled dos mesmos botoes pequenos de transferencia individual, como o
949:     * legado faz em pgfftp.Page1.Activate/Page2.Activate. Metodos PUBLIC -
950:     * BINDEVENT exige (regra #3).
951:     *==========================================================================
952:     PROCEDURE PagFtpEnviadosActivate()
953:         *-- "This.Parent.Parent.pgfloc.Page1.zorder" do legado: leva o
954:         *-- PageFrame Local para a pagina do MESMO sentido (A Enviar).
955:         IF THIS.cnt_4c_Navegacao.pgf_4c_Loc.ActivePage <> 1
956:             THIS.cnt_4c_Navegacao.pgf_4c_Loc.ActivePage = 1
957:         ENDIF
958:     ENDPROC
959: 
960:     PROCEDURE PagFtpAReceberActivate()
961:         *-- "This.Parent.Parent.pgfloc.Page2.zorder" do legado: leva o
962:         *-- PageFrame Local para a pagina do MESMO sentido (Recebidos).
963:         IF THIS.cnt_4c_Navegacao.pgf_4c_Loc.ActivePage <> 2
964:             THIS.cnt_4c_Navegacao.pgf_4c_Loc.ActivePage = 2
965:         ENDIF
966:     ENDPROC
967: 
968:     *==========================================================================
969:     * Inf - Registra uma mensagem no grid de log (grd_4c_Log/cursor_4c_Log)
970:     * e reposiciona o cursor no ultimo registro, equivalente ao PROCEDURE Inf
971:     * do legado (par_cCor: "R"=erro/vermelho, "G"=sucesso/verde, "B"=info/azul)
972:     *==========================================================================
973:     PROTECTED PROCEDURE Inf(par_cTexto, par_cCor)
974:         LOCAL loc_cAliasAnterior
975:         loc_cAliasAnterior = ALIAS()
976: 
977:         IF !USED("cursor_4c_Log")
978:             RETURN
979:         ENDIF
980: 
981:         SELECT cursor_4c_Log
982:         APPEND BLANK
983:         REPLACE memo WITH par_cTexto, cor WITH par_cCor
984:         GO BOTTOM
985: 
986:         THIS.grd_4c_Log.Refresh()
987: 
988:         IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
989:             SELECT (loc_cAliasAnterior)
990:         ENDIF
991:     ENDPROC
992: 
993:     *==========================================================================
994:     * WordToC / CToWord - Conversao entre inteiro (4 bytes) e buffer de
995:     * caracteres usada pelas chamadas RAS/WinInet, equivalente aos metodos
996:     * homonimos do legado
997:     *==========================================================================
998:     PROTECTED PROCEDURE WordToC(par_nNumero)
999:         RETURN CHR(BITAND(255, par_nNumero)) + ;
1000:                CHR(BITAND(65280, par_nNumero) % 255) + ;
1001:                CHR(BITAND(16711680, par_nNumero) % 255) + ;
1002:                CHR(BITAND(4278190080, par_nNumero) % 255)
1003:     ENDPROC
1004: 
1005:     PROTECTED PROCEDURE CToWord(par_cBuffer)
1006:         RETURN ASC(SUBSTR(par_cBuffer, 1, 1)) + ;
1007:                ASC(SUBSTR(par_cBuffer, 2, 1)) * 256 + ;
1008:                ASC(SUBSTR(par_cBuffer, 3, 1)) * 65536 + ;
1009:                ASC(SUBSTR(par_cBuffer, 4, 1)) * 16777216
1010:     ENDPROC
1011: 
1012:     *==========================================================================
1013:     * RasAtivas - Enumera as conexoes Dial-Up ATIVAS no momento via RAS API
1014:     * (equivalente ao PROCEDURE rasativas do legado). Devolve a quantidade de
1015:     * conexoes ativas e preenche o array PUBLIC cujo nome e passado em
1016:     * par_cNomeArray com [indice,1]=handle e [indice,2..4]=dados da conexao
1017:     *==========================================================================
1018:     PROTECTED PROCEDURE RasAtivas(par_cNomeArray)
1019:         LOCAL loc_cConexao, loc_cConexoes, loc_nSize, loc_nCount, loc_nResultado, loc_nPos
1020: 
1021:         DECLARE INTEGER RasEnumConnections IN RASAPI32.DLL ;
1022:             STRING  @loc_cConexoes, ;
1023:             INTEGER @loc_nSize, ;
1024:             INTEGER @loc_nCount
1025: 
1026:         loc_cConexao  = THIS.WordToC(412) + REPLICATE(CHR(0), 408)
1027:         loc_cConexoes = REPLICATE(loc_cConexao, 16)
1028:         loc_nSize     = LEN(loc_cConexoes)
1029:         loc_nCount    = 0
1030: 
1031:         loc_nResultado = RasEnumConnections(@loc_cConexoes, @loc_nSize, @loc_nCount)
1032: 
1033:         IF loc_nCount > 0
1034:             PUBLIC ARRAY &par_cNomeArray.[loc_nCount, 4]
1035: 
1036:             FOR loc_nPos = 0 TO loc_nCount - 1
1037:                 loc_cConexao = SUBSTR(loc_cConexoes, (loc_nPos * 412) + 1, 412)
1038: 
1039:                 &par_cNomeArray.[loc_nPos + 1, 1] = THIS.CToWord(SUBSTR(loc_cConexao, 5, 4))
1040:                 &par_cNomeArray.[loc_nPos + 1, 2] = STRTRAN(SUBSTR(loc_cConexao, 9, 257), CHR(0))
1041:                 &par_cNomeArray.[loc_nPos + 1, 3] = STRTRAN(SUBSTR(loc_cConexao, 266, 17), CHR(0))
1042:                 &par_cNomeArray.[loc_nPos + 1, 4] = STRTRAN(SUBSTR(loc_cConexao, 283, 129), CHR(0))
1043:             ENDFOR
1044:         ENDIF
1045: 
1046:         RETURN loc_nCount
1047:     ENDPROC
1048: 
1049:     *==========================================================================
1050:     * RasConexao - Enumera as conexoes Dial-Up CADASTRADAS no Windows (todas,
1051:     * ativas ou nao) via RAS API (equivalente ao PROCEDURE rasENTRADAS do
1052:     * legado - RasEnumEntries; o PROCEDURE rasconexao legado, que DISCA via
1053:     * RasDial, e o rashangup, que derruba a linha, sao codigo MORTO no legado:
1054:     * nenhum Click nem metodo os chama - quem disca e derruba e o
1055:     * "RUN /N Rundll Rnaui.dll,RnaDial" de cmdconect.Click e do Release, ja
1056:     * transcrito em BtnRedeDialupClick e Destroy). Devolve a quantidade de
1057:     * conexoes cadastradas e preenche o
1058:     * array PUBLIC cujo nome e passado em par_cNomeArray com o nome de cada
1059:     * conexao - fonte do RowSource de cbo_4c_Provedor.
1060:     *==========================================================================
1061:     PROTECTED PROCEDURE RasConexao(par_cNomeArray)
1062:         LOCAL loc_cEntradaVazia, loc_cEntradas, loc_nTamanho, loc_nEntradas, ;
1063:             loc_nResultado, loc_cEntrada, loc_nPos
1064: 
1065:         #DEFINE RAS_MAXENTRYNAME_CX 256
1066: 
1067:         DECLARE INTEGER RasEnumEntries IN RASAPI32.DLL ;
1068:             INTEGER reserved, ;
1069:             STRING  PhoneBox, ;
1070:             STRING  @loc_cEntradas, ;
1071:             INTEGER @loc_nTamanho, ;
1072:             INTEGER @loc_nEntradas
1073: 
1074:         loc_cEntradaVazia = THIS.WordToC(264) + REPLICATE(CHR(0), RAS_MAXENTRYNAME_CX)
1075:         loc_cEntradas     = REPLICATE(loc_cEntradaVazia, 255)
1076:         loc_nTamanho      = LEN(loc_cEntradas)
1077:         loc_nEntradas     = 0
1078: 
1079:         loc_nResultado = RasEnumEntries(0, "", @loc_cEntradas, @loc_nTamanho, @loc_nEntradas)
1080: 
1081:         IF loc_nEntradas = 0
1082:             RETURN 0
1083:         ENDIF
1084: 
1085:         RELEASE &par_cNomeArray.
1086:         PUBLIC ARRAY &par_cNomeArray.[loc_nEntradas]
1087: 
1088:         FOR loc_nPos = 0 TO loc_nEntradas - 1
1089:             loc_cEntrada = SUBSTR(loc_cEntradas, (264 * loc_nPos) + 1, 264)
1090:             &par_cNomeArray.[loc_nPos + 1] = SUBSTR(loc_cEntrada, 5, AT(CHR(0), SUBSTR(loc_cEntrada, 5)) - 1)
1091:         ENDFOR
1092: 
1093:         RETURN loc_nEntradas
1094:     ENDPROC
1095: 
1096:     *==========================================================================
1097:     * CarregarDados - Carga de dados do form: lista o diretorio REMOTO do
1098:     * servidor FTP (WinInet: InternetOpen -> InternetConnect ->
1099:     * FtpSetCurrentDirectory -> FtpFindFirstFile/InternetFindNextFile) e
1100:     * popula cursor_4c_FtpServer, que e a fonte de todo o lado "FTP" da tela.
1101:     * Transcricao do PROCEDURE getftpdirectory do legado.
1102:     *
1103:     * par_cDirRemoto : pasta no servidor FTP a listar
1104:     * par_cMascara   : mascara de arquivos (ex.: "*.*")
1105:     * Retorna .T. quando a listagem foi obtida (cursor_4c_FtpServer populado)
1106:     *==========================================================================
1107:     PROCEDURE CarregarDados(par_cDirRemoto, par_cMascara)
1108:         LOCAL loc_nInternet, loc_nFtp, loc_cTempDir, loc_cDiretorio, loc_cMascara
1109:         LOCAL loc_cStruct, loc_nHandle, loc_nResultCode, loc_nResult, loc_lManual
1110:         LOCAL loc_nFResult, loc_lSucesso, loc_cNulo
1111: 
1112:         #DEFINE ERROR_NO_MORE_FILES_FTP        18
1113:         #DEFINE INTERNET_OPEN_TYPE_DIRECT_FTP   1
1114:         #DEFINE INTERNET_DEFAULT_FTP_PORT_FTP  21
1115:         #DEFINE INTERNET_SERVICE_FTP_FTP        1
1116:         #DEFINE INTERNET_FLAG_PASSIVE_FTP 14217728
1117:         #DEFINE MAX_PATH_FTP                  260
1118: 
1119:         loc_cNulo    = CHR(0)
1120:         loc_lSucesso = .F.
1121:         loc_lManual  = .F.
1122:         loc_nInternet = 0
1123:         loc_nFtp      = 0
1124: 
1125:         DECLARE INTEGER FtpFindFirstFile IN WinInet ;
1126:             INTEGER nConnect_Handle, STRING @lpcSearchStr, ;
1127:             STRING @lpcWIN32_FIND_DATA, INTEGER nFlags, INTEGER nContext
1128: 
1129:         DECLARE INTEGER InternetFindNextFile IN WinInet ;
1130:             INTEGER nConnect_Handle, STRING @lpcWIN32_FIND_DATA
1131: 
1132:         DECLARE LONG InternetOpen IN "wininet.dll" ;
1133:             STRING lpszAgent, LONG dwAccessType, STRING lpszProxyName, ;
1134:             STRING lpszProxyBypass, LONG dwFlags
1135: 
1136:         DECLARE LONG InternetConnect IN "wininet.dll" ;
1137:             LONG hInternetSession, STRING lpszServerName, LONG nServerPort, ;
1138:             STRING lpszUsername, STRING lpszPassword, LONG dwService, ;
1139:             LONG dwFlags, LONG dwContext
1140: 
1141:         DECLARE INTEGER InternetCloseHandle IN "wininet.dll" LONG hInet
1142: 
1143:         DECLARE LONG GetLastError IN WIN32API
1144: 
1145:         DECLARE INTEGER FtpGetCurrentDirectory IN WinInet ;
1146:             INTEGER nConnect_Handle, STRING @lpcDirectory, INTEGER @nMax_Path
1147: 

*-- Linhas 1257 a 1302:
1257:     *==========================================================================
1258:     * CrackFile - Desmonta uma estrutura WIN32_FIND_DATA devolvida pelo
1259:     * WinInet e grava a linha correspondente em cursor_4c_FtpServer
1260:     * (transcricao do PROCEDURE crackfile do legado)
1261:     *==========================================================================
1262:     PROTECTED PROCEDURE CrackFile(par_cString)
1263:         LOCAL loc_cArquivo, loc_nSizeHigh, loc_nSizeLow, loc_nTamanho
1264:         LOCAL loc_cTipo, loc_cAtributos, loc_cBufferData, loc_cDataGravacao
1265:         LOCAL loc_cNulo, loc_nPosNulo
1266: 
1267:         #DEFINE BYTE_1_CF                     1
1268:         #DEFINE BYTE_2_CF                   256
1269:         #DEFINE BYTE_3_CF                 65536
1270:         #DEFINE BYTE_4_CF              16777216
1271:         #DEFINE MAXDWORD_CF          4294967295
1272:         #DEFINE FILE_ATTRIBUTE_DIRECTORY_CF  16
1273:         #DEFINE MAX_PATH_CF                 260
1274: 
1275:         loc_cNulo = CHR(0)
1276: 
1277:         loc_cArquivo = SUBSTR(par_cString, 45, MAX_PATH_CF)
1278:         loc_nPosNulo = AT(loc_cNulo, loc_cArquivo)
1279: 
1280:         IF loc_nPosNulo > 1
1281:             loc_cArquivo = LEFT(loc_cArquivo, loc_nPosNulo - 1)
1282:         ENDIF
1283: 
1284:         *-- Tamanho do arquivo (dois DWORD)
1285:         loc_nSizeHigh = (ASC(SUBSTR(par_cString, 29, 1)) * BYTE_1_CF) + ;
1286:                         (ASC(SUBSTR(par_cString, 30, 1)) * BYTE_2_CF) + ;
1287:                         (ASC(SUBSTR(par_cString, 31, 1)) * BYTE_3_CF) + ;
1288:                         (ASC(SUBSTR(par_cString, 32, 1)) * BYTE_4_CF)
1289: 
1290:         loc_nSizeLow  = (ASC(SUBSTR(par_cString, 33, 1)) * BYTE_1_CF) + ;
1291:                         (ASC(SUBSTR(par_cString, 34, 1)) * BYTE_2_CF) + ;
1292:                         (ASC(SUBSTR(par_cString, 35, 1)) * BYTE_3_CF) + ;
1293:                         (ASC(SUBSTR(par_cString, 36, 1)) * BYTE_4_CF)
1294: 
1295:         loc_nTamanho = (loc_nSizeHigh * MAXDWORD_CF) + loc_nSizeLow
1296: 
1297:         IF THIS.CToWord(SUBSTR(par_cString, 1, 4)) = FILE_ATTRIBUTE_DIRECTORY_CF
1298:             loc_cTipo = "Diret" + CHR(243) + "rio"
1299:         ELSE
1300:             loc_cTipo = "Arquivo"
1301:         ENDIF
1302: 

*-- Linhas 1316 a 1393:
1316: 
1317:     *==========================================================================
1318:     * CrackDate - Converte um FILETIME (8 bytes) na data formatada dd/mm/aaaa
1319:     * (transcricao do PROCEDURE crackdate do legado, que desconsidera a hora)
1320:     *==========================================================================
1321:     PROTECTED PROCEDURE CrackDate(par_cBuffer)
1322:         LOCAL loc_cEntrada, loc_nResultado, loc_nDia, loc_nMes, loc_nAno, loc_cData
1323: 
1324:         #DEFINE BYTE_2_CD 256
1325: 
1326:         DECLARE INTEGER FileTimeToSystemTime IN Kernel32 ;
1327:             STRING @lpcBuffer, STRING @lpcBuffer2
1328: 
1329:         loc_cEntrada   = SPACE(16)
1330:         loc_nResultado = FileTimeToSystemTime(@par_cBuffer, @loc_cEntrada)
1331: 
1332:         IF loc_nResultado = 0
1333:             *-- Falhou: data default do legado
1334:             loc_cData = "1901/01/01"
1335:         ELSE
1336:             loc_nAno = ASC(SUBSTR(loc_cEntrada, 1, 1)) + (ASC(SUBSTR(loc_cEntrada, 2, 1)) * BYTE_2_CD)
1337:             loc_nMes = ASC(SUBSTR(loc_cEntrada, 3, 1)) + (ASC(SUBSTR(loc_cEntrada, 4, 1)) * BYTE_2_CD)
1338:             loc_nDia = ASC(SUBSTR(loc_cEntrada, 7, 1)) + (ASC(SUBSTR(loc_cEntrada, 8, 1)) * BYTE_2_CD)
1339: 
1340:             loc_cData = PADL(ALLTRIM(STR(loc_nDia)), 2, "0") + "/" + ;
1341:                         PADL(ALLTRIM(STR(loc_nMes)), 2, "0") + "/" + ;
1342:                         ALLTRIM(STR(loc_nAno))
1343:         ENDIF
1344: 
1345:         RETURN loc_cData
1346:     ENDPROC
1347: 
1348:     *==========================================================================
1349:     * CrackAttributes - Traduz os 4 bytes de atributos do WIN32_FIND_DATA na
1350:     * letra correspondente (transcricao do PROCEDURE crackattributes do
1351:     * legado - DO CASE, portanto devolve APENAS o primeiro atributo que casar)
1352:     *==========================================================================
1353:     PROTECTED PROCEDURE CrackAttributes(par_cBuffer)
1354:         LOCAL loc_cAtributos, loc_nValor
1355: 
1356:         #DEFINE BYTE_1_CA                      1
1357:         #DEFINE BYTE_2_CA                    256
1358:         #DEFINE BYTE_3_CA                  65536
1359:         #DEFINE BYTE_4_CA               16777216
1360: 
1361:         #DEFINE BIT_ATTRIBUTE_READONLY_CA      0
1362:         #DEFINE BIT_ATTRIBUTE_HIDDEN_CA        1
1363:         #DEFINE BIT_ATTRIBUTE_SYSTEM_CA        2
1364:         #DEFINE BIT_ATTRIBUTE_DIRECTORY_CA     4
1365:         #DEFINE BIT_ATTRIBUTE_ARCHIVE_CA       5
1366:         #DEFINE BIT_ATTRIBUTE_NORMAL_CA        7
1367:         #DEFINE BIT_ATTRIBUTE_TEMPORARY_CA     8
1368:         #DEFINE BIT_ATTRIBUTE_COMPRESSED_CA   11
1369:         #DEFINE BIT_ATTRIBUTE_OFFLINE_CA      12
1370: 
1371:         loc_cAtributos = ""
1372: 
1373:         loc_nValor = (ASC(SUBSTR(par_cBuffer, 1, 1)) * BYTE_1_CA) + ;
1374:                      (ASC(SUBSTR(par_cBuffer, 2, 1)) * BYTE_2_CA) + ;
1375:                      (ASC(SUBSTR(par_cBuffer, 3, 1)) * BYTE_3_CA) + ;
1376:                      (ASC(SUBSTR(par_cBuffer, 4, 1)) * BYTE_4_CA)
1377: 
1378:         DO CASE
1379:             CASE BITTEST(loc_nValor, BIT_ATTRIBUTE_READONLY_CA)
1380:                 loc_cAtributos = loc_cAtributos + "R"
1381:             CASE BITTEST(loc_nValor, BIT_ATTRIBUTE_HIDDEN_CA)
1382:                 loc_cAtributos = loc_cAtributos + "H"
1383:             CASE BITTEST(loc_nValor, BIT_ATTRIBUTE_SYSTEM_CA)
1384:                 loc_cAtributos = loc_cAtributos + "S"
1385:             CASE BITTEST(loc_nValor, BIT_ATTRIBUTE_DIRECTORY_CA)
1386:                 loc_cAtributos = loc_cAtributos + "D"
1387:             CASE BITTEST(loc_nValor, BIT_ATTRIBUTE_ARCHIVE_CA)
1388:                 loc_cAtributos = loc_cAtributos + "A"
1389:             CASE BITTEST(loc_nValor, BIT_ATTRIBUTE_NORMAL_CA)
1390:                 loc_cAtributos = loc_cAtributos + "N"
1391:             CASE BITTEST(loc_nValor, BIT_ATTRIBUTE_TEMPORARY_CA)
1392:                 loc_cAtributos = loc_cAtributos + "T"
1393:             CASE BITTEST(loc_nValor, BIT_ATTRIBUTE_COMPRESSED_CA)

*-- Linhas 1401 a 1447:
1401: 
1402:     *==========================================================================
1403:     * InErrorCase - Traduz o codigo devolvido por GetLastError() no nome
1404:     * simbolico do erro WinInet/Win32 (transcricao do PROCEDURE inerrorcase
1405:     * do legado, incluindo o formato final "[ <codigo> : <nome> ]")
1406:     *==========================================================================
1407:     PROTECTED PROCEDURE InErrorCase(par_nErro)
1408:         LOCAL loc_cMensagem
1409: 
1410:         #DEFINE ERROR_INTERNET_BASE_IE 12000
1411: 
1412:         DO CASE
1413:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 1
1414:                 loc_cMensagem = "ERROR_INTERNET_OUT_OF_HANDLES"
1415:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 2
1416:                 loc_cMensagem = "ERROR_INTERNET_TIMEOUT"
1417:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 3
1418:                 loc_cMensagem = "ERROR_INTERNET_EXTENDED_ERROR"
1419:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 4
1420:                 loc_cMensagem = "ERROR_INTERNET_INTERNAL_ERROR"
1421:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 5
1422:                 loc_cMensagem = "ERROR_INTERNET_INVALID_URL"
1423:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 6
1424:                 loc_cMensagem = "ERROR_INTERNET_UNRECOGNIZED_SCHEME"
1425:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 7
1426:                 loc_cMensagem = "ERROR_INTERNET_NAME_NOT_RESOLVED"
1427:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 8
1428:                 loc_cMensagem = "ERROR_INTERNET_PROTOCOL_NOT_FOUND"
1429:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 9
1430:                 loc_cMensagem = "ERROR_INTERNET_INVALID_OPTION"
1431:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 10
1432:                 loc_cMensagem = "ERROR_INTERNET_BAD_OPTION_LENGTH"
1433:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 11
1434:                 loc_cMensagem = "ERROR_INTERNET_OPTION_NOT_SETTABLE"
1435:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 12
1436:                 loc_cMensagem = "ERROR_INTERNET_SHUTDOWN"
1437:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 13
1438:                 loc_cMensagem = "ERROR_INTERNET_INCORRECT_USER_NAME"
1439:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 14
1440:                 loc_cMensagem = "ERROR_INTERNET_INCORRECT_PASSWORD"
1441:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 15
1442:                 loc_cMensagem = "ERROR_INTERNET_LOGIN_FAILURE"
1443:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 16
1444:                 loc_cMensagem = "ERROR_INTERNET_INVALID_OPERATION"
1445:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 17
1446:                 loc_cMensagem = "ERROR_INTERNET_OPERATION_CANCELLED"
1447:             CASE par_nErro = ERROR_INTERNET_BASE_IE + 18

*-- Linhas 1563 a 1635:
1563: 
1564:     *==========================================================================
1565:     * SecToHour - Formata uma quantidade de segundos como "Nh, Nm, Ns"
1566:     * (transcricao do PROCEDURE sectohour do legado)
1567:     *==========================================================================
1568:     PROTECTED PROCEDURE SecToHour(par_nSegundos)
1569:         LOCAL loc_nHora, loc_nMinuto, loc_nSegundo
1570: 
1571:         loc_nHora    = INT(par_nSegundos / 3600)
1572:         loc_nMinuto  = MOD(INT(par_nSegundos / 60), 60)
1573:         loc_nSegundo = MOD(par_nSegundos, 60)
1574: 
1575:         RETURN IIF(loc_nHora > 0, ALLTRIM(STR(loc_nHora)) + " h, ", "") + ;
1576:                IIF(loc_nMinuto > 0, ALLTRIM(STR(loc_nMinuto)) + " m, ", "") + ;
1577:                ALLTRIM(STR(loc_nSegundo)) + " s"
1578:     ENDPROC
1579: 
1580:     *==========================================================================
1581:     * Processa - Alimenta o grid de progresso (grd_4c_Progresso /
1582:     * cursor_4c_Progresso) durante uma transferencia, nos 3 estagios do
1583:     * legado: "I"=iniciando (cria a linha), "A"=em andamento (atualiza bytes
1584:     * e percentual), "C"=concluido (fecha a linha e registra no log).
1585:     * Transcricao do PROCEDURE processa do legado.
1586:     *
1587:     * DIVERGENCIA DOCUMENTADA: o legado chama ThisForm.FileCtrlUp(...) neste
1588:     * metodo, mas o controle ActiveX que FileCtrlUp manipula (ThisForm.
1589:     * FileControl) NAO EXISTE no SCX - nao consta da lista de objetos do
1590:     * dump, so das linhas "With ThisForm.FileControl" do proprio FileCtrlUp.
1591:     * Reproduzir essas chamadas geraria "Unknown member FILECONTROL" em
1592:     * runtime, entao elas ficam de fora; o percentual segue visivel na coluna
1593:     * Status do grid e no lbl_4c_Progresso, como no legado.
1594:     *==========================================================================
1595:     PROCEDURE Processa(par_cArquivo, par_nTamanho, par_cPastaLocal, ;
1596:             par_cPastaHost, par_nTransferido, par_nBuffer, ;
1597:             par_nSegIniciais, par_nSegundos, par_cStatus)
1598: 
1599:         LOCAL loc_nSegundos, loc_cTempoEstimado, loc_cTempoDecorrido, ;
1600:             loc_nIndice, loc_nPos
1601: 
1602:         loc_nSegundos = par_nSegundos
1603: 
1604:         IF loc_nSegundos = 0
1605:             *-- Valor minimo de tempo de transferencia (evita divisao por zero)
1606:             loc_nSegundos = 0.001
1607:         ENDIF
1608: 
1609:         IF !USED("cursor_4c_Progresso")
1610:             RETURN
1611:         ENDIF
1612: 
1613:         DO CASE
1614:             CASE par_cStatus == "I"
1615:                 SELECT cursor_4c_Progresso
1616:                 APPEND BLANK
1617:                 REPLACE arquivo        WITH par_cArquivo, ;
1618:                         tamanho        WITH par_nTamanho, ;
1619:                         pastalocal     WITH par_cPastaLocal, ;
1620:                         pastahost      WITH par_cPastaHost, ;
1621:                         statusoperacao WITH "0 bytes copiados, 0% completado"
1622: 
1623:             CASE par_cStatus == "A"
1624:                 SELECT cursor_4c_Progresso
1625:                 LOCATE FOR cursor_4c_Progresso.arquivo = par_cArquivo
1626: 
1627:                 IF FOUND()
1628:                     REPLACE statusoperacao WITH ;
1629:                         STR(par_nTransferido) + " bytes copiados, " + ;
1630:                         STR(par_nTransferido * 100 / par_nTamanho, 3, 2) + "% completado"
1631: 
1632:                     loc_cTempoEstimado  = THIS.SecToHour(INT(((par_nTamanho - par_nTransferido) * loc_nSegundos) / par_nTransferido))
1633:                     loc_cTempoDecorrido = THIS.SecToHour(SECONDS() - par_nSegIniciais)
1634: 
1635:                     THIS.lbl_4c_Progresso.Caption = "Tempo decorrido: " + loc_cTempoDecorrido + ;

*-- Linhas 1651 a 1694:
1651: 
1652:                     THIS.Inf("Arquivo Transferido...", "B")
1653: 
1654:                     *-- "Atualiza os listbox dos arquivos" do PROCEDURE
1655:                     *-- processa legado: registra o arquivo concluido na
1656:                     *-- lista de DESTINO e, se configurado, apaga o arquivo
1657:                     *-- de ORIGEM (this_lDelLocal para envio / this_lDelHost
1658:                     *-- para recebimento) e o remove da lista de origem
1659:                     IF par_cPastaLocal == THIS.this_oBusinessObject.this_cDirEnvFtp
1660:                         *-- Enviando arquivos para o FTP: registra em
1661:                         *-- lst_4c_RecLoc (pgf_4c_Ftp.Page1 "Enviados")
1662:                         WITH THIS.cnt_4c_Navegacao.pgf_4c_Ftp.Page1.lst_4c_RecLoc
1663:                             loc_nIndice = .ListCount + 1
1664:                             .AddItem(par_cArquivo, loc_nIndice, 1)
1665:                             .AddListItem(STR(par_nTamanho), loc_nIndice, 2)
1666:                             .AddListItem(STR(par_nTransferido), loc_nIndice, 3)
1667:                             .Refresh()
1668:                         ENDWITH
1669: 
1670:                         IF THIS.this_oBusinessObject.this_lDelLocal
1671:                             THIS.Inf("Exclu" + CHR(237) + "ndo o arquivo local " + par_cPastaLocal + par_cArquivo, "B")
1672: 
1673:                             ERASE (par_cPastaLocal + par_cArquivo)
1674: 
1675:                             IF FILE(par_cPastaLocal + par_cArquivo)
1676:                                 THIS.Inf("Falha na exclus" + CHR(227) + "o do arquivo local " + par_cPastaLocal + par_cArquivo, "R")
1677:                             ELSE
1678:                                 THIS.Inf("Arquivo Local " + par_cPastaLocal + par_cArquivo + " foi exclu" + CHR(237) + "do com sucesso", "B")
1679:                             ENDIF
1680: 
1681:                             *-- Remove o arquivo da lista de origem (lst_4c_EnvFtp)
1682:                             WITH THIS.cnt_4c_Navegacao.pgf_4c_Loc.Page1.lst_4c_EnvFtp
1683:                                 FOR loc_nPos = 1 TO .ListCount
1684:                                     IF UPPER(ALLTRIM(.List(loc_nPos, 1))) == UPPER(par_cArquivo)
1685:                                         .RemoveItem(loc_nPos)
1686:                                         EXIT
1687:                                     ENDIF
1688:                                 ENDFOR
1689:                             ENDWITH
1690:                         ENDIF
1691:                     ENDIF
1692: 
1693:                     IF par_cPastaHost == THIS.this_oBusinessObject.this_cDirEnvLoc
1694:                         *-- Recebendo do FTP: registra em lst_4c_RecFtp

*-- Linhas 1732 a 1791:
1732: 
1733:     *==========================================================================
1734:     * MontaContainer - "Monta os pageframes com todos os arquivos a enviar e
1735:     * receber" (equivalente ao PROCEDURE montacontainer do legado): carrega a
1736:     * listagem do diretorio REMOTO (via THIS.CarregarDados), filtra pela
1737:     * mascara this_cTpRec e povoa lst_4c_EnvLoc (Page2 "A Receber" do
1738:     * pgf_4c_Ftp), e lista a pasta LOCAL de envio em lst_4c_EnvFtp,
1739:     * registrando no log o mesmo roteiro do legado.
1740:     *
1741:     * DIVERGENCIA DOCUMENTADA (fiel ao legado, nao simplificada): o cursor
1742:     * remoto (cursor_4c_FtpServer) nao pode ser filtrado por wildcard
1743:     * diretamente - o legado grava cada NOME num arquivo VAZIO dentro de uma
1744:     * pasta TEMPORARIA (Strtofile) e roda ADIR com a mascara this_cTpRec
1745:     * sobre essa pasta, ja que ADIR so filtra arquivos REAIS em disco.
1746:     * Reproduzido aqui com SYS(2023) (pasta temp do Windows) + MKDIR +
1747:     * STRTOFILE + ADIR + ERASE, na MESMA ordem - necessario porque
1748:     * this_cTpRec vem da configuracao da empresa (SigCdEmp) e PODE nao ser
1749:     * "*.*".
1750:     *==========================================================================
1751:     PROTECTED PROCEDURE MontaContainer()
1752:         LOCAL loc_lSucesso, loc_nArquivosLocais, loc_nPos, loc_cPastaTemp, ;
1753:             loc_cDefaultAnterior, loc_nArquivosMascara, loc_nCont, loc_nItem
1754:         LOCAL ARRAY loc_aArquivosLocais[1], loc_aArquivosMascara[1]
1755: 
1756:         loc_lSucesso = .T.
1757: 
1758:         THIS.Inf("Carregando os par" + CHR(226) + "metros da tela... Aguarde", "B")
1759: 
1760:         *-- A Receber do Host: lista o diretorio REMOTO no servidor FTP e
1761:         *-- filtra pela mascara this_cTpRec antes de povoar lst_4c_EnvLoc
1762:         IF !EMPTY(THIS.this_oBusinessObject.this_cDirEnvLoc)
1763:             THIS.Inf("Estabelecendo uma conex" + CHR(227) + "o com o servidor FTP no endere" + CHR(231) + "o " + ;
1764:                 THIS.this_oBusinessObject.this_cFtpAdd, "B")
1765: 
1766:             IF THIS.CarregarDados(THIS.this_oBusinessObject.this_cDirEnvLoc, "*.*") AND USED("cursor_4c_FtpServer")
1767:                 THIS.cnt_4c_Navegacao.pgf_4c_Ftp.Page2.lst_4c_EnvLoc.Clear()
1768: 
1769:                 loc_cDefaultAnterior = SYS(5) + SYS(2003)
1770:                 loc_cPastaTemp       = ADDBS(SYS(2023)) + SYS(3)
1771:                 MKDIR (loc_cPastaTemp)
1772:                 SET DEFAULT TO (loc_cPastaTemp)
1773: 
1774:                 SELECT cursor_4c_FtpServer
1775:                 SCAN
1776:                     =STRTOFILE("1", cursor_4c_FtpServer.nome)
1777:                 ENDSCAN
1778: 
1779:                 loc_nArquivosMascara = ADIR(loc_aArquivosMascara, ALLTRIM(THIS.this_oBusinessObject.this_cTpRec))
1780: 
1781:                 loc_nItem = 0
1782:                 FOR loc_nCont = 1 TO loc_nArquivosMascara
1783:                     SELECT cursor_4c_FtpServer
1784:                     LOCATE FOR ALLTRIM(UPPER(cursor_4c_FtpServer.nome)) = ALLTRIM(UPPER(loc_aArquivosMascara[loc_nCont, 1]))
1785:                     IF FOUND() AND SUBSTR(cursor_4c_FtpServer.tipo, 1, 1) == "A"
1786:                         loc_nItem = loc_nItem + 1
1787:                         WITH THIS.cnt_4c_Navegacao.pgf_4c_Ftp.Page2.lst_4c_EnvLoc
1788:                             .AddItem(ALLTRIM(cursor_4c_FtpServer.nome), loc_nItem, 1)
1789:                             .AddListItem(cursor_4c_FtpServer.tama, loc_nItem, 2)
1790:                             .AddListItem(cursor_4c_FtpServer.data, loc_nItem, 3)
1791:                         ENDWITH

*-- Linhas 1819 a 1895:
1819: 
1820:         *-- Local -> Host (A Enviar para o Host): lista a pasta LOCAL de onde
1821:         *-- os arquivos saem e povoa lst_4c_EnvFtp (equivalente ao bloco
1822:         *-- "Local -> Host" do PROCEDURE montacontainer legado - nome,
1823:         *-- tamanho e data de cada arquivo, ordenados por nome)
1824:         IF loc_lSucesso AND !EMPTY(THIS.this_oBusinessObject.this_cDirEnvFtp)
1825:             THIS.cnt_4c_Navegacao.pgf_4c_Loc.Page1.lst_4c_EnvFtp.Clear()
1826: 
1827:             loc_nArquivosLocais = ADIR(loc_aArquivosLocais, ;
1828:                 ADDBS(ALLTRIM(THIS.this_oBusinessObject.this_cDirEnvFtp)) + ;
1829:                 ALLTRIM(THIS.this_oBusinessObject.this_cTpEnv))
1830: 
1831:             IF loc_nArquivosLocais > 0
1832:                 ASORT(loc_aArquivosLocais)
1833: 
1834:                 FOR loc_nPos = 1 TO loc_nArquivosLocais
1835:                     WITH THIS.cnt_4c_Navegacao.pgf_4c_Loc.Page1.lst_4c_EnvFtp
1836:                         .AddItem(loc_aArquivosLocais[loc_nPos, 1], loc_nPos, 1)
1837:                         .AddListItem(STR(loc_aArquivosLocais[loc_nPos, 2], 10, 0), loc_nPos, 2)
1838:                         .AddListItem(DTOC(loc_aArquivosLocais[loc_nPos, 3]), loc_nPos, 3)
1839:                     ENDWITH
1840:                 ENDFOR
1841:             ENDIF
1842: 
1843:             THIS.cnt_4c_Navegacao.pgf_4c_Loc.Page1.lst_4c_EnvFtp.Refresh()
1844: 
1845:             THIS.Inf("Lista de arquivos Locais j" + CHR(225) + " carregada do " + ;
1846:                 THIS.this_oBusinessObject.this_cDirEnvFtp, "B")
1847:             THIS.Inf("Pronto para a Transfer" + CHR(234) + "ncia... Clique no bot" + CHR(227) + "o (Transfere)", "G")
1848:         ENDIF
1849: 
1850:         RETURN loc_lSucesso
1851:     ENDPROC
1852: 
1853:     *==========================================================================
1854:     * VerificarArquivoFtp - Confirma que um arquivo existe no servidor FTP,
1855:     * tentando abri-lo para leitura (equivalente ao PROCEDURE rasfile do
1856:     * legado). Usado antes de receber um arquivo e, apos o envio, para
1857:     * confirmar que o arquivo renomeado ficou disponivel no destino.
1858:     *==========================================================================
1859:     PROTECTED FUNCTION VerificarArquivoFtp(par_cFtpAdd, par_cFtpUser, par_cFtpPass, par_cArquivoRemoto)
1860:         LOCAL loc_nInternet, loc_nFtp, loc_nArquivoFtp, loc_lOk
1861: 
1862:         #DEFINE INTERNET_OPEN_TYPE_DIRECT_VF   1
1863:         #DEFINE INTERNET_DEFAULT_FTP_PORT_VF  21
1864:         #DEFINE INTERNET_SERVICE_FTP_VF        1
1865:         #DEFINE INTERNET_FLAG_PASSIVE_VF 14217728
1866:         #DEFINE FTP_TRANSFER_TYPE_BINARY_VF    2
1867:         #DEFINE GENERIC_READ_VF       2147483648
1868: 
1869:         loc_lOk = .F.
1870: 
1871:         DECLARE LONG InternetOpen IN "wininet.dll" ;
1872:             STRING lpszAgent, LONG dwAccessType, STRING lpszProxyName, ;
1873:             STRING lpszProxyBypass, LONG dwFlags
1874: 
1875:         DECLARE LONG InternetConnect IN "wininet.dll" ;
1876:             LONG hInternetSession, STRING lpszServerName, LONG nServerPort, ;
1877:             STRING lpszUsername, STRING lpszPassword, LONG dwService, ;
1878:             LONG dwFlags, LONG dwContext
1879: 
1880:         DECLARE INTEGER InternetCloseHandle IN "wininet.dll" LONG hInet
1881: 
1882:         DECLARE LONG GetLastError IN WIN32API
1883: 
1884:         DECLARE LONG FtpOpenFile IN "wininet.dll" ;
1885:             LONG hFtpSession, STRING lpszFileName, INTEGER fdwAccess, ;
1886:             INTEGER dwFlags, INTEGER dwContext
1887: 
1888:         THIS.Inf("Estabelecendo uma conex" + CHR(227) + "o com a Internet", "G")
1889:         loc_nInternet = InternetOpen("vfp", INTERNET_OPEN_TYPE_DIRECT_VF, "", "", 0)
1890: 
1891:         IF loc_nInternet = 0
1892:             THIS.Inf("Erro na conex" + CHR(227) + "o com o servidor. " + ;
1893:                 ALLTRIM(THIS.InErrorCase(GetLastError())), "R")
1894:             RETURN .F.
1895:         ENDIF

*-- Linhas 1930 a 1973:
1930: 
1931:     *==========================================================================
1932:     * RenomearArquivoFtp - Renomeia um arquivo no servidor FTP (equivalente ao
1933:     * PROCEDURE renameftpfile do legado). Usado por EnviarArquivoFtp para
1934:     * restaurar o nome definitivo do arquivo apos o upload do temporario.
1935:     *==========================================================================
1936:     PROTECTED FUNCTION RenomearArquivoFtp(par_cFtpAdd, par_cFtpUser, par_cFtpPass, par_cArquivoAntigo, par_cArquivoNovo)
1937:         LOCAL loc_nInternet, loc_nFtp, loc_nResultado, loc_cAntigo, loc_cNovo
1938: 
1939:         #DEFINE INTERNET_OPEN_TYPE_DIRECT_NF   1
1940:         #DEFINE INTERNET_DEFAULT_FTP_PORT_NF  21
1941:         #DEFINE INTERNET_SERVICE_FTP_NF        1
1942:         #DEFINE INTERNET_FLAG_PASSIVE_NF 14217728
1943: 
1944:         DECLARE LONG InternetOpen IN "wininet.dll" ;
1945:             STRING lpszAgent, LONG dwAccessType, STRING lpszProxyName, ;
1946:             STRING lpszProxyBypass, LONG dwFlags
1947: 
1948:         DECLARE LONG InternetConnect IN "wininet.dll" ;
1949:             LONG hInternetSession, STRING lpszServerName, LONG nServerPort, ;
1950:             STRING lpszUsername, STRING lpszPassword, LONG dwService, ;
1951:             LONG dwFlags, LONG dwContext
1952: 
1953:         DECLARE INTEGER InternetCloseHandle IN "wininet.dll" LONG hInet
1954: 
1955:         DECLARE LONG GetLastError IN WIN32API
1956: 
1957:         DECLARE INTEGER FtpRenameFile IN WinInet ;
1958:             INTEGER nConnect_Handle, STRING @lpcRemoteFile, STRING @lpcNewFile
1959: 
1960:         loc_nInternet = InternetOpen("vfp", INTERNET_OPEN_TYPE_DIRECT_NF, "", "", 0)
1961:         IF loc_nInternet = 0
1962:             THIS.Inf("Erro na conex" + CHR(227) + "o com o servidor. " + ;
1963:                 ALLTRIM(THIS.InErrorCase(GetLastError())), "R")
1964:             RETURN .F.
1965:         ENDIF
1966: 
1967:         loc_nFtp = InternetConnect(loc_nInternet, par_cFtpAdd, INTERNET_DEFAULT_FTP_PORT_NF, ;
1968:             par_cFtpUser, par_cFtpPass, INTERNET_SERVICE_FTP_NF, INTERNET_FLAG_PASSIVE_NF, 0)
1969:         IF loc_nFtp = 0
1970:             THIS.Inf("Erro na conex" + CHR(227) + "o com o servidor FTP. " + ;
1971:                 ALLTRIM(THIS.InErrorCase(GetLastError())), "R")
1972:             InternetCloseHandle(loc_nInternet)
1973:             RETURN .F.

*-- Linhas 1986 a 2029:
1986: 
1987:     *==========================================================================
1988:     * ExcluirArquivoFtp - Apaga um arquivo no servidor FTP (equivalente ao
1989:     * PROCEDURE deleteftpfile do legado), tentando por ate 60 segundos.
1990:     * Usado por Processa quando this_lDelHost esta ativo.
1991:     *==========================================================================
1992:     PROTECTED FUNCTION ExcluirArquivoFtp(par_cFtpAdd, par_cFtpUser, par_cFtpPass, par_cArquivoRemoto)
1993:         LOCAL loc_nInternet, loc_nFtp, loc_cArquivo, loc_nResultado, ;
1994:             loc_lContinua, loc_tSegIni, loc_tSegFim
1995: 
1996:         #DEFINE INTERNET_OPEN_TYPE_DIRECT_XF   1
1997:         #DEFINE INTERNET_DEFAULT_FTP_PORT_XF  21
1998:         #DEFINE INTERNET_SERVICE_FTP_XF        1
1999:         #DEFINE INTERNET_FLAG_PASSIVE_XF 14217728
2000: 
2001:         DECLARE LONG InternetOpen IN "wininet.dll" ;
2002:             STRING lpszAgent, LONG dwAccessType, STRING lpszProxyName, ;
2003:             STRING lpszProxyBypass, LONG dwFlags
2004: 
2005:         DECLARE LONG InternetConnect IN "wininet.dll" ;
2006:             LONG hInternetSession, STRING lpszServerName, LONG nServerPort, ;
2007:             STRING lpszUsername, STRING lpszPassword, LONG dwService, ;
2008:             LONG dwFlags, LONG dwContext
2009: 
2010:         DECLARE INTEGER InternetCloseHandle IN "wininet.dll" LONG hInet
2011: 
2012:         DECLARE LONG GetLastError IN WIN32API
2013: 
2014:         DECLARE INTEGER FtpDeleteFile IN WinInet ;
2015:             INTEGER nConnect_Handle, STRING @lpcFileName
2016: 
2017:         loc_nInternet = InternetOpen("vfp", INTERNET_OPEN_TYPE_DIRECT_XF, "", "", 0)
2018:         IF loc_nInternet = 0
2019:             THIS.Inf("Erro na conex" + CHR(227) + "o com o servidor. " + ;
2020:                 ALLTRIM(THIS.InErrorCase(GetLastError())), "R")
2021:             RETURN .F.
2022:         ENDIF
2023: 
2024:         loc_nFtp = InternetConnect(loc_nInternet, par_cFtpAdd, INTERNET_DEFAULT_FTP_PORT_XF, ;
2025:             par_cFtpUser, par_cFtpPass, INTERNET_SERVICE_FTP_XF, INTERNET_FLAG_PASSIVE_XF, 0)
2026:         IF loc_nFtp = 0
2027:             THIS.Inf("Erro na conex" + CHR(227) + "o com o servidor FTP. " + ;
2028:                 ALLTRIM(THIS.InErrorCase(GetLastError())), "R")
2029:             InternetCloseHandle(loc_nInternet)

*-- Linhas 2049 a 2092:
2049: 
2050:     *==========================================================================
2051:     * EnviarArquivoFtp - Envia um arquivo LOCAL para o servidor FTP
2052:     * (equivalente ao PROCEDURE rasftpput do legado): sobe o conteudo com
2053:     * FtpPutFile sob um nome TEMPORARIO (extensao trocada por ".ftp"),
2054:     * dispara o Processa "I"/"A" em torno do upload e, tendo sucesso, renomeia
2055:     * o temporario para o nome definitivo e confirma a existencia final com
2056:     * VerificarArquivoFtp.
2057:     *
2058:     * DIVERGENCIA DOCUMENTADA: o legado, apos renomear, ainda chama
2059:     * ThisForm.raslisarq(...) para recarregar uma listagem completa do
2060:     * diretorio remoto (cursor "ftpserver", nao utilizado por nenhum outro
2061:     * ponto do form) so para obter um booleano de confirmacao - na pratica
2062:     * sempre .T. quando a conexao permanece de pe, exatamente a mesma garantia
2063:     * que VerificarArquivoFtp ja fornece de forma direta. Reproduzir essa
2064:     * listagem completa duplicaria CarregarDados/CrackFile sem mudar o
2065:     * resultado observavel (loc_lOk), entao o passo fica resumido a
2066:     * VerificarArquivoFtp - mantendo o efeito (confirmar sucesso do envio),
2067:     * sem inventar comportamento novo.
2068:     *==========================================================================
2069:     PROTECTED FUNCTION EnviarArquivoFtp(par_cFtpAdd, par_cFtpUser, par_cFtpPass, par_cArquivoLocal, par_cArquivoRemoto)
2070:         LOCAL loc_nInternet, loc_nFtp, loc_cArquivoTemp, loc_nTamanho, ;
2071:             loc_nSegIni, loc_nSegFim, loc_lOk
2072: 
2073:         #DEFINE INTERNET_OPEN_TYPE_DIRECT_EF   1
2074:         #DEFINE INTERNET_DEFAULT_FTP_PORT_EF  21
2075:         #DEFINE INTERNET_SERVICE_FTP_EF        1
2076:         #DEFINE INTERNET_FLAG_PASSIVE_EF 14217728
2077:         #DEFINE FTP_TRANSFER_TYPE_BINARY_EF    2
2078: 
2079:         loc_lOk = .F.
2080: 
2081:         DECLARE LONG InternetOpen IN "wininet.dll" ;
2082:             STRING lpszAgent, LONG dwAccessType, STRING lpszProxyName, ;
2083:             STRING lpszProxyBypass, LONG dwFlags
2084: 
2085:         DECLARE LONG InternetConnect IN "wininet.dll" ;
2086:             LONG hInternetSession, STRING lpszServerName, LONG nServerPort, ;
2087:             STRING lpszUsername, STRING lpszPassword, LONG dwService, ;
2088:             LONG dwFlags, LONG dwContext
2089: 
2090:         DECLARE INTEGER InternetCloseHandle IN "wininet.dll" LONG hInet
2091: 
2092:         DECLARE LONG GetLastError IN WIN32API

*-- Linhas 2172 a 2215:
2172: 
2173:     *==========================================================================
2174:     * ReceberArquivoFtp - Recebe um arquivo do servidor FTP para uma pasta
2175:     * LOCAL (equivalente ao PROCEDURE rasftpget do legado): baixa o conteudo
2176:     * com FtpGetFile sob um nome LOCAL temporario (extensao trocada por
2177:     * ".ftp") e, tendo sucesso, renomeia para o nome definitivo.
2178:     *==========================================================================
2179:     PROTECTED FUNCTION ReceberArquivoFtp(par_cFtpAdd, par_cFtpUser, par_cFtpPass, par_cArquivoRemoto, par_cArquivoLocal)
2180:         LOCAL loc_nInternet, loc_nFtp, loc_cArquivoTemp, loc_nTamanho, ;
2181:             loc_nSegIni, loc_nSegFim, loc_lOk
2182: 
2183:         #DEFINE INTERNET_OPEN_TYPE_DIRECT_GF    1
2184:         #DEFINE INTERNET_DEFAULT_FTP_PORT_GF   21
2185:         #DEFINE INTERNET_SERVICE_FTP_GF         1
2186:         #DEFINE INTERNET_FLAG_PASSIVE_GF  14217728
2187:         #DEFINE FILE_ATTRIBUTE_NORMAL_GF      128
2188:         #DEFINE FTP_TRANSFER_TYPE_BINARY_GF     2
2189: 
2190:         loc_lOk     = .F.
2191:         loc_nTamanho = 0
2192: 
2193:         DECLARE LONG InternetOpen IN "wininet.dll" ;
2194:             STRING lpszAgent, LONG dwAccessType, STRING lpszProxyName, ;
2195:             STRING lpszProxyBypass, LONG dwFlags
2196: 
2197:         DECLARE LONG InternetConnect IN "wininet.dll" ;
2198:             LONG hInternetSession, STRING lpszServerName, LONG nServerPort, ;
2199:             STRING lpszUsername, STRING lpszPassword, LONG dwService, ;
2200:             LONG dwFlags, LONG dwContext
2201: 
2202:         DECLARE INTEGER InternetCloseHandle IN "wininet.dll" LONG hInet
2203: 
2204:         DECLARE LONG GetLastError IN WIN32API
2205: 
2206:         DECLARE INTEGER FtpGetFile IN "wininet.dll" ;
2207:             LONG hFtpSession, STRING lpszRemoteFile, STRING lpszNewFile, ;
2208:             LONG fFailIfExist, LONG dwFlagsAndAttributes, LONG dwFlags, LONG dwContext
2209: 
2210:         loc_nInternet = InternetOpen("vfp", INTERNET_OPEN_TYPE_DIRECT_GF, "", "", 0)
2211:         IF loc_nInternet = 0
2212:             THIS.Inf("Erro na conex" + CHR(227) + "o com o servidor. " + ;
2213:                 ALLTRIM(THIS.InErrorCase(GetLastError())), "R")
2214:             RETURN .F.
2215:         ENDIF

*-- Linhas 2270 a 2359:
2270: 
2271:     *==========================================================================
2272:     * Transferir / Receber - Disparam o envio/recebimento de arquivos
2273:     * (equivalentes aos PROCEDURE transfere/recebe do legado, chamados com
2274:     * par_cModo = "A" para todos os arquivos ou "I" para selecao individual).
2275:     * A origem eh o mesmo ListBox que MontaContainer/lst_4c_* ja mantem
2276:     * populado (lst_4c_EnvFtp para envio, lst_4c_EnvLoc para recebimento);
2277:     * o loop percorre a selecao (ou todos, conforme par_cModo) chamando
2278:     * EnviarArquivoFtp/ReceberArquivoFtp arquivo a arquivo, replicando o
2279:     * DO CASE ptptrans == "I"/"A" e o guard de selecao vazia do legado.
2280:     *==========================================================================
2281:     PROTECTED PROCEDURE Transferir(par_cModo)
2282:         LOCAL loc_oObj, loc_nQtd, loc_nPos, loc_nSelecionados, loc_lOk, ;
2283:             loc_cArquivo, loc_cArquivoLocal, loc_cArquivoRemoto
2284:         LOCAL ARRAY loc_aArquivos[1]
2285: 
2286:         *-- Le os diretorios da tela para o BO (FormParaBO) antes de montar
2287:         *-- qualquer caminho: e dali que saem this_cDirEnvFtp/this_cDirRecLoc
2288:         IF !THIS.FormParaBO()
2289:             RETURN .F.
2290:         ENDIF
2291: 
2292:         loc_oObj = THIS.cnt_4c_Navegacao.pgf_4c_Loc.Page1.lst_4c_EnvFtp
2293:         loc_nQtd = loc_oObj.ListCount
2294: 
2295:         IF loc_nQtd <= 0
2296:             THIS.Inf("N" + CHR(227) + "O existe nenhum arquivo a ser Transferido para o FTP.", "B")
2297:             RETURN .F.
2298:         ENDIF
2299: 
2300:         DIMENSION loc_aArquivos(loc_nQtd)
2301:         loc_nSelecionados = 0
2302: 
2303:         FOR loc_nPos = 1 TO loc_nQtd
2304:             DO CASE
2305:                 CASE par_cModo == "I"
2306:                     IF loc_oObj.Selected(loc_nPos)
2307:                         loc_nSelecionados = loc_nSelecionados + 1
2308:                         loc_aArquivos(loc_nPos) = loc_oObj.List(loc_nPos, 1)
2309:                     ELSE
2310:                         loc_aArquivos(loc_nPos) = ""
2311:                     ENDIF
2312:                 CASE par_cModo == "A"
2313:                     loc_aArquivos(loc_nPos) = loc_oObj.List(loc_nPos, 1)
2314:             ENDCASE
2315:         ENDFOR
2316: 
2317:         IF par_cModo == "I" AND loc_nSelecionados <= 0
2318:             THIS.Inf("Nenhum arquivo da lista foi selecionado.", "R")
2319:             MsgAviso("Nenhum Arquivo est" + CHR(225) + " selecionado na lista", "Aviso...")
2320:             RETURN .F.
2321:         ENDIF
2322: 
2323:         THIS.HabilitarCampos(.F.)
2324: 
2325:         loc_lOk = .T.
2326:         FOR loc_nPos = 1 TO loc_nQtd
2327:             loc_cArquivo = loc_aArquivos(loc_nPos)
2328: 
2329:             IF EMPTY(ALLTRIM(loc_cArquivo))
2330:                 LOOP
2331:             ENDIF
2332: 
2333:             loc_cArquivoLocal  = ALLTRIM(THIS.this_oBusinessObject.this_cDirEnvFtp + ALLTRIM(loc_cArquivo))
2334:             loc_cArquivoRemoto = LOWER(ALLTRIM(THIS.this_oBusinessObject.this_cDirRecLoc + ALLTRIM(loc_cArquivo)))
2335: 
2336:             THIS.Inf("Processando o arquivo Local " + loc_cArquivoLocal + " para enviar ao FTP", "G")
2337: 
2338:             fGravarLog("X", THIS.Name, "ENVIO FTP", ;
2339:                 SUBSTR("INICIANDO ENVIO DE " + JUSTFNAME(loc_cArquivoLocal), 1, 70), gc_4c_UsuarioLogado)
2340: 
2341:             IF THIS.EnviarArquivoFtp(THIS.this_oBusinessObject.this_cFtpAdd, ;
2342:                     THIS.this_oBusinessObject.this_cFtpUser, ;
2343:                     THIS.this_oBusinessObject.this_cFtpPass, ;
2344:                     loc_cArquivoLocal, loc_cArquivoRemoto)
2345:                 loc_lOk = .T.
2346:                 THIS.Inf("Arquivo Local " + loc_cArquivoLocal + " transferido para FTP.", "G")
2347:                 fGravarLog("X", THIS.Name, "ENVIO FTP", ;
2348:                     SUBSTR("ENVIO OK DE " + JUSTFNAME(loc_cArquivoLocal), 1, 70), gc_4c_UsuarioLogado)
2349:             ELSE
2350:                 loc_lOk = .F.
2351:                 THIS.Inf("Problema: Arquivo Local " + loc_cArquivoLocal + " N" + CHR(227) + "O foi transferido para o FTP.", "R")
2352:                 fGravarLog("X", THIS.Name, "ENVIO FTP", ;
2353:                     SUBSTR("FALHA NO ENVIO DE " + JUSTFNAME(loc_cArquivoLocal), 1, 70), gc_4c_UsuarioLogado)
2354:                 EXIT
2355:             ENDIF
2356:         ENDFOR
2357: 
2358:         IF loc_lOk
2359:             THIS.Inf("Opera" + CHR(231) + CHR(227) + "o de transfer" + CHR(234) + "ncia Conclu" + CHR(237) + "da", "B")

*-- Linhas 2366 a 2447:
2366:         RETURN loc_lOk
2367:     ENDPROC
2368: 
2369:     PROTECTED PROCEDURE Receber(par_cModo)
2370:         LOCAL loc_oObj, loc_nQtd, loc_nPos, loc_nSelecionados, loc_lOk, ;
2371:             loc_cArquivo, loc_cArquivoLocal, loc_cArquivoFtp
2372:         LOCAL ARRAY loc_aArquivos[1]
2373: 
2374:         *-- Le os diretorios da tela para o BO (FormParaBO) antes de montar
2375:         *-- qualquer caminho: e dali que saem this_cDirEnvLoc/this_cDirRecFtp
2376:         IF !THIS.FormParaBO()
2377:             RETURN .F.
2378:         ENDIF
2379: 
2380:         loc_oObj = THIS.cnt_4c_Navegacao.pgf_4c_Ftp.Page2.lst_4c_EnvLoc
2381:         loc_nQtd = loc_oObj.ListCount
2382: 
2383:         IF loc_nQtd <= 0
2384:             THIS.Inf("N" + CHR(227) + "O existe nenhum arquivo a ser recebido do FTP.", "B")
2385:             RETURN .F.
2386:         ENDIF
2387: 
2388:         DIMENSION loc_aArquivos(loc_nQtd)
2389:         loc_nSelecionados = 0
2390: 
2391:         FOR loc_nPos = 1 TO loc_nQtd
2392:             DO CASE
2393:                 CASE par_cModo == "I"
2394:                     IF loc_oObj.Selected(loc_nPos)
2395:                         loc_nSelecionados = loc_nSelecionados + 1
2396:                         loc_aArquivos(loc_nPos) = loc_oObj.List(loc_nPos, 1)
2397:                     ELSE
2398:                         loc_aArquivos(loc_nPos) = ""
2399:                     ENDIF
2400:                 CASE par_cModo == "A"
2401:                     loc_aArquivos(loc_nPos) = loc_oObj.List(loc_nPos, 1)
2402:             ENDCASE
2403:         ENDFOR
2404: 
2405:         IF par_cModo == "I" AND loc_nSelecionados <= 0
2406:             THIS.Inf("Nenhum arquivo da lista foi selecionado.", "R")
2407:             MsgAviso("Nenhum Arquivo est" + CHR(225) + " selecionado na lista", "Aviso...")
2408:             RETURN .F.
2409:         ENDIF
2410: 
2411:         THIS.HabilitarCampos(.F.)
2412: 
2413:         loc_lOk = .T.
2414:         FOR loc_nPos = 1 TO loc_nQtd
2415:             loc_cArquivo = loc_aArquivos(loc_nPos)
2416: 
2417:             IF EMPTY(ALLTRIM(loc_cArquivo))
2418:                 LOOP
2419:             ENDIF
2420: 
2421:             loc_cArquivoFtp   = ALLTRIM(THIS.this_oBusinessObject.this_cDirEnvLoc + ALLTRIM(loc_cArquivo))
2422:             loc_cArquivoLocal = ALLTRIM(THIS.this_oBusinessObject.this_cDirRecFtp + ALLTRIM(loc_cArquivo))
2423: 
2424:             THIS.Inf("Processando o arquivo " + loc_cArquivoFtp + " para receber do FTP", "G")
2425: 
2426:             fGravarLog("X", THIS.Name, "REC FTP", ;
2427:                 SUBSTR("INICIANDO RECEPCAO DE " + JUSTFNAME(loc_cArquivoFtp), 1, 70), gc_4c_UsuarioLogado)
2428: 
2429:             IF THIS.VerificarArquivoFtp(THIS.this_oBusinessObject.this_cFtpAdd, ;
2430:                     THIS.this_oBusinessObject.this_cFtpUser, ;
2431:                     THIS.this_oBusinessObject.this_cFtpPass, loc_cArquivoFtp)
2432:                 IF THIS.ReceberArquivoFtp(THIS.this_oBusinessObject.this_cFtpAdd, ;
2433:                         THIS.this_oBusinessObject.this_cFtpUser, ;
2434:                         THIS.this_oBusinessObject.this_cFtpPass, ;
2435:                         loc_cArquivoFtp, loc_cArquivoLocal)
2436:                     fGravarLog("X", THIS.Name, "REC FTP", ;
2437:                         SUBSTR("RECEPCAO OK DE " + JUSTFNAME(loc_cArquivoFtp), 1, 70), gc_4c_UsuarioLogado)
2438:                     loc_lOk = .T.
2439:                 ELSE
2440:                     fGravarLog("X", THIS.Name, "REC FTP", ;
2441:                         SUBSTR("FALHA NA RECEPCAO DE " + JUSTFNAME(loc_cArquivoFtp), 1, 70), gc_4c_UsuarioLogado)
2442:                     loc_lOk = .F.
2443:                 ENDIF
2444:             ELSE
2445:                 loc_lOk = .F.
2446:             ENDIF
2447: 

*-- Linhas 2477 a 2520:
2477:     * PROTECTED porque FormBase.BOParaForm eh PROTECTED - VFP9 nao permite
2478:     * ALARGAR o escopo de um metodo herdado.
2479:     *==========================================================================
2480:     PROTECTED PROCEDURE BOParaForm()
2481:         LOCAL loc_oPgLoc, loc_oPgFtp
2482: 
2483:         loc_oPgLoc = THIS.cnt_4c_Navegacao.pgf_4c_Loc
2484:         loc_oPgFtp = THIS.cnt_4c_Navegacao.pgf_4c_Ftp
2485: 
2486:         WITH THIS.this_oBusinessObject
2487:             loc_oPgLoc.Page1.txt_4c_DirEnvFtp.Value       = .this_cDirEnvFtp
2488:             loc_oPgLoc.Page1.txt_4c_DirEnvFtp.ToolTipText = .this_cDirEnvFtp
2489: 
2490:             loc_oPgLoc.Page2.txt_4c_DirRecFtp.Value       = .this_cDirRecFtp
2491:             loc_oPgLoc.Page2.txt_4c_DirRecFtp.ToolTipText = .this_cDirRecFtp
2492: 
2493:             loc_oPgFtp.Page1.txt_4c_DirRecLoc.Value       = .this_cDirRecLoc
2494:             loc_oPgFtp.Page1.txt_4c_DirRecLoc.ToolTipText = .this_cDirRecLoc
2495: 
2496:             loc_oPgFtp.Page2.txt_4c_DirEnvLoc.Value       = .this_cDirEnvLoc
2497:             loc_oPgFtp.Page2.txt_4c_DirEnvLoc.ToolTipText = .this_cDirEnvLoc
2498:         ENDWITH
2499:     ENDPROC
2500: 
2501:     *==========================================================================
2502:     * FormParaBO - Le de volta os quatro campos de diretorio da tela para as
2503:     * properties do BO, aplicando a MESMA normalizacao do Init legado:
2504:     *   pasta LOCAL  -> ADDBS(LOWER(ALLTRIM(x)))
2505:     *   pasta REMOTA -> LOWER(ALLTRIM(x)) + "/" quando ainda nao termina em "/"
2506:     * (iif(right(cDir,1)=="/" or empt(cDir), cDir, cDir+"/") do legado)
2507:     *
2508:     * Campo em BRANCO nao sobrescreve a property: sem isso um campo apagado
2509:     * zeraria a configuracao resolvida e a transferencia passaria a montar
2510:     * caminho a partir de "" - e os guards de sentido de ConfigurarPaginaDados
2511:     * (que rodam no Init) nao seriam reavaliados. Pasta LOCAL que nao existe
2512:     * no disco aborta e avisa, como o Init legado ja faz com DIRECTORY().
2513:     *
2514:     * DIVERGENCIA DELIBERADA, documentada: no legado os quatro TextBox ficam
2515:     * editaveis (nao tem ReadOnly nem ControlSource) mas NADA le o valor de
2516:     * volta - toda rotina de transferencia usa ThisForm._DirEnvFtp etc. Editar
2517:     * a pasta na tela legada, portanto, nao tem efeito nenhum (os proprios
2518:     * botoes "..." de escolher pasta estao com Enabled = .F. no SCX, sinal de
2519:     * que o caminho de edicao ficou inacabado). Aqui a edicao passa a valer,
2520:     * porque campo habilitado que ignora o que o usuario digita eh defeito, nao

*-- Linhas 2542 a 2699:
2542:         *-- checagem com "if !empt(_DirEnvFtp) and !DIRECTORY(_DirEnvFtp)")
2543:         IF !EMPTY(loc_cEnvFtp) AND !DIRECTORY(loc_cEnvFtp)
2544:             THIS.Inf("A pasta local de envio " + loc_cEnvFtp + " n" + CHR(227) + "o existe. Por favor verifique.", "R")
2545:             MsgAviso("A pasta local de envio informada n" + CHR(227) + "o existe:" + CHR(13) + loc_cEnvFtp, ;
2546:                 "Aten" + CHR(231) + CHR(227) + "o")
2547:             loc_lOk = .F.
2548:         ENDIF
2549: 
2550:         IF !EMPTY(loc_cRecFtp) AND !DIRECTORY(loc_cRecFtp)
2551:             THIS.Inf("A pasta local de recebimento " + loc_cRecFtp + " n" + CHR(227) + "o existe. Por favor verifique.", "R")
2552:             MsgAviso("A pasta local de recebimento informada n" + CHR(227) + "o existe:" + CHR(13) + loc_cRecFtp, ;
2553:                 "Aten" + CHR(231) + CHR(227) + "o")
2554:             loc_lOk = .F.
2555:         ENDIF
2556: 
2557:         IF loc_lOk
2558:             WITH THIS.this_oBusinessObject
2559:                 IF !EMPTY(loc_cEnvFtp)
2560:                     .this_cDirEnvFtp = ADDBS(loc_cEnvFtp)
2561:                 ENDIF
2562: 
2563:                 IF !EMPTY(loc_cRecFtp)
2564:                     .this_cDirRecFtp = ADDBS(loc_cRecFtp)
2565:                 ENDIF
2566: 
2567:                 IF !EMPTY(loc_cRecLoc)
2568:                     .this_cDirRecLoc = IIF(RIGHT(loc_cRecLoc, 1) == "/", loc_cRecLoc, loc_cRecLoc + "/")
2569:                 ENDIF
2570: 
2571:                 IF !EMPTY(loc_cEnvLoc)
2572:                     .this_cDirEnvLoc = IIF(RIGHT(loc_cEnvLoc, 1) == "/", loc_cEnvLoc, loc_cEnvLoc + "/")
2573:                 ENDIF
2574:             ENDWITH
2575: 
2576:             *-- Reescreve a tela com o valor JA normalizado, para o que o
2577:             *-- usuario ve ser exatamente o que sera usado na transferencia
2578:             THIS.BOParaForm()
2579:         ENDIF
2580: 
2581:         RETURN loc_lOk
2582:     ENDFUNC
2583: 
2584:     *==========================================================================
2585:     * CarregarLista - Ponto unico de (re)carga das listas da tela: le os
2586:     * diretorios da tela para o BO, repovoa as quatro listas via MontaContainer
2587:     * e repinta os dois grids.
2588:     *
2589:     * O GO TOP + Refresh do fim nao eh enfeite: popular cursor NAO repinta
2590:     * grade em VFP9 (o legado sempre fecha com "go bott" + "GrdInf.refresh"),
2591:     * e sem isso a grade fica visualmente vazia com o cursor cheio.
2592:     *
2593:     * PUBLIC (sem PROTECTED): o harness TesteAutomatico.prg chama
2594:     * THIS.oForm.CarregarLista() de FORA da classe - regra #3 do CLAUDE.md.
2595:     *==========================================================================
2596:     PROCEDURE CarregarLista()
2597:         LOCAL loc_lSucesso
2598: 
2599:         loc_lSucesso = .F.
2600: 
2601:         IF !THIS.FormParaBO()
2602:             RETURN .F.
2603:         ENDIF
2604: 
2605:         loc_lSucesso = THIS.MontaContainer()
2606: 
2607:         *-- Grid de progresso (cursor_4c_Progresso) e grid de log
2608:         *-- (cursor_4c_Log): reposiciona e repinta os dois
2609:         IF USED("cursor_4c_Progresso")
2610:             SELECT cursor_4c_Progresso
2611:             GO TOP
2612:             THIS.grd_4c_Progresso.Refresh()
2613:         ENDIF
2614: 
2615:         IF USED("cursor_4c_Log")
2616:             SELECT cursor_4c_Log
2617:             GO BOTTOM
2618:             THIS.grd_4c_Log.Refresh()
2619:         ENDIF
2620: 
2621:         RETURN loc_lSucesso
2622:     ENDPROC
2623: 
2624:     *==========================================================================
2625:     * HabilitarCampos - Liga/desliga em bloco os controles de acao da tela.
2626:     * Consolida o bloco de ".enabled" que o legado repete em cmdload.Click
2627:     * (IF/ELSE), em transfere e em recebe:
2628:     *
2629:     *   ThisForm.Container1.enabled = .t.     && o legado deixa .t. nos dois
2630:     *   ThisForm.cmdtran.enabled    = <flag>  && ramos - transcrito como esta
2631:     *   ThisForm.cmdrec.enabled     = <flag>
2632:     *   ThisForm.cmdsair.enabled    = <flag>
2633:     *
2634:     * par_lHabilitar = .F. durante a transferencia (trava a tela), .T. ao
2635:     * terminar. cmd_4c_Encerrar segue o flag, como cmdsair no legado.
2636:     *
2637:     * PUBLIC (sem PROTECTED): mesma razao de CarregarLista - o harness chama
2638:     * de fora da classe.
2639:     *==========================================================================
2640:     PROCEDURE HabilitarCampos(par_lHabilitar)
2641:         LOCAL loc_lHabilitar
2642: 
2643:         loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
2644: 
2645:         *-- "ThisForm.Container1.enabled = .t." do legado: fica .T. tanto ao
2646:         *-- iniciar quanto ao terminar a transferencia (transcrito, nao
2647:         *-- "corrigido" - as listas continuam navegaveis durante a operacao)
2648:         THIS.cnt_4c_Navegacao.Enabled  = .T.
2649:         THIS.cmd_4c_Transferir.Enabled = loc_lHabilitar
2650:         THIS.cmd_4c_Receber.Enabled    = loc_lHabilitar
2651:         THIS.cmd_4c_Encerrar.Enabled   = loc_lHabilitar
2652:     ENDPROC
2653: 
2654:     *==========================================================================
2655:     * BtnConectarClick - Click de cmd_4c_Conectar (cmdload do legado): valida
2656:     * o tipo de conexao (Dial-Up/Banda Larga), tenta conectar quando
2657:     * necessario e, tendo sucesso, habilita os botoes de transferencia
2658:     *==========================================================================
2659:     PROCEDURE BtnConectarClick()
2660:         LOCAL loc_lOk
2661:         loc_lOk = .T.
2662: 
2663:         THIS.cmd_4c_Conectar.Enabled = .F.
2664: 
2665:         DO CASE
2666:             CASE THIS.this_oBusinessObject.this_cTpConnect == "D"
2667:                 IF THIS.RasAtivas("aAtivas") > 0
2668:                     THIS.Inf("Este computador j" + CHR(225) + " est" + CHR(225) + " conectado " + CHR(224) + " INTERNET", "B")
2669:                     *-- "=ThisForm.MontaContainer()" seguido de "lOk = .t." no
2670:                     *-- legado: o retorno da carga eh DESCARTADO de proposito -
2671:                     *-- listagem que falha nao desabilita a transferencia
2672:                     THIS.CarregarLista()
2673:                     loc_lOk = .T.
2674:                 ELSE
2675:                     THIS.Inf("Conex" + CHR(227) + "o " + CHR(224) + " Internet N" + CHR(227) + "o detectada", "R")
2676:                     THIS.Inf("Esperando por uma Conex" + CHR(227) + "o " + CHR(224) + " Internet via Dial-UP", "B")
2677:                     THIS.cmd_4c_RedeDialup.Visible = .T.
2678:                     loc_lOk = .F.
2679:                 ENDIF
2680: 
2681:             CASE THIS.this_oBusinessObject.this_cTpConnect == "B"
2682:                 THIS.Inf("Aguarde a inicializa" + CHR(231) + CHR(227) + "o das rotinas...", "B")
2683:                 THIS.Inf("Checando diret" + CHR(243) + "rios locais e conex" + CHR(245) + "es de rede...", "B")
2684:                 *-- idem ao ramo "D": o legado faz "lOk = .t." e so depois
2685:                 *-- "=ThisForm.MontaContainer()", descartando o retorno
2686:                 loc_lOk = .T.
2687:                 THIS.CarregarLista()
2688: 
2689:             OTHERWISE
2690:                 THIS.Inf("N" + CHR(227) + "o h" + CHR(225) + " tipo definido de conex" + CHR(227) + "o... Opera" + CHR(231) + CHR(227) + "o Cancelada", "R")
2691:                 loc_lOk = .F.
2692:         ENDCASE
2693: 
2694:         IF loc_lOk
2695:             THIS.cnt_4c_Navegacao.Enabled                  = .T.
2696:             THIS.cmd_4c_Transferir.Enabled                 = .T.
2697:             THIS.cmd_4c_Receber.Enabled                    = .T.
2698:             THIS.cmd_4c_Encerrar.Enabled                   = .T.
2699:             THIS.cmd_4c_Conectar.Enabled                   = .F.

*-- Linhas 2715 a 2832:
2715:     * selecionado no combo (CboProvedor, adicionado junto com os demais
2716:     * controles de dados do PageFrame)
2717:     *==========================================================================
2718:     PROCEDURE BtnRedeDialupClick()
2719:         LOCAL loc_cProvedor, loc_cComando
2720: 
2721:         DO CASE
2722:             CASE THIS.this_oBusinessObject.this_cTpConnect == "D"
2723:                 IF THIS.RasAtivas("aAtivas") > 0
2724:                     THIS.Inf("Este computador j" + CHR(225) + " est" + CHR(225) + " conectado " + CHR(224) + " INTERNET", "B")
2725:                 ELSE
2726:                     THIS.Inf("Esperando por uma Conex" + CHR(227) + "o " + CHR(224) + " Internet via Dial-UP", "B")
2727:                     *-- VFP9 nao faz short-circuit em AND/OR: TYPE() e o valor
2728:                     *-- da variavel tem de ser checados em IFs separados, senao
2729:                     *-- "nProvedor > 0" estoura "Variable NPROVEDOR is not found"
2730:                     *-- antes de nProvedor existir (CboProvedor, Fase 5-6)
2731:                     IF TYPE("nProvedor") = "N"
2732:                         IF nProvedor > 0
2733:                             loc_cProvedor = aProvedor(nProvedor)
2734:                             THIS.this_cProvedorConectado = loc_cProvedor
2735:                             loc_cComando  = "RUN /N Rundll Rnaui.dll,RnaDial " + ALLTRIM(loc_cProvedor)
2736:                             &loc_cComando.
2737:                         ELSE
2738:                             THIS.Inf("Nome de Provedor inv" + CHR(225) + "lido.. Selecione um provedor", "R")
2739:                             MsgAviso("Selecione o provedor.", "Aten" + CHR(231) + CHR(227) + "o")
2740:                         ENDIF
2741:                     ELSE
2742:                         THIS.Inf("Nome de Provedor inv" + CHR(225) + "lido.. Selecione um provedor", "R")
2743:                         MsgAviso("Selecione o provedor.", "Aten" + CHR(231) + CHR(227) + "o")
2744:                     ENDIF
2745:                 ENDIF
2746: 
2747:             OTHERWISE
2748:                 THIS.Inf("N" + CHR(227) + "o h" + CHR(225) + " tipo definido de conex" + CHR(227) + "o... Opera" + CHR(231) + CHR(227) + "o Cancelada", "R")
2749:         ENDCASE
2750:     ENDPROC
2751: 
2752:     *==========================================================================
2753:     * BtnExecutarTransferenciaClick / BtnEnviaFtpClick - Click de cmd_4c_Transferir
2754:     * (cmdtran, transfere todos) e cmd_4c_EnviaFtp (cmdtransfere, transfere
2755:     * so os selecionados)
2756:     *==========================================================================
2757:     PROCEDURE BtnExecutarTransferenciaClick()
2758:         THIS.Transferir("A")
2759:     ENDPROC
2760: 
2761:     PROCEDURE BtnEnviaFtpClick()
2762:         THIS.Transferir("I")
2763:     ENDPROC
2764: 
2765:     *==========================================================================
2766:     * BtnExecutarRecebimentoClick / BtnRecebeFtpClick - Click de cmd_4c_Receber (cmdrec,
2767:     * recebe todos) e cmd_4c_RecebeFtp (cmdrecebe, recebe so os selecionados)
2768:     *==========================================================================
2769:     PROCEDURE BtnExecutarRecebimentoClick()
2770:         THIS.Receber("A")
2771:     ENDPROC
2772: 
2773:     PROCEDURE BtnRecebeFtpClick()
2774:         THIS.Receber("I")
2775:     ENDPROC
2776: 
2777:     *==========================================================================
2778:     * BtnEncerrarClick - Click de cmd_4c_Encerrar (cmdsair do legado:
2779:     * "ThisForm.release")
2780:     *==========================================================================
2781:     PROCEDURE BtnEncerrarClick()
2782:         THIS.Release()
2783:     ENDPROC
2784: 
2785:     *==========================================================================
2786:     * Destroy - Libera o Business Object; a restauracao do menu principal
2787:     * ja e feita por FormBase.Destroy via DODEFAULT()
2788:     *==========================================================================
2789:     PROCEDURE Destroy()
2790:         LOCAL loc_nAtivas, loc_cComando
2791: 
2792:         *-- "if ThisForm._TpConnect = 'D' ... " do PROCEDURE Release legado:
2793:         *-- se a conexao Dial-Up discada por BtnRedeDialupClick ainda estiver
2794:         *-- ativa ao fechar o form, avisa o usuario e desconecta (a mesma
2795:         *-- chamada RnaDial de novo funciona como toggle e derruba a conexao)
2796:         IF VARTYPE(THIS.this_oBusinessObject) = "O" AND THIS.this_oBusinessObject.this_cTpConnect == "D"
2797:             PUBLIC ARRAY aAtivas(1)
2798:             loc_nAtivas = THIS.RasAtivas("aAtivas")
2799: 
2800:             IF loc_nAtivas > 0
2801:                 MsgInfo("A conex" + CHR(227) + "o " + CHR(224) + " internet ainda est" + CHR(225) + " ativa...", "Aten" + CHR(231) + CHR(227) + "o")
2802: 
2803:                 IF !EMPTY(THIS.this_cProvedorConectado)
2804:                     loc_cComando = "RUN /N Rundll Rnaui.dll,RnaDial " + ALLTRIM(THIS.this_cProvedorConectado)
2805:                     &loc_cComando.
2806:                 ENDIF
2807:             ENDIF
2808: 
2809:             RELEASE aAtivas
2810:         ENDIF
2811: 
2812:         *-- Fecha os cursores locais do form (equivalente ao "sele logftp /
2813:         *-- use" e "sele tmpprog / use" do Destroy legado)
2814:         IF USED("cursor_4c_Progresso")
2815:             USE IN cursor_4c_Progresso
2816:         ENDIF
2817: 
2818:         IF USED("cursor_4c_Log")
2819:             USE IN cursor_4c_Log
2820:         ENDIF
2821: 
2822:         IF USED("cursor_4c_FtpServer")
2823:             USE IN cursor_4c_FtpServer
2824:         ENDIF
2825: 
2826:         *-- "Release aAtivas, cProvedor, aProvedor" do Destroy legado - os
2827:         *-- arrays/memvars PUBLIC do combo de provedores Dial-Up (criados em
2828:         *-- ConfigurarProvedorDialUp) nao devem sobreviver ao fechamento do form
2829:         IF TYPE("aProvedor") <> "U"
2830:             RELEASE aProvedor
2831:         ENDIF
2832:         IF TYPE("nProvedor") <> "U"


### BO (C:\4c\projeto\app\classes\sigprftpBO.prg):
*============================================================================
* sigprftpBO.prg - Business Object para Transferencia e Recebimento de
*                   arquivos via FTP (form OPERACIONAL, sem CRUD proprio)
*
* Tabela de parametros globais : SigCdPam (PK: cidchaves char(20))
*   Colunas usadas: tptrans, empmasters, grumccrs, conmccrs, vendnts
* Tabela de configuracao/empresa: SigCdEmp (PK: cemps char(3))
*   Colunas usadas: cemps, tpconexao, ftpend, ftpusuario, ftpsenha,
*                    drivets, drivels, dirftpts, dirftpls, locdel, ftpdel
*
* Este BO e SOMENTE-LEITURA em relacao a SigCdPam/SigCdEmp: o form legado
* apenas consulta essas tabelas para resolver a configuracao de FTP da
* empresa (ou da empresa "master", quando SigCdPam.empmasters esta
* preenchido) - o comportamento padrao herdado de BusinessBase (recusar
* Inserir/Atualizar/ExecutarExclusao) ja e o correto para esta entidade.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS sigprftpBO AS BusinessBase

    *==========================================================================
    * Parametros recebidos pelo Init do form legado (equivalentes as
    * propriedades ThisForm._TpEnv / ._TpRec / ._TpConnect / etc do SIGPRFTP)
    * Representam a configuracao RESOLVIDA que efetivamente comanda a
    * transferencia (combinacao dos parametros de chamada + fallback do
    * cadastro de empresa quando a chamada nao informa os dados).
    *==========================================================================
    this_cTpEnv         = "*.*"  && Mascara de arquivos para Envio (Local -> FTP)
    this_cTpRec         = "*.*"  && Mascara de arquivos para Recebimento (FTP -> Local)
    this_cTpConnect     = ""     && Tipo de conexao: "D"=Dial-Up, "B"=Banda Larga/Direta
    this_cFtpAdd        = ""     && Endereco do servidor FTP
    this_cFtpUser       = ""     && Usuario de acesso ao FTP
    this_cFtpPass       = ""     && Senha de acesso ao FTP (ja descriptografada)
    this_cDirEnvFtp     = ""     && Pasta LOCAL de onde os arquivos sao enviados ao FTP
    this_cDirRecFtp     = ""     && Pasta LOCAL onde os arquivos recebidos do FTP sao gravados
    this_cDirEnvLoc     = ""     && Pasta REMOTA (no FTP) onde os arquivos enviados sao gravados
    this_cDirRecLoc     = ""     && Pasta REMOTA (no FTP) de onde os arquivos sao recebidos
    this_lDelLocal      = .F.    && Exclui o arquivo local apos o envio ao FTP
    this_lDelHost       = .F.    && Exclui o arquivo do FTP apos o recebimento
    this_nTpConect      = 0      && 0=Nenhuma acao automatica, 1=Transfere automatico, 2=Recebe automatico
    this_lCaseSensitive = .F.    && Preserva caixa da senha de FTP (nao converte para minusculo)

    *==========================================================================
    * Propriedades de SigCdPam (parametros gerais do sistema) - carregadas
    * uma unica vez em BuscarParametros() nas proximas fases
    *==========================================================================
    this_cTpTrans    = ""    && char(6)  - Tipo de transferencia padrao do sistema
    this_cEmpMasters = ""    && char(3)  - Empresa "master" cuja config de FTP e usada
    this_cGruMccrs   = ""    && char(10) - Grupo padrao (uso do modulo de FTP/movimento)
    this_cConMccrs   = ""    && char(10) - Conta padrao (uso do modulo de FTP/movimento)
    this_cVendNts    = ""    && char(10) - Vendedor padrao (uso do modulo de FTP/movimento)

    *==========================================================================
    * Propriedades de SigCdEmp (configuracao de FTP da empresa consultada)
    *==========================================================================
    this_cCemps      = ""    && char(3)  - Codigo da empresa cuja config foi carregada
    this_cTpConexao  = ""    && char(1)  - Tipo de conexao cadastrado na empresa
    this_cFtpEnd     = ""    && char(50) - Endereco do servidor FTP cadastrado na empresa
    this_cFtpUsuario = ""    && char(20) - Usuario de FTP cadastrado na empresa
    this_cFtpSenha   = ""    && char(20) - Senha de FTP cadastrada na empresa (criptografada)
    this_cDrivets    = ""    && char(60) - Pasta local de envio cadastrada na empresa
    this_cDrivels    = ""    && char(60) - Pasta local de recebimento cadastrada na empresa
    this_cDirftpts   = ""    && char(60) - Pasta remota de recebimento cadastrada na empresa
    this_cDirftpls   = ""    && char(60) - Pasta remota de envio cadastrada na empresa
    this_lLocDel     = .F.   && bit      - Exclui arquivo local apos envio (config da empresa)
    this_lFtpDel     = .F.   && bit      - Exclui arquivo do FTP apos recebimento (config da empresa)

    *==========================================================================
    * Propriedades de controle/mensagens especificas deste BO
    *==========================================================================
    this_lConfigValida = .F.  && .T. quando a configuracao resolvida esta apta a transferir

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdEmp"
            THIS.this_cCampoChave = "cemps"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Chave primaria para auditoria/identificacao do
    * registro de configuracao de empresa (SigCdEmp) atualmente carregado
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCemps
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia as colunas de SigCdEmp (config de FTP da
    * empresa) do cursor para as propriedades this_c*/this_l* do BO.
    * Equivalente ao bloco do Init legado que le "crftpemp" apos o
    * CursorQuery('SigCdEmp', 'crftpemp', 'Cemps', lcBusEmp).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        THIS.this_cCemps      = ALLTRIM(TratarNulo(cemps, ""))
        THIS.this_cTpConexao  = TratarNulo(tpconexao, "")
        THIS.this_cFtpEnd     = TratarNulo(ftpend, "")
        THIS.this_cFtpUsuario = TratarNulo(ftpusuario, "")
        THIS.this_cFtpSenha   = TratarNulo(ftpsenha, "")
        THIS.this_cDrivets    = TratarNulo(drivets, "")
        THIS.this_cDrivels    = TratarNulo(drivels, "")
        THIS.this_cDirftpts   = TratarNulo(dirftpts, "")
        THIS.this_cDirftpls   = TratarNulo(dirftpls, "")

        * Coluna bit chega ao VFP ora como Logico ora como Numerico
        * conforme o driver - testar VARTYPE antes de comparar (regra #13)
        IF VARTYPE(locdel) = "L"
            THIS.this_lLocDel = locdel
        ELSE
            THIS.this_lLocDel = (NVL(locdel, 0) = 1)
        ENDIF

        IF VARTYPE(ftpdel) = "L"
            THIS.this_lFtpDel = ftpdel
        ELSE
            THIS.this_lFtpDel = (NVL(ftpdel, 0) = 1)
        ENDIF

        loc_lResultado = .T.
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BuscarParametrosSistema - Carrega a (unica) linha de parametros gerais
    * do sistema em SigCdPam, equivalente a:
    *   ThisForm.poDataMgr.CursorQuery('SigCdPam', 'crftpParam', .f., .f.,
    *     'TpTrans, EmpMasters, GruMccrs, ConMccrs, VendNts')
    *==========================================================================
    FUNCTION BuscarParametrosSistema()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_FtpParam")
                USE IN cursor_4c_FtpParam
            ENDIF

            loc_cSQL = "SELECT TOP 1 TpTrans, EmpMasters, GruMccrs, ConMccrs, VendNts " + ;
                       "FROM SigCdPam"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FtpParam")

            IF loc_nResultado >= 0
                IF USED("cursor_4c_FtpParam") AND RECCOUNT("cursor_4c_FtpParam") > 0
                    SELECT cursor_4c_FtpParam
                    GO TOP
                    THIS.this_cTpTrans    = TratarNulo(TpTrans, "")
                    THIS.this_cEmpMasters = ALLTRIM(TratarNulo(EmpMasters, ""))
                    THIS.this_cGruMccrs   = TratarNulo(GruMccrs, "")
                    THIS.this_cConMccrs   = TratarNulo(ConMccrs, "")
                    THIS.this_cVendNts    = TratarNulo(VendNts, "")
                ENDIF
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar par" + CHR(226) + "metros do sistema (SigCdPam)"
                loc_lResultado = .F.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        IF USED("cursor_4c_FtpParam")
            USE IN cursor_4c_FtpParam
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * BuscarConfiguracaoEmpresa - Carrega a configuracao de FTP cadastrada
    * para a empresa informada (SigCdEmp), equivalente a:
    *   ThisForm.PodataMgr.Cursorquery('SigCdEmp','crftpemp','Cemps',lcBusEmp)
    *==========================================================================
    FUNCTION BuscarConfiguracaoEmpresa(par_cCemps)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado

        loc_lResultado = .F.

        IF EMPTY(par_cCemps)
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo de empresa n" + CHR(227) + "o informado"
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_FtpEmp")
                USE IN cursor_4c_FtpEmp
            ENDIF

            loc_cSQL = "SELECT Cemps, TpConexao, Ftpend, Ftpusuario, Ftpsenha, " + ;
                       "Drivets, Drivels, Dirftpts, Dirftpls, LocDel, FtpDel " + ;
                       "FROM SigCdEmp " + ;
                       "WHERE Cemps = " + EscaparSQL(PADR(ALLTRIM(par_cCemps), 3))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FtpEmp")

            IF loc_nResultado >= 0
                IF USED("cursor_4c_FtpEmp") AND RECCOUNT("cursor_4c_FtpEmp") > 0
                    SELECT cursor_4c_FtpEmp
                    GO TOP
                    THIS.CarregarDoCursor("cursor_4c_FtpEmp")
                    loc_lResultado = .T.
                ELSE
                    THIS.this_cMensagemErro = "Empresa n" + CHR(227) + "o cadastrada ... Opera" + CHR(231) + CHR(227) + "o Cancelada"
                    loc_lResultado = .F.
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar configura" + CHR(231) + CHR(227) + "o de FTP da empresa"
                loc_lResultado = .F.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        IF USED("cursor_4c_FtpEmp")
            USE IN cursor_4c_FtpEmp
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * ResolverConfiguracaoFtp - Orquestra a resolucao da configuracao efetiva
    * de FTP (parametros gerais + empresa "master" ou a propria empresa),
    * reproduzindo o bloco de PROCEDURE Init do form legado:
    *   lcBusEmp = Iif(!Empty(crftpparam.EmpMasters), crftpParam.EmpMasters, _Empr)
    *   ... carrega crftpemp e resolve _TpConnect/_FtpAdd/_FtpUser/_FtpPass/
    *       _DirEnvFtp/_DirRecFtp/_DirRecLoc/_DirEnvLoc/_DelLocal/_DelHost
    *
    * par_cCemps: codigo da empresa CORRENTE (equivalente a _Empr do legado -
    *             o form migrado deve passar go_4c_Sistema.cCodEmpresa)
    *==========================================================================
    FUNCTION ResolverConfiguracaoFtp(par_cCemps)
        LOCAL loc_lResultado, loc_cEmpresaBusca

        loc_lResultado = .F.
        THIS.this_lConfigValida = .F.

        IF !THIS.BuscarParametrosSistema()
            RETURN .F.
        ENDIF

        loc_cEmpresaBusca = IIF(!EMPTY(THIS.this_cEmpMasters), THIS.this_cEmpMasters, ALLTRIM(TratarNulo(par_cCemps, "")))

        IF !THIS.BuscarConfiguracaoEmpresa(loc_cEmpresaBusca)
            RETURN .F.
        ENDIF

        * Resolucao dos campos efetivos de conexao (equivalente ao trecho
        * "With ThisForm ... EndWith" do Init legado que copia crftpemp.*
        * para as propriedades _Tp*/_Ftp*/_Dir*/_Del* do form)
        THIS.this_cTpConnect = UPPER(ALLTRIM(THIS.this_cTpConexao))
        THIS.this_cFtpAdd    = LOWER(ALLTRIM(THIS.this_cFtpEnd))
        THIS.this_cFtpUser   = LOWER(ALLTRIM(THIS.this_cFtpUsuario))

        * fCriptografar: mesma funcao global do legado ja referenciada sem
        * wrapper proprio em SigPrScnBO.prg/sigtosenBO.prg (decodifica a
        * senha gravada no cadastro de empresa para uso efetivo no FTP)
        IF THIS.this_lCaseSensitive
            THIS.this_cFtpPass = ALLTRIM(fCriptografar(THIS.this_cFtpSenha))
        ELSE
            THIS.this_cFtpPass = LOWER(ALLTRIM(fCriptografar(THIS.this_cFtpSenha)))
        ENDIF

        THIS.this_cDirEnvFtp = ADDBS(LOWER(ALLTRIM(THIS.this_cDrivets)))
        THIS.this_cDirRecFtp = ADDBS(LOWER(ALLTRIM(THIS.this_cDrivels)))
        THIS.this_cDirRecLoc = THIS.NormalizarDiretorioRemoto(LOWER(ALLTRIM(THIS.this_cDirftpts)))
        THIS.this_cDirEnvLoc = THIS.NormalizarDiretorioRemoto(LOWER(ALLTRIM(THIS.this_cDirftpls)))
        THIS.this_lDelLocal  = THIS.this_lLocDel
        THIS.this_lDelHost   = THIS.this_lFtpDel

        * Mesma validacao do "Do Case" do Init legado (TpConnect invalido /
        * FtpAdd, FtpUser ou FtpPass vazios cancelam a operacao)
        loc_lResultado = INLIST(THIS.this_cTpConnect, "D", "B") AND ;
                          !EMPTY(THIS.this_cFtpAdd) AND ;
                          !EMPTY(THIS.this_cFtpUser) AND ;
                          !EMPTY(THIS.this_cFtpPass)

        IF !loc_lResultado
            THIS.this_cMensagemErro = "Esta empresa n" + CHR(227) + "o possui uma configura" + CHR(231) + CHR(227) + "o correta de acesso " + CHR(224) + " FTP"
        ENDIF

        THIS.this_lConfigValida = loc_lResultado

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * NormalizarDiretorioRemoto - Garante barra "/" no final do caminho
    * remoto do FTP, equivalente a:
    *   iif(right(cDir,1)=="/" or empt(cDir), cDir, cDir + "/")
    *==========================================================================
    PROTECTED FUNCTION NormalizarDiretorioRemoto(par_cDiretorio)
        IF EMPTY(par_cDiretorio) OR RIGHT(par_cDiretorio, 1) == "/"
            RETURN par_cDiretorio
        ENDIF

        RETURN par_cDiretorio + "/"
    ENDFUNC

ENDDEFINE

