*============================================================================
* FisBO.prg - Business Object para Configura" + CHR(231) + CHR(227) + "o de Impressora Fiscal
* Entidade  : Fis  (SIGCDFIS)
* Origem    : SigCdFis.SCX
* Arquitetura: BusinessBase sem tabela SQL - persiste em arquivo local SetFiscal.Ini
*============================================================================

DEFINE CLASS FisBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Configuracao da "tabela" - form nao tem tabela SQL Server
    *--------------------------------------------------------------------------
    this_cTabela     = ""
    this_cCampoChave = ""

    *--------------------------------------------------------------------------
    * Propriedades - campos do cursor CrSigFiFis
    * CrSigFiFis (Portas n(1), Hands c(20), Settings c(20), Dtrs L, Rtss L, Imps c(20), Termicas L)
    *--------------------------------------------------------------------------
    this_nPorta       = 1     && Porta de comunica" + CHR(231) + CHR(227) + "o COM (1-10; valor 9 = USB)
    this_cHandshaking = ""    && Tipo de HandShaking (c20): "0-None", "1-Xon Xoff", "2-RTS", ""
    this_cSettings    = ""    && Par" + CHR(226) + "metros seriais (c20): ex. "9600,n,8,1"
    this_lDtr         = .F.   && DTR enable
    this_lRts         = .F.   && RTS enable
    this_cImpressora  = ""    && Modelo de impressora fiscal (c20)
    this_lTermica     = .F.   && Impressora t" + CHR(233) + "rmica

    *--------------------------------------------------------------------------
    * Propriedades auxiliares de controle de arquivo
    *--------------------------------------------------------------------------
    this_cArqFiscal   = ""    && Path completo de SetFiscal.Ini (SYS(5)+SYS(2003)+\SetFiscal.Ini)
    this_cArqBema     = ""    && Path de BEMAFI32.INI (%SystemRoot%\system32\BEMAFI32.INI)
    this_cArqDaruma   = ""    && Path de DarumaFramework.xml (SYS(5)+SYS(2003)+\DarumaFramework.xml)

    *==========================================================================
    * Init
    * Configura BO sem tabela SQL. Resolve paths dos arquivos de configuracao.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso

        TRY
            this_cTabela     = ""
            this_cCampoChave = ""

            *-- Paths dos arquivos de configuracao fiscal
            this_cArqFiscal = SYS(5) + SYS(2003) + "\SetFiscal.Ini"
            this_cArqBema   = GETENV("SystemRoot") + "\system32\BEMAFI32.INI"
            this_cArqDaruma = SYS(5) + SYS(2003) + "\DarumaFramework.xml"

            loc_lSucesso = DODEFAULT()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FisBO.Init")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarCursor
    * Cria cursor CrSigFiFis com estrutura identica ao legado (Load event)
    *==========================================================================
    PROCEDURE InicializarCursor()
        LOCAL loc_lSucesso

        TRY
            IF USED("CrSigFiFis")
                USE IN CrSigFiFis
            ENDIF

            CREATE CURSOR CrSigFiFis (Portas n(1), Hands c(20), Settings c(20), Dtrs L, Rtss L, Imps c(20), Termicas L)

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FisBO.InicializarCursor")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDeArquivo
    * Equivalente a fLerFiscal() do legado.
    * Le SetFiscal.Ini e popula cursor CrSigFiFis com valores default.
    *==========================================================================
    PROCEDURE CarregarDeArquivo()
        LOCAL loc_lSucesso

        TRY
            IF !USED("CrSigFiFis")
                THIS.InicializarCursor()
            ENDIF

            SELECT CrSigFiFis
            ZAP

            IF FILE(THIS.this_cArqFiscal)
                APPEND FROM (THIS.this_cArqFiscal) TYPE SDF
            ENDIF

            SELECT CrSigFiFis
            GO TOP

            IF EOF()
                APPEND BLANK
            ENDIF

            IF EMPTY(CrSigFiFis.Settings)
                REPLACE CrSigFiFis.Settings WITH "9600,n,8,1"
            ENDIF

            IF ALLTRIM(CrSigFiFis.Imps) = ""
                REPLACE CrSigFiFis.Imps WITH "Em Branco   "
            ENDIF

            IF ALLTRIM(CrSigFiFis.Hands) = ""
                REPLACE CrSigFiFis.Hands WITH "Em Branco   "
            ENDIF

            THIS.CarregarDoCursor("CrSigFiFis")

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FisBO.CarregarDeArquivo")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor
    * Mapeia campos do cursor CrSigFiFis para propriedades do BO
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_nPorta       = NVL(Portas,   1)
                THIS.this_cHandshaking = ALLTRIM(NVL(Hands,    ""))
                THIS.this_cSettings    = ALLTRIM(NVL(Settings, ""))
                THIS.this_lDtr         = NVL(Dtrs,     .F.)
                THIS.this_lRts         = NVL(Rtss,     .F.)
                THIS.this_cImpressora  = ALLTRIM(NVL(Imps,     ""))
                THIS.this_lTermica     = NVL(Termicas, .F.)
                loc_lSucesso = .T.
            ELSE
                loc_lSucesso = .F.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FisBO.CarregarDoCursor")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * SalvarConfiguracao
    * Persiste configuracao em SetFiscal.Ini, BEMAFI32.INI e DarumaFramework.xml.
    * Equivalente ao Ok.Click do legado.
    *==========================================================================
    PROCEDURE SalvarConfiguracao()
        LOCAL loc_lSucesso, loc_cConfig, loc_cComs, loc_cNewCon, loc_cPor, loc_cVel

        TRY
            IF !USED("CrSigFiFis")
                MsgErro("Cursor CrSigFiFis n" + CHR(227) + "o inicializado.", ;
                        "Erro em SalvarConfiguracao")
                loc_lSucesso = .F.
            ELSE
                SELECT CrSigFiFis
                GO TOP

                *-- Normalizar "Em Branco" para vazio antes de gravar no arquivo
                IF ALLTRIM(CrSigFiFis.Imps) = "Em Branco"
                    REPLACE CrSigFiFis.Imps WITH ""
                ENDIF

                IF ALLTRIM(CrSigFiFis.Hands) = "Em Branco"
                    REPLACE CrSigFiFis.Hands WITH ""
                ENDIF

                *-- Gravar SetFiscal.Ini via SDF (formato de campo fixo)
                SELECT CrSigFiFis
                GO TOP
                COPY TO (THIS.this_cArqFiscal) TYPE SDF

                *-- Atualizar porta em BEMAFI32.INI (Bematech)
                IF FILE(THIS.this_cArqBema)
                    loc_cConfig = FILETOSTR(THIS.this_cArqBema)
                    loc_cComs   = STREXTRACT(loc_cConfig, "Porta", CHR(13) + CHR(10), 1, 1)
                    loc_cPor    = ALLTRIM(TRANSFORM(THIS.this_nPorta))
                    IF loc_cPor = "9"
                        loc_cNewCon = STRTRAN(loc_cConfig, "Porta" + loc_cComs, "Porta=USB", -1, 1, 1)
                    ELSE
                        loc_cNewCon = STRTRAN(loc_cConfig, "Porta" + loc_cComs, "Porta=COM" + loc_cPor, -1, 1, 1)
                    ENDIF
                    STRTOFILE(loc_cNewCon, THIS.this_cArqBema)
                ENDIF

                *-- Atualizar porta e velocidade em DarumaFramework.xml (Daruma)
                IF FILE(THIS.this_cArqDaruma)
                    loc_cConfig = FILETOSTR(THIS.this_cArqDaruma)
                    loc_cPor    = ALLTRIM(TRANSFORM(THIS.this_nPorta))

                    *-- Atualizar PortaSerial
                    loc_cComs   = STREXTRACT(loc_cConfig, "<PortaSerial>", CHR(13) + CHR(10), 1, 1)
                    loc_cNewCon = STRTRAN(loc_cConfig, "<PortaSerial>" + loc_cComs, ;
                                  "<PortaSerial>COM" + loc_cPor + "</PortaSerial>", -1, 1, 1)

                    *-- Atualizar Velocidade (primeiro campo antes da virgula em Settings)
                    SELECT CrSigFiFis
                    GO TOP
                    IF AT(",", ALLTRIM(CrSigFiFis.Settings)) > 0
                        loc_cVel = SUBSTR(ALLTRIM(CrSigFiFis.Settings), 1, ;
                                   AT(",", ALLTRIM(CrSigFiFis.Settings)) - 1)
                    ELSE
                        loc_cVel = "9600"
                    ENDIF
                    loc_cComs   = STREXTRACT(loc_cNewCon, "<Velocidade>", CHR(13) + CHR(10), 2, 1)
                    loc_cNewCon = STRTRAN(loc_cNewCon, "<Velocidade>" + loc_cComs, ;
                                  "<Velocidade>" + loc_cVel + "</Velocidade>", -1, 1, 1)

                    STRTOFILE(loc_cNewCon, THIS.this_cArqDaruma)
                ENDIF

                *-- Recarregar propriedades do BO apos normalizar
                THIS.CarregarDoCursor("CrSigFiFis")

                THIS.CarregarProcedureFiscal(THIS.this_cImpressora)

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FisBO.SalvarConfiguracao")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarProcedureFiscal
    * Libera procedure fiscal anterior e carrega nova conforme modelo de impressora.
    * Equivalente ao DO CASE de SET PROCEDURE no Ok.Click do legado.
    *==========================================================================
    PROCEDURE CarregarProcedureFiscal(par_cImpressora)
        LOCAL loc_lSucesso

        TRY
            *-- Liberar procedure fiscal previamente carregada
            DO CASE
                CASE ATC("SIGFIOP5", UPPER(SET("PROCEDURE"))) <> 0
                    RELEASE PROCEDURE SIGFIOP5.Prg
                CASE ATC("SIGFIOP4", UPPER(SET("PROCEDURE"))) <> 0
                    RELEASE PROCEDURE SIGFIOP4.Prg
                CASE ATC("SIGFIOP3", UPPER(SET("PROCEDURE"))) <> 0
                    RELEASE PROCEDURE SIGFIOP3.Prg
                CASE ATC("SIGFIOP0", UPPER(SET("PROCEDURE"))) <> 0
                    RELEASE PROCEDURE SIGFIOP0.Prg
                CASE ATC("SIGFIOP2", UPPER(SET("PROCEDURE"))) <> 0
                    RELEASE PROCEDURE SIGFIOP2.Prg
                CASE ATC("SIGFIOP1", UPPER(SET("PROCEDURE"))) <> 0
                    RELEASE PROCEDURE SIGFIOP1.Prg
                CASE ATC("SIGFIOP8", UPPER(SET("PROCEDURE"))) <> 0
                    RELEASE PROCEDURE SIGFIOP8.Prg
            ENDCASE

            *-- Carregar procedure correspondente ao modelo
            DO CASE
                CASE ALLTRIM(par_cImpressora) == "SWEDA"
                    SET PROCEDURE TO SIGFIOP0.Prg ADDITIVE
                CASE ALLTRIM(par_cImpressora) == "BEMATECH"
                    SET PROCEDURE TO SIGFIOP1.Prg ADDITIVE
                CASE ALLTRIM(par_cImpressora) == "BEMA8501"
                    SET PROCEDURE TO SIGFIOP2.Prg ADDITIVE
                CASE ALLTRIM(par_cImpressora) == "DATAREGIS"
                    SET PROCEDURE TO SIGFIOP3.Prg ADDITIVE
                CASE ALLTRIM(par_cImpressora) == "NDATAREGIS"
                    SET PROCEDURE TO SIGFIOP4.Prg ADDITIVE
                CASE ALLTRIM(par_cImpressora) == "DARUMA"
                    SET PROCEDURE TO SIGFIOP5.Prg ADDITIVE
                CASE ALLTRIM(par_cImpressora) == "S/IMPRESSORA"
                    SET PROCEDURE TO SIGFIOP9.Prg ADDITIVE
                CASE ALLTRIM(par_cImpressora) == "NSWEDA"
                    SET PROCEDURE TO SIGFIOP8.Prg ADDITIVE
                CASE ALLTRIM(par_cImpressora) == "EPSON"
                    SET PROCEDURE TO SIGFIOP7.Prg ADDITIVE
            ENDCASE

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FisBO.CarregarProcedureFiscal")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria
    * Form nao possui tabela SQL - retorna vazio
    *==========================================================================
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *==========================================================================
    * Inserir / Atualizar
    * Form nao usa SQL - delegam para SalvarConfiguracao
    *==========================================================================
    PROCEDURE Inserir()
        RETURN THIS.SalvarConfiguracao()
    ENDPROC

    PROCEDURE Atualizar()
        RETURN THIS.SalvarConfiguracao()
    ENDPROC

ENDDEFINE
