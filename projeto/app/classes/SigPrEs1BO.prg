*==============================================================================
* SigPrEs1BO.prg - Business Object: Posicao Por Movimentacao
* Herda de BusinessBase
* Form OPERACIONAL - consulta/filtro de movimentacoes em SigMvCab
*==============================================================================

DEFINE CLASS SigPrEs1BO AS BusinessBase

    *-- Empresa
    this_cEmpresa      = ""
    this_cDsEmpresa    = ""
    this_nEmpD         = 0

    *-- Operacao / Movimentacao
    this_cNmOperacao   = ""
    this_nNumero       = 0
    this_nOp           = 0

    *-- Periodo
    this_dDtInicial    = {}
    this_dDtFinal      = {}
    this_nPeriodo      = 1

    *-- Grupo contabil
    this_cGrupo        = ""
    this_cDsGrupo      = ""

    *-- Conta
    this_cConta        = ""
    this_cDsConta      = ""

    *-- CPF/CNPJ
    this_cCpf          = ""

    *-- Responsavel / Vendedor
    this_cResps        = ""
    this_cDsResps      = ""

    *-- Moeda
    this_cMoeda        = ""
    this_cDsMoeda      = ""

    *-- Opcoes de filtro
    this_nSituacao     = 3
    this_nImpressao    = 1
    this_nCotacao      = 1
    this_cStatus       = ""

    *-- Grupo padrao de vendedores (SigCdPam.grpadvens) - carregado em Init
    this_cGrPadVens    = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = ""
        DODEFAULT()
        THIS.CarregarGrPadVens()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGrPadVens - Carrega o grupo padrao de vendedores de SigCdPam
    * Necessario para validacao de Responsavel via fAcessoContab
    *--------------------------------------------------------------------------
    FUNCTION CarregarGrPadVens()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT TOP 1 grpadvens AS GrPadVens FROM SigCdPam"

            IF USED("cursor_4c_ParamPam")
                USE IN cursor_4c_ParamPam
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ParamPam")

            IF loc_nResultado >= 1
                SELECT cursor_4c_ParamPam
                GO TOP
                IF !EOF("cursor_4c_ParamPam")
                    THIS.this_cGrPadVens = NVL(cursor_4c_ParamPam.GrPadVens, "")
                    loc_lResultado = .T.
                ENDIF
                USE IN cursor_4c_ParamPam
            ELSE
                THIS.this_cMensagemErro = "Erro ao carregar par" + CHR(226) + "metros SigCdPam"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida filtros antes de executar consulta
    * Retorna .T. se valido; popula this_cMensagemErro se invalido
    *--------------------------------------------------------------------------
    FUNCTION ValidarFiltros()
        THIS.this_cMensagemErro = ""

        IF EMPTY(ALLTRIM(THIS.this_cEmpresa))
            THIS.this_cMensagemErro = "Empresa Inv" + CHR(225) + "lida!!!"
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cNmOperacao))
            THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!"
            RETURN .F.
        ENDIF

        IF !EMPTY(THIS.this_dDtFinal) AND !EMPTY(THIS.this_dDtInicial)
            IF THIS.this_dDtFinal < THIS.this_dDtInicial
                THIS.this_cMensagemErro = "Per" + CHR(237) + "odo Inv" + CHR(225) + "lido!!! " + ;
                    "Data Final Menor do Que a Inicial!!!"
                RETURN .F.
            ENDIF
        ENDIF

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarConsulta - Executa a consulta principal contra SigMvCab
    * Cria cursor csTemporario com resultados indexados
    * Retorna .T. se encontrou registros, .F. caso contrario
    *--------------------------------------------------------------------------
    FUNCTION ExecutarConsulta()
        LOCAL loc_lResultado, loc_cSQL, loc_cWhere, loc_nResultado
        LOCAL loc_cEmp, loc_cNmO, loc_cGrupo, loc_cConta, loc_cResps, loc_cSta
        LOCAL loc_nEmpD, loc_nNrP, loc_nPen, loc_nOp, loc_nNum
        LOCAL loc_dDtI, loc_dDtF, loc_cDtISQL, loc_cDtFSQL, loc_cEmpFilter

        loc_lResultado = .F.

        TRY
            loc_cEmp    = ALLTRIM(THIS.this_cEmpresa)
            loc_cNmO    = ALLTRIM(THIS.this_cNmOperacao)
            loc_cGrupo  = ALLTRIM(THIS.this_cGrupo)
            loc_cConta  = ALLTRIM(THIS.this_cConta)
            loc_cResps  = ALLTRIM(THIS.this_cResps)
            loc_cSta    = ALLTRIM(THIS.this_cStatus)
            loc_nEmpD   = THIS.this_nEmpD
            loc_nNrP    = THIS.this_nPeriodo
            loc_nPen    = THIS.this_nSituacao
            loc_nOp     = THIS.this_nOp
            loc_nNum    = THIS.this_nNumero
            loc_dDtI    = THIS.this_dDtInicial
            loc_dDtF    = THIS.this_dDtFinal

            *-- Formata datas para SQL Server (com componente de hora)
            loc_cDtISQL = "'" + PADL(YEAR(loc_dDtI), 4, "0") + "-" + ;
                PADL(MONTH(loc_dDtI), 2, "0") + "-" + ;
                PADL(DAY(loc_dDtI), 2, "0") + " 00:00:00'"
            loc_cDtFSQL = "'" + PADL(YEAR(loc_dDtF), 4, "0") + "-" + ;
                PADL(MONTH(loc_dDtF), 2, "0") + "-" + ;
                PADL(DAY(loc_dDtF), 2, "0") + " 23:59:59'"

            *-- Monta WHERE replicando logica de consulta.Click do legado
            loc_cWhere = ""

            IF !EMPTY(loc_cNmO)
                loc_cWhere = loc_cWhere + "a.Dopes = " + EscaparSQL(loc_cNmO) + " And "
            ENDIF

            IF loc_nNrP = 1
                loc_cWhere = loc_cWhere + "a.Datas "
            ELSE
                loc_cWhere = loc_cWhere + "a.PrazoEnts "
            ENDIF
            loc_cWhere = loc_cWhere + "BetWeen " + loc_cDtISQL + " And " + loc_cDtFSQL + " And "

            IF !EMPTY(loc_cGrupo)
                loc_cWhere = loc_cWhere + "(a.GrupoOs = " + EscaparSQL(loc_cGrupo) + ;
                    " Or a.GrupoDs = " + EscaparSQL(loc_cGrupo) + ") And "
            ENDIF

            IF !EMPTY(loc_cConta)
                loc_cWhere = loc_cWhere + "(a.ContaOs = " + EscaparSQL(loc_cConta) + ;
                    " Or a.ContaDs = " + EscaparSQL(loc_cConta) + ") And "
            ENDIF

            IF loc_nOp > 0
                loc_cWhere = loc_cWhere + "a.Nops = " + FormatarNumeroSQL(loc_nOp, 0) + " And "
            ENDIF

            IF loc_nNum > 0
                loc_cWhere = loc_cWhere + "a.Numes = " + FormatarNumeroSQL(loc_nNum, 0) + " And "
            ENDIF

            IF !EMPTY(loc_cResps)
                loc_cWhere = loc_cWhere + "a.Vends = " + EscaparSQL(loc_cResps) + " And "
            ENDIF

            DO CASE
                CASE loc_nPen = 1
                    loc_cWhere = loc_cWhere + "a.ChkSubn = 0 And "
                CASE loc_nPen = 2
                    loc_cWhere = loc_cWhere + "a.ChkSubn = 1 And "
            ENDCASE

            IF !EMPTY(loc_cSta)
                loc_cWhere = loc_cWhere + "a.pStatus = " + EscaparSQL(loc_cSta) + " And "
            ENDIF

            *-- Filtro de empresa (com empresa destino opcional)
            loc_cEmpFilter = "(a.Emps = " + EscaparSQL(loc_cEmp)
            IF loc_nEmpD != 0
                loc_cEmpFilter = loc_cEmpFilter + " Or a.Empds = " + EscaparSQL(loc_cEmp)
            ENDIF
            loc_cEmpFilter = loc_cEmpFilter + ")"

            loc_cSQL = "Select a.* " + ;
                "From SigMvCab a, SigCdOpe b " + ;
                "Where " + loc_cEmpFilter + " And " + ;
                loc_cWhere + ;
                "a.Dopes = b.Dopes"

            IF USED("csTemporario")
                USE IN csTemporario
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "csTemporario")

            IF loc_nResultado >= 1
                SELECT csTemporario
                IF RECCOUNT("csTemporario") > 0
                    INDEX ON EmpDopNums TAG EmpDopNums
                    *-- Corrige PrazoEnts NULL (replica Update Set PrazoEnts = Iif(IsNull,Ctod(''),PrazoEnts))
                    REPLACE ALL prazoents WITH IIF(ISNULL(prazoents), CTOD(""), prazoents) IN csTemporario
                    GO TOP IN csTemporario
                    loc_lResultado = .T.
                ELSE
                    THIS.this_cMensagemErro = "Nenhum Registro Selecionado!!!"
                    USE IN csTemporario
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Falha ao executar consulta (csTemporario)"
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarCpfPorConta - Carrega CPF do cliente pelo codigo da conta (iclis)
    * Retorna o CPF (string) ou "" se nao encontrado
    *--------------------------------------------------------------------------
    FUNCTION CarregarCpfPorConta(par_cConta)
        LOCAL loc_cCpf, loc_cSQL, loc_nResultado
        loc_cCpf = ""

        IF EMPTY(ALLTRIM(par_cConta))
            RETURN ""
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 Cpfs FROM SigCdCli " + ;
                "WHERE iClis = " + EscaparSQL(PADR(ALLTRIM(par_cConta), 10))

            IF USED("cursor_4c_CpfCli")
                USE IN cursor_4c_CpfCli
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CpfCli")

            IF loc_nResultado >= 1
                SELECT cursor_4c_CpfCli
                IF !EOF("cursor_4c_CpfCli")
                    loc_cCpf = NVL(cursor_4c_CpfCli.Cpfs, "")
                ENDIF
                USE IN cursor_4c_CpfCli
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_cCpf
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarCpfCnpj - Valida CPF/CNPJ e localiza conta vinculada em SigCdCli
    * Retorna objeto Empty com: lValido, cConta, cDsConta, cCpf, cErro
    * Replica logica de Get_cpf.Valid do legado
    *--------------------------------------------------------------------------
    FUNCTION ValidarCpfCnpj(par_cCpfCnpj)
        LOCAL loc_oRet, loc_cCgc, loc_cCgc1, loc_nLen, loc_nVerCpfCgc, loc_nResultado

        loc_oRet = CREATEOBJECT("Empty")
        ADDPROPERTY(loc_oRet, "lValido",  .F.)
        ADDPROPERTY(loc_oRet, "cConta",   "")
        ADDPROPERTY(loc_oRet, "cDsConta", "")
        ADDPROPERTY(loc_oRet, "cCpf",     "")
        ADDPROPERTY(loc_oRet, "cErro",    "")

        IF EMPTY(ALLTRIM(par_cCpfCnpj))
            loc_oRet.lValido = .T.
            RETURN loc_oRet
        ENDIF

        loc_cCgc = STRTRAN(STRTRAN(STRTRAN(ALLTRIM(par_cCpfCnpj), ".", ""), "-", ""), "/", "")
        loc_nLen = LEN(ALLTRIM(loc_cCgc))
        loc_nVerCpfCgc = 0

        IF loc_nLen <> 14
            loc_cCgc1 = TRANSFORM(loc_cCgc, "@R 999.999.999-99")
            IF loc_nLen = 11
                loc_nVerCpfCgc = IIF(ValidarCPF(loc_cCgc1), 1, 2)
            ENDIF
        ELSE
            loc_cCgc1 = TRANSFORM(loc_cCgc, "@R 99.999.999/9999-99")
            loc_nVerCpfCgc = IIF(ValidarCNPJ(loc_cCgc1), 1, 2)
        ENDIF

        IF loc_nVerCpfCgc = 2
            loc_oRet.cErro = "CPF / CGC Incorreto !!!"
            RETURN loc_oRet
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 iclis, rclis, cpfs FROM SigCdCli " + ;
                "WHERE cpfs = " + EscaparSQL(PADR(ALLTRIM(loc_cCgc1), 20))

            IF USED("cursor_4c_BuscaCpf")
                USE IN cursor_4c_BuscaCpf
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCpf")

            IF loc_nResultado >= 1
                SELECT cursor_4c_BuscaCpf
                IF !EOF("cursor_4c_BuscaCpf")
                    loc_oRet.cConta   = NVL(cursor_4c_BuscaCpf.iclis, "")
                    loc_oRet.cDsConta = NVL(cursor_4c_BuscaCpf.rclis, "")
                    loc_oRet.cCpf     = NVL(cursor_4c_BuscaCpf.cpfs, "")
                    loc_oRet.lValido  = .T.
                ELSE
                    IF loc_nVerCpfCgc = 1
                        loc_oRet.cErro = "CPF / CGC n" + CHR(227) + "o encontrado !!!"
                    ELSE
                        loc_oRet.lValido = .T.
                    ENDIF
                ENDIF
                USE IN cursor_4c_BuscaCpf
            ELSE
                loc_oRet.cErro = "Falha ao buscar CPF/CGC em SigCdCli"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_oRet.cErro = loc_oErro.Message
        ENDTRY

        RETURN loc_oRet
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave composta de SigMvCab (Emps + Dopes + Nums)
    * Usada em RegistrarAuditoria para log de consulta/operacoes
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cEmpresa) + "|" + ;
               ALLTRIM(THIS.this_cNmOperacao) + "|" + ;
               ALLTRIM(TRANSFORM(THIS.this_nNumero))
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega chave e campos principais de SigMvCab
    * a partir da linha corrente do cursor (usado quando usuario seleciona
    * uma movimentacao no grid de resultados de ExecutarConsulta)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor " + par_cAliasCursor + " n" + CHR(227) + "o est" + CHR(225) + " aberto"
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAliasCursor)

            IF TYPE(par_cAliasCursor + ".emps") != "U"
                THIS.this_cEmpresa    = TratarNulo(emps, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".empds") != "U"
                THIS.this_nEmpD       = IIF(NVL(empds, "") != THIS.this_cEmpresa AND !EMPTY(NVL(empds, "")), 1, 0)
            ENDIF
            IF TYPE(par_cAliasCursor + ".dopes") != "U"
                THIS.this_cNmOperacao = TratarNulo(dopes, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".nops") != "U"
                THIS.this_nOp         = NVL(nops, 0)
            ENDIF
            IF TYPE(par_cAliasCursor + ".numes") != "U"
                THIS.this_nNumero     = NVL(numes, 0)
            ENDIF
            IF TYPE(par_cAliasCursor + ".grupos") != "U"
                THIS.this_cGrupo      = TratarNulo(grupos, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".iclis") != "U"
                THIS.this_cConta      = TratarNulo(iclis, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".vends") != "U"
                THIS.this_cResps      = TratarNulo(vends, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".datas") != "U"
                THIS.this_dDtInicial  = TratarNulo(datas, "D")
            ENDIF
            IF TYPE(par_cAliasCursor + ".prazoents") != "U"
                THIS.this_dDtFinal    = TratarNulo(prazoents, "D")
            ENDIF
            IF TYPE(par_cAliasCursor + ".pstatus") != "U"
                THIS.this_cStatus     = TratarNulo(pstatus, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".chksubn") != "U"
                THIS.this_nSituacao   = IIF(NVL(chksubn, .F.), 2, 1)
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrEs1BO.CarregarDoCursor")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - NAO APLICAVEL a form OPERACIONAL de consulta
    * SigPrEs1 (Posicao Por Movimentacao) apenas LE registros de SigMvCab
    * atraves de ExecutarConsulta. Inclusao de movimentacoes ocorre nos
    * forms de entrada de operacao (SigMvCab tem forms proprios de CRUD).
    * Metodo mantido para conformidade com contrato BusinessBase; sempre
    * retorna .F. com mensagem clara para prevenir uso indevido.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: SigPrEs1 " + CHR(233) + " form de consulta de posi" + ;
            CHR(231) + CHR(227) + "o por movimenta" + CHR(231) + CHR(227) + "o. " + ;
            "Utilize o form pr" + CHR(243) + "prio da opera" + CHR(231) + CHR(227) + ;
            "o para incluir movimenta" + CHR(231) + CHR(245) + "es."
        RETURN .F.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - NAO APLICAVEL a form OPERACIONAL de consulta
    * Mesma razao de Inserir(): SigPrEs1 apenas consulta SigMvCab.
    * Atualizacoes ocorrem nos forms de operacao correspondentes.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: SigPrEs1 " + CHR(233) + " form de consulta de posi" + ;
            CHR(231) + CHR(227) + "o por movimenta" + CHR(231) + CHR(227) + "o. " + ;
            "Utilize o form pr" + CHR(243) + "prio da opera" + CHR(231) + CHR(227) + ;
            "o para atualizar movimenta" + CHR(231) + CHR(245) + "es."
        RETURN .F.
    ENDFUNC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra em LogAuditoria a consulta executada
    * Sobrescreve BusinessBase para logar operacao "CONSULTA" com filtros
    * aplicados (empresa, operacao, periodo). DataHora usa GETDATE() (regra
    * canonica - GETDATE() rejeita tipo T).
    *--------------------------------------------------------------------------
    FUNCTION RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_cUsuario, loc_cDetalhes
        loc_lSucesso = .F.

        TRY
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                              ALLTRIM(gc_4c_UsuarioLogado), "SISTEMA")
            loc_cChave = THIS.ObterChavePrimaria()

            loc_cDetalhes = "Empresa=" + ALLTRIM(THIS.this_cEmpresa) + ;
                "; Operacao=" + ALLTRIM(THIS.this_cNmOperacao) + ;
                "; Periodo=" + DTOC(THIS.this_dDtInicial) + ".." + DTOC(THIS.this_dDtFinal)

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                "(Tabela, Operacao, ChaveRegistro, Usuario, DataHora, DadosNovos) " + ;
                "VALUES (" + ;
                EscaparSQL("SigPrEs1") + ", " + ;
                EscaparSQL(par_cOperacao) + ", " + ;
                EscaparSQL(loc_cChave) + ", " + ;
                EscaparSQL(loc_cUsuario) + ", " + ;
                "GETDATE(), " + ;
                EscaparSQL(loc_cDetalhes) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 1
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            *-- Falha de auditoria nao interrompe operacao principal
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE
