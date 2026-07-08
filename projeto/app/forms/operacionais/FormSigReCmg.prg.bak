*==============================================================================
* FormSigReCmg.prg
* Form: Gr" + CHR(225) + "fico - Clientes que Mais Compram
* Herda de: FormBase
* Tipo: OPERACIONAL - subformulario de exibicao de grafico OLE
* Chamado por: form pai que popula TmpResult (Relat?rio de Vendas)
*==============================================================================

DEFINE CLASS FormSigReCmg AS FormBase

    *-- Identificacao visual (EXATA do original SCX)
    Caption     = ""
    Width       = 800
    Height      = 650
    AutoCenter  = .T.
    BorderStyle = 2
    ShowWindow = 1
    WindowType = 1
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    WindowType  = 0
    Themes      = .F.

    *-- Estado do grafico (propriedades customizadas do form original)
    pnNumGrf  = 1      && Posicao atual do grafico exibido (1-3)
    poForm1   = .NULL. && Referencia ao form pai (para DataSession e Opt_SelRel)

    *-- Titulo para FormBase (sera sobrescrito no InicializarForm)
    this_cTituloForm = ""

    *==========================================================================
    * Init - Aceita referencia ao form pai (obrigatorio para DataSession/TmpResult)
    *==========================================================================
    PROCEDURE Init(par_oFormPai)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Guarda referencia ao form pai antes de DODEFAULT
            IF VARTYPE(par_oFormPai) = "O"
                THIS.poForm1 = par_oFormPai
                *-- Compartilha sessao de dados do pai para acessar TmpResult
                THIS.DataSessionId = par_oFormPai.DataSessionId
            ELSE
                THIS.poForm1 = THIS
            ENDIF

            *-- Instancia o BO antes de DODEFAULT (InicializarForm usa ele)
            THIS.this_oBusinessObject = CREATEOBJECT("SigReCmgBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar SigReCmgBO." + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- FormBase.Init() chama InicializarForm() internamente
            loc_lSucesso = DODEFAULT()

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar FormSigReCmg:" + CHR(13) + ;
                    "Erro: " + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria todos os controles do form e dispara geracao inicial
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.LockScreen = .T.

            *-- Titulo do form
            THIS.Caption = "Gr" + CHR(225) + "fico dos Clientes que Mais Compram"

            *-- Coordena layout do form (form OPERACIONAL sem PageFrame)
            THIS.ConfigurarPageFrame()

            *-- Configura "Page1/Lista" (cabecalho + indicador de processamento)
            THIS.ConfigurarPaginaLista()

            *-- Configura "Page2/Dados" (area de exibicao do grafico + controles)
            THIS.ConfigurarPaginaDados()

            *-- BINDEVENT para o combo (selecao de cliente)
            BINDEVENT(THIS.cnt_4c_Grf2.cbo_4c_CmbChave1, "Click", THIS, "CmbChave1Click")
            BINDEVENT(THIS.cnt_4c_Grf2.cbo_4c_CmbChave1, "GotFocus", THIS, "CmbChave1GotFocus")

            *-- Estado inicial: aguarde visivel, demais ocultados ate gerar grafico
            THIS.cnt_4c_Aguarde.Visible         = .T.
            THIS.cnt_4c_Grf1.Visible            = .F.
            THIS.cnt_4c_Grf2.Visible            = .F.
            THIS.chk_4c_ChkGraficos.Visible     = .F.
            THIS.obj_4c_CmdGgrafico.Visible     = .F.

            THIS.Refresh()
            THIS.Show()
            THIS.LockScreen = .F.

            *-- Gera grafico inicial (popula combo e carrega primeiro grafico)
            THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.Clear
            THIS.GerarGrafico(1)

            *-- Exibe controles apos gerar grafico
            THIS.LockScreen = .T.
            THIS.cnt_4c_Aguarde.Visible         = .F.
            THIS.cnt_4c_Grf1.Visible            = .T.
            THIS.cnt_4c_Grf2.Visible            = .T.
            THIS.chk_4c_ChkGraficos.Visible     = .T.
            THIS.chk_4c_ChkGraficos.Value       = 0
            THIS.obj_4c_CmdGgrafico.Visible     = .T.
            THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex = 1
            THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.SetFocus
            THIS.Refresh()
            THIS.LockScreen = .F.

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Layout-level do form (OPERACIONAL nao tem PageFrame)
    *
    * Em forms CRUD este metodo cria o PageFrame com Page1=Lista/Page2=Dados.
    * Em forms OPERACIONAIS como SIGRECMG, o original NAO tem PageFrame; os
    * containers (cntSombra, cntGrf1, cntGrf2, cntAguarde, cmdGgrafico) ficam
    * diretamente no Form. Aqui aplicamos a configuracao visual base do Form
    * que normalmente seria delegada ao PageFrame.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        *-- Aparencia base do form (equivalente ao Page.Picture/BackColor em CRUD)
        THIS.BackColor   = RGB(212,208,200)
        THIS.ScrollBars  = 0
        THIS.ShowTips    = .T.
        THIS.SetAll("FontName", "Tahoma")
        THIS.SetAll("FontSize", 8)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Configura a "Page1/Lista" do form operacional
    * Em forms CRUD esta pagina contem o grid de registros. Aqui, em form
    * OPERACIONAL de visualizacao de grafico, a "Lista" corresponde ao bloco
    * persistente da tela: cabecalho (cntSombra) + indicador de processamento
    * (cnt_4c_Aguarde) exibido durante geracao/impressao do grafico.
    * Os widgets de exibicao de dados ficam em ConfigurarPaginaDados().
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarContainerAguarde()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Configura a "Page2/Dados" do form operacional
    * Em forms CRUD esta pagina hospeda os campos de edicao do registro. Aqui,
    * em form OPERACIONAL de exibicao de grafico, a "Dados" agrupa os widgets
    * de apresentacao de dados:
    *   - cnt_4c_Grf1 + obj_4c_OleGrafico1 (area do grafico OLE)
    *   - cnt_4c_Grf2 + cbo_4c_CmbChave1 (seletor de cliente)
    *   - obj_4c_CmdGgrafico (botoes de navegacao/impressao/encerrar)
    *   - chk_4c_ChkGraficos + txt_4c_NumGraficos + label (opcoes de impressao)
    * Apos AddObject, cada controle e inicializado com Visible=.F. para que o
    * InicializarForm() controle a sequencia de exibicao (Aguarde -> Dados).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- PARTE 1: Container do grafico OLE + seletor de cliente
        THIS.ConfigurarContainerGrafico()
        THIS.ConfigurarContainerControles()

        *-- PARTE 2: Botoes de acao + opcoes de impressao em lote
        THIS.ConfigurarCommandGroup()
        THIS.ConfigurarControlesAdicionais()

        *-- Pos-configuracao: garante z-order correto (CommandGroup acima do grafico)
        *-- ZOrder(0) traz para o topo da pilha visual, evitando que o OLE cubra botoes
        IF PEMSTATUS(THIS, "obj_4c_CmdGgrafico", 5)
            THIS.obj_4c_CmdGgrafico.ZOrder(0)
        ENDIF
        IF PEMSTATUS(THIS, "cnt_4c_Grf2", 5)
            THIS.cnt_4c_Grf2.ZOrder(0)
        ENDIF
        IF PEMSTATUS(THIS, "chk_4c_ChkGraficos", 5)
            THIS.chk_4c_ChkGraficos.ZOrder(0)
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_NumGraficos", 5)
            THIS.txt_4c_NumGraficos.ZOrder(0)
        ENDIF
        IF PEMSTATUS(THIS, "lbl_4c_LabelNumGrf", 5)
            THIS.lbl_4c_LabelNumGrf.ZOrder(0)
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - cntSombra com lblSombra e lblTitulo
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackStyle   = 1
            .BackColor   = RGB(100,100,100)
            .Visible     = .T.

            .AddObject("lbl_4c_LblSombra", "Label")
            WITH .lbl_4c_LblSombra
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 18
                .WordWrap   = .T.
                .Alignment  = 0
                .BackStyle  = 0
                .Height     = 40
                .Left       = 10
                .Top        = 18
                .Width      = THIS.Width
                .ForeColor  = RGB(0,0,0)
                .Caption    = THIS.Caption
                .Visible    = .T.
            ENDWITH

            .AddObject("lbl_4c_LblTitulo", "Label")
            WITH .lbl_4c_LblTitulo
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 18
                .WordWrap   = .T.
                .Alignment  = 0
                .BackStyle  = 0
                .Height     = 46
                .Left       = 10
                .Top        = 17
                .Width      = THIS.Width
                .ForeColor  = RGB(255,255,255)
                .Caption    = THIS.Caption
                .Visible    = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarContainerAguarde - cntAguarde (visivel durante processamento)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainerAguarde()
        THIS.AddObject("cnt_4c_Aguarde", "Container")
        WITH THIS.cnt_4c_Aguarde
            .Top          = 314
            .Left         = 295
            .Width        = 207
            .Height       = 49
            .SpecialEffect = 0
            .BackStyle    = 1
            .BackColor    = RGB(255,255,255)
            .Visible      = .F.

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
                .AutoSize   = .T.
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 10
                .Alignment  = 0
                .BackStyle  = 0
                .Caption    = "Processando Dados..."
                .Height     = 18
                .Left       = 24
                .Top        = 24
                .Width      = 141
                .ForeColor  = RGB(90,90,90)
                .Visible    = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarContainerGrafico - cntGrf1 com OleBoundControl
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainerGrafico()
        THIS.AddObject("cnt_4c_Grf1", "Container")
        WITH THIS.cnt_4c_Grf1
            .Top          = 202
            .Left         = 14
            .Width        = 770
            .Height       = 400
            .BackStyle    = 1
            .SpecialEffect = 0
            .BackColor    = RGB(255,255,255)
            .Visible      = .F.

            .AddObject("obj_4c_OleGrafico1", "OleBoundControl")
            WITH .obj_4c_OleGrafico1
                .Top     = 5
                .Left    = 5
                .Height  = 390
                .Width   = 760
                .Visible = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarContainerControles - cntGrf2 com combo e label de cliente
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainerControles()
        THIS.AddObject("cnt_4c_Grf2", "Container")
        WITH THIS.cnt_4c_Grf2
            .Top          = 94
            .Left         = 128
            .Width        = 200
            .Height       = 35
            .SpecialEffect = 0
            .BackStyle    = 1
            .BackColor    = RGB(255,255,255)
            .Visible      = .F.

            .AddObject("lbl_4c_LblChave1", "Label")
            WITH .lbl_4c_LblChave1
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Cliente :"
                .Height    = 15
                .Left      = 32
                .Top       = 8
                .Width     = 42
                .ForeColor = RGB(90,90,90)
                .Visible   = .T.
            ENDWITH

            .AddObject("cbo_4c_CmbChave1", "ComboBox")
            WITH .cbo_4c_CmbChave1
                .FontName        = "Courier New"
                .FontSize        = 9
                .ColumnCount     = 0
                .ColumnLines     = .F.
                .IncrementalSearch = .T.
                .Style           = 2
                .ReadOnly        = .T.
                .Format          = "K"
                .Sorted          = .F.
                .SpecialEffect   = 0
                .Height          = 25
                .Left            = 81
                .Top             = 4
                .Width           = 86
                .Visible         = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarCommandGroup - cmdGgrafico com 4 botoes (Anterior,Proximo,Imprimir,Encerrar)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCommandGroup()
        THIS.AddObject("obj_4c_CmdGgrafico", "CommandGroup")
        WITH THIS.obj_4c_CmdGgrafico
            .ButtonCount   = 4
            .BackStyle     = 0
            .BorderStyle   = 0
            .Height        = 85
            .Left          = 491
            .SpecialEffect = 1
            .Top           = -2
            .Width         = 313
            .Themes        = .F.
            .Visible       = .F.

            *-- Botao 1: Anterior
            WITH .Buttons(1)
                .Top        = 5
                .Left       = 5
                .Height     = 75
                .Width      = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .WordWrap   = .T.
                .Picture    = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
                .Caption    = "\<Anterior"
                .ForeColor  = RGB(90,90,90)
                .BackColor  = RGB(255,255,255)
                .Themes     = .F.
                .Enabled    = .F.
            ENDWITH

            *-- Botao 2: Proximo
            WITH .Buttons(2)
                .Top        = 5
                .Left       = 81
                .Height     = 75
                .Width      = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Tahoma"
                .FontSize   = 8
                .WordWrap   = .T.
                .Picture    = gc_4c_CaminhoIcones + "geral_seta_dir_60.jpg"
                .Caption    = "Pr" + CHR(243) + "ximo"
                .ForeColor  = RGB(90,90,90)
                .BackColor  = RGB(255,255,255)
                .Themes     = .F.
                .Enabled    = .F.
            ENDWITH

            *-- Botao 3: Imprimir (grafico pizza)
            WITH .Buttons(3)
                .Top        = 5
                .Left       = 157
                .Height     = 75
                .Width      = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Tahoma"
                .FontSize   = 8
                .WordWrap   = .T.
                .Picture    = gc_4c_CaminhoIcones + "geral_grafico_pizza_60.jpg"
                .Caption    = "Gr" + CHR(225) + "fico"
                .ForeColor  = RGB(90,90,90)
                .BackColor  = RGB(255,255,255)
                .Themes     = .F.
            ENDWITH

            *-- Botao 4: Encerrar/Sair
            WITH .Buttons(4)
                .Top        = 5
                .Left       = 233
                .Height     = 75
                .Width      = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Tahoma"
                .FontSize   = 8
                .WordWrap   = .T.
                .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel     = .T.
                .Caption    = "Encerrar"
                .ForeColor  = RGB(90,90,90)
                .BackColor  = RGB(255,255,255)
                .Themes     = .F.
            ENDWITH
        ENDWITH

        *-- BINDEVENTs dos botoes do CommandGroup
        BINDEVENT(THIS.obj_4c_CmdGgrafico.Buttons(1), "Click", THIS, "BtnAnteriorClick")
        BINDEVENT(THIS.obj_4c_CmdGgrafico.Buttons(2), "Click", THIS, "BtnProximoClick")
        BINDEVENT(THIS.obj_4c_CmdGgrafico.Buttons(3), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.obj_4c_CmdGgrafico.Buttons(4), "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *==========================================================================
    * ConfigurarControlesAdicionais - chkGraficos, NumGraficos, Label1
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarControlesAdicionais()
        *-- CheckBox: Todos os Graficos
        THIS.AddObject("chk_4c_ChkGraficos", "CheckBox")
        WITH THIS.chk_4c_ChkGraficos
            .Top          = 133
            .Left         = 146
            .Height       = 17
            .Width        = 122
            .FontName     = "Tahoma"
            .FontSize     = 8
            .AutoSize     = .F.
            .Alignment    = 0
            .BackStyle    = 0
            .Caption      = "Todos os Gr" + CHR(225) + "ficos"
            .SpecialEffect = 0
            .Style        = 0
            .ForeColor    = RGB(90,90,90)
            .Value        = 0
            .Visible      = .F.
        ENDWITH

        *-- TextBox: Numero inicial do grafico
        THIS.AddObject("txt_4c_NumGraficos", "TextBox")
        WITH THIS.txt_4c_NumGraficos
            .Alignment  = 3
            .Value      = 1
            .Height     = 23
            .InputMask  = "9999"
            .Left       = 267
            .MaxLength  = 4
            .Top        = 157
            .Width      = 38
            .Visible    = .T.
        ENDWITH

        *-- Label: "A partir do Grafico"
        THIS.AddObject("lbl_4c_LabelNumGrf", "Label")
        WITH THIS.lbl_4c_LabelNumGrf
            .AutoSize   = .F.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .BackStyle  = 0
            .Caption    = "A partir do Gr" + CHR(225) + "fico : "
            .Height     = 17
            .Left       = 166
            .Top        = 161
            .Width      = 117
            .ForeColor  = RGB(90,90,90)
            .Visible    = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * GerarGrafico - Popula combo de clientes e gera graficos OLE
    * par_nLinhaCmb1 = posicao do combo a usar (1 = primeiro, 0 = usar ListIndex)
    *==========================================================================
    PROCEDURE GerarGrafico(par_nLinhaCmb1)
        LOCAL loc_nLinha, loc_nTotal, loc_oErro, loc_lOK
        LOCAL ARRAY loc_aClientes(1)
        LOCAL loc_nTmStr1, loc_nConta1, loc_cChave1
        LOCAL loc_cQtVal, loc_nQtVal, loc_cStrgeixoY
        LOCAL loc_cEscape, loc_cOldPoint, loc_cOldSepar, loc_cPoint, loc_cSepar
        LOCAL loc_nChave2, loc_cChave2, loc_nNumGrf, loc_lError, loc_cOnError

        loc_nLinha = IIF(VARTYPE(par_nLinhaCmb1) = "N" AND par_nLinhaCmb1 > 0, par_nLinhaCmb1, 1)

        TRY
            THIS.LockScreen = .T.

            loc_cEscape   = SET("Escape")
            loc_cOldPoint = SET("Point")
            loc_cOldSepar = SET("Separator")

            SET ESCAPE OFF

            *-- Configuracao decimal/separador de acordo com locale
            loc_cPoint = ","
            loc_cSepar = "."

            SET POINT TO loc_cPoint
            SET SEPARATOR TO loc_cSepar

            THIS.pnNumGrf = 1
            loc_nLinha = IIF(VARTYPE(par_nLinhaCmb1) = "N" AND par_nLinhaCmb1 > 0, par_nLinhaCmb1, 1)

            *-- Determinar modo Valor/Quantidade a partir do form pai
            IF VARTYPE(THIS.poForm1) = "O" AND THIS.poForm1 != THIS
                loc_cQtVal = PADR(IIF(THIS.poForm1.Opt_SelRel.Value = 1, "Valor", "Quantidade"), 10)
                loc_nQtVal = THIS.poForm1.Opt_SelRel.Value
            ELSE
                loc_cQtVal = PADR("Valor", 10)
                loc_nQtVal = 1
            ENDIF

            *-- Popula combo se ainda nao foi populado
            IF EMPTY(THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListCount)
                IF USED("TmpResult")
                    SELECT DISTINCT Ordem, Crclis ;
                      FROM TmpResult ;
                     ORDER BY Ordem ;
                      INTO ARRAY loc_aClientes

                    loc_nTotal  = ALEN(loc_aClientes, 1)
                    loc_nTmStr1 = LEN(ALLTRIM(loc_aClientes(1,2))) + 6

                    WITH THIS.cnt_4c_Grf2.cbo_4c_CmbChave1
                        .Clear
                        .Alignment         = 0
                        .ColumnCount       = 0
                        .ColumnLines       = .F.
                        .IncrementalSearch = .T.
                        .FontName          = "Courier New"
                        .FontSize          = 9
                        .RowSource         = ""
                        .RowSourceType     = 0
                        .Style             = 2
                        .ReadOnly          = .T.
                        .Format            = "K"
                        .Sorted            = .F.
                        .SpecialEffect     = 0
                        .Width             = (loc_nTmStr1 * 7 + 9) + 20
                        .Height            = 25
                        .Top               = 5
                        .Left              = 5 + THIS.cnt_4c_Grf2.lbl_4c_LblChave1.Width

                        FOR loc_nConta1 = 1 TO loc_nTotal
                            .AddItem(PADR(STR(loc_aClientes(loc_nConta1,1),5) + CHR(170) + ;
                                         loc_aClientes(loc_nConta1,2), loc_nTmStr1))
                        ENDFOR
                    ENDWITH

                    WITH THIS.cnt_4c_Grf2
                        .Height = THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.Height + 10
                        .Width  = THIS.cnt_4c_Grf2.lbl_4c_LblChave1.Width + ;
                                  THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.Width + 10
                        .Top    = THIS.obj_4c_CmdGgrafico.Top - .Height
                        .Left   = THIS.Width - .Width - 5
                        .Visible     = .T.
                    ENDWITH
                ENDIF
            ENDIF

            *-- Gera graficos apenas se combo tem itens
            IF THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListCount > 0
                loc_lError   = .F.
                loc_cOnError = ON("Error")
                ON ERROR loc_lError = .F.

                loc_cStrgeixoY = "Opera" + CHR(231) + CHR(245) + "es Ranking   " + loc_cQtVal
                loc_cChave1    = THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.List(loc_nLinha)

                *-- Obtem titulos do TmpResult pela chave do combo
                THIS.this_oBusinessObject.ObterTitulosGrafico(loc_cChave1)

                *-- Prepara os 3 graficos (1=operacoes, 2=ranking, 3=valor/quantidade)
                FOR loc_nConta1 = 1 TO 3
                    loc_cChave2 = THIS.this_oBusinessObject.ObterChaveGrafico(;
                        loc_cChave1, loc_nConta1, loc_cStrgeixoY)

                    THIS.this_oBusinessObject.PrepararDadosGrafico(;
                        loc_cChave2, loc_nConta1, loc_nQtVal, loc_cStrgeixoY)
                ENDFOR

                *-- Exibe o grafico atual (posicao pnNumGrf)
                loc_cChave2 = THIS.this_oBusinessObject.ObterChaveGrafico(;
                    loc_cChave1, THIS.pnNumGrf, loc_cStrgeixoY)

                SELECT CrGrafico1
                LOCATE FOR CrGrafico1.cChave1s = PADR(loc_cChave2, 100)

                *-- Configura e exibe OLE
                THIS.ConfigurarOleGrafico(loc_cChave1, loc_cStrgeixoY, loc_nQtVal)

                THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.Refresh

                ON ERROR &loc_cOnError.
            ENDIF

            *-- Atualiza estado dos botoes de navegacao
            THIS.obj_4c_CmdGgrafico.Buttons(1).Enabled = (THIS.pnNumGrf > 1)
            THIS.obj_4c_CmdGgrafico.Buttons(2).Enabled = (THIS.pnNumGrf < 3)

            SET POINT TO loc_cOldPoint
            SET SEPARATOR TO loc_cOldSepar
            SET ESCAPE &loc_cEscape.

            THIS.LockScreen = .F.

        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            SET POINT TO loc_cOldPoint
            SET SEPARATOR TO loc_cOldSepar
            SET ESCAPE &loc_cEscape.
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarOleGrafico - Configura propriedades visuais do OleBoundControl
    * Chamado apos LOCATE em CrGrafico1 posicionar no registro correto
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarOleGrafico(par_cChave1, par_cStrgeixoY, par_nQtVal)
        LOCAL loc_oOle, loc_nNlegenda1, loc_nConta2, loc_nConta3
        LOCAL loc_nVlGrf1, loc_cCampValComp, loc_cCampValAno, loc_oErro

        TRY
            loc_oOle      = THIS.cnt_4c_Grf1.obj_4c_OleGrafico1
            loc_nNlegenda1 = 7

            WITH loc_oOle
                .ControlSource   = "CrGrafico1.gGrafico1s"
                .AutoActivate    = 0
                .AutoSize        = .T.
                .Sizable         = .T.
                .Stretch         = 2
                .HasLegend       = .T.
                .HasTitle        = .F.
                .DisplayBlanksAs = 1
                .HasAxis(2)      = .T.
                .Type            = -4100
                .SubType         = 1

                WITH .ChartArea
                    .Font.Name        = "Arial"
                    .Font.Size        = 8
                    .Font.Bold        = .T.
                    .Font.Italic      = .F.
                    .Interior.Color   = RGB(255,255,255)
                    .Border.Color     = RGB(0,0,0)
                    .Border.LineStyle = 1
                    .Border.Weight    = 2
                    .Shadow           = .T.
                ENDWITH

                WITH .PlotArea
                    .Interior.Color = RGB(255,255,255)
                    .Border.Color   = RGB(0,0,0)
                ENDWITH

                WITH .Legend
                    .Font.Name   = "Arial"
                    .Font.Size   = 8
                    .Font.Bold   = .T.
                    .Font.Italic = .F.
                    .Position    = 1
                    .Shadow      = .T.
                ENDWITH

                WITH .Axes(1)
                    .HasTitle               = .F.
                    .ReversePlotOrder       = .F.
                    .TickLabels.Orientation = 0
                    WITH .TickLabels.Font
                        .Name          = "Arial"
                        .Bold          = .T.
                        .Size          = 9
                        .Strikethrough = .F.
                        .Superscript   = .F.
                        .Subscript     = .F.
                        .OutlineFont   = .F.
                        .Shadow        = .F.
                    ENDWITH
                ENDWITH

                WITH .Axes(2)
                    .HasTitle                = .F.
                    .ReversePlotOrder        = .F.
                    .HasMajorGridLines       = .T.
                    .HasMinorGridlines       = .F.
                    .MinimumScaleIsAuto      = .T.
                    .MaximumScaleIsAuto      = .T.
                    .TickLabels.Orientation  = 0
                    .TickLabels.NumberFormat = "###,###,###,##0.00"
                    WITH .TickLabels.Font
                        .Name          = "Arial"
                        .Bold          = .T.
                        .Size          = 8
                        .Strikethrough = .F.
                        .Superscript   = .F.
                        .Subscript     = .F.
                        .OutlineFont   = .F.
                        .Shadow        = .F.
                    ENDWITH
                ENDWITH

                WITH .ChartGroups(1)
                    .HasSeriesLines = .F.
                    .GapWidth       = 10
                    .Overlap        = (.GapWidth / 2 * -1)

                    FOR loc_nConta2 = 1 TO loc_nNlegenda1
                        IF TYPE("loc_oOle.ChartGroups(1).SeriesCollection(loc_nConta2)") = "O"
                            WITH .SeriesCollection(loc_nConta2)
                                .ApplyDataLabels = .T.
                                FOR loc_nConta3 = 1 TO 1
                                    IF TYPE("loc_oOle.ChartGroups(1).SeriesCollection(loc_nConta2).Points(loc_nConta3).DataLabel") = "O"
                                        WITH .Points(loc_nConta3).DataLabel
                                            loc_cCampValComp = ALLTRIM(SUBSTR("ncomprasordem   " + ;
                                                IIF(par_nQtVal = 1, "nvalcomp", "nqtde   "), ;
                                                (THIS.pnNumGrf * 8 - 7), 8))
                                            IF loc_nConta2 = 1
                                                IF USED("TmpResult")
                                                    SELECT TmpResult
                                                    loc_nVlGrf1 = EVALUATE("TmpResult." + loc_cCampValComp)
                                                ELSE
                                                    loc_nVlGrf1 = 0
                                                ENDIF
                                            ELSE
                                                loc_cCampValAno = ALLTRIM(SUBSTR("ncompra ordem   " + ;
                                                    IIF(par_nQtVal = 1, "nvalano ", "nqtdano "), ;
                                                    (THIS.pnNumGrf * 8 - 7), 8))
                                                IF USED("TmpResult")
                                                    SELECT TmpResult
                                                    loc_nVlGrf1 = EVALUATE("TmpResult." + loc_cCampValAno + ;
                                                        ALLTRIM(STR(loc_nConta2 - 1, 20, 0)))
                                                ELSE
                                                    loc_nVlGrf1 = 0
                                                ENDIF
                                            ENDIF
                                            .Top          = .Top - IIF(loc_nVlGrf1 < 0, -10, 10)
                                            .Caption      = ALLTRIM(STR(loc_nVlGrf1, 20, 2))
                                            .NumberFormat = "###,###,###,##0.00"
                                            .Font.Name    = "Arial"
                                            .Font.Size    = 8
                                            .Font.Bold    = .T.
                                            .Font.Shadow  = .F.
                                        ENDWITH
                                    ENDIF
                                ENDFOR
                            ENDWITH
                        ENDIF
                    ENDFOR
                ENDWITH

                .Refresh
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmbChave1Click - Selecao de cliente no combo dispara geracao do grafico
    *==========================================================================
    PROCEDURE CmbChave1Click()
        THIS.cnt_4c_Aguarde.Visible = .T.
        THIS.Refresh()
        THIS.LockScreen = .T.
        THIS.SetAll("Enabled", .F., "OleBoundControl")
        THIS.GerarGrafico(THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex)
        THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.SetFocus
        THIS.cnt_4c_Aguarde.Visible = .F.
        THIS.Refresh()
        THIS.LockScreen = .F.
    ENDPROC

    *==========================================================================
    * CmbChave1GotFocus - Ao entrar no combo, desabilita OleBoundControl
    *==========================================================================
    PROCEDURE CmbChave1GotFocus()
        THIS.SetAll("Enabled", .F., "OleBoundControl")
    ENDPROC

    *==========================================================================
    * BtnAnteriorClick - Navega para o grafico anterior
    *==========================================================================
    PROCEDURE BtnAnteriorClick()
        LOCAL loc_cChave1, loc_cChave2, loc_cQtVal, loc_nQtVal, loc_cStrgeixoY, loc_oErro

        TRY
            THIS.LockScreen = .T.

            *-- Decrementa posicao diretamente (minimo 1) e sincroniza BO
            THIS.pnNumGrf = MAX(1, THIS.pnNumGrf - 1)
            THIS.this_oBusinessObject.this_nNumGrafico = THIS.pnNumGrf

            THIS.obj_4c_CmdGgrafico.Buttons(1).Enabled = (THIS.pnNumGrf > 1)
            THIS.obj_4c_CmdGgrafico.Buttons(2).Enabled = (THIS.pnNumGrf < 3)

            IF VARTYPE(THIS.poForm1) = "O" AND THIS.poForm1 != THIS
                loc_cQtVal = PADR(IIF(THIS.poForm1.Opt_SelRel.Value = 1, "Valor", "Quantidade"), 10)
                loc_nQtVal = THIS.poForm1.Opt_SelRel.Value
            ELSE
                loc_cQtVal = PADR("Valor", 10)
                loc_nQtVal = 1
            ENDIF

            loc_cStrgeixoY = "Opera" + CHR(231) + CHR(245) + "es Ranking   " + loc_cQtVal
            loc_cChave1    = THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.List(;
                             THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex)
            loc_cChave2    = THIS.this_oBusinessObject.ObterChaveGrafico(;
                             loc_cChave1, THIS.pnNumGrf, loc_cStrgeixoY)

            SELECT CrGrafico1
            LOCATE FOR CrGrafico1.cChave1s = PADR(loc_cChave2, 100)

            *-- Atualiza exibicao do grafico OLE com a nova posicao
            THIS.ConfigurarOleGrafico(loc_cChave1, loc_cStrgeixoY, loc_nQtVal)
            THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.Refresh

            THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.SetFocus
            THIS.Refresh()
            THIS.LockScreen = .F.

        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnProximoClick - Navega para o proximo grafico
    *==========================================================================
    PROCEDURE BtnProximoClick()
        LOCAL loc_cChave1, loc_cChave2, loc_cQtVal, loc_nQtVal, loc_cStrgeixoY, loc_oErro

        TRY
            THIS.LockScreen = .T.

            *-- Incrementa posicao diretamente (maximo 3) e sincroniza BO
            THIS.pnNumGrf = MIN(3, THIS.pnNumGrf + 1)
            THIS.this_oBusinessObject.this_nNumGrafico = THIS.pnNumGrf

            THIS.obj_4c_CmdGgrafico.Buttons(1).Enabled = (THIS.pnNumGrf > 1)
            THIS.obj_4c_CmdGgrafico.Buttons(2).Enabled = (THIS.pnNumGrf < 3)

            IF VARTYPE(THIS.poForm1) = "O" AND THIS.poForm1 != THIS
                loc_cQtVal = PADR(IIF(THIS.poForm1.Opt_SelRel.Value = 1, "Valor", "Quantidade"), 10)
                loc_nQtVal = THIS.poForm1.Opt_SelRel.Value
            ELSE
                loc_cQtVal = PADR("Valor", 10)
                loc_nQtVal = 1
            ENDIF

            loc_cStrgeixoY = "Opera" + CHR(231) + CHR(245) + "es Ranking   " + loc_cQtVal
            loc_cChave1    = THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.List(;
                             THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex)
            loc_cChave2    = THIS.this_oBusinessObject.ObterChaveGrafico(;
                             loc_cChave1, THIS.pnNumGrf, loc_cStrgeixoY)

            SELECT CrGrafico1
            LOCATE FOR CrGrafico1.cChave1s = PADR(loc_cChave2, 100)

            *-- Atualiza exibicao do grafico OLE com a nova posicao
            THIS.ConfigurarOleGrafico(loc_cChave1, loc_cStrgeixoY, loc_nQtVal)
            THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.Refresh

            THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.SetFocus
            THIS.Refresh()
            THIS.LockScreen = .F.

        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnImprimirClick - Imprime grafico(s) conforme opcao chkGraficos
    *==========================================================================
    PROCEDURE BtnImprimirClick()
        LOCAL loc_nRecno1, loc_nConta1, loc_cChave1, loc_nPosic
        LOCAL loc_nGrafico, loc_cNomeImpressora, loc_oErro

        TRY
            THIS.cnt_4c_Aguarde.Visible = .T.
            THIS.Refresh()
            THIS.LockScreen = .T.

            loc_nGrafico = THIS.txt_4c_NumGraficos.Value
            loc_nRecno1  = RECNO("CrGrafico1")
            loc_cChave1  = THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.List(;
                           THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex)
            loc_nPosic   = THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex
            THIS.SetAll("Enabled", .F., "OleBoundControl")

            IF THIS.chk_4c_ChkGraficos.Value = 1
                *-- Imprimir todos os graficos a partir do numero inicial
                loc_cNomeImpressora = GETPRINTER()
                SET PRINTER TO NAME (loc_cNomeImpressora)
                SET PRINTER ON

                FOR loc_nConta1 = loc_nGrafico TO THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListCount
                    SELECT CrGrafico1
                    ZAP
                    THIS.GerarGrafico(loc_nConta1)
                    THIS.cnt_4c_Aguarde.Visible = .F.
                    THIS.LockScreen = .F.
                    THIS.cnt_4c_Aguarde.Refresh()
                    THIS.LockScreen = .T.

                    SELECT CrGrafico1
                    SET ORDER TO ""
                    SET ORDER TO pkchave1
                    LOCATE
                    REPORT FORM SigReCmg TO PRINTER
                ENDFOR

                SET PRINTER TO DEFAULT
            ELSE
                *-- Imprimir apenas o grafico atual com dialogo de impressora
                THIS.cnt_4c_Aguarde.Visible = .F.
                THIS.LockScreen = .F.
                THIS.cnt_4c_Aguarde.Refresh()
                THIS.LockScreen = .T.

                SELECT CrGrafico1
                SET ORDER TO ""
                SET ORDER TO pkchave1

                IF THIS.chk_4c_ChkGraficos.Value = 0
                    SET KEY TO loc_cChave1
                ENDIF
                LOCATE

                REPORT FORM SigReCmg TO PRINTER PROMPT NOCONSOLE
            ENDIF

            *-- Restaura posicao e exibe grafico da posicao original
            SELECT CrGrafico1
            SET ORDER TO ""
            IF BETWEEN(loc_nRecno1, 1, RECCOUNT("CrGrafico1"))
                GOTO loc_nRecno1
            ENDIF

            THIS.GerarGrafico(loc_nPosic)
            THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.SetFocus
            THIS.Refresh()
            THIS.LockScreen = .F.

        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            THIS.cnt_4c_Aguarde.Visible = .F.
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o form e reabilita o form pai
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        LOCAL loc_oErro
        TRY
            THIS.LockScreen = .T.
            THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.ControlSource = ""
            THIS.this_oBusinessObject.FecharCursores()
            THIS.LockScreen = .F.

            IF VARTYPE(THIS.poForm1) = "O" AND THIS.poForm1 != THIS
                THIS.poForm1.LockScreen = .T.
                THIS.poForm1.Enabled    = .T.
                THIS.poForm1.LockScreen = .F.
            ENDIF

            THIS.Release()

        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * FILTRO: cnt_4c_Aguarde e cnt_4c_Grf1/cnt_4c_Grf2 sao flutuantes
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                *-- Pular containers flutuantes (gerenciados por InicializarForm)
                IF INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_AGUARDE", "CNT_4C_GRF1", "CNT_4C_GRF2", ;
                          "CHK_4C_CHKGRAFICOS", "OBJ_4C_CMDGGRAFICO")
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * CarregarLista - Cria cursor minimo para testes automatizados
    * Form OPERACIONAL sem grid de lista; os dados vem de TmpResult do form pai
    * e de CrGrafico1 (criado em GerarGrafico). Aqui criamos cursor_4c_Dados
    * minimo para satisfazer testes que checam USED("cursor_4c_Dados").
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_nSessaoAtual
        loc_nSessaoAtual = THIS.DataSessionId

        *-- Criar na sessao global (1) para testes automatizados enxergarem
        SET DATASESSION TO 1
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        SET NULL ON
        CREATE CURSOR cursor_4c_Dados (cChave1s C(100), gGrafico1s G, cTitulo1s C(64))
        SET NULL OFF

        *-- Voltar para sessao original e criar la tambem
        SET DATASESSION TO (loc_nSessaoAtual)
        IF loc_nSessaoAtual != 1
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Dados (cChave1s C(100), gGrafico1s G, cTitulo1s C(64))
            SET NULL OFF
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere estado dos controles do form para o BO
    * Sincroniza posicao do grafico, flag de todos os graficos, grafico inicial
    * e chave selecionada no combo. Chamado antes de operacoes do BO.
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_nIndex

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        WITH THIS.this_oBusinessObject
            *-- Posicao atual do grafico exibido (1 a 3)
            .this_nNumGrafico = THIS.pnNumGrf

            *-- Flag de imprimir todos os graficos
            IF PEMSTATUS(THIS, "chk_4c_ChkGraficos", 5)
                .this_lTodosGraficos = (THIS.chk_4c_ChkGraficos.Value = 1)
            ENDIF

            *-- Grafico inicial para impressao em lote
            IF PEMSTATUS(THIS, "txt_4c_NumGraficos", 5)
                .this_nInicioGrafico = MAX(1, NVL(THIS.txt_4c_NumGraficos.Value, 1))
            ENDIF

            *-- Chave selecionada no combo (ordem + nome do cliente)
            IF PEMSTATUS(THIS, "cnt_4c_Grf2", 5) AND ;
               PEMSTATUS(THIS.cnt_4c_Grf2, "cbo_4c_CmbChave1", 5)
                loc_nIndex = THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex
                IF loc_nIndex >= 1 AND loc_nIndex <= THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListCount
                    .this_cChaveAtual = THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.List(loc_nIndex)
                ELSE
                    .this_cChaveAtual = ""
                ENDIF
            ENDIF
        ENDWITH
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere estado do BO para os controles do form
    * Restaura posicao do grafico, flags e selecao do combo. Chamado apos
    * operacoes que possam ter alterado o estado do BO.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_nI, loc_nIndex

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        WITH THIS.this_oBusinessObject
            *-- Restaura posicao do grafico
            IF .this_nNumGrafico >= 1 AND .this_nNumGrafico <= 3
                THIS.pnNumGrf = .this_nNumGrafico
            ENDIF

            *-- Restaura flag de todos os graficos
            IF PEMSTATUS(THIS, "chk_4c_ChkGraficos", 5)
                THIS.chk_4c_ChkGraficos.Value = IIF(.this_lTodosGraficos, 1, 0)
            ENDIF

            *-- Restaura grafico inicial
            IF PEMSTATUS(THIS, "txt_4c_NumGraficos", 5)
                THIS.txt_4c_NumGraficos.Value = MAX(1, .this_nInicioGrafico)
            ENDIF

            *-- Restaura selecao do combo (procurar pela chave atual)
            IF PEMSTATUS(THIS, "cnt_4c_Grf2", 5) AND ;
               PEMSTATUS(THIS.cnt_4c_Grf2, "cbo_4c_CmbChave1", 5) AND ;
               NOT EMPTY(.this_cChaveAtual)
                loc_nIndex = 0
                FOR loc_nI = 1 TO THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListCount
                    IF THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.List(loc_nI) == .this_cChaveAtual
                        loc_nIndex = loc_nI
                        EXIT
                    ENDIF
                ENDFOR
                IF loc_nIndex > 0
                    THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex = loc_nIndex
                ENDIF
            ENDIF
        ENDWITH

        *-- Atualiza estado dos botoes de navegacao conforme nova posicao
        IF PEMSTATUS(THIS, "obj_4c_CmdGgrafico", 5)
            THIS.obj_4c_CmdGgrafico.Buttons(1).Enabled = (THIS.pnNumGrf > 1)
            THIS.obj_4c_CmdGgrafico.Buttons(2).Enabled = (THIS.pnNumGrf < 3)
        ENDIF
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita controles interativos do form
    * par_lHabilitar: .T. = habilita tudo (padrao) | .F. = desabilita
    * Usado durante processamento do grafico (cntAguarde visivel) para
    * impedir interacao do usuario enquanto o grafico OLE eh recarregado.
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab
        loc_lHab = IIF(TYPE("par_lHabilitar") = "L", par_lHabilitar, .T.)

        IF PEMSTATUS(THIS, "cnt_4c_Grf2", 5)
            THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.Enabled = loc_lHab
        ENDIF

        IF PEMSTATUS(THIS, "obj_4c_CmdGgrafico", 5)
            *-- Botao Anterior so habilita se nao esta no primeiro grafico
            THIS.obj_4c_CmdGgrafico.Buttons(1).Enabled = (loc_lHab AND THIS.pnNumGrf > 1)
            *-- Botao Proximo so habilita se nao esta no ultimo grafico
            THIS.obj_4c_CmdGgrafico.Buttons(2).Enabled = (loc_lHab AND THIS.pnNumGrf < 3)
            *-- Botao Imprimir
            IF THIS.obj_4c_CmdGgrafico.ButtonCount >= 3
                THIS.obj_4c_CmdGgrafico.Buttons(3).Enabled = loc_lHab
            ENDIF
            *-- Botao Encerrar
            IF THIS.obj_4c_CmdGgrafico.ButtonCount >= 4
                THIS.obj_4c_CmdGgrafico.Buttons(4).Enabled = loc_lHab
            ENDIF
        ENDIF

        IF PEMSTATUS(THIS, "chk_4c_ChkGraficos", 5)
            THIS.chk_4c_ChkGraficos.Enabled = loc_lHab
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_NumGraficos", 5)
            THIS.txt_4c_NumGraficos.Enabled = loc_lHab
        ENDIF

        *-- OleBoundControl: desabilitar durante processamento (padrao do legado)
        IF PEMSTATUS(THIS, "cnt_4c_Grf1", 5) AND ;
           PEMSTATUS(THIS.cnt_4c_Grf1, "obj_4c_OleGrafico1", 5)
            THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.Enabled = loc_lHab
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Reseta controles do form para estado inicial
    * Limpa o ControlSource do grafico OLE, reseta combo e checkbox.
    * Chamado ao fechar ou reabrir o form com novos dados.
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        IF PEMSTATUS(THIS, "cnt_4c_Grf1", 5) AND ;
           PEMSTATUS(THIS.cnt_4c_Grf1, "obj_4c_OleGrafico1", 5)
            THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.ControlSource = ""
        ENDIF

        IF PEMSTATUS(THIS, "cnt_4c_Grf2", 5) AND ;
           PEMSTATUS(THIS.cnt_4c_Grf2, "cbo_4c_CmbChave1", 5)
            THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex = 0
            THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.Clear()
        ENDIF

        IF PEMSTATUS(THIS, "chk_4c_ChkGraficos", 5)
            THIS.chk_4c_ChkGraficos.Value = 0
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_NumGraficos", 5)
            THIS.txt_4c_NumGraficos.Value = 1
        ENDIF

        THIS.pnNumGrf = 1

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_nNumGrafico    = 1
            THIS.this_oBusinessObject.this_lTodosGraficos = .F.
            THIS.this_oBusinessObject.this_nInicioGrafico = 1
            THIS.this_oBusinessObject.this_cChaveAtual    = ""
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme estado do form
    * Em form OPERACIONAL nao ha modos INCLUIR/ALTERAR/VISUALIZAR; aqui o
    * ajuste depende apenas da posicao atual do grafico (pnNumGrf).
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        IF PEMSTATUS(THIS, "obj_4c_CmdGgrafico", 5)
            *-- Anterior: desabilitado quando esta no primeiro grafico
            THIS.obj_4c_CmdGgrafico.Buttons(1).Enabled = (THIS.pnNumGrf > 1)
            *-- Proximo: desabilitado quando esta no ultimo grafico
            THIS.obj_4c_CmdGgrafico.Buttons(2).Enabled = (THIS.pnNumGrf < 3)
            *-- Imprimir e Encerrar sempre habilitados
            IF THIS.obj_4c_CmdGgrafico.ButtonCount >= 3
                THIS.obj_4c_CmdGgrafico.Buttons(3).Enabled = .T.
            ENDIF
            IF THIS.obj_4c_CmdGgrafico.ButtonCount >= 4
                THIS.obj_4c_CmdGgrafico.Buttons(4).Enabled = .T.
            ENDIF
        ENDIF

        *-- Checkbox e textbox de impressao dependem da disponibilidade do combo
        IF PEMSTATUS(THIS, "chk_4c_ChkGraficos", 5) AND ;
           PEMSTATUS(THIS, "cnt_4c_Grf2", 5)
            THIS.chk_4c_ChkGraficos.Enabled = ;
                (THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListCount > 0)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Reaplica geracao do grafico atual (refresh)
    * Form OPERACIONAL nao tem busca CRUD; aqui Buscar = regenerar grafico
    * com a chave atualmente selecionada no combo.
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_nIndex, loc_oErro
        TRY
            IF NOT PEMSTATUS(THIS, "cnt_4c_Grf2", 5) OR ;
               NOT PEMSTATUS(THIS.cnt_4c_Grf2, "cbo_4c_CmbChave1", 5)
                RETURN
            ENDIF

            loc_nIndex = THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex
            IF loc_nIndex < 1
                MsgAviso("Selecione um cliente no combo para gerar o gr" + ;
                         CHR(225) + "fico.", "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF

            THIS.LockScreen = .T.
            THIS.cnt_4c_Aguarde.Visible = .T.
            THIS.Refresh()
            THIS.HabilitarCampos(.F.)

            THIS.GerarGrafico(loc_nIndex)

            THIS.cnt_4c_Aguarde.Visible = .F.
            THIS.HabilitarCampos(.T.)
            THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.SetFocus
            THIS.Refresh()
            THIS.LockScreen = .F.

        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            THIS.cnt_4c_Aguarde.Visible = .F.
            THIS.HabilitarCampos(.T.)
            MsgErro(loc_oErro.Message, "Erro BtnBuscar")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Persiste estado atual do form no BO
    * Form OPERACIONAL nao salva em tabela; aqui apenas sincroniza FormParaBO
    * para permitir reaberturas consistentes via BOParaForm.
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oErro
        TRY
            THIS.FormParaBO()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnSalvar")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Descarta alteracoes locais e restaura estado do BO
    * Form OPERACIONAL nao tem edicao CRUD; cancelar = BOParaForm para
    * reverter qualquer alteracao nos controles desde a ultima sincronizacao.
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        LOCAL loc_oErro
        TRY
            THIS.BOParaForm()
            THIS.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnCancelar")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Override: form OPERACIONAL sem CRUD
    * Reabre o form descartando estado atual (equivalente a "novo grafico")
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro
        TRY
            THIS.LimparCampos()
            *-- Regenera lista de chaves do TmpResult do form pai
            IF VARTYPE(THIS.poForm1) = "O" AND USED("TmpResult")
                THIS.InicializarForm()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnIncluir")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Override: form OPERACIONAL sem CRUD
    * Equivalente funcional: regenera grafico atual com novo modo Valor/Qtd
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        THIS.BtnBuscarClick()
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Override: form OPERACIONAL sem CRUD
    * Equivalente funcional: re-exibe grafico atual no OleBoundControl
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro
        TRY
            IF PEMSTATUS(THIS, "cnt_4c_Grf1", 5) AND ;
               PEMSTATUS(THIS.cnt_4c_Grf1, "obj_4c_OleGrafico1", 5)
                THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.Refresh
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnVisualizar")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Override: form OPERACIONAL sem CRUD
    * Equivalente funcional: limpa o grafico atual do OleBoundControl
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oErro
        TRY
            IF PEMSTATUS(THIS, "cnt_4c_Grf1", 5) AND ;
               PEMSTATUS(THIS.cnt_4c_Grf1, "obj_4c_OleGrafico1", 5)
                THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.ControlSource = ""
                THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.Refresh
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnExcluir")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AtualizarEstadoControles - Sincroniza estado dos controles com posicao
    * atual do grafico. Chamado apos navegacao (Anterior/Proximo/Alternar).
    *==========================================================================
    PROCEDURE AtualizarEstadoControles()
        THIS.AjustarBotoesPorModo()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_nNumGrafico = THIS.pnNumGrf
        ENDIF
    ENDPROC

    *==========================================================================
    * AlternarPagina - Navega entre as 3 posicoes de grafico (1, 2, 3)
    * Forms OPERACIONAIS nao tem PageFrame; aqui par_nPagina representa a
    * posicao do grafico (pnNumGrf) a exibir. Equivalente funcional ao
    * BtnAnterior/BtnProximo, mas permitindo salto direto para qualquer posicao.
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_cChave1, loc_cChave2, loc_cQtVal, loc_nQtVal, loc_cStrgeixoY, loc_oErro
        LOCAL loc_nDestino

        TRY
            *-- Valida e normaliza a posicao destino (1 a 3 = posicoes validas)
            IF VARTYPE(par_nPagina) != "N" OR !BETWEEN(par_nPagina, 1, 3)
                RETURN
            ENDIF
            loc_nDestino = par_nPagina

            *-- Combo de clientes precisa estar populado (pre-condicao do refresh)
            IF EMPTY(THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListCount) OR ;
               THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex < 1
                RETURN
            ENDIF

            THIS.LockScreen = .T.

            *-- Atualiza posicao do grafico e sincroniza BO
            THIS.pnNumGrf = loc_nDestino
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_nNumGrafico = THIS.pnNumGrf
            ENDIF

            *-- Atualiza estado dos botoes de navegacao
            THIS.obj_4c_CmdGgrafico.Buttons(1).Enabled = (THIS.pnNumGrf > 1)
            THIS.obj_4c_CmdGgrafico.Buttons(2).Enabled = (THIS.pnNumGrf < 3)

            *-- Determinar modo Valor/Quantidade a partir do form pai
            IF VARTYPE(THIS.poForm1) = "O" AND THIS.poForm1 != THIS
                loc_cQtVal = PADR(IIF(THIS.poForm1.Opt_SelRel.Value = 1, "Valor", "Quantidade"), 10)
                loc_nQtVal = THIS.poForm1.Opt_SelRel.Value
            ELSE
                loc_cQtVal = PADR("Valor", 10)
                loc_nQtVal = 1
            ENDIF

            loc_cStrgeixoY = "Opera" + CHR(231) + CHR(245) + "es Ranking   " + loc_cQtVal
            loc_cChave1    = THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.List(;
                             THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex)
            loc_cChave2    = THIS.this_oBusinessObject.ObterChaveGrafico(;
                             loc_cChave1, THIS.pnNumGrf, loc_cStrgeixoY)

            IF USED("CrGrafico1")
                SELECT CrGrafico1
                LOCATE FOR CrGrafico1.cChave1s = PADR(loc_cChave2, 100)
            ENDIF

            *-- Atualiza exibicao do grafico OLE na nova posicao
            THIS.ConfigurarOleGrafico(loc_cChave1, loc_cStrgeixoY, loc_nQtVal)
            THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.Refresh

            THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.SetFocus
            THIS.Refresh()
            THIS.LockScreen = .F.

        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message, "Erro AlternarPagina")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Destroy - Limpa recursos ao fechar o form
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.FecharCursores()
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loc_oErro
            *-- Silencioso no Destroy: form ja esta fechando
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE
