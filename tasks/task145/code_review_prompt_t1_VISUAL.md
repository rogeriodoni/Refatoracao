# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [GRID-WITH] Bloco WITH loc_oGrade define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrade.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPdMp4.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1468 linhas total):

*-- Linhas 91 a 104:
91:             THIS.LockScreen = .F.
92: 
93:             *-- Atualiza caption (igual ao Init original)
94:             THIS.Caption = "Desagregar Componentes "
95:             IF PEMSTATUS(THIS.cnt_4c_Sombra.lbl_4c_Sombra, "Caption", 5)
96:                 THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
97:             ENDIF
98:             IF PEMSTATUS(THIS.cnt_4c_Sombra.lbl_4c_Titulo, "Caption", 5)
99:                 THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
100:             ENDIF
101: 
102:             *-- Desabilita form pai enquanto este dialog esta aberto
103:             IF VARTYPE(THIS.this_oParentForm) = "O" AND !ISNULL(THIS.this_oParentForm)
104:                 THIS.this_oParentForm.Enabled = .F.

*-- Linhas 125 a 180:
125:         IF TYPE("gc_4c_CaminhoIcones") = "C"
126:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
127:         ENDIF
128:         THIS.Caption = "Desagregar Componentes Agregados"
129:     ENDPROC
130: 
131:     *--------------------------------------------------------------------------
132:     * ConfigurarCabecalho - cntSombra com labels de sombra e titulo
133:     * Original: cntSombra (Top=0, Left=0, Width=1100, Height=80, BackColor=100,100,100)
134:     *--------------------------------------------------------------------------
135:     PROTECTED PROCEDURE ConfigurarCabecalho()
136:         THIS.AddObject("cnt_4c_Sombra", "Container")
137:         WITH THIS.cnt_4c_Sombra
138:             .Top        = 0
139:             .Left       = 0
140:             .Width      = 1100
141:             .Height     = 80
142:             .BorderWidth = 0
143:             .BackStyle  = 1
144:             .BackColor  = RGB(100, 100, 100)
145:             .Visible    = .T.
146: 
147:             .AddObject("lbl_4c_Sombra", "Label")
148:             WITH .lbl_4c_Sombra
149:                 .FontBold   = .T.
150:                 .FontName   = "Tahoma"
151:                 .FontSize   = 18
152:                 .WordWrap   = .T.
153:                 .Alignment  = 0
154:                 .BackStyle  = 0
155:                 .Caption    = "Desagregar Componentes "
156:                 .Height     = 40
157:                 .Left       = 10
158:                 .Top        = 18
159:                 .Width      = THIS.Width
160:                 .ForeColor  = RGB(0, 0, 0)
161:                 .Visible    = .T.
162:             ENDWITH
163: 
164:             .AddObject("lbl_4c_Titulo", "Label")
165:             WITH .lbl_4c_Titulo
166:                 .FontBold   = .T.
167:                 .FontName   = "Tahoma"
168:                 .FontSize   = 18
169:                 .WordWrap   = .T.
170:                 .Alignment  = 0
171:                 .BackStyle  = 0
172:                 .Caption    = "Desagregar Componentes "
173:                 .Height     = 46
174:                 .Left       = 10
175:                 .Top        = 17
176:                 .Width      = THIS.Width
177:                 .ForeColor  = RGB(255, 255, 255)
178:                 .Visible    = .T.
179:             ENDWITH
180:         ENDWITH

*-- Linhas 188 a 197:
188:     PROTECTED PROCEDURE ConfigurarContainerOperacao()
189:         THIS.AddObject("cnt_4c_Operacao", "Container")
190:         WITH THIS.cnt_4c_Operacao
191:             .Top        = 104
192:             .Left       = 12
193:             .Width      = 378
194:             .Height     = 40
195:             .BackStyle  = 0
196:             .BorderWidth = 0
197:             .Visible    = .T.

*-- Linhas 206 a 234:
206:     PROTECTED PROCEDURE ConfigurarContainerIndicador()
207:         THIS.AddObject("cnt_4c_Indicador", "Container")
208:         WITH THIS.cnt_4c_Indicador
209:             .Top           = 126
210:             .Left          = 667
211:             .Width         = 324
212:             .Height        = 22
213:             .SpecialEffect = 2
214:             .BackStyle     = 1
215:             .BackColor     = RGB(245, 251, 136)
216:             .BorderColor   = RGB(219, 219, 219)
217:             .Visible       = .T.
218: 
219:             .AddObject("lbl_4c_DesagregaParcial", "Label")
220:             WITH .lbl_4c_DesagregaParcial
221:                 .AutoSize  = .T.
222:                 .FontBold  = .F.
223:                 .FontName  = "Tahoma"
224:                 .FontSize  = 8
225:                 .BackStyle = 0
226:                 .Caption   = "Desagrega Parcialmente"
227:                 .Height    = 15
228:                 .Left      = 92
229:                 .Top       = 4
230:                 .Width     = 118
231:                 .ForeColor = RGB(0, 0, 0)
232:                 .Visible   = .T.
233:             ENDWITH
234:         ENDWITH

*-- Linhas 272 a 281:
272:             BINDEVENT(THIS.grd_4c_Dados.Column11.Text1, "KeyPress", THIS, "Col11ValidarPesoFabr")
273:             BINDEVENT(THIS.grd_4c_Dados.Column11.Text1, "GotFocus", THIS, "Col11GotFocus")
274:         ENDIF
275:         IF VARTYPE(THIS.cmd_4c_Ok) = "O"
276:             BINDEVENT(THIS.cmd_4c_Ok, "Click", THIS, "BtnOkClick")
277:         ENDIF
278: 
279:         THIS.CarregarGrade()
280:     ENDPROC
281: 

*-- Linhas 301 a 310:
301:         loc_oGrade = THIS.grd_4c_Dados
302: 
303:         WITH loc_oGrade
304:             .Top              = 147
305:             .Left             = 9
306:             .Width            = 982
307:             .Height           = 417
308:             .ColumnCount      = 11
309:             .RecordMark       = .F.
310:             .DeleteMark       = .F.

*-- Linhas 329 a 337:
329:             .FontName    = "Courier New"
330:             .Format      = "L"
331:             .InputMask   = "9999999999"
332:             .Header1.Caption   = "Industrializa" + CHR(231) + CHR(227) + "o"
333:             .Header1.FontName  = "Verdana"
334:             .Header1.FontSize  = 8
335:             .Header1.Alignment = 2
336:             .Header1.ForeColor = RGB(36, 84, 155)
337:             .Text1.FontName    = "Courier New"

*-- Linhas 352 a 360:
352:             .Resizable   = .F.
353:             .ReadOnly    = .T.
354:             .FontSize    = 8
355:             .Header1.Caption   = "Componente"
356:             .Header1.FontName  = "Verdana"
357:             .Header1.FontSize  = 8
358:             .Header1.Alignment = 2
359:             .Header1.ForeColor = RGB(36, 84, 155)
360:             .Text1.BorderStyle = 0

*-- Linhas 372 a 380:
372:             .Movable     = .F.
373:             .Resizable   = .F.
374:             .ReadOnly    = .T.
375:             .Header1.Caption   = "Peso Fabr"
376:             .Header1.FontName  = "Verdana"
377:             .Header1.FontSize  = 8
378:             .Header1.Alignment = 2
379:             .Header1.ForeColor = RGB(36, 84, 155)
380:             .Text1.BorderStyle = 0

*-- Linhas 391 a 399:
391:             .Movable     = .F.
392:             .Resizable   = .F.
393:             .ReadOnly    = .T.
394:             .Header1.Caption   = "Unid."
395:             .Header1.FontName  = "Verdana"
396:             .Header1.FontSize  = 8
397:             .Header1.Alignment = 2
398:             .Header1.ForeColor = RGB(36, 84, 155)
399:             .Text1.BorderStyle = 0

*-- Linhas 410 a 418:
410:             .Movable     = .F.
411:             .Resizable   = .F.
412:             .ReadOnly    = .T.
413:             .Header1.Caption   = "Qtde"
414:             .Header1.FontName  = "Verdana"
415:             .Header1.FontSize  = 8
416:             .Header1.Alignment = 2
417:             .Header1.ForeColor = RGB(36, 84, 155)
418:             .Text1.BorderStyle = 0

*-- Linhas 429 a 437:
429:             .Movable     = .F.
430:             .Resizable   = .F.
431:             .ReadOnly    = .T.
432:             .Header1.Caption   = "Unid."
433:             .Header1.FontName  = "Verdana"
434:             .Header1.FontSize  = 8
435:             .Header1.Alignment = 2
436:             .Header1.ForeColor = RGB(36, 84, 155)
437:             .Text1.BorderStyle = 0

*-- Linhas 449 a 496:
449:             .Resizable   = .F.
450:             .ReadOnly    = .F.
451:             .BackColor   = RGB(245, 251, 136)
452:             .Header1.Caption   = "Qtde"
453:             .Header1.FontName  = "Verdana"
454:             .Header1.FontSize  = 8
455:             .Header1.Alignment = 2
456:             .Header1.ForeColor = RGB(36, 84, 155)
457:             .Header1.BackColor = RGB(245, 251, 136)
458:             .Text1.BorderStyle = 0
459:             .Text1.Margin      = 0
460:             .Text1.ReadOnly    = .F.
461:             .Text1.ForeColor   = RGB(0, 0, 0)
462:             .Text1.BackColor   = RGB(245, 251, 136)
463:         ENDWITH
464: 
465:         *-- Column8: CheckBox Marca (ColumnOrder=1, EDITAVEL)
466:         *-- ORDEM OBRIGATORIA: Sparse -> Header -> AddObject(Check1) -> Check1.Config -> CurrentControl
467:         WITH loc_oGrade.Column8
468:             .ColumnOrder = 1
469:             .Width       = 20
470:             .Movable     = .F.
471:             .Resizable   = .F.
472:             .ReadOnly    = .F.
473:             .Sparse      = .F.
474:             .Header1.Caption   = ""
475:             .Header1.FontName  = "Verdana"
476:             .Header1.ForeColor = RGB(36, 84, 155)
477:             .Header1.BackColor = RGB(36, 84, 155)
478:         ENDWITH
479:         loc_oGrade.Column8.AddObject("Check1", "CheckBox")
480:         loc_oGrade.Column8.Check1.Caption = ""
481:         loc_oGrade.Column8.Check1.Value   = 0
482:         loc_oGrade.Column8.CurrentControl = "Check1"
483: 
484:         *-- Column9: Peso original (ColumnOrder=6, ReadOnly)
485:         WITH loc_oGrade.Column9
486:             .ColumnOrder = 6
487:             .Width       = 100
488:             .Movable     = .F.
489:             .Resizable   = .F.
490:             .ReadOnly    = .T.
491:             .Header1.Caption   = "Peso"
492:             .Header1.FontName  = "Verdana"
493:             .Header1.FontSize  = 8
494:             .Header1.Alignment = 2
495:             .Header1.ForeColor = RGB(36, 84, 155)
496:             .Text1.BorderStyle = 0

*-- Linhas 507 a 515:
507:             .Resizable   = .F.
508:             .ReadOnly    = .F.
509:             .BackColor   = RGB(245, 251, 136)
510:             .Header1.Caption   = "Peso"
511:             .Header1.FontName  = "Verdana"
512:             .Header1.FontSize  = 8
513:             .Header1.Alignment = 2
514:             .Header1.ForeColor = RGB(36, 84, 155)
515:             .Header1.BackColor = RGB(245, 251, 136)

*-- Linhas 526 a 534:
526:             .Resizable   = .F.
527:             .ReadOnly    = .F.
528:             .BackColor   = RGB(245, 251, 136)
529:             .Header1.Caption   = "Peso Fabr"
530:             .Header1.FontName  = "Verdana"
531:             .Header1.FontSize  = 8
532:             .Header1.Alignment = 2
533:             .Header1.ForeColor = RGB(36, 84, 155)
534:             .Header1.BackColor = RGB(245, 251, 136)

*-- Linhas 560 a 568:
560:             .ColumnCount  = 11
561:             .RecordSource = "TmpDistrib"
562: 
563:             *-- ControlSources (Column8/CheckBox: APOS CurrentControl ja setado em ConfigurarGrade)
564:             .Column8.ControlSource  = "TmpDistrib.Marca"
565:             .Column1.ControlSource  = "TmpDistrib.Nops"
566:             .Column2.ControlSource  = "TmpDistrib.CMats"
567:             .Column5.ControlSource  = "TmpDistrib.Qtds"
568:             .Column4.ControlSource  = "TmpDistrib.CUnis"

*-- Linhas 580 a 600:
580:                     loc_cTitulo = ALLTRIM(THIS.this_oParentForm.Titulo)
581:                 ENDIF
582:             ENDIF
583:             .Column1.Header1.Caption = loc_cTitulo
584: 
585:             *-- Redefine cabecalhos obrigatorios apos RecordSource/ControlSource
586:             .Column2.Header1.Caption  = "Componente"
587:             .Column3.Header1.Caption  = "Peso Fabr"
588:             .Column4.Header1.Caption  = "Unid."
589:             .Column5.Header1.Caption  = "Qtde"
590:             .Column6.Header1.Caption  = "Unid."
591:             .Column7.Header1.Caption  = "Qtde"
592:             .Column8.Header1.Caption  = ""
593:             .Column9.Header1.Caption  = "Peso"
594:             .Column10.Header1.Caption = "Peso"
595:             .Column11.Header1.Caption = "Peso Fabr"
596: 
597:             .Refresh()
598:         ENDWITH
599: 
600:         *-- Preenche campos do rodape com dados do primeiro registro

*-- Linhas 621 a 707:
621:     *--------------------------------------------------------------------------
622:     PROTECTED PROCEDURE ConfigurarRodape()
623:         *-- Say2: "Descricao :" Top=573, Left=27
624:         THIS.AddObject("lbl_4c_Descricao", "Label")
625:         WITH THIS.lbl_4c_Descricao
626:             .FontName  = "Tahoma"
627:             .FontSize  = 8
628:             .BackStyle = 0
629:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
630:             .Left      = 27
631:             .Top       = 573
632:             .ForeColor = RGB(90, 90, 90)
633:             .AutoSize  = .T.
634:             .Visible   = .T.
635:         ENDWITH
636: 
637:         *-- Get_descr: exibicao descricao do componente, Top=569, Left=84, Width=335
638:         THIS.AddObject("txt_4c_Descr", "TextBox")
639:         WITH THIS.txt_4c_Descr
640:             .FontName  = "Tahoma"
641:             .FontSize  = 8
642:             .Left      = 84
643:             .Top       = 569
644:             .Width     = 335
645:             .Height    = 23
646:             .ForeColor = RGB(0, 0, 0)
647:             .ReadOnly  = .T.
648:             .Value     = ""
649:             .Visible   = .T.
650:         ENDWITH
651: 
652:         *-- Label3: "Cor :" Top=573, Left=435
653:         THIS.AddObject("lbl_4c_RotCor", "Label")
654:         WITH THIS.lbl_4c_RotCor
655:             .FontName  = "Tahoma"
656:             .FontSize  = 8
657:             .BackStyle = 0
658:             .Caption   = "Cor :"
659:             .Left      = 435
660:             .Top       = 573
661:             .ForeColor = RGB(90, 90, 90)
662:             .AutoSize  = .T.
663:             .Visible   = .T.
664:         ENDWITH
665: 
666:         *-- get_Cor: exibicao codigo de cor, Top=569, Left=463, Width=31
667:         THIS.AddObject("txt_4c_Cor", "TextBox")
668:         WITH THIS.txt_4c_Cor
669:             .FontName  = "Tahoma"
670:             .FontSize  = 8
671:             .Left      = 463
672:             .Top       = 569
673:             .Width     = 31
674:             .Height    = 23
675:             .Margin    = 0
676:             .ForeColor = RGB(0, 0, 0)
677:             .ReadOnly  = .T.
678:             .Value     = ""
679:             .Visible   = .T.
680:         ENDWITH
681: 
682:         *-- Label1: "Tamanho :" Top=573, Left=523
683:         THIS.AddObject("lbl_4c_RotTam", "Label")
684:         WITH THIS.lbl_4c_RotTam
685:             .FontName  = "Tahoma"
686:             .FontSize  = 8
687:             .BackStyle = 0
688:             .Caption   = "Tamanho :"
689:             .Left      = 523
690:             .Top       = 573
691:             .ForeColor = RGB(90, 90, 90)
692:             .AutoSize  = .T.
693:             .Visible   = .T.
694:         ENDWITH
695: 
696:         *-- get_Tam: exibicao codigo de tamanho, Top=569, Left=578, Width=31
697:         THIS.AddObject("txt_4c_Tam", "TextBox")
698:         WITH THIS.txt_4c_Tam
699:             .FontName  = "Tahoma"
700:             .FontSize  = 8
701:             .Left      = 578
702:             .Top       = 569
703:             .Width     = 31
704:             .Height    = 23
705:             .Margin    = 0
706:             .ForeColor = RGB(0, 0, 0)
707:             .ReadOnly  = .T.

*-- Linhas 715 a 729:
715:     * Original: Top=3, Left=925, Cancel=.T., Caption="\<OK"
716:     *--------------------------------------------------------------------------
717:     PROTECTED PROCEDURE ConfigurarBotaoOk()
718:         THIS.AddObject("cmd_4c_Ok", "CommandButton")
719:         WITH THIS.cmd_4c_Ok
720:             .Top             = 3
721:             .Left            = 925
722:             .Width           = 75
723:             .Height          = 75
724:             .Caption         = "\<OK"
725:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
726:             .Cancel          = .T.
727:             .FontName        = "Tahoma"
728:             .FontBold        = .T.
729:             .FontItalic      = .T.

*-- Linhas 935 a 962:
935:         loc_oContainer = THIS.cnt_4c_Operacao
936: 
937:         *-- Say1: "Movimentacao :" Left=17, Top=12
938:         loc_oContainer.AddObject("lbl_4c_Movimentacao", "Label")
939:         WITH loc_oContainer.lbl_4c_Movimentacao
940:             .FontName  = "Tahoma"
941:             .FontSize  = 8
942:             .BackStyle = 0
943:             .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
944:             .Left      = 17
945:             .Top       = 12
946:             .AutoSize  = .T.
947:             .ForeColor = RGB(90, 90, 90)
948:             .Visible   = .T.
949:         ENDWITH
950: 
951:         *-- GetEmpresa: empresa da operacao, Left=97, Top=8, Width=36 (ReadOnly)
952:         loc_oContainer.AddObject("txt_4c_Empresa", "TextBox")
953:         WITH loc_oContainer.txt_4c_Empresa
954:             .FontName          = "Tahoma"
955:             .FontSize          = 8
956:             .Left              = 97
957:             .Top               = 8
958:             .Width             = 36
959:             .Height            = 23
960:             .ForeColor         = RGB(0, 0, 0)
961:             .DisabledBackColor = RGB(255, 255, 255)
962:             .ReadOnly          = .T.

*-- Linhas 972 a 981:
972:         WITH loc_oContainer.txt_4c_Operacao
973:             .FontName          = "Tahoma"
974:             .FontSize          = 8
975:             .Left              = 135
976:             .Top               = 8
977:             .Width             = 156
978:             .Height            = 23
979:             .ForeColor         = RGB(0, 0, 0)
980:             .DisabledBackColor = RGB(255, 255, 255)
981:             .ReadOnly          = .T.

*-- Linhas 993 a 1002:
993:             .FontSize          = 8
994:             .Format            = "L"
995:             .InputMask         = "9999999999"
996:             .Left              = 293
997:             .Top               = 8
998:             .Width             = 81
999:             .Height            = 23
1000:             .ForeColor         = RGB(0, 0, 0)
1001:             .DisabledBackColor = RGB(255, 255, 255)
1002:             .ReadOnly          = .T.

*-- Linhas 1015 a 1024:
1015:     PROTECTED PROCEDURE ConfigurarShapeDecorativo()
1016:         THIS.AddObject("shp_4c_Decorativo", "Shape")
1017:         WITH THIS.shp_4c_Decorativo
1018:             .Top         = 10
1019:             .Left        = 897
1020:             .Width       = 90
1021:             .Height      = 110
1022:             .BackStyle   = 0
1023:             .BorderStyle = 0
1024:             .BorderColor = RGB(136, 189, 188)

*-- Linhas 1415 a 1424:
1415:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
1416:             THIS.grd_4c_Dados.Enabled = par_lHabilitar
1417:         ENDIF
1418:         IF VARTYPE(THIS.cmd_4c_Ok) = "O"
1419:             THIS.cmd_4c_Ok.Enabled = par_lHabilitar
1420:         ENDIF
1421:     ENDPROC
1422: 
1423:     *--------------------------------------------------------------------------
1424:     * LimparCampos - Zera todas as marcacoes e quantidades desagregadas

*-- Linhas 1460 a 1468:
1460:     * Garante que o botao OK permanece habilitado (unico modo: operacional).
1461:     *--------------------------------------------------------------------------
1462:     PROCEDURE AjustarBotoesPorModo()
1463:         IF VARTYPE(THIS.cmd_4c_Ok) = "O"
1464:             THIS.cmd_4c_Ok.Enabled = .T.
1465:         ENDIF
1466:     ENDPROC
1467: 
1468: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPdMp4BO.prg):
*-------------------------------------------------------------------------------
* SigPdMp4BO.prg - Business Object: Desagregar Componentes Agregados
* Herda de BusinessBase
* OPERACIONAL: Desagrega itens do cursor xNensi (producao) via TmpDistrib
*-------------------------------------------------------------------------------

DEFINE CLASS SigPdMp4BO AS BusinessBase

    *-- Dados do componente (campos do cursor TmpDistrib)
    this_lMarca       = .F.
    this_nNops        = 0
    this_nNenvs       = 0
    this_cCodPds      = ""
    this_cCMats       = ""
    this_cCUnis       = ""
    this_nQtds        = 0
    this_nPesos       = 0
    this_nPesofs      = 0
    this_cCDescs      = ""
    this_cCGrus       = ""
    this_cTpOps       = ""
    this_cCUniPs      = ""
    this_nQtd2s       = 0
    this_nPeso2s      = 0
    this_nPesof2s     = 0
    this_cCodCors     = ""
    this_cCodTams     = ""

    *-- Contexto do pedido de producao (xNensi)
    this_nRecnoAnt    = 0

    *-- Parametros operacionais lidos de crSigCdOpd
    this_nLibrPqs     = 0
    this_nGrOdns      = 0
    this_nPesoBals    = 0

    *-- Parametros de balanca/unidade padrao lidos de crSigCdPam
    this_cCUnipPads   = ""

    *-- Fatores da unidade principal (SigCdUni - LocalUni)
    this_nFatorsUni   = 0
    this_cQtEqualPs   = ""
    this_cCEstosUni   = ""

    *-- Fatores da unidade secundaria (SigCdUni - LocalUni2)
    this_nFatorsUni2  = 0
    this_cQtEqualPs2  = ""
    this_cCEstosUni2  = ""

    *-- Alias do cursor fonte (xNensi - producao) a ser desagregado
    this_cAliasFonte  = ""

    *---------------------------------------------------------------------------
    * Init - Configura tabela e chave
    * OPERACIONAL: this_cTabela usado apenas para auditoria (alvo logico = xNensi)
    *---------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "xNensi"
        THIS.this_cCampoChave = "Nops"
        RETURN DODEFAULT()
    ENDPROC

    *---------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna numero da operacao como identificador
    *---------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nNops)
    ENDFUNC

    *---------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor TmpDistrib
    *---------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_lMarca    = NVL(Marca, .F.)
            THIS.this_nNops     = NVL(Nops, 0)
            THIS.this_nNenvs    = NVL(Nenvs, 0)
            THIS.this_cCodPds   = TratarNulo(CodPds, "C")
            THIS.this_cCMats    = TratarNulo(CMats, "C")
            THIS.this_cCUnis    = TratarNulo(CUnis, "C")
            THIS.this_nQtds     = NVL(Qtds, 0)
            THIS.this_nPesos    = NVL(Pesos, 0)
            THIS.this_nPesofs   = NVL(Pesofs, 0)
            THIS.this_cCDescs   = TratarNulo(CDescs, "C")
            THIS.this_cCGrus    = TratarNulo(CGrus, "C")
            THIS.this_cTpOps    = TratarNulo(TpOps, "C")
            THIS.this_cCUniPs   = TratarNulo(cUniPs, "C")
            THIS.this_nQtd2s    = NVL(Qtd2s, 0)
            THIS.this_nPeso2s   = NVL(Peso2s, 0)
            THIS.this_nPesof2s  = NVL(Pesof2s, 0)
            THIS.this_cCodCors  = TratarNulo(CodCors, "C")
            THIS.this_cCodTams  = TratarNulo(CodTams, "C")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *---------------------------------------------------------------------------
    * InicializarTmpDistrib - Cria cursor TmpDistrib a partir do cursor fonte
    * par_cAliasFonte: alias do cursor de producao (xNensi no legado)
    * Estrutura TmpDistrib identica ao legado (Create Cursor do Init original)
    *---------------------------------------------------------------------------
    PROCEDURE InicializarTmpDistrib(par_cAliasFonte)
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_nNops, loc_nNenvs, loc_nQtds, loc_nPeso2s, loc_nPesos
        LOCAL loc_cCUnis, loc_cCMats, loc_cCDescs, loc_cCGrus, loc_cCUniPs
        LOCAL loc_cCodCors, loc_cCodTams

        loc_lSucesso = .F.

        TRY
            IF !USED(par_cAliasFonte)
                loc_lSucesso = .F.
            ELSE
                IF USED("TmpDistrib")
                    USE IN TmpDistrib
                ENDIF

                SET NULL ON
                CREATE CURSOR TmpDistrib (;
                    Marca    L        NULL,;
                    Nops     N(10,0)  NULL,;
                    Nenvs    N(10,0)  NULL,;
                    CodPds   C(10)    NULL,;
                    CMats    C(14)    NULL,;
                    CUnis    C(3)     NULL,;
                    Qtds     N(10,3)  NULL,;
                    Pesos    N(10,3)  NULL,;
                    Pesofs   N(10,3)  NULL,;
                    CDescs   C(40)    NULL,;
                    CGrus    C(3)     NULL,;
                    TpOps    C(15)    NULL,;
                    cUniPs   C(3)     NULL,;
                    Qtd2s    N(10,3)  NULL,;
                    Peso2s   N(10,3)  NULL,;
                    Pesof2s  N(10,3)  NULL,;
                    CodCors  C(4)     NULL,;
                    CodTams  C(4)     NULL)
                SET NULL OFF

                SELECT (par_cAliasFonte)
                SET ORDER TO NopCMat
                GO TOP

                SCAN
                    IF Visivel
                        LOOP
                    ENDIF

                    loc_nNops    = Nops
                    loc_nNenvs   = Nenvs
                    loc_nQtds    = Qtds
                    loc_nPeso2s  = Peso2s
                    loc_nPesos   = Pesos
                    loc_cCUnis   = CUnis
                    loc_cCMats   = CMats
                    loc_cCDescs  = CDescs
                    loc_cCGrus   = CGrus
                    loc_cCUniPs  = cUniPs
                    loc_cCodCors = CodCors
                    loc_cCodTams = CodTams

                    INSERT INTO TmpDistrib (;
                        Nops, Nenvs, Qtd2s, Peso2s, Pesof2s,;
                        CUnis, CMats, CDescs, CGrus, Qtds, Pesos,;
                        Pesofs, cUniPs, CodCors, CodTams) ;
                    VALUES (;
                        loc_nNops, loc_nNenvs, loc_nQtds, loc_nPeso2s, loc_nPesos,;
                        loc_cCUnis, loc_cCMats, loc_cCDescs, loc_cCGrus,;
                        loc_nQtds, loc_nPeso2s, loc_nPesos,;
                        loc_cCUniPs, loc_cCodCors, loc_cCodTams)

                    SELECT (par_cAliasFonte)
                ENDSCAN

                SELECT TmpDistrib
                GO TOP
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * BuscarUnidade - Consulta SigCdUni via SQL e armazena em cursor local
    * par_cCUnis         : codigo da unidade
    * par_cCampos        : lista de campos (ex: "Fators, QtEqualPs, CEstos")
    * par_cCursorDestino : nome do cursor local de destino
    *---------------------------------------------------------------------------
    PROCEDURE BuscarUnidade(par_cCUnis, par_cCampos, par_cCursorDestino)
        LOCAL loc_cSQL, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cCUnis))
                loc_lSucesso = .F.
            ELSE
                IF USED(par_cCursorDestino)
                    USE IN (par_cCursorDestino)
                ENDIF

                loc_cSQL = "SELECT " + par_cCampos + ;
                           " FROM SigCdUni WHERE CUnis = " + EscaparSQL(ALLTRIM(par_cCUnis))

                IF SQLEXEC(gnConnHandle, loc_cSQL, par_cCursorDestino) > 0
                    IF RECCOUNT(par_cCursorDestino) > 0
                        SELECT (par_cCursorDestino)
                        GO TOP
                    ENDIF
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * ValidarQtdeDesagregada - Valida e recalcula apos alteracao de Qtd2s (Col 7)
    * Requer: TmpDistrib selecionado na linha corrente
    * par_nNovaQtd : novo valor de Qtd2s digitado pelo usuario
    * par_nLibrPqs : flag LibrPqs do crSigCdOpd (1=permite qtd >= original)
    * Retorna .T. se valor aceito
    * Efeito colateral: atualiza TmpDistrib.Pesof2s ou TmpDistrib.Pesos
    *---------------------------------------------------------------------------
    FUNCTION ValidarQtdeDesagregada(par_nNovaQtd, par_nLibrPqs)
        LOCAL loc_lValido, loc_oErro
        LOCAL loc_nFators, loc_cQtEqualPs

        loc_lValido = .T.

        TRY
            IF !USED("TmpDistrib")
                loc_lValido = .F.
            ELSE
                SELECT TmpDistrib

                IF par_nNovaQtd >= TmpDistrib.Qtds AND par_nLibrPqs <> 1
                    MsgAviso("Desagregar Parcialmente: Qtde tem que ser menor do que a original", ;
                             "Valida" + CHR(231) + CHR(227) + CHR(227) + "o")
                    loc_lValido = .F.
                ELSE
                    THIS.BuscarUnidade(TmpDistrib.CUnis, "Fators, QtEqualPs", "LocalUni")

                    IF USED("LocalUni") AND RECCOUNT("LocalUni") > 0
                        SELECT LocalUni
                        loc_nFators    = NVL(Fators, 0)
                        loc_cQtEqualPs = TratarNulo(QtEqualPs, "C")

                        IF loc_nFators <> 0
                            IF (loc_nFators <> 1) OR UPPER(ALLTRIM(loc_cQtEqualPs)) = "S"
                                SELECT TmpDistrib
                                REPLACE Pesof2s WITH par_nNovaQtd * loc_nFators
                            ENDIF
                        ENDIF

                        SELECT TmpDistrib
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lValido = .F.
        ENDTRY

        RETURN loc_lValido
    ENDFUNC

    *---------------------------------------------------------------------------
    * ValidarPesoDesagregado - Valida e recalcula apos alteracao de Peso2s (Col 10)
    * Requer: TmpDistrib selecionado na linha corrente
    * par_nNovoPeso : novo valor de Peso2s digitado pelo usuario
    * par_nLibrPqs  : flag LibrPqs do crSigCdOpd
    * Retorna .T. se valor aceito
    * Efeito colateral: atualiza TmpDistrib.Pesof2s
    *---------------------------------------------------------------------------
    FUNCTION ValidarPesoDesagregado(par_nNovoPeso, par_nLibrPqs)
        LOCAL loc_lValido, loc_oErro
        LOCAL loc_nFators2, loc_cQtEqualPs2

        loc_lValido = .T.

        TRY
            IF !USED("TmpDistrib")
                loc_lValido = .F.
            ELSE
                SELECT TmpDistrib

                IF par_nNovoPeso >= TmpDistrib.Pesos AND par_nLibrPqs <> 1
                    MsgAviso("Desagregar Parcialmente: Peso tem que ser menor do que Original", ;
                             "Valida" + CHR(231) + CHR(227) + CHR(227) + "o")
                    loc_lValido = .F.
                ELSE
                    THIS.BuscarUnidade(TmpDistrib.cUniPs, "Fators, QtEqualPs", "LocalUni2")

                    IF USED("LocalUni2") AND RECCOUNT("LocalUni2") > 0
                        SELECT LocalUni2
                        loc_nFators2    = NVL(Fators, 0)
                        loc_cQtEqualPs2 = TratarNulo(QtEqualPs, "C")

                        IF loc_nFators2 <> 0
                            IF (loc_nFators2 <> 1) OR UPPER(ALLTRIM(loc_cQtEqualPs2)) = "S"
                                SELECT TmpDistrib
                                REPLACE Pesof2s WITH par_nNovoPeso * loc_nFators2
                            ENDIF
                        ENDIF

                        SELECT TmpDistrib
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lValido = .F.
        ENDTRY

        RETURN loc_lValido
    ENDFUNC

    *---------------------------------------------------------------------------
    * ValidarPesoFabrDesagregado - Valida e recalcula apos alt. Pesof2s (Col 11)
    * Requer: TmpDistrib selecionado na linha corrente
    * par_nNovoPesoFabr : novo valor de Pesof2s digitado
    * par_nLibrPqs      : flag LibrPqs do crSigCdOpd
    * par_nPesoBals     : flag PesoBals do crSigCdOpd (1=controle por balanca)
    * Retorna .T. se valor aceito
    * Efeito colateral: atualiza TmpDistrib.Qtd2s ou TmpDistrib.Peso2s
    *---------------------------------------------------------------------------
    FUNCTION ValidarPesoFabrDesagregado(par_nNovoPesoFabr, par_nLibrPqs, par_nPesoBals)
        LOCAL loc_lValido, loc_oErro
        LOCAL loc_nFators, loc_cQtEqualPs, loc_cCEstos
        LOCAL loc_nFators2, loc_cQtEqualPs2, loc_nDivisor

        loc_lValido = .T.

        TRY
            IF !USED("TmpDistrib")
                loc_lValido = .F.
            ELSE
                SELECT TmpDistrib

                IF par_nNovoPesoFabr >= TmpDistrib.Pesofs AND par_nLibrPqs <> 1
                    MsgAviso("Desagregar Parcialmente: Peso Fabr tem que ser menor do que Original", ;
                             "Valida" + CHR(231) + CHR(227) + CHR(227) + "o")
                    loc_lValido = .F.
                ELSE
                    THIS.BuscarUnidade(TmpDistrib.CUnis,  "Fators, QtEqualPs, CEstos", "LocalUni")
                    THIS.BuscarUnidade(TmpDistrib.cUniPs, "Fators, QtEqualPs, CEstos", "LocalUni2")

                    IF USED("LocalUni") AND RECCOUNT("LocalUni") > 0
                        SELECT LocalUni
                        loc_nFators    = NVL(Fators, 0)
                        loc_cQtEqualPs = TratarNulo(QtEqualPs, "C")
                        loc_cCEstos    = TratarNulo(CEstos, "C")

                        IF loc_nFators <> 0
                            IF (loc_nFators <> 1) OR UPPER(ALLTRIM(loc_cQtEqualPs)) = "S"
                                loc_nDivisor = IIF(EMPTY(loc_nFators), 1, loc_nFators)
                                SELECT TmpDistrib
                                REPLACE Qtd2s WITH par_nNovoPesoFabr / loc_nDivisor
                            ELSE
                                IF USED("LocalUni2") AND RECCOUNT("LocalUni2") > 0
                                    SELECT LocalUni2
                                    loc_nFators2    = NVL(Fators, 0)
                                    loc_cQtEqualPs2 = TratarNulo(QtEqualPs, "C")

                                    SELECT TmpDistrib
                                    IF ALLTRIM(loc_cCEstos) = "3" AND ;
                                       !EMPTY(ALLTRIM(TmpDistrib.cUniPs)) AND ;
                                       ((loc_nFators2 <> 1) OR UPPER(ALLTRIM(loc_cQtEqualPs2)) = "S")
                                        loc_nDivisor = IIF(EMPTY(loc_nFators2), 1, loc_nFators2)
                                        REPLACE Peso2s WITH par_nNovoPesoFabr / loc_nDivisor
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF

                    SELECT TmpDistrib
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lValido = .F.
        ENDTRY

        RETURN loc_lValido
    ENDFUNC

    *---------------------------------------------------------------------------
    * SalvarDesagregacao - Aplica desagregacao: atualiza cursor fonte (xNensi)
    * com base nos valores parciais definidos em TmpDistrib (logica do ok.Click)
    * par_cAliasFonte: alias do cursor de producao a ser atualizado
    * Retorna .T. se sucesso
    * Efeito: marca linhas como Visivel=.T., Rateio=3; atualiza qtds/pesos restantes
    *---------------------------------------------------------------------------
    FUNCTION SalvarDesagregacao(par_cAliasFonte)
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_nNops, loc_cCMats
        LOCAL loc_nQtds, loc_nPesos, loc_nPesofs
        LOCAL loc_nQtd2s, loc_nPeso2s, loc_nPesof2s
        LOCAL loc_lMarca

        loc_lSucesso = .F.

        TRY
            IF !USED("TmpDistrib") OR !USED(par_cAliasFonte)
                loc_lSucesso = .F.
            ELSE
                SELECT TmpDistrib
                GO TOP

                SCAN
                    loc_nNops    = TmpDistrib.Nops
                    loc_cCMats   = TmpDistrib.CMats
                    loc_nQtds    = TmpDistrib.Qtds
                    loc_nPesos   = TmpDistrib.Pesos
                    loc_nPesofs  = TmpDistrib.Pesofs
                    loc_nQtd2s   = TmpDistrib.Qtd2s
                    loc_nPeso2s  = TmpDistrib.Peso2s
                    loc_nPesof2s = TmpDistrib.Pesof2s
                    loc_lMarca   = TmpDistrib.Marca

                    SELECT (par_cAliasFonte)
                    SET ORDER TO NopCmat

                    IF SEEK(STR(loc_nNops, 10) + loc_cCMats)
                        SCAN WHILE Nops = loc_nNops AND CMats = loc_cCMats
                            IF Qtds = loc_nQtds AND Peso2s = loc_nPesos AND Pesos = loc_nPesofs
                                REPLACE Visivel WITH .T., Rateio WITH 3
                                IF loc_lMarca
                                    REPLACE Pesos  WITH loc_nPesofs  - loc_nPesof2s, ;
                                            Qtds   WITH loc_nQtds    - loc_nQtd2s, ;
                                            Peso2s WITH loc_nPesos   - loc_nPeso2s
                                ENDIF
                                EXIT
                            ENDIF
                        ENDSCAN
                    ENDIF

                    SELECT TmpDistrib
                ENDSCAN

                SELECT (par_cAliasFonte)
                SET ORDER TO Editar

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *---------------------------------------------------------------------------
    * Inserir - Aplica desagregacao ao cursor fonte (xNensi)
    * OPERACIONAL: nao existe INSERT em tabela; persistencia eh via cursor xNensi.
    * Pre-condicao: THIS.this_cAliasFonte preenchido pelo Form antes do Salvar().
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cAliasFonte)
                THIS.this_cMensagemErro = "Alias fonte n" + CHR(227) + "o definido"
                loc_lSucesso = .F.
            ELSE
                IF !USED(THIS.this_cAliasFonte)
                    THIS.this_cMensagemErro = "Cursor fonte n" + CHR(227) + "o est" + CHR(225) + " aberto"
                    loc_lSucesso = .F.
                ELSE
                    loc_lSucesso = THIS.SalvarDesagregacao(THIS.this_cAliasFonte)

                    IF loc_lSucesso
                        THIS.RegistrarAuditoria("DESAGREGAR")
                    ELSE
                        THIS.this_cMensagemErro = "Falha ao aplicar desagrega" + CHR(231) + CHR(227) + "o"
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inserir: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * Atualizar - Re-aplica desagregacao ao cursor fonte (xNensi)
    * OPERACIONAL: equivale a Inserir em forms de movimentacao sobre cursor.
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cAliasFonte)
                THIS.this_cMensagemErro = "Alias fonte n" + CHR(227) + "o definido"
                loc_lSucesso = .F.
            ELSE
                IF !USED(THIS.this_cAliasFonte)
                    THIS.this_cMensagemErro = "Cursor fonte n" + CHR(227) + "o est" + CHR(225) + " aberto"
                    loc_lSucesso = .F.
                ELSE
                    loc_lSucesso = THIS.SalvarDesagregacao(THIS.this_cAliasFonte)

                    IF loc_lSucesso
                        THIS.RegistrarAuditoria("REDESAGREGAR")
                    ELSE
                        THIS.this_cMensagemErro = "Falha ao re-aplicar desagrega" + CHR(231) + CHR(227) + "o"
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao atualizar: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

