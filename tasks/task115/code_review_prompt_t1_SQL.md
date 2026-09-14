# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CGRUS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMICHQS, ICLIS, CONTAS, GRUPOS, EMPS, DOPES, NUMES, NOPERS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DGRUS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMICHQS, ICLIS, CONTAS, GRUPOS, EMPS, DOPES, NUMES, NOPERS

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
lcSql=[Select Distinct b.Iclis, b.Rclis ]+;
      [From SigOpFp a,SigCdCli b ]+;
ThisForm.podatamgr.SqlExecute(lcSql,"crTmpContas0")
Select Iclis,;
  From crTmpContas0 ;
Select crContas
Insert Into crContas (Iclis,Rclis) Values ('','')
= Seek('','crContas','Iclis')
lcSql = [Select * ] + ;
		  [From SigCqChi ] + ;
ThisForm.podatamgr.SqlExecute(lcSql,"crSigCqChi")
Select crSigCqChi
		Insert Into Resultado ( NCopias, Favos, Valors, Vencs, Datas, Emps, Dopes, MascNum,;
		lcSql=[Select * From SigCdPit Where Emps = ']+crSigCqChi.Emps+;
		ThisForm.poDatamgr.SqlExecute(lcSql,"crSigCdPit")
		Select crSigCdPit
				lcSql=[Select * From SigMvPar Where Emps = ']+crSigCdPit.Empos+;
				ThisForm.podatamgr.SqlExecute(lcSql,"crSigMvPar")
				SELECT crSigMvPar
				lcSql=[Select * From SigMvCcr Where Emps = ']+crSigCdPit.Empos+;
				ThisForm.podatamgr.SqlExecute(lcSql,"crSigMvCcr")
				SELECT crSigMvCcr
			Insert Into Resultado ( NCopias, Favos, Valors, Vencs, Datas, Hists, Moedas, Emps, ;
		Select crSigCdPit
	Select crSigCqChi
Select Resultado
		Select Resultado

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrehtc.prg) - TRECHOS RELEVANTES PARA PASS SQL (1254 linhas total):

*-- Linhas 798 a 826:
798:             RETURN
799:         ENDIF
800: 
801:         loc_cSQL = "SELECT cgrus, dgrus FROM SigCdGrp" + ;
802:             " WHERE cgrus = " + EscaparSQL(loc_cCodigo)
803: 
804:         IF USED("cursor_4c_GrpVal")
805:             USE IN cursor_4c_GrpVal
806:         ENDIF
807: 
808:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrpVal")
809: 
810:         IF loc_nResult > 0
811:             SELECT cursor_4c_GrpVal
812:             IF !EOF()
813:                 THIS.txt_4c_DsGrEstoque.Value   = ALLTRIM(dgrus)
814:                 THIS.txt_4c_DsGrEstoque.Enabled = .F.
815:                 USE IN cursor_4c_GrpVal
816:                 RETURN
817:             ENDIF
818:             USE IN cursor_4c_GrpVal
819:         ENDIF
820: 
821:         MsgAviso("Grupo de estoque n" + CHR(227) + "o encontrado: " + loc_cCodigo, "Aviso")
822:         THIS.txt_4c_CdGrEstoque.Value   = ""
823:         THIS.txt_4c_DsGrEstoque.Value   = ""
824:         THIS.txt_4c_DsGrEstoque.Enabled = .T.
825:         THIS.txt_4c_CdGrEstoque.SetFocus()
826:     ENDPROC

*-- Linhas 842 a 870:
842:             RETURN
843:         ENDIF
844: 
845:         loc_cSQL = "SELECT cgrus, dgrus FROM SigCdGrp" + ;
846:             " WHERE dgrus = " + EscaparSQL(loc_cDesc)
847: 
848:         IF USED("cursor_4c_GrpDsVal")
849:             USE IN cursor_4c_GrpDsVal
850:         ENDIF
851: 
852:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrpDsVal")
853: 
854:         IF loc_nResult > 0
855:             SELECT cursor_4c_GrpDsVal
856:             IF !EOF()
857:                 THIS.txt_4c_CdGrEstoque.Value   = ALLTRIM(cgrus)
858:                 THIS.txt_4c_DsGrEstoque.Value   = ALLTRIM(dgrus)
859:                 THIS.txt_4c_DsGrEstoque.Enabled = .F.
860:                 USE IN cursor_4c_GrpDsVal
861:                 RETURN
862:             ENDIF
863:             USE IN cursor_4c_GrpDsVal
864:         ENDIF
865: 
866:         MsgAviso("Grupo de estoque n" + CHR(227) + "o encontrado.", "Aviso")
867:         THIS.txt_4c_CdGrEstoque.Value   = ""
868:         THIS.txt_4c_DsGrEstoque.Value   = ""
869:         THIS.txt_4c_DsGrEstoque.Enabled = .T.
870:         THIS.txt_4c_DsGrEstoque.SetFocus()

*-- Linhas 976 a 1003:
976:         ENDIF
977: 
978:         IF USED("cursor_4c_Contas")
979:             loc_nArea = SELECT()
980:             SELECT cursor_4c_Contas
981:             LOCATE FOR ALLTRIM(Iclis) = loc_cCodigo
982:             IF FOUND()
983:                 THIS.txt_4c_DsContas.Value   = ALLTRIM(Rclis)
984:                 THIS.txt_4c_DsContas.Enabled = .F.
985:                 SELECT (loc_nArea)
986:                 RETURN
987:             ENDIF
988:             SELECT (loc_nArea)
989:         ENDIF
990: 
991:         THIS.AbrirLookupContas()
992:     ENDPROC
993: 
994:     *==========================================================================
995:     * VALIDARDSCONTAS - Valida descricao da conta (busca reversa por nome)
996:     * Somente ativo quando CdContas estiver vazio (comportamento When original)
997:     * Se nao encontrado, abre lookup FormBuscaAuxiliar
998:     *==========================================================================
999:     PROCEDURE ValidarDsContas()
1000:         LOCAL loc_cDesc, loc_nArea
1001: 
1002:         IF !EMPTY(ALLTRIM(THIS.txt_4c_CdContas.Value))
1003:             RETURN

*-- Linhas 1011 a 1039:
1011:         ENDIF
1012: 
1013:         IF USED("cursor_4c_Contas")
1014:             loc_nArea = SELECT()
1015:             SELECT cursor_4c_Contas
1016:             LOCATE FOR UPPER(ALLTRIM(Rclis)) = UPPER(loc_cDesc)
1017:             IF FOUND()
1018:                 THIS.txt_4c_CdContas.Value   = ALLTRIM(Iclis)
1019:                 THIS.txt_4c_DsContas.Value   = ALLTRIM(Rclis)
1020:                 THIS.txt_4c_DsContas.Enabled = .F.
1021:                 SELECT (loc_nArea)
1022:                 RETURN
1023:             ENDIF
1024:             SELECT (loc_nArea)
1025:         ENDIF
1026: 
1027:         THIS.AbrirLookupContas()
1028:     ENDPROC
1029: 
1030:     *==========================================================================
1031:     * ABRIRLOOKUPCONTAS - Abre FormBuscaAuxiliar para conta corrente
1032:     * Tabela: SigCdCli | Iclis (cod) | Rclis (nome/razao social)
1033:     *==========================================================================
1034:     PROCEDURE AbrirLookupContas()
1035:         LOCAL loc_oBusca, loc_cCodigo, loc_cDescricao
1036: 
1037:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1038:             "SigCdCli", ;
1039:             "cursor_4c_BuscaContas", ;


### BO (C:\4c\projeto\app\classes\sigrehtcBO.prg):
*==============================================================================
* SIGREHTCBO.PRG
* Business Object para Relatorio de Cheques Emitidos (SIGREHTC)
* Herda de: RelatorioBase
*
* Filtros disponiveis (mapeados do codigo legado):
*   - Periodo (data inicial / data final) + tipo (Movimentacao ou Vencimento)
*   - Grupo de estoque/contabil (codigo + descricao)
*   - Conta (codigo Iclis + descricao)
*   - Opcoes de selecao: Emitido, Cancelado, Ordem, Baixados
*
* Tabela principal: SigCqChi
* Tabelas auxiliares: SigCdCli, SigOpFp, SigCdPit, SigMvPar, SigMvCcr
*==============================================================================

DEFINE CLASS sigrehtcBO AS RelatorioBase

    *-- Filtros de periodo
    this_dDtInicial     = {}
    this_dDtFinal       = {}

    *-- Tipo de data: 1=Movimentacao, 2=Vencimento (optDatas)
    this_nTpDat         = 1

    *-- Grupo de estoque / contabil (getCdGrEstoque / getDsGrEstoque)
    this_cGrupo         = ""
    this_cDsGrupo       = ""

    *-- Conta corrente (getCdContas / getDsContas) - Iclis no banco
    this_cIclis         = ""
    this_cDsContas      = ""

    *-- Op_Emitido: 1=Emitido, 2=Nao Emitido, 3=Todos
    this_nOpEmitido     = 1

    *-- Op_Cancelado: 1=Validos, 2=Cancelados, 3=Todos
    this_nOpCancela     = 1

    *-- Op_Ordem: 1=por Copia, 2=por Data, 3=por Conta
    this_nOpOrdem       = 1

    *-- Op_Baixados: 1=Sim, 2=Nao
    this_nOpBaixas      = 1

    *-- Nome do cursor de resultado gerado por PrepararDados()
    this_cCursorDados   = "cursor_4c_Resultado"

    *--------------------------------------------------------------------------
    * Init - Configura tabela principal e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCqChi"
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa queries e monta cursor para o relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cSQL, loc_cOrdem
        LOCAL loc_cDtInicial, loc_cDtFinal
        LOCAL loc_cGrupos, loc_cContas
        LOCAL loc_cTitulo1, loc_cPeriodo, loc_cOrdemDesc, loc_cEmp
        LOCAL loc_nResult
        LOCAL loc_cFavor, loc_cHists, loc_cMoedas
        LOCAL loc_nCopia

        loc_lSucesso = .F.

        TRY
            loc_cEmp = go_4c_Sistema.cEmpresa

            *-- Titulo principal do relatorio
            loc_cTitulo1 = "Relat" + CHR(243) + "rio de Cheques Emitidos de " + ;
                DTOC(THIS.this_dDtInicial) + " " + CHR(224) + " " + ;
                DTOC(THIS.this_dDtFinal) + " - " + ;
                IIF(THIS.this_nTpDat = 1, ;
                    "Movimenta" + CHR(231) + CHR(227) + "o", ;
                    "Vencimento")

            *-- Linha descritiva de grupo/conta para o relatorio
            IF !EMPTY(THIS.this_cGrupo)
                loc_cPeriodo = "Grupo : " + ALLTRIM(THIS.this_cGrupo) + ;
                    " - " + ALLTRIM(THIS.this_cDsGrupo) + " - "
            ELSE
                loc_cPeriodo = "Grupo : Todos - "
            ENDIF

            IF !EMPTY(THIS.this_cIclis)
                loc_cPeriodo = loc_cPeriodo + "Conta : " + ;
                    ALLTRIM(THIS.this_cIclis) + " - " + ALLTRIM(THIS.this_cDsContas)
            ELSE
                loc_cPeriodo = loc_cPeriodo + "Conta : Todas"
            ENDIF

            *-- Descricao da ordem de impressao
            loc_cOrdemDesc = "Emiss" + CHR(227) + "o em Ordem de " + ;
                IIF(THIS.this_nOpOrdem = 1, ;
                    "N" + CHR(250) + "mero de C" + CHR(243) + "pia", ;
                    IIF(THIS.this_nOpOrdem = 2, "Data", "Conta"))

            *-- Datas formatadas para SQL
            loc_cDtInicial = FormatarDataSQL(THIS.this_dDtInicial)
            loc_cDtFinal   = "'" + ;
                PADL(ALLTRIM(STR(YEAR(THIS.this_dDtFinal),  4, 0)), 4, "0") + "-" + ;
                PADL(ALLTRIM(STR(MONTH(THIS.this_dDtFinal), 2, 0)), 2, "0") + "-" + ;
                PADL(ALLTRIM(STR(DAY(THIS.this_dDtFinal),   2, 0)), 2, "0") + ;
                " 23:59:59'"

            *-- Campo de data e clausulas opcionais
            loc_cOrdem  = IIF(THIS.this_nTpDat = 1, "Datas", "Vencs")
            loc_cContas = IIF(EMPTY(THIS.this_cIclis), "", ;
                " AND Contas = " + EscaparSQL(THIS.this_cIclis))
            loc_cGrupos = IIF(EMPTY(THIS.this_cGrupo), "", ;
                " AND Grupos = " + EscaparSQL(THIS.this_cGrupo))

            *-- Query principal em SigCqChi
            loc_cSQL = "SELECT * FROM SigCqChi" + ;
                " WHERE " + loc_cOrdem + ;
                " BETWEEN " + loc_cDtInicial + " AND " + loc_cDtFinal + ;
                loc_cGrupos + loc_cContas + ;
                " ORDER BY " + loc_cOrdem

            IF USED("cursor_4c_SigCqChi")
                USE IN cursor_4c_SigCqChi
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCqChi")

            IF loc_nResult >= 0
                *-- Recria cursor de resultado com estrutura identica ao original
                IF USED("cursor_4c_Resultado")
                    USE IN cursor_4c_Resultado
                ENDIF

                CREATE CURSOR cursor_4c_Resultado ( ;
                    NCopias   N(6,0),  ;
                    Favos     C(40),   ;
                    Valors    N(12,2), ;
                    Vencs     D,       ;
                    Datas     D,       ;
                    Hists     C(60),   ;
                    Valos     N(12,2), ;
                    Emps      C(3),    ;
                    Dopes     C(20),   ;
                    MascNum   C(6),    ;
                    Cheques   C(26),   ;
                    Cancelas  L,       ;
                    Moedas    C(3),    ;
                    Periodos  C(254),  ;
                    cEmpresas C(50),   ;
                    Grupos    C(10),   ;
                    Contas    C(10),   ;
                    Titulo1s  C(254),  ;
                    Ordem     C(254),  ;
                    Saltar    C(20),   ;
                    Total     L,       ;
                    Baixas    N(1,0),  ;
                    TotCon    N(12,4)  ;
                )

                *-- Indice conforme ordem selecionada
                DO CASE
                    CASE THIS.this_nOpOrdem = 1
                        INDEX ON STR(NCopias, 6) TAG Ncopias
                    CASE THIS.this_nOpOrdem = 2
                        IF THIS.this_nTpDat = 1
                            INDEX ON DTOS(Datas) + STR(NCopias, 6) TAG DataNCop
                        ELSE
                            INDEX ON DTOS(Vencs) + STR(NCopias, 6) TAG DataNCop
                        ENDIF
                    CASE THIS.this_nOpOrdem = 3
                        IF THIS.this_nTpDat = 1
                            INDEX ON Grupos + Contas + Cheques + ;
                                DTOS(Datas) + STR(NCopias, 6) TAG GruConDat
                        ELSE
                            INDEX ON Grupos + Contas + Cheques + ;
                                DTOS(Vencs) + STR(NCopias, 6) TAG GruConDat
                        ENDIF
                ENDCASE

                *-- Percorre SigCqChi e popula cursor de resultado
                SELECT cursor_4c_SigCqChi
                SCAN
                    *-- Filtro cancelamento/emissao
                    IF (THIS.this_nOpCancela = 1 .AND. ;
                            (cursor_4c_SigCqChi.Cancelas .OR. !cursor_4c_SigCqChi.Emitidos)) .OR. ;
                       (THIS.this_nOpCancela = 2 .AND. ;
                            (cursor_4c_SigCqChi.Emitidos .OR. !cursor_4c_SigCqChi.Cancelas))
                        LOOP
                    ENDIF

                    IF cursor_4c_SigCqChi.Cancelas
                        *-- Cancelado: insere sem busca de historico
                        INSERT INTO cursor_4c_Resultado ;
                            (NCopias, Favos, Valors, Vencs, Datas, ;
                             Emps, Dopes, MascNum, Cheques, Cancelas, ;
                             Periodos, cEmpresas, Grupos, Contas, ;
                             Titulo1s, Ordem, Saltar, Total, Baixas) ;
                        VALUES ;
                            (cursor_4c_SigCqChi.NCopias, ;
                             cursor_4c_SigCqChi.Favos, ;
                             cursor_4c_SigCqChi.Valors, ;
                             IIF(ISNULL(cursor_4c_SigCqChi.Vencs), {}, TTOD(cursor_4c_SigCqChi.Vencs)), ;
                             IIF(ISNULL(cursor_4c_SigCqChi.Datas), {}, TTOD(cursor_4c_SigCqChi.Datas)), ;
                             cursor_4c_SigCqChi.Emps, ;
                             cursor_4c_SigCqChi.Dopes, ;
                             PADL(ALLTRIM(STR(cursor_4c_SigCqChi.Numes, 6, 0)), 6, "0"), ;
                             cursor_4c_SigCqChi.Bancos + "-" + cursor_4c_SigCqChi.Agencias + ;
                                 "-" + cursor_4c_SigCqChi.Ncontas + ;
                                 "-" + cursor_4c_SigCqChi.NCheques, ;
                             cursor_4c_SigCqChi.Cancelas, ;
                             loc_cPeriodo, ;
                             loc_cEmp, ;
                             cursor_4c_SigCqChi.Grupos, ;
                             cursor_4c_SigCqChi.Contas, ;
                             loc_cTitulo1, ;
                             loc_cOrdemDesc, ;
                             IIF(THIS.this_nOpOrdem = 3, ;
                                 cursor_4c_SigCqChi.Grupos + cursor_4c_SigCqChi.Contas, ;
                                 ""), ;
                             (THIS.this_nOpOrdem = 3), ;
                             THIS.this_nOpBaixas)
                    ELSE
                        *-- Nao cancelado: busca historico em SigCdPit
                        loc_cFavor = cursor_4c_SigCqChi.Favos

                        loc_cSQL = "SELECT * FROM SigCdPit" + ;
                            " WHERE Emps = " + EscaparSQL(cursor_4c_SigCqChi.Emps) + ;
                            " AND Dopes = " + EscaparSQL(cursor_4c_SigCqChi.Dopes) + ;
                            " AND Numes = " + FormatarNumeroSQL(cursor_4c_SigCqChi.Numes)

                        IF USED("cursor_4c_SigCdPit")
                            USE IN cursor_4c_SigCdPit
                        ENDIF

                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPit")

                        IF loc_nResult > 0
                            SELECT cursor_4c_SigCdPit
                            SCAN
                                IF cursor_4c_SigCdPit.Tipos = "P"
                                    loc_cSQL = "SELECT * FROM SigMvPar" + ;
                                        " WHERE Emps = " + EscaparSQL(cursor_4c_SigCdPit.Empos) + ;
                                        " AND Nopers = " + FormatarNumeroSQL(cursor_4c_SigCdPit.Nopers)

                                    IF USED("cursor_4c_SigMvPar")
                                        USE IN cursor_4c_SigMvPar
                                    ENDIF

                                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigMvPar")

                                    IF loc_nResult > 0
                                        SELECT cursor_4c_SigMvPar
                                        loc_cHists  = LEFT( ;
                                            cursor_4c_SigMvPar.Emps + ;
                                            ALLTRIM(cursor_4c_SigMvPar.Dopes) + " " + ;
                                            ALLTRIM(PADL(ALLTRIM(STR(cursor_4c_SigMvPar.Numes, 6, 0)), 6, "0")) + ;
                                            " ( " + ALLTRIM(cursor_4c_SigMvPar.Fpags) + " ) ", 60)
                                        loc_cMoedas = cursor_4c_SigMvPar.Moefpgs
                                    ELSE
                                        loc_cHists  = ""
                                        loc_cMoedas = ""
                                    ENDIF
                                ELSE
                                    loc_cSQL = "SELECT * FROM SigMvCcr" + ;
                                        " WHERE Emps = " + EscaparSQL(cursor_4c_SigCdPit.Empos) + ;
                                        " AND Nopers = " + FormatarNumeroSQL(cursor_4c_SigCdPit.Nopers)

                                    IF USED("cursor_4c_SigMvCcr")
                                        USE IN cursor_4c_SigMvCcr
                                    ENDIF

                                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigMvCcr")

                                    IF loc_nResult > 0
                                        SELECT cursor_4c_SigMvCcr
                                        loc_cHists  = NVL(cursor_4c_SigMvCcr.Hists, "")
                                        loc_cMoedas = cursor_4c_SigMvCcr.Moedas
                                    ELSE
                                        loc_cHists  = ""
                                        loc_cMoedas = ""
                                    ENDIF
                                ENDIF

                                INSERT INTO cursor_4c_Resultado ;
                                    (NCopias, Favos, Valors, Vencs, Datas, ;
                                     Hists, Moedas, Emps, Dopes, MascNum, ;
                                     Cheques, Valos, Cancelas, Periodos, ;
                                     cEmpresas, Grupos, Contas, Titulo1s, ;
                                     Ordem, Saltar, Total, Baixas) ;
                                VALUES ;
                                    (cursor_4c_SigCqChi.NCopias, ;
                                     loc_cFavor, ;
                                     cursor_4c_SigCqChi.Valors, ;
                                     IIF(ISNULL(cursor_4c_SigCqChi.Vencs), {}, ;
                                         TTOD(cursor_4c_SigCqChi.Vencs)), ;
                                     IIF(ISNULL(cursor_4c_SigCqChi.Datas), {}, ;
                                         TTOD(cursor_4c_SigCqChi.Datas)), ;
                                     loc_cHists, ;
                                     loc_cMoedas, ;
                                     cursor_4c_SigCqChi.Emps, ;
                                     cursor_4c_SigCqChi.Dopes, ;
                                     PADL(ALLTRIM(STR(cursor_4c_SigCqChi.Numes, 6, 0)), 6, "0"), ;
                                     cursor_4c_SigCqChi.Bancos + "-" + ;
                                         cursor_4c_SigCqChi.Agencias + "-" + ;
                                         cursor_4c_SigCqChi.Ncontas + "-" + ;
                                         cursor_4c_SigCqChi.NCheques, ;
                                     cursor_4c_SigCdPit.Acertos, ;
                                     cursor_4c_SigCqChi.Cancelas, ;
                                     loc_cPeriodo, ;
                                     loc_cEmp, ;
                                     cursor_4c_SigCqChi.Grupos, ;
                                     cursor_4c_SigCqChi.Contas, ;
                                     loc_cTitulo1, ;
                                     loc_cOrdemDesc, ;
                                     IIF(THIS.this_nOpOrdem = 3, ;
                                         cursor_4c_SigCqChi.Grupos + cursor_4c_SigCqChi.Contas, ;
                                         ""), ;
                                     (THIS.this_nOpOrdem = 3), ;
                                     THIS.this_nOpBaixas)

                                loc_cFavor = ""
                                SELECT cursor_4c_SigCdPit
                            ENDSCAN
                        ENDIF
                    ENDIF
                    SELECT cursor_4c_SigCqChi
                ENDSCAN

                *-- Calculo TotCon para ordem por Conta
                SELECT cursor_4c_Resultado
                GO TOP

                IF THIS.this_nOpOrdem = 3
                    loc_nCopia = 0
                    DO WHILE !EOF()
                        IF loc_nCopia != NCopias
                            loc_nCopia = NCopias
                            REPLACE TotCon WITH Valors
                        ENDIF
                        SKIP
                    ENDDO
                    GO TOP
                ENDIF

                *-- Limpa cursores auxiliares
                IF USED("cursor_4c_SigCqChi")
                    USE IN cursor_4c_SigCqChi
                ENDIF
                IF USED("cursor_4c_SigCdPit")
                    USE IN cursor_4c_SigCdPit
                ENDIF
                IF USED("cursor_4c_SigMvPar")
                    USE IN cursor_4c_SigMvPar
                ENDIF
                IF USED("cursor_4c_SigMvCcr")
                    USE IN cursor_4c_SigMvCcr
                ENDIF

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar cheques de SigCqChi"
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "PrepararDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro, loc_cFrx
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                SELECT (THIS.this_cCursorDados)

                IF !EOF()
                    loc_cFrx = gc_4c_CaminhoBase + "reports\SigReHtc.frx"

                    IF !FILE(loc_cFrx)
                        THIS.this_cMensagemErro = "Arquivo de relat" + CHR(243) + ;
                            "rio n" + CHR(227) + "o encontrado: " + loc_cFrx
                        MsgAviso(THIS.this_cMensagemErro, "Aviso")
                    ELSE
                        REPORT FORM (loc_cFrx) TO PRINTER PROMPT NOCONSOLE
                        loc_lSucesso = .T.
                    ENDIF
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Imprimir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe preview do relatorio na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro, loc_cFrx
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                SELECT (THIS.this_cCursorDados)

                IF !EOF()
                    loc_cFrx = gc_4c_CaminhoBase + "reports\SigReHtc.frx"

                    IF !FILE(loc_cFrx)
                        THIS.this_cMensagemErro = "Arquivo de relat" + CHR(243) + ;
                            "rio n" + CHR(227) + "o encontrado: " + loc_cFrx
                        MsgAviso(THIS.this_cMensagemErro, "Aviso")
                    ELSE
                        REPORT FORM (loc_cFrx) PREVIEW NOCONSOLE
                        loc_lSucesso = .T.
                    ENDIF
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Visualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarContas - Popula cursor de contas para lookup no form
    * Substitui o crContas do Init() legado
    *--------------------------------------------------------------------------
    PROCEDURE BuscarContas()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT DISTINCT b.iclis, b.rclis" + ;
                " FROM SigOpFp a, SigCdCli b" + ;
                " WHERE a.emichqs = 1 AND b.iclis = a.contads" + ;
                " ORDER BY b.iclis"

            IF USED("cursor_4c_Contas")
                USE IN cursor_4c_Contas
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Contas")

            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar lista de contas"
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "BuscarContas")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExportarExcel - Prepara dados e exporta para arquivo XLS
    *--------------------------------------------------------------------------
    PROCEDURE ExportarExcel(par_cArquivo)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                SELECT (THIS.this_cCursorDados)
                IF !EOF()
                    COPY TO (par_cArquivo) TYPE XLS
                    loc_lSucesso = .T.
                ELSE
                    MsgAviso("Nenhum dado encontrado para exportar.", ;
                        "Exportar Excel")
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Erro ao preparar dados para exporta" + ;
                    CHR(231) + CHR(227) + "o"
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "ExportarExcel")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna a mensagem do ultimo erro ocorrido
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera todos os cursores abertos pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Resultado")
            USE IN cursor_4c_Resultado
        ENDIF
        IF USED("cursor_4c_SigCqChi")
            USE IN cursor_4c_SigCqChi
        ENDIF
        IF USED("cursor_4c_SigCdPit")
            USE IN cursor_4c_SigCdPit
        ENDIF
        IF USED("cursor_4c_SigMvPar")
            USE IN cursor_4c_SigMvPar
        ENDIF
        IF USED("cursor_4c_SigMvCcr")
            USE IN cursor_4c_SigMvCcr
        ENDIF
        IF USED("cursor_4c_Contas")
            USE IN cursor_4c_Contas
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

