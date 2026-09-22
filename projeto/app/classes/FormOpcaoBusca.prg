*==============================================================================
* FORMOPCAOBUSCA.PRG
* Dialogo modal de modo de casamento da busca por texto (PROCURAR).
*
* Substitui o SigOpCtd do legado Fortyus, que NAO veio no acervo - nao esta em
* origem\, nem em tasks\, nem migrado. O CONTRATO dele, porem, esta inteiramente
* determinado pelos call sites do msv_procurar (SIGCDCTA_form_codigo_fonte.txt),
* que leem ThisForm.pnRetorno e montam o termo assim:
*
*     lcTmp = Iif(pnRetorno = 2 or pnRetorno = 3, '%', '') + Alltrim(valor) + ;
*             Iif(pnRetorno = 1 or pnRetorno = 3, '%', '')
*
*     lcQuery = [... Where Rtrim(<coluna>) ] + ;
*               Iif(pnRetorno = 4, [=], [Like]) + [ ] + termo + ...
*
* Donde os cinco retornos:
*
*     1 -> 'x%'   Inicia com   (o default: o Wait Window do legado diz
*                               "Procurando Contas INICIADAS Com a Descricao")
*     2 -> '%x'   Termina com
*     3 -> '%x%'  Contem
*     4 ->  =     Exato
*     0 ->        Cancelou - o legado nao executa consulta nenhuma
*
* O COMPORTAMENTO acima eh fiel. O visual eh o canonico do sistema novo, porque
* o original nao existe para copiar - divergencia deliberada e registrada.
*
* Uso (modal - regra #29: o Show() fica FORA de qualquer TRY):
*
*     loc_oDlg = CREATEOBJECT("FormOpcaoBusca", loc_cMensagem)
*     IF VARTYPE(loc_oDlg) = "O"
*         loc_oDlg.Show()
*         loc_nRetorno = loc_oDlg.this_nRetorno
*         loc_oDlg = .NULL.
*     ENDIF
*==============================================================================

DEFINE CLASS FormOpcaoBusca AS Form

    Height       = 208
    Width        = 400
    AutoCenter   = .T.
    BorderStyle  = 2
    Caption      = "Op" + CHR(231) + CHR(245) + "es de Procura"
    MaxButton    = .F.
    MinButton    = .F.
    ControlBox   = .F.
    ShowWindow   = 1
    WindowType   = 1          && modal: o Show() bloqueia ate o Release
    DataSession  = 1
    BackColor    = RGB(240, 240, 240)
    Themes       = .F.

    *-- 0 = cancelou. 1..4 conforme o contrato acima.
    this_nRetorno  = 0
    this_cMensagem = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cMensagem)
    *--------------------------------------------------------------------------
        IF TYPE("par_cMensagem") = "C" AND !EMPTY(par_cMensagem)
            THIS.this_cMensagem = ALLTRIM(par_cMensagem)
        ENDIF
        THIS.CriarControles()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CriarControles
    *--------------------------------------------------------------------------
        LOCAL loc_oOpt

        *-- Faixa de cabecalho, no padrao canonico do sistema novo
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 44
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Top       = 11
            .Left      = 12
            .Width     = THIS.Width - 24
            .Height    = 24
            .FontName  = "Tahoma"
            .FontSize  = 11
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(255, 255, 255)
            .Caption   = "Como procurar?"
            .Visible   = .T.
        ENDWITH

        *-- Mensagem de contexto: o legado passa
        *-- 'Procura No Grupo "<grupo>"' ou 'Procura Sem Grupo Definido'
        THIS.AddObject("lbl_4c_Mensagem", "Label")
        WITH THIS.lbl_4c_Mensagem
            .Top       = 54
            .Left      = 16
            .Width     = THIS.Width - 32
            .Height    = 16
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = THIS.this_cMensagem
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup: Value SEMPRE numerico, e o indice ja eh o pnRetorno
        *-- que os call sites do legado esperam (1..4), sem tabela de-para.
        THIS.AddObject("opt_4c_Modo", "OptionGroup")
        loc_oOpt = THIS.opt_4c_Modo
        loc_oOpt.ButtonCount = 4
        WITH loc_oOpt
            .Top         = 78
            .Left        = 20
            .Width       = 250
            .Height      = 82
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1          && Inicia com - o default do legado
            .Visible     = .T.
        ENDWITH

        WITH loc_oOpt.Buttons(1)
            .Caption   = "Inicia com"
            .Top       = 2
            .Left      = 0
            .Width     = 240
            .Height    = 18
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .F.
        ENDWITH
        WITH loc_oOpt.Buttons(2)
            .Caption   = "Termina com"
            .Top       = 22
            .Left      = 0
            .Width     = 240
            .Height    = 18
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .F.
        ENDWITH
        WITH loc_oOpt.Buttons(3)
            .Caption   = "Cont" + CHR(233) + "m"
            .Top       = 42
            .Left      = 0
            .Width     = 240
            .Height    = 18
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .F.
        ENDWITH
        WITH loc_oOpt.Buttons(4)
            .Caption   = "Exato"
            .Top       = 62
            .Left      = 0
            .Width     = 240
            .Height    = 18
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .F.
        ENDWITH

        *-- Botoes
        THIS.AddObject("cmd_4c_Ok", "CommandButton")
        WITH THIS.cmd_4c_Ok
            .Top      = 168
            .Left     = THIS.Width - 186
            .Width    = 85
            .Height   = 28
            .FontName = "Tahoma"
            .FontSize = 8
            .Caption  = "\<Procurar"
            .Default  = .T.
            .Visible  = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH THIS.cmd_4c_Cancelar
            .Top      = 168
            .Left     = THIS.Width - 95
            .Width    = 85
            .Height   = 28
            .FontName = "Tahoma"
            .FontSize = 8
            .Caption  = "\<Cancelar"
            .Cancel   = .T.
            .Visible  = .T.
        ENDWITH

        *-- Regra #3: handlers de BINDEVENT tem de ser PUBLIC (default em VFP9)
        BINDEVENT(THIS.cmd_4c_Ok,       "Click", THIS, "BtnOkClick")
        BINDEVENT(THIS.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnOkClick
    *--------------------------------------------------------------------------
        *-- OptionGroup.Value eh NUMERICO e ja vale 1..4
        THIS.this_nRetorno = IIF(VARTYPE(THIS.opt_4c_Modo.Value) = "N", ;
                                 THIS.opt_4c_Modo.Value, 1)
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick
    *--------------------------------------------------------------------------
        *-- 0 = o legado nao executa consulta nenhuma
        THIS.this_nRetorno = 0
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * QueryUnload - fechar pelo X/ESC equivale a cancelar
    *--------------------------------------------------------------------------
    PROCEDURE QueryUnload
        IF !INLIST(THIS.this_nRetorno, 1, 2, 3, 4)
            THIS.this_nRetorno = 0
        ENDIF
    ENDPROC

ENDDEFINE
