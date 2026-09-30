*==============================================================================
* FormSigPrCcc.prg - Recalculo de Saldos (SIGPRCCC)
* Tipo: OPERACIONAL - layout flat customizado (sem PageFrame)
* Migrado de: SIGPRCCC.SCX
* Fase 8/8: Form COMPLETO - eventos principais, eventos auxiliares e
*           consolidacao final
*
* Processo em lote com 4 frentes autonomas de recalculo, cada uma
* filtrada pelos campos do respectivo container flutuante:
*   - cnt_4c_OpConta   (Conta Corrente)
*   - cnt_4c_OpEstoque (Estoque)
*   - cnt_4c_OpCusto   (Custo de Produto)   - campos criados nesta fase
*   - cnt_4c_OpCompra  (Ultima Compra)      - campos criados nesta fase
* Os quatro comecam ocultos (Visible=.F.), exatamente como no legado, e
* sao exibidos/expandidos (com a mesma animacao de Width do legado) pelos
* checkboxes chk_4c_Conta/Estoque/BtnCusto/BtnCompra (Fase 4).
*
* Lookups (Fase 6), todos via AbrirLookupCanonico (FormBase - Pattern A
* seguro, NUNCA o Pattern B defeituoso "CREATEOBJECT com 2+ args"):
*   - Empresa (SigCdEmp.Cemps/Razas)     - nos 4 containers
*   - Grupo   (SigCdGcr.Codigos/Descrs)  - OpConta/OpEstoque (substitui
*     fAcessoContab, banido como handler de UI - so exato + picker canonico)
*   - Conta/Estoque (SigCdCli.IClis/RClis, filtrado por Grupo) - OpConta e
*     OpEstoque (substitui fAcessoContas, banido como handler de UI)
*   - Moeda   (SigCdMoe.Cmoes/Dmoes)     - OpConta
*   - Produto/Descricao (SigCdPro.CPros/DPros, bidirecional) - OpEstoque/
*     OpCusto/OpCompra
* Cada campo tem KeyPress (Enter/Tab valida por igualdade exata e so abre o
* picker se nao achar; F4 sempre abre direto) e DblClick (sempre abre).
*
* O botao cmd_4c_Processa nasce Enabled=.F. e so eh habilitado quando algum
* checkbox eh marcado. O Click dele (BtnProcessarClick, Fase 7) transcreve o
* Processa.Click do legado (556 linhas): trava a tela, roda as frentes
* MARCADAS na ordem Conta -> Estoque -> Custo -> Ultima Compra delegando cada
* uma ao metodo correspondente do BO (RecalcularContaCorrente /
* RecalcularEstoque / RecalcularCustoProduto / AtualizarUltimaCompra, onde
* moram o SQL, os cursores temporarios, fRecalculaS/P/C e o fwprogressbar),
* destrava a tela em QUALQUER saida e exibe o "Processamento Concluido".
* cmd_4c_Cancela.Click eh definitivo desde a Fase 4 (THIS.Release(),
* identico ao legado "ThisForm.Release").
*
* Fase 8 - eventos auxiliares fechados nesta fase (os dois "When" do SCX, que
* nao existiam no migrado e nao se migram por BINDEVENT, porque o VFP descarta
* o retorno do delegate):
*   - SIGPRCCC.Get_Registro.When ("Return .f.") -> txt_4c_Registro nasce
*     .ReadOnly = .T. / .TabStop = .F. (contador de progresso, escrito so por
*     AtualizarContadorRegistros).
*   - SIGPRCCC.Op{Estoque,Custo,Compra}.Get_Descs.When
*     ("Return(Empty(This.Parent.Get_Produto.Value))") -> AplicarWhenDescricao,
*     chamada no InicializarForm, nos dois helpers de lookup de produto e no
*     InteractiveChange do respectivo txt_4c_Produto.
*
*==============================================================================
* DISPOSICAO DOS NOMES CANONICOS DE CRUD (nenhum se aplica a esta tela)
*==============================================================================
* Este form NAO tem CRUD: o legado (SIGPRCCC, Class: form puro) nao herda de
* frmcadastro, nao tem Grupo_Op nem botao Incluir/Alterar/Visualizar/Excluir
* - tem 2 CommandButton (Processa/Cancela) e 4 CheckBox de toggle. Nao
* existe BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick
* a migrar, e inventa-los violaria o PILAR 1. Pelo mesmo motivo:
*
*   - BtnBuscarClick / AjustarBotoesPorModo / HabilitarCampos / LimparCampos:
*     nao ha modo LISTA/INCLUIR/ALTERAR/VISUALIZAR nesta tela. O unico estado
*     que muda eh "lote rodando x lote parado", e ele ja tem metodo proprio -
*     HabilitarControlesProcessamento(.T./.F.), que eh a transcricao literal
*     do par de blocos "With Thisform / .Conta.Enabled = ..." do
*     Processa.Click. O unico botao com habilitacao condicional eh o
*     Processar, tratado por AtualizarEstadoProcessar.
*   - CarregarLista: o SCX nao tem UM grid (layout.json: zero objeto de
*     BaseClass grid; 59 objetos, todos label/textbox/checkbox/commandbutton/
*     container/shape). Nao ha lista para carregar. O AddCursor do Init legado
*     ('SigOpClU','CidChaves','CrSigOpClU') NAO eh grade: eh a tabela de apoio
*     em que a frente "Ultima Compra" grava os valores recalculados antes de
*     aplica-los, e vive no BO (GravarApoioUltimaCompra/AplicarTopoSigOpClU).
*   - BOParaForm: o sentido dele eh trazer um REGISTRO do BO de volta para a
*     ficha. Aqui nao ha registro em edicao - os campos sao FILTROS do lote, o
*     trafego eh so num sentido (FormParaBO, chamado no inicio do Processar) e
*     o legado nunca escreve de volta nesses campos. O unico retorno do BO
*     para a tela durante o processamento eh o contador de registros, que ja
*     chega por AtualizarContadorRegistros (chamado pelo BO, por isso PUBLIC).
*   - BtnSalvarClick: nao existe botao de gravar no SCX. A gravacao eh o
*     resultado do lote e acontece dentro do BO.
*
* Load legado ("=fConfigGeral()") NAO PORTADO, pelo mesmo motivo ja registrado
* em FormSigMvExp.prg (task570): fConfigGeral era rotina de inicializacao
* GLOBAL da aplicacao legado, nao comportamento desta tela. O que ela
* preparava e que esta tela realmente usa sao os parametros de SigCdPam, hoje
* carregados no SigPrCccBO.Init (gruporecs/grupopags/contarecs/contapags/
* moecentral), equivalente ao CursorQuery('SigCdPam','CrSigCdPam',...) que o
* Init legado fazia logo depois.
*==============================================================================

DEFINE CLASS FormSigPrCcc AS FormBase

    *-- Propriedades visuais (copiadas exatamente do original)
    Height       = 600
    Width        = 800
    Caption      = "Rec" + CHR(225) + "lculo de Saldos"
    AutoCenter   = .T.
    BorderStyle  = 2
    TitleBar     = 0
    DataSession  = 2
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    ClipControls = .F.
    ShowTips     = .T.
    KeyPreview   = .T.

    *-- Estado / Negocio
    this_oBusinessObject = .NULL.
    this_cMensagemErro   = ""

    *-- Larguras-alvo dos containers flutuantes (capturadas apos cria-los,
    *-- espelha "ThisForm.LarguraOpX = Thisform.OpX.Width" do Init legado)
    this_nLarguraOpConta   = 0
    this_nLarguraOpEstoque = 0
    this_nLarguraOpCusto   = 0
    this_nLarguraOpCompra  = 0

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        *-- FormBase.Init() ja chama THIS.InicializarForm() e ja corrige
        *-- SET DATE/CENTURY para DataSession=2 (regra 9.4) - nao duplicar aqui
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrCccBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigPrCcc.", "Erro")
            ELSE
                *-- Montar interface visual (estrutura base)
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarContainersOperacao()
                THIS.ConfigurarCamposOpConta()
                THIS.ConfigurarCamposOpEstoque()
                THIS.ConfigurarCamposOpCusto()
                THIS.ConfigurarCamposOpCompra()

                *-- Capturar largura-alvo de cada container (para a animacao
                *-- de expandir/recolher nos checkboxes de toggle)
                THIS.this_nLarguraOpConta   = THIS.cnt_4c_OpConta.Width
                THIS.this_nLarguraOpEstoque = THIS.cnt_4c_OpEstoque.Width
                THIS.this_nLarguraOpCusto   = THIS.cnt_4c_OpCusto.Width
                THIS.this_nLarguraOpCompra  = THIS.cnt_4c_OpCompra.Width

                THIS.ConfigurarBotoesAcao()
                THIS.ConfigurarCheckboxesToggle()
                THIS.ConfigurarControlesStatus()

                *-- Propagar titulo para os labels do cabecalho
                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

                THIS.TornarControlesVisiveis(THIS)

                *-- LblEnd so aparece ao final do Processar (Fase de bindings) -
                *-- TornarControlesVisiveis nao pode deixa-lo visivel agora
                THIS.lbl_4c_LblEnd.Visible = .F.

                *-- Estado inicial do When do Get_Descs nos tres containers que
                *-- tem Produto+Descricao (a tela abre com os dois em branco,
                *-- logo a Descricao comeca digitavel - igual ao legado)
                THIS.AplicarWhenDescricao(THIS.cnt_4c_OpEstoque)
                THIS.AplicarWhenDescricao(THIS.cnt_4c_OpCusto)
                THIS.AplicarWhenDescricao(THIS.cnt_4c_OpCompra)

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "Erro FormSigPrCcc.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - OPERACIONAL: sem PageFrame, fundo via Picture
    * (layout flat identico ao legado - cntSombra + containers flutuantes
    * direto no Form, sem Page1/Page2 do padrao CRUD)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame
        THIS.Picture      = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
        THIS.ClipControls = .F.
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Container escuro com titulo (cntSombra original)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .BackStyle   = 1

            .AddObject("lbl_4c_LblSombra", "Label")
            WITH .lbl_4c_LblSombra
                .AutoSize  = .F.
                .BackStyle = 0
                .Caption   = ""
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .ForeColor = RGB(0, 0, 0)
                .Height    = 40
                .Left      = 10
                .Top       = 18
                .Width     = THIS.Width
                .WordWrap  = .T.
                .Alignment = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_LblTitulo", "Label")
            WITH .lbl_4c_LblTitulo
                .AutoSize    = .F.
                .BackStyle   = 0
                .Caption     = ""
                .FontBold    = .T.
                .FontName    = "Tahoma"
                .FontSize    = 18
                .ForeColor   = RGB(255, 255, 255)
                .Height      = 46
                .Left        = 10
                .Top         = 17
                .Width       = THIS.Width
                .WordWrap    = .T.
                .Alignment   = 0
                .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
                .Visible     = .T.
            ENDWITH

            .Visible = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarContainersOperacao - Cria os 4 containers flutuantes das
    * frentes de recalculo (Conta/Estoque/Custo/Compra), todos ocultos por
    * padrao - exatamente como no legado (BackStyle=0, BorderWidth=2,
    * SpecialEffect=2, BorderColor cinza, Visible=.F.). Campos internos
    * (Empresa/Grupo/Produto/Descricao/Data) entram nas Fases 5/6.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainersOperacao
        THIS.AddObject("cnt_4c_OpConta", "Container")
        WITH THIS.cnt_4c_OpConta
            .Top           = 114
            .Left          = 139
            .Width         = 536
            .Height        = 81
            .BackStyle     = 0
            .BorderWidth   = 2
            .SpecialEffect = 2
            .BackColor     = RGB(192, 192, 255)
            .BorderColor   = RGB(90, 90, 90)
            .Enabled       = .F.
            .Visible       = .F.
        ENDWITH

        THIS.AddObject("cnt_4c_OpEstoque", "Container")
        WITH THIS.cnt_4c_OpEstoque
            .Top           = 200
            .Left          = 139
            .Width         = 536
            .Height        = 143
            .BackStyle     = 0
            .BorderWidth   = 2
            .SpecialEffect = 2
            .BackColor     = RGB(192, 192, 255)
            .BorderColor   = RGB(90, 90, 90)
            .Enabled       = .F.
            .Visible       = .F.
        ENDWITH

        THIS.AddObject("cnt_4c_OpCusto", "Container")
        WITH THIS.cnt_4c_OpCusto
            .Top           = 349
            .Left          = 139
            .Width         = 536
            .Height        = 92
            .BackStyle     = 0
            .BorderWidth   = 2
            .SpecialEffect = 2
            .BackColor     = RGB(192, 192, 255)
            .BorderColor   = RGB(90, 90, 90)
            .Enabled       = .F.
            .Visible       = .F.
        ENDWITH

        THIS.AddObject("cnt_4c_OpCompra", "Container")
        WITH THIS.cnt_4c_OpCompra
            .Top           = 447
            .Left          = 139
            .Width         = 536
            .Height        = 91
            .BackStyle     = 0
            .BorderWidth   = 2
            .SpecialEffect = 2
            .BackColor     = RGB(192, 192, 255)
            .BorderColor   = RGB(90, 90, 90)
            .Enabled       = .F.
            .Visible       = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarCamposOpConta - Campos internos do container Conta Corrente
    * (Fase 5/8 - primeira metade dos containers: OpConta + OpEstoque).
    * Coordenadas RELATIVAS ao container (top/left do layout.json), copiadas
    * do SCX legado. Ainda sem Valid/lookup (fAcessoContas/fAcessoContab/
    * fwBuscaExt) - entram na fase de eventos.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposOpConta
        WITH THIS.cnt_4c_OpConta

            .AddObject("lbl_4c_Label2", "Label")
            WITH .lbl_4c_Label2
                .Top       = 2
                .Left      = 171
                .Width     = 250
                .Height    = 15
                .AutoSize  = .F.
                .BackStyle = 0
                .Alignment = 0
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Op" + CHR(231) + CHR(245) + "es de Conta Corrente"
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Label15", "Label")
            WITH .lbl_4c_Label15
                .Top       = 23
                .Left      = 16
                .Width     = 57
                .Height    = 15
                .AutoSize  = .F.
                .BackStyle = 0
                .Alignment = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Empresa :"
                .Visible   = .T.
            ENDWITH

            .AddObject("txt_4c_Empresa", "TextBox")
            WITH .txt_4c_Empresa
                .Top       = 20
                .Left      = 75
                .Width     = 31
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 3
                .Value     = ""
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_LblGrupos", "Label")
            WITH .lbl_4c_LblGrupos
                .Top       = 24
                .Left      = 122
                .Width     = 42
                .Height    = 15
                .AutoSize  = .F.
                .BackStyle = 0
                .Alignment = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Grupo :"
                .Visible   = .T.
            ENDWITH

            .AddObject("txt_4c_TxtGrupos", "TextBox")
            WITH .txt_4c_TxtGrupos
                .Top       = 20
                .Left      = 166
                .Width     = 80
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 10
                .Value     = ""
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_LblContas", "Label")
            WITH .lbl_4c_LblContas
                .Top       = 24
                .Left      = 255
                .Width     = 41
                .Height    = 15
                .AutoSize  = .F.
                .BackStyle = 0
                .Alignment = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Conta :"
                .Visible   = .T.
            ENDWITH

            .AddObject("txt_4c_TxtContas", "TextBox")
            WITH .txt_4c_TxtContas
                .Top       = 20
                .Left      = 298
                .Width     = 80
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 10
                .Value     = ""
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_LblMoedas", "Label")
            WITH .lbl_4c_LblMoedas
                .Top       = 50
                .Left      = 27
                .Width     = 46
                .Height    = 15
                .AutoSize  = .F.
                .BackStyle = 0
                .Alignment = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Moeda :"
                .Visible   = .T.
            ENDWITH

            .AddObject("txt_4c_TxtMoedas", "TextBox")
            WITH .txt_4c_TxtMoedas
                .Top       = 46
                .Left      = 75
                .Width     = 31
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 3
                .Value     = ""
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_LblData", "Label")
            WITH .lbl_4c_LblData
                .Top       = 50
                .Left      = 121
                .Width     = 68
                .Height    = 15
                .AutoSize  = .F.
                .BackStyle = 0
                .Alignment = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "A partir de :"
                .Visible   = .T.
            ENDWITH

            .AddObject("txt_4c_TxtData", "TextBox")
            WITH .txt_4c_TxtData
                .Top      = 46
                .Left     = 191
                .Width    = 80
                .Height   = 23
                .FontName = "Tahoma"
                .FontSize = 8
                .Value    = {}
                .Visible  = .T.
            ENDWITH

            *-- Lookups (Fase 6): Empresa (SigCdEmp), Grupo (SigCdGcr),
            *-- Conta (SigCdCli filtrado por Grupo) e Moeda (SigCdMoe)
            BINDEVENT(.txt_4c_Empresa, "KeyPress", THIS, "EmpresaContaKeyPress")
            BINDEVENT(.txt_4c_Empresa, "DblClick", THIS, "EmpresaContaDblClick")
            BINDEVENT(.txt_4c_TxtGrupos, "KeyPress", THIS, "GrupoContaKeyPress")
            BINDEVENT(.txt_4c_TxtGrupos, "DblClick", THIS, "GrupoContaDblClick")
            BINDEVENT(.txt_4c_TxtContas, "KeyPress", THIS, "ContaContaKeyPress")
            BINDEVENT(.txt_4c_TxtContas, "DblClick", THIS, "ContaContaDblClick")
            BINDEVENT(.txt_4c_TxtMoedas, "KeyPress", THIS, "MoedaContaKeyPress")
            BINDEVENT(.txt_4c_TxtMoedas, "DblClick", THIS, "MoedaContaDblClick")

        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarCamposOpEstoque - Campos internos do container Estoque
    * (Fase 5/8). Coordenadas RELATIVAS ao container, copiadas do SCX legado.
    * NOTA: o legado tem DOIS labels genericos "Label1" nesta pagina (Say1 =
    * "Estoque :" e Label1 = "Produto :") que colidiriam se nomeados pelo
    * mesmo padrao automatico (mapeamento.json os gerou ambos como
    * lbl_4c_Label1) - renomeados por CONTEUDO para lbl_4c_Estoque e
    * lbl_4c_Produto (regra CLAUDE.md "nomear pela ACAO/conteudo, nao pelo
    * nome generico do legado").
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposOpEstoque
        WITH THIS.cnt_4c_OpEstoque

            .AddObject("lbl_4c_Label2", "Label")
            WITH .lbl_4c_Label2
                .Top       = 2
                .Left      = 182
                .Width     = 200
                .Height    = 15
                .AutoSize  = .F.
                .BackStyle = 0
                .Alignment = 0
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Op" + CHR(231) + CHR(245) + "es de Estoque"
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Label15", "Label")
            WITH .lbl_4c_Label15
                .Top       = 15
                .Left      = 31
                .Width     = 57
                .Height    = 15
                .AutoSize  = .F.
                .BackStyle = 0
                .Alignment = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Empresa :"
                .Visible   = .T.
            ENDWITH

            .AddObject("txt_4c_Empresa", "TextBox")
            WITH .txt_4c_Empresa
                .Top       = 12
                .Left      = 90
                .Width     = 31
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 3
                .Value     = ""
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Estoque", "Label")
            WITH .lbl_4c_Estoque
                .Top       = 65
                .Left      = 35
                .Width     = 53
                .Height    = 15
                .AutoSize  = .F.
                .BackStyle = 0
                .Alignment = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Estoque :"
                .Visible   = .T.
            ENDWITH

            .AddObject("txt_4c_Estoque", "TextBox")
            WITH .txt_4c_Estoque
                .Top       = 62
                .Left      = 90
                .Width     = 80
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 10
                .Value     = ""
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_LblGrupos", "Label")
            WITH .lbl_4c_LblGrupos
                .Top       = 40
                .Left      = 46
                .Width     = 42
                .Height    = 15
                .AutoSize  = .F.
                .BackStyle = 0
                .Alignment = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Grupo :"
                .Visible   = .T.
            ENDWITH

            .AddObject("txt_4c_TxtGrupos", "TextBox")
            WITH .txt_4c_TxtGrupos
                .Top       = 37
                .Left      = 90
                .Width     = 80
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 10
                .Value     = ""
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_LblData", "Label")
            WITH .lbl_4c_LblData
                .Top       = 115
                .Left      = 20
                .Width     = 68
                .Height    = 15
                .AutoSize  = .F.
                .BackStyle = 0
                .Alignment = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "A partir de :"
                .Visible   = .T.
            ENDWITH

            .AddObject("txt_4c_TxtData", "TextBox")
            WITH .txt_4c_TxtData
                .Top      = 112
                .Left     = 90
                .Width    = 80
                .Height   = 23
                .FontName = "Tahoma"
                .FontSize = 8
                .Value    = {}
                .Visible  = .T.
            ENDWITH

            .AddObject("lbl_4c_Produto", "Label")
            WITH .lbl_4c_Produto
                .Top       = 90
                .Left      = 35
                .Width     = 53
                .Height    = 15
                .AutoSize  = .F.
                .BackStyle = 0
                .Alignment = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Produto :"
                .Visible   = .T.
            ENDWITH

            .AddObject("txt_4c_Produto", "TextBox")
            WITH .txt_4c_Produto
                .Top       = 87
                .Left      = 90
                .Width     = 108
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 14
                .Value     = ""
                .Visible   = .T.
            ENDWITH

            .AddObject("txt_4c_Descricao", "TextBox")
            WITH .txt_4c_Descricao
                .Top       = 87
                .Left      = 199
                .Width     = 327
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 65
                .Value     = ""
                .Visible   = .T.
            ENDWITH

            *-- Lookups (Fase 6): Empresa (SigCdEmp), Grupo (SigCdGcr),
            *-- Estoque=Conta (SigCdCli filtrado por Grupo) e Produto/Descricao
            *-- (SigCdPro, bidirecional)
            BINDEVENT(.txt_4c_Empresa, "KeyPress", THIS, "EmpresaEstoqueKeyPress")
            BINDEVENT(.txt_4c_Empresa, "DblClick", THIS, "EmpresaEstoqueDblClick")
            BINDEVENT(.txt_4c_TxtGrupos, "KeyPress", THIS, "GrupoEstoqueKeyPress")
            BINDEVENT(.txt_4c_TxtGrupos, "DblClick", THIS, "GrupoEstoqueDblClick")
            BINDEVENT(.txt_4c_Estoque, "KeyPress", THIS, "EstoqueKeyPress")
            BINDEVENT(.txt_4c_Estoque, "DblClick", THIS, "EstoqueDblClick")
            BINDEVENT(.txt_4c_Produto, "KeyPress", THIS, "ProdutoEstoqueKeyPress")
            BINDEVENT(.txt_4c_Produto, "DblClick", THIS, "ProdutoEstoqueDblClick")
            *-- InteractiveChange: reavalia a cada tecla o When do Get_Descs
            *-- legado (Descricao so digitavel com o Produto em branco)
            BINDEVENT(.txt_4c_Produto, "InteractiveChange", THIS, "ProdutoEstoqueInteractiveChange")
            BINDEVENT(.txt_4c_Descricao, "KeyPress", THIS, "DescricaoEstoqueKeyPress")
            BINDEVENT(.txt_4c_Descricao, "DblClick", THIS, "DescricaoEstoqueDblClick")

        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarCamposOpCusto - Campos internos do container Custo de Produto
    * (Fase 6/8). Coordenadas RELATIVAS ao container, copiadas do SCX legado
    * (layout.json: cnt_4c_OpCusto). Mesmo padrao de OpEstoque, sem o campo
    * Estoque (nao existe nesta frente de recalculo).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposOpCusto
        WITH THIS.cnt_4c_OpCusto

            .AddObject("lbl_4c_Label2", "Label")
            WITH .lbl_4c_Label2
                .Top       = 2
                .Left      = 155
                .Width     = 250
                .Height    = 15
                .AutoSize  = .F.
                .BackStyle = 0
                .Alignment = 0
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Op" + CHR(231) + CHR(245) + "es de Custo de Produto"
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Label15", "Label")
            WITH .lbl_4c_Label15
                .Top       = 14
                .Left      = 31
                .Width     = 57
                .Height    = 15
                .AutoSize  = .F.
                .BackStyle = 0
                .Alignment = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Empresa :"
                .Visible   = .T.
            ENDWITH

            .AddObject("txt_4c_Empresa", "TextBox")
            WITH .txt_4c_Empresa
                .Top       = 11
                .Left      = 90
                .Width     = 31
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 3
                .Value     = ""
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_LblData", "Label")
            WITH .lbl_4c_LblData
                .Top       = 64
                .Left      = 20
                .Width     = 68
                .Height    = 15
                .AutoSize  = .F.
                .BackStyle = 0
                .Alignment = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "A partir de :"
                .Visible   = .T.
            ENDWITH

            .AddObject("txt_4c_TxtData", "TextBox")
            WITH .txt_4c_TxtData
                .Top      = 61
                .Left     = 90
                .Width    = 80
                .Height   = 23
                .FontName = "Tahoma"
                .FontSize = 8
                .Value    = {}
                .Visible  = .T.
            ENDWITH

            .AddObject("lbl_4c_Label1", "Label")
            WITH .lbl_4c_Label1
                .Top       = 39
                .Left      = 35
                .Width     = 53
                .Height    = 15
                .AutoSize  = .F.
                .BackStyle = 0
                .Alignment = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Produto :"
                .Visible   = .T.
            ENDWITH

            .AddObject("txt_4c_Produto", "TextBox")
            WITH .txt_4c_Produto
                .Top       = 36
                .Left      = 90
                .Width     = 108
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 14
                .Value     = ""
                .Visible   = .T.
            ENDWITH

            .AddObject("txt_4c_Descricao", "TextBox")
            WITH .txt_4c_Descricao
                .Top       = 36
                .Left      = 199
                .Width     = 327
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 65
                .Value     = ""
                .Visible   = .T.
            ENDWITH

            *-- Lookups (Fase 6): Empresa (SigCdEmp) e Produto/Descricao
            *-- (SigCdPro, bidirecional)
            BINDEVENT(.txt_4c_Empresa, "KeyPress", THIS, "EmpresaCustoKeyPress")
            BINDEVENT(.txt_4c_Empresa, "DblClick", THIS, "EmpresaCustoDblClick")
            BINDEVENT(.txt_4c_Produto, "KeyPress", THIS, "ProdutoCustoKeyPress")
            BINDEVENT(.txt_4c_Produto, "DblClick", THIS, "ProdutoCustoDblClick")
            *-- InteractiveChange: reavalia a cada tecla o When do Get_Descs
            *-- legado (Descricao so digitavel com o Produto em branco)
            BINDEVENT(.txt_4c_Produto, "InteractiveChange", THIS, "ProdutoCustoInteractiveChange")
            BINDEVENT(.txt_4c_Descricao, "KeyPress", THIS, "DescricaoCustoKeyPress")
            BINDEVENT(.txt_4c_Descricao, "DblClick", THIS, "DescricaoCustoDblClick")

        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarCamposOpCompra - Campos internos do container Ultima Compra
    * do Produto/Cliente (Fase 6/8). Coordenadas RELATIVAS ao container,
    * copiadas do SCX legado (layout.json: cnt_4c_OpCompra). Mesmo padrao de
    * OpCusto (Empresa + Produto/Descricao, sem campo Estoque).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposOpCompra
        WITH THIS.cnt_4c_OpCompra

            .AddObject("lbl_4c_Label2", "Label")
            WITH .lbl_4c_Label2
                .Top       = 2
                .Left      = 140
                .Width     = 300
                .Height    = 15
                .AutoSize  = .F.
                .BackStyle = 0
                .Alignment = 0
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Op" + CHR(231) + CHR(245) + "es de " + CHR(218) + "ltima Compra do Produto/Cliente"
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Label15", "Label")
            WITH .lbl_4c_Label15
                .Top       = 14
                .Left      = 31
                .Width     = 57
                .Height    = 15
                .AutoSize  = .F.
                .BackStyle = 0
                .Alignment = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Empresa :"
                .Visible   = .T.
            ENDWITH

            .AddObject("txt_4c_Empresa", "TextBox")
            WITH .txt_4c_Empresa
                .Top       = 10
                .Left      = 90
                .Width     = 31
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 3
                .Value     = ""
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_LblData", "Label")
            WITH .lbl_4c_LblData
                .Top       = 64
                .Left      = 20
                .Width     = 68
                .Height    = 15
                .AutoSize  = .F.
                .BackStyle = 0
                .Alignment = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "A partir de :"
                .Visible   = .T.
            ENDWITH

            .AddObject("txt_4c_TxtData", "TextBox")
            WITH .txt_4c_TxtData
                .Top      = 60
                .Left     = 90
                .Width    = 80
                .Height   = 23
                .FontName = "Tahoma"
                .FontSize = 8
                .Value    = {}
                .Visible  = .T.
            ENDWITH

            .AddObject("lbl_4c_Label1", "Label")
            WITH .lbl_4c_Label1
                .Top       = 39
                .Left      = 35
                .Width     = 53
                .Height    = 15
                .AutoSize  = .F.
                .BackStyle = 0
                .Alignment = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Produto :"
                .Visible   = .T.
            ENDWITH

            .AddObject("txt_4c_Produto", "TextBox")
            WITH .txt_4c_Produto
                .Top       = 35
                .Left      = 90
                .Width     = 108
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 14
                .Value     = ""
                .Visible   = .T.
            ENDWITH

            .AddObject("txt_4c_Descricao", "TextBox")
            WITH .txt_4c_Descricao
                .Top       = 35
                .Left      = 199
                .Width     = 327
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 65
                .Value     = ""
                .Visible   = .T.
            ENDWITH

            *-- Lookups (Fase 6): Empresa (SigCdEmp) e Produto/Descricao
            *-- (SigCdPro, bidirecional)
            BINDEVENT(.txt_4c_Empresa, "KeyPress", THIS, "EmpresaCompraKeyPress")
            BINDEVENT(.txt_4c_Empresa, "DblClick", THIS, "EmpresaCompraDblClick")
            BINDEVENT(.txt_4c_Produto, "KeyPress", THIS, "ProdutoCompraKeyPress")
            BINDEVENT(.txt_4c_Produto, "DblClick", THIS, "ProdutoCompraDblClick")
            *-- InteractiveChange: reavalia a cada tecla o When do Get_Descs
            *-- legado (Descricao so digitavel com o Produto em branco)
            BINDEVENT(.txt_4c_Produto, "InteractiveChange", THIS, "ProdutoCompraInteractiveChange")
            BINDEVENT(.txt_4c_Descricao, "KeyPress", THIS, "DescricaoCompraKeyPress")
            BINDEVENT(.txt_4c_Descricao, "DblClick", THIS, "DescricaoCompraDblClick")

        ENDWITH
    ENDPROC

    *==========================================================================
    * MontarFiltroGrupo - monta o WHERE extra "Grupos = <valor>" usado nos
    * lookups de Conta/Estoque (SigCdCli), espelhando o filtro por grupo que
    * o legado aplicava via fAcessoContas(Usuar, txtGrupos.Value, ...).
    * Retorna "" quando o Grupo ainda nao foi preenchido (lista sem filtro).
    *==========================================================================
    PROTECTED PROCEDURE MontarFiltroGrupo(par_oTxtGrupo)
        LOCAL loc_cGrupo
        loc_cGrupo = ALLTRIM(par_oTxtGrupo.Value)
        IF EMPTY(loc_cGrupo)
            RETURN ""
        ENDIF
        RETURN "Grupos = " + EscaparSQL(loc_cGrupo)
    ENDPROC

    *==========================================================================
    * AbrirLookupSimples - abre o picker canonico (FormBuscaAuxiliar via
    * AbrirLookupCanonico, herdado de FormBase) SEM checagem previa - usado
    * por F4 e DblClick, que sempre abrem a busca (regra CLAUDE.md: "F4
    * sempre abre lookup direto").
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupSimples(par_oTxtCod, par_cTabela, par_cCampoCod, ;
            par_cCampoDesc, par_cTitulo, par_cFiltroExtra)
        THIS.AbrirLookupCanonico(par_cTabela, par_cCampoCod, par_cCampoDesc, ;
            par_cTitulo, ALLTRIM(par_oTxtCod.Value), par_oTxtCod, .NULL., par_cFiltroExtra)
    ENDPROC

    *==========================================================================
    * ValidarLookupSimples - usado por Enter/Tab: tenta achar o codigo digitado
    * por igualdade exata primeiro (equivalente ao Seek do legado); so abre o
    * picker se nao encontrar. Campo vazio nao valida (segue o legado, que so
    * dispara a busca com !Empty(This.Value)).
    *==========================================================================
    PROTECTED PROCEDURE ValidarLookupSimples(par_oTxtCod, par_cTabela, par_cCampoCod, ;
            par_cCampoDesc, par_cTitulo, par_cFiltroExtra)
        LOCAL loc_cValor, loc_nResult, loc_cCursor, loc_cSQL
        loc_cValor  = ALLTRIM(par_oTxtCod.Value)
        loc_cCursor = "cursor_4c_ChkLookup"

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        IF USED(loc_cCursor)
            USE IN SELECT(loc_cCursor)
        ENDIF
        loc_cSQL = "SELECT " + par_cCampoCod + " FROM " + par_cTabela + ;
            " WHERE " + par_cCampoCod + " = " + EscaparSQL(loc_cValor) + ;
            IIF(EMPTY(par_cFiltroExtra), "", " AND (" + par_cFiltroExtra + ")")
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

        IF loc_nResult > 0 AND USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
            USE IN SELECT(loc_cCursor)
            RETURN
        ENDIF
        IF USED(loc_cCursor)
            USE IN SELECT(loc_cCursor)
        ENDIF

        THIS.AbrirLookupSimples(par_oTxtCod, par_cTabela, par_cCampoCod, ;
            par_cCampoDesc, par_cTitulo, par_cFiltroExtra)
    ENDPROC

    *==========================================================================
    * AbrirLookupProduto / ValidarLookupProduto - lookup bidirecional de
    * Produto (SigCdPro.CPros/DPros), usado tanto pelo campo Codigo quanto
    * pelo campo Descricao (igual ao legado: Get_Produto.Valid e
    * Get_Descs.Valid abrem a MESMA busca e preenchem os DOIS campos).
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupProduto(par_oTxtDigitado, par_oTxtCod, par_oTxtDesc)
        THIS.AbrirLookupCanonico("SigCdPro", "CPros", "DPros", ;
            "Sele" + CHR(231) + CHR(227) + "o de Produto", ;
            ALLTRIM(par_oTxtDigitado.Value), par_oTxtCod, par_oTxtDesc)

        *-- O picker preenche Produto E Descricao de uma vez: reavaliar o When
        *-- do Get_Descs legado (so digitavel com o Produto em branco)
        THIS.AplicarWhenDescricaoPorCampo(par_oTxtCod)
    ENDPROC

    PROTECTED PROCEDURE ValidarLookupProduto(par_oTxtDigitado, par_oTxtCod, par_oTxtDesc, par_cCampoDigitado)
        LOCAL loc_cValor, loc_nResult, loc_cCursor, loc_cSQL
        loc_cValor  = ALLTRIM(par_oTxtDigitado.Value)
        loc_cCursor = "cursor_4c_ChkProduto"

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        IF USED(loc_cCursor)
            USE IN SELECT(loc_cCursor)
        ENDIF
        loc_cSQL = "SELECT CPros, DPros FROM SigCdPro WHERE " + ;
            par_cCampoDigitado + " = " + EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

        IF loc_nResult > 0 AND USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
            par_oTxtCod.Value  = ALLTRIM(cursor_4c_ChkProduto.CPros)
            par_oTxtDesc.Value = ALLTRIM(cursor_4c_ChkProduto.DPros)
            USE IN SELECT(loc_cCursor)
            *-- Achou pelo valor exato: Produto acabou de ficar preenchido,
            *-- entao a Descricao deixa de aceitar digitacao (When legado)
            THIS.AplicarWhenDescricaoPorCampo(par_oTxtCod)
            RETURN
        ENDIF
        IF USED(loc_cCursor)
            USE IN SELECT(loc_cCursor)
        ENDIF

        THIS.AbrirLookupProduto(par_oTxtDigitado, par_oTxtCod, par_oTxtDesc)
    ENDPROC

    *==========================================================================
    * AplicarWhenDescricao - transcreve o "PROCEDURE When / Return(Empty(
    * This.Parent.Get_Produto.Value))" que os TRES Get_Descs do legado tem
    * (OpEstoque, OpCusto e OpCompra): a Descricao so aceita digitacao
    * enquanto o Produto esta em branco - assim que o codigo do produto eh
    * preenchido (digitado ou trazido pelo picker), a Descricao vira apenas
    * exibicao do que o lookup devolveu, e voltar a digitar nela so eh
    * possivel limpando o Produto.
    *
    * Nao da para migrar o When por BINDEVENT (o VFP descarta o retorno do
    * delegate - mesma limitacao ja registrada para o Valid de TextBox), entao
    * o efeito eh reproduzido por ReadOnly + TabStop, que eh o que o When
    * fazia na pratica: o campo continua visivel e com o texto legivel, mas
    * nao entra na tabulacao nem aceita digitacao. NUNCA .Enabled = .F.: o
    * legado nao acinzenta a Descricao.
    *
    * Chamado de (a) InicializarForm, para o estado inicial dos tres
    * containers, (b) dos dois helpers de lookup de produto, que preenchem os
    * dois campos de uma vez, e (c) do InteractiveChange do Produto, que eh
    * onde o usuario limpa/digita o codigo tecla a tecla.
    *==========================================================================
    PROTECTED PROCEDURE AplicarWhenDescricao(par_oContainer)
        LOCAL loc_lPodeDigitar

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF
        IF !PEMSTATUS(par_oContainer, "txt_4c_Produto", 5) OR ;
                !PEMSTATUS(par_oContainer, "txt_4c_Descricao", 5)
            RETURN
        ENDIF

        loc_lPodeDigitar = EMPTY(par_oContainer.txt_4c_Produto.Value)

        par_oContainer.txt_4c_Descricao.ReadOnly = !loc_lPodeDigitar
        par_oContainer.txt_4c_Descricao.TabStop  = loc_lPodeDigitar
    ENDPROC

    *==========================================================================
    * AplicarWhenDescricaoPorCampo - atalho usado pelos helpers de lookup, que
    * recebem os TextBox e nao o container. Produto e Descricao sao sempre
    * irmaos dentro do mesmo cnt_4c_Op*, entao o pai de qualquer um deles eh o
    * container que a regra acima precisa.
    *==========================================================================
    PROTECTED PROCEDURE AplicarWhenDescricaoPorCampo(par_oTxtCod)
        IF VARTYPE(par_oTxtCod) = "O" AND VARTYPE(par_oTxtCod.Parent) = "O"
            THIS.AplicarWhenDescricao(par_oTxtCod.Parent)
        ENDIF
    ENDPROC

    *==========================================================================
    * InteractiveChange do Produto nos tres containers que tem Descricao -
    * reavalia o When a cada tecla digitada no codigo do produto (inclusive
    * quando o usuario APAGA o codigo, que eh o caminho de volta para poder
    * digitar na Descricao). PUBLIC: exigido por BINDEVENT (regra #3).
    *==========================================================================
    PROCEDURE ProdutoEstoqueInteractiveChange()
        THIS.AplicarWhenDescricao(THIS.cnt_4c_OpEstoque)
    ENDPROC

    PROCEDURE ProdutoCustoInteractiveChange()
        THIS.AplicarWhenDescricao(THIS.cnt_4c_OpCusto)
    ENDPROC

    PROCEDURE ProdutoCompraInteractiveChange()
        THIS.AplicarWhenDescricao(THIS.cnt_4c_OpCompra)
    ENDPROC

    *==========================================================================
    * Handlers de lookup - OpConta (Empresa/SigCdEmp, Grupo/SigCdGcr,
    * Conta/SigCdCli filtrado por Grupo, Moeda/SigCdMoe). PUBLIC - exigido
    * por BINDEVENT (regra CLAUDE.md #3).
    *==========================================================================
    PROCEDURE EmpresaContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oTxt
        loc_oTxt = THIS.cnt_4c_OpConta.txt_4c_Empresa
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupSimples(loc_oTxt, "SigCdEmp", "Cemps", "Razas", ;
                "Sele" + CHR(231) + CHR(227) + "o de Empresa", "")
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
                THIS.ValidarLookupSimples(loc_oTxt, "SigCdEmp", "Cemps", "Razas", ;
                    "Sele" + CHR(231) + CHR(227) + "o de Empresa", "")
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE EmpresaContaDblClick()
        THIS.AbrirLookupSimples(THIS.cnt_4c_OpConta.txt_4c_Empresa, "SigCdEmp", "Cemps", "Razas", ;
            "Sele" + CHR(231) + CHR(227) + "o de Empresa", "")
    ENDPROC

    PROCEDURE GrupoContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oTxt
        loc_oTxt = THIS.cnt_4c_OpConta.txt_4c_TxtGrupos
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupSimples(loc_oTxt, "SigCdGcr", "Codigos", "Descrs", ;
                "Sele" + CHR(231) + CHR(227) + "o de Grupo", "")
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
                THIS.ValidarLookupSimples(loc_oTxt, "SigCdGcr", "Codigos", "Descrs", ;
                    "Sele" + CHR(231) + CHR(227) + "o de Grupo", "")
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE GrupoContaDblClick()
        THIS.AbrirLookupSimples(THIS.cnt_4c_OpConta.txt_4c_TxtGrupos, "SigCdGcr", "Codigos", "Descrs", ;
            "Sele" + CHR(231) + CHR(227) + "o de Grupo", "")
    ENDPROC

    PROCEDURE ContaContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oTxt, loc_cFiltro
        loc_oTxt    = THIS.cnt_4c_OpConta.txt_4c_TxtContas
        loc_cFiltro = THIS.MontarFiltroGrupo(THIS.cnt_4c_OpConta.txt_4c_TxtGrupos)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupSimples(loc_oTxt, "SigCdCli", "IClis", "RClis", ;
                "Sele" + CHR(231) + CHR(227) + "o de Conta", loc_cFiltro)
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
                THIS.ValidarLookupSimples(loc_oTxt, "SigCdCli", "IClis", "RClis", ;
                    "Sele" + CHR(231) + CHR(227) + "o de Conta", loc_cFiltro)
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE ContaContaDblClick()
        LOCAL loc_cFiltro
        loc_cFiltro = THIS.MontarFiltroGrupo(THIS.cnt_4c_OpConta.txt_4c_TxtGrupos)
        THIS.AbrirLookupSimples(THIS.cnt_4c_OpConta.txt_4c_TxtContas, "SigCdCli", "IClis", "RClis", ;
            "Sele" + CHR(231) + CHR(227) + "o de Conta", loc_cFiltro)
    ENDPROC

    PROCEDURE MoedaContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oTxt
        loc_oTxt = THIS.cnt_4c_OpConta.txt_4c_TxtMoedas
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupSimples(loc_oTxt, "SigCdMoe", "Cmoes", "Dmoes", ;
                "Sele" + CHR(231) + CHR(227) + "o de Moeda", "")
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
                THIS.ValidarLookupSimples(loc_oTxt, "SigCdMoe", "Cmoes", "Dmoes", ;
                    "Sele" + CHR(231) + CHR(227) + "o de Moeda", "")
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE MoedaContaDblClick()
        THIS.AbrirLookupSimples(THIS.cnt_4c_OpConta.txt_4c_TxtMoedas, "SigCdMoe", "Cmoes", "Dmoes", ;
            "Sele" + CHR(231) + CHR(227) + "o de Moeda", "")
    ENDPROC

    *==========================================================================
    * Handlers de lookup - OpEstoque (Empresa/SigCdEmp, Grupo/SigCdGcr,
    * Estoque=Conta/SigCdCli filtrado por Grupo, Produto+Descricao/SigCdPro)
    *==========================================================================
    PROCEDURE EmpresaEstoqueKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oTxt
        loc_oTxt = THIS.cnt_4c_OpEstoque.txt_4c_Empresa
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupSimples(loc_oTxt, "SigCdEmp", "Cemps", "Razas", ;
                "Sele" + CHR(231) + CHR(227) + "o de Empresa", "")
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
                THIS.ValidarLookupSimples(loc_oTxt, "SigCdEmp", "Cemps", "Razas", ;
                    "Sele" + CHR(231) + CHR(227) + "o de Empresa", "")
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE EmpresaEstoqueDblClick()
        THIS.AbrirLookupSimples(THIS.cnt_4c_OpEstoque.txt_4c_Empresa, "SigCdEmp", "Cemps", "Razas", ;
            "Sele" + CHR(231) + CHR(227) + "o de Empresa", "")
    ENDPROC

    PROCEDURE GrupoEstoqueKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oTxt
        loc_oTxt = THIS.cnt_4c_OpEstoque.txt_4c_TxtGrupos
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupSimples(loc_oTxt, "SigCdGcr", "Codigos", "Descrs", ;
                "Sele" + CHR(231) + CHR(227) + "o de Grupo", "")
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
                THIS.ValidarLookupSimples(loc_oTxt, "SigCdGcr", "Codigos", "Descrs", ;
                    "Sele" + CHR(231) + CHR(227) + "o de Grupo", "")
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE GrupoEstoqueDblClick()
        THIS.AbrirLookupSimples(THIS.cnt_4c_OpEstoque.txt_4c_TxtGrupos, "SigCdGcr", "Codigos", "Descrs", ;
            "Sele" + CHR(231) + CHR(227) + "o de Grupo", "")
    ENDPROC

    PROCEDURE EstoqueKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oTxt, loc_cFiltro
        loc_oTxt    = THIS.cnt_4c_OpEstoque.txt_4c_Estoque
        loc_cFiltro = THIS.MontarFiltroGrupo(THIS.cnt_4c_OpEstoque.txt_4c_TxtGrupos)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupSimples(loc_oTxt, "SigCdCli", "IClis", "RClis", ;
                "Sele" + CHR(231) + CHR(227) + "o de Conta", loc_cFiltro)
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
                THIS.ValidarLookupSimples(loc_oTxt, "SigCdCli", "IClis", "RClis", ;
                    "Sele" + CHR(231) + CHR(227) + "o de Conta", loc_cFiltro)
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE EstoqueDblClick()
        LOCAL loc_cFiltro
        loc_cFiltro = THIS.MontarFiltroGrupo(THIS.cnt_4c_OpEstoque.txt_4c_TxtGrupos)
        THIS.AbrirLookupSimples(THIS.cnt_4c_OpEstoque.txt_4c_Estoque, "SigCdCli", "IClis", "RClis", ;
            "Sele" + CHR(231) + CHR(227) + "o de Conta", loc_cFiltro)
    ENDPROC

    PROCEDURE ProdutoEstoqueKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oProduto, loc_oDescricao
        loc_oProduto   = THIS.cnt_4c_OpEstoque.txt_4c_Produto
        loc_oDescricao = THIS.cnt_4c_OpEstoque.txt_4c_Descricao
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupProduto(loc_oProduto, loc_oProduto, loc_oDescricao)
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
                THIS.ValidarLookupProduto(loc_oProduto, loc_oProduto, loc_oDescricao, "CPros")
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE ProdutoEstoqueDblClick()
        THIS.AbrirLookupProduto(THIS.cnt_4c_OpEstoque.txt_4c_Produto, ;
            THIS.cnt_4c_OpEstoque.txt_4c_Produto, THIS.cnt_4c_OpEstoque.txt_4c_Descricao)
    ENDPROC

    PROCEDURE DescricaoEstoqueKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oProduto, loc_oDescricao
        loc_oProduto   = THIS.cnt_4c_OpEstoque.txt_4c_Produto
        loc_oDescricao = THIS.cnt_4c_OpEstoque.txt_4c_Descricao
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupProduto(loc_oDescricao, loc_oProduto, loc_oDescricao)
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
                THIS.ValidarLookupProduto(loc_oDescricao, loc_oProduto, loc_oDescricao, "DPros")
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE DescricaoEstoqueDblClick()
        THIS.AbrirLookupProduto(THIS.cnt_4c_OpEstoque.txt_4c_Descricao, ;
            THIS.cnt_4c_OpEstoque.txt_4c_Produto, THIS.cnt_4c_OpEstoque.txt_4c_Descricao)
    ENDPROC

    *==========================================================================
    * Handlers de lookup - OpCusto (Empresa/SigCdEmp, Produto+Descricao/SigCdPro)
    *==========================================================================
    PROCEDURE EmpresaCustoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oTxt
        loc_oTxt = THIS.cnt_4c_OpCusto.txt_4c_Empresa
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupSimples(loc_oTxt, "SigCdEmp", "Cemps", "Razas", ;
                "Sele" + CHR(231) + CHR(227) + "o de Empresa", "")
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
                THIS.ValidarLookupSimples(loc_oTxt, "SigCdEmp", "Cemps", "Razas", ;
                    "Sele" + CHR(231) + CHR(227) + "o de Empresa", "")
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE EmpresaCustoDblClick()
        THIS.AbrirLookupSimples(THIS.cnt_4c_OpCusto.txt_4c_Empresa, "SigCdEmp", "Cemps", "Razas", ;
            "Sele" + CHR(231) + CHR(227) + "o de Empresa", "")
    ENDPROC

    PROCEDURE ProdutoCustoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oProduto, loc_oDescricao
        loc_oProduto   = THIS.cnt_4c_OpCusto.txt_4c_Produto
        loc_oDescricao = THIS.cnt_4c_OpCusto.txt_4c_Descricao
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupProduto(loc_oProduto, loc_oProduto, loc_oDescricao)
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
                THIS.ValidarLookupProduto(loc_oProduto, loc_oProduto, loc_oDescricao, "CPros")
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE ProdutoCustoDblClick()
        THIS.AbrirLookupProduto(THIS.cnt_4c_OpCusto.txt_4c_Produto, ;
            THIS.cnt_4c_OpCusto.txt_4c_Produto, THIS.cnt_4c_OpCusto.txt_4c_Descricao)
    ENDPROC

    PROCEDURE DescricaoCustoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oProduto, loc_oDescricao
        loc_oProduto   = THIS.cnt_4c_OpCusto.txt_4c_Produto
        loc_oDescricao = THIS.cnt_4c_OpCusto.txt_4c_Descricao
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupProduto(loc_oDescricao, loc_oProduto, loc_oDescricao)
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
                THIS.ValidarLookupProduto(loc_oDescricao, loc_oProduto, loc_oDescricao, "DPros")
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE DescricaoCustoDblClick()
        THIS.AbrirLookupProduto(THIS.cnt_4c_OpCusto.txt_4c_Descricao, ;
            THIS.cnt_4c_OpCusto.txt_4c_Produto, THIS.cnt_4c_OpCusto.txt_4c_Descricao)
    ENDPROC

    *==========================================================================
    * Handlers de lookup - OpCompra (Empresa/SigCdEmp, Produto+Descricao/SigCdPro)
    *==========================================================================
    PROCEDURE EmpresaCompraKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oTxt
        loc_oTxt = THIS.cnt_4c_OpCompra.txt_4c_Empresa
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupSimples(loc_oTxt, "SigCdEmp", "Cemps", "Razas", ;
                "Sele" + CHR(231) + CHR(227) + "o de Empresa", "")
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
                THIS.ValidarLookupSimples(loc_oTxt, "SigCdEmp", "Cemps", "Razas", ;
                    "Sele" + CHR(231) + CHR(227) + "o de Empresa", "")
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE EmpresaCompraDblClick()
        THIS.AbrirLookupSimples(THIS.cnt_4c_OpCompra.txt_4c_Empresa, "SigCdEmp", "Cemps", "Razas", ;
            "Sele" + CHR(231) + CHR(227) + "o de Empresa", "")
    ENDPROC

    PROCEDURE ProdutoCompraKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oProduto, loc_oDescricao
        loc_oProduto   = THIS.cnt_4c_OpCompra.txt_4c_Produto
        loc_oDescricao = THIS.cnt_4c_OpCompra.txt_4c_Descricao
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupProduto(loc_oProduto, loc_oProduto, loc_oDescricao)
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
                THIS.ValidarLookupProduto(loc_oProduto, loc_oProduto, loc_oDescricao, "CPros")
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE ProdutoCompraDblClick()
        THIS.AbrirLookupProduto(THIS.cnt_4c_OpCompra.txt_4c_Produto, ;
            THIS.cnt_4c_OpCompra.txt_4c_Produto, THIS.cnt_4c_OpCompra.txt_4c_Descricao)
    ENDPROC

    PROCEDURE DescricaoCompraKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oProduto, loc_oDescricao
        loc_oProduto   = THIS.cnt_4c_OpCompra.txt_4c_Produto
        loc_oDescricao = THIS.cnt_4c_OpCompra.txt_4c_Descricao
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupProduto(loc_oDescricao, loc_oProduto, loc_oDescricao)
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
                THIS.ValidarLookupProduto(loc_oDescricao, loc_oProduto, loc_oDescricao, "DPros")
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE DescricaoCompraDblClick()
        THIS.AbrirLookupProduto(THIS.cnt_4c_OpCompra.txt_4c_Descricao, ;
            THIS.cnt_4c_OpCompra.txt_4c_Produto, THIS.cnt_4c_OpCompra.txt_4c_Descricao)
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesAcao - Shape decorativo + botoes Processar/Encerrar
    * (top-level, canto superior direito, identico ao legado)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesAcao
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 7
            .Left        = 697
            .Width       = 90
            .Height      = 110
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_Processa", "CommandButton")
        WITH THIS.cmd_4c_Processa
            .Top             = 3
            .Left            = 650
            .Width           = 75
            .Height          = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .Caption         = "Processar"
            .Picture         = gc_4c_CaminhoFramework + "imagens\geral_processar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoFramework + "imagens\geral_processar_60.jpg"
            .Enabled         = .F.
            .ToolTipText     = "Processar"
            .SpecialEffect   = 0
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .Visible         = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_Cancela", "CommandButton")
        WITH THIS.cmd_4c_Cancela
            .Top             = 3
            .Left            = 725
            .Width           = 75
            .Height          = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .Cancel          = .T.
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoFramework + "imagens\cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoFramework + "imagens\cadastro_sair_60.jpg"
            .ToolTipText     = "[ESC] Sair"
            .SpecialEffect   = 0
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Processa, "Click", THIS, "BtnProcessarClick")
        BINDEVENT(THIS.cmd_4c_Cancela, "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *==========================================================================
    * ConfigurarCheckboxesToggle - os 4 checkboxes graficos que expandem/
    * recolhem cada container flutuante (identico ao Valid do legado:
    * anima o Width, alterna Visible/Enabled e liga o Processar quando
    * algum dos 4 estiver marcado)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCheckboxesToggle
        THIS.AddObject("chk_4c_Conta", "CheckBox")
        WITH THIS.chk_4c_Conta
            .Top           = 3
            .Left          = 350
            .Width         = 75
            .Height        = 75
            .FontBold      = .T.
            .FontItalic    = .T.
            .FontName      = "Comic Sans MS"
            .FontSize      = 8
            .AutoSize      = .F.
            .Picture       = gc_4c_CaminhoIcones + "Folder42.ico"
            .DownPicture   = gc_4c_CaminhoIcones + "A_CASH1.BMP"
            .Alignment     = 1
            .BackStyle     = 0
            .Caption       = "C.C."
            .Value         = 0
            .SpecialEffect = 0
            .Style         = 1
            .ToolTipText   = "Conta Corrente"
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(THIS.chk_4c_Conta, "Click", THIS, "ChkContaClick")

        THIS.AddObject("chk_4c_Estoque", "CheckBox")
        WITH THIS.chk_4c_Estoque
            .Top           = 3
            .Left          = 425
            .Width         = 75
            .Height        = 75
            .FontBold      = .T.
            .FontItalic    = .T.
            .FontName      = "Comic Sans MS"
            .FontSize      = 8
            .AutoSize      = .F.
            .Picture       = gc_4c_CaminhoIcones + "Folder22.ico"
            .DownPicture   = gc_4c_CaminhoIcones + "A_DIAMD1.BMP"
            .Alignment     = 1
            .BackStyle     = 0
            .Caption       = "Estoque"
            .Value         = 0
            .SpecialEffect = 0
            .Style         = 1
            .ToolTipText   = ""
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(THIS.chk_4c_Estoque, "Click", THIS, "ChkEstoqueClick")

        THIS.AddObject("chk_4c_BtnCusto", "CheckBox")
        WITH THIS.chk_4c_BtnCusto
            .Top           = 3
            .Left          = 500
            .Width         = 75
            .Height        = 75
            .FontBold      = .T.
            .FontItalic    = .T.
            .FontName      = "Comic Sans MS"
            .FontSize      = 8
            .AutoSize      = .F.
            .Picture       = gc_4c_CaminhoIcones + "Folder34.ico"
            .DownPicture   = gc_4c_CaminhoIcones + "D_MISC2.BMP"
            .Alignment     = 1
            .BackStyle     = 0
            .Caption       = "Custo"
            .Value         = 0
            .SpecialEffect = 0
            .Style         = 1
            .ToolTipText   = ""
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(THIS.chk_4c_BtnCusto, "Click", THIS, "ChkBtnCustoClick")

        THIS.AddObject("chk_4c_BtnCompra", "CheckBox")
        WITH THIS.chk_4c_BtnCompra
            .Top           = 3
            .Left          = 575
            .Width         = 75
            .Height        = 75
            .FontBold      = .T.
            .FontItalic    = .T.
            .FontName      = "Comic Sans MS"
            .FontSize      = 8
            .AutoSize      = .F.
            .Picture       = gc_4c_CaminhoIcones + "Folder27.ico"
            .DownPicture   = gc_4c_CaminhoIcones + "D_MISC2.BMP"
            .Alignment     = 1
            .BackStyle     = 0
            .Caption       = CHR(218) + "lt. Compra"
            .Value         = 0
            .SpecialEffect = 0
            .Style         = 1
            .ToolTipText   = CHR(218) + "ltima Compra"
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(THIS.chk_4c_BtnCompra, "Click", THIS, "ChkBtnCompraClick")
    ENDPROC

    *==========================================================================
    * ConfigurarControlesStatus - label + contador de registros processados
    * (Get_Registro do legado) e o aviso final de conclusao (LblEnd)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarControlesStatus
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .AutoSize   = .F.
            .FontBold   = .T.
            .FontItalic = .F.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .WordWrap   = .F.
            .BackStyle  = 0
            .Caption    = "Registros : "
            .Height     = 15
            .Left       = 171
            .Top        = 547
            .Width      = 65
            .ForeColor  = RGB(90, 90, 90)
            .Visible    = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Registro", "TextBox")
        WITH THIS.txt_4c_Registro
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 23
            .InputMask     = "999,999,999"
            .Left          = 238
            .Top           = 543
            .Width         = 93
            .SpecialEffect = 1
            .Value         = 0
            *-- Contador somente-leitura: o legado prende o foco fora dele com
            *-- "PROCEDURE When / Return .f." (SIGPRCCC.Get_Registro). NUNCA
            *-- .Enabled = .F. aqui - o numero ficaria cinza, e o legado o exibe
            *-- normalmente; ReadOnly + TabStop = .F. reproduz o efeito (nao
            *-- entra na tabulacao e nao aceita digitacao) preservando a
            *-- aparencia. Quem escreve nele eh AtualizarContadorRegistros.
            .ReadOnly      = .T.
            .TabStop       = .F.
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_LblEnd", "Label")
        WITH THIS.lbl_4c_LblEnd
            .AutoSize   = .F.
            .FontBold   = .T.
            .FontItalic = .F.
            .FontName   = "Arial"
            .FontSize   = 12
            .WordWrap   = .F.
            .Alignment  = 2
            .BackStyle  = 0
            .Caption    = "Processamento Conclu" + CHR(237) + "do"
            .Height     = 22
            .Left       = 361
            .Top        = 545
            .Width      = 205
            .ForeColor  = RGB(255, 0, 0)
            .Visible    = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    * AjustarLarguraContainer - reproduz a animacao de Width do legado
    * (For 1 To Largura / For Largura To 0 Step -1) ao expandir/recolher
    * o container flutuante de cada frente de recalculo
    *==========================================================================
    PROTECTED PROCEDURE AjustarLarguraContainer(par_oContainer, par_nLarguraAlvo, par_lExpandir)
        LOCAL loc_nI
        IF par_lExpandir
            FOR loc_nI = 1 TO par_nLarguraAlvo
                par_oContainer.Width = loc_nI
            ENDFOR
        ELSE
            FOR loc_nI = par_nLarguraAlvo TO 0 STEP -1
                par_oContainer.Width = loc_nI
            ENDFOR
        ENDIF
    ENDPROC

    *==========================================================================
    * AtualizarEstadoProcessar - Processar so fica habilitado quando pelo
    * menos uma das 4 frentes esta marcada (mesma condicao OR do legado,
    * repetida nos 4 handlers de checkbox)
    *==========================================================================
    PROTECTED PROCEDURE AtualizarEstadoProcessar
        IF THIS.chk_4c_Conta.Value = 1 OR THIS.chk_4c_Estoque.Value = 1 OR ;
                THIS.chk_4c_BtnCusto.Value = 1 OR THIS.chk_4c_BtnCompra.Value = 1
            THIS.cmd_4c_Processa.Enabled = .T.
        ELSE
            THIS.cmd_4c_Processa.Enabled = .F.
        ENDIF
    ENDPROC

    *==========================================================================
    * Handlers de Click dos checkboxes de toggle (PUBLIC - BINDEVENT exige
    * metodo publico, regra #3) - cada um alterna Enabled/Visible do seu
    * container e reproduz a animacao de Width antes de exibir/ocultar
    *==========================================================================
    PROCEDURE ChkContaClick
        LOCAL loc_lExpandir
        loc_lExpandir = (THIS.chk_4c_Conta.Value = 1)

        THIS.cnt_4c_OpConta.Enabled = loc_lExpandir
        THIS.AjustarLarguraContainer(THIS.cnt_4c_OpConta, THIS.this_nLarguraOpConta, loc_lExpandir)
        THIS.cnt_4c_OpConta.Visible = loc_lExpandir

        THIS.AtualizarEstadoProcessar()
        THIS.Refresh()
    ENDPROC

    PROCEDURE ChkEstoqueClick
        LOCAL loc_lExpandir
        loc_lExpandir = (THIS.chk_4c_Estoque.Value = 1)

        THIS.cnt_4c_OpEstoque.Enabled = loc_lExpandir
        THIS.AjustarLarguraContainer(THIS.cnt_4c_OpEstoque, THIS.this_nLarguraOpEstoque, loc_lExpandir)
        THIS.cnt_4c_OpEstoque.Visible = loc_lExpandir

        THIS.AtualizarEstadoProcessar()
        THIS.Refresh()
    ENDPROC

    PROCEDURE ChkBtnCustoClick
        LOCAL loc_lExpandir
        loc_lExpandir = (THIS.chk_4c_BtnCusto.Value = 1)

        THIS.cnt_4c_OpCusto.Enabled = loc_lExpandir
        THIS.AjustarLarguraContainer(THIS.cnt_4c_OpCusto, THIS.this_nLarguraOpCusto, loc_lExpandir)
        THIS.cnt_4c_OpCusto.Visible = loc_lExpandir

        THIS.AtualizarEstadoProcessar()
        THIS.Refresh()
    ENDPROC

    PROCEDURE ChkBtnCompraClick
        LOCAL loc_lExpandir
        loc_lExpandir = (THIS.chk_4c_BtnCompra.Value = 1)

        THIS.cnt_4c_OpCompra.Enabled = loc_lExpandir
        THIS.AjustarLarguraContainer(THIS.cnt_4c_OpCompra, THIS.this_nLarguraOpCompra, loc_lExpandir)
        THIS.cnt_4c_OpCompra.Visible = loc_lExpandir

        THIS.AtualizarEstadoProcessar()
        THIS.Refresh()
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - PUBLIC (BINDEVENT), identico ao legado ("ThisForm.Release").
    * O nome vem do OBJETO do legado, que se chama "Cancela" (Caption
    * "Encerrar"): nao ha nome inventado nem Page2 de Dados para cancelar -
    * este eh o unico caminho de saida da tela.
    *==========================================================================
    PROCEDURE BtnCancelarClick
        THIS.Release()
    ENDPROC


    *==========================================================================
    * BtnProcessarClick - PUBLIC (BINDEVENT), evento PRINCIPAL do form e a
    * UNICA acao que ele tem: transcreve o Processa.Click do legado
    * (SIGPRCCC.Processa - o nome do handler vem do nome do objeto legado).
    * Esta tela nao tem Salvar/Confirmar: o que ela grava eh o resultado do
    * lote, dentro dos metodos Recalcular*/AtualizarUltimaCompra do BO.
    *
    * Sequencia do legado, na mesma ordem:
    *   1. desabilita os 4 checkboxes + Processar + Encerrar e esconde o
    *      "Processamento Concluido" (nada pode ser alterado durante o lote);
    *   2. executa as frentes MARCADAS, cada uma autonoma em relacao as outras, na
    *      ordem Conta Corrente -> Estoque -> Custo -> Ultima Compra;
    *   3. reabilita tudo, exibe o "Processamento Concluido" e devolve o foco
    *      ao Encerrar.
    *
    * O "Do While llSaida" do legado eh um laco de UMA passada usado apenas
    * como estrutura de abandono (cada falha faz "llSaida = .f. / Loop", que
    * pula as frentes seguintes). Aqui isso vira a flag loc_lProsseguir
    * testada antes de cada frente - RETURN dentro de TRY/CATCH eh proibido
    * (regra #1), e o bloco de reabilitacao TEM de rodar em qualquer saida,
    * senao a tela fica inutilizavel com tudo cinza (regra #40).
    *==========================================================================
    PROCEDURE BtnProcessarClick
        LOCAL loc_lProsseguir, loc_oErro

        *-- Sem conexao nao ha o que processar: avisa e nao mexe na tela
        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            MsgAviso("Sem conex" + CHR(227) + "o com o servidor de banco de dados. " + ;
                "N" + CHR(227) + "o eh poss" + CHR(237) + "vel processar.", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        *-- Nenhuma frente marcada: o legado nem habilita o Processar nesse
        *-- caso (AtualizarEstadoProcessar), mas o atalho de teclado chega aqui
        IF THIS.chk_4c_Conta.Value != 1 AND THIS.chk_4c_Estoque.Value != 1 AND ;
                THIS.chk_4c_BtnCusto.Value != 1 AND THIS.chk_4c_BtnCompra.Value != 1
            MsgAviso("Marque ao menos uma op" + CHR(231) + CHR(227) + "o de rec" + ;
                CHR(225) + "lculo antes de processar.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        loc_lProsseguir = .T.

        *-- 1. Travar a tela durante o lote (identico ao 1o With do legado)
        THIS.HabilitarControlesProcessamento(.F.)

        TRY
            *-- Levar os filtros de cada container para o BO
            THIS.FormParaBO()
            THIS.this_oBusinessObject.this_oFormUI = THIS

            *-- 2a. Conta Corrente (If ThisForm.Conta.Value)
            IF loc_lProsseguir AND THIS.chk_4c_Conta.Value = 1
                WAIT WINDOW "Aguarde! Selecionando Registros..." NOWAIT
                loc_lProsseguir = THIS.this_oBusinessObject.RecalcularContaCorrente()
            ENDIF

            *-- 2b. Estoque (If ThisForm.Estoque.Value)
            IF loc_lProsseguir AND THIS.chk_4c_Estoque.Value = 1
                WAIT WINDOW "Aguarde! Selecionando Registros..." NOWAIT
                loc_lProsseguir = THIS.this_oBusinessObject.RecalcularEstoque()
            ENDIF

            *-- 2c. Custo de Produto (If ThisForm.btnCusto.Value)
            IF loc_lProsseguir AND THIS.chk_4c_BtnCusto.Value = 1
                WAIT WINDOW "Aguarde! Selecionando Registros..." NOWAIT
                loc_lProsseguir = THIS.this_oBusinessObject.RecalcularCustoProduto()
            ENDIF

            *-- 2d. Ultima Compra (If ThisForm.BtnCompra.Value)
            IF loc_lProsseguir AND THIS.chk_4c_BtnCompra.Value = 1
                WAIT WINDOW "Aguarde! Selecionando Registros..." NOWAIT
                loc_lProsseguir = THIS.this_oBusinessObject.AtualizarUltimaCompra()
            ENDIF

            WAIT CLEAR
        CATCH TO loc_oErro
            loc_lProsseguir = .F.
            WAIT CLEAR
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro ao processar Rec" + ;
                CHR(225) + "lculo de Saldos")
        ENDTRY

        *-- 3. Destravar a tela SEMPRE - inclusive quando uma frente falhou
        *-- (senao Processar/Encerrar ficam cinza e a tela morre, regra #40)
        THIS.HabilitarControlesProcessamento(.T.)

        *-- "Processamento Concluido" so aparece quando tudo correu bem; em
        *-- caso de falha o usuario ja recebeu o MsgErro da frente que parou
        THIS.lbl_4c_LblEnd.Visible = loc_lProsseguir

        THIS.cmd_4c_Cancela.SetFocus()
    ENDPROC

    *==========================================================================
    * HabilitarControlesProcessamento - o par de blocos "With Thisform /
    * .Conta.Enabled = .F. ... " do inicio e do fim de Processa.Click.
    * Recebe .F. para travar a tela durante o lote e .T. para destravar.
    *==========================================================================
    PROTECTED PROCEDURE HabilitarControlesProcessamento(par_lHabilitar)
        THIS.chk_4c_Conta.Enabled     = par_lHabilitar
        THIS.chk_4c_Estoque.Enabled   = par_lHabilitar
        THIS.chk_4c_BtnCusto.Enabled  = par_lHabilitar
        THIS.chk_4c_BtnCompra.Enabled = par_lHabilitar
        THIS.cmd_4c_Cancela.Enabled   = par_lHabilitar

        IF par_lHabilitar
            *-- Processar segue a regra normal da tela (so habilitado com
            *-- alguma frente marcada), NUNCA habilitado incondicionalmente
            THIS.AtualizarEstadoProcessar()
        ELSE
            THIS.cmd_4c_Processa.Enabled = .F.
            THIS.lbl_4c_LblEnd.Visible   = .F.
        ENDIF

        THIS.Refresh()
    ENDPROC

    *==========================================================================
    * FormParaBO - leva os filtros dos 4 containers flutuantes para as
    * propriedades do BO. Espelha as atribuicoes "_Emps = Padr(...)" que o
    * legado faz no inicio de cada ramo de Processa.Click.
    *
    * PROTECTED EXPLICITO: FormBase declara FormParaBO como PROTECTED e o
    * VFP9 nao deixa a subclasse alargar o escopo - omitir o modificador
    * mentiria para quem le, porque o metodo continua protegido. Chamado
    * sempre por THIS. de dentro da classe (regra #8).
    *
    * As datas ficam como DATE ({} quando em branco) - quem converte para
    * DATETIME/SQL eh o BO, via fDtoSQL. NUNCA TTOD aqui: o TextBox nasce
    * com .Value = {} (DATE) e TTOD com DATE dispara erro 11 (regra #16).
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oBO, loc_oCnt
        loc_oBO = THIS.this_oBusinessObject

        *-- Flags das 4 frentes (CheckBox.Value eh NUMERICO - converter)
        loc_oBO.this_lConta   = (THIS.chk_4c_Conta.Value = 1)
        loc_oBO.this_lEstoque = (THIS.chk_4c_Estoque.Value = 1)
        loc_oBO.this_lCusto   = (THIS.chk_4c_BtnCusto.Value = 1)
        loc_oBO.this_lCompra  = (THIS.chk_4c_BtnCompra.Value = 1)

        *-- Conta Corrente (OpConta)
        loc_oCnt = THIS.cnt_4c_OpConta
        loc_oBO.this_cContaEmpresa = PADR(ALLTRIM(loc_oCnt.txt_4c_Empresa.Value), 3)
        loc_oBO.this_cContaGrupo   = PADR(ALLTRIM(loc_oCnt.txt_4c_TxtGrupos.Value), 10)
        loc_oBO.this_cContaConta   = PADR(ALLTRIM(loc_oCnt.txt_4c_TxtContas.Value), 10)
        loc_oBO.this_cContaMoeda   = PADR(ALLTRIM(loc_oCnt.txt_4c_TxtMoedas.Value), 3)
        loc_oBO.this_dContaData    = ConverterParaData(loc_oCnt.txt_4c_TxtData.Value)

        *-- Estoque (OpEstoque)
        loc_oCnt = THIS.cnt_4c_OpEstoque
        loc_oBO.this_cEstoqueEmpresa   = PADR(ALLTRIM(loc_oCnt.txt_4c_Empresa.Value), 3)
        loc_oBO.this_cEstoqueGrupo     = PADR(ALLTRIM(loc_oCnt.txt_4c_TxtGrupos.Value), 10)
        loc_oBO.this_cEstoqueEstoque   = PADR(ALLTRIM(loc_oCnt.txt_4c_Estoque.Value), 10)
        loc_oBO.this_cEstoqueProduto   = PADR(ALLTRIM(loc_oCnt.txt_4c_Produto.Value), 14)
        loc_oBO.this_cEstoqueDescricao = PADR(ALLTRIM(loc_oCnt.txt_4c_Descricao.Value), 65)
        loc_oBO.this_dEstoqueData      = ConverterParaData(loc_oCnt.txt_4c_TxtData.Value)

        *-- Custo de Produto (OpCusto)
        loc_oCnt = THIS.cnt_4c_OpCusto
        loc_oBO.this_cCustoEmpresa   = PADR(ALLTRIM(loc_oCnt.txt_4c_Empresa.Value), 3)
        loc_oBO.this_cCustoProduto   = PADR(ALLTRIM(loc_oCnt.txt_4c_Produto.Value), 14)
        loc_oBO.this_cCustoDescricao = PADR(ALLTRIM(loc_oCnt.txt_4c_Descricao.Value), 65)
        loc_oBO.this_dCustoData      = ConverterParaData(loc_oCnt.txt_4c_TxtData.Value)

        *-- Ultima Compra (OpCompra)
        loc_oCnt = THIS.cnt_4c_OpCompra
        loc_oBO.this_cCompraEmpresa   = PADR(ALLTRIM(loc_oCnt.txt_4c_Empresa.Value), 3)
        loc_oBO.this_cCompraProduto   = PADR(ALLTRIM(loc_oCnt.txt_4c_Produto.Value), 14)
        loc_oBO.this_cCompraDescricao = PADR(ALLTRIM(loc_oCnt.txt_4c_Descricao.Value), 65)
        loc_oBO.this_dCompraData      = ConverterParaData(loc_oCnt.txt_4c_TxtData.Value)

        RETURN .T.
    ENDPROC

    *==========================================================================
    * AtualizarContadorRegistros - PUBLIC (chamado de FORA da classe, pelo BO
    * durante o processamento - metodo PROTECTED falharia em runtime mesmo
    * com PEMSTATUS devolvendo .T., regra #3). Equivale ao par
    * "ThisForm.Get_Registro.Value = lnReg / ThisForm.Get_Registro.Refresh"
    * repetido em todos os Scan de Processa.Click.
    *==========================================================================
    PROCEDURE AtualizarContadorRegistros(par_nRegistros)
        IF VARTYPE(par_nRegistros) = "N"
            THIS.txt_4c_Registro.Value = par_nRegistros
            THIS.txt_4c_Registro.Refresh()
        ENDIF
    ENDPROC
    *==========================================================================
    * TornarControlesVisiveis - Torna visiveis os controles recem-criados,
    * SEM alterar os containers flutuantes (cnt_4c_Op*), que devem comecar
    * ocultos igual ao legado - mas RECURSA dentro deles para que os
    * campos adicionados nas fases seguintes ja nascam visiveis quando o
    * container for exibido pelo checkbox correspondente.
    *==========================================================================
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl, loc_oAlvo

        IF VARTYPE(par_oContainer) = "O"
            loc_oAlvo = par_oContainer
        ELSE
            loc_oAlvo = THIS
        ENDIF

        FOR loc_i = 1 TO loc_oAlvo.ControlCount
            loc_oControl = loc_oAlvo.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF INLIST(UPPER(loc_oControl.Name), "CNT_4C_OPCONTA", "CNT_4C_OPESTOQUE", ;
                        "CNT_4C_OPCUSTO", "CNT_4C_OPCOMPRA")
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

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
