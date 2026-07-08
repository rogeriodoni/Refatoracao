*==============================================================================
* SigPrGlxBO.prg - Business Object: Previa da Globalizacao
* Data: 2026-07-03
* Tipo: OPERACIONAL
* Funcao: Gerencia logica de negocio da previa de globalizacao/reserva automatica.
*          Recebe parametros do form pai (SigGlb ou equivalente), opera sobre
*          cursores TmpFinalg/TmpFinal/TmpSaldG/TmpFabr pre-populados pelo pai.
*          Executa processamento de OPs, reservas e requisicoes de material.
*==============================================================================

DEFINE CLASS SigPrGlxBO AS BusinessBase

    *-- Parametros operacionais (recebidos via Form.Init do form pai)
    this_lReserva    = .F.    && .T. = previa de reserva automatica; .F. = previa de globalizacao
    this_nEmphPdr    = 0      && enfase padrao para geracao de OPs (1 = gerar empenhos)
    this_lAutomatico = .F.    && .T. = modo automatico (sem intervencao do usuario)
    this_nNumeroOp   = 0      && numero da OP especifica (0 = sem restricao)
    this_lPorDestino = .F.    && .T. = usar grupo/conta de destino do cabecalho do movimento
    this_cSigKey     = ""     && chave de assinatura digital (SigCdPac.sigKeys)
    this_dDataRef    = {}     && data de referencia para o processamento (geracao)

    *-- Estado de edicao nas grades (equivalentes a ThisForm.Liberado/OldValue/AntValue)
    this_lLiberado   = .F.    && .T. = coluna "Produzir Estq" liberada para edicao
    this_nOldValue   = 0      && valor anterior da celula editavel em GradeItens
    this_nAntValue   = 0      && valor anterior da celula editavel em GradePedra (Page6)

    *-- Campos do cursor TmpFinalg (carregados via CarregarDoCursor)
    this_cCpros      = ""     && codigo do produto
    this_cCodCors    = ""     && codigo da cor
    this_cCodTams    = ""     && codigo do tamanho
    this_nSaldo      = 0      && saldo disponivel
    this_nFabrs      = 0      && quantidade em fabricacao
    this_nEstoque    = 0      && quantidade em estoque
    this_nProduzir   = 0      && quantidade a produzir (editavel pelo usuario)
    this_nProduzir2  = 0      && quantidade a produzir ajustada
    this_nQtds       = 0      && quantidade total
    this_cFlag       = ""     && flag de controle
    this_cUsuLibs    = ""     && usuario autorizador da liberacao
    this_nQtdMins    = 0      && quantidade minima de producao
    this_cLinhas     = ""     && codigo da linha de producao

    *-- Estado de processamento (uso interno de ProcessarGlobalizacao)
    this_nNume       = 0      && numero do movimento gerado (SigMvCab.Numes)
    this_nRnop       = 0      && numero da OP de reserva
    this_dPrevisao   = {}     && data de previsao de entrega (form pai GetPrevisao)

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir do registro atual de TmpFinalg
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED("TmpFinalg") AND !EOF("TmpFinalg")
                THIS.this_cCpros     = TmpFinalg.Cpros
                THIS.this_cCodCors   = TmpFinalg.CodCors
                THIS.this_cCodTams   = TmpFinalg.CodTams
                THIS.this_nSaldo     = TmpFinalg.Saldo
                THIS.this_nFabrs     = TmpFinalg.Fabrs
                THIS.this_nEstoque   = TmpFinalg.Estoque
                THIS.this_nProduzir  = TmpFinalg.Produzir
                THIS.this_nProduzir2 = TmpFinalg.Produzir2
                THIS.this_nQtds      = TmpFinalg.Qtds
                THIS.this_cFlag      = TmpFinalg.Flag
                THIS.this_cUsuLibs   = TmpFinalg.UsuLibs
                THIS.this_nQtdMins   = TmpFinalg.QtdMins
                THIS.this_cLinhas    = TmpFinalg.Linhas
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave composta do produto atual
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCpros) + ALLTRIM(THIS.this_cCodCors) + ALLTRIM(THIS.this_cCodTams)
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida pre-requisitos antes do processamento
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        IF !USED("TmpFinalg")
            THIS.this_cMensagemErro = "Cursor TmpFinalg n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF
        IF !USED("TmpFinal")
            THIS.this_cMensagemErro = "Cursor TmpFinal n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF
        IF !USED("TmpSaldG")
            THIS.this_cMensagemErro = "Cursor TmpSaldG n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF
        IF !USED("TmpFabr")
            THIS.this_cMensagemErro = "Cursor TmpFabr n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Processar - Metodo publico: executa globalizacao/reserva automatica
    * Chamado pelo Form.Processar.Click equivalente
    *--------------------------------------------------------------------------
    PROCEDURE Processar()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF THIS.ValidarDados()
                loc_lResultado = THIS.Inserir()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Delega para ProcessarGlobalizacao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        RETURN THIS.ProcessarGlobalizacao()
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza quantidade Produzir2 no cursor TmpFinalg
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED("TmpFinalg") AND !EOF("TmpFinalg")
                REPLACE TmpFinalg.Produzir2 WITH THIS.this_nProduzir2
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Stub: previa nao suporta exclusao direta
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        THIS.this_cMensagemErro = "Pr" + CHR(233) + "via n" + CHR(227) + "o suporta exclus" + CHR(227) + "o direta"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao no log de auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSql, loc_cChave, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cChave = THIS.ObterChavePrimaria()
            IF !EMPTY(loc_cChave)
                loc_cSql = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, Usuario, DataHora) VALUES (" + ;
                           "'SigPdMvf', " + ;
                           EscaparSQL(par_cOperacao) + ", " + ;
                           EscaparSQL(loc_cChave) + ", " + ;
                           EscaparSQL(gc_4c_UsuarioLogado) + ", GETDATE())"
                SQLEXEC(gnConnHandle, loc_cSql)
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarGlobalizacao - Orquestrador principal
    * Equivalente ao Processar.Click do legado (~1903 linhas)
    * Modos: !this_lReserva = Globalizacao com OPs; this_lReserva = Reserva Automatica
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarGlobalizacao()
        LOCAL loc_cDopp, loc_cDope, loc_cDopEst, loc_nNump, loc_nRnop
        LOCAL loc_nNume, loc_cEmpr, loc_cUsuar, loc_dDtGera, loc_dPrev
        LOCAL loc_lErro, loc_cSql, loc_lResultado
        LOCAL loc_cGrupoOrig, loc_cContaOrig, loc_cGrupoDest, loc_cContaDest
        LOCAL loc_cObsSigMv, loc_cEmpDopNum

        loc_lResultado = .F.
        loc_lErro      = .F.

        TRY
            loc_cEmpr   = go_4c_Sistema.cCodEmpresa
            loc_cUsuar  = gc_4c_UsuarioLogado
            loc_dDtGera = THIS.this_dDataRef
            loc_dPrev   = THIS.this_dPrevisao
            IF EMPTY(loc_dDtGera)
                loc_dDtGera = DATE()
            ENDIF
            IF EMPTY(loc_dPrev)
                loc_dPrev = DATE()
            ENDIF

            *-- Carregar configuracoes do sistema
            IF THIS.SqlExecute("SELECT * FROM SigCdPam", "crSigCdPam_4c") <= 0
                MsgErro("Falha ao carregar SigCdPam", "Erro")
                loc_lResultado = .F.
            ENDIF
            IF THIS.SqlExecute("SELECT * FROM SigCdPac", "crSigCdPac_4c") <= 0
                MsgErro("Falha ao carregar SigCdPac", "Erro")
                loc_lResultado = .F.
            ENDIF
            IF THIS.SqlExecute("SELECT * FROM DbParam", "crDbParam_4c") <= 0
                MsgErro("Falha ao carregar DbParam", "Erro")
                loc_lResultado = .F.
            ENDIF
            IF THIS.SqlExecute("SELECT * FROM SigCdCom", "crSigCdCom_4c") <= 0
                MsgErro("Falha ao carregar SigCdCom", "Erro")
                loc_lResultado = .F.
            ENDIF

            SELECT crSigCdPam_4c
            loc_cDopp = ALLTRIM(crSigCdPam_4c.DoppPads)
            loc_cDope = ALLTRIM(crSigCdPam_4c.TransfRes)
            SELECT crSigCdPac_4c
            loc_cDopEst = ALLTRIM(crSigCdPac_4c.dopEsts)

            IF THIS.CursorQuery("SigCdOpd", "crSigCdOpd_4c", "Dopps", loc_cDopp) <= 0
                MsgErro("Opera" + CHR(231) + CHR(227) + "o de produ" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada: " + loc_cDopp, "Erro")
                loc_lResultado = .F.
            ENDIF

            *-- Gerar numero da OP ou da reserva
            loc_nNump = 0
            loc_nRnop = 0
            IF !THIS.this_lReserva
                SELECT crSigCdPam_4c
                IF crSigCdPam_4c.GlobAutos = 2 AND THIS.this_nNumeroOp > 0
                    loc_nNump = THIS.this_nNumeroOp
                ELSE
                    loc_nNump = fGerUniqueKey(loc_cDopp)
                ENDIF
                loc_cSql = "SELECT Numps FROM SigOpPic WHERE Numps = " + LTRIM(STR(loc_nNump))
                IF THIS.SqlExecute(loc_cSql, "TmpOpiChk_4c") <= 0
                    MsgErro("Favor Reinicializar o Processo!!!", "Erro")
                    loc_lResultado = .F.
                ENDIF
                IF RECCOUNT("TmpOpiChk_4c") > 0
                    MsgAviso("N" + CHR(250) + "mero de Op j" + CHR(225) + " existe. Favor Corrigir!!!")
                    loc_lResultado = .F.
                ENDIF
            ELSE
                loc_nRnop = fGerUniqueKey("RESERVAPCP")
            ENDIF

            *-- Carregar operacao de estoque
            IF THIS.CursorQuery("SigCdOpe", "CrSigCdOpe_4c", "Dopes", loc_cDopEst) <= 0
                MsgErro("Opera" + CHR(231) + CHR(227) + "o de estoque n" + CHR(227) + "o encontrada: " + loc_cDopEst, "Erro")
                loc_lResultado = .F.
            ENDIF

            SELECT CrSigCdOpe_4c
            loc_cGrupoOrig = ALLTRIM(CrSigCdOpe_4c.GruOrigs)
            loc_cContaOrig = ALLTRIM(CrSigCdOpe_4c.ConOrigs)
            loc_cGrupoDest = ALLTRIM(CrSigCdOpe_4c.GruDests)
            loc_cContaDest = ALLTRIM(CrSigCdOpe_4c.ConDests)

            *-- Gerar numero do movimento de baixa
            loc_nNume = fGerUniqueKey(ALLTRIM(loc_cDopEst) + loc_cEmpr)
            THIS.this_nNume  = loc_nNume
            THIS.this_nRnop  = loc_nRnop

            *-- Criar cursores temporarios de trabalho
            SET NULL ON
            CREATE CURSOR TmpEmpH_4c (Grupos c(10), Contas c(10), cGrus c(3), cMats c(14), Qtds n(12,3), QtdReqs n(12,3), ;
                                      QtdEsts n(12,3), QtdMins n(12,3), QtdPedcs n(12,3), QtdComps n(12,3), QtdEmphs n(12,3), ;
                                      QtdGReqs n(12,3), cpro2s c(14))
            INDEX ON cGrus + cMats TAG GruMat
            INDEX ON cMats + cpro2s TAG CMats

            CREATE CURSOR TmpPedra_4c (Grupos c(10), Contas c(10), cGrus c(3), cMats c(14), Qtds n(12,3), QtdReqs n(12,3), ;
                                       QtdEsts n(12,3), QtdMins n(12,3), QtdPedcs n(12,3), QtdComps n(12,3), QtdEmphs n(12,3), ;
                                       QtdGReqs n(12,3))
            INDEX ON cGrus + cMats TAG GruMat
            INDEX ON cMats TAG CMats

            CREATE CURSOR TmpMatPrz_4c (cMats c(14), Qtds n(12,3), Pesos n(12,3), PrazoEnts D, QtBaixas n(12,3))
            INDEX ON DTOC(PrazoEnts) + cMats TAG MatPrazo DESCENDING
            SET NULL OFF

            *-- Atualizar saldos de reserva em TmpSaldG
            SELECT TmpSaldG
            SET ORDER TO
            REPLACE ALL Reservs WITH Saldo - Disps

            *-- Iniciar transacao
            SQLEXEC(gnConnHandle, "BEGIN TRAN")

            *-- INSERT cabecalho do movimento de baixa (SigMvCab)
            loc_cObsSigMv  = IIF(THIS.this_lReserva, ;
                                 "[ Reserva Autom" + CHR(225) + "tica ]", ;
                                 "[ Globaliza" + CHR(231) + CHR(227) + "o ]")
            loc_cEmpDopNum = loc_cEmpr + loc_cDopEst + STR(loc_nNume, 6)

            loc_cSql = "INSERT INTO SigMvCab (Emps, Dopes, Numes, MascNum, Datas, Datars, Usuars, " + ;
                       "Grupoos, Contaos, Grupods, Contads, Obses, CidChaves, Dtalts, EmpDopNums, rNops, PrazoEnts) VALUES (" + ;
                       EscaparSQL(loc_cEmpr) + ", " + ;
                       EscaparSQL(loc_cDopEst) + ", " + ;
                       LTRIM(STR(loc_nNume)) + ", " + ;
                       EscaparSQL(THIS.GerMascara(loc_nNume)) + ", " + ;
                       FormatarDataSQL(loc_dDtGera) + ", " + ;
                       FormatarDataSQL(DATE()) + ", " + ;
                       EscaparSQL(loc_cUsuar) + ", " + ;
                       EscaparSQL(loc_cGrupoOrig) + ", " + ;
                       EscaparSQL(loc_cContaOrig) + ", " + ;
                       EscaparSQL(loc_cGrupoDest) + ", " + ;
                       EscaparSQL(loc_cContaDest) + ", " + ;
                       EscaparSQL(loc_cObsSigMv) + ", " + ;
                       EscaparSQL(fUniqueIds()) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL(loc_cEmpDopNum) + ", " + ;
                       LTRIM(STR(loc_nRnop)) + ", " + ;
                       FormatarDataSQL(loc_dPrev) + ")"
            IF SQLEXEC(gnConnHandle, loc_cSql) <= 0
                SQLEXEC(gnConnHandle, "ROLLBACK TRAN")
                MsgErro("Falha ao inserir cabe" + CHR(231) + "alho do movimento (SigMvCab)", "Erro")
                loc_lResultado = .F.
            ENDIF

            *-- Modo Globalizacao: atualizar Nops e gerar OPs
            IF !THIS.this_lReserva
                loc_cSql = "UPDATE SigMvCab SET Nops = " + LTRIM(STR(loc_nNump)) + ;
                           ", Rnops = " + LTRIM(STR(loc_nNump)) + ;
                           " WHERE EmpDopNums = " + EscaparSQL(loc_cEmpDopNum)
                IF SQLEXEC(gnConnHandle, loc_cSql) <= 0
                    SQLEXEC(gnConnHandle, "ROLLBACK TRAN")
                    MsgErro("Falha ao atualizar Nops em SigMvCab", "Erro")
                    loc_lResultado = .F.
                ENDIF

                IF !THIS.GerarOrdensProducao(loc_cDopp, loc_cDopEst, loc_nNump, ;
                                             loc_dDtGera, loc_dPrev, loc_cEmpr, loc_cUsuar)
                    SQLEXEC(gnConnHandle, "ROLLBACK TRAN")
                    loc_lResultado = .F.
                ENDIF
            ENDIF

            *-- Processar baixa de estoque
            IF !THIS.ProcessarBaixaEstoque(loc_cDopEst, loc_cDope, loc_nNump, loc_nRnop, ;
                                           loc_dDtGera, loc_cEmpr, loc_cUsuar)
                SQLEXEC(gnConnHandle, "ROLLBACK TRAN")
                loc_lResultado = .F.
            ENDIF

            *-- Processar baixa de fabricacao
            IF !THIS.ProcessarBaixaFabricacao(loc_cDopEst, loc_nNume, loc_nNump, ;
                                              loc_dDtGera, loc_cEmpr, loc_cUsuar)
                SQLEXEC(gnConnHandle, "ROLLBACK TRAN")
                loc_lResultado = .F.
            ENDIF

            *-- Processar empenhamentos (se configurado)
            SELECT crSigCdPam_4c
            IF !EMPTY(crSigCdPam_4c.DopEmphs) AND !EMPTY(crSigCdPam_4c.DopReqcs) AND ;
               !EMPTY(crSigCdPam_4c.DopPedcs) AND !THIS.this_lReserva AND THIS.this_nEmphPdr = 1
                IF !THIS.ProcessarEmpenhamentos(loc_cDopp, loc_cDopEst, loc_nNump, loc_nRnop, ;
                                               loc_dDtGera, loc_cEmpr, loc_cUsuar)
                    SQLEXEC(gnConnHandle, "ROLLBACK TRAN")
                    loc_lResultado = .F.
                ENDIF
            ENDIF

            *-- Gravar historico de movimentos
            IF !THIS.GravarHistorico(loc_cEmpr, loc_cUsuar, THIS.this_cSigKey)
                SQLEXEC(gnConnHandle, "ROLLBACK TRAN")
                loc_lResultado = .F.
            ENDIF

            *-- Modo Reserva: atualizar Rnops nos cabecalhos originais
            IF THIS.this_lReserva AND USED("TmpCabec")
                SELECT TmpCabec
                SCAN
                    IF !TmpCabec.Flag
                        LOOP
                    ENDIF
                    loc_cEdnCab = ALLTRIM(TmpCabec.Emps) + ALLTRIM(TmpCabec.Dopes) + STR(TmpCabec.Numes, 6)
                    loc_cSql = "UPDATE SigMvCab SET Rnops = " + LTRIM(STR(loc_nRnop)) + ;
                               " WHERE EmpDopNums = " + EscaparSQL(loc_cEdnCab)
                    SQLEXEC(gnConnHandle, loc_cSql)
                ENDSCAN
            ENDIF

            *-- Commit
            IF SQLEXEC(gnConnHandle, "COMMIT TRAN") <= 0
                SQLEXEC(gnConnHandle, "ROLLBACK TRAN")
                MsgErro("Falha no Commit da transa" + CHR(231) + CHR(227) + "o", "Erro")
                loc_lResultado = .F.
            ENDIF

            THIS.RegistrarAuditoria(IIF(THIS.this_lReserva, "RESERVA", "GLOBALIZACAO"))
            loc_lResultado = .T.

        CATCH TO loc_oErro
            SQLEXEC(gnConnHandle, "ROLLBACK TRAN")
            MsgErro(loc_oErro.Message, "Erro ao processar globaliza" + CHR(231) + CHR(227) + "o")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarOrdensProducao - Gera OPs a partir dos cursores TmpFinalg/TmpFinal
    * Equivalente ao bloco "If Not ThisForm.Reserva" do Processar.Click
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerarOrdensProducao(par_cDopp, par_cDopEst, par_nNump, ;
                                            par_dDtGera, par_dPrev, par_cEmpr, par_cUsuar)
        LOCAL loc_cSql, loc_lResultado
        LOCAL loc_nSeqs, loc_cCpros, loc_cReff, loc_cCor, loc_cTam
        LOCAL loc_cClinha, loc_cNota, loc_cGrupoD, loc_cContaD, loc_nNopComp, loc_cCidC
        LOCAL loc_nLnVezes, loc_QtBaixar, loc_QtBaixado, loc_QtdLim, loc_nTProd, loc_nTPeso
        LOCAL loc_nNume_Dopest, loc_cDopePed, loc_cForn, loc_nTotPed, loc_nNumePed, loc_nCItens

        loc_lResultado = .T.
        loc_nSeqs      = 0
        loc_cCpros     = ""
        loc_cReff      = SPACE(15)
        loc_cCor       = SPACE(4)
        loc_cTam       = SPACE(2)
        loc_cClinha    = SPACE(10)
        loc_cNota      = SPACE(6)
        loc_cGrupoD    = SPACE(10)
        loc_cContaD    = SPACE(10)
        loc_nTProd     = 0
        loc_nTPeso     = 0
        loc_nCItens    = 1

        TRY
            *-- Limpar e popular TmpFinal a partir de TmpFinalg
            SELECT TmpFinal
            DELETE ALL
            PACK

            SELECT TmpFinalg
            SCAN
                IF TmpFinalg.Produzir2 = 0
                    LOOP
                ENDIF

                THIS.CursorQuery("SigCdPro", "crSigCdPro_4c", "CPros", ALLTRIM(TmpFinalg.Cpros))
                SELECT crSigCdOpd_4c
                loc_cGrupoD = IIF(THIS.this_lPorDestino AND !EMPTY(ALLTRIM(crSigCdOpd_4c.GruDests)), ;
                                  ALLTRIM(crSigCdOpd_4c.GruDests), ALLTRIM(crSigCdOpd_4c.GruDests))
                loc_cContaD = IIF(THIS.this_lPorDestino AND !EMPTY(ALLTRIM(crSigCdOpd_4c.ConDests)), ;
                                  ALLTRIM(crSigCdOpd_4c.ConDests), ALLTRIM(crSigCdOpd_4c.ConDests))

                SELECT TmpFinal
                INSERT INTO TmpFinal (Emps, Dopes, Numes, CPros, Qtds, Peso, Saldo, Estoque, Produzir, Obsps, ;
                                      Obs, Entregas, CodCors, CodTams, Linhas, Citens, Reffs, Notas, ;
                                      Dpros, GrupoDs, ContaDs, KeyPdes) ;
                              VALUES (par_cEmpr, par_cDopEst, par_nNump, ;
                                      ALLTRIM(TmpFinalg.Cpros), TmpFinalg.Qtds, NVL(crSigCdPro_4c.PesoMs, 0), ;
                                      0, 0, TmpFinalg.Produzir2, "", "", ;
                                      par_dPrev, ;
                                      ALLTRIM(TmpFinalg.CodCors), ALLTRIM(TmpFinalg.CodTams), ;
                                      ALLTRIM(NVL(crSigCdPro_4c.Linhas, "")), 0, ;
                                      ALLTRIM(NVL(crSigCdPro_4c.Reffs, "")), "", ;
                                      ALLTRIM(NVL(crSigCdPro_4c.Dpros, "")), loc_cGrupoD, loc_cContaD, .T.)
                SELECT TmpFinalg
            ENDSCAN

            *-- Indexar TmpFinal para processamento ordenado
            SELECT TmpFinal
            INDEX ON Linhas + Reffs + Cpros + Notas + CodCors + GrupoDs + ContaDs TAG Cpros FOR Produzir > 0
            SET ORDER TO Cpros
            GO TOP

            SELECT crSigCdPac_4c
            loc_cDopePed = ALLTRIM(crSigCdPac_4c.OpPdCompra)
            IF !EMPTY(loc_cDopePed)
                THIS.CursorQuery("SigCdOpe", "TmpOpePed_4c", "Dopes", loc_cDopePed)
            ENDIF

            SELECT TmpFinal
            DO WHILE !EOF("TmpFinal")
                IF TmpFinal.Produzir = 0
                    SKIP IN TmpFinal
                    LOOP
                ENDIF

                THIS.CursorQuery("SigCdPro", "crSigCdPro_4c", "CPros", ALLTRIM(TmpFinal.Cpros))
                THIS.CursorQuery("SigCdLin", "CrSigCdLin_4c", "Linhas", ALLTRIM(TmpFinal.Linhas))
                THIS.CursorQuery("SigCdGrp", "CrSigCdGrp_4c", "CGrus",  ALLTRIM(crSigCdPro_4c.Cgrus))
                THIS.CursorQuery("SigCdGpr", "CrSigCdGpr_4c", "Codigos", ALLTRIM(CrSigCdGrp_4c.Mercs))

                SELECT TmpFinal

                *-- Caminho 1: gerar OP propria de producao
                IF EMPTY(loc_cDopePed) OR (!EMPTY(loc_cDopePed) AND crSigCdPro_4c.FabrProPrs = 1)
                    SELECT CrSigCdLin_4c
                    loc_QtdLim   = IIF(CrSigCdLin_4c.QtPcs = 0, TmpFinal.Produzir, CrSigCdLin_4c.QtPcs)
                    SELECT TmpFinal
                    loc_QtBaixar = TmpFinal.Produzir
                    loc_nLnVezes = 0

                    DO WHILE loc_QtBaixar > 0
                        loc_nLnVezes = loc_nLnVezes + 1

                        IF loc_QtBaixar < loc_QtdLim
                            loc_QtBaixado = loc_QtBaixar
                            loc_QtBaixar  = 0
                        ELSE
                            loc_QtBaixar  = loc_QtBaixar - loc_QtdLim
                            loc_QtBaixado = loc_QtdLim
                        ENDIF

                        *-- Verificar mudanca de produto/linha para criar nova OP
                        IF (loc_cClinha + loc_cReff + loc_cCpros + loc_cNota + loc_cCor + loc_cGrupoD + loc_cContaD) <> ;
                           (ALLTRIM(TmpFinal.Linhas) + ALLTRIM(TmpFinal.Reffs) + ALLTRIM(TmpFinal.Cpros) + ;
                            ALLTRIM(TmpFinal.Notas) + ALLTRIM(TmpFinal.CodCors) + ALLTRIM(TmpFinal.GrupoDs) + ;
                            ALLTRIM(TmpFinal.ContaDs)) OR loc_nLnVezes > 1

                            loc_cClinha  = ALLTRIM(TmpFinal.Linhas)
                            loc_cCpros   = ALLTRIM(TmpFinal.Cpros)
                            loc_cCor     = ALLTRIM(TmpFinal.CodCors)
                            loc_cTam     = ALLTRIM(TmpFinal.CodTams)
                            loc_cReff    = ALLTRIM(TmpFinal.Reffs)
                            loc_cGrupoD  = ALLTRIM(TmpFinal.GrupoDs)
                            loc_cContaD  = ALLTRIM(TmpFinal.ContaDs)
                            loc_nSeqs    = loc_nSeqs + 1
                            loc_cNota    = ALLTRIM(TmpFinal.Notas)
                            loc_nNopComp = (par_nNump * 10000) + loc_nSeqs
                            loc_cCidC    = DTOS(par_dDtGera) + TRANSFORM(fGerUniqueKey(DTOS(par_dDtGera)), "@L 999999") + THIS.this_cSigKey

                            *-- INSERT SigPdMvf (cabecalho da OP de producao)
                            loc_cEmpDNps = par_cEmpr + par_cDopp + STR(loc_nNopComp, 10)
                            SELECT crSigCdOpd_4c
                            loc_cSql = "INSERT INTO SigPdMvf (Emps, Dopps, Numps, Datars, Datas, Usuars, Grupoos, Contaos, " + ;
                                       "Grupods, Contads, Nops, CodPds, Unids, Pesos, Qtds, Ordems, cIdChaves, EmpDopNums, EmpDNps) VALUES (" + ;
                                       EscaparSQL(par_cEmpr) + ", " + ;
                                       EscaparSQL(par_cDopp) + ", " + ;
                                       LTRIM(STR(loc_nNopComp)) + ", GETDATE(), " + ;
                                       FormatarDataSQL(par_dDtGera) + ", " + ;
                                       EscaparSQL(par_cUsuar) + ", " + ;
                                       EscaparSQL(ALLTRIM(crSigCdOpd_4c.GruOrigs)) + ", " + ;
                                       EscaparSQL(ALLTRIM(crSigCdOpd_4c.ConOrigs)) + ", " + ;
                                       EscaparSQL(loc_cGrupoD) + ", " + ;
                                       EscaparSQL(loc_cContaD) + ", " + ;
                                       LTRIM(STR(loc_nNopComp)) + ", " + ;
                                       EscaparSQL(loc_cCpros) + ", " + ;
                                       EscaparSQL(ALLTRIM(crSigCdPro_4c.CUnis)) + ", " + ;
                                       "0, 0, 1, " + ;
                                       EscaparSQL(loc_cCidC) + ", " + ;
                                       EscaparSQL(par_cEmpr + SPACE(20) + STR(0, 6)) + ", " + ;
                                       EscaparSQL(loc_cEmpDNps) + ")"
                            IF SQLEXEC(gnConnHandle, loc_cSql) <= 0
                                loc_lResultado = .F.
                                MsgErro("Falha ao inserir SigPdMvf", "Erro")
                                EXIT
                            ENDIF

                            *-- INSERT SigCdNec (necessidade de producao)
                            loc_cIdsNec = DTOS(par_dDtGera) + TRANSFORM(fGerUniqueKey(DTOS(par_dDtGera)), "@L 999999") + THIS.this_cSigKey
                            loc_cSql = "INSERT INTO SigCdNec (Emps, Dopps, Numps, Datars, Datas, Usuars, TotPesos, Grupoos, " + ;
                                       "Contaos, Grupods, Contads, cIdChaves, EmpDNps) VALUES (" + ;
                                       EscaparSQL(par_cEmpr) + ", " + ;
                                       EscaparSQL(par_cDopp) + ", " + ;
                                       LTRIM(STR(loc_nNopComp)) + ", GETDATE(), " + ;
                                       FormatarDataSQL(par_dDtGera) + ", " + ;
                                       EscaparSQL(par_cUsuar) + ", 0, " + ;
                                       EscaparSQL(ALLTRIM(crSigCdOpd_4c.GruOrigs)) + ", " + ;
                                       EscaparSQL(ALLTRIM(crSigCdOpd_4c.ConOrigs)) + ", " + ;
                                       EscaparSQL(loc_cGrupoD) + ", " + ;
                                       EscaparSQL(loc_cContaD) + ", " + ;
                                       EscaparSQL(loc_cIdsNec) + ", " + ;
                                       EscaparSQL(loc_cEmpDNps) + ")"
                            IF SQLEXEC(gnConnHandle, loc_cSql) <= 0
                                loc_lResultado = .F.
                                MsgErro("Falha ao inserir SigCdNec", "Erro")
                                EXIT
                            ENDIF

                            *-- INSERT SigCdNei (item de necessidade agrupado)
                            SELECT crSigCdPam_4c
                            loc_cSql = "INSERT INTO SigCdNei (Emps, Dopps, Numps, Nops, Nenvs, Cmats, Cdescs, " + ;
                                       "cUnis, Pesos, Qtds, TpOps, EmpDNps, cIdChaves, nenvs) VALUES (" + ;
                                       EscaparSQL(par_cEmpr) + ", " + ;
                                       EscaparSQL(par_cDopp) + ", " + ;
                                       LTRIM(STR(loc_nNopComp)) + ", " + ;
                                       LTRIM(STR(loc_nNopComp)) + ", " + ;
                                       LTRIM(STR(loc_nNopComp)) + ", " + ;
                                       EscaparSQL(loc_cCpros) + ", " + ;
                                       EscaparSQL(ALLTRIM(crSigCdPro_4c.Dpros)) + ", " + ;
                                       EscaparSQL(ALLTRIM(crSigCdPro_4c.Cunis)) + ", 0, 0, " + ;
                                       FormatarNumeroSQL(crSigCdPam_4c.TpOpEntAus, 0) + ", " + ;
                                       EscaparSQL(loc_cEmpDNps) + ", " + ;
                                       EscaparSQL(fUniqueIds()) + ", " + ;
                                       LTRIM(STR(loc_nNopComp)) + ")"
                            IF SQLEXEC(gnConnHandle, loc_cSql) <= 0
                                loc_lResultado = .F.
                                MsgErro("Falha ao inserir SigCdNei", "Erro")
                                EXIT
                            ENDIF

                            loc_nTProd = 0
                            loc_nTPeso = 0
                        ENDIF

                        IF !loc_lResultado
                            EXIT
                        ENDIF

                        loc_nNopComp = (par_nNump * 10000) + loc_nSeqs

                        *-- Calcular quantidade de componentes (por peca ou por matriz)
                        SELECT CrSigCdGrp_4c
                        IF CrSigCdGrp_4c.GeraTubs <> 2
                            loc_nQtdCpnt = NVL(crSigCdPro_4c.QtdCpnts, 0) * loc_QtBaixado
                        ELSE
                            loc_cSql = "SELECT SUM(qtds) as total FROM SigPrMtz WHERE Cpros = '" + ALLTRIM(TmpFinal.Cpros) + "'"
                            IF THIS.SqlExecute(loc_cSql, "crSigPrMtz_4c") <= 0
                                loc_lResultado = .F.
                                MsgErro("Falha ao buscar SigPrMtz", "Erro")
                                EXIT
                            ENDIF
                            loc_nQtdCpnt = NVL(crSigPrMtz_4c.total, 0) * loc_QtBaixado
                        ENDIF

                        *-- Buscar preco do item de movimento original
                        SELECT TmpFinal
                        loc_nUnit    = 0
                        loc_cMoeda   = SPACE(3)
                        loc_cEdnFin  = ALLTRIM(TmpFinal.Emps) + ALLTRIM(TmpFinal.Dopes) + STR(TmpFinal.Numes, 6)
                        loc_cSql = "SELECT * FROM SigMvItn WHERE EmpDopNums = " + EscaparSQL(loc_cEdnFin) + " AND CPros = " + EscaparSQL(ALLTRIM(TmpFinal.Cpros))
                        THIS.SqlExecute(loc_cSql, "TempEestI_4c")
                        SELECT TempEestI_4c
                        SCAN
                            IF TempEestI_4c.Citens = TmpFinal.Citens
                                loc_nUnit  = NVL(TempEestI_4c.Units, 0)
                                loc_cMoeda = ALLTRIM(NVL(TempEestI_4c.Moedas, ""))
                                EXIT
                            ENDIF
                            SELECT TmpFinal
                        ENDSCAN
                        IF TmpFinal.KeyPdes
                            loc_nUnit  = NVL(crSigCdPro_4c.pVens, 0)
                            loc_cMoeda = ALLTRIM(NVL(crSigCdPro_4c.Moevs, ""))
                        ENDIF

                        *-- INSERT SigOpPic (peca da OP)
                        SELECT TmpFinal
                        loc_cSql = "INSERT INTO SigOpPic (Emps, Dopps, Numps, Nops, Dopes, Numes, Dataes, Dataps, Obss, Qtds, " + ;
                                   "Cpros, DtGeras, CodCors, CodTams, Pesos, QtdCpnts, Units, Moedas, cIdChaves, " + ;
                                   "EmpDopNums, EmpDNps, Notas, Empds, EmpDopNops, Dpros, Citens) VALUES (" + ;
                                   EscaparSQL(par_cEmpr) + ", " + ;
                                   EscaparSQL(par_cDopp) + ", " + ;
                                   LTRIM(STR(par_nNump)) + ", " + ;
                                   LTRIM(STR(loc_nNopComp)) + ", " + ;
                                   EscaparSQL(ALLTRIM(TmpFinal.Dopes)) + ", " + ;
                                   LTRIM(STR(TmpFinal.Numes)) + ", " + ;
                                   FormatarDataSQL(par_dPrev) + ", " + ;
                                   FormatarDataSQL(IIF(EMPTY(TmpFinal.Datas), DATE(), TmpFinal.Datas)) + ", " + ;
                                   EscaparSQL(ALLTRIM(TmpFinal.Obsps)) + ", " + ;
                                   FormatarNumeroSQL(loc_QtBaixado, 3) + ", " + ;
                                   EscaparSQL(loc_cCpros) + ", " + ;
                                   FormatarDataSQL(par_dDtGera) + ", " + ;
                                   EscaparSQL(ALLTRIM(TmpFinal.CodCors)) + ", " + ;
                                   EscaparSQL(ALLTRIM(TmpFinal.CodTams)) + ", " + ;
                                   FormatarNumeroSQL(loc_QtBaixado * NVL(TmpFinal.Peso, 0), 3) + ", " + ;
                                   FormatarNumeroSQL(loc_nQtdCpnt, 3) + ", " + ;
                                   FormatarNumeroSQL(loc_nUnit, 3) + ", " + ;
                                   EscaparSQL(loc_cMoeda) + ", " + ;
                                   EscaparSQL(fUniqueIds()) + ", " + ;
                                   EscaparSQL(ALLTRIM(TmpFinal.Emps) + ALLTRIM(TmpFinal.Dopes) + STR(TmpFinal.Numes, 6)) + ", " + ;
                                   EscaparSQL(par_cEmpr + par_cDopp + STR(par_nNump, 10)) + ", " + ;
                                   EscaparSQL(ALLTRIM(TmpFinal.Notas)) + ", " + ;
                                   EscaparSQL(ALLTRIM(TmpFinal.Emps)) + ", " + ;
                                   EscaparSQL(par_cEmpr + par_cDopp + STR(loc_nNopComp, 10)) + ", " + ;
                                   EscaparSQL(ALLTRIM(TmpFinal.Dpros)) + ", " + ;
                                   LTRIM(STR(TmpFinal.Citens)) + ")"
                        IF SQLEXEC(gnConnHandle, loc_cSql) <= 0
                            loc_lResultado = .F.
                            MsgErro("Falha ao inserir SigOpPic", "Erro")
                            EXIT
                        ENDIF

                        *-- Atualizar QtProds em SigMvItn/SigMvIts
                        SELECT TmpFinal
                        loc_nBaixa = loc_QtBaixado
                        SELECT TempEestI_4c
                        GO TOP
                        SCAN WHILE loc_nBaixa > 0
                            loc_pEdn = ALLTRIM(TempEestI_4c.Emps) + ALLTRIM(TempEestI_4c.Dopes) + STR(TempEestI_4c.Numes, 6)
                            loc_pIds = ALLTRIM(TempEestI_4c.cIdChaves)
                            IF (TempEestI_4c.Qtds - TempEestI_4c.QtBaixas - TempEestI_4c.QtProds) <> 0
                                loc_cSql = "SELECT * FROM SigMvIts WHERE EmpDopNums = " + EscaparSQL(loc_pEdn) + " AND CItens = " + LTRIM(STR(TempEestI_4c.Citens))
                                THIS.SqlExecute(loc_cSql, "TempEsti2_4c")
                                GO TOP IN TempEsti2_4c
                                IF EOF("TempEsti2_4c")
                                    loc_nPend = TempEestI_4c.Qtds - TempEestI_4c.QtBaixas - TempEestI_4c.QtProds
                                    IF loc_nPend > loc_nBaixa
                                        loc_pQtd   = TempEestI_4c.QtProds + loc_nBaixa
                                        loc_nBaixa = 0
                                    ELSE
                                        loc_pQtd   = TempEestI_4c.QtProds + loc_nPend
                                        loc_nBaixa = loc_nBaixa - loc_nPend
                                    ENDIF
                                    SQLEXEC(gnConnHandle, "UPDATE SigMvItn SET DtAlts=GETDATE(), QtProds=" + LTRIM(STR(loc_pQtd,12,3)) + " WHERE cIdChaves=" + EscaparSQL(loc_pIds))
                                ELSE
                                    SELECT TempEsti2_4c
                                    SCAN WHILE loc_nBaixa > 0
                                        loc_pId2  = ALLTRIM(TempEsti2_4c.cIdChaves)
                                        loc_nPend = TempEsti2_4c.Qtds - TempEsti2_4c.QtBaixas - TempEsti2_4c.QtProds
                                        IF loc_nPend <> 0
                                            IF loc_nPend > loc_nBaixa
                                                loc_pQtd   = TempEestI_4c.QtProds + loc_nBaixa
                                                loc_pQt2   = TempEsti2_4c.QtProds + loc_nBaixa
                                                loc_nBaixa = 0
                                            ELSE
                                                loc_pQtd   = TempEestI_4c.QtProds + loc_nPend
                                                loc_pQt2   = TempEsti2_4c.QtProds + loc_nPend
                                                loc_nBaixa = loc_nBaixa - loc_nPend
                                            ENDIF
                                            SQLEXEC(gnConnHandle, "UPDATE SigMvItn SET DtAlts=GETDATE(), QtProds=" + LTRIM(STR(loc_pQtd,12,3)) + " WHERE cIdChaves=" + EscaparSQL(loc_pIds))
                                            SQLEXEC(gnConnHandle, "UPDATE SigMvIts SET QtProds=" + LTRIM(STR(loc_pQt2,12,3)) + " WHERE cIdChaves=" + EscaparSQL(loc_pId2))
                                        ENDIF
                                    ENDSCAN
                                ENDIF
                            ENDIF
                            SELECT TempEestI_4c
                        ENDSCAN

                        *-- Atualizar Nops no cabecalho de movimento original
                        SELECT TmpFinal
                        loc_cEdnFin = ALLTRIM(TmpFinal.Emps) + ALLTRIM(TmpFinal.Dopes) + STR(TmpFinal.Numes, 6)
                        SQLEXEC(gnConnHandle, "UPDATE SigMvCab SET Nops=" + LTRIM(STR(par_nNump)) + ", DtAlts=GETDATE() WHERE EmpDopNums=" + EscaparSQL(loc_cEdnFin))

                        *-- Buscar composicao substituida e calcular peso
                        loc_cSqlCompo = "SELECT a.*, b.cgrus FROM SigSubMv a INNER JOIN SigCdPro b ON a.mats=b.cpros " + ;
                                        "WHERE a.empdopnums=" + EscaparSQL(loc_cEdnFin) + ;
                                        " AND a.cpros=" + EscaparSQL(ALLTRIM(TmpFinal.Cpros)) + ;
                                        " AND a.citem2=" + LTRIM(STR(TmpFinal.Citens))
                        THIS.SqlExecute(loc_cSqlCompo, "LocalCompo_4c")

                        SELECT crSigCdPam_4c
                        IF crSigCdPam_4c.AutComps <> 1 AND RECCOUNT("LocalCompo_4c") > 0
                            SELECT LocalCompo_4c
                            loc_nPesoCmp = THIS.AtualizarPeso()
                            loc_nTProd   = loc_nTProd + loc_QtBaixado
                            loc_nTPeso   = loc_nTPeso + (loc_QtBaixado * loc_nPesoCmp)
                            SQLEXEC(gnConnHandle, "UPDATE SigOpPic SET Pesos=" + LTRIM(STR(loc_QtBaixado * loc_nPesoCmp, 12, 3)) + ;
                                    " WHERE Cpros=" + EscaparSQL(loc_cCpros) + " AND Numes=" + LTRIM(STR(TmpFinal.Numes)))
                        ELSE
                            SELECT TmpFinal
                            loc_nTProd = loc_nTProd + loc_QtBaixado
                            loc_nTPeso = loc_nTPeso + (loc_QtBaixado * NVL(TmpFinal.Peso, 0))
                        ENDIF

                        *-- Atualizar SigPdMvf com pesos/qtds acumulados
                        SELECT crSigCdPam_4c
                        loc_nPesoFinal = IIF(crDbParam_4c.opZers = 1, 0, loc_nTPeso)
                        SQLEXEC(gnConnHandle, "UPDATE SigPdMvf SET Pesos=" + LTRIM(STR(loc_nPesoFinal,12,3)) + ",Qtds=" + LTRIM(STR(loc_nTProd,12,3)) + " WHERE EmpDNps=" + EscaparSQL(par_cEmpr + par_cDopp + STR(loc_nNopComp, 10)))

                        *-- Atualizar TotPesos em SigCdNec
                        IF THIS.this_lAutomatico
                            SQLEXEC(gnConnHandle, "UPDATE SigCdNec SET TotPesos=" + LTRIM(STR(loc_nTPeso,12,3)) + ",Autos=1 WHERE Emps=" + EscaparSQL(par_cEmpr) + " AND Dopps=" + EscaparSQL(par_cDopp) + " AND Numps=" + LTRIM(STR(loc_nNopComp)))
                        ELSE
                            SQLEXEC(gnConnHandle, "UPDATE SigCdNec SET TotPesos=" + LTRIM(STR(loc_nTPeso,12,3)) + " WHERE Emps=" + EscaparSQL(par_cEmpr) + " AND Dopps=" + EscaparSQL(par_cDopp) + " AND Numps=" + LTRIM(STR(loc_nNopComp)))
                        ENDIF

                        SELECT TmpFinal
                    ENDDO

                ELSE
                    *-- Caminho 2: gerar pedido de compra (produto terceirizado)
                    SELECT TmpFinal
                    loc_cForn   = IIF(!EMPTY(ALLTRIM(crSigCdPro_4c.Ifors)), ALLTRIM(crSigCdPro_4c.Ifors), ALLTRIM(TmpOpePed_4c.ConOrigs))
                    loc_nTotPed = TmpFinal.Produzir

                    loc_cSql = "SELECT TOP 1 Numes FROM SigMvCab WHERE Dopes=" + EscaparSQL(loc_cDopePed) + " AND ContaDs=" + EscaparSQL(loc_cForn)
                    THIS.SqlExecute(loc_cSql, "TmpCabPed_4c")
                    IF !EOF("TmpCabPed_4c")
                        loc_nNumePed = TmpCabPed_4c.Numes
                        THIS.SqlExecute("SELECT MAX(Citens) as Citens FROM SigMvItn WHERE Emps=" + EscaparSQL(par_cEmpr) + " AND Dopes=" + EscaparSQL(loc_cDopePed) + " AND Numes=" + LTRIM(STR(loc_nNumePed)), "TmpUltItn_4c")
                        loc_nCItens = NVL(TmpUltItn_4c.Citens, 0) + 1
                    ELSE
                        loc_nCItens = 9999
                    ENDIF

                    IF loc_nCItens >= 9999
                        loc_nCItens  = 1
                        loc_nNumePed = fGerUniqueKey(par_cEmpr + loc_cDopePed)
                        SELECT TmpOpePed_4c
                        loc_cSql = "INSERT INTO SigMvCab (Emps, Dopes, Numes, MascNum, Datas, Datars, Usuars, " + ;
                                   "Grupoos, Contaos, Grupods, Contads, Nops, Obses, Empdopnums, cIdChaves, DtAlts) VALUES (" + ;
                                   EscaparSQL(par_cEmpr) + ", " + ;
                                   EscaparSQL(loc_cDopePed) + ", " + ;
                                   LTRIM(STR(loc_nNumePed)) + ", " + ;
                                   EscaparSQL(THIS.GerMascara(loc_nNumePed)) + ", " + ;
                                   FormatarDataSQL(par_dDtGera) + ", GETDATE(), " + ;
                                   EscaparSQL(par_cUsuar) + ", " + ;
                                   EscaparSQL(ALLTRIM(TmpOpePed_4c.GruOrigs)) + ", " + ;
                                   EscaparSQL(loc_cForn) + ", " + ;
                                   EscaparSQL(ALLTRIM(TmpOpePed_4c.GruDests)) + ", " + ;
                                   EscaparSQL(ALLTRIM(TmpOpePed_4c.ConDests)) + ", " + ;
                                   LTRIM(STR(par_nNump)) + ", " + ;
                                   EscaparSQL("[ OP: " + STR(par_nNump) + "] ") + ", " + ;
                                   EscaparSQL(par_cEmpr + loc_cDopePed + STR(loc_nNumePed, 6)) + ", " + ;
                                   EscaparSQL(fUniqueIds()) + ", GETDATE())"
                        IF SQLEXEC(gnConnHandle, loc_cSql) <= 0
                            loc_lResultado = .F.
                            MsgErro("Falha ao inserir pedido de compra em SigMvCab", "Erro")
                            SELECT TmpFinal
                            SKIP
                            LOOP
                        ENDIF
                    ENDIF

                    SELECT TmpFinal
                    SQLEXEC(gnConnHandle, "INSERT INTO SigMvItn (Emps,Dopes,Numes,CPros,Qtds,Cunis,DPros,Opers,Citens,Pesos,cUniPs,Obs,EmpDopNums,CidChaves,DtAlts) VALUES (" + ;
                           EscaparSQL(par_cEmpr) + "," + EscaparSQL(loc_cDopePed) + "," + LTRIM(STR(loc_nNumePed)) + "," + EscaparSQL(ALLTRIM(TmpFinal.Cpros)) + "," + ;
                           FormatarNumeroSQL(loc_nTotPed, 3) + "," + EscaparSQL(ALLTRIM(crSigCdPro_4c.Cunis)) + "," + EscaparSQL(ALLTRIM(crSigCdPro_4c.Dpros)) + ",'E'," + ;
                           LTRIM(STR(loc_nCItens)) + "," + FormatarNumeroSQL(crSigCdPro_4c.PesoMs, 3) + "," + EscaparSQL(ALLTRIM(crSigCdPro_4c.cUniPs)) + "," + ;
                           EscaparSQL(ALLTRIM(TmpFinal.Obsps)) + "," + EscaparSQL(par_cEmpr + loc_cDopePed + STR(loc_nNumePed, 6)) + "," + EscaparSQL(fUniqueIds()) + ",GETDATE())")

                    IF !EMPTY(ALLTRIM(TmpFinal.CodCors)) OR !EMPTY(ALLTRIM(TmpFinal.CodTams))
                        SQLEXEC(gnConnHandle, "INSERT INTO SigMvIts (cItens,Emps,Dopes,Numes,CPros,Qtds,Pesos,CodCors,CodTams,QtdEmbs) VALUES (" + ;
                               LTRIM(STR(loc_nCItens)) + "," + EscaparSQL(par_cEmpr) + "," + EscaparSQL(loc_cDopePed) + "," + LTRIM(STR(loc_nNumePed)) + "," + ;
                               EscaparSQL(ALLTRIM(TmpFinal.Cpros)) + "," + FormatarNumeroSQL(loc_nTotPed, 3) + "," + FormatarNumeroSQL(crSigCdPro_4c.PesoMs, 3) + "," + ;
                               EscaparSQL(ALLTRIM(TmpFinal.CodCors)) + "," + EscaparSQL(ALLTRIM(TmpFinal.CodTams)) + ",1)")
                    ENDIF

                    loc_cEdnFin = ALLTRIM(TmpFinal.Emps) + ALLTRIM(TmpFinal.Dopes) + STR(TmpFinal.Numes, 6)
                    SQLEXEC(gnConnHandle, "UPDATE SigMvCab SET Nops=" + LTRIM(STR(par_nNump)) + ",DtAlts=GETDATE() WHERE EmpDopNums=" + EscaparSQL(loc_cEdnFin))
                ENDIF

                SELECT TmpFinal
                SKIP
            ENDDO

            *-- INSERT SigInAtz para itens autorizados (UsuLibs preenchido)
            IF loc_lResultado
                loc_cSql = "SELECT TOP 1 Numes FROM SigMvCab WHERE Dopes=" + EscaparSQL(par_cDopEst) + " AND Emps=" + EscaparSQL(par_cEmpr)
                loc_nNume_Dopest = 0
                IF THIS.SqlExecute(loc_cSql, "TmpNuAtz_4c") > 0 AND !EOF("TmpNuAtz_4c")
                    loc_nNume_Dopest = TmpNuAtz_4c.Numes
                ENDIF

                SELECT TmpFinalg
                SCAN
                    IF !EMPTY(ALLTRIM(TmpFinalg.UsuLibs))
                        loc_nQtdF = IIF(TmpFinalg.QtdMins > 0 AND TmpFinalg.Produzir < TmpFinalg.QtdMins AND TmpFinalg.Produzir > 0, ;
                                        TmpFinalg.QtdMins - TmpFinalg.Produzir, 0)
                        IF SQLEXEC(gnConnHandle, "INSERT INTO SigInAtz (Emps,Dopes,Numes,EmpDopNums,Cpros,Qtds,Qtdes,Qtdps,Qtdfs,Qtdms,Qtdfes,Qtdfins,Usulibs,CidChaves) VALUES (" + ;
                               EscaparSQL(par_cEmpr) + "," + EscaparSQL(par_cDopEst) + "," + LTRIM(STR(loc_nNume_Dopest)) + "," + ;
                               EscaparSQL(par_cEmpr + par_cDopEst + STR(loc_nNume_Dopest, 6)) + "," + EscaparSQL(ALLTRIM(TmpFinalg.Cpros)) + "," + ;
                               FormatarNumeroSQL(TmpFinalg.Saldo, 3) + "," + FormatarNumeroSQL(TmpFinalg.Estoque, 3) + "," + ;
                               FormatarNumeroSQL(TmpFinalg.Fabrs, 3) + "," + FormatarNumeroSQL(TmpFinalg.Produzir, 3) + "," + ;
                               FormatarNumeroSQL(TmpFinalg.QtdMins, 3) + "," + FormatarNumeroSQL(loc_nQtdF, 3) + "," + ;
                               FormatarNumeroSQL(TmpFinalg.Produzir2, 3) + "," + EscaparSQL(ALLTRIM(TmpFinalg.UsuLibs)) + "," + EscaparSQL(fUniqueIds()) + ")") <= 0
                            loc_lResultado = .F.
                            MsgErro("Falha ao inserir SigInAtz", "Erro")
                            EXIT
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF

        CATCH TO loc_oErro
            loc_lResultado = .F.
            MsgErro(loc_oErro.Message, "Erro em GerarOrdensProducao")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarBaixaEstoque - Processa baixa do estoque via SigMvItn/SigMvHst/SigBxEst
    * Equivalente ao bloco "Select TmpSaldg / TmpEstoque" do Processar.Click
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarBaixaEstoque(par_cDopEst, par_cDope, par_nNump, par_nRnop, ;
                                              par_dDtGera, par_cEmpr, par_cUsuar)
        LOCAL loc_cSql, loc_lResultado, loc_nNume, loc_xBaixa, loc_cChave, loc_cChave2
        LOCAL loc_lGrvEest, loc_nCItens, loc_cGrupoD, loc_cContaD, loc_cEdnEst, loc_cEdnNovo

        loc_lResultado = .T.
        loc_lGrvEest   = .F.
        loc_cChave     = SPACE(30)
        loc_cChave2    = SPACE(20)
        loc_nCItens    = 1
        loc_nNume      = 0

        TRY
            *-- Criar cursor de alocacao de estoque
            SET NULL ON
            CREATE CURSOR TmpEstoque_4c (EmpDs c(3), Cpros c(14), CodCors c(4), CodTams c(4), ;
                                         Emps c(3), Dopes c(20), Numes n(6), ;
                                         Grupos c(10), Estos c(10), Estoque n(12,3))
            INDEX ON EmpDs + Grupos + Estos + Emps + Dopes + STR(Numes, 6) TAG EmpDopNum
            SET NULL OFF

            *-- Alocar itens de estoque a partir de TmpSaldG
            SELECT TmpFinal
            SET ORDER TO
            SCAN
                IF TmpFinal.Estoque = 0
                    LOOP
                ENDIF
                loc_xBaixa = TmpFinal.Estoque
                SELECT TmpSaldG
                SET ORDER TO Cpros
                IF SEEK(ALLTRIM(TmpFinal.Cpros) + ALLTRIM(TmpFinal.CodCors) + ALLTRIM(TmpFinal.CodTams))
                    SCAN WHILE ALLTRIM(Cpros) = ALLTRIM(TmpFinal.Cpros) AND ;
                               ALLTRIM(CodCors) = ALLTRIM(TmpFinal.CodCors) AND ;
                               ALLTRIM(CodTams) = ALLTRIM(TmpFinal.CodTams) AND loc_xBaixa > 0
                        IF TmpSaldG.Reservs >= loc_xBaixa
                            REPLACE TmpSaldG.Reservs WITH TmpSaldG.Reservs - loc_xBaixa IN TmpSaldG
                            SELECT TmpFinal
                            INSERT INTO TmpEstoque_4c (Cpros, CodCors, CodTams, Emps, Dopes, Numes, Grupos, Estos, Estoque, EmpDs) ;
                                              VALUES (ALLTRIM(TmpFinal.Cpros), ALLTRIM(TmpFinal.CodCors), ALLTRIM(TmpFinal.CodTams), ;
                                                      ALLTRIM(TmpFinal.Emps), ALLTRIM(TmpFinal.Dopes), TmpFinal.Numes, ;
                                                      ALLTRIM(TmpSaldG.Grupos), ALLTRIM(TmpSaldG.Estos), loc_xBaixa, ALLTRIM(TmpSaldG.Emps))
                            loc_xBaixa = 0
                        ELSE
                            IF TmpSaldG.Reservs > 0
                                loc_nParcial = TmpSaldG.Reservs
                                INSERT INTO TmpEstoque_4c (Cpros, CodCors, CodTams, Emps, Dopes, Numes, Grupos, Estos, Estoque, EmpDs) ;
                                                  VALUES (ALLTRIM(TmpFinal.Cpros), ALLTRIM(TmpFinal.CodCors), ALLTRIM(TmpFinal.CodTams), ;
                                                          ALLTRIM(TmpFinal.Emps), ALLTRIM(TmpFinal.Dopes), TmpFinal.Numes, ;
                                                          ALLTRIM(TmpSaldG.Grupos), ALLTRIM(TmpSaldG.Estos), loc_nParcial, ALLTRIM(TmpSaldG.Emps))
                                REPLACE TmpSaldG.Reservs WITH 0 IN TmpSaldG
                                loc_xBaixa = loc_xBaixa - loc_nParcial
                            ENDIF
                        ENDIF
                        SELECT TmpSaldG
                    ENDSCAN
                ENDIF
                SELECT TmpFinal
            ENDSCAN

            *-- Processar TmpEstoque_4c: gerar movimentos de baixa
            SELECT TmpEstoque_4c
            SET ORDER TO EmpDopNum

            SCAN
                THIS.CursorQuery("SigCdPro", "crSigCdPro_4c", "CPros", ALLTRIM(TmpEstoque_4c.Cpros))
                THIS.CursorQuery("SigCdGrp", "crSigCdGrp_4c", "CGrus", ALLTRIM(crSigCdPro_4c.CGrus))
                SELECT TmpEstoque_4c

                loc_cChave2Cur = ALLTRIM(TmpEstoque_4c.EmpDs) + ALLTRIM(TmpEstoque_4c.Grupos) + ALLTRIM(TmpEstoque_4c.Estos)
                loc_cChaveCur  = ALLTRIM(TmpEstoque_4c.Emps) + ALLTRIM(TmpEstoque_4c.Dopes) + STR(TmpEstoque_4c.Numes, 6)

                IF loc_cChave2Cur <> loc_cChave2 OR loc_cChaveCur <> loc_cChave
                    IF loc_cChave2Cur <> loc_cChave2
                        loc_lGrvEest = .F.
                    ENDIF
                    loc_cChave2  = loc_cChave2Cur
                    loc_cChave   = loc_cChaveCur
                    loc_cEdnEst  = loc_cChaveCur

                    SQLEXEC(gnConnHandle, "UPDATE SigMvCab SET Nops=" + LTRIM(STR(par_nNump)) + ",DtAlts=GETDATE() WHERE EmpDopNums=" + EscaparSQL(loc_cEdnEst))

                    THIS.CursorQuery("SigCdOpe", "crSigCdOpe_4c", "Dopes", ALLTRIM(TmpEstoque_4c.Dopes))
                    THIS.CursorQuery("SigMvCab", "TempEest_4c",   "EmpDopNums", loc_cEdnEst)

                    SELECT crSigCdOpe_4c
                    IF crSigCdOpe_4c.Globalizas = 1
                        loc_cGrupoD = ALLTRIM(TempEest_4c.Grupoos)
                        loc_cContaD = ALLTRIM(TempEest_4c.Contaos)
                    ELSE
                        loc_cGrupoD = ALLTRIM(TempEest_4c.Grupods)
                        loc_cContaD = ALLTRIM(TempEest_4c.Contads)
                    ENDIF

                    SELECT crSigCdPam_4c
                    IF !EMPTY(crSigCdPam_4c.GruReservs)
                        loc_cGrupoD = ALLTRIM(crSigCdPam_4c.GruReservs)
                    ENDIF
                    IF !EMPTY(crSigCdPam_4c.ConReservs)
                        loc_cContaD = ALLTRIM(crSigCdPam_4c.ConReservs)
                    ENDIF

                    *-- Criar novo cabecalho de movimento de transferencia
                    IF (crSigCdPam_4c.AgrupEmph = 2 AND !EMPTY(crSigCdPam_4c.GruReservs) AND !loc_lGrvEest) OR (crSigCdPam_4c.AgrupEmph <> 2)
                        loc_nNume    = fGerUniqueKey(ALLTRIM(TmpEstoque_4c.EmpDs) + par_cDope)
                        loc_nCItens  = 1
                        loc_cEdnNovo = ALLTRIM(TmpEstoque_4c.EmpDs) + par_cDope + STR(loc_nNume, 6)
                        loc_cObsEst  = IIF(THIS.this_lReserva, "[ Reserva Autom" + CHR(225) + "tica ]", "[ OP: " + STR(par_nNump) + "] ") + loc_cChave
                        loc_cSql = "INSERT INTO SigMvCab (Emps,Dopes,Numes,MascNum,Datas,Datars,Usuars,Grupoos,Contaos,Grupods,Contads,Nops,Obses,cIdChaves,Dtalts,EmpDopNums,EmpDs,rNops) VALUES (" + ;
                                   EscaparSQL(ALLTRIM(TmpEstoque_4c.EmpDs)) + "," + EscaparSQL(par_cDope) + "," + LTRIM(STR(loc_nNume)) + "," + ;
                                   EscaparSQL(THIS.GerMascara(loc_nNume)) + "," + FormatarDataSQL(par_dDtGera) + ",GETDATE()," + ;
                                   EscaparSQL(par_cUsuar) + "," + EscaparSQL(ALLTRIM(TmpEstoque_4c.Grupos)) + "," + ;
                                   EscaparSQL(ALLTRIM(TmpEstoque_4c.Estos)) + "," + EscaparSQL(loc_cGrupoD) + "," + ;
                                   EscaparSQL(loc_cContaD) + "," + LTRIM(STR(par_nNump)) + "," + ;
                                   EscaparSQL(loc_cObsEst) + "," + EscaparSQL(fUniqueIds()) + ",GETDATE()," + ;
                                   EscaparSQL(loc_cEdnNovo) + "," + EscaparSQL(par_cEmpr) + "," + LTRIM(STR(par_nRnop)) + ")"
                        IF SQLEXEC(gnConnHandle, loc_cSql) <= 0
                            loc_lResultado = .F.
                            MsgErro("Falha ao inserir SigMvCab (baixa estoque)", "Erro")
                            EXIT
                        ENDIF
                        loc_lGrvEest = .T.
                    ELSE
                        loc_cEdnNovo = ALLTRIM(TmpEstoque_4c.Emps) + par_cDope + STR(loc_nNume, 6)
                        THIS.CursorQuery("SigMvCab", "TempEest_4c", "EmpDopNums", loc_cEdnNovo)
                        SELECT TempEest_4c
                        loc_cNewObs = ALLTRIM(NVL(TempEest_4c.Obses, "")) + " / " + loc_cChave
                        SQLEXEC(gnConnHandle, "UPDATE SigMvCab SET Obses=" + EscaparSQL(loc_cNewObs) + ",DtAlts=GETDATE() WHERE EmpDopNums=" + EscaparSQL(loc_cEdnNovo))
                    ENDIF
                ENDIF

                *-- INSERT SigMvItn (item de saida do estoque)
                SELECT TmpEstoque_4c
                SQLEXEC(gnConnHandle, "INSERT INTO SigMvItn (Emps,Dopes,Numes,CPros,Qtds,Cunis,DPros,Opers,cItens,EmpDopNums,CidChaves,DtAlts) VALUES (" + ;
                        EscaparSQL(ALLTRIM(TmpEstoque_4c.EmpDs)) + "," + EscaparSQL(par_cDope) + "," + LTRIM(STR(loc_nNume)) + "," + ;
                        EscaparSQL(ALLTRIM(TmpEstoque_4c.Cpros)) + "," + FormatarNumeroSQL(TmpEstoque_4c.Estoque, 3) + "," + ;
                        EscaparSQL(ALLTRIM(crSigCdPro_4c.Cunis)) + "," + EscaparSQL(ALLTRIM(crSigCdPro_4c.Dpros)) + ",'S'," + ;
                        LTRIM(STR(loc_nCItens)) + "," + EscaparSQL(loc_cEdnNovo) + "," + EscaparSQL(fUniqueIds()) + ",GETDATE())")

                *-- INSERT SigMvIts se grupo controla estoque por grade
                SELECT crSigCdGrp_4c
                IF crSigCdGrp_4c.TipoEstos > 1
                    SELECT TmpEstoque_4c
                    SQLEXEC(gnConnHandle, "INSERT INTO SigMvIts (cItens,Emps,Dopes,Numes,CPros,Qtds,CodCors,CodTams,QtdEmbs) VALUES (" + ;
                            LTRIM(STR(loc_nCItens)) + "," + EscaparSQL(ALLTRIM(TmpEstoque_4c.EmpDs)) + "," + EscaparSQL(par_cDope) + "," + ;
                            LTRIM(STR(loc_nNume)) + "," + EscaparSQL(ALLTRIM(TmpEstoque_4c.Cpros)) + "," + ;
                            FormatarNumeroSQL(TmpEstoque_4c.Estoque, 3) + "," + EscaparSQL(ALLTRIM(TmpEstoque_4c.CodCors)) + "," + ;
                            EscaparSQL(ALLTRIM(TmpEstoque_4c.CodTams)) + ",1)")
                ENDIF

                loc_nCItens = loc_nCItens + 1

                *-- INSERT SigMvHst se operacao controla historico
                THIS.CursorQuery("SigCdOpe", "crSigCdOpe_4c", "Dopes", par_cDope)
                SELECT crSigCdOpe_4c
                IF crSigCdOpe_4c.Estoqs = 1
                    SELECT TmpEstoque_4c
                    SQLEXEC(gnConnHandle, "INSERT INTO SigMvHst (Usuars,Datas,Datars,Emps,Dopes,Numes,Empos,Cpros,Qtds,Opers,Grupos,Estos,CodCors,CodTams,EmpDopNums,EmpGruEsts,OriDopNums,cIdChaves,Seqs) VALUES (" + ;
                            EscaparSQL(par_cUsuar) + "," + FormatarDataSQL(par_dDtGera) + ",GETDATE()," + ;
                            EscaparSQL(ALLTRIM(TmpEstoque_4c.EmpDs)) + "," + EscaparSQL(par_cDope) + "," + LTRIM(STR(loc_nNume)) + "," + ;
                            EscaparSQL(par_cEmpr) + "," + EscaparSQL(ALLTRIM(TmpEstoque_4c.Cpros)) + "," + ;
                            FormatarNumeroSQL(TmpEstoque_4c.Estoque, 3) + ",'S'," + ;
                            EscaparSQL(ALLTRIM(TmpEstoque_4c.Grupos)) + "," + EscaparSQL(ALLTRIM(TmpEstoque_4c.Estos)) + "," + ;
                            EscaparSQL(ALLTRIM(TmpEstoque_4c.CodCors)) + "," + EscaparSQL(ALLTRIM(TmpEstoque_4c.CodTams)) + "," + ;
                            EscaparSQL(ALLTRIM(TmpEstoque_4c.EmpDs) + par_cDope + STR(loc_nNume, 6)) + "," + ;
                            EscaparSQL(ALLTRIM(TmpEstoque_4c.EmpDs) + ALLTRIM(TmpEstoque_4c.Grupos) + ALLTRIM(TmpEstoque_4c.Estos)) + "," + ;
                            EscaparSQL(ALLTRIM(TmpEstoque_4c.EmpDs) + par_cDope + STR(loc_nNume, 6)) + "," + ;
                            EscaparSQL(fUniqueIds()) + ",0)")
                    SQLEXEC(gnConnHandle, "INSERT INTO SigMvHst (Usuars,Datas,Datars,Emps,Dopes,Numes,Empos,Cpros,Qtds,Opers,Grupos,Estos,CodCors,CodTams,EmpDopNums,EmpGruEsts,OriDopNums,cIdChaves,Seqs) VALUES (" + ;
                            EscaparSQL(par_cUsuar) + "," + FormatarDataSQL(par_dDtGera) + ",GETDATE()," + ;
                            EscaparSQL(par_cEmpr) + "," + EscaparSQL(par_cDope) + "," + LTRIM(STR(loc_nNume)) + "," + ;
                            EscaparSQL(par_cEmpr) + "," + EscaparSQL(ALLTRIM(TmpEstoque_4c.Cpros)) + "," + ;
                            FormatarNumeroSQL(TmpEstoque_4c.Estoque, 3) + ",'E'," + ;
                            EscaparSQL(loc_cGrupoD) + "," + EscaparSQL(loc_cContaD) + "," + ;
                            EscaparSQL(ALLTRIM(TmpEstoque_4c.CodCors)) + "," + EscaparSQL(ALLTRIM(TmpEstoque_4c.CodTams)) + "," + ;
                            EscaparSQL(par_cEmpr + par_cDope + STR(loc_nNume, 6)) + "," + ;
                            EscaparSQL(par_cEmpr + loc_cGrupoD + loc_cContaD) + "," + ;
                            EscaparSQL(ALLTRIM(TmpEstoque_4c.EmpDs) + par_cDope + STR(loc_nNume, 6)) + "," + ;
                            EscaparSQL(fUniqueIds()) + ",0)")
                ENDIF

                *-- Baixar QtProds em SigMvItn/SigMvIts
                SELECT TmpEstoque_4c
                loc_nQtBaixar = TmpEstoque_4c.Estoque
                loc_cEdnItn   = ALLTRIM(TmpEstoque_4c.Emps) + ALLTRIM(TmpEstoque_4c.Dopes) + STR(TmpEstoque_4c.Numes, 6)

                THIS.SqlExecute("SELECT * FROM SigMvIts WHERE EmpDopNums=" + EscaparSQL(loc_cEdnItn) + " AND CPros=" + EscaparSQL(ALLTRIM(TmpEstoque_4c.Cpros)), "TempEsti2_4c")
                GO TOP IN TempEsti2_4c
                loc_lTemItem2 = !EOF("TempEsti2_4c")

                THIS.SqlExecute("SELECT * FROM SigMvItn WHERE EmpDopNums=" + EscaparSQL(loc_cEdnItn) + " AND CPros=" + EscaparSQL(ALLTRIM(TmpEstoque_4c.Cpros)), "TempEestI_4c")

                SELECT TempEestI_4c
                SCAN WHILE loc_nQtBaixar > 0
                    loc_pIds = ALLTRIM(TempEestI_4c.cIdChaves)
                    IF TempEestI_4c.QtProds + loc_nQtBaixar <= TempEestI_4c.Qtds
                        loc_pQtd       = TempEestI_4c.QtProds + loc_nQtBaixar
                        loc_nQtBaixado = loc_nQtBaixar
                        loc_nQtBaixar  = 0
                    ELSE
                        loc_nQtBaixar  = loc_nQtBaixar - (TempEestI_4c.Qtds - TempEestI_4c.QtProds)
                        loc_nQtBaixado = TempEestI_4c.Qtds - TempEestI_4c.QtProds
                        loc_pQtd       = TempEestI_4c.Qtds
                    ENDIF
                    IF THIS.this_lReserva
                        SQLEXEC(gnConnHandle, "UPDATE SigMvItn SET QtProds=" + LTRIM(STR(loc_pQtd,12,3)) + ",QtReservas=" + LTRIM(STR(loc_pQtd,12,3)) + ",DtAlts=GETDATE() WHERE cIdChaves=" + EscaparSQL(loc_pIds))
                    ELSE
                        SQLEXEC(gnConnHandle, "UPDATE SigMvItn SET QtProds=" + LTRIM(STR(loc_pQtd,12,3)) + ",QtReservas=" + LTRIM(STR(loc_nQtBaixado,12,3)) + ",DtAlts=GETDATE() WHERE cIdChaves=" + EscaparSQL(loc_pIds))
                    ENDIF
                    IF !loc_lTemItem2
                        SELECT TmpEstoque_4c
                        SQLEXEC(gnConnHandle, "INSERT INTO SigBxEst (Emps,Dopes,Numes,CItens,Cpros,Datas,Empbs,Dopebs,Numebs,Qtdfs,CidChaves,EmpDopNums,EmpDopNumb) VALUES (" + ;
                                EscaparSQL(par_cEmpr) + "," + EscaparSQL(par_cDope) + "," + LTRIM(STR(loc_nNume)) + "," + ;
                                LTRIM(STR(TempEestI_4c.CItens)) + "," + EscaparSQL(ALLTRIM(TempEestI_4c.Cpros)) + "," + ;
                                FormatarDataSQL(par_dDtGera) + "," + EscaparSQL(ALLTRIM(TempEestI_4c.Emps)) + "," + ;
                                EscaparSQL(ALLTRIM(TempEestI_4c.Dopes)) + "," + LTRIM(STR(TempEestI_4c.Numes)) + "," + ;
                                FormatarNumeroSQL(loc_nQtBaixado, 3) + "," + EscaparSQL(fUniqueIds()) + "," + ;
                                EscaparSQL(par_cEmpr + par_cDope + STR(loc_nNume, 6)) + "," + ;
                                EscaparSQL(ALLTRIM(TempEestI_4c.Emps) + ALLTRIM(TempEestI_4c.Dopes) + STR(TempEestI_4c.Numes, 6)) + ")")
                    ENDIF
                    SELECT TempEestI_4c
                ENDSCAN

                *-- Baixar SigMvIts por grade de cor/tamanho
                SELECT TmpEstoque_4c
                loc_nQtBaixar = TmpEstoque_4c.Estoque
                SELECT TempEsti2_4c
                SCAN WHILE loc_nQtBaixar > 0
                    IF ALLTRIM(TempEsti2_4c.CodCors) <> ALLTRIM(TmpEstoque_4c.CodCors) OR ;
                       ALLTRIM(TempEsti2_4c.CodTams) <> ALLTRIM(TmpEstoque_4c.CodTams)
                        LOOP
                    ENDIF
                    loc_pIds = ALLTRIM(TempEsti2_4c.cIdChaves)
                    IF TempEsti2_4c.QtProds + loc_nQtBaixar <= TempEsti2_4c.Qtds
                        loc_pQtd       = TempEsti2_4c.QtProds + loc_nQtBaixar
                        loc_nQtBaixado = loc_nQtBaixar
                        loc_nQtBaixar  = 0
                    ELSE
                        loc_nQtBaixar  = loc_nQtBaixar - (TempEsti2_4c.Qtds - TempEsti2_4c.QtProds)
                        loc_nQtBaixado = TempEsti2_4c.Qtds - TempEsti2_4c.QtProds
                        loc_pQtd       = TempEsti2_4c.Qtds
                    ENDIF
                    IF THIS.this_lReserva
                        SQLEXEC(gnConnHandle, "UPDATE SigMvIts SET QtProds=" + LTRIM(STR(loc_pQtd,12,3)) + ",QtReservas=" + LTRIM(STR(loc_pQtd,12,3)) + ",DtAlts=GETDATE() WHERE cIdChaves=" + EscaparSQL(loc_pIds))
                    ELSE
                        SQLEXEC(gnConnHandle, "UPDATE SigMvIts SET QtProds=" + LTRIM(STR(loc_pQtd,12,3)) + ",QtReservas=" + LTRIM(STR(loc_nQtBaixado,12,3)) + ",DtAlts=GETDATE() WHERE cIdChaves=" + EscaparSQL(loc_pIds))
                    ENDIF
                    SELECT TmpEstoque_4c
                    SQLEXEC(gnConnHandle, "INSERT INTO SigBxEst (Emps,Dopes,Numes,CItens,Cpros,Datas,Empbs,Dopebs,Numebs,Qtdfs,CodCors,CodTams,cIdChaves,EmpDopNums,EmpDopNumb) VALUES (" + ;
                            EscaparSQL(par_cEmpr) + "," + EscaparSQL(par_cDope) + "," + LTRIM(STR(loc_nNume)) + "," + ;
                            LTRIM(STR(TempEsti2_4c.CItens)) + "," + EscaparSQL(ALLTRIM(TempEsti2_4c.Cpros)) + "," + ;
                            FormatarDataSQL(par_dDtGera) + "," + EscaparSQL(ALLTRIM(TempEsti2_4c.Emps)) + "," + ;
                            EscaparSQL(ALLTRIM(TempEsti2_4c.Dopes)) + "," + LTRIM(STR(TempEsti2_4c.Numes)) + "," + ;
                            FormatarNumeroSQL(loc_nQtBaixado, 3) + "," + EscaparSQL(ALLTRIM(TempEsti2_4c.CodCors)) + "," + ;
                            EscaparSQL(ALLTRIM(TempEsti2_4c.CodTams)) + "," + ;
                            EscaparSQL(par_cEmpr + par_cDope + STR(loc_nNume, 6)) + "," + ;
                            EscaparSQL(ALLTRIM(TempEsti2_4c.Emps) + ALLTRIM(TempEsti2_4c.Dopes) + STR(TempEsti2_4c.Numes, 6)) + ")")
                    SELECT TempEsti2_4c
                ENDSCAN

                SELECT TmpEstoque_4c
            ENDSCAN

        CATCH TO loc_oErro
            loc_lResultado = .F.
            MsgErro(loc_oErro.Message, "Erro em ProcessarBaixaEstoque")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarBaixaFabricacao - Processa baixa de producao em fabricacao
    * Equivalente ao bloco "Baixar Producao" do Processar.Click
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarBaixaFabricacao(par_cDopEst, par_nNume, par_nNump, ;
                                                  par_dDtGera, par_cEmpr, par_cUsuar)
        LOCAL loc_cSql, loc_lResultado, loc_nCItens, loc_xBaixa

        loc_lResultado = .T.
        loc_nCItens    = 1

        TRY
            *-- Criar cursor de alocacao de fabricacao
            SET NULL ON
            CREATE CURSOR TmpEstoqueFab_4c (Cpros c(14), CodCors c(4), CodTams c(4), ;
                                             Emps c(3), Dopes c(20), Numes n(6), Nops n(10), Estoque n(12,3))
            INDEX ON Emps + Dopes + STR(Numes, 6) TAG EmpDopNum
            SET NULL OFF

            *-- Preparar saldos de disponibilidade em TmpFabr
            SELECT TmpFabr
            SET ORDER TO
            REPLACE ALL Reservs WITH Disps

            *-- Alocar itens de fabricacao
            SELECT TmpFinal
            SET ORDER TO
            SCAN
                IF TmpFinal.Fabrs = 0
                    LOOP
                ENDIF
                loc_xBaixa = TmpFinal.Fabrs
                SELECT TmpFabr
                SET ORDER TO Cpros
                IF SEEK(ALLTRIM(TmpFinal.Cpros) + ALLTRIM(TmpFinal.CodCors) + ALLTRIM(TmpFinal.CodTams))
                    SCAN WHILE ALLTRIM(Cpros) = ALLTRIM(TmpFinal.Cpros) AND ;
                               ALLTRIM(CodCors) = ALLTRIM(TmpFinal.CodCors) AND ;
                               ALLTRIM(CodTams) = ALLTRIM(TmpFinal.CodTams) AND loc_xBaixa > 0
                        IF TmpFabr.Reservs >= loc_xBaixa
                            REPLACE TmpFabr.Reservs WITH TmpFabr.Reservs - loc_xBaixa IN TmpFabr
                            SELECT TmpFinal
                            INSERT INTO TmpEstoqueFab_4c (Cpros, CodCors, CodTams, Emps, Dopes, Numes, Nops, Estoque) ;
                                                  VALUES (ALLTRIM(TmpFinal.Cpros), ALLTRIM(TmpFinal.CodCors), ;
                                                          ALLTRIM(TmpFinal.CodTams), ALLTRIM(TmpFinal.Emps), ;
                                                          ALLTRIM(TmpFinal.Dopes), TmpFinal.Numes, TmpFabr.Nops, loc_xBaixa)
                            loc_xBaixa = 0
                        ELSE
                            IF TmpFabr.Reservs > 0
                                loc_nParcial = TmpFabr.Reservs
                                INSERT INTO TmpEstoqueFab_4c (Cpros, CodCors, CodTams, Emps, Dopes, Numes, Nops, Estoque) ;
                                                      VALUES (ALLTRIM(TmpFinal.Cpros), ALLTRIM(TmpFinal.CodCors), ;
                                                              ALLTRIM(TmpFinal.CodTams), ALLTRIM(TmpFinal.Emps), ;
                                                              ALLTRIM(TmpFinal.Dopes), TmpFinal.Numes, TmpFabr.Nops, loc_nParcial)
                                REPLACE TmpFabr.Reservs WITH 0 IN TmpFabr
                                loc_xBaixa = loc_xBaixa - loc_nParcial
                            ENDIF
                        ENDIF
                        SELECT TmpFabr
                    ENDSCAN
                ENDIF
                SELECT TmpFinal
            ENDSCAN

            *-- Inserir itens de saida de producao (SigMvItn) a partir de TmpFinalg
            SELECT TmpFinalg
            SET ORDER TO
            SCAN
                IF TmpFinalg.Produzir2 = 0
                    LOOP
                ENDIF

                THIS.CursorQuery("SigCdPro", "crSigCdPro_4c", "CPros", ALLTRIM(TmpFinalg.Cpros))
                THIS.CursorQuery("SigCdGrp", "crSigCdGrp_4c", "CGrus", ALLTRIM(crSigCdPro_4c.CGrus))
                SELECT TmpFinalg

                SQLEXEC(gnConnHandle, "INSERT INTO SigMvItn (Emps,Dopes,Numes,CPros,Qtds,Cunis,DPros,Opers,cItens,Pesos,Units,Moedas,Totas,EmpDopNums,CidChaves,DtAlts) VALUES (" + ;
                        EscaparSQL(par_cEmpr) + "," + EscaparSQL(par_cDopEst) + "," + LTRIM(STR(par_nNume)) + "," + ;
                        EscaparSQL(ALLTRIM(TmpFinalg.Cpros)) + "," + FormatarNumeroSQL(TmpFinalg.Produzir2, 3) + "," + ;
                        EscaparSQL(ALLTRIM(crSigCdPro_4c.Cunis)) + "," + EscaparSQL(ALLTRIM(crSigCdPro_4c.Dpros)) + ",'S'," + ;
                        LTRIM(STR(loc_nCItens)) + "," + FormatarNumeroSQL(crSigCdPro_4c.PesoMs * TmpFinalg.Produzir2, 3) + "," + ;
                        FormatarNumeroSQL(NVL(crSigCdPro_4c.pVens, 0), 3) + "," + EscaparSQL(ALLTRIM(NVL(crSigCdPro_4c.Moevs, ""))) + "," + ;
                        FormatarNumeroSQL(TmpFinalg.Produzir2 * NVL(crSigCdPro_4c.Pvens, 0), 3) + "," + ;
                        EscaparSQL(par_cEmpr + par_cDopEst + STR(par_nNume, 6)) + "," + EscaparSQL(fUniqueIds()) + ",GETDATE())")

                IF !THIS.this_lReserva
                    SQLEXEC(gnConnHandle, "UPDATE SigMvItn SET QtProds=Qtds WHERE EmpDopNums=" + ;
                            EscaparSQL(par_cEmpr + par_cDopEst + STR(par_nNume, 6)) + ;
                            " AND Cpros=" + EscaparSQL(ALLTRIM(TmpFinalg.Cpros)) + " AND cItens=" + LTRIM(STR(loc_nCItens)))
                ENDIF

                SELECT crSigCdGrp_4c
                IF crSigCdGrp_4c.TipoEstos > 1
                    SELECT TmpFinalg
                    SQLEXEC(gnConnHandle, "INSERT INTO SigMvIts (cItens,Emps,Dopes,Numes,CPros,Qtds,CodCors,CodTams,QtdEmbs) VALUES (" + ;
                            LTRIM(STR(loc_nCItens)) + "," + EscaparSQL(par_cEmpr) + "," + EscaparSQL(par_cDopEst) + "," + ;
                            LTRIM(STR(par_nNume)) + "," + EscaparSQL(ALLTRIM(TmpFinalg.Cpros)) + "," + ;
                            FormatarNumeroSQL(TmpFinalg.Produzir2, 3) + "," + EscaparSQL(ALLTRIM(TmpFinalg.CodCors)) + "," + ;
                            EscaparSQL(ALLTRIM(TmpFinalg.CodTams)) + ",1)")
                ENDIF

                loc_nCItens = loc_nCItens + 1
                SELECT TmpFinalg
            ENDSCAN

            *-- Processar OPI de fabricacao: gerar SigOpPii e baixar SigOpPic
            SELECT TmpEstoqueFab_4c
            SCAN
                loc_xBaixa = TmpEstoqueFab_4c.Estoque
                THIS.SqlExecute("SELECT * FROM SigOpPic WHERE Nops=" + LTRIM(STR(TmpEstoqueFab_4c.Nops)), "LocalOpi_4c")
                SELECT LocalOpi_4c
                GO TOP
                SCAN WHILE loc_xBaixa > 0
                    IF ALLTRIM(LocalOpi_4c.Dopes) <> par_cDopEst
                        LOOP
                    ENDIF
                    IF LocalOpi_4c.Qtds >= loc_xBaixa
                        SQLEXEC(gnConnHandle, "UPDATE SigOpPic SET Qtds=" + LTRIM(STR(LocalOpi_4c.Qtds - loc_xBaixa, 12, 3)) + " WHERE CidChaves=" + EscaparSQL(ALLTRIM(LocalOpi_4c.CidChaves)))
                        SELECT TmpEstoqueFab_4c
                        SQLEXEC(gnConnHandle, "INSERT INTO SigOpPii (Emps,Dopes,Numes,EmpDopNums,Empos,DopeOs,NumeOs,EmpDs,DopeDs,Numeds,Qtds,Nops,CidChaves) VALUES (" + ;
                                EscaparSQL(par_cEmpr) + "," + EscaparSQL(par_cDopEst) + "," + LTRIM(STR(par_nNume)) + "," + ;
                                EscaparSQL(par_cEmpr + par_cDopEst + STR(par_nNume, 6)) + "," + EscaparSQL(ALLTRIM(LocalOpi_4c.Empds)) + "," + ;
                                EscaparSQL(ALLTRIM(LocalOpi_4c.Dopes)) + "," + LTRIM(STR(LocalOpi_4c.Numes)) + "," + ;
                                EscaparSQL(ALLTRIM(TmpEstoqueFab_4c.Emps)) + "," + EscaparSQL(ALLTRIM(TmpEstoqueFab_4c.Dopes)) + "," + ;
                                LTRIM(STR(TmpEstoqueFab_4c.Numes)) + "," + FormatarNumeroSQL(loc_xBaixa, 3) + "," + ;
                                LTRIM(STR(LocalOpi_4c.Nops)) + "," + EscaparSQL(fUniqueIds()) + ")")
                        loc_xBaixa = 0
                    ELSE
                        IF LocalOpi_4c.Qtds > 0
                            SELECT TmpEstoqueFab_4c
                            SQLEXEC(gnConnHandle, "INSERT INTO SigOpPii (Emps,Dopes,Numes,EmpDopNums,Empos,DopeOs,NumeOs,EmpDs,DopeDs,Numeds,Qtds,Nops,CidChaves) VALUES (" + ;
                                    EscaparSQL(par_cEmpr) + "," + EscaparSQL(par_cDopEst) + "," + LTRIM(STR(par_nNume)) + "," + ;
                                    EscaparSQL(par_cEmpr + par_cDopEst + STR(par_nNume, 6)) + "," + EscaparSQL(ALLTRIM(LocalOpi_4c.Empds)) + "," + ;
                                    EscaparSQL(ALLTRIM(LocalOpi_4c.Dopes)) + "," + LTRIM(STR(LocalOpi_4c.Numes)) + "," + ;
                                    EscaparSQL(ALLTRIM(TmpEstoqueFab_4c.Emps)) + "," + EscaparSQL(ALLTRIM(TmpEstoqueFab_4c.Dopes)) + "," + ;
                                    LTRIM(STR(TmpEstoqueFab_4c.Numes)) + "," + FormatarNumeroSQL(LocalOpi_4c.Qtds, 3) + "," + ;
                                    LTRIM(STR(LocalOpi_4c.Nops)) + "," + EscaparSQL(fUniqueIds()) + ")")
                            loc_xBaixa = loc_xBaixa - LocalOpi_4c.Qtds
                        ENDIF
                    ENDIF

                    *-- Baixar QtProds em SigMvItn/SigMvIts da OP de fabricacao
                    SELECT TmpEstoqueFab_4c
                    THIS.BaixarQtProdsFab(TmpEstoqueFab_4c.Estoque, ;
                                         ALLTRIM(TmpEstoqueFab_4c.Emps) + ALLTRIM(TmpEstoqueFab_4c.Dopes) + STR(TmpEstoqueFab_4c.Numes, 6), ;
                                         ALLTRIM(TmpEstoqueFab_4c.Cpros), ;
                                         ALLTRIM(TmpEstoqueFab_4c.CodCors), ;
                                         ALLTRIM(TmpEstoqueFab_4c.CodTams))

                    SELECT LocalOpi_4c
                ENDSCAN
                SELECT TmpEstoqueFab_4c
            ENDSCAN

        CATCH TO loc_oErro
            loc_lResultado = .F.
            MsgErro(loc_oErro.Message, "Erro em ProcessarBaixaFabricacao")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BaixarQtProdsFab - Helper: baixa QtProds em SigMvItn/SigMvIts de OP
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BaixarQtProdsFab(par_nQtd, par_cEdn, par_cCpros, par_cCodCors, par_cCodTams)
        LOCAL loc_nQtBaixar, loc_pIds, loc_pQtd

        TRY
            loc_nQtBaixar = par_nQtd
            THIS.SqlExecute("SELECT * FROM SigMvItn WHERE EmpDopNums=" + EscaparSQL(par_cEdn) + " AND CPros=" + EscaparSQL(par_cCpros), "TempEestIFab_4c")
            SELECT TempEestIFab_4c
            SCAN WHILE loc_nQtBaixar > 0
                loc_pIds = ALLTRIM(TempEestIFab_4c.cIdChaves)
                IF TempEestIFab_4c.QtProds + loc_nQtBaixar <= TempEestIFab_4c.Qtds
                    loc_pQtd      = TempEestIFab_4c.QtProds + loc_nQtBaixar
                    loc_nQtBaixar = 0
                ELSE
                    loc_nQtBaixar = loc_nQtBaixar - (TempEestIFab_4c.Qtds - TempEestIFab_4c.QtProds)
                    loc_pQtd      = TempEestIFab_4c.Qtds
                ENDIF
                SQLEXEC(gnConnHandle, "UPDATE SigMvItn SET QtProds=" + LTRIM(STR(loc_pQtd,12,3)) + " WHERE cIdChaves=" + EscaparSQL(loc_pIds))
            ENDSCAN

            loc_nQtBaixar = par_nQtd
            THIS.SqlExecute("SELECT * FROM SigMvIts WHERE EmpDopNums=" + EscaparSQL(par_cEdn) + " AND CPros=" + EscaparSQL(par_cCpros), "TempEsti2Fab_4c")
            SELECT TempEsti2Fab_4c
            SCAN WHILE loc_nQtBaixar > 0
                IF ALLTRIM(CodCors) <> par_cCodCors OR ALLTRIM(CodTams) <> par_cCodTams
                    LOOP
                ENDIF
                loc_pIds = ALLTRIM(TempEsti2Fab_4c.cIdChaves)
                IF TempEsti2Fab_4c.QtProds + loc_nQtBaixar <= TempEsti2Fab_4c.Qtds
                    loc_pQtd      = TempEsti2Fab_4c.QtProds + loc_nQtBaixar
                    loc_nQtBaixar = 0
                ELSE
                    loc_nQtBaixar = loc_nQtBaixar - (TempEsti2Fab_4c.Qtds - TempEsti2Fab_4c.QtProds)
                    loc_pQtd      = TempEsti2Fab_4c.Qtds
                ENDIF
                SQLEXEC(gnConnHandle, "UPDATE SigMvIts SET QtProds=" + LTRIM(STR(loc_pQtd,12,3)) + " WHERE cIdChaves=" + EscaparSQL(loc_pIds))
            ENDSCAN
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BaixarQtProdsFab")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarEmpenhamentos - Gera empenhos e requisicoes de material
    * Equivalente ao bloco "If Not Empty(crSigCdPam.DopEmphs)..." do Processar.Click
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarEmpenhamentos(par_cDopp, par_cDopEst, par_nNump, par_nRnop, ;
                                               par_dDtGera, par_cEmpr, par_cUsuar)
        LOCAL loc_cSql, loc_lResultado, loc_nNume, loc_nCItens
        LOCAL loc_cDopeEmp, loc_cDopeReq, loc_cCgru, loc_cForn

        loc_lResultado = .T.

        TRY
            SELECT crSigCdPam_4c
            loc_cDopeEmp = ALLTRIM(crSigCdPam_4c.DopEmphs)
            loc_cDopeReq = ALLTRIM(crSigCdPam_4c.DopReqcs)

            *-- Processar SelPedra (itens especiais de pedra/gemstone)
            IF USED("SelPedra") AND RECCOUNT("SelPedra") > 0
                SELECT SelPedra
                SCAN
                    IF EMPTY(ALLTRIM(SelPedra.Cpros)) OR SelPedra.Qtds <= 0
                        LOOP
                    ENDIF
                    THIS.CursorQuery("SigCdPro", "crSigCdPro_4c", "CPros", ALLTRIM(SelPedra.Cpros))
                    THIS.CursorQuery("SigCdGrp", "crSigCdGrp_4c", "CGrus", ALLTRIM(crSigCdPro_4c.CGrus))
                    SELECT crSigCdGrp_4c
                    IF crSigCdGrp_4c.CEstoqs = 1 AND !EMPTY(crSigCdGrp_4c.GruEstps) AND !EMPTY(crSigCdGrp_4c.ConEstps)
                        loc_nQtde = SelPedra.Qtds
                        SELECT TmpPedra_4c
                        SET ORDER TO CMats
                        IF !SEEK(ALLTRIM(SelPedra.Cpros))
                            INSERT INTO TmpPedra_4c (Grupos, Contas, cGrus, cMats, QtdMins) ;
                                               VALUES (ALLTRIM(crSigCdGrp_4c.GruEstps), ALLTRIM(crSigCdGrp_4c.ConEstps), ;
                                                       ALLTRIM(crSigCdPro_4c.CGrus), ALLTRIM(SelPedra.Cpros), crSigCdPro_4c.QMins)
                        ENDIF
                        REPLACE Qtds WITH Qtds + loc_nQtde
                        SELECT TmpEmpH_4c
                        SET ORDER TO CMats
                        IF !SEEK(ALLTRIM(SelPedra.Cpros) + ALLTRIM(SelPedra.Cpro2s))
                            INSERT INTO TmpEmpH_4c (Grupos, Contas, cGrus, cMats, QtdMins, Cpro2s) ;
                                               VALUES (ALLTRIM(crSigCdGrp_4c.GruEstps), ALLTRIM(crSigCdGrp_4c.ConEstps), ;
                                                       ALLTRIM(crSigCdPro_4c.CGrus), ALLTRIM(SelPedra.Cpros), crSigCdPro_4c.QMins, ALLTRIM(SelPedra.Cpro2s))
                        ENDIF
                        REPLACE Qtds WITH Qtds + loc_nQtde
                        SELECT SelPedra
                    ENDIF
                ENDSCAN
            ENDIF

            *-- Processar composicoes dos produtos de TmpFinal
            SELECT TmpFinal
            SET ORDER TO Cpros
            SCAN
                IF TmpFinal.Produzir = 0
                    LOOP
                ENDIF
                loc_cSql = "SELECT GerEmphs FROM SigOpCdc WHERE Dopes=" + EscaparSQL(ALLTRIM(TmpFinal.Dopes))
                IF THIS.SqlExecute(loc_cSql, "TmpDcOpe_4c") > 0 AND !EOF("TmpDcOpe_4c")
                    IF TmpDcOpe_4c.GerEmphs <> 1
                        SELECT TmpFinal
                        LOOP
                    ENDIF
                ENDIF

                loc_cEpn     = ALLTRIM(TmpFinal.Emps) + ALLTRIM(TmpFinal.Dopes) + STR(TmpFinal.Numes, 6)
                loc_cSqlCpo  = "SELECT a.*, b.cgrus, b.PesoMs FROM SigSubMv a INNER JOIN SigCdPro b ON a.mats=b.cpros " + ;
                               "WHERE a.empdopnums=" + EscaparSQL(loc_cEpn) + ;
                               " AND a.cpros=" + EscaparSQL(ALLTRIM(TmpFinal.Cpros)) + ;
                               " AND a.citem2=" + LTRIM(STR(TmpFinal.Citens))
                IF THIS.SqlExecute(loc_cSqlCpo, "crSigPrCpo_4c") <= 0 OR RECCOUNT("crSigPrCpo_4c") = 0
                    loc_cSqlCpo = "SELECT a.*, b.cgrus, b.PesoMs FROM SigPrCpo a INNER JOIN SigCdPro b ON a.mats=b.cpros WHERE a.cpros=" + EscaparSQL(ALLTRIM(TmpFinal.Cpros))
                    THIS.SqlExecute(loc_cSqlCpo, "crSigPrCpo_4c")
                ENDIF

                SELECT crSigPrCpo_4c
                SCAN
                    THIS.CursorQuery("SigCdPro", "crSigCdPro_4c", "CPros", ALLTRIM(crSigPrCpo_4c.Mats))
                    THIS.CursorQuery("SigCdGrp", "crSigCdGrp_4c", "CGrus", ALLTRIM(crSigCdPro_4c.CGrus))
                    SELECT crSigCdGrp_4c
                    IF crSigCdGrp_4c.CEstoqs = 1 AND !EMPTY(crSigCdGrp_4c.GruEstps) AND !EMPTY(crSigCdGrp_4c.ConEstps)
                        SELECT TmpFinal
                        loc_nQtde = TmpFinal.Produzir * crSigPrCpo_4c.Qtds
                        SELECT TmpPedra_4c
                        SET ORDER TO CMats
                        IF !SEEK(ALLTRIM(crSigPrCpo_4c.Mats))
                            INSERT INTO TmpPedra_4c (Grupos, Contas, cGrus, cMats, QtdMins) ;
                                               VALUES (ALLTRIM(crSigCdGrp_4c.GruEstps), ALLTRIM(crSigCdGrp_4c.ConEstps), ;
                                                       ALLTRIM(crSigCdPro_4c.CGrus), ALLTRIM(crSigPrCpo_4c.Mats), crSigCdPro_4c.QMins)
                        ENDIF
                        REPLACE Qtds WITH Qtds + loc_nQtde
                        SELECT TmpEmpH_4c
                        SET ORDER TO CMats
                        IF !SEEK(ALLTRIM(crSigPrCpo_4c.Mats) + ALLTRIM(crSigPrCpo_4c.Cpros))
                            INSERT INTO TmpEmpH_4c (Grupos, Contas, cGrus, cMats, QtdMins, Cpro2s) ;
                                               VALUES (ALLTRIM(crSigCdGrp_4c.GruEstps), ALLTRIM(crSigCdGrp_4c.ConEstps), ;
                                                       ALLTRIM(crSigCdPro_4c.CGrus), ALLTRIM(crSigPrCpo_4c.Mats), crSigCdPro_4c.QMins, ALLTRIM(crSigPrCpo_4c.Cpros))
                        ENDIF
                        REPLACE Qtds WITH Qtds + loc_nQtde
                        SELECT crSigPrCpo_4c
                    ENDIF
                ENDSCAN
                SELECT TmpFinal
            ENDSCAN

            *-- Buscar estoque atual e atualizar QtdEsts em TmpPedra_4c
            loc_cSqlEst = "SELECT b.* FROM SigMvEst b WHERE NOT b.Sqtds = 0 AND b.Grupos + b.Estos IN " + ;
                          "(SELECT GruEstps + ConEstPs FROM SigCdGrp WHERE NOT GruEstPs = '" + SPACE(10) + "' AND NOT ConEstPs = '" + SPACE(10) + "' GROUP BY GruEstPs, ConEstPs)"
            IF THIS.SqlExecute(loc_cSqlEst, "pEstoque_4c") > 0
                SELECT pEstoque_4c
                SCAN
                    SELECT TmpPedra_4c
                    SET ORDER TO CMats
                    IF SEEK(ALLTRIM(pEstoque_4c.Cpros))
                        REPLACE QtdEsts WITH QtdEsts + pEstoque_4c.Sqtds
                    ENDIF
                    SELECT pEstoque_4c
                ENDSCAN
            ENDIF

            *-- Gerar empenho (DopEmphs)
            IF !EMPTY(loc_cDopeEmp)
                SELECT TmpEmpH_4c
                SET ORDER TO GruMat
                GO TOP
                IF !EOF("TmpEmpH_4c")
                    loc_cCgru   = ALLTRIM(TmpEmpH_4c.CGrus)
                    loc_nCItens = 999
                    SCAN
                        THIS.CursorQuery("SigCdPro", "crSigCdPro_4c", "CPros", ALLTRIM(TmpEmpH_4c.CMats))
                        SELECT TmpEmpH_4c
                        IF ALLTRIM(TmpEmpH_4c.Cgrus) <> loc_cCgru
                            loc_nCItens = 999
                            loc_cCgru   = ALLTRIM(TmpEmpH_4c.Cgrus)
                        ENDIF
                        IF loc_nCItens >= 999
                            loc_nCItens = 1
                            loc_nNume   = fGerUniqueKey(par_cEmpr + loc_cDopeEmp)
                            IF SQLEXEC(gnConnHandle, "INSERT INTO SigMvCab (Emps,Dopes,Numes,MascNum,Datas,Datars,Usuars,Grupoos,Contaos,Nops,Obses,EmpDopNums,cIdChaves,DtAlts,rNops) VALUES (" + ;
                                       EscaparSQL(par_cEmpr) + "," + EscaparSQL(loc_cDopeEmp) + "," + LTRIM(STR(loc_nNume)) + "," + ;
                                       EscaparSQL(THIS.GerMascara(loc_nNume)) + "," + FormatarDataSQL(par_dDtGera) + ",GETDATE()," + ;
                                       EscaparSQL(par_cUsuar) + "," + EscaparSQL(ALLTRIM(TmpEmpH_4c.Grupos)) + "," + ;
                                       EscaparSQL(ALLTRIM(TmpEmpH_4c.Contas)) + "," + LTRIM(STR(par_nNump)) + "," + ;
                                       EscaparSQL("[ OP: " + STR(par_nNump) + "] ") + "," + ;
                                       EscaparSQL(par_cEmpr + loc_cDopeEmp + STR(loc_nNume, 6)) + "," + ;
                                       EscaparSQL(fUniqueIds()) + ",GETDATE()," + LTRIM(STR(par_nRnop)) + ")") <= 0
                                loc_lResultado = .F.
                                MsgErro("Falha ao inserir empenho em SigMvCab", "Erro")
                                EXIT
                            ENDIF
                        ENDIF
                        SQLEXEC(gnConnHandle, "INSERT INTO SigMvItn (Emps,Dopes,Numes,CPros,Qtds,Cunis,DPros,Opers,Citens,cPro2s,EmpDopNums,CidChaves,DtAlts) VALUES (" + ;
                                EscaparSQL(par_cEmpr) + "," + EscaparSQL(loc_cDopeEmp) + "," + LTRIM(STR(loc_nNume)) + "," + ;
                                EscaparSQL(ALLTRIM(TmpEmpH_4c.cMats)) + "," + FormatarNumeroSQL(TmpEmpH_4c.Qtds, 3) + "," + ;
                                EscaparSQL(ALLTRIM(crSigCdPro_4c.Cunis)) + "," + EscaparSQL(ALLTRIM(crSigCdPro_4c.Dpros)) + ",'S'," + ;
                                LTRIM(STR(loc_nCItens)) + "," + EscaparSQL(ALLTRIM(TmpEmpH_4c.Cpro2s)) + "," + ;
                                EscaparSQL(par_cEmpr + loc_cDopeEmp + STR(loc_nNume, 6)) + "," + EscaparSQL(fUniqueIds()) + ",GETDATE())")
                        loc_nCItens = loc_nCItens + 1
                    ENDSCAN
                ENDIF
            ENDIF

            *-- Calcular necessidades de requisicao e gerar requisicao de compra (DopReqcs)
            IF !EMPTY(loc_cDopeReq)
                SELECT TmpPedra_4c
                SCAN
                    THIS.CursorQuery("SigOpCdc", "crSigOpCdc_4c", "Dopes", loc_cDopeReq)
                    SELECT crSigOpCdc_4c
                    IF RECCOUNT("crSigOpCdc_4c") > 0 AND crSigOpCdc_4c.verests <> 2
                        SELECT TmpPedra_4c
                        loc_nQtd = TmpPedra_4c.Qtds - (TmpPedra_4c.QtdEsts - TmpPedra_4c.QtdMins + TmpPedra_4c.QtdReqs + TmpPedra_4c.QtdPedcs + TmpPedra_4c.QtdComps - TmpPedra_4c.QtdEmphs)
                        IF loc_nQtd > 0
                            REPLACE QtdGReqs WITH loc_nQtd
                        ENDIF
                    ELSE
                        SELECT TmpPedra_4c
                        REPLACE QtdGReqs WITH TmpPedra_4c.Qtds
                    ENDIF
                    SELECT TmpPedra_4c
                ENDSCAN

                SELECT TmpPedra_4c
                SET ORDER TO GruMat
                GO TOP
                IF !EOF("TmpPedra_4c")
                    loc_cCgru   = ALLTRIM(TmpPedra_4c.Cgrus)
                    loc_cForn   = ""
                    loc_nCItens = 999
                    SCAN
                        IF TmpPedra_4c.QtdGReqs <= 0
                            LOOP
                        ENDIF
                        THIS.CursorQuery("SigCdPro", "crSigCdPro_4c", "CPros", ALLTRIM(TmpPedra_4c.CMats))
                        SELECT TmpPedra_4c

                        IF loc_nCItens >= 999
                            loc_nCItens = 1
                            loc_nNume   = fGerUniqueKey(par_cEmpr + loc_cDopeReq)
                            THIS.CursorQuery("SigCdOpe", "crSigCdOpe_4c", "Dopes", loc_cDopeReq)
                            loc_cForn = IIF(!EMPTY(ALLTRIM(crSigCdPro_4c.Ifors)), ALLTRIM(crSigCdPro_4c.Ifors), ALLTRIM(crSigCdOpe_4c.ConOrigs))
                            IF SQLEXEC(gnConnHandle, "INSERT INTO SigMvCab (Emps,Dopes,Numes,MascNum,Datas,Datars,Usuars,Grupoos,Contaos,Grupods,Contads,Nops,Obses,Empdopnums,cIdChaves,DtAlts,rNops) VALUES (" + ;
                                       EscaparSQL(par_cEmpr) + "," + EscaparSQL(loc_cDopeReq) + "," + LTRIM(STR(loc_nNume)) + "," + ;
                                       EscaparSQL(THIS.GerMascara(loc_nNume)) + "," + FormatarDataSQL(par_dDtGera) + ",GETDATE()," + ;
                                       EscaparSQL(par_cUsuar) + "," + EscaparSQL(ALLTRIM(crSigCdOpe_4c.GruOrigs)) + "," + ;
                                       EscaparSQL(loc_cForn) + "," + EscaparSQL(ALLTRIM(crSigCdOpe_4c.GruDests)) + "," + ;
                                       EscaparSQL(ALLTRIM(crSigCdOpe_4c.ConDests)) + "," + LTRIM(STR(par_nNump)) + "," + ;
                                       EscaparSQL("[ OP: " + STR(par_nNump) + "] ") + "," + ;
                                       EscaparSQL(par_cEmpr + loc_cDopeReq + STR(loc_nNume, 6)) + "," + ;
                                       EscaparSQL(fUniqueIds()) + ",GETDATE()," + LTRIM(STR(par_nRnop)) + ")") <= 0
                                loc_lResultado = .F.
                                MsgErro("Falha ao inserir requisi" + CHR(231) + CHR(227) + "o em SigMvCab", "Erro")
                                EXIT
                            ENDIF
                        ENDIF
                        SELECT TmpPedra_4c
                        SQLEXEC(gnConnHandle, "INSERT INTO SigMvItn (Emps,Dopes,Numes,CPros,Qtds,Cunis,DPros,Opers,Citens,EmpDopNums,CidChaves,DtAlts) VALUES (" + ;
                                EscaparSQL(par_cEmpr) + "," + EscaparSQL(loc_cDopeReq) + "," + LTRIM(STR(loc_nNume)) + "," + ;
                                EscaparSQL(ALLTRIM(TmpPedra_4c.cMats)) + "," + FormatarNumeroSQL(TmpPedra_4c.QtdGReqs, 3) + "," + ;
                                EscaparSQL(ALLTRIM(crSigCdPro_4c.Cunis)) + "," + EscaparSQL(ALLTRIM(crSigCdPro_4c.Dpros)) + ",'S'," + ;
                                LTRIM(STR(loc_nCItens)) + "," + EscaparSQL(par_cEmpr + loc_cDopeReq + STR(loc_nNume, 6)) + "," + ;
                                EscaparSQL(fUniqueIds()) + ",GETDATE())")
                        loc_nCItens = loc_nCItens + 1
                        SELECT TmpPedra_4c
                    ENDSCAN
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            loc_lResultado = .F.
            MsgErro(loc_oErro.Message, "Erro em ProcessarEmpenhamentos")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarHistorico - Atualiza cIdChaves/Seqs nos registros de SigMvHst
    * Equivalente ao GravaHis() do legado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GravarHistorico(par_cEmpr, par_cUsuar, par_cSigKey)
        LOCAL loc_cSql, loc_lResultado, loc_nRegistro, loc_nReservado, loc_nInicio
        LOCAL loc_nRerSeq, loc_nIniSeq, loc_cNewCid, loc_cIdOld

        loc_lResultado = .T.

        TRY
            loc_cSql = "SELECT * FROM SigMvHst WHERE Emps=" + EscaparSQL(par_cEmpr)
            IF THIS.SqlExecute(loc_cSql, "crSigMvHst_4c") <= 0 OR RECCOUNT("crSigMvHst_4c") = 0
                loc_lResultado = .T.
            ENDIF

            loc_nRegistro = RECCOUNT("crSigMvHst_4c")
            loc_nReservado = 0

            DO WHILE loc_nReservado = 0 AND loc_nRegistro > 0
                loc_nReservado = fGerUniqueKey(DTOS(DATE()), .NULL., .NULL., loc_nRegistro + 1)
            ENDDO
            loc_nInicio  = loc_nReservado - loc_nRegistro
            loc_nRerSeq  = 0

            DO WHILE loc_nRerSeq = 0 AND loc_nRegistro > 0
                loc_nRerSeq = fGerUniqueKey("HISTBAR", .NULL., .NULL., loc_nRegistro + 1)
            ENDDO
            loc_nIniSeq = loc_nRerSeq - loc_nRegistro

            SELECT crSigMvHst_4c
            SCAN
                loc_nInicio  = loc_nInicio  + 1
                loc_nIniSeq  = loc_nIniSeq  + 1
                loc_cNewCid  = DTOS(crSigMvHst_4c.Datas) + ALLTRIM(crSigMvHst_4c.Opers) + ;
                               TRANSFORM(loc_nInicio, "@L 999999") + par_cSigKey
                loc_cIdOld   = ALLTRIM(crSigMvHst_4c.cIdChaves)
                SQLEXEC(gnConnHandle, "UPDATE SigMvHst SET cIdChaves=" + EscaparSQL(loc_cNewCid) + ",Seqs=" + LTRIM(STR(loc_nIniSeq)) + " WHERE cIdChaves=" + EscaparSQL(loc_cIdOld))
            ENDSCAN

        CATCH TO loc_oErro
            loc_lResultado = .F.
            MsgErro(loc_oErro.Message, "Erro em GravarHistorico")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarPeso - Calcula peso total a partir da composicao corrente
    * Equivalente ao AtualizaPeso() do legado
    * Assume que o cursor atual (alias corrente) eh LocalCompo_4c ou similar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarPeso()
        LOCAL loc_nTotQtd, loc_cCompo, loc_cSql, loc_nFator

        loc_nTotQtd = 0
        loc_cCompo  = ALIAS()

        TRY
            SELECT crSigCdPam_4c
            IF crSigCdPam_4c.AutComps <> 1
                SELECT &loc_cCompo.
                SCAN
                    IF !USED("crSigCdCom_4c")
                        THIS.SqlExecute("SELECT * FROM SigCdCom", "crSigCdCom_4c")
                    ENDIF
                    GO TOP IN crSigCdCom_4c
                    SELECT crSigCdCom_4c
                    LOCATE FOR ALLTRIM(crSigCdCom_4c.CGrus) = ALLTRIM(&loc_cCompo..CGrus) AND crSigCdCom_4c.Custos = 1
                    IF !EOF("crSigCdCom_4c")
                        loc_cSql = "SELECT a.cUnis, a.cUnips, b.BPesos FROM SigCdPro a, SigCdGrp b WHERE a.CPros=" + ;
                                   EscaparSQL(ALLTRIM(&loc_cCompo..Mats)) + " AND a.CGrus=b.CGrus"
                        IF THIS.SqlExecute(loc_cSql, "crSomaGru_4c") > 0 AND !EOF("crSomaGru_4c")
                            SELECT crSomaGru_4c
                            IF INLIST(crSomaGru_4c.BPesos, 1, 3)
                                loc_cUniKey = IIF(crSomaGru_4c.BPesos = 1, ALLTRIM(crSomaGru_4c.Cunis), ALLTRIM(crSomaGru_4c.CUnips))
                                IF THIS.SqlExecute("SELECT Fators FROM SigCdUni WHERE Cunis=" + EscaparSQL(loc_cUniKey), "LocalUni_4c") > 0 AND !EOF("LocalUni_4c")
                                    loc_nFator = IIF(NVL(LocalUni_4c.Fators, 0) = 0, 1, LocalUni_4c.Fators)
                                    SELECT &loc_cCompo.
                                    loc_nTotQtd = loc_nTotQtd + (IIF(crSomaGru_4c.BPesos = 1, &loc_cCompo..Qtds, &loc_cCompo..Pesos) * loc_nFator)
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                    SELECT &loc_cCompo.
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em AtualizarPeso")
        ENDTRY

        RETURN loc_nTotQtd
    ENDPROC

    *--------------------------------------------------------------------------
    * GerMascara - Formata numero como string de 6 digitos (substituto de fGerMascara)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerMascara(par_nNum)
        RETURN PADL(LTRIM(STR(par_nNum)), 6, "0")
    ENDPROC

    *--------------------------------------------------------------------------
    * CursorQuery - Executa SELECT simples via SQLEXEC
    * Equivalente ao poDataMgr.CursorQuery() do legado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CursorQuery(par_cTabela, par_cCursor, par_cCampo, par_vValor)
        LOCAL loc_cSql, loc_nRet

        IF USED(par_cCursor)
            USE IN (par_cCursor)
        ENDIF

        DO CASE
            CASE VARTYPE(par_vValor) = "C"
                loc_cSql = "SELECT * FROM " + par_cTabela + " WHERE " + par_cCampo + " = " + EscaparSQL(ALLTRIM(par_vValor))
            CASE VARTYPE(par_vValor) = "N"
                loc_cSql = "SELECT * FROM " + par_cTabela + " WHERE " + par_cCampo + " = " + LTRIM(STR(par_vValor))
            OTHERWISE
                loc_cSql = "SELECT * FROM " + par_cTabela + " WHERE 0=1"
        ENDCASE

        loc_nRet = SQLEXEC(gnConnHandle, loc_cSql, par_cCursor)
        IF loc_nRet <= 0 OR !USED(par_cCursor)
            SQLEXEC(gnConnHandle, "SELECT * FROM " + par_cTabela + " WHERE 0=1", par_cCursor)
        ENDIF
        IF USED(par_cCursor) AND RECCOUNT(par_cCursor) > 0
            GO TOP IN (par_cCursor)
        ENDIF
        RETURN NVL(loc_nRet, 0)
    ENDPROC

    *--------------------------------------------------------------------------
    * SqlExecute - Executa SQL via SQLEXEC
    * Equivalente ao poDataMgr.SqlExecute() do legado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE SqlExecute(par_cSql, par_cCursor)
        LOCAL loc_nRet

        IF VARTYPE(par_cCursor) = "C" AND !EMPTY(par_cCursor)
            IF USED(par_cCursor)
                USE IN (par_cCursor)
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, par_cSql, par_cCursor)
        ELSE
            loc_nRet = SQLEXEC(gnConnHandle, par_cSql)
        ENDIF

        RETURN NVL(loc_nRet, 0)
    ENDPROC

ENDDEFINE
