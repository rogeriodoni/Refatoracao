# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS

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
  ControlSource = "crSigCdNcf.Descs"
  ControlSource = "crSigCdNcf.Cods"
  ControlSource = "crSigCdNcf.fixos"
  ControlSource = "crSigCdNcf.tipos"
  ControlSource = "crSigCdNcf.Emps"
lcQuerLista = [Select * From SigCdNcf Where Emps = ']+_Empr+[' Or Emps = ' ' ]
Select crSigCdNcf
Select crSigCdNcf

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormNcf.prg) - TRECHOS RELEVANTES PARA PASS SQL (1128 linhas total):

*-- Linhas 356 a 374:
356:             .HighlightBackColor = RGB(255, 255, 255)
357:             .HighlightForeColor = RGB(15, 41, 104)
358:             .HighlightStyle     = 2
359:             .DeleteMark         = .F.
360:             .RecordMark         = .F.
361:             .RowHeight          = 16
362:             .ScrollBars         = 2
363:             .ReadOnly           = .T.
364:             .Visible            = .T.
365:         ENDWITH
366: 
367:         THIS.TornarControlesVisiveis(loc_oPg1)
368:     ENDPROC
369: 
370:     *--------------------------------------------------------------------------
371:     * ConfigurarPaginaDados - Configura Page2: botoes + campos Codigo e Descricao
372:     *--------------------------------------------------------------------------
373:     PROTECTED PROCEDURE ConfigurarPaginaDados()
374:         LOCAL loc_oPg2, loc_oSalva

*-- Linhas 687 a 706:
687:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
688:                     loc_oGrid.ColumnCount = 2
689:                     loc_oGrid.RecordSource          = "cursor_4c_Dados"
690:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cods"
691:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
692:                     loc_oGrid.Column1.Width         = 80
693:                     loc_oGrid.Column2.Width         = 290
694:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
695:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
696:                     THIS.FormatarGridLista(loc_oGrid)
697:                     loc_lResultado = .T.
698:                 ENDIF
699:             ENDIF
700:         CATCH TO loc_oErro
701:             MsgErro(loc_oErro.Message, "FormNcf.CarregarLista")
702:         ENDTRY
703: 
704:         RETURN loc_lResultado
705:     ENDPROC
706: 

*-- Linhas 757 a 775:
757:         loc_cCodigo = ""
758: 
759:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
760:             SELECT cursor_4c_Dados
761:             loc_cCodigo = ALLTRIM(cods)
762:         ENDIF
763: 
764:         IF EMPTY(loc_cCodigo)
765:             MsgAviso("Selecione um registro na lista.", "Visualizar")
766:             RETURN
767:         ENDIF
768: 
769:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
770:             THIS.this_cModoAtual = "VISUALIZAR"
771:             THIS.HabilitarCampos(.F.)
772:             THIS.BOParaForm()
773:             THIS.AjustarBotoesPorModo()
774:             THIS.AlternarPagina(2)
775:         ENDIF

*-- Linhas 783 a 801:
783:         loc_cCodigo = ""
784: 
785:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
786:             SELECT cursor_4c_Dados
787:             loc_cCodigo = ALLTRIM(cods)
788:         ENDIF
789: 
790:         IF EMPTY(loc_cCodigo)
791:             MsgAviso("Selecione um registro na lista.", "Alterar")
792:             RETURN
793:         ENDIF
794: 
795:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
796:             THIS.this_oBusinessObject.EditarRegistro()
797:             THIS.this_cModoAtual = "ALTERAR"
798:             THIS.HabilitarCampos(.T.)
799:             THIS.BOParaForm()
800:             THIS.AjustarBotoesPorModo()
801:             THIS.AlternarPagina(2)

*-- Linhas 812 a 830:
812:         loc_cDescricao = ""
813: 
814:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
815:             SELECT cursor_4c_Dados
816:             loc_cCodigo    = ALLTRIM(cods)
817:             loc_cDescricao = ALLTRIM(descs)
818:         ENDIF
819: 
820:         IF EMPTY(loc_cCodigo)
821:             MsgAviso("Selecione um registro na lista.", "Excluir")
822:             RETURN
823:         ENDIF
824: 
825:         loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o da N" + CHR(227) + "o-Conformidade?" + ;
826:                                     CHR(13) + CHR(13) + ;
827:                                     "C" + CHR(243) + "digo: " + loc_cCodigo + CHR(13) + ;
828:                                     "Descri" + CHR(231) + CHR(227) + "o: " + loc_cDescricao, ;
829:                                     "Confirmar Exclus" + CHR(227) + "o")
830: 

*-- Linhas 852 a 871:
852:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
853:             loc_oGrid.ColumnCount = 2
854:             loc_oGrid.RecordSource          = "cursor_4c_Dados"
855:             loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cods"
856:             loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
857:             loc_oGrid.Column1.Width         = 80
858:             loc_oGrid.Column2.Width         = 290
859:             loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
860:             loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
861:             THIS.FormatarGridLista(loc_oGrid)
862:             loc_oGrid.Refresh()
863:         ENDIF
864:     ENDPROC
865: 
866:     *--------------------------------------------------------------------------
867:     * BtnEncerrarClick - Fecha o formulario
868:     *--------------------------------------------------------------------------
869:     PROCEDURE BtnEncerrarClick()
870:         THIS.Release()
871:     ENDPROC

*-- Linhas 967 a 986:
967:         ENDIF
968: 
969:         TRY
970:             loc_nResult = SQLEXEC(gnConnHandle, ;
971:                 "SELECT CEmps FROM SigCdEmp WHERE CEmps = " + EscaparSQL(loc_cValor), ;
972:                 "cursor_4c_ValidaEmp")
973: 
974:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ValidaEmp") > 0
975:                 loc_lEncontrou = .T.
976:             ENDIF
977:         CATCH TO loc_oErro
978:             MsgErro(loc_oErro.Message, "FormNcf.ValidarEmpPad")
979:         ENDTRY
980: 
981:         IF USED("cursor_4c_ValidaEmp")
982:             USE IN cursor_4c_ValidaEmp
983:         ENDIF
984: 
985:         IF !loc_lEncontrou
986:             THIS.AbrirLookupEmpPad()

*-- Linhas 999 a 1034:
999:         ENDIF
1000: 
1001:         TRY
1002:             loc_nResult = SQLEXEC(gnConnHandle, ;
1003:                 "SELECT CEmps, Razas FROM SigCdEmp ORDER BY CEmps", ;
1004:                 "cursor_4c_BuscaEmp")
1005: 
1006:             IF loc_nResult < 0
1007:                 MsgErro("Erro ao carregar empresas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1008:             ELSE
1009:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1010: 
1011:                 IF VARTYPE(loc_oBusca) = "O"
1012:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmp"
1013:                     loc_oBusca.this_cTitulo        = "Empresas"
1014:                     loc_oBusca.mAddColuna("CEmps", "", "C" + CHR(243) + "digo")
1015:                     loc_oBusca.mAddColuna("Razas", "", "Descri" + CHR(231) + CHR(227) + "o")
1016:                     loc_oBusca.Show()
1017: 
1018:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
1019:                         SELECT cursor_4c_BuscaEmp
1020:                         loc_oPg2.txt_4c_EmpPad.Value = ALLTRIM(CEmps)
1021:                     ENDIF
1022: 
1023:                     loc_oBusca.Release()
1024:                 ENDIF
1025:             ENDIF
1026:         CATCH TO loc_oErro
1027:             MsgErro(loc_oErro.Message, "FormNcf.AbrirLookupEmpPad")
1028:         ENDTRY
1029: 
1030:         IF USED("cursor_4c_BuscaEmp")
1031:             USE IN cursor_4c_BuscaEmp
1032:         ENDIF
1033:     ENDPROC
1034: 


### BO (C:\4c\projeto\app\classes\NcfBO.prg):
*==============================================================================
* NcfBO.prg - Business Object para Nao-Conformidades
* Tabela: SigCdNcf
* Migrado de: SIGCDNCF.SCX (frmcadastro)
*==============================================================================
DEFINE CLASS NcfBO AS BusinessBase

    *-- Propriedades (this_* -> coluna SQL)
    this_cCodigo    = ""    && cods  char(10)  PK
    this_cDescricao = ""    && descs char(60)
    this_nFixos     = 2     && fixos numeric(1,0)  1=Sim / 2=Nao (Descricao Fixa)
    this_nTipos     = 1     && tipos numeric(1,0)  1=Nao Conforme / 2=Limite Qtd / 3=Variacao Peso / 4=Reposicao S/Composicao
    this_cEmps      = ""    && emps  char(3)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdNcf"
        THIS.this_cCampoChave = "cods"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - SELECT lista de registros para o grid
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cods, descs, fixos, tipos, emps" + ;
                       " FROM SigCdNcf" + ;
                       " WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                       " OR emps = ' '" + ;
                       " ORDER BY cods"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar N" + CHR(227) + "o-Conformidades:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao buscar N" + CHR(227) + "o-Conformidades:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pelo codigo (PK)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cods, descs, fixos, tipos, emps" + ;
                       " FROM SigCdNcf" + ;
                       " WHERE cods = " + EscaparSQL(par_cCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MsgErro("Erro ao carregar N" + CHR(227) + "o-Conformidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao carregar N" + CHR(227) + "o-Conformidade:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo    = TratarNulo(cods,  "C")
            THIS.this_cDescricao = TratarNulo(descs, "C")
            THIS.this_nFixos     = TratarNulo(fixos, "N")
            THIS.this_nTipos     = TratarNulo(tipos, "N")
            THIS.this_cEmps      = TratarNulo(emps,  "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da PK para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdNcf (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdNcf (cods, descs, fixos, tipos, emps)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigo) + ", " + ;
                       EscaparSQL(THIS.this_cDescricao) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nFixos) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTipos) + ", " + ;
                       EscaparSQL(THIS.this_cEmps) + ;
                       ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir N" + CHR(227) + "o-Conformidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao inserir N" + CHR(227) + "o-Conformidade:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdNcf (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdNcf SET" + ;
                       " descs = " + EscaparSQL(THIS.this_cDescricao) + "," + ;
                       " fixos = " + FormatarNumeroSQL(THIS.this_nFixos) + "," + ;
                       " tipos = " + FormatarNumeroSQL(THIS.this_nTipos) + "," + ;
                       " emps  = " + EscaparSQL(THIS.this_cEmps) + ;
                       " WHERE cods = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar N" + CHR(227) + "o-Conformidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao atualizar N" + CHR(227) + "o-Conformidade:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigCdNcf (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdNcf" + ;
                       " WHERE cods = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Delete")

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir N" + CHR(227) + "o-Conformidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao excluir N" + CHR(227) + "o-Conformidade:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

