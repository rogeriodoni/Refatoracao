*==============================================================================
* SIGPRGL2BO.PRG
* Business Object do formulario Operacoes Selecionadas (SigPrGl2)
* Origem legado: SigPrGl2.SCX (form generico, aberto via DO FORM pelo
* formulario pai que lista as operacoes, com cursores TmpCabec/TmpItens
* ja populados na DataSession do chamador)
*==============================================================================

DEFINE CLASS SigPrGl2BO AS BusinessBase

    *-- Contexto recebido do formulario pai (equivalente as properties
    *-- customizadas ParentForm/Datasessionid/Reserva/Emphpdr/Automatico/
    *-- Numerodaop/Pordestino do SIGPRGL2.SCX legado)
    this_oParentForm      = .NULL.  && Referencia ao form pai (lista de operacoes)
    this_nDataSessionId   = 0       && DataSessionId do form pai (cursores TmpCabec/TmpItens vivem la)
    this_lReservaAuto     = .F.     && .T. quando a reserva de estoque e automatica
    this_nEmpHpdr         = 0       && Codigo do grupo/empresa padrao de geracao (Emphpdr)
    this_lAutomatico      = .F.     && .T. quando o processamento e automatico (sem interacao)
    this_cNumeroDaOp      = ""      && Numero da operacao de origem (Numerodaop)
    this_cPorDestino      = ""      && Destino da operacao (PorDestino)

    *-- Estado da grade de operacoes selecionaveis
    this_cOrdConta        = ""      && Ordem corrente da grade (EMPDOPNUM ou ENTREGA)

    *-- Resultado de ValidarSelecaoParaProcessamento(): quantidade de operacoes
    *-- marcadas (Flag) no cursor de cabecalho. Fonte UNICA da contagem - o form
    *-- le esta property para saber em QUAL ramo do Processar.Click legado a
    *-- validacao caiu (selecao vazia x Jobs diferentes), porque so o ramo da
    *-- selecao vazia devolvia o foco a Column1 da grade.
    this_nOperacoesMarcadas = 0

    *-- Nomes dos cursores de trabalho (populados pelo form pai antes de abrir este dialogo)
    this_cCursorCabecalho = "TmpCabec"  && Cabecalho das operacoes disponiveis para selecao
    this_cCursorItens     = "TmpItens"  && Itens da operacao corrente (filtrados por EmpDopNum)
    this_cCursorOperacoes = "TmpOper"   && Cursor auxiliar de operacoes (ChkObs/Reservas)

    *-- Campos do cabecalho da operacao corrente (mapeados de TmpCabec via CarregarDoCursor)
    this_lFlag     = .F.  && Operacao marcada para processamento
    this_cEmps     = ""   && Empresa da operacao
    this_cDopes    = ""   && Tipo de documento/operacao (Dopes)
    this_nNumes    = 0    && Numero da operacao
    this_dDatas    = {}   && Data de emissao
    this_dEntregas = {}   && Data de entrega
    this_nPeso     = 0    && Peso total da operacao
    this_cContav   = ""   && Codigo da conta (coluna Contav da grade)
    this_cConta    = ""   && Codigo da conta
    this_cDConta   = ""   && Descricao da conta (cliente/fornecedor)
    this_cObs      = ""   && Observacao do cabecalho
    this_cNotas    = ""   && Numero da nota
    this_cGrupoOs  = ""   && Grupo de origem
    this_cContaOs  = ""   && Conta de origem
    this_cGrupoDs  = ""   && Grupo de destino
    this_cContaDs  = ""   && Conta de destino
    this_cJobs     = ""   && Job da operacao

    *-- Resultado de ExecutarProcessamento(), consumido pelo form para decidir
    *-- qual tela filha abrir (SigPrGlx com fabricacao / SigPrGlp sem fabricacao)
    this_cCursorFinal      = "TmpFinal"   && Itens prontos para gerar OP
    this_cCursorFinalG     = "TmpFinalg"  && Itens agrupados (fabricacao)
    this_lPossuiFabricacao = .F.                    && .T. quando crSigCdPac.DopEsts exige geracao de OP de fabricacao

    *--------------------------------------------------------------------------
    * INIT - Construtor
    * Este BO nao opera sobre uma unica tabela SQL Server: trabalha sobre
    * cursores temporarios ja preparados pelo formulario pai (TmpCabec/
    * TmpItens), por isso this_cTabela/this_cCampoChave ficam vazios.
    *
    * crSigCdPam/crSigCdPac sao cursores globais do Fortyus que o sistema
    * legado pre-carregava no login (GrupoEsts/ContaEsts/TransfRes e
    * DopEsts/GerPcps/nMeses, usados em ExecutarProcessamento). O sistema
    * novo nao faz esse pre-load, entao o BO os popula aqui - mesmo padrao
    * do ClienteBO (Erro118).
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_nResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            IF USED("crSigCdPam")
                USE IN crSigCdPam
            ENDIF
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_nResultado = SQLEXEC(gnConnHandle, "SELECT TOP 1 GrupoEsts, ContaEsts, TransfRes FROM SigCdPam", "cursor_4c_Pam_Temp")
                IF loc_nResultado > 0 AND USED("cursor_4c_Pam_Temp")
                    SELECT * FROM cursor_4c_Pam_Temp INTO CURSOR crSigCdPam READWRITE
                    USE IN cursor_4c_Pam_Temp
                ENDIF
            ENDIF
            IF !USED("crSigCdPam")
                CREATE CURSOR crSigCdPam (GrupoEsts C(10), ContaEsts C(10), TransfRes C(20))
                APPEND BLANK
            ENDIF

            IF USED("crSigCdPac")
                USE IN crSigCdPac
            ENDIF
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_nResultado = SQLEXEC(gnConnHandle, "SELECT TOP 1 DopEsts, GerPcps, nMeses FROM SigCdPac", "cursor_4c_Pac_Temp")
                IF loc_nResultado > 0 AND USED("cursor_4c_Pac_Temp")
                    SELECT * FROM cursor_4c_Pac_Temp INTO CURSOR crSigCdPac READWRITE
                    USE IN cursor_4c_Pac_Temp
                ENDIF
            ENDIF
            IF !USED("crSigCdPac")
                CREATE CURSOR crSigCdPac (DopEsts C(20), GerPcps N(1,0), nMeses N(2,0))
                APPEND BLANK
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Nota de arquitetura (Fase 2/8): este BO nao grava um registro de
    * entidade unica (nao ha Inserir/Atualizar/ExecutarExclusao classicos) -
    * SigPrGl2 e um dialogo de selecao/processamento que opera sobre
    * cursores TmpCabec/TmpItens/TmpOper ja preparados pelo formulario pai
    * (equivalente ao AddCursor sem query do legado). CarregarDoCursor()
    * mapeia a linha corrente de TmpCabec para as properties this_ do
    * cabecalho; a gravacao real do legado (INSERT em SigTempD) fica em
    * ExecutarProcessamento(), que reproduz o Click do botao Processar e
    * monta os cursores TmpFinal/TmpFinalG que as telas SigPrGlx/SigPrGlp
    * usam para gerar as OPs. O comportamento herdado de BusinessBase para
    * Inserir()/Atualizar()/ExecutarExclusao() ja e o correto aqui.
    *--------------------------------------------------------------------------

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia a linha corrente do cursor de cabecalho
    * (TmpCabec) para as properties this_ desta classe
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_lFlag     = Flag
            THIS.this_cEmps     = TratarNulo(Emps, "")
            THIS.this_cDopes    = TratarNulo(Dopes, "")
            THIS.this_nNumes    = TratarNulo(Numes, 0)
            THIS.this_dDatas    = TratarNulo(Datas, {})
            THIS.this_dEntregas = TratarNulo(Entregas, {})
            THIS.this_nPeso     = TratarNulo(Peso, 0)
            THIS.this_cContav   = TratarNulo(Contav, "")
            THIS.this_cConta    = TratarNulo(Conta, "")
            THIS.this_cDConta   = TratarNulo(DConta, "")
            THIS.this_cObs      = TratarNulo(Obs, "")
            THIS.this_cNotas    = TratarNulo(Notas, "")
            THIS.this_cGrupoOs  = TratarNulo(GrupoOs, "")
            THIS.this_cContaOs  = TratarNulo(ContaOs, "")
            THIS.this_cGrupoDs  = TratarNulo(GrupoDs, "")
            THIS.this_cContaDs  = TratarNulo(ContaDs, "")
            THIS.this_cJobs     = TratarNulo(Jobs, "")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave EmpDopNum (Emps+Dopes+STR(Numes,6)) da
    * operacao corrente, montagem posicional identica a SigMvCab.EmpDopNums
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarTodasOperacoes - Equivalente aos botoes SelTudo/apaga do legado
    * (Replace All Flag With <valor> In TmpCabec)
    *--------------------------------------------------------------------------
    FUNCTION MarcarTodasOperacoes(par_lMarcar)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(THIS.this_cCursorCabecalho)
            SELECT (THIS.this_cCursorCabecalho)
            REPLACE ALL Flag WITH par_lMarcar
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * DefinirOrdemConta - Equivalente ao mOrdemConta do legado (so a parte de
    * cursor - a cor dos headers da grade fica no form). Aceita apenas as
    * ordens EMPDOPNUM/ENTREGA; qualquer outro valor cai no default EmpDopNum
    *--------------------------------------------------------------------------
    FUNCTION DefinirOrdemConta(par_cOrdem)
        LOCAL loc_lSucesso, loc_cOrdem
        loc_lSucesso = .F.
        loc_cOrdem   = UPPER(TratarNulo(par_cOrdem, ""))

        IF USED(THIS.this_cCursorCabecalho)
            SELECT (THIS.this_cCursorCabecalho)
            IF !EMPTY(loc_cOrdem) AND INLIST(loc_cOrdem, "ENTREGA", "EMPDOPNUM")
                SET ORDER TO (loc_cOrdem)
                THIS.this_cOrdConta = loc_cOrdem
            ELSE
                SET ORDER TO EmpDopNum
                THIS.this_cOrdConta = UPPER(ORDER(THIS.this_cCursorCabecalho))
            ENDIF
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarSelecaoParaProcessamento - Guarda inicial do Click do botao
    * Processar: exige ao menos 1 operacao marcada (Flag) e que todas as
    * marcadas pertencam ao MESMO Job (regra de negocio do legado)
    *--------------------------------------------------------------------------
    FUNCTION ValidarSelecaoParaProcessamento()
        LOCAL loc_lSucesso, loc_nContador, loc_cJob

        loc_lSucesso  = .T.
        loc_nContador = 0
        THIS.this_cMensagemErro      = ""
        THIS.this_nOperacoesMarcadas = 0

        IF !USED(THIS.this_cCursorCabecalho)
            THIS.this_cMensagemErro = "Cursor de opera" + CHR(231) + CHR(245) + "es n" + CHR(227) + "o est" + CHR(225) + " dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        SELECT (THIS.this_cCursorCabecalho)
        SET ORDER TO EmpDopNum
        GO TOP
        loc_cJob = Jobs
        SCAN FOR Flag
            loc_nContador = loc_nContador + 1
            IF loc_cJob != Jobs
                THIS.this_cMensagemErro = "N" + CHR(227) + "o " + CHR(233) + " permitido gerar OPs de opera" + CHR(231) + CHR(245) + "es com Jobs diferentes."
                loc_lSucesso = .F.
                EXIT
            ENDIF
        ENDSCAN

        THIS.this_nOperacoesMarcadas = loc_nContador

        IF loc_lSucesso AND loc_nContador = 0
            THIS.this_cMensagemErro = "Nenhuma Opera" + CHR(231) + CHR(227) + "o Foi Selecionada!!!"
            loc_lSucesso = .F.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarProcessamento - Replica o Click do botao "Processar" do legado
    * (SIGPRGL2.SCX): calcula o saldo em estoque disponivel para as
    * operacoes marcadas (Flag = .T.) em this_cCursorCabecalho/
    * this_cCursorItens, descontando o que ja esta reservado/fabricado, e
    * monta this_cCursorFinal (TmpFinal) - e, quando o parametro
    * de fabricacao esta configurado (crSigCdPac.DopEsts), tambem
    * this_cCursorFinalG (TmpFinalg) agrupado por produto -
    * prontos para as telas SigPrGlx (fabricacao) / SigPrGlp (sem
    * fabricacao) gerarem as OPs.
    *
    * Equivalencia com o legado: ThisForm.PodataMgr.SqlExecute(...) vira
    * SQLEXEC(gnConnHandle, ...); ThisForm.PodataMgr2.UpDate('CrSigTempd')
    * vira INSERT direto em SigTempD (linha a linha, na mesma transacao
    * manual que o commit/rollback do legado fazia); ThisForm.
    * poDataMgr.CursorQuery(...) vira SELECT ... INTO CURSOR equivalente;
    * _Empr vira go_4c_Sistema.cCodEmpresa (regra #Global Variables).
    *
    * A consulta de vendas (Selecao->Vendas, usada so quando
    * crSigCdPac.nMeses > 0) tinha no legado a coluna "opers" AMBIGUA -
    * vinda tanto de SigMvItn (char) quanto de SigCdOpe (numeric) sem
    * alias, o que so funcionava por coincidencia de resolucao do cliente
    * VFP. Aqui as duas vem explicitamente aliasadas (OpersOpe/OpersItn)
    * para no dar erro de tipo (numeric x char) na mesma expressao.
    *--------------------------------------------------------------------------
    FUNCTION ExecutarProcessamento()
        LOCAL loc_lSucesso, loc_lProsseguir, loc_lManual, loc_oErro
        LOCAL loc_cCidQuerys, loc_cSQL, loc_nResultado
        LOCAL loc_cEdI, loc_cEdF, loc_cEdn, loc_nItn
        LOCAL loc_nProduzir, loc_nEstoque, loc_nXBaixa, loc_nSaldoBaixa
        LOCAL loc_dLimite, loc_lFlagCab

        loc_lSucesso    = .F.
        loc_lProsseguir = .T.
        loc_lManual     = (SQLGETPROP(gnConnHandle, "Transactions") = 2)
        THIS.this_cMensagemErro     = ""
        THIS.this_lPossuiFabricacao = .F.

        *-- 1) Preparando estoque disponivel: grava em SigTempD (staging) uma
        *-- linha por Grupo/Conta de estoque a considerar (TpCads <> 1) - ou,
        *-- na ausencia de qualquer um, a linha padrao de crSigCdPam
        TRY
            loc_cCidQuerys = fUniqueIds()

            loc_cSQL = "SELECT * FROM SigCdCeg WHERE TpCads <> 1"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCeg")
            IF loc_nResultado < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (TmpCeg)"
                loc_lProsseguir = .F.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lProsseguir = .F.
        ENDTRY

        IF loc_lProsseguir
            TRY
                IF RECCOUNT("cursor_4c_TmpCeg") > 0
                    SELECT cursor_4c_TmpCeg
                    SCAN
                        loc_cSQL = "INSERT INTO SigTempD (Grupos, Contas, CodObs, Emps, Dpros, CidChaves, CidQuerys) VALUES (" + ;
                            EscaparSQL(cursor_4c_TmpCeg.Grupos) + ", " + ;
                            EscaparSQL(cursor_4c_TmpCeg.Contas) + ", " + ;
                            FormatarNumeroSQL(cursor_4c_TmpCeg.Priors, 0) + ", " + ;
                            EscaparSQL(cursor_4c_TmpCeg.Emps) + ", " + ;
                            EscaparSQL("") + ", " + ;
                            EscaparSQL(fUniqueIds()) + ", " + ;
                            EscaparSQL(loc_cCidQuerys) + ")"
                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            THIS.this_cMensagemErro = "Favor reinicializar o processo. (SigTempD)"
                            loc_lProsseguir = .F.
                            EXIT
                        ENDIF
                    ENDSCAN
                ELSE
                    loc_cSQL = "INSERT INTO SigTempD (Grupos, Contas, CodObs, Emps, Dpros, CidChaves, CidQuerys) VALUES (" + ;
                        EscaparSQL(crSigCdPam.GrupoEsts) + ", " + ;
                        EscaparSQL(crSigCdPam.ContaEsts) + ", " + ;
                        FormatarNumeroSQL(1, 0) + ", " + ;
                        EscaparSQL(go_4c_Sistema.cCodEmpresa) + ", " + ;
                        EscaparSQL("") + ", " + ;
                        EscaparSQL(fUniqueIds()) + ", " + ;
                        EscaparSQL(loc_cCidQuerys) + ")"
                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                        THIS.this_cMensagemErro = "Favor reinicializar o processo. (SigTempD)"
                        loc_lProsseguir = .F.
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
                loc_lProsseguir = .F.
            ENDTRY
        ENDIF

        IF loc_lProsseguir
            IF loc_lManual
                = SQLCOMMIT(gnConnHandle)
            ENDIF
        ELSE
            IF loc_lManual
                = SQLROLLBACK(gnConnHandle)
            ENDIF
        ENDIF

        *-- 2) Estoque disponivel por Grupo/Estoque/Produto (equivalente ao
        *-- Union do legado, cruzando SigMvEst com o SigTempD recem-gravado)
        IF loc_lProsseguir
            TRY
                loc_cSQL = "SELECT a.*, b.CodObs AS Priors FROM SigMvEst a, SigTempD b " + ;
                    "WHERE a.Grupos = b.Grupos AND a.Estos = b.Contas AND a.Emps = b.Emps AND a.Sqtds > 0 " + ;
                    "UNION " + ;
                    "SELECT a.*, b.CodObs AS Priors FROM SigMvEst a, SigTempD b " + ;
                    "WHERE a.Grupos = b.Grupos AND b.Contas = '' AND a.Emps = b.Emps AND a.Sqtds > 0"
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpEstoque")
                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (TmpEstoque)"
                    loc_lProsseguir = .F.
                ENDIF
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
                loc_lProsseguir = .F.
            ENDTRY
        ENDIF

        *-- Limpa o staging gravado no passo 1 (equivalente a fSqlApagarTmp)
        IF loc_lProsseguir
            TRY
                SQLEXEC(gnConnHandle, "DELETE FROM SigTempD WHERE CidQuerys = " + EscaparSQL(loc_cCidQuerys))
                IF loc_lManual
                    = SQLCOMMIT(gnConnHandle)
                ENDIF
            CATCH TO loc_oErro
                IF loc_lManual
                    = SQLROLLBACK(gnConnHandle)
                ENDIF
            ENDTRY
        ENDIF

        *-- 3) Monta TmpSaldo (saldo por produto/cor/tamanho) e TmpSaldg
        *-- (saldo por grupo/estoque/produto/cor/tamanho), varrendo TmpEstoque
        IF loc_lProsseguir
            IF USED("cursor_4c_TmpSaldo")
                USE IN cursor_4c_TmpSaldo
            ENDIF
            IF USED("cursor_4c_TmpSaldg")
                USE IN cursor_4c_TmpSaldg
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_TmpSaldo (CPros C(14), CodCors C(4), CodTams C(4), Saldo N(12,3), Disps N(12,3), Fabrs N(12,3), DispFs N(12,3))
            SET NULL OFF
            INDEX ON CPros + CodCors + CodTams TAG CPros

            SET NULL ON
            CREATE CURSOR cursor_4c_TmpSaldg (Emps C(3), Grupos C(10), Estos C(10), CPros C(14), CodCors C(4), CodTams C(4), Saldo N(12,3), Disps N(12,3), Priors N(2), Reservs N(12,3))
            SET NULL OFF
            INDEX ON CPros + CodCors + CodTams + STR(Priors,2) + Grupos + Estos + Emps TAG CPros
            INDEX ON Emps + Grupos + Estos + CPros + CodCors + CodTams TAG GruEstPro

            SELECT cursor_4c_TmpEstoque
            SCAN
                SELECT cursor_4c_TmpSaldo
                IF !SEEK(cursor_4c_TmpEstoque.Cpros + cursor_4c_TmpEstoque.CodCors + cursor_4c_TmpEstoque.CodTams)
                    INSERT INTO cursor_4c_TmpSaldo (CPros, CodCors, CodTams, Saldo, Disps) ;
                        VALUES (cursor_4c_TmpEstoque.CPros, cursor_4c_TmpEstoque.CodCors, cursor_4c_TmpEstoque.CodTams, 0, 0)
                ENDIF
                REPLACE Saldo WITH Saldo + cursor_4c_TmpEstoque.Sqtds, ;
                    Disps WITH Disps + cursor_4c_TmpEstoque.Sqtds IN cursor_4c_TmpSaldo

                INSERT INTO cursor_4c_TmpSaldg (Grupos, Estos, CPros, CodCors, CodTams, Saldo, Disps, Priors, Emps) ;
                    VALUES (cursor_4c_TmpEstoque.Grupos, cursor_4c_TmpEstoque.Estos, cursor_4c_TmpEstoque.CPros, cursor_4c_TmpEstoque.CodCors, ;
                        cursor_4c_TmpEstoque.CodTams, cursor_4c_TmpEstoque.SQtds, cursor_4c_TmpEstoque.SQtds, cursor_4c_TmpEstoque.Priors, cursor_4c_TmpEstoque.Emps)

                *-- INSERT INTO troca a area corrente - restaurar antes do ENDSCAN
                SELECT cursor_4c_TmpEstoque
            ENDSCAN
        ENDIF

        *-- 4) Reserva por transferencia em aberto (SigCdPam.TransfRes): abate
        *-- do saldo o que ja esta alocado em operacoes de transferencia em
        *-- aberto cuja operacao NAO controla estoque (SigCdOpe.Estoqs <> 1)
        IF loc_lProsseguir
            TRY
                loc_cSQL = "SELECT * FROM SigCdOpe WHERE Dopes = " + EscaparSQL(crSigCdPam.TransfRes)
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdOpe")
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
                loc_lProsseguir = .F.
            ENDTRY
        ENDIF

        IF loc_lProsseguir AND !EMPTY(crSigCdPam.TransfRes) AND USED("cursor_4c_SigCdOpe") AND !EOF("cursor_4c_SigCdOpe") AND cursor_4c_SigCdOpe.Estoqs <> 1
            loc_cEdI = PADR(go_4c_Sistema.cCodEmpresa, 3) + PADR(crSigCdPam.TransfRes, 20) + STR(0, 6)
            loc_cEdF = PADR(go_4c_Sistema.cCodEmpresa, 3) + PADR(crSigCdPam.TransfRes, 20) + STR(999999, 6)

            TRY
                loc_cSQL = "SELECT EmpDopNums, GrupoOs, ContaOs, Emps, Dopes, Numes FROM SigMvCab " + ;
                    "WHERE EmpDopNums BETWEEN " + EscaparSQL(loc_cEdI) + " AND " + EscaparSQL(loc_cEdF) + " " + ;
                    "ORDER BY EmpDopNums"
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TempEest")
                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (TempEest)"
                    loc_lProsseguir = .F.
                ENDIF
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
                loc_lProsseguir = .F.
            ENDTRY

            IF loc_lProsseguir
                SELECT cursor_4c_TempEest
                SCAN
                    loc_cEdn = cursor_4c_TempEest.EmpDopNums

                    IF USED("cursor_4c_TempEestI")
                        USE IN cursor_4c_TempEestI
                    ENDIF
                    SQLEXEC(gnConnHandle, "SELECT * FROM SigMvItn WHERE EmpDopNums = " + EscaparSQL(loc_cEdn), "cursor_4c_TempEestI")

                    IF USED("cursor_4c_TempEestI")
                        SELECT cursor_4c_TempEestI
                        SCAN FOR (Qtds - QtBaixas) > 0
                            loc_nItn = cursor_4c_TempEestI.CItens

                            IF USED("cursor_4c_TempEsti2")
                                USE IN cursor_4c_TempEsti2
                            ENDIF
                            loc_cSQL = "SELECT * FROM SigMvIts WHERE EmpDopNums = " + EscaparSQL(loc_cEdn) + " AND CItens = " + FormatarNumeroSQL(loc_nItn, 0)
                            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TempEsti2")

                            IF !USED("cursor_4c_TempEsti2") OR EOF("cursor_4c_TempEsti2")
                                SELECT cursor_4c_TmpSaldo
                                IF !SEEK(cursor_4c_TempEestI.Cpros)
                                    INSERT INTO cursor_4c_TmpSaldo (Cpros) VALUES (cursor_4c_TempEestI.CPros)
                                ENDIF
                                REPLACE Saldo WITH Saldo - (cursor_4c_TempEestI.Qtds - cursor_4c_TempEestI.QtBaixas), ;
                                    Disps WITH Disps - (cursor_4c_TempEestI.Qtds - cursor_4c_TempEestI.QtBaixas)

                                SELECT cursor_4c_TmpSaldg
                                SET ORDER TO GruEstPro
                                IF !SEEK(cursor_4c_TempEest.Emps + cursor_4c_TempEest.GrupoOs + cursor_4c_TempEest.ContaOs + cursor_4c_TempEestI.Cpros)
                                    INSERT INTO cursor_4c_TmpSaldg (Emps, Grupos, Estos, Cpros, Priors) ;
                                        VALUES (cursor_4c_TempEest.Emps, cursor_4c_TempEest.GrupoOs, cursor_4c_TempEest.ContaOs, cursor_4c_TempEestI.CPros, 99)
                                ENDIF
                                REPLACE Saldo WITH Saldo - (cursor_4c_TempEestI.Qtds - cursor_4c_TempEestI.QtBaixas), ;
                                    Disps WITH Disps - (cursor_4c_TempEestI.Qtds - cursor_4c_TempEestI.QtBaixas)
                            ELSE
                                SELECT cursor_4c_TempEsti2
                                SCAN
                                    loc_nSaldoBaixa = cursor_4c_TempEsti2.Qtds - cursor_4c_TempEsti2.QtBaixas

                                    SELECT cursor_4c_TmpSaldo
                                    IF !SEEK(cursor_4c_TempEsti2.Cpros + cursor_4c_TempEsti2.CodCors + cursor_4c_TempEsti2.CodTams)
                                        INSERT INTO cursor_4c_TmpSaldo (Cpros, CodCors, CodTams) ;
                                            VALUES (cursor_4c_TempEsti2.CPros, cursor_4c_TempEsti2.CodCors, cursor_4c_TempEsti2.CodTams)
                                    ENDIF
                                    REPLACE Saldo WITH Saldo - loc_nSaldoBaixa, Disps WITH Disps - loc_nSaldoBaixa

                                    SELECT cursor_4c_TmpSaldg
                                    SET ORDER TO GruEstPro
                                    IF !SEEK(cursor_4c_TempEest.Emps + cursor_4c_TempEest.GrupoOs + cursor_4c_TempEest.ContaOs + cursor_4c_TempEsti2.Cpros + cursor_4c_TempEsti2.CodCors + cursor_4c_TempEsti2.CodTams)
                                        INSERT INTO cursor_4c_TmpSaldg (Emps, Grupos, Estos, Cpros, CodCors, CodTams, Priors) ;
                                            VALUES (cursor_4c_TempEest.Emps, cursor_4c_TempEest.GrupoOs, cursor_4c_TempEest.ContaOs, ;
                                            cursor_4c_TempEsti2.CPros, cursor_4c_TempEsti2.CodCors, cursor_4c_TempEsti2.CodTams, 99)
                                    ENDIF
                                    REPLACE Saldo WITH Saldo - loc_nSaldoBaixa, Disps WITH Disps - loc_nSaldoBaixa

                                    *-- INSERT INTO troca a area corrente - restaurar antes do ENDSCAN
                                    SELECT cursor_4c_TempEsti2
                                ENDSCAN
                            ENDIF

                            *-- SQLEXEC/INSERT INTO trocam a area corrente - restaurar antes do ENDSCAN
                            SELECT cursor_4c_TempEestI
                        ENDSCAN
                    ENDIF

                    *-- SQLEXEC troca a area corrente - restaurar antes do ENDSCAN
                    SELECT cursor_4c_TempEest
                ENDSCAN
            ENDIF
        ENDIF

        *-- 5) Monta TmpFinal com os itens das operacoes marcadas, descontando
        *-- o estoque disponivel calculado acima
        IF loc_lProsseguir
            IF USED("TmpFinal")
                USE IN TmpFinal
            ENDIF
            CREATE CURSOR TmpFinal (Emps C(3), Dopes C(20), Numes N(6), CPros C(14), Qtds N(10,3), Peso N(9,3), ;
                Saldo N(10,3), Estoque N(10,3), Produzir N(10,3), Obs M NULL, Obsps M NULL, ;
                Datas D NULL, Entregas D NULL, CodCors C(4), CodTams C(4), Linhas C(10), ;
                Citens N(10), Reffs C(40), Notas C(6), Dpros C(40), GrupoDs C(10), ContaDs C(10), ;
                KeySelM L, Fabrs N(10,3), KeyPdes L, Jobs C(10))
            INDEX ON Cpros + CodCors + CodTams TAG Cpros

            SELECT (THIS.this_cCursorCabecalho)
            SET ORDER TO EmpDopNum

            SELECT (THIS.this_cCursorItens)
            SET KEY TO
            SET ORDER TO CPros
            SCAN
                SELECT (THIS.this_cCursorCabecalho)
                SEEK EVALUATE(THIS.this_cCursorItens + ".Emps") + EVALUATE(THIS.this_cCursorItens + ".Dopes") + STR(EVALUATE(THIS.this_cCursorItens + ".Numes"), 6)
                loc_lFlagCab = Flag

                *-- SCAN/LOOP dependem da area CORRENTE, nao da area em que o
                *-- SCAN foi aberto - restaurar this_cCursorItens ANTES do LOOP
                SELECT (THIS.this_cCursorItens)
                IF !loc_lFlagCab
                    LOOP
                ENDIF

                SELECT (THIS.this_cCursorOperacoes)
                SEEK EVALUATE(THIS.this_cCursorItens + ".Dopes")

                SELECT (THIS.this_cCursorItens)
                IF (Saldo > 0)
                    STORE 0 TO loc_nEstoque, loc_nProduzir

                    IF (EVALUATE(THIS.this_cCursorOperacoes + ".ChkObs") <> 1 AND !EMPTY(Obs)) OR ;
                            !SEEK(CPros + CodCors + CodTams, "cursor_4c_TmpSaldo") OR ;
                            EMPTY(crSigCdPam.TransfRes) OR (EVALUATE(THIS.this_cCursorOperacoes + ".Reservas") = 2 AND !THIS.this_lReservaAuto) OR ;
                            cursor_4c_TmpSaldo.Disps < 0
                        loc_nProduzir = Saldo
                    ELSE
                        = SEEK(CPros + CodCors + CodTams, "cursor_4c_TmpSaldo")
                        loc_nEstoque = cursor_4c_TmpSaldo.Disps
                        IF (cursor_4c_TmpSaldo.Disps >= Saldo)
                            REPLACE cursor_4c_TmpSaldo.Disps WITH cursor_4c_TmpSaldo.Disps - Saldo
                        ELSE
                            loc_nProduzir = Saldo - cursor_4c_TmpSaldo.Disps
                            REPLACE cursor_4c_TmpSaldo.Disps WITH 0
                        ENDIF
                    ENDIF

                    IF USED("cursor_4c_SigCdPro")
                        USE IN cursor_4c_SigCdPro
                    ENDIF
                    SQLEXEC(gnConnHandle, "SELECT * FROM SigCdPro WHERE Cpros = " + EscaparSQL(CPros), "cursor_4c_SigCdPro")

                    *-- SQLEXEC troca a area corrente - restaurar antes de ler os
                    *-- campos "soltos" (Emps/Dopes/Numes/...) abaixo, que se
                    *-- referem ao registro corrente de this_cCursorItens
                    SELECT (THIS.this_cCursorItens)

                    INSERT INTO TmpFinal (Emps, Dopes, Numes, CPros, Qtds, Peso, Saldo, Estoque, Produzir, Obsps, ;
                            Obs, Datas, Entregas, CodCors, CodTams, Linhas, Citens, Reffs, Notas, ;
                            Dpros, GrupoDs, ContaDs, Jobs) ;
                        VALUES (Emps, Dopes, Numes, CPros, Qtds, Peso, Saldo, Saldo - loc_nProduzir, ;
                            loc_nProduzir, TratarNulo(Obs, ""), TratarNulo(EVALUATE(THIS.this_cCursorCabecalho + ".Obs"), ""), ;
                            TratarNulo(EVALUATE(THIS.this_cCursorCabecalho + ".Datas"), {}), ;
                            TratarNulo(EVALUATE(THIS.this_cCursorCabecalho + ".Entregas"), {}), CodCors, CodTams, ;
                            Linhas, CItens, IIF(USED("cursor_4c_SigCdPro"), TratarNulo(cursor_4c_SigCdPro.Reffs, ""), ""), Notas, ;
                            Dpros, EVALUATE(THIS.this_cCursorCabecalho + ".Grupods"), EVALUATE(THIS.this_cCursorCabecalho + ".Contads"), ;
                            EVALUATE(THIS.this_cCursorCabecalho + ".Jobs"))

                    *-- INSERT INTO troca a area corrente - restaurar antes do ENDSCAN
                    SELECT (THIS.this_cCursorItens)
                ENDIF
            ENDSCAN
        ENDIF

        *-- 6) Distribui a baixa apurada em TmpSaldo pelos grupos/estoques de
        *-- TmpSaldg (mesmo produto/cor/tamanho), na ordem de prioridade
        IF loc_lProsseguir
            SELECT cursor_4c_TmpSaldo
            SCAN
                IF Saldo # Disps
                    loc_nXBaixa = Saldo - Disps
                    SELECT cursor_4c_TmpSaldg
                    SET ORDER TO Cpros
                    = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
                    SCAN WHILE Cpros = cursor_4c_TmpSaldo.Cpros AND CodCors = cursor_4c_TmpSaldo.CodCors AND CodTams = cursor_4c_TmpSaldo.CodTams AND loc_nXBaixa > 0
                        IF cursor_4c_TmpSaldg.Disps >= loc_nXBaixa
                            REPLACE cursor_4c_TmpSaldg.Disps WITH cursor_4c_TmpSaldg.Disps - loc_nXBaixa
                            loc_nXBaixa = 0
                        ELSE
                            loc_nXBaixa = loc_nXBaixa - cursor_4c_TmpSaldg.Disps
                            REPLACE cursor_4c_TmpSaldg.Disps WITH 0
                        ENDIF
                    ENDSCAN

                    *-- o SCAN interno deixou cursor_4c_TmpSaldg selecionado -
                    *-- restaurar antes do ENDSCAN externo
                    SELECT cursor_4c_TmpSaldo
                ENDIF
            ENDSCAN
        ENDIF

        *-- 7) Quando o parametro de fabricacao esta configurado
        *-- (crSigCdPac.DopEsts), apura tambem o saldo ja alocado em OPs de
        *-- fabricacao em aberto e monta TmpFinalG (agrupado por produto/
        *-- cor/tamanho) para a tela de fabricacao
        IF loc_lProsseguir AND !EMPTY(crSigCdPac.DopEsts)
            THIS.this_lPossuiFabricacao = .T.

            IF USED("cursor_4c_TmpFabr")
                USE IN cursor_4c_TmpFabr
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_TmpFabr (Priors N(2), Nops N(10), Fases C(10), Cpros C(14), CodCors C(4), CodTams C(4), Qtds N(10,3), Disps N(12,3), Reservs N(12,3))
            SET NULL OFF
            INDEX ON Cpros + CodCors + CodTams + STR(Priors,2) + STR(Nops,10) TAG Cpros

            TRY
                loc_cSQL = "SELECT a.Nops, a.Cpros, a.CodCors, a.CodTams, SUM(a.Qtds) AS Qtds FROM SigOpPic a, SigCdNec b " + ;
                    "WHERE a.Dopes = " + EscaparSQL(crSigCdPac.DopEsts) + " AND a.EmpDopNops = b.EmpDnps AND b.Chksubn = " + FormatarNumeroSQL(0, 0) + " " + ;
                    "AND a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + " GROUP BY a.Nops, a.Cpros, a.CodCors, a.CodTams"
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpi")
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
                loc_lProsseguir = .F.
            ENDTRY

            IF loc_lProsseguir AND USED("cursor_4c_TmpOpi")
                SELECT cursor_4c_TmpOpi
                SCAN
                    SELECT cursor_4c_TmpSaldo
                    IF !SEEK(cursor_4c_TmpOpi.Cpros + cursor_4c_TmpOpi.CodCors + cursor_4c_TmpOpi.CodTams)
                        INSERT INTO cursor_4c_TmpSaldo (CPros, CodCors, CodTams) ;
                            VALUES (cursor_4c_TmpOpi.CPros, cursor_4c_TmpOpi.CodCors, cursor_4c_TmpOpi.CodTams)
                    ENDIF
                    REPLACE Fabrs WITH Fabrs + cursor_4c_TmpOpi.Qtds, DispFs WITH DispFs + cursor_4c_TmpOpi.Qtds

                    INSERT INTO cursor_4c_TmpFabr (Nops, Cpros, CodCors, CodTams, Qtds, Priors) ;
                        VALUES (cursor_4c_TmpOpi.Nops, cursor_4c_TmpOpi.Cpros, cursor_4c_TmpOpi.CodCors, cursor_4c_TmpOpi.CodTams, cursor_4c_TmpOpi.Qtds, 0)

                    IF USED("cursor_4c_TmpMfas")
                        USE IN cursor_4c_TmpMfas
                    ENDIF
                    loc_cSQL = "SELECT GrupoDs FROM SigPdMvf WHERE Nops = " + FormatarNumeroSQL(cursor_4c_TmpOpi.Nops, 0) + " ORDER BY CidChaves DESC"
                    SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMfas")

                    IF USED("cursor_4c_TmpMfas")
                        SELECT cursor_4c_TmpMfas
                        GO TOP
                        IF !EOF("cursor_4c_TmpMfas")
                            REPLACE Fases WITH cursor_4c_TmpMfas.GrupoDs IN cursor_4c_TmpFabr
                        ENDIF
                    ENDIF

                    STORE 0 TO loc_nEstoque, loc_nProduzir

                    IF SEEK(cursor_4c_TmpOpi.Cpros + cursor_4c_TmpOpi.CodCors + cursor_4c_TmpOpi.CodTams, "TmpFinal", "Cpros")
                        IF cursor_4c_TmpSaldo.Fabrs >= TmpFinal.Produzir
                            loc_nEstoque  = TmpFinal.Produzir
                            loc_nProduzir = 0
                            REPLACE cursor_4c_TmpSaldo.Dispfs WITH cursor_4c_TmpSaldo.Dispfs - TmpFinal.Produzir IN cursor_4c_TmpSaldo
                        ELSE
                            loc_nEstoque  = cursor_4c_TmpSaldo.Fabrs
                            loc_nProduzir = TmpFinal.Produzir - cursor_4c_TmpSaldo.Fabrs
                            REPLACE Dispfs WITH 0 IN cursor_4c_TmpSaldo
                        ENDIF
                        REPLACE Produzir WITH loc_nProduzir, Fabrs WITH loc_nEstoque IN TmpFinal
                    ENDIF

                    *-- SQLEXEC/INSERT INTO trocam a area corrente - restaurar antes do ENDSCAN
                    SELECT cursor_4c_TmpOpi
                ENDSCAN

                SELECT cursor_4c_TmpSaldo
                SCAN
                    IF Fabrs # Dispfs
                        loc_nXBaixa = Fabrs - DispFs
                        SELECT cursor_4c_TmpFabr
                        SET ORDER TO Cpros
                        = SEEK(cursor_4c_TmpSaldo.Cpros + cursor_4c_TmpSaldo.CodCors + cursor_4c_TmpSaldo.CodTams)
                        SCAN WHILE Cpros = cursor_4c_TmpSaldo.Cpros AND CodCors = cursor_4c_TmpSaldo.CodCors AND CodTams = cursor_4c_TmpSaldo.CodTams AND loc_nXBaixa > 0
                            IF (cursor_4c_TmpFabr.Qtds - cursor_4c_TmpFabr.Disps) >= loc_nXBaixa
                                REPLACE cursor_4c_TmpFabr.Disps WITH cursor_4c_TmpFabr.Disps + loc_nXBaixa IN cursor_4c_TmpFabr
                                loc_nXBaixa = 0
                            ELSE
                                loc_nXBaixa = loc_nXBaixa - (cursor_4c_TmpFabr.Qtds - cursor_4c_TmpFabr.Disps)
                                REPLACE cursor_4c_TmpFabr.Disps WITH Qtds IN cursor_4c_TmpFabr
                            ENDIF
                        ENDSCAN

                        *-- o SCAN interno deixou cursor_4c_TmpFabr selecionado -
                        *-- restaurar antes do ENDSCAN externo
                        SELECT cursor_4c_TmpSaldo
                    ENDIF
                ENDSCAN

                IF USED("TmpFinalg")
                    USE IN TmpFinalg
                ENDIF
                CREATE CURSOR TmpFinalg (Flag C(1), CPros C(14), CodCors C(4), CodTams C(4), Linhas C(10), Qtds N(10,3), ;
                    Saldo N(10,3), Estoque N(10,3), Produzir N(10,3), Fabrs N(10,3), Produzir2 N(10,3), ;
                    TotVenda N(10,3), QtdMins N(10,3), KeySelM L, KeySelMP L, UsuLibs C(10))
                INDEX ON Cpros + CodCors + CodTams TAG Cpros

                IF USED("cursor_4c_Selecao")
                    USE IN cursor_4c_Selecao
                ENDIF
                SELECT Cpros, CodCors, CodTams, Linhas, SUM(Qtds) AS Qtds, SUM(Saldo) AS Saldo, SUM(Estoque) AS Estoque, ;
                        SUM(Produzir) AS Produzir, SUM(Fabrs) AS Fabrs FROM TmpFinal ;
                    INTO CURSOR cursor_4c_Selecao GROUP BY Cpros, CodCors, CodTams, Linhas READWRITE

                IF crSigCdPac.nMeses > 0
                    loc_dLimite = GOMONTH(DATE(), -crSigCdPac.nmeses)

                    IF USED("cursor_4c_LocalEest")
                        USE IN cursor_4c_LocalEest
                    ENDIF
                    TRY
                        loc_cSQL = "SELECT a.cpros, a.qtds, b.Caixas, b.copers, b.opers AS OpersOpe, a.opers AS OpersItn " + ;
                            "FROM SigMvItn a, SigCdOpe b, SigMvCab c " + ;
                            "WHERE a.EmpDopNums = c.EmpDopNums AND a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + " AND c.datas >= " + FormatarDataSQL(loc_dLimite) + " " + ;
                            "AND a.dopes = b.dopes AND b.tipoops IN (4,5)"
                        SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalEest")
                    CATCH TO loc_oErro
                        THIS.this_cMensagemErro = loc_oErro.Message
                    ENDTRY

                    IF USED("cursor_4c_LocalEest")
                        IF USED("cursor_4c_Vendas")
                            USE IN cursor_4c_Vendas
                        ENDIF
                        SELECT cpros, SUM(qtds * IIF((Caixas = 1 AND copers = 1) OR (caixas <> 1 AND OpersOpe = 1) OR (caixas <> 1 AND OpersOpe = 3 AND OpersItn = "E"), 1, -1)) AS Qtds ;
                            FROM cursor_4c_LocalEest GROUP BY 1 INTO CURSOR cursor_4c_Vendas READWRITE
                        SELECT cursor_4c_Vendas
                        INDEX ON cpros TAG Cpros
                    ENDIF
                ENDIF

                SELECT TmpFinalg
                SCATTER MEMVAR BLANK

                SELECT cursor_4c_Selecao
                SCAN
                    SCATTER MEMVAR
                    m.flag = "+"

                    IF USED("cursor_4c_SigCdProQtd")
                        USE IN cursor_4c_SigCdProQtd
                    ENDIF
                    SQLEXEC(gnConnHandle, "SELECT QtMinFabs FROM SigCdPro WHERE Cpros = " + EscaparSQL(cursor_4c_Selecao.Cpros), "cursor_4c_SigCdProQtd")

                    m.QtdMins = 0
                    IF (crSigCdPac.GerPcps = 2 AND !THIS.this_lReservaAuto) OR (crSigCdPac.GerPcps <> 2 AND THIS.this_lReservaAuto)
                        IF USED("cursor_4c_SigCdProQtd") AND !EOF("cursor_4c_SigCdProQtd")
                            m.QtdMins = cursor_4c_SigCdProQtd.QtMinFabs
                        ENDIF
                    ENDIF

                    IF USED("cursor_4c_Vendas") AND SEEK(m.Cpros, "cursor_4c_Vendas", "Cpros")
                        m.TotVenda = cursor_4c_Vendas.Qtds
                    ELSE
                        m.TotVenda = 0
                    ENDIF

                    m.Produzir2 = IIF(m.QtdMins > 0 AND m.produzir > 0 AND m.Produzir < m.QtdMins, m.QtdMins - m.Produzir, 0)

                    SELECT TmpFinalg
                    APPEND BLANK
                    GATHER MEMVAR

                    *-- APPEND BLANK troca a area corrente - restaurar antes do ENDSCAN
                    SELECT cursor_4c_Selecao
                ENDSCAN
            ENDIF
        ENDIF

        IF loc_lProsseguir
            SELECT (THIS.this_cCursorItens)
            SET ORDER TO EmpDopNum
            SET KEY TO EVALUATE(THIS.this_cCursorCabecalho + ".Emps") + EVALUATE(THIS.this_cCursorCabecalho + ".Dopes") + STR(EVALUATE(THIS.this_cCursorCabecalho + ".Numes"), 6)
            GO TOP

            THIS.this_cCursorFinal  = "TmpFinal"
            THIS.this_cCursorFinalG = "TmpFinalg"
            loc_lSucesso = .T.
        ELSE
            IF EMPTY(THIS.this_cMensagemErro)
                THIS.this_cMensagemErro = "Favor reinicializar o processo."
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE
