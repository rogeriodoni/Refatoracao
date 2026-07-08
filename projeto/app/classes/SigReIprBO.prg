*==============================================================================
* SIGREIPRBO.PRG
* Business Object para Relatorio de Mailing (SIGREIPR)
* Herda de: RelatorioBase
* Tarefa: task129
*==============================================================================

DEFINE CLASS SigReIprBO AS RelatorioBase

    *-- Filtro: selecao do mailing (SigMlItn)
    this_cCodigos          = ""
    this_cDescs            = ""

    *-- Opcoes de inclusao de campos no relatorio
    this_nImpEnderecos     = 1
    this_nImpTelefones     = 1
    this_nImpClassif       = 1
    this_nImpRepres        = 1
    this_nImpDtCom         = 1

    *-- Opcoes de ordenacao
    *-- this_nOrdemImpressao: 1=Alfab, 2=CEP, 3=DtNasc, 4=DtCasam, 5=NascConj, 6=DtComem
    this_nOrdemImpressao   = 2
    *-- this_nOrdemDirecao: 1=Descendente, 2=Ascendente
    this_nOrdemDirecao     = 2

    *-- Configuracao do relatorio
    this_cCursorDados      = "cursor_4c_MalaRelacao"
    this_cCaminhoFRX       = ""
    this_cTituloRelatorio  = ""
    this_cSubtituloRelatorio = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO do relatorio de Mailing
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cTabela             = "SigMlCab"
            THIS.this_cCampoChave         = "cIdChaves"
            THIS.this_cTituloRelatorio    = "Rela" + CHR(231) + CHR(227) + "o Para Mala Direta"
            THIS.this_cCaminhoFRX         = gc_4c_CaminhoReports + "SigMlda.frx"

            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigReIprBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta cursor Relacao e CsCabecalho para SigMlda.frx
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_nImpTel, loc_nImpEnd, loc_nImpCom, loc_nImpClf, loc_nImpRep
        LOCAL loc_cTitulo, loc_cSubTit, loc_cCodigos
        LOCAL loc_cQueryRep, loc_nRep

        loc_lSucesso = .F.
        TRY
            loc_nImpTel  = THIS.this_nImpTelefones
            loc_nImpEnd  = THIS.this_nImpEnderecos
            loc_nImpCom  = THIS.this_nImpDtCom
            loc_nImpClf  = THIS.this_nImpClassif
            loc_nImpRep  = THIS.this_nImpRepres
            loc_cCodigos = ALLTRIM(THIS.this_cCodigos)

            loc_cTitulo = "Rela" + CHR(231) + CHR(227) + "o Para Mala Direta"
            loc_cSubTit = loc_cCodigos + " - " + ALLTRIM(THIS.this_cDescs)

            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF
            CREATE CURSOR CsCabecalho (Titulo C(100), SubTitulo C(100))
            INSERT INTO CsCabecalho (Titulo, SubTitulo) VALUES (loc_cTitulo, loc_cSubTit)

            IF USED("cursor_4c_MalaCab")
                USE IN cursor_4c_MalaCab
            ENDIF

            loc_cSQL = "SELECT a.IClis, a.RClis, a.Profiss, " + ;
                       "a.Nascs, a.UltComps, a.Sexos, a.Tel1s, a.Tel2s, " + ;
                       "a.Endes, a.Nums, a.Compls, a.Bairs, a.Cidas, " + ;
                       "a.Ceps, a.Estas, a.Quebras, " + ;
                       "a.cIdChaves, b.DDDs, a.DesDtCom, a.DatDtCom, " + ;
                       "a.cpfs, a.TelDtCom, a.DtCasas, " + ;
                       "a.DtnCons, b.eMails, b.Codigos " + ;
                       "FROM SigMlCab a INNER JOIN SigCdCli b ON b.IClis = a.IClis " + ;
                       "WHERE a.Codigos = " + EscaparSQL(loc_cCodigos) + " " + ;
                       "ORDER BY a.IClis, a.RClis"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MalaCab")

            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados de mala direta"
            ELSE
                IF USED("Relacao")
                    USE IN Relacao
                ENDIF

                SELECT IClis, RClis, Profiss, ;
                       NVL(Nascs, {}) AS Nascs, ;
                       NVL(UltComps, {}) AS UltComps, ;
                       Sexos, Tel1s, Tel2s, ;
                       Endes, Nums, Compls, Bairs, Cidas, Ceps, Estas, Quebras, ;
                       loc_nImpTel AS ImpTel, ;
                       loc_nImpEnd AS ImpEnd, ;
                       loc_nImpCom AS ImpCom, ;
                       loc_nImpClf AS ImpClf, ;
                       loc_nImpRep AS ImpRep, ;
                       DDDs, DesDtCom, ;
                       NVL(IIF(YEAR(DatDtCom) <= 1900, .NULL., DatDtCom), {}) AS DatDtCom, ;
                       cpfs, TelDtCom, ;
                       NVL(DtCasas, {}) AS DtCasas, ;
                       NVL(DtnCons, {}) AS DtnCons, ;
                       eMails, Codigos, ;
                       SPACE(10) AS CodReps ;
                FROM cursor_4c_MalaCab ;
                INTO CURSOR Relacao READWRITE

                IF loc_nImpRep = 1
                    SELECT Relacao
                    SCAN
                        IF USED("cursor_4c_LocalCli")
                            USE IN cursor_4c_LocalCli
                        ENDIF
                        loc_cQueryRep = "SELECT ContaVens FROM SigCdCli " + ;
                                       "WHERE IClis = " + ;
                                       EscaparSQL(ALLTRIM(Relacao.IClis))
                        loc_nRep = SQLEXEC(gnConnHandle, loc_cQueryRep, ;
                                           "cursor_4c_LocalCli")
                        IF loc_nRep > 0
                            SELECT cursor_4c_LocalCli
                            GO TOP
                            IF !EOF()
                                REPLACE CodReps WITH ;
                                        ALLTRIM(cursor_4c_LocalCli.ContaVens) ;
                                        IN Relacao
                            ENDIF
                            USE IN cursor_4c_LocalCli
                        ENDIF
                    ENDSCAN
                ENDIF

                SELECT Relacao
                THIS.AplicarOrdenacao()
                GO TOP IN Relacao

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SigReIprBO.PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarOrdenacao - Indexa cursor Relacao conforme opcoes de ordenacao
    *--------------------------------------------------------------------------
    PROCEDURE AplicarOrdenacao()
        LOCAL loc_nOrdem, loc_nDirecao, loc_cDesc
        loc_nOrdem   = THIS.this_nOrdemImpressao
        loc_nDirecao = THIS.this_nOrdemDirecao
        loc_cDesc    = IIF(loc_nDirecao = 1, " DESCENDING", "")

        SELECT Relacao
        DO CASE
            CASE loc_nOrdem = 1
                IF loc_nDirecao = 1
                    INDEX ON Quebras + RClis + IClis DESCENDING TAG RClis
                ELSE
                    INDEX ON Quebras + RClis + IClis TAG RClis
                ENDIF
            CASE loc_nOrdem = 2
                IF loc_nDirecao = 1
                    INDEX ON Quebras + Ceps + IClis DESCENDING TAG Ceps
                ELSE
                    INDEX ON Quebras + Ceps + IClis TAG Ceps
                ENDIF
            CASE loc_nOrdem = 3
                IF loc_nDirecao = 1
                    INDEX ON Quebras + SUBSTR(DTOS(Nascs), 5) + IClis DESCENDING TAG Nascs
                ELSE
                    INDEX ON Quebras + SUBSTR(DTOS(Nascs), 5) + IClis TAG Nascs
                ENDIF
            CASE loc_nOrdem = 4
                IF loc_nDirecao = 1
                    INDEX ON Quebras + SUBSTR(DTOS(DtCasas), 5) + IClis DESCENDING TAG Nascs
                ELSE
                    INDEX ON Quebras + SUBSTR(DTOS(DtCasas), 5) + IClis TAG Nascs
                ENDIF
            CASE loc_nOrdem = 5
                IF loc_nDirecao = 1
                    INDEX ON Quebras + SUBSTR(DTOS(DtnCons), 5) + IClis DESCENDING TAG Nascs
                ELSE
                    INDEX ON Quebras + SUBSTR(DTOS(DtnCons), 5) + IClis TAG Nascs
                ENDIF
            CASE loc_nOrdem = 6
                IF loc_nDirecao = 1
                    INDEX ON Quebras + SUBSTR(DTOS(DatDtCom), 5) + IClis DESCENDING TAG Nascs
                ELSE
                    INDEX ON Quebras + SUBSTR(DTOS(DatDtCom), 5) + IClis TAG Nascs
                ENDIF
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Executa relatorio em modo preview
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cCaminhoFRX) PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SigReIprBO.Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Executa relatorio para impressora com dialogo de selecao
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cCaminhoFRX) TO PRINTER PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SigReIprBO.Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Documento - Executa relatorio para impressora sem dialogo
    *--------------------------------------------------------------------------
    PROCEDURE Documento()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cCaminhoFRX) TO PRINTER
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SigReIprBO.Documento")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna codigo do mailing selecionado
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigos)
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro registrada
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores abertos pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_MalaCab")
            USE IN cursor_4c_MalaCab
        ENDIF
        IF USED("CsCabecalho")
            USE IN CsCabecalho
        ENDIF
        IF USED("Relacao")
            USE IN Relacao
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
