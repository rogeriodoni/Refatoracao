*==============================================================================
* SigPrGloBO.prg - Business Object para Processamento de O.P.
* Data: 2026-07-03
* Tabela: SigMvCab (principal - registros processados)
* Legado: SigPrGlo.SCX (form operacional)
*==============================================================================

DEFINE CLASS SigPrGloBO AS BusinessBase

    *--------------------------------------------------------------------------
    *-- Modo de operacao (passados via parametros na abertura do form)
    *--------------------------------------------------------------------------
    this_lReserva     = .F.    && Modo reserva automatica (_Reserva)
    this_lAutomatico  = .F.    && Modo automatico (_Autom)
    this_lPorDestino  = .F.    && Por destino (_PorDestino)
    this_lGerPorTp    = .F.    && Gerar por tipo de OP (pTipo)
    this_lAlterEmp    = .T.    && Permite alterar empresa (AlterEmp)

    *--------------------------------------------------------------------------
    *-- Filtros de periodo de emissao
    *--------------------------------------------------------------------------
    this_dDataei      = {}     && Data emissao inicial (GetDataei)
    this_dDataef      = {}     && Data emissao final (GetDataef)

    *--------------------------------------------------------------------------
    *-- Filtros de periodo de previsao de entrega
    *--------------------------------------------------------------------------
    this_dDatapi      = {}     && Data previsao entrega inicial (GetDatapi)
    this_dDatapf      = {}     && Data previsao entrega final (GetDatapf)

    *--------------------------------------------------------------------------
    *-- Filtro de operacao
    *--------------------------------------------------------------------------
    this_cOperacao    = ""     && Codigo da operacao (Get_Operacao)
    this_nOperacaoi   = 0      && Numero OP inicial - faixa (Get_Operacaoi)
    this_nOperacaof   = 0      && Numero OP final - faixa (Get_Operacaof)

    *--------------------------------------------------------------------------
    *-- Conta / Movimentacao (cliente)
    *--------------------------------------------------------------------------
    this_cGrupoConta  = ""     && Grupo da conta (Conta.Get_grupo)
    this_cConta       = ""     && Conta (Conta.Get_conta)
    this_cDconta      = ""     && Descricao da conta (Conta.Get_dconta)

    *--------------------------------------------------------------------------
    *-- Responsavel / Vendedor
    *--------------------------------------------------------------------------
    this_cGrupoResp   = ""     && Grupo do responsavel (Responsavel.Get_grupo)
    this_cContaResp   = ""     && Conta do responsavel (Responsavel.Get_conta)
    this_cDcontaResp  = ""     && Descricao do responsavel (Responsavel.Get_dconta)

    *--------------------------------------------------------------------------
    *-- Empresa
    *--------------------------------------------------------------------------
    this_cCdEmpresa   = ""     && Codigo da empresa (Empresa.get_cd_empresa)
    this_cDsEmpresa   = ""     && Razao social da empresa (Empresa.get_ds_empresa)
    this_nNaoEmpPedra = 0      && Nao empenhar pedras: 0=nao, 1=sim (Empresa.Chec_pedra)

    *--------------------------------------------------------------------------
    *-- Tipo de geracao de OP
    *--------------------------------------------------------------------------
    this_cTpGOp       = ""     && Codigo do tipo de geracao (Container1.Get_TpGOp)

    *--------------------------------------------------------------------------
    *-- Previsao de entrega e data de geracao
    *--------------------------------------------------------------------------
    this_dPrevisao    = {}     && Data de previsao de entrega (Cnt_Previsao.GetPrevisao)
    this_dGeracao     = {}     && Data de geracao (Cnt_Previsao.GetGeracao)

    *--------------------------------------------------------------------------
    *-- Numero da OP manual (GlobAutos = 2)
    *--------------------------------------------------------------------------
    this_nNop         = 0      && Numero da OP manual (Cnt_Op.GetNop)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = "Numes"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - carrega propriedades a partir de cursor com registros de OP
    * Usado quando o form recarrega um contexto ja gerado a partir de SigOpPic
    * ou de cursor temporario TmpCabec/TmpItens. Popula filtros base.
    * Retorna .T. se pelo menos os campos essenciais foram carregados.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(par_cAliasCursor) OR NOT USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)
        IF EOF()
            RETURN .F.
        ENDIF

        *-- Empresa (todos os cursores relevantes tem coluna Emps)
        IF TYPE(par_cAliasCursor + ".Emps") = "C"
            THIS.this_cCdEmpresa = NVL(ALLTRIM(EVALUATE(par_cAliasCursor + ".Emps")), "")
            loc_lSucesso = .T.
        ENDIF

        *-- Operacao (Dopes) e movimento (Numes) - opcionais conforme cursor origem
        IF TYPE(par_cAliasCursor + ".Dopes") = "C"
            THIS.this_cOperacao  = NVL(ALLTRIM(EVALUATE(par_cAliasCursor + ".Dopes")), "")
            THIS.this_nOperacaoi = 0
            THIS.this_nOperacaof = 0
        ENDIF
        IF TYPE(par_cAliasCursor + ".Datas") = "D"
            THIS.this_dGeracao = NVL(EVALUATE(par_cAliasCursor + ".Datas"), DATE())
        ENDIF
        IF TYPE(par_cAliasCursor + ".Entregas") = "D"
            THIS.this_dPrevisao = NVL(EVALUATE(par_cAliasCursor + ".Entregas"), DATE())
        ENDIF
        IF TYPE(par_cAliasCursor + ".Grupo") = "C"
            THIS.this_cGrupoConta = NVL(ALLTRIM(EVALUATE(par_cAliasCursor + ".Grupo")), "")
        ENDIF
        IF TYPE(par_cAliasCursor + ".Conta") = "C"
            THIS.this_cConta = NVL(ALLTRIM(EVALUATE(par_cAliasCursor + ".Conta")), "")
        ENDIF
        IF TYPE(par_cAliasCursor + ".DConta") = "C"
            THIS.this_cDconta = NVL(ALLTRIM(EVALUATE(par_cAliasCursor + ".DConta")), "")
        ENDIF
        IF TYPE(par_cAliasCursor + ".Grupov") = "C"
            THIS.this_cGrupoResp = NVL(ALLTRIM(EVALUATE(par_cAliasCursor + ".Grupov")), "")
        ENDIF
        IF TYPE(par_cAliasCursor + ".Contav") = "C"
            THIS.this_cContaResp = NVL(ALLTRIM(EVALUATE(par_cAliasCursor + ".Contav")), "")
        ENDIF
        IF TYPE(par_cAliasCursor + ".Numes") = "N"
            THIS.this_nNop = NVL(EVALUATE(par_cAliasCursor + ".Numes"), 0)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarDataHoraSQL - retorna 'YYYY-MM-DD HH:MM:SS' com aspas simples
    * par_cHora: ex "23:59:59" ou "00:00:00"
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarDataHoraSQL(par_dData, par_cHora)
        LOCAL loc_cBase
        IF EMPTY(par_dData) OR VARTYPE(par_dData) != "D"
            RETURN "NULL"
        ENDIF
        *-- FormatarDataSQL retorna 'YYYY-MM-DD' (12 chars, com aspas)
        *-- Remove aspas de fechamento e adiciona hora
        loc_cBase = FormatarDataSQL(par_dData)
        RETURN SUBSTR(loc_cBase, 1, LEN(loc_cBase)-1) + " " + par_cHora + "'"
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametros - carrega dados de configuracao para o processamento
    * Cria cursores: crSigCdPam, crSigCdPac, TmpOper, CrTmpTpGop
    * par_lGerPorTp: .T. se modo de geracao por tipo de OP
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametros(par_lGerPorTp)
        LOCAL loc_lSucesso, loc_cSQL, loc_cCampos, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Parametros de OP (SigCdPam)
            loc_cCampos = "DopEmphs, DopReqcs, DopPedcs, DopComps, TransfRes, GrPadClis, " + ;
                          "DoppPads, DopTrfCps, GrPadVens, PrevProds, GrupoEsts, ContaEsts, " + ;
                          "GruReservs, ConReservs, AgrupEmph, DoppServs, mascnums, GruEstps, " + ;
                          "ConEstps, transfencs, Ouros, GruConfs, ConConfs, GlobAutos, " + ;
                          "DopEntAus, TpOpEntAus, AutComps"
            loc_cSQL = "SELECT " + loc_cCampos + " FROM SigCdPam"
            IF USED("crSigCdPam")
                USE IN crSigCdPam
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdPam") < 1
                MsgErro("Falha ao carregar par" + CHR(226) + "metros de OP (SigCdPam).", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Parametros de componentes (SigCdPac)
            loc_cSQL = "SELECT * FROM SigCdPac"
            IF USED("crSigCdPac")
                USE IN crSigCdPac
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdPac") < 1
                MsgErro("Falha ao carregar par" + CHR(226) + "metros de componentes (SigCdPac).", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Operacoes disponiveis (SigCdOpe + SigOpCdd + SigOpCdc -> TmpOper)
            loc_cSQL = "SELECT b.OpeGops, b.CodTgOps, a.Dopes, a.NDopes, a.Globalizas, " + ;
                       "a.Reservas, a.Opers, 0 AS Acesso, b.chkObs, c.carcompos " + ;
                       "FROM SigCdOpe a " + ;
                       "LEFT JOIN SigOpCdd b ON b.dopes = a.dopes " + ;
                       "LEFT JOIN SigOpCdc c ON a.dopes = c.dopes " + ;
                       "WHERE a.Globalizas IN (1, 2)"
            IF USED("TmpOper2")
                USE IN TmpOper2
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpOper2") < 1
                MsgErro("Falha ao carregar opera" + CHR(231) + CHR(245) + "es (SigCdOpe).", "Erro")
                loc_lSucesso = .F.
            ENDIF
            *-- Normalizar NULLs nos campos opcionais
            SELECT TmpOper2
            SCAN
                REPLACE CodTgOps WITH NVL(CodTgOps, " "), ;
                        OpeGops  WITH NVL(OpeGops, " ") IN TmpOper2
            ENDSCAN
            *-- Mover para TmpOper com indice
            IF USED("TmpOper")
                USE IN TmpOper
            ENDIF
            SELECT * FROM TmpOper2 INTO CURSOR TmpOper READWRITE
            USE IN TmpOper2
            SELECT TmpOper
            INDEX ON Dopes TAG Dopes
            GO TOP
            IF EOF()
                MsgAviso("Nenhuma Opera" + CHR(231) + CHR(227) + "o Configurada Para Processar " + ;
                         "Ordem de Produ" + CHR(231) + CHR(227) + "o!!!", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            *-- Tipos de OP com filtro de acesso (SigInTgo -> CrTmpTpGop)
            loc_cSQL = "SELECT 0 AS Acesso, * FROM SigInTgo"
            IF USED("TmpTpGop")
                USE IN TmpTpGop
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpTpGop") < 1
                MsgErro("Falha ao carregar tipos de OP (SigInTgo).", "Erro")
                loc_lSucesso = .F.
            ENDIF
            SELECT TmpTpGop
            SCAN
                IF fChecaAcesso("SIGPRGLOT", ALLTRIM(TmpTpGop.Codigos))
                    REPLACE Acesso WITH 1 IN TmpTpGop
                ENDIF
            ENDSCAN
            IF USED("CrTmpTpGop")
                USE IN CrTmpTpGop
            ENDIF
            SELECT * FROM TmpTpGop WHERE Acesso = 1 INTO CURSOR CrTmpTpGop READWRITE
            USE IN TmpTpGop
            SELECT CrTmpTpGop
            INDEX ON Codigos TAG Codigos
            GO TOP

            *-- Auto-selecionar tipo se GerPorTp e so ha um disponivel
            IF par_lGerPorTp AND RECCOUNT("CrTmpTpGop") = 1
                THIS.this_cTpGOp = ALLTRIM(CrTmpTpGop.Codigos)
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar par" + CHR(226) + "metros: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarEmpresa - carrega dados da empresa pelo codigo
    * Popula this_cCdEmpresa e this_cDsEmpresa
    *--------------------------------------------------------------------------
    PROCEDURE CarregarEmpresa(par_cCodEmp)
        LOCAL loc_cSQL, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(ALLTRIM(par_cCodEmp))
            IF USED("TempEmp")
                USE IN TempEmp
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "TempEmp") >= 1
                SELECT TempEmp
                IF NOT EOF()
                    THIS.this_cCdEmpresa = ALLTRIM(TempEmp.Cemps)
                    THIS.this_cDsEmpresa = ALLTRIM(TempEmp.Razas)
                    loc_lSucesso = .T.
                ENDIF
                USE IN TempEmp
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar empresa: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarNumeroOP - verifica se numero de OP ja existe em SigOpPic
    * Retorna .T. se DISPONIVEL (nao existe), .F. se JA EXISTE ou erro
    *--------------------------------------------------------------------------
    PROCEDURE ValidarNumeroOP(par_nNop)
        LOCAL loc_cSQL, loc_lDisponivel, loc_oErro
        loc_lDisponivel = .T.

        TRY
            loc_cSQL = "SELECT Numps FROM SigOpPic WHERE Numps = " + TRANSFORM(par_nNop)
            IF USED("TmpOpi")
                USE IN TmpOpi
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpOpi") >= 1
                IF RECCOUNT("TmpOpi") > 0
                    loc_lDisponivel = .F.
                ENDIF
                USE IN TmpOpi
            ELSE
                loc_lDisponivel = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar n" + CHR(250) + "mero de OP: " + loc_oErro.Message, "Erro")
            loc_lDisponivel = .F.
        ENDTRY

        RETURN loc_lDisponivel
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararCursoresProcessamento - cria cursores temporarios para Processar
    * TmpCabec, TmpItens, DBParam, SelPedra, Produtos
    *--------------------------------------------------------------------------
    PROCEDURE PrepararCursoresProcessamento()
        LOCAL loc_oErro
        TRY
            IF USED("DBParam")
                USE IN DBParam
            ENDIF
            IF USED("TmpCabec")
                USE IN TmpCabec
            ENDIF
            IF USED("TmpItens")
                USE IN TmpItens
            ENDIF
            IF USED("SelPedra")
                USE IN SelPedra
            ENDIF
            IF USED("Produtos")
                USE IN Produtos
            ENDIF

            SET NULL ON
            CREATE CURSOR DBParam (CodTgOps C(10) NULL, OpZers N(1,0) NULL, EntPes N(1,0) NULL)
            SET NULL OFF

            SET NULL ON
            CREATE CURSOR TmpCabec (Flag L, Emps C(3), Dopes C(20), Numes N(6,0), ;
                                     Grupo C(10), Conta C(10), Datas D NULL, ;
                                     Entregas D NULL, Grupov C(10), Contav C(10), ;
                                     Obs M NULL, Peso N(12,2), ;
                                     GrupoDs C(10), ContaDs C(10), DConta C(40), ;
                                     Notas C(6), Jobs C(10))
            SET NULL OFF
            INDEX ON DTOS(Entregas) + Emps + Dopes + STR(Numes,6) TAG Entrega
            INDEX ON Emps + Dopes + STR(Numes,6) TAG Empdopnum
            SET ORDER TO TAG Empdopnum

            SET NULL ON
            CREATE CURSOR SelPedra (Cpros C(14), Dpros C(40), Cunis C(3), ;
                                     Qtds N(12,3), Cpro2s C(14))
            SET NULL OFF

            CREATE CURSOR Produtos (Cpros C(14), Dpros C(40), cmats C(14))
            INDEX ON Cpros TAG Cpros

            SET NULL ON
            CREATE CURSOR TmpItens (Emps C(3), Dopes C(20), Numes N(6,0), ;
                                     CPros C(14), Qtds N(12,3), Saldo N(12,3), ;
                                     Peso N(9,3), Obs M NULL, Linhas C(10), ;
                                     CodCors C(4), CodTams C(4), Citens N(10,0), ;
                                     Notas C(6), dpros C(40), Reffs C(40))
            SET NULL OFF
            INDEX ON Linhas + Cpros TAG LinPro
            INDEX ON Cpros TAG Cpros
            INDEX ON Emps + Dopes + STR(Numes,6) TAG Empdopnum
            SET ORDER TO TAG Empdopnum

        CATCH TO loc_oErro
            MsgErro("Erro ao preparar cursores de processamento: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarOrdens - logica principal de processamento de OP
    * Usa this_* properties definidas pela form para os filtros.
    * Popula TmpCabec e TmpItens para uso pelo form SigPrGl2.
    * Retorna .T. se ha registros a processar, .F. caso contrario.
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarOrdens()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_Conde, loc_Condp, loc_cSQL
        LOCAL loc_cDateiSQL, loc_cDatefSQL, loc_cDatepiSQL, loc_cDatepfSQL
        LOCAL loc_Dopp, loc_lcTpGOp, loc_lcEmp
        LOCAL loc_Grupo, loc_Conta, loc_GrupoV, loc_ContaV
        LOCAL loc_GrupoG, loc_ContaG, loc_GrupoD, loc_ContaD
        LOCAL loc_Operacao, loc_Operacaoi, loc_Operacaof
        LOCAL loc_TPeso, loc_Processa, loc_Saldo, loc_Peso
        LOCAL loc_lcEdn, loc_lcCpo, loc_oProg, loc_xBaixa, loc_lnQtdTb
        LOCAL loc_pItn, loc_cDConta

        loc_lSucesso = .F.

        TRY
            THIS.PrepararCursoresProcessamento()

            *-- Coletar filtros das propriedades do BO
            SELECT crSigCdPam
            loc_Dopp       = crSigCdPam.DoppPads
            loc_lcTpGOp    = THIS.this_cTpGOp
            loc_lcEmp      = IIF(EMPTY(THIS.this_cCdEmpresa), go_4c_Sistema.cCodEmpresa, THIS.this_cCdEmpresa)
            loc_Grupo      = THIS.this_cGrupoConta
            loc_Conta      = THIS.this_cConta
            loc_GrupoV     = THIS.this_cGrupoResp
            loc_ContaV     = THIS.this_cContaResp
            loc_Operacao   = THIS.this_cOperacao
            loc_Operacaoi  = THIS.this_nOperacaoi
            loc_Operacaof  = THIS.this_nOperacaof

            *-- Carregar operacao padrao (SigCdOpd)
            loc_cSQL = "SELECT * FROM SigCdOpd WHERE Dopps = " + EscaparSQL(ALLTRIM(loc_Dopp))
            IF USED("crSigCdOpd")
                USE IN crSigCdOpd
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdOpd") < 1
                MsgErro("Falha ao carregar opera" + CHR(231) + CHR(227) + "o padr" + CHR(227) + "o (SigCdOpd).", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Formatar datas para SQL
            loc_cDateiSQL  = IIF(EMPTY(THIS.this_dDataei), "NULL", FormatarDataSQL(THIS.this_dDataei))
            loc_cDatefSQL  = IIF(EMPTY(THIS.this_dDataef), "NULL", THIS.FormatarDataHoraSQL(THIS.this_dDataef, "23:59:59"))
            loc_cDatepiSQL = IIF(EMPTY(THIS.this_dDatapi), "NULL", FormatarDataSQL(THIS.this_dDatapi))
            loc_cDatepfSQL = IIF(EMPTY(THIS.this_dDatapf), "NULL", THIS.FormatarDataHoraSQL(THIS.this_dDatapf, "23:59:59"))

            *-- Condicao de periodo de emissao
            IF EMPTY(THIS.this_dDataef)
                loc_Conde = ""
            ELSE
                IF EMPTY(THIS.this_dDataei)
                loc_Conde = "Datas <= " + loc_cDatefSQL + " AND "
            ELSE
                loc_Conde = "Datas BETWEEN " + loc_cDateiSQL + " AND " + loc_cDatefSQL + " AND "
                ENDIF
            ENDIF

            *-- Condicao de periodo de previsao de entrega
            IF EMPTY(THIS.this_dDatapi)
                IF EMPTY(THIS.this_dDatapf)
                    loc_Condp = ""
                ELSE
                    loc_Condp = "PrazoEnts <= " + loc_cDatepfSQL + " AND "
                ENDIF
            ELSE
                IF EMPTY(THIS.this_dDatapf)
                    loc_Condp = "PrazoEnts >= " + loc_cDatepiSQL + " AND "
                ELSE
                    loc_Condp = "PrazoEnts BETWEEN " + loc_cDatepiSQL + " AND " + loc_cDatepfSQL + " AND "
                ENDIF
            ENDIF

            *-- Inserir parametros de geracao em DBParam
            IF SEEK(ALLTRIM(loc_lcTpGOp), "CrTmpTpGop", "Codigos")
                INSERT INTO DBParam (CodTgOps, OpZers, EntPes) ;
                    VALUES (loc_lcTpGOp, ;
                            IIF(THIS.this_lGerPorTp, CrTmpTpGop.OpZers, crSigCdPac.OpZers), ;
                            IIF(THIS.this_lGerPorTp, CrTmpTpGop.EntPes, 0))
            ELSE
                INSERT INTO DBParam (CodTgOps, OpZers, EntPes) ;
                    VALUES (loc_lcTpGOp, crSigCdPac.OpZers, 0)
            ENDIF

            *-- Verificar operacoes dispon?veis
            SELECT TmpOper
            GO TOP
            IF EOF()
                MsgAviso("Nenhuma Opera" + CHR(231) + CHR(227) + "o Configurada Para Processar " + ;
                         "Ordem de Produ" + CHR(231) + CHR(227) + "o!!!", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            *-- Aplicar filtro de operacao especifica
            SET ORDER TO TAG Dopes IN TmpOper
            IF NOT EMPTY(loc_Operacao)
                SET KEY TO loc_Operacao IN TmpOper
            ENDIF

            *-- Iterar operacoes
            SELECT TmpOper
            SCAN
                IF THIS.this_lGerPorTp AND ALLTRIM(TmpOper.CodTgOps) <> ALLTRIM(loc_lcTpGOp)
                    LOOP
                ENDIF

                *-- Montar SQL para buscar movimentos desta operacao
                loc_cSQL = "SELECT Emps, Dopes, Numes, Datas, PrazoEnts, GrupoOs, " + ;
                           "ContaOs, GrupoDs, ContaDs, GrVends, Vends, Obses, rNops, Notas, Jobs " + ;
                           "FROM SigMvCab " + ;
                           "WHERE " + loc_Conde + loc_Condp + ;
                           "Emps = " + EscaparSQL(ALLTRIM(loc_lcEmp)) + " AND " + ;
                           "Dopes = " + EscaparSQL(ALLTRIM(TmpOper.Dopes)) + " AND "

                *-- Filtros de conta (cliente/destino conforme Globalizas)
                IF NOT EMPTY(loc_Grupo)
                    IF TmpOper.Globalizas = 1
                        loc_cSQL = loc_cSQL + "GrupoOs = " + EscaparSQL(ALLTRIM(loc_Grupo)) + " AND "
                    ENDIF
                    IF TmpOper.Globalizas = 2
                        loc_cSQL = loc_cSQL + "GrupoDs = " + EscaparSQL(ALLTRIM(loc_Grupo)) + " AND "
                    ENDIF
                ENDIF
                IF NOT EMPTY(loc_Conta)
                    IF TmpOper.Globalizas = 1
                        loc_cSQL = loc_cSQL + "ContaOs = " + EscaparSQL(ALLTRIM(loc_Conta)) + " AND "
                    ENDIF
                    IF TmpOper.Globalizas = 2
                        loc_cSQL = loc_cSQL + "ContaDs = " + EscaparSQL(ALLTRIM(loc_Conta)) + " AND "
                    ENDIF
                ENDIF
                *-- Filtros de vendedor (Responsavel)
                IF NOT EMPTY(loc_GrupoV)
                    loc_cSQL = loc_cSQL + "GrVends = " + EscaparSQL(ALLTRIM(loc_GrupoV)) + " AND "
                ENDIF
                IF NOT EMPTY(loc_ContaV)
                    loc_cSQL = loc_cSQL + "Vends = " + EscaparSQL(ALLTRIM(loc_ContaV)) + " AND "
                ENDIF
                *-- Apenas movimentos sem OP gerada
                loc_cSQL = loc_cSQL + "Nops = 0"

                IF USED("TempEest")
                    USE IN TempEest
                ENDIF
                IF SQLEXEC(gnConnHandle, loc_cSQL, "TempEest") < 1
                    MsgErro("Falha na conex" + CHR(227) + "o ao buscar movimentos (TempEest).", "Erro")
                    loc_lSucesso = .F.
                ENDIF

                *-- Barra de progresso por operacao
                SELECT TempEest
                loc_oProg = CREATEOBJECT("fwprogressbar", ;
                    "Processando Opera" + CHR(231) + CHR(227) + "o " + ALLTRIM(TmpOper.Dopes) + "...", ;
                    RECCOUNT())
                loc_oProg.Show()

                SCAN
                    loc_oProg.Update(.T.)

                    *-- Filtrar por faixa de numero de OP se especificada
                    IF NOT EMPTY(loc_Operacao)
                        IF loc_Operacaoi != 0 AND loc_Operacaof != 0 AND ;
                           NOT BETWEEN(TempEest.Numes, loc_Operacaoi, loc_Operacaof)
                            LOOP
                        ENDIF
                    ENDIF

                    *-- Grupo/Conta conforme tipo de globalizacao
                    IF TmpOper.Globalizas = 1
                        loc_GrupoG = ALLTRIM(TempEest.GrupoOs)
                        loc_ContaG = ALLTRIM(TempEest.ContaOs)
                    ELSE
                        loc_GrupoG = ALLTRIM(TempEest.GrupoDs)
                        loc_ContaG = ALLTRIM(TempEest.ContaDs)
                    ENDIF

                    *-- Pular movimentos com reserva automatica ja processada
                    IF THIS.this_lReserva AND TempEest.rNops > 0
                        LOOP
                    ENDIF

                    loc_TPeso    = 0
                    loc_Processa = .F.

                    *-- Buscar itens do movimento (SigMvItn)
                    loc_lcEdn = TempEest.Emps + TempEest.Dopes + STR(TempEest.Numes, 6)
                    loc_lcCpo = "CPros, CItens, Qtds, QtBaixas, QtProds, Pesos, " + ;
                                "Emps, Dopes, Numes, Obs, Notas, Dpros, Opers, Citem2"
                    loc_cSQL = "SELECT " + loc_lcCpo + " FROM SigMvItn " + ;
                               "WHERE EmpDopNums = " + EscaparSQL(loc_lcEdn)
                    IF USED("TempEestI")
                        USE IN TempEestI
                    ENDIF
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "TempEestI") < 1
                        MsgErro("Falha ao buscar itens do movimento (TempEestI).", "Erro")
                        loc_lSucesso = .F.
                    ENDIF

                    SELECT TempEestI
                    SCAN
                        *-- Filtrar por operacao interna se OPers = 3
                        IF TmpOper.OPers = 3 AND NOT EMPTY(TmpOper.OpeGops) AND ;
                           ALLTRIM(TempEestI.Opers) <> ALLTRIM(TmpOper.OpeGops)
                            LOOP
                        ENDIF
                        *-- Pular componentes de sub-montagem se carcompos = 5
                        IF TmpOper.carcompos = 5 AND TempEestI.Citem2 <> 0
                            LOOP
                        ENDIF

                        *-- Carregar dados do produto
                        loc_cSQL = "SELECT Pesoms, Linhas, QtdCpnts, DPros, Reffs, Cgrus " + ;
                                   "FROM SigCdPro WHERE CPros = " + EscaparSQL(ALLTRIM(TempEestI.CPros))
                        IF USED("crSigCdPro")
                            USE IN crSigCdPro
                        ENDIF
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdPro") < 1
                            MsgErro("Falha ao carregar produto (SigCdPro).", "Erro")
                            loc_lSucesso = .F.
                        ENDIF

                        *-- Carregar grupo do produto
                        loc_cSQL = "SELECT GeraTubs FROM SigCdGrp " + ;
                                   "WHERE CGrus = " + EscaparSQL(ALLTRIM(crSigCdPro.CGrus))
                        IF USED("crSigCdGrp")
                            USE IN crSigCdGrp
                        ENDIF
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdGrp") < 1
                            MsgErro("Falha ao carregar grupo do produto (SigCdGrp).", "Erro")
                            loc_lSucesso = .F.
                        ENDIF

                        loc_pItn   = TempEestI.CItens
                        loc_lnQtdTb = 0

                        *-- Buscar sub-itens (SigMvIts)
                        loc_cSQL = "SELECT * FROM SigMvIts " + ;
                                   "WHERE EmpDopNums = " + EscaparSQL(loc_lcEdn) + ;
                                   " AND CItens = " + FormatarNumeroSQL(loc_pItn)
                        IF USED("TempEsti2")
                            USE IN TempEsti2
                        ENDIF
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "TempEsti2") < 1
                            MsgErro("Falha ao buscar sub-itens (TempEsti2).", "Erro")
                            loc_lSucesso = .F.
                        ENDIF

                        SELECT TempEsti2
                        GO TOP
                        IF EOF("TempEsti2")
                            *-- Sem sub-itens: processar item principal
                            SELECT TempEestI
                            loc_xBaixa = IIF(QtBaixas > 0 AND QtBaixas >= QtProds, ;
                                             QtBaixas - QtProds, 0) + QtProds
                            loc_Saldo  = TempEestI.Qtds - loc_xBaixa
                            loc_Peso   = IIF(EMPTY(TempEestI.Pesos), crSigCdPro.Pesoms, TempEestI.Pesos)
                            IF loc_Saldo <> 0
                                INSERT INTO TmpItens ;
                                    (Emps, Dopes, Numes, CPros, Qtds, Saldo, Obs, Peso, ;
                                     Linhas, Citens, Notas, Dpros, Reffs) ;
                                    VALUES (TempEestI.Emps, TempEestI.Dopes, TempEestI.Numes, ;
                                            TempEestI.CPros, TempEestI.Qtds, loc_Saldo, ;
                                            TempEestI.Obs, loc_Peso, crSigCdPro.Linhas, ;
                                            TempEestI.Citens, TempEestI.Notas, TempEestI.Dpros, ;
                                            crSigCdPro.Reffs)
                                loc_TPeso    = loc_TPeso + (loc_Peso * loc_Saldo)
                                loc_Processa = .T.
                                *-- Verificar qtd de tubos por grupo
                                IF crSigCdGrp.GeraTubs <> 2
                                    loc_lnQtdTb = crSigCdPro.QtdCpnts
                                ELSE
                                    loc_cSQL = "SELECT SUM(qtds) AS total FROM SigPrMtz " + ;
                                               "WHERE Cpros = " + EscaparSQL(ALLTRIM(TempEestI.CPros))
                                    IF USED("crSigPrMtz")
                                        USE IN crSigPrMtz
                                    ENDIF
                                    IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigPrMtz") >= 1
                                        SELECT crSigPrMtz
                                        loc_lnQtdTb = NVL(crSigPrMtz.total, 0)
                                    ENDIF
                                ENDIF
                                IF loc_lnQtdTb = 0
                                    SELECT Produtos
                                    IF NOT SEEK(ALLTRIM(TempEestI.Cpros), "Produtos", "CPros")
                                        INSERT INTO Produtos (Cpros, DPros) ;
                                            VALUES (TempEestI.Cpros, crSigCdPro.Dpros)
                                    ENDIF
                                ENDIF
                            ENDIF
                        ELSE
                            *-- Com sub-itens: processar cada sub-item
                            SELECT TempEsti2
                            SCAN
                                loc_xBaixa = IIF(QtBaixas > 0 AND QtBaixas >= QtProds, ;
                                                 QtBaixas - QtProds, 0) + QtProds
                                loc_Saldo  = TempEsti2.Qtds - loc_xBaixa
                                loc_Peso   = IIF(EMPTY(TempEsti2.Pesos), crSigCdPro.Pesoms, TempEsti2.Pesos)
                                IF loc_Saldo <> 0
                                    INSERT INTO TmpItens ;
                                        (Emps, Dopes, Numes, CPros, Qtds, Saldo, Obs, Peso, ;
                                         Linhas, CodCors, CodTams, Citens, Notas, Dpros, Reffs) ;
                                        VALUES (TempEsti2.Emps, TempEsti2.Dopes, TempEsti2.Numes, ;
                                                TempEsti2.CPros, TempEsti2.Qtds, loc_Saldo, ;
                                                TempEestI.Obs, loc_Peso, crSigCdPro.Linhas, ;
                                                TempEsti2.CodCors, TempEsti2.CodTams, ;
                                                TempEestI.Citens, TempEestI.Notas, TempEestI.Dpros, ;
                                                crSigCdPro.Reffs)
                                    loc_TPeso    = loc_TPeso + (loc_Peso * loc_Saldo)
                                    loc_Processa = .T.
                                    *-- Verificar qtd de tubos por grupo
                                    IF crSigCdGrp.GeraTubs <> 2
                                        loc_lnQtdTb = crSigCdPro.QtdCpnts
                                    ELSE
                                        loc_cSQL = "SELECT SUM(qtds) AS total FROM SigPrMtz " + ;
                                                   "WHERE Cpros = " + EscaparSQL(ALLTRIM(TempEestI.CPros))
                                        IF USED("crSigPrMtz")
                                            USE IN crSigPrMtz
                                        ENDIF
                                        IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigPrMtz") >= 1
                                            SELECT crSigPrMtz
                                            loc_lnQtdTb = NVL(crSigPrMtz.total, 0)
                                        ENDIF
                                    ENDIF
                                    IF loc_lnQtdTb = 0
                                        SELECT Produtos
                                        IF NOT SEEK(ALLTRIM(TempEestI.Cpros), "Produtos", "CPros")
                                            INSERT INTO Produtos (Cpros, DPros) ;
                                                VALUES (TempEestI.Cpros, crSigCdPro.Dpros)
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDSCAN
                        ENDIF
                    ENDSCAN

                    *-- Inserir cabecalho se ha itens para processar neste movimento
                    IF loc_Processa
                        *-- Destino: preferencia pelo SigCdOpd, fallback para o movimento
                        loc_GrupoD = IIF(EMPTY(crSigCdOpd.GruDests), ;
                                         ALLTRIM(TempEest.GrupoDs), ALLTRIM(crSigCdOpd.GruDests))
                        loc_ContaD = IIF(EMPTY(crSigCdOpd.ConDests), ;
                                         ALLTRIM(TempEest.ContaDs), ALLTRIM(crSigCdOpd.ConDests))

                        *-- Buscar razao social do cliente
                        loc_cSQL = "SELECT TOP 1 RClis FROM SigCdCli " + ;
                                   "WHERE IClis = " + EscaparSQL(loc_ContaG)
                        IF USED("LocalCli")
                            USE IN LocalCli
                        ENDIF
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "LocalCli") < 1
                            MsgErro("Falha ao buscar cliente (SigCdCli).", "Erro")
                            loc_lSucesso = .F.
                        ENDIF
                        SELECT LocalCli
                        loc_cDConta = IIF(EOF(), "", ALLTRIM(LocalCli.RClis))
                        USE IN LocalCli

                        INSERT INTO TmpCabec ;
                            (Flag, Emps, Dopes, Numes, Grupo, Conta, Grupov, Contav, ;
                             Datas, Entregas, Peso, Obs, GrupoDs, ContaDs, DConta, ;
                             Notas, Jobs) ;
                            VALUES (.T., TempEest.Emps, TempEest.Dopes, TempEest.Numes, ;
                                    loc_GrupoG, loc_ContaG, ;
                                    ALLTRIM(TempEest.GrVends), ALLTRIM(TempEest.Vends), ;
                                    TempEest.Datas, TempEest.PrazoEnts, ;
                                    loc_TPeso, TempEest.Obses, ;
                                    loc_GrupoD, loc_ContaD, loc_cDConta, ;
                                    ALLTRIM(TempEest.Notas), ALLTRIM(TempEest.Jobs))
                    ENDIF
                ENDSCAN

                loc_oProg.Complete()

                IF USED("TempEest")
                    USE IN TempEest
                ENDIF
            ENDSCAN

            *-- Limpar filtro de operacao
            IF NOT EMPTY(loc_Operacao)
                SET KEY TO IN TmpOper
            ENDIF

            *-- Posicionar cursores no inicio
            GO TOP IN TmpCabec
            GO TOP IN TmpItens

            *-- Verificar se ha registros para processar
            loc_lSucesso = NOT EOF("TmpItens") AND NOT EOF("TmpCabec")
            IF NOT loc_lSucesso
                MsgAviso("Nenhum Item Selecionado Para Processar!!!", "Aviso")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao processar ordens: " + loc_oErro.Message + ;
                    " Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - retorna chave identificadora do contexto de processamento
    * Formato: Emp + TpGOp + Numps (evita colisao entre empresas/tipos)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ALLTRIM(THIS.this_cCdEmpresa) + "|" + ;
                     ALLTRIM(THIS.this_cTpGOp) + "|" + ;
                     TRANSFORM(THIS.this_nNop)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - grava uma OP gerada em SigOpPic (Ordens de Producao)
    * Chamada apos usuario confirmar selecao em SigPrGl2.
    * par_nNumps: numero da OP a gravar
    * par_cDope: operacao (Dopes) do item
    * par_cCpro: codigo do produto
    * par_nQtds: quantidade da OP
    * par_nNumes: numero do movimento origem (SigMvCab.Numes)
    * par_cCodTgOp: tipo de geracao (opcional; usa this_cTpGOp se vazio)
    * Retorna .T. em caso de sucesso
    *--------------------------------------------------------------------------
    PROCEDURE Inserir(par_nNumps, par_cDope, par_cCpro, par_nQtds, par_nNumes, par_cCodTgOp)
        LOCAL loc_lSucesso, loc_cSQL, loc_cEmp, loc_cDopp
        LOCAL loc_cCodTgOp, loc_cIdChave, loc_dGeracao, loc_dPrev
        LOCAL loc_cEmpDopNums, loc_cEmpDopNops, loc_cEmpDnps
        LOCAL loc_cUsuario, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Validar parametros obrigatorios
            IF EMPTY(par_nNumps) OR par_nNumps <= 0
                MsgErro("N" + CHR(250) + "mero da OP inv" + CHR(225) + "lido para inser" + CHR(231) + CHR(227) + "o.", "Erro")
                loc_lSucesso = .F.
            ENDIF
            IF EMPTY(ALLTRIM(par_cDope))
                MsgErro("Opera" + CHR(231) + CHR(227) + "o (Dopes) obrigat" + CHR(243) + "ria para inser" + CHR(231) + CHR(227) + "o.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Verificar duplicidade antes de inserir
            IF NOT THIS.ValidarNumeroOP(par_nNumps)
                MsgAviso("N" + CHR(250) + "mero de OP " + TRANSFORM(par_nNumps) + " j" + CHR(225) + " existe em SigOpPic.", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            *-- Preparar valores
            loc_cEmp      = ALLTRIM(THIS.this_cCdEmpresa)
            IF EMPTY(loc_cEmp)
                loc_cEmp = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            ENDIF
            loc_dGeracao  = IIF(EMPTY(THIS.this_dGeracao), DATE(), THIS.this_dGeracao)
            loc_dPrev     = IIF(EMPTY(THIS.this_dPrevisao), loc_dGeracao, THIS.this_dPrevisao)
            loc_cCodTgOp  = IIF(EMPTY(ALLTRIM(par_cCodTgOp)), ALLTRIM(THIS.this_cTpGOp), ALLTRIM(par_cCodTgOp))
            loc_cUsuario  = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")

            *-- Recuperar Dopp da operacao padrao (usa CarregarParametros previamente)
            loc_cDopp = ""
            IF USED("crSigCdPam")
                SELECT crSigCdPam
                loc_cDopp = ALLTRIM(crSigCdPam.DoppPads)
            ENDIF

            *-- Composicao das chaves compostas (padrao do sistema)
            loc_cEmpDopNums = loc_cEmp + ALLTRIM(par_cDope) + PADL(TRANSFORM(par_nNumes), 6, "0")
            loc_cEmpDopNops = loc_cEmp + ALLTRIM(par_cDope) + PADL(TRANSFORM(par_nNumps), 10, "0")
            loc_cEmpDnps    = loc_cEmp + PADL(TRANSFORM(par_nNumps), 10, "0")
            loc_cIdChave    = loc_cEmp + PADL(TRANSFORM(par_nNumps), 10, "0")

            *-- Montar INSERT em SigOpPic (colunas NOT NULL preenchidas)
            loc_cSQL = "INSERT INTO SigOpPic " + ;
                       "(cIdChaves, Emps, Dopes, Dopps, Nops, Numes, Numps, " + ;
                       " dataes, dataps, dtgeras, Cpros, Empds, Locals, Ntrans, " + ;
                       " Seqdivs, CodCors, CodTams, Divs, Imprs, Usuars, Nopmaes, " + ;
                       " Pesos, CodBarras, QtdCpnts, QtdTubos, iImprs, Moedas, Units, " + ;
                       " Nfunds, Dpros, Empdnps, EmpDopNops, EmpDopNums, Notas, " + ;
                       " CodTgOps, Citens, Qtds) VALUES ("
            loc_cSQL = loc_cSQL + ;
                       EscaparSQL(loc_cIdChave) + ", " + ;
                       EscaparSQL(loc_cEmp) + ", " + ;
                       EscaparSQL(ALLTRIM(par_cDope)) + ", " + ;
                       EscaparSQL(loc_cDopp) + ", " + ;
                       FormatarNumeroSQL(par_nNumps) + ", " + ;
                       FormatarNumeroSQL(par_nNumes) + ", " + ;
                       FormatarNumeroSQL(par_nNumps) + ", " + ;
                       FormatarDataSQL(loc_dGeracao) + ", " + ;
                       FormatarDataSQL(loc_dPrev) + ", " + ;
                       FormatarDataSQL(loc_dGeracao) + ", " + ;
                       EscaparSQL(ALLTRIM(par_cCpro)) + ", " + ;
                       EscaparSQL(loc_cEmp) + ", " + ;
                       EscaparSQL("") + ", " + ;
                       "0, 0, "
            loc_cSQL = loc_cSQL + ;
                       EscaparSQL("") + ", " + ;
                       EscaparSQL("") + ", " + ;
                       "0, 0, " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       "0, 0, 0, 0, 0, 0, " + ;
                       EscaparSQL("") + ", " + ;
                       "0, 0, " + ;
                       EscaparSQL("") + ", " + ;
                       EscaparSQL(loc_cEmpDnps) + ", " + ;
                       EscaparSQL(loc_cEmpDopNops) + ", " + ;
                       EscaparSQL(loc_cEmpDopNums) + ", " + ;
                       EscaparSQL("") + ", " + ;
                       EscaparSQL(loc_cCodTgOp) + ", " + ;
                       "0, " + ;
                       FormatarNumeroSQL(par_nQtds) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                MsgErro("Falha ao gravar OP em SigOpPic (n" + CHR(250) + "mero " + TRANSFORM(par_nNumps) + ").", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Auditoria da insercao
            THIS.RegistrarAuditoria("INCLUIR")

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro("Erro ao inserir OP: " + loc_oErro.Message + ;
                    " Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - vincula movimento origem (SigMvCab) ao numero da OP gerada
    * Em modo Reserva: atualiza rNops (reserva). Modo normal: atualiza Nops.
    * par_cEmp: empresa do movimento
    * par_cDope: operacao do movimento
    * par_nNumes: numero do movimento
    * par_nNumps: numero da OP gerada
    * Retorna .T. em caso de sucesso
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar(par_cEmp, par_cDope, par_nNumes, par_nNumps)
        LOCAL loc_lSucesso, loc_cSQL, loc_cEmpDopNums, loc_cCampo
        LOCAL loc_dAlt, loc_cUsuario, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Validar parametros
            IF EMPTY(par_nNumps) OR par_nNumps <= 0
                MsgErro("N" + CHR(250) + "mero da OP inv" + CHR(225) + "lido para atualiza" + CHR(231) + CHR(227) + "o.", "Erro")
                loc_lSucesso = .F.
            ENDIF
            IF EMPTY(ALLTRIM(par_cEmp)) OR EMPTY(ALLTRIM(par_cDope)) OR par_nNumes <= 0
                MsgErro("Chave do movimento (Emp/Dope/Numes) obrigat" + CHR(243) + "ria.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Campo destino: rNops em reserva automatica, Nops caso contrario
            loc_cCampo = IIF(THIS.this_lReserva, "rNops", "Nops")

            *-- Chave composta EmpDopNums
            loc_cEmpDopNums = ALLTRIM(par_cEmp) + ALLTRIM(par_cDope) + PADL(TRANSFORM(par_nNumes), 6, "0")

            *-- Dados de auditoria embutidos no proprio UPDATE
            loc_dAlt     = DATE()
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")

            loc_cSQL = "UPDATE SigMvCab SET " + loc_cCampo + " = " + FormatarNumeroSQL(par_nNumps)
            IF NOT THIS.this_lReserva
                loc_cSQL = loc_cSQL + ", Dtalts = " + FormatarDataSQL(loc_dAlt) + ;
                           ", Usualts = " + EscaparSQL(loc_cUsuario)
            ENDIF
            loc_cSQL = loc_cSQL + " WHERE EmpDopNums = " + EscaparSQL(loc_cEmpDopNums)

            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                MsgErro("Falha ao atualizar movimento " + loc_cEmpDopNums + " com OP " + TRANSFORM(par_nNumps) + ".", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Auditoria da atualizacao
            THIS.RegistrarAuditoria("ALTERAR")

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar movimento: " + loc_oErro.Message + ;
                    " Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
