*==============================================================================
* SigPrSddBO.prg - Business Object para Senha do Dia
* Herda de BusinessBase
* Tabela principal: SigPrSnd
* Fase 1/8: Propriedades e Init
*==============================================================================

DEFINE CLASS SigPrSddBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Configuracao da entidade
    *--------------------------------------------------------------------------
    this_cTabela     = "SigPrSnd"
    this_cCampoChave = "cIdChaves"

    *--------------------------------------------------------------------------
    * Propriedades de dados - SigPrSnd (todas as colunas)
    *--------------------------------------------------------------------------
    this_cIdChaves   = ""  && cidchaves  char(20)  PK
    this_dDatas      = {}  && datas      datetime  NULL
    this_nDocs       = 0   && docs       numeric(10,0)
    this_cHoras      = ""  && horas      char(8)
    this_cMotivos    = ""  && motivos    char(40)
    this_cOperas     = ""  && operas     char(20)
    this_cSenhads    = ""  && senhads    char(6)
    this_cSolicits   = ""  && solicits   char(10)
    this_cUsuars     = ""  && usuars     char(10)
    this_nValors     = 0   && valors     numeric(11,2)
    this_nTipos      = 0   && tipos      numeric(1,0)
    this_cEmps       = ""  && emps       char(3)
    this_cFpags      = ""  && fpags      char(12)
    this_cEmpdopnums = ""  && empdopnums char(29)
    this_nPerlimite  = 0   && perlimite  numeric(5,2)

    *--------------------------------------------------------------------------
    * Propriedades auxiliares (nao persistidas em SigPrSnd)
    *--------------------------------------------------------------------------
    this_lProducao   = .F. && modo producao (parametro recebido pelo form)
    this_lSenhDEmps  = .F. && flag SigCdPac.senhdemps (bit -> logical)
    this_cDsEmpresa  = ""  && descricao empresa (SigCdEmp.Razas, exibida em Get_Ds_Empresa)

    *==========================================================================
    * Init - Configura tabela principal e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            THIS.this_cTabela     = "SigPrSnd"
            THIS.this_cCampoChave = "cIdChaves"

            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrSddBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna cIdChaves como chave primaria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN RTRIM(THIS.this_cIdChaves)
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades a partir de cursor
    * par_cAliasCursor: alias do cursor com dados de SigPrSnd
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cIdChaves   = TratarNulo(cidchaves,   "C")
                THIS.this_dDatas      = IIF(VARTYPE(datas) = "T", datas, IIF(VARTYPE(datas) = "D", DATETIME(YEAR(datas), MONTH(datas), DAY(datas)), DATETIME()))
                THIS.this_nDocs       = TratarNulo(docs,        "N")
                THIS.this_cHoras      = TratarNulo(horas,       "C")
                THIS.this_cMotivos    = TratarNulo(motivos,     "C")
                THIS.this_cOperas     = TratarNulo(operas,      "C")
                THIS.this_cSenhads    = TratarNulo(senhads,     "C")
                THIS.this_cSolicits   = TratarNulo(solicits,    "C")
                THIS.this_cUsuars     = TratarNulo(usuars,      "C")
                THIS.this_nValors     = TratarNulo(valors,      "N")
                THIS.this_nTipos      = TratarNulo(tipos,       "N")
                THIS.this_cEmps       = TratarNulo(emps,        "C")
                THIS.this_cFpags      = TratarNulo(fpags,       "C")
                THIS.this_cEmpdopnums = TratarNulo(empdopnums,  "C")
                THIS.this_nPerlimite  = TratarNulo(perlimite,   "N")

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDados - Valida campos obrigatorios antes de salvar
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_cMensagem

        loc_cMensagem = ""

        IF EMPTY(ALLTRIM(THIS.this_cSolicits))
            loc_cMensagem = "Informe o Nome do Solicitante."
        ENDIF
        IF EMPTY(loc_cMensagem) AND EMPTY(ALLTRIM(THIS.this_cEmps))
            loc_cMensagem = "Informe a Empresa."
        ENDIF
        IF EMPTY(loc_cMensagem) AND EMPTY(ALLTRIM(THIS.this_cOperas))
            loc_cMensagem = "Informe a Opera" + CHR(231) + CHR(227) + "o."
        ENDIF
        IF EMPTY(loc_cMensagem) AND THIS.this_nDocs = 0
            loc_cMensagem = "Informe o N" + CHR(250) + "mero do Documento."
        ENDIF
        IF EMPTY(loc_cMensagem) AND !THIS.this_lProducao AND THIS.this_nValors = 0
            loc_cMensagem = "Informe o Valor."
        ENDIF
        IF EMPTY(loc_cMensagem) AND EMPTY(ALLTRIM(THIS.this_cMotivos))
            loc_cMensagem = "Informe o Motivo."
        ENDIF

        THIS.this_cMensagemErro = loc_cMensagem
        RETURN EMPTY(loc_cMensagem)
    ENDPROC

    *==========================================================================
    * Inserir - INSERT completo em SigPrSnd
    * Chamado apos GeraSenha preencher cIdChaves, Senhads e Horas
    *==========================================================================
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigPrSnd " + ;
                       "(cidchaves, datas, docs, horas, motivos, operas, senhads, " + ;
                       " solicits, usuars, valors, tipos, emps, fpags, empdopnums, perlimite) " + ;
                       "VALUES (" + ;
                       EscaparSQL(LEFT(THIS.this_cIdChaves,   20)) + ", " + ;
                       "GETDATE(), " + ;
                       FormatarNumeroSQL(THIS.this_nDocs,     0)   + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cHoras,       8)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cMotivos,    40)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cOperas,     20)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cSenhads,     6)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cSolicits,   10)) + ", " + ;
                       EscaparSQL(LEFT(gc_4c_UsuarioLogado,   10)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nValors,    2)  + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTipos,     0)  + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cEmps,        3)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cFpags,      12)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPerlimite, 2)  + ;
                       ")"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet > 0
                THIS.RegistrarAuditoria("I")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro ao Inserir Senha do Dia")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Atualizar - UPDATE em SigPrSnd por cIdChaves
    *==========================================================================
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigPrSnd SET " + ;
                       "datas        = GETDATE(), " + ;
                       "docs         = " + FormatarNumeroSQL(THIS.this_nDocs,     0) + ", " + ;
                       "horas        = " + EscaparSQL(LEFT(THIS.this_cHoras,       8)) + ", " + ;
                       "motivos      = " + EscaparSQL(LEFT(THIS.this_cMotivos,    40)) + ", " + ;
                       "operas       = " + EscaparSQL(LEFT(THIS.this_cOperas,     20)) + ", " + ;
                       "senhads      = " + EscaparSQL(LEFT(THIS.this_cSenhads,     6)) + ", " + ;
                       "solicits     = " + EscaparSQL(LEFT(THIS.this_cSolicits,   10)) + ", " + ;
                       "usuars       = " + EscaparSQL(LEFT(gc_4c_UsuarioLogado,   10)) + ", " + ;
                       "valors       = " + FormatarNumeroSQL(THIS.this_nValors,    2)  + ", " + ;
                       "tipos        = " + FormatarNumeroSQL(THIS.this_nTipos,     0)  + ", " + ;
                       "emps         = " + EscaparSQL(LEFT(THIS.this_cEmps,        3)) + ", " + ;
                       "fpags        = " + EscaparSQL(LEFT(THIS.this_cFpags,      12)) + ", " + ;
                       "empdopnums   = " + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ", " + ;
                       "perlimite    = " + FormatarNumeroSQL(THIS.this_nPerlimite, 2)  + " " + ;
                       "WHERE cidchaves = " + EscaparSQL(LEFT(THIS.this_cIdChaves, 20))

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet > 0
                THIS.RegistrarAuditoria("A")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro ao Atualizar Senha do Dia")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * RegistrarAuditoria - Registra operacao na LogAuditoria
    * par_cOperacao: "I" inserir, "A" alterar, "E" excluir
    *==========================================================================
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_nRet

        TRY
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL("SigPrSnd")                           + ", " + ;
                       EscaparSQL(par_cOperacao)                        + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cIdChaves, 20))        + ", " + ;
                       EscaparSQL(LEFT(gc_4c_UsuarioLogado, 50))        + ", " + ;
                       "GETDATE()" + ;
                       ")"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            && auditoria nao pode bloquear operacao principal
        ENDTRY
    ENDPROC

    *==========================================================================
    * GeraSenha - Gera senha diaria e persiste em SigPrSnd
    * Retorna a senha gerada ou "" em caso de erro
    * Deve ser chamado apos ValidarDados() retornar .T.
    *==========================================================================
    FUNCTION GeraSenha()
        LOCAL loc_lSucesso, loc_lSenhDEmps, loc_nNum, loc_cSenha, loc_lValido

        loc_lSucesso   = .F.
        loc_lSenhDEmps = .F.
        loc_lValido    = .F.
        loc_nNum       = 0
        loc_cSenha     = ""

        TRY
            loc_lValido = THIS.ValidarDados()

            IF loc_lValido
                loc_lSenhDEmps = THIS.BuscarSenhDEmps()

                IF loc_lSenhDEmps
                    loc_nNum = THIS.BuscarNumeroEmpresa()
                    loc_nNum = loc_nNum + THIS.BuscarNumeroFpag()
                    loc_nNum = loc_nNum + (THIS.this_nValors * 100)
                ENDIF

                *-- Gerar senha pelo algoritmo legado
                loc_cSenha = fGerPswDiario(THIS.this_nDocs, THIS.this_dDatas, loc_nNum)

                *-- Preencher campos gerados antes de inserir
                THIS.this_cSenhads    = LEFT(loc_cSenha, 6)
                THIS.this_cHoras      = LEFT(TIME(), 8)
                THIS.this_cIdChaves   = fUniqueIds()
                THIS.this_nTipos      = IIF(THIS.this_lProducao, 1, 0)
                THIS.this_cEmpdopnums = SPACE(29)
                THIS.this_nPerlimite  = 0
                THIS.this_cUsuars     = LEFT(gc_4c_UsuarioLogado, 10)

                IF THIS.Inserir()
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro GeraSenha")
            loc_cSenha = ""
        ENDTRY

        RETURN IIF(loc_lSucesso, loc_cSenha, "")
    ENDFUNC

    *==========================================================================
    * BuscarSenhDEmps - Consulta flag SigCdPac.senhdemps
    * Retorna .T. se a senha depende de empresa+pagamento
    *==========================================================================
    PROTECTED FUNCTION BuscarSenhDEmps()
        LOCAL loc_lSenhDEmps, loc_nRet

        loc_lSenhDEmps = .F.

        TRY
            loc_nRet = SQLEXEC(gnConnHandle, "SELECT senhdemps FROM SigCdPac", "cursor_4c_Pac")
            IF loc_nRet > 0 AND USED("cursor_4c_Pac") AND !EOF("cursor_4c_Pac")
                SELECT cursor_4c_Pac
                loc_lSenhDEmps = cursor_4c_Pac.senhdemps
            ENDIF
            IF USED("cursor_4c_Pac")
                USE IN cursor_4c_Pac
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro BuscarSenhDEmps")
        ENDTRY

        RETURN loc_lSenhDEmps
    ENDFUNC

    *==========================================================================
    * BuscarNumeroEmpresa - Busca SigCdEmp.nemps pelo codigo da empresa
    * Retorna valor numerico de nemps (0 se nao encontrar)
    *==========================================================================
    PROTECTED FUNCTION BuscarNumeroEmpresa()
        LOCAL loc_nEmps, loc_nRet, loc_cSQL

        loc_nEmps = 0

        TRY
            loc_cSQL = "SELECT nemps FROM SigCdEmp WHERE Cemps = " + ;
                       EscaparSQL(LEFT(THIS.this_cEmps, 3))

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emp")
            IF loc_nRet > 0 AND USED("cursor_4c_Emp") AND !EOF("cursor_4c_Emp")
                SELECT cursor_4c_Emp
                loc_nEmps = NVL(cursor_4c_Emp.nemps, 0)
            ENDIF
            IF USED("cursor_4c_Emp")
                USE IN cursor_4c_Emp
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro BuscarNumeroEmpresa")
        ENDTRY

        RETURN loc_nEmps
    ENDFUNC

    *==========================================================================
    * BuscarNumeroFpag - Busca SigOpFp.nfpags pelo codigo de pagamento
    * Retorna valor numerico de nfpags (0 se nao encontrar)
    *==========================================================================
    PROTECTED FUNCTION BuscarNumeroFpag()
        LOCAL loc_nFpags, loc_nRet, loc_cSQL

        loc_nFpags = 0

        TRY
            IF !EMPTY(ALLTRIM(THIS.this_cFpags))
                loc_cSQL = "SELECT nfpags FROM SigOpFp WHERE Fpags = " + ;
                           EscaparSQL(LEFT(THIS.this_cFpags, 12))

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Fpag")
                IF loc_nRet > 0 AND USED("cursor_4c_Fpag") AND !EOF("cursor_4c_Fpag")
                    SELECT cursor_4c_Fpag
                    loc_nFpags = NVL(cursor_4c_Fpag.nfpags, 0)
                ENDIF
                IF USED("cursor_4c_Fpag")
                    USE IN cursor_4c_Fpag
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro BuscarNumeroFpag")
        ENDTRY

        RETURN loc_nFpags
    ENDFUNC

ENDDEFINE
