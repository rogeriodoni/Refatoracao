# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (5)
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: O. P., Envelope, Qtde, Produto, Codigo, Descrição, Funcionário. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: O. P., Envelope, Qtde, Produto, Codigo, Descrição, Funcionário. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'Label1' (parent: SigPdMp9): Left original=376 vs migrado 'lbl_4c_Label1' Left=470 (diff=94px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SigPdMp9): Left original=362 vs migrado 'lbl_4c_Label3' Left=452 (diff=90px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'ok' (parent: SigPdMp9): Left original=725 vs migrado 'cmd_4c_Ok' Left=906 (diff=181px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPdMp8.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1489 linhas total):

*-- Linhas 91 a 109:
91:         TRY
92:             THIS.LockScreen = .T.
93: 
94:             THIS.Caption = "Rela" + CHR(231) + CHR(227) + "o de OPs com N" + ;
95:                            CHR(227) + "o-Confirmidades"
96: 
97:             IF TYPE("gc_4c_CaminhoIcones") = "C"
98:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
99:             ENDIF
100: 
101:             THIS.ConfigurarPageFrame()
102:             THIS.ConfigurarCabecalho()
103:             THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
104:             THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
105:             THIS.ConfigurarPaginaLista()
106:             THIS.ConfigurarPaginaDados()
107:             THIS.CarregarGradeRetrab()
108:             THIS.ConfigurarEventos()
109: 

*-- Linhas 138 a 175:
138:         loc_cCaption = THIS.Caption
139: 
140:         WITH THIS.cnt_4c_Sombra
141:             .AddObject("lbl_4c_LblSombra", "Label")
142:             WITH .lbl_4c_LblSombra
143:                 .FontBold      = .T.
144:                 .FontName      = "Tahoma"
145:                 .FontSize      = 18
146:                 .FontUnderline = .F.
147:                 .WordWrap      = .T.
148:                 .Alignment     = 0
149:                 .BackStyle     = 0
150:                 .Caption       = loc_cCaption
151:                 .Height        = 40
152:                 .Left          = 10
153:                 .Top           = 18
154:                 .Width         = 769
155:                 .ForeColor     = RGB(0, 0, 0)
156:                 .Visible       = .T.
157:             ENDWITH
158: 
159:             .AddObject("lbl_4c_LblTitulo", "Label")
160:             WITH .lbl_4c_LblTitulo
161:                 .FontBold   = .T.
162:                 .FontName   = "Tahoma"
163:                 .FontSize   = 18
164:                 .WordWrap   = .T.
165:                 .Alignment  = 0
166:                 .BackStyle  = 0
167:                 .Caption    = loc_cCaption
168:                 .Height     = 46
169:                 .Left       = 10
170:                 .Top        = 17
171:                 .Width      = 769
172:                 .ForeColor  = RGB(255, 255, 255)
173:                 .Visible    = .T.
174:             ENDWITH
175:         ENDWITH

*-- Linhas 194 a 245:
194:     * Label1 (acima grd_4c_Inc), Label3 (abaixo grd_4c_Inc / campo Descs)
195:     *==========================================================================
196:     PROTECTED PROCEDURE AdicionarLabelsGrade()
197:         THIS.AddObject("lbl_4c_Label2", "Label")
198:         WITH THIS.lbl_4c_Label2
199:             .AutoSize   = .F.
200:             .FontBold   = .T.
201:             .FontName   = "Tahoma"
202:             .FontSize   = 8
203:             .Alignment  = 2
204:             .BackStyle  = 0
205:             .Caption    = "Rela" + CHR(231) + CHR(227) + "o de Op's"
206:             .Height     = 17
207:             .Left       = 35
208:             .Top        = 215
209:             .Width      = 403
210:             .ForeColor  = RGB(90, 90, 90)
211:             .Visible    = .T.
212:         ENDWITH
213: 
214:         THIS.AddObject("lbl_4c_Label1", "Label")
215:         WITH THIS.lbl_4c_Label1
216:             .AutoSize   = .F.
217:             .FontBold   = .T.
218:             .FontName   = "Tahoma"
219:             .FontSize   = 8
220:             .Alignment  = 2
221:             .BackStyle  = 0
222:             .Caption    = "N" + CHR(227) + "o Conformidades"
223:             .Height     = 17
224:             .Left       = 470
225:             .Top        = 216
226:             .Width      = 436
227:             .ForeColor  = RGB(90, 90, 90)
228:             .Visible    = .T.
229:         ENDWITH
230: 
231:         THIS.AddObject("lbl_4c_Label3", "Label")
232:         WITH THIS.lbl_4c_Label3
233:             .AutoSize   = .T.
234:             .FontName   = "Tahoma"
235:             .FontSize   = 8
236:             .BackStyle  = 0
237:             .Caption    = "Descri" + CHR(231) + CHR(227) + "o da N" + CHR(227) + "o Conformidade"
238:             .Height     = 15
239:             .Left       = 452
240:             .Top        = 552
241:             .Width      = 194
242:             .ForeColor  = RGB(90, 90, 90)
243:             .Visible    = .T.
244:         ENDWITH
245:     ENDPROC

*-- Linhas 257 a 283:
257:         loc_oCnt = THIS.cnt_4c_Operacao
258: 
259:         *-- Label "Movimentacao :" (original Say4, left=31->39 escalado)
260:         loc_oCnt.AddObject("lbl_4c_Say4", "Label")
261:         WITH loc_oCnt.lbl_4c_Say4
262:             .FontName  = "Tahoma"
263:             .FontSize  = 8
264:             .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
265:             .Left      = 39
266:             .Top       = 14
267:             .AutoSize  = .T.
268:             .BackStyle = 0
269:             .ForeColor = RGB(0,0,0)
270:         ENDWITH
271: 
272:         *-- txt_4c_Empresa: empresa da OP (original GetEmpresa, tmpnens.emps)
273:         *-- left=111->139, width=36->45 escalado
274:         loc_oCnt.AddObject("txt_4c_Empresa", "TextBox")
275:         WITH loc_oCnt.txt_4c_Empresa
276:             .ControlSource     = "tmpnens.emps"
277:             .Left              = 139
278:             .Top               = 10
279:             .Width             = 45
280:             .Height            = 23
281:             .ReadOnly          = .T.
282:             .SpecialEffect     = 2
283:             .ForeColor         = RGB(0,0,0)

*-- Linhas 290 a 299:
290:         loc_oCnt.AddObject("txt_4c_Operacao", "TextBox")
291:         WITH loc_oCnt.txt_4c_Operacao
292:             .ControlSource     = "tmpnens.dopps"
293:             .Left              = 186
294:             .Top               = 10
295:             .Width             = 195
296:             .Height            = 23
297:             .ReadOnly          = .T.
298:             .SpecialEffect     = 2
299:             .ForeColor         = RGB(0,0,0)

*-- Linhas 308 a 317:
308:             .ControlSource     = "tmpnens.numps"
309:             .Format            = "L"
310:             .InputMask         = "9999999999"
311:             .Left              = 384
312:             .Top               = 10
313:             .Width             = 101
314:             .Height            = 23
315:             .ReadOnly          = .T.
316:             .SpecialEffect     = 2
317:             .ForeColor         = RGB(0,0,0)

*-- Linhas 385 a 394:
385:     PROTECTED PROCEDURE ConfigurarGrdRetrab()
386:         THIS.AddObject("grd_4c_Retrab", "Grid")
387:         WITH THIS.grd_4c_Retrab
388:             .Top                = 232
389:             .Left               = 33
390:             .Width              = 414
391:             .Height             = 317
392:             .ColumnCount        = 4
393:             .ReadOnly           = .T.
394:             .RecordMark         = .F.

*-- Linhas 411 a 419:
411:             .Column1.Format      = "L"
412:             .Column1.InputMask   = "9999999999"
413:             .Column1.FontName    = "Arial"
414:             .Column1.Header1.Caption   = "O. P."
415:             .Column1.Header1.FontName  = "Tahoma"
416:             .Column1.Header1.FontSize  = 8
417:             .Column1.Header1.Alignment = 2
418:             .Column1.Text1.FontName    = "Arial"
419:             .Column1.Text1.BorderStyle = 0

*-- Linhas 429 a 437:
429:             .Column2.Resizable   = .F.
430:             .Column2.ReadOnly    = .T.
431:             .Column2.Alignment   = 4
432:             .Column2.Header1.Caption   = "Envelope"
433:             .Column2.Header1.FontName  = "Tahoma"
434:             .Column2.Header1.FontSize  = 8
435:             .Column2.Header1.Alignment = 2
436:             .Column2.Text1.Alignment   = 0
437:             .Column2.Text1.BorderStyle = 0

*-- Linhas 448 a 456:
448:             .Column3.Resizable   = .F.
449:             .Column3.ReadOnly    = .T.
450:             .Column3.InputMask   = "9999.9"
451:             .Column3.Header1.Caption   = "Qtde"
452:             .Column3.Header1.FontName  = "Tahoma"
453:             .Column3.Header1.FontSize  = 8
454:             .Column3.Header1.Alignment = 2
455:             .Column3.Text1.BorderStyle = 0
456:             .Column3.Text1.Margin      = 0

*-- Linhas 464 a 472:
464:             .Column4.Movable     = .F.
465:             .Column4.Resizable   = .F.
466:             .Column4.ReadOnly    = .T.
467:             .Column4.Header1.Caption   = "Produto"
468:             .Column4.Header1.FontName  = "Tahoma"
469:             .Column4.Header1.FontSize  = 8
470:             .Column4.Header1.Alignment = 2
471:             .Column4.Text1.BorderStyle = 0
472:             .Column4.Text1.Margin      = 0

*-- Linhas 486 a 495:
486:     PROTECTED PROCEDURE ConfigurarGrdInc()
487:         THIS.AddObject("grd_4c_Inc", "Grid")
488:         WITH THIS.grd_4c_Inc
489:             .Top                = 232
490:             .Left               = 448
491:             .Width              = 461
492:             .Height             = 317
493:             .ColumnCount        = 4
494:             .ReadOnly           = .F.
495:             .RecordMark         = .F.

*-- Linhas 511 a 519:
511:             .Column1.Resizable   = .F.
512:             .Column1.ReadOnly    = .F.
513:             .Column1.FontName    = "Arial"
514:             .Column1.Header1.Caption   = "C" + CHR(243) + "digo"
515:             .Column1.Header1.FontName  = "Tahoma"
516:             .Column1.Header1.FontSize  = 8
517:             .Column1.Header1.Alignment = 2
518:             .Column1.Text1.FontName    = "Arial"
519:             .Column1.Text1.BorderStyle = 0

*-- Linhas 530 a 538:
530:             .Column2.Resizable   = .F.
531:             .Column2.ReadOnly    = .F.
532:             .Column2.InputMask   = "999.9"
533:             .Column2.Header1.Caption   = "Qtde"
534:             .Column2.Header1.FontName  = "Tahoma"
535:             .Column2.Header1.FontSize  = 8
536:             .Column2.Header1.Alignment = 2
537:             .Column2.Text1.BorderStyle = 0
538:             .Column2.Text1.InputMask   = "999.9"

*-- Linhas 546 a 554:
546:             .Column3.ColumnOrder = 4
547:             .Column3.Width       = 181
548:             .Column3.ReadOnly    = .F.
549:             .Column3.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
550:             .Column3.Header1.FontName  = "Tahoma"
551:             .Column3.Header1.Alignment = 2
552:             .Column3.Text1.BorderStyle = 0
553:             .Column3.Text1.Margin      = 0
554:             .Column3.Text1.ForeColor   = RGB(0,0,0)

*-- Linhas 560 a 568:
560:             .Column4.Movable     = .F.
561:             .Column4.Resizable   = .F.
562:             .Column4.ReadOnly    = .F.
563:             .Column4.Header1.Caption   = "Funcion" + CHR(225) + "rio"
564:             .Column4.Header1.FontName  = "Tahoma"
565:             .Column4.Header1.Alignment = 2
566:             .Column4.Text1.BorderStyle = 0
567:             .Column4.Text1.Margin      = 0
568:             .Column4.Text1.ForeColor   = RGB(0,0,0)

*-- Linhas 579 a 620:
579:     PROTECTED PROCEDURE ConfigurarCmdgCompo()
580:         THIS.AddObject("cmdg_4c_Compo", "CommandGroup")
581:         WITH THIS.cmdg_4c_Compo
582:             .Top         = 229
583:             .Left        = 904
584:             .Width       = 50
585:             .Height      = 92
586:             .BackStyle   = 0
587:             .BorderStyle = 0
588:             .ButtonCount = 2
589:             .Value       = 1
590: 
591:             WITH .Buttons(1)
592:                 .AutoSize    = .F.
593:                 .Top         = 5
594:                 .Left        = 5
595:                 .Height      = 40
596:                 .Width       = 40
597:                 .Caption     = ""
598:                 .ForeColor   = RGB(36,84,155)
599:                 .BackColor   = RGB(255,255,255)
600:                 .Themes      = .F.
601:                 .ToolTipText = "Inclui uma N" + CHR(227) + "o-Conformidade"
602:                 IF TYPE("gc_4c_CaminhoIcones") = "C"
603:                     .Picture = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
604:                 ENDIF
605:             ENDWITH
606: 
607:             WITH .Buttons(2)
608:                 .AutoSize    = .F.
609:                 .Top         = 47
610:                 .Left        = 5
611:                 .Height      = 40
612:                 .Width       = 40
613:                 .FontName    = "Verdana"
614:                 .FontSize    = 8
615:                 .Caption     = ""
616:                 .ForeColor   = RGB(36,84,155)
617:                 .BackColor   = RGB(255,255,255)
618:                 .Themes      = .F.
619:                 .ToolTipText = "Exclui uma N" + CHR(227) + "o-Conformidade"
620:                 IF TYPE("gc_4c_CaminhoIcones") = "C"

*-- Linhas 633 a 642:
633:         THIS.AddObject("txt_4c_Descricao", "TextBox")
634:         WITH THIS.txt_4c_Descricao
635:             .ControlSource = "xNensiN.descs"
636:             .Left          = 451
637:             .Top           = 568
638:             .Width         = 434
639:             .Height        = 23
640:             .FontName      = "Tahoma"
641:             .FontSize      = 8
642:             .BorderStyle   = 1

*-- Linhas 648 a 669:
648:     *==========================================================================
649:     * AdicionarBtnOk - Botao OK: habilita form pai e fecha este sub-dialog
650:     * Original ok: left=725 top=3 picture=cadastro_salvar_60.jpg (800px) -> left=906
651:     *==========================================================================
652:     PROTECTED PROCEDURE AdicionarBtnOk()
653:         THIS.AddObject("cmd_4c_Ok", "CommandButton")
654:         WITH THIS.cmd_4c_Ok
655:             .Top             = 3
656:             .Left            = 906
657:             .Width           = 60
658:             .Height          = 72
659:             .Caption         = "OK"
660:             .FontBold        = .T.
661:             .FontName        = "Tahoma"
662:             .FontSize        = 8
663:             .ForeColor       = RGB(90,90,90)
664:             .BackColor       = RGB(255,255,255)
665:             .Themes          = .F.
666:             .SpecialEffect   = 0
667:             .PicturePosition = 13
668:             .MousePointer    = 15
669:             .WordWrap        = .T.

*-- Linhas 703 a 714:
703:             loc_oGrdR.Column4.ControlSource = "xmfas.codpds"
704: 
705:             *-- Reconfigurar headers (obrigatorio apos RecordSource/ControlSource)
706:             loc_oGrdR.Column1.Header1.Caption = "O. P."
707:             loc_oGrdR.Column2.Header1.Caption = "Envelope"
708:             loc_oGrdR.Column3.Header1.Caption = "Qtde"
709:             loc_oGrdR.Column4.Header1.Caption = "Produto"
710: 
711:             loc_oGrdR.Refresh
712:         ENDIF
713: 
714:         *-- Vincular grd_4c_Inc ao cursor xNensiN (ordenado por Nops)

*-- Linhas 726 a 737:
726:             loc_oGrdI.Column4.ControlSource = "xnensiN.Conta2s"
727: 
728:             *-- Reconfigurar headers (obrigatorio apos RecordSource/ControlSource)
729:             loc_oGrdI.Column1.Header1.Caption = "C" + CHR(243) + "digo"
730:             loc_oGrdI.Column2.Header1.Caption = "Qtde"
731:             loc_oGrdI.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
732:             loc_oGrdI.Column4.Header1.Caption = "Funcion" + CHR(225) + "rio"
733: 
734:             loc_oGrdI.Refresh
735:         ENDIF
736: 
737:         *-- Foco inicial na coluna Envelope do grd_4c_Retrab (igual ao original)

*-- Linhas 777 a 799:
777:         IF PEMSTATUS(THIS, "cmdg_4c_Compo", 5)
778:             BINDEVENT(THIS.cmdg_4c_Compo.Buttons(1), "Click", THIS, "BtnIncluirClick")
779:             BINDEVENT(THIS.cmdg_4c_Compo.Buttons(2), "Click", THIS, "BtnExcluirClick")
780:         ENDIF
781: 
782:         *-- cmd_4c_Ok: habilitar form pai e fechar sub-dialog
783:         IF PEMSTATUS(THIS, "cmd_4c_Ok", 5)
784:             BINDEVENT(THIS.cmd_4c_Ok, "Click", THIS, "BtnOkClick")
785:         ENDIF
786: 
787:         *-- Ajustar estado inicial dos botoes conforme modo (INSERIR/ALTERAR vs VISUALIZAR)
788:         loc_lModoEdicao = INLIST(UPPER(THIS.this_cEscolha), "INSERIR", "ALTERAR")
789:         IF PEMSTATUS(THIS, "cmdg_4c_Compo", 5)
790:             THIS.cmdg_4c_Compo.Buttons(1).Enabled = loc_lModoEdicao
791:             THIS.cmdg_4c_Compo.Buttons(2).Enabled = loc_lModoEdicao
792:         ENDIF
793: 
794:         *-- grd_4c_Inc: celulas editaveis - When (controle de edicao) e KeyPress (validacao/lookup)
795:         IF PEMSTATUS(THIS, "grd_4c_Inc", 5)
796:             *-- Column1 (Cods - Codigo NCF): salva AntValue em When; valida NCF em KeyPress
797:             BINDEVENT(THIS.grd_4c_Inc.Column1.Text1, "When",     THIS, "GrdIncCol1When")
798:             BINDEVENT(THIS.grd_4c_Inc.Column1.Text1, "KeyPress", THIS, "GrdIncCol1KeyPress")
799:             *-- Column2 (Qtds - Quantidade): controle de edicao em When; valida em KeyPress


### BO (C:\4c\projeto\app\classes\SigPdMp8BO.prg):
*==============================================================================
* SigPdMp8BO.prg - Business Object para Relacao de OPs com Nao-Conformidades
* Subformulario para vincular nao-conformidades (SigCdNcf) a OPs de retrabalho
* Herda de BusinessBase
*==============================================================================
DEFINE CLASS SigPdMp8BO AS BusinessBase

    *-- Dados da Operacao selecionada no pai (cursor tmpnens)
    this_cNumps    = ""   && OP number (tmpnens.numps, mask 9999999999)
    this_cEmps     = ""   && Empresa (tmpnens.emps)
    this_cDopps    = ""   && Descricao da operacao (tmpnens.dopps)

    *-- Dados da OP de Retrabalho selecionada (cursor xMfas)
    this_nNopsMfa  = 0    && Numero da OP (xMfas.Nops)
    this_nNenvs    = 0    && Numero do envelope (xMfas.nenvs)
    this_nQtdsMfa  = 0    && Quantidade da OP (xMfas.Qtds)
    this_cCodpds   = ""   && Codigo do produto (xMfas.CodPds)
    this_cDpros    = ""   && Descricao do produto (SigCdPro.DPros)
    this_cFigJpgs  = ""   && Imagem base64 do produto (SigCdPro.FigJpgs)

    *-- Dados da Nao-Conformidade atual (cursor xNensiN)
    this_nNops     = 0    && Numero da OP vinculada (xNensiN.Nops)
    this_cCods     = ""   && Codigo da nao-conformidade (xNensiN.Cods)
    this_nQtds     = 0    && Quantidade com nao-conformidade (xNensiN.Qtds)
    this_cDescs    = ""   && Descricao da nao-conformidade (xNensiN.Descs)
    this_cConta2s  = ""   && Codigo do funcionario responsavel (xNensiN.Conta2s)
    this_nFixos    = 0    && Flag fixo: 2=editavel descricao (xNensiN.Fixos)

    *-- Estado interno do subformulario
    this_cAntValue  = ""   && Valor anterior do campo Cods (anti-loop Valid)
    this_cPcEscolha = ""   && Modo do form pai: INSERIR ou ALTERAR

    *==========================================================================
    * Init - Configura tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        THIS.this_cTabela     = "xNensiN"
        THIS.this_cCampoChave = "Nops"
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna Nops do registro corrente de xNensiN
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ""
        IF USED("xNensiN")
            SELECT xNensiN
            loc_cChave = TRANSFORM(NVL(Nops, 0))
        ENDIF
        RETURN loc_cChave
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de alias de cursor
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nNops    = NVL(Nops,    0)
            THIS.this_cCods    = ALLTRIM(NVL(Cods,    ""))
            THIS.this_nQtds    = NVL(Qtds,    0)
            THIS.this_cDescs   = ALLTRIM(NVL(Descs,   ""))
            THIS.this_cConta2s = ALLTRIM(NVL(Conta2s, ""))
            THIS.this_nFixos   = NVL(Fixos,   0)
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *==========================================================================
    * ValidarDados - Valida dados minimos antes de inserir/atualizar
    *==========================================================================
    PROTECTED FUNCTION ValidarDados()
        IF THIS.this_nNops <= 0
            MsgAviso("O n" + CHR(250) + "mero da OP deve ser informado.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDFUNC

    *==========================================================================
    * ExecutarInsercao - INSERT no cursor VFP xNensiN (replica cmdSInserir.Click)
    *==========================================================================
    PROTECTED FUNCTION ExecutarInsercao()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("xNensiN")
                INSERT INTO xNensiN (Nops, Qtds) VALUES (THIS.this_nNops, THIS.this_nQtdsMfa)
                loc_lSucesso = .T.
            ELSE
                MsgErro("Cursor xNensiN n" + CHR(227) + "o est" + CHR(225) + " aberto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inserir NC")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ExecutarAtualizacao - REPLACE completo no cursor VFP xNensiN
    *==========================================================================
    PROTECTED FUNCTION ExecutarAtualizacao()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("xNensiN")
                SELECT xNensiN
                REPLACE Cods    WITH THIS.this_cCods,    ;
                        Qtds    WITH THIS.this_nQtds,    ;
                        Fixos   WITH THIS.this_nFixos,   ;
                        Descs   WITH THIS.this_cDescs,   ;
                        Conta2s WITH THIS.this_cConta2s  ;
                        IN xNensiN
                loc_lSucesso = .T.
            ELSE
                MsgErro("Cursor xNensiN n" + CHR(227) + "o est" + CHR(225) + " aberto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao atualizar NC")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ExecutarExclusao - DELETE no cursor VFP xNensiN (replica cmdSexcluir.Click)
    *==========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("xNensiN")
                SELECT xNensiN
                DELETE
                loc_lSucesso = .T.
            ELSE
                MsgErro("Cursor xNensiN n" + CHR(227) + "o est" + CHR(225) + " aberto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao excluir NC")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * BuscarNcf - Busca NCs em SigCdNcf via SQL Server, indexa cursor por Cods
    * Retorna .T. se par_cCods encontrado (carrega this_cDescs e this_nFixos)
    *         .F. se nao encontrado (form deve abrir FormBuscaAuxiliar)
    *==========================================================================
    FUNCTION BuscarNcf(par_cCods, par_cEmps)
        LOCAL loc_lEncontrado, loc_cSQL, loc_nRet, loc_oErro
        loc_lEncontrado = .F.
        TRY
            loc_cSQL = "SELECT Cods, Descs, Fixos FROM SigCdNcf" + ;
                       " WHERE Emps = " + EscaparSQL(par_cEmps) + ;
                       " OR Emps = ' '"

            IF USED("cursor_4c_Ncf")
                TABLEREVERT(.T., "cursor_4c_Ncf")
                USE IN cursor_4c_Ncf
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ncf")
            IF loc_nRet < 1
                MsgErro("Falha ao buscar N" + CHR(227) + "o-Conformidades (SigCdNcf)", "Erro")
            ELSE
                SELECT cursor_4c_Ncf
                INDEX ON Cods TAG Cods
                IF !EMPTY(par_cCods) AND SEEK(par_cCods)
                    THIS.this_cCods  = ALLTRIM(NVL(cursor_4c_Ncf.Cods,  ""))
                    THIS.this_cDescs = ALLTRIM(NVL(cursor_4c_Ncf.Descs, ""))
                    THIS.this_nFixos = NVL(cursor_4c_Ncf.Fixos, 0)
                    loc_lEncontrado  = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar N" + CHR(227) + "o-Conformidade")
        ENDTRY
        RETURN loc_lEncontrado
    ENDFUNC

    *==========================================================================
    * BuscarProduto - Consulta SigCdPro para descricao e imagem do produto
    * Resultado em this_cDpros e this_cFigJpgs
    *==========================================================================
    PROCEDURE BuscarProduto(par_cCodPds)
        LOCAL loc_cSQL, loc_nRet, loc_oErro
        THIS.this_cDpros   = ""
        THIS.this_cFigJpgs = ""
        TRY
            loc_cSQL = "SELECT DPros, FigJpgs FROM SigCdPro WHERE CPros = " + ;
                       EscaparSQL(par_cCodPds)

            IF USED("cursor_4c_Produto")
                TABLEREVERT(.T., "cursor_4c_Produto")
                USE IN cursor_4c_Produto
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Produto")
            IF loc_nRet > 0 AND !EOF("cursor_4c_Produto")
                SELECT cursor_4c_Produto
                THIS.this_cDpros   = ALLTRIM(NVL(DPros,   ""))
                THIS.this_cFigJpgs = NVL(FigJpgs, "")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar produto")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AtualizarNcfNoCursor - REPLACE Fixos e Descs no registro corrente de xNensiN
    * Chamado apos selecao/validacao de NC para sincronizar campos relacionados
    *==========================================================================
    PROCEDURE AtualizarNcfNoCursor(par_cCods, par_nFixos, par_cDescs)
        LOCAL loc_oErro
        TRY
            IF USED("xNensiN")
                SELECT xNensiN
                REPLACE Fixos WITH par_nFixos, ;
                        Descs WITH par_cDescs  ;
                        IN xNensiN
                THIS.this_nFixos = par_nFixos
                THIS.this_cDescs = par_cDescs
                THIS.this_cCods  = par_cCods
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao atualizar NC no cursor")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ContarNcsPorNops - Conta registros NC nao-deletados para a OP par_nNops
    * Retorna 0 se nenhuma NC restante (gatilho para auto-inserir apos Excluir)
    *==========================================================================
    FUNCTION ContarNcsPorNops(par_nNops)
        LOCAL loc_nTotal, loc_oErro
        loc_nTotal = 0
        TRY
            IF USED("xNensiN")
                SELECT xNensiN
                SET ORDER TO Nops
                SET KEY TO par_nNops
                COUNT TO loc_nTotal
                SET KEY TO
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao contar NCs")
        ENDTRY
        RETURN loc_nTotal
    ENDFUNC

ENDDEFINE

