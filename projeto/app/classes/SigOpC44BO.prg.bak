*------------------------------------------------------------------------------
* SigOpC44BO - Business Object para FormSigOpC44
* Dialogo operacional de geracao do arquivo da CAT 44/2008 (Substituicao
* Tributaria de Estoque) em layout posicional de texto (pipe-delimited no
* migrado, largura fixa no legado), com 3 tipos de registro:
*   Tipo 1 - cabecalho (dados da empresa + data do estoque + finalidade)
*   Tipo 2 - um registro por produto em estoque (1 por linha de crProds)
*   Tipo 3 - rodape (totais de imposto devido + parcelas de pagamento)
* Migrado de: SIGOPC44 (Framework Fortyus)
*
* Este dialogo NAO persiste em tabela propria: ele LE SigCdPac (parametros
* gerais - diretorio padrao de destino, this_cTabela/this_cCampoChave
* apontam para SigCdEmp, a entidade central da geracao) e SigCdEmp (dados
* fiscais da empresa - CNPJ, IE, Razao Social, Regime de Tributacao) e
* consome CsTemporario, um cursor de saldo de estoque JA POPULADO pelo
* processo chamador (fora do escopo deste BO) com Ps/Ps2/cPros/cGrus/
* Sqtds/dPros/cUnis/ClFiscals - equivalente ao agrupamento feito pelo
* GeraReg2 legado (Select ... From CsTemporario Where Ps=1 AND Ps2=1
* Having Sum(Sqtds)>0 Group By cPros).
*------------------------------------------------------------------------------
DEFINE CLASS SigOpC44BO AS BusinessBase

    *-- Propriedades espelhando os campos da tela (txtdest/getDtEst/getFinal/
    *-- getNumParc do legado)
    this_cEmpresa     = ""   && codigo da empresa (Cemps) - equivalente ao parametro lcEmp/go_4c_Sistema.cCodEmpresa do Init legado
    this_cDestino     = ""   && diretorio de destino do arquivo (txtdest.Value) - default SigCdPac.dircat44 ou "C:\"
    this_dDataEstoque = {}   && data do estoque (getDtEst.Value)
    this_nFinalidade  = 0    && getFinal.ListIndex: 1=Normal, 2=Substitutivo Total
    this_nNumParcelas = 0    && getNumParc.Value - numero de parcelas p/ pagamento do ICMS

    *-- Propriedade de acumulo entre registros (ThisForm.TotalImposto do
    *-- legado) - calculada durante a geracao do Registro 2 e usada na
    *-- geracao do Registro 3
    this_nTotalImposto = 0

    *-- Propriedade customizada da classe SIGOPC44 original (codidents),
    *-- vestigial: nao e lida nem gravada em nenhum dos 7 metodos do dump
    *-- legado. Mantida apenas para fidelidade estrutural (RESERVED3
    *-- ClassInfo do SCX a declara como propriedade customizada da classe).
    this_lCodIdents = .F.

    *-- Nomes dos cursores que este BO consome/popula (propriedade para o
    *-- Form referenciar sem repetir literais - padrao SigMvSbnBO/sigopagrBO)
    this_cCursorReg1 = "cursor_4c_Reg1"           && equivalente a crReg1 (Registro Tipo 1 - cabecalho)
    this_cCursorReg2 = "cursor_4c_Reg2"           && equivalente a crReg2 (Registro Tipo 2 - produtos)
    this_cCursorReg3 = "cursor_4c_Reg3"           && equivalente a crReg3 (Registro Tipo 3 - rodape)
    this_cCursorPac  = "cursor_4c_SigCdPac"       && equivalente a crSigCdPac (parametros gerais)
    this_cCursorEmp  = "cursor_4c_SigCdEmp"       && equivalente a crSigCdEmp (dados fiscais da empresa)

    *-- Dados fiscais da empresa (SigCdEmp), carregados por CarregarParametros/
    *-- CarregarDoCursor - usados em GerarRegistro1/GerarRegistro2
    this_cCNPJ              = ""   && SigCdEmp.Cgcs
    this_cInscricaoEstadual = ""   && SigCdEmp.IEs
    this_cRazaoSocial       = ""   && SigCdEmp.Razsocs
    this_cRegimeTributario  = ""   && SigCdEmp.RegTribs - '01'/'04' conforme GeraReg2 legado

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigCdEmp"
        THIS.this_cCampoChave = "Cemps"
    ENDPROC

    *--------------------------------------------------------------------------
    * Este BO eh SOMENTE-LEITURA: nenhum metodo do SIGOPC44 legado grava em
    * tabela do SQL Server. CarregarParametros/CarregarDoCursor fazem apenas
    * SELECT (SigCdPac/SigCdEmp); GerarRegistro1/GerarRegistro2/GerarRegistro3
    * escrevem so nos cursores LOCAIS cursor_4c_Reg1/cursor_4c_Reg2/
    * cursor_4c_Reg3, que o botao Gerar Arquivo do Form converte em arquivo de
    * texto (FCREATE/FWRITE, fora do escopo deste BO). O comportamento padrao
    * herdado de BusinessBase para Inserir()/Atualizar()/ExecutarExclusao()
    * ja eh o correto para esta entidade.
    *--------------------------------------------------------------------------

    *--------------------------------------------------------------------------
    * InicializarCursoresLocais - Cria os cursores locais de saida (Registros
    * Tipo 1/2/3 do layout posicional da CAT 44/2008). Migrado de SIGOPC44.Load.
    * Idempotente: PUBLIC porque o Form chama no Init, antes de qualquer
    * GerarRegistroN.
    *--------------------------------------------------------------------------
    PROCEDURE InicializarCursoresLocais()
        IF !USED(THIS.this_cCursorReg1)
            CREATE CURSOR (THIS.this_cCursorReg1) ( ;
                TipoReg  C(1), ;
                CNPJ     C(14), ;
                InscEst  C(15), ;
                Razaos   C(50), ;
                CodFinal C(1), ;
                QtdRegT2 C(5), ;
                DtLevEst C(10))
        ENDIF

        IF !USED(THIS.this_cCursorReg2)
            CREATE CURSOR (THIS.this_cCursorReg2) ( ;
                TipoReg   C(1), ;
                CodMerc   C(10), ;
                Qtde      C(12), ;
                VlrUnit   C(12), ;
                VlrTot    C(14), ;
                AliqIcms  C(5), ;
                IVASt     C(8), ;
                PrecoFin  C(12), ;
                ImpDev    C(12), ;
                CodTpMerc C(2), ;
                DescMerc  C(50), ;
                Unid      C(3))
        ENDIF

        IF !USED(THIS.this_cCursorReg3)
            CREATE CURSOR (THIS.this_cCursorReg3) ( ;
                TipoReg    C(1), ;
                TotSldCred C(12), ;
                IcmTotDev  C(12), ;
                IcmRecEst  C(12), ;
                NumParcPag C(2))
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametros - Carrega os parametros do sistema (SigCdPac.DirCat44
    * - diretorio padrao de destino) e os dados fiscais da empresa (SigCdEmp).
    * Migrado de SIGOPC44.Init: lcEmp = Iif(Type('lcEmp')=='C' and !Empty(lcEmp),
    * lcEmp, _Empr) + Seek(lcEmp, crSigCdEmp, cEmps) + CursorQuery('SigCdPac', ...)
    * + TxtDest.Value default. _Empr (regra legada proibida) -> go_4c_Sistema.
    * cCodEmpresa.
    *--------------------------------------------------------------------------
    FUNCTION CarregarParametros(par_cEmpresa)
        LOCAL loc_cSQL, loc_nResultado, loc_cEmpresa, loc_lSucesso

        loc_lSucesso = .T.

        THIS.InicializarCursoresLocais()

        loc_cEmpresa = IIF(VARTYPE(par_cEmpresa) = "C" AND !EMPTY(par_cEmpresa), ;
            ALLTRIM(par_cEmpresa), go_4c_Sistema.cCodEmpresa)

        IF USED(THIS.this_cCursorPac)
            USE IN (THIS.this_cCursorPac)
        ENDIF
        loc_cSQL = "SELECT dircat44 FROM SigCdPac"
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorPac)
        IF loc_nResultado < 0
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (" + ;
                THIS.this_cCursorPac + ")" + CHR(13) + CapturarErroSQL()
            loc_lSucesso = .F.
        ENDIF

        IF loc_lSucesso
            IF USED(THIS.this_cCursorEmp)
                USE IN (THIS.this_cCursorEmp)
            ENDIF
            loc_cSQL = "SELECT * FROM SigCdEmp WHERE cemps = " + EscaparSQL(loc_cEmpresa)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorEmp)
            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
                    "o Com o Servidor de Banco de Dados..." + CHR(13) + CapturarErroSQL()
                loc_lSucesso = .F.
            ENDIF
        ENDIF

        IF loc_lSucesso AND RECCOUNT(THIS.this_cCursorEmp) = 0
            THIS.this_cMensagemErro = "Empresa " + loc_cEmpresa + " n" + CHR(227) + ;
                "o encontrada em SigCdEmp."
            loc_lSucesso = .F.
        ENDIF

        IF loc_lSucesso
            THIS.CarregarDoCursor(THIS.this_cCursorEmp)

            THIS.this_cDestino = "C:\"
            IF USED(THIS.this_cCursorPac)
                SELECT (THIS.this_cCursorPac)
                IF RECCOUNT() > 0 AND !EMPTY(TratarNulo(dircat44, ""))
                    THIS.this_cDestino = ALLTRIM(dircat44)
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega os dados fiscais da empresa a partir do
    * cursor_4c_SigCdEmp (coluna a coluna, sem sintaxe campo -
    * Problema 9 da FORMCOR_LICOES_APRENDIDAS).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)
        IF RECCOUNT() = 0
            RETURN .F.
        ENDIF

        THIS.this_cEmpresa            = TratarNulo(cemps, "")
        THIS.this_cCNPJ               = TratarNulo(cgcs, "")
        THIS.this_cInscricaoEstadual  = TratarNulo(ies, "")
        THIS.this_cRazaoSocial        = TratarNulo(razsocs, "")
        THIS.this_cRegimeTributario   = TratarNulo(regtribs, "")

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave desta "entidade" eh o codigo da empresa
    * (SigCdEmp.Cemps), unica informacao persistida que identifica a geracao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cEmpresa
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarRegistro1 - Gera o registro Tipo 1 (cabecalho: CNPJ/IE/Razao Social
    * sem mascara, finalidade do arquivo e data do estoque). Migrado de
    * SIGOPC44.GeraReg1.
    *--------------------------------------------------------------------------
    FUNCTION GerarRegistro1()
        LOCAL loc_cCNPJ, loc_cIE

        THIS.InicializarCursoresLocais()

        loc_cCNPJ = STRTRAN(STRTRAN(STRTRAN(THIS.this_cCNPJ, ".", ""), "/", ""), "-", "")
        loc_cIE   = STRTRAN(THIS.this_cInscricaoEstadual, ".", "")

        SELECT (THIS.this_cCursorReg1)
        ZAP
        APPEND BLANK
        REPLACE TipoReg  WITH "1", ;
                CNPJ     WITH loc_cCNPJ, ;
                InscEst  WITH loc_cIE, ;
                Razaos   WITH fLimpaTexto(THIS.this_cRazaoSocial), ;
                CodFinal WITH STR(THIS.this_nFinalidade, 1), ;
                QtdRegT2 WITH STR(0, 5), ;
                DtLevEst WITH DTOC(THIS.this_dDataEstoque)

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarRegistro2 - Gera os registros Tipo 2 (um por produto em estoque),
    * calculando o ICMS devido na Substituicao Tributaria de cada item e
    * acumulando this_nTotalImposto (usado no Registro 3). Migrado de
    * SIGOPC44.GeraReg2. Consome CsTemporario, cursor LOCAL de saldo de
    * estoque ja populado pelo processo chamador (fora do escopo deste BO).
    *--------------------------------------------------------------------------
    FUNCTION GerarRegistro2()
        LOCAL loc_nAliqIcm, loc_nUltVlrCompra, loc_nIVASt, loc_nPrecoFin, ;
            loc_nTpSubSt, loc_cCodTpMerc, loc_nVlrImp, loc_cSQL, loc_dDtSaldo, ;
            loc_nResultado, loc_nQtdReg2

        IF !USED("CsTemporario")
            THIS.this_cMensagemErro = "Cursor de saldo de estoque (CsTemporario) n" + ;
                CHR(227) + "o est" + CHR(225) + " dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        THIS.InicializarCursoresLocais()

        IF USED("cursor_4c_Prods")
            USE IN cursor_4c_Prods
        ENDIF
        SELECT cPros, MAX(cGrus) AS cGrus, SUM(Sqtds) AS Sqtds, MAX(dPros) AS dPros, ;
                MAX(cUnis) AS cUnis, MAX(ClFiscals) AS ClFiscals ;
            FROM CsTemporario ;
            WHERE Ps = 1 AND Ps2 = 1 ;
            GROUP BY cPros ;
            HAVING SUM(Sqtds) > 0 ;
            INTO CURSOR cursor_4c_Prods READWRITE

        THIS.this_nTotalImposto = 0
        loc_dDtSaldo = fDtoSQL(THIS.this_dDataEstoque, "23:59:59")

        SELECT (THIS.this_cCursorReg2)
        ZAP

        SELECT cursor_4c_Prods
        SCAN
            loc_nAliqIcm      = 0
            loc_nUltVlrCompra = 0

            loc_cSQL = "SELECT Valors, Icms, CustoFS FROM SigCdPro WHERE cPros = " + ;
                EscaparSQL(cursor_4c_Prods.cPros)
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro")

            loc_cSQL = "SELECT IndIVAST, TpSubSt, TipoMercs FROM SigCdClf WHERE Codigos = " + ;
                EscaparSQL(cursor_4c_Prods.ClFiscals)
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalClf")

            IF USED("cursor_4c_LocalPro") AND !EOF("cursor_4c_LocalPro")
                loc_nUltVlrCompra = cursor_4c_LocalPro.CustoFS
            ENDIF

            * Valor da ultima entrada realizada (compra mais recente antes da
            * data do estoque) - usado quando nao ha custo medio corrente
            loc_cSQL = "SELECT TOP 1 Units FROM SigMvItn a " + ;
                "INNER JOIN SigCdOpe o ON o.Dopes = a.Dopes " + ;
                "INNER JOIN SigCdTom t ON t.Codigos = o.TipoOps " + ;
                "WHERE a.cPros = " + EscaparSQL(cursor_4c_Prods.cPros) + ;
                " AND t.GerGdmis = 2 AND a.DtAlts < " + FormatarDataSQL(loc_dDtSaldo) + ;
                " ORDER BY a.DtAlts DESC"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UltVlr")
            IF loc_nResultado < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (cursor_4c_UltVlr)" + ;
                    CHR(13) + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
                RETURN .F.
            ENDIF
            IF USED("cursor_4c_UltVlr") AND !EOF("cursor_4c_UltVlr")
                loc_nUltVlrCompra = ROUND(cursor_4c_UltVlr.Units, 2)
            ENDIF
            IF USED("cursor_4c_UltVlr")
                USE IN cursor_4c_UltVlr
            ENDIF

            * Aliquota de ICMS do produto - cadeia de prioridades do legado:
            * SigPrTri -> SigCdUfd -> SigCdcFi -> SigCdPro.Icms -> SigCdUfs
            loc_cSQL = "SELECT Aliquotas FROM SigPrTri WHERE Origems = " + EscaparSQL("SP") + ;
                " AND Destinos = " + EscaparSQL("SP")
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrTri")
            IF USED("cursor_4c_PrTri") AND RECCOUNT("cursor_4c_PrTri") > 0
                loc_nAliqIcm = cursor_4c_PrTri.Aliquotas
            ENDIF
            IF USED("cursor_4c_PrTri")
                USE IN cursor_4c_PrTri
            ENDIF

            IF loc_nAliqIcm = 0
                loc_cSQL = "SELECT Aliqs FROM SigCdUfd WHERE Codigos = " + EscaparSQL("SP") + ;
                    " AND Destinos = " + EscaparSQL("SP")
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ufd")
                IF USED("cursor_4c_Ufd") AND RECCOUNT("cursor_4c_Ufd") > 0
                    loc_nAliqIcm = cursor_4c_Ufd.Aliqs
                ENDIF
                IF USED("cursor_4c_Ufd")
                    USE IN cursor_4c_Ufd
                ENDIF
            ENDIF

            IF loc_nAliqIcm = 0
                loc_cSQL = "SELECT Icms FROM SigCdcFi WHERE Grupos = " + ;
                    EscaparSQL(cursor_4c_Prods.cGrus) + " AND Ests = " + EscaparSQL("SP")
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_cFi")
                IF USED("cursor_4c_cFi") AND RECCOUNT("cursor_4c_cFi") > 0
                    loc_nAliqIcm = cursor_4c_cFi.Icms
                ENDIF
                IF USED("cursor_4c_cFi")
                    USE IN cursor_4c_cFi
                ENDIF
            ENDIF

            IF loc_nAliqIcm = 0
                IF USED("cursor_4c_LocalPro") AND !EOF("cursor_4c_LocalPro") AND cursor_4c_LocalPro.Icms > 0
                    loc_nAliqIcm = cursor_4c_LocalPro.Icms
                ELSE
                    loc_cSQL = "SELECT AIcms FROM SigCdUfs WHERE Estados = " + EscaparSQL("SP")
                    SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ufs")
                    IF USED("cursor_4c_Ufs") AND RECCOUNT("cursor_4c_Ufs") > 0
                        loc_nAliqIcm = cursor_4c_Ufs.AIcms
                    ENDIF
                    IF USED("cursor_4c_Ufs")
                        USE IN cursor_4c_Ufs
                    ENDIF
                ENDIF
            ENDIF

            loc_nIVASt     = 0
            loc_nPrecoFin  = 0
            loc_nTpSubSt   = 0
            loc_cCodTpMerc = ""
            IF USED("cursor_4c_LocalClf") AND !EOF("cursor_4c_LocalClf")
                loc_nIVASt     = cursor_4c_LocalClf.IndIVAST
                loc_nTpSubSt   = cursor_4c_LocalClf.TpSubSt
                loc_cCodTpMerc = TRANSFORM(cursor_4c_LocalClf.TipoMercs, "@L 99")
                IF USED("cursor_4c_LocalPro") AND !EOF("cursor_4c_LocalPro")
                    loc_nPrecoFin = cursor_4c_LocalPro.Valors
                ENDIF
                IF loc_nTpSubSt = 2
                    loc_nIVASt = 0
                ELSE
                    loc_nPrecoFin = 0
                ENDIF
            ENDIF

            * Calculo do imposto devido - conforme o regime de tributacao da empresa
            loc_nVlrImp = 0
            IF loc_nTpSubSt = 2
                IF THIS.this_cRegimeTributario = "01"
                    loc_nVlrImp = (cursor_4c_Prods.Sqtds * loc_nUltVlrCompra) * (loc_nAliqIcm / 100)
                ENDIF
                IF THIS.this_cRegimeTributario = "04"
                    loc_nVlrImp = ((cursor_4c_Prods.Sqtds * loc_nPrecoFin) - ;
                        (cursor_4c_Prods.Sqtds * loc_nUltVlrCompra)) * (loc_nAliqIcm / 100)
                ENDIF
            ELSE
                IF THIS.this_cRegimeTributario = "01"
                    loc_nVlrImp = ((cursor_4c_Prods.Sqtds * loc_nUltVlrCompra) * (loc_nAliqIcm / 100)) + ;
                        ((cursor_4c_Prods.Sqtds * loc_nUltVlrCompra) * (loc_nIVASt / 100) * (loc_nAliqIcm / 100))
                ENDIF
                IF THIS.this_cRegimeTributario = "04"
                    loc_nVlrImp = (cursor_4c_Prods.Sqtds * loc_nUltVlrCompra) * (loc_nIVASt / 100) * (loc_nAliqIcm / 100)
                ENDIF
            ENDIF

            THIS.this_nTotalImposto = THIS.this_nTotalImposto + ROUND(loc_nVlrImp, 2)

            SELECT (THIS.this_cCursorReg2)
            APPEND BLANK
            REPLACE TipoReg    WITH "2", ;
                    CodMerc    WITH cursor_4c_Prods.cPros, ;
                    Qtde       WITH STR(cursor_4c_Prods.Sqtds, 12, 3), ;
                    VlrUnit    WITH STR(loc_nUltVlrCompra, 12, 2), ;
                    VlrTot     WITH STR(cursor_4c_Prods.Sqtds * loc_nUltVlrCompra, 12, 2), ;
                    AliqIcms   WITH STR(loc_nAliqIcm, 5, 2), ;
                    IVASt      WITH STR(loc_nIVASt, 7, 2), ;
                    PrecoFin   WITH STR(loc_nPrecoFin, 12, 2), ;
                    ImpDev     WITH STR(loc_nVlrImp, 12, 2), ;
                    CodTpMerc  WITH loc_cCodTpMerc, ;
                    DescMerc   WITH fLimpaTexto(cursor_4c_Prods.dPros), ;
                    Unid       WITH cursor_4c_Prods.cUnis

            IF USED("cursor_4c_LocalPro")
                USE IN cursor_4c_LocalPro
            ENDIF
            IF USED("cursor_4c_LocalClf")
                USE IN cursor_4c_LocalClf
            ENDIF

            SELECT cursor_4c_Prods
        ENDSCAN

        IF USED("cursor_4c_Prods")
            USE IN cursor_4c_Prods
        ENDIF

        * Acerto da quantidade de registros Tipo 2 no cabecalho (Registro 1)
        loc_nQtdReg2 = IIF(USED(THIS.this_cCursorReg2), RECCOUNT(THIS.this_cCursorReg2), 0)
        IF USED(THIS.this_cCursorReg1)
            SELECT (THIS.this_cCursorReg1)
            GO TOP
            REPLACE QtdRegT2 WITH STR(loc_nQtdReg2, 5)
        ENDIF

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarRegistro3 - Gera o registro Tipo 3 (rodape: total de imposto devido
    * e numero de parcelas para pagamento do ICMS). Migrado de SIGOPC44.GeraReg3.
    *--------------------------------------------------------------------------
    FUNCTION GerarRegistro3()
        LOCAL loc_nNumParc

        THIS.InicializarCursoresLocais()

        loc_nNumParc = THIS.this_nNumParcelas
        IF THIS.this_nTotalImposto <= 0
            loc_nNumParc = 0
        ENDIF

        SELECT (THIS.this_cCursorReg3)
        ZAP
        APPEND BLANK
        REPLACE TipoReg    WITH "3", ;
                TotSldCred WITH "0,00", ;
                IcmTotDev  WITH STR(THIS.this_nTotalImposto, 12, 2), ;
                IcmRecEst  WITH STR(THIS.this_nTotalImposto, 12, 2), ;
                NumParcPag WITH STR(loc_nNumParc, 2)

        RETURN .T.
    ENDFUNC

ENDDEFINE
