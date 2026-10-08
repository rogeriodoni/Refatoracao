*==============================================================================
* FormSigPrApr.prg - Formulario OPERACIONAL: Reajuste de Precificacao
* Equivalente ao SIGPRAPR.SCX do legado (form generico com layout proprio -
* SEM PageFrame/Page1/Page2; processo em lote que reajusta o preco de um
* conjunto de produtos e nao segue o padrao Lista/Dados do CRUD)
*
* Fase 3/8 - Estrutura Base: DEFINE CLASS, Init/InicializarForm e o cabecalho
* (equivalente ao cntSombra do legado).
*
* Fase 4/8 - Grid e Botoes: grd_4c_Produtos (SIGPRAPR.Grd_Produto - grade de
* conferencia, 5 colunas, marca/desmarca no Header1.Click) + cmg_4c_Botoes
* (SIGPRAPR.sair - Processar/Encerrar/Atualizar). A consulta/calculo de
* Processar e a gravacao de Atualizar ja estao implementadas em
* SigPrAprBO.BuscarProdutos()/Atualizar() - os handlers do form so acionam o
* BO e refletem o resultado na tela (regra: nenhum botao visivel fica sem
* funcionalidade real).
*
* Fase 5/8 - Campos Parte 1 (ConfigurarCampos): Grupo de Produto (de/ate),
* Grupo de Venda (Colecao) e TODOS os campos que o Opt_Tipo.
* InteractiveChange legado alterna via Visible (transcrito em
* OptTipoInteractiveChange) - Variacao/%/Incluir Custos (Tipo=1), Moeda/
* MarkUp1/MarkUp2/Fator de Custo/Moeda do Fator e o grupo Moeda Custo Compo./
* Moeda Custo Total/Feitio/Moeda Preco Ideal/Moeda Preco Atual (Tipo=2).
* SincronizarFiltros copia esses campos para o BO antes de BuscarProdutos()
* (BtnProcessarClick).
*
* Fase 6/8 - Campos Parte 2 (ConfigurarCampos) + Lookups: os campos que o
* Opt_Tipo NAO alterna - Promocao (Get_Promo), Limpar Promocoes Anteriores
* (chkLimpar), Ignorar Componentes (chkIgnorar) e Fornecedor (Get_Conta/
* Get_DConta). Fornecedor substitui o fAcessoContas('C'/'D',...) legado pelo
* padrao canonico do projeto (FormBase.AbrirLookupCanonico com filtro
* Grupos=GrPadFors, ao inves do auto-load por LIKE que fAcessoContas fazia -
* regra feedback_facessocontas_lookup_ux.md). Promocao usa o mesmo padrao
* contra SigPrPmc (tabela single-column, igual a SigCdOpe). SincronizarFiltros
* passou a copiar tambem estes campos.
*
* Fase 7/8 - Eventos Principais: este form OPERACIONAL nao tem CRUD
* (Incluir/Alterar/Visualizar/Excluir) - os "eventos principais" de verdade
* sao os que restaram em aberto das fases anteriores:
*   1) Lookup F4/Enter/Tab dos 10 campos de codigo que a Fase 5 criou so como
*      TextBox simples (Get_Cd_Grupo/Get_ate_Grupo -> SigCdGrp, Get_Col ->
*      SigCdCol, Get_CFtios -> SigPrFti, e os 6 campos de moeda -> SigCdMoe),
*      usando o mesmo padrao KeyPress + AbrirLookupCanonico ja usado em
*      Fornecedor/Promocao (Fase 6).
*   2) Get_Variacao.LostFocus -> foco no botao Processar (navegacao trivial,
*      mas eh evento real do legado).
*   3) O modo "Produtos" (chkAuditado + Shp_foto/FigJpg), explicitamente
*      adiado nas Fases 5/6: inclusao manual de um produto na grade, fora do
*      filtro Grupo/Colecao/Fornecedor - controles criados agora em
*      ConfigurarModoProdutos(), com o toggle (ChkAuditadoClick), o lookup
*      de produto na propria celula da grade (Grd_Produto.Column2) e o
*      calculo de preco ao confirmar o codigo digitado (Column2LostFocus).
*   4) Grd_Produto.AfterRowColChange (GridAfterRowColChange) - carrega a
*      foto do produto da linha corrente (SigCdPro.FigJpgs, base64) em
*      img_4c_FigJpg. Decodificar com STRCONV(...,14) UMA UNICA VEZ - um
*      segundo STRCONV sobre o binario ja decodificado corrompe o JPEG
*      (feedback_strconv_double_decode_imagem.md).
*
* Fase 8/8 - Consolidacao final: este form OPERACIONAL nao tem CRUD (sem
* PageFrame/Page1/Page2), entao o checklist generico de Fase 8
* (BtnSalvarClick/BtnCancelarClick/FormParaBO/BOParaForm/HabilitarCampos/
* LimparCampos/AjustarBotoesPorModo) nao se aplica - os equivalentes
* OPERACIONAIS ja foram entregues nas fases anteriores: BtnProcessarClick/
* BtnAtualizarClick/BtnEncerrarClick (botoes), CarregarLista (recarga da
* grade), SincronizarFiltros (Form->BO, equivalente a FormParaBO) e
* ChkAuditadoClick (toggle Enabled dos campos por estado, equivalente a
* HabilitarCampos). Integracao conferida: menu.prg (popMovimentos bar 22 ->
* AbrirFormSigPrApr, padrao canonico Show() fora do TRY) e config.prg (ADIR
* carrega SigPrAprBO.prg/FormSigPrApr.prg automaticamente - sem SET
* PROCEDURE manual). Nenhum .fxp de SigPrApr* presente na arvore.
*
* Herda de: FormBase
*==============================================================================

DEFINE CLASS FormSigPrApr AS FormBase

    Width       = 1000
    Height      = 600
    Caption     = "Reajuste de Precifica" + CHR(231) + CHR(227) + "o"
    DataSession = 2
    ShowWindow = 1
    WindowType = 1
    BorderStyle = 2
    DoCreate    = .T.
    ShowTips    = .T.
    AutoCenter  = .T.
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    WindowState = 0
    Themes      = .F.
    FontName    = "Verdana"
    FontSize    = 8

    *-- Propriedades customizadas do form legado (SIGPRAPR.antvalue / .libvalatu)
    this_cAntValue  = ""
    this_lLibValAtu = .F.

    *==========================================================================
    * Init - DODEFAULT() ja chama InicializarForm() atraves do FormBase.Init()
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria o Business Object e monta a estrutura base do
    * form (fundo + cabecalho). Grade, filtros, botoes de processamento e
    * demais campos sao adicionados nas fases seguintes da migracao.
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrAprBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar SigPrAprBO." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "Erro em FormSigPrApr.InicializarForm")
            ELSE
                IF FILE(gc_4c_CaminhoFramework + "Imagens\new_background.jpg")
                    THIS.Picture = gc_4c_CaminhoFramework + "Imagens\new_background.jpg"
                ENDIF

                THIS.this_lLibValAtu = THIS.this_oBusinessObject.this_lLibValAtu

                THIS.ConfigurarPageFrame()

                THIS.TornarControlesVisiveis(THIS)

                *-- TornarControlesVisiveis torna TODOS os controles visiveis
                *-- (regra do AddObject) - reaplicar o toggle do Opt_Tipo por
                *-- cima para esconder de novo os campos que nao pertencem ao
                *-- modo Variacao (Tipo=1, selecao inicial do OptionGroup)
                THIS.OptTipoInteractiveChange()

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormSigPrApr.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Ponto de entrada da montagem visual do form.
    * SIGPRAPR (SCX legado, Width=1000 Height=600) e dialog PLANO sem
    * PageFrame - PILAR 1 (UX pixel-perfect) manda manter o layout flat
    * identico ao legado ao inves de introduzir abas artificialmente. Este
    * metodo organiza as regioes visuais delegando para helpers dedicados,
    * preservando o papel de "ConfigurarPageFrame" como ponto de entrada da
    * montagem visual (mesmo padrao de FormFis/FormFAPF).
    *
    * A faixa do cabecalho (ConfigurarCabecalho) tem de ser o PRIMEIRO
    * AddObject da tela - os botoes de acao (cnt_4c_Sombra ocupa Top=0..80,
    * cmg_4c_Botoes flutua em Top=-2..83) ficam DENTRO da area da faixa e so
    * aparecem se criados DEPOIS dela.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarCampos()
        THIS.ConfigurarGrid()
        THIS.ConfigurarBotoes()
        THIS.ConfigurarModoProdutos()
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Faixa cinza do topo com o titulo do form
    * (SIGPRAPR.cntSombra + lblSombra/lblTitulo no legado)
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
            .BackColor   = RGB(100, 100, 100)
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .Top       = 15
            .Left      = 10
            .Width     = THIS.Width
            .Height    = 40
            .AutoSize  = .F.
            .WordWrap  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .Caption   = THIS.Caption
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width
            .Height    = 46
            .AutoSize  = .F.
            .WordWrap  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .Caption   = THIS.Caption
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarCampos - Campos de filtro/reajuste (SIGPRAPR - PARTE 1/2 desta
    * migracao). Cobre: Grupo de Produto (de/ate), Grupo de Venda (Colecao),
    * tipo de reajuste (Opt_Tipo) e TODOS os campos que o Opt_Tipo.
    * InteractiveChange do legado alterna via Visible (Variacao/%, Moeda,
    * MarkUp1/MarkUp2, Fator de Custo+Moeda do Fator, Incluir Custos, e o
    * grupo Moeda Custo Compo./Moeda Custo Total/Feitio/Moeda Preco Ideal/
    * Moeda Preco Atual). Ficam para a Parte 2: Fornecedor (Get_Conta/
    * Get_DConta), Promocao, Limpar Promocoes Anteriores, Ignorar Componentes
    * e o modo "Produtos" (chkAuditado + Shp_foto/FigJpg) - nenhum desses eh
    * tocado pelo Opt_Tipo.
    *
    * Todos os controles vao direto em THIS (form flat, sem PageFrame/Page -
    * mesmo padrao de cnt_4c_Sombra/grd_4c_Produtos/cmg_4c_Botoes).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCampos()
        *-- Say10 "Reajuste por :" (label acima do OptionGroup)
        THIS.AddObject("lbl_4c_ReajustePor", "Label")
        WITH THIS.lbl_4c_ReajustePor
            .Top       = 139
            .Left      = 92
            .Width     = 71
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Reajuste por :"
        ENDWITH

        *-- lbl_grupo "Grupo de Produto :" + Get_Cd_Grupo (de) + Say5 "ate" +
        *-- Get_ate_Grupo (faixa de grupo, mesmo par usado no WHERE de
        *-- BuscarProdutos - this_cCdGrupo/this_cAteGrupo)
        THIS.AddObject("lbl_4c_Grupo", "Label")
        WITH THIS.lbl_4c_Grupo
            .Top       = 113
            .Left      = 69
            .Width     = 94
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Grupo de Produto :"
        ENDWITH

        THIS.AddObject("txt_4c_CdGrupo", "TextBox")
        WITH THIS.txt_4c_CdGrupo
            .Top       = 109
            .Left      = 165
            .Width     = 31
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Format    = "K!"
            .MaxLength = 3
            .Value     = ""
        ENDWITH
        BINDEVENT(THIS.txt_4c_CdGrupo, "KeyPress", THIS, "TxtCdGrupoKeyPress")

        THIS.AddObject("lbl_4c_AteGrupo", "Label")
        WITH THIS.lbl_4c_AteGrupo
            .Top       = 113
            .Left      = 203
            .Width     = 18
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "at" + CHR(233)
        ENDWITH

        THIS.AddObject("txt_4c_AteGrupo", "TextBox")
        WITH THIS.txt_4c_AteGrupo
            .Top       = 109
            .Left      = 228
            .Width     = 31
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Format    = "K!"
            .MaxLength = 3
            .Value     = ""
        ENDWITH
        BINDEVENT(THIS.txt_4c_AteGrupo, "KeyPress", THIS, "TxtAteGrupoKeyPress")

        *-- Say2 "Grupo de Venda :" + Get_Col (this_cColecao)
        THIS.AddObject("lbl_4c_GrupoVenda", "Label")
        WITH THIS.lbl_4c_GrupoVenda
            .Top       = 113
            .Left      = 399
            .Width     = 86
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Grupo de Venda :"
        ENDWITH

        THIS.AddObject("txt_4c_Colecao", "TextBox")
        WITH THIS.txt_4c_Colecao
            .Top       = 109
            .Left      = 487
            .Width     = 94
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Format    = "K"
            .MaxLength = 10
            .Value     = ""
        ENDWITH
        BINDEVENT(THIS.txt_4c_Colecao, "KeyPress", THIS, "TxtColecaoKeyPress")

        *-- Opt_Tipo (fwoption -> OptionGroup): 1=Variacao, 2=MarkUp, 3=Cambio
        *-- (this_nTipo). InteractiveChange (transcrito em
        *-- OptTipoInteractiveChange) alterna a visibilidade de todos os
        *-- campos abaixo conforme o botao selecionado.
        THIS.AddObject("opt_4c_Tipo", "OptionGroup")
        WITH THIS.opt_4c_Tipo
            .Top           = 134
            .Left          = 159
            .Width         = 208
            .Height        = 24
            .ButtonCount   = 3
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 0
            .Value         = 1

            WITH .Buttons(1)
                .Top       = 5
                .Left      = 5
                .Width     = 59
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Varia" + CHR(231) + CHR(227) + "o"
            ENDWITH

            WITH .Buttons(2)
                .Top       = 5
                .Left      = 74
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "MarkUp"
            ENDWITH

            WITH .Buttons(3)
                .Top       = 5
                .Left      = 139
                .Width     = 53
                .Height    = 15
                .Alignment = 2
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "C" + CHR(226) + "m\<bio"
                .WordWrap        = .T.
            ENDWITH
        ENDWITH
        BINDEVENT(THIS.opt_4c_Tipo, "InteractiveChange", THIS, "OptTipoInteractiveChange")

        *-- lbl_Variacao "Variacao de Preco :" + Get_Variacao (%) + Say1 "%"
        *-- (visivel so com Tipo=1)
        THIS.AddObject("lbl_4c_Variacao", "Label")
        WITH THIS.lbl_4c_Variacao
            .Top       = 139
            .Left      = 390
            .Width     = 95
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Varia" + CHR(231) + CHR(227) + "o de Pre" + CHR(231) + "o :"
        ENDWITH

        THIS.AddObject("txt_4c_Variacao", "TextBox")
        WITH THIS.txt_4c_Variacao
            .Top       = 135
            .Left      = 487
            .Width     = 94
            .Height    = 23
            .Alignment = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .InputMask = "99,999.99"
            .MaxLength = 9
            .Value     = 0
        ENDWITH
        *-- Legado: PROCEDURE LostFocus -> ThisForm.Sair.Processa.SetFocus
        BINDEVENT(THIS.txt_4c_Variacao, "KeyPress", THIS, "TxtVariacaoLostFocus")

        THIS.AddObject("lbl_4c_Percentual", "Label")
        WITH THIS.lbl_4c_Percentual
            .Top       = 139
            .Left      = 585
            .Width     = 13
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "%"
        ENDWITH

        *-- lbl_Moeda "Moeda :" + Get_Moeda (visivel so com Tipo=2 - moeda
        *-- base do MarkUp, this_cMoeda). Ocupa o MESMO Top/Left do
        *-- Get_Variacao no legado (137,487) - so um dos dois esta visivel
        *-- por vez, conforme Opt_Tipo.
        THIS.AddObject("lbl_4c_Moeda", "Label")
        WITH THIS.lbl_4c_Moeda
            .Top       = 139
            .Left      = 444
            .Width     = 41
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Moeda :"
        ENDWITH

        THIS.AddObject("txt_4c_Moeda", "TextBox")
        WITH THIS.txt_4c_Moeda
            .Top       = 135
            .Left      = 487
            .Width     = 31
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Format    = "K!"
            .MaxLength = 3
            .Value     = ""
        ENDWITH
        BINDEVENT(THIS.txt_4c_Moeda, "KeyPress", THIS, "TxtMoedaKeyPress")

        *-- lbl_MarkUp "MarkUp :" + Get_MarkUp1 + Say4 "para" + Get_MarkUp2
        *-- (faixa de markup, visivel so com Tipo=2 - this_nMarkUp1/
        *-- this_nMarkUp2, usados no WHERE e no calculo de CalcPreco)
        THIS.AddObject("lbl_4c_MarkUp", "Label")
        WITH THIS.lbl_4c_MarkUp
            .Top       = 165
            .Left      = 440
            .Width     = 45
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "MarkUp :"
        ENDWITH

        THIS.AddObject("txt_4c_MarkUp1", "TextBox")
        WITH THIS.txt_4c_MarkUp1
            .Top       = 161
            .Left      = 487
            .Width     = 52
            .Height    = 23
            .Alignment = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .InputMask = "999.99"
            .MaxLength = 6
            .Value     = 0
        ENDWITH

        THIS.AddObject("lbl_4c_Para", "Label")
        WITH THIS.lbl_4c_Para
            .Top       = 165
            .Left      = 547
            .Width     = 24
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "para"
        ENDWITH

        THIS.AddObject("txt_4c_MarkUp2", "TextBox")
        WITH THIS.txt_4c_MarkUp2
            .Top       = 161
            .Left      = 580
            .Width     = 52
            .Height    = 23
            .Alignment = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .InputMask = "999.99"
            .MaxLength = 6
            .Value     = 0
        ENDWITH

        *-- Say8 "Fator de Custo:" + GET_FATOR + get_moeCusto (this_nFator/
        *-- this_cMoeCusto - visivel so com Tipo=2)
        THIS.AddObject("lbl_4c_FatorCusto", "Label")
        WITH THIS.lbl_4c_FatorCusto
            .Top       = 165
            .Left      = 85
            .Width     = 78
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Fator de Custo:"
        ENDWITH

        THIS.AddObject("txt_4c_Fator", "TextBox")
        WITH THIS.txt_4c_Fator
            .Top       = 161
            .Left      = 165
            .Width     = 73
            .Height    = 23
            .Alignment = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .InputMask = "9999.999"
            .MaxLength = 8
            .Value     = 0
        ENDWITH

        THIS.AddObject("txt_4c_MoeCusto", "TextBox")
        WITH THIS.txt_4c_MoeCusto
            .Top       = 161
            .Left      = 241
            .Width     = 31
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Format    = "K!"
            .MaxLength = 3
            .Value     = ""
        ENDWITH
        BINDEVENT(THIS.txt_4c_MoeCusto, "KeyPress", THIS, "TxtMoeCustoKeyPress")

        *-- chkIncCusts "Incluir Custos" (this_lIncCusts - visivel so com
        *-- Tipo=1, reajusta tambem PCuss/CustoFs proporcionalmente)
        THIS.AddObject("chk_4c_IncCusts", "CheckBox")
        WITH THIS.chk_4c_IncCusts
            .Top       = 139
            .Left      = 609
            .Width     = 83
            .Height    = 15
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Incluir Custos"
            .Value     = 0
        ENDWITH

        *-- Moeda Custo Compo. (Get_Moecs -> this_cMoeCs), visivel so com Tipo=2
        THIS.AddObject("lbl_4c_MoedaCusCompo", "Label")
        WITH THIS.lbl_4c_MoedaCusCompo
            .Top       = 244
            .Left      = 51
            .Width     = 112
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Moeda Custo Compo. :"
        ENDWITH

        THIS.AddObject("txt_4c_MoeCs", "TextBox")
        WITH THIS.txt_4c_MoeCs
            .Top       = 240
            .Left      = 165
            .Width     = 31
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Format    = "K!"
            .MaxLength = 3
            .Value     = ""
        ENDWITH
        BINDEVENT(THIS.txt_4c_MoeCs, "KeyPress", THIS, "TxtMoeCsKeyPress")

        *-- Moeda Custo Total (Get_MoeCusFs -> this_cMoeCusFs), Tipo=2
        THIS.AddObject("lbl_4c_MoedaCusTotal", "Label")
        WITH THIS.lbl_4c_MoedaCusTotal
            .Top       = 270
            .Left      = 64
            .Width     = 99
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Moeda Custo Total :"
        ENDWITH

        THIS.AddObject("txt_4c_MoeCusFs", "TextBox")
        WITH THIS.txt_4c_MoeCusFs
            .Top       = 266
            .Left      = 165
            .Width     = 31
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Format    = "K!"
            .MaxLength = 3
            .Value     = ""
        ENDWITH
        BINDEVENT(THIS.txt_4c_MoeCusFs, "KeyPress", THIS, "TxtMoeCusFsKeyPress")

        *-- Feitio (Get_CFtios -> this_cCFtios), Tipo=2
        THIS.AddObject("lbl_4c_Feitio", "Label")
        WITH THIS.lbl_4c_Feitio
            .Top       = 244
            .Left      = 531
            .Width     = 35
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Feitio :"
        ENDWITH

        THIS.AddObject("txt_4c_CFtios", "TextBox")
        WITH THIS.txt_4c_CFtios
            .Top       = 240
            .Left      = 568
            .Width     = 31
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Format    = "K!"
            .MaxLength = 3
            .Value     = ""
        ENDWITH
        BINDEVENT(THIS.txt_4c_CFtios, "KeyPress", THIS, "TxtCFtiosKeyPress")

        *-- Moeda Preco Ideal (Get_Moedas -> this_cMoedas), Tipo=2
        THIS.AddObject("lbl_4c_MoedaPrecoIdeal", "Label")
        WITH THIS.lbl_4c_MoedaPrecoIdeal
            .Top       = 244
            .Left      = 320
            .Width     = 98
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Moeda Pre" + CHR(231) + "o Ideal :"
        ENDWITH

        THIS.AddObject("txt_4c_Moedas", "TextBox")
        WITH THIS.txt_4c_Moedas
            .Top       = 240
            .Left      = 420
            .Width     = 31
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Format    = "K!"
            .MaxLength = 3
            .Value     = ""
        ENDWITH
        BINDEVENT(THIS.txt_4c_Moedas, "KeyPress", THIS, "TxtMoedasKeyPress")

        *-- Moeda Preco Atual (Get_MoeVs -> this_cMoeVs), Tipo=2
        THIS.AddObject("lbl_4c_MoedaPrecoAtual", "Label")
        WITH THIS.lbl_4c_MoedaPrecoAtual
            .Top       = 270
            .Left      = 319
            .Width     = 99
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Moeda Pre" + CHR(231) + "o Atual :"
        ENDWITH

        THIS.AddObject("txt_4c_MoeVs", "TextBox")
        WITH THIS.txt_4c_MoeVs
            .Top       = 266
            .Left      = 420
            .Width     = 31
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Format    = "K!"
            .MaxLength = 3
            .Value     = ""
        ENDWITH
        BINDEVENT(THIS.txt_4c_MoeVs, "KeyPress", THIS, "TxtMoeVsKeyPress")

        *----------------------------------------------------------------------
        * PARTE 2 (Fase 6/8) - campos que o Opt_Tipo NAO alterna: sempre
        * visiveis, sem depender do tipo de reajuste escolhido.
        *----------------------------------------------------------------------

        *-- Say6 "Promocao :" + Get_Promo (this_cPromo, SigPrPmc.Promos -
        *-- lookup single-column, igual a SigCdOpe/Dopes)
        THIS.AddObject("lbl_4c_Promocao", "Label")
        WITH THIS.lbl_4c_Promocao
            .Top       = 191
            .Left      = 107
            .Width     = 56
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Promo" + CHR(231) + CHR(227) + "o :"
        ENDWITH

        THIS.AddObject("txt_4c_Promo", "TextBox")
        WITH THIS.txt_4c_Promo
            .Top       = 187
            .Left      = 165
            .Width     = 185
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .MaxLength = 25
            .Value     = ""
            .Format = "K!"
        ENDWITH
        BINDEVENT(THIS.txt_4c_Promo, "KeyPress", THIS, "TxtPromoKeyPress")

        *-- chkLimpar "Limpar Promocoes Anteriores" (this_lLimparPromos)
        THIS.AddObject("chk_4c_Limpar", "CheckBox")
        WITH THIS.chk_4c_Limpar
            .Top       = 191
            .Left      = 362
            .Width     = 157
            .Height    = 15
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Limpar Promo" + CHR(231) + CHR(245) + "es Anteriores"
            .Value     = 0
        ENDWITH

        *-- chkIgnorar "Ignorar Componentes" (this_lIgnorar - nao filtra
        *-- produto-componente na consulta de BuscarProdutos)
        THIS.AddObject("chk_4c_Ignorar", "CheckBox")
        WITH THIS.chk_4c_Ignorar
            .Top       = 112
            .Left      = 609
            .Width     = 123
            .Height    = 15
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Ignorar Componentes"
            .Value     = 0
        ENDWITH

        *-- Say7 "Fornecedor :" + Get_Conta (codigo) + Get_DConta (descricao) -
        *-- lookup restrito ao grupo padrao de acesso a Contas
        *-- (this_oBusinessObject.this_cGrPadFors, carregado no Init do BO a
        *-- partir de SigCdPam.GrPadFors - equivalente a "Grupo =
        *-- CrSigCdPam.GrPadFors" do legado). Substitui fAcessoContas() (regra
        *-- feedback_facessocontas_lookup_ux.md - NAO usar auto-load por LIKE).
        THIS.AddObject("lbl_4c_Fornecedor", "Label")
        WITH THIS.lbl_4c_Fornecedor
            .Top       = 216
            .Left      = 99
            .Width     = 64
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Fornecedor :"
        ENDWITH

        THIS.AddObject("txt_4c_Conta", "TextBox")
        WITH THIS.txt_4c_Conta
            .Top       = 213
            .Left      = 165
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .MaxLength = 10
            .Value     = ""
        ENDWITH
        BINDEVENT(THIS.txt_4c_Conta, "KeyPress", THIS, "TxtContaKeyPress")

        THIS.AddObject("txt_4c_DConta", "TextBox")
        WITH THIS.txt_4c_DConta
            .Top        = 213
            .Left       = 248
            .Width      = 290
            .Height     = 23
            .FontName   = "Tahoma"
            .FontSize   = 8
            .ForeColor  = RGB(0, 0, 0)
            .MaxLength  = 50
            .Value      = ""
        ENDWITH
        BINDEVENT(THIS.txt_4c_DConta, "KeyPress", THIS, "TxtDContaKeyPress")
    ENDPROC

    *==========================================================================
    * OptTipoInteractiveChange - Transcreve o PROCEDURE InteractiveChange do
    * Opt_Tipo legado: alterna a visibilidade dos campos conforme o tipo de
    * reajuste escolhido (1=Variacao, 2=MarkUp, 3=Cambio - Cambio nao usa
    * nenhum dos campos abaixo, so Grupo/Colecao/Fornecedor/Promo, que ficam
    * sempre visiveis). PUBLIC de proposito: acionado via BINDEVENT
    * (InteractiveChange) e tambem chamado direto por InicializarForm/
    * TesteAutomatico para repor o estado inicial (Tipo=1).
    *
    * PEMSTATUS em cada controle: a Parte 2 desta migracao ainda vai
    * acrescentar Fornecedor/Promocao/flags/chkAuditado, que este metodo NAO
    * referencia (o Opt_Tipo legado nao alterna esses campos) - os guards
    * aqui protegem apenas contra a ordem de chamada dentro do Init, nao
    * substituem os campos que faltam.
    *==========================================================================
    PROCEDURE OptTipoInteractiveChange()
        LOCAL loc_nTipo, loc_lVisivelVariacao, loc_lVisivelMarkUp

        IF !PEMSTATUS(THIS, "opt_4c_Tipo", 5)
            RETURN
        ENDIF
        loc_nTipo = THIS.opt_4c_Tipo.Value

        loc_lVisivelVariacao = (loc_nTipo = 1)
        loc_lVisivelMarkUp   = (loc_nTipo = 2)

        IF PEMSTATUS(THIS, "lbl_4c_Variacao", 5)
            THIS.lbl_4c_Variacao.Visible = loc_lVisivelVariacao
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_Variacao", 5)
            THIS.txt_4c_Variacao.Visible = loc_lVisivelVariacao
        ENDIF
        IF PEMSTATUS(THIS, "lbl_4c_Percentual", 5)
            THIS.lbl_4c_Percentual.Visible = loc_lVisivelVariacao
        ENDIF
        IF PEMSTATUS(THIS, "chk_4c_IncCusts", 5)
            THIS.chk_4c_IncCusts.Visible = loc_lVisivelVariacao
        ENDIF

        IF PEMSTATUS(THIS, "lbl_4c_Moeda", 5)
            THIS.lbl_4c_Moeda.Visible = loc_lVisivelMarkUp
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_Moeda", 5)
            THIS.txt_4c_Moeda.Visible = loc_lVisivelMarkUp
        ENDIF
        IF PEMSTATUS(THIS, "lbl_4c_MarkUp", 5)
            THIS.lbl_4c_MarkUp.Visible = loc_lVisivelMarkUp
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_MarkUp1", 5)
            THIS.txt_4c_MarkUp1.Visible = loc_lVisivelMarkUp
        ENDIF
        IF PEMSTATUS(THIS, "lbl_4c_Para", 5)
            THIS.lbl_4c_Para.Visible = loc_lVisivelMarkUp
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_MarkUp2", 5)
            THIS.txt_4c_MarkUp2.Visible = loc_lVisivelMarkUp
        ENDIF
        IF PEMSTATUS(THIS, "lbl_4c_FatorCusto", 5)
            THIS.lbl_4c_FatorCusto.Visible = loc_lVisivelMarkUp
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_Fator", 5)
            THIS.txt_4c_Fator.Visible = loc_lVisivelMarkUp
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_MoeCusto", 5)
            THIS.txt_4c_MoeCusto.Visible = loc_lVisivelMarkUp
        ENDIF

        IF PEMSTATUS(THIS, "lbl_4c_MoedaCusCompo", 5)
            THIS.lbl_4c_MoedaCusCompo.Visible = loc_lVisivelMarkUp
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_MoeCs", 5)
            THIS.txt_4c_MoeCs.Visible = loc_lVisivelMarkUp
        ENDIF
        IF PEMSTATUS(THIS, "lbl_4c_MoedaCusTotal", 5)
            THIS.lbl_4c_MoedaCusTotal.Visible = loc_lVisivelMarkUp
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_MoeCusFs", 5)
            THIS.txt_4c_MoeCusFs.Visible = loc_lVisivelMarkUp
        ENDIF
        IF PEMSTATUS(THIS, "lbl_4c_Feitio", 5)
            THIS.lbl_4c_Feitio.Visible = loc_lVisivelMarkUp
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_CFtios", 5)
            THIS.txt_4c_CFtios.Visible = loc_lVisivelMarkUp
        ENDIF
        IF PEMSTATUS(THIS, "lbl_4c_MoedaPrecoIdeal", 5)
            THIS.lbl_4c_MoedaPrecoIdeal.Visible = loc_lVisivelMarkUp
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_Moedas", 5)
            THIS.txt_4c_Moedas.Visible = loc_lVisivelMarkUp
        ENDIF
        IF PEMSTATUS(THIS, "lbl_4c_MoedaPrecoAtual", 5)
            THIS.lbl_4c_MoedaPrecoAtual.Visible = loc_lVisivelMarkUp
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_MoeVs", 5)
            THIS.txt_4c_MoeVs.Visible = loc_lVisivelMarkUp
        ENDIF

        THIS.Refresh()
    ENDPROC

    *==========================================================================
    * TxtVariacaoLostFocus - Equivalente ao LostFocus do Get_Variacao legado
    * (ThisForm.Sair.Processa.SetFocus) - so navegacao de foco, sem SQL, entao
    * nao esbarra na regra de nao usar LostFocus para carregar dados.
    *==========================================================================
    PROCEDURE TxtVariacaoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        IF PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
            THIS.cmg_4c_Botoes.Buttons(1).SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * ExisteCodigoNaTabela - Helper generico usado pelos KeyPress de lookup
    * (Enter/Tab): confere existencia EXATA de par_cValor em par_cCampoCod de
    * par_cTabela, sem abrir o picker.
    *==========================================================================
    PROTECTED FUNCTION ExisteCodigoNaTabela(par_cTabela, par_cCampoCod, par_cValor)
        LOCAL loc_cCursor, loc_lAchou, loc_oErro
        loc_cCursor = "cursor_4c_LkpExiste"
        loc_lAchou  = .F.

        TRY
            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF
            IF SQLEXEC(gnConnHandle, "SELECT " + par_cCampoCod + " FROM " + par_cTabela + ;
                    " WHERE " + par_cCampoCod + " = " + EscaparSQL(par_cValor), loc_cCursor) > 0 AND ;
               USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
                loc_lAchou = .T.
            ENDIF
            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormSigPrApr.ExisteCodigoNaTabela")
        ENDTRY

        RETURN loc_lAchou
    ENDFUNC

    *==========================================================================
    * ValidarECompletarMoeda - Helper compartilhado pelos 6 campos de moeda
    * (Get_Moeda/Get_Moecs/Get_MoeCusFs/Get_Moedas/Get_MoeVs/get_moeCusto),
    * todos fwbuscaext contra SigCdMoe/CMoes/DMoes no legado.
    *==========================================================================
    PROTECTED PROCEDURE ValidarECompletarMoeda(par_oTxt)
        LOCAL loc_cValor
        loc_cValor = ALLTRIM(NVL(par_oTxt.Value, ""))

        IF EMPTY(loc_cValor) OR THIS.ExisteCodigoNaTabela("SigCdMoe", "CMoes", loc_cValor)
            RETURN
        ENDIF

        THIS.AbrirLookupCanonico("SigCdMoe", "CMoes", "DMoes", "Moedas", loc_cValor, par_oTxt, .NULL.)
    ENDPROC

    *==========================================================================
    * TxtCdGrupoKeyPress - Equivalente ao Valid do Get_Cd_Grupo legado
    * (fwbuscaext contra SigCdGrp). Preserva o auto-preenchimento de
    * Get_ate_Grupo quando ele ainda esta vazio (legado: "If Empty(This.
    * Parent.Get_ate_Grupo.Value) / This.Parent.Get_ate_Grupo.Value = this.
    * Value").
    *==========================================================================
    PROCEDURE TxtCdGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor

        IF !INLIST(par_nKeyCode, 13, 9, 115)
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(NVL(THIS.txt_4c_CdGrupo.Value, ""))
        IF par_nKeyCode != 115 AND (EMPTY(loc_cValor) OR THIS.ExisteCodigoNaTabela("SigCdGrp", "CGrus", loc_cValor))
            IF !EMPTY(loc_cValor) AND EMPTY(ALLTRIM(NVL(THIS.txt_4c_AteGrupo.Value, "")))
                THIS.txt_4c_AteGrupo.Value = THIS.txt_4c_CdGrupo.Value
            ENDIF
            RETURN
        ENDIF

        THIS.AbrirLookupCanonico("SigCdGrp", "CGrus", "DGrus", "Grupos de Produto", loc_cValor, THIS.txt_4c_CdGrupo, .NULL.)
        IF EMPTY(ALLTRIM(NVL(THIS.txt_4c_AteGrupo.Value, "")))
            THIS.txt_4c_AteGrupo.Value = THIS.txt_4c_CdGrupo.Value
        ENDIF
    ENDPROC

    *==========================================================================
    * TxtAteGrupoKeyPress - Equivalente ao Get_ate_Grupo legado (mesma tabela
    * de Get_Cd_Grupo, sem o auto-preenchimento).
    *==========================================================================
    PROCEDURE TxtAteGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor

        IF !INLIST(par_nKeyCode, 13, 9, 115)
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(NVL(THIS.txt_4c_AteGrupo.Value, ""))
        IF par_nKeyCode != 115 AND (EMPTY(loc_cValor) OR THIS.ExisteCodigoNaTabela("SigCdGrp", "CGrus", loc_cValor))
            RETURN
        ENDIF

        THIS.AbrirLookupCanonico("SigCdGrp", "CGrus", "DGrus", "Grupos de Produto", loc_cValor, THIS.txt_4c_AteGrupo, .NULL.)
    ENDPROC

    *==========================================================================
    * TxtColecaoKeyPress - Equivalente ao Get_Col legado (fwbuscaext contra
    * SigCdCol/Colecoes/Descs).
    *==========================================================================
    PROCEDURE TxtColecaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor

        IF !INLIST(par_nKeyCode, 13, 9, 115)
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(NVL(THIS.txt_4c_Colecao.Value, ""))
        IF par_nKeyCode != 115 AND (EMPTY(loc_cValor) OR THIS.ExisteCodigoNaTabela("SigCdCol", "Colecoes", loc_cValor))
            RETURN
        ENDIF

        THIS.AbrirLookupCanonico("SigCdCol", "Colecoes", "Descs", "Cole" + CHR(231) + CHR(245) + "es", loc_cValor, THIS.txt_4c_Colecao, .NULL.)
    ENDPROC

    *==========================================================================
    * TxtCFtiosKeyPress - Equivalente ao Get_CFtios legado (fwbuscaext contra
    * SigPrFti/Cods/Descs).
    *==========================================================================
    PROCEDURE TxtCFtiosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor

        IF !INLIST(par_nKeyCode, 13, 9, 115)
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(NVL(THIS.txt_4c_CFtios.Value, ""))
        IF par_nKeyCode != 115 AND (EMPTY(loc_cValor) OR THIS.ExisteCodigoNaTabela("SigPrFti", "Cods", loc_cValor))
            RETURN
        ENDIF

        THIS.AbrirLookupCanonico("SigPrFti", "Cods", "Descs", "Feitio", loc_cValor, THIS.txt_4c_CFtios, .NULL.)
    ENDPROC

    *==========================================================================
    * TxtMoedaKeyPress / TxtMoeCustoKeyPress / TxtMoeCsKeyPress /
    * TxtMoeCusFsKeyPress / TxtMoedasKeyPress / TxtMoeVsKeyPress - os 6 campos
    * de moeda (Get_Moeda/get_moeCusto/Get_Moecs/Get_MoeCusFs/Get_Moedas/
    * Get_MoeVs), todos delegando para ValidarECompletarMoeda.
    *==========================================================================
    PROCEDURE TxtMoedaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF !INLIST(par_nKeyCode, 13, 9, 115)
            RETURN
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupCanonico("SigCdMoe", "CMoes", "DMoes", "Moedas", ALLTRIM(NVL(THIS.txt_4c_Moeda.Value, "")), THIS.txt_4c_Moeda, .NULL.)
            RETURN
        ENDIF
        THIS.ValidarECompletarMoeda(THIS.txt_4c_Moeda)
    ENDPROC

    PROCEDURE TxtMoeCustoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF !INLIST(par_nKeyCode, 13, 9, 115)
            RETURN
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupCanonico("SigCdMoe", "CMoes", "DMoes", "Moedas", ALLTRIM(NVL(THIS.txt_4c_MoeCusto.Value, "")), THIS.txt_4c_MoeCusto, .NULL.)
            RETURN
        ENDIF
        THIS.ValidarECompletarMoeda(THIS.txt_4c_MoeCusto)
    ENDPROC

    PROCEDURE TxtMoeCsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF !INLIST(par_nKeyCode, 13, 9, 115)
            RETURN
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupCanonico("SigCdMoe", "CMoes", "DMoes", "Moedas", ALLTRIM(NVL(THIS.txt_4c_MoeCs.Value, "")), THIS.txt_4c_MoeCs, .NULL.)
            RETURN
        ENDIF
        THIS.ValidarECompletarMoeda(THIS.txt_4c_MoeCs)
    ENDPROC

    PROCEDURE TxtMoeCusFsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF !INLIST(par_nKeyCode, 13, 9, 115)
            RETURN
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupCanonico("SigCdMoe", "CMoes", "DMoes", "Moedas", ALLTRIM(NVL(THIS.txt_4c_MoeCusFs.Value, "")), THIS.txt_4c_MoeCusFs, .NULL.)
            RETURN
        ENDIF
        THIS.ValidarECompletarMoeda(THIS.txt_4c_MoeCusFs)
    ENDPROC

    PROCEDURE TxtMoedasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF !INLIST(par_nKeyCode, 13, 9, 115)
            RETURN
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupCanonico("SigCdMoe", "CMoes", "DMoes", "Moedas", ALLTRIM(NVL(THIS.txt_4c_Moedas.Value, "")), THIS.txt_4c_Moedas, .NULL.)
            RETURN
        ENDIF
        THIS.ValidarECompletarMoeda(THIS.txt_4c_Moedas)
    ENDPROC

    PROCEDURE TxtMoeVsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF !INLIST(par_nKeyCode, 13, 9, 115)
            RETURN
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupCanonico("SigCdMoe", "CMoes", "DMoes", "Moedas", ALLTRIM(NVL(THIS.txt_4c_MoeVs.Value, "")), THIS.txt_4c_MoeVs, .NULL.)
            RETURN
        ENDIF
        THIS.ValidarECompletarMoeda(THIS.txt_4c_MoeVs)
    ENDPROC

    *==========================================================================
    * TxtContaKeyPress - Equivalente ao Valid do Get_Conta legado
    * (fAcessoContas(Usuar,Grupo,'C',...)). F4 sempre abre o lookup filtrado
    * pelo Grupo padrao de acesso a Contas (GrPadFors); Enter/Tab valida
    * existencia exata em SigCdCli e, se nao achar, abre o mesmo lookup.
    *==========================================================================
    PROCEDURE TxtContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor, loc_lAchou, loc_oErro

        IF !INLIST(par_nKeyCode, 13, 9, 115)
            RETURN
        ENDIF

        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupConta()
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(NVL(THIS.txt_4c_Conta.Value, ""))
        IF EMPTY(loc_cValor)
            THIS.txt_4c_DConta.Value = ""
            RETURN
        ENDIF

        loc_lAchou = .F.
        TRY
            IF USED("cursor_4c_LkpConta")
                USE IN cursor_4c_LkpConta
            ENDIF
            IF SQLEXEC(gnConnHandle, ;
                    "SELECT IClis, RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cValor) + ;
                    " AND Grupos = " + EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cGrPadFors)), ;
                    "cursor_4c_LkpConta") > 0 AND ;
               USED("cursor_4c_LkpConta") AND RECCOUNT("cursor_4c_LkpConta") > 0
                THIS.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_LkpConta.IClis)
                THIS.txt_4c_DConta.Value = ALLTRIM(cursor_4c_LkpConta.RClis)
                loc_lAchou = .T.
            ENDIF
            IF USED("cursor_4c_LkpConta")
                USE IN cursor_4c_LkpConta
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormSigPrApr.TxtContaKeyPress")
        ENDTRY

        IF !loc_lAchou
            THIS.AbrirLookupConta()
        ENDIF
    ENDPROC

    *==========================================================================
    * TxtDContaKeyPress - Equivalente ao Valid do Get_DConta legado
    * (fAcessoContas(Usuar,Grupo,'D',...)): busca por descricao, so quando o
    * codigo (Get_Conta) esta vazio (mesma condicao do When legado - "Return
    * (Empty(ThisForm.Get_Conta.Value))" - com codigo preenchido, o campo de
    * descricao eh so espelho e nao dispara consulta propria).
    *==========================================================================
    PROCEDURE TxtDContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF !INLIST(par_nKeyCode, 13, 9, 115)
            RETURN
        ENDIF

        IF !EMPTY(ALLTRIM(NVL(THIS.txt_4c_Conta.Value, "")))
            RETURN
        ENDIF

        THIS.AbrirLookupContaPorDescricao()
    ENDPROC

    *==========================================================================
    * AbrirLookupConta - Lookup de Fornecedor por codigo (SigCdCli.IClis/
    * RClis), restrito ao Grupo padrao de acesso a Contas (this_cGrPadFors).
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupConta()
        THIS.AbrirLookupCanonico("SigCdCli", "IClis", "RClis", ;
            "Sele" + CHR(231) + CHR(227) + "o de Fornecedor", ;
            ALLTRIM(NVL(THIS.txt_4c_Conta.Value, "")), ;
            THIS.txt_4c_Conta, THIS.txt_4c_DConta, ;
            "Grupos = " + EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cGrPadFors)))
    ENDPROC

    *==========================================================================
    * AbrirLookupContaPorDescricao - Mesmo lookup de Fornecedor, mas com o
    * prefixo digitado em Get_DConta (busca por Razao Social - modo 'D' do
    * fAcessoContas legado).
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupContaPorDescricao()
        THIS.AbrirLookupCanonico("SigCdCli", "IClis", "RClis", ;
            "Sele" + CHR(231) + CHR(227) + "o de Fornecedor", ;
            ALLTRIM(NVL(THIS.txt_4c_DConta.Value, "")), ;
            THIS.txt_4c_Conta, THIS.txt_4c_DConta, ;
            "Grupos = " + EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cGrPadFors)))
    ENDPROC

    *==========================================================================
    * TxtPromoKeyPress - Equivalente ao Valid do Get_Promo legado
    * (fwbuscaext contra SigPrPmc). F4 sempre abre o lookup; Enter/Tab valida
    * existencia exata e, se nao achar, abre o mesmo lookup. SigPrPmc.Promos
    * eh PK e descricao ao mesmo tempo (tabela single-column, igual a
    * SigCdOpe.Dopes - regra: nunca inventar segunda coluna de descricao).
    *==========================================================================
    PROCEDURE TxtPromoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor, loc_lAchou, loc_oErro

        IF !INLIST(par_nKeyCode, 13, 9, 115)
            RETURN
        ENDIF

        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupPromo()
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(NVL(THIS.txt_4c_Promo.Value, ""))
        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        loc_lAchou = .F.
        TRY
            IF USED("cursor_4c_LkpPromo")
                USE IN cursor_4c_LkpPromo
            ENDIF
            IF SQLEXEC(gnConnHandle, ;
                    "SELECT Promos FROM SigPrPmc WHERE Promos = " + EscaparSQL(loc_cValor), ;
                    "cursor_4c_LkpPromo") > 0 AND ;
               USED("cursor_4c_LkpPromo") AND RECCOUNT("cursor_4c_LkpPromo") > 0
                THIS.txt_4c_Promo.Value = ALLTRIM(cursor_4c_LkpPromo.Promos)
                loc_lAchou = .T.
            ENDIF
            IF USED("cursor_4c_LkpPromo")
                USE IN cursor_4c_LkpPromo
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormSigPrApr.TxtPromoKeyPress")
        ENDTRY

        IF !loc_lAchou
            THIS.AbrirLookupPromo()
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirLookupPromo - Lookup de Promocao (SigPrPmc.Promos - coluna unica)
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupPromo()
        THIS.AbrirLookupCanonico("SigPrPmc", "Promos", "Promos", ;
            "Promo" + CHR(231) + CHR(227) + "o", ;
            ALLTRIM(NVL(THIS.txt_4c_Promo.Value, "")), ;
            THIS.txt_4c_Promo, .NULL.)
    ENDPROC

    *==========================================================================
    * SincronizarFiltros - Copia os campos de filtro/reajuste (Parte 1 desta
    * migracao) para as propriedades this_ do BO, exatamente como o legado le
    * ThisForm.Get_Xxx.Value dentro do proprio Processa.Click. Chamado por
    * BtnProcessarClick ANTES de BuscarProdutos(). A Parte 2 (Fornecedor/
    * Promocao/flags/chkAuditado) sera acrescentada aqui quando esses campos
    * forem criados.
    *==========================================================================
    PROTECTED PROCEDURE SincronizarFiltros()
        LOCAL loc_oBO

        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) != "O"
            RETURN
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_CdGrupo", 5)
            loc_oBO.this_cCdGrupo = PADR(ALLTRIM(THIS.txt_4c_CdGrupo.Value), 3)
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_AteGrupo", 5)
            loc_oBO.this_cAteGrupo = PADR(ALLTRIM(THIS.txt_4c_AteGrupo.Value), 3)
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_Colecao", 5)
            loc_oBO.this_cColecao = PADR(ALLTRIM(THIS.txt_4c_Colecao.Value), 10)
        ENDIF
        IF PEMSTATUS(THIS, "opt_4c_Tipo", 5)
            loc_oBO.this_nTipo = THIS.opt_4c_Tipo.Value
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_Variacao", 5)
            loc_oBO.this_nVariacao = THIS.txt_4c_Variacao.Value
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_Moeda", 5)
            loc_oBO.this_cMoeda = PADR(ALLTRIM(THIS.txt_4c_Moeda.Value), 3)
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_MarkUp1", 5)
            loc_oBO.this_nMarkUp1 = THIS.txt_4c_MarkUp1.Value
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_MarkUp2", 5)
            loc_oBO.this_nMarkUp2 = THIS.txt_4c_MarkUp2.Value
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_Fator", 5)
            loc_oBO.this_nFator = THIS.txt_4c_Fator.Value
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_MoeCusto", 5)
            loc_oBO.this_cMoeCusto = PADR(ALLTRIM(THIS.txt_4c_MoeCusto.Value), 3)
        ENDIF
        IF PEMSTATUS(THIS, "chk_4c_IncCusts", 5)
            loc_oBO.this_lIncCusts = (THIS.chk_4c_IncCusts.Value = 1)
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_MoeCs", 5)
            loc_oBO.this_cMoeCs = PADR(ALLTRIM(THIS.txt_4c_MoeCs.Value), 3)
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_MoeCusFs", 5)
            loc_oBO.this_cMoeCusFs = PADR(ALLTRIM(THIS.txt_4c_MoeCusFs.Value), 3)
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_CFtios", 5)
            loc_oBO.this_cCFtios = PADR(ALLTRIM(THIS.txt_4c_CFtios.Value), 3)
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_Moedas", 5)
            loc_oBO.this_cMoedas = PADR(ALLTRIM(THIS.txt_4c_Moedas.Value), 3)
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_MoeVs", 5)
            loc_oBO.this_cMoeVs = PADR(ALLTRIM(THIS.txt_4c_MoeVs.Value), 3)
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_Conta", 5)
            loc_oBO.this_cConta = PADR(ALLTRIM(THIS.txt_4c_Conta.Value), 10)
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_DConta", 5)
            loc_oBO.this_cDConta = PADR(ALLTRIM(THIS.txt_4c_DConta.Value), 50)
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_Promo", 5)
            loc_oBO.this_cPromo = PADR(ALLTRIM(THIS.txt_4c_Promo.Value), 25)
        ENDIF
        IF PEMSTATUS(THIS, "chk_4c_Limpar", 5)
            loc_oBO.this_lLimparPromos = (THIS.chk_4c_Limpar.Value = 1)
        ENDIF
        IF PEMSTATUS(THIS, "chk_4c_Ignorar", 5)
            loc_oBO.this_lIgnorar = (THIS.chk_4c_Ignorar.Value = 1)
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarGrid - Cria a grade de conferencia de produtos (SIGPRAPR.
    * Grd_Produto do legado, RecordSource="CrProdutos"). O cursor
    * cursor_4c_Produtos ja existe (vazio) neste ponto -
    * THIS.this_oBusinessObject.CriarCursorItens() roda dentro do Init do BO,
    * chamado ANTES deste metodo - sem isso o RecordSource travaria o Init
    * (regra do cursor que ainda nao existe).
    *
    * Colunas na ordem do legado (ColumnCount=5): Marca (lMarca, CheckBox,
    * toggle-all no Header1.Click) / Produto (CPros, somente leitura nesta
    * fase - a digitacao manual do codigo via lookup fwbuscaext chega junto
    * com o modo "Produtos"/chkAuditado em fase posterior) / Descricao
    * (DPros, sempre somente leitura no legado - When -> .F.) / Preco
    * Anterior (ValAnt, sempre somente leitura) / Preco Atual (ValAtu,
    * editavel SO com a permissao fChecaAcesso('SIGPRAPR','VMANUAL') -
    * this_lLibValAtu, ja copiada do BO em InicializarForm).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_oGrid, loc_cCursor

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorItens

        THIS.AddObject("grd_4c_Produtos", "Grid")
        loc_oGrid = THIS.grd_4c_Produtos
        loc_oGrid.ColumnCount  = 5
        loc_oGrid.RecordSource = loc_cCursor
        WITH loc_oGrid
            .Top          = 307
            .Left         = 31
            .Width        = 725
            .Height       = 247
            .FontName     = "Verdana"
            .FontSize     = 8
            .HeaderHeight = 20
            .RowHeight    = 16
            .ScrollBars   = 2
            .DeleteMark   = .F.
            .RecordMark   = .F.

            *-- Column1: Marca (lMarca) - CheckBox (regra #18: Column.AddObject
            *-- exige CurrentControl, senao a coluna continua desenhando o Text1)
            .Column1.ControlSource = loc_cCursor + ".lMarca"
            .Column1.Width         = 20
            .Column1.Alignment     = 3
            .Column1.Movable       = .F.
            .Column1.Resizable     = .F.
            .Column1.Sparse        = .F.
            .Column1.ReadOnly      = .F.
        ENDWITH

        loc_oGrid.Column1.AddObject("Check1", "CheckBox")
        WITH loc_oGrid.Column1.Check1
            .Caption  = ""
            .AutoSize = .T.
            .Visible  = .T.
        ENDWITH
        loc_oGrid.Column1.CurrentControl   = "Check1"
        loc_oGrid.Column1.Header1.Caption   = ""
        loc_oGrid.Column1.Header1.Alignment = 2
        loc_oGrid.Column1.Header1.Picture   = gc_4c_CaminhoIcones + "checkbx.bmp"
        *-- Legado: this.cOLUMN1.header1.Tag = '1' (Grd_Produto.Init) - primeiro
        *-- clique no header DESMARCA tudo, pois Processar ja insere marcado
        loc_oGrid.Column1.Header1.Tag = "1"

        WITH loc_oGrid
            *-- Column2: Produto (CPros)
            .Column2.ControlSource   = loc_cCursor + ".CPros"
            .Column2.Width           = 108
            .Column2.ReadOnly        = .T.
            .Column2.Movable         = .F.
            .Column2.Resizable       = .F.
            .Column2.Header1.Caption = "Produto"

            *-- Column3: Descricao (DPros) - legado: When -> .F. (sempre readonly)
            .Column3.ControlSource   = loc_cCursor + ".DPros"
            .Column3.Width           = 350
            .Column3.ReadOnly        = .T.
            .Column3.Movable         = .F.
            .Column3.Resizable       = .F.
            .Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

            *-- Column4: Preco Anterior (ValAnt) - legado: When -> .F.
            .Column4.ControlSource   = loc_cCursor + ".ValAnt"
            .Column4.Width           = 100
            .Column4.InputMask       = "999,999,999.99"
            .Column4.ReadOnly        = .T.
            .Column4.Movable         = .F.
            .Column4.Resizable       = .F.
            .Column4.Header1.Caption = "Pre" + CHR(231) + "o Anterior"

            *-- Column5: Preco Atual (ValAtu) - editavel so com this_lLibValAtu
            *-- (legado: Column5.Text1.ReadOnly = Not ThisForm.LibValAtu +
            *-- Header1.Picture = lock.bmp quando sem permissao)
            .Column5.ControlSource   = loc_cCursor + ".ValAtu"
            .Column5.Width           = 111
            .Column5.InputMask       = "999,999,999.99"
            .Column5.ReadOnly        = !THIS.this_lLibValAtu
            .Column5.Movable         = .F.
            .Column5.Resizable       = .F.
            .Column5.Header1.Caption = "Pre" + CHR(231) + "o Atual"
            .Column5.Header1.Picture = IIF(THIS.this_lLibValAtu, "", gc_4c_CaminhoIcones + "lock.bmp")
        ENDWITH

        *-- Legado: Column1.Header1.Click (toggle marcar/desmarcar todos)
        BINDEVENT(loc_oGrid.Column1.Header1, "Click", THIS, "GridHeaderMarcaClick")
        *-- Legado: Column1.Check1.When -> Return(!Empty(CrProdutos.CPros)) -
        *-- impede marcar a linha em branco que o modo "Produtos" mantem no
        *-- fim da grade enquanto o codigo ainda nao foi digitado
        BINDEVENT(loc_oGrid.Column1.Check1, "When", THIS, "Column1CheckWhen")
        *-- Legado: Column5.Text1.Valid (marca Manual=1 quando o usuario altera
        *-- o Preco Atual manualmente na grade, e insere a proxima linha em
        *-- branco do modo "Produtos" quando aplicavel)
        BINDEVENT(loc_oGrid.Column5.Text1,   "Valid", THIS, "ColValAtuValid")
        *-- Legado: Column2.Text1.When (guarda o valor ANTES do foco, para
        *-- LostFocus saber se o codigo mudou) / Valid (lookup fwbuscaext
        *-- contra SigCdPro) / LostFocus (calcula o preco do produto digitado
        *-- manualmente - modo "Produtos")
        BINDEVENT(loc_oGrid.Column2.Text1, "GotFocus",  THIS, "Column2GotFocus")
        BINDEVENT(loc_oGrid.Column2.Text1, "Valid",     THIS, "Column2Valid")
        BINDEVENT(loc_oGrid.Column2.Text1, "KeyPress", THIS, "Column2LostFocus")
        *-- Legado: Grd_Produto.AfterRowColChange - carrega a foto do produto
        *-- da linha corrente (regra #3: precisa declarar par_nColIndex)
        BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GridAfterRowColChange")
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Cria o grupo Processar/Encerrar/Atualizar (SIGPRAPR.
    * sair do legado). Top=-2/Left=770 posiciona o grupo flutuando SOBRE a
    * faixa do cabecalho (cnt_4c_Sombra, Top=0..80, ja criado ANTES deste
    * metodo por ConfigurarPageFrame - regra da faixa ser o PRIMEIRO
    * AddObject da tela).
    *
    * Numeracao dos botoes IDENTICA ao legado (Command1=Processa/Buttons(1),
    * Command2=Cancela/Buttons(2), Command3=Atualiza/Buttons(3)) - a ordem
    * VISUAL (Left) difere da ordem de CRIACAO, exatamente como no SCX.
    * Atualizar comeca desabilitado (legado: Init faz
    * ThisForm.Sair.Atualiza.Enabled = .F.) - so liga apos Processar bem
    * sucedido (BtnProcessarClick) e desliga de novo ao fim de todo clique em
    * Atualizar, haja ou nao confirmado a gravacao (BtnAtualizarClick).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_oGrp

        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        loc_oGrp = THIS.cmg_4c_Botoes
        WITH loc_oGrp
            .Top           = -2
            .Left          = 770
            .Width         = 235
            .Height        = 85
            .ButtonCount   = 3
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .Themes        = .F.

            WITH .Buttons(1)
                .Top        = 5
                .Left       = 5
                .Width      = 75
                .Height     = 75
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .T.
                .Picture    = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
                .Caption    = "\<Processar"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
            ENDWITH

            WITH .Buttons(2)
                .Top        = 5
                .Left       = 155
                .Width      = 75
                .Height     = 75
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .T.
                .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel     = .T.
                .Caption    = "Encerrar"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
            ENDWITH

            WITH .Buttons(3)
                .Top        = 5
                .Left       = 80
                .Width      = 75
                .Height     = 75
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .T.
                .Picture    = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .Caption    = "\<Atualizar"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
                .Enabled    = .F.
                .WordWrap        = .T.
            ENDWITH
        ENDWITH

        BINDEVENT(loc_oGrp.Buttons(1), "Click", THIS, "BtnProcessarClick")
        BINDEVENT(loc_oGrp.Buttons(2), "Click", THIS, "BtnEncerrarClick")
        BINDEVENT(loc_oGrp.Buttons(3), "Click", THIS, "BtnAtualizarClick")
    ENDPROC

    *==========================================================================
    * CarregarLista - Reexibe a grade de conferencia apos popular/esvaziar o
    * cursor de trabalho (regra: popular cursor NAO repinta a grade sozinho -
    * legado: Select CrProdutos / Go Top / ThisForm.Grd_Produto.Refresh).
    * PUBLIC de proposito: TesteAutomatico.prg chama metodos de carga direto
    * no oForm, e metodo PROTECTED falha em runtime mesmo passando no PEMSTATUS.
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_oBO, loc_cCursor

        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) = "O"
            loc_cCursor = loc_oBO.this_cCursorItens
            IF USED(loc_cCursor)
                SELECT (loc_cCursor)
                GO TOP
            ENDIF
        ENDIF

        IF PEMSTATUS(THIS, "grd_4c_Produtos", 5)
            THIS.grd_4c_Produtos.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * GridHeaderMarcaClick - Transcreve o PROCEDURE Click do Column1.Header1
    * legado (marca/desmarca todos os produtos da grade de uma vez).
    *==========================================================================
    PROCEDURE GridHeaderMarcaClick()
        LOCAL loc_oBO, loc_cCursor

        IF !PEMSTATUS(THIS, "grd_4c_Produtos", 5)
            RETURN
        ENDIF
        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) != "O"
            RETURN
        ENDIF

        loc_cCursor = loc_oBO.this_cCursorItens
        IF !USED(loc_cCursor)
            RETURN
        ENDIF

        IF THIS.grd_4c_Produtos.Column1.Header1.Tag = "0"
            UPDATE (loc_cCursor) SET lMarca = 1
            THIS.grd_4c_Produtos.Column1.Header1.Tag = "1"
        ELSE
            UPDATE (loc_cCursor) SET lMarca = 0
            THIS.grd_4c_Produtos.Column1.Header1.Tag = "0"
        ENDIF

        THIS.grd_4c_Produtos.Refresh()
    ENDPROC

    *==========================================================================
    * ColValAtuValid - Transcreve o PROCEDURE Valid do Column5.Text1 legado:
    * marca Manual=1 no cursor quando o usuario altera manualmente o Preco
    * Atual (a insercao de linha em branco no fim, que o legado faz junto
    * disso para o modo de digitacao manual de produto, fica para quando o
    * modo "Produtos"/chkAuditado for wireado, em fase posterior).
    *==========================================================================
    PROCEDURE ColValAtuValid()
        LOCAL loc_oBO, loc_cCursor, loc_nValorNovo, loc_nValorAtual, loc_lAlterado

        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) != "O" OR !PEMSTATUS(THIS, "grd_4c_Produtos", 5)
            RETURN .T.
        ENDIF

        loc_cCursor   = loc_oBO.this_cCursorItens
        loc_lAlterado = .F.
        IF USED(loc_cCursor) AND !EOF(loc_cCursor)
            loc_nValorNovo = THIS.grd_4c_Produtos.Column5.Text1.Value
            SELECT (loc_cCursor)
            loc_nValorAtual = ValAtu
            loc_lAlterado   = (loc_nValorAtual <> loc_nValorNovo)
            IF loc_oBO.this_lLibValAtu AND loc_lAlterado
                REPLACE Manual WITH 1 IN (loc_cCursor)
            ENDIF

            *-- Legado (modo "Produtos"): "If This.Value <> ThisForm.AntValue Or
            *-- Lastkey() = 13" - ao confirmar o Preco Atual de uma linha recem
            *-- preenchida manualmente, insere OUTRA linha em branco no fim e
            *-- desce o cursor para ela (o guard !Empty(CPros) evita duplicar a
            *-- linha em branco quando o usuario so passa pela coluna sem
            *-- preencher produto nenhum)
            IF loc_oBO.this_lAuditado AND (loc_lAlterado OR LASTKEY() = 13)
                SELECT (loc_cCursor)
                IF !EMPTY(ALLTRIM(NVL(CPros, "")))
                    INSERT INTO (loc_cCursor) (lMarca, CPros, DPros, ValAnt, ValAtu) VALUES (0, SPACE(14), SPACE(40), 0, 0)
                ENDIF
                THIS.grd_4c_Produtos.Refresh()
                KEYBOARD "{DNARROW}"
            ENDIF
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * Column1CheckWhen - Equivalente ao When do Column1.Check1 legado: impede
    * marcar (Space no Check1) a linha em branco que o modo "Produtos" deixa
    * no fim da grade enquanto o Produto ainda nao foi digitado.
    *==========================================================================
    PROCEDURE Column1CheckWhen()
        LOCAL loc_oBO, loc_cCursor

        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) != "O"
            RETURN .T.
        ENDIF

        loc_cCursor = loc_oBO.this_cCursorItens
        IF !USED(loc_cCursor)
            RETURN .T.
        ENDIF

        RETURN !EMPTY(ALLTRIM(NVL(EVALUATE(loc_cCursor + ".CPros"), "")))
    ENDPROC

    *==========================================================================
    * Column2GotFocus - Equivalente ao When do Column2.Text1 legado ("ThisForm.
    * Antvalue = This.Value"): guarda o valor ANTES da edicao em
    * this_cAntValue, para Column2LostFocus saber se o codigo mudou (mesmo
    * papel de ThisForm.AntValue no legado, sem precisar de BINDEVENT em
    * "When" para este controle - a captura acontece ao GANHAR foco, e a
    * comparacao acontece ao PERDER foco).
    *==========================================================================
    PROCEDURE Column2GotFocus()
        IF PEMSTATUS(THIS, "grd_4c_Produtos", 5)
            THIS.this_cAntValue = ALLTRIM(NVL(THIS.grd_4c_Produtos.Column2.Text1.Value, ""))
        ENDIF
    ENDPROC

    *==========================================================================
    * Column2Valid - Equivalente ao Valid do Column2.Text1 legado: lookup
    * fwbuscaext contra SigCdPro/CPros/DPros (modo "Produtos" - digitacao
    * manual do codigo do produto na propria celula da grade).
    *==========================================================================
    PROCEDURE Column2Valid()
        LOCAL loc_oGrid, loc_cValor, loc_lAchou, loc_oErro

        IF !PEMSTATUS(THIS, "grd_4c_Produtos", 5)
            RETURN .T.
        ENDIF
        loc_oGrid  = THIS.grd_4c_Produtos
        loc_cValor = ALLTRIM(NVL(loc_oGrid.Column2.Text1.Value, ""))

        IF !EMPTY(loc_cValor)
            loc_lAchou = .F.
            TRY
                IF USED("cursor_4c_LkpProdutoManual")
                    USE IN cursor_4c_LkpProdutoManual
                ENDIF
                IF SQLEXEC(gnConnHandle, "SELECT CPros FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cValor), ;
                        "cursor_4c_LkpProdutoManual") > 0 AND ;
                   USED("cursor_4c_LkpProdutoManual") AND RECCOUNT("cursor_4c_LkpProdutoManual") > 0
                    loc_lAchou = .T.
                ENDIF
                IF USED("cursor_4c_LkpProdutoManual")
                    USE IN cursor_4c_LkpProdutoManual
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "FormSigPrApr.Column2Valid")
            ENDTRY

            IF !loc_lAchou
                THIS.AbrirLookupCanonico("SigCdPro", "CPros", "DPros", "Produtos", loc_cValor, loc_oGrid.Column2.Text1, .NULL.)
            ENDIF
        ENDIF

        loc_oGrid.Refresh()
        RETURN .T.
    ENDPROC

    *==========================================================================
    * Column2LostFocus - Equivalente ao LostFocus do Column2.Text1 legado:
    * confirmado o codigo do produto (modo "Produtos"), pede ao BO
    * (ProcessarProdutoManual) para calcular o novo preco conforme
    * this_nTipo/this_nVariacao/this_nMarkUp2 (mesmo criterio de
    * BuscarProdutos, aqui para um UNICO produto digitado manualmente) e
    * gravar a linha; este metodo so cuida da parte de UI (refresh, avanco
    * para a proxima linha em branco, habilitar Atualizar).
    *==========================================================================
    PROCEDURE Column2LostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oBO, loc_oGrid, loc_cCursor, loc_cValor

        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) != "O" OR !PEMSTATUS(THIS, "grd_4c_Produtos", 5)
            RETURN
        ENDIF
        loc_oGrid   = THIS.grd_4c_Produtos
        loc_cCursor = loc_oBO.this_cCursorItens
        loc_cValor  = ALLTRIM(NVL(loc_oGrid.Column2.Text1.Value, ""))

        IF EMPTY(loc_cValor) OR loc_cValor == ALLTRIM(NVL(THIS.this_cAntValue, ""))
            RETURN
        ENDIF

        THIS.SincronizarFiltros()

        IF loc_oBO.ProcessarProdutoManual(loc_cValor)
            IF PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
                THIS.cmg_4c_Botoes.Buttons(3).Enabled = .T.
            ENDIF

            *-- Legado: sem permissao de editar o Preco Atual (Column5
            *-- ficaria travada), insere OUTRA linha em branco e desce
            *-- direto para ela; COM permissao, deixa o tab natural levar
            *-- para Column5 (o insert/desce fica por conta do
            *-- ColValAtuValid nesse caso, ao confirmar o preco)
            IF !loc_oBO.this_lLibValAtu AND USED(loc_cCursor)
                SELECT (loc_cCursor)
                IF !EMPTY(ALLTRIM(NVL(CPros, "")))
                    INSERT INTO (loc_cCursor) (lMarca, CPros, DPros, ValAnt, ValAtu) VALUES (0, SPACE(14), SPACE(40), 0, 0)
                ENDIF
                loc_oGrid.Refresh()
                KEYBOARD "{DNARROW}"
            ELSE
                loc_oGrid.Refresh()
            ENDIF
        ELSE
            MsgAviso("Produto n" + CHR(227) + "o encontrado" + CHR(33) + CHR(33) + CHR(33) + CHR(13) + ;
                "Reinicie o processo.", "Aten" + CHR(231) + CHR(227) + "o")
        ENDIF
    ENDPROC

    *==========================================================================
    * GridAfterRowColChange - Equivalente ao AfterRowColChange do Grd_Produto
    * legado: carrega a foto do produto (SigCdPro.FigJpgs, base64) da linha
    * corrente em img_4c_FigJpg. STRCONV(...,14) UMA UNICA VEZ - decodifica
    * base64 -> binario JPEG; um segundo STRCONV sobre o binario ja
    * decodificado corrompe a imagem (feedback_strconv_double_decode_imagem).
    *==========================================================================
    PROCEDURE GridAfterRowColChange(par_nColIndex)
        LOCAL loc_oBO, loc_cCursor, loc_cCpros, loc_cArqFig, loc_oErro

        IF !PEMSTATUS(THIS, "img_4c_FigJpg", 5) OR !PEMSTATUS(THIS, "grd_4c_Produtos", 5)
            RETURN
        ENDIF
        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) != "O"
            RETURN
        ENDIF

        loc_cCursor = loc_oBO.this_cCursorItens
        THIS.img_4c_FigJpg.Visible = .F.
        THIS.img_4c_FigJpg.Picture = ""

        IF !USED(loc_cCursor) OR EOF(loc_cCursor)
            RETURN
        ENDIF

        loc_cCpros = ALLTRIM(NVL(EVALUATE(loc_cCursor + ".CPros"), ""))
        IF EMPTY(loc_cCpros)
            RETURN
        ENDIF

        TRY
            IF USED("cursor_4c_FotoProduto")
                USE IN cursor_4c_FotoProduto
            ENDIF
            SQLEXEC(gnConnHandle, "SELECT FigJpgs FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCpros), "cursor_4c_FotoProduto")

            IF USED("cursor_4c_FotoProduto") AND !EOF("cursor_4c_FotoProduto") AND ;
               !ISNULL(cursor_4c_FotoProduto.FigJpgs) AND !EMPTY(cursor_4c_FotoProduto.FigJpgs)
                loc_cArqFig = SYS(2023) + "\" + SYS(2015) + ".jpg"
                STRTOFILE(STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_FotoProduto.FigJpgs, ;
                    "data:image/png;base64,", ""), "data:image/jpeg;base64,", ""), "data:image/jpg;base64,", ""), 14), ;
                    loc_cArqFig)
                THIS.img_4c_FigJpg.Picture = loc_cArqFig
                THIS.img_4c_FigJpg.Visible = .T.
            ENDIF

            IF USED("cursor_4c_FotoProduto")
                USE IN cursor_4c_FotoProduto
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormSigPrApr.GridAfterRowColChange")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarModoProdutos - Cria os controles do modo "Produtos" (SIGPRAPR.
    * chkAuditado/Shp_foto/FigJpg do legado): botao-checkbox que alterna a
    * grade para inclusao manual de um item (fora do filtro Grupo/Colecao/
    * Fornecedor) e a moldura/imagem que exibe a foto do produto corrente.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarModoProdutos()
        THIS.AddObject("shp_4c_Foto", "Shape")
        WITH THIS.shp_4c_Foto
            .Top           = 414
            .Left          = 763
            .Width         = 205
            .Height        = 140
            .BackStyle     = 0
            .BorderStyle   = 1
            .FillStyle     = 1
            .SpecialEffect = 1
            .BorderColor   = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("img_4c_FigJpg", "Image")
        WITH THIS.img_4c_FigJpg
            .Top     = 415
            .Left    = 764
            .Width   = 203
            .Height  = 138
            .Stretch = 1
            .Visible = .F.
        ENDWITH

        THIS.AddObject("chk_4c_Auditado", "CheckBox")
        WITH THIS.chk_4c_Auditado
            .Top        = 307
            .Left       = 763
            .Width      = 75
            .Height     = 75
            .Style      = 1
            .Alignment  = 0
            .FontName   = "Comic Sans MS"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .Picture    = gc_4c_CaminhoIcones + "geral_produtos_60.jpg"
            .Caption    = "Pro\<dutos"
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes     = .F.
            .Value      = 0
        ENDWITH
        BINDEVENT(THIS.chk_4c_Auditado, "Click", THIS, "ChkAuditadoClick")
    ENDPROC

    *==========================================================================
    * ChkAuditadoClick - Transcreve o PROCEDURE Click do chkAuditado legado:
    * alterna a grade entre o modo normal (produtos filtrados por Processar)
    * e o modo "Produtos" (inclusao manual de UM item, digitado direto na
    * grade). Ligar o modo desabilita os filtros e a Column1/libera a
    * Column2; desligar devolve o estado normal e remove a linha em branco
    * corrente (legado: "Delete From CrProdutos" sem escopo = so o registro
    * ATUAL, que SET DELETED ON global esconde sem precisar de PACK).
    *==========================================================================
    PROCEDURE ChkAuditadoClick()
        LOCAL loc_oBO, loc_cCursor, loc_oGrid

        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) != "O" OR !PEMSTATUS(THIS, "grd_4c_Produtos", 5)
            RETURN
        ENDIF
        loc_cCursor = loc_oBO.this_cCursorItens
        loc_oGrid   = THIS.grd_4c_Produtos

        loc_oBO.this_lAuditado = (THIS.chk_4c_Auditado.Value = 1)

        IF loc_oBO.this_lAuditado
            IF USED(loc_cCursor)
                INSERT INTO (loc_cCursor) (lMarca, CPros, DPros, ValAnt, ValAtu) VALUES (0, SPACE(14), SPACE(40), 0, 0)
                SELECT (loc_cCursor)
                SET ORDER TO
                GO TOP
            ENDIF
            THIS.txt_4c_CdGrupo.Enabled  = .F.
            THIS.txt_4c_AteGrupo.Enabled = .F.
            THIS.txt_4c_Colecao.Enabled  = .F.
            THIS.txt_4c_Moeda.Enabled    = .F.
            THIS.txt_4c_MarkUp1.Enabled  = .F.
            IF PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
                THIS.cmg_4c_Botoes.Buttons(1).Enabled = .F.
            ENDIF
            loc_oGrid.Column1.Check1.ReadOnly = .T.
            loc_oGrid.Column2.Text1.ReadOnly  = .F.
            loc_oGrid.Refresh()
            loc_oGrid.Column2.Text1.SetFocus()
        ELSE
            IF USED(loc_cCursor)
                SELECT (loc_cCursor)
                DELETE
                SET ORDER TO CPros
                GO TOP
            ENDIF
            THIS.txt_4c_CdGrupo.Enabled  = .T.
            THIS.txt_4c_AteGrupo.Enabled = .T.
            THIS.txt_4c_Colecao.Enabled  = .T.
            THIS.txt_4c_Moeda.Enabled    = .T.
            THIS.txt_4c_MarkUp1.Enabled  = .T.
            IF PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
                THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.
            ENDIF
            loc_oGrid.Column1.Check1.ReadOnly = .F.
            loc_oGrid.Column2.Text1.ReadOnly  = .T.
            loc_oGrid.Refresh()
            THIS.txt_4c_CdGrupo.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnProcessarClick - Transcreve o PROCEDURE Processa.Click do legado: a
    * consulta/calculo ja esta implementada em
    * SigPrAprBO.BuscarProdutos() - este metodo aciona o BO e reflete o
    * resultado na tela (recarrega a grade, habilita Atualizar).
    *
    * this_cMensagemErro preenchido COM retorno .T. eh falha de VALIDACAO
    * (MsgAviso, igual ao MessageBox de icone 48 do legado); retorno .F. eh
    * falha TECNICA (MsgErro).
    *==========================================================================
    PROCEDURE BtnProcessarClick()
        LOCAL loc_oBO, loc_lSucesso

        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) != "O"
            RETURN
        ENDIF

        THIS.SincronizarFiltros()
        loc_lSucesso = loc_oBO.BuscarProdutos()

        IF loc_lSucesso
            IF !EMPTY(loc_oBO.this_cMensagemErro)
                MsgAviso(loc_oBO.this_cMensagemErro, "Campo Obrigat" + CHR(243) + "rio")
            ELSE
                THIS.CarregarLista()
                IF PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
                    THIS.cmg_4c_Botoes.Buttons(3).Enabled = .T.
                ENDIF
                IF PEMSTATUS(THIS, "grd_4c_Produtos", 5)
                    THIS.grd_4c_Produtos.SetFocus()
                ENDIF
            ENDIF
        ELSE
            MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel buscar os produtos." + CHR(13) + ;
                loc_oBO.this_cMensagemErro, "Erro em BtnProcessarClick")
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAtualizarClick - Transcreve o PROCEDURE Atualiza.Click do legado. A
    * parte de GRAVACAO (snapshot SigCdPrc + recalculo + UPDATE SigCdPro +
    * historico SigPrCp2 + limpeza SigPrPrt/SigPrPmi + vinculo de promocao,
    * tudo numa unica transacao) ja esta implementada em
    * SigPrAprBO.Atualizar() desde a Fase 1/2 - este metodo so precisa
    * acionar o contrato BusinessBase (EditarRegistro()+Salvar()) apos as
    * mesmas duas confirmacoes do legado.
    *
    * BO.Salvar()/Atualizar() ja exibem a falha sozinhos (BusinessBase.
    * ExibirFalha) em caso de erro - nenhum ELSE necessario aqui (regra #20).
    *
    * Legado: "This.Enabled = .F." roda INCONDICIONALMENTE ao final do Click
    * (haja ou nao confirmado a atualizacao) - Atualizar so volta a ligar no
    * proximo Processar bem sucedido.
    *==========================================================================
    PROCEDURE BtnAtualizarClick()
        LOCAL loc_oBO, loc_cCursor, loc_lImprimirEtiquetas

        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) = "O"

            IF MsgConfirma("Atualiza " + CHR(63) + CHR(63) + CHR(63), ;
                    "Altera" + CHR(231) + CHR(227) + "o de Pre" + CHR(231) + "os")

                loc_cCursor = loc_oBO.this_cCursorItens
                IF USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    LOCATE FOR lMarca = 1
                ENDIF

                IF !USED(loc_cCursor) OR !FOUND()
                    MsgAviso("Nenhum Produto Selecionado" + CHR(33) + CHR(33) + CHR(33), ;
                        "Sele" + CHR(231) + CHR(227) + "o Obrigat" + CHR(243) + "ria")
                    IF PEMSTATUS(THIS, "grd_4c_Produtos", 5)
                        THIS.grd_4c_Produtos.SetFocus()
                    ENDIF
                ELSE
                    loc_lImprimirEtiquetas = MsgConfirma( ;
                        "Confirma a Impress" + CHR(227) + "o das Etiquetas?", "")
                    loc_oBO.this_lImprimirEtiquetas = loc_lImprimirEtiquetas

                    loc_oBO.EditarRegistro()
                    IF loc_oBO.Salvar()
                        MsgInfo("Processamento Finalizado com Sucesso" + CHR(33) + CHR(33) + CHR(33), "")
                    ENDIF
                ENDIF
            ENDIF

            IF PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
                THIS.cmg_4c_Botoes.Buttons(3).Enabled = .F.
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Transcreve o PROCEDURE Cancela.Click do legado
    * (ThisForm.Release).
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis
    * recursivamente (AddObject cria com Visible=.F. por padrao). FILTRO:
    * img_4c_FigJpg (SIGPRAPR.FigJpg) eh a UNICA excecao - legado declara
    * Visible=.F. no SCX e so aparece quando GridAfterRowColChange encontra
    * foto para o produto da linha corrente.
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oControl) = "O"
                IF UPPER(loc_oControl.Name) == "IMG_4C_FIGJPG"
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

ENDDEFINE
