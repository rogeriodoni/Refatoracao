*====================================================================
* SigOpOpeBO.prg
*
* Business Object para Centro de Custo Padrao da Operacao
* Tabela: SigCcCpe (vinculo Grupo de Contas x Operacao)
* Tabelas relacionadas: SigCdOpe (operacao - FK dopes), SigCdGcr (grupo de contas - FK grupos)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigOpOpeBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCcCpe)
    this_cCidChaves      = ""    && cidchaves char(20) - PK (gerada via fUniqueIds())
    this_cDopes          = ""    && dopes     char(20) - codigo da operacao (FK SigCdOpe.dopes)
    this_cGrupos         = ""    && grupos    char(10) - codigo do grupo de contas (FK SigCdGcr.codigos)
    this_cGruCads        = ""    && grucads   char(10) - grupo de cadastro (conta contabil validada via fAcessoContab)
    this_nCtFils         = 0     && ctfils    numeric(1,0) - "C" = Somente Contas do Grupo (0/1)

    *-- Propriedade auxiliar de exibicao (NAO persistida em SigCcCpe)
    this_cDescricaoGrupo = ""    && SigCdGcr.descrs - descricao do grupo (join, somente leitura)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCcCpe"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SigOpOpeBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna a chave primaria do registro atual
    * (usada por RegistrarAuditoria)
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia os campos do cursor para as propriedades
    * do vinculo Grupo de Contas x Operacao (SigCcCpe). par_cAliasCursor
    * eh o alias do cursor posicionado no registro a carregar (ex.: linha
    * corrente da grade TmpCcOpe, ou resultado de SQLEXEC pela chave).
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves = TratarNulo(cidchaves, "")
            THIS.this_cDopes     = TratarNulo(dopes,     "")
            THIS.this_cGrupos    = TratarNulo(grupos,    "")
            THIS.this_cGruCads   = TratarNulo(grucads,   "")
            THIS.this_nCtFils    = TratarNulo(ctfils,    0)

            *-- descrs nao eh coluna de SigCcCpe: so chega quando o cursor
            *-- de origem for montado com JOIN contra SigCdGcr (descricao
            *-- do grupo exibida na grade). Mapear so quando presente.
            IF TYPE(par_cAliasCursor + ".descrs") != "U"
                THIS.this_cDescricaoGrupo = TratarNulo(descrs, "")
            ELSE
                THIS.this_cDescricaoGrupo = ""
            ENDIF

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - INSERT de um vinculo Grupo de Contas x Operacao em SigCcCpe
    *====================================================================
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)
            ENDIF

            loc_cSQL = "INSERT INTO SigCcCpe (cidchaves, dopes, grupos, grucads, ctfils)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves)       + "," + ;
                       EscaparSQL(THIS.this_cDopes)           + "," + ;
                       EscaparSQL(THIS.this_cGrupos)          + "," + ;
                       EscaparSQL(THIS.this_cGruCads)         + "," + ;
                       FormatarNumeroSQL(THIS.this_nCtFils, 0) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir centro de custo padr" + CHR(227) + "o da opera" + CHR(231) + CHR(227) + "o:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir centro de custo padr" + CHR(227) + "o da opera" + CHR(231) + CHR(227) + "o:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - UPDATE de um vinculo Grupo de Contas x Operacao em SigCcCpe
    *====================================================================
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCcCpe SET" + ;
                       " dopes    = " + EscaparSQL(THIS.this_cDopes)   + "," + ;
                       " grupos   = " + EscaparSQL(THIS.this_cGrupos)  + "," + ;
                       " grucads  = " + EscaparSQL(THIS.this_cGruCads) + "," + ;
                       " ctfils   = " + FormatarNumeroSQL(THIS.this_nCtFils, 0) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar centro de custo padr" + CHR(227) + "o da opera" + CHR(231) + CHR(227) + "o:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar centro de custo padr" + CHR(227) + "o da opera" + CHR(231) + CHR(227) + "o:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC


    *====================================================================
    * CarregarVinculos - Popula o cursor da grade com os vinculos
    * "Grupo de Contas x Operacao" ja gravados para a operacao recebida.
    *
    * Transcreve a consulta do PROCEDURE Init legado:
    *   lcSql = [Select a.*, b.Descrs as Dgrus From SigCcCpe a, SigCdGcr b
    *            where a.Dopes = <operacao> And a.Grupos = b.Codigos]
    *   SigCdOpe.PodataMgr.Sqlexecute(lcSql,'xCcOpe')
    *   Select * From xCcOpe Into Cursor TmpCcOpe ReadWrite
    *
    * O "a.*" do legado vira a lista EXPLICITA das 5 colunas de SigCcCpe
    * (cidchaves/dopes/grupos/grucads/ctfils): o APPEND FROM casa as
    * colunas por NOME, entao a lista do SELECT tem de ser exatamente a
    * do CREATE CURSOR do form.
    *
    * NAO faz SQLEXEC direto no alias da grade: isso FECHA e RECRIA o
    * alias, zerando ColumnCount/RecordSource/ControlSource e o
    * CurrentControl do CheckBox da Column4 (a grade viraria um retangulo
    * branco, sem erro e sem log). Por isso o SQL vai para um cursor
    * TEMPORARIO e o alias da grade e recarregado com ZAP + APPEND FROM
    * DBF(), que preserva estrutura e bindings.
    *
    * par_cDopes        - codigo da operacao (SigCdOpe.dopes)
    * par_cAliasDestino - alias ja criado (CREATE CURSOR) ligado a grade
    *====================================================================
    PROCEDURE CarregarVinculos(par_cDopes, par_cAliasDestino)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cTemp, loc_oErro
        LOCAL loc_cAliasAnterior, loc_cSafety

        loc_lSucesso       = .F.
        loc_cTemp          = "cursor_4c_VinculosTmp"
        loc_cAliasAnterior = ALIAS()
        loc_cSafety        = SET("SAFETY")

        TRY
            IF VARTYPE(par_cDopes) != "C" OR VARTYPE(par_cAliasDestino) != "C"
                MsgErro("Par" + CHR(226) + "metros inv" + CHR(225) + "lidos em CarregarVinculos.", ;
                        "Erro em CarregarVinculos")
            ELSE
                IF !USED(par_cAliasDestino)
                    MsgErro("Cursor da grade [" + par_cAliasDestino + "] n" + CHR(227) + ;
                            "o est" + CHR(225) + " aberto.", "Erro em CarregarVinculos")
                ELSE
                    IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                        MsgErro("Conex" + CHR(227) + "o com o banco n" + CHR(227) + ;
                                "o estabelecida.", "Erro em CarregarVinculos")
                    ELSE
                        loc_cSQL = "SELECT a.cidchaves, a.dopes, a.grupos, a.grucads, a.ctfils," + ;
                                   " b.descrs AS dgrus" + ;
                                   " FROM SigCcCpe a, SigCdGcr b" + ;
                                   " WHERE a.dopes = " + EscaparSQL(ALLTRIM(par_cDopes)) + ;
                                   " AND a.grupos = b.codigos"

                        IF USED(loc_cTemp)
                            IF CURSORGETPROP("Buffering", loc_cTemp) > 1
                                TABLEREVERT(.T., loc_cTemp)
                            ENDIF
                            USE IN (loc_cTemp)
                        ENDIF

                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cTemp)

                        IF loc_nResultado < 0
                            MsgErro("Erro ao carregar os centros de custo da opera" + CHR(231) + ;
                                    CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        ELSE
                            *-- SET SAFETY e escopado por DATA SESSION: o
                            *-- SET SAFETY OFF do main.prg vale na sessao 1,
                            *-- mas este BO roda DENTRO da datasession
                            *-- privada do FormSigOpOpe (DataSession = 2),
                            *-- onde SAFETY nasce ON - medido no VFP9 em
                            *-- 2026-11-11 (automation/MedirDeletedSafetyDS2.prg:
                            *-- "SESSAO_FORM deleted=OFF safety=ON"). Com
                            *-- SAFETY ON o ZAP abre o dialogo modal
                            *-- "Zap ... Are you sure?" e CONGELA a tela.
                            SET SAFETY OFF

                            SELECT (par_cAliasDestino)
                            ZAP

                            IF loc_cSafety = "ON"
                                SET SAFETY ON
                            ENDIF

                            IF USED(loc_cTemp)
                                APPEND FROM DBF(loc_cTemp)
                                USE IN (loc_cTemp)
                            ENDIF
                            GO TOP IN (par_cAliasDestino)
                            loc_lSucesso = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CarregarVinculos")
        ENDTRY

        *-- rede de seguranca: excecao DURANTE o ZAP sairia com SAFETY OFF
        IF loc_cSafety = "ON"
            SET SAFETY ON
        ENDIF

        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterGrupoContasAcessivel - Nucleo de fAcessoContab (Framework legado,
    * Framework\sigacess.PRG:1029) restrito ao caminho usado por SIGOPOPE
    * (os dois call sites do dump passam so pUsu/pTip/pTxt/pCod[/pDsc] -
    * pCta e pDat nunca sao informados, entao os blocos de vinculo com
    * conta-corrente (SigCdCli) e de bloqueio por periodo (ddRetros/ddFutus)
    * do legado NUNCA executam para este form e foram omitidos aqui).
    *
    * Replica a restricao de acesso por GRUPO DE CONTAS:
    *   - usuario "4CONTROL" (super-usuario) enxerga TODOS os grupos
    *     (equivalente a "llTot" do legado)
    *   - demais usuarios so veem grupos vinculados a eles via SigSyAgc
    *     (Usuacess direto) OU via grupo de acesso (SigCdAcG.Usuarios),
    *     igual ao JOIN de 3 tabelas do legado
    *   - se o usuario NAO tem NENHUM vinculo de restricao cadastrado em
    *     SigSyAgc/SigCdAcG, cai para a lista COMPLETA de SigCdGcr
    *     (equivalente a "llRst" do legado - sistema sem restricao
    *     configurada libera tudo)
    *
    * par_cFiltroCodigo - codigo exato a filtrar (Codigos = valor); vazio
    *   devolve TODOS os grupos acessiveis (usado para popular o picker).
    *
    * Retorna o codigo do SQLEXEC; o resultado fica no cursor
    * cursor_4c_GruposAcessiveis (colunas Codigos/Descrs) - o CHAMADOR
    * fecha esse cursor apos usar.
    *====================================================================
    FUNCTION ObterGrupoContasAcessivel(par_cFiltroCodigo)
        LOCAL loc_cUsuario, loc_lSuperUsuario, loc_cAlias, loc_cWhereUsuario
        LOCAL loc_cSQL, loc_nResultado, loc_nTotalVinculos, loc_lUsaRestricao
        LOCAL loc_cFiltro

        loc_cAlias   = "cursor_4c_GruposAcessiveis"
        loc_cFiltro  = IIF(VARTYPE(par_cFiltroCodigo) = "C", ALLTRIM(par_cFiltroCodigo), "")
        loc_cUsuario = ALLTRIM(UPPER(IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "")))
        loc_lSuperUsuario = (loc_cUsuario == "4CONTROL")

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_lUsaRestricao = !loc_lSuperUsuario AND !EMPTY(loc_cUsuario)

        IF loc_lUsaRestricao
            loc_cWhereUsuario = "(a.Usuacess = " + EscaparSQL(loc_cUsuario) + ;
                                 " OR c.Usuarios = " + EscaparSQL(loc_cUsuario) + ")"

            loc_cSQL = "SELECT COUNT(*) AS Nvinc FROM SigSyAgc a" + ;
                       " LEFT JOIN SigCdAcG c ON c.Grupos = a.Gracess AND c.Usuarios = " + ;
                       EscaparSQL(loc_cUsuario) + ;
                       " WHERE " + loc_cWhereUsuario

            IF USED("cursor_4c_ContaVinc")
                USE IN cursor_4c_ContaVinc
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaVinc")
            loc_nTotalVinculos = IIF(loc_nResultado >= 0 AND USED("cursor_4c_ContaVinc"), ;
                                      NVL(cursor_4c_ContaVinc.Nvinc, 0), 0)
            IF USED("cursor_4c_ContaVinc")
                USE IN cursor_4c_ContaVinc
            ENDIF

            *-- sem NENHUM vinculo de restricao cadastrado -> acesso livre
            loc_lUsaRestricao = (loc_nTotalVinculos > 0)
        ENDIF

        IF loc_lUsaRestricao
            loc_cSQL = "SELECT b.Codigos, b.Descrs" + ;
                       " FROM SigSyAgc a" + ;
                       " LEFT JOIN SigCdAcG c ON c.Grupos = a.Gracess AND c.Usuarios = " + ;
                       EscaparSQL(loc_cUsuario) + ;
                       " RIGHT JOIN SigCdGcr b ON b.Codigos = a.Grcontbs" + ;
                       " WHERE " + loc_cWhereUsuario
            IF !EMPTY(loc_cFiltro)
                loc_cSQL = loc_cSQL + " AND b.Codigos = " + EscaparSQL(loc_cFiltro)
            ENDIF
            loc_cSQL = loc_cSQL + " GROUP BY b.Codigos, b.Descrs ORDER BY b.Codigos"
        ELSE
            loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr"
            IF !EMPTY(loc_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE Codigos = " + EscaparSQL(loc_cFiltro)
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY Codigos"
        ENDIF

        RETURN SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)
    ENDFUNC

    *====================================================================
    * SalvarVinculos - Regrava TODOS os vinculos da operacao a partir do
    * cursor da grade, em transacao unica.
    *
    * Transcreve o bloco de gravacao do cmdSair.Click legado:
    *   lcSql = [Delete From SigCcCpe Where Dopes = <operacao>]
    *   ...Sqlexecute(lcSql,'') / .poDataMgr.UpDate('crSigCcCpe') / Commit()
    *   Se qualquer etapa falhar -> RollBack()
    * O legado apaga tudo da operacao e regrava o cursor inteiro (o
    * "Zap / Append From Dbf('TmpCcOpe')" em crSigCcCpe antes do Update);
    * aqui o mesmo efeito vem de DELETE + um INSERT por linha.
    *
    * BEGIN/COMMIT por SQLEXEC NAO protege nada - a transacao e aberta na
    * CONEXAO (SQLSETPROP "Transactions" = 2) e encerrada com SQLTRANSACT,
    * restaurando o modo automatico (1) em TODOS os caminhos, inclusive
    * no CATCH.
    *
    * As linhas DELETADAS do cursor (o "Delete For Grupos = '  '" do
    * legado) ficam de fora porque o SCAN respeita SET DELETED ON; a
    * guarda por grupos vazio cobre o caso de SET DELETED OFF.
    *
    * par_cDopes       - codigo da operacao (SigCdOpe.dopes)
    * par_cAliasCursor - alias do cursor da grade com as linhas a gravar
    *====================================================================
    PROCEDURE SalvarVinculos(par_cDopes, par_cAliasCursor)
        LOCAL loc_lSucesso, loc_lTransacaoAberta, loc_lErroScan
        LOCAL loc_cSQL, loc_nResultado, loc_oErro, loc_cAliasAnterior

        loc_lSucesso         = .F.
        loc_lTransacaoAberta = .F.
        loc_lErroScan        = .F.
        loc_cAliasAnterior   = ALIAS()

        TRY
            IF VARTYPE(par_cDopes) != "C" OR VARTYPE(par_cAliasCursor) != "C"
                MsgErro("Par" + CHR(226) + "metros inv" + CHR(225) + "lidos em SalvarVinculos.", ;
                        "Erro em SalvarVinculos")
            ELSE
                IF !USED(par_cAliasCursor)
                    MsgErro("Cursor da grade [" + par_cAliasCursor + "] n" + CHR(227) + ;
                            "o est" + CHR(225) + " aberto.", "Erro em SalvarVinculos")
                ELSE
                    IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                        MsgErro("Conex" + CHR(227) + "o com o banco n" + CHR(227) + ;
                                "o estabelecida.", "Erro em SalvarVinculos")
                    ELSE
                        SQLSETPROP(gnConnHandle, "Transactions", 2)
                        loc_lTransacaoAberta = .T.

                        loc_cSQL = "DELETE FROM SigCcCpe WHERE dopes = " + ;
                                   EscaparSQL(ALLTRIM(par_cDopes))
                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                        IF loc_nResultado < 0
                            loc_lErroScan = .T.
                            MsgErro("Erro ao limpar os centros de custo da opera" + CHR(231) + ;
                                    CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        ELSE
                            SELECT (par_cAliasCursor)
                            GO TOP

                            SCAN
                                *-- linha em branco nao vira registro (o legado
                                *-- apaga essas linhas antes de gravar)
                                IF !EMPTY(EVALUATE(par_cAliasCursor + ".grupos"))
                                    IF !THIS.CarregarDoCursor(par_cAliasCursor)
                                        loc_lErroScan = .T.
                                        EXIT
                                    ENDIF

                                    *-- a operacao do vinculo e sempre a do form
                                    *-- chamador ("Replace all dopes With
                                    *-- CrSigCdOpe.Dopes" do legado)
                                    THIS.this_cDopes = ALLTRIM(par_cDopes)

                                    *-- PK nova para cada linha regravada
                                    *-- ("CidChaves With fUniqueIds()")
                                    THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)

                                    IF !THIS.Inserir()
                                        loc_lErroScan = .T.
                                        EXIT
                                    ENDIF
                                ENDIF
                            ENDSCAN
                        ENDIF

                        IF loc_lErroScan
                            SQLTRANSACT(gnConnHandle, "ROLLBACK")
                        ELSE
                            SQLTRANSACT(gnConnHandle, "COMMIT")
                            loc_lSucesso = .T.
                        ENDIF

                        SQLSETPROP(gnConnHandle, "Transactions", 1)
                        loc_lTransacaoAberta = .F.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF loc_lTransacaoAberta
                SQLTRANSACT(gnConnHandle, "ROLLBACK")
                SQLSETPROP(gnConnHandle, "Transactions", 1)
            ENDIF
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SalvarVinculos")
        ENDTRY

        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
