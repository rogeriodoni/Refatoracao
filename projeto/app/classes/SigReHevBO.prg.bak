*==============================================================================
* SIGREHEEVO.PRG
* Business Object para Relatorio - Historico de Envelopes
*
* Herda de RelatorioBase
* Tabelas: SigCdOpe, SigCdPam, SigPdMvf, SigCdCli, SigCdCe
*==============================================================================

DEFINE CLASS SigReHevBO AS RelatorioBase

    *-- Configuracao base
    this_cTabela            = "SigPdMvf"
    this_cCampoChave        = ""

    *-- Parametro principal do relatorio
    this_nEnvelope          = 0

    *-- Flag de acesso (fChecaAcesso RESUMIDO)
    this_lAcesso            = .F.

    *-- Parametro lido de SigCdPam (DopEnvels)
    this_cDopEnvels         = ""

    *-- Nomes dos cursores usados no processamento
    this_cCursorDados       = "Temp_HisOp"
    this_cCursorCabecalho   = "csCabecalho"
    this_cCursorOpe         = "crTmpOpe"
    this_cCursorMvf         = "crSigPdMvf"
    this_cCursorParam       = "TmpParam"
    this_cCursorCli         = "CrTmpCli"
    this_cCursorCliE        = "TmpCliE"

    *-- Caminho completo do arquivo de relatorio (.frx)
    this_cArquivoRelatorio  = ""

    *--------------------------------------------------------------------------
    * Init - Configura caminho do relatorio e propriedades base
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cTabela           = "SigPdMvf"
            THIS.this_cCampoChave       = ""
            THIS.this_cArquivoRelatorio = gc_4c_CaminhoReports + "SigReHev.frx"
            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC


    *--------------------------------------------------------------------------
    * PrepararDados - Prepara cursores para o relatorio de Historico de Envelopes
    * Equivalente ao metodo Processamento() do form legado SIGREHEV
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cDopeE
        LOCAL loc_nOp, loc_lPrimeira, loc_cAcesso
        LOCAL loc_nPeso, loc_nQtde, loc_cChaveMfas, loc_cConta
        LOCAL loc_cEmpresa, loc_cTitulo, loc_cEmps, loc_cObsOps

        loc_lSucesso = .F.

        TRY
            IF THIS.this_nEnvelope <= 0
                THIS.this_cMensagemErro = "Informe o n" + CHR(250) + "mero do envelope"
                loc_lSucesso = .F.
            ENDIF

            *-- Cria cursor de cabecalho do relatorio
            IF USED(THIS.this_cCursorCabecalho)
                USE IN (THIS.this_cCursorCabecalho)
            ENDIF
            loc_cEmpresa = go_4c_Sistema.cEmpresa
            loc_cTitulo  = "An" + CHR(225) + "lise do Envelope n" + CHR(186) + " " + ;
                           ALLTRIM(STR(THIS.this_nEnvelope))
            CREATE CURSOR (THIS.this_cCursorCabecalho) (cb_empresa C(80), cb_titulo C(80))
            INSERT INTO (THIS.this_cCursorCabecalho) (cb_empresa, cb_titulo) ;
                VALUES (loc_cEmpresa, loc_cTitulo)

            *-- Busca parametro DopEnvels de SigCdPam
            IF USED(THIS.this_cCursorParam)
                USE IN (THIS.this_cCursorParam)
            ENDIF
            loc_cSQL = "SELECT DopEnvels FROM SigCdPam"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorParam)
            IF loc_nResult > 0
                SELECT (THIS.this_cCursorParam)
                IF !EOF()
                    THIS.this_cDopEnvels = ALLTRIM(DopEnvels)
                ENDIF
                USE IN (THIS.this_cCursorParam)
            ENDIF
            loc_cDopeE = THIS.this_cDopEnvels

            *-- Acesso completo (equivalente a fChecaAcesso com Envelope > 0)
            THIS.this_lAcesso = .T.
            loc_cAcesso = "1"

            *-- Busca tipos de envelope em SigCdOpe
            IF USED(THIS.this_cCursorOpe)
                USE IN (THIS.this_cCursorOpe)
            ENDIF
            loc_cSQL = "SELECT DISTINCT DigEnves FROM SigCdOpe " + ;
                       "WHERE (Servicos = 1 OR Servicos = 2) " + ;
                       "OR (Globalizas = 1 OR Globalizas = 2)"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorOpe)
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                loc_lSucesso = .F.
            ENDIF

            *-- Remove cursor de resultado anterior
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            loc_lPrimeira = .T.

            *-- Itera sobre cada tipo de envelope (DigEnves)
            SELECT (THIS.this_cCursorOpe)
            SCAN
                loc_nOp = VAL(STR(DigEnves, 1) + TRANSFORM(THIS.this_nEnvelope, "@L 999999"))

                *-- Busca movimentos do envelope calculado
                IF USED(THIS.this_cCursorMvf)
                    USE IN (THIS.this_cCursorMvf)
                ENDIF
                loc_cSQL = "SELECT Nenvs, cIdChaves, Datas, Emps, Dopps, Numps, " + ;
                           "GrupoOs, ContaOs, GrupoDs, ContaDs, Pesos, Qtds, " + ;
                           "Dopes, EmpDnPs, EmpDnPs AS ObsOps, " + ;
                           loc_cAcesso + " AS Acesso " + ;
                           "FROM SigPdMvf " + ;
                           "WHERE (Nenvs = " + STR(loc_nOp) + ;
                           " AND Dopps <> " + EscaparSQL(loc_cDopeE) + ") " + ;
                           "OR (Dopps = " + EscaparSQL(loc_cDopeE) + ;
                           " AND Numps = " + STR(loc_nOp) + ") " + ;
                           "ORDER BY Nenvs, cIdChaves"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorMvf)
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                    loc_lSucesso = .F.
                ENDIF

                SELECT (THIS.this_cCursorMvf)
                INDEX ON cIdChaves TAG Nenvs
                SET ORDER TO Nenvs

                *-- Na primeira iteracao, cria cursor de resultado com mesmo schema do MVF
                IF loc_lPrimeira
                    LOCAL ARRAY xMfas[1]
                    =AFIELDS(xMfas)
                    CREATE CURSOR (THIS.this_cCursorDados) FROM ARRAY xMfas
                    INDEX ON cIdChaves TAG cIdChaves
                    loc_lPrimeira = .F.
                ENDIF

                *-- Garante que MVF esta selecionado antes do SCAN interno
                SELECT (THIS.this_cCursorMvf)
                SCAN
                    loc_cChaveMfas = Emps + Dopps + STR(Numps, 10)
                    loc_nPeso = 0
                    loc_nQtde = 0

                    *-- Acumula Pesos e Qtds do grupo de mesma chave
                    SCAN WHILE Emps + Dopps + STR(Numps, 10) = loc_cChaveMfas
                        loc_nPeso = loc_nPeso + Pesos
                        loc_nQtde = loc_nQtde + Qtds
                    ENDSCAN
                    SKIP -1
                    SCATTER MEMVAR MEMO

                    *-- Busca nome do cliente origem (ContaOs -> Dopes)
                    IF USED(THIS.this_cCursorCli)
                        USE IN (THIS.this_cCursorCli)
                    ENDIF
                    loc_cSQL = "SELECT Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(m.ContaOs)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorCli) > 0
                        SELECT (THIS.this_cCursorCli)
                        IF !EOF()
                            m.Dopes = ALLTRIM(Rclis)
                        ENDIF
                    ENDIF

                    *-- Busca nome do cliente destino (ContaDs -> EmpDnPs)
                    IF USED(THIS.this_cCursorCli)
                        USE IN (THIS.this_cCursorCli)
                    ENDIF
                    loc_cSQL = "SELECT Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(m.ContaDs)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorCli) > 0
                        SELECT (THIS.this_cCursorCli)
                        IF !EOF()
                            m.empDnPs = ALLTRIM(Rclis)
                        ENDIF
                    ENDIF

                    *-- Adiciona registro ao cursor de resultado
                    SELECT (THIS.this_cCursorDados)
                    APPEND BLANK
                    GATHER MEMVAR
                    REPLACE Pesos  WITH loc_nPeso, ;
                            Qtds   WITH loc_nQtde, ;
                            ObsOps WITH " "

                ENDSCAN
            ENDSCAN

            *-- Preenche campo ObsOps com dados de SigCdCe
            IF USED(THIS.this_cCursorDados) AND RECCOUNT(THIS.this_cCursorDados) > 0
                SELECT (THIS.this_cCursorDados)
                GO BOTTOM

                IF !THIS.this_lAcesso
                    *-- Sem acesso resumido: apenas ultimo registro recebe ObsOps
                    loc_cConta = ContaDs
                    IF USED(THIS.this_cCursorCliE)
                        USE IN (THIS.this_cCursorCliE)
                    ENDIF
                    loc_cSQL = "SELECT ObsOps FROM SigCdCe WHERE Iclis = " + EscaparSQL(loc_cConta)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorCliE) > 0
                        SELECT (THIS.this_cCursorCliE)
                        IF !EOF()
                            loc_cObsOps = ALLTRIM(ObsOps)
                        ELSE
                            loc_cObsOps = ""
                        ENDIF
                        SELECT (THIS.this_cCursorDados)
                        REPLACE ObsOps WITH loc_cObsOps
                    ENDIF
                ELSE
                    *-- Com acesso: todos os registros recebem ObsOps de SigCdCe
                    SELECT (THIS.this_cCursorDados)
                    SCAN
                        loc_cConta = ContaDs
                        loc_cEmps  = ALLTRIM(Emps)
                        IF USED(THIS.this_cCursorCliE)
                            USE IN (THIS.this_cCursorCliE)
                        ENDIF
                        loc_cSQL = "SELECT ObsOps FROM SigCdCe WHERE Iclis = " + EscaparSQL(loc_cConta)
                        IF SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorCliE) > 0
                            SELECT (THIS.this_cCursorCliE)
                            IF !EOF()
                                loc_cObsOps = ALLTRIM(ObsOps)
                            ELSE
                                loc_cObsOps = ""
                            ENDIF
                        ELSE
                            loc_cObsOps = ""
                        ENDIF
                        SELECT (THIS.this_cCursorDados)
                        IF EMPTY(loc_cObsOps)
                            REPLACE ObsOps WITH ""
                        ELSE
                            REPLACE ObsOps WITH loc_cEmps + " " + loc_cObsOps
                        ENDIF
                    ENDSCAN
                ENDIF

                SELECT (THIS.this_cCursorDados)
                GO TOP
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em modo preview
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF USED(THIS.this_cCursorDados) AND RECCOUNT(THIS.this_cCursorDados) > 0
                    REPORT FORM (THIS.this_cArquivoRelatorio) PREVIEW NOCONSOLE
                    loc_lSucesso = .T.
                ELSE
                    MsgAviso("O Envelope N" + CHR(227) + "o Foi Encontrado!!!", "Aviso")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime com dialogo de selecao de impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF USED(THIS.this_cCursorDados) AND RECCOUNT(THIS.this_cCursorDados) > 0
                    REPORT FORM (THIS.this_cArquivoRelatorio) TO PRINTER PROMPT NOCONSOLE
                    loc_lSucesso = .T.
                ELSE
                    MsgAviso("O Envelope N" + CHR(227) + "o Foi Encontrado!!!", "Aviso")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirDireto - Prepara dados e imprime sem dialogo (exportacao/direto)
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirDireto()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF USED(THIS.this_cCursorDados) AND RECCOUNT(THIS.this_cCursorDados) > 0
                    REPORT FORM (THIS.this_cArquivoRelatorio) TO PRINTER NOCONSOLE
                    loc_lSucesso = .T.
                ELSE
                    MsgAviso("O Envelope N" + CHR(227) + "o Foi Encontrado!!!", "Aviso")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro registrada
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

ENDDEFINE
