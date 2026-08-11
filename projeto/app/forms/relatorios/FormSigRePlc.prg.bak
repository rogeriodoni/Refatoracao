*==============================================================================
* FORMSIGREPLC.PRG
* Formulario de Relatorio do Plano de Contas
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SigRePlc.SCX (frmrelatorio)
*==============================================================================

DEFINE CLASS FormSigRePlc AS FormBase

    *-- Propriedades visuais (EXATAS do original)
    Height      = 300
    Width       = 800
    DataSession = 2
    ShowWindow  = 1
    WindowType  = 1
    AutoCenter  = .T.
    BorderStyle = 2
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    ShowTips    = .T.
    BackColor   = RGB(192, 192, 192)

    *-- Propriedades customizadas
    this_cMensagemErro  = ""
    this_oRelatorio     = .NULL.

    *-- Guards para LostFocus (evitar processamento recursivo)
    this_lValidandoClasse  = .F.
    this_lValidandoDclasse = .F.

    *-- Ultimo valor validado (guard adicional: evita reprocessar valor identico)
    this_cUltimoClasseValidado  = ""
    this_cUltimoDclasseValidado = ""

    *==========================================================================
    * INICIALIZARFORM - Cria todos os controles visuais e inicializa dados
    *==========================================================================
    PROCEDURE InicializarForm
        LOCAL loc_lSucesso
        loc_lSucesso = .T.
        TRY
            *-- Caption com acentos
            THIS.Caption = "Relat" + CHR(243) + "rio do Plano de Contas"

            *-- Garantir variavel de icones
            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            IF TYPE("gc_4c_CaminhoReports") = "U"
                gc_4c_CaminhoReports = ""
            ENDIF

            *-- Instanciar BO
            THIS.this_oBusinessObject = CREATEOBJECT("SigRePlcBO")
            IF ISNULL(THIS.this_oBusinessObject)
                THIS.this_cMensagemErro = "Falha ao instanciar SigRePlcBO"
                loc_lSucesso = .F.
            ENDIF

            IF loc_lSucesso
                THIS.ConfigurarCabecalho()
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.ConfigurarCampos()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarEventos()

                *-- Carregar cursores auxiliares (SigCdPam, SigCdGcr, SigCdCli, cTpgc)
                IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                    *-- Modo de teste: pular carga do banco
                ELSE
                    IF NOT THIS.this_oBusinessObject.InicializarDados()
                        THIS.this_cMensagemErro = THIS.this_oBusinessObject.this_cMensagemErro
                        loc_lSucesso = .F.
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lSucesso
                *-- Valores iniciais dos campos de filtro
                THIS.txt_4c_Classe.Value  = SPACE(10)
                THIS.txt_4c_Dclasse.Value = SPACE(30)

                *-- Atualizar estado inicial (Dclasse habilitado quando Classe vazio)
                THIS.AtualizarEstadoCampos()

                *-- Foco inicial
                IF TYPE("THIS.txt_4c_Classe") = "O"
                    THIS.txt_4c_Classe.SetFocus()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ATUALIZARESTADOCONTROLES - Override para evitar logica CRUD
    *==========================================================================
    PROCEDURE AtualizarEstadoControles
        *-- Formulario de relatorio: nao aplica logica CRUD
        RETURN
    ENDPROC

    *==========================================================================
    * CONFIGURARCABECALHO - Container escuro + titulo (equivalente a cntSombra)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top        = 0
            .Left       = 0
            .Width      = THIS.Width
            .Height     = 80
            .BackColor  = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Top        = 25
            .Left       = 20
            .AutoSize  = .F.
            .Width     = THIS.Width
            .Height    = 30
            .Caption    = "Relat" + CHR(243) + "rio do Plano de Contas"
            .FontName   = "Tahoma"
            .FontSize   = 14
            .FontBold   = .T.
            .ForeColor  = RGB(255, 255, 255)
            .BackStyle  = 0
            .Visible    = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Visible = .T.
        THIS.cnt_4c_Cabecalho.Visible = .T.
    ENDPROC

    *==========================================================================
    * CONFIGURARCAMPOS - Campos de filtro com posicoes EXATAS do original
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCampos

        *-- Label "Classe :" - original: Top=149, Left=234
        THIS.AddObject("lbl_4c_Label6", "Label")
        WITH THIS.lbl_4c_Label6
            .Top        = 149
            .Left       = 234
            .AutoSize   = .T.
            .Caption    = "Classe :"
            .FontName   = "Tahoma"
            .FontSize   = 8
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Visible    = .T.
        ENDWITH

        *-- TextBox Classe - original: Top=144, Left=279, Width=79, Height=25
        THIS.AddObject("txt_4c_Classe", "TextBox")
        WITH THIS.txt_4c_Classe
            .Top            = 144
            .Left           = 279
            .Width          = 79
            .Height         = 25
            .FontName       = "Courier New"
            .Format         = "K!"
            .MaxLength      = 10
            .SpecialEffect  = 1
            .BorderColor    = RGB(100, 100, 100)
            .Value          = ""
            .TabIndex       = 1
            .Visible        = .T.
        ENDWITH

        *-- TextBox Descricao Classe - original: Top=144, Left=360, Width=219, Height=25
        THIS.AddObject("txt_4c_Dclasse", "TextBox")
        WITH THIS.txt_4c_Dclasse
            .Top            = 144
            .Left           = 360
            .Width          = 219
            .Height         = 25
            .FontName       = "Courier New"
            .Format         = "K"
            .MaxLength      = 30
            .SpecialEffect  = 1
            .BorderColor    = RGB(100, 100, 100)
            .Value          = ""
            .TabIndex       = 2
            .Visible        = .T.
        ENDWITH

        *-- Label "Cliente :" - original Say4: Top=175, Left=232
        THIS.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.lbl_4c_Label4
            .Top        = 175
            .Left       = 232
            .AutoSize   = .T.
            .Caption    = "Cliente :"
            .FontName   = "Tahoma"
            .FontSize   = 8
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Visible    = .T.
        ENDWITH

        *-- OptionGroup Cliente (Analitico/Sintetico) - original Opt_Cli: Top=169, Left=274
        THIS.AddObject("obj_4c_Opt_Cli", "OptionGroup")
        WITH THIS.obj_4c_Opt_Cli
            .ButtonCount    = 2
            .Top            = 169
            .Left           = 274
            .Width          = 153
            .Height         = 27
            .BackStyle      = 0
            .BorderStyle    = 0
            .Value          = 1
            .TabIndex       = 3

            .Option1.Caption    = "\<Anal" + CHR(237) + "tico"
            .Option1.FontName   = "Tahoma"
            .Option1.FontSize   = 8
            .Option1.BackStyle  = 0
            .Option1.ForeColor  = RGB(90, 90, 90)
            .Option1.Top        = 5
            .Option1.Left       = 5
            .Option1.Width      = 67
            .Option1.Height     = 17
            .Option1.Value      = 1

            .Option2.Caption    = "S\<int" + CHR(233) + "tico"
            .Option2.FontName   = "Tahoma"
            .Option2.FontSize   = 8
            .Option2.BackStyle  = 0
            .Option2.ForeColor  = RGB(90, 90, 90)
            .Option2.Top        = 5
            .Option2.Left       = 75
            .Option2.Width      = 69
            .Option2.Height     = 17

            .Visible = .T.
        ENDWITH

        *-- Label "Fornecedor:" - original Say1: Top=197, Left=213
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top        = 197
            .Left       = 213
            .AutoSize   = .T.
            .Caption    = "Fornecedor:"
            .FontName   = "Tahoma"
            .FontSize   = 8
            .BackStyle  = 0
            .ForeColor  = RGB(90, 90, 90)
            .Visible    = .T.
        ENDWITH

        *-- OptionGroup Fornecedor (Analitico/Sintetico) - original Opt_For: Top=191, Left=274
        THIS.AddObject("obj_4c_Opt_For", "OptionGroup")
        WITH THIS.obj_4c_Opt_For
            .ButtonCount    = 2
            .Top            = 191
            .Left           = 274
            .Width          = 153
            .Height         = 27
            .BackStyle      = 0
            .BorderStyle    = 0
            .Value          = 1
            .TabIndex       = 4

            .Option1.Caption    = "\<Anal" + CHR(237) + "tico"
            .Option1.FontName   = "Tahoma"
            .Option1.FontSize   = 8
            .Option1.BackStyle  = 0
            .Option1.ForeColor  = RGB(90, 90, 90)
            .Option1.Top        = 5
            .Option1.Left       = 5
            .Option1.Width      = 67
            .Option1.Height     = 17
            .Option1.Value      = 1

            .Option2.Caption    = "S\<int" + CHR(233) + "tico"
            .Option2.FontName   = "Tahoma"
            .Option2.FontSize   = 8
            .Option2.BackStyle  = 0
            .Option2.ForeColor  = RGB(90, 90, 90)
            .Option2.Top        = 5
            .Option2.Left       = 75
            .Option2.Width      = 69
            .Option2.Height     = 17

            .Visible = .T.
        ENDWITH

    ENDPROC

    *==========================================================================
    * CONFIGURARBOTOES - Container de botoes de relatorio (equivalente a btnReport)
    * Original: Left=527, Top=0, Width=276, Height=80
    * Botoes: Visualiza(5), Imprime(72), DocExcel(139), Sair(206)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes

        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = 0
            .Left          = 529
            .Width         = 273
            .Height        = 80
            .ButtonCount   = 4
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderColor   = RGB(136, 189, 188)
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        *-- Botao Visualizar - original: Visualiza.Left=5, Top=5
        WITH THIS.cmg_4c_Botoes.Buttons(1)
            .Top            = 5
            .Left           = 5
            .Width          = 65
            .Height         = 70
            .Caption        = "Visualizar"
            .FontName       = "Comic Sans MS"
            .FontBold       = .T.
            .FontItalic     = .T.
            .FontSize       = 8
            .Picture        = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
            .PicturePosition = 13
            .Themes         = .F.
            .BackColor      = RGB(255, 255, 255)
            .ForeColor      = RGB(90, 90, 90)
            .Visible        = .T.
        ENDWITH
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")

        *-- Botao Imprimir - original: Imprime.Left=72, Top=5
        WITH THIS.cmg_4c_Botoes.Buttons(2)
            .Top            = 5
            .Left           = 72
            .Width          = 65
            .Height         = 70
            .Caption        = "Imprimir"
            .FontName       = "Comic Sans MS"
            .FontBold       = .T.
            .FontItalic     = .T.
            .FontSize       = 8
            .Picture        = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
            .PicturePosition = 13
            .Themes         = .F.
            .BackColor      = RGB(255, 255, 255)
            .ForeColor      = RGB(90, 90, 90)
            .Visible        = .T.
        ENDWITH
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")

        *-- Botao Excel - original: DocExcel.Left=139, Top=5
        WITH THIS.cmg_4c_Botoes.Buttons(3)
            .Top            = 5
            .Left           = 139
            .Width          = 65
            .Height         = 70
            .Caption        = "\<Arquivos Email"
            .WordWrap        = .T.
            .FontName       = "Comic Sans MS"
            .FontBold       = .T.
            .FontItalic     = .T.
            .FontSize       = 8
            .Picture        = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
            .PicturePosition = 13
            .Themes         = .F.
            .BackColor      = RGB(255, 255, 255)
            .ForeColor      = RGB(90, 90, 90)
            .Visible        = .T.
        ENDWITH
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")

        *-- Botao Sair - original: Sair.Left=206, Top=5
        WITH THIS.cmg_4c_Botoes.Buttons(4)
            .Top            = 5
            .Left           = 206
            .Width          = 65
            .Height         = 70
            .Caption        = "Encerrar"
            .WordWrap        = .T.
            .FontName       = "Comic Sans MS"
            .FontBold       = .T.
            .FontItalic     = .T.
            .FontSize       = 8
            .Picture        = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
            .PicturePosition = 13
            .Themes         = .F.
            .BackColor      = RGB(255, 255, 255)
            .ForeColor      = RGB(90, 90, 90)
            .Visible        = .T.
        ENDWITH
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")
    ENDPROC

    *==========================================================================
    * CONFIGURAREVENTOS - BINDEVENT LostFocus para validacao dos campos de filtro
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarEventos
        BINDEVENT(THIS.txt_4c_Classe,  "KeyPress", THIS, "ValidarClasse")
        BINDEVENT(THIS.txt_4c_Dclasse, "KeyPress", THIS, "ValidarDclasse")
    ENDPROC

    *==========================================================================
    * ATUALIZARESTADOCAMPOS
    * Habilita/desabilita txt_4c_Dclasse conforme estado de txt_4c_Classe.
    * Equivalente ao evento When do getDclasse no legado:
    *   "Return Empty(ThisForm.getClasse.Value)"
    * Dclasse so fica habilitado quando Classe esta vazio.
    *==========================================================================
    PROCEDURE AtualizarEstadoCampos
        IF TYPE("THIS.txt_4c_Dclasse") = "O"
            THIS.txt_4c_Dclasse.Enabled = EMPTY(ALLTRIM(THIS.txt_4c_Classe.Value))
        ENDIF
    ENDPROC

    *==========================================================================
    * FORMPARARELATORIO - Transfere valores dos filtros do form para o BO
    *==========================================================================
    PROCEDURE FormParaRelatorio
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_cClasse  = ALLTRIM(THIS.txt_4c_Classe.Value)
            THIS.this_oBusinessObject.this_cDclasse = ALLTRIM(THIS.txt_4c_Dclasse.Value)
            THIS.this_oBusinessObject.this_nOptCli  = THIS.obj_4c_Opt_Cli.Value
            THIS.this_oBusinessObject.this_nOptFor  = THIS.obj_4c_Opt_For.Value
        ENDIF
    ENDPROC

    *==========================================================================
    * VALIDARFILTROS
    * Valida campos de filtro antes de gerar o relatorio.
    * Equivalente a parte do btnReport.Click do legado.
    * Retorna .T. se filtros estao OK, .F. se ha erro.
    *==========================================================================
    PROCEDURE ValidarFiltros
        LOCAL loc_lcClasse, loc_lcDclasse
        loc_lcClasse  = ALLTRIM(THIS.txt_4c_Classe.Value)
        loc_lcDclasse = ALLTRIM(THIS.txt_4c_Dclasse.Value)

        *-- Validar Classe se informada
        IF NOT EMPTY(loc_lcClasse)
            IF USED("cursor_4c_Tpgc")
                IF NOT SEEK("1" + loc_lcClasse, "cursor_4c_Tpgc", "Nclasses")
                    MsgErro("Classe Inv" + CHR(225) + "lida !")
                    THIS.txt_4c_Classe.SetFocus()
                    RETURN .F.
                ENDIF
            ENDIF
        ENDIF

        *-- Validar Descricao de Classe se informada
        IF NOT EMPTY(loc_lcDclasse)
            IF USED("cursor_4c_Tpgc")
                IF NOT SEEK("1" + loc_lcDclasse, "cursor_4c_Tpgc", "Ndescrs")
                    MsgErro("Descri" + CHR(231) + CHR(227) + "o de Classe Inv" + CHR(225) + "lida !")
                    THIS.txt_4c_Classe.SetFocus()
                    RETURN .F.
                ENDIF
            ENDIF
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * VALIDARCLASSE - Chamado via BINDEVENT LostFocus em txt_4c_Classe
    * Busca em cursor_4c_Tpgc por Classes. Se nao encontrado, abre lookup.
    * Se vazio, limpa txt_4c_Dclasse.
    *==========================================================================
    PROCEDURE ValidarClasse
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_cValor

        *-- Guard: evitar processamento recursivo
        IF THIS.this_lValidandoClasse
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(THIS.txt_4c_Classe.Value)

        *-- Guard: evitar reprocessar valor identico
        IF loc_cValor == THIS.this_cUltimoClasseValidado
            RETURN
        ENDIF
        THIS.this_cUltimoClasseValidado = loc_cValor

        THIS.this_lValidandoClasse = .T.
        TRY
            IF EMPTY(loc_cValor)
                *-- Classe vazia: limpar Dclasse e habilitar
                THIS.txt_4c_Dclasse.Value = SPACE(30)
                THIS.txt_4c_Dclasse.Refresh()
                THIS.AtualizarEstadoCampos()
            ELSE
                *-- Buscar em cursor_4c_Tpgc (ja carregado em memoria)
                IF USED("cursor_4c_Tpgc")
                    SELECT cursor_4c_Tpgc
                    SET ORDER TO Classes
                    IF SEEK(PADR(loc_cValor, 10), "cursor_4c_Tpgc", "Classes")
                        THIS.txt_4c_Classe.Value  = ALLTRIM(cursor_4c_Tpgc.Classes)
                        THIS.txt_4c_Dclasse.Value = cursor_4c_Tpgc.Descrs
                        THIS.txt_4c_Classe.Refresh()
                        THIS.txt_4c_Dclasse.Refresh()
                    ELSE
                        *-- Nao encontrado: abrir lookup
                        THIS.AbrirBuscaClasse()
                    ENDIF
                ELSE
                    THIS.AbrirBuscaClasse()
                ENDIF
                THIS.AtualizarEstadoCampos()
            ENDIF
        CATCH TO loc_oErro
            *-- Ignorar erros de foco durante validacao
        ENDTRY
        THIS.this_lValidandoClasse = .F.
    ENDPROC

    *==========================================================================
    * VALIDARDCLASSE - Chamado via BINDEVENT LostFocus em txt_4c_Dclasse
    * Busca reversa em cursor_4c_Tpgc por Descrs.
    * Se vazio, limpa txt_4c_Classe.
    * Se nao encontrado, abre lookup por descricao.
    *==========================================================================
    PROCEDURE ValidarDclasse
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_cValor

        *-- Guard: evitar processamento recursivo
        IF THIS.this_lValidandoDclasse
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(THIS.txt_4c_Dclasse.Value)

        *-- Guard: evitar reprocessar valor identico
        IF loc_cValor == THIS.this_cUltimoDclasseValidado
            RETURN
        ENDIF
        THIS.this_cUltimoDclasseValidado = loc_cValor

        THIS.this_lValidandoDclasse = .T.
        TRY
            IF EMPTY(loc_cValor)
                *-- Dclasse vazia: limpar Classe
                THIS.txt_4c_Classe.Value = SPACE(10)
                THIS.txt_4c_Classe.Refresh()
                THIS.this_cUltimoClasseValidado = ""
                THIS.AtualizarEstadoCampos()
            ELSE
                *-- Busca reversa por Descrs em cursor_4c_Tpgc (indice Ndescrs)
                IF USED("cursor_4c_Tpgc")
                    SELECT cursor_4c_Tpgc
                    SET ORDER TO Ndescrs
                    IF SEEK("1" + loc_cValor, "cursor_4c_Tpgc", "Ndescrs")
                        THIS.txt_4c_Classe.Value  = ALLTRIM(cursor_4c_Tpgc.Classes)
                        THIS.txt_4c_Dclasse.Value = cursor_4c_Tpgc.Descrs
                        THIS.txt_4c_Classe.Refresh()
                        THIS.txt_4c_Dclasse.Refresh()
                        THIS.this_cUltimoClasseValidado = ALLTRIM(cursor_4c_Tpgc.Classes)
                    ELSE
                        *-- Nao encontrado: abrir lookup por descricao
                        THIS.AbrirBuscaDclasse()
                    ENDIF
                ELSE
                    THIS.AbrirBuscaDclasse()
                ENDIF
                THIS.AtualizarEstadoCampos()
            ENDIF
        CATCH TO loc_oErro
            *-- Ignorar erros de foco durante validacao
        ENDTRY
        THIS.this_lValidandoDclasse = .F.
    ENDPROC

    *==========================================================================
    * ABRIRBUSCACLASSE - Lookup por Classes em SigCdCss (codigo do plano)
    * Equivalente ao fwBuscaExt em getClasse.Valid do legado
    *==========================================================================
    PROCEDURE AbrirBuscaClasse
        LOCAL loc_cValorAtual, loc_oBusca
        loc_cValorAtual = ALLTRIM(THIS.txt_4c_Classe.Value)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
            gnConnHandle, ;
            "SigCdCss", ;
            "cursor_4c_BuscaClasse", ;
            "Classes", ;
            loc_cValorAtual, ;
            "Busca de Classes", ;
            .F.)

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaClasse") AND RECCOUNT("cursor_4c_BuscaClasse") > 0
                    THIS.txt_4c_Classe.Value  = ALLTRIM(cursor_4c_BuscaClasse.Classes)
                    THIS.txt_4c_Dclasse.Value = cursor_4c_BuscaClasse.Descrs
                    THIS.txt_4c_Classe.Refresh()
                    THIS.txt_4c_Dclasse.Refresh()
                    THIS.this_cUltimoClasseValidado = ALLTRIM(cursor_4c_BuscaClasse.Classes)
                ENDIF
            ELSE
                IF loc_oBusca.this_lAchouRegistro OR EMPTY(loc_cValorAtual)
                    loc_oBusca.mAddColuna("Classes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClasse")
                        THIS.txt_4c_Classe.Value  = ALLTRIM(cursor_4c_BuscaClasse.Classes)
                        THIS.txt_4c_Dclasse.Value = cursor_4c_BuscaClasse.Descrs
                        THIS.txt_4c_Classe.Refresh()
                        THIS.txt_4c_Dclasse.Refresh()
                        THIS.this_cUltimoClasseValidado = ALLTRIM(cursor_4c_BuscaClasse.Classes)
                    ELSE
                        THIS.txt_4c_Classe.Value  = SPACE(10)
                        THIS.txt_4c_Dclasse.Value = SPACE(30)
                        THIS.this_cUltimoClasseValidado = ""
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaClasse")
            USE IN cursor_4c_BuscaClasse
        ENDIF
    ENDPROC

    *==========================================================================
    * ABRIRBUSCADCLASSE - Lookup por Descrs em SigCdCss (descricao do plano)
    * Equivalente ao fwBuscaExt em getDclasse.Valid do legado
    *==========================================================================
    PROCEDURE AbrirBuscaDclasse
        LOCAL loc_cValorAtual, loc_oBusca
        loc_cValorAtual = ALLTRIM(THIS.txt_4c_Dclasse.Value)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
            gnConnHandle, ;
            "SigCdCss", ;
            "cursor_4c_BuscaDclasse", ;
            "Descrs", ;
            loc_cValorAtual, ;
            "Busca por Descri" + CHR(231) + CHR(227) + "o", ;
            .F.)

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaDclasse") AND RECCOUNT("cursor_4c_BuscaDclasse") > 0
                    THIS.txt_4c_Classe.Value  = ALLTRIM(cursor_4c_BuscaDclasse.Classes)
                    THIS.txt_4c_Dclasse.Value = cursor_4c_BuscaDclasse.Descrs
                    THIS.txt_4c_Classe.Refresh()
                    THIS.txt_4c_Dclasse.Refresh()
                    THIS.this_cUltimoClasseValidado  = ALLTRIM(cursor_4c_BuscaDclasse.Classes)
                    THIS.this_cUltimoDclasseValidado = ALLTRIM(cursor_4c_BuscaDclasse.Descrs)
                ENDIF
            ELSE
                IF loc_oBusca.this_lAchouRegistro OR EMPTY(loc_cValorAtual)
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("Classes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDclasse")
                        THIS.txt_4c_Classe.Value  = ALLTRIM(cursor_4c_BuscaDclasse.Classes)
                        THIS.txt_4c_Dclasse.Value = cursor_4c_BuscaDclasse.Descrs
                        THIS.txt_4c_Classe.Refresh()
                        THIS.txt_4c_Dclasse.Refresh()
                        THIS.this_cUltimoClasseValidado  = ALLTRIM(cursor_4c_BuscaDclasse.Classes)
                        THIS.this_cUltimoDclasseValidado = ALLTRIM(cursor_4c_BuscaDclasse.Descrs)
                    ELSE
                        THIS.txt_4c_Dclasse.Value = SPACE(30)
                        THIS.this_cUltimoDclasseValidado = ""
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaDclasse")
            USE IN cursor_4c_BuscaDclasse
        ENDIF
    ENDPROC

    *==========================================================================
    * BTNVISUALIZARCLICK - Visualiza o relatorio na tela
    *==========================================================================
    *-- ============================================================
    *-- PROCEDURE ExecutarReportForm (Pattern #117)
    *-- Executa REPORT FORM apenas se o FRX existir; caso contrario,
    *-- exibe MostrarErro descritivo com o path faltante.
    *-- Isola SET POINT/SEPARATOR/REPORTBEHAVIOR durante o REPORT FORM
    *-- porque FRXs legados Fortyus (VFP6/7/8) foram desenhados com
    *-- POINT="." + REPORTBEHAVIOR 80. Sem isolamento o modo 90 remede
    *-- fontes em runtime e mostra asteriscos em campos numericos.
    *-- par_cModo: "PREVIEW" | "PRINTER_PROMPT" | "PRINTER"
    *-- ============================================================
    PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
        LOCAL loc_cFRX
        loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")

        IF NOT FILE(loc_cFRX)
            MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + ;
                loc_cFRX + CHR(13) + CHR(13) + ;
                "O FRX legado ainda n" + CHR(227) + "o foi portado para o novo sistema.", "Erro")
            RETURN .F.
        ENDIF

        *-- Guard cursor vazio: evita preview em branco / impressao vazia (Erro30)
        IF VARTYPE(par_cCursorDados) == "C" AND !EMPTY(par_cCursorDados)
            IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
                MsgAviso("Nenhum registro encontrado com os filtros informados.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                RETURN .F.
            ENDIF
        ENDIF


        *-- Isolamento de locale + modo de renderizacao (Pattern #117 / Erro28)
        LOCAL loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig
        loc_cPointOrig    = SET("POINT")
        loc_cSepOrig      = SET("SEPARATOR")
        loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
        SET POINT TO "."
        SET SEPARATOR TO ","
        SET REPORTBEHAVIOR 80

        DO CASE
            CASE par_cModo == "PREVIEW"
                REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
            CASE par_cModo == "PRINTER_PROMPT"
                REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
            CASE par_cModo == "PRINTER"
                REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
        ENDCASE

        SET POINT TO (loc_cPointOrig)
        SET SEPARATOR TO (loc_cSepOrig)
        SET REPORTBEHAVIOR (loc_nBehaviorOrig)

        RETURN .T.
    ENDPROC

    PROCEDURE BtnVisualizarClick

        IF THIS.ValidarFiltros()
            THIS.FormParaRelatorio()
            IF THIS.this_oBusinessObject.PrepararDados()
                IF FILE(loc_cArquivoFRX)
                    THIS.ExecutarReportForm("relplanocontas", "PREVIEW", THIS.this_oBusinessObject.this_cCursorDados)
                ELSE
                    MsgErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + ;
                            CHR(13) + loc_cArquivoFRX)
                ENDIF
                IF USED("cursor_4c_PlConta")
                    USE IN cursor_4c_PlConta
                ENDIF
            ELSE
                MsgErro("Erro ao processar relat" + CHR(243) + "rio:" + CHR(13) + ;
                        THIS.this_oBusinessObject.this_cMensagemErro)
            ENDIF
        ENDIF

        THIS.Refresh()
    ENDPROC

    *==========================================================================
    * BTNIMPRIMIRCLICK - Imprime o relatorio
    *==========================================================================
    PROCEDURE BtnImprimirClick

        IF THIS.ValidarFiltros()
            THIS.FormParaRelatorio()
            IF THIS.this_oBusinessObject.PrepararDados()
                IF FILE(loc_cArquivoFRX)
                    THIS.ExecutarReportForm("relplanocontas", "PRINTER_PROMPT", THIS.this_oBusinessObject.this_cCursorDados)
                ELSE
                    MsgErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + ;
                            CHR(13) + loc_cArquivoFRX)
                ENDIF
                IF USED("cursor_4c_PlConta")
                    USE IN cursor_4c_PlConta
                ENDIF
            ELSE
                MsgErro("Erro ao processar relat" + CHR(243) + "rio:" + CHR(13) + ;
                        THIS.this_oBusinessObject.this_cMensagemErro)
            ENDIF
        ENDIF

        THIS.Refresh()
    ENDPROC

    *==========================================================================
    * BTNEXCELCLICK - Exporta para Excel
    *==========================================================================
    PROCEDURE BtnExcelClick
        LOCAL loc_cArquivo

        IF THIS.ValidarFiltros()
            THIS.FormParaRelatorio()
            IF THIS.this_oBusinessObject.PrepararDados()
                *-- Exportar para arquivo temporario com timestamp
                loc_cArquivo = ADDBS(SYS(2023)) + "PlanoContas_" + ;
                              DTOS(DATE()) + "_" + STRTRAN(TIME(), ":", "") + ".xls"

                IF USED("cursor_4c_PlConta")
                    SELECT cursor_4c_PlConta
                    COPY TO (loc_cArquivo) TYPE XLS

                    IF FILE(loc_cArquivo)
                        DECLARE INTEGER ShellExecute IN shell32.dll ;
                            INTEGER hndWin, STRING cAction, STRING cFileName, ;
                            STRING cParams, STRING cDir, INTEGER nShowWin
                        ShellExecute(0, "open", loc_cArquivo, "", "", 1)
                        MsgInfo("Arquivo exportado para:" + CHR(13) + loc_cArquivo)
                    ELSE
                        MsgErro("Erro ao exportar para Excel.")
                    ENDIF

                    USE IN cursor_4c_PlConta
                ELSE
                    MsgErro("Sem dados para exportar.")
                ENDIF
            ELSE
                MsgErro("Erro ao processar relat" + CHR(243) + "rio:" + CHR(13) + ;
                        THIS.this_oBusinessObject.this_cMensagemErro)
            ENDIF
        ENDIF

        THIS.Refresh()
    ENDPROC

    *==========================================================================
    * BTNSAIRCLICK - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnSairClick
        THIS.Release()
    ENDPROC

    *==========================================================================
    * DESTROY - Limpeza de recursos
    *==========================================================================
    PROCEDURE Destroy
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
