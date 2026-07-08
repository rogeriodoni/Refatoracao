*==============================================================================
* SIGPRCNBBO.prg - Business Object para Geracao de Arquivos CNAB - Cobranca
* Data: 2026-07-02
* Tabela principal: SigPcOol | PK: cidchaves
* Tabela de titulos: SigMvPar (via SigMvCab + SigCdCli + SigMvCcr)
* Tabela de operacoes: SigCdOpe (grid filtro com marca)
* Tabela de formas pgto: SigOpFp (lookup get_titban)
* Tabela de convenios: SigCdCeb (dados bancarios)
*==============================================================================

DEFINE CLASS SIGPRCNBBO AS BusinessBase

    *-- -----------------------------------------------------------------------
    *-- FILTROS DE TELA (pgfiltro - Page 1)
    *-- -----------------------------------------------------------------------

    *-- Empresa (get_cd_empresa / get_ds_empresa)
    this_cCdEmpresa        = ""    && emps      CHAR(3)  - Codigo empresa
    this_cDsEmpresa        = ""    && RazSocs   CHAR(40) - Razao social

    *-- Periodo (Get_Datai / Get_Dataf)
    this_dDatai            = {}    && Periodo inicial
    this_dDataf            = {}    && Periodo final

    *-- Opcao processados (optProcessados: 1=Nao Processados, 2=Ja Processados)
    this_nProcessados      = 1

    *-- Opcao periodo (optPeriodo: 1=Vencimento, 2=Emissao)
    this_nPeriodo          = 1

    *-- Conta bancaria (get_cd_car_conta / get_ds_car_conta)
    this_cCdConta          = ""    && IClis / GruContas CHAR(10) - Codigo conta
    this_cDsConta          = ""    && Descricao da conta CHAR(40)

    *-- Titulo banco (Get_titban) - codigo do titulo no banco
    this_cTitBan           = ""    && Fpags CHAR(12) - Titulo banco (FPagsGru)

    *-- -----------------------------------------------------------------------
    *-- ESTADO DO PROCESSAMENTO (pgdados - Page 2)
    *-- -----------------------------------------------------------------------

    *-- Spinner dias protesto (spndias, default=5)
    this_nDiasProt         = 5     && DiasProts NUMERIC - Dias para protesto

    *-- Caminho do arquivo CNAB gerado (montado em geracnab por banco)
    this_cArquivoCNAB      = ""    && Drive + ArqCnabs + seq + .REM

    *-- Codigo do banco do convenio ativo (ex: "001", "341", "237", "033")
    this_cBancoNr          = ""    && nbancos CHAR(3) - Codigo banco FEBRABAN

    *-- -----------------------------------------------------------------------
    *-- REGISTRO DE PROCESSAMENTO (SigPcOol)
    *-- -----------------------------------------------------------------------

    *-- Campos da tabela SigPcOol (usados em INSERT durante geracao CNAB)
    this_cCidChaves        = ""    && cidchaves   CHAR(20)      - Chave unica PK
    this_cTipos            = ""    && tipos       CHAR(10)      - Identificador ('SIGPRCNB')
    this_cEmps             = ""    && emps        CHAR(3)       - Empresa origem do titulo
    this_cDopes            = ""    && dopes       CHAR(20)      - Tipo operacao
    this_nNumes            = 0     && numes       NUMERIC(6,0)  - Numero operacao
    this_cEmpDs            = ""    && empds       CHAR(3)       - Empresa destino
    this_cDopeds           = ""    && dopeds      CHAR(20)      - Referencia titulo (SigMvCcr.Titulos)
    this_nNumeds           = 0     && numeds      NUMERIC(11,0) - Numero sequencial CNAB
    this_dDataS            = {}    && datas       DATETIME      - Data/hora geracao
    this_cUsuars           = ""    && usuars      CHAR(10)      - Usuario que gerou
    this_cProdutos         = ""    && produtos    TEXT          - Conteudo linha CNAB gerada
    this_cEdndests         = ""    && edndests    CHAR(29)      - EmpDopNums origem
    this_cEmpDopNums       = ""    && empdopnums  CHAR(29)      - Chave EmpDopNums titulo
    this_cProcessos        = ""    && processos   CHAR(20)      - Processo ('CNAB')
    this_nNopers           = 0     && nopers      NUMERIC(9,0)  - Numero operacao SigMvCcr

    *-- -----------------------------------------------------------------------
    *-- DADOS DO CONVENIO BANCARIO (SigCdCeb - carregado em geracnab/impboleto)
    *-- -----------------------------------------------------------------------
    this_cConvenio         = ""    && Convenios   CHAR - Codigo convenio
    this_cAgencia          = ""    && NAgencias   CHAR - Agencia empresa
    this_cDigitoAgencia    = ""    && DigiAgen    CHAR - Digito agencia
    this_cContaConv        = ""    && contas      CHAR - Conta do convenio
    this_cArqCnabs         = ""    && ArqCnabs    CHAR - Nome base do arquivo .REM
    this_cDrive            = ""    && Drive       CHAR - Drive de destino do arquivo
    this_cTpCtArq          = ""    && TpCtArqs    CHAR - Tipo conta arquivo
    this_cTpCtBol          = ""    && TpCtBols    CHAR - Tipo conta boleto
    this_cBancos           = ""    && bancos      CHAR - Razao social banco
    this_nMoras            = 0     && Moras       NUMERIC - Indice de mora/dia
    this_cInstrus          = ""    && Instrus     CHAR - Primeira instrucao
    this_nDiasProtConvenio = 0     && DiasProts   NUMERIC - Dias para protesto (config convenio)
    this_nBcoImprime       = 0     && bcoimprime  NUMERIC - 1=Banco emite boleto
    this_cGruposConv       = ""    && Grupos      CHAR - Grupo da conta no convenio
    this_nMsgMulta         = 0     && MsgMulta    NUMERIC - 1=Gerar mensagem de multa

    *-- -----------------------------------------------------------------------
    *-- DADOS DA EMPRESA (SigCdEmp - carregado em geracnab)
    *-- -----------------------------------------------------------------------
    this_cRazSocs          = ""    && RazSocs     CHAR - Razao social empresa
    this_cCgcs             = ""    && Cgcs        CHAR - CNPJ/CPF empresa
    this_cTel1s            = ""    && Tel1s       CHAR - Telefone
    this_cCepsEmp          = ""    && Ceps        CHAR - CEP empresa
    this_cEndesEmp         = ""    && Endes       CHAR - Endereco empresa
    this_cNumerosEmp       = ""    && Numeros     CHAR - Numero endereco
    this_cBairsEmp         = ""    && Bairs       CHAR - Bairro
    this_cCidasEmp         = ""    && Cidas       CHAR - Cidade
    this_cEstasEmp         = ""    && Estas       CHAR - Estado (UF)
    this_cComplsEmp        = ""    && Compls      CHAR - Complemento

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigPcOol"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave primaria do registro atual
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do cursor para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves    = TratarNulo(cidchaves,    "C")
                THIS.this_cTipos        = TratarNulo(tipos,        "C")
                THIS.this_cEmps         = TratarNulo(emps,         "C")
                THIS.this_cDopes        = TratarNulo(dopes,        "C")
                THIS.this_nNumes        = TratarNulo(numes,        "N")
                THIS.this_cEmpDs        = TratarNulo(empds,        "C")
                THIS.this_cDopeds       = TratarNulo(dopeds,       "C")
                THIS.this_nNumeds       = TratarNulo(numeds,       "N")
                THIS.this_dDataS        = TratarNulo(datas,        "D")
                THIS.this_cUsuars       = TratarNulo(usuars,       "C")
                THIS.this_cProdutos     = TratarNulo(produtos,     "C")
                THIS.this_cEdndests     = TratarNulo(edndests,     "C")
                THIS.this_cEmpDopNums   = TratarNulo(empdopnums,   "C")
                THIS.this_cProcessos    = TratarNulo(processos,    "C")
                THIS.this_nNopers       = TratarNulo(nopers,       "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados obrigatorios antes de Inserir/Atualizar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cEmps))
            MsgAviso("Empresa " + CHR(233) + " obrigat" + CHR(243) + "ria.", ;
                "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        IF EMPTY(ALLTRIM(THIS.this_cProcessos))
            MsgAviso("Processo " + CHR(233) + " obrigat" + CHR(243) + "rio.", ;
                "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro em SigPcOol
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cCidChaves = PADR(LOWER(SYS(2015)) + LOWER(SYS(2015)), 20)
            ENDIF

            loc_cSQL = "INSERT INTO SigPcOol " + ;
                "(cidchaves, tipos, emps, dopes, numes, empds, dopeds, numeds, " + ;
                " datas, usuars, produtos, edndests, empdopnums, processos, nopers) " + ;
                "VALUES (" + ;
                EscaparSQL(THIS.this_cCidChaves)    + ", " + ;
                EscaparSQL(THIS.this_cTipos)        + ", " + ;
                EscaparSQL(THIS.this_cEmps)         + ", " + ;
                EscaparSQL(THIS.this_cDopes)        + ", " + ;
                FormatarNumeroSQL(THIS.this_nNumes) + ", " + ;
                EscaparSQL(THIS.this_cEmpDs)        + ", " + ;
                EscaparSQL(THIS.this_cDopeds)       + ", " + ;
                FormatarNumeroSQL(THIS.this_nNumeds) + ", " + ;
                "GETDATE(), " + ;
                EscaparSQL(gc_4c_UsuarioLogado)     + ", " + ;
                EscaparSQL(THIS.this_cProdutos)     + ", " + ;
                EscaparSQL(THIS.this_cEdndests)     + ", " + ;
                EscaparSQL(THIS.this_cEmpDopNums)   + ", " + ;
                EscaparSQL(THIS.this_cProcessos)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nNopers) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("I")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir registro em SigPcOol.", "Inserir")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro em SigPcOol pela chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigPcOol SET " + ;
                "tipos = "        + EscaparSQL(THIS.this_cTipos)         + ", " + ;
                "emps = "         + EscaparSQL(THIS.this_cEmps)          + ", " + ;
                "dopes = "        + EscaparSQL(THIS.this_cDopes)         + ", " + ;
                "numes = "        + FormatarNumeroSQL(THIS.this_nNumes)   + ", " + ;
                "empds = "        + EscaparSQL(THIS.this_cEmpDs)         + ", " + ;
                "dopeds = "       + EscaparSQL(THIS.this_cDopeds)        + ", " + ;
                "numeds = "       + FormatarNumeroSQL(THIS.this_nNumeds)  + ", " + ;
                "usuars = "       + EscaparSQL(gc_4c_UsuarioLogado)      + ", " + ;
                "produtos = "     + EscaparSQL(THIS.this_cProdutos)      + ", " + ;
                "edndests = "     + EscaparSQL(THIS.this_cEdndests)      + ", " + ;
                "empdopnums = "   + EscaparSQL(THIS.this_cEmpDopNums)    + ", " + ;
                "processos = "    + EscaparSQL(THIS.this_cProcessos)     + ", " + ;
                "nopers = "       + FormatarNumeroSQL(THIS.this_nNopers) + ;
                " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("A")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar registro em SigPcOol.", "Atualizar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarOperacoes - Carrega SigCdOpe no cursor_4c_Operacoes com campo marca
    * Equivalente ao Init: select dopes, .F. as marca from SigCdOpe where Parcontas=1 And ValPends=1
    *--------------------------------------------------------------------------
    PROCEDURE BuscarOperacoes()
        LOCAL loc_lSucesso, loc_cSQL, loc_lFalso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Operacoes")
                TABLEREVERT(.T., "cursor_4c_Operacoes")
                USE IN cursor_4c_Operacoes
            ENDIF

            loc_lFalso = .F.
            loc_cSQL = "SELECT Dopes, ?loc_lFalso AS marca FROM SigCdOpe " + ;
                "WHERE Parcontas = 1 AND ValPends = 1 ORDER BY Dopes"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacoes") > 0
                SELECT cursor_4c_Operacoes
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar opera" + CHR(231) + CHR(245) + "es.", "BuscarOperacoes")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao BuscarOperacoes")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarFormaPagamento - Carrega SigOpFp em cursor_4c_FormaPagto para lookup titban
    * Equivalente ao Init: Select * From SigOpFp Where Situas in ('R','A') And Infos='K'
    *--------------------------------------------------------------------------
    PROCEDURE BuscarFormaPagamento()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_FormaPagto")
                USE IN cursor_4c_FormaPagto
            ENDIF

            IF SQLEXEC(gnConnHandle, ;
                "SELECT * FROM SigOpFp WHERE Situas IN ('R','A') AND Infos = 'K'", ;
                "cursor_4c_FormaPagto") > 0
                SELECT cursor_4c_FormaPagto
                INDEX ON Fpags TAG FpagSgru
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar formas de pagamento.", "BuscarFormaPagamento")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao BuscarFormaPagamento")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarEmpresa - Carrega dados da empresa; popula this_c* e cursor_4c_Empresa
    * par_cCodEmp: codigo da empresa (Cemps em SigCdEmp)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarEmpresa(par_cCodEmp)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Empresa")
                USE IN cursor_4c_Empresa
            ENDIF

            loc_cSQL = "SELECT RazSocs, Cgcs, Tel1s, Ceps, Endes, Numeros, " + ;
                "Bairs, Cidas, Estas, Compls " + ;
                "FROM SigCdEmp WHERE Cemps = " + EscaparSQL(par_cCodEmp)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Empresa") > 0
                SELECT cursor_4c_Empresa
                GO TOP
                IF !EOF("cursor_4c_Empresa")
                    THIS.this_cRazSocs      = TratarNulo(cursor_4c_Empresa.RazSocs,    "C")
                    THIS.this_cCgcs         = TratarNulo(cursor_4c_Empresa.Cgcs,       "C")
                    THIS.this_cTel1s        = TratarNulo(cursor_4c_Empresa.Tel1s,      "C")
                    THIS.this_cCepsEmp      = TratarNulo(cursor_4c_Empresa.Ceps,       "C")
                    THIS.this_cEndesEmp     = TratarNulo(cursor_4c_Empresa.Endes,      "C")
                    THIS.this_cNumerosEmp   = TratarNulo(cursor_4c_Empresa.Numeros,    "C")
                    THIS.this_cBairsEmp     = TratarNulo(cursor_4c_Empresa.Bairs,      "C")
                    THIS.this_cCidasEmp     = TratarNulo(cursor_4c_Empresa.Cidas,      "C")
                    THIS.this_cEstasEmp     = TratarNulo(cursor_4c_Empresa.Estas,      "C")
                    THIS.this_cComplsEmp    = TratarNulo(cursor_4c_Empresa.Compls,     "C")
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                MsgErro("Erro ao carregar empresa.", "CarregarEmpresa")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao CarregarEmpresa")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarConvenio - Carrega convenio bancario; popula this_c* e cursor_4c_Convenio
    * par_cConta: codigo da conta bancaria (IClis em SigCdCli)
    * Busca Grupos em SigCdCli, depois SigCdCeb WHERE GruContas = Grupos+Conta
    *--------------------------------------------------------------------------
    PROCEDURE CarregarConvenio(par_cConta)
        LOCAL loc_lSucesso, loc_cGrupos, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            *-- 1. Busca grupo da conta em SigCdCli
            loc_cGrupos = ""
            IF SQLEXEC(gnConnHandle, ;
                "SELECT Grupos FROM SigCdCli WHERE IClis = " + EscaparSQL(par_cConta), ;
                "cursor_4c_BancoGrupo") > 0
                SELECT cursor_4c_BancoGrupo
                GO TOP
                IF !EOF("cursor_4c_BancoGrupo")
                    loc_cGrupos = TratarNulo(cursor_4c_BancoGrupo.Grupos, "C")
                ENDIF
                USE IN cursor_4c_BancoGrupo
            ENDIF

            *-- 2. Busca convenio em SigCdCeb
            IF USED("cursor_4c_Convenio")
                USE IN cursor_4c_Convenio
            ENDIF

            loc_cSQL = "SELECT * FROM SigCdCeb " + ;
                "WHERE GruContas = " + ;
                EscaparSQL(ALLTRIM(loc_cGrupos) + ALLTRIM(par_cConta)) + ;
                " AND NAgencias <> SPACE(6) AND Convenios <> SPACE(9) " + ;
                "ORDER BY NAgencias, Convenios"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Convenio") > 0
                SELECT cursor_4c_Convenio
                GO TOP
                IF !EOF("cursor_4c_Convenio")
                    THIS.this_cConvenio         = TratarNulo(cursor_4c_Convenio.Convenios,  "C")
                    THIS.this_cAgencia          = TratarNulo(cursor_4c_Convenio.NAgencias,  "C")
                    THIS.this_cDigitoAgencia    = TratarNulo(cursor_4c_Convenio.DigiAgen,   "C")
                    THIS.this_cContaConv        = TratarNulo(cursor_4c_Convenio.contas,     "C")
                    THIS.this_cArqCnabs         = TratarNulo(cursor_4c_Convenio.ArqCnabs,   "C")
                    THIS.this_cDrive            = TratarNulo(cursor_4c_Convenio.Drive,      "C")
                    THIS.this_cTpCtArq          = TratarNulo(cursor_4c_Convenio.TpCtArqs,   "C")
                    THIS.this_cTpCtBol          = TratarNulo(cursor_4c_Convenio.TpCtBols,   "C")
                    THIS.this_cBancos           = TratarNulo(cursor_4c_Convenio.bancos,     "C")
                    THIS.this_nMoras            = TratarNulo(cursor_4c_Convenio.Moras,      "N")
                    THIS.this_cInstrus          = TratarNulo(cursor_4c_Convenio.Instrus,    "C")
                    THIS.this_nDiasProtConvenio = TratarNulo(cursor_4c_Convenio.DiasProts,  "N")
                    THIS.this_nBcoImprime       = TratarNulo(cursor_4c_Convenio.bcoimprime, "N")
                    THIS.this_cGruposConv       = TratarNulo(cursor_4c_Convenio.Grupos,     "C")
                    THIS.this_nMsgMulta         = TratarNulo(cursor_4c_Convenio.MsgMulta,   "N")
                    THIS.this_cBancoNr          = TratarNulo(cursor_4c_Convenio.nbancos,    "C")
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                MsgErro("Erro ao carregar conv" + CHR(234) + "nio.", "CarregarConvenio")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao CarregarConvenio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarTitulos - Executa query de processamento e carrega cursor_4c_Filtro
    * Equivalente ao PROCEDURE processamento do legado
    * par_cEmp: codigo da empresa
    * par_dDatai / par_dDataf: periodo
    * par_nProcessados: 1=Nao processados, 2=Ja processados
    * par_nPeriodo: 1=Vencimento, 2=Emissao
    * par_cOpeIN: clausula IN formatada ex: ('VENDA','COBRANCA')
    *--------------------------------------------------------------------------
    PROCEDURE BuscarTitulos(par_cEmp, par_dDatai, par_dDataf, par_nProcessados, par_nPeriodo, par_cOpeIN)
        LOCAL loc_lSucesso, loc_cSQL, loc_lMarca, loc_dDatai, loc_dDataf, loc_cEmpParam, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Filtro")
                TABLEREVERT(.T., "cursor_4c_Filtro")
                USE IN cursor_4c_Filtro
            ENDIF

            *-- Variaveis para parametros SQLEXEC (?var resolve na scope local)
            loc_lMarca    = .T.
            loc_dDatai    = par_dDatai
            loc_dDataf    = par_dDataf
            loc_cEmpParam = par_cEmp

            loc_cSQL = "SELECT ?loc_lMarca AS marca, e.titulos, a.dopes, a.numes, d.rclis, " + ;
                "a.vencs, b.fpags, a.valos, a.datas, a.vpags, " + ;
                "d.iclis, d.endes, d.cidas, d.estas, d.nums, d.compls, " + ;
                "d.bairs, d.ceps, d.cpfs, a.emps, a.empdopnums, a.nopers, d.Razaos, " + ;
                "d.endcobs, d.cepcobs, d.estcobs, d.baicobs, d.cidcobs, " + ;
                "CASE WHEN d.EndCobs <> '' AND LEN(RTRIM(d.EndCobs)) > 40 THEN 1 " + ;
                "ELSE CASE WHEN d.Endes <> '' AND " + ;
                "LEN(RTRIM(d.Endes) + ' ' + RTRIM(d.Nums) + ' ' + RTRIM(d.compls)) > 40 " + ;
                "THEN 1 ELSE 0 END END AS EndErro " + ;
                "FROM SigMvPar a " + ;
                "INNER JOIN SigOpFp b ON a.fpags = b.fpags " + ;
                "LEFT JOIN SigMvCab c ON a.empdopnums = c.empdopnums " + ;
                "LEFT JOIN SigCdCli d ON c.contads = d.iclis " + ;
                "LEFT JOIN SigMvCcr e ON a.empdopnums = e.empdopnums AND a.nopers = e.nopers " + ;
                "WHERE b.infos = 'B' AND a.vpags = 0 " + ;
                "AND " + IIF(par_nPeriodo = 1, "a.Vencs", "e.DtEmis") + ;
                " BETWEEN ?loc_dDatai AND ?loc_dDataf " + ;
                "AND e.opers = 'C' " + ;
                "AND c.emps = ?loc_cEmpParam " + ;
                "AND a.dopes IN " + par_cOpeIN + ;
                " AND a.EmpDopNums + e.titulos " + ;
                IIF(par_nProcessados = 1, "NOT ", "") + ;
                "IN (SELECT e2.EmpDopNums + SUBSTRING(e2.dopeds, 1, 10) " + ;
                "    FROM SigPcOol e2 WHERE e2.Tipos = 'SIGPRCNB') " + ;
                "ORDER BY a.dopes, a.numes"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Filtro") > 0
                SELECT cursor_4c_Filtro
                GO TOP
                IF !EOF("cursor_4c_Filtro")
                    REPLACE ALL marca WITH .F. FOR EndErro = 1
                    GO TOP
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar t" + CHR(237) + "tulos para processamento.", "BuscarTitulos")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao BuscarTitulos")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InserirLinhaCNAB - Insere linha CNAB em SigPcOol diretamente via SQLEXEC
    * par_cEmpDopNums: chave EmpDopNums do titulo
    * par_cEmps: codigo empresa
    * par_cDopes: codigo operacao
    * par_nNumes: numero da operacao
    * par_cConteudo: conteudo da linha CNAB (texto do arquivo .REM)
    * par_cDopeDs: referencia do titulo (SigMvCcr.Titulos)
    * par_nNumeDs: numero sequencial CNAB gerado (SeqNums)
    * Retorna: cidchaves gerado ou "" se falhou
    *--------------------------------------------------------------------------
    PROCEDURE InserirLinhaCNAB(par_cEmpDopNums, par_cEmps, par_cDopes, par_nNumes, par_cConteudo, par_cDopeDs, par_nNumeDs)
        LOCAL loc_cCidChaves, loc_cSQL, loc_oErro
        loc_cCidChaves = ""
        TRY
            loc_cCidChaves = PADR(LOWER(SYS(2015)) + LOWER(SYS(2015)), 20)

            loc_cSQL = "INSERT INTO SigPcOol " + ;
                "(empdopnums, emps, dopes, numes, usuars, tipos, processos, " + ;
                " produtos, DataS, cidchaves, dopeds, numeds) VALUES (" + ;
                EscaparSQL(par_cEmpDopNums)         + ", " + ;
                EscaparSQL(par_cEmps)               + ", " + ;
                EscaparSQL(par_cDopes)              + ", " + ;
                FormatarNumeroSQL(par_nNumes)       + ", " + ;
                EscaparSQL(gc_4c_UsuarioLogado)     + ", " + ;
                "'SIGPRCNB', " + ;
                "'CNAB', " + ;
                EscaparSQL(par_cConteudo)           + ", " + ;
                "GETDATE(), " + ;
                EscaparSQL(loc_cCidChaves)          + ", " + ;
                EscaparSQL(par_cDopeDs)             + ", " + ;
                FormatarNumeroSQL(par_nNumeDs) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) <= 0
                loc_cCidChaves = ""
                MsgErro("Erro ao inserir linha CNAB em SigPcOol.", "InserirLinhaCNAB")
            ENDIF
        CATCH TO loc_oErro
            loc_cCidChaves = ""
            MsgErro(loc_oErro.Message, "Erro ao InserirLinhaCNAB")
        ENDTRY
        RETURN loc_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarTituloBanco - Verifica TitBans atual em SigMvCcr
    * Retorna "" se nao preenchido, ou valor atual se ja preenchido
    *--------------------------------------------------------------------------
    PROCEDURE VerificarTituloBanco(par_cEmpDopNums, par_nNopers)
        LOCAL loc_cTitBanAtual, loc_cSQL, loc_oErro
        loc_cTitBanAtual = ""
        TRY
            loc_cSQL = "SELECT Titulos, TitBans FROM SigMvCcr " + ;
                "WHERE EmpDopNums = " + EscaparSQL(par_cEmpDopNums) + ;
                " AND Nopers = " + FormatarNumeroSQL(par_nNopers)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigMvCcr") > 0
                SELECT cursor_4c_SigMvCcr
                GO TOP
                IF !EOF("cursor_4c_SigMvCcr")
                    loc_cTitBanAtual = TratarNulo(cursor_4c_SigMvCcr.TitBans, "C")
                ENDIF
                USE IN cursor_4c_SigMvCcr
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao VerificarTituloBanco")
        ENDTRY
        RETURN loc_cTitBanAtual
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarTituloBanco - Atualiza TitBans em SigMvCcr
    * par_cEmpDopNums: chave do movimento de conta corrente
    * par_nNopers: numero da operacao
    * par_cTitBan: novo valor do titulo banco (12 chars)
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarTituloBanco(par_cEmpDopNums, par_nNopers, par_cTitBan)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigMvCcr SET TitBans = " + EscaparSQL(par_cTitBan) + ;
                " WHERE EmpDopNums = " + EscaparSQL(par_cEmpDopNums) + ;
                " AND Nopers = " + FormatarNumeroSQL(par_nNopers)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar T" + CHR(237) + "tulo Banco.", "AtualizarTituloBanco")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao AtualizarTituloBanco")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarUltimoNumeDs - Busca ultimo NumeDs gerado para um titulo (reimprimir)
    * par_cDopeDs: referencia do titulo (campo titulos em SigMvCcr)
    * Retorna: numeds como N ou 0 se nao encontrado
    *--------------------------------------------------------------------------
    PROCEDURE BuscarUltimoNumeDs(par_cDopeDs)
        LOCAL loc_nNumeDs, loc_cSQL, loc_oErro
        loc_nNumeDs = 0
        TRY
            loc_cSQL = "SELECT TOP 1 NumeDs FROM SigPcOol " + ;
                "WHERE Processos = 'CNAB' AND DopeDs = " + EscaparSQL(par_cDopeDs) + ;
                " ORDER BY Datas DESC"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PcOolUlt") > 0
                SELECT cursor_4c_PcOolUlt
                GO TOP
                IF !EOF("cursor_4c_PcOolUlt")
                    loc_nNumeDs = TratarNulo(cursor_4c_PcOolUlt.NumeDs, "N")
                ENDIF
                USE IN cursor_4c_PcOolUlt
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao BuscarUltimoNumeDs")
        ENDTRY
        RETURN loc_nNumeDs
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfirmarTransacao - Confirma todos os INSERTs CNAB (SQLCOMMIT)
    *--------------------------------------------------------------------------
    PROCEDURE ConfirmarTransacao()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF SQLCOMMIT(gnConnHandle) > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao confirmar transa" + CHR(231) + CHR(227) + "o CNAB.", "ConfirmarTransacao")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao ConfirmarTransacao")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CancelarTransacao - Desfaz INSERTs CNAB em caso de falha (SQLROLLBACK)
    *--------------------------------------------------------------------------
    PROCEDURE CancelarTransacao()
        LOCAL loc_oErro
        TRY
            SQLROLLBACK(gnConnHandle)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao CancelarTransacao")
        ENDTRY
    ENDPROC

ENDDEFINE
