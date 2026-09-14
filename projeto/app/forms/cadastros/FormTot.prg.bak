*==============================================================================
* FormTot.prg - Formulario de Cadastro de Tipos de Operacoes de Producao
* Migrado de: SigCdTot.SCX (frmcadastro)
* Tabela: SigCdToi
* Chave: codigos numeric(2,0)
*
* FASE 4/8: Form - Grid e Botoes CRUD (Page1)
* Page1 completa: faixa do cabecalho com labels, Grid (Codigo/Descricao,
* espelhando o AddCursor/pColuna do legado) e Container cnt_4c_Botoes com
* os 5 botoes CRUD (Incluir/Visualizar/Alterar/Excluir/Buscar) + cnt_4c_Saida
* canonico (CLAUDE.md #10) com cmd_4c_Encerrar. AlternarPagina() e
* CarregarLista() implementados. Campos de Page2 e eventos Btn*Click sao
* adicionados nas proximas fases.
*
* FASE 5/8: Form - Campos Principais (Page2 - Parte 1)
* Page2 (Dados) recebe a faixa do cabecalho completa (lbl_4c_Sombra +
* lbl_4c_Titulo, igual a Page1 - CLAUDE.md #11) e os primeiros 50% dos
* campos: Codigo (txt_4c_Codigos, InputMask "99") e Descricao
* (txt_4c_Descrs, Format "!K"), com os labels correspondentes
* (lbl_4c_LblCodigos/lbl_4c_LblDescrs, ForeColor RGB(90,90,90) - CLAUDE.md
* #12).
*
* FASE 6/8: Form - Campos Restantes e Lookups (Page2 - Parte 2)
* Ultimo campo: Tipo de Operacao (obj_4c_Fwoption1/OptionGroup com botoes
* Soma/Subtrai, ControlSource numerico -> Value grava indice 1/2 do botao)
* + label lbl_4c_Label4. Container cnt_4c_BotoesAcao populado com
* cmd_4c_Confirmar/cmd_4c_Cancelar + BINDEVENT para BtnSalvarClick/
* BtnCancelarClick (implementados na Fase 7). NAO ha lookups no form
* original (SigCdTot_form_codigo_fonte.txt nao usa fwbuscaext/fwBuscaSel/
* sigacess) - nenhum lookup foi inventado.
*
* FASE 7/8: Form - Eventos Principais
* BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick +
* metodos de suporte (BOParaForm/HabilitarCampos/LimparCampos/
* AjustarBotoesPorModo). Logica espelha comportamento.json
* (SIGCDTOT.Click "Opcao" de 19 linhas: foco em Get_Codigos no INSERIR,
* Get_Descrs no ALTERAR) e SIGCDTOT.Click de 18 linhas (validacao no
* Confirmar: Descrs obrigatoria + ChkRegister de Codigos duplicado,
* ambas restritas ao modo INCLUIR). BtnSalvarClick/BtnCancelarClick/
* BtnBuscarClick/BtnEncerrarClick (ja vinculados via BINDEVENT nas
* fases 4/6) sao implementados na Fase 8.
*
* FASE 8/8: Form - Eventos Auxiliares e Consolidacao Final
* BtnSalvarClick (validacoes do SIGCDTOT.Click de 18 linhas: Descrs
* obrigatoria + ChkRegister de Codigos duplicado, ambas restritas ao modo
* INCLUIR), BtnCancelarClick (espelha SIGCDTOT.Click de 4 linhas:
* DoDefault + mAtivaPagina1), BtnBuscarClick (espelha SIGCDTOT.Procedure de
* 23 linhas - SEEK local por Codigos/Descrs - via FormBuscaAuxiliar,
* padrao unificado de lookup) e BtnEncerrarClick. Integracao final: item
* de menu (popCadastros BAR 182) + AbrirFormTot() em menu.prg. TotBO.prg e
* FormTot.prg ja sao carregados automaticamente via ADIR() em config.prg
* (SET PROCEDURE dinamico para *BO.prg e Form*.prg).
*==============================================================================

DEFINE CLASS FormTot AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: Height/Width/Caption EXATOS do original)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Tipos de Opera" + CHR(231) + CHR(245) + "es de Produ" + CHR(231) + CHR(227) + "o"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *===========================================================================
    * Init - Inicializa o formulario
    * REGRA CRITICA: Apenas RETURN DODEFAULT()
    * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
    *===========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *===========================================================================
    * InicializarForm - Configura estrutura completa
    * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
    *===========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("TotBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar TotBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormTot.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Visible   = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                THIS.CarregarLista()
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormTot:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormTot.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * Top=-29 para esconder abas; controles compensam +29 no Top
    *===========================================================================
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
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)

            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaLista - Configura Page1 (Lista)
    * REGRA CLAUDE.md #11: a faixa do cabecalho DEVE ser o PRIMEIRO AddObject
    * da pagina - os containers de botao ficam em Top=29..33, dentro da area
    * da faixa, e precisam ser criados DEPOIS para desenhar por cima.
    * Grid com colunas Codigo/Descricao (espelha AddCursor/pColuna do Init
    * legado: pColuna('Codigos',...,44) + pColuna('Descrs',...,279)) e
    * botoes CRUD (Incluir/Visualizar/Alterar/Excluir/Buscar/Encerrar).
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Faixa do Cabecalho (PRIMEIRO AddObject da pagina - CLAUDE.md #11)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 29
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = THIS.Caption
            .Top       = 15
            .Left      = 10
            .Width     = 769
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = THIS.Caption
            .Top       = 18
            .Left      = 10
            .Width     = 769
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container Botoes CRUD (Grupo_op no legado)
        *-- Canonico: Left=542, Top=29, Width=390, Height=85 (framework_frmcadastro_layout.md)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Container Saida - valores canonicos CLAUDE.md regra #10 (PREVALECE sobre legado)
        *-- Transparente/flutuante sobre a Page; Page.Width NAO subtrai espaco por este container
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

        loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Grid de lista (Grade no legado) - AddCursor('SigCdToi','Codigos','CrSigCdToi')
        *-- pColuna('Codigos',...,44) + pColuna('Descrs',...,279)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 12
            .Width              = 895
            .Height             = 455
            .FontName           = "Verdana"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 2
            .GridLines          = 3
            .ReadOnly           = .T.
            .Visible            = .T.
        ENDWITH

        *-- ColumnCount FORA do WITH para criar colunas imediatamente (Problema 36)
        loc_oPagina.grd_4c_Lista.ColumnCount = 2

        WITH loc_oPagina.grd_4c_Lista
            .Column1.Header1.Caption = "C" + CHR(243) + "digo"
            .Column1.Width           = 120
            .Column1.Alignment       = 1

            .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            .Column2.Width           = 770
            .Column2.Alignment       = 0
        ENDWITH

        *-- BINDEVENTs - metodos devem ser PUBLIC (sem PROTECTED) para funcionar
        *-- (metodos Btn*Click implementados em fase posterior)
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    * par_nPagina: 1=Lista, 2=Dados
    *===========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) = "N" AND BETWEEN(par_nPagina, 1, 2)
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
            IF par_nPagina = 1
                THIS.this_cModoAtual = "LISTA"
                THIS.CarregarLista()
            ENDIF
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * CarregarLista - Carrega dados no Grid da Page1
    * Chama TotBO.Buscar() e vincula cursor_4c_Dados ao grid
    * Colunas exibidas: codigos (Codigo) e descrs (Descricao), espelhando
    * o AddCursor/pColuna do legado (SigCdTot.SCX Init)
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            IF !USED("cursor_4c_Dados")
                SET NULL ON
                CREATE CURSOR cursor_4c_Dados (codigos N(2,0), descrs C(30), tpgdmis N(1,0))
                SET NULL OFF
            ENDIF
            loc_lResultado = .T.
        ELSE
            TRY
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                IF THIS.this_oBusinessObject.Buscar("")
                    loc_oGrid.ColumnCount = 2
                    loc_oGrid.RecordSource          = "cursor_4c_Dados"
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"

                    *-- Reconfigurar headers apos RecordSource (RecordSource reseta captions)
                    loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                    loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

                    loc_oGrid.Column1.Width     = 120
                    loc_oGrid.Column1.Alignment = 1
                    loc_oGrid.Column2.Width     = 770
                    loc_oGrid.Column2.Alignment = 0

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_oGrid.Refresh()
                    loc_lResultado = .T.
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro ao carregar lista: " + loc_oErro.Message, "Erro")
            ENDTRY
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * Percorre Controls E Pages (para PageFrames aninhados)
    *===========================================================================
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

    *===========================================================================
    * FormatarGridLista - Formata visual do grid da lista
    * Fonte Verdana (padrao do framework Grade), tamanho 8
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Configura Page2 (Dados)
    * REGRA CLAUDE.md #11: faixa do cabecalho tambem na pagina Dados
    * (decisao do time - diverge do legado frmcadastro que so tem na Lista).
    *
    * FASE 5/8: primeiros 50% dos campos (Codigo + Descricao) + faixa do
    * cabecalho completa (lbl_4c_Sombra/lbl_4c_Titulo).
    *
    * FASE 6/8: campo restante (Tipo de Operacao - obj_4c_Fwoption1) +
    * botoes de acao (cmd_4c_Confirmar/cmd_4c_Cancelar) em cnt_4c_BotoesAcao.
    *
    * Compensacao PageFrame.Top=-29: todo Top do original (Pagina.Dados.*)
    * recebe +29.
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Faixa do Cabecalho (PRIMEIRO AddObject da pagina - CLAUDE.md #11)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 29
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = THIS.Caption
            .Top       = 15
            .Left      = 10
            .Width     = 769
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = THIS.Caption
            .Top       = 18
            .Left      = 10
            .Width     = 769
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container Botoes de Acao (Confirmar/Cancelar)
        *-- Posicao base equivalente ao Grupo_Salva do framework (Top=33, Left=842)
        *-- Vazio nesta fase; botoes cmd_4c_Confirmar/cmd_4c_Cancelar sao
        *-- adicionados na Fase 6/7
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle = 1
            .BackColor   = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Campo Codigo (Get_Codigos: crSigCdToi.Codigos numeric(2,0))
        *-- Original: Top=155 Left=260 Width=25 Height=23 InputMask="99" MaxLength=2
        loc_oPagina.AddObject("lbl_4c_LblCodigos", "Label")
        WITH loc_oPagina.lbl_4c_LblCodigos
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 158 + 29
            .Left      = 216
            .Width     = 42
            .Height    = 17
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Codigos", "TextBox")
        WITH loc_oPagina.txt_4c_Codigos
            .Top        = 155 + 29
            .Left       = 260
            .Width      = 25
            .Height     = 23
            .InputMask  = "99"
            .MaxLength  = 2
            .FontName   = "Tahoma"
            .FontSize   = 8
            .ForeColor  = RGB(0, 0, 0)
            .Value      = 0
            .Visible    = .T.
        ENDWITH

        *-- Campo Descricao (Get_Descrs: crSigCdToi.Descrs char(30))
        *-- Original: Top=180 Left=260 Width=220 Format="!K" (uppercase + limpa ao entrar)
        loc_oPagina.AddObject("lbl_4c_LblDescrs", "Label")
        WITH loc_oPagina.lbl_4c_LblDescrs
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 183 + 29
            .Left      = 203
            .Width     = 55
            .Height    = 17
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Descrs", "TextBox")
        WITH loc_oPagina.txt_4c_Descrs
            .Top        = 180 + 29
            .Left       = 260
            .Width      = 220
            .Height     = 23
            .Format     = "!K"
            .FontName   = "Tahoma"
            .FontSize   = 8
            .ForeColor  = RGB(0, 0, 0)
            .Value      = ""
            .Visible    = .T.
        ENDWITH

        *-- Label "Tipo de Operacao :" (Label4 no legado)
        *-- Original: Top=209 Left=164 Width=94
        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Caption   = "Tipo de Opera" + CHR(231) + CHR(227) + "o :"
            .Top       = 209 + 29
            .Left      = 164
            .Width     = 94
            .Height    = 17
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Tipo de Operacao (fwoption1: ControlSource crSigCdToi.TpGdmis)
        *-- Original: Top=206 Left=260 Width=121 Height=24 ButtonCount=2
        *-- Option1="Soma" (Left=3), Option2="Subtrai" (Left=63)
        *-- ControlSource numerico -> Value grava o INDICE do botao (1=Soma, 2=Subtrai)
        LOCAL loc_oBtnSoma, loc_oBtnSubtrai

        loc_oPagina.AddObject("obj_4c_Fwoption1", "OptionGroup")
        WITH loc_oPagina.obj_4c_Fwoption1
            .ButtonCount   = 2
            .Top           = 206 + 29
            .Left          = 260
            .Width         = 121
            .Height        = 24
            .BackStyle     = 0
            .SpecialEffect = 0
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- Buttons(N) NUNCA configurado dentro de WITH (nem aninhado) - "BUTTONS is not an object"
        *-- Capturar referencia em LOCAL antes de usar WITH (feedback_optiongroup_buttons_with_aninhado)
        loc_oBtnSoma    = loc_oPagina.obj_4c_Fwoption1.Buttons(1)
        loc_oBtnSubtrai = loc_oPagina.obj_4c_Fwoption1.Buttons(2)

        WITH loc_oBtnSoma
            .Caption   = "Soma"
            .Left      = 3
            .Top       = 4
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        WITH loc_oBtnSubtrai
            .Caption   = "Subtrai"
            .Left      = 63
            .Top       = 4
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- Container Botoes de Acao (Grupo_Salva no legado): Confirmar/Cancelar
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- BINDEVENTs Page2 - metodos devem ser PUBLIC (sem PROTECTED) para funcionar
        *-- (metodos BtnSalvarClick/BtnCancelarClick implementados em fase posterior)
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Prepara o BO/Form para inclusao de novo registro
    * PUBLIC (sem PROTECTED) - obrigatorio para funcionar com BINDEVENT (CLAUDE.md #3)
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(THIS.this_cModoAtual)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
        THIS.pgf_4c_Paginas.Page2.txt_4c_Codigos.SetFocus()
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Carrega o registro selecionado na lista e habilita
    * edicao (Descricao + Tipo de Operacao). Codigo permanece somente-leitura
    * (legado Get_Codigos.When = INSERIR/PROCURAR - nao inclui ALTERAR).
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_nCodigo

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um registro na lista para alterar!")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        IF EOF()
            MsgAviso("Selecione um registro na lista para alterar!")
            RETURN
        ENDIF
        loc_nCodigo = cursor_4c_Dados.codigos

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.BOParaForm()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.HabilitarCampos(THIS.this_cModoAtual)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Descrs.SetFocus()
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Carrega o registro selecionado em modo somente-leitura
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_nCodigo

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um registro na lista para visualizar!")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        IF EOF()
            MsgAviso("Selecione um registro na lista para visualizar!")
            RETURN
        ENDIF
        loc_nCodigo = cursor_4c_Dados.codigos

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
            THIS.BOParaForm()
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.HabilitarCampos(THIS.this_cModoAtual)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Exclui o registro selecionado na lista (apos confirmar)
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_nCodigo, loc_cDescricao, loc_lConfirma, loc_lSucesso

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um registro na lista para excluir!")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        IF EOF()
            MsgAviso("Selecione um registro na lista para excluir!")
            RETURN
        ENDIF
        loc_nCodigo    = cursor_4c_Dados.codigos
        loc_cDescricao = ALLTRIM(cursor_4c_Dados.descrs)

        loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do Tipo de Opera" + CHR(231) + CHR(227) + "o " + ;
            TRANSFORM(loc_nCodigo) + " - " + loc_cDescricao + "?", ;
            "Confirma Exclus" + CHR(227) + "o")

        IF loc_lConfirma
            loc_lSucesso = .F.

            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
                loc_lSucesso = THIS.this_oBusinessObject.Excluir()
            ENDIF

            IF loc_lSucesso
                MsgExcluidoSucesso()
                THIS.CarregarLista()
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Valida e grava o registro (INSERT ou UPDATE)
    * Validacoes espelham comportamento.json (SIGCDTOT.Click, 18 linhas) -
    * aplicadas apenas no modo INCLUIR (InList(pcEscolha,'INSERIR')):
    *   - Descrs vazia -> bloqueia (Messagebox 'Descricao Invalida !!!')
    *   - ChkRegister('SigCdToi','Codigos',...) duplicado -> bloqueia
    *     (Messagebox 'Tipo Ja Cadastrado !!!')
    * PUBLIC (sem PROTECTED) - obrigatorio para funcionar com BINDEVENT (CLAUDE.md #3)
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPagina, loc_nCodigo, loc_cDescricao, loc_nChk, loc_lDuplicado, loc_lErroChk
        loc_oPagina    = THIS.pgf_4c_Paginas.Page2
        loc_nCodigo    = loc_oPagina.txt_4c_Codigos.Value
        loc_cDescricao = ALLTRIM(loc_oPagina.txt_4c_Descrs.Value)
        loc_lDuplicado = .F.
        loc_lErroChk   = .F.

        *-- Validacoes FORA do TRY (permitem RETURN direto) - somente no INCLUIR
        IF THIS.this_cModoAtual = "INCLUIR"
            IF EMPTY(loc_cDescricao)
                MsgAviso("Descri" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida !!!", "Campo Obrigat" + CHR(243) + "rio")
                loc_oPagina.txt_4c_Descrs.SetFocus
                RETURN
            ENDIF

            *-- Verificar duplicidade do codigo - espelha ChkRegister('SigCdToi','Codigos',...)
            *-- REGRA CRITICA: RETURN NUNCA dentro de TRY/CATCH - usar flags e checar apos ENDTRY
            TRY
                loc_nChk = SQLEXEC(gnConnHandle, "SELECT COUNT(*) AS nExiste FROM SigCdToi WHERE codigos = " + ;
                    FormatarNumeroSQL(loc_nCodigo, 0), "cursor_4c_ChkCod")
                IF loc_nChk >= 0 AND RECCOUNT("cursor_4c_ChkCod") > 0
                    SELECT cursor_4c_ChkCod
                    loc_lDuplicado = (cursor_4c_ChkCod.nExiste > 0)
                ENDIF
                IF USED("cursor_4c_ChkCod")
                    USE IN cursor_4c_ChkCod
                ENDIF
            CATCH TO loException
                MostrarErro("Erro em FormTot.BtnSalvarClick:" + CHR(13) + loException.Message, "Erro")
                IF USED("cursor_4c_ChkCod")
                    USE IN cursor_4c_ChkCod
                ENDIF
                loc_lErroChk = .T.
            ENDTRY

            IF loc_lErroChk
                RETURN
            ENDIF

            IF loc_lDuplicado
                MsgAviso("Tipo J" + CHR(225) + " Cadastrado !!!", "Valida" + CHR(231) + CHR(227) + "o")
                loc_oPagina.txt_4c_Codigos.SetFocus
                RETURN
            ENDIF
        ENDIF

        TRY
            THIS.FormParaBO()
            IF THIS.this_oBusinessObject.Salvar()
                MsgSucesso("Tipo de Opera" + CHR(231) + CHR(227) + "o de Produ" + CHR(231) + CHR(227) + "o salvo com sucesso!")
                THIS.AlternarPagina(1)
                THIS.this_cModoAtual = "LISTA"
                THIS.AjustarBotoesPorModo()
            ENDIF
        CATCH TO loException
            MostrarErro("Erro em FormTot.BtnSalvarClick:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancela edicao/visualizacao e retorna para a lista
    * Legado (SIGCDTOT.Click, 4 linhas): DoDefault(); IF plCancelar; mAtivaPagina1()
    * PUBLIC (sem PROTECTED) - TesteAutomatico.prg chama direto de fora da classe
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        TRY
            THIS.AlternarPagina(1)
            THIS.this_cModoAtual = "LISTA"
            THIS.CarregarLista()
            THIS.AjustarBotoesPorModo()
        CATCH TO loException
            MostrarErro("Erro em FormTot.BtnCancelarClick:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Procura um Tipo de Operacao de Producao por codigo e
    * posiciona o grid da lista no registro encontrado.
    * Legado (SIGCDTOT.Procedure, 23 linhas): SEEK direto no cursor local pelos
    * campos Get_Codigos/Get_Descrs. Aqui, mesma intencao via FormBuscaAuxiliar
    * (padrao unificado de lookup do novo sistema) + LOCATE no grid da lista.
    * PUBLIC (sem PROTECTED) - obrigatorio para funcionar com BINDEVENT (CLAUDE.md #3)
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cCodigo
        loc_cCodigo = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdToi", "cursor_4c_BuscaTot", "codigos", loc_cCodigo, ;
                "Buscar Tipo de Opera" + CHR(231) + CHR(227) + "o de Produ" + CHR(231) + CHR(227) + "o")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTot")
                    SELECT cursor_4c_BuscaTot
                    loc_cCodigo = ALLTRIM(TRANSFORM(cursor_4c_BuscaTot.codigos))

                    *-- Posicionar grid na linha correspondente
                    IF USED("cursor_4c_Dados")
                        SELECT cursor_4c_Dados
                        LOCATE FOR ALLTRIM(TRANSFORM(cursor_4c_Dados.codigos)) = loc_cCodigo
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaTot")
                USE IN cursor_4c_BuscaTot
            ENDIF
        CATCH TO loException
            MostrarErro("Erro em FormTot.BtnBuscarClick:" + CHR(13) + loException.Message, "Erro")
            IF USED("cursor_4c_BuscaTot")
                USE IN cursor_4c_BuscaTot
            ENDIF
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    * PUBLIC (sem PROTECTED) - obrigatorio para funcionar com BINDEVENT (CLAUDE.md #3)
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        TRY
            THIS.Release()
        CATCH TO loException
            MostrarErro("Erro em FormTot.BtnEncerrarClick:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere propriedades do TotBO para os controles da Page2
    * Mapeamento identico ao TotBO.CarregarDoCursor
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        WITH THIS.this_oBusinessObject
            loc_oPg2.txt_4c_Codigos.Value   = .this_nCodigo
            loc_oPg2.txt_4c_Descrs.Value    = .this_cDescricao
            loc_oPg2.obj_4c_Fwoption1.Value = .this_nTipoOperacao
        ENDWITH
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere os controles da Page2 para as propriedades do TotBO
    * Mapeamento identico (invertido) ao BOParaForm.
    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        WITH THIS.this_oBusinessObject
            .this_nCodigo       = loc_oPg2.txt_4c_Codigos.Value
            .this_cDescricao    = ALLTRIM(loc_oPg2.txt_4c_Descrs.Value)
            .this_nTipoOperacao = loc_oPg2.obj_4c_Fwoption1.Value
        ENDWITH
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Habilita/desabilita botoes de Page1 conforme o modo
    * PUBLIC (sem PROTECTED) - TesteAutomatico.prg chama direto de fora da classe
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg1, loc_lLista
        loc_oPg1   = THIS.pgf_4c_Paginas.Page1
        loc_lLista = (THIS.this_cModoAtual = "LISTA")

        TRY
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = loc_lLista
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lLista
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lLista
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lLista
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = loc_lLista
            loc_oPg1.cnt_4c_Saida.cmd_4c_Encerrar.Enabled    = loc_lLista
        CATCH TO loException
            MostrarErro("Erro em FormTot.AjustarBotoesPorModo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    * LimparCampos - Reseta os controles da Page2 para os valores default
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_Codigos.Value   = 0
        loc_oPg2.txt_4c_Descrs.Value    = ""
        loc_oPg2.obj_4c_Fwoption1.Value = 1
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita/desabilita os controles da Page2 conforme o modo
    * Replica os eventos When do legado (comportamento.json):
    *   Get_Codigos.When -> INSERIR/PROCURAR (aqui: somente INCLUIR)
    *   fwoption1.Procedure -> InList(pcEscolha,'INSERIR','ALTERAR')
    * par_cModo: "INCLUIR", "ALTERAR" ou "VISUALIZAR"
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_cModo)
        LOCAL loc_oPg2, loc_lEditavel
        loc_oPg2      = THIS.pgf_4c_Paginas.Page2
        loc_lEditavel = INLIST(par_cModo, "INCLUIR", "ALTERAR")

        loc_oPg2.txt_4c_Codigos.Enabled   = (par_cModo = "INCLUIR")
        loc_oPg2.txt_4c_Descrs.Enabled    = loc_lEditavel
        loc_oPg2.obj_4c_Fwoption1.Enabled = loc_lEditavel

        *-- Confirmar so fica habilitado quando ha algo para gravar (INCLUIR/ALTERAR)
        loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditavel OR (THIS.this_cModoAtual = "EXCLUIR")
        loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
    ENDPROC

    *===========================================================================
    * Destroy - Libera recursos do formulario
    *===========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
