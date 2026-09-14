*==============================================================================
* SIGPRPPPBO.prg - Business Object: Resultado de Pesquisa de Produtos por Conta
* Form OPERACIONAL sub-form: exibe movimentacoes e itens filtrados pelo pai
* Tabela base: SigMvCab / SigMvItn / SigCdPro
* Aberto por: FormSigPrPpc (passa TprMvCab populado + referencia THIS)
*==============================================================================
DEFINE CLASS SIGPRPPPBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Parametros de filtro recebidos do form pai (FormSigPrPpc)
    * Espelham os campos exibidos nos controles somente-leitura do form
    *--------------------------------------------------------------------------
    this_cGrupo       = ""   && Codigo do grupo contabil (SigCdGcr.codigos)
    this_cConta       = ""   && Codigo da conta/cliente (SigCdCli.IClis)
    this_cContaDesc   = ""   && Descricao da conta (SigCdCli.RClis)
    this_dInicial     = {}   && Data inicial do periodo de consulta
    this_dFinal       = {}   && Data final do periodo de consulta

    *--------------------------------------------------------------------------
    * Estado interno do grid de operacoes
    * Evita recarregar grd_4c_Itens quando o usuario nao muda de linha
    *--------------------------------------------------------------------------
    this_nLinhaAnterior = 0  && Ultima linha ativa em grd_4c_Operacoes

    *--------------------------------------------------------------------------
    * Chave unica para operacoes na tabela SigTempC
    * Gerado por fUniqueIds() em CarregarMovimentos() e limpo ao encerrar
    *--------------------------------------------------------------------------
    this_cChavePesquisa = ""

    *--------------------------------------------------------------------------
    * Init - Operacional de pesquisa. Registra tabela consultada (SigMvItn) para
    * auditoria via BusinessBase.RegistrarAuditoria (usa this_cTabela).
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigMvItn"
        THIS.this_cCampoChave = "cIdQuerys"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave da pesquisa em curso concatenada
    * com Grupo|Conta para rastrear filtros aplicados na auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ALLTRIM(NVL(THIS.this_cGrupo, "")) + "|" + ;
                     ALLTRIM(NVL(THIS.this_cConta, "")) + "|" + ;
                     ALLTRIM(NVL(THIS.this_cChavePesquisa, ""))
        RETURN loc_cChave
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - OPERACIONAL: nao grava em tabela propria (form eh somente-leitura).
    * Executa CarregarMovimentos (pipeline SQL) + registra auditoria "CONSULTA".
    * Chamado por FormSigPrPpc antes de exibir o form para materializar dados.
    * Retorno: .T. se a consulta foi executada e auditada com sucesso.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            *-- Auditoria obrigatoria da consulta (INSERT em LogAuditoria)
            THIS.RegistrarAuditoria("CONSULTA")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao registrar auditoria da consulta: " + ;
                                      loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro em Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - OPERACIONAL: nao ha UPDATE em tabela propria. Regenera a chave
    * de pesquisa (novo cIdQuerys), reexecuta o pipeline e registra REFRESH.
    * Usado quando o usuario altera filtros e redispara a consulta.
    * Retorno: .T. se auditoria foi registrada com sucesso.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            *-- Auditoria obrigatoria do refresh (INSERT em LogAuditoria)
            THIS.RegistrarAuditoria("REFRESH")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao registrar auditoria do refresh: " + ;
                                      loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro em Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia filtros opcionais de um cursor para as props
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                IF TYPE(par_cAliasCursor + ".cgrus") != "U"
                    THIS.this_cGrupo = TratarNulo(cgrus, "C")
                ENDIF
                IF TYPE(par_cAliasCursor + ".IClis") != "U"
                    THIS.this_cConta = TratarNulo(IClis, "C")
                ENDIF
                IF TYPE(par_cAliasCursor + ".RClis") != "U"
                    THIS.this_cContaDesc = TratarNulo(RClis, "C")
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarMovimentos - Pipeline principal de carga:
    *   1. Insere cabecalhos em SIGTEMPC (staging SQL Server)
    *   2. JOIN SIGTEMPC x SigMvItn x SigCdPro -> cursor_4c_MvItn indexado
    *   3. Popula cursor_4c_Operacoes a partir do cursor de origem (VFP)
    *   4. Cria cursor_4c_Itens e preenche com a primeira operacao
    * par_cCursorOrigem: nome do cursor VFP com cabecalhos (estrutura SigMvCab)
    *   deve ter: Emps C(3), Dopes C(20), Numes N(6,0), Datas D/T, Valos N(11,2)
    *--------------------------------------------------------------------------
    FUNCTION CarregarMovimentos(par_cCursorOrigem)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF !USED(par_cCursorOrigem) OR RECCOUNT(par_cCursorOrigem) = 0
                THIS.this_cMensagemErro = "Nenhum registro para carregar."
            ELSE
                THIS.this_cChavePesquisa = SYS(2015)

                *-- Insere cabecalhos em SIGTEMPC (ponte VFP->SQL Server para JOIN)
                *-- dpros: NOT NULL no schema, usar string vazia como placeholder
                SELECT (par_cCursorOrigem)
                GO TOP
                DO WHILE !EOF()
                    SQLEXEC(gnConnHandle, ;
                        "INSERT INTO SIGTEMPC (EmpDopNums, cIdQuerys, cIdChaves, dpros)" + ;
                        " VALUES (" + ;
                        EscaparSQL(Emps + Dopes + STR(Numes, 6)) + ", " + ;
                        EscaparSQL(THIS.this_cChavePesquisa) + ", " + ;
                        EscaparSQL(SYS(2015)) + ", " + ;
                        "'')")
                    SKIP
                ENDDO

                *-- Busca itens com descricao atualizada de SigCdPro
                loc_cSQL = "SELECT b.Emps, b.Dopes, b.Numes, b.Cpros, " + ;
                           "ISNULL(p.dpros, b.Dpros) AS Dpros, b.Qtds " + ;
                           "FROM SIGTEMPC a " + ;
                           "INNER JOIN SigMvItn b ON a.empdopnums = b.empdopnums " + ;
                           "LEFT JOIN SigCdPro p ON b.cpros = p.cpros " + ;
                           "WHERE a.cidquerys = " + EscaparSQL(THIS.this_cChavePesquisa) + ;
                           " ORDER BY b.Emps, b.Dopes, b.Numes, b.Cpros"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvItnRaw")
                THIS.LimparSIGTEMPC(THIS.this_cChavePesquisa)

                IF loc_nResult >= 0
                    *-- Cria cursor indexado cursor_4c_MvItn para lookup por operacao
                    IF USED("cursor_4c_MvItn")
                        USE IN cursor_4c_MvItn
                    ENDIF
                    SET NULL ON
                    CREATE CURSOR cursor_4c_MvItn ;
                        (Emps C(3) NULL, Dopes C(20) NULL, Numes N(6,0) NULL, ;
                         Cpros C(14) NULL, Dpros C(65) NULL, Qtds N(9,3) NULL)
                    SET NULL OFF

                    IF USED("cursor_4c_MvItnRaw") AND RECCOUNT("cursor_4c_MvItnRaw") > 0
                        SELECT cursor_4c_MvItn
                        APPEND FROM DBF("cursor_4c_MvItnRaw")
                    ENDIF
                    IF USED("cursor_4c_MvItnRaw")
                        USE IN cursor_4c_MvItnRaw
                    ENDIF

                    SELECT cursor_4c_MvItn
                    INDEX ON Emps + Dopes + STR(Numes, 6) TAG EmpDopNum

                    *-- Popula cursor_4c_Operacoes diretamente do cursor de origem (VFP)
                    IF USED("cursor_4c_Operacoes")
                        USE IN cursor_4c_Operacoes
                    ENDIF
                    SELECT Emps, Dopes, Numes, Datas, Valos ;
                        FROM (par_cCursorOrigem) ;
                        ORDER BY Emps, Dopes, Numes ;
                        INTO CURSOR cursor_4c_Operacoes READWRITE

                    *-- Cria cursor_4c_Itens placeholder vazio
                    IF USED("cursor_4c_Itens")
                        USE IN cursor_4c_Itens
                    ENDIF
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Itens ;
                        (Emps C(3) NULL, Dopes C(20) NULL, Numes N(6,0) NULL, ;
                         Cpros C(14) NULL, Dpros C(65) NULL, Qtds N(9,3) NULL)
                    SET NULL OFF

                    *-- Preenche itens da primeira operacao imediatamente
                    IF RECCOUNT("cursor_4c_Operacoes") > 0
                        SELECT cursor_4c_Operacoes
                        GO TOP
                        THIS.CarregarItensPorOperacao(cursor_4c_Operacoes.Emps, ;
                                                      cursor_4c_Operacoes.Dopes, ;
                                                      cursor_4c_Operacoes.Numes)
                    ENDIF

                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Falha ao consultar itens de movimenta" + ;
                                              CHR(231) + CHR(245) + "es."
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.LimparSIGTEMPC(THIS.this_cChavePesquisa)
            MsgErro(loc_oErro.Message, "Erro ao carregar movimenta" + CHR(231) + CHR(245) + "es")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarItensPorOperacao - Preenche cursor_4c_Itens com os itens da
    * operacao selecionada no grid superior (AfterRowColChange do form)
    * Faz SEEK em cursor_4c_MvItn (indexado por Emps+Dopes+STR(Numes,6))
    *--------------------------------------------------------------------------
    FUNCTION CarregarItensPorOperacao(par_cEmps, par_cDopes, par_nNumes)
        LOCAL loc_lSucesso, loc_cChaveSeek, loc_oErro
        LOCAL loc_cEmp, loc_cDop, loc_nNum, loc_cCpro, loc_cDpro, loc_nQtd
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_MvItn") AND USED("cursor_4c_Itens")
                SELECT cursor_4c_Itens
                ZAP

                loc_cChaveSeek = par_cEmps + par_cDopes + STR(par_nNumes, 6)

                SELECT cursor_4c_MvItn
                SET ORDER TO EmpDopNum
                SET NEAR ON
                SEEK loc_cChaveSeek
                SET NEAR OFF

                DO WHILE !EOF("cursor_4c_MvItn") AND ;
                         cursor_4c_MvItn.Emps + cursor_4c_MvItn.Dopes + ;
                         STR(cursor_4c_MvItn.Numes, 6) = loc_cChaveSeek

                    loc_cEmp  = cursor_4c_MvItn.Emps
                    loc_cDop  = cursor_4c_MvItn.Dopes
                    loc_nNum  = cursor_4c_MvItn.Numes
                    loc_cCpro = cursor_4c_MvItn.Cpros
                    loc_cDpro = cursor_4c_MvItn.Dpros
                    loc_nQtd  = cursor_4c_MvItn.Qtds

                    INSERT INTO cursor_4c_Itens (Emps, Dopes, Numes, Cpros, Dpros, Qtds) ;
                        VALUES (loc_cEmp, loc_cDop, loc_nNum, loc_cCpro, loc_cDpro, loc_nQtd)

                    SELECT cursor_4c_MvItn
                    SKIP
                ENDDO

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar itens")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * LimparSIGTEMPC - Remove registros temporarios da sessao em SIGTEMPC
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparSIGTEMPC(par_cChave)
        LOCAL loc_oErro
        TRY
            IF !EMPTY(par_cChave)
                SQLEXEC(gnConnHandle, "DELETE FROM SIGTEMPC WHERE cidquerys = " + ;
                        EscaparSQL(par_cChave))
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao limpar SIGTEMPC")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparRecursos - Fecha cursores temporarios ao encerrar o form
    *--------------------------------------------------------------------------
    PROCEDURE LimparRecursos()
        LOCAL loc_oErro
        TRY
            IF USED("cursor_4c_Operacoes")
                USE IN cursor_4c_Operacoes
            ENDIF
            IF USED("cursor_4c_Itens")
                USE IN cursor_4c_Itens
            ENDIF
            IF USED("cursor_4c_MvItn")
                USE IN cursor_4c_MvItn
            ENDIF
            IF USED("cursor_4c_MvItnRaw")
                USE IN cursor_4c_MvItnRaw
            ENDIF
            IF !EMPTY(THIS.this_cChavePesquisa)
                THIS.LimparSIGTEMPC(THIS.this_cChavePesquisa)
                THIS.this_cChavePesquisa = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao liberar recursos")
        ENDTRY
    ENDPROC

ENDDEFINE
