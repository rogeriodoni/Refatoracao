# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [LAYOUT-POSITION] Controle 'chkObs' (parent: SIGREIFX): Top original=89 vs migrado 'chk_4c_ChkObs' Top=9 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'chkImagem' (parent: SIGREIFX): Top original=105 vs migrado 'chk_4c_ChkImagem' Top=25 (diff=80px, tolerancia=30px)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' encontrado - substituir por 'Tahoma'

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreifx.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (830 linhas total):

*-- Linhas 85 a 93:
85:         loc_lAutoExec  = .F.
86: 
87:         TRY
88:             THIS.Caption = "Impress" + CHR(227) + "o de Documento (" + ;
89:                            ALLTRIM(THIS.this_cDopes) + "/" + ;
90:                            ALLTRIM(STR(THIS.this_nNumes)) + ")"
91: 
92:             IF TYPE("gc_4c_CaminhoIcones") = "U"
93:                 gc_4c_CaminhoIcones = ""

*-- Linhas 110 a 118:
110:                 THIS.this_oRelatorio.this_lPChkImpDoc  = THIS.this_lPChkImpDoc
111: 
112:                 *-- Consulta leve em SigCdOpe para obter Docus (tipo do documento)
113:                 *   Necess" + CHR(225) + "rio para visibilidade dos checkboxes ANTES de PrepararDados()
114:                 IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
115:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
116:                         "SELECT Docus FROM SigCdOpe WHERE Dopes = " + EscaparSQL(THIS.this_cDopes), ;
117:                         "cursor_4c_TmpDocType")
118:                     IF loc_nResultado > 0 AND USED("cursor_4c_TmpDocType")

*-- Linhas 130 a 155:
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

*-- Linhas 191 a 227:
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

*-- Linhas 233 a 267:
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

*-- Linhas 276 a 288:
276:             ENDWITH
277: 
278:             WITH .Buttons(2)
279:                 .Top             = 5
280:                 .Left            = 71
281:                 .Width           = 65
282:                 .Height          = 70
283:                 .Caption         = "Imprimir"
284:                 .FontName        = "Tahoma"
285:                 .FontBold        = .T.
286:                 .FontItalic      = .T.
287:                 .FontSize        = 8
288:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 299 a 311:
299:             ENDWITH
300: 
301:             WITH .Buttons(3)
302:                 .Top             = 5
303:                 .Left            = 137
304:                 .Width           = 65
305:                 .Height          = 70
306:                 .Caption         = "Excel"
307:                 .FontName        = "Tahoma"
308:                 .FontBold        = .T.
309:                 .FontItalic      = .T.
310:                 .FontSize        = 8
311:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 322 a 334:
322:             ENDWITH
323: 
324:             WITH .Buttons(4)
325:                 .Top             = 5
326:                 .Left            = 203
327:                 .Width           = 65
328:                 .Height          = 70
329:                 .Caption         = "Sair"
330:                 .Cancel          = .T.
331:                 .FontName        = "Tahoma"
332:                 .FontBold        = .T.
333:                 .FontItalic      = .T.
334:                 .FontSize        = 8

*-- Linhas 348 a 356:
348:     ENDPROC
349: 
350:     *--------------------------------------------------------------------------
351:     * ConfigurarPageFrame - PageFrame com 1 pagina ("Filtros") para os checkboxes
352:     *   O form legado SIGREIFX e FLAT (sem PageFrame), mas no novo padrao
353:     *   os campos de filtro sao agrupados em um PageFrame de 1 pagina para
354:     *   consistencia com o restante do sistema (Page1 = "Filtros" hospeda
355:     *   chk_4c_ChkObs e chk_4c_ChkImagem).
356:     *

*-- Linhas 371 a 380:
371:         loc_oPgf.PageCount = 1
372: 
373:         *-- Posicionamento: logo abaixo do cabecalho/botoes (80px) ate fim do form
374:         loc_oPgf.Top    = 80
375:         loc_oPgf.Left   = 0
376:         loc_oPgf.Width  = THIS.Width
377:         loc_oPgf.Height = THIS.Height - 80
378:         loc_oPgf.Tabs   = .F.
379: 
380:         loc_oPgf.Visible = .T.

*-- Linhas 389 a 400:
389:     *--------------------------------------------------------------------------
390:     * ConfigurarPaginaLista - Configura Page1 do pgf_4c_Paginas
391:     *   Em forms CRUD, este metodo configura a pagina de listagem (grid).
392:     *   Neste form REPORT (frmrelatorio), Page1 hospeda os checkboxes de
393:     *   filtros de impressao (chk_4c_ChkObs, chk_4c_ChkImagem); portanto,
394:     *   este metodo aplica apenas o estilo visual da pagina - os controles
395:     *   sao adicionados separadamente por ConfigurarCheckBoxes() pois sua
396:     *   visibilidade depende do tipo do documento (Docus) consultado em
397:     *   InicializarForm().
398:     *
399:     *   PILAR 1 (UX): Page1.BackColor e ForeColor seguem o padrao do
400:     *   framework frmrelatorio (fundo branco, texto cinza 90,90,90).

*-- Linhas 412 a 420:
412:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
413: 
414:         *-- Estilo visual da Page1 (Filtros)
415:         loc_oPagina.Caption   = "Filtros"
416:         loc_oPagina.FontName  = "Tahoma"
417:         loc_oPagina.FontSize  = 8
418:         loc_oPagina.BackColor = RGB(255, 255, 255)
419:         loc_oPagina.ForeColor = RGB(90, 90, 90)
420:     ENDPROC

*-- Linhas 471 a 531:
471:     *       Top=9, Left=36 relativo a Page1 (original Top=89 - 80px PageFrame)
472:     *
473:     *   par_nDocus: tipo do documento obtido de SigCdOpe.Docus
474:     *   REGRA: CheckBox.Value SEMPRE NUMERICO (1=marcado, 0=desmarcado)
475:     *--------------------------------------------------------------------------
476:     PROTECTED PROCEDURE ConfigurarPaginaDados(par_nDocus)
477:         LOCAL loc_oPagina
478:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
479: 
480:         *-- chkObs: Imprimir Observacao de Moedas/Cotacoes
481:         loc_oPagina.AddObject("chk_4c_ChkObs", "CheckBox")
482:         WITH loc_oPagina.chk_4c_ChkObs
483:             .Top           = 9
484:             .Left          = 36
485:             .AutoSize      = .T.
486:             .Alignment     = 0
487:             .Caption       = "Imprimir Observa" + CHR(231) + CHR(227) + "o de Moedas/Cota" + CHR(231) + CHR(245) + "es"
488:             .SpecialEffect = 1
489:             .FontName      = "Arial"
490:             .FontSize      = 9
491:             IF INLIST(par_nDocus, 3, 6, 11)
492:                 *-- Visivel: Docus Fixo Horizontal (3/11) e Fixo Vertical (6)
493:                 .Value   = 1
494:                 .Visible = .T.
495:             ELSE
496:                 *-- Oculto: valor = 1 apenas se Docus=6 (Fixo Vertical sem checkbox visivel)
497:                 .Value   = IIF(par_nDocus = 6, 1, 0)
498:                 .Visible = .F.
499:             ENDIF
500:         ENDWITH
501:     ENDPROC
502: 
503:     *--------------------------------------------------------------------------
504:     * ConfigurarCheckBoxes - Campos de filtro da pagina de opcoes (2a metade)
505:     *   Complementa ConfigurarPaginaDados() adicionando o segundo campo de
506:     *   opcao de impressao (chk_4c_ChkImagem).
507:     *
508:     *   Campos adicionados (2a metade - Phase 6):
509:     *     - chk_4c_ChkImagem: Imprimir Imagem do produto (visivel Docus 6/10)
510:     *       Top=25, Left=36 relativo a Page1 (original Top=105 - 80px PageFrame)
511:     *
512:     *   par_nDocus: tipo do documento obtido de SigCdOpe.Docus
513:     *   REGRA: CheckBox.Value SEMPRE NUMERICO (1=marcado, 0=desmarcado)
514:     *--------------------------------------------------------------------------
515:     PROTECTED PROCEDURE ConfigurarCheckBoxes(par_nDocus)
516:         LOCAL loc_oPagina
517:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
518: 
519:         *-- chkImagem: Imprimir Imagem do produto
520:         loc_oPagina.AddObject("chk_4c_ChkImagem", "CheckBox")
521:         WITH loc_oPagina.chk_4c_ChkImagem
522:             .Top           = 25
523:             .Left          = 36
524:             .AutoSize      = .T.
525:             .Alignment     = 0
526:             .Caption       = "Imprimir Imagem"
527:             .Value         = 1
528:             .SpecialEffect = 1
529:             .FontName      = "Arial"
530:             .FontSize      = 9
531:             *-- Visivel apenas para Docus 6 (Fixo Vertical) e 10 (Tres Vias)

*-- Linhas 631 a 653:
631:     ENDPROC
632: 
633:     *--------------------------------------------------------------------------
634:     * FormParaRelatorio - Transfere estado dos checkboxes para o BO
635:     *   Chamado antes de qualquer operacao de impressao/visualizacao/exportacao.
636:     *   CheckBox.Value e NUMERICO (1=marcado, 0=desmarcado) - comparar com = 1
637:     *--------------------------------------------------------------------------
638:     PROCEDURE FormParaRelatorio()
639:         LOCAL loc_oPagina
640:         IF VARTYPE(THIS.this_oRelatorio) != "O"
641:             RETURN
642:         ENDIF
643:         TRY
644:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
645:             THIS.this_oRelatorio.this_lChkObs    = (loc_oPagina.chk_4c_ChkObs.Value    = 1)
646:             THIS.this_oRelatorio.this_lChkImagem = (loc_oPagina.chk_4c_ChkImagem.Value = 1)
647:         CATCH
648:             *-- Checkboxes nao disponiveis - manter defaults do BO
649:         ENDTRY
650:     ENDPROC
651: 
652:     *--------------------------------------------------------------------------
653:     * BtnIncluirClick - Nao aplicavel a formularios de relatorio (frmrelatorio)

*-- Linhas 722 a 730:
722:     ENDPROC
723: 
724:     *--------------------------------------------------------------------------
725:     * LimparCampos - Reinicia checkboxes de filtro para valores padrao
726:     *   Chamado por FormBase em certas transicoes de estado.
727:     *--------------------------------------------------------------------------
728:     PROTECTED PROCEDURE LimparCampos()
729:         LOCAL loc_oErro
730:         TRY

