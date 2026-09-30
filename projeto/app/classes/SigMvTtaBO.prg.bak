*====================================================================
* SigMvTtaBO.prg
*
* Business Object para Impostos Gerados na Movimentacao
* Tabela: sigmvimp
* Herda de: BusinessBase
*
* Este BO acompanha o form OPERACIONAL FormSigMvTta, que revisa/edita
* (em grade) os impostos de UMA movimentacao (EmpDopNums) antes de a
* movimentacao ser confirmada pelo form chamador. O cursor da grade
* eh recebido por parametro do form chamador (par_cArquivo) - este BO
* fornece os metodos de apoio (descricao de Grupo/Conta e validacao
* de titulo/vencimento) que o legado (SIGMVTTA.SCX) implementava
* direto no form, contra ThisForm.poDataMgr.
*====================================================================

DEFINE CLASS SigMvTtaBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela sigmvimp)
    this_cPkChaves  = ""    && pkchaves char(20) - PK
    this_cEmpDopNums = ""   && empdopnums char(29)
    this_cImpostos  = ""    && impostos char(6)
    this_nValBases  = 0     && valbases numeric(11,2)
    this_nAliqs     = 0     && aliqs numeric(11,2)
    this_nValImps   = 0     && valimps numeric(11,2)
    this_cGrupos    = ""    && grupos char(10)
    this_cContas    = ""    && contas char(10)
    this_nValTits   = 0     && valtits numeric(11,2)
    this_dVencs     = {}    && vencs datetime NULL
    this_cMoedas    = ""    && moedas char(3)
    this_cHists     = ""    && hists char(40)
    this_cTitulos   = ""    && titulos char(10)
    this_cUsuCancs  = ""    && usucancs char(10)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "sigmvimp"
            THIS.this_cCampoChave = "pkchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SigMvTtaBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia campos do cursor (linha da grade de
    * impostos da movimentacao) para as propriedades do BO
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cPkChaves   = TratarNulo(pkchaves, "")
            THIS.this_cEmpDopNums = TratarNulo(empdopnums, "")
            THIS.this_cImpostos   = TratarNulo(impostos, "")
            THIS.this_nValBases   = TratarNulo(valbases, 0)
            THIS.this_nAliqs      = TratarNulo(aliqs, 0)
            THIS.this_nValImps    = TratarNulo(valimps, 0)
            THIS.this_cGrupos     = TratarNulo(grupos, "")
            THIS.this_cContas     = TratarNulo(contas, "")
            THIS.this_nValTits    = TratarNulo(valtits, 0)
            THIS.this_dVencs      = ConverterParaData(vencs)
            THIS.this_cMoedas     = TratarNulo(moedas, "")
            THIS.this_cHists      = TratarNulo(hists, "")
            THIS.this_cTitulos    = TratarNulo(titulos, "")
            THIS.this_cUsuCancs   = TratarNulo(usucancs, "")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Chave primaria de sigmvimp (pkchaves)
    *====================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cPkChaves)
    ENDFUNC

    *====================================================================
    * Inserir - INSERT na tabela sigmvimp
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cVencs
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cPkChaves))
                THIS.this_cPkChaves = LEFT(fUniqueIds(), 20)
            ENDIF

            loc_cVencs = IIF(EMPTY(THIS.this_dVencs), "NULL", FormatarDataSQL(THIS.this_dVencs))

            loc_cSQL = "INSERT INTO sigmvimp (pkchaves, empdopnums, impostos, valbases," + ;
                       " aliqs, valimps, grupos, contas, valtits, vencs, moedas," + ;
                       " hists, titulos, usucancs)" + ;
                       " VALUES (" + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cPkChaves), 20)) + "," + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmpDopNums), 29)) + "," + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cImpostos), 6)) + "," + ;
                       FormatarNumeroSQL(THIS.this_nValBases, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nAliqs, 2) + "," + ;
                       FormatarNumeroSQL(THIS.this_nValImps, 2) + "," + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cGrupos), 10)) + "," + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cContas), 10)) + "," + ;
                       FormatarNumeroSQL(THIS.this_nValTits, 2) + "," + ;
                       loc_cVencs + "," + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cMoedas), 3)) + "," + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cHists), 40)) + "," + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cTitulos), 10)) + "," + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cUsuCancs), 10)) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir imposto da movimenta" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir imposto da movimenta" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - UPDATE na tabela sigmvimp
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cVencs
        loc_lSucesso = .F.

        TRY
            loc_cVencs = IIF(EMPTY(THIS.this_dVencs), "NULL", FormatarDataSQL(THIS.this_dVencs))

            loc_cSQL = "UPDATE sigmvimp SET" + ;
                       " empdopnums = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmpDopNums), 29)) + "," + ;
                       " impostos = "   + EscaparSQL(LEFT(ALLTRIM(THIS.this_cImpostos), 6)) + "," + ;
                       " valbases = "   + FormatarNumeroSQL(THIS.this_nValBases, 2) + "," + ;
                       " aliqs = "      + FormatarNumeroSQL(THIS.this_nAliqs, 2) + "," + ;
                       " valimps = "    + FormatarNumeroSQL(THIS.this_nValImps, 2) + "," + ;
                       " grupos = "     + EscaparSQL(LEFT(ALLTRIM(THIS.this_cGrupos), 10)) + "," + ;
                       " contas = "     + EscaparSQL(LEFT(ALLTRIM(THIS.this_cContas), 10)) + "," + ;
                       " valtits = "    + FormatarNumeroSQL(THIS.this_nValTits, 2) + "," + ;
                       " vencs = "      + loc_cVencs + "," + ;
                       " moedas = "     + EscaparSQL(LEFT(ALLTRIM(THIS.this_cMoedas), 3)) + "," + ;
                       " hists = "      + EscaparSQL(LEFT(ALLTRIM(THIS.this_cHists), 40)) + "," + ;
                       " titulos = "    + EscaparSQL(LEFT(ALLTRIM(THIS.this_cTitulos), 10)) + "," + ;
                       " usucancs = "   + EscaparSQL(LEFT(ALLTRIM(THIS.this_cUsuCancs), 10)) + ;
                       " WHERE RTRIM(pkchaves) = " + EscaparSQL(ALLTRIM(THIS.this_cPkChaves))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar imposto da movimenta" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar imposto da movimenta" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
