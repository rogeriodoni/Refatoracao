*==============================================================================
* Formsigprftp.prg - Formulario Operacional: Transferencia e Recebimento
*                    de Arquivos via FTP
* Tipo: OPERACIONAL (layout customizado - sem PageFrame CRUD)
* Migrado de: sigprftp.SCX
* Data: 2026-07-16
*
* Pilares:
*   UX   -> layout identico ao legado (1000x600, sem titlebar)
*   BD   -> cursores logftp/tmpprog locais + SigCdPam/SigCdEmp via BO
*   CODE -> arquitetura em camadas (FormBase / sigprftpBO)
*
* CHAMADA (via menu.prg):
*   loForm = CREATEOBJECT("Formsigprftp")
*   IF VARTYPE(loForm) = "O"
*       loForm.Show()
*   ENDIF
*
* IMPLEMENTACAO COMPLETA (fases 3-5):
*   Estrutura base, controles visuais, grids, botoes, handlers de eventos
*   (Transfere, Receber, MontarContainer, GetFtpDirectory, RasftpGet/Put)
*==============================================================================

DEFINE CLASS Formsigprftp AS FormBase

    *-- Dimensoes do form (1000px - padrao do sistema, adaptado do legado 800px)
    this_cMensagemErro = ""
    Width    = 1000
    Height   = 600

    *-- Propriedades visuais herdadas do legado (identico ao SCX original)
    AutoCenter  = .T.
    ShowTips    = .T.
    TitleBar    = 0
    ShowWindow = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    WindowType  = 1
    Themes      = .F.
    KeyPreview  = .T.
    DataSession = 1

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Configuracao de conexao FTP
    this_cTpConnect  = ""    && "D"=Dial-Up  "B"=Broadband/Direto
    this_cFtpAdd     = ""    && endereco do servidor FTP
    this_cFtpUser    = ""    && usuario FTP
    this_cFtpPass    = ""    && senha FTP

    *-- Diretorios locais (drive/pasta no PC)
    this_cDirEnvFtp  = ""    && dir local de origem para ENVIAR ao FTP
    this_cDirRecFtp  = ""    && dir local de destino ao RECEBER do FTP

    *-- Diretorios remotos (caminhos no servidor FTP)
    this_cDirEnvLoc  = ""    && dir FTP de origem ao RECEBER (dirftpls)
    this_cDirRecLoc  = ""    && dir FTP de destino ao ENVIAR  (dirftpts)

    *-- Opcoes de exclusao automatica apos transferencia
    this_lDelLocal   = .F.   && excluir arquivo local apos envio bem-sucedido
    this_lDelHost    = .F.   && excluir arquivo FTP apos recebimento bem-sucedido

    *-- Mascaras de filtro de arquivos
    this_cTpEnv      = "*.*" && mascara de arquivos para envio (ex: "*.xml")
    this_cTpRec      = "*.*" && mascara de arquivos para recebimento

    *-- Modo de execucao automatica
    this_nTpConect   = 0     && 0=manual 1=auto-envio 2=auto-recebimento

    *-- Flags de modo de operacao (detectados em CarregarParametros)
    this_lSomenteEnvio       = .F.   && configurado apenas para envio
    this_lSomenteRecebimento = .F.   && configurado apenas para recebimento

    *-- Estado Dial-UP (preenchidos em ConfigurarControlesDialUp)
    this_cProvedor   = ""    && nome do provedor Dial-Up selecionado
    this_nProvedor   = 0     && indice no CboProvedor

    *-- Guard de recursao para sincronizacao de paginas
    this_lAlternandoPagina = .F.

    *==========================================================================
    PROCEDURE Init
    *==========================================================================
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            *-- 1. Criar cursores de log (logftp) e progresso (tmpprog)
            THIS.CriarCursores()

            *-- 2. Criar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("sigprftpBO")
            IF VARTYPE(THIS.this_oBusinessObject) = "O"

                *-- 3. Aplicar propriedades visuais do form
                THIS.ConfigurarForm()

                *-- 4. Criar estrutura base: Container principal com 2 PageFrames
                *--    (pgfloc = arquivos locais, pgfftp = arquivos remotos FTP)
                THIS.ConfigurarPageFrame()

                *-- 5. Configurar controles operacionais (botoes, grids, conteudo das paginas)
                THIS.ConfigurarPaginaLista()

                *-- 6. Carregar parametros FTP do banco (pular em modo validacao UI)
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarParametros()
                ENDIF

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao criar sigprftpBO"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CriarCursores - Cria cursores de log e progresso utilizados pelo form
    * Equivalente ao evento Load() do legado (sigprftp.SCX)
    * Cursores:
    *   logftp  (memo C(254), cor C(1))     - log de operacoes do FTP
    *   tmpprog (file/size/local/host/status) - progresso das transferencias
    *==========================================================================
    PROTECTED PROCEDURE CriarCursores
        IF !USED("logftp")
            SELECT 0
            CREATE CURSOR logftp (memo C(254), cor C(1))
        ENDIF
        IF !USED("tmpprog")
            SELECT 0
            CREATE CURSOR tmpprog (file   C(254), ;
                                   Size   N(12),  ;
                                   Local  C(254), ;
                                   Host   C(254), ;
                                   Status C(50))
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarForm - Define propriedades visuais do form (background, fonte)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarForm
        LOCAL loc_cBackground
        loc_cBackground = gc_4c_CaminhoIcones + "new_background.jpg"
        WITH THIS
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(100, 100, 100)
            IF FILE(loc_cBackground)
                .Picture = loc_cBackground
            ENDIF
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria estrutura base do form OPERACIONAL:
    *   cnt_4c_Container1 (Container principal - abriga PageFrames)
    *     pgf_4c_Loc  (2 paginas: envio local, recebimento local)
    *     pgf_4c_Ftp  (2 paginas: recebimento FTP, envio FTP)
    * Layout replicado do legado (Container1 no SCX original)
    * Fases posteriores populam ListBoxes, TextBoxes e botoes de navegacao.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame
        LOCAL loc_oCnt, loc_oPgLoc, loc_oPgFtp

        *-- Container principal (equivalente ao Container1 do legado)
        THIS.AddObject("cnt_4c_Container1", "Container")
        loc_oCnt = THIS.cnt_4c_Container1
        WITH loc_oCnt
            .Top         = 128
            .Left        = 88
            .Width       = 620
            .Height      = 194
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- PageFrame LOCAL (pgfloc - pastas locais do PC)
        *--   Page1 = Envio Local (arquivos para enviar ao FTP)
        *--   Page2 = Recebimento Local (destino de arquivos vindos do FTP)
        loc_oCnt.AddObject("pgf_4c_Loc", "PageFrame")
        loc_oPgLoc = loc_oCnt.pgf_4c_Loc
        WITH loc_oPgLoc
            .Top        = 4
            .Left       = 3
            .Width      = 294
            .Height     = 186
            .PageCount  = 2
            .Tabs       = .T.
            .TabStyle   = 0
            .Themes     = .F.
            .Visible    = .T.
        ENDWITH
        loc_oPgLoc.Page1.Caption = "Envio Local"
        loc_oPgLoc.Page2.Caption = "Recebimento Local"

        *-- PageFrame FTP (pgfftp - pastas remotas no servidor FTP)
        *--   Page1 = Recebimento FTP (arquivos remotos p/ baixar)
        *--   Page2 = Envio FTP (destino remoto de arquivos enviados)
        loc_oCnt.AddObject("pgf_4c_Ftp", "PageFrame")
        loc_oPgFtp = loc_oCnt.pgf_4c_Ftp
        WITH loc_oPgFtp
            .Top        = 4
            .Left       = 326
            .Width      = 294
            .Height     = 186
            .PageCount  = 2
            .Tabs       = .T.
            .TabStyle   = 0
            .Themes     = .F.
            .Visible    = .T.
        ENDWITH
        loc_oPgFtp.Page1.Caption = "Recebimento FTP"
        loc_oPgFtp.Page2.Caption = "Envio FTP"

        *-- Tornar filhos visiveis (AddObject cria com Visible=.F.)
        THIS.TornarControlesVisiveis(loc_oCnt)
    ENDPROC

    *==========================================================================
    * CarregarParametros - Carrega configuracao FTP do banco via sigprftpBO
    * Sequencia:
    *   1. Parametros globais de SigCdPam (empresa master, grupos, etc.)
    *   2. Configuracao FTP da empresa corrente de SigCdEmp
    *   3. Normaliza separadores de diretorio
    *   4. Detecta modo de operacao (so envio / so recebimento)
    * Retorno: .T. se configuracao carregada com sucesso
    *==========================================================================
    PROTECTED PROCEDURE CarregarParametros
        LOCAL loc_lSucesso, loc_oBO, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_oBO = THIS.this_oBusinessObject

            *-- Carregar parametros globais de SigCdPam (nao critico - pode nao ter)
            IF !loc_oBO.CarregarParametrosSistema()
                THIS.Inf("Aviso: " + loc_oBO.this_cMensagemErro, "R")
            ENDIF

            *-- Carregar configuracao FTP da empresa corrente de SigCdEmp
            IF loc_oBO.CarregarConfiguracaoEmpresa(go_4c_Sistema.cCodEmpresa)

                *-- Transferir propriedades do BO para o form
                THIS.this_cTpConnect = UPPER(ALLTRIM(loc_oBO.this_cTpConexaoEmp))
                THIS.this_cFtpAdd    = LOWER(ALLTRIM(loc_oBO.this_cFtpAddEmp))
                THIS.this_cFtpUser   = LOWER(ALLTRIM(loc_oBO.this_cFtpUserEmp))
                THIS.this_cFtpPass   = LOWER(ALLTRIM(loc_oBO.this_cFtpPassEmp))
                THIS.this_cDirEnvFtp = LOWER(ALLTRIM(loc_oBO.this_cDriveTs))
                THIS.this_cDirRecFtp = LOWER(ALLTRIM(loc_oBO.this_cDriveLs))
                THIS.this_cDirRecLoc = LOWER(ALLTRIM(loc_oBO.this_cDirFtpTs))
                THIS.this_cDirEnvLoc = LOWER(ALLTRIM(loc_oBO.this_cDirFtpLs))
                THIS.this_lDelLocal  = loc_oBO.this_lLocDel
                THIS.this_lDelHost   = loc_oBO.this_lFtpDel

                *-- Normalizar separador de diretorio local (trailing backslash)
                IF !EMPTY(THIS.this_cDirEnvFtp)
                    THIS.this_cDirEnvFtp = ADDBS(THIS.this_cDirEnvFtp)
                ENDIF
                IF !EMPTY(THIS.this_cDirRecFtp)
                    THIS.this_cDirRecFtp = ADDBS(THIS.this_cDirRecFtp)
                ENDIF

                *-- Normalizar separador de diretorio remoto FTP (trailing slash)
                IF !EMPTY(THIS.this_cDirRecLoc) AND RIGHT(THIS.this_cDirRecLoc, 1) <> "/"
                    THIS.this_cDirRecLoc = THIS.this_cDirRecLoc + "/"
                ENDIF
                IF !EMPTY(THIS.this_cDirEnvLoc) AND RIGHT(THIS.this_cDirEnvLoc, 1) <> "/"
                    THIS.this_cDirEnvLoc = THIS.this_cDirEnvLoc + "/"
                ENDIF

                *-- Detectar modo de operacao (igual ao legado)
                THIS.this_lSomenteEnvio = ;
                    (EMPTY(THIS.this_cDirRecFtp) OR EMPTY(THIS.this_cDirEnvLoc))
                THIS.this_lSomenteRecebimento = ;
                    (EMPTY(THIS.this_cDirEnvFtp) OR EMPTY(THIS.this_cDirRecLoc))

                loc_lSucesso = .T.

                *-- Modo Dial-Up: preencher ComboBox de provedores RAS
                IF UPPER(ALLTRIM(THIS.this_cTpConnect)) == "D"
                    THIS.CarregarConexoesDialUp()
                ENDIF
            ELSE
                THIS.Inf("Empresa " + ALLTRIM(go_4c_Sistema.cCodEmpresa) + ;
                         " n" + CHR(227) + "o cadastrada", "R")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * Utilizacao: chamar apos AddObject das pages/containers
    * par_oContainer: container (Page, Container) cujos filhos serao ativados
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl
        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF INLIST(UPPER(loc_oControl.Name), "CNT_4C_CONTAINER1")
                    LOOP
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
                   loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Inf - Adiciona mensagem ao cursor logftp (exibido no grd_4c_GrdInf)
    * par_cMensagem: texto da mensagem
    * par_cCor: "R"=vermelho(erro), "G"=verde(sucesso), "B"=azul(informativo)
    * Equivalente ao procedimento Inf() do legado sigprftp.SCX
    *==========================================================================
    PROCEDURE Inf(par_cMensagem, par_cCor)
        IF USED("logftp")
            SELECT logftp
            APPEND BLANK
            REPLACE memo WITH par_cMensagem
            REPLACE cor  WITH par_cCor
            GO BOTTOM IN logftp
            IF VARTYPE(THIS.grd_4c_GrdInf) = "O"
                THIS.grd_4c_GrdInf.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Orquestra criacao dos controles operacionais FTP.
    * Chamado de InicializarForm apos ConfigurarPageFrame.
    * Cria: botoes superiores, conteudo das paginas dos PageFrames,
    *        setas de transferencia individual, grid de log (grd_4c_GrdInf).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista
        *-- Grupo 1: Botoes de acao (superior, transferencia intermediaria, rodape)
        THIS.ConfigurarBotoesSuperiores()
        THIS.ConfigurarBotoesTransferencia()
        THIS.ConfigurarRodape()

        *-- Grupo 2: Areas de dados (conteudo das paginas + grids de log e progresso)
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Configura as areas de dados (conteudo) do form:
    *   - Conteudo do pgf_4c_Loc (ListBoxes de arquivos locais + paths + botoes ...)
    *   - Conteudo do pgf_4c_Ftp (ListBoxes de arquivos remotos + paths + botoes ...)
    *   - grd_4c_GrdInf (grid de log de operacoes/mensagens)
    *   - grd_4c_GrdProc (grid de progresso das transferencias)
    * Em forms OPERACIONAIS a "pagina de dados" nao segue o padrao CRUD
    * (Page1=Lista/Page2=Dados). Aqui "dados" = todas as areas que EXIBEM ou
    * MANIPULAM dados (arquivos, log, progresso), em oposicao as areas de
    * ACAO/COMANDO (botoes). Esta separacao facilita manutencao e permite
    * recriar apenas as areas de dados sem tocar nos botoes ja instanciados.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados
        *-- Conteudo do PageFrame LOCAL (pgfloc)
        *--   Page1 "A Enviar"    = txt_4c_Direnvftp + cmd_4c_Cmdbrowloc + lst_4c_Lstenvftp
        *--   Page2 "Recebidos"   = txt_4c_Dirrecftp + cmd_4c_Cmdbrowloc + lst_4c_Lstrecftp
        THIS.ConfigurarConteudoPgLoc()

        *-- Conteudo do PageFrame FTP (pgfftp)
        *--   Page1 "A Baixar"    = txt_4c_Dirrecloc + cmd_4c_Cmdbrowftp + lst_4c_Lstrecloc
        *--   Page2 "Enviados"    = txt_4c_Direnvloc + cmd_4c_Cmdbrowftp + lst_4c_Lstenvloc
        THIS.ConfigurarConteudoPgFtp()

        *-- Grid de log (GrdInf): mensagens de status coloridas (logftp.cor)
        THIS.ConfigurarGrdInf()

        *-- Grid de progresso (GrdProc): arquivo/tamanho/local/host/status (tmpprog)
        THIS.ConfigurarGrdProc()
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesSuperiores - Cria botoes de acao no topo do form:
    *   cmd_4c_Cmdload  (Conecta - carrega listagens FTP e local)
    *   cmd_4c_Cmdtran  (Transfere - envia todos para FTP)
    *   cmd_4c_Cmdrec   (Recebe - baixa todos do FTP)
    *   cmd_4c_Cmdsair  (Encerrar - posicao canonica 917)
    *   shp_4c_Shape1   (Shape decorativo ao redor do Encerrar)
    * Posicoes proporcional ao SCX original (800px -> 1000px).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesSuperiores
        LOCAL loc_cIcones, loc_cBmps
        loc_cIcones = gc_4c_CaminhoIcones
        loc_cBmps   = gc_4c_CaminhoIcones + "..\vbmp\"

        *-- Shape decorativo ao redor do botao Encerrar
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 7
            .Left        = 912
            .Width       = 90
            .Height      = 110
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(0, 0, 0)
            .Visible     = .T.
        ENDWITH

        *-- Botao Conecta (cmdload) - carrega listagens FTP e locais
        THIS.AddObject("cmd_4c_Cmdload", "CommandButton")
        WITH THIS.cmd_4c_Cmdload
            .Top             = 12
            .Left            = 23
            .Width           = 75
            .Height          = 75
            .Caption         = CHR(92) + "<Conecta"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .AutoSize        = .F.
            .PicturePosition = 13
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Cmdload, "Click", THIS, "CmdCmdloadClick")

        *-- Botao Transfere (cmdtran) - envia todos os arquivos para o FTP
        THIS.AddObject("cmd_4c_Cmdtran", "CommandButton")
        WITH THIS.cmd_4c_Cmdtran
            .Top             = 12
            .Left            = 103
            .Width           = 75
            .Height          = 75
            .Caption         = CHR(92) + "<Transfere"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .AutoSize        = .F.
            .PicturePosition = 13
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Cmdtran, "Click", THIS, "CmdCmdtranClick")

        *-- Botao Recebe (cmdrec) - baixa todos os arquivos do FTP
        THIS.AddObject("cmd_4c_Cmdrec", "CommandButton")
        WITH THIS.cmd_4c_Cmdrec
            .Top             = 12
            .Left            = 183
            .Width           = 75
            .Height          = 75
            .Caption         = CHR(92) + "<Recebe"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .AutoSize        = .F.
            .PicturePosition = 13
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Cmdrec, "Click", THIS, "CmdCmdrecClick")

        *-- Botao Encerrar (cmdsair) - posicao canonica CLAUDE.md
        THIS.AddObject("cmd_4c_Cmdsair", "CommandButton")
        WITH THIS.cmd_4c_Cmdsair
            .Top             = 12
            .Left            = 917
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Cancel          = .T.
            .Picture         = loc_cIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = loc_cIcones + "cadastro_sair_60.jpg"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .WordWrap        = .T.
            .AutoSize        = .F.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Cmdsair, "Click", THIS, "CmdCmdsairClick")

        *-- Imagens dos botoes de acao (vbmp/ do legado)
        IF FILE(loc_cBmps + "a_arrow1.bmp")
            THIS.cmd_4c_Cmdload.Picture         = loc_cBmps + "a_arrow1.bmp"
            THIS.cmd_4c_Cmdload.DisabledPicture = loc_cBmps + "a_arrow1.bmp"
        ENDIF
        IF FILE(loc_cBmps + "baix_aut.bmp")
            THIS.cmd_4c_Cmdtran.Picture         = loc_cBmps + "baix_aut.bmp"
            THIS.cmd_4c_Cmdtran.DisabledPicture = loc_cBmps + "baix_aut.bmp"
        ENDIF
        IF FILE(loc_cBmps + "d_disk1.bmp")
            THIS.cmd_4c_Cmdrec.Picture         = loc_cBmps + "d_disk1.bmp"
            THIS.cmd_4c_Cmdrec.DisabledPicture = loc_cBmps + "d_disk1.bmp"
        ENDIF

        *-- Labels "MASTER" (decorativos, variam por empresa - ocultos por default)
        THIS.AddObject("lbl_4c_Label8", "Label")
        WITH THIS.lbl_4c_Label8
            .Top       = 138
            .Left      = 805
            .Caption   = "MASTER"
            .FontName  = "Verdana"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(0, 255, 0)
            .BackStyle = 0
            .Visible   = .F.
        ENDWITH

        THIS.AddObject("lbl_4c_Label9", "Label")
        WITH THIS.lbl_4c_Label9
            .Top       = 137
            .Left      = 804
            .Caption   = "MASTER"
            .FontName  = "Verdana"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(255, 0, 0)
            .BackStyle = 0
            .Visible   = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarConteudoPgLoc - Popula as 2 paginas do pgf_4c_Loc:
    *   Page1 ("A Enviar")    = arquivos locais do PC para enviar ao FTP
    *   Page2 ("Recebidos")   = arquivos locais recebidos do FTP
    * Cada pagina: TextBox (caminho) + botao "..." + ListBox (arquivos)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarConteudoPgLoc
        LOCAL loc_oPgLoc, loc_oPage1, loc_oPage2
        loc_oPgLoc = THIS.cnt_4c_Container1.pgf_4c_Loc

        *-- Captions e cores das abas (do SCX original)
        loc_oPgLoc.Page1.Caption   = "A Enviar"
        loc_oPgLoc.Page1.FontBold  = .T.
        loc_oPgLoc.Page1.FontName  = "Verdana"
        loc_oPgLoc.Page1.FontSize  = 8
        loc_oPgLoc.Page1.BackColor = RGB(255, 255, 255)
        loc_oPgLoc.Page1.ForeColor = RGB(0, 0, 255)
        loc_oPgLoc.Page2.Caption   = "Recebidos"
        loc_oPgLoc.Page2.FontBold  = .T.
        loc_oPgLoc.Page2.FontName  = "Verdana"
        loc_oPgLoc.Page2.FontSize  = 8
        loc_oPgLoc.Page2.BackColor = RGB(255, 255, 255)
        loc_oPgLoc.Page2.ForeColor = RGB(255, 0, 0)

        *-- PAGE 1: A Enviar (arquivos locais que serao enviados ao FTP)
        loc_oPage1 = loc_oPgLoc.Page1
        loc_oPage1.AddObject("txt_4c_Direnvftp", "TextBox")
        WITH loc_oPage1.txt_4c_Direnvftp
            .Top      = 2
            .Left     = 2
            .Width    = 217
            .Height   = 23
            .Value    = ""
            .FontName = "Verdana"
            .FontSize = 8
            .ReadOnly = .T.
            .Visible  = .T.
        ENDWITH

        loc_oPage1.AddObject("cmd_4c_BrowlocEnvio", "CommandButton")
        WITH loc_oPage1.cmd_4c_BrowlocEnvio
            .Top      = 2
            .Left     = 222
            .Width    = 22
            .Height   = 22
            .Caption  = "..."
            .Enabled  = .F.
            .FontName = "Verdana"
            .FontSize = 8
            .ForeColor = RGB(36, 84, 155)
            .BackColor = RGB(255, 255, 255)
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPage1.cmd_4c_BrowlocEnvio, "Click", THIS, "CmdBrowlocEnvioClick")

        loc_oPage1.AddObject("obj_4c_Lstenvftp", "ListBox")
        WITH loc_oPage1.obj_4c_Lstenvftp
            .Top          = 26
            .Left         = 2
            .Width        = 286
            .Height       = 130
            .ColumnCount  = 3
            .ColumnWidths = "130,62,83"
            .ColumnLines  = .T.
            .RowSourceType = 0
            .MultiSelect  = .T.
            .FontName     = "Verdana"
            .FontSize     = 8
            .Visible      = .T.
        ENDWITH

        *-- PAGE 2: Recebidos (destino local dos arquivos recebidos do FTP)
        loc_oPage2 = loc_oPgLoc.Page2
        loc_oPage2.AddObject("txt_4c_Dirrecftp", "TextBox")
        WITH loc_oPage2.txt_4c_Dirrecftp
            .Top      = 2
            .Left     = 2
            .Width    = 217
            .Height   = 23
            .Value    = ""
            .FontName = "Verdana"
            .FontSize = 8
            .ReadOnly = .T.
            .Visible  = .T.
        ENDWITH

        loc_oPage2.AddObject("cmd_4c_BrowlocReceb", "CommandButton")
        WITH loc_oPage2.cmd_4c_BrowlocReceb
            .Top      = 2
            .Left     = 222
            .Width    = 22
            .Height   = 22
            .Caption  = "..."
            .Enabled  = .F.
            .FontName = "Verdana"
            .FontSize = 8
            .ForeColor = RGB(36, 84, 155)
            .BackColor = RGB(255, 255, 255)
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPage2.cmd_4c_BrowlocReceb, "Click", THIS, "CmdBrowlocRecebClick")

        loc_oPage2.AddObject("obj_4c_Lstrecftp", "ListBox")
        WITH loc_oPage2.obj_4c_Lstrecftp
            .Top          = 26
            .Left         = 2
            .Width        = 286
            .Height       = 130
            .ColumnCount  = 3
            .ColumnWidths = "135,58,82"
            .ColumnLines  = .T.
            .RowSourceType = 0
            .MultiSelect  = .T.
            .FontName     = "Verdana"
            .FontSize     = 8
            .Visible      = .T.
        ENDWITH

        BINDEVENT(loc_oPgLoc.Page1, "Activate", THIS, "PgLocPage1Activate")
        BINDEVENT(loc_oPgLoc.Page2, "Activate", THIS, "PgLocPage2Activate")

        THIS.TornarControlesVisiveis(loc_oPage1)
        THIS.TornarControlesVisiveis(loc_oPage2)
    ENDPROC

    *==========================================================================
    * ConfigurarConteudoPgFtp - Popula as 2 paginas do pgf_4c_Ftp:
    *   Page1 ("Enviados")   = arquivos enviados / destino remoto FTP
    *   Page2 ("A Receber")  = arquivos remotos FTP disponiveis para baixar
    * Cada pagina: TextBox (caminho FTP) + botao "..." + ListBox
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarConteudoPgFtp
        LOCAL loc_oPgFtp, loc_oPage1, loc_oPage2
        loc_oPgFtp = THIS.cnt_4c_Container1.pgf_4c_Ftp

        *-- Captions e cores das abas (do SCX original)
        loc_oPgFtp.Page1.Caption   = "Enviados"
        loc_oPgFtp.Page1.FontBold  = .T.
        loc_oPgFtp.Page1.FontName  = "Verdana"
        loc_oPgFtp.Page1.FontSize  = 8
        loc_oPgFtp.Page1.BackColor = RGB(255, 255, 255)
        loc_oPgFtp.Page1.ForeColor = RGB(0, 0, 255)
        loc_oPgFtp.Page2.Caption   = "A Receber"
        loc_oPgFtp.Page2.FontBold  = .T.
        loc_oPgFtp.Page2.FontName  = "Verdana"
        loc_oPgFtp.Page2.FontSize  = 8
        loc_oPgFtp.Page2.BackColor = RGB(255, 255, 255)
        loc_oPgFtp.Page2.ForeColor = RGB(255, 0, 0)

        *-- PAGE 1: Enviados (diretorio remoto FTP de destino dos enviados)
        loc_oPage1 = loc_oPgFtp.Page1
        loc_oPage1.AddObject("txt_4c_Dirrecloc", "TextBox")
        WITH loc_oPage1.txt_4c_Dirrecloc
            .Top      = 2
            .Left     = 2
            .Width    = 217
            .Height   = 23
            .Value    = ""
            .FontName = "Verdana"
            .FontSize = 8
            .ReadOnly = .T.
            .Visible  = .T.
        ENDWITH

        loc_oPage1.AddObject("cmd_4c_BrowftpEnviados", "CommandButton")
        WITH loc_oPage1.cmd_4c_BrowftpEnviados
            .Top      = 2
            .Left     = 223
            .Width    = 22
            .Height   = 22
            .Caption  = "..."
            .Enabled  = .F.
            .FontName = "Verdana"
            .FontSize = 8
            .ForeColor = RGB(36, 84, 155)
            .BackColor = RGB(255, 255, 255)
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        loc_oPage1.AddObject("obj_4c_Lstrecloc", "ListBox")
        WITH loc_oPage1.obj_4c_Lstrecloc
            .Top          = 26
            .Left         = 2
            .Width        = 286
            .Height       = 130
            .ColumnCount  = 3
            .ColumnWidths = "135,58,82"
            .ColumnLines  = .T.
            .RowSourceType = 0
            .MultiSelect  = .T.
            .FontName     = "Verdana"
            .FontSize     = 8
            .Visible      = .T.
        ENDWITH

        *-- PAGE 2: A Receber (arquivos remotos FTP dispon?veis para baixar)
        loc_oPage2 = loc_oPgFtp.Page2
        loc_oPage2.AddObject("txt_4c_Direnvloc", "TextBox")
        WITH loc_oPage2.txt_4c_Direnvloc
            .Top      = 2
            .Left     = 2
            .Width    = 217
            .Height   = 23
            .Value    = ""
            .FontName = "Verdana"
            .FontSize = 8
            .ReadOnly = .T.
            .Visible  = .T.
        ENDWITH

        loc_oPage2.AddObject("cmd_4c_BrowftpAReceber", "CommandButton")
        WITH loc_oPage2.cmd_4c_BrowftpAReceber
            .Top      = 2
            .Left     = 223
            .Width    = 22
            .Height   = 22
            .Caption  = "..."
            .Enabled  = .F.
            .FontName = "Verdana"
            .FontSize = 8
            .ForeColor = RGB(36, 84, 155)
            .BackColor = RGB(255, 255, 255)
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        loc_oPage2.AddObject("obj_4c_Lstenvloc", "ListBox")
        WITH loc_oPage2.obj_4c_Lstenvloc
            .Top          = 26
            .Left         = 2
            .Width        = 286
            .Height       = 130
            .ColumnCount  = 3
            .ColumnWidths = "130,62,83"
            .ColumnLines  = .T.
            .RowSourceType = 0
            .MultiSelect  = .T.
            .FontName     = "Verdana"
            .FontSize     = 8
            .Visible      = .T.
        ENDWITH

        BINDEVENT(loc_oPgFtp.Page1, "Activate", THIS, "PgFtpPage1Activate")
        BINDEVENT(loc_oPgFtp.Page2, "Activate", THIS, "PgFtpPage2Activate")

        THIS.TornarControlesVisiveis(loc_oPage1)
        THIS.TornarControlesVisiveis(loc_oPage2)
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesTransferencia - Cria as setas de transferencia individual
    * dentro do cnt_4c_Container1 (entre pgf_4c_Loc e pgf_4c_Ftp):
    *   cmd_4c_Cmdtransfere (>) transfere arquivo selecionado local->FTP
    *   cmd_4c_Cmdrecebe    (<) recebe arquivo selecionado FTP->local
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesTransferencia
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_Container1

        loc_oCnt.AddObject("cmd_4c_Cmdtransfere", "CommandButton")
        WITH loc_oCnt.cmd_4c_Cmdtransfere
            .Top         = 83
            .Left        = 299
            .Width       = 25
            .Height      = 24
            .Caption     = ""
            .ToolTipText = "Transfere para FTP"
            .FontName    = "Verdana"
            .FontSize    = 8
            .ForeColor   = RGB(36, 84, 155)
            .BackColor   = RGB(255, 255, 255)
            .Enabled     = .T.
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Cmdtransfere, "Click", THIS, "CmdCmdtransfereClick")

        loc_oCnt.AddObject("cmd_4c_Cmdrecebe", "CommandButton")
        WITH loc_oCnt.cmd_4c_Cmdrecebe
            .Top         = 116
            .Left        = 299
            .Width       = 25
            .Height      = 24
            .Caption     = ""
            .ToolTipText = "Recebe do FTP"
            .FontName    = "Verdana"
            .FontSize    = 8
            .ForeColor   = RGB(36, 84, 155)
            .BackColor   = RGB(255, 255, 255)
            .Enabled     = .F.
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oCnt.cmd_4c_Cmdrecebe, "Click", THIS, "CmdCmdrecebeClick")

        *-- Imagens das setas de transferencia individual (vbmp/ legado)
        LOCAL loc_cVbmp
        loc_cVbmp = gc_4c_CaminhoIcones + "..\vbmp\"
        IF FILE(loc_cVbmp + "b_arrow2.bmp")
            loc_oCnt.cmd_4c_Cmdtransfere.Picture = loc_cVbmp + "b_arrow2.bmp"
        ENDIF
        IF FILE(loc_cVbmp + "b_arrow1.bmp")
            loc_oCnt.cmd_4c_Cmdrecebe.Picture = loc_cVbmp + "b_arrow1.bmp"
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarGrdInf - Grid de log de operacoes FTP (equivalente ao GrdInf)
    * RecordSource = "logftp" | DynamicBackColor/ForeColor por cor (R/G/B)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrdInf
        LOCAL loc_oGrid
        THIS.AddObject("grd_4c_GrdInf", "Grid")
        loc_oGrid = THIS.grd_4c_GrdInf
        WITH loc_oGrid
            .Top                = 323
            .Left               = 89
            .Width              = 622
            .Height             = 52
            .ColumnCount        = 1
            .RecordMark         = .F.
            .DeleteMark         = .F.
            .GridLines          = 0
            .GridLineWidth      = 1
            .GridLineColor      = RGB(192, 192, 192)
            .HeaderHeight       = 0
            .HighlightStyle     = 2
            .HighlightBackColor = RGB(255, 255, 255)
            .ScrollBars         = 2
            .RowHeight          = 14
            .FontBold           = .T.
            .FontSize           = 8
            .ReadOnly           = .T.
            .TabStop            = .F.
            .RecordSource       = "logftp"
            .ForeColor          = RGB(0, 0, 0)
            .BackColor          = RGB(255, 255, 255)
            .Visible            = .T.
        ENDWITH
        WITH loc_oGrid.Column1
            .FontBold       = .T.
            .FontName       = "Arial"
            .FontSize       = 8
            .Alignment      = 0
            .Width          = 599
            .ControlSource  = "logftp.memo"
            .ReadOnly       = .T.
            .ForeColor      = RGB(0, 0, 0)
            .BackColor      = RGB(255, 255, 255)
            .Header1.FontBold  = .T.
            .Header1.FontName  = "Arial"
            .Header1.FontSize  = 8
            .Header1.Caption   = "Memo"
            .Header1.Alignment = 2
            .Header1.ForeColor = RGB(0, 0, 0)
            .Header1.BackColor = RGB(192, 192, 192)
        ENDWITH
        loc_oGrid.SetAll("DynamicForeColor", ;
            "iif(logftp.cor='R',RGB(255,255,255),iif(logftp.cor='G',RGB(0,128,0),iif(logftp.cor='B',RGB(0,0,255),RGB(0,255,255))))", ;
            "Column")
        loc_oGrid.SetAll("DynamicBackColor", ;
            "iif(logftp.cor='R',RGB(255,0,0),RGB(255,255,255))", ;
            "Column")
    ENDPROC

    *==========================================================================
    * ConfigurarGrdProc - Grid de progresso das transferencias (GrdProc)
    * RecordSource = "tmpprog" | 5 colunas: arquivo, tamanho, pasta local,
    *   pasta host, status
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrdProc
        LOCAL loc_oGrid
        THIS.AddObject("grd_4c_GrdProc", "Grid")
        loc_oGrid = THIS.grd_4c_GrdProc
        WITH loc_oGrid
            .Top            = 376
            .Left           = 89
            .Width          = 622
            .Height         = 114
            .ColumnCount    = 5
            .RecordMark     = .F.
            .DeleteMark     = .F.
            .GridLines      = 0
            .HeaderHeight   = 15
            .RowHeight      = 15
            .FontSize       = 8
            .ReadOnly       = .T.
            .TabStop        = .F.
            .RecordSource   = "tmpprog"
            .ToolTipText    = "Progresso das Opera" + CHR(231) + CHR(245) + "es de Envio e Recebimento"
            .Visible        = .T.
        ENDWITH
        WITH loc_oGrid.Column1
            .FontSize      = 8
            .Width         = 81
            .ControlSource = "tmpprog.file"
            .ReadOnly      = .T.
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Header1.Caption = "Arquivo"
            .Header1.FontSize = 8
        ENDWITH
        WITH loc_oGrid.Column2
            .FontSize      = 8
            .Width         = 63
            .ControlSource = "tmpprog.size"
            .ReadOnly      = .T.
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Header1.Caption = "Tamanho"
            .Header1.FontSize = 8
        ENDWITH
        WITH loc_oGrid.Column3
            .FontSize      = 8
            .Width         = 107
            .ControlSource = "tmpprog.local"
            .ReadOnly      = .T.
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Header1.Caption = "Pasta Local"
            .Header1.FontSize = 8
        ENDWITH
        WITH loc_oGrid.Column4
            .FontSize      = 8
            .Width         = 136
            .ControlSource = "tmpprog.host"
            .ReadOnly      = .T.
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Header1.Caption = "Pasta Host"
            .Header1.FontSize = 8
        ENDWITH
        WITH loc_oGrid.Column5
            .FontSize      = 8
            .Width         = 207
            .ControlSource = "tmpprog.status"
            .ReadOnly      = .T.
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Header1.Caption = "Status"
            .Header1.FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarRodape - Label de progresso, ComboBox de provedores Dial-Up
    * e botao de conexao Dial-Up (cmdconect)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarRodape
        *-- Label de progresso de operacoes (lblprog)
        THIS.AddObject("lbl_4c_Lblprog", "Label")
        WITH THIS.lbl_4c_Lblprog
            .Top       = 512
            .Left      = 245
            .Width     = 437
            .Height    = 16
            .Caption   = ""
            .FontBold  = .T.
            .FontName  = "Verdana"
            .FontSize  = 10
            .BackStyle = 0
            .ForeColor = RGB(36, 84, 155)
            .Visible   = .T.
        ENDWITH

        *-- Botao Dial-Up (cmdconect) - conecta via RAS
        THIS.AddObject("cmd_4c_Cmdconect", "CommandButton")
        WITH THIS.cmd_4c_Cmdconect
            .Top       = 534
            .Left      = 332
            .Width     = 76
            .Height    = 54
            .Caption   = "Rede " + CHR(92) + "<Dial-Up"
            .FontBold  = .T.
            .FontItalic = .T.
            .FontName  = "Tahoma"
            .FontSize  = 7
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Themes    = .F.
            .PicturePosition = 13
            .WordWrap  = .T.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Cmdconect, "Click", THIS, "CmdCmdconectClick")

        *-- Imagem do botao de conexao Dial-Up (vbmp/ legado)
        LOCAL loc_cVbmp
        loc_cVbmp = gc_4c_CaminhoIcones + "..\vbmp\"
        IF FILE(loc_cVbmp + "c_comm1.bmp")
            THIS.cmd_4c_Cmdconect.Picture         = loc_cVbmp + "c_comm1.bmp"
            THIS.cmd_4c_Cmdconect.DisabledPicture = loc_cVbmp + "c_comm1.bmp"
        ENDIF

        *-- ComboBox de provedores Dial-Up (CboProvedor)
        THIS.AddObject("cbo_4c_CboProvedor", "ComboBox")
        WITH THIS.cbo_4c_CboProvedor
            .Top           = 550
            .Left          = 90
            .Width         = 235
            .Height        = 24
            .RowSourceType = 0
            .Style         = 2
            .Value         = 0
            .FontName      = "Verdana"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH
        BINDEVENT(THIS.cbo_4c_CboProvedor, "InteractiveChange", THIS, "CboProvedorInteractiveChange")
    ENDPROC

    *==========================================================================
    * AlternarPagina - Sincroniza pgf_4c_Loc e pgf_4c_Ftp para mesma pagina
    * e habilita/desabilita setas de transferencia individual:
    *   par_nPagina=1  Envio (local->FTP): seta > habilitada
    *   par_nPagina=2  Recebimento (FTP->local): seta < habilitada
    * Guard this_lAlternandoPagina evita recursao entre Activate handlers.
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_oCnt, loc_oErro
        IF THIS.this_lAlternandoPagina OR par_nPagina < 1 OR par_nPagina > 2
            RETURN
        ENDIF
        THIS.this_lAlternandoPagina = .T.
        TRY
            loc_oCnt = THIS.cnt_4c_Container1
            IF loc_oCnt.pgf_4c_Loc.ActivePage != par_nPagina
                loc_oCnt.pgf_4c_Loc.ActivePage = par_nPagina
            ENDIF
            IF loc_oCnt.pgf_4c_Ftp.ActivePage != par_nPagina
                loc_oCnt.pgf_4c_Ftp.ActivePage = par_nPagina
            ENDIF
            loc_oCnt.cmd_4c_Cmdtransfere.Enabled = (par_nPagina = 1)
            loc_oCnt.cmd_4c_Cmdrecebe.Enabled    = (par_nPagina = 2)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY
        THIS.this_lAlternandoPagina = .F.
    ENDPROC

    *-- Handlers de sincronizacao de paginas (via BINDEVENT nos Activate das Pages)
    PROCEDURE PgLocPage1Activate
        THIS.AlternarPagina(1)
    ENDPROC

    PROCEDURE PgLocPage2Activate
        THIS.AlternarPagina(2)
    ENDPROC

    PROCEDURE PgFtpPage1Activate
        THIS.AlternarPagina(1)
    ENDPROC

    PROCEDURE PgFtpPage2Activate
        THIS.AlternarPagina(2)
    ENDPROC

    *==========================================================================
    * CmdCmdsairClick - Encerra o formulario FTP
    *==========================================================================
    PROCEDURE CmdCmdsairClick
        THIS.Release()
    ENDPROC

    *==========================================================================
    * CmdBrowlocEnvioClick - Seleciona pasta local de onde serao enviados
    *                        os arquivos ao FTP (direnvftp)
    *==========================================================================
    PROCEDURE CmdBrowlocEnvioClick
        LOCAL loc_cDir
        loc_cDir = GETDIRECTORY("Selecione a pasta de envio")
        IF !EMPTY(loc_cDir)
            THIS.cnt_4c_Container1.pgf_4c_Loc.Page1.txt_4c_Direnvftp.Value = loc_cDir
            THIS.this_cDirEnvFtp = loc_cDir
        ENDIF
    ENDPROC

    *==========================================================================
    * CmdBrowlocRecebClick - Seleciona pasta local de destino dos arquivos
    *                        recebidos do FTP (dirrecftp)
    *==========================================================================
    PROCEDURE CmdBrowlocRecebClick
        LOCAL loc_cDir
        loc_cDir = GETDIRECTORY("Selecione a pasta de recebimento")
        IF !EMPTY(loc_cDir)
            THIS.cnt_4c_Container1.pgf_4c_Loc.Page2.txt_4c_Dirrecftp.Value = loc_cDir
            THIS.this_cDirRecFtp = loc_cDir
        ENDIF
    ENDPROC

    *==========================================================================
    * CmdCmdloadClick - Conecta e carrega listagens de arquivos:
    *   1. Desabilita botao para evitar clique duplo
    *   2. Chama MontarContainer (listagem FTP + local)
    *   3. Reabilita botao
    *==========================================================================
    PROCEDURE CmdCmdloadClick
        LOCAL loc_lOk, loc_nAtivas, loc_oErro
        loc_lOk = .T.
        THIS.cmd_4c_Cmdload.Enabled = .F.
        TRY
            DO CASE
                CASE THIS.this_cTpConnect = "D"
                    PUBLIC ARRAY aAtivas(1)
                    loc_nAtivas = THIS.RasAtivas("aAtivas")
                    IF loc_nAtivas > 0
                        THIS.Inf("Este computador j" + CHR(225) + " est" + CHR(225) + ;
                                 " conectado " + CHR(224) + " INTERNET", "B")
                        THIS.MontarContainer()
                    ELSE
                        THIS.Inf("Conex" + CHR(227) + "o " + CHR(224) + ;
                                 " Internet N" + CHR(195) + "O detectada", "R")
                        loc_lOk = .F.
                    ENDIF
                    IF TYPE("aAtivas") = "A"
                        RELEASE aAtivas
                    ENDIF
                OTHERWISE
                    THIS.MontarContainer()
            ENDCASE
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro")
            loc_lOk = .F.
        ENDTRY
        THIS.cmd_4c_Cmdload.Enabled = .T.
        RETURN loc_lOk
    ENDPROC

    *==========================================================================
    * CmdCmdtranClick - Transfere TODOS os arquivos listados para o FTP
    *==========================================================================
    PROCEDURE CmdCmdtranClick
        THIS.Transfere("A")
    ENDPROC

    *==========================================================================
    * CmdCmdrecClick - Recebe TODOS os arquivos listados do FTP
    *==========================================================================
    PROCEDURE CmdCmdrecClick
        THIS.Receber("A")
    ENDPROC

    *==========================================================================
    * CmdCmdtransfereClick - Transfere apenas o arquivo SELECIONADO ao FTP
    *==========================================================================
    PROCEDURE CmdCmdtransfereClick
        THIS.Transfere("I")
    ENDPROC

    *==========================================================================
    * CmdCmdrecebeClick - Recebe apenas o arquivo SELECIONADO do FTP
    *==========================================================================
    PROCEDURE CmdCmdrecebeClick
        THIS.Receber("I")
    ENDPROC

    *==========================================================================
    * CmdCmdconectClick - Conecta via RAS Dial-Up (se _TpConnect = "D")
    *==========================================================================
    PROCEDURE CmdCmdconectClick
        LOCAL loc_nAtivas, loc_cRun, loc_oErro
        TRY
            DO CASE
                CASE THIS.this_cTpConnect = "D"
                    PUBLIC ARRAY aAtivas(1)
                    loc_nAtivas = THIS.RasAtivas("aAtivas")
                    IF loc_nAtivas > 0
                        THIS.Inf("Este computador j" + CHR(225) + " est" + CHR(225) + ;
                                 " conectado " + CHR(224) + " INTERNET", "B")
                    ELSE
                        THIS.Inf("Esperando por uma Conex" + CHR(227) + "o " + CHR(224) + ;
                                 " Internet via Dial-UP", "B")
                        IF !EMPTY(THIS.this_cProvedor) AND TYPE("aProvedor") = "A"
                            loc_cRun = "RUN /N Rundll Rnaui.dll,RnaDial " + ALLTRIM(THIS.this_cProvedor)
                            &loc_cRun.
                        ELSE
                            IF EMPTY(THIS.this_cProvedor)
                            THIS.Inf("Nome de Provedor n" + CHR(227) + "o selecionado.", "R")
                            ENDIF
                        ENDIF
                    ENDIF
                    IF TYPE("aAtivas") = "A"
                        RELEASE aAtivas
                    ENDIF
                OTHERWISE
                    THIS.Inf("Conex" + CHR(227) + "o Broadband: n" + CHR(227) + ;
                             "o requer discagem.", "B")
            ENDCASE
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CboProvedorInteractiveChange - Atualiza provedor Dial-Up selecionado
    * quando usuario escolhe diferente item no ComboBox de provedores
    *==========================================================================
    PROCEDURE CboProvedorInteractiveChange
        IF VARTYPE(THIS.cbo_4c_CboProvedor) = "O"
            THIS.this_nProvedor = THIS.cbo_4c_CboProvedor.ListIndex
            THIS.this_cProvedor = ALLTRIM(THIS.cbo_4c_CboProvedor.DisplayValue)
        ENDIF
    ENDPROC

    *==========================================================================
    * MontarContainer - Carrega listagens de arquivos FTP e locais nos ListBoxes
    * Equivalente a MontaContainer() do legado SIGPRFTP.SCX
    * Preenche:
    *   pgf_4c_Loc.Page1 -> obj_4c_Lstenvftp  (arquivos locais para enviar)
    *   pgf_4c_Ftp.Page2 -> obj_4c_Lstenvloc  (arquivos FTP a receber)
    *   Caminhos nos TextBoxes de cada pagina
    *==========================================================================
    PROCEDURE MontarContainer
        LOCAL loc_lOk, loc_oCnt, loc_oPgLoc, loc_oPgFtp, loc_oObj
        LOCAL loc_i, loc_aArq, loc_nArq, loc_oErro
        loc_lOk  = .T.
        loc_oCnt   = THIS.cnt_4c_Container1
        loc_oPgLoc = loc_oCnt.pgf_4c_Loc
        loc_oPgFtp = loc_oCnt.pgf_4c_Ftp

        THIS.Inf("Carregando par" + CHR(226) + "metros da tela... Aguarde", "B")

        *-- Atualizar TextBoxes de caminhos configurados
        IF !EMPTY(THIS.this_cDirEnvFtp)
            loc_oPgLoc.Page1.txt_4c_Direnvftp.Value = THIS.this_cDirEnvFtp
        ENDIF
        IF !EMPTY(THIS.this_cDirRecFtp)
            loc_oPgLoc.Page2.txt_4c_Dirrecftp.Value = THIS.this_cDirRecFtp
        ENDIF
        IF !EMPTY(THIS.this_cDirRecLoc)
            loc_oPgFtp.Page1.txt_4c_Dirrecloc.Value = THIS.this_cDirRecLoc
        ENDIF
        IF !EMPTY(THIS.this_cDirEnvLoc)
            loc_oPgFtp.Page2.txt_4c_Direnvloc.Value = THIS.this_cDirEnvLoc
        ENDIF

        *-- [A RECEBER DO HOST] Listagem do FTP (diretorio de envio local)
        IF !EMPTY(THIS.this_cDirEnvLoc)
            THIS.Inf("Estabelecendo conex" + CHR(227) + "o com " + ;
                     THIS.this_cFtpAdd + "...", "B")
            IF THIS.GetFtpDirectory(THIS.this_cDirEnvLoc, "*.*")
                IF USED("FtpServer")
                    loc_oObj = loc_oPgFtp.Page2.obj_4c_Lstenvloc
                    FOR loc_i = loc_oObj.ListCount TO 1 STEP -1
                        loc_oObj.RemoveItem(loc_i)
                    ENDFOR
                    SELECT FtpServer
                    SCAN
                        loc_oObj.AddItem(ALLTRIM(FtpServer.lcFileName))
                    ENDSCAN
                    THIS.Inf("FTP: " + TRANSFORM(loc_oObj.ListCount) + ;
                             " arquivo(s) encontrado(s)", "G")
                ENDIF
            ELSE
                THIS.Inf("Falha ao listar diret" + CHR(243) + "rio FTP", "R")
                loc_lOk = .F.
            ENDIF
        ENDIF

        *-- [A ENVIAR PARA O HOST] Listagem local (arquivos para enviar)
        IF !EMPTY(THIS.this_cDirEnvFtp)
            loc_oObj = loc_oPgLoc.Page1.obj_4c_Lstenvftp
            FOR loc_i = loc_oObj.ListCount TO 1 STEP -1
                loc_oObj.RemoveItem(loc_i)
            ENDFOR
            IF ISDIR(THIS.this_cDirEnvFtp)
                DIMENSION loc_aArq[1, 5]
                loc_nArq = ADIR(loc_aArq, THIS.this_cDirEnvFtp + "*.*", "")
                IF loc_nArq > 0
                    LOCAL loc_j
                    FOR loc_j = 1 TO loc_nArq
                        loc_oObj.AddItem(ALLTRIM(loc_aArq[loc_j, 1]))
                    ENDFOR
                ENDIF
                THIS.Inf("Local: " + TRANSFORM(loc_oObj.ListCount) + ;
                         " arquivo(s) encontrado(s)", "B")
            ELSE
                THIS.Inf("Pasta local n" + CHR(227) + "o encontrada: " + ;
                         THIS.this_cDirEnvFtp, "R")
            ENDIF
        ENDIF

        IF loc_lOk
            THIS.Inf("Pronto.", "G")
        ENDIF
        IF USED("FtpServer")
            USE IN FtpServer
        ENDIF
        RETURN loc_lOk
    ENDPROC

    *==========================================================================
    * Transfere - Transfere arquivos do PC local para o servidor FTP
    * par_cTipo: "A" = todos os arquivos | "I" = apenas selecionados
    * Equivalente a transfere() do legado SIGPRFTP.SCX
    *==========================================================================
    PROCEDURE Transfere(par_cTipo)
        LOCAL loc_lOk, loc_oObj, loc_i, loc_nQtd, loc_nTrans, loc_nFalha
        LOCAL loc_cArqLocal, loc_cArqFtp, loc_oErro
        loc_lOk    = .T.
        loc_nTrans = 0
        loc_nFalha = 0

        THIS.cnt_4c_Container1.pgf_4c_Loc.ActivePage = 1
        loc_oObj = THIS.cnt_4c_Container1.pgf_4c_Loc.Page1.obj_4c_Lstenvftp

        IF loc_oObj.ListCount <= 0
            THIS.Inf("N" + CHR(195) + "O existe nenhum arquivo a ser Transferido para o FTP.", "B")
            RETURN .F.
        ENDIF

        loc_nQtd = loc_oObj.ListCount
        TRY
            FOR loc_i = 1 TO loc_nQtd
                loc_cArqLocal = ALLTRIM(loc_oObj.List(loc_i))
                IF UPPER(par_cTipo) = "I" AND !loc_oObj.Selected(loc_i)
                    LOOP
                ENDIF
                loc_cArqFtp = THIS.this_cDirRecLoc + loc_cArqLocal
                THIS.Inf("Transferindo " + loc_cArqLocal + " para FTP...", "B")
                IF THIS.RasftpPut(THIS.this_cFtpAdd, THIS.this_cFtpUser, ;
                                  THIS.this_cFtpPass, ;
                                  THIS.this_cDirEnvFtp + loc_cArqLocal, ;
                                  loc_cArqFtp)
                    loc_nTrans = loc_nTrans + 1
                    IF THIS.this_lDelLocal
                        IF FILE(THIS.this_cDirEnvFtp + loc_cArqLocal)
                            DELETE FILE (THIS.this_cDirEnvFtp + loc_cArqLocal)
                        ENDIF
                    ENDIF
                    THIS.Inf("OK: " + loc_cArqLocal, "G")
                ELSE
                    loc_nFalha = loc_nFalha + 1
                    THIS.Inf("Falha: " + loc_cArqLocal, "R")
                    loc_lOk = .F.
                ENDIF
            ENDFOR
            THIS.Inf("Transfer" + CHR(234) + "ncia: " + TRANSFORM(loc_nTrans) + ;
                     " ok, " + TRANSFORM(loc_nFalha) + " falha(s)", ;
                     IIF(loc_nFalha = 0, "G", "R"))
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
            loc_lOk = .F.
        ENDTRY
        RETURN loc_lOk
    ENDPROC

    *==========================================================================
    * Receber - Recebe arquivos do servidor FTP para o PC local
    * par_cTipo: "A" = todos os arquivos | "I" = apenas selecionados
    * Equivalente a recebe() do legado SIGPRFTP.SCX
    *==========================================================================
    PROCEDURE Receber(par_cTipo)
        LOCAL loc_lOk, loc_oObj, loc_i, loc_nQtd, loc_nTrans, loc_nFalha
        LOCAL loc_cArqFtp, loc_cArqLocal, loc_oErro
        loc_lOk    = .T.
        loc_nTrans = 0
        loc_nFalha = 0

        THIS.cnt_4c_Container1.pgf_4c_Ftp.ActivePage = 2
        THIS.Inf("Carregando listagem do FTP...", "B")
        THIS.MontarContainer()
        loc_oObj = THIS.cnt_4c_Container1.pgf_4c_Ftp.Page2.obj_4c_Lstenvloc
        IF loc_oObj.ListCount <= 0
            THIS.Inf("N" + CHR(195) + "O existe nenhum arquivo a ser recebido do FTP.", "B")
            RETURN .F.
        ENDIF

        loc_nQtd = loc_oObj.ListCount
        TRY
            FOR loc_i = 1 TO loc_nQtd
                loc_cArqFtp = ALLTRIM(loc_oObj.List(loc_i))
                IF UPPER(par_cTipo) = "I" AND !loc_oObj.Selected(loc_i)
                    LOOP
                ENDIF
                loc_cArqLocal = THIS.this_cDirRecFtp + loc_cArqFtp
                THIS.Inf("Recebendo " + loc_cArqFtp + " do FTP...", "B")
                IF THIS.RasftpGet(THIS.this_cFtpAdd, THIS.this_cFtpUser, ;
                                  THIS.this_cFtpPass, ;
                                  THIS.this_cDirEnvLoc + loc_cArqFtp, ;
                                  loc_cArqLocal)
                    loc_nTrans = loc_nTrans + 1
                    IF THIS.this_lDelHost
                        THIS.DeleteFtpFile(THIS.this_cFtpAdd, THIS.this_cFtpUser, ;
                                           THIS.this_cFtpPass, ;
                                           THIS.this_cDirEnvLoc + loc_cArqFtp)
                    ENDIF
                    THIS.Inf("OK: " + loc_cArqFtp, "G")
                ELSE
                    loc_nFalha = loc_nFalha + 1
                    THIS.Inf("Falha: " + loc_cArqFtp, "R")
                    loc_lOk = .F.
                ENDIF
            ENDFOR
            THIS.Inf("Recebimento: " + TRANSFORM(loc_nTrans) + ;
                     " ok, " + TRANSFORM(loc_nFalha) + " falha(s)", ;
                     IIF(loc_nFalha = 0, "G", "R"))
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
            loc_lOk = .F.
        ENDTRY
        RETURN loc_lOk
    ENDPROC

    *==========================================================================
    * GetFtpDirectory - Lista arquivos de um diretorio FTP remoto
    * Usa WinInet.dll para conectar e listar via FtpFindFirstFile/FindNextFile
    * Resultado: cursor "FtpServer" com campos lcFileName, lcAlterName,
    *            lnSize, ldWriteDate, lcAttributes
    * Retorno: .T. se sucesso
    * Equivalente a GetFtpDirectory() do legado SIGPRFTP.SCX
    *==========================================================================
    PROCEDURE GetFtpDirectory(par_cDirFtp, par_cMask)
        LOCAL loc_lOk, loc_nInternet, loc_nFtp, loc_nFind, loc_oErro
        LOCAL loc_cStruct, loc_cNull, loc_cName, loc_cResult, loc_lContinuar

        loc_lOk      = .F.
        loc_nInternet = 0
        loc_nFtp      = 0

        #DEFINE INTERNET_OPEN_TYPE_PRECONFIG   0
        #DEFINE INTERNET_OPEN_TYPE_DIRECT      1
        #DEFINE INTERNET_DEFAULT_FTP_PORT     21
        #DEFINE INTERNET_SERVICE_FTP           1
        #DEFINE INTERNET_FLAG_PASSIVE   14217728
        #DEFINE ERROR_NO_MORE_FILES           18
        #DEFINE MAX_PATH                     260

        TRY
            DECLARE Integer InternetOpen IN wininet ;
                String  sAgent, Integer nAccessType, String sProxy, ;
                String  sProxyBypass, Integer dwFlags

            DECLARE Integer InternetConnect IN wininet ;
                Integer hInternet, String lpszServerName, ;
                Integer nServerPort, String lpszUserName, ;
                String  lpszPassword, Integer dwService, ;
                Integer dwFlags, Integer dwContext

            DECLARE Integer FtpFindFirstFile IN wininet ;
                Integer hConnect, String lpszSearchFile, ;
                String @lpFindFileData, Integer dwFlags, Integer dwContext

            DECLARE Integer InternetFindNextFile IN wininet ;
                Integer hFind, String @lpFindFileData

            DECLARE Integer InternetCloseHandle IN wininet ;
                Integer hInet

            loc_cStruct = SPACE(592)
            loc_cNull   = CHR(0)

            loc_nInternet = InternetOpen("VFP9/FTP", INTERNET_OPEN_TYPE_DIRECT, ;
                                         loc_cNull, loc_cNull, 0)
            IF loc_nInternet = 0
                THIS.Inf("Falha ao inicializar WinInet", "R")
            ELSE
                loc_nFtp = InternetConnect(loc_nInternet, ;
                                           THIS.this_cFtpAdd, ;
                                           INTERNET_DEFAULT_FTP_PORT, ;
                                           THIS.this_cFtpUser, ;
                                           THIS.this_cFtpPass, ;
                                           INTERNET_SERVICE_FTP, ;
                                           INTERNET_FLAG_PASSIVE, 0)
                IF loc_nFtp = 0
                    THIS.Inf("Falha ao conectar FTP: " + THIS.this_cFtpAdd, "R")
                ELSE
                    IF USED("FtpServer")
                        USE IN FtpServer
                    ENDIF
                    SELECT 0
                    CREATE CURSOR FtpServer (lcFileName C(MAX_PATH), ;
                                            lcAlterName C(14), ;
                                            lnSize N(12), ;
                                            ldWriteDate C(10), ;
                                            lcAttributes C(2))

                    loc_nFind = FtpFindFirstFile(loc_nFtp, ;
                                                 ALLTRIM(par_cDirFtp) + par_cMask, ;
                                                 @loc_cStruct, 0, 0)
                    IF loc_nFind = 0
                        loc_lOk = .T.
                    ELSE
                        loc_lContinuar = .T.
                        DO WHILE loc_lContinuar
                            loc_cName = LEFT(SUBSTR(loc_cStruct, 45, MAX_PATH), ;
                                            IIF(AT(CHR(0), SUBSTR(loc_cStruct, 45, MAX_PATH)) > 0, ;
                                                AT(CHR(0), SUBSTR(loc_cStruct, 45, MAX_PATH)) - 1, ;
                                                MAX_PATH))
                            IF !EMPTY(ALLTRIM(loc_cName)) AND loc_cName <> "." AND loc_cName <> ".."
                                SELECT FtpServer
                                APPEND BLANK
                                REPLACE lcFileName WITH ALLTRIM(loc_cName)
                            ENDIF
                            loc_cStruct = SPACE(592)
                            IF InternetFindNextFile(loc_nFind, @loc_cStruct) = 0
                                loc_lContinuar = .F.
                            ENDIF
                        ENDDO
                        InternetCloseHandle(loc_nFind)
                        loc_lOk = .T.
                    ENDIF
                    InternetCloseHandle(loc_nFtp)
                ENDIF
                InternetCloseHandle(loc_nInternet)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro FTP")
            loc_lOk = .F.
        ENDTRY
        RETURN loc_lOk
    ENDPROC

    *==========================================================================
    * RasftpGet - Baixa arquivo do servidor FTP para pasta local
    * par_cFtpLoc:    endereco do servidor FTP
    * par_cFtpUsu:    usuario FTP
    * par_cFtpSen:    senha FTP
    * par_cFtpRemArq: caminho completo do arquivo no FTP
    * par_cFtpLocArq: caminho completo de destino local
    * Retorno: .T. se sucesso
    * Equivalente a rasftpget() do legado SIGPRFTP.SCX
    *==========================================================================
    PROCEDURE RasftpGet(par_cFtpLoc, par_cFtpUsu, par_cFtpSen, par_cFtpRemArq, par_cFtpLocArq)
        LOCAL loc_lOk, loc_nInternet, loc_nFtp, loc_oErro

        loc_lOk      = .F.
        loc_nInternet = 0
        loc_nFtp      = 0

        #DEFINE INTERNET_OPEN_TYPE_DIRECT      1
        #DEFINE INTERNET_DEFAULT_FTP_PORT     21
        #DEFINE INTERNET_SERVICE_FTP           1
        #DEFINE INTERNET_FLAG_PASSIVE   14217728
        #DEFINE FILE_ATTRIBUTE_NORMAL        128
        #DEFINE FTP_TRANSFER_TYPE_BINARY       2

        TRY
            DECLARE Integer InternetOpen IN wininet ;
                String  sAgent, Integer nAccessType, String sProxy, ;
                String  sProxyBypass, Integer dwFlags

            DECLARE Integer InternetConnect IN wininet ;
                Integer hInternet, String lpszServerName, ;
                Integer nServerPort, String lpszUserName, ;
                String  lpszPassword, Integer dwService, ;
                Integer dwFlags, Integer dwContext

            DECLARE Integer FtpGetFile IN wininet ;
                Integer hConnect, String lpszRemoteFile, ;
                String  lpszNewFile, Integer fFailIfExists, ;
                Integer dwFlagsAndAttributes, Integer dwFlags, Integer dwContext

            DECLARE Integer InternetCloseHandle IN wininet ;
                Integer hInet

            loc_nInternet = InternetOpen("VFP9/FTP", INTERNET_OPEN_TYPE_DIRECT, ;
                                         CHR(0), CHR(0), 0)
            IF loc_nInternet = 0
                THIS.Inf("Falha ao inicializar WinInet (GET)", "R")
            ELSE
                loc_nFtp = InternetConnect(loc_nInternet, ;
                                           par_cFtpLoc, ;
                                           INTERNET_DEFAULT_FTP_PORT, ;
                                           par_cFtpUsu, ;
                                           par_cFtpSen, ;
                                           INTERNET_SERVICE_FTP, ;
                                           INTERNET_FLAG_PASSIVE, 0)
                IF loc_nFtp = 0
                    THIS.Inf("Falha na conex" + CHR(227) + "o FTP para GET", "R")
                ELSE
                    IF FILE(par_cFtpLocArq)
                        DELETE FILE (par_cFtpLocArq)
                    ENDIF
                    loc_lOk = (FtpGetFile(loc_nFtp, ;
                                          par_cFtpRemArq, ;
                                          par_cFtpLocArq, ;
                                          .F., ;
                                          FILE_ATTRIBUTE_NORMAL, ;
                                          FTP_TRANSFER_TYPE_BINARY, 0) <> 0)
                    IF !loc_lOk
                        THIS.Inf("Falha ao baixar: " + par_cFtpRemArq, "R")
                    ENDIF
                    InternetCloseHandle(loc_nFtp)
                ENDIF
                InternetCloseHandle(loc_nInternet)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro FTP GET")
            loc_lOk = .F.
        ENDTRY
        RETURN loc_lOk
    ENDPROC

    *==========================================================================
    * RasftpPut - Envia arquivo local para o servidor FTP
    * par_cFtpLoc:    endereco do servidor FTP
    * par_cFtpUsu:    usuario FTP
    * par_cFtpSen:    senha FTP
    * par_cFtpLocArq: caminho completo do arquivo local (origem)
    * par_cFtpRemArq: caminho completo no servidor FTP (destino)
    * Retorno: .T. se sucesso
    * Equivalente a rasftpPUT() do legado SIGPRFTP.SCX
    *==========================================================================
    PROCEDURE RasftpPut(par_cFtpLoc, par_cFtpUsu, par_cFtpSen, par_cFtpLocArq, par_cFtpRemArq)
        LOCAL loc_lOk, loc_nInternet, loc_nFtp, loc_oErro

        loc_lOk      = .F.
        loc_nInternet = 0
        loc_nFtp      = 0

        #DEFINE INTERNET_OPEN_TYPE_DIRECT      1
        #DEFINE INTERNET_DEFAULT_FTP_PORT     21
        #DEFINE INTERNET_SERVICE_FTP           1
        #DEFINE INTERNET_FLAG_PASSIVE   14217728
        #DEFINE FTP_TRANSFER_TYPE_BINARY       2

        TRY
            DECLARE Integer InternetOpen IN wininet ;
                String  sAgent, Integer nAccessType, String sProxy, ;
                String  sProxyBypass, Integer dwFlags

            DECLARE Integer InternetConnect IN wininet ;
                Integer hInternet, String lpszServerName, ;
                Integer nServerPort, String lpszUserName, ;
                String  lpszPassword, Integer dwService, ;
                Integer dwFlags, Integer dwContext

            DECLARE Integer FtpPutFile IN wininet ;
                Integer hConnect, String lpszLocalFile, ;
                String  lpszNewRemoteFile, Integer dwFlags, Integer dwContext

            DECLARE Integer InternetCloseHandle IN wininet ;
                Integer hInet

            IF !FILE(par_cFtpLocArq)
                THIS.Inf("Arquivo n" + CHR(227) + "o encontrado: " + par_cFtpLocArq, "R")
            ELSE
                loc_nInternet = InternetOpen("VFP9/FTP", INTERNET_OPEN_TYPE_DIRECT, ;
                                             CHR(0), CHR(0), 0)
                IF loc_nInternet = 0
                    THIS.Inf("Falha ao inicializar WinInet (PUT)", "R")
                ELSE
                    loc_nFtp = InternetConnect(loc_nInternet, ;
                                               par_cFtpLoc, ;
                                               INTERNET_DEFAULT_FTP_PORT, ;
                                               par_cFtpUsu, ;
                                               par_cFtpSen, ;
                                               INTERNET_SERVICE_FTP, ;
                                               INTERNET_FLAG_PASSIVE, 0)
                    IF loc_nFtp = 0
                        THIS.Inf("Falha na conex" + CHR(227) + "o FTP para PUT", "R")
                    ELSE
                        loc_lOk = (FtpPutFile(loc_nFtp, ;
                                               par_cFtpLocArq, ;
                                               par_cFtpRemArq, ;
                                               FTP_TRANSFER_TYPE_BINARY, 0) <> 0)
                        IF !loc_lOk
                            THIS.Inf("Falha ao enviar: " + par_cFtpLocArq, "R")
                        ENDIF
                        InternetCloseHandle(loc_nFtp)
                    ENDIF
                    InternetCloseHandle(loc_nInternet)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro FTP PUT")
            loc_lOk = .F.
        ENDTRY
        RETURN loc_lOk
    ENDPROC

    *==========================================================================
    * DeleteFtpFile - Remove arquivo do servidor FTP
    * par_cFtpLoc: endereco, par_cFtpUsu: usuario, par_cFtpSen: senha
    * par_cFtpArq: caminho completo do arquivo no FTP
    * Retorno: .T. se sucesso
    *==========================================================================
    PROCEDURE DeleteFtpFile(par_cFtpLoc, par_cFtpUsu, par_cFtpSen, par_cFtpArq)
        LOCAL loc_lOk, loc_nInternet, loc_nFtp, loc_oErro

        loc_lOk      = .F.
        loc_nInternet = 0
        loc_nFtp      = 0

        #DEFINE INTERNET_OPEN_TYPE_DIRECT     1
        #DEFINE INTERNET_DEFAULT_FTP_PORT    21
        #DEFINE INTERNET_SERVICE_FTP          1
        #DEFINE INTERNET_FLAG_PASSIVE  14217728

        TRY
            DECLARE Integer InternetOpen IN wininet ;
                String  sAgent, Integer nAccessType, String sProxy, ;
                String  sProxyBypass, Integer dwFlags

            DECLARE Integer InternetConnect IN wininet ;
                Integer hInternet, String lpszServerName, ;
                Integer nServerPort, String lpszUserName, ;
                String  lpszPassword, Integer dwService, ;
                Integer dwFlags, Integer dwContext

            DECLARE Integer FtpDeleteFile IN wininet ;
                Integer hConnect, String lpszFileName

            DECLARE Integer InternetCloseHandle IN wininet ;
                Integer hInet

            loc_nInternet = InternetOpen("VFP9/FTP", INTERNET_OPEN_TYPE_DIRECT, ;
                                         CHR(0), CHR(0), 0)
            IF loc_nInternet <> 0
                loc_nFtp = InternetConnect(loc_nInternet, par_cFtpLoc, ;
                                           INTERNET_DEFAULT_FTP_PORT, ;
                                           par_cFtpUsu, par_cFtpSen, ;
                                           INTERNET_SERVICE_FTP, ;
                                           INTERNET_FLAG_PASSIVE, 0)
                IF loc_nFtp <> 0
                    loc_lOk = (FtpDeleteFile(loc_nFtp, par_cFtpArq) <> 0)
                    IF !loc_lOk
                        THIS.Inf("Falha ao remover FTP: " + par_cFtpArq, "R")
                    ENDIF
                    InternetCloseHandle(loc_nFtp)
                ENDIF
                InternetCloseHandle(loc_nInternet)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro FTP DEL")
            loc_lOk = .F.
        ENDTRY
        RETURN loc_lOk
    ENDPROC

    *==========================================================================
    * CToWord - Converte buffer de 4 bytes em numero inteiro (little-endian DWORD)
    * par_cBuffer: string de 4 bytes
    * Retorno: inteiro equivalente
    *==========================================================================
    PROCEDURE CToWord(par_cBuffer)
        RETURN ASC(SUBSTR(par_cBuffer, 1, 1)) + ;
               ASC(SUBSTR(par_cBuffer, 2, 1)) * 256 + ;
               ASC(SUBSTR(par_cBuffer, 3, 1)) * 65536 + ;
               ASC(SUBSTR(par_cBuffer, 4, 1)) * 16777216
    ENDPROC

    *==========================================================================
    * WordToC - Converte numero inteiro em buffer de 4 bytes (little-endian DWORD)
    * par_nNumber: inteiro a converter
    * Retorno: string de 4 bytes
    *==========================================================================
    PROCEDURE WordToC(par_nNumber)
        RETURN CHR(BITAND(255, par_nNumber)) + ;
               CHR(BITAND(65280, par_nNumber) % 255) + ;
               CHR(BITAND(16711680, par_nNumber) % 255) + ;
               CHR(BITAND(4278190080, par_nNumber) % 255)
    ENDPROC

    *==========================================================================
    * SectToHour - Converte segundos em string legivel "Xh, Xm, Xs"
    * par_nSecto: numero de segundos
    * Retorno: string formatada (ex: "1 h, 2 m, 30 s")
    *==========================================================================
    PROCEDURE SectToHour(par_nSecto)
        LOCAL loc_nHora, loc_nMinu, loc_nSeco
        loc_nHora = INT(par_nSecto / 3600)
        loc_nMinu = MOD(INT(par_nSecto / 60), 60)
        loc_nSeco = MOD(par_nSecto, 60)
        RETURN IIF(loc_nHora > 0, ALLTRIM(STR(loc_nHora)) + " h, ", "") + ;
               IIF(loc_nMinu > 0, ALLTRIM(STR(loc_nMinu)) + " m, ", "") + ;
               ALLTRIM(STR(loc_nSeco)) + " s"
    ENDPROC

    *==========================================================================
    * CrackAttributes - Extrai atributos de arquivo de buffer WIN32 DWORD (4 bytes)
    * par_cBuffer: 4 primeiros bytes do WIN32_FIND_DATA
    * Retorno: string com letras de atributos (R/H/S/D/A/N/T/C/O)
    *==========================================================================
    PROCEDURE CrackAttributes(par_cBuffer)
        LOCAL loc_cAtributos, loc_nValor
        loc_cAtributos = ""
        loc_nValor = (ASC(SUBSTR(par_cBuffer, 1, 1)) * 1) + ;
                     (ASC(SUBSTR(par_cBuffer, 2, 1)) * 256) + ;
                     (ASC(SUBSTR(par_cBuffer, 3, 1)) * 65536) + ;
                     (ASC(SUBSTR(par_cBuffer, 4, 1)) * 16777216)
        DO CASE
            CASE BITTEST(loc_nValor, 0)
                loc_cAtributos = loc_cAtributos + "R"
            CASE BITTEST(loc_nValor, 1)
                loc_cAtributos = loc_cAtributos + "H"
            CASE BITTEST(loc_nValor, 2)
                loc_cAtributos = loc_cAtributos + "S"
            CASE BITTEST(loc_nValor, 4)
                loc_cAtributos = loc_cAtributos + "D"
            CASE BITTEST(loc_nValor, 5)
                loc_cAtributos = loc_cAtributos + "A"
            CASE BITTEST(loc_nValor, 7)
                loc_cAtributos = loc_cAtributos + "N"
            CASE BITTEST(loc_nValor, 8)
                loc_cAtributos = loc_cAtributos + "T"
            CASE BITTEST(loc_nValor, 11)
                loc_cAtributos = loc_cAtributos + "C"
            CASE BITTEST(loc_nValor, 12)
                loc_cAtributos = loc_cAtributos + "O"
        ENDCASE
        RETURN loc_cAtributos
    ENDPROC

    *==========================================================================
    * CrackDate - Converte buffer FILETIME (8 bytes) em string de data dd/mm/aaaa
    * par_cOutBuffer: 8 bytes FILETIME (little-endian Windows)
    * Retorno: string "dd/mm/aaaa" ou "01/01/1901" em caso de falha
    *==========================================================================
    PROCEDURE CrackDate(par_cOutBuffer)
        LOCAL loc_cInBuffer, loc_nResult, loc_nAno, loc_nMes, loc_nDia, loc_cData, loc_oErro
        loc_cInBuffer = SPACE(16)
        loc_cData     = "01/01/1901"
        TRY
            DECLARE Integer FileTimeToSystemTime IN Kernel32 ;
                String @lpcBuffer, String @lpcBuffer
            loc_nResult = FileTimeToSystemTime(@par_cOutBuffer, @loc_cInBuffer)
            IF loc_nResult <> 0
                loc_nAno  = ASC(SUBSTR(loc_cInBuffer, 1, 1)) + (ASC(SUBSTR(loc_cInBuffer, 2, 1)) * 256)
                loc_nMes  = ASC(SUBSTR(loc_cInBuffer, 3, 1)) + (ASC(SUBSTR(loc_cInBuffer, 4, 1)) * 256)
                loc_nDia  = ASC(SUBSTR(loc_cInBuffer, 7, 1)) + (ASC(SUBSTR(loc_cInBuffer, 8, 1)) * 256)
                loc_cData = PADL(ALLTRIM(STR(loc_nDia)), 2, "0") + "/" + ;
                            PADL(ALLTRIM(STR(loc_nMes)), 2, "0") + "/" + ;
                            ALLTRIM(STR(loc_nAno))
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro CrackDate")
        ENDTRY
        RETURN loc_cData
    ENDPROC

    *==========================================================================
    * CrackFile - Analisa buffer WIN32_FIND_DATA e insere registro no cursor FtpServer
    * par_cBuffer: buffer binario de 319 bytes (WIN32_FIND_DATA)
    * Resultado: INSERT no cursor FtpServer (campos: nome, Tipo, Tama, Data, Atri)
    *==========================================================================
    PROCEDURE CrackFile(par_cBuffer)
        LOCAL loc_cNomeArq, loc_cNomeAlt, loc_nSizeHigh, loc_nSizeLow, loc_nTamanho
        LOCAL loc_cAtributos, loc_cBuffTempo, loc_cDataEsc, loc_cTipo, loc_nAttr, loc_oErro

        #DEFINE LOC_MAX_PATH       260
        #DEFINE LOC_MAXDWORD       4294967295
        #DEFINE LOC_FILE_ATTR_DIR  16

        TRY
            loc_cNomeArq = SUBSTR(par_cBuffer, 45, LOC_MAX_PATH)
            loc_cNomeAlt = RIGHT(par_cBuffer, 14)
            loc_cNomeArq = LEFT(loc_cNomeArq, AT(CHR(0), loc_cNomeArq) - 1)
            loc_cNomeAlt = LEFT(loc_cNomeAlt, AT(CHR(0), loc_cNomeAlt) - 1)

            loc_nSizeHigh = (ASC(SUBSTR(par_cBuffer, 29, 1)) * 1) + ;
                            (ASC(SUBSTR(par_cBuffer, 30, 1)) * 256) + ;
                            (ASC(SUBSTR(par_cBuffer, 31, 1)) * 65536) + ;
                            (ASC(SUBSTR(par_cBuffer, 32, 1)) * 16777216)
            loc_nSizeLow  = (ASC(SUBSTR(par_cBuffer, 33, 1)) * 1) + ;
                            (ASC(SUBSTR(par_cBuffer, 34, 1)) * 256) + ;
                            (ASC(SUBSTR(par_cBuffer, 35, 1)) * 65536) + ;
                            (ASC(SUBSTR(par_cBuffer, 36, 1)) * 16777216)
            loc_nTamanho  = (loc_nSizeHigh * LOC_MAXDWORD) + loc_nSizeLow

            loc_nAttr = THIS.CToWord(SUBSTR(par_cBuffer, 1, 4))
            IF loc_nAttr = LOC_FILE_ATTR_DIR
                loc_cTipo = "Diret" + CHR(243) + "rio"
            ELSE
                loc_cTipo = "Arquivo"
            ENDIF

            loc_cBuffTempo = SUBSTR(par_cBuffer, 21, 8)
            loc_cDataEsc   = THIS.CrackDate(loc_cBuffTempo)
            loc_cAtributos = THIS.CrackAttributes(LEFT(par_cBuffer, 4))

            SELECT FtpServer
            INSERT INTO FtpServer VALUES (ALLTRIM(loc_cNomeArq), ;
                                          ALLTRIM(loc_cTipo), ;
                                          TRANSFORM(loc_nTamanho, "9999999999"), ;
                                          loc_cDataEsc, ;
                                          loc_cAtributos)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro CrackFile")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FileCtrlUp - Atualiza label de progresso lbl_4c_Lblprog
    * Substitui FileControl (classe Framework nao disponivel no novo sistema)
    * par_pStep  : numero (passo atual) OU logico (.T.=iniciar / .F.=ocultar)
    * par_pTotal : total de passos (usado quando par_pStep eh numerico)
    * par_pMessage: mensagem de status (opcional, tipo C)
    *==========================================================================
    PROCEDURE FileCtrlUp(par_pStep, par_pTotal, par_pMessage)
        LOCAL loc_oErro
        TRY
            IF TYPE("par_pMessage") = "C"
                IF VARTYPE(THIS.lbl_4c_Lblprog) = "O"
                    THIS.lbl_4c_Lblprog.Caption = par_pMessage
                ENDIF
            ENDIF
            IF TYPE("par_pStep") = "N" AND TYPE("par_pTotal") = "N" AND par_pTotal > 0
                IF VARTYPE(THIS.lbl_4c_Lblprog) = "O"
                    THIS.lbl_4c_Lblprog.Caption = TRANSFORM(INT(par_pStep * 100 / par_pTotal)) + "% " + ;
                                                  IIF(TYPE("par_pMessage") = "C", "- " + par_pMessage, "")
                ENDIF
                DOEVENTS
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro FileCtrlUp")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Processa - Rastreador de progresso chamado durante transferencias FTP
    * Atualiza cursor tmpprog e lbl_4c_Lblprog com andamento da transferencia.
    * par_cArquivo : nome do arquivo em transferencia
    * par_nTamanho : tamanho total em bytes
    * par_cLocal   : diretorio local
    * par_cHost    : diretorio no host FTP
    * par_nTransf  : bytes ja transferidos
    * par_nBuffer  : tamanho do buffer utilizado
    * par_nSecIni  : segundos no inicio (SECONDS())
    * par_nSec     : segundos decorridos
    * par_cStatus  : "I"=Iniciando | "A"=em Andamento | "C"=Concluido
    *==========================================================================
    PROCEDURE Processa(par_cArquivo, par_nTamanho, par_cLocal, par_cHost, ;
                       par_nTransf, par_nBuffer, par_nSecIni, par_nSec, par_cStatus)
        LOCAL loc_nSec, loc_cTiEst, loc_cTiEla, loc_i, loc_oObj, loc_nIdx
        LOCAL loc_cEraseCmd, loc_oErro
        loc_nSec = par_nSec
        IF loc_nSec = 0
            loc_nSec = 0.001
        ENDIF
        TRY
            IF par_cStatus == "I"
                THIS.FileCtrlUp(.T., .T., "Iniciando a transfer" + CHR(234) + "ncia...")
                IF USED("tmpprog")
                    SELECT tmpprog
                    APPEND BLANK
                    REPLACE file   WITH par_cArquivo
                    REPLACE size   WITH par_nTamanho
                    REPLACE local  WITH par_cLocal
                    REPLACE host   WITH par_cHost
                    REPLACE status WITH "0 bytes copiados, 0% completado"
                ENDIF
            ENDIF
            IF par_cStatus == "A"
                IF USED("tmpprog")
                    SELECT tmpprog
                    LOCATE FOR tmpprog.file = par_cArquivo
                    IF FOUND()
                        REPLACE status WITH TRANSFORM(par_nTransf) + " bytes copiados, " + ;
                                            TRANSFORM(IIF(par_nTamanho > 0, par_nTransf * 100 / par_nTamanho, 0), "99.99") + ;
                                            "% completado"
                        loc_cTiEst = THIS.SectToHour(INT(IIF(par_nTransf > 0, ;
                                          (par_nTamanho - par_nTransf) * loc_nSec / par_nTransf, 0)))
                        loc_cTiEla = THIS.SectToHour(SECONDS() - par_nSecIni)
                        THIS.FileCtrlUp(par_nTransf * 100 / IIF(par_nTamanho > 0, par_nTamanho, 1), ;
                                        100, ;
                                        TRANSFORM(par_nTransf / loc_nSec / 1024, "9999.99") + " Kbps")
                        IF VARTYPE(THIS.lbl_4c_Lblprog) = "O"
                            THIS.lbl_4c_Lblprog.Caption = "Tempo decorrido: " + loc_cTiEla + ;
                                                          "   Tempo Estimado : " + loc_cTiEst
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
            IF par_cStatus == "C"
                IF USED("tmpprog")
                    SELECT tmpprog
                    LOCATE FOR tmpprog.file = par_cArquivo
                    IF FOUND()
                        REPLACE status WITH TRANSFORM(par_nTransf) + " bytes copiados, " + ;
                                            TRANSFORM(IIF(par_nTamanho > 0, par_nTransf * 100 / par_nTamanho, 0), "99.99") + ;
                                            "% completado em " + THIS.SectToHour(par_nSec)
                        THIS.FileCtrlUp(IIF(par_nTamanho > 0, par_nTransf * 100 / par_nTamanho, 100), ;
                                        100, ;
                                        TRANSFORM(IIF(loc_nSec > 0, par_nBuffer / loc_nSec / 1000, 0), "999.99") + " Kbps")
                        IF VARTYPE(THIS.lbl_4c_Lblprog) = "O"
                            THIS.lbl_4c_Lblprog.Caption = " Transfer" + CHR(234) + "ncia do arquivo [ " + ;
                                                          par_cArquivo + " ] Conclu" + CHR(237) + "da. OK"
                        ENDIF
                        THIS.Inf("Arquivo Transferido...", "B")
                        THIS.FileCtrlUp(.F., .F., "")
                        *-- Atualiza listbox: arquivo enviado local->FTP
                        IF par_cLocal == THIS.this_cDirEnvFtp
                            loc_oObj = THIS.cnt_4c_Container1.pgf_4c_Ftp.Page1.obj_4c_Lstrecloc
                            loc_nIdx = loc_oObj.ListCount + 1
                            loc_oObj.AddItem(par_cArquivo, loc_nIdx, 1)
                            loc_oObj.AddListItem(TRANSFORM(par_nTamanho), loc_nIdx, 2)
                            loc_oObj.AddListItem(TRANSFORM(par_nTransf), loc_nIdx, 3)
                            loc_oObj.Refresh()
                            IF THIS.this_lDelLocal
                                IF FILE(THIS.this_cDirEnvFtp + par_cArquivo)
                                    THIS.Inf("Excluindo arquivo local " + THIS.this_cDirEnvFtp + par_cArquivo, "B")
                                    loc_cEraseCmd = "ERASE " + THIS.this_cDirEnvFtp + par_cArquivo
                                    &loc_cEraseCmd
                                    IF FILE(THIS.this_cDirEnvFtp + par_cArquivo)
                                        THIS.Inf("Falha na exclus" + CHR(227) + "o do arquivo local " + par_cArquivo, "R")
                                    ELSE
                                        THIS.Inf("Arquivo local " + par_cArquivo + " exclu" + CHR(237) + "do.", "B")
                                        FOR loc_i = 1 TO THIS.cnt_4c_Container1.pgf_4c_Loc.Page1.obj_4c_Lstenvftp.ListCount
                                            IF UPPER(ALLTRIM(THIS.cnt_4c_Container1.pgf_4c_Loc.Page1.obj_4c_Lstenvftp.List(loc_i, 1))) = UPPER(par_cArquivo)
                                                THIS.cnt_4c_Container1.pgf_4c_Loc.Page1.obj_4c_Lstenvftp.RemoveItem(loc_i)
                                                EXIT
                                            ENDIF
                                        ENDFOR
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                        *-- Atualiza listbox: arquivo recebido FTP->local
                        IF par_cHost == THIS.this_cDirEnvLoc
                            loc_oObj = THIS.cnt_4c_Container1.pgf_4c_Loc.Page2.obj_4c_Lstrecftp
                            loc_nIdx = loc_oObj.ListCount + 1
                            loc_oObj.AddItem(par_cArquivo, loc_nIdx, 1)
                            loc_oObj.AddListItem(TRANSFORM(par_nTamanho), loc_nIdx, 2)
                            loc_oObj.AddListItem(TRANSFORM(par_nTransf), loc_nIdx, 3)
                            loc_oObj.Refresh()
                            IF THIS.this_lDelHost
                                THIS.Inf("Excluindo arquivo FTP " + THIS.this_cDirEnvLoc + par_cArquivo, "B")
                                IF THIS.DeleteFtpFile(THIS.this_cFtpAdd, THIS.this_cFtpUser, ;
                                                      THIS.this_cFtpPass, ;
                                                      THIS.this_cDirEnvLoc + par_cArquivo)
                                    THIS.Inf("Arquivo FTP " + par_cArquivo + " exclu" + CHR(237) + "do.", "B")
                                    FOR loc_i = 1 TO THIS.cnt_4c_Container1.pgf_4c_Ftp.Page2.obj_4c_Lstenvloc.ListCount
                                        IF UPPER(ALLTRIM(THIS.cnt_4c_Container1.pgf_4c_Ftp.Page2.obj_4c_Lstenvloc.List(loc_i, 1))) = UPPER(par_cArquivo)
                                            THIS.cnt_4c_Container1.pgf_4c_Ftp.Page2.obj_4c_Lstenvloc.RemoveItem(loc_i)
                                            EXIT
                                        ENDIF
                                    ENDFOR
                                ELSE
                                    THIS.Inf("Falha na exclus" + CHR(227) + "o FTP " + par_cArquivo, "R")
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
            IF VARTYPE(THIS.grd_4c_GrdProc) = "O"
                THIS.grd_4c_GrdProc.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro Processa")
        ENDTRY
    ENDPROC

    *==========================================================================
    * InErrorCase - Converte codigo de erro WinInet/Win32 em mensagem legivel
    * par_nErro: codigo de erro numerico (GetLastError / WinInet)
    * Retorno: string formatada "[ NNN : NOME_DO_ERRO ]"
    *==========================================================================
    PROCEDURE InErrorCase(par_nErro)
        LOCAL loc_cMensagem
        DO CASE
            CASE par_nErro = 12001
                loc_cMensagem = "ERROR_INTERNET_OUT_OF_HANDLES"
            CASE par_nErro = 12002
                loc_cMensagem = "ERROR_INTERNET_TIMEOUT"
            CASE par_nErro = 12003
                loc_cMensagem = "ERROR_INTERNET_EXTENDED_ERROR"
            CASE par_nErro = 12004
                loc_cMensagem = "ERROR_INTERNET_INTERNAL_ERROR"
            CASE par_nErro = 12005
                loc_cMensagem = "ERROR_INTERNET_INVALID_URL"
            CASE par_nErro = 12006
                loc_cMensagem = "ERROR_INTERNET_UNRECOGNIZED_SCHEME"
            CASE par_nErro = 12007
                loc_cMensagem = "ERROR_INTERNET_NAME_NOT_RESOLVED"
            CASE par_nErro = 12008
                loc_cMensagem = "ERROR_INTERNET_PROTOCOL_NOT_FOUND"
            CASE par_nErro = 12009
                loc_cMensagem = "ERROR_INTERNET_INVALID_OPTION"
            CASE par_nErro = 12010
                loc_cMensagem = "ERROR_INTERNET_BAD_OPTION_LENGTH"
            CASE par_nErro = 12011
                loc_cMensagem = "ERROR_INTERNET_OPTION_NOT_SETTABLE"
            CASE par_nErro = 12012
                loc_cMensagem = "ERROR_INTERNET_SHUTDOWN"
            CASE par_nErro = 12013
                loc_cMensagem = "ERROR_INTERNET_INCORRECT_USER_NAME"
            CASE par_nErro = 12014
                loc_cMensagem = "ERROR_INTERNET_INCORRECT_PASSWORD"
            CASE par_nErro = 12015
                loc_cMensagem = "ERROR_INTERNET_LOGIN_FAILURE"
            CASE par_nErro = 12016
                loc_cMensagem = "ERROR_INTERNET_INVALID_OPERATION"
            CASE par_nErro = 12017
                loc_cMensagem = "ERROR_INTERNET_OPERATION_CANCELLED"
            CASE par_nErro = 12018
                loc_cMensagem = "ERROR_INTERNET_INCORRECT_HANDLE_TYPE"
            CASE par_nErro = 12019
                loc_cMensagem = "ERROR_INTERNET_INCORRECT_HANDLE_STATE"
            CASE par_nErro = 12020
                loc_cMensagem = "ERROR_INTERNET_NOT_PROXY_REQUEST"
            CASE par_nErro = 12021
                loc_cMensagem = "ERROR_INTERNET_REGISTRY_VALUE_NOT_FOUND"
            CASE par_nErro = 12022
                loc_cMensagem = "ERROR_INTERNET_BAD_REGISTRY_PARAMETER"
            CASE par_nErro = 12023
                loc_cMensagem = "ERROR_INTERNET_NO_DIRECT_ACCESS"
            CASE par_nErro = 12024
                loc_cMensagem = "ERROR_INTERNET_NO_CONTEXT"
            CASE par_nErro = 12025
                loc_cMensagem = "ERROR_INTERNET_NO_CALLBACK"
            CASE par_nErro = 12026
                loc_cMensagem = "ERROR_INTERNET_REQUEST_PENDING"
            CASE par_nErro = 12027
                loc_cMensagem = "ERROR_INTERNET_INCORRECT_FORMAT"
            CASE par_nErro = 12028
                loc_cMensagem = "ERROR_INTERNET_ITEM_NOT_FOUND"
            CASE par_nErro = 12029
                loc_cMensagem = "ERROR_INTERNET_CANNOT_CONNECT"
            CASE par_nErro = 12030
                loc_cMensagem = "ERROR_INTERNET_CONNECTION_ABORTED"
            CASE par_nErro = 12031
                loc_cMensagem = "ERROR_INTERNET_CONNECTION_RESET"
            CASE par_nErro = 12032
                loc_cMensagem = "ERROR_INTERNET_FORCE_RETRY"
            CASE par_nErro = 12033
                loc_cMensagem = "ERROR_INTERNET_INVALID_PROXY_REQUEST"
            CASE par_nErro = 12034
                loc_cMensagem = "ERROR_INTERNET_NEED_UI"
            CASE par_nErro = 12036
                loc_cMensagem = "ERROR_INTERNET_HANDLE_EXISTS"
            CASE par_nErro = 12037
                loc_cMensagem = "ERROR_INTERNET_SEC_CERT_DATE_INVALID"
            CASE par_nErro = 12038
                loc_cMensagem = "ERROR_INTERNET_SEC_CERT_CN_INVALID"
            CASE par_nErro = 12039
                loc_cMensagem = "ERROR_INTERNET_HTTP_TO_HTTPS_ON_REDIR"
            CASE par_nErro = 12040
                loc_cMensagem = "ERROR_INTERNET_HTTPS_TO_HTTP_ON_REDIR"
            CASE par_nErro = 12041
                loc_cMensagem = "ERROR_INTERNET_MIXED_SECURITY"
            CASE par_nErro = 12042
                loc_cMensagem = "ERROR_INTERNET_CHG_POST_IS_NON_SECURE"
            CASE par_nErro = 12043
                loc_cMensagem = "ERROR_INTERNET_POST_IS_NON_SECURE"
            CASE par_nErro = 12044
                loc_cMensagem = "ERROR_INTERNET_CLIENT_AUTH_CERT_NEEDED"
            CASE par_nErro = 12045
                loc_cMensagem = "ERROR_INTERNET_INVALID_CA"
            CASE par_nErro = 12046
                loc_cMensagem = "ERROR_INTERNET_CLIENT_AUTH_NOT_SETUP"
            CASE par_nErro = 12047
                loc_cMensagem = "ERROR_INTERNET_ASYNC_THREAD_FAILED"
            CASE par_nErro = 12048
                loc_cMensagem = "ERROR_INTERNET_REDIRECT_SCHEME_CHANGE"
            CASE par_nErro = 12049
                loc_cMensagem = "ERROR_INTERNET_DIALOG_PENDING"
            CASE par_nErro = 12050
                loc_cMensagem = "ERROR_INTERNET_RETRY_DIALOG"
            CASE par_nErro = 12052
                loc_cMensagem = "ERROR_INTERNET_HTTPS_HTTP_SUBMIT_REDIR"
            CASE par_nErro = 12053
                loc_cMensagem = "ERROR_INTERNET_INSERT_CDROM"
            CASE par_nErro = 12110
                loc_cMensagem = "FTP_TRANSFER_IN_PROGRESS"
            CASE par_nErro = 12111
                loc_cMensagem = "FTP_DROPPED"
            CASE par_nErro = 12112
                loc_cMensagem = "FTP_NO_PASSIVE_MODE"
            CASE par_nErro = 12157
                loc_cMensagem = "ERROR_INTERNET_SECURITY_CHANNEL_ERROR"
            CASE par_nErro = 12158
                loc_cMensagem = "ERROR_INTERNET_UNABLE_TO_CACHE_FILE"
            CASE par_nErro = 12159
                loc_cMensagem = "ERROR_INTERNET_TCPIP_NOT_INSTALLED"
            CASE par_nErro = 12163
                loc_cMensagem = "ERROR_INTERNET_DISCONNECTED"
            CASE par_nErro = 12164
                loc_cMensagem = "ERROR_INTERNET_SERVER_UNREACHABLE"
            CASE par_nErro = 12165
                loc_cMensagem = "ERROR_INTERNET_PROXY_SERVER_UNREACHABLE"
            CASE par_nErro = 12166
                loc_cMensagem = "ERROR_INTERNET_BAD_AUTO_PROXY_SCRIPT"
            CASE par_nErro = 12167
                loc_cMensagem = "ERROR_INTERNET_UNABLE_TO_DOWNLOAD_SCRIPT"
            CASE par_nErro = 12169
                loc_cMensagem = "ERROR_INTERNET_SEC_INVALID_CERT"
            CASE par_nErro = 12170
                loc_cMensagem = "ERROR_INTERNET_SEC_CERT_REVOKED"
            CASE par_nErro = 18
                loc_cMensagem = "ERROR_NO_MORE_FILES"
            CASE par_nErro = 6
                loc_cMensagem = "ERROR_INVALID_HANDLE"
            CASE par_nErro = 2
                loc_cMensagem = "ERROR_FILE_NOT_FOUND"
            CASE par_nErro = 3
                loc_cMensagem = "ERROR_PATH_NOT_FOUND"
            CASE par_nErro = 5
                loc_cMensagem = "ERROR_ACCESS_DENIED"
            CASE par_nErro = 80
                loc_cMensagem = "ERROR_FILE_EXISTS"
            CASE par_nErro = 87
                loc_cMensagem = "ERROR_INVALID_PARAMETER"
            OTHERWISE
                loc_cMensagem = "Unknown Error Message"
        ENDCASE
        RETURN "[ " + ALLTRIM(STR(par_nErro)) + " : " + ALLTRIM(loc_cMensagem) + " ]"
    ENDPROC

    *==========================================================================
    * RasAtivas - Lista conexoes RAS atualmente ativas (RASAPI32.DLL)
    * par_cArrayRetorno: nome (string) do array PUBLIC a preencher com [N,4]
    *   [N,1]=handle hRasConn | [N,2]=nome | [N,3]=dispositivo | [N,4]=telefone
    * Retorno: numero de conexoes ativas
    *==========================================================================
    PROCEDURE RasAtivas(par_cArrayRetorno)
        LOCAL loc_cConexao, loc_cConexoes, loc_nSize, loc_nContagem, loc_nResult
        LOCAL loc_nPos, loc_oErro
        loc_nContagem = 0
        TRY
            DECLARE INTEGER RasEnumConnections ;
                IN RASAPI32.DLL ;
                STRING  @ RasConnectionsBuffer, ;
                INTEGER @ dwSize, ;
                INTEGER @ nCount

            loc_cConexao  = THIS.WordToC(412) + REPLICATE(CHR(0), 408)
            loc_cConexoes = REPLICATE(loc_cConexao, 16)
            loc_nSize     = LEN(loc_cConexoes)
            loc_nContagem = 0

            loc_nResult = RasEnumConnections(@loc_cConexoes, @loc_nSize, @loc_nContagem)

            IF loc_nContagem > 0
                PUBLIC ARRAY &par_cArrayRetorno.[loc_nContagem, 4]
                FOR loc_nPos = 0 TO loc_nContagem - 1
                    loc_cConexao = SUBSTR(loc_cConexoes, (loc_nPos * 412) + 1, 412)
                    &par_cArrayRetorno.[loc_nPos + 1, 1] = THIS.CToWord(SUBSTR(loc_cConexao, 5, 4))
                    &par_cArrayRetorno.[loc_nPos + 1, 2] = STRTRAN(SUBSTR(loc_cConexao, 9, 257), CHR(0))
                    &par_cArrayRetorno.[loc_nPos + 1, 3] = STRTRAN(SUBSTR(loc_cConexao, 266, 17), CHR(0))
                    &par_cArrayRetorno.[loc_nPos + 1, 4] = STRTRAN(SUBSTR(loc_cConexao, 283, 129), CHR(0))
                ENDFOR
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro RasAtivas")
            loc_nContagem = 0
        ENDTRY
        RETURN loc_nContagem
    ENDPROC

    *==========================================================================
    * RasConexao - Lista entradas disponiveis no Phonebook RAS (RASAPI32.DLL)
    * par_cArrayRetorno: nome (string) do array PUBLIC a preencher com [N]
    *   Cada elemento = nome da entrada de discagem
    * Retorno: numero de entradas encontradas
    *==========================================================================
    PROCEDURE RasConexao(par_cArrayRetorno)
        LOCAL loc_cEntrada, loc_cEntradas, loc_nSize, loc_nTotal, loc_nResult
        LOCAL loc_nCont, loc_cNomeEntrada, loc_oErro
        loc_nTotal = 0
        TRY
            DECLARE INTEGER RasEnumEntries ;
                IN RASAPI32.DLL ;
                INTEGER   reserved, ;
                STRING    PhoneBox, ;
                STRING  @ RasEntryName, ;
                INTEGER @ SizeOfRasEntryName, ;
                INTEGER @ Entries

            loc_cEntrada  = THIS.WordToC(264) + REPLICATE(CHR(0), 256)
            loc_cEntradas = REPLICATE(loc_cEntrada, 255)
            loc_nSize     = LEN(loc_cEntradas)
            loc_nTotal    = 0

            loc_nResult = RasEnumEntries(0, "", @loc_cEntradas, @loc_nSize, @loc_nTotal)

            IF loc_nTotal > 0
                RELEASE &par_cArrayRetorno.
                PUBLIC ARRAY &par_cArrayRetorno.[loc_nTotal]
                FOR loc_nCont = 0 TO loc_nTotal - 1
                    loc_cNomeEntrada = SUBSTR(loc_cEntradas, 264 * loc_nCont + 1, 264)
                    &par_cArrayRetorno.[loc_nCont + 1] = SUBSTR(loc_cNomeEntrada, 5, ;
                        AT(CHR(0), SUBSTR(loc_cNomeEntrada, 5)) - 1)
                ENDFOR
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro RasConexao")
            loc_nTotal = 0
        ENDTRY
        RETURN loc_nTotal
    ENDPROC

    *==========================================================================
    * RasDescon - Desconecta uma conexao RAS ativa via RasHangUp (RASAPI32.DLL)
    * par_nRasConn: handle da conexao RAS a encerrar (obtido por RasAtivas)
    * Retorno: resultado de RasHangUp (0 = sucesso)
    *==========================================================================
    PROCEDURE RasDescon(par_nRasConn)
        LOCAL loc_nResult, loc_oErro
        loc_nResult = -1
        TRY
            DECLARE Integer RasHangUp ;
                IN RASAPI32.DLL ;
                Integer hRasConn
            DECLARE Integer Sleep ;
                IN Win32API ;
                Integer Milliseconds
            THIS.Inf("Desconectando... ", "R")
            loc_nResult = RasHangUp(par_nRasConn)
            Sleep(3000)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro RasDescon")
        ENDTRY
        RETURN loc_nResult
    ENDPROC

    *==========================================================================
    * CarregarConexoesDialUp - Popula cbo_4c_CboProvedor com entradas RAS
    * Chamado automaticamente em CarregarParametros quando TpConnect = "D"
    *==========================================================================
    PROCEDURE CarregarConexoesDialUp
        LOCAL loc_nTotal, loc_i, loc_oErro
        TRY
            IF VARTYPE(THIS.cbo_4c_CboProvedor) = "O"
                THIS.cbo_4c_CboProvedor.Clear()
                loc_nTotal = THIS.RasConexao("aProvedor")
                IF loc_nTotal > 0
                    FOR loc_i = 1 TO loc_nTotal
                        THIS.cbo_4c_CboProvedor.AddItem(aProvedor(loc_i))
                    ENDFOR
                    IF THIS.cbo_4c_CboProvedor.ListCount > 0
                        THIS.cbo_4c_CboProvedor.ListIndex = 1
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro CarregarConexoesDialUp")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Destroy - Libera recursos ao encerrar o form
    *==========================================================================
    PROCEDURE Destroy
        IF USED("logftp")
            USE IN logftp
        ENDIF
        IF USED("tmpprog")
            USE IN tmpprog
        ENDIF
        IF USED("FtpServer")
            USE IN FtpServer
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * Adaptadores CRUD -> OPERACIONAL (FTP)
    *
    * Form operacional FTP: fluxo distinto do padrao CRUD (Incluir/Alterar/Visualizar/Excluir).
    * Os botoes reais sao: Conecta (cmd_4c_Cmdload), Transfere (cmd_4c_Cmdtran),
    * Recebe (cmd_4c_Cmdrec), Rede Dial-Up (cmd_4c_Cmdconect) e Encerrar
    * (cmd_4c_Cmdsair), alem dos botoes por-arquivo cmd_4c_Cmdtransfere e
    * cmd_4c_Cmdrecebe dentro do Container1.
    *
    * Os adaptadores abaixo mapeiam as intencoes CRUD (usadas por menus/pipeline)
    * para as operacoes reais equivalentes do fluxo FTP, evitando codigo morto
    * e mantendo compatibilidade com chamadores genericos.
    *==========================================================================

    *-- BtnIncluirClick: iniciar nova sessao FTP (conectar + carregar listagens)
    PROCEDURE BtnIncluirClick
        RETURN THIS.CmdCmdloadClick()
    ENDPROC

    *-- BtnAlterarClick: recarregar listagens FTP/local (refresh dos containers)
    PROCEDURE BtnAlterarClick
        RETURN THIS.CmdCmdloadClick()
    ENDPROC

    *-- BtnVisualizarClick: exibir arquivos disponiveis para envio/recebimento
    PROCEDURE BtnVisualizarClick
        RETURN THIS.MontarContainer()
    ENDPROC

    *-- BtnExcluirClick: excluir arquivo remoto selecionado no ListBox FTP
    *-- Se nenhum arquivo estiver selecionado, o proprio metodo emite aviso.
    PROCEDURE BtnExcluirClick
        LOCAL loc_oObj, loc_cArquivo, loc_lOk, loc_oErro
        loc_lOk = .F.
        TRY
            loc_oObj = THIS.cnt_4c_Container1.pgf_4c_Ftp.Page2.obj_4c_Lstenvloc
            IF VARTYPE(loc_oObj) = "O" AND loc_oObj.ListIndex > 0
                loc_cArquivo = ALLTRIM(loc_oObj.List(loc_oObj.ListIndex, 1))
                IF !EMPTY(loc_cArquivo) AND MsgConfirma("Excluir arquivo remoto: " + ;
                        loc_cArquivo + " ?", "Confirma" + CHR(231) + CHR(227) + "o")
                    loc_lOk = THIS.DeleteFtpFile(THIS.this_cFtpAdd, THIS.this_cFtpUser, ;
                                                  THIS.this_cFtpPass, loc_cArquivo)
                    IF loc_lOk
                        loc_oObj.RemoveItem(loc_oObj.ListIndex)
                        THIS.Inf("Arquivo " + loc_cArquivo + " exclu" + CHR(237) + "do do FTP.", "B")
                    ENDIF
                ENDIF
            ELSE
                THIS.Inf("Selecione um arquivo remoto para excluir.", "R")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro")
            loc_lOk = .F.
        ENDTRY
        RETURN loc_lOk
    ENDPROC

    *-- BtnBuscarClick: conectar e carregar listagens FTP/local
    PROCEDURE BtnBuscarClick
        RETURN THIS.CmdCmdloadClick()
    ENDPROC

    *-- BtnEncerrarClick: encerrar o formulario FTP
    PROCEDURE BtnEncerrarClick
        THIS.Release()
    ENDPROC

    *-- BtnSalvarClick: enviar todos os arquivos para o FTP
    PROCEDURE BtnSalvarClick
        RETURN THIS.Transfere("A")
    ENDPROC

    *-- BtnCancelarClick: receber todos os arquivos do FTP
    PROCEDURE BtnCancelarClick
        RETURN THIS.Receber("A")
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere configuracao FTP do form para o BO
    *==========================================================================
    PROCEDURE FormParaBO
        LOCAL loc_oBO
        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) != "O"
            RETURN .F.
        ENDIF
        loc_oBO.this_cTpConexaoEmp = THIS.this_cTpConnect
        loc_oBO.this_cFtpAddEmp    = THIS.this_cFtpAdd
        loc_oBO.this_cFtpUserEmp   = THIS.this_cFtpUser
        loc_oBO.this_cFtpPassEmp   = THIS.this_cFtpPass
        loc_oBO.this_cDriveTs      = THIS.this_cDirEnvFtp
        loc_oBO.this_cDriveLs      = THIS.this_cDirRecFtp
        loc_oBO.this_cDirFtpTs     = THIS.this_cDirRecLoc
        loc_oBO.this_cDirFtpLs     = THIS.this_cDirEnvLoc
        loc_oBO.this_lLocDel       = THIS.this_lDelLocal
        loc_oBO.this_lFtpDel       = THIS.this_lDelHost
        RETURN .T.
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere configuracao FTP do BO para os controles do form
    *==========================================================================
    PROCEDURE BOParaForm
        LOCAL loc_oBO, loc_oCnt, loc_oPgLoc, loc_oPgFtp, loc_oErro
        TRY
            loc_oBO = THIS.this_oBusinessObject
            IF VARTYPE(loc_oBO) != "O"
                loc_lResultado = .F.
            ENDIF
            THIS.this_cTpConnect = UPPER(ALLTRIM(loc_oBO.this_cTpConexaoEmp))
            THIS.this_cFtpAdd    = LOWER(ALLTRIM(loc_oBO.this_cFtpAddEmp))
            THIS.this_cFtpUser   = LOWER(ALLTRIM(loc_oBO.this_cFtpUserEmp))
            THIS.this_cFtpPass   = LOWER(ALLTRIM(loc_oBO.this_cFtpPassEmp))
            THIS.this_cDirEnvFtp = LOWER(ALLTRIM(loc_oBO.this_cDriveTs))
            THIS.this_cDirRecFtp = LOWER(ALLTRIM(loc_oBO.this_cDriveLs))
            THIS.this_cDirRecLoc = LOWER(ALLTRIM(loc_oBO.this_cDirFtpTs))
            THIS.this_cDirEnvLoc = LOWER(ALLTRIM(loc_oBO.this_cDirFtpLs))
            THIS.this_lDelLocal  = loc_oBO.this_lLocDel
            THIS.this_lDelHost   = loc_oBO.this_lFtpDel
            *-- Atualizar TextBoxes de caminhos nos PageFrames
            IF VARTYPE(THIS.cnt_4c_Container1) = "O"
                loc_oCnt   = THIS.cnt_4c_Container1
                loc_oPgLoc = loc_oCnt.pgf_4c_Loc
                loc_oPgFtp = loc_oCnt.pgf_4c_Ftp
                IF !EMPTY(THIS.this_cDirEnvFtp)
                    loc_oPgLoc.Page1.txt_4c_Direnvftp.Value = THIS.this_cDirEnvFtp
                ENDIF
                IF !EMPTY(THIS.this_cDirRecFtp)
                    loc_oPgLoc.Page2.txt_4c_Dirrecftp.Value = THIS.this_cDirRecFtp
                ENDIF
                IF !EMPTY(THIS.this_cDirRecLoc)
                    loc_oPgFtp.Page1.txt_4c_Dirrecloc.Value = THIS.this_cDirRecLoc
                ENDIF
                IF !EMPTY(THIS.this_cDirEnvLoc)
                    loc_oPgFtp.Page2.txt_4c_Direnvloc.Value = THIS.this_cDirEnvLoc
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro BOParaForm")
        ENDTRY
        RETURN .T.
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita botoes conforme modo de operacao
    * par_lHabilitar: .T. = habilitar (respeitando restricoes de modo)
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.cmd_4c_Cmdtran) = "O"
                THIS.cmd_4c_Cmdtran.Enabled = par_lHabilitar AND !THIS.this_lSomenteRecebimento
            ENDIF
            IF VARTYPE(THIS.cmd_4c_Cmdrec) = "O"
                THIS.cmd_4c_Cmdrec.Enabled = par_lHabilitar AND !THIS.this_lSomenteEnvio
            ENDIF
            IF VARTYPE(THIS.cmd_4c_Cmdload) = "O"
                THIS.cmd_4c_Cmdload.Enabled = par_lHabilitar
            ENDIF
            IF VARTYPE(THIS.cnt_4c_Container1) = "O"
                THIS.cnt_4c_Container1.cmd_4c_Cmdtransfere.Enabled = ;
                    par_lHabilitar AND !THIS.this_lSomenteRecebimento
                THIS.cnt_4c_Container1.cmd_4c_Cmdrecebe.Enabled = ;
                    par_lHabilitar AND !THIS.this_lSomenteEnvio
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro HabilitarCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa ListBoxes de arquivos, log e cursor de progresso
    *==========================================================================
    PROCEDURE LimparCampos
        LOCAL loc_oObj, loc_i, loc_oErro
        TRY
            IF VARTYPE(THIS.cnt_4c_Container1) = "O"
                loc_oObj = THIS.cnt_4c_Container1.pgf_4c_Loc.Page1.obj_4c_Lstenvftp
                FOR loc_i = loc_oObj.ListCount TO 1 STEP -1
                    loc_oObj.RemoveItem(loc_i)
                ENDFOR
                loc_oObj = THIS.cnt_4c_Container1.pgf_4c_Loc.Page2.obj_4c_Lstrecftp
                FOR loc_i = loc_oObj.ListCount TO 1 STEP -1
                    loc_oObj.RemoveItem(loc_i)
                ENDFOR
                loc_oObj = THIS.cnt_4c_Container1.pgf_4c_Ftp.Page1.obj_4c_Lstrecloc
                FOR loc_i = loc_oObj.ListCount TO 1 STEP -1
                    loc_oObj.RemoveItem(loc_i)
                ENDFOR
                loc_oObj = THIS.cnt_4c_Container1.pgf_4c_Ftp.Page2.obj_4c_Lstenvloc
                FOR loc_i = loc_oObj.ListCount TO 1 STEP -1
                    loc_oObj.RemoveItem(loc_i)
                ENDFOR
            ENDIF
            IF USED("logftp")
                SELECT logftp
                ZAP
                IF VARTYPE(THIS.grd_4c_GrdInf) = "O"
                    THIS.grd_4c_GrdInf.Refresh()
                ENDIF
            ENDIF
            IF USED("tmpprog")
                SELECT tmpprog
                ZAP
                IF VARTYPE(THIS.grd_4c_GrdProc) = "O"
                    THIS.grd_4c_GrdProc.Refresh()
                ENDIF
            ENDIF
            IF VARTYPE(THIS.lbl_4c_Lblprog) = "O"
                THIS.lbl_4c_Lblprog.Caption = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro LimparCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarLista - Recarrega listagens FTP e local (adaptador CRUD)
    *==========================================================================
    PROCEDURE CarregarLista
        RETURN THIS.MontarContainer()
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo de operacao
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo
        THIS.HabilitarCampos(.T.)
    ENDPROC

ENDDEFINE
