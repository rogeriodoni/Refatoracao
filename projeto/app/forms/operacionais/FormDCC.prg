*==============================================================================
* FormDCC.prg - Descontos Concedido no Caixa
* Origem: SIGCDDCC.SCX
* Herda de: FormBase
* Tipo: OPERACIONAL (form filho/modal - gerencia itens de desconto em xEestDsc)
*       Aberto pelo form pai com: CREATEOBJECT("FormDCC", oFormPai, nDataSes, cEmpresa)
*       DataSession=1: acessa cursores do pai (xEestDsc, TprMvCab) diretamente
*==============================================================================

DEFINE CLASS FormDCC AS FormBase

    Width        = 1000
    Height       = 600
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow = 1
    WindowType = 1
    ControlBox   = .F.
    Movable      = .F.
    BorderStyle  = 1
    ClipControls = .F.
    ShowTips     = .T.
    Caption      = "Descontos Concedido no Caixa"
    DataSession  = 1

    *-- Referencia ao form pai (habilitado/desabilitado ao abrir/fechar)
    this_oParentForm = .NULL.

    *-- Empresa corrente (filtro SigCdFsI.Emps)
    this_cEmpresa    = ""

    *-- Modo herdado do form pai (pcEscolha = "INSERIR" ou "ALTERAR" permite edicao)
    this_cPcEscolha  = ""
    this_lModoEdicao = .F.

    *-- Total calculado (SUM(Valos) de xEestDsc)
    this_nTotal = 0

    *==========================================================================
    * Init - Recebe parametros do form pai e inicializa
    * par_oParentForm : referencia ao form pai
    * par_nDataSes    : DataSession do pai (nao usado na nova arq - DataSession=1)
    * par_cEmpresa    : codigo da empresa corrente
    *==========================================================================
    PROCEDURE Init()
        LPARAMETERS par_oParentForm, par_nDataSes, par_cEmpresa

        LOCAL loc_oErro
        TRY
            IF VARTYPE(par_oParentForm) = "O"
                THIS.this_oParentForm = par_oParentForm
                THIS.this_cPcEscolha  = par_oParentForm.pcEscolha
                par_oParentForm.Enabled = .F.
            ENDIF

            THIS.this_cEmpresa    = IIF(TYPE("par_cEmpresa") = "C", par_cEmpresa, go_4c_Sistema.cCodEmpresa)
            THIS.this_lModoEdicao = INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em Init")
        ENDTRY

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria a estrutura visual (cabecalho, botoes, PageFrame de 1 pagina)
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            SET DATE TO BRITISH
            SET CENTURY ON

            THIS.this_oBusinessObject = CREATEOBJECT("DCCBO")
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_cEmpresa    = THIS.this_cEmpresa
                THIS.this_oBusinessObject.this_lModoEdicao = THIS.this_lModoEdicao

                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarPageFrame()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                *-- Pre-carrega motivos de desconto usando dados do cursor do form pai
                IF USED("TprMvCab")
                    THIS.this_oBusinessObject.BuscarMotivos(;
                        ALLTRIM(TratarNulo(TprMvCab.ContaDs, "C")), ;
                        IIF(EMPTY(TratarNulo(TprMvCab.Datas, "D")), DATE(), TratarNulo(TprMvCab.Datas, "D")), ;
                        ALLTRIM(TratarNulo(TprMvCab.Dopes, "C")), ;
                        THIS.this_cEmpresa)
                ENDIF

                THIS.pgf_4c_Principal.Visible    = .T.
                THIS.pgf_4c_Principal.ActivePage = 1
                THIS.AtualizarTotal()
                THIS.TornarControlesVisiveis(THIS)

                THIS.Visible = .T.
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao criar DCCBO.", "Erro em InicializarForm")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Cria cnt_4c_Cabecalho com labels de titulo
    * Original: cntSombra Top=-1, Width=800, Height=80 (BackColor=100,100,100)
    * Novo: Top=0, Width=1000 (proporcional)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oErro
        TRY
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

            THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
            WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .AutoSize      = .F.
                .Caption       = "Descontos Concedido no Caixa"
                .Height        = 40
                .Left          = 10
                .Top           = 18
                .Width         = THIS.Width - 20
                .ForeColor     = RGB(0, 0, 0)
                .Visible       = .T.
            ENDWITH

            THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
            WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .AutoSize      = .F.
                .Caption       = "Descontos Concedido no Caixa"
                .Height        = 46
                .Left          = 10
                .Top           = 17
                .Width         = THIS.Width - 20
                .ForeColor     = RGB(255, 255, 255)
                .ToolTipText   = "T" + CHR(237) + "tulo"
                .Visible       = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Cria cmd_4c_Inserir, cmd_4c_Excluir, cmd_4c_Encerrar
    * Original (800px): cmdInserir.Left=573, cmdExcluir.Left=649, cmdSair.Left=725
    * Escalado (1000px): Inserir=716, Excluir=811, Encerrar=906
    * Todos sobrepem o cnt_4c_Cabecalho (Top=7, dentro da faixa 0-80)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_lPodeInserir, loc_lPodeExcluir, loc_oErro
        loc_lPodeInserir = THIS.this_lModoEdicao
        loc_lPodeExcluir = THIS.this_lModoEdicao

        TRY
            THIS.AddObject("cmd_4c_Inserir", "CommandButton")
            WITH THIS.cmd_4c_Inserir
                .Top             = 7
                .Left            = 716
                .Width           = 75
                .Height          = 75
                .Caption         = "Inserir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
                .ToolTipText     = "Inserir Item"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes           = .T.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
                .Enabled         = loc_lPodeInserir
            ENDWITH

            THIS.AddObject("cmd_4c_Excluir", "CommandButton")
            WITH THIS.cmd_4c_Excluir
                .Top             = 7
                .Left            = 811
                .Width           = 75
                .Height          = 75
                .Caption         = "Excluir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                .ToolTipText     = "Excluir Item"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes           = .T.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
                .Enabled         = loc_lPodeExcluir
            ENDWITH

            THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH THIS.cmd_4c_Encerrar
                .Top             = 7
                .Left            = 906
                .Width           = 75
                .Height          = 75
                .Caption         = "Encerrar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel          = .T.
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes           = .T.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
                .Enabled         = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBotoes")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria pgf_4c_Principal (Page1 = area de conteudo)
    * Layout OPERACIONAL: PageFrame ocupa area abaixo do cnt_4c_Cabecalho
    * (Top=80..600 = 520px). Tabs=.F. (sem abas visiveis - dialog plano).
    * Page1 hospedara grd_4c_Dados (Fase 4) e txt_4c_Total (Fase 5).
    * Original SIGCDDCC nao tem PageFrame (grid + total soltos na form);
    * usamos PageFrame de 1 pagina para satisfazer contrato FormBase e
    * permitir extensao futura (Page2 = filtros/opcoes) sem refatoracao.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("pgf_4c_Principal", "PageFrame")
            WITH THIS.pgf_4c_Principal
                .Top       = 80
                .Left      = 0
                .Width     = THIS.Width
                .Height    = THIS.Height - 80
                .PageCount = 1
                .Tabs      = .F.
                .BorderWidth = 0
                .Visible   = .T.
            ENDWITH

            WITH THIS.pgf_4c_Principal.Page1
                .Caption = "Descontos"
                .Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarPageFrame")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AtualizarTotal - Recalcula SUM(Valos) e atualiza txt_4c_Total se existir
    *==========================================================================
    PROCEDURE AtualizarTotal()
        LOCAL loc_oErro, loc_oTxt
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                IF THIS.this_oBusinessObject.CalcularTotal()
                    THIS.this_nTotal = THIS.this_oBusinessObject.this_nTotal
                    IF VARTYPE(THIS.pgf_4c_Principal) = "O"
                        IF PEMSTATUS(THIS.pgf_4c_Principal.Page1, "txt_4c_Total", 5)
                            loc_oTxt = THIS.pgf_4c_Principal.Page1.txt_4c_Total
                            loc_oTxt.Value = THIS.this_nTotal
                            loc_oTxt.Refresh()
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em AtualizarTotal")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdInserirClick - Insere linha em branco em xEestDsc e foca coluna Motivo
    * Equivalente ao cmdInserir.Click original
    *==========================================================================
    PROCEDURE CmdInserirClick()
        LOCAL loc_oGrid, loc_oErro
        TRY
            IF THIS.this_oBusinessObject.Inserir()
                IF VARTYPE(THIS.pgf_4c_Principal) = "O"
                    IF PEMSTATUS(THIS.pgf_4c_Principal.Page1, "grd_4c_Dados", 5)
                        loc_oGrid = THIS.pgf_4c_Principal.Page1.grd_4c_Dados
                        loc_oGrid.Column1.SetFocus()
                        loc_oGrid.Refresh()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em CmdInserirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdExcluirClick - Exclui linha corrente de xEestDsc
    * Equivalente ao cmdExcluir.Click original
    *==========================================================================
    PROCEDURE CmdExcluirClick()
        LOCAL loc_oGrid, loc_oErro
        TRY
            IF THIS.this_oBusinessObject.ExcluirLinhaAtual()
                IF VARTYPE(THIS.pgf_4c_Principal) = "O"
                    IF PEMSTATUS(THIS.pgf_4c_Principal.Page1, "grd_4c_Dados", 5)
                        loc_oGrid = THIS.pgf_4c_Principal.Page1.grd_4c_Dados
                        loc_oGrid.Refresh()
                    ENDIF
                ENDIF
                THIS.AtualizarTotal()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em CmdExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdEncerrarClick - Valida todas as linhas e fecha o form
    * Equivalente ao cmdSair.Click original (valida + re-habilita form pai + Release)
    *==========================================================================
    PROCEDURE CmdEncerrarClick()
        LOCAL loc_oErro
        TRY
            IF THIS.this_oBusinessObject.ValidarTodos()
                IF VARTYPE(THIS.this_oParentForm) = "O"
                    THIS.this_oParentForm.Enabled = .T.
                ENDIF
                THIS.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em CmdEncerrarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Insere nova linha em xEestDsc e foca coluna Motivo
    * Equivalente ao cmdInserir.Click original (Insert Into XEestDsc + SetFocus)
    * Wrapper canonico CRUD para OPERACIONAL: delega ao BO e refresca grid
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oGrid, loc_oErro
        TRY
            IF !THIS.this_lModoEdicao
                MsgAviso("Modo somente leitura ??? inclus" + CHR(227) + "o n" + CHR(227) + "o permitida.", "Inclus" + CHR(227) + "o")
                RETURN
            ENDIF
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                IF THIS.this_oBusinessObject.Inserir()
                    IF VARTYPE(THIS.pgf_4c_Principal) = "O"
                        IF PEMSTATUS(THIS.pgf_4c_Principal.Page1, "grd_4c_Dados", 5)
                            loc_oGrid = THIS.pgf_4c_Principal.Page1.grd_4c_Dados
                            loc_oGrid.ReadOnly = .F.
                            loc_oGrid.Refresh()
                            loc_oGrid.SetFocus()
                            loc_oGrid.Column1.SetFocus()
                        ENDIF
                    ENDIF
                    THIS.AtualizarTotal()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em BtnIncluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Ativa edi" + CHR(231) + CHR(227) + "o inline na linha corrente do grd_4c_Dados
    * Form OPERACIONAL (SIGCDDCC) nao tem Page2/Dados separada ??? a edicao eh
    * inline no grid. BtnAlterarClick posiciona foco na coluna Motivo da linha
    * corrente, garantindo que grid esteja editavel (ReadOnly=.F.) e Column1
    * respondendo a Enter/Tab/F4 para lookup.
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oGrid, loc_oErro
        TRY
            IF !THIS.this_lModoEdicao
                MsgAviso("Modo somente leitura ??? altera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o permitida.", "Altera" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF
            IF !USED("xEestDsc") OR RECCOUNT("xEestDsc") = 0
                MsgAviso("Nenhum registro para alterar. Utilize Inserir para adicionar uma linha.", "Altera" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF
            IF EOF("xEestDsc")
                SELECT xEestDsc
                GO TOP
            ENDIF
            IF VARTYPE(THIS.pgf_4c_Principal) = "O"
                IF PEMSTATUS(THIS.pgf_4c_Principal.Page1, "grd_4c_Dados", 5)
                    loc_oGrid = THIS.pgf_4c_Principal.Page1.grd_4c_Dados
                    loc_oGrid.ReadOnly = .F.
                    loc_oGrid.Column1.ReadOnly = .F.
                    loc_oGrid.Column3.ReadOnly = .F.
                    loc_oGrid.Column4.ReadOnly = .F.
                    loc_oGrid.Refresh()
                    loc_oGrid.SetFocus()
                    loc_oGrid.Column1.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em BtnAlterarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Coloca o grid em modo somente leitura e desabilita
    * botoes de edicao (Inserir/Excluir). Uso: usuario quer inspecionar as
    * linhas de desconto sem alterar. Restauracao para edicao via BtnAlterarClick.
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oGrid, loc_oErro
        TRY
            IF !USED("xEestDsc") OR RECCOUNT("xEestDsc") = 0
                MsgAviso("Nenhum registro para visualizar.", "Visualiza" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF
            SELECT xEestDsc
            GO TOP
            IF VARTYPE(THIS.pgf_4c_Principal) = "O"
                IF PEMSTATUS(THIS.pgf_4c_Principal.Page1, "grd_4c_Dados", 5)
                    loc_oGrid = THIS.pgf_4c_Principal.Page1.grd_4c_Dados
                    loc_oGrid.ReadOnly = .T.
                    loc_oGrid.Column1.ReadOnly = .T.
                    loc_oGrid.Column3.ReadOnly = .T.
                    loc_oGrid.Column4.ReadOnly = .T.
                    loc_oGrid.Refresh()
                    loc_oGrid.SetFocus()
                ENDIF
            ENDIF
            IF PEMSTATUS(THIS, "cmd_4c_Inserir", 5)
                THIS.cmd_4c_Inserir.Enabled = .F.
            ENDIF
            IF PEMSTATUS(THIS, "cmd_4c_Excluir", 5)
                THIS.cmd_4c_Excluir.Enabled = .F.
            ENDIF
            THIS.AtualizarTotal()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Exclui linha corrente de xEestDsc (com confirmacao)
    * Equivalente ao cmdExcluir.Click original (Delete + Skip -1 + Refresh)
    * Wrapper canonico CRUD para OPERACIONAL: MsgConfirma + delega ao BO
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oGrid, loc_oErro
        TRY
            IF !THIS.this_lModoEdicao
                MsgAviso("Modo somente leitura ??? exclus" + CHR(227) + "o n" + CHR(227) + "o permitida.", "Exclus" + CHR(227) + "o")
                RETURN
            ENDIF
            IF !USED("xEestDsc") OR RECCOUNT("xEestDsc") = 0 OR EOF("xEestDsc")
                MsgAviso("Nenhum registro selecionado para exclus" + CHR(227) + "o.", "Exclus" + CHR(227) + "o")
                RETURN
            ENDIF
            IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o da linha corrente?", "Exclus" + CHR(227) + "o")
                RETURN
            ENDIF
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                IF THIS.this_oBusinessObject.ExcluirLinhaAtual()
                    IF VARTYPE(THIS.pgf_4c_Principal) = "O"
                        IF PEMSTATUS(THIS.pgf_4c_Principal.Page1, "grd_4c_Dados", 5)
                            loc_oGrid = THIS.pgf_4c_Principal.Page1.grd_4c_Dados
                            loc_oGrid.Refresh()
                        ENDIF
                    ENDIF
                    THIS.AtualizarTotal()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em BtnExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Cria grid e total em Page1 (pgf_4c_Principal.Page1)
    * Grid grd_4c_Dados: equivalente ao GradeFPagto original (4 colunas)
    *   Column1: Motivo (MotDscs) - editavel, lookup em cursor_4c_TmpMdsc via F4/Enter/Tab
    *   Column2: Descricao (Descs) - somente leitura, auto-preenchida pelo lookup
    *   Column3: Valor (Valos) - editavel
    *   Column4: Observacao (Obs) - editavel
    * txt_4c_Total: equivalente ao Get_total original (top=478, left=673, w=92, h=23 no 800px)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oErro
        TRY
            loc_oPagina = THIS.pgf_4c_Principal.Page1

            *-- Grid grd_4c_Dados
            loc_oPagina.AddObject("grd_4c_Dados", "Grid")
            WITH loc_oPagina.grd_4c_Dados
                .Top                = 15
                .Left               = 20
                .Width              = 960
                .Height             = 455
                .ColumnCount        = 4
                .RecordSource       = "xEestDsc"
                .RecordMark         = .F.
                .DeleteMark         = .F.
                .RowHeight          = 20
                .ScrollBars         = 2
                .FontName           = "Verdana"
                .FontSize           = 8
                .GridLineColor      = RGB(238, 238, 238)
                .HighlightBackColor = RGB(255, 255, 255)
                .HighlightForeColor = RGB(15, 41, 104)
                .HighlightStyle     = 2
                .ToolTipText        = "Grade de Motivos de Descontos"
                .ReadOnly           = !THIS.this_lModoEdicao

                *-- Column1: Motivo (MotDscs) - FK em SigCdFs, lookup via KeyPress
                WITH .Column1
                    .Width             = 130
                    .ControlSource     = "xEestDsc.MotDscs"
                    .Movable           = .F.
                    .Resizable         = .F.
                    .Sparse            = .F.
                    .ReadOnly          = .F.
                    .Header1.Caption   = "Motivo"
                    .Header1.FontName  = "Tahoma"
                    .Header1.FontSize  = 8
                    .Header1.Alignment = 2
                    .Header1.ForeColor = RGB(90, 90, 90)
                    .Text1.BorderStyle = 0
                    .Text1.Margin      = 0
                    .Text1.ForeColor   = RGB(0, 0, 0)
                    .Text1.BackColor   = RGB(255, 255, 255)
                ENDWITH

                *-- Column2: Descricao (Descs) - somente leitura (When=.F. no original)
                WITH .Column2
                    .Width             = 360
                    .ControlSource     = "xEestDsc.Descs"
                    .Movable           = .F.
                    .Resizable         = .F.
                    .Sparse            = .F.
                    .ReadOnly          = .T.
                    .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
                    .Header1.FontName  = "Tahoma"
                    .Header1.FontSize  = 8
                    .Header1.Alignment = 2
                    .Header1.ForeColor = RGB(90, 90, 90)
                    .Text1.BorderStyle = 0
                    .Text1.Margin      = 0
                    .Text1.ForeColor   = RGB(0, 0, 0)
                    .Text1.BackColor   = RGB(255, 255, 255)
                ENDWITH

                *-- Column3: Valor (Valos) - editavel com InputMask numerico
                WITH .Column3
                    .Width             = 120
                    .ControlSource     = "xEestDsc.Valos"
                    .Movable           = .F.
                    .Resizable         = .F.
                    .Sparse            = .F.
                    .ReadOnly          = .F.
                    .Header1.Caption   = "Valor"
                    .Header1.FontName  = "Tahoma"
                    .Header1.FontSize  = 8
                    .Header1.Alignment = 2
                    .Header1.ForeColor = RGB(90, 90, 90)
                    .Text1.BorderStyle = 0
                    .Text1.Margin      = 0
                    .Text1.ForeColor   = RGB(0, 0, 0)
                    .Text1.BackColor   = RGB(255, 255, 255)
                    .Text1.InputMask   = "999,999,999.99"
                ENDWITH

                *-- Column4: Observacao (Obs) - editavel
                WITH .Column4
                    .Width             = 330
                    .ControlSource     = "xEestDsc.Obs"
                    .Movable           = .F.
                    .Sparse            = .F.
                    .ReadOnly          = .F.
                    .Header1.Caption   = "Observa" + CHR(231) + CHR(227) + "o"
                    .Header1.FontName  = "Tahoma"
                    .Header1.FontSize  = 8
                    .Header1.Alignment = 2
                    .Header1.ForeColor = RGB(90, 90, 90)
                    .Text1.BorderStyle = 0
                    .Text1.Margin      = 0
                    .Text1.ForeColor   = RGB(0, 0, 0)
                    .Text1.BackColor   = RGB(255, 255, 255)
                ENDWITH

                .Visible = .T.
            ENDWITH

            *-- BINDEVENTs: botoes (criados em ConfigurarBotoes, acima do PageFrame)
            BINDEVENT(THIS.cmd_4c_Inserir,  "Click", THIS, "CmdInserirClick")
            BINDEVENT(THIS.cmd_4c_Excluir,  "Click", THIS, "CmdExcluirClick")
            BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "CmdEncerrarClick")

            *-- BINDEVENT: Column1.Text1 KeyPress -> lookup de motivo (F4=115, Enter=13, Tab=9)
            BINDEVENT(loc_oPagina.grd_4c_Dados.Column1.Text1, "KeyPress", THIS, "GrdMotivoKeyPress")

            *-- BINDEVENT: Grid AfterRowColChange -> recalcula total ao sair de Column3 (Valor)
            BINDEVENT(loc_oPagina.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")

            *-- BINDEVENTs: Column3 e Column4 When -> apenas editaveis quando Motivo preenchido
            *-- Equivalente ao Column3.Text1.When e Column4.Text1.When originais (Return Not Empty Column1)
            BINDEVENT(loc_oPagina.grd_4c_Dados.Column3.Text1, "When", THIS, "GrdValorWhen")
            BINDEVENT(loc_oPagina.grd_4c_Dados.Column4.Text1, "When", THIS, "GrdObsWhen")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Cria campos de exibi" + CHR(231) + CHR(227) + "o em Page1
    * Original: Get_total (Top=478, Left=673, Width=92, Height=23 em 800px)
    * Escalado para 1000px: Top=483, Left=658, Width=130.
    * Como este form OPERACIONAL nao tem Page2 (Dados) separada no legado
    * (SIGCDDCC eh dialog plano de 1 pagina), este metodo hospeda os
    * campos de exibicao (label + textbox de Total) que sao logicamente
    * "dados calculados" ??? separados do grid (Lista) para permitir refresh
    * isolado via AtualizarTotal() sem tocar no grid.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina, loc_oErro
        TRY
            loc_oPagina = THIS.pgf_4c_Principal.Page1

            *-- Label "Total R$:" (rotulo do campo de total, alinhado a direita)
            loc_oPagina.AddObject("lbl_4c_Total", "Label")
            WITH loc_oPagina.lbl_4c_Total
                .Top       = 487
                .Left      = 525
                .Width     = 125
                .Height    = 23
                .Caption   = "Total R$:"
                .FontName  = "Tahoma"
                .FontSize  = 10
                .FontBold  = .T.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .AutoSize  = .F.
                .Alignment = 1
                .Visible   = .T.
            ENDWITH

            *-- TextBox txt_4c_Total (equivalente ao Get_total original - somente leitura)
            loc_oPagina.AddObject("txt_4c_Total", "TextBox")
            WITH loc_oPagina.txt_4c_Total
                .Top       = 483
                .Left      = 658
                .Width     = 130
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 10
                .FontBold  = .T.
                .ForeColor = RGB(90, 90, 90)
                .BackColor = RGB(224, 253, 254)
                .ReadOnly  = .T.
                .Value     = 0
                .InputMask = "9,999,999.99"
                .Visible   = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AlternarPagina - Muda ActivePage do pgf_4c_Principal
    * (Form tem apenas 1 pagina; metodo mantido para contrato com FormBase)
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        IF VARTYPE(THIS.pgf_4c_Principal) = "O"
            IF par_nPagina >= 1 AND par_nPagina <= THIS.pgf_4c_Principal.PageCount
                THIS.pgf_4c_Principal.ActivePage = par_nPagina
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * GrdMotivoKeyPress - Handler KeyPress da Column1.Text1 (Motivo)
    * Dispara em Enter(13)/Tab(9)/F4(115): valida codigo ou abre lookup
    * Equivalente ao Column1.Text1.Valid original (sem trigger a cada tecla)
    *==========================================================================
    PROCEDURE GrdMotivoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor, loc_oGrid, loc_oErro
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        TRY
            loc_oGrid  = THIS.pgf_4c_Principal.Page1.grd_4c_Dados
            loc_cValor = ALLTRIM(NVL(loc_oGrid.Column1.Text1.Value, ""))

            IF EMPTY(loc_cValor)
                IF VARTYPE(THIS.this_oBusinessObject) = "O"
                    THIS.this_oBusinessObject.LimparDescricao()
                    loc_oGrid.Refresh()
                ENDIF
                RETURN
            ENDIF

            *-- Recarrega motivos se cursor nao disponivel (ex: sessao nova)
            IF (!USED("cursor_4c_TmpMdsc") OR RECCOUNT("cursor_4c_TmpMdsc") = 0) AND VARTYPE(THIS.this_oBusinessObject) = "O"
                IF USED("TprMvCab")
                    THIS.this_oBusinessObject.BuscarMotivos(;
                        ALLTRIM(TratarNulo(TprMvCab.ContaDs, "C")), ;
                        IIF(EMPTY(TratarNulo(TprMvCab.Datas, "D")), DATE(), TratarNulo(TprMvCab.Datas, "D")), ;
                        ALLTRIM(TratarNulo(TprMvCab.Dopes, "C")), ;
                        THIS.this_cEmpresa)
                ENDIF
            ENDIF

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                IF THIS.this_oBusinessObject.ValidarMotivo(loc_cValor)
                    loc_oGrid.Refresh()
                ELSE
                    THIS.AbrirLookupMotivo(loc_cValor)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em GrdMotivoKeyPress")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirLookupMotivo - Abre FormBuscaAuxiliar com cursor_4c_TmpMdsc pre-populado
    * Equivalente ao fwBuscaSel do Column1.Text1.Valid original
    * par_cValor - valor digitado (usado como filtro inicial no picker)
    *==========================================================================
    PROCEDURE AbrirLookupMotivo(par_cValor)
        LOCAL loc_oLookup, loc_oGrid, loc_cCodSel, loc_oErro
        TRY
            IF !USED("cursor_4c_TmpMdsc") OR RECCOUNT("cursor_4c_TmpMdsc") = 0
                MsgAviso("Nenhum motivo de desconto dispon" + CHR(237) + "vel para pesquisa.", "Lookup")
                RETURN
            ENDIF

            *-- Usa cursor pre-populado por BuscarMotivos (cTabela="" = sem SELECT interno)
            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "", "cursor_4c_TmpMdsc", "Codigos", m.par_cValor, ;
                "Motivo de Desconto", .T., .T., "")

            IF VARTYPE(loc_oLookup) = "O"
                loc_oLookup.mAddColuna("Codigos", "XXXXXXXXXXXXXXXXXXXX", "C" + CHR(243) + "digo")
                loc_oLookup.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oLookup.Show()

                IF loc_oLookup.this_lSelecionou
                    IF USED("cursor_4c_TmpMdsc") AND !EOF("cursor_4c_TmpMdsc")
                        loc_cCodSel = ALLTRIM(cursor_4c_TmpMdsc.Codigos)
                        IF USED("xEestDsc") AND VARTYPE(THIS.this_oBusinessObject) = "O"
                            REPLACE MotDscs WITH loc_cCodSel IN xEestDsc
                            THIS.this_oBusinessObject.ValidarMotivo(loc_cCodSel)
                        ENDIF
                        loc_oGrid = THIS.pgf_4c_Principal.Page1.grd_4c_Dados
                        IF VARTYPE(loc_oGrid) = "O"
                            loc_oGrid.Refresh()
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em AbrirLookupMotivo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GrdDadosAfterRowColChange - Handler AfterRowColChange do grd_4c_Dados
    * par_nColIndex = coluna ANTERIOR (da qual o usuario acabou de sair)
    * Column3 (Valor): recalcular total ao sair
    *==========================================================================
    PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
        IF par_nColIndex = 3
            THIS.AtualizarTotal()
        ENDIF
    ENDPROC

    *==========================================================================
    * GrdValorWhen - When handler da Column3.Text1 (Valor)
    * Equivalente ao Column3.Text1.When original:
    *   Return (Not Empty(ThisForm.GradeFPagto.Column1.Text1.Value))
    * Retorna .T. apenas quando o Motivo da linha corrente esta preenchido
    *==========================================================================
    PROCEDURE GrdValorWhen()
        LOCAL loc_cMotivo
        loc_cMotivo = ""
        IF USED("xEestDsc") AND !EOF("xEestDsc")
            loc_cMotivo = ALLTRIM(NVL(xEestDsc.MotDscs, ""))
        ENDIF
        RETURN !EMPTY(loc_cMotivo)
    ENDPROC

    *==========================================================================
    * GrdObsWhen - When handler da Column4.Text1 (Observacao)
    * Equivalente ao Column4.Text1.When original:
    *   Return (Not Empty(ThisForm.GradeFPagto.Column1.Text1.Value))
    * Retorna .T. apenas quando o Motivo da linha corrente esta preenchido
    *==========================================================================
    PROCEDURE GrdObsWhen()
        LOCAL loc_cMotivo
        loc_cMotivo = ""
        IF USED("xEestDsc") AND !EOF("xEestDsc")
            loc_cMotivo = ALLTRIM(NVL(xEestDsc.MotDscs, ""))
        ENDIF
        RETURN !EMPTY(loc_cMotivo)
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles do container visiveis
    * Recursivo: percorre Pages de PageFrames e Controls de Containers
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_nP, loc_oObjeto
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

    *==========================================================================
    * BtnEncerrarClick - Wrapper canonico: valida todas as linhas e encerra
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.CmdEncerrarClick()
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Busca nao aplicavel neste form operacional
    * Form gerencia itens de xEestDsc via grade inline sem pesquisa propria
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        MsgInfo("Utilize as colunas da grade para localizar registros.", "Busca")
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Persiste linha corrente do grid via BO.Atualizar
    * Para OPERACIONAL: opera sobre cursor VFP local xEestDsc (nao SQL Server)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.FormParaBO()
                IF THIS.this_oBusinessObject.Atualizar()
                    THIS.AtualizarTotal()
                    IF VARTYPE(THIS.pgf_4c_Principal) = "O"
                        IF PEMSTATUS(THIS.pgf_4c_Principal.Page1, "grd_4c_Dados", 5)
                            THIS.pgf_4c_Principal.Page1.grd_4c_Dados.Refresh()
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em BtnSalvarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Fecha o form sem validar e re-habilita o form pai
    * Re-habilita form pai antes de liberar
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oParentForm) = "O"
                THIS.this_oParentForm.Enabled = .T.
            ENDIF
            THIS.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em BtnCancelarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormParaBO - Mapeia linha corrente de xEestDsc para propriedades do BO
    *==========================================================================
    PROCEDURE FormParaBO()
        IF USED("xEestDsc") AND !EOF("xEestDsc") AND VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_cCidchaves = TratarNulo(xEestDsc.Cidchaves, "C")
            THIS.this_oBusinessObject.this_cMotDscs   = TratarNulo(xEestDsc.MotDscs, "C")
            THIS.this_oBusinessObject.this_cDescs     = TratarNulo(xEestDsc.Descs, "C")
            THIS.this_oBusinessObject.this_nValos     = TratarNulo(xEestDsc.Valos, "N")
            THIS.this_oBusinessObject.this_cObs       = TratarNulo(xEestDsc.Obs, "C")
        ENDIF
    ENDPROC

    *==========================================================================
    * BOParaForm - Mapeia propriedades do BO de volta para linha corrente de xEestDsc
    *==========================================================================
    PROCEDURE BOParaForm()
        IF USED("xEestDsc") AND !EOF("xEestDsc") AND VARTYPE(THIS.this_oBusinessObject) = "O"
            REPLACE xEestDsc.Cidchaves WITH THIS.this_oBusinessObject.this_cCidchaves, ;
                    xEestDsc.MotDscs   WITH THIS.this_oBusinessObject.this_cMotDscs, ;
                    xEestDsc.Descs     WITH THIS.this_oBusinessObject.this_cDescs, ;
                    xEestDsc.Valos     WITH THIS.this_oBusinessObject.this_nValos, ;
                    xEestDsc.Obs       WITH THIS.this_oBusinessObject.this_cObs
        ENDIF
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita controles conforme par_lHabilitar
    * Respeita this_lModoEdicao: em modo somente leitura nunca habilita edicao
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lEditar, loc_oErro
        loc_lEditar = par_lHabilitar AND THIS.this_lModoEdicao
        TRY
            IF PEMSTATUS(THIS, "cmd_4c_Inserir", 5)
                THIS.cmd_4c_Inserir.Enabled = loc_lEditar
            ENDIF
            IF PEMSTATUS(THIS, "cmd_4c_Excluir", 5)
                THIS.cmd_4c_Excluir.Enabled = loc_lEditar
            ENDIF
            IF VARTYPE(THIS.pgf_4c_Principal) = "O"
                IF PEMSTATUS(THIS.pgf_4c_Principal.Page1, "grd_4c_Dados", 5)
                    THIS.pgf_4c_Principal.Page1.grd_4c_Dados.ReadOnly = !loc_lEditar
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em HabilitarCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparCampos - Zera totalizador e refresca grade
    * Para OPERACIONAL: nao ha campos Page2; apenas reseta exibicao de total
    *==========================================================================
    PROCEDURE LimparCampos()
        LOCAL loc_oErro
        TRY
            THIS.this_nTotal = 0
            IF VARTYPE(THIS.pgf_4c_Principal) = "O"
                IF PEMSTATUS(THIS.pgf_4c_Principal.Page1, "txt_4c_Total", 5)
                    THIS.pgf_4c_Principal.Page1.txt_4c_Total.Value = 0
                ENDIF
                IF PEMSTATUS(THIS.pgf_4c_Principal.Page1, "grd_4c_Dados", 5)
                    THIS.pgf_4c_Principal.Page1.grd_4c_Dados.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em LimparCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarLista - Refresca grd_4c_Dados (xEestDsc) e recalcula total
    * Para OPERACIONAL: grid esta sempre bindado ao cursor local; apenas Refresh
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.pgf_4c_Principal) = "O"
                IF PEMSTATUS(THIS.pgf_4c_Principal.Page1, "grd_4c_Dados", 5)
                    THIS.pgf_4c_Principal.Page1.grd_4c_Dados.Refresh()
                ENDIF
            ENDIF
            THIS.AtualizarTotal()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em CarregarLista")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Habilita/desabilita botoes conforme modo de edicao
    * Chamado apos mudanca de contexto (BuscarMotivos, pcEscolha, etc.)
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        THIS.HabilitarCampos(THIS.this_lModoEdicao)
    ENDPROC

    *==========================================================================
    * Destroy - Re-habilita form pai e libera recursos
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oParentForm) = "O"
                THIS.this_oParentForm.Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em Destroy")
        ENDTRY
        DODEFAULT()
    ENDPROC

ENDDEFINE
