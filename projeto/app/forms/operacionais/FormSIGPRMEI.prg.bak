*==============================================================================
* FormSIGPRMEI.prg - Form Integracao SIS E-Commerce
* Herdado de: FormBase
* Tipo: OPERACIONAL (dialogo de processamento - sem PageFrame)
* Portado de: SIGPRMEI.SCX
*
* NAO-PORT DELIBERADO:
*   Load (=fConfigGeral()) - fConfigGeral era funcao GLOBAL da aplicacao legado
*   (sig.prg/SIGFUNCS.PRG) que nao veio no acervo. O wrapper NO-OP em
*   projeto\app\utils\fconfiggeral.prg existe so para o p-code dos VCX legado
*   (nao editavel) continuar resolvendo o nome; em codigo NOSSO nunca se chama
*   fConfigGeral. O que ela fazia (configuracao global) ja ocorre ANTES deste
*   form abrir: config.prg (SETs/paths/aliases), main.prg (conexao) e o
*   proprio SIGPRMEIBO (SigCdPam via InicializarForm). Mesmo padrao de
*   FormSigMvExp.prg/FormSigPrCar.prg.
*
*   Destroy (ThisForm.PoDataMgr.Release + DoDefault) - poDataMgr era o
*   data manager do Framework legado (fSqlConector); equivalente no migrado
*   eh THIS.this_oBusinessObject, liberado em Destroy() abaixo.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF

DEFINE CLASS FormSIGPRMEI AS FormBase

    *-- Dimensoes (PILAR 1: identico ao legado SIGPRMEI.SCX)
    Width       = 500
    Height      = 147
    AutoCenter  = .T.
    TitleBar    = 0
    ShowWindow = 1
    WindowType = 1
    ControlBox  = .F.
    FontBold    = .F.          && SCX: SIGPRMEI.FontBold
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    KeyPreview  = .T.
    DataSession = 2
    AlwaysOnTop = .T.
    BorderStyle = 2

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Modo automatico: .T. = iniciado por scheduler sem interface interativa
    this_lParametrizado  = .F.

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        LPARAMETERS par_lParametrizado
        THIS.this_lParametrizado = IIF(VARTYPE(par_lParametrizado) = "L", par_lParametrizado, .F.)
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Background e fontes do dialogo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ScrollBars = 0
        THIS.ShowTips   = .T.
        THIS.SetAll("FontName", "Tahoma")
        THIS.SetAll("FontSize", 8)
        THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria BO, carrega config SigCdPam e monta controles
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nRet
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SIGPRMEIBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"

                *-- Titulo com acentuacao via CHR (PILAR 1: fidelidade ao caption legado)
                THIS.Caption = "Integra" + CHR(231) + CHR(227) + "o SIS E-Commerce"

                *-- Carregar configuracoes operacionais de SigCdPam
                IF gnConnHandle > 0
                    loc_cSQL = "SELECT DirLivrosV, CdChepSais, Mascnums, CdChepEnts FROM SigCdPam"
                    loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPam")
                    IF loc_nRet > 0
                        SELECT cursor_4c_SigCdPam
                        GO TOP
                        IF !EOF("cursor_4c_SigCdPam")
                            THIS.this_oBusinessObject.this_cDirLivros  = ALLTRIM(cursor_4c_SigCdPam.DirLivrosV)
                            THIS.this_oBusinessObject.this_cDirSaida   = ALLTRIM(cursor_4c_SigCdPam.CdChepSais)
                            THIS.this_oBusinessObject.this_cMascNums   = ALLTRIM(cursor_4c_SigCdPam.Mascnums)
                            THIS.this_oBusinessObject.this_cDirEntrada = ALLTRIM(cursor_4c_SigCdPam.CdChepEnts)
                        ENDIF
                        USE IN SELECT("cursor_4c_SigCdPam")
                    ELSE
                        MsgErro("Erro ao carregar configura" + CHR(231) + CHR(245) + "es de SigCdPam.", "FormSIGPRMEI.InicializarForm")
                    ENDIF
                ENDIF

                THIS.this_oBusinessObject.this_lParametrizado = THIS.this_lParametrizado

                THIS.ConfigurarPageFrame()
                THIS.ConfigurarCabecalho()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.ConfigurarBotoes()
                THIS.ConfigurarLabels()

                *-- TabIndex: DEPOIS de todos os AddObject (regra: atribuir em
                *-- controle inexistente derruba o Init)
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                THIS.TornarControlesVisiveis(THIS)

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar Business Object SIGPRMEIBO." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "FormSIGPRMEI.InicializarForm")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container cinza escuro com titulo em sombra e branco
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab

        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCab = THIS.cnt_4c_Cabecalho

        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .Top           = 18
            .Left          = 10
            .Width         = THIS.Width
            .Height        = 40
            .AutoSize      = .F.
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .ForeColor     = RGB(0, 0, 0)
            .Rotation      = 0                      && SCX: lblSombra.Rotation
            .Caption       = THIS.Caption
            .Visible       = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .Top          = 17
            .Left         = 10
            .Width        = THIS.Width
            .Height       = 46
            .AutoSize     = .F.
            .FontBold     = .T.
            .FontName     = "Tahoma"
            .FontSize     = 18
            .WordWrap     = .T.
            .Alignment    = 0
            .BackStyle    = 0
            .ForeColor    = RGB(255, 255, 255)
            .ToolTipText  = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Rotation     = 0                       && SCX: lblTitulo.Rotation
            .Caption      = THIS.Caption
            .Visible      = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - Botoes Processar e Encerrar sobrepostos ao cabecalho
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()

        *-- Botao Processar
        THIS.AddObject("btn_4c_Processar", "CommandButton")
        WITH THIS.btn_4c_Processar
            .Top             = 3
            .Left            = 350                && SCX: cmdBtnForm.Left=345 + Command1.Left=5
            .Width           = 75
            .Height          = 75
            .Caption         = "Processar"
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .ToolTipText     = "Processar"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"     && SCX: Command1.FontName
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .WordWrap        = .T.
            .AutoSize        = .F.
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.btn_4c_Processar, "Click", THIS, "BtnProcessarClick")

        *-- Botao Encerrar
        THIS.AddObject("btn_4c_Encerrar", "CommandButton")
        WITH THIS.btn_4c_Encerrar
            .Top             = 3
            .Left            = 425                && SCX: cmdBtnForm.Left=345 + Command2.Left=80
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel          = .T.
            .ToolTipText     = "[ESC] Sair"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"     && SCX: Command2.FontName
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .WordWrap        = .T.
            .AutoSize        = .F.
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.btn_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarLabels - Label de identificacao e label de status dinamico
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarLabels()

        *-- Label de identificacao do sistema (Label2 no legado)
        THIS.AddObject("lbl_4c_Info", "Label")
        WITH THIS.lbl_4c_Info
            .FontBold    = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackStyle   = 0
            .BorderStyle = 0
            .Caption     = "Integra" + CHR(231) + CHR(227) + "o Sis e-Commerce"
            .Height      = 20
            .Left        = 147
            .Top         = 96
            .Width       = 205
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 234)
            .Visible     = .T.
        ENDWITH

        *-- Label de status do processamento (Label1 no legado - atualizado dinamicamente)
        THIS.AddObject("lbl_4c_Status", "Label")
        WITH THIS.lbl_4c_Status
            .FontBold    = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackStyle   = 0
            .BorderStyle = 0
            .Caption     = ""
            .Height      = 20
            .Left        = 56
            .Top         = 114
            .Width       = 387
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 234)
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * Activate - Auto-inicia processamento em modo automatico (Parametrizado)
    *--------------------------------------------------------------------------
    PROCEDURE Activate()
        IF THIS.this_lParametrizado
            THIS.BtnProcessarClick()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnProcessarClick - Loop de processamento: LerArquivos + GravarArquivos
    *--------------------------------------------------------------------------
    PROCEDURE BtnProcessarClick()
        LOCAL loc_llOk1, loc_llOk2, loc_lnMov, loc_lnKey, loc_lnError, loc_lcErro
        LOCAL loc_lSaiuPeloBotao

        loc_lSaiuPeloBotao = .F.

        THIS.btn_4c_Processar.Enabled = .F.
        SET CURSOR OFF

        *-- SCX btnCopiar.Click: Keyboard [{LEFTARROW}] - tira o foco do botao que
        *-- acabou de perder o Enabled, para que o INKEY(.5, "M") do loop capture
        *-- mouse e teclado em vez de a tecla ficar presa no controle desabilitado.
        KEYBOARD "{LEFTARROW}"

        loc_lnMov = 1
        DO WHILE .T.
            THIS.btn_4c_Encerrar.Enabled = .F.
            THIS.lbl_4c_Status.Caption = "Aguardando Arquivos Para Processar" + REPLICATE(".", loc_lnMov)
            loc_lnMov = IIF(loc_lnMov < 5, loc_lnMov + 1, 1)

            loc_llOk1 = THIS.this_oBusinessObject.LerArquivos()
            loc_llOk2 = THIS.this_oBusinessObject.GravarArquivos()

            IF !EMPTY(THIS.this_oBusinessObject.this_cUltStatus)
                THIS.lbl_4c_Status.Caption = THIS.this_oBusinessObject.this_cUltStatus
            ENDIF

            THIS.btn_4c_Encerrar.Enabled = .T.

            *-- Aguardar 0.5s capturando input do usuario
            loc_lnError = 0
            loc_lcErro  = ON("Error")
            ON ERROR loc_lnError = 1

            loc_lnKey = INKEY(.5, "M")

            IF loc_lnError <> 0
                loc_lnKey = 0
            ENDIF
            ON ERROR &loc_lcErro.

            *-- Sair apos ciclo unico se nao-parametrizado, ou se ESC pressionado
            IF !THIS.this_lParametrizado OR loc_lnKey = 27
                EXIT
            ENDIF

            *-- SCX btnCopiar.Click: clique do mouse sobre o botao Encerrar tambem
            *-- interrompe o polling. INKEY(.5, "M") devolve 151 no clique com o
            *-- botao esquerdo; MCOL/MROW com nScaleMode = 3 dao a posicao do
            *-- ponteiro em PIXELS dentro da janela do form, que eh a unidade em
            *-- que Left/Top/Width/Height dos controles estao. Sem este ramo o loop
            *-- so para por ESC e clicar em Encerrar nao surte efeito algum.
            IF loc_lnKey = 151 AND ;
               THIS.MouseSobreBotaoSair(MCOL(THIS.Name, 3), MROW(THIS.Name, 3), THIS.btn_4c_Encerrar)
                loc_lSaiuPeloBotao = .T.
                THIS.BtnEncerrarClick()
                EXIT
            ENDIF
        ENDDO

        SET CURSOR ON

        *-- Restauracao NAO roda quando o Encerrar ja liberou o form: os controles
        *-- pertencem a um form em liberacao, e o legado tambem nao chega aqui em
        *-- estado util (btnSair.Click faz ThisForm.Release).
        IF !loc_lSaiuPeloBotao
            THIS.lbl_4c_Status.Caption = ""
            THIS.btn_4c_Processar.Enabled = .T.

            IF THIS.this_lParametrizado
                THIS.Release()
                QUIT
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * MouseSobreBotaoSair - O ponteiro do mouse esta sobre o botao de saida?
    *
    * O SCX legado CHAMA ThisForm.MouseSobreBotaoSair(...) no loop do
    * btnCopiar.Click mas NUNCA a define: a ClassInfo do SCX (RESERVED3) lista
    * apenas desabotao / gravararquivos / habilitabotao / lerarquivos, e a classe
    * do form eh "form" PURA, sem VCX de onde herdar. Transcrever a chamada sem
    * definir o metodo cairia na regra #13 do CLAUDE.md: nome desconhecido nao eh
    * erro de compilacao - o VFP procura mousesobrebotaosair.prg no PATH e so
    * estoura em RUNTIME, dentro do loop de processamento. Por isso o metodo eh
    * IMPLEMENTADO aqui, com a semantica que o call site exige.
    *
    * par_nCol / par_nRow : posicao do ponteiro em PIXELS dentro da janela do
    *                       form (MCOL/MROW com nScaleMode = 3)
    * par_oBotao          : o CommandButton de saida a testar
    *--------------------------------------------------------------------------
    PROCEDURE MouseSobreBotaoSair(par_nCol, par_nRow, par_oBotao)
        LOCAL loc_nLeft, loc_nTop, loc_oPai, loc_nNivel, loc_lSobre

        loc_lSobre = .F.

        IF VARTYPE(par_oBotao) = "O" AND VARTYPE(par_nCol) = "N" AND VARTYPE(par_nRow) = "N"

            *-- Left/Top sao RELATIVOS ao pai: somar a cadeia de containers ate o
            *-- Form da a posicao ABSOLUTA na janela, que eh o referencial de
            *-- MCOL/MROW. Hoje os dois botoes sao filhos diretos do Form (o
            *-- cmdBtnForm do legado foi desmembrado em dois CommandButton), mas
            *-- somar a cadeia mantem o teste correto se algum deles voltar para
            *-- dentro de um container.
            loc_nLeft  = par_oBotao.Left
            loc_nTop   = par_oBotao.Top
            loc_oPai   = par_oBotao.Parent
            loc_nNivel = 0

            *-- Guarda de profundidade: evita laco infinito se a cadeia de Parent
            *-- vier ciclica ou nunca alcancar o Form.
            DO WHILE VARTYPE(loc_oPai) = "O" AND loc_nNivel < 20
                IF UPPER(loc_oPai.BaseClass) == "FORM"
                    EXIT
                ENDIF
                IF PEMSTATUS(loc_oPai, "Left", 5) AND PEMSTATUS(loc_oPai, "Top", 5)
                    loc_nLeft = loc_nLeft + loc_oPai.Left
                    loc_nTop  = loc_nTop  + loc_oPai.Top
                ENDIF
                IF !PEMSTATUS(loc_oPai, "Parent", 5)
                    EXIT
                ENDIF
                loc_oPai   = loc_oPai.Parent
                loc_nNivel = loc_nNivel + 1
            ENDDO

            loc_lSobre = BETWEEN(par_nCol, loc_nLeft, loc_nLeft + par_oBotao.Width) ;
                AND BETWEEN(par_nRow, loc_nTop, loc_nTop + par_oBotao.Height)
        ENDIF

        RETURN loc_lSobre
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Executa UM ciclo manual de leitura+gravacao
    *
    * Em forms CRUD, este botao inclui novo registro. Neste form OPERACIONAL
    * de integracao SIS E-Commerce, aciona um ciclo unico de processamento
    * dos XMLs em fila ("incluir novo lote de movimentos"), sem entrar no
    * loop continuo do BtnProcessar. Util para operacao manual pontual.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_llOk1, loc_llOk2, loc_oErro

        THIS.btn_4c_Processar.Enabled = .F.
        THIS.btn_4c_Encerrar.Enabled  = .F.
        THIS.lbl_4c_Status.Caption    = "Processando novo lote..."

        TRY
            loc_llOk1 = THIS.this_oBusinessObject.LerArquivos()
            loc_llOk2 = THIS.this_oBusinessObject.GravarArquivos()

            IF !EMPTY(THIS.this_oBusinessObject.this_cUltStatus)
                THIS.lbl_4c_Status.Caption = THIS.this_oBusinessObject.this_cUltStatus
            ELSE
                THIS.lbl_4c_Status.Caption = IIF(loc_llOk1 AND loc_llOk2, ;
                    "Lote processado com sucesso.", ;
                    "Falha no processamento do lote.")
            ENDIF
        CATCH TO loc_oErro
            THIS.lbl_4c_Status.Caption = "Erro: " + loc_oErro.Message
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "FormSIGPRMEI.BtnIncluirClick")
        ENDTRY

        THIS.btn_4c_Processar.Enabled = .T.
        THIS.btn_4c_Encerrar.Enabled  = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Reprocessa: releitura imediata de arquivos em fila
    *
    * Em forms CRUD, este botao edita registro. Neste form OPERACIONAL, forca
    * releitura imediata dos XMLs ? util quando o operador corrigiu arquivos
    * no diretorio de entrada e nao quer esperar o polling do BtnProcessar.
    * Delega para BtnIncluirClick (mesma operacao de ciclo unico).
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        THIS.BtnIncluirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Exibe configuracoes ativas da integracao SIS
    *
    * Em forms CRUD, este botao visualiza registro. Neste form OPERACIONAL,
    * mostra as configuracoes carregadas de SigCdPam (diretorios de entrada/
    * saida, mascara de numeracao) ? permite ao operador confirmar caminhos
    * antes de iniciar processamento.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cMsg, loc_oBO

        loc_oBO = THIS.this_oBusinessObject

        loc_cMsg = "Configura" + CHR(231) + CHR(245) + "es de Integra" + ;
                   CHR(231) + CHR(227) + "o SIS E-Commerce:" + CHR(13) + CHR(13)
        loc_cMsg = loc_cMsg + "Diret" + CHR(243) + "rio de Livros (XMLs de venda web):" + CHR(13)
        loc_cMsg = loc_cMsg + "  " + ALLTRIM(loc_oBO.this_cDirLivros) + CHR(13) + CHR(13)
        loc_cMsg = loc_cMsg + "Diret" + CHR(243) + "rio de Sa" + CHR(237) + "da (estoque.xml):" + CHR(13)
        loc_cMsg = loc_cMsg + "  " + ALLTRIM(loc_oBO.this_cDirSaida) + CHR(13) + CHR(13)
        loc_cMsg = loc_cMsg + "Diret" + CHR(243) + "rio de Entrada:" + CHR(13)
        loc_cMsg = loc_cMsg + "  " + ALLTRIM(loc_oBO.this_cDirEntrada) + CHR(13) + CHR(13)
        loc_cMsg = loc_cMsg + "M" + CHR(225) + "scara Num" + CHR(233) + "rica: " + ALLTRIM(loc_oBO.this_cMascNums) + CHR(13)
        loc_cMsg = loc_cMsg + "Arquivos processados na sess" + CHR(227) + "o: " + ;
                   TRANSFORM(loc_oBO.this_nArqProcessados)

        MsgInfo(loc_cMsg, "Configura" + CHR(231) + CHR(245) + "es")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Aborta processamento em andamento e encerra
    *
    * Em forms CRUD, este botao exclui registro. Neste form OPERACIONAL, aborta
    * qualquer polling ativo (desliga modo parametrizado), restaura estado dos
    * botoes e fecha o dialogo ? equivalente a "cancelar integracao e sair".
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_lConfirma

        loc_lConfirma = MsgConfirma("Deseja realmente cancelar a integra" + ;
            CHR(231) + CHR(227) + "o e encerrar?", "Confirma" + CHR(231) + CHR(227) + "o")

        IF !loc_lConfirma
            RETURN
        ENDIF

        THIS.this_lParametrizado = .F.
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_lParametrizado = .F.
            THIS.this_oBusinessObject.this_lProcessando   = .F.
        ENDIF

        THIS.btn_4c_Processar.Enabled = .T.
        THIS.btn_4c_Encerrar.Enabled  = .T.
        THIS.lbl_4c_Status.Caption    = ""

        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - N/A para OPERACIONAL sem PageFrame
    *
    * FormSIGPRMEI eh um dialogo de processamento (500x147) sem PageFrame,
    * portanto nao ha Page1/Lista/Grid como em forms CRUD (frmcadastro).
    * Metodo mantido pela interface do pipeline de migracao. A construcao
    * real dos controles ocorre em ConfigurarCabecalho + ConfigurarBotoes
    * + ConfigurarLabels chamados por InicializarForm.
    *
    * Efeito real: limpa o rotulo de status (equivalente a "recarregar a
    * lista" nos forms CRUD - devolve o dialogo ao estado inicial).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        IF PEMSTATUS(THIS, "lbl_4c_Status", 5)
            THIS.lbl_4c_Status.Caption = ""
        ENDIF
        IF PEMSTATUS(THIS, "btn_4c_Processar", 5)
            THIS.btn_4c_Processar.Enabled = .T.
        ENDIF
        IF PEMSTATUS(THIS, "btn_4c_Encerrar", 5)
            THIS.btn_4c_Encerrar.Enabled = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Ordem de tabulacao transcrita do SCX legado
    *
    * FormSIGPRMEI eh um dialogo de processamento (500x147) sem PageFrame: o SCX
    * legado nao tem TextBox/EditBox/ComboBox/Grid algum (arvore completa =
    * cntSombra + lblSombra/lblTitulo, cmdBtnForm com 2 botoes, Label2, Label1),
    * entao nao existe campo de dados a criar - analise.json confirma campos,
    * lookups e labels vazios. O trabalho real desta fase eh o TabIndex, que o
    * migrador descarta: com AddObject o VFP9 numera pela ORDEM DE CRIACAO, que
    * nao tem relacao com a ordem do legado, e isso nao gera erro nem log.
    *
    * TabIndex declarado no SCX:
    *   cmdBtnForm           = 4   CommandGroup - sem TabStop, nao focalizavel
    *   cmdBtnForm.Command1  = 2   -> btn_4c_Processar  (Processar)
    *   cmdBtnForm.Command2  = 3   -> btn_4c_Encerrar   (Encerrar)
    *   Label2 / Label1      = 4   Label nao tem TabStop - TabIndex inerte
    *
    * Numerar SO os focalizaveis: Label nao tem TabStop (nao recebe foco), logo
    * transcrever o TabIndex dos labels seria inerte e ainda EMBARALHARIA a
    * sequencia dos controles que de fato param o Tab - por isso os tres "4"
    * duplicados do SCX (cmdBtnForm/Label2/Label1) nao sao reproduzidos. Entre
    * os dois focalizaveis nao ha empate, e a ordem relativa do legado
    * (Command1=2 antes de Command2=3) fica preservada.
    *
    * Atribuicao em ordem ASCENDENTE: cada atribuicao poe o controle na posicao
    * pedida e empurra os demais para tras. Chamado por InicializarForm DEPOIS
    * de todos os AddObject - antes disso atribuiria em controle inexistente.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        IF PEMSTATUS(THIS, "btn_4c_Processar", 5)
            THIS.btn_4c_Processar.TabIndex = 1
        ENDIF
        IF PEMSTATUS(THIS, "btn_4c_Encerrar", 5)
            THIS.btn_4c_Encerrar.TabIndex = 2
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - N/A para OPERACIONAL sem PageFrame
    *
    * FormSIGPRMEI nao possui PageFrame. Metodo mantido pela interface do
    * pipeline de migracao. O parametro representa o modo do dialogo:
    *   1 = OCIOSO       (Processar habilitado, aguardando comando do usuario)
    *   2 = PROCESSANDO  (Processar desabilitado durante loop de leitura/gravacao)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lProcessando
        loc_lProcessando = (par_nPagina = 2)
        IF PEMSTATUS(THIS, "btn_4c_Processar", 5)
            THIS.btn_4c_Processar.Enabled = !loc_lProcessando
        ENDIF
        IF PEMSTATUS(THIS, "btn_4c_Encerrar", 5)
            THIS.btn_4c_Encerrar.Enabled = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Verifica XMLs em fila no diretorio de entrada
    *
    * Em forms CRUD, este botao abre busca por registro. Neste form OPERACIONAL,
    * varre o diretorio de livros (XMLs de pedidos web) e informa quantos
    * arquivos aguardam processamento ? util para diagnostico antes de processar.
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_laDirs[1], loc_lnArq, loc_cDir, loc_cMsg, loc_oBO, loc_oErro, loc_lProsseguir
        loc_lProsseguir = .T.
        TRY
            loc_oBO  = THIS.this_oBusinessObject
            loc_cDir = ALLTRIM(loc_oBO.this_cDirLivros)

            IF EMPTY(loc_cDir)
                MsgAviso("Diret" + CHR(243) + "rio de entrada n" + CHR(227) + "o configurado." + CHR(13) + ;
                    "Verifique as configura" + CHR(231) + CHR(245) + "es de SigCdPam.", ;
                    "Buscar Pedidos")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                IF RIGHT(loc_cDir, 1) <> "\"
                    loc_cDir = loc_cDir + "\"
                ENDIF

                loc_lnArq = ADIR(loc_laDirs, loc_cDir + "*.XML")

                IF loc_lnArq = 0
                    loc_cMsg = "Nenhum pedido em fila de processamento." + CHR(13) + CHR(13) + ;
                        "Diret" + CHR(243) + "rio: " + loc_cDir + CHR(13) + CHR(13) + ;
                        "Total processado na sess" + CHR(227) + "o: " + TRANSFORM(loc_oBO.this_nArqProcessados)
                    MsgInfo(loc_cMsg, "Buscar Pedidos")
                ELSE
                    loc_cMsg = TRANSFORM(loc_lnArq) + " pedido(s) web aguardando processamento." + CHR(13) + CHR(13) + ;
                        "Diret" + CHR(243) + "rio: " + loc_cDir + CHR(13) + CHR(13) + ;
                        "Total processado na sess" + CHR(227) + "o: " + TRANSFORM(loc_oBO.this_nArqProcessados) + CHR(13) + CHR(13) + ;
                        "Clique em Processar para importar os pedidos."
                    MsgInfo(loc_cMsg, "Buscar Pedidos")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "FormSIGPRMEI.BtnBuscarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Executa um ciclo de processamento (equivalente a Processar)
    *
    * Em forms CRUD, salva dados editados. Neste form OPERACIONAL, executa
    * imediatamente UM ciclo de leitura+gravacao (LerArquivos + GravarArquivos),
    * sem entrar no loop continuo do BtnProcessar ? para uso manual pontual.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnIncluirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Interrompe processamento em andamento
    *
    * Em forms CRUD, cancela edicao em curso. Neste form OPERACIONAL, desativa
    * o modo automatico (parametrizado) para que o loop do BtnProcessar encerre
    * no proximo ciclo, restaurando o dialogo ao estado de repouso.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_lParametrizado = .F.
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_lParametrizado = .F.
            THIS.this_oBusinessObject.this_lProcessando   = .F.
        ENDIF
        IF PEMSTATUS(THIS, "lbl_4c_Status", 5)
            THIS.lbl_4c_Status.Caption = "Processamento cancelado."
        ENDIF
        THIS.AjustarBotoesPorModo()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Sincroniza estado do form para o BO
    *
    * Form OPERACIONAL sem campos de entrada: sincroniza apenas o flag de
    * modo automatico (this_lParametrizado) entre o dialogo e o BO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_lParametrizado = THIS.this_lParametrizado
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Sincroniza estado do BO para o form
    *
    * Form OPERACIONAL sem campos editaveis: atualiza o label de status com
    * a ultima mensagem gerada pelo BO durante o processamento.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oBO
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_oBO = THIS.this_oBusinessObject
            IF PEMSTATUS(THIS, "lbl_4c_Status", 5) AND !EMPTY(ALLTRIM(loc_oBO.this_cUltStatus))
                THIS.lbl_4c_Status.Caption = loc_oBO.this_cUltStatus
            ENDIF
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita botoes conforme modo de operacao
    *
    * par_cModo: "IDLE"        -> Processar habilitado, aguardando
    *            "PROCESSANDO" -> Processar desabilitado durante loop
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_cModo)
        LOCAL loc_lIdle
        loc_lIdle = (UPPER(ALLTRIM(par_cModo)) = "IDLE" OR EMPTY(par_cModo))

        IF PEMSTATUS(THIS, "btn_4c_Processar", 5)
            THIS.btn_4c_Processar.Enabled = loc_lIdle
        ENDIF
        IF PEMSTATUS(THIS, "btn_4c_Encerrar", 5)
            THIS.btn_4c_Encerrar.Enabled = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Reseta o status do dialogo para o estado inicial
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        IF PEMSTATUS(THIS, "lbl_4c_Status", 5)
            THIS.lbl_4c_Status.Caption = ""
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_cUltStatus = ""
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Atualiza o dialogo com estado atual do BO
    *
    * Forms CRUD usam este metodo para recarregar o grid. Neste form
    * OPERACIONAL, sincroniza o status label com o ultimo estado do BO
    * e restaura os botoes para o modo de repouso (IDLE).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        THIS.BOParaForm()
        THIS.AjustarBotoesPorModo()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Restaura botoes ao modo de repouso (IDLE)
    *
    * Em forms CRUD, ajusta botoes conforme modo INCLUIR/ALTERAR/VISUALIZAR.
    * Neste form OPERACIONAL, restaura sempre ao estado IDLE (Processar
    * habilitado, Encerrar habilitado) apos conclusao de qualquer operacao.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        THIS.HabilitarCampos("IDLE")
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
    *--------------------------------------------------------------------------
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormSIGPRMEI.Destroy")
        ENDTRY
        DODEFAULT()
    ENDPROC

ENDDEFINE
