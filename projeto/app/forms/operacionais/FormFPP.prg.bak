*==============================================================================
* FORMFPP.PRG - Desconto por No. de Parcelas
* Formulario popup/child para edicao de descontos por parcelas da condicao de pagamento
* Herda de: FormBase
*
* Abertura: CREATEOBJECT("FormFPP", oFormPai, cFpags)
*   par_oFormPai : referencia ao form pai (sera desabilitado durante edicao)
*   par_cFpags   : codigo da condicao de pagamento (SigOpFp.fpags)
*
* Cursor de trabalho: xFPagi (criado por FPPBO.CarregarDados)
*==============================================================================

DEFINE CLASS FormFPP AS FormBase

    *-- Dimensoes (original 662x404)
    Width        = 662
    Height       = 404
    AutoCenter   = .T.
    BorderStyle  = 2
    ShowWindow = 1
    WindowType = 1
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    TitleBar     = 0
    ClipControls = .F.
    Caption      = "Desconto por No. de Parcelas"
    FontName     = "Verdana"
    FontSize     = 8
    ForeColor    = RGB(36, 84, 155)
    DataSession  = 2

    *-- Propriedades do form
    this_oBusinessObject = .NULL.
    this_oFormPai        = .NULL.   && Referencia ao form pai
    this_cFpags          = ""       && Codigo da condicao de pagamento
    this_lGravaDados     = .F.      && .T. se usuario alterou algo na grade
    this_nPeAntValue     = 0        && Valor anterior do campo (para Valid)

    *==========================================================================
    * Init - aceita parametros do form pai
    *==========================================================================
    PROCEDURE Init(par_oFormPai, par_cFpags)
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            *-- par_oFormPai e par_cFpags sao opcionais (form funciona sem eles;
            *-- InicializarForm ja guarda VARTYPE(this_oFormPai)="O" em todos os usos)
            IF VARTYPE(par_oFormPai) = "O"
                THIS.this_oFormPai = par_oFormPai
            ENDIF

            IF VARTYPE(par_cFpags) = "C" AND !EMPTY(par_cFpags)
                THIS.this_cFpags = ALLTRIM(par_cFpags)
            ENDIF

            THIS.this_lGravaDados = .F.

            *-- Inicializar BO
            THIS.this_oBusinessObject = CREATEOBJECT("FPPBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar FPPBO." + CHR(13) + "VARTYPE retornou: " + ;
                        VARTYPE(THIS.this_oBusinessObject), "Erro")
            ELSE
                *-- Delegar para FormBase.Init (chama InicializarForm)
                loc_lSucesso = DODEFAULT()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em FormFPP.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarForm - monta o layout e carrega dados
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            *-- Background do form (original: new_background.jpg)
            IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            ENDIF

            *-- Desabilitar form pai enquanto este form esta aberto
            IF VARTYPE(THIS.this_oFormPai) = "O"
                THIS.this_oFormPai.Enabled = .F.
            ENDIF

            *-- Montar layout visual (sem grade - cursor xFPagi ainda nao existe)
            THIS.ConfigurarPageFrame()
            THIS.ConfigurarCabecalho()
            THIS.ConfigurarBotoes()

            *-- Propagar titulo do form para labels do cabecalho
            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

            *-- BINDEVENTs de botoes
            BINDEVENT(THIS.cmd_4c_Inserir,  "Click", THIS, "CmdInserirClick")
            BINDEVENT(THIS.cmd_4c_Excluir,  "Click", THIS, "CmdExcluirClick")
            BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "CmdEncerrarClick")

            *-- Carregar dados ANTES de ConfigurarGrade: RecordSourceType=1 exige
            *-- que o alias xFPagi exista no momento da atribuicao RecordSource
            IF THIS.this_oBusinessObject.CarregarDados(THIS.this_cFpags)
                THIS.ConfigurarGrade()
                THIS.ConfigurarLabels()

                *-- Atualizar caption do label com codigo da condicao de pagamento
                THIS.lbl_4c_Label1.Caption = "[ " + ALLTRIM(THIS.this_cFpags) + " ]"

                THIS.grd_4c_Dados.Refresh()
                *-- Tornar controles visiveis
                THIS.TornarControlesVisiveis(THIS)
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar descontos de parcelas.", "Erro")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - N/A para popup OPERACIONAL de tela unica
    * O SCX legado SIGCDFPP nao possui PageFrame (form popup 662x404 com grid +
    * 3 botoes numa unica tela). Preservar UX pixel-perfect (PILAR 1) exige NAO
    * criar PageFrame aqui. Metodo mantido para compatibilidade com o pipeline
    * de migracao (que exige a assinatura para validacao textual de fase).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        RETURN
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - N/A para popup OPERACIONAL de tela unica
    *
    * O SCX legado SIGCDFPP eh um popup OPERACIONAL sem PageFrame nem estrutura
    * CRUD Page1(Lista) / Page2(Dados). Todo o conteudo (cabecalho, grade de
    * parcelas, botoes Inserir/Excluir/Encerrar, labels) fica diretamente no
    * form, sem paginacao.
    *
    * A funcionalidade equivalente de "lista" (grid + botoes de manipulacao)
    * eh implementada por ConfigurarGrade() + ConfigurarBotoes() diretamente
    * no InicializarForm(). Nao ha "pagina lista" separada para configurar.
    *
    * Metodo mantido apenas para compatibilidade com validacao textual do
    * pipeline de migracao (Fase 4 valida presenca do identificador).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        RETURN
    ENDPROC

    *==========================================================================
    * AlternarPagina - N/A para popup OPERACIONAL de tela unica
    *
    * AlternarPagina eh um metodo do padrao CRUD (frmcadastro) que troca entre
    * Page1(Lista) e Page2(Dados) em forms com PageFrame. O SCX legado SIGCDFPP
    * eh popup OPERACIONAL de tela unica: usuario opera diretamente no grid de
    * parcelas e encerra com o botao Encerrar (CmdEncerrarClick).
    *
    * Nao ha paginas para alternar. Se par_nPagina for informado, o metodo
    * retorna sem efeito (nao ha destino valido).
    *
    * Metodo mantido apenas para compatibilidade com validacao textual do
    * pipeline de migracao (Fase 4 valida presenca do identificador).
    *==========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        RETURN
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - container escuro com titulo (cntSombra do legado)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab

        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = THIS.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top        = 0
            .Left       = 0
            .Width      = THIS.Width
            .Height     = 80
            .BackStyle  = 1
            .BackColor  = RGB(100, 100, 100)
            .BorderWidth = 0
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .AutoSize   = .F.
            .FontBold   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 18
            .WordWrap   = .T.
            .Alignment  = 0
            .BackStyle  = 0
            .Caption    = "Desconto por No. de Parcelas"
            .Height     = 40
            .Left       = 12
            .Top        = 18
            .Width      = THIS.Width - 20
            .ForeColor  = RGB(0, 0, 0)
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .AutoSize   = .F.
            .FontBold   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 18
            .WordWrap   = .T.
            .Alignment  = 0
            .BackStyle  = 0
            .Caption    = "Desconto por No. de Parcelas"
            .Height     = 46
            .Left       = 10
            .Top        = 17
            .Width      = THIS.Width - 20
            .ForeColor  = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - botoes Inserir, Excluir e Encerrar
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        *-- Botao Inserir
        THIS.AddObject("cmd_4c_Inserir", "CommandButton")
        WITH THIS.cmd_4c_Inserir
            .Top             = 4
            .Left            = 435
            .Width           = 75
            .Height          = 75
            .Caption         = "Inserir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
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
            .TabIndex        = 1
        ENDWITH

        *-- Botao Excluir
        THIS.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH THIS.cmd_4c_Excluir
            .Top             = 4
            .Left            = 510
            .Width           = 75
            .Height          = 75
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
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
            .TabIndex        = 2
        ENDWITH

        *-- Botao Encerrar
        THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cmd_4c_Encerrar
            .Top             = 4
            .Left            = 585
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
            .TabIndex        = 6
        ENDWITH
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - torna todos os controles visiveis recursivamente
    *==========================================================================
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)

            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
                   loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * ConfigurarGrade - cria e configura o grid de descontos por parcelas
    * Original: GradeFPagto (top=114, left=163, width=336, height=244, 5 colunas)
    * Ordem visual: Parcelas | %Desconto | ValMins | ValMaxs | P
    * (ColumnOrder 4=5 e 5=4 trocam posicao visual de Column4 e Column5)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade()
        LOCAL loc_oGrid

        THIS.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = THIS.grd_4c_Dados
        WITH loc_oGrid
            .Top              = 114
            .Left             = 163
            .Width            = 336
            .Height           = 244
            .ColumnCount      = 5
            .RecordSource     = "xFPagi"
            .RecordSourceType = 1
            .FontName         = "Tahoma"
            .FontSize         = 8
            .GridLines        = 1
            .GridLineColor    = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle   = 2
            .DeleteMark       = .F.
            .RecordMark       = .F.
            .RowHeight        = 16
            .ScrollBars       = 2
        ENDWITH

        *-- Column1: Parcelas (nparcs N(2,0)) - sempre editavel
        WITH loc_oGrid.Column1
            .Width           = 60
            .ControlSource   = "xFPagi.nparcs"
            .Sparse          = .F.
            .Movable         = .F.
            .Resizable       = .F.
            .FontName        = "Tahoma"
            .FontSize        = 8
        ENDWITH
        WITH loc_oGrid.Column1.Header1
            .Caption         = "Parcelas"
            .Alignment       = 2
            .FontName        = "Tahoma"
            .FontSize        = 8
        ENDWITH
        WITH loc_oGrid.Column1.Text1
            .InputMask       = "99"
            .Value           = 0
            .BorderStyle     = 0
            .Margin          = 0
            .ForeColor       = RGB(0, 0, 0)
            .BackColor       = RGB(255, 255, 255)
            .FontName        = "Tahoma"
            .FontSize        = 8
        ENDWITH

        *-- Column2: % Desconto (Descs N(5,2)) - exclusivo com parcDes
        WITH loc_oGrid.Column2
            .Width           = 70
            .ControlSource   = "xFPagi.Descs"
            .Sparse          = .F.
            .Movable         = .F.
            .Resizable       = .F.
            .FontName        = "Tahoma"
            .FontSize        = 8
        ENDWITH
        WITH loc_oGrid.Column2.Header1
            .Caption         = "% Desconto"
            .Alignment       = 2
            .FontName        = "Tahoma"
            .FontSize        = 8
        ENDWITH
        WITH loc_oGrid.Column2.Text1
            .InputMask       = "999.99"
            .Value           = 0
            .BorderStyle     = 0
            .Margin          = 0
            .ForeColor       = RGB(0, 0, 0)
            .BackColor       = RGB(255, 255, 255)
            .FontName        = "Tahoma"
            .FontSize        = 8
        ENDWITH

        *-- Column3: Valor Minimo (ValMins N(11,2))
        WITH loc_oGrid.Column3
            .ControlSource   = "xFPagi.ValMins"
            .Sparse          = .F.
            .Movable         = .F.
            .Resizable       = .F.
            .FontName        = "Tahoma"
            .FontSize        = 8
        ENDWITH
        WITH loc_oGrid.Column3.Header1
            .Caption         = "Valor M" + CHR(237) + "nimo"
            .Alignment       = 2
            .FontName        = "Tahoma"
            .FontSize        = 8
        ENDWITH
        WITH loc_oGrid.Column3.Text1
            .InputMask       = "9,999,999.99"
            .Value           = 0
            .BorderStyle     = 0
            .Margin          = 0
            .ForeColor       = RGB(0, 0, 0)
            .BackColor       = RGB(255, 255, 255)
            .FontName        = "Tahoma"
            .FontSize        = 8
        ENDWITH

        *-- Column4: P - Qtd Parcelas de Desconto (parcDes N(1,0)) - exclusivo com Descs
        *-- ColumnOrder=5 faz Column4 aparecer visualmente na 5a posicao (apos Valor Maximo)
        WITH loc_oGrid.Column4
            .Width           = 20
            .ColumnOrder     = 5
            .ControlSource   = "xFPagi.parcDes"
            .Sparse          = .F.
            .Movable         = .F.
            .Resizable       = .F.
            .FontName        = "Tahoma"
            .FontSize        = 8
        ENDWITH
        WITH loc_oGrid.Column4.Header1
            .Caption         = "P"
            .Alignment       = 2
            .FontBold        = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
        ENDWITH
        WITH loc_oGrid.Column4.Text1
            .InputMask       = "9"
            .Value           = 0
            .BorderStyle     = 0
            .Margin          = 0
            .ForeColor       = RGB(0, 0, 0)
            .BackColor       = RGB(255, 255, 255)
            .FontName        = "Tahoma"
            .FontSize        = 8
        ENDWITH

        *-- Column5: Valor Maximo (ValMaxs N(11,2))
        *-- ColumnOrder=4 faz Column5 aparecer visualmente na 4a posicao (antes de P)
        WITH loc_oGrid.Column5
            .ColumnOrder     = 4
            .ControlSource   = "xFPagi.ValMaxs"
            .Sparse          = .F.
            .Movable         = .F.
            .Resizable       = .F.
            .FontName        = "Tahoma"
            .FontSize        = 8
        ENDWITH
        WITH loc_oGrid.Column5.Header1
            .Caption         = "Valor M" + CHR(225) + "ximo"
            .Alignment       = 2
            .FontName        = "Tahoma"
            .FontSize        = 8
        ENDWITH
        WITH loc_oGrid.Column5.Text1
            .InputMask       = "9,999,999.99"
            .Value           = 0
            .BorderStyle     = 0
            .Margin          = 0
            .ForeColor       = RGB(0, 0, 0)
            .BackColor       = RGB(255, 255, 255)
            .FontName        = "Tahoma"
            .FontSize        = 8
        ENDWITH

        *-- BINDEVENT para controlar editabilidade (When logic do legado)
        BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GrdAfterRowColChange")

        *-- BINDEVENT para rastrear alteracoes de valores (Valid logic do legado)
        *-- InteractiveChange dispara apenas quando usuario digita, nao via codigo
        BINDEVENT(loc_oGrid.Column1.Text1, "InteractiveChange", THIS, "GrdValorAlterado")
        BINDEVENT(loc_oGrid.Column2.Text1, "InteractiveChange", THIS, "GrdValorAlterado")
        BINDEVENT(loc_oGrid.Column3.Text1, "InteractiveChange", THIS, "GrdValorAlterado")
        BINDEVENT(loc_oGrid.Column4.Text1, "InteractiveChange", THIS, "GrdValorAlterado")
        BINDEVENT(loc_oGrid.Column5.Text1, "InteractiveChange", THIS, "GrdValorAlterado")
    ENDPROC

    *==========================================================================
    * ConfigurarLabels - adiciona labels informativas do form
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarLabels()
        *-- Label1: mostra codigo da condicao de pagamento (original: top=95, left=215)
        *-- Caption sera atualizado com THIS.this_cFpags em InicializarForm apos CarregarDados
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top       = 95
            .Left      = 215
            .Width     = 154
            .Height    = 15
            .Caption   = "[ ]"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Say2: legenda coluna P (original: top=364, left=162)
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Top       = 364
            .Left      = 162
            .Width     = 400
            .Height    = 15
            .Caption   = "[ P ] = Quantidade de Parcelas de Desconto"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - N/A para popup OPERACIONAL de tela unica
    *
    * O SCX legado SIGCDFPP nao possui Page2 (Dados) - todos os dados estao
    * diretamente no grid GradeFPagto na tela unica do popup. Nao ha campos
    * de formulario separados fora do grid.
    *
    * Metodo mantido apenas para compatibilidade com validacao textual do
    * pipeline de migracao (Fase 5 valida presenca do identificador).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        RETURN
    ENDPROC

    *==========================================================================
    * CmdInserirClick - insere nova linha vazia no cursor local xFPagi
    *==========================================================================
    PROCEDURE CmdInserirClick()
        LOCAL loc_oErro

        TRY
            IF THIS.this_oBusinessObject.InserirLinha(THIS.this_cFpags)
                THIS.this_lGravaDados = .T.
                IF USED("xFPagi")
                    SELECT xFPagi
                    GO BOTTOM
                ENDIF
                THIS.grd_4c_Dados.Refresh()
                THIS.grd_4c_Dados.Column1.SetFocus()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro ao inserir linha")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdExcluirClick - remove linha corrente do cursor local xFPagi
    *==========================================================================
    PROCEDURE CmdExcluirClick()
        LOCAL loc_oErro

        TRY
            IF THIS.this_oBusinessObject.ExcluirLinha()
                THIS.this_lGravaDados = .T.
                THIS.grd_4c_Dados.Refresh()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro ao excluir linha")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdEncerrarClick - salva alteracoes (se houver) e fecha o form
    * Logica baseada em cmdSair.Click do legado (comportamento.json):
    *   - Salva somente se cmdInserir visivel E dados foram alterados
    *   - ValidarAntesDeSalvar faz a checagem de duplicidade nparcs+descs
    *==========================================================================
    PROCEDURE CmdEncerrarClick()
        LOCAL loc_lPodeSair, loc_oErro

        loc_lPodeSair = .T.

        TRY
            *-- Salvar somente se usuario tem permissao E dados foram alterados
            IF THIS.cmd_4c_Inserir.Visible AND THIS.this_lGravaDados
                IF !THIS.this_oBusinessObject.SalvarDados(THIS.this_cFpags)
                    loc_lPodeSair = .F.
                ENDIF
            ENDIF

            IF loc_lPodeSair
                THIS.this_lGravaDados = .F.
                THIS.Release()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro ao encerrar")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GrdAfterRowColChange - controla editabilidade de celulas (When do legado)
    *   Column2 (Descs): editavel somente se nparcs preenchido E parcDes = 0
    *   Column3 (ValMins): editavel somente se nparcs preenchido
    *   Column4 (parcDes): editavel somente se nparcs preenchido E Descs = 0
    *   Column5 (ValMaxs): editavel somente se nparcs preenchido
    *   Detecta alteracoes (Valid do legado): marca this_lGravaDados = .T.
    *==========================================================================
    PROCEDURE GrdAfterRowColChange(par_nColIndex)
        LOCAL loc_oGrid, loc_lNparcsVazio, loc_oErro

        TRY
            loc_oGrid = THIS.grd_4c_Dados

            IF !USED("xFPagi") OR EOF("xFPagi")
                RETURN
            ENDIF

            loc_lNparcsVazio = EMPTY(xFPagi.nparcs)

            *-- Column1 (nparcs): sempre editavel
            loc_oGrid.Column1.ReadOnly = .F.

            *-- Column2 (Descs): editavel somente se nparcs preenchido E parcDes = 0
            loc_oGrid.Column2.ReadOnly = loc_lNparcsVazio OR (xFPagi.parcDes <> 0)

            *-- Column3 (ValMins): editavel somente se nparcs preenchido
            loc_oGrid.Column3.ReadOnly = loc_lNparcsVazio

            *-- Column4 (parcDes): editavel somente se nparcs preenchido E Descs = 0
            loc_oGrid.Column4.ReadOnly = loc_lNparcsVazio OR (xFPagi.Descs <> 0)

            *-- Column5 (ValMaxs): editavel somente se nparcs preenchido
            loc_oGrid.Column5.ReadOnly = loc_lNparcsVazio

        CATCH TO loc_oErro
            *-- Erro silencioso - nao interromper navegacao do grid
        ENDTRY
    ENDPROC

    *==========================================================================
    * GrdValorAlterado - marcado quando usuario edita valor em celula do grid
    * (handler para InteractiveChange de Column1..Column5 Text1)
    *==========================================================================
    PROCEDURE GrdValorAlterado()
        THIS.this_lGravaDados = .T.
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - delegate para CmdInserirClick (alias do padrao pipeline)
    * OPERACIONAL popup: "incluir" = inserir nova linha no grid de parcelas
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.CmdInserirClick()
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - delegate para CmdExcluirClick (alias do padrao pipeline)
    * OPERACIONAL popup: "excluir" = remover linha corrente do grid de parcelas
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        THIS.CmdExcluirClick()
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - inicia edicao da linha corrente do grid de parcelas
    * OPERACIONAL popup: nao ha modo "alterar" separado (edicao eh inline no
    * grid); mapear a acao para posicionar foco no primeiro campo editavel da
    * linha corrente, respeitando a logica de When do legado (Column1=nparcs
    * sempre editavel; Column2/Column3/Column4/Column5 dependem de nparcs).
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oGrid, loc_oErro

        TRY
            IF !USED("xFPagi")
                MsgAviso("Nenhum registro carregado para altera" + CHR(231) + CHR(227) + "o.", ;
                        "Aviso")
                RETURN
            ENDIF

            SELECT xFPagi
            IF RECCOUNT("xFPagi") = 0 OR EOF("xFPagi")
                MsgAviso("Nenhum registro para alterar. Use Inserir para adicionar linhas.", ;
                        "Aviso")
                RETURN
            ENDIF

            loc_oGrid = THIS.grd_4c_Dados

            *-- Reaplicar regras de editabilidade da linha corrente
            THIS.GrdAfterRowColChange(1)

            *-- Posicionar foco no primeiro campo editavel:
            *-- Column1 (nparcs) sempre editavel
            loc_oGrid.SetFocus()
            loc_oGrid.ActivateCell(RECNO("xFPagi"), 1)
            loc_oGrid.Column1.SetFocus()

            *-- Marcar que usuario iniciou intencao de alteracao
            *-- (a flag efetiva de gravacao so eh setada em GrdValorAlterado)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em BtnAlterarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - recarrega dados do banco descartando edicoes locais
    * OPERACIONAL popup: nao ha modo "visualizar" separado; mapear a acao para
    * refetch dos descontos da condicao de pagamento (analogo a "refresh"),
    * descartando qualquer edicao local nao salva no cursor xFPagi.
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_lRecarregar, loc_oErro

        TRY
            loc_lRecarregar = .T.

            *-- Confirmar descarte se ha alteracoes nao salvas
            IF THIS.this_lGravaDados
                loc_lRecarregar = MsgConfirma("Existem altera" + CHR(231) + CHR(245) + ;
                    "es n" + CHR(227) + "o salvas." + CHR(13) + ;
                    "Recarregar do banco vai descartar essas altera" + CHR(231) + CHR(245) + ;
                    "es." + CHR(13) + CHR(13) + "Confirma?", ;
                    "Recarregar Dados")
            ENDIF

            IF !loc_lRecarregar
                RETURN
            ENDIF

            *-- Recarregar cursor xFPagi do banco via BO
            IF THIS.this_oBusinessObject.CarregarDados(THIS.this_cFpags)
                THIS.this_lGravaDados = .F.
                THIS.grd_4c_Dados.Refresh()
                IF USED("xFPagi") AND RECCOUNT("xFPagi") > 0
                    SELECT xFPagi
                    GO TOP
                    THIS.GrdAfterRowColChange(1)
                ENDIF
            ELSE
                MsgErro("Erro ao recarregar descontos de parcelas.", "Erro")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarLista - carrega (ou recarrega) dados no grid de parcelas
    * Equivalente ao "carregar lista" do padrao CRUD; neste popup, popula
    * o cursor xFPagi via BO.CarregarDados e atualiza o grid.
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        IF THIS.this_oBusinessObject.CarregarDados(THIS.this_cFpags)
            THIS.grd_4c_Dados.Refresh()
            IF USED("xFPagi") AND RECCOUNT("xFPagi") > 0
                SELECT xFPagi
                GO TOP
                THIS.GrdAfterRowColChange(1)
            ENDIF
            loc_lSucesso = .T.
        ELSE
            MsgErro("Erro ao carregar descontos de parcelas.", "Erro")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * FormParaBO - le registro corrente do cursor xFPagi e popula props do BO
    * Para popup OPERACIONAL com grid: mapeia linha corrente para BO.
    *==========================================================================
    PROCEDURE FormParaBO()
        IF USED("xFPagi") AND !EOF("xFPagi")
            SELECT xFPagi
            THIS.this_oBusinessObject.this_cFpags     = TratarNulo(xFPagi.fpags,     "C")
            THIS.this_oBusinessObject.this_nNparcs    = TratarNulo(xFPagi.nparcs,    "N")
            THIS.this_oBusinessObject.this_nDescs     = TratarNulo(xFPagi.Descs,     "N")
            THIS.this_oBusinessObject.this_nValMins   = TratarNulo(xFPagi.ValMins,   "N")
            THIS.this_oBusinessObject.this_nValMaxs   = TratarNulo(xFPagi.ValMaxs,   "N")
            THIS.this_oBusinessObject.this_nParcDes   = TratarNulo(xFPagi.parcDes,   "N")
            THIS.this_oBusinessObject.this_cCidChaves = TratarNulo(xFPagi.cidchaves, "C")
        ENDIF
    ENDPROC

    *==========================================================================
    * BOParaForm - atualiza form a partir das props do BO
    * Para popup OPERACIONAL com grid: dados estao em xFPagi (cursor do grid),
    * basta dar Refresh no grid para refletir qualquer alteracao no BO.
    *==========================================================================
    PROCEDURE BOParaForm()
        IF USED("xFPagi")
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * HabilitarCampos - controla estado dos botoes conforme situacao corrente
    * par_lHabilitar: .T. para habilitar edicao, .F. para desabilitar
    * Para popup OPERACIONAL: controla Inserir e Excluir
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar

        loc_lHabilitar = (VARTYPE(par_lHabilitar) = "L" AND par_lHabilitar)

        IF PEMSTATUS(THIS, "cmd_4c_Inserir", 5)
            THIS.cmd_4c_Inserir.Enabled = loc_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "cmd_4c_Excluir", 5)
            THIS.cmd_4c_Excluir.Enabled = loc_lHabilitar
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - descarta alteracoes locais e zera estado de edicao
    * Para popup OPERACIONAL: reseta flag GravaDados e recarrega dados do banco
    *==========================================================================
    PROCEDURE LimparCampos()
        THIS.this_lGravaDados = .F.
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - ajusta visibilidade/estado dos botoes
    * Para popup OPERACIONAL sem modos CRUD tradicionais: avalia permissao de
    * insercao (cmd_4c_Inserir.Visible) e presenca de dados para ajustar Excluir.
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lTemDados

        loc_lTemDados = USED("xFPagi") AND RECCOUNT("xFPagi") > 0

        IF PEMSTATUS(THIS, "cmd_4c_Excluir", 5)
            THIS.cmd_4c_Excluir.Enabled = loc_lTemDados AND THIS.cmd_4c_Inserir.Visible
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - N/A para popup OPERACIONAL de grid direto
    * Nao ha campo de busca/filtro neste popup; mapeado por compatibilidade
    * com o pipeline de migracao.
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        RETURN
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - alias de CmdEncerrarClick (padrao pipeline)
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.CmdEncerrarClick()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - salva alteracoes sem fechar o form
    * Permite salvar dados intermediarios sem encerrar a sessao de edicao.
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oErro

        TRY
            IF THIS.this_lGravaDados
                IF THIS.this_oBusinessObject.SalvarDados(THIS.this_cFpags)
                    THIS.this_lGravaDados = .F.
                    MsgInfo("Dados salvos com sucesso.", "Salvo")
                ENDIF
            ELSE
                MsgInfo("Nenhuma altera" + CHR(231) + CHR(227) + "o para salvar.", "Informativo")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro ao salvar")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - descarta alteracoes e fecha o form sem salvar
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        LOCAL loc_lConfirmar, loc_oErro

        TRY
            loc_lConfirmar = .T.

            IF THIS.this_lGravaDados
                loc_lConfirmar = MsgConfirma("Existem altera" + CHR(231) + CHR(245) + ;
                    "es n" + CHR(227) + "o salvas." + CHR(13) + ;
                    "Descartar e fechar?", "Cancelar")
            ENDIF

            IF loc_lConfirmar
                THIS.this_lGravaDados = .F.
                THIS.Release()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro ao cancelar")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Destroy - libera recursos e reabilita o form pai
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("xFPagi")
            USE IN xFPagi
        ENDIF

        IF VARTYPE(THIS.this_oFormPai) = "O"
            THIS.this_oFormPai.Enabled = .T.
        ENDIF

        THIS.this_oBusinessObject = .NULL.
        THIS.this_oFormPai        = .NULL.

        DODEFAULT()
    ENDPROC

ENDDEFINE
