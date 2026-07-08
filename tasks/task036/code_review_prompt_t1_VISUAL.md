# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Cabecalho' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_TmpInc' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREAUP.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1606 linhas total):

*-- Linhas 103 a 119:
103:                 *-- PageFrame de 1 pagina ("Filtros") - hospeda os campos de filtro
104:                 THIS.ConfigurarPageFrame()
105: 
106:                 *-- Campos de filtro dentro da Page1 (TextBoxes, OptionGroup, CheckBox)
107:                 THIS.ConfigurarCamposFiltro()
108: 
109:                 *-- BINDEVENTs de lookup nos campos de filtro (Fase 5)
110:                 THIS.ConfigurarPaginaDados()
111: 
112:                 *-- Garantir captions do cabecalho coerentes
113:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
114:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
115: 
116:                 *-- Inicializa filtros do BO (pula em modo validacao UI)
117:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
118:                     THIS.LimparCampos()
119:                 ENDIF

*-- Linhas 141 a 181:
141:     PROTECTED PROCEDURE ConfigurarCabecalho()
142:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
143:         WITH THIS.cnt_4c_Cabecalho
144:             .Top         = 0
145:             .Left        = 0
146:             .Width       = THIS.Width
147:             .Height      = 80
148:             .BackColor   = RGB(100, 100, 100)
149:             .BackStyle   = 1
150:             .BorderWidth = 0
151:             .Visible     = .T.
152:         ENDWITH
153: 
154:         *-- Sombra do texto (efeito 3D - texto preto ligeiramente deslocado)
155:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
156:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
157:             .Top       = 17
158:             .Left      = 12
159:             .AutoSize  = .T.
160:             .Caption   = "Relat" + CHR(243) + "rio de Tipos de Autoriza" + ;
161:                          CHR(231) + CHR(245) + "es de Produ" + CHR(231) + CHR(227) + "o"
162:             .FontName  = "Tahoma"
163:             .FontSize  = 14
164:             .FontBold  = .T.
165:             .ForeColor = RGB(0, 0, 0)
166:             .BackStyle = 0
167:             .Visible   = .T.
168:         ENDWITH
169: 
170:         *-- Titulo principal (texto branco sobre fundo cinza escuro)
171:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
172:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
173:             .Top       = 20
174:             .Left      = 10
175:             .AutoSize  = .T.
176:             .Caption   = "Relat" + CHR(243) + "rio de Tipos de Autoriza" + ;
177:                          CHR(231) + CHR(245) + "es de Produ" + CHR(231) + CHR(227) + "o"
178:             .FontName  = "Tahoma"
179:             .FontSize  = 14
180:             .FontBold  = .T.
181:             .ForeColor = RGB(255, 255, 255)

*-- Linhas 194 a 203:
194:     PROTECTED PROCEDURE ConfigurarBotoes()
195:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
196:         WITH THIS.cmg_4c_Botoes
197:             .Top           = 0
198:             .Left          = 528
199:             .Width         = 273
200:             .Height        = 80
201:             .ButtonCount   = 4
202:             .BackStyle     = 0
203:             .BorderStyle   = 0

*-- Linhas 209 a 221:
209: 
210:         *-- Botao 1: Visualizar (preview na tela)
211:         WITH THIS.cmg_4c_Botoes.Buttons(1)
212:             .Top             = 5
213:             .Left            = 5
214:             .Width           = 65
215:             .Height          = 70
216:             .Caption         = "Visualizar"
217:             .FontName        = "Tahoma"
218:             .FontBold        = .T.
219:             .FontItalic      = .T.
220:             .FontSize        = 8
221:             .ForeColor       = RGB(90, 90, 90)

*-- Linhas 231 a 243:
231: 
232:         *-- Botao 2: Imprimir (com dialogo de selecao de impressora)
233:         WITH THIS.cmg_4c_Botoes.Buttons(2)
234:             .Top             = 5
235:             .Left            = 71
236:             .Width           = 65
237:             .Height          = 70
238:             .Caption         = "Imprimir"
239:             .FontName        = "Tahoma"
240:             .FontBold        = .T.
241:             .FontItalic      = .T.
242:             .FontSize        = 8
243:             .ForeColor       = RGB(90, 90, 90)

*-- Linhas 253 a 265:
253: 
254:         *-- Botao 3: Documento (impressao direta sem dialogo)
255:         WITH THIS.cmg_4c_Botoes.Buttons(3)
256:             .Top             = 5
257:             .Left            = 137
258:             .Width           = 65
259:             .Height          = 70
260:             .Caption         = "Documento"
261:             .FontName        = "Tahoma"
262:             .FontBold        = .T.
263:             .FontItalic      = .T.
264:             .FontSize        = 8
265:             .ForeColor       = RGB(90, 90, 90)

*-- Linhas 275 a 287:
275: 
276:         *-- Botao 4: Encerrar (ESC fecha via .Cancel = .T.)
277:         WITH THIS.cmg_4c_Botoes.Buttons(4)
278:             .Top             = 5
279:             .Left            = 203
280:             .Width           = 65
281:             .Height          = 70
282:             .Caption         = "Encerrar"
283:             .FontName        = "Tahoma"
284:             .FontBold        = .T.
285:             .FontItalic      = .T.
286:             .FontSize        = 8
287:             .ForeColor       = RGB(90, 90, 90)

*-- Linhas 304 a 331:
304:     *   consistencia visual e arquitetural com o restante do sistema.
305:     *
306:     *   O PageFrame fica logo abaixo do cabecalho (Top=85) e cobre o restante
307:     *   do form ate o bottom. Os filtros (TextBoxes, OptionGroup, CheckBox)
308:     *   serao adicionados DENTRO da Page1 nas Fases 5-6.
309:     *--------------------------------------------------------------------------
310:     PROTECTED PROCEDURE ConfigurarPageFrame()
311:         LOCAL loc_oPgf
312: 
313:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
314:         loc_oPgf = THIS.pgf_4c_Paginas
315: 
316:         *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
317:         loc_oPgf.PageCount = 1
318: 
319:         *-- Logo abaixo do cabecalho (80px) ate o fim do form
320:         loc_oPgf.Top    = 85
321:         loc_oPgf.Left   = -1
322:         loc_oPgf.Width  = THIS.Width + 2
323:         loc_oPgf.Height = THIS.Height - 85
324:         loc_oPgf.Tabs   = .F.
325: 
326:         loc_oPgf.Page1.Caption   = "Filtros"
327:         loc_oPgf.Page1.FontName  = "Tahoma"
328:         loc_oPgf.Page1.FontSize  = 8
329:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
330:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
331:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 447 a 455:
447:     *   permitir nova selecao de criterios.
448:     *
449:     *   Reset completo: datas voltam para DATE() (hoje), codigos vazios,
450:     *   OptionGroup volta para opcao 1, CheckBox de percentual desmarcado.
451:     *--------------------------------------------------------------------------
452:     PROCEDURE BtnIncluirClick()
453:         THIS.LimparCampos()
454:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
455:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "txt_4c_DtInicial", 5)

*-- Linhas 518 a 531:
518:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
519: 
520:         *-- Label Periodo (form top=111 -> page top=26)
521:         loc_oPagina.AddObject("lbl_4c_Periodo", "Label")
522:         WITH loc_oPagina.lbl_4c_Periodo
523:             .AutoSize  = .T.
524:             .Caption   = "Per" + CHR(237) + "odo :"
525:             .Top       = 26
526:             .Left      = 199
527:             .FontName  = "Tahoma"
528:             .FontSize  = 8
529:             .ForeColor = RGB(90, 90, 90)
530:             .BackStyle = 0
531:             .Visible   = .T.

*-- Linhas 539 a 561:
539:             .Format        = "K"
540:             .Height        = 23
541:             .Width         = 80
542:             .Left          = 249
543:             .Top           = 23
544:             .ForeColor     = RGB(0, 0, 0)
545:             .SpecialEffect = 1
546:             .Value         = DATE()
547:             .Visible       = .T.
548:         ENDWITH
549: 
550:         *-- Separador "a" entre datas (form top=111 -> page top=26)
551:         loc_oPagina.AddObject("lbl_4c_PeriodoA", "Label")
552:         WITH loc_oPagina.lbl_4c_PeriodoA
553:             .AutoSize  = .T.
554:             .Caption   = CHR(224)
555:             .Top       = 26
556:             .Left      = 334
557:             .FontName  = "Tahoma"
558:             .FontSize  = 8
559:             .ForeColor = RGB(90, 90, 90)
560:             .BackStyle = 0
561:             .Visible   = .T.

*-- Linhas 569 a 591:
569:             .Format        = "K"
570:             .Height        = 23
571:             .Width         = 80
572:             .Left          = 348
573:             .Top           = 23
574:             .ForeColor     = RGB(0, 0, 0)
575:             .SpecialEffect = 1
576:             .Value         = DATE()
577:             .Visible       = .T.
578:         ENDWITH
579: 
580:         *-- Label Grupo (form top=136 -> page top=51)
581:         loc_oPagina.AddObject("lbl_4c_LblGrupo", "Label")
582:         WITH loc_oPagina.lbl_4c_LblGrupo
583:             .AutoSize  = .T.
584:             .Caption   = "Grupo :"
585:             .Top       = 51
586:             .Left      = 206
587:             .FontName  = "Tahoma"
588:             .FontSize  = 8
589:             .ForeColor = RGB(90, 90, 90)
590:             .BackStyle = 0
591:             .Visible   = .T.

*-- Linhas 599 a 608:
599:             .Format        = "K!"
600:             .Height        = 23
601:             .Width         = 80
602:             .Left          = 249
603:             .Top           = 48
604:             .ForeColor     = RGB(0, 0, 0)
605:             .SpecialEffect = 1
606:             .MaxLength     = 10
607:             .Value         = ""
608:             .Visible       = .T.

*-- Linhas 617 a 641:
617:             .Format        = "K!"
618:             .Height        = 23
619:             .Width         = 150
620:             .Left          = 330
621:             .Top           = 48
622:             .ForeColor     = RGB(0, 0, 0)
623:             .SpecialEffect = 1
624:             .MaxLength     = 20
625:             .Value         = ""
626:             .Enabled       = .T.
627:             .Visible       = .T.
628:         ENDWITH
629: 
630:         *-- Label Conta (form top=160 -> page top=75)
631:         loc_oPagina.AddObject("lbl_4c_LblConta", "Label")
632:         WITH loc_oPagina.lbl_4c_LblConta
633:             .AutoSize  = .T.
634:             .Caption   = "Conta :"
635:             .Top       = 75
636:             .Left      = 206
637:             .FontName  = "Tahoma"
638:             .FontSize  = 8
639:             .ForeColor = RGB(90, 90, 90)
640:             .BackStyle = 0
641:             .Visible   = .T.

*-- Linhas 649 a 658:
649:             .FontSize      = 8
650:             .Height        = 23
651:             .Width         = 80
652:             .Left          = 249
653:             .Top           = 72
654:             .ForeColor     = RGB(0, 0, 0)
655:             .SpecialEffect = 1
656:             .Value         = ""
657:             .Enabled       = .F.
658:             .Visible       = .T.

*-- Linhas 666 a 689:
666:             .FontSize      = 8
667:             .Height        = 23
668:             .Width         = 290
669:             .Left          = 330
670:             .Top           = 72
671:             .ForeColor     = RGB(0, 0, 0)
672:             .SpecialEffect = 1
673:             .Value         = ""
674:             .Enabled       = .F.
675:             .Visible       = .T.
676:         ENDWITH
677: 
678:         *-- Label O.S. / Envelope (form top=183 -> page top=98)
679:         loc_oPagina.AddObject("lbl_4c_OS", "Label")
680:         WITH loc_oPagina.lbl_4c_OS
681:             .AutoSize  = .T.
682:             .Caption   = "O.S. :"
683:             .Top       = 98
684:             .Left      = 213
685:             .FontName  = "Tahoma"
686:             .FontSize  = 8
687:             .ForeColor = RGB(90, 90, 90)
688:             .BackStyle = 0
689:             .Visible   = .T.

*-- Linhas 700 a 721:
700:             .InputMask     = ""
701:             .Height        = 23
702:             .Width         = 80
703:             .Left          = 249
704:             .Top           = 95
705:             .ForeColor     = RGB(0, 0, 0)
706:             .SpecialEffect = 1
707:             .Visible       = .T.
708:         ENDWITH
709: 
710:         *-- Label Codigo NCF (form top=207 -> page top=122)
711:         loc_oPagina.AddObject("lbl_4c_LblCodigo", "Label")
712:         WITH loc_oPagina.lbl_4c_LblCodigo
713:             .AutoSize  = .T.
714:             .Caption   = "C" + CHR(243) + "digo :"
715:             .Top       = 122
716:             .Left      = 202
717:             .FontName  = "Tahoma"
718:             .FontSize  = 8
719:             .ForeColor = RGB(90, 90, 90)
720:             .BackStyle = 0
721:             .Visible   = .T.

*-- Linhas 730 a 770:
730:             .Format        = "K"
731:             .Height        = 23
732:             .Width         = 80
733:             .Left          = 249
734:             .Top           = 119
735:             .MaxLength     = 10
736:             .ForeColor     = RGB(0, 0, 0)
737:             .SpecialEffect = 1
738:             .Value         = ""
739:             .Visible       = .T.
740:         ENDWITH
741: 
742:         *-- CheckBox Em Percentual (%) (form top=209 -> page top=124)
743:         loc_oPagina.AddObject("chk_4c_Percent", "CheckBox")
744:         WITH loc_oPagina.chk_4c_Percent
745:             .Top       = 124
746:             .Left      = 455
747:             .Height    = 15
748:             .Width     = 108
749:             .FontName  = "Tahoma"
750:             .FontSize  = 8
751:             .AutoSize  = .T.
752:             .Alignment = 0
753:             .BackStyle = 0
754:             .Caption   = "Em Percentual (%)"
755:             .ForeColor = RGB(90, 90, 90)
756:             .Value     = 0
757:             .Visible   = .T.
758:         ENDWITH
759: 
760:         *-- Label Quebra (form top=234 -> page top=149)
761:         loc_oPagina.AddObject("lbl_4c_Quebra", "Label")
762:         WITH loc_oPagina.lbl_4c_Quebra
763:             .Caption   = "Quebra :"
764:             .Top       = 149
765:             .Left      = 199
766:             .Width     = 45
767:             .FontName  = "Tahoma"
768:             .FontSize  = 8
769:             .ForeColor = RGB(90, 90, 90)
770:             .BackStyle = 0

*-- Linhas 780 a 814:
780:             .BorderStyle = 0
781:             .Height      = 25
782:             .Width       = 224
783:             .Left        = 245
784:             .Top         = 144
785:             .BackStyle   = 0
786:             .ForeColor   = RGB(90, 90, 90)
787:             .Value       = 1
788:             .Visible     = .T.
789:         ENDWITH
790:         WITH loc_oPagina.opt_4c_Ordem.Buttons(1)
791:             .Caption  = "Grupo/conta"
792:             .BackStyle = 0
793:             .Height   = 15
794:             .Left     = 5
795:             .Style    = 0
796:             .Top      = 5
797:             .Width    = 78
798:             .AutoSize = .T.
799:             .FontName = "Tahoma"
800:             .FontSize = 8
801:             .Visible  = .T.
802:         ENDWITH
803:         WITH loc_oPagina.opt_4c_Ordem.Buttons(2)
804:             .Caption  = "Tipo de Autoriza" + CHR(231) + CHR(227) + "o"
805:             .BackStyle = 0
806:             .Height   = 15
807:             .Left     = 101
808:             .Style    = 0
809:             .Top      = 5
810:             .Width    = 113
811:             .AutoSize = .T.
812:             .FontName = "Tahoma"
813:             .FontSize = 8
814:             .Visible  = .T.

*-- Linhas 1549 a 1566:
1549:         ENDIF
1550: 
1551:         WITH THIS.this_oRelatorio
1552:             loc_oPagina.txt_4c_DtInicial.Value  = .this_dDtInicial
1553:             loc_oPagina.txt_4c_DtFinal.Value    = .this_dDtFinal
1554:             loc_oPagina.txt_4c_Grupo.Value      = .this_cGrupo
1555:             loc_oPagina.txt_4c_DGrupo.Value     = .this_cDGrupo
1556:             loc_oPagina.txt_4c_Conta.Value      = .this_cConta
1557:             loc_oPagina.txt_4c_DConta.Value     = .this_cDConta
1558:             loc_oPagina.txt_4c_Envelope.Value   = .this_nEnvelope
1559:             loc_oPagina.txt_4c_Codigo.Value     = .this_cCodigo
1560:             loc_oPagina.opt_4c_Ordem.Value      = .this_nOrdem
1561:             loc_oPagina.chk_4c_Percent.Value    = .this_nPercent
1562:         ENDWITH
1563: 
1564:         THIS.AtualizarEstadoCampos()
1565:     ENDPROC
1566: 


### BO (C:\4c\projeto\app\classes\SIGREAUPBO.prg):
*==============================================================================
* SIGREAUPBO.PRG
* Business Object - Relatorio de Tipos de Autorizacoes de Producao
* Herda de RelatorioBase
*
* Filtros: Periodo, Grupo, Conta, Envelope, Codigo NCF, Ordem, Percentual
* Tabela principal: SigOpInc (joins: SigCdNcf, SigCdCli)
* Reports: SigReAu1 (listagem), SigReAu2 (percentual)
*==============================================================================

DEFINE CLASS SIGREAUPBO AS RelatorioBase

    *-- Identificacao
    this_cTabela        = "SigOpInc"
    this_cCampoChave    = ""
    this_cMensagemErro  = ""

    *-- Filtros de periodo
    this_dDtInicial     = {}
    this_dDtFinal       = {}

    *-- Filtro de grupo (codigo + descricao para lookup bidirecional)
    this_cGrupo         = ""
    this_cDGrupo        = ""

    *-- Filtro de conta (codigo + descricao para lookup bidirecional)
    this_cConta         = ""
    this_cDConta        = ""

    *-- Filtro de envelope (numerico)
    this_nEnvelope      = 0

    *-- Filtro de codigo NCF
    this_cCodigo        = ""

    *-- Opcao de ordem: 1=Grupo/Conta, 2=Tipo de Autorizacao
    this_nOrdem         = 1

    *-- Exibir em percentual: 0=nao, 1=sim
    this_nPercent       = 0

    *-- Nome do cursor principal de dados gerado por PrepararDados
    this_cCursorDados   = "cursor_4c_SigOpInc"

    *--------------------------------------------------------------------------
    * Init - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro da ultima operacao
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida filtros obrigatorios antes de gerar relatorio
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFiltros()
        IF EMPTY(THIS.this_dDtInicial)
            THIS.this_cMensagemErro = "Data Inicial inv" + CHR(225) + "lida!"
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_dDtFinal)
            THIS.this_cMensagemErro = "Data Final inv" + CHR(225) + "lida!"
            RETURN .F.
        ENDIF
        IF THIS.this_dDtFinal < THIS.this_dDtInicial
            THIS.this_cMensagemErro = "A Data Final n" + CHR(227) + "o pode ser menor que a Inicial!"
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta cursores para o relatorio
    * Replica logica do procedimento 'processamento' do legado:
    *   1. Carrega nome da empresa para cabecalho
    *   2. Cria cursor_4c_Cabecalho com titulo/subtitulo
    *   3. Executa query principal em SigOpInc (joins SigCdNcf, SigCdCli)
    *   4. Transforma cursor: percentual (TmpInc) ou listagem (Selecao+index)
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_nResult
        LOCAL loc_cEmp, loc_cCab, loc_cSub, loc_cSQLEmp
        LOCAL loc_nQbr, loc_nWQtd

        loc_lSucesso  = .F.
        loc_nWQtd     = 0
        loc_nQbr      = THIS.this_nOrdem
        THIS.this_cMensagemErro = ""

        TRY
            *-- 1. Nome da empresa para cabecalho
            loc_cSQLEmp = "SELECT Razas FROM SigCdEmp WHERE Cemps = " + ;
                          EscaparSQL(go_4c_Sistema.cCodEmpresa)
            SQLEXEC(gnConnHandle, loc_cSQLEmp, "cursor_4c_SigCdEmp")
            SELECT cursor_4c_SigCdEmp
            loc_cEmp = go_4c_Sistema.cCodEmpresa + " - " + ;
                       IIF(EOF("cursor_4c_SigCdEmp"), "", ALLTRIM(cursor_4c_SigCdEmp.Razas))
            IF USED("cursor_4c_SigCdEmp")
                USE IN cursor_4c_SigCdEmp
            ENDIF

            *-- 2. Monta cabecalho e subtitulo do relatorio
            loc_cCab = "Relat" + CHR(243) + "rio de Tipo de Autoriza" + ;
                       CHR(231) + CHR(245) + "es"
            loc_cSub = "Per" + CHR(237) + "odo: " + DTOC(THIS.this_dDtInicial) + ;
                       " " + CHR(224) + " " + DTOC(THIS.this_dDtFinal)
            IF !EMPTY(THIS.this_cGrupo)
                loc_cSub = loc_cSub + " - Grupo : " + ALLTRIM(THIS.this_cGrupo)
            ENDIF
            IF !EMPTY(THIS.this_cConta)
                loc_cSub = loc_cSub + " - Contas : " + ALLTRIM(THIS.this_cConta)
            ENDIF
            IF !EMPTY(THIS.this_nEnvelope)
                loc_cSub = loc_cSub + " - Envelope : " + ALLTRIM(STR(THIS.this_nEnvelope))
            ENDIF
            IF !EMPTY(THIS.this_cCodigo)
                loc_cSub = loc_cSub + " - C" + CHR(243) + "digo : " + ALLTRIM(THIS.this_cCodigo)
            ENDIF

            IF USED("cursor_4c_Cabecalho")
                USE IN cursor_4c_Cabecalho
            ENDIF
            CREATE CURSOR cursor_4c_Cabecalho ;
                (Titulo C(100), SubTitulo C(100), NomeEmpresa C(100))
            INSERT INTO cursor_4c_Cabecalho (Titulo, SubTitulo, NomeEmpresa) ;
                VALUES (loc_cCab, loc_cSub, loc_cEmp)

            *-- 3. Monta clausula WHERE da query principal
            loc_cWhere = "a.Datas >= " + FormatarDataSQL(THIS.this_dDtInicial) + ;
                         " AND a.Datas < DATEADD(day, 1, " + ;
                         FormatarDataSQL(THIS.this_dDtFinal) + ")" + ;
                         " AND a.Cods = b.Cods" + ;
                         " AND (b.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                         " OR b.Emps = '  ')" + ;
                         " AND a.Contas = d.IClis" + ;
                         " AND a.Cpros = ' '"

            IF !EMPTY(THIS.this_cGrupo)
                loc_cWhere = loc_cWhere + ;
                             " AND a.Grupos = " + EscaparSQL(THIS.this_cGrupo)
            ENDIF
            IF !EMPTY(THIS.this_cConta)
                loc_cWhere = loc_cWhere + ;
                             " AND a.Contas = " + EscaparSQL(THIS.this_cConta)
            ENDIF
            IF !EMPTY(THIS.this_cCodigo)
                loc_cWhere = loc_cWhere + ;
                             " AND a.Cods = " + EscaparSQL(THIS.this_cCodigo)
            ENDIF
            IF !EMPTY(THIS.this_nEnvelope)
                loc_cWhere = loc_cWhere + ;
                             " AND a.Nenvs = " + TRANSFORM(THIS.this_nEnvelope)
            ENDIF

            *-- 4. Query principal: SigOpInc + SigCdNcf + SigCdCli
            loc_cSQL = "SELECT a.*, d.RClis, b.Descs AS DescTabs, b.fixos " + ;
                       "FROM SigOpInc a, SigCdNcf b, SigCdCli d " + ;
                       "WHERE " + loc_cWhere + " " + ;
                       "ORDER BY a.Grupos, a.Contas, a.Datas, a.Nenvs, a.Cods"

            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados de autoriza" + ;
                    CHR(231) + CHR(245) + "es de produ" + CHR(231) + CHR(227) + "o"
                loc_lSucesso = .F.
            ENDIF

            *-- 5. Transforma cursor conforme modo: percentual ou listagem
            IF THIS.this_nPercent = 1

                SELECT (THIS.this_cCursorDados)
                SUM 1 TO loc_nWQtd

                IF loc_nWQtd > 0
                    SELECT Cods, ;
                           IIF(fixos <> 2, DescTabs, Descs) AS DescTabs, ;
                           IIF(loc_nQbr = 1, Grupos, SPACE(10)) AS Grupos, ;
                           IIF(loc_nQbr = 1, Contas, SPACE(10)) AS Contas, ;
                           SUM(1) AS Qtds, ;
                           SUM(1 / loc_nWQtd * 100.00) AS Percs ;
                    FROM (THIS.this_cCursorDados) ;
                    INTO CURSOR cursor_4c_TmpInc ;
                    GROUP BY 1, 2, 3, 4 ;
                    ORDER BY 1, 2, 3, 4
                ELSE
                    CREATE CURSOR cursor_4c_TmpInc ;
                        (Cods C(10), DescTabs C(50), Grupos C(10), ;
                         Contas C(10), Qtds N(10,0), Percs N(10,2))
                ENDIF

            ELSE

                SELECT IIF(loc_nQbr = 1, ;
                           Grupos + "/" + Contas + "-" + RClis, ;
                           Cods + "-" + IIF(fixos <> 2, DescTabs, Descs)) AS Quebra1, ;
                       IIF(loc_nQbr = 1, ;
                           Cods + "-" + DescTabs, ;
                           Grupos + "/" + Contas + "-" + RClis) AS Quebra2, ;
                       IIF(fixos <> 2, DescTabs, Descs) AS DescTabs, * ;
                FROM (THIS.this_cCursorDados) ;
                INTO CURSOR cursor_4c_Selecao

                SELECT cursor_4c_Selecao
                INDEX ON Quebra1 + Quebra2 + DTOS(Datas) + STR(Nenvs, 10) TAG Ordem
                GO TOP

            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_cRelatorio

        loc_lSucesso = .F.

        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            loc_cRelatorio = gc_4c_CaminhoReports + ;
                             IIF(THIS.this_nPercent = 1, "SigReAu2", "SigReAu1")

            REPORT FORM (loc_cRelatorio) PREVIEW NOCONSOLE
            THIS.RegistrarAuditoria("VISUALIZAR")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime com dialogo de selecao de impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_cRelatorio

        loc_lSucesso = .F.

        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            loc_cRelatorio = gc_4c_CaminhoReports + ;
                             IIF(THIS.this_nPercent = 1, "SigReAu2", "SigReAu1")

            REPORT FORM (loc_cRelatorio) TO PRINTER PROMPT NOCONSOLE
            THIS.RegistrarAuditoria("IMPRIMIR")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Documento - Prepara dados e envia direto para impressora sem dialogo
    *--------------------------------------------------------------------------
    PROCEDURE Documento()
        LOCAL loc_lSucesso, loc_cRelatorio

        loc_lSucesso = .F.

        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            loc_cRelatorio = gc_4c_CaminhoReports + ;
                             IIF(THIS.this_nPercent = 1, "SigReAu2", "SigReAu1")

            REPORT FORM (loc_cRelatorio) TO PRINT NOCONSOLE
            THIS.RegistrarAuditoria("DOCUMENTO")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave de auditoria da execucao do relatorio
    * Compoe identificador unico com empresa + filtros principais + periodo
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave, loc_cEmpresa, loc_cTipo

        loc_cEmpresa = IIF(TYPE("go_4c_Sistema.cCodEmpresa") = "C", ;
                           ALLTRIM(go_4c_Sistema.cCodEmpresa), "TODAS")

        loc_cTipo = IIF(THIS.this_nPercent = 1, "PERCENT", "LISTAGEM") + ;
                    "/ORD" + ALLTRIM(STR(THIS.this_nOrdem))

        loc_cChave = loc_cEmpresa + "/" + loc_cTipo + "/" + ;
                     DTOC(THIS.this_dDtInicial) + "/" + ;
                     DTOC(THIS.this_dDtFinal)

        IF !EMPTY(THIS.this_cGrupo)
            loc_cChave = loc_cChave + "/G:" + ALLTRIM(THIS.this_cGrupo)
        ENDIF

        IF !EMPTY(THIS.this_cConta)
            loc_cChave = loc_cChave + "/C:" + ALLTRIM(THIS.this_cConta)
        ENDIF

        IF !EMPTY(THIS.this_cCodigo)
            loc_cChave = loc_cChave + "/N:" + ALLTRIM(THIS.this_cCodigo)
        ENDIF

        IF THIS.this_nEnvelope > 0
            loc_cChave = loc_cChave + "/E:" + ALLTRIM(STR(THIS.this_nEnvelope))
        ENDIF

        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra execucao do relatorio na tabela LogAuditoria
    * par_cOperacao: VISUALIZAR, IMPRIMIR, DOCUMENTO, EXPORTAR
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            loc_cChave   = THIS.ObterChavePrimaria()
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                               gc_4c_UsuarioLogado, "SISTEMA")

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL("SIGREAUP") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(loc_cUsuario) + ", GETDATE())"

            SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Aviso: falha ao registrar auditoria - " + ;
                                       loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir / Atualizar / CarregarDoCursor
    *
    * Operacoes nao aplicaveis a BOs de relatorio. Sao implementadas aqui
    * apenas para manter o contrato uniforme com BusinessBase (auditoria,
    * dispatchers genericos, validadores automatizados) e para sinalizar
    * explicitamente a restricao.
    *
    * Para relatorios, o fluxo correto eh:
    *   - PrepararDados() monta os cursores de saida via SQLEXEC sobre o
    *     periodo filtrado (cursor_4c_Cabecalho, cursor_4c_TmpInc, cursor_4c_Selecao)
    *   - Imprimir() / Visualizar() / Documento() consomem esses cursores
    *     atraves dos .FRX SigReAu1 (listagem) / SigReAu2 (percentual)
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: BO de relat" + CHR(243) + "rio n" + CHR(227) + ;
            "o insere registros. Use PrepararDados()/Imprimir()/Visualizar()."
        RETURN .F.
    ENDPROC

    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: BO de relat" + CHR(243) + "rio n" + CHR(227) + ;
            "o atualiza registros. Use PrepararDados()/Imprimir()/Visualizar()."
        RETURN .F.
    ENDPROC

    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: BO de relat" + CHR(243) + "rio processa o per" + ;
            CHR(237) + "odo inteiro em PrepararDados(), n" + CHR(227) + ;
            "o registro a registro."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha cursores auxiliares abertos pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_SigOpInc")
            USE IN cursor_4c_SigOpInc
        ENDIF
        IF USED("cursor_4c_TmpInc")
            USE IN cursor_4c_TmpInc
        ENDIF
        IF USED("cursor_4c_Selecao")
            USE IN cursor_4c_Selecao
        ENDIF
        IF USED("cursor_4c_Cabecalho")
            USE IN cursor_4c_Cabecalho
        ENDIF
        IF USED("cursor_4c_SigCdEmp")
            USE IN cursor_4c_SigCdEmp
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

