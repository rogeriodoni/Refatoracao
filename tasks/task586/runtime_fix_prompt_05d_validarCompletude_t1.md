# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[SigPrCccBO.prg] Indicador de pendencia: * saldos/valores de referencia em quatro frentes independente
[SigPrCccBO.prg] Indicador de pendencia: * revertendo buffer pendente
[FormSigPrCcc.prg] Indicador de pendencia: * Processo em lote com 4 frentes independente
[FormSigPrCcc.prg] Indicador de pendencia: *   2. executa as frentes MARCADAS, cada uma independente

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrCcc.prg):
*==============================================================================
* FormSigPrCcc.prg - Recalculo de Saldos (SIGPRCCC)
* Tipo: OPERACIONAL - layout flat customizado (sem PageFrame)
* Migrado de: SIGPRCCC.SCX
* Fase 8/8: Form COMPLETO - eventos principais, eventos auxiliares e
*           consolidacao final
*
* Processo em lote com 4 frentes independentes de recalculo, cada uma
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
    *   2. executa as frentes MARCADAS, cada uma independente da outra, na
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


### BO (C:\4c\projeto\app\classes\SigPrCccBO.prg):
*============================================================================
* SigPrCccBO.prg - Business Object para Recalculo de Saldos (SIGPRCCC)
*
* Form OPERACIONAL (SIGPRCCC / FormSigPrCcc): processo em lote que recalcula
* saldos/valores de referencia em quatro frentes independentes, habilitadas
* pelos checkboxes Conta/Estoque/btnCusto/btnCompra do form e filtradas pelos
* campos do respectivo container (OpConta/OpEstoque/OpCusto/OpCompra):
*   - Conta Corrente (SigMvCcr)      -> recalcula saldo de conta corrente
*   - Estoque (SigMvItn/SigCdPro)    -> recalcula saldo de estoque
*   - Custo de Produto (SigCdPro)    -> recalcula custo do produto
*   - Ultima Compra (SigMvItn/SigCdPro/SigCdCli) -> recalcula ultima compra
*
* SigOpClU (PK: cidchaves char(20)) e a tabela de apoio onde o legado grava
* os valores recem-calculados antes de aplica-los (Insert Into CrSigOpClU +
* poDataMgr.Update - AddCursor('SigOpClU','CidChaves','CrSigOpClU') no Init).
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
* Completado em: Fase 2 - Metodos CRUD (CarregarDoCursor/Inserir/Atualizar/
*                ObterChavePrimaria/RegistrarAuditoria) para a entidade
*                SigOpClU (this_cTabela)
*============================================================================

DEFINE CLASS SigPrCccBO AS BusinessBase

    *==========================================================================
    * Flags de processamento - checkboxes Conta/Estoque/btnCusto/btnCompra do
    * form (SIGPRCCC.Conta/Estoque/btnCusto/btnCompra), que habilitam cada
    * frente do recalculo em Processa.Click
    *==========================================================================
    this_lConta    = .F.   && SIGPRCCC.Conta.Value    - habilita frente Conta Corrente
    this_lEstoque  = .F.   && SIGPRCCC.Estoque.Value  - habilita frente Estoque
    this_lCusto    = .F.   && SIGPRCCC.btnCusto.Value - habilita frente Custo de Produto
    this_lCompra   = .F.   && SIGPRCCC.btnCompra.Value - habilita frente Ultima Compra

    *==========================================================================
    * Filtros - Conta Corrente (container OpConta)
    *==========================================================================
    this_cContaEmpresa = SPACE(3)    && OpConta.Get_Empresa - SigCdEmp.Cemps
    this_cContaGrupo   = SPACE(10)   && OpConta.txtGrupos   - SigMvCcr.Grupos
    this_cContaConta   = SPACE(10)   && OpConta.txtContas   - SigMvCcr.Contas
    this_cContaMoeda   = SPACE(3)    && OpConta.txtMoedas   - SigMvCcr.Moedas
    this_dContaData    = {}          && OpConta.txtData     - "A partir de"

    *==========================================================================
    * Filtros - Estoque (container OpEstoque)
    *==========================================================================
    this_cEstoqueEmpresa   = SPACE(3)    && OpEstoque.Get_Empresa - SigCdEmp.Cemps
    this_cEstoqueGrupo     = SPACE(10)   && OpEstoque.txtGrupos   - Grupo do estoque
    this_cEstoqueEstoque   = SPACE(10)   && OpEstoque.Get_Estoque - codigo do estoque
    this_cEstoqueProduto   = SPACE(14)   && OpEstoque.Get_Produto - SigCdPro.CPros
    this_cEstoqueDescricao = SPACE(65)   && OpEstoque.Get_Descs   - SigCdPro.DPros (lookup)
    this_dEstoqueData      = {}          && OpEstoque.txtData     - "A partir de"

    *==========================================================================
    * Filtros - Custo de Produto (container OpCusto)
    *==========================================================================
    this_cCustoEmpresa   = SPACE(3)    && OpCusto.Get_Empresa - SigCdEmp.Cemps
    this_cCustoProduto   = SPACE(14)   && OpCusto.Get_Produto - SigCdPro.CPros
    this_cCustoDescricao = SPACE(65)   && OpCusto.Get_Descs   - SigCdPro.DPros (lookup)
    this_dCustoData      = {}          && OpCusto.txtData     - "A partir de"

    *==========================================================================
    * Filtros - Ultima Compra do Produto/Cliente (container OpCompra)
    *==========================================================================
    this_cCompraEmpresa   = SPACE(3)    && OpCompra.Get_Empresa - SigCdEmp.Cemps
    this_cCompraProduto   = SPACE(14)   && OpCompra.Get_Produto - SigCdPro.CPros
    this_cCompraDescricao = SPACE(65)   && OpCompra.Get_Descs   - SigCdPro.DPros (lookup)
    this_dCompraData      = {}          && OpCompra.txtData     - "A partir de"

    *==========================================================================
    * Contador de registros restantes durante o processamento (Get_Registro)
    *==========================================================================
    this_nRegistros = 0

    *==========================================================================
    * Referencia ao form para o feedback de progresso - equivale ao
    * "ThisForm.Get_Registro.Value = lnReg / Refresh" que o legado repete
    * dentro de cada Scan de Processa.Click. Fica .NULL. quando o BO eh usado
    * sem interface (o processamento nao depende dela).
    *==========================================================================
    this_oFormUI = .NULL.

    *==========================================================================
    * Propriedades de registro - espelham TODAS as colunas de SigOpClU
    * (docs/schema.sql), tabela de apoio (this_cTabela) onde o legado grava,
    * via Insert Into CrSigOpClU, os valores recalculados na frente Ultima
    * Compra (btnCompra) antes de aplica-los em SigCdCli/SigCdPro. Usadas por
    * CarregarDoCursor()/Inserir()/Atualizar()/ObterChavePrimaria().
    *==========================================================================
    this_cIdChaves   = SPACE(20)  && SigOpClU.cidchaves (PK)
    this_cEmps       = SPACE(3)   && SigOpClU.emps       - char(3)  NOT NULL
    this_cDopes      = SPACE(20)  && SigOpClU.dopes      - char(20) NOT NULL
    this_nNumes      = 0          && SigOpClU.numes      - numeric(6,0) NOT NULL
    this_cEmpDopNums = SPACE(29)  && SigOpClU.empdopnums - char(29) NOT NULL (chave POSICIONAL Emps+Dopes+Str(Numes,6))
    this_cIclis      = SPACE(10)  && SigOpClU.iclis      - char(10) NOT NULL (conta contabil, ramo Conta Corrente)
    this_cCpros      = SPACE(14)  && SigOpClU.cpros      - char(14) NOT NULL (produto, ramo Estoque)
    this_nValors     = 0          && SigOpClU.valors     - numeric(13,2) NOT NULL
    this_dDatas      = {}         && SigOpClU.datas      - datetime NULL
    this_cMoedas     = SPACE(3)   && SigOpClU.moedas     - char(3)  NOT NULL
    this_nQtds       = 0          && SigOpClU.qtds       - numeric(12,0) NOT NULL (nao referenciado no legado - sempre 0)

    *==========================================================================
    * Parametros do sistema (SigCdPam), carregados uma unica vez no Init -
    * equivalente ao CursorQuery('SigCdPam','CrSigCdPam',...,[GrupoRecs,
    * GrupoPags,ContaRecs,ContaPags,MoeCentral]) do Init() legado
    *==========================================================================
    this_cGrupoRecs  = SPACE(10)   && SigCdPam.gruporecs - grupo padrao de Contas a Receber
    this_cGrupoPags  = SPACE(10)   && SigCdPam.grupopags - grupo padrao de Contas a Pagar
    this_cContaRecs  = SPACE(10)   && SigCdPam.contarecs - conta padrao de Contas a Receber
    this_cContaPags  = SPACE(10)   && SigCdPam.contapags - conta padrao de Contas a Pagar
    this_cMoeCentral = SPACE(3)    && SigCdPam.moecentral - moeda central (conversao de cambio)

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela/chave primaria
    * de referencia (SigOpClU/cidchaves - AddCursor do Init legado) e carrega
    * os parametros do sistema usados no recalculo (SigCdPam.gruporecs/
    * grupopags/contarecs/contapags/moecentral)
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigOpClU"
            THIS.this_cCampoChave = "cidchaves"

            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0

                IF USED("cursor_4c_SigCdPam")
                    USE IN cursor_4c_SigCdPam
                ENDIF
                SQLEXEC(gnConnHandle, ;
                    "SELECT gruporecs, grupopags, contarecs, contapags, moecentral FROM SigCdPam", ;
                    "cursor_4c_SigCdPam")
                IF USED("cursor_4c_SigCdPam") AND !EOF("cursor_4c_SigCdPam")
                    THIS.this_cGrupoRecs  = PADR(TratarNulo(cursor_4c_SigCdPam.gruporecs, ""), 10)
                    THIS.this_cGrupoPags  = PADR(TratarNulo(cursor_4c_SigCdPam.grupopags, ""), 10)
                    THIS.this_cContaRecs  = PADR(TratarNulo(cursor_4c_SigCdPam.contarecs, ""), 10)
                    THIS.this_cContaPags  = PADR(TratarNulo(cursor_4c_SigCdPam.contapags, ""), 10)
                    THIS.this_cMoeCentral = PADR(TratarNulo(cursor_4c_SigCdPam.moecentral, ""), 3)
                ENDIF
                IF USED("cursor_4c_SigCdPam")
                    USE IN cursor_4c_SigCdPam
                ENDIF

            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * LimparDados - Reseta as propriedades de registro de SigOpClU (chamado
    * por NovoRegistro()/CancelarEdicao() do BusinessBase)
    *==========================================================================
    PROTECTED PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cIdChaves   = SPACE(20)
        THIS.this_cEmps       = SPACE(3)
        THIS.this_cDopes      = SPACE(20)
        THIS.this_nNumes      = 0
        THIS.this_cEmpDopNums = SPACE(29)
        THIS.this_cIclis      = SPACE(10)
        THIS.this_cCpros      = SPACE(14)
        THIS.this_nValors     = 0
        THIS.this_dDatas      = {}
        THIS.this_cMoedas     = SPACE(3)
        THIS.this_nQtds       = 0
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas de uma linha de SigOpClU
    * (identificada por cidchaves) para as propriedades this_ do BO.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF VARTYPE(par_cAliasCursor) != "C" OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        THIS.this_cIdChaves   = TratarNulo(cidchaves, "")
        THIS.this_cEmps       = TratarNulo(emps, "")
        THIS.this_cDopes      = TratarNulo(dopes, "")
        THIS.this_nNumes      = TratarNulo(numes, 0)
        THIS.this_cEmpDopNums = TratarNulo(empdopnums, "")
        THIS.this_cIclis      = TratarNulo(iclis, "")
        THIS.this_cCpros      = TratarNulo(cpros, "")
        THIS.this_nValors     = TratarNulo(valors, 0)
        THIS.this_dDatas      = ConverterParaData(datas)
        THIS.this_cMoedas     = TratarNulo(moedas, "")
        THIS.this_nQtds       = TratarNulo(qtds, 0)

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Chave do registro corrente de SigOpClU, usada por
    * RegistrarAuditoria()
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cIdChaves)
    ENDPROC

    *==========================================================================
    * Inserir - Grava uma linha em SigOpClU cobrindo TODAS as colunas NOT
    * NULL da tabela (docs/schema.sql), equivalente a cada "Insert Into
    * CrSigOpClU (...)" do legado (Processa.Click, ramo BtnCompra.Value).
    * cidchaves eh gerado aqui via fUniqueIds() quando ainda nao preenchido,
    * igual ao "Sys(2015)+Sys(2015)"/"fUniqueIds()" do legado - NUNCA string
    * vazia, senao a 2a linha colide no indice unico (PK).
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(THIS.this_cIdChaves))
            THIS.this_cIdChaves = fUniqueIds()
        ENDIF

        TRY
            loc_cSQL = "INSERT INTO SigOpClU " + ;
                "(cidchaves, emps, dopes, numes, empdopnums, iclis, cpros, valors, datas, moedas, qtds) " + ;
                "VALUES (" + ;
                EscaparSQL(ALLTRIM(THIS.this_cIdChaves)) + ", " + ;
                EscaparSQL(THIS.this_cEmps) + ", " + ;
                EscaparSQL(THIS.this_cDopes) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNumes, 0) + ", " + ;
                EscaparSQL(THIS.this_cEmpDopNums) + ", " + ;
                EscaparSQL(THIS.this_cIclis) + ", " + ;
                EscaparSQL(THIS.this_cCpros) + ", " + ;
                FormatarNumeroSQL(THIS.this_nValors, 2) + ", " + ;
                FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                EscaparSQL(THIS.this_cMoedas) + ", " + ;
                FormatarNumeroSQL(THIS.this_nQtds, 0) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                THIS.this_cMensagemErro = "Erro ao inserir em SigOpClU: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Regrava (por completo) uma linha existente de SigOpClU,
    * localizada por cidchaves. O legado NUNCA faz Update de uma linha desta
    * tabela em si (SigOpClU eh ZAP'd e repopulada a cada recalculo via
    * Insert - THIS.Inserir()); este metodo cobre o contrato padrao de
    * BusinessBase.Salvar() para o caso de uma linha precisar ser corrigida
    * apos carregada via CarregarDoCursor().
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(THIS.this_cIdChaves))
            THIS.this_cMensagemErro = "Registro de SigOpClU sem chave (cidchaves) para atualizar."
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "UPDATE SigOpClU SET " + ;
                "emps = " + EscaparSQL(THIS.this_cEmps) + ", " + ;
                "dopes = " + EscaparSQL(THIS.this_cDopes) + ", " + ;
                "numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0) + ", " + ;
                "empdopnums = " + EscaparSQL(THIS.this_cEmpDopNums) + ", " + ;
                "iclis = " + EscaparSQL(THIS.this_cIclis) + ", " + ;
                "cpros = " + EscaparSQL(THIS.this_cCpros) + ", " + ;
                "valors = " + FormatarNumeroSQL(THIS.this_nValors, 2) + ", " + ;
                "datas = " + FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                "moedas = " + EscaparSQL(THIS.this_cMoedas) + ", " + ;
                "qtds = " + FormatarNumeroSQL(THIS.this_nQtds, 0) + ;
                " WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cIdChaves))

            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                THIS.this_cMensagemErro = "Erro ao atualizar SigOpClU: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro")
            ELSE
                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC


    *==========================================================================
    * RecalcularContaCorrente - ramo "If ThisForm.Conta.Value" de
    * Processa.Click. Monta a lista de combinacoes Emps/Grupos/Contas/Moedas a
    * recalcular e chama fRecalculaS() para cada uma, com COMMIT por linha
    * (o legado faz poDataMgr.Commit()/Rollback() dentro do Scan).
    *
    * Duas origens para a lista, exatamente como o legado:
    *   - Grupo+Conta+Moeda TODOS preenchidos (_Gcm nao vazio): a combinacao
    *     eh montada em memoria (uma linha por empresa de SigCdEmp quando a
    *     empresa nao foi informada);
    *   - caso contrario: UNION ALL de SigMvCcr pelo filtro de Datas e pelo
    *     filtro de DataConcs+Concs (as DUAS metades do legado).
    *==========================================================================
    PROCEDURE RecalcularContaCorrente()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cWhere, loc_cWherC
        LOCAL loc_cEmps, loc_cGrupo, loc_cConta, loc_cMoeda, loc_cGcm
        LOCAL loc_dPData, loc_nRestantes, loc_oProg, loc_lOk
        loc_lSucesso = .F.

        TRY
            *-- Padr() dos valores, igual ao legado (_Emps/_Grupo/_Conta/_Moeda)
            loc_cEmps  = PADR(THIS.this_cContaEmpresa, 3)
            loc_cGrupo = PADR(THIS.this_cContaGrupo, 10)
            loc_cConta = PADR(THIS.this_cContaConta, 10)
            loc_cMoeda = PADR(THIS.this_cContaMoeda, 3)

            *-- _Gcm: so vale quando os TRES estao preenchidos
            IF !EMPTY(loc_cGrupo) AND !EMPTY(loc_cConta) AND !EMPTY(loc_cMoeda)
                loc_cGcm = loc_cGrupo + loc_cConta + loc_cMoeda
            ELSE
                loc_cGcm = SPACE(23)
            ENDIF

            *-- _pData: data-base do recalculo (1900-01-01 quando nao informada)
            loc_dPData = fDtoSQL(THIS.this_dContaData)

            *-- Os dois WHERE do legado (o 2o troca Datas por DataConcs e
            *-- acrescenta Concs = .T.)
            loc_cWhere = "WHERE 0 = 0 " + ;
                IIF(EMPTY(loc_cGrupo), "", "AND Grupos = " + EscaparSQL(loc_cGrupo) + " ") + ;
                IIF(EMPTY(loc_cConta), "", "AND Contas = " + EscaparSQL(loc_cConta) + " ") + ;
                IIF(EMPTY(loc_cMoeda), "", "AND Moedas = " + EscaparSQL(loc_cMoeda) + " ") + ;
                IIF(EMPTY(loc_cEmps),  "", "AND Emps = "   + EscaparSQL(loc_cEmps)  + " ") + ;
                IIF(EMPTY(THIS.this_dContaData), "", ;
                    "AND Datas >= " + FormatarDataSQL(loc_dPData) + " ")

            loc_cWherC = "WHERE 0 = 0 " + ;
                IIF(EMPTY(loc_cGrupo), "", "AND Grupos = " + EscaparSQL(loc_cGrupo) + " ") + ;
                IIF(EMPTY(loc_cConta), "", "AND Contas = " + EscaparSQL(loc_cConta) + " ") + ;
                IIF(EMPTY(loc_cMoeda), "", "AND Moedas = " + EscaparSQL(loc_cMoeda) + " ") + ;
                IIF(EMPTY(loc_cEmps),  "", "AND Emps = "   + EscaparSQL(loc_cEmps)  + " ") + ;
                IIF(EMPTY(THIS.this_dContaData), "", ;
                    "AND DataConcs >= " + FormatarDataSQL(loc_dPData) + " ") + ;
                "AND Concs = 1 "

            THIS.FecharCursorProcesso("cursor_4c_TmpConta")

            IF !EMPTY(ALLTRIM(loc_cGcm))

                *-- Combinacao fixa: uma linha por empresa (ou so a informada)
                CREATE CURSOR cursor_4c_TmpConta ;
                    (Emps C(3), Grupos C(10), Contas C(10), Moedas C(3), CidChaves C(20))

                IF EMPTY(loc_cEmps)
                    THIS.FecharCursorProcesso("cursor_4c_TmpEmps")
                    IF SQLEXEC(gnConnHandle, "SELECT Cemps FROM SigCdEmp", "cursor_4c_TmpEmps") < 1
                        THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! " + ;
                            "(cursor_4c_TmpEmps) " + CapturarErroSQL()
                        MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
                    ELSE
                        SELECT cursor_4c_TmpEmps
                        GO TOP
                        SCAN
                            INSERT INTO cursor_4c_TmpConta ;
                                (Emps, Grupos, Contas, Moedas, CidChaves) VALUES ;
                                (cursor_4c_TmpEmps.Cemps, loc_cGrupo, loc_cConta, ;
                                 loc_cMoeda, fUniqueIds())
                            SELECT cursor_4c_TmpEmps
                        ENDSCAN
                        THIS.FecharCursorProcesso("cursor_4c_TmpEmps")
                        loc_lSucesso = .T.
                    ENDIF
                ELSE
                    INSERT INTO cursor_4c_TmpConta ;
                        (Emps, Grupos, Contas, Moedas, CidChaves) VALUES ;
                        (loc_cEmps, loc_cGrupo, loc_cConta, loc_cMoeda, fUniqueIds())
                    loc_lSucesso = .T.
                ENDIF

                IF USED("cursor_4c_TmpConta")
                    SELECT cursor_4c_TmpConta
                    INDEX ON CidChaves TAG CidChaves
                ENDIF

            ELSE

                *-- UNION ALL das duas metades de SigMvCcr
                loc_cSQL = "SELECT DISTINCT Emps, Grupos, Contas, Moedas, " + ;
                    "SPACE(20) AS CidChaves FROM SigMvCcr " + loc_cWhere + ;
                    " UNION ALL " + ;
                    "SELECT DISTINCT Emps, Grupos, Contas, Moedas, " + ;
                    "SPACE(20) AS CidChaves FROM SigMvCcr " + loc_cWherC

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpContaTmp") < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! " + ;
                        "(cursor_4c_TmpConta) " + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
                ELSE
                    *-- Cursor do SQLEXEC nasce READ-ONLY: converter para
                    *-- READWRITE, senao o REPLACE/DELETE do Scan estoura
                    SELECT * FROM cursor_4c_TmpContaTmp ;
                        INTO CURSOR cursor_4c_TmpConta READWRITE
                    THIS.FecharCursorProcesso("cursor_4c_TmpContaTmp")

                    SELECT cursor_4c_TmpConta
                    SCAN
                        REPLACE CidChaves WITH fUniqueIds()
                    ENDSCAN
                    INDEX ON CidChaves TAG CidChaves
                    loc_lSucesso = .T.
                ENDIF

            ENDIF

            IF loc_lSucesso AND USED("cursor_4c_TmpConta")

                *-- Laco externo do legado: reprocessa o que sobrou em
                *-- TmpConta ate a lista esvaziar (linha recalculada eh
                *-- apagada; linha que falhou permanece e eh retentada)
                DO WHILE .T.
                    THIS.FecharCursorProcesso("cursor_4c_Selecao")
                    SELECT * FROM cursor_4c_TmpConta ;
                        INTO CURSOR cursor_4c_Selecao READWRITE ;
                        ORDER BY Emps, Grupos, Contas, Moedas

                    IF !USED("cursor_4c_Selecao") OR RECCOUNT("cursor_4c_Selecao") = 0
                        EXIT
                    ENDIF

                    loc_nRestantes = RECCOUNT("cursor_4c_Selecao")
                    loc_oProg = CREATEOBJECT("fwprogressbar", ;
                        "Recalculando Saldo de Conta Corrente", loc_nRestantes)
                    loc_oProg.Titulo.FontBold = .T.
                    loc_oProg.Show()

                    SELECT cursor_4c_Selecao
                    SCAN
                        loc_nRestantes = loc_nRestantes - 1
                        THIS.AtualizarProgresso(loc_nRestantes, loc_oProg, ;
                            ALLTRIM(cursor_4c_Selecao.Grupos) + " : " + ;
                            ALLTRIM(cursor_4c_Selecao.Contas) + "-" + ;
                            ALLTRIM(cursor_4c_Selecao.Moedas))

                        *-- 1a chamada acumula, 2a (.T.) grava - contrato do
                        *-- fRecalculaS portado (utils\functions.prg)
                        =fRecalculaS(cursor_4c_Selecao.Grupos, cursor_4c_Selecao.Contas, ;
                            loc_dPData, cursor_4c_Selecao.Moedas, gnConnHandle)

                        loc_lOk = fRecalculaS(.T., gnConnHandle, .T.)
                        IF !loc_lOk
                            =SQLROLLBACK(gnConnHandle)
                            LOOP
                        ENDIF

                        loc_lOk = (SQLCOMMIT(gnConnHandle) > 0)
                        IF !loc_lOk
                            =SQLROLLBACK(gnConnHandle)
                            LOOP
                        ENDIF

                        SELECT cursor_4c_TmpConta
                        IF SEEK(cursor_4c_Selecao.CidChaves, "cursor_4c_TmpConta", "CidChaves")
                            DELETE
                        ENDIF
                        SELECT cursor_4c_Selecao
                    ENDSCAN

                    loc_oProg.Complete(.T.)
                    loc_oProg = .NULL.
                    THIS.FecharCursorProcesso("cursor_4c_Selecao")
                ENDDO

            ENDIF

            THIS.FecharCursorProcesso("cursor_4c_TmpConta")
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                CHR(13) + "Procedure: " + loc_oErro.Procedure, ;
                "Erro em RecalcularContaCorrente")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * RecalcularEstoque - ramo "If ThisForm.Estoque.Value" de Processa.Click.
    * Seleciona as combinacoes distintas de SigMvHst e chama fRecalculaP()
    * para cada uma, com COMMIT por linha.
    *
    * O filtro sobre EmpGruEsts (char concatenado Emps+Grupos+Estos) tem os
    * TRES casos do Do Case legado: igualdade quando os 3 estao preenchidos,
    * sem filtro quando nenhum, e BETWEEN com CHR(254) como limite superior
    * nos casos intermediarios. EmpGruEsts eh chave POSICIONAL: as partes vao
    * com PADR na largura da coluna (3/10/10), NUNCA com ALLTRIM (regra #42).
    *==========================================================================
    PROCEDURE RecalcularEstoque()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cWhere
        LOCAL loc_cEmpresa, loc_cGrupo, loc_cEstoque, loc_cCPros
        LOCAL loc_cEmpIni, loc_cGruIni, loc_cEstIni
        LOCAL loc_cEmpFin, loc_cGruFin, loc_cEstFin
        LOCAL loc_dPData, loc_nRestantes, loc_oProg, loc_lOk
        loc_lSucesso = .F.

        TRY
            loc_cEstoque = PADR(THIS.this_cEstoqueEstoque, 10)
            loc_cEmpresa = PADR(THIS.this_cEstoqueEmpresa, 3)
            loc_cGrupo   = PADR(THIS.this_cEstoqueGrupo, 10)
            loc_cCPros   = PADR(THIS.this_cEstoqueProduto, 14)
            loc_dPData   = fDtoSQL(THIS.this_dEstoqueData)

            DO CASE
                CASE !EMPTY(loc_cEmpresa) AND !EMPTY(loc_cGrupo) AND !EMPTY(loc_cEstoque)
                    loc_cWhere = "EmpGruEsts = " + ;
                        EscaparSQL(loc_cEmpresa + loc_cGrupo + loc_cEstoque) + " "
                CASE EMPTY(loc_cEmpresa) AND EMPTY(loc_cGrupo) AND EMPTY(loc_cEstoque)
                    loc_cWhere = ""
                OTHERWISE
                    loc_cEmpIni = IIF(EMPTY(loc_cEmpresa), SPACE(3),  loc_cEmpresa)
                    loc_cGruIni = IIF(EMPTY(loc_cGrupo),   SPACE(10), loc_cGrupo)
                    loc_cEstIni = IIF(EMPTY(loc_cEstoque), SPACE(10), loc_cEstoque)
                    loc_cEmpFin = IIF(EMPTY(loc_cEmpresa), REPLICATE(CHR(254), 3),  loc_cEmpresa)
                    loc_cGruFin = IIF(EMPTY(loc_cGrupo),   REPLICATE(CHR(254), 10), loc_cGrupo)
                    loc_cEstFin = IIF(EMPTY(loc_cEstoque), REPLICATE(CHR(254), 10), loc_cEstoque)
                    loc_cWhere = "EmpGruEsts BETWEEN " + ;
                        EscaparSQL(loc_cEmpIni + loc_cGruIni + loc_cEstIni) + " AND " + ;
                        EscaparSQL(loc_cEmpFin + loc_cGruFin + loc_cEstFin) + " "
            ENDCASE

            IF !EMPTY(loc_cCPros)
                loc_cWhere = IIF(EMPTY(loc_cWhere), "", loc_cWhere + " AND ") + ;
                    "CPros = " + EscaparSQL(loc_cCPros) + " "
            ENDIF
            IF !EMPTY(THIS.this_dEstoqueData)
                loc_cWhere = IIF(EMPTY(loc_cWhere), "", loc_cWhere + " AND ") + ;
                    "Datas >= " + FormatarDataSQL(loc_dPData) + " "
            ENDIF
            loc_cWhere = IIF(EMPTY(loc_cWhere), "", "WHERE " + loc_cWhere)

            loc_cSQL = "SELECT DISTINCT Emps, Grupos, Estos, Cpros, CodCors, CodTams, " + ;
                "SPACE(20) AS CidChaves FROM SigMvHst " + loc_cWhere

            THIS.FecharCursorProcesso("cursor_4c_TmpEst")
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpEstTmp") < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! " + ;
                    "(cursor_4c_TmpEst) " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
            ELSE
                SELECT * FROM cursor_4c_TmpEstTmp INTO CURSOR cursor_4c_TmpEst READWRITE
                THIS.FecharCursorProcesso("cursor_4c_TmpEstTmp")

                SELECT cursor_4c_TmpEst
                SCAN
                    REPLACE CidChaves WITH fUniqueIds()
                ENDSCAN
                INDEX ON CidChaves TAG CidChaves

                DO WHILE .T.
                    THIS.FecharCursorProcesso("cursor_4c_Selecao")
                    SELECT * FROM cursor_4c_TmpEst ;
                        INTO CURSOR cursor_4c_Selecao READWRITE

                    IF !USED("cursor_4c_Selecao") OR RECCOUNT("cursor_4c_Selecao") = 0
                        EXIT
                    ENDIF

                    loc_nRestantes = RECCOUNT("cursor_4c_Selecao")
                    loc_oProg = CREATEOBJECT("fwprogressbar", ;
                        "Recalculando Saldo do Estoque", loc_nRestantes)
                    loc_oProg.Titulo.FontBold = .T.
                    loc_oProg.Show()

                    SELECT cursor_4c_Selecao
                    SCAN
                        loc_nRestantes = loc_nRestantes - 1
                        THIS.AtualizarProgresso(loc_nRestantes, loc_oProg, ;
                            ALLTRIM(cursor_4c_Selecao.Estos) + " : " + ;
                            ALLTRIM(cursor_4c_Selecao.CPros))

                        =fRecalculaP(cursor_4c_Selecao.Emps, cursor_4c_Selecao.Grupos, ;
                            cursor_4c_Selecao.Estos, cursor_4c_Selecao.CPros, loc_dPData, ;
                            cursor_4c_Selecao.CodCors, cursor_4c_Selecao.CodTams, gnConnHandle)

                        loc_lOk = fRecalculaP(.T., gnConnHandle, .T.)
                        IF !loc_lOk
                            =SQLROLLBACK(gnConnHandle)
                            LOOP
                        ENDIF

                        loc_lOk = (SQLCOMMIT(gnConnHandle) > 0)
                        IF !loc_lOk
                            =SQLROLLBACK(gnConnHandle)
                            LOOP
                        ENDIF

                        SELECT cursor_4c_TmpEst
                        IF SEEK(cursor_4c_Selecao.CidChaves, "cursor_4c_TmpEst", "CidChaves")
                            DELETE
                        ENDIF
                        SELECT cursor_4c_Selecao
                    ENDSCAN

                    loc_oProg.Complete(.T.)
                    loc_oProg = .NULL.
                    THIS.FecharCursorProcesso("cursor_4c_Selecao")
                ENDDO

                loc_lSucesso = .T.
            ENDIF

            THIS.FecharCursorProcesso("cursor_4c_TmpEst")
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em RecalcularEstoque")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * RecalcularCustoProduto - ramo "If ThisForm.btnCusto.Value" de
    * Processa.Click. Para cada Empresa x Produto chama fRecalculaC(), com
    * COMMIT por produto.
    *
    * SigCdPac.CalcCustos decide a origem da lista de produtos (llEmp do
    * legado): quando CalcCustos <> 1 o custo eh POR EMPRESA e os produtos
    * saem de SigMvEst daquela empresa; quando = 1 o custo eh global e a
    * lista eh a de SigCdPro, processada UMA vez so (o "If Not llEmp / Exit"
    * do legado sai do Scan de empresas apos a primeira).
    *==========================================================================
    PROCEDURE RecalcularCustoProduto()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cEmp, loc_cPro
        LOCAL loc_dData, loc_lPorEmpresa, loc_nRestantes, loc_oProg, loc_lOk
        LOCAL loc_lFalhou
        loc_lSucesso    = .F.
        loc_lFalhou     = .F.
        loc_lPorEmpresa = .T.

        TRY
            loc_cEmp  = PADR(THIS.this_cCustoEmpresa, 3)
            loc_cPro  = PADR(THIS.this_cCustoProduto, 14)
            loc_dData = fDtoSQL(THIS.this_dCustoData)

            *-- Empresas a processar
            THIS.FecharCursorProcesso("cursor_4c_LocalEmp")
            loc_cSQL = "SELECT Cemps FROM SigCdEmp WHERE NOT Cemps = SPACE(3)" + ;
                IIF(EMPTY(loc_cEmp), "", " AND Cemps = " + EscaparSQL(loc_cEmp))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalEmp") < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! " + ;
                    "(cursor_4c_LocalEmp) " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
                loc_lFalhou = .T.
            ENDIF

            *-- SigCdPac.CalcCustos: custo por empresa ou global
            IF !loc_lFalhou
                THIS.FecharCursorProcesso("cursor_4c_LocalParac")
                IF SQLEXEC(gnConnHandle, "SELECT Calccustos FROM SigCdPac", ;
                        "cursor_4c_LocalParac") < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! " + ;
                        "(cursor_4c_LocalParac) " + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
                    loc_lFalhou = .T.
                ELSE
                    *-- Coluna bit/numeric conforme o driver: testar VARTYPE
                    *-- antes de comparar (regra #13)
                    IF USED("cursor_4c_LocalParac") AND !EOF("cursor_4c_LocalParac")
                        IF VARTYPE(cursor_4c_LocalParac.Calccustos) = "L"
                            loc_lPorEmpresa = !cursor_4c_LocalParac.Calccustos
                        ELSE
                            loc_lPorEmpresa = (NVL(cursor_4c_LocalParac.Calccustos, 0) <> 1)
                        ENDIF
                    ENDIF
                    THIS.FecharCursorProcesso("cursor_4c_LocalParac")
                ENDIF
            ENDIF

            *-- Lista global de produtos (usada quando o custo NAO eh por empresa)
            IF !loc_lFalhou
                THIS.FecharCursorProcesso("cursor_4c_LocalPro2")
                loc_cSQL = "SELECT Cpros FROM SigCdPro WHERE NOT Cpros = SPACE(14)" + ;
                    IIF(EMPTY(loc_cPro), "", " AND Cpros = " + EscaparSQL(loc_cPro))
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro2") < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! " + ;
                        "(cursor_4c_LocalPro2) " + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
                    loc_lFalhou = .T.
                ENDIF
            ENDIF

            IF !loc_lFalhou AND USED("cursor_4c_LocalEmp")

                SELECT cursor_4c_LocalEmp
                GO TOP
                SCAN

                    THIS.FecharCursorProcesso("cursor_4c_LocalPro")
                    IF loc_lPorEmpresa
                        loc_cSQL = "SELECT DISTINCT Cpros FROM SigMvEst WHERE Emps = " + ;
                            EscaparSQL(cursor_4c_LocalEmp.Cemps) + ;
                            " AND NOT Cpros = SPACE(14)" + ;
                            IIF(EMPTY(loc_cPro), "", " AND Cpros = " + EscaparSQL(loc_cPro))
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro") < 1
                            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! " + ;
                                "(cursor_4c_LocalPro) " + CapturarErroSQL()
                            MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
                            loc_lFalhou = .T.
                            EXIT
                        ENDIF
                    ELSE
                        SELECT * FROM cursor_4c_LocalPro2 ;
                            INTO CURSOR cursor_4c_LocalPro READWRITE
                    ENDIF

                    loc_nRestantes = IIF(USED("cursor_4c_LocalPro"), ;
                        RECCOUNT("cursor_4c_LocalPro"), 0)

                    loc_oProg = CREATEOBJECT("fwprogressbar", ;
                        "Preparando Arquivo de Rec" + CHR(225) + "lculo do Custo de Produtos", ;
                        loc_nRestantes)
                    loc_oProg.Titulo.FontBold = .T.
                    loc_oProg.Show()

                    SELECT cursor_4c_LocalPro
                    SCAN
                        loc_nRestantes = loc_nRestantes - 1
                        THIS.AtualizarProgresso(loc_nRestantes, loc_oProg, ;
                            "Empresa : " + cursor_4c_LocalEmp.Cemps + ;
                            " - Produto : " + cursor_4c_LocalPro.CPros)

                        =fRecalculaC(cursor_4c_LocalEmp.Cemps, cursor_4c_LocalPro.CPros, ;
                            loc_dData, gnConnHandle)

                        loc_lOk = fRecalculaC(.T., .T., .F., gnConnHandle, .T.)
                        IF !loc_lOk
                            =SQLROLLBACK(gnConnHandle)
                            LOOP
                        ENDIF

                        loc_lOk = (SQLCOMMIT(gnConnHandle) > 0)
                        IF !loc_lOk
                            =SQLROLLBACK(gnConnHandle)
                            LOOP
                        ENDIF

                        SELECT cursor_4c_LocalPro
                    ENDSCAN

                    loc_oProg.Complete(.T., .T.)
                    loc_oProg = .NULL.

                    *-- Custo global: a lista de SigCdPro nao depende da
                    *-- empresa, entao processa UMA vez so
                    IF !loc_lPorEmpresa
                        EXIT
                    ENDIF
                    SELECT cursor_4c_LocalEmp
                ENDSCAN

                loc_lSucesso = !loc_lFalhou
            ENDIF

            THIS.FecharCursorProcesso("cursor_4c_LocalPro")
            THIS.FecharCursorProcesso("cursor_4c_LocalPro2")
            THIS.FecharCursorProcesso("cursor_4c_LocalEmp")
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em RecalcularCustoProduto")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AtualizarUltimaCompra - ramo "If ThisForm.BtnCompra.Value" de
    * Processa.Click, em quatro etapas:
    *   1. limpa SigOpClU e remonta a partir de SigMvCab/SigMvItn as
    *      movimentacoes cuja operacao gera "Gdmi" (SigCdTom.GerGdmis);
    *   2. grava as linhas em SigOpClU (uma por titulo ou por item);
    *   3. atualiza SigCdCli.UltComps/vUltComps (ultima data) e
    *      dtfats/mfats (maior valor) por cliente;
    *   4. atualiza SigCdPro.UltComps/vUltComps/mUltComps por produto.
    *
    * GerGdmis = 1 + TpGdmis = 1  -> valor do TITULO, na conta contabil
    *   (Contads quando cOpers = 1, senao ContaOs), convertido para a moeda
    *   central (SigCdPam.moecentral) via fBuscarCotacao.
    * GerGdmis = 2 + AtuCompras = 1 -> valor UNITARIO de cada item de SigMvItn.
    *==========================================================================
    PROCEDURE AtualizarUltimaCompra()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cEmp, loc_cPro, loc_dData
        LOCAL loc_nRestantes, loc_oProg, loc_cConta, loc_nValorCentral
        LOCAL loc_nCotaCentral, loc_nCotaOperac, loc_dDataMov, loc_lFalhou
        LOCAL loc_nGerGdmis, loc_nTpGdmis, loc_nAtuCompras, loc_nCopers
        LOCAL loc_cChave, loc_nValor, loc_cMoeda
        loc_lSucesso = .F.
        loc_lFalhou  = .F.

        TRY
            loc_cEmp  = PADR(THIS.this_cCompraEmpresa, 3)
            loc_cPro  = PADR(THIS.this_cCompraProduto, 14)
            loc_dData = fDtoSQL(THIS.this_dCompraData)

            *-- Etapa 1: "Select CrSigOpClU / Zap" do legado - a tabela de
            *-- apoio eh reconstruida a cada processamento
            IF SQLEXEC(gnConnHandle, "DELETE FROM SigOpClU") < 0
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! " + ;
                    "(Limpar SigOpClU) " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
                loc_lFalhou = .T.
            ELSE
                =SQLCOMMIT(gnConnHandle)
            ENDIF

            *-- Cabecalhos de movimento cuja operacao gera Gdmi
            IF !loc_lFalhou
                THIS.FecharCursorProcesso("cursor_4c_TprMvCab")
                loc_cSQL = "SELECT a.datas, a.Emps, a.Dopes, a.Numes, a.EmpDopNums, " + ;
                    "a.Valos, a.Contads, a.ContaOs, " + ;
                    "c.GerGdmis, c.atuCompras, c.TpGdmis, b.cOpers, b.cmoes " + ;
                    "FROM SigMvCab a, SigCdOpe b, SigCdTom c " + ;
                    "WHERE a.Dopes = b.Dopes AND b.TipoOps = c.Codigos AND " + ;
                    "((c.GerGdmis = 1 AND c.TpGdmis = 1) OR " + ;
                    "(c.GerGdmis = 2 AND c.AtuCompras = 1)) AND " + ;
                    "a.Datas >= " + FormatarDataSQL(loc_dData) + " " + ;
                    IIF(EMPTY(loc_cEmp), "", "AND a.Emps = " + EscaparSQL(loc_cEmp) + " ")
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TprMvCab") < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! " + ;
                        "(cursor_4c_TprMvCab) " + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
                    loc_lFalhou = .T.
                ENDIF
            ENDIF

            *-- Itens dos movimentos que atualizam compra por ITEM
            IF !loc_lFalhou
                THIS.FecharCursorProcesso("cursor_4c_TpmMvItn")
                loc_cSQL = "SELECT Emps, Dopes, Numes, EmpDopNums, Cpros, Units, Moedas " + ;
                    "FROM SigMvItn WHERE EmpDopNums IN " + ;
                    "(SELECT EmpDopNums FROM SigMvCab a, SigCdOpe b, SigCdTom c " + ;
                    "WHERE a.Dopes = b.Dopes AND b.TipoOps = c.Codigos AND " + ;
                    "c.GerGdmis = 2 AND c.AtuCompras = 1 AND " + ;
                    "a.Datas >= " + FormatarDataSQL(loc_dData) + " " + ;
                    IIF(EMPTY(loc_cEmp), "", "AND a.Emps = " + EscaparSQL(loc_cEmp) + " ") + ")"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TpmMvItnTmp") < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! " + ;
                        "(cursor_4c_TpmMvItn) " + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
                    loc_lFalhou = .T.
                ELSE
                    *-- INDEX ON exige cursor READWRITE
                    SELECT * FROM cursor_4c_TpmMvItnTmp ;
                        INTO CURSOR cursor_4c_TpmMvItn READWRITE
                    THIS.FecharCursorProcesso("cursor_4c_TpmMvItnTmp")
                    SELECT cursor_4c_TpmMvItn
                    INDEX ON EmpDopNums TAG EmpDopNums
                ENDIF
            ENDIF

            *-- Etapa 2: percorrer os cabecalhos e montar SigOpClU
            IF !loc_lFalhou
                loc_nRestantes = RECCOUNT("cursor_4c_TprMvCab")
                loc_oProg = CREATEOBJECT("fwprogressbar", ;
                    "Preparando Arquivo de Atualiza" + CHR(231) + CHR(227) + ;
                    "o da Ultima Compra", loc_nRestantes)
                loc_oProg.Titulo.FontBold = .T.
                loc_oProg.Show()

                SELECT cursor_4c_TprMvCab
                GO TOP
                SCAN
                    loc_nRestantes = loc_nRestantes - 1
                    THIS.AtualizarProgresso(loc_nRestantes, loc_oProg, ;
                        cursor_4c_TprMvCab.Emps + " " + cursor_4c_TprMvCab.Dopes + ;
                        " " + STR(cursor_4c_TprMvCab.Numes, 6))

                    loc_cChave      = cursor_4c_TprMvCab.EmpDopNums
                    loc_dDataMov    = ConverterParaData(cursor_4c_TprMvCab.Datas)
                    loc_nGerGdmis   = NVL(cursor_4c_TprMvCab.GerGdmis, 0)
                    loc_nTpGdmis    = NVL(cursor_4c_TprMvCab.TpGdmis, 0)
                    loc_nAtuCompras = NVL(cursor_4c_TprMvCab.atuCompras, 0)
                    loc_nCopers     = NVL(cursor_4c_TprMvCab.cOpers, 0)

                    *-- Valor do TITULO na conta contabil, em moeda central
                    IF loc_nGerGdmis = 1 AND loc_nTpGdmis = 1
                        loc_cConta = IIF(loc_nCopers = 1, ;
                            cursor_4c_TprMvCab.Contads, cursor_4c_TprMvCab.ContaOs)

                        IF ALLTRIM(NVL(cursor_4c_TprMvCab.cmoes, "")) != ;
                                ALLTRIM(THIS.this_cMoeCentral)
                            loc_nCotaCentral = fBuscarCotacao(THIS.this_cMoeCentral, ;
                                loc_dDataMov, gnConnHandle)
                            loc_nCotaOperac  = fBuscarCotacao(cursor_4c_TprMvCab.cmoes, ;
                                loc_dDataMov, gnConnHandle)
                            IF loc_nCotaCentral = 0
                                loc_nValorCentral = NVL(cursor_4c_TprMvCab.Valos, 0)
                            ELSE
                                loc_nValorCentral = ROUND(NVL(cursor_4c_TprMvCab.Valos, 0) * ;
                                    loc_nCotaOperac / loc_nCotaCentral, 2)
                            ENDIF
                        ELSE
                            loc_nValorCentral = NVL(cursor_4c_TprMvCab.Valos, 0)
                        ENDIF

                        THIS.GravarApoioUltimaCompra(cursor_4c_TprMvCab.Emps, ;
                            cursor_4c_TprMvCab.Dopes, cursor_4c_TprMvCab.Numes, ;
                            loc_cChave, loc_cConta, "", loc_nValorCentral, ;
                            loc_dDataMov, "")
                    ENDIF

                    *-- Valor UNITARIO de cada item do movimento
                    IF loc_nGerGdmis = 2 AND loc_nAtuCompras = 1 AND USED("cursor_4c_TpmMvItn")
                        SELECT cursor_4c_TpmMvItn
                        IF SEEK(loc_cChave, "cursor_4c_TpmMvItn", "EmpDopNums")
                            SCAN WHILE ALLTRIM(cursor_4c_TpmMvItn.EmpDopNums) == ;
                                    ALLTRIM(loc_cChave)
                                IF EMPTY(cursor_4c_TpmMvItn.Cpros)
                                    LOOP
                                ENDIF
                                loc_nValor = NVL(cursor_4c_TpmMvItn.Units, 0)
                                loc_cMoeda = NVL(cursor_4c_TpmMvItn.Moedas, "")

                                THIS.GravarApoioUltimaCompra(cursor_4c_TprMvCab.Emps, ;
                                    cursor_4c_TprMvCab.Dopes, cursor_4c_TprMvCab.Numes, ;
                                    loc_cChave, "", cursor_4c_TpmMvItn.Cpros, ;
                                    loc_nValor, loc_dDataMov, loc_cMoeda)
                            ENDSCAN
                        ENDIF
                        SELECT cursor_4c_TprMvCab
                    ENDIF
                ENDSCAN

                loc_oProg.Complete(.T., .T.)
                loc_oProg = .NULL.
                =SQLCOMMIT(gnConnHandle)

                *-- Etapas 3 e 4: aplicar o apoio em SigCdCli e SigCdPro
                THIS.FecharCursorProcesso("cursor_4c_CsSelecao")
                IF SQLEXEC(gnConnHandle, "SELECT * FROM SigOpClU", "cursor_4c_CsSelecao") < 0
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! " + ;
                        "(cursor_4c_CsSelecao) " + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
                    loc_lFalhou = .T.
                ELSE
                    loc_lFalhou = !THIS.AtualizarUltimaCompraClientes()
                    IF !loc_lFalhou
                        loc_lFalhou = !THIS.AtualizarUltimaCompraProdutos()
                    ENDIF
                ENDIF

                loc_lSucesso = !loc_lFalhou
            ENDIF

            THIS.FecharCursorProcesso("cursor_4c_CsSelecao")
            THIS.FecharCursorProcesso("cursor_4c_TpmMvItn")
            THIS.FecharCursorProcesso("cursor_4c_TprMvCab")
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em AtualizarUltimaCompra")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * GravarApoioUltimaCompra - uma linha de SigOpClU (equivale a cada
    * "Insert Into CrSigOpClU (...)" do legado). Preenche TODAS as colunas
    * NOT NULL da tabela (regra #22): as que o legado nao informa recebem o
    * default do tipo, e cidchaves vem de fUniqueIds() (NUNCA vazio, senao a
    * 2a linha colide na PK).
    *==========================================================================
    PROTECTED PROCEDURE GravarApoioUltimaCompra(par_cEmps, par_cDopes, par_nNumes, ;
            par_cEmpDopNums, par_cIclis, par_cCpros, par_nValors, par_dDatas, par_cMoedas)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigOpClU " + ;
                "(cidchaves, emps, dopes, numes, empdopnums, " + ;
                "iclis, cpros, valors, datas, moedas, qtds) VALUES (" + ;
                EscaparSQL(fUniqueIds()) + ", " + ;
                EscaparSQL(LEFT(par_cEmps, 3)) + ", " + ;
                EscaparSQL(LEFT(par_cDopes, 20)) + ", " + ;
                FormatarNumeroSQL(par_nNumes, 0) + ", " + ;
                EscaparSQL(LEFT(par_cEmpDopNums, 29)) + ", " + ;
                EscaparSQL(LEFT(par_cIclis, 10)) + ", " + ;
                EscaparSQL(LEFT(par_cCpros, 14)) + ", " + ;
                FormatarNumeroSQL(par_nValors, 2) + ", " + ;
                FormatarDataSQL(par_dDatas) + ", " + ;
                EscaparSQL(LEFT(par_cMoedas, 3)) + ", " + ;
                FormatarNumeroSQL(0, 0) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                THIS.this_cMensagemErro = "Erro ao gravar SigOpClU: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro em GravarApoioUltimaCompra")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AtualizarUltimaCompraClientes - etapa 3 do ramo BtnCompra: para cada
    * cliente presente em SigOpClU grava em SigCdCli a ultima compra por
    * DATA (UltComps/vUltComps) e o maior faturamento por VALOR
    * (dtfats/mfats), igual aos dois "Select Top 1 ... Order by" do legado.
    *==========================================================================
    PROTECTED PROCEDURE AtualizarUltimaCompraClientes()
        LOCAL loc_lSucesso, loc_oErro, loc_nRestantes, loc_oProg, loc_cConta
        loc_lSucesso = .F.

        TRY
            THIS.FecharCursorProcesso("cursor_4c_SelecaoCli")
            SELECT DISTINCT Iclis FROM cursor_4c_CsSelecao ;
                WHERE !EMPTY(Iclis) INTO CURSOR cursor_4c_SelecaoCli READWRITE

            loc_nRestantes = IIF(USED("cursor_4c_SelecaoCli"), ;
                RECCOUNT("cursor_4c_SelecaoCli"), 0)

            loc_oProg = CREATEOBJECT("fwprogressbar", ;
                "Atualizando Valor da Ultima Compra Clientes", loc_nRestantes)
            loc_oProg.Titulo.FontBold = .T.
            loc_oProg.Show()

            SELECT cursor_4c_SelecaoCli
            SCAN
                loc_nRestantes = loc_nRestantes - 1
                loc_cConta = ALLTRIM(cursor_4c_SelecaoCli.Iclis)
                THIS.AtualizarProgresso(loc_nRestantes, loc_oProg, "Cliente " + loc_cConta)

                *-- Ultima compra (maior Datas) -> UltComps / vUltComps
                THIS.AplicarTopoSigOpClU("SigCdCli", "Iclis", loc_cConta, ;
                    "Datas DESC", "UltComps", "vUltComps", "")

                *-- Maior valor (maior Valors) -> dtfats / mfats
                THIS.AplicarTopoSigOpClU("SigCdCli", "Iclis", loc_cConta, ;
                    "Valors DESC", "dtfats", "mfats", "")

                =SQLCOMMIT(gnConnHandle)
                SELECT cursor_4c_SelecaoCli
            ENDSCAN

            loc_oProg.Complete(.T., .T.)
            loc_oProg = .NULL.
            THIS.FecharCursorProcesso("cursor_4c_SelecaoCli")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em AtualizarUltimaCompraClientes")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AtualizarUltimaCompraProdutos - etapa 4 do ramo BtnCompra: para cada
    * produto presente em SigOpClU grava em SigCdPro a ultima compra
    * (UltComps/vUltComps) e a moeda dela (mUltComps).
    *==========================================================================
    PROTECTED PROCEDURE AtualizarUltimaCompraProdutos()
        LOCAL loc_lSucesso, loc_oErro, loc_nRestantes, loc_oProg, loc_cProduto
        loc_lSucesso = .F.

        TRY
            THIS.FecharCursorProcesso("cursor_4c_SelecaoPro")
            SELECT DISTINCT Cpros FROM cursor_4c_CsSelecao ;
                WHERE !EMPTY(Cpros) INTO CURSOR cursor_4c_SelecaoPro READWRITE

            loc_nRestantes = IIF(USED("cursor_4c_SelecaoPro"), ;
                RECCOUNT("cursor_4c_SelecaoPro"), 0)

            loc_oProg = CREATEOBJECT("fwprogressbar", ;
                "Atualizando Valor da Ultima Compra Produtos", loc_nRestantes)
            loc_oProg.Titulo.FontBold = .T.
            loc_oProg.Show()

            SELECT cursor_4c_SelecaoPro
            SCAN
                loc_nRestantes = loc_nRestantes - 1
                loc_cProduto = ALLTRIM(cursor_4c_SelecaoPro.Cpros)
                THIS.AtualizarProgresso(loc_nRestantes, loc_oProg, "Produto " + loc_cProduto)

                THIS.AplicarTopoSigOpClU("SigCdPro", "Cpros", loc_cProduto, ;
                    "Datas DESC", "UltComps", "vUltComps", "mUltComps")

                =SQLCOMMIT(gnConnHandle)
                SELECT cursor_4c_SelecaoPro
            ENDSCAN

            loc_oProg.Complete(.T., .T.)
            loc_oProg = .NULL.
            THIS.FecharCursorProcesso("cursor_4c_SelecaoPro")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em AtualizarUltimaCompraProdutos")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AplicarTopoSigOpClU - le a linha TOPO de SigOpClU para uma chave
    * (ordenada por par_cOrdem) e grava data/valor/moeda na tabela destino.
    * Equivale ao par "Select Top 1 ... Order by ..." + "UpDate <tabela> Set
    * ..." do legado. Sem linha na origem, a data vai NULL (o
    * Iif(Reccount()=0, Null, ...) do legado) e valor/moeda ficam zerados.
    *==========================================================================
    PROTECTED PROCEDURE AplicarTopoSigOpClU(par_cTabela, par_cCampoChave, par_cValorChave, ;
            par_cOrdem, par_cCampoData, par_cCampoValor, par_cCampoMoeda)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cCursor
        LOCAL loc_cDataSQL, loc_nValor, loc_cMoeda
        loc_lSucesso = .F.
        loc_cCursor  = "cursor_4c_LocalCalcU"

        TRY
            THIS.FecharCursorProcesso(loc_cCursor)
            loc_cSQL = "SELECT TOP 1 Datas, Valors, Moedas FROM SigOpClU WHERE " + ;
                par_cCampoChave + " = " + EscaparSQL(par_cValorChave) + ;
                " ORDER BY " + par_cOrdem

            IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor) < 0
                THIS.this_cMensagemErro = "Favor reinicializar o processo. " + ;
                    "(cursor_4c_LocalCalcU) " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
            ELSE
                loc_cDataSQL = "NULL"
                loc_nValor   = 0
                loc_cMoeda   = ""

                IF USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
                    SELECT (loc_cCursor)
                    GO TOP
                    loc_cDataSQL = FormatarDataSQL(ConverterParaData(Datas))
                    loc_nValor   = NVL(Valors, 0)
                    loc_cMoeda   = NVL(Moedas, "")
                ENDIF
                THIS.FecharCursorProcesso(loc_cCursor)

                loc_cSQL = "UPDATE " + par_cTabela + " SET " + ;
                    par_cCampoData + " = " + loc_cDataSQL + ", " + ;
                    par_cCampoValor + " = " + FormatarNumeroSQL(loc_nValor, 2) + ;
                    IIF(EMPTY(par_cCampoMoeda), "", ", " + par_cCampoMoeda + " = " + ;
                        EscaparSQL(LEFT(loc_cMoeda, 3))) + ;
                    " WHERE " + par_cCampoChave + " = " + EscaparSQL(par_cValorChave)

                IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                    THIS.this_cMensagemErro = "Favor reinicializar o processo. " + ;
                        "(Update " + par_cTabela + ") " + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro em AplicarTopoSigOpClU")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AtualizarProgresso - centraliza o par "ThisForm.Get_Registro.Value =
    * lnReg / Refresh" + "Prog.SubTitulo.Caption = ... / Prog.Update(.t.)"
    * repetido em todos os Scan do legado. O contador tambem fica em
    * this_nRegistros, para quem nao tem referencia de form.
    *==========================================================================
    PROTECTED PROCEDURE AtualizarProgresso(par_nRestantes, par_oProgresso, par_cSubTitulo)
        THIS.this_nRegistros = par_nRestantes

        IF VARTYPE(THIS.this_oFormUI) = "O"
            THIS.this_oFormUI.AtualizarContadorRegistros(par_nRestantes)
        ENDIF

        IF VARTYPE(par_oProgresso) = "O"
            IF VARTYPE(par_cSubTitulo) = "C"
                par_oProgresso.SubTitulo.Caption = par_cSubTitulo
            ENDIF
            par_oProgresso.Update(.T.)
        ENDIF
    ENDPROC

    *==========================================================================
    * FecharCursorProcesso - fecha um cursor de trabalho se estiver aberto,
    * revertendo buffer pendente (evita "Table buffer contains uncommitted
    * changes" na proxima passada do processamento)
    *==========================================================================
    PROTECTED PROCEDURE FecharCursorProcesso(par_cCursor)
        IF VARTYPE(par_cCursor) = "C" AND USED(par_cCursor)
            TABLEREVERT(.T., par_cCursor)
            USE IN SELECT(par_cCursor)
        ENDIF
    ENDPROC

ENDDEFINE

