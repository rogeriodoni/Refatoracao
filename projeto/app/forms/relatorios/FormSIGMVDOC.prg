*==============================================================================
* FORMSIGMVDOC.PRG
* Emissao do Documento - Formulario de Filtros (faixa de Nota Fiscal)
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGMVDOC.SCX (frmrelatorio)
*
* O SIGMVDOC.SCX legado eh um dialogo generico de impressao (LPARAMETERS
* pRep, pTit) reaproveitado por varios chamadores; o unico ramo com regra de
* negocio real (faixa de Nota Fiscal) eh o caso pRep = "SIGCDENT", que e o
* que este form/BO implementa (ver comentario em SIGMVDOCBO.prg:PrepararDados).
*
* Filtro:
*   - Nota Fiscal Inicial (GetNotaI) + Nota Fiscal Final (GetNotaF)
*==============================================================================

DEFINE CLASS FormSIGMVDOC AS FormBase

    *-- Dimensoes e aparencia (EXATAS do original: Width=800, Height=130)
    Height      = 130
    Width       = 800
    DataSession = 2
    ShowWindow  = 1
    WindowType  = 1
    AutoCenter  = .T.
    BorderStyle = 2
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    ShowTips    = .T.
    AlwaysOnTop = .T.

    *-- Referencia ao BO de relatorio (instanciado em InicializarForm)
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *-- Faixa REAL de Notas Fiscais existentes (menor e maior nfis da empresa).
    *   Equivalem ao "Go Top" / "Go Bott" que o Init legado fazia sobre o cursor
    *   crDados para descobrir os limites da faixa. Populadas por LimparCampos e
    *   usadas pelos handlers de saida dos campos para limitar o que o usuario
    *   digita, exatamente como GetNotaI.Valid / GetNotaF.Valid do legado.
    this_nNotaMin      = 0
    this_nNotaMax      = 0

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura visual do formulario de relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Emiss" + CHR(227) + "o do Documento"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            IF TYPE("gc_4c_CaminhoReports") = "U"
                gc_4c_CaminhoReports = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO de relatorio
            THIS.this_oRelatorio = CREATEOBJECT("SIGMVDOCBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SIGMVDOCBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Liga os controles de filtro aos handlers e carrega a faixa
                *   inicial de Notas (equivalente ao final do Init legado)
                THIS.ConfigurarPaginaDados()
                THIS.LimparCampos()

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro superior com titulo do relatorio
    *   Equivalente ao cntSombra do frmrelatorio legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
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

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 22
                .Left      = 22
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Emiss" + CHR(227) + "o do Documento"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 20
                .Left      = 20
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Emiss" + CHR(227) + "o do Documento"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - CommandGroup com 4 botoes de relatorio
    *   Geometria EXATA do SCX legado (SIGMVDOC.btnReport):
    *     Top=0, Left=495, Width=310, Height=85, ButtonCount=4
    *     Buttons Width=75, Height=75, Lefts=5/80/155/230 (inc 75)
    *   Buttons(3): Caption/Picture canonicos "Arquivos Email" (CLAUDE.md #100),
    *   sem relacao com o Name legado "DocExcel".
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = 0
            .Left          = 495
            .Width         = 310
            .Height        = 85
            .ButtonCount   = 4
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderColor   = RGB(136, 189, 188)
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.

            WITH .Buttons(1)
                .Top             = 5
                .Left            = 5
                .Width           = 75
                .Height          = 75
                .Caption         = "\<Visualizar"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Gerar o Relat" + CHR(243) + "rio no V" + CHR(237) + "deo"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(2)
                .Top             = 5
                .Left            = 80
                .Width           = 75
                .Height          = 75
                .Caption         = "\<Imprimir"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Enviar o Relat" + CHR(243) + "rio Para Impressora"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(3)
                .Top             = 5
                .Left            = 155
                .Width           = 75
                .Height          = 75
                .Caption         = "\<Arquivos Email"
                .WordWrap        = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Arquivos Email"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(4)
                .Top             = 5
                .Left            = 230
                .Width           = 75
                .Height          = 75
                .Caption         = "\<Encerrar"
                .Cancel          = .T.
                .WordWrap        = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "[Esc] Encerrar"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com 1 pagina (Filtros)
    *   Posicionado abaixo do cabecalho (Top=80) ate o fim do form.
    *   Os controles de filtro (Nota Inicial/Final) sao adicionados na
    *   Page1 por ConfigurarPaginaLista.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
        loc_oPgf.PageCount = 1

        loc_oPgf.Top    = 80
        loc_oPgf.Left   = -1
        loc_oPgf.Width  = THIS.Width + 2
        loc_oPgf.Height = THIS.Height - 80
        loc_oPgf.Tabs   = .F.

        loc_oPgf.Page1.Caption   = "Filtros"
        loc_oPgf.Page1.FontName  = "Tahoma"
        loc_oPgf.Page1.FontSize  = 8
        loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Controles de filtro da faixa de Nota Fiscal (Page1)
    *
    * Form REPORT (frmrelatorio) tem layout FLAT: PageFrame com UMA pagina so
    * (Filtros). Nao existe grade de registros nem botoes CRUD - a Page1 deste
    * tipo de form hospeda os campos de parametro do relatorio, e os botoes de
    * acao (Visualizar/Imprimir/Arquivos Email/Encerrar) vivem no cmg_4c_Botoes
    * criado em ConfigurarBotoes, fora do PageFrame.
    *
    * Posicoes EXATAS do SCX legado, compensadas pelo Top do PageFrame (-80):
    *     Shape1    Top=90  Left=203 W=394 H=32  -> Top=10
    *     Label1    Top=98  Left=254 W=96  H=15  -> Top=18  "Documentos de :"
    *     GetNotaI  Top=95  Left=352 W=60  H=23  -> Top=15
    *     Label2    Top=98  Left=419 W=9   H=15  -> Top=18  CHR(224) = a crasado
    *     GetNotaF  Top=94  Left=434 W=60  H=23  -> Top=14
    *
    * Ordem de criacao = ordem do SCX (Shape primeiro): o Shape eh a moldura do
    * bloco e precisa ficar ATRAS dos campos, que sao criados depois.
    *
    * Shape3 (Top=343) e Shape4 (Top=276) do SCX ficam fora da area visivel do
    * form (Form.Height=130) - sao restos do dialogo generico, nao migrados.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        *-- Shape1: moldura do bloco de filtro
        *   SCX: BackStyle=0 / BorderStyle=0 / BorderColor=136,189,188
        loc_oPag.AddObject("shp_4c_Shape1", "Shape")
        WITH loc_oPag.shp_4c_Shape1
            .Top         = 10
            .Left        = 203
            .Width       = 394
            .Height      = 32
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH

        *-- Label1 "Documentos de :"
        *   SCX declara AutoSize=.T., que eh no-op em Label criado por AddObject:
        *   usar Alignment=0 + Width explicita do legado (CLAUDE.md regra #23).
        loc_oPag.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPag.lbl_4c_Label1
            .Top       = 18
            .Left      = 254
            .Width     = 96
            .Height    = 15
            .Caption   = "Documentos de :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- GetNotaI -> txt_4c_NotaI (Nota Fiscal inicial da faixa)
        loc_oPag.AddObject("txt_4c_NotaI", "TextBox")
        WITH loc_oPag.txt_4c_NotaI
            .Top           = 15
            .Left          = 352
            .Width         = 60
            .Height        = 23
            .Value         = 0
            .InputMask     = "999999"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .TabIndex      = 2
            .ToolTipText   = "Nota Fiscal Inicial"
            .Visible       = .T.
        ENDWITH

        *-- Label2 CHR(224) = "a" crasado (separador da faixa "de X a Y")
        loc_oPag.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPag.lbl_4c_Label2
            .Top       = 18
            .Left      = 419
            .Width     = 9
            .Height    = 15
            .Caption   = CHR(224)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- GetNotaF -> txt_4c_NotaF (Nota Fiscal final da faixa)
        loc_oPag.AddObject("txt_4c_NotaF", "TextBox")
        WITH loc_oPag.txt_4c_NotaF
            .Top           = 14
            .Left          = 434
            .Width         = 60
            .Height        = 23
            .Value         = 0
            .InputMask     = "999999"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .TabIndex      = 4
            .ToolTipText   = "Nota Fiscal Final"
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Vincula os eventos dos controles de entrada
    *
    * Form REPORT (frmrelatorio) NAO tem "Page2 de Dados": o SCX legado eh FLAT e
    * os unicos controles de entrada sao a faixa de Nota Fiscal, ja criada na
    * Page1 por ConfigurarPaginaLista. Este metodo conecta esses controles - e os
    * 4 botoes do cmg_4c_Botoes - aos respectivos handlers, mesmo papel que o
    * ConfigurarPaginaDados dos demais forms REPORT do projeto (ref: Formsigrecrf).
    *
    * GetNotaI.Valid / GetNotaF.Valid do legado sao reproduzidos em
    * TxtNotaILostFocus / TxtNotaFLostFocus: BINDEVENT em "Valid" nao dispara de
    * forma confiavel em TextBox (CLAUDE.md regra #3) e o Valid do legado rodava
    * justamente ao SAIR do campo.
    *
    * Os botoes sao ligados UM A UM em Buttons(N) (canonico REPORT) - NAO ligar
    * tambem o Click do proprio CommandGroup, senao cada clique dispara duas
    * vezes (o botao sem codigo de Click propaga o evento para o grupo).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Faixa de Nota Fiscal: valida ao sair do campo (Valid do legado)
        BINDEVENT(loc_oPagina.txt_4c_NotaI, "KeyPress", THIS, "TxtNotaILostFocus")
        BINDEVENT(loc_oPagina.txt_4c_NotaF, "KeyPress", THIS, "TxtNotaFLostFocus")

        *-- Botoes do relatorio (Visualizar / Imprimir / Arquivos Email / Encerrar)
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnEmailClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarFaixaNotas - Descobre no banco a faixa REAL de Notas Fiscais
    *
    * Equivale ao que o Init legado fazia sobre o cursor crDados para achar os
    * limites da faixa -
    *     Go Top  / Thisform.GetNotaI.Value = nFis
    *     Go Bott / Thisform.GetNotaF.Value = nFis
    * Aqui os mesmos limites vem do banco (MIN/MAX de nfis na empresa corrente),
    * ja que o crDados do dialogo generico era populado pelo chamador externo.
    *
    * NAO escreve nos campos da tela: apenas atualiza this_nNotaMin /
    * this_nNotaMax, que os handlers de saida dos campos usam para limitar o que
    * for digitado. Quem escreve nos campos eh LimparCampos (abertura da tela e
    * botao Cancelar) e CarregarLista (que so traz de volta para dentro da faixa
    * o valor que tiver ficado fora dela).
    *
    * Sem conexao (validacao de UI / teste automatizado) devolve .F. com os
    * limites zerados e o form abre normalmente - o PrepararDados do BO recusa
    * faixa zerada.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarFaixaNotas()
        LOCAL loc_cSQL, loc_cEmpresa, loc_nResult, loc_lTemBanco, loc_lSucesso, loc_oErro

        THIS.this_nNotaMin = 0
        THIS.this_nNotaMax = 0
        loc_lSucesso       = .F.

        loc_lTemBanco = .T.
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            loc_lTemBanco = .F.
        ENDIF
        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            loc_lTemBanco = .F.
        ENDIF

        IF loc_lTemBanco
            TRY
                loc_cEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa)

                IF USED("cursor_4c_FaixaNota")
                    USE IN cursor_4c_FaixaNota
                ENDIF

                *-- nfis eh char(6) no schema: MIN/MAX devolvem char e a
                *   conversao para numerico fica no VAL logo abaixo
                loc_cSQL = "SELECT MIN(nfis) AS notamin, MAX(nfis) AS notamax" + ;
                    " FROM SigMvNfi WHERE emps = " + EscaparSQL(loc_cEmpresa)

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FaixaNota")

                IF loc_nResult < 0
                    MsgErro("Erro ao carregar a faixa de Notas Fiscais:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                ELSE
                    IF USED("cursor_4c_FaixaNota")
                        SELECT cursor_4c_FaixaNota
                        IF !EOF()
                            THIS.this_nNotaMin = VAL(TratarNulo(cursor_4c_FaixaNota.notamin, ""))
                            THIS.this_nNotaMax = VAL(TratarNulo(cursor_4c_FaixaNota.notamax, ""))
                            loc_lSucesso       = .T.
                        ENDIF
                    ENDIF
                ENDIF

                IF USED("cursor_4c_FaixaNota")
                    USE IN cursor_4c_FaixaNota
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "CarregarFaixaNotas")
            ENDTRY
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * LimparCampos - Abre a tela ja com a faixa inicial de Notas Fiscais
    *
    * O Init legado nao abre o dialogo com os campos em branco: usa o primeiro e
    * o ultimo documento como faixa inicial. Aqui esses limites vem de
    * CarregarFaixaNotas e sao copiados para os dois campos.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina

        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        THIS.CarregarFaixaNotas()

        loc_oPagina.txt_4c_NotaI.Value = THIS.this_nNotaMin
        loc_oPagina.txt_4c_NotaF.Value = THIS.this_nNotaMax
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Ativa a pagina de filtros e devolve o foco ao 1o campo
    *
    * Form REPORT tem PageCount=1: qualquer indice fora da faixa cai na Page1
    * (Filtros). Sobrescreve FormBase.AlternarPagina para tambem reexibir o
    * PageFrame e reposicionar o foco no primeiro campo editavel, como o
    * dialogo legado fazia ao voltar do preview/impressao.
    *
    * PUBLIC (sem PROTECTED): eh chamado de FORA da classe pelo harness de
    * teste automatizado (CLAUDE.md regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina, loc_oPag, loc_oErro

        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)
                IF loc_nPagina < 1 OR loc_nPagina > THIS.pgf_4c_Paginas.PageCount
                    loc_nPagina = 1
                ENDIF

                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = loc_nPagina

                *-- SetFocus so eh valido com o form ja visivel; sem o guard,
                *   chamar AlternarPagina antes do Show() cai no CATCH.
                loc_oPag = THIS.pgf_4c_Paginas.Page1
                IF THIS.Visible AND PEMSTATUS(loc_oPag, "txt_4c_NotaI", 5)
                    IF loc_oPag.txt_4c_NotaI.Visible AND loc_oPag.txt_4c_NotaI.Enabled
                        loc_oPag.txt_4c_NotaI.SetFocus()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "AlternarPagina")
        ENDTRY
    ENDPROC


    *--------------------------------------------------------------------------
    * TxtNotaILostFocus - Valida a Nota Inicial contra a Nota Final digitada
    *   (equivalente funcional ao GetNotaI.Valid legado, que comparava contra
    *   o cursor crDados aberto pelo chamador externo do dialogo generico -
    *   nao reproduzivel aqui; a validacao de faixa correta eh preservada e
    *   tambem reforcada pelo PrepararDados do BO antes de rodar o relatorio)
    *--------------------------------------------------------------------------
    PROCEDURE TxtNotaILostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        *-- Legado: Go Top  / If This.Value < nFis -> avisa e volta para o limite
        IF THIS.this_nNotaMin > 0 AND loc_oPag.txt_4c_NotaI.Value < THIS.this_nNotaMin
            MsgAviso("Nota Menor Que Inicial !!!", "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPag.txt_4c_NotaI.Value = THIS.this_nNotaMin
        ENDIF

        *-- Legado: Go Bott / If This.Value > nFis -> avisa e volta para o limite
        IF THIS.this_nNotaMax > 0 AND loc_oPag.txt_4c_NotaI.Value > THIS.this_nNotaMax
            MsgAviso("Nota Maior Que Final !!!", "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPag.txt_4c_NotaI.Value = THIS.this_nNotaMax
        ENDIF

        *-- Coerencia da faixa: a inicial nunca acima da final ja digitada
        IF loc_oPag.txt_4c_NotaF.Value > 0 AND loc_oPag.txt_4c_NotaI.Value > loc_oPag.txt_4c_NotaF.Value
            MsgAviso("Nota Inicial maior que a Nota Final !!!", "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPag.txt_4c_NotaI.Value = loc_oPag.txt_4c_NotaF.Value
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtNotaFLostFocus - Valida a Nota Final contra a Nota Inicial digitada
    *--------------------------------------------------------------------------
    PROCEDURE TxtNotaFLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        *-- Legado: Go Top  / If This.Value < nFis -> avisa e volta para o limite
        IF THIS.this_nNotaMin > 0 AND loc_oPag.txt_4c_NotaF.Value < THIS.this_nNotaMin
            MsgAviso("Nota Menor Que Inicial !!!", "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPag.txt_4c_NotaF.Value = THIS.this_nNotaMin
        ENDIF

        *-- Legado: Go Bott / If This.Value > nFis -> avisa e volta para o limite
        IF THIS.this_nNotaMax > 0 AND loc_oPag.txt_4c_NotaF.Value > THIS.this_nNotaMax
            MsgAviso("Nota Maior Que Final !!!", "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPag.txt_4c_NotaF.Value = THIS.this_nNotaMax
        ENDIF

        *-- Coerencia da faixa: a final nunca abaixo da inicial ja digitada
        IF loc_oPag.txt_4c_NotaF.Value < loc_oPag.txt_4c_NotaI.Value
            MsgAviso("Nota Final menor que a Nota Inicial !!!", "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPag.txt_4c_NotaF.Value = loc_oPag.txt_4c_NotaI.Value
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Copia os filtros digitados para o BO de relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        WITH THIS.this_oRelatorio
            .this_nNotaI = loc_oPag.txt_4c_NotaI.Value
            .this_nNotaF = loc_oPag.txt_4c_NotaF.Value
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFaixaPreenchida - Equivalente ao btnReport.Click legado:
    *   "If (This.Value <> 3) ... If Empty(GetNotaI.Value) / If Empty(GetNotaF.Value)"
    *   Roda antes de Visualizar/Imprimir (botoes 1 e 2 do grupo); o legado
    *   tambem cobria o botao Sair (4), mas bloquear o fechamento do dialogo
    *   por faixa vazia nao faz sentido no fluxo migrado - Encerrar fica de
    *   fora desta checagem (desvio deliberado, registrado aqui). O botao de
    *   Email/DocExcel (3) ja era excluido no legado.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarFaixaPreenchida()
        LOCAL loc_oPag, loc_lValido
        loc_oPag    = THIS.pgf_4c_Paginas.Page1
        loc_lValido = .T.

        IF EMPTY(loc_oPag.txt_4c_NotaI.Value)
            MsgErro("Nota Inicial Inv" + CHR(225) + "lida !!!", "")
            loc_lValido = .F.
        ELSE
            IF EMPTY(loc_oPag.txt_4c_NotaF.Value)
                MsgErro("Nota Final Inv" + CHR(225) + "lida !!!", "")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Preview do documento na tela
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        IF THIS.ValidarFaixaPreenchida()
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.Visualizar()
                IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Visualizar")
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Envia o documento para a impressora (com dialogo)
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        IF THIS.ValidarFaixaPreenchida()
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.Imprimir()
                IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEmailClick - Gera arquivo (Excel) do documento para envio por email
    *--------------------------------------------------------------------------
    PROCEDURE BtnEmailClick()
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.GerarExcel()
            IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Arquivos Email")
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
    * Destroy - Libera referencia ao BO
    *   RelatorioBase herda de Custom (sem Release()) - usar .NULL. para liberar
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * METODOS DE COMPATIBILIDADE COM O PIPELINE CRUD
    *
    * Form REPORT nao tem grid de lista nem gravacao de registro: os nomes CRUD
    * abaixo existem porque o pipeline e o harness de teste automatizado os
    * chamam em todo form, e cada um recebe aqui o comportamento equivalente no
    * contexto de um relatorio (mesmo padrao dos demais forms REPORT do
    * projeto - ref: Formsigrecrf.prg).
    *
    * Os que o harness chama de FORA da classe (CarregarLista,
    * AjustarBotoesPorModo, HabilitarCampos, BtnCancelarClick) sao PUBLIC (sem
    * PROTECTED): PEMSTATUS(oForm, "Metodo", 5) devolve .T. mesmo para metodo
    * PROTECTED e a chamada real falharia em runtime (CLAUDE.md regra #3).
    *
    * FormParaBO e BOParaForm sao PROTECTED porque o FormBase ja os declara
    * assim - a protecao eh herdada e nao ha como afrouxa-la na subclasse
    * (declarar sem PROTECTED aqui nao muda nada: medido, chamada externa
    * estoura "Property FORMPARABO is not found"). Sao internos mesmo: quem os
    * usa sao os proprios metodos desta classe.
    *==========================================================================

    *--------------------------------------------------------------------------
    * FormParaBO - Copia os filtros da tela para o BO
    *   Nome CRUD do pipeline; em REPORT o destino eh o BO de relatorio, entao
    *   delega para FormParaRelatorio (fonte unica da copia dos filtros).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Traz os filtros que estao no BO de volta para a tela
    *   Caminho inverso de FormParaBO: util depois de o BO ajustar a faixa
    *   (ex.: PrepararDados normaliza os limites) para a tela refletir o que
    *   sera efetivamente impresso.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPag

        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF

        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF VARTYPE(loc_oPag) != "O"
            RETURN
        ENDIF

        WITH THIS.this_oRelatorio
            IF VARTYPE(loc_oPag.txt_4c_NotaI) = "O"
                loc_oPag.txt_4c_NotaI.Value = .this_nNotaI
            ENDIF
            IF VARTYPE(loc_oPag.txt_4c_NotaF) = "O"
                loc_oPag.txt_4c_NotaF.Value = .this_nNotaF
            ENDIF
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Em REPORT nao ha grid: recarrega a faixa de documentos
    *
    * O equivalente a "recarregar a lista" neste dialogo eh reconsultar quais
    * documentos existem (CarregarFaixaNotas) e, se a faixa disponivel tiver
    * mudado desde a abertura da tela, trazer de volta para dentro dela o que o
    * usuario tiver digitado - sem zerar o que ele escolheu, que eh o que
    * LimparCampos faz.
    *
    * Devolve sempre .T.: nao ha lista cuja carga possa falhar, e o relatorio
    * segue utilizavel mesmo com os limites zerados (o PrepararDados do BO
    * recusa faixa invalida com mensagem propria).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_oPag

        THIS.CarregarFaixaNotas()

        loc_oPag = THIS.pgf_4c_Paginas.Page1

        IF VARTYPE(loc_oPag) = "O" AND THIS.this_nNotaMin > 0 AND THIS.this_nNotaMax > 0
            IF loc_oPag.txt_4c_NotaI.Value < THIS.this_nNotaMin OR ;
               loc_oPag.txt_4c_NotaI.Value > THIS.this_nNotaMax
                loc_oPag.txt_4c_NotaI.Value = THIS.this_nNotaMin
            ENDIF
            IF loc_oPag.txt_4c_NotaF.Value < THIS.this_nNotaMin OR ;
               loc_oPag.txt_4c_NotaF.Value > THIS.this_nNotaMax
                loc_oPag.txt_4c_NotaF.Value = THIS.this_nNotaMax
            ENDIF
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita os campos de filtro da faixa
    *   par_lHabilitar ausente ou de tipo invalido assume .T. (habilitar), que
    *   eh o estado normal de um form REPORT - nao ha modo VISUALIZAR aqui.
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab, loc_oPag

        loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        IF VARTYPE(loc_oPag) != "O"
            RETURN
        ENDIF

        IF VARTYPE(loc_oPag.txt_4c_NotaI) = "O"
            loc_oPag.txt_4c_NotaI.Enabled = loc_lHab
        ENDIF
        IF VARTYPE(loc_oPag.txt_4c_NotaF) = "O"
            loc_oPag.txt_4c_NotaF.Enabled = loc_lHab
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Em REPORT os 4 botoes ficam sempre habilitados
    *   (Visualizar / Imprimir / Arquivos Email / Encerrar). Chamado de FORA da
    *   classe pelo harness de teste, por isso PUBLIC.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_nI

        IF VARTYPE(THIS.cmg_4c_Botoes) != "O"
            RETURN
        ENDIF

        FOR loc_nI = 1 TO THIS.cmg_4c_Botoes.ButtonCount
            THIS.cmg_4c_Botoes.Buttons(loc_nI).Enabled = .T.
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Nome CRUD do pipeline; em REPORT "salvar o resultado" eh
    *   mandar o documento para a impressora. Delega para BtnImprimirClick para
    *   que a validacao da faixa (ValidarFaixaPreenchida) e o tratamento de erro
    *   fiquem em um lugar so.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Nome CRUD do pipeline; em REPORT "cancelar a edicao" eh
    *   descartar o que foi digitado e voltar a faixa completa de documentos,
    *   devolvendo o foco ao primeiro campo para nova consulta.
    *
    *   O SetFocus so vale com a tela JA exibida: o harness de teste chama este
    *   metodo com o form apenas instanciado (sem Show), e ai SetFocus estoura.
    *   Dai a guarda por THIS.Visible alem da de Enabled.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        LOCAL loc_oPag

        THIS.LimparCampos()

        loc_oPag = THIS.pgf_4c_Paginas.Page1

        IF VARTYPE(loc_oPag) = "O" AND THIS.Visible
            IF VARTYPE(loc_oPag.txt_4c_NotaI) = "O" AND loc_oPag.txt_4c_NotaI.Enabled
                loc_oPag.txt_4c_NotaI.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

ENDDEFINE

