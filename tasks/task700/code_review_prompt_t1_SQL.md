# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: UMOVS, GRCLIS, ICLIS, TIPOS, VENCS

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
lcEmp = _Empr + Iif(Seek(_Empr, 'crSigCdEmp', 'Cemps'), ' - ' + Alltrim(crSigCdEmp.Razas), '')
Insert Into csCabecalho (Empresa, Titulo, Subtitulo, Quebra, Nconta) Values (lcEmp, lcTit, lcSub, llQue, llconta )
lcWhere = [Select a.Vencs, a.GrClis as Grupos, a.IClis as Contas, a.UMovs, a.Emps, ]+ ;
	   	  [From SigChe a, SigCdOpt b, SigCdCli c Where ]+ ;
lnErro = ThisForm.podatamgr.SqlExecute(lcWhere,'CsImpressao')
	Select csImpressao
Select CrSigCdGcr
Select crSigCdOpt
Select CrSigCdEmp
	=Seek(ThisForm.getGrupo.Value, 'crSigCdGcr', 'Codigos')
	Select CrSigCdCli
	Select crSigCdOpt
	If !Seek(This.Value)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGOPCHR.prg) - TRECHOS RELEVANTES PARA PASS SQL (1341 linhas total):

*-- Linhas 548 a 566:
548:             .Visible   = .T.
549:         ENDWITH
550: 
551:         *-- Tipo (OptionGroup Geral/Nao Liquidado - ControlSource numerico 1/2)
552:         loc_oPg.AddObject("obj_4c_GetTipo", "OptionGroup")
553:         loc_oPg.obj_4c_GetTipo.ButtonCount = 2
554:         WITH loc_oPg.obj_4c_GetTipo
555:             .Top         = 119
556:             .Left        = 238
557:             .Width       = 144
558:             .Height      = 27
559:             .BackStyle   = 0
560:             .BorderStyle = 0
561:             .Value       = 1
562:             .Themes      = .F.
563:             .Visible     = .T.
564: 
565:             WITH .Buttons(1)
566:                 .Caption   = "Geral"

*-- Linhas 654 a 672:
654:                 *-- Regra #37: atribuir SO sob a guarda this_lSelecionou. Sem
655:                 *-- picker selecionado, o codigo digitado permanece (regra #50).
656:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_OperPick")
657:                     SELECT cursor_4c_OperPick
658:                     loc_oPg.txt_4c_Oper.Value = ALLTRIM(cursor_4c_OperPick.Operacaos)
659:                 ENDIF
660: 
661:                 IF USED("cursor_4c_OperPick")
662:                     USE IN cursor_4c_OperPick
663:                 ENDIF
664:                 loc_oLookup.Release()
665:             ENDIF
666:         CATCH TO loc_oErro
667:             MsgErro(loc_oErro.Message, "FormSIGOPCHR.ValidarOper")
668:         ENDTRY
669:     ENDPROC
670: 
671:     *--------------------------------------------------------------------------
672:     * ValidarGrupo - LostFocus: lookup de grupo contabil (SigCdGcr)

*-- Linhas 707 a 725:
707:                 ENDIF
708: 
709:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_GrupoPick")
710:                     SELECT cursor_4c_GrupoPick
711:                     loc_oPg.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_GrupoPick.codigos)
712:                     loc_oPg.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_GrupoPick.descrs)
713:                 ELSE
714:                     *-- Legado (fAcessoContab): sem selecao, limpa a descricao
715:                     loc_oPg.txt_4c_DGrupo.Value = ""
716:                 ENDIF
717: 
718:                 IF USED("cursor_4c_GrupoPick")
719:                     USE IN cursor_4c_GrupoPick
720:                 ENDIF
721:                 loc_oLookup.Release()
722:             ENDIF
723:         CATCH TO loc_oErro
724:             MsgErro(loc_oErro.Message, "FormSIGOPCHR.ValidarGrupo")
725:         ENDTRY

*-- Linhas 767 a 807:
767:                 ENDIF
768: 
769:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_DGrupoPick")
770:                     SELECT cursor_4c_DGrupoPick
771:                     loc_oPg.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_DGrupoPick.codigos)
772:                     loc_oPg.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_DGrupoPick.descrs)
773:                 ELSE
774:                     loc_oPg.txt_4c_DGrupo.Value = ""
775:                 ENDIF
776: 
777:                 IF USED("cursor_4c_DGrupoPick")
778:                     USE IN cursor_4c_DGrupoPick
779:                 ENDIF
780:                 loc_oLookup.Release()
781:             ENDIF
782:         CATCH TO loc_oErro
783:             MsgErro(loc_oErro.Message, "FormSIGOPCHR.ValidarDGrupo")
784:         ENDTRY
785:     ENDPROC
786: 
787:     *--------------------------------------------------------------------------
788:     * ValidarConta - LostFocus: lookup de conta/cliente (SigCdCli), filtrado
789:     *   pelo grupo contabil quando preenchido.
790:     *   Legado (getConta.Valid): fAcessoContas(Usuar,Grupo,'C',This.Value,...).
791:     *   Substituicao canonica (fAcessoContas NAO deve ser chamada diretamente
792:     *   como handler de UX - auto-carrega o 1o match por LIKE): SELECT exato
793:     *   via FormBuscaAuxiliar + picker filtrado por grupos, como Formche.
794:     *   ResolverConta.
795:     *--------------------------------------------------------------------------
796:     PROCEDURE ValidarConta()
797:         IF THIS.this_lEmLookup
798:             RETURN
799:         ENDIF
800:         THIS.this_lEmLookup = .T.
801:         THIS.ValidarContaExec()
802:         THIS.this_lEmLookup = .F.
803:         THIS.AtualizarEstadoCampos()
804:     ENDPROC
805: 
806:     PROCEDURE ValidarContaExec()
807:         LOCAL loc_oPg, loc_cVal, loc_cGrupo, loc_cFiltro, loc_oLookup, loc_oErro

*-- Linhas 815 a 847:
815:             ENDIF
816: 
817:             loc_cGrupo  = ALLTRIM(loc_oPg.txt_4c_Grupo.Value)
818:             loc_cFiltro = IIF(EMPTY(loc_cGrupo), "", "grupos = " + EscaparSQL(loc_cGrupo))
819: 
820:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
821:                 gnConnHandle, "SigCdCli", "cursor_4c_ContaPick", ;
822:                 "Iclis", loc_cVal, "Conta", .F., .F., loc_cFiltro)
823: 
824:             IF VARTYPE(loc_oLookup) = "O"
825:                 IF !loc_oLookup.this_lAchouRegistro
826:                     loc_oLookup.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
827:                     loc_oLookup.mAddColuna("Rclis", "", "Nome")
828:                     loc_oLookup.Show()
829:                 ENDIF
830: 
831:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_ContaPick")
832:                     SELECT cursor_4c_ContaPick
833:                     loc_oPg.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_ContaPick.Iclis)
834:                     loc_oPg.txt_4c_DConta.Value = ALLTRIM(cursor_4c_ContaPick.Rclis)
835:                 ELSE
836:                     loc_oPg.txt_4c_DConta.Value = ""
837:                 ENDIF
838: 
839:                 IF USED("cursor_4c_ContaPick")
840:                     USE IN cursor_4c_ContaPick
841:                 ENDIF
842:                 loc_oLookup.Release()
843:             ENDIF
844:         CATCH TO loc_oErro
845:             MsgErro(loc_oErro.Message, "FormSIGOPCHR.ValidarConta")
846:         ENDTRY
847:     ENDPROC

*-- Linhas 878 a 910:
878:             ENDIF
879: 
880:             loc_cGrupo  = ALLTRIM(loc_oPg.txt_4c_Grupo.Value)
881:             loc_cFiltro = IIF(EMPTY(loc_cGrupo), "", "grupos = " + EscaparSQL(loc_cGrupo))
882: 
883:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
884:                 gnConnHandle, "SigCdCli", "cursor_4c_DContaPick", ;
885:                 "Rclis", loc_cVal, "Conta", .F., .F., loc_cFiltro)
886: 
887:             IF VARTYPE(loc_oLookup) = "O"
888:                 IF !loc_oLookup.this_lAchouRegistro
889:                     loc_oLookup.mAddColuna("Rclis", "", "Nome")
890:                     loc_oLookup.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
891:                     loc_oLookup.Show()
892:                 ENDIF
893: 
894:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_DContaPick")
895:                     SELECT cursor_4c_DContaPick
896:                     loc_oPg.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_DContaPick.Iclis)
897:                     loc_oPg.txt_4c_DConta.Value = ALLTRIM(cursor_4c_DContaPick.Rclis)
898:                 ELSE
899:                     loc_oPg.txt_4c_DConta.Value = ""
900:                 ENDIF
901: 
902:                 IF USED("cursor_4c_DContaPick")
903:                     USE IN cursor_4c_DContaPick
904:                 ENDIF
905:                 loc_oLookup.Release()
906:             ENDIF
907:         CATCH TO loc_oErro
908:             MsgErro(loc_oErro.Message, "FormSIGOPCHR.ValidarDConta")
909:         ENDTRY
910:     ENDPROC


### BO (C:\4c\projeto\app\classes\SIGOPCHRBO.prg):
*==============================================================================
* SIGOPCHRBO.PRG
* Business Object para Relatorio de Relacao de Cheques
*
* Herda de: RelatorioBase
* Form: FormSIGOPCHR.prg
* Relatorio original: SIGOPCHR.SCX / SigOpChr.FRX
*==============================================================================

DEFINE CLASS SIGOPCHRBO AS RelatorioBase

    *-- Identificacao do relatorio
    this_cArquivoRelatorio  = "SigOpChr"
    this_cTituloRelatorio   = ""
    this_cSubtituloRelatorio = ""

    *-- Filtros de parametro do formulario (legado: Get_Oper/GetDataI/GetDataF/GetTipo/getGrupo/getConta/ImpNConta)
    this_cOperacao          = ""
    this_dDataInicial       = {}
    this_dDataFinal         = {}
    this_nTipo              = 1
    this_cGrupo             = ""
    this_cDescGrupo         = ""
    this_cConta             = ""
    this_cDescConta         = ""
    this_lImpNConta         = .F.

    *-- Cursores principais consumidos pelo FRX (nomes preservados do legado)
    this_cCursorDados       = "CsImpressao"
    this_cCursorCabecalho   = "csCabecalho"

    *--------------------------------------------------------------------------
    * Init - Construtor do BO de Relatorio de Cheques
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""

        THIS.this_cTituloRelatorio = "Rela" + CHR(231) + CHR(227) + "o de Cheques"

        THIS.this_dDataInicial = DATE() - 30
        THIS.this_dDataFinal   = DATE()
        THIS.this_nTipo        = 1

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarParametros - Valida filtros antes de PrepararDados
    * Equivale ao bloco de validacao de btnReport.Click do legado
    * (Data Inicial/Final invalidas, Final < Inicial).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarParametros()
        THIS.this_cMensagemErro = ""

        IF EMPTY(THIS.this_dDataInicial)
            THIS.this_cMensagemErro = "Data Inicial Inv" + CHR(225) + "lida!!!"
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.this_dDataFinal)
            THIS.this_cMensagemErro = "Data Final Inv" + CHR(225) + "lida!!!"
            RETURN .F.
        ENDIF

        IF THIS.this_dDataFinal < THIS.this_dDataInicial
            THIS.this_cMensagemErro = "A Data Final N" + CHR(227) + ;
                "o Pode Ser Menor do que a Inicial!!!"
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarCabecalho - Popula cursor csCabecalho referenciado pelo FRX legado
    * SigOpChr.frx tem Dataenvironment com alias csCabecalho (Empresa, Titulo,
    * Subtitulo, Quebra, Nconta). Estrutura preservada do legado
    * (SIGOPCHR.processamento).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarCabecalho()
        LOCAL loc_cEmp, loc_cRazas, loc_cEmpresa, loc_cTitulo, loc_cSubtitulo
        LOCAL loc_lQuebra, loc_nResult

        loc_cEmp = ALLTRIM(go_4c_Sistema.cCodEmpresa)

        loc_cRazas = ""
        IF USED("cursor_4c_EmpCab")
            USE IN cursor_4c_EmpCab
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, ;
            "SELECT Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cEmp), ;
            "cursor_4c_EmpCab")
        IF loc_nResult > 0 AND USED("cursor_4c_EmpCab") AND RECCOUNT("cursor_4c_EmpCab") > 0
            loc_cRazas = ALLTRIM(cursor_4c_EmpCab.Razas)
        ENDIF
        IF USED("cursor_4c_EmpCab")
            USE IN cursor_4c_EmpCab
        ENDIF
        loc_cEmpresa = loc_cEmp + IIF(EMPTY(loc_cRazas), "", " - " + loc_cRazas)

        loc_cTitulo = "Rela" + CHR(231) + CHR(227) + "o " + ;
            IIF(THIS.this_nTipo = 1, "Geral de Cheques - ", "de Cheques Pendentes - ") + ;
            IIF(EMPTY(ALLTRIM(THIS.this_cOperacao)), ;
                "Todas as Opera" + CHR(231) + CHR(245) + "es", ;
                ALLTRIM(THIS.this_cOperacao))

        loc_cSubtitulo = "Per" + CHR(237) + "odo : " + DTOC(THIS.this_dDataInicial) + ;
            " at" + CHR(233) + " " + DTOC(THIS.this_dDataFinal) + "     " + ;
            IIF(EMPTY(ALLTRIM(THIS.this_cGrupo)), ;
                "Todos os Grupos", "Grupo : " + ALLTRIM(THIS.this_cGrupo)) + "  " + ;
            IIF(EMPTY(ALLTRIM(THIS.this_cConta)), ;
                "Todas as Contas", "Conta : " + ALLTRIM(THIS.this_cConta))

        loc_lQuebra = EMPTY(ALLTRIM(THIS.this_cConta))

        IF USED("csCabecalho")
            USE IN csCabecalho
        ENDIF
        CREATE CURSOR csCabecalho (Empresa C(80), Titulo C(80), Subtitulo C(80), ;
            Quebra L(1), Nconta L)
        INSERT INTO csCabecalho (Empresa, Titulo, Subtitulo, Quebra, Nconta) ;
            VALUES (loc_cEmpresa, loc_cTitulo, loc_cSubtitulo, loc_lQuebra, ;
                    THIS.this_lImpNConta)

        SELECT csCabecalho
        GO TOP
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta WHERE a partir dos filtros e executa a consulta
    * Transcricao de SIGOPCHR.processamento:
    *   From SigChe a, SigCdOpt b, SigCdCli c
    *   Where a.Vencs Between ?ldDatai And ?ldDataF
    *     [And a.Umovs = lcOpera] [And a.GrClis = lcGrupo] [And a.IClis = lcConta]
    *     [And b.Tipos = 'DB' quando this_nTipo = 2 (nao liquidado)]
    *     And a.Umovs = b.Operacaos And a.Iclis = c.Iclis
    *   Order By 1,2,3,4,5,6,7,8,9,10
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cWhere
        LOCAL loc_tDataFinal, loc_nResult

        loc_lSucesso = .F.

        TRY
            IF !THIS.ValidarParametros()
                loc_lSucesso = .F.
            ELSE
                THIS.CriarCabecalho()

                *-- Data final inclui o dia inteiro (fDtoSQL(ldDataF,'23:59:59') no legado)
                loc_tDataFinal = DATETIME(YEAR(THIS.this_dDataFinal), ;
                    MONTH(THIS.this_dDataFinal), DAY(THIS.this_dDataFinal), 23, 59, 59)

                loc_cWhere = " a.Vencs BETWEEN " + FormatarDataSQL(THIS.this_dDataInicial) + ;
                             " AND " + FormatarDataSQL(loc_tDataFinal)

                IF !EMPTY(ALLTRIM(THIS.this_cOperacao))
                    loc_cWhere = loc_cWhere + " AND a.Umovs = " + ;
                        EscaparSQL(ALLTRIM(THIS.this_cOperacao))
                ENDIF
                IF !EMPTY(ALLTRIM(THIS.this_cGrupo))
                    loc_cWhere = loc_cWhere + " AND a.GrClis = " + ;
                        EscaparSQL(ALLTRIM(THIS.this_cGrupo))
                ENDIF
                IF !EMPTY(ALLTRIM(THIS.this_cConta))
                    loc_cWhere = loc_cWhere + " AND a.IClis = " + ;
                        EscaparSQL(ALLTRIM(THIS.this_cConta))
                ENDIF
                IF THIS.this_nTipo = 2
                    loc_cWhere = loc_cWhere + " AND b.Tipos = " + EscaparSQL("DB")
                ENDIF

                loc_cSQL = "SELECT a.Vencs, a.GrClis AS Grupos, a.IClis AS Contas," + ;
                           " a.Umovs, a.Emps, a.Bancos, a.Agencias, a.NContas," + ;
                           " a.NCheques, a.Valors, b.Tipos, c.Rclis" + ;
                           " FROM SigChe a" + ;
                           " INNER JOIN SigCdOpt b ON a.Umovs = b.Operacaos" + ;
                           " INNER JOIN SigCdCli c ON a.IClis = c.IClis" + ;
                           " WHERE" + loc_cWhere + ;
                           " ORDER BY a.Vencs, a.GrClis, a.IClis, a.Umovs, a.Emps," + ;
                           " a.Bancos, a.Agencias, a.NContas, a.NCheques, a.Valors"

                IF USED(THIS.this_cCursorDados)
                    USE IN (THIS.this_cCursorDados)
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao buscar cheques" + CHR(13) + ;
                        CapturarErroSQL()
                    loc_lSucesso = .F.
                ELSE
                    SELECT (THIS.this_cCursorDados)
                    GO TOP
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro em PrepararDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarReportForm (Pattern #117) - Executa REPORT FORM apenas se o FRX
    * existir e o cursor nao estiver vazio. Isola SET POINT/SEPARATOR/
    * REPORTBEHAVIOR durante o REPORT FORM porque o FRX legado Fortyus foi
    * desenhado com POINT="." + REPORTBEHAVIOR 80. Restaura o menu principal
    * depois do PREVIEW (Erro63).
    * par_cModo: "PREVIEW" | "PRINTER_PROMPT" | "PRINTER"
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
        LOCAL loc_cFRX
        loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")

        IF NOT FILE(loc_cFRX)
            MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
                "o encontrado:" + CHR(13) + loc_cFRX + CHR(13) + CHR(13) + ;
                "O FRX legado ainda n" + CHR(227) + ;
                "o foi portado para o novo sistema.", "Erro")
            RETURN .F.
        ENDIF

        *-- Guard cursor vazio: evita preview em branco / impressao vazia (Erro30)
        IF VARTYPE(par_cCursorDados) == "C" AND !EMPTY(par_cCursorDados)
            IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
                MsgAviso("Nenhum cheque encontrado com os filtros informados.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                RETURN .F.
            ENDIF
        ENDIF

        LOCAL loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig
        loc_cPointOrig    = SET("POINT")
        loc_cSepOrig      = SET("SEPARATOR")
        loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
        SET POINT TO "."
        SET SEPARATOR TO ","
        SET REPORTBEHAVIOR 80

        DO CASE
            CASE par_cModo == "PREVIEW"
                REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
            CASE par_cModo == "PRINTER_PROMPT"
                REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
            CASE par_cModo == "PRINTER"
                REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
        ENDCASE

        SET POINT TO (loc_cPointOrig)
        SET SEPARATOR TO (loc_cSepOrig)
        SET REPORTBEHAVIOR (loc_nBehaviorOrig)

        *-- Restaurar menu (Erro63): REPORT FORM PREVIEW abre toolbar propria
        *-- que corrompe o cache visual do _MSYSMENU.
        TRY
            SET SYSMENU TO DEFAULT
            RELEASE POPUP popArquivo, popCadastros, popMovimentos, popRelatorios, popFerramentas, popAjuda
            CriarMenuPrincipal()
        CATCH
            *-- CriarMenuPrincipal fora do escopo (teste automatizado) - silencioso
        ENDTRY

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe o relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_cMensagemErro = ""
            IF THIS.PrepararDados()
                SELECT (THIS.this_cCursorDados)
                GO TOP
                loc_lSucesso = THIS.ExecutarReportForm("SigOpChr", "PREVIEW", THIS.this_cCursorDados)
                IF loc_lSucesso
                    THIS.RegistrarAuditoria("VISUALIZAR")
                ENDIF
            ELSE
                IF !EMPTY(THIS.this_cMensagemErro)
                    MsgErro(THIS.this_cMensagemErro, "Rela" + CHR(231) + CHR(227) + "o de Cheques")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao visualizar relat" + CHR(243) + "rio")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia o relatorio para a impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_cMensagemErro = ""
            IF THIS.PrepararDados()
                SELECT (THIS.this_cCursorDados)
                GO TOP
                loc_lSucesso = THIS.ExecutarReportForm("SigOpChr", "PRINTER_PROMPT", THIS.this_cCursorDados)
                IF loc_lSucesso
                    THIS.RegistrarAuditoria("IMPRESSAO")
                ENDIF
            ELSE
                IF !EMPTY(THIS.this_cMensagemErro)
                    MsgErro(THIS.this_cMensagemErro, "Rela" + CHR(231) + CHR(227) + "o de Cheques")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao imprimir relat" + CHR(243) + "rio")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarExcel - Exporta o relatorio para arquivo ASCII (Pattern #167)
    *--------------------------------------------------------------------------
    PROCEDURE GerarExcel()
        LOCAL loc_lSucesso, loc_cArquivo, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_cMensagemErro = ""
            IF THIS.PrepararDados()
                IF USED(THIS.this_cCursorDados) AND RECCOUNT(THIS.this_cCursorDados) > 0
                    SELECT (THIS.this_cCursorDados)
                    GO TOP
                    loc_cArquivo = SYS(5) + CURDIR() + "sigopchr_" + ;
                                   STRTRAN(DTOC(DATE()), "/", "") + ".xls"
                    REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) ;
                        TO FILE (loc_cArquivo) NOCONSOLE ASCII
                    IF FILE(loc_cArquivo)
                        MsgInfo("Arquivo gerado:" + CHR(13) + loc_cArquivo, "Excel")
                        THIS.RegistrarAuditoria("EXCEL")
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Nenhum cheque encontrado com os filtros informados."
                    MsgAviso(THIS.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
                ENDIF
            ELSE
                IF !EMPTY(THIS.this_cMensagemErro)
                    MsgErro(THIS.this_cMensagemErro, "Rela" + CHR(231) + CHR(227) + "o de Cheques")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "GerarExcel")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro da ultima operacao
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave composta dos filtros, usada em RegistrarAuditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN "OPER=" + ALLTRIM(THIS.this_cOperacao) + ;
               ";TIPO=" + ALLTRIM(STR(THIS.this_nTipo, 1)) + ;
               ";GRUPO=" + ALLTRIM(THIS.this_cGrupo) + ;
               ";CONTA=" + ALLTRIM(THIS.this_cConta) + ;
               ";DT=" + DTOC(THIS.this_dDataInicial) + "-" + DTOC(THIS.this_dDataFinal)
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra a geracao do relatorio em LogAuditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResult, loc_cUsuario, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
            ENDIF

            loc_cChave = THIS.ObterChavePrimaria()

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Tabela, Operacao, ChaveRegistro, Usuario, DataHora) VALUES (" + ;
                       EscaparSQL("SigChe") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       "GETDATE())"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores abertos por PrepararDados/CriarCabecalho
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_aCursores(3), loc_nI
        loc_aCursores(1) = THIS.this_cCursorDados
        loc_aCursores(2) = "csCabecalho"
        loc_aCursores(3) = "cursor_4c_EmpCab"

        FOR loc_nI = 1 TO 3
            IF USED(loc_aCursores(loc_nI))
                USE IN (loc_aCursores(loc_nI))
            ENDIF
        ENDFOR

        DODEFAULT()
    ENDPROC

ENDDEFINE

