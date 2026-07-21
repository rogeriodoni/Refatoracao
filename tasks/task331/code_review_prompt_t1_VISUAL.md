# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [GRID-WITH] Bloco WITH loc_oGrd define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrd.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrSer.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1364 linhas total):

*-- Linhas 68 a 77:
68:                 THIS.ConfigurarPaginaDados()
69:                 THIS.TornarControlesVisiveis(THIS)
70: 
71:                 THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
72:                 THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption  = THIS.Caption
73: 
74:                 THIS.CarregarDados()
75:                 THIS.AlternarPagina(1)
76:                 THIS.LockScreen = .F.
77: 

*-- Linhas 118 a 168:
118:             THIS.AddObject("cnt_4c_Sombra", "Container")
119:             WITH THIS.cnt_4c_Sombra
120:                 .Visible     = .T.
121:                 .Top         = 0
122:                 .Left        = 0
123:                 .Width       = THIS.Width
124:                 .Height      = 80
125:                 .BorderWidth = 0
126:                 .BackStyle   = 1
127:                 .BackColor   = RGB(100, 100, 100)
128:             ENDWITH
129: 
130:             THIS.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
131:             WITH THIS.cnt_4c_Sombra.lbl_4c_Sombra
132:                 .Visible   = .T.
133:                 .Top       = 18
134:                 .Left      = 10
135:                 .Width     = 769
136:                 .Height    = 40
137:                 .AutoSize  = .F.
138:                 .FontBold  = .T.
139:                 .FontName  = "Tahoma"
140:                 .FontSize  = 18
141:                 .BackStyle = 0
142:                 .ForeColor = RGB(0, 0, 0)
143:                 .WordWrap  = .T.
144:                 .Alignment = 0
145:                 .Caption   = "Servi" + CHR(231) + "os lan" + CHR(231) + "ados"
146:             ENDWITH
147: 
148:             THIS.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
149:             WITH THIS.cnt_4c_Sombra.lbl_4c_Titulo
150:                 .Visible   = .T.
151:                 .Top       = 17
152:                 .Left      = 10
153:                 .Width     = 769
154:                 .Height    = 46
155:                 .AutoSize  = .F.
156:                 .FontBold  = .T.
157:                 .FontName  = "Tahoma"
158:                 .FontSize  = 18
159:                 .BackStyle = 0
160:                 .ForeColor = RGB(255, 255, 255)
161:                 .WordWrap  = .T.
162:                 .Alignment = 0
163:                 .Caption   = "Servi" + CHR(231) + "os lan" + CHR(231) + "ados"
164:             ENDWITH
165: 
166:         CATCH TO loc_oErro
167:             MsgErro(loc_oErro.Message, "Erro")
168:         ENDTRY

*-- Linhas 179 a 214:
179:             THIS.AddObject("cnt_4c_Operacao", "Container")
180:             WITH THIS.cnt_4c_Operacao
181:                 .Visible       = .T.
182:                 .Top           = 104
183:                 .Left          = 12
184:                 .Width         = 490
185:                 .Height        = 56
186:                 .BackStyle     = 1
187:                 .BackColor     = RGB(255, 255, 255)
188:                 .BorderWidth   = 1
189:                 .SpecialEffect = 0
190:             ENDWITH
191: 
192:             THIS.cnt_4c_Operacao.AddObject("lbl_4c_Movimentacao", "Label")
193:             WITH THIS.cnt_4c_Operacao.lbl_4c_Movimentacao
194:                 .Visible   = .T.
195:                 .Top       = 3
196:                 .Left      = 4
197:                 .AutoSize  = .T.
198:                 .FontBold  = .T.
199:                 .FontSize  = 8
200:                 .BackStyle = 0
201:                 .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
202:             ENDWITH
203: 
204:             *-- Empresa (emps - char 3)
205:             THIS.cnt_4c_Operacao.AddObject("txt_4c_Empresa", "TextBox")
206:             WITH THIS.cnt_4c_Operacao.txt_4c_Empresa
207:                 .Visible           = .T.
208:                 .Top               = 26
209:                 .Left              = 5
210:                 .Width             = 36
211:                 .Height            = 23
212:                 .ReadOnly          = .T.
213:                 .Enabled           = .T.
214:                 .ForeColor         = RGB(0, 0, 0)

*-- Linhas 222 a 231:
222:             THIS.cnt_4c_Operacao.AddObject("txt_4c_Operacao", "TextBox")
223:             WITH THIS.cnt_4c_Operacao.txt_4c_Operacao
224:                 .Visible           = .T.
225:                 .Top               = 26
226:                 .Left              = 43
227:                 .Width             = 156
228:                 .Height            = 23
229:                 .ReadOnly          = .T.
230:                 .Enabled           = .T.
231:                 .ForeColor         = RGB(0, 0, 0)

*-- Linhas 238 a 247:
238:             THIS.cnt_4c_Operacao.AddObject("txt_4c_Numps", "TextBox")
239:             WITH THIS.cnt_4c_Operacao.txt_4c_Numps
240:                 .Visible           = .T.
241:                 .Top               = 26
242:                 .Left              = 201
243:                 .Width             = 81
244:                 .Height            = 23
245:                 .ReadOnly          = .T.
246:                 .Enabled           = .T.
247:                 .ForeColor         = RGB(0, 0, 0)

*-- Linhas 255 a 264:
255:             THIS.cnt_4c_Operacao.AddObject("lin_4c_Divisoria", "Line")
256:             WITH THIS.cnt_4c_Operacao.lin_4c_Divisoria
257:                 .Visible     = .T.
258:                 .Top         = 19
259:                 .Left        = 4
260:                 .Width       = 316
261:                 .Height      = 0
262:                 .BorderWidth = 2
263:                 .BorderColor = RGB(90, 90, 90)
264:             ENDWITH

*-- Linhas 276 a 291:
276:         LOCAL loc_oErro
277: 
278:         TRY
279:             THIS.AddObject("cmd_4c_Ok", "CommandButton")
280:             WITH THIS.cmd_4c_Ok
281:                 .Visible         = .T.
282:                 .Top             = 3
283:                 .Left            = 925
284:                 .Width           = 75
285:                 .Height          = 75
286:                 .Caption         = "OK"
287:                 .Cancel          = .T.
288:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
289:                 .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
290:                 .Themes          = .T.
291:                 .FontName        = "Tahoma"

*-- Linhas 301 a 309:
301:                 .AutoSize        = .F.
302:             ENDWITH
303: 
304:             BINDEVENT(THIS.cmd_4c_Ok, "Click", THIS, "CmdOkClick")
305: 
306:         CATCH TO loc_oErro
307:             MsgErro(loc_oErro.Message, "Erro")
308:         ENDTRY
309:     ENDPROC

*-- Linhas 320 a 329:
320:             THIS.AddObject("shp_4c_Shape1", "Shape")
321:             WITH THIS.shp_4c_Shape1
322:                 .Visible     = .T.
323:                 .Top         = 7
324:                 .Left        = 898
325:                 .Width       = 90
326:                 .Height      = 110
327:                 .BackStyle   = 0
328:                 .BorderStyle = 0
329:                 .BorderColor = RGB(136, 189, 188)

*-- Linhas 347 a 356:
347:             loc_oGrd = THIS.grd_4c_Dados
348:             WITH loc_oGrd
349:                 .Visible              = .T.
350:                 .Top                  = 197
351:                 .Left                 = 12
352:                 .Width                = 976
353:                 .Height               = 325
354:                 .ColumnCount          = 9
355:                 .FontName             = "Courier New"
356:                 .FontSize             = 8

*-- Linhas 375 a 383:
375:                 .Resizable   = .F.
376:                 .ReadOnly    = .T.
377:                 WITH .Header1
378:                     .Caption   = "Opera" + CHR(231) + CHR(227) + "o"
379:                     .FontName  = "Tahoma"
380:                     .FontSize  = 8
381:                     .Alignment = 2
382:                 ENDWITH
383:                 WITH .Text1

*-- Linhas 399 a 407:
399:                 .Resizable   = .F.
400:                 .ReadOnly    = .T.
401:                 WITH .Header1
402:                     .Caption   = "Grupo"
403:                     .FontName  = "Tahoma"
404:                     .FontSize  = 8
405:                     .Alignment = 2
406:                 ENDWITH
407:                 WITH .Text1

*-- Linhas 423 a 431:
423:                 .Resizable   = .F.
424:                 .ReadOnly    = .T.
425:                 WITH .Header1
426:                     .Caption   = "Conta"
427:                     .FontName  = "Tahoma"
428:                     .FontSize  = 8
429:                     .Alignment = 2
430:                 ENDWITH
431:                 WITH .Text1

*-- Linhas 447 a 455:
447:                 .Resizable   = .F.
448:                 .ReadOnly    = .T.
449:                 WITH .Header1
450:                     .Caption   = "Grupo"
451:                     .FontName  = "Tahoma"
452:                     .FontSize  = 8
453:                     .Alignment = 2
454:                 ENDWITH
455:                 WITH .Text1

*-- Linhas 471 a 479:
471:                 .Resizable   = .F.
472:                 .ReadOnly    = .T.
473:                 WITH .Header1
474:                     .Caption   = "Conta"
475:                     .FontName  = "Tahoma"
476:                     .FontSize  = 8
477:                     .Alignment = 2
478:                 ENDWITH
479:                 WITH .Text1

*-- Linhas 495 a 503:
495:                 .Resizable   = .F.
496:                 .ReadOnly    = .T.
497:                 WITH .Header1
498:                     .Caption   = "Servi" + CHR(231) + "o"
499:                     .FontName  = "Tahoma"
500:                     .FontSize  = 8
501:                     .Alignment = 2
502:                 ENDWITH
503:                 WITH .Text1

*-- Linhas 519 a 527:
519:                 .Resizable   = .F.
520:                 .ReadOnly    = .T.
521:                 WITH .Header1
522:                     .Caption   = "Qtde"
523:                     .FontName  = "Tahoma"
524:                     .FontSize  = 8
525:                     .Alignment = 2
526:                 ENDWITH
527:                 WITH .Text1

*-- Linhas 543 a 551:
543:                 .Resizable   = .F.
544:                 .ReadOnly    = .T.
545:                 WITH .Header1
546:                     .Caption   = "Valor"
547:                     .FontName  = "Tahoma"
548:                     .FontSize  = 8
549:                     .Alignment = 2
550:                 ENDWITH
551:                 WITH .Text1

*-- Linhas 567 a 575:
567:                 .Resizable   = .F.
568:                 .ReadOnly    = .T.
569:                 WITH .Header1
570:                     .Caption   = "Total"
571:                     .FontName  = "Tahoma"
572:                     .FontSize  = 8
573:                     .Alignment = 2
574:                 ENDWITH
575:                 WITH .Text1

*-- Linhas 598 a 637:
598:         LOCAL loc_oErro
599: 
600:         TRY
601:             THIS.AddObject("lbl_4c_Origem", "Label")
602:             WITH THIS.lbl_4c_Origem
603:                 .Visible     = .T.
604:                 .Top         = 182
605:                 .Left        = 264
606:                 .Width       = 163
607:                 .Height      = 15
608:                 .AutoSize    = .F.
609:                 .FontBold    = .T.
610:                 .FontSize    = 8
611:                 .Alignment   = 2
612:                 .BackStyle   = 1
613:                 .BackColor   = RGB(255, 255, 255)
614:                 .BorderStyle = 1
615:                 .Caption     = "Origem"
616:             ENDWITH
617: 
618:             THIS.AddObject("lbl_4c_Destino", "Label")
619:             WITH THIS.lbl_4c_Destino
620:                 .Visible     = .T.
621:                 .Top         = 182
622:                 .Left        = 426
623:                 .Width       = 163
624:                 .Height      = 15
625:                 .AutoSize    = .F.
626:                 .FontBold    = .T.
627:                 .FontSize    = 8
628:                 .Alignment   = 2
629:                 .BackStyle   = 1
630:                 .BackColor   = RGB(255, 255, 255)
631:                 .BorderStyle = 1
632:                 .Caption     = "Destino"
633:             ENDWITH
634: 
635:         CATCH TO loc_oErro
636:             MsgErro(loc_oErro.Message, "Erro")
637:         ENDTRY

*-- Linhas 645 a 712:
645:         LOCAL loc_oErro
646: 
647:         TRY
648:             THIS.AddObject("lbl_4c_Say2", "Label")
649:             WITH THIS.lbl_4c_Say2
650:                 .Visible   = .T.
651:                 .Top       = 525
652:                 .Left      = 591
653:                 .AutoSize  = .T.
654:                 .FontSize  = 8
655:                 .ForeColor = RGB(90, 90, 90)
656:                 .BackStyle = 0
657:                 .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
658:             ENDWITH
659: 
660:             *-- Descricao do produto (TmpDistrib.Dpros) - Get_descr do legado
661:             THIS.AddObject("txt_4c_Descr", "TextBox")
662:             WITH THIS.txt_4c_Descr
663:                 .Visible           = .T.
664:                 .Top               = 540
665:                 .Left              = 541
666:                 .Width             = 241
667:                 .Height            = 23
668:                 .ReadOnly          = .T.
669:                 .TabStop           = .F.
670:                 .DisabledBackColor = RGB(255, 255, 255)
671:                 .Value             = ""
672:             ENDWITH
673: 
674:             *-- Descricao conta origem (TmpDistrib.DescOrig) - getDescOrig do legado
675:             THIS.AddObject("txt_4c_DescOrig", "TextBox")
676:             WITH THIS.txt_4c_DescOrig
677:                 .Visible           = .T.
678:                 .Top               = 541
679:                 .Left              = 217
680:                 .Width             = 150
681:                 .Height            = 22
682:                 .ReadOnly          = .T.
683:                 .TabStop           = .F.
684:                 .DisabledBackColor = RGB(255, 255, 255)
685:                 .Value             = ""
686:             ENDWITH
687: 
688:             *-- Descricao conta destino (TmpDistrib.DescDest) - getDescDest do legado
689:             THIS.AddObject("txt_4c_DescDest", "TextBox")
690:             WITH THIS.txt_4c_DescDest
691:                 .Visible           = .T.
692:                 .Top               = 541
693:                 .Left              = 379
694:                 .Width             = 150
695:                 .Height            = 22
696:                 .ReadOnly          = .T.
697:                 .TabStop           = .F.
698:                 .DisabledBackColor = RGB(255, 255, 255)
699:                 .Value             = ""
700:             ENDWITH
701: 
702:             *-- Total de quantidade acumulada (getQtdTot do legado) - fundo amarelo
703:             THIS.AddObject("txt_4c_QtdTot", "TextBox")
704:             WITH THIS.txt_4c_QtdTot
705:                 .Visible   = .T.
706:                 .Top       = 521
707:                 .Left      = 696
708:                 .Width     = 83
709:                 .Height    = 18
710:                 .ReadOnly  = .T.
711:                 .TabStop   = .F.
712:                 .FontBold  = .T.

*-- Linhas 723 a 732:
723:             THIS.AddObject("txt_4c_Valtot", "TextBox")
724:             WITH THIS.txt_4c_Valtot
725:                 .Visible   = .T.
726:                 .Top       = 521
727:                 .Left      = 860
728:                 .Width     = 108
729:                 .Height    = 18
730:                 .ReadOnly  = .T.
731:                 .TabStop   = .F.
732:                 .FontBold  = .T.

*-- Linhas 775 a 791:
775:                 .Column9.ControlSource = "TmpDistrib.Qtds * TmpDistrib.Fators"
776:                 .SetAll("DynamicForeColor", "IIF(TmpDistrib.Retrabs, RGB(255,0,0), RGB(0,0,0))", "Column")
777:                 *-- Redefine headers apos RecordSource (VFP9 reseta ao mudar RecordSource)
778:                 .Column1.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
779:                 .Column2.Header1.Caption = "Grupo"
780:                 .Column3.Header1.Caption = "Conta"
781:                 .Column4.Header1.Caption = "Grupo"
782:                 .Column5.Header1.Caption = "Conta"
783:                 .Column6.Header1.Caption = "Servi" + CHR(231) + "o"
784:                 .Column7.Header1.Caption = "Qtde"
785:                 .Column8.Header1.Caption = "Valor"
786:                 .Column9.Header1.Caption = "Total"
787:                 .Refresh()
788:             ENDWITH
789: 
790:             *-- Vincula campos de descricao ao cursor TmpDistrib
791:             THIS.txt_4c_Descr.ControlSource   = "TmpDistrib.Dpros"

*-- Linhas 838 a 846:
838:     * Em forms OPERACIONAIS nao ha Page2=Dados; este metodo agrupa controles
839:     * read-only que refletem a linha selecionada + acumuladores de totais:
840:     *   - cnt_4c_Cabecalho (area transparente de identificacao)
841:     *   - lbl_4c_Say2 (label "Descricao")
842:     *   - txt_4c_Descr (descricao produto, TmpDistrib.Dpros)
843:     *   - txt_4c_DescOrig (descricao conta origem, TmpDistrib.DescOrig)
844:     *   - txt_4c_DescDest (descricao conta destino, TmpDistrib.DescDest)
845:     *   - txt_4c_QtdTot / txt_4c_Valtot (totais amarelos acumulados)
846:     *==========================================================================

*-- Linhas 853 a 862:
853:                 THIS.AddObject("cnt_4c_Cabecalho", "Container")
854:                 WITH THIS.cnt_4c_Cabecalho
855:                     .Visible       = .T.
856:                     .Top           = 505
857:                     .Left          = 12
858:                     .Width         = THIS.Width
859:                     .Height        = 14
860:                     .BackStyle     = 0
861:                     .BorderWidth   = 0
862:                     .SpecialEffect = 0

*-- Linhas 1301 a 1317:
1301:     ENDPROC
1302: 
1303:     *==========================================================================
1304:     * AjustarBotoesPorModo - Popup com unico cmd_4c_Ok (sempre habilitado)
1305:     * par_cModo ignorado
1306:     *==========================================================================
1307:     PROTECTED PROCEDURE AjustarBotoesPorModo(par_cModo)
1308:         LOCAL loc_oErro
1309: 
1310:         TRY
1311:             IF VARTYPE(THIS.cmd_4c_Ok) = "O"
1312:                 THIS.cmd_4c_Ok.Enabled = .T.
1313:             ENDIF
1314:         CATCH TO loc_oErro
1315:             MsgErro(loc_oErro.Message, "Erro")
1316:         ENDTRY
1317:     ENDPROC


### BO (C:\4c\projeto\app\classes\SigPrSerBO.prg):
*==============================================================================
* SigPrSerBO.prg - Business Object: Servi?os Lan?ados
* Tipo: OPERACIONAL (somente leitura - popup filho de form de processamento)
* Tabelas: SigPdMvf, SigCdNei, SigCdNec, SigCdPro, SigCdCli
*==============================================================================

DEFINE CLASS SigPrSerBO AS BusinessBase

    *-- Identifica??o da entidade
    this_cTabela        = "SigCdNei"
    this_cCampoChave    = "cidchaves"

    *-- Chave prim?ria composta (char(20)) do registro corrente em SigCdNei
    this_cCidchaves     = ""

    *-- Dados da opera??o pai (exibidos no container Opera??o)
    this_cEmpdnps       = ""  && char(33) - chave composta emp+op+num
    this_cEmps          = ""  && char(3)  - empresa
    this_nNumps         = 0   && numeric(10,0) - n?mero do processamento
    this_cDopps         = ""  && char(20) - descri??o da opera??o

    *-- Campos do registro corrente do grid (TmpDistrib)
    this_cGrupoos       = ""  && char(10) - grupo de origem (SigCdNec)
    this_cContaos       = ""  && char(10) - conta de origem (SigCdNec)
    this_cGrupods       = ""  && char(10) - grupo de destino (SigCdNec)
    this_cContads       = ""  && char(10) - conta de destino (SigCdNec)
    this_nNops          = 0   && numeric(10,0) - n?mero da opera??o (SigCdNei)
    this_cCmats         = ""  && char(14) - c?digo do material/servi?o (SigCdNei)
    this_nFators        = 0   && numeric(7,4) - fator unit?rio (SigCdNei)
    this_nQtds          = 0   && numeric(9,3) - quantidade (SigCdNei)
    this_cCretrabs      = ""  && char(6) - c?digo retrabalho (SigCdNei)
    this_lRetrabs       = .F. && bit - flag retrabalho (SigCdNec)
    this_cCdescs        = ""  && char(40) - descri??o complementar (SigCdNei)
    this_cDpros         = ""  && char(?) - descri??o do produto/servi?o (SigCdPro)
    this_cDescOrig      = ""  && char(60) - descri??o conta origem (SigCdCli.Rclis)
    this_cDescDest      = ""  && char(60) - descri??o conta destino (SigCdCli.Rclis)

    *-- Totais acumulados do grid
    this_nQtdTotal      = 0   && SUM(qtds)
    this_nValTotal      = 0   && SUM(qtds * fators)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        DODEFAULT()

        THIS.this_cTabela     = "SigCdNei"
        THIS.this_cCampoChave = "cidchaves"
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarServicos(par_nNops)
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cSQL, loc_nNops, loc_oErro
        loc_lSucesso = .F.
        loc_nNops    = IIF(VARTYPE(par_nNops) = "N", par_nNops, 0)

        TRY
            *-- Cursor placeholder (estrutura identica ao SQLEXEC)
            IF USED("TmpDistrib")
                TABLEREVERT(.T., "TmpDistrib")
                USE IN TmpDistrib
            ENDIF

            SET NULL ON
            CREATE CURSOR TmpDistrib ( ;
                Empdnps  C(33)  NULL, ;
                Grupoos  C(10)  NULL, ;
                Contaos  C(10)  NULL, ;
                Grupods  C(10)  NULL, ;
                Contads  C(10)  NULL, ;
                Nops     N(10,0) NULL, ;
                cMats    C(14)  NULL, ;
                Fators   N(7,4)  NULL, ;
                Qtds     N(9,3)  NULL, ;
                Cretrabs C(6)   NULL, ;
                Retrabs  I      NULL, ;
                CDescs   C(40)  NULL, ;
                Dpros    C(40)  NULL, ;
                DescOrig C(60)  NULL, ;
                DescDest C(60)  NULL  ;
            )
            SET NULL OFF

            *-- SELECT base com where 0=1 para criar estrutura
            loc_cSQL = "SELECT a.Empdnps, c.grupoos, c.contaos, c.grupods, c.contads, " + ;
                       "b.nOps, b.cmats, b.fators, b.qtds, b.cretrabs, c.retrabs, " + ;
                       "b.CDescs, d.Dpros, " + ;
                       "e.Rclis as DescOrig, f.Rclis as DescDest " + ;
                       "FROM SigPdMvf a " + ;
                       "INNER JOIN SigCdNei b ON a.Empdnps = b.Empdnps " + ;
                       "INNER JOIN SigCdNec c ON a.Empdnps = c.Empdnps " + ;
                       "INNER JOIN SigCdPro d ON b.Cmats = d.Cpros " + ;
                       "INNER JOIN SigCdCli e ON c.Contaos = e.Iclis " + ;
                       "INNER JOIN SigCdCli f ON c.Contads = f.Iclis " + ;
                       "WHERE a.Nops = " + FormatarNumeroSQL(loc_nNops, 0) + ;
                       " AND b.servicos = 1 AND b.Cats <> ''"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ServicosTmp") < 1
                THIS.this_cMensagemErro = "Falha ao carregar servi" + CHR(231) + CHR(245) + "os lan" + CHR(231) + "ados."
            ELSE
                SELECT TmpDistrib
                ZAP
                APPEND FROM DBF("cursor_4c_ServicosTmp")
                IF USED("cursor_4c_ServicosTmp")
                    USE IN cursor_4c_ServicosTmp
                ENDIF
                SELECT TmpDistrib
                GO TOP
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarServicosDeXMfas(par_cCursorXMfas)
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cSQL, loc_nNops, loc_oErro, loc_cAlias
        loc_lSucesso = .F.
        loc_cAlias   = IIF(VARTYPE(par_cCursorXMfas) = "C" AND !EMPTY(par_cCursorXMfas), par_cCursorXMfas, "xMfas")

        IF !USED(loc_cAlias)
            THIS.this_cMensagemErro = "Cursor " + loc_cAlias + " n" + CHR(227) + "o est" + CHR(225) + " aberto."
            RETURN .F.
        ENDIF

        TRY
            *-- Criar/recriar cursor TmpDistrib
            IF USED("TmpDistrib")
                TABLEREVERT(.T., "TmpDistrib")
                USE IN TmpDistrib
            ENDIF

            SET NULL ON
            CREATE CURSOR TmpDistrib ( ;
                Empdnps  C(33)  NULL, ;
                Grupoos  C(10)  NULL, ;
                Contaos  C(10)  NULL, ;
                Grupods  C(10)  NULL, ;
                Contads  C(10)  NULL, ;
                Nops     N(10,0) NULL, ;
                cMats    C(14)  NULL, ;
                Fators   N(7,4)  NULL, ;
                Qtds     N(9,3)  NULL, ;
                Cretrabs C(6)   NULL, ;
                Retrabs  I      NULL, ;
                CDescs   C(40)  NULL, ;
                Dpros    C(40)  NULL, ;
                DescOrig C(60)  NULL, ;
                DescDest C(60)  NULL  ;
            )
            SET NULL OFF

            *-- Percorre fases do cursor xMfas (mesmo padr?o do legado)
            SELECT (loc_cAlias)
            SCAN
                loc_nNops = Nops

                loc_cSQL = "SELECT b.Empdnps, c.grupoos, c.contaos, c.grupods, c.contads, " + ;
                           "b.cmats, b.fators, b.qtds, b.cretrabs, c.retrabs, " + ;
                           "b.CDescs, d.dpros, " + ;
                           "e.Rclis as DescOrig, f.Rclis as DescDest " + ;
                           "FROM SigPdMvf a " + ;
                           "INNER JOIN SigCdNei b ON a.Empdnps = b.Empdnps " + ;
                           "INNER JOIN SigCdNec c ON a.Empdnps = c.Empdnps " + ;
                           "INNER JOIN SigCdPro d ON b.Cmats = d.Cpros " + ;
                           "INNER JOIN SigCdCli e ON c.Contaos = e.Iclis " + ;
                           "INNER JOIN SigCdCli f ON c.Contads = f.Iclis " + ;
                           "WHERE a.Nops = " + FormatarNumeroSQL(loc_nNops, 0) + ;
                           " AND b.servicos = 1 AND b.Cats <> ''"

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalMFas4") >= 1
                    SELECT cursor_4c_LocalMFas4
                    SCAN
                        SCATTER MEMO MEMVAR
                        SELECT TmpDistrib
                        INSERT INTO TmpDistrib FROM MEMVAR
                    ENDSCAN
                    IF USED("cursor_4c_LocalMFas4")
                        USE IN cursor_4c_LocalMFas4
                    ENDIF
                ENDIF
            ENDSCAN

            SELECT TmpDistrib
            GO TOP
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Acumular()
    *--------------------------------------------------------------------------
        LOCAL loc_nQtdTotal, loc_nValTotal, loc_oErro
        loc_nQtdTotal = 0
        loc_nValTotal = 0

        TRY
            IF USED("TmpDistrib") AND RECCOUNT("TmpDistrib") > 0
                SELECT SUM(Qtds) AS loc_nQtd, SUM(Qtds * Fators) AS loc_nVal ;
                    FROM TmpDistrib ;
                    INTO CURSOR cursor_4c_Acumulado READWRITE
                IF USED("cursor_4c_Acumulado")
                    SELECT cursor_4c_Acumulado
                    loc_nQtdTotal = NVL(loc_nQtd, 0)
                    loc_nValTotal = NVL(loc_nVal, 0)
                    USE IN cursor_4c_Acumulado
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        THIS.this_nQtdTotal = loc_nQtdTotal
        THIS.this_nValTotal = loc_nValTotal
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cCursorAlias)
    *--------------------------------------------------------------------------
        LOCAL loc_cAlias
        loc_cAlias = IIF(VARTYPE(par_cCursorAlias) = "C" AND !EMPTY(par_cCursorAlias), par_cCursorAlias, "TmpDistrib")

        IF !USED(loc_cAlias)
            RETURN .F.
        ENDIF

        SELECT (loc_cAlias)
        THIS.this_cEmpdnps  = TratarNulo(Empdnps,  "C")
        THIS.this_cGrupoos  = TratarNulo(Grupoos,  "C")
        THIS.this_cContaos  = TratarNulo(Contaos,  "C")
        THIS.this_cGrupods  = TratarNulo(Grupods,  "C")
        THIS.this_cContads  = TratarNulo(Contads,  "C")
        THIS.this_nNops     = TratarNulo(Nops,     "N")
        THIS.this_cCmats    = TratarNulo(cMats,    "C")
        THIS.this_nFators   = TratarNulo(Fators,   "N")
        THIS.this_nQtds     = TratarNulo(Qtds,     "N")
        THIS.this_cCretrabs = TratarNulo(Cretrabs, "C")
        IF VARTYPE(Retrabs) = "L"
            THIS.this_lRetrabs = Retrabs
        ELSE
            IF VARTYPE(Retrabs) = "L"
                THIS.this_lRetrabs = Retrabs
            ELSE
                IF VARTYPE(Retrabs) = "L"
                    THIS.this_lRetrabs = Retrabs
                ELSE
                    THIS.this_lRetrabs = (NVL(Retrabs, 0) = 1)
                ENDIF
            ENDIF
        ENDIF
        THIS.this_cCdescs   = TratarNulo(CDescs,   "C")
        THIS.this_cDpros    = TratarNulo(Dpros,    "C")
        THIS.this_cDescOrig = TratarNulo(DescOrig, "C")
        THIS.this_cDescDest = TratarNulo(DescDest, "C")

        *-- Chave prim?ria opcional (SigCdNei.cidchaves) quando presente no cursor
        IF TYPE(loc_cAlias + ".Cidchaves") != "U"
            THIS.this_cCidchaves = TratarNulo(Cidchaves, "C")
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna cidchaves (char(20)) do registro em SigCdNei
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdNei do servi?o corrente
    *   Persiste os campos do registro carregado (Empdnps, Nops, Cmats, Qtds,
    *   Fators, Cretrabs, CDescs). Marca Servicos=1 e gera chave prim?ria
    *   cidchaves quando ausente.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_cCats, loc_oErro, loc_nResultado
        loc_lSucesso = .F.

        TRY
            *-- Cats = primeiros 6 chars do c?digo do material (padr?o legado)
            loc_cCats = LEFT(THIS.this_cCmats, 6)

            *-- Gera chave prim?ria composta se ainda n?o houver
            IF EMPTY(THIS.this_cCidchaves)
                loc_cChave = LEFT(ALLTRIM(THIS.this_cEmpdnps) + ;
                                  PADL(ALLTRIM(TRANSFORM(THIS.this_nNops)), 10, "0") + ;
                                  ALLTRIM(loc_cCats), 20)
                THIS.this_cCidchaves = loc_cChave
            ENDIF

            loc_cSQL = "INSERT INTO SigCdNei (" + ;
                       "cidchaves, Empdnps, Nops, Cmats, Cats, " + ;
                       "Qtds, Fators, Cretrabs, Cdescs, Servicos, " + ;
                       "Emps, Numps, Dopps" + ;
                       ") VALUES (" + ;
                       EscaparSQL(LEFT(THIS.this_cCidchaves, 20)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cEmpdnps, 33)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNops, 0) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cCmats, 14)) + ", " + ;
                       EscaparSQL(LEFT(loc_cCats, 6)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtds, 3) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nFators, 4) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cCretrabs, 6)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cCdescs, 40)) + ", " + ;
                       "1, " + ;
                       EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumps, 0) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cDopps, 20)) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 1
                THIS.this_cMensagemErro = "Falha ao inserir servi" + CHR(231) + "o em SigCdNei."
            ELSE
                THIS.RegistrarAuditoria("INCLUSAO")
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigCdNei do servi?o corrente por Empdnps+Cmats
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro, loc_nResultado
        loc_lSucesso = .F.

        IF EMPTY(THIS.this_cEmpdnps) OR EMPTY(THIS.this_cCmats)
            THIS.this_cMensagemErro = "Empdnps ou Cmats n" + CHR(227) + "o informado."
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "UPDATE SigCdNei SET " + ;
                       "Nops     = " + FormatarNumeroSQL(THIS.this_nNops, 0) + ", " + ;
                       "Cats     = " + EscaparSQL(LEFT(THIS.this_cCmats, 6)) + ", " + ;
                       "Qtds     = " + FormatarNumeroSQL(THIS.this_nQtds, 3) + ", " + ;
                       "Fators   = " + FormatarNumeroSQL(THIS.this_nFators, 4) + ", " + ;
                       "Cretrabs = " + EscaparSQL(LEFT(THIS.this_cCretrabs, 6)) + ", " + ;
                       "Cdescs   = " + EscaparSQL(LEFT(THIS.this_cCdescs, 40)) + ", " + ;
                       "Servicos = 1 " + ;
                       "WHERE Empdnps = " + EscaparSQL(LEFT(THIS.this_cEmpdnps, 33)) + ;
                       " AND Cmats = " + EscaparSQL(LEFT(THIS.this_cCmats, 14))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 1
                THIS.this_cMensagemErro = "Falha ao atualizar servi" + CHR(231) + "o em SigCdNei."
            ELSE
                THIS.RegistrarAuditoria("ALTERACAO")
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

