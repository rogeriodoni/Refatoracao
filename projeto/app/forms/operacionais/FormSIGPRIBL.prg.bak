*------------------------------------------------------------------------------
* FormSIGPRIBL.prg - Formulario Operacional de Impressao de Boleto Bancario
* Herda de: FormBase
* Tipo: OPERACIONAL (layout flat, sem PageFrame)
* Tabela: SigCnFBl (configuracao de boleto bancario)
*------------------------------------------------------------------------------
DEFINE CLASS FormSIGPRIBL AS FormBase

    *-- Dimensoes e aparencia (TitleBar=0: sem barra de titulo - form modal flutuante)
    Width        = 1000
    Height       = 400
    AutoCenter   = .T.
    ShowTips     = .T.
    BorderStyle  = 2
    ShowWindow = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    TitleBar     = 0
    WindowType   = 1

    *-- Parametros recebidos na abertura
    this_cChave1  = ""     && pcchave1: chave do movimento pai (Emps+Dopes+Numes)
    this_xNform1  = .NULL. && pcnform1: ref ao form chamador (pode ser O ou C no legado)

    *-- Estado interno
    this_cFPagsSel = ""    && FPags atualmente selecionado

    *-- BO (nao utilizado diretamente; logica principal esta no form)
    this_oBusinessObject = .NULL.

    *--------------------------------------------------------------------------
    * Init - Recebe chave do movimento pai e referencia ao form chamador
    *--------------------------------------------------------------------------
    PROCEDURE Init
        LPARAMETERS par_cChave1, par_cNform1

        IF VARTYPE(par_cChave1) = "C"
            THIS.this_cChave1 = par_cChave1
        ENDIF
        THIS.this_xNform1 = par_cNform1

        *-- Cursor auxiliar de movimentos a imprimir (compartilhado com SigPrIbl.prg)
        IF !USED("TprMvCab")
            CREATE CURSOR TprMvCab (Emps C(3), Dopes C(20), Numes N(6,0), Parcs C(2))
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configura o formulario operacional completo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            THIS.Caption = "Impress" + CHR(227) + "o de Boleto Banc" + CHR(225) + "rio"

            IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            ENDIF

            THIS.ConfigurarCabecalho()
            THIS.ConfigurarPageFrame()
            THIS.TornarControlesVisiveis()
            THIS.AtualizaBoleto("")

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro em InicializarForm")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Cria container cinza superior com titulo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top        = 0
            .Left       = 0
            .Width      = 1020
            .Height     = 80
            .BorderWidth = 0
            .BackStyle  = 1
            .BackColor  = RGB(100, 100, 100)

            .AddObject("lbl_4c_LblSombra", "Label")
            WITH .lbl_4c_LblSombra
                .AutoSize      = .F.
                .Top           = 18
                .Left          = 10
                .Width         = THIS.Width
                .Height        = 40
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .ForeColor     = RGB(0, 0, 0)
                .Caption       = "Impress" + CHR(227) + "o de Boleto Banc" + CHR(225) + "rio"
            ENDWITH

            .AddObject("lbl_4c_LblTitulo", "Label")
            WITH .lbl_4c_LblTitulo
                .AutoSize      = .F.
                .Top           = 17
                .Left          = 10
                .Width         = THIS.Width
                .Height        = 46
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .ForeColor     = RGB(255, 255, 255)
                .Caption       = "Impress" + CHR(227) + "o de Boleto Banc" + CHR(225) + "rio"
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Ponto de entrada canonico do pipeline
    * Form OPERACIONAL (dialogo modal): nao tem PageFrame Page1/Page2.
    * Delega para ConfigurarPageFrame (montagem flat) apenas se controles ainda
    * nao foram criados, evitando duplicacao em caso de reentrada.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        IF !PEMSTATUS(THIS, "txt_4c_FPags", 5)
            THIS.ConfigurarPageFrame()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Ponto de entrada canonico do pipeline (Fase 5)
    * Form OPERACIONAL: nao possui Page2 separada com campos de edicao.
    * Todos os controles (txt_4c_FPags, txt_4c_Locals, obj_4c_GetTxtCds,
    * lbl_4c_*, obj_4c_CmdGImprimir) ja foram criados em ConfigurarPageFrame().
    * Este metodo existe apenas por compatibilidade com o pipeline multi-fase.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Ponto de entrada canonico do pipeline
    * Form OPERACIONAL: nao ha alternancia de paginas; recarrega configuracao
    * do boleto e faz refresh dos controles com base no FPags atual.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        THIS.AtualizaBoleto(THIS.this_cFPagsSel)
        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Configura layout do form (OPERACIONAL flat, sem PageFrame real)
    * Nome mantido por compatibilidade com pipeline; em forms OPERACIONAIS
    * este metodo cria labels, TextBoxes, EditBox e CommandGroup diretamente
    * no form (sem Page1/Page2). Equivalente a ConfigurarInterface em CRUD.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oErro
        TRY
            *-- lbl_4c_Label2: Condicao de Pagamento
            THIS.AddObject("lbl_4c_Label2", "Label")
            WITH THIS.lbl_4c_Label2
                .AutoSize   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 8
                .BackStyle  = 0
                .Caption    = " Condi" + CHR(231) + CHR(227) + "o de Pagamento "
                .Height     = 15
                .Left       = 82
                .Top        = 93
                .Width      = 124
                .ForeColor  = RGB(90, 90, 90)
            ENDWITH

            *-- txt_4c_FPags: TextBox de selecao da condicao de pagamento (lookup SigCnFBl)
            THIS.AddObject("txt_4c_FPags", "TextBox")
            WITH THIS.txt_4c_FPags
                .FontName   = "Tahoma"
                .Left       = 84
                .MaxLength  = 12
                .Top        = 110
                .Width      = 94
                .ForeColor  = RGB(0, 0, 0)
                .Value      = ""
            ENDWITH
            BINDEVENT(THIS.txt_4c_FPags, "KeyPress", THIS, "TxtFPagsKeyPress")

            *-- lbl_4c_Label3: Local de Pagamento
            THIS.AddObject("lbl_4c_Label3", "Label")
            WITH THIS.lbl_4c_Label3
                .AutoSize   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 8
                .BackStyle  = 0
                .Caption    = " Local de Pagamento "
                .Height     = 15
                .Left       = 82
                .Top        = 151
                .Width      = 104
                .ForeColor  = RGB(90, 90, 90)
            ENDWITH

            *-- txt_4c_Locals: TextBox de local de pagamento (editavel, multi-linha via Height)
            THIS.AddObject("txt_4c_Locals", "TextBox")
            WITH THIS.txt_4c_Locals
                .FontName   = "Tahoma"
                .Left       = 84
                .MaxLength  = 100
                .Top        = 168
                .Width      = 798
                .Height     = 69
                .ForeColor  = RGB(0, 0, 0)
                .Value      = ""
                .Enabled    = .F.
            ENDWITH

            *-- lbl_4c_Label31: Texto de Responsabilidade do Cedente
            THIS.AddObject("lbl_4c_Label31", "Label")
            WITH THIS.lbl_4c_Label31
                .AutoSize   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 8
                .BackStyle  = 0
                .Caption    = " Texto de Responsabilidade do Cedente "
                .Height     = 15
                .Left       = 82
                .Top        = 251
                .Width      = 196
                .ForeColor  = RGB(90, 90, 90)
            ENDWITH

            *-- obj_4c_GetTxtCds: EditBox de texto do cedente
            THIS.AddObject("obj_4c_GetTxtCds", "EditBox")
            WITH THIS.obj_4c_GetTxtCds
                .FontName   = "Tahoma"
                .Left       = 84
                .Top        = 268
                .Width      = 798
                .Height     = 69
                .ForeColor  = RGB(0, 0, 0)
                .Value      = ""
                .Enabled    = .F.
            ENDWITH

            *-- lbl_4c_LblAviso: aviso quando sem configuracao de boleto
            THIS.AddObject("lbl_4c_LblAviso", "Label")
            WITH THIS.lbl_4c_LblAviso
                .AutoSize   = .T.
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .BackStyle  = 0
                .Caption    = "N" + CHR(227) + "o Existe Configura" + CHR(231) + CHR(227) + "o de Boleto"
                .Left       = 89
                .Top        = 351
                .Width      = 213
                .ForeColor  = RGB(90, 90, 90)
                .Visible    = .F.
            ENDWITH

            *-- obj_4c_CmdGImprimir: CommandGroup com Imprimir + Encerrar
            THIS.AddObject("obj_4c_CmdGImprimir", "CommandGroup")
            WITH THIS.obj_4c_CmdGImprimir
                .ButtonCount  = 2
                .BackStyle    = 0
                .BorderStyle  = 0
                .Value        = 1
                .Height       = 88
                .Left         = 835
                .SpecialEffect = 1
                .Top          = 2
                .Width        = 173
                .Themes       = .F.

                WITH .Buttons(1)
                    .Top          = 5
                    .Left         = 11
                    .Height       = 75
                    .Width        = 75
                    .FontBold     = .T.
                    .FontItalic   = .T.
                    .Caption      = "\<Imprimir"
                    .ToolTipText  = "Imprimir"
                    .ForeColor    = RGB(90, 90, 90)
                    .BackColor    = RGB(255, 255, 255)
                    .Themes       = .F.
                    .Picture      = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
                    .Enabled      = .F.
                ENDWITH

                WITH .Buttons(2)
                    .Top          = 5
                    .Left         = 87
                    .Height       = 75
                    .Width        = 75
                    .FontBold     = .T.
                    .FontItalic   = .T.
                    .FontName     = "Tahoma"
                    .FontSize     = 8
                    .Caption      = "Encerrar"
                    .ToolTipText  = "[ESC] Sair"
                    .ForeColor    = RGB(90, 90, 90)
                    .BackColor    = RGB(255, 255, 255)
                    .Themes       = .F.
                    .Cancel       = .T.
                    .Picture      = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                ENDWITH
            ENDWITH

            BINDEVENT(THIS.obj_4c_CmdGImprimir.Buttons(1), "Click", THIS, "CmdImprimirClick")
            BINDEVENT(THIS.obj_4c_CmdGImprimir.Buttons(2), "Click", THIS, "CmdSaidaClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro em ConfigurarPageFrame")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizaBoleto - Recarrega config de SigCnFBl e habilita/desabilita controles
    *--------------------------------------------------------------------------
    PROCEDURE AtualizaBoleto(par_cCond)
        LOCAL loc_cFPags, loc_cSQL, loc_nRet, loc_oErro, loc_lAchou
        loc_lAchou = .F.
        TRY
            loc_cFPags = PADR(NVL(par_cCond, ""), 12)
            THIS.this_cFPagsSel = ALLTRIM(loc_cFPags)

            IF USED("cursor_4c_Config")
                USE IN cursor_4c_Config
            ENDIF
            IF USED("cursor_4c_ConfigTemp")
                USE IN cursor_4c_ConfigTemp
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_Config ( ;
                FPags      C(12)  NULL, ;
                cLocals    C(100) NULL, ;
                cTxtCds    M      NULL, ;
                cNomeImps  C(50)  NULL, ;
                cFontePdrs C(20)  NULL, ;
                nTamFontes N(3,0) NULL, ;
                cTamFolha  C(30)  NULL, ;
                cIdChaves  C(15)  NULL, ;
                nLnLocals  N(6,2) NULL, ;
                nClLocals  N(6,2) NULL, ;
                nLnDtVencs N(6,2) NULL, ;
                nClDtVencs N(6,2) NULL, ;
                nLnDtDocs  N(6,2) NULL, ;
                nClDtDocs  N(6,2) NULL, ;
                nLnNrDocs  N(6,2) NULL, ;
                nClNrDocs  N(6,2) NULL, ;
                nLnVlDocs  N(6,2) NULL, ;
                nClVlDocs  N(6,2) NULL, ;
                nLnRazClis N(6,2) NULL, ;
                nClRazClis N(6,2) NULL, ;
                nLnCgcClis N(6,2) NULL, ;
                nClCgcClis N(6,2) NULL, ;
                nLnEndCobs N(6,2) NULL, ;
                nClEndCobs N(6,2) NULL, ;
                nLnBaiCobs N(6,2) NULL, ;
                nClBaiCobs N(6,2) NULL, ;
                nLnCidCobs N(6,2) NULL, ;
                nClCidCobs N(6,2) NULL, ;
                nLnEstCobs N(6,2) NULL, ;
                nClEstCobs N(6,2) NULL, ;
                nLnCepCobs N(6,2) NULL, ;
                nClCepCobs N(6,2) NULL, ;
                nLnTxtCds  N(6,2) NULL, ;
                nClTxtCds  N(6,2) NULL  ;
            )
            SET NULL OFF

            loc_cSQL = "SELECT FPags, cLocals, cTxtCds, cNomeImps, cFontePdrs," + ;
                       " nTamFontes, cTamFolha, cIdChaves," + ;
                       " nLnLocals, nClLocals, nLnDtVencs, nClDtVencs," + ;
                       " nLnDtDocs, nClDtDocs, nLnNrDocs, nClNrDocs," + ;
                       " nLnVlDocs, nClVlDocs, nLnRazClis, nClRazClis," + ;
                       " nLnCgcClis, nClCgcClis, nLnEndCobs, nClEndCobs," + ;
                       " nLnBaiCobs, nClBaiCobs, nLnCidCobs, nClCidCobs," + ;
                       " nLnEstCobs, nClEstCobs, nLnCepCobs, nClCepCobs," + ;
                       " nLnTxtCds, nClTxtCds" + ;
                       " FROM SigCnFBl WHERE FPags = " + EscaparSQL(loc_cFPags)
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConfigTemp")

            IF loc_nRet > 0 AND USED("cursor_4c_ConfigTemp") AND RECCOUNT("cursor_4c_ConfigTemp") > 0
                SELECT cursor_4c_Config
                ZAP
                APPEND FROM DBF("cursor_4c_ConfigTemp")
                IF USED("cursor_4c_ConfigTemp")
                    USE IN cursor_4c_ConfigTemp
                ENDIF
                SELECT cursor_4c_Config
                GO TOP
                loc_lAchou = .T.
            ELSE
                IF USED("cursor_4c_ConfigTemp")
                    USE IN cursor_4c_ConfigTemp
                ENDIF
            ENDIF

            IF loc_lAchou
                IF PEMSTATUS(THIS, "txt_4c_Locals", 5)
                    THIS.txt_4c_Locals.Enabled = .T.
                    THIS.txt_4c_Locals.Value   = NVL(cursor_4c_Config.cLocals, "")
                    THIS.txt_4c_Locals.Refresh()
                ENDIF
                IF PEMSTATUS(THIS, "obj_4c_GetTxtCds", 5)
                    THIS.obj_4c_GetTxtCds.Enabled = .T.
                    THIS.obj_4c_GetTxtCds.Value   = NVL(cursor_4c_Config.cTxtCds, "")
                    THIS.obj_4c_GetTxtCds.Refresh()
                ENDIF
                IF PEMSTATUS(THIS, "lbl_4c_LblAviso", 5)
                    THIS.lbl_4c_LblAviso.Visible = .F.
                ENDIF
                IF PEMSTATUS(THIS, "obj_4c_CmdGImprimir", 5)
                    THIS.obj_4c_CmdGImprimir.Buttons(1).Enabled = .T.
                    THIS.obj_4c_CmdGImprimir.Refresh()
                ENDIF
            ELSE
                IF PEMSTATUS(THIS, "txt_4c_Locals", 5)
                    THIS.txt_4c_Locals.Enabled = .F.
                    THIS.txt_4c_Locals.Refresh()
                ENDIF
                IF PEMSTATUS(THIS, "obj_4c_GetTxtCds", 5)
                    THIS.obj_4c_GetTxtCds.Enabled = .F.
                    THIS.obj_4c_GetTxtCds.Refresh()
                ENDIF
                IF PEMSTATUS(THIS, "lbl_4c_LblAviso", 5)
                    THIS.lbl_4c_LblAviso.Visible = .T.
                ENDIF
                IF PEMSTATUS(THIS, "obj_4c_CmdGImprimir", 5)
                    THIS.obj_4c_CmdGImprimir.Buttons(1).Enabled = .F.
                    THIS.obj_4c_CmdGImprimir.Value = 2
                    THIS.obj_4c_CmdGImprimir.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em AtualizaBoleto")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtFPagsKeyPress - Handler do campo Condicao de Pagamento
    *--------------------------------------------------------------------------
    PROCEDURE TxtFPagsKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        LOCAL loc_cVal, loc_cSQL, loc_nRet, loc_lProcessar, loc_oErro
        loc_lProcessar = .T.
        TRY
            loc_cVal = ALLTRIM(NVL(THIS.txt_4c_FPags.Value, ""))

            IF EMPTY(loc_cVal)
                THIS.AtualizaBoleto("")
                loc_lProcessar = .F.
            ENDIF

            IF loc_lProcessar
                *-- Busca exata primeiro
                loc_cSQL = "SELECT TOP 1 FPags FROM SigCnFBl WHERE FPags = " + ;
                           EscaparSQL(PADR(loc_cVal, 12))
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FPagsExato")

                IF loc_nRet > 0 AND USED("cursor_4c_FPagsExato") AND RECCOUNT("cursor_4c_FPagsExato") > 0
                    SELECT cursor_4c_FPagsExato
                    THIS.txt_4c_FPags.Value = ALLTRIM(NVL(FPags, ""))
                    IF USED("cursor_4c_FPagsExato")
                        USE IN cursor_4c_FPagsExato
                    ENDIF
                    THIS.AtualizaBoleto(THIS.txt_4c_FPags.Value)
                ELSE
                    IF USED("cursor_4c_FPagsExato")
                        USE IN cursor_4c_FPagsExato
                    ENDIF
                    *-- Nao encontrado exato: abre lookup
                    THIS.AbrirLookupFPags()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar Condi" + CHR(231) + CHR(227) + "o de Pagamento")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupFPags - Abre FormBuscaAuxiliar para SigCnFBl
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupFPags()
        LOCAL loc_cVal, loc_oLookup, loc_oErro
        TRY
            loc_cVal = ALLTRIM(NVL(THIS.txt_4c_FPags.Value, ""))

            IF USED("cursor_4c_BuscaFPags")
                USE IN cursor_4c_BuscaFPags
            ENDIF

            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCnFBl", ;
                "cursor_4c_BuscaFPags", ;
                "FPags", ;
                loc_cVal, ;
                "Sele" + CHR(231) + CHR(227) + "o")

            IF VARTYPE(loc_oLookup) = "O"
                loc_oLookup.mAddColuna("FPags",   "XXXXXXXXXXXX", "Condi" + CHR(231) + CHR(227) + "o")
                loc_oLookup.mAddColuna("cLocals", "",             "Local de Pagamento")
                loc_oLookup.Show()

                IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_BuscaFPags")
                    SELECT cursor_4c_BuscaFPags
                    THIS.txt_4c_FPags.Value = ALLTRIM(NVL(FPags, ""))
                    THIS.AtualizaBoleto(THIS.txt_4c_FPags.Value)
                ENDIF
                loc_oLookup.Release()
            ENDIF

            IF USED("cursor_4c_BuscaFPags")
                USE IN cursor_4c_BuscaFPags
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir busca de Condi" + CHR(231) + CHR(227) + "o")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdImprimirClick - Confirma e imprime boletos bancarios
    *--------------------------------------------------------------------------
    PROCEDURE CmdImprimirClick()
        LOCAL loc_lConfirmado, loc_lTemImpressora, loc_lSucesso
        LOCAL loc_cChave1, loc_nParcel, loc_nConta, loc_lTaOk
        LOCAL loc_cSQL, loc_nRet, loc_cFonteP, loc_cFonteG
        LOCAL loc_nTamFolha, loc_oErro, loc_laPrinters(1)

        IF !MsgConfirma("Confirma a Impress" + CHR(227) + "o do(s) Boleto(s) Banc" + CHR(225) + "rio(s)?")
            THIS.txt_4c_Locals.SetFocus()
            RETURN
        ENDIF

        THIS.LockScreen = .T.
        TRY
            *-- Salva cLocals e cTxtCds editados de volta em SigCnFBl
            IF !USED("cursor_4c_Config") OR RECCOUNT("cursor_4c_Config") = 0
                MsgAviso("Selecione uma Condi" + CHR(231) + CHR(227) + "o de Pagamento v" + ;
                         CHR(225) + "lida antes de imprimir.", "Aviso")
                THIS.LockScreen = .F.
                RETURN
            ENDIF

            SELECT cursor_4c_Config
            REPLACE cLocals WITH THIS.txt_4c_Locals.Value
            REPLACE cTxtCds WITH THIS.obj_4c_GetTxtCds.Value

            loc_cSQL = "UPDATE SigCnFBl SET" + ;
                       " cLocals = " + EscaparSQL(THIS.txt_4c_Locals.Value) + "," + ;
                       " cTxtCds = " + EscaparSQL(THIS.obj_4c_GetTxtCds.Value) + ;
                       " WHERE FPags = " + EscaparSQL(PADR(THIS.this_cFPagsSel, 12))
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet <= 0
                MsgAviso("Falha ao salvar. Favor reinicializar o processo.", "Falha na Conex" + CHR(227) + "o")
                THIS.LockScreen = .F.
                RETURN
            ENDIF

            *-- Verifica se ha impressora de boleto configurada
            loc_lTemImpressora = .F.
            IF APRINTERS(loc_laPrinters) > 0
                LOCAL loc_i
                SELECT cursor_4c_Config
                FOR loc_i = 1 TO ALEN(loc_laPrinters, 1)
                    IF UPPER(ALLTRIM(loc_laPrinters[loc_i, 1])) == UPPER(ALLTRIM(cursor_4c_Config.cNomeImps))
                        loc_lTemImpressora = .T.
                        EXIT
                    ENDIF
                ENDFOR
            ENDIF

            IF !loc_lTemImpressora
                MsgAviso("Nenhuma Impressora de Boleto Configurada ou Instalada.", "Aviso")
                THIS.LockScreen = .F.
                RETURN
            ENDIF

            *-- Carrega movimentos a imprimir
            IF !EMPTY(THIS.this_cChave1)
                SELECT TprMvCab
                ZAP
                INSERT INTO TprMvCab (Emps, Dopes, Numes) VALUES ;
                    (SUBSTR(THIS.this_cChave1, 1, 3), ;
                     SUBSTR(THIS.this_cChave1, 4, 20), ;
                     INT(VAL(SUBSTR(THIS.this_cChave1, 24, 6))))
            ENDIF

            *-- Cria cursor de dados do boleto (uma linha por parcela impressa)
            IF USED("Crdados")
                USE IN Crdados
            ENDIF
            SET NULL ON
            CREATE CURSOR Crdados ( ;
                clocal  C(100), ;
                vencs   C(12), ;
                datdoc  D, ;
                numdoc  C(8), ;
                valor   N(14,2), ;
                razaos  C(50), ;
                cpfs    C(20), ;
                endcobs C(80), ;
                baicobs C(20), ;
                cidcobs C(20), ;
                estcobs C(2), ;
                cepcobs C(9), ;
                texto   M ;
            )
            SET NULL OFF

            *-- Monta fontes de impressao a partir da configuracao
            SELECT cursor_4c_Config
            IF EMPTY(ALLTRIM(NVL(cursor_4c_Config.cFontePdrs, "")))
                loc_cFonteP = ""
                loc_cFonteG = ""
            ELSE
                IF NVL(cursor_4c_Config.nTamFontes, 0) = 0
                    loc_cFonteP = "Font '" + ALLTRIM(cursor_4c_Config.cFontePdrs) + "',9"
                    loc_cFonteG = "Font '" + ALLTRIM(cursor_4c_Config.cFontePdrs) + "',11"
                ELSE
                    loc_cFonteP = "Font '" + ALLTRIM(cursor_4c_Config.cFontePdrs) + "'," + ;
                                  ALLTRIM(STR(cursor_4c_Config.nTamFontes, 3))
                    loc_cFonteG = "Font '" + ALLTRIM(cursor_4c_Config.cFontePdrs) + "'," + ;
                                  ALLTRIM(STR(cursor_4c_Config.nTamFontes + 2, 3))
                ENDIF
            ENDIF
            loc_nTamFolha = VAL(ALLTRIM(SUBSTR(cursor_4c_Config.cTamFolha, ;
                                (AT("/", cursor_4c_Config.cTamFolha, 1) + 1), ;
                                (AT("/", cursor_4c_Config.cTamFolha, 2) - AT("/", cursor_4c_Config.cTamFolha, 1) - 1))))

            *-- Itera movimentos e gera dados de impressao
            SELECT TprMvCab
            GO TOP
            SCAN
                loc_cChave1 = TprMvCab.Emps + TprMvCab.Dopes + STR(TprMvCab.Numes, 6)
                loc_nParcel = NVL(TprMvCab.Parcs, 0)
                IF VARTYPE(loc_nParcel) != "N"
                    loc_nParcel = 0
                ENDIF

                *-- Busca cabecalho do movimento
                loc_cSQL = "SELECT TOP 1 Emps, Dopes, Numes, Contaos, Contads, Nfiscals" + ;
                           " FROM SigMvCab WHERE Emps + Dopes + CAST(Numes AS CHAR(6)) = " + ;
                           EscaparSQL(loc_cChave1)
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvCab")
                IF loc_nRet <= 0 OR !USED("cursor_4c_MvCab") OR RECCOUNT("cursor_4c_MvCab") = 0
                    MsgAviso("Esta Opera" + CHR(231) + CHR(227) + "o N" + CHR(227) + ;
                             "o Encontrou Movimenta" + CHR(231) + CHR(227) + "o.", "Aten" + CHR(231) + CHR(227) + "o")
                    IF USED("cursor_4c_MvCab")
                        USE IN cursor_4c_MvCab
                    ENDIF
                    LOOP
                ENDIF

                *-- Busca parcelas do movimento
                loc_cSQL = "SELECT Emps, Dopes, Numes, Parcs, Fpags, Vencs, Datas, Valos" + ;
                           " FROM SigMvPar WHERE Emps + Dopes + CAST(Numes AS CHAR(6)) = " + ;
                           EscaparSQL(loc_cChave1) + " ORDER BY Parcs"
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvPar")
                IF loc_nRet <= 0 OR !USED("cursor_4c_MvPar") OR RECCOUNT("cursor_4c_MvPar") = 0
                    MsgAviso("Nenhuma Forma de Pagamento Encontrada Nessa Opera" + CHR(231) + CHR(227) + "o.", "Aten" + CHR(231) + CHR(227) + "o")
                    IF USED("cursor_4c_MvPar")
                        USE IN cursor_4c_MvPar
                    ENDIF
                    IF USED("cursor_4c_MvCab")
                        USE IN cursor_4c_MvCab
                    ENDIF
                    LOOP
                ENDIF

                *-- Busca nota fiscal do movimento
                loc_cSQL = "SELECT TOP 1 NFis, Emps, Dopes, Numes" + ;
                           " FROM SigMvNfi WHERE Emps + Dopes + CAST(Numes AS CHAR(6)) = " + ;
                           EscaparSQL(loc_cChave1)
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvNfi")
                IF loc_nRet <= 0 OR !USED("cursor_4c_MvNfi") OR RECCOUNT("cursor_4c_MvNfi") = 0
                    MsgAviso("Esta Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                             "o possui Nota Fiscal Cadastrada.", "Aten" + CHR(231) + CHR(227) + "o")
                    IF USED("cursor_4c_MvNfi")
                        USE IN cursor_4c_MvNfi
                    ENDIF
                    IF USED("cursor_4c_MvPar")
                        USE IN cursor_4c_MvPar
                    ENDIF
                    IF USED("cursor_4c_MvCab")
                        USE IN cursor_4c_MvCab
                    ENDIF
                    LOOP
                ENDIF

                *-- Busca dados do cliente (conta de origem ou destino conforme tipo NF)
                SELECT cursor_4c_MvCab
                LOCAL loc_cContaCli
                loc_cContaCli = IIF(NVL(cursor_4c_MvCab.Nfiscals, 0) = 1, ;
                                    cursor_4c_MvCab.Contaos, cursor_4c_MvCab.Contads)
                loc_cSQL = "SELECT TOP 1 Iclis, Razaos, Cpfs," + ;
                           " Endes, EndCobs, Bairs, BaiCobs, Cidas, CidCobs," + ;
                           " Estas, EstCobs, Ceps, CepCobs" + ;
                           " FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cContaCli)
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cli")
                IF loc_nRet <= 0 OR !USED("cursor_4c_Cli") OR RECCOUNT("cursor_4c_Cli") = 0
                    IF USED("cursor_4c_Cli")
                        USE IN cursor_4c_Cli
                    ENDIF
                    IF USED("cursor_4c_MvNfi")
                        USE IN cursor_4c_MvNfi
                    ENDIF
                    IF USED("cursor_4c_MvPar")
                        USE IN cursor_4c_MvPar
                    ENDIF
                    IF USED("cursor_4c_MvCab")
                        USE IN cursor_4c_MvCab
                    ENDIF
                    LOOP
                ENDIF

                *-- Itera parcelas e insere dados para impressao
                SELECT cursor_4c_MvPar
                GO TOP
                SCAN
                    loc_lTaOk = .T.
                    IF loc_nParcel > 0
                        IF cursor_4c_MvPar.Parcs != loc_nParcel
                            loc_lTaOk = .F.
                        ENDIF
                    ENDIF

                    IF loc_lTaOk
                        *-- Verifica forma de pagamento habilita boleto
                        loc_cSQL = "SELECT TOP 1 Fpags, ImpBols, ImpNotas" + ;
                                   " FROM SigOpFp WHERE Fpags = " + ;
                                   EscaparSQL(cursor_4c_MvPar.Fpags)
                        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpFp")

                        IF loc_nRet > 0 AND USED("cursor_4c_OpFp") AND ;
                           RECCOUNT("cursor_4c_OpFp") > 0 AND cursor_4c_OpFp.ImpBols

                            *-- Cria cursor TmpImprime e indice de ordenacao
                            IF USED("TmpImprime")
                                USE IN TmpImprime
                            ENDIF
                            CREATE CURSOR TmpImprime ( ;
                                Linha    N(6,2), ;
                                Coluna   N(6,2), ;
                                Conteudo C(100), ;
                                Style    C(3), ;
                                fontname C(64), ;
                                fontsize I, ;
                                linesize N(6,2), ;
                                nheight  N(6,2) ;
                            )
                            INDEX ON (Linha * 1000000000) + (Coluna * 100) TAG Ordem

                            LOCAL loc_xVenc
                            SELECT cursor_4c_OpFp
                            IF NVL(cursor_4c_OpFp.ImpNotas, 0) = 1
                                SELECT cursor_4c_MvPar
                                loc_xVenc = DTOC(cursor_4c_MvPar.Vencs)
                            ELSE
                                SELECT cursor_4c_MvPar
                                loc_xVenc = ALLTRIM(NVL(cursor_4c_MvPar.FPags, ""))
                            ENDIF

                            SELECT cursor_4c_MvNfi
                            LOCAL loc_cNumDoc
                            loc_cNumDoc = ALLTRIM(NVL(cursor_4c_MvNfi.NFis, "")) + "-" + ;
                                          ALLTRIM(STR(NVL(cursor_4c_MvPar.Parcs, 0), 1))

                            SELECT cursor_4c_Cli
                            LOCAL loc_cEndCob, loc_cBaiCob, loc_cCidCob, loc_cEstCob, loc_cCepCob
                            loc_cEndCob = IIF(!EMPTY(ALLTRIM(NVL(cursor_4c_Cli.EndCobs, ""))), ;
                                              cursor_4c_Cli.EndCobs, cursor_4c_Cli.Endes)
                            loc_cBaiCob = IIF(!EMPTY(ALLTRIM(NVL(cursor_4c_Cli.BaiCobs, ""))), ;
                                              cursor_4c_Cli.BaiCobs, cursor_4c_Cli.Bairs)
                            loc_cCidCob = IIF(!EMPTY(ALLTRIM(NVL(cursor_4c_Cli.CidCobs, ""))), ;
                                              cursor_4c_Cli.CidCobs, cursor_4c_Cli.Cidas)
                            loc_cEstCob = IIF(!EMPTY(ALLTRIM(NVL(cursor_4c_Cli.EstCobs, ""))), ;
                                              cursor_4c_Cli.EstCobs, cursor_4c_Cli.Estas)
                            loc_cCepCob = IIF(!EMPTY(ALLTRIM(NVL(cursor_4c_Cli.CepCobs, ""))), ;
                                              cursor_4c_Cli.CepCobs, cursor_4c_Cli.Ceps)

                            SELECT cursor_4c_MvPar
                            SELECT Crdados
                            ZAP
                            SELECT cursor_4c_Config
                            INSERT INTO Crdados VALUES ( ;
                                cursor_4c_Config.cLocals, ;
                                m.loc_xVenc, ;
                                cursor_4c_MvPar.Datas, ;
                                m.loc_cNumDoc, ;
                                cursor_4c_MvPar.Valos, ;
                                cursor_4c_Cli.Razaos, ;
                                cursor_4c_Cli.Cpfs, ;
                                m.loc_cEndCob, ;
                                m.loc_cBaiCob, ;
                                m.loc_cCidCob, ;
                                m.loc_cEstCob, ;
                                m.loc_cCepCob, ;
                                THIS.obj_4c_GetTxtCds.Value ;
                            )

                            *-- Preenche TmpImprime com posicoes configuradas
                            SELECT cursor_4c_Config
                            THIS.GrDetalhe(cursor_4c_Config.nLnLocals,  cursor_4c_Config.nClLocals,  "Crdados.clocal",  "", 60, 1)
                            THIS.GrDetalhe(cursor_4c_Config.nLnDtVencs, cursor_4c_Config.nClDtVencs, "Crdados.Vencs",   "", 9,  1)
                            THIS.GrDetalhe(cursor_4c_Config.nLnDtDocs,  cursor_4c_Config.nClDtDocs,  "Dtoc(Crdados.Datdoc)", "", 9, 1)
                            THIS.GrDetalhe(cursor_4c_Config.nLnNrDocs,  cursor_4c_Config.nClNrDocs,  "Crdados.numdoc",  "", 9,  1)
                            THIS.GrDetalhe(cursor_4c_Config.nLnVlDocs,  cursor_4c_Config.nClVlDocs,  "Transform(CrDados.Valor,'@Z 999,999,999.99')", "", 15, 1)
                            THIS.GrDetalhe(cursor_4c_Config.nLnRazClis, cursor_4c_Config.nClRazClis, "AllTrim(Crdados.Razaos)",  "", 50, 1)
                            THIS.GrDetalhe(cursor_4c_Config.nLnCgcClis, cursor_4c_Config.nClCgcClis, "AllTrim(Crdados.Cpfs)",    "", 20, 1)
                            THIS.GrDetalhe(cursor_4c_Config.nLnEndCobs, cursor_4c_Config.nClEndCobs, "AllTrim(Crdados.EndCobs)", "", 80, 1)
                            THIS.GrDetalhe(cursor_4c_Config.nLnBaiCobs, cursor_4c_Config.nClBaiCobs, "AllTrim(Crdados.BaiCobs)", "", 20, 1)
                            THIS.GrDetalhe(cursor_4c_Config.nLnCidCobs, cursor_4c_Config.nClCidCobs, "AllTrim(Crdados.CidCobs)", "", 20, 1)
                            THIS.GrDetalhe(cursor_4c_Config.nLnEstCobs, cursor_4c_Config.nClEstCobs, "AllTrim(Crdados.EstCobs)", "", 2,  1)
                            THIS.GrDetalhe(cursor_4c_Config.nLnCepCobs, cursor_4c_Config.nClCepCobs, "AllTrim(Crdados.CepCobs)", "", 9,  1)
                            THIS.GrDetalhe(cursor_4c_Config.nLnTxtCds,  cursor_4c_Config.nClTxtCds,  "Crdados.texto",   "", 60, 6)

                            *-- Chama rotina de impressao matricial SigPrIbl.prg
                            DO SigPrIbl WITH "tmpimprime", ;
                                ALLTRIM(cursor_4c_Config.cNomeImps), ;
                                "to printer noconsole", ;
                                0, loc_nTamFolha, 0, 0, "crdados", 17
                        ENDIF
                        IF USED("cursor_4c_OpFp")
                            USE IN cursor_4c_OpFp
                        ENDIF
                    ENDIF
                ENDSCAN

                IF USED("cursor_4c_Cli")
                    USE IN cursor_4c_Cli
                ENDIF
                IF USED("cursor_4c_MvNfi")
                    USE IN cursor_4c_MvNfi
                ENDIF
                IF USED("cursor_4c_MvPar")
                    USE IN cursor_4c_MvPar
                ENDIF
                IF USED("cursor_4c_MvCab")
                    USE IN cursor_4c_MvCab
                ENDIF
            ENDSCAN

            *-- Reativa form pai e fecha
            THIS.LockScreen = .F.
            IF VARTYPE(THIS.this_xNform1) = "O" AND !ISNULL(THIS.this_xNform1)
                THIS.this_xNform1.Enabled = .T.
            ENDIF
            THIS.Release()
        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro ao Imprimir")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdSaidaClick - Confirma saida e fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE CmdSaidaClick()
        LOCAL loc_lPodeFechar, loc_oErro
        TRY
            IF !THIS.obj_4c_CmdGImprimir.Buttons(1).Enabled
                loc_lPodeFechar = .T.
            ELSE
                loc_lPodeFechar = MsgConfirma("Deseja Abandonar as Impress" + CHR(245) + "es do Boleto?")
            ENDIF

            IF loc_lPodeFechar
                IF VARTYPE(THIS.this_xNform1) = "O" AND !ISNULL(THIS.this_xNform1)
                    THIS.this_xNform1.Enabled = .T.
                ENDIF
                THIS.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao sair")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GrDetalhe - Insere linha de dados no cursor TmpImprime para impressao matricial
    *--------------------------------------------------------------------------
    PROCEDURE GrDetalhe(par_nLinha, par_nColuna, par_cDetalhe, par_cEstilo, par_nLineSize, par_nHeight)
        LOCAL loc_nLinha, loc_nColuna, loc_cDetalhe, loc_cEstilo, loc_oErro
        TRY
            loc_nLinha   = IIF(VARTYPE(par_nLinha)   = "N", par_nLinha,   0)
            loc_nColuna  = IIF(VARTYPE(par_nColuna)  = "N", par_nColuna,  0)
            loc_cDetalhe = IIF(VARTYPE(par_cDetalhe) = "C", par_cDetalhe, "")
            loc_cEstilo  = IIF(VARTYPE(par_cEstilo)  = "C", par_cEstilo,  "X")
            IF EMPTY(loc_cEstilo)
                loc_cEstilo = "X"
            ENDIF

            IF !(loc_cEstilo == "*") AND (loc_nColuna != 0 OR loc_nLinha != 0)
                IF USED("TmpImprime")
                    INSERT INTO TmpImprime (Linha, Coluna, Conteudo, Style, LineSize, NHeight) ;
                        VALUES (loc_nLinha, loc_nColuna, loc_cDetalhe, ;
                                ALLTRIM(loc_cEstilo), par_nLineSize, par_nHeight)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em GrDetalhe")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Ponto de entrada canonico do pipeline
    * Form OPERACIONAL de impressao de boleto: a acao "Incluir/Confirmar" eh a
    * propria impressao dos boletos bancarios. Delega para CmdImprimirClick, que
    * confirma, salva a config editada em SigCnFBl e envia os movimentos para
    * impressora matricial via SigPrIbl.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro
        TRY
            IF !THIS.obj_4c_CmdGImprimir.Buttons(1).Enabled
                MsgAviso("Selecione uma Condi" + CHR(231) + CHR(227) + "o de Pagamento v" + ;
                         CHR(225) + "lida antes de imprimir.", "Aviso")
                IF PEMSTATUS(THIS, "txt_4c_FPags", 5)
                    THIS.txt_4c_FPags.SetFocus()
                ENDIF
                RETURN
            ENDIF
            THIS.CmdImprimirClick()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em Incluir")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Ponto de entrada canonico do pipeline
    * Form OPERACIONAL: "Alterar" corresponde a recarregar a config do boleto
    * atualmente selecionado (SigCnFBl) e permitir edicao de Local de Pagamento
    * e Texto do Cedente. Se nenhum FPags esta selecionado, avisa o usuario.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oErro
        TRY
            IF EMPTY(THIS.this_cFPagsSel)
                MsgAviso("Selecione uma Condi" + CHR(231) + CHR(227) + "o de Pagamento antes de alterar.", "Aviso")
                IF PEMSTATUS(THIS, "txt_4c_FPags", 5)
                    THIS.txt_4c_FPags.SetFocus()
                ENDIF
                RETURN
            ENDIF
            THIS.AtualizaBoleto(THIS.this_cFPagsSel)
            IF PEMSTATUS(THIS, "txt_4c_Locals", 5) AND THIS.txt_4c_Locals.Enabled
                THIS.txt_4c_Locals.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em Alterar")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Ponto de entrada canonico do pipeline
    * Form OPERACIONAL: "Visualizar" abre o picker (FormBuscaAuxiliar) de
    * condicoes de pagamento cadastradas em SigCnFBl, permitindo o usuario
    * escolher qual boleto configurar.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro
        TRY
            THIS.AbrirLookupFPags()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em Visualizar")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Ponto de entrada canonico do pipeline
    * Form OPERACIONAL: "Excluir" limpa a selecao corrente (equivalente a
    * cancelar a configuracao ativa), desabilitando os campos e o botao
    * Imprimir. Nao afeta dados persistidos em SigCnFBl.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oErro
        TRY
            IF EMPTY(THIS.this_cFPagsSel)
                RETURN
            ENDIF
            IF !MsgConfirma("Deseja limpar a Condi" + CHR(231) + CHR(227) + "o de Pagamento selecionada?")
                RETURN
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_FPags", 5)
                THIS.txt_4c_FPags.Value = ""
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_Locals", 5)
                THIS.txt_4c_Locals.Value = ""
            ENDIF
            IF PEMSTATUS(THIS, "obj_4c_GetTxtCds", 5)
                THIS.obj_4c_GetTxtCds.Value = ""
            ENDIF
            THIS.AtualizaBoleto("")
            IF PEMSTATUS(THIS, "txt_4c_FPags", 5)
                THIS.txt_4c_FPags.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em Excluir")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos controles visiveis recursivamente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl, loc_oRef
        IF VARTYPE(par_oContainer) = "O"
            loc_oRef = par_oContainer
        ELSE
            loc_oRef = THIS
        ENDIF
        FOR loc_i = 1 TO loc_oRef.ControlCount
            loc_oControl = loc_oRef.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF INLIST(UPPER(loc_oControl.Name), "CNT_4C_CABECALHO")
                    IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControl)
                    ENDIF
                    LOOP
                ENDIF
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Abre lookup de condicoes de pagamento (SigCnFBl)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oErro
        TRY
            THIS.AbrirLookupFPags()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em Buscar")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario (confirma se impressao habilitada)
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        LOCAL loc_oErro
        TRY
            THIS.CmdSaidaClick()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao encerrar")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Salva alteracoes de Local e Texto Cedente em SigCnFBl
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_cSQL, loc_nRet, loc_oErro
        TRY
            IF !USED("cursor_4c_Config") OR RECCOUNT("cursor_4c_Config") = 0
                MsgAviso("Selecione uma Condi" + CHR(231) + CHR(227) + "o de Pagamento antes de salvar.", "Aviso")
                IF PEMSTATUS(THIS, "txt_4c_FPags", 5)
                    THIS.txt_4c_FPags.SetFocus()
                ENDIF
                RETURN
            ENDIF

            loc_cSQL = "UPDATE SigCnFBl SET" + ;
                       " cLocals = " + EscaparSQL(THIS.txt_4c_Locals.Value) + "," + ;
                       " cTxtCds = " + EscaparSQL(THIS.obj_4c_GetTxtCds.Value) + ;
                       " WHERE FPags = " + EscaparSQL(PADR(THIS.this_cFPagsSel, 12))
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet > 0
                MsgInfo("Dados salvos com sucesso.", "Salvo")
            ELSE
                MsgAviso("Falha ao salvar. Verifique a conex" + CHR(227) + "o.", "Aviso")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro ao Salvar")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela edicao corrente, restaura valores do banco
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        LOCAL loc_oErro
        TRY
            IF EMPTY(THIS.this_cFPagsSel)
                THIS.LimparCampos()
            ELSE
                THIS.AtualizaBoleto(THIS.this_cFPagsSel)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Cancelar")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Recarrega configuracao do boleto bancario atual
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            THIS.AtualizaBoleto(THIS.this_cFPagsSel)
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Carregar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Extrai valores do formulario para propriedades internas
    * (Form OPERACIONAL: nao usa BO CRUD; armazena em variaveis de estado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oErro
        TRY
            THIS.this_cFPagsSel = ALLTRIM(NVL(THIS.txt_4c_FPags.Value, ""))
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em FormParaBO")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Popula campos do formulario a partir do cursor de config
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oErro
        TRY
            IF USED("cursor_4c_Config") AND RECCOUNT("cursor_4c_Config") > 0
                SELECT cursor_4c_Config
                GO TOP
                IF PEMSTATUS(THIS, "txt_4c_FPags", 5)
                    THIS.txt_4c_FPags.Value = ALLTRIM(NVL(cursor_4c_Config.FPags, ""))
                ENDIF
                IF PEMSTATUS(THIS, "txt_4c_Locals", 5)
                    THIS.txt_4c_Locals.Value = NVL(cursor_4c_Config.cLocals, "")
                ENDIF
                IF PEMSTATUS(THIS, "obj_4c_GetTxtCds", 5)
                    THIS.obj_4c_GetTxtCds.Value = NVL(cursor_4c_Config.cTxtCds, "")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos conforme estado atual
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar, loc_oErro
        loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
        TRY
            IF PEMSTATUS(THIS, "txt_4c_Locals", 5)
                THIS.txt_4c_Locals.Enabled = loc_lHabilitar
            ENDIF
            IF PEMSTATUS(THIS, "obj_4c_GetTxtCds", 5)
                THIS.obj_4c_GetTxtCds.Enabled = loc_lHabilitar
            ENDIF
            IF PEMSTATUS(THIS, "obj_4c_CmdGImprimir", 5)
                THIS.obj_4c_CmdGImprimir.Buttons(1).Enabled = loc_lHabilitar
                IF !loc_lHabilitar
                    THIS.obj_4c_CmdGImprimir.Value = 2
                ENDIF
                THIS.obj_4c_CmdGImprimir.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa todos os campos do formulario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oErro
        TRY
            THIS.this_cFPagsSel = ""
            IF PEMSTATUS(THIS, "txt_4c_FPags", 5)
                THIS.txt_4c_FPags.Value = ""
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_Locals", 5)
                THIS.txt_4c_Locals.Value   = ""
                THIS.txt_4c_Locals.Enabled = .F.
            ENDIF
            IF PEMSTATUS(THIS, "obj_4c_GetTxtCds", 5)
                THIS.obj_4c_GetTxtCds.Value   = ""
                THIS.obj_4c_GetTxtCds.Enabled = .F.
            ENDIF
            IF PEMSTATUS(THIS, "lbl_4c_LblAviso", 5)
                THIS.lbl_4c_LblAviso.Visible = .T.
            ENDIF
            IF PEMSTATUS(THIS, "obj_4c_CmdGImprimir", 5)
                THIS.obj_4c_CmdGImprimir.Buttons(1).Enabled = .F.
                THIS.obj_4c_CmdGImprimir.Value = 2
                THIS.obj_4c_CmdGImprimir.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado do botao Imprimir conforme config
    * Form OPERACIONAL: o "modo" eh determinado por loc_lAchou em AtualizaBoleto
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo(par_cModo)
        LOCAL loc_lTemConfig, loc_oErro
        TRY
            loc_lTemConfig = USED("cursor_4c_Config") AND RECCOUNT("cursor_4c_Config") > 0
            THIS.HabilitarCampos(loc_lTemConfig)
            IF PEMSTATUS(THIS, "lbl_4c_LblAviso", 5)
                THIS.lbl_4c_LblAviso.Visible = !loc_lTemConfig
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos ao fechar o formulario
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_xNform1) = "O" AND !ISNULL(THIS.this_xNform1)
            THIS.this_xNform1.Enabled = .T.
        ENDIF

        IF USED("cursor_4c_Config")
            USE IN cursor_4c_Config
        ENDIF
        IF USED("cursor_4c_ConfigTemp")
            USE IN cursor_4c_ConfigTemp
        ENDIF
        IF USED("cursor_4c_BuscaFPags")
            USE IN cursor_4c_BuscaFPags
        ENDIF
        IF USED("Crdados")
            USE IN Crdados
        ENDIF
        IF USED("TmpImprime")
            USE IN TmpImprime
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
