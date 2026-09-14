# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 314: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprdft.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2595 linhas total):

*-- Linhas 236 a 281:
236:         loc_oCnt = THIS.cnt_4c_Cabecalho
237: 
238:         WITH loc_oCnt
239:             .Top         = 0
240:             .Left        = 0
241:             .Width       = THIS.Width
242:             .Height      = 80
243:             .BorderWidth = 0
244:             .BackColor   = RGB(100,100,100)
245: 
246:             .AddObject("lbl_4c_Sombra", "Label")
247:             WITH .lbl_4c_Sombra
248:                 .AutoSize      = .F.
249:                 .FontBold      = .T.
250:                 .FontName      = "Tahoma"
251:                 .FontSize      = 18
252:                 .FontUnderline = .F.
253:                 .WordWrap      = .T.
254:                 .Alignment     = 0
255:                 .BackStyle     = 0
256:                 .Caption       = "Sitef - Cart" + CHR(227) + "o de D" + CHR(233) + "bito"
257:                 .Height        = 40
258:                 .Left          = 10
259:                 .Top           = 18
260:                 .Width         = THIS.Width
261:                 .ForeColor     = RGB(0,0,0)
262:             ENDWITH
263: 
264:             .AddObject("lbl_4c_Titulo", "Label")
265:             WITH .lbl_4c_Titulo
266:                 .AutoSize   = .F.
267:                 .FontBold   = .T.
268:                 .FontName   = "Tahoma"
269:                 .FontSize   = 18
270:                 .WordWrap   = .T.
271:                 .Alignment  = 0
272:                 .BackStyle  = 0
273:                 .Caption    = "Sitef - Cart" + CHR(227) + "o de D" + CHR(233) + "bito"
274:                 .Height     = 46
275:                 .Left       = 10
276:                 .Top        = 17
277:                 .Width      = THIS.Width
278:                 .ForeColor  = RGB(255,255,255)
279:             ENDWITH
280:         ENDWITH
281:     ENDPROC

*-- Linhas 297 a 323:
297:             .BorderStyle = 0
298:             .Value       = 0
299:             .Height      = 85
300:             .Left        = 420
301:             .Top         = -2
302:             .Width       = 85
303:             .TabIndex    = 8
304:             .BackColor   = RGB(255,255,255)
305:             .Themes      = .F.
306: 
307:             WITH .Buttons(1)
308:                 .Top                = 5
309:                 .Left               = 5
310:                 .Height             = 75
311:                 .Width              = 75
312:                 .FontBold           = .T.
313:                 .FontItalic         = .T.
314:                 .FontName           = "Comic Sans MS"
315:                 .FontSize           = 8
316:                 .Picture            = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
317:                 .DisabledPicture    = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
318:                 .Caption            = "Cancelar"
319:                 .Cancel             = .F.
320:                 .ForeColor          = RGB(90,90,90)
321:                 .BackColor          = RGB(255,255,255)
322:                 .Themes             = .F.
323:                 .SpecialEffect      = 0

*-- Linhas 337 a 346:
337:         THIS.AddObject("shp_4c_Shape2", "Shape")
338: 
339:         WITH THIS.shp_4c_Shape2
340:             .Top           = 93
341:             .Left          = 17
342:             .Height        = 202
343:             .Width         = 466
344:             .SpecialEffect = 0
345:         ENDWITH
346:     ENDPROC

*-- Linhas 357 a 381:
357:         loc_oCnt = THIS.cnt_4c_Instrucao
358: 
359:         WITH loc_oCnt
360:             .Top           = 298
361:             .Left          = 54
362:             .Width         = 392
363:             .Height        = 58
364:             .SpecialEffect = 0
365: 
366:             .AddObject("lbl_4c_Instrucao", "Label")
367:             WITH .lbl_4c_Instrucao
368:                 .AutoSize   = .F.
369:                 .FontBold   = .T.
370:                 .FontName   = "Tahoma"
371:                 .FontSize   = 18
372:                 .Alignment  = 2
373:                 .Caption    = "Insira ou Passe" + CHR(13) + "o Cart" + CHR(227) + "o"
374:                 .Height     = 29
375:                 .Left       = 18
376:                 .Top        = 14
377:                 .Width      = 349
378:                 .ForeColor  = RGB(90,90,90)
379:                 .BackStyle  = 0
380:             ENDWITH
381:         ENDWITH

*-- Linhas 415 a 439:
415:                 IF VARTYPE(THIS.txt_4c_Cartao) = "O"
416:                     THIS.txt_4c_Cartao.Enabled = .T.
417:                 ENDIF
418:                 IF VARTYPE(THIS.lbl_4c_Label2) = "O"
419:                     THIS.lbl_4c_Label2.Caption = "Validade Cart" + CHR(227) + "o :"
420:                 ENDIF
421:             ENDIF
422: 
423:             *-- Instrucao inicial conforme tipo de entrada do cartao
424:             IF VARTYPE(THIS.cnt_4c_Instrucao) = "O"
425:                 IF VARTYPE(THIS.txt_4c_Datas) = "O" AND !THIS.txt_4c_Datas.Enabled
426:                     IF loc_oBO.this_cLCartao = "N"
427:                         THIS.cnt_4c_Instrucao.lbl_4c_Instrucao.Caption = ;
428:                             "Insira ou Passe" + CHR(13) + "o Cart" + CHR(227) + "o"
429:                     ELSE
430:                         THIS.cnt_4c_Instrucao.lbl_4c_Instrucao.Caption = ;
431:                             "Digite o N" + CHR(250) + "mero" + CHR(13) + "do Cart" + CHR(227) + "o"
432:                     ENDIF
433:                 ELSE
434:                     THIS.cnt_4c_Instrucao.lbl_4c_Instrucao.Caption = ;
435:                         "Insira ou Passe" + CHR(13) + "o Cart" + CHR(227) + "o"
436:                 ENDIF
437:             ENDIF
438: 
439:             *-- OptionGroup de tipo de venda: desabilitado ate completar handshake SiTef

*-- Linhas 588 a 616:
588:         LOCAL loc_oErro
589:         TRY
590:             *-- Label5: VALOR : (SCX original: AutoSize=.T., FontBold=.T.)
591:             THIS.AddObject("lbl_4c_Label5", "Label")
592:             WITH THIS.lbl_4c_Label5
593:                 .AutoSize  = .T.
594:                 .FontBold  = .T.
595:                 .Caption   = "VALOR :"
596:                 .Top       = 102
597:                 .Left      = 175
598:                 .Width     = 45
599:                 .Height    = 15
600:                 .FontName  = "Tahoma"
601:                 .FontSize  = 8
602:                 .ForeColor = RGB(90,90,90)
603:                 .BackStyle = 0
604:             ENDWITH
605: 
606:             *-- GetValor -> txt_4c_Valor: exibe valor formatado
607:             *-- SCX original: Enabled=.F. (nao ReadOnly), FontBold=.T., Alignment=3, InputMask, Value=0
608:             THIS.AddObject("txt_4c_Valor", "TextBox")
609:             WITH THIS.txt_4c_Valor
610:                 .Top       = 99
611:                 .Left      = 222
612:                 .Width     = 100
613:                 .Height    = 23
614:                 .FontBold  = .T.
615:                 .FontName  = "Tahoma"
616:                 .FontSize  = 8

*-- Linhas 623 a 651:
623:             ENDWITH
624: 
625:             *-- Label8: NUMERO CARTAO : (SCX original: AutoSize=.T., FontBold=.T., sem acento)
626:             THIS.AddObject("lbl_4c_Label8", "Label")
627:             WITH THIS.lbl_4c_Label8
628:                 .AutoSize  = .T.
629:                 .FontBold  = .T.
630:                 .Caption   = "NUMERO CARTAO :"
631:                 .Top       = 136
632:                 .Left      = 116
633:                 .Width     = 104
634:                 .Height    = 15
635:                 .FontName  = "Tahoma"
636:                 .FontSize  = 8
637:                 .ForeColor = RGB(90,90,90)
638:                 .BackStyle = 0
639:             ENDWITH
640: 
641:             *-- GetCartao -> txt_4c_Cartao: numero mascarado do cartao (preenchido pelo SiTef)
642:             *-- SCX original: Enabled=.F., FontBold=.T., Alignment=3, InputMask, MaxLength=19
643:             THIS.AddObject("txt_4c_Cartao", "TextBox")
644:             WITH THIS.txt_4c_Cartao
645:                 .Top       = 133
646:                 .Left      = 222
647:                 .Width     = 160
648:                 .Height    = 23
649:                 .FontBold  = .T.
650:                 .FontName  = "Tahoma"
651:                 .FontSize  = 8

*-- Linhas 659 a 687:
659:             ENDWITH
660: 
661:             *-- Label2: 4 ULTIMOS DIGITOS : (SCX original: FontBold=.T.)
662:             THIS.AddObject("lbl_4c_Label2", "Label")
663:             WITH THIS.lbl_4c_Label2
664:                 .AutoSize  = .F.
665:                 .FontBold  = .T.
666:                 .Caption   = "4 ULTIMOS DIGITOS :"
667:                 .Top       = 171
668:                 .Left      = 101
669:                 .Width     = 119
670:                 .Height    = 17
671:                 .FontName  = "Tahoma"
672:                 .FontSize  = 8
673:                 .ForeColor = RGB(90,90,90)
674:                 .BackStyle = 0
675:             ENDWITH
676: 
677:             *-- GetDigitos -> txt_4c_Digitos: 4 ultimos digitos (campo principal SiTef)
678:             *-- SCX original: FontBold=.T., InputMask="9999", BackColor=212,208,200, ForeColor=0,0,0
679:             THIS.AddObject("txt_4c_Digitos", "TextBox")
680:             WITH THIS.txt_4c_Digitos
681:                 .Top       = 168
682:                 .Left      = 222
683:                 .Width     = 40
684:                 .Height    = 23
685:                 .FontBold  = .T.
686:                 .FontName  = "Tahoma"
687:                 .FontSize  = 8

*-- Linhas 693 a 764:
693:             ENDWITH
694: 
695:             *-- Label4: TIPO DE VENDA :
696:             THIS.AddObject("lbl_4c_Label4", "Label")
697:             WITH THIS.lbl_4c_Label4
698:                 .AutoSize  = .F.
699:                 .Caption   = "TIPO DE VENDA :"
700:                 .Top       = 204
701:                 .Left      = 129
702:                 .Width     = 91
703:                 .Height    = 15
704:                 .FontName  = "Tahoma"
705:                 .FontSize  = 8
706:                 .ForeColor = RGB(90,90,90)
707:                 .BackStyle = 0
708:             ENDWITH
709: 
710:             *-- Label6: N? PARCELAS :
711:             THIS.AddObject("lbl_4c_Label6", "Label")
712:             WITH THIS.lbl_4c_Label6
713:                 .AutoSize  = .F.
714:                 .Caption   = "N" + CHR(186) + " PARCELAS :"
715:                 .Top       = 238
716:                 .Left      = 139
717:                 .Width     = 81
718:                 .Height    = 15
719:                 .FontName  = "Tahoma"
720:                 .FontSize  = 8
721:                 .ForeColor = RGB(90,90,90)
722:                 .BackStyle = 0
723:             ENDWITH
724: 
725:             *-- Text1 -> txt_4c_Text1: numero de parcelas (habilitado apenas em parcelado)
726:             THIS.AddObject("txt_4c_Text1", "TextBox")
727:             WITH THIS.txt_4c_Text1
728:                 .Top       = 235
729:                 .Left      = 222
730:                 .Width     = 27
731:                 .Height    = 23
732:                 .FontName  = "Tahoma"
733:                 .FontSize  = 8
734:                 .MaxLength = 2
735:                 .Enabled   = .F.
736:                 .TabIndex  = 4
737:                 .Value     = ""
738:             ENDWITH
739: 
740:             *-- Label11: 1a PARCELA/VENCTO :
741:             THIS.AddObject("lbl_4c_Label11", "Label")
742:             WITH THIS.lbl_4c_Label11
743:                 .AutoSize  = .F.
744:                 .Caption   = "1" + CHR(170) + " PARCELA/VENCTO :"
745:                 .Top       = 268
746:                 .Left      = 98
747:                 .Width     = 122
748:                 .Height    = 15
749:                 .FontName  = "Tahoma"
750:                 .FontSize  = 8
751:                 .ForeColor = RGB(90,90,90)
752:                 .BackStyle = 0
753:             ENDWITH
754: 
755:             *-- GetDatas -> txt_4c_Datas: data de vencimento para parcelado pre-datado
756:             THIS.AddObject("txt_4c_Datas", "TextBox")
757:             WITH THIS.txt_4c_Datas
758:                 .Top       = 266
759:                 .Left      = 222
760:                 .Width     = 75
761:                 .Height    = 23
762:                 .FontName  = "Tahoma"
763:                 .FontSize  = 8
764:                 .Format    = "D"

*-- Linhas 783 a 814:
783:             THIS.AddObject("obj_4c_TipoVenda", "OptionGroup")
784: 
785:             WITH THIS.obj_4c_TipoVenda
786:                 .Top         = 200
787:                 .Left        = 222
788:                 .Width       = 161
789:                 .Height      = 26
790:                 .ButtonCount = 2
791:                 .Value       = 1
792:                 .BackStyle   = 0
793:                 .BorderStyle = 0
794:                 .TabIndex    = 6
795: 
796:                 WITH .Buttons(1)
797:                     .Caption   = CHR(192) + " Vista"
798:                     .Top       = 2
799:                     .Left      = 0
800:                     .Width     = 70
801:                     .Height    = 20
802:                     .BackStyle = 0
803:                     .ForeColor = RGB(90,90,90)
804:                 ENDWITH
805: 
806:                 WITH .Buttons(2)
807:                     .Caption   = "Parcelado"
808:                     .Top       = 2
809:                     .Left      = 75
810:                     .Width     = 80
811:                     .Height    = 20
812:                     .FontName  = "Tahoma"
813:                     .FontSize  = 8
814:                     .BackStyle = 0

*-- Linhas 846 a 861:
846: 
847:     *==========================================================================
848:     * AtualizarInstrucao - Atualiza label de instrucao ao usuario
849:     * Equivale a ThisForm.Container1.Label1.Caption = ... no legado
850:     *==========================================================================
851:     PROCEDURE AtualizarInstrucao(par_cTexto)
852:         LOCAL loc_oErro
853:         TRY
854:             IF VARTYPE(THIS.cnt_4c_Instrucao) = "O" AND ;
855:                VARTYPE(THIS.cnt_4c_Instrucao.lbl_4c_Instrucao) = "O"
856:                 THIS.cnt_4c_Instrucao.lbl_4c_Instrucao.Caption = par_cTexto
857:             ENDIF
858:         CATCH TO loc_oErro
859:             MsgErro(loc_oErro.Message, "Erro AtualizarInstrucao")
860:         ENDTRY
861:     ENDPROC

*-- Linhas 1374 a 1382:
1374: 
1375:                 *-- Pos-loop: visibilidade do container de instrucao
1376:                 IF VARTYPE(THIS.cnt_4c_Instrucao) = "O"
1377:                     THIS.cnt_4c_Instrucao.lbl_4c_Instrucao.Visible = .T.
1378:                 ENDIF
1379: 
1380:                 *-- Libera form em caso de erro ou abandono
1381:                 IF loc_nRet < 0 OR THIS.this_lAbandona
1382:                     THIS.Release()


### BO (C:\4c\projeto\app\classes\sigprdftBO.prg):
*==============================================================================
* sigprdftBO.prg - Business Object para TEF SiTef Cartao de Debito
* Herda de BusinessBase
* Formulario original: SIGPRDFT.SCX
*==============================================================================

DEFINE CLASS sigprdftBO AS BusinessBase

    *-- Parametros de entrada (recebidos do chamador)
    this_cEndSiTef       = ""   && Endereco do servidor SiTef
    this_nValPago        = 0    && Valor a pagar
    this_cCupom          = ""   && Numero do cupom
    this_cCaixa          = ""   && Identificador do caixa
    this_cDebCred        = ""   && Debito/Credito/Pre-datado (D/C/P)
    this_cTipPagto       = ""   && Tipo de pagamento
    this_nNumParcs       = 0    && Numero de parcelas
    this_nIdent          = 0    && Identificador da transacao (ltIdent)
    this_cOpers          = ""   && Codigo da operacao/forma de pagamento (FPags)

    *-- Estado da transacao SiTef (variaveis PUBLIC no legado)
    this_cIdTerminal     = ""   && ID do terminal SiTef (lsIdTerminal)
    this_lDCD            = .F.  && Flag data credito/debito (DCD)
    this_dData           = {}   && Data da transacao (ldData)
    this_nProximoComando = 0    && Proximo comando SiTef (ProximoComando)
    this_nTipoCampo      = 0    && Tipo de campo SiTef (TipoCampo)
    this_nTamanhoMinimo  = 0    && Tamanho minimo do campo (TamanhoMinimo)
    this_nTamanhoMaximo  = 0    && Tamanho maximo do campo (TamanhoMaximo)
    this_cBuffer         = ""   && Buffer de comunicacao SiTef 2000 chars (Buffer)
    this_nContinua       = 0    && Flag/resultado de continuacao (lnContinua)
    this_nCiclos         = 0    && Contador de ciclos (lnCiclos)
    this_cParcs          = ""   && Parcelas formatadas "@L 99" (lnParcs string)

    *-- Resultados da transacao
    this_cBandeira       = ""   && Bandeira do cartao - codigo (pcBandeira)
    this_cCartao         = ""   && 5 primeiros digitos do cartao (lsCartao)
    this_cSaque          = ""   && Valor do saque formato "0,00" (lcSaque)
    this_cTipTran        = ""   && Tipo de transacao retornado pelo SiTef (lsTipTran)
    this_cDataHora       = ""   && Data e hora da transacao (lsDataHora)
    this_cNsu            = ""   && NSU da transacao (lsNsu)
    this_cAutoriza       = ""   && Codigo de autorizacao (lsAutoriza)
    this_cFinaliza       = ""   && Buffer de finalizacao (lsFinaliza)
    this_cMensagem       = ""   && Mensagem da transacao (lsMensagem)
    this_cMRet           = ""   && Mensagem de retorno adicional (lsMRet)

    *-- Estado do formulario (propriedades customizadas do form legado)
    this_lTvenda         = .T.  && Habilita selecao de tipo de venda (pctvenda)
    this_lKeyEsc         = .T.  && Habilita tecla ESC (pckeyesc)
    this_lAbandona       = .F.  && Flag de abandono da operacao (abandona)

    *-- Dados do registro SigOpFp (forma de pagamento)
    this_cFPags          = ""   && Codigo da forma de pagamento (FPags)
    this_cTcdc           = ""   && Tipo CDC - controla fluxo parcelado (Tcdc)
    this_cGarantias      = ""   && Habilita inversao de risco (Garantias S/N)
    this_cLSaque         = ""   && Permite operacao de saque (lSaque S/N)
    this_cLCartao        = ""   && Cartao numerico (lCartao S/N)
    this_nDias           = 0    && Dias para pre-datado (Dias)
    this_nMesFec         = 0    && Mes de fechamento CDC (MesFec)

    *-- Dados da empresa SigCdEmp
    this_nEmps           = 0    && Numero da empresa para compor terminal (nEmps)
    this_cEmpresa        = ""   && Codigo da empresa (cEmps)

    *-- Dados do caixa SigFiMpF
    this_nCncaixas       = 0    && Numero do caixa para compor ID terminal (Cncaixas)

    *==========================================================================
    * Init - Inicializa o BO de integracao SiTef
    *==========================================================================
    PROCEDURE Init()
        this_cTabela     = ""
        this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades de SigOpFp do cursor informado
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cFPags     = TratarNulo(FPags,      "C")
                THIS.this_cTcdc      = TratarNulo(Tcdc,       "C")
                THIS.this_cGarantias = TratarNulo(Garantias,  "C")
                THIS.this_cLSaque    = TratarNulo(lSaque,     "C")
                THIS.this_cLCartao   = TratarNulo(lCartao,    "C")
                THIS.this_nDias      = TratarNulo(Dias,       "N")
                THIS.this_nMesFec    = TratarNulo(MesFec,     "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarConfig - SQLEXEC para carregar SigOpFp e SigCdEmp
    *==========================================================================
    PROCEDURE CarregarConfig(par_cOpers)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        loc_lSucesso = .F.
        TRY
            *-- Forma de pagamento
            loc_cSQL = "SELECT FPags, Tcdc, Garantias, lSaque, lCartao, Dias, MesFec " + ;
                       "FROM SigOpFp WHERE FPags = " + EscaparSQL(ALLTRIM(par_cOpers))
            IF USED("cursor_4c_SigOpFp")
                TABLEREVERT(.T., "cursor_4c_SigOpFp")
                USE IN cursor_4c_SigOpFp
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigOpFp")
            IF loc_nRet > 0 AND !EOF("cursor_4c_SigOpFp")
                THIS.CarregarDoCursor("cursor_4c_SigOpFp")
            ENDIF

            *-- Empresa
            loc_cSQL = "SELECT cEmps, nEmps FROM SigCdEmp " + ;
                       "WHERE cEmps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
            IF USED("cursor_4c_SigCdEmp")
                TABLEREVERT(.T., "cursor_4c_SigCdEmp")
                USE IN cursor_4c_SigCdEmp
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdEmp")
            IF loc_nRet > 0 AND !EOF("cursor_4c_SigCdEmp")
                SELECT cursor_4c_SigCdEmp
                THIS.this_nEmps    = TratarNulo(nEmps, "N")
                THIS.this_cEmpresa = TratarNulo(cEmps, "C")
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar configura" + CHR(231) + CHR(227) + "o SiTef")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarCaixa - SQLEXEC para carregar numero do caixa (SigFiMpF)
    *==========================================================================
    PROCEDURE CarregarCaixa(par_cCaixa)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT Cncaixas FROM SigFiMpF"
            IF USED("cursor_4c_SigFiMpF")
                TABLEREVERT(.T., "cursor_4c_SigFiMpF")
                USE IN cursor_4c_SigFiMpF
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigFiMpF")
            IF loc_nRet > 0 AND !EOF("cursor_4c_SigFiMpF")
                SELECT cursor_4c_SigFiMpF
                THIS.this_nCncaixas = TratarNulo(Cncaixas, "N")
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar dados do caixa")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * MontarRetorno - Monta cursor crSiTef e escreve arquivos de retorno de sucesso
    * Equivale ao PROCEDURE montaretorno do legado
    *==========================================================================
    PROCEDURE MontarRetorno(par_cTipTran, par_cDataHora, par_cCupom, par_cCartaoBandeira, ;
                             par_cNsu, par_cAutoriza, par_cFinaliza, par_nValPago, par_cMenRet)
        LOCAL loc_lSucesso, loc_cValPago, loc_cBandIdx, loc_nPos, loc_nLinha, loc_cCupom
        LOCAL ARRAY loc_aCartao[11]
        loc_lSucesso = .F.
        TRY
            loc_cValPago = STRTRAN(ALLTRIM(TRANSFORM(par_nValPago, "99999999999.99")), ".", ",")

            loc_aCartao[1]  = "Outro, nao definido"
            loc_aCartao[2]  = "Visa"
            loc_aCartao[3]  = "Mastercard"
            loc_aCartao[4]  = "Diners"
            loc_aCartao[5]  = "American Express"
            loc_aCartao[6]  = "Sollo"
            loc_aCartao[7]  = "Sidecard (Redecard)"
            loc_aCartao[8]  = "Private Label (Redecard)"
            loc_aCartao[9]  = "Redeshop"
            loc_aCartao[10] = ""
            loc_aCartao[11] = "Fininvest"

            IF VAL(THIS.this_cBandeira) > 10 .OR. VAL(THIS.this_cBandeira) < 0
                loc_cBandIdx = "0"
            ELSE
                loc_cBandIdx = THIS.this_cBandeira
            ENDIF

            IF USED("crSiTef")
                USE IN crSiTef
            ENDIF
            CREATE CURSOR crSiTef (tef C(100))

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(THIS.this_nIdent, 10))
            INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("003-000 = " + loc_cValPago)
            INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("009-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("010-000 = " + loc_aCartao[VAL(loc_cBandIdx) + 1])
            INSERT INTO crSiTef (Tef) VALUES ("011-000 = " + par_cTipTran)
            INSERT INTO crSiTef (Tef) VALUES ("012-000 = " + par_cNsu)
            INSERT INTO crSiTef (Tef) VALUES ("013-000 = " + par_cAutoriza)
            INSERT INTO crSiTef (Tef) VALUES ("015-000 = " + ;
                SUBSTR(par_cDataHora, 7, 2) + ;
                SUBSTR(par_cDataHora, 5, 2) + ;
                SUBSTR(par_cDataHora, 9, 6))
            INSERT INTO crSiTef (Tef) VALUES ("017-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("018-000 = " + ;
                ALLTRIM(TRANSFORM(THIS.this_nNumParcs, "@L 99")))
            INSERT INTO crSiTef (Tef) VALUES ("017-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("019-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("020-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("021-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("022-000 = " + ;
                SUBSTR(par_cDataHora, 7, 2) + ;
                SUBSTR(par_cDataHora, 5, 2) + ;
                SUBSTR(par_cDataHora, 1, 4))
            INSERT INTO crSiTef (Tef) VALUES ("023-000 = " + SUBSTR(par_cDataHora, 9, 6))
            INSERT INTO crSiTef (Tef) VALUES ("023-000 = " + par_cFinaliza)
            INSERT INTO crSiTef (Tef) VALUES ("027-000 = " + SUBSTR(par_cDataHora, 9, 6))

            loc_cCupom = par_cCupom
            loc_nPos   = 1
            loc_nLinha = 1
            DO WHILE loc_nPos <> 0
                loc_nPos = AT(CHR(10), loc_cCupom)
                INSERT INTO crSiTef (Tef) VALUES ("029-" + TRANSFORM(loc_nLinha, "@L 999") + ;
                    " = " + IIF(loc_nPos <> 0, SUBSTR(loc_cCupom, 1, loc_nPos - 1), loc_cCupom))
                loc_cCupom = SUBSTR(loc_cCupom, loc_nPos + 1)
                loc_nLinha = loc_nLinha + 1
            ENDDO
            INSERT INTO crSiTef (Tef) VALUES ("028-000 = " + ALLTRIM(STR(loc_nLinha - 2)))
            INSERT INTO crSiTef (Tef) VALUES ("030-000 = " + par_cMenRet)
            INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            SELECT crSiTef
            SET SAFETY OFF
            COPY TO C:\client\Resp\IntPos.001 SDF
            ZAP

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(THIS.this_nIdent, 10))
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            COPY TO C:\client\Resp\IntPos.STS SDF
            SET SAFETY ON

            USE IN crSiTef

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            SET SAFETY ON
            MsgErro(loc_oErro.Message, "Erro ao montar retorno SiTef")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * RetornoFalha - Monta cursor crSiTef e escreve arquivos de retorno de falha
    * Equivale ao PROCEDURE retornofalha do legado
    *==========================================================================
    PROCEDURE RetornoFalha(par_cMensagem, par_nValPago)
        LOCAL loc_lSucesso, loc_cValPago, loc_cMensagem
        loc_lSucesso = .F.
        TRY
            loc_cMensagem = IIF(EMPTY(par_cMensagem), ;
                "Opera" + CHR(231) + CHR(227) + "o Cancelada Pelo Usuario", par_cMensagem)
            loc_cValPago = STRTRAN(ALLTRIM(TRANSFORM(par_nValPago, "99999999999.99")), ".", ",")

            IF USED("crSiTef")
                USE IN crSiTef
            ENDIF
            CREATE CURSOR crSiTef (tef C(100))

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(THIS.this_nIdent, 10))
            INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("003-000 = " + loc_cValPago)
            INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("009-000 = FF")
            INSERT INTO crSiTef (Tef) VALUES ("010-000 = 05")
            INSERT INTO crSiTef (Tef) VALUES ("028-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("030-000 = " + ;
                IIF("AGUARDE" $ UPPER(loc_cMensagem), "TRANSACAO CANCELADA", loc_cMensagem))
            INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            SELECT crSiTef
            SET SAFETY OFF
            COPY TO C:\client\Resp\IntPos.001 SDF
            ZAP

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(THIS.this_nIdent, 10))
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            COPY TO C:\client\Resp\IntPos.STS SDF
            SET SAFETY ON

            USE IN crSiTef

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            SET SAFETY ON
            MsgErro(loc_oErro.Message, "Erro ao montar retorno de falha SiTef")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ErroTef - Trata codigos de erro retornados pelo SiTef (-1 a -5)
    * Equivale ao PROCEDURE errotef do legado
    *==========================================================================
    PROCEDURE ErroTef(par_nRetorno)
        LOCAL loc_oErro
        TRY
            IF VARTYPE(par_nRetorno) = "N" AND ;
               (par_nRetorno > -1 OR par_nRetorno < -5)
                THIS.RetornoFalha("Operacao Cancelada pelo Usuario", 0)
            ELSE
                DO CASE
                    CASE par_nRetorno = -1
                        THIS.RetornoFalha("Modulo Nao Iniciado", 0)
                    CASE par_nRetorno = -2
                        THIS.RetornoFalha("Operacao Cancelada pelo Usuario", 0)
                    CASE par_nRetorno = -3
                        THIS.RetornoFalha("Fornecida uma Modalidade Invalida", 0)
                    CASE par_nRetorno = -4
                        THIS.RetornoFalha("Falta Memoria para Rodar a Funcao", 0)
                    CASE par_nRetorno = -5
                        THIS.RetornoFalha("Sem Comunicacao com o SiTef", 0)
                ENDCASE
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao tratar erro SiTef")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ObterResultadoFinal - Retorna string de resultado da transacao
    * Equivale ao PROCEDURE Unload do legado
    * Formato: "lcSaque/lnParcs/DTOC(ldData)+pcBandeira+lsCartao"
    *==========================================================================
    FUNCTION ObterResultadoFinal()
        LOCAL loc_cBandeira, loc_cCartao, loc_cResultado
        loc_cResultado = ""
        TRY
            loc_cBandeira = IIF(VARTYPE(THIS.this_cBandeira) <> "C" .OR. EMPTY(THIS.this_cBandeira), ;
                "00000", THIS.this_cBandeira)
            loc_cCartao   = IIF(VARTYPE(THIS.this_cCartao) <> "C" .OR. EMPTY(THIS.this_cCartao), ;
                "00000", THIS.this_cCartao)
            loc_cResultado = THIS.this_cSaque + "/" + ;
                             ALLTRIM(TRANSFORM(THIS.this_nNumParcs, "@L 99")) + "/" + ;
                             DTOC(THIS.this_dData) + ;
                             loc_cBandeira + ;
                             loc_cCartao
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao obter resultado final SiTef")
            loc_cResultado = "0,00/00/" + DTOC(DATE()) + "00000" + "00000"
        ENDTRY
        RETURN loc_cResultado
    ENDFUNC

    *==========================================================================
    * Inserir - Nao aplicavel para form TEF (sem tabela SQL Server)
    *==========================================================================
    FUNCTION Inserir()
        RETURN .T.
    ENDFUNC

    *==========================================================================
    * Atualizar - Nao aplicavel para form TEF (sem tabela SQL Server)
    *==========================================================================
    FUNCTION Atualizar()
        RETURN .T.
    ENDFUNC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave da forma de pagamento
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cFPags
    ENDFUNC

ENDDEFINE

