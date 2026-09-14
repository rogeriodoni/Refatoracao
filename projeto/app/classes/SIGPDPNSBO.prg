*==============================================================================
* SIGPDPNSBO.prg - BO de movimentos em aberto aguardando confirmacao (SIGPDPNS)
* Herda de BusinessBase
* Tabela principal: SigMvCab (movimentos em aberto filtrados por chave de sessao)
* Form OPERACIONAL: exibe movimentos em aberto filtrados por chave de sessao (this_cKey)
*==============================================================================
DEFINE CLASS SIGPDPNSBO AS BusinessBase

    *-- Chave de filtro recebida pelo form (equivalente a lpKey do legado)
    this_cKey            = ""

    *-- Campos da linha corrente em cursor_4c_Grade (equiv. crGrade)
    *-- cursor_4c_Grade: Emps c(3), Dopes c(20), Numes n(6), GrupoDs c(10),
    *--                  ContaDs c(10), Usuars c(10), Datas d, PrazoEnts d,
    *--                  Qtds n(10,3), EmpDs c(3), RClis c(50)
    this_cEmps           = ""
    this_cEmpDs          = ""
    this_cDopes          = ""
    this_nNumes          = 0
    this_cGrupoDs        = ""
    this_cContaDs        = ""
    this_cUsuars         = ""
    this_dDatas          = {}
    this_dPrazoEnts      = {}
    this_nPendentes      = 0
    this_cRClis          = ""

    *-- Totalizador de quantidade exibido em cursor_4c_Rodape (campo Qtds)
    this_nTotalPendentes = 0

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        this_cTabela     = "SigMvCab"
        this_cCampoChave = "EmpDopNums"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir da linha corrente do cursor
    * Chamado pelo form ao navegar em grd_4c_Dados (AfterRowColChange)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cEmps      = TratarNulo(Emps,      "C")
            THIS.this_cEmpDs     = TratarNulo(EmpDs,     "C")
            THIS.this_cDopes     = TratarNulo(Dopes,     "C")
            THIS.this_nNumes     = TratarNulo(Numes,     "N")
            THIS.this_cGrupoDs   = TratarNulo(GrupoDs,   "C")
            THIS.this_cContaDs   = TratarNulo(ContaDs,   "C")
            THIS.this_cUsuars    = TratarNulo(Usuars,    "C")
            THIS.this_dDatas     = TratarNulo(Datas,     "D")
            THIS.this_dPrazoEnts = TratarNulo(PrazoEnts, "D")
            THIS.this_nPendentes = TratarNulo(Pendentes, "N")
            THIS.this_cRClis     = TratarNulo(RClis,     "C")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * SelecionarDados - Popula cursor_4c_Grade e cursor_4c_Rodape
    * Equivale a SelecionaDados do legado (SIGPDPNS.selecionadados)
    * Pre-requisitos:
    *   - cursor_4c_Grade e cursor_4c_Rodape ja criados pelo form
    *   - crSigMvEstPd em scope com campos EmpDopNums, Qtds, Fk_chave
    *   - this_cKey preenchido com a chave de filtro da sessao
    *--------------------------------------------------------------------------
    PROCEDURE SelecionarDados()
        LOCAL loc_lSucesso, loc_lPodeProsseguir
        LOCAL loc_cSQL, loc_nTotal, loc_oErro

        loc_lSucesso        = .F.
        loc_lPodeProsseguir = .T.

        TRY
            IF !USED("crSigMvEstPd")
                MsgErro("Cursor crSigMvEstPd n" + CHR(227) + "o encontrado.", ;
                        "Erro ao Selecionar Dados")
                loc_lPodeProsseguir = .F.
            ENDIF

            IF loc_lPodeProsseguir AND !USED("cursor_4c_Grade")
                MsgErro("Cursor cursor_4c_Grade n" + CHR(227) + "o encontrado.", ;
                        "Erro ao Selecionar Dados")
                loc_lPodeProsseguir = .F.
            ENDIF

            IF loc_lPodeProsseguir
                *-- Limpar cursores de destino
                SELECT cursor_4c_Grade
                ZAP
                IF USED("cursor_4c_Rodape")
                    SELECT cursor_4c_Rodape
                    ZAP
                ENDIF

                *-- Obter EmpDopNums distintos filtrados pela chave da sessao
                SELECT DISTINCT EmpDopNums, SUM(Qtds) AS Qtds ;
                  FROM crSigMvEstPd ;
                 WHERE Fk_chave = THIS.this_cKey ;
                 GROUP BY EmpDopNums ;
                 ORDER BY EmpDopNums ;
                  INTO CURSOR cursor_4c_LocalEstPd

                *-- Para cada grupo EmpDopNums, buscar movimentos no SQL Server
                SELECT cursor_4c_LocalEstPd
                SCAN
                    loc_cSQL = "SELECT a.Emps, a.EmpDs, a.Dopes, a.Numes, " + ;
                               "a.GrupoDs, a.ContaDs, b.RClis, a.Usuars, " + ;
                               "a.Datas, a.PrazoEnts " + ;
                               "FROM SigMvCab a, SigCdCli b " + ;
                               "WHERE a.EmpDopNums = '" + ;
                               ALLTRIM(cursor_4c_LocalEstPd.EmpDopNums) + ;
                               "' AND a.ContaDs = b.IClis"

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalEest") >= 1
                        SELECT cursor_4c_LocalEest
                        SCAN
                            INSERT INTO cursor_4c_Grade ;
                                (Emps, Dopes, Numes, GrupoDs, ContaDs, ;
                                 RClis, Usuars, Datas, PrazoEnts, EmpDs, Pendentes) ;
                            VALUES ;
                                (cursor_4c_LocalEest.Emps, ;
                                 cursor_4c_LocalEest.Dopes, ;
                                 cursor_4c_LocalEest.Numes, ;
                                 cursor_4c_LocalEest.GrupoDs, ;
                                 cursor_4c_LocalEest.ContaDs, ;
                                 cursor_4c_LocalEest.RClis, ;
                                 cursor_4c_LocalEest.Usuars, ;
                                 IIF(ISNULL(cursor_4c_LocalEest.Datas), {}, ;
                                     TTOD(cursor_4c_LocalEest.Datas)), ;
                                 IIF(ISNULL(cursor_4c_LocalEest.PrazoEnts), {}, ;
                                     TTOD(cursor_4c_LocalEest.PrazoEnts)), ;
                                 cursor_4c_LocalEest.EmpDs, ;
                                 cursor_4c_LocalEstPd.Qtds)
                        ENDSCAN
                        USE IN cursor_4c_LocalEest
                    ELSE
                        MsgErro("Falha ao carregar movimentos: " + ;
                                ALLTRIM(cursor_4c_LocalEstPd.EmpDopNums), ;
                                "Erro SQL")
                    ENDIF
                ENDSCAN

                IF USED("cursor_4c_LocalEstPd")
                    USE IN cursor_4c_LocalEstPd
                ENDIF

                *-- Calcular total de quantidades em aberto
                loc_nTotal = 0
                SELECT SUM(Pendentes) AS nTotalPs ;
                  FROM cursor_4c_Grade ;
                  INTO CURSOR cursor_4c_TotalPs

                IF USED("cursor_4c_TotalPs")
                    SELECT cursor_4c_TotalPs
                    GO TOP
                    IF !EOF()
                        loc_nTotal = NVL(nTotalPs, 0)
                    ENDIF
                    USE IN cursor_4c_TotalPs
                ENDIF

                THIS.this_nTotalPendentes = loc_nTotal

                *-- Inserir totalizador no rodape
                IF USED("cursor_4c_Rodape")
                    INSERT INTO cursor_4c_Rodape (Pendentes) VALUES (loc_nTotal)
                ENDIF

                *-- Posicionar no inicio para exibicao no grid
                IF USED("cursor_4c_Grade") AND !EOF("cursor_4c_Grade")
                    GO TOP IN cursor_4c_Grade
                ENDIF
                IF USED("cursor_4c_Rodape") AND !EOF("cursor_4c_Rodape")
                    GO TOP IN cursor_4c_Rodape
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Selecionar Dados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave de filtro da sessao (this_cKey)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cKey)
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarChaveEmpDopNum - Concatena Emps + Dopes + Numes no formato legado
    * Usado para localizar a linha de SigMvCab da operacao corrente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarChaveEmpDopNum()
        RETURN ALLTRIM(THIS.this_cEmps) + ;
               ALLTRIM(THIS.this_cDopes) + ;
               PADL(ALLTRIM(STR(THIS.this_nNumes, 6, 0)), 6, "0")
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigMvCab com os campos rastreados pelo BO
    * Os demais campos NOT NULL recebem defaults seguros para que o INSERT
    * passe na validacao do schema.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        LOCAL loc_oErro, loc_cChave

        loc_lResultado = .F.

        TRY
            loc_cChave = THIS.MontarChaveEmpDopNum()

            IF EMPTY(loc_cChave)
                THIS.this_cMensagemErro = "Chave EmpDopNum vazia: " + ;
                                          "Emps/Dopes/Numes nao preenchidos."
                loc_lResultado = .F.
            ENDIF

            loc_cSQL = "INSERT INTO SigMvCab " + ;
                       "(cidchaves, emps, empds, dopes, numes, grupods, " + ;
                       " contads, usuars, datas, prazoents, " + ;
                       " npedclis, acres, antecs, chksubn, codpeds, contaos, " + ;
                       " desc2s, descs, devols, grresps, grupoos, grupos, " + ;
                       " grvends, iclis, ifors, locals, lotechqs, lprecos, " + ;
                       " mascnum, ncarnecs, nemps, nops, notas, nrcons, " + ;
                       " ntrans, numolds, opers, resps, tabds, tpfats, " + ;
                       " transps, usuals, usulibs, valacres, valdes2s, " + ;
                       " valdescs, valdevs, valencs, valinis, valos, " + ;
                       " valservs, valvars, vars, vends, cotusus, espes, " + ;
                       " qtdes, lcancelas, cofs, livros, chkbxparcs, ecfs, " + ;
                       " codobs, dgopes, trfisicos, utilizados, valndevs, " + ;
                       " valobxs, noforms, auditors, usuconfs) " + ;
                       "VALUES (" + ;
                       EscaparSQL(LEFT(loc_cChave, 20)) + ", " + ;
                       EscaparSQL(THIS.this_cEmps) + ", " + ;
                       EscaparSQL(THIS.this_cEmpDs) + ", " + ;
                       EscaparSQL(THIS.this_cDopes) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumes, 0) + ", " + ;
                       EscaparSQL(THIS.this_cGrupoDs) + ", " + ;
                       EscaparSQL(THIS.this_cContaDs) + ", " + ;
                       EscaparSQL(THIS.this_cUsuars) + ", " + ;
                       FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                       FormatarDataSQL(THIS.this_dPrazoEnts) + ", " + ;
                       "0, 0, '', 0, 0, '', " + ;
                       "0, 0, 0, '', '', '', " + ;
                       "'', '', '', '', 0, '', " + ;
                       "'', '', '', 0, '', '', " + ;
                       "0, 0, '', '', '', '', " + ;
                       "0, '', '', 0, 0, " + ;
                       "0, 0, 0, 0, 0, " + ;
                       "0, 0, 0, '', '', '', " + ;
                       "0, 0, 0, 0, 0, '', " + ;
                       "0, '', 0, 0, 0, " + ;
                       "0, '', '', '')"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir registro em SigMvCab"
                loc_lResultado = .F.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro Inserir: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigMvCab com os campos rastreados pelo BO
    * Filtra por EmpDopNums (chave primaria composta, equivalente ao original)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        LOCAL loc_oErro, loc_cChave

        loc_lResultado = .F.

        TRY
            loc_cChave = THIS.MontarChaveEmpDopNum()

            IF EMPTY(loc_cChave)
                THIS.this_cMensagemErro = "Chave EmpDopNums vazia para UPDATE."
                loc_lResultado = .F.
            ENDIF

            loc_cSQL = "UPDATE SigMvCab SET " + ;
                       " empds    = " + EscaparSQL(THIS.this_cEmpDs)   + ", " + ;
                       " grupods  = " + EscaparSQL(THIS.this_cGrupoDs) + ", " + ;
                       " contads  = " + EscaparSQL(THIS.this_cContaDs) + ", " + ;
                       " usuars   = " + EscaparSQL(THIS.this_cUsuars)  + ", " + ;
                       " datas    = " + FormatarDataSQL(THIS.this_dDatas)     + ", " + ;
                       " prazoents= " + FormatarDataSQL(THIS.this_dPrazoEnts) + ;
                       " WHERE EmpDopNums = " + EscaparSQL(loc_cChave)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar registro em SigMvCab"
                loc_lResultado = .F.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro Atualizar: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE
