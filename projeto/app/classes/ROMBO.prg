*====================================================================
* ROMBO.prg - Business Object para Romaneio XML
* Migrado de: SIGCDROM.SCX
* Tabelas: SigCdRom (cabecalho) + SigCdRoI (chaves NF-e)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS ROMBO AS BusinessBase

    *-- Propriedades da entidade (SigCdRom)
    this_cCodigo     = ""     && Codigo    CHAR(10) - PK gerado por fGerUniqueKey('XMLROM')
    this_dDatas      = {}     && Datas     DATE
    this_cTipo       = ""     && Tipo      CHAR(1) - 'R'=Recebimento, else Romaneio
    this_cCodTransp  = ""     && CodTransp CHAR - cod transportadora
    this_cContas     = ""     && Contas    CHAR - cod cliente (iClis)
    this_cDepOrig    = ""     && DepOrig   CHAR - cod departamento origem
    this_cDepDest    = ""     && DepDest   CHAR - cod departamento destino
    this_cObs        = ""     && Obs       CHAR
    this_nNAceite    = 0      && nAceite   NUMERIC(1) - 0=pendente, 1=aceito
    this_dDataAct    = {}     && DataAct   DATE - data aceite
    this_cUsuarios   = ""     && Usuarios  CHAR - usuario que aceitou
    this_nValor      = 0      && Valor     NUMERIC
    this_cCidChaves  = ""     && CidChaves CHAR(20)
    this_lCodigoGerado = .F.  && flag: codigo foi pre-gerado (para cancelamento)

    *====================================================================
    * Init
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdRom"
        THIS.this_cCampoChave = "Codigo"
        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - para auditoria
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDPROC

    *====================================================================
    * Buscar - Busca registros com filtro de periodo e tipo
    *====================================================================
    PROCEDURE Buscar(par_dDataIni, par_dDataFim, par_cTipo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_aErro[1]
        LOCAL loc_cDataIni, loc_cDataFim
        loc_lResultado = .F.

        TRY
            loc_cDataIni = FormatarDataSQL(par_dDataIni)
            loc_cDataFim = FormatarDataSQL(IIF(EMPTY(par_dDataFim), par_dDataIni, par_dDataFim))

            loc_cSQL = "SELECT a.Codigo, a.Datas, a.Tipo, a.CodTransp, " + ;
                       "ISNULL(b.Razaos,'') AS Razaos, " + ;
                       "a.Contas, ISNULL(c.RClis,'') AS RClis, " + ;
                       "a.DepOrig, ISNULL(h.Descricaos,'') AS dDepOrig, " + ;
                       "a.DepDest, ISNULL(i.Descricaos,'') AS dDepDest, " + ;
                       "LEFT(ISNULL(a.Obs,''),20) AS ObsRed, " + ;
                       "a.Valor, a.Usuarios, a.DataAct, " + ;
                       "ISNULL(a.nAceite,0) AS nAceite, " + ;
                       "CASE WHEN ISNULL(a.nAceite,0)=1 THEN 'S' ELSE 'N' END AS aceite, " + ;
                       "a.CidChaves " + ;
                       "FROM SigCdRom a " + ;
                       "LEFT JOIN SigPrTrp b ON a.CodTransp = b.ITras " + ;
                       "LEFT JOIN SigCdCli c ON a.Contas = c.IClis " + ;
                       "LEFT JOIN SigCdDpt h ON a.DepOrig = h.Codigos " + ;
                       "LEFT JOIN SigCdDpt i ON a.DepDest = i.Codigos " + ;
                       "WHERE a.Datas BETWEEN " + loc_cDataIni + " AND " + loc_cDataFim + ;
                       " AND a.Tipo = " + EscaparSQL(par_cTipo) + ;
                       " ORDER BY a.Datas DESC, a.Codigo"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTemp")

            IF loc_nResultado >= 0
                IF USED("cursor_4c_Dados")
                    SELECT cursor_4c_Dados
                    ZAP
                    IF RECCOUNT("cursor_4c_DadosTemp") > 0
                        APPEND FROM DBF("cursor_4c_DadosTemp")
                    ENDIF
                ENDIF
                IF USED("cursor_4c_DadosTemp")
                    USE IN cursor_4c_DadosTemp
                ENDIF
                loc_lResultado = .T.
            ELSE
                AERROR(loc_aErro)
                THIS.this_cMensagemErro = "Erro ao buscar romaneios: " + loc_aErro[1,2]
                MsgErro(THIS.this_cMensagemErro, "ROMBO.Buscar")
                loc_lResultado = .F.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha:" + TRANSFORM(loc_oErro.LineNo) + ")", ;
                "ROMBO.Buscar")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades a partir do cursor ativo
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAlias)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !USED(par_cAlias)
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAlias)
            THIS.this_cCodigo    = ALLTRIM(Codigo)
            THIS.this_dDatas     = Datas
            THIS.this_cTipo      = ALLTRIM(Tipo)
            THIS.this_cCodTransp = ALLTRIM(CodTransp)
            THIS.this_cContas    = ALLTRIM(Contas)
            THIS.this_cDepOrig   = ALLTRIM(DepOrig)
            THIS.this_cDepDest   = ALLTRIM(DepDest)
            THIS.this_nNAceite   = nAceite
            THIS.this_nValor     = Valor
            THIS.this_cCidChaves = ALLTRIM(CidChaves)
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha:" + TRANSFORM(loc_oErro.LineNo) + ")", ;
                "ROMBO.CarregarDoCursor")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro completo do SigCdRom
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT a.*, ISNULL(a.Obs,'') AS ObsVal FROM SigCdRom a " + ;
                "WHERE a.Codigo = " + EscaparSQL(par_cCodigo), ;
                "cursor_4c_RomLoad")

            IF loc_nResult > 0 AND USED("cursor_4c_RomLoad") AND RECCOUNT("cursor_4c_RomLoad") > 0
                SELECT cursor_4c_RomLoad
                THIS.this_cCodigo    = ALLTRIM(Codigo)
                THIS.this_dDatas     = Datas
                THIS.this_cTipo      = ALLTRIM(Tipo)
                THIS.this_cCodTransp = ALLTRIM(ISNULL(CodTransp, ""))
                THIS.this_cContas    = ALLTRIM(ISNULL(Contas, ""))
                THIS.this_cDepOrig   = ALLTRIM(ISNULL(DepOrig, ""))
                THIS.this_cDepDest   = ALLTRIM(ISNULL(DepDest, ""))
                THIS.this_cObs       = ALLTRIM(ISNULL(ObsVal, ""))
                THIS.this_nNAceite   = ISNULL(nAceite, 0)
                THIS.this_dDataAct   = DataAct
                THIS.this_cUsuarios  = ALLTRIM(ISNULL(Usuarios, ""))
                THIS.this_nValor     = ISNULL(Valor, 0)
                THIS.this_cCidChaves = ALLTRIM(ISNULL(CidChaves, ""))
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ROMBO.CarregarPorCodigo")
        ENDTRY

        IF USED("cursor_4c_RomLoad")
            USE IN cursor_4c_RomLoad
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * GerarCodigo - Reserva novo codigo via fGerUniqueKey
    *====================================================================
    PROCEDURE GerarCodigo()
        LOCAL loc_lResultado, loc_nChave
        loc_lResultado = .F.

        TRY
            loc_nChave = fGerUniqueKey("XMLROM")
            IF loc_nChave > 0
                THIS.this_cCodigo       = ALLTRIM(STR(loc_nChave, 10))
                THIS.this_lCodigoGerado = .T.
                THIS.this_cCidChaves    = LEFT(SYS(2015) + SYS(2015), 20)
                THIS.this_dDatas        = DATE()
                THIS.this_nNAceite      = 0
                THIS.this_nValor        = 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Falha ao gerar c" + CHR(243) + "digo do romaneio.", "ROMBO.GerarCodigo")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ROMBO.GerarCodigo")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * CancelarCodigo - Libera codigo reservado nao utilizado
    *====================================================================
    PROCEDURE CancelarCodigo()
        IF THIS.this_lCodigoGerado AND !EMPTY(THIS.this_cCodigo)
            TRY
                fCanUniqueKey(VAL(THIS.this_cCodigo), "XMLROM")
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "ROMBO.CancelarCodigo")
            ENDTRY
            THIS.this_lCodigoGerado = .F.
        ENDIF
    ENDPROC

    *====================================================================
    * Inserir (PROTECTED) - INSERT INTO SigCdRom
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_aErro[1]
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdRom " + ;
                "(Codigo, Datas, Tipo, CodTransp, Contas, DepOrig, DepDest, Obs, " + ;
                "nAceite, Valor, CidChaves, Usuarios) " + ;
                "VALUES (" + ;
                EscaparSQL(THIS.this_cCodigo)                     + ", " + ;
                FormatarDataSQL(THIS.this_dDatas)                 + ", " + ;
                EscaparSQL(THIS.this_cTipo)                       + ", " + ;
                EscaparSQL(THIS.this_cCodTransp)                  + ", " + ;
                EscaparSQL(THIS.this_cContas)                     + ", " + ;
                EscaparSQL(THIS.this_cDepOrig)                    + ", " + ;
                EscaparSQL(THIS.this_cDepDest)                    + ", " + ;
                EscaparSQL(THIS.this_cObs)                        + ", " + ;
                FormatarNumeroSQL(THIS.this_nNAceite, 0)          + ", " + ;
                FormatarNumeroSQL(THIS.this_nValor, 2)            + ", " + ;
                EscaparSQL(THIS.this_cCidChaves)                  + ", " + ;
                EscaparSQL(gc_4c_UsuarioLogado)                   + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.this_lCodigoGerado = .F.
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                AERROR(loc_aErro)
                THIS.this_cMensagemErro = "Erro ao inserir romaneio: " + loc_aErro[1,2]
                MsgErro(THIS.this_cMensagemErro, "ROMBO.Inserir")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha:" + TRANSFORM(loc_oErro.LineNo) + ")", ;
                "ROMBO.Inserir")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * Atualizar (PROTECTED) - DELETE+INSERT (padrao legado)
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_aErro[1]
        loc_lResultado = .F.

        TRY
            *-- Exclui itens e cabecalho antigos
            loc_cSQL = "DELETE FROM SigCdRoI WHERE Codigo = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                loc_cSQL = "DELETE FROM SigCdRom WHERE Codigo = " + EscaparSQL(THIS.this_cCodigo)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            ENDIF

            IF loc_nResultado >= 0
                *-- Re-insere cabecalho
                loc_cSQL = "INSERT INTO SigCdRom " + ;
                    "(Codigo, Datas, Tipo, CodTransp, Contas, DepOrig, DepDest, Obs, " + ;
                    "nAceite, Valor, CidChaves, Usuarios) " + ;
                    "VALUES (" + ;
                    EscaparSQL(THIS.this_cCodigo)                     + ", " + ;
                    FormatarDataSQL(THIS.this_dDatas)                 + ", " + ;
                    EscaparSQL(THIS.this_cTipo)                       + ", " + ;
                    EscaparSQL(THIS.this_cCodTransp)                  + ", " + ;
                    EscaparSQL(THIS.this_cContas)                     + ", " + ;
                    EscaparSQL(THIS.this_cDepOrig)                    + ", " + ;
                    EscaparSQL(THIS.this_cDepDest)                    + ", " + ;
                    EscaparSQL(THIS.this_cObs)                        + ", " + ;
                    FormatarNumeroSQL(THIS.this_nNAceite, 0)          + ", " + ;
                    FormatarNumeroSQL(THIS.this_nValor, 2)            + ", " + ;
                    EscaparSQL(THIS.this_cCidChaves)                  + ", " + ;
                    EscaparSQL(gc_4c_UsuarioLogado)                   + ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                AERROR(loc_aErro)
                THIS.this_cMensagemErro = "Erro ao atualizar romaneio: " + loc_aErro[1,2]
                MsgErro(THIS.this_cMensagemErro, "ROMBO.Atualizar")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha:" + TRANSFORM(loc_oErro.LineNo) + ")", ;
                "ROMBO.Atualizar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * ExecutarExclusao (PROTECTED) - DELETE FROM ambas as tabelas
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_aErro[1]
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdRoI WHERE Codigo = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                loc_cSQL = "DELETE FROM SigCdRom WHERE Codigo = " + EscaparSQL(THIS.this_cCodigo)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                AERROR(loc_aErro)
                THIS.this_cMensagemErro = "Erro ao excluir romaneio: " + loc_aErro[1,2]
                MsgErro(THIS.this_cMensagemErro, "ROMBO.ExecutarExclusao")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha:" + TRANSFORM(loc_oErro.LineNo) + ")", ;
                "ROMBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * Aceitar - Marca romaneio como aceito
    *====================================================================
    PROCEDURE Aceitar(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_aErro[1]
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdRom SET " + ;
                "nAceite = 1, " + ;
                "DataAct = " + FormatarDataSQL(DATE()) + ", " + ;
                "Usuarios = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                " WHERE Codigo = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("ACEITAR")
                loc_lResultado = .T.
            ELSE
                AERROR(loc_aErro)
                THIS.this_cMensagemErro = "Erro ao aceitar romaneio: " + loc_aErro[1,2]
                MsgErro(THIS.this_cMensagemErro, "ROMBO.Aceitar")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ROMBO.Aceitar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * SalvarChaves - Salva itens (SigCdRoI) apos salvar cabecalho
    *====================================================================
    PROCEDURE SalvarChaves(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_aErro[1]
        LOCAL loc_cChave, loc_cCidChaves
        loc_lResultado = .F.

        TRY
            IF !USED("cursor_4c_Chaves")
                RETURN .T.
            ENDIF

            SELECT cursor_4c_Chaves
            GO TOP

            SCAN
                loc_cChave = ALLTRIM(cursor_4c_Chaves.Chave)
                IF EMPTY(loc_cChave)
                    LOOP
                ENDIF

                loc_cCidChaves = ALLTRIM(cursor_4c_Chaves.cIdChaves)
                IF EMPTY(loc_cCidChaves)
                    loc_cCidChaves = LEFT(SYS(2015) + SYS(2015), 20)
                ENDIF

                loc_cSQL = "INSERT INTO SigCdRoI (Codigo, Chave, cIdChaves) " + ;
                    "VALUES (" + ;
                    EscaparSQL(par_cCodigo) + ", " + ;
                    EscaparSQL(loc_cChave)  + ", " + ;
                    EscaparSQL(loc_cCidChaves) + ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado < 0
                    AERROR(loc_aErro)
                    THIS.this_cMensagemErro = "Erro ao salvar chave: " + loc_aErro[1,2]
                    MsgErro(THIS.this_cMensagemErro, "ROMBO.SalvarChaves")
                    RETURN .F.
                ENDIF
            ENDSCAN

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha:" + TRANSFORM(loc_oErro.LineNo) + ")", ;
                "ROMBO.SalvarChaves")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * CarregarChaves - Carrega SigCdRoI em cursor_4c_Chaves
    *====================================================================
    PROCEDURE CarregarChaves(par_cCodigo)
        LOCAL loc_lResultado, loc_nResult, loc_aErro[1]
        loc_lResultado = .F.

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Codigo, Chave, ISNULL(cIdChaves,'') AS cIdChaves " + ;
                "FROM SigCdRoI WHERE Codigo = " + EscaparSQL(par_cCodigo) + ;
                " ORDER BY Chave", ;
                "cursor_4c_ChavesTemp")

            IF loc_nResult >= 0
                IF USED("cursor_4c_Chaves")
                    SELECT cursor_4c_Chaves
                    ZAP
                    IF RECCOUNT("cursor_4c_ChavesTemp") > 0
                        APPEND FROM DBF("cursor_4c_ChavesTemp")
                    ENDIF
                ENDIF
                IF USED("cursor_4c_ChavesTemp")
                    USE IN cursor_4c_ChavesTemp
                ENDIF
                loc_lResultado = .T.
            ELSE
                AERROR(loc_aErro)
                MsgErro("Erro ao carregar chaves: " + loc_aErro[1,2], "ROMBO.CarregarChaves")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ROMBO.CarregarChaves")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * ObterTotalChaves - Conta chaves nao vazias em cursor_4c_Chaves
    *====================================================================
    PROCEDURE ObterTotalChaves()
        LOCAL loc_nTotal, loc_nOldSel
        loc_nTotal  = 0
        loc_nOldSel = SELECT()

        IF USED("cursor_4c_Chaves")
            SELECT COUNT(*) AS Qtd FROM cursor_4c_Chaves ;
                WHERE !EMPTY(Chave) INTO CURSOR cursor_4c_TotalTemp READWRITE
            IF USED("cursor_4c_TotalTemp") AND RECCOUNT("cursor_4c_TotalTemp") > 0
                SELECT cursor_4c_TotalTemp
                loc_nTotal = cursor_4c_TotalTemp.Qtd
                USE IN cursor_4c_TotalTemp
            ENDIF
        ENDIF

        SELECT (loc_nOldSel)
        RETURN loc_nTotal
    ENDPROC

    *====================================================================
    * ValidarChave - Verifica se chave NF-e tem GNRE pendente
    * Retorna .T. para continuar, .F. para cancelar insercao
    *====================================================================
    PROCEDURE ValidarChave(par_cChave)
        LOCAL loc_lResultado, loc_nResult
        loc_lResultado = .T.

        IF EMPTY(par_cChave) OR LEN(ALLTRIM(par_cChave)) <> 44
            RETURN .T.
        ENDIF

        TRY
            *-- Busca NF-e e UF de destino
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 nfechv, nfexml FROM SigMvNfi " + ;
                "WHERE nfechv = " + EscaparSQL(par_cChave), ;
                "cursor_4c_NfiTemp")

            IF loc_nResult > 0 AND USED("cursor_4c_NfiTemp") AND RECCOUNT("cursor_4c_NfiTemp") > 0
                SELECT cursor_4c_NfiTemp
                LOCAL loc_cXml, loc_cDestino, loc_cUF
                loc_cXml     = ALLTRIM(ISNULL(nfexml, ""))
                loc_cDestino = STREXTRACT(loc_cXml, "<enderDest>", "</enderDest>")
                loc_cUF      = STREXTRACT(loc_cDestino, "<UF>", "</UF>")

                IF !EMPTY(loc_cUF)
                    LOCAL loc_nResUf
                    loc_nResUf = SQLEXEC(gnConnHandle, ;
                        "SELECT estados, chkgnre FROM SigCdUfs " + ;
                        "WHERE estados = " + EscaparSQL(loc_cUF), ;
                        "cursor_4c_UfsTemp")

                    IF loc_nResUf > 0 AND USED("cursor_4c_UfsTemp") AND RECCOUNT("cursor_4c_UfsTemp") > 0
                        SELECT cursor_4c_UfsTemp
                        IF ISNULL(chkgnre, 0) = 1
                            IF !MsgConfirma("NF com inscri" + CHR(231) + CHR(227) + "o pendente." + ;
                                CHR(13) + "Guia GNRE foi paga?", "Aten" + CHR(231) + CHR(227) + "o")
                                loc_lResultado = .F.
                            ENDIF
                        ENDIF
                    ENDIF
                    IF USED("cursor_4c_UfsTemp")
                        USE IN cursor_4c_UfsTemp
                    ENDIF
                ENDIF
            ENDIF

            IF USED("cursor_4c_NfiTemp")
                USE IN cursor_4c_NfiTemp
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ROMBO.ValidarChave")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * BuscarTransportadora - Retorna dados da transportadora
    *====================================================================
    PROCEDURE BuscarTransportadora(par_cCodigo)
        LOCAL loc_cRazao, loc_cIdTransp, loc_nResult
        loc_cRazao    = ""
        loc_cIdTransp = ""

        IF !EMPTY(par_cCodigo)
            TRY
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT ITras, Razaos, ISNULL(IdTransp,'') AS IdTransp " + ;
                    "FROM SigPrTrp WHERE ITras = " + EscaparSQL(par_cCodigo), ;
                    "cursor_4c_TrpTemp")
                IF loc_nResult > 0 AND USED("cursor_4c_TrpTemp") AND RECCOUNT("cursor_4c_TrpTemp") > 0
                    SELECT cursor_4c_TrpTemp
                    loc_cRazao    = ALLTRIM(ISNULL(Razaos, ""))
                    loc_cIdTransp = ALLTRIM(IdTransp)
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "ROMBO.BuscarTransportadora")
            ENDTRY
            IF USED("cursor_4c_TrpTemp")
                USE IN cursor_4c_TrpTemp
            ENDIF
        ENDIF

        RETURN loc_cRazao + CHR(9) + loc_cIdTransp
    ENDPROC

    *====================================================================
    * BuscarDepartamento - Retorna descricao do departamento
    *====================================================================
    PROCEDURE BuscarDepartamento(par_cCodigo)
        LOCAL loc_cDesc, loc_nResult
        loc_cDesc = ""

        IF !EMPTY(par_cCodigo)
            TRY
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT Descricaos FROM SigCdDpt " + ;
                    "WHERE Codigos = " + EscaparSQL(par_cCodigo), ;
                    "cursor_4c_DptTemp")
                IF loc_nResult > 0 AND USED("cursor_4c_DptTemp") AND RECCOUNT("cursor_4c_DptTemp") > 0
                    SELECT cursor_4c_DptTemp
                    loc_cDesc = ALLTRIM(ISNULL(Descricaos, ""))
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "ROMBO.BuscarDepartamento")
            ENDTRY
            IF USED("cursor_4c_DptTemp")
                USE IN cursor_4c_DptTemp
            ENDIF
        ENDIF

        RETURN loc_cDesc
    ENDPROC

    *====================================================================
    * BuscarCliente - Retorna dados do cliente
    *====================================================================
    PROCEDURE BuscarCliente(par_cIClis)
        LOCAL loc_cRClis, loc_cCpfs, loc_nResult
        loc_cRClis = ""
        loc_cCpfs  = ""

        IF !EMPTY(par_cIClis)
            TRY
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT IClis, RClis, ISNULL(Cpfs,'') AS Cpfs " + ;
                    "FROM SigCdCli WHERE IClis = " + EscaparSQL(par_cIClis), ;
                    "cursor_4c_CliTemp")
                IF loc_nResult > 0 AND USED("cursor_4c_CliTemp") AND RECCOUNT("cursor_4c_CliTemp") > 0
                    SELECT cursor_4c_CliTemp
                    loc_cRClis = ALLTRIM(ISNULL(RClis, ""))
                    loc_cCpfs  = ALLTRIM(Cpfs)
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "ROMBO.BuscarCliente")
            ENDTRY
            IF USED("cursor_4c_CliTemp")
                USE IN cursor_4c_CliTemp
            ENDIF
        ENDIF

        RETURN loc_cRClis + CHR(9) + loc_cCpfs
    ENDPROC

    *====================================================================
    * Imprimir - Executa relatorio SIGCDROM.frx
    *====================================================================
    PROCEDURE Imprimir(par_cTipo, par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cFrx
        loc_lResultado = .F.

        TRY
            loc_cFrx = gc_4c_CaminhoReports + "SIGCDROM.FRX"
            IF !FILE(loc_cFrx)
                MsgErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + ;
                    CHR(13) + loc_cFrx, "ROMBO.Imprimir")
                RETURN .F.
            ENDIF

            loc_cSQL = "SELECT a.*, " + ;
                "ISNULL(c.Razaos,'') AS Razaos, " + ;
                "ISNULL(d.RClis,'') AS RClis, " + ;
                "ISNULL(d.Cpfs,'') AS Cpfs, " + ;
                "b.Chave, " + ;
                "CONVERT(VARCHAR(4), REPLICATE('0',4-LEN(CONVERT(VARCHAR(4), " + ;
                "ROW_NUMBER() OVER(ORDER BY b.Chave ASC)))) + " + ;
                "CONVERT(VARCHAR(4),ROW_NUMBER() OVER(ORDER BY b.Chave ASC))) AS Ids, " + ;
                "ISNULL(e.empdopnums,'') AS empdopnums, " + ;
                "ISNULL(f.pedidoweb,'') AS pedidoweb, " + ;
                "ISNULL(f.cdrastreio,'') AS cdrastreio, " + ;
                "ISNULL(f.notas,'') AS notas, " + ;
                "ISNULL(e.series,'') AS series, " + ;
                "ISNULL(g.RClis,'') AS nome, " + ;
                "ISNULL(h.Descricaos,'') AS dDepOrig, " + ;
                "ISNULL(i.Descricaos,'') AS dDepDest " + ;
                "FROM SigCdRom a " + ;
                "JOIN SigCdRoI b ON a.Codigo = b.Codigo " + ;
                "LEFT JOIN SigPrTrp c ON a.CodTransp = c.ITras " + ;
                "LEFT JOIN SigCdCli d ON a.Contas = d.IClis " + ;
                "LEFT JOIN SigMvNfi e ON b.Chave = e.nfechv " + ;
                "LEFT JOIN SigMvCab f ON e.empdopnums = f.empdopnums " + ;
                "LEFT JOIN SigCdCli g ON f.contads = g.IClis " + ;
                "LEFT JOIN SigCdDpt h ON a.DepOrig = h.Codigos " + ;
                "LEFT JOIN SigCdDpt i ON a.DepDest = i.Codigos " + ;
                "WHERE a.Codigo = " + EscaparSQL(par_cCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "csRel")

            IF loc_nResult > 0 AND USED("csRel") AND RECCOUNT("csRel") > 0
                SELECT csRel
                INDEX ON Ids TAG Ids
                GO TOP

                IF par_cTipo = "V"
                    REPORT FORM (loc_cFrx) PREVIEW NOCONSOLE
                ELSE
                    REPORT FORM (loc_cFrx) TO PRINTER PROMPT NOCONSOLE
                ENDIF

                loc_lResultado = .T.
            ELSE
                MsgAviso("Nenhum dado encontrado para impress" + CHR(227) + "o.", "Imprimir")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha:" + TRANSFORM(loc_oErro.LineNo) + ")", ;
                "ROMBO.Imprimir")
        ENDTRY

        IF USED("csRel")
            USE IN csRel
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * BuscarClientePorCpf - Busca cliente por CPF/CNPJ
    *====================================================================
    PROCEDURE BuscarClientePorCpf(par_cCpf)
        LOCAL loc_cIClis, loc_cRClis, loc_cCpfs, loc_nResult
        loc_cIClis = ""
        loc_cRClis = ""
        loc_cCpfs  = ""

        IF !EMPTY(par_cCpf)
            TRY
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT IClis, RClis, ISNULL(Cpfs,'') AS Cpfs " + ;
                    "FROM SigCdCli WHERE REPLACE(REPLACE(REPLACE(Cpfs,'.',''),'-',''),'/','') = " + ;
                    EscaparSQL(STRTRAN(STRTRAN(STRTRAN(par_cCpf, ".", ""), "-", ""), "/", "")), ;
                    "cursor_4c_CliCpfTemp")
                IF loc_nResult > 0 AND USED("cursor_4c_CliCpfTemp") AND RECCOUNT("cursor_4c_CliCpfTemp") > 0
                    SELECT cursor_4c_CliCpfTemp
                    loc_cIClis = ALLTRIM(IClis)
                    loc_cRClis = ALLTRIM(ISNULL(RClis, ""))
                    loc_cCpfs  = ALLTRIM(Cpfs)
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "ROMBO.BuscarClientePorCpf")
            ENDTRY
            IF USED("cursor_4c_CliCpfTemp")
                USE IN cursor_4c_CliCpfTemp
            ENDIF
        ENDIF

        RETURN loc_cIClis + CHR(9) + loc_cRClis + CHR(9) + loc_cCpfs
    ENDPROC

ENDDEFINE
