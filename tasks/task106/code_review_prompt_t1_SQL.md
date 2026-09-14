# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: FPAGS, TMPNF, NFIS, SERIES, EMPDOPNUMS

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES SQL
- [GRID-SQL] Campos no ControlSource que nao existem no CREATE CURSOR/SELECT
- [SQL-COLUNA] Nomes de colunas que NAO existem na tabela (validado contra banco real)
  - A mensagem mostra colunas VALIDAS - usar nome EXATO
  - Se sugere "voce quis dizer 'X'?", usar X
- [SQL-TABELA] Tabela inventada que nao existe no original
- [SQL-ASPAS] Aspas duplicadas ou concatenacao sem EscaparSQL
  - EscaparSQL() JA retorna com aspas. FormatarDataSQL() idem.
- [SQL-FILTRO-INVENTADO] Condicao WHERE inventada pela LLM - REMOVER
- [TRANSACAO-AVULSA] COMMIT/ROLLBACK sem BEGIN TRANSACTION - REMOVER

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

### LINHAS SQL/CONTROLSOURCE DO CODIGO ORIGINAL (referencia):
  DeleteMark = .F.
  Column1.ControlSource = "TmpNFis.Flag"
  Column2.ControlSource = "TmpNFis.NFis"
  Column3.ControlSource = "TmpNFis.Datas"
  Column4.ControlSource = "TmpNFis.Digito"
  Column5.ControlSource = "TmpNFis.Vecto"
  Column6.ControlSource = "TmpNFis.Valor"
  Column7.ControlSource = "TmpNFis.Conta"
  Column8.ControlSource = "TmpNFis.Emps + TmpNFis.Dopes + Str(TmpNFis.Numes, 6)"
	Select Emps, Dopes, Numes, Parcs ;
	  From TmpNFis ;
	lcSql = [Select count(*) as qt from SigCnFBl Where fpags <> ' ']
	If Thisform.Podatamgr.Sqlexecute(lcsql,'LocalCfg') < 1
		Select TprMvCab
Select TmpNFis
		Select crSigOpFp
Select TmpNFis
lcQuery = [Select a.NFis, a.CliFors, a.TotNotas, a.Emps, a.Dopes, a.Numes, ] + ;
		    [From SigMvNfi a, SigMvPar b ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigMvNfi') < 1)
Select crSigMvNfi
	oProg.Update(.t.)
	=Seek(crSigMvNfi.FPags, 'crSigOpFp', 'FPags')
	Insert Into TmpNFis (Flag, NFis, Valor, Datas, Conta, Digito, Parcs, Vecto, TotNotas, Obs, Emps, Dopes, Numes) ;
Select TmpNFis
Update TmpNFis Set Flag = .f.
Update TmpNFis Set Flag = .t.

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREGDP.prg) - TRECHOS RELEVANTES PARA PASS SQL (1215 linhas total):

*-- Linhas 572 a 744:
572:             .FontSize           = 8
573:             .AllowHeaderSizing  = .F.
574:             .AllowRowSizing     = .F.
575:             .DeleteMark         = .F.
576:             .RecordMark         = .F.
577:             .ScrollBars         = 2
578:             .GridLineColor      = RGB(238, 238, 238)
579:             .HighlightBackColor = RGB(255, 255, 255)
580:             .HighlightForeColor = RGB(15, 41, 104)
581:             .HighlightStyle     = 2
582:             .RecordSource       = THIS.this_oRelatorio.this_cCursorDados
583:             .Visible            = .T.
584: 
585:             *-- Column1: CheckBox Flag (W=20)
586:             *-- ORDEM CRITICA: AddObject -> CurrentControl -> ControlSource
587:             .Column1.Width             = 20
588:             .Column1.Movable           = .F.
589:             .Column1.Resizable         = .F.
590:             .Column1.ReadOnly          = .F.
591:             .Column1.Sparse            = .F.
592:             .Column1.FontName          = "Tahoma"
593:             .Column1.FontSize          = 8
594:             .Column1.Header1.Caption   = ""
595:             .Column1.Header1.FontName  = "Tahoma"
596:             .Column1.Header1.FontSize  = 8
597:             .Column1.Header1.Alignment = 2
598:             .Column1.Header1.ForeColor = RGB(90, 90, 90)
599:             .Column1.AddObject("Check1", "CheckBox")
600:             .Column1.Check1.Caption    = ""
601:             .Column1.Check1.BackStyle  = 0
602:             .Column1.Check1.Alignment  = 0
603:             .Column1.Check1.AutoSize   = .T.
604:             .Column1.Check1.Value      = 0
605:             .Column1.CurrentControl    = "Check1"
606:             .Column1.ControlSource     = THIS.this_oRelatorio.this_cCursorDados + ".flag"
607: 
608:             *-- Column2: NFis - Numero (W=45)
609:             .Column2.ControlSource     = THIS.this_oRelatorio.this_cCursorDados + ".nfis"
610:             .Column2.Width             = 45
611:             .Column2.Movable           = .F.
612:             .Column2.Resizable         = .F.
613:             .Column2.ReadOnly          = .T.
614:             .Column2.FontBold          = .T.
615:             .Column2.FontName          = "Tahoma"
616:             .Column2.FontSize          = 8
617:             .Column2.Header1.Caption   = "N" + CHR(250) + "mero"
618:             .Column2.Header1.FontName  = "Tahoma"
619:             .Column2.Header1.FontSize  = 8
620:             .Column2.Header1.Alignment = 2
621:             .Column2.Header1.ForeColor = RGB(90, 90, 90)
622:             .Column2.Text1.BorderStyle = 0
623:             .Column2.Text1.Margin      = 0
624:             .Column2.Text1.ReadOnly    = .T.
625:             .Column2.Text1.ForeColor   = RGB(0, 0, 0)
626:             .Column2.Text1.BackColor   = RGB(255, 255, 255)
627: 
628:             *-- Column3: Datas - Data (W=70, ColumnOrder=5)
629:             .Column3.ControlSource     = THIS.this_oRelatorio.this_cCursorDados + ".datas"
630:             .Column3.Width             = 70
631:             .Column3.ColumnOrder       = 5
632:             .Column3.Movable           = .F.
633:             .Column3.Resizable         = .F.
634:             .Column3.ReadOnly          = .T.
635:             .Column3.FontName          = "Tahoma"
636:             .Column3.FontSize          = 8
637:             .Column3.Header1.Caption   = "Data"
638:             .Column3.Header1.FontName  = "Tahoma"
639:             .Column3.Header1.FontSize  = 8
640:             .Column3.Header1.Alignment = 2
641:             .Column3.Header1.ForeColor = RGB(90, 90, 90)
642:             .Column3.Text1.BorderStyle = 0
643:             .Column3.Text1.Margin      = 0
644:             .Column3.Text1.ReadOnly    = .T.
645:             .Column3.Text1.ForeColor   = RGB(0, 0, 0)
646:             .Column3.Text1.BackColor   = RGB(255, 255, 255)
647: 
648:             *-- Column4: Digito (W=16, ColumnOrder=3)
649:             .Column4.ControlSource     = THIS.this_oRelatorio.this_cCursorDados + ".digito"
650:             .Column4.Width             = 16
651:             .Column4.ColumnOrder       = 3
652:             .Column4.Movable           = .F.
653:             .Column4.Resizable         = .F.
654:             .Column4.ReadOnly          = .T.
655:             .Column4.FontName          = "Tahoma"
656:             .Column4.FontSize          = 8
657:             .Column4.Header1.Caption   = ""
658:             .Column4.Header1.FontName  = "Tahoma"
659:             .Column4.Header1.FontSize  = 8
660:             .Column4.Header1.Alignment = 2
661:             .Column4.Header1.ForeColor = RGB(90, 90, 90)
662:             .Column4.Text1.BorderStyle = 0
663:             .Column4.Text1.Margin      = 0
664:             .Column4.Text1.ReadOnly    = .T.
665:             .Column4.Text1.ForeColor   = RGB(0, 0, 0)
666:             .Column4.Text1.BackColor   = RGB(255, 255, 255)
667: 
668:             *-- Column5: Vecto (W=70, ColumnOrder=7)
669:             .Column5.ControlSource     = THIS.this_oRelatorio.this_cCursorDados + ".vecto"
670:             .Column5.Width             = 70
671:             .Column5.ColumnOrder       = 7
672:             .Column5.Movable           = .F.
673:             .Column5.Resizable         = .F.
674:             .Column5.ReadOnly          = .T.
675:             .Column5.FontName          = "Tahoma"
676:             .Column5.FontSize          = 8
677:             .Column5.Header1.Caption   = "Vecto"
678:             .Column5.Header1.FontName  = "Tahoma"
679:             .Column5.Header1.FontSize  = 8
680:             .Column5.Header1.Alignment = 2
681:             .Column5.Header1.ForeColor = RGB(90, 90, 90)
682:             .Column5.Text1.BorderStyle = 0
683:             .Column5.Text1.Margin      = 0
684:             .Column5.Text1.ReadOnly    = .T.
685:             .Column5.Text1.ForeColor   = RGB(0, 0, 0)
686:             .Column5.Text1.BackColor   = RGB(255, 255, 255)
687: 
688:             *-- Column6: Valor (W=80)
689:             .Column6.ControlSource     = THIS.this_oRelatorio.this_cCursorDados + ".valor"
690:             .Column6.Width             = 80
691:             .Column6.Movable           = .F.
692:             .Column6.Resizable         = .F.
693:             .Column6.ReadOnly          = .T.
694:             .Column6.InputMask         = "999,999,999.99"
695:             .Column6.FontName          = "Tahoma"
696:             .Column6.FontSize          = 8
697:             .Column6.Header1.Caption   = "Valor"
698:             .Column6.Header1.FontName  = "Tahoma"
699:             .Column6.Header1.FontSize  = 8
700:             .Column6.Header1.Alignment = 2
701:             .Column6.Header1.ForeColor = RGB(90, 90, 90)
702:             .Column6.Text1.BorderStyle = 0
703:             .Column6.Text1.Margin      = 0
704:             .Column6.Text1.ReadOnly    = .T.
705:             .Column6.Text1.ForeColor   = RGB(0, 0, 0)
706:             .Column6.Text1.BackColor   = RGB(255, 255, 255)
707: 
708:             *-- Column7: Conta/Emitente-Destinatario (W=160, ColumnOrder=4)
709:             .Column7.ControlSource     = THIS.this_oRelatorio.this_cCursorDados + ".conta"
710:             .Column7.Width             = 160
711:             .Column7.ColumnOrder       = 4
712:             .Column7.Movable           = .F.
713:             .Column7.Resizable         = .F.
714:             .Column7.ReadOnly          = .T.
715:             .Column7.FontName          = "Tahoma"
716:             .Column7.FontSize          = 8
717:             .Column7.Header1.Caption   = "Emitente / Destinat" + CHR(225) + "rio"
718:             .Column7.Header1.FontName  = "Tahoma"
719:             .Column7.Header1.FontSize  = 8
720:             .Column7.Header1.Alignment = 2
721:             .Column7.Header1.ForeColor = RGB(90, 90, 90)
722:             .Column7.Text1.BorderStyle = 0
723:             .Column7.Text1.Margin      = 0
724:             .Column7.Text1.ReadOnly    = .T.
725:             .Column7.Text1.ForeColor   = RGB(0, 0, 0)
726:             .Column7.Text1.BackColor   = RGB(255, 255, 255)
727: 
728:             *-- Column8: Operacao = Emps+Dopes+STR(Numes) (W=170)
729:             .Column8.ControlSource     = THIS.this_oRelatorio.this_cCursorDados + ".emps + " + ;
730:                                           THIS.this_oRelatorio.this_cCursorDados + ".dopes + " + ;
731:                                           "STR(" + THIS.this_oRelatorio.this_cCursorDados + ".numes, 6)"
732:             .Column8.Width             = 170
733:             .Column8.Movable           = .F.
734:             .Column8.Resizable         = .F.
735:             .Column8.ReadOnly          = .T.
736:             .Column8.FontName          = "Tahoma"
737:             .Column8.FontSize          = 8
738:             .Column8.Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
739:             .Column8.Header1.FontName  = "Tahoma"
740:             .Column8.Header1.FontSize  = 8
741:             .Column8.Header1.Alignment = 2
742:             .Column8.Header1.ForeColor = RGB(90, 90, 90)
743:             .Column8.Text1.BorderStyle = 0
744:             .Column8.Text1.Margin      = 0

*-- Linhas 822 a 840:
822: 
823:     *--------------------------------------------------------------------------
824:     * BtnProcessarClick - Executa busca e popula grid (equivalente Processar.Click)
825:     *   Original: Zap In TmpNFis + Select com Where NFis Between + Where Series
826:     *--------------------------------------------------------------------------
827:     PROCEDURE BtnProcessarClick()
828:         LOCAL loc_oPagina
829:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
830: 
831:         THIS.FormParaRelatorio()
832:         IF !THIS.this_oRelatorio.PrepararDados()
833:             MsgErro(THIS.this_oRelatorio.this_cMensagemErro, "Processar")
834:         ELSE
835:             loc_oPagina.grd_4c_Dados.Refresh()
836:         ENDIF
837:         THIS.AjustarBotoesPorModo()
838:     ENDPROC
839: 
840:     *--------------------------------------------------------------------------

*-- Linhas 884 a 902:
884:                         loc_cArq = SYS(5) + SYS(2003) + "\SIGREGDP_" + ;
885:                                    STRTRAN(DTOC(DATE()), "/", "") + "_" + ;
886:                                    STRTRAN(TIME(), ":", "") + ".xls"
887:                         SELECT (THIS.this_oRelatorio.this_cCursorDados)
888:                         COPY TO (loc_cArq) TYPE XLS
889:                         MsgInfo("Arquivo exportado:" + CHR(13) + loc_cArq)
890:                         loc_lSucesso = .T.
891:                     ELSE
892:                         MsgAviso("Nenhum dado dispon" + CHR(237) + "vel para exporta" + ;
893:                                  CHR(231) + CHR(227) + "o.")
894:                     ENDIF
895:                 ENDIF
896:             ENDIF
897: 
898:         CATCH TO loc_oErro
899:             MsgErro(loc_oErro.Message, "FormSIGREGDP.BtnExcelClick")
900:         ENDTRY
901:     ENDPROC
902: 

*-- Linhas 909 a 939:
909: 
910:     *--------------------------------------------------------------------------
911:     * BtnSelTudoClick - Marca todos os registros do grid (Flag=.T.)
912:     *   Equivalente Update TmpNFis Set Flag = .t. + Grade.Refresh
913:     *--------------------------------------------------------------------------
914:     PROCEDURE BtnSelTudoClick()
915:         LOCAL loc_oPagina
916:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
917: 
918:         THIS.this_oRelatorio.SelecionarTodos()
919:         loc_oPagina.grd_4c_Dados.Refresh()
920:     ENDPROC
921: 
922:     *--------------------------------------------------------------------------
923:     * BtnDesmarcarClick - Desmarca todos os registros do grid (Flag=.F.)
924:     *   Equivalente Update TmpNFis Set Flag = .f. + Grade.Refresh
925:     *--------------------------------------------------------------------------
926:     PROCEDURE BtnDesmarcarClick()
927:         LOCAL loc_oPagina
928:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
929: 
930:         THIS.this_oRelatorio.DesmarcarTodos()
931:         loc_oPagina.grd_4c_Dados.Refresh()
932:     ENDPROC
933: 
934:     *--------------------------------------------------------------------------
935:     * BtnIncluirClick - Carrega registros na selecao a partir dos filtros
936:     *   Form de RELATORIO: "Incluir" equivale a INCLUIR notas na grade de selecao
937:     *   (SigMvNfi + SigMvPar entre NF Inicial..NF Final na Serie informada).
938:     *   Validacao previa dos filtros e delegacao para BtnProcessarClick().
939:     *--------------------------------------------------------------------------

*-- Linhas 972 a 1008:
972:     * BtnAlterarClick - Altera estado de selecao marcando todos os registros
973:     *   Form de RELATORIO: "Alterar" equivale a ALTERAR a selecao corrente,
974:     *   marcando todos os registros disponiveis no grid para emissao em lote.
975:     *   Equivalente ao SelTudo do legado (Update TmpNFis Set Flag = .t.).
976:     *--------------------------------------------------------------------------
977:     PROCEDURE BtnAlterarClick()
978:         IF VARTYPE(THIS.this_oRelatorio) != "O"
979:             RETURN
980:         ENDIF
981:         IF !THIS.this_oRelatorio.this_lProcessado
982:             MsgAviso("Execute o Processamento antes de alterar a sele" + ;
983:                      CHR(231) + CHR(227) + "o.")
984:             RETURN
985:         ENDIF
986:         THIS.BtnSelTudoClick()
987:     ENDPROC
988: 
989:     *--------------------------------------------------------------------------
990:     * BtnExcluirClick - Exclui registros da selecao desmarcando todos
991:     *   Form de RELATORIO: "Excluir" equivale a EXCLUIR registros da selecao,
992:     *   ou seja, desmarcar todos os Flag para que nenhuma duplicata/boleto
993:     *   seja emitido. Equivalente ao apaga do legado (Update Flag = .f.).
994:     *--------------------------------------------------------------------------
995:     PROCEDURE BtnExcluirClick()
996:         IF VARTYPE(THIS.this_oRelatorio) != "O"
997:             RETURN
998:         ENDIF
999:         IF !THIS.this_oRelatorio.this_lProcessado
1000:             MsgAviso("N" + CHR(227) + "o h" + CHR(225) + ;
1001:                      " registros para excluir da sele" + ;
1002:                      CHR(231) + CHR(227) + "o.")
1003:             RETURN
1004:         ENDIF
1005:         IF !MsgConfirma("Desmarcar todos os registros da sele" + ;
1006:                         CHR(231) + CHR(227) + "o?")
1007:             RETURN
1008:         ENDIF

*-- Linhas 1037 a 1055:
1037:                     loc_oBusca.mAddColuna("series", "", "C" + CHR(243) + "digos")
1038:                     loc_oBusca.Show()
1039:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_SerieRemota")
1040:                         SELECT cursor_4c_SerieRemota
1041:                         loc_oTxt.Value = ALLTRIM(series)
1042:                         USE IN cursor_4c_SerieRemota
1043:                     ENDIF
1044:                     loc_oBusca.Release()
1045:                 ENDIF
1046:             ENDIF
1047:         ENDIF
1048:     ENDPROC
1049: 
1050:     *--------------------------------------------------------------------------
1051:     * LimparCampos - Reseta campos de filtro para estado inicial
1052:     *--------------------------------------------------------------------------
1053:     PROTECTED PROCEDURE LimparCampos()
1054:         LOCAL loc_oPagina
1055:         loc_oPagina = THIS.pgf_4c_Paginas.Page1


### BO (C:\4c\projeto\app\classes\SIGREGDPBO.prg):
*==============================================================================
* SIGREGDPBO.PRG
* Business Object - Emissao Global de Duplicatas/Boletos (SIGREGDP)
* Herda de: RelatorioBase
*
* Funcionalidade:
*   - Filtros: Serie NF, NF Inicial/Final, tipo (Duplicatas ou Boletos)
*   - Carrega SigMvNfi join SigMvPar no cursor de dados (equivalente TmpNFis)
*   - Impressao: chama SigIpDup (Duplicatas) ou SigPrIbl/SigPrIbb (Boletos)
*==============================================================================

DEFINE CLASS SIGREGDPBO AS RelatorioBase

    *-- Identificacao (sem tabela CRUD - form operacional)
    this_cTabela        = ""
    this_cCampoChave    = ""

    *-- Filtros do formulario
    this_cSerieNf       = ""    && Serie da NF (Get_Serie, C(3))
    this_cNFIni         = ""    && NF Inicial (Get_NFIni, C(6))
    this_cNFFim         = ""    && NF Final (Get_NFFim, C(6))
    this_nSelecao       = 0     && 1=Duplicatas, 2=Boletos Bancarios

    *-- Nomes dos cursores de trabalho
    this_cCursorDados   = "cursor_4c_Dados"     && Equivalente a TmpNFis (grid)
    this_cCursorOpFp    = "cursor_4c_OpFp"      && SigOpFp (FPags, ImpDups, ImpBols, ImpNotas)
    this_cCursorPam     = "cursor_4c_Pam"       && SigCdPam (MascNums)
    this_cCursorNfi     = "cursor_4c_NfiFiltro" && SigMvNfi JOIN SigMvPar filtrado
    this_cCursorCli     = "cursor_4c_Cli"       && SigCdCli (RClis - nome do cliente)

    *-- Estado interno
    this_lProcessado    = .F.   && .T. apos PrepararDados() executado com sucesso

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO e cursores auxiliares
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            IF DODEFAULT()
                IF THIS.InicializarCursores()
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SIGREGDPBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarCursores - Cria cursor local de dados e carrega auxiliares
    *--------------------------------------------------------------------------
    PROCEDURE InicializarCursores()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            *-- Criar cursor local equivalente ao TmpNFis do legado
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF
            CREATE CURSOR cursor_4c_Dados ( ;
                flag     L, ;
                datas    D NULL, ;
                nfis     C(6), ;
                valor    N(12,2), ;
                conta    C(40), ;
                digito   N(1), ;
                vecto    C(12), ;
                totnotas N(12,2), ;
                emps     C(3), ;
                dopes    C(20), ;
                numes    N(6), ;
                obs      M NULL, ;
                parcs    N(2) ;
            )

            *-- Em modo validacao UI, nao executar SQLs (sem conexao)
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lSucesso = .T.
            ELSE
                *-- Carregar SigOpFp (formas de pagamento com flags de impressao)
                loc_cSQL = "SELECT fpags, impdups, impbols, impnotas FROM SigOpFp"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorOpFp)
                IF loc_nResult > 0
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao carregar formas de pagamento (SigOpFp)"
                ENDIF

                *-- Carregar SigCdPam (mascara de numeros) - nao critico para funcionamento
                loc_cSQL = "SELECT mascnums FROM SigCdPam"
                SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorPam)
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SIGREGDPBO.InicializarCursores")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Processa NFs conforme filtros (equivalente Processar.Click)
    * Popula cursor_4c_Dados com os registros filtrados e validados
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_cSQL2, loc_nResult
        LOCAL loc_cFPags, loc_cCliFors, loc_cNfis, loc_cConta, loc_cVecto
        LOCAL loc_nValos, loc_dDatas, loc_nParcs, loc_nNumes, loc_nTotNot
        LOCAL loc_cEmps, loc_cDopes, loc_cObs, loc_dVencs
        LOCAL loc_nImpDups, loc_nImpBols, loc_nImpNot, loc_nConta
        loc_lSucesso = .F.

        TRY
            *-- ZAP cursor de dados e resetar estado
            IF USED(THIS.this_cCursorDados)
                ZAP IN (THIS.this_cCursorDados)
            ENDIF
            THIS.this_lProcessado = .F.

            *-- Consultar SigMvNfi JOIN SigMvPar com filtros informados
            loc_cSQL = "SELECT a.nfis, a.clifors, a.totnotas, a.emps, a.dopes, a.numes, " + ;
                       "b.fpags, b.parcs, b.valos, b.datas, b.vencs, b.obs " + ;
                       "FROM SigMvNfi a " + ;
                       "INNER JOIN SigMvPar b ON a.empdopnums = b.empdopnums " + ;
                       "WHERE a.nfis BETWEEN " + EscaparSQL(THIS.this_cNFIni) + ;
                       " AND " + EscaparSQL(THIS.this_cNFFim) + ;
                       " AND a.series = " + EscaparSQL(THIS.this_cSerieNf) + ;
                       " ORDER BY a.emps, a.dopes, a.numes, b.fpags, b.parcs"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorNfi)
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao consultar notas fiscais. Verifique a conex" + ;
                                          CHR(227) + "o."
            ELSE
                WAIT WINDOW "Aguarde!!! Selecionando Notas Fiscais..." NOWAIT

                *-- Iterar sobre registros e popular cursor_4c_Dados
                SELECT (THIS.this_cCursorNfi)
                SCAN
                    *-- Capturar todos os valores necessarios antes de trocar de area
                    loc_cFPags   = ALLTRIM(cursor_4c_NfiFiltro.fpags)
                    loc_cCliFors = ALLTRIM(cursor_4c_NfiFiltro.clifors)
                    loc_cNfis    = ALLTRIM(cursor_4c_NfiFiltro.nfis)
                    loc_nValos   = cursor_4c_NfiFiltro.valos
                    loc_dDatas   = TTOD(NVL(cursor_4c_NfiFiltro.datas, CTOT("")))
                    loc_nParcs   = cursor_4c_NfiFiltro.parcs
                    loc_cEmps    = ALLTRIM(cursor_4c_NfiFiltro.emps)
                    loc_cDopes   = ALLTRIM(cursor_4c_NfiFiltro.dopes)
                    loc_nNumes   = cursor_4c_NfiFiltro.numes
                    loc_cObs     = NVL(cursor_4c_NfiFiltro.obs, "")
                    loc_nTotNot  = cursor_4c_NfiFiltro.totnotas
                    loc_dVencs   = cursor_4c_NfiFiltro.vencs

                    *-- Verificar forma de pagamento habilitada em SigOpFp
                    SELECT (THIS.this_cCursorOpFp)
                    LOCATE FOR ALLTRIM(fpags) = loc_cFPags

                    IF !FOUND()
                        SELECT (THIS.this_cCursorNfi)
                        LOOP
                    ENDIF

                    *-- Capturar flags de impressao da forma de pagamento
                    loc_nImpDups = cursor_4c_OpFp.impdups
                    loc_nImpBols = cursor_4c_OpFp.impbols
                    loc_nImpNot  = cursor_4c_OpFp.impnotas

                    *-- Filtrar por tipo de selecao (Duplicatas ou Boletos)
                    IF ((THIS.this_nSelecao = 1) AND (loc_nImpDups <> 1)) OR ;
                       ((THIS.this_nSelecao = 2) AND (loc_nImpBols <> 1))
                        SELECT (THIS.this_cCursorNfi)
                        LOOP
                    ENDIF

                    *-- Numero da parcela (digito)
                    loc_nConta = loc_nParcs

                    *-- Lookup de nome do cliente em SigCdCli
                    loc_cConta = loc_cCliFors
                    loc_cSQL2 = "SELECT rclis FROM SigCdCli WHERE iclis = " + ;
                                EscaparSQL(loc_cCliFors)
                    IF SQLEXEC(gnConnHandle, loc_cSQL2, THIS.this_cCursorCli) > 0
                        SELECT (THIS.this_cCursorCli)
                        IF !EOF()
                            loc_cConta = loc_cCliFors + " " + ALLTRIM(cursor_4c_Cli.rclis)
                        ENDIF
                        USE IN (THIS.this_cCursorCli)
                    ENDIF

                    *-- Calcular campo Vecto: data de vencimento ou forma de pagamento
                    IF loc_nImpNot = 1
                        loc_cVecto = DTOC(TTOD(NVL(loc_dVencs, CTOT(""))))
                    ELSE
                        loc_cVecto = loc_cFPags
                    ENDIF

                    *-- Inserir registro processado no cursor de dados
                    SELECT (THIS.this_cCursorDados)
                    INSERT INTO cursor_4c_Dados ( ;
                        flag, nfis, valor, datas, conta, digito, parcs, ;
                        vecto, totnotas, obs, emps, dopes, numes) ;
                    VALUES ( ;
                        .T., ;
                        loc_cNfis, ;
                        loc_nValos, ;
                        loc_dDatas, ;
                        loc_cConta, ;
                        loc_nConta, ;
                        loc_nParcs, ;
                        loc_cVecto, ;
                        loc_nTotNot, ;
                        loc_cObs, ;
                        loc_cEmps, ;
                        loc_cDopes, ;
                        loc_nNumes ;
                    )

                    SELECT (THIS.this_cCursorNfi)
                ENDSCAN

                WAIT CLEAR

                *-- Verificar resultado e alertar se vazio
                SELECT (THIS.this_cCursorDados)
                GO TOP
                IF EOF()
                    IF THIS.this_nSelecao = 1
                        MsgAviso("Nenhuma Duplicata Selecionada...")
                    ELSE
                        MsgAviso("Nenhum Boleto Banc" + CHR(225) + "rio Selecionado...")
                    ENDIF
                ENDIF

                THIS.this_lProcessado = .T.
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SIGREGDPBO.PrepararDados")
            WAIT CLEAR
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Emite duplicatas ou boletos para os registros selecionados
    * Equivalente ao procedure "impressao" do legado
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_nQt, loc_cChave
        loc_lSucesso = .F.

        TRY
            IF !THIS.this_lProcessado
                MsgAviso("Execute o Processamento antes de Imprimir.")
            ELSE
                IF THIS.this_nSelecao = 1
                    *-- Emissao de Duplicatas via funcao legada SigIpDup
                    =SigIpDup("", THIS.this_cSerieNf, .T., .NULL.)
                    loc_lSucesso = .T.
                ELSE
                    *-- Emissao de Boletos Bancarios
                    *-- Montar cursor cabecalho agrupado por NF
                    IF USED("cursor_4c_MvCab")
                        USE IN cursor_4c_MvCab
                    ENDIF
                    SELECT emps, dopes, numes, parcs ;
                        FROM (THIS.this_cCursorDados) ;
                        WHERE flag ;
                        GROUP BY emps, dopes, numes, parcs ;
                        INTO CURSOR cursor_4c_MvCab READWRITE

                    *-- Verificar configuracao de boleto bancario em SigCnFBl
                    loc_cSQL = "SELECT COUNT(*) AS qt FROM SigCnFBl WHERE fpags <> ' '"
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfgBol")
                    IF loc_nResult < 1
                        MsgErro("Favor Reinicializar o Processo!!!", ;
                                "Falha na Conex" + CHR(227) + "o (SigCnFBl)")
                    ELSE
                        SELECT cursor_4c_CfgBol
                        loc_nQt = NVL(qt, 0)
                        USE IN cursor_4c_CfgBol

                        IF loc_nQt = 0
                            *-- Sem boleto bancario configurado: imprimir simples
                            DO FORM SigPrIbl WITH "", .NULL.
                        ELSE
                            *-- Com boleto bancario: imprimir por NF individualmente
                            SELECT cursor_4c_MvCab
                            SCAN
                                loc_cChave = cursor_4c_MvCab.emps + ;
                                             cursor_4c_MvCab.dopes + ;
                                             STR(cursor_4c_MvCab.numes, 6)
                                DO FORM SigPrIbb WITH loc_cChave, .NULL.
                            ENDSCAN
                        ENDIF

                        loc_lSucesso = .T.
                    ENDIF

                    IF USED("cursor_4c_MvCab")
                        USE IN cursor_4c_MvCab
                    ENDIF
                ENDIF

                *-- Reposicionar cursor de dados no final (comportamento original)
                IF USED(THIS.this_cCursorDados)
                    SELECT (THIS.this_cCursorDados)
                    GO BOTTOM
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SIGREGDPBO.Imprimir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SelecionarTodos - Marca Flag=.T. em todos os registros do cursor de dados
    * Equivalente ao botao SelTudo do legado
    *--------------------------------------------------------------------------
    PROCEDURE SelecionarTodos()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorDados)
                UPDATE (THIS.this_cCursorDados) SET flag = .T.
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SIGREGDPBO.SelecionarTodos")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarTodos - Marca Flag=.F. em todos os registros do cursor de dados
    * Equivalente ao botao apaga do legado
    *--------------------------------------------------------------------------
    PROCEDURE DesmarcarTodos()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorDados)
                UPDATE (THIS.this_cCursorDados) SET flag = .F.
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SIGREGDPBO.DesmarcarTodos")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe relatorio em modo impressao (original: Visualiza oculto)
    * No legado btnReport.Visualiza.Visible = .F. - nao havia preview separado.
    * Delega para Imprimir() para compatibilidade com qualquer chamada residual.
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        RETURN THIS.Imprimir()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Stub (relatorio nao possui chave primaria)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha todos os cursores abertos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        IF USED(THIS.this_cCursorOpFp)
            USE IN (THIS.this_cCursorOpFp)
        ENDIF
        IF USED(THIS.this_cCursorPam)
            USE IN (THIS.this_cCursorPam)
        ENDIF
        IF USED(THIS.this_cCursorNfi)
            USE IN (THIS.this_cCursorNfi)
        ENDIF
        IF USED(THIS.this_cCursorCli)
            USE IN (THIS.this_cCursorCli)
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

