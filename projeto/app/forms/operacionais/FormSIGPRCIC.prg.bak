*==============================================================================
* FormSIGPRCIC.prg - Form OPERACIONAL: dialogo modal de escolha de icone
* Migrado de: SIGPRCIC.SCX
* Herda de: FormBase
*
* Pilares:
*   UX   -> layout identico ao legado (469x496, sem TitleBar/ControlBox,
*           cabecalho cinza com titulo duplicado sombra/branco)
*   BD   -> SigSyIco (catalogo de icones) via SIGPRCICBO, somente leitura
*   CODE -> FormBase + SIGPRCICBO (flat OPERACIONAL, sem PageFrame CRUD)
*
* Contexto: dialogo aberto por outro form (par_oFormPai, tipicamente FormICN)
* para o usuario escolher um icone do catalogo SigSyIco e aplica-lo ao
* registro de programa identificado por par_cPkChaves nos cursores do
* CHAMADOR (cursor_4c_Prog/cursor_4c_ProgFiltrado). Por isso este form
* assume o MESMO DataSessionId do chamador (THIS.DataSessionId =
* par_oFormPai.DataSessionId) - sem isso nao enxergaria os cursores do
* form pai, que vivem na data session PRIVADA dele.
*
* Estrutura original (SIGPRCIC.SCX): cntSombra (cabecalho) + Grid1 (lista de
* icones) + Shape1/Icone (preview) + Say2/Text1 (descricao do programa).
* Fase 3/8 entrega so a "casca": Init/InicializarForm + cabecalho. Grid1
* (Fase 4), Shape1/Icone/Say2/Text1 (Fase 5) e os eventos (Fases 6-8) sao
* adicionados nas fases seguintes.
*==============================================================================
DEFINE CLASS FormSIGPRCIC AS FormBase

    *-- Layout legado: dialogo modal 469x496, sem TitleBar/ControlBox/MaxButton
    Width        = 469
    Height       = 496
    AutoCenter   = .T.
    BorderStyle  = 2
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .F.
    TitleBar     = 0
    ShowWindow   = 0
    WindowType   = 0

    *-- Referencia ao form chamador e chave do registro escolhido nele
    *-- (espelham poForm1/pcIdChaves do legado)
    this_oFormPai  = .NULL.
    this_cPkChaves = ""

    *==========================================================================
    PROCEDURE Init(par_oFormPai, par_cPkChaves)
    *==========================================================================
        THIS.this_oFormPai    = IIF(VARTYPE(par_oFormPai) = "O", par_oFormPai, THIS)
        THIS.this_cPkChaves   = IIF(VARTYPE(par_cPkChaves) = "C", par_cPkChaves, "")
        THIS.this_cTituloForm = "Escolha de " + CHR(237) + "cones"

        *-- Compartilha a data session do form chamador (legado: .DataSessionId
        *-- = .poForm1.DataSessionId) - sem isso este dialogo nao enxerga os
        *-- cursores de programas que vivem na sessao PRIVADA do chamador.
        THIS.DataSessionId = THIS.this_oFormPai.DataSessionId

        *-- WindowType=1 (modal) bloqueia Show() ate o usuario fechar o dialogo.
        *-- Em teste/validacao de UI mantem 0 para nao travar o pipeline;
        *-- em producao restaura o modal aqui (mesmo padrao de FormICN).
        IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
             (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
            THIS.WindowType = 1
            THIS.ShowWindow = 1
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            THIS.this_oBusinessObject = CREATEOBJECT("SIGPRCICBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar SIGPRCICBO." + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                        "Erro em FormSIGPRCIC.InicializarForm")
            ELSE
                THIS.this_oBusinessObject.this_oFormPai  = THIS.this_oFormPai
                THIS.this_oBusinessObject.this_cPkChaves = THIS.this_cPkChaves

                *-- Compor layout (flat OPERACIONAL, sem PageFrame CRUD)
                THIS.ConfigurarPageFrame()

                *-- Ecoar Caption nas labels do cabecalho (apos ConfigurarPageFrame)
                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

                *-- Tornar controles visiveis (AddObject cria com Visible=.F.)
                THIS.TornarControlesVisiveis()

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSIGPRCIC.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
    *==========================================================================
    * OPERACIONAL flat - o legado SIGPRCIC nao usa PageFrame; os controles
    * (Grid1/Shape1/Icone/Say2/Text1) ficam diretamente sobre o Form. Este
    * metodo orquestra a composicao das regioes do dialogo. Por ora so o
    * cabecalho (cntSombra); a Fase 4 acrescenta a lista de icones (Grid1) e
    * a Fase 5 acrescenta os campos de preview (Shape1/Icone/Say2/Text1).
    * Nome preservado por compatibilidade com o pipeline de migracao.
    *==========================================================================
        THIS.ConfigurarCabecalho()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
    *==========================================================================
    * Cria cnt_4c_Sombra com lbl_4c_LblSombra (sombra preta) e lbl_4c_LblTitulo
    * (texto branco) - replica cntSombra/lblSombra/lblTitulo do legado
    * (SIGPRCIC.SCX), com o titulo definido em runtime a partir de THIS.Caption
    * (mesmo padrao do legado: ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption).
    *==========================================================================
        LOCAL loc_oCab, loc_oErro
        TRY
            THIS.AddObject("cnt_4c_Sombra", "Container")
            loc_oCab = THIS.cnt_4c_Sombra
            WITH loc_oCab
                .Top         = 0
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BackStyle   = 1
                .BackColor   = RGB(100, 100, 100)
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

            loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
            WITH loc_oCab.lbl_4c_LblSombra
                .AutoSize  = .F.
                .Top       = 18
                .Left      = 10
                .Width     = loc_oCab.Width - 20
                .Height    = 40
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Caption   = ""
                .Visible   = .T.
            ENDWITH

            loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
            WITH loc_oCab.lbl_4c_LblTitulo
                .AutoSize    = .F.
                .Top         = 17
                .Left        = 10
                .Width       = loc_oCab.Width - 20
                .Height      = 46
                .FontBold    = .T.
                .FontName    = "Tahoma"
                .FontSize    = 18
                .WordWrap    = .T.
                .Alignment   = 0
                .BackStyle   = 0
                .ForeColor   = RGB(255, 255, 255)
                .Caption     = ""
                .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
                .Visible     = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSIGPRCIC.ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE TornarControlesVisiveis(par_oContainer)
    *==========================================================================
    * Torna visiveis todos os controles recursivamente (AddObject cria com
    * Visible = .F.). Sem filtro de containers ocultos - este form nao usa
    * containers flutuantes.
    *==========================================================================
        LOCAL loc_nI, loc_oControl, loc_nP
        IF VARTYPE(par_oContainer) != "O"
            par_oContainer = THIS
        ENDIF
        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oControl.PageCount
                        THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
                    ENDFOR
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
                   loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSIGPRCIC.Destroy")
        ENDTRY
        DODEFAULT()
    ENDPROC

ENDDEFINE
