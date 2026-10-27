*==============================================================================
* Formsigopcgb.prg
* Form Operacional: Pesquisa Global de Codigo de Barras (SIGOPCGB)
* Herda de: FormBase
* Tipo: OPERACIONAL - layout customizado (flat, sem PageFrame/abas)
* SCX Origem: sigopcgb.SCX
*
* A partir de um codigo de barras digitado, localiza a etiqueta (SigOpEtq),
* o produto (SigCdPro), monta o historico de movimentacao (SigMvHst/SigMvItn/
* SigMvIts/SigMvCab/SigMvMov) e as devolucoes em aberto (SigOpExi).
*
* Parametro Init: par_nCodBarra (opcional) - codigo de barras pre-selecionado
*
* Fase 3/8: Estrutura base (DEFINE CLASS, Init/InicializarForm, cabecalho)
* Fase 4/8: Grades de resultado (Historico/Movimento/Devolucao) ligadas aos
* seus cursores, botoes de acao (Imprimir/Visualizar/Movimento/
* Rastreabilidade/Etiquetas/Encerrar) com visibilidade por permissao, e a
* carga de dados (CarregarDados), que reproduz a parte do PROCEDURE
* Processamento do legado referente as grades.
* Form OPERACIONAL sem PageFrame (regra CLAUDE.md) - grades e botoes vao
* direto em THIS, nao em Page1/Page2. ATENCAO: o mapeamento.json gerado
* automaticamente colide as 3 grades no mesmo nome "grd_4c_Dados" - aqui
* cada grade recebe nome distinto (grd_4c_Historico/Movimento/Devolucao).
*
* Fase 5/8: Campos principais parte 1/2 (ConfigurarCamposPrincipais) - o
* campo de pesquisa do codigo de barras (txt_4c_Barras, equivalente ao
* getBarras legado, dentro do Shape1) e o bloco "Dados do Produto"
* (Shape2): produto/fornecedor/referencia/origem/colecao/categoria/precos
* encontrados pela pesquisa. Todos SOMENTE EXIBICAO (TabStop = .F.,
* equivalente ao Return(.F.) do When legado), exceto txt_4c_Barras. A
* fiacao do evento de pesquisa e o preenchimento destes campos a partir
* do BO ficam para fase posterior - esta fase cobre so o layout.
*
* Fase 7/8: Eventos principais dos botoes de acao, que ate aqui so tinham
* .Enabled controlado mas NENHUM Click ligado: Encerrar (obj_4c_CmdBtnForm,
* legado cmdBtnForm.btnSair.Click = ThisForm.Release), Imprimir/Visualizar
* (legado: Imagem('I')/Imagem('V') - cabecalho da etiqueta + REPORT FORM),
* Documento (legado: localiza o documento em SigMvCab/SigCdNec e abre
* FormSigMvExp/FormSigMvPdt), Rastreabilidade (legado: Do Form SigReCgr -
* ainda nao migrada, mesmo guard do BtnLocalClick) e o painel flutuante de
* correcao de etiquetas (legado: Botao_de_Correcao - cnt_4c_Correcao +
* grd_4c_Correcao, criados aqui porque so existiam no legado dentro deste
* Click). O SIGOPCGB nao tem Incluir/Alterar/Excluir - eh form de PESQUISA,
* sem CRUD de entidade propria (ver sigopcgbBO.prg, bloco final).
*
* Fase 8/8: eventos AUXILIARES e consolidacao. Os 53 eventos do dump legado
* passam a estar todos cobertos; faltavam QUATRO, todos do ciclo do campo de
* barras, e sem eles o form nao se comporta como o legado:
*   getBarras.GotFocus  -> BarrasGotFocus  (guard "peantvalue", this_nBarrasAnterior)
*   getBarras.LostFocus -> BarrasLostFocus (Valid + armar o timer de foco)
*   tmAux.Timer         -> TimerFocoBarras (devolve o foco e se DESARMA)
*   foca                -> FocarBarras
* O timer NAO eh enfeite: em VFP9 nao se devolve o foco a um controle de
* dentro do LostFocus dele, e o legado resolve exatamente com esse timer de
* 200ms - eh o que faz o leitor de codigo de barras funcionar em sequencia.
* Junto vieram tres acertos de fidelidade medidos contra o dump:
*   (a) o Valid legado so pesquisa quando o codigo MUDOU - sem esse guard a
*       pesquisa inteira (3 SELECT + 3 cursores) repetia a cada saida do campo,
*       e o funil ganhou guard de reentrancia em wrapper fino (regra #47);
*   (b) as DUAS linhas finais do ramo "Init com pBar" (travar o campo e levar o
*       foco ao Encerrar) - aberta de outra tela, a consulta eh de UM codigo;
*   (c) o When das 3 grades ("Return(!Empty(GetBarras.Value))") entrou no
*       AtualizarEstadoBotoes, que ja cuidava dos 6 botoes.
*
* NAO portados, de proposito:
*   Load ("=fConfigGeral()") - funcao GLOBAL de inicializacao do legado
*     Fortyus; em codigo nosso a inicializacao global mora no config.prg
*     (mesmo precedente de FormSigMvExp/FormSigMvMen).
*   ThisForm.Tpbusca - propriedade ESCRITA em tres pontos do legado (Init,
*     Init-com-pBar e getBarras.LostFocus) e NUNCA lida: estado morto.
*     Migra-la seria criar propriedade que ninguem consulta.
*==============================================================================

DEFINE CLASS Formsigopcgb AS FormBase

    *-- Propriedades visuais (pixel-perfect do SCX original - PILAR 1)
    Width        = 1000
    Height       = 600
    AutoCenter   = .T.
    Caption      = "Pesquisa Global de Codigo de Barras"
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    TitleBar     = 0
    ClipControls = .F.
    Themes       = .F.
    BorderStyle  = 2
    DataSession  = 2

    *-- Parametro recebido em Init (codigo de barras pre-selecionado, opcional)
    this_nCodBarraInicial = 0

    *-- Estado operacional (ThisForm.GradeSel no legado: 1=Historico 2=Movimento 3=Devolucao)
    this_nGradeSel        = 1

    *-- Valor do campo de barras na ENTRADA do campo (legado:
    *-- getBarras.peantvalue, gravado no GotFocus). O Valid legado so pesquisa
    *-- quando "This.peantvalue # This.Value", ou seja quando o usuario
    *-- realmente mudou o codigo - sem isso a pesquisa (3 SELECT + 3 cursores)
    *-- roda de novo a cada saida do campo.
    this_nBarrasAnterior  = 0

    *-- Guard de reentrancia do funil de pesquisa. ValidarBarras pode exibir
    *-- MsgErro (modal), o foco sai do campo e o proprio LostFocus redispara -
    *-- sem guard a pesquisa se empilha (regra CLAUDE.md #37/#47).
    this_lEmPesquisa      = .F.

    *==================================================================
    * Init - Armazena parametro antes de DODEFAULT (que chama InicializarForm)
    *==================================================================
    PROCEDURE Init(par_nCodBarra)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        THIS.this_nCodBarraInicial = IIF(VARTYPE(par_nCodBarra) = "N", par_nCodBarra, 0)

        loc_lResultado = DODEFAULT()
        RETURN loc_lResultado
    ENDPROC

    *==================================================================
    * InicializarForm - Cria o Business Object e monta o cabecalho
    *==================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigopcgbBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar sigopcgbBO. VARTYPE retornou: " + ;
                    VARTYPE(THIS.this_oBusinessObject), "Formsigopcgb.InicializarForm")
            ELSE
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
                THIS.Caption = "Pesquisa Global de C" + CHR(243) + "digo de Barras"

                THIS.ConfigurarCabecalho()
                THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Parametros que o Init legado le ANTES de montar as grades:
                *-- Habvalor decide a 11a coluna do Historico (Valor x Peso) e
                *-- o controle de lotes decide a visibilidade do Rastreabilidade.
                IF THIS.PodeConsultarBanco()
                    THIS.this_oBusinessObject.CarregarParametrosIniciais()
                ENDIF

                *-- Botoes de acao DEPOIS do cabecalho (flutuam por cima dele,
                *-- mesma regra do cnt_4c_Saida canonico - regra #11/CLAUDE.md)
                THIS.ConfigurarBotoesAcao()
                THIS.ConfigurarCamposPrincipais()
                THIS.ConfigurarCamposComplementares()
                THIS.ConfigurarPainelCorrecao()
                THIS.ConfigurarGrids()
                THIS.ConfigurarTimerFoco()

                *-- Cursores ANTES do bind: ControlSource de cursor inexistente
                *-- derruba o Init e a tela nao abre (regra #41/CLAUDE.md).
                THIS.CriarCursoresGrades()
                THIS.VincularGrades()
                THIS.ConfigurarBindings()

                THIS.AplicarAcessoBotoes()
                THIS.AtualizarEstadoBotoes(THIS.this_nCodBarraInicial)

                *-- Legado: If (Type([pBar])=[N]) And (GetBarras.Value > 0) ->
                *-- ThisForm.Processamento. Sem conexao (validacao de UI/teste
                *-- automatizado) nao ha o que consultar. Passa pelo mesmo
                *-- funil da digitacao manual (ValidarBarras), que tambem
                *-- carrega Produto/Posicao Atual, nao so as grades.
                IF THIS.this_nCodBarraInicial > 0 AND THIS.PodeConsultarBanco()
                    THIS.txt_4c_Barras.Value = THIS.this_nCodBarraInicial
                    THIS.ValidarBarras()

                    *-- Fase 8/8 - as DUAS linhas finais que o legado executa
                    *-- nesse mesmo ramo e que faltavam:
                    *--   ThisForm.cmdBtnForm.btnSair.SetFocus
                    *--   ThisForm.getBarras.Enabled = .f.
                    *-- Aberta COM codigo (chamada de outra tela), a pesquisa
                    *-- eh de UM codigo so: o campo fica travado e o foco vai
                    *-- para o Encerrar. Sem isso o usuario podia digitar
                    *-- outro codigo numa tela que o chamador abriu para
                    *-- consultar um especifico.
                    THIS.txt_4c_Barras.Enabled = .F.
                    THIS.obj_4c_CmdBtnForm.Buttons(1).SetFocus()
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em Formsigopcgb.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==================================================================
    * ConfigurarCabecalho - Container cinza escuro com titulo do form
    * (equivalente ao cntSombra do legado: Top=0, Left=0, Height=80,
    * BackColor=RGB(100,100,100) - criado direto no form, sem PageFrame)
    *==================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCnt

        THIS.AddObject("cnt_4c_Sombra", "Container")
        loc_oCnt = THIS.cnt_4c_Sombra
        WITH loc_oCnt
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackColor   = RGB(100, 100, 100)
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCnt.lbl_4c_Sombra
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .AutoSize      = .F.
            .Caption       = THIS.Caption
            .Height        = 40
            .Left          = 10
            .Top           = 18
            .Width         = 769
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCnt.lbl_4c_Titulo
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .WordWrap  = .T.
            .Alignment = 0
            .BackStyle = 0
            .AutoSize  = .F.
            .Caption   = THIS.Caption
            .Height    = 46
            .Left      = 10
            .Top       = 17
            .Width     = 769
            .ForeColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *==================================================================
    * ConfigurarBotoesAcao - Botoes de acao do form (legado: cmdBtnForm
    * CommandGroup com o botao Encerrar + 5 CommandButton avulsos Top=3
    * sobrepondo o cabecalho, Left=550..920). Posicoes/Picture/Caption
    * transcritos literalmente do dump (regra CLAUDE.md #25 - nunca
    * inventar nome de icone). O Enabled inicial (.F.) reproduz o estado
    * antes de qualquer busca - o When do legado eh
    * Return(!Empty(ThisForm.GetBarras.Value)) - e eh mantido por
    * AtualizarEstadoBotoes; a visibilidade por permissao fica em
    * AplicarAcessoBotoes.
    *
    * Os 5 botoes avulsos (fora de CommandGroup) tem .Picture E nascem
    * desabilitados: com Themes = .F. o icone NAO desenha em Enabled = .F.,
    * por isso levam Themes = .T. + DisabledPicture. O botao do
    * CommandGroup mantem Themes = .F. (padrao canonico do grupo).
    *==================================================================
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
        LOCAL loc_oGrp

        *-- obj_4c_CmdBtnForm (CommandGroup, 1 botao: Encerrar/Sair)
        THIS.AddObject("obj_4c_CmdBtnForm", "CommandGroup")
        loc_oGrp = THIS.obj_4c_CmdBtnForm
        WITH loc_oGrp
            .Top           = -2
            .Left          = 920
            .Width         = 85
            .Height        = 85
            .ButtonCount   = 1
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        WITH loc_oGrp.Buttons(1)
            .Top       = 5
            .Left      = 5
            .Width     = 75
            .Height    = 75
            .FontBold  = .T.
            .FontItalic = .T.
            .FontName  = "Comic Sans MS"
            .FontSize  = 8
            .Picture   = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel    = .T.
            .Caption   = "Encerrar"
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Themes    = .F.
        ENDWITH

        *-- cmd_4c_BtnImprimir
        THIS.AddObject("cmd_4c_BtnImprimir", "CommandButton")
        WITH THIS.cmd_4c_BtnImprimir
            .Top        = 3
            .Left       = 550
            .Width      = 75
            .Height     = 75
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .Picture    = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
            .Caption    = "Imprimir"
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes     = .T.
            .Enabled    = .F.
            .Visible    = .T.
        ENDWITH

        *-- cmd_4c_BtnVisualizar
        THIS.AddObject("cmd_4c_BtnVisualizar", "CommandButton")
        WITH THIS.cmd_4c_BtnVisualizar
            .Top        = 3
            .Left       = 625
            .Width      = 75
            .Height     = 75
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .Picture    = gc_4c_CaminhoIcones + "geral_video_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_video_60.jpg"
            .Caption    = "Visualizar"
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes     = .T.
            .Enabled    = .F.
            .Visible    = .T.
        ENDWITH

        *-- cmd_4c_BtnDocumento (abre a Movimentacao - SigReCgr no legado)
        THIS.AddObject("cmd_4c_BtnDocumento", "CommandButton")
        WITH THIS.cmd_4c_BtnDocumento
            .Top            = 3
            .Left           = 700
            .Width          = 75
            .Height         = 75
            .FontBold       = .T.
            .FontItalic     = .T.
            .FontName       = "Comic Sans MS"
            .FontSize       = 8
            .Picture        = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
            .Caption        = "Movimento"
            .ToolTipText    = "Movimenta" + CHR(231) + CHR(227) + "o"
            .PicturePosition = 13
            .ForeColor      = RGB(90, 90, 90)
            .BackColor      = RGB(255, 255, 255)
            .Themes         = .T.
            .Enabled        = .F.
            .Visible        = .T.
        ENDWITH

        *-- cmd_4c_BotRastro (rastreabilidade - oculto no legado: Visible=.F.)
        THIS.AddObject("cmd_4c_BotRastro", "CommandButton")
        WITH THIS.cmd_4c_BotRastro
            .Top         = 3
            .Left        = 775
            .Width       = 75
            .Height      = 75
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Comic Sans MS"
            .FontSize    = 8
            .Picture     = gc_4c_CaminhoIcones + "geral_pn_btn_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_pn_btn_60.jpg"
            .Caption     = "Rastreabil."
            .ToolTipText = "Rastrabealidade"
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .T.
            .Enabled     = .F.
            .Visible     = .F.
        ENDWITH

        *-- cmd_4c_BotaoCorrecao (legado: "Bot?o_de_Correcao", caption Etiquetas)
        THIS.AddObject("cmd_4c_BotaoCorrecao", "CommandButton")
        WITH THIS.cmd_4c_BotaoCorrecao
            .Top        = 3
            .Left       = 850
            .Width      = 75
            .Height     = 75
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .Picture    = gc_4c_CaminhoIcones + "geral_etiqueta_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_etiqueta_60.jpg"
            .Caption    = "Etiquetas"
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes     = .T.
            .Enabled    = .F.
            .Visible    = .T.
        ENDWITH
    ENDPROC

    *==================================================================
    * ConfigurarCamposPrincipais - Fase 5/8 (parte 1 de 2): campo de
    * pesquisa do codigo de barras (getBarras no legado, dentro do Shape1)
    * e o bloco "Dados do Produto" (Shape2) - os dados do produto
    * encontrado pela pesquisa (TmpPro no legado).
    *
    * Os campos deste bloco sao SOMENTE EXIBICAO: no legado todos tem
    * PROCEDURE When Return(.F.) (nunca recebem foco), exceto getBarras,
    * que eh a UNICA entrada editavel - reproduzido aqui com .TabStop = .F.
    * nos campos de exibicao. A fiacao do evento de pesquisa (KeyPress de
    * txt_4c_Barras) e o preenchimento destes campos a partir do BO ficam
    * para fase posterior (wiring), nao fazem parte desta fase (so layout).
    *
    * Posicoes/Caption/Width transcritos LITERALMENTE do dump do SCX
    * (regra CLAUDE.md #23/#28). Label sem Width no dump (classe say sem
    * override) recebe Width calculado = Left do campo vizinho - Left do
    * label - folga de ~3px (AutoSize=.T. eh no-op em Label por AddObject).
    *==================================================================
    PROTECTED PROCEDURE ConfigurarCamposPrincipais()

        *-- Shape1 - moldura do campo de pesquisa do codigo de barras
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 88
            .Left        = 761
            .Width       = 232
            .Height      = 31
            .BackStyle   = 0
            .FillStyle   = 1
            .ColorScheme = 1
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH

        *-- Say1 / getBarras - entrada do codigo de barras (UNICO campo
        *-- editavel deste metodo; os demais sao somente exibicao)
        THIS.AddObject("lbl_4c_CodBarra", "Label")
        WITH THIS.lbl_4c_CodBarra
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .Caption   = "C" + CHR(243) + "digo de Barra :"
            .Left      = 782
            .Top        = 96
            .Width      = 86
            .Height     = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Barras", "TextBox")
        WITH THIS.txt_4c_Barras
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 3
            .Format        = "Z"
            .Height        = 23
            .Left          = 870
            .Top           = 92
            .Width         = 112
            .MaxLength     = 14
            .SpecialEffect = 1
            .TabStop       = .T.
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- Shape2 - moldura do bloco "Dados do Produto"
        THIS.AddObject("shp_4c_Shape2", "Shape")
        WITH THIS.shp_4c_Shape2
            .Top         = 144
            .Left        = 10
            .Width       = 633
            .Height      = 106
            .BackStyle   = 0
            .BorderStyle = 6
            .FillStyle   = 1
            .ColorScheme = 1
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_TituloDadosProduto", "Label")
        WITH THIS.lbl_4c_TituloDadosProduto
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .Caption   = " Dados do Produto "
            .Left      = 10
            .Top       = 130
            .Width     = 108
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Linha 1: Produto (getCProduto/getDProduto) e Origem (getOrigem)
        THIS.AddObject("lbl_4c_Produto", "Label")
        WITH THIS.lbl_4c_Produto
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .Caption   = "Produto :"
            .Left      = 42
            .Top       = 154
            .Width     = 46
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_CProduto", "TextBox")
        WITH THIS.txt_4c_CProduto
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 23
            .Left          = 91
            .Top           = 150
            .Width         = 108
            .SpecialEffect = 1
            .Themes        = .F.
            .TabStop       = .F.
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DProduto", "TextBox")
        WITH THIS.txt_4c_DProduto
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 23
            .Left          = 201
            .Top           = 150
            .Width         = 290
            .SpecialEffect = 1
            .Themes        = .F.
            .TabStop       = .F.
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Origem", "Label")
        WITH THIS.lbl_4c_Origem
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .Caption   = "Origem :"
            .Left      = 514
            .Top       = 154
            .Width     = 43
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Origem", "TextBox")
        WITH THIS.txt_4c_Origem
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 23
            .Left          = 559
            .Top           = 150
            .Width         = 31
            .SpecialEffect = 1
            .Themes        = .F.
            .TabStop       = .F.
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Linha 2: Fornecedor (getCFornecedor/getDFornecedor) e Grp Vda (getColecoes)
        THIS.AddObject("lbl_4c_Fornecedor", "Label")
        WITH THIS.lbl_4c_Fornecedor
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .Caption   = "Fornecedor :"
            .Left      = 25
            .Top       = 179
            .Width     = 64
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_CFornecedor", "TextBox")
        WITH THIS.txt_4c_CFornecedor
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 23
            .Left          = 91
            .Top           = 175
            .Width         = 108
            .SpecialEffect = 1
            .Themes        = .F.
            .TabStop       = .F.
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DFornecedor", "TextBox")
        WITH THIS.txt_4c_DFornecedor
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 23
            .Left          = 201
            .Top           = 175
            .Width         = 290
            .SpecialEffect = 1
            .Themes        = .F.
            .TabStop       = .F.
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_GrpVda", "Label")
        WITH THIS.lbl_4c_GrpVda
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .Caption   = "Grp Vda :"
            .Left      = 510
            .Top       = 179
            .Width     = 47
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Colecoes", "TextBox")
        WITH THIS.txt_4c_Colecoes
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 23
            .Left          = 559
            .Top           = 175
            .Width         = 80
            .SpecialEffect = 1
            .Themes        = .F.
            .TabStop       = .F.
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Linha 3: Referencia (getReferencia), Referencia/GetBarra (cbars_old) e Colecao (GetCat)
        THIS.AddObject("lbl_4c_Referencia", "Label")
        WITH THIS.lbl_4c_Referencia
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .Caption   = "Refer" + CHR(234) + "ncia :"
            .Left      = 28
            .Top       = 204
            .Width     = 60
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Referencia", "TextBox")
        WITH THIS.txt_4c_Referencia
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 23
            .Left          = 91
            .Top           = 200
            .Width         = 150
            .SpecialEffect = 1
            .Themes        = .F.
            .TabStop       = .F.
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Legado: Say10 repete o caption "Referencia :" para o campo
        *-- GetBarra (que na verdade guarda o cbars_old da etiqueta
        *-- renumerada) - transcrito LITERALMENTE do dump, nao corrigido
        *-- (regra CLAUDE.md #23: so corrige Left/Width, nunca inventa
        *-- caption diferente do que o legado tem).
        THIS.AddObject("lbl_4c_Referencia2", "Label")
        WITH THIS.lbl_4c_Referencia2
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .Caption   = "Refer" + CHR(234) + "ncia :"
            .Left      = 261
            .Top       = 204
            .Width     = 60
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Barra", "TextBox")
        WITH THIS.txt_4c_Barra
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 23
            .Left          = 324
            .Top           = 200
            .Width         = 150
            .SpecialEffect = 1
            .Themes        = .F.
            .TabStop       = .F.
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Colecao", "Label")
        WITH THIS.lbl_4c_Colecao
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .Caption   = "Cole" + CHR(231) + CHR(227) + "o :"
            .Left      = 457
            .Top       = 229
            .Width     = 46
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Cat", "TextBox")
        WITH THIS.txt_4c_Cat
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 23
            .Left          = 506
            .Top           = 225
            .Width         = 133
            .SpecialEffect = 1
            .Themes        = .F.
            .TabStop       = .F.
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Linha 4: Precos De (GetPrecoDe) e Precos de Venda (getPVenda)
        THIS.AddObject("lbl_4c_PrecosDe", "Label")
        WITH THIS.lbl_4c_PrecosDe
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .Caption   = "Pre" + CHR(231) + "os De :"
            .Left      = 265
            .Top       = 229
            .Width     = 56
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_PrecoDe", "TextBox")
        WITH THIS.txt_4c_PrecoDe
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 23
            .InputMask     = "999,999.99"
            .Left          = 324
            .Top           = 225
            .Width         = 118
            .SpecialEffect = 1
            .Themes        = .F.
            .TabStop       = .F.
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_PrecosVenda", "Label")
        WITH THIS.lbl_4c_PrecosVenda
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .Caption   = "Pre" + CHR(231) + "os de Venda:"
            .Left      = 35
            .Top       = 229
            .Width     = 85
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_PVenda", "TextBox")
        WITH THIS.txt_4c_PVenda
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 23
            .InputMask     = "999,999.99"
            .Left          = 123
            .Top           = 225
            .Width         = 118
            .SpecialEffect = 1
            .Themes        = .F.
            .TabStop       = .F.
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = 0
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *==================================================================
    * ConfigurarCamposComplementares - Fase 6/8 (ultimos 50% dos campos):
    *
    * 1) Bloco "Posicao Atual do Codigo de Barras" (Shape7): Empresa/Grupo/
    *    Conta/Qtde/Peso da etiqueta (TmpEti no legado) - somente exibicao.
    * 2) Imagem do produto (Shape5/ImgFigJpg).
    * 3) Campo Local (dentro do Shape2, "Dados do Produto") + botao "..."
    *    que abre a tela de correcao de localizacao (SigOpCgl no legado).
    * 4) Titulos/molduras das secoes de grade: Historico (Shape3), "Codigos
    *    de Barras Sem Historico" (Shape6, com o produto da linha corrente
    *    de Movimento - GetCProSHis/GetDProSHis) e Devolucao (Shape9).
    * 5) Checkbox + painel de Cotacoes (Bot_Cotacoes/grdCot) - a grade
    *    propriamente dita (grd_4c_Cotacoes) eh criada em ConfigurarGrids,
    *    junto com as outras 3, para manter o padrao Criar/Vincular.
    *
    * Todos os campos de exibicao (TabStop=.F.) sao preenchidos pelo funil
    * de pesquisa (ValidarBarras/AtualizarCamposEtiqueta/AtualizarCamposProduto),
    * nao por ControlSource - igual ao padrao da fase anterior.
    *==================================================================
    PROTECTED PROCEDURE ConfigurarCamposComplementares()

        *-- Shape7 - moldura "Posicao Atual do Codigo de Barras"
        THIS.AddObject("shp_4c_Shape7", "Shape")
        WITH THIS.shp_4c_Shape7
            .Top         = 144
            .Left        = 648
            .Width       = 344
            .Height      = 106
            .BackStyle   = 0
            .BorderStyle = 6
            .FillStyle   = 1
            .ColorScheme = 1
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_PosicaoAtual", "Label")
        WITH THIS.lbl_4c_PosicaoAtual
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .Caption   = "Posi" + CHR(231) + CHR(227) + "o Atual do C" + CHR(243) + "digo de Barras"
            .Left      = 648
            .Top       = 130
            .Width     = 193
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Linha 1: Empresa
        THIS.AddObject("lbl_4c_Emp", "Label")
        WITH THIS.lbl_4c_Emp
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .Caption   = "Emp :"
            .Left      = 713
            .Top       = 154
            .Width     = 29
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Empresa", "TextBox")
        WITH THIS.txt_4c_Empresa
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K!"
            .Height        = 23
            .Left          = 744
            .Top           = 150
            .Width         = 31
            .MaxLength     = 3
            .SpecialEffect = 1
            .Themes        = .F.
            .TabStop       = .F.
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Linha 2: Grupo e Qtd(1)
        THIS.AddObject("lbl_4c_Grupo", "Label")
        WITH THIS.lbl_4c_Grupo
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .Caption   = "Grupo :"
            .Left      = 704
            .Top       = 177
            .Width     = 38
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Grupo", "TextBox")
        WITH THIS.txt_4c_Grupo
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K!"
            .Height        = 23
            .Left          = 744
            .Top           = 173
            .Width         = 80
            .MaxLength     = 10
            .SpecialEffect = 1
            .Themes        = .F.
            .TabStop       = .F.
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Qtd1", "Label")
        WITH THIS.lbl_4c_Qtd1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .Caption   = "Qtd(1).:"
            .Left      = 836
            .Top       = 177
            .Width     = 42
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Qtde", "TextBox")
        WITH THIS.txt_4c_Qtde
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "9,999.999"
            .Height        = 23
            .Left          = 880
            .Top           = 173
            .Width         = 74
            .MaxLength     = 10
            .SpecialEffect = 1
            .Themes        = .F.
            .TabStop       = .F.
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- Linha 3: Conta e Qtd(2)
        THIS.AddObject("lbl_4c_Conta", "Label")
        WITH THIS.lbl_4c_Conta
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .Caption   = "Conta :"
            .Left      = 704
            .Top       = 203
            .Width     = 38
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Conta", "TextBox")
        WITH THIS.txt_4c_Conta
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K!"
            .Alignment     = 0
            .Height        = 23
            .Left          = 744
            .Top           = 199
            .Width         = 80
            .MaxLength     = 10
            .SpecialEffect = 1
            .Themes        = .F.
            .TabStop       = .F.
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Qtd2", "Label")
        WITH THIS.lbl_4c_Qtd2
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .Caption   = "Qtd(2).:"
            .Left      = 836
            .Top       = 203
            .Width     = 42
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Peso", "TextBox")
        WITH THIS.txt_4c_Peso
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "9999.99"
            .Height        = 23
            .Left          = 880
            .Top           = 199
            .Width         = 74
            .MaxLength     = 10
            .SpecialEffect = 1
            .Themes        = .F.
            .TabStop       = .F.
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- Campo Local + botao "..." (dentro do bloco "Dados do Produto")
        THIS.AddObject("lbl_4c_Local", "Label")
        WITH THIS.lbl_4c_Local
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .Caption   = "Local :"
            .Left      = 709
            .Top       = 228
            .Width     = 33
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Local", "TextBox")
        WITH THIS.txt_4c_Local
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 23
            .Left          = 744
            .Top           = 224
            .Width         = 80
            .SpecialEffect = 1
            .Themes        = .F.
            .TabStop       = .F.
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- bot?o_da_barra no legado: botao pequeno "..." ao lado do campo,
        *-- abre a tela de correcao de localizacao (SigOpCgl). Enabled fica
        *-- a cargo de AtualizarEstadoBotoes, igual aos outros botoes de acao
        *-- (When legado: Return(!Empty(ThisForm.GetBarras.Value))).
        THIS.AddObject("cmd_4c_BtnLocal", "CommandButton")
        WITH THIS.cmd_4c_BtnLocal
            .Top        = 225
            .Left       = 826
            .Width      = 23
            .Height     = 23
            .FontBold   = .T.
            .FontName   = "Comic Sans MS"
            .FontSize   = 9
            .Caption    = "..."
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes     = .F.
            .Enabled    = .F.
            .Visible    = .T.
        ENDWITH

        *-- Shape5 + imagem do produto pesquisado/linha selecionada
        THIS.AddObject("shp_4c_Shape5", "Shape")
        WITH THIS.shp_4c_Shape5
            .Top         = 282
            .Left        = 802
            .Width       = 159
            .Height      = 126
            .BackStyle   = 0
            .BorderStyle = 6
            .FillStyle   = 1
            .ColorScheme = 1
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH

        THIS.AddObject("img_4c_FigJpg", "Image")
        WITH THIS.img_4c_FigJpg
            .Stretch = 1
            .Enabled = .F.
            .Top     = 288
            .Left    = 807
            .Width   = 148
            .Height  = 115
            .Picture = ""
            .Visible = .F.
        ENDWITH

        *-- Titulo da secao "Historico do Codigo de Barras" + moldura (a
        *-- grade grd_4c_Historico ja foi posicionada dentro desta moldura
        *-- em Fase 4/8)
        THIS.AddObject("lbl_4c_TituloHistorico", "Label")
        WITH THIS.lbl_4c_TituloHistorico
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .Caption   = " Hist" + CHR(243) + "rico do C" + CHR(243) + "digo de Barras "
            .Left      = 15
            .Top       = 251
            .Width     = 173
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("shp_4c_Shape3", "Shape")
        WITH THIS.shp_4c_Shape3
            .Top         = 268
            .Left        = 10
            .Width       = 762
            .Height      = 180
            .BackStyle   = 0
            .BorderStyle = 6
            .FillStyle   = 1
            .ColorScheme = 1
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH

        *-- Titulo "Codigos de Barras Sem Historico" + moldura + produto da
        *-- linha corrente da grade de Movimento (grd_4c_Movimento tambem ja
        *-- foi posicionada dentro desta moldura em Fase 4/8)
        THIS.AddObject("lbl_4c_TituloSemHistorico", "Label")
        WITH THIS.lbl_4c_TituloSemHistorico
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .Caption   = " C" + CHR(243) + "digos de Barras Sem Hist" + CHR(243) + "rico "
            .Left      = 15
            .Top        = 452
            .Width      = 190
            .Height     = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("shp_4c_Shape6", "Shape")
        WITH THIS.shp_4c_Shape6
            .Top         = 466
            .Left        = 10
            .Width       = 551
            .Height      = 128
            .BackStyle   = 0
            .BorderStyle = 6
            .FillStyle   = 1
            .ColorScheme = 1
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_ProdutoSemHistorico", "Label")
        WITH THIS.lbl_4c_ProdutoSemHistorico
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .Caption   = "Produto :"
            .Left      = 30
            .Top       = 570
            .Width     = 46
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_CProdutoSemHistorico", "TextBox")
        WITH THIS.txt_4c_CProdutoSemHistorico
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 23
            .Left          = 79
            .Top           = 568
            .Width         = 108
            .SpecialEffect = 1
            .Themes        = .F.
            .TabStop       = .F.
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DProdutoSemHistorico", "TextBox")
        WITH THIS.txt_4c_DProdutoSemHistorico
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 23
            .Left          = 188
            .Top           = 568
            .Width         = 287
            .SpecialEffect = 1
            .Themes        = .F.
            .TabStop       = .F.
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Titulo "Devolucao" + moldura (grd_4c_Devolucao ja posicionada em
        *-- Fase 4/8)
        THIS.AddObject("lbl_4c_Devolucao", "Label")
        WITH THIS.lbl_4c_Devolucao
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .Caption   = "Devolu" + CHR(231) + CHR(227) + "o"
            .Left      = 569
            .Top       = 453
            .Width     = 61
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("shp_4c_Shape9", "Shape")
        WITH THIS.shp_4c_Shape9
            .Top         = 466
            .Left        = 564
            .Width       = 423
            .Height      = 128
            .BackStyle   = 0
            .BorderStyle = 6
            .FillStyle   = 1
            .ColorScheme = 1
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH

        *-- Checkbox "Cotacoes" (liga/desliga o painel cnt_4c_GrdCot) + o
        *-- proprio painel. A grade interna (grd_4c_Cotacoes) eh criada
        *-- em ConfigurarGrids/CriarGradeCotacoes, apos o container existir.
        THIS.AddObject("chk_4c_BotCotacoes", "CheckBox")
        WITH THIS.chk_4c_BotCotacoes
            .Top          = 425
            .Left         = 781
            .Width        = 33
            .Height       = 26
            .FontName     = "Verdana"
            .FontSize     = 8
            .Picture      = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
            .Alignment    = 0
            .BackStyle    = 0
            .Caption      = ""
            .Style        = 1
            .SpecialEffect = 0
            .ToolTipText  = "Mostra C" + CHR(226) + "mbio das moedas na data"
            .ForeColor    = RGB(36, 84, 155)
            .BackColor    = RGB(255, 255, 255)
            .Themes       = .F.
            .Value        = 0
            .Visible      = .T.
        ENDWITH

        THIS.AddObject("cnt_4c_GrdCot", "Container")
        WITH THIS.cnt_4c_GrdCot
            .Top          = 274
            .Left         = 816
            .Width        = 177
            .Height       = 176
            .SpecialEffect = 2
            .BackColor    = RGB(255, 255, 255)
            .BorderColor  = RGB(90, 90, 90)
            .Visible      = .F.
        ENDWITH

        THIS.cnt_4c_GrdCot.AddObject("lbl_4c_TituloCotacoes", "Label")
        WITH THIS.cnt_4c_GrdCot.lbl_4c_TituloCotacoes
            .AutoSize  = .F.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = "T" + CHR(237) + "tulo da Grade"
            .Left      = 3
            .Top       = 7
            .Width     = 170
            .Height    = 16
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *==================================================================
    * ConfigurarPainelCorrecao - Painel flutuante de correcao de etiquetas
    * (legado: Cnt_Correcao - Visible=.F. por padrao, mostrado pelo
    * BotaoCorrecaoClick). Container + titulo + grade (grd_4c_Correcao,
    * criada em CriarGradeCorrecao, depois que o container ja existe - mesma
    * ordem de cnt_4c_GrdCot/grd_4c_Cotacoes) + botao de fechar (legado:
    * Cnt_Correcao.cmdBtnForm.btnSair.Click - so esconde o painel e reabilita
    * os demais controles, NAO fecha o form).
    *
    * .Top eh recalculado em runtime pelo BotaoCorrecaoClick, igual ao
    * legado ((ThisForm.Height / 2) - (.Height / 2)) - o valor aqui eh so o
    * ponto de partida (.Left/.Width/.Height do dump).
    *==================================================================
    PROTECTED PROCEDURE ConfigurarPainelCorrecao()
        THIS.AddObject("cnt_4c_Correcao", "Container")
        WITH THIS.cnt_4c_Correcao
            .Top           = 322
            .Left          = 252
            .Width         = 556
            .Height        = 182
            .SpecialEffect = 0
            .BackColor     = RGB(255, 255, 255)
            .BorderColor   = RGB(90, 90, 90)
            .Visible       = .F.
        ENDWITH

        THIS.cnt_4c_Correcao.AddObject("lbl_4c_TituloCorrecao", "Label")
        WITH THIS.cnt_4c_Correcao.lbl_4c_TituloCorrecao
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .Caption   = "Corre" + CHR(231) + CHR(245) + "es do C" + CHR(243) + "digo de Barras"
            .Left      = 2
            .Top       = 5
            .Width     = 423
            .Height    = 17
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_Correcao.AddObject("obj_4c_CmdCorrecao", "CommandGroup")
        WITH THIS.cnt_4c_Correcao.obj_4c_CmdCorrecao
            .Top         = -1
            .Left        = 471
            .Width       = 85
            .Height      = 85
            .ButtonCount = 1
            .BackStyle   = 0
            .BorderStyle = 0
            .Themes      = .F.
            .Visible     = .T.
        ENDWITH

        WITH THIS.cnt_4c_Correcao.obj_4c_CmdCorrecao.Buttons(1)
            .Top        = 5
            .Left       = 5
            .Width      = 75
            .Height     = 75
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel     = .T.
            .Caption    = "Encerrar"
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes     = .F.
        ENDWITH
    ENDPROC

    *==================================================================
    * ConfigurarGrids - As 3 grades de resultado do legado (fwgrade),
    * criadas direto em THIS (form OPERACIONAL sem PageFrame). Larguras
    * de coluna, Header1.Caption e ReadOnly transcritos literalmente do
    * dump do SCX (grdMovimento/grdHistorico/grddevolucao). Nomes
    * distintos (Historico/Movimento/Devolucao) porque o mapeamento.json
    * gerado automaticamente colidiu as 3 grades em "grd_4c_Dados".
    *
    * Aqui ficam SO as propriedades que nao dependem de dado. O
    * RecordSource/ControlSource de cada coluna vai em VincularGrades, que
    * roda depois de CriarCursoresGrades - ControlSource de cursor que ainda
    * nao existe derruba o Init e a tela nao abre (regra CLAUDE.md #41).
    *==================================================================
    PROTECTED PROCEDURE ConfigurarGrids()
        THIS.CriarGradeHistorico()
        THIS.CriarGradeMovimento()
        THIS.CriarGradeDevolucao()
        THIS.CriarGradeCotacoes()
        THIS.CriarGradeCorrecao()
    ENDPROC

    *==================================================================
    * ConfigurarTimerFoco - tmr_4c_FocoBarras (legado: tmAux, Timer com
    * Interval = 200).
    *
    * NAO eh enfeite: em VFP9 nao se pode devolver o foco a um controle de
    * DENTRO do LostFocus dele - a chamada eh ignorada. O legado resolve
    * exatamente assim, armando um timer de 200ms no LostFocus; o Timer
    * chama ThisForm.foca() (que faz getBarras.SetFocus) e se DESARMA
    * (This.Enabled = .F.), ou seja eh um "one-shot".
    *
    * Nasce DESARMADO: em VFP9 Timer.Enabled tem default .T., e um timer
    * armado no Init roubaria o foco do primeiro controle da tela a cada
    * 200ms antes de qualquer digitacao.
    *==================================================================
    PROTECTED PROCEDURE ConfigurarTimerFoco()
        THIS.AddObject("tmr_4c_FocoBarras", "Timer")

        WITH THIS.tmr_4c_FocoBarras
            .Interval = 200
            .Enabled  = .F.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarGradeHistorico - grd_4c_Historico (legado: grdHistorico, 11 colunas)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarGradeHistorico()
        LOCAL loc_oGrd

        THIS.AddObject("grd_4c_Historico", "Grid")
        loc_oGrd = THIS.grd_4c_Historico
        WITH loc_oGrd
            .Top         = 276
            .Left        = 15
            .Width       = 750
            .Height      = 166
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ColumnCount = 11
            .DeleteMark  = .F.
            .RecordMark  = .F.
            .ReadOnly    = .T.
            .Visible     = .T.
        ENDWITH

    ENDPROC

    *--------------------------------------------------------------------------
    * CriarGradeMovimento - grd_4c_Movimento (legado: grdMovimento, 8 colunas)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarGradeMovimento()
        LOCAL loc_oGrd

        THIS.AddObject("grd_4c_Movimento", "Grid")
        loc_oGrd = THIS.grd_4c_Movimento
        WITH loc_oGrd
            .Top         = 474
            .Left        = 14
            .Width       = 544
            .Height      = 94
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ColumnCount = 8
            .DeleteMark  = .F.
            .RecordMark  = .F.
            .ReadOnly    = .T.
            .Visible     = .T.
        ENDWITH

    ENDPROC

    *--------------------------------------------------------------------------
    * CriarGradeDevolucao - grd_4c_Devolucao (legado: grddevolucao, 6 colunas)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarGradeDevolucao()
        LOCAL loc_oGrd

        THIS.AddObject("grd_4c_Devolucao", "Grid")
        loc_oGrd = THIS.grd_4c_Devolucao
        WITH loc_oGrd
            .Top         = 474
            .Left        = 568
            .Width       = 414
            .Height      = 94
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ColumnCount = 6
            .DeleteMark  = .F.
            .RecordMark  = .F.
            .ReadOnly    = .T.
            .Visible     = .T.
        ENDWITH

    ENDPROC

    *--------------------------------------------------------------------------
    * CriarGradeCotacoes - grd_4c_Cotacoes (legado: grdCot.grade_Cot, 2
    * colunas), dentro do container cnt_4c_GrdCot (que ja foi criado em
    * ConfigurarCamposComplementares - a grade PRECISA do container pai).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarGradeCotacoes()
        LOCAL loc_oGrd

        THIS.cnt_4c_GrdCot.AddObject("grd_4c_Cotacoes", "Grid")
        loc_oGrd = THIS.cnt_4c_GrdCot.grd_4c_Cotacoes
        WITH loc_oGrd
            .Top           = 26
            .Left          = 6
            .Width         = 164
            .Height        = 147
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ColumnCount   = 2
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .ReadOnly      = .T.
            .RowHeight     = 16
            .ScrollBars    = 2
            .GridLineColor = RGB(238, 238, 238)
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarGradeCorrecao - grd_4c_Correcao (legado: Cnt_Correcao.GrdCorrecao,
    * 6 colunas), dentro do container cnt_4c_Correcao (criado em
    * ConfigurarPainelCorrecao - a grade PRECISA do container pai).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarGradeCorrecao()
        LOCAL loc_oGrd

        THIS.cnt_4c_Correcao.AddObject("grd_4c_Correcao", "Grid")
        loc_oGrd = THIS.cnt_4c_Correcao.grd_4c_Correcao
        WITH loc_oGrd
            .Top         = 27
            .Left        = 6
            .Width       = 447
            .Height      = 146
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ColumnCount = 6
            .DeleteMark  = .F.
            .RecordMark  = .F.
            .ReadOnly    = .T.
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarColunaGrade - aplica Width/Header1.Caption/estilo de coluna
    * comum as 3 grades (Tahoma 8, Alignment=2 no header - direita - igual
    * ao dump; Text1 BorderStyle=0/Margin=0/ReadOnly=.T. - sem coluna
    * editavel nestas grades de resultado).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarColunaGrade(par_oGrd, par_nCol, par_nWidth, par_cCaption)
        LOCAL loc_oCol
        loc_oCol = par_oGrd.Columns(par_nCol)

        WITH loc_oCol
            .Width     = par_nWidth
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH

        WITH loc_oCol.Header1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 2
            .Caption   = par_cCaption
        ENDWITH

        WITH loc_oCol.Text1
            .BorderStyle = 0
            .Margin      = 0
            .ReadOnly    = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *==================================================================
    * CriarCursoresGrades - Cria os cursores que alimentam as 3 grades.
    *
    * Estrutura de cursor_4c_Historico e cursor_4c_Movimento transcrita
    * literalmente do Init legado (CsHistorico/CsMovimento), com os MESMOS
    * indices - EmpDopNum e OriDopNums sao usados por SEEK no BO para decidir
    * se o movimento ja tem historico, e DtOpers eh a ordem de exibicao.
    *
    * Os tres cursores sao criados UMA UNICA VEZ, aqui, e so sao esvaziados
    * (ZAP) e repopulados pelo BO - nunca derrubados por SQLEXEC, que zeraria
    * o ColumnCount das grades ligadas a eles.
    *
    * cursor_4c_Devolucao nao existe no legado como cursor proprio: la o
    * SQLEXEC das barras devolvidas ia DIRETO para o alias da grade. As
    * colunas abaixo tem os nomes EXATOS dos aliases daquele SELECT, porque
    * o APPEND FROM do BO casa por NOME.
    *==================================================================
    PROTECTED PROCEDURE CriarCursoresGrades()
        *-- Grade de Historico (CsHistorico no legado)
        IF USED("cursor_4c_Historico")
            USE IN cursor_4c_Historico
        ENDIF

        SET NULL ON
        CREATE CURSOR cursor_4c_Historico ;
            (codbarras N(14), cpros C(14), emps C(3), dopes C(20), numes N(6), ;
             datas D, grupos C(10), estos C(10), opers C(1), codcors C(4), ;
             codtams C(4), valor N(12,2), Qtds N(9,3), Pesos N(9,3), OriDopNums C(29))
        SET NULL OFF

        INDEX ON emps + dopes + STR(numes, 6) TAG EmpDopNum
        INDEX ON OriDopNums TAG OriDopNums
        INDEX ON DTOS(datas) TAG DtOpers

        *-- Grade de Movimento (CsMovimento no legado)
        IF USED("cursor_4c_Movimento")
            USE IN cursor_4c_Movimento
        ENDIF

        SET NULL ON
        CREATE CURSOR cursor_4c_Movimento ;
            (codbarras N(14), cpros C(14), emps C(3), dopes C(20), numes N(6), ;
             datas D, opers C(1), valor N(12,2), Qtds N(12,3), Pesos N(12,3), ;
             OriDopNums C(29))
        SET NULL OFF

        INDEX ON DTOS(datas) TAG DtOpers

        *-- Grade de Devolucao (crSigOpexi no legado).
        *-- SET NULL ON eh obrigatorio: SigOpExi.datas aceita NULL no banco e o
        *-- APPEND FROM do BO falharia num campo declarado NOT NULL.
        *-- Desvio documentado: datas aqui eh DATE e no legado era o datetime
        *-- cru do SQL Server. A coluna da grade tem 70px (nao cabe a hora) e as
        *-- duas grades irmas usam DATE no mesmo campo "Data".
        IF USED("cursor_4c_Devolucao")
            USE IN cursor_4c_Devolucao
        ENDIF

        SET NULL ON
        CREATE CURSOR cursor_4c_Devolucao ;
            (datas D NULL, opers C(1) NULL, emps C(3) NULL, dopes C(20) NULL, ;
             numes N(10) NULL, OriDopNums C(29) NULL, valors N(11,2) NULL)
        SET NULL OFF

        *-- Sem indice de proposito: o legado NAO reordena a grade de devolucao
        *-- (exibe na ordem do SELECT). Indexar por DTOS(datas) aqui exigiria
        *-- chave de indice sobre data NULL, que eh justamente o caso que
        *-- SigOpExi.datas permite.

        *-- Grade de Cotacoes (TmpCot no legado: Select cmoes, 0000.000 as
        *-- valos From SigCdCot Group By cmoes)
        IF USED("cursor_4c_Cotacoes")
            USE IN cursor_4c_Cotacoes
        ENDIF

        CREATE CURSOR cursor_4c_Cotacoes (cmoes C(3), valos N(11, 6))

        *-- Grade do painel de Correcao (CrSigEtHst no legado: Select * From
        *-- SigEtHst Where cbars = <codbarras> - so as colunas usadas pela
        *-- grade). SigEtHst.datas aceita NULL no banco - SET NULL ON evita
        *-- que o APPEND FROM do BO falhe num campo NOT NULL por acidente.
        IF USED("cursor_4c_Correcao")
            USE IN cursor_4c_Correcao
        ENDIF

        SET NULL ON
        CREATE CURSOR cursor_4c_Correcao ;
            (datas T NULL, cpros C(14), pesos N(8,2), codcors C(4), codtams C(4), usuars C(10))
        SET NULL OFF
    ENDPROC

    *==================================================================
    * VincularGrades - Liga cada grade ao seu cursor. Roda DEPOIS de
    * CriarCursoresGrades (os cursores precisam existir: ControlSource de
    * cursor inexistente derruba o Init) e DEPOIS de ConfigurarGrids.
    *
    * Ordem obrigatoria por coluna: RecordSource -> ControlSource -> Width ->
    * Header1.Caption. Mexer em RecordSource/ControlSource faz o VFP recalcular
    * as larguras para o default, entao Width/Caption vem por ULTIMO.
    *
    * A 11a coluna da grade de Historico eh a unica condicional, igual ao
    * legado: com Habvalor mostra "valor" (caption "Valor"); sem Habvalor
    * mostra "Pesos" e mantem o caption desenhado no SCX.
    *==================================================================
    PROTECTED PROCEDURE VincularGrades()
        LOCAL loc_oGrd, loc_lHabValor

        loc_lHabValor = .F.
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_lHabValor = THIS.this_oBusinessObject.this_lHabilitaValor
        ENDIF

        *-- Grade de Historico
        loc_oGrd = THIS.grd_4c_Historico
        loc_oGrd.ColumnCount = 11
        loc_oGrd.RecordSource = "cursor_4c_Historico"

        loc_oGrd.Column1.ControlSource  = "cursor_4c_Historico.datas"
        loc_oGrd.Column2.ControlSource  = "cursor_4c_Historico.opers"
        loc_oGrd.Column3.ControlSource  = "cursor_4c_Historico.emps"
        loc_oGrd.Column4.ControlSource  = "cursor_4c_Historico.dopes"
        loc_oGrd.Column5.ControlSource  = "cursor_4c_Historico.numes"
        loc_oGrd.Column6.ControlSource  = "cursor_4c_Historico.grupos"
        loc_oGrd.Column7.ControlSource  = "cursor_4c_Historico.estos"
        loc_oGrd.Column8.ControlSource  = "cursor_4c_Historico.codcors"
        loc_oGrd.Column9.ControlSource  = "cursor_4c_Historico.codtams"
        loc_oGrd.Column10.ControlSource = "cursor_4c_Historico.Qtds"

        IF loc_lHabValor
            loc_oGrd.Column11.ControlSource = "cursor_4c_Historico.valor"
        ELSE
            loc_oGrd.Column11.ControlSource = "cursor_4c_Historico.Pesos"
        ENDIF

        THIS.ConfigurarColunaGrade(loc_oGrd, 1,  69,  "Data")
        THIS.ConfigurarColunaGrade(loc_oGrd, 2,  15,  "O")
        THIS.ConfigurarColunaGrade(loc_oGrd, 3,  28,  "Emp")
        THIS.ConfigurarColunaGrade(loc_oGrd, 4,  203, "Movimenta" + CHR(231) + CHR(227) + "o")
        THIS.ConfigurarColunaGrade(loc_oGrd, 5,  50,  "C" + CHR(243) + "digo")
        THIS.ConfigurarColunaGrade(loc_oGrd, 6,  75,  "Grupo")
        THIS.ConfigurarColunaGrade(loc_oGrd, 7,  75,  "Conta")
        THIS.ConfigurarColunaGrade(loc_oGrd, 8,  32,  "Cor")
        THIS.ConfigurarColunaGrade(loc_oGrd, 9,  32,  "Tam")
        THIS.ConfigurarColunaGrade(loc_oGrd, 10, 70,  "Qtd")
        THIS.ConfigurarColunaGrade(loc_oGrd, 11, 70,  IIF(loc_lHabValor, "Valor", "Qtd"))

        *-- Grade de Movimento
        loc_oGrd = THIS.grd_4c_Movimento
        loc_oGrd.ColumnCount = 8
        loc_oGrd.RecordSource = "cursor_4c_Movimento"

        loc_oGrd.Column1.ControlSource = "cursor_4c_Movimento.datas"
        loc_oGrd.Column2.ControlSource = "cursor_4c_Movimento.opers"
        loc_oGrd.Column3.ControlSource = "cursor_4c_Movimento.emps"
        loc_oGrd.Column4.ControlSource = "cursor_4c_Movimento.dopes"
        loc_oGrd.Column5.ControlSource = "cursor_4c_Movimento.numes"
        loc_oGrd.Column6.ControlSource = "cursor_4c_Movimento.valor"
        loc_oGrd.Column7.ControlSource = "cursor_4c_Movimento.Qtds"
        loc_oGrd.Column8.ControlSource = "cursor_4c_Movimento.Pesos"

        THIS.ConfigurarColunaGrade(loc_oGrd, 1, 70,  "Data")
        THIS.ConfigurarColunaGrade(loc_oGrd, 2, 15,  "O")
        THIS.ConfigurarColunaGrade(loc_oGrd, 3, 28,  "Emp")
        THIS.ConfigurarColunaGrade(loc_oGrd, 4, 145, "Movimenta" + CHR(231) + CHR(227) + "o")
        THIS.ConfigurarColunaGrade(loc_oGrd, 5, 50,  "C" + CHR(243) + "digo")
        THIS.ConfigurarColunaGrade(loc_oGrd, 6, 80,  "Valor")
        THIS.ConfigurarColunaGrade(loc_oGrd, 7, 70,  "Qtde")
        THIS.ConfigurarColunaGrade(loc_oGrd, 8, 70,  "Pesos")

        *-- Grade de Devolucao
        loc_oGrd = THIS.grd_4c_Devolucao
        loc_oGrd.ColumnCount = 6
        loc_oGrd.RecordSource = "cursor_4c_Devolucao"

        loc_oGrd.Column1.ControlSource = "cursor_4c_Devolucao.datas"
        loc_oGrd.Column2.ControlSource = "cursor_4c_Devolucao.opers"
        loc_oGrd.Column3.ControlSource = "cursor_4c_Devolucao.emps"
        loc_oGrd.Column4.ControlSource = "cursor_4c_Devolucao.dopes"
        loc_oGrd.Column5.ControlSource = "cursor_4c_Devolucao.numes"
        loc_oGrd.Column6.ControlSource = "cursor_4c_Devolucao.valors"

        THIS.ConfigurarColunaGrade(loc_oGrd, 1, 70,  "Data")
        THIS.ConfigurarColunaGrade(loc_oGrd, 2, 15,  "O")
        THIS.ConfigurarColunaGrade(loc_oGrd, 3, 28,  "Emp")
        THIS.ConfigurarColunaGrade(loc_oGrd, 4, 145, "Movimenta" + CHR(231) + CHR(227) + "o")
        THIS.ConfigurarColunaGrade(loc_oGrd, 5, 50,  "C" + CHR(243) + "digo")
        THIS.ConfigurarColunaGrade(loc_oGrd, 6, 80,  "Valor")

        *-- Grade de Cotacoes (dentro de cnt_4c_GrdCot, oculta por padrao)
        loc_oGrd = THIS.cnt_4c_GrdCot.grd_4c_Cotacoes
        loc_oGrd.ColumnCount = 2
        loc_oGrd.RecordSource = "cursor_4c_Cotacoes"

        loc_oGrd.Column1.ControlSource = "cursor_4c_Cotacoes.cmoes"
        loc_oGrd.Column2.ControlSource = "cursor_4c_Cotacoes.valos"

        THIS.ConfigurarColunaGrade(loc_oGrd, 1, 30,  "Moe")
        THIS.ConfigurarColunaGrade(loc_oGrd, 2, 100, "Cotacao")
        loc_oGrd.Column2.Text1.InputMask = "999,999,999.99"

        *-- Grade do painel de Correcao (dentro de cnt_4c_Correcao, oculto
        *-- por padrao). Ordem de colunas igual ao legado: Column5=usuars,
        *-- Column6=codtams (NAO na ordem 4,5,6 "natural").
        loc_oGrd = THIS.cnt_4c_Correcao.grd_4c_Correcao
        loc_oGrd.ColumnCount = 6
        loc_oGrd.RecordSource = "cursor_4c_Correcao"

        loc_oGrd.Column1.ControlSource = "cursor_4c_Correcao.datas"
        loc_oGrd.Column2.ControlSource = "cursor_4c_Correcao.cpros"
        loc_oGrd.Column3.ControlSource = "cursor_4c_Correcao.pesos"
        loc_oGrd.Column4.ControlSource = "cursor_4c_Correcao.codcors"
        loc_oGrd.Column5.ControlSource = "cursor_4c_Correcao.usuars"
        loc_oGrd.Column6.ControlSource = "cursor_4c_Correcao.codtams"

        THIS.ConfigurarColunaGrade(loc_oGrd, 1, 70, "Data")
        THIS.ConfigurarColunaGrade(loc_oGrd, 2, 90, "Produto")
        THIS.ConfigurarColunaGrade(loc_oGrd, 3, 60, "Peso")
        THIS.ConfigurarColunaGrade(loc_oGrd, 4, 60, "Cor")
        THIS.ConfigurarColunaGrade(loc_oGrd, 5, 80, "Usu" + CHR(225) + "rio")
        THIS.ConfigurarColunaGrade(loc_oGrd, 6, 60, "Tam")
    ENDPROC

    *==================================================================
    * CarregarDados - Monta as 3 grades para um codigo de barras.
    * Equivalente a parte do PROCEDURE Processamento do legado que diz
    * respeito as grades; os campos do produto/etiqueta sao preenchidos
    * pelos metodos da pagina de dados.
    *
    * par_nCodBarras: codigo de barras a pesquisar. Zero/invalido apenas
    * limpa as grades (nenhuma consulta eh disparada).
    *==================================================================
    PROCEDURE CarregarDados(par_nCodBarras)
        LOCAL loc_nCodBarras, loc_lSucesso

        loc_lSucesso  = .F.
        loc_nCodBarras = IIF(VARTYPE(par_nCodBarras) = "N", par_nCodBarras, 0)

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        IF loc_nCodBarras <= 0
            THIS.LimparGrades()
            RETURN .F.
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.CarregarGradesPorCodBarras(loc_nCodBarras)
                IF THIS.this_oBusinessObject.CarregarDevolucaoPorCodBarras(loc_nCodBarras)
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

            THIS.this_oBusinessObject.LiberarCursoresConsulta()

            *-- Ordem de exibicao do legado: Set Order To DtOpers nas duas grades
            THIS.RepintarGrades()
            THIS.AtualizarEstadoBotoes(loc_nCodBarras)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em Formsigopcgb.CarregarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==================================================================
    * LimparGrades - Esvazia os 3 cursores e repinta. Usado quando o
    * codigo de barras eh apagado/invalido: as grades tem de ficar vazias
    * em vez de manter o resultado da pesquisa anterior.
    *==================================================================
    PROCEDURE LimparGrades()
        IF USED("cursor_4c_Historico")
            ZAP IN cursor_4c_Historico
        ENDIF
        IF USED("cursor_4c_Movimento")
            ZAP IN cursor_4c_Movimento
        ENDIF
        IF USED("cursor_4c_Devolucao")
            ZAP IN cursor_4c_Devolucao
        ENDIF

        THIS.RepintarGrades()
        THIS.AtualizarEstadoBotoes(0)

        RETURN .T.
    ENDPROC

    *==================================================================
    * RepintarGrades - FUNIL unico de repintura. Popular o cursor NAO faz a
    * grade redesenhar: sem reposicionar o ponteiro + Refresh a grade aparece
    * vazia com o cursor cheio.
    *
    * O legado fecha o Processamento assim, e eh isso que se reproduz:
    *   Select CsMovimento / Set Order To DtOpers / AfterRowColChange / Go Bottom
    *   Select CsHistorico / Set Order To DtOpers / AfterRowColChange / Go Bottom
    * ou seja GO BOTTOM (ultimo movimento, o mais recente), NAO Go Top. A grade
    * de devolucao nao eh reordenada nem reposicionada pelo legado.
    *
    * Chamado em TODO caminho que popula ou esvazia os cursores.
    *==================================================================
    PROCEDURE RepintarGrades()
        IF USED("cursor_4c_Historico")
            SELECT cursor_4c_Historico
            SET ORDER TO TAG DtOpers
            GO BOTTOM
            THIS.grd_4c_Historico.Refresh()
        ENDIF

        IF USED("cursor_4c_Movimento")
            SELECT cursor_4c_Movimento
            SET ORDER TO TAG DtOpers
            GO BOTTOM
            THIS.grd_4c_Movimento.Refresh()
        ENDIF

        IF USED("cursor_4c_Devolucao")
            SELECT cursor_4c_Devolucao
            GO TOP
            THIS.grd_4c_Devolucao.Refresh()
        ENDIF

        *-- O legado deixa CsHistorico selecionado quando CsMovimento esta vazio
        *-- (If RecCount('CsMovimento') < 1 / Select CsHistorico).
        IF USED("cursor_4c_Movimento") AND RECCOUNT("cursor_4c_Movimento") < 1
            IF USED("cursor_4c_Historico")
                SELECT cursor_4c_Historico
            ENDIF
        ENDIF

        RETURN .T.
    ENDPROC

    *==================================================================
    * AplicarAcessoBotoes - Visibilidade dos botoes por permissao, como no
    * Init legado:
    *   .BtnDocumento.Visible      = fChecaAcesso('SIGOPCGB','BTNDOC')
    *   .BtnImprimir.Visible       = fChecaAcesso('SIGOPCGB','IMPRIMIR')
    *   .BtnVisualizar.Visible     = fChecaAcesso('SIGOPCGB','VISUALIZAR')
    *   .Bot_Rastro.Visible        = fChecaAcesso('SIGOPCGB','RASTRO') And !Eof('TmpOpe')
    *   .Botao_de_Correcao.Visible = fChecaAcesso('SIGOPCGB','CORRECAO')
    * O !Eof('TmpOpe') eh o this_lControlaLotes do BO (existe SigCdOpe com
    * ctrllotes 1 ou 2).
    *==================================================================
    PROTECTED PROCEDURE AplicarAcessoBotoes()
        LOCAL loc_oBO, loc_lLotes

        loc_oBO    = THIS.this_oBusinessObject
        loc_lLotes = .F.

        IF VARTYPE(loc_oBO) = "O"
            loc_oBO.this_lAcessoDocumento  = fChecaAcesso("SIGOPCGB", "BTNDOC")
            loc_oBO.this_lAcessoImprimir   = fChecaAcesso("SIGOPCGB", "IMPRIMIR")
            loc_oBO.this_lAcessoVisualizar = fChecaAcesso("SIGOPCGB", "VISUALIZAR")
            loc_oBO.this_lAcessoRastro     = fChecaAcesso("SIGOPCGB", "RASTRO")
            loc_oBO.this_lAcessoCorrecao   = fChecaAcesso("SIGOPCGB", "CORRECAO")
            loc_oBO.this_lAcessoFornecedor = fChecaAcesso("SIGOPCGB", "FORNECEDOR")
            loc_oBO.this_lAcessoFollowUp   = fChecaAcesso("SIGOPCGB", "FOLLOWUP")

            loc_lLotes = loc_oBO.this_lControlaLotes

            THIS.cmd_4c_BtnDocumento.Visible  = loc_oBO.this_lAcessoDocumento
            THIS.cmd_4c_BtnImprimir.Visible   = loc_oBO.this_lAcessoImprimir
            THIS.cmd_4c_BtnVisualizar.Visible = loc_oBO.this_lAcessoVisualizar
            THIS.cmd_4c_BotRastro.Visible     = (loc_oBO.this_lAcessoRastro AND loc_lLotes)
            THIS.cmd_4c_BotaoCorrecao.Visible = loc_oBO.this_lAcessoCorrecao
        ENDIF

        RETURN .T.
    ENDPROC

    *==================================================================
    * AtualizarEstadoBotoes - Reproduz o When dos botoes de acao do legado
    * (Return(!Empty(ThisForm.GetBarras.Value))): sem codigo de barras
    * pesquisado, nenhuma das acoes faz sentido e os botoes ficam
    * desabilitados. O Encerrar NUNCA eh desabilitado - eh a saida da tela.
    *
    * Chamado pelo FUNIL de carga (CarregarDados/LimparGrades), nao por cada
    * botao: quem desabilita tem de reabilitar no caminho de volta.
    *==================================================================
    PROCEDURE AtualizarEstadoBotoes(par_nCodBarras)
        LOCAL loc_lAtivo

        loc_lAtivo = (VARTYPE(par_nCodBarras) = "N" AND par_nCodBarras > 0)

        THIS.cmd_4c_BtnImprimir.Enabled   = loc_lAtivo
        THIS.cmd_4c_BtnVisualizar.Enabled = loc_lAtivo
        THIS.cmd_4c_BtnDocumento.Enabled  = loc_lAtivo
        THIS.cmd_4c_BotRastro.Enabled     = loc_lAtivo
        THIS.cmd_4c_BotaoCorrecao.Enabled = loc_lAtivo
        THIS.cmd_4c_BtnLocal.Enabled      = loc_lAtivo

        *-- As 3 grades tambem tem o MESMO When no legado
        *-- (grdHistorico/grdMovimento/grddevolucao: "Return(!Empty(
        *-- ThisForm.GetBarras.Value))"): sem codigo pesquisado elas estao
        *-- vazias e nao devem aceitar foco/navegacao.
        THIS.grd_4c_Historico.Enabled = loc_lAtivo
        THIS.grd_4c_Movimento.Enabled = loc_lAtivo
        THIS.grd_4c_Devolucao.Enabled = loc_lAtivo

        RETURN .T.
    ENDPROC

    *==================================================================
    * ConfigurarBindings - BINDEVENT dos campos/botoes interativos desta
    * fase (Fase 6/8 - campos restantes e "lookups"). O unico lookup real
    * deste form OPERACIONAL eh a pesquisa por codigo de barras (nao ha
    * FormBuscaAuxiliar aqui: txt_4c_Barras EH a busca).
    *==================================================================
    PROTECTED PROCEDURE ConfigurarBindings()
        BINDEVENT(THIS.txt_4c_Barras, "KeyPress", THIS, "BarrasKeyPress")

        *-- Fase 8/8 - os tres eventos auxiliares do getBarras legado que
        *-- faltavam, e sem os quais o campo de barras nao se comporta como
        *-- no legado:
        *--   GotFocus  = "This.peantvalue = This.Value" (guard de valor nao
        *--               mudado, consumido pelo Valid)
        *--   LostFocus = arma o tmAux (devolucao do foco) - aqui tambem
        *--               dispara a pesquisa, que no legado eh o Valid: os
        *--               dois rodam ao SAIR do campo, e BINDEVENT em "Valid"
        *--               nao dispara de forma confiavel em TextBox (regra
        *--               CLAUDE.md #3/#35), entao o Valid vive no LostFocus.
        *--   Timer     = devolve o foco ao campo e se desarma
        BINDEVENT(THIS.txt_4c_Barras, "GotFocus", THIS, "BarrasGotFocus")
        BINDEVENT(THIS.txt_4c_Barras, "LostFocus", THIS, "BarrasLostFocus")
        BINDEVENT(THIS.tmr_4c_FocoBarras, "Timer", THIS, "TimerFocoBarras")

        BINDEVENT(THIS.cmd_4c_BtnLocal, "Click", THIS, "BtnLocalClick")
        BINDEVENT(THIS.chk_4c_BotCotacoes, "Click", THIS, "BotCotacoesClick")

        *-- AfterRowColChange para mostrar o produto/imagem da LINHA
        *-- corrente (uso legitimo de AfterRowColChange - regra #46/CLAUDE.md,
        *-- "carregar detalhe da linha corrente" - diferente de validar
        *-- celula editavel, que este form nao tem: as 3 grades sao ReadOnly).
        BINDEVENT(THIS.grd_4c_Historico, "AfterRowColChange", THIS, "GradeHistoricoAfterRowColChange")
        BINDEVENT(THIS.grd_4c_Movimento, "AfterRowColChange", THIS, "GradeMovimentoAfterRowColChange")

        *-- Legado: grdHistorico.Click delega para o handler nativo de
        *-- AfterRowColChange (reforca a
        *-- repintura ao clicar na MESMA celula ja focada) e
        *-- grddevolucao.AfterRowColChange so marca a grade selecionada
        *-- (this_nGradeSel), usado por BtnDocumentoClick/BotRastroClick.
        BINDEVENT(THIS.grd_4c_Historico, "Click", THIS, "GradeHistoricoClick")
        BINDEVENT(THIS.grd_4c_Devolucao, "AfterRowColChange", THIS, "GradeDevolucaoAfterRowColChange")

        *-- Botoes de acao (Fase 7/8 - eventos principais).
        BINDEVENT(THIS.obj_4c_CmdBtnForm.Buttons(1), "Click", THIS, "BtnEncerrarClick")
        BINDEVENT(THIS.cmd_4c_BtnImprimir, "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmd_4c_BtnVisualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(THIS.cmd_4c_BtnDocumento, "Click", THIS, "BtnDocumentoClick")
        BINDEVENT(THIS.cmd_4c_BotRastro, "Click", THIS, "BotRastroClick")
        BINDEVENT(THIS.cmd_4c_BotaoCorrecao, "Click", THIS, "BotaoCorrecaoClick")
        BINDEVENT(THIS.cnt_4c_Correcao.obj_4c_CmdCorrecao.Buttons(1), "Click", THIS, "PainelCorrecaoEncerrarClick")
    ENDPROC

    *==================================================================
    * BarrasKeyPress - txt_4c_Barras (equivalente ao getBarras do legado).
    * ENTER/TAB pesquisa sem esperar a saida do campo, que eh o uso real do
    * leitor de codigo de barras (o scanner emite o codigo e um ENTER).
    * A pesquisa ao SAIR do campo por qualquer outro meio (clicar num botao,
    * por exemplo) fica no BarrasLostFocus, que eh onde mora o Valid legado.
    *==================================================================
    PROCEDURE BarrasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarBarras()
        ENDIF
    ENDPROC

    *==================================================================
    * BarrasGotFocus - legado: getBarras.GotFocus = "This.peantvalue =
    * This.Value". Guarda o valor na ENTRADA do campo; o funil de pesquisa
    * compara com ele para nao repetir a consulta quando o usuario entra e
    * sai do campo sem mudar o codigo.
    *==================================================================
    PROCEDURE BarrasGotFocus()
        THIS.this_nBarrasAnterior = IIF(VARTYPE(THIS.txt_4c_Barras.Value) = "N", ;
            THIS.txt_4c_Barras.Value, 0)
    ENDPROC

    *==================================================================
    * BarrasLostFocus - reune os DOIS eventos que o legado dispara ao sair
    * do campo de barras:
    *
    *   getBarras.Valid     - pesquisa o codigo (guard "peantvalue # Value").
    *                         Vive aqui porque BINDEVENT em "Valid" nao
    *                         dispara de forma confiavel em TextBox
    *                         (regra CLAUDE.md #3/#35).
    *   getBarras.LostFocus - "If InList(LastKey(), 13, 48..57, 9) /
    *                         ThisForm.Tpbusca = 1 / tmAux.Enabled = .T."
    *                         isto eh: saiu por ENTER, TAB ou digitando um
    *                         digito -> arma o timer que devolve o foco ao
    *                         campo, para a leitura seguinte.
    *
    * Tpbusca NAO eh migrada de proposito: no legado ela eh escrita em tres
    * lugares (Init, LostFocus e o proprio Init com pBar) e NUNCA lida -
    * estado morto. Migra-la seria criar propriedade que ninguem consulta.
    *==================================================================
    PROCEDURE BarrasLostFocus()
        LOCAL loc_nUltimaTecla

        *-- Guard do legado: so pesquisa se o codigo MUDOU desde o GotFocus.
        *-- Tambem eh o que impede a pesquisa de rodar de novo quando o
        *-- MsgErro dela rouba o foco e o LostFocus redispara.
        *-- IF ANINHADO, nao AND encadeado: VFP9 nao faz short-circuit, entao
        *-- "VARTYPE(x) = 'N' AND x > 0" avaliaria "x > 0" mesmo com x
        *-- Caractere e estouraria "Operator/operand type mismatch".
        IF VARTYPE(THIS.txt_4c_Barras.Value) = "N"
            IF THIS.txt_4c_Barras.Value > 0 AND ;
               THIS.txt_4c_Barras.Value != THIS.this_nBarrasAnterior
                THIS.ValidarBarras()
            ENDIF
        ENDIF

        *-- Devolucao do foco ao campo: so quando a saida foi por ENTER (13),
        *-- TAB (9) ou digito (48..57), igual ao InList do legado. Sair
        *-- clicando com o mouse NAO rearma o foco - senao o usuario nao
        *-- conseguiria clicar em nenhum botao da tela.
        loc_nUltimaTecla = LASTKEY()

        IF loc_nUltimaTecla = 13 OR loc_nUltimaTecla = 9 OR ;
           BETWEEN(loc_nUltimaTecla, 48, 57)
            IF THIS.txt_4c_Barras.Enabled
                THIS.tmr_4c_FocoBarras.Enabled = .T.
            ENDIF
        ENDIF
    ENDPROC

    *==================================================================
    * TimerFocoBarras - legado: tmAux.Timer = "ThisForm.foca() /
    * Keyboard(Chr(3)) / This.Enabled = .F."
    *
    * ORDEM e CONTEUDO transcritos do legado. O Keyboard(Chr(3)) vai junto
    * por fidelidade (PILAR 1): com o foco no campo de barras ele age sobre
    * a selecao do proprio campo, e o KeyPress deste form so reage a 13/9,
    * entao nao dispara pesquisa nenhuma.
    *
    * O "This.Enabled = .F." eh o que faz o timer ser ONE-SHOT: sem ele o
    * foco voltaria ao campo de barras a cada 200ms e a tela ficaria
    * inutilizavel. THIS aqui eh o FORM (o handler eh metodo do form), por
    * isso o alvo eh escrito por extenso.
    *==================================================================
    PROCEDURE TimerFocoBarras()
        THIS.FocarBarras()
        KEYBOARD CHR(3)
        THIS.tmr_4c_FocoBarras.Enabled = .F.
    ENDPROC

    *==================================================================
    * FocarBarras - legado: PROCEDURE foca = "ThisForm.getBarras.SetFocus".
    * Metodo proprio (e nao SetFocus embutido no Timer) porque no legado
    * tambem eh metodo do form, chamado pelo Timer.
    *==================================================================
    PROCEDURE FocarBarras()
        IF THIS.txt_4c_Barras.Enabled AND THIS.txt_4c_Barras.Visible
            THIS.txt_4c_Barras.SetFocus()
        ENDIF
    ENDPROC

    *==================================================================
    * ValidarBarras - FUNIL da pesquisa por codigo de barras (equivalente
    * a getBarras.Valid + Processamento do legado): resolve a etiqueta (ou
    * o produto, no fallback por SigCdPro), carrega os dados do produto e
    * as 3 grades, e atualiza todos os campos de exibicao da tela.
    *
    * WRAPPER FINO do guard de reentrancia: o corpo fica em
    * ValidarBarrasExec porque ele tem RETURN antecipado, e flag
    * setada/limpa no proprio corpo ficaria TRAVADA ligada nesses caminhos -
    * matando a pesquisa pelo resto da vida do form (regra CLAUDE.md #47).
    *==================================================================
    PROCEDURE ValidarBarras()
        LOCAL loc_lSucesso

        IF THIS.this_lEmPesquisa
            RETURN .F.
        ENDIF

        THIS.this_lEmPesquisa = .T.
        loc_lSucesso = THIS.ValidarBarrasExec()
        THIS.this_lEmPesquisa = .F.

        RETURN loc_lSucesso
    ENDPROC

    *==================================================================
    * ValidarBarrasExec - corpo do funil de pesquisa. Chamado SO por
    * ValidarBarras, que garante o guard de reentrancia.
    *==================================================================
    PROCEDURE ValidarBarrasExec()
        LOCAL loc_nCodBarras, loc_lSucesso, loc_lProdutoAchado

        loc_lSucesso   = .F.
        loc_nCodBarras = THIS.txt_4c_Barras.Value

        IF VARTYPE(loc_nCodBarras) != "N" OR loc_nCodBarras <= 0
            RETURN .F.
        ENDIF

        IF !THIS.PodeConsultarBanco()
            RETURN .F.
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.BuscarEtiquetaPorCodBarras(loc_nCodBarras)
                *-- O codigo pode ter sido RENUMERADO (cbars_old -> cbars_new);
                *-- o campo de busca sempre mostra o codigo ATUAL.
                THIS.txt_4c_Barras.Value = THIS.this_oBusinessObject.this_nCodBarras
                THIS.txt_4c_Barra.Value  = THIS.this_oBusinessObject.this_nCodBarraAnterior

                *-- Sincroniza o guard do GotFocus com o codigo RESOLVIDO (que
                *-- pode diferir do digitado, se a etiqueta foi renumerada):
                *-- sem isto o LostFocus seguinte veria "valor mudou" e
                *-- repetiria a pesquisa inteira.
                THIS.this_nBarrasAnterior = THIS.this_oBusinessObject.this_nCodBarras

                THIS.AtualizarCamposEtiqueta()

                loc_lProdutoAchado = THIS.this_oBusinessObject.CarregarDadosProduto(THIS.this_oBusinessObject.this_cCodProduto)
                THIS.AtualizarCamposProduto(loc_lProdutoAchado)

                THIS.CarregarDados(THIS.this_oBusinessObject.this_nCodBarras)

                *-- Legado: ao final do Processamento, as duas grades sao
                *-- reposicionadas e o AfterRowColChange disparado NA MAO
                *-- (Go Bottom + ThisForm.grdXxx.AfterRowColChange()).
                THIS.GradeHistoricoAfterRowColChange()
                THIS.GradeMovimentoAfterRowColChange()

                loc_lSucesso = .T.
            ELSE
                MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
                    "Pesquisa Global de C" + CHR(243) + "digo de Barras")
                THIS.LimparCamposProduto()
                THIS.LimparGrades()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em Formsigopcgb.ValidarBarrasExec")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==================================================================
    * AtualizarCamposEtiqueta - Espelha os dados da etiqueta (BO) nos
    * campos do bloco "Posicao Atual do Codigo de Barras" + Local.
    * GetCProSHis/GetDProSHis sao zerados aqui, igual ao legado - so voltam
    * a ser preenchidos se a linha corrente de Movimento tiver um produto
    * DIFERENTE do pesquisado (GradeMovimentoAfterRowColChange).
    *==================================================================
    PROTECTED PROCEDURE AtualizarCamposEtiqueta()
        LOCAL loc_oBO
        loc_oBO = THIS.this_oBusinessObject

        THIS.txt_4c_Origem.Value  = loc_oBO.this_cOrigem
        THIS.txt_4c_Empresa.Value = loc_oBO.this_cEmpresaOp
        THIS.txt_4c_Grupo.Value   = loc_oBO.this_cGrupoOp
        THIS.txt_4c_Conta.Value   = loc_oBO.this_cContaOp
        THIS.txt_4c_Qtde.Value    = loc_oBO.this_nQtdeOp
        THIS.txt_4c_Peso.Value    = loc_oBO.this_nPesoOp
        THIS.txt_4c_Local.Value   = loc_oBO.this_cLocalizacao

        THIS.txt_4c_CProdutoSemHistorico.Value = ""
        THIS.txt_4c_DProdutoSemHistorico.Value = ""

        THIS.txt_4c_Origem.Refresh()
        THIS.txt_4c_Empresa.Refresh()
        THIS.txt_4c_Grupo.Refresh()
        THIS.txt_4c_Conta.Refresh()
        THIS.txt_4c_Qtde.Refresh()
        THIS.txt_4c_Peso.Refresh()
        THIS.txt_4c_Local.Refresh()
    ENDPROC

    *==================================================================
    * AtualizarCamposProduto - Espelha os dados do produto (BO, carregados
    * por CarregarDadosProduto) no bloco "Dados do Produto" + ajusta os
    * captions de Qtd(1)/Qtd(2) e do cabecalho da 10a/11a coluna da grade de
    * Historico pela unidade do produto (igual ao Processamento legado).
    * par_lAchou: resultado de CarregarDadosProduto - produto nao encontrado
    * limpa os campos (ramo Else do TmpPro legado).
    *==================================================================
    PROTECTED PROCEDURE AtualizarCamposProduto(par_lAchou)
        LOCAL loc_oBO, loc_cUnidade, loc_cUnidadePeso

        loc_oBO = THIS.this_oBusinessObject

        IF par_lAchou
            THIS.txt_4c_CProduto.Value    = loc_oBO.this_cCodProduto
            THIS.txt_4c_DProduto.Value    = loc_oBO.this_cDescProduto
            THIS.txt_4c_CFornecedor.Value = loc_oBO.this_cCodFornecedor
            THIS.txt_4c_DFornecedor.Value = loc_oBO.this_cDescFornecedor
            THIS.txt_4c_Referencia.Value  = loc_oBO.this_cReferencia
            THIS.txt_4c_Colecoes.Value    = loc_oBO.this_cColecao
            THIS.txt_4c_PVenda.Value      = loc_oBO.this_nPrecoVenda
            THIS.txt_4c_PrecoDe.Value     = loc_oBO.this_nPrecoDe
            THIS.txt_4c_Cat.Value         = loc_oBO.this_cCategoria

            loc_cUnidade     = ALLTRIM(loc_oBO.this_cUnidade)
            loc_cUnidadePeso = ALLTRIM(loc_oBO.this_cUnidadePeso)

            THIS.lbl_4c_Qtd1.Caption = IIF(EMPTY(loc_cUnidade), "Qtd", "Qtd(" + loc_cUnidade + ")")
            THIS.lbl_4c_Qtd2.Caption = IIF(EMPTY(loc_cUnidadePeso), "Peso", "Qtd(" + loc_cUnidadePeso + ")")

            THIS.grd_4c_Historico.Column10.Header1.Caption = IIF(EMPTY(loc_cUnidade), "Qtd", "Qtd(" + loc_cUnidade + ")")
            IF !loc_oBO.this_lHabilitaValor
                THIS.grd_4c_Historico.Column11.Header1.Caption = ;
                    IIF(EMPTY(loc_cUnidadePeso), "Peso", "Qtd(" + loc_cUnidadePeso + ")")
            ENDIF
        ELSE
            THIS.txt_4c_CProduto.Value    = ""
            THIS.txt_4c_DProduto.Value    = ""
            THIS.txt_4c_CFornecedor.Value = ""
            THIS.txt_4c_DFornecedor.Value = ""
            THIS.txt_4c_Referencia.Value  = ""
            THIS.txt_4c_Colecoes.Value    = ""
            THIS.txt_4c_PVenda.Value      = 0
            THIS.txt_4c_Barra.Value       = 0
        ENDIF

        THIS.ExibirImagemProduto(loc_oBO.this_cFigJpgBase64)

        THIS.txt_4c_CProduto.Refresh()
        THIS.txt_4c_DProduto.Refresh()
        THIS.txt_4c_CFornecedor.Refresh()
        THIS.txt_4c_DFornecedor.Refresh()
        THIS.txt_4c_Referencia.Refresh()
        THIS.txt_4c_Colecoes.Refresh()
        THIS.txt_4c_PVenda.Refresh()
        THIS.txt_4c_PrecoDe.Refresh()
        THIS.txt_4c_Cat.Refresh()
    ENDPROC

    *==================================================================
    * LimparCamposProduto - Esvazia TODOS os campos de exibicao (etiqueta,
    * produto e imagem) quando a pesquisa nao encontra NADA (nem etiqueta,
    * nem produto pelo fallback) - a tela nao deve manter dados da busca
    * anterior depois de um resultado negativo.
    *==================================================================
    PROTECTED PROCEDURE LimparCamposProduto()
        THIS.txt_4c_Origem.Value  = ""
        THIS.txt_4c_Empresa.Value = ""
        THIS.txt_4c_Grupo.Value   = ""
        THIS.txt_4c_Conta.Value   = ""
        THIS.txt_4c_Qtde.Value    = 0
        THIS.txt_4c_Peso.Value    = 0
        THIS.txt_4c_Local.Value   = ""

        THIS.txt_4c_CProdutoSemHistorico.Value = ""
        THIS.txt_4c_DProdutoSemHistorico.Value = ""

        THIS.txt_4c_CProduto.Value    = ""
        THIS.txt_4c_DProduto.Value    = ""
        THIS.txt_4c_CFornecedor.Value = ""
        THIS.txt_4c_DFornecedor.Value = ""
        THIS.txt_4c_Referencia.Value  = ""
        THIS.txt_4c_Colecoes.Value    = ""
        THIS.txt_4c_PVenda.Value      = 0
        THIS.txt_4c_PrecoDe.Value     = 0
        THIS.txt_4c_Cat.Value         = ""
        THIS.txt_4c_Barra.Value       = 0

        THIS.ExibirImagemProduto("")

        THIS.Refresh()
    ENDPROC

    *==================================================================
    * ExibirImagemProduto - Decodifica o FigJpgs (base64, com os prefixos
    * data:image/... removidos pelo proprio legado) e exibe em img_4c_FigJpg.
    * STRCONV(...,14) roda UMA UNICA VEZ (decode simples, nao duplo - regra
    * CLAUDE.md "STRCONV double decode imagem"). Padrao canonico do projeto
    * (FormSigMvSbn.AtualizarImagemProduto).
    *==================================================================
    PROTECTED PROCEDURE ExibirImagemProduto(par_cFigJpgBase64)
        LOCAL loc_cFoto, loc_cArquivo

        THIS.img_4c_FigJpg.Visible = .F.
        THIS.img_4c_FigJpg.Picture = ""

        loc_cFoto = TratarNulo(par_cFigJpgBase64, "")
        IF !EMPTY(loc_cFoto)
            loc_cFoto = STRTRAN(loc_cFoto, "data:image/png;base64,", "")
            loc_cFoto = STRTRAN(loc_cFoto, "data:image/jpeg;base64,", "")
            loc_cFoto = STRTRAN(loc_cFoto, "data:image/jpg;base64,", "")
            loc_cFoto = STRCONV(loc_cFoto, 14)

            loc_cArquivo = SYS(2023) + "\SIGOPCGB.jpg"
            IF STRTOFILE(loc_cFoto, loc_cArquivo) > 0
                THIS.img_4c_FigJpg.Picture = loc_cArquivo
                THIS.img_4c_FigJpg.Visible = .T.
            ENDIF
        ENDIF
    ENDPROC

    *==================================================================
    * GradeHistoricoAfterRowColChange - legado: recarrega a imagem do
    * PRODUTO PESQUISADO (nao ha lookup por linha aqui - todo o Historico
    * pertence ao mesmo produto) e atualiza a grade de cotacoes (chamada
    * incondicional no legado, independente do checkbox estar marcado).
    *==================================================================
    PROCEDURE GradeHistoricoAfterRowColChange(par_nColIndex)
        THIS.this_nGradeSel = 1

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.ExibirImagemProduto(THIS.this_oBusinessObject.this_cFigJpgBase64)
        ENDIF

        THIS.AtualizarGradeCotacoes()
    ENDPROC

    *==================================================================
    * GradeMovimentoAfterRowColChange - legado: se o produto da linha de
    * Movimento CORRENTE for DIFERENTE do produto pesquisado, busca
    * (SigCdPro) e exibe o codigo/descricao/imagem desse OUTRO produto nos
    * campos "Codigos de Barras Sem Historico" (GetCProSHis/GetDProSHis).
    * Se for o MESMO produto, nao faz nada - os campos ficam como
    * AtualizarCamposEtiqueta os deixou (vazios).
    *==================================================================
    PROCEDURE GradeMovimentoAfterRowColChange(par_nColIndex)
        LOCAL loc_cCodProdutoLinha

        THIS.this_nGradeSel = 2

        IF USED("cursor_4c_Movimento") AND !EOF("cursor_4c_Movimento")
            loc_cCodProdutoLinha = TratarNulo(cursor_4c_Movimento.cpros, "")
        ELSE
            loc_cCodProdutoLinha = ""
        ENDIF

        IF !EMPTY(loc_cCodProdutoLinha) AND VARTYPE(THIS.this_oBusinessObject) = "O" ;
                AND loc_cCodProdutoLinha != THIS.this_oBusinessObject.this_cCodProduto
            THIS.this_oBusinessObject.CarregarProdutoResumido(loc_cCodProdutoLinha)
            THIS.txt_4c_CProdutoSemHistorico.Value = THIS.this_oBusinessObject.this_cCodProdutoHist
            THIS.txt_4c_DProdutoSemHistorico.Value = THIS.this_oBusinessObject.this_cDescProdutoHist
            THIS.ExibirImagemProduto(THIS.this_oBusinessObject.this_cFigJpgProdutoHist)
        ENDIF
    ENDPROC

    *==================================================================
    * GradeDevolucaoAfterRowColChange - legado: grddevolucao.AfterRowColChange
    * so marca qual grade esta selecionada - usado por BtnDocumentoClick/
    * BotRastroClick para saber de qual grade ler a linha corrente.
    *==================================================================
    PROCEDURE GradeDevolucaoAfterRowColChange(par_nColIndex)
        THIS.this_nGradeSel = 3
    ENDPROC

    *==================================================================
    * GradeHistoricoClick - legado: grdHistorico.Click delega para o handler
    * nativo de AfterRowColChange. Reforca a repintura da imagem/cotacoes ao clicar na MESMA celula ja
    * focada (o AfterRowColChange nativo so dispara ao TROCAR de celula).
    *==================================================================
    PROCEDURE GradeHistoricoClick()
        THIS.GradeHistoricoAfterRowColChange()
    ENDPROC

    *==================================================================
    * DesabilitarControlesPrincipais / ReabilitarControlesPrincipais - funil
    * unico da lista de controles que o legado desabilita/reabilita enquanto
    * um form ou painel filho esta aberto (BtnLocalClick/BotaoCorrecaoClick -
    * mesma lista nos dois: GetBarras/CmdBtnForm.BtnSair/GrdMovimento/
    * GrdHistorico/BtnDocumento/BtnImprimir/BtnVisualizar/BtnLocal).
    *==================================================================
    PROTECTED PROCEDURE DesabilitarControlesPrincipais()
        THIS.txt_4c_Barras.Enabled                = .F.
        THIS.obj_4c_CmdBtnForm.Buttons(1).Enabled = .F.
        THIS.grd_4c_Movimento.Enabled              = .F.
        THIS.grd_4c_Historico.Enabled               = .F.
        THIS.cmd_4c_BtnDocumento.Enabled           = .F.
        THIS.cmd_4c_BtnImprimir.Enabled            = .F.
        THIS.cmd_4c_BtnVisualizar.Enabled          = .F.
        THIS.cmd_4c_BtnLocal.Enabled               = .F.
    ENDPROC

    PROTECTED PROCEDURE ReabilitarControlesPrincipais()
        THIS.txt_4c_Barras.Enabled                = .T.
        THIS.obj_4c_CmdBtnForm.Buttons(1).Enabled = .T.
        THIS.grd_4c_Movimento.Enabled               = .T.
        THIS.grd_4c_Historico.Enabled                = .T.
        THIS.AtualizarEstadoBotoes(THIS.txt_4c_Barras.Value)
    ENDPROC

    *==================================================================
    * BtnLocalClick - abre a tela de correcao de localizacao da etiqueta
    * (legado: Do Form SigOpCgl With lnCodBars), desabilitando os demais
    * controles enquanto ela estiver aberta - igual ao legado. SigOpCgl
    * ainda nao foi migrado para a nova arquitetura; o guard evita
    * "Class SIGOPCGL is not found" e avisa o usuario.
    *==================================================================
    PROCEDURE BtnLocalClick()
        LOCAL loc_nCodBarras, loc_oForm

        IF !THIS.cmd_4c_BtnLocal.Enabled
            RETURN
        ENDIF

        loc_nCodBarras = THIS.txt_4c_Barras.Value

        THIS.DesabilitarControlesPrincipais()

        loc_oForm = .NULL.
        TRY
            loc_oForm = CREATEOBJECT("FormSigOpCgl", loc_nCodBarras)
        CATCH TO loc_oErro
            loc_oForm = .NULL.
        ENDTRY

        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ELSE
            MsgAviso("Tela de corre" + CHR(231) + CHR(227) + "o de localiza" + CHR(231) + CHR(227) + ;
                "o (SigOpCgl) ainda n" + CHR(227) + "o foi migrada.", "Aviso")
        ENDIF

        *-- Ao voltar, a localizacao pode ter sido alterada na tela de
        *-- correcao - reconsulta a etiqueta para refletir o valor atual.
        IF THIS.PodeConsultarBanco() AND VARTYPE(loc_nCodBarras) = "N" AND loc_nCodBarras > 0
            IF THIS.this_oBusinessObject.BuscarEtiquetaPorCodBarras(loc_nCodBarras)
                THIS.AtualizarCamposEtiqueta()
            ENDIF
        ENDIF

        THIS.ReabilitarControlesPrincipais()
    ENDPROC

    *==================================================================
    * BtnEncerrarClick - Encerrar (obj_4c_CmdBtnForm.Buttons(1), legado:
    * cmdBtnForm.btnSair.Click = ThisForm.Release).
    *==================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==================================================================
    * BtnImprimirClick / BtnVisualizarClick - disparam a mesma rotina do
    * legado (ThisForm.Imagem('I') / ThisForm.Imagem('V')), precedida pelo
    * SetFocus na grade de Historico que o legado tambem faz antes de
    * chamar Imagem.
    *==================================================================
    PROCEDURE BtnImprimirClick()
        IF !THIS.cmd_4c_BtnImprimir.Enabled
            RETURN
        ENDIF
        THIS.grd_4c_Historico.Column1.SetFocus()
        THIS.ImprimirOuVisualizarEtiqueta("I")
    ENDPROC

    PROCEDURE BtnVisualizarClick()
        IF !THIS.cmd_4c_BtnVisualizar.Enabled
            RETURN
        ENDIF
        THIS.grd_4c_Historico.Column1.SetFocus()
        THIS.ImprimirOuVisualizarEtiqueta("V")
    ENDPROC

    *==================================================================
    * ImprimirOuVisualizarEtiqueta - equivalente ao PROCEDURE imagem do
    * legado: monta o cabecalho da etiqueta (empresa logada, codigo de
    * barras, produto, fornecedor, referencia), garante o .jpg que o FRX
    * carrega e aciona o REPORT FORM SigOpCgb - To Printer Prompt
    * (par_cTipo = "I") ou Preview (par_cTipo = "V").
    *
    * O ALIAS DO CURSOR E CONTRATO DO FRX, NAO NOME ESCOLHIDO AQUI.
    * O SigOpCgb.frx legado le csCabecalho.CodBarras / .CPros / .DPros /
    * .Fornecedor / .Referencia / .empresa - entao o cursor TEM de se
    * chamar csCabecalho, como no legado. Rebatiza-lo para
    * cursor_4c_Etiqueta (PILAR 3) faz o relatorio estourar com
    * "Alias CSCABECALHO is not found": aqui o nome do alias e dado do
    * relatorio, igual a nome de coluna do banco (PILAR 2), e o PILAR 3
    * nao se aplica.
    *
    * A IMAGEM TEM NOME FIXO, TAMBEM POR CONTRATO DO FRX: a expressao do
    * Image do FRX e "Sys(2023) + '\SigOpCgb.Jpg'". Gravar num nome
    * aleatorio (SYS(2015)) escreve um arquivo que o relatorio nunca le e
    * imprime a FOTO DO PRODUTO ANTERIOR, que ficou no nome fixo. Sem
    * foto, o legado grava o fundo BRANCO (BrJpg.JPG) exatamente para
    * nao arrastar a imagem anterior - reproduzido com vbmp\brjpg.jpg.
    *==================================================================
    PROTECTED PROCEDURE ImprimirOuVisualizarEtiqueta(par_cTipo)
        LOCAL loc_oBO, loc_cEmpresa, loc_cArquivoImg, loc_cBranco, loc_cFoto

        loc_oBO = THIS.this_oBusinessObject

        IF EMPTY(THIS.txt_4c_CProduto.Value)
            MsgAviso("Nenhum produto localizado para a etiqueta pesquisada.", "Aviso")
            RETURN
        ENDIF

        *-- Legado: "If !File(lcBrJpg) / MessageBox('Esta Faltando .JPG
        *-- Branco !!!') / Return 0" - sem o fundo branco ele ABORTA.
        loc_cBranco = FULLPATH(gc_4c_CaminhoIcones + "brjpg.jpg")
        IF !FILE(loc_cBranco)
            MsgAviso("Est" + CHR(225) + " faltando o .JPG branco (brjpg.jpg).", "Aviso")
            RETURN
        ENDIF

        loc_cEmpresa = TRIM(loc_oBO.this_cCodEmpresa) + ;
            IIF(!EMPTY(loc_oBO.this_cRazaoEmpresa), " - " + TRIM(loc_oBO.this_cRazaoEmpresa), "")

        IF USED("csCabecalho")
            USE IN csCabecalho
        ENDIF
        CREATE CURSOR csCabecalho ;
            (empresa C(80), codbarras N(14), cpros C(14), dpros C(40), fornecedor C(10), referencia C(10))
        INSERT INTO csCabecalho (empresa, codbarras, cpros, dpros, fornecedor, referencia) ;
            VALUES (loc_cEmpresa, THIS.txt_4c_Barras.Value, THIS.txt_4c_CProduto.Value, ;
                    THIS.txt_4c_DProduto.Value, THIS.txt_4c_CFornecedor.Value, THIS.txt_4c_Referencia.Value)

        *-- Nome FIXO, igual a expressao do Image no FRX.
        loc_cArquivoImg = SYS(2023) + "\SigOpCgb.Jpg"
        loc_cFoto = TratarNulo(loc_oBO.this_cFigJpgBase64, "")
        IF !EMPTY(loc_cFoto)
            loc_cFoto = STRTRAN(loc_cFoto, "data:image/png;base64,", "")
            loc_cFoto = STRTRAN(loc_cFoto, "data:image/jpeg;base64,", "")
            loc_cFoto = STRTRAN(loc_cFoto, "data:image/jpg;base64,", "")
            loc_cFoto = STRCONV(loc_cFoto, 14)
            STRTOFILE(loc_cFoto, loc_cArquivoImg)
        ELSE
            *-- Sem foto: fundo BRANCO, para nao imprimir a do produto anterior.
            COPY FILE (loc_cBranco) TO (loc_cArquivoImg)
        ENDIF

        *-- CLEAR RESOURCES: sem isso o VFP reusa o .jpg CACHEADO e a
        *-- etiqueta sai com a imagem anterior (o legado faz o mesmo).
        CLEAR RESOURCES

        THIS.ExecutarReportForm(gc_4c_CaminhoReports + "SigOpCgb.frx", ;
            IIF(par_cTipo = "I", "PRINTER_PROMPT", "PREVIEW"), "csCabecalho")

        IF USED("csCabecalho")
            USE IN csCabecalho
        ENDIF
    ENDPROC

    *==================================================================
    * ExecutarReportForm - helper canonico de REPORT FORM: guarda de
    * arquivo, guarda de cursor vazio, isolamento de locale e restauracao
    * do menu principal.
    *
    * O isolamento de locale NAO e enfeite: os FRX Fortyus foram feitos
    * com SET POINT "." e REPORTBEHAVIOR 80, e sob o default brasileiro
    * do VFP9 (POINT ",", REPORTBEHAVIOR 90) os campos numericos saem
    * como ******* (CLAUDE.md, pattern #117/#147).
    *
    * O _MREPORT do preview corrompe o _MSYSMENU: sem SET SYSMENU TO
    * DEFAULT + rebuild, o menu principal volta com menos telas (Erro63).
    *
    * par_cModo: "PREVIEW" | "PRINTER" | "PRINTER_PROMPT"
    *==================================================================
    PROCEDURE ExecutarReportForm(par_cFRXPath, par_cModo, par_cCursorDados)
        LOCAL loc_cPonto, loc_cSeparador, loc_nBehavior, loc_lResultado, loc_lProsseguir

        loc_cPonto     = SET("POINT")
        loc_cSeparador = SET("SEPARATOR")
        loc_nBehavior  = SET("REPORTBEHAVIOR")
        loc_lResultado = .F.
        loc_lProsseguir = .T.

        IF !FILE(FULLPATH(par_cFRXPath))
            MsgErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + ;
                CHR(13) + par_cFRXPath, "Relat" + CHR(243) + "rio")
            loc_lProsseguir = .F.
        ENDIF

        IF loc_lProsseguir AND VARTYPE(par_cCursorDados) = "C" AND !EMPTY(par_cCursorDados)
            IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
                MsgAviso("Nenhum dado dispon" + CHR(237) + "vel para o relat" + ;
                    CHR(243) + "rio.", "Relat" + CHR(243) + "rio")
                loc_lProsseguir = .F.
            ENDIF
        ENDIF

        IF loc_lProsseguir
            TRY
                SET POINT TO "."
                SET SEPARATOR TO ","
                SET REPORTBEHAVIOR 80

                DO CASE
                CASE UPPER(ALLTRIM(par_cModo)) = "PREVIEW"
                    REPORT FORM (FULLPATH(par_cFRXPath)) NOCONSOLE PREVIEW
                CASE UPPER(ALLTRIM(par_cModo)) = "PRINTER_PROMPT"
                    REPORT FORM (FULLPATH(par_cFRXPath)) NOCONSOLE TO PRINTER PROMPT
                CASE UPPER(ALLTRIM(par_cModo)) = "PRINTER"
                    REPORT FORM (FULLPATH(par_cFRXPath)) NOCONSOLE TO PRINTER
                OTHERWISE
                    REPORT FORM (FULLPATH(par_cFRXPath)) NOCONSOLE PREVIEW
                ENDCASE

                loc_lResultado = .T.
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "ExecutarReportForm")
            ENDTRY

            SET POINT TO loc_cPonto
            SET SEPARATOR TO loc_cSeparador
            SET REPORTBEHAVIOR loc_nBehavior

            *-- Restaura o menu principal que o _MREPORT do preview corrompe.
            TRY
                SET SYSMENU TO DEFAULT
                RELEASE POPUP popArquivo, popCadastros, popMovimentos, ;
                    popRelatorios, popFerramentas, popAjuda
                CriarMenuPrincipal()
            CATCH TO loc_oErroMenu
                MsgErro(loc_oErroMenu.Message, "ExecutarReportForm")
            ENDTRY
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==================================================================
    * BtnDocumentoClick - abre o documento de movimento da linha CORRENTE
    * da grade ativa (Historico/Movimento/Devolucao - this_nGradeSel),
    * igual ao legado: localiza o documento em SigMvCab (CongBEest);
    * achando, abre FormSigMvExp; nao achando, confere SigCdNec (EmpDnPs) e
    * abre FormSigMvPdt; sem nenhum dos dois, avisa que a operacao nao foi
    * encontrada.
    *==================================================================
    PROCEDURE BtnDocumentoClick()
        LOCAL loc_cEmps, loc_cDopes, loc_nNumes, loc_cEDN, loc_oForm, loc_oBO

        IF !THIS.cmd_4c_BtnDocumento.Enabled
            RETURN
        ENDIF

        loc_cEmps  = ""
        loc_cDopes = ""
        loc_nNumes = 0
        loc_cEDN   = ""

        DO CASE
        CASE THIS.this_nGradeSel = 2 AND USED("cursor_4c_Movimento") AND !EOF("cursor_4c_Movimento")
            loc_cEmps  = TratarNulo(cursor_4c_Movimento.emps, "")
            loc_cDopes = TratarNulo(cursor_4c_Movimento.dopes, "")
            loc_nNumes = NVL(cursor_4c_Movimento.numes, 0)
            loc_cEDN   = TratarNulo(cursor_4c_Movimento.OriDopNums, "")
        CASE THIS.this_nGradeSel = 3 AND USED("cursor_4c_Devolucao") AND !EOF("cursor_4c_Devolucao")
            loc_cEmps  = TratarNulo(cursor_4c_Devolucao.emps, "")
            loc_cDopes = TratarNulo(cursor_4c_Devolucao.dopes, "")
            loc_nNumes = NVL(cursor_4c_Devolucao.numes, 0)
            loc_cEDN   = TratarNulo(cursor_4c_Devolucao.OriDopNums, "")
        OTHERWISE
            IF USED("cursor_4c_Historico") AND !EOF("cursor_4c_Historico")
                loc_cEmps  = TratarNulo(cursor_4c_Historico.emps, "")
                loc_cDopes = TratarNulo(cursor_4c_Historico.dopes, "")
                loc_nNumes = NVL(cursor_4c_Historico.numes, 0)
                loc_cEDN   = TratarNulo(cursor_4c_Historico.OriDopNums, "")
            ENDIF
        ENDCASE

        IF EMPTY(loc_cEmps) OR EMPTY(loc_cDopes) OR loc_nNumes = 0
            MsgAviso("Selecione uma Etiqueta em uma das listas para visualizar o Documento!", "Aviso")
            RETURN
        ENDIF

        IF !THIS.PodeConsultarBanco()
            RETURN
        ENDIF

        loc_oBO   = THIS.this_oBusinessObject
        loc_oForm = .NULL.

        IF loc_oBO.LocalizarDocumentoPorChave(loc_cEDN)
            TRY
                loc_oForm = CREATEOBJECT("FormSigMvExp", loc_oBO.this_cDopesDocto, "C", ;
                    loc_oBO.this_nNumesDocto, loc_oBO.this_cEmpsDocto, .T.)
            CATCH TO loc_oErro
                loc_oForm = .NULL.
            ENDTRY

            IF VARTYPE(loc_oForm) = "O"
                loc_oForm.Show()
            ELSE
                MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel abrir a tela de " + ;
                    "Movimenta" + CHR(231) + CHR(227) + "o (SigMvExp).", "Aviso")
            ENDIF
        ELSE
            IF loc_oBO.ExisteNecessidadePorChave(loc_cEmps, loc_cDopes, loc_nNumes)
                TRY
                    loc_oForm = CREATEOBJECT("FormSigMvPdt", loc_cDopes, "C", loc_nNumes, loc_cEmps, .T.)
                CATCH TO loc_oErro
                    loc_oForm = .NULL.
                ENDTRY

                IF VARTYPE(loc_oForm) = "O"
                    loc_oForm.Show()
                ELSE
                    MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel abrir a tela de " + ;
                        "Pedido (SigMvPdt).", "Aviso")
                ENDIF
            ELSE
                MsgErro("A opera" + CHR(231) + CHR(227) + "o selecionada n" + CHR(227) + ;
                    "o pode ser encontrada!" + CHR(13) + ;
                    "Posicione em uma opera" + CHR(231) + CHR(227) + "o v" + CHR(225) + ;
                    "lida na lista!", "Documento")
            ENDIF
        ENDIF
    ENDPROC

    *==================================================================
    * BotRastroClick - abre a tela de rastreabilidade (legado: Do Form
    * SigReCgr With 1, ThisForm.GetBarras.Value, ThisForm). SigReCgr ainda
    * nao foi migrada - mesmo guard do BtnLocalClick (CREATEOBJECT dentro
    * do TRY, Show() FORA - regra CLAUDE.md #29).
    *==================================================================
    PROCEDURE BotRastroClick()
        LOCAL loc_nCodBarras, loc_oForm

        IF !THIS.cmd_4c_BotRastro.Enabled
            RETURN
        ENDIF

        loc_nCodBarras = THIS.txt_4c_Barras.Value
        loc_oForm = .NULL.

        TRY
            loc_oForm = CREATEOBJECT("FormSigReCgr", 1, loc_nCodBarras, THIS)
        CATCH TO loc_oErro
            loc_oForm = .NULL.
        ENDTRY

        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ELSE
            MsgAviso("Tela de rastreabilidade (SigReCgr) ainda n" + CHR(227) + "o foi migrada.", "Aviso")
        ENDIF

        *-- Legado: devolve o foco para a grade ativa (Movimento ou Historico)
        IF THIS.this_nGradeSel = 2
            THIS.grd_4c_Movimento.Column1.SetFocus()
        ELSE
            THIS.grd_4c_Historico.Column1.SetFocus()
        ENDIF
    ENDPROC

    *==================================================================
    * BotaoCorrecaoClick - abre o painel de correcao de etiquetas (legado:
    * Botao_de_Correcao.Click), desabilitando os demais controles (mesma
    * lista do BtnLocalClick) e carregando o historico de correcoes da
    * etiqueta (SigEtHst) na grade grd_4c_Correcao.
    *==================================================================
    PROCEDURE BotaoCorrecaoClick()
        LOCAL loc_nCodBarras

        IF !THIS.cmd_4c_BotaoCorrecao.Enabled
            RETURN
        ENDIF

        loc_nCodBarras = THIS.txt_4c_Barras.Value

        THIS.DesabilitarControlesPrincipais()

        IF THIS.PodeConsultarBanco()
            THIS.this_oBusinessObject.CarregarCorrecaoPorCodBarras(loc_nCodBarras)
        ENDIF

        WITH THIS.cnt_4c_Correcao
            .Top     = (THIS.Height / 2) - (.Height / 2)
            .Visible = .T.
            .Refresh()
            .grd_4c_Correcao.Refresh()
            .grd_4c_Correcao.Column1.SetFocus()
        ENDWITH
    ENDPROC

    *==================================================================
    * PainelCorrecaoEncerrarClick - fecha o painel de correcao (legado:
    * Cnt_Correcao.cmdBtnForm.btnSair.Click) e reabilita os demais
    * controles - NAO fecha o form (eh so o painel flutuante).
    *==================================================================
    PROCEDURE PainelCorrecaoEncerrarClick()
        THIS.ReabilitarControlesPrincipais()
        THIS.cnt_4c_Correcao.Visible = .F.
    ENDPROC

    *==================================================================
    * BotCotacoesClick - chk_4c_BotCotacoes: liga/desliga o painel de
    * cotacoes (legado: This.Parent.grdCot.Visible = This.Value), atualizando
    * a grade so quando o checkbox eh marcado.
    *==================================================================
    PROCEDURE BotCotacoesClick()
        LOCAL loc_lMostrar

        loc_lMostrar = (THIS.chk_4c_BotCotacoes.Value = 1)

        IF loc_lMostrar
            THIS.AtualizarGradeCotacoes()
        ENDIF

        THIS.cnt_4c_GrdCot.Visible = loc_lMostrar
        THIS.cnt_4c_GrdCot.Refresh()
    ENDPROC

    *==================================================================
    * AtualizarGradeCotacoes - recarrega cursor_4c_Cotacoes com a cotacao de
    * cada moeda na data do registro CORRENTE da grade de Historico (legado:
    * fBuscarCotacao(TmpCot.cmoes, csHistorico.Datas, ...)).
    *==================================================================
    PROTECTED PROCEDURE AtualizarGradeCotacoes()
        LOCAL loc_dData

        loc_dData = {}
        IF USED("cursor_4c_Historico") AND !EOF("cursor_4c_Historico")
            loc_dData = ConverterParaData(cursor_4c_Historico.datas)
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND THIS.PodeConsultarBanco()
            THIS.this_oBusinessObject.CarregarCotacoesPorData(loc_dData)
            THIS.cnt_4c_GrdCot.lbl_4c_TituloCotacoes.Caption = "Cota" + CHR(231) + CHR(245) + "es na Data"
            THIS.cnt_4c_GrdCot.grd_4c_Cotacoes.Refresh()
        ENDIF
    ENDPROC

    *==================================================================
    * FecharCursoresGrades - Fecha os cursores das grades. Chamado pelo
    * Destroy: as grades morrem com o form, mas os aliases sao globais a
    * data session e ficariam abertos.
    *==================================================================
    PROTECTED PROCEDURE FecharCursoresGrades()
        IF USED("cursor_4c_Historico")
            USE IN cursor_4c_Historico
        ENDIF
        IF USED("cursor_4c_Movimento")
            USE IN cursor_4c_Movimento
        ENDIF
        IF USED("cursor_4c_Devolucao")
            USE IN cursor_4c_Devolucao
        ENDIF
        IF USED("cursor_4c_Cotacoes")
            USE IN cursor_4c_Cotacoes
        ENDIF
        IF USED("cursor_4c_Correcao")
            USE IN cursor_4c_Correcao
        ENDIF

        RETURN .T.
    ENDPROC

    *==================================================================
    * PodeConsultarBanco - .T. quando ha conexao real E o form nao esta
    * sendo instanciado por validacao de UI / teste automatizado (onde
    * nao existe banco para consultar).
    *==================================================================
    FUNCTION PodeConsultarBanco()
        LOCAL loc_lPode

        loc_lPode = (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)

        IF loc_lPode AND TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            loc_lPode = .F.
        ENDIF

        IF loc_lPode AND TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            loc_lPode = .F.
        ENDIF

        RETURN loc_lPode
    ENDFUNC

    *==================================================================
    * Destroy - Fecha os cursores das grades, libera o Business Object e
    * chama DODEFAULT (FormBase.Destroy, que reconstroi o menu principal)
    *==================================================================
    PROCEDURE Destroy()
        *-- Desarma o timer de foco ANTES de derrubar o resto: timer armado
        *-- disparando durante o teardown chamaria SetFocus num controle que
        *-- ja esta sendo destruido.
        IF PEMSTATUS(THIS, "tmr_4c_FocoBarras", 5)
            THIS.tmr_4c_FocoBarras.Enabled = .F.
        ENDIF

        THIS.FecharCursoresGrades()

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.LiberarCursoresConsulta()
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
