*==============================================================================
* FORMSIGOPETQDOC.PRG
* Impressao da Consulta de Etiquetas - dialogo de escolha do destino
* Tipo: OPERACIONAL (dialogo filho de FormSigOpEtq)
* Migrado de: SIGMVDOC.SCX (frmrelatorio), RAMO GENERICO (pRep <> 'SIGCDENT')
*
*------------------------------------------------------------------------------
* POR QUE ESTA CLASSE EXISTE
*------------------------------------------------------------------------------
* O botao Imprimir do SIGOPETQ legado nao imprime: ele abre o dialogo generico
* SIGMVDOC, passando o nome do relatorio e o titulo da janela -
*
*   PROCEDURE btnImprimir.Valid            (SIGOPETQ)
*       If .f.
*           Report Form SigOpEtq && Linha Colocada Apenas Para Compilacao
*       EndIf
*       Select csRelatorio
*       Do Form SigMvDoc With 'SIGOPETQ', 'Impressao da Consulta de Etiquetas'
*
* O SIGMVDOC tem DOIS ramos, decididos no proprio Init dele pelo 1o parametro:
*
*   pRep  = 'SIGCDENT' -> mostra a faixa de Nota Fiscal (GetNotaI/GetNotaF) e
*                         recorta o cursor por ela antes de imprimir;
*   pRep <> 'SIGCDENT' -> ESCONDE label1/label2/Shape1/GetNotaI/GetNotaF, sobe
*                         a barra de botoes (btnReport.Top = 4) e imprime o
*                         cursor CORRENTE inteiro.
*
* O migrado FormSIGMVDOC/SIGMVDOCBO existe, mas implementa SO o 1o ramo (ver o
* cabecalho dele e o PrepararDados do BO: SQL de faixa de nfis contra
* SigMvNfi). Reusa-lo aqui abriria a tela ERRADA - filtro de Nota Fiscal, sem
* nenhuma ligacao com etiquetas - e ainda bateria em dois impedimentos
* estruturais:
*
*   1. o Init dele NAO recebe parametro, logo nao ha como informar nem o
*      NomeRepo (SIGOPETQ) nem o titulo;
*   2. ele nasce com DataSession = 2 (sessao privada), e por isso nao
*      alcancaria o cursor da consulta, que vive na sessao do chamador.
*
* Dai esta classe: o ramo generico do SIGMVDOC, com a barra de 4 botoes e nada
* mais, na MESMA data session do cursor. O SCX legado declara DataSession = 1 -
* ou seja, aqui o valor eh transcricao do dump, nao escolha.
*
*------------------------------------------------------------------------------
* O QUE CADA BOTAO FAZ (barra btnReport do frmrelatorio)
*------------------------------------------------------------------------------
*   Visualizar     -> PROCEDURE visualizacao   Report Form &NomeRepo. Preview
*   Imprimir       -> PROCEDURE impressao      Report Form &NomeRepo. To Printer Prompt
*   Arquivos Email -> DocExcel                 mesmo FRX com destino To File ... Ascii
*   Encerrar       -> Sair                     fecha o dialogo
*
* As tres acoes moram no SigOpEtqBO (Visualizar/Imprimir/GerarExcel), que eh
* quem conhece o nome-base do FRX, o alias do cursor e o helper
* ExecutarReportForm. Este form so oferece a escolha - mesma divisao do
* FormSIGMVDOC, onde os Btn*Click delegam ao SIGMVDOCBO.
*
* O "Go Top" do PROCEDURE processamento do SIGMVDOC roda dentro do helper do
* BO, junto do SELECT do alias: o FRX le a work area CORRENTE (as expressoes
* dele sao Contas/CBars/Tipos/datas/cpros/DPros, SEM prefixo de alias).
*
*------------------------------------------------------------------------------
* GEOMETRIA
*------------------------------------------------------------------------------
* Transcrita do dump de SIGMVDOC (Width 800, Height 130; btnReport Left 495,
* Width 310, Height 85, Top 4 no ramo generico; os 4 botoes 75x75 em Left
* 5/80/155/230, Top 5). O bloco "If .Width > (lnBotW + 20)" do Init legado NAO
* encolhe a janela neste caso: a condicao eh 800 > 330, verdadeira, e o ramo
* verdadeiro esta VAZIO - quem encolhe eh o ELSE. Por isso a janela fica nos
* 800x130 declarados.
*
* Captions, icones e cores seguem o FormSIGMVDOC, que eh a migracao ja
* aprovada deste mesmo SCX - as duas telas sao o mesmo dialogo do legado e nao
* podem divergir visualmente.
*==============================================================================

DEFINE CLASS FormSigOpEtqDoc AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais - TRANSCRITAS do dump de SIGMVDOC
    *
    * Caption fica VAZIO aqui e eh montado no Init a partir do titulo que o
    * chamador entrega (o pTit do legado): o bloco de propriedades de
    * DEFINE CLASS recebe literal, nao expressao, e o texto tem "a" com til -
    * acento nao se escreve literal em .PRG (regra CLAUDE.md #4).
    *
    * DataSession = 1 eh REQUISITO, nao default copiado: eh o que faz este
    * dialogo ver o cursor da consulta, que pertence a sessao do chamador.
    *
    * WindowType nasce 0 e vira 1 no Init fora de teste, igual ao
    * FormSigOpEtq: o chamador guarda esta tela numa variavel LOCAL, e sem o
    * Show() bloqueante a referencia cairia no retorno do metodo dele,
    * destruindo a tela sem erro e sem log (regra CLAUDE.md #29). Em
    * validacao de UI / teste automatizado o 0 permanece, senao o Show()
    * travaria o pipeline.
    *--------------------------------------------------------------------------
    Height       = 130
    Width        = 800
    Caption      = ""
    BorderStyle  = 2
    AutoCenter   = .T.
    TitleBar     = 0
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    KeyPreview   = .T.
    ClipControls = .T.
    ShowWindow   = 1
    WindowType   = 0
    DataSession  = 1
    AlwaysOnTop  = .T.
    Themes       = .F.
    ShowTips     = .T.
    FontName     = "Tahoma"
    FontSize     = 8

    *--------------------------------------------------------------------------
    * Estado do dialogo
    *
    * this_oRelatorio eh o SigOpEtqBO do form PAI - recebido PRONTO, nunca
    * criado aqui: ele eh quem guarda o alias do cursor da consulta resolvido
    * na abertura da tela de tras. Instanciar um BO novo aqui perderia esse
    * alias e o relatorio sairia vazio.
    *--------------------------------------------------------------------------
    this_oRelatorio = .NULL.        && SigOpEtqBO do form pai

    *==========================================================================
    * Init - recebe o BO do pai e o titulo (pTit do legado)
    *
    * par_oRelatorio   SigOpEtqBO ja com o cursor da consulta resolvido
    * par_cTitulo      titulo da janela; na falta, usa o do proprio BO
    *
    * Sem o BO nao ha o que imprimir, entao o Init RECUSA a abertura (devolve
    * .F.): melhor a tela nao abrir do que abrir uma barra de botoes que
    * estouraria "Property VISUALIZAR is not found" no primeiro clique.
    *
    * RETURN fica FORA do TRY/CATCH (regra CLAUDE.md #1) - o resultado passa
    * pela flag loc_lSucesso.
    *==========================================================================
    PROCEDURE Init(par_oRelatorio, par_cTitulo)
        LOCAL loc_lSucesso, loc_cTitulo, loc_oErro

        loc_lSucesso = .F.

        IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
             (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
            THIS.WindowType = 1
            THIS.ShowWindow = 1
        ENDIF

        TRY
            IF VARTYPE(par_oRelatorio) = "O"
                THIS.this_oRelatorio = par_oRelatorio
            ENDIF

            *-- Titulo: o pTit do "Do Form SigMvDoc With 'SIGOPETQ', <pTit>".
            *-- O default do legado eh "Emissao do Documento" (o
            *-- Iif(Type('pTit')='C', pTit, 'Emissao do Documento') do Init
            *-- do SIGMVDOC); aqui o 1o default eh o titulo guardado no BO,
            *-- que ja eh exatamente o pTit desta tela.
            loc_cTitulo = ""
            IF VARTYPE(par_cTitulo) = "C"
                loc_cTitulo = ALLTRIM(par_cTitulo)
            ENDIF

            IF EMPTY(loc_cTitulo) AND VARTYPE(THIS.this_oRelatorio) = "O"
                IF PEMSTATUS(THIS.this_oRelatorio, "this_cTituloRelatorio", 5)
                    loc_cTitulo = ALLTRIM(THIS.this_oRelatorio.this_cTituloRelatorio)
                ENDIF
            ENDIF

            IF EMPTY(loc_cTitulo)
                loc_cTitulo = "Emiss" + CHR(227) + "o do Documento"
            ENDIF

            *-- this_cTituloForm tem de concordar com o Caption: FormBase.Init
            *-- repoe o Caption a partir dela antes de InicializarForm.
            THIS.Caption          = loc_cTitulo
            THIS.this_cTituloForm = loc_cTitulo

            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Imprimir indispon" + CHR(237) + "vel: o objeto de " + ;
                    "neg" + CHR(243) + "cio da consulta n" + CHR(227) + ;
                    "o foi informado.", "Imprimir")
            ELSE
                *-- FormBase.Init chama InicializarForm
                loc_lSucesso = DODEFAULT()
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormSigOpEtqDoc.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarForm - monta a faixa do cabecalho e a barra de botoes
    *
    * A faixa vem PRIMEIRO: a barra de botoes fica em Top = 4, DENTRO da area
    * dela (Top 0 + Height 80), e so desenha por cima se for criada DEPOIS
    * (regra CLAUDE.md #11).
    *
    * RETURN unico, FORA do TRY (regra CLAUDE.md #1).
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF TYPE("gc_4c_CaminhoIcones") != "C"
                gc_4c_CaminhoIcones = ""
            ENDIF

            THIS.ConfigurarCabecalho()
            THIS.ConfigurarBotoes()
            THIS.ConfigurarEventos()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormSigOpEtqDoc.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - cntSombra do legado (faixa cinza com o titulo)
    *
    * Dois labels sobrepostos: lbl_4c_Sombra em preto e lbl_4c_Titulo em
    * branco um pixel abaixo, que eh o efeito de sombra do framework. Nenhum
    * dos dois pode ficar sem propriedade (label "pelado" sai no tamanho
    * default, preto sobre cinza).
    *
    * BackColor RGB(100,100,100) + ForeColor branco no titulo: aqui o branco
    * eh CORRETO porque o container eh OPACO e escuro (a excecao prevista na
    * regra CLAUDE.md #12).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")

        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Top       = 18
            .Left      = 10
            .Width     = 769
            .Height    = 40
            .AutoSize  = .F.
            .WordWrap  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .Caption   = THIS.Caption
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Top       = 17
            .Left      = 10
            .Width     = 769
            .Height    = 46
            .AutoSize  = .F.
            .WordWrap  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .Caption   = THIS.Caption
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - barra btnReport do frmrelatorio (4 botoes)
    *
    * Top = 4 eh o valor que o Init legado aplica no ramo generico
    * (ThisForm.btnReport.Top = 4), nao o -2 declarado no SCX.
    *
    * CommandGroup NAO tem ForeColor (regra CLAUDE.md #33): a cor mora em cada
    * Buttons(N). Os WITH .Buttons(N) ficam ANINHADOS dentro do WITH do grupo
    * de proposito - Buttons(N) eh acessor de colecao, nao AddObject, e este eh
    * o unico nivel de aninhamento seguro.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")

        WITH THIS.cmg_4c_Botoes
            .Top           = 4
            .Left          = 495
            .Width         = 310
            .Height        = 85
            .ButtonCount   = 4
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .AutoSize      = .F.
            .Themes        = .F.
            .Visible       = .T.

            WITH .Buttons(1)
                .Top             = 5
                .Left            = 5
                .Width           = 75
                .Height          = 75
                .Caption         = "\<Visualizar"
                .WordWrap        = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Gerar o Relat" + CHR(243) + "rio no V" + ;
                    CHR(237) + "deo"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(2)
                .Top             = 5
                .Left            = 80
                .Width           = 75
                .Height          = 75
                .Caption         = "\<Imprimir"
                .WordWrap        = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Enviar o Relat" + CHR(243) + ;
                    "rio Para Impressora"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(3)
                .Top             = 5
                .Left            = 155
                .Width           = 75
                .Height          = 75
                .Caption         = "\<Arquivos Email"
                .WordWrap        = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Arquivos Email"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(4)
                .Top             = 5
                .Left            = 230
                .Width           = 75
                .Height          = 75
                .Caption         = "\<Encerrar"
                .Cancel          = .T.
                .WordWrap        = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "[Esc] Encerrar"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarEventos - liga o Click de cada botao da barra
    *
    * Os 4 delegates sao PUBLIC (sem PROTECTED): BINDEVENT com delegate
    * PROTECTED falha em SILENCIO e o botao fica inerte (regra CLAUDE.md #3).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarEventos()
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnEmailClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - btnReport.Visualiza -> PROCEDURE visualizacao
    *
    * Sem ELSE de mensagem: o BO ja reporta a propria falha (FRX ausente,
    * cursor vazio, erro do REPORT FORM) e marca this_lErroExibido - um ELSE
    * aqui exibiria o segundo modal, de corpo vazio.
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        THIS.this_oRelatorio.Visualizar()
    ENDPROC

    *==========================================================================
    * BtnImprimirClick - btnReport.Imprime -> PROCEDURE impressao
    *==========================================================================
    PROCEDURE BtnImprimirClick()
        THIS.this_oRelatorio.Imprimir()
    ENDPROC

    *==========================================================================
    * BtnEmailClick - btnReport.DocExcel -> mesmo FRX com destino To File
    *==========================================================================
    PROCEDURE BtnEmailClick()
        THIS.this_oRelatorio.GerarExcel()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - btnReport.Sair -> fecha o dialogo
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * Destroy - solta a referencia ao BO do pai
    *
    * So anula a referencia: o BO pertence ao form PAI, que continua vivo
    * depois deste dialogo fechar. O cursor da consulta tambem nao eh tocado -
    * ele eh do chamador do pai.
    *
    * DODEFAULT() eh a ULTIMA linha, obrigatoriamente: FormBase.Destroy repoe
    * os pads do menu principal; sem ele o menu volta encolhido.
    *==========================================================================
    PROCEDURE Destroy()
        THIS.this_oRelatorio = .NULL.

        DODEFAULT()
    ENDPROC

ENDDEFINE
