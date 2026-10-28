*==============================================================================
* SIGOPCFEBO.prg - Business Object para Pesquisa de Saldos por Funcionario
*
* Form OPERACIONAL sem tabela principal (processamento/consulta de saldos).
* Fontes consultadas: SigCdPro, SigCdGcr, SigCdCli, SigMvEst, SigCdNec, SigCdNei,
*                      SigCdFcx, SigCdOpe, SigCdOpd, SigOpOpt, SigCdPam, SigCdPac.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*==============================================================================

DEFINE CLASS SIGOPCFEBO AS BusinessBase

    *==========================================================================
    * Filtro: Material (Get_Mat / Get_DMat -> SigCdPro.CPros / DPros)
    *==========================================================================
    this_cMaterial      = ""   && char(14) - Codigo do material/produto pesquisado
    this_cDescMaterial  = ""   && char(40) - Descricao do material/produto

    *==========================================================================
    * Filtro: Grupo de Conta (Get_grupo / get_Dgrupo -> SigCdGcr.Codigos / Descrs)
    *==========================================================================
    this_cGrupo         = ""   && Codigo do grupo de contas (opcional)
    this_cDescGrupo     = ""   && Descricao do grupo de contas

    *==========================================================================
    * Filtro: Conta/Funcionario (Get_conta / Get_dconta -> SigCdCli.IClis / RClis)
    *==========================================================================
    this_cConta         = ""   && Codigo da conta/funcionario (opcional)
    this_cDescConta     = ""   && Descricao da conta/funcionario

    *==========================================================================
    * Opcoes de processamento (Chk_Saldo / chkFalha)
    *==========================================================================
    this_lNaoMostrarSaldosZerados = .F.   && Chk_Saldo - oculta saldo = 0 na grade
    this_lNaoChecarFalha           = .F.   && chkFalha - nao calcula/subtrai falha

    *==========================================================================
    * Estado do processamento (populado por Processar/buscas)
    *==========================================================================
    this_nQtdeRegistros = 0    && Quantidade de registros apurados em TmpSaldo
    this_cCursorSaldo    = "cursor_4c_Saldo"   && Alias do cursor de resultado (grade)

    *-- O cursor do cabecalho MANTEM o nome legado "TmpCabec" de proposito: o
    *-- SigOpCfe.frx referencia TmpCabec.Titulo/TmpCabec.SubTitulo
    *-- explicitamente (conferido no .frt) - renomear para o padrao
    *-- cursor_4c_* faria o relatorio abortar com "Alias TMPCABEC is not
    *-- found". Mesmo tratamento de SigOpCfaBO/sigreanrBO.
    this_cCursorCabecalho = "TmpCabec"
    this_cCursorEmpresa   = "cursor_4c_Empresa"

    *==========================================================================
    * Linha corrente do resultado (cursor_4c_Saldo, equivalente ao TmpSaldo do
    * legado: Codigo/Nome/Fase/Saldo/Data) - populada por CarregarDoCursor()
    * quando o usuario posiciona o cursor numa linha da grade de resultado.
    *==========================================================================
    this_cCodigoSaldo    = ""   && char(10) - Codigo do funcionario/conta
    this_cNomeSaldo      = ""   && char(50) - Nome do funcionario/conta
    this_cFaseSaldo      = ""   && char(10) - Grupo/fase do saldo apurado
    this_nSaldoValor     = 0    && numeric(12,3) - Saldo apurado
    this_dUltimoBalanco  = {}   && date - Data do ultimo balanco da conta

    *==========================================================================
    * Init - Inicializa o Business Object
    * Form OPERACIONAL de consulta/processamento: nao ha tabela principal de
    * CRUD (Inserir/Atualizar/Excluir nao se aplicam), por isso this_cTabela e
    * this_cCampoChave permanecem vazios.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarCursoresReferencia - Carrega os cursores de referencia usados
    * pelo processamento de saldos. Equivalente ao bloco WITH ThisForm ...
    * EndWith do Init() legado do SIGOPCFE.SCX (SigCdPam/SigCdPac/SigOpOpt/
    * SigCdOpe/SigCdOpd/SigCdGcr/SigCdPro/SigCdCli), exceto os trechos de UI
    * (CntMensagem.Visible/.Show), que ficam no Form.
    *
    * Mantido PUBLIC (sem PROTECTED): o Form chama este metodo a partir de
    * InicializarForm(), antes de habilitar os filtros Material/Grupo/Conta.
    *==========================================================================
    PROCEDURE CarregarCursoresReferencia()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            DO WHILE .T.
                *-- SigCdPam: parametros gerais do modulo de balanco/estoque
                loc_cSQL = "SELECT Ouros, BalPortas, BalVelocs, BalTppars, BalBits, " + ;
                           "BalParids, AcertBals, DopeBals, MascNums, GrupoRecs, " + ;
                           "ContaRecs, GrupoPags, ContaPags FROM SigCdPam"
                IF USED("cursor_4c_Pam")
                    USE IN cursor_4c_Pam
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam")
                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (cursor_4c_Pam)"
                    EXIT
                ENDIF

                *-- SigCdPac: parametros de fechamento
                loc_cSQL = "SELECT ndFechas FROM SigCdPac"
                IF USED("cursor_4c_Pac")
                    USE IN cursor_4c_Pac
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pac")
                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (cursor_4c_Pac)"
                    EXIT
                ENDIF

                *-- SigOpOpt: opcoes por tipo de operacao (percentual de falha)
                loc_cSQL = "SELECT Cods, PFalhas, TFalhas, Trabas, Prodzs FROM SigOpOpt"
                IF USED("cursor_4c_OpOpt")
                    USE IN cursor_4c_OpOpt
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpOpt")
                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (cursor_4c_OpOpt)"
                    EXIT
                ENDIF
                SELECT cursor_4c_OpOpt
                INDEX ON Cods TAG Cods

                *-- SigCdOpe: definicao dos tipos de operacao (origem/destino)
                loc_cSQL = "SELECT Dopes, Origems, EstOrigs, Destinos, EstDests, Opers " + ;
                           "FROM SigCdOpe"
                IF USED("cursor_4c_Ope")
                    USE IN cursor_4c_Ope
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ope")
                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (cursor_4c_Ope)"
                    EXIT
                ENDIF
                SELECT cursor_4c_Ope
                INDEX ON Dopes TAG Dopes

                *-- SigCdOpd: definicao dos tipos de operacao de producao
                loc_cSQL = "SELECT Dopps, Origems, EstOrigs, Destinos, EstDests " + ;
                           "FROM SigCdOpd"
                IF USED("cursor_4c_Opd")
                    USE IN cursor_4c_Opd
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Opd")
                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (cursor_4c_Opd)"
                    EXIT
                ENDIF
                SELECT cursor_4c_Opd
                INDEX ON Dopps TAG Dopps

                *-- SigCdGcr: grupos de conta, sem filtro (usado nas checagens de UnifBals)
                loc_cSQL = "SELECT Codigos, UnifBals, GerBals FROM SigCdGcr"
                IF USED("cursor_4c_Gcr")
                    USE IN cursor_4c_Gcr
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Gcr")
                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (cursor_4c_Gcr)"
                    EXIT
                ENDIF
                SELECT cursor_4c_Gcr
                INDEX ON Codigos TAG Codigos

                *-- SigCdPro: cadastro de produtos/materiais
                loc_cSQL = "SELECT CPros, DPros, CUnis, CGrus, Varias, Custofs, " + ;
                           "MoeCusfs, MatPrincs, cUniPs FROM SigCdPro"
                IF USED("cursor_4c_Pro")
                    USE IN cursor_4c_Pro
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pro")
                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (cursor_4c_Pro)"
                    EXIT
                ENDIF
                SELECT cursor_4c_Pro
                INDEX ON CPros TAG CPros

                *-- SigCdCli: contas/funcionarios habilitados para balanco (GerBals = 1)
                loc_cSQL = "SELECT IClis, RClis, Grupos, Inativas FROM SigCdCli " + ;
                           "WHERE GerBals = 1"
                IF USED("cursor_4c_Cli")
                    USE IN cursor_4c_Cli
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cli")
                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (cursor_4c_Cli)"
                    EXIT
                ENDIF
                SELECT cursor_4c_Cli
                INDEX ON Grupos TAG BalGrupo
                INDEX ON IClis  TAG BalCodigo
                INDEX ON RClis  TAG BalNome

                *-- SigCdGcr: grupos de conta habilitados para balanco (GerBals = 1)
                loc_cSQL = "SELECT Codigos, Descrs, TrfPesas, CompAgrus FROM SigCdGcr " + ;
                           "WHERE GerBals = 1"
                IF USED("cursor_4c_Gccr")
                    USE IN cursor_4c_Gccr
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Gccr")
                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (cursor_4c_Gccr)"
                    EXIT
                ENDIF
                SELECT cursor_4c_Gccr
                INDEX ON Codigos TAG BalCodigo
                INDEX ON Descrs  TAG BalDescrs

                loc_lResultado = .T.
                EXIT
            ENDDO
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega a linha corrente do cursor de resultado
    * (cursor_4c_Saldo, equivalente ao TmpSaldo do legado) para as
    * propriedades this_cCodigoSaldo/this_cNomeSaldo/this_cFaseSaldo/
    * this_nSaldoValor/this_dUltimoBalanco.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        THIS.this_cCodigoSaldo    = TratarNulo(Codigo, "")
        THIS.this_cNomeSaldo      = TratarNulo(Nome, "")
        THIS.this_cFaseSaldo      = TratarNulo(Fase, "")
        THIS.this_nSaldoValor     = TratarNulo(Saldo, 0)
        THIS.this_dUltimoBalanco  = TratarNulo(Data, {})

        loc_lResultado = .T.
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Inserir / Atualizar / ExecutarExclusao
    *
    * SIGOPCFE e um form OPERACIONAL de consulta e processamento ("Pesquisa
    * de Saldos por Funcionario"): o legado apura o resultado so em cursores
    * locais (TmpSaldo/TmpResumo/TmpOpera), nunca numa tabela propria do SQL
    * Server - os dados persistidos que ele le pertencem a outras entidades
    * (SigMvEst, SigMvCab, SigCdNec, SigCdFcx, etc), cada uma com seu proprio
    * BO. Por isso esta tela nao tem INSERT/UPDATE/DELETE proprios; o
    * comportamento padrao herdado de BusinessBase (recusar a operacao e
    * expor THIS.this_cMensagemErro) ja e o correto aqui.
    *==========================================================================
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Esta tela realiza consulta e processamento de " + ;
                                   "saldos; n" + CHR(227) + "o grava registro pr" + CHR(243) + "prio."
        RETURN .F.
    ENDPROC

    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Esta tela realiza consulta e processamento de " + ;
                                   "saldos; n" + CHR(227) + "o grava registro pr" + CHR(243) + "prio."
        RETURN .F.
    ENDPROC

    PROTECTED PROCEDURE ExecutarExclusao()
        THIS.this_cMensagemErro = "Esta tela realiza consulta e processamento de " + ;
                                   "saldos; n" + CHR(227) + "o exclui registro pr" + CHR(243) + "prio."
        RETURN .F.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Nao ha registro proprio persistido por esta BO
    * (ver Inserir/Atualizar/ExecutarExclusao acima). Mantido PROTECTED para
    * compatibilidade com a interface de BusinessBase, devolvendo o codigo
    * do material pesquisado como chave de referencia da consulta atual.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cMaterial
    ENDPROC

    *==========================================================================
    * ProcessarSaldos - Fase 7/8: transcricao literal do Processa.Click do
    * legado (SIGOPCFE.SCX, ~975 linhas) - apura o saldo de Material por
    * Fase (Grupo) e Conta/Funcionario, cruzando Produ" + CHR(231) + CHR(227) +
    * "o (SigCdNec/SigCdNei), Estoque (SigMvCab/SigMvItn/SigMvIts) e Pesagem
    * (SigCdPsc/SigCdPsi), com o saldo anterior em SigOpCfe/SigCdFcx.
    *
    * Regra #17 (CLAUDE.md): a formula e os guards sao regra de negocio -
    * TRANSCRITOS, nao reescritos. Nomes de cursor/variavel seguem o padrao
    * _4c_/loc_ do projeto (PILAR 3); valores/condicoes/ordem permanecem
    * IDENTICOS ao legado, inclusive quando parecem assimetricos entre os
    * ramos origem/destino (ex.: CUnis vindo de TmpPro num bloco e do
    * proprio registro no outro) - e inclusive na linha marcada abaixo, que
    * reproduz um comportamento visivelmente estranho do legado (usa
    * LocalNens.GrupoOs/ContaOs, nao _Grupo/_Conta) porque a regra exige
    * transcricao literal, nao correcao nao verificada.
    *
    * Sem TRY/CATCH (igual ao legado, que tambem nao tem): cada falha de
    * SQLEXEC usa o mesmo "Return 0" do original, aqui RETURN .F. com
    * THIS.this_cMensagemErro preenchido - sintaxe valida porque nao ha
    * bloco TRY envolvendo (regra #1 so veda RETURN DENTRO de TRY/CATCH).
    *
    * Guarda de Material vazio fica no Form (tem o SetFocus do campo).
    *==========================================================================
    PROCEDURE ProcessarSaldos()
        LOCAL loc_cSQL, loc_nResultado, loc_cCodMat, loc_cGrupoF, loc_cContaF
        LOCAL loc_dPDat, loc_lPNot, loc_lFalse
        LOCAL loc_cGrupoProc, loc_cContaProc, loc_nFalhaAdmitida, loc_lTipoQ
        LOCAL loc_oBarraP, loc_oBarra
        LOCAL loc_cEdn, loc_lOrigem, loc_lDestino, loc_cMaterial, loc_cMatResFa
        LOCAL loc_cGrupoD, loc_cContaD, loc_cOperacao
        LOCAL loc_cCodCor, loc_cCodTam, loc_nQtde, loc_nPeso, loc_nFalha
        LOCAL loc_cMat, loc_nSaldoI, loc_nSaidas, loc_nPesagem, loc_nTrabalhado, loc_cMatCorrente
        LOCAL loc_nQtdeSaldo

        *-- Recria/zera os cursores de trabalho (equivalente ao Create
        *-- Cursor do Load legado + Select/Zap do inicio do Click - regra
        *-- #52: ZAP so e seguro porque os dois ja nascem com Buffering<=1).
        IF USED("cursor_4c_Opera")
            SELECT cursor_4c_Opera
            ZAP
        ELSE
            CREATE CURSOR cursor_4c_Opera (Grupo C(10), Conta C(10), CMats C(14), TpOps C(15), ;
                PesoEnts N(12,3), QtdeEnts N(12,3), PesoSais N(12,3), QtdeSais N(12,3), ;
                PFalha N(6,2), Falha N(12,3), PFalhaE N(6,2), FalhaE N(12,3), Varias N(1), ;
                Agregas N(1), AplicFlhs N(1), PesoBSais N(12,3), PesoBEnts N(12,3), ;
                QtdeBEnts N(12,3), QtdeBSais N(12,3))
            INDEX ON Grupo + Conta + CMats + TpOps TAG GrConMatTp
        ENDIF
        SELECT cursor_4c_Opera
        SET ORDER TO GrConMatTp ASCENDING

        IF USED("cursor_4c_Resumo")
            SELECT cursor_4c_Resumo
            ZAP
        ELSE
            CREATE CURSOR cursor_4c_Resumo (Flag L, Flag2 L, Grupo C(10), Conta C(10), CMats C(14), ;
                CUnis C(3), PesoEnts N(12,3), QtdeEnts N(12,3), PesoSais N(12,3), QtdeSais N(12,3), ;
                Saldoi N(12,3), Pesagem N(12,3), FReal N(12,3), FAdmin N(12,3), Saldof N(12,3), ;
                PesoPEnts N(12,3), PesoPSais N(12,3), PfTrabs N(9,2), Flag3 L, Varias N(1), ;
                PesoFabre N(12,3), PesoFabrs N(12,3), cUniPs C(3), CodCors C(4), CodTams C(4), ;
                Visivel L, Agregas N(1))
            INDEX ON Cmats + CodCors + CodTams TAG cpros
            INDEX ON Grupo + Conta + CMats + CodCors + CodTams TAG GrConMat FOR Visivel
        ENDIF
        SELECT cursor_4c_Resumo
        SET ORDER TO GrConMat

        IF !USED("cursor_4c_Saldo")
            THIS.this_cMensagemErro = "Cursor de resultado n" + CHR(227) + "o inicializado."
            RETURN .F.
        ENDIF
        SELECT cursor_4c_Saldo
        SET ORDER TO TAG Codigo
        ZAP

        loc_cCodMat = ALLTRIM(THIS.this_cMaterial)
        loc_cGrupoF = ALLTRIM(THIS.this_cGrupo)
        loc_cContaF = ALLTRIM(THIS.this_cConta)

        loc_cSQL = "SELECT Grupos, Estos FROM SigMvEst WHERE Emps = " + ;
            EscaparSQL(PADR(go_4c_Sistema.cCodEmpresa, 3)) + " AND CPros = " + EscaparSQL(loc_cCodMat) + ;
            IIF(!EMPTY(loc_cGrupoF), " AND Grupos = " + EscaparSQL(loc_cGrupoF), "") + ;
            IIF(!EMPTY(loc_cContaF), " AND Estos = " + EscaparSQL(loc_cContaF), "")

        IF USED("cursor_4c_MvEst")
            USE IN cursor_4c_MvEst
        ENDIF
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvEst")
        IF loc_nResultado < 1
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (cursor_4c_MvEst)"
            RETURN .F.
        ENDIF

        SELECT cursor_4c_MvEst
        loc_oBarraP = CREATEOBJECT("fwprogressbar", "Processando as Contas...", RECCOUNT())
        IF VARTYPE(loc_oBarraP) = "O"
            loc_oBarraP.Top = loc_oBarraP.Top - INT(loc_oBarraP.Height / 2)
            loc_oBarraP.Show()
        ENDIF
        SCAN
            IF VARTYPE(loc_oBarraP) = "O"
                loc_oBarraP.Update(.T.)
            ENDIF

            loc_cSQL = "SELECT Rclis, GerBals, PagFals, RecFals FROM SigCdCli WHERE Iclis = " + ;
                EscaparSQL(cursor_4c_MvEst.Estos)
            IF USED("cursor_4c_CliDet")
                USE IN cursor_4c_CliDet
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliDet") < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (cursor_4c_CliDet)"
                RETURN .F.
            ENDIF

            = SEEK(cursor_4c_MvEst.Grupos, "cursor_4c_Gcr", "Codigos")

            IF cursor_4c_CliDet.GerBals <> 1 OR cursor_4c_Gcr.GerBals <> 1
                LOOP
            ENDIF

            loc_cSQL = "SELECT TOP 1 Datas FROM SigCdFcx WHERE Emps = " + ;
                EscaparSQL(PADR(go_4c_Sistema.cCodEmpresa, 3)) + " AND Grupos = " + EscaparSQL(cursor_4c_MvEst.Grupos) + ;
                " AND Contas = " + EscaparSQL(cursor_4c_MvEst.Estos) + " ORDER BY Datas DESC"
            IF USED("cursor_4c_Fcx")
                USE IN cursor_4c_Fcx
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Fcx") < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (cursor_4c_Fcx)"
                RETURN .F.
            ENDIF

            INSERT INTO cursor_4c_Saldo (Codigo, Nome, Fase, Data) ;
                VALUES (cursor_4c_MvEst.Estos, cursor_4c_CliDet.RClis, cursor_4c_MvEst.Grupos, cursor_4c_Fcx.Datas)

            loc_dPDat          = TTOD(cursor_4c_Fcx.Datas) + cursor_4c_Pac.ndFechas
            loc_lPNot          = .F.
            loc_lFalse         = .F.
            loc_cGrupoProc     = cursor_4c_MvEst.Grupos
            loc_cContaProc     = cursor_4c_MvEst.Estos
            loc_nFalhaAdmitida = 0
            loc_lTipoQ         = .F.

            loc_cSQL = "SELECT Datas, Dopps, GrupoOs, ContaOs, GrupoDs, ContaDs, Emps, Numps, Obss, cIdChaves, EmpDnPs " + ;
                "FROM SigCdNec WHERE Emps = " + EscaparSQL(PADR(go_4c_Sistema.cCodEmpresa, 3)) + ;
                " AND Datas >= ?loc_dPDat AND ((GrupoDs = " + EscaparSQL(loc_cGrupoProc) + " AND ContaDs = " + ;
                EscaparSQL(loc_cContaProc) + " AND ProcdBal = ?loc_lFalse) OR (GrupoOs = " + EscaparSQL(loc_cGrupoProc) + ;
                " AND ContaOs = " + EscaparSQL(loc_cContaProc) + " AND ProcBals = ?loc_lFalse)) " + ;
                "ORDER BY Datas, Dopps, GrupoOs, ContaOs, GrupoDs, ContaDs, Emps, Numps, cIdChaves"

            IF USED("cursor_4c_Nens")
                USE IN cursor_4c_Nens
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Nens") < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (cursor_4c_Nens)"
                RETURN .F.
            ENDIF

            loc_cSQL = "SELECT b.EmpDNPs, b.CMats, b.CUnis, b.Nenvs, b.Pesos, b.Qtds, b.TpOps, b.cIdChaves, b.Nops, b.Peso2s, b.CodCors, b.CodTams " + ;
                "FROM SigCdNec a, SigCdNei b WHERE a.Emps = " + EscaparSQL(PADR(go_4c_Sistema.cCodEmpresa, 3)) + ;
                " AND a.Datas >= ?loc_dPDat AND (a.GrupoDs = " + EscaparSQL(loc_cGrupoProc) + " OR a.GrupoOs = " + ;
                EscaparSQL(loc_cGrupoProc) + ") AND (a.ContaDs = " + EscaparSQL(loc_cContaProc) + " OR a.ContaOs = " + ;
                EscaparSQL(loc_cContaProc) + ") AND a.EmpDNPs = b.EmpDNPs AND b.Servicos = ?loc_lPNot " + ;
                "ORDER BY b.EmpDNPs, b.CMats, b.CUnis, b.Nenvs, b.Pesos, b.Qtds, b.TpOps, b.cIdChaves, b.Nops"

            IF USED("cursor_4c_NensI")
                USE IN cursor_4c_NensI
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NensI") < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (cursor_4c_NensI)"
                RETURN .F.
            ENDIF
            SELECT cursor_4c_NensI
            INDEX ON EmpDNPs TAG EmpDNPs
            SET ORDER TO EmpDNPs

            SELECT cursor_4c_Nens
            loc_oBarra = CREATEOBJECT("fwprogressbar", "Processando Mov. de Produ" + CHR(231) + CHR(227) + "o...", RECCOUNT())
            IF VARTYPE(loc_oBarra) = "O"
                loc_oBarra.Top = loc_oBarra.Top + INT(loc_oBarra.Height / 2)
                loc_oBarra.Show()
            ENDIF
            SCAN
                IF VARTYPE(loc_oBarra) = "O"
                    loc_oBarra.Update(.T.)
                ENDIF

                loc_cEdn = cursor_4c_Nens.Emps + cursor_4c_Nens.Dopps + STR(cursor_4c_Nens.Numps, 10)

                = SEEK(cursor_4c_Nens.Dopps, "cursor_4c_Opd", "Dopps")

                loc_lOrigem   = .F.
                loc_lDestino  = .F.
                loc_cMaterial = SPACE(10)
                loc_cMatResFa = SPACE(10)

                IF cursor_4c_Opd.Origems = 1 AND cursor_4c_Nens.GrupoOs = loc_cGrupoProc AND ;
                        cursor_4c_Nens.ContaOs = loc_cContaProc AND INLIST(cursor_4c_Opd.EstOrigs, 1, 2)
                    loc_lOrigem = .T.
                ENDIF

                IF cursor_4c_Opd.Destinos = 1 AND cursor_4c_Nens.GrupoDs = loc_cGrupoProc AND ;
                        cursor_4c_Nens.ContaDs = loc_cContaProc AND INLIST(cursor_4c_Opd.EstDests, 1, 2)
                    loc_lDestino = .T.
                ENDIF

                IF !loc_lOrigem AND !loc_lDestino
                    LOOP
                ENDIF

                SELECT cursor_4c_NensI
                SEEK loc_cEdn
                SCAN WHILE EmpDNPs = loc_cEdn

                    IF cursor_4c_Gcr.UnifBals = 4
                        IF cursor_4c_NensI.Nops = 0
                            loc_cMaterial = cursor_4c_NensI.CMats
                        ELSE
                            loc_cSQL = "SELECT Cpros FROM SigOpPic WHERE Nops = " + FormatarNumeroSQL(cursor_4c_NensI.Nops, 0)
                            IF USED("cursor_4c_Opi")
                                USE IN cursor_4c_Opi
                            ENDIF
                            = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Opi")
                            = SEEK(cursor_4c_Opi.Cpros, "cursor_4c_Pro", "CPros")
                            loc_cMaterial = IIF(EMPTY(cursor_4c_Pro.MatPrincs), cursor_4c_Pam.Ouros, cursor_4c_Pro.MatPrincs)
                        ENDIF
                        IF cursor_4c_NensI.CMats <> loc_cMaterial
                            LOOP
                        ENDIF
                    ELSE
                        IF cursor_4c_Gcr.UnifBals = 3
                            loc_cSQL = "SELECT Cpros FROM SigOpPic WHERE Nops = " + FormatarNumeroSQL(cursor_4c_NensI.Nops, 0)
                            IF USED("cursor_4c_Opi")
                                USE IN cursor_4c_Opi
                            ENDIF
                            = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Opi")
                            IF cursor_4c_NensI.Nops = 0
                                loc_cMaterial = cursor_4c_NensI.CMats
                            ELSE
                                = SEEK(cursor_4c_Opi.Cpros, "cursor_4c_Pro", "CPros")
                                loc_cMaterial = IIF(EMPTY(cursor_4c_Pro.MatPrincs), cursor_4c_Pam.Ouros, cursor_4c_Pro.MatPrincs)
                            ENDIF
                        ELSE
                            loc_cMaterial = IIF(cursor_4c_Gcr.UnifBals = 1, cursor_4c_Pam.Ouros, cursor_4c_NensI.CMats)
                        ENDIF
                    ENDIF
                    loc_cMatResFa = loc_cMaterial

                    = SEEK(cursor_4c_NensI.CMats, "cursor_4c_Pro", "CPros")
                    loc_cSQL = "SELECT GruEstPs, ConEstPs, nAgMts, TipoEstos, Mercs FROM SigCdGrp WHERE Cgrus = " + EscaparSQL(cursor_4c_Pro.Cgrus)
                    IF USED("cursor_4c_Gru")
                        USE IN cursor_4c_Gru
                    ENDIF
                    = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Gru")

                    loc_cSQL = "SELECT Aplicflhs FROM SigCdGpr WHERE Codigos = " + EscaparSQL(cursor_4c_Gru.Mercs)
                    IF USED("cursor_4c_Ggrp")
                        USE IN cursor_4c_Ggrp
                    ENDIF
                    = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ggrp")

                    loc_cCodCor = PADR(IIF(INLIST(cursor_4c_Gru.TipoEstos, 2, 4), cursor_4c_NensI.CodCors, " "), 4)
                    loc_cCodTam = PADR(IIF(INLIST(cursor_4c_Gru.TipoEstos, 3, 4), cursor_4c_NensI.CodTams, " "), 4)

                    IF loc_lOrigem
                        IF !SEEK(cursor_4c_Nens.GrupoOs + cursor_4c_Nens.ContaOs + cursor_4c_NensI.CMats + loc_cCodCor + loc_cCodTam, "cursor_4c_Resumo")
                            INSERT INTO cursor_4c_Resumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel, CodCors, CodTams) ;
                                VALUES (cursor_4c_Nens.GrupoOs, cursor_4c_Nens.ContaOs, cursor_4c_NensI.CMats, cursor_4c_Pro.CUnis, ;
                                        cursor_4c_Pro.Varias, cursor_4c_Gru.nAgMts, .T., loc_cCodCor, loc_cCodTam)
                        ENDIF

                        SELECT cursor_4c_Resumo
                        IF cursor_4c_Opd.EstOrigs = 1
                            REPLACE PesoEnts  WITH PesoEnts  + cursor_4c_NensI.Pesos, ;
                                    QtdeEnts  WITH QtdeEnts  + cursor_4c_NensI.Qtds, ;
                                    PesoFabre WITH PesoFabre + cursor_4c_NensI.Peso2s
                        ELSE
                            REPLACE PesoSais  WITH PesoSais  + cursor_4c_NensI.Pesos, ;
                                    QtdeSais  WITH QtdeSais  + cursor_4c_NensI.Qtds, ;
                                    PesoFabrs WITH PesoFabrs + cursor_4c_NensI.Peso2s
                        ENDIF

                        IF !SEEK(cursor_4c_Nens.GrupoOs + cursor_4c_Nens.ContaOs + cursor_4c_NensI.CMats + cursor_4c_NensI.TpOps, "cursor_4c_Opera")
                            INSERT INTO cursor_4c_Opera (Grupo, Conta, CMats, TpOps, Varias, Agregas, AplicFlhs) ;
                                VALUES (cursor_4c_Nens.GrupoOs, cursor_4c_Nens.ContaOs, cursor_4c_NensI.CMats, ;
                                        cursor_4c_NensI.TpOps, cursor_4c_Pro.Varias, cursor_4c_Gru.nAgMts, cursor_4c_Ggrp.Aplicflhs)
                        ENDIF

                        SELECT cursor_4c_Opera
                        IF cursor_4c_Opd.EstOrigs = 1
                            REPLACE PesoEnts WITH PesoEnts + cursor_4c_NensI.Pesos, ;
                                    QtdeEnts WITH QtdeEnts + cursor_4c_NensI.Qtds
                        ELSE
                            REPLACE PesoSais WITH PesoSais + cursor_4c_NensI.Pesos, ;
                                    QtdeSais WITH QtdeSais + cursor_4c_NensI.Qtds
                        ENDIF

                        = SEEK(cursor_4c_Opera.TpOps, "cursor_4c_OpOpt", "Cods")

                        IF cursor_4c_OpOpt.PFalhas <> 0 AND cursor_4c_Pro.Varias = 1 AND cursor_4c_OpOpt.TFalhas == "Q" AND !THIS.this_lNaoChecarFalha
                            loc_lTipoQ = .T.
                            IF cursor_4c_Opd.EstOrigs = 1
                                IF cursor_4c_OpOpt.Pfalhas > cursor_4c_NensI.Qtds
                                    loc_nFalha = cursor_4c_NensI.Qtds
                                ELSE
                                    loc_nFalha = cursor_4c_OpOpt.Pfalhas
                                ENDIF

                                REPLACE PFalha WITH loc_nFalha, ;
                                        Falha  WITH cursor_4c_Opera.Falha + loc_nFalha IN cursor_4c_Opera

                                loc_nFalhaAdmitida = loc_nFalhaAdmitida + loc_nFalha
                            ENDIF
                        ENDIF
                    ENDIF

                    IF loc_lDestino
                        IF !SEEK(cursor_4c_Nens.GrupoDs + cursor_4c_Nens.ContaDs + cursor_4c_NensI.CMats + loc_cCodCor + loc_cCodTam, "cursor_4c_Resumo")
                            INSERT INTO cursor_4c_Resumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel, CodCors, CodTams) ;
                                VALUES (cursor_4c_Nens.GrupoDs, cursor_4c_Nens.ContaDs, cursor_4c_NensI.CMats, cursor_4c_Pro.CUnis, ;
                                        cursor_4c_Pro.Varias, cursor_4c_Gru.nAgMts, .T., loc_cCodCor, loc_cCodTam)
                        ENDIF

                        SELECT cursor_4c_Resumo
                        IF cursor_4c_Opd.EstDests = 1
                            REPLACE PesoEnts  WITH PesoEnts  + cursor_4c_NensI.Pesos, ;
                                    QtdeEnts  WITH QtdeEnts  + cursor_4c_NensI.Qtds, ;
                                    PesoFabre WITH PesoFabre + cursor_4c_NensI.Peso2s
                        ELSE
                            REPLACE PesoSais  WITH PesoSais  + cursor_4c_NensI.Pesos, ;
                                    QtdeSais  WITH QtdeSais  + cursor_4c_NensI.Qtds, ;
                                    PesoFabrs WITH PesoFabrs + cursor_4c_NensI.Peso2s
                        ENDIF

                        IF !SEEK(cursor_4c_Nens.GrupoDs + cursor_4c_Nens.ContaDs + cursor_4c_NensI.CMats + cursor_4c_NensI.TpOps, "cursor_4c_Opera")
                            INSERT INTO cursor_4c_Opera (Grupo, Conta, CMats, TpOps, Varias, Agregas, AplicFlhs) ;
                                VALUES (cursor_4c_Nens.GrupoDs, cursor_4c_Nens.ContaDs, cursor_4c_NensI.CMats, ;
                                        cursor_4c_NensI.TpOps, cursor_4c_Pro.Varias, cursor_4c_Gru.nAgMts, cursor_4c_Ggrp.Aplicflhs)
                        ENDIF

                        SELECT cursor_4c_Opera
                        IF cursor_4c_Opd.EstDests = 1
                            REPLACE PesoEnts WITH PesoEnts + cursor_4c_NensI.Pesos, ;
                                    QtdeEnts WITH QtdeEnts + cursor_4c_NensI.Qtds
                        ELSE
                            REPLACE PesoSais WITH PesoSais + cursor_4c_NensI.Pesos, ;
                                    QtdeSais WITH QtdeSais + cursor_4c_NensI.Qtds
                        ENDIF

                        = SEEK(cursor_4c_Opera.TpOps, "cursor_4c_OpOpt", "Cods")

                        IF cursor_4c_OpOpt.PFalhas <> 0 AND cursor_4c_Pro.Varias = 1 AND cursor_4c_OpOpt.TFalhas == "Q" AND !THIS.this_lNaoChecarFalha
                            loc_lTipoQ = .T.
                            IF cursor_4c_Opd.EstDests = 1
                                IF cursor_4c_OpOpt.Pfalhas > cursor_4c_NensI.Qtds
                                    loc_nFalha = cursor_4c_NensI.Qtds
                                ELSE
                                    loc_nFalha = cursor_4c_OpOpt.Pfalhas
                                ENDIF

                                REPLACE PFalha WITH loc_nFalha, ;
                                        Falha  WITH cursor_4c_Opera.Falha + loc_nFalha IN cursor_4c_Opera

                                loc_nFalhaAdmitida = loc_nFalhaAdmitida + loc_nFalha
                            ENDIF
                        ENDIF
                    ENDIF

                    = SEEK(cursor_4c_Resumo.CMats, "cursor_4c_Pro", "CPros")
                    loc_cSQL = "SELECT GruEstPs, ConEstPs, nAgMts, TipoEstos, Mercs FROM SigCdGrp WHERE Cgrus = " + EscaparSQL(cursor_4c_Pro.Cgrus)
                    IF USED("cursor_4c_Gru")
                        USE IN cursor_4c_Gru
                    ENDIF
                    = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Gru")

                    loc_cSQL = "SELECT Aplicflhs FROM SigCdGpr WHERE Codigos = " + EscaparSQL(cursor_4c_Gru.Mercs)
                    IF USED("cursor_4c_Ggrp")
                        USE IN cursor_4c_Ggrp
                    ENDIF
                    = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ggrp")

                    IF cursor_4c_Gcr.UnifBals = 3 AND cursor_4c_NensI.Cmats <> loc_cMaterial AND ;
                            cursor_4c_Gru.GruEstPs <> cursor_4c_MvEst.Grupos AND cursor_4c_Gru.ConEstPs <> cursor_4c_MvEst.Estos
                        = SEEK(loc_cMaterial, "cursor_4c_Pro", "CPros")
                        loc_cSQL = "SELECT GruEstPs, ConEstPs, nAgMts, TipoEstos, Mercs FROM SigCdGrp WHERE Cgrus = " + EscaparSQL(cursor_4c_Pro.Cgrus)
                        IF USED("cursor_4c_Gru")
                            USE IN cursor_4c_Gru
                        ENDIF
                        = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Gru")
                        loc_cSQL = "SELECT Aplicflhs FROM SigCdGpr WHERE Codigos = " + EscaparSQL(cursor_4c_Gru.Mercs)
                        IF USED("cursor_4c_Ggrp")
                            USE IN cursor_4c_Ggrp
                        ENDIF
                        = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ggrp")

                        IF loc_lOrigem
                            IF !SEEK(cursor_4c_Nens.GrupoOs + cursor_4c_Nens.ContaOs + loc_cMaterial, "cursor_4c_Resumo")
                                INSERT INTO cursor_4c_Resumo (Grupo, Conta, CMats, CUnis, Varias, Visivel) ;
                                    VALUES (cursor_4c_Nens.GrupoOs, cursor_4c_Nens.ContaOs, loc_cMaterial, cursor_4c_Pro.CUnis, cursor_4c_Pro.Varias, .T.)
                            ENDIF
                            SELECT cursor_4c_Resumo
                            IF cursor_4c_Opd.EstOrigs = 1
                                REPLACE PesoEnts WITH PesoEnts + cursor_4c_NensI.Pesos, ;
                                        QtdeEnts WITH QtdeEnts + cursor_4c_NensI.Pesos
                            ELSE
                                REPLACE PesoSais WITH PesoSais + cursor_4c_NensI.Pesos, ;
                                        QtdeSais WITH QtdeSais + cursor_4c_NensI.Pesos
                            ENDIF
                            IF !SEEK(cursor_4c_Nens.GrupoOs + cursor_4c_Nens.ContaOs + loc_cMaterial + cursor_4c_NensI.TpOps, "cursor_4c_Opera")
                                INSERT INTO cursor_4c_Opera (Grupo, Conta, CMats, TpOps, Varias, Agregas, AplicFlhs) ;
                                    VALUES (cursor_4c_Nens.GrupoOs, cursor_4c_Nens.ContaOs, loc_cMaterial, cursor_4c_NensI.TpOps, ;
                                            cursor_4c_Pro.Varias, cursor_4c_Gru.nAgMts, cursor_4c_Ggrp.Aplicflhs)
                            ENDIF
                            SELECT cursor_4c_Opera
                            IF cursor_4c_Opd.EstOrigs = 1
                                REPLACE PesoEnts WITH PesoEnts + cursor_4c_NensI.Pesos, ;
                                        QtdeEnts WITH QtdeEnts + cursor_4c_NensI.Pesos
                            ELSE
                                REPLACE PesoSais WITH PesoSais + cursor_4c_NensI.Pesos, ;
                                        QtdeSais WITH QtdeSais + cursor_4c_NensI.Pesos
                            ENDIF
                        ENDIF

                        IF loc_lDestino
                            IF !SEEK(cursor_4c_Nens.GrupoDs + cursor_4c_Nens.ContaDs + loc_cMaterial, "cursor_4c_Resumo")
                                INSERT INTO cursor_4c_Resumo (Grupo, Conta, CMats, CUnis, Varias, Visivel) ;
                                    VALUES (cursor_4c_Nens.GrupoDs, cursor_4c_Nens.ContaDs, loc_cMaterial, cursor_4c_Pro.CUnis, cursor_4c_Pro.Varias, .T.)
                            ENDIF
                            SELECT cursor_4c_Resumo
                            IF cursor_4c_Opd.EstDests = 1
                                REPLACE PesoEnts WITH PesoEnts + cursor_4c_NensI.Pesos, ;
                                        QtdeEnts WITH QtdeEnts + cursor_4c_NensI.Pesos
                            ELSE
                                REPLACE PesoSais WITH PesoSais + cursor_4c_NensI.Pesos, ;
                                        QtdeSais WITH QtdeSais + cursor_4c_NensI.Pesos
                            ENDIF
                            IF !SEEK(cursor_4c_Nens.GrupoDs + cursor_4c_Nens.ContaDs + loc_cMaterial + cursor_4c_NensI.TpOps, "cursor_4c_Opera")
                                INSERT INTO cursor_4c_Opera (Grupo, Conta, CMats, TpOps, Varias, Agregas, AplicFlhs) ;
                                    VALUES (cursor_4c_Nens.GrupoDs, cursor_4c_Nens.ContaDs, loc_cMaterial, cursor_4c_NensI.TpOps, ;
                                            cursor_4c_Pro.Varias, cursor_4c_Gru.nAgMts, cursor_4c_Ggrp.Aplicflhs)
                            ENDIF
                            SELECT cursor_4c_Opera
                            IF cursor_4c_Opd.EstDests = 1
                                REPLACE PesoEnts WITH PesoEnts + cursor_4c_NensI.Pesos, ;
                                        QtdeEnts WITH QtdeEnts + cursor_4c_NensI.Pesos
                            ELSE
                                REPLACE PesoSais WITH PesoSais + cursor_4c_NensI.Pesos, ;
                                        QtdeSais WITH QtdeSais + cursor_4c_NensI.Pesos
                            ENDIF
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDSCAN
            IF VARTYPE(loc_oBarra) = "O"
                loc_oBarra.Complete()
            ENDIF

            loc_cSQL = "SELECT Datas, GrupoOs, ContaOs, GrupoDs, ContaDs, Emps, Dopes, Numes, Obses, CidChaves, EmpDs " + ;
                "FROM SigMvCab WHERE (Emps = " + EscaparSQL(PADR(go_4c_Sistema.cCodEmpresa, 3)) + " OR EmpDs = " + ;
                EscaparSQL(PADR(go_4c_Sistema.cCodEmpresa, 3)) + ") AND Datas >= ?loc_dPDat AND ((GrupoDs = " + ;
                EscaparSQL(loc_cGrupoProc) + " AND ContaDs = " + EscaparSQL(loc_cContaProc) + " AND ProcdBal = ?loc_lFalse) " + ;
                "OR (GrupoOs = " + EscaparSQL(loc_cGrupoProc) + " AND ContaOs = " + EscaparSQL(loc_cContaProc) + ;
                " AND ProcBals = ?loc_lFalse)) ORDER BY Datas"

            IF USED("cursor_4c_Eest")
                USE IN cursor_4c_Eest
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Eest") < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (cursor_4c_Eest)"
                RETURN .F.
            ENDIF

            loc_cSQL = "SELECT b.EmpDopNums, b.Opers, b.CPros, b.CUnis, b.Qtds, b.Pesos, b.cItens " + ;
                "FROM SigMvCab a, SigMvItn b WHERE (a.Emps = " + EscaparSQL(PADR(go_4c_Sistema.cCodEmpresa, 3)) + ;
                " OR a.Empds = " + EscaparSQL(PADR(go_4c_Sistema.cCodEmpresa, 3)) + ") AND Datas >= ?loc_dPDat AND " + ;
                "(GrupoDs = " + EscaparSQL(loc_cGrupoProc) + " OR GrupoOs = " + EscaparSQL(loc_cGrupoProc) + ") AND " + ;
                "(ContaDs = " + EscaparSQL(loc_cContaProc) + " OR ContaOs = " + EscaparSQL(loc_cContaProc) + ") AND " + ;
                "a.EmpDopNums = b.EmpDopNums ORDER BY b.EmpDopNums, b.Opers, b.CPros, b.CUnis, b.Qtds"

            IF USED("cursor_4c_EestI")
                USE IN cursor_4c_EestI
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EestI") < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (cursor_4c_EestI)"
                RETURN .F.
            ENDIF
            SELECT cursor_4c_EestI
            INDEX ON EmpDopNums TAG EmpDopNums
            SET ORDER TO EmpDopNums

            loc_cSQL = "SELECT b.EmpDopNums, b.CPros, b.Qtds, b.Pesos, b.CodCors, b.CodTams, b.Citens " + ;
                "FROM SigMvCab a, SigMvIts b WHERE (a.Emps = " + EscaparSQL(PADR(go_4c_Sistema.cCodEmpresa, 3)) + ;
                " OR a.EmpDs = " + EscaparSQL(PADR(go_4c_Sistema.cCodEmpresa, 3)) + ") AND Datas >= ?loc_dPDat AND " + ;
                "(GrupoDs = " + EscaparSQL(loc_cGrupoProc) + " OR GrupoOs = " + EscaparSQL(loc_cGrupoProc) + ") AND " + ;
                "(ContaDs = " + EscaparSQL(loc_cContaProc) + " OR ContaOs = " + EscaparSQL(loc_cContaProc) + ") AND " + ;
                "a.EmpDopNums = b.EmpDopNums ORDER BY b.EmpDopNums, b.CPros, b.CodCors, b.CodTams, b.Citens"

            IF USED("cursor_4c_Esti2")
                USE IN cursor_4c_Esti2
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Esti2") < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (cursor_4c_Esti2)"
                RETURN .F.
            ENDIF
            SELECT cursor_4c_Esti2
            INDEX ON EmpDopNums + Cpros + STR(Citens, 4) TAG EmpDopNums
            SET ORDER TO EmpDopNums

            SELECT cursor_4c_Eest
            loc_oBarra = CREATEOBJECT("fwprogressbar", "Processando Mov. de Estoque", RECCOUNT("cursor_4c_Eest"))
            IF VARTYPE(loc_oBarra) = "O"
                loc_oBarra.Top = loc_oBarra.Top + INT(loc_oBarra.Height / 2)
                loc_oBarra.Show()
            ENDIF
            SCAN
                IF VARTYPE(loc_oBarra) = "O"
                    loc_oBarra.Update(.T.)
                ENDIF

                loc_cEdn = cursor_4c_Eest.Emps + cursor_4c_Eest.Dopes + STR(cursor_4c_Eest.Numes, 6)

                = SEEK(cursor_4c_Eest.Dopes, "cursor_4c_Ope", "Dopes")

                loc_lOrigem  = .F.
                loc_lDestino = .F.
                IF cursor_4c_Eest.Emps = go_4c_Sistema.cCodEmpresa
                    IF cursor_4c_Ope.EstOrigs = 4 OR cursor_4c_Ope.Opers = 3
                        IF cursor_4c_Ope.Origems = 1 AND cursor_4c_Eest.GrupoOs = loc_cGrupoProc AND cursor_4c_Eest.ContaOs = loc_cContaProc
                            loc_lOrigem = .T.
                        ELSE
                            IF cursor_4c_Ope.Destinos = 1 AND cursor_4c_Eest.GrupoDs = loc_cGrupoProc AND cursor_4c_Eest.ContaDs = loc_cContaProc
                                loc_lDestino = .T.
                            ENDIF
                        ENDIF
                    ELSE
                        IF cursor_4c_Ope.Origems = 1 AND cursor_4c_Eest.GrupoOs = loc_cGrupoProc AND cursor_4c_Eest.ContaOs = loc_cContaProc
                            IF INLIST(cursor_4c_Ope.EstOrigs, 1, 2)
                                loc_lOrigem = .T.
                            ENDIF
                        ENDIF
                        IF cursor_4c_Ope.Destinos = 1 AND cursor_4c_Eest.GrupoDs = loc_cGrupoProc AND cursor_4c_Eest.ContaDs = loc_cContaProc
                            IF INLIST(cursor_4c_Ope.EstDests, 1, 2)
                                loc_lDestino = .T.
                            ENDIF
                        ENDIF
                    ENDIF
                ELSE
                    IF cursor_4c_Eest.EmpDs = go_4c_Sistema.cCodEmpresa
                        IF cursor_4c_Ope.Destinos = 1 AND cursor_4c_Eest.GrupoDs = loc_cGrupoProc AND cursor_4c_Eest.ContaDs = loc_cContaProc
                            IF INLIST(cursor_4c_Ope.EstDests, 1, 2)
                                loc_lDestino = .T.
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF

                IF !loc_lOrigem AND !loc_lDestino
                    LOOP
                ENDIF

                SELECT cursor_4c_EestI
                SEEK loc_cEdn
                SCAN WHILE EmpDopNums = loc_cEdn
                    = SEEK(cursor_4c_EestI.Cpros, "cursor_4c_Pro", "CPros")

                    loc_cSQL = "SELECT GruEstPs, ConEstPs, nAgMts, TipoEstos, Mercs FROM SigCdGrp WHERE Cgrus = " + EscaparSQL(cursor_4c_Pro.Cgrus)
                    IF USED("cursor_4c_Gru")
                        USE IN cursor_4c_Gru
                    ENDIF
                    = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Gru")
                    loc_cSQL = "SELECT Aplicflhs FROM SigCdGpr WHERE Codigos = " + EscaparSQL(cursor_4c_Gru.Mercs)
                    IF USED("cursor_4c_Ggrp")
                        USE IN cursor_4c_Ggrp
                    ENDIF
                    = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ggrp")

                    loc_cGrupoD   = SPACE(10)
                    loc_cContaD   = SPACE(10)
                    loc_cOperacao = " "

                    IF cursor_4c_Ope.EstOrigs = 4
                        loc_lOrigem  = .F.
                        loc_lDestino = .F.

                        IF cursor_4c_EestI.Opers == "S" AND cursor_4c_Eest.GrupoOs = loc_cGrupoProc AND cursor_4c_Eest.ContaOs = loc_cContaProc
                            loc_lOrigem   = .T.
                            loc_cOperacao = "S"
                            loc_cGrupoD   = cursor_4c_Eest.GrupoDs
                            loc_cContaD   = cursor_4c_Eest.ContaDs
                        ELSE
                            IF cursor_4c_EestI.Opers == "E" AND cursor_4c_Eest.GrupoDs = loc_cGrupoProc AND cursor_4c_Eest.ContaDs = loc_cContaProc
                                loc_lDestino  = .T.
                                loc_cOperacao = "E"
                                loc_cGrupoD   = cursor_4c_Eest.GrupoOs
                                loc_cContaD   = cursor_4c_Eest.ContaOs
                            ENDIF
                        ENDIF
                    ELSE
                        IF cursor_4c_Ope.Opers = 3
                            IF cursor_4c_Ope.Origems = 1
                                IF cursor_4c_EestI.Opers == "S" AND cursor_4c_Eest.GrupoOs = loc_cGrupoProc AND cursor_4c_Eest.ContaOs = loc_cContaProc
                                    loc_lOrigem   = .T.
                                    loc_lDestino  = .F.
                                    loc_cOperacao = "S"
                                    loc_cGrupoD   = cursor_4c_Eest.GrupoOs
                                    loc_cContaD   = cursor_4c_Eest.ContaOs
                                ELSE
                                    IF cursor_4c_EestI.Opers == "E" AND cursor_4c_Eest.GrupoOs = loc_cGrupoProc AND cursor_4c_Eest.ContaOs = loc_cContaProc
                                        loc_lOrigem   = .F.
                                        loc_lDestino  = .T.
                                        loc_cOperacao = "E"
                                        loc_cGrupoD   = cursor_4c_Eest.GrupoOs
                                        loc_cContaD   = cursor_4c_Eest.ContaOs
                                    ENDIF
                                ENDIF
                            ELSE
                                IF cursor_4c_Ope.Destinos = 1
                                    IF cursor_4c_EestI.Opers == "S" AND cursor_4c_Eest.GrupoDs = loc_cGrupoProc AND cursor_4c_Eest.ContaDs = loc_cContaProc
                                        loc_lOrigem   = .T.
                                        loc_cOperacao = "S"
                                        loc_cGrupoD   = cursor_4c_Eest.GrupoDs
                                        loc_cContaD   = cursor_4c_Eest.ContaDs
                                    ELSE
                                        IF cursor_4c_EestI.Opers == "E" AND cursor_4c_Eest.GrupoDs = loc_cGrupoProc AND cursor_4c_Eest.ContaDs = loc_cContaProc
                                            loc_lDestino  = .T.
                                            loc_cOperacao = "E"
                                            loc_cGrupoD   = cursor_4c_Eest.GrupoDs
                                            loc_cContaD   = cursor_4c_Eest.ContaDs
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ELSE
                            IF loc_lOrigem AND cursor_4c_Ope.EstOrigs = 1
                                loc_cOperacao = "E"
                                IF cursor_4c_Ope.Destinos = 1 AND cursor_4c_Ope.EstDests = 2
                                    loc_cGrupoD = cursor_4c_Eest.GrupoDs
                                    loc_cContaD = cursor_4c_Eest.ContaDs
                                ENDIF
                            ELSE
                                IF loc_lOrigem AND cursor_4c_Ope.EstOrigs = 2
                                    loc_cOperacao = "S"
                                    IF cursor_4c_Ope.Destinos = 1 AND cursor_4c_Ope.EstDests = 1
                                        loc_cGrupoD = cursor_4c_Eest.GrupoDs
                                        loc_cContaD = cursor_4c_Eest.ContaDs
                                    ENDIF
                                ELSE
                                    IF loc_lDestino AND cursor_4c_Ope.EstDests = 1
                                        loc_cOperacao = "E"
                                        IF cursor_4c_Ope.Origems = 1 AND cursor_4c_Ope.EstOrigs = 2
                                            loc_cGrupoD = cursor_4c_Eest.GrupoOs
                                            loc_cContaD = cursor_4c_Eest.ContaOs
                                        ENDIF
                                    ELSE
                                        IF loc_lDestino AND cursor_4c_Ope.EstDests = 2
                                            loc_cOperacao = "S"
                                            IF cursor_4c_Ope.Origems = 1 AND cursor_4c_Ope.EstOrigs = 1
                                                loc_cGrupoD = cursor_4c_Eest.GrupoOs
                                                loc_cContaD = cursor_4c_Eest.ContaOs
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF

                    IF INLIST(cursor_4c_Gcr.UnifBals, 3, 4)
                        loc_cMaterial = IIF(EMPTY(cursor_4c_Pro.MatPrincs), cursor_4c_Pam.Ouros, cursor_4c_Pro.MatPrincs)
                    ELSE
                        loc_cMaterial = IIF(cursor_4c_Gcr.UnifBals = 1, cursor_4c_Pam.Ouros, cursor_4c_EestI.Cpros)
                    ENDIF
                    loc_cMatResFa = loc_cMaterial

                    IF cursor_4c_Gcr.UnifBals = 4 AND cursor_4c_EestI.Cpros <> loc_cMaterial
                        LOOP
                    ENDIF

                    loc_cSQL = "SELECT Cunis FROM SigCdUni WHERE Cunis = " + EscaparSQL(cursor_4c_Pro.Cunis)
                    IF USED("cursor_4c_Uni")
                        USE IN cursor_4c_Uni
                    ENDIF
                    = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Uni")

                    SELECT cursor_4c_Esti2
                    SET ORDER TO EmpDopNums
                    IF SEEK(cursor_4c_EestI.EmpDopNums + cursor_4c_EestI.Cpros + STR(cursor_4c_EestI.Citens, 4))
                        SCAN WHILE EmpDopNums + Cpros + STR(Citens, 4) = cursor_4c_EestI.EmpDopNums + cursor_4c_EestI.Cpros + STR(cursor_4c_EestI.Citens, 4)
                            loc_nQtde = cursor_4c_Esti2.Qtds
                            loc_nPeso = cursor_4c_Esti2.Pesos

                            loc_cCodCor = PADR(IIF(INLIST(cursor_4c_Gru.TipoEstos, 2, 4), cursor_4c_Esti2.CodCors, " "), 4)
                            loc_cCodTam = PADR(IIF(INLIST(cursor_4c_Gru.TipoEstos, 3, 4), cursor_4c_Esti2.CodTams, " "), 4)

                            IF loc_lOrigem
                                IF !SEEK(loc_cGrupoProc + loc_cContaProc + cursor_4c_Esti2.CPros + loc_cCodCor + loc_cCodTam, "cursor_4c_Resumo")
                                    INSERT INTO cursor_4c_Resumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel, CodCors, CodTams) ;
                                        VALUES (loc_cGrupoProc, loc_cContaProc, cursor_4c_EestI.CPros, cursor_4c_EestI.CUnis, ;
                                                cursor_4c_Pro.Varias, cursor_4c_Gru.nAgMts, .T., loc_cCodCor, loc_cCodTam)
                                ENDIF

                                SELECT cursor_4c_Resumo
                                IF loc_cOperacao == "E"
                                    REPLACE QtdeEnts  WITH QtdeEnts  + cursor_4c_Esti2.Qtds, ;
                                            PesoEnts  WITH PesoEnts  + loc_nQtde, ;
                                            PesoFabre WITH PesoFabre + loc_nQtde
                                ELSE
                                    REPLACE QtdeSais  WITH QtdeSais  + cursor_4c_Esti2.Qtds, ;
                                            PesoSais  WITH PesoSais  + loc_nQtde, ;
                                            PesoFabrs WITH PesoFabrs + loc_nQtde
                                ENDIF
                                IF !SEEK(loc_cGrupoProc + loc_cContaProc + cursor_4c_EestI.CPros + SPACE(15), "cursor_4c_Opera")
                                    INSERT INTO cursor_4c_Opera (Grupo, Conta, CMats, TpOps, Varias, Agregas, AplicFlhs) ;
                                        VALUES (loc_cGrupoProc, loc_cContaProc, cursor_4c_EestI.CPros, SPACE(15), ;
                                                cursor_4c_Pro.Varias, cursor_4c_Gru.nAgMts, cursor_4c_Ggrp.Aplicflhs)
                                ENDIF
                                SELECT cursor_4c_Opera
                                IF loc_cOperacao == "E"
                                    REPLACE QtdeEnts WITH QtdeEnts + loc_nQtde
                                    REPLACE PesoEnts WITH PesoEnts + loc_nQtde
                                ELSE
                                    REPLACE QtdeSais WITH QtdeSais + loc_nQtde
                                    REPLACE PesoSais WITH PesoSais + loc_nQtde
                                ENDIF
                            ENDIF

                            IF loc_lDestino
                                IF !SEEK(loc_cGrupoProc + loc_cContaProc + cursor_4c_Esti2.CPros + loc_cCodCor + loc_cCodTam, "cursor_4c_Resumo")
                                    INSERT INTO cursor_4c_Resumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel, CodCors, CodTams) ;
                                        VALUES (loc_cGrupoProc, loc_cContaProc, cursor_4c_EestI.CPros, cursor_4c_Pro.CUnis, ;
                                                cursor_4c_Pro.Varias, cursor_4c_Gru.nAgMts, .T., loc_cCodCor, loc_cCodTam)
                                ENDIF

                                SELECT cursor_4c_Resumo
                                IF loc_cOperacao == "E"
                                    REPLACE QtdeEnts  WITH QtdeEnts  + cursor_4c_Esti2.Qtds, ;
                                            PesoEnts  WITH PesoEnts  + loc_nQtde, ;
                                            PesoFabre WITH PesoFabre + loc_nQtde
                                ELSE
                                    REPLACE QtdeSais  WITH QtdeSais  + cursor_4c_Esti2.Qtds, ;
                                            PesoSais  WITH PesoSais  + loc_nQtde, ;
                                            PesoFabrs WITH PesoFabrs + loc_nQtde
                                ENDIF
                            ENDIF
                        ENDSCAN
                    ELSE
                        loc_nQtde = cursor_4c_EestI.Qtds
                        loc_nPeso = cursor_4c_EestI.Pesos

                        IF loc_lOrigem
                            IF !SEEK(loc_cGrupoProc + loc_cContaProc + cursor_4c_EestI.CPros, "cursor_4c_Resumo")
                                INSERT INTO cursor_4c_Resumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel) ;
                                    VALUES (loc_cGrupoProc, loc_cContaProc, cursor_4c_EestI.CPros, cursor_4c_EestI.CUnis, ;
                                            cursor_4c_Pro.Varias, cursor_4c_Gru.nAgMts, .T.)
                            ENDIF

                            SELECT cursor_4c_Resumo
                            IF loc_cOperacao == "E"
                                REPLACE QtdeEnts  WITH QtdeEnts  + cursor_4c_EestI.Qtds, ;
                                        PesoEnts  WITH PesoEnts  + loc_nQtde, ;
                                        PesoFabre WITH PesoFabre + loc_nQtde
                            ELSE
                                REPLACE QtdeSais  WITH QtdeSais  + cursor_4c_EestI.Qtds, ;
                                        PesoSais  WITH PesoSais  + loc_nQtde, ;
                                        PesoFabrs WITH PesoFabrs + loc_nQtde
                            ENDIF
                            IF !SEEK(loc_cGrupoProc + loc_cContaProc + cursor_4c_EestI.CPros + SPACE(15), "cursor_4c_Opera")
                                INSERT INTO cursor_4c_Opera (Grupo, Conta, CMats, TpOps, AplicFlhs) ;
                                    VALUES (loc_cGrupoProc, loc_cContaProc, cursor_4c_EestI.CPros, SPACE(15), cursor_4c_Ggrp.Aplicflhs)
                            ENDIF
                            SELECT cursor_4c_Opera
                            IF loc_cOperacao == "E"
                                REPLACE QtdeEnts WITH QtdeEnts + loc_nQtde
                                REPLACE PesoEnts WITH PesoEnts + loc_nQtde
                            ELSE
                                REPLACE QtdeSais WITH QtdeSais + loc_nQtde
                                REPLACE PesoSais WITH PesoSais + loc_nQtde
                            ENDIF
                        ENDIF

                        IF loc_lDestino
                            IF !SEEK(loc_cGrupoProc + loc_cContaProc + cursor_4c_EestI.CPros, "cursor_4c_Resumo")
                                INSERT INTO cursor_4c_Resumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel) ;
                                    VALUES (loc_cGrupoProc, loc_cContaProc, cursor_4c_EestI.CPros, cursor_4c_Pro.CUnis, ;
                                            cursor_4c_Pro.Varias, cursor_4c_Gru.nAgMts, .T.)
                            ENDIF

                            SELECT cursor_4c_Resumo
                            IF loc_cOperacao == "E"
                                REPLACE QtdeEnts  WITH QtdeEnts  + cursor_4c_EestI.Qtds, ;
                                        PesoEnts  WITH PesoEnts  + loc_nQtde, ;
                                        PesoFabre WITH PesoFabre + loc_nQtde
                            ELSE
                                REPLACE QtdeSais  WITH QtdeSais  + cursor_4c_EestI.Qtds, ;
                                        PesoSais  WITH PesoSais  + loc_nQtde, ;
                                        PesoFabrs WITH PesoFabrs + loc_nQtde
                            ENDIF
                            IF !SEEK(loc_cGrupoProc + loc_cContaProc + cursor_4c_EestI.CPros + SPACE(15), "cursor_4c_Opera")
                                INSERT INTO cursor_4c_Opera (Grupo, Conta, CMats, TpOps, Varias, Agregas, AplicFlhs) ;
                                    VALUES (loc_cGrupoProc, loc_cContaProc, cursor_4c_EestI.CPros, SPACE(15), ;
                                            cursor_4c_Pro.Varias, cursor_4c_Gru.nAgMts, cursor_4c_Ggrp.Aplicflhs)
                            ENDIF
                            SELECT cursor_4c_Opera
                            IF loc_cOperacao == "E"
                                REPLACE QtdeEnts WITH QtdeEnts + loc_nQtde
                                REPLACE PesoEnts WITH PesoEnts + loc_nQtde
                            ELSE
                                REPLACE QtdeSais WITH QtdeSais + loc_nQtde
                                REPLACE PesoSais WITH PesoSais + loc_nQtde
                            ENDIF
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDSCAN
            IF VARTYPE(loc_oBarra) = "O"
                loc_oBarra.Complete()
            ENDIF

            loc_cSQL = "SELECT Emps, Codigos FROM SigCdPsc WHERE Emps = " + EscaparSQL(PADR(go_4c_Sistema.cCodEmpresa, 3)) + ;
                " AND Grupos = " + EscaparSQL(loc_cGrupoProc) + " AND Contas = " + EscaparSQL(loc_cContaProc) + ;
                " AND Datas >= ?loc_dPDat AND ProcBals = ?loc_lFalse ORDER BY Emps, Codigos"

            IF USED("cursor_4c_Pesa")
                USE IN cursor_4c_Pesa
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pesa") < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (cursor_4c_Pesa)"
                RETURN .F.
            ENDIF

            SELECT cursor_4c_Pesa
            SCAN
                loc_cSQL = "SELECT CPros, Qtds FROM SigCdPsi WHERE Emps = " + EscaparSQL(cursor_4c_Pesa.Emps) + ;
                    " AND Codigos = " + FormatarNumeroSQL(cursor_4c_Pesa.Codigos, 0) + " ORDER BY CPros"

                IF USED("cursor_4c_PesaI")
                    USE IN cursor_4c_PesaI
                ENDIF
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PesaI") < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (cursor_4c_PesaI)"
                    RETURN .F.
                ENDIF

                SELECT cursor_4c_PesaI
                SCAN
                    = SEEK(cursor_4c_PesaI.CPros, "cursor_4c_Pro", "CPros")
                    loc_cSQL = "SELECT GruEstPs, ConEstPs, nAgMts, TipoEstos, Mercs FROM SigCdGrp WHERE Cgrus = " + EscaparSQL(cursor_4c_Pro.Cgrus)
                    IF USED("cursor_4c_Gru")
                        USE IN cursor_4c_Gru
                    ENDIF
                    = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Gru")
                    loc_cSQL = "SELECT Aplicflhs FROM SigCdGpr WHERE Codigos = " + EscaparSQL(cursor_4c_Gru.Mercs)
                    IF USED("cursor_4c_Ggrp")
                        USE IN cursor_4c_Ggrp
                    ENDIF
                    = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ggrp")

                    IF !SEEK(loc_cGrupoProc + loc_cContaProc + cursor_4c_PesaI.CPros, "cursor_4c_Resumo")
                        INSERT INTO cursor_4c_Resumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel) ;
                            VALUES (loc_cGrupoProc, loc_cContaProc, cursor_4c_PesaI.CPros, cursor_4c_Pro.CUnis, cursor_4c_Pro.Varias, cursor_4c_Gru.nAgMts, .T.)
                    ENDIF
                    SELECT cursor_4c_Resumo
                    REPLACE Pesagem WITH cursor_4c_Resumo.Pesagem + cursor_4c_PesaI.Qtds IN cursor_4c_Resumo
                ENDSCAN
            ENDSCAN

            SELECT cursor_4c_Resumo
            REPLACE Flag3 WITH .T. FOR Grupo + Conta = loc_cGrupoProc + loc_cContaProc

            SELECT cursor_4c_Opera
            REPLACE PesoBEnts WITH PesoEnts, ;
                    PesoBSais WITH PesoSais, ;
                    QtdeBEnts WITH QtdeEnts, ;
                    QtdeBSais WITH QtdeSais FOR Grupo + Conta = loc_cGrupoProc + loc_cContaProc

            IF cursor_4c_Gcr.UnifBals = 1
                loc_cMat = cursor_4c_Pam.Ouros
                SELECT cursor_4c_Resumo
                IF !SEEK(loc_cGrupoProc + loc_cContaProc + loc_cMat)
                    APPEND BLANK
                    REPLACE cmats   WITH loc_cMat, ;
                            Grupo   WITH loc_cGrupoProc, ;
                            conta   WITH loc_cContaProc, ;
                            Visivel WITH .T.
                ENDIF

                SELECT "" AS Agrupar, SUM(PesoEnts) AS pEnts, SUM(PesoSais) AS pSais ;
                    FROM cursor_4c_Resumo ;
                    WHERE Grupo + Conta = loc_cGrupoProc + loc_cContaProc AND Cmats <> loc_cMat AND Varias <> 1 AND Agregas <> 1 ;
                    INTO CURSOR cursor_4c_Total GROUP BY 1
                GO TOP IN cursor_4c_Total

                SELECT cursor_4c_Resumo
                = SEEK(loc_cGrupoProc + loc_cContaProc)
                SCAN WHILE Grupo + Conta = loc_cGrupoProc + loc_cContaProc
                    IF Cmats = loc_cMat
                        REPLACE PesoEnts WITH PesoEnts + cursor_4c_Total.pEnts
                        REPLACE PesoSais WITH PesoSais + cursor_4c_Total.pSais
                        REPLACE QtdeEnts WITH QtdeEnts + cursor_4c_Total.pEnts
                        REPLACE QtdeSais WITH QtdeSais + cursor_4c_Total.pSais
                    ELSE
                        IF Agregas <> 1
                            REPLACE Visivel WITH .F., ;
                                    Flag3   WITH .F.
                        ENDIF
                    ENDIF
                ENDSCAN

                SELECT Grupo, Conta, TpOps, SUM(PesoEnts) AS pEnts, SUM(PesoSais) AS pSais ;
                    FROM cursor_4c_Opera ;
                    WHERE Grupo + Conta = loc_cGrupoProc + loc_cContaProc AND Cmats <> loc_cMat AND Varias <> 1 AND Agregas <> 1 ;
                    GROUP BY Grupo, Conta, TpOps ;
                    INTO CURSOR cursor_4c_Total

                SELECT cursor_4c_Total
                SCAN
                    IF !SEEK(cursor_4c_Total.Grupo + cursor_4c_Total.Conta + loc_cMat + cursor_4c_Total.TpOps, "cursor_4c_Opera")
                        INSERT INTO cursor_4c_Opera (Grupo, Conta, CMats, TpOps, AplicFlhs) ;
                            VALUES (cursor_4c_Total.Grupo, cursor_4c_Total.Conta, loc_cMat, cursor_4c_Total.TpOps, 1)
                    ENDIF
                    REPLACE cursor_4c_Opera.PesoEnts WITH cursor_4c_Opera.PesoEnts + cursor_4c_Total.pEnts IN cursor_4c_Opera
                    REPLACE cursor_4c_Opera.PesoSais WITH cursor_4c_Opera.PesoSais + cursor_4c_Total.pSais IN cursor_4c_Opera
                    REPLACE cursor_4c_Opera.QtdeEnts WITH cursor_4c_Opera.QtdeEnts + cursor_4c_Total.pEnts IN cursor_4c_Opera
                    REPLACE cursor_4c_Opera.QtdeSais WITH cursor_4c_Opera.QtdeSais + cursor_4c_Total.pSais IN cursor_4c_Opera
                ENDSCAN

                SELECT Grupo, Conta, TpOps, SUM(PesoEnts) AS pEnts, SUM(PesoSais) AS pSais ;
                    FROM cursor_4c_Opera ;
                    WHERE Grupo + Conta = loc_cGrupoProc + loc_cContaProc AND Cmats <> loc_cMat AND Varias <> 1 AND Agregas <> 1 AND AplicFlhs <> 2 ;
                    GROUP BY Grupo, Conta, TpOps ;
                    INTO CURSOR cursor_4c_Total

                SELECT cursor_4c_Total
                SCAN
                    IF SEEK(cursor_4c_Total.Grupo + cursor_4c_Total.Conta + loc_cMat + cursor_4c_Total.TpOps, "cursor_4c_Opera")
                        REPLACE cursor_4c_Opera.PesoBEnts WITH cursor_4c_Opera.PesoBEnts + cursor_4c_Total.pEnts IN cursor_4c_Opera
                        REPLACE cursor_4c_Opera.PesoBSais WITH cursor_4c_Opera.PesoBSais + cursor_4c_Total.pSais IN cursor_4c_Opera
                        REPLACE cursor_4c_Opera.QtdeBEnts WITH cursor_4c_Opera.QtdeBEnts + cursor_4c_Total.pEnts IN cursor_4c_Opera
                        REPLACE cursor_4c_Opera.QtdeBSais WITH cursor_4c_Opera.QtdeBSais + cursor_4c_Total.pSais IN cursor_4c_Opera
                    ENDIF
                ENDSCAN
            ENDIF

            *-- Buscar Saldo Anterior (SigCdFcx/SigOpCfe)
            loc_cSQL = "SELECT Codigos FROM SigCdFcx WHERE Emps = " + EscaparSQL(PADR(go_4c_Sistema.cCodEmpresa, 3)) + ;
                " AND Grupos = " + EscaparSQL(loc_cGrupoProc) + " AND Contas = " + EscaparSQL(loc_cContaProc) + " ORDER BY Codigos"

            IF USED("cursor_4c_UltBal")
                USE IN cursor_4c_UltBal
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UltBal") < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (cursor_4c_UltBal)"
                RETURN .F.
            ENDIF
            SELECT cursor_4c_UltBal
            GO BOTTOM
            IF RECCOUNT() > 0
                loc_cSQL = "SELECT * FROM SigOpCfe WHERE Codigos = " + FormatarNumeroSQL(cursor_4c_UltBal.Codigos, 0) + ;
                    " AND Emps = " + EscaparSQL(PADR(go_4c_Sistema.cCodEmpresa, 3)) + " ORDER BY Codigos, cpros"
            ELSE
                loc_cSQL = "SELECT * FROM SigOpCfe WHERE 0 = 1"
            ENDIF
            IF USED("cursor_4c_SaldoI")
                USE IN cursor_4c_SaldoI
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SaldoI") < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (cursor_4c_SaldoI)"
                RETURN .F.
            ENDIF

            SELECT cursor_4c_SaldoI
            INDEX ON Cpros TAG Cpros

            SELECT cursor_4c_Resumo
            loc_oBarra = CREATEOBJECT("fwprogressbar", "Preparando Resumos", RECCOUNT("cursor_4c_Resumo"))
            IF VARTYPE(loc_oBarra) = "O"
                loc_oBarra.Top = loc_oBarra.Top + INT(loc_oBarra.Height / 2)
                loc_oBarra.Show()
            ENDIF
            loc_cMatCorrente = SPACE(10)
            SET ORDER TO GrConMat
            = SEEK(loc_cGrupoProc + loc_cContaProc)
            SCAN WHILE Grupo + Conta = loc_cGrupoProc + loc_cContaProc
                IF VARTYPE(loc_oBarra) = "O"
                    loc_oBarra.Update(.T.)
                ENDIF
                STORE 0 TO loc_nSaldoI, loc_nSaidas, loc_nPesagem

                = SEEK(cursor_4c_Resumo.CMats, "cursor_4c_Pro", "CPros")
                IF !loc_lTipoQ AND cursor_4c_Resumo.Cmats <> loc_cMatCorrente
                    STORE 0 TO loc_nFalhaAdmitida
                    loc_cMatCorrente = cursor_4c_Resumo.cmats
                ENDIF

                SELECT cursor_4c_SaldoI
                = SEEK(cursor_4c_Resumo.Cmats)
                loc_nSaldoI = cursor_4c_SaldoI.Pesagems

                SELECT cursor_4c_Opera
                = SEEK(cursor_4c_Resumo.Grupo + cursor_4c_Resumo.Conta + cursor_4c_Resumo.CMats)
                loc_nTrabalhado = 0
                SCAN WHILE Grupo + Conta + Cmats = cursor_4c_Resumo.Grupo + cursor_4c_Resumo.Conta + cursor_4c_Resumo.Cmats
                    = SEEK(cursor_4c_Opera.TpOps, "cursor_4c_OpOpt", "Cods")

                    IF (cursor_4c_OpOpt.PFalhas <> 0 AND cursor_4c_Pro.Varias = 1 AND cursor_4c_OpOpt.TFalhas <> "Q" AND ;
                            cursor_4c_Opera.AplicFlhs <> 2) AND !THIS.this_lNaoChecarFalha
                        loc_nFalhaAdmitida = loc_nFalhaAdmitida + ROUND(cursor_4c_Opera.QtdeBSais * cursor_4c_OpOpt.PFalhas / 100, 3)
                        REPLACE PFalha WITH cursor_4c_OpOpt.PFalhas, ;
                                Falha  WITH ROUND(cursor_4c_Opera.QtdeBSais * cursor_4c_OpOpt.PFalhas / 100, 3) IN cursor_4c_Opera
                    ENDIF

                    IF cursor_4c_OpOpt.Trabas = 1 OR EMPTY(cursor_4c_Opera.TpOps)
                        loc_nTrabalhado = loc_nTrabalhado + cursor_4c_Opera.QtdeSais
                    ENDIF
                ENDSCAN

                SELECT cursor_4c_Resumo
                REPLACE Saldoi  WITH loc_nSaldoI, ;
                        FReal   WITH loc_nSaldoI + cursor_4c_Resumo.QtdeEnts - cursor_4c_Resumo.QtdeSais - cursor_4c_Resumo.Pesagem, ;
                        FAdmin  WITH loc_nFalhaAdmitida, ;
                        Saldof  WITH loc_nSaldoI + cursor_4c_Resumo.QtdeEnts - cursor_4c_Resumo.QtdeSais - cursor_4c_Resumo.Pesagem - loc_nFalhaAdmitida, ;
                        PfTrabs WITH IIF(loc_nTrabalhado <> 0, (Saldof / loc_nTrabalhado * 100), 0)

                IF cursor_4c_Resumo.Saldof <> 0 AND (cursor_4c_CliDet.PagFals = 1 OR cursor_4c_CliDet.RecFals = 1)
                    REPLACE Flag  WITH .T., ;
                            Flag2 WITH (cursor_4c_CliDet.PagFals = 1 OR cursor_4c_CliDet.RecFals = 1) IN cursor_4c_Resumo
                ENDIF
            ENDSCAN
            IF VARTYPE(loc_oBarra) = "O"
                loc_oBarra.Complete()
            ENDIF

            SELECT cursor_4c_SaldoI
            loc_oBarra = CREATEOBJECT("fwprogressbar", "Preparando Resumos", RECCOUNT("cursor_4c_SaldoI"))
            IF VARTYPE(loc_oBarra) = "O"
                loc_oBarra.Top = loc_oBarra.Top + INT(loc_oBarra.Height / 2)
                loc_oBarra.Show()
            ENDIF
            loc_cMatCorrente = SPACE(10)
            SCAN
                IF VARTYPE(loc_oBarra) = "O"
                    loc_oBarra.Update(.T.)
                ENDIF
                IF cursor_4c_SaldoI.Pesagems = 0
                    LOOP
                ENDIF
                = SEEK(cursor_4c_SaldoI.Cpros, "cursor_4c_Pro", "CPros")
                loc_cSQL = "SELECT GruEstPs, ConEstPs, nAgMts, TipoEstos, Mercs FROM SigCdGrp WHERE Cgrus = " + EscaparSQL(cursor_4c_Pro.Cgrus)
                IF USED("cursor_4c_Gru")
                    USE IN cursor_4c_Gru
                ENDIF
                = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Gru")

                loc_nSaldoI = cursor_4c_SaldoI.Pesagems

                SELECT cursor_4c_Resumo
                LOCATE FOR Grupo + Conta + cMats = loc_cGrupoProc + loc_cContaProc + cursor_4c_SaldoI.Cpros
                IF EOF()
                    *-- Transcricao LITERAL do legado (regra #17): a linha
                    *-- original usa LocalNens.GrupoOs/ContaOs aqui, nao
                    *-- _Grupo/_Conta - aparenta ser um residuo do cursor da
                    *-- SCAN de producao (bug latente do legado), mas a
                    *-- regra exige nao "corrigir" sem confirmacao.
                    INSERT INTO cursor_4c_Resumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel) ;
                        VALUES (cursor_4c_Nens.GrupoOs, cursor_4c_Nens.ContaOs, cursor_4c_SaldoI.Cpros, ;
                                cursor_4c_Pro.CUnis, cursor_4c_Pro.Varias, cursor_4c_Gru.nAgMts, .T.)

                    SELECT cursor_4c_Resumo
                    REPLACE Saldoi  WITH loc_nSaldoI, ;
                            FReal   WITH loc_nSaldoI + cursor_4c_Resumo.QtdeEnts - cursor_4c_Resumo.QtdeSais - cursor_4c_Resumo.Pesagem, ;
                            FAdmin  WITH 0, ;
                            Saldof  WITH loc_nSaldoI + cursor_4c_Resumo.QtdeEnts - cursor_4c_Resumo.QtdeSais - cursor_4c_Resumo.Pesagem - 0, ;
                            PfTrabs WITH 0
                ENDIF
            ENDSCAN
            IF VARTYPE(loc_oBarra) = "O"
                loc_oBarra.Complete()
            ENDIF
        ENDSCAN
        IF VARTYPE(loc_oBarraP) = "O"
            loc_oBarraP.Complete()
        ENDIF

        *-- Agregacao final: soma Saldof de cursor_4c_Resumo em cursor_4c_Saldo,
        *-- por Fase+Codigo+Material (legado: Select TmpSaldo / Scan / Seek
        *-- TmpSaldo.Fase + TmpSaldo.Codigo + lcCodMat em TmpResumo).
        SELECT cursor_4c_Saldo
        SCAN
            SELECT cursor_4c_Resumo
            = SEEK(cursor_4c_Saldo.Fase + cursor_4c_Saldo.Codigo + loc_cCodMat)
            SCAN WHILE Grupo + Conta + cMats = (cursor_4c_Saldo.Fase + cursor_4c_Saldo.Codigo + loc_cCodMat)
                REPLACE Saldo WITH Saldo + cursor_4c_Resumo.Saldof IN cursor_4c_Saldo
            ENDSCAN
        ENDSCAN

        SELECT cursor_4c_Saldo
        IF THIS.this_lNaoMostrarSaldosZerados
            DELETE FOR Saldo = 0
        ENDIF
        SET ORDER TO TAG Codigo
        GO TOP
        IF EOF()
            THIS.this_nQtdeRegistros = 0
            THIS.this_cMensagemErro = "Nenhum Saldo Selecionado!!!"
            RETURN .F.
        ENDIF

        *-- Quantidade apurada (this_nQtdeRegistros): o legado nao precisa dela
        *-- porque le TmpSaldo direto da tela; aqui ela eh o unico retorno
        *-- quantitativo do processamento para o Form (BOParaForm). COUNT sobre
        *-- o alias ja SELECIONADO (nao existe clausula IN em COUNT) e GO TOP
        *-- de volta depois, para a grade abrir na primeira linha como no legado.
        COUNT TO loc_nQtdeSaldo
        GO TOP
        THIS.this_nQtdeRegistros = loc_nQtdeSaldo

        RETURN .T.
    ENDPROC

    *==========================================================================
    * LimparDados - Hook de BusinessBase ("Subclasses devem limpar suas
    * propriedades especificas"): devolve os filtros e o estado do resultado
    * aos valores iniciais. Chamado por FormSIGOPCFE.LimparCampos(), que em
    * seguida espelha o BO de volta na tela com BOParaForm().
    *
    * Mantido PUBLIC (como em BusinessBase - regra #51): o Form chama este
    * metodo de FORA da classe.
    *==========================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cMaterial     = ""
        THIS.this_cDescMaterial = ""
        THIS.this_cGrupo        = ""
        THIS.this_cDescGrupo    = ""
        THIS.this_cConta        = ""
        THIS.this_cDescConta    = ""

        THIS.this_lNaoMostrarSaldosZerados = .F.
        THIS.this_lNaoChecarFalha          = .F.

        THIS.this_nQtdeRegistros = 0

        THIS.this_cCodigoSaldo   = ""
        THIS.this_cNomeSaldo     = ""
        THIS.this_cFaseSaldo     = ""
        THIS.this_nSaldoValor    = 0
        THIS.this_dUltimoBalanco = {}
    ENDPROC

    *==========================================================================
    * ObterDescricaoEmpresa - CursorQuery('SigCdEmp','crSigCdEmp','Cemps',
    * _Empr,'Razas') do metodo Impress" + CHR(227) + "o legado.
    *==========================================================================
    PROCEDURE ObterDescricaoEmpresa()
        LOCAL loc_cSQL, loc_nResultado, loc_cDescricao, loc_oErro

        loc_cDescricao = ""

        TRY
            loc_cSQL = "SELECT Razas FROM SigCdEmp WHERE Cemps = " + ;
                EscaparSQL(PADR(ALLTRIM(go_4c_Sistema.cCodEmpresa), 3))

            IF USED(THIS.this_cCursorEmpresa)
                USE IN (THIS.this_cCursorEmpresa)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorEmpresa)

            IF loc_nResultado >= 1 AND RECCOUNT(THIS.this_cCursorEmpresa) > 0
                loc_cDescricao = ALLTRIM(TratarNulo(EVALUATE(THIS.this_cCursorEmpresa + ".Razas"), ""))
            ENDIF
        CATCH TO loc_oErro
            loc_cDescricao = ""
        ENDTRY

        IF USED(THIS.this_cCursorEmpresa)
            USE IN (THIS.this_cCursorEmpresa)
        ENDIF

        RETURN loc_cDescricao
    ENDPROC

    *==========================================================================
    * MontarCursorCabecalho - transcricao do bloco de cabecalho do metodo
    * "Impress" + CHR(227) + "o" do legado:
    *   Create Cursor TmpCabec (Titulo c(100), SubTitulo c(100), Empresa c(100))
    *   lcTitulo = 'Saldos Por Funcion' + CHR(225) + "rio"
    *   lcSubTitulo = 'Material : ' + ... + ' - ' + ...
    *   Insert Into TmpCabec (Empresa, Titulo, SubTitulo) Values (...)
    *==========================================================================
    PROCEDURE MontarCursorCabecalho()
        LOCAL loc_lSucesso, loc_cTitulo, loc_cSubTitulo, loc_cEmpresa, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorCabecalho)
                USE IN (THIS.this_cCursorCabecalho)
            ENDIF

            CREATE CURSOR (THIS.this_cCursorCabecalho) ;
                (Titulo C(100), SubTitulo C(100), Empresa C(100))

            loc_cTitulo = "Saldos Por Funcion" + CHR(225) + "rio"

            loc_cSubTitulo = "Material : " + ALLTRIM(TratarNulo(THIS.this_cMaterial, "")) + " - " + ;
                ALLTRIM(TratarNulo(THIS.this_cDescMaterial, ""))

            loc_cEmpresa = THIS.ObterDescricaoEmpresa()

            INSERT INTO (THIS.this_cCursorCabecalho) (Empresa, Titulo, SubTitulo) ;
                VALUES (LEFT(loc_cEmpresa, 100), LEFT(loc_cTitulo, 100), LEFT(loc_cSubTitulo, 100))

            GO TOP IN (THIS.this_cCursorCabecalho)
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarReportForm - dispara o REPORT FORM com o isolamento de locale/
    * REPORTBEHAVIOR e a restauracao de menu do padrao canonico do projeto
    * (ver SigOpCfaBO/SigReCgcBO.ExecutarReportForm). par_cModo: "PREVIEW"
    * (legado lcSaida='V') ou "PRINTER_PROMPT" (legado lcSaida='I').
    *==========================================================================
    PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo)
        LOCAL loc_cFRX, loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig

        loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")

        IF NOT FILE(loc_cFRX)
            MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + ;
                loc_cFRX, "Erro")
            RETURN .F.
        ENDIF

        loc_cPointOrig    = SET("POINT")
        loc_cSepOrig      = SET("SEPARATOR")
        loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
        SET POINT TO "."
        SET SEPARATOR TO ","
        SET REPORTBEHAVIOR 80

        DO CASE
            CASE par_cModo == "PREVIEW"
                REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
            CASE par_cModo == "PRINTER_PROMPT"
                REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
        ENDCASE

        SET POINT TO (loc_cPointOrig)
        SET SEPARATOR TO (loc_cSepOrig)
        SET REPORTBEHAVIOR (loc_nBehaviorOrig)

        *-- Restaurar menu apos preview (Erro63): REPORT FORM PREVIEW abre
        *-- toolbar propria que corrompe o cache visual do _MSYSMENU.
        TRY
            SET SYSMENU TO DEFAULT
            RELEASE POPUP popArquivo, popCadastros, popMovimentos, popRelatorios, popFerramentas, popAjuda
            CriarMenuPrincipal()
        CATCH
            *-- CriarMenuPrincipal fora do escopo (teste automatizado) - silencioso
        ENDTRY

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ExibirRelatorio - equivalente ao bloco final do metodo "Impress" +
    * CHR(227) + "o" do legado: monta TmpCabec, confere "Set Order to
    * Impressao / Go Top / If Eof()" em cursor_4c_Saldo e dispara o
    * SigOpCfe.frx (Preview ou To Printer Prompt conforme par_cSaida).
    *==========================================================================
    PROCEDURE ExibirRelatorio(par_cSaida)
        LOCAL loc_lSucesso, loc_cModo, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF !THIS.MontarCursorCabecalho()
                loc_lSucesso = .F.
            ELSE
                IF !USED("cursor_4c_Saldo")
                    THIS.this_cMensagemErro = "Nenhuma Informa" + CHR(231) + CHR(227) + "o Selecionada!!!"
                ELSE
                    SELECT cursor_4c_Saldo
                    SET ORDER TO TAG Impressao
                    GO TOP

                    IF EOF()
                        THIS.this_cMensagemErro = "Nenhuma Informa" + CHR(231) + CHR(227) + "o Selecionada!!!"
                    ELSE
                        loc_cModo    = IIF(par_cSaida == "V", "PREVIEW", "PRINTER_PROMPT")
                        loc_lSucesso = THIS.ExecutarReportForm("SigOpCfe", loc_cModo)
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        IF USED(THIS.this_cCursorCabecalho)
            USE IN (THIS.this_cCursorCabecalho)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
