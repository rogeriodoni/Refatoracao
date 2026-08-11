*==============================================================================
* SIGPGCNBBO.prg - Business Object para Geracao de Arquivos CNAB - Pagamentos
* Data: 2026-06-19
* Tabela principal: SigPcOol | PK: cidchaves
* Tabela de operacoes: SigMvCcr (leitura) | SigCdCeb (convenios)
*==============================================================================

DEFINE CLASS SIGPGCNBBO AS BusinessBase

    *-- -----------------------------------------------------------------------
    *-- FILTROS DE TELA (pgfiltro)
    *-- -----------------------------------------------------------------------

    *-- Empresa (get_cd_empresa / get_ds_empresa)
    this_cCdEmpresa        = ""    && Emps     CHAR(3)  - C" + CHR(243) + "digo empresa
    this_cDsEmpresa        = ""    && RazSocs  CHAR(40) - Raz" + CHR(227) + "o social

    *-- Per" + CHR(237) + "odo (Get_Datai / Get_Dataf)
    this_dDatai            = {}    && Per" + CHR(237) + "odo inicial
    this_dDataf            = {}    && Per" + CHR(237) + "odo final

    *-- Op" + CHR(231) + CHR(227) + "o processados (optProcessados: 1=N" + CHR(227) + "o Processados, 2=J" + CHR(225) + " Processados)
    this_nProcessados      = 1

    *-- Op" + CHR(231) + CHR(227) + "o per" + CHR(237) + "odo (optPeriodo: 1=Vencimento, 2=Emiss" + CHR(227) + "o)
    this_nPeriodo          = 1

    *-- Conta banc" + CHR(225) + "ria (get_cd_car_conta / get_ds_car_conta)
    this_cCdConta          = ""    && IClis / GruContas CHAR(10) - C" + CHR(243) + "digo conta
    this_cDsConta          = ""    && Descri" + CHR(231) + CHR(227) + "o da conta CHAR(40)

    *-- Empresa do conv" + CHR(234) + "nio (getCEmpc / getDEmpc)
    this_cCdEmpConvenio    = ""    && Cemps    CHAR(3)  - C" + CHR(243) + "digo empresa conv" + CHR(234) + "nio
    this_cDsEmpConvenio    = ""    && RazSocs  CHAR(40) - Descri" + CHR(231) + CHR(227) + "o empresa conv" + CHR(234) + "nio

    *-- -----------------------------------------------------------------------
    *-- ESTADO DO PROCESSAMENTO (pgdados)
    *-- -----------------------------------------------------------------------

    *-- Spinner dias protesto (spndias, default=5)
    this_nDiasProt         = 5     && DiasProts NUMERIC - Dias para protestos

    *-- Caminho do arquivo CNAB gerado
    this_cArquivoCNAB      = ""    && Drive + ArqCnabs - Caminho completo do .REM

    *-- C" + CHR(243) + "digo do banco do conv" + CHR(234) + "nio ativo (ex: "001", "341", "237", "033")
    this_cBancoNr          = ""    && nbancos CHAR(3) - C" + CHR(243) + "digo banco FEBRABAN

    *-- -----------------------------------------------------------------------
    *-- REGISTRO DE PROCESSAMENTO (SigPcOol)
    *-- -----------------------------------------------------------------------

    *-- Campos da tabela SigPcOol (usados em INSERT)
    this_cDopes            = ""    && dopes     CHAR    - Tipo operacao ('C' = CNAB)
    this_nNopers           = 0     && nopers    NUMERIC - N" + CHR(250) + "mero operacao de SigMvCcr
    this_cUsuars           = ""    && usuars    CHAR    - Usu" + CHR(225) + "rio que gerou
    this_cTipos            = ""    && tipos     CHAR    - Identificador ('SIGPGCNB')
    this_cProcessos        = ""    && processos CHAR    - Processo ('CNAB')
    this_cProdutos         = ""    && produtos  MEMO    - Conte" + CHR(250) + "do do arquivo gerado
    this_dDataS            = {}    && DataS     DATETIME - Data/hora de geracao
    this_cCidChaves        = ""    && cidchaves CHAR    - Chave " + CHR(250) + "nica (PK)
    this_cDopeds           = ""    && dopeds    CHAR    - Referencia doc (titulo)
    this_cEdndests         = ""    && edndests  CHAR    - Chave destino (titulo+nopers)

    *-- -----------------------------------------------------------------------
    *-- DADOS DO CONVENIO BANCARIO (SigCdCeb - carregado em geracnab)
    *-- -----------------------------------------------------------------------
    this_cConvenio         = ""    && Convenios  CHAR - C" + CHR(243) + "digo conv" + CHR(234) + "nio
    this_cAgencia          = ""    && NAgencias  CHAR - Ag" + CHR(234) + "ncia empresa
    this_cDigitoAgencia    = ""    && DigiAgen   CHAR - D" + CHR(237) + "gito ag" + CHR(234) + "ncia
    this_cContaConv        = ""    && contas     CHAR - Conta do conv" + CHR(234) + "nio
    this_cArqCnabs         = ""    && ArqCnabs   CHAR - Nome base do arquivo
    this_cDrive            = ""    && Drive      CHAR - Drive de destino
    this_cTpCtArq          = ""    && TpCtArqs   CHAR - Tipo conta arquivo
    this_cTpCtBol          = ""    && TpCtBols   CHAR - Tipo conta boleto
    this_cBancos           = ""    && bancos     CHAR - Raz" + CHR(227) + "o social banco

    *-- -----------------------------------------------------------------------
    *-- DADOS DA EMPRESA (SigCdEmp - carregado em geracnab)
    *-- -----------------------------------------------------------------------
    this_cRazSocs          = ""    && RazSocs   CHAR - Raz" + CHR(227) + "o social empresa
    this_cCgcs             = ""    && Cgcs      CHAR - CNPJ/CPF empresa
    this_cEndesEmp         = ""    && Endes     CHAR - Endere" + CHR(231) + "o empresa
    this_cNumerosEmp       = ""    && Numeros   CHAR - N" + CHR(250) + "mero endere" + CHR(231) + "o
    this_cComplsEmp        = ""    && Compls    CHAR - Complemento
    this_cBairsEmp         = ""    && Bairs     CHAR - Bairro
    this_cCidasEmp         = ""    && Cidas     CHAR - Cidade
    this_cCepsEmp          = ""    && Ceps      CHAR - CEP
    this_cEstasEmp         = ""    && Estas     CHAR - Estado (UF)

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
    * Usado pelo sistema de auditoria do BusinessBase
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves  = TratarNulo(cidchaves, "C")
            THIS.this_cDopes      = TratarNulo(dopes, "C")
            THIS.this_nNopers     = TratarNulo(nopers, "N")
            THIS.this_cUsuars     = TratarNulo(usuars, "C")
            THIS.this_cTipos      = TratarNulo(tipos, "C")
            THIS.this_cProcessos  = TratarNulo(processos, "C")
            THIS.this_cProdutos   = TratarNulo(produtos, "C")
            THIS.this_cDopeds     = TratarNulo(dopeds, "C")
            THIS.this_cEdndests   = TratarNulo(edndests, "C")
            IF TYPE("DataS") != "U"
                THIS.this_dDataS  = TratarNulo(DataS, "D")
            ENDIF
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere um registro de processamento CNAB em SigPcOol
    * Chamado para cada linha/segmento gerado durante geracao do arquivo CNAB
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        LOCAL loc_cProdutos
        loc_lSucesso = .F.
        TRY
            THIS.this_cCidChaves = ALLTRIM(fUniqueIds())
            THIS.this_cUsuars    = ALLTRIM(gc_4c_UsuarioLogado)
            THIS.this_cTipos     = "SIGPGCNB"
            THIS.this_cProcessos = "CNAB"

            loc_cProdutos = THIS.this_cProdutos

            loc_cSQL = "INSERT INTO SigPcOol " + ;
                       "(dopes, nopers, usuars, tipos, processos, produtos, DataS, cidchaves, dopeds, edndests)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cDopes) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNopers) + ", " + ;
                       EscaparSQL(THIS.this_cUsuars) + ", " + ;
                       EscaparSQL(THIS.this_cTipos) + ", " + ;
                       EscaparSQL(THIS.this_cProcessos) + ", " + ;
                       "?loc_cProdutos, " + ;
                       "GETDATE(), " + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cDopeds) + ", " + ;
                       EscaparSQL(THIS.this_cEdndests) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 1
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir registro em SigPcOol." + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao inserir em SigPcOol:" + CHR(13) + ;
                        loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro de processamento CNAB em SigPcOol
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        LOCAL loc_cProdutos
        loc_lSucesso = .F.
        TRY
            loc_cProdutos = THIS.this_cProdutos

            loc_cSQL = "UPDATE SigPcOol" + ;
                       " SET dopes     = " + EscaparSQL(THIS.this_cDopes) + ;
                       ",    nopers    = " + FormatarNumeroSQL(THIS.this_nNopers) + ;
                       ",    usuars    = " + EscaparSQL(THIS.this_cUsuars) + ;
                       ",    tipos     = " + EscaparSQL(THIS.this_cTipos) + ;
                       ",    processos = " + EscaparSQL(THIS.this_cProcessos) + ;
                       ",    produtos  = ?loc_cProdutos" + ;
                       ",    dopeds    = " + EscaparSQL(THIS.this_cDopeds) + ;
                       ",    edndests  = " + EscaparSQL(THIS.this_cEdndests) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 1
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar registro em SigPcOol." + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao atualizar em SigPcOol:" + CHR(13) + ;
                        loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarGrupos - Carrega grupos de fornecedores (SigCdGcr) para grid filtro
    * Cria cursor_4c_Grupos com campos: codigos, descrs, marca (bool=.F.)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarGrupos()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro, loc_lFalso
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_GruposTemp")
                USE IN cursor_4c_GruposTemp
            ENDIF
            loc_lFalso = .F.
            loc_cSQL = "SELECT Codigos, Descrs, ?loc_lFalso AS marca FROM SigCdGcr" + ;
                       " WHERE PadPgRecs IN (4,2) ORDER BY Codigos"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruposTemp") >= 1
                IF USED("cursor_4c_Grupos")
                    USE IN cursor_4c_Grupos
                ENDIF
                SET NULL ON
                CREATE CURSOR cursor_4c_Grupos (codigos C(9) NULL, descrs C(40) NULL, marca L NULL)
                SET NULL OFF
                SELECT cursor_4c_Grupos
                APPEND FROM DBF("cursor_4c_GruposTemp")
                SELECT cursor_4c_Grupos
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar grupos de fornecedores." + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
            IF USED("cursor_4c_GruposTemp")
                USE IN cursor_4c_GruposTemp
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em BuscarGrupos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarOperacoes - Consulta operacoes de pagamento em SigMvCcr
    * Parametros:
    *   par_cCodEmp        - Codigo da empresa
    *   par_cCodConta      - Codigo da conta bancaria (get_cd_car_conta)
    *   par_dDatai         - Data inicial do periodo
    *   par_dDataf         - Data final do periodo
    *   par_lNaoProc       - .T.=Nao Processados, .F.=Ja Processados
    *   par_nPeriodo       - 1=Vencimento, 2=Emissao
    *   par_cGrupos        - Lista SQL de grupos marcados: ('GR1','GR2',...)
    * Cria cursor_4c_Filtro com registros de SigMvCcr+SigCdCli
    *--------------------------------------------------------------------------
    PROCEDURE BuscarOperacoes(par_cCodEmp, par_cCodConta, par_dDatai, par_dDataf, ;
                               par_lNaoProc, par_nPeriodo, par_cGrupos)
        LOCAL loc_lSucesso, loc_cSQL, loc_cCampoPeriodo, loc_cNaoProc, loc_oErro
        LOCAL loc_dDatai, loc_dDataf, loc_lFalso
        loc_lSucesso = .F.
        TRY
            loc_dDatai = par_dDatai
            loc_dDataf = par_dDataf
            loc_lFalso = .F.

            IF par_nPeriodo = 1
                loc_cCampoPeriodo = "a.Vencs"
            ELSE
                loc_cCampoPeriodo = "a.Datas"
            ENDIF

            IF par_lNaoProc
                loc_cNaoProc = "NOT "
            ELSE
                loc_cNaoProc = ""
            ENDIF

            IF USED("cursor_4c_FiltroTemp")
                USE IN cursor_4c_FiltroTemp
            ENDIF

            loc_cSQL = "SELECT ?loc_lFalso AS marca, a.emps, a.datas, a.vencs, a.Valors, " + ;
                       "a.moedas, a.Hists + a.Titulos + a.Nfs AS histo, b.rclis, b.iclis, " + ;
                       "a.Grupos, a.contas, a.Nopers, a.Tipos, " + ;
                       "a.Contapgs, a.Dopes, a.ValPags, a.GruConMoes, a.Opers, " + ;
                       "a.cotacaos, a.cotusus, a.GrupEms, " + ;
                       "a.ContEms, a.GrupAges, a.ContAges, a.EmpDopNcs, a.Pagos, a.Titulos, a.Nfs, " + ;
                       "b.razaos, b.cpfs, b.endes, b.nums, b.bairs, b.cidas, b.ceps, b.estas, " + ;
                       "b.compls, b.tipochv, b.chvpix " + ;
                       "FROM SigMvCcr a, SigCdCli b " + ;
                       "WHERE a.pagos = 1 " + ;
                       "AND a.ContaPgs != 2 " + ;
                       "AND a.opers = 'C' " + ;
                       "AND " + loc_cCampoPeriodo + " BETWEEN ?loc_dDatai AND ?loc_dDataf " + ;
                       "AND a.Nopers <> 0 " + ;
                       "AND a.emps = " + EscaparSQL(par_cCodEmp) + " " + ;
                       "AND a.cidchaves IN (" + ;
                           "SELECT cidchaves FROM SigMvCcr " + ;
                           "WHERE grupos IN " + par_cGrupos + " " + ;
                           "AND " + loc_cCampoPeriodo + " BETWEEN ?loc_dDatai AND ?loc_dDataf" + ;
                       ") " + ;
                       "AND a.grupos = b.grupos " + ;
                       "AND a.contas = b.iclis " + ;
                       "AND a.nopers " + loc_cNaoProc + ;
                       "IN (SELECT e.nopers FROM SigPcOol e WHERE e.Tipos = 'SIGPGCNB' AND e.dopes = 'C') " + ;
                       "ORDER BY a.emps, " + loc_cCampoPeriodo

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FiltroTemp") >= 1
                IF USED("cursor_4c_Filtro")
                    IF USED("cursor_4c_Filtro")
                        TABLEREVERT(.T., "cursor_4c_Filtro")
                        USE IN cursor_4c_Filtro
                    ENDIF
                ENDIF
                SET NULL ON
                CREATE CURSOR cursor_4c_Filtro (marca L NULL, emps C(3) NULL, ;
                    datas D NULL, vencs D NULL, Valors N(14,2) NULL, moedas C(6) NULL, ;
                    histo C(60) NULL, rclis C(40) NULL, iclis C(10) NULL, ;
                    Grupos C(6) NULL, contas C(10) NULL, Nopers N(10,0) NULL, ;
                    Tipos C(6) NULL, Contapgs N(1,0) NULL, Dopes C(6) NULL, ;
                    ValPags N(14,2) NULL, GruConMoes C(6) NULL, Opers C(6) NULL, ;
                    cotacaos N(14,6) NULL, cotusus C(10) NULL, GrupEms C(6) NULL, ;
                    ContEms C(10) NULL, GrupAges C(6) NULL, ContAges C(10) NULL, ;
                    EmpDopNcs C(9) NULL, Pagos N(1,0) NULL, Titulos C(10) NULL, ;
                    Nfs C(9) NULL, razaos C(40) NULL, cpfs C(20) NULL, ;
                    endes C(40) NULL, nums C(6) NULL, bairs C(20) NULL, ;
                    cidas C(20) NULL, ceps C(9) NULL, estas C(2) NULL, ;
                    compls C(15) NULL, tipochv C(2) NULL, chvpix C(50) NULL)
                SET NULL OFF
                SELECT cursor_4c_Filtro
                APPEND FROM DBF("cursor_4c_FiltroTemp")
                SELECT cursor_4c_Filtro
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es." + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
            IF USED("cursor_4c_FiltroTemp")
                USE IN cursor_4c_FiltroTemp
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em BuscarOperacoes:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarEmpresa - Carrega dados da empresa para geracao CNAB (SigCdEmp)
    * Parametro: par_cCodEmpConvenio - Codigo da empresa do convenio (Cemps)
    * Cria cursor_4c_Empresa com: RazSocs, Cgcs, Tel1s, Ceps, Endes, Numeros,
    *                              Bairs, Cidas, Estas, Compls
    *--------------------------------------------------------------------------
    PROCEDURE BuscarEmpresa(par_cCodEmpConvenio)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        LOCAL loc_cCodEmp
        loc_lSucesso = .F.
        TRY
            loc_cCodEmp = ALLTRIM(par_cCodEmpConvenio)
            IF USED("cursor_4c_EmpresaTemp")
                USE IN cursor_4c_EmpresaTemp
            ENDIF
            loc_cSQL = "SELECT RazSocs, Cgcs, Tel1s, Ceps, Endes, Numeros," + ;
                       " Bairs, Cidas, Estas, Compls" + ;
                       " FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cCodEmp)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpresaTemp") >= 1
                IF USED("cursor_4c_Empresa")
                    USE IN cursor_4c_Empresa
                ENDIF
                SET NULL ON
                CREATE CURSOR cursor_4c_Empresa (RazSocs C(40) NULL, Cgcs C(20) NULL, ;
                    Tel1s C(14) NULL, Ceps C(9) NULL, Endes C(40) NULL, ;
                    Numeros C(6) NULL, Bairs C(20) NULL, Cidas C(20) NULL, ;
                    Estas C(2) NULL, Compls C(15) NULL)
                SET NULL OFF
                SELECT cursor_4c_Empresa
                APPEND FROM DBF("cursor_4c_EmpresaTemp")
                SELECT cursor_4c_Empresa
                GO TOP
                loc_lSucesso = !EOF("cursor_4c_Empresa")
            ELSE
                MostrarErro("Erro ao carregar dados da empresa " + loc_cCodEmp + "." + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
            IF USED("cursor_4c_EmpresaTemp")
                USE IN cursor_4c_EmpresaTemp
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em BuscarEmpresa:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarConvenio - Carrega dados do convenio bancario (SigCdCeb)
    * Parametros:
    *   par_cGruContas - Grupos+Contas concatenado (ex: crBancos.Grupos + lcconta)
    * Cria cursor_4c_Convenio com dados do SigCdCeb
    *--------------------------------------------------------------------------
    PROCEDURE BuscarConvenio(par_cGruContas)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        LOCAL loc_cGruContas
        loc_lSucesso = .F.
        TRY
            loc_cGruContas = ALLTRIM(par_cGruContas)
            IF USED("cursor_4c_ConvenioTemp")
                USE IN cursor_4c_ConvenioTemp
            ENDIF
            loc_cSQL = "SELECT * FROM SigCdCeb" + ;
                       " WHERE GruContas = " + EscaparSQL(loc_cGruContas) + ;
                       " AND NAgencias != ''" + ;
                       " ORDER BY NAgencias"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConvenioTemp") >= 1
                IF USED("cursor_4c_Convenio")
                    USE IN cursor_4c_Convenio
                ENDIF
                SELECT cursor_4c_ConvenioTemp
                SELECT *, " " AS placeHolder FROM cursor_4c_ConvenioTemp INTO CURSOR cursor_4c_Convenio READWRITE
                SELECT cursor_4c_Convenio
                GO TOP
                loc_lSucesso = !EOF("cursor_4c_Convenio")
            ELSE
                MostrarErro("Erro ao carregar conv" + CHR(234) + "nio bancario." + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
            IF USED("cursor_4c_ConvenioTemp")
                USE IN cursor_4c_ConvenioTemp
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em BuscarConvenio:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarContaBancaria - Carrega dados da conta do favorecido (SigCdCeb)
    * Parametros:
    *   par_cGruContas - Grupos+Contas do favorecido
    * Cria cursor_4c_ContaFav com dados do SigCdCeb
    *--------------------------------------------------------------------------
    PROCEDURE BuscarContaBancaria(par_cGruContas)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        LOCAL loc_cGruContas
        loc_lSucesso = .F.
        TRY
            loc_cGruContas = ALLTRIM(par_cGruContas)
            IF USED("cursor_4c_ContaFavTemp")
                USE IN cursor_4c_ContaFavTemp
            ENDIF
            loc_cSQL = "SELECT * FROM SigCdCeb" + ;
                       " WHERE GruContas = " + EscaparSQL(loc_cGruContas) + ;
                       " AND NAgencias != '' AND contas != '' AND nbancos != 0" + ;
                       " ORDER BY NAgencias"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaFavTemp") >= 1
                IF USED("cursor_4c_ContaFav")
                    USE IN cursor_4c_ContaFav
                ENDIF
                SELECT cursor_4c_ContaFavTemp
                SELECT * FROM cursor_4c_ContaFavTemp INTO CURSOR cursor_4c_ContaFav READWRITE
                SELECT cursor_4c_ContaFav
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar conta do favorecido." + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
            IF USED("cursor_4c_ContaFavTemp")
                USE IN cursor_4c_ContaFavTemp
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em BuscarContaBancaria:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarContasBanco - Carrega contas do banco especificado (SigCdCeb)
    * Para buscaboleto: separa contas do mesmo banco vs outros bancos
    * Parametro: par_cBco - Codigo do banco FEBRABAN (ex: '341', '237', '033')
    * Cria cursor_4c_BancoIgual e cursor_4c_BancoDif
    *--------------------------------------------------------------------------
    PROCEDURE BuscarContasBanco(par_cBco)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro, loc_cBco
        loc_lSucesso = .F.
        TRY
            loc_cBco = ALLTRIM(par_cBco)
            IF USED("cursor_4c_BancoIgualTemp")
                USE IN cursor_4c_BancoIgualTemp
            ENDIF
            IF USED("cursor_4c_BancoDifTemp")
                USE IN cursor_4c_BancoDifTemp
            ENDIF
            loc_cSQL = "SELECT * FROM SigCdCeb WHERE nbancos = " + ALLTRIM(loc_cBco)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BancoIgualTemp") < 1
                MostrarErro("Erro ao carregar contas do banco " + loc_cBco + "." + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_cSQL = "SELECT * FROM SigCdCeb WHERE nbancos != " + ALLTRIM(loc_cBco)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BancoDifTemp") < 1
                    MostrarErro("Erro ao carregar demais contas." + CHR(13) + ;
                                CapturarErroSQL(), "Erro SQL")
                ELSE
                    IF USED("cursor_4c_BancoIgual")
                        USE IN cursor_4c_BancoIgual
                    ENDIF
                    IF USED("cursor_4c_BancoDif")
                        USE IN cursor_4c_BancoDif
                    ENDIF
                    SELECT cursor_4c_BancoIgualTemp
                    SELECT * FROM cursor_4c_BancoIgualTemp INTO CURSOR cursor_4c_BancoIgual READWRITE
                    SELECT cursor_4c_BancoDifTemp
                    SELECT * FROM cursor_4c_BancoDifTemp INTO CURSOR cursor_4c_BancoDif READWRITE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
            IF USED("cursor_4c_BancoIgualTemp")
                USE IN cursor_4c_BancoIgualTemp
            ENDIF
            IF USED("cursor_4c_BancoDifTemp")
                USE IN cursor_4c_BancoDifTemp
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em BuscarContasBanco:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarBarrasCcb - Busca codigo de barras de um titulo em SigMvCcb
    * Parametro: par_cFkChaves - chave fk (emps + str(nopers,10) + opers)
    * Retorna a string de barras ou "" se nao encontrado
    *--------------------------------------------------------------------------
    PROCEDURE BuscarBarrasCcb(par_cFkChaves)
        LOCAL loc_cBarras, loc_cSQL, loc_oErro
        LOCAL loc_cFkChaves
        loc_cBarras = ""
        TRY
            loc_cFkChaves = ALLTRIM(par_cFkChaves)
            IF USED("cursor_4c_BarraTemp")
                USE IN cursor_4c_BarraTemp
            ENDIF
            loc_cSQL = "SELECT ccb_bars FROM SigMvCcb WHERE fkchaves = " + ;
                       EscaparSQL(loc_cFkChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BarraTemp") >= 1
                SELECT cursor_4c_BarraTemp
                GO TOP
                IF !EOF("cursor_4c_BarraTemp")
                    loc_cBarras = NVL(cursor_4c_BarraTemp.ccb_bars, "")
                ENDIF
            ENDIF
            IF USED("cursor_4c_BarraTemp")
                USE IN cursor_4c_BarraTemp
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em BuscarBarrasCcb:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_cBarras
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarGruposContaCli - Carrega grupos de uma conta (SigCdCli)
    * Parametro: par_cIClis - Codigo da conta (IClis)
    * Retorna valor do campo Grupos ou ""
    *--------------------------------------------------------------------------
    PROCEDURE BuscarGruposContaCli(par_cIClis)
        LOCAL loc_cGrupos, loc_cSQL, loc_oErro
        LOCAL loc_cIClis
        loc_cGrupos = ""
        TRY
            loc_cIClis = ALLTRIM(par_cIClis)
            IF USED("cursor_4c_CliGrupoTemp")
                USE IN cursor_4c_CliGrupoTemp
            ENDIF
            loc_cSQL = "SELECT Grupos FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cIClis)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliGrupoTemp") >= 1
                SELECT cursor_4c_CliGrupoTemp
                GO TOP
                IF !EOF("cursor_4c_CliGrupoTemp")
                    loc_cGrupos = NVL(ALLTRIM(cursor_4c_CliGrupoTemp.Grupos), "")
                ENDIF
            ENDIF
            IF USED("cursor_4c_CliGrupoTemp")
                USE IN cursor_4c_CliGrupoTemp
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em BuscarGruposContaCli:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_cGrupos
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarTituloBanco - Atualiza titbans em SigMvCcr apos geracao CNAB
    * Parametros:
    *   par_nNopers - Numero da operacao
    *   par_cTitulo - Titulo banco para gravar (ex: 'TIT ITAU')
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarTituloBanco(par_nNopers, par_cTitulo)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        LOCAL loc_nNopers
        loc_lSucesso = .F.
        TRY
            loc_nNopers = par_nNopers
            loc_cSQL = "UPDATE SigMvCcr SET titbans = " + EscaparSQL(par_cTitulo) + ;
                       " WHERE opers = 'C' AND nopers = ?loc_nNopers"
            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 1
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar t" + CHR(237) + "tulo banco." + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em AtualizarTituloBanco:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarTituloBanco - Verifica titbans existente em SigMvCcr
    * Parametro: par_nNopers - Numero da operacao
    * Retorna o titbans atual ou ""
    *--------------------------------------------------------------------------
    PROCEDURE BuscarTituloBanco(par_nNopers)
        LOCAL loc_cTitulo, loc_cSQL, loc_oErro
        LOCAL loc_nNopers
        loc_cTitulo = ""
        TRY
            loc_nNopers = par_nNopers
            IF USED("cursor_4c_TitBanTemp")
                USE IN cursor_4c_TitBanTemp
            ENDIF
            loc_cSQL = "SELECT titulos, titbans FROM SigMvCcr WHERE opers = 'C' AND nopers = ?loc_nNopers"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TitBanTemp") >= 1
                SELECT cursor_4c_TitBanTemp
                GO TOP
                IF !EOF("cursor_4c_TitBanTemp")
                    loc_cTitulo = NVL(ALLTRIM(cursor_4c_TitBanTemp.titbans), "")
                ENDIF
            ENDIF
            IF USED("cursor_4c_TitBanTemp")
                USE IN cursor_4c_TitBanTemp
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro em BuscarTituloBanco:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_cTitulo
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarChaveUnica - Gera chave unica para cidchaves usando fUniqueIds()
    * Retorna a chave gerada como string
    *--------------------------------------------------------------------------
    PROCEDURE GerarChaveUnica()
        RETURN ALLTRIM(fUniqueIds())
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarLinhaArquivo - Insere uma linha do arquivo CNAB em SigPcOol
    * Chamado pelas procedures de geracao CNAB no FormSIGPGCNB
    * Parametros:
    *   par_cDopes    - Tipo operacao ('C')
    *   par_nNopers   - Numero da operacao em SigMvCcr
    *   par_cProdutos - Conteudo da linha CNAB gerada
    *   par_cDopeds   - Referencia do documento (titulo)
    *   par_cEdndests - Chave destino (titulo+nopers)
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarLinhaArquivo(par_cDopes, par_nNopers, par_cProdutos, par_cDopeds, par_cEdndests)
        THIS.this_cDopes    = par_cDopes
        THIS.this_nNopers   = par_nNopers
        THIS.this_cProdutos = par_cProdutos
        THIS.this_cDopeds   = par_cDopeds
        THIS.this_cEdndests = par_cEdndests
        RETURN THIS.Inserir()
    ENDPROC

ENDDEFINE
