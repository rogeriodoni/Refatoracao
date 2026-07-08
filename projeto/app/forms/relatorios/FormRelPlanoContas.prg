*-- FormRelPlanoContas.prg
*-- Formulario de Relatorio do Plano de Contas
*--
*-- NOTA: Este NAO eh um formulario CRUD - eh um formulario de RELATORIO
*-- Herda de Form (nao FormBase) pois nao faz operacoes CRUD
*--
*-- Data: 2026-02-05
*-- Migrado de: SigRePlc.SCX (frmrelatorio)

DEFINE CLASS FormRelPlanoContas AS FormBase

    *-- Propriedades visuais (EXATAS do original)
    Height = 300
    Width = 800
    AutoCenter = .T.
    BorderStyle = 2
    Caption = "Relat" + CHR(243) + "rio do Plano de Contas"
    ControlBox = .F.
    Closable = .F.
    MaxButton = .F.
    TitleBar = 0
    Themes = .F.
    WindowType = 1
    ShowWindow = 1

    *-- Propriedades do form
    this_oBO = .NULL.
    this_cClasse = ""
    this_cDclasse = ""
    this_nOptCli = 1
    this_nOptFor = 1

    *-- =============================================
    *-- PROCEDURE Init
    *-- Inicializacao do formulario
    *-- =============================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Verificar conexao (exceto em modo validacao UI)
            IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                IF TYPE("gnConnHandle") != "N" OR gnConnHandle < 0
                    MostrarErro("Erro de conex" + CHR(227) + "o com banco de dados.", "Erro")
                    loc_lSucesso = .F.
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                loc_lSucesso = .T.
            ENDIF

            IF loc_lSucesso
                *-- Criar BO
                THIS.this_oBO = CREATEOBJECT("PlanoContasBO")

                *-- Imagem de fundo canonica do frmrelatorio
                IF TYPE("gc_4c_CaminhoIcones") = "U"
                    gc_4c_CaminhoIcones = ""
                ENDIF
                THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

                *-- Configurar interface
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarCampos()
                THIS.ConfigurarBotoes()

                *-- Carregar dados base
                IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    IF NOT THIS.this_oBO.CarregarDadosBase()
                        MostrarErro("Erro ao carregar dados base.", "Erro")
                        loc_lSucesso = .F.
                    ENDIF
                ENDIF

                *-- Foco inicial
                IF loc_lSucesso AND TYPE("THIS.txt_4c_Classe") = "O"
                    THIS.txt_4c_Classe.SetFocus()
                ENDIF
            ENDIF

        CATCH TO loc_oExcecao
            MostrarErro("Erro ao inicializar formul" + CHR(225) + "rio:" + CHR(13) + ;
                       "Linha: " + TRANSFORM(loc_oExcecao.LineNo) + CHR(13) + ;
                       loc_oExcecao.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *-- =============================================
    *-- PROCEDURE ConfigurarCabecalho
    *-- Configura container de cabecalho
    *-- =============================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        *-- Container de sombra/titulo (herdado de frmrelatorio)
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top = 0
            .Left = 0
            .Width = THIS.Width
            .Height = 80
            .BackStyle   = 1
            .BackColor = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Sombra do titulo (efeito 3D canonico frmrelatorio)
        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Top = 22
            .Left = 22
            .AutoSize  = .F.
            .Width     = THIS.Width
            .Height    = 30
            .Caption = "Relat" + CHR(243) + "rio do Plano de Contas"
            .FontName = "Tahoma"
            .FontSize = 14
            .FontBold = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        *-- Titulo
        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Top = 20
            .Left = 20
            .AutoSize  = .F.
            .Width     = THIS.Width
            .Height    = 30
            .Caption = "Relat" + CHR(243) + "rio do Plano de Contas"
            .FontName = "Tahoma"
            .FontSize = 14
            .FontBold = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Visible = .T.
        THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Visible = .T.
        THIS.cnt_4c_Cabecalho.Visible = .T.
    ENDPROC

    *-- =============================================
    *-- PROCEDURE ConfigurarCampos
    *-- Configura campos de filtro
    *-- =============================================
    PROTECTED PROCEDURE ConfigurarCampos()
        LOCAL loc_nTopBase
        loc_nTopBase = 100

        *-- Label Classe
        THIS.AddObject("lbl_4c_Classe", "Label")
        WITH THIS.lbl_4c_Classe
            .Top = loc_nTopBase + 49
            .Left = 234
            .AutoSize = .T.
            .Caption = "Classe :"
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible = .T.
        ENDWITH

        *-- TextBox Classe
        THIS.AddObject("txt_4c_Classe", "TextBox")
        WITH THIS.txt_4c_Classe
            .Top = loc_nTopBase + 44
            .Left = 279
            .Width = 79
            .Height = 25
            .FontName = "Courier New"
            .Format = "K!"
            .MaxLength = 10
            .SpecialEffect = 1
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH

        *-- TextBox Descricao Classe
        THIS.AddObject("txt_4c_Dclasse", "TextBox")
        WITH THIS.txt_4c_Dclasse
            .Top = loc_nTopBase + 44
            .Left = 360
            .Width = 219
            .Height = 25
            .FontName = "Courier New"
            .Format = "K"
            .MaxLength = 30
            .SpecialEffect = 1
            .BorderColor = RGB(100, 100, 100)
            .Value = ""
            .Visible = .T.
        ENDWITH

        *-- Label Cliente
        THIS.AddObject("lbl_4c_Cliente", "Label")
        WITH THIS.lbl_4c_Cliente
            .Top = loc_nTopBase + 75
            .Left = 232
            .AutoSize = .T.
            .Caption = "Cliente :"
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible = .T.
        ENDWITH

        *-- OptionGroup Cliente (Analitico/Sintetico)
        THIS.AddObject("opt_4c_Cli", "OptionGroup")
        WITH THIS.opt_4c_Cli
            .ButtonCount = 2
            .Top = loc_nTopBase + 69
            .Left = 274
            .Width = 153
            .Height = 27
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1

            .Option1.Caption = "\<Anal" + CHR(237) + "tico"
            .Option1.FontName = "Tahoma"
            .Option1.FontSize = 8
            .Option1.BackStyle = 0
            .Option1.ForeColor = RGB(90, 90, 90)
            .Option1.Top = 5
            .Option1.Left = 5
            .Option1.Width = 67
            .Option1.Height = 17

            .Option2.Caption = "S\<int" + CHR(233) + "tico"
            .Option2.FontName = "Tahoma"
            .Option2.FontSize = 8
            .Option2.BackStyle = 0
            .Option2.ForeColor = RGB(90, 90, 90)
            .Option2.Top = 5
            .Option2.Left = 75
            .Option2.Width = 69
            .Option2.Height = 17

            .Visible = .T.
        ENDWITH

        *-- Label Fornecedor
        THIS.AddObject("lbl_4c_Fornecedor", "Label")
        WITH THIS.lbl_4c_Fornecedor
            .Top = loc_nTopBase + 97
            .Left = 213
            .AutoSize = .T.
            .Caption = "Fornecedor:"
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible = .T.
        ENDWITH

        *-- OptionGroup Fornecedor (Analitico/Sintetico)
        THIS.AddObject("opt_4c_For", "OptionGroup")
        WITH THIS.opt_4c_For
            .ButtonCount = 2
            .Top = loc_nTopBase + 91
            .Left = 274
            .Width = 153
            .Height = 27
            .BackStyle = 0
            .BorderStyle = 0
            .Value = 1

            .Option1.Caption = "\<Anal" + CHR(237) + "tico"
            .Option1.FontName = "Tahoma"
            .Option1.FontSize = 8
            .Option1.BackStyle = 0
            .Option1.ForeColor = RGB(90, 90, 90)
            .Option1.Top = 5
            .Option1.Left = 5
            .Option1.Width = 67
            .Option1.Height = 17

            .Option2.Caption = "S\<int" + CHR(233) + "tico"
            .Option2.FontName = "Tahoma"
            .Option2.FontSize = 8
            .Option2.BackStyle = 0
            .Option2.ForeColor = RGB(90, 90, 90)
            .Option2.Top = 5
            .Option2.Left = 75
            .Option2.Width = 69
            .Option2.Height = 17

            .Visible = .T.
        ENDWITH
    ENDPROC

    *-- =============================================
    *-- PROCEDURE ConfigurarBotoes
    *-- Configura container de botoes de relatorio
    *-- =============================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        *-- Container de botoes (btnReport do framework)
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = 0
            .Left          = 529
            .Width         = 273
            .Height        = 80
            .ButtonCount   = 4
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderColor   = RGB(136, 189, 188)
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        *-- Botao Visualizar
        WITH THIS.cmg_4c_Botoes.Buttons(1)
            .Top = 5
            .Left = 5
            .Width = 65
            .Height = 70
            .Caption = "Visualizar"
            .FontName       = "Comic Sans MS"
            .FontBold       = .T.
            .FontItalic     = .T.
            .FontSize = 8
            .Picture = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
            .PicturePosition = 13
            .Themes = .F.
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible = .T.
        ENDWITH
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")

        *-- Botao Imprimir
        WITH THIS.cmg_4c_Botoes.Buttons(2)
            .Top = 5
            .Left = 72
            .Width = 65
            .Height = 70
            .Caption = "Imprimir"
            .FontName       = "Comic Sans MS"
            .FontBold       = .T.
            .FontItalic     = .T.
            .FontSize = 8
            .Picture = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
            .PicturePosition = 13
            .Themes = .F.
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible = .T.
        ENDWITH
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")

        *-- Botao Excel
        WITH THIS.cmg_4c_Botoes.Buttons(3)
            .Top = 5
            .Left = 139
            .Width = 65
            .Height = 70
            .Caption = "\<Arquivos Email"
            .WordWrap        = .T.
            .FontName       = "Comic Sans MS"
            .FontBold       = .T.
            .FontItalic     = .T.
            .FontSize = 8
            .Picture = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
            .PicturePosition = 13
            .Themes = .F.
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible = .T.
        ENDWITH
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")

        *-- Botao Sair
        WITH THIS.cmg_4c_Botoes.Buttons(4)
            .Top = 5
            .Left = 206
            .Width          = 65
            .Height         = 70
            .Caption = "Encerrar"
            .WordWrap        = .T.
            .FontName       = "Comic Sans MS"
            .FontBold       = .T.
            .FontItalic     = .T.
            .FontSize = 8
            .Picture = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
            .PicturePosition = 13
            .Themes = .F.
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible = .T.
        ENDWITH
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")
    ENDPROC

    *-- =============================================
    *-- PROCEDURE ValidarFiltros
    *-- Valida os filtros antes de gerar relatorio
    *-- =============================================
    PROTECTED PROCEDURE ValidarFiltros()
        LOCAL loc_lValido
        loc_lValido = .T.

        *-- Transferir valores do form para o BO
        THIS.this_cClasse = ALLTRIM(THIS.txt_4c_Classe.Value)
        THIS.this_cDclasse = ALLTRIM(THIS.txt_4c_Dclasse.Value)
        THIS.this_nOptCli = THIS.opt_4c_Cli.Value
        THIS.this_nOptFor = THIS.opt_4c_For.Value

        *-- Validar classe
        IF NOT EMPTY(THIS.this_cClasse)
            IF NOT THIS.this_oBO.ValidarClasse(THIS.this_cClasse)
                MsgErro("Classe Inv" + CHR(225) + "lida!", "Erro")
                THIS.txt_4c_Classe.SetFocus()
                loc_lValido = .F.
            ENDIF
        ENDIF

        *-- Validar descricao
        IF loc_lValido AND NOT EMPTY(THIS.this_cDclasse)
            IF NOT THIS.this_oBO.ValidarDescricao(THIS.this_cDclasse)
                MsgErro("Descri" + CHR(231) + CHR(227) + "o de Classe Inv" + CHR(225) + "lida!", "Erro")
                THIS.txt_4c_Dclasse.SetFocus()
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *-- =============================================
    *-- PROCEDURE Processamento
    *-- Processa dados para o relatorio
    *-- =============================================
    PROTECTED PROCEDURE Processamento()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        *-- Atualizar BO com filtros
        THIS.this_oBO.this_cClasse = THIS.this_cClasse
        THIS.this_oBO.this_cDclasse = THIS.this_cDclasse
        THIS.this_oBO.this_nOptCli = THIS.this_nOptCli
        THIS.this_oBO.this_nOptFor = THIS.this_nOptFor

        *-- Gerar relatorio
        loc_lSucesso = THIS.this_oBO.GerarRelatorio()

        RETURN loc_lSucesso
    ENDPROC

    *-- =============================================
    *-- PROCEDURE BtnVisualizarClick
    *-- Visualiza o relatorio na tela
    *-- =============================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cArquivoFRX, loc_oErro
        TRY
            loc_cArquivoFRX = FULLPATH(gc_4c_CaminhoReports + "relplanocontas.frx")

            IF THIS.ValidarFiltros()
                IF THIS.Processamento()
                    IF FILE(loc_cArquivoFRX)
                        REPORT FORM (loc_cArquivoFRX) PREVIEW NOCONSOLE
                    ELSE
                        MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + loc_cArquivoFRX, "Erro")
                    ENDIF
                ELSE
                    MostrarErro("Erro ao processar relat" + CHR(243) + "rio.", "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao visualizar relat" + CHR(243) + "rio:" + CHR(13) + ;
                       "Erro: " + loc_oErro.Message + CHR(13) + ;
                       "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        THIS.Refresh()
    ENDPROC

    *-- =============================================
    *-- PROCEDURE BtnImprimirClick
    *-- Imprime o relatorio
    *-- =============================================
    PROCEDURE BtnImprimirClick()
        LOCAL loc_cArquivoFRX, loc_oErro
        TRY
            loc_cArquivoFRX = FULLPATH(gc_4c_CaminhoReports + "relplanocontas.frx")

            IF THIS.ValidarFiltros()
                IF THIS.Processamento()
                    IF FILE(loc_cArquivoFRX)
                        REPORT FORM (loc_cArquivoFRX) TO PRINTER PROMPT NOCONSOLE
                    ELSE
                        MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + loc_cArquivoFRX, "Erro")
                    ENDIF
                ELSE
                    MostrarErro("Erro ao processar relat" + CHR(243) + "rio.", "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao imprimir relat" + CHR(243) + "rio:" + CHR(13) + ;
                       "Erro: " + loc_oErro.Message + CHR(13) + ;
                       "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        THIS.Refresh()
    ENDPROC

    *-- =============================================
    *-- PROCEDURE BtnExcelClick
    *-- Exporta para Excel
    *-- =============================================
    PROCEDURE BtnExcelClick()
        LOCAL loc_cArquivo

        IF THIS.ValidarFiltros()
            IF THIS.Processamento()
                *-- Gerar arquivo temporario
                loc_cArquivo = ADDBS(SYS(2023)) + "PlanoContas_" + DTOS(DATE()) + "_" + STRTRAN(TIME(), ":", "") + ".xls"

                SELECT cPlconta
                COPY TO (loc_cArquivo) TYPE XLS

                IF FILE(loc_cArquivo)
                    *-- Abrir no Excel
                    DECLARE INTEGER ShellExecute IN shell32.dll ;
                        INTEGER hndWin, STRING cAction, STRING cFileName, ;
                        STRING cParams, STRING cDir, INTEGER nShowWin

                    ShellExecute(0, "open", loc_cArquivo, "", "", 1)

                    MsgSucesso("Arquivo exportado para: " + loc_cArquivo)
                ELSE
                    MostrarErro("Erro ao exportar para Excel.", "Erro")
                ENDIF
            ELSE
                MostrarErro("Erro ao processar relat" + CHR(243) + "rio.", "Erro")
            ENDIF
        ENDIF

        THIS.Refresh()
    ENDPROC

    *-- =============================================
    *-- PROCEDURE BtnSairClick
    *-- Fecha o formulario
    *-- =============================================
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *-- =============================================
    *-- PROCEDURE Destroy
    *-- Limpa recursos ao fechar
    *-- =============================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBO) = "O" AND NOT ISNULL(THIS.this_oBO)
            THIS.this_oBO.LimparCursores()
            THIS.this_oBO = .NULL.
        ENDIF
    ENDPROC

ENDDEFINE
