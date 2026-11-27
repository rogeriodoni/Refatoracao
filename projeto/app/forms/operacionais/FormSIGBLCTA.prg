*==============================================================
* FormSIGBLCTA.prg
* Form Processamento de Bloqueio de Contas
* Tipo: OPERACIONAL (flat - sem PageFrame)
* Migrado de SIGBLCTA.SCX
*
* Pilares:
*   UX   -> layout PIXEL-PERFECT identico ao legado
*   BD   -> SigCdCli / SigMvPar / SigMvCab / SigOpFp / SigCdCst
*   CODE -> arquitetura em camadas (FormBase / SIGBLCTABO)
*==============================================================

DEFINE CLASS FormSIGBLCTA AS FormBase

    *-- Propriedades visuais (copiadas do original)
    Height      = 230
    Width       = 500
    BorderStyle = 2
    AutoCenter  = .T.
    ShowTips    = .T.
    Caption     = "Processamento para Bloqueio de Contas"
    ShowWindow = 1
    WindowType = 1
    ControlBox  = .F.
    Closable    = .F.
    TitleBar    = 0
    WindowState = 0
    DataSession = 2

    *-- Propriedades customizadas
    this_cMensagemErro          = ""
    this_cUltimoSituasValidado  = ""

    *============================================================
    PROCEDURE InicializarForm
    *============================================================
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        TRY
            THIS.Picture = gc_4c_CaminhoFramework + "imagens\fundo_cadastro.jpg"
            THIS.ConfigurarCabecalho()
            THIS.ConfigurarCampos()
            THIS.ConfigurarOpcoes()
            THIS.ConfigurarCntAguarde()
            THIS.ConfigurarBotoes()
            THIS.TornarControlesVisiveis(THIS)
            THIS.ConfigurarBINDEVENTs()
            THIS.InicializarValores()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao inicializar form: " + loc_oErro.Message)
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *============================================================
    PROCEDURE ConfigurarCabecalho
    *============================================================
        LOCAL loc_oCnt
        THIS.AddObject("cnt_4c_Sombra", "Container")
        loc_oCnt = THIS.cnt_4c_Sombra
        WITH loc_oCnt
            .Top        = 0
            .Left       = 0
            .Width      = THIS.Width
            .Height     = 80
            .BorderWidth= 0
            .BackColor  = RGB(100,100,100)
            .Visible    = .T.
            .AddObject("lbl_4c_LblSombra", "Label")
            WITH .lbl_4c_LblSombra
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 12
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .Caption       = "Processamento para Bloqueio de Contas"
                .Height        = 40
                .Left          = 10
                .Top           = 0
                .Width         = 337
                .ForeColor     = RGB(0,0,0)
                .Visible       = .T.
            ENDWITH
            .AddObject("lbl_4c_LblTitulo", "Label")
            WITH .lbl_4c_LblTitulo
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 12
                .WordWrap   = .T.
                .Alignment  = 0
                .BackStyle  = 0
                .Caption    = "Processamento para Bloqueio de Contas"
                .Height     = 46
                .Left       = 10
                .Top        = 3
                .Width      = 337
                .ForeColor  = RGB(255,255,255)
                .Visible    = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *============================================================
    PROCEDURE ConfigurarCampos
    *============================================================
        LOCAL loc_oCtrl

        *-- Label "Periodo :"
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .AutoSize   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .BackStyle  = 0
            .Caption    = "Per" + CHR(237) + "odo :"
            .Height     = 15
            .Left       = 51
            .Top        = 97
            .Width      = 45
            .ForeColor  = RGB(90,90,90)
            .Visible    = .T.
        ENDWITH

        *-- TextBox Data Inicial
        THIS.AddObject("txt_4c_Datai", "TextBox")
        WITH THIS.txt_4c_Datai
            .FontName      = "Courier New"
            .Alignment     = 3
            .Value         = {}
            .Format        = "KD"
            .Height        = 25
            .Left          = 98
            .MaxLength     = 10
            .SpecialEffect = 1
            .Top           = 92
            .Width         = 79
            .Visible       = .T.
        ENDWITH

        *-- Label separador "a" entre datas
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .AutoSize   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .BackStyle  = 0
            .Caption    = "a"
            .Height     = 15
            .Left       = 182
            .Top        = 97
            .Width      = 8
            .ForeColor  = RGB(90,90,90)
            .Visible    = .T.
        ENDWITH

        *-- TextBox Data Final
        THIS.AddObject("txt_4c_Dataf", "TextBox")
        WITH THIS.txt_4c_Dataf
            .FontName      = "Courier New"
            .Alignment     = 3
            .Value         = {}
            .Format        = "KD"
            .Height        = 25
            .Left          = 193
            .MaxLength     = 10
            .SpecialEffect = 1
            .Top           = 92
            .Width         = 79
            .Visible       = .T.
        ENDWITH

        *-- Label "Situacao :"
        THIS.AddObject("lbl_4c_Label6", "Label")
        WITH THIS.lbl_4c_Label6
            .AutoSize   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .BackStyle  = 0
            .Caption    = "Situa" + CHR(231) + CHR(227) + "o :"
            .Height     = 15
            .Left       = 46
            .Top        = 125
            .Width      = 50
            .ForeColor  = RGB(90,90,90)
            .Visible    = .T.
        ENDWITH

        *-- TextBox Situacao
        THIS.AddObject("txt_4c_Situas", "TextBox")
        WITH THIS.txt_4c_Situas
            .FontBold      = .F.
            .FontItalic    = .F.
            .FontName      = "Courier New"
            .FontSize      = 9
            .FontUnderline = .F.
            .Alignment     = 0
            .BackStyle     = 1
            .BorderStyle   = 1
            .Value         = ""
            .Format        = "K"
            .Height        = 25
            .Left          = 98
            .MaxLength     = 3
            .SpecialEffect = 1
            .Top           = 120
            .Width         = 31
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *============================================================
    PROCEDURE ConfigurarOpcoes
    *============================================================
        LOCAL loc_oOpt

        *-- OptionGroup Bloqueio/Desbloqueio
        THIS.AddObject("opt_4c_Bloq", "OptionGroup")
        loc_oOpt = THIS.opt_4c_Bloq
        WITH loc_oOpt
            .AutoSize     = .T.
            .ButtonCount  = 2
            .BackStyle    = 0
            .BorderStyle  = 0
            .Value        = 1
            .Height       = 25
            .Left         = 137
            .Top          = 120
            .Width        = 161
            .Visible      = .T.
            WITH .Buttons(1)
                .FontName   = "Tahoma"
                .FontSize   = 8
                .BackStyle  = 0
                .Caption    = "Bloqueio"
                .Value      = 1
                .Height     = 15
                .Left       = 5
                .Top        = 5
                .Width      = 58
                .AutoSize   = .T.
                .ForeColor  = RGB(90,90,90)
                .Themes     = .F.
            ENDWITH
            WITH .Buttons(2)
                .FontName   = "Tahoma"
                .FontSize   = 8
                .BackStyle  = 0
                .Caption    = "Desbloqueio"
                .Value      = 0
                .Height     = 15
                .Left       = 80
                .Top        = 5
                .Width      = 76
                .AutoSize   = .T.
                .ForeColor  = RGB(90,90,90)
                .Themes     = .F.
            ENDWITH
        ENDWITH

        *-- Label "Opcao :"
        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .AutoSize   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .BackStyle  = 0
            .Caption    = "Op" + CHR(231) + CHR(227) + "o :"
            .Height     = 15
            .Left       = 56
            .Top        = 153
            .Width      = 40
            .ForeColor  = RGB(90,90,90)
            .Visible    = .T.
        ENDWITH

        *-- OptionGroup Opcao (3 botoes)
        THIS.AddObject("opt_4c_Opcao", "OptionGroup")
        loc_oOpt = THIS.opt_4c_Opcao
        WITH loc_oOpt
            .AutoSize      = .T.
            .ButtonCount   = 3
            .BackStyle     = 0
            .SpecialEffect = 1
            .Value         = 1
            .Height        = 63
            .Left          = 98
            .Top           = 147
            .Width         = 187
            .Themes        = .F.
            .Visible       = .T.
            WITH .Buttons(1)
                .FontName      = "Tahoma"
                .FontSize      = 8
                .BackStyle     = 0
                .Caption       = "Somente com Parcelas em Atraso"
                .Value         = 1
                .Height        = 15
                .Left          = 5
                .Top           = 5
                .Width         = 177
                .AutoSize      = .T.
                .ForeColor     = RGB(90,90,90)
                .Themes        = .F.
                .ToolTipText   = "Nao Esta com Parcelas em Atraso e esta Parcelas em Aberto"
            ENDWITH
            WITH .Buttons(2)
                .FontName      = "Tahoma"
                .FontSize      = 8
                .BackStyle     = 0
                .Caption       = "Somente com Vendas em Aberto"
                .Value         = 0
                .Height        = 15
                .Left          = 5
                .Top           = 24
                .Width         = 173
                .AutoSize      = .T.
                .ForeColor     = RGB(90,90,90)
                .Themes        = .F.
                .ToolTipText   = "Esta com Parcelas em Atraso e esta com Parcelas em Aberto"
            ENDWITH
            WITH .Buttons(3)
                .FontName      = "Tahoma"
                .FontSize      = 8
                .BackStyle     = 0
                .Caption       = "Ambos"
                .Value         = 0
                .Height        = 15
                .Left          = 5
                .Top           = 43
                .Width         = 50
                .AutoSize      = .T.
                .ForeColor     = RGB(90,90,90)
                .Themes        = .F.
                .ToolTipText   = "Esta com Parcelas em Atraso ou esta com Parcelas em Aberto"
            ENDWITH
        ENDWITH
    ENDPROC

    *============================================================
    PROCEDURE ConfigurarCntAguarde
    *============================================================
        LOCAL loc_oCnt
        THIS.AddObject("cnt_4c_Aguarde", "Container")
        loc_oCnt = THIS.cnt_4c_Aguarde
        WITH loc_oCnt
            .Top           = 120
            .Left          = 146
            .Width         = 207
            .Height        = 49
            .SpecialEffect = 0
            .BackColor     = RGB(255,255,255)
            .Visible       = .F.
            .AddObject("lbl_4c_Label1Agu", "Label")
            WITH .lbl_4c_Label1Agu
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 10
                .BackStyle  = 0
                .Caption    = "Aguarde..."
                .Height     = 18
                .Left       = 69
                .Top        = 7
                .Width      = 68
                .ForeColor  = RGB(90,90,90)
                .Visible    = .T.
            ENDWITH
            .AddObject("lbl_4c_Label2Agu", "Label")
            WITH .lbl_4c_Label2Agu
                .AutoSize      = .T.
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 10
                .FontCondense  = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .Caption       = "Processando Dados..."
                .Height        = 18
                .Left          = 24
                .Top           = 24
                .Width         = 141
                .ForeColor     = RGB(90,90,90)
                .Visible       = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *============================================================
    PROCEDURE ConfigurarBotoes
    *============================================================
        *-- Botao Processa
        THIS.AddObject("cmd_4c_Processa", "CommandButton")
        WITH THIS.cmd_4c_Processa
            .Caption         = "\<Processar"
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "disabled\geral_processar_60.jpg"
            .PicturePosition = 13
            .Top             = 3
            .Left            = 347
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botao Cancela
        THIS.AddObject("cmd_4c_Cancela", "CommandButton")
        WITH THIS.cmd_4c_Cancela
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "disabled\cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Top             = 3
            .Left            = 423
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Cancel          = .T.
            .Visible         = .T.
        ENDWITH
    ENDPROC

    *============================================================
    * par_oContainer eh OBRIGATORIO na recursao: antes o metodo nao declarava
    * parametro NENHUM e mesmo assim chamava a si proprio com um argumento, o
    * que estoura "No PARAMETER statement is found." Ausente, varre o proprio form.
    PROCEDURE TornarControlesVisiveis(par_oContainer)
    *============================================================
        LOCAL loc_i, loc_oCtrl, loc_cNome, loc_oAlvo
        loc_oAlvo = IIF(VARTYPE(par_oContainer) = "O", par_oContainer, THIS)

        FOR loc_i = 1 TO loc_oAlvo.ControlCount
            loc_oCtrl = loc_oAlvo.Controls(loc_i)
            IF VARTYPE(loc_oCtrl) != "O"
                LOOP
            ENDIF
            loc_cNome = LOWER(loc_oCtrl.Name)
            *-- Nao tornar visivel containers com Visible=.F. gerenciados individualmente
            IF INLIST(loc_cNome, "cnt_4c_aguarde", "cnt_4c_sombra")
                *-- Container preserva estado inicial, mas recursa para os filhos
                IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oCtrl)
                ENDIF
                LOOP
            ENDIF
            IF PEMSTATUS(loc_oCtrl, "Visible", 5)
                loc_oCtrl.Visible = .T.
            ENDIF
        NEXT
    ENDPROC

    *============================================================
    PROCEDURE InicializarValores
    *============================================================
        THIS.txt_4c_Datai.Value  = {}
        THIS.txt_4c_Dataf.Value  = {}
        THIS.txt_4c_Situas.Value = ""
    ENDPROC

    *============================================================
    PROCEDURE ConfigurarBINDEVENTs
    *============================================================
        BINDEVENT(THIS.txt_4c_Datai,  "KeyPress", THIS, "TxtDataiLostFocus")
        BINDEVENT(THIS.txt_4c_Situas, "KeyPress", THIS, "TxtSituasLostFocus")
        BINDEVENT(THIS.opt_4c_Bloq,   "InteractiveChange", THIS, "OptBloqInteractiveChange")
        BINDEVENT(THIS.cmd_4c_Processa, "Click", THIS, "BtnProcessaClick")
        BINDEVENT(THIS.cmd_4c_Cancela,  "Click", THIS, "BtnCancelaClick")
    ENDPROC

    *============================================================
    * HANDLERS DE EVENTOS
    *============================================================

    PROCEDURE TxtDataiLostFocus
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        *-- Ajusta data final para que nao seja menor que data inicial
        THIS.txt_4c_Dataf.Value = IIF(THIS.txt_4c_Datai.Value > THIS.txt_4c_Dataf.Value, ;
            THIS.txt_4c_Datai.Value, THIS.txt_4c_Dataf.Value)
    ENDPROC

    PROCEDURE TxtSituasLostFocus
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        *-- 13=Enter 9=Tab -3=F4. O 115 que estava aqui NAO eh F4: medido no
        *-- VFP9 (2026-11-25) 115 eh a letra "s" minuscula, entao digitar um "s"
        *-- no campo disparava a validacao/lookup no meio da digitacao.
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != -3
            RETURN
        ENDIF
        LOCAL loc_cValorAtual, loc_cQuery, loc_oLookup
        loc_cValorAtual = ALLTRIM(THIS.txt_4c_Situas.Value)

        *-- Guardia: evitar reprocessamento com mesmo valor
        IF loc_cValorAtual == THIS.this_cUltimoSituasValidado
            RETURN
        ENDIF

        IF EMPTY(loc_cValorAtual)
            THIS.this_cUltimoSituasValidado = ""
            RETURN
        ENDIF

        *-- Consultar situacoes no banco
        loc_cQuery = "SELECT Codigos, Descrs FROM SigCdCst WHERE NOT Autos = 2"
        IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_ListaSituas") < 1
            MsgErro("Falha na conex" + CHR(227) + "o (SigCdCst)")
            RETURN
        ENDIF

        SELECT cursor_4c_ListaSituas
        LOCATE FOR ALLTRIM(Codigos) == loc_cValorAtual

        IF FOUND()
            *-- Codigo encontrado direto
            THIS.txt_4c_Situas.Value            = ALLTRIM(cursor_4c_ListaSituas.Codigos)
            THIS.this_cUltimoSituasValidado     = ALLTRIM(cursor_4c_ListaSituas.Codigos)
        ELSE
            *-- Abrir FormBuscaAuxiliar sobre o cursor JA populado acima.
            *-- CLAUDE.md regra #36: o 1o argumento do Init eh o HANDLE da conexao.
            *-- A chamada antiga passava o CURSOR ali, deslocando todos os demais:
            *-- par_cCampo ficava sem valor (.F. logico) e a concatenacao do SELECT
            *-- estourava "Operator/operand type mismatch" dentro do FormBuscaAuxiliar.
            *-- Para REUSAR cursor ja populado o padrao eh CREATEOBJECT SEM argumento
            *-- + this_cCursorDestino/this_cTitulo (igual FormCEP.AbrirLookupCidades).
            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oLookup) != "O"
                RETURN
            ENDIF
            loc_oLookup.this_cCursorDestino = "cursor_4c_ListaSituas"
            loc_oLookup.this_cTitulo        = "Situa" + CHR(231) + CHR(245) + "es"
            loc_oLookup.mAddColuna("Codigos", "", "C" + CHR(243) + "digo", 60)
            loc_oLookup.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o", 260)
            loc_oLookup.Show()
            IF loc_oLookup.this_lSelecionou
                THIS.txt_4c_Situas.Value        = ALLTRIM(cursor_4c_ListaSituas.Codigos)
                THIS.this_cUltimoSituasValidado = ALLTRIM(cursor_4c_ListaSituas.Codigos)
            ELSE
                THIS.txt_4c_Situas.Value        = ""
                THIS.this_cUltimoSituasValidado = ""
            ENDIF
            loc_oLookup = .NULL.
        ENDIF

        USE IN SELECT("cursor_4c_ListaSituas")
        THIS.txt_4c_Situas.Refresh()
    ENDPROC

    PROCEDURE OptBloqInteractiveChange
        *-- Quando Desbloqueio selecionado, forca opcao = Ambos (igual ao legado)
        IF THIS.opt_4c_Bloq.Value = 2
            THIS.opt_4c_Opcao.Value = 3
        ENDIF
    ENDPROC

    PROCEDURE BtnProcessaClick
        THIS.Processamento()
    ENDPROC

    PROCEDURE BtnCancelaClick
        THIS.Release()
    ENDPROC

    *============================================================
    PROCEDURE Processamento
    *============================================================
        LOCAL loc_ldDtIni, loc_ldDtFim, loc_lcSituas, loc_lnOpcao, loc_lnBloq
        LOCAL loc_lcCond, loc_lcFiltro, loc_lcTit, loc_lcQuery, loc_lcUpdate
        LOCAL loc_lcPDti, loc_lcPDtf, loc_cDtfBase, loc_lcRelPath
        LOCAL loc_lcCodSituas, loc_lcCpl, loc_llOks, loc_lnErr
        LOCAL loc_lSucesso, loc_lProsseguir

        loc_ldDtIni  = THIS.txt_4c_Datai.Value
        loc_ldDtFim  = THIS.txt_4c_Dataf.Value
        loc_lcSituas = ALLTRIM(THIS.txt_4c_Situas.Value)
        loc_lnOpcao  = THIS.opt_4c_Opcao.Value
        loc_lnBloq   = THIS.opt_4c_Bloq.Value

        *-- Validacoes (fora do TRY - RETURN permitido aqui)
        IF EMPTY(loc_lcSituas)
            MsgAviso("Situa" + CHR(231) + CHR(227) + "o N" + CHR(227) + "o Informada!!!")
            RETURN
        ENDIF

        IF EMPTY(loc_ldDtIni) OR EMPTY(loc_ldDtFim)
            MsgAviso("Per" + CHR(237) + "odo N" + CHR(227) + "o Informado!!!")
            RETURN
        ENDIF

        IF loc_ldDtIni > loc_ldDtFim
            MsgAviso("Data Inicial n" + CHR(227) + "o deve ser maior que a Data Final.")
            RETURN
        ENDIF

        THIS.cnt_4c_Aguarde.Visible = .T.
        THIS.Refresh()

        loc_lSucesso    = .F.
        loc_lProsseguir = .T.

        TRY
            *-- Cursor de cabecalho para o relatorio
            SET NULL ON
            CREATE CURSOR cursor_4c_Cabecalho (Titulo C(200))
            SET NULL OFF

            *-- Formatar datas para SQL Server
            loc_lcPDti  = FormatarDataSQL(loc_ldDtIni)
            loc_cDtfBase = DTOC(loc_ldDtFim, 1)
            loc_lcPDtf  = "'" + LEFT(loc_cDtfBase,4) + "-" + SUBSTR(loc_cDtfBase,5,2) + ;
                "-" + RIGHT(loc_cDtfBase,2) + " 23:59:59'"

            loc_lcCodSituas = EscaparSQL(ALLTRIM(loc_lcSituas))

            *-- Query 1: ultimo vencimento por conta (filtro bloqueio/desbloqueio)
            loc_lcQuery = "SELECT b.ContaDs AS Contas, MAX(a.Vencs) AS UltVencs, c.Situas " + ;
                "FROM SigMvPar a " + ;
                "JOIN SigMvCab b ON a.EmpDopNums = b.EmpDopNums " + ;
                "JOIN SigOpFp d ON d.Fpags = a.Fpags " + ;
                "JOIN SigCdCli c ON c.IClis = b.ContaDs " + ;
                "WHERE b.ContaDs <> SPACE(10) " + ;
                "AND " + IIF(loc_lnBloq = 1, "a.VPags <> a.Valos", "a.VPags = a.Valos") + " " + ;
                "AND d.Infos <> 'T' " + ;
                "AND c.Situas <> " + loc_lcCodSituas + " " + ;
                "GROUP BY b.ContaDs, c.Situas"

            IF SQLEXEC(gnConnHandle, loc_lcQuery, "cursor_4c_UltVencs") < 1
                MsgErro("Favor Reiniciar o Processo!!!")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                *-- Construir condicao de cruzamento e filtro da query principal
                DO CASE
                CASE loc_lnOpcao = 1
                    loc_lcCond   = " uv.UltVencs < cr.Vencs "
                    loc_lcFiltro = " a.VPags <> a.Valos "
                    loc_lcTit    = "Somente com Parcelas em Atraso"
                CASE loc_lnOpcao = 2
                    loc_lcCond   = " uv.UltVencs >= cr.Vencs "
                    loc_lcFiltro = " a.VPags = a.Valos "
                    loc_lcTit    = "Somente com Vendas em Aberto"
                CASE loc_lnOpcao = 3
                    loc_lcCond   = " 0=0 "
                    loc_lcTit    = "Com Parcelas em Atraso e Venda em Aberto"
                    loc_lcFiltro = " a.valos = a.vpags " + ;
                        "AND b.ContaDs NOT IN (" + ;
                            "SELECT DISTINCT sb.ContaDs " + ;
                            "FROM SigMvPar sa " + ;
                            "JOIN SigMvCab sb ON sa.EmpDopNums = sb.EmpDopNums " + ;
                            "JOIN SigCdCli sc ON sc.IClis = sb.ContaDs " + ;
                            "JOIN SigOpFp sd ON sd.FPags = sa.FPags " + ;
                            "JOIN SigCdGcr sg ON sc.Grupos = sg.Codigos " + ;
                            "WHERE sb.ContaDs <> SPACE(10) " + ;
                            "AND sd.Infos <> 'T' " + ;
                            "AND sg.Coletors = 2 " + ;
                            "AND sa.valos <> sa.vpags)"
                    loc_lcFiltro = IIF(loc_lnBloq = 1, " 0=0 ", loc_lcFiltro)
                ENDCASE

                loc_lcTit = "Processamento de " + IIF(loc_lnBloq = 1, "Bloqueio", "Desbloqueio") + ;
                    " - " + loc_lcTit
                INSERT INTO cursor_4c_Cabecalho (Titulo) VALUES (loc_lcTit)

                *-- Query 2: contas no periodo com filtro de opcao
                loc_lcQuery = "SELECT b.ContaDs AS Contas, c.RClis AS DescConta, " + ;
                    "MAX(a.Vencs) AS Vencs, c.Situas " + ;
                    "FROM SigMvPar a " + ;
                    "JOIN SigMvCab b ON a.EmpDopNums = b.EmpDopNums " + ;
                    "JOIN SigCdCli c ON c.IClis = b.ContaDs " + ;
                    "JOIN SigOpFp d ON d.FPags = a.FPags " + ;
                    "JOIN SigCdGcr g ON c.Grupos = g.Codigos " + ;
                    "WHERE b.ContaDs <> SPACE(10) " + ;
                    "AND a.Vencs BETWEEN " + loc_lcPDti + " AND " + loc_lcPDtf + " " + ;
                    "AND d.Infos <> 'T' " + ;
                    "AND g.Coletors = 2 " + ;
                    "AND c.Situas <> " + loc_lcCodSituas + " " + ;
                    "AND " + loc_lcFiltro + " " + ;
                    "GROUP BY b.ContaDs, c.RClis, c.Situas"

                IF SQLEXEC(gnConnHandle, loc_lcQuery, "cursor_4c_Result") < 1
                    MsgErro("Favor Reiniciar o Processo!!!")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                *-- Cruzamento local: UltVencs x Result usando condicao por opcao
                SELECT uv.Contas, cr.DescConta, uv.UltVencs, cr.Vencs, cr.Situas ;
                    FROM cursor_4c_UltVencs uv ;
                    INNER JOIN cursor_4c_Result cr ON uv.Contas = cr.Contas ;
                    WHERE &loc_lcCond ;
                    INTO CURSOR cursor_4c_Dados READWRITE

                *-- Cursor de erros (mesma estrutura de cursor_4c_Dados)
                SELECT * FROM cursor_4c_Dados INTO CURSOR cursor_4c_Erros READWRITE

                SELECT cursor_4c_Dados
                GO TOP

                IF RECCOUNT() = 0
                    MsgInfo("Nenhum Registro foi Selecionado.")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                *-- Exibir relatorio preview
                *-- Helper canonico: FRX em gc_4c_CaminhoReports, com teste FILE()
                IF !THIS.ExecutarReportForm("SigBlCta", "PREVIEW")
                    loc_lProsseguir = .F.
                ENDIF

                *-- Confirmar atualizacao de situacoes
                *-- CLAUDE.md regra #7: MsgConfirma devolve LOGICO (.T./.F.), nunca 6.
                *-- Comparar com 6 estoura Operator/operand type mismatch bem no meio
                *-- do processamento, depois do preview do relatorio.
                IF !MsgConfirma("Deseja Atualizar as Situa" + CHR(231) + CHR(245) + "es das Contas?")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                loc_lnErr = 0

                *-- Transacao explicita para o batch de UPDATEs
                SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

                SELECT cursor_4c_Dados
                SCAN
                    loc_lcUpdate = "UPDATE SigCdCli SET " + ;
                        "Situas = "  + EscaparSQL(ALLTRIM(loc_lcSituas))           + ", " + ;
                        "usualts = " + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado))    + ", " + ;
                        "dtalts = GETDATE() " + ;
                        "WHERE IClis = " + EscaparSQL(ALLTRIM(cursor_4c_Dados.Contas))

                    IF SQLEXEC(gnConnHandle, loc_lcUpdate) < 1
                        MsgErro("Favor Reiniciar o Processo!!!")
                        INSERT INTO cursor_4c_Erros (Contas, DescConta) ;
                            VALUES (cursor_4c_Dados.Contas, cursor_4c_Dados.DescConta)
                        loc_lnErr = loc_lnErr + 1
                    ENDIF
                ENDSCAN

                loc_llOks = .T.

                IF SQLCOMMIT(gnConnHandle) < 1
                    loc_llOks = .F.
                    SQLROLLBACK(gnConnHandle)
                ENDIF

                IF loc_llOks
                    IF loc_lnErr > 0
                        IF loc_lnErr = 1
                            loc_lcCpl = "Por" + CHR(233) + "m UMA Conta Apresentou Erro."
                        ELSE
                            loc_lcCpl = "Por" + CHR(233) + "m " + ALLTRIM(STR(loc_lnErr, 10)) + ;
                                " Contas Apresentaram Erros."
                        ENDIF
                        MsgInfo("A Grava" + CHR(231) + CHR(227) + "o Dos Dados Foi Realizada " + ;
                            "Com Sucesso!!!" + CHR(13) + loc_lcCpl + " Veja o LOG!!!")

                        SELECT cursor_4c_Erros
                        GO TOP
                        REPLACE Titulo WITH "Erros do Processamento" IN cursor_4c_Cabecalho
                        THIS.ExecutarReportForm("SigBlCta", "PREVIEW")
                    ELSE
                        MsgInfo("A Grava" + CHR(231) + CHR(227) + "o Dos Dados Foi Realizada " + ;
                            "Com Sucesso!!!")
                    ENDIF
                ELSE
                    MsgErro("A Grava" + CHR(231) + CHR(227) + "o Dos Dados N" + CHR(195) + ;
                        "O Pode Ser Realizada!!!")
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro no processamento: " + loc_oErro.Message)
            SQLROLLBACK(gnConnHandle)
        ENDTRY

        THIS.cnt_4c_Aguarde.Visible = .F.

        IF loc_lSucesso
            THIS.txt_4c_Datai.Value             = {}
            THIS.txt_4c_Dataf.Value             = {}
            THIS.txt_4c_Situas.Value            = ""
            THIS.this_cUltimoSituasValidado     = ""
            THIS.Refresh()
        ENDIF
    ENDPROC

    *============================================================
    PROCEDURE Buscar
    *============================================================
    LPARAMETERS par_cFiltro
        *-- Form processamento: carga de dados acionada pelo botao Processar
        *-- Sem carregamento inicial de grade
        IF TYPE("gnConnHandle") <> "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *============================================================
    PROCEDURE Destroy
    *============================================================
        DODEFAULT()
    ENDPROC


    *============================================================
    * ExecutarReportForm - helper canonico de REPORT FORM
    *
    * Antes o form fazia:
    *     loc_lcRelPath = gc_4c_CaminhoFramework + "SigBlCta"
    *     REPORT FORM &loc_lcRelPath PREVIEW
    * Dois problemas:
    *   1) apontava para a pasta do Framework legado, nao para
    *      gc_4c_CaminhoReports, que eh onde moram os 210 FRX do projeto;
    *   2) a forma MACRO (&var.) nao tem como testar FILE() antes, entao o
    *      FRX ausente virava um "File does not exist" seco, sem dizer QUAL
    *      arquivo faltava (erro392).
    * Helper canonico: FULLPATH + IF FILE + mensagem nomeando o FRX +
    * isolamento de POINT/SEPARATOR/REPORTBEHAVIOR.
    *
    * par_cRelatorioBase - nome base do FRX, SEM extensao
    * par_cModo          - "PREVIEW" | "PRINTER_PROMPT" | "PRINTER"
    *============================================================
    PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo)
        LOCAL loc_cFRX, loc_cPonto, loc_cSeparador, loc_lResultado
        loc_lResultado = .F.

        loc_cFRX = FULLPATH(gc_4c_CaminhoReports + ALLTRIM(par_cRelatorioBase) + ".frx")

        IF !FILE(loc_cFRX)
            MsgErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + ;
                CHR(13) + loc_cFRX + CHR(13) + CHR(13) + ;
                "O FRX legado ainda n" + CHR(227) + "o foi portado.", ;
                "Relat" + CHR(243) + "rio")
            RETURN .F.
        ENDIF

        loc_cPonto     = SET("POINT")
        loc_cSeparador = SET("SEPARATOR")

        TRY
            SET POINT TO "."
            SET SEPARATOR TO ","
            SET REPORTBEHAVIOR 80

            DO CASE
            CASE UPPER(ALLTRIM(par_cModo)) == "PRINTER_PROMPT"
                REPORT FORM (loc_cFRX) NOCONSOLE TO PRINTER PROMPT
            CASE UPPER(ALLTRIM(par_cModo)) == "PRINTER"
                REPORT FORM (loc_cFRX) NOCONSOLE TO PRINTER
            OTHERWISE
                REPORT FORM (loc_cFRX) NOCONSOLE PREVIEW
            ENDCASE

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ExecutarReportForm")
        ENDTRY

        SET POINT TO loc_cPonto
        SET SEPARATOR TO loc_cSeparador
        SET REPORTBEHAVIOR 90

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE