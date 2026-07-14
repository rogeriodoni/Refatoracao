*==============================================================================
* sigrecpeBO.prg
* Business Object para relatorio: Divergencias em Estoques
* Herda de: RelatorioBase
*==============================================================================

DEFINE CLASS sigrecpeBO AS RelatorioBase

    *-- Cursor de resultado do relatorio
    this_cCursorDados    = "cursor_4c_Dados"

    *-- Estoque A - Grupo e Conta
    this_cCdGrEstoqueA   = ""
    this_cDsGrEstoqueA   = ""
    this_cCdEstoqueA     = ""
    this_cDsEstoqueA     = ""

    *-- Estoque B - Grupo e Conta
    this_cCdGrupoB       = ""
    this_cDsGrupoB       = ""
    this_cCdContaB       = ""
    this_cDsContaB       = ""

    *-- Opcoes de comparacao (valores default iguais ao legado)
    this_nTipo           = 1
    this_nCorTam         = 2
    this_nReff           = 2
    this_nSituacao       = 3

    *-- Filtros de produto (intervalo inicial/final)
    this_cCgrui          = ""
    this_cCgruf          = ""
    this_cCunii          = ""
    this_cCunif          = ""
    this_cLini           = ""
    this_cLinf           = ""
    this_cColi           = ""
    this_cColf           = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa Business Object do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Restaura filtros a partir de um cursor de preset
    * Para BO de relatorio: permite reaplicar parametros salvos previamente
    * par_cAliasCursor: nome do alias com colunas de filtro (formato preset)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias
        loc_lSucesso = .F.
        TRY
            loc_cAlias = par_cAliasCursor
            IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor de preset n" + CHR(227) + "o dispon" + CHR(237) + "vel"
                EXIT
            ENDIF

            SELECT (loc_cAlias)
            IF EOF()
                THIS.this_cMensagemErro = "Cursor de preset vazio: " + loc_cAlias
                EXIT
            ENDIF

            *-- SCATTER MEMVAR para acessar colunas dinamicamente
            SCATTER MEMVAR

            *-- Estoque A
            IF TYPE("m.cCdGrEstoqueA") = "C"
                THIS.this_cCdGrEstoqueA = ALLTRIM(m.cCdGrEstoqueA)
            ENDIF
            IF TYPE("m.cDsGrEstoqueA") = "C"
                THIS.this_cDsGrEstoqueA = ALLTRIM(m.cDsGrEstoqueA)
            ENDIF
            IF TYPE("m.cCdEstoqueA") = "C"
                THIS.this_cCdEstoqueA = ALLTRIM(m.cCdEstoqueA)
            ENDIF
            IF TYPE("m.cDsEstoqueA") = "C"
                THIS.this_cDsEstoqueA = ALLTRIM(m.cDsEstoqueA)
            ENDIF

            *-- Estoque B
            IF TYPE("m.cCdGrupoB") = "C"
                THIS.this_cCdGrupoB = ALLTRIM(m.cCdGrupoB)
            ENDIF
            IF TYPE("m.cDsGrupoB") = "C"
                THIS.this_cDsGrupoB = ALLTRIM(m.cDsGrupoB)
            ENDIF
            IF TYPE("m.cCdContaB") = "C"
                THIS.this_cCdContaB = ALLTRIM(m.cCdContaB)
            ENDIF
            IF TYPE("m.cDsContaB") = "C"
                THIS.this_cDsContaB = ALLTRIM(m.cDsContaB)
            ENDIF

            *-- Opcoes de comparacao
            IF TYPE("m.nTipo") = "N"
                THIS.this_nTipo = m.nTipo
            ENDIF
            IF TYPE("m.nCorTam") = "N"
                THIS.this_nCorTam = m.nCorTam
            ENDIF
            IF TYPE("m.nReff") = "N"
                THIS.this_nReff = m.nReff
            ENDIF
            IF TYPE("m.nSituacao") = "N"
                THIS.this_nSituacao = m.nSituacao
            ENDIF

            *-- Filtros de produto
            IF TYPE("m.cCgrui") = "C"
                THIS.this_cCgrui = ALLTRIM(m.cCgrui)
            ENDIF
            IF TYPE("m.cCgruf") = "C"
                THIS.this_cCgruf = ALLTRIM(m.cCgruf)
            ENDIF
            IF TYPE("m.cCunii") = "C"
                THIS.this_cCunii = ALLTRIM(m.cCunii)
            ENDIF
            IF TYPE("m.cCunif") = "C"
                THIS.this_cCunif = ALLTRIM(m.cCunif)
            ENDIF
            IF TYPE("m.cLini") = "C"
                THIS.this_cLini = ALLTRIM(m.cLini)
            ENDIF
            IF TYPE("m.cLinf") = "C"
                THIS.this_cLinf = ALLTRIM(m.cLinf)
            ENDIF
            IF TYPE("m.cColi") = "C"
                THIS.this_cColi = ALLTRIM(m.cColi)
            ENDIF
            IF TYPE("m.cColf") = "C"
                THIS.this_cColf = ALLTRIM(m.cColf)
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Gera o relatorio enviando para a impressora
    * Semantica para BO de relatorio: "inserir" = produzir documento impresso
    * Valida filtros obrigatorios, delega para Imprimir() e registra auditoria
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DO WHILE .T.
                IF EMPTY(THIS.this_cCdGrupoB) OR EMPTY(THIS.this_cCdContaB)
                    THIS.this_cMensagemErro = "Estoque B (Grupo e Conta) " + ;
                                              CHR(233) + " obrigat" + CHR(243) + "rio para gerar relat" + ;
                                              CHR(243) + "rio"
                    EXIT
                ENDIF
                IF THIS.this_nTipo = 1
                    IF EMPTY(THIS.this_cCdGrEstoqueA) OR EMPTY(THIS.this_cCdEstoqueA)
                        THIS.this_cMensagemErro = "Estoque A (Grupo e Conta) " + ;
                                                  CHR(233) + " obrigat" + CHR(243) + "rio no tipo Estoque vs Estoque"
                        EXIT
                    ENDIF
                ENDIF

                loc_lSucesso = THIS.Imprimir()
                IF loc_lSucesso
                    THIS.RegistrarAuditoria("IMPRESSAO")
                ENDIF
                EXIT
            ENDDO
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Reprocessa os dados e exibe o relatorio em preview
    * Semantica para BO de relatorio: "atualizar" = recalcular e visualizar
    * Valida filtros obrigatorios, delega para Visualizar() e registra auditoria
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DO WHILE .T.
                IF EMPTY(THIS.this_cCdGrupoB) OR EMPTY(THIS.this_cCdContaB)
                    THIS.this_cMensagemErro = "Estoque B (Grupo e Conta) " + ;
                                              CHR(233) + " obrigat" + CHR(243) + "rio para visualizar relat" + ;
                                              CHR(243) + "rio"
                    EXIT
                ENDIF
                IF THIS.this_nTipo = 1
                    IF EMPTY(THIS.this_cCdGrEstoqueA) OR EMPTY(THIS.this_cCdEstoqueA)
                        THIS.this_cMensagemErro = "Estoque A (Grupo e Conta) " + ;
                                                  CHR(233) + " obrigat" + CHR(243) + "rio no tipo Estoque vs Estoque"
                        EXIT
                    ENDIF
                ENDIF

                loc_lSucesso = THIS.Visualizar()
                IF loc_lSucesso
                    THIS.RegistrarAuditoria("VISUALIZACAO")
                ENDIF
                EXIT
            ENDDO
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave composta dos filtros (para auditoria)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = "TP="    + ALLTRIM(STR(THIS.this_nTipo,1)) + ;
                     ";GA="   + ALLTRIM(THIS.this_cCdGrEstoqueA) + ;
                     ";EA="   + ALLTRIM(THIS.this_cCdEstoqueA) + ;
                     ";GB="   + ALLTRIM(THIS.this_cCdGrupoB) + ;
                     ";EB="   + ALLTRIM(THIS.this_cCdContaB) + ;
                     ";CT="   + ALLTRIM(STR(THIS.this_nCorTam,1)) + ;
                     ";RF="   + ALLTRIM(STR(THIS.this_nReff,1)) + ;
                     ";SIT="  + ALLTRIM(STR(THIS.this_nSituacao,1)) + ;
                     ";GRU="  + ALLTRIM(THIS.this_cCgrui) + "-" + ALLTRIM(THIS.this_cCgruf) + ;
                     ";UNI="  + ALLTRIM(THIS.this_cCunii) + "-" + ALLTRIM(THIS.this_cCunif) + ;
                     ";LIN="  + ALLTRIM(THIS.this_cLini)  + "-" + ALLTRIM(THIS.this_cLinf) + ;
                     ";COL="  + ALLTRIM(THIS.this_cColi)  + "-" + ALLTRIM(THIS.this_cColf)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra geracao do relatorio em LogAuditoria
    * par_cOperacao: IMPRESSAO, VISUALIZACAO, EXCEL
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResult, loc_cUsuario
        loc_lSucesso = .F.
        TRY
            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
            ENDIF

            loc_cChave = THIS.ObterChavePrimaria()

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(DataHora, Usuario, Tabela, Operacao, ChaveRegistro) " + ;
                       "VALUES (GETDATE(), " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       EscaparSQL("SigReCpE") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            *-- Falha de auditoria nao deve impedir geracao do relatorio
            THIS.this_cMensagemErro = "Aviso: falha ao registrar auditoria - " + loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa processamento e popula cursor_4c_Dados
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_cGrupoA, loc_cEstoqA, loc_cGrupoB, loc_cEstoqB
        LOCAL loc_cNomeEmpresa, loc_cRelTitulo, loc_cRelTitulo2
        LOCAL loc_cEmps

        loc_lSucesso = .F.
        TRY
            DO WHILE .T.
                loc_cEmps   = go_4c_Sistema.cCodEmpresa
                loc_cGrupoA = PADR(THIS.this_cCdGrEstoqueA, 10)
                loc_cEstoqA = PADR(THIS.this_cCdEstoqueA,   10)
                loc_cGrupoB = PADR(THIS.this_cCdGrupoB,     10)
                loc_cEstoqB = PADR(THIS.this_cCdContaB,     10)

                *-- Obter nome da empresa
                loc_cSQL = "SELECT Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cEmps)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpEmp")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao buscar empresa"
                    EXIT
                ENDIF
                SELECT cursor_4c_TmpEmp
                loc_cNomeEmpresa = IIF(!EOF(), ALLTRIM(Razas), "")
                USE IN cursor_4c_TmpEmp

                *-- Montar titulos do relatorio (CHR: 234=e-circunflex)
                loc_cRelTitulo  = "Diverg" + CHR(234) + "ncias entre Estoque"
                loc_cRelTitulo2 = "Estoque A :" + loc_cGrupoA + "/" + loc_cEstoqA + ;
                                  " - Estoque B :" + loc_cGrupoB + "/" + loc_cEstoqB

                *-- Criar cursor de cabecalho para o FRX
                IF USED("cscabecalho")
                    USE IN cscabecalho
                ENDIF
                CREATE CURSOR cscabecalho (NomeEmpresa C(80), RelTitulo C(80), RelTitulo2 C(80))
                INSERT INTO cscabecalho (NomeEmpresa, RelTitulo, RelTitulo2) ;
                    VALUES (loc_cNomeEmpresa, loc_cRelTitulo, loc_cRelTitulo2)

                *-- Carregar movimentos de estoque do SQL Server
                IF USED("cursor_4c_LocalEst")
                    USE IN cursor_4c_LocalEst
                ENDIF
                loc_cSQL = "SELECT * FROM SigMvEst WHERE Emps = " + EscaparSQL(loc_cEmps) + " AND Sqtds > 0"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalEst")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao carregar movimentos de estoque"
                    EXIT
                ENDIF

                *-- Carregar cadastro de produtos do SQL Server
                IF USED("cursor_4c_LocalPro")
                    USE IN cursor_4c_LocalPro
                ENDIF
                loc_cSQL = "SELECT Cpros, cproEqs, Reffs, cgrus, dpros, " + ;
                           "Cunis, Linhas, Colecoes, situas FROM SigCdPro"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao carregar produtos"
                    EXIT
                ENDIF

                *-- Fechar cursor resultado anterior
                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF

                *-- Executar comparacao conforme tipo selecionado
                IF THIS.this_nTipo = 1
                    THIS.ExecutarComparacaoEstoqueAvsB(loc_cGrupoA, loc_cEstoqA, ;
                        loc_cGrupoB, loc_cEstoqB, loc_cEmps)
                ELSE
                    THIS.ExecutarComparacaoProdutosVsB(loc_cGrupoB, loc_cEstoqB, loc_cEmps)
                ENDIF

                SELECT cursor_4c_Dados
                GO TOP

                loc_lSucesso = .T.
                EXIT
            ENDDO

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarComparacaoEstoqueAvsB - Tipo 1: itens do Estoque A ausentes no B
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarComparacaoEstoqueAvsB(par_cGrupoA, par_cEstoqA, ;
                                                       par_cGrupoB, par_cEstoqB, ;
                                                       par_cEmps)
        IF THIS.this_nCorTam = 1
            *-- Analisa por Cor/Tamanho: chave composta Cpros+CodCors+CodTams
            SELECT a.*, b.Dpros ;
                FROM cursor_4c_LocalEst a, cursor_4c_LocalPro b ;
                WHERE a.Grupos = par_cGrupoA AND a.Estos = par_cEstoqA ;
                  AND a.Emps = par_cEmps AND a.Sqtds > 0 ;
                  AND a.Cpros + a.CodCors + a.CodTams NOT IN ;
                      (SELECT Cpros + CodCors + CodTams FROM cursor_4c_LocalEst ;
                       WHERE Grupos = par_cGrupoB AND Estos = par_cEstoqB ;
                         AND Emps = par_cEmps AND Sqtds > 0) ;
                  AND a.Cpros = b.Cpros ;
                INTO CURSOR cursor_4c_Dados READWRITE ;
                ORDER BY a.Cpros, a.CodCors, a.CodTams
        ELSE
            *-- Analisa somente por produto (Cpros)
            SELECT a.*, b.Dpros ;
                FROM cursor_4c_LocalEst a, cursor_4c_LocalPro b ;
                WHERE a.Grupos = par_cGrupoA AND a.Estos = par_cEstoqA ;
                  AND a.Emps = par_cEmps AND a.Sqtds > 0 ;
                  AND a.Cpros NOT IN ;
                      (SELECT Cpros FROM cursor_4c_LocalEst ;
                       WHERE Grupos = par_cGrupoB AND Estos = par_cEstoqB ;
                         AND Emps = par_cEmps AND Sqtds > 0) ;
                  AND a.Cpros = b.Cpros ;
                INTO CURSOR cursor_4c_Dados READWRITE ;
                ORDER BY a.Cpros, a.CodCors, a.CodTams
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarComparacaoProdutosVsB - Tipo 2: produtos filtrados ausentes no B
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarComparacaoProdutosVsB(par_cGrupoB, par_cEstoqB, par_cEmps)
        LOCAL loc_cWhere, loc_cInicio, loc_cFinal

        *-- Montar clausula WHERE para filtros de produto
        loc_cWhere = ".T."

        *-- Filtro de Grupo (cgrus)
        loc_cInicio = ALLTRIM(THIS.this_cCgrui)
        loc_cFinal  = ALLTRIM(THIS.this_cCgruf)
        IF !EMPTY(loc_cInicio) AND !EMPTY(loc_cFinal)
            loc_cWhere = loc_cWhere + ' AND cgrus Between "' + loc_cInicio + '" And "' + loc_cFinal + '"'
        ELSE
            IF !EMPTY(loc_cInicio)
            loc_cWhere = loc_cWhere + ' AND cgrus >= "' + loc_cInicio + '"'
        ELSE
            IF !EMPTY(loc_cFinal)
            loc_cWhere = loc_cWhere + ' AND cgrus <= "' + loc_cFinal + '"'
            ENDIF
            ENDIF
        ENDIF

        *-- Filtro de Unidade (Cunis)
        loc_cInicio = ALLTRIM(THIS.this_cCunii)
        loc_cFinal  = ALLTRIM(THIS.this_cCunif)
        IF !EMPTY(loc_cInicio) AND !EMPTY(loc_cFinal)
            loc_cWhere = loc_cWhere + ' AND Cunis Between "' + loc_cInicio + '" And "' + loc_cFinal + '"'
        ELSE
            IF !EMPTY(loc_cInicio)
            loc_cWhere = loc_cWhere + ' AND Cunis >= "' + loc_cInicio + '"'
        ELSE
            IF !EMPTY(loc_cFinal)
            loc_cWhere = loc_cWhere + ' AND Cunis <= "' + loc_cFinal + '"'
            ENDIF
            ENDIF
        ENDIF

        *-- Filtro de Linha (Linhas)
        loc_cInicio = ALLTRIM(THIS.this_cLini)
        loc_cFinal  = ALLTRIM(THIS.this_cLinf)
        IF !EMPTY(loc_cInicio) AND !EMPTY(loc_cFinal)
            loc_cWhere = loc_cWhere + ' AND Linhas Between "' + loc_cInicio + '" And "' + loc_cFinal + '"'
        ELSE
            IF !EMPTY(loc_cInicio)
            loc_cWhere = loc_cWhere + ' AND Linhas >= "' + loc_cInicio + '"'
        ELSE
            IF !EMPTY(loc_cFinal)
            loc_cWhere = loc_cWhere + ' AND Linhas <= "' + loc_cFinal + '"'
            ENDIF
            ENDIF
        ENDIF

        *-- Filtro de Colecao (Colecoes)
        loc_cInicio = ALLTRIM(THIS.this_cColi)
        loc_cFinal  = ALLTRIM(THIS.this_cColf)
        IF !EMPTY(loc_cInicio) AND !EMPTY(loc_cFinal)
            loc_cWhere = loc_cWhere + ' AND Colecoes Between "' + loc_cInicio + '" And "' + loc_cFinal + '"'
        ELSE
            IF !EMPTY(loc_cInicio)
            loc_cWhere = loc_cWhere + ' AND Colecoes >= "' + loc_cInicio + '"'
        ELSE
            IF !EMPTY(loc_cFinal)
            loc_cWhere = loc_cWhere + ' AND Colecoes <= "' + loc_cFinal + '"'
            ENDIF
            ENDIF
        ENDIF

        *-- Filtro de situacao (Ativos=1, Inativos=2, Todos=3 = sem filtro)
        IF THIS.this_nSituacao = 1 OR THIS.this_nSituacao = 2
            loc_cWhere = loc_cWhere + " AND situas = " + TRANSFORM(THIS.this_nSituacao)
        ENDIF

        *-- Criar cursor com produtos filtrados (sem CodCors/CodTams reais ainda)
        IF USED("cursor_4c_TmpPro2")
            USE IN cursor_4c_TmpPro2
        ENDIF
        SELECT Cpros, cproEqs, Reffs, cgrus, dpros, ;
               "    " AS CodCors, "  " AS CodTams, 0 AS Sqtds ;
            FROM cursor_4c_LocalPro ;
            WHERE &loc_cWhere. ;
            INTO CURSOR cursor_4c_TmpPro2 READWRITE

        *-- Criar cursor TmpPro indexado por Cpros para SEEK de equivalentes
        IF USED("cursor_4c_TmpPro")
            USE IN cursor_4c_TmpPro
        ENDIF
        SET NULL ON
        CREATE CURSOR cursor_4c_TmpPro ;
            (Cpros C(10), cproeqs C(10), dpros C(40), ;
             CodCors C(4), CodTams C(2), Sqtds N(12,2), ;
             Reffs C(40), Reff2s C(40))
        INDEX ON Cpros TAG Cpros
        SELECT cursor_4c_TmpPro
        APPEND FROM DBF("cursor_4c_TmpPro2")
        SET NULL OFF

        *-- Buscar produtos equivalentes (cproEqs aponta para outro Cpros)
        SELECT Cpros, cproEqs, Reffs, cgrus, dpros, ;
               " " AS CodCors, " " AS CodTams, 0 AS Sqtds ;
            FROM cursor_4c_LocalPro ;
            WHERE !EMPTY(cproEqs) ;
              AND cproEqs IN (SELECT Cpros FROM cursor_4c_TmpPro) ;
            INTO CURSOR cursor_4c_TmpPro2 READWRITE

        *-- Preencher Reff2s em TmpPro com referencia do produto equivalente
        SELECT cursor_4c_TmpPro2
        SCAN
            IF SEEK(cproEqs, "cursor_4c_TmpPro", "Cpros")
                REPLACE cursor_4c_TmpPro.cproEqs WITH cursor_4c_TmpPro2.Cpros, ;
                        cursor_4c_TmpPro.Reff2s  WITH cursor_4c_TmpPro2.Reffs ;
                        IN cursor_4c_TmpPro
            ENDIF
        ENDSCAN

        *-- Gerar resultado conforme opcao de referencia de fornecedor
        IF THIS.this_nReff = 1
            *-- Agrupar por Reffs e comparar via referencia de fornecedor
            IF USED("cursor_4c_TmpProx")
                USE IN cursor_4c_TmpProx
            ENDIF
            SELECT Reffs, MAX(Reff2s) AS Reff2s ;
                FROM cursor_4c_TmpPro ;
                GROUP BY Reffs ;
                INTO CURSOR cursor_4c_TmpProx READWRITE

            SELECT DISTINCT PADR(Reffs, 10) AS Cpros, SPACE(40) AS dpros, ;
                            " " AS CodCors, " " AS CodTams, 0 AS Sqtds ;
                FROM cursor_4c_TmpProx ;
                WHERE !EMPTY(Reffs) ;
                  AND Reffs NOT IN ;
                      (SELECT b.Reffs ;
                       FROM cursor_4c_LocalEst a, cursor_4c_LocalPro b ;
                       WHERE a.Grupos = par_cGrupoB AND a.Estos = par_cEstoqB ;
                         AND a.Emps = par_cEmps AND a.Sqtds > 0 ;
                         AND a.Cpros = b.Cpros) ;
                  AND (EMPTY(Reff2s) OR Reff2s NOT IN ;
                      (SELECT b.Reffs ;
                       FROM cursor_4c_LocalEst a, cursor_4c_LocalPro b ;
                       WHERE a.Grupos = par_cGrupoB AND a.Estos = par_cEstoqB ;
                         AND a.Emps = par_cEmps AND a.Sqtds > 0 ;
                         AND a.Cpros = b.Cpros)) ;
                INTO CURSOR cursor_4c_Dados READWRITE ;
                ORDER BY 1

            IF USED("cursor_4c_TmpProx")
                USE IN cursor_4c_TmpProx
            ENDIF
        ELSE
            *-- Comparar diretamente por Cpros e produto equivalente
            SELECT * ;
                FROM cursor_4c_TmpPro ;
                WHERE Cpros NOT IN ;
                      (SELECT Cpros FROM cursor_4c_LocalEst ;
                       WHERE Grupos = par_cGrupoB AND Estos = par_cEstoqB ;
                         AND Emps = par_cEmps AND Sqtds > 0) ;
                  AND (EMPTY(cproEqs) OR cproEqs NOT IN ;
                      (SELECT Cpros FROM cursor_4c_LocalEst ;
                       WHERE Grupos = par_cGrupoB AND Estos = par_cEstoqB ;
                         AND Emps = par_cEmps AND Sqtds > 0)) ;
                INTO CURSOR cursor_4c_Dados READWRITE ;
                ORDER BY Cpros
        ENDIF

        *-- Limpar cursores temporarios
        IF USED("cursor_4c_TmpPro2")
            USE IN cursor_4c_TmpPro2
        ENDIF
        IF USED("cursor_4c_TmpPro")
            USE IN cursor_4c_TmpPro
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (gc_4c_CaminhoReports + "RelSigrecpe.frx") ;
                    TO PRINTER PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (gc_4c_CaminhoReports + "RelSigrecpe.frx") ;
                    PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

ENDDEFINE
