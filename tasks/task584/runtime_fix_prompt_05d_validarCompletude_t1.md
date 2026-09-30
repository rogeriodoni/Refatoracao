# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[FormSigPrApr.prg] Indicador de pendencia: * sao os que ficaram pendente
[FormSigPrApr.prg] Indicador de pendencia: * visiveis, independente

IMPORTANTE: Preencha TODAS as procedures vazias com codigo funcional REAL. NAO use TODO, FIXME, PLACEHOLDER ou comentarios de pendencia. Cada procedure deve ter implementacao completa.

## CONTEXTO DO ERRO


## ERROS COMUNS E SOLUCOES (Consultar CLAUDE.md)
- "Property PAGE1 is not found" -> Definir .PageCount ANTES de acessar .Page1
- "Property BACKCOLOR is not found" em PageFrame -> Remover BackColor do PageFrame, usar Page1.BackColor
- "RETURN/RETRY not allowed in TRY/CATCH" -> Usar variavel loc_lResultado e RETURN fora do TRY
- "Property ALLOWDELETE is not found" -> Grid VFP9 nao tem AllowDelete/AllowEdit/AllowAddNew
- "Property VISIBLE is not found" em Page -> Pages NAO tem .Visible, apenas PageFrame tem
- "Property ERASEPAGE is not found" -> PageFrame NAO tem ErasePage
- "Unknown member BUTTON1" -> OptionGroup: usar .Buttons(1) ao inves de .Button1
- "Property FONTNAME is not found" em OptionGroup -> OptionGroup NAO tem FontName/FontSize, definir nas Buttons(N)
- "Property FONTNAME is not found" em Grid -> SetAll("FontName",...,"Column") invalido, usar Grid.FontName diretamente
- "Alias XXX is not found" -> Criar cursor ANTES de definir ControlSource
- "Property THIS_CNOMETABELA is not found" -> Usar this_cTabela (nao this_cNomeTabela)
- "Property OBTERTODOS is not found" -> Usar Buscar("") (nao ObterTodos)
- "Property RELEASE is not found" -> Custom/BO NAO tem Release(), usar = .NULL.
- "Function argument value, type, or count is invalid" em FormParaBO -> Se TextBox.Value ja eh numerico, NAO usar VAL()
- "Unknown member PAGE1" apos WITH PageFrame -> Mover config das Pages para FORA do WITH block
- "PAGE1" ou "COLUMN1" apos .Name -> NUNCA usar .Name em Pages ou Columns (rename quebra TODAS as referencias .Page1/.Column1 no resto do codigo)
- BINDEVENT nao funciona -> Metodo deve ser PUBLIC (sem PROTECTED)
- "Incorrect syntax near" em SQL com EscaparSQL/FormatarDataSQL -> Estas funcoes JA INCLUEM aspas. NUNCA adicionar aspas extras: usar campo = " + EscaparSQL(val), NAO campo = '" + EscaparSQL(val) + "'"
- TIMEOUT sem mensagem de erro visivel -> Provavelmente dialog modal de erro travando VFP

## REGRAS OBRIGATORIAS
- Corrigir APENAS o erro indicado, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- NAO alterar nomes de tabelas/colunas do banco (PILAR 2)
- Manter nomenclatura padronizada _4c_ (PILAR 3)
- Strings SQL longas DEVEM ser quebradas com `+;` (continuation) a cada 3-4 campos - NUNCA numa unica linha
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrApr.prg):
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
* sao os que ficaram pendentes das fases anteriores:
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
        * visiveis, independente do tipo de reajuste escolhido.
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
    PROCEDURE TxtVariacaoLostFocus()
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
    PROCEDURE Column2LostFocus()
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


### BO (C:\4c\projeto\app\classes\SigPrAprBO.prg):
*============================================================================
* SigPrAprBO.prg - Business Object para Reajuste de Precificacao
*
* Form OPERACIONAL (SIGPRAPR / FormSigPrApr): processo em lote que recalcula
* o preco de venda de um conjunto de produtos (filtrados por Grupo/Colecao/
* Fornecedor) usando um de tres criterios (Opt_Tipo): Variacao percentual,
* MarkUp sobre custo em moeda, ou Cambio (reprecificacao por cotacao). Os
* produtos calculados ficam numa grade de conferencia (CrProdutos no legado,
* this_cCursorItens aqui) e so sao gravados em definitivo ao clicar Atualizar,
* quando o BO grava historico em SigCdPrc/SigPrCp2 e promocao em SigPrPmi.
*
* Tabelas principais tocadas pelo processo:
*   - SigCdPro  (PK: CPros char(14))    -> produto: preco atual e moedas de custo
*   - SigCdPrc  (PK: cIdChaves char(20)) -> historico de alteracao de preco
*   - SigPrCp2  (PK: cIdChaves char(20)) -> historico de composicao/custo
*   - SigPrPmi  (PK: cidchaves char(20)) -> vinculo produto-promocao
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SigPrAprBO AS BusinessBase

    *==========================================================================
    * Propriedades de filtro - selecao dos produtos a reajustar (Processa.Click)
    *==========================================================================
    this_cCdGrupo   = SPACE(3)    && char(3)  - SigCdGrp.CGrus (Grupo de Produto - "de")        [Get_Cd_Grupo]
    this_cAteGrupo  = SPACE(3)    && char(3)  - SigCdGrp.CGrus (Grupo de Produto - "ate")        [Get_ate_Grupo]
    this_cColecao   = SPACE(10)   && char(10) - SigCdCol.Colecoes (Grupo de Venda/Colecao)       [Get_Col]
    this_cConta     = SPACE(10)   && char(10) - Fornecedor, codigo (SigCdCli.IClis)              [Get_Conta]
    this_cDConta    = SPACE(50)   && char(50) - Fornecedor, descricao (SigCdCli.RClis)           [Get_DConta]

    *==========================================================================
    * Tipo de reajuste (Opt_Tipo: 1=Variacao, 2=MarkUp, 3=Cambio) e parametros
    *==========================================================================
    this_nTipo      = 1           && numeric      - Opt_Tipo.Value (1/2/3)
    this_nVariacao  = 0           && numeric(9,2) - percentual de reajuste (Tipo=1)              [Get_Variacao]
    this_cMoeda     = SPACE(3)    && char(3)      - moeda base do MarkUp (Tipo=2)                [Get_Moeda]
    this_nMarkUp1   = 0           && numeric(6,2) - MarkUp minimo / faixa "de"                   [Get_MarkUp1]
    this_nMarkUp2   = 0           && numeric(6,2) - MarkUp maximo, usado no calculo (Tipo=2)     [Get_MarkUp2]

    *==========================================================================
    * Fator de custo - usado em CalcPreco/CalcMargem quando informado
    *==========================================================================
    this_nFator     = 0           && numeric(8,3) - Fator de custo                               [GET_FATOR]
    this_cMoeCusto  = SPACE(3)    && char(3)      - moeda referente ao Fator de custo             [get_moeCusto]

    *==========================================================================
    * Moedas/feitio de gravacao - sobrescrevem SigCdPro quando informados
    * em Atualiza.Click (campos vazios preservam o valor atual do produto)
    *==========================================================================
    this_cMoeCs     = SPACE(3)    && char(3) - Moeda Custo Compo.  (SigCdPro.MoeCs)     [Get_Moecs]
    this_cMoeCusFs  = SPACE(3)    && char(3) - Moeda Custo Total   (SigCdPro.MoeCusFs)  [Get_MoeCusFs]
    this_cMoedas    = SPACE(3)    && char(3) - Moeda Preco Ideal   (SigCdPro.Moedas)    [Get_Moedas]
    this_cCFtios    = SPACE(3)    && char(3) - Feitio              (SigCdPro.CFtios)    [Get_CFtios]
    this_cMoeVs     = SPACE(3)    && char(3) - Moeda Preco Atual   (SigCdPro.MoeVs)     [Get_MoeVs]

    *==========================================================================
    * Promocao a vincular aos produtos atualizados (grava em SigPrPmi)
    *==========================================================================
    this_cPromo         = SPACE(25)   && char(25) - SigPrPmc.Promos                     [Get_Promo]
    this_lLimparPromos  = .F.         && logical  - Limpar promocoes anteriores         [chkLimpar]

    *==========================================================================
    * Flags de opcoes do processamento
    *==========================================================================
    this_lAuditado  = .F.   && logical - modo "Produtos": inclusao manual de itens na grade  [chkAuditado]
    this_lIncCusts  = .F.   && logical - Incluir Custos no reajuste por variacao (Tipo=1)     [chkIncCusts]
    this_lIgnorar   = .F.   && logical - Ignorar Componentes (nao filtra produto-componente)  [chkIgnorar]

    *==========================================================================
    * Estado - permissao de edicao manual do Valor Atual na grade de conferencia
    *==========================================================================
    this_lLibValAtu = .F.   && logical - fChecaAcesso('SIGPRAPR', 'VMANUAL')

    *==========================================================================
    * Parametros do sistema (SigCdPam/SigCdPac), carregados uma unica vez no
    * Init - equivalente aos SqlExecute('...SigCdPam...')/('...SigCdPac...')
    * do Init() legado
    *==========================================================================
    this_nMarkUpCVs  = 0          && numeric(9,6) - SigCdPam.MarkUpCVs
    this_cGrPadFors  = SPACE(10)  && char(10)     - SigCdPam.GrPadFors (grupo padrao p/ acesso a Contas)
    this_nCalcCusts  = 0          && numeric(1,0) - SigCdPac.CalcCusts (2 = nao usar peso no calculo de custo)
    this_nChkSubGrs  = 0          && numeric(1,0) - SigCdPac.nChkSubGrs (recalcula subgrupo por faixa de preco)

    *==========================================================================
    * Cursor de trabalho - grade de produtos selecionados/reajustados
    * (equivalente ao CrProdutos do legado). Estrutura: lMarca N(1), CPros
    * C(14), DPros C(40), ValAnt N(14,2), ValAtu N(14,2), fCustos N(8,3),
    * MoePcs C(3), CustoFs N(12,3), Manual N(1) - criado/populado pelo
    * metodo de processamento (equivalente ao Processa.Click), a ser
    * completado em fase posterior. Atualizar() abaixo consome este cursor
    * ja preenchido; se ainda nao existir, devolve mensagem de erro.
    *==========================================================================
    this_cCursorItens = "cursor_4c_Produtos"

    *==========================================================================
    * Propriedades de registro - SigPrPmi (vinculo produto-promocao), usadas
    * por CarregarDoCursor()/Inserir()/ObterChavePrimaria(). this_cCpros e
    * this_cPromo (acima) sao compartilhados com o vinculo gravado aqui -
    * this_cPromo ja representa SigPrPmi.Promos (mesmo campo do filtro).
    *==========================================================================
    this_cIdChaves   = SPACE(20)  && char(20) - SigPrPmi.cidchaves (PK)
    this_cPecas      = SPACE(10)  && char(10) - SigPrPmi.pecas
    this_nCBars      = 0          && numeric(14,0) - SigPrPmi.cbars
    this_dDatas      = {}         && datetime      - SigPrPmi.datas
    this_cPromoPro   = SPACE(35)  && char(35) - SigPrPmi.promopro (promo+cpros, truncado)
    this_dDtAlts     = {}         && datetime      - SigPrPmi.dtalts
    this_nVendavels  = 0          && numeric(1,0)  - SigPrPmi.vendavels (NOT NULL, sem uso no legado)

    *==========================================================================
    * Propriedade de item em processamento - produto CORRENTE dentro do laco
    * de Atualizar()/Inserir() (SigCdPro.cpros / SigPrPmi.cpros)
    *==========================================================================
    this_cCpros = SPACE(14)

    *==========================================================================
    * Resposta do MsgConfirma "Confirma a Impressao das Etiquetas?" (legado),
    * definida pelo Form ANTES de EditarRegistro()+Salvar() - BusinessBase.
    * Salvar() chama Atualizar() sem parametros, entao o valor tem de vir
    * por property.
    *==========================================================================
    this_lImprimirEtiquetas = .F.

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela/chave primaria
    * de referencia (SigPrPmi/cidchaves - vinculo produto-promocao gravado ao
    * Atualizar) e carrega os parametros do sistema usados no calculo
    * (SigCdPam.MarkUpCVs/GrPadFors, SigCdPac.CalcCusts/nChkSubGrs)
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrPmi"
            THIS.this_cCampoChave = "cidchaves"

            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0

                IF USED("cursor_4c_SigCdPam")
                    USE IN cursor_4c_SigCdPam
                ENDIF
                SQLEXEC(gnConnHandle, "SELECT MarkUpCVs, GrPadFors FROM SigCdPam", "cursor_4c_SigCdPam")
                IF USED("cursor_4c_SigCdPam") AND !EOF("cursor_4c_SigCdPam")
                    THIS.this_nMarkUpCVs = TratarNulo(cursor_4c_SigCdPam.MarkUpCVs, 0)
                    THIS.this_cGrPadFors = PADR(TratarNulo(cursor_4c_SigCdPam.GrPadFors, ""), 10)
                ENDIF
                IF USED("cursor_4c_SigCdPam")
                    USE IN cursor_4c_SigCdPam
                ENDIF

                IF USED("cursor_4c_SigCdPac")
                    USE IN cursor_4c_SigCdPac
                ENDIF
                SQLEXEC(gnConnHandle, "SELECT CalcCusts, nChkSubGrs FROM SigCdPac", "cursor_4c_SigCdPac")
                IF USED("cursor_4c_SigCdPac") AND !EOF("cursor_4c_SigCdPac")
                    THIS.this_nCalcCusts = TratarNulo(cursor_4c_SigCdPac.CalcCusts, 0)
                    THIS.this_nChkSubGrs = TratarNulo(cursor_4c_SigCdPac.nChkSubGrs, 0)
                ENDIF
                IF USED("cursor_4c_SigCdPac")
                    USE IN cursor_4c_SigCdPac
                ENDIF

            ENDIF

            *-- Cria o cursor de trabalho vazio ja no Init, para que o Grid
            *-- do form possa ligar Column.ControlSource/RecordSource nele
            *-- durante InicializarForm (o cursor so recebe linhas de verdade
            *-- quando o usuario clicar Processar - BuscarProdutos())
            THIS.CriarCursorItens()

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CriarCursorItens - Cria (ou ESVAZIA) o cursor de trabalho da grade de
    * conferencia. Estrutura TRANSCRITA do legado (Create Cursor CrProdutos,
    * PROCEDURE Init do SIGPRAPR): mesma ordem/tipos/tamanhos em TODOS os
    * lugares onde o cursor eh usado (unico ponto de criacao).
    *
    * Cursor JA existente eh esvaziado com ZAP, NUNCA fechado e recriado - o
    * legado tambem faz "Zap In CrProdutos" no inicio do Processa.Click, pelo
    * mesmo motivo: fechar o alias derruba o binding de quem aponta para ele
    * (grd_4c_Produtos.RecordSource + as 5 Column.ControlSource, ligados uma
    * unica vez em ConfigurarGrid). Recriando, o Processar preencheria o
    * cursor e a grade continuaria vazia - sem erro e sem log.
    *==========================================================================
    PROTECTED PROCEDURE CriarCursorItens()
        LOCAL loc_cSafety

        IF USED("cursor_4c_Produtos")
            *-- DataSession=2 reseta SET SAFETY para ON (mesmo mecanismo que
            *-- reseta SET DATE/CENTURY) - sem o guard, o ZAP abre o dialogo
            *-- modal "Are you sure?" e congela a tela.
            loc_cSafety = SET("SAFETY")
            SET SAFETY OFF
            SELECT cursor_4c_Produtos
            ZAP IN cursor_4c_Produtos
            IF loc_cSafety = "ON"
                SET SAFETY ON
            ENDIF
        ELSE
            SET NULL ON
            CREATE CURSOR cursor_4c_Produtos (lMarca N(1), CPros C(14), DPros C(40), ;
                ValAnt N(14,2), ValAtu N(14,2), fCustos N(8,3), MoePcs C(3), CustoFs N(12,3), Manual N(1))
            SET NULL OFF
            *-- Legado: Index On CPros Tag CPros - usado pelo modo "Produtos"
            *-- (chkAuditado) para alternar entre ordem natural (linhas
            *-- digitadas manualmente aparecem no fim) e ordem por codigo
            *-- (exibicao normal, "Set Order To CPros")
            INDEX ON CPros TAG CPros
        ENDIF
    ENDPROC

    *==========================================================================
    * BuscarProdutos - Transcreve o PROCEDURE Processa.Click do legado: monta
    * a selecao de produtos a partir dos filtros (this_cCdGrupo/this_cAteGrupo/
    * this_cColecao/this_cConta/this_nTipo/this_nVariacao/this_cMoeda/
    * this_nMarkUp1/this_nMarkUp2/this_lIgnorar - propriedades da Fase 1,
    * preenchidas pelo Form a partir dos campos de filtro), calcula o novo
    * preco (ValAtu) conforme o tipo de reajuste e popula cursor_4c_Produtos
    * para conferencia/edicao manual na grade antes de Atualizar().
    *
    * Retorno .T. com this_cMensagemErro preenchido = falha de VALIDACAO (o
    * legado mostra o MessageBox e devolve o foco ao campo - condicao de
    * negocio, nao erro tecnico; mesmo padrao de SigPrAopBO.BuscarItensPorOP).
    * Retorno .F. = falha TECNICA (SQL/conexao) - so nesse caso o Form deve
    * usar MsgErro no lugar de MsgAviso.
    *==========================================================================
    PROCEDURE BuscarProdutos()
        LOCAL loc_lSucesso, loc_cWhere, loc_cSQL, loc_nResultado, loc_oErro, loc_lProsseguir
        LOCAL loc_nCotId, loc_nCotVd, loc_nPven, loc_nValAtu, loc_cMoePcs, loc_nFCustos, loc_nCustoFs

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        THIS.CriarCursorItens()

        *-- Legado: Do Case / Consiste Selecao
        DO CASE
        CASE THIS.this_nTipo = 1 AND THIS.this_nVariacao = 0
            THIS.this_cMensagemErro = "Varia" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida" + CHR(33) + CHR(33) + CHR(33)
            RETURN .T.
        CASE THIS.this_nTipo = 2 AND EMPTY(ALLTRIM(THIS.this_cMoeda))
            THIS.this_cMensagemErro = "Moeda Inv" + CHR(225) + "lida" + CHR(33) + CHR(33) + CHR(33)
            RETURN .T.
        CASE THIS.this_nTipo = 2 AND THIS.this_nMarkUp2 = 0
            THIS.this_cMensagemErro = "MarkUp Inv" + CHR(225) + "lido" + CHR(33) + CHR(33) + CHR(33)
            RETURN .T.
        ENDCASE

        TRY
            *-- Legado: lcWhere (Cgrus faixa/exato, Colecoes, IFors, e
            *-- MoeVs+Margems quando Tipo=2)
            loc_cWhere = "0 = 0 "
            IF !EMPTY(ALLTRIM(THIS.this_cCdGrupo)) OR !EMPTY(ALLTRIM(THIS.this_cAteGrupo))
                IF !EMPTY(ALLTRIM(THIS.this_cAteGrupo))
                    loc_cWhere = loc_cWhere + "AND Cgrus BETWEEN " + EscaparSQL(ALLTRIM(THIS.this_cCdGrupo)) + ;
                        " AND " + EscaparSQL(ALLTRIM(THIS.this_cAteGrupo)) + " "
                ELSE
                    loc_cWhere = loc_cWhere + "AND CGrus = " + EscaparSQL(ALLTRIM(THIS.this_cCdGrupo)) + " "
                ENDIF
            ENDIF
            IF !EMPTY(ALLTRIM(THIS.this_cColecao))
                loc_cWhere = loc_cWhere + "AND Colecoes = " + EscaparSQL(ALLTRIM(THIS.this_cColecao)) + " "
            ENDIF
            IF !EMPTY(ALLTRIM(THIS.this_cConta))
                loc_cWhere = loc_cWhere + "AND IFors = " + EscaparSQL(ALLTRIM(THIS.this_cConta)) + " "
            ENDIF
            IF THIS.this_nTipo = 2
                loc_cWhere = loc_cWhere + "AND MoeVs = " + EscaparSQL(ALLTRIM(THIS.this_cMoeda)) + ;
                    " AND Margems = " + FormatarNumeroSQL(THIS.this_nMarkUp1, 2) + " "
            ENDIF

            loc_cSQL = "SELECT * FROM SigCdPro WHERE " + loc_cWhere
            IF !THIS.this_lIgnorar
                loc_cSQL = loc_cSQL + "AND Cpros NOT IN (SELECT DISTINCT cpros FROM SigPrCpo) "
            ENDIF
            loc_cSQL = loc_cSQL + "ORDER BY CPros"

            IF USED("cursor_4c_ProdutosOrigem")
                USE IN cursor_4c_ProdutosOrigem
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdutosOrigem")

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Falha na consulta de produtos:" + CHR(13) + CapturarErroSQL()
                loc_lProsseguir = .F.
            ELSE
                loc_lProsseguir = .T.
            ENDIF

            *-- Legado: Scan / Do Case (calculo do novo preco por tipo de
            *-- reajuste) / Insert Into CrProdutos
            IF loc_lProsseguir AND USED("cursor_4c_ProdutosOrigem")
                SELECT cursor_4c_ProdutosOrigem
                SCAN
                    loc_cMoePcs  = IIF(EMPTY(ALLTRIM(THIS.this_cMoeCusto)), ALLTRIM(TratarNulo(cursor_4c_ProdutosOrigem.Moepcs, "")), ALLTRIM(THIS.this_cMoeCusto))
                    loc_nFCustos = IIF(THIS.this_nFator > 0 AND !EMPTY(loc_cMoePcs), THIS.this_nFator, TratarNulo(cursor_4c_ProdutosOrigem.fCustos, 0))
                    *-- Legado: m.CustoFs = Iif(Fator>0 AND !Empty(Moepcs), TmpPro.CustoFs, m.CustoF)
                    *-- onde m.CustoF ja veio de TmpPro.CustoFs - as DUAS ramas do IIF
                    *-- avaliam para o MESMO valor (vestigio do legado, igual ao
                    *-- "Replace CustoFs With m.CustoF" ja documentado em CalcPreco)
                    loc_nCustoFs = TratarNulo(cursor_4c_ProdutosOrigem.CustoFs, 0)

                    DO CASE
                    CASE THIS.this_nTipo = 1
                        loc_nValAtu = cursor_4c_ProdutosOrigem.PVens + ((cursor_4c_ProdutosOrigem.PVens * THIS.this_nVariacao) / 100)
                    CASE THIS.this_nTipo = 2
                        loc_nValAtu = THIS.CalcPreco(THIS.this_nMarkUp2, "cursor_4c_ProdutosOrigem")
                    CASE THIS.this_nTipo = 3
                        loc_nCotId  = THIS.ObterCotacaoResolvida(cursor_4c_ProdutosOrigem.Moedas)
                        loc_nCotVd  = THIS.ObterCotacaoResolvida(cursor_4c_ProdutosOrigem.Moevs)
                        loc_nPven   = cursor_4c_ProdutosOrigem.PVideals * loc_nCotId / loc_nCotVd
                        loc_nValAtu = loc_nPven / IIF(cursor_4c_ProdutosOrigem.Encargos <> 0, cursor_4c_ProdutosOrigem.Encargos, 1)
                    ENDCASE

                    INSERT INTO cursor_4c_Produtos (lMarca, CPros, DPros, ValAnt, ValAtu, fCustos, MoePcs, CustoFs, Manual) ;
                        VALUES (1, cursor_4c_ProdutosOrigem.CPros, cursor_4c_ProdutosOrigem.DPros, cursor_4c_ProdutosOrigem.PVens, ;
                            loc_nValAtu, loc_nFCustos, loc_cMoePcs, loc_nCustoFs, 0)

                    SELECT cursor_4c_ProdutosOrigem
                ENDSCAN
                USE IN cursor_4c_ProdutosOrigem
            ENDIF

            IF loc_lProsseguir
                SELECT cursor_4c_Produtos
                GO TOP
                loc_lSucesso = .T.
            ELSE
                loc_lSucesso = .F.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas de uma linha de SigPrPmi
    * (identificada por cidchaves) para as propriedades this_ do BO.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF VARTYPE(par_cAliasCursor) != "C" OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        THIS.this_cIdChaves   = TratarNulo(cidchaves, "")
        THIS.this_cCpros      = TratarNulo(cpros, "")
        THIS.this_cPecas      = TratarNulo(pecas, "")
        THIS.this_cPromo      = TratarNulo(promos, "")
        THIS.this_nCBars      = TratarNulo(cbars, 0)
        THIS.this_dDatas      = TratarNulo(datas, {})
        THIS.this_cPromoPro   = TratarNulo(promopro, "")
        THIS.this_dDtAlts     = TratarNulo(dtalts, {})
        THIS.this_nVendavels  = TratarNulo(vendavels, 0)

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Chave do registro "corrente" para auditoria. Ao
    * longo de Atualizar(), this_cTabela/this_cIdChaves sao reposicionados a
    * cada gravacao bem sucedida (SigCdPro por cpros, SigPrPmi por cidchaves),
    * de forma que RegistrarAuditoria() sempre registre a linha certa.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cIdChaves
    ENDPROC

    *==========================================================================
    * Inserir - Vincula um produto a uma promocao em SigPrPmi (bloco final do
    * Atualiza.Click legado: "If !Empty(lcPromo) / Select TmpPromI / If Eof() /
    * Insert Into CrSigPrPmi ..."). Chamado internamente por Atualizar() para
    * cada produto processado, quando ainda nao existe vinculo com a promocao
    * informada. this_cCpros/this_cPromo DEVEM estar preenchidos antes da
    * chamada; this_cIdChaves, se vazio, e gerado aqui.
    *
    * cbars/pecas/vendavels nao tem equivalente no formulario legado (o
    * Insert do legado tambem nao os cita) - gravados com os defaults do
    * cursor buffer original (0/"").
    *
    * promopro (char 35) e o proprio legado monta com lcPromo (25) + CPros
    * (14) = ate 39 chars, mais largo que a coluna - LEFT() para nao estourar
    * "String or binary data would be truncated" (regra #19).
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(THIS.this_cCpros)) OR EMPTY(ALLTRIM(THIS.this_cPromo))
            THIS.this_cMensagemErro = "Produto ou Promo" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informados."
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cIdChaves))
            THIS.this_cIdChaves = fUniqueIds()
        ENDIF
        THIS.this_cPromoPro = LEFT(ALLTRIM(THIS.this_cPromo) + ALLTRIM(THIS.this_cCpros), 35)

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigPrPmi (cpros, pecas, promos, cbars, datas, cidchaves, dtalts, promopro, vendavels)
                VALUES (
                    <<EscaparSQL(THIS.this_cCpros)>>,
                    <<EscaparSQL("")>>,
                    <<EscaparSQL(THIS.this_cPromo)>>,
                    <<FormatarNumeroSQL(0, 0)>>,
                    GETDATE(),
                    <<EscaparSQL(THIS.this_cIdChaves)>>,
                    GETDATE(),
                    <<EscaparSQL(THIS.this_cPromoPro)>>,
                    <<FormatarNumeroSQL(0, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERIR")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao vincular produto " + ALLTRIM(THIS.this_cCpros) + ;
                    " " + CHR(224) + " promo" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL()
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarCambio - Cotacao (Valos) mais recente da moeda na data informada
    * (SigCdCot, filtrando por Cmoes + Datas <= data, a mais recente primeiro).
    * fBuscarCotacao NAO foi portada (regra CLAUDE.md) - substituicao local.
    * Sem cotacao encontrada, devolve 1 (mesmo fallback do legado: nunca
    * zera o preco por falta de cambio).
    *==========================================================================
    PROTECTED FUNCTION CarregarCambio(par_cMoeda, par_dData)
        LOCAL loc_cMoeda, loc_dData, loc_nCotacao, loc_cSQL

        loc_cMoeda   = ALLTRIM(TratarNulo(par_cMoeda, ""))
        loc_dData    = IIF(EMPTY(par_dData), DATE(), ConverterParaData(par_dData))
        loc_nCotacao = 0

        IF EMPTY(loc_cMoeda)
            RETURN 1
        ENDIF

        IF USED("cursor_4c_Cotacao")
            USE IN cursor_4c_Cotacao
        ENDIF
        loc_cSQL = "SELECT TOP 1 valos FROM SigCdCot WHERE cmoes = " + EscaparSQL(loc_cMoeda) + ;
            " AND datas <= " + FormatarDataSQL(loc_dData) + " ORDER BY datas DESC"
        SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cotacao")

        IF USED("cursor_4c_Cotacao") AND !EOF("cursor_4c_Cotacao")
            loc_nCotacao = TratarNulo(cursor_4c_Cotacao.valos, 0)
        ENDIF
        IF USED("cursor_4c_Cotacao")
            USE IN cursor_4c_Cotacao
        ENDIF

        RETURN IIF(loc_nCotacao = 0, 1, loc_nCotacao)
    ENDFUNC

    *==========================================================================
    * ObterCotacaoResolvida - Transcreve o padrao repetido em calcpreco/
    * calcmargem/calcmarkpa/calcideal do legado:
    *   CursorQuery('SigCdMoe', ..., par_cMoeda) / Go Top
    *   Se MoeQs preenchido, cotacao = CarregarCambio(MoeQs) * QtdeQs (ou 1)
    *   Senao, cotacao = CarregarCambio(par_cMoeda) * 1
    *==========================================================================
    PROTECTED FUNCTION ObterCotacaoResolvida(par_cMoeda)
        LOCAL loc_cMoeda, loc_cMoeQs, loc_nQtdeQs, loc_nCotacao

        loc_cMoeda = ALLTRIM(TratarNulo(par_cMoeda, ""))
        IF EMPTY(loc_cMoeda)
            RETURN 1
        ENDIF

        IF USED("cursor_4c_MoedaCot")
            USE IN cursor_4c_MoedaCot
        ENDIF
        SQLEXEC(gnConnHandle, "SELECT MoeQs, QtdeQs FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cMoeda), "cursor_4c_MoedaCot")

        loc_cMoeQs  = loc_cMoeda
        loc_nQtdeQs = 1
        IF USED("cursor_4c_MoedaCot") AND !EOF("cursor_4c_MoedaCot")
            IF !EMPTY(ALLTRIM(TratarNulo(cursor_4c_MoedaCot.MoeQs, "")))
                loc_cMoeQs  = ALLTRIM(cursor_4c_MoedaCot.MoeQs)
                loc_nQtdeQs = IIF(TratarNulo(cursor_4c_MoedaCot.QtdeQs, 0) = 0, 1, cursor_4c_MoedaCot.QtdeQs)
            ENDIF
        ENDIF
        IF USED("cursor_4c_MoedaCot")
            USE IN cursor_4c_MoedaCot
        ENDIF

        loc_nCotacao = THIS.CarregarCambio(loc_cMoeQs, DATE()) * loc_nQtdeQs

        RETURN loc_nCotacao
    ENDFUNC

    *==========================================================================
    * CalcPreco - Transcreve o PROCEDURE calcpreco do legado: preco IDEAL para
    * a margem informada, a partir dos dados do produto CORRENTE do cursor
    * par_cAliasProduto (colunas obrigatorias: PCuss, PesoMs, PFtios, MoeCs,
    * MoePCs, MoeVs, MoeCusFs, MFtios, fCustos, Moedas - mesmo subconjunto
    * usado pelo legado via TmpPro).
    *
    * MoeCusto/FatCusto/MoeIdeal seguem o mesmo IIF do legado (campo do form
    * quando preenchido, senao o dado do produto): aqui os campos do form sao
    * this_cMoeCusto/this_nFator/this_cMoedas (propriedades da Fase 1).
    *
    * O legado tambem faz "Replace CustoFs With lnCustof in TmpPro" ao final -
    * OMITIDO aqui de proposito: em Atualiza.Click esse CustoFs recem-calculado
    * e sempre sobrescrito logo em seguida por CsProdutos.CustoFs (valor da
    * grade), tornando o Replace vestigial nesse fluxo (unico ponto do legado
    * que chama CalcPreco fora do preview).
    *==========================================================================
    PROTECTED FUNCTION CalcPreco(par_nMargem, par_cAliasProduto)
        LOCAL loc_cMoeCusto, loc_nFatCusto, loc_cMoeIdeal, loc_nCusto, loc_nFPeso, loc_nFeitio
        LOCAL loc_nMoeC, loc_nMoeP, loc_nMoeV, loc_nMoeCF, loc_nMoedas, loc_nMoeFT
        LOCAL loc_nCustoF, loc_nIdeal

        SELECT (par_cAliasProduto)

        loc_cMoeCusto = IIF(EMPTY(ALLTRIM(THIS.this_cMoeCusto)), ALLTRIM(TratarNulo(MoePCs, "")), ALLTRIM(THIS.this_cMoeCusto))
        loc_nFatCusto = IIF(THIS.this_nFator > 0 AND !EMPTY(loc_cMoeCusto), THIS.this_nFator, TratarNulo(fCustos, 0))
        loc_cMoeIdeal = IIF(EMPTY(ALLTRIM(THIS.this_cMoedas)), ALLTRIM(TratarNulo(Moedas, "")), ALLTRIM(THIS.this_cMoedas))

        loc_nCusto  = TratarNulo(PCuss, 0)
        loc_nFPeso  = TratarNulo(PesoMs, 0) * loc_nFatCusto
        loc_nFeitio = TratarNulo(PFtios, 0)

        loc_nMoeC   = THIS.ObterCotacaoResolvida(MoeCs)
        loc_nMoeP   = THIS.ObterCotacaoResolvida(loc_cMoeCusto)
        loc_nMoeV   = THIS.ObterCotacaoResolvida(MoeVs)
        loc_nMoeCF  = THIS.ObterCotacaoResolvida(MoeCusFs)
        loc_nMoedas = THIS.ObterCotacaoResolvida(loc_cMoeIdeal)
        loc_nMoeFT  = THIS.ObterCotacaoResolvida(MFtios)

        IF ALLTRIM(TratarNulo(MFtios, "")) != ALLTRIM(TratarNulo(MoeCusFs, ""))
            loc_nFeitio = (loc_nFeitio * loc_nMoeFT) / loc_nMoeCF
        ENDIF

        IF ALLTRIM(TratarNulo(MoeCs, "")) != ALLTRIM(TratarNulo(MoeCusFs, ""))
            loc_nCustoF = (loc_nCusto * loc_nMoeC) / loc_nMoeCF
        ELSE
            loc_nCustoF = loc_nCusto
        ENDIF

        IF THIS.this_nCalcCusts = 2
            IF loc_cMoeCusto != ALLTRIM(TratarNulo(MoeCusFs, ""))
                loc_nCustoF = loc_nCustoF * IIF(loc_nFatCusto = 0, 1, loc_nFatCusto * loc_nMoeP / loc_nMoeCF)
            ELSE
                loc_nCustoF = loc_nCustoF * IIF(loc_nFatCusto = 0, 1, loc_nFatCusto)
            ENDIF
        ELSE
            IF loc_cMoeCusto != ALLTRIM(TratarNulo(MoeCusFs, ""))
                loc_nCustoF = loc_nCustoF + (loc_nFPeso * loc_nMoeP / loc_nMoeCF)
            ELSE
                loc_nCustoF = loc_nCustoF + loc_nFPeso
            ENDIF
        ENDIF

        IF ALLTRIM(TratarNulo(MoeCusFs, "")) != loc_cMoeIdeal
            loc_nIdeal = (loc_nCustoF + loc_nFeitio) * loc_nMoeCF / loc_nMoedas * par_nMargem
        ELSE
            loc_nIdeal = (loc_nCustoF + loc_nFeitio) * par_nMargem
        ENDIF

        RETURN loc_nIdeal
    ENDFUNC

    *==========================================================================
    * ProcessarProdutoManual - Transcreve o trecho do LostFocus do
    * Column2.Text1 legado (modo "Produtos"/chkAuditado): dado o codigo de um
    * produto digitado manualmente na grade, calcula o novo preco pelo MESMO
    * criterio de BuscarProdutos (this_nTipo/this_nVariacao/this_nMarkUp2 - o
    * Form chama SincronizarFiltros() antes desta chamada) e grava a linha em
    * cursor_4c_Produtos. PUBLIC porque o Form aciona isto direto do evento
    * de grade (CalcPreco/ObterCotacaoResolvida sao PROTECTED e nao podem ser
    * chamados de fora do BO). Retorno .F. = produto nao encontrado
    * (this_cMensagemErro preenchido).
    *==========================================================================
    PROCEDURE ProcessarProdutoManual(par_cCodigo)
        LOCAL loc_lSucesso, loc_nValAtu, loc_nCotId, loc_nCotVd, loc_oErro
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF USED("cursor_4c_ProdutoManual")
                USE IN cursor_4c_ProdutoManual
            ENDIF
            SQLEXEC(gnConnHandle, ;
                "SELECT CPros, DPros, PVens, PVideals, Encargos, Moedas, MoeVs, " + ;
                "PCuss, PesoMs, PFtios, MoeCs, MoePCs, MoeCusFs, MFtios, fCustos, CFtios " + ;
                "FROM SigCdPro WHERE CPros = " + EscaparSQL(par_cCodigo), "cursor_4c_ProdutoManual")

            IF USED("cursor_4c_ProdutoManual") AND !EOF("cursor_4c_ProdutoManual")
                DO CASE
                CASE THIS.this_nTipo = 1
                    loc_nValAtu = cursor_4c_ProdutoManual.PVens + ((cursor_4c_ProdutoManual.PVens * THIS.this_nVariacao) / 100)
                CASE THIS.this_nTipo = 2
                    loc_nValAtu = THIS.CalcPreco(THIS.this_nMarkUp2, "cursor_4c_ProdutoManual")
                CASE THIS.this_nTipo = 3
                    loc_nCotId  = THIS.ObterCotacaoResolvida(cursor_4c_ProdutoManual.Moedas)
                    loc_nCotVd  = THIS.ObterCotacaoResolvida(cursor_4c_ProdutoManual.MoeVs)
                    loc_nValAtu = (cursor_4c_ProdutoManual.PVideals * loc_nCotId / loc_nCotVd) / ;
                        IIF(cursor_4c_ProdutoManual.Encargos <> 0, cursor_4c_ProdutoManual.Encargos, 1)
                ENDCASE

                IF USED(THIS.this_cCursorItens)
                    SELECT (THIS.this_cCursorItens)
                    REPLACE lMarca WITH 1, ;
                            CPros  WITH cursor_4c_ProdutoManual.CPros, ;
                            DPros  WITH cursor_4c_ProdutoManual.DPros, ;
                            ValAnt WITH cursor_4c_ProdutoManual.PVens, ;
                            ValAtu WITH loc_nValAtu IN (THIS.this_cCursorItens)
                ENDIF
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Produto n" + CHR(227) + "o encontrado" + CHR(33) + CHR(33) + CHR(33)
            ENDIF

            IF USED("cursor_4c_ProdutoManual")
                USE IN cursor_4c_ProdutoManual
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * GravarHistoricoComposicao - Copia, para SigPrCp2 (historico), TODAS as
    * linhas de composicao vigentes do produto em SigPrCpo (equivalente a
    * "SqlExecute(Select * From SigPrCpo Where CPros=...) / Scan / Scatter /
    * Insert Into CrSigPrCp2 From MemVar" do legado). cidchaves E GERADO DE
    * NOVO para cada linha - reaproveitar o cidchaves de origem colidiria com
    * a PK de SigPrCp2 caso o mesmo produto seja reajustado mais de uma vez
    * (SigPrCpo.cidchaves nao muda entre reajustes).
    *==========================================================================
    PROTECTED FUNCTION GravarHistoricoComposicao(par_cCpros)
        LOCAL loc_lOk, loc_cSQL, loc_cIdOrigem, loc_cIdNovo, loc_cHora
        loc_lOk = .T.

        IF USED("cursor_4c_ComposicaoAtual")
            USE IN cursor_4c_ComposicaoAtual
        ENDIF
        SQLEXEC(gnConnHandle, "SELECT cidchaves FROM SigPrCpo WHERE cpros = " + EscaparSQL(par_cCpros), "cursor_4c_ComposicaoAtual")

        IF USED("cursor_4c_ComposicaoAtual")
            loc_cHora = SUBSTR(TTOC(DATETIME()), 10, 8)
            SELECT cursor_4c_ComposicaoAtual
            SCAN
                loc_cIdOrigem = cursor_4c_ComposicaoAtual.cidchaves
                loc_cIdNovo   = fUniqueIds()

                TEXT TO loc_cSQL TEXTMERGE NOSHOW
                    INSERT INTO SigPrCp2 (
                        cats, cgrus, cpros, datatrans, dcompos, dscgrp, etiqs, grupos, mats, moeds,
                        obscompos, ordems, pcompos, qtds, qtscons, unicompos, compos, ordcompos, qtdcvs, vlrcvs,
                        dtmovs, cunips, markcvs, pesos, totas, tpalts, vlrpvs, ordts, tipos, matriz,
                        obsofs,
                        cidchaves, dataalts, horaalts, usuaalts
                    )
                    SELECT
                        cats, cgrus, cpros, datatrans, dcompos, dscgrp, etiqs, grupos, mats, moeds,
                        obscompos, ordems, pcompos, qtds, qtscons, unicompos, compos, ordcompos, qtdcvs, vlrcvs,
                        dtmovs, cunips, markcvs, pesos, totas, tpalts, vlrpvs, ordts, tipos, matriz,
                        obsofs,
                        <<EscaparSQL(loc_cIdNovo)>>, GETDATE(), <<EscaparSQL(loc_cHora)>>, <<EscaparSQL(gc_4c_UsuarioLogado)>>
                    FROM SigPrCpo WHERE cidchaves = <<EscaparSQL(loc_cIdOrigem)>>
                ENDTEXT

                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                    THIS.this_cMensagemErro = "Falha ao gravar hist" + CHR(243) + "rico de composi" + CHR(231) + CHR(227) + ;
                        "o (SigPrCp2):" + CHR(13) + CapturarErroSQL()
                    loc_lOk = .F.
                    EXIT
                ENDIF

                SELECT cursor_4c_ComposicaoAtual
            ENDSCAN
            USE IN cursor_4c_ComposicaoAtual
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *==========================================================================
    * Atualizar - Confirma a atualizacao de precos (Atualiza.Click do legado).
    * Para cada produto marcado (lMarca=1) em cursor_4c_Produtos:
    *   1) Le a linha CORRENTE de SigCdPro (equivalente ao Seek+Scatter TmpPro)
    *   2) Grava snapshot em SigCdPrc (historico) com os valores ANTIGOS
    *   3) Recalcula PVens/PCuss/CustoFs/Margems/PVIdeals/fCustos/Moepcs
    *      conforme this_nTipo (1=Variacao, 2=MarkUp/CalcPreco, 3=Cambio),
    *      respeitando o override manual da grade (Manual=1 -> usa ValAtu)
    *   4) Recalcula MarkupA (Calcmarkpa) com os valores NOVOS
    *   5) UPDATE SigCdPro com os campos alterados + overrides de moeda/feitio
    *   6) Copia a composicao vigente (SigPrCpo) para o historico (SigPrCp2)
    *   7) Remove vinculo de portal/etiqueta anterior (SigPrPrt)
    *   8) Se this_lLimparPromos, remove promocoes anteriores (SigPrPmi)
    *   9) Vincula a nova promocao (this_cPromo), se informada e ainda nao
    *      vinculada a este produto (via Inserir())
    * Tudo dentro de uma unica transacao manual (SQLCOMMIT/SQLROLLBACK) -
    * qualquer falha em qualquer produto desfaz TODO o lote, igual ao legado
    * (ThisForm.poDataMgr.Commit()/RollBack() unico para o lote inteiro).
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_lOk, loc_cSQL, loc_oErro, loc_nQtdeProcessados
        LOCAL loc_cCproAtual, loc_cIdChavesHistorico, loc_cHoraAtual, loc_cOrigem
        LOCAL loc_nPVensNovo, loc_nPCussNovo, loc_nCustoFsNovo, loc_nMargemNovo, loc_nPVIdealsNovo
        LOCAL loc_nFCustosNovo, loc_cMoePcsNovo, loc_nCotIdeal, loc_nCotVenda, loc_nPVenCambio
        LOCAL loc_cMoeCsNovo, loc_cMoeCusFsNovo, loc_cMoedasNovo, loc_cCFtiosNovo, loc_cMoeVsNovo
        LOCAL loc_nMarkupA

        loc_lSucesso = .F.
        loc_lOk      = .T.
        loc_nQtdeProcessados = 0
        THIS.this_cMensagemErro = ""

        IF !USED(THIS.this_cCursorItens) OR RECCOUNT(THIS.this_cCursorItens) = 0
            THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + " produtos processados."
            RETURN .F.
        ENDIF

        SELECT (THIS.this_cCursorItens)
        LOCATE FOR lMarca = 1
        IF !FOUND()
            THIS.this_cMensagemErro = "Nenhum Produto Selecionado" + CHR(33) + CHR(33) + CHR(33)
            RETURN .F.
        ENDIF

        TRY
            SELECT cursor_4c_Produtos
            SCAN FOR lMarca = 1

                loc_cCproAtual = ALLTRIM(cursor_4c_Produtos.CPros)

                *-- 1) Carrega a linha ATUAL de SigCdPro (equivalente ao Seek+Scatter TmpPro)
                IF USED("cursor_4c_ProdutoAtual")
                    USE IN cursor_4c_ProdutoAtual
                ENDIF
                SQLEXEC(gnConnHandle, ;
                    "SELECT cpros, pcuss, pesoms, pftios, moecs, moepcs, moevs, moecusfs, mftios, " + ;
                    "fcustos, moedas, cftios, pvens, pvideals, encargos, margems " + ;
                    "FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCproAtual), "cursor_4c_ProdutoAtual")

                IF !USED("cursor_4c_ProdutoAtual") OR EOF("cursor_4c_ProdutoAtual")
                    THIS.this_cMensagemErro = "Produto " + loc_cCproAtual + " n" + CHR(227) + "o encontrado."
                    loc_lOk = .F.
                    EXIT
                ENDIF

                *-- 2) Snapshot de historico (SigCdPrc) com os valores ANTIGOS, ANTES do recalculo
                loc_cIdChavesHistorico = fUniqueIds()
                loc_cHoraAtual = SUBSTR(TTOC(DATETIME()), 10, 8)
                loc_cOrigem    = LEFT(TTOC(DATETIME()) + " SIGALTPC", 30)

                TEXT TO loc_cSQL TEXTMERGE NOSHOW
                    INSERT INTO SigCdPrc (
                        matprincs, dtcomps, cbars, cgrus, clfiscals, colecoes, comis, cpros, cunis, custofs,
                        cvens, datas, datatrans, descfis, dpros, dtfilms, fcustos, figjpgs, flagctabs, fvendas,
                        icms, ifors, linhas, locals, margems, moecs, moecusfs, moedas, moepcs, moepvs,
                        moevs, notas, obspeds, obspes, origmercs, pcuss, pesoms, pvens, pvideals, qmins,
                        reffs, sittricms, tcomps, tipos, transps, valors, varias, situas, dtincs, sgrus,
                        metals, teors, cftios, codservs, mftios, pftios, codcors, codtams, compos, montadescs,
                        digimaxs, ordcompos, ean13, cproeqs, qtdcpnts, impetiqs, chkfunds, casas, mercs, pesobs,
                        tamhs, tamls, tamps, tptribs, volumes, ipis, dpro2s, dsccompras, encoms, figtecs,
                        obscompras, codacbs, cravcers, cunips, obsetqs, ultcomps, vultcomps, multcomps, markupa, tinsts,
                        cclass, nivelqs, cftiocs, pftiocs, usuincs, diasinas, idecpros, fabrproprs, qtminfabs, tents,
                        codfinp, codmatp, dpro3s, consigs, ltminsv, status, aliqipis, codgarras, descecfs, encargos,
                        idpro, nidentfixa, pesobris, pesometal, pesopdrs, extipi, iats, contaccus, gruccus, dtsituas,
                        conjunts,
                        cidchaves, dataalts, horaalts, usuaalts, origem,
                        codcpds, cbms, caracts, cunifors, custocvs, ltmins, markcvs, pesomts, pidealcvs, qtdias,
                        retiras, codccnjs, montagens, tmontas, codconc
                    )
                    SELECT
                        matprincs, dtcomps, cbars, cgrus, clfiscals, colecoes, comis, cpros, cunis, custofs,
                        cvens, datas, datatrans, descfis, dpros, dtfilms, fcustos, figjpgs, flagctabs, fvendas,
                        icms, ifors, linhas, locals, margems, moecs, moecusfs, moedas, moepcs, moepvs,
                        moevs, notas, obspeds, obspes, origmercs, pcuss, pesoms, pvens, pvideals, qmins,
                        reffs, sittricms, tcomps, tipos, transps, valors, varias, situas, dtincs, sgrus,
                        metals, teors, cftios, codservs, mftios, pftios, codcors, codtams, compos, montadescs,
                        digimaxs, ordcompos, ean13, cproeqs, qtdcpnts, impetiqs, chkfunds, casas, mercs, pesobs,
                        tamhs, tamls, tamps, tptribs, volumes, ipis, dpro2s, dsccompras, encoms, figtecs,
                        obscompras, codacbs, cravcers, cunips, obsetqs, ultcomps, vultcomps, multcomps, markupa, tinsts,
                        cclass, nivelqs, cftiocs, pftiocs, usuincs, diasinas, idecpros, fabrproprs, qtminfabs, tents,
                        codfinp, codmatp, dpro3s, consigs, ltminsv, status, aliqipis, codgarras, descecfs, encargos,
                        idpro, nidentfixa, pesobris, pesometal, pesopdrs, extipi, iats, contaccus, gruccus, dtsituas,
                        conjunts,
                        <<EscaparSQL(loc_cIdChavesHistorico)>>, GETDATE(), <<EscaparSQL(loc_cHoraAtual)>>, <<EscaparSQL(gc_4c_UsuarioLogado)>>, <<EscaparSQL(loc_cOrigem)>>,
                        <<EscaparSQL("")>>, <<FormatarNumeroSQL(0, 6)>>, <<EscaparSQL("")>>, <<EscaparSQL("")>>, <<FormatarNumeroSQL(0, 3)>>, <<FormatarNumeroSQL(0, 3)>>, <<FormatarNumeroSQL(0, 6)>>, <<FormatarNumeroSQL(0, 3)>>, <<FormatarNumeroSQL(0, 2)>>, <<FormatarNumeroSQL(0, 0)>>,
                        <<FormatarNumeroSQL(0, 0)>>, <<EscaparSQL("")>>, <<FormatarNumeroSQL(0, 0)>>, <<EscaparSQL("")>>, <<EscaparSQL("")>>
                    FROM SigCdPro WHERE cpros = <<EscaparSQL(loc_cCproAtual)>>
                ENDTEXT

                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                    THIS.this_cMensagemErro = "Falha ao gravar hist" + CHR(243) + "rico de pre" + CHR(231) + "o (SigCdPrc):" + ;
                        CHR(13) + CapturarErroSQL()
                    loc_lOk = .F.
                    EXIT
                ENDIF

                *-- 3) Recalcula o novo preco conforme o tipo de reajuste - cada variavel
                *--    parte do valor ATUAL (sem alteracao) e so o Do Case sobrescreve
                loc_nPVensNovo    = cursor_4c_ProdutoAtual.pvens
                loc_nPCussNovo    = cursor_4c_ProdutoAtual.pcuss
                loc_nCustoFsNovo  = cursor_4c_ProdutoAtual.custofs
                loc_nMargemNovo   = cursor_4c_ProdutoAtual.margems
                loc_nPVIdealsNovo = cursor_4c_ProdutoAtual.pvideals
                loc_nFCustosNovo  = cursor_4c_ProdutoAtual.fcustos
                loc_cMoePcsNovo   = ALLTRIM(TratarNulo(cursor_4c_ProdutoAtual.moepcs, ""))

                DO CASE
                CASE THIS.this_nTipo = 1
                    loc_nPVensNovo = cursor_4c_ProdutoAtual.pvens + ((cursor_4c_ProdutoAtual.pvens * THIS.this_nVariacao) / 100)
                    IF THIS.this_lIncCusts
                        loc_nPCussNovo   = cursor_4c_ProdutoAtual.pcuss + ((cursor_4c_ProdutoAtual.pcuss * THIS.this_nVariacao) / 100)
                        loc_nCustoFsNovo = cursor_4c_ProdutoAtual.custofs + ((cursor_4c_ProdutoAtual.custofs * THIS.this_nVariacao) / 100)
                    ENDIF
                CASE THIS.this_nTipo = 2
                    loc_nMargemNovo   = THIS.this_nMarkUp2
                    loc_nPVIdealsNovo = THIS.CalcPreco(loc_nMargemNovo, "cursor_4c_ProdutoAtual")
                    loc_nPVensNovo    = loc_nPVIdealsNovo
                    loc_nFCustosNovo  = TratarNulo(cursor_4c_Produtos.fCustos, 0)
                    loc_cMoePcsNovo   = ALLTRIM(TratarNulo(cursor_4c_Produtos.MoePcs, ""))
                    loc_nCustoFsNovo  = TratarNulo(cursor_4c_Produtos.CustoFs, 0)
                CASE THIS.this_nTipo = 3
                    loc_nCotIdeal   = THIS.ObterCotacaoResolvida(cursor_4c_ProdutoAtual.moedas)
                    loc_nCotVenda   = THIS.ObterCotacaoResolvida(cursor_4c_ProdutoAtual.moevs)
                    loc_nPVenCambio = cursor_4c_ProdutoAtual.pvideals * loc_nCotIdeal / loc_nCotVenda
                    loc_nPVensNovo  = loc_nPVenCambio / IIF(cursor_4c_ProdutoAtual.encargos <> 0, cursor_4c_ProdutoAtual.encargos, 1)
                ENDCASE

                *-- Valor Atual informado manualmente na grade prevalece sobre o calculo
                IF TratarNulo(cursor_4c_Produtos.Manual, 0) = 1
                    loc_nPVensNovo = cursor_4c_Produtos.ValAtu
                ENDIF

                *-- Overrides de moeda/feitio de gravacao (campos vazios preservam o atual)
                loc_cMoeCsNovo    = IIF(EMPTY(ALLTRIM(THIS.this_cMoeCs)),    ALLTRIM(TratarNulo(cursor_4c_ProdutoAtual.moecs, "")),    ALLTRIM(THIS.this_cMoeCs))
                loc_cMoeCusFsNovo = IIF(EMPTY(ALLTRIM(THIS.this_cMoeCusFs)), ALLTRIM(TratarNulo(cursor_4c_ProdutoAtual.moecusfs, "")), ALLTRIM(THIS.this_cMoeCusFs))
                loc_cMoedasNovo   = IIF(EMPTY(ALLTRIM(THIS.this_cMoedas)),   ALLTRIM(TratarNulo(cursor_4c_ProdutoAtual.moedas, "")),   ALLTRIM(THIS.this_cMoedas))
                loc_cCFtiosNovo   = IIF(EMPTY(ALLTRIM(THIS.this_cCFtios)),   ALLTRIM(TratarNulo(cursor_4c_ProdutoAtual.cftios, "")),   ALLTRIM(THIS.this_cCFtios))
                loc_cMoeVsNovo    = IIF(EMPTY(ALLTRIM(THIS.this_cMoeVs)),    ALLTRIM(TratarNulo(cursor_4c_ProdutoAtual.moevs, "")),    ALLTRIM(THIS.this_cMoeVs))

                *-- 4) Recalcula o MarkUp Aplicado (Calcmarkpa) com os valores NOVOS
                loc_nCotIdeal = THIS.ObterCotacaoResolvida(loc_cMoeVsNovo)
                loc_nCotVenda = THIS.ObterCotacaoResolvida(loc_cMoeCusFsNovo)
                loc_nMarkupA  = IIF(loc_nCustoFsNovo = 0, 0, ROUND((loc_nPVensNovo * loc_nCotIdeal) / (loc_nCustoFsNovo * loc_nCotVenda), 3))

                *-- 5) Grava o novo preco em SigCdPro
                TEXT TO loc_cSQL TEXTMERGE NOSHOW
                    UPDATE SigCdPro SET
                        pvens    = <<FormatarNumeroSQL(loc_nPVensNovo, 5)>>,
                        pcuss    = <<FormatarNumeroSQL(loc_nPCussNovo, 5)>>,
                        custofs  = <<FormatarNumeroSQL(loc_nCustoFsNovo, 3)>>,
                        margems  = <<FormatarNumeroSQL(loc_nMargemNovo, 6)>>,
                        pvideals = <<FormatarNumeroSQL(loc_nPVIdealsNovo, 5)>>,
                        fcustos  = <<FormatarNumeroSQL(loc_nFCustosNovo, 5)>>,
                        moepcs   = <<EscaparSQL(loc_cMoePcsNovo)>>,
                        impetiqs = <<FormatarNumeroSQL(IIF(THIS.this_lImprimirEtiquetas, 1, 0), 0)>>,
                        moecs    = <<EscaparSQL(loc_cMoeCsNovo)>>,
                        moecusfs = <<EscaparSQL(loc_cMoeCusFsNovo)>>,
                        moedas   = <<EscaparSQL(loc_cMoedasNovo)>>,
                        cftios   = <<EscaparSQL(loc_cCFtiosNovo)>>,
                        moevs    = <<EscaparSQL(loc_cMoeVsNovo)>>,
                        markupa  = <<FormatarNumeroSQL(loc_nMarkupA, 3)>>
                    WHERE cpros = <<EscaparSQL(loc_cCproAtual)>>
                ENDTEXT

                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                    THIS.this_cMensagemErro = "Falha ao atualizar pre" + CHR(231) + "o do produto " + loc_cCproAtual + ;
                        ":" + CHR(13) + CapturarErroSQL()
                    loc_lOk = .F.
                    EXIT
                ENDIF

                THIS.this_cTabela   = "SigCdPro"
                THIS.this_cIdChaves = loc_cCproAtual
                THIS.RegistrarAuditoria("ATUALIZAR")
                THIS.this_cTabela   = "SigPrPmi"

                *-- 6) Historico de composicao (SigPrCp2), copiado de SigPrCpo
                IF !THIS.GravarHistoricoComposicao(loc_cCproAtual)
                    loc_lOk = .F.
                    EXIT
                ENDIF

                *-- 7) Remove vinculo de portal/etiqueta anterior (SigPrPrt)
                IF SQLEXEC(gnConnHandle, "DELETE FROM SigPrPrt WHERE cpros = " + EscaparSQL(loc_cCproAtual)) < 0
                    THIS.this_cMensagemErro = "Falha ao limpar SigPrPrt do produto " + loc_cCproAtual + ":" + ;
                        CHR(13) + CapturarErroSQL()
                    loc_lOk = .F.
                    EXIT
                ENDIF

                *-- 8) Limpa promocoes anteriores, se solicitado
                IF THIS.this_lLimparPromos
                    IF SQLEXEC(gnConnHandle, "DELETE FROM SigPrPmi WHERE cpros = " + EscaparSQL(loc_cCproAtual)) < 0
                        THIS.this_cMensagemErro = "Falha ao limpar promo" + CHR(231) + CHR(245) + "es do produto " + ;
                            loc_cCproAtual + ":" + CHR(13) + CapturarErroSQL()
                        loc_lOk = .F.
                        EXIT
                    ENDIF
                ENDIF

                *-- 9) Vincula a nova promocao, se informada e ainda nao vinculada a este produto
                IF !EMPTY(ALLTRIM(THIS.this_cPromo))
                    IF USED("cursor_4c_PmiExiste")
                        USE IN cursor_4c_PmiExiste
                    ENDIF
                    SQLEXEC(gnConnHandle, "SELECT cidchaves FROM SigPrPmi WHERE cpros = " + EscaparSQL(loc_cCproAtual) + ;
                        " AND promos = " + EscaparSQL(THIS.this_cPromo), "cursor_4c_PmiExiste")

                    IF USED("cursor_4c_PmiExiste") AND EOF("cursor_4c_PmiExiste")
                        THIS.this_cCpros    = loc_cCproAtual
                        THIS.this_cIdChaves = ""
                        IF !THIS.Inserir()
                            loc_lOk = .F.
                        ENDIF
                    ENDIF
                    IF USED("cursor_4c_PmiExiste")
                        USE IN cursor_4c_PmiExiste
                    ENDIF
                    IF !loc_lOk
                        EXIT
                    ENDIF
                ENDIF

                loc_nQtdeProcessados = loc_nQtdeProcessados + 1
                SELECT cursor_4c_Produtos
            ENDSCAN

            IF USED("cursor_4c_ProdutoAtual")
                USE IN cursor_4c_ProdutoAtual
            ENDIF

            IF loc_lOk AND loc_nQtdeProcessados > 0
                SQLCOMMIT(gnConnHandle)
                loc_lSucesso = .T.
            ELSE
                SQLROLLBACK(gnConnHandle)
                IF EMPTY(THIS.this_cMensagemErro)
                    THIS.this_cMensagemErro = "Nenhum produto foi atualizado."
                ENDIF
                loc_lSucesso = .F.
            ENDIF

        CATCH TO loc_oErro
            SQLROLLBACK(gnConnHandle)
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Destroy - Libera os cursores de trabalho abertos por este BO
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_Produtos")
            USE IN cursor_4c_Produtos
        ENDIF
        IF USED("cursor_4c_SigCdPam")
            USE IN cursor_4c_SigCdPam
        ENDIF
        IF USED("cursor_4c_SigCdPac")
            USE IN cursor_4c_SigCdPac
        ENDIF
        IF USED("cursor_4c_Cotacao")
            USE IN cursor_4c_Cotacao
        ENDIF
        IF USED("cursor_4c_MoedaCot")
            USE IN cursor_4c_MoedaCot
        ENDIF
        IF USED("cursor_4c_ProdutoAtual")
            USE IN cursor_4c_ProdutoAtual
        ENDIF
        IF USED("cursor_4c_ProdutoManual")
            USE IN cursor_4c_ProdutoManual
        ENDIF
        IF USED("cursor_4c_ComposicaoAtual")
            USE IN cursor_4c_ComposicaoAtual
        ENDIF
        IF USED("cursor_4c_PmiExiste")
            USE IN cursor_4c_PmiExiste
        ENDIF
        IF USED("cursor_4c_ProdutosOrigem")
            USE IN cursor_4c_ProdutosOrigem
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE

