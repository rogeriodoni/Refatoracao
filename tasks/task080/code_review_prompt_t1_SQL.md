# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'IMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, I, EMIS, VCOFINS, VCSLL, CLIFORS

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
Select Cemps ;
  From crSigCdEmp ;
		Select LocalEmps
	If ThisForm.podatamgr.SQLExecute([select ?lfalso as Imps, cemps, razas from SigCdEmp Order by cEmps],'crSigCdEmp') < 1 Then
	Select crSigCdEmp
		.DeleteMark        = .f.
		.Column1.ControlSource   = 'crSigCdEmp.Imps'
		.Column2.ControlSource   = 'crSigCdEmp.cEmps'
		.Column3.ControlSource   = 'crSigCdEmp.Razas'
lcquery = [select d.razsocs, d.cgcs, a.emis, a.totnotas, a.vpis as vimposto, b.codpiss as codservs, a.clifors, c.rclis, c.cpfs as cnpj from SigMvNfi a with (nolock) left join SigCdSrv b with (nolock) on a.codservs=b.codservs ] +;
			[left join SigCdCli c on c.iclis=a.clifors ] +;
			[left join SigCdEmp d on a.emps=d.cemps ] +;
			[select d.razsocs, d.cgcs, a.emis, a.totnotas, a.vcofins as vimposto, b.codcofinss as codservs, a.clifors, c.rclis, c.cpfs as cnpj from SigMvNfi a with (nolock) left join SigCdSrv b with (nolock) on a.codservs=b.codservs ] +;
			[left join SigCdCli c on c.iclis=a.clifors ] +;
			[left join SigCdEmp d on a.emps=d.cemps ] +;			
			[select d.razsocs, d.cgcs, a.emis, a.totnotas, a.vcsll as vimposto,b.codcslls as codservs,a.clifors, c.rclis, c.cpfs as cnpj from SigMvNfi a with (nolock) left join SigCdSrv b with (nolock) on a.codservs=b.codservs ] +;
			[left join SigCdCli c on c.iclis=a.clifors ] +;
			[left join SigCdEmp d on a.emps=d.cemps ] +;			
If( ThisForm.poDataMgr.SQLExecute(m.lcQuery,[crSigMvNfi]) < 1 )
Select crSigMvNfi
	SELECT crSigCdEmp
Update crSigCdEmp Set Imps = (This.Value = 1)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREDIR.prg) - TRECHOS RELEVANTES PARA PASS SQL (1167 linhas total):

*-- Linhas 73 a 91:
73:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
74: 
75:             *-- Instanciar BO apenas quando ha conexao real (pula em validacao UI)
76:             *   SIGREDIRBO.Init() executa SQLEXEC para carregar empresas;
77:             *   em modo gb_4c_ValidandoUI (gnConnHandle=-1) isso falharia.
78:             IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
79:                 THIS.this_oRelatorio = CREATEOBJECT("SIGREDIRBO")
80:                 IF VARTYPE(THIS.this_oRelatorio) != "O"
81:                     MsgErro("Erro ao criar SIGREDIRBO" + CHR(13) + ;
82:                         "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
83:                     loc_lSucesso = .F.
84:                 ENDIF
85:                 THIS.ConfigurarPaginaLista()
86:                 THIS.ConfigurarPaginaDados()
87:                 THIS.LimparCampos()
88:             ENDIF
89: 
90:             THIS.Visible   = .T.
91:             loc_lSucesso   = .T.

*-- Linhas 408 a 467:
408:             .Width              = 291
409:             .Height             = 139
410:             .ColumnCount        = 3
411:             .DeleteMark         = .F.
412:             .RecordMark         = .F.
413:             .FontName           = "Verdana"
414:             .FontSize           = 8
415:             .ForeColor          = RGB(90, 90, 90)
416:             .BackColor          = RGB(255, 255, 255)
417:             .GridLineColor      = RGB(238, 238, 238)
418:             .HighlightBackColor = RGB(255, 255, 255)
419:             .HighlightForeColor = RGB(15, 41, 104)
420:             .HighlightStyle     = 2
421:             .RowHeight          = 16
422:             .ScrollBars         = 2
423: 
424:             *-- Column1: CheckBox para selecao (Imps)
425:             *   ORDEM OBRIGATORIA: AddObject -> Caption -> CurrentControl -> ControlSource
426:             .Column1.Width = 25
427:             .Column1.Header1.Caption = ""
428:             .Column1.AddObject("Check1", "CheckBox")
429:             .Column1.Check1.Caption = ""
430:             .Column1.Check1.Value = 1
431:             .Column1.CurrentControl = "Check1"
432: 
433:             *-- Column2: Codigo da empresa
434:             .Column2.Width    = 55
435:             .Column2.Header1.Caption = "Emp."
436:             .Column2.ReadOnly = .T.
437: 
438:             *-- Column3: Razao Social
439:             .Column3.Width    = 211
440:             .Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
441:             .Column3.ReadOnly = .T.
442: 
443:             .Visible = .T.
444:         ENDWITH
445: 
446:         *-- ControlSource APOS toda a configuracao de colunas e CurrentControl
447:         loc_cCursor = THIS.this_oRelatorio.this_cCursorEmpresas
448:         IF USED(loc_cCursor)
449:             loc_oGrid.RecordSource      = loc_cCursor
450:             loc_oGrid.Column1.ControlSource = loc_cCursor + ".Imps"
451:             loc_oGrid.Column2.ControlSource = loc_cCursor + ".cemps"
452:             loc_oGrid.Column3.ControlSource = loc_cCursor + ".razas"
453:         ENDIF
454: 
455:         *-- Checkbox "marcar/desmarcar todas" posicionado sobre o header do Column1
456:         *   (original: ck_MarcaEmp.Top=180, Left=240 -> Page1: 95, 240)
457:         *   ZOrder(0) garante que fica sobre o grid (adicionado apos o grid)
458:         loc_oPagina.AddObject("chk_4c_MarcaEmp", "CheckBox")
459:         WITH loc_oPagina.chk_4c_MarcaEmp
460:             .Top         = 95
461:             .Left        = 240
462:             .Width       = 22
463:             .Height      = 16
464:             .Caption     = ""
465:             .Value       = 1
466:             .ToolTipText = "Marcar/Desmarcar todas as empresas"
467:             .Visible     = .T.

*-- Linhas 733 a 769:
733:     ENDPROC
734: 
735:     *--------------------------------------------------------------------------
736:     * ValidarFornec - Valida codigo digitado em txt_4c_Fornec via SQLEXEC
737:     *   Se encontrado: preenche txt_4c_Dforn e torna ReadOnly
738:     *   Se nao encontrado: abre FormBuscaAuxiliar para selecao
739:     *--------------------------------------------------------------------------
740:     PROTECTED PROCEDURE ValidarFornec()
741:         LOCAL loc_cValor, loc_cSQL, loc_nResult
742:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Fornec.Value)
743: 
744:         IF EMPTY(loc_cValor)
745:             THIS.pgf_4c_Paginas.Page1.txt_4c_Dforn.Value    = ""
746:             THIS.pgf_4c_Paginas.Page1.txt_4c_Dforn.ReadOnly = .F.
747:             RETURN
748:         ENDIF
749: 
750:         loc_cSQL = "SELECT iclis, rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cValor)
751:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FornVal")
752: 
753:         IF loc_nResult > 0 AND RECCOUNT("cursor_4c_FornVal") = 1
754:             SELECT cursor_4c_FornVal
755:             THIS.pgf_4c_Paginas.Page1.txt_4c_Fornec.Value   = ALLTRIM(iclis)
756:             THIS.pgf_4c_Paginas.Page1.txt_4c_Dforn.Value    = ALLTRIM(rclis)
757:             THIS.pgf_4c_Paginas.Page1.txt_4c_Dforn.ReadOnly = .T.
758:         ELSE
759:             IF USED("cursor_4c_FornVal")
760:                 USE IN cursor_4c_FornVal
761:             ENDIF
762:             THIS.AbrirBuscaFornec()
763:             RETURN
764:         ENDIF
765: 
766:         IF USED("cursor_4c_FornVal")
767:             USE IN cursor_4c_FornVal
768:         ENDIF
769:     ENDPROC

*-- Linhas 788 a 817:
788:             IF VARTYPE(loc_oBusca) = "O"
789:                 IF loc_oBusca.this_lSelecionou
790:                     IF USED("cursor_4c_Busca") AND RECCOUNT("cursor_4c_Busca") > 0
791:                         SELECT cursor_4c_Busca
792:                         THIS.pgf_4c_Paginas.Page1.txt_4c_Fornec.Value   = ALLTRIM(iclis)
793:                         THIS.pgf_4c_Paginas.Page1.txt_4c_Dforn.Value    = ALLTRIM(rclis)
794:                         THIS.pgf_4c_Paginas.Page1.txt_4c_Dforn.ReadOnly = .T.
795:                     ENDIF
796:                 ELSE
797:                     IF loc_oBusca.this_lAchouRegistro OR EMPTY(loc_cValorAtual)
798:                         loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
799:                         loc_oBusca.mAddColuna("rclis", "", "Fornecedor")
800:                         loc_oBusca.Show()
801:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
802:                             SELECT cursor_4c_Busca
803:                             THIS.pgf_4c_Paginas.Page1.txt_4c_Fornec.Value   = ALLTRIM(iclis)
804:                             THIS.pgf_4c_Paginas.Page1.txt_4c_Dforn.Value    = ALLTRIM(rclis)
805:                             THIS.pgf_4c_Paginas.Page1.txt_4c_Dforn.ReadOnly = .T.
806:                         ENDIF
807:                     ENDIF
808:                 ENDIF
809:                 loc_oBusca.Release()
810:             ENDIF
811: 
812:             IF USED("cursor_4c_Busca")
813:                 USE IN cursor_4c_Busca
814:             ENDIF
815: 
816:         CATCH TO loc_oErro
817:             MsgErro(loc_oErro.Message, "Erro")

*-- Linhas 839 a 868:
839:             IF VARTYPE(loc_oBusca) = "O"
840:                 IF loc_oBusca.this_lSelecionou
841:                     IF USED("cursor_4c_Busca") AND RECCOUNT("cursor_4c_Busca") > 0
842:                         SELECT cursor_4c_Busca
843:                         THIS.pgf_4c_Paginas.Page1.txt_4c_Fornec.Value   = ALLTRIM(iclis)
844:                         THIS.pgf_4c_Paginas.Page1.txt_4c_Dforn.Value    = ALLTRIM(rclis)
845:                         THIS.pgf_4c_Paginas.Page1.txt_4c_Dforn.ReadOnly = .T.
846:                     ENDIF
847:                 ELSE
848:                     IF loc_oBusca.this_lAchouRegistro OR EMPTY(loc_cValorAtual)
849:                         loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
850:                         loc_oBusca.mAddColuna("rclis", "", "Fornecedor")
851:                         loc_oBusca.Show()
852:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
853:                             SELECT cursor_4c_Busca
854:                             THIS.pgf_4c_Paginas.Page1.txt_4c_Fornec.Value   = ALLTRIM(iclis)
855:                             THIS.pgf_4c_Paginas.Page1.txt_4c_Dforn.Value    = ALLTRIM(rclis)
856:                             THIS.pgf_4c_Paginas.Page1.txt_4c_Dforn.ReadOnly = .T.
857:                         ENDIF
858:                     ENDIF
859:                 ENDIF
860:                 loc_oBusca.Release()
861:             ENDIF
862: 
863:             IF USED("cursor_4c_Busca")
864:                 USE IN cursor_4c_Busca
865:             ENDIF
866: 
867:         CATCH TO loc_oErro
868:             MsgErro(loc_oErro.Message, "Erro")

*-- Linhas 1102 a 1136:
1102:         ENDIF
1103: 
1104:         TRY
1105:             loc_cSQL = "SELECT 1 AS Imps, cemps, razas FROM SigCdEmp ORDER BY cemps"
1106:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpTmp")
1107: 
1108:             IF loc_nResult > 0
1109:                 IF USED(THIS.this_oRelatorio.this_cCursorEmpresas)
1110:                     USE IN (THIS.this_oRelatorio.this_cCursorEmpresas)
1111:                 ENDIF
1112:                 SELECT Imps, cemps, razas FROM cursor_4c_EmpTmp ;
1113:                     INTO CURSOR (THIS.this_oRelatorio.this_cCursorEmpresas) READWRITE
1114:                 USE IN cursor_4c_EmpTmp
1115: 
1116:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
1117:                 IF VARTYPE(loc_oGrid) = "O"
1118:                     loc_oGrid.RecordSource          = THIS.this_oRelatorio.this_cCursorEmpresas
1119:                     loc_oGrid.Column1.ControlSource = THIS.this_oRelatorio.this_cCursorEmpresas + ".Imps"
1120:                     loc_oGrid.Column2.ControlSource = THIS.this_oRelatorio.this_cCursorEmpresas + ".cemps"
1121:                     loc_oGrid.Column3.ControlSource = THIS.this_oRelatorio.this_cCursorEmpresas + ".razas"
1122:                     loc_oGrid.Refresh()
1123:                 ENDIF
1124: 
1125:                 loc_lSucesso = .T.
1126:             ELSE
1127:                 THIS.this_cMensagemErro = "Erro ao recarregar lista de empresas"
1128:             ENDIF
1129: 
1130:         CATCH TO loc_oErro
1131:             MsgErro(loc_oErro.Message, "Erro")
1132:             THIS.this_cMensagemErro = loc_oErro.Message
1133:         ENDTRY
1134: 
1135:         RETURN loc_lSucesso
1136:     ENDPROC


### BO (C:\4c\projeto\app\classes\SIGREDIRBO.prg):
*==============================================================================
* SIGREDIRBO.PRG
* Business Object - Demonstrativo de Retencao de Impostos
* CSLL, COFINS e PIS/PASEP
*
* Herda de: RelatorioBase
*==============================================================================

DEFINE CLASS SIGREDIRBO AS RelatorioBase

    *-- Filtros do relatorio
    this_cAnoBase            = ""
    this_cFornec             = ""
    this_cDforn              = ""

    *-- Cursores internos
    this_cCursorEmpresas     = "cursor_4c_Empresas"
    this_cCursorDados        = "cursor_4c_Dados"

    *-- Arquivo de relatorio (sem extensao)
    this_cArquivoFRX         = "sigReDir"
    this_cUltimoArquivoExcel  = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa BO e carrega cursor de empresas para selecao
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult

        loc_lSucesso = .F.

        IF !DODEFAULT()
            THIS.this_cMensagemErro = "Falha na inicializa" + CHR(231) + CHR(227) + "o da classe base"
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT 1 AS Imps, cemps, razas FROM SigCdEmp ORDER BY cemps"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpTmp")

            IF loc_nResult > 0
                *-- Cria cursor local READWRITE para permitir marcacao pelo usuario
                IF USED(THIS.this_cCursorEmpresas)
                    USE IN (THIS.this_cCursorEmpresas)
                ENDIF
                SELECT Imps, cemps, razas FROM cursor_4c_EmpTmp ;
                    INTO CURSOR (THIS.this_cCursorEmpresas) READWRITE
                USE IN cursor_4c_EmpTmp
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao carregar lista de empresas"
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna descricao do ultimo erro ocorrido
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores e recursos alocados
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorEmpresas)
            USE IN (THIS.this_cCursorEmpresas)
        ENDIF
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarEmpresas - Monta clausula WHERE para filtro de empresas selecionadas
    * Retorna string SQL (ex: " AND a.Emps = 'xxx'") ou "" se nenhuma selecionada
    *--------------------------------------------------------------------------
    PROCEDURE MontarEmpresas()
        LOCAL loc_cEmp, loc_cVir

        loc_cEmp = ""
        loc_cVir = ""

        IF !USED(THIS.this_cCursorEmpresas)
            THIS.this_cMensagemErro = "Cursor de empresas n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN ""
        ENDIF

        SELECT cemps FROM (THIS.this_cCursorEmpresas) WHERE Imps = 1 ;
            INTO CURSOR cursor_4c_EmpSel

        DO CASE
            CASE RECCOUNT("cursor_4c_EmpSel") = 0
                USE IN cursor_4c_EmpSel
                THIS.this_cMensagemErro = "Nenhuma empresa foi selecionada."
                RETURN ""

            CASE RECCOUNT("cursor_4c_EmpSel") = 1
                SELECT cursor_4c_EmpSel
                GO TOP
                loc_cEmp = " AND a.Emps = '" + ALLTRIM(cemps) + "'"

            OTHERWISE
                loc_cEmp = " AND a.Emps IN ("
                SELECT cursor_4c_EmpSel
                GO TOP
                SCAN
                    loc_cEmp = loc_cEmp + loc_cVir + "'" + ALLTRIM(cemps) + "'"
                    loc_cVir = ", "
                ENDSCAN
                loc_cEmp = loc_cEmp + ")"
        ENDCASE

        USE IN cursor_4c_EmpSel
        RETURN loc_cEmp
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta SQL UNION ALL (PIS/COFINS/CSLL) e executa query
    * Retorna .T. se dados carregados com sucesso
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_cEmpFilter, loc_cFornecFilter
        LOCAL loc_cDtIni, loc_cDtFin, loc_cAno
        LOCAL loc_cJoins, loc_cWhere
        LOCAL loc_cSelect1, loc_cSelect2, loc_cSelect3

        loc_lSucesso = .F.

        TRY
            *-- Validacao: ano base obrigatorio
            loc_cAno = ALLTRIM(THIS.this_cAnoBase)
            IF EMPTY(loc_cAno)
                THIS.this_cMensagemErro = "Ano base n" + CHR(227) + "o informado."
                loc_lSucesso = .F.
            ENDIF

            *-- Filtro de empresas (valida selecao e monta clausula)
            loc_cEmpFilter = THIS.MontarEmpresas()
            IF EMPTY(loc_cEmpFilter)
                loc_lSucesso = .F.
            ENDIF

            *-- Periodo do exercicio anual
            loc_cDtIni = "'" + loc_cAno + "-01-01'"
            loc_cDtFin = "'" + loc_cAno + "-12-31 23:59:59'"

            *-- Filtro de fornecedor (opcional)
            IF !EMPTY(ALLTRIM(THIS.this_cFornec))
                loc_cFornecFilter = " AND a.clifors = " + EscaparSQL(ALLTRIM(THIS.this_cFornec))
            ELSE
                loc_cFornecFilter = ""
            ENDIF

            *-- Clausulas reutilizaveis
            loc_cJoins = " LEFT JOIN SigCdSrv b WITH (NOLOCK) ON a.codservs = b.codservs" + ;
                         " LEFT JOIN SigCdCli c ON c.iclis = a.clifors" + ;
                         " LEFT JOIN SigCdEmp d ON a.emps = d.cemps"

            loc_cWhere = " WHERE a.emis BETWEEN " + loc_cDtIni + " AND " + loc_cDtFin + ;
                         " AND (a.vpis <> 0 OR a.vcofins <> 0 OR a.vcsll <> 0)" + ;
                         loc_cEmpFilter + loc_cFornecFilter

            *-- SELECT PIS
            loc_cSelect1 = ;
                "SELECT d.razsocs, d.cgcs, a.emis, a.totnotas," + ;
                " a.vpis AS vimposto, b.codpiss AS codservs," + ;
                " a.clifors, c.rclis, c.cpfs AS cnpj" + ;
                " FROM SigMvNfi a WITH (NOLOCK)" + ;
                loc_cJoins + loc_cWhere

            *-- SELECT COFINS
            loc_cSelect2 = ;
                "SELECT d.razsocs, d.cgcs, a.emis, a.totnotas," + ;
                " a.vcofins AS vimposto, b.codcofinss AS codservs," + ;
                " a.clifors, c.rclis, c.cpfs AS cnpj" + ;
                " FROM SigMvNfi a WITH (NOLOCK)" + ;
                loc_cJoins + loc_cWhere

            *-- SELECT CSLL
            loc_cSelect3 = ;
                "SELECT d.razsocs, d.cgcs, a.emis, a.totnotas," + ;
                " a.vcsll AS vimposto, b.codcslls AS codservs," + ;
                " a.clifors, c.rclis, c.cpfs AS cnpj" + ;
                " FROM SigMvNfi a WITH (NOLOCK)" + ;
                loc_cJoins + loc_cWhere

            *-- UNION ALL (PIS + COFINS + CSLL) com ordenacao
            loc_cSQL = loc_cSelect1 + ;
                       " UNION ALL " + loc_cSelect2 + ;
                       " UNION ALL " + loc_cSelect3 + ;
                       " ORDER BY cnpj, clifors, emis, codservs"

            *-- Fechar cursor anterior
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)

            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados do relat" + CHR(243) + "rio"
                loc_lSucesso = .F.
            ENDIF

            SELECT (THIS.this_cCursorDados)
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora (sem dialogo)
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoFRX) TO PRINT NOCONSOLE
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirComPrompt - Prepara dados e abre dialogo de impressao
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirComPrompt()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoFRX) TO PRINT PROMPT NOCONSOLE
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoFRX) PREVIEW NOCONSOLE
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarSelecaoEmpresas - Marca ou desmarca todas as empresas no cursor
    * par_lMarcar: .T. marca todas, .F. desmarca todas
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarSelecaoEmpresas(par_lMarcar)
        LOCAL loc_nValor
        loc_nValor = IIF(par_lMarcar = .T., 1, 0)
        IF USED(THIS.this_cCursorEmpresas)
            SELECT (THIS.this_cCursorEmpresas)
            REPLACE ALL Imps WITH loc_nValor
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarSelecaoEmpresaUnica - Marca/desmarca empresa especifica no cursor
    * par_cCodigoEmp: codigo da empresa (cemps) a alterar
    * par_lMarcar: .T. para marcar (Imps=1), .F. para desmarcar (Imps=0)
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarSelecaoEmpresaUnica(par_cCodigoEmp, par_lMarcar)
        LOCAL loc_lSucesso, loc_nValor, loc_cCodigo
        loc_lSucesso = .F.
        loc_cCodigo = ALLTRIM(par_cCodigoEmp)
        loc_nValor = IIF(par_lMarcar = .T., 1, 0)

        IF EMPTY(loc_cCodigo) OR !USED(THIS.this_cCursorEmpresas)
            RETURN .F.
        ENDIF

        SELECT (THIS.this_cCursorEmpresas)
        LOCATE FOR ALLTRIM(cemps) == loc_cCodigo
        IF FOUND()
            REPLACE Imps WITH loc_nValor
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InserirEmpresaNaSelecao - Adiciona empresa especifica na selecao (Imps=1)
    * Util para pre-selecionar empresas via codigo externo (ex: empresa logada)
    * par_cCodigoEmp: codigo da empresa (cemps) a marcar
    *--------------------------------------------------------------------------
    PROCEDURE InserirEmpresaNaSelecao(par_cCodigoEmp)
        RETURN THIS.AtualizarSelecaoEmpresaUnica(par_cCodigoEmp, .T.)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega valores de filtros da linha atual do cursor
    * Permite restaurar estado de filtros a partir de cursor externo
    * (ex: configuracao salva, parametros de outro form, agendamento)
    * par_cAliasCursor: nome do cursor com campos AnoBase/Fornec/Dforn
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
                THIS.this_cMensagemErro = "Cursor de origem n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            ELSE
                SELECT (par_cAliasCursor)

                IF TYPE("AnoBase") <> "U"
                    THIS.this_cAnoBase = TratarNulo(AnoBase, "C")
                ENDIF

                IF TYPE("Fornec") <> "U"
                    THIS.this_cFornec = TratarNulo(Fornec, "C")
                ENDIF

                IF TYPE("Dforn") <> "U"
                    THIS.this_cDforn = TratarNulo(Dforn, "C")
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExportarExcel - Prepara dados e exporta cursor para arquivo XLS
    *   Retorna .T. se exportacao bem-sucedida
    *   this_cUltimoArquivoExcel recebe caminho do arquivo gerado
    *--------------------------------------------------------------------------
    PROCEDURE ExportarExcel()
        LOCAL loc_lSucesso, loc_cArquivo, loc_cData
        loc_lSucesso = .F.
        THIS.this_cUltimoArquivoExcel = ""

        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            loc_cData    = TRANSFORM(YEAR(DATE())) + ;
                           RIGHT("0" + TRANSFORM(MONTH(DATE())), 2) + ;
                           RIGHT("0" + TRANSFORM(DAY(DATE())), 2)
            loc_cArquivo = SYS(5) + CURDIR() + "sigReDir_" + loc_cData + ".xls"

            SELECT (THIS.this_cCursorDados)
            COPY TO (loc_cArquivo) TYPE XLS

            THIS.this_cUltimoArquivoExcel = loc_cArquivo
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave logica do relatorio (ano base + cnpj fornec)
    * Usado por RegistrarAuditoria para identificar a execucao
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ALLTRIM(THIS.this_cAnoBase)
        IF !EMPTY(ALLTRIM(THIS.this_cFornec))
            loc_cChave = loc_cChave + "|" + ALLTRIM(THIS.this_cFornec)
        ENDIF
        RETURN loc_cChave
    ENDPROC

ENDDEFINE

