*============================================================================
* Formsigopdiv.prg - Separa/Reinicia Industrializa" + CHR(231) + CHR(227) + "o
* Tipo: OPERACIONAL - Divide ou Reinicia Ordens de Producao
* Tabelas principais: SigOpPic, SigCdNec, SigCdNei, SigPdMvf, SigCdOpd
* Fase 7/8: Form completo com eventos principais (GrupoSalvaClick/GrupoConfClick)
*============================================================================
DEFINE CLASS Formsigopdiv AS FormBase

    *-- Layout (pixel-perfect do legado)
    Width       = 830
    Height      = 527
    AutoCenter  = .T.
    BorderStyle = 2
    TitleBar    = 0
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    WindowType  = 1
    DataSession = 2
    Themes      = .F.
    ShowWindow  = 1
    KeyPreview  = .F.

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cMensagemErro   = ""
    this_cOperacao       = "D"    && 'D'=Divisao, 'R'=Reinicia
    this_lAutomatico     = .F.

    *==========================================================================
    * Init - Aceita parametro de operacao antes de chamar FormBase.Init
    *==========================================================================
    PROCEDURE Init(par_cOperacao)
        IF VARTYPE(par_cOperacao) = "C" AND !EMPTY(par_cOperacao)
            THIS.this_cOperacao = UPPER(ALLTRIM(par_cOperacao))
        ENDIF
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Construcao completa do form
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Criar BO
            THIS.this_oBusinessObject = CREATEOBJECT("sigopdivBO")
            IF VARTYPE(THIS.this_oBusinessObject) # "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio sigopdiv.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Validar DivOps em SigCdPam
            LOCAL loc_cSQL
            loc_cSQL = "SELECT DivOps FROM SigCdPam"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PamDiv") > 0
                SELECT cursor_4c_PamDiv
                GO TOP
                IF EMPTY(ALLTRIM(cursor_4c_PamDiv.DivOps))
                    MsgAviso("Opera" + CHR(231) + CHR(227) + "o de Divis" + CHR(227) + ;
                             "o de Op n" + CHR(227) + "o Configurada nos par" + CHR(226) + ;
                             "metros do sistema...", "Configura" + CHR(231) + CHR(227) + "o")
                ENDIF
                USE IN cursor_4c_PamDiv
            ENDIF

            *-- Definir Caption conforme operacao
            IF THIS.this_cOperacao = "R"
                THIS.Caption = "Reinicia Industrializa" + CHR(231) + CHR(227) + "o"
            ELSE
                THIS.Caption = "Separa Industrializa" + CHR(231) + CHR(227) + "o"
            ENDIF

            *-- Criar cursores de trabalho (privados desta sessao de dados)
            SET NULL ON
            CREATE CURSOR Temp_DivOp ;
                (Qtds N(12,3), QtdEtiqs N(5,0), QtdDivs N(12,3), Dopes C(20), ;
                 Numes N(6,0), Dataes D, Obss M NULL, Nops N(10,0), SeqDivs N(3,0), ;
                 Cpros C(14), CodCors C(4), CodTams C(4), Empds C(3), Dpros C(65), ;
                 Notas C(6), Contas C(10), Citens N(10,0), Pesos N(12,3))
            CREATE CURSOR Temporario ;
                (Qtds N(12,3), Dopes C(20), Numes N(6,0), Dataes D, Obss M NULL, ;
                 Nops N(10,0), SeqDivs N(3,0), Cpros C(14), CodCors C(4), CodTams C(4), ;
                 Empds C(3), Dpros C(65), Notas C(6), Contas C(10), Pesos N(9,3))
            INDEX ON Nops TAG Nops FOR Qtds > 0
            SET NULL OFF

            *-- Criar xNensi com estrutura identica a SigCdNei
            IF gnConnHandle > 0
                IF SQLEXEC(gnConnHandle, "SELECT TOP 0 * FROM SigCdNei", ;
                           "cursor_4c_NensiStruct") > 0
                    DIMENSION loc_aNensiFields[1]
                    AFIELDS(loc_aNensiFields, "cursor_4c_NensiStruct")
                    CREATE CURSOR xNensi FROM ARRAY loc_aNensiFields
                    USE IN cursor_4c_NensiStruct
                ENDIF
            ENDIF

            *-- Construir todos os controles UI
            THIS.ConfigurarControles()

            *-- Inicializar estado visual do form (Grade principal visivel)
            THIS.ConfigurarPaginaLista()

            *-- Propagar Caption para labels de titulo
            THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption

            *-- BINDEVENT: Get_OP
            *-- Valid nao funciona via BINDEVENT em TextBox; usar KeyPress ENTER/TAB
            BINDEVENT(THIS.txt_4c_Op, "When",     THIS, "GetOpWhen")
            BINDEVENT(THIS.txt_4c_Op, "KeyPress",  THIS, "GetOpKeyPress")
            BINDEVENT(THIS.txt_4c_Op, "KeyPress", THIS, "GetOpLostFocus")

            *-- BINDEVENT: CommandGroups
            BINDEVENT(THIS.grp_4c_GrupoSalva, "Click", THIS, "GrupoSalvaClick")
            BINDEVENT(THIS.grp_4c_GrupoConf,  "Click", THIS, "GrupoConfClick")

            *-- BINDEVENT: Grade (principal) eventos
            BINDEVENT(THIS.grd_4c_Grade, "AfterRowColChange", THIS, "GradeAfterRowColChange")

            *-- BINDEVENT: Grade2 (resultado) eventos
            BINDEVENT(THIS.grd_4c_Grade2, "AfterRowColChange", THIS, "Grade2AfterRowColChange")

            *-- BINDEVENT: colunas editaveis da Grade (QtdDivs e QtdEtiqs)
            *-- Regra VFP9: BINDEVENT "Valid" nao funciona em TextBox.
            *-- Usar KeyPress (ENTER=13/TAB=9) para simular Valid + LostFocus para rede de seguranca.
            BINDEVENT(THIS.grd_4c_Grade.Column4.Text1, "KeyPress",  THIS, "GradeCol4KeyPress")
            BINDEVENT(THIS.grd_4c_Grade.Column4.Text1, "KeyPress", THIS, "GradeCol4LostFocus")
            BINDEVENT(THIS.grd_4c_Grade.Column4.Text1, "When",      THIS, "GradeCol4When")
            BINDEVENT(THIS.grd_4c_Grade.Column2.Text1, "KeyPress",  THIS, "GradeCol2KeyPress")
            BINDEVENT(THIS.grd_4c_Grade.Column2.Text1, "KeyPress", THIS, "GradeCol2LostFocus")
            BINDEVENT(THIS.grd_4c_Grade.Column2.Text1, "When",      THIS, "GradeCol2When")

            *-- BINDEVENT: EditBoxes LostFocus
            BINDEVENT(THIS.edt_4c_MemoObs, "KeyPress", THIS, "MemoObsLostFocus")
            BINDEVENT(THIS.edt_4c_Obss,    "KeyPress", THIS, "ObssLostFocus")

            *-- Ajustar caption do botao Gerar para modo Reinicia
            IF THIS.this_cOperacao = "R"
                THIS.grp_4c_GrupoSalva.Buttons(1).Caption = "\<Reinicia"
            ENDIF

            *-- Tornar todos os controles visiveis (exceto flutuantes)
            THIS.TornarControlesVisiveis(THIS)

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Constroi o "frame" visual do form operacional:
    * Picture de fundo + container cabecalho (cntSombra) com labels de titulo.
    * Forms OPERACIONAIS nao usam PageFrame CRUD; este metodo agrupa a
    * estrutura fixa do topo (equivalente ao "frame" da tela).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        *-- Imagem de fundo (pixel-perfect do legado)
        THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *----------------------------------------------------------------------
        * Container cabecalho (cntSombra): fundo cinza + labels de titulo
        *----------------------------------------------------------------------
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top      = 18
                .Left     = 10
                .Width    = THIS.Width
                .Height   = 40
                .FontBold = .T.
                .FontName = "Tahoma"
                .FontSize = 18
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .WordWrap  = .T.
                .Caption   = "Separa Industrializa" + CHR(231) + CHR(227) + "o"
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top      = 19
                .Left     = 10
                .Width    = THIS.Width
                .Height   = 46
                .FontBold = .T.
                .FontName = "Tahoma"
                .FontSize = 18
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .WordWrap  = .T.
                .Caption   = "Separa Industrializa" + CHR(231) + CHR(227) + "o"
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarControles - Cria todos os objetos visuais do form
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarControles()
        *-- Construir frame (picture + cabecalho)
        THIS.ConfigurarPageFrame()

        *-- Construir campos principais (labels, textboxes, editboxes)
        THIS.ConfigurarCamposPrincipais()

        *----------------------------------------------------------------------
        * CommandGroup Grupo_Salva: "Gerar O.P." + "Encerrar"
        *----------------------------------------------------------------------
        THIS.AddObject("grp_4c_GrupoSalva", "CommandGroup")
        WITH THIS.grp_4c_GrupoSalva
            .Top           = -1
            .Left          = 673
            .Width         = 160
            .Height        = 85
            .AutoSize      = .T.
            .ButtonCount   = 2
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH
        WITH THIS.grp_4c_GrupoSalva.Buttons(1)
            .Top             = 5
            .Left            = 5
            .Height          = 75
            .Width           = 75
            .Caption         = "\<Gerar O.P."
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
        ENDWITH
        WITH THIS.grp_4c_GrupoSalva.Buttons(2)
            .Top             = 5
            .Left            = 80
            .Height          = 75
            .Width           = 75
            .Caption         = "Encerrar"
            .Cancel          = .T.
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
        ENDWITH

        *----------------------------------------------------------------------
        * CommandGroup Grupo_Conf: "Confirmar" + "Encerrar" (oculto inicialmente)
        *----------------------------------------------------------------------
        THIS.AddObject("grp_4c_GrupoConf", "CommandGroup")
        WITH THIS.grp_4c_GrupoConf
            .Top           = -1
            .Left          = 674
            .Width         = 173
            .Height        = 110
            .ButtonCount   = 2
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Themes        = .F.
            .Enabled       = .F.
            .Visible       = .F.
        ENDWITH
        WITH THIS.grp_4c_GrupoConf.Buttons(1)
            .Top             = 5
            .Left            = 5
            .Height          = 75
            .Width           = 75
            .Caption         = "\<Confirmar"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
        ENDWITH
        WITH THIS.grp_4c_GrupoConf.Buttons(2)
            .Top             = 5
            .Left            = 80
            .Height          = 75
            .Width           = 75
            .Caption         = "Encerrar"
            .Cancel          = .T.
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
        ENDWITH

        *----------------------------------------------------------------------
        * Grade principal (Temp_DivOp) e Grade2 resultado (Temporario)
        *----------------------------------------------------------------------
        THIS.ConfigurarGrade()
        THIS.ConfigurarGrade2()
    ENDPROC

    *==========================================================================
    * ConfigurarCamposPrincipais (Fase 5) - Campos principais do form operacional
    * Labels (OP/Produto), TextBoxes de entrada (Get_OP/Get_Produto) e EditBoxes
    * de observacao (Get_obss/fwmemo_obs). Chamado por ConfigurarControles.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposPrincipais()
        *----------------------------------------------------------------------
        * Label "OP :"
        *----------------------------------------------------------------------
        THIS.AddObject("lbl_4c_Op", "Label")
        WITH THIS.lbl_4c_Op
            .Top       = 87
            .Left      = 41
            .Width     = 23
            .Height    = 15
            .Caption   = "OP :"
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * TextBox Get_OP: entrada do numero da OP
        *----------------------------------------------------------------------
        THIS.AddObject("txt_4c_Op", "TextBox")
        WITH THIS.txt_4c_Op
            .Top           = 83
            .Left          = 67
            .Width         = 108
            .Height        = 23
            .Alignment     = 3
            .Format        = "K"
            .InputMask     = "999999999999"
            .MaxLength     = 12
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .Value         = " "
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Label "Produto :"
        *----------------------------------------------------------------------
        THIS.AddObject("lbl_4c_Produto", "Label")
        WITH THIS.lbl_4c_Produto
            .Top       = 87
            .Left      = 213
            .Width     = 47
            .Height    = 15
            .Caption   = "Produto :"
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * TextBox Produto: exibe codigo do produto (readonly)
        *----------------------------------------------------------------------
        THIS.AddObject("txt_4c_Produto", "TextBox")
        WITH THIS.txt_4c_Produto
            .Top           = 83
            .Left          = 262
            .Width         = 108
            .Height        = 23
            .Alignment     = 3
            .Format        = "K"
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .ReadOnly      = .T.
            .Value         = " "
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * EditBox Get_obss: observacao da OP selecionada (Temp_DivOp.Obss)
        *----------------------------------------------------------------------
        THIS.AddObject("edt_4c_Obss", "EditBox")
        WITH THIS.edt_4c_Obss
            .Top           = 421
            .Left          = 11
            .Width         = 626
            .Height        = 94
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .ControlSource = "Temp_DivOp.Obss"
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * EditBox fwmemo_obs: observacao das OPs geradas (Temporario.Obss)
        * Oculto inicialmente; exibido apos geracao em modo Divisao
        *----------------------------------------------------------------------
        THIS.AddObject("edt_4c_MemoObs", "EditBox")
        WITH THIS.edt_4c_MemoObs
            .Top           = 421
            .Left          = 11
            .Width         = 626
            .Height        = 94
            .SpecialEffect = 1
            .BorderColor   = RGB(36, 84, 155)
            .ControlSource = "Temporario.Obss"
            .Enabled       = .F.
            .Visible       = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarGrade - Grade principal (Temp_DivOp)
    * 7 colunas: Pedido | Cliente | Cor | Tam | Qtd.Op | QtdDivs | Quantidade
    * Nota: Column2=QtdEtiqs, Column4=QtdDivs sao editaveis pelo usuario
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade()
        LOCAL loc_oGrd
        THIS.AddObject("grd_4c_Grade", "Grid")
        loc_oGrd = THIS.grd_4c_Grade
        WITH loc_oGrd
            .Top           = 121
            .Left          = 11
            .Width         = 626
            .Height        = 293
            .FontName      = "Arial"
            .FontSize      = 8
            .ColumnCount   = 7
            .DeleteMark    = .F.
            .GridLines     = 3
            .GridLineWidth = 1
            .GridLineColor = RGB(238, 238, 238)
            .HeaderHeight  = 17
            .RecordMark    = .F.
            .RowHeight     = 17
            .ScrollBars    = 2
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .RecordSource  = "Temp_DivOp"
            .Visible       = .T.
        ENDWITH

        *-- Column1: Pedido (expressao Dopes + Numes - readonly)
        WITH loc_oGrd.Column1
            .Header1.Caption     = "Pedido"
            .Header1.Alignment   = 2
            .Header1.BackColor   = RGB(192, 192, 192)
            .ControlSource       = "ALLTRIM(Temp_DivOp.Dopes)+' '+ALLTRIM(STR(Temp_DivOp.Numes,6))"
            .Text1.ReadOnly      = .T.
            .Text1.BorderStyle   = 0
            .Text1.Alignment     = 0
            .Text1.Margin        = 0
            .Width               = 160
            .Movable             = .F.
            .Resizable           = .F.
            .ReadOnly            = .T.
        ENDWITH

        *-- Column2: Qtd.Op (QtdEtiqs) - editavel para divisao por etiquetas
        WITH loc_oGrd.Column2
            .Header1.Caption     = "Qtd.Op"
            .Header1.Alignment   = 2
            .Header1.BackColor   = RGB(192, 192, 192)
            .ControlSource       = "Temp_DivOp.QtdEtiqs"
            .Text1.BorderStyle   = 0
            .Text1.Alignment     = 1
            .Text1.Format        = "K"
            .Text1.InputMask     = "99999"
            .Text1.Margin        = 0
            .Width               = 85
            .ColumnOrder         = 6
            .Movable             = .F.
            .Resizable           = .F.
        ENDWITH

        *-- Column3: Quantidade (Qtds - readonly)
        WITH loc_oGrd.Column3
            .Header1.Caption     = "Quantidade"
            .Header1.Alignment   = 2
            .ControlSource       = "Temp_DivOp.Qtds"
            .Text1.ReadOnly      = .T.
            .Text1.BorderStyle   = 0
            .Text1.Alignment     = 1
            .Text1.InputMask     = "999,999.999"
            .Text1.Margin        = 0
            .Width               = 102
            .ColumnOrder         = 5
            .Movable             = .F.
            .Resizable           = .F.
            .ReadOnly            = .T.
        ENDWITH

        *-- Column4: Divisao (QtdDivs) - editavel para informar quantidade a dividir
        WITH loc_oGrd.Column4
            .Header1.Caption     = "Divis" + CHR(227) + "o"
            .Header1.Alignment   = 2
            .Header1.BackColor   = RGB(192, 192, 192)
            .ControlSource       = "Temp_DivOp.QtdDivs"
            .Text1.BorderStyle   = 0
            .Text1.Alignment     = 1
            .Text1.Format        = "K"
            .Text1.InputMask     = "999,999.999"
            .Text1.Margin        = 0
            .Width               = 85
            .ColumnOrder         = 7
            .Movable             = .F.
            .Resizable           = .F.
        ENDWITH

        *-- Column5: Cor (CodCors - readonly)
        WITH loc_oGrd.Column5
            .Header1.Caption     = "Cor"
            .Header1.Alignment   = 2
            .ControlSource       = "Temp_DivOp.CodCors"
            .Text1.ReadOnly      = .T.
            .Text1.BorderStyle   = 0
            .Text1.Margin        = 0
            .Width               = 38
            .ColumnOrder         = 3
            .Movable             = .F.
            .Resizable           = .F.
            .ReadOnly            = .T.
        ENDWITH

        *-- Column6: Tam (CodTams - readonly)
        WITH loc_oGrd.Column6
            .Header1.Caption     = "Tam"
            .Header1.Alignment   = 2
            .ControlSource       = "Temp_DivOp.CodTams"
            .Text1.ReadOnly      = .T.
            .Text1.BorderStyle   = 0
            .Text1.Margin        = 0
            .Width               = 38
            .ColumnOrder         = 4
            .Movable             = .F.
            .Resizable           = .F.
            .ReadOnly            = .T.
        ENDWITH

        *-- Column7: Cliente (Contas - readonly)
        WITH loc_oGrd.Column7
            .Header1.Caption     = "Cliente"
            .Header1.Alignment   = 2
            .ControlSource       = "Temp_DivOp.Contas"
            .Text1.ReadOnly      = .T.
            .Text1.BorderStyle   = 0
            .Text1.Margin        = 0
            .Width               = 90
            .ColumnOrder         = 2
            .Movable             = .F.
            .Resizable           = .F.
            .ReadOnly            = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarGrade2 - Grade resultado (Temporario - oculto ate geracao)
    * 7 colunas: O.P. | Pedido | Cliente | Cor | Tam | Quantidade | Peso
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade2()
        LOCAL loc_oGrd
        THIS.AddObject("grd_4c_Grade2", "Grid")
        loc_oGrd = THIS.grd_4c_Grade2
        WITH loc_oGrd
            .Top           = 121
            .Left          = 11
            .Width         = 626
            .Height        = 293
            .FontName      = "Arial"
            .FontSize      = 8
            .ColumnCount   = 7
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .GridLineWidth = 1
            .GridLineColor = RGB(136, 189, 188)
            .HeaderHeight  = 17
            .RowHeight     = 17
            .ScrollBars    = 2
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .RecordSource  = "Temporario"
            .ReadOnly      = .T.
            .Enabled       = .F.
            .Visible       = .F.
        ENDWITH

        *-- Column1: Pedido
        WITH loc_oGrd.Column1
            .Header1.Caption     = "Pedido"
            .Header1.Alignment   = 2
            .Header1.BackColor   = RGB(192, 192, 192)
            .ControlSource       = "ALLTRIM(Temporario.Dopes)+' '+ALLTRIM(STR(Temporario.Numes,6))"
            .Text1.ReadOnly      = .T.
            .Text1.Alignment     = 0
            .Text1.BorderStyle   = 0
            .Text1.Margin        = 0
            .Text1.Enabled       = .F.
            .Width               = 205
            .ColumnOrder         = 2
            .Movable             = .F.
            .Resizable           = .F.
            .ReadOnly            = .T.
            .Enabled             = .F.
        ENDWITH

        *-- Column2: O.P. (Nops)
        WITH loc_oGrd.Column2
            .Header1.Caption     = "O.P."
            .Header1.Alignment   = 2
            .Header1.BackColor   = RGB(192, 192, 192)
            .ControlSource       = "Temporario.Nops"
            .Text1.ReadOnly      = .T.
            .Text1.Alignment     = 1
            .Text1.BorderStyle   = 0
            .Text1.Format        = "K"
            .Text1.InputMask     = "9999999999"
            .Text1.Margin        = 0
            .Text1.Enabled       = .F.
            .Width               = 80
            .ColumnOrder         = 1
            .Movable             = .F.
            .Resizable           = .F.
            .ReadOnly            = .T.
            .Enabled             = .F.
        ENDWITH

        *-- Column3: Quantidade (Qtds)
        WITH loc_oGrd.Column3
            .Header1.Caption     = "Quantidade"
            .Header1.Alignment   = 2
            .Header1.BackColor   = RGB(192, 192, 192)
            .ControlSource       = "Temporario.Qtds"
            .Text1.ReadOnly      = .T.
            .Text1.Alignment     = 1
            .Text1.BorderStyle   = 0
            .Text1.InputMask     = "999,999.999"
            .Text1.Margin        = 0
            .Text1.Enabled       = .F.
            .Width               = 80
            .ColumnOrder         = 6
            .Movable             = .F.
            .Resizable           = .F.
            .ReadOnly            = .T.
            .Enabled             = .F.
        ENDWITH

        *-- Column4: Cor
        WITH loc_oGrd.Column4
            .Header1.Caption     = "Cor"
            .Header1.Alignment   = 2
            .ControlSource       = "Temporario.CodCors"
            .Text1.ReadOnly      = .T.
            .Text1.BorderStyle   = 0
            .Text1.Margin        = 0
            .Text1.Enabled       = .F.
            .Width               = 38
            .ColumnOrder         = 4
            .Movable             = .F.
            .Resizable           = .F.
            .ReadOnly            = .T.
            .Enabled             = .F.
        ENDWITH

        *-- Column5: Tam
        WITH loc_oGrd.Column5
            .Header1.Caption     = "Tam"
            .Header1.Alignment   = 2
            .ControlSource       = "Temporario.CodTams"
            .Text1.ReadOnly      = .T.
            .Text1.BorderStyle   = 0
            .Text1.Margin        = 0
            .Text1.Enabled       = .F.
            .Width               = 24
            .ColumnOrder         = 5
            .Movable             = .F.
            .Resizable           = .F.
            .ReadOnly            = .T.
            .Enabled             = .F.
        ENDWITH

        *-- Column6: Cliente (Contas)
        WITH loc_oGrd.Column6
            .Header1.Caption     = "Cliente"
            .Header1.Alignment   = 2
            .ControlSource       = "Temporario.Contas"
            .Text1.ReadOnly      = .T.
            .Text1.BorderStyle   = 0
            .Text1.Margin        = 0
            .Text1.Enabled       = .F.
            .Width               = 80
            .ColumnOrder         = 3
            .Movable             = .F.
            .Resizable           = .F.
            .ReadOnly            = .T.
            .Enabled             = .F.
        ENDWITH

        *-- Column7: Peso
        WITH loc_oGrd.Column7
            .Header1.Caption     = "Peso"
            .Header1.Alignment   = 2
            .ControlSource       = "Temporario.Pesos"
            .Text1.ReadOnly      = .T.
            .Text1.BorderStyle   = 0
            .Text1.Margin        = 0
            .Text1.Enabled       = .F.
            .Width               = 75
            .Movable             = .F.
            .Resizable           = .F.
            .Enabled             = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Define estado inicial do form operacional:
    * Grade principal visivel, Grade2 oculta, GrupoSalva ativo.
    * Chamado em InicializarForm e ao retornar do estado de revisao.
    *==========================================================================
    PROCEDURE ConfigurarPaginaLista()
        WITH THIS.grd_4c_Grade
            .Enabled = .T.
            .Visible = .T.
        ENDWITH
        WITH THIS.grd_4c_Grade2
            .Enabled = .F.
            .Visible = .F.
        ENDWITH
        WITH THIS.edt_4c_Obss
            .Enabled = .T.
            .Visible = .T.
        ENDWITH
        WITH THIS.edt_4c_MemoObs
            .Enabled = .F.
            .Visible = .F.
        ENDWITH
        WITH THIS.grp_4c_GrupoSalva
            .Enabled = .T.
            .Visible = .T.
        ENDWITH
        WITH THIS.grp_4c_GrupoConf
            .Enabled = .F.
            .Visible = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna estado visual do form operacional
    * par_nPagina: 1 = Entrada (Grade principal + GrupoSalva)
    *              2 = Revisao (Grade2 resultado + GrupoConf)
    * Sobrescreve FormBase.AlternarPagina que usa pgf_4c_Paginas inexistente.
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        DO CASE
        CASE par_nPagina = 1
            THIS.ConfigurarPaginaLista()
            THIS.grd_4c_Grade.Refresh()
        CASE par_nPagina = 2
            WITH THIS.grd_4c_Grade
                .Enabled = .F.
                .Visible = .F.
            ENDWITH
            WITH THIS.grd_4c_Grade2
                .Enabled = .T.
                .Visible = .T.
                .Refresh()
            ENDWITH
            WITH THIS.edt_4c_Obss
                .Enabled = .F.
                .Visible = .F.
            ENDWITH
            WITH THIS.edt_4c_MemoObs
                .Enabled = .T.
                .Visible = .T.
            ENDWITH
            WITH THIS.grp_4c_GrupoSalva
                .Enabled = .F.
                .Visible = .F.
            ENDWITH
            WITH THIS.grp_4c_GrupoConf
                .Enabled = .T.
                .Visible = .T.
            ENDWITH
        ENDCASE
    ENDPROC

    *==========================================================================
    * GetOpWhen - Get_OP.When
    * Permite digitacao apenas enquanto Temporario estiver vazio
    *==========================================================================
    PROCEDURE GetOpWhen()
        RETURN RECCOUNT("Temporario") = 0
    ENDPROC

    *==========================================================================
    * GetOpKeyPress - Get_OP.KeyPress
    * Dispara GetOpValid ao pressionar ENTER(13) ou TAB(9)
    *==========================================================================
    PROCEDURE GetOpKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.GetOpValid()
        ENDIF
    ENDPROC

    *==========================================================================
    * GetOpValid - Valida OP e carrega Temp_DivOp / xNensi via BO.BuscarOP
    *==========================================================================
    PROCEDURE GetOpValid()
        LOCAL loc_nOp, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(THIS.txt_4c_Op.Value)) OR VAL(THIS.txt_4c_Op.Value) = 0
            RETURN .T.
        ENDIF

        IF LEN(ALLTRIM(THIS.txt_4c_Op.Value)) > 10
            THIS.txt_4c_Op.Value = RIGHT(ALLTRIM(THIS.txt_4c_Op.Value), 10)
        ENDIF

        loc_nOp = VAL(THIS.txt_4c_Op.Value)

        TRY
            loc_lSucesso = THIS.this_oBusinessObject.BuscarOP(loc_nOp)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em GetOpValid")
            loc_lSucesso = .F.
        ENDTRY

        IF loc_lSucesso
            THIS.txt_4c_Produto.Value = THIS.this_oBusinessObject.this_cProduto
            THIS.grd_4c_Grade.Refresh()
        ELSE
            THIS.txt_4c_Op.Value      = " "
            THIS.txt_4c_Produto.Value = " "
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * GetOpLostFocus - Get_OP.LostFocus
    * Se OP valida carregada, move foco para coluna QtdEtiqs da grade
    *==========================================================================
    PROCEDURE GetOpLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        IF !EMPTY(ALLTRIM(THIS.txt_4c_Op.Value)) AND ;
           USED("Temp_DivOp") AND !EOF("Temp_DivOp")
            THIS.grd_4c_Grade.Column2.Text1.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * GrupoSalvaClick - Grupo_Salva.Click
    * Botao 1 (Gerar O.P.): valida e chama BO.GerarNovaOP
    * Botao 2 (Encerrar): rollback e fecha
    *==========================================================================
    PROCEDURE GrupoSalvaClick()
        LOCAL loc_nOp, loc_nQtds, loc_nQtdDivs, loc_nQtdEtiqs
        LOCAL loc_lSucesso, loc_oErro

        IF THIS.grp_4c_GrupoSalva.Value = 2
            ON KEY LABEL ENTER
            THIS.this_oBusinessObject.RollbackTransacao()
            THIS.Release()
            RETURN
        ENDIF

        *-- Botao 1: Gerar O.P.
        IF EMPTY(ALLTRIM(THIS.txt_4c_Op.Value)) OR VAL(THIS.txt_4c_Op.Value) = 0
            MsgAviso("OP n" + CHR(227) + "o informada!!", "Aviso")
            THIS.txt_4c_Op.SetFocus()
            RETURN
        ENDIF

        loc_nOp       = VAL(THIS.txt_4c_Op.Value)
        loc_nQtds     = 0
        loc_nQtdDivs  = 0
        loc_nQtdEtiqs = 0

        *-- Somar quantidades de Temp_DivOp para validacao
        IF USED("Temp_DivOp") AND RECCOUNT("Temp_DivOp") > 0
            SELECT SUM(Qtds) AS SQtds, SUM(QtdDivs) AS SQtdDivs, SUM(QtdEtiqs) AS SQtdEtiqs ;
                FROM Temp_DivOp INTO CURSOR cursor_4c_SumTmpDiv
            SELECT cursor_4c_SumTmpDiv
            GO TOP
            loc_nQtds     = NVL(cursor_4c_SumTmpDiv.SQtds,     0)
            loc_nQtdDivs  = NVL(cursor_4c_SumTmpDiv.SQtdDivs,  0)
            loc_nQtdEtiqs = NVL(cursor_4c_SumTmpDiv.SQtdEtiqs, 0)
            USE IN cursor_4c_SumTmpDiv
        ENDIF

        ON KEY LABEL ENTER

        *-- Delegar para BO
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = THIS.this_oBusinessObject.GerarNovaOP(;
                THIS.this_cOperacao, loc_nOp, loc_nQtds, loc_nQtdDivs, loc_nQtdEtiqs)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em GrupoSalvaClick")
        ENDTRY

        IF loc_lSucesso
            IF THIS.this_cOperacao = "D"
                *-- Divisao: ir para estado de revisao (Grade2 + GrupoConf)
                IF USED("Temp_DivOp")
                    SELECT Temp_DivOp
                    ZAP
                ENDIF
                SELECT Temporario
                GO TOP
                THIS.AlternarPagina(2)

                IF !THIS.this_lAutomatico
                    THIS.grd_4c_Grade2.Column2.Text1.SetFocus()
                ENDIF

            ELSE
                *-- Reinicia: confirmar transacao automaticamente (sem revisao em Grade2)
                LOCAL loc_lCommit
                loc_lCommit = .F.
                TRY
                    loc_lCommit = THIS.this_oBusinessObject.ConfirmarGravacao()
                CATCH TO loc_oErro
                    MsgErro(loc_oErro.Message, "Erro ao confirmar Reinicia")
                ENDTRY

                IF loc_lCommit
                    IF USED("Temp_DivOp")
                        SELECT Temp_DivOp
                        ZAP
                    ENDIF
                    THIS.txt_4c_Op.Value      = " "
                    THIS.txt_4c_Produto.Value = " "
                    THIS.AlternarPagina(1)

                    IF !THIS.this_lAutomatico
                        THIS.txt_4c_Op.SetFocus()
                    ENDIF
                    THIS.Refresh()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * GrupoConfClick - Grupo_Conf.Click
    * Botao 1 (Confirmar): persiste Obss e faz COMMIT via BO
    * Botao 2 (Encerrar): rollback e fecha
    *==========================================================================
    PROCEDURE GrupoConfClick()
        LOCAL loc_lSucesso, loc_oErro

        IF THIS.grp_4c_GrupoConf.Value = 2
            ON KEY LABEL ENTER
            THIS.this_oBusinessObject.RollbackTransacao()
            THIS.Release()
            RETURN
        ENDIF

        *-- Botao 1: Confirmar
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = THIS.this_oBusinessObject.ConfirmarGravacao()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em GrupoConfClick")
        ENDTRY

        IF loc_lSucesso
            IF USED("Temporario")
                SELECT Temporario
                ZAP
            ENDIF
            THIS.txt_4c_Op.Value      = " "
            THIS.txt_4c_Produto.Value = " "
            THIS.AlternarPagina(1)

            IF !THIS.this_lAutomatico
                THIS.txt_4c_Op.SetFocus()
            ENDIF
            THIS.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * GradeAfterRowColChange - Grade.AfterRowColChange
    * Atualiza editbox de observacao ao navegar entre linhas
    *==========================================================================
    PROCEDURE GradeAfterRowColChange(par_nColIndex)
        THIS.edt_4c_Obss.Refresh()
    ENDPROC

    *==========================================================================
    * Grade2AfterRowColChange - Grade2.AfterRowColChange
    * Atualiza editbox de observacao ao navegar entre OPs geradas
    *==========================================================================
    PROCEDURE Grade2AfterRowColChange(par_nColIndex)
        THIS.edt_4c_MemoObs.Refresh()
    ENDPROC

    *==========================================================================
    * GradeCol4Valid - Column4 (QtdDivs) Valid
    * Regras: QtdDivs e QtdEtiqs mutuamente exclusivos; nao pode exceder Qtds
    *==========================================================================
    PROCEDURE GradeCol4Valid()
        LOCAL loc_lOk, loc_nValDivisao, loc_nValEtiq
        loc_lOk       = .T.
        loc_nValDivisao = THIS.grd_4c_Grade.Column4.Text1.Value
        loc_nValEtiq    = THIS.grd_4c_Grade.Column2.Text1.Value

        IF loc_nValEtiq > 0 AND loc_nValDivisao > 0
            MsgAviso("Informe Somente Qtde Divis" + CHR(227) + "o ou Qtde de Etiquetas...", "Aviso")
            THIS.grd_4c_Grade.Column4.Text1.Value = 0
            loc_lOk = .F.
        ENDIF

        IF loc_lOk AND USED("Temp_DivOp") AND !EOF("Temp_DivOp")
            IF loc_nValDivisao > Temp_DivOp.Qtds
                MsgAviso("Quantidade a dividir n" + CHR(227) + ;
                         "o pode ser maior que a quantidade do Pedido...", "Aviso")
                THIS.grd_4c_Grade.Column4.Text1.Value = 0
                loc_lOk = .F.
            ENDIF
        ENDIF

        RETURN loc_lOk
    ENDPROC

    *==========================================================================
    * GradeCol4When - Column4 (QtdDivs) When
    * Define ENTER para avan?ar linha (DNARROW) quando em QtdDivs
    *==========================================================================
    PROCEDURE GradeCol4When()
        ON KEY LABEL ENTER KEYBOARD "{DNARROW}"
        RETURN .T.
    ENDPROC

    *==========================================================================
    * GradeCol4KeyPress - Column4 (QtdDivs) KeyPress
    * Simula Valid em ENTER(13)/TAB(9). Retorna 0 via binding de Valid nao
    * funciona em TextBox sob BINDEVENT; aqui resetamos o valor se invalido
    * e deixamos a tecla fluir para o VFP9 processar navegacao.
    *==========================================================================
    PROCEDURE GradeCol4KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.GradeCol4Valid()
        ENDIF
    ENDPROC

    *==========================================================================
    * GradeCol4LostFocus - Column4 (QtdDivs) LostFocus
    * Rede de seguranca: aplica validacao ao sair da celula por click/mouse
    *==========================================================================
    PROCEDURE GradeCol4LostFocus(par_nKeyCode, par_nShiftAltCtrl)
        THIS.GradeCol4Valid()
    ENDPROC

    *==========================================================================
    * GradeCol2KeyPress - Column2 (QtdEtiqs) KeyPress
    *==========================================================================
    PROCEDURE GradeCol2KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.GradeCol2Valid()
        ENDIF
    ENDPROC

    *==========================================================================
    * GradeCol2LostFocus - Column2 (QtdEtiqs) LostFocus
    *==========================================================================
    PROCEDURE GradeCol2LostFocus(par_nKeyCode, par_nShiftAltCtrl)
        THIS.GradeCol2Valid()
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna visiveis todos os controles do form
    * recursivamente, EXCETO containers/controles flutuantes que devem
    * permanecer Visible=.F. ate serem alternados por AlternarPagina(2).
    *
    * Controles flutuantes (estado inicial oculto):
    *   - grd_4c_Grade2      : Grade resultado, aparece apos Gerar O.P.
    *   - edt_4c_MemoObs     : EditBox de obs das OPs geradas
    *   - grp_4c_GrupoConf   : Botoes Confirmar/Encerrar (modo revisao)
    *==========================================================================
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_j, loc_oCtrl, loc_cNome

        IF VARTYPE(par_oContainer) # "O"
            RETURN
        ENDIF

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oCtrl = par_oContainer.Controls(loc_i)
            loc_cNome = UPPER(loc_oCtrl.Name)

            *-- Controles flutuantes: permanecem ocultos (alternados via AlternarPagina)
            *-- CNT_4C_SOMBRA: visibilidade gerenciada por ConfigurarPageFrame
            IF INLIST(loc_cNome, ;
                    "GRD_4C_GRADE2",    ;
                    "EDT_4C_MEMOOBS",   ;
                    "GRP_4C_GRUPOCONF", ;
                    "CNT_4C_SOMBRA")
                LOOP
            ENDIF

            IF PEMSTATUS(loc_oCtrl, "Visible", 5)
                loc_oCtrl.Visible = .T.
            ENDIF

            *-- Recursao em Containers
            IF PEMSTATUS(loc_oCtrl, "ControlCount", 5)
                IF loc_oCtrl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oCtrl)
                ENDIF
            ENDIF

            *-- Recursao em Pages de PageFrame
            IF UPPER(loc_oCtrl.BaseClass) = "PAGEFRAME"
                FOR loc_j = 1 TO loc_oCtrl.PageCount
                    THIS.TornarControlesVisiveis(loc_oCtrl.Pages(loc_j))
                ENDFOR
            ENDIF
        ENDFOR

        loc_oCtrl = .NULL.
    ENDPROC

    *==========================================================================
    * GradeCol2Valid - Column2 (QtdEtiqs) Valid
    * Regras: mutuamente exclusivo com QtdDivs; > 1; nao pode exceder Qtds
    *==========================================================================
    PROCEDURE GradeCol2Valid()
        LOCAL loc_lOk, loc_nValDivisao, loc_nValEtiq
        loc_lOk         = .T.
        loc_nValDivisao = THIS.grd_4c_Grade.Column4.Text1.Value
        loc_nValEtiq    = THIS.grd_4c_Grade.Column2.Text1.Value

        IF loc_nValDivisao > 0 AND loc_nValEtiq > 0
            MsgAviso("Informe Somente Qtde Divis" + CHR(227) + "o ou Qtde de Etiquetas...", "Aviso")
            THIS.grd_4c_Grade.Column2.Text1.Value = 0
            loc_lOk = .F.
        ENDIF

        IF loc_lOk AND loc_nValEtiq = 1
            MsgAviso("Informe somente Qtde maior que 1.", "Aviso")
            THIS.grd_4c_Grade.Column2.Text1.Value = 0
            loc_lOk = .F.
        ENDIF

        IF loc_lOk AND USED("Temp_DivOp") AND !EOF("Temp_DivOp")
            IF loc_nValEtiq > Temp_DivOp.Qtds
                MsgAviso("Quantidade de Etiquetas n" + CHR(227) + ;
                         "o pode ser maior que a quantidade do Pedido...", "Aviso")
                THIS.grd_4c_Grade.Column2.Text1.Value = 0
                loc_lOk = .F.
            ENDIF
        ENDIF

        RETURN loc_lOk
    ENDPROC

    *==========================================================================
    * GradeCol2When - Column2 (QtdEtiqs) When
    * Limpa binding ENTER (cancelando atalho de Column4) e libera celula
    * apenas quando Qtds > 1 (nao faz sentido dividir em etiquetas se qtd=1)
    *==========================================================================
    PROCEDURE GradeCol2When()
        ON KEY LABEL ENTER
        IF USED("Temp_DivOp") AND !EOF("Temp_DivOp")
            RETURN (Temp_DivOp.Qtds > 1)
        ENDIF
        RETURN .F.
    ENDPROC

    *==========================================================================
    * MemoObsLostFocus - fwmemo_obs.LostFocus
    *==========================================================================
    PROCEDURE MemoObsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.grd_4c_Grade2.Visible
            THIS.grd_4c_Grade2.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * ObssLostFocus - Get_obss.LostFocus
    *==========================================================================
    PROCEDURE ObssLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.grd_4c_Grade2.Visible
            THIS.grd_4c_Grade2.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * ExecutarModoAutomatico - Execucao automatica para divisao programatica
    * par_aNop: array [n,1]=Dopes, [n,2]=Numes, [n,3]=CodCors, [n,4]=CodTams,
    *           [n,5]=Emps, [n,6]=Nops, [n,7]=NovaOp(out), [n,8]=Qtds,
    *           [n,9]=QtdsGeradas(out)
    *==========================================================================
    PROCEDURE ExecutarModoAutomatico(par_aNop)
        LOCAL loc_nCnt, loc_llOk, loc_nOp

        IF TYPE("par_aNop", 1) # "A"
            RETURN .F.
        ENDIF

        THIS.this_lAutomatico = .T.
        THIS.Visible = .F.

        *-- Simular entrada de OP (primeiro elemento)
        loc_nOp = par_aNop[1, 6]
        THIS.txt_4c_Op.Value = ALLTRIM(STR(loc_nOp))
        THIS.GetOpValid()

        SELECT Temp_DivOp
        IF RECCOUNT() = 0
            RETURN .F.
        ENDIF

        *-- Distribuir QtdDivs conforme array
        loc_llOk = .F.
        FOR loc_nCnt = 1 TO ALEN(par_aNop, 1)
            SELECT Temp_DivOp
            GO TOP
            LOCATE FOR Dopes   = par_aNop[loc_nCnt, 1] AND ;
                       Numes   = par_aNop[loc_nCnt, 2] AND ;
                       CodCors = par_aNop[loc_nCnt, 3] AND ;
                       CodTams = par_aNop[loc_nCnt, 4]
            IF !EOF()
                REPLACE QtdDivs WITH QtdDivs + par_aNop[loc_nCnt, 8]
                loc_llOk = .T.
            ENDIF
        ENDFOR

        IF !loc_llOk
            RETURN .F.
        ENDIF

        *-- Executar geracao
        THIS.GrupoSalvaClick()

        *-- Capturar OPs geradas de volta no array
        FOR loc_nCnt = 1 TO ALEN(par_aNop, 1)
            SELECT Temporario
            GO TOP
            LOCATE FOR Dopes   = par_aNop[loc_nCnt, 1] AND ;
                       Numes   = par_aNop[loc_nCnt, 2] AND ;
                       CodCors = par_aNop[loc_nCnt, 3] AND ;
                       CodTams = par_aNop[loc_nCnt, 4] AND ;
                       Qtds    = par_aNop[loc_nCnt, 8]
            IF !EOF()
                par_aNop[loc_nCnt, 7] = Temporario.Nops
                par_aNop[loc_nCnt, 9] = Temporario.Qtds
            ENDIF
        ENDFOR

        *-- Confirmar
        THIS.GrupoConfClick()

        RETURN .T.
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Override de FormBase.BtnIncluirClick
    * Form OPERACIONAL: a inclusao real acontece via GrupoSalvaClick (Gerar O.P.).
    * Ao ser acionado (por atalho herdado ou automacao), delega para o fluxo
    * operacional principal: valida OP digitada e gera as novas OPs divididas.
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.grp_4c_GrupoSalva.Value = 1
        THIS.GrupoSalvaClick()
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Override de FormBase.BtnAlterarClick
    * Form OPERACIONAL: alteracao corresponde a revisao da divisao gerada.
    * Se Grade2 estiver ativa (estado de revisao), move foco para coluna O.P.
    * para o usuario editar as novas OPs. Caso contrario, posiciona foco na
    * coluna de divisao da grade principal para iniciar a alteracao.
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        IF THIS.grd_4c_Grade2.Visible
            THIS.grd_4c_Grade2.Column2.Text1.SetFocus()
        ELSE
            IF USED("Temp_DivOp") AND !EOF("Temp_DivOp")
                THIS.grd_4c_Grade.Column4.Text1.SetFocus()
            ELSE
                THIS.txt_4c_Op.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Override de FormBase.BtnVisualizarClick
    * Form OPERACIONAL: visualizacao corresponde ao estado de revisao da
    * divisao (Grade2). Alterna para pagina de revisao se houver Temporario
    * preenchido; caso contrario, mantem estado atual e move foco para OP.
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        IF USED("Temporario") AND RECCOUNT("Temporario") > 0
            THIS.AlternarPagina(2)
        ELSE
            THIS.txt_4c_Op.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Override de FormBase.BtnExcluirClick
    * Form OPERACIONAL: exclusao equivale a rollback da transacao em curso.
    * Confirma com usuario; se aprovado, faz rollback no BO e volta para
    * estado inicial de entrada (Grade principal + GrupoSalva).
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_lConfirma
        loc_lConfirma = MsgConfirma("Cancelar a divis" + CHR(227) + ;
                                    "o em andamento e descartar altera" + ;
                                    CHR(231) + CHR(245) + "es?", "Confirma" + ;
                                    CHR(231) + CHR(227) + "o")
        IF !loc_lConfirma
            RETURN
        ENDIF

        IF !ISNULL(THIS.this_oBusinessObject) AND ;
           VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.RollbackTransacao()
        ENDIF

        IF USED("Temp_DivOp")
            SELECT Temp_DivOp
            ZAP
        ENDIF
        IF USED("Temporario")
            SELECT Temporario
            ZAP
        ENDIF
        IF USED("xNensi")
            SELECT xNensi
            ZAP
        ENDIF

        THIS.txt_4c_Op.Value      = " "
        THIS.txt_4c_Produto.Value = " "
        THIS.AlternarPagina(1)
        THIS.txt_4c_Op.SetFocus()
        THIS.Refresh()
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Override de FormBase.BtnBuscarClick
    * Form OPERACIONAL: re-executa a validacao e carga da OP corrente.
    * Permite ao usuario recarregar o grid caso os dados tenham sido
    * alterados externamente sem precisar limpar e redigitar a OP.
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        IF !EMPTY(ALLTRIM(THIS.txt_4c_Op.Value)) AND VAL(THIS.txt_4c_Op.Value) > 0
            THIS.GetOpValid()
        ELSE
            THIS.txt_4c_Op.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Override de FormBase.BtnEncerrarClick
    * Form OPERACIONAL: faz rollback da transacao em aberto e fecha o form.
    * Equivale a clicar "Encerrar" nos CommandGroups de Salva ou Conf.
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        ON KEY LABEL ENTER
        IF !ISNULL(THIS.this_oBusinessObject) AND ;
           VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.RollbackTransacao()
        ENDIF
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Override de FormBase.BtnSalvarClick
    * Form OPERACIONAL: delega para o CommandGroup ativo.
    * Se estiver em modo revisao (GrupoConf visivel) -> ConfirmarGravacao.
    * Se estiver em modo entrada (GrupoSalva visivel) -> GerarNovaOP.
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        IF THIS.grp_4c_GrupoConf.Visible AND THIS.grp_4c_GrupoConf.Enabled
            THIS.grp_4c_GrupoConf.Value = 1
            THIS.GrupoConfClick()
        ELSE
            THIS.grp_4c_GrupoSalva.Value = 1
            THIS.GrupoSalvaClick()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Override de FormBase.BtnCancelarClick
    * Form OPERACIONAL: cancela a divisao em andamento, faz rollback e
    * retorna ao estado inicial de entrada sem pedir confirmacao.
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        ON KEY LABEL ENTER
        IF !ISNULL(THIS.this_oBusinessObject) AND ;
           VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.RollbackTransacao()
        ENDIF

        IF USED("Temp_DivOp")
            SELECT Temp_DivOp
            ZAP
        ENDIF
        IF USED("Temporario")
            SELECT Temporario
            ZAP
        ENDIF
        IF USED("xNensi")
            SELECT xNensi
            ZAP
        ENDIF

        THIS.txt_4c_Op.Value      = " "
        THIS.txt_4c_Produto.Value = " "
        THIS.AlternarPagina(1)
        THIS.txt_4c_Op.SetFocus()
        THIS.Refresh()
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere estado do form para propriedades do BO
    * Form OPERACIONAL: propaga numero da OP, operacao e empresa corrente.
    * Chamado antes de qualquer persistencia (GerarNovaOP/ConfirmarGravacao).
    *==========================================================================
    PROCEDURE FormParaBO()
        THIS.this_oBusinessObject.this_nNops     = ALLTRIM(THIS.txt_4c_Op.Value)
        THIS.this_oBusinessObject.this_cOperacao = THIS.this_cOperacao
        THIS.this_oBusinessObject.this_cEmps     = go_4c_Sistema.cCodEmpresa
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere estado do BO para os controles do form
    * Form OPERACIONAL: atualiza campo de produto apos carga da OP.
    *==========================================================================
    PROCEDURE BOParaForm()
        THIS.txt_4c_Produto.Value = THIS.this_oBusinessObject.this_cProduto
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita controles de entrada
    * Form OPERACIONAL: Get_OP editavel apenas enquanto Temporario estiver
    * vazio (antes de gerar as OPs). Get_Produto sempre readonly.
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lOpHabilitada
        loc_lOpHabilitada = par_lHabilitar AND (RECCOUNT("Temporario") = 0)
        THIS.txt_4c_Op.Enabled = loc_lOpHabilitada
        THIS.txt_4c_Op.ReadOnly = !loc_lOpHabilitada
    ENDPROC

    *==========================================================================
    * LimparCampos - Zera todos os campos e cursores de trabalho
    * Form OPERACIONAL: limpa Get_OP, Get_Produto, Temp_DivOp, Temporario,
    * xNensi e retorna form ao estado inicial (Grade principal + GrupoSalva).
    *==========================================================================
    PROCEDURE LimparCampos()
        THIS.txt_4c_Op.Value      = " "
        THIS.txt_4c_Produto.Value = " "

        IF USED("Temp_DivOp")
            SELECT Temp_DivOp
            ZAP
        ENDIF
        IF USED("Temporario")
            SELECT Temporario
            ZAP
        ENDIF
        IF USED("xNensi")
            SELECT xNensi
            ZAP
        ENDIF

        THIS.AlternarPagina(1)
        THIS.Refresh()
    ENDPROC

    *==========================================================================
    * CarregarLista - Recarrega o grid principal para a OP corrente
    * Form OPERACIONAL: se OP informada, re-executa GetOpValid para repopular
    * Temp_DivOp e atualizar o grid; caso contrario, apenas limpa os cursores.
    *==========================================================================
    PROCEDURE CarregarLista()
        IF !EMPTY(ALLTRIM(THIS.txt_4c_Op.Value)) AND VAL(THIS.txt_4c_Op.Value) > 0
            THIS.GetOpValid()
        ENDIF
        IF USED("Temp_DivOp")
            THIS.grd_4c_Grade.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta visibilidade dos CommandGroups conforme modo
    * Form OPERACIONAL: usa AlternarPagina para controlar GrupoSalva/GrupoConf.
    * Parametro par_cModo: "LISTA"/"ENTRADA" -> pagina 1, "DADOS"/"REVISAO" -> pagina 2.
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo(par_cModo)
        IF VARTYPE(par_cModo) = "C"
            IF UPPER(ALLTRIM(par_cModo)) = "DADOS" OR UPPER(ALLTRIM(par_cModo)) = "REVISAO"
                THIS.AlternarPagina(2)
            ELSE
                THIS.AlternarPagina(1)
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * Destroy - Destrutor: rollback seguro + limpeza de key bindings
    *==========================================================================
    PROCEDURE Destroy()
        ON KEY LABEL ENTER
        IF !ISNULL(THIS.this_oBusinessObject) AND ;
           VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.RollbackTransacao()
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
