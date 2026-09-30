*==============================================================================
* SigPrCtcBO.prg
* Business Object: Cotacoes por Operacoes (tabela SIGPRCTC)
* Migrado de: SIGPRCTC.scx (dialogo filho, grade de cotacoes de moeda)
*==============================================================================

DEFINE CLASS SigPrCtcBO AS BusinessBase

    *-- Propriedades (colunas de dbo.sigprctc - docs/schema.sql)
    this_cCMoes      = ""      && char(3)  NOT NULL - codigo da moeda (PK composta com EmpDopNums)
    this_cEmpDopNums = ""      && char(29) NOT NULL - chave posicional: Emps(3)+Dopes(20)+Str(Numes,6)
    this_nValos      = 0       && numeric(11,6) NOT NULL - valor da cotacao
    this_cPkChaves   = ""      && char(20) NOT NULL - chave primaria (fUniqueIds())
    this_dDtAlts     = {}      && datetime NULL
    this_cUsuars     = ""      && char(10) NOT NULL

    *-- Propriedade derivada (JOIN com SigCdMoe.dMoes AS Descrs) - nao existe em sigprctc
    this_cDescrs     = ""

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SIGPRCTC"
        THIS.this_cCampoChave = "pkchaves"

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria (RegistrarAuditoria)
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cPkChaves)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de uma linha do cursor
    * (estrutura de dbo.sigprctc, com Descrs opcional quando o cursor vem de
    * um SELECT com LEFT JOIN em SigCdMoe.dmoes)
    * REGRA: EmpDopNums eh chave POSICIONAL (Emps char(3)+Dopes char(20)+
    * Str(Numes,6)) - NUNCA aplicar ALLTRIM nela, o padding faz parte da chave.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cCMoes      = ALLTRIM(TratarNulo(cmoes, ""))
            THIS.this_cEmpDopNums = TratarNulo(empdopnums, "")
            THIS.this_nValos      = TratarNulo(valos, 0)
            THIS.this_cPkChaves   = ALLTRIM(TratarNulo(pkchaves, ""))
            THIS.this_dDtAlts     = ConverterParaData(TratarNulo(dtalts, {}))
            THIS.this_cUsuars     = ALLTRIM(TratarNulo(usuars, ""))

            IF TYPE(par_cAliasCursor + ".descrs") = "C"
                THIS.this_cDescrs = ALLTRIM(TratarNulo(descrs, ""))
            ELSE
                THIS.this_cDescrs = ""
            ENDIF

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere nova cotacao na tabela SIGPRCTC
    * Espelha SIGPRCTC.cmdInserir.Click (fUniqueIds() para a chave) e
    * SIGPRCTC.cmdSair.Click (Scatter Memvar + Insert) do legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cPkChaves))
                THIS.this_cPkChaves = LEFT(fUniqueIds(), 20)
            ENDIF

            THIS.this_dDtAlts = DATE()
            THIS.this_cUsuars = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                gc_4c_UsuarioLogado, THIS.this_cUsuars)

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SIGPRCTC (cmoes, empdopnums, valos, pkchaves, dtalts, usuars)
                VALUES (
                    <<EscaparSQL(ALLTRIM(THIS.this_cCMoes))>>,
                    <<EscaparSQL(THIS.this_cEmpDopNums)>>,
                    <<FormatarNumeroSQL(THIS.this_nValos, 6)>>,
                    <<EscaparSQL(THIS.this_cPkChaves)>>,
                    <<FormatarDataSQL(THIS.this_dDtAlts)>>,
                    <<EscaparSQL(THIS.this_cUsuars)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir cota" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "SigPrCtcBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza cotacao existente na tabela SIGPRCTC
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_dDtAlts = DATE()
            THIS.this_cUsuars = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                gc_4c_UsuarioLogado, THIS.this_cUsuars)

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SIGPRCTC
                SET cmoes      = <<EscaparSQL(ALLTRIM(THIS.this_cCMoes))>>,
                    empdopnums = <<EscaparSQL(THIS.this_cEmpDopNums)>>,
                    valos      = <<FormatarNumeroSQL(THIS.this_nValos, 6)>>,
                    dtalts     = <<FormatarDataSQL(THIS.this_dDtAlts)>>,
                    usuars     = <<EscaparSQL(THIS.this_cUsuars)>>
                WHERE pkchaves = <<EscaparSQL(THIS.this_cPkChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar cota" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "SigPrCtcBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGradeCotacoes - Popula cursor_4c_Dados com as cotacoes da chave
    * EmpDopNums informada, via JOIN com SigCdMoe (equivalente ao
    * "Select a.*,b.dMoes as Descrs From SIGPRCTC a, SigCdMoe b Where
    * a.EmpDopNums = ... And a.cMoes = b.cMoes" do Init legado). O cursor
    * resultante do SQLEXEC eh local e editavel (INSERT/DELETE/REPLACE sem ir
    * ao banco), equivalente ao LocalCtMoe do legado.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarGradeCotacoes(par_cEmpDopNums)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT a.cmoes, a.empdopnums, a.valos, a.pkchaves, a.dtalts, a.usuars," + ;
                       " b.dmoes AS descrs" + ;
                       " FROM SIGPRCTC a, SigCdMoe b" + ;
                       " WHERE a.empdopnums = " + EscaparSQL(par_cEmpDopNums) + ;
                       " AND a.cmoes = b.cmoes"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar cota" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar cota" + CHR(231) + CHR(245) + "es:" + CHR(13) + loException.Message, "SigPrCtcBO.CarregarGradeCotacoes")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarGradeCotacoes - Sincroniza EM LOTE o cursor local da grade
    * (par_cAliasGrade) com SIGPRCTC para a chave par_cEmpDopNums: apaga TODAS
    * as cotacoes anteriores da chave e reinsere as linhas com moeda
    * preenchida (linhas com cmoes vazio sao descartadas, igual ao
    * "If Empty(m.cMoes) Loop" do sair.Click legado). Equivalente ao bloco
    * "Delete From SIGPRCTC ... / Insert Into CrSIGPRCTC ... / UpDate /
    * Commit/RollBack" do legado - aqui direto em SIGPRCTC, sem cursor de
    * staging intermediario. A checagem de moeda duplicada (Select cMoes,
    * sum(1)...) e responsabilidade do FORM (validacao de estado da grade,
    * nao de persistencia) - ver BtnSairClick.
    *--------------------------------------------------------------------------
    PROCEDURE SalvarGradeCotacoes(par_cAliasGrade, par_cEmpDopNums)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cPkGerada, loc_oErro
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        IF !USED(par_cAliasGrade)
            THIS.this_cMensagemErro = "Cursor de grade n" + CHR(227) + "o localizado"
            RETURN .F.
        ENDIF

        TRY
            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

            loc_cSQL = "DELETE FROM SIGPRCTC WHERE empdopnums = " + EscaparSQL(par_cEmpDopNums)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro na grava" + CHR(231) + CHR(227) + "o dos dados do Cadastro de Cota" + CHR(231) + CHR(245) + "es.", "Erro")
            ELSE
                loc_lSucesso = .T.
                SELECT (par_cAliasGrade)
                GO TOP
                SCAN
                    IF EMPTY(ALLTRIM(cmoes))
                        LOOP
                    ENDIF

                    loc_cPkGerada = LEFT(fUniqueIds(), 20)
                    loc_cSQL = "INSERT INTO SIGPRCTC (cmoes, empdopnums, valos, pkchaves, dtalts, usuars)" + ;
                               " VALUES (" + ;
                               EscaparSQL(ALLTRIM(cmoes)) + "," + ;
                               EscaparSQL(par_cEmpDopNums) + "," + ;
                               FormatarNumeroSQL(valos, 6) + "," + ;
                               EscaparSQL(loc_cPkGerada) + "," + ;
                               FormatarDataSQL(DATE()) + "," + ;
                               EscaparSQL(IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "")) + ;
                               ")"

                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                        loc_lSucesso = .F.
                        MsgErro("Erro na grava" + CHR(231) + CHR(227) + "o dos dados do Cadastro de Cota" + CHR(231) + CHR(245) + "es.", "Erro")
                        EXIT
                    ENDIF

                    THIS.this_cPkChaves   = loc_cPkGerada
                    THIS.this_cCMoes      = ALLTRIM(cmoes)
                    THIS.this_cEmpDopNums = par_cEmpDopNums
                    THIS.RegistrarAuditoria("INSERT")
                ENDSCAN
            ENDIF

            IF loc_lSucesso
                SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
            ELSE
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
            ENDIF
        CATCH TO loc_oErro
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao salvar cota" + CHR(231) + CHR(245) + "es:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
