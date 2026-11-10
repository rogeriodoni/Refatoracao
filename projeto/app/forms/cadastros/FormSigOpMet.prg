*==============================================================================
* FormSigOpMet.prg - Formulario de Cadastro de Metas por Loja
* Migrado de: SIGOPMET.SCX (frmcadastro)
*
* FASE 4/8 - Grid e Botoes CRUD (Page1): grd_4c_Lista ligado a
* cursor_4c_Dados (SigOpMetBO.Buscar), cnt_4c_Botoes com 5 botoes CRUD
* (Incluir/Visualizar/Alterar/Excluir/Buscar), cnt_4c_Saida com
* cmd_4c_Encerrar (CLAUDE.md regra #10), CarregarLista() e
* AlternarPagina().
*
* FASE 7/8 - Eventos principais dos botoes CRUD: BtnIncluirClick,
* BtnVisualizarClick, BtnAlterarClick, BtnExcluirClick (PUBLIC, com
* BINDEVENT ligado em ConfigurarPaginaLista - regra #17). Usam
* NovoRegistro()/EditarRegistro()/Excluir() do BO.
*
* FASE 8/8 - Eventos auxiliares e consolidacao final: BtnSalvarClick/
* BtnCancelarClick (Page2, BINDEVENT em ConfigurarPaginaDados),
* BtnBuscarClick/BtnEncerrarClick (Page1), FormParaBO()/BOParaForm()
* (so Codigo+Emps - ver ATENCAO em ConfigurarPaginaDados sobre os
* demais campos nao terem property no BO), HabilitarCampos(),
* LimparCampos() e AjustarBotoesPorModo() (desabilita os 5 botoes CRUD
* da Lista ao entrar em Dados e reabilita no funil de AlternarPagina -
* CLAUDE.md regra #40).
*==============================================================================

DEFINE CLASS FormSigOpMet AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: Height/Width/Caption EXATOS do original)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Metas por Loja"
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
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpMetBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar SigOpMetBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormSigOpMet.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                THIS.CarregarLista()
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormSigOpMet:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormSigOpMet.InicializarForm")
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
    * FASE 4/8: cabecalho + cnt_4c_Botoes (5 botoes CRUD) + cnt_4c_Saida
    * (cmd_4c_Encerrar, CLAUDE.md regra #10) + grd_4c_Lista (9 colunas,
    * ligado a cursor_4c_Dados por SigOpMetBO.Buscar). Click handlers e
    * BINDEVENT ficam para as Fases 7-8.
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (cntSombra no legado) - PRIMEIRO AddObject da pagina
        *-- Original: Top=1. Com compensacao +29: Top=31
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

        *-- Container Botoes CRUD (Grupo_op no legado: Left=544, Top=-1, Width=385, Height=85)
        *-- Canonico: Top=29 (-1+29 compensacao), Left=542, Width=390, Height=85
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container Saida - valores canonicos CLAUDE.md regra #10 (prevalece sobre o
        *-- legado Grupo_Saida.Left=919/cmdSair.Caption="SAIR"). Flutuante/transparente
        *-- sobre a Page; a Page NAO subtrai espaco por causa deste container.
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
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de lista (metas por loja - cursor_4c_Dados, ver SigOpMetBO.Buscar)
        *-- Legado: Pagina.Lista.Grade (Top=130, Left=29, Width=940, Height=463)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 130
            .Left               = 29
            .Width              = 940
            .Height             = 463
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
        loc_oPagina.grd_4c_Lista.ColumnCount = 9

        *-- Colunas espelham o pColuna do Init legado (regra #35b), nao o
        *-- header desenhado no SCX: Codigo, Estado, Loja, Nome da Loja, Data,
        *-- Vr Meta, Desafio, Usuario, Alteracao
        WITH loc_oPagina.grd_4c_Lista
            .Column1.Header1.Caption = "Codigo"
            .Column1.Width           = 100

            .Column2.Header1.Caption = "Estado"
            .Column2.Width           = 75

            .Column3.Header1.Caption = "Loja"
            .Column3.Width           = 75

            .Column4.Header1.Caption = "Nome da Loja"
            .Column4.Width           = 150

            .Column5.Header1.Caption = "Data"
            .Column5.Width           = 75

            .Column6.Header1.Caption = "Vr Meta"
            .Column6.Width           = 75
            .Column6.Alignment       = 1

            .Column7.Header1.Caption = "Desafio"
            .Column7.Width           = 75
            .Column7.Alignment       = 1

            .Column8.Header1.Caption = "Usu" + CHR(225) + "rio"
            .Column8.Width           = 75

            .Column9.Header1.Caption = "Alteracao"
            .Column9.Width           = 75
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Configura Page2 (Dados)
    * FASE 6/8: cabecalho + container de botoes de acao (cnt_4c_BotoesAcao
    * com cmd_4c_Confirmar/cmd_4c_Cancelar) + TODOS os campos (TabIndex 1 a
    * 8 do SCX legado): Codigo, Empresa, Data Inicial, Data Final, Meta de
    * Vendas, Cota Desconto $, Desconto Aplicado $, Cota Desconto %. Sem
    * lookups (comportamento.json: nenhum metodo do form tem temLookup=.T.).
    * Click handlers de Confirmar/Cancelar ficam para as Fases 7-8.
    *
    * Geometria/fonte/cor TRANSCRITAS do dump SCX (PILAR 1). Top compensado
    * em +29 por causa de pgf_4c_Paginas.Top = -29. Labels da classe `say`
    * nao declaram Width/Alignment no dump: Alignment = 0 e AutoSize = .F.
    * com Width explicita que termina rente ao campo (CLAUDE.md regra #23).
    *
    * ATENCAO (divergencia HERDADA do legado - nao e' erro de migracao):
    * TODOS os controles desta pagina no SCX apontam ControlSource para o
    * cursor CrSigCdDes (tabela SigCdDes), que o Init do legado NUNCA cria -
    * ele so faz AddCursor('SigOpMet',...) para a grade da Lista. Logo:
    *   - Codigo (char 10) e Empresa (char 3) existem nas DUAS tabelas e
    *     casam com SigOpMetBO.this_cCodigo / this_cEmps;
    *   - Data Inicial/Final (dtini/dtfin), Meta de Vendas (valmeta), Cota
    *     Desconto $ (valcota) e Desconto Aplicado $ (valdes) existem SO em
    *     SigCdDes - "valmeta" ali e' column DIFERENTE de SigOpMet.valmeta
    *     (this_nValMeta), mera coincidencia de nome entre tabelas distintas
    *     (schema conferido em docs/schema.sql: SigCdDes NAO tem FK para
    *     SigOpMet). getpdes (Cota Desconto %) tem ControlSource = "" no
    *     dump - nem SigCdDes tem coluna "pdes".
    * Os controles sao reproduzidos por fidelidade visual, mas NAO devem
    * inventar property no BO nem coluna no INSERT/UPDATE para
    * dtini/dtfin/valmeta(Dados)/valcota/valdes/pdes - isso violaria o
    * PILAR 2. Nao usar ControlSource: a transferencia e' feita por
    * FormParaBO/BOParaForm (que tocam apenas Codigo/Empresa).
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (faixa tambem na pagina Dados - regra #11) - PRIMEIRO AddObject
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

        *-- Container Botoes de Acao (Grupo_Salva no legado)
        *-- Canonico: Left=842, Top=33, Width=160, Height=85 (fica POR CIMA da faixa)
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
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

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
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *----------------------------------------------------------------------
        * CAMPO 1 (TabIndex 1): Codigo - SigOpMet.codigo char(10)
        *   Say7:      left=445, top=154 -> 183   Caption "Codigo : "
        *   getcodigo: left=492, top=149 -> 178, width=80, height=24
        *              InputMask "!!!!!!!!!!" (10 posicoes maiusculas)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPagina.lbl_4c_Label7
            .Caption   = "C" + CHR(243) + "digo : "
            .Top       = 183
            .Left      = 445
            .Width     = 47
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Value         = ""
            .Top           = 178
            .Left          = 492
            .Width         = 80
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "!!!!!!!!!!"
            .MaxLength     = 10
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .SpecialEffect = 1
            .Themes        = .F.
            .TabIndex      = 1
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * CAMPO 2 (TabIndex 2): Empresa - SigOpMet.emps char(3)
        *   Say1:    left=437, top=181 -> 210   Caption "Empresa : "
        *   getEmps: left=492, top=176 -> 205, width=33, height=24 (sem InputMask)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "Empresa : "
            .Top       = 210
            .Left      = 437
            .Width     = 55
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Emps", "TextBox")
        WITH loc_oPagina.txt_4c_Emps
            .Value         = ""
            .Top           = 205
            .Left          = 492
            .Width         = 33
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 3
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .SpecialEffect = 1
            .Themes        = .F.
            .TabIndex      = 2
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * CAMPO 3 (TabIndex 3): Data Inicial - SigCdDes.dtini datetime
        *   SEM coluna em SigOpMet (ver ATENCAO no cabecalho do metodo)
        *   Say5:     left=425, top=208 -> 237   Caption "Data Inicial : "
        *   getDtini: left=492, top=203 -> 232, width=80, height=24, Alignment=3
        *             Format/InputMask sao override VAZIO no dump: nao transcrever
        *             (CLAUDE.md regra #49). A exibicao dd/mm/yyyy vem do
        *             SET DATE BRITISH + SET CENTURY ON do FormBase.Init (regra #9.4).
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPagina.lbl_4c_Label5
            .Caption   = "Data Inicial : "
            .Top       = 237
            .Left      = 425
            .Width     = 67
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Dtini", "TextBox")
        WITH loc_oPagina.txt_4c_Dtini
            .Value         = {}
            .Top           = 232
            .Left          = 492
            .Width         = 80
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 3
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .SpecialEffect = 1
            .Themes        = .F.
            .TabIndex      = 3
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * CAMPO 4 (TabIndex 4): Data Final - SigCdDes.dtfin datetime
        *   SEM coluna em SigOpMet (ver ATENCAO no cabecalho do metodo)
        *   Say6:     left=430, top=235 -> 264   Caption "Data Final : "
        *   GetDtfin: left=492, top=230 -> 259, width=80, height=24, Alignment=3
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPagina.lbl_4c_Label6
            .Caption   = "Data Final : "
            .Top       = 264
            .Left      = 430
            .Width     = 62
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Dtfin", "TextBox")
        WITH loc_oPagina.txt_4c_Dtfin
            .Value         = {}
            .Top           = 259
            .Left          = 492
            .Width         = 80
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 3
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .SpecialEffect = 1
            .Themes        = .F.
            .TabIndex      = 4
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * CAMPO 5 (TabIndex 5): Meta de Vendas - CrSigCdDes.valmeta numeric(11,2)
        *   SEM coluna em SigOpMet (ver ATENCAO no cabecalho do metodo - e'
        *   coluna DIFERENTE de SigOpMet.valmeta/this_nValMeta)
        *   Say3:       left=401, top=262 -> 291   Caption "Meta de Vendas : "
        *   GetValmeta: left=492, top=257 -> 286, width=126, height=24
        *               Alignment=3, InputMask "99,999,999.99"
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "Meta de Vendas : "
            .Top       = 291
            .Left      = 401
            .Width     = 91
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Valmeta", "TextBox")
        WITH loc_oPagina.txt_4c_Valmeta
            .Value         = 0
            .Top           = 286
            .Left          = 492
            .Width         = 126
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 3
            .InputMask     = "99,999,999.99"
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .SpecialEffect = 1
            .Themes        = .F.
            .TabIndex      = 5
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * CAMPO 6 (TabIndex 6): Cota Desconto $ - CrSigCdDes.valcota numeric(11,2)
        *   SEM coluna em SigOpMet (ver ATENCAO no cabecalho do metodo)
        *   Say2:       left=398, top=289 -> 318   Caption "Cota Desconto $ : "
        *   getvalcota: left=492, top=284 -> 313, width=126, height=24
        *               Alignment=3, InputMask "99,999,999.99"
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Cota Desconto $ : "
            .Top       = 318
            .Left      = 398
            .Width     = 94
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Valcota", "TextBox")
        WITH loc_oPagina.txt_4c_Valcota
            .Value         = 0
            .Top           = 313
            .Left          = 492
            .Width         = 126
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 3
            .InputMask     = "99,999,999.99"
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .SpecialEffect = 1
            .Themes        = .F.
            .TabIndex      = 6
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * CAMPO 7 (TabIndex 7): Desconto Aplicado $ - CrSigCdDes.valdes numeric(11,2)
        *   SEM coluna em SigOpMet (ver ATENCAO no cabecalho do metodo)
        *   Say8:      left=381, top=316 -> 345   Caption "Desconto Aplicado $ : "
        *   getvaldes: left=492, top=311 -> 340, width=126, height=24
        *              Alignment=3, InputMask "99,999,999.99"
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPagina.lbl_4c_Label8
            .Caption   = "Desconto Aplicado $ : "
            .Top       = 345
            .Left      = 381
            .Width     = 111
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Valdes", "TextBox")
        WITH loc_oPagina.txt_4c_Valdes
            .Value         = 0
            .Top           = 340
            .Left          = 492
            .Width         = 126
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 3
            .InputMask     = "99,999,999.99"
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .SpecialEffect = 1
            .Themes        = .F.
            .TabIndex      = 7
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * CAMPO 8 (TabIndex 8): Cota Desconto % - getpdes.ControlSource = ""
        *   no dump (NEM CrSigCdDes tem coluna "pdes" - campo totalmente
        *   orfao, mais fiel ainda ao caso do cabecalho do metodo)
        *   Say4:   left=393, top=343 -> 372   Caption "Cota Desconto % : "
        *   getpdes: left=492, top=338 -> 367, width=126, height=24
        *            Alignment=3, InputMask "999.99"
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Caption   = "Cota Desconto % : "
            .Top       = 372
            .Left      = 393
            .Width     = 99
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Pdes", "TextBox")
        WITH loc_oPagina.txt_4c_Pdes
            .Value         = 0
            .Top           = 367
            .Left          = 492
            .Width         = 126
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 3
            .InputMask     = "999.99"
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .SpecialEffect = 1
            .Themes        = .F.
            .TabIndex      = 8
            .Visible       = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * REGRA: Deve iterar Pages E Controls para PageFrames
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
    * FormatarGridLista - Formata visual do grid da lista (fonte/tamanho)
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        IF VARTYPE(par_oGrid) != "O"
            RETURN
        ENDIF

        par_oGrid.FontName = "Verdana"
        par_oGrid.FontSize = 8
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
            *-- Regra #40: quem desabilita no funil de ida tem de reabilitar
            *-- no funil de volta. Chamar SEMPRE aqui, nao so no botao que entra.
            THIS.AjustarBotoesPorModo()
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * CarregarLista - Carrega metas por loja (SigOpMet) no Grid da Page1
    * Chama SigOpMetBO.Buscar("") e vincula cursor_4c_Dados ao grid.
    * Colunas (pColuna do Init legado): codigo, ufs, emps, nomeloja, datas,
    * valmeta, valmetad, usualts, dtalts
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

            IF THIS.this_oBusinessObject.Buscar("")
                loc_oGrid.ColumnCount = 9
                loc_oGrid.RecordSource          = "cursor_4c_Dados"
                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigo"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.ufs"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.emps"
                loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.nomeloja"
                loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.datas"
                loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.valmeta"
                loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.valmetad"
                loc_oGrid.Column8.ControlSource = "cursor_4c_Dados.usualts"
                loc_oGrid.Column9.ControlSource = "cursor_4c_Dados.dtalts"

                *-- Reconfigurar headers e larguras APOS RecordSource (reseta captions/Width)
                loc_oGrid.Column1.Header1.Caption = "Codigo"
                loc_oGrid.Column2.Header1.Caption = "Estado"
                loc_oGrid.Column3.Header1.Caption = "Loja"
                loc_oGrid.Column4.Header1.Caption = "Nome da Loja"
                loc_oGrid.Column5.Header1.Caption = "Data"
                loc_oGrid.Column6.Header1.Caption = "Vr Meta"
                loc_oGrid.Column7.Header1.Caption = "Desafio"
                loc_oGrid.Column8.Header1.Caption = "Usu" + CHR(225) + "rio"
                loc_oGrid.Column9.Header1.Caption = "Alteracao"

                loc_oGrid.Column1.Width = 100
                loc_oGrid.Column2.Width = 75
                loc_oGrid.Column3.Width = 75
                loc_oGrid.Column4.Width = 150
                loc_oGrid.Column5.Width = 75
                loc_oGrid.Column6.Width = 75
                loc_oGrid.Column7.Width = 75
                loc_oGrid.Column8.Width = 75
                loc_oGrid.Column9.Width = 75

                loc_oGrid.Column6.Alignment = 1
                loc_oGrid.Column7.Alignment = 1

                THIS.FormatarGridLista(loc_oGrid)
                loc_oGrid.Refresh()
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar lista: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Abre Page2 para inclusao de nova meta
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
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
    * BtnVisualizarClick - Abre Page2 em modo somente leitura
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigo)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione uma meta para visualizar.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.F.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Abre Page2 para alterar meta selecionada
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigo)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione uma meta para alterar.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.this_cModoAtual = "ALTERAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.T.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Exclui meta selecionada com confirmacao
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigo)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione uma meta para excluir.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da meta [" + loc_cCodigo + "]?", ;
                    "Confirmar Exclus" + CHR(227) + "o")
                    IF THIS.this_oBusinessObject.Excluir()
                        MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
                        THIS.CarregarLista()
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Recarrega a lista de metas (5o botao CRUD padrao do
    * framework: Incluir/Visualizar/Alterar/Excluir/Buscar). Nao ha
    * cnt_4c_Filtros nesta pagina (nenhum campo de filtro no dump legado
    * nem PROCEDURE msv_procurar) - Buscar equivale a atualizar a grade.
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario (cnt_4c_Saida.cmd_4c_Encerrar)
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Valida e grava a meta (Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar)
    * Salvar() SEM parametro (BusinessBase decide INSERT/UPDATE via
    * this_lNovoRegistro, setado por NovoRegistro()/EditarRegistro()).
    * Regra #20: sem ELSE generico - BusinessBase.Salvar() ja chama
    * ExibirFalha() em todo caminho que falha; so complementar quando
    * this_lErroExibido continuar .F.
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPg

        loc_oPg = THIS.pgf_4c_Paginas.Page2

        IF EMPTY(ALLTRIM(loc_oPg.txt_4c_Codigo.Value))
            MsgAviso("Informe o c" + CHR(243) + "digo da meta!")
        ELSE
            IF EMPTY(ALLTRIM(loc_oPg.txt_4c_Emps.Value))
                MsgAviso("Informe a empresa (loja)!")
            ELSE
                THIS.FormParaBO()

                IF THIS.this_oBusinessObject.Salvar()
                    MsgInfo("Registro salvo com sucesso!")
                    THIS.AlternarPagina(1)
                ELSE
                    IF !THIS.this_oBusinessObject.this_lErroExibido
                        MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o registro.", "Confirmar")
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancela edicao e volta para a Lista
    * (Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar)
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.this_oBusinessObject.CancelarEdicao()
        THIS.AlternarPagina(1)
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere Form -> BO (chamado antes de Salvar)
    * Apenas Codigo e Emps tem property no BO - ver ATENCAO no cabecalho
    * de ConfigurarPaginaDados: os demais campos da pagina (Dtini/Dtfin/
    * Valmeta/Valcota/Valdes/Pdes) pertencem visualmente a SigCdDes no
    * legado e nao tem coluna correspondente em SigOpMet (PILAR 2 - nao
    * inventar property/coluna).
    *===========================================================================
    PROCEDURE FormParaBO()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.this_cCodigo = ALLTRIM(loc_oPg.txt_4c_Codigo.Value)
        THIS.this_oBusinessObject.this_cEmps   = ALLTRIM(loc_oPg.txt_4c_Emps.Value)
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere BO -> Form (chamado apos Carregar)
    * Codigo/Emps vem do BO; os demais campos (sem property no BO - ver
    * FormParaBO) voltam ao valor default, pois nao fazem parte do
    * registro de SigOpMet.
    *===========================================================================
    PROCEDURE BOParaForm()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2

        loc_oPg.txt_4c_Codigo.Value = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
        loc_oPg.txt_4c_Emps.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cEmps)

        loc_oPg.txt_4c_Dtini.Value   = {}
        loc_oPg.txt_4c_Dtfin.Value   = {}
        loc_oPg.txt_4c_Valmeta.Value = 0
        loc_oPg.txt_4c_Valcota.Value = 0
        loc_oPg.txt_4c_Valdes.Value  = 0
        loc_oPg.txt_4c_Pdes.Value    = 0
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita/desabilita os campos de Page2
    * Codigo (PK) so fica editavel em modo INCLUIR (regra geral de PK);
    * os demais acompanham par_lHabilitar.
    *===========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2

        loc_oPg.txt_4c_Codigo.Enabled  = par_lHabilitar AND THIS.this_cModoAtual == "INCLUIR"
        loc_oPg.txt_4c_Emps.Enabled    = par_lHabilitar
        loc_oPg.txt_4c_Dtini.Enabled   = par_lHabilitar
        loc_oPg.txt_4c_Dtfin.Enabled   = par_lHabilitar
        loc_oPg.txt_4c_Valmeta.Enabled = par_lHabilitar
        loc_oPg.txt_4c_Valcota.Enabled = par_lHabilitar
        loc_oPg.txt_4c_Valdes.Enabled  = par_lHabilitar
        loc_oPg.txt_4c_Pdes.Enabled    = par_lHabilitar
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa os valores dos campos de Page2
    *===========================================================================
    PROCEDURE LimparCampos()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2

        loc_oPg.txt_4c_Codigo.Value  = ""
        loc_oPg.txt_4c_Emps.Value    = ""
        loc_oPg.txt_4c_Dtini.Value   = {}
        loc_oPg.txt_4c_Dtfin.Value   = {}
        loc_oPg.txt_4c_Valmeta.Value = 0
        loc_oPg.txt_4c_Valcota.Value = 0
        loc_oPg.txt_4c_Valdes.Value  = 0
        loc_oPg.txt_4c_Pdes.Value    = 0
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Ajusta botoes conforme this_cModoAtual
    * - Page1: os 5 botoes CRUD ficam desabilitados fora do modo LISTA
    *   (CLAUDE.md regra #40 - reabilitados pelo proprio AlternarPagina(1))
    * - Page2: Confirmar desabilitado em modo VISUALIZAR (somente leitura),
    *   Cancelar sempre habilitado (permite voltar/fechar a visualizacao)
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg1, loc_oPg2, loc_lListaAtiva

        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_lListaAtiva = (THIS.this_cModoAtual == "LISTA")

        loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = loc_lListaAtiva
        loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lListaAtiva
        loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lListaAtiva
        loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lListaAtiva
        loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = loc_lListaAtiva

        loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = !(THIS.this_cModoAtual == "VISUALIZAR")
        loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
    ENDPROC

    *===========================================================================
    * Destroy - Finaliza o formulario
    *===========================================================================
    PROCEDURE Destroy()
        RETURN DODEFAULT()
    ENDPROC

ENDDEFINE
