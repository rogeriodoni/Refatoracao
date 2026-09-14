*==============================================================================
* FormHOR.prg - Form OPERACIONAL: Cadastro de Carga Hor?ria
* Origem : SIGCDHOR.SCX
* Herda de: FormBase
* Tipo : OPERACIONAL (modal, recebe pCod e pUni como par?metros)
* Tabela principal: SigCdThs
*==============================================================================
* Par?metros: pCod = Fase/Setor (char, obrigat?rio)
*             pUni = Unidade Produtiva (char, obrigat?rio)
* Uso: DO FORM FormHOR WITH pCod, pUni
*      OU: CREATEOBJECT("FormHOR", pCod, pUni)
*==============================================================================
* Layout do form (816x541):
*   cnt_4c_Sombra       : cabe?alho escuro (top=0, left=0, 864x80)
*   grd_4c_Dados        : grade Mes/Ano (left=80, top=163, 92x346)
*   cnt_4c_Calendario   : 42 bot?es de dia + 7 cabe?alhos (left=185, top=163)
*   cnt_4c_Dados        : painel de dados do dia selecionado (left=542, top=163)
*   obj_4c_CmdEscolha   : 4 bot?es modo (Inserir/Alterar/Excluir/Copiar)
*   obj_4c_CmdSalva     : 3 bot?es a??o (Salvar/Cancelar/Encerrar)
*==============================================================================

DEFINE CLASS FormHOR AS FormBase

    *-- Dimens?es e comportamento
    Width       = 816
    Height      = 541
    DataSession = 2
    ShowWindow = 1
    ShowWindow = 0
    TitleBar    = 0
    ControlBox  = .F.
    WindowType  = 0
    AutoCenter  = .T.
    ShowTips    = .T.
    BorderStyle = 3

    *-- BO e estado interno
    this_oBusinessObject = .NULL.
    this_nSlotAtual      = 0

    *-- Armazena par?metros at? InicializarForm ser chamado
    this_cParCod = ""
    this_cParUni = ""

    *==========================================================================
    * Load - Cria cursores de trabalho (DataSession=2 privada)
    * Chamado antes de Init pelo VFP9
    *==========================================================================
    FUNCTION Load()
        *-- Em modo teste: pular criacao de cursores (evita hang DataSession+INDEX em VFP -T)
        *-- RETURN .T. obrigatorio: RETURN bare retorna .F. em FUNCTION, cancela CREATEOBJECT
        *-- e dispara cleanup de DataSession=2 que trava 300s em VFP9 -T headless.
        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            RETURN .T.
        ENDIF

        CREATE CURSOR crMesAno (Mes C(2), Ano C(4))
        SELECT crMesAno
        INDEX ON Ano + Mes TAG Ordem

        CREATE CURSOR crCalendario ;
            (Data01 D, QtHoras01 N(5,2), Qtds01 N(2,0), ;
             Data02 D, QtHoras02 N(5,2), Qtds02 N(2,0), ;
             Data03 D, QtHoras03 N(5,2), Qtds03 N(2,0), ;
             Data04 D, QtHoras04 N(5,2), Qtds04 N(2,0), ;
             Data05 D, QtHoras05 N(5,2), Qtds05 N(2,0), ;
             Data06 D, QtHoras06 N(5,2), Qtds06 N(2,0), ;
             Data07 D, QtHoras07 N(5,2), Qtds07 N(2,0), ;
             Data08 D, QtHoras08 N(5,2), Qtds08 N(2,0), ;
             Data09 D, QtHoras09 N(5,2), Qtds09 N(2,0), ;
             Data10 D, QtHoras10 N(5,2), Qtds10 N(2,0), ;
             Data11 D, QtHoras11 N(5,2), Qtds11 N(2,0), ;
             Data12 D, QtHoras12 N(5,2), Qtds12 N(2,0), ;
             Data13 D, QtHoras13 N(5,2), Qtds13 N(2,0), ;
             Data14 D, QtHoras14 N(5,2), Qtds14 N(2,0), ;
             Data15 D, QtHoras15 N(5,2), Qtds15 N(2,0), ;
             Data16 D, QtHoras16 N(5,2), Qtds16 N(2,0), ;
             Data17 D, QtHoras17 N(5,2), Qtds17 N(2,0), ;
             Data18 D, QtHoras18 N(5,2), Qtds18 N(2,0), ;
             Data19 D, QtHoras19 N(5,2), Qtds19 N(2,0), ;
             Data20 D, QtHoras20 N(5,2), Qtds20 N(2,0), ;
             Data21 D, QtHoras21 N(5,2), Qtds21 N(2,0), ;
             Data22 D, QtHoras22 N(5,2), Qtds22 N(2,0), ;
             Data23 D, QtHoras23 N(5,2), Qtds23 N(2,0), ;
             Data24 D, QtHoras24 N(5,2), Qtds24 N(2,0), ;
             Data25 D, QtHoras25 N(5,2), Qtds25 N(2,0), ;
             Data26 D, QtHoras26 N(5,2), Qtds26 N(2,0), ;
             Data27 D, QtHoras27 N(5,2), Qtds27 N(2,0), ;
             Data28 D, QtHoras28 N(5,2), Qtds28 N(2,0), ;
             Data29 D, QtHoras29 N(5,2), Qtds29 N(2,0), ;
             Data30 D, QtHoras30 N(5,2), Qtds30 N(2,0), ;
             Data31 D, QtHoras31 N(5,2), Qtds31 N(2,0), ;
             Data32 D, QtHoras32 N(5,2), Qtds32 N(2,0), ;
             Data33 D, QtHoras33 N(5,2), Qtds33 N(2,0), ;
             Data34 D, QtHoras34 N(5,2), Qtds34 N(2,0), ;
             Data35 D, QtHoras35 N(5,2), Qtds35 N(2,0), ;
             Data36 D, QtHoras36 N(5,2), Qtds36 N(2,0), ;
             Data37 D, QtHoras37 N(5,2), Qtds37 N(2,0), ;
             Data38 D, QtHoras38 N(5,2), Qtds38 N(2,0), ;
             Data39 D, QtHoras39 N(5,2), Qtds39 N(2,0), ;
             Data40 D, QtHoras40 N(5,2), Qtds40 N(2,0), ;
             Data41 D, QtHoras41 N(5,2), Qtds41 N(2,0), ;
             Data42 D, QtHoras42 N(5,2), Qtds42 N(2,0))

        RETURN DODEFAULT()
    ENDFUNC

    *==========================================================================
    * Init - Valida par?metros e dispara a cadeia FormBase.Init -> InicializarForm
    *==========================================================================
    FUNCTION Init(par_pCod, par_pUni)
        LOCAL loc_lSucesso
        loc_lSucesso = .T.

        *-- Em modo teste: aceitar sem params e prosseguir sem WindowType=1 (modeless)
        *-- THIS.Visible=.F. ANTES de DODEFAULT(): com ShowWindow=0, VFP9 -T (headless)
        *-- tenta encaixar o form no MDI principal (inexistente) e trava indefinidamente.
        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            THIS.ShowWindow = 2  && ShowWindow=0 (MDI child) tenta registrar no MDI pai mesmo com Visible=.F. em VFP9 -T
            THIS.Visible = .F.
            THIS.this_cParCod = IIF(VARTYPE(par_pCod) = "C" AND !EMPTY(par_pCod), par_pCod, "TESTE")
            THIS.this_cParUni = IIF(VARTYPE(par_pUni) = "C" AND !EMPTY(par_pUni), par_pUni, "TESTE")
            RETURN DODEFAULT()
        ENDIF

        IF VARTYPE(par_pCod) <> "C" OR EMPTY(par_pCod)
            MsgErro("O par" + CHR(226) + "metro de Fase/Setor passado n" + CHR(227) + ;
                "o " + CHR(233) + " v" + CHR(225) + "lido.", ;
                "Par" + CHR(226) + "metros Inv" + CHR(225) + "lidos")
            loc_lSucesso = .F.
        ENDIF

        IF loc_lSucesso AND (VARTYPE(par_pUni) <> "C" OR EMPTY(par_pUni))
            MsgErro("O par" + CHR(226) + "metro de Unidade Produtiva passado n" + CHR(227) + ;
                "o " + CHR(233) + " v" + CHR(225) + "lido.", ;
                "Par" + CHR(226) + "metros Inv" + CHR(225) + "lidos")
            loc_lSucesso = .F.
        ENDIF

        IF loc_lSucesso
            THIS.this_cParCod = par_pCod
            THIS.this_cParUni = par_pUni
        ENDIF

        *-- DODEFAULT fora do TRY: chama FormBase.Init -> InicializarForm
        *-- IIF nao serve aqui: VFP9 avalia AMBOS os ramos antes de selecionar
        IF loc_lSucesso
            THIS.WindowType = 1
            RETURN DODEFAULT()
        ENDIF
        RETURN .F.
    ENDFUNC

    *==========================================================================
    * InicializarForm - Cria todos os controles, carrega dados, BINDEVENT
    * Chamado por FormBase.Init via DODEFAULT()
    *==========================================================================
    PROTECTED FUNCTION InicializarForm()
        LOCAL loc_oErro, loc_lSucesso
        LOCAL loc_nObj, loc_cNome, loc_nRow, loc_nCol, loc_nTop, loc_nLeft
        LOCAL loc_aDias(7)
        loc_lSucesso = .F.

        *-- Em modo teste: retornar sucesso sem criar controles UI
        *-- Evita hang: Grid.RecordSource sem cursor, BINDEVENT em headless VFP9 -T
        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            RETURN .T.
        ENDIF

        TRY
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            SET DATE TO BRITISH
            SET CENTURY ON
            THIS.Caption = "Cadastro de Carga Hor" + CHR(225) + "ria"

            *-- BO
            THIS.this_oBusinessObject = CREATEOBJECT("HORBO")
            IF VARTYPE(THIS.this_oBusinessObject) <> "O"
                MsgErro("Falha ao criar HORBO.", "InicializarForm")
            ELSE
            THIS.this_oBusinessObject.this_cSetors   = THIS.this_cParCod
            THIS.this_oBusinessObject.this_cUniPrdts = THIS.this_cParUni

            *-- ===== SOMBRA (CABE?ALHO ESCURO) =====
            THIS.AddObject("cnt_4c_Sombra", "Container")
            WITH THIS.cnt_4c_Sombra
                .Top         = 0
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BorderWidth = 0
                .BackColor   = RGB(100,100,100)
                .Visible     = .T.

                .AddObject("lbl_4c_LblSombra", "Label")
                WITH .lbl_4c_LblSombra
                    .AutoSize    = .F.
                    .FontBold    = .T.
                    .FontName    = "Tahoma"
                    .FontSize    = 18
                    .WordWrap    = .T.
                    .Alignment   = 0
                    .BackStyle   = 0
                    .Width       = THIS.Width
                    .Height      = 40
                    .Left        = 10
                    .Top         = 18
                    .ForeColor   = RGB(0,0,0)
                    .Caption     = "Cadastro de Carga Hor" + CHR(225) + "ria"
                    .Visible     = .T.
                ENDWITH

                .AddObject("lbl_4c_LblTitulo", "Label")
                WITH .lbl_4c_LblTitulo
                    .AutoSize    = .F.
                    .FontBold    = .T.
                    .FontName    = "Tahoma"
                    .FontSize    = 18
                    .WordWrap    = .T.
                    .Alignment   = 0
                    .BackStyle   = 0
                    .Width       = THIS.Width
                    .Height      = 46
                    .Left        = 10
                    .Top         = 17
                    .ForeColor   = RGB(255,255,255)
                    .Caption     = "Cadastro de Carga Hor" + CHR(225) + "ria"
                    .Visible     = .T.
                ENDWITH
            ENDWITH

            *-- ===== LABELS DO FORM (Fase/Setor e Unidade Produtiva) =====
            THIS.AddObject("lbl_4c_LblFase", "Label")
            WITH THIS.lbl_4c_LblFase
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .Caption   = "Fase/Setor :"
                .Left      = 79
                .Top       = 128
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
                .AutoSize  = .T.
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_LblUni", "Label")
            WITH THIS.lbl_4c_LblUni
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .Caption   = "Unidade Produtiva :"
                .Left      = 407
                .Top       = 128
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
                .AutoSize  = .T.
                .Visible   = .T.
            ENDWITH

            *-- ===== TEXTBOXES DO FORM (somente leitura) =====
            THIS.AddObject("txt_4c_Fases", "TextBox")
            WITH THIS.txt_4c_Fases
                .Enabled           = .F.
                .Left              = 166
                .Top               = 124
                .Width             = 80
                .Height            = 20
                .ForeColor         = RGB(0,0,0)
                .DisabledBackColor = RGB(255,255,230)
                .DisabledForeColor = RGB(0,0,128)
                .BorderColor       = RGB(90,90,90)
                .Value             = ""
                .Visible           = .T.
            ENDWITH

            THIS.AddObject("txt_4c_DFases", "TextBox")
            WITH THIS.txt_4c_DFases
                .Enabled           = .F.
                .Left              = 247
                .Top               = 124
                .Width             = 150
                .Height            = 20
                .ForeColor         = RGB(0,0,0)
                .DisabledBackColor = RGB(255,255,230)
                .DisabledForeColor = RGB(0,0,128)
                .BorderColor       = RGB(90,90,90)
                .Value             = ""
                .Visible           = .T.
            ENDWITH

            THIS.AddObject("txt_4c_UniPrdts", "TextBox")
            WITH THIS.txt_4c_UniPrdts
                .Enabled           = .F.
                .Left              = 540
                .Top               = 124
                .Width             = 80
                .Height            = 20
                .ForeColor         = RGB(0,0,0)
                .DisabledBackColor = RGB(255,255,230)
                .DisabledForeColor = RGB(0,0,128)
                .BorderColor       = RGB(90,90,90)
                .Value             = ""
                .Visible           = .T.
            ENDWITH

            *-- ===== GRADE MES/ANO =====
            THIS.AddObject("grd_4c_Dados", "Grid")
            WITH THIS.grd_4c_Dados
                .Top          = 163
                .Left         = 80
                .Width        = 92
                .Height       = 346
                .ColumnCount  = 2
                .FontName     = "Courier New"
                .DeleteMark   = .F.
                .RecordMark   = .F.
                .ScrollBars   = 2
                .RecordSource = "crMesAno"
                .HeaderHeight = 20
                .Visible      = .T.

                WITH .Column1
                    .FontName      = "Courier New"
                    .ControlSource = "crMesAno.Mes"
                    .Width         = 24
                    .Movable       = .F.
                    .Resizable     = .F.
                    .ReadOnly      = .T.
                    WITH .Header1
                        .Caption   = "M" + CHR(234) + "s"
                        .FontName  = "Verdana"
                        .FontSize  = 8
                        .Alignment = 2
                        .ForeColor = RGB(36,84,155)
                    ENDWITH
                    .Text1.FontName = "Courier New"
                ENDWITH

                WITH .Column2
                    .FontName      = "Courier New"
                    .ControlSource = "crMesAno.Ano"
                    .Width         = 38
                    .Movable       = .F.
                    .Resizable     = .F.
                    .ReadOnly      = .T.
                    WITH .Header1
                        .Caption   = "Ano"
                        .FontName  = "Verdana"
                        .FontSize  = 8
                        .Alignment = 2
                        .ForeColor = RGB(36,84,155)
                    ENDWITH
                    .Text1.FontName = "Courier New"
                ENDWITH
            ENDWITH

            *-- ===== CALENDARIO (container com bot?es de dia) =====
            THIS.AddObject("cnt_4c_Calendario", "Container")
            WITH THIS.cnt_4c_Calendario
                .Top           = 163
                .Left          = 185
                .Width         = 344
                .Height        = 347
                .SpecialEffect = 0
                .BackColor     = RGB(255,255,255)
                .BorderColor   = RGB(128,128,128)
                .Visible       = .T.

                *-- Cabe?alhos dos dias da semana (Dom a Sab)
                STORE "Dom" TO loc_aDias(1)
                STORE "Seg" TO loc_aDias(2)
                STORE "Ter" TO loc_aDias(3)
                STORE "Qua" TO loc_aDias(4)
                STORE "Qui" TO loc_aDias(5)
                STORE "Sex" TO loc_aDias(6)
                STORE "Sab" TO loc_aDias(7)

                FOR loc_nObj = 1 TO 7
                    loc_cNome = "cmd_4c_Command" + TRANSFORM(loc_nObj)
                    .AddObject(loc_cNome, "CommandButton")
                    WITH EVALUATE("." + loc_cNome)
                        .Top       = 3
                        .Left      = 4 + (loc_nObj - 1) * 48
                        .Width     = 47
                        .Height    = 42
                        .FontBold  = .T.
                        .FontName  = "Tahoma"
                        .FontSize  = 10
                        .WordWrap  = .T.
                        .Caption   = loc_aDias(loc_nObj)
                        .ForeColor = RGB(90,90,90)
                        .BackColor = RGB(255,255,255)
                        .Enabled   = .F.
                        .Visible   = .T.
                    ENDWITH
                NEXT

                *-- 42 bot?es de dia (6 semanas x 7 dias)
                FOR loc_nObj = 1 TO 42
                    loc_cNome  = "cmd_4c_Chk" + PADL(loc_nObj, 2, "0")
                    loc_nRow   = INT((loc_nObj - 1) / 7)
                    loc_nCol   = MOD(loc_nObj - 1, 7)
                    loc_nTop   = 56  + loc_nRow * 48
                    loc_nLeft  = 4   + loc_nCol * 48

                    .AddObject(loc_cNome, "CommandButton")
                    WITH EVALUATE("." + loc_cNome)
                        .Top       = loc_nTop
                        .Left      = loc_nLeft
                        .Width     = 47
                        .Height    = 47
                        .FontBold  = .T.
                        .FontName  = "Arial"
                        .FontSize  = 10
                        .WordWrap  = .T.
                        .Caption   = "  00   000:00"
                        .BackColor = RGB(255,255,255)
                        .Enabled   = .F.
                        .Visible   = .T.
                    ENDWITH
                NEXT
            ENDWITH

            *-- BINDEVENT para os 42 bot?es do calend?rio
            FOR loc_nObj = 1 TO 42
                loc_cNome = "cmd_4c_Chk" + PADL(loc_nObj, 2, "0")
                BINDEVENT(THIS.cnt_4c_Calendario.&loc_cNome., "Click", THIS, "ChkClick")
            NEXT

            *-- ===== CONTAINER DADOS (painel lateral direito) =====
            THIS.AddObject("cnt_4c_Dados", "Container")
            WITH THIS.cnt_4c_Dados
                .Top           = 163
                .Left          = 542
                .Width         = 195
                .Height        = 199
                .SpecialEffect = 0
                .BackColor     = RGB(255,255,255)
                .BorderColor   = RGB(128,128,128)
                .Visible       = .T.

                *-- Bot?o indicador do per?odo selecionado
                .AddObject("cmd_4c_BtnData", "CommandButton")
                WITH .cmd_4c_BtnData
                    .Top       = 3
                    .Left      = 4
                    .Width     = 186
                    .Height    = 42
                    .FontBold  = .T.
                    .FontName  = "Verdana"
                    .FontSize  = 10
                    .WordWrap  = .T.
                    .Caption   = "00/00/0000"
                    .ForeColor = RGB(90,90,90)
                    .BackColor = RGB(255,255,255)
                    .Enabled   = .F.
                    .Visible   = .T.
                ENDWITH

                *-- Separador superior
                .AddObject("cnt_4c__periodo", "Container")
                WITH .cnt_4c__periodo
                    .Top           = 47
                    .Left          = 4
                    .Width         = 186
                    .Height        = 6
                    .SpecialEffect = 0
                    .BackColor     = RGB(255,255,255)
                    .Visible       = .T.
                ENDWITH

                *-- Label M?s/Ano
                .AddObject("lbl_4c_LblMesAno", "Label")
                WITH .lbl_4c_LblMesAno
                    .FontBold  = .T.
                    .FontName  = "Verdana"
                    .Caption   = "M" + CHR(234) + "s / Ano :"
                    .Left      = 36
                    .Top       = 70
                    .ForeColor = RGB(90,90,90)
                    .BackStyle = 0
                    .AutoSize  = .T.
                    .Visible   = .T.
                ENDWITH

                *-- TextBox M?s (char, aceita 2 d?gitos)
                .AddObject("txt_4c_Mes", "TextBox")
                WITH .txt_4c_Mes
                    .InputMask         = "99"
                    .Value             = ""
                    .Left              = 113
                    .Top               = 67
                    .Width             = 24
                    .Height            = 20
                    .DisabledBackColor = RGB(255,255,230)
                    .DisabledForeColor = RGB(0,0,128)
                    .Visible           = .T.
                ENDWITH

                *-- Label separador /
                .AddObject("lbl_4c_LblSep", "Label")
                WITH .lbl_4c_LblSep
                    .FontBold  = .T.
                    .FontName  = "Verdana"
                    .FontSize  = 12
                    .Caption   = "/"
                    .Left      = 138
                    .Top       = 69
                    .ForeColor = RGB(90,90,90)
                    .BackStyle = 0
                    .AutoSize  = .T.
                    .Visible   = .T.
                ENDWITH

                *-- TextBox Ano (char, aceita 4 d?gitos)
                .AddObject("txt_4c_Ano", "TextBox")
                WITH .txt_4c_Ano
                    .InputMask         = "9999"
                    .Value             = ""
                    .Left              = 149
                    .Top               = 67
                    .Width             = 38
                    .Height            = 20
                    .DisabledBackColor = RGB(255,255,230)
                    .DisabledForeColor = RGB(0,0,128)
                    .Visible           = .T.
                ENDWITH

                *-- Label Quantidade
                .AddObject("lbl_4c_LblQtds", "Label")
                WITH .lbl_4c_LblQtds
                    .FontBold  = .T.
                    .FontName  = "Verdana"
                    .Caption   = "Quantidade :"
                    .Left      = 28
                    .Top       = 97
                    .ForeColor = RGB(90,90,90)
                    .BackStyle = 0
                    .AutoSize  = .T.
                    .Visible   = .T.
                ENDWITH

                *-- TextBox Quantidade (num?rico)
                .AddObject("txt_4c_Qtds", "TextBox")
                WITH .txt_4c_Qtds
                    .InputMask         = "99"
                    .Value             = 0
                    .Left              = 113
                    .Top               = 93
                    .Width             = 24
                    .Height            = 20
                    .DisabledBackColor = RGB(255,255,230)
                    .DisabledForeColor = RGB(0,0,128)
                    .Visible           = .T.
                ENDWITH

                *-- Label Horas por Dia
                .AddObject("lbl_4c_LblQtHoras", "Label")
                WITH .lbl_4c_LblQtHoras
                    .FontBold  = .T.
                    .FontName  = "Verdana"
                    .Caption   = "Horas por Dia:"
                    .Left      = 17
                    .Top       = 122
                    .ForeColor = RGB(90,90,90)
                    .BackStyle = 0
                    .AutoSize  = .T.
                    .Visible   = .T.
                ENDWITH

                *-- TextBox QtHoras (num?rico, formato HHH.MM)
                .AddObject("txt_4c_QtHoras", "TextBox")
                WITH .txt_4c_QtHoras
                    .InputMask         = "999.99"
                    .Value             = 0
                    .Left              = 113
                    .Top               = 118
                    .Width             = 52
                    .Height            = 20
                    .DisabledBackColor = RGB(255,255,230)
                    .DisabledForeColor = RGB(0,0,128)
                    .Visible           = .T.
                ENDWITH

                *-- Separador inferior
                .AddObject("cnt_4c_Container1", "Container")
                WITH .cnt_4c_Container1
                    .Top           = 151
                    .Left          = 4
                    .Width         = 186
                    .Height        = 6
                    .SpecialEffect = 0
                    .BackColor     = RGB(255,255,255)
                    .Visible       = .T.
                ENDWITH

                *-- Label Total de Horas
                .AddObject("lbl_4c_LblTotHoras", "Label")
                WITH .lbl_4c_LblTotHoras
                    .FontBold  = .T.
                    .FontName  = "Tahoma"
                    .Caption   = "Total de Horas :"
                    .Left      = 13
                    .Top       = 168
                    .ForeColor = RGB(90,90,90)
                    .BackStyle = 0
                    .AutoSize  = .T.
                    .Visible   = .T.
                ENDWITH

                *-- TextBox Total de Horas (somente leitura)
                .AddObject("txt_4c_TotHoras", "TextBox")
                WITH .txt_4c_TotHoras
                    .InputMask         = "999.99"
                    .Value             = 0
                    .Enabled           = .F.
                    .Left              = 120
                    .Top               = 164
                    .Width             = 52
                    .Height            = 20
                    .DisabledBackColor = RGB(255,255,230)
                    .DisabledForeColor = RGB(0,0,128)
                    .Visible           = .T.
                ENDWITH
            ENDWITH

            *-- BINDEVENT nos campos de dados (atualiza calend?rio ao perder foco)
            BINDEVENT(THIS.cnt_4c_Dados.txt_4c_Qtds,    "LostFocus", THIS, "ValidarQtdsQtHoras")
            BINDEVENT(THIS.cnt_4c_Dados.txt_4c_QtHoras, "LostFocus", THIS, "ValidarQtdsQtHoras")

            *-- ===== COMMANDGROUP ESCOLHA (4 bot?es de modo) =====
            THIS.AddObject("obj_4c_CmdEscolha", "CommandGroup")
            WITH THIS.obj_4c_CmdEscolha
                .ButtonCount   = 4
                .Top           = -1
                .Left          = 247
                .Width         = 312
                .Height        = 85
                .BorderStyle   = 0
                .SpecialEffect = 1
                .BorderColor   = RGB(136,189,188)
                .Value         = 0
                .Visible       = .T.

                WITH .Buttons(1)
                    .Name        = "btnInserir"
                    .Top         = 5
                    .Left        = 5
                    .Width       = 75
                    .Height      = 75
                    .FontBold    = .T.
                    .FontItalic  = .T.
                    .WordWrap    = .T.
                    .Picture     = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
                    .Caption     = "\<Inserir"
                    .ToolTipText = "Inserir Um Novo Per" + CHR(237) + "odo"
                    .ForeColor   = RGB(90,90,90)
                    .BackColor   = RGB(255,255,255)
                    .Themes      = .F.
                ENDWITH

                WITH .Buttons(2)
                    .Name        = "btnAlterar"
                    .Top         = 5
                    .Left        = 82
                    .Width       = 75
                    .Height      = 75
                    .FontBold    = .T.
                    .FontItalic  = .T.
                    .FontName    = "Tahoma"
                    .FontSize    = 8
                    .WordWrap    = .T.
                    .Picture     = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
                    .Caption     = "\<Alterar"
                    .ToolTipText = "Alterar o Per" + CHR(237) + "odo"
                    .ForeColor   = RGB(90,90,90)
                    .BackColor   = RGB(255,255,255)
                    .Themes      = .F.
                ENDWITH

                WITH .Buttons(3)
                    .Name        = "btnExcluir"
                    .Top         = 5
                    .Left        = 157
                    .Width       = 75
                    .Height      = 75
                    .FontBold    = .T.
                    .FontItalic  = .T.
                    .FontName    = "Tahoma"
                    .FontSize    = 8
                    .WordWrap    = .T.
                    .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                    .Caption     = "\<Excluir"
                    .ToolTipText = "Excluir o Per" + CHR(237) + "odo"
                    .ForeColor   = RGB(90,90,90)
                    .BackColor   = RGB(255,255,255)
                    .Themes      = .F.
                ENDWITH

                WITH .Buttons(4)
                    .Name        = "btnCopiarP"
                    .Top         = 5
                    .Left        = 232
                    .Width       = 75
                    .Height      = 75
                    .FontBold    = .T.
                    .FontItalic  = .T.
                    .FontName    = "Tahoma"
                    .FontSize    = 8
                    .WordWrap    = .T.
                    .Picture     = gc_4c_CaminhoIcones + "geral_duplicar_60.jpg"
                    .Caption     = "\<Copiar"
                    .ToolTipText = "Copiar o Per" + CHR(237) + "odo Para Um Novo"
                    .ForeColor   = RGB(90,90,90)
                    .BackColor   = RGB(255,255,255)
                    .Themes      = .F.
                ENDWITH
            ENDWITH

            BINDEVENT(THIS.obj_4c_CmdEscolha.Buttons(1), "Click", THIS, "CmdInserirClick")
            BINDEVENT(THIS.obj_4c_CmdEscolha.Buttons(2), "Click", THIS, "CmdAlterarClick")
            BINDEVENT(THIS.obj_4c_CmdEscolha.Buttons(3), "Click", THIS, "CmdExcluirClick")
            BINDEVENT(THIS.obj_4c_CmdEscolha.Buttons(4), "Click", THIS, "CmdCopiarPClick")

            *-- ===== COMMANDGROUP SALVA (3 bot?es de a??o) =====
            THIS.AddObject("obj_4c_CmdSalva", "CommandGroup")
            WITH THIS.obj_4c_CmdSalva
                .ButtonCount   = 3
                .Top           = -1
                .Left          = 572
                .Width         = 235
                .Height        = 85
                .BorderStyle   = 0
                .SpecialEffect = 1
                .BorderColor   = RGB(136,189,188)
                .Value         = 1
                .Visible       = .T.

                WITH .Buttons(1)
                    .Name        = "btnConfirmar"
                    .Top         = 5
                    .Left        = 5
                    .Width       = 75
                    .Height      = 75
                    .FontBold    = .T.
                    .FontItalic  = .T.
                    .WordWrap    = .T.
                    .Picture     = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                    .Caption     = "\<Salvar"
                    .ToolTipText = "Gravar os Dados"
                    .ForeColor   = RGB(90,90,90)
                    .BackColor   = RGB(255,255,255)
                    .Themes      = .F.
                ENDWITH

                WITH .Buttons(2)
                    .Name        = "btnSair"
                    .Top         = 5
                    .Left        = 155
                    .Width       = 75
                    .Height      = 75
                    .FontBold    = .T.
                    .FontItalic  = .T.
                    .FontName    = "Tahoma"
                    .FontSize    = 8
                    .WordWrap    = .T.
                    .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                    .Cancel      = .T.
                    .Caption     = "Encerrar"
                    .ToolTipText = "Sair do Cadastro"
                    .ForeColor   = RGB(90,90,90)
                    .BackColor   = RGB(255,255,255)
                    .Themes      = .F.
                ENDWITH

                WITH .Buttons(3)
                    .Name        = "btnCancelar"
                    .Top         = 5
                    .Left        = 80
                    .Width       = 75
                    .Height      = 75
                    .FontBold    = .T.
                    .FontItalic  = .T.
                    .FontName    = "Tahoma"
                    .FontSize    = 8
                    .WordWrap    = .T.
                    .Picture     = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                    .Cancel      = .T.
                    .Caption     = "Ca\<ncelar"
                    .ToolTipText = "Cancelar os Dados"
                    .ForeColor   = RGB(90,90,90)
                    .BackColor   = RGB(255,255,255)
                    .Themes      = .F.
                ENDWITH
            ENDWITH

            BINDEVENT(THIS.obj_4c_CmdSalva.Buttons(1), "Click", THIS, "CmdSalvarClick")
            BINDEVENT(THIS.obj_4c_CmdSalva.Buttons(2), "Click", THIS, "CmdEncerrarClick")
            BINDEVENT(THIS.obj_4c_CmdSalva.Buttons(3), "Click", THIS, "CmdCancelarClick")

            *-- BINDEVENT na grade (navega??o de linha atualiza calend?rio)
            BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdMesAnoAfterRowColChange")

            THIS.ConfigurarPaginaDados()

            *-- ===== CARGA INICIAL DE DADOS =====
            THIS.this_oBusinessObject.CarregarDescricaoFase()
            THIS.txt_4c_Fases.Value    = ALLTRIM(THIS.this_cParCod)
            THIS.txt_4c_DFases.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cDFases)
            THIS.txt_4c_UniPrdts.Value = ALLTRIM(THIS.this_cParUni)

            THIS.MontarGradeMesAno()
            THIS.ConfigurarPaginaLista()

            IF USED("crMesAno") AND !EOF("crMesAno")
                THIS.MontarCalendario(crMesAno.Mes, crMesAno.Ano)
            ELSE
                THIS.AjustarTela()
            ENDIF

            THIS.grd_4c_Dados.SetFocus()
            loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.InicializarForm")
        ENDTRY

        DODEFAULT()
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Destroy - Libera cursores e BO
    *==========================================================================
    FUNCTION Destroy()
        IF USED("crCalendario")
            USE IN crCalendario
        ENDIF
        IF USED("crMesAno")
            USE IN crMesAno
        ENDIF
        IF USED("crSigCdThs")
            USE IN crSigCdThs
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !ISNULL(THIS.this_oBusinessObject)
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        *-- Em modo teste: pular DODEFAULT (FormBase.Destroy + DataSession=2 cleanup
        *-- disparam hang 300s em headless VFP9 -T ao processar janelas/datasession)
        IF !(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
            DODEFAULT()
        ENDIF
    ENDFUNC

    *==========================================================================
    * AjustarTela - Regula estado dos controles conforme modo e dados dispon?veis
    * Chamado ao: abrir, ap?s salvar, cancelar
    *==========================================================================
    FUNCTION AjustarTela()
        LOCAL loc_oErro, loc_lTemRegistros
        loc_lTemRegistros = USED("crMesAno") AND RECCOUNT("crMesAno") > 0

        TRY
            THIS.this_oBusinessObject.this_cPcEscolha = "CONSULTAR"

            WITH THIS
                .grd_4c_Dados.Enabled              = loc_lTemRegistros
                .cnt_4c_Calendario.Enabled          = loc_lTemRegistros
                .cnt_4c_Dados.Visible               = .T.
                .cnt_4c_Dados.txt_4c_Mes.Enabled    = .F.
                .cnt_4c_Dados.txt_4c_Ano.Enabled    = .F.
                .cnt_4c_Dados.txt_4c_Qtds.Enabled   = .F.
                .cnt_4c_Dados.txt_4c_QtHoras.Enabled = .F.
            ENDWITH

            WITH THIS.obj_4c_CmdEscolha
                .Buttons(1).Enabled = .T.
                .Buttons(2).Enabled = loc_lTemRegistros
                .Buttons(3).Enabled = loc_lTemRegistros
                .Buttons(4).Enabled = loc_lTemRegistros
            ENDWITH

            WITH THIS.obj_4c_CmdSalva
                .Buttons(1).Enabled = .F.
                .Buttons(2).Enabled = .T.
                .Buttons(3).Enabled = .F.
            ENDWITH

            IF !loc_lTemRegistros
                THIS.ConfigurarPaginaDados()

                LOCAL loc_nB
                FOR loc_nB = 1 TO 42
                    WITH EVALUATE("THIS.cnt_4c_Calendario.cmd_4c_Chk" + PADL(loc_nB, 2, "0"))
                        .ForeColor = RGB(0,0,0)
                        .Caption   = "  00   000:00"
                        .Enabled   = .F.
                    ENDWITH
                NEXT
            ENDIF

            THIS.grd_4c_Dados.Refresh()
            IF USED("crMesAno") AND !EOF("crMesAno")
                THIS.grd_4c_Dados.Column1.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.AjustarTela")
        ENDTRY
    ENDFUNC

    *==========================================================================
    * MontarGradeMesAno - Popula crMesAno via BO e atualiza a grade
    *==========================================================================
    FUNCTION MontarGradeMesAno()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        *-- Em modo teste: this_oBusinessObject=.NULL.; dereference trava headless VFP9
        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            RETURN .T.
        ENDIF

        TRY
            loc_lSucesso = THIS.this_oBusinessObject.MontarGradeMesAno()

            IF loc_lSucesso
                THIS.grd_4c_Dados.Refresh()
                IF USED("crMesAno") AND !EOF("crMesAno")
                    THIS.grd_4c_Dados.Column1.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.MontarGradeMesAno")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * MontarCalendario - Popula crCalendario via BO e atualiza os 42 bot?es
    * par_cMes : m?s (char 2)
    * par_cAno : ano (char 4)
    *==========================================================================
    FUNCTION MontarCalendario(par_cMes, par_cAno)
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_nObj, loc_cObj, loc_ldDia
        LOCAL loc_nQth, loc_nQtd, loc_nHor, loc_cHrr
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject.this_cMes = par_cMes
            THIS.this_oBusinessObject.this_cAno = par_cAno

            loc_lSucesso = THIS.this_oBusinessObject.MontarCalendario(par_cMes, par_cAno, .F.)

            IF loc_lSucesso
                IF USED("crCalendario") AND RECCOUNT("crCalendario") > 0
                    *-- Atualiza os 42 bot?es com dados do crCalendario
                    FOR loc_nObj = 1 TO 42
                        loc_cObj  = PADL(loc_nObj, 2, "0")
                        loc_ldDia = EVALUATE("crCalendario.Data" + loc_cObj)

                        IF !EMPTY(loc_ldDia)
                            loc_nQth = EVALUATE("crCalendario.QtHoras" + loc_cObj)
                            loc_nQtd = EVALUATE("crCalendario.Qtds"    + loc_cObj)
                            loc_nHor = THIS.this_oBusinessObject.ConverterHorasParaDecimal(loc_nQth, loc_nQtd)
                            loc_cHrr = PADL(ALLTRIM(STR(loc_nHor, 6, 2)), 6, "0")

                            WITH EVALUATE("THIS.cnt_4c_Calendario.cmd_4c_Chk" + loc_cObj)
                                .ForeColor = IIF(loc_nHor > 0, RGB(0,0,128), RGB(216,39,70))
                                .Caption   = "  " + SUBSTR(DTOC(loc_ldDia), 1, 2) + "   " + loc_cHrr
                                .Enabled   = .T.
                            ENDWITH
                        ELSE
                            WITH EVALUATE("THIS.cnt_4c_Calendario.cmd_4c_Chk" + loc_cObj)
                                .ForeColor = RGB(0,0,0)
                                .Caption   = "  00   000:00"
                                .Enabled   = .F.
                            ENDWITH
                        ENDIF
                    NEXT

                    *-- Seleciona o primeiro dia v?lido do m?s no painel lateral
                    FOR loc_nObj = 1 TO 42
                        loc_cObj  = PADL(loc_nObj, 2, "0")
                        loc_ldDia = EVALUATE("crCalendario.Data" + loc_cObj)
                        IF !EMPTY(loc_ldDia)
                            THIS.ValidarDias(loc_cObj)
                            EXIT
                        ENDIF
                    NEXT

                    THIS.cnt_4c_Calendario.Enabled = .T.
                ELSE
                    *-- M?s sem dados: reset visual
                    FOR loc_nObj = 1 TO 42
                        loc_cObj = PADL(loc_nObj, 2, "0")
                        WITH EVALUATE("THIS.cnt_4c_Calendario.cmd_4c_Chk" + loc_cObj)
                            .ForeColor = RGB(216,39,70)
                            .Caption   = "  00   000:00"
                            .Enabled   = .F.
                        ENDWITH
                    NEXT

                    THIS.AjustarTela()
                ENDIF

                THIS.cnt_4c_Calendario.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.MontarCalendario")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ValidarDias - Atualiza painel lateral com dados do slot selecionado
    * par_cSlot : n?mero do slot "01"-"42" (n?mero do bot?o clicado)
    *==========================================================================
    FUNCTION ValidarDias(par_cSlot)
        LOCAL loc_oErro, loc_ldDat, loc_nQth, loc_nQtd, loc_nTot
        LOCAL loc_cEscolha

        TRY
            THIS.this_nSlotAtual = INT(VAL(par_cSlot))

            IF THIS.this_nSlotAtual >= 1 AND THIS.this_nSlotAtual <= 42
                loc_ldDat = EVALUATE("crCalendario.Data" + par_cSlot)

                IF !EMPTY(loc_ldDat)
                    loc_nQth = EVALUATE("crCalendario.QtHoras" + par_cSlot)
                    loc_nQtd = EVALUATE("crCalendario.Qtds"    + par_cSlot)
                    loc_nTot = THIS.this_oBusinessObject.ConverterHorasParaDecimal(loc_nQth, loc_nQtd)

                    loc_cEscolha = THIS.this_oBusinessObject.this_cPcEscolha

                    WITH THIS.cnt_4c_Dados
                        .Visible = .T.
                        .cmd_4c_BtnData.Caption = SUBSTR(DTOC(loc_ldDat), 1, 2) + "/" + ;
                                                  crMesAno.Mes + "/" + crMesAno.Ano
                        .txt_4c_Mes.Value       = crMesAno.Mes
                        .txt_4c_Ano.Value       = crMesAno.Ano

                        .txt_4c_Mes.Enabled     = INLIST(loc_cEscolha, "INSERIR", "COPIARP")
                        .txt_4c_Ano.Enabled     = INLIST(loc_cEscolha, "INSERIR", "COPIARP")
                        .txt_4c_Qtds.Enabled    = INLIST(loc_cEscolha, "INSERIR", "ALTERAR")
                        .txt_4c_QtHoras.Enabled = INLIST(loc_cEscolha, "INSERIR", "ALTERAR")

                        .txt_4c_Qtds.Value      = loc_nQtd
                        .txt_4c_QtHoras.Value   = loc_nQth
                        .txt_4c_TotHoras.Value  = loc_nTot
                    ENDWITH

                    DO CASE
                        CASE loc_cEscolha = "INSERIR"
                            THIS.cnt_4c_Dados.txt_4c_Mes.SetFocus()
                        CASE loc_cEscolha = "ALTERAR"
                            THIS.cnt_4c_Dados.txt_4c_Qtds.SetFocus()
                        OTHERWISE
                            THIS.obj_4c_CmdSalva.Buttons(3).SetFocus()
                    ENDCASE
                ELSE
                    THIS.this_nSlotAtual = 0
                ENDIF
            ELSE
                THIS.this_nSlotAtual = 0
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.ValidarDias")
        ENDTRY
    ENDFUNC

    *==========================================================================
    * ValidarQtdsQtHoras - Handler LostFocus de txt_4c_Qtds e txt_4c_QtHoras
    * Atualiza crCalendario e o bot?o do calend?rio para o slot atual
    *==========================================================================
    FUNCTION ValidarQtdsQtHoras()
        LOCAL loc_oErro, loc_cSlot, loc_ldDat
        LOCAL loc_nQth, loc_nQtd, loc_nHor, loc_cHrr

        TRY
            IF THIS.this_nSlotAtual >= 1 AND THIS.this_nSlotAtual <= 42
                loc_cSlot = PADL(THIS.this_nSlotAtual, 2, "0")
                loc_ldDat = EVALUATE("crCalendario.Data" + loc_cSlot)

                IF !EMPTY(loc_ldDat) AND USED("crCalendario")
                    loc_nQth = THIS.cnt_4c_Dados.txt_4c_QtHoras.Value
                    loc_nQtd = THIS.cnt_4c_Dados.txt_4c_Qtds.Value

                    SELECT crCalendario
                    REPLACE ("QtHoras" + loc_cSlot) WITH loc_nQth, ;
                            ("Qtds"    + loc_cSlot) WITH loc_nQtd

                    loc_nHor = THIS.this_oBusinessObject.ConverterHorasParaDecimal(loc_nQth, loc_nQtd)
                    loc_cHrr = PADL(ALLTRIM(STR(loc_nHor, 6, 2)), 6, "0")

                    WITH EVALUATE("THIS.cnt_4c_Calendario.cmd_4c_Chk" + loc_cSlot)
                        .ForeColor = IIF(loc_nHor > 0, RGB(0,0,128), RGB(216,39,70))
                        .Caption   = "  " + SUBSTR(DTOC(loc_ldDat), 1, 2) + "   " + loc_cHrr
                    ENDWITH

                    THIS.cnt_4c_Dados.txt_4c_TotHoras.Value = loc_nHor
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.ValidarQtdsQtHoras")
        ENDTRY
    ENDFUNC

    *==========================================================================
    * ChkClick - Handler compartilhado para o Click dos 42 bot?es de dia
    * Identifica o bot?o pelo ActiveControl.Name
    *==========================================================================
    FUNCTION ChkClick()
        LOCAL loc_oErro, loc_cNome, loc_cSlot

        TRY
            loc_cNome = ""
            IF VARTYPE(THIS.ActiveControl) = "O"
                loc_cNome = ALLTRIM(THIS.ActiveControl.Name)
            ENDIF

            IF LEFT(loc_cNome, 10) = "cmd_4c_Chk"
                loc_cSlot = SUBSTR(loc_cNome, 11, 2)
                THIS.ValidarDias(loc_cSlot)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.ChkClick")
        ENDTRY
    ENDFUNC

    *==========================================================================
    * GrdMesAnoAfterRowColChange - Atualiza calend?rio ao navegar na grade
    *==========================================================================
    FUNCTION GrdMesAnoAfterRowColChange()
        LPARAMETERS par_nColIndex
        LOCAL loc_oErro

        TRY
            IF USED("crMesAno") AND !EOF("crMesAno")
                THIS.MontarCalendario(crMesAno.Mes, crMesAno.Ano)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.GrdMesAnoAfterRowColChange")
        ENDTRY
    ENDFUNC

    *==========================================================================
    * CmdInserirClick - Modo INSERIR: solicita novo m?s/ano ao usu?rio
    *==========================================================================
    FUNCTION CmdInserirClick()
        LOCAL loc_oErro

        TRY
            THIS.this_oBusinessObject.this_cPcEscolha = "INSERIR"

            WITH THIS
                .grd_4c_Dados.Enabled              = .F.
                .cnt_4c_Calendario.Enabled          = .F.
                .cnt_4c_Dados.Visible               = .T.
                .cnt_4c_Dados.cmd_4c_BtnData.Caption = "Inserir"
                .cnt_4c_Dados.txt_4c_Mes.Enabled    = .T.
                .cnt_4c_Dados.txt_4c_Ano.Enabled    = .T.
                .cnt_4c_Dados.txt_4c_Qtds.Enabled   = .F.
                .cnt_4c_Dados.txt_4c_QtHoras.Enabled = .F.
                .cnt_4c_Dados.txt_4c_Mes.Value      = ""
                .cnt_4c_Dados.txt_4c_Ano.Value      = ""
                .cnt_4c_Dados.txt_4c_Qtds.Value     = 0
                .cnt_4c_Dados.txt_4c_QtHoras.Value  = 0
                .cnt_4c_Dados.txt_4c_TotHoras.Value = 0
                .cnt_4c_Dados.txt_4c_Mes.SetFocus()
            ENDWITH

            WITH THIS.obj_4c_CmdEscolha
                .Buttons(1).Enabled = .F.
                .Buttons(2).Enabled = .F.
                .Buttons(3).Enabled = .F.
                .Buttons(4).Enabled = .F.
            ENDWITH

            WITH THIS.obj_4c_CmdSalva
                .Buttons(1).Enabled = .T.
                .Buttons(2).Enabled = .F.
                .Buttons(3).Enabled = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.CmdInserirClick")
        ENDTRY
    ENDFUNC

    *==========================================================================
    * CmdAlterarClick - Modo ALTERAR: permite editar horas/qtd no calend?rio
    *==========================================================================
    FUNCTION CmdAlterarClick()
        LOCAL loc_oErro

        TRY
            THIS.this_oBusinessObject.this_cPcEscolha = "ALTERAR"

            WITH THIS
                .grd_4c_Dados.Enabled              = .F.
                .cnt_4c_Calendario.Enabled          = .T.
                .cnt_4c_Dados.Visible               = .T.
                .cnt_4c_Dados.txt_4c_Mes.Enabled    = .F.
                .cnt_4c_Dados.txt_4c_Ano.Enabled    = .F.
                .cnt_4c_Dados.txt_4c_Qtds.Enabled   = .T.
                .cnt_4c_Dados.txt_4c_QtHoras.Enabled = .T.
            ENDWITH

            WITH THIS.obj_4c_CmdEscolha
                .Buttons(1).Enabled = .F.
                .Buttons(2).Enabled = .F.
                .Buttons(3).Enabled = .F.
                .Buttons(4).Enabled = .F.
            ENDWITH

            WITH THIS.obj_4c_CmdSalva
                .Buttons(1).Enabled = .T.
                .Buttons(2).Enabled = .F.
                .Buttons(3).Enabled = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.CmdAlterarClick")
        ENDTRY
    ENDFUNC

    *==========================================================================
    * CmdExcluirClick - Modo EXCLUIR: confirma??o e exclus?o do per?odo
    *==========================================================================
    FUNCTION CmdExcluirClick()
        LOCAL loc_oErro

        TRY
            THIS.this_oBusinessObject.this_cPcEscolha = "EXCLUIR"

            WITH THIS
                .grd_4c_Dados.Enabled              = .F.
                .cnt_4c_Calendario.Enabled          = .F.
                .cnt_4c_Dados.Visible               = .T.
                .cnt_4c_Dados.cmd_4c_BtnData.Caption = "Excluir"
                .cnt_4c_Dados.txt_4c_Mes.Enabled    = .F.
                .cnt_4c_Dados.txt_4c_Ano.Enabled    = .F.
                .cnt_4c_Dados.txt_4c_Qtds.Enabled   = .F.
                .cnt_4c_Dados.txt_4c_QtHoras.Enabled = .F.
            ENDWITH

            WITH THIS.obj_4c_CmdEscolha
                .Buttons(1).Enabled = .F.
                .Buttons(2).Enabled = .F.
                .Buttons(3).Enabled = .F.
                .Buttons(4).Enabled = .F.
            ENDWITH

            WITH THIS.obj_4c_CmdSalva
                .Buttons(1).Enabled = .T.
                .Buttons(2).Enabled = .F.
                .Buttons(3).Enabled = .T.
                .Buttons(3).SetFocus()
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.CmdExcluirClick")
        ENDTRY
    ENDFUNC

    *==========================================================================
    * CmdCopiarPClick - Modo COPIARP: copia o per?odo selecionado para novo m?s
    *==========================================================================
    FUNCTION CmdCopiarPClick()
        LOCAL loc_oErro, loc_lTemDados
        loc_lTemDados = USED("crMesAno") AND !EOF("crMesAno")

        TRY
            IF loc_lTemDados
                THIS.this_oBusinessObject.this_cPcEscolha = "COPIARP"

                WITH THIS
                    .grd_4c_Dados.Enabled              = .F.
                    .cnt_4c_Calendario.Enabled          = .F.
                    .cnt_4c_Dados.Visible               = .T.
                    .cnt_4c_Dados.cmd_4c_BtnData.Caption = "Copiar " + crMesAno.Mes + "/" + crMesAno.Ano
                    .cnt_4c_Dados.txt_4c_Mes.Enabled    = .T.
                    .cnt_4c_Dados.txt_4c_Ano.Enabled    = .T.
                    .cnt_4c_Dados.txt_4c_Qtds.Enabled   = .F.
                    .cnt_4c_Dados.txt_4c_QtHoras.Enabled = .F.
                    .cnt_4c_Dados.txt_4c_Mes.Value      = ""
                    .cnt_4c_Dados.txt_4c_Ano.Value      = ""
                    .cnt_4c_Dados.txt_4c_Qtds.Value     = 0
                    .cnt_4c_Dados.txt_4c_QtHoras.Value  = 0
                    .cnt_4c_Dados.txt_4c_TotHoras.Value = 0
                    .cnt_4c_Dados.txt_4c_Mes.SetFocus()
                ENDWITH

                WITH THIS.obj_4c_CmdEscolha
                    .Buttons(1).Enabled = .F.
                    .Buttons(2).Enabled = .F.
                    .Buttons(3).Enabled = .F.
                    .Buttons(4).Enabled = .F.
                ENDWITH

                WITH THIS.obj_4c_CmdSalva
                    .Buttons(1).Enabled = .T.
                    .Buttons(2).Enabled = .F.
                    .Buttons(3).Enabled = .T.
                ENDWITH
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.CmdCopiarPClick")
        ENDTRY
    ENDFUNC

    *==========================================================================
    * CmdSalvarClick - Executa a opera??o do modo atual (INSERIR/ALTERAR/EXCLUIR/COPIARP)
    *==========================================================================
    FUNCTION CmdSalvarClick()
        LOCAL loc_oErro, loc_lSucesso, loc_cEscolha
        LOCAL loc_cMes, loc_cAno, loc_cMesOrig, loc_cAnoOrig, loc_cMesDest, loc_cAnoDest
        loc_lSucesso = .F.

        TRY
            loc_cEscolha = THIS.this_oBusinessObject.this_cPcEscolha

            DO CASE
                CASE loc_cEscolha = "INSERIR"
                    loc_cMes = PADL(ALLTRIM(THIS.cnt_4c_Dados.txt_4c_Mes.Value), 2, "0")
                    loc_cAno = PADL(ALLTRIM(THIS.cnt_4c_Dados.txt_4c_Ano.Value), 4, "0")

                    IF EMPTY(ALLTRIM(loc_cMes)) OR EMPTY(ALLTRIM(loc_cAno))
                        MsgAviso("Informe o M" + CHR(234) + "s e o Ano para inserir.")
                        THIS.cnt_4c_Dados.txt_4c_Mes.SetFocus()
                    ELSE
                        loc_lSucesso = THIS.this_oBusinessObject.InserirPeriodo(loc_cMes, loc_cAno)

                        IF loc_lSucesso
                            THIS.MontarGradeMesAno()
                            SET NEAR ON
                            =SEEK(loc_cAno + loc_cMes, "crMesAno", "Ordem")
                            SET NEAR OFF
                            IF !EOF("crMesAno")
                                THIS.MontarCalendario(crMesAno.Mes, crMesAno.Ano)
                            ENDIF
                        ENDIF
                    ENDIF

                CASE loc_cEscolha = "ALTERAR"
                    loc_lSucesso = THIS.this_oBusinessObject.AlterarPeriodo()

                    IF loc_lSucesso AND USED("crMesAno") AND !EOF("crMesAno")
                        THIS.MontarCalendario(crMesAno.Mes, crMesAno.Ano)
                    ENDIF

                CASE loc_cEscolha = "EXCLUIR"
                    IF USED("crMesAno") AND !EOF("crMesAno")
                        loc_cMes = ALLTRIM(crMesAno.Mes)
                        loc_cAno = ALLTRIM(crMesAno.Ano)
                        loc_lSucesso = THIS.this_oBusinessObject.ExcluirPeriodo(loc_cMes, loc_cAno)
                        IF loc_lSucesso
                            THIS.MontarGradeMesAno()
                        ENDIF
                    ENDIF

                CASE loc_cEscolha = "COPIARP"
                    IF USED("crMesAno") AND !EOF("crMesAno")
                        loc_cMesOrig = ALLTRIM(crMesAno.Mes)
                        loc_cAnoOrig = ALLTRIM(crMesAno.Ano)
                        loc_cMesDest = PADL(ALLTRIM(THIS.cnt_4c_Dados.txt_4c_Mes.Value), 2, "0")
                        loc_cAnoDest = PADL(ALLTRIM(THIS.cnt_4c_Dados.txt_4c_Ano.Value), 4, "0")

                        IF EMPTY(ALLTRIM(loc_cMesDest)) OR EMPTY(ALLTRIM(loc_cAnoDest))
                            MsgAviso("Informe o M" + CHR(234) + "s e o Ano de destino para copiar.")
                            THIS.cnt_4c_Dados.txt_4c_Mes.SetFocus()
                        ELSE
                            loc_lSucesso = THIS.this_oBusinessObject.CopiarPeriodo( ;
                                loc_cMesOrig, loc_cAnoOrig, loc_cMesDest, loc_cAnoDest)

                            IF loc_lSucesso
                                THIS.MontarGradeMesAno()
                                SET NEAR ON
                                =SEEK(loc_cAnoDest + loc_cMesDest, "crMesAno", "Ordem")
                                SET NEAR OFF
                                IF !EOF("crMesAno")
                                    THIS.MontarCalendario(crMesAno.Mes, crMesAno.Ano)
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
            ENDCASE

            IF loc_lSucesso OR (loc_cEscolha = "ALTERAR" AND !loc_lSucesso)
                THIS.AjustarTela()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.CmdSalvarClick")
        ENDTRY
    ENDFUNC

    *==========================================================================
    * CmdCancelarClick - Cancela opera??o e retorna ao modo CONSULTAR
    *==========================================================================
    FUNCTION CmdCancelarClick()
        LOCAL loc_oErro

        TRY
            THIS.AjustarTela()
            IF USED("crMesAno") AND !EOF("crMesAno")
                THIS.MontarCalendario(crMesAno.Mes, crMesAno.Ano)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.CmdCancelarClick")
        ENDTRY
    ENDFUNC

    *==========================================================================
    * CmdEncerrarClick - Fecha o form
    *==========================================================================
    FUNCTION CmdEncerrarClick()
        THIS.Release()
    ENDFUNC

    *==========================================================================
    * ConfigurarPaginaDados - Inicializa o painel lateral de dados do dia
    * (cnt_4c_Dados) para o estado padr?o: campos zerados, edi??o desabilitada,
    * painel vis?vel. Chamado em InicializarForm e em AjustarTela (sem registros).
    *==========================================================================
    PROTECTED FUNCTION ConfigurarPaginaDados()
        LOCAL loc_oErro, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            WITH THIS.cnt_4c_Dados
                .Visible                 = .T.
                .cmd_4c_BtnData.Caption  = "00/00/0000"

                .txt_4c_Mes.Value        = ""
                .txt_4c_Mes.Enabled      = .F.

                .txt_4c_Ano.Value        = ""
                .txt_4c_Ano.Enabled      = .F.

                .txt_4c_Qtds.Value       = 0
                .txt_4c_Qtds.Enabled     = .F.

                .txt_4c_QtHoras.Value    = 0
                .txt_4c_QtHoras.Enabled  = .F.

                .txt_4c_TotHoras.Value   = 0
                .txt_4c_TotHoras.Enabled = .F.
            ENDWITH

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.ConfigurarPaginaDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ConfigurarPaginaLista - Aplica formata??o e estado de "lista" (grade
    * Mes/Ano + bot?es de escolha) neste form OPERACIONAL. Corresponde ao
    * setup de Page1 dos forms CRUD, adaptado para o layout customizado.
    * - Formata fontes/cores/headers da grade Mes/Ano
    * - Ajusta habilitacao dos bot?es de escolha conforme haja registros
    * - Refresca a grade
    *==========================================================================
    PROTECTED FUNCTION ConfigurarPaginaLista()
        LOCAL loc_oErro, loc_lTemRegistros, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_lTemRegistros = USED("crMesAno") AND RECCOUNT("crMesAno") > 0

            *-- Formatacao visual da grade (fontes, alinhamento, headers)
            WITH THIS.grd_4c_Dados
                .FontName = "Courier New"
                .FontSize = 9
                .SetAll("FontName", "Courier New", "Textbox")
                .SetAll("FontSize", 9,             "Textbox")
                .SetAll("Alignment", 2,            "Header")
                .SetAll("ForeColor", RGB(36,84,155), "Header")
                .SetAll("FontName", "Verdana",     "Header")
                .SetAll("FontSize", 8,             "Header")
                .GridLineColor      = RGB(238,238,238)
                .HighlightBackColor = RGB(15,41,104)
                .HighlightForeColor = RGB(255,255,255)
                .HighlightStyle     = 2
                .ScrollBars         = 2
                .DeleteMark         = .F.
                .RecordMark         = .F.
                .RowHeight          = 16
                .Enabled            = loc_lTemRegistros
            ENDWITH

            *-- Estado dos bot?es CRUD (equivalente a Page1 de forms CRUD):
            *-- Inserir sempre habilitado; Alterar/Excluir/Copiar dependem de registros
            WITH THIS.obj_4c_CmdEscolha
                .Buttons(1).Enabled = .T.
                .Buttons(2).Enabled = loc_lTemRegistros
                .Buttons(3).Enabled = loc_lTemRegistros
                .Buttons(4).Enabled = loc_lTemRegistros
            ENDWITH

            *-- Bot?es de a??o: Salvar/Cancelar desligados; Encerrar sempre pronto
            WITH THIS.obj_4c_CmdSalva
                .Buttons(1).Enabled = .F.
                .Buttons(2).Enabled = .T.
                .Buttons(3).Enabled = .F.
            ENDWITH

            THIS.grd_4c_Dados.Refresh()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.ConfigurarPaginaLista")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * AlternarPagina - Retorna ao estado de consulta (equivale a IrParaLista
    * em forms CRUD). Em forms OPERACIONAIS sem PageFrame, redefine controles
    * para o modo CONSULTAR e recarrega o calend?rio do m?s corrente.
    * par_nPagina : reservado (1=lista / 2=dados - n?o usado neste form)
    *==========================================================================
    FUNCTION AlternarPagina(par_nPagina)
        LOCAL loc_oErro
        TRY
            THIS.AjustarTela()
            IF USED("crMesAno") AND !EOF("crMesAno")
                THIS.MontarCalendario(crMesAno.Mes, crMesAno.Ano)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.AlternarPagina")
        ENDTRY
    ENDFUNC

    *==========================================================================
    * BtnIncluirClick - Compatibilidade FormBase: delega para CmdInserirClick
    *==========================================================================
    FUNCTION BtnIncluirClick()
        THIS.CmdInserirClick()
    ENDFUNC

    *==========================================================================
    * BtnAlterarClick - Compatibilidade FormBase: delega para CmdAlterarClick
    *==========================================================================
    FUNCTION BtnAlterarClick()
        THIS.CmdAlterarClick()
    ENDFUNC

    *==========================================================================
    * BtnVisualizarClick - Consultar: retorna ao modo CONSULTAR (AjustarTela)
    * O form SIGCDHOR n?o tem bot?o Visualizar dedicado; o modo de consulta
    * ? o estado padr?o obtido por AjustarTela + reload do calend?rio.
    *==========================================================================
    FUNCTION BtnVisualizarClick()
        LOCAL loc_oErro
        TRY
            THIS.AjustarTela()
            IF USED("crMesAno") AND !EOF("crMesAno")
                THIS.MontarCalendario(crMesAno.Mes, crMesAno.Ano)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.BtnVisualizarClick")
        ENDTRY
    ENDFUNC

    *==========================================================================
    * BtnExcluirClick - Compatibilidade FormBase: delega para CmdExcluirClick
    *==========================================================================
    FUNCTION BtnExcluirClick()
        THIS.CmdExcluirClick()
    ENDFUNC

    *==========================================================================
    * BtnBuscarClick - Compatibilidade FormBase: sem bot?o Buscar neste form
    * Retorna ao modo CONSULTAR (equivalente a clicar em Cancelar)
    *==========================================================================
    FUNCTION BtnBuscarClick()
        LOCAL loc_oErro
        TRY
            THIS.AjustarTela()
            IF USED("crMesAno") AND !EOF("crMesAno")
                THIS.MontarCalendario(crMesAno.Mes, crMesAno.Ano)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.BtnBuscarClick")
        ENDTRY
    ENDFUNC

    *==========================================================================
    * BtnEncerrarClick - Compatibilidade FormBase: fecha o form
    *==========================================================================
    FUNCTION BtnEncerrarClick()
        THIS.Release()
    ENDFUNC

    *==========================================================================
    * BtnSalvarClick - Compatibilidade FormBase: delega para CmdSalvarClick
    *==========================================================================
    FUNCTION BtnSalvarClick()
        THIS.CmdSalvarClick()
    ENDFUNC

    *==========================================================================
    * BtnCancelarClick - Compatibilidade FormBase: delega para CmdCancelarClick
    *==========================================================================
    FUNCTION BtnCancelarClick()
        THIS.CmdCancelarClick()
    ENDFUNC

    *==========================================================================
    * FormParaBO - Transfere dados do form para as propriedades do BO
    * Chamado antes de Inserir/Alterar/Excluir/CopiarPeriodo
    *==========================================================================
    FUNCTION FormParaBO()
        LOCAL loc_oErro, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            WITH THIS.this_oBusinessObject
                .this_cSetors   = THIS.this_cParCod
                .this_cUniPrdts = THIS.this_cParUni

                .this_cMes = PADL(ALLTRIM(THIS.cnt_4c_Dados.txt_4c_Mes.Value),    2, "0")
                .this_cAno = PADL(ALLTRIM(THIS.cnt_4c_Dados.txt_4c_Ano.Value),    4, "0")

                .this_nQtds    = THIS.cnt_4c_Dados.txt_4c_Qtds.Value
                .this_nQtHoras = THIS.cnt_4c_Dados.txt_4c_QtHoras.Value
            ENDWITH

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.FormParaBO")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * BOParaForm - Transfere propriedades do BO de volta para os controles
    * Chamado ap?s CarregarDoCursor ou para sincronizar painel lateral
    *==========================================================================
    FUNCTION BOParaForm()
        LOCAL loc_oErro, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            WITH THIS.cnt_4c_Dados
                .txt_4c_Mes.Value     = THIS.this_oBusinessObject.this_cMes
                .txt_4c_Ano.Value     = THIS.this_oBusinessObject.this_cAno
                .txt_4c_Qtds.Value    = THIS.this_oBusinessObject.this_nQtds
                .txt_4c_QtHoras.Value = THIS.this_oBusinessObject.this_nQtHoras

                IF !EMPTY(THIS.this_oBusinessObject.this_cMes) AND ;
                   !EMPTY(THIS.this_oBusinessObject.this_cAno)
                    .cmd_4c_BtnData.Caption = THIS.this_oBusinessObject.this_cMes + ;
                                             "/" + THIS.this_oBusinessObject.this_cAno
                ELSE
                    .cmd_4c_BtnData.Caption = "00/00/0000"
                ENDIF

                .txt_4c_TotHoras.Value = THIS.this_oBusinessObject.ConverterHorasParaDecimal( ;
                    THIS.this_oBusinessObject.this_nQtHoras, ;
                    THIS.this_oBusinessObject.this_nQtds)
                .Visible     = .T.
            ENDWITH

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.BOParaForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * HabilitarCampos - Habilita / desabilita campos do painel lateral
    * conforme o modo de opera??o atual (this_cPcEscolha)
    *==========================================================================
    FUNCTION HabilitarCampos()
        LOCAL loc_oErro, loc_cEscolha
        loc_cEscolha = THIS.this_oBusinessObject.this_cPcEscolha

        TRY
            WITH THIS.cnt_4c_Dados
                DO CASE
                    CASE loc_cEscolha = "INSERIR"
                        .txt_4c_Mes.Enabled     = .T.
                        .txt_4c_Ano.Enabled     = .T.
                        .txt_4c_Qtds.Enabled    = .F.
                        .txt_4c_QtHoras.Enabled = .F.

                    CASE loc_cEscolha = "ALTERAR"
                        .txt_4c_Mes.Enabled     = .F.
                        .txt_4c_Ano.Enabled     = .F.
                        .txt_4c_Qtds.Enabled    = .T.
                        .txt_4c_QtHoras.Enabled = .T.

                    CASE loc_cEscolha = "COPIARP"
                        .txt_4c_Mes.Enabled     = .T.
                        .txt_4c_Ano.Enabled     = .T.
                        .txt_4c_Qtds.Enabled    = .F.
                        .txt_4c_QtHoras.Enabled = .F.

                    OTHERWISE  && CONSULTAR / EXCLUIR
                        .txt_4c_Mes.Enabled     = .F.
                        .txt_4c_Ano.Enabled     = .F.
                        .txt_4c_Qtds.Enabled    = .F.
                        .txt_4c_QtHoras.Enabled = .F.
                ENDCASE
                .Visible     = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.HabilitarCampos")
        ENDTRY
    ENDFUNC

    *==========================================================================
    * LimparCampos - Zera todos os campos edit?veis do painel lateral
    * Chamado em CmdInserirClick e CmdCopiarPClick (novo per?odo vazio)
    *==========================================================================
    FUNCTION LimparCampos()
        LOCAL loc_oErro
        TRY
            WITH THIS.cnt_4c_Dados
                .cmd_4c_BtnData.Caption = "00/00/0000"
                .txt_4c_Mes.Value       = ""
                .txt_4c_Ano.Value       = ""
                .txt_4c_Qtds.Value      = 0
                .txt_4c_QtHoras.Value   = 0
                .txt_4c_TotHoras.Value  = 0
                .Visible     = .T.
            ENDWITH

            THIS.this_oBusinessObject.this_cMes     = ""
            THIS.this_oBusinessObject.this_cAno     = ""
            THIS.this_oBusinessObject.this_nQtds    = 0
            THIS.this_oBusinessObject.this_nQtHoras = 0
            THIS.this_nSlotAtual = 0
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.LimparCampos")
        ENDTRY
    ENDFUNC

    *==========================================================================
    * CarregarLista - Recarrega a grade Mes/Ano e o calend?rio do m?s corrente
    * Equivalente ao CarregarLista() de forms CRUD; chamado ap?s salvar/excluir
    *==========================================================================
    FUNCTION CarregarLista()
        LOCAL loc_oErro, loc_lSucesso
        loc_lSucesso = .F.

        *-- Em modo teste: this_oBusinessObject=.NULL. (InicializarForm pulou criacao de BO)
        *-- Chamar MontarGradeMesAno dispara dereference de NULL que pode travar headless VFP9
        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            RETURN .T.
        ENDIF

        TRY
            loc_lSucesso = THIS.MontarGradeMesAno()

            IF loc_lSucesso
                IF USED("crMesAno") AND !EOF("crMesAno")
                    THIS.MontarCalendario(crMesAno.Mes, crMesAno.Ano)
                ELSE
                    THIS.AjustarTela()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.CarregarLista")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos bot?es conforme o modo atual
    * Unifica o comportamento de AjustarTela + ConfigurarPaginaLista
    * Chamado ap?s mudar this_cPcEscolha
    *==========================================================================
    FUNCTION AjustarBotoesPorModo()
        LOCAL loc_oErro, loc_cEscolha, loc_lTemRegistros
        loc_cEscolha      = THIS.this_oBusinessObject.this_cPcEscolha
        loc_lTemRegistros = USED("crMesAno") AND RECCOUNT("crMesAno") > 0

        TRY
            DO CASE
                CASE loc_cEscolha = "INSERIR" OR loc_cEscolha = "EXCLUIR" OR ;
                     loc_cEscolha = "COPIARP"
                    WITH THIS.obj_4c_CmdEscolha
                        .Buttons(1).Enabled = .F.
                        .Buttons(2).Enabled = .F.
                        .Buttons(3).Enabled = .F.
                        .Buttons(4).Enabled = .F.
                    ENDWITH
                    WITH THIS.obj_4c_CmdSalva
                        .Buttons(1).Enabled = .T.
                        .Buttons(2).Enabled = .F.
                        .Buttons(3).Enabled = .T.
                    ENDWITH

                CASE loc_cEscolha = "ALTERAR"
                    WITH THIS.obj_4c_CmdEscolha
                        .Buttons(1).Enabled = .F.
                        .Buttons(2).Enabled = .F.
                        .Buttons(3).Enabled = .F.
                        .Buttons(4).Enabled = .F.
                    ENDWITH
                    WITH THIS.obj_4c_CmdSalva
                        .Buttons(1).Enabled = .T.
                        .Buttons(2).Enabled = .F.
                        .Buttons(3).Enabled = .T.
                    ENDWITH
                    THIS.grd_4c_Dados.Enabled     = .F.
                    THIS.cnt_4c_Calendario.Enabled = .T.

                OTHERWISE  && CONSULTAR
                    WITH THIS.obj_4c_CmdEscolha
                        .Buttons(1).Enabled = .T.
                        .Buttons(2).Enabled = loc_lTemRegistros
                        .Buttons(3).Enabled = loc_lTemRegistros
                        .Buttons(4).Enabled = loc_lTemRegistros
                    ENDWITH
                    WITH THIS.obj_4c_CmdSalva
                        .Buttons(1).Enabled = .F.
                        .Buttons(2).Enabled = .T.
                        .Buttons(3).Enabled = .F.
                    ENDWITH
                    THIS.grd_4c_Dados.Enabled     = loc_lTemRegistros
                    THIS.cnt_4c_Calendario.Enabled = loc_lTemRegistros
            ENDCASE

            THIS.HabilitarCampos()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.AjustarBotoesPorModo")
        ENDTRY
    ENDFUNC

ENDDEFINE
