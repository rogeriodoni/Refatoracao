*==============================================================================
* SIGREATMBO.PRG
* Business Object para Relatorio Analise por Tipo de Material (SigReAtm)
* Herda de: RelatorioBase
*==============================================================================

DEFINE CLASS SigReAtmBO AS RelatorioBase

    *-- Filtros de periodo
    this_dDatai           = {}
    this_dDataf           = {}

    *-- Filtro tipo de OP
    this_cTpGOp           = ""

    *-- Filtro grupo de balanco (SigCdGcr)
    this_cGrupo           = ""
    this_cDGrupo          = ""

    *-- Filtro conta/cliente
    this_cConta           = ""
    this_cDConta          = ""

    *-- Filtro grande grupo de produto
    this_cGgrp            = ""
    this_cDGGrp           = ""

    *-- Filtro grupo de materia prima
    this_cCGru            = ""
    this_cDGru            = ""

    *-- Filtro subgrupo de materia prima
    this_cCSGru           = ""
    this_cDsGru           = ""

    *-- Filtro modelo (finalidade de produto)
    this_cCodFinP         = ""
    this_cDesFinP         = ""

    *-- Filtro acabamento
    this_cCodAcb          = ""
    this_cDAcb            = ""

    *-- Filtro classificacao
    this_cClass           = ""
    this_cDClass          = ""

    *-- Filtro dimensoes
    this_nTamPs           = 0
    this_nTamHs           = 0
    this_nTamLs           = 0

    *-- Filtro envelope e OP
    this_nEnvelope        = 0
    this_nNop             = 0

    *-- Filtro moeda de conversao
    this_cCdMoeda         = ""
    this_cDsMoeda         = ""

    *-- Agrupamento: 1=Analitico 2=Modelo 3=Classificacao 4=Conta
    this_nAgru            = 4

    *-- Opcoes logicas
    this_lDestino         = .F.
    this_lProdutos        = .F.

    *-- Nomes dos cursors para uso pelo Form
    this_cCursorTiposMat  = "cursor_4c_TiposMat"
    this_cCursorGrupos    = "cursor_4c_GruposBal"
    this_cCursorClientes  = "cursor_4c_Clientes"
    this_cCursorTpGOp     = "cursor_4c_TpGOp"

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_aCursors(8), loc_nI
        loc_aCursors(1) = "cursor_4c_GruposBal"
        loc_aCursors(2) = "cursor_4c_TiposMat"
        loc_aCursors(3) = "cursor_4c_Clientes"
        loc_aCursors(4) = "cursor_4c_Pam"
        loc_aCursors(5) = "cursor_4c_TpGOp"
        loc_aCursors(6) = "crSigCdCot"
        loc_aCursors(7) = "crSigCdMoe"
        loc_aCursors(8) = "cursor_4c_Operacoes"
        FOR loc_nI = 1 TO 8
            IF USED(loc_aCursors(loc_nI))
                USE IN (loc_aCursors(loc_nI))
            ENDIF
        ENDFOR
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarDados - Carrega cursors de referencia usados pelo Form e pelo
    * PrepararDados. Deve ser chamado no InicializarForm() do Form.
    *--------------------------------------------------------------------------
    PROCEDURE InicializarDados()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL, loc_cEmp, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_cEmp = ALLTRIM(go_4c_Sistema.cCodEmpresa)

            *-- 1. Grupos de balanco (SigCdGcr GerBals=1)
            IF USED("cursor_4c_GruposBal")
                USE IN cursor_4c_GruposBal
            ENDIF
            loc_cSQL = "SELECT Codigos, Descrs, Agrupas FROM SigCdGcr WHERE GerBals = 1"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruposBal")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar grupos de balan" + CHR(231) + CHR(227) + "o"
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_GruposBal
            INDEX ON Codigos TAG BalCodigo
            INDEX ON Descrs  TAG BalDescrs

            *-- 2. Tipos de material selecionaveis (SigOpOpt Situas<2)
            IF USED("cursor_4c_TiposMat")
                USE IN cursor_4c_TiposMat
            ENDIF
            loc_cSQL = "SELECT 0 AS Marca, Cods, Descs FROM SigOpOpt " + ;
                       "WHERE Situas < 2 AND " + ;
                       "(RTRIM(Emps) = '' OR Emps = " + EscaparSQL(loc_cEmp) + ")"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TiposMat")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar tipos de material"
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_TiposMat
            INDEX ON Cods  TAG Cods
            INDEX ON Descs TAG Descs
            GO TOP

            *-- 3. Clientes (SigCdCli GerBals=1)
            IF USED("cursor_4c_Clientes")
                USE IN cursor_4c_Clientes
            ENDIF
            loc_cSQL = "SELECT IClis, RClis, Inativas FROM SigCdCli WHERE GerBals = 1"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Clientes")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar clientes"
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_Clientes
            INDEX ON IClis TAG BalCodigo
            INDEX ON RClis TAG BalNome

            *-- 4. Parametros empresa (GrTrans para exclusao de transitorio)
            IF USED("cursor_4c_Pam")
                USE IN cursor_4c_Pam
            ENDIF
            loc_cSQL = "SELECT GrTrans FROM SigCdPam"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar par" + CHR(226) + "metros"
                loc_lSucesso = .F.
            ENDIF
            SELECT cursor_4c_Pam
            GO TOP

            *-- 5. Tipos de geracao de OP filtrados por acesso do usuario
            IF USED("TmpTpGop")
                USE IN TmpTpGop
            ENDIF
            IF USED("cursor_4c_TpGOp")
                USE IN cursor_4c_TpGOp
            ENDIF
            loc_cSQL = "SELECT 0 AS Acesso, Codigos, Descs FROM SigInTgo"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpTpGop")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar tipos de OP"
                loc_lSucesso = .F.
            ENDIF
            SELECT TmpTpGop
            SCAN
                IF fChecaAcesso("SIGPRGLOT", ALLTRIM(TmpTpGop.Codigos))
                    REPLACE Acesso WITH 1 IN TmpTpGop
                ENDIF
            ENDSCAN
            SELECT * FROM TmpTpGop WHERE Acesso = 1 INTO CURSOR cursor_4c_TpGOp READWRITE
            SELECT cursor_4c_TpGOp
            INDEX ON Codigos TAG Codigos
            GO TOP
            USE IN TmpTpGop

            *-- 6. Cotacoes de moeda (crSigCdCot - nome exato usado por fCarregarCambio)
            IF USED("crSigCdCot")
                USE IN crSigCdCot
            ENDIF
            loc_cSQL = "SELECT CMoes, Datas, Valos FROM SigCdCot"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdCot")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar cota" + CHR(231) + CHR(245) + "es"
                loc_lSucesso = .F.
            ENDIF
            SELECT crSigCdCot
            INDEX ON CMoes + DTOS(Datas) TAG CMoeData
            SET ORDER TO CMoeData DESCENDING

            *-- 7. Moedas (crSigCdMoe - nome exato usado por fCarregarCambio)
            IF USED("crSigCdMoe")
                USE IN crSigCdMoe
            ENDIF
            loc_cSQL = "SELECT CMoes, Cotas FROM SigCdMoe"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdMoe")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar moedas"
                loc_lSucesso = .F.
            ENDIF
            SELECT crSigCdMoe
            INDEX ON CMoes TAG CMoes

            *-- 8. Operacoes de producao (SigCdOpd)
            IF USED("cursor_4c_Operacoes")
                USE IN cursor_4c_Operacoes
            ENDIF
            loc_cSQL = "SELECT 0 AS Marca, DopPs, ndopps, CodTgOps FROM SigCdOpd"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacoes")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar opera" + CHR(231) + CHR(245) + "es"
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em InicializarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa processamento completo do relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL, loc_oErro
        LOCAL loc_cGrupo, loc_cConta, loc_cGruMat, loc_cGgrp, loc_cSgru
        LOCAL loc_dDatai, loc_dDataf, loc_lDestino, loc_nEnvelope, loc_nOp
        LOCAL loc_nOpI, loc_nOpF, loc_cTGOp, loc_cCodFin, loc_cClas
        LOCAL loc_nTamA, loc_nTamP, loc_nTamC, loc_nAgru, loc_cMoeda
        LOCAL loc_cTpOp, loc_nTotOp, loc_cCabTipo, loc_cCab, loc_cSub, loc_cEmp
        LOCAL loc_cTpOps, loc_cGrp, loc_cCta, loc_cPed, loc_nEnv, loc_ldData
        LOCAL loc_lcDimen, loc_lcPro, loc_lcDpr, loc_cGrTrans, loc_nValorCalc
        LOCAL loc_cDtI, loc_cDtF, loc_cChave, loc_cChaveTotal, loc_cRClis
        LOCAL loc_cDFinP, loc_cDClass, loc_cQueryPro, loc_cLabel1, loc_cLabel2, loc_cLabel3

        loc_lSucesso = .F.

        TRY
            *-- Copiar filtros das propriedades
            loc_cGrupo    = ALLTRIM(THIS.this_cGrupo)
            loc_cConta    = ALLTRIM(THIS.this_cConta)
            loc_cGruMat   = ALLTRIM(THIS.this_cCGru)
            loc_cGgrp     = ALLTRIM(THIS.this_cGgrp)
            loc_cSgru     = ALLTRIM(THIS.this_cCSGru)
            loc_dDatai    = THIS.this_dDatai
            loc_dDataf    = THIS.this_dDataf
            loc_lDestino  = THIS.this_lDestino
            loc_nEnvelope = THIS.this_nEnvelope
            loc_nOp       = THIS.this_nNop
            loc_nOpI      = (loc_nOp * 10000) + 1
            loc_nOpF      = (loc_nOp * 10000) + 9999
            loc_cTGOp     = ALLTRIM(THIS.this_cTpGOp)
            loc_cCodFin   = ALLTRIM(THIS.this_cCodFinP)
            loc_cClas     = ALLTRIM(THIS.this_cClass)
            loc_nTamA     = THIS.this_nTamHs
            loc_nTamP     = THIS.this_nTamPs
            loc_nTamC     = THIS.this_nTamLs
            loc_nAgru     = THIS.this_nAgru
            loc_cMoeda    = ALLTRIM(THIS.this_cCdMoeda)

            *-- Criar cursor TmpRelat com indexes
            IF USED("TmpRelat")
                USE IN TmpRelat
            ENDIF
            CREATE CURSOR TmpRelat (Fase c(10), IClis c(10), RClis c(50), ;
                CMats c(14), DPros c(40), CPros c(14), DDPros c(40), ;
                Qtde n(12,3), TpOps c(15), CUnis c(3), Operacaos c(31), ;
                Nenvs n(10), Datas D, Pesos n(12,3), Valor n(12,2), ;
                Fators n(12,3), Moecs c(3), Cgrus c(3), Sgrus c(3), ;
                Cclass c(3), CodFinP c(3), Dimens c(30), DFinP c(20), ;
                DClass c(40), QtdTrabs n(12,3))
            INDEX ON DTOS(Datas) + Operacaos + STR(Nenvs,10) + CMats TAG Operacao
            INDEX ON TpOps + CodFinP + STR(Qtde,12,3) TAG TpCodFin
            INDEX ON DTOS(Datas) + Fase + IClis + TpOps + CUnis + ;
                CMats + Operacaos + STR(Nenvs,10) + STR(Qtde,12,3) TAG FFuncMat

            *-- Datas formatadas
            loc_cDtI = FormatarDataSQL(loc_dDatai)
            loc_cDtF = FormatarDataSQL(loc_dDataf)

            *-- Montar filtro de tipos de material marcados no grid
            loc_cTpOp  = ""
            loc_nTotOp = 0
            IF USED("cursor_4c_TiposMat")
                SELECT cursor_4c_TiposMat
                GO TOP
                COUNT FOR Marca = 1 TO loc_nTotOp
                SCAN
                    IF cursor_4c_TiposMat.Marca = 1 OR loc_nTotOp = 0
                        IF EMPTY(loc_cTpOp)
                            loc_cTpOp = "'" + ALLTRIM(cursor_4c_TiposMat.Cods) + "'"
                        ELSE
                            loc_cTpOp = loc_cTpOp + ",'" + ALLTRIM(cursor_4c_TiposMat.Cods) + "'"
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF
            loc_cTpOp = "(" + IIF(EMPTY(loc_cTpOp), "''", loc_cTpOp) + ")"

            *-- QUERY 1: movimentos basicos (TmpNens)
            IF USED("TmpNens")
                USE IN TmpNens
            ENDIF
            loc_cSQL = "Select a.Datas,a.CIdChaves,a.Emps,a.DopPs,a.NumPs,a.GrupoOs,a.ContaOs," + ;
                       "b.CMats,b.Qtds,b.TpOps,b.Nenvs," + ;
                       "a.GrupoDs,a.ContaDs,b.Nops,b.Pesos,b.Fators,b.Servicos,b.Cats,b.Empdnps " + ;
                       "From SigCdNec a, SigCdNei b " + ;
                       "Where a.Datas Between " + loc_cDtI + " And " + loc_cDtF + ;
                       " And a.EmpDNPs = b.EmpDNPs"
            IF !EMPTY(loc_cTpOp) AND loc_cTpOp <> "()"
                loc_cSQL = loc_cSQL + " And b.TpOps in " + loc_cTpOp
            ENDIF
            IF !EMPTY(loc_cGrupo)
                IF loc_lDestino
                    loc_cSQL = loc_cSQL + " And a.GrupoDs = " + EscaparSQL(loc_cGrupo)
                ELSE
                    loc_cSQL = loc_cSQL + " And a.GrupoOs = " + EscaparSQL(loc_cGrupo)
                ENDIF
            ENDIF
            IF !EMPTY(loc_cConta)
                IF loc_lDestino
                    loc_cSQL = loc_cSQL + " And a.ContaDs = " + EscaparSQL(loc_cConta)
                ELSE
                    loc_cSQL = loc_cSQL + " And a.ContaOs = " + EscaparSQL(loc_cConta)
                ENDIF
            ENDIF
            IF loc_nEnvelope > 0
                loc_cSQL = loc_cSQL + " And b.Nenvs = " + FormatarNumeroSQL(loc_nEnvelope)
            ENDIF
            loc_cSQL = loc_cSQL + " Order By a.cIdChaves"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpNens")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar movimenta" + CHR(231) + CHR(245) + "es (TmpNens)"
                loc_lSucesso = .F.
            ENDIF

            *-- QUERY 2: componentes com dados de produto (TmpProd)
            IF USED("TmpProd")
                USE IN TmpProd
            ENDIF
            loc_cSQL = "Select a.Datas,a.CIdChaves,a.Emps,a.DopPs,a.NumPs,a.ContaOs," + ;
                       "b.CMats,b.Qtds,b.TpOps,b.Nenvs,a.GrupoDs,a.ContaDs," + ;
                       "b.Nops,b.Pesos,b.Fators,b.Servicos,b.Cats,b.Empdnps," + ;
                       "d.CodFinP,d.Cclass,d.Cunis,d.Pcuss," + ;
                       "case when e.agrupas = '' then a.GrupoOs else e.agrupas end as GrupoOs " + ;
                       "From SigCdNec a, SigCdNei b, SigOpOpt c, SigCdPro d, SigCdGcr e " + ;
                       "Where a.Datas Between " + loc_cDtI + " And " + loc_cDtF + ;
                       " And a.EmpDNPs = b.EmpDNPs And c.Cods = b.TpOps" + ;
                       " And b.Cmats = d.Cpros And b.servicos = 0 And a.Retrabs = 0 And a.GrupoOs = e.Codigos"
            IF !EMPTY(loc_cGrupo)
                IF loc_lDestino
                    loc_cSQL = loc_cSQL + " And a.GrupoDs = " + EscaparSQL(loc_cGrupo)
                ELSE
                    loc_cSQL = loc_cSQL + " And a.GrupoOs = " + EscaparSQL(loc_cGrupo)
                ENDIF
            ENDIF
            IF !EMPTY(loc_cConta)
                IF loc_lDestino
                    loc_cSQL = loc_cSQL + " And a.ContaDs = " + EscaparSQL(loc_cConta)
                ELSE
                    loc_cSQL = loc_cSQL + " And a.ContaOs = " + EscaparSQL(loc_cConta)
                ENDIF
            ENDIF
            IF loc_nEnvelope > 0
                loc_cSQL = loc_cSQL + " And b.Nenvs = " + FormatarNumeroSQL(loc_nEnvelope)
            ENDIF
            IF !EMPTY(loc_cGruMat)
                loc_cSQL = loc_cSQL + " And d.CGrus = " + EscaparSQL(loc_cGruMat)
            ENDIF
            IF !EMPTY(loc_cGgrp)
                loc_cSQL = loc_cSQL + " And d.Mercs = " + EscaparSQL(loc_cGgrp)
            ENDIF
            IF !EMPTY(loc_cCodFin)
                loc_cSQL = loc_cSQL + " And d.CodFinP = " + EscaparSQL(loc_cCodFin)
            ENDIF
            IF !EMPTY(loc_cClas)
                loc_cSQL = loc_cSQL + " And d.Cclass = " + EscaparSQL(loc_cClas)
            ENDIF
            loc_cSQL = loc_cSQL + " Order By a.cIdChaves"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpProd")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar componentes (TmpProd)"
                loc_lSucesso = .F.
            ENDIF

            *-- Filtrar movimentos por tipo de geracao de OP
            IF USED("CrSigCdNec")
                USE IN CrSigCdNec
            ENDIF
            SELECT TmpNens.* FROM TmpNens, cursor_4c_Operacoes ;
                WHERE TmpNens.DopPs = cursor_4c_Operacoes.DopPs ;
                AND IIF(!EMPTY(m.loc_cTGOp), ALLTRIM(cursor_4c_Operacoes.CodTgOps) = m.loc_cTGOp, .T.) ;
                INTO CURSOR CrSigCdNec READWRITE

            *-- Cursor de filtro por envelope
            IF USED("crEnvelope")
                USE IN crEnvelope
            ENDIF
            IF loc_nEnvelope > 0
                SELECT DISTINCT Empdnps FROM CrSigCdNec ;
                    WHERE Nenvs = loc_nEnvelope INTO CURSOR crEnvelope
            ENDIF

            *-- Indexar CrSigCdNec
            SELECT CrSigCdNec
            INDEX ON DTOS(Datas) + CIdChaves TAG Datas
            SET ORDER TO Datas
            GO TOP

            *-- Ler GrTrans uma vez (evitar acesso ao cursor dentro do SCAN)
            loc_cGrTrans = ""
            IF USED("cursor_4c_Pam")
                SELECT cursor_4c_Pam
                GO TOP
                IF !EOF()
                    loc_cGrTrans = ALLTRIM(cursor_4c_Pam.GrTrans)
                ENDIF
            ENDIF

            *-- Processar movimentos
            LOCAL loc_nTotal
            loc_nTotal = RECCOUNT("CrSigCdNec")

            IF loc_nTotal > 0
                WAIT WINDOW "Processando movimenta" + CHR(231) + CHR(245) + "es..." NOWAIT

                SELECT CrSigCdNec
                SCAN
                    *-- Filtro envelope
                    IF loc_nEnvelope > 0
                        IF USED("crEnvelope")
                            SELECT crEnvelope
                            GO TOP
                            LOCATE FOR Empdnps = CrSigCdNec.Empdnps
                            IF EOF("crEnvelope")
                                LOOP
                            ENDIF
                        ENDIF
                    ENDIF

                    *-- Filtro numero de OP
                    IF loc_nOp > 0
                        IF !BETWEEN(CrSigCdNec.Nops, loc_nOpI, loc_nOpF)
                            LOOP
                        ENDIF
                    ENDIF

                    *-- Buscar dados do produto/material para este componente
                    IF USED("CrSigCdPro")
                        USE IN CrSigCdPro
                    ENDIF
                    loc_cQueryPro = "Select a.CPros,a.DPros,a.CGrus,a.Sgrus,a.CUnis," + ;
                                    "b.Mercs,a.Pcuss,a.Moecs,a.Cclass,a.CodFinp," + ;
                                    "a.TamPs,a.TamHs,a.TamLs " + ;
                                    "From SigCdPro a, SigCdGrp b " + ;
                                    "Where a.CPros = " + EscaparSQL(ALLTRIM(CrSigCdNec.CMats)) + ;
                                    " And a.Cgrus = b.Cgrus"
                    IF SQLEXEC(gnConnHandle, loc_cQueryPro, "CrSigCdPro") < 1
                        THIS.this_cMensagemErro = "Erro ao buscar produto " + ALLTRIM(CrSigCdNec.CMats)
                        loc_lSucesso = .F.
                    ENDIF
                    SELECT CrSigCdPro
                    IF EOF()
                        LOOP
                    ENDIF

                    *-- Aplicar filtros de produto
                    IF !EMPTY(loc_cGruMat) AND ALLTRIM(CrSigCdPro.CGrus) <> loc_cGruMat
                        LOOP
                    ENDIF
                    IF !EMPTY(loc_cGgrp) AND ALLTRIM(CrSigCdPro.Mercs) <> loc_cGgrp
                        LOOP
                    ENDIF
                    IF !EMPTY(loc_cSgru) AND ALLTRIM(CrSigCdPro.Sgrus) <> loc_cSgru
                        LOOP
                    ENDIF
                    IF !EMPTY(loc_cCodFin) AND ALLTRIM(CrSigCdPro.CodFinp) <> loc_cCodFin
                        LOOP
                    ENDIF
                    IF !EMPTY(loc_cClas) AND ALLTRIM(CrSigCdPro.Cclass) <> loc_cClas
                        LOOP
                    ENDIF
                    IF loc_nTamP <> 0 AND CrSigCdPro.TamPs <> loc_nTamP
                        LOOP
                    ENDIF
                    IF loc_nTamA <> 0 AND CrSigCdPro.TamHs <> loc_nTamA
                        LOOP
                    ENDIF
                    IF loc_nTamC <> 0 AND CrSigCdPro.TamLs <> loc_nTamC
                        LOOP
                    ENDIF

                    loc_cTpOps = CrSigCdNec.TpOps

                    *-- Determinar grupo (origem ou destino)
                    IF loc_lDestino
                        loc_cGrp = CrSigCdNec.GrupoDs
                    ELSE
                        loc_cGrp = CrSigCdNec.GrupoOs
                    ENDIF

                    *-- Buscar agrupamento customizado do grupo
                    IF USED("cursor_4c_GruposBal") AND !EMPTY(ALLTRIM(loc_cGrp))
                        SELECT cursor_4c_GruposBal
                        SET ORDER TO TAG BalCodigo
                        IF SEEK(ALLTRIM(loc_cGrp)) AND !EMPTY(ALLTRIM(cursor_4c_GruposBal.Agrupas))
                            loc_cGrp = PADR(ALLTRIM(cursor_4c_GruposBal.Agrupas), 10)
                        ENDIF
                        SELECT CrSigCdNec
                    ENDIF

                    *-- Excluir grupo transitorio
                    IF ALLTRIM(loc_cGrp) = loc_cGrTrans
                        LOOP
                    ENDIF

                    *-- Determinar conta
                    IF loc_lDestino
                        loc_cCta = CrSigCdNec.ContaDs
                    ELSE
                        loc_cCta = CrSigCdNec.ContaOs
                    ENDIF

                    *-- Montar chave de agrupamento (loc_cPed/lnEnv/ldData por modo)
                    IF loc_nAgru = 1
                        loc_cPed   = PADR(ALLTRIM(CrSigCdNec.DopPs) + "-" + STR(CrSigCdNec.NumPs,10), 31)
                        loc_nEnv   = CrSigCdNec.Nenvs
                        loc_ldData = CrSigCdNec.Datas
                    ELSE
                        loc_cPed   = PADR(" ", 31)
                        loc_nEnv   = 0
                        loc_ldData = CTOD("31/12/9999")
                    ENDIF

                    *-- Buscar produto final da OP (opcional)
                    loc_lcPro = ""
                    loc_lcDpr = ""
                    IF !EMPTY(CrSigCdNec.Nops) AND THIS.this_lProdutos
                        IF USED("LocalPro")
                            USE IN LocalPro
                        ENDIF
                        loc_nResult = SQLEXEC(gnConnHandle, ;
                            "SELECT TOP 1 a.Cpros,b.DPros " + ;
                            "From SigOpPic a Inner join SigCdPro b on a.Cpros = b.Cpros " + ;
                            "Where Nops = " + FormatarNumeroSQL(CrSigCdNec.Nops), "LocalPro")
                        IF loc_nResult > 0
                            SELECT LocalPro
                            GO TOP
                            IF !EOF()
                                loc_lcDpr = ALLTRIM(LocalPro.DPros)
                                loc_lcPro = ALLTRIM(LocalPro.Cpros)
                            ENDIF
                        ENDIF
                    ENDIF

                    *-- Montar string de dimensoes do produto
                    loc_lcDimen = ""
                    IF USED("crSigCdGrp")
                        USE IN crSigCdGrp
                    ENDIF
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT TitulosPro FROM SigCdGrp WHERE CGrus = " + ;
                        EscaparSQL(ALLTRIM(CrSigCdPro.CGrus)), "crSigCdGrp")
                    IF loc_nResult > 0
                        SELECT crSigCdGrp
                        GO TOP
                        IF !EOF() AND !EMPTY(SUBSTR(crSigCdGrp.TitulosPro, 61, 60))
                            loc_cLabel1 = IIF(EMPTY(ALLTRIM(SUBSTR(crSigCdGrp.TitulosPro, 61, 20))), ;
                                             "p", ALLTRIM(SUBSTR(crSigCdGrp.TitulosPro, 61, 20)))
                            loc_cLabel2 = IIF(EMPTY(ALLTRIM(SUBSTR(crSigCdGrp.TitulosPro, 81, 20))), ;
                                             "a", ALLTRIM(SUBSTR(crSigCdGrp.TitulosPro, 81, 20)))
                            loc_cLabel3 = IIF(EMPTY(ALLTRIM(SUBSTR(crSigCdGrp.TitulosPro, 101, 20))), ;
                                             "c", ALLTRIM(SUBSTR(crSigCdGrp.TitulosPro, 101, 20)))
                            loc_lcDimen = STR(CrSigCdPro.TamPs, 2) + loc_cLabel1 + ;
                                          " x " + STR(CrSigCdPro.TamHs, 2) + loc_cLabel2 + ;
                                          " x " + STR(CrSigCdPro.TamLs, 2) + loc_cLabel3
                        ENDIF
                    ENDIF

                    *-- Buscar descricao de finalidade/modelo (SigCdFip)
                    IF USED("crSigCdFip")
                        USE IN crSigCdFip
                    ENDIF
                    SQLEXEC(gnConnHandle, ;
                        "SELECT Descs FROM SigCdFip WHERE Cods = " + ;
                        EscaparSQL(ALLTRIM(CrSigCdPro.CodFinp)), "crSigCdFip")
                    loc_cDFinP = ""
                    IF USED("crSigCdFip")
                        SELECT crSigCdFip
                        GO TOP
                        IF !EOF()
                            loc_cDFinP = ALLTRIM(crSigCdFip.Descs)
                        ENDIF
                    ENDIF

                    *-- Buscar descricao de classificacao (SigCdCls)
                    IF USED("crSigCdCls")
                        USE IN crSigCdCls
                    ENDIF
                    SQLEXEC(gnConnHandle, ;
                        "SELECT Descs FROM SigCdCls WHERE Cods = " + ;
                        EscaparSQL(ALLTRIM(CrSigCdPro.Cclass)), "crSigCdCls")
                    loc_cDClass = ""
                    IF USED("crSigCdCls")
                        SELECT crSigCdCls
                        GO TOP
                        IF !EOF()
                            loc_cDClass = ALLTRIM(crSigCdCls.Descs)
                        ENDIF
                    ENDIF

                    *-- Montar chave de busca no TmpRelat
                    loc_cChave = DTOS(loc_ldData) + ;
                                 PADR(ALLTRIM(loc_cGrp), 10) + ;
                                 PADR(ALLTRIM(loc_cCta), 10) + ;
                                 PADR(ALLTRIM(loc_cTpOps), 15) + ;
                                 PADR(ALLTRIM(CrSigCdPro.Cunis), 3) + ;
                                 PADR(ALLTRIM(CrSigCdNec.CMats), 14) + ;
                                 loc_cPed + ;
                                 STR(loc_nEnv, 10)

                    SELECT TmpRelat
                    SET ORDER TO TAG FFuncMat

                    IF !SEEK(loc_cChave)
                        *-- Buscar nome do cliente para o INSERT
                        IF USED("CrTmpCli")
                            USE IN CrTmpCli
                        ENDIF
                        SQLEXEC(gnConnHandle, ;
                            "SELECT RClis FROM SigCdCli WHERE IClis = " + ;
                            EscaparSQL(ALLTRIM(loc_cCta)), "CrTmpCli")
                        loc_cRClis = ""
                        IF USED("CrTmpCli")
                            SELECT CrTmpCli
                            GO TOP
                            IF !EOF()
                                loc_cRClis = ALLTRIM(CrTmpCli.RClis)
                            ENDIF
                        ENDIF

                        SELECT TmpRelat
                        INSERT INTO TmpRelat (Fase, IClis, RClis, CMats, DPros, CPros, ;
                            DDPros, TpOps, CUnis, Operacaos, Nenvs, Datas, Fators, ;
                            Moecs, Cclass, CodFinP, Dimens, Cgrus, Sgrus, DFinP, DClass) ;
                            VALUES (PADR(ALLTRIM(loc_cGrp),10), ;
                                PADR(ALLTRIM(loc_cCta),10), ;
                                loc_cRClis, ;
                                PADR(ALLTRIM(CrSigCdNec.CMats),14), ;
                                ALLTRIM(CrSigCdPro.DPros), ;
                                loc_lcPro, loc_lcDpr, ;
                                PADR(ALLTRIM(loc_cTpOps),15), ;
                                PADR(ALLTRIM(CrSigCdPro.Cunis),3), ;
                                loc_cPed, loc_nEnv, loc_ldData, ;
                                CrSigCdNec.Fators, ;
                                PADR(ALLTRIM(CrSigCdPro.Moecs),3), ;
                                PADR(ALLTRIM(CrSigCdPro.Cclass),3), ;
                                PADR(ALLTRIM(CrSigCdPro.CodFinp),3), ;
                                loc_lcDimen, ;
                                PADR(ALLTRIM(CrSigCdPro.Cgrus),3), ;
                                PADR(ALLTRIM(CrSigCdPro.Sgrus),3), ;
                                loc_cDFinP, loc_cDClass)
                    ENDIF

                    SELECT TmpRelat
                    REPLACE Qtde WITH Qtde + CrSigCdNec.Qtds
                    IF ALLTRIM(CrSigCdPro.Moecs) <> loc_cMoeda
                        loc_nValorCalc = fCarregarCambio(ALLTRIM(CrSigCdPro.Moecs), DATE()) / ;
                                         fCarregarCambio(loc_cMoeda, DATE())
                    ELSE
                        loc_nValorCalc = CrSigCdPro.Pcuss * CrSigCdNec.Qtds
                    ENDIF
                    REPLACE Valor WITH Valor + loc_nValorCalc
                    REPLACE Moecs WITH IIF(ALLTRIM(CrSigCdPro.Moecs) <> loc_cMoeda, ;
                        loc_cMoeda, ALLTRIM(CrSigCdPro.Moecs))

                    *-- Linha de total geral (somente modo Analitico)
                    IF loc_nAgru = 1
                        loc_cChaveTotal = DTOS(CTOD("31/12/9999")) + ;
                                          REPLICATE(CHR(255), 20) + ;
                                          PADR(ALLTRIM(loc_cTpOps), 15) + ;
                                          PADR(ALLTRIM(CrSigCdPro.Cunis), 3) + ;
                                          PADR(ALLTRIM(CrSigCdNec.CMats), 14) + ;
                                          PADR(" ", 31) + STR(0, 10)
                        SELECT TmpRelat
                        SET ORDER TO TAG FFuncMat
                        IF !SEEK(loc_cChaveTotal)
                            INSERT INTO TmpRelat (Fase, IClis, RClis, CMats, TpOps, ;
                                CUnis, Moecs, Datas, CodFinP, Cclass) ;
                                VALUES (REPLICATE(CHR(255),10), ;
                                    REPLICATE(CHR(255),10), ;
                                    "Total Geral : ", ;
                                    PADR(ALLTRIM(CrSigCdNec.CMats),14), ;
                                    PADR(ALLTRIM(loc_cTpOps),15), ;
                                    PADR(ALLTRIM(CrSigCdPro.Cunis),3), ;
                                    PADR(ALLTRIM(CrSigCdPro.Moecs),3), ;
                                    CTOD("31/12/9999"), "", "")
                        ENDIF
                        SELECT TmpRelat
                        REPLACE Qtde WITH Qtde + CrSigCdNec.Qtds
                        IF ALLTRIM(CrSigCdPro.Moecs) <> loc_cMoeda
                            loc_nValorCalc = fCarregarCambio(ALLTRIM(CrSigCdPro.Moecs), DATE()) / ;
                                             fCarregarCambio(loc_cMoeda, DATE())
                        ELSE
                            loc_nValorCalc = CrSigCdPro.Pcuss * CrSigCdNec.Qtds
                        ENDIF
                        REPLACE Valor WITH Valor + loc_nValorCalc
                        REPLACE Moecs WITH IIF(ALLTRIM(CrSigCdPro.Moecs) <> loc_cMoeda, ;
                            loc_cMoeda, ALLTRIM(CrSigCdPro.Moecs))
                    ENDIF

                ENDSCAN

                WAIT CLEAR
            ENDIF

            *-- Agregar TmpRelat conforme tipo de agrupamento
            SELECT TmpRelat
            GO TOP

            DO CASE
                CASE loc_nAgru = 1
                    loc_cCabTipo = " - Tipo : Anal" + CHR(237) + "tico"
                    SELECT * FROM TmpRelat ;
                        ORDER BY Datas, Fase, IClis, TpOps, CUnis, Moecs, CMats, Qtde DESC ;
                        INTO CURSOR TmpRelat READWRITE

                CASE loc_nAgru = 2
                    loc_cCabTipo = " - Tipo : Modelo"
                    SELECT CodFinp, Cunis, ;
                        SUM(Qtds) AS QtdTrabs, SUM(Qtds * Pcuss) AS CustoTrabs ;
                        FROM TmpProd ;
                        GROUP BY CodFinp, Cunis ;
                        ORDER BY CodFinp, QtdTrabs DESC ;
                        INTO CURSOR TmpProd READWRITE
                    SELECT a.TpOps, a.CodFinp AS Agrupa, a.DFinP AS Dagrupa, ;
                        a.Cunis, a.Moecs, b.QtdTrabs, ;
                        SUM(a.Qtde) AS Qtde, SUM(a.Valor) AS Valor, ;
                        b.CustoTrabs, ((SUM(a.Qtde) / b.QtdTrabs) * 100) AS PercMat ;
                        FROM TmpRelat a LEFT JOIN TmpProd b ;
                            ON a.CodFinP = b.CodFinP AND a.Cunis = b.Cunis ;
                        GROUP BY a.TpOps, a.CodFinp, a.DFinP, a.Cunis, a.Moecs, ;
                            b.QtdTrabs, b.CustoTrabs ;
                        ORDER BY a.TpOps, a.CodFinp, a.Cunis ;
                        INTO CURSOR TmpRelat READWRITE

                CASE loc_nAgru = 3
                    loc_cCabTipo = " - Tipo : Classifica" + CHR(231) + CHR(227) + "o"
                    SELECT Cclass, Cunis, ;
                        SUM(Qtds) AS QtdTrabs, SUM(Qtds * Pcuss) AS CustoTrabs ;
                        FROM TmpProd ;
                        GROUP BY Cclass, Cunis ;
                        ORDER BY Cclass, QtdTrabs DESC ;
                        INTO CURSOR TmpProd READWRITE
                    SELECT a.TpOps, a.Cclass AS Agrupa, a.DClass AS Dagrupa, ;
                        a.Cunis, a.Moecs, b.QtdTrabs, ;
                        SUM(a.Qtde) AS Qtde, SUM(a.Valor) AS Valor, ;
                        b.CustoTrabs, ((SUM(a.Qtde) / b.QtdTrabs) * 100) AS PercMat ;
                        FROM TmpRelat a LEFT JOIN TmpProd b ;
                            ON a.Cclass = b.Cclass AND a.Cunis = b.Cunis ;
                        GROUP BY a.TpOps, a.Cclass, a.DClass, a.Cunis, a.Moecs, ;
                            b.QtdTrabs, b.CustoTrabs ;
                        ORDER BY a.TpOps, a.Cclass, a.Cunis ;
                        INTO CURSOR TmpRelat READWRITE

                CASE loc_nAgru = 4
                    loc_cCabTipo = " - Tipo : Conta"
                    SELECT GrupoOs, ContaOs, Cunis, ;
                        SUM(Qtds) AS QtdTrabs, SUM(Qtds * Pcuss) AS CustoTrabs ;
                        FROM TmpProd ;
                        GROUP BY GrupoOs, ContaOs, Cunis ;
                        ORDER BY GrupoOs, ContaOs, QtdTrabs DESC ;
                        INTO CURSOR TmpProd READWRITE
                    SELECT a.TpOps, a.Fase AS Agrupa, ;
                        ALLTRIM(a.IClis) + " - " + ALLTRIM(a.RClis) AS Dagrupa, ;
                        a.Cunis, a.Moecs, b.QtdTrabs, ;
                        SUM(a.Qtde) AS Qtde, SUM(a.Valor) AS Valor, ;
                        b.CustoTrabs, ((SUM(a.Qtde) / b.QtdTrabs) * 100) AS PercMat ;
                        FROM TmpRelat a LEFT JOIN TmpProd b ;
                            ON ALLTRIM(a.Fase) = ALLTRIM(b.GrupoOs) ;
                                AND ALLTRIM(a.IClis) = ALLTRIM(b.ContaOs) ;
                                AND a.Cunis = b.Cunis ;
                        GROUP BY a.TpOps, a.Fase, Dagrupa, a.Cunis, a.Moecs, ;
                            b.QtdTrabs, b.CustoTrabs ;
                        ORDER BY a.TpOps, a.Fase, Dagrupa, a.Cunis ;
                        INTO CURSOR TmpRelat READWRITE

            ENDCASE

            *-- Cabecalho do relatorio
            loc_cCab = "An" + CHR(225) + "lise por Tipo de Material" + ;
                       CHR(13) + "Moeda : " + loc_cMoeda + loc_cCabTipo
            IF loc_lDestino
                loc_cSub = "Por Destino"
            ELSE
                loc_cSub = "Por Origem"
            ENDIF
            loc_cSub = loc_cSub + " - Per" + CHR(237) + "odo : " + ;
                       ALLTRIM(DTOC(loc_dDatai)) + " at" + CHR(233) + " " + ;
                       ALLTRIM(DTOC(loc_dDataf))

            *-- Nome da empresa
            loc_cEmp = ALLTRIM(go_4c_Sistema.cCodEmpresa) + " - " + ALLTRIM(go_4c_Sistema.cEmpresa)

            *-- Cursor de cabecalho
            IF USED("dbCabecalho")
                USE IN dbCabecalho
            ENDIF
            CREATE CURSOR dbCabecalho (Titulo c(100), SubTitulo c(100), NomeEmpresa c(100))
            INSERT INTO dbCabecalho (Titulo, SubTitulo, NomeEmpresa) ;
                VALUES (loc_cCab, loc_cSub, loc_cEmp)

            SELECT TmpRelat
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            WAIT CLEAR
            MsgErro(loc_oErro.Message, "Erro em PrepararDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                DO CASE
                    CASE THIS.this_nAgru = 1
                        REPORT FORM (gc_4c_CaminhoReports + "SigReAt2") PREVIEW NOCONSOLE
                    OTHERWISE
                        REPORT FORM (gc_4c_CaminhoReports + "SigReAt3") PREVIEW NOCONSOLE
                ENDCASE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao visualizar relat" + CHR(243) + "rio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                DO CASE
                    CASE THIS.this_nAgru = 1
                        REPORT FORM (gc_4c_CaminhoReports + "SigReAt2") TO PRINT PROMPT NOCONSOLE
                    OTHERWISE
                        REPORT FORM (gc_4c_CaminhoReports + "SigReAt3") TO PRINT PROMPT NOCONSOLE
                ENDCASE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao imprimir relat" + CHR(243) + "rio")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro da ultima operacao
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao possui chave primaria persistida
    * Para fins de auditoria/log, retorna chave composta dos filtros principais
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = DTOC(THIS.this_dDatai) + "|" + DTOC(THIS.this_dDataf) + "|" + ;
                     ALLTRIM(THIS.this_cTpGOp) + "|" + ALLTRIM(THIS.this_cGrupo) + "|" + ;
                     ALLTRIM(THIS.this_cConta) + "|" + STR(THIS.this_nAgru, 1)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Nao aplicavel a relatorios (RelatorioBase nao persiste)
    * Mantido para compatibilidade com padrao de validacao do pipeline.
    * Em relatorios, a carga dos filtros vem do Form (FormParaRelatorio).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel a relatorios (frmrelatorio nao persiste dados)
    * Mantido para compatibilidade com padrao de validacao do pipeline.
    * A acao equivalente em relatorios eh Visualizar()/Imprimir().
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                                  "o aplic" + CHR(225) + "vel a relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel a relatorios (frmrelatorio nao persiste dados)
    * Mantido para compatibilidade com padrao de validacao do pipeline.
    * A acao equivalente em relatorios eh Visualizar()/Imprimir().
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                                  "o aplic" + CHR(225) + "vel a relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

ENDDEFINE
