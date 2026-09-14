# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (5)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 402: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 421: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 440: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 459: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigredcu.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1181 linhas total):

*-- Linhas 128 a 136:
128:                     gc_4c_CaminhoIcones = ""
129:                 ENDIF
130:                 THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
131:                 THIS.Caption = "Impress" + CHR(227) + "o de Documento (" + ;
132:                                ALLTRIM(THIS.this_oRelatorio.this_cDopes) + "/" + ;
133:                                ALLTRIM(STR(THIS.this_oRelatorio.this_nNumes)) + ")"
134: 
135:                 *-- Carrega dados da operacao do banco (pula em modo validacao UI)
136:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI

*-- Linhas 184 a 204:
184:     *
185:     * Em forms REPORT (frmrelatorio) nao ha Page1/Page2 - este metodo eh o
186:     * equivalente funcional do ConfigurarPaginaLista CRUD: sincroniza estado
187:     * inicial dos controles de opcao (CheckBoxes e OptionGroup) com os dados
188:     * carregados pelo BO em PrepararDados() e com os parametros recebidos
189:     * do form chamador.
190:     *
191:     * Logica espelhada do SIGREDCU.Init() legado:
192:     *   chkImagem.Value = crSigCdOpeD.chkIFoto  (1=imprime imagem padrao)
193:     *   chkCompo.Value  = Int(Val(Substr(lbltxidCs, 21, 1)))  (configuracao composicao)
194:     *   chkCompo.Visible = fChecaAcesso(nDopes, "INIBCOMPO")
195:     *   OptAgrupa.Value = 2  (default "Nenhum")
196:     *   chkImpPag/ChkItensP/chkDescIng marcam ImpTodasPaginas no BO
197:     *
198:     * Os controles sao criados em fases posteriores (5/6) - usa VARTYPE para
199:     * evitar erro quando este metodo for chamado antes da criacao dos checkboxes.
200:     * Sempre sincroniza o BO no final (mesmo sem os controles instanciados).
201:     *--------------------------------------------------------------------------
202:     PROTECTED PROCEDURE ConfigurarPaginaLista()
203:         LOCAL loc_nValComp, loc_cConfig, loc_oBO
204: 

*-- Linhas 299 a 339:
299:     PROTECTED PROCEDURE ConfigurarCabecalho()
300:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
301:         WITH THIS.cnt_4c_Cabecalho
302:             .Top         = 0
303:             .Left        = 0
304:             .Width       = THIS.Width
305:             .Height      = 83
306:             .BackStyle   = 1
307:             .BackColor   = RGB(100, 100, 100)
308:             .BorderWidth = 0
309:             .Visible     = .T.
310: 
311:             *-- Sombra deslocada 2px para efeito 3D no texto branco
312:             .AddObject("lbl_4c_Sombra", "Label")
313:             WITH .lbl_4c_Sombra
314:                 .Top       = 22
315:                 .Left      = 22
316:                 .Width     = THIS.Width
317:                 .Height    = 30
318:                 .Caption   = "Impress" + CHR(227) + "o de Documento"
319:                 .FontName  = "Tahoma"
320:                 .FontSize  = 14
321:                 .FontBold  = .T.
322:                 .ForeColor = RGB(0, 0, 0)
323:                 .BackStyle = 0
324:                 .Visible   = .T.
325:             ENDWITH
326: 
327:             *-- Titulo em branco sobre a sombra
328:             .AddObject("lbl_4c_Titulo", "Label")
329:             WITH .lbl_4c_Titulo
330:                 .Top       = 20
331:                 .Left      = 20
332:                 .Width     = THIS.Width
333:                 .Height    = 30
334:                 .Caption   = "Impress" + CHR(227) + "o de Documento"
335:                 .FontName  = "Tahoma"
336:                 .FontSize  = 14
337:                 .FontBold  = .T.
338:                 .ForeColor = RGB(255, 255, 255)
339:                 .BackStyle = 0

*-- Linhas 378 a 387:
378:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
379: 
380:         WITH THIS.cmg_4c_Botoes
381:             .Top           = 0
382:             .Left          = 529
383:             .Width         = 273
384:             .Height        = 80
385:             .ButtonCount   = 4
386:             .BackStyle     = 0
387:             .BorderStyle   = 0

*-- Linhas 393 a 465:
393:         ENDWITH
394: 
395:         WITH THIS.cmg_4c_Botoes.Buttons(1)
396:             .Caption         = "Visualizar"
397:             .Top             = 5
398:             .Left            = 5
399:             .Width           = 65
400:             .Height          = 70
401:             .Picture         = gc_4c_CaminhoIcones + "ideo.jpg"
402:             .FontName        = "Comic Sans MS"
403:             .FontBold        = .T.
404:             .FontItalic      = .T.
405:             .FontSize        = 8
406:             .BackColor       = RGB(255, 255, 255)
407:             .ForeColor       = RGB(90, 90, 90)
408:             .PicturePosition = 13
409:             .SpecialEffect   = 0
410:             .MousePointer    = 15
411:             .Themes          = .F.
412:         ENDWITH
413: 
414:         WITH THIS.cmg_4c_Botoes.Buttons(2)
415:             .Caption         = "Imprimir"
416:             .Top             = 5
417:             .Left            = 71
418:             .Width           = 65
419:             .Height          = 70
420:             .Picture         = gc_4c_CaminhoIcones + "impressora.jpg"
421:             .FontName        = "Comic Sans MS"
422:             .FontBold        = .T.
423:             .FontItalic      = .T.
424:             .FontSize        = 8
425:             .BackColor       = RGB(255, 255, 255)
426:             .ForeColor       = RGB(90, 90, 90)
427:             .PicturePosition = 13
428:             .SpecialEffect   = 0
429:             .MousePointer    = 15
430:             .Themes          = .F.
431:         ENDWITH
432: 
433:         WITH THIS.cmg_4c_Botoes.Buttons(3)
434:             .Caption         = "Doc Excel"
435:             .Top             = 5
436:             .Left            = 137
437:             .Width           = 65
438:             .Height          = 70
439:             .Picture         = gc_4c_CaminhoIcones + "excel.jpg"
440:             .FontName        = "Comic Sans MS"
441:             .FontBold        = .T.
442:             .FontItalic      = .T.
443:             .FontSize        = 8
444:             .BackColor       = RGB(255, 255, 255)
445:             .ForeColor       = RGB(90, 90, 90)
446:             .PicturePosition = 13
447:             .SpecialEffect   = 0
448:             .MousePointer    = 15
449:             .Themes          = .F.
450:         ENDWITH
451: 
452:         WITH THIS.cmg_4c_Botoes.Buttons(4)
453:             .Caption         = "Encerrar"
454:             .Top             = 5
455:             .Left            = 203
456:             .Width           = 65
457:             .Height          = 70
458:             .Picture         = gc_4c_CaminhoIcones + "otao_encerrar.jpg"
459:             .FontName        = "Comic Sans MS"
460:             .FontBold        = .T.
461:             .FontItalic      = .T.
462:             .FontSize        = 8
463:             .BackColor       = RGB(255, 255, 255)
464:             .ForeColor       = RGB(90, 90, 90)
465:             .PicturePosition = 13

*-- Linhas 681 a 844:
681:     * ConfigurarPaginaDados - Cria controles do dialogo (Fase 5: primeiros 50%)
682:     *   Cria: chk_4c_ChkImagem, chk_4c_ChkItensP, chk_4c_ChkDescIng, chk_4c_ChkCompo
683:     *   Posicoes EXATAS do original SIGREDCU (Top=88/105/122/139, Left=36)
684:     *   Fase 6 completa com chk_4c_ChkImpPag, obj_4c_OptAgrupa, lbl_4c_Agrupa
685:     *--------------------------------------------------------------------------
686:     PROTECTED PROCEDURE ConfigurarPaginaDados()
687:         *-- chkImagem: "Imprimir Imagem" (Top=88)
688:         THIS.AddObject("chk_4c_ChkImagem", "CheckBox")
689:         WITH THIS.chk_4c_ChkImagem
690:             .Top       = 88
691:             .Left      = 36
692:             .Height    = 17
693:             .Width     = 140
694:             .Caption   = "Imprimir Imagem"
695:             .FontName  = "Tahoma"
696:             .FontSize  = 8
697:             .AutoSize  = .T.
698:             .Alignment = 0
699:             .BackStyle = 0
700:             .ForeColor = RGB(90, 90, 90)
701:             .Value     = 0
702:             .Visible   = .T.
703:         ENDWITH
704:         BINDEVENT(THIS.chk_4c_ChkImagem, "Click", THIS, "ChkImagemClick")
705: 
706:         *-- ChkItensP: checkbox filtro de itens (Top=105)
707:         THIS.AddObject("chk_4c_ChkItensP", "CheckBox")
708:         WITH THIS.chk_4c_ChkItensP
709:             .Top       = 105
710:             .Left      = 36
711:             .Height    = 17
712:             .Width     = 200
713:             .Caption   = "Imprimir Apenas Itens Pendentes"
714:             .FontName  = "Tahoma"
715:             .FontSize  = 8
716:             .AutoSize  = .T.
717:             .Alignment = 0
718:             .BackStyle = 0
719:             .ForeColor = RGB(90, 90, 90)
720:             .Value     = 0
721:             .Visible   = .T.
722:         ENDWITH
723:         BINDEVENT(THIS.chk_4c_ChkItensP, "Click", THIS, "ChkItensPClick")
724: 
725:         *-- chkDescIng: "Imprimir Descricao em Ingles" (Top=122)
726:         THIS.AddObject("chk_4c_ChkDescIng", "CheckBox")
727:         WITH THIS.chk_4c_ChkDescIng
728:             .Top       = 122
729:             .Left      = 36
730:             .Height    = 17
731:             .Width     = 200
732:             .Caption   = "Imprimir Descri" + CHR(231) + CHR(227) + "o em Ingl" + CHR(234) + "s"
733:             .FontName  = "Tahoma"
734:             .FontSize  = 8
735:             .AutoSize  = .T.
736:             .Alignment = 0
737:             .BackStyle = 0
738:             .ForeColor = RGB(90, 90, 90)
739:             .Value     = 0
740:             .Visible   = .T.
741:         ENDWITH
742:         BINDEVENT(THIS.chk_4c_ChkDescIng, "Click", THIS, "ChkDescIngClick")
743: 
744:         *-- chkCompo: "Inibir Composicao Desmembrada" (Top=139)
745:         THIS.AddObject("chk_4c_ChkCompo", "CheckBox")
746:         WITH THIS.chk_4c_ChkCompo
747:             .Top       = 139
748:             .Left      = 36
749:             .Height    = 17
750:             .Width     = 200
751:             .Caption   = "Inibir Composi" + CHR(231) + CHR(227) + "o Desmembrada"
752:             .FontName  = "Tahoma"
753:             .FontSize  = 8
754:             .AutoSize  = .T.
755:             .Alignment = 0
756:             .BackStyle = 0
757:             .ForeColor = RGB(90, 90, 90)
758:             .Value     = 0
759:             .Visible   = .T.
760:         ENDWITH
761:         BINDEVENT(THIS.chk_4c_ChkCompo, "Click", THIS, "ChkCompoClick")
762: 
763:         *-- chkImpPag: "Imprimir o Cabecalho em Todas as Paginas" (Top=156)
764:         THIS.AddObject("chk_4c_ChkImpPag", "CheckBox")
765:         WITH THIS.chk_4c_ChkImpPag
766:             .Top       = 156
767:             .Left      = 36
768:             .Height    = 17
769:             .Width     = 230
770:             .Caption   = "Imprimir o Cabe" + CHR(231) + "alho em Todas as P" + CHR(225) + "ginas"
771:             .FontName  = "Tahoma"
772:             .FontSize  = 8
773:             .AutoSize  = .T.
774:             .Alignment = 0
775:             .BackStyle = 0
776:             .ForeColor = RGB(90, 90, 90)
777:             .Value     = 0
778:             .Visible   = .T.
779:         ENDWITH
780:         BINDEVENT(THIS.chk_4c_ChkImpPag, "Click", THIS, "ChkImpPagClick")
781: 
782:         *-- lbl_4c_Agrupa: "Agrupar por :" (Top=180, Left=36)
783:         THIS.AddObject("lbl_4c_Agrupa", "Label")
784:         WITH THIS.lbl_4c_Agrupa
785:             .Top       = 180
786:             .Left      = 36
787:             .Height    = 15
788:             .Width     = 67
789:             .Caption   = "Agrupar por :"
790:             .FontName  = "Tahoma"
791:             .FontSize  = 8
792:             .AutoSize  = .T.
793:             .BackStyle = 0
794:             .ForeColor = RGB(90, 90, 90)
795:             .Visible   = .T.
796:         ENDWITH
797: 
798:         *-- obj_4c_OptAgrupa: OptionGroup com 3 opcoes de agrupamento (Top=174, Left=117)
799:         THIS.AddObject("obj_4c_OptAgrupa", "OptionGroup")
800:         WITH THIS.obj_4c_OptAgrupa
801:             .Top         = 174
802:             .Left        = 117
803:             .Width       = 210
804:             .Height      = 57
805:             .ButtonCount = 3
806:             .BackStyle   = 0
807:             .BorderStyle = 0
808:             .Value       = 2
809:             .Visible     = .T.
810:         ENDWITH
811:         WITH THIS.obj_4c_OptAgrupa.Buttons(1)
812:             .Caption   = "Produto, Cor, Valor Unit" + CHR(225) + "rio"
813:             .Top       = 5
814:             .Left      = 6
815:             .Height    = 15
816:             .Width     = 151
817:             .FontName  = "Tahoma"
818:             .FontSize  = 8
819:             .BackStyle = 0
820:             .AutoSize  = .T.
821:             .ForeColor = RGB(90, 90, 90)
822:             .Visible   = .T.
823:         ENDWITH
824:         WITH THIS.obj_4c_OptAgrupa.Buttons(2)
825:             .Caption   = "Nenhum"
826:             .Top       = 20
827:             .Left      = 6
828:             .Height    = 17
829:             .Width     = 78
830:             .FontName  = "Tahoma"
831:             .FontSize  = 8
832:             .BackStyle = 0
833:             .ForeColor = RGB(90, 90, 90)
834:             .Visible   = .T.
835:         ENDWITH
836:         WITH THIS.obj_4c_OptAgrupa.Buttons(3)
837:             .Caption   = "Ref fornecedor, Cor, Tamanho"
838:             .Top       = 37
839:             .Left      = 6
840:             .Height    = 15
841:             .Width     = 194
842:             .FontName  = "Tahoma"
843:             .FontSize  = 8
844:             .BackStyle = 0


### BO (C:\4c\projeto\app\classes\sigredcuBO.prg):
*==============================================================================
* SIGREDCUBO.PRG
* Business Object para Impressao de Documento (SIGREDCU)
* Herda de RelatorioBase
*
* Dialogo de opcoes de impressao de documentos operacionais.
* Recebe cursores ja populados (TmpRelat/TmpRel) do form chamador.
*==============================================================================

DEFINE CLASS sigredcuBO AS RelatorioBase

    *-- Parametros do documento a imprimir (recebidos do form chamador)
    this_cEmps            = ""    && Codigo empresa (3 chars)
    this_cDopes           = ""    && Tipo de operacao (20 chars)
    this_nNumes           = 0     && Numero do documento
    this_nQbols           = 1     && Quantidade de vias para impressao
    this_cEmail           = ""    && Email de destino

    *-- Tipo de impressao (TpImpressao do legado)
    this_nTpImpressao     = 0     && 0=nenhum, 1=video, 2=impressora, 3=excel, 4=encerrar

    *-- Opcoes de impressao (mapeadas dos checkboxes do form)
    this_nChkImagem       = 0     && Imprimir imagem (0=nao, 1=sim)
    this_nChkItensP       = 0     && Apenas itens pendentes (0=nao, 1=sim)
    this_nChkDescIng      = 0     && Descricao em ingles (0=nao, 1=sim)
    this_nChkCompo        = 0     && Inibir composicao desmembrada (0=nao, 1=sim)
    this_nChkImpPag       = 0     && Imprimir cabecalho em todas as paginas (0=nao, 1=sim)

    *-- Tipo de agrupamento (OptAgrupa, default 2=Nenhum)
    this_nOptAgrupa       = 2     && 1=Produto/Cor/Valor, 2=Nenhum, 3=Ref Forn/Cor/Tamanho

    *-- Controle de impressao de documento (ChkImpDoc do legado)
    this_lChkImpDoc       = .F.   && Documento tem controle de impressao
    this_lChkImpDocAcess  = .F.   && Acesso para reimpressao liberado
    this_lImpTodasPaginas = .F.   && Estado: imprimir cabecalho em todas as paginas

    *-- Controles de acesso aos botoes (lAcImprimir/lAcExcel do frmrelatorio)
    this_lAcImprimir      = .T.   && Acesso ao botao imprimir
    this_lAcExcel         = .T.   && Acesso ao botao excel

    *-- Visibilidade do chkCompo (determinada por fChecaAcesso no Init)
    this_lChkCompoVisivel = .F.

    *-- Dados carregados de crSigCdOpeD (JOIN SigCdOpe + SigOpCdc + SigOpCdi)
    this_nNDopes          = 0     && ID numerico da operacao (para fChecaAcesso)
    this_nChkImpDocOpe    = 0     && SigOpCdc.chkImpDoc: flag controle impressao
    this_nCarCompos       = 0     && SigOpCdc.carcompos: tipo composicao
    this_nDckTermos       = 0     && SigOpCdc.dckTermos: flag termos de garantia
    this_cCMoes           = ""    && SigCdOpe.Cmoes: moeda
    this_nTipoNfs         = 0     && SigCdOpe.TipoNfs: tipo nota fiscal
    this_nOpers           = 0     && SigCdOpe.Opers: 1=fornecedor, 2=destino, 3=ambos
    this_cLblTxIdCs       = ""    && SigOpCdi.lbltxidCs: string de configuracao
    this_nChkIFoto        = 0     && SigOpCdi.chkIFoto: flag imagem padrao

    *-- Cursores de dados (populados externamente pelo form chamador)
    this_cCursorDados     = "TmpRelat"   && Cursor principal com dados do documento
    this_cCursorRel       = "TmpRel"     && Cursor auxiliar de relatorio

    *-- Referencia ao form pai (para reativar apos fechar este dialogo)
    this_oFormPai         = .NULL.

    *-- Arquivo gerado para email/PDF (pcArqEmail do legado)
    this_cArqEmail        = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa BO com valores padrao
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Carrega dados da operacao do banco (crSigCdOpeD)
    * Chamado pelo Form apos setar this_cEmps/this_cDopes/this_nNumes
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT a.Ndopes, b.chkImpDoc, b.carcompos, b.dckTermos, " + ;
                       "a.Cmoes, a.TipoNfs, a.Opers, c.lbltxidCs, c.chkIFoto " + ;
                       "FROM SigCdOpe a, SigOpCdc b, SigOpCdi c " + ;
                       "WHERE a.Dopes = " + EscaparSQL(THIS.this_cDopes) + ;
                       " AND b.Dopes = a.Dopes AND c.Dopes = a.Dopes"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigRedcuOpe")

            IF loc_nResult >= 1
                SELECT cursor_4c_SigRedcuOpe
                IF !EOF()
                    THIS.this_nNDopes         = NVL(Ndopes, 0)
                    THIS.this_nChkImpDocOpe   = NVL(chkImpDoc, 0)
                    THIS.this_nCarCompos      = NVL(carcompos, 0)
                    THIS.this_nDckTermos      = NVL(dckTermos, 0)
                    THIS.this_cCMoes          = ALLTRIM(NVL(Cmoes, ""))
                    THIS.this_nTipoNfs        = NVL(TipoNfs, 0)
                    THIS.this_nOpers          = NVL(Opers, 0)
                    THIS.this_cLblTxIdCs      = ALLTRIM(NVL(lbltxidCs, ""))
                    THIS.this_nChkIFoto       = NVL(chkIFoto, 0)

                    *-- chkCompo inicializado com valor da posicao 21 de lbltxidCs
                    THIS.this_nChkCompo = INT(VAL(SUBSTR(THIS.this_cLblTxIdCs, 21, 1)))

                    *-- chkImagem inicializado com valor de chkIFoto
                    THIS.this_nChkImagem = THIS.this_nChkIFoto

                    *-- Flag controle de impressao
                    IF THIS.this_nChkImpDocOpe <> 0
                        THIS.this_lChkImpDoc = .T.
                    ENDIF

                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o " + ;
                        ALLTRIM(THIS.this_cDopes) + " n" + CHR(227) + "o encontrada"
                ENDIF

                IF USED("cursor_4c_SigRedcuOpe")
                    USE IN cursor_4c_SigRedcuOpe
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Falha ao carregar dados da opera" + ;
                    CHR(231) + CHR(227) + "o " + ALLTRIM(THIS.this_cDopes)
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredcuBO.PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarReimpressao - Verifica se documento ja foi impresso em SigMvCab
    * Retorna .T. se ja foi impresso
    *--------------------------------------------------------------------------
    PROCEDURE VerificarReimpressao()
        LOCAL loc_lJaImpresso, loc_cSQL, loc_nResult, loc_cEdn
        loc_lJaImpresso = .F.
        TRY
            loc_cEdn = PADR(THIS.this_cEmps, 3) + ;
                       PADR(THIS.this_cDopes, 20) + ;
                       STR(THIS.this_nNumes, 6)

            loc_cSQL = "SELECT Impress FROM SigMvCab WHERE EmpDopNums = " + ;
                       EscaparSQL(loc_cEdn)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigRedcuImp")

            IF loc_nResult > 0
                SELECT cursor_4c_SigRedcuImp
                IF !EOF()
                    IF NVL(Impress, 0) <> 0
                        loc_lJaImpresso = .T.
                    ENDIF
                ENDIF
                IF USED("cursor_4c_SigRedcuImp")
                    USE IN cursor_4c_SigRedcuImp
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigredcuBO.VerificarReimpressao")
        ENDTRY
        RETURN loc_lJaImpresso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarImpressao - Marca documento como impresso (Impress=1) em SigMvCab
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarImpressao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cEdn
        loc_lSucesso = .F.
        TRY
            loc_cEdn = PADR(THIS.this_cEmps, 3) + ;
                       PADR(THIS.this_cDopes, 20) + ;
                       STR(THIS.this_nNumes, 6)

            loc_cSQL = "UPDATE SigMvCab SET Impress = 1 WHERE EmpDopNums = " + ;
                       EscaparSQL(loc_cEdn)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "")
            IF loc_nResult >= 0
                SQLCOMMIT(gnConnHandle)
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao registrar impress" + CHR(227) + "o"
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredcuBO.RegistrarImpressao")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave do documento (EmpDopNums concatenado)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN PADR(THIS.this_cEmps, 3) + ;
               PADR(THIS.this_cDopes, 20) + ;
               STR(THIS.this_nNumes, 6)
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra geracao do documento em LogAuditoria
    * par_cOperacao: IMPRIMIR, VISUALIZAR, EXCEL, EMAIL
    * Para IMPRIMIR, tambem atualiza SigMvCab.Impress = 1 via RegistrarImpressao()
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResult, loc_cUsuario, loc_cOp
        loc_lSucesso = .F.
        TRY
            loc_cOp = UPPER(ALLTRIM(par_cOperacao))

            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
            ENDIF

            loc_cChave = "EMP=" + ALLTRIM(THIS.this_cEmps) + ;
                         ";DOP=" + ALLTRIM(THIS.this_cDopes) + ;
                         ";NUM=" + ALLTRIM(STR(THIS.this_nNumes, 6))

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(DataHora, Usuario, Tabela, Operacao, ChaveRegistro) " + ;
                       "VALUES (GETDATE(), " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       EscaparSQL("SigReDcu") + ", " + ;
                       EscaparSQL(loc_cOp) + ", " + ;
                       EscaparSQL(loc_cChave) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)

            *-- Para operacao IMPRIMIR, marca documento como impresso em SigMvCab
            IF loc_cOp = "IMPRIMIR"
                THIS.RegistrarImpressao()
            ENDIF
        CATCH TO loc_oErro
            *-- Auditoria nao deve interromper geracao do documento
            MsgErro("Falha ao registrar auditoria: " + loc_oErro.Message, "Auditoria")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega parametros do documento a partir de cursor preset
    * Permite restaurar configuracao previamente salva (vias, opcoes, tipo agrupamento)
    * par_cAliasCursor: cursor com colunas: cEmps, cDopes, nNumes, nQbols,
    *                   nOptAgrupa, nChkImagem, nChkItensP, nChkDescIng,
    *                   nChkCompo, nChkImpPag, cEmail
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias
        loc_lSucesso = .F.
        TRY
            loc_cAlias = par_cAliasCursor
            IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor de par" + CHR(226) + "metros n" + ;
                    CHR(227) + "o dispon" + CHR(237) + "vel: " + ALLTRIM(NVL(loc_cAlias, ""))
                loc_lSucesso = .F.
            ENDIF

            SELECT (loc_cAlias)
            IF EOF()
                THIS.this_cMensagemErro = "Cursor de par" + CHR(226) + "metros vazio: " + loc_cAlias
                loc_lSucesso = .F.
            ENDIF

            SCATTER MEMVAR

            IF TYPE("m.cEmps") = "C"
                THIS.this_cEmps = ALLTRIM(m.cEmps)
            ENDIF
            IF TYPE("m.cDopes") = "C"
                THIS.this_cDopes = ALLTRIM(m.cDopes)
            ENDIF
            IF TYPE("m.nNumes") = "N"
                THIS.this_nNumes = m.nNumes
            ENDIF
            IF TYPE("m.nQbols") = "N"
                THIS.this_nQbols = IIF(m.nQbols >= 1, m.nQbols, 1)
            ENDIF
            IF TYPE("m.cEmail") = "C"
                THIS.this_cEmail = ALLTRIM(m.cEmail)
            ENDIF
            IF TYPE("m.nOptAgrupa") = "N"
                THIS.this_nOptAgrupa = m.nOptAgrupa
            ENDIF
            IF TYPE("m.nChkImagem") = "N"
                THIS.this_nChkImagem = m.nChkImagem
            ENDIF
            IF TYPE("m.nChkItensP") = "N"
                THIS.this_nChkItensP = m.nChkItensP
            ENDIF
            IF TYPE("m.nChkDescIng") = "N"
                THIS.this_nChkDescIng = m.nChkDescIng
            ENDIF
            IF TYPE("m.nChkCompo") = "N"
                THIS.this_nChkCompo = m.nChkCompo
            ENDIF
            IF TYPE("m.nChkImpPag") = "N"
                THIS.this_nChkImpPag = m.nChkImpPag
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredcuBO.CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Gera o documento enviando para a impressora
    * Semantica para BO de relatorio: "inserir" = produzir documento impresso
    * Valida parametros, executa Impressao() e registra auditoria IMPRIMIR
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cEmps) OR EMPTY(THIS.this_cDopes) OR THIS.this_nNumes <= 0
                THIS.this_cMensagemErro = "Par" + CHR(226) + "metros do documento " + ;
                    "(empresa/opera" + CHR(231) + CHR(227) + "o/n" + CHR(250) + "mero) " + ;
                    "s" + CHR(227) + "o obrigat" + CHR(243) + "rios"
                loc_lSucesso = .F.
            ENDIF

            IF THIS.this_nQbols < 1
                THIS.this_nQbols = 1
            ENDIF

            loc_lSucesso = THIS.Impressao()
            IF loc_lSucesso
                THIS.RegistrarAuditoria("IMPRIMIR")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredcuBO.Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Reprocessa os dados e exibe o documento em preview
    * Semantica para BO de relatorio: "atualizar" = recalcular e visualizar
    * Reaplica Processamento() (TmpRelat) e delega para Visualizacao()
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cEmps) OR EMPTY(THIS.this_cDopes) OR THIS.this_nNumes <= 0
                THIS.this_cMensagemErro = "Par" + CHR(226) + "metros do documento " + ;
                    "(empresa/opera" + CHR(231) + CHR(227) + "o/n" + CHR(250) + "mero) " + ;
                    "s" + CHR(227) + "o obrigat" + CHR(243) + "rios"
                loc_lSucesso = .F.
            ENDIF

            IF THIS.this_nQbols < 1
                THIS.this_nQbols = 1
            ENDIF

            *-- Reprocessa TmpRelat com as opcoes atuais antes do preview
            IF !THIS.Processamento()
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = THIS.Visualizacao()
            IF loc_lSucesso
                THIS.RegistrarAuditoria("VISUALIZAR")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredcuBO.Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararImpressao - Configura flag ImpTodasPaginas e posiciona cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararImpressao()
        THIS.this_lImpTodasPaginas = (THIS.this_nChkImpPag = 1)
        IF USED(THIS.this_cCursorDados)
            SELECT (THIS.this_cCursorDados)
            GO TOP
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Processamento - Popula TmpRelat chamando SigPrIdc com opcoes atuais
    * Chamado ao inicializar e cada vez que usuario altera uma opcao
    *--------------------------------------------------------------------------
    PROCEDURE Processamento()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(THIS.this_cCursorRel)
                SELECT (THIS.this_cCursorRel)
                GO TOP IN (THIS.this_cCursorRel)
            ENDIF
            DO SigPrIdc WITH ;
                THIS.this_cEmps, ;
                THIS.this_cDopes, ;
                THIS.this_nNumes, ;
                0, ;
                THIS.this_nQbols, ;
                THIS.this_nOptAgrupa, ;
                .T., ;
                gnConnHandle, ;
                (THIS.this_nChkImagem = 1), ;
                .F., ;
                (THIS.this_nChkItensP = 1), ;
                THIS.this_oFormPai, ;
                .F., ;
                (THIS.this_nChkDescIng = 1), ;
                THIS.this_nChkCompo
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredcuBO.Processamento")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarOpcoes - Reprocessa TmpRelat ao alterar opcoes de impressao
    * Chamado pelos handlers de OptAgrupa e todos os checkboxes de opcoes
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarOpcoes()
        RETURN THIS.Processamento()
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizacao - Exibe preview do documento na tela (REPORT FORM PREVIEW)
    * Apos o preview, imprime termo de garantia se dckTermos = 1
    *--------------------------------------------------------------------------
    PROCEDURE Visualizacao()
        LOCAL loc_lSucesso, loc_nCnt
        loc_lSucesso = .F.
        TRY
            THIS.PrepararImpressao()
            FOR loc_nCnt = 1 TO THIS.this_nQbols
                IF USED(THIS.this_cCursorDados)
                    SELECT (THIS.this_cCursorDados)
                    GO TOP
                ENDIF
                REPORT FORM SigReDc2 PREVIEW NOCONSOLE
            NEXT
            THIS.impGarantia()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredcuBO.Visualizacao")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Impressao - Envia documento para impressora em this_nQbols vias
    * TpImpressao 2 ou 4 = sem dialogo de impressora; outros = com PROMPT
    *--------------------------------------------------------------------------
    PROCEDURE Impressao()
        LOCAL loc_lSucesso, loc_nCnt
        loc_lSucesso = .F.
        TRY
            SET PRINTER TO DEFAULT
            THIS.PrepararImpressao()
            FOR loc_nCnt = 1 TO THIS.this_nQbols
                IF USED(THIS.this_cCursorDados)
                    SELECT (THIS.this_cCursorDados)
                    GO TOP
                ENDIF
                IF INLIST(THIS.this_nTpImpressao, 2, 4)
                    REPORT FORM SigReDc2 TO PRINTER NOCONSOLE
                ELSE
                    REPORT FORM SigReDc2 TO PRINTER PROMPT NOCONSOLE
                ENDIF
            NEXT
            THIS.impGarantia()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredcuBO.Impressao")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * DocumentoExcel - Gera exportacao do documento para arquivo XLS
    * Popula this_cArqEmail com o caminho do arquivo gerado para uso posterior
    *--------------------------------------------------------------------------
    PROCEDURE DocumentoExcel()
        LOCAL loc_lSucesso, loc_nCnt, loc_cArqSaida
        loc_lSucesso = .F.
        TRY
            THIS.PrepararImpressao()
            IF EMPTY(THIS.this_cArqEmail)
                loc_cArqSaida = SYS(2023) + "\" + ;
                    "Dcto_" + ALLTRIM(THIS.this_cDopes) + "_" + ;
                    TRANSFORM(THIS.this_nNumes) + "_" + ;
                    TRANSFORM(DATE(), "@YL") + ".xls"
                THIS.this_cArqEmail = loc_cArqSaida
            ELSE
                loc_cArqSaida = THIS.this_cArqEmail
            ENDIF
            FOR loc_nCnt = 1 TO THIS.this_nQbols
                IF USED(THIS.this_cCursorDados)
                    SELECT (THIS.this_cCursorDados)
                    GO TOP
                ENDIF
                REPORT FORM SigReDc2 TO FILE (loc_cArqSaida) ASCII NOCONSOLE
            NEXT
            loc_lSucesso = FILE(loc_cArqSaida)
            IF !loc_lSucesso
                THIS.this_cMensagemErro = "Falha ao gerar arquivo Excel"
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredcuBO.DocumentoExcel")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * impGarantia - Imprime termo de garantia quando dckTermos = 1
    * Carrega colunas de texto e titulo de SigOpCdc e imprime SigReDc3
    *--------------------------------------------------------------------------
    PROCEDURE impGarantia()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cTxtTermos
        loc_lSucesso = .F.
        TRY
            IF THIS.this_nDckTermos <> 1
                loc_lSucesso = .T.
            ENDIF
            loc_cSQL = "SELECT DocTit, DocOrig, DocDest, DckReffs, DocReffs, " + ;
                       "DckPrzE, DocPrzE, TxtPrzEnts, ChkPrzEnts, DckVend, " + ;
                       "DocVend, DocPag, DckTVend, DckBarra, DckFretes, DocFretes, " + ;
                       "DckIcmIpi, DocDesco, DocAcres, DckEntregs, DocEntregs, " + ;
                       "DckObsI, ImgTecs, DckTermos, TitTermos, TxtTermos, " + ;
                       "ViaTermos, TitTermgs, TxtTermgs " + ;
                       "FROM SigOpCdc " + ;
                       "WHERE Dopes = " + EscaparSQL(THIS.this_cDopes)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigRedcuGar")
            IF loc_nResult > 0
                SELECT cursor_4c_SigRedcuGar
                IF !EOF()
                    loc_cTxtTermos = ALLTRIM(NVL(TxtTermos, ""))
                    IF !EMPTY(loc_cTxtTermos)
                        IF USED(THIS.this_cCursorDados)
                            SELECT (THIS.this_cCursorDados)
                            GO TOP
                        ENDIF
                        REPORT FORM SigReDc3 TO PRINTER NOCONSOLE
                    ENDIF
                ENDIF
                IF USED("cursor_4c_SigRedcuGar")
                    USE IN cursor_4c_SigRedcuGar
                ENDIF
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredcuBO.impGarantia")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * EnviarEmail - Envia documento por email com anexo PDF ou XLS
    * par_cAnexo - Caminho completo do arquivo a anexar
    * Usa this_cEmail (passado no Init pelo form chamador)
    *--------------------------------------------------------------------------
    PROCEDURE EnviarEmail(par_cAnexo)
        LOCAL loc_lSucesso
        LOCAL loc_cEmailDest, loc_cAssunto
        loc_lSucesso = .F.
        TRY
            loc_cEmailDest = ALLTRIM(THIS.this_cEmail)
            IF EMPTY(loc_cEmailDest)
                THIS.this_cMensagemErro = "E-mail de destino n" + CHR(227) + "o definido"
                loc_lSucesso = .F.
            ENDIF
            IF EMPTY(par_cAnexo) OR !FILE(par_cAnexo)
                THIS.this_cMensagemErro = "Arquivo anexo n" + CHR(227) + "o encontrado"
                loc_lSucesso = .F.
            ENDIF
            loc_cAssunto = "Documento " + ALLTRIM(THIS.this_cDopes) + ;
                           " N" + CHR(250) + "mero " + TRANSFORM(THIS.this_nNumes)
            ForeMails(loc_cEmailDest, loc_cAssunto, par_cAnexo, ;
                      PADR(THIS.this_cEmps, 3))
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredcuBO.EnviarEmail")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.this_oFormPai = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE

