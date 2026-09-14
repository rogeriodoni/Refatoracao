# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGREFTP): Top original=498 vs migrado 'lbl_4c_Label10' Top=46 (diff=452px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReFtp.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (957 linhas total):

*-- Linhas 69 a 77:
69:         loc_lSucesso   = .F.
70:         loc_lContinuar = .T.
71:         TRY
72:             THIS.Caption = "Ficha T" + CHR(233) + "cnica do Produto"
73: 
74:             IF TYPE("gc_4c_CaminhoIcones") = "U"
75:                 gc_4c_CaminhoIcones = ""
76:             ENDIF
77:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

*-- Linhas 101 a 110:
101:                 THIS.ConfigurarPaginaLista()
102:                 THIS.ConfigurarPaginaDados()
103: 
104:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
105:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
106: 
107:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
108:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
109:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnDocumentoClick")
110:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")

*-- Linhas 135 a 144:
135:     PROTECTED PROCEDURE ConfigurarPageFrame()
136:         THIS.AddObject("cnt_4c_Corpo", "Container")
137:         WITH THIS.cnt_4c_Corpo
138:             .Top         = 85
139:             .Left        = 0
140:             .Width       = THIS.Width
141:             .Height      = THIS.Height - 85
142:             .BackStyle   = 0
143:             .BorderWidth = 0
144:             .Visible     = .T.

*-- Linhas 152 a 227:
152:     PROTECTED PROCEDURE ConfigurarCabecalho()
153:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
154:         WITH THIS.cnt_4c_Cabecalho
155:             .Top         = 0
156:             .Left        = 0
157:             .Width       = THIS.Width
158:             .Height      = 80
159:             .BackStyle   = 1
160:             .BackColor   = RGB(100, 100, 100)
161:             .BorderWidth = 0
162:             .Visible     = .T.
163: 
164:             .AddObject("lbl_4c_Sombra", "Label")
165:             WITH .lbl_4c_Sombra
166:                 .Top       = 22
167:                 .Left      = 22
168:                 .Width     = THIS.Width
169:                 .Height    = 30
170:                 .Caption   = "Ficha T" + CHR(233) + "cnica do Produto"
171:                 .FontName  = "Tahoma"
172:                 .FontSize  = 14
173:                 .FontBold  = .T.
174:                 .ForeColor = RGB(0, 0, 0)
175:                 .BackStyle = 0
176:                 .Visible   = .T.
177:             ENDWITH
178: 
179:             .AddObject("lbl_4c_Titulo", "Label")
180:             WITH .lbl_4c_Titulo
181:                 .Top       = 20
182:                 .Left      = 20
183:                 .Width     = THIS.Width
184:                 .Height    = 30
185:                 .Caption   = "Ficha T" + CHR(233) + "cnica do Produto"
186:                 .FontName  = "Tahoma"
187:                 .FontSize  = 14
188:                 .FontBold  = .T.
189:                 .ForeColor = RGB(255, 255, 255)
190:                 .BackStyle = 0
191:                 .Visible   = .T.
192:             ENDWITH
193:         ENDWITH
194:     ENDPROC
195: 
196:     *--------------------------------------------------------------------------
197:     * ConfigurarBotoes - CommandGroup com 4 botoes de relatorio
198:     *   Original: BTNREPORT.Left=495, Width=310, 4 botoes de 75px cada
199:     *   Novo:     cmg_4c_Botoes.Left=529, Width=273, 4 botoes de 65px
200:     *   (padrao canonico frmrelatorio - ver regra critica btnReport)
201:     *--------------------------------------------------------------------------
202:     PROTECTED PROCEDURE ConfigurarBotoes()
203:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
204:         WITH THIS.cmg_4c_Botoes
205:             .Top           = 0
206:             .Left          = 529
207:             .Width         = 273
208:             .Height        = 80
209:             .ButtonCount   = 4
210:             .BackStyle     = 0
211:             .BorderStyle   = 0
212:             .BorderColor   = RGB(136, 189, 188)
213:             .SpecialEffect = 1
214:             .Themes        = .F.
215:             .Visible       = .T.
216: 
217:             WITH .Buttons(1)
218:                 .Top             = 5
219:                 .Left            = 5
220:                 .Width           = 65
221:                 .Height          = 70
222:                 .Caption         = "Visualizar"
223:                 .FontBold        = .T.
224:                 .FontItalic      = .T.
225:                 .BackColor       = RGB(255, 255, 255)
226:                 .ForeColor       = RGB(90, 90, 90)
227:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 234 a 246:
234:             ENDWITH
235: 
236:             WITH .Buttons(2)
237:                 .Top             = 5
238:                 .Left            = 71
239:                 .Width           = 65
240:                 .Height          = 70
241:                 .Caption         = "Imprimir"
242:                 .FontName        = "Tahoma"
243:                 .FontBold        = .T.
244:                 .FontItalic      = .T.
245:                 .FontSize        = 8
246:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 255 a 267:
255:             ENDWITH
256: 
257:             WITH .Buttons(3)
258:                 .Top             = 5
259:                 .Left            = 137
260:                 .Width           = 65
261:                 .Height          = 70
262:                 .Caption         = "Documento"
263:                 .FontName        = "Tahoma"
264:                 .FontBold        = .T.
265:                 .FontItalic      = .T.
266:                 .FontSize        = 8
267:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 276 a 288:
276:             ENDWITH
277: 
278:             WITH .Buttons(4)
279:                 .Top             = 5
280:                 .Left            = 203
281:                 .Width           = 65
282:                 .Height          = 70
283:                 .Caption         = "Encerrar"
284:                 .Cancel          = .T.
285:                 .FontName        = "Tahoma"
286:                 .FontBold        = .T.
287:                 .FontItalic      = .T.
288:                 .FontSize        = 8

*-- Linhas 376 a 384:
376:     *--------------------------------------------------------------------------
377:     * BtnAlterarClick - Alterna marca do processo corrente (toggle lMarca)
378:     *   Form REPORT (frmrelatorio): "Alterar" no contexto de selecao significa
379:     *   inverter a marca do registro corrente no grid, refletindo no checkbox.
380:     *--------------------------------------------------------------------------
381:     PROCEDURE BtnAlterarClick()
382:         LOCAL loc_lAtual
383:         TRY
384:             IF !USED("cursor_4c_SelSigReFtp") OR EOF("cursor_4c_SelSigReFtp")

*-- Linhas 423 a 444:
423:     *
424:     *   Posicoes originais (relativas ao form); ajustadas para cnt_4c_Corpo (Top=85):
425:     *     grd_4c_Dados:    top=79  (164-85), left=385, w=318, h=387
426:     *     cmd_4c_SelTodos: top=228 (313-85), left=707, w=100, h=25
427:     *     cmd_4c_LimparSel:top=268 (353-85), left=707, w=100, h=25
428:     *--------------------------------------------------------------------------
429:     PROTECTED PROCEDURE ConfigurarPaginaLista()
430:         LOCAL loc_oCorp, loc_oGrid
431:         TRY
432:             loc_oCorp = THIS.cnt_4c_Corpo
433: 
434:             *-- Grid de processos (GrdProc no legado)
435:             loc_oCorp.AddObject("grd_4c_Dados", "Grid")
436:             loc_oGrid = loc_oCorp.grd_4c_Dados
437:             WITH loc_oGrid
438:                 .Top                = 79
439:                 .Left               = 385
440:                 .Width              = 318
441:                 .Height             = 387
442:                 .ColumnCount        = 4
443:                 .RecordMark         = .F.
444:                 .DeleteMark         = .F.

*-- Linhas 450 a 465:
450:                 .FontName           = "Verdana"
451:                 .FontSize           = 8
452: 
453:                 *-- Column1: CheckBox de selecao (lMarca)
454:                 *   Ordem OBRIGATORIO: AddObject ANTES de CurrentControl,
455:                 *   ControlSource SOMENTE apos CurrentControl (Error 1767)
456:                 WITH .Column1
457:                     .Width          = 35
458:                     .Resizable      = .F.
459:                     .AddObject("Check1", "CheckBox")
460:                     .Check1.Caption = ""
461:                     .Check1.Value   = 0
462:                     .CurrentControl = "Check1"
463:                     .ControlSource  = "cursor_4c_SelSigReFtp.lMarca"
464:                 ENDWITH
465: 

*-- Linhas 495 a 551:
495:                 .Column4.ControlSource = "cursor_4c_SelSigReFtp.Descrps"
496: 
497:                 *-- Redefinir cabecalhos APOS RecordSource (obrigatorio)
498:                 .Column1.Header1.Caption = ""
499:                 .Column2.Header1.Caption = "Ordem"
500:                 .Column3.Header1.Caption = "Grupo"
501:                 .Column4.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
502: 
503:                 .Visible = .T.
504:             ENDWITH
505: 
506:             *-- Botao Selecionar Todos (cmdSel no legado)
507:             loc_oCorp.AddObject("cmd_4c_SelTodos", "CommandButton")
508:             WITH loc_oCorp.cmd_4c_SelTodos
509:                 .Top           = 228
510:                 .Left          = 707
511:                 .Width         = 100
512:                 .Height        = 25
513:                 .Caption       = "Selecionar Todos"
514:                 .FontName      = "Tahoma"
515:                 .FontSize      = 8
516:                 .BackColor     = RGB(255, 255, 255)
517:                 .ForeColor     = RGB(90, 90, 90)
518:                 .Themes        = .F.
519:                 .SpecialEffect = 0
520:                 .Visible       = .T.
521:             ENDWITH
522: 
523:             *-- Botao Limpar Selecao (CmdApg no legado)
524:             loc_oCorp.AddObject("cmd_4c_LimparSel", "CommandButton")
525:             WITH loc_oCorp.cmd_4c_LimparSel
526:                 .Top           = 268
527:                 .Left          = 707
528:                 .Width         = 100
529:                 .Height        = 25
530:                 .Caption       = "Limpar Sele" + CHR(231) + CHR(227) + "o"
531:                 .FontName      = "Tahoma"
532:                 .FontSize      = 8
533:                 .BackColor     = RGB(255, 255, 255)
534:                 .ForeColor     = RGB(90, 90, 90)
535:                 .Themes        = .F.
536:                 .SpecialEffect = 0
537:                 .Visible       = .T.
538:             ENDWITH
539: 
540:             *-- BINDEVENTs: grid, checkbox da coluna 1, botoes auxiliares
541:             BINDEVENT(loc_oCorp.grd_4c_Dados, "AfterRowColChange", ;
542:                 THIS, "GrdAfterRowColChange")
543:             BINDEVENT(loc_oCorp.grd_4c_Dados.Column1.Check1, "Click", ;
544:                 THIS, "GrdCheckClick")
545:             BINDEVENT(loc_oCorp.cmd_4c_SelTodos,  "Click", THIS, "BtnSelTodosClick")
546:             BINDEVENT(loc_oCorp.cmd_4c_LimparSel, "Click", THIS, "BtnLimparSelClick")
547: 
548:         CATCH TO loc_oErro
549:             MsgErro(loc_oErro.Message + CHR(13) + ;
550:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
551:                 "Procedure: " + loc_oErro.Procedure, ;

*-- Linhas 559 a 599:
559:     *   Controles adicionados em cnt_4c_Corpo (Top=85).
560:     *   Coordenadas: top_relativo = top_original - 85 (cnt_4c_Corpo.Top).
561:     *
562:     *   lbl_4c_Label10 (Say10):  top=46, left=58  (original 131-85=46)
563:     *   txt_4c_Cpro    (getCpro): top=43, left=114 (original 128-85=43)
564:     *   txt_4c_Dpro    (getDpro): top=43, left=223 (original 128-85=43)
565:     *   img_4c_FigJpg  (ImgFigJpg): top=79, left=53 (original 164-85=79)
566:     *     img_4c_FigJpg comeca invisivel; GrdAfterRowColChange controla exibicao.
567:     *--------------------------------------------------------------------------
568:     PROTECTED PROCEDURE ConfigurarPaginaDados()
569:         LOCAL loc_oCorp
570:         TRY
571:             loc_oCorp = THIS.cnt_4c_Corpo
572: 
573:             *-- Label "Produto :" (Say10 no legado)
574:             loc_oCorp.AddObject("lbl_4c_Label10", "Label")
575:             WITH loc_oCorp.lbl_4c_Label10
576:                 .Top       = 46
577:                 .Left      = 58
578:                 .Width     = 53
579:                 .Height    = 15
580:                 .Caption   = "Produto :"
581:                 .FontName  = "Tahoma"
582:                 .FontSize  = 8
583:                 .FontBold  = .T.
584:                 .ForeColor = RGB(90, 90, 90)
585:                 .BackStyle = 0
586:                 .Visible   = .T.
587:             ENDWITH
588: 
589:             *-- Codigo do produto - somente leitura (getCpro no legado)
590:             *   Recebe this_cCodProd passado ao Init pelo form chamador
591:             loc_oCorp.AddObject("txt_4c_Cpro", "TextBox")
592:             WITH loc_oCorp.txt_4c_Cpro
593:                 .Top               = 43
594:                 .Left              = 114
595:                 .Width             = 108
596:                 .Height            = 23
597:                 .Value             = THIS.this_cCodProd
598:                 .Enabled           = .F.
599:                 .ReadOnly          = .T.

*-- Linhas 610 a 619:
610:             *   Recebe this_cNomProd passado ao Init pelo form chamador
611:             loc_oCorp.AddObject("txt_4c_Dpro", "TextBox")
612:             WITH loc_oCorp.txt_4c_Dpro
613:                 .Top               = 43
614:                 .Left              = 223
615:                 .Width             = 384
616:                 .Height            = 23
617:                 .Value             = THIS.this_cNomProd
618:                 .Enabled           = .F.
619:                 .ReadOnly          = .T.

*-- Linhas 631 a 640:
631:             *   via STRTOFILE(FigProcs, arq) -> img_4c_FigJpg.Picture = arq
632:             loc_oCorp.AddObject("img_4c_FigJpg", "Image")
633:             WITH loc_oCorp.img_4c_FigJpg
634:                 .Top     = 79
635:                 .Left    = 53
636:                 .Width   = 320
637:                 .Height  = 199
638:                 .Stretch = 1
639:                 .Picture = ""
640:                 .Enabled = .F.

*-- Linhas 646 a 655:
646:             *   Top relativo: 370-85=285
647:             loc_oCorp.AddObject("edt_4c_Obs", "EditBox")
648:             WITH loc_oCorp.edt_4c_Obs
649:                 .Top               = 285
650:                 .Left              = 52
651:                 .Width             = 321
652:                 .Height            = 112
653:                 .ReadOnly          = .T.
654:                 .ControlSource     = "cursor_4c_SelSigReFtp.Obs"
655:                 .FontName          = "Tahoma"

*-- Linhas 663 a 715:
663: 
664:             *-- Label "Tipo de Ficha :" (Label1 no legado)
665:             *   Top relativo: 498-85=413
666:             loc_oCorp.AddObject("lbl_4c_TpRel", "Label")
667:             WITH loc_oCorp.lbl_4c_TpRel
668:                 .Top       = 413
669:                 .Left      = 52
670:                 .Width     = 125
671:                 .Height    = 14
672:                 .Caption   = "Tipo de Ficha :"
673:                 .FontName  = "Tahoma"
674:                 .FontSize  = 8
675:                 .FontBold  = .T.
676:                 .ForeColor = RGB(90, 90, 90)
677:                 .BackStyle = 0
678:                 .Visible   = .T.
679:             ENDWITH
680: 
681:             *-- OptionGroup Reduzida/Expandida (OptTpRel no legado)
682:             *   Top relativo: 497-85=412
683:             loc_oCorp.AddObject("opt_4c_TpRel", "OptionGroup")
684:             WITH loc_oCorp.opt_4c_TpRel
685:                 .Top         = 412
686:                 .Left        = 183
687:                 .Width       = 87
688:                 .Height      = 36
689:                 .ButtonCount = 2
690:                 .BackStyle   = 0
691:                 .BorderStyle = 0
692:                 .Value       = 1
693:                 .Visible     = .T.
694: 
695:                 WITH .Buttons(1)
696:                     .Caption   = "Reduzida"
697:                     .Value     = 1
698:                     .Height    = 17
699:                     .Left      = 5
700:                     .Top       = 1
701:                     .Width     = 79
702:                     .BackStyle = 0
703:                     .ForeColor = RGB(90, 90, 90)
704:                 ENDWITH
705: 
706:                 WITH .Buttons(2)
707:                     .Caption   = "Expandida"
708:                     .Height    = 17
709:                     .Left      = 5
710:                     .Top       = 20
711:                     .Width     = 80
712:                     .FontName  = "Tahoma"
713:                     .FontSize  = 8
714:                     .BackStyle = 0
715:                     .ForeColor = RGB(90, 90, 90)

*-- Linhas 772 a 780:
772:     ENDPROC
773: 
774:     *--------------------------------------------------------------------------
775:     * GrdCheckClick - Sincroniza lMarca do cursor com o valor do checkbox
776:     *   Equivalente ao GrdProc.Column1.Check1.Click do legado:
777:     *     Replace csSelekTon.lMarca With This.Value In csSelekTon
778:     *--------------------------------------------------------------------------
779:     PROCEDURE GrdCheckClick()
780:         LOCAL loc_lNovaMarca, loc_nVal


### BO (C:\4c\projeto\app\classes\SigReFtpBO.prg):
*==============================================================================
* SIGREFTPBO.PRG
* Business Object para Relatorio - Ficha Tecnica do Produto
* Herda de RelatorioBase
*
* Descricao:
*   Gerencia a logica do relatorio SigReFtp (Ficha Tecnica do Produto).
*   Recebe parametros pcProd/pdProd do form chamador.
*   Utiliza cursor csDetalhes ja aberto no contexto do chamador para montar
*   cursor de selecao cursor_4c_SelSigReFtp, onde o usuario marca/desmarca
*   processos antes de imprimir.
*   Suporta dois layouts: Reduzida (SigReFtp.frx) e Expandida (SigReFt1.frx).
*==============================================================================

DEFINE CLASS SigReFtpBO AS RelatorioBase

    *-- Referencia ao cursor fonte (csDetalhes do contexto chamador)
    this_cTabela          = "csDetalhes"
    this_cCampoChave      = "Ordems"
    this_cMensagemErro    = ""

    *-- Parametros de entrada (populados pelo form via FormParaRelatorio)
    this_cCodProd         = ""   && Codigo do produto (pcProd)
    this_cNomProd         = ""   && Descricao do produto (pdProd)

    *-- Configuracao do relatorio
    this_nTipoRelatorio   = 1    && 1=Reduzida (SigReFtp.frx), 2=Expandida (SigReFt1.frx)

    *-- Cursor de selecao (equivalente ao csSelekTon do legado)
    this_cCursorSel       = "cursor_4c_SelSigReFtp"

    *-- Paths dos arquivos FRX (configurados no Init)
    this_cArqRelReduzido  = ""
    this_cArqRelExpandido = ""

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cArqRelReduzido  = gc_4c_CaminhoReports + "SigReFtp.frx"
            THIS.this_cArqRelExpandido = gc_4c_CaminhoReports + "SigReFt1.frx"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarCursorSelecao - Cria cursor de selecao a partir de csDetalhes
    * Equivalente ao bloco SELECT/INDEX do Init() legado.
    * par_cCodProd: Codigo do produto
    * par_cNomProd: Descricao do produto
    *--------------------------------------------------------------------------
    PROCEDURE InicializarCursorSelecao(par_cCodProd, par_cNomProd)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !USED("csDetalhes")
                THIS.this_cMensagemErro = "Cursor csDetalhes n" + CHR(227) + ;
                    "o est" + CHR(225) + " aberto"
                loc_lSucesso = .F.
            ENDIF

            THIS.this_cCodProd = ALLTRIM(NVL(par_cCodProd, ""))
            THIS.this_cNomProd = ALLTRIM(NVL(par_cNomProd, ""))

            *-- Fecha cursor anterior se existir
            IF USED(THIS.this_cCursorSel)
                USE IN (THIS.this_cCursorSel)
            ENDIF

            *-- Cria cursor de selecao com coluna lMarca adicional
            SELECT .F. AS lMarca, * ;
              FROM csDetalhes ;
              INTO CURSOR (THIS.this_cCursorSel) READWRITE

            *-- Cria indice para busca por Ordem+Grupo (mesmo do legado)
            SELECT (THIS.this_cCursorSel)
            INDEX ON STR(Ordems, 2) + Grupos TAG OrdGru
            GO TOP

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Filtra csDetalhes com base nas marcacoes do usuario
    * Equivalente ao 'processamento' do legado:
    *   Recall All em csDetalhes, depois deleta os nao marcados
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cCursorSel
        loc_lSucesso  = .F.
        loc_cCursorSel = THIS.this_cCursorSel
        TRY
            IF !USED("csDetalhes")
                THIS.this_cMensagemErro = "Cursor csDetalhes n" + CHR(227) + ;
                    "o est" + CHR(225) + " aberto"
                loc_lSucesso = .F.
            ENDIF
            IF !USED(loc_cCursorSel)
                THIS.this_cMensagemErro = "Cursor de sele" + CHR(231) + CHR(227) + ;
                    "o n" + CHR(227) + "o inicializado"
                loc_lSucesso = .F.
            ENDIF

            *-- Restaura todos os registros deletados anteriormente
            SELECT csDetalhes
            RECALL ALL

            *-- Varre csDetalhes e deleta registros nao selecionados
            SCAN
                IF SEEK(STR(csDetalhes.Ordems, 2) + csDetalhes.Grupos, ;
                        loc_cCursorSel, "OrdGru")
                    IF !EVALUATE(loc_cCursorSel + ".lMarca")
                        DELETE IN csDetalhes
                    ENDIF
                ENDIF
            ENDSCAN

            *-- Posiciona no inicio de todos os cursores (igual ao legado)
            GO TOP IN (loc_cCursorSel)
            IF USED("csCabecalho")
                GO TOP IN csCabecalho
            ENDIF
            GO TOP IN csDetalhes

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe relatorio em modo preview (PREVIEW NOCONSOLE)
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            IF THIS.this_nTipoRelatorio = 1
                REPORT FORM (THIS.this_cArqRelReduzido) PREVIEW NOCONSOLE
            ELSE
                REPORT FORM (THIS.this_cArqRelExpandido) PREVIEW NOCONSOLE
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime relatorio com prompt de impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            IF THIS.this_nTipoRelatorio = 1
                REPORT FORM (THIS.this_cArqRelReduzido) TO PRINTER PROMPT NOCONSOLE
            ELSE
                REPORT FORM (THIS.this_cArqRelExpandido) TO PRINTER PROMPT NOCONSOLE
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Documento - Imprime relatorio direto sem prompt
    *--------------------------------------------------------------------------
    PROCEDURE Documento()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            IF THIS.this_nTipoRelatorio = 1
                REPORT FORM (THIS.this_cArqRelReduzido) TO PRINTER
            ELSE
                REPORT FORM (THIS.this_cArqRelExpandido) TO PRINTER
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarTodos - Seleciona todos os processos (cmdSel.Click do legado)
    *--------------------------------------------------------------------------
    PROCEDURE MarcarTodos()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !USED(THIS.this_cCursorSel)
                loc_lSucesso = .F.
            ENDIF
            REPLACE ALL lMarca WITH .T. IN (THIS.this_cCursorSel)
            GO TOP IN (THIS.this_cCursorSel)
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarTodos - Desmarca todos os processos (CmdApg.Click do legado)
    *--------------------------------------------------------------------------
    PROCEDURE DesmarcarTodos()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !USED(THIS.this_cCursorSel)
                loc_lSucesso = .F.
            ENDIF
            REPLACE ALL lMarca WITH .F. IN (THIS.this_cCursorSel)
            GO TOP IN (THIS.this_cCursorSel)
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna codigo do produto (chave de contexto)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCodProd
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha cursor de selecao proprio (NAO fecha csDetalhes)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorSel)
            USE IN (THIS.this_cCursorSel)
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

