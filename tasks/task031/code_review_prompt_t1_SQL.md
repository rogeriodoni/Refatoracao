# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'EMPDOPNUMS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: RELFECHAS, CEMPS, DATAS, MOEDA, EMPS, DOPES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: RELFECHAS, CEMPS, DATAS, MOEDA, EMPS, DOPES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: RELFECHAS, CEMPS, DATAS, MOEDA, EMPS, DOPES

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
  ControlSource = ""
  ControlSource = ""
Insert Into dbCabecalho (NomeEmpresa, Titulo, Periodo) Values (cNomeEmpresa, cTitulo, cPeriodo)
lcQuery = [Select Dopes, COpers ] + ;
		    [From SigCdOpe ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdOpe') < 1)
lcQuery = [Select Cemps, Razas ] + ;
		    [From SigCdEmp ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdEmp') < 1)
Select crSigCdEmp
Select crSigCdOpe
	oSuper.Update(.t.)
	Select crSigCdEmp
		oInfer.Update(.t.)
		lcQuery = [Select Emps, Dopes, Numes, GrupoDs, ContaDs, GrupoOs, ContaOs ] + ;
				    [From SigMvCab ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigMvCab') < 1)
		Select crSigMvCab
			Select crSigMvPar
				Insert Into TmpCli (Grupo, Conta, TipoOper, Emps, Valor, Moeda) ;
Select TmpCli
lcQuery = [Select CMoes, NOrdRels, Cotas ] + ;
		    [From SigCdMoe]
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdMoe') < 1)
Select crSigCdMoe
Select Distinct a.Emps, a.TipoOper, Iif(Empty(b.NOrdRels), 9, b.NOrdRels), a.Moeda ;
  From TmpCli a, crSigCdMoe b ;
Select Operas
	If Not Seek(Operas.Emps, 'TmpCabec', 'Emps')
		Insert Into TmpCabec (Emps) Values (Operas.Emps)
Select TmpCli
	oProg.Update(.t.)
	=Seek(Emps, 'TmpCabec', 'Emps')
	=Seek(Emps, 'crSigCdEmp', 'CEmps')
	If Not Seek(Emps + Grupo + Conta, 'TmpFinal', 'EmpConDat')
		Insert Into TmpFinal (Emps, Grupo, Conta, NomeCli, Razas) ; 
	If Not Seek(TmpCli.Moeda, 'TmpTotal', 'Moeda')
		=Seek(TmpCli.Moeda, 'crSigCdMoe', 'CMoes')
		Insert Into TmpTotal (Moeda, NOrdRels) Values (TmpCli.Moeda, lnNOrdRels)
Select crSigCdMoe
	If Not Seek(crSigCdMoe.Cmoes, 'TmpTotal', 'Moeda')
		Insert Into TmpTotal (Moeda, NOrdRels) Values (crSigCdMoe.Cmoes, lnNOrdRels)
Select TmpTotal
Select TmpTotal
Select TmpFinal

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreanr.prg) - TRECHOS RELEVANTES PARA PASS SQL (865 linhas total):

*-- Linhas 762 a 784:
762:                 THIS.pgf_4c_Paginas.Page1.txt_4c_EmpresaDesc.Value   = ""
763:                 THIS.pgf_4c_Paginas.Page1.txt_4c_EmpresaDesc.ReadOnly = .F.
764:             ELSE
765:                 loc_cSQL    = "SELECT Cemps, Razas FROM SigCdEmp " + ;
766:                               "WHERE Cemps = " + EscaparSQL(loc_cValor)
767:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
768:                 IF loc_nResult > 0 AND !EOF("cursor_4c_EmpVal")
769:                     SELECT cursor_4c_EmpVal
770:                     THIS.pgf_4c_Paginas.Page1.txt_4c_EmpresaDesc.Value   = ALLTRIM(Razas)
771:                     THIS.pgf_4c_Paginas.Page1.txt_4c_EmpresaDesc.ReadOnly = .T.
772:                     loc_lEncontrou = .T.
773:                 ENDIF
774:                 IF USED("cursor_4c_EmpVal")
775:                     USE IN cursor_4c_EmpVal
776:                 ENDIF
777:                 IF !loc_lEncontrou
778:                     THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value      = ""
779:                     THIS.pgf_4c_Paginas.Page1.txt_4c_EmpresaDesc.Value   = ""
780:                     THIS.pgf_4c_Paginas.Page1.txt_4c_EmpresaDesc.ReadOnly = .F.
781:                     THIS.AbrirBuscaEmpresa()
782:                 ENDIF
783:             ENDIF
784:         CATCH TO loc_oErro

*-- Linhas 832 a 850:
832: 
833:                 IF loc_oBusca.this_lSelecionou
834:                     IF USED("cursor_4c_BuscaEmp")
835:                         SELECT cursor_4c_BuscaEmp
836:                         THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value      = ALLTRIM(Cemps)
837:                         THIS.pgf_4c_Paginas.Page1.txt_4c_EmpresaDesc.Value  = ALLTRIM(Razas)
838:                         THIS.pgf_4c_Paginas.Page1.txt_4c_EmpresaDesc.ReadOnly = .T.
839:                     ENDIF
840:                 ENDIF
841: 
842:                 IF USED("cursor_4c_BuscaEmp")
843:                     USE IN cursor_4c_BuscaEmp
844:                 ENDIF
845:                 loc_oBusca.Release()
846:             ENDIF
847:         CATCH TO loc_oErro
848:             MsgErro(loc_oErro.Message, "Erro ao Buscar Empresa")
849:         ENDTRY
850:     ENDPROC


### BO (C:\4c\projeto\app\classes\sigreanrBO.prg):
*==============================================================================
* SIGREANRBO.PRG
* Business Object para Relatorio de Resultados
*
* Herda de RelatorioBase
* Form: Formsigreanr.prg
* Relatorio: SigReAnr.frx (REPORT FORM SigReAnr)
*
* Filtros: Periodo (DtInicial/DtFinal), Data Cotacao, Empresa
* Tabelas: SigCdOpe, SigMvCab, SigMvPar, SigCdEmp, SigCdMoe, SigCdCli, SigCdCot
* Cursores de saida (referenciados pelo .FRX):
*   TmpFinal   - dados principais por cliente/grupo/conta
*   TmpCabec   - cabecalho de colunas de moeda por empresa
*   dbCabecalho - titulo, periodo e nome da empresa
* Variaveis PUBLIC (referenciadas pelo .FRX):
*   _TotalTit, _TotalVal, _TotalGTit, _TotalGVal, _TotalGCot
*==============================================================================

DEFINE CLASS sigreanrBO AS RelatorioBase

    *-- Filtros do relatorio (entradas do form)
    this_dDtInicial     = {}
    this_dDtFinal       = {}
    this_dDtCotacao     = {}
    this_cEmpresa       = ""
    this_cEmpresaDesc   = ""

    *-- Configuracao do relatorio
    this_cArquivoFRX    = ""
    this_cTitulo        = ""

    *-- Cursor principal de saida (compativel com .FRX original)
    this_cCursorDados   = "TmpFinal"

    *--------------------------------------------------------------------------
    * Init - Configura arquivo FRX e titulo do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cArquivoFRX = gc_4c_CaminhoReports + "SigReAnr.frx"
        THIS.this_cTitulo     = "Relat" + CHR(243) + "rio de Resultados"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem do ultimo erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa todo o processamento do relatorio
    * Replica a PROCEDURE processamento do SIGREANR.SCX original
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cNomeEmpresa, loc_cTitulo, loc_cPeriodo
        LOCAL loc_cEmpresa, loc_cDopAtual, loc_nCOpers, loc_cEmpAtual
        LOCAL loc_lcQuery, loc_nResult
        LOCAL loc_lcEdn, loc_cGrupo, loc_cConta, loc_cTipoOper, loc_nValor
        LOCAL loc_nConta1, loc_nConta2, loc_lnNOrdRels
        LOCAL loc_nTotalGeral, loc_nCot1
        LOCAL loc_cTotalTit, loc_cTotalVal, loc_cTotalGTit, loc_cTotalGVal, loc_cTotalGCot
        LOCAL loc_cRazas, loc_cNomeCli

        loc_lSucesso     = .F.

        TRY
            DO WHILE .T.

                loc_cEmpresa = ALLTRIM(THIS.this_cEmpresa)

                *-- Busca nome da empresa corrente (cabecalho do relatorio)
                loc_lcQuery = "SELECT Cemps, Razas FROM SigCdEmp " + ;
                              "WHERE Cemps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa))
                loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crSigCdEmpHdr")
                loc_cNomeEmpresa = ""
                IF loc_nResult > 0 AND !EOF("crSigCdEmpHdr")
                    SELECT crSigCdEmpHdr
                    loc_cNomeEmpresa = ALLTRIM(Razas)
                ENDIF
                IF USED("crSigCdEmpHdr")
                    USE IN crSigCdEmpHdr
                ENDIF

                loc_cTitulo  = "Relat" + CHR(243) + "rio de Resultados - Empresa : " + ;
                               IIF(EMPTY(loc_cEmpresa), "Todas", loc_cEmpresa)
                loc_cPeriodo = "Per" + CHR(237) + "odo : " + ;
                               DTOC(THIS.this_dDtInicial) + " " + CHR(224) + " " + ;
                               DTOC(THIS.this_dDtFinal)

                *-- Cursor de cabecalho do relatorio (dbCabecalho)
                IF USED("dbCabecalho")
                    USE IN dbCabecalho
                ENDIF
                CREATE CURSOR dbCabecalho (NomeEmpresa C(80), Titulo C(80), Periodo C(80), ;
                                           Cabecalho C(200), Campo1 C(20), Campo2 C(20), ;
                                           Campo3 C(20), Campo4 C(20), Campo5 C(20), TotalGeral M(4))
                INSERT INTO dbCabecalho (NomeEmpresa, Titulo, Periodo) ;
                    VALUES (loc_cNomeEmpresa, loc_cTitulo, loc_cPeriodo)

                *-- Cursor acumulador de valores por cliente/grupo/conta/moeda
                IF USED("TmpCli")
                    USE IN TmpCli
                ENDIF
                CREATE CURSOR TmpCli (Grupo C(10), Conta C(10), TipoOper C(1), ;
                                      Emps C(3), Valor N(12,2), Moeda C(3))

                *-- Busca operacoes com fechamento habilitado (RelFechas = 1)
                loc_lcQuery = "SELECT Dopes, COpers FROM SigCdOpe " + ;
                              "WHERE RelFechas = 1 ORDER BY Dopes"
                loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crSigCdOpe")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (crSigCdOpe)"
                    EXIT
                ENDIF

                *-- Busca empresas (filtradas ou todas)
                IF EMPTY(loc_cEmpresa)
                    loc_lcQuery = "SELECT Cemps, Razas FROM SigCdEmp"
                ELSE
                    loc_lcQuery = "SELECT Cemps, Razas FROM SigCdEmp " + ;
                                  "WHERE Cemps = " + EscaparSQL(loc_cEmpresa)
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crSigCdEmp")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (crSigCdEmp)"
                    EXIT
                ENDIF
                SELECT crSigCdEmp
                INDEX ON Cemps TAG Cemps

                *-- Loop externo: para cada operacao (tipo de lancamento)
                SELECT crSigCdOpe
                SCAN
                    loc_cDopAtual = ALLTRIM(crSigCdOpe.Dopes)
                    loc_nCOpers   = crSigCdOpe.COpers

                    WAIT WINDOW "Processando Opera" + CHR(231) + CHR(245) + "es: " + ;
                                loc_cDopAtual + "..." NOWAIT

                    *-- Loop interno: para cada empresa
                    SELECT crSigCdEmp
                    SCAN
                        loc_cEmpAtual = ALLTRIM(crSigCdEmp.Cemps)

                        *-- Movimentos no periodo para esta empresa/operacao
                        loc_lcQuery = "SELECT Emps, Dopes, Numes, GrupoDs, ContaDs, GrupoOs, ContaOs " + ;
                                      "FROM SigMvCab " + ;
                                      "WHERE Datas >= " + FormatarDataSQL(THIS.this_dDtInicial) + ;
                                      " AND Datas < DATEADD(day, 1, " + FormatarDataSQL(THIS.this_dDtFinal) + ")" + ;
                                      " AND Emps = " + EscaparSQL(loc_cEmpAtual) + ;
                                      " AND Dopes = " + EscaparSQL(loc_cDopAtual)
                        loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crSigMvCab")
                        IF loc_nResult < 1
                            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (crSigMvCab)"
                            EXIT
                        ENDIF

                        *-- Para cada movimento, acumula parcelas em TmpCli
                        SELECT crSigMvCab
                        SCAN
                            IF NVL(loc_nCOpers, 0) = 1
                                loc_cGrupo    = crSigMvCab.GrupoDs
                                loc_cConta    = crSigMvCab.ContaDs
                                loc_cTipoOper = "1"
                            ELSE
                                loc_cGrupo    = crSigMvCab.GrupoOs
                                loc_cConta    = crSigMvCab.ContaOs
                                loc_cTipoOper = "2"
                            ENDIF

                            loc_lcEdn = ALLTRIM(crSigMvCab.Emps) + ;
                                        ALLTRIM(crSigMvCab.Dopes) + ;
                                        STR(crSigMvCab.Numes, 6)

                            *-- Parcelas de pagamento deste movimento
                            loc_lcQuery = "SELECT MoeFpgs, Valos FROM SigMvPar " + ;
                                          "WHERE EmpDopNums = " + EscaparSQL(loc_lcEdn)
                            loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crSigMvPar")
                            IF loc_nResult > 0
                                SELECT crSigMvPar
                                SCAN
                                    loc_nValor = crSigMvPar.Valos * IIF(NVL(loc_nCOpers, 0) = 1, 1, -1)
                                    INSERT INTO TmpCli (Grupo, Conta, TipoOper, Emps, Valor, Moeda) ;
                                        VALUES (loc_cGrupo, loc_cConta, loc_cTipoOper, ;
                                                crSigMvCab.Emps, loc_nValor, crSigMvPar.MoeFpgs)
                                ENDSCAN
                            ENDIF
                            IF USED("crSigMvPar")
                                USE IN crSigMvPar
                            ENDIF
                            SELECT crSigMvCab
                        ENDSCAN

                        IF USED("crSigMvCab")
                            USE IN crSigMvCab
                        ENDIF

                        IF !EMPTY(THIS.this_cMensagemErro)
                            EXIT
                        ENDIF
                        SELECT crSigCdEmp
                    ENDSCAN

                    IF !EMPTY(THIS.this_cMensagemErro)
                        EXIT
                    ENDIF
                    SELECT crSigCdOpe
                ENDSCAN
                WAIT CLEAR

                IF !EMPTY(THIS.this_cMensagemErro)
                    EXIT
                ENDIF

                *-- Indexa TmpCli para busca por empresa/grupo/conta
                SELECT TmpCli
                INDEX ON Emps + Grupo + Conta + TipoOper TAG EmpDopCon

                *-- Cursor de cabecalho de colunas de moeda por empresa
                IF USED("TmpCabec")
                    USE IN TmpCabec
                ENDIF
                CREATE CURSOR TmpCabec (Emps C(3), Op11 C(3), Op12 C(3), Op13 C(3), ;
                                        Op21 C(3), Op22 C(3), Op23 C(3))
                INDEX ON Emps TAG Emps

                *-- Busca moedas com sua ordem de exibicao no relatorio
                loc_lcQuery = "SELECT CMoes, NOrdRels, Cotas FROM SigCdMoe"
                loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "crSigCdMoe")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (crSigCdMoe)"
                    EXIT
                ENDIF
                SELECT crSigCdMoe
                INDEX ON CMoes TAG CMoes

                *-- Combinacoes distintas de empresa/tipo/moeda presentes em TmpCli
                SELECT DISTINCT a.Emps, a.TipoOper, ;
                       IIF(EMPTY(b.NOrdRels), 9, b.NOrdRels) AS NOrdRels, a.Moeda ;
                  FROM TmpCli a, crSigCdMoe b ;
                 WHERE a.Moeda = b.CMoes ;
                  INTO CURSOR Operas

                *-- Atribui moedas as colunas Op11..Op13 (tipo 1) e Op21..Op23 (tipo 2)
                loc_nConta1 = 0
                loc_nConta2 = 0
                SELECT Operas
                SCAN
                    IF !SEEK(ALLTRIM(Operas.Emps), "TmpCabec", "Emps")
                        INSERT INTO TmpCabec (Emps) VALUES (Operas.Emps)
                        SELECT TmpCabec
                        SEEK ALLTRIM(Operas.Emps) ORDER TAG Emps
                        loc_nConta1 = 0
                        loc_nConta2 = 0
                    ENDIF

                    IF ALLTRIM(Operas.TipoOper) = "1"
                        loc_nConta1 = loc_nConta1 + 1
                        IF loc_nConta1 <= 3
                            DO CASE
                            CASE loc_nConta1 = 1
                                REPLACE Op11 WITH Operas.Moeda IN TmpCabec
                            CASE loc_nConta1 = 2
                                REPLACE Op12 WITH Operas.Moeda IN TmpCabec
                            CASE loc_nConta1 = 3
                                REPLACE Op13 WITH Operas.Moeda IN TmpCabec
                            ENDCASE
                        ENDIF
                    ELSE
                        loc_nConta2 = loc_nConta2 + 1
                        IF loc_nConta2 <= 3
                            DO CASE
                            CASE loc_nConta2 = 1
                                REPLACE Op21 WITH Operas.Moeda IN TmpCabec
                            CASE loc_nConta2 = 2
                                REPLACE Op22 WITH Operas.Moeda IN TmpCabec
                            CASE loc_nConta2 = 3
                                REPLACE Op23 WITH Operas.Moeda IN TmpCabec
                            ENDCASE
                        ENDIF
                    ENDIF
                    SELECT Operas
                ENDSCAN

                *-- Cursor de totais por moeda
                IF USED("TmpTotal")
                    USE IN TmpTotal
                ENDIF
                CREATE CURSOR TmpTotal (Moeda C(3), Valor N(12,2), NOrdRels N(1))
                INDEX ON Moeda TAG Moeda

                *-- Cursor final de dados do relatorio (compativel com SigReAnr.frx)
                IF USED("TmpFinal")
                    USE IN TmpFinal
                ENDIF
                CREATE CURSOR TmpFinal (Emps C(3), Grupo C(10), Conta C(10), Datas D, ;
                                        NomeCli C(40), Razas C(40), ;
                                        Valor1 N(12,2), Moeda1 C(3), ;
                                        Valor2 N(12,2), Moeda2 C(3), ;
                                        Valor3 N(12,2), Moeda3 C(3), ;
                                        Valor4 N(12,2), Moeda4 C(3), ;
                                        Valor5 N(12,2), Moeda5 C(3), ;
                                        Valor6 N(12,2), Moeda6 C(3))
                INDEX ON Emps + Grupo + Conta + DTOS(Datas) TAG EmpConDat

                *-- Popula TmpFinal acumulando valores por moeda/tipo de operacao
                SELECT TmpCli
                WAIT WINDOW "Processando Clientes..." NOWAIT
                GO TOP
                SCAN
                    *-- Posiciona TmpCabec na empresa do registro atual
                    = SEEK(ALLTRIM(TmpCli.Emps), "TmpCabec", "Emps")

                    *-- Busca razao social da empresa
                    = SEEK(ALLTRIM(TmpCli.Emps), "crSigCdEmp", "Cemps")
                    loc_cRazas = IIF(FOUND("crSigCdEmp"), ALLTRIM(crSigCdEmp.Razas), "")

                    *-- Busca nome do cliente (conta)
                    loc_lcQuery = "SELECT IClis, RClis FROM SigCdCli " + ;
                                  "WHERE IClis = " + EscaparSQL(ALLTRIM(TmpCli.Conta))
                    loc_cNomeCli = ""
                    IF SQLEXEC(gnConnHandle, loc_lcQuery, "crSigCdCli") > 0 AND ;
                       !EOF("crSigCdCli")
                        SELECT crSigCdCli
                        loc_cNomeCli = ALLTRIM(RClis)
                    ENDIF
                    IF USED("crSigCdCli")
                        USE IN crSigCdCli
                    ENDIF

                    *-- Localiza ou cria linha em TmpFinal para este cliente
                    IF !SEEK(ALLTRIM(TmpCli.Emps) + ALLTRIM(TmpCli.Grupo) + ALLTRIM(TmpCli.Conta), ;
                             "TmpFinal", "EmpConDat")
                        INSERT INTO TmpFinal (Emps, Grupo, Conta, NomeCli, Razas) ;
                            VALUES (TmpCli.Emps, TmpCli.Grupo, TmpCli.Conta, ;
                                    loc_cNomeCli, loc_cRazas)
                    ENDIF

                    *-- Acumula valor na coluna de moeda correspondente ao tipo de operacao
                    DO CASE
                    CASE (ALLTRIM(TmpCli.Moeda) = ALLTRIM(TmpCabec.Op11)) AND ;
                         (ALLTRIM(TmpCli.TipoOper) = "1")
                        REPLACE Valor1 WITH TmpFinal.Valor1 + TmpCli.Valor, ;
                                Moeda1 WITH TmpCli.Moeda IN TmpFinal
                    CASE (ALLTRIM(TmpCli.Moeda) = ALLTRIM(TmpCabec.Op12)) AND ;
                         (ALLTRIM(TmpCli.TipoOper) = "1")
                        REPLACE Valor2 WITH TmpFinal.Valor2 + TmpCli.Valor, ;
                                Moeda2 WITH TmpCli.Moeda IN TmpFinal
                    CASE (ALLTRIM(TmpCli.Moeda) = ALLTRIM(TmpCabec.Op13)) AND ;
                         (ALLTRIM(TmpCli.TipoOper) = "1")
                        REPLACE Valor3 WITH TmpFinal.Valor3 + TmpCli.Valor, ;
                                Moeda3 WITH TmpCli.Moeda IN TmpFinal
                    CASE (ALLTRIM(TmpCli.Moeda) = ALLTRIM(TmpCabec.Op21)) AND ;
                         (ALLTRIM(TmpCli.TipoOper) = "2")
                        REPLACE Valor4 WITH TmpFinal.Valor4 + TmpCli.Valor, ;
                                Moeda4 WITH TmpCli.Moeda IN TmpFinal
                    CASE (ALLTRIM(TmpCli.Moeda) = ALLTRIM(TmpCabec.Op22)) AND ;
                         (ALLTRIM(TmpCli.TipoOper) = "2")
                        REPLACE Valor5 WITH TmpFinal.Valor5 + TmpCli.Valor, ;
                                Moeda5 WITH TmpCli.Moeda IN TmpFinal
                    CASE (ALLTRIM(TmpCli.Moeda) = ALLTRIM(TmpCabec.Op23)) AND ;
                         (ALLTRIM(TmpCli.TipoOper) = "2")
                        REPLACE Valor6 WITH TmpFinal.Valor6 + TmpCli.Valor, ;
                                Moeda6 WITH TmpCli.Moeda IN TmpFinal
                    ENDCASE

                    *-- Acumula total por moeda em TmpTotal
                    IF !SEEK(ALLTRIM(TmpCli.Moeda), "TmpTotal", "Moeda")
                        = SEEK(ALLTRIM(TmpCli.Moeda), "crSigCdMoe", "CMoes")
                        loc_lnNOrdRels = IIF(FOUND("crSigCdMoe"), crSigCdMoe.NOrdRels, 9)
                        INSERT INTO TmpTotal (Moeda, NOrdRels) ;
                            VALUES (TmpCli.Moeda, loc_lnNOrdRels)
                        = SEEK(ALLTRIM(TmpCli.Moeda), "TmpTotal", "Moeda")
                    ENDIF
                    REPLACE Valor WITH TmpTotal.Valor + TmpCli.Valor IN TmpTotal

                    SELECT TmpCli
                ENDSCAN
                WAIT CLEAR

                *-- Adiciona moedas sem cotacao que ainda nao constam em TmpTotal
                SELECT crSigCdMoe
                SCAN FOR !Cotas
                    IF !SEEK(ALLTRIM(crSigCdMoe.CMoes), "TmpTotal", "Moeda")
                        loc_lnNOrdRels = crSigCdMoe.NOrdRels
                        INSERT INTO TmpTotal (Moeda, NOrdRels) ;
                            VALUES (crSigCdMoe.CMoes, loc_lnNOrdRels)
                        = SEEK(ALLTRIM(crSigCdMoe.CMoes), "TmpTotal", "Moeda")
                    ENDIF
                    SELECT crSigCdMoe
                ENDSCAN

                *-- Calcula totais parciais por moeda com cotacao na data informada
                loc_cTotalTit  = ""
                loc_cTotalVal  = ""
                loc_nTotalGeral = 0

                SELECT TmpTotal
                SCAN
                    loc_cTotalTit  = loc_cTotalTit + "Total em " + ;
                                     ALLTRIM(TmpTotal.Moeda) + " : " + CHR(13) + CHR(10)
                    loc_cTotalVal  = loc_cTotalVal + ;
                                     TRANSFORM(TmpTotal.Valor, "999,999,999.99") + ;
                                     CHR(13) + CHR(10)
                    loc_nCot1 = THIS.BuscarCotacao(ALLTRIM(TmpTotal.Moeda), THIS.this_dDtCotacao)
                    loc_nTotalGeral = loc_nTotalGeral + ROUND(TmpTotal.Valor * loc_nCot1, 2)
                    SELECT TmpTotal
                ENDSCAN

                *-- Calcula totais gerais convertidos para cada moeda
                loc_cTotalGTit = ""
                loc_cTotalGVal = ""
                loc_cTotalGCot = ""

                SELECT TmpTotal
                SCAN
                    loc_nCot1 = THIS.BuscarCotacao(ALLTRIM(TmpTotal.Moeda), THIS.this_dDtCotacao)
                    loc_cTotalGTit = loc_cTotalGTit + "Total Geral " + ;
                                     ALLTRIM(TmpTotal.Moeda) + " : " + CHR(13) + CHR(10)
                    IF loc_nCot1 > 0
                        loc_cTotalGVal = loc_cTotalGVal + ;
                                         TRANSFORM(ROUND(loc_nTotalGeral / loc_nCot1, 2), ;
                                                   "999,999,999.99") + CHR(13) + CHR(10)
                    ELSE
                        loc_cTotalGVal = loc_cTotalGVal + "0.00" + CHR(13) + CHR(10)
                    ENDIF
                    loc_cTotalGCot = loc_cTotalGCot + ;
                                     TRANSFORM(loc_nCot1, "99,999.999999") + CHR(13) + CHR(10)
                    SELECT TmpTotal
                ENDSCAN

                *-- Publica variaveis para o relatorio .FRX
                PUBLIC _TotalTit, _TotalVal, _TotalGTit, _TotalGVal, _TotalGCot
                _TotalTit  = loc_cTotalTit
                _TotalVal  = loc_cTotalVal
                _TotalGTit = loc_cTotalGTit
                _TotalGVal = loc_cTotalGVal
                _TotalGCot = loc_cTotalGCot

                *-- Relacao TmpFinal -> TmpCabec para o relatorio
                SELECT TmpFinal
                SET RELATION TO Emps INTO TmpCabec
                GO TOP

                loc_lSucesso = .T.
                EXIT
            ENDDO

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Preparar Dados do Relat" + CHR(243) + "rio")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarCotacao - Busca taxa de cambio da moeda para a data informada
    * Substitui fBuscarCotacao() do sistema legado
    * Tabela: SigCdCot (cmoes, datas, horas, valos)
    * Retorna 1.0 se moeda nao encontrada (fallback seguro)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarCotacao(par_cMoeda, par_dData)
        LOCAL loc_nTaxa, loc_cSQL, loc_nResult, loc_cMoeda, loc_cFiltroData

        loc_nTaxa  = 1.0
        loc_cMoeda = ALLTRIM(par_cMoeda)

        IF EMPTY(loc_cMoeda) OR loc_cMoeda = "R"
            RETURN loc_nTaxa
        ENDIF

        IF EMPTY(par_dData) OR VARTYPE(par_dData) != "D"
            loc_cFiltroData = "datas <= GETDATE()"
        ELSE
            loc_cFiltroData = "datas <= DATEADD(day, 1, " + FormatarDataSQL(par_dData) + ")"
        ENDIF

        loc_cSQL = "SELECT TOP 1 valos FROM SigCdCot " + ;
                   "WHERE cmoes = " + EscaparSQL(loc_cMoeda) + ;
                   " AND " + loc_cFiltroData + ;
                   " ORDER BY datas DESC, horas DESC"
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CotAnr")
        IF loc_nResult > 0 AND !EOF("cursor_4c_CotAnr")
            SELECT cursor_4c_CotAnr
            IF NVL(valos, 0) > 0
                loc_nTaxa = valos
            ENDIF
        ENDIF

        IF USED("cursor_4c_CotAnr")
            USE IN cursor_4c_CotAnr
        ENDIF

        RETURN loc_nTaxa
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime diretamente na impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cArquivoFRX) TO PRINTER PROMPT NOCONSOLE
                THIS.RegistrarAuditoria("IMPRIMIR")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Imprimir Relat" + CHR(243) + "rio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cArquivoFRX) PREVIEW NOCONSOLE
                THIS.RegistrarAuditoria("VISUALIZAR")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Visualizar Relat" + CHR(243) + "rio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarExcel - Prepara dados e gera documento (imprime para arquivo)
    *--------------------------------------------------------------------------
    PROCEDURE GerarExcel()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cArquivoFRX) TO PRINTER NOCONSOLE
                THIS.RegistrarAuditoria("EXPORTAR")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Gerar Documento do Relat" + CHR(243) + "rio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave de auditoria da execucao
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = IIF(EMPTY(THIS.this_cEmpresa), "TODAS", ALLTRIM(THIS.this_cEmpresa))
        loc_cChave = loc_cChave + "/" + DTOC(THIS.this_dDtInicial) + ;
                     "/" + DTOC(THIS.this_dDtFinal)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra execucao do relatorio na tabela LogAuditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cChave   = THIS.ObterChavePrimaria()
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                               gc_4c_UsuarioLogado, "SISTEMA")

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL("SIGREANR") + ", " + ;
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
    * apenas para manter um contrato uniforme com BusinessBase (auditoria,
    * dispatchers genericos, validadores automatizados) e para sinalizar
    * explicitamente a restricao - em vez de silenciar com herda padrao.
    *
    * Para relatorios, o fluxo correto eh:
    *   - PrepararDados() monta os cursores de saida (TmpFinal, TmpCabec,
    *     TmpCli, TmpTotal, dbCabecalho) via SQLEXEC sobre o periodo filtrado
    *   - Imprimir() / Visualizar() / GerarExcel() consomem esses cursores
    *     atraves do .FRX SigReAnr
    *
    * Qualquer chamada a uma destas rotinas em runtime indica uso incorreto
    * da API e deve falhar de forma observavel (mensagem de erro + retorno .F.).
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
    * Destroy - Limpeza de recursos e cursores temporarios
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("TmpFinal")
            SELECT TmpFinal
            SET RELATION TO
            USE IN TmpFinal
        ENDIF
        IF USED("TmpCabec")
            USE IN TmpCabec
        ENDIF
        IF USED("TmpCli")
            USE IN TmpCli
        ENDIF
        IF USED("TmpTotal")
            USE IN TmpTotal
        ENDIF
        IF USED("dbCabecalho")
            USE IN dbCabecalho
        ENDIF
        IF USED("crSigCdOpe")
            USE IN crSigCdOpe
        ENDIF
        IF USED("crSigCdEmp")
            USE IN crSigCdEmp
        ENDIF
        IF USED("crSigCdMoe")
            USE IN crSigCdMoe
        ENDIF
        IF USED("Operas")
            USE IN Operas
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

