*==============================================================================
* FormEnd.prg
* Form Operacional: Cadastro de Enderecos de Entrega (SigCdCeE)
* Herda de: FormBase
* Tipo: OPERACIONAL - flat layout, form modal chamado por FormCliente e outros
* SCX Origem: SigCdEnd.SCX
*
* Parametros Init: pGru, pCon, pDes, pEsc, pCnx (ignorado), pCod
*   pGru - Grupo da conta (obrigatorio, usado em SigCdGcr)
*   pCon - IClis do cliente (obrigatorio)
*   pDes - Nome do cliente (para exibicao)
*   pEsc - Modo: CONSULTAR / INSERIR / ALTERAR (default CONSULTAR)
*   pCnx - Objeto de conexao legado (ignorado: usa gnConnHandle)
*   pCod - Codigos do local a localizar (default 0)
*
* Cursores:
*   crCursorCliEE - dados de SigCdCeE do cliente (ControlSource dos campos)
*   crGrade       - cursor local para RecordSource do grd_4c_Locais
*==============================================================================

DEFINE CLASS FormEnd AS FormBase

    *-- Propriedades visuais (pixel-perfect do SCX original - PILAR 1)
    Width        = 800
    Height       = 600
    AutoCenter   = .T.
    Caption      = "Cadastro de Enderecos"
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    TitleBar     = 0
    ClipControls = .F.
    Themes       = .F.
    BorderStyle  = 2
    DataSession  = 1

    *-- Parametros recebidos em Init (armazenados antes de DODEFAULT)
    this_cGrupo          = ""          && pGru - grupo do cliente
    this_cIClis          = ""          && pCon - IClis do cliente (padr 10)
    this_cNome           = ""          && pDes - nome do cliente
    this_cModo           = "CONSULTAR" && pEsc - CONSULTAR/INSERIR/ALTERAR
    this_nCodigos        = 0           && pCod - Codigos a localizar

    *-- Flags de estado operacional
    this_lTipoPais       = .F.    && .T. quando pais != BRASIL
    this_cTipoCep        = "1"    && tipo CEP
    this_lEntraInserindo = .F.    && entrou em modo inserir automaticamente

    *-- Flags de configuracao do grupo (de SigCdGcr)
    this_nCepObris = 0    && 1=CEP obrigatorio
    this_nChkEndDs = 0    && 1=verificar endereco duplicado
    this_nChkEndRs = 0    && 1=verificar bairro/endereco restrito

    *==================================================================
    * Init - Armazena parametros antes de DODEFAULT (que chama InicializarForm)
    *==================================================================
    PROCEDURE Init(par_pGru, par_pCon, par_pDes, par_pEsc, par_pCnx, par_pCod)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        THIS.this_cGrupo  = IIF(VARTYPE(par_pGru) = "C", ALLTRIM(par_pGru), "")
        THIS.this_cIClis  = IIF(VARTYPE(par_pCon) = "C", PADR(ALLTRIM(par_pCon), 10), SPACE(10))
        THIS.this_cNome   = IIF(VARTYPE(par_pDes) = "C", par_pDes, SPACE(50))
        THIS.this_cModo   = "CONSULTAR"
        IF VARTYPE(par_pEsc) = "C" AND INLIST(par_pEsc, "INSERIR", "ALTERAR")
            THIS.this_cModo = par_pEsc
        ENDIF
        THIS.this_nCodigos = IIF(VARTYPE(par_pCod) = "N", par_pCod, 0)

        loc_lResultado = DODEFAULT()
        RETURN loc_lResultado
    ENDPROC

    *==================================================================
    * InicializarForm - Cria BO, cursores, controles e carrega dados
    *==================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Cursor local para RecordSource do grid
            IF USED("crGrade")
                USE IN crGrade
            ENDIF
            CREATE CURSOR crGrade (Atuals L, Descrs C(50), Codigos N(10, 0))

            *-- Instanciar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("EndBO")

            IF VARTYPE(THIS.this_oBusinessObject) <> "O"
                MsgErro("Erro ao criar EndBO. VARTYPE retornou: " + ;
                    VARTYPE(THIS.this_oBusinessObject), "FormEnd.InicializarForm")
            ELSE
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
                THIS.Caption = "Cadastro de Endere" + CHR(231) + "os"

                *-- Carregar flags de configuracao do grupo
                THIS.this_oBusinessObject.CarregarConfigGrupo(THIS.this_cGrupo)
                THIS.this_nCepObris = THIS.this_oBusinessObject.this_nCepObris
                THIS.this_nChkEndDs = THIS.this_oBusinessObject.this_nChkEndDs
                THIS.this_nChkEndRs = THIS.this_oBusinessObject.this_nChkEndRs

                *-- Carregar enderecos do cliente (cria crCursorCliEE)
                THIS.this_oBusinessObject.CarregarEnderecos(THIS.this_cIClis, THIS.this_nCodigos)

                *-- Garantir crCursorCliEE para ControlSources (mesmo sem conexao/dados)
                IF !USED("crCursorCliEE")
                    CREATE CURSOR crCursorCliEE (IClis C(10), Codigos N(10,0), Atuals L, ;
                        Descrs C(50), Ceps C(9), Paises C(30), Endes C(60), Nums C(10), ;
                        Compls C(50), Bairs C(40), Cidas C(30), Estas C(2), Ddds C(4), ;
                        Tel1s C(20), Tel2s C(20), Contatos C(20), Refers M)
                ENDIF

                *-- Construir interface
                THIS.ConfigurarCabecalho()
                THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.ConfigurarCommandGroups()
                THIS.ConfigurarGrid()
                THIS.ConfigurarPaginaDados()
                THIS.BindEventos()

                *-- Ajustar visibilidade de botoes conforme modo
                THIS.AjustarBotoes()

                *-- Popular grade a partir de crCursorCliEE
                THIS.AtualizaTela(.T.)

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormEnd.InicializarForm")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==================================================================
    * ConfigurarCabecalho - Container cinza escuro com titulo do form
    *==================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCnt
        THIS.AddObject("cnt_4c_Sombra", "Container")
        loc_oCnt = THIS.cnt_4c_Sombra
        WITH loc_oCnt
            .Top         = -1
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackColor   = RGB(100, 100, 100)
            .Visible     = .T.
        ENDWITH
        loc_oCnt.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCnt.lbl_4c_Sombra
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .AutoSize      = .F.
            .Caption       = "Cadastro de Endere" + CHR(231) + "os"
            .Height        = 40
            .Left          = 10
            .Top           = 18
            .Width         = 769
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH
        loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCnt.lbl_4c_Titulo
            .FontBold   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 18
            .WordWrap   = .T.
            .Alignment  = 0
            .BackStyle  = 0
            .AutoSize   = .F.
            .Caption    = "Cadastro de Endere" + CHR(231) + "os"
            .Height     = 46
            .Left       = 10
            .Top        = 17
            .Width      = 769
            .ForeColor  = RGB(255, 255, 255)
            .Visible    = .T.
        ENDWITH
    ENDPROC

    *==================================================================
    * ConfigurarCommandGroups - Containers com botoes de acao
    *==================================================================
    PROTECTED PROCEDURE ConfigurarCommandGroups()
        LOCAL loc_oCnt

        *-- cnt_4c_Escolha: Inserir / Alterar / Excluir / Copiar (sobre header)
        THIS.AddObject("cnt_4c_Escolha", "Container")
        loc_oCnt = THIS.cnt_4c_Escolha
        WITH loc_oCnt
            .Top         = -3
            .Left        = 270
            .Width       = 310
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("btn_4c_Inserir", "CommandButton")
        WITH loc_oCnt.btn_4c_Inserir
            .Top         = 5
            .Left        = 5
            .Width       = 75
            .Height      = 75
            .Caption     = "\<Inserir"
            .Picture     = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .WordWrap    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .ToolTipText = "Inserir Um Novo Local de Entrega"
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("btn_4c_Alterar", "CommandButton")
        WITH loc_oCnt.btn_4c_Alterar
            .Top         = 5
            .Left        = 80
            .Width       = 75
            .Height      = 75
            .Caption     = "\<Alterar"
            .Picture     = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .WordWrap    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .ToolTipText = "Alterar o Local de Entrega"
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("btn_4c_Excluir", "CommandButton")
        WITH loc_oCnt.btn_4c_Excluir
            .Top         = 5
            .Left        = 155
            .Width       = 75
            .Height      = 75
            .Caption     = "\<Excluir"
            .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .WordWrap    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .ToolTipText = "Excluir o Local de Entrega"
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("btn_4c_Copiar", "CommandButton")
        WITH loc_oCnt.btn_4c_Copiar
            .Top         = 5
            .Left        = 230
            .Width       = 75
            .Height      = 75
            .Caption     = "C\<opiar"
            .Picture     = gc_4c_CaminhoIcones + "geral_duplicar_60.jpg"
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .WordWrap    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .ToolTipText = "Copiar o Endere" + CHR(231) + "o Principal"
            .Visible     = .T.
        ENDWITH

        *-- cnt_4c_Salva: Salvar / Cancelar / Encerrar
        THIS.AddObject("cnt_4c_Salva", "Container")
        loc_oCnt = THIS.cnt_4c_Salva
        WITH loc_oCnt
            .Top         = -3
            .Left        = 571
            .Width       = 234
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("btn_4c_Salvar", "CommandButton")
        WITH loc_oCnt.btn_4c_Salvar
            .Top         = 5
            .Left        = 5
            .Width       = 75
            .Height      = 75
            .Caption     = "\<Salvar"
            .Picture     = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .WordWrap    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .ToolTipText = "Gravar os Dados"
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("btn_4c_Cancelar", "CommandButton")
        WITH loc_oCnt.btn_4c_Cancelar
            .Top         = 5
            .Left        = 79
            .Width       = 75
            .Height      = 75
            .Caption     = "\<Cancelar"
            .Picture     = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .WordWrap    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .ToolTipText = "Cancelar os Dados"
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("btn_4c_Encerrar", "CommandButton")
        WITH loc_oCnt.btn_4c_Encerrar
            .Top         = 5
            .Left        = 154
            .Width       = 75
            .Height      = 75
            .Caption     = "Encerrar"
            .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .WordWrap    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .ToolTipText = "Sair do Cadastro"
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==================================================================
    * ConfigurarGrid - grd_4c_Locais com Column1=CheckBox e Column2=Descrs
    *==================================================================
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_oGrid

        THIS.AddObject("grd_4c_Locais", "Grid")
        loc_oGrid = THIS.grd_4c_Locais

        WITH loc_oGrid
            .Top               = 143
            .Left              = 149
            .Width             = 541
            .Height            = 148
            .ColumnCount       = 2
            .FontName          = "Tahoma"
            .FontSize          = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .HeaderHeight      = 16
            .RowHeight         = 16
            .ScrollBars        = 2
            .GridLineColor     = RGB(238, 238, 238)
            .ReadOnly          = .F.
            .Visible           = .T.
        ENDWITH

        *-- Column1: CheckBox para campo Atuals (marcacao do endereco ativo)
        WITH loc_oGrid.Column1
            .Width     = 15
            .ReadOnly  = .F.
            .Sparse    = .F.
            .Movable   = .F.
            .Resizable = .F.
            .AddObject("Check1", "CheckBox")
            .Check1.Top       = 9
            .Check1.Left      = 2
            .Check1.Height    = 17
            .Check1.Width     = 22
            .Check1.Alignment = 0
            .Check1.Caption   = ""
            .Check1.Alignment = 0
            .Check1.Top       = 9
            .Check1.Left      = 2
            .Check1.Height    = 17
            .Check1.Width     = 22
            .Check1.ReadOnly  = .F.
            .Check1.Visible   = .T.
            .Check1.Value     = .F.
            .CurrentControl   = "Check1"
            .Header1.Caption  = ""
            .Header1.Alignment = 2
            .Header1.FontName = "Tahoma"
            .Header1.FontSize = 8
            .ControlSource    = "crGrade.Atuals"
        ENDWITH

        *-- Column2: TextBox para campo Descrs (descricao do local)
        WITH loc_oGrid.Column2
            .Width     = 492
            .ReadOnly  = .F.
            .Sparse    = .F.
            .Movable   = .F.
            .Resizable = .F.
            .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .ControlSource     = "crGrade.Descrs"
        ENDWITH

        IF PEMSTATUS(loc_oGrid.Column2, "Text1", 5)
            WITH loc_oGrid.Column2.Text1
                .Format      = "K!"
                .BorderStyle = 1
                .Margin      = 0
                .ReadOnly    = .F.
                .ForeColor   = RGB(0, 0, 0)
                .Visible     = .T.
            ENDWITH
        ENDIF

        *-- RecordSource APOS ControlSources (evita reset de headers pelo VFP)
        loc_oGrid.RecordSource = "crGrade"
    ENDPROC

    *==================================================================
    * ConfigurarCampos - TextBoxes e EditBox para os campos de endereco
    *==================================================================
    PROTECTED PROCEDURE ConfigurarCampos()
        *-- txt_4c_Codigos: codigo do cliente (display, desabilitado)
        THIS.AddObject("txt_4c_Codigos", "TextBox")
        WITH THIS.txt_4c_Codigos
            .Enabled           = .F.
            .Left              = 148
            .Top               = 97
            .Width             = 80
            .Height            = 23
            .SpecialEffect     = 1
            .DisabledBackColor = RGB(255, 255, 230)
            .DisabledForeColor = RGB(0, 0, 0)
            .Visible           = .T.
            .Value             = ALLTRIM(THIS.this_cIClis)
        ENDWITH

        *-- txt_4c_Nomes: nome do cliente (display, desabilitado)
        THIS.AddObject("txt_4c_Nomes", "TextBox")
        WITH THIS.txt_4c_Nomes
            .Enabled           = .F.
            .Left              = 323
            .Top               = 97
            .Width             = 367
            .Height            = 23
            .Format            = "K!"
            .DisabledBackColor = RGB(255, 255, 230)
            .DisabledForeColor = RGB(0, 0, 0)
            .Visible           = .T.
            .Value             = ALLTRIM(THIS.this_cNome)
        ENDWITH

        *-- txt_4c_Paises: pais (ControlSource = crCursorCliEE.Paises)
        THIS.AddObject("txt_4c_Paises", "TextBox")
        WITH THIS.txt_4c_Paises
            .Left              = 148
            .Top               = 312
            .Width             = 175
            .Height            = 23
            .Format            = "K!"
            .SpecialEffect     = 1
            .TabIndex          = 8
            .DisabledBackColor = RGB(255, 255, 230)
            .DisabledForeColor = RGB(0, 0, 0)
            .Visible           = .T.
            .ControlSource     = "crCursorCliEE.Paises"
        ENDWITH

        *-- txt_4c_Ceps: CEP (InputMask padrao CEP)
        THIS.AddObject("txt_4c_Ceps", "TextBox")
        WITH THIS.txt_4c_Ceps
            .Left              = 396
            .Top               = 312
            .Width             = 80
            .Height            = 23
            .InputMask         = "99999-999"
            .SpecialEffect     = 1
            .TabIndex          = 10
            .DisabledBackColor = RGB(255, 255, 230)
            .DisabledForeColor = RGB(0, 0, 0)
            .Visible           = .T.
            .ControlSource     = "crCursorCliEE.Ceps"
        ENDWITH

        *-- txt_4c_Endes: logradouro
        THIS.AddObject("txt_4c_Endes", "TextBox")
        WITH THIS.txt_4c_Endes
            .Left              = 148
            .Top               = 337
            .Width             = 430
            .Height            = 23
            .Format            = "K!"
            .SpecialEffect     = 1
            .TabIndex          = 12
            .DisabledBackColor = RGB(255, 255, 230)
            .DisabledForeColor = RGB(0, 0, 0)
            .Visible           = .T.
            .ControlSource     = "crCursorCliEE.Endes"
        ENDWITH

        *-- txt_4c_Nums: numero
        THIS.AddObject("txt_4c_Nums", "TextBox")
        WITH THIS.txt_4c_Nums
            .Left              = 606
            .Top               = 337
            .Width             = 80
            .Height            = 23
            .SpecialEffect     = 1
            .TabIndex          = 14
            .DisabledBackColor = RGB(255, 255, 230)
            .DisabledForeColor = RGB(0, 0, 0)
            .Visible           = .T.
            .ControlSource     = "crCursorCliEE.Nums"
        ENDWITH

        *-- txt_4c_Compls: complemento
        THIS.AddObject("txt_4c_Compls", "TextBox")
        WITH THIS.txt_4c_Compls
            .Left              = 148
            .Top               = 362
            .Width             = 185
            .Height            = 23
            .Format            = "K!"
            .SpecialEffect     = 1
            .TabIndex          = 16
            .DisabledBackColor = RGB(255, 255, 230)
            .DisabledForeColor = RGB(0, 0, 0)
            .Visible           = .T.
            .ControlSource     = "crCursorCliEE.Compls"
        ENDWITH

        *-- txt_4c_Bairs: bairro
        THIS.AddObject("txt_4c_Bairs", "TextBox")
        WITH THIS.txt_4c_Bairs
            .Left              = 396
            .Top               = 362
            .Width             = 290
            .Height            = 23
            .Format            = "K!"
            .SpecialEffect     = 1
            .TabIndex          = 18
            .DisabledBackColor = RGB(255, 255, 230)
            .DisabledForeColor = RGB(0, 0, 0)
            .Visible           = .T.
            .ControlSource     = "crCursorCliEE.Bairs"
        ENDWITH

        *-- txt_4c_Cidas: cidade
        THIS.AddObject("txt_4c_Cidas", "TextBox")
        WITH THIS.txt_4c_Cidas
            .Left              = 148
            .Top               = 387
            .Width             = 224
            .Height            = 23
            .Format            = "K!"
            .SpecialEffect     = 1
            .TabIndex          = 20
            .DisabledBackColor = RGB(255, 255, 230)
            .DisabledForeColor = RGB(0, 0, 0)
            .Visible           = .T.
            .ControlSource     = "crCursorCliEE.Cidas"
        ENDWITH

        *-- txt_4c_Estas: UF (2 chars, caixa alta, Valid abre picker)
        THIS.AddObject("txt_4c_Estas", "TextBox")
        WITH THIS.txt_4c_Estas
            .Left              = 444
            .Top               = 387
            .Width             = 24
            .Height            = 23
            .Format            = "K!"
            .MaxLength         = 2
            .SpecialEffect     = 1
            .TabIndex          = 22
            .DisabledBackColor = RGB(255, 255, 230)
            .DisabledForeColor = RGB(0, 0, 0)
            .Visible           = .T.
            .ControlSource     = "crCursorCliEE.Estas"
        ENDWITH

        *-- txt_4c_Contatos: contato
        THIS.AddObject("txt_4c_Contatos", "TextBox")
        WITH THIS.txt_4c_Contatos
            .Left              = 536
            .Top               = 387
            .Width             = 150
            .Height            = 23
            .Format            = "K!"
            .SpecialEffect     = 1
            .TabIndex          = 24
            .DisabledBackColor = RGB(255, 255, 230)
            .DisabledForeColor = RGB(0, 0, 0)
            .Visible           = .T.
            .ControlSource     = "crCursorCliEE.Contatos"
        ENDWITH

        *-- txt_4c_Ddds: DDD
        THIS.AddObject("txt_4c_Ddds", "TextBox")
        WITH THIS.txt_4c_Ddds
            .Left              = 148
            .Top               = 412
            .Width             = 38
            .Height            = 23
            .Format            = "K!"
            .SpecialEffect     = 1
            .TabIndex          = 26
            .DisabledBackColor = RGB(255, 255, 230)
            .DisabledForeColor = RGB(0, 0, 0)
            .Visible           = .T.
            .ControlSource     = "crCursorCliEE.Ddds"
        ENDWITH

        *-- txt_4c_Tel1s: telefone 1
        THIS.AddObject("txt_4c_Tel1s", "TextBox")
        WITH THIS.txt_4c_Tel1s
            .Left              = 282
            .Top               = 412
            .Width             = 150
            .Height            = 23
            .Format            = "K!"
            .MaxLength         = 20
            .SpecialEffect     = 1
            .TabIndex          = 28
            .DisabledBackColor = RGB(255, 255, 230)
            .DisabledForeColor = RGB(0, 0, 0)
            .Visible           = .T.
            .ControlSource     = "crCursorCliEE.Tel1s"
        ENDWITH

        *-- txt_4c_Tel2s: telefone 2
        THIS.AddObject("txt_4c_Tel2s", "TextBox")
        WITH THIS.txt_4c_Tel2s
            .Left              = 536
            .Top               = 412
            .Width             = 150
            .Height            = 23
            .Format            = "K!"
            .MaxLength         = 20
            .SpecialEffect     = 1
            .TabIndex          = 30
            .DisabledBackColor = RGB(255, 255, 230)
            .DisabledForeColor = RGB(0, 0, 0)
            .Visible           = .T.
            .ControlSource     = "crCursorCliEE.Tel2s"
        ENDWITH

        *-- edt_4c_Refers: observacoes / referencias (EditBox para campo Memo)
        THIS.AddObject("edt_4c_Refers", "EditBox")
        WITH THIS.edt_4c_Refers
            .Left              = 148
            .Top               = 437
            .Width             = 538
            .Height            = 58
            .SpecialEffect     = 1
            .TabIndex          = 32
            .DisabledBackColor = RGB(255, 255, 230)
            .DisabledForeColor = RGB(0, 0, 0)
            .Visible           = .T.
            .ControlSource     = "crCursorCliEE.Refers"
        ENDWITH
    ENDPROC

    *==================================================================
    * ConfigurarLabels - Labels de identificacao dos campos
    *==================================================================
    PROTECTED PROCEDURE ConfigurarLabels()
        *-- "Codigo :" (Say1) - IClis
        THIS.AddObject("lbl_4c_Codigo", "Label")
        WITH THIS.lbl_4c_Codigo
            .FontName = "Verdana"
            .Caption  = "C" + CHR(243) + "digo :"
            .Left     = 92
            .Top      = 101
            .AutoSize = .T.
            .Visible  = .T.
        ENDWITH

        *-- "Local :" (Say3) - acima do grid
        THIS.AddObject("lbl_4c_Local", "Label")
        WITH THIS.lbl_4c_Local
            .FontName = "Verdana"
            .Caption  = "Local :"
            .Left     = 103
            .Top      = 146
            .AutoSize = .T.
            .Visible  = .T.
        ENDWITH

        *-- "Nome :" (Say2) - nome do cliente
        THIS.AddObject("lbl_4c_Nome", "Label")
        WITH THIS.lbl_4c_Nome
            .FontName = "Verdana"
            .Caption  = "Nome :"
            .Left     = 277
            .Top      = 98
            .AutoSize = .T.
            .Visible  = .T.
        ENDWITH

        *-- "Pais :" (Say15)
        THIS.AddObject("lbl_4c_Pais", "Label")
        WITH THIS.lbl_4c_Pais
            .FontName = "Verdana"
            .Caption  = "Pa" + CHR(237) + "s :"
            .Left     = 109
            .Top      = 316
            .AutoSize = .T.
            .Visible  = .T.
        ENDWITH

        *-- "CEP : " (Say6)
        THIS.AddObject("lbl_4c_Cep", "Label")
        WITH THIS.lbl_4c_Cep
            .FontName = "Verdana"
            .Caption  = "CEP : "
            .Left     = 361
            .Top      = 316
            .AutoSize = .T.
            .Visible  = .T.
        ENDWITH

        *-- "Endereco :" (Say4)
        THIS.AddObject("lbl_4c_Endereco", "Label")
        WITH THIS.lbl_4c_Endereco
            .FontName = "Verdana"
            .Caption  = "Endere" + CHR(231) + "o :"
            .Left     = 79
            .Top      = 341
            .AutoSize = .T.
            .Visible  = .T.
        ENDWITH

        *-- "n? :" (Say10)
        THIS.AddObject("lbl_4c_Num", "Label")
        WITH THIS.lbl_4c_Num
            .Caption  = "n" + CHR(186) + " :"
            .Left     = 583
            .Top      = 341
            .AutoSize = .T.
            .Visible  = .T.
        ENDWITH

        *-- "Complemento :" (Say18)
        THIS.AddObject("lbl_4c_Compl", "Label")
        WITH THIS.lbl_4c_Compl
            .FontName = "Verdana"
            .Caption  = "Complemento :"
            .Left     = 52
            .Top      = 366
            .AutoSize = .T.
            .Visible  = .T.
        ENDWITH

        *-- "Bairro : " (Say5)
        THIS.AddObject("lbl_4c_Bairro", "Label")
        WITH THIS.lbl_4c_Bairro
            .FontName = "Verdana"
            .Caption  = "Bairro : "
            .Left     = 350
            .Top      = 366
            .AutoSize = .T.
            .Visible  = .T.
        ENDWITH

        *-- "Cidade :" (Say7)
        THIS.AddObject("lbl_4c_Cidade", "Label")
        WITH THIS.lbl_4c_Cidade
            .FontName = "Verdana"
            .Caption  = "Cidade :"
            .Left     = 92
            .Top      = 391
            .AutoSize = .T.
            .Visible  = .T.
        ENDWITH

        *-- "Estado : " (Say8)
        THIS.AddObject("lbl_4c_Estado", "Label")
        WITH THIS.lbl_4c_Estado
            .FontName = "Verdana"
            .Caption  = "Estado : "
            .Left     = 393
            .Top      = 391
            .AutoSize = .T.
            .Visible  = .T.
        ENDWITH

        *-- "Contato :" (Say11)
        THIS.AddObject("lbl_4c_Contato", "Label")
        WITH THIS.lbl_4c_Contato
            .FontName = "Verdana"
            .Caption  = "Contato :"
            .Left     = 479
            .Top      = 391
            .AutoSize = .T.
            .Visible  = .T.
        ENDWITH

        *-- "DDD :" (Say13)
        THIS.AddObject("lbl_4c_Ddd", "Label")
        WITH THIS.lbl_4c_Ddd
            .FontName = "Verdana"
            .Caption  = "DDD :"
            .Left     = 105
            .Top      = 416
            .AutoSize = .T.
            .Visible  = .T.
        ENDWITH

        *-- "Telefone (1) :" (Say9)
        THIS.AddObject("lbl_4c_Tel1", "Label")
        WITH THIS.lbl_4c_Tel1
            .FontName = "Verdana"
            .Caption  = "Telefone (1) :"
            .Left     = 202
            .Top      = 416
            .AutoSize = .T.
            .Visible  = .T.
        ENDWITH

        *-- "Telefone (2) :" (Say12)
        THIS.AddObject("lbl_4c_Tel2", "Label")
        WITH THIS.lbl_4c_Tel2
            .FontName = "Verdana"
            .Caption  = "Telefone (2) :"
            .Left     = 456
            .Top      = 416
            .AutoSize = .T.
            .Visible  = .T.
        ENDWITH

        *-- "Observacao :" (Say14)
        THIS.AddObject("lbl_4c_Observ", "Label")
        WITH THIS.lbl_4c_Observ
            .FontName = "Tahoma"
            .Caption  = "Observa" + CHR(231) + CHR(227) + "o :"
            .Height   = 15
            .Left     = 76
            .Top      = 437
            .Width    = 67
            .AutoSize = .F.
            .ForeColor = RGB(90, 90, 90)
            .Visible  = .T.
        ENDWITH
    ENDPROC

    *==================================================================
    * BindEventos - Vincula eventos de controles a metodos PUBLIC do form
    *==================================================================
    PROTECTED PROCEDURE BindEventos()
        *-- Botoes Escolha
        BINDEVENT(THIS.cnt_4c_Escolha.btn_4c_Inserir, "Click", THIS, "BtnIncluirClick")
        BINDEVENT(THIS.cnt_4c_Escolha.btn_4c_Alterar, "Click", THIS, "BtnAlterarClick")
        BINDEVENT(THIS.cnt_4c_Escolha.btn_4c_Excluir, "Click", THIS, "BtnExcluirClick")
        BINDEVENT(THIS.cnt_4c_Escolha.btn_4c_Copiar,  "Click", THIS, "BtnCopiarClick")

        *-- Botoes Salva
        BINDEVENT(THIS.cnt_4c_Salva.btn_4c_Salvar,   "Click", THIS, "BtnSalvarClick")
        BINDEVENT(THIS.cnt_4c_Salva.btn_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
        BINDEVENT(THIS.cnt_4c_Salva.btn_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid: AfterRowColChange para sincronizar campos com linha corrente
        BINDEVENT(THIS.grd_4c_Locais, "AfterRowColChange", THIS, "GrdLocaisAfterRowColChange")

        *-- Checkbox Column1: controle manual do toggle Atuals
        BINDEVENT(THIS.grd_4c_Locais.Column1.Check1, "Click",     THIS, "GrdChkClick")
        BINDEVENT(THIS.grd_4c_Locais.Column1.Check1, "KeyPress",  THIS, "GrdChkKeyPress")
        BINDEVENT(THIS.grd_4c_Locais.Column1.Check1, "MouseDown", THIS, "GrdChkMouseDown")
        BINDEVENT(THIS.grd_4c_Locais.Column1.Check1, "MouseUp",   THIS, "GrdChkMouseUp")
        BINDEVENT(THIS.grd_4c_Locais.Column1.Check1, "KeyPress", THIS, "GrdChkLostFocus")
        BINDEVENT(THIS.grd_4c_Locais.Column1.Check1, "When",      THIS, "GrdChkWhen")

        *-- Text1 Column2: controle de edicao do campo Descrs
        *-- NOTA: BINDEVENT "Valid" nao funciona em TextBox; logica de Valid
        *-- foi incorporada em GrdDescrsLostFocus
        BINDEVENT(THIS.grd_4c_Locais.Column2.Text1, "KeyPress", THIS, "GrdDescrsLostFocus")
        BINDEVENT(THIS.grd_4c_Locais.Column2.Text1, "When",      THIS, "GrdDescrsWhen")

        *-- Campos de endereco: restricao e validacao de UF
        BINDEVENT(THIS.txt_4c_Ceps,   "KeyPress", THIS, "TxtCepsLostFocus")
        BINDEVENT(THIS.txt_4c_Bairs,  "KeyPress", THIS, "TxtBairsLostFocus")
        BINDEVENT(THIS.txt_4c_Endes,  "KeyPress", THIS, "TxtEndesLostFocus")
        BINDEVENT(THIS.txt_4c_Cidas,  "KeyPress", THIS, "TxtCidasLostFocus")
        *-- UF: BINDEVENT "Valid" nao funciona em TextBox; usar KeyPress (ENTER/TAB/F4) + DblClick
        BINDEVENT(THIS.txt_4c_Estas,  "KeyPress",  THIS, "TxtEstasKeyPress")
        BINDEVENT(THIS.txt_4c_Estas,  "DblClick",  THIS, "TxtEstasDblClick")
        BINDEVENT(THIS.txt_4c_Paises, "GotFocus",  THIS, "TxtPaisesGotFocus")
        BINDEVENT(THIS.txt_4c_Paises, "KeyPress", THIS, "TxtPaisesLostFocus")
    ENDPROC

    *==================================================================
    * AjustarBotoes - Ajusta visibilidade dos botoes conforme modo
    *==================================================================
    PROCEDURE AjustarBotoes()
        WITH THIS
            IF (.this_cModo = "CONSULTAR")
                .cnt_4c_Escolha.Visible               = .F.
                .cnt_4c_Salva.btn_4c_Salvar.Visible   = .F.
                .cnt_4c_Salva.btn_4c_Cancelar.Visible = .F.
            ELSE
                .cnt_4c_Escolha.Visible               = .T.
                .cnt_4c_Salva.btn_4c_Salvar.Visible   = .T.
                .cnt_4c_Salva.btn_4c_Cancelar.Visible = .T.
            ENDIF
        ENDWITH
    ENDPROC

    *==================================================================
    * AtualizaTela - Sincroniza crGrade com crCursorCliEE e atualiza grid
    * par_lPosChk: .T. posicionar no marcado; .F. posicionar por Descrs
    *==================================================================
    PROCEDURE AtualizaTela(par_lPosChk)
        LOCAL loc_lcDes, loc_llMar, loc_lnCod
        loc_lcDes = ""
        loc_llMar = .F.
        loc_lnCod = 0

        TRY
            IF USED("crGrade") AND !EOF("crGrade")
                loc_lcDes = crGrade.Descrs
            ENDIF

            *-- Garantir que crCursorCliEE existe
            IF !USED("crCursorCliEE")
                THIS.this_oBusinessObject.CarregarEnderecos(THIS.this_cIClis, THIS.this_nCodigos)
            ENDIF

            IF USED("crCursorCliEE")
                UPDATE crCursorCliEE SET Refers = [] WHERE ISNULL(Refers)
            ENDIF

            *-- Ajustar Atuals pelo Codigos pedido (uma vez)
            IF INLIST(THIS.this_cModo, "INSERIR", "ALTERAR") AND THIS.this_nCodigos <> 0
                IF USED("crCursorCliEE")
                    UPDATE crCursorCliEE SET Atuals = .F.
                    UPDATE crCursorCliEE SET Atuals = .T. WHERE Codigos = THIS.this_nCodigos
                ENDIF
                THIS.this_nCodigos = 0
            ENDIF

            *-- Limpar e repopular crGrade a partir de crCursorCliEE
            ZAP IN crGrade
            IF USED("crCursorCliEE")
                SELECT crCursorCliEE
                SCAN
                    INSERT INTO crGrade (Atuals, Descrs, Codigos) ;
                        VALUES (crCursorCliEE.Atuals, crCursorCliEE.Descrs, crCursorCliEE.Codigos)
                    IF !loc_llMar AND crCursorCliEE.Atuals
                        loc_llMar = .T.
                    ENDIF
                ENDSCAN
            ENDIF

            *-- Verificar se grade esta vazia
            SELECT crGrade
            GO TOP

            IF EOF("crGrade")
                IF THIS.this_cModo = "CONSULTAR"
                    THIS.HabilitarCampos(.F.)
                ELSE
                    *-- Modo edicao sem registros: criar linha em branco automaticamente
                    loc_lnCod = THIS.this_oBusinessObject.GerarCodigoUnico()
                    INSERT INTO crCursorCliEE (IClis, Codigos, Atuals) ;
                        VALUES (THIS.this_cIClis, loc_lnCod, .T.)
                    INSERT INTO crGrade (Atuals, Descrs, Codigos) VALUES (.T., "", loc_lnCod)
                    GO TOP IN crCursorCliEE
                    GO TOP IN crGrade
                    THIS.this_cModo           = "INSERIR"
                    THIS.this_lEntraInserindo = .T.
                    THIS.HabilitarCampos(.T.)
                ENDIF
            ELSE
                IF THIS.this_cModo <> "INSERIR"
                    THIS.this_cModo = "CONSULTAR"
                    THIS.HabilitarCampos(.F.)
                ENDIF
            ENDIF

            *-- Se nenhum marcado, marcar o primeiro
            IF !loc_llMar AND !EOF("crGrade") AND THIS.this_cModo <> "CONSULTAR"
                REPLACE Atuals WITH .T. IN crGrade
                IF USED("crCursorCliEE")
                    UPDATE crCursorCliEE SET Atuals = .T. WHERE Descrs = crGrade.Descrs
                ENDIF
            ENDIF

            *-- Posicionar no registro correto
            SELECT crGrade
            GO TOP
            IF par_lPosChk
                LOCATE FOR Atuals
            ELSE
                LOCATE FOR RTRIM(Descrs) = ALLTRIM(loc_lcDes)
            ENDIF

            *-- Sincronizar crCursorCliEE com linha corrente do grid
            IF USED("crCursorCliEE") AND !EOF("crGrade")
                SELECT crCursorCliEE
                GO TOP
                LOCATE FOR Codigos = crGrade.Codigos
            ENDIF

            THIS.Refresh()
            THIS.grd_4c_Locais.Refresh()

            IF !EOF("crGrade")
                IF PEMSTATUS(THIS, "grd_4c_Locais", 5)
                    THIS.grd_4c_Locais.Column2.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormEnd.AtualizaTela")
        ENDTRY
    ENDPROC

    *==================================================================
    * HabilitarCampos - Habilita ou desabilita todos os campos e botoes
    *==================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        WITH THIS
            .txt_4c_Paises.Enabled    = par_lHabilitar
            .txt_4c_Ceps.Enabled      = par_lHabilitar
            .txt_4c_Endes.Enabled     = par_lHabilitar
            .txt_4c_Nums.Enabled      = par_lHabilitar
            .txt_4c_Compls.Enabled    = par_lHabilitar
            .txt_4c_Bairs.Enabled     = par_lHabilitar
            .txt_4c_Cidas.Enabled     = par_lHabilitar
            .txt_4c_Estas.Enabled     = par_lHabilitar
            .txt_4c_Ddds.Enabled      = par_lHabilitar
            .txt_4c_Tel1s.Enabled     = par_lHabilitar
            .txt_4c_Tel2s.Enabled     = par_lHabilitar
            .txt_4c_Contatos.Enabled  = par_lHabilitar
            .edt_4c_Refers.Enabled    = par_lHabilitar

            .cnt_4c_Salva.btn_4c_Salvar.Enabled   = par_lHabilitar
            .cnt_4c_Salva.btn_4c_Cancelar.Enabled = par_lHabilitar

            IF RECCOUNT("crCursorCliEE") > 0 AND THIS.this_cModo <> "INSERIR"
                .cnt_4c_Salva.btn_4c_Encerrar.Enabled = !par_lHabilitar
            ELSE
                .cnt_4c_Salva.btn_4c_Encerrar.Enabled = .T.
            ENDIF

            .cnt_4c_Escolha.btn_4c_Inserir.Enabled = !par_lHabilitar
            .cnt_4c_Escolha.btn_4c_Alterar.Enabled = !par_lHabilitar
            .cnt_4c_Escolha.btn_4c_Excluir.Enabled = !par_lHabilitar

            IF THIS.this_lEntraInserindo
                .cnt_4c_Escolha.btn_4c_Copiar.Enabled = .T.
            ELSE
                .cnt_4c_Escolha.btn_4c_Copiar.Enabled = !par_lHabilitar
            ENDIF

            .txt_4c_Paises.Refresh()
            .txt_4c_Ceps.Refresh()
            .txt_4c_Endes.Refresh()
            .txt_4c_Nums.Refresh()
            .txt_4c_Compls.Refresh()
            .txt_4c_Bairs.Refresh()
            .txt_4c_Cidas.Refresh()
            .txt_4c_Estas.Refresh()
            .txt_4c_Ddds.Refresh()
            .txt_4c_Tel1s.Refresh()
            .txt_4c_Tel2s.Refresh()
            .txt_4c_Contatos.Refresh()
            .edt_4c_Refers.Refresh()
            .cnt_4c_Salva.btn_4c_Salvar.Refresh()
            .cnt_4c_Salva.btn_4c_Cancelar.Refresh()
            .cnt_4c_Salva.btn_4c_Encerrar.Refresh()
            .cnt_4c_Escolha.btn_4c_Inserir.Refresh()
            .cnt_4c_Escolha.btn_4c_Alterar.Refresh()
            .cnt_4c_Escolha.btn_4c_Excluir.Refresh()
            .cnt_4c_Escolha.btn_4c_Copiar.Refresh()
        ENDWITH
    ENDPROC

    *==================================================================
    * AlternarAtual - Logica compartilhada para toggle do checkbox Atuals
    * Chamado por GrdChkClick, GrdChkKeyPress, GrdChkMouseDown
    *==================================================================
    PROTECTED PROCEDURE AlternarAtual()
        LOCAL loc_lAtuals, loc_lnCnt, loc_llMar
        TRY
            IF INLIST(THIS.this_cModo, "INSERIR", "ALTERAR") AND ;
                    USED("crGrade") AND !EOF("crGrade")
                loc_lAtuals = !crGrade.Atuals
                loc_lnCnt   = RECNO("crGrade")

                UPDATE crGrade SET Atuals = .F.
                GO loc_lnCnt IN crGrade
                REPLACE Atuals WITH loc_lAtuals IN crGrade
                THIS.grd_4c_Locais.Refresh()

                IF USED("crCursorCliEE")
                    LOCAL loc_lcDescGrd
                    loc_lcDescGrd = crGrade.Descrs
                    UPDATE crCursorCliEE SET Atuals = .F.
                    SELECT crCursorCliEE
                    GO TOP
                    LOCATE FOR RTRIM(Descrs) = RTRIM(loc_lcDescGrd)
                    IF !EOF("crCursorCliEE")
                        REPLACE Atuals WITH loc_lAtuals IN crCursorCliEE
                    ENDIF
                ENDIF

                *-- Se desmarcou e ficou sem nenhum marcado, marcar o primeiro
                IF !loc_lAtuals
                    loc_llMar = .F.
                    IF USED("crCursorCliEE")
                        SELECT crCursorCliEE
                        SCAN
                            IF crCursorCliEE.Atuals
                                loc_llMar = .T.
                            ENDIF
                        ENDSCAN
                    ENDIF

                    IF !loc_llMar AND USED("crCursorCliEE") AND RECCOUNT("crCursorCliEE") > 0
                        MsgAviso("Nenhum endere" + CHR(231) + "o marcado para entrega." + CHR(13) + ;
                            "O primeiro endere" + CHR(231) + "o dispon" + CHR(237) + ;
                            "vel ser" + CHR(225) + " marcado como atual.")
                        SELECT crGrade
                        GO TOP
                        REPLACE Atuals WITH .T.
                        IF USED("crCursorCliEE")
                            SELECT crCursorCliEE
                            GO TOP
                            LOCAL loc_lcDescFirst
                            loc_lcDescFirst = crGrade.Descrs
                            LOCATE FOR RTRIM(Descrs) = RTRIM(loc_lcDescFirst)
                            IF !EOF("crCursorCliEE")
                                REPLACE Atuals WITH .T. IN crCursorCliEE
                            ENDIF
                        ENDIF
                        SELECT crGrade
                        GO loc_lnCnt
                    ENDIF
                ENDIF

                THIS.grd_4c_Locais.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormEnd.AlternarAtual")
        ENDTRY
    ENDPROC

    *==================================================================
    * Handlers de botoes (PUBLIC para BINDEVENT)
    *==================================================================

    PROCEDURE BtnIncluirClick()
        LOCAL loc_lnCod
        loc_lnCod = 0
        TRY
            THIS.this_cModo           = "INSERIR"
            THIS.this_cTipoCep        = "1"
            THIS.this_lTipoPais       = .F.
            THIS.this_lEntraInserindo = .F.

            SELECT crGrade
            ZAP IN crGrade

            loc_lnCod = THIS.this_oBusinessObject.GerarCodigoUnico()
            INSERT INTO crGrade (Atuals, Codigos) VALUES (.F., loc_lnCod)
            INSERT INTO crCursorCliEE (IClis, Codigos, Atuals) ;
                VALUES (THIS.this_cIClis, loc_lnCod, .F.)

            GO BOTTOM IN crCursorCliEE

            THIS.HabilitarCampos(.T.)
            THIS.grd_4c_Locais.Column2.SetFocus()
            THIS.grd_4c_Locais.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormEnd.BtnIncluirClick")
        ENDTRY
    ENDPROC

    PROCEDURE BtnAlterarClick()
        TRY
            THIS.this_cModo     = "ALTERAR"
            THIS.this_cTipoCep  = "1"
            THIS.this_lTipoPais = .F.
            THIS.HabilitarCampos(.T.)
            THIS.grd_4c_Locais.Column2.SetFocus()
            THIS.grd_4c_Locais.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormEnd.BtnAlterarClick")
        ENDTRY
    ENDPROC

    PROCEDURE BtnVisualizarClick()
        TRY
            THIS.this_cModo     = "CONSULTAR"
            THIS.this_cTipoCep  = "1"
            THIS.this_lTipoPais = .F.
            THIS.HabilitarCampos(.F.)
            THIS.grd_4c_Locais.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormEnd.BtnVisualizarClick")
        ENDTRY
    ENDPROC

    PROCEDURE BtnExcluirClick()
        LOCAL loc_lcDescr, loc_llMar
        loc_lcDescr = ""
        loc_llMar   = .F.
        TRY
            IF USED("crGrade") AND !EOF("crGrade")
                loc_lcDescr = crGrade.Descrs
                THIS.this_cModo = "EXCLUIR"

                DELETE FROM crCursorCliEE WHERE RTRIM(Descrs) = RTRIM(loc_lcDescr)
                DELETE IN crGrade

                *-- Verificar se ficou sem nenhum marcado
                IF USED("crCursorCliEE")
                    SELECT crCursorCliEE
                    SCAN
                        IF crCursorCliEE.Atuals
                            loc_llMar = .T.
                        ENDIF
                    ENDSCAN
                ENDIF

                IF !loc_llMar AND USED("crCursorCliEE") AND RECCOUNT("crCursorCliEE") > 0
                    MsgAviso("Nenhum endere" + CHR(231) + "o marcado para entrega." + CHR(13) + ;
                        "O primeiro endere" + CHR(231) + "o dispon" + CHR(237) + ;
                        "vel ser" + CHR(225) + " marcado como atual.")
                    SELECT crGrade
                    GO TOP
                    REPLACE Atuals WITH .T.
                    IF USED("crCursorCliEE")
                        SELECT crCursorCliEE
                        GO TOP
                        LOCAL loc_lcDG
                        loc_lcDG = crGrade.Descrs
                        LOCATE FOR RTRIM(Descrs) = RTRIM(loc_lcDG)
                        IF !EOF("crCursorCliEE")
                            REPLACE Atuals WITH .T. IN crCursorCliEE
                        ENDIF
                    ENDIF
                ENDIF

                THIS.BtnSalvarClick()

                SELECT crGrade
                GO TOP
                THIS.Refresh()
                THIS.grd_4c_Locais.Column2.SetFocus()
                THIS.grd_4c_Locais.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormEnd.BtnExcluirClick")
        ENDTRY
    ENDPROC

    PROCEDURE BtnCopiarClick()
        LOCAL loc_lSucesso, loc_lnCod
        loc_lSucesso = .F.
        loc_lnCod    = 0
        TRY
            *-- Somente se "PRINCIPAL" ainda nao existe na grade
            SELECT crGrade
            LOCATE FOR RTRIM(Descrs) = "PRINCIPAL"
            IF EOF("crGrade")
                loc_lSucesso = THIS.this_oBusinessObject.ObterEnderecoPrincipal(ALLTRIM(THIS.this_cIClis))

                IF loc_lSucesso AND USED("cursor_4c_EndPrincipal") AND ;
                        !EOF("cursor_4c_EndPrincipal")
                    IF !EMPTY(ALLTRIM(cursor_4c_EndPrincipal.Endes))
                        loc_lnCod = THIS.this_oBusinessObject.GerarCodigoUnico()

                        UPDATE crCursorCliEE SET Atuals = .F.
                        UPDATE crGrade SET Atuals = .F.

                        SELECT crGrade
                        LOCATE FOR EMPTY(RTRIM(Descrs))
                        IF EOF("crGrade")
                            INSERT INTO crGrade (Atuals, Descrs, Codigos) ;
                                VALUES (.T., "PRINCIPAL", loc_lnCod)
                        ELSE
                            REPLACE Atuals WITH .T., Descrs WITH "PRINCIPAL", ;
                                Codigos WITH loc_lnCod IN crGrade
                        ENDIF

                        INSERT INTO crCursorCliEE ;
                            (IClis, Codigos, Atuals, Descrs, Ceps, Paises, Endes, Nums, ;
                             Compls, Bairs, Cidas, Estas, Ddds, Tel1s, Tel2s, Contatos) ;
                            VALUES (THIS.this_cIClis, loc_lnCod, .T., "PRINCIPAL", ;
                                cursor_4c_EndPrincipal.Ceps,  cursor_4c_EndPrincipal.Paises, ;
                                cursor_4c_EndPrincipal.Endes, cursor_4c_EndPrincipal.Nums, ;
                                cursor_4c_EndPrincipal.Compls, cursor_4c_EndPrincipal.Bairs, ;
                                cursor_4c_EndPrincipal.Cidas,  cursor_4c_EndPrincipal.Estas, ;
                                cursor_4c_EndPrincipal.Ddds,   cursor_4c_EndPrincipal.Tel1s, ;
                                cursor_4c_EndPrincipal.Tel2s,  cursor_4c_EndPrincipal.Contato)

                        THIS.grd_4c_Locais.Refresh()
                        THIS.this_cModo = "INSERIR"
                        THIS.BtnSalvarClick()
                    ENDIF

                    IF USED("cursor_4c_EndPrincipal")
                        USE IN cursor_4c_EndPrincipal
                    ENDIF
                ENDIF
            ENDIF

            SELECT crGrade
            THIS.Refresh()
            THIS.grd_4c_Locais.Column2.SetFocus()
            THIS.grd_4c_Locais.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormEnd.BtnCopiarClick")
        ENDTRY
    ENDPROC

    PROCEDURE BtnSalvarClick()
        LOCAL loc_lcDescr, loc_lcCep, loc_lcEnd, loc_lcBai, loc_lnCod
        LOCAL loc_lcContas, loc_llOk
        loc_lcDescr  = ""
        loc_lcCep    = ""
        loc_lcEnd    = ""
        loc_lcBai    = ""
        loc_lnCod    = 0
        loc_lcContas = ""
        loc_llOk     = .F.

        TRY
            IF USED("crGrade") AND !EOF("crGrade")
                loc_lcDescr = ALLTRIM(crGrade.Descrs)
            ENDIF
            IF USED("crCursorCliEE") AND !EOF("crCursorCliEE")
                loc_lcCep = ALLTRIM(crCursorCliEE.Ceps)
                loc_lcEnd = ALLTRIM(crCursorCliEE.Endes)
                loc_lcBai = ALLTRIM(crCursorCliEE.Bairs)
                loc_lnCod = NVL(crCursorCliEE.Codigos, 0)
            ENDIF

            *-- Em INSERIR: verificar duplicidade de descricao
            IF THIS.this_cModo = "INSERIR"
                THIS.this_lEntraInserindo = .F.

                IF THIS.this_oBusinessObject.VerificarDuplicidade(;
                        ALLTRIM(THIS.this_cIClis), loc_lcDescr, loc_lnCod)
                    IF USED("crCursorCliEE") AND !EOF("crCursorCliEE")
                        REPLACE Descrs WITH SPACE(50) IN crCursorCliEE
                    ENDIF
                    IF USED("crGrade") AND !EOF("crGrade")
                        REPLACE Descrs WITH SPACE(50) IN crGrade
                    ENDIF
                    MsgAviso("Descri" + CHR(231) + CHR(227) + "o [" + loc_lcDescr + ;
                        "] j" + CHR(225) + " existe.")
                ELSE
                    loc_llOk = .T.
                ENDIF
            ELSE
                loc_llOk = .T.
            ENDIF

            *-- Verificar endereco duplicado (chkendds=1) em INSERIR/ALTERAR
            IF loc_llOk AND INLIST(THIS.this_cModo, "INSERIR", "ALTERAR")
                IF THIS.this_nChkEndDs = 1
                    loc_lcContas = THIS.this_oBusinessObject.VerificarEnderecoDuplicado(;
                        ALLTRIM(THIS.this_cIClis), loc_lcCep, loc_lcEnd, loc_lcBai, loc_lnCod)
                    IF !EMPTY(ALLTRIM(loc_lcContas))
                        MsgAviso("Endere" + CHR(231) + "o duplicado. Contas: " + loc_lcContas)
                        loc_llOk = .F.
                    ENDIF
                ENDIF
            ENDIF

            IF loc_llOk
                *-- Sincronizar Descrs de crGrade para crCursorCliEE
                IF USED("crCursorCliEE") AND USED("crGrade") AND !EOF("crGrade")
                    SELECT crCursorCliEE
                    LOCATE FOR Codigos = crGrade.Codigos
                    IF !EOF("crCursorCliEE")
                        REPLACE Descrs WITH loc_lcDescr IN crCursorCliEE
                    ENDIF
                ENDIF

                *-- Limpar registros com Descrs vazio de crCursorCliEE
                IF USED("crCursorCliEE")
                    SELECT crCursorCliEE
                    SCAN
                        IF EMPTY(RTRIM(crCursorCliEE.Descrs))
                            DELETE IN crCursorCliEE
                        ELSE
                            IF THIS.this_cModo = "INSERIR"
                                REPLACE Atuals WITH .F. IN crCursorCliEE
                            ENDIF
                        ENDIF
                    ENDSCAN

                    IF THIS.this_cModo = "INSERIR"
                        UPDATE crCursorCliEE SET Atuals = .T. WHERE RTRIM(Descrs) = loc_lcDescr
                    ENDIF
                ENDIF

                *-- Salvar no SQL Server via BO
                THIS.this_oBusinessObject.SalvarEnderecos(ALLTRIM(THIS.this_cIClis))

                THIS.AtualizaTela(.F.)

                IF USED("crGrade")
                    SELECT crGrade
                    GO TOP
                    LOCATE FOR RTRIM(Descrs) = loc_lcDescr
                ENDIF

                THIS.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormEnd.BtnSalvarClick")
        ENDTRY
    ENDPROC

    PROCEDURE BtnCancelarClick()
        LOCAL loc_lcDes
        loc_lcDes = ""
        TRY
            IF USED("crGrade") AND !EOF("crGrade")
                loc_lcDes = ALLTRIM(crGrade.Descrs)
            ENDIF
            THIS.this_lEntraInserindo = .F.
            THIS.AtualizaTela(.F.)
            IF USED("crGrade")
                SELECT crGrade
                GO TOP
                LOCATE FOR RTRIM(Descrs) = loc_lcDes
            ENDIF
            THIS.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormEnd.BtnCancelarClick")
        ENDTRY
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==================================================================
    * Handlers do Grid (PUBLIC para BINDEVENT)
    *==================================================================

    PROCEDURE GrdLocaisAfterRowColChange(par_nColIndex)
        TRY
            IF USED("crCursorCliEE") AND USED("crGrade") AND !EOF("crGrade")
                SELECT crCursorCliEE
                GO TOP
                LOCATE FOR Codigos = crGrade.Codigos

                WITH THIS
                    .txt_4c_Paises.Refresh()
                    .txt_4c_Ceps.Refresh()
                    .txt_4c_Endes.Refresh()
                    .txt_4c_Nums.Refresh()
                    .txt_4c_Compls.Refresh()
                    .txt_4c_Bairs.Refresh()
                    .txt_4c_Cidas.Refresh()
                    .txt_4c_Estas.Refresh()
                    .txt_4c_Ddds.Refresh()
                    .txt_4c_Tel1s.Refresh()
                    .txt_4c_Tel2s.Refresh()
                    .txt_4c_Contatos.Refresh()
                    .edt_4c_Refers.Refresh()
                ENDWITH
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormEnd.GrdLocaisAfterRowColChange")
        ENDTRY
    ENDPROC

    PROCEDURE GrdChkClick()
        NODEFAULT
        THIS.AlternarAtual()
    ENDPROC

    PROCEDURE GrdChkKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32)
            THIS.AlternarAtual()
            NODEFAULT
        ENDIF
    ENDPROC

    PROCEDURE GrdChkMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        NODEFAULT
        THIS.AlternarAtual()
    ENDPROC

    PROCEDURE GrdChkMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        NODEFAULT
    ENDPROC

    PROCEDURE GrdChkLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        IF PEMSTATUS(THIS, "grd_4c_Locais", 5)
            THIS.grd_4c_Locais.Column2.SetFocus()
        ENDIF
    ENDPROC

    PROCEDURE GrdChkWhen()
        RETURN INLIST(THIS.this_cModo, "INSERIR", "ALTERAR")
    ENDPROC

    PROCEDURE GrdDescrsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        TRY
            IF INLIST(THIS.this_cModo, "INSERIR", "ALTERAR") AND ;
                    USED("crGrade") AND !EOF("crGrade") AND ;
                    !EMPTY(ALLTRIM(crGrade.Descrs))
                *-- Incorpora logica do Valid original (BINDEVENT "Valid" nao funciona em TextBox)
                THIS.HabilitarCampos(.T.)
                THIS.txt_4c_Paises.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormEnd.GrdDescrsLostFocus")
        ENDTRY
    ENDPROC

    PROCEDURE GrdDescrsWhen()
        RETURN (THIS.this_cModo = "INSERIR")
    ENDPROC

    *==================================================================
    * Handlers de campos de endereco (PUBLIC para BINDEVENT)
    *==================================================================

    PROCEDURE TxtCepsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_lcCep
        loc_lcCep = ""
        TRY
            IF USED("crCursorCliEE") AND !EOF("crCursorCliEE")
                loc_lcCep = ALLTRIM(crCursorCliEE.Ceps)
            ENDIF

            *-- Default pais para BRASIL se CEP preenchido e pais vazio
            IF !EMPTY(STRTRAN(loc_lcCep, "-", "")) AND !THIS.this_lTipoPais
                IF USED("crCursorCliEE") AND !EOF("crCursorCliEE")
                    IF EMPTY(ALLTRIM(crCursorCliEE.Paises))
                        REPLACE Paises WITH "BRASIL" IN crCursorCliEE
                        THIS.txt_4c_Paises.Refresh()
                    ENDIF
                ENDIF
            ENDIF

            *-- Verificar CEP restrito (quando chkendrs=1)
            IF !EMPTY(STRTRAN(loc_lcCep, "-", "")) AND THIS.this_nChkEndRs = 1
                IF THIS.this_oBusinessObject.VerificarCepRestrito(loc_lcCep)
                    MsgAviso("CEP Restrito.")
                    IF USED("crCursorCliEE") AND !EOF("crCursorCliEE")
                        REPLACE Ceps    WITH "" IN crCursorCliEE
                        REPLACE Endes   WITH "" IN crCursorCliEE
                        REPLACE Nums    WITH "" IN crCursorCliEE
                        REPLACE Compls  WITH "" IN crCursorCliEE
                        REPLACE Paises  WITH "" IN crCursorCliEE
                        REPLACE Bairs   WITH "" IN crCursorCliEE
                        REPLACE Cidas   WITH "" IN crCursorCliEE
                        REPLACE Estas   WITH "" IN crCursorCliEE
                    ENDIF
                    THIS.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormEnd.TxtCepsLostFocus")
        ENDTRY
    ENDPROC

    PROCEDURE TxtBairsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_lcBairro
        loc_lcBairro = ""
        TRY
            IF USED("crCursorCliEE") AND !EOF("crCursorCliEE")
                loc_lcBairro = ALLTRIM(crCursorCliEE.Bairs)
            ENDIF
            IF !EMPTY(loc_lcBairro) AND THIS.this_nChkEndRs = 1
                IF THIS.this_oBusinessObject.VerificarBairroRestrito(loc_lcBairro)
                    MsgAviso("Bairro Restrito.")
                    IF USED("crCursorCliEE") AND !EOF("crCursorCliEE")
                        REPLACE Ceps    WITH "" IN crCursorCliEE
                        REPLACE Endes   WITH "" IN crCursorCliEE
                        REPLACE Nums    WITH "" IN crCursorCliEE
                        REPLACE Compls  WITH "" IN crCursorCliEE
                        REPLACE Paises  WITH "" IN crCursorCliEE
                        REPLACE Bairs   WITH "" IN crCursorCliEE
                        REPLACE Cidas   WITH "" IN crCursorCliEE
                        REPLACE Estas   WITH "" IN crCursorCliEE
                    ENDIF
                    THIS.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormEnd.TxtBairsLostFocus")
        ENDTRY
    ENDPROC

    PROCEDURE TxtEndesLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_lcEnde
        loc_lcEnde = ""
        TRY
            IF USED("crCursorCliEE") AND !EOF("crCursorCliEE")
                loc_lcEnde = ALLTRIM(crCursorCliEE.Endes)
            ENDIF
            IF !EMPTY(loc_lcEnde) AND THIS.this_nChkEndRs = 1
                IF THIS.this_oBusinessObject.VerificarEnderecoRestrito(loc_lcEnde)
                    MsgAviso("Endere" + CHR(231) + "o Restrito.")
                    IF USED("crCursorCliEE") AND !EOF("crCursorCliEE")
                        REPLACE Ceps    WITH "" IN crCursorCliEE
                        REPLACE Endes   WITH "" IN crCursorCliEE
                        REPLACE Nums    WITH "" IN crCursorCliEE
                        REPLACE Compls  WITH "" IN crCursorCliEE
                        REPLACE Paises  WITH "" IN crCursorCliEE
                        REPLACE Bairs   WITH "" IN crCursorCliEE
                        REPLACE Cidas   WITH "" IN crCursorCliEE
                        REPLACE Estas   WITH "" IN crCursorCliEE
                    ENDIF
                    THIS.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormEnd.TxtEndesLostFocus")
        ENDTRY
    ENDPROC

    PROCEDURE TxtEstasValid()
        LOCAL loc_lcEstado, loc_lResultado, loc_oFrm
        loc_lcEstado   = ""
        loc_lResultado = .T.
        TRY
            loc_lcEstado = ALLTRIM(THIS.txt_4c_Estas.Value)
            IF !EMPTY(loc_lcEstado)
                IF THIS.this_oBusinessObject.ListarEstados(loc_lcEstado)
                    SELECT cursor_4c_ListaEstados
                    GO TOP
                    IF EOF("cursor_4c_ListaEstados")
                        *-- Nao encontrou exato: abrir picker de UFs
                        IF USED("cursor_4c_ListaEstados")
                            USE IN cursor_4c_ListaEstados
                        ENDIF
                        THIS.this_oBusinessObject.ListarEstados("")
                        loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                            "SigCdUfs", "cursor_4c_BuscaUfs", "Estados", loc_lcEstado, ;
                            "Sele" + CHR(231) + CHR(227) + "o de Estado", .T.)
                        IF VARTYPE(loc_oFrm) = "O"
                            IF !loc_oFrm.this_lAchouRegistro
                                loc_oFrm.mAddColuna("Estados", "", "UF")
                                loc_oFrm.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                                loc_oFrm.Show()
                            ENDIF
                            IF loc_oFrm.this_lSelecionou AND USED("cursor_4c_BuscaUfs")
                                SELECT cursor_4c_BuscaUfs
                                THIS.txt_4c_Estas.Value = ALLTRIM(cursor_4c_BuscaUfs.Estados)
                                IF USED("crCursorCliEE") AND !EOF("crCursorCliEE")
                                    REPLACE Estas WITH ALLTRIM(cursor_4c_BuscaUfs.Estados) IN crCursorCliEE
                                ENDIF
                            ELSE
                                THIS.txt_4c_Estas.Value = ""
                            ENDIF
                            IF USED("cursor_4c_BuscaUfs")
                                USE IN cursor_4c_BuscaUfs
                            ENDIF
                            IF USED("cursor_4c_ListaEstados")
                                USE IN cursor_4c_ListaEstados
                            ENDIF
                        ENDIF
                    ELSE
                        *-- Encontrou: usar o UF exato retornado
                        THIS.txt_4c_Estas.Value = ALLTRIM(cursor_4c_ListaEstados.Estados)
                        IF USED("crCursorCliEE") AND !EOF("crCursorCliEE")
                            REPLACE Estas WITH ALLTRIM(cursor_4c_ListaEstados.Estados) IN crCursorCliEE
                        ENDIF
                        IF USED("cursor_4c_ListaEstados")
                            USE IN cursor_4c_ListaEstados
                        ENDIF
                    ENDIF
                ELSE
                    THIS.txt_4c_Estas.Value = ""
                ENDIF
            ELSE
                THIS.txt_4c_Estas.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormEnd.TxtEstasValid")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    PROCEDURE TxtPaisesGotFocus()
        TRY
            IF USED("crCursorCliEE") AND !EOF("crCursorCliEE")
                IF EMPTY(ALLTRIM(crCursorCliEE.Paises))
                    REPLACE Paises WITH "BRASIL" IN crCursorCliEE
                    THIS.txt_4c_Paises.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormEnd.TxtPaisesGotFocus")
        ENDTRY
    ENDPROC

    PROCEDURE TxtPaisesLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        TRY
            IF USED("crCursorCliEE") AND !EOF("crCursorCliEE")
                IF ALLTRIM(crCursorCliEE.Paises) = "BRASIL"
                    THIS.this_lTipoPais = .F.
                ELSE
                    THIS.this_lTipoPais = .T.
                    REPLACE Estas WITH "EX" IN crCursorCliEE
                    THIS.txt_4c_Estas.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormEnd.TxtPaisesLostFocus")
        ENDTRY
    ENDPROC

    *==================================================================
    * Stubs de API de compatibilidade com FormBase (OPERACIONAL flat)
    * Este form nao usa PageFrame - layout plano com controles diretos.
    * ConfigurarGrid() e ConfigurarCommandGroups() fazem o papel de
    * ConfigurarPaginaLista() para este form OPERACIONAL.
    *==================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        RETURN
    ENDPROC

    PROTECTED PROCEDURE ConfigurarPaginaLista()
        RETURN
    ENDPROC

    PROTECTED PROCEDURE ConfigurarPaginaDados()
        THIS.ConfigurarCampos()
        THIS.ConfigurarLabels()
    ENDPROC

    *==================================================================
    * AlternarPagina - Stub (form OPERACIONAL nao tem PageFrame/abas)
    * Mantido para compatibilidade com eventuais chamadas do FormBase.
    *==================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        RETURN
    ENDPROC

    *==================================================================
    * Destroy - Sincroniza crSigCdCeE (se aberto pelo chamador),
    *           libera cursores e chama DODEFAULT (FormBase.Destroy)
    *==================================================================
    PROCEDURE Destroy()
        TRY
            *-- Sincronizar crCursorCliEE -> crSigCdCeE se o chamador
            *-- (ex: FormCliente) tiver o cursor compartilhado aberto.
            *-- Replica o comportamento do Release legado do SCX.
            IF USED("crCursorCliEE") AND USED("crSigCdCeE")
                LOCAL loc_iclis, loc_codigos, loc_atuals, loc_descrs
                LOCAL loc_ceps, loc_paises, loc_endes, loc_nums
                LOCAL loc_compls, loc_bairs, loc_cidas, loc_estas
                LOCAL loc_ddds, loc_tel1s, loc_tel2s, loc_contatos, loc_refers

                SELECT crCursorCliEE
                GO TOP
                SCAN
                    SCATTER MEMO MEMVAR
                    IF !EMPTY(m.codigos) AND !EMPTY(ALLTRIM(m.iclis))
                        SELECT crSigCdCeE
                        GO TOP
                        LOCATE FOR codigos == m.codigos
                        IF EOF("crSigCdCeE")
                            INSERT INTO crSigCdCeE FROM MEMVAR
                        ELSE
                            GATHER MEMO MEMVAR
                        ENDIF
                    ENDIF
                ENDSCAN

                *-- Remover registros com descricao vazia que possam ter ficado
                SELECT crSigCdCeE
                DELETE FROM crSigCdCeE WHERE EMPTY(RTRIM(Descrs))
            ENDIF

            IF USED("crGrade")
                USE IN crGrade
            ENDIF
            IF USED("crCursorCliEE")
                USE IN crCursorCliEE
            ENDIF
            IF USED("cursor_4c_EndPrincipal")
                USE IN cursor_4c_EndPrincipal
            ENDIF
            IF USED("cursor_4c_ListaEstados")
                USE IN cursor_4c_ListaEstados
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormEnd.Destroy")
        ENDTRY
        DODEFAULT()
    ENDPROC

    PROCEDURE TxtEstasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.TxtEstasValid()
    ENDPROC

    PROCEDURE TxtEstasDblClick()
        THIS.TxtEstasValid()
    ENDPROC

    PROCEDURE TxtCidasLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        TRY
            IF USED("crCursorCliEE") AND !EOF("crCursorCliEE")
                IF !EMPTY(ALLTRIM(crCursorCliEE.Cidas))
                    REPLACE Cidas WITH UPPER(ALLTRIM(crCursorCliEE.Cidas)) IN crCursorCliEE
                    THIS.txt_4c_Cidas.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormEnd.TxtCidasLostFocus")
        ENDTRY
    ENDPROC

    *==================================================================
    * LimparCampos - Limpa todos os campos de endereco do registro corrente
    *==================================================================
    PROCEDURE LimparCampos()
        TRY
            IF USED("crCursorCliEE") AND !EOF("crCursorCliEE")
                REPLACE Ceps     WITH "" IN crCursorCliEE
                REPLACE Paises   WITH "" IN crCursorCliEE
                REPLACE Endes    WITH "" IN crCursorCliEE
                REPLACE Nums     WITH "" IN crCursorCliEE
                REPLACE Compls   WITH "" IN crCursorCliEE
                REPLACE Bairs    WITH "" IN crCursorCliEE
                REPLACE Cidas    WITH "" IN crCursorCliEE
                REPLACE Estas    WITH "" IN crCursorCliEE
                REPLACE Ddds     WITH "" IN crCursorCliEE
                REPLACE Tel1s    WITH "" IN crCursorCliEE
                REPLACE Tel2s    WITH "" IN crCursorCliEE
                REPLACE Contatos WITH "" IN crCursorCliEE
                REPLACE Refers   WITH "" IN crCursorCliEE
                THIS.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormEnd.LimparCampos")
        ENDTRY
    ENDPROC

    *==================================================================
    * CarregarLista - Recarga a grade (wrapper de AtualizaTela para
    *   compatibilidade com interface de FormBase)
    *==================================================================
    PROCEDURE CarregarLista()
        THIS.AtualizaTela(.T.)
    ENDPROC

    *==================================================================
    * FormParaBO - Copia dados do registro corrente de crCursorCliEE
    *   (que esta bindado nos TextBoxes via ControlSource) para as
    *   propriedades do BusinessObject. Como todos os controles usam
    *   ControlSource = "crCursorCliEE.<campo>", os valores digitados
    *   pelo usuario ja estao no cursor. Este metodo apenas sincroniza
    *   BO <- cursor para chamadas de validacao/persistencia via BO.
    *==================================================================
    PROCEDURE FormParaBO()
        TRY
            IF ISNULL(THIS.this_oBusinessObject)
                RETURN
            ENDIF

            IF !USED("crCursorCliEE") OR EOF("crCursorCliEE")
                RETURN
            ENDIF

            WITH THIS.this_oBusinessObject
                .this_cIClis     = ALLTRIM(NVL(crCursorCliEE.IClis, ""))
                .this_nCodigos   = NVL(crCursorCliEE.Codigos, 0)
                .this_lAtuals    = NVL(crCursorCliEE.Atuals, .F.)
                .this_cDescrs    = ALLTRIM(NVL(crCursorCliEE.Descrs, ""))
                .this_cCeps      = ALLTRIM(NVL(crCursorCliEE.Ceps, ""))
                .this_cPaises    = ALLTRIM(NVL(crCursorCliEE.Paises, ""))
                .this_cEndes     = ALLTRIM(NVL(crCursorCliEE.Endes, ""))
                .this_cNums      = ALLTRIM(NVL(crCursorCliEE.Nums, ""))
                .this_cCompls    = ALLTRIM(NVL(crCursorCliEE.Compls, ""))
                .this_cBairs     = ALLTRIM(NVL(crCursorCliEE.Bairs, ""))
                .this_cCidas     = ALLTRIM(NVL(crCursorCliEE.Cidas, ""))
                .this_cEstas     = ALLTRIM(NVL(crCursorCliEE.Estas, ""))
                .this_cDdds      = ALLTRIM(NVL(crCursorCliEE.Ddds, ""))
                .this_cTel1s     = ALLTRIM(NVL(crCursorCliEE.Tel1s, ""))
                .this_cTel2s     = ALLTRIM(NVL(crCursorCliEE.Tel2s, ""))
                .this_cContatos  = ALLTRIM(NVL(crCursorCliEE.Contatos, ""))
                .this_cRefers    = NVL(crCursorCliEE.Refers, "")
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormEnd.FormParaBO")
        ENDTRY
    ENDPROC

    *==================================================================
    * BOParaForm - Grava as propriedades do BusinessObject no registro
    *   corrente de crCursorCliEE e da Refresh nos TextBoxes bindados
    *   via ControlSource. Usado quando o BO altera valores (ex: em
    *   VerificarCepRestrito, CarregarConfigGrupo, etc.).
    *==================================================================
    PROCEDURE BOParaForm()
        TRY
            IF ISNULL(THIS.this_oBusinessObject)
                RETURN
            ENDIF

            IF !USED("crCursorCliEE") OR EOF("crCursorCliEE")
                RETURN
            ENDIF

            WITH THIS.this_oBusinessObject
                REPLACE Atuals   WITH .this_lAtuals   IN crCursorCliEE
                REPLACE Descrs   WITH .this_cDescrs   IN crCursorCliEE
                REPLACE Ceps     WITH .this_cCeps     IN crCursorCliEE
                REPLACE Paises   WITH .this_cPaises   IN crCursorCliEE
                REPLACE Endes    WITH .this_cEndes    IN crCursorCliEE
                REPLACE Nums     WITH .this_cNums     IN crCursorCliEE
                REPLACE Compls   WITH .this_cCompls   IN crCursorCliEE
                REPLACE Bairs    WITH .this_cBairs    IN crCursorCliEE
                REPLACE Cidas    WITH .this_cCidas    IN crCursorCliEE
                REPLACE Estas    WITH .this_cEstas    IN crCursorCliEE
                REPLACE Ddds     WITH .this_cDdds     IN crCursorCliEE
                REPLACE Tel1s    WITH .this_cTel1s    IN crCursorCliEE
                REPLACE Tel2s    WITH .this_cTel2s    IN crCursorCliEE
                REPLACE Contatos WITH .this_cContatos IN crCursorCliEE
                REPLACE Refers   WITH .this_cRefers   IN crCursorCliEE
            ENDWITH

            WITH THIS
                .txt_4c_Paises.Refresh()
                .txt_4c_Ceps.Refresh()
                .txt_4c_Endes.Refresh()
                .txt_4c_Nums.Refresh()
                .txt_4c_Compls.Refresh()
                .txt_4c_Bairs.Refresh()
                .txt_4c_Cidas.Refresh()
                .txt_4c_Estas.Refresh()
                .txt_4c_Ddds.Refresh()
                .txt_4c_Tel1s.Refresh()
                .txt_4c_Tel2s.Refresh()
                .txt_4c_Contatos.Refresh()
                .edt_4c_Refers.Refresh()
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormEnd.BOParaForm")
        ENDTRY
    ENDPROC

    *==================================================================
    * AjustarBotoesPorModo - Wrapper canonico para AjustarBotoes()
    *   Segue naming convention de forms CRUD (FormBase interface).
    *==================================================================
    PROCEDURE AjustarBotoesPorModo()
        THIS.AjustarBotoes()
    ENDPROC

ENDDEFINE
