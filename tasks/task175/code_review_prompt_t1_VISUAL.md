# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (5)
- [GRID-WITH] Bloco WITH THIS.grd_4c_Dados define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Dados.RecordSource).
- [GRID-HEADER] Header Caption ' Conta' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Conta, Nome, Email, Mensagem, . Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption ' Nome' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Conta, Nome, Email, Mensagem, . Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption ' Conta' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Conta, Nome, Email, Mensagem, . Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption ' Nome' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Conta, Nome, Email, Mensagem, . Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrEml.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1133 linhas total):

*-- Linhas 146 a 204:
146:         *-- Reforca dimensoes canonicas do SCX original
147:         THIS.Width   = 1000
148:         THIS.Height  = 600
149:         THIS.Caption = "ALERTA - Email"
150:     ENDPROC
151: 
152:     *--------------------------------------------------------------------------
153:     * ConfigurarCabecalho - Cria cnt_4c_Sombra com labels de titulo
154:     * Ref SCX: SIGPREML.cntSombra - Top=0, Left=-1, Width=1004, Height=80
155:     *          BackColor=RGB(100,100,100) (cinza medio do framework)
156:     *--------------------------------------------------------------------------
157:     PROTECTED PROCEDURE ConfigurarCabecalho()
158:         THIS.AddObject("cnt_4c_Sombra", "Container")
159:         WITH THIS.cnt_4c_Sombra
160:             .Top         = 0
161:             .Left        = -1
162:             .Width       = 1004
163:             .Height      = 80
164:             .BorderWidth = 0
165:             .BackColor   = RGB(100, 100, 100)
166:             .BackStyle   = 1
167: 
168:             *-- Label sombra: deslocado +1px, ForeColor preto (cria efeito 3D)
169:             .AddObject("lbl_4c_LblSombra", "Label")
170:             WITH .lbl_4c_LblSombra
171:                 .FontBold    = .T.
172:                 .FontName    = "Tahoma"
173:                 .FontSize    = 18
174:                 .WordWrap    = .T.
175:                 .Alignment   = 0
176:                 .BackStyle   = 0
177:                 .AutoSize    = .F.
178:                 .Caption     = "ALERTA - Email"
179:                 .Height      = 40
180:                 .Left        = 10
181:                 .Top         = 18
182:                 .Width       = THIS.Width
183:                 .ForeColor   = RGB(0, 0, 0)
184:             ENDWITH
185: 
186:             *-- Label titulo: ForeColor branco (visivel sobre cinza)
187:             .AddObject("lbl_4c_LblTitulo", "Label")
188:             WITH .lbl_4c_LblTitulo
189:                 .FontBold    = .T.
190:                 .FontName    = "Tahoma"
191:                 .FontSize    = 18
192:                 .WordWrap    = .T.
193:                 .Alignment   = 0
194:                 .BackStyle   = 0
195:                 .AutoSize    = .F.
196:                 .Caption     = "ALERTA - Email"
197:                 .Height      = 46
198:                 .Left        = 10
199:                 .Top         = 17
200:                 .Width       = THIS.Width
201:                 .ForeColor   = RGB(255, 255, 255)
202:             ENDWITH
203:         ENDWITH
204:     ENDPROC

*-- Linhas 217 a 240:
217:             .BackStyle     = 0
218:             .BorderStyle   = 0
219:             .Height        = 85
220:             .Left          = 918
221:             .SpecialEffect = 1
222:             .Top           = -2
223:             .Width         = 85
224:             .Themes        = .F.
225: 
226:             WITH .Buttons(1)
227:                 .Top         = 5
228:                 .Left        = 5
229:                 .Height      = 75
230:                 .Width       = 75
231:                 .FontBold    = .T.
232:                 .FontItalic  = .T.
233:                 .Picture     = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
234:                 .Cancel      = .T.
235:                 .Caption     = "Encerrar"
236:                 .ToolTipText = "[Esc] Encerrar"
237:                 .ForeColor   = RGB(90, 90, 90)
238:                 .BackColor   = RGB(255, 255, 255)
239:                 .Themes      = .F.
240:             ENDWITH

*-- Linhas 276 a 297:
276: 
277:     *--------------------------------------------------------------------------
278:     * AtualizarEstadoControles - Override: form OPERACIONAL sem modos CRUD
279:     *--------------------------------------------------------------------------
280:     PROCEDURE AtualizarEstadoControles()
281:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
282:             THIS.grd_4c_Dados.Refresh()
283:         ENDIF
284:     ENDPROC
285: 
286:     *--------------------------------------------------------------------------
287:     * Destroy - Libera cursores de trabalho e recursos
288:     *--------------------------------------------------------------------------
289:     PROCEDURE Destroy()
290:         *-- Fechar cursores de trabalho (com TABLEREVERT se cursor editavel)
291:         IF USED("cursor_4c_Dados")
292:             TABLEREVERT(.T., "cursor_4c_Dados")
293:             USE IN cursor_4c_Dados
294:         ENDIF
295:         IF USED("cursor_4c_MvCab")
296:             USE IN cursor_4c_MvCab
297:         ENDIF

*-- Linhas 357 a 391:
357:         *-- Shape1: decoracao visual ao redor da area de botoes de acao
358:         THIS.AddObject("shp_4c_Shape1", "Shape")
359:         WITH THIS.shp_4c_Shape1
360:             .Top           = -2
361:             .Left          = 819
362:             .Width         = 84
363:             .Height        = 84
364:             .BackStyle     = 0
365:             .BorderStyle   = 0
366:             .BorderWidth   = 1
367:             .SpecialEffect = 1
368:         ENDWITH
369: 
370:         *-- Ajustar ColumnOrder, ReadOnly e larguras conforme SCX original
371:         *-- Column5 = Checks: visual mais a esquerda (ColumnOrder=1)
372:         *-- Column1 = Conta: segunda visual (ColumnOrder=2)
373:         *-- Column2 = Nome: terceira visual (ColumnOrder=3)
374:         *-- Column3 = Email: quarta visual, editavel (ColumnOrder=4)
375:         *-- Column4 = Mensagem: quinta visual, readonly (ColumnOrder=5)
376:         WITH THIS.grd_4c_Dados
377:             WITH .Column5
378:                 .ColumnOrder = 1
379:                 .Width       = 17
380:                 .ReadOnly    = .F.
381:             ENDWITH
382:             WITH .Column1
383:                 .ColumnOrder = 2
384:                 .Width       = 80
385:                 .ReadOnly    = .T.
386:             ENDWITH
387:             WITH .Column2
388:                 .ColumnOrder = 3
389:                 .Width       = 290
390:                 .ReadOnly    = .T.
391:             ENDWITH

*-- Linhas 409 a 437:
409:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
410:         RETURN .F.
411:     ENDPROC
412: 
413:     *--------------------------------------------------------------------------
414:     * ConfigurarGrade - Cria grd_4c_Dados (grade_alerta do SCX)
415:     * Ref SCX: SIGPREML.grade_alerta Top=132 Left=3 Width=993 Height=435
416:     * 5 colunas: Conta | Nome | Email | Mensagem(EditBox) | Checks (checkbox)
417:     * Index tags: Contas, Rclis, Emails (criados pelo BO em CarregarAlertasEmail)
418:     *--------------------------------------------------------------------------
419:     PROTECTED PROCEDURE ConfigurarGrade()
420:         LOCAL loc_oGrid
421:         THIS.AddObject("grd_4c_Dados", "Grid")
422:         loc_oGrid = THIS.grd_4c_Dados
423:         WITH loc_oGrid
424:             .Top                = 132
425:             .Left               = 3
426:             .Width              = 993
427:             .Height             = 435
428:             .FontName           = "Verdana"
429:             .FontSize           = 8
430:             .ForeColor          = RGB(90, 90, 90)
431:             .BackColor          = RGB(255, 255, 255)
432:             .GridLineColor      = RGB(238, 238, 238)
433:             .HighlightBackColor = RGB(255, 255, 255)
434:             .HighlightForeColor = RGB(15, 41, 104)
435:             .HighlightStyle     = 2
436:             .RecordMark         = .F.
437:             .DeleteMark         = .F.

*-- Linhas 447 a 455:
447:                 .Width            = 90
448:                 .ReadOnly         = .T.
449:                 .ControlSource    = "cursor_4c_Dados.Contas"
450:                 .Header1.Caption  = " Conta"
451:                 .Header1.BackColor = RGB(192, 192, 192)
452:                 .Header1.FontName = "Verdana"
453:                 .Header1.FontSize = 8
454:                 .Header1.Alignment = 2
455:             ENDWITH

*-- Linhas 461 a 469:
461:                 .Width            = 200
462:                 .ReadOnly         = .T.
463:                 .ControlSource    = "cursor_4c_Dados.Rclis"
464:                 .Header1.Caption  = " Nome"
465:                 .Header1.BackColor = RGB(192, 192, 192)
466:                 .Header1.FontName = "Verdana"
467:                 .Header1.FontSize = 8
468:                 .Header1.Alignment = 2
469:             ENDWITH

*-- Linhas 475 a 483:
475:                 .Width            = 230
476:                 .ReadOnly         = .F.
477:                 .ControlSource    = "cursor_4c_Dados.emails"
478:                 .Header1.Caption  = "Email"
479:                 .Header1.BackColor = RGB(192, 192, 192)
480:                 .Header1.FontName = "Verdana"
481:                 .Header1.FontSize = 8
482:                 .Header1.Alignment = 2
483:             ENDWITH

*-- Linhas 489 a 497:
489:                 .FontSize         = 8
490:                 .Width            = 390
491:                 .ReadOnly         = .T.
492:                 .Header1.Caption  = "Mensagem"
493:                 .Header1.BackColor = RGB(192, 192, 192)
494:                 .Header1.FontName = "Verdana"
495:                 .Header1.FontSize = 8
496:                 .Header1.Alignment = 2
497:                 .AddObject("EditBox1", "EditBox")

*-- Linhas 509 a 528:
509:                 .Sparse          = .F.
510:             ENDWITH
511: 
512:             *-- Column5: Checks - checkbox de selecao (SCX Column6 - header vazio)
513:             *-- REGRA: AddObject ANTES de CurrentControl; ControlSource na Column, NAO no Check1
514:             WITH .Column5
515:                 .Width            = 40
516:                 .Alignment        = 2
517:                 .Header1.Caption  = ""
518:                 .Header1.BackColor = RGB(192, 192, 192)
519:                 .Header1.FontName = "Verdana"
520:                 .Header1.FontSize = 8
521:                 .AddObject("Check1", "CheckBox")
522:                 WITH .Check1
523:                     .Caption   = ""
524:                     .BackStyle = 0
525:                     .ForeColor = RGB(90, 90, 90)
526:                     .Value     = 0
527:                 ENDWITH
528:                 .CurrentControl  = "Check1"

*-- Linhas 545 a 601:
545:     * REGRA: botoes icone-only (Caption="") NAO recebem .Enabled=.F. em runtime
546:     *--------------------------------------------------------------------------
547:     PROTECTED PROCEDURE ConfigurarBotoesOpe()
548:         *-- cmd_4c_SelTudo: Selecionar todos os destinatarios
549:         THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
550:         WITH THIS.cmd_4c_SelTudo
551:             .Top             = 90
552:             .Left            = 4
553:             .Width           = 40
554:             .Height          = 40
555:             .Caption         = ""
556:             .ToolTipText     = "Selecionar Todos"
557:             .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
558:             .Themes          = .T.
559:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
560:             .FontName        = "Tahoma"
561:             .FontSize        = 8
562:             .ForeColor       = RGB(90, 90, 90)
563:             .BackColor       = RGB(255, 255, 255)
564:             .SpecialEffect   = 0
565:         ENDWITH
566:         BINDEVENT(THIS.cmd_4c_SelTudo, "Click", THIS, "CmdSelTudoClick")
567: 
568:         *-- cmd_4c_Apaga: Desmarcar todos os destinatarios
569:         THIS.AddObject("cmd_4c_Apaga", "CommandButton")
570:         WITH THIS.cmd_4c_Apaga
571:             .Top             = 90
572:             .Left            = 43
573:             .Width           = 40
574:             .Height          = 40
575:             .Caption         = ""
576:             .ToolTipText     = "Desmarcar Todos"
577:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
578:             .Themes          = .T.
579:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
580:             .FontName        = "Tahoma"
581:             .FontSize        = 8
582:             .ForeColor       = RGB(90, 90, 90)
583:             .BackColor       = RGB(255, 255, 255)
584:             .SpecialEffect   = 0
585:         ENDWITH
586:         BINDEVENT(THIS.cmd_4c_Apaga, "Click", THIS, "CmdApagaClick")
587: 
588:         *-- cmd_4c_BtnEmail: Enviar email para destinatarios selecionados
589:         *-- Ref SCX: btnEmail class=fwbtnp Top=3 Left=848 W=75 H=75
590:         THIS.AddObject("cmd_4c_BtnEmail", "CommandButton")
591:         WITH THIS.cmd_4c_BtnEmail
592:             .Top             = 3
593:             .Left            = 848
594:             .Width           = 75
595:             .Height          = 75
596:             .Caption         = "Enviar Email"
597:             .ToolTipText     = "Enviar email para destinat" + CHR(225) + "rios selecionados"
598:             .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
599:             .Themes          = .T.
600:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
601:             .FontBold        = .T.

*-- Linhas 609 a 617:
609:             .MousePointer    = 15
610:             .WordWrap        = .T.
611:         ENDWITH
612:         BINDEVENT(THIS.cmd_4c_BtnEmail, "Click", THIS, "CmdBtnEmailClick")
613:     ENDPROC
614: 
615:     *--------------------------------------------------------------------------
616:     * CarregarDados - Chama BO para popular cursor_4c_Dados e vincula ao grid
617:     * BO.CarregarAlertasEmail cria cursor_4c_Dados com tags Contas/Rclis/Emails

*-- Linhas 625 a 698:
625:                 THIS.this_cPrDopes, ;
626:                 THIS.this_cEscolha, ;
627:                 ga_4c_SigPrEmlOpeBaixa)
628: 
629:             IF loc_lResultado AND USED("cursor_4c_Dados")
630:                 WITH THIS.grd_4c_Dados
631:                     .ColumnCount  = 5
632:                     .RecordSource = "cursor_4c_Dados"
633: 
634:                     *-- Reconfigurar apos RecordSource (VFP reseta headers)
635:                     .Column1.ControlSource    = "cursor_4c_Dados.Contas"
636:                     .Column1.Header1.Caption  = " Conta"
637:                     .Column2.ControlSource    = "cursor_4c_Dados.Rclis"
638:                     .Column2.Header1.Caption  = " Nome"
639:                     .Column3.ControlSource    = "cursor_4c_Dados.emails"
640:                     .Column3.Header1.Caption  = "Email"
641:                     .Column4.CurrentControl   = "EditBox1"
642:                     .Column4.ControlSource    = "cursor_4c_Dados.mensagems"
643:                     .Column4.Header1.Caption  = "Mensagem"
644:                     .AddObject("Check1", "CheckBox")
645:                     .Check1.Caption = ""
646:                     .Column5.CurrentControl   = "Check1"
647:                     .Column5.ControlSource    = "cursor_4c_Dados.Checks"
648:                     .Column5.Header1.Caption  = ""
649:                 ENDWITH
650:                 THIS.grd_4c_Dados.Refresh()
651:                 THIS.GrdColNomeClick()
652:             ENDIF
653:         CATCH TO loc_oErro
654:             MsgErro("Erro ao carregar destinat" + CHR(225) + "rios:" + CHR(13) + ;
655:                     loc_oErro.Message, "Erro")
656:         ENDTRY
657: 
658:         RETURN loc_lResultado
659:     ENDPROC
660: 
661:     *--------------------------------------------------------------------------
662:     * CmdSelTudoClick - Marca Checks=1 em todos os registros do cursor
663:     *--------------------------------------------------------------------------
664:     PROCEDURE CmdSelTudoClick()
665:         IF USED("cursor_4c_Dados")
666:             SELECT cursor_4c_Dados
667:             GO TOP
668:             REPLACE ALL Checks WITH 1
669:             GO TOP
670:             THIS.grd_4c_Dados.Refresh()
671:         ENDIF
672:     ENDPROC
673: 
674:     *--------------------------------------------------------------------------
675:     * CmdApagaClick - Marca Checks=0 em todos os registros do cursor
676:     *--------------------------------------------------------------------------
677:     PROCEDURE CmdApagaClick()
678:         IF USED("cursor_4c_Dados")
679:             SELECT cursor_4c_Dados
680:             GO TOP
681:             REPLACE ALL Checks WITH 0
682:             GO TOP
683:             THIS.grd_4c_Dados.Refresh()
684:         ENDIF
685:     ENDPROC
686: 
687:     *--------------------------------------------------------------------------
688:     * CmdBtnEmailClick - Envia email para destinatarios com Checks=1
689:     * Replica logica de SIGPREML.btnEmail.Click (~139 linhas no SCX original)
690:     * Fluxo: verifica selecao -> busca config SMTP -> monta mensagem completa ->
691:     *        envia via SQL Server Database Mail -> registra historico em SigAlert ->
692:     *        envia segundo email para baixas -> fecha form
693:     *--------------------------------------------------------------------------
694:     PROCEDURE CmdBtnEmailClick()
695:         LOCAL loc_lResultado, loc_nSelecionados, loc_cSQL, loc_oErro, loc_oBO
696:         LOCAL loc_cReceptor, loc_cReceptorCopia, loc_cAssunto, loc_cTxtMensagem
697:         LOCAL loc_cJobDesc, loc_cClienteDesc, loc_cDescritivo, loc_cObses
698:         LOCAL loc_cMensagemAlerta, loc_cEscolhaDesc, loc_cPkNovo, loc_cTxtPrioridade

*-- Linhas 963 a 1016:
963:     PROCEDURE GrdColContaClick()
964:         IF USED("cursor_4c_Dados")
965:             SELECT cursor_4c_Dados
966:             SET ORDER TO TAG Contas
967:         ENDIF
968:         THIS.grd_4c_Dados.Column1.Header1.BackColor = RGB(64, 128, 128)
969:         THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(192, 192, 192)
970:         THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(192, 192, 192)
971:         THIS.grd_4c_Dados.Refresh()
972:     ENDPROC
973: 
974:     *--------------------------------------------------------------------------
975:     * GrdColNomeClick - Ordena grid por Nome/Rclis; destaca header ativo
976:     * Ref SCX: SIGPREML.grade_alerta.Column3.Header1.Click
977:     *--------------------------------------------------------------------------
978:     PROCEDURE GrdColNomeClick()
979:         IF USED("cursor_4c_Dados")
980:             SELECT cursor_4c_Dados
981:             SET ORDER TO TAG Rclis
982:         ENDIF
983:         THIS.grd_4c_Dados.Column1.Header1.BackColor = RGB(192, 192, 192)
984:         THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(64, 128, 128)
985:         THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(192, 192, 192)
986:         THIS.grd_4c_Dados.Refresh()
987:     ENDPROC
988: 
989:     *--------------------------------------------------------------------------
990:     * GrdColEmailClick - Ordena grid por Email; destaca header ativo
991:     * Ref SCX: SIGPREML.grade_alerta.Column4.Header1.Click
992:     *--------------------------------------------------------------------------
993:     PROCEDURE GrdColEmailClick()
994:         IF USED("cursor_4c_Dados")
995:             SELECT cursor_4c_Dados
996:             SET ORDER TO TAG Emails
997:         ENDIF
998:         THIS.grd_4c_Dados.Column1.Header1.BackColor = RGB(192, 192, 192)
999:         THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(192, 192, 192)
1000:         THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(64, 128, 128)
1001:         THIS.grd_4c_Dados.Refresh()
1002:     ENDPROC
1003: 
1004:     *--------------------------------------------------------------------------
1005:     * BtnIncluirClick - Form OPERACIONAL nao tem fluxo de inclusao CRUD
1006:     * SCX SIGPREML nao possui botao Incluir; destinatarios sao carregados
1007:     * automaticamente por CarregarDados via BO.CarregarAlertasEmail.
1008:     *--------------------------------------------------------------------------
1009:     PROCEDURE BtnIncluirClick()
1010:         RETURN .F.
1011:     ENDPROC
1012: 
1013:     *--------------------------------------------------------------------------
1014:     * BtnAlterarClick - Form OPERACIONAL nao tem fluxo de alteracao CRUD
1015:     * SCX SIGPREML nao possui botao Alterar; edicao de email/mensagem eh
1016:     * inline no grid (colunas com ReadOnly=.F.).

*-- Linhas 1031 a 1039:
1031:     *--------------------------------------------------------------------------
1032:     * BtnExcluirClick - Form OPERACIONAL nao tem fluxo de exclusao CRUD
1033:     * SCX SIGPREML nao possui botao Excluir; desmarcar destinatarios eh
1034:     * feito via cmd_4c_Apaga (CmdApagaClick) que zera todos os Checks.
1035:     *--------------------------------------------------------------------------
1036:     PROCEDURE BtnExcluirClick()
1037:         RETURN .F.
1038:     ENDPROC
1039: 

*-- Linhas 1113 a 1133:
1113:         IF USED("cursor_4c_Dados")
1114:             SELECT cursor_4c_Dados
1115:             GO TOP
1116:             REPLACE ALL Checks WITH 0
1117:             GO TOP
1118:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
1119:                 THIS.grd_4c_Dados.Refresh()
1120:             ENDIF
1121:         ENDIF
1122:     ENDPROC
1123: 
1124:     *--------------------------------------------------------------------------
1125:     * AjustarBotoesPorModo - Form OPERACIONAL sem botoes CRUD com modo variavel
1126:     * Metodo presente para compatibilidade com o pipeline de migracao
1127:     *--------------------------------------------------------------------------
1128:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1129:         *-- OPERACIONAL: sem botoes CRUD com aparencia por modo
1130:         RETURN .T.
1131:     ENDPROC
1132: 
1133: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrEmlBO.prg):
*==============================================================================
* SIGPREMLBO.PRG
* Business Object para Alerta de Email (SIGPREML)
* Entidade: SigAlert
* Tipo: OPERACIONAL
*==============================================================================

DEFINE CLASS SigPrEmlBO AS BusinessBase

    *-- Identificacao da entidade
    this_cTabela         = "SigAlert"
    this_cCampoChave     = "PkChaves"

    *-- Chave primaria
    this_cPkChaves       = ""

    *-- Campos principais de SigAlert
    this_cContas         = ""    && Conta do cliente C(10)
    this_cGrupos         = ""    && Grupo C(10)
    this_cEmps           = ""    && Empresa C(3)
    this_cDopes          = ""    && Operacao C(20)
    this_nNumes          = 0     && Numero N(6,0)
    this_cAcaos          = ""    && Acao C(10)
    this_cUsuars         = ""    && Usuario
    this_dDtAlerts       = {}    && Data/hora do alerta
    this_cMsg1s          = ""    && Mensagem 1 (texto)
    this_cMensagems      = ""    && Mensagem (memo)
    this_cEmails         = ""    && Email C(50)
    this_cPrioridade     = ""    && Prioridade C(15): URGENTE/IMPORTANTE/NORMAL
    this_cEmpDopNums     = ""    && Composto empresa+dope+numero C(29)
    this_nPriors         = 0     && Prioridade numerica N(1): 1=URGENTE,2=IMPORTANTE,3=NORMAL
    this_cRclis          = ""    && Nome do cliente C(30)

    *-- Parametros de contexto recebidos pelo form
    this_cPrDopes        = ""    && Parametro completo (empresa+dope+numero) C(29)
    this_cEmp            = ""    && Codigo da empresa (3 primeiros chars de PrDopes)
    this_cDope           = ""    && Codigo da operacao (chars 4-23 de PrDopes)
    this_cEscolha        = ""    && Escolha de acao: INSERIR/ALTERAR/EXCLUIR

    *-- Dados de email da empresa (lidos de SigCdEmp)
    this_cAleServs       = ""    && Servidor SMTP
    this_cAleEmails      = ""    && Email remetente
    this_cAleSenhas      = ""    && Senha do email
    this_nAlePortas      = 0     && Porta SMTP

    *-- Conexao secundaria para banco ALERTA (SigAlert)
    this_nConnAlerta     = 0

    *--------------------------------------------------------------------------
    * Init - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT("SigAlert")
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Destrutor
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF THIS.this_nConnAlerta > 0
            SQLDISCONNECT(THIS.this_nConnAlerta)
            THIS.this_nConnAlerta = 0
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarConexaoAlerta - Abre conexao com banco ALERTA
    *--------------------------------------------------------------------------
    PROCEDURE InicializarConexaoAlerta()
        LOCAL loc_lResultado, loc_cConnStr, loc_oErro
        loc_lResultado = .F.
        TRY
            loc_cConnStr = "DRIVER={SQL Server};" + ;
                           "SERVER=192.168.15.101;" + ;
                           "DATABASE=ALERTA;" + ;
                           "UID=sa;PWD=s@4control;"
            THIS.this_nConnAlerta = SQLSTRINGCONNECT(loc_cConnStr)
            IF THIS.this_nConnAlerta > 0
                SQLSETPROP(THIS.this_nConnAlerta, "DispWarnings", .F.)
                SQLSETPROP(THIS.this_nConnAlerta, "Asynchronous", .F.)
                loc_lResultado = .T.
            ELSE
                MsgErro("Imposs" + CHR(237) + "vel conectar ao banco ALERTA.", ;
                        "Erro de Conex" + CHR(227) + "o")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria do registro atual
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cPkChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor SigAlert
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cPkChaves    = TratarNulo(PkChaves,    "C")
                THIS.this_cContas      = TratarNulo(Contas,      "C")
                THIS.this_cGrupos      = TratarNulo(Grupos,      "C")
                THIS.this_cEmps        = TratarNulo(Emps,        "C")
                THIS.this_cDopes       = TratarNulo(Dopes,       "C")
                THIS.this_nNumes       = TratarNulo(Numes,       "N")
                THIS.this_cAcaos       = TratarNulo(Acaos,       "C")
                THIS.this_cUsuars      = TratarNulo(Usuars,      "C")
                THIS.this_cMsg1s       = TratarNulo(Msg1s,       "C")
                THIS.this_cMensagems   = TratarNulo(Mensagems,   "C")
                THIS.this_cEmails      = TratarNulo(Emails,      "C")
                THIS.this_cEmpDopNums  = TratarNulo(EmpDopNums,  "C")
                THIS.this_cRclis       = TratarNulo(Rclis,       "C")
                THIS.this_nPriors      = TratarNulo(Priors,      "N")
                IF THIS.this_nPriors = 1
                    THIS.this_cPrioridade = "URGENTE"
                ELSE
                    IF THIS.this_nPriors = 2
                        THIS.this_cPrioridade = "IMPORTANTE"
                    ELSE
                        THIS.this_cPrioridade = "NORMAL"
                    ENDIF
                ENDIF
                IF TYPE(par_cAliasCursor + ".DtAlerts") != "U"
                    THIS.this_dDtAlerts = TratarNulo(DtAlerts, "D")
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de Inserir/Atualizar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        IF EMPTY(THIS.this_cContas)
            MsgAviso("Conta n" + CHR(227) + "o informada.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cEmails)
            MsgAviso("Email n" + CHR(227) + "o informado.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cEmpDopNums)
            MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informada.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro em SigAlert (banco ALERTA)
    * Requer this_nConnAlerta ja inicializado via InicializarConexaoAlerta()
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            IF THIS.ValidarDados()
                THIS.this_cPkChaves = fUniqueIds()
                THIS.this_dDtAlerts = DATETIME()
                THIS.this_cEmps     = SUBSTR(THIS.this_cEmpDopNums, 1, 3)
                THIS.this_cDopes    = ALLTRIM(SUBSTR(THIS.this_cEmpDopNums, 4, 20))
                THIS.this_nNumes    = VAL(SUBSTR(THIS.this_cEmpDopNums, 24, 6))
                THIS.this_cUsuars   = gc_4c_UsuarioLogado

                loc_cSQL = "INSERT INTO SigAlert " + ;
                    "(PkChaves, Emps, Dopes, Numes, Contas, Grupos, Rclis, " + ;
                    "Emails, Mensagems, Msg1s, Priors, Acaos, " + ;
                    "Usuars, DtAlerts, EmpDopNums) VALUES (" + ;
                    EscaparSQL(THIS.this_cPkChaves) + ", " + ;
                    EscaparSQL(THIS.this_cEmps) + ", " + ;
                    EscaparSQL(THIS.this_cDopes) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nNumes) + ", " + ;
                    EscaparSQL(THIS.this_cContas) + ", " + ;
                    EscaparSQL(THIS.this_cGrupos) + ", " + ;
                    EscaparSQL(THIS.this_cRclis) + ", " + ;
                    EscaparSQL(THIS.this_cEmails) + ", " + ;
                    EscaparSQL(THIS.this_cMensagems) + ", " + ;
                    EscaparSQL(THIS.this_cMsg1s) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nPriors) + ", " + ;
                    EscaparSQL(THIS.this_cAcaos) + ", " + ;
                    EscaparSQL(THIS.this_cUsuars) + ", " + ;
                    "GETDATE(), " + ;
                    EscaparSQL(THIS.this_cEmpDopNums) + ")"

                IF SQLEXEC(THIS.this_nConnAlerta, loc_cSQL) >= 1
                    THIS.RegistrarAuditoria("INSERIR")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao registrar alerta de email no banco ALERTA.", "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro em SigAlert (banco ALERTA)
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            IF THIS.ValidarDados()
                THIS.this_cUsuars = gc_4c_UsuarioLogado

                loc_cSQL = "UPDATE SigAlert SET " + ;
                    "Contas = " + EscaparSQL(THIS.this_cContas) + ", " + ;
                    "Grupos = " + EscaparSQL(THIS.this_cGrupos) + ", " + ;
                    "Rclis = " + EscaparSQL(THIS.this_cRclis) + ", " + ;
                    "Emails = " + EscaparSQL(THIS.this_cEmails) + ", " + ;
                    "Mensagems = " + EscaparSQL(THIS.this_cMensagems) + ", " + ;
                    "Msg1s = " + EscaparSQL(THIS.this_cMsg1s) + ", " + ;
                    "Priors = " + FormatarNumeroSQL(THIS.this_nPriors) + ", " + ;
                    "Acaos = " + EscaparSQL(THIS.this_cAcaos) + ", " + ;
                    "Usuars = " + EscaparSQL(THIS.this_cUsuars) + ", " + ;
                    "EmpDopNums = " + EscaparSQL(THIS.this_cEmpDopNums) + " " + ;
                    "WHERE PkChaves = " + EscaparSQL(THIS.this_cPkChaves)

                IF SQLEXEC(THIS.this_nConnAlerta, loc_cSQL) >= 1
                    THIS.RegistrarAuditoria("ALTERAR")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao atualizar alerta de email.", "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro de SigAlert (banco ALERTA)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM SigAlert WHERE PkChaves = " + ;
                EscaparSQL(THIS.this_cPkChaves)

            IF SQLEXEC(THIS.this_nConnAlerta, loc_cSQL) >= 1
                THIS.RegistrarAuditoria("EXCLUIR")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir alerta de email.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarAlertasEmail - Carrega lista de destinatarios para o cursor do form
    * Popula cursor_4c_Dados (estrutura identica a crLocalTotal do legado)
    * par_cPrDopes: empresa(3)+dope(20)+numero(6) concatenados
    * par_cEscolha: INSERIR | ALTERAR | EXCLUIR
    * par_laOpeBaixa: array de EmpDopNums de operacoes baixadas (ou .F. se nenhum)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarAlertasEmail(par_cPrDopes, par_cEscolha, par_laOpeBaixa)
        LOCAL loc_lResultado, loc_cSQL, loc_cDopes, loc_oErro
        LOCAL loc_cDope, loc_cEDN, loc_nX, loc_cConta, loc_cRclis
        loc_lResultado = .F.
        loc_cDope      = ""
        loc_cEDN       = ""
        TRY
            THIS.this_cPrDopes = par_cPrDopes
            THIS.this_cEscolha = par_cEscolha
            THIS.this_cEmp     = SUBSTR(par_cPrDopes, 1, 3)
            loc_cDopes         = ALLTRIM(SUBSTR(par_cPrDopes, 4, 20))

            SET NULL ON
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            CREATE CURSOR cursor_4c_Dados (Checks N(1) NULL, grupos C(10) NULL, ;
                Contas C(10) NULL, Rclis C(30) NULL, emails C(50) NULL, ;
                mensagems M NULL, prioridade C(15) NULL, ;
                EmpDopNums C(29) NULL, Acaos C(10) NULL)
            INDEX ON Contas TAG Contas
            INDEX ON Rclis  TAG Rclis
            INDEX ON emails TAG Emails
            SET NULL OFF

            *-- Buscar dados da movimentacao (cabecalho + cliente)
            IF USED("cursor_4c_MvCab")
                USE IN cursor_4c_MvCab
            ENDIF
            loc_cSQL = "SELECT a.EmpDopNums, a.Jobs, b.Rclis, a.ObsCabMovs, a.Obses " + ;
                       "FROM SigMvcab a INNER JOIN SigCdCli b ON a.Jobs = b.Iclis " + ;
                       "WHERE a.EmpDopNums = " + EscaparSQL(par_cPrDopes)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvCab") >= 1
                SELECT cursor_4c_MvCab
                GO TOP

                *-- Buscar alertas configurados em SigCdAle
                IF USED("cursor_4c_Ale")
                    USE IN cursor_4c_Ale
                ENDIF
                loc_cSQL = "SELECT 1 AS Checks, ALE.grupos, ALE.Contas, " + ;
                           "CLI.Rclis, CLI.emails, ALE.mensagems, " + ;
                           "CASE WHEN ALE.priors = 1 THEN 'URGENTE' " + ;
                           "WHEN ALE.priors = 2 THEN 'IMPORTANTE' " + ;
                           "ELSE 'NORMAL' END AS prioridade, " + ;
                           "ALE.datas, ALE.dtalts, ALE.pkchaves, ALE.priors, ALE.dopes, " + ;
                           "'" + par_cPrDopes + "' AS EmpDopNums " + ;
                           "FROM SigCdAle ALE " + ;
                           "INNER JOIN SigCdCli CLI ON ALE.Contas = CLI.Iclis " + ;
                           "WHERE ALE.Dopes = " + EscaparSQL(loc_cDopes) + " AND " + ;
                           IIF(par_cEscolha = "INSERIR", "ALE.inserirs = 1 ", ;
                           IIF(par_cEscolha = "ALTERAR", "ALE.alterars = 1 ", ;
                           IIF(par_cEscolha = "EXCLUIR", "ALE.excluirs = 1 ", "1 = 1 ")))
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ale") >= 1
                    *-- Filtrar por job e inserir em cursor_4c_Dados
                    SELECT cursor_4c_Ale
                    GO TOP
                    SCAN
                        IF USED("cursor_4c_ClJob")
                            USE IN cursor_4c_ClJob
                        ENDIF
                        loc_cSQL = "SELECT Jobs FROM SigClJob WHERE Iclis = '" + ;
                                   ALLTRIM(cursor_4c_Ale.Contas) + "'"
                        SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ClJob")
                        SELECT cursor_4c_ClJob
                        GO TOP
                        IF !EOF()
                            LOCATE FOR ALLTRIM(Jobs) = ALLTRIM(cursor_4c_MvCab.Jobs)
                            IF EOF()
                                SELECT cursor_4c_Ale
                                LOOP
                            ENDIF
                        ENDIF

                        SELECT cursor_4c_Dados
                        INSERT INTO cursor_4c_Dados ;
                            (Checks, grupos, Contas, Rclis, emails, ;
                             mensagems, prioridade, EmpDopNums, Acaos) ;
                            VALUES (cursor_4c_Ale.Checks, cursor_4c_Ale.grupos, ;
                                    cursor_4c_Ale.Contas, cursor_4c_Ale.Rclis, ;
                                    cursor_4c_Ale.emails, NVL(cursor_4c_Ale.mensagems, ""), ;
                                    cursor_4c_Ale.prioridade, par_cPrDopes, par_cEscolha)
                        SELECT cursor_4c_Ale
                    ENDSCAN
                ELSE
                    MsgErro("Falha ao buscar alertas configurados.", "Erro")
                ENDIF

                *-- Buscar destinatarios de SigCdPam (grupos de alerta parametrizados)
                IF USED("cursor_4c_Pam")
                    USE IN cursor_4c_Pam
                ENDIF
                loc_cSQL = "SELECT 0 AS Checks, CLI.grupos, CLI.iclis AS Contas, " + ;
                           "CLI.rclis, CLI.emails, '' AS prioridade " + ;
                           "FROM SigCdPam PAM " + ;
                           "INNER JOIN SigCdCli CLI ON CLI.grupos = PAM.grpadats"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam") >= 1
                    SELECT cursor_4c_Pam
                    GO TOP
                    SCAN
                        IF USED("cursor_4c_ClJob")
                            USE IN cursor_4c_ClJob
                        ENDIF
                        loc_cSQL = "SELECT Jobs FROM SigClJob WHERE Iclis = '" + ;
                                   ALLTRIM(cursor_4c_Pam.Contas) + "'"
                        SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ClJob")
                        SELECT cursor_4c_ClJob
                        GO TOP
                        IF !EOF()
                            LOCATE FOR ALLTRIM(Jobs) = ALLTRIM(cursor_4c_MvCab.Jobs)
                            IF EOF()
                                SELECT cursor_4c_Pam
                                LOOP
                            ENDIF
                        ENDIF

                        loc_cConta = cursor_4c_Pam.Contas
                        loc_cRclis = cursor_4c_Pam.Rclis
                        SELECT cursor_4c_Dados
                        LOCATE FOR ALLTRIM(cursor_4c_Dados.Contas) = ALLTRIM(loc_cConta) ;
                               AND ALLTRIM(cursor_4c_Dados.Rclis)  = ALLTRIM(loc_cRclis)
                        IF EOF()
                            INSERT INTO cursor_4c_Dados ;
                                (Checks, grupos, Contas, Rclis, emails, ;
                                 EmpDopNums, Acaos, prioridade) ;
                                VALUES (cursor_4c_Pam.Checks, "", loc_cConta, ;
                                        loc_cRclis, cursor_4c_Pam.emails, ;
                                        par_cPrDopes, par_cEscolha, "NORMAL")
                        ENDIF
                        SELECT cursor_4c_Pam
                    ENDSCAN
                ELSE
                    MsgErro("Falha ao buscar destinat" + CHR(225) + "rios de grupo.", "Erro")
                ENDIF

                *-- Processar operacoes de baixa (laOpeBaixa), se array valido
                IF TYPE("par_laOpeBaixa", 1) = "A"
                    FOR loc_nX = 1 TO ALEN(par_laOpeBaixa)
                        IF !EMPTY(par_laOpeBaixa(loc_nX))
                            IF EMPTY(loc_cDope)
                                loc_cDope = "('" + ALLTRIM(SUBSTR(par_laOpeBaixa(loc_nX), 4, 20)) + "'"
                                loc_cEDN  = "('" + ALLTRIM(par_laOpeBaixa(loc_nX)) + "'"
                            ELSE
                                loc_cDope = loc_cDope + ",'" + ALLTRIM(SUBSTR(par_laOpeBaixa(loc_nX), 4, 20)) + "'"
                                loc_cEDN  = loc_cEDN  + ",'" + ALLTRIM(par_laOpeBaixa(loc_nX)) + "'"
                            ENDIF
                        ENDIF
                    NEXT
                    IF !EMPTY(loc_cDope)
                        loc_cDope = loc_cDope + ") "
                        loc_cEDN  = loc_cEDN  + ") "
                        THIS.CarregarAlertasBaixa(par_cPrDopes, par_cEscolha, loc_cDope, loc_cEDN)
                    ENDIF
                ENDIF

                SELECT cursor_4c_Dados
                GO TOP
                loc_lResultado = .T.
            ELSE
                MsgErro("Falha ao buscar dados da movimenta" + CHR(231) + CHR(227) + "o.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarAlertasBaixa - Processa alertas de operacoes baixadas
    * Popula cursor_4c_OpeBaixa (usado pelo form no envio do segundo email)
    * par_cDope: lista IN de codigos de operacao ex: "('FRET','DESPA') "
    * par_cEDN:  lista IN de EmpDopNums    ex: "('001FRET  000001') "
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarAlertasBaixa(par_cPrDopes, par_cEscolha, par_cDope, par_cEDN)
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_OpeBaixa")
                USE IN cursor_4c_OpeBaixa
            ENDIF

            *-- Tentar buscar na ALERTA primeiro (alertas ja enviados para baixa)
            loc_cSQL = "SELECT TOP 1 Contas, Acaos, EmpDopNums, Emps, Dopes, Numes, " + ;
                       "SPACE(50) AS emails, SPACE(15) AS Prioridade, " + ;
                       "Msg1s AS Mensagems, 1 AS Checks " + ;
                       "FROM SigAlert WHERE EmpDopNums IN " + par_cEDN + ;
                       " AND Acaos = 'BAIXAR'"
            IF SQLEXEC(THIS.this_nConnAlerta, loc_cSQL, "cursor_4c_OpeBaixa") < 1
                *-- Fallback: buscar na SIGE via SigCdAle (baixas configuradas)
                loc_cSQL = "SELECT 1 AS Checks, ALE.grupos, ALE.Contas, " + ;
                           "CLI.Rclis, CLI.emails, ALE.mensagems, " + ;
                           "CASE WHEN ALE.priors = 1 THEN 'URGENTE' " + ;
                           "WHEN ALE.priors = 2 THEN 'IMPORTANTE' " + ;
                           "ELSE 'NORMAL' END AS prioridade, " + ;
                           "ALE.datas, ALE.dtalts, ALE.pkchaves, ALE.priors, ALE.dopes, " + ;
                           "SPACE(29) AS EmpDopNums, '" + par_cEscolha + "' AS Acaos " + ;
                           "FROM SigCdAle ALE " + ;
                           "INNER JOIN SigCdCli CLI ON ALE.Contas = CLI.Iclis " + ;
                           "WHERE ALE.Dopes IN " + par_cDope + " AND ALE.baixas = 1"
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeBaixa")
            ENDIF

            IF USED("cursor_4c_OpeBaixa")
                *-- Buscar emails e prioridade para cada conta
                SELECT cursor_4c_OpeBaixa
                GO TOP
                SCAN
                    IF USED("cursor_4c_CliEmail")
                        USE IN cursor_4c_CliEmail
                    ENDIF
                    loc_cSQL = "SELECT a.Emails, " + ;
                               "CASE WHEN b.priors = 1 THEN 'URGENTE' " + ;
                               "WHEN b.priors = 2 THEN 'IMPORTANTE' " + ;
                               "ELSE 'NORMAL' END AS prioridade, b.mensagems " + ;
                               "FROM SigCdCli a INNER JOIN SigCdAle b ON a.Iclis = b.Contas " + ;
                               "WHERE a.Iclis = '" + ALLTRIM(cursor_4c_OpeBaixa.Contas) + ;
                               "' AND b.Dopes = '" + ALLTRIM(cursor_4c_OpeBaixa.Dopes) + "'"
                    SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliEmail")
                    IF USED("cursor_4c_CliEmail") AND !EOF("cursor_4c_CliEmail")
                        SELECT cursor_4c_OpeBaixa
                        REPLACE emails     WITH cursor_4c_CliEmail.Emails
                        REPLACE prioridade WITH cursor_4c_CliEmail.prioridade
                        REPLACE mensagems  WITH cursor_4c_CliEmail.mensagems
                    ENDIF
                    SELECT cursor_4c_OpeBaixa
                ENDSCAN
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarConfigEmailEmpresa - Busca config SMTP de SigCdEmp
    * Popula this_cAleServs, this_cAleEmails, this_cAleSenhas, this_nAlePortas
    *--------------------------------------------------------------------------
    PROCEDURE BuscarConfigEmailEmpresa()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_ConfigEmail")
                USE IN cursor_4c_ConfigEmail
            ENDIF
            loc_cSQL = "SELECT AleServs, AleEmails, AleSenhas, AlePortas " + ;
                       "FROM SigCdEmp WHERE CEmps = '" + ALLTRIM(THIS.this_cEmp) + "'"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConfigEmail") >= 1
                SELECT cursor_4c_ConfigEmail
                IF !EOF()
                    THIS.this_cAleServs  = ALLTRIM(TratarNulo(AleServs,  "C"))
                    THIS.this_cAleEmails = ALLTRIM(TratarNulo(AleEmails, "C"))
                    THIS.this_cAleSenhas = ALLTRIM(TratarNulo(AleSenhas, "C"))
                    THIS.this_nAlePortas = TratarNulo(AlePortas, "N")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Configura" + CHR(231) + CHR(227) + "o de email n" + CHR(227) + ;
                            "o encontrada para empresa '" + ALLTRIM(THIS.this_cEmp) + "'.", "Erro")
                ENDIF
            ELSE
                MsgErro("Falha ao buscar configura" + CHR(231) + CHR(227) + "o de email.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * InserirAlertaHistoricoItem - Insere UM registro em SigAlert (banco ALERTA)
    * Chamado pelo form para cada destinatario selecionado no grid
    * par_cMsg1s:     texto completo da mensagem montada pelo form
    * par_cEmpDopNums: empresa(3)+dope(20)+numero(6) concatenados
    * par_cAcaos:     INSERIR | ALTERAR | EXCLUIR | BAIXAR
    * par_cPrioridade: URGENTE | IMPORTANTE | NORMAL
    *--------------------------------------------------------------------------
    PROCEDURE InserirAlertaHistoricoItem(par_cPkChaves, par_cMsg1s, par_cContas, ;
                                         par_cRclis, par_cEmails, par_cMensagems, ;
                                         par_cEmpDopNums, par_cAcaos, par_cPrioridade)
        LOCAL loc_lResultado, loc_cSQL, loc_nPriors, loc_oErro
        loc_lResultado = .F.
        TRY
            DO CASE
                CASE ALLTRIM(par_cPrioridade) = "URGENTE"
                    loc_nPriors = 1
                CASE ALLTRIM(par_cPrioridade) = "IMPORTANTE"
                    loc_nPriors = 2
                OTHERWISE
                    loc_nPriors = 3
            ENDCASE

            loc_cSQL = "INSERT INTO SigAlert " + ;
                "(PkChaves, Emps, Dopes, Numes, Contas, Grupos, Rclis, " + ;
                "Emails, Mensagems, Msg1s, Priors, Acaos, Usuars, DtAlerts, EmpDopNums) " + ;
                "VALUES (" + ;
                EscaparSQL(par_cPkChaves) + ", " + ;
                EscaparSQL(SUBSTR(par_cEmpDopNums, 1, 3)) + ", " + ;
                EscaparSQL(ALLTRIM(SUBSTR(par_cEmpDopNums, 4, 20))) + ", " + ;
                FormatarNumeroSQL(VAL(SUBSTR(par_cEmpDopNums, 24, 6))) + ", " + ;
                EscaparSQL(par_cContas) + ", " + ;
                EscaparSQL("") + ", " + ;
                EscaparSQL(par_cRclis) + ", " + ;
                EscaparSQL(par_cEmails) + ", " + ;
                EscaparSQL(par_cMensagems) + ", " + ;
                EscaparSQL(par_cMsg1s) + ", " + ;
                FormatarNumeroSQL(loc_nPriors) + ", " + ;
                EscaparSQL(par_cAcaos) + ", " + ;
                EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                "GETDATE(), " + ;
                EscaparSQL(par_cEmpDopNums) + ")"

            IF SQLEXEC(THIS.this_nConnAlerta, loc_cSQL) >= 1
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao registrar alerta no hist" + CHR(243) + "rico.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

