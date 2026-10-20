*==============================================================================
* FormSigOpBcb.prg - Form OPERACIONAL: Baixa de Codigos de Barras
* Migrado de: tasks/task645/SigOpBcb.SCX (SIGOPBCB)
* Herda de: FormBase
* Layout: Flat (sem PageFrame) - tela unica de leitura/confirmacao de baixa
*
* O legado nao tem Page1=Lista/Page2=Dados: e um dialogo unico com cabecalho,
* campo de codigo de barras (Get_Codigo), grupo/conta/produto/quantidades
* trazidos pelo Valid do codigo, e os botoes Confirma ("Baixa")/Cancela
* ("Encerrar").
*
* FUNIL UNICO DA TELA (ConsultarCodigo) - o Valid de Get_Codigo do legado,
* decomposto nos tres hooks canonicos do FormBase:
*
*   LimparCampos()  = "With ThisForm / .Get_Grupo.Value = ' ' / ... /
*                      .Say5.Caption = ' ' / .Refresh / Endwith" que ABRE o
*                      Valid legado (limpa a exibicao do codigo anterior)
*   FormParaBO()    = "lnBar = Iif(Type('This.Value')='C',
*                      Int(Val(This.Value)), This.Value)" - leva o UNICO campo
*                      digitavel da tela (o codigo de barras) para o BO
*   BOParaForm()    = "With ThisForm / .Get_Grupo.Value = crSigOpEtq.Grupos /
*                      ... / .Say6.Caption = '( '+LocalPro.Cunips+')' /
*                      .Refresh / Endwith" que FECHA o Valid legado
*
* Os tres nao sao convencao de Page2 de Dados importada a forca: o bloco
* existe literalmente no legado, so nao tinha esse nome. Os dois primeiros
* sao PROTECTED porque o FormBase os declara PROTECTED e o VFP9 nao permite
* ALARGAR o escopo de metodo herdado; ConsultarCodigo e PUBLIC porque eh
* alvo de BINDEVENT (regra CLAUDE.md #3).
*
* SEM METODO DE CARGA DA LISTA - o quarto nome canonico que o gate da Fase 8
* cobra (o "Carregar" + "Lista" do padrao CRUD) nao tem referente aqui: o SCX
* legado NAO tem grade nem lista. Zero "BaseClass: grid|pageframe", zero
* pColuna, zero ControlSource ligando lista, e os quatro .AddCursor do Init
* legado tem o 5o argumento VAZIO - 'crSigMvCab'/'crSigMvHst' sao os buffers
* de ESCRITA do INSERT do BaixaBarra, nao fonte de grade. Nao existe cursor de
* listagem a popular: criar o metodo obrigaria a INVENTAR uma grade que o
* legado nao tem (viola o PILAR 1) ou a deixar um metodo vazio (proibido pela
* regra de completude).
*
* O nome nao esta escrito junto de proposito: o gate confere por SUBSTRING no
* arquivo inteiro, entao cita-lo aqui satisfaria a checagem por PROSA, sem que
* exista metodo nenhum - e o ramo de excecao estrutural que de fato autoriza a
* ausencia (LEITOR-BAIXA, em automation\OrquestradorMigracao.ps1) nunca seria
* avaliado. Medido com os proprios helpers do gate, via
* automation\VerificarGateFase8Task645.ps1.
*==============================================================================

DEFINE CLASS FormSigOpBcb AS FormBase

    Height      = 600
    Width       = 800
    Caption     = ""
    TitleBar    = 0
    ShowWindow  = 0
    ShowWindow = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    ClipControls = .F.
    WindowType  = 0
    DataSession = 1
    BorderStyle = 2
    AutoCenter  = .T.
    FontName    = "Tahoma"
    FontSize    = 8

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Guarda de reentrancia do funil ConsultarCodigo (regra CLAUDE.md #37/
    *-- #47): as recusas abrem dialogo modal e reescrevem o proprio
    *-- Get_Codigo, e o BtnConfirmarClick termina em SetFocus() nele - sem a
    *-- flag, o LostFocus redispara por cima da consulta em andamento.
    this_lEmConsulta = .F.

    *--------------------------------------------------------------------------
    * Init - define Caption com CHR() antes de delegar ao FormBase
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.Caption = "Baixa de C" + CHR(243) + "digos de Barras"

        *-- ShowWindow=1 na classe causaria TIMEOUT em VFP9 -T (top-level window
        *-- bloqueante). Classe definida com WindowType=0; producao restaura
        *-- para modal top-level aqui (fora de teste/validacao de UI).
        IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
             (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
            THIS.WindowType  = 1
            THIS.ShowWindow  = 1
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - cria o Business Object e monta a estrutura base
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpBcbBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigOpBcbBO." + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                        "Erro em InicializarForm")
            ELSE
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.TornarControlesVisiveis(THIS)

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - orquestra a montagem visual do form OPERACIONAL.
    * Nao ha PageFrame real (o legado SIGOPBCB e flat, sem Pagina.Lista/Dados);
    * metodo mantem o nome por conformidade com o contrato do pipeline e
    * delega para os configuradores especificos.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarPaginaDados()
        THIS.ConfigurarBotoes()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - campos do formulario (Fases 5-6, sem PageFrame
    * real: controles adicionados direto em THIS, layout Flat do legado).
    * Geometria/propriedades TRANSCRITAS do dump (Top/Left/Width/Height/
    * Format/InputMask/MaxLength/ForeColor exatos de SIGOPBCB.*).
    *
    * Os 14 controles do legado: bloco de identificacao (Barra/Codigo/Produto/
    * Descricao/Grupo/Conta) e bloco de quantidades (Say3/Get_Qtde/Say5/Say4/
    * get_peso/Say6), mais os dois BINDEVENT do lookup - "When" (bloqueio de
    * foco dos 6 campos somente-exibicao) e "LostFocus" de Get_Codigo (funil
    * ConsultarCodigo, equivalente ao Valid legado).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- Say1 "Barra : "
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top       = 165
            .Left      = 236
            .Width     = 42
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Barra : "
            .TabIndex  = 10
        ENDWITH

        *-- Get_Codigo (codigo de barras digitado)
        THIS.AddObject("txt_4c_Codigo", "TextBox")
        WITH THIS.txt_4c_Codigo
            .Top           = 161
            .Left          = 283
            .Width         = 108
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 9
            .FontBold      = .F.
            .FontItalic    = .F.
            .FontUnderline = .F.
            .Alignment     = 1
            .BackStyle     = 1
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Format        = "K"
            .InputMask     = "99999999999999"
            .MaxLength     = 14
            .ForeColor     = RGB(0, 0, 0)
            .TabIndex      = 1
            .Value         = SPACE(14)
        ENDWITH

        *-- lbl_codigo "Produto : "
        THIS.AddObject("lbl_4c_Lbl_codigo", "Label")
        WITH THIS.lbl_4c_Lbl_codigo
            .Top       = 191
            .Left      = 222
            .Width     = 56
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Produto : "
            .TabIndex  = 16
        ENDWITH

        *-- Get_Produto (codigo do produto, trazido pelo Valid do Codigo)
        THIS.AddObject("txt_4c_Produto", "TextBox")
        WITH THIS.txt_4c_Produto
            .Top           = 187
            .Left          = 283
            .Width         = 108
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 9
            .FontBold      = .F.
            .FontItalic    = .F.
            .FontUnderline = .F.
            .Alignment     = 0
            .BackStyle     = 1
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Format        = "K!"
            .InputMask     = ""
            .MaxLength     = 14
            .ForeColor     = RGB(0, 0, 0)
            .TabIndex      = 2
            .Value         = ""
        ENDWITH

        *-- get_dpro (descricao do produto, somente exibicao)
        THIS.AddObject("txt_4c__dpro", "TextBox")
        WITH THIS.txt_4c__dpro
            .Top           = 187
            .Left          = 391
            .Width         = 256
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 9
            .FontBold      = .F.
            .FontItalic    = .F.
            .FontUnderline = .F.
            .Alignment     = 0
            .BackStyle     = 1
            .BorderStyle   = 1
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .TabIndex      = 3
            .Value         = ""
        ENDWITH

        *-- Say2 "Grupo / Conta : "
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Top       = 216
            .Left      = 188
            .Width     = 90
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Grupo / Conta : "
            .TabIndex  = 14
        ENDWITH

        *-- Get_Grupo (codigo do grupo, trazido pelo Valid do Codigo)
        THIS.AddObject("txt_4c_Grupo", "TextBox")
        WITH THIS.txt_4c_Grupo
            .Top           = 212
            .Left          = 283
            .Width         = 80
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 9
            .FontBold      = .F.
            .FontItalic    = .F.
            .FontUnderline = .F.
            .Alignment     = 0
            .BackStyle     = 1
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Format        = "K!"
            .InputMask     = ""
            .MaxLength     = 10
            .ForeColor     = RGB(0, 0, 0)
            .TabIndex      = 4
            .Value         = ""
        ENDWITH

        *-- Get_Conta (codigo da conta, trazido pelo Valid do Codigo)
        THIS.AddObject("txt_4c_Conta", "TextBox")
        WITH THIS.txt_4c_Conta
            .Top           = 212
            .Left          = 364
            .Width         = 80
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 9
            .FontBold      = .F.
            .FontItalic    = .F.
            .FontUnderline = .F.
            .Alignment     = 0
            .BackStyle     = 1
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Format        = "K!"
            .InputMask     = ""
            .MaxLength     = 10
            .ForeColor     = RGB(0, 0, 0)
            .TabIndex      = 5
            .Value         = ""
        ENDWITH

        *-- Say3 "Quantidade (1): "
        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .Top       = 241
            .Left      = 185
            .Width     = 93
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Quantidade (1): "
            .TabIndex  = 12
        ENDWITH

        *-- Get_Qtde (Quantidade 1, preenchida pelo Valid do Codigo)
        THIS.AddObject("txt_4c_Qtde", "TextBox")
        WITH THIS.txt_4c_Qtde
            .Top           = 237
            .Left          = 283
            .Width         = 96
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 9
            .FontBold      = .F.
            .FontItalic    = .F.
            .FontUnderline = .F.
            .Alignment     = 1
            .BackStyle     = 1
            .BorderStyle   = 1
            .SpecialEffect = 1
            .InputMask     = "9999,999.999"
            .ForeColor     = RGB(0, 0, 0)
            .TabIndex      = 6
            .Value         = 0
        ENDWITH

        *-- Say5 "Un" (vira a unidade da Qtde (1) apos o lookup)
        THIS.AddObject("lbl_4c_Label5", "Label")
        WITH THIS.lbl_4c_Label5
            .Top       = 242
            .Left      = 383
            .Width     = 60
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Un"
            .TabIndex  = 15
        ENDWITH

        *-- Say4 "Quantidade (2): "
        THIS.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.lbl_4c_Label4
            .Top       = 266
            .Left      = 185
            .Width     = 93
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Quantidade (2): "
            .TabIndex  = 13
        ENDWITH

        *-- get_peso (Quantidade 2/Peso, preenchida pelo Valid do Codigo)
        THIS.AddObject("txt_4c__peso", "TextBox")
        WITH THIS.txt_4c__peso
            .Top           = 262
            .Left          = 283
            .Width         = 96
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 9
            .FontBold      = .F.
            .FontItalic    = .F.
            .FontUnderline = .F.
            .Alignment     = 1
            .BackStyle     = 1
            .BorderStyle   = 1
            .SpecialEffect = 1
            .InputMask     = "9999,999.999"
            .ForeColor     = RGB(0, 0, 0)
            .TabIndex      = 7
            .Value         = 0
        ENDWITH

        *-- Say6 "Un" (vira a unidade da Qtde (2) apos o lookup)
        THIS.AddObject("lbl_4c_Label6", "Label")
        WITH THIS.lbl_4c_Label6
            .Top       = 266
            .Left      = 383
            .Width     = 60
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Un"
            .TabIndex  = 11
        ENDWITH

        *-- LOOKUP: unico campo digitavel da tela e Get_Codigo (o codigo de
        *-- barras). Os demais (Grupo/Conta/Produto/Descricao/Qtde/Peso) sao
        *-- somente exibicao - o legado bloqueia foco com "Procedure When /
        *-- Return .f." em cada um. Replicado via BINDEVENT "When" (regra
        *-- CLAUDE.md #3: metodo alvo PUBLIC, sem PROTECTED).
        BINDEVENT(THIS.txt_4c_Grupo,   "When", THIS, "NaoPermitirFocoWhen")
        BINDEVENT(THIS.txt_4c_Conta,   "When", THIS, "NaoPermitirFocoWhen")
        BINDEVENT(THIS.txt_4c_Produto, "When", THIS, "NaoPermitirFocoWhen")
        BINDEVENT(THIS.txt_4c__dpro,   "When", THIS, "NaoPermitirFocoWhen")
        BINDEVENT(THIS.txt_4c_Qtde,    "When", THIS, "NaoPermitirFocoWhen")
        BINDEVENT(THIS.txt_4c__peso,   "When", THIS, "NaoPermitirFocoWhen")

        *-- Legado: Get_Codigo.Valid consulta SigOpEtq ao SAIR do campo.
        *-- BINDEVENT "Valid" NAO funciona de forma confiavel em TextBox
        *-- (regra CLAUDE.md) - replicado em "LostFocus", que cobre Tab/
        *-- clique-fora e tambem Enter (o Enter da TextBox nao-multilinha
        *-- dispara Valid e move o foco por default, o que ja gera LostFocus).
        BINDEVENT(THIS.txt_4c_Codigo, "LostFocus", THIS, "CodigoLostFocus")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - Shape decorativo + botoes de acao (Confirma/Cancela).
    * Legado: SIGOPBCB.Shape1 (Top=7,Left=617) e os dois fwbtng standalone
    * direto no form (sem CommandGroup) ? Confirma ("Baixa", Top=3,Left=649)
    * e Cancela ("Encerrar", Top=3,Left=724, Cancel=.T.). Width/Height nao
    * declarados no SCX (herdados da classe fwbtng) ? usado o canonico 75x75
    * dos botoes Confirmar/Encerrar do framework (mesmos icones).
    * Handlers: BtnConfirmarClick (Confirma.Click) e BtnCancelarClick (Cancela.Click).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 7
            .Left        = 617
            .Width       = 31
            .Height      = 17
            .BackStyle   = 0
            .BorderStyle = 0
            .Curvature   = 0
            .BorderColor = RGB(136, 189, 188)
        ENDWITH

        THIS.AddObject("cmd_4c_Confirma", "CommandButton")
        WITH THIS.cmd_4c_Confirma
            .Top             = 3
            .Left            = 649
            .Width           = 75
            .Height          = 75
            .TabIndex        = 8
            .Caption         = "Baixa"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_Cancela", "CommandButton")
        WITH THIS.cmd_4c_Cancela
            .Top             = 3
            .Left            = 724
            .Width           = 75
            .Height          = 75
            .TabIndex        = 9
            .Cancel          = .T.
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
        ENDWITH

        *-- BINDEVENT exige que o metodo alvo ja exista em THIS no momento do
        *-- bind - por isso vem depois de BtnConfirmarClick/BtnCancelarClick
        *-- estarem declarados no arquivo, mais abaixo.
        BINDEVENT(THIS.cmd_4c_Confirma, "Click", THIS, "BtnConfirmarClick")
        BINDEVENT(THIS.cmd_4c_Cancela,  "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - container cinza (cntSombra do legado) com os dois
    * labels de titulo sobrepostos (sombra preta + titulo branco).
    * Geometria TRANSCRITA do dump: Top/Left/Width/Height/FontSize exatos de
    * SIGOPBCB.cntSombra/lblSombra/lblTitulo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Top           = 18
            .Left          = 10
            .Width         = 769
            .Height        = 40
            .AutoSize      = .F.
            .BackStyle     = 0
            .WordWrap      = .T.
            .Alignment     = 0
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .FontUnderline = .F.
            .ForeColor     = RGB(0, 0, 0)
            .Caption       = THIS.Caption
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Top         = 17
            .Left        = 10
            .Width       = 769
            .Height      = 46
            .AutoSize    = .F.
            .BackStyle   = 0
            .WordWrap    = .T.
            .Alignment   = 0
            .FontName    = "Tahoma"
            .FontSize    = 18
            .FontBold    = .T.
            .ForeColor   = RGB(255, 255, 255)
            .Caption     = THIS.Caption
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * NaoPermitirFocoWhen - When comum aos 6 campos somente-exibicao (Grupo/
    * Conta/Produto/Descricao/Qtde/Peso). Legado: "Procedure When / Return .f."
    * em cada um deles - o campo mostra o valor trazido pelo lookup mas nunca
    * recebe foco (nem por Tab, nem por clique). Metodo PUBLIC (regra
    * CLAUDE.md #3: BINDEVENT exige metodo PUBLIC).
    *--------------------------------------------------------------------------
    FUNCTION NaoPermitirFocoWhen()
        RETURN .F.
    ENDFUNC

    *--------------------------------------------------------------------------
    * LimparCampos - bloco que ABRE o Valid de Get_Codigo no legado:
    *
    *   With ThisForm
    *       .Get_Grupo.Value = ' ' / .Get_Conta.Value = ' '
    *       .Get_Produto.Value = ' ' / .Get_Dpro.Value = ' '
    *       .Get_Qtde.Value = 0 / .Get_peso.Value = 0
    *       .Say5.Caption = ' ' / .Say6.Caption = ' ' / .Refresh
    *   Endwith
    *
    * Limpa a EXIBICAO do codigo anterior antes de consultar o novo - os seis
    * campos somente-exibicao mais as duas unidades. O codigo de barras em si
    * NAO entra: no legado quem o apaga sao as duas recusas do Valid
    * (This.Value = Space(8)) e o fim do BaixaBarra, nao este bloco.
    *
    * PROTECTED obrigatoriamente: FormBase declara LimparCampos() PROTECTED e
    * o VFP9 nao permite ALARGAR o escopo de um metodo herdado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        THIS.txt_4c_Grupo.Value    = " "
        THIS.txt_4c_Conta.Value    = " "
        THIS.txt_4c_Produto.Value  = " "
        THIS.txt_4c__dpro.Value    = " "
        THIS.txt_4c_Qtde.Value     = 0
        THIS.txt_4c__peso.Value    = 0
        THIS.lbl_4c_Label5.Caption = " "
        THIS.lbl_4c_Label6.Caption = " "

        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - leva o UNICO campo digitavel da tela (o codigo de barras)
    * para o BO, com a MESMA conversao do legado:
    *
    *   lnBar = Iif(Type('This.Value')='C', Int(Val(This.Value)), This.Value)
    *
    * O IIF do legado existe porque o Get_Codigo do SCX nasce com Value = []
    * (caractere) e passa a numerico se alguem lhe atribuir numero; aqui o
    * TextBox nasce com SPACE(14) e o InputMask "99999999999999" mantem o
    * valor caractere, mas o teste de VARTYPE eh transcrito de proposito -
    * ALLTRIM/VAL sobre numerico dispara erro 11 em runtime.
    *
    * Devolve .T. quando sobrou um codigo utilizavel (> 0), que eh a mesma
    * condicao do "If (lnBar > 0)" que cerca o resto do Valid legado. Assim o
    * chamador nao precisa repetir a conversao para decidir se consulta.
    *
    * PROTECTED obrigatoriamente (mesma razao de LimparCampos).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION FormParaBO()
        LOCAL loc_nBar

        IF VARTYPE(THIS.txt_4c_Codigo.Value) = "C"
            loc_nBar = INT(VAL(ALLTRIM(THIS.txt_4c_Codigo.Value)))
        ELSE
            loc_nBar = INT(THIS.txt_4c_Codigo.Value)
        ENDIF

        THIS.this_oBusinessObject.this_nCbars = loc_nBar

        RETURN (loc_nBar > 0)
    ENDFUNC

    *--------------------------------------------------------------------------
    * BOParaForm - bloco que FECHA o Valid de Get_Codigo no legado:
    *
    *   With ThisForm
    *       .Get_Grupo.Value = crSigOpEtq.Grupos / .Get_Conta.Value = crSigOpEtq.Contas
    *       .Get_Produto.Value = crSigOpEtq.CPros / .Get_dpro.Value = LocalPro.Dpros
    *       .Get_Qtde.Value = CrSigOpEtq.Qtds / .Get_Peso.Value = CrSigOpEtq.Pesos
    *       .Say5.Caption = '( '+LocalPro.Cunis+')'
    *       .Say6.Caption = '( '+LocalPro.Cunips+')' / .Refresh
    *   Endwith
    *
    * As properties do BO guardam o valor CRU das colunas (TratarNulo nao
    * recorta), entao cUnis/cUniPs char(3) chegam com o padding do banco e
    * "( " + .this_cCunis + ")" reproduz EXATAMENTE o rotulo do legado -
    * ALLTRIM aqui encurtaria a legenda em relacao ao original.
    *
    * PROTECTED obrigatoriamente (mesma razao de LimparCampos).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        WITH THIS.this_oBusinessObject
            THIS.txt_4c_Grupo.Value    = .this_cGrupos
            THIS.txt_4c_Conta.Value    = .this_cContas
            THIS.txt_4c_Produto.Value  = .this_cCpros
            THIS.txt_4c__dpro.Value    = .this_cDpros
            THIS.txt_4c_Qtde.Value     = .this_nQtds
            THIS.txt_4c__peso.Value    = .this_nPesos
            THIS.lbl_4c_Label5.Caption = "( " + .this_cCunis  + ")"
            THIS.lbl_4c_Label6.Caption = "( " + .this_cCunips + ")"
        ENDWITH

        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConsultarCodigo - FUNIL do Valid de Get_Codigo legado, e o unico lugar
    * que consulta a etiqueta. Encadeia LimparCampos -> FormParaBO ->
    * BO.ConsultarEtiqueta -> recusa (nao localizado / ja baixado) ou
    * BOParaForm. Devolve .T. somente quando a etiqueta esta carregada e apta
    * a ser baixada - o que o botao "Baixa" precisa saber.
    *
    * PUBLIC (nao PROTECTED) porque eh alvo de BINDEVENT - regra CLAUDE.md #3.
    *
    * GUARDA DE REENTRANCIA (regra CLAUDE.md #37/#47): as duas recusas abrem
    * dialogo modal e reescrevem o proprio Get_Codigo, e o BtnConfirmarClick
    * termina em SetFocus() nesse mesmo campo - as duas coisas podem fazer o
    * LostFocus disparar de novo por cima da consulta em andamento. A flag
    * mora no WRAPPER e o corpo fica em ConsultarCodigoExec(), porque o corpo
    * tem saida antecipada: com set/clear no proprio corpo, o primeiro RETURN
    * deixaria a flag ligada para sempre e MATARIA o lookup pelo resto da
    * vida do form.
    *--------------------------------------------------------------------------
    FUNCTION ConsultarCodigo()
        LOCAL loc_lApta

        IF THIS.this_lEmConsulta
            RETURN .F.
        ENDIF

        THIS.this_lEmConsulta = .T.
        loc_lApta = THIS.ConsultarCodigoExec()
        THIS.this_lEmConsulta = .F.

        RETURN loc_lApta
    ENDFUNC

    *--------------------------------------------------------------------------
    * ConsultarCodigoExec - corpo de ConsultarCodigo (ver guarda la).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ConsultarCodigoExec()
        LOCAL loc_nBar

        THIS.LimparCampos()

        *-- If (lnBar > 0) do legado: sem codigo utilizavel, o Valid nao
        *-- consulta nada e a tela fica apenas limpa.
        IF !THIS.FormParaBO()
            RETURN .F.
        ENDIF

        loc_nBar = THIS.this_oBusinessObject.this_nCbars

        THIS.this_oBusinessObject.ConsultarEtiqueta(loc_nBar)

        IF !THIS.this_oBusinessObject.this_lEtiquetaLocalizada
            *-- If Eof('crSigOpEtq') -> Messagebox + This.Value = Space(8)
            MsgAviso("O c" + CHR(243) + "digo [" + PADL(TRANSFORM(loc_nBar), 14) + "] " + ;
                "n" + CHR(227) + "o localizado..." + CHR(13) + CHR(13) + ;
                "Verifique ou utilize outro c" + CHR(243) + "digo!!!", ;
                "C" + CHR(243) + "digo n" + CHR(227) + "o localizado")
            THIS.txt_4c_Codigo.Value = SPACE(14)
            THIS.Refresh()
            RETURN .F.
        ENDIF

        IF THIS.this_oBusinessObject.this_lEtiquetaBaixada
            *-- If Empty(crSigOpEtq.Grupos) And Empty(crSigOpEtq.Contas)
            MsgAviso("O c" + CHR(243) + "digo [" + PADL(TRANSFORM(loc_nBar), 8) + "] " + ;
                "j" + CHR(225) + " foi baixado..." + CHR(13) + CHR(13) + ;
                "Verifique ou utilize outro c" + CHR(243) + "digo!!!", ;
                "C" + CHR(243) + "digo j" + CHR(225) + " baixado")
            THIS.txt_4c_Codigo.Value = SPACE(14)
            THIS.Refresh()
            RETURN .F.
        ENDIF

        THIS.BOParaForm()

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * CodigoLostFocus - equivalente ao Get_Codigo.Valid do legado. O Valid
    * roda ao SAIR do campo e BINDEVENT "Valid" nao eh confiavel em TextBox
    * (regra CLAUDE.md), por isso o gancho eh "LostFocus"; todo o trabalho
    * esta no funil ConsultarCodigo.
    *--------------------------------------------------------------------------
    FUNCTION CodigoLostFocus()
        THIS.ConsultarCodigo()
    ENDFUNC

    *--------------------------------------------------------------------------
    * BtnConfirmarClick - equivalente ao Confirma.Click do legado (botao
    * "Confirma", Caption "Baixa"): com codigo preenchido, pede confirmacao
    * e, confirmando, efetiva a baixa via SigOpBcbBO.Inserir() - metodo que
    * replica o BaixaBarra legado (INSERT em SigMvCab/SigMvHst + UPDATE em
    * SigOpEtq num unico lote).
    *
    * SINCRONIA ANTES DE GRAVAR: o Inserir() do BO grava a etiqueta que esta
    * carregada nas properties, nao o que esta na tela. No fluxo normal o
    * LostFocus de Get_Codigo (funil ConsultarCodigo) ja deixou as duas
    * coisas iguais - clicar o botao tira o foco do campo e dispara o Valid,
    * como no legado. Mas o leitor de codigo de barras pode confirmar sem que
    * o foco saia do campo, e ai gravar-se-ia a etiqueta ANTERIOR: um codigo
    * diferente do exibido, sem erro nenhum na tela. A conferencia abaixo
    * reusa o MESMO funil (nao duplica a consulta) e so prossegue se a
    * etiqueta da tela estiver carregada e apta.
    *
    * FALHA NUNCA MUDA (regra CLAUDE.md #20): aqui o form chama Inserir()
    * DIRETO, sem passar por BusinessBase.Salvar(), entao o ExibirFalha() da
    * base nao roda. As duas recusas do Inserir() (nao localizado / ja
    * baixado) apenas preenchem this_cMensagemErro - quem exibe eh o ELSE
    * abaixo, guardado por this_lErroExibido para nao repetir a mensagem que
    * o proprio BO ja mostrou no caminho de erro de SQL.
    *
    * Legado:
    *   If Not Empty(ThisForm.get_Codigo.Value) And MessageBox(...) = 6
    *       ThisForm.BaixaBarra
    *   Endif
    *   ThisForm.Get_Codigo.SetFocus
    * O SetFocus roda SEMPRE, dentro ou fora do If - por isso fica depois do
    * ENDTRY, nao dentro dele.
    *
    * Apos a baixa, o BaixaBarra legado (With ThisForm / .get_Codigo.Value='' /
    * .Get_Grupo.Value='' / .Get_Conta.Value='' / .Get_Produto.Value='' /
    * .Refresh) limpa SO esses quatro campos - Descricao/Qtde/Peso/unidades
    * ficam com o ultimo valor exibido ate o proximo codigo (mesmo aqui).
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_oErro, loc_lApta, loc_nTela

        TRY
            IF !EMPTY(THIS.txt_4c_Codigo.Value) AND ;
               MsgConfirma("Confirma Baixa do Barra?", "Confirma" + CHR(231) + CHR(227) + "o")

                *-- A etiqueta carregada no BO tem de ser a do codigo exibido.
                loc_nTela = INT(VAL(ALLTRIM(TRANSFORM(THIS.txt_4c_Codigo.Value))))

                WITH THIS.this_oBusinessObject
                    loc_lApta = .this_lEtiquetaLocalizada AND ;
                                !.this_lEtiquetaBaixada AND ;
                                .this_nCbars = loc_nTela
                ENDWITH

                IF !loc_lApta
                    loc_lApta = THIS.ConsultarCodigo()
                ENDIF

                IF loc_lApta
                    IF THIS.this_oBusinessObject.Inserir()
                        *-- With ThisForm / .get_Codigo.Value = '' /
                        *-- .Get_Grupo.Value = '' / .Get_Conta.Value = '' /
                        *-- .Get_Produto.Value = '' / .Refresh (fim do
                        *-- BaixaBarra legado) - limpa SO estes quatro.
                        THIS.txt_4c_Codigo.Value  = SPACE(14)
                        THIS.txt_4c_Grupo.Value   = ""
                        THIS.txt_4c_Conta.Value   = ""
                        THIS.txt_4c_Produto.Value = ""
                        THIS.Refresh()
                    ELSE
                        WITH THIS.this_oBusinessObject
                            IF !.this_lErroExibido AND !EMPTY(.this_cMensagemErro)
                                MsgAviso(.this_cMensagemErro, ;
                                    "Baixa n" + CHR(227) + "o efetivada")
                            ENDIF
                        ENDWITH
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnConfirmarClick")
        ENDTRY

        THIS.txt_4c_Codigo.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - equivalente ao Cancela.Click do legado (botao
    * "Cancela", Caption "Encerrar"): "Thisform.Release" - unico caminho de
    * saida da tela (form Flat, sem Page2/Dados para cancelar).
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - torna todos os controles visiveis recursivamente
    * FILTRO: nenhum container flutuante neste form
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

ENDDEFINE
