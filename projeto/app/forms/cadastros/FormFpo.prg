*==============================================================================
* FormFpo.prg - Condicao de Pagamento Por Operacao
* Migrado de: SIGCDFPO.SCX
* Tabela principal: SigOpFpo (condicoes de pagamento por operacao)
*
* PADRAO: CRUD canonico de tela de MENU (regra #10), que PREVALECE sobre o
* PILAR 1. Page1 = Lista (grade + Incluir/Visualizar/Alterar/Excluir/Buscar +
* Encerrar); Incluir/Alterar/Visualizar levam a Page2 = Dados, onde o registro
* eh editado e confirmado.
*
* O SCX legado eh um dialogo 532x335 que edita DENTRO da grade, porque la a
* tela eh filha do Cadastro de Operacoes e vive uma operacao so. Aqui ela tem
* entrada propria no menu e lista TODAS as operacoes, por isso a coluna
* "Operacao" (Dopes), que no legado era implicita.
*==============================================================================

DEFINE CLASS FormFpo AS FormBase

    *-- Propriedades visuais - canonico de tela de menu
    Top         = 0
    Left        = 0
    Height      = 600
    Width       = 1000
    Caption     = ""
    AutoCenter  = .T.
    ShowWindow  = 1
    *-- WindowType = 1 (MODAL) eh obrigatorio: o menu abre com
    *-- loForm = CREATEOBJECT(...) numa variavel LOCAL + loForm.Show().
    *-- Com 0 (modeless) o Show() retorna na hora, o PROCEDURE termina,
    *-- loForm sai de escopo e o form eh DESTRUIDO - a tela pisca e some,
    *-- sem erro e sem log.
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    DataSession = 1

    *-- Estado e BO
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"    && LISTA / INCLUIR / ALTERAR / VISUALIZAR
    this_cChaveAtual     = ""         && CidChaves do registro em edicao
    *-- Guarda de reentrancia dos lookups abertos de LostFocus (regra #37/#47)
    this_lEmLookup       = .F.

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Chamado automaticamente pelo FormBase.Init()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.Caption = "Condi" + CHR(231) + CHR(227) + ;
                "o de Pagamento Por Opera" + CHR(231) + CHR(227) + "o"

            THIS.this_oBusinessObject = CREATEOBJECT("FpoBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar FpoBO", "Erro de Inicializa" + CHR(231) + CHR(227) + CHR(227) + "o")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                THIS.AjustarBotoesPorModo()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com Page1 (Lista) e Page2 (Dados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        WITH THIS.pgf_4c_Paginas
            .PageCount = 2
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .Tabs      = .F.
            .Visible   = .T.
            .Page1.Caption   = "Lista"
            .Page1.BackColor = RGB(100, 100, 100)
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.Caption   = "Dados"
            .Page2.BackColor = RGB(100, 100, 100)
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarCabecalho - Faixa cinza do titulo (regra #11)
    * PRIMEIRO AddObject da pagina: os containers de botao ficam em Top=29..33,
    * dentro da area da faixa, e precisam ser criados DEPOIS para desenhar por cima.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarCabecalho(par_oPagina, par_nTop)
        par_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH par_oPagina.cnt_4c_Cabecalho
            .Top         = par_nTop
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Caption   = THIS.Caption
                .Top       = 15
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Caption   = THIS.Caption
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarBotao - CommandButton 75x75 no padrao do projeto
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarBotao(par_oPai, par_cNome, par_cCaption, par_cIcone, par_nLeft)
        par_oPai.AddObject(par_cNome, "CommandButton")
        WITH EVALUATE("par_oPai." + par_cNome)
            .Caption         = par_cCaption
            .Picture         = gc_4c_CaminhoIcones + par_cIcone
            .PicturePosition = 13
            .Top             = 5
            .Left            = par_nLeft
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Page1: grade + barra CRUD canonica
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oErro

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            THIS.MontarCabecalho(loc_oPagina, 31)

            *-- Barra CRUD canonica (regra #10): Left=542, Width=385, passo 75
            loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
            WITH loc_oPagina.cnt_4c_Botoes
                .Top         = 29
                .Left        = 542
                .Width       = 385
                .Height      = 85
                .BackStyle   = 0
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH
            THIS.MontarBotao(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Incluir",    "Incluir",    "cadastro_inserir_60.jpg",    5)
            THIS.MontarBotao(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Visualizar", "Visualizar", "cadastro_vizualizar_60.jpg", 80)
            THIS.MontarBotao(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Alterar",    "Alterar",    "cadastro_alterar_60.jpg",    155)
            THIS.MontarBotao(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Excluir",    "Excluir",    "cadastro_excluir_60.jpg",    230)
            THIS.MontarBotao(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Buscar",     "Buscar",     "cadastro_procurar_60.jpg",   305)

            *-- Container de saida canonico (regra #10): Left=917, Width=90
            loc_oPagina.AddObject("cnt_4c_Saida", "Container")
            WITH loc_oPagina.cnt_4c_Saida
                .Top         = 29
                .Left        = 917
                .Width       = 90
                .Height      = 85
                .BackStyle   = 0
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH
            THIS.MontarBotao(loc_oPagina.cnt_4c_Saida, "cmd_4c_Encerrar", "Encerrar", "cadastro_sair_60.jpg", 5)

            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
            BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")

            *-- Grade da Lista (geometria canonica). SO exibe: a edicao eh na Page2.
            loc_oPagina.AddObject("grd_4c_Lista", "Grid")
            loc_oPagina.grd_4c_Lista.ColumnCount = 6
            WITH loc_oPagina.grd_4c_Lista
                .Top                = 117
                .Left               = 26
                .Width              = 880
                .Height             = 440
                .FontName           = "Tahoma"
                .FontSize           = 8
                .ForeColor          = RGB(90, 90, 90)
                .ReadOnly           = .T.
                .DeleteMark         = .F.
                .RecordMark         = .T.
                .RowHeight          = 18
                .AllowHeaderSizing  = .F.
                .AllowRowSizing     = .F.
                .GridLineColor      = RGB(238, 238, 238)
                .HighlightStyle     = 2
                .HighlightBackColor = RGB(255, 255, 255)
                .HighlightForeColor = RGB(15, 41, 104)
                .ScrollBars         = 2
                .Visible            = .T.
            ENDWITH
            BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnAlterarClick")

            *-- Legendas das colunas O / A / C (Say1/Say2/Say3 do legado), com as
            *-- MESMAS cores, logo abaixo da grade.
            THIS.MontarLegenda(loc_oPagina, "lbl_4c_Say1", "O = Obrigat" + CHR(243) + "rio",      307, 100, RGB(216, 39, 70))
            THIS.MontarLegenda(loc_oPagina, "lbl_4c_Say2", "A = S" + CHR(243) + " Auto",          419,  80, RGB(0, 0, 128))
            THIS.MontarLegenda(loc_oPagina, "lbl_4c_Say3", "C = N" + CHR(195) + "O Contabilizar", 507, 145, RGB(0, 128, 255))

            THIS.TornarControlesVisiveis(loc_oPagina)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarLegenda(par_oPagina, par_cNome, par_cTexto, par_nLeft, par_nWidth, par_nCor)
        par_oPagina.AddObject(par_cNome, "Label")
        WITH EVALUATE("par_oPagina." + par_cNome)
            .Caption   = par_cTexto
            .Top       = 565
            .Left      = par_nLeft
            .Width     = par_nWidth
            .Height    = 15
            .BackStyle = 0
            .ForeColor = par_nCor
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Page2: campos do registro + Confirmar/Cancelar
    * Nenhum controle de dados pode ter Top < 109 (a faixa ocupa 29..109).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina, loc_oErro

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            THIS.MontarCabecalho(loc_oPagina, 29)

            *-- Botoes de acao canonicos da Page2: Top=33, Left=842, Width=160
            loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
            WITH loc_oPagina.cnt_4c_BotoesAcao
                .Top         = 33
                .Left        = 842
                .Width       = 160
                .Height      = 85
                .BackStyle   = 0
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH
            THIS.MontarBotao(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", "Confirmar", "cadastro_salvar_60.jpg",   5)
            THIS.MontarBotao(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Cancelar",  "Encerrar",  "cadastro_cancelar_60.jpg", 80)
            BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
            BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

            *-- Moldura dos campos
            loc_oPagina.AddObject("shp_4c_Campos", "Shape")
            WITH loc_oPagina.shp_4c_Campos
                .Top         = 125
                .Left        = 26
                .Width       = 620
                .Height      = 225
                .BorderColor = RGB(90, 90, 90)
                .BackStyle   = 0
                .Visible     = .T.
            ENDWITH

            THIS.MontarRotulo(loc_oPagina, "lbl_4c_LblDopes",  "Opera" + CHR(231) + CHR(227) + "o :",            145,  46, 115)
            THIS.MontarCampo (loc_oPagina, "txt_4c_Dopes",   141, 170, 200, 20)
            THIS.MontarRotulo(loc_oPagina, "lbl_4c_LblFPags",  "Condi" + CHR(231) + CHR(227) + "o Pagto :",      180,  46, 115)
            THIS.MontarCampo (loc_oPagina, "txt_4c_FPags",   176, 170, 150, 12)
            THIS.MontarRotulo(loc_oPagina, "lbl_4c_LblFPagss", "Substituir :",                                   215,  46, 115)
            THIS.MontarCampo (loc_oPagina, "txt_4c_FPagss",  211, 170, 150, 12)

            THIS.MontarCheck(loc_oPagina, "chk_4c_Obrigs",  "O = Obrigat" + CHR(243) + "rio",      250, 170, 200, RGB(216, 39, 70))
            THIS.MontarCheck(loc_oPagina, "chk_4c_Autos",   "A = S" + CHR(243) + " Auto",          278, 170, 200, RGB(0, 0, 128))
            THIS.MontarCheck(loc_oPagina, "chk_4c_Contabs", "C = N" + CHR(195) + "O Contabilizar", 306, 170, 200, RGB(0, 128, 255))

            *-- Lookups: picker no LostFocus (o legado valida no Valid) e F4 na tecla.
            *-- Ligar no "KeyPress" abriria o dialogo a cada caractere (regra #47).
            BINDEVENT(loc_oPagina.txt_4c_Dopes,  "LostFocus", THIS, "DopesLostFocus")
            BINDEVENT(loc_oPagina.txt_4c_Dopes,  "KeyPress",  THIS, "DopesKeyPress")
            BINDEVENT(loc_oPagina.txt_4c_FPags,  "LostFocus", THIS, "FPagsLostFocus")
            BINDEVENT(loc_oPagina.txt_4c_FPags,  "KeyPress",  THIS, "FPagsKeyPress")
            BINDEVENT(loc_oPagina.txt_4c_FPagss, "KeyPress",  THIS, "FPagssKeyPress")

            THIS.TornarControlesVisiveis(loc_oPagina)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarRotulo(par_oPagina, par_cNome, par_cTexto, par_nTop, par_nLeft, par_nWidth)
        par_oPagina.AddObject(par_cNome, "Label")
        WITH EVALUATE("par_oPagina." + par_cNome)
            .Caption   = par_cTexto
            .Top       = par_nTop
            .Left      = par_nLeft
            .Width     = par_nWidth
            .Height    = 17
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarCampo(par_oPagina, par_cNome, par_nTop, par_nLeft, par_nWidth, par_nMax)
        par_oPagina.AddObject(par_cNome, "TextBox")
        WITH EVALUATE("par_oPagina." + par_cNome)
            .Value         = ""
            .Top           = par_nTop
            .Left          = par_nLeft
            .Width         = par_nWidth
            .Height        = 25
            .MaxLength     = par_nMax
            .Format        = "K!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarCheck(par_oPagina, par_cNome, par_cTexto, par_nTop, par_nLeft, par_nWidth, par_nCor)
        par_oPagina.AddObject(par_cNome, "CheckBox")
        WITH EVALUATE("par_oPagina." + par_cNome)
            .Caption   = par_cTexto
            .Value     = 0
            .Top       = par_nTop
            .Left      = par_nLeft
            .Width     = par_nWidth
            .Height    = 17
            .BackStyle = 0
            .ForeColor = par_nCor
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF
                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Popula a grade da Page1 com SigOpFpo
    * PUBLIC: chamado de fora (harness) - regra #3/#51
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid, loc_oErro
        loc_lResultado = .F.

        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                IF !USED("cursor_4c_Dados")
                    CREATE CURSOR cursor_4c_Dados (;
                        CidChaves C(20), Dopes C(20), FPags C(12), ;
                        Obrigs N(1,0), Autos N(1,0), Contabs N(1,0), ;
                        FPagss C(12), BlqAltExc N(1,0))
                ENDIF
                loc_lResultado = .T.
            ELSE
                loc_lResultado = THIS.this_oBusinessObject.Buscar("")
            ENDIF

            IF loc_lResultado AND USED("cursor_4c_Dados")
                THIS.VincularGrade(loc_oGrid)
                SELECT cursor_4c_Dados
                GO TOP
                loc_oGrid.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * VincularGrade - RecordSource + colunas. Regra #41: a largura vai DEPOIS do
    * RecordSource, que a recalcula; e o AddObject do Check1 so na 1a vez, senao
    * estoura "member object already exists" no recarregamento.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE VincularGrade(par_oGrid)
        par_oGrid.RecordSource = ""
        par_oGrid.ColumnCount  = 6
        par_oGrid.RecordSource = "cursor_4c_Dados"

        WITH par_oGrid
            .Column1.ControlSource   = "cursor_4c_Dados.Dopes"
            .Column1.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
            .Column2.ControlSource   = "cursor_4c_Dados.FPags"
            .Column2.Header1.Caption = "Condi" + CHR(231) + CHR(227) + "o Pagto"
            .Column3.ControlSource   = "cursor_4c_Dados.Obrigs"
            .Column3.Header1.Caption = "O"
            .Column4.ControlSource   = "cursor_4c_Dados.Autos"
            .Column4.Header1.Caption = "A"
            .Column5.ControlSource   = "cursor_4c_Dados.Contabs"
            .Column5.Header1.Caption = "C"
            .Column6.ControlSource   = "cursor_4c_Dados.FPagss"
            .Column6.Header1.Caption = "Substituir"
        ENDWITH

        *-- CheckBox nas colunas O/A/C, com as cores do legado (regra #18:
        *-- sem CurrentControl a coluna segue desenhando o Text1 e nada aparece)
        THIS.MontarCheckColuna(par_oGrid.Column3, RGB(216, 39, 70))
        THIS.MontarCheckColuna(par_oGrid.Column4, RGB(0, 0, 128))
        THIS.MontarCheckColuna(par_oGrid.Column5, RGB(0, 128, 255))

        LOCAL loc_nI
        FOR loc_nI = 1 TO 6
            WITH par_oGrid.Columns(loc_nI)
                .Movable   = .F.
                .Resizable = .F.
                .FontName  = "Courier New"
                .FontSize  = 8
                .Header1.FontBold  = .T.
                .Header1.Alignment = 2
            ENDWITH
        ENDFOR
        par_oGrid.Column3.Header1.ForeColor = RGB(216, 39, 70)
        par_oGrid.Column4.Header1.ForeColor = RGB(0, 0, 128)
        par_oGrid.Column5.Header1.ForeColor = RGB(0, 128, 255)

        *-- A grade eh SO EXIBICAO (a edicao eh na Page2). O ColumnCount acima
        *-- RECRIA as colunas e zera o ReadOnly delas, por isso ele tem de ser
        *-- reafirmado AQUI - e o da Column vem DEPOIS do Grid, que propaga
        *-- para as colunas e sobrescreveria (regra #46).
        par_oGrid.ReadOnly = .T.
        FOR loc_nI = 1 TO 6
            par_oGrid.Columns(loc_nI).ReadOnly = .T.
        ENDFOR

        *-- Larguras por ULTIMO (regra #41)
        par_oGrid.Column1.Width = 220
        par_oGrid.Column2.Width = 180
        par_oGrid.Column3.Width = 30
        par_oGrid.Column4.Width = 30
        par_oGrid.Column5.Width = 30
        par_oGrid.Column6.Width = 180
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarCheckColuna(par_oColuna, par_nCor)
        IF !PEMSTATUS(par_oColuna, "Check1", 5)
            par_oColuna.AddObject("Check1", "CheckBox")
        ENDIF
        WITH par_oColuna.Check1
            .Caption   = ""
            .Alignment = 0
            .BackColor = par_nCor
            .ForeColor = RGB(90, 90, 90)
            *-- so exibe o estado: marcar/desmarcar eh na Page2
            .ReadOnly  = .T.
            .Enabled   = .F.
            .Visible   = .T.
            .Top       = 9
            .Left      = 2
            .Height    = 17
            .Width     = 22
        ENDWITH
        par_oColuna.Sparse         = .F.
        par_oColuna.CurrentControl = "Check1"
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Funil de ida e VOLTA entre Lista e Dados.
    * Regra #40: quem desabilita os botoes no caminho de ida tem de reabilitar
    * aqui, no caminho de volta - senao a Lista volta com tudo cinza.
    * PUBLIC: chamado de fora (harness) - regra #3/#51
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        IF VARTYPE(par_nPagina) != "N" OR !INLIST(par_nPagina, 1, 2)
            RETURN .F.
        ENDIF

        THIS.pgf_4c_Paginas.ActivePage = par_nPagina

        IF par_nPagina = 1
            THIS.this_cModoAtual = "LISTA"
            THIS.CarregarLista()
        ENDIF

        THIS.AjustarBotoesPorModo()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - PUBLIC (regra #3/#51)
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lLista, loc_lEditando, loc_oPg1, loc_oPg2

        loc_lLista    = (THIS.this_cModoAtual == "LISTA")
        loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        WITH loc_oPg1.cnt_4c_Botoes
            .cmd_4c_Incluir.Enabled    = loc_lLista
            .cmd_4c_Visualizar.Enabled = loc_lLista
            .cmd_4c_Alterar.Enabled    = loc_lLista
            .cmd_4c_Excluir.Enabled    = loc_lLista
            .cmd_4c_Buscar.Enabled     = loc_lLista
        ENDWITH
        loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Novo registro na Page2
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro
        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.this_cChaveAtual = ""
            THIS.this_cModoAtual  = "INCLUIR"
            THIS.LimparCampos()
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Dopes.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BtnIncluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick / BtnVisualizarClick - Carregam o registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        THIS.AbrirRegistro("ALTERAR")
    ENDPROC

    PROCEDURE BtnVisualizarClick()
        THIS.AbrirRegistro("VISUALIZAR")
    ENDPROC

    PROCEDURE AbrirRegistro(par_cModo)
        LOCAL loc_cChave, loc_oErro, loc_lOk
        loc_lOk = .F.

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.", "")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Dados
        IF EOF() OR BOF()
            GO TOP
        ENDIF
        loc_cChave = ALLTRIM(NVL(cursor_4c_Dados.CidChaves, ""))

        IF EMPTY(loc_cChave)
            MsgAviso("Registro sem chave - n" + CHR(227) + "o pode ser aberto.", "")
            RETURN .F.
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                THIS.this_cChaveAtual = loc_cChave
                THIS.this_cModoAtual  = par_cModo
                THIS.BOParaForm()
                THIS.HabilitarCampos(par_cModo == "ALTERAR")
                IF par_cModo == "ALTERAR"
                    THIS.this_oBusinessObject.EditarRegistro()
                ENDIF
                THIS.AlternarPagina(2)
                loc_lOk = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em AbrirRegistro")
        ENDTRY

        RETURN loc_lOk
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Exclui o registro selecionado (apos confirmacao)
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cChave, loc_oErro, loc_lOk
        loc_lOk = .F.

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.", "")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Dados
        IF EOF() OR BOF()
            GO TOP
        ENDIF

        IF NVL(cursor_4c_Dados.BlqAltExc, 0) = 1
            MsgAviso("Registro bloqueado para altera" + CHR(231) + CHR(227) + ;
                "o/exclus" + CHR(227) + "o.", "")
            RETURN .F.
        ENDIF

        loc_cChave = ALLTRIM(NVL(cursor_4c_Dados.CidChaves, ""))
        IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
            RETURN .F.
        ENDIF

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?")
            RETURN .F.
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Registro exclu" + CHR(237) + "do com sucesso.")
                THIS.CarregarLista()
                loc_lOk = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BtnExcluirClick")
        ENDTRY

        RETURN loc_lOk
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConfirmarClick - Grava o registro da Page2 e volta para a Lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_oErro
        TRY
            IF THIS.ValidarCampos()
                IF THIS.FormParaBO()
                    IF THIS.this_oBusinessObject.Salvar()
                        MsgInfo("Registro salvo com sucesso!", "Confirmar")
                        THIS.AlternarPagina(1)
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BtnConfirmarClick")
        ENDTRY
    ENDPROC

    PROCEDURE BtnSalvarClick()
        THIS.BtnConfirmarClick()
    ENDPROC

    PROCEDURE BtnCancelarClick()
        THIS.this_oBusinessObject.CancelarEdicao()
        THIS.AlternarPagina(1)
    ENDPROC

    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCampos - Operacao e Condicao de Pagamento sao obrigatorias
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Dopes.Value))
            MsgAviso("Informe a Opera" + CHR(231) + CHR(227) + "o.", "")
            loc_oPg2.txt_4c_Dopes.SetFocus()
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_FPags.Value))
            MsgAviso("Informe a Condi" + CHR(231) + CHR(227) + "o de Pagamento.", "")
            loc_oPg2.txt_4c_FPags.SetFocus()
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        LOCAL loc_oPg2, loc_oBO
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oBO  = THIS.this_oBusinessObject

        loc_oBO.this_cCidChaves = ALLTRIM(THIS.this_cChaveAtual)
        loc_oBO.this_cDopes     = ALLTRIM(loc_oPg2.txt_4c_Dopes.Value)
        loc_oBO.this_cFPags     = ALLTRIM(loc_oPg2.txt_4c_FPags.Value)
        loc_oBO.this_cFPagss    = ALLTRIM(loc_oPg2.txt_4c_FPagss.Value)
        loc_oBO.this_nObrigs    = IIF(loc_oPg2.chk_4c_Obrigs.Value  = 1, 1, 0)
        loc_oBO.this_nAutos     = IIF(loc_oPg2.chk_4c_Autos.Value   = 1, 1, 0)
        loc_oBO.this_nContabs   = IIF(loc_oPg2.chk_4c_Contabs.Value = 1, 1, 0)

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_oBO
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oBO  = THIS.this_oBusinessObject

        loc_oPg2.txt_4c_Dopes.Value    = ALLTRIM(loc_oBO.this_cDopes)
        loc_oPg2.txt_4c_FPags.Value    = ALLTRIM(loc_oBO.this_cFPags)
        loc_oPg2.txt_4c_FPagss.Value   = ALLTRIM(loc_oBO.this_cFPagss)
        loc_oPg2.chk_4c_Obrigs.Value   = IIF(loc_oBO.this_nObrigs  = 1, 1, 0)
        loc_oPg2.chk_4c_Autos.Value    = IIF(loc_oBO.this_nAutos   = 1, 1, 0)
        loc_oPg2.chk_4c_Contabs.Value  = IIF(loc_oBO.this_nContabs = 1, 1, 0)

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oPg2.txt_4c_Dopes.Value   = ""
        loc_oPg2.txt_4c_FPags.Value   = ""
        loc_oPg2.txt_4c_FPagss.Value  = ""
        loc_oPg2.chk_4c_Obrigs.Value  = 0
        loc_oPg2.chk_4c_Autos.Value   = 0
        loc_oPg2.chk_4c_Contabs.Value = 0
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oPg2.txt_4c_Dopes.ReadOnly   = !par_lHabilitar
        loc_oPg2.txt_4c_FPags.ReadOnly   = !par_lHabilitar
        loc_oPg2.txt_4c_FPagss.ReadOnly  = !par_lHabilitar
        loc_oPg2.chk_4c_Obrigs.Enabled   = par_lHabilitar
        loc_oPg2.chk_4c_Autos.Enabled    = par_lHabilitar
        loc_oPg2.chk_4c_Contabs.Enabled  = par_lHabilitar
        RETURN .T.
    ENDPROC

    *==========================================================================
    * LOOKUPS
    * Picker no LostFocus (o legado valida no Valid) + F4 na tecla. Guarda de
    * reentrancia: o picker eh MODAL, tira o foco e redispara o LostFocus; o
    * corpo vive no *Exec para a flag ser liberada mesmo com RETURN antecipado.
    *==========================================================================
    PROCEDURE DopesKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_lAnt
        IF par_nKeyCode = 115
            loc_lAnt = THIS.this_lEmLookup
            THIS.this_lEmLookup = .T.
            THIS.AbrirLookupDopes()
            THIS.this_lEmLookup = loc_lAnt
        ENDIF
    ENDPROC

    PROCEDURE DopesLostFocus()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.DopesLostFocusExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROCEDURE DopesLostFocusExec()
        IF THIS.this_cModoAtual == "VISUALIZAR"
            RETURN
        ENDIF
        IF EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Dopes.Value))
            RETURN
        ENDIF
        THIS.AbrirLookupDopes()
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupDopes()
        LOCAL loc_oBusca, loc_oPg2, loc_oErro
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdOpe", "cursor_4c_BuscaOpe", "Dopes", ;
                ALLTRIM(loc_oPg2.txt_4c_Dopes.Value), "Opera" + CHR(231) + CHR(245) + "es")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpe")
                    SELECT cursor_4c_BuscaOpe
                    loc_oPg2.txt_4c_Dopes.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em AbrirLookupDopes")
        ENDTRY

        IF USED("cursor_4c_BuscaOpe")
            USE IN cursor_4c_BuscaOpe
        ENDIF
    ENDPROC

    PROCEDURE FPagsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_lAnt
        IF par_nKeyCode = 115
            loc_lAnt = THIS.this_lEmLookup
            THIS.this_lEmLookup = .T.
            THIS.AbrirLookupFPags("txt_4c_FPags")
            THIS.this_lEmLookup = loc_lAnt
        ENDIF
    ENDPROC

    PROCEDURE FPagssKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_lAnt
        IF par_nKeyCode = 115
            loc_lAnt = THIS.this_lEmLookup
            THIS.this_lEmLookup = .T.
            THIS.AbrirLookupFPags("txt_4c_FPagss")
            THIS.this_lEmLookup = loc_lAnt
        ENDIF
    ENDPROC

    PROCEDURE FPagsLostFocus()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.FPagsLostFocusExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROCEDURE FPagsLostFocusExec()
        IF THIS.this_cModoAtual == "VISUALIZAR"
            RETURN
        ENDIF
        IF EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_FPags.Value))
            RETURN
        ENDIF
        THIS.AbrirLookupFPags("txt_4c_FPags")
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupFPags(par_cCampo)
        LOCAL loc_oBusca, loc_oPg2, loc_oErro, loc_cValor
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cValor = ALLTRIM(EVALUATE("loc_oPg2." + par_cCampo + ".Value"))

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigOpFp", "cursor_4c_BuscaFp", "FPags", loc_cValor, ;
                "Condi" + CHR(231) + CHR(245) + "es de Pagamento")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("FPags",  "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFp")
                    SELECT cursor_4c_BuscaFp
                    STORE ALLTRIM(cursor_4c_BuscaFp.FPags) TO ("loc_oPg2." + par_cCampo + ".Value")
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em AbrirLookupFPags")
        ENDTRY

        IF USED("cursor_4c_BuscaFp")
            USE IN cursor_4c_BuscaFp
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        THIS.this_oBusinessObject = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE
