*==============================================================================
* sigprpdfBO.prg - Business Object: Gera????o de PDF/XLS e E-mail
* Herda de: BusinessBase
* Tipo: OPERACIONAL (auxiliar modal - sem CRUD)
* Tabela: SigCdEmp (somente leitura para config. de email)
*==============================================================================
DEFINE CLASS sigprpdfBO AS BusinessBase

    *-- Configuracao da entidade (sem tabela de CRUD)
    this_cTabela     = ""
    this_cCampoChave = ""

    *-- Diretorio e arquivo de saida
    this_cDiretorio     = ""
    this_cArquivoSaida  = ""
    this_nTipoArquivo   = 1

    *-- Disponibilidade do PDFCreator (verificado via registry)
    this_lPdfDisponivel = .F.

    *-- Dados de email da empresa (vindos de SigCdEmp)
    this_cEmailEmpresaDe = ""
    this_cSmtpServidor   = ""
    this_cSmtpSenha      = ""
    this_cSmtpPasta      = ""
    this_nSmtpPorta      = 0

    *-- Dados do email a enviar
    this_lEnviarEmail   = .F.
    this_cEmailPara     = ""
    this_cEmailCC       = ""
    this_cEmailAssunto  = ""
    this_cEmailCorpo    = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        this_cTabela     = ""
        this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarEmailEmpresa()
    *-- Busca configuracoes de email da empresa em SigCdEmp
    *--------------------------------------------------------------------------
        LOCAL loc_cSQL, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT PadEmails, PadServs, PadSenhas, pastas, PadPortas " + ;
                       "FROM SigCdEmp " + ;
                       "WHERE CEmps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

            IF USED("cursor_4c_EmailEmp")
                USE IN cursor_4c_EmailEmp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmailEmp") < 1
                MsgErro("Falha ao carregar dados de email da empresa.", "Erro")
            ELSE
                IF RECCOUNT("cursor_4c_EmailEmp") > 0
                    SELECT cursor_4c_EmailEmp
                    THIS.this_cEmailEmpresaDe = LOWER(ALLTRIM(NVL(PadEmails, "")))
                    THIS.this_cSmtpServidor   = LOWER(ALLTRIM(NVL(PadServs,  "")))
                    THIS.this_cSmtpSenha      = ALLTRIM(NVL(PadSenhas, ""))
                    THIS.this_cSmtpPasta      = ALLTRIM(NVL(pastas,    ""))
                    THIS.this_nSmtpPorta      = NVL(PadPortas, 0)
                ENDIF
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ValidarParaSalvar()
    *-- Valida campos obrigatorios antes de gravar
    *--------------------------------------------------------------------------
        LOCAL loc_lOk

        loc_lOk = .T.

        IF EMPTY(THIS.this_cArquivoSaida)
            MsgAviso("Selecione um nome para o arquivo!", "Aten" + CHR(231) + CHR(227) + "o")
            loc_lOk = .F.
        ENDIF

        RETURN loc_lOk
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ValidarParaEmail()
    *-- Valida campos obrigatorios do email antes de enviar
    *--------------------------------------------------------------------------
        LOCAL loc_lOk

        loc_lOk = .T.

        IF EMPTY(THIS.this_cEmailEmpresaDe)
            MsgAviso("O campo 'DE:' n" + CHR(227) + "o foi preenchido.", "Aten" + CHR(231) + CHR(227) + "o")
            loc_lOk = .F.
        ENDIF

        IF loc_lOk AND EMPTY(THIS.this_cEmailPara)
            MsgAviso("O campo 'PARA:' n" + CHR(227) + "o foi preenchido.", "Aten" + CHR(231) + CHR(227) + "o")
            loc_lOk = .F.
        ENDIF

        RETURN loc_lOk
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE MontarObjetoEmail(par_cArquivoAnexo)
    *-- Monta e retorna objeto CUSTOM com dados do email para o form pai usar
    *-- par_cArquivoAnexo: caminho completo do arquivo a ser anexado
    *-- Retorna objeto CUSTOM ou .NULL. em caso de erro
    *--------------------------------------------------------------------------
        LOCAL loc_oEmail, loc_oErro

        loc_oEmail = .NULL.

        TRY
            IF !THIS.ValidarParaEmail()
                loc_lResultado = .NULL.
            ENDIF

            loc_oEmail = CREATEOBJECT("CUSTOM")

            loc_oEmail.AddProperty("cSmtpServer",    THIS.this_cSmtpServidor)
            loc_oEmail.AddProperty("nSmtpServerPort", THIS.this_nSmtpPorta)
            loc_oEmail.AddProperty("cSendUserName",  THIS.this_cEmailEmpresaDe)
            loc_oEmail.AddProperty("cSendPassWord",  THIS.this_cSmtpSenha)
            loc_oEmail.AddProperty("cFrom",          THIS.this_cEmailEmpresaDe)
            loc_oEmail.AddProperty("cTO",            THIS.this_cEmailPara)
            loc_oEmail.AddProperty("cCC",            THIS.this_cEmailCC)
            loc_oEmail.AddProperty("cAssunto",       THIS.this_cEmailAssunto)
            loc_oEmail.AddProperty("cCorpo",         THIS.this_cEmailCorpo)
            loc_oEmail.AddProperty("cAnexo",         par_cArquivoAnexo)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_oEmail = .NULL.
        ENDTRY

        RETURN loc_oEmail
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ResolverExtensao(par_cCaminho, par_nTipoArquivo)
    *-- Garante que o caminho tem a extensao correta (.pdf ou .xls)
    *-- par_cCaminho: caminho do arquivo (pode estar sem extensao)
    *-- par_nTipoArquivo: 1=PDF, 2=XLS
    *-- Retorna: caminho com extensao correta
    *--------------------------------------------------------------------------
        LOCAL loc_cExt, loc_cCaminho

        loc_cExt    = IIF(par_nTipoArquivo = 1, "PDF", "XLS")
        loc_cCaminho = ALLTRIM(par_cCaminho)

        IF !EMPTY(loc_cCaminho)
            IF !(UPPER(JUSTEXT(loc_cCaminho)) $ loc_cExt)
                loc_cCaminho = FORCEEXT(loc_cCaminho, LEFT(loc_cExt, 3))
            ENDIF
        ENDIF

        RETURN loc_cCaminho
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *-- Carrega config de email da empresa a partir do cursor (TmpEmpMail/cursor_4c_EmailEmp)
    *--------------------------------------------------------------------------
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cEmailEmpresaDe = LOWER(ALLTRIM(NVL(PadEmails, "")))
            THIS.this_cSmtpServidor   = LOWER(ALLTRIM(NVL(PadServs,  "")))
            THIS.this_cSmtpSenha      = ALLTRIM(NVL(PadSenhas, ""))
            THIS.this_cSmtpPasta      = ALLTRIM(NVL(pastas, ""))
            THIS.this_nSmtpPorta      = NVL(PadPortas, 0)
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
    *-- Form auxiliar sem tabela de CRUD - sem chave primaria
    *--------------------------------------------------------------------------
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
    *-- Compatibilidade BusinessBase.Salvar() - delega para ValidarParaSalvar
    *--------------------------------------------------------------------------
        RETURN THIS.ValidarParaSalvar()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE AbrirPasta(par_cDiretorio)
    *-- Abre o diretorio no Windows Explorer
    *--------------------------------------------------------------------------
        LOCAL loc_oApp, loc_oErro

        TRY
            IF !EMPTY(par_cDiretorio)
                IF !DIRECTORY(par_cDiretorio)
                    MsgAviso("Diret" + CHR(243) + "rio n" + CHR(227) + "o Localizado", "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    loc_oApp = CREATEOBJECT("Shell.Application")
                    loc_oApp.Open(par_cDiretorio)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
    *-- Modo GRAVAR: prepara arquivo de saida SEM envio de email.
    *-- Form OPERACIONAL auxiliar (sem tabela de CRUD): "Inserir" representa
    *-- a acao de gerar o arquivo de saida (PDF/XLS) pela primeira vez.
    *-- Valida os dados, resolve extensao do arquivo e marca envio de email
    *-- como .F. para que o form pai use apenas o caminho do arquivo.
    *-- Retorna: .T. sucesso, .F. falha (ver ObterMensagemErro em BusinessBase)
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_oErro

        loc_lResultado = .F.

        TRY
            IF !THIS.ValidarParaSalvar()
                loc_lResultado = .F.
            ELSE
                THIS.this_cArquivoSaida = THIS.ResolverExtensao( ;
                    THIS.this_cArquivoSaida, THIS.this_nTipoArquivo)

                THIS.this_lEnviarEmail = .F.
                THIS.this_cEmailPara    = ""
                THIS.this_cEmailCC      = ""
                THIS.this_cEmailAssunto = ""
                THIS.this_cEmailCorpo   = ""

                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao preparar arquivo")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
    *-- Modo ENVIAR EMAIL: prepara arquivo de saida COM anexo em email.
    *-- Form OPERACIONAL auxiliar (sem tabela de CRUD): "Atualizar" representa
    *-- a acao de re-gerar/atualizar o arquivo com envio por email anexado.
    *-- Valida arquivo E dados de email antes de sinalizar sucesso.
    *-- Retorna: .T. sucesso, .F. falha
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_oErro

        loc_lResultado = .F.

        TRY
            IF !THIS.ValidarParaSalvar()
                loc_lResultado = .F.
            ELSE
                THIS.this_cArquivoSaida = THIS.ResolverExtensao( ;
                    THIS.this_cArquivoSaida, THIS.this_nTipoArquivo)

                IF !THIS.ValidarParaEmail()
                    loc_lResultado = .F.
                ELSE
                    THIS.this_lEnviarEmail = .T.
                    loc_lResultado = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao preparar envio de email")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE
