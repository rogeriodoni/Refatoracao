*-------------------------------------------------------------------------------
* SigPdMp4BO.prg - Business Object: Desagregar Componentes Agregados
* Herda de BusinessBase
* OPERACIONAL: Desagrega itens do cursor xNensi (producao) via TmpDistrib
*-------------------------------------------------------------------------------

DEFINE CLASS SigPdMp4BO AS BusinessBase

    *-- Dados do componente (campos do cursor TmpDistrib)
    this_lMarca       = .F.
    this_nNops        = 0
    this_nNenvs       = 0
    this_cCodPds      = ""
    this_cCMats       = ""
    this_cCUnis       = ""
    this_nQtds        = 0
    this_nPesos       = 0
    this_nPesofs      = 0
    this_cCDescs      = ""
    this_cCGrus       = ""
    this_cTpOps       = ""
    this_cCUniPs      = ""
    this_nQtd2s       = 0
    this_nPeso2s      = 0
    this_nPesof2s     = 0
    this_cCodCors     = ""
    this_cCodTams     = ""

    *-- Contexto do pedido de producao (xNensi)
    this_nRecnoAnt    = 0

    *-- Parametros operacionais lidos de crSigCdOpd
    this_nLibrPqs     = 0
    this_nGrOdns      = 0
    this_nPesoBals    = 0

    *-- Parametros de balanca/unidade padrao lidos de crSigCdPam
    this_cCUnipPads   = ""

    *-- Fatores da unidade principal (SigCdUni - LocalUni)
    this_nFatorsUni   = 0
    this_cQtEqualPs   = ""
    this_cCEstosUni   = ""

    *-- Fatores da unidade secundaria (SigCdUni - LocalUni2)
    this_nFatorsUni2  = 0
    this_cQtEqualPs2  = ""
    this_cCEstosUni2  = ""

    *-- Alias do cursor fonte (xNensi - producao) a ser desagregado
    this_cAliasFonte  = ""

    *---------------------------------------------------------------------------
    * Init - Configura tabela e chave
    * OPERACIONAL: this_cTabela usado apenas para auditoria (alvo logico = xNensi)
    *---------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "xNensi"
        THIS.this_cCampoChave = "Nops"
        RETURN DODEFAULT()
    ENDPROC

    *---------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna numero da operacao como identificador
    *---------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nNops)
    ENDFUNC

    *---------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor TmpDistrib
    *---------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_lMarca    = NVL(Marca, .F.)
            THIS.this_nNops     = NVL(Nops, 0)
            THIS.this_nNenvs    = NVL(Nenvs, 0)
            THIS.this_cCodPds   = TratarNulo(CodPds, "C")
            THIS.this_cCMats    = TratarNulo(CMats, "C")
            THIS.this_cCUnis    = TratarNulo(CUnis, "C")
            THIS.this_nQtds     = NVL(Qtds, 0)
            THIS.this_nPesos    = NVL(Pesos, 0)
            THIS.this_nPesofs   = NVL(Pesofs, 0)
            THIS.this_cCDescs   = TratarNulo(CDescs, "C")
            THIS.this_cCGrus    = TratarNulo(CGrus, "C")
            THIS.this_cTpOps    = TratarNulo(TpOps, "C")
            THIS.this_cCUniPs   = TratarNulo(cUniPs, "C")
            THIS.this_nQtd2s    = NVL(Qtd2s, 0)
            THIS.this_nPeso2s   = NVL(Peso2s, 0)
            THIS.this_nPesof2s  = NVL(Pesof2s, 0)
            THIS.this_cCodCors  = TratarNulo(CodCors, "C")
            THIS.this_cCodTams  = TratarNulo(CodTams, "C")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *---------------------------------------------------------------------------
    * InicializarTmpDistrib - Cria cursor TmpDistrib a partir do cursor fonte
    * par_cAliasFonte: alias do cursor de producao (xNensi no legado)
    * Estrutura TmpDistrib identica ao legado (Create Cursor do Init original)
    *---------------------------------------------------------------------------
    PROCEDURE InicializarTmpDistrib(par_cAliasFonte)
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_nNops, loc_nNenvs, loc_nQtds, loc_nPeso2s, loc_nPesos
        LOCAL loc_cCUnis, loc_cCMats, loc_cCDescs, loc_cCGrus, loc_cCUniPs
        LOCAL loc_cCodCors, loc_cCodTams

        loc_lSucesso = .F.

        TRY
            IF !USED(par_cAliasFonte)
                loc_lSucesso = .F.
            ELSE
                IF USED("TmpDistrib")
                    USE IN TmpDistrib
                ENDIF

                SET NULL ON
                CREATE CURSOR TmpDistrib (;
                    Marca    L        NULL,;
                    Nops     N(10,0)  NULL,;
                    Nenvs    N(10,0)  NULL,;
                    CodPds   C(10)    NULL,;
                    CMats    C(14)    NULL,;
                    CUnis    C(3)     NULL,;
                    Qtds     N(10,3)  NULL,;
                    Pesos    N(10,3)  NULL,;
                    Pesofs   N(10,3)  NULL,;
                    CDescs   C(40)    NULL,;
                    CGrus    C(3)     NULL,;
                    TpOps    C(15)    NULL,;
                    cUniPs   C(3)     NULL,;
                    Qtd2s    N(10,3)  NULL,;
                    Peso2s   N(10,3)  NULL,;
                    Pesof2s  N(10,3)  NULL,;
                    CodCors  C(4)     NULL,;
                    CodTams  C(4)     NULL)
                SET NULL OFF

                SELECT (par_cAliasFonte)
                SET ORDER TO NopCMat
                GO TOP

                SCAN
                    IF Visivel
                        LOOP
                    ENDIF

                    loc_nNops    = Nops
                    loc_nNenvs   = Nenvs
                    loc_nQtds    = Qtds
                    loc_nPeso2s  = Peso2s
                    loc_nPesos   = Pesos
                    loc_cCUnis   = CUnis
                    loc_cCMats   = CMats
                    loc_cCDescs  = CDescs
                    loc_cCGrus   = CGrus
                    loc_cCUniPs  = cUniPs
                    loc_cCodCors = CodCors
                    loc_cCodTams = CodTams

                    INSERT INTO TmpDistrib (;
                        Nops, Nenvs, Qtd2s, Peso2s, Pesof2s,;
                        CUnis, CMats, CDescs, CGrus, Qtds, Pesos,;
                        Pesofs, cUniPs, CodCors, CodTams) ;
                    VALUES (;
                        loc_nNops, loc_nNenvs, loc_nQtds, loc_nPeso2s, loc_nPesos,;
                        loc_cCUnis, loc_cCMats, loc_cCDescs, loc_cCGrus,;
                        loc_nQtds, loc_nPeso2s, loc_nPesos,;
                        loc_cCUniPs, loc_cCodCors, loc_cCodTams)

                    SELECT (par_cAliasFonte)
                ENDSCAN

                SELECT TmpDistrib
                GO TOP
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * BuscarUnidade - Consulta SigCdUni via SQL e armazena em cursor local
    * par_cCUnis         : codigo da unidade
    * par_cCampos        : lista de campos (ex: "Fators, QtEqualPs, CEstos")
    * par_cCursorDestino : nome do cursor local de destino
    *---------------------------------------------------------------------------
    PROCEDURE BuscarUnidade(par_cCUnis, par_cCampos, par_cCursorDestino)
        LOCAL loc_cSQL, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cCUnis))
                loc_lSucesso = .F.
            ELSE
                IF USED(par_cCursorDestino)
                    USE IN (par_cCursorDestino)
                ENDIF

                loc_cSQL = "SELECT " + par_cCampos + ;
                           " FROM SigCdUni WHERE CUnis = " + EscaparSQL(ALLTRIM(par_cCUnis))

                IF SQLEXEC(gnConnHandle, loc_cSQL, par_cCursorDestino) > 0
                    IF RECCOUNT(par_cCursorDestino) > 0
                        SELECT (par_cCursorDestino)
                        GO TOP
                    ENDIF
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * ValidarQtdeDesagregada - Valida e recalcula apos alteracao de Qtd2s (Col 7)
    * Requer: TmpDistrib selecionado na linha corrente
    * par_nNovaQtd : novo valor de Qtd2s digitado pelo usuario
    * par_nLibrPqs : flag LibrPqs do crSigCdOpd (1=permite qtd >= original)
    * Retorna .T. se valor aceito
    * Efeito colateral: atualiza TmpDistrib.Pesof2s ou TmpDistrib.Pesos
    *---------------------------------------------------------------------------
    FUNCTION ValidarQtdeDesagregada(par_nNovaQtd, par_nLibrPqs)
        LOCAL loc_lValido, loc_oErro
        LOCAL loc_nFators, loc_cQtEqualPs

        loc_lValido = .T.

        TRY
            IF !USED("TmpDistrib")
                loc_lValido = .F.
            ELSE
                SELECT TmpDistrib

                IF par_nNovaQtd >= TmpDistrib.Qtds AND par_nLibrPqs <> 1
                    MsgAviso("Desagregar Parcialmente: Qtde tem que ser menor do que a original", ;
                             "Valida" + CHR(231) + CHR(227) + CHR(227) + "o")
                    loc_lValido = .F.
                ELSE
                    THIS.BuscarUnidade(TmpDistrib.CUnis, "Fators, QtEqualPs", "LocalUni")

                    IF USED("LocalUni") AND RECCOUNT("LocalUni") > 0
                        SELECT LocalUni
                        loc_nFators    = NVL(Fators, 0)
                        loc_cQtEqualPs = TratarNulo(QtEqualPs, "C")

                        IF loc_nFators <> 0
                            IF (loc_nFators <> 1) OR UPPER(ALLTRIM(loc_cQtEqualPs)) = "S"
                                SELECT TmpDistrib
                                REPLACE Pesof2s WITH par_nNovaQtd * loc_nFators
                            ENDIF
                        ENDIF

                        SELECT TmpDistrib
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lValido = .F.
        ENDTRY

        RETURN loc_lValido
    ENDFUNC

    *---------------------------------------------------------------------------
    * ValidarPesoDesagregado - Valida e recalcula apos alteracao de Peso2s (Col 10)
    * Requer: TmpDistrib selecionado na linha corrente
    * par_nNovoPeso : novo valor de Peso2s digitado pelo usuario
    * par_nLibrPqs  : flag LibrPqs do crSigCdOpd
    * Retorna .T. se valor aceito
    * Efeito colateral: atualiza TmpDistrib.Pesof2s
    *---------------------------------------------------------------------------
    FUNCTION ValidarPesoDesagregado(par_nNovoPeso, par_nLibrPqs)
        LOCAL loc_lValido, loc_oErro
        LOCAL loc_nFators2, loc_cQtEqualPs2

        loc_lValido = .T.

        TRY
            IF !USED("TmpDistrib")
                loc_lValido = .F.
            ELSE
                SELECT TmpDistrib

                IF par_nNovoPeso >= TmpDistrib.Pesos AND par_nLibrPqs <> 1
                    MsgAviso("Desagregar Parcialmente: Peso tem que ser menor do que Original", ;
                             "Valida" + CHR(231) + CHR(227) + CHR(227) + "o")
                    loc_lValido = .F.
                ELSE
                    THIS.BuscarUnidade(TmpDistrib.cUniPs, "Fators, QtEqualPs", "LocalUni2")

                    IF USED("LocalUni2") AND RECCOUNT("LocalUni2") > 0
                        SELECT LocalUni2
                        loc_nFators2    = NVL(Fators, 0)
                        loc_cQtEqualPs2 = TratarNulo(QtEqualPs, "C")

                        IF loc_nFators2 <> 0
                            IF (loc_nFators2 <> 1) OR UPPER(ALLTRIM(loc_cQtEqualPs2)) = "S"
                                SELECT TmpDistrib
                                REPLACE Pesof2s WITH par_nNovoPeso * loc_nFators2
                            ENDIF
                        ENDIF

                        SELECT TmpDistrib
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lValido = .F.
        ENDTRY

        RETURN loc_lValido
    ENDFUNC

    *---------------------------------------------------------------------------
    * ValidarPesoFabrDesagregado - Valida e recalcula apos alt. Pesof2s (Col 11)
    * Requer: TmpDistrib selecionado na linha corrente
    * par_nNovoPesoFabr : novo valor de Pesof2s digitado
    * par_nLibrPqs      : flag LibrPqs do crSigCdOpd
    * par_nPesoBals     : flag PesoBals do crSigCdOpd (1=controle por balanca)
    * Retorna .T. se valor aceito
    * Efeito colateral: atualiza TmpDistrib.Qtd2s ou TmpDistrib.Peso2s
    *---------------------------------------------------------------------------
    FUNCTION ValidarPesoFabrDesagregado(par_nNovoPesoFabr, par_nLibrPqs, par_nPesoBals)
        LOCAL loc_lValido, loc_oErro
        LOCAL loc_nFators, loc_cQtEqualPs, loc_cCEstos
        LOCAL loc_nFators2, loc_cQtEqualPs2, loc_nDivisor

        loc_lValido = .T.

        TRY
            IF !USED("TmpDistrib")
                loc_lValido = .F.
            ELSE
                SELECT TmpDistrib

                IF par_nNovoPesoFabr >= TmpDistrib.Pesofs AND par_nLibrPqs <> 1
                    MsgAviso("Desagregar Parcialmente: Peso Fabr tem que ser menor do que Original", ;
                             "Valida" + CHR(231) + CHR(227) + CHR(227) + "o")
                    loc_lValido = .F.
                ELSE
                    THIS.BuscarUnidade(TmpDistrib.CUnis,  "Fators, QtEqualPs, CEstos", "LocalUni")
                    THIS.BuscarUnidade(TmpDistrib.cUniPs, "Fators, QtEqualPs, CEstos", "LocalUni2")

                    IF USED("LocalUni") AND RECCOUNT("LocalUni") > 0
                        SELECT LocalUni
                        loc_nFators    = NVL(Fators, 0)
                        loc_cQtEqualPs = TratarNulo(QtEqualPs, "C")
                        loc_cCEstos    = TratarNulo(CEstos, "C")

                        IF loc_nFators <> 0
                            IF (loc_nFators <> 1) OR UPPER(ALLTRIM(loc_cQtEqualPs)) = "S"
                                loc_nDivisor = IIF(EMPTY(loc_nFators), 1, loc_nFators)
                                SELECT TmpDistrib
                                REPLACE Qtd2s WITH par_nNovoPesoFabr / loc_nDivisor
                            ELSE
                                IF USED("LocalUni2") AND RECCOUNT("LocalUni2") > 0
                                    SELECT LocalUni2
                                    loc_nFators2    = NVL(Fators, 0)
                                    loc_cQtEqualPs2 = TratarNulo(QtEqualPs, "C")

                                    SELECT TmpDistrib
                                    IF ALLTRIM(loc_cCEstos) = "3" AND ;
                                       !EMPTY(ALLTRIM(TmpDistrib.cUniPs)) AND ;
                                       ((loc_nFators2 <> 1) OR UPPER(ALLTRIM(loc_cQtEqualPs2)) = "S")
                                        loc_nDivisor = IIF(EMPTY(loc_nFators2), 1, loc_nFators2)
                                        REPLACE Peso2s WITH par_nNovoPesoFabr / loc_nDivisor
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF

                    SELECT TmpDistrib
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lValido = .F.
        ENDTRY

        RETURN loc_lValido
    ENDFUNC

    *---------------------------------------------------------------------------
    * SalvarDesagregacao - Aplica desagregacao: atualiza cursor fonte (xNensi)
    * com base nos valores parciais definidos em TmpDistrib (logica do ok.Click)
    * par_cAliasFonte: alias do cursor de producao a ser atualizado
    * Retorna .T. se sucesso
    * Efeito: marca linhas como Visivel=.T., Rateio=3; atualiza qtds/pesos restantes
    *---------------------------------------------------------------------------
    FUNCTION SalvarDesagregacao(par_cAliasFonte)
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_nNops, loc_cCMats
        LOCAL loc_nQtds, loc_nPesos, loc_nPesofs
        LOCAL loc_nQtd2s, loc_nPeso2s, loc_nPesof2s
        LOCAL loc_lMarca

        loc_lSucesso = .F.

        TRY
            IF !USED("TmpDistrib") OR !USED(par_cAliasFonte)
                loc_lSucesso = .F.
            ELSE
                SELECT TmpDistrib
                GO TOP

                SCAN
                    loc_nNops    = TmpDistrib.Nops
                    loc_cCMats   = TmpDistrib.CMats
                    loc_nQtds    = TmpDistrib.Qtds
                    loc_nPesos   = TmpDistrib.Pesos
                    loc_nPesofs  = TmpDistrib.Pesofs
                    loc_nQtd2s   = TmpDistrib.Qtd2s
                    loc_nPeso2s  = TmpDistrib.Peso2s
                    loc_nPesof2s = TmpDistrib.Pesof2s
                    loc_lMarca   = TmpDistrib.Marca

                    SELECT (par_cAliasFonte)
                    SET ORDER TO NopCmat

                    IF SEEK(STR(loc_nNops, 10) + loc_cCMats)
                        SCAN WHILE Nops = loc_nNops AND CMats = loc_cCMats
                            IF Qtds = loc_nQtds AND Peso2s = loc_nPesos AND Pesos = loc_nPesofs
                                REPLACE Visivel WITH .T., Rateio WITH 3
                                IF loc_lMarca
                                    REPLACE Pesos  WITH loc_nPesofs  - loc_nPesof2s, ;
                                            Qtds   WITH loc_nQtds    - loc_nQtd2s, ;
                                            Peso2s WITH loc_nPesos   - loc_nPeso2s
                                ENDIF
                                EXIT
                            ENDIF
                        ENDSCAN
                    ENDIF

                    SELECT TmpDistrib
                ENDSCAN

                SELECT (par_cAliasFonte)
                SET ORDER TO Editar

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *---------------------------------------------------------------------------
    * Inserir - Aplica desagregacao ao cursor fonte (xNensi)
    * OPERACIONAL: nao existe INSERT em tabela; persistencia eh via cursor xNensi.
    * Pre-condicao: THIS.this_cAliasFonte preenchido pelo Form antes do Salvar().
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cAliasFonte)
                THIS.this_cMensagemErro = "Alias fonte n" + CHR(227) + "o definido"
                loc_lSucesso = .F.
            ELSE
                IF !USED(THIS.this_cAliasFonte)
                    THIS.this_cMensagemErro = "Cursor fonte n" + CHR(227) + "o est" + CHR(225) + " aberto"
                    loc_lSucesso = .F.
                ELSE
                    loc_lSucesso = THIS.SalvarDesagregacao(THIS.this_cAliasFonte)

                    IF loc_lSucesso
                        THIS.RegistrarAuditoria("DESAGREGAR")
                    ELSE
                        THIS.this_cMensagemErro = "Falha ao aplicar desagrega" + CHR(231) + CHR(227) + "o"
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inserir: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * Atualizar - Re-aplica desagregacao ao cursor fonte (xNensi)
    * OPERACIONAL: equivale a Inserir em forms de movimentacao sobre cursor.
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cAliasFonte)
                THIS.this_cMensagemErro = "Alias fonte n" + CHR(227) + "o definido"
                loc_lSucesso = .F.
            ELSE
                IF !USED(THIS.this_cAliasFonte)
                    THIS.this_cMensagemErro = "Cursor fonte n" + CHR(227) + "o est" + CHR(225) + " aberto"
                    loc_lSucesso = .F.
                ELSE
                    loc_lSucesso = THIS.SalvarDesagregacao(THIS.this_cAliasFonte)

                    IF loc_lSucesso
                        THIS.RegistrarAuditoria("REDESAGREGAR")
                    ELSE
                        THIS.this_cMensagemErro = "Falha ao re-aplicar desagrega" + CHR(231) + CHR(227) + "o"
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao atualizar: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
