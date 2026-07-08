# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [METODO-INEXISTENTE] Metodo 'THIS.Height()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreifx.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (835 linhas total):

*-- Linhas 53 a 279:
53:     *--------------------------------------------------------------------------
54:     * Init - Recebe par" + CHR(226) + "metros do c" + CHR(243) + "digo chamador
55:     * Salva par" + CHR(226) + "metros como propriedades ANTES de DODEFAULT() para que
56:     * InicializarForm() possa us" + CHR(225) + "-los ao ser chamada por FormBase.Init().
57:     *--------------------------------------------------------------------------
58:     PROCEDURE Init(par_cEmp, par_cDop, par_nNum, par_nImp, par_lChkImpDoc)
59:         LOCAL loc_lSucesso
60:         loc_lSucesso = .F.
61:         TRY
62:             THIS.this_cEmps        = PADR(IIF(VARTYPE(par_cEmp) = "C", par_cEmp, ""), 3)
63:             THIS.this_cDopes       = PADR(IIF(VARTYPE(par_cDop) = "C", par_cDop, ""), 20)
64:             THIS.this_nNumes       = IIF(VARTYPE(par_nNum) = "N", par_nNum, 0)
65:             THIS.this_nTpImpressao = IIF(VARTYPE(par_nImp) = "N", par_nImp, 0)
66:             THIS.this_lPChkImpDoc  = IIF(VARTYPE(par_lChkImpDoc) = "L", par_lChkImpDoc, .F.)
67: 
68:             loc_lSucesso = DODEFAULT()
69:         CATCH TO loc_oErro
70:             MsgErro(loc_oErro.Message, "Erro ao inicializar Formsigreifx")
71:         ENDTRY
72:         RETURN loc_lSucesso
73:     ENDPROC
74: 
75:     *--------------------------------------------------------------------------
76:     * InicializarForm - Monta UI, cria BO, configura visibilidade por Docus
77:     * Retorna .F. tanto em erro quanto no modo auto-execu" + CHR(231) + CHR(227) + "o (form n" + CHR(227) + "o aparece).
78:     * REGRA: NUNCA usar RETURN dentro de TRY/CATCH - usar flags loc_lContinuar.
79:     *--------------------------------------------------------------------------
80:     PROTECTED PROCEDURE InicializarForm()
81:         LOCAL loc_lSucesso, loc_nDocus, loc_nResultado, loc_lContinuar, loc_lAutoExec
82:         loc_lSucesso   = .F.
83:         loc_nDocus     = 0
84:         loc_lContinuar = .T.
85:         loc_lAutoExec  = .F.
86: 
87:         TRY
88:             THIS.Caption = "Impress" + CHR(227) + "o de Documento (" + ;
89:                            ALLTRIM(THIS.this_cDopes) + "/" + ;
90:                            ALLTRIM(STR(THIS.this_nNumes)) + ")"
91: 
92:             IF TYPE("gc_4c_CaminhoIcones") = "U"
93:                 gc_4c_CaminhoIcones = ""
94:             ENDIF
95:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
96: 
97:             *-- Criar BO de impress" + CHR(227) + "o de documentos
98:             THIS.this_oRelatorio = CREATEOBJECT("sigreifxBO")
99:             IF VARTYPE(THIS.this_oRelatorio) != "O"
100:                 MsgErro("Erro ao criar sigreifxBO", "Erro")
101:                 loc_lContinuar = .F.
102:             ENDIF
103: 
104:             IF loc_lContinuar
105:                 *-- Transferir par" + CHR(226) + "metros para o BO antes de qualquer opera" + CHR(231) + CHR(227) + "o
106:                 THIS.this_oRelatorio.this_cEmps        = THIS.this_cEmps
107:                 THIS.this_oRelatorio.this_cDopes       = THIS.this_cDopes
108:                 THIS.this_oRelatorio.this_nNumes       = THIS.this_nNumes
109:                 THIS.this_oRelatorio.this_nTpImpressao = THIS.this_nTpImpressao
110:                 THIS.this_oRelatorio.this_lPChkImpDoc  = THIS.this_lPChkImpDoc
111: 
112:                 *-- Consulta leve em SigCdOpe para obter Docus (tipo do documento)
113:                 *   Necess" + CHR(225) + "rio para visibilidade dos checkboxes ANTES de PrepararDados()
114:                 IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
115:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
116:                         "SELECT Docus FROM SigCdOpe WHERE Dopes = " + EscaparSQL(THIS.this_cDopes), ;
117:                         "cursor_4c_TmpDocType")
118:                     IF loc_nResultado > 0 AND USED("cursor_4c_TmpDocType")
119:                         GO TOP IN cursor_4c_TmpDocType
120:                         IF !EOF("cursor_4c_TmpDocType")
121:                             loc_nDocus = cursor_4c_TmpDocType.Docus
122:                         ENDIF
123:                         USE IN cursor_4c_TmpDocType
124:                     ENDIF
125:                 ENDIF
126: 
127:                 *-- Montar cabecalho escuro superior (equivalente ao cntSombra do legado)
128:                 THIS.ConfigurarCabecalho()
129: 
130:                 *-- Montar botoes de acao (equivalente ao btnReport do legado)
131:                 THIS.ConfigurarBotoes()
132: 
133:                 *-- PageFrame com 1 pagina ("Filtros") - agrupa os checkboxes de opcoes
134:                 THIS.ConfigurarPageFrame()
135: 
136:                 *-- Montar campos de filtro: 1a metade (ConfigurarPaginaDados) + 2a metade (ConfigurarCheckBoxes)
137:                 THIS.ConfigurarPaginaDados(loc_nDocus)
138:                 THIS.ConfigurarCheckBoxes(loc_nDocus)
139: 
140:                 *-- Verificar historico de impressao e ajustar habilitacao dos botoes
141:                 IF THIS.this_lPChkImpDoc
142:                     THIS.VerificarHistoricoImpressao()
143:                 ENDIF
144: 
145:                 *-- Vincular eventos dos botoes (BINDEVENT exige metodos PUBLIC)
146:                 THIS.VincularEventos()
147: 
148:                 *-- Atualizar titulo no cabecalho
149:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
150:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
151: 
152:                 *-- Modo auto-impressao (TpImpressao 3 ou 4): executa e sinaliza fechamento
153:                 IF INLIST(THIS.this_nTpImpressao, 3, 4)
154:                     THIS.FormParaRelatorio()
155:                     THIS.this_oRelatorio.Imprimir()
156:                     loc_lAutoExec  = .T.
157:                     loc_lContinuar = .F.
158:                 ENDIF
159: 
160:                 *-- Modo auto-visualizacao (TpImpressao = 5): executa e sinaliza fechamento
161:                 IF loc_lContinuar AND THIS.this_nTpImpressao = 5
162:                     THIS.FormParaRelatorio()
163:                     THIS.this_oRelatorio.Visualizar()
164:                     loc_lAutoExec  = .T.
165:                     loc_lContinuar = .F.
166:                 ENDIF
167: 
168:                 IF loc_lContinuar
169:                     THIS.Visible = .T.
170:                     loc_lSucesso = .T.
171:                 ENDIF
172:             ENDIF
173:         CATCH TO loc_oErro
174:             THIS.this_cMensagemErro = loc_oErro.Message
175:             MsgErro(loc_oErro.Message + CHR(13) + ;
176:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
177:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
178:         ENDTRY
179: 
180:         *-- Modo auto-execucao retorna .F. para que o form nao seja exibido
181:         IF loc_lAutoExec
182:             RETURN .F.
183:         ENDIF
184:         RETURN loc_lSucesso
185:     ENDPROC
186: 
187:     *--------------------------------------------------------------------------
188:     * ConfigurarCabecalho - Container escuro superior com titulo do documento
189:     *   Equivalente ao cntSombra do legado (Top=-1, Width=848, Height=80).
190:     *--------------------------------------------------------------------------
191:     PROTECTED PROCEDURE ConfigurarCabecalho()
192:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
193:         WITH THIS.cnt_4c_Cabecalho
194:             .Top         = 0
195:             .Left        = 0
196:             .Width       = THIS.Width
197:             .Height      = 80
198:             .BackStyle   = 1
199:             .BackColor   = RGB(100, 100, 100)
200:             .BorderWidth = 0
201:             .Visible     = .T.
202: 
203:             .AddObject("lbl_4c_Sombra", "Label")
204:             WITH .lbl_4c_Sombra
205:                 .Top       = 22
206:                 .Left      = 22
207:                 .AutoSize  = .T.
208:                 .Caption   = ""
209:                 .FontName  = "Arial"
210:                 .FontSize  = 12
211:                 .FontBold  = .T.
212:                 .ForeColor = RGB(60, 60, 60)
213:                 .BackStyle = 0
214:                 .Visible   = .T.
215:             ENDWITH
216: 
217:             .AddObject("lbl_4c_Titulo", "Label")
218:             WITH .lbl_4c_Titulo
219:                 .Top       = 20
220:                 .Left      = 20
221:                 .AutoSize  = .T.
222:                 .Caption   = ""
223:                 .FontName  = "Arial"
224:                 .FontSize  = 12
225:                 .FontBold  = .T.
226:                 .ForeColor = RGB(255, 255, 255)
227:                 .BackStyle = 0
228:                 .Visible   = .T.
229:             ENDWITH
230:         ENDWITH
231:     ENDPROC
232: 
233:     *--------------------------------------------------------------------------
234:     * ConfigurarBotoes - CommandGroup de botoes do relatorio (btnReport legado)
235:     *   Padrao canonico frmrelatorio: cmg_4c_Botoes CommandGroup, ButtonCount=4.
236:     *   Left=578 EXATO do original (btnReport.Left=578, Width=845).
237:     *   Buttons: Visualizar(1), Imprimir(2), Excel(3), Sair(4).
238:     *--------------------------------------------------------------------------
239:     PROTECTED PROCEDURE ConfigurarBotoes()
240:         LOCAL loc_cIcones
241:         loc_cIcones = IIF(TYPE("gc_4c_CaminhoIcones") = "C", gc_4c_CaminhoIcones, "")
242: 
243:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
244:         WITH THIS.cmg_4c_Botoes
245:             .Top           = 0
246:             .Left          = 578   && EXATO do original: btnReport.Left = 578
247:             .Width         = 267   && 845 - 578 = 267
248:             .Height        = 80
249:             .ButtonCount   = 4
250:             .BackStyle     = 0
251:             .BorderStyle   = 0
252:             .BorderColor   = RGB(136, 189, 188)
253:             .SpecialEffect = 1
254:             .Themes        = .F.
255:             .Visible       = .T.
256: 
257:             WITH .Buttons(1)
258:                 .Top             = 5
259:                 .Left            = 5
260:                 .Width           = 65
261:                 .Height          = 70
262:                 .Caption         = "Visualizar"
263:                 .FontBold        = .T.
264:                 .FontItalic      = .T.
265:                 .BackColor       = RGB(255, 255, 255)
266:                 .ForeColor       = RGB(90, 90, 90)
267:                 .PicturePosition = 13
268:                 .SpecialEffect   = 0
269:                 .MousePointer    = 15
270:                 .ToolTipText     = "Gerar o Documento no V" + CHR(237) + "deo"
271:                 .Themes          = .F.
272:                 .Visible         = .T.
273:                 IF !EMPTY(loc_cIcones)
274:                     .Picture = loc_cIcones + "relatorio_video_26.jpg"
275:                 ENDIF
276:             ENDWITH
277: 
278:             WITH .Buttons(2)
279:                 .Top             = 5

*-- Linhas 363 a 588:
363:     *   ZOrder(1) envia o PageFrame ao fundo: cnt_4c_Cabecalho e
364:     *   cmg_4c_Botoes (adicionados antes) ficam visualmente sobre ele.
365:     *--------------------------------------------------------------------------
366:     PROTECTED PROCEDURE ConfigurarPageFrame()
367:         LOCAL loc_oPgf
368: 
369:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
370:         loc_oPgf = THIS.pgf_4c_Paginas
371: 
372:         *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
373:         loc_oPgf.PageCount = 1
374: 
375:         *-- PageFrame cobre o form inteiro; cabecalho/botoes ficam sobre ele (z-order)
376:         loc_oPgf.Top    = 0
377:         loc_oPgf.Left   = 0
378:         loc_oPgf.Width  = THIS.Width
379:         loc_oPgf.Height = THIS.Height
380:         loc_oPgf.Tabs   = .F.
381: 
382:         loc_oPgf.Visible = .T.
383: 
384:         *-- Enviar ao fundo: cnt_4c_Cabecalho e cmg_4c_Botoes ficam por cima
385:         loc_oPgf.ZOrder(1)
386: 
387:         *-- Configurar Page1 (estilo, fontes, cores) via metodo dedicado
388:         THIS.ConfigurarPaginaLista()
389: 
390:         *-- Ativar Page1 (unica pagina logica deste form REPORT)
391:         THIS.AlternarPagina(1)
392:     ENDPROC
393: 
394:     *--------------------------------------------------------------------------
395:     * ConfigurarPaginaLista - Configura Page1 do pgf_4c_Paginas
396:     *   Em forms CRUD, este metodo configura a pagina de listagem (grid).
397:     *   Neste form REPORT (frmrelatorio), Page1 hospeda os checkboxes de
398:     *   filtros de impressao (chk_4c_ChkObs, chk_4c_ChkImagem); portanto,
399:     *   este metodo aplica apenas o estilo visual da pagina - os controles
400:     *   sao adicionados separadamente por ConfigurarCheckBoxes() pois sua
401:     *   visibilidade depende do tipo do documento (Docus) consultado em
402:     *   InicializarForm().
403:     *
404:     *   PILAR 1 (UX): Page1.BackColor e ForeColor seguem o padrao do
405:     *   framework frmrelatorio (fundo branco, texto cinza 90,90,90).
406:     *--------------------------------------------------------------------------
407:     PROTECTED PROCEDURE ConfigurarPaginaLista()
408:         LOCAL loc_oPagina
409: 
410:         IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
411:             RETURN
412:         ENDIF
413:         IF THIS.pgf_4c_Paginas.PageCount < 1
414:             RETURN
415:         ENDIF
416: 
417:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
418: 
419:         *-- Estilo visual da Page1 (Filtros)
420:         loc_oPagina.Caption   = "Filtros"
421:         loc_oPagina.FontName  = "Tahoma"
422:         loc_oPagina.FontSize  = 8
423:         loc_oPagina.BackColor = RGB(255, 255, 255)
424:         loc_oPagina.ForeColor = RGB(90, 90, 90)
425:     ENDPROC
426: 
427:     *--------------------------------------------------------------------------
428:     * AlternarPagina - Ativa a pagina indicada do pgf_4c_Paginas
429:     *   par_nPagina: numero da pagina (1 .. PageCount)
430:     *
431:     *   Em forms CRUD, este metodo alterna entre Page1 (Lista) e Page2 (Dados).
432:     *   Neste form REPORT, ha apenas Page1 (Filtros), mas o metodo realiza
433:     *   validacao de limites (1 .. PageCount), define ActivePage e garante
434:     *   que a pagina ativa esteja visivel - logica reutilizavel caso novas
435:     *   paginas de filtros sejam adicionadas no futuro (ex: filtros avancados).
436:     *
437:     *   Retorno: .T. se a pagina foi ativada com sucesso, .F. caso contrario.
438:     *--------------------------------------------------------------------------
439:     PROCEDURE AlternarPagina(par_nPagina)
440:         LOCAL loc_lOk, loc_nPagina, loc_oPgf
441:         loc_lOk     = .F.
442:         loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)
443: 
444:         TRY
445:             loc_oPgf = THIS.pgf_4c_Paginas
446:             IF VARTYPE(loc_oPgf) = "O"
447:                 *-- Limitar entre 1 e PageCount
448:                 IF loc_nPagina < 1
449:                     loc_nPagina = 1
450:                 ENDIF
451:                 IF loc_nPagina > loc_oPgf.PageCount
452:                     loc_nPagina = loc_oPgf.PageCount
453:                 ENDIF
454: 
455:                 *-- Garantir que o PageFrame esteja visivel antes de ativar
456:                 loc_oPgf.Visible    = .T.
457:                 loc_oPgf.ActivePage = loc_nPagina
458: 
459:                 loc_lOk = .T.
460:             ENDIF
461:         CATCH TO loc_oErro
462:             THIS.this_cMensagemErro = loc_oErro.Message
463:         ENDTRY
464: 
465:         RETURN loc_lOk
466:     ENDPROC
467: 
468:     *--------------------------------------------------------------------------
469:     * ConfigurarPaginaDados - Campos de filtro da pagina de opcoes (1a metade)
470:     *   Para forms REPORT, "PaginaDados" corresponde a pagina de filtros de
471:     *   impressao (Page1 unica, sem Page2 CRUD). Adiciona o primeiro campo
472:     *   de opcao de impressao.
473:     *
474:     *   Campos adicionados (1a metade - Phase 5):
475:     *     - chk_4c_ChkObs: Imprimir Obs Moedas/Cotacoes (visivel Docus 3/6/11)
476:     *       Top=89, Left=36 relativo a Page1 (original Top=89, PageFrame.Top=0)
477:     *
478:     *   par_nDocus: tipo do documento obtido de SigCdOpe.Docus
479:     *   REGRA: CheckBox.Value SEMPRE NUMERICO (1=marcado, 0=desmarcado)
480:     *--------------------------------------------------------------------------
481:     PROTECTED PROCEDURE ConfigurarPaginaDados(par_nDocus)
482:         LOCAL loc_oPagina
483:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
484: 
485:         *-- chkObs: Imprimir Observacao de Moedas/Cotacoes
486:         loc_oPagina.AddObject("chk_4c_ChkObs", "CheckBox")
487:         WITH loc_oPagina.chk_4c_ChkObs
488:             .Top           = 89
489:             .Left          = 36
490:             .AutoSize      = .T.
491:             .Alignment     = 0
492:             .Caption       = "Imprimir Observa" + CHR(231) + CHR(227) + "o de Moedas/Cota" + CHR(231) + CHR(245) + "es"
493:             .SpecialEffect = 1
494:             .FontName      = "Arial"
495:             .FontSize      = 9
496:             IF INLIST(par_nDocus, 3, 6, 11)
497:                 *-- Visivel: Docus Fixo Horizontal (3/11) e Fixo Vertical (6)
498:                 .Value   = 1
499:                 .Visible = .T.
500:             ELSE
501:                 *-- Oculto: valor = 1 apenas se Docus=6 (Fixo Vertical sem checkbox visivel)
502:                 .Value   = IIF(par_nDocus = 6, 1, 0)
503:                 .Visible = .F.
504:             ENDIF
505:         ENDWITH
506:     ENDPROC
507: 
508:     *--------------------------------------------------------------------------
509:     * ConfigurarCheckBoxes - Campos de filtro da pagina de opcoes (2a metade)
510:     *   Complementa ConfigurarPaginaDados() adicionando o segundo campo de
511:     *   opcao de impressao (chk_4c_ChkImagem).
512:     *
513:     *   Campos adicionados (2a metade - Phase 6):
514:     *     - chk_4c_ChkImagem: Imprimir Imagem do produto (visivel Docus 6/10)
515:     *       Top=105, Left=36 relativo a Page1 (original Top=105, PageFrame.Top=0)
516:     *
517:     *   par_nDocus: tipo do documento obtido de SigCdOpe.Docus
518:     *   REGRA: CheckBox.Value SEMPRE NUMERICO (1=marcado, 0=desmarcado)
519:     *--------------------------------------------------------------------------
520:     PROTECTED PROCEDURE ConfigurarCheckBoxes(par_nDocus)
521:         LOCAL loc_oPagina
522:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
523: 
524:         *-- chkImagem: Imprimir Imagem do produto
525:         loc_oPagina.AddObject("chk_4c_ChkImagem", "CheckBox")
526:         WITH loc_oPagina.chk_4c_ChkImagem
527:             .Top           = 105
528:             .Left          = 36
529:             .AutoSize      = .T.
530:             .Alignment     = 0
531:             .Caption       = "Imprimir Imagem"
532:             .Value         = 1
533:             .SpecialEffect = 1
534:             .FontName      = "Arial"
535:             .FontSize      = 9
536:             *-- Visivel apenas para Docus 6 (Fixo Vertical) e 10 (Tres Vias)
537:             .Visible       = INLIST(par_nDocus, 6, 10)
538:         ENDWITH
539:     ENDPROC
540: 
541:     *--------------------------------------------------------------------------
542:     * VerificarHistoricoImpressao - Verifica se o documento ja foi impresso
543:     *   Se SigOpCdc.chkImpDoc = 1 e SigMvCab.Impress <> 0:
544:     *     - Consulta permissao de reimpressao via fChecaAcesso
545:     *     - Desabilita botoes Imprimir e Excel se sem permissao
546:     *   REGRA: NUNCA usar RETURN dentro de TRY/CATCH - usar flags loc_lContinuar
547:     *--------------------------------------------------------------------------
548:     PROTECTED PROCEDURE VerificarHistoricoImpressao()
549:         LOCAL loc_nResultado, loc_lChkImpDoc, loc_nNDopes
550:         LOCAL loc_lcEdn, loc_lImpresso, loc_lAcesso, loc_lContinuar
551:         loc_lChkImpDoc = .F.
552:         loc_nNDopes    = 0
553:         loc_lImpresso  = .F.
554:         loc_lAcesso    = .T.
555:         loc_lContinuar = .T.
556: 
557:         TRY
558:             IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
559:                 loc_lContinuar = .F.
560:             ENDIF
561: 
562:             IF loc_lContinuar
563:                 *-- Verificar se a operacao tem controle de impressao (SigOpCdc.chkImpDoc)
564:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
565:                     "SELECT a.NDopes, b.chkImpDoc " + ;
566:                     "FROM SigCdOpe a, SigOpCdc b " + ;
567:                     "WHERE a.Dopes = " + EscaparSQL(THIS.this_cDopes) + " " + ;
568:                     "AND b.Dopes = a.Dopes", ;
569:                     "cursor_4c_TmpChkDoc")
570:                 IF loc_nResultado < 1 OR !USED("cursor_4c_TmpChkDoc")
571:                     loc_lContinuar = .F.
572:                 ENDIF
573:             ENDIF
574: 
575:             IF loc_lContinuar
576:                 GO TOP IN cursor_4c_TmpChkDoc
577:                 IF EOF("cursor_4c_TmpChkDoc")
578:                     loc_lContinuar = .F.
579:                 ELSE
580:                     loc_lChkImpDoc = (cursor_4c_TmpChkDoc.chkImpDoc <> 0)
581:                     loc_nNDopes    = cursor_4c_TmpChkDoc.NDopes
582:                 ENDIF
583:                 USE IN cursor_4c_TmpChkDoc
584:                 IF !loc_lChkImpDoc
585:                     loc_lContinuar = .F.
586:                 ENDIF
587:             ENDIF
588: 

*-- Linhas 625 a 835:
625:     ENDPROC
626: 
627:     *--------------------------------------------------------------------------
628:     * VincularEventos - BINDEVENT dos botoes de acao
629:     *   Os handlers devem ser PUBLIC para BINDEVENT funcionar corretamente.
630:     *--------------------------------------------------------------------------
631:     PROTECTED PROCEDURE VincularEventos()
632:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
633:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
634:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnDocExcelClick")
635:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")
636:     ENDPROC
637: 
638:     *--------------------------------------------------------------------------
639:     * FormParaRelatorio - Transfere estado dos checkboxes para o BO
640:     *   Chamado antes de qualquer operacao de impressao/visualizacao/exportacao.
641:     *   CheckBox.Value e NUMERICO (1=marcado, 0=desmarcado) - comparar com = 1
642:     *--------------------------------------------------------------------------
643:     PROCEDURE FormParaRelatorio()
644:         LOCAL loc_oPagina
645:         IF VARTYPE(THIS.this_oRelatorio) != "O"
646:             RETURN
647:         ENDIF
648:         TRY
649:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
650:             THIS.this_oRelatorio.this_lChkObs    = (loc_oPagina.chk_4c_ChkObs.Value    = 1)
651:             THIS.this_oRelatorio.this_lChkImagem = (loc_oPagina.chk_4c_ChkImagem.Value = 1)
652:         CATCH
653:             *-- Checkboxes nao disponiveis - manter defaults do BO
654:         ENDTRY
655:     ENDPROC
656: 
657:     *--------------------------------------------------------------------------
658:     * BtnIncluirClick - Nao aplicavel a formularios de relatorio (frmrelatorio)
659:     *   Form REPORT nao possui operacao Incluir - usar Visualizar/Imprimir/Excel.
660:     *   Mantido por padrao do pipeline de migracao (Fase 7 valida assinatura).
661:     *--------------------------------------------------------------------------
662:     PROCEDURE BtnIncluirClick()
663:         RETURN
664:     ENDPROC
665: 
666:     *--------------------------------------------------------------------------
667:     * BtnAlterarClick - Nao aplicavel a formularios de relatorio (frmrelatorio)
668:     *   Form REPORT nao possui operacao Alterar - usar Visualizar/Imprimir/Excel.
669:     *--------------------------------------------------------------------------
670:     PROCEDURE BtnAlterarClick()
671:         RETURN
672:     ENDPROC
673: 
674:     *--------------------------------------------------------------------------
675:     * BtnExcluirClick - Nao aplicavel a formularios de relatorio (frmrelatorio)
676:     *   Form REPORT nao possui operacao Excluir - usar Visualizar/Imprimir/Excel.
677:     *--------------------------------------------------------------------------
678:     PROCEDURE BtnExcluirClick()
679:         RETURN
680:     ENDPROC
681: 
682:     *--------------------------------------------------------------------------
683:     * BtnVisualizarClick - Prepara dados e exibe relatorio em tela (PREVIEW)
684:     *--------------------------------------------------------------------------
685:     PROCEDURE BtnVisualizarClick()
686:         IF VARTYPE(THIS.this_oRelatorio) != "O"
687:             MsgErro("BO n" + CHR(227) + "o inicializado", "Erro")
688:             RETURN
689:         ENDIF
690:         THIS.FormParaRelatorio()
691:         IF !THIS.this_oRelatorio.Visualizar()
692:             MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro ao Visualizar")
693:         ENDIF
694:     ENDPROC
695: 
696:     *--------------------------------------------------------------------------
697:     * BtnImprimirClick - Prepara dados e imprime o documento
698:     *--------------------------------------------------------------------------
699:     PROCEDURE BtnImprimirClick()
700:         IF VARTYPE(THIS.this_oRelatorio) != "O"
701:             MsgErro("BO n" + CHR(227) + "o inicializado", "Erro")
702:             RETURN
703:         ENDIF
704:         THIS.FormParaRelatorio()
705:         IF !THIS.this_oRelatorio.Imprimir()
706:             MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro ao Imprimir")
707:         ENDIF
708:     ENDPROC
709: 
710:     *--------------------------------------------------------------------------
711:     * BtnDocExcelClick - Exporta dados do documento para cursor crExcel
712:     *--------------------------------------------------------------------------
713:     PROCEDURE BtnDocExcelClick()
714:         IF VARTYPE(THIS.this_oRelatorio) != "O"
715:             MsgErro("BO n" + CHR(227) + "o inicializado", "Erro")
716:             RETURN
717:         ENDIF
718:         THIS.FormParaRelatorio()
719:         THIS.this_oRelatorio.DocumentoExcel()
720:     ENDPROC
721: 
722:     *--------------------------------------------------------------------------
723:     * BtnSairClick - Fecha o formulario
724:     *--------------------------------------------------------------------------
725:     PROCEDURE BtnSairClick()
726:         THIS.Release()
727:     ENDPROC
728: 
729:     *--------------------------------------------------------------------------
730:     * LimparCampos - Reinicia checkboxes de filtro para valores padrao
731:     *   Chamado por FormBase em certas transicoes de estado.
732:     *--------------------------------------------------------------------------
733:     PROTECTED PROCEDURE LimparCampos()
734:         LOCAL loc_oErro
735:         TRY
736:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O" AND THIS.pgf_4c_Paginas.PageCount >= 1
737:                 LOCAL loc_oPagina
738:                 loc_oPagina = THIS.pgf_4c_Paginas.Page1
739:                 IF VARTYPE(loc_oPagina.chk_4c_ChkObs) = "O"
740:                     loc_oPagina.chk_4c_ChkObs.Value = 1
741:                 ENDIF
742:                 IF VARTYPE(loc_oPagina.chk_4c_ChkImagem) = "O"
743:                     loc_oPagina.chk_4c_ChkImagem.Value = 1
744:                 ENDIF
745:             ENDIF
746:         CATCH TO loc_oErro
747:             THIS.this_cMensagemErro = loc_oErro.Message
748:         ENDTRY
749:     ENDPROC
750: 
751:     *--------------------------------------------------------------------------
752:     * HabilitarCampos - Nao aplicavel a formularios de relatorio (frmrelatorio)
753:     *   Forms REPORT nao possuem campos editaveis no sentido CRUD.
754:     *--------------------------------------------------------------------------
755:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
756:         RETURN
757:     ENDPROC
758: 
759:     *--------------------------------------------------------------------------
760:     * FormParaBO - Alias para FormParaRelatorio() (compatibilidade com FormBase)
761:     *--------------------------------------------------------------------------
762:     PROTECTED PROCEDURE FormParaBO()
763:         THIS.FormParaRelatorio()
764:     ENDPROC
765: 
766:     *--------------------------------------------------------------------------
767:     * BOParaForm - Nao aplicavel a formularios de relatorio (frmrelatorio)
768:     *--------------------------------------------------------------------------
769:     PROTECTED PROCEDURE BOParaForm()
770:         RETURN
771:     ENDPROC
772: 
773:     *--------------------------------------------------------------------------
774:     * CarregarLista - Nao aplicavel a formularios de relatorio (frmrelatorio)
775:     *   Forms REPORT nao possuem grid de lista.
776:     *--------------------------------------------------------------------------
777:     PROCEDURE CarregarLista()
778:         RETURN
779:     ENDPROC
780: 
781:     *--------------------------------------------------------------------------
782:     * AjustarBotoesPorModo - Habilita/desabilita botoes conforme permissoes
783:     *   Em forms REPORT, Imprimir e Excel sao controlados por permissao de
784:     *   reimpressao (VerificarHistoricoImpressao). Visualizar e Sair: sempre on.
785:     *--------------------------------------------------------------------------
786:     PROCEDURE AjustarBotoesPorModo()
787:         IF VARTYPE(THIS.cmg_4c_Botoes) = "O" AND VARTYPE(THIS.this_oRelatorio) = "O"
788:             THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.
789:             THIS.cmg_4c_Botoes.Buttons(2).Enabled = THIS.this_oRelatorio.this_lAcImprimir
790:             THIS.cmg_4c_Botoes.Buttons(3).Enabled = THIS.this_oRelatorio.this_lAcExcel
791:             THIS.cmg_4c_Botoes.Buttons(4).Enabled = .T.
792:         ENDIF
793:     ENDPROC
794: 
795:     *--------------------------------------------------------------------------
796:     * BtnBuscarClick - Nao aplicavel a formularios de relatorio (frmrelatorio)
797:     *--------------------------------------------------------------------------
798:     PROCEDURE BtnBuscarClick()
799:         RETURN
800:     ENDPROC
801: 
802:     *--------------------------------------------------------------------------
803:     * BtnEncerrarClick - Fecha o formulario (alias para BtnSairClick)
804:     *--------------------------------------------------------------------------
805:     PROCEDURE BtnEncerrarClick()
806:         THIS.Release()
807:     ENDPROC
808: 
809:     *--------------------------------------------------------------------------
810:     * BtnSalvarClick - Nao aplicavel a formularios de relatorio (frmrelatorio)
811:     *--------------------------------------------------------------------------
812:     PROCEDURE BtnSalvarClick()
813:         RETURN
814:     ENDPROC
815: 
816:     *--------------------------------------------------------------------------
817:     * BtnCancelarClick - Fecha o formulario sem imprimir
818:     *--------------------------------------------------------------------------
819:     PROCEDURE BtnCancelarClick()
820:         THIS.Release()
821:     ENDPROC
822: 
823:     *--------------------------------------------------------------------------
824:     * Destroy - Libera recursos ao fechar o formulario
825:     *   this_oRelatorio = .NULL. dispara Destroy() do BO (RelatorioBase/Custom)
826:     *   que limpa cursores temporarios e arquivos de imagem.
827:     *--------------------------------------------------------------------------
828:     PROCEDURE Destroy()
829:         IF VARTYPE(THIS.this_oRelatorio) = "O"
830:             THIS.this_oRelatorio = .NULL.
831:         ENDIF
832:         DODEFAULT()
833:     ENDPROC
834: 
835: ENDDEFINE

