# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODIGOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NEXISTE' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODIGOS

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
  ControlSource = "crSigCdCfo.codigos"
  ControlSource = "crSigCdCfo.Ndigitos"
  ControlSource = "crSigCdCfo.descricaos"
  ControlSource = "crSigCdCfo.Desc2s"
  ControlSource = "crSigCdCfo.InclIPIs"
  ControlSource = "crSigCdCfo.tipos"
  ControlSource = "crSigCdCfo.AliqII"
  ControlSource = "crSigCdCfo.AliqISSQN"
  ControlSource = "crSigCdCfo.IcmsIncs"
  ControlSource = "crSigCdCfo.InclIcms"
  ControlSource = "crSigCdCfo.IpiNCreds"
  ControlSource = "crSigCdCfo.Transps"
  ControlSource = "crSigCdCfo.aliqipis"
  ControlSource = "crSigCdCfo.icmsdscs"
  ControlSource = "crSigCdCfo.cfost60s"
  ControlSource = "crSigCdCfo.pbcipis"
  ControlSource = "crSigCdCfo.Ipi_Icms"
  ControlSource = "crSigCdCfo.cgergia1s"
  ControlSource = "crSigCdCfo.ISSQNL"
  ControlSource = "crSigCdCfo.COFCST"
  ControlSource = "crSigCdCfo.PISCST"
  ControlSource = "crSigCdCfo.IPICST"
  ControlSource = "crSigCdCfo.aliqivcs"
  ControlSource = "crSigCdCfo.pbcsts"
  ControlSource = "crSigCdCfo.coddests"
  ControlSource = "crSigCdCfo.cfosts"
  ControlSource = "crSigCdCfo.sittribs"
  ControlSource = "crSigCdCfo.AliqPIS"
  ControlSource = "crSigCdCfo.AliqCOFINS"
  ControlSource = "crSigCdCfo.IPIEnq"
  ControlSource = "crSigCdCfo.situas"
  ControlSource = "crSigCdCfo.Frticms"
  ControlSource = "crSigCdCfo.SegIcms"
  ControlSource = "crSigCdCfo.DesIcms"
  ControlSource = "crSigCdCfo.FrtIpis"
  ControlSource = "crSigCdCfo.SegIpis"
  ControlSource = "crSigCdCfo.DesIpis"
  ControlSource = "crSigCdCfo.IncIcmNFs"
  ControlSource = "crSigCdCfo.CTISSQN"
  ControlSource = "crSigCdCfo.RetTribs"
  ControlSource = "crSigCdCfo.SomaIcmFrete"
  ControlSource = "crSigCdCfo.MotDeson"
  ControlSource = "crSigCdCfo.contipcs"
  ControlSource = "crSigCdCfo.contipds"
  ControlSource = "crSigCdCfo.PonteDescs"
  ControlSource = "crSigCdCfo.agrupas"
  ControlSource = "crSigCdCfo.zeradas"
  ControlSource = "crSigCdCfo.dtintfis"
  ControlSource = "crSigCdCfo.utilvars"
  ControlSource = "crSigCdCfo.contvcds"
  ControlSource = "crSigCdCfo.contvccs"
  ControlSource = "crSigCdCfo.conticds"
  ControlSource = "crSigCdCfo.contfrt"
  ControlSource = "crSigCdCfo.contseg"
  ControlSource = "crSigCdCfo.contda"
  ControlSource = "crSigCdCfo.conticcs"
  ControlSource = "crSigCdCfo.intvlrcont"
  ControlSource = "crSigCdCfo.intvlricms"
  ControlSource = "crSigCdCfo.intvlripi"
  ControlSource = "crSigCdCfo.IndMov"
  ControlSource = "crSigCdCfo.IndPagto"
Select CrSigCdCfo
select CrSigCdCfo
	Select crSigCdCfo
Select crSigCdCfo
Select CrSigCdCfo
Select CrSigCdCfo
Select CrSigCdCfo
Select CrSigCdCfo

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formcfo.prg) - TRECHOS RELEVANTES PARA PASS SQL (4406 linhas total):

*-- Linhas 374 a 392:
374:             .HighlightBackColor = RGB(255, 255, 255)
375:             .HighlightForeColor = RGB(15, 41, 104)
376:             .HighlightStyle     = 2
377:             .DeleteMark         = .F.
378:             .RecordMark         = .F.
379:             .RowHeight          = 16
380:             .ScrollBars         = 2
381:             .GridLines          = 3
382:             .ReadOnly           = .T.
383:             .Visible            = .T.
384:         ENDWITH
385: 
386:         *-- BINDEVENT para botoes (PUBLIC para funcionar com BINDEVENT)
387:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
388:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
389:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
390:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
391:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
392:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")

*-- Linhas 523 a 546:
523:                 loc_oGrid.ColumnCount  = 2
524: 
525:                 *-- Configurar colunas APOS RecordSource (redefine headers resetados pelo auto-bind)
526:                 loc_oGrid.Column1.ControlSource    = "cursor_4c_Dados.codigos"
527:                 loc_oGrid.Column1.Width            = 80
528:                 loc_oGrid.Column1.Header1.Caption  = "C" + CHR(243) + "digo"
529:                 loc_oGrid.Column1.DynamicForeColor = "IIF(cursor_4c_Dados.situas=1,RGB(0,0,0),RGB(200,0,0))"
530: 
531:                 loc_oGrid.Column2.ControlSource    = "cursor_4c_Dados.descricaos"
532:                 loc_oGrid.Column2.Width            = 400
533:                 loc_oGrid.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
534:                 loc_oGrid.Column2.DynamicForeColor = "IIF(cursor_4c_Dados.situas=1,RGB(0,0,0),RGB(200,0,0))"
535: 
536:                 THIS.FormatarGridLista(loc_oGrid)
537:                 loc_lResultado = .T.
538:             ENDIF
539:         CATCH TO loc_oErro
540:             MostrarErro(loc_oErro, "Formcfo.CarregarLista")
541:         ENDTRY
542: 
543:         RETURN loc_lResultado
544:     ENDPROC
545: 
546:     *--------------------------------------------------------------------------

*-- Linhas 634 a 652:
634:         loc_cCodigo = ""
635: 
636:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
637:             SELECT cursor_4c_Dados
638:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
639:         ENDIF
640: 
641:         IF EMPTY(loc_cCodigo)
642:             MsgAviso("Selecione um registro na lista.", "Visualizar")
643:             RETURN
644:         ENDIF
645: 
646:         TRY
647:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
648:                 THIS.this_cModoAtual = "VISUALIZAR"
649:                 THIS.BOParaForm()
650:                 THIS.HabilitarCampos(.F.)
651:                 THIS.AjustarBotoesPorModo()
652:                 THIS.pgf_4c_Paginas.ActivePage = 2

*-- Linhas 666 a 684:
666:         loc_cCodigo = ""
667: 
668:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
669:             SELECT cursor_4c_Dados
670:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
671:         ENDIF
672: 
673:         IF EMPTY(loc_cCodigo)
674:             MsgAviso("Selecione um registro na lista.", "Alterar")
675:             RETURN
676:         ENDIF
677: 
678:         TRY
679:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
680:                 THIS.this_oBusinessObject.EditarRegistro()
681:                 THIS.this_cModoAtual = "ALTERAR"
682:                 THIS.BOParaForm()
683:                 THIS.HabilitarCampos(.T.)
684:                 THIS.AjustarBotoesPorModo()

*-- Linhas 701 a 719:
701:         loc_lConfirma = .F.
702: 
703:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
704:             SELECT cursor_4c_Dados
705:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
706:         ENDIF
707: 
708:         IF EMPTY(loc_cCodigo)
709:             MsgAviso("Selecione um registro na lista.", "Excluir")
710:             RETURN
711:         ENDIF
712: 
713:         loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o do CFOP '" + ;
714:             loc_cCodigo + "'?", "Excluir")
715: 
716:         IF loc_lConfirma
717:             TRY
718:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
719:                     IF THIS.this_oBusinessObject.Excluir()

*-- Linhas 746 a 764:
746:                     loc_oBusca.Show()
747:                 ENDIF
748:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCFO")
749:                     SELECT cursor_4c_BuscaCFO
750:                     GO TOP
751:                 ENDIF
752:                 loc_oBusca.Release()
753:                 loc_oBusca = .NULL.
754:             ENDIF
755:         CATCH TO loc_oErro
756:             MostrarErro(loc_oErro, "Formcfo.BtnBuscarClick")
757:         ENDTRY
758: 
759:         IF USED("cursor_4c_BuscaCFO")
760:             USE IN cursor_4c_BuscaCFO
761:         ENDIF
762: 
763:         THIS.CarregarLista()
764:     ENDPROC

*-- Linhas 778 a 833:
778:         loc_cCodigo = ""
779: 
780:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
781:             SELECT cursor_4c_Dados
782:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
783:         ENDIF
784: 
785:         IF EMPTY(loc_cCodigo)
786:             MsgAviso("Selecione um registro para exportar.", "Exporta XML")
787:             RETURN
788:         ENDIF
789: 
790:         TRY
791:             DO FORM SigOpXml WITH THIS, loc_cCodigo, "E", "CFOP", 10
792:             THIS.CarregarLista()
793:             IF USED("cursor_4c_Dados")
794:                 SELECT cursor_4c_Dados
795:                 LOCATE FOR ALLTRIM(codigos) = loc_cCodigo
796:             ENDIF
797:         CATCH TO loc_oErro
798:             MostrarErro(loc_oErro, "Formcfo.BtnExpXMLClick")
799:         ENDTRY
800:     ENDPROC
801: 
802:     *--------------------------------------------------------------------------
803:     * BtnImpXMLClick - Importa CFOP de arquivo XML (via SigOpXml)
804:     *--------------------------------------------------------------------------
805:     PROCEDURE BtnImpXMLClick()
806:         LOCAL loc_cCodigo
807:         loc_cCodigo = ""
808: 
809:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
810:             SELECT cursor_4c_Dados
811:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
812:         ENDIF
813: 
814:         TRY
815:             DO FORM SigOpXml WITH THIS, loc_cCodigo, "I", "CFOP", 10
816:             THIS.CarregarLista()
817:             IF !EMPTY(loc_cCodigo) AND USED("cursor_4c_Dados")
818:                 SELECT cursor_4c_Dados
819:                 LOCATE FOR ALLTRIM(codigos) = loc_cCodigo
820:             ENDIF
821:         CATCH TO loc_oErro
822:             MostrarErro(loc_oErro, "Formcfo.BtnImpXMLClick")
823:         ENDTRY
824:     ENDPROC
825: 
826:     *--------------------------------------------------------------------------
827:     * GrdListaDblClick - DblClick na lista abre visualizacao do registro
828:     *--------------------------------------------------------------------------
829:     PROCEDURE GrdListaDblClick()
830:         THIS.BtnVisualizarClick()
831:     ENDPROC
832: 
833:     *--------------------------------------------------------------------------

*-- Linhas 3572 a 3653:
3572:         TRY
3573:             loc_cConta = ALLTRIM(NVL(loc_oPag2.txt_4c_ContFrt.Value, ""))
3574:             IF NOT EMPTY(loc_cConta)
3575:                 loc_nRows = SQLEXEC(gnConnHandle, ;
3576:                     "SELECT COUNT(*) AS nExiste FROM SigCdCli WHERE iClis = " + EscaparSQL(loc_cConta), ;
3577:                     "cursor_4c_ContFrt")
3578:                 IF loc_nRows > 0 AND cursor_4c_ContFrt.nExiste = 0
3579:                     MsgAlerta("Conta n" + CHR(227) + "o cadastrada, verifique!")
3580:                     loc_oPag2.txt_4c_ContFrt.SetFocus()
3581:                 ENDIF
3582:                 USE IN SELECT("cursor_4c_ContFrt")
3583:             ENDIF
3584:         CATCH TO loc_oErro
3585:             MostrarErro(loc_oErro, "Formcfo.ValidarContFrt")
3586:         ENDTRY
3587:     ENDPROC
3588: 
3589:     *--------------------------------------------------------------------------
3590:     * ValidarContSeg - Valida Conta de Seguro contra SigCdCli (LostFocus)
3591:     *--------------------------------------------------------------------------
3592:     PROCEDURE ValidarContSeg()
3593:         LOCAL loc_oPag2, loc_cConta, loc_nRows
3594:         IF gb_4c_ValidandoUI
3595:             RETURN
3596:         ENDIF
3597:         loc_oPag2  = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
3598:         loc_cConta = ""
3599:         loc_nRows  = 0
3600:         TRY
3601:             loc_cConta = ALLTRIM(NVL(loc_oPag2.txt_4c_ContSeg.Value, ""))
3602:             IF NOT EMPTY(loc_cConta)
3603:                 loc_nRows = SQLEXEC(gnConnHandle, ;
3604:                     "SELECT COUNT(*) AS nExiste FROM SigCdCli WHERE iClis = " + EscaparSQL(loc_cConta), ;
3605:                     "cursor_4c_ContSeg")
3606:                 IF loc_nRows > 0 AND cursor_4c_ContSeg.nExiste = 0
3607:                     MsgAlerta("Conta n" + CHR(227) + "o cadastrada, verifique!")
3608:                     loc_oPag2.txt_4c_ContSeg.SetFocus()
3609:                 ENDIF
3610:                 USE IN SELECT("cursor_4c_ContSeg")
3611:             ENDIF
3612:         CATCH TO loc_oErro
3613:             MostrarErro(loc_oErro, "Formcfo.ValidarContSeg")
3614:         ENDTRY
3615:     ENDPROC
3616: 
3617:     *--------------------------------------------------------------------------
3618:     * ValidarContDa - Valida Conta de Despesas contra SigCdCli (LostFocus)
3619:     *--------------------------------------------------------------------------
3620:     PROCEDURE ValidarContDa()
3621:         LOCAL loc_oPag2, loc_cConta, loc_nRows
3622:         IF gb_4c_ValidandoUI
3623:             RETURN
3624:         ENDIF
3625:         loc_oPag2  = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
3626:         loc_cConta = ""
3627:         loc_nRows  = 0
3628:         TRY
3629:             loc_cConta = ALLTRIM(NVL(loc_oPag2.txt_4c_ContDa.Value, ""))
3630:             IF NOT EMPTY(loc_cConta)
3631:                 loc_nRows = SQLEXEC(gnConnHandle, ;
3632:                     "SELECT COUNT(*) AS nExiste FROM SigCdCli WHERE iClis = " + EscaparSQL(loc_cConta), ;
3633:                     "cursor_4c_ContDa")
3634:                 IF loc_nRows > 0 AND cursor_4c_ContDa.nExiste = 0
3635:                     MsgAlerta("Conta n" + CHR(227) + "o cadastrada, verifique!")
3636:                     loc_oPag2.txt_4c_ContDa.SetFocus()
3637:                 ENDIF
3638:                 USE IN SELECT("cursor_4c_ContDa")
3639:             ENDIF
3640:         CATCH TO loc_oErro
3641:             MostrarErro(loc_oErro, "Formcfo.ValidarContDa")
3642:         ENDTRY
3643:     ENDPROC
3644: 
3645:     *--------------------------------------------------------------------------
3646:     * BtnSalvarClick - Confirma o registro (Incluir ou Alterar)
3647:     *--------------------------------------------------------------------------
3648:     PROCEDURE BtnSalvarClick()
3649:         LOCAL loc_lResultado, loc_oPag1
3650:         loc_lResultado = .F.
3651:         loc_oPag1      = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
3652: 
3653:         *-- Validacoes basicas ANTES do TRY

*-- Linhas 3713 a 3731:
3713:                     loc_oBusca.Show()
3714:                 ENDIF
3715:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCfoST60")
3716:                     SELECT cursor_4c_BuscaCfoST60
3717:                     loc_oPag1.txt_4c_CfoST60.Value = ALLTRIM(cursor_4c_BuscaCfoST60.codigos)
3718:                 ENDIF
3719:                 loc_oBusca.Release()
3720:                 loc_oBusca = .NULL.
3721:             ENDIF
3722:         CATCH TO loc_oErro
3723:             MostrarErro(loc_oErro, "Formcfo.ValidarCfoST60")
3724:         ENDTRY
3725: 
3726:         IF USED("cursor_4c_BuscaCfoST60")
3727:             USE IN cursor_4c_BuscaCfoST60
3728:         ENDIF
3729:     ENDPROC
3730: 
3731:     *--------------------------------------------------------------------------

*-- Linhas 3754 a 3772:
3754:                     loc_oBusca.Show()
3755:                 ENDIF
3756:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCfoST")
3757:                     SELECT cursor_4c_BuscaCfoST
3758:                     loc_oPag1.txt_4c_CfoST.Value = ALLTRIM(cursor_4c_BuscaCfoST.codigos)
3759:                 ENDIF
3760:                 loc_oBusca.Release()
3761:                 loc_oBusca = .NULL.
3762:             ENDIF
3763:         CATCH TO loc_oErro
3764:             MostrarErro(loc_oErro, "Formcfo.ValidarCfoST")
3765:         ENDTRY
3766: 
3767:         IF USED("cursor_4c_BuscaCfoST")
3768:             USE IN cursor_4c_BuscaCfoST
3769:         ENDIF
3770:     ENDPROC
3771: 
3772:     *--------------------------------------------------------------------------

*-- Linhas 3795 a 3813:
3795:                     loc_oBusca.Show()
3796:                 ENDIF
3797:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCfdest")
3798:                     SELECT cursor_4c_BuscaCfdest
3799:                     loc_oPag1.txt_4c_Cfdest.Value = ALLTRIM(cursor_4c_BuscaCfdest.codigos)
3800:                 ENDIF
3801:                 loc_oBusca.Release()
3802:                 loc_oBusca = .NULL.
3803:             ENDIF
3804:         CATCH TO loc_oErro
3805:             MostrarErro(loc_oErro, "Formcfo.ValidarCfdest")
3806:         ENDTRY
3807: 
3808:         IF USED("cursor_4c_BuscaCfdest")
3809:             USE IN cursor_4c_BuscaCfdest
3810:         ENDIF
3811:     ENDPROC
3812: 
3813:     *--------------------------------------------------------------------------

*-- Linhas 3836 a 3854:
3836:                     loc_oBusca.Show()
3837:                 ENDIF
3838:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIcm")
3839:                     SELECT cursor_4c_BuscaIcm
3840:                     loc_oPag1.txt_4c_Sittricm.Value = ALLTRIM(cursor_4c_BuscaIcm.codigos)
3841:                 ENDIF
3842:                 loc_oBusca.Release()
3843:                 loc_oBusca = .NULL.
3844:             ENDIF
3845:         CATCH TO loc_oErro
3846:             MostrarErro(loc_oErro, "Formcfo.ValidarSittricm")
3847:         ENDTRY
3848: 
3849:         IF USED("cursor_4c_BuscaIcm")
3850:             USE IN cursor_4c_BuscaIcm
3851:         ENDIF
3852:     ENDPROC
3853: 
3854:     *--------------------------------------------------------------------------


### BO (C:\4c\projeto\app\classes\cfoBO.prg):
*==============================================================================
* cfoBO.prg - Business Object para CFOP (C" + CHR(243) + "digo Fiscal de Opera" + CHR(231) + CHR(245) + "es)
* Data: 2026-04-11
* Tabela: SIGCDCFO | PK: codigos
*==============================================================================

DEFINE CLASS cfoBO AS BusinessBase

    *-- === DADOS PRINCIPAIS ===
    this_cCodigos       = ""   && codigos    CHAR(10)      - C" + CHR(243) + "digo CFOP (PK)
    this_cDescricaos    = ""   && descricaos CHAR(60)      - Descri" + CHR(231) + CHR(227) + "o Nota Fiscal
    this_cDesc2s        = ""   && desc2s     CHAR(60)      - Descri" + CHR(231) + CHR(227) + "o Consulta
    this_nSituas        = 1    && situas     NUMERIC(1,0)  - Situa" + CHR(231) + CHR(227) + "o (1=Ativo, 0=Inativo)
    this_nTipos         = 0    && tipos      NUMERIC(1,0)  - Tipo (0=Compras,1=Dev.Comp.,2=Vendas,3=Dev.Vend.,4=Serv.)
    this_cOperacaos     = ""   && operacaos  CHAR(1)       - Opera" + CHR(231) + CHR(227) + "o (E=Entrada, S=Sa" + CHR(237) + "da)
    this_nNdigitos      = 0    && ndigitos   NUMERIC(2,0)  - D" + CHR(237) + "gitos Para NF

    *-- === ICMS ===
    this_cIcms          = ""   && icms       CHAR(1)       - ICMS (regime)
    this_nInclicms      = 0    && inclicms   NUMERIC(1,0)  - Incluir ICMS (0=N" + CHR(227) + "o,1=Sim,2=Base,3=Pre" + CHR(231) + "o)
    this_nIcmsincs      = 0    && icmsincs   NUMERIC(1,0)  - ICMS Incluso no Pre" + CHR(231) + "o (Sim/N" + CHR(227) + "o)
    this_nIcmsdscs      = 0    && icmsdscs   NUMERIC(1,0)  - ICMS Sobre Desconto
    this_cSittribs      = ""   && sittribs   CHAR(3)       - Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS (lookup SigCdIcm)
    this_nPbcsts        = 0    && pbcsts     NUMERIC(5,2)  - % Base de C" + CHR(225) + "lculo ST
    this_cSubtribs      = ""   && subtribs   CHAR(1)       - Substitui" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria (Sim/N" + CHR(227) + "o)
    this_cCfosts        = ""   && cfosts     CHAR(10)      - CFOP Substitui" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria
    this_cCoddests      = ""   && coddests   CHAR(10)      - CFOP Destino
    this_cCfost60s      = ""   && cfost60s   CHAR(10)      - CFOP ST60
    this_nAliqivcs      = 0    && aliqivcs   NUMERIC(4,2)  - Al" + CHR(237) + "quota Venda Consumidor
    this_nDesicms       = 0    && desicms    NUMERIC(1,0)  - Desp. Acess. ICMS (Sim/N" + CHR(227) + "o)
    this_nFrticms       = 0    && frticms    NUMERIC(1,0)  - Frete ICMS (Sim/N" + CHR(227) + "o)
    this_nSegicms       = 0    && segicms    NUMERIC(1,0)  - Seguro ICMS (Sim/N" + CHR(227) + "o)
    this_nIncicmnfs     = 0    && incicmnfs  NUMERIC(1,0)  - Incluir ICMS no Total NF (Sim/N" + CHR(227) + "o)
    this_nSomaicmfrete  = 0    && somaicmfrete NUMERIC(1,0) - Soma ICMS Frete no Total NF
    this_cCgergia1s     = ""   && cgergia1s  CHAR(1)       - Destaca ICMS na Nota Fiscal (S/N)
    this_cUnitimps      = ""   && unitimps   CHAR(1)       - Inibe Valor Unit" + CHR(225) + "rio NF Importa" + CHR(231) + CHR(227) + "o
    this_cMotdeson      = ""   && motdeson   CHAR(2)       - Motivo Desonera" + CHR(231) + CHR(227) + "o ICMS

    *-- === IPI ===
    this_cIpis          = ""   && ipis       CHAR(1)       - IPI
    this_nAliqipis      = 0    && aliqipis   NUMERIC(4,2)  - Al" + CHR(237) + "quota IPI
    this_nInclipis      = 0    && inclipis   NUMERIC(1,0)  - Incluir IPI na Base
    this_cIpiIcms       = ""   && ipi_icms   CHAR(1)       - IPI Importa" + CHR(231) + CHR(227) + "o
    this_cBcipis        = ""   && bcipis     CHAR(1)       - Base de C" + CHR(225) + "lculo IPI
    this_nPbcipis       = 0    && pbcipis    NUMERIC(5,2)  - % Base de C" + CHR(225) + "lculo IPI
    this_nIpincreds     = 0    && ipincreds  NUMERIC(1,0)  - N" + CHR(227) + "o Creditado
    this_cAcresipis     = ""   && acresipis  CHAR(1)       - Acres/Desc na Base IPI
    this_cIpiimpors     = ""   && ipiimpors  CHAR(1)       - Retira IPI do $
    this_cIpiom2s       = ""   && ipiom2s    CHAR(1)       - Calcula IPI Import. Origem Merc.=2
    this_nDesipis       = 0    && desipis    NUMERIC(1,0)  - Desp. Acess. IPI (Sim/N" + CHR(227) + "o)
    this_nFrtipis       = 0    && frtipis    NUMERIC(1,0)  - Frete IPI (Sim/N" + CHR(227) + "o)
    this_nSegipis       = 0    && segipis    NUMERIC(1,0)  - Seguro IPI (Sim/N" + CHR(227) + "o)

    *-- === ESPECIFICACOES NF-e ===
    this_cIpicst        = ""   && ipicst     CHAR(2)       - C" + CHR(243) + "digo IPI Sit. Tribut" + CHR(225) + "ria
    this_cPiscst        = ""   && piscst     CHAR(2)       - C" + CHR(243) + "digo PIS Sit. Tribut" + CHR(225) + "ria
    this_cCofcst        = ""   && cofcst     CHAR(2)       - C" + CHR(243) + "digo COFINS Sit. Tribut" + CHR(225) + "ria
    this_cIssqnl        = ""   && issqnl     CHAR(5)       - C" + CHR(243) + "digo ISSQN Lista Serv.
    this_nAliqpis       = 0    && aliqpis    NUMERIC(5,2)  - Al" + CHR(237) + "quota do PIS
    this_nAliqcofins    = 0    && aliqcofins NUMERIC(5,2)  - Al" + CHR(237) + "quota do COFINS
    this_nAliqissqn     = 0    && aliqissqn  NUMERIC(5,2)  - Al" + CHR(237) + "quota do ISSQN
    this_nCtissqn       = 0    && ctissqn    NUMERIC(1,0)  - C" + CHR(243) + "d. Trib. ISSQN (0=Normal,1=Retida,2=Substituta,3=Isenta)
    this_nRettribs      = 0    && rettribs   NUMERIC(1,0)  - Informa Reten" + CHR(231) + CHR(227) + "o de Trib. (Sim/N" + CHR(227) + "o)
    this_nAliqii        = 0    && aliqii     NUMERIC(5,2)  - Al" + CHR(237) + "quota do II
    this_cIpienq        = ""   && ipienq     CHAR(3)       - C" + CHR(243) + "digo Enquadramento IPI
    this_cContribs      = ""   && contribs   CHAR(1)       - Contribuinte

    *-- === INTEGRACAO CONTABIL ===
    this_cContvcds      = ""   && contvcds   CHAR(9)       - Conta Valor Cont" + CHR(225) + "bil DB
    this_cContvccs      = ""   && contvccs   CHAR(9)       - Conta Valor Cont" + CHR(225) + "bil CR
    this_cConticds      = ""   && conticds   CHAR(9)       - Conta ICMS DB
    this_cConticcs      = ""   && conticcs   CHAR(9)       - Conta ICMS CR
    this_cContipds      = ""   && contipds   CHAR(9)       - Conta IPI DB
    this_cContipcs      = ""   && contipcs   CHAR(9)       - Conta IPI CR
    this_cContfrt       = ""   && contfrt    CHAR(9)       - Conta de Frete
    this_cContseg       = ""   && contseg    CHAR(9)       - Conta de Seguro
    this_cContda        = ""   && contda     CHAR(9)       - Conta de Despesas
    this_cContconts     = ""   && contconts  CHAR(1)       - Tipo contabiliza" + CHR(231) + CHR(227) + "o (fixa/din" + CHR(226) + "mica)

    *-- === INTEGRACAO FISCAL ===
    this_nPontedescs    = 0    && pontedescs NUMERIC(1,0)  - Descri" + CHR(231) + CHR(227) + "o na Integra" + CHR(231) + CHR(227) + "o (0=N" + CHR(227) + "o,1=CFOP,2=Obs)
    this_nAgrupas       = 0    && agrupas    NUMERIC(1,0)  - Agrupa CFO na Integra" + CHR(231) + CHR(227) + "o (Sim/N" + CHR(227) + "o)
    this_nZeradas       = 0    && zeradas    NUMERIC(1,0)  - Integra" + CHR(231) + CHR(227) + "o Zerada (Sim/N" + CHR(227) + "o)
    this_nDtintfis      = 0    && dtintfis   NUMERIC(1,0)  - Data Lan" + CHR(231) + "amento Cont" + CHR(225) + "bil (0=Integra" + CHR(231) + CHR(227) + "o, 1=NF)
    this_nUtilvars      = 0    && utilvars   NUMERIC(1,0)  - Utilizar Varia" + CHR(231) + CHR(227) + "o CFOP na Integra" + CHR(231) + CHR(227) + "o
    this_nIntvlrcont    = 0    && intvlrcont NUMERIC(1,0)  - Integrar Valor Cont" + CHR(225) + "bil (Sim/N" + CHR(227) + "o)
    this_nIntvlricms    = 0    && intvlricms NUMERIC(1,0)  - Integrar Valores ICMS (Sim/N" + CHR(227) + "o)
    this_nIntvlripi     = 0    && intvlripi  NUMERIC(1,0)  - Integrar Valores IPI (Sim/N" + CHR(227) + "o)
    this_nIndmov        = 0    && indmov     NUMERIC(1,0)  - Movimenta" + CHR(231) + CHR(227) + "o F" + CHR(237) + "sica de Estoque (Sim/N" + CHR(227) + "o)
    this_nIndpagto      = 0    && indpagto   NUMERIC(1,0)  - Indica" + CHR(231) + CHR(227) + "o de Pagamento (Sim/N" + CHR(227) + "o)

    *-- === OUTROS ===
    this_nTransps       = 0    && transps    NUMERIC(1,0)  - CFOP Transporte (Sim/N" + CHR(227) + "o)
    this_nTiporecs      = 0    && tiporecs   NUMERIC(1,0)  - Tipo Recibo
    this_nObspads       = 0    && obspads    NUMERIC(3,0)  - Obs. Padr" + CHR(227) + "o

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SIGCDCFO"
        THIS.this_cCampoChave = "codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                *-- Dados Principais
                THIS.this_cCodigos       = TratarNulo(codigos,      "C")
                THIS.this_cDescricaos    = TratarNulo(descricaos,   "C")
                THIS.this_cDesc2s        = TratarNulo(desc2s,       "C")
                THIS.this_nSituas        = TratarNulo(situas,       "N")
                THIS.this_nTipos         = TratarNulo(tipos,        "N")
                THIS.this_cOperacaos     = TratarNulo(operacaos,    "C")
                THIS.this_nNdigitos      = TratarNulo(ndigitos,     "N")

                *-- ICMS
                THIS.this_cIcms          = TratarNulo(icms,         "C")
                THIS.this_nInclicms      = TratarNulo(inclicms,     "N")
                THIS.this_nIcmsincs      = TratarNulo(icmsincs,     "N")
                THIS.this_nIcmsdscs      = TratarNulo(icmsdscs,     "N")
                THIS.this_cSittribs      = TratarNulo(sittribs,     "C")
                THIS.this_nPbcsts        = TratarNulo(pbcsts,       "N")
                THIS.this_cSubtribs      = TratarNulo(subtribs,     "C")
                THIS.this_cCfosts        = TratarNulo(cfosts,       "C")
                THIS.this_cCoddests      = TratarNulo(coddests,     "C")
                THIS.this_cCfost60s      = TratarNulo(cfost60s,     "C")
                THIS.this_nAliqivcs      = TratarNulo(aliqivcs,     "N")
                THIS.this_nDesicms       = TratarNulo(desicms,      "N")
                THIS.this_nFrticms       = TratarNulo(frticms,      "N")
                THIS.this_nSegicms       = TratarNulo(segicms,      "N")
                THIS.this_nIncicmnfs     = TratarNulo(incicmnfs,    "N")
                THIS.this_nSomaicmfrete  = TratarNulo(somaicmfrete, "N")
                THIS.this_cCgergia1s     = TratarNulo(cgergia1s,    "C")
                THIS.this_cUnitimps      = TratarNulo(unitimps,     "C")
                THIS.this_cMotdeson      = TratarNulo(motdeson,     "C")

                *-- IPI
                THIS.this_cIpis          = TratarNulo(ipis,         "C")
                THIS.this_nAliqipis      = TratarNulo(aliqipis,     "N")
                THIS.this_nInclipis      = TratarNulo(inclipis,     "N")
                THIS.this_cIpiIcms       = TratarNulo(ipi_icms,     "C")
                THIS.this_cBcipis        = TratarNulo(bcipis,       "C")
                THIS.this_nPbcipis       = TratarNulo(pbcipis,      "N")
                THIS.this_nIpincreds     = TratarNulo(ipincreds,    "N")
                THIS.this_cAcresipis     = TratarNulo(acresipis,    "C")
                THIS.this_cIpiimpors     = TratarNulo(ipiimpors,    "C")
                THIS.this_cIpiom2s       = TratarNulo(ipiom2s,      "C")
                THIS.this_nDesipis       = TratarNulo(desipis,      "N")
                THIS.this_nFrtipis       = TratarNulo(frtipis,      "N")
                THIS.this_nSegipis       = TratarNulo(segipis,      "N")

                *-- Especifica" + CHR(231) + CHR(245) + "es NF-e
                THIS.this_cIpicst        = TratarNulo(ipicst,       "C")
                THIS.this_cPiscst        = TratarNulo(piscst,       "C")
                THIS.this_cCofcst        = TratarNulo(cofcst,       "C")
                THIS.this_cIssqnl        = TratarNulo(issqnl,       "C")
                THIS.this_nAliqpis       = TratarNulo(aliqpis,      "N")
                THIS.this_nAliqcofins    = TratarNulo(aliqcofins,   "N")
                THIS.this_nAliqissqn     = TratarNulo(aliqissqn,    "N")
                THIS.this_nCtissqn       = TratarNulo(ctissqn,      "N")
                THIS.this_nRettribs      = TratarNulo(rettribs,     "N")
                THIS.this_nAliqii        = TratarNulo(aliqii,       "N")
                THIS.this_cIpienq        = TratarNulo(ipienq,       "C")
                THIS.this_cContribs      = TratarNulo(contribs,     "C")

                *-- Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil
                THIS.this_cContvcds      = TratarNulo(contvcds,     "C")
                THIS.this_cContvccs      = TratarNulo(contvccs,     "C")
                THIS.this_cConticds      = TratarNulo(conticds,     "C")
                THIS.this_cConticcs      = TratarNulo(conticcs,     "C")
                THIS.this_cContipds      = TratarNulo(contipds,     "C")
                THIS.this_cContipcs      = TratarNulo(contipcs,     "C")
                THIS.this_cContfrt       = TratarNulo(contfrt,      "C")
                THIS.this_cContseg       = TratarNulo(contseg,      "C")
                THIS.this_cContda        = TratarNulo(contda,       "C")
                THIS.this_cContconts     = TratarNulo(contconts,    "C")

                *-- Integra" + CHR(231) + CHR(227) + "o Fiscal
                THIS.this_nPontedescs    = TratarNulo(pontedescs,   "N")
                THIS.this_nAgrupas       = TratarNulo(agrupas,      "N")
                THIS.this_nZeradas       = TratarNulo(zeradas,      "N")
                THIS.this_nDtintfis      = TratarNulo(dtintfis,     "N")
                THIS.this_nUtilvars      = TratarNulo(utilvars,     "N")
                THIS.this_nIntvlrcont    = TratarNulo(intvlrcont,   "N")
                THIS.this_nIntvlricms    = TratarNulo(intvlricms,   "N")
                THIS.this_nIntvlripi     = TratarNulo(intvlripi,    "N")
                THIS.this_nIndmov        = TratarNulo(indmov,       "N")
                THIS.this_nIndpagto      = TratarNulo(indpagto,     "N")

                *-- Outros
                THIS.this_nTransps       = TratarNulo(transps,      "N")
                THIS.this_nTiporecs      = TratarNulo(tiporecs,     "N")
                THIS.this_nObspads       = TratarNulo(obspads,      "N")

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "cfoBO.CarregarDoCursor")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SIGCDCFO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SIGCDCFO (" + ;
                "codigos, descricaos, desc2s, situas, tipos, operacaos, ndigitos," + ;
                " icms, inclicms, icmsincs, icmsdscs, sittribs, pbcsts, subtribs," + ;
                " cfosts, coddests, cfost60s, aliqivcs, desicms, frticms, segicms," + ;
                " incicmnfs, somaicmfrete, cgergia1s, unitimps, motdeson," + ;
                " ipis, aliqipis, inclipis, ipi_icms, bcipis, pbcipis, ipincreds," + ;
                " acresipis, ipiimpors, ipiom2s, desipis, frtipis, segipis," + ;
                " ipicst, piscst, cofcst, issqnl, aliqpis, aliqcofins, aliqissqn," + ;
                " ctissqn, rettribs, aliqii, ipienq, contribs," + ;
                " contvcds, contvccs, conticds, conticcs, contipds, contipcs," + ;
                " contfrt, contseg, contda, contconts," + ;
                " pontedescs, agrupas, zeradas, dtintfis, utilvars," + ;
                " intvlrcont, intvlricms, intvlripi, indmov, indpagto," + ;
                " transps, tiporecs, obspads" + ;
                ") VALUES (" + ;
                EscaparSQL(THIS.this_cCodigos) + ", " + ;
                EscaparSQL(THIS.this_cDescricaos) + ", " + ;
                EscaparSQL(THIS.this_cDesc2s) + ", " + ;
                FormatarNumeroSQL(THIS.this_nSituas, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTipos, 0) + ", " + ;
                EscaparSQL(THIS.this_cOperacaos) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNdigitos, 0) + ", " + ;
                EscaparSQL(THIS.this_cIcms) + ", " + ;
                FormatarNumeroSQL(THIS.this_nInclicms, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIcmsincs, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIcmsdscs, 0) + ", " + ;
                EscaparSQL(THIS.this_cSittribs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nPbcsts, 2) + ", " + ;
                EscaparSQL(THIS.this_cSubtribs) + ", " + ;
                EscaparSQL(THIS.this_cCfosts) + ", " + ;
                EscaparSQL(THIS.this_cCoddests) + ", " + ;
                EscaparSQL(THIS.this_cCfost60s) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqivcs, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nDesicms, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nFrticms, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nSegicms, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIncicmnfs, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nSomaicmfrete, 0) + ", " + ;
                EscaparSQL(THIS.this_cCgergia1s) + ", " + ;
                EscaparSQL(THIS.this_cUnitimps) + ", " + ;
                EscaparSQL(THIS.this_cMotdeson) + ", " + ;
                EscaparSQL(THIS.this_cIpis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqipis, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nInclipis, 0) + ", " + ;
                EscaparSQL(THIS.this_cIpiIcms) + ", " + ;
                EscaparSQL(THIS.this_cBcipis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nPbcipis, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIpincreds, 0) + ", " + ;
                EscaparSQL(THIS.this_cAcresipis) + ", " + ;
                EscaparSQL(THIS.this_cIpiimpors) + ", " + ;
                EscaparSQL(THIS.this_cIpiom2s) + ", " + ;
                FormatarNumeroSQL(THIS.this_nDesipis, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nFrtipis, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nSegipis, 0) + ", " + ;
                EscaparSQL(THIS.this_cIpicst) + ", " + ;
                EscaparSQL(THIS.this_cPiscst) + ", " + ;
                EscaparSQL(THIS.this_cCofcst) + ", " + ;
                EscaparSQL(THIS.this_cIssqnl) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqpis, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqcofins, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqissqn, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nCtissqn, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nRettribs, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqii, 2) + ", " + ;
                EscaparSQL(THIS.this_cIpienq) + ", " + ;
                EscaparSQL(THIS.this_cContribs) + ", " + ;
                EscaparSQL(THIS.this_cContvcds) + ", " + ;
                EscaparSQL(THIS.this_cContvccs) + ", " + ;
                EscaparSQL(THIS.this_cConticds) + ", " + ;
                EscaparSQL(THIS.this_cConticcs) + ", " + ;
                EscaparSQL(THIS.this_cContipds) + ", " + ;
                EscaparSQL(THIS.this_cContipcs) + ", " + ;
                EscaparSQL(THIS.this_cContfrt) + ", " + ;
                EscaparSQL(THIS.this_cContseg) + ", " + ;
                EscaparSQL(THIS.this_cContda) + ", " + ;
                EscaparSQL(THIS.this_cContconts) + ", " + ;
                FormatarNumeroSQL(THIS.this_nPontedescs, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAgrupas, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nZeradas, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nDtintfis, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nUtilvars, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIntvlrcont, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIntvlricms, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIntvlripi, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIndmov, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIndpagto, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTransps, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTiporecs, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nObspads, 0) + ;
                ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "cfoBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SIGCDCFO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SIGCDCFO SET " + ;
                "descricaos    = " + EscaparSQL(THIS.this_cDescricaos) + ", " + ;
                "desc2s        = " + EscaparSQL(THIS.this_cDesc2s) + ", " + ;
                "situas        = " + FormatarNumeroSQL(THIS.this_nSituas, 0) + ", " + ;
                "tipos         = " + FormatarNumeroSQL(THIS.this_nTipos, 0) + ", " + ;
                "operacaos     = " + EscaparSQL(THIS.this_cOperacaos) + ", " + ;
                "ndigitos      = " + FormatarNumeroSQL(THIS.this_nNdigitos, 0) + ", " + ;
                "icms          = " + EscaparSQL(THIS.this_cIcms) + ", " + ;
                "inclicms      = " + FormatarNumeroSQL(THIS.this_nInclicms, 0) + ", " + ;
                "icmsincs      = " + FormatarNumeroSQL(THIS.this_nIcmsincs, 0) + ", " + ;
                "icmsdscs      = " + FormatarNumeroSQL(THIS.this_nIcmsdscs, 0) + ", " + ;
                "sittribs      = " + EscaparSQL(THIS.this_cSittribs) + ", " + ;
                "pbcsts        = " + FormatarNumeroSQL(THIS.this_nPbcsts, 2) + ", " + ;
                "subtribs      = " + EscaparSQL(THIS.this_cSubtribs) + ", " + ;
                "cfosts        = " + EscaparSQL(THIS.this_cCfosts) + ", " + ;
                "coddests      = " + EscaparSQL(THIS.this_cCoddests) + ", " + ;
                "cfost60s      = " + EscaparSQL(THIS.this_cCfost60s) + ", " + ;
                "aliqivcs      = " + FormatarNumeroSQL(THIS.this_nAliqivcs, 2) + ", " + ;
                "desicms       = " + FormatarNumeroSQL(THIS.this_nDesicms, 0) + ", " + ;
                "frticms       = " + FormatarNumeroSQL(THIS.this_nFrticms, 0) + ", " + ;
                "segicms       = " + FormatarNumeroSQL(THIS.this_nSegicms, 0) + ", " + ;
                "incicmnfs     = " + FormatarNumeroSQL(THIS.this_nIncicmnfs, 0) + ", " + ;
                "somaicmfrete  = " + FormatarNumeroSQL(THIS.this_nSomaicmfrete, 0) + ", " + ;
                "cgergia1s     = " + EscaparSQL(THIS.this_cCgergia1s) + ", " + ;
                "unitimps      = " + EscaparSQL(THIS.this_cUnitimps) + ", " + ;
                "motdeson      = " + EscaparSQL(THIS.this_cMotdeson) + ", " + ;
                "ipis          = " + EscaparSQL(THIS.this_cIpis) + ", " + ;
                "aliqipis      = " + FormatarNumeroSQL(THIS.this_nAliqipis, 2) + ", " + ;
                "inclipis      = " + FormatarNumeroSQL(THIS.this_nInclipis, 0) + ", " + ;
                "ipi_icms      = " + EscaparSQL(THIS.this_cIpiIcms) + ", " + ;
                "bcipis        = " + EscaparSQL(THIS.this_cBcipis) + ", " + ;
                "pbcipis       = " + FormatarNumeroSQL(THIS.this_nPbcipis, 2) + ", " + ;
                "ipincreds     = " + FormatarNumeroSQL(THIS.this_nIpincreds, 0) + ", " + ;
                "acresipis     = " + EscaparSQL(THIS.this_cAcresipis) + ", " + ;
                "ipiimpors     = " + EscaparSQL(THIS.this_cIpiimpors) + ", " + ;
                "ipiom2s       = " + EscaparSQL(THIS.this_cIpiom2s) + ", " + ;
                "desipis       = " + FormatarNumeroSQL(THIS.this_nDesipis, 0) + ", " + ;
                "frtipis       = " + FormatarNumeroSQL(THIS.this_nFrtipis, 0) + ", " + ;
                "segipis       = " + FormatarNumeroSQL(THIS.this_nSegipis, 0) + ", " + ;
                "ipicst        = " + EscaparSQL(THIS.this_cIpicst) + ", " + ;
                "piscst        = " + EscaparSQL(THIS.this_cPiscst) + ", " + ;
                "cofcst        = " + EscaparSQL(THIS.this_cCofcst) + ", " + ;
                "issqnl        = " + EscaparSQL(THIS.this_cIssqnl) + ", " + ;
                "aliqpis       = " + FormatarNumeroSQL(THIS.this_nAliqpis, 2) + ", " + ;
                "aliqcofins    = " + FormatarNumeroSQL(THIS.this_nAliqcofins, 2) + ", " + ;
                "aliqissqn     = " + FormatarNumeroSQL(THIS.this_nAliqissqn, 2) + ", " + ;
                "ctissqn       = " + FormatarNumeroSQL(THIS.this_nCtissqn, 0) + ", " + ;
                "rettribs      = " + FormatarNumeroSQL(THIS.this_nRettribs, 0) + ", " + ;
                "aliqii        = " + FormatarNumeroSQL(THIS.this_nAliqii, 2) + ", " + ;
                "ipienq        = " + EscaparSQL(THIS.this_cIpienq) + ", " + ;
                "contribs      = " + EscaparSQL(THIS.this_cContribs) + ", " + ;
                "contvcds      = " + EscaparSQL(THIS.this_cContvcds) + ", " + ;
                "contvccs      = " + EscaparSQL(THIS.this_cContvccs) + ", " + ;
                "conticds      = " + EscaparSQL(THIS.this_cConticds) + ", " + ;
                "conticcs      = " + EscaparSQL(THIS.this_cConticcs) + ", " + ;
                "contipds      = " + EscaparSQL(THIS.this_cContipds) + ", " + ;
                "contipcs      = " + EscaparSQL(THIS.this_cContipcs) + ", " + ;
                "contfrt       = " + EscaparSQL(THIS.this_cContfrt) + ", " + ;
                "contseg       = " + EscaparSQL(THIS.this_cContseg) + ", " + ;
                "contda        = " + EscaparSQL(THIS.this_cContda) + ", " + ;
                "contconts     = " + EscaparSQL(THIS.this_cContconts) + ", " + ;
                "pontedescs    = " + FormatarNumeroSQL(THIS.this_nPontedescs, 0) + ", " + ;
                "agrupas       = " + FormatarNumeroSQL(THIS.this_nAgrupas, 0) + ", " + ;
                "zeradas       = " + FormatarNumeroSQL(THIS.this_nZeradas, 0) + ", " + ;
                "dtintfis      = " + FormatarNumeroSQL(THIS.this_nDtintfis, 0) + ", " + ;
                "utilvars      = " + FormatarNumeroSQL(THIS.this_nUtilvars, 0) + ", " + ;
                "intvlrcont    = " + FormatarNumeroSQL(THIS.this_nIntvlrcont, 0) + ", " + ;
                "intvlricms    = " + FormatarNumeroSQL(THIS.this_nIntvlricms, 0) + ", " + ;
                "intvlripi     = " + FormatarNumeroSQL(THIS.this_nIntvlripi, 0) + ", " + ;
                "indmov        = " + FormatarNumeroSQL(THIS.this_nIndmov, 0) + ", " + ;
                "indpagto      = " + FormatarNumeroSQL(THIS.this_nIndpagto, 0) + ", " + ;
                "transps       = " + FormatarNumeroSQL(THIS.this_nTransps, 0) + ", " + ;
                "tiporecs      = " + FormatarNumeroSQL(THIS.this_nTiporecs, 0) + ", " + ;
                "obspads       = " + FormatarNumeroSQL(THIS.this_nObspads, 0) + ;
                " WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "cfoBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SIGCDCFO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SIGCDCFO WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "cfoBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com codigos, descricaos, situas
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Sem conexao: criar cursor vazio para nao bloquear o grid
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    CREATE CURSOR cursor_4c_Dados (codigos C(10), descricaos C(60), situas N(1,0))
                ENDIF
                loc_lSucesso = .T.
            ENDIF

            loc_cSQL = "SELECT codigos, descricaos, situas FROM SIGCDCFO"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY codigos"

            *-- Protecao de grid: se cursor ja esta aberto (grid vinculado), usar ZAP+APPEND
            IF USED("cursor_4c_Dados")
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                IF loc_nResultado >= 0
                    SELECT cursor_4c_Dados
                    ZAP
                    APPEND FROM DBF("cursor_4c_DadosTmp")
                    USE IN cursor_4c_DadosTmp
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "cfoBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descricaos, desc2s, situas, tipos, operacaos, ndigitos," + ;
                " icms, inclicms, icmsincs, icmsdscs, sittribs, pbcsts, subtribs," + ;
                " cfosts, coddests, cfost60s, aliqivcs, desicms, frticms, segicms," + ;
                " incicmnfs, somaicmfrete, cgergia1s, unitimps, motdeson," + ;
                " ipis, aliqipis, inclipis, ipi_icms, bcipis, pbcipis, ipincreds," + ;
                " acresipis, ipiimpors, ipiom2s, desipis, frtipis, segipis," + ;
                " ipicst, piscst, cofcst, issqnl, aliqpis, aliqcofins, aliqissqn," + ;
                " ctissqn, rettribs, aliqii, ipienq, contribs," + ;
                " contvcds, contvccs, conticds, conticcs, contipds, contipcs," + ;
                " contfrt, contseg, contda, contconts," + ;
                " pontedescs, agrupas, zeradas, dtintfis, utilvars," + ;
                " intvlrcont, intvlricms, intvlripi, indmov, indpagto," + ;
                " transps, tiporecs, obspads" + ;
                " FROM SIGCDCFO WHERE codigos = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("CFOP n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "cfoBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave prim" + CHR(225) + "ria para auditoria
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigos
    ENDFUNC

    *--------------------------------------------------------------------------
    * Validar - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Validar()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cCodigos))
            MsgAviso("C" + CHR(243) + "digo obrigat" + CHR(243) + "rio!")
            loc_lValido = .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cDescricaos))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o obrigat" + CHR(243) + "ria!")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarCfopPorCodigo - Busca CFOP para lookup (usado em validacoes de campos)
    * Retorna .T. se encontrou, cursor cursor_4c_BuscaCfo com os dados
    *--------------------------------------------------------------------------
    PROCEDURE BuscarCfopPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descricaos FROM SIGCDCFO" + ;
                " WHERE codigos = " + EscaparSQL(par_cCodigo)

            IF USED("cursor_4c_BuscaCfo")
                USE IN cursor_4c_BuscaCfo
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCfo")

            IF loc_nResultado >= 0
                loc_lSucesso = (RECCOUNT("cursor_4c_BuscaCfo") > 0)
            ELSE
                MostrarErro("Erro ao buscar CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar CFOP:" + CHR(13) + loException.Message, "cfoBO.BuscarCfopPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarIcmPorCodigo - Busca Situacao Tributaria ICMS para lookup
    * Retorna .T. se encontrou, cursor cursor_4c_BuscaIcm com os dados
    *--------------------------------------------------------------------------
    PROCEDURE BuscarIcmPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descricaos FROM SigCdIcm" + ;
                " WHERE codigos = " + EscaparSQL(par_cCodigo)

            IF USED("cursor_4c_BuscaIcm")
                USE IN cursor_4c_BuscaIcm
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaIcm")

            IF loc_nResultado >= 0
                loc_lSucesso = (RECCOUNT("cursor_4c_BuscaIcm") > 0)
            ELSE
                MostrarErro("Erro ao buscar ICM:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar ICM:" + CHR(13) + loException.Message, "cfoBO.BuscarIcmPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

