*==============================================================================
* FormTPR.prg - Formulario de Cadastro de Subtipos de Transportes
* Migrado de: SIGCDTPR.SCX (frmcadastro)
* Tabela: SigPrTro / Chave: cidchaves char(20)
*
* FASE 3/8 - Estrutura Base:
*   PageFrame (Page1=Lista / Page2=Dados) + containers principais vazios
*   (cnt_4c_Cabecalho nas duas paginas, cnt_4c_Botoes e cnt_4c_BotoesAcao
*   apenas posicionados).
*
* FASE 4/8 - Grid e Botoes CRUD (Page1):
*   grd_4c_Lista (colunas configuradas em CarregarLista) + cnt_4c_Botoes com
*   5 botoes CRUD (Incluir/Visualizar/Alterar/Excluir/Buscar) + cnt_4c_Saida
*   com cmd_4c_Encerrar (padrao canonico). CarregarLista/FormatarGridLista/
*   AlternarPagina e os handlers Btn*Click implementados. Campos de Page2,
*   FormParaBO/BOParaForm e HabilitarCampos ficam para as Fases 5-8.
*
* FASE 5/8 - Campos Principais (Page2 - Parte 1 de 2):
*   Primeiros 50% dos campos de dados (ordem do SCX legado): txt_4c_TpTrans,
*   txt_4c_Obs, txt_4c_Tps, txt_4c_RecTrans, txt_4c__Ordem, txt_4c_Dbf + labels
*   correspondentes (lbl_4c_Label7/6/5/9/1, lbl_4c_Lbl_estoque). Tops compensados
*   +29 (PageFrame.Top=-29). MaxLength por schema.sql (regra #19), NAO pelo
*   Width em pixels. Restantes (getIndice/getChave/getCProcs/getComparacao/
*   op_fotos) + validacoes (Valid) + FormParaBO/BOParaForm ficam para as
*   proximas fases.
*
* FASE 6/8 - Campos Restantes e Botoes de Acao (Page2 - Parte 2 de 2):
*   Ultimos 50% dos campos: txt_4c_Indice, txt_4c_Chave, txt_4c_CProcs,
*   obj_4c_GetComparacao (EditBox - comparacao eh text no schema, sem MaxLength),
*   obj_4c_Op_fotos (OptionGroup Sim/Nao) + labels correspondentes (lbl_4c_Label2/
*   3/4/8/21). SEM lookups neste form (confirmado via grep no fonte legado: nenhum
*   fwbuscaext/fwBuscaSel/sigacess). cnt_4c_BotoesAcao populado com cmd_4c_Confirmar/
*   cmd_4c_Cancelar + FormParaBO/BOParaForm/HabilitarCampos/LimparCampos/
*   BtnSalvarClick/BtnCancelarClick implementados (validacoes de negocio ja
*   centralizadas em TPRBO.ValidarDados desde a Fase 2).
*
* FASE 7/8 - Eventos Principais (CRUD da Page1):
*   BtnIncluirClick/BtnVisualizarClick/BtnAlterarClick/BtnExcluirClick
*   implementados (leem cidchaves da linha selecionada em cursor_4c_Dados,
*   chamam NovoRegistro()/EditarRegistro()/CarregarPorCodigo()/Excluir() do
*   TPRBO e navegam Page1<->Page2 via AlternarPagina).
*
* FASE 8/8 - Eventos Auxiliares e Consolidacao Final:
*   BtnBuscarClick (recarrega a lista) e BtnEncerrarClick (fecha o form,
*   libera cursor_4c_Dados) implementados. AjustarBotoesPorModo() adicionado
*   e chamado em Incluir/Alterar/Visualizar (Confirmar desabilitado em modo
*   VISUALIZAR, Cancelar sempre habilitado). Integracao concluida:
*   config.prg carrega TPRBO.prg/FormTPR.prg via ADIR() dinamico (sem SET
*   PROCEDURE manual); menu.prg tem DEFINE BAR 187 OF popCadastros +
*   ON SELECTION + PROCEDURE AbrirFormTPR(). Form completo e integrado.
*==============================================================================

DEFINE CLASS FormTPR AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: Height/Width/Caption EXATOS do original)
    Height      = 600
    Width       = 1000
    Caption     = "Subtipos de Transportes"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual       = "LISTA"

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
            THIS.this_oBusinessObject = CREATEOBJECT("TPRBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar TPRBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormTPR.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Visible = .T.

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormTPR:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormTPR.InicializarForm")
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
    * ConfigurarPaginaLista - Estrutura base de Page1 (Lista)
    * Cabecalho completo (regra #11) + container de botoes CRUD ainda VAZIO
    * (grid e os 5 botoes/cnt_4c_Saida entram na Fase 4).
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (cntSombra no legado)
        *-- Original: Top=2 (default da classe). Com compensacao +29: Top=31
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
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

        *-- Container Botoes CRUD (Grupo_op no legado: Left=312, Top=-1, Width=421, Height=85)
        *-- Canonico: Left=542, Top=29 (-1+29 compensacao), Width=390, Height=85
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
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
            .WordWrap        = .T.
            .AutoSize        = .F.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Botao Visualizar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
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
            .WordWrap        = .T.
            .AutoSize        = .F.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Botao Alterar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 155
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
            .WordWrap        = .T.
            .AutoSize        = .F.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Botao Excluir
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 230
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
            .WordWrap        = .T.
            .AutoSize        = .F.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Botao Buscar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 305
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
            .WordWrap        = .T.
            .AutoSize        = .F.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container de Saida (Encerrar) - PADRAO CANONICO (CLAUDE.md regra #10,
        *-- prevalece sobre o SCX legado do Grupo_Saida)
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
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
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
            .WordWrap        = .T.
            .AutoSize        = .F.
            .MousePointer    = 15
            .Cancel          = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de Lista (colunas configuradas em CarregarLista/BtnBuscarClick,
        *-- cursor_4c_Dados e criado por TPRBO.Buscar())
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 26
            .Width              = 890
            .Height             = 498
            .ColumnCount        = 1
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
            .Visible            = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Estrutura base de Page2 (Dados)
    * Cabecalho completo (regra #11 - faixa nas duas paginas) + container de
    * botoes de acao ainda VAZIO (Confirmar/Cancelar entram em fase posterior).
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho cinza (identico ao da pagina Lista) - regra #11 CLAUDE.md
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
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

        *-- Container BotoesAcao (Grupo_Salva legado: Left=5, Top=4 [Page-relative],
        *-- efetivo com compensacao +29 = 33). Canonico usado nos demais forms CRUD: Left=842
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar (Grupo_Salva.Salva no legado)
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
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
            .WordWrap        = .T.
            .AutoSize        = .F.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        *-- Botao Cancelar (Grupo_Salva.Cancelar no legado)
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
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
            .WordWrap        = .T.
            .AutoSize        = .F.
            .MousePointer    = 15
            .Cancel          = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- FASE 5/8: primeiros 50% dos campos (labels/textbox). Compensacao
        *-- +29 (PageFrame.Top=-29) aplicada a TODOS os Top do SCX legado.
        *-- Labels classe "say": legado nao declara Width/Alignment (AutoSize=.T.)
        *-- -> Width medido em layout.json + Alignment=0 (regra #23 CLAUDE.md).

        *-- Say7 "Tipo Transporte :" (Top=145+29) / getTpTrans (Top=141+29)
        loc_oPagina.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPagina.lbl_4c_Label7
            .Caption   = "Tipo Transporte :"
            .Top       = 174
            .Left      = 108
            .Width     = 97
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- getTpTrans: crSigPrTro.TpTrans (tptrans char(6)) - MaxLength do schema
        loc_oPagina.AddObject("txt_4c_TpTrans", "TextBox")
        WITH loc_oPagina.txt_4c_TpTrans
            .Value         = ""
            .Top           = 170
            .Left          = 212
            .Width         = 52
            .Height        = 25
            .Alignment     = 3
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .MaxLength     = 6
            .Visible       = .T.
        ENDWITH

        *-- Say6 "Descricao :" / getObs (obs char(40))
        loc_oPagina.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPagina.lbl_4c_Label6
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 201
            .Left      = 138
            .Width     = 67
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Obs", "TextBox")
        WITH loc_oPagina.txt_4c_Obs
            .Value         = ""
            .Top           = 196
            .Left          = 212
            .Width         = 290
            .Height        = 25
            .Alignment     = 3
            .Format        = "K!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .MaxLength     = 40
            .Visible       = .T.
        ENDWITH

        *-- Say5 "Codigo do Transporte :" / getTps (tps char(1))
        loc_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPagina.lbl_4c_Label5
            .Caption   = "C" + CHR(243) + "digo do Transporte :"
            .Top       = 227
            .Left      = 70
            .Width     = 135
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Tps", "TextBox")
        WITH loc_oPagina.txt_4c_Tps
            .Value         = ""
            .Top           = 222
            .Left          = 212
            .Width         = 17
            .Height        = 25
            .Alignment     = 3
            .Format        = "K!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .MaxLength     = 1
            .Visible       = .T.
        ENDWITH

        *-- lbl_estoque "Tipo (T/R) :" / getRecTrans (rectrans char(1), so T/R)
        loc_oPagina.AddObject("lbl_4c_Lbl_estoque", "Label")
        WITH loc_oPagina.lbl_4c_Lbl_estoque
            .Caption   = "Tipo (T/R) :"
            .Top       = 253
            .Left      = 136
            .Width     = 69
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_RecTrans", "TextBox")
        WITH loc_oPagina.txt_4c_RecTrans
            .Value         = ""
            .Top           = 248
            .Left          = 212
            .Width         = 17
            .Height        = 25
            .Alignment     = 3
            .Format        = "K!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .MaxLength     = 1
            .Visible       = .T.
        ENDWITH

        *-- Say9 "Ordem :" / get_Ordem (ordems numeric(2,0))
        loc_oPagina.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oPagina.lbl_4c_Label9
            .Caption   = "Ordem :"
            .Top       = 278
            .Left      = 155
            .Width     = 50
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c__Ordem", "TextBox")
        WITH loc_oPagina.txt_4c__Ordem
            .Value         = 0
            .Top           = 273
            .Left          = 212
            .Width         = 17
            .Height        = 25
            .Alignment     = 3
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .InputMask     = "99"
            .Visible       = .T.
        ENDWITH

        *-- Say1 "Tabela :" / getDbf (dbf char(8))
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "Tabela :"
            .Top       = 305
            .Left      = 156
            .Width     = 49
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Dbf", "TextBox")
        WITH loc_oPagina.txt_4c_Dbf
            .Value         = ""
            .Top           = 300
            .Left          = 212
            .Width         = 66
            .Height        = 25
            .Alignment     = 3
            .Format        = "K!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .MaxLength     = 8
            .Visible       = .T.
        ENDWITH

        *-- FASE 6/8: ultimos 50% dos campos (labels/textbox). Compensacao +29
        *-- aplicada a TODOS os Top do SCX legado. Sem lookups neste form (nenhum
        *-- fwbuscaext/fwBuscaSel/sigacess no fonte legado - confirmado via grep).

        *-- Say9 "Ordem :" ja adicionado na Fase 5. Say2 "Indice :" (Top=302+29) / getIndice (Top=297+29)
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = CHR(205) + "ndice :"
            .Top       = 331
            .Left      = 159
            .Width     = 46
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- getIndice: crSigPrTro.Indice (indice char(15)) - MaxLength do schema
        loc_oPagina.AddObject("txt_4c_Indice", "TextBox")
        WITH loc_oPagina.txt_4c_Indice
            .Value         = ""
            .Top           = 326
            .Left          = 212
            .Width         = 115
            .Height        = 25
            .Alignment     = 3
            .Format        = "K!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .MaxLength     = 15
            .Visible       = .T.
        ENDWITH

        *-- Say3 "Chave :" / getChave (chave char(40))
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "Chave :"
            .Top       = 357
            .Left      = 157
            .Width     = 48
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Chave", "TextBox")
        WITH loc_oPagina.txt_4c_Chave
            .Value         = ""
            .Top           = 352
            .Left          = 212
            .Width         = 290
            .Height        = 25
            .Alignment     = 3
            .Format        = "K!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .MaxLength     = 40
            .Visible       = .T.
        ENDWITH

        *-- Say4 "Processo :" / getCProcs (cprocs char(15))
        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Caption   = "Processo :"
            .Top       = 383
            .Left      = 143
            .Width     = 62
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_CProcs", "TextBox")
        WITH loc_oPagina.txt_4c_CProcs
            .Value         = ""
            .Top           = 378
            .Left          = 212
            .Width         = 115
            .Height        = 25
            .Alignment     = 3
            .Format        = "K!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .MaxLength     = 15
            .Visible       = .T.
        ENDWITH

        *-- Say21 "Foto :" / op_fotos (fotos numeric(1,0), Value default=1/Sim)
        loc_oPagina.AddObject("lbl_4c_Label21", "Label")
        WITH loc_oPagina.lbl_4c_Label21
            .Caption   = "Foto :"
            .Top       = 406
            .Left      = 170
            .Width     = 35
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_Op_fotos", "OptionGroup")
        WITH loc_oPagina.obj_4c_Op_fotos
            .ButtonCount = 2
            .Top         = 404
            .Left        = 212
            .Width       = 94
            .Height      = 20
            .Value       = 1
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH

        WITH loc_oPagina.obj_4c_Op_fotos.Buttons(1)
            .Caption   = "Sim"
            .BackStyle = 0
            .Value     = 1
            .Left      = 5
            .Top       = 2
            .Width     = 40
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        WITH loc_oPagina.obj_4c_Op_fotos.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .BackStyle = 0
            .Left      = 49
            .Top       = 2
            .Width     = 35
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- Say8 "Comando :" / getComparacao (comparacao text - EditBox, sem MaxLength)
        loc_oPagina.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPagina.lbl_4c_Label8
            .Caption   = "Comando :"
            .Top       = 428
            .Left      = 139
            .Width     = 66
            .Height    = 17
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("obj_4c_GetComparacao", "EditBox")
        WITH loc_oPagina.obj_4c_GetComparacao
            .Value         = ""
            .Top           = 425
            .Left          = 212
            .Width         = 516
            .Height        = 76
            .FontName      = "Courier New"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * Percorre Pages (PageFrame) e Controls (Container) recursivamente
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
    * CarregarLista - Busca subtipos de transporte e popula grd_4c_Lista
    * Legado: "Select * From SigPrTro Where TpTrans = ? Order BY RecTrans,Tps,ordems"
    * (TPRBO.Buscar cobre a mesma ordenacao; filtro por TpTrans fica para o
    * BtnBuscarClick, ja que este form nao restringe a lista a um TpTrans fixo)
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oGrid
        loc_lSucesso = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            IF !USED("cursor_4c_Dados")
                SET NULL ON
                CREATE CURSOR cursor_4c_Dados (cidchaves C(20), tptrans C(6), tps C(1), ;
                    rectrans C(1), dbf C(8), obs C(40), cprocs C(15), indice C(15), ;
                    ordems N(2,0), fotos N(1,0))
                SET NULL OFF
            ENDIF
            RETURN .T.
        ENDIF

        TRY
            IF !THIS.this_oBusinessObject.Buscar("")
                loc_lSucesso = .F.
            ELSE
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                *-- RecordSource e ColumnCount FORA de WITH (Problema 36); ControlSource
                *-- e Header1.Caption SEMPRE redefinidos APOS o RecordSource (Problema 48)
                loc_oGrid.ColumnCount  = 3
                loc_oGrid.RecordSource = "cursor_4c_Dados"
                loc_oGrid.ColumnCount  = 7

                WITH loc_oGrid
                    .Column1.ControlSource   = "cursor_4c_Dados.tptrans"
                    .Column1.Width           = 90
                    .Column1.Header1.Caption = "Tipo Transporte"

                    .Column2.ControlSource   = "cursor_4c_Dados.tps"
                    .Column2.Width           = 60
                    .Column2.Header1.Caption = "C" + CHR(243) + "digo"

                    .Column3.ControlSource   = "cursor_4c_Dados.obs"
                    .Column3.Width           = 260
                    .Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

                    .Column4.ControlSource   = "cursor_4c_Dados.rectrans"
                    .Column4.Width           = 70
                    .Column4.Header1.Caption = "Tipo (T/R)"

                    .Column5.ControlSource   = "cursor_4c_Dados.dbf"
                    .Column5.Width           = 100
                    .Column5.Header1.Caption = "Tabela"

                    .Column6.ControlSource   = "cursor_4c_Dados.cprocs"
                    .Column6.Width           = 140
                    .Column6.Header1.Caption = "Processo"

                    .Column7.ControlSource   = "cursor_4c_Dados.ordems"
                    .Column7.Width           = 60
                    .Column7.Header1.Caption = "Ordem"

                    .Refresh()
                ENDWITH

                THIS.FormatarGridLista(loc_oGrid)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar lista de subtipos de transporte:" + CHR(13) + ;
                loException.Message, "FormTPR.CarregarLista")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * FormatarGridLista - Formata visual do grid da lista
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *===========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    *===========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.CarregarLista()
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + ;
                loException.Message, "FormTPR.AlternarPagina")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere valores dos campos da Page2 para o BusinessObject
    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.this_cTpTrans    = ALLTRIM(loc_oPg2.txt_4c_TpTrans.Value)
        THIS.this_oBusinessObject.this_cObs        = ALLTRIM(loc_oPg2.txt_4c_Obs.Value)
        THIS.this_oBusinessObject.this_cTps        = ALLTRIM(loc_oPg2.txt_4c_Tps.Value)
        THIS.this_oBusinessObject.this_cRecTrans   = ALLTRIM(loc_oPg2.txt_4c_RecTrans.Value)
        THIS.this_oBusinessObject.this_nOrdems     = loc_oPg2.txt_4c__Ordem.Value
        THIS.this_oBusinessObject.this_cDbf        = ALLTRIM(loc_oPg2.txt_4c_Dbf.Value)
        THIS.this_oBusinessObject.this_cIndice     = ALLTRIM(loc_oPg2.txt_4c_Indice.Value)
        THIS.this_oBusinessObject.this_cChave      = ALLTRIM(loc_oPg2.txt_4c_Chave.Value)
        THIS.this_oBusinessObject.this_cCProcs     = ALLTRIM(loc_oPg2.txt_4c_CProcs.Value)
        THIS.this_oBusinessObject.this_cComparacao = ALLTRIM(loc_oPg2.obj_4c_GetComparacao.Value)
        THIS.this_oBusinessObject.this_nFotos      = loc_oPg2.obj_4c_Op_fotos.Value
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere valores do BusinessObject para os campos da Page2
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_TpTrans.Value        = THIS.this_oBusinessObject.this_cTpTrans
        loc_oPg2.txt_4c_Obs.Value            = THIS.this_oBusinessObject.this_cObs
        loc_oPg2.txt_4c_Tps.Value            = THIS.this_oBusinessObject.this_cTps
        loc_oPg2.txt_4c_RecTrans.Value       = THIS.this_oBusinessObject.this_cRecTrans
        loc_oPg2.txt_4c__Ordem.Value         = THIS.this_oBusinessObject.this_nOrdems
        loc_oPg2.txt_4c_Dbf.Value            = THIS.this_oBusinessObject.this_cDbf
        loc_oPg2.txt_4c_Indice.Value         = THIS.this_oBusinessObject.this_cIndice
        loc_oPg2.txt_4c_Chave.Value          = THIS.this_oBusinessObject.this_cChave
        loc_oPg2.txt_4c_CProcs.Value         = THIS.this_oBusinessObject.this_cCProcs
        loc_oPg2.obj_4c_GetComparacao.Value  = THIS.this_oBusinessObject.this_cComparacao
        loc_oPg2.obj_4c_Op_fotos.Value       = THIS.this_oBusinessObject.this_nFotos
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa os campos da Page2 (usado antes de INCLUIR)
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_TpTrans.Value        = ""
        loc_oPg2.txt_4c_Obs.Value            = ""
        loc_oPg2.txt_4c_Tps.Value            = ""
        loc_oPg2.txt_4c_RecTrans.Value       = ""
        loc_oPg2.txt_4c__Ordem.Value         = 0
        loc_oPg2.txt_4c_Dbf.Value            = ""
        loc_oPg2.txt_4c_Indice.Value         = ""
        loc_oPg2.txt_4c_Chave.Value          = ""
        loc_oPg2.txt_4c_CProcs.Value         = ""
        loc_oPg2.obj_4c_GetComparacao.Value  = ""
        loc_oPg2.obj_4c_Op_fotos.Value       = 1
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita/desabilita os campos de dados da Page2
    * cmd_4c_Confirmar acompanha o mesmo estado (somente leitura em VISUALIZAR)
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_TpTrans.Enabled       = par_lHabilitar
        loc_oPg2.txt_4c_Obs.Enabled           = par_lHabilitar
        loc_oPg2.txt_4c_Tps.Enabled           = par_lHabilitar
        loc_oPg2.txt_4c_RecTrans.Enabled      = par_lHabilitar
        loc_oPg2.txt_4c__Ordem.Enabled        = par_lHabilitar
        loc_oPg2.txt_4c_Dbf.Enabled           = par_lHabilitar
        loc_oPg2.txt_4c_Indice.Enabled        = par_lHabilitar
        loc_oPg2.txt_4c_Chave.Enabled         = par_lHabilitar
        loc_oPg2.txt_4c_CProcs.Enabled        = par_lHabilitar
        loc_oPg2.obj_4c_GetComparacao.Enabled = par_lHabilitar
        loc_oPg2.obj_4c_Op_fotos.Enabled      = par_lHabilitar

        loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Confirma a gravacao do registro (Grupo_Salva.Salva no legado)
    * Validacoes (ValidarDados) e Inserir/Atualizar ficam no TPRBO
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        TRY
            THIS.FormParaBO()

            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Subtipo de transporte salvo com sucesso.", "Sucesso")
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
            ELSE
                IF !THIS.this_oBusinessObject.this_lErroExibido
                    MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
                        "vel gravar o registro.", "Confirmar")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao salvar subtipo de transporte:" + CHR(13) + ;
                loException.Message, "FormTPR.BtnSalvarClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancela a edicao e retorna para a lista (Grupo_Salva.Cancelar)
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Ajusta cmd_4c_Confirmar/cmd_4c_Cancelar conforme
    * this_cModoAtual. Em VISUALIZAR o Confirmar fica desabilitado (somente
    * leitura) e o Cancelar permanece habilitado para voltar a lista.
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oBotoesAcao
        loc_oBotoesAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao

        DO CASE
            CASE THIS.this_cModoAtual = "VISUALIZAR"
                loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = .F.
                loc_oBotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
            CASE INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = .T.
                loc_oBotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
            OTHERWISE
                loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = .T.
                loc_oBotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
        ENDCASE
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Prepara o BO para inclusao e navega para Page2
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Carrega o registro selecionado em modo somente leitura
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum subtipo de transporte selecionado.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Dados
        IF EOF("cursor_4c_Dados")
            MsgAviso("Nenhum subtipo de transporte selecionado.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        loc_cCodigo = ALLTRIM(cursor_4c_Dados.cidchaves)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.BOParaForm()
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Carrega o registro selecionado em modo de edicao
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum subtipo de transporte selecionado.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Dados
        IF EOF("cursor_4c_Dados")
            MsgAviso("Nenhum subtipo de transporte selecionado.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        loc_cCodigo = ALLTRIM(cursor_4c_Dados.cidchaves)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.BOParaForm()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Exclui o registro selecionado apos confirmacao
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_cDescricao, loc_lConfirmado

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum subtipo de transporte selecionado.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Dados
        IF EOF("cursor_4c_Dados")
            MsgAviso("Nenhum subtipo de transporte selecionado.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        loc_cCodigo    = ALLTRIM(cursor_4c_Dados.cidchaves)
        loc_cDescricao = ALLTRIM(cursor_4c_Dados.obs)

        loc_lConfirmado = MsgConfirma("Excluir o subtipo de transporte [" + loc_cDescricao + "]?", ;
            "Confirmar Exclus" + CHR(227) + "o")

        IF loc_lConfirmado
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Subtipo de transporte exclu" + CHR(237) + "do com sucesso.", "Sucesso")
                    THIS.CarregarLista()
                ELSE
                    IF !THIS.this_oBusinessObject.this_lErroExibido
                        MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
                            "vel excluir o registro.", "Confirmar")
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Recarrega a lista de subtipos de transporte
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        TRY
            THIS.CarregarLista()
        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "FormTPR.BtnBuscarClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        THIS.Release()
    ENDPROC

    *===========================================================================
    * Destroy - Libera recursos ao fechar o formulario
    *===========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
