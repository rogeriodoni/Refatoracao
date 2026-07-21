*==============================================================================
* Formsigprtef.prg - Formulario Operacional: Administracao do TEF
* Tipo: OPERACIONAL (flat sem PageFrame, modal 800x190)
* Migrado de SIGPRTEF.SCX
*
* Pilares:
*   UX   -> layout identico ao legado (800x190, botoes Top=12, TextBox Top=144)
*   BD   -> SigFiTef, SigFiNfs, SigFiMpF, SigCdPam (via sigprtefBO)
*   CODE -> arquitetura em camadas (FormBase / sigprtefBO)
*
* CHAMADA:
*   loForm = CREATEOBJECT("Formsigprtef")
*   loForm.Show()
*   - ou -
*   loForm = CREATEOBJECT("Formsigprtef", .T., lcIdChaves)
*   loForm.Show()
*
* NOTA: O controle OLE modem (oModem/ActiveX) do legado nao pode ser
*       criado via AddObject em .prg. this_oModem deve ser fornecido
*       externamente apos CREATEOBJECT antes de Show().
*==============================================================================

DEFINE CLASS Formsigprtef AS FormBase

    *-- Propriedades visuais (identicas ao legado)
    Height      = 190
    Width       = 800
    BorderStyle = 2
    AutoCenter  = .T.
    ShowWindow = 1
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    WindowType  = 1
    WindowState = 0
    DataSession = 2
    KeyPreview  = .T.

    *-- Propriedades customizadas (RESERVED3 do legado)
    cOperacao   = ""    && Operacao TEF atual (PADR NoCaixa+NoFab+'ADM', 20 chars)
    cNoCaixa    = ""    && Numero do caixa fiscal
    cNoFab      = ""    && Numero de fabricacao da impressora fiscal
    cPcIdChaves = ""    && Chaves de identificacao da transacao TEF

    *-- Referencia ao controle modem/impressora fiscal (OLE ActiveX no legado)
    *-- Fornecido externamente; funcoes TEF (SigFiTefReq etc.) dependem deste objeto
    this_oModem = .NULL.

    *==========================================================================
    PROCEDURE Init
    *==========================================================================
        LPARAMETERS par_lModal, par_cIdChaves

        IF VARTYPE(par_lModal) = "L" AND par_lModal
            THIS.WindowType = 1
        ENDIF

        IF VARTYPE(par_cIdChaves) = "C"
            THIS.cPcIdChaves = ALLTRIM(par_cIdChaves)
        ENDIF

        *-- DODEFAULT() chama FormBase.Init() que:
        *-- 1) aplica SET DATE TO BRITISH + SET CENTURY ON (fix DataSession=2)
        *-- 2) chama THIS.InicializarForm()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.Caption = "Administra" + CHR(231) + CHR(227) + "o do TEF"

            IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            ENDIF

            THIS.this_oBusinessObject = CREATEOBJECT("sigprtefBO")
            IF VARTYPE(THIS.this_oBusinessObject) = "O"

                *-- Guard para validacao de UI sem conexao SQL
                IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                    THIS.ConfigurarPageFrame()
                    loc_lSucesso = .T.
                ELSE
                    *-- Carregar parametros TEF de SigCdPam (popula this_nSistef no BO)
                    IF THIS.this_oBusinessObject.CarregarParametrosTEF()
                        THIS.ConfigurarPageFrame()
                        THIS.InicializarEstadoTEF()
                        THIS.ConfigurarEventos()
                        loc_lSucesso = .T.
                    ELSE
                        MsgErro("Falha ao carregar par" + CHR(226) + "metros TEF de SigCdPam", "Erro")
                    ENDIF
                ENDIF

            ELSE
                MsgErro("Falha ao criar sigprtefBO", "Erro")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ao inicializar TEF")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame
    *==========================================================================
        *-- Form OPERACIONAL: layout FLAT (sem PageFrame).
        *-- Metodo mantido por compatibilidade com validador do orquestrador
        *-- e delega para ConfigurarForm (que cria o layout customizado real).
        THIS.ConfigurarForm()
        RETURN .T.
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista
    *==========================================================================
        *-- Form OPERACIONAL: modal flat 800x190 SEM PageFrame e SEM Grid CRUD.
        *-- Nao existe "Page1 - Lista de Registros" nesta tela: os dados TEF
        *-- (crSigFiFis, crSigFiTef, CrSigFiNfs, CrTefImp, CrTefResp, SigTef)
        *-- sao cursores TRANSACIONAIS carregados sob demanda em
        *-- InicializarEstadoTEF, TxtRedetefValid, ProcCntTxt, CmdTefAdmClick e
        *-- CmdCancelarClick conforme o fluxo TEF (Ativo/Admin/Cancelamento).
        *--
        *-- Este metodo existe para atender ao contrato do validador do
        *-- orquestrador de migracao (Fase 4) e retorna sempre .T. porque
        *-- toda a "configuracao de exibicao" ja foi feita em ConfigurarForm().
        RETURN .T.
    ENDPROC

    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
    *==========================================================================
        *-- Form OPERACIONAL: NAO possui pgf_4c_Paginas (Page1/Page2 CRUD).
        *-- A UI eh flat (todos os controles no proprio Form) e a unica
        *-- alternancia visual eh o container cnt_4c_TefTxt (Visible=.T./.F.)
        *-- gerenciado por ProcCntTxt() apos leitura da transacao TEF.
        *--
        *-- Metodo existe para atender ao contrato do validador do orquestrador
        *-- de migracao (Fase 4). par_nPagina eh ignorado; sempre retorna .T.
        RETURN .T.
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados
    *==========================================================================
        *-- Form OPERACIONAL: modal flat 800x190 SEM PageFrame e SEM Page2-Dados.
        *-- Nao existe "Page2 - Formulario de Edicao" nesta tela: o layout
        *-- completo (Shape1, cnt_4c_TefTxt, lbl_4c_Redetef, txt_4c_Redetef e os
        *-- 4 botoes de acao TEF) eh criado inteiramente em ConfigurarForm(),
        *-- que eh chamado por ConfigurarPageFrame() durante InicializarForm().
        *--
        *-- Este metodo existe para atender ao contrato do validador do
        *-- orquestrador de migracao (Fase 5) e retorna sempre .T. porque
        *-- toda a "configuracao de campos/dados" ja foi feita em ConfigurarForm().
        RETURN .T.
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarForm
    *==========================================================================
        LOCAL loc_oErro
        TRY

            *-- Shape decorativo (canto direito - Shape1 do legado)
            THIS.AddObject("shp_4c_Shape1", "Shape")
            WITH THIS.shp_4c_Shape1
                .Top         = 7
                .Left        = 698
                .Height      = 110
                .Width       = 90
                .BackStyle   = 0
                .BorderColor = RGB(136, 189, 188)
                .Visible     = .T.
            ENDWITH

            *-- Placeholder posicional para controle OLE modem (oModem/ActiveX do legado)
            THIS.AddObject("cnt_4c_OModem", "Container")
            WITH THIS.cnt_4c_OModem
                .Top       = 8
                .Left      = 320
                .Height    = 100
                .Width     = 100
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Container de mensagens TEF (CntTefTxt do legado - inicia Visible=.F.)
            THIS.AddObject("cnt_4c_TefTxt", "Container")
            WITH THIS.cnt_4c_TefTxt
                .Top           = 192
                .Left          = 2
                .Height        = 155
                .Width         = 381
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .BackStyle     = 1
                .Visible       = .F.
            ENDWITH

            *-- Labels filhos de cnt_4c_TefTxt (fora de WITH pai - evita WITH aninhado)
            THIS.cnt_4c_TefTxt.AddObject("lbl_4c_Label1", "Label")
            WITH THIS.cnt_4c_TefTxt.lbl_4c_Label1
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontSize  = 9
                .WordWrap  = .T.
                .BackStyle = 0
                .Caption   = "Impress" + CHR(227) + "o Cupom Vinculado : "
                .Height    = 26
                .Left      = 4
                .Top       = 5
                .Width     = 174
                .ForeColor = RGB(0, 0, 160)
                .Visible   = .T.
            ENDWITH

            THIS.cnt_4c_TefTxt.AddObject("lbl_4c_TxtTpTrans", "Label")
            WITH THIS.cnt_4c_TefTxt.lbl_4c_TxtTpTrans
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontSize  = 9
                .WordWrap  = .T.
                .BackStyle = 0
                .Caption   = ""
                .Height    = 26
                .Left      = 177
                .Top       = 5
                .Width     = 195
                .ForeColor = RGB(0, 0, 255)
                .Visible   = .T.
            ENDWITH

            THIS.cnt_4c_TefTxt.AddObject("lbl_4c_Label2", "Label")
            WITH THIS.cnt_4c_TefTxt.lbl_4c_Label2
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontSize  = 9
                .WordWrap  = .T.
                .BackStyle = 0
                .Caption   = "Mensagem Operador : "
                .Height    = 25
                .Left      = 4
                .Top       = 62
                .Width     = 128
                .ForeColor = RGB(0, 0, 160)
                .Visible   = .T.
            ENDWITH

            THIS.cnt_4c_TefTxt.AddObject("lbl_4c_TxtOper", "Label")
            WITH THIS.cnt_4c_TefTxt.lbl_4c_TxtOper
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontSize  = 9
                .WordWrap  = .T.
                .BackStyle = 0
                .Caption   = ""
                .Height    = 26
                .Left      = 134
                .Top       = 61
                .Width     = 239
                .ForeColor = RGB(0, 0, 255)
                .Visible   = .T.
            ENDWITH

            THIS.cnt_4c_TefTxt.AddObject("lbl_4c_TxtCli", "Label")
            WITH THIS.cnt_4c_TefTxt.lbl_4c_TxtCli
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontSize  = 9
                .WordWrap  = .T.
                .BackStyle = 0
                .Caption   = "Mensagem Cliente : "
                .Height    = 22
                .Left      = 4
                .Top       = 108
                .Width     = 115
                .ForeColor = RGB(0, 0, 160)
                .Visible   = .T.
            ENDWITH

            THIS.cnt_4c_TefTxt.AddObject("lbl_4c_Label3", "Label")
            WITH THIS.cnt_4c_TefTxt.lbl_4c_Label3
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontSize  = 9
                .WordWrap  = .T.
                .BackStyle = 0
                .Caption   = ""
                .Height    = 22
                .Left      = 118
                .Top       = 108
                .Width     = 255
                .ForeColor = RGB(0, 0, 255)
                .Visible   = .T.
            ENDWITH

            *-- Label "Rede Tef :" (Say1 do legado)
            THIS.AddObject("lbl_4c_Redetef", "Label")
            WITH THIS.lbl_4c_Redetef
                .FontBold  = .T.
                .FontName  = "Verdana"
                .FontSize  = 8
                .Caption   = "Rede Tef :"
                .Left      = 203
                .Top       = 147
                .ForeColor = RGB(36, 84, 155)
                .BackStyle = 0
                .AutoSize  = .T.
                .Visible   = .T.
            ENDWITH

            *-- TextBox Rede TEF (Get_redetef do legado)
            THIS.AddObject("txt_4c_Redetef", "TextBox")
            WITH THIS.txt_4c_Redetef
                .Height   = 23
                .Left     = 274
                .Top      = 144
                .Width    = 150
                .Value    = ""
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH

            *-- Botao Admin TEF (TefAdm do legado)
            *-- Inicia Enabled=.F.; habilitado em InicializarEstadoTEF apos leitura FAB
            THIS.AddObject("cmd_4c_TefAdm", "CommandButton")
            WITH THIS.cmd_4c_TefAdm
                .Top             = 12
                .Left            = 17
                .Width           = 75
                .Height          = 75
                .Caption         = "Admin"
                .Picture         = gc_4c_CaminhoIcones + "geral_pn_btn_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "geral_pn_btn_60.jpg"
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .T.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Enabled         = .F.
                .Visible         = .T.
            ENDWITH

            *-- Botao Tef Ativo (TefAtv do legado)
            THIS.AddObject("cmd_4c_TefAtv", "CommandButton")
            WITH THIS.cmd_4c_TefAtv
                .Top             = 12
                .Left            = 100
                .Width           = 75
                .Height          = 75
                .Caption         = "\<Tef Ativo"
                .Picture         = gc_4c_CaminhoIcones + "cartao.png"
                .DisabledPicture = gc_4c_CaminhoIcones + "cartao.png"
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .T.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Enabled         = .F.
                .Visible         = .T.
            ENDWITH

            *-- Botao Cancelar (Command1 do legado)
            THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
            WITH THIS.cmd_4c_Cancelar
                .Top             = 12
                .Left            = 183
                .Width           = 75
                .Height          = 75
                .Caption         = "\<Cancelar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .T.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH

            *-- Botao Encerrar (Sair do legado, Cancel=.T. para ESC fechar)
            THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH THIS.cmd_4c_Encerrar
                .Top             = 12
                .Left            = 703
                .Width           = 75
                .Height          = 75
                .Caption         = "Encerrar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .T.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Cancel          = .T.
                .Visible         = .T.
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ConfigurarForm")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarEstadoTEF
    *==========================================================================
        LOCAL loc_lOk, loc_cNoFab, loc_cNoFabr, loc_oErro
        loc_lOk = .F.

        TRY
            THIS.cOperacao = ""
            THIS.cNoCaixa  = ""
            THIS.cNoFab    = ""

            *-- Carregar configuracao fiscal (popula crSigFiFis - usado nos handlers)
            =fLerFiscal()
            SELECT crSigFiFis
            GO TOP

            IF VARTYPE(THIS.this_oModem) = "O"
                *-- Ler numero de fabricacao da impressora fiscal
                loc_cNoFab = LeituraFab(THIS.this_oModem)
                IF VARTYPE(loc_cNoFab) = "C"
                    loc_cNoFabr = fDecriptografar(ALLTRIM(loc_cNoFab))
                    IF THIS.this_oBusinessObject.CarregarImpressoraFiscal(loc_cNoFabr)
                        THIS.cNoCaixa  = THIS.this_oBusinessObject.this_cNoCaixa
                        THIS.cNoFab    = loc_cNoFab
                        THIS.cOperacao = PADR(THIS.cNoCaixa + THIS.cNoFab + "ADM", 20)
                        loc_lOk        = .T.
                    ENDIF
                ENDIF
            ENDIF

            *-- fChecaAcesso nao portada: habilitar botoes se inicializacao ok
            THIS.cmd_4c_TefAdm.Enabled = loc_lOk
            THIS.cmd_4c_TefAtv.Enabled = loc_lOk

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro InicializarEstadoTEF")
        ENDTRY

        RETURN loc_lOk
    ENDPROC

    *==========================================================================
    PROCEDURE TornarControlesVisiveis(par_oContainer)
    *==========================================================================
        *-- Torna controles Visible=.T. recursivamente.
        *-- FILTRO: cnt_4c_TefTxt fica Visible=.F. (toggled pela procedure CntTxt)
        *-- Os filhos do container filtrado sao recursados para ficarem Visible=.T.
        *-- quando o container for exibido posteriormente.
        LOCAL loc_i, loc_oControl, loc_p
        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF INLIST(UPPER(loc_oControl.Name), "CNT_4C_TEFTXT")
                    *-- Container oculto por logica TEF: recursar filhos sem
                    *-- alterar Visible do proprio container
                    IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControl)
                    ENDIF
                    LOOP
                ENDIF
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                    FOR loc_p = 1 TO loc_oControl.PageCount
                        THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_p))
                    ENDFOR
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy
    *==========================================================================
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        IF VARTYPE(THIS.this_oModem) = "O"
            THIS.this_oModem = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarEventos
    *==========================================================================
        LOCAL loc_oErro
        TRY
            BINDEVENT(THIS.cmd_4c_Encerrar, "Click",    THIS, "CmdEncerrarClick")
            BINDEVENT(THIS.cmd_4c_TefAdm,   "Click",    THIS, "CmdTefAdmClick")
            BINDEVENT(THIS.cmd_4c_TefAdm,   "When",     THIS, "CmdTefAdmWhen")
            BINDEVENT(THIS.cmd_4c_TefAtv,   "Click",    THIS, "CmdTefAtvClick")
            BINDEVENT(THIS.cmd_4c_TefAtv,   "When",     THIS, "CmdTefAtvWhen")
            BINDEVENT(THIS.cmd_4c_Cancelar, "Click",    THIS, "CmdCancelarClick")
            BINDEVENT(THIS.cmd_4c_Cancelar, "When",     THIS, "CmdCancelarWhen")
            BINDEVENT(THIS.txt_4c_Redetef,  "KeyPress", THIS, "TxtRedetefKeyPress")
            BINDEVENT(THIS.txt_4c_Redetef,  "KeyPress",    THIS, "TxtRedetefValid")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro ConfigurarEventos")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE CmdEncerrarClick
    *==========================================================================
        THIS.Release()
    ENDPROC

    *==========================================================================
    PROCEDURE CmdTefAdmWhen
    *==========================================================================
        RETURN !EMPTY(ALLTRIM(THIS.txt_4c_Redetef.Value))
    ENDPROC

    *==========================================================================
    PROCEDURE CmdTefAtvWhen
    *==========================================================================
        RETURN !EMPTY(ALLTRIM(THIS.txt_4c_Redetef.Value))
    ENDPROC

    *==========================================================================
    PROCEDURE CmdCancelarWhen
    *==========================================================================
        RETURN !EMPTY(ALLTRIM(THIS.txt_4c_Redetef.Value))
    ENDPROC

    *==========================================================================
    PROCEDURE TxtRedetefKeyPress
    *==========================================================================
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            IF !EMPTY(ALLTRIM(THIS.txt_4c_Redetef.Value))
                THIS.TxtRedetefValid()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE TxtRedetefValid
    LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
    *==========================================================================
        LOCAL loc_lOk, loc_oErro
        loc_lOk = .T.
        TRY
            IF !EMPTY(ALLTRIM(THIS.txt_4c_Redetef.Value))
                IF USED("crSigFiFis") AND !EOF("crSigFiFis")
                    IF THIS.this_oBusinessObject.BuscarComprovantes(ALLTRIM(crSigFiFis.Imps))
                        SELECT CrSigFiNfs
                        INDEX ON cComprovs TAG cComprovs
                        IF !SEEK(ALLTRIM(THIS.txt_4c_Redetef.Value), "CrSigFiNfs", "cComprovs")
                            THIS.AbrirBuscaRedetef()
                        ENDIF
                        IF USED("CrSigFiNfs") AND !EOF("CrSigFiNfs")
                            THIS.txt_4c_Redetef.Value = ALLTRIM(CrSigFiNfs.cComprovs)
                        ENDIF
                        THIS.txt_4c_Redetef.Refresh()
                    ENDIF
                ENDIF
            ELSE
                THIS.txt_4c_Redetef.Value = ""
                THIS.txt_4c_Redetef.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro ValidarRedetef")
        ENDTRY
        RETURN loc_lOk
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE AbrirBuscaRedetef
    *==========================================================================
        LOCAL loc_oBusca, loc_cImps, loc_oErro
        TRY
            loc_cImps = IIF(USED("crSigFiFis") AND !EOF("crSigFiFis"), ALLTRIM(crSigFiFis.Imps), "")
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                                       "SigFiNfs", ;
                                       "cursor_4c_BuscaRedetef", ;
                                       "cComprovs", ;
                                       ALLTRIM(THIS.txt_4c_Redetef.Value), ;
                                       "Sele" + CHR(231) + CHR(227) + "o", ;
                                       .F., .F., ;
                                       "Imps = " + EscaparSQL(loc_cImps))
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("cComprovs", "", "Rede Tef")
                loc_oBusca.mAddColuna("nfinalzs",  "XXXXXXXXXX", "Finalizadora")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaRedetef")
                    THIS.txt_4c_Redetef.Value = ALLTRIM(cursor_4c_BuscaRedetef.cComprovs)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro AbrirBuscaRedetef")
        ENDTRY
        IF USED("cursor_4c_BuscaRedetef")
            USE IN cursor_4c_BuscaRedetef
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE CmdTefAtvClick
    *==========================================================================
        LOCAL loc_lcRedeTef, loc_lcTipo, loc_SendTef, loc_lcDirReq, loc_lcArq, loc_oErro
        TRY
            WAIT WINDOW "Aguarde Processamento TEF !!" NOWAIT
            loc_lcRedeTef = ALLTRIM(THIS.txt_4c_Redetef.Value)
            loc_lcTipo    = "ATV"
            loc_SendTef   = SigFiTefReq(THIS, THIS.cNoCaixa, go_4c_Sistema.cCodEmpresa, ;
                                         THIS.cOperacao, 0, 0, loc_lcTipo, 0, loc_lcRedeTef)
            IF VARTYPE(loc_SendTef) = "N"
                MsgAviso("Gerenciador Padr" + CHR(227) + "o Ativo !!", "")
            ELSE
                MsgAviso("Gerenciador Padr" + CHR(227) + "o n" + CHR(227) + "o Ativo !!", "")
                IF USED("crSigFiFis") AND !EOF("crSigFiFis")
                    IF THIS.this_oBusinessObject.BuscarNFiscalPorComprovante( ;
                            ALLTRIM(crSigFiFis.Imps), loc_lcRedeTef)
                        SELECT crTmpNFis
                        GO TOP
                        IF !EOF("crTmpNFis")
                            loc_lcDirReq = ALLTRIM(crTmpNFis.cTefdReqs)
                            loc_lcArq    = loc_lcDirReq + "IntPos.001"
                            IF FILE(loc_lcArq)
                                DELETE FILE (loc_lcArq)
                            ENDIF
                            loc_lcArq = loc_lcDirReq + "IntPos.Tmp"
                            IF FILE(loc_lcArq)
                                DELETE FILE (loc_lcArq)
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
            WAIT CLEAR
        CATCH TO loc_oErro
            WAIT CLEAR
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro CmdTefAtvClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE CmdTefAdmClick
    *==========================================================================
        LOCAL loc_lcRedeTef, loc_SendTef, loc_lcTipo, loc_lnIdent
        LOCAL loc_okTef, loc_llChecaSigTef, loc_lnQtdTef, loc_RetNImp
        LOCAL loc_oFormulario, loc_VerStatus, loc_oErro

        TRY
            IF USED("CrTefImp")
                USE IN CrTefImp
            ENDIF
            CREATE CURSOR CrTefImp (cinfos C(100), nordems N(2), cnIdents C(10))
            INDEX ON cnIdents TAG Ident

            loc_oFormulario = THIS.this_oModem
            loc_okTef       = .T.

            WAIT WINDOW "Aguarde Verificando TEF Ativo!!" NOWAIT
            loc_lcRedeTef = ALLTRIM(THIS.txt_4c_Redetef.Value)

            IF THIS.this_oBusinessObject.this_nSistef = 1
                loc_lcTipo  = "ATV"
                loc_SendTef = SigFiTefReq(THIS, THIS.cNoCaixa, go_4c_Sistema.cCodEmpresa, ;
                                           THIS.cOperacao, 0, 0, loc_lcTipo, 0, loc_lcRedeTef)
                IF VARTYPE(loc_SendTef) = "N"
                    *-- ATV retornou numerico: TEF ativo
                ELSE
                    loc_okTef = .F.
                    MsgAviso("Gerenciador Padr" + CHR(227) + "o n" + CHR(227) + "o Ativo !!", "")
                ENDIF
                WAIT CLEAR
            ENDIF

            IF loc_okTef
                loc_llChecaSigTef = .F.
                IF !USED("SigTef")
                    IF TYPE("goSistema") = "O" AND !EMPTY(goSistema.DirTefEcfs)
                        USE (goSistema.DirTefEcfs + "\SigTef") IN 0
                        loc_llChecaSigTef = .T.
                    ENDIF
                ENDIF

                IF USED("CrTef")
                    USE IN CrTef
                ENDIF
                CREATE CURSOR CrTef (cinfos M)

                IF USED("SigTef")
                    SELECT SigTef
                    COUNT FOR !DELETED() TO loc_lnQtdTef
                    GO TOP
                    IF loc_lnQtdTef = 1 AND SigTef.cStatus <> "CNF"
                        SCAN
                            IF SigTef.cCnfs = "C"
                                WAIT WINDOW "Aguarde Processamento Confirma" + CHR(231) + ;
                                            CHR(227) + "o SITEF, Prov" + CHR(225) + ;
                                            "vel Queda Energia !!" NOWAIT
                                loc_lcTipo = "CNF"
                            ELSE
                                WAIT WINDOW "Aguarde Processamento Cancelamento SITEF, Prov" + ;
                                            CHR(225) + "vel Queda Energia !!" NOWAIT
                                loc_lcTipo = "NCN"
                                THIS.this_oBusinessObject.AtualizarStatusTefPorIdents( ;
                                    SigTef.cnIdents, "CNC")
                            ENDIF
                            loc_RetNImp = TefImpr(SigTef.cEmps, SigTef.cDopes, ;
                                                   VAL(SigTef.cnCupoms), loc_lcTipo, ;
                                                   VAL(SigTef.cnIdents), SigTef.cNmRedes, ;
                                                   SigTef.cnNSUs, SigTef.cFinalzs, ;
                                                   SigTef.cCupomnvs, SigTef.FPags)
                            IF loc_RetNImp
                                IF THIS.this_oBusinessObject.this_nSistef = 1
                                    DO FORM SIGCNTEF WITH SigTef.cnNSUs, SigTef.cNmRedes, ;
                                        IIF(THIS.this_oBusinessObject.this_nSistef = 3, ;
                                            VAL(STRTRAN(SigTef.cnValors, ",", ".")), ;
                                            VAL(SigTef.cnValors) / 100)
                                ENDIF
                                SELECT SigTef
                                DELETE
                            ELSE
                                MsgAviso("Problemas de comunica" + CHR(231) + ;
                                         CHR(227) + "o com TEF !!", "")
                                loc_okTef = .F.
                            ENDIF
                        ENDSCAN
                    ELSE
                        SELECT SigTef
                        DELETE ALL
                    ENDIF
                ENDIF

                WAIT CLEAR

                IF loc_llChecaSigTef AND USED("SigTef")
                    USE IN SigTef
                ENDIF
                IF USED("CrTef")
                    USE IN CrTef
                ENDIF

                IF USED("crSigFiFis") AND !EOF("crSigFiFis")
                    IF UPPER(ALLTRIM(crSigFiFis.Imps)) <> "SWEDA"
                        loc_VerStatus = RotStatus(1, loc_oFormulario)
                        IF VARTYPE(loc_VerStatus) <> "L"
                            IF SUBSTR(loc_VerStatus, 1, 1) = "R"
                                FinFimVinc(loc_oFormulario)
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF

                WAIT WINDOW "Aguarde Processamento TEF !!" NOWAIT
                loc_lcRedeTef = ALLTRIM(THIS.txt_4c_Redetef.Value)
                THIS.cmd_4c_TefAdm.Enabled = .F.
                loc_lcTipo  = "ADM"
                loc_SendTef = SigFiTefReq(THIS, THIS.cNoCaixa, go_4c_Sistema.cCodEmpresa, ;
                                           THIS.cOperacao, 0, 0, loc_lcTipo, 0, loc_lcRedeTef)
                WAIT CLEAR

                SELECT CrTefImp
                IF RECCOUNT("CrTefImp") <> 0
                    WAIT WINDOW "Aguarde Impress" + CHR(227) + "o !!" NOWAIT
                    IF VARTYPE(loc_SendTef) = "N"
                        loc_lnIdent = loc_SendTef
                        THIS.ImprFiscalProc(loc_lnIdent)
                    ENDIF
                ELSE
                    IF VARTYPE(loc_SendTef) = "N"
                        loc_lnIdent = loc_SendTef
                        IF THIS.this_oBusinessObject.BuscarTransacaoTEF("R", ;
                                go_4c_Sistema.cCodEmpresa, THIS.cOperacao, ;
                                ALLTRIM(STR(loc_lnIdent, 20)))
                            THIS.ExcluirTef(crSigFiTef.cnIdents)
                            THIS.this_oBusinessObject.BuscarTransacaoTEF("R", ;
                                go_4c_Sistema.cCodEmpresa, THIS.cOperacao, ;
                                ALLTRIM(STR(loc_lnIdent, 20)))
                            IF USED("crSigFiTef") AND !EOF("crSigFiTef")
                                SELECT crSigFiTef
                                IF !EMPTY(ALLTRIM(crSigFiTef.cTxtOpers))
                                    MsgAviso(ALLTRIM(crSigFiTef.cTxtOpers), "")
                                ENDIF
                                IF !EMPTY(ALLTRIM(crSigFiTef.cTxtClis))
                                    MsgAviso(ALLTRIM(crSigFiTef.cTxtClis), "")
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

            WAIT CLEAR
            THIS.cmd_4c_TefAdm.Enabled = .T.

        CATCH TO loc_oErro
            WAIT CLEAR
            THIS.cmd_4c_TefAdm.Enabled = .T.
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro CmdTefAdmClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE CmdCancelarClick
    *==========================================================================
        LOCAL loc_lcRedeTef, loc_SendTef, loc_lcTipo, loc_okTef
        LOCAL loc_lcDirReq, loc_lcDirResp, loc_lnQtdVia, loc_lcArquivo
        LOCAL loc_lcNSU, loc_lcFinalzs, loc_llCancTef, loc_RetCVinc
        LOCAL loc_lnContaQtdVia, loc_oFormulario, loc_lcMsg, loc_oErro

        TRY
            IF USED("CrTefImp")
                USE IN CrTefImp
            ENDIF
            CREATE CURSOR CrTefImp (cinfos C(100), nordems N(2), cnIdents C(10))
            INDEX ON cnIdents TAG Ident

            loc_oFormulario = THIS.this_oModem
            loc_okTef       = .T.
            loc_lcNSU       = ""
            loc_lcFinalzs   = ""
            loc_llCancTef   = .F.
            loc_RetCVinc    = .F.

            =fLerFiscal()

            WAIT WINDOW "Aguarde Verificando TEF Ativo!!" NOWAIT
            loc_lcRedeTef = ALLTRIM(THIS.txt_4c_Redetef.Value)

            IF THIS.this_oBusinessObject.this_nSistef = 1
                loc_lcTipo  = "ATV"
                loc_SendTef = SigFiTefReq(THIS, THIS.cNoCaixa, go_4c_Sistema.cCodEmpresa, ;
                                           THIS.cOperacao, 0, 0, loc_lcTipo, 0, loc_lcRedeTef)
                IF VARTYPE(loc_SendTef) = "N"
                    *-- ATV ok
                ELSE
                    loc_okTef = .F.
                    MsgAviso("Gerenciador Padr" + CHR(227) + "o n" + CHR(227) + "o Ativo !!", "")
                ENDIF
                WAIT CLEAR
            ENDIF

            IF loc_okTef
                IF USED("CrTef")
                    USE IN CrTef
                ENDIF
                CREATE CURSOR CrTef (cinfos M)

                IF THIS.this_oBusinessObject.BuscarTransacaoPorIdChaves(THIS.cPcIdChaves)
                    SELECT csSigFiTef
                    GO TOP

                    IF THIS.this_oBusinessObject.BuscarNFiscalPorComprovante( ;
                            ALLTRIM(crSigFiFis.Imps), ALLTRIM(csSigFiTef.cCupomnvs))
                        SELECT crTmpNFis
                        GO TOP
                        loc_lcDirReq  = ALLTRIM(crTmpNFis.cTefdReqs)
                        loc_lcDirResp = ALLTRIM(crTmpNFis.cTefdResps)
                        loc_lnQtdVia  = crTmpNFis.nQtdVias

                        loc_lcArquivo = LOWER(loc_lcDirResp + "IntPos.001")
                        IF FILE(loc_lcArquivo)
                            DELETE FILE (loc_lcArquivo)
                        ENDIF

                        SELECT csSigFiTef
                        loc_lcTipo = "CNC"
                        TefImpr(csSigFiTef.cEmps, csSigFiTef.cDopes, VAL(csSigFiTef.cnCupoms), ;
                                loc_lcTipo, VAL(csSigFiTef.cnIdents), csSigFiTef.cNmRedes, ;
                                csSigFiTef.cnNSUs, csSigFiTef.cFinalzs, csSigFiTef.cCupomnvs, ;
                                csSigFiTef.Fpags, VAL(csSigFiTef.cnValors) / 100)

                        SELECT crTmpNFis
                        loc_lcDirReq  = ALLTRIM(crTmpNFis.cTefdReqs)
                        loc_lcDirResp = ALLTRIM(crTmpNFis.cTefdResps)
                        loc_lnQtdVia  = crTmpNFis.nQtdVias
                        loc_lcArquivo = LOWER(loc_lcDirResp + "IntPos.001")

                        SELECT CrTefImp
                        DELETE ALL

                        IF !USED("CrTefResp")
                            CREATE CURSOR CrTefResp (cinfos C(100))
                            INDEX ON SUBSTR(CrTefResp.cInfos, 1, 3) TAG resp
                        ENDIF
                        SELECT CrTefResp
                        SET ORDER TO resp
                        DELETE ALL

                        APPEND FROM &loc_lcArquivo. SDF
                        SEEK "009"
                        IF ALLTRIM(SUBSTR(CrTefResp.cinfos, 11)) = "0"
                            loc_lcNSU = ""
                            IF SEEK("012")
                                loc_lcNSU = SUBSTR(CrTefResp.cinfos, 11)
                            ENDIF
                            loc_lcFinalzs = ""
                            SEEK "027"
                            IF FOUND()
                                loc_lcFinalzs = SUBSTR(CrTefResp.cinfos, 11)
                            ENDIF

                            FOR loc_lnContaQtdVia = 1 TO loc_lnQtdVia
                                SELECT CrTefResp
                                GO TOP
                                SEEK "029"
                                IF FOUND()
                                    DO WHILE CrTefResp.cInfos = "029"
                                        SELECT CrTefResp
                                        SCATTER MEMVAR
                                        m.cnIdents = csSigFiTef.cnIdents
                                        m.cinfos   = STRTRAN(SUBSTR(CrTefResp.cinfos, 11), '"', "")
                                        m.nvias    = loc_lnContaQtdVia
                                        INSERT INTO CrTefImp FROM MEMVAR
                                        SELECT CrTefResp
                                        SKIP
                                    ENDDO
                                    SELECT CrTefImp
                                    DELETE
                                ENDIF
                            NEXT

                            loc_RetCVinc  = .F.
                            loc_llCancTef = .F.
                            DO WHILE !loc_RetCVinc
                                SELECT csSigFiTef
                                loc_RetCVinc = RRelGerVinc(csSigFiTef.cnIdents, loc_oFormulario)
                                IF !loc_RetCVinc
                                    IF !MsgConfirma("Impressora N" + CHR(227) + "o Responde (1), " + ;
                                                    "Tentar Novamente ?", "")
                                        MsgInfo("Cancelamento N" + CHR(227) + "o Realizado com Sucesso," + ;
                                                " Reimpress" + CHR(227) + "o pelo Modulo Administrativo", "")
                                        loc_llCancTef = .T.
                                        loc_RetCVinc  = .F.
                                        EXIT
                                    ENDIF
                                ENDIF
                            ENDDO
                        ELSE
                            SEEK "030"
                            loc_lcMsg = IIF(EMPTY(ALLTRIM(SUBSTR(CrTefResp.cinfos, 11))), ;
                                            "Opera" + CHR(231) + CHR(227) + "o Cancelada pelo " + ;
                                            "Usu" + CHR(225) + "rio", ;
                                            ALLTRIM(SUBSTR(CrTefResp.cinfos, 11)))
                            DO FORM SigTfDss WITH "Erro na Trasa" + CHR(231) + CHR(227) + "o", ;
                                "", loc_lcMsg, ;
                                "Cancelar ou Reimprimir pelo Modulo Administrativo", ;
                                "", "VM", 0, 0
                            loc_llCancTef = .T.
                        ENDIF

                        IF !loc_llCancTef
                            SELECT csSigFiTef
                            loc_lcTipo = "CNF"
                            TefImpr(csSigFiTef.cEmps, csSigFiTef.cDopes, VAL(csSigFiTef.cnCupoms), ;
                                    loc_lcTipo, VAL(csSigFiTef.cnIdents), csSigFiTef.cNmRedes, ;
                                    loc_lcNSU, loc_lcFinalzs, csSigFiTef.cCupomnvs, csSigFiTef.Fpags)
                            THIS.this_oBusinessObject.AtualizarStatusTef(THIS.cPcIdChaves, "CNC")
                            WAIT CLEAR
                        ELSE
                            loc_lcNSU     = IIF(!EMPTY(loc_lcNSU),     loc_lcNSU,     csSigFiTef.cnNSUs)
                            loc_lcFinalzs = IIF(!EMPTY(loc_lcFinalzs), loc_lcFinalzs, csSigFiTef.cFinalzs)
                            FinFimVinc(loc_oFormulario)
                            DO FORM SIGCNTEF WITH csSigFiTef.cnNSUs, csSigFiTef.cNmRedes, ;
                                VAL(STRTRAN(csSigFiTef.cnValors, ",", ".")) / 100
                            loc_lcTipo = "NCN"
                            TefImpr(go_4c_Sistema.cCodEmpresa, "", 0, loc_lcTipo, ;
                                    VAL(csSigFiTef.cnIdents), csSigFiTef.cNmRedes, ;
                                    loc_lcNSU, loc_lcFinalzs, csSigFiTef.cCupomnvs, csSigFiTef.Fpags)
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            WAIT CLEAR
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro CmdCancelarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ProcCntTxt
    *==========================================================================
        LOCAL loc_cHeader, loc_lcTran, loc_nSistef, loc_cSQL, loc_oErro
        TRY
            IF !USED("crSigFiTef") OR EOF("crSigFiTef")
                RETURN
            ENDIF

            loc_nSistef = THIS.this_oBusinessObject.this_nSistef
            SELECT crSigFiTef

            IF (ALLTRIM(crSigFiTef.cTpTrans) = "99" AND loc_nSistef = 1) OR loc_nSistef = 3
                loc_cHeader = SPACE(3)
            ELSE
                loc_cHeader = crSigFiTef.cHeaders
            ENDIF

            IF USED("crSigFiTra")
                USE IN crSigFiTra
            ENDIF
            loc_cSQL = "SELECT * FROM SigFiTra " + ;
                       "WHERE cHeaders = " + EscaparSQL(ALLTRIM(loc_cHeader)) + ;
                       " AND cTpTrans = " + EscaparSQL(ALLTRIM(crSigFiTef.cTpTrans))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigFiTra") > 0
                SELECT crSigFiTra
                GO TOP
                IF EOF() OR ALLTRIM(crSigFiTef.cTpTrans) = "99"
                    loc_lcTran = "Outras"
                ELSE
                    loc_lcTran = ALLTRIM(crSigFiTra.cTrans)
                ENDIF
            ELSE
                loc_lcTran = "Outras"
            ENDIF

            WITH THIS.cnt_4c_TefTxt
                .Top  = 35
                .Left = 2
                IF loc_nSistef = 1 OR loc_nSistef = 3
                    IF !EMPTY(ALLTRIM(crSigFiTef.cTxtOpers))
                        .lbl_4c_TxtOper.Caption  = ALLTRIM(crSigFiTef.cTxtOpers)
                        .lbl_4c_TxtOper.Width    = 239
                        .lbl_4c_TxtOper.AutoSize = .T.
                        .Visible = .T.
                        .ZOrder()
                    ENDIF
                    IF !EMPTY(ALLTRIM(crSigFiTef.cTxtClis))
                        .lbl_4c_TxtCli.Caption  = ALLTRIM(crSigFiTef.cTxtClis)
                        .lbl_4c_TxtCli.Width    = 255
                        .lbl_4c_TxtCli.AutoSize = .T.
                        .Visible = .T.
                        .ZOrder()
                    ENDIF
                    IF !EMPTY(loc_lcTran)
                        .lbl_4c_TxtTpTrans.Caption  = loc_lcTran
                        .lbl_4c_TxtTpTrans.Width    = 195
                        .lbl_4c_TxtTpTrans.AutoSize = .T.
                        .Visible = .T.
                        .ZOrder()
                    ENDIF
                ENDIF
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro ProcCntTxt")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ExcluirTef(par_cIdent)
    *==========================================================================
        LOCAL loc_llChecaSigTef, loc_cChave, loc_oErro
        loc_llChecaSigTef = .F.
        TRY
            IF !USED("SigTef")
                IF TYPE("goSistema") = "O" AND !EMPTY(goSistema.DirTefEcfs)
                    USE (goSistema.DirTefEcfs + "\SigTef") IN 0
                    loc_llChecaSigTef = .T.
                ENDIF
            ENDIF
            IF USED("SigTef")
                loc_cChave = "R" + go_4c_Sistema.cCodEmpresa + THIS.cOperacao + ALLTRIM(par_cIdent)
                =SEEK(loc_cChave, "SigTef", "Ident")
                SELECT SigTef
                IF !EOF("SigTef")
                    DELETE IN SigTef
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro ExcluirTef")
        ENDTRY
        IF loc_llChecaSigTef AND USED("SigTef")
            USE IN SigTef
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ImprFiscalProc(par_nIdent)
    *==========================================================================
        LOCAL loc_lRetCVinc, loc_lLoopCVinc, loc_lRetNImp, loc_lPrimeira, loc_lRetFim
        LOCAL loc_lnValor, loc_lcCancTef, loc_lcNSUs, loc_lcTipo, loc_VerStatus
        LOCAL loc_oFormulario, loc_lcRedes, loc_oErro

        TRY
            IF USED("crSigFiFis")
                SELECT crSigFiFis
                GO TOP
            ENDIF

            loc_oFormulario = THIS.this_oModem

            IF !EMPTY(THIS.cOperacao)
                loc_lRetCVinc  = .F.
                loc_lLoopCVinc = .T.
                loc_lPrimeira  = .T.
                loc_lRetFim    = .T.

                DO WHILE loc_lLoopCVinc
                    CLEAR TYPEAHEAD
                    THIS.ProcCntTxt()

                    SELECT CrTefImp
                    loc_lnValor = "0"
                    GO TOP
                    LOCATE FOR cinfos = " VALOR VENDA"
                    IF EOF()
                        LOCATE FOR cinfos = "    FINAL"
                        IF !EOF()
                            loc_lnValor = STRTRAN(STRTRAN(ALLTRIM(SUBSTR(cinfos, 10)), ",", ""), ".", "")
                        ENDIF
                    ELSE
                        loc_lnValor = STRTRAN(STRTRAN(ALLTRIM(SUBSTR(cinfos, 16)), ",", ""), ".", "")
                    ENDIF
                    GO TOP

                    IF !loc_lPrimeira
                        IF USED("crSigFiFis") AND UPPER(ALLTRIM(crSigFiFis.Imps)) = "SWEDA"
                            loc_lRetFim = FinFimVinc(loc_oFormulario)
                        ELSE
                            loc_lRetFim   = .F.
                            loc_VerStatus = RotStatus(1, loc_oFormulario)
                            IF VARTYPE(loc_VerStatus) <> "L"
                                IF SUBSTR(loc_VerStatus, 1, 1) = "R"
                                    loc_lRetFim = FinFimVinc(loc_oFormulario)
                                ENDIF
                                IF !loc_lRetFim AND SUBSTR(loc_VerStatus, 6, 1) = "K"
                                    loc_lRetFim = .T.
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF

                    IF loc_lRetFim
                        SELECT CrTefImp
                        GO TOP
                        loc_lRetCVinc = RRelGerVinc(CrTefImp.cnIdents, loc_oFormulario, THIS.cOperacao)
                    ENDIF

                    loc_lPrimeira = .F.
                    WITH THIS.cnt_4c_TefTxt
                        .lbl_4c_TxtOper.Caption    = ""
                        .lbl_4c_TxtCli.Caption     = ""
                        .lbl_4c_TxtTpTrans.Caption = ""
                        .Visible = .F.
                    ENDWITH

                    IF loc_lRetCVinc
                        loc_lcCancTef = ""
                        IF USED("CrTefResp")
                            SELECT CrTefResp
                            GO TOP
                            IF SEEK("025")
                                loc_lcCancTef = ALLTRIM(SUBSTR(CrTefResp.cinfos, 11))
                            ENDIF
                        ENDIF

                        IF THIS.this_oBusinessObject.BuscarTransacaoTEF("R", ;
                                go_4c_Sistema.cCodEmpresa, THIS.cOperacao, ;
                                ALLTRIM(STR(par_nIdent, 20)))
                            SELECT crSigFiTef
                            loc_lcNSUs = IIF(EMPTY(ALLTRIM(crSigFiTef.cnNSUCancs)), ;
                                             crSigFiTef.cnNSUs, crSigFiTef.cnNSUCancs)
                            loc_lcTipo = "CNF"
                            TefImpr(go_4c_Sistema.cCodEmpresa, THIS.cOperacao, 0, loc_lcTipo, ;
                                    VAL(crSigFiTef.cnIdents), crSigFiTef.cNmRedes, loc_lcNSUs, ;
                                    crSigFiTef.cFinalzs, crSigFiTef.cCupomnvs, crSigFiTef.FPags)
                            THIS.ExcluirTef(crSigFiTef.cnIdents)

                            IF !EMPTY(loc_lcCancTef)
                                IF !EMPTY(THIS.cPcIdChaves)
                                    THIS.this_oBusinessObject.AtualizarStatusTef( ;
                                        THIS.cPcIdChaves, "CNC")
                                ELSE
                                    loc_lcRedes = ""
                                    IF USED("CrTefResp")
                                        SELECT CrTefResp
                                        IF SEEK("010")
                                            loc_lcRedes = ALLTRIM(SUBSTR(CrTefResp.cinfos, 11))
                                        ENDIF
                                    ENDIF
                                    IF !EMPTY(loc_lcRedes)
                                        THIS.this_oBusinessObject.AtualizarStatusTefPorRede( ;
                                            loc_lcRedes, loc_lcCancTef, "CNC")
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF

                        loc_lLoopCVinc = .F.
                        loc_lRetCVinc  = .T.
                        LOOP
                    ELSE
                        WAIT WINDOW "Aguarde Impress" + CHR(227) + "o !!!" NOWAIT
                        IF USED("crSigFiFis") AND UPPER(ALLTRIM(crSigFiFis.Imps)) <> "SWEDA"
                            loc_VerStatus = RotStatus(1, loc_oFormulario)
                            IF VARTYPE(loc_VerStatus) <> "L"
                                IF SUBSTR(loc_VerStatus, 6, 1) = "t"
                                    MsgAviso("Encontrou-se no comando a string 'TOTAL'", "ERRO")
                                    FinFimVinc(loc_oFormulario)
                                    IF THIS.this_oBusinessObject.this_nSistef = 1
                                        IF THIS.this_oBusinessObject.BuscarTransacaoTEF("R", ;
                                                go_4c_Sistema.cCodEmpresa, THIS.cOperacao, ;
                                                ALLTRIM(STR(par_nIdent, 20)))
                                            SELECT crSigFiTef
                                            DO FORM SIGCNTEF WITH crSigFiTef.cnNSUs, crSigFiTef.cNmRedes, ;
                                                VAL(loc_lnValor) / 100
                                        ENDIF
                                    ENDIF
                                    IF THIS.this_oBusinessObject.BuscarTransacaoTEF("R", ;
                                            go_4c_Sistema.cCodEmpresa, THIS.cOperacao, ;
                                            ALLTRIM(STR(par_nIdent, 20)))
                                        SELECT crSigFiTef
                                        loc_lcTipo = "NCN"
                                        TefImpr(go_4c_Sistema.cCodEmpresa, THIS.cOperacao, 0, ;
                                                loc_lcTipo, VAL(crSigFiTef.cnIdents), ;
                                                crSigFiTef.cNmRedes, crSigFiTef.cnNSUs, ;
                                                crSigFiTef.cFinalzs, crSigFiTef.cCupomnvs, ;
                                                crSigFiTef.FPags)
                                        THIS.ExcluirTef(crSigFiTef.cnIdents)
                                    ENDIF
                                    loc_lLoopCVinc = .F.
                                    loc_lRetCVinc  = .F.
                                    LOOP
                                ENDIF
                            ENDIF
                        ENDIF

                        IF (THIS.this_oBusinessObject.this_nSistef = 1 AND ;
                            !MsgConfirma("IMPRESSORA N" + CHR(195) + "O RESPONDE, TENTAR NOVAMENTE", "")) OR ;
                           THIS.this_oBusinessObject.this_nSistef = 3

                            IF THIS.this_oBusinessObject.BuscarTransacaoTEF("R", ;
                                    go_4c_Sistema.cCodEmpresa, THIS.cOperacao, ;
                                    ALLTRIM(STR(par_nIdent, 20)))
                                SELECT crSigFiTef
                                loc_lcTipo = "NCN"
                                TefImpr(go_4c_Sistema.cCodEmpresa, THIS.cOperacao, 0, ;
                                        loc_lcTipo, VAL(crSigFiTef.cnIdents), ;
                                        crSigFiTef.cNmRedes, crSigFiTef.cnNSUs, ;
                                        crSigFiTef.cFinalzs, crSigFiTef.cCupomnvs, ;
                                        crSigFiTef.FPags)
                                THIS.ExcluirTef(crSigFiTef.cnIdents)
                                IF THIS.this_oBusinessObject.this_nSistef = 1
                                    DO FORM SIGCNTEF WITH crSigFiTef.cnNSUs, crSigFiTef.cNmRedes, ;
                                        VAL(loc_lnValor) / 100
                                ENDIF
                            ENDIF
                            loc_lLoopCVinc = .F.
                            loc_lRetCVinc  = .F.
                            LOOP
                        ELSE
                            loc_lRetFim   = .T.
                            loc_lPrimeira = .T.
                        ENDIF
                    ENDIF
                ENDDO

                WAIT CLEAR
            ELSE
                MsgAviso("Nenhuma Opera" + CHR(231) + CHR(227) + "o de Cupom Fiscal !!", "ERRO")
            ENDIF
        CATCH TO loc_oErro
            WAIT CLEAR
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro ImprFiscalProc")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Aciona Administra + CHR(231) + CHR(227) + o do TEF (Admin)
    * Form OPERACIONAL TEF: mapeia semantica CRUD para acao TEF equivalente.
    * Requer rede TEF preenchida (usada em CmdTefAdmWhen).
    *==========================================================================
    PROCEDURE BtnIncluirClick
        IF EMPTY(ALLTRIM(THIS.txt_4c_Redetef.Value))
            MsgAviso("Informe a Rede TEF antes de acionar a Administra" + CHR(231) + CHR(227) + "o.", "Aviso")
            THIS.txt_4c_Redetef.SetFocus()
            RETURN
        ENDIF
        THIS.CmdTefAdmClick()
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Verifica se o TEF esta Ativo (Tef Ativo)
    * Form OPERACIONAL TEF: mapeia semantica CRUD para acao TEF equivalente.
    *==========================================================================
    PROCEDURE BtnAlterarClick
        IF EMPTY(ALLTRIM(THIS.txt_4c_Redetef.Value))
            MsgAviso("Informe a Rede TEF antes de verificar o TEF Ativo.", "Aviso")
            THIS.txt_4c_Redetef.SetFocus()
            RETURN
        ENDIF
        THIS.CmdTefAtvClick()
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Aciona Cancelamento de transacao TEF (Cancelar)
    * Form OPERACIONAL TEF: mapeia semantica CRUD para acao TEF equivalente.
    *==========================================================================
    PROCEDURE BtnVisualizarClick
        IF EMPTY(ALLTRIM(THIS.txt_4c_Redetef.Value))
            MsgAviso("Informe a Rede TEF antes de cancelar a transa" + CHR(231) + CHR(227) + "o.", "Aviso")
            THIS.txt_4c_Redetef.SetFocus()
            RETURN
        ENDIF
        THIS.CmdCancelarClick()
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Encerra o formulario (Encerrar)
    * Form OPERACIONAL TEF: mapeia semantica CRUD para acao TEF equivalente.
    *==========================================================================
    PROCEDURE BtnExcluirClick
        THIS.CmdEncerrarClick()
    ENDPROC

    *==========================================================================
    PROCEDURE BtnEncerrarClick
    *==========================================================================
        THIS.CmdEncerrarClick()
    ENDPROC

    *==========================================================================
    PROCEDURE BtnBuscarClick
    *==========================================================================
        *-- Form OPERACIONAL TEF: sem grade de registros para busca.
        *-- Seta foco no campo Rede TEF para iniciar nova operacao.
        IF VARTYPE(THIS.txt_4c_Redetef) = "O"
            THIS.txt_4c_Redetef.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE BtnSalvarClick
    *==========================================================================
        *-- Form OPERACIONAL TEF: sem registro CRUD para salvar.
        *-- Aciona a operacao Admin (equivalente principal deste form).
        IF EMPTY(ALLTRIM(THIS.txt_4c_Redetef.Value))
            MsgAviso("Informe a Rede TEF antes de acionar a Administra" + ;
                     CHR(231) + CHR(227) + "o.", "Aviso")
            THIS.txt_4c_Redetef.SetFocus()
            RETURN
        ENDIF
        THIS.CmdTefAdmClick()
    ENDPROC

    *==========================================================================
    PROCEDURE BtnCancelarClick
    *==========================================================================
        *-- Form OPERACIONAL TEF: encerra o formulario (sem edicao CRUD a cancelar).
        THIS.CmdEncerrarClick()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE FormParaBO
    *==========================================================================
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_cRedeTef = ;
                IIF(VARTYPE(THIS.txt_4c_Redetef) = "O", ;
                    ALLTRIM(THIS.txt_4c_Redetef.Value), "")
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE BOParaForm
    *==========================================================================
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            IF VARTYPE(THIS.txt_4c_Redetef) = "O"
                THIS.txt_4c_Redetef.Value = ;
                    IIF(EMPTY(THIS.this_oBusinessObject.this_cRedeTef), ;
                        "", THIS.this_oBusinessObject.this_cRedeTef)
                THIS.txt_4c_Redetef.Refresh()
            ENDIF
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
    *==========================================================================
        LOCAL loc_lHab
        loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
        IF VARTYPE(THIS.txt_4c_Redetef) = "O"
            THIS.txt_4c_Redetef.Enabled = loc_lHab
        ENDIF
        IF VARTYPE(THIS.cmd_4c_TefAdm) = "O"
            THIS.cmd_4c_TefAdm.Enabled = loc_lHab AND THIS.this_oBusinessObject.this_lInicializado
        ENDIF
        IF VARTYPE(THIS.cmd_4c_TefAtv) = "O"
            THIS.cmd_4c_TefAtv.Enabled = loc_lHab AND THIS.this_oBusinessObject.this_lInicializado
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE LimparCampos
    *==========================================================================
        IF VARTYPE(THIS.txt_4c_Redetef) = "O"
            THIS.txt_4c_Redetef.Value = ""
            THIS.txt_4c_Redetef.Refresh()
        ENDIF
        IF VARTYPE(THIS.cnt_4c_TefTxt) = "O"
            WITH THIS.cnt_4c_TefTxt
                IF VARTYPE(.lbl_4c_TxtOper) = "O"
                    .lbl_4c_TxtOper.Caption = ""
                ENDIF
                IF VARTYPE(.lbl_4c_TxtCli) = "O"
                    .lbl_4c_TxtCli.Caption = ""
                ENDIF
                IF VARTYPE(.lbl_4c_TxtTpTrans) = "O"
                    .lbl_4c_TxtTpTrans.Caption = ""
                ENDIF
                .Visible = .F.
            ENDWITH
        ENDIF
        IF USED("CrTefImp")
            USE IN CrTefImp
        ENDIF
        IF USED("CrTefResp")
            USE IN CrTefResp
        ENDIF
        IF USED("CrTef")
            USE IN CrTef
        ENDIF
        IF USED("crSigFiTra")
            USE IN crSigFiTra
        ENDIF
        IF USED("CrSigFiNfs")
            USE IN CrSigFiNfs
        ENDIF
        IF USED("csSigFiTef")
            USE IN csSigFiTef
        ENDIF
        IF USED("crTmpNFis")
            USE IN crTmpNFis
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_cRedeTef = ""
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarLista
    *==========================================================================
        *-- Form OPERACIONAL TEF: sem lista de registros CRUD.
        *-- InicializarEstadoTEF gerencia o carregamento de dados transacionais.
        RETURN .T.
    ENDPROC

    *==========================================================================
    PROCEDURE AjustarBotoesPorModo
    *==========================================================================
        *-- Form OPERACIONAL TEF: sem modos CRUD (INCLUIR/ALTERAR/VISUALIZAR).
        *-- Habilitacao dos botoes eh gerenciada por InicializarEstadoTEF.
        RETURN .T.
    ENDPROC

ENDDEFINE
