# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' numa tela cujo dump legado NAO declara essa fonte - trocar por 'Tahoma' SO nas linhas apontadas, nunca "todas as ocorrencias" (Erro178: o legado do SIGCDPRO declara Comic Sans MS nos 8 botoes de navegacao, e a troca em massa virou regressao de PILAR 1)

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrItb.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1391 linhas total):

*-- Linhas 31 a 39:
31: *            guarda no inicio do handler, padrao ValidarDemp de
32: *            Formsigatcrp.prg (fAcessoEmpresa).
33: *            Fase 7/8 (esta) - ConfigurarAguarde() (cnt_4c_Aguarde + Shape1
34: *            decorativo); eventos dos botoes de acao: cmd_4c_Processar
35: *            (BtnProcessarClick -> valida periodo via SigPrItbBO.
36: *            ValidarPeriodo, confirma e delega para ExecutarProcessamento,
37: *            equivalente ao PROCEDURE "Processamento" do SCX legado);
38: *            cmg_4c_Relatorio Buttons(1)/(2) (BtnImprimirClick/
39: *            BtnVisualizarClick -> REPORT FORM SigPrIct via

*-- Linhas 127 a 172:
127:         RETURN DODEFAULT()
128:     ENDPROC
129: 
130:     *==========================================================================
131:     * InicializarForm - Instancia o BO e monta a estrutura visual base.
132:     * Fase 3 (esta) monta apenas o cabecalho (cnt_4c_Sombra); os demais
133:     * blocos (botoes de acao, filtro de periodo/empresa, aguarde) entram nas
134:     * proximas fases, dentro de ConfigurarPageFrame().
135:     *==========================================================================
136:     PROTECTED PROCEDURE InicializarForm()
137:         LOCAL loc_lSucesso, loc_lModoSemBanco, loc_oErro
138:         loc_lSucesso = .F.
139: 
140:         TRY
141:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrItbBO")
142: 
143:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
144:                 *-- Init legado aborta a tela se "Select DirContabv From
145:                 *-- SigCdPam" falhar (MessageBox + Return 0) - em validacao de
146:                 *-- UI/modo teste nao ha conexao SQL, e o form so monta a
147:                 *-- estrutura visual (mesmo padrao de FormSIGPRIMP.CarregarLista).
148:                 loc_lModoSemBanco = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
149:                     (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
150: 
151:                 IF loc_lModoSemBanco OR THIS.this_oBusinessObject.CarregarParametros()
152:                     THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
153: 
154:                     THIS.ConfigurarPageFrame()
155: 
156:                     THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
157:                     THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
158: 
159:                     THIS.TornarControlesVisiveis(THIS)
160: 
161:                     *-- Estado inicial do Init legado (".getData1.Enabled = .t.",
162:                     *-- ".getData2.Enabled = .t.", ".btnImprimir.Enabled = .f." e
163:                     *-- ".btnVisualizar.Enabled = .f.") pelo funil unico da Fase 8
164:                     THIS.this_cModoAtual = "FILTRO"
165:                     THIS.HabilitarCampos(.T.)
166:                     THIS.AjustarBotoesPorModo()
167: 
168:                     THIS.Visible = .T.
169: 
170:                     loc_lSucesso = .T.
171:                 ELSE
172:                     MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "FormSigPrItb.InicializarForm")

*-- Linhas 216 a 224:
216:     * EM LOTE (filtro de periodo + empresa -> gera arquivo de integracao
217:     * contabil), sem Lista/Grid e sem Page1/Page2.
218:     *
219:     *   cmd_4c_Processar  - solto no form (SIGPRITB.Processar, Top=3/Left=649)
220:     *   cnt_4c_Botoes     - container (SIGPRITB.cntBotoes, Top=1/Left=496)
221:     *     cmg_4c_Relatorio  - CommandGroup com 2 botoes (legado chama o
222:     *                         container interno de "BtnReport" no codigo -
223:     *                         THIS.cnt_4c_Botoes.cmg_4c_Relatorio.btnImprimir/
224:     *                         btnVisualizar.Enabled = .f./.t. na Fase 7/8):

*-- Linhas 233 a 253:
233:         LOCAL loc_oCmg, loc_oErro
234: 
235:         TRY
236:             *-- cmd_4c_Processar (SIGPRITB.Processar, classe fwbtng do legado -
237:             *-- defaults Height=100/Width=80/FontName="Comic Sans MS" herdados
238:             *-- de framework.vcx, mas o canonico do projeto para botao de acao
239:             *-- solto com icone eh 75x75, igual ao FormSIGMVCMV/Processa)
240:             THIS.AddObject("cmd_4c_Processar", "CommandButton")
241:             WITH THIS.cmd_4c_Processar
242:                 .Top             = 3
243:                 .Left            = 649
244:                 .Height          = 75
245:                 .Width           = 75
246:                 .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
247:                 .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
248:                 .Caption         = "\<Processar"
249:                 .FontName        = "Comic Sans MS"
250:                 .FontBold        = .T.
251:                 .FontItalic      = .T.
252:                 .FontSize        = 8
253:                 .ForeColor       = RGB(90, 90, 90)

*-- Linhas 260 a 274:
260:                 .AutoSize        = .F.
261:                 .Visible         = .T.
262:             ENDWITH
263:             BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
264: 
265:             *-- cnt_4c_Botoes (SIGPRITB.cntBotoes)
266:             THIS.AddObject("cnt_4c_Botoes", "Container")
267:             WITH THIS.cnt_4c_Botoes
268:                 .Top         = 1
269:                 .Left        =  542
270:                 .Width       = 156
271:                 .Height      = 84
272:                 .BackStyle   = 0
273:                 .BorderWidth = 0
274:                 .Visible     = .T.

*-- Linhas 281 a 320:
281:                 .ButtonCount = 2
282:                 .BackStyle   = 0
283:                 .BorderStyle = 0
284:                 .Top         = -3
285:                 .Left        = -2
286:                 .Width       = 160
287:                 .Height      = 85
288:                 .Value       = 1
289:                 WITH .Buttons(1)
290:                     .Top             = 5
291:                     .Left            = 80
292:                     .Height          = 75
293:                     .Width           = 75
294:                     .FontName        = "Comic Sans MS"
295:                     .FontSize        = 8
296:                     .WordWrap        = .T.
297:                     .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
298:                     .Caption         = "\<Impressora"
299:                     .PicturePosition = 13
300:                     .ForeColor       = RGB(90, 90, 90)
301:                     .BackColor       = RGB(255, 255, 255)
302:                     .Themes          = .F.
303:                     *-- Init legado: .cntBotoes.BtnReport.btnImprimir.Enabled = .f.
304:                     .Enabled         = .F.
305:                 ENDWITH
306:                 WITH .Buttons(2)
307:                     .Top             = 5
308:                     .Left            = 5
309:                     .Height          = 75
310:                     .Width           = 75
311:                     .FontName        = "Comic Sans MS"
312:                     .FontSize        = 8
313:                     .WordWrap        = .T.
314:                     .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
315:                     .Caption         = "\<Video"
316:                     .PicturePosition = 13
317:                     .ForeColor       = RGB(90, 90, 90)
318:                     .BackColor       = RGB(255, 255, 255)
319:                     .Themes          = .F.
320:                     *-- Init legado: .cntBotoes.BtnReport.btnVisualizar.Enabled = .f.

*-- Linhas 336 a 359:
336:                 .BackStyle     = 0
337:                 .BorderStyle   = 0
338:                 .SpecialEffect = 1
339:                 .Top           = -2
340:                 .Left          = 719
341:                 .Width         = 85
342:                 .Height        = 85
343:                 .Value         = 0
344:                 WITH .Buttons(1)
345:                     .Top       = 5
346:                     .Left      = 5
347:                     .Height    = 75
348:                     .Width     = 75
349:                     .FontName  = "Comic Sans MS"
350:                     .FontSize  = 8
351:                     .WordWrap  = .T.
352:                     .Picture   = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
353:                     .Cancel    = .T.
354:                     .Caption   = "Encerrar"
355:                     .ForeColor = RGB(90, 90, 90)
356:                     .BackColor = RGB(255, 255, 255)
357:                     .Themes    = .F.
358:                 ENDWITH
359:             ENDWITH

*-- Linhas 378 a 431:
378:     *==========================================================================
379:     PROTECTED PROCEDURE ConfigurarCabecalho()
380:         LOCAL loc_oCnt, loc_oErro
381: 
382:         TRY
383:             THIS.AddObject("cnt_4c_Sombra", "Container")
384:             loc_oCnt = THIS.cnt_4c_Sombra
385:             WITH loc_oCnt
386:                 .Top         = 0
387:                 .Left        = 0
388:                 .Width       = THIS.Width
389:                 .Height      = 80
390:                 .BorderWidth = 0
391:                 .BackColor   = RGB(100, 100, 100)
392:                 .Visible     = .T.
393:             ENDWITH
394: 
395:             loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
396:             WITH loc_oCnt.lbl_4c_LblSombra
397:                 .FontBold      = .T.
398:                 .FontName      = "Tahoma"
399:                 .FontSize      = 18
400:                 .FontUnderline = .F.
401:                 .WordWrap      = .T.
402:                 .Alignment     = 0
403:                 .BackStyle     = 0
404:                 .AutoSize      = .F.
405:                 .Caption       = THIS.Caption
406:                 .Height        = 40
407:                 .Left          = 10
408:                 .Top           = 18
409:                 .Width         = 769
410:                 .ForeColor     = RGB(0, 0, 0)
411:                 .Visible       = .T.
412:             ENDWITH
413: 
414:             loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
415:             WITH loc_oCnt.lbl_4c_LblTitulo
416:                 .FontBold   = .T.
417:                 .FontName   = "Tahoma"
418:                 .FontSize   = 18
419:                 .WordWrap   = .T.
420:                 .Alignment  = 0
421:                 .BackStyle  = 0
422:                 .AutoSize   = .F.
423:                 .Caption    = THIS.Caption
424:                 .Height     = 46
425:                 .Left       = 10
426:                 .Top        = 17
427:                 .Width      = 769
428:                 .ForeColor  = RGB(255, 255, 255)
429:                 .Visible    = .T.
430:             ENDWITH
431:         CATCH TO loc_oErro

*-- Linhas 461 a 522:
461:             *-- da Fase 4
462:             THIS.AddObject("cnt_4c_Mvt1", "Container")
463:             WITH THIS.cnt_4c_Mvt1
464:                 .Top         = 94
465:                 .Left        = 132
466:                 .Width       = 389
467:                 .Height      = 60
468:                 .BackStyle   = 0
469:                 .BorderWidth = 0
470:                 .Visible     = .T.
471:             ENDWITH
472: 
473:             *-- lbl_4c_Lbl_periodo (SIGPRITB.cntMvt1.lbl_periodo, classe say)
474:             THIS.cnt_4c_Mvt1.AddObject("lbl_4c_Lbl_periodo", "Label")
475:             WITH THIS.cnt_4c_Mvt1.lbl_4c_Lbl_periodo
476:                 .Top       = 10
477:                 .Left      = 13
478:                 .Width     = 45
479:                 .Height    = 15
480:                 .FontName  = "Tahoma"
481:                 .FontSize  = 8
482:                 .BackStyle = 0
483:                 .Alignment = 0
484:                 .AutoSize  = .F.
485:                 .ForeColor = RGB(90, 90, 90)
486:                 .Caption   = "Per" + CHR(237) + "odo :"
487:                 .Visible   = .T.
488:             ENDWITH
489: 
490:             *-- lbl_4c_Lbl_periodo_a (SIGPRITB.cntMvt1.lbl_periodo_a) - "a"
491:             *-- entre as duas datas (Data Inicial "a" Data Final)
492:             THIS.cnt_4c_Mvt1.AddObject("lbl_4c_Lbl_periodo_a", "Label")
493:             WITH THIS.cnt_4c_Mvt1.lbl_4c_Lbl_periodo_a
494:                 .Top       = 9
495:                 .Left      = 146
496:                 .Width     = 8
497:                 .Height    = 15
498:                 .FontName  = "Tahoma"
499:                 .FontSize  = 8
500:                 .BackStyle = 0
501:                 .Alignment = 0
502:                 .AutoSize  = .F.
503:                 .ForeColor = RGB(90, 90, 90)
504:                 .Caption   = "a"
505:                 .Visible   = .T.
506:             ENDWITH
507: 
508:             *-- txt_4c_Data1 (SIGPRITB.cntMvt1.getData1, classe fweditdata) -
509:             *-- Data Inicial do periodo. .Value = {} aqui so para o controle
510:             *-- nascer DATE - o valor real vem do BO logo no fim do metodo.
511:             *-- SpecialEffect/Alignment/Themes = defaults da classe fweditdata
512:             *-- (docs/FRAMEWORK_class_codigo_fonte.txt); Format="K" eh override
513:             *-- do dump (SECAO 2 - PROPRIEDADES DE SIGPRITB.cntMvt1.getData1)
514:             THIS.cnt_4c_Mvt1.AddObject("txt_4c_Data1", "TextBox")
515:             WITH THIS.cnt_4c_Mvt1.txt_4c_Data1
516:                 .Top           = 5
517:                 .Left          = 63
518:                 .Width         = 79
519:                 .Height        = 25
520:                 .FontName      = "Tahoma"
521:                 .FontSize      = 8
522:                 .ForeColor     = RGB(90, 90, 90)

*-- Linhas 532 a 541:
532:             *-- Data Final do periodo
533:             THIS.cnt_4c_Mvt1.AddObject("txt_4c_Data2", "TextBox")
534:             WITH THIS.cnt_4c_Mvt1.txt_4c_Data2
535:                 .Top           = 5
536:                 .Left          = 155
537:                 .Width         = 79
538:                 .Height        = 25
539:                 .FontName      = "Tahoma"
540:                 .FontSize      = 8
541:                 .ForeColor     = RGB(90, 90, 90)

*-- Linhas 547 a 581:
547:                 .Visible       = .T.
548:             ENDWITH
549: 
550:             *-- lbl_4c_Lbl_empresa (SIGPRITB.cntMvt1.lbl_empresa, classe say)
551:             THIS.cnt_4c_Mvt1.AddObject("lbl_4c_Lbl_empresa", "Label")
552:             WITH THIS.cnt_4c_Mvt1.lbl_4c_Lbl_empresa
553:                 .Top       = 37
554:                 .Left      = 8
555:                 .Width     = 50
556:                 .Height    = 15
557:                 .FontName  = "Tahoma"
558:                 .FontSize  = 8
559:                 .BackStyle = 0
560:                 .Alignment = 0
561:                 .AutoSize  = .F.
562:                 .ForeColor = RGB(90, 90, 90)
563:                 .Caption   = "Empresa :"
564:                 .Visible   = .T.
565:             ENDWITH
566: 
567:             *-- txt_4c_Emp1 (SIGPRITB.cntMvt1.getEmp1) - codigo da empresa,
568:             *-- OPCIONAL (vazio processa todas as empresas). SigCdEmp.Cemps
569:             *-- eh char(3) no schema - MaxLength vem do SCHEMA, nunca do
570:             *-- Width em pixels (regra #19 / Erro158). Alignment/BackStyle/
571:             *-- BorderStyle/SpecialEffect/Format transcritos do dump (SECAO 2
572:             *-- - PROPRIEDADES DE SIGPRITB.cntMvt1.getEmp1)
573:             THIS.cnt_4c_Mvt1.AddObject("txt_4c_Emp1", "TextBox")
574:             WITH THIS.cnt_4c_Mvt1.txt_4c_Emp1
575:                 .Top           = 32
576:                 .Left          = 63
577:                 .Width         = 31
578:                 .Height        = 25
579:                 .FontName      = "Tahoma"
580:                 .FontSize      = 8
581:                 .ForeColor     = RGB(90, 90, 90)

*-- Linhas 594 a 603:
594:             *-- este metodo). SigCdEmp.Razas eh char(40) no schema
595:             THIS.cnt_4c_Mvt1.AddObject("txt_4c_Dsemp1", "TextBox")
596:             WITH THIS.cnt_4c_Mvt1.txt_4c_Dsemp1
597:                 .Top       = 32
598:                 .Left      = 94
599:                 .Width     = 290
600:                 .Height    = 25
601:                 .FontName  = "Tahoma"
602:                 .FontSize  = 8
603:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 779 a 788:
779:                 IF VARTYPE(loc_oBusca) = "O"
780:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmp"
781:                     loc_oBusca.this_cTitulo        = loc_cTitulo
782:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
783:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
784:                     IF par_lPorDescricao
785:                         loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
786:                         loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
787:                     ELSE
788:                         loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")

*-- Linhas 826 a 898:
826:             *-- Shape1 (SIGPRITB.Shape1) - decorativo, sem BINDEVENT
827:             THIS.AddObject("shp_4c_Shape1", "Shape")
828:             WITH THIS.shp_4c_Shape1
829:                 .Top         = 48
830:                 .Left        = 372
831:                 .Height      = 12
832:                 .Width       = 36
833:                 .BackStyle   = 0
834:                 .BorderStyle = 0
835:                 .BorderColor = RGB(136, 189, 188)
836:                 .Visible     = .T.
837:             ENDWITH
838: 
839:             *-- cnt_4c_Aguarde (SIGPRITB.cntAguarde)
840:             THIS.AddObject("cnt_4c_Aguarde", "Container")
841:             WITH THIS.cnt_4c_Aguarde
842:                 .Top         = 163
843:                 .Left        = 284
844:                 .Width       = 207
845:                 .Height      = 49
846:                 .BorderWidth = 5
847:                 .SpecialEffect = 0
848:                 .BackColor   = RGB(255, 255, 255)
849:                 .Visible     = .F.
850:             ENDWITH
851: 
852:             THIS.cnt_4c_Aguarde.AddObject("lbl_4c_Label1", "Label")
853:             WITH THIS.cnt_4c_Aguarde.lbl_4c_Label1
854:                 .FontBold  = .T.
855:                 .FontName  = "Verdana"
856:                 .FontSize  = 10
857:                 .BackStyle = 0
858:                 .AutoSize  = .F.
859:                 .Caption   = "Aguarde..."
860:                 .Height    = 18
861:                 .Left      = 68
862:                 .Top       = 7
863:                 .Width     = 78
864:                 .ForeColor = RGB(255, 0, 0)
865:                 .Visible   = .T.
866:             ENDWITH
867: 
868:             THIS.cnt_4c_Aguarde.AddObject("lbl_4c_Label2", "Label")
869:             WITH THIS.cnt_4c_Aguarde.lbl_4c_Label2
870:                 .FontBold      = .T.
871:                 .FontName      = "Tahoma"
872:                 .FontSize      = 9
873:                 .FontCondense  = .T.
874:                 .Alignment     = 0
875:                 .BackStyle     = 0
876:                 .AutoSize      = .F.
877:                 .Caption       = "Processando Dados..."
878:                 .Height        = 16
879:                 .Left          = 38
880:                 .Top           = 24
881:                 .Width         = 133
882:                 .ForeColor     = RGB(90, 90, 90)
883:                 .Visible       = .T.
884:             ENDWITH
885:         CATCH TO loc_oErro
886:             MsgErro(loc_oErro.Message + CHR(13) + ;
887:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
888:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarAguarde")
889:         ENDTRY
890:     ENDPROC
891: 
892:     *==========================================================================
893:     * BtnProcessarClick - Click de cmd_4c_Processar (SIGPRITB.Processar.Click).
894:     * Replica as 3 validacoes do legado (via SigPrItbBO.ValidarPeriodo - mesmas
895:     * mensagens e ordem) + confirmacao "Confirma o Processamento ?"; so entao
896:     * delega para ExecutarProcessamento (PROCEDURE "Processamento" do legado).
897:     * PUBLIC: ligado via BINDEVENT em ConfigurarBotoesAcao.
898:     *==========================================================================

*-- Linhas 1306 a 1314:
1306: 
1307:         loc_lInconsistencia = (UPPER(ALLTRIM(THIS.this_cModoAtual)) == "INCONSISTENCIA")
1308: 
1309:         THIS.cmd_4c_Processar.Enabled = !loc_lInconsistencia
1310:         THIS.cnt_4c_Botoes.cmg_4c_Relatorio.Buttons(1).Enabled = loc_lInconsistencia
1311:         THIS.cnt_4c_Botoes.cmg_4c_Relatorio.Buttons(2).Enabled = loc_lInconsistencia
1312:     ENDPROC
1313: 
1314:     *==========================================================================


### BO (C:\4c\projeto\app\classes\SigPrItbBO.prg):
*==============================================================================
* SIGPRITBBO.PRG
* Business Object do formulario SIGPRITB (Integracao Contabil Total)
* Responsabilidade: processar os lancamentos financeiros do periodo filtrado
* (SigMvCcr), classificar a conta contabil de cada lancamento (SigCdGcr /
* SigCdCli), detectar contas sem conta contabil cadastrada e gerar o arquivo
* texto de integracao contabil (um arquivo por empresa/data) no diretorio
* configurado em SigCdPam.DirContabv.
*
* SIGPRITB e um form OPERACIONAL de PROCESSAMENTO em lote, sem tabela
* mestre nem grid de cadastro - por isso this_cTabela e this_cCampoChave
* permanecem vazios (nao ha CRUD, nao ha chave primaria de registro).
*==============================================================================

DEFINE CLASS SigPrItbBO AS BusinessBase

    *-- Propriedades (espelham os controles/variaveis do form legado)
    this_dDataInicial       = {}    && Periodo inicial do filtro (cntMvt1.getData1.Value / IniPer)
    this_dDataFinal         = {}    && Periodo final do filtro (cntMvt1.getData2.Value / FinPer)
    this_cEmpresa           = ""    && Codigo da empresa filtrada, opcional (cntMvt1.getEmp1.Value / lcEmp1)
    this_cDescricaoEmpresa  = ""    && Razao social da empresa filtrada, somente exibicao (cntMvt1.getDsemp1.Value)
    this_cDiretorioContabil = ""    && Diretorio de geracao do arquivo contabil (crSigCdPam.DirContabv)
    this_nTotalRegistros    = 0     && Total de lancamentos processados no ultimo Processamento (Ncont)
    this_lTemInconsistencia = .F.   && .T. quando sobraram lancamentos sem conta contabil (cursor SemConta)

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        *-- SIGPRITB nao possui tabela mestre (form de processamento em lote)
        THIS.this_cTabela = ""
        THIS.this_cCampoChave = ""

        DODEFAULT()

        *-- Valores padrao equivalentes ao Init do SCX legado
        THIS.this_dDataInicial = DATE()
        THIS.this_dDataFinal = DATE()
        THIS.this_cEmpresa = SPACE(3)
        THIS.this_cDescricaoEmpresa = SPACE(40)
        THIS.this_cDiretorioContabil = ""
        THIS.this_nTotalRegistros = 0
        THIS.this_lTemInconsistencia = .F.

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarSQL - SQLEXEC preservando a area de trabalho corrente
    * (SQLEXEC() troca a area selecionada ao criar o cursor de resultado).
    * Convencao adotada: sucesso quando o retorno do SQLEXEC nativo eh >= 0
    * (0 linhas tambem eh sucesso - periodo sem movimento NAO eh erro de
    * conexao, e e tratado depois por THIS.this_nTotalRegistros = 0).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarSQL(par_cSQL, par_cCursor, par_cRotulo)
        LOCAL loc_nRet, loc_lOk, loc_cAliasAnt

        loc_cAliasAnt = ALIAS()

        IF USED(par_cCursor)
            USE IN (par_cCursor)
        ENDIF
        loc_nRet = SQLEXEC(gnConnHandle, par_cSQL, par_cCursor)

        IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
            SELECT (loc_cAliasAnt)
        ENDIF

        loc_lOk = (loc_nRet >= 0)

        IF !loc_lOk
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                "(" + TRANSFORM(par_cRotulo) + ") " + CapturarErroSQL()
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarParametros - le o diretorio de geracao do arquivo contabil
    * (equivalente ao "Select DirContabv From SigCdPam" feito no Init do
    * SCX legado). SigCdPam nao tem filtro de empresa no legado - usa-se o
    * primeiro registro, igual ao original.
    *--------------------------------------------------------------------------
    FUNCTION CarregarParametros()
        LOCAL loc_lResultado

        loc_lResultado = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF THIS.ExecutarSQL("SELECT DirContabv FROM SigCdPam", "cursor_4c_Pam", "SigCdPam")
            IF USED("cursor_4c_Pam") AND RECCOUNT("cursor_4c_Pam") > 0
                THIS.CarregarDoCursor("cursor_4c_Pam")
            ENDIF
            IF USED("cursor_4c_Pam")
                USE IN cursor_4c_Pam
            ENDIF
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - transfere para as propriedades do BO as colunas
    * remotas que ele guarda, a partir de um cursor ja populado.
    *
    * PUBLIC (sem PROTECTED): a BusinessBase declara este metodo sem
    * modificador e o form chama de fora (regra #51 do CLAUDE.md).
    *
    * Atende os dois cursores que alimentam o BO, porque as colunas nao
    * colidem entre si e o teste de existencia eh feito coluna a coluna:
    *   - cursor de SigCdEmp (Cemps / Razas)   -> filtro de empresa da tela
    *     (equivalente ao "getEmp1.Value = crListaRemota.Cemps" e
    *      "getDsemp1.Value = crListaRemota.Razas" dos Valid do SCX legado)
    *   - cursor de SigCdPam (DirContabv)      -> diretorio de geracao
    *     (equivalente ao Select DirContabv do Init do SCX legado)
    *
    * Existencia de coluna conferida com TYPE(alias + "." + coluna) - NUNCA
    * PEMSTATUS, que exige OBJETO no 1o argumento e dispara erro 11 com
    * nome de cursor.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_cAliasAnt, loc_lResultado

        loc_lResultado = .F.

        IF VARTYPE(par_cAliasCursor) != "C" OR EMPTY(par_cAliasCursor)
            RETURN .F.
        ENDIF

        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        loc_cAliasAnt = ALIAS()

        SELECT (par_cAliasCursor)
        IF RECCOUNT(par_cAliasCursor) > 0 AND EOF(par_cAliasCursor)
            GO TOP
        ENDIF

        IF !EOF(par_cAliasCursor)
            IF TYPE(par_cAliasCursor + ".Cemps") != "U"
                THIS.this_cEmpresa = ALLTRIM(TratarNulo(EVALUATE(par_cAliasCursor + ".Cemps"), ""))
                loc_lResultado = .T.
            ENDIF

            IF TYPE(par_cAliasCursor + ".Razas") != "U"
                THIS.this_cDescricaoEmpresa = ALLTRIM(TratarNulo(EVALUATE(par_cAliasCursor + ".Razas"), ""))
                loc_lResultado = .T.
            ENDIF

            IF TYPE(par_cAliasCursor + ".DirContabv") != "U"
                THIS.this_cDiretorioContabil = ALLTRIM(TratarNulo(EVALUATE(par_cAliasCursor + ".DirContabv"), ""))
                loc_lResultado = .T.
            ENDIF
        ENDIF

        IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
            SELECT (loc_cAliasAnt)
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarEmpresa - resolve o filtro de empresa da tela por codigo
    * (Cemps) ou por razao social (Razas), com match EXATO.
    *
    * Equivale a primeira metade dos Valid de getEmp1/getDsemp1 do SCX
    * legado: achando UM registro, o par codigo/descricao eh preenchido e o
    * browse nao abre; nao achando, o form abre o picker (FormBuscaAuxiliar)
    * passando o valor digitado como prefixo - por isso aqui NAO se apaga o
    * valor digitado nem se exibe aviso de "nao encontrado" (regra #50).
    *
    * SigCdEmp: PK Cemps char(3), razao social Razas char(40) (schema.sql).
    *--------------------------------------------------------------------------
    FUNCTION CarregarEmpresa(par_cValor, par_lPorDescricao)
        LOCAL loc_lResultado, loc_cSQL, loc_cValor, loc_lPorDesc

        THIS.this_cMensagemErro = ""
        loc_lResultado = .F.

        loc_cValor = IIF(VARTYPE(par_cValor) = "C", ALLTRIM(par_cValor), "")
        loc_lPorDesc = (VARTYPE(par_lPorDescricao) = "L" AND par_lPorDescricao)

        IF EMPTY(loc_cValor)
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE " + ;
            IIF(loc_lPorDesc, "RTRIM(Razas) = ", "RTRIM(Cemps) = ") + EscaparSQL(loc_cValor)

        IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_Emp", "SigCdEmp")
            IF USED("cursor_4c_Emp") AND RECCOUNT("cursor_4c_Emp") = 1
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Emp")
            ENDIF
            IF USED("cursor_4c_Emp")
                USE IN cursor_4c_Emp
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - identificacao do lote processado (empresa +
    * periodo). SIGPRITB nao tem registro mestre; esta eh a unica chave que
    * identifica uma execucao, e eh o que a BusinessBase consome quando
    * RegistrarAuditoria() eh chamado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        LOCAL loc_cEmp

        loc_cEmp = ALLTRIM(TratarNulo(THIS.this_cEmpresa, ""))
        IF EMPTY(loc_cEmp)
            loc_cEmp = "*"
        ENDIF

        RETURN loc_cEmp + "|" + DTOS(ConverterParaData(THIS.this_dDataInicial)) + ;
               "|" + DTOS(ConverterParaData(THIS.this_dDataFinal))
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarCabecalhoRelatorio - cria e popula cursor_4c_Cabecalho, o
    * cabecalho do "Relatorio de Integracao Contabil" (a lista de contas sem
    * conta contabil cadastrada). Transcrito do Create Cursor Cabecalho +
    * Insert Into Cabecalho do metodo "processamento" do SCX legado, que
    * busca a razao social da empresa corrente com
    * CursorQuery('SigCdEmp', 'crSigCdEmp', 'Cemps', _Empr).
    *
    * _Empr do legado = go_4c_Sistema.cCodEmpresa (a variavel legada _EMPR
    * nunca eh usada no sistema novo).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION MontarCabecalhoRelatorio()
        LOCAL loc_lResultado, loc_cCodEmpresa, loc_cRazao, loc_cPeriodo

        loc_lResultado = .F.

        loc_cCodEmpresa = ""
        IF TYPE("go_4c_Sistema") = "O" AND !ISNULL(go_4c_Sistema)
            loc_cCodEmpresa = ALLTRIM(TratarNulo(go_4c_Sistema.cCodEmpresa, ""))
        ENDIF

        loc_cRazao = ""
        IF !EMPTY(loc_cCodEmpresa)
            IF THIS.ExecutarSQL("SELECT Cemps, Razas FROM SigCdEmp WHERE RTRIM(Cemps) = " + ;
                    EscaparSQL(loc_cCodEmpresa), "cursor_4c_EmpCab", "SigCdEmp")
                IF USED("cursor_4c_EmpCab") AND RECCOUNT("cursor_4c_EmpCab") > 0
                    SELECT cursor_4c_EmpCab
                    GO TOP
                    loc_cRazao = ALLTRIM(TratarNulo(cursor_4c_EmpCab.Razas, ""))
                ENDIF
                IF USED("cursor_4c_EmpCab")
                    USE IN cursor_4c_EmpCab
                ENDIF
                loc_lResultado = .T.
            ENDIF
        ELSE
            *-- Sem empresa corrente definida o legado tambem segue adiante
            *-- (o CursorQuery nao achando nada deixa crSigCdEmp.Razas vazio)
            loc_lResultado = .T.
        ENDIF

        IF loc_lResultado
            IF USED("cursor_4c_Cabecalho")
                USE IN cursor_4c_Cabecalho
            ENDIF
            CREATE CURSOR cursor_4c_Cabecalho (Empresa C(80), Titulo C(80), ;
                SubTit C(80), Periodo C(80))

            loc_cPeriodo = "Per" + CHR(237) + "odo: " + ;
                DTOC(ConverterParaData(THIS.this_dDataInicial)) + " " + CHR(224) + " " + ;
                DTOC(ConverterParaData(THIS.this_dDataFinal))

            INSERT INTO cursor_4c_Cabecalho (Empresa, Titulo, SubTit, Periodo) ;
                VALUES (loc_cCodEmpresa + " - " + loc_cRazao, ;
                        "Relat" + CHR(243) + "rio de Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil", ;
                        "Contas Financeiras sem Conta Cont" + CHR(225) + "bil Cadastrada", ;
                        loc_cPeriodo)
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarPeriodo - valida o periodo informado antes de processar
    * (equivalente as checagens do Processar.Click do SCX legado).
    *--------------------------------------------------------------------------
    FUNCTION ValidarPeriodo()
        THIS.this_cMensagemErro = ""

        IF EMPTY(THIS.this_dDataInicial)
            THIS.this_cMensagemErro = "Data Inicial Inv" + CHR(225) + "lida!!!"
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.this_dDataFinal)
            THIS.this_cMensagemErro = "Data Final Inv" + CHR(225) + "lida!!!"
            RETURN .F.
        ENDIF

        IF THIS.this_dDataFinal < THIS.this_dDataInicial
            THIS.this_cMensagemErro = "A Data Final N" + CHR(227) + "o Pode Ser Menor Que a Inicial!!!"
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Processar - classifica os lancamentos de SigMvCcr do periodo filtrado
    * (equivalente ao metodo "processamento" do SCX legado). Para cada
    * lancamento, define a conta contabil na ordem: conta do grupo de conta
    * corrente (SigCdGcr.ContConts) -> conta contabil do cliente
    * (SigCdCli.CContabs) -> a propria conta do lancamento (e nesse caso
    * entra em cursor_4c_SemConta, a lista de inconsistencias). Preenche
    * cursor_4c_MovAux (base do arquivo gerado por GerarArquivoContabil) e
    * as propriedades this_nTotalRegistros / this_lTemInconsistencia.
    *
    * EmpCont (cursor_4c_MovAux): no SCX legado este campo da cursor MovAux
    * nunca recebe valor dentro do Scan ("Scatter Memvar" em crSigMvCcr cria
    * m.Emps, nao m.EmpCont, e nenhuma linha do metodo atribui M.EmpCont) -
    * ficaria sempre em branco, o que faria a separacao "um arquivo por
    * empresa" (Gravar/GerarArquivoContabil, que agrupa por este campo)
    * degenerar num unico arquivo sem extensao para TODAS as empresas. Como
    * o proprio cursor (campo dedicado + indice EmpCont+Datas) e o metodo de
    * geracao do arquivo so fazem sentido com o agrupamento funcionando,
    * populamos aqui com o Emps do lancamento (crSigMvCcr.Emps) - e nao a
    * omissao do legado - para completar o mecanismo que a estrutura de
    * dados ja declarava.
    *--------------------------------------------------------------------------
    FUNCTION Processar()
        LOCAL loc_lResultado, loc_lProsseguir, loc_cSQL, loc_cDataIniSQL, loc_cDataFimSQL, ;
              loc_nTotal, loc_cContabs, loc_nDebs, loc_nCreds, loc_cAnoFis, loc_cDatas, ;
              loc_cHistsRaw, loc_cHist2sRaw, loc_cHists, loc_cDocto, loc_dDataLan, loc_oErro

        THIS.this_cMensagemErro = ""
        THIS.this_nTotalRegistros = 0
        THIS.this_lTemInconsistencia = .F.
        loc_lResultado = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF !THIS.ValidarPeriodo()
            RETURN .F.
        ENDIF

        loc_lProsseguir = .T.

        TRY
            *-- Cursores de trabalho (recriados a cada chamada)
            IF USED("cursor_4c_MovAux")
                USE IN cursor_4c_MovAux
            ENDIF
            *-- Larguras TRANSCRITAS do Create Cursor do legado (Load /
            *-- processamento). Nao sao detalhe: GerarArquivoContabil grava
            *-- registro de largura FIXA (o "Copy To ... Type SDF" do legado),
            *-- entao cada caractere a mais desloca todas as colunas
            *-- seguintes do arquivo entregue a contabilidade.
            CREATE CURSOR cursor_4c_MovAux (AnoFis C(04), Datas C(08), Contas C(09), ;
                Debs C(12), Creds C(12), Docto C(10), Hists C(70), EmpCont C(03))
            INDEX ON EmpCont + Datas TAG EmpCont

            IF USED("cursor_4c_SemConta")
                USE IN cursor_4c_SemConta
            ENDIF
            *-- SEM "SET NULL ON": o legado declara estes campos NAO-nulaveis e
            *-- o cursor eh populado por APPEND BLANK + REPLACE com NVL(), nunca
            *-- por APPEND FROM de SQLEXEC. Nulavel, o APPEND BLANK deixaria
            *-- Datas = .NULL. e a chave do indice (DTOS(Datas)) sairia nula.
            CREATE CURSOR cursor_4c_SemConta (Contas C(09), Datas D, Hists C(70), ;
                Valors N(12,2), Ocors C(40))
            INDEX ON Contas + DTOS(Datas) TAG Conta

            *-- Cabecalho do relatorio de inconsistencias
            IF !THIS.MontarCabecalhoRelatorio()
                loc_lProsseguir = .F.
            ENDIF

            *-- Grupos de conta corrente (SigCdGcr) - preload + indice, igual ao legado
            IF loc_lProsseguir
                IF !THIS.ExecutarSQL("SELECT Codigos, ContConts FROM SigCdGcr", "cursor_4c_Gcr", "SigCdGcr")
                    loc_lProsseguir = .F.
                ELSE
                    SELECT cursor_4c_Gcr
                    INDEX ON Codigos TAG Codigos
                ENDIF
            ENDIF

            *-- Lancamentos financeiros do periodo, opcionalmente filtrados por empresa
            IF loc_lProsseguir
                loc_cDataIniSQL = LEFT(FormatarDataSQL(THIS.this_dDataInicial), ;
                    LEN(FormatarDataSQL(THIS.this_dDataInicial)) - 1) + " 00:00:00'"
                loc_cDataFimSQL = LEFT(FormatarDataSQL(THIS.this_dDataFinal), ;
                    LEN(FormatarDataSQL(THIS.this_dDataFinal)) - 1) + " 23:59:59'"

                loc_cSQL = "SELECT Emps, Grupos, Contas, Datas, Hists, Hist2s, Valors, Opers, Autos " + ;
                    "FROM SigMvCcr " + ;
                    "WHERE Datas BETWEEN " + loc_cDataIniSQL + " AND " + loc_cDataFimSQL
                IF !EMPTY(ALLTRIM(THIS.this_cEmpresa))
                    loc_cSQL = loc_cSQL + " AND Emps = " + EscaparSQL(ALLTRIM(THIS.this_cEmpresa))
                ENDIF

                IF !THIS.ExecutarSQL(loc_cSQL, "cursor_4c_MvCcr", "SigMvCcr")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                loc_nTotal = 0

                SELECT cursor_4c_MvCcr
                SCAN
                    loc_nTotal = loc_nTotal + 1

                    *-- Conta contabil do cliente do lancamento (SigCdCli) -
                    *-- consulta linha a linha, igual ao legado (CursorQuery por IClis)
                    THIS.ExecutarSQL("SELECT IClis, CContabs FROM SigCdCli WHERE IClis = " + ;
                        EscaparSQL(ALLTRIM(cursor_4c_MvCcr.Contas)), "cursor_4c_Cli", "SigCdCli")

                    loc_cContabs = ""
                    IF SEEK(ALLTRIM(cursor_4c_MvCcr.Grupos), "cursor_4c_Gcr", "Codigos") AND ;
                            !EMPTY(ALLTRIM(NVL(cursor_4c_Gcr.ContConts, "")))
                        loc_cContabs = ALLTRIM(cursor_4c_Gcr.ContConts)
                    ELSE
                        IF USED("cursor_4c_Cli") AND RECCOUNT("cursor_4c_Cli") > 0 AND ;
                                !EMPTY(ALLTRIM(NVL(cursor_4c_Cli.CContabs, "")))
                            loc_cContabs = ALLTRIM(cursor_4c_Cli.CContabs)
                        ELSE
                            loc_cContabs = ALLTRIM(cursor_4c_MvCcr.Contas)

                            SELECT cursor_4c_SemConta
                            APPEND BLANK
                            REPLACE Datas  WITH NVL(cursor_4c_MvCcr.Datas, {}), ;
                                    Contas WITH cursor_4c_MvCcr.Contas, ;
                                    Hists  WITH LEFT(TratarNulo(cursor_4c_MvCcr.Hists, "") + ;
                                        TratarNulo(cursor_4c_MvCcr.Hist2s, ""), 70), ;
                                    Valors WITH cursor_4c_MvCcr.Valors
                            THIS.this_lTemInconsistencia = .T.

                            SELECT cursor_4c_MvCcr
                        ENDIF
                    ENDIF

                    IF cursor_4c_MvCcr.Opers = "D"
                        loc_nDebs  = cursor_4c_MvCcr.Valors
                        loc_nCreds = 0
                    ELSE
                        loc_nDebs  = 0
                        loc_nCreds = cursor_4c_MvCcr.Valors
                    ENDIF

                    loc_dDataLan = ConverterParaData(cursor_4c_MvCcr.Datas)
                    loc_cAnoFis  = STR(YEAR(loc_dDataLan), 4)

                    *-- Legado: StrTran(Dtoc(...), "/", "") num campo c(08), ou
                    *-- seja DDMMAAAA - resultado que DEPENDE de SET DATE
                    *-- BRITISH + SET CENTURY ON. Montado aqui digito a digito
                    *-- para que o arquivo saia igual mesmo se os SETs estiverem
                    *-- em outro estado (DataSession=2 nasce em AMERICAN com
                    *-- CENTURY OFF - regra #9.4 - e Dtoc daria 6 caracteres,
                    *-- deslocando TODAS as colunas seguintes do arquivo).
                    IF EMPTY(loc_dDataLan)
                        loc_cDatas = SPACE(8)
                    ELSE
                        loc_cDatas = PADL(DAY(loc_dDataLan), 2, "0") + ;
                                     PADL(MONTH(loc_dDataLan), 2, "0") + ;
                                     PADL(YEAR(loc_dDataLan), 4, "0")
                    ENDIF

                    loc_cHistsRaw  = TratarNulo(cursor_4c_MvCcr.Hists, "")
                    loc_cHist2sRaw = TratarNulo(cursor_4c_MvCcr.Hist2s, "")

                    loc_cHists = LEFT(loc_cHistsRaw + loc_cHist2sRaw, 70)
                    loc_cHists = STRTRAN(loc_cHists, CHR(1), "")
                    loc_cHists = STRTRAN(loc_cHists, CHR(13), "")
                    loc_cHists = STRTRAN(loc_cHists, CHR(10), "")

                    *-- SigMvCcr.Autos eh coluna `bit`: chega ao VFP ora como
                    *-- Logico, ora como Numerico, conforme o driver ODBC.
                    *-- Comparar/conjugar direto com AND estoura
                    *-- "Data type mismatch" quando vem Numerico - por isso o
                    *-- ConverterParaLogico (regra #13).
                    IF ConverterParaLogico(cursor_4c_MvCcr.Autos) AND "LOTE" $ loc_cHistsRaw
                        loc_cDocto = TRANSFORM(VAL(RIGHT(ALLTRIM(loc_cHistsRaw), 6)), "@L 9999999999")
                    ELSE
                        loc_cDocto = TRANSFORM(loc_nTotal, "@L 999999")
                    ENDIF

                    SELECT cursor_4c_MovAux
                    APPEND BLANK
                    REPLACE AnoFis  WITH loc_cAnoFis, ;
                            Datas   WITH loc_cDatas, ;
                            Contas  WITH loc_cContabs, ;
                            Debs    WITH TRANSFORM(loc_nDebs * 100, "@L 999999999999"), ;
                            Creds   WITH TRANSFORM(loc_nCreds * 100, "@L 999999999999"), ;
                            Docto   WITH loc_cDocto, ;
                            Hists   WITH loc_cHists, ;
                            EmpCont WITH cursor_4c_MvCcr.Emps

                    SELECT cursor_4c_MvCcr
                ENDSCAN

                THIS.this_nTotalRegistros = loc_nTotal

                IF USED("cursor_4c_Cli")
                    USE IN cursor_4c_Cli
                ENDIF
                IF USED("cursor_4c_Gcr")
                    USE IN cursor_4c_Gcr
                ENDIF
                IF USED("cursor_4c_MvCcr")
                    USE IN cursor_4c_MvCcr
                ENDIF

                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao processar integra" + CHR(231) + CHR(227) + "o cont" + CHR(225) + "bil: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarArquivoContabil - grava o arquivo texto de integracao contabil
    * (formato fixo, equivalente ao "Copy To ... Type SDF" do metodo
    * "gravar" do SCX legado), um arquivo por empresa (cursor_4c_MovAux.
    * EmpCont), nomeado "CT<sufixo unico>.<empresa>" dentro do diretorio
    * carregado por CarregarParametros(). Requer que Processar() tenha
    * rodado e populado cursor_4c_MovAux.
    *--------------------------------------------------------------------------
    FUNCTION GerarArquivoContabil()
        LOCAL loc_lResultado, loc_cDiretorio, loc_cEmpAnterior, loc_cNomeArquivo, loc_cLinha, ;
              loc_cConteudo, loc_nArquivosGerados, loc_oErro

        THIS.this_cMensagemErro = ""
        loc_lResultado = .F.

        IF !USED("cursor_4c_MovAux") OR RECCOUNT("cursor_4c_MovAux") = 0
            THIS.this_cMensagemErro = "N" + CHR(227) + "o Existe Movimenta" + CHR(231) + CHR(227) + "o no Per" + CHR(237) + "odo."
            RETURN .F.
        ENDIF

        loc_cDiretorio = ALLTRIM(TratarNulo(THIS.this_cDiretorioContabil, ""))
        IF EMPTY(loc_cDiretorio)
            THIS.this_cMensagemErro = "Diret" + CHR(243) + "rio de integra" + CHR(231) + CHR(227) + "o cont" + CHR(225) + ;
                "bil n" + CHR(227) + "o configurado (SigCdPam.DirContabv)."
            RETURN .F.
        ENDIF
        loc_cDiretorio = ADDBS(loc_cDiretorio)

        TRY
            SELECT cursor_4c_MovAux
            SET ORDER TO TAG EmpCont
            GO TOP

            loc_nArquivosGerados = 0
            loc_cEmpAnterior = ""
            loc_cConteudo    = ""
            loc_cNomeArquivo = ""

            SCAN
                IF cursor_4c_MovAux.EmpCont != loc_cEmpAnterior
                    IF !EMPTY(loc_cConteudo) AND !EMPTY(loc_cNomeArquivo)
                        STRTOFILE(loc_cConteudo, loc_cNomeArquivo)
                        loc_nArquivosGerados = loc_nArquivosGerados + 1
                    ENDIF

                    loc_cEmpAnterior = cursor_4c_MovAux.EmpCont
                    loc_cNomeArquivo = loc_cDiretorio + "CT" + SUBSTR(SYS(3), 3) + "." + ALLTRIM(loc_cEmpAnterior)
                    loc_cConteudo    = ""
                ENDIF

                *-- Larguras IGUAIS as do CREATE CURSOR de Processar - eh o que
                *-- o "Copy To ... Type SDF" do legado produz.
                loc_cLinha = PADR(cursor_4c_MovAux.AnoFis, 4) + ;
                             PADR(cursor_4c_MovAux.Datas, 8) + ;
                             PADR(cursor_4c_MovAux.Contas, 9) + ;
                             PADR(cursor_4c_MovAux.Debs, 12) + ;
                             PADR(cursor_4c_MovAux.Creds, 12) + ;
                             PADR(cursor_4c_MovAux.Docto, 10) + ;
                             PADR(cursor_4c_MovAux.Hists, 70) + ;
                             PADR(cursor_4c_MovAux.EmpCont, 3)

                loc_cConteudo = loc_cConteudo + loc_cLinha + CHR(13) + CHR(10)
            ENDSCAN

            IF !EMPTY(loc_cConteudo) AND !EMPTY(loc_cNomeArquivo)
                STRTOFILE(loc_cConteudo, loc_cNomeArquivo)
                loc_nArquivosGerados = loc_nArquivosGerados + 1
            ENDIF

            IF loc_nArquivosGerados = 0
                THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar o arquivo de integra" + CHR(231) + CHR(227) + "o cont" + CHR(225) + "bil."
                loc_lResultado = .F.
            ELSE
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao gerar arquivo de integra" + CHR(231) + CHR(227) + "o cont" + CHR(225) + "bil: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE

