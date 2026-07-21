*==============================================================================
* SigPrPcpBO.prg - Business Object: Priorizacao de Operacoes para PCP
* Tabela principal: SigMvCab (UPDATE Priors)
* Formulario: FormSigPrPcp.prg
*==============================================================================
DEFINE CLASS SigPrPcpBO AS BusinessBase

    *-- Tabela e chave (alvo do UPDATE de prioridades)
    this_cTabela      = "SigMvCab"
    this_cCampoChave  = "EmpDopNums"

    *-- Parametros de configuracao (lidos de SigCdPam)
    this_cOperacao    = ""   && DoppPads - tipo de operacao para planejamento
    this_cServico     = ""   && DoppServs - tipo de servico para planejamento

    *-- Registro corrente do cursor zTmpSelecao / zTmppPcp
    this_nPriors      = 0    && Priors n(6)   - prioridade atual (editavel)
    this_nNenvs       = 0    && nenvs n(10)   - numero envelope
    this_nNops        = 0    && Nops n(10)    - numero OP (SigPdMvf.NOps)
    this_cEmps        = ""   && Emps c(3)     - codigo empresa
    this_cDopes       = ""   && Dopes c(20)   - codigo operacao
    this_nNumes       = 0    && Numes n(6)    - numero da ordem de producao
    this_cContas      = ""   && Contas c(10)  - codigo conta/cliente (SigCdCli.Iclis)
    this_cRclis       = ""   && Rclis c(40)   - razao social do cliente
    this_tPrazoEnts   = {}   && PrazoEnts T   - prazo de entrega (DateTime)
    this_cCpros       = ""   && Cpros c(14)   - codigo do produto (SigCdPro)
    this_nQtds        = 0    && Qtds n(9,3)   - quantidade da OP
    this_nAPriors     = 0    && aPriors n(6)  - prioridade original antes de editar

    *-- Chave concatenada usada em INDEX e RELATION
    this_cEmpDopNum   = ""   && Emps + Dopes + Str(Numes,6)

    *-- Contexto de processamento (SigCdOpd)
    this_cNivels      = ""   && Nivels - nivel da operacao (SigCdOpd)
    this_nChkDests    = 0    && ChkDests n(1,0) - flag destino (SigCdOpd): 3=ignorar

    *-- Dados do item de grade (SigOpPic + SigMvCab + SigCdOpe)
    this_cContaOs     = ""   && ContaOs c(10) - conta origem (SigMvCab)
    this_cContaDs     = ""   && ContaDs c(10) - conta destino (SigMvCab)
    this_nGlobalizas  = 0    && Globalizas n(1,0) - flag globalizacao (SigCdOpe)
    this_nServicos    = 0    && Servicos n(1,0)   - flag servico (SigCdOpe)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave; chama BusinessBase.Init via DODEFAULT
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = "EmpDopNums"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave concatenada do registro corrente
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cEmps + THIS.this_cDopes + STR(THIS.this_nNumes, 6)
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterConfiguracaoPam - Le DoppPads e DoppServs de SigCdPam
    * Popula: this_cOperacao, this_cServico
    *--------------------------------------------------------------------------
    FUNCTION ObterConfiguracaoPam()
        LOCAL loc_cSQL, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "Select DoppPads, DoppServs From SigCdPam"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam") > 0
                IF USED("cursor_4c_Pam") AND RECCOUNT("cursor_4c_Pam") > 0
                    SELECT cursor_4c_Pam
                    THIS.this_cOperacao = ALLTRIM(NVL(DoppPads, ""))
                    THIS.this_cServico  = ALLTRIM(NVL(DoppServs, ""))
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_Pam")
            USE IN cursor_4c_Pam
        ENDIF
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades this_* a partir de cursor
    * par_cAliasCursor: alias do cursor (zTmppPcp ou zTmpSelecao)
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nPriors    = NVL(Priors, 0)
            THIS.this_nNenvs     = NVL(Nenvs, 0)
            THIS.this_nNops      = NVL(Nops, 0)
            THIS.this_cEmps      = ALLTRIM(NVL(Emps, ""))
            THIS.this_cDopes     = ALLTRIM(NVL(Dopes, ""))
            THIS.this_nNumes     = NVL(Numes, 0)
            THIS.this_cContas    = ALLTRIM(NVL(Contas, ""))
            THIS.this_cRclis     = ALLTRIM(NVL(Rclis, ""))
            THIS.this_tPrazoEnts = NVL(PrazoEnts, {})
            THIS.this_cCpros     = ALLTRIM(NVL(Cpros, ""))
            THIS.this_nQtds      = NVL(Qtds, 0)
            THIS.this_nAPriors   = NVL(aPriors, 0)
            THIS.this_cEmpDopNum = THIS.this_cEmps + THIS.this_cDopes + STR(THIS.this_nNumes, 6)
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Processar - Processa OPs em aberto e popula cursor destino (zTmppPcp)
    * Requer: ObterConfiguracaoPam() chamado antes
    * par_cCursorDestino: cursor criado pelo Form (estrutura zTmppPcp)
    *--------------------------------------------------------------------------
    FUNCTION Processar(par_cCursorDestino)
        LOCAL loc_lSucesso, loc_lAbortar, loc_cSQL, loc_oErro, loc_oProg
        LOCAL loc_cEmpresa, loc_lEnvelope, loc_nEnv, loc_cCliente, loc_cRclis
        LOCAL loc_cOpCompara, loc_nPop
        LOCAL loc_nMfasNops, loc_nMfasNenvs, loc_nMfasNumps
        LOCAL loc_nPriors, loc_cEmps, loc_cDopes, loc_nNumes
        LOCAL loc_tPrazoEnts, loc_cCpros, loc_nQtds

        loc_lSucesso  = .F.
        loc_lAbortar  = .F.
        loc_cEmpresa  = go_4c_Sistema.cCodEmpresa

        TRY
            IF USED(par_cCursorDestino)
                SELECT (par_cCursorDestino)
                ZAP
            ENDIF

            *-- Buscar OPs em aberto de Operacao (DoppPads) em SigCdNec
            loc_cSQL = "Select Numps, Dopps, cIdChaves From SigCdNec " + ;
                       "Where EmpDNps Between " + ;
                       EscaparSQL(loc_cEmpresa + THIS.this_cOperacao + STR(0,10)) + ;
                       " And " + ;
                       EscaparSQL(loc_cEmpresa + THIS.this_cOperacao + "9999999999") + ;
                       " And ChkSubn = 0 Order By Numps, Dopps, cIdChaves"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpPend1") < 1
                loc_lAbortar = .T.
                MsgErro("Favor Reinicializar o Processo!!!", ;
                        "Falha na Conex" + CHR(227) + "o (OpPendente1)")
            ENDIF

            IF !loc_lAbortar
                *-- Buscar OPs em aberto de Servico (DoppServs) em SigCdNec
                loc_cSQL = "Select Numps, Dopps, cIdChaves From SigCdNec " + ;
                           "Where EmpDNps Between " + ;
                           EscaparSQL(loc_cEmpresa + THIS.this_cServico + STR(0,10)) + ;
                           " And " + ;
                           EscaparSQL(loc_cEmpresa + THIS.this_cServico + "9999999999") + ;
                           " And ChkSubn = 0 And 0=1 Order By Numps, Dopps, cIdChaves"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpPend2") < 1
                    loc_lAbortar = .T.
                    MsgErro("Favor Reinicializar o Processo!!!", ;
                            "Falha na Conex" + CHR(227) + "o (OpPendente2)")
                ENDIF
            ENDIF

            IF !loc_lAbortar
                *-- Unir cursores de Operacao e Servico
                SELECT 0 AS Priors, Numps, Dopps FROM cursor_4c_OpPend1 ;
                    UNION ALL ;
                    SELECT 0 AS Priors, Numps, Dopps FROM cursor_4c_OpPend2 ;
                    INTO CURSOR cursor_4c_OpPendente READWRITE

                IF USED("cursor_4c_OpPend1")
                    USE IN cursor_4c_OpPend1
                ENDIF
                IF USED("cursor_4c_OpPend2")
                    USE IN cursor_4c_OpPend2
                ENDIF

                SELECT cursor_4c_OpPendente
                loc_oProg = CREATEOBJECT("fwprogressbar", "Processando Ops ...", RECCOUNT())
                loc_oProg.Show()

                SCAN
                    loc_oProg.Update(.T.)

                    *-- Buscar movimentos de producao (SigPdMvf)
                    loc_cSQL = "Select * From SigPdMvf Where Nops = " + ;
                               FormatarNumeroSQL(cursor_4c_OpPendente.Numps, 0) + ;
                               " Order by Nops, CidChaves desc"
                    SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMfas")

                    IF !USED("cursor_4c_TmpMfas") OR RECCOUNT("cursor_4c_TmpMfas") = 0
                        IF USED("cursor_4c_TmpMfas")
                            USE IN cursor_4c_TmpMfas
                        ENDIF
                        LOOP
                    ENDIF

                    SELECT cursor_4c_TmpMfas
                    GO TOP
                    IF EMPTY(NVL(cursor_4c_TmpMfas.GrupoDs, ""))
                        USE IN cursor_4c_TmpMfas
                        LOOP
                    ENDIF

                    *-- Salvar valores de TmpMfas antes de trocar work area
                    loc_nMfasNops  = NVL(cursor_4c_TmpMfas.Nops, 0)
                    loc_nMfasNenvs = NVL(cursor_4c_TmpMfas.Nenvs, 0)
                    loc_nMfasNumps = NVL(cursor_4c_TmpMfas.Numps, 0)
                    loc_nPop       = loc_nMfasNops

                    loc_cOpCompara = IIF(ALLTRIM(NVL(cursor_4c_OpPendente.Dopps, "")) = ;
                                        ALLTRIM(THIS.this_cOperacao), ;
                                        THIS.this_cOperacao, THIS.this_cServico)

                    *-- Buscar dados da operacao em SigCdOpd
                    loc_cSQL = "Select * From SigCdOpd Where Dopps = " + ;
                               EscaparSQL(ALLTRIM(cursor_4c_TmpMfas.Dopps))
                    SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdOpd")

                    IF !USED("cursor_4c_SigCdOpd") OR RECCOUNT("cursor_4c_SigCdOpd") = 0
                        IF USED("cursor_4c_SigCdOpd")
                            USE IN cursor_4c_SigCdOpd
                        ENDIF
                        USE IN cursor_4c_TmpMfas
                        LOOP
                    ENDIF

                    SELECT cursor_4c_SigCdOpd
                    IF NVL(cursor_4c_SigCdOpd.ChkDests, 0) = 3
                        USE IN cursor_4c_SigCdOpd
                        USE IN cursor_4c_TmpMfas
                        LOOP
                    ENDIF

                    loc_lEnvelope = (ALLTRIM(NVL(cursor_4c_SigCdOpd.Nivels, "")) <> ;
                                    ALLTRIM(loc_cOpCompara) OR ;
                                    NVL(cursor_4c_SigCdOpd.ChkDests, 0) = 1)
                    USE IN cursor_4c_SigCdOpd

                    *-- Query principal: SigOpPic + SigMvCab + SigCdOpe agrupados
                    loc_cSQL = "Select a.Nops, Sum(a.Qtds) as Qtds, b.ContaOs, b.ContaDs, " + ;
                               "b.prazoents, b.empdopNums, b.priors, b.Emps, b.Dopes, b.Numes, " + ;
                               "c.Globalizas, c.Servicos, a.cpros " + ;
                               "From SigOpPic a, SigMvCab b, SigCdOpe c " + ;
                               "Where a.Nops = " + FormatarNumeroSQL(loc_nPop, 0) + ;
                               " And a.EmpDopNums = b.EmpDopNums " + ;
                               "And b.Dopes = c.Dopes " + ;
                               "Group by a.Nops, b.ContaOs, b.ContaDs, b.prazoents, " + ;
                               "b.empdopnums, b.priors, b.emps, b.dopes, " + ;
                               "b.numes, c.globalizas, c.Servicos, a.cpros"

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpi") < 1
                        USE IN cursor_4c_TmpMfas
                        loc_lAbortar = .T.
                        MsgErro("Favor Reinicializar o Processo!!!", ;
                                "Falha na Conex" + CHR(227) + "o (crTmpOpi)")
                        EXIT
                    ENDIF

                    *-- Processar cada item da OP
                    SELECT cursor_4c_TmpOpi
                    SCAN
                        IF NVL(cursor_4c_TmpOpi.Qtds, 0) <> 0
                            *-- Calcular numero do envelope
                            IF loc_lEnvelope
                                loc_nEnv = loc_nMfasNenvs
                                IF loc_nMfasNenvs = loc_nMfasNops
                                    loc_nEnv = loc_nMfasNumps
                                ENDIF
                            ELSE
                                loc_nEnv = 0
                            ENDIF
                            loc_nEnv = IIF(loc_nEnv = 0, loc_nMfasNops, loc_nEnv)

                            *-- Globalizas=1 ou Servicos=1: usa ContaOs; senao ContaDs
                            IF NVL(cursor_4c_TmpOpi.Globalizas, 0) = 1 OR ;
                               NVL(cursor_4c_TmpOpi.Servicos, 0) = 1
                                loc_cCliente = ALLTRIM(NVL(cursor_4c_TmpOpi.ContaOs, ""))
                            ELSE
                                loc_cCliente = ALLTRIM(NVL(cursor_4c_TmpOpi.ContaDs, ""))
                            ENDIF

                            *-- Buscar razao social do cliente em SigCdCli
                            loc_cSQL = "Select rclis From SigCdCli Where Iclis = " + ;
                                       EscaparSQL(loc_cCliente)
                            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCli")
                            loc_cRclis = ""
                            IF USED("cursor_4c_TmpCli") AND RECCOUNT("cursor_4c_TmpCli") > 0
                                SELECT cursor_4c_TmpCli
                                loc_cRclis = ALLTRIM(NVL(rclis, ""))
                            ENDIF
                            IF USED("cursor_4c_TmpCli")
                                USE IN cursor_4c_TmpCli
                            ENDIF

                            *-- Capturar valores de TmpOpi para o REPLACE
                            SELECT cursor_4c_TmpOpi
                            loc_nPriors    = NVL(cursor_4c_TmpOpi.Priors, 0)
                            loc_cEmps      = ALLTRIM(NVL(cursor_4c_TmpOpi.Emps, ""))
                            loc_cDopes     = ALLTRIM(NVL(cursor_4c_TmpOpi.Dopes, ""))
                            loc_nNumes     = NVL(cursor_4c_TmpOpi.Numes, 0)
                            loc_tPrazoEnts = NVL(cursor_4c_TmpOpi.PrazoEnts, {})
                            loc_cCpros     = ALLTRIM(NVL(cursor_4c_TmpOpi.Cpros, ""))
                            loc_nQtds      = NVL(cursor_4c_TmpOpi.Qtds, 0)

                            *-- Inserir no cursor destino
                            SELECT (par_cCursorDestino)
                            APPEND BLANK
                            REPLACE Priors    WITH loc_nPriors, ;
                                    Nenvs     WITH loc_nEnv, ;
                                    Nops      WITH loc_nMfasNops, ;
                                    Emps      WITH loc_cEmps, ;
                                    Dopes     WITH loc_cDopes, ;
                                    Numes     WITH loc_nNumes, ;
                                    Contas    WITH loc_cCliente, ;
                                    Rclis     WITH LEFT(loc_cRclis, 40), ;
                                    PrazoEnts WITH loc_tPrazoEnts, ;
                                    Cpros     WITH loc_cCpros, ;
                                    Qtds      WITH loc_nQtds, ;
                                    aPriors   WITH loc_nPriors
                        ENDIF
                    ENDSCAN

                    IF USED("cursor_4c_TmpOpi")
                        USE IN cursor_4c_TmpOpi
                    ENDIF
                    IF USED("cursor_4c_TmpMfas")
                        USE IN cursor_4c_TmpMfas
                    ENDIF
                ENDSCAN

                IF VARTYPE(loc_oProg) = "O"
                    loc_oProg.Complete()
                    loc_oProg = .NULL.
                ENDIF

                IF !loc_lAbortar
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        *-- Limpeza de cursores temporarios
        IF USED("cursor_4c_OpPend1")
            USE IN cursor_4c_OpPend1
        ENDIF
        IF USED("cursor_4c_OpPend2")
            USE IN cursor_4c_OpPend2
        ENDIF
        IF USED("cursor_4c_OpPendente")
            USE IN cursor_4c_OpPendente
        ENDIF
        IF USED("cursor_4c_TmpMfas")
            USE IN cursor_4c_TmpMfas
        ENDIF
        IF USED("cursor_4c_SigCdOpd")
            USE IN cursor_4c_SigCdOpd
        ENDIF
        IF USED("cursor_4c_TmpOpi")
            USE IN cursor_4c_TmpOpi
        ENDIF
        IF USED("cursor_4c_TmpCli")
            USE IN cursor_4c_TmpCli
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza prioridade de uma OP individual em SigMvCab
    * Usa: this_nPriors, this_cEmps, this_cDopes, this_nNumes
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "Update SigMvCab Set Priors = " + ;
                       FormatarNumeroSQL(THIS.this_nPriors, 0) + ;
                       " Where EmpDopNums = " + ;
                       EscaparSQL(THIS.ObterChavePrimaria())
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * GravarPrioridades - Grava todas as prioridades alteradas em lote
    * par_cCursorSelecao: cursor com os registros (ex: "zTmpSelecao")
    * Ignora registros onde Priors=0 E aPriors=0 (sem alteracao)
    *--------------------------------------------------------------------------
    FUNCTION GravarPrioridades(par_cCursorSelecao)
        LOCAL loc_lSucesso, loc_lTransacao, loc_cSQL, loc_oErro
        LOCAL loc_cEdn, loc_nPriors

        loc_lSucesso   = .T.
        loc_lTransacao = .F.

        TRY
            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
            loc_lTransacao = .T.

            SELECT (par_cCursorSelecao)
            GO TOP
            SCAN
                IF NVL(Priors, 0) = 0 AND NVL(aPriors, 0) = 0
                    LOOP
                ENDIF

                loc_nPriors = NVL(Priors, 0)
                loc_cEdn    = ALLTRIM(NVL(Emps, "")) + ;
                              ALLTRIM(NVL(Dopes, "")) + ;
                              STR(NVL(Numes, 0), 6)

                loc_cSQL = "Update SigMvCab Set Priors = " + ;
                           FormatarNumeroSQL(loc_nPriors, 0) + ;
                           " Where EmpDopNums = " + EscaparSQL(loc_cEdn)

                IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                    loc_lSucesso = .F.
                    EXIT
                ENDIF
            ENDSCAN

            IF loc_lSucesso
                SQLEXEC(gnConnHandle, "COMMIT")
                THIS.RegistrarAuditoria("GRAVARPRIORIDADES")
            ELSE
                SQLEXEC(gnConnHandle, "ROLLBACK")
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel completar " + ;
                        "o processamento (commit). Tente novamente!!", ;
                        "Falha na Grava" + CHR(231) + CHR(227) + "o")
            ENDIF

        CATCH TO loc_oErro
            IF loc_lTransacao
                SQLEXEC(gnConnHandle, "ROLLBACK")
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterImagemProduto - Busca e grava imagem Base64 de SigCdPro em arquivo
    * par_cCpros: codigo do produto
    * par_cArquivoDestino: caminho completo do arquivo temporario
    * Retorna: .T. se imagem obtida e gravada com sucesso
    *--------------------------------------------------------------------------
    FUNCTION ObterImagemProduto(par_cCpros, par_cArquivoDestino)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro, loc_cFoto
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "Select FigJpgs From SigCdPro Where Cpros = " + ;
                       EscaparSQL(par_cCpros)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPro") > 0
                IF USED("cursor_4c_TmpPro") AND RECCOUNT("cursor_4c_TmpPro") > 0
                    SELECT cursor_4c_TmpPro
                    IF !EMPTY(NVL(cursor_4c_TmpPro.FigJpgs, ""))
                        loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN( ;
                                    cursor_4c_TmpPro.FigJpgs, ;
                                    "data:image/png;base64,", ""), ;
                                    "data:image/jpeg;base64,", ""), ;
                                    "data:image/jpg;base64,", ""), 14)
                        IF STRTOFILE(loc_cFoto, par_cArquivoDestino) > 0
                            loc_lSucesso = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_TmpPro")
            USE IN cursor_4c_TmpPro
        ENDIF
        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE
