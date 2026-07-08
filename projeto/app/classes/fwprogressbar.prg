*==============================================================================
* FWPROGRESSBAR.PRG
* Barra de progresso portada do Framework legado.
* Interface esperada pelos forms/BOs migrados:
*   loBarra = CREATEOBJECT("fwprogressbar", cTitulo, nTotal)
*   loBarra.Show()
*   loBarra.Update(.T.)   && incrementa contador
*   loBarra.Complete(.T.) && finaliza
*   loBarra.Titulo.FontBold = .T.   && Label "Titulo" acessivel externamente
* Implementacao minima: janela pequena com progresso; se falhar a criacao,
* os chamadores continuam operando (nao bloqueia processamento).
*==============================================================================

DEFINE CLASS fwprogressbar AS Form

    Height      = 108
    Width       = 380
    AutoCenter  = .T.
    BorderStyle = 1
    Caption     = "Aguarde..."
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    ShowWindow  = 1
    WindowType  = 0
    TitleBar    = 1
    AlwaysOnTop = .T.

    this_nTotal = 0
    this_nAtual = 0

    ADD OBJECT Titulo AS Label WITH ;
        Top       = 8, ;
        Left      = 10, ;
        Width     = 360, ;
        Height    = 18, ;
        AutoSize  = .F., ;
        FontName  = "Tahoma", ;
        FontSize  = 9, ;
        FontBold  = .T., ;
        BackStyle = 0, ;
        Caption   = ""

    ADD OBJECT SubTitulo AS Label WITH ;
        Top       = 28, ;
        Left      = 10, ;
        Width     = 360, ;
        Height    = 14, ;
        AutoSize  = .F., ;
        FontName  = "Tahoma", ;
        FontSize  = 8, ;
        BackStyle = 0, ;
        Caption   = ""

    ADD OBJECT shpThermBg AS Shape WITH ;
        Top         = 48, ;
        Left        = 10, ;
        Width       = 360, ;
        Height      = 18, ;
        BorderColor = RGB(120, 120, 120), ;
        FillColor   = RGB(240, 240, 240), ;
        FillStyle   = 0

    ADD OBJECT shpThermBar AS Shape WITH ;
        Top         = 49, ;
        Left        = 11, ;
        Width       = 1, ;
        Height      = 16, ;
        BorderColor = RGB(0, 120, 215), ;
        FillColor   = RGB(0, 120, 215), ;
        FillStyle   = 0

    ADD OBJECT lblPercentage AS Label WITH ;
        Top       = 68, ;
        Left      = 10, ;
        Width     = 360, ;
        Height    = 14, ;
        AutoSize  = .F., ;
        Alignment = 2, ;
        FontName  = "Tahoma", ;
        FontSize  = 8, ;
        BackStyle = 0, ;
        Caption   = "0%"

    *-- Rodape: mensagens auxiliares (ex: "<ESC> para interromper...")
    ADD OBJECT Rodape AS Label WITH ;
        Top       = 86, ;
        Left      = 10, ;
        Width     = 360, ;
        Height    = 14, ;
        AutoSize  = .F., ;
        Alignment = 2, ;
        FontName  = "Tahoma", ;
        FontSize  = 8, ;
        BackStyle = 0, ;
        Caption   = ""

    PROCEDURE Init
        LPARAMETERS par_cTitulo, par_nTotal
        IF VARTYPE(par_cTitulo) = "C"
            THIS.Titulo.Caption = par_cTitulo
        ENDIF
        IF VARTYPE(par_nTotal) = "N" AND par_nTotal > 0
            THIS.this_nTotal = par_nTotal
        ELSE
            THIS.this_nTotal = 1
        ENDIF
        THIS.this_nAtual = 0
        RETURN .T.
    ENDPROC

    PROCEDURE Update
        LPARAMETERS par_lRefresh
        THIS.this_nAtual = THIS.this_nAtual + 1
        IF THIS.this_nAtual > THIS.this_nTotal
            THIS.this_nAtual = THIS.this_nTotal
        ENDIF
        LOCAL loc_nPct
        loc_nPct = IIF(THIS.this_nTotal > 0, ;
            INT((THIS.this_nAtual / THIS.this_nTotal) * 100), 100)
        THIS.shpThermBar.Width = MAX(1, INT((loc_nPct / 100.0) * 358))
        THIS.lblPercentage.Caption = TRANSFORM(loc_nPct) + "%"
        IF par_lRefresh
            THIS.Refresh
        ENDIF
    ENDPROC

    PROCEDURE Complete
        LPARAMETERS par_lRefresh
        THIS.this_nAtual = THIS.this_nTotal
        THIS.shpThermBar.Width = 358
        THIS.lblPercentage.Caption = "100%"
        IF par_lRefresh
            THIS.Refresh
        ENDIF
        THIS.Hide()
    ENDPROC

ENDDEFINE
