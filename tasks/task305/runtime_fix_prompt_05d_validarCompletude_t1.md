# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[FormSigPrIns.prg] Procedure vazia (sem codigo): ConfigurarPageFrame
[FormSigPrIns.prg] Procedure vazia (sem codigo): ConfigurarPaginaLista
[FormSigPrIns.prg] Procedure vazia (sem codigo): AlternarPagina
[FormSigPrIns.prg] Procedure vazia (sem codigo): ConfigurarPaginaDados
[FormSigPrIns.prg] Procedure vazia (sem codigo): BtnIncluirClick
[FormSigPrIns.prg] Procedure vazia (sem codigo): BtnAlterarClick
[FormSigPrIns.prg] Procedure vazia (sem codigo): BtnVisualizarClick
[FormSigPrIns.prg] Procedure vazia (sem codigo): BtnExcluirClick
[FormSigPrIns.prg] Procedure vazia (sem codigo): AjustarBotoesPorModo
[FormSigPrIns.prg] Procedure vazia (sem codigo): BtnBuscarClick

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrIns.prg):
*==============================================================================
* FormSigPrIns.prg - Informacoes do Servico (dialog modal OPERACIONAL)
* Herda de: FormBase
* Tipo: OPERACIONAL - dialog modal pequeno
* Recebe: par_oFormPai (referencia ao form chamador)
* Devolve: par_oFormPai.cCodServ e par_oFormPai.nVlServ apos confirmacao
*==============================================================================

DEFINE CLASS FormSigPrIns AS FormBase

    *-- Dimensoes do dialog (pequeno - sem PageFrame)
    DataSession  = 1
    ShowWindow = 1
    Height       = 153
    Width        = 685
    AutoCenter   = .T.
    ControlBox   = .F.
    Movable      = .F.
    TitleBar     = 0
    WindowType   = 1
    AlwaysOnTop  = .T.
    ClipControls = .F.
    BorderStyle  = 2
    FontName     = "Tahoma"
    FontSize     = 8

    *-- Referencia ao form que abriu este dialog
    this_oFormPai = .NULL.

    *--------------------------------------------------------------------------
    * Init - Recebe referencia ao form pai ANTES de DODEFAULT
    * FormBase.Init() chamara InicializarForm() via DODEFAULT
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oFormPai)
        THIS.this_oFormPai = par_oFormPai
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configura todo o dialog
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cCodServ, loc_cDescServ, loc_nVlServ

        loc_lSucesso = .F.

        TRY
            THIS.Caption = "Informa" + CHR(231) + CHR(245) + "es do Servi" + CHR(231) + "o"

            *-- Criar Business Object para lookup de descricao e auditoria
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrInsBO")

            *-- Ler valores iniciais do cursor LocalSacOp (do form pai - DataSession=1)
            IF USED("LocalSacOp") AND !EOF("LocalSacOp")
                loc_cCodServ = NVL(LocalSacOp.cCodServs, "")
                loc_nVlServ  = NVL(LocalSacOp.nVlServs,  0)
            ELSE
                loc_cCodServ = ""
                loc_nVlServ  = 0
            ENDIF

            *-- Buscar descricao do servico via BO
            loc_cDescServ = ""
            IF !EMPTY(loc_cCodServ)
                loc_cDescServ = THIS.this_oBusinessObject.BuscarDescricaoServico(loc_cCodServ)
            ENDIF

            *-- Desabilitar form pai enquanto dialog esta aberto
            IF VARTYPE(THIS.this_oFormPai) = "O"
                THIS.this_oFormPai.Enabled = .F.
            ENDIF

            *-- Montar controles do dialog
            THIS.ConfigurarCabecalho()
            THIS.ConfigurarCampos(loc_cCodServ, loc_cDescServ, loc_nVlServ)
            THIS.ConfigurarBotoes()

            *-- Foco no campo editavel
            THIS.txt_4c_Valor.SetFocus()

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Nao aplicavel a este dialog OPERACIONAL
    * Dialog pequeno (685x153) sem PageFrame; layout usa AddObject direto no form.
    * Mantido para satisfazer contrato do pipeline (validador multi-fase).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Nao aplicavel a este dialog OPERACIONAL
    * Dialog nao tem Page1 (Lista/Grid) nem botoes CRUD. O legado SIGPRINS e um
    * popup modal simples sem estrutura de cadastro. Satisfaz contrato multi-fase.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Nao aplicavel a este dialog OPERACIONAL
    * Dialog nao tem PageFrame nem multiplas paginas. Satisfaz contrato multi-fase.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Nao aplicavel a este dialog OPERACIONAL
    * Dialog nao tem Page2 (estrutura CRUD). Todos os campos sao criados em
    * ConfigurarCampos() diretamente no form flat. Satisfaz contrato multi-fase.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container cinza escuro com titulo (cntSombra legado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_cCaption

        loc_cCaption = "Informa" + CHR(231) + CHR(245) + "es do Servi" + CHR(231) + "o"

        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .AutoSize  = .F.
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .BackStyle = 0
                .Caption   = loc_cCaption
                .ForeColor = RGB(0, 0, 0)
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .AutoSize  = .F.
                .Top       = 17
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .BackStyle = 0
                .Caption   = loc_cCaption
                .ForeColor = RGB(255, 255, 255)
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCampos - Labels e TextBoxes (Servico readonly, Valor editavel)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCampos(par_cCodServ, par_cDescServ, par_nVlServ)
        *-- Label "Servico :"
        THIS.AddObject("lbl_4c_Servico", "Label")
        WITH THIS.lbl_4c_Servico
            .FontBold   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .BackStyle  = 0
            .Caption    = "Servi" + CHR(231) + "o :"
            .Height     = 17
            .Left       = 40
            .Top        = 95
            .Width      = 49
            .ForeColor  = RGB(90, 90, 90)
            .Visible    = .T.
        ENDWITH

        *-- TextBox codigo do servico (somente leitura - get_CodServ legado)
        THIS.AddObject("txt_4c_CodServ", "TextBox")
        WITH THIS.txt_4c_CodServ
            .FontName  = "Arial"
            .FontSize  = 9
            .Height    = 23
            .Left      = 96
            .Top       = 92
            .Width     = 80
            .ReadOnly  = .T.
            .Value     = par_cCodServ
            .Visible   = .T.
        ENDWITH

        *-- TextBox descricao do servico (somente leitura - get_DescServ legado)
        THIS.AddObject("txt_4c_DescServ", "TextBox")
        WITH THIS.txt_4c_DescServ
            .FontName  = "Arial"
            .FontSize  = 9
            .Height    = 23
            .Left      = 177
            .Top       = 92
            .Width     = 290
            .ReadOnly  = .T.
            .Value     = par_cDescServ
            .Visible   = .T.
        ENDWITH

        *-- Label "Valor :"
        THIS.AddObject("lbl_4c_Valor", "Label")
        WITH THIS.lbl_4c_Valor
            .FontBold   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .BackStyle  = 0
            .Caption    = "Valor :"
            .Height     = 17
            .Left       = 52
            .Top        = 122
            .Width      = 37
            .ForeColor  = RGB(90, 90, 90)
            .Visible    = .T.
        ENDWITH

        *-- TextBox valor do servico (editavel - get_Valor legado)
        THIS.AddObject("txt_4c_Valor", "TextBox")
        WITH THIS.txt_4c_Valor
            .FontName  = "Arial"
            .FontSize  = 9
            .Height    = 23
            .Left      = 96
            .Top       = 119
            .Width     = 100
            .InputMask = "9,999,999.99"
            .MaxLength = 12
            .Value     = par_nVlServ
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - Botoes Confirmar e Cancelar sobrepostos ao cabecalho
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        *-- Botao Confirmar (ok legado - Left=534)
        THIS.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH THIS.cmd_4c_Confirmar
            .Top             = 3
            .Left            = 534
            .Width           = 75
            .Height          = 75
            .Caption         = "Confirma"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes           = .T.
            .SpecialEffect   = 0
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .WordWrap        = .T.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH

        BINDEVENT(THIS.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")

        *-- Botao Cancelar (Cancela legado - Left=609)
        THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH THIS.cmd_4c_Cancelar
            .Top             = 3
            .Left            = 609
            .Width           = 75
            .Height          = 75
            .Caption         = "Cancela"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes           = .T.
            .SpecialEffect   = 0
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .WordWrap        = .T.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH

        BINDEVENT(THIS.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConfirmarClick - Valida valor e devolve ao form pai
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_nValor

        loc_nValor = THIS.txt_4c_Valor.Value

        IF loc_nValor <= 0
            MsgAviso("O valor do servi" + CHR(231) + "o deve ser informado!", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            THIS.txt_4c_Valor.SetFocus()
            RETURN
        ENDIF

        *-- Registrar auditoria via BO
        WITH THIS.this_oBusinessObject
            .this_cCodServs  = THIS.txt_4c_CodServ.Value
            .this_nVlServs   = loc_nValor
            .this_cDescServs = THIS.txt_4c_DescServ.Value
        ENDWITH
        THIS.this_oBusinessObject.RegistrarAuditoria("CONFIRMAR")

        *-- Devolver valores ao form pai e reabilitar
        IF VARTYPE(THIS.this_oFormPai) = "O"
            THIS.this_oFormPai.cCodServ = THIS.txt_4c_CodServ.Value
            THIS.this_oFormPai.nVlServ  = loc_nValor
            THIS.this_oFormPai.Enabled  = .T.
        ENDIF

        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Limpa valores e retorna ao form pai sem confirmar
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        IF VARTYPE(THIS.this_oFormPai) = "O"
            THIS.this_oFormPai.cCodServ = ""
            THIS.this_oFormPai.nVlServ  = 0
            THIS.this_oFormPai.Enabled  = .T.
        ENDIF

        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Nao aplicavel a este dialog OPERACIONAL
    * Dialog nao tem estrutura CRUD; acao principal eh BtnConfirmarClick.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Nao aplicavel a este dialog OPERACIONAL
    * Dialog nao tem estrutura CRUD; acao principal eh BtnConfirmarClick.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Nao aplicavel a este dialog OPERACIONAL
    * Dialog nao tem estrutura CRUD; campos sao exibidos diretamente no Init.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Nao aplicavel a este dialog OPERACIONAL
    * Dialog nao tem estrutura CRUD nem operacao de exclusao.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Popula propriedades do BO com valores dos campos do form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF
        THIS.this_oBusinessObject.this_cCodServs  = ALLTRIM(THIS.txt_4c_CodServ.Value)
        THIS.this_oBusinessObject.this_cDescServs = ALLTRIM(THIS.txt_4c_DescServ.Value)
        THIS.this_oBusinessObject.this_nVlServs   = THIS.txt_4c_Valor.Value
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Popula campos do form com valores do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF
        THIS.txt_4c_CodServ.Value  = THIS.this_oBusinessObject.this_cCodServs
        THIS.txt_4c_DescServ.Value = THIS.this_oBusinessObject.this_cDescServs
        THIS.txt_4c_Valor.Value    = THIS.this_oBusinessObject.this_nVlServs
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Controla habilitacao dos campos por modo
    * Apenas txt_4c_Valor e editavel; CodServ e DescServ sao sempre ReadOnly.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar AS Logical)
        THIS.txt_4c_Valor.Enabled = par_lHabilitar
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Reseta todos os campos do form para valores vazios
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        THIS.txt_4c_CodServ.Value  = ""
        THIS.txt_4c_DescServ.Value = ""
        THIS.txt_4c_Valor.Value    = 0
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Nao aplicavel a este dialog OPERACIONAL
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarLista() AS Logical
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Nao aplicavel a este dialog OPERACIONAL
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Nao aplicavel a este dialog OPERACIONAL
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Alias de BtnConfirmarClick para contrato do pipeline
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnConfirmarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha dialog sem confirmar (equivale a Cancelar)
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.BtnCancelarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpa referencia ao form pai antes de destruir
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.this_oFormPai = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrInsBO.prg):
*==============================================================================
* SigPrInsBO.prg - Business Object: Informacoes do Servico
* Herda de: BusinessBase
* Tipo: OPERACIONAL (dialog modal - recebe ParentForm, devolve valores)
* Tabela relacionada: SigCdPro (lookup de descricao do servico)
*==============================================================================

DEFINE CLASS SigPrInsBO AS BusinessBase

    *-- Codigo do servico (SigCdPro.cPros)
    this_cCodServs  = ""

    *-- Descricao do servico (SigCdPro.dPros)
    this_cDescServs = ""

    *-- Valor do servico
    this_nVlServs   = 0

    *-- Mensagem de erro para o Form consultar apos Inserir/Atualizar
    this_cMensagemErro = ""

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "cPros"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodServs
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    * par_cAliasCursor: alias do cursor com campos cCodServs, nVlServs
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor AS String) AS Logical
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            TRY
                SELECT (par_cAliasCursor)

                THIS.this_cCodServs  = NVL(cCodServs, "")
                THIS.this_nVlServs   = NVL(nVlServs,  0)

                IF !EMPTY(THIS.this_cCodServs)
                    THIS.this_cDescServs = THIS.BuscarDescricaoServico(THIS.this_cCodServs)
                ELSE
                    THIS.this_cDescServs = ""
                ENDIF

                loc_lSucesso = .T.

            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Erro")
            ENDTRY
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarDescricaoServico - Busca descricao do servico em SigCdPro
    *--------------------------------------------------------------------------
    FUNCTION BuscarDescricaoServico(par_cCodServs AS String) AS String
        LOCAL loc_cDescricao, loc_cSQL, loc_oErro

        loc_cDescricao = ""

        TRY
            loc_cSQL = "SELECT dPros" + ;
                       " FROM SigCdPro" + ;
                       " WHERE cPros = " + EscaparSQL(ALLTRIM(par_cCodServs))

            IF USED("cursor_4c_ProServico")
                USE IN cursor_4c_ProServico
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProServico") > 0
                IF !EOF("cursor_4c_ProServico")
                    loc_cDescricao = NVL(cursor_4c_ProServico.dPros, "")
                ENDIF
                USE IN cursor_4c_ProServico
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_cDescricao
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarDados() AS Logical
        IF EMPTY(THIS.this_cCodServs)
            THIS.this_cMensagemErro = "O c" + CHR(243) + "digo do servi" + CHR(231) + "o deve ser informado!"
            MsgAviso(THIS.this_cMensagemErro, "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF THIS.this_nVlServs <= 0
            THIS.this_cMensagemErro = "O valor do servi" + CHR(231) + "o deve ser informado!"
            MsgAviso(THIS.this_cMensagemErro, "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        THIS.this_cMensagemErro = ""
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Confirmacao da entrada do servico (dialog OPERACIONAL modal)
    * Semantica: NAO ha tabela persistente para INSERT SQL. Esta dialog captura
    * cCodServ + nVlServ para devolver ao ParentForm que fara a persistencia
    * efetiva na tabela de itens (ex: linha de servico de um pedido/OT).
    * Aqui apenas: valida dados, resolve descricao do servico, registra
    * auditoria da operacao e retorna sucesso para o Form fechar o dialog.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir() AS Logical
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF !THIS.ValidarDados()
                loc_lSucesso = .F.
            ENDIF

            IF EMPTY(THIS.this_cDescServs)
                THIS.this_cDescServs = THIS.BuscarDescricaoServico(THIS.this_cCodServs)
            ENDIF

            IF EMPTY(THIS.this_cDescServs)
                THIS.this_cMensagemErro = "Servi" + CHR(231) + "o n" + CHR(227) + "o encontrado no cat" + CHR(225) + "logo!"
                MsgAviso(THIS.this_cMensagemErro, "Valida" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            THIS.RegistrarAuditoria("INSERIR")

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao confirmar servi" + CHR(231) + "o: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Re-confirmacao da entrada do servico (dialog OPERACIONAL modal)
    * Semantica: no fluxo do SIGPRINS original, o dialog eh usado tanto para
    * incluir uma nova linha de servico quanto para alterar uma linha existente
    * do ParentForm (que decide o modo via LocalSacOp). Nesta camada, Atualizar
    * reexecuta a mesma validacao e resolucao de descricao usadas em Inserir
    * e registra auditoria da operacao de alteracao.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar() AS Logical
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF !THIS.ValidarDados()
                loc_lSucesso = .F.
            ENDIF

            THIS.this_cDescServs = THIS.BuscarDescricaoServico(THIS.this_cCodServs)

            IF EMPTY(THIS.this_cDescServs)
                THIS.this_cMensagemErro = "Servi" + CHR(231) + "o n" + CHR(227) + "o encontrado no cat" + CHR(225) + "logo!"
                MsgAviso(THIS.this_cMensagemErro, "Valida" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            THIS.RegistrarAuditoria("ATUALIZAR")

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao atualizar servi" + CHR(231) + "o: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao no log de auditoria (LogAuditoria)
    * Sobrescreve o padrao de BusinessBase para gravar chave descritiva da
    * operacao (codigo do servico + valor) em vez de PK de tabela inexistente.
    * DataHora usa GETDATE() (SQL Server) - regra Erro35.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cQuery, loc_cUsuario, loc_cChave, loc_oErro

        TRY
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")

            loc_cChave = "Servico: " + ALLTRIM(THIS.this_cCodServs) + ;
                         " | Valor: " + TRANSFORM(THIS.this_nVlServs, "@$ 999,999,999.99")

            loc_cQuery = "INSERT INTO LogAuditoria (Tabela, ChaveRegistro, Operacao, Usuario, DataHora) " + ;
                         "VALUES (" + ;
                         EscaparSQL("SigPrIns") + ", " + ;
                         EscaparSQL(LEFT(loc_cChave, 100)) + ", " + ;
                         EscaparSQL(par_cOperacao) + ", " + ;
                         EscaparSQL(loc_cUsuario) + ", " + ;
                         "GETDATE())"

            SQLEXEC(gnConnHandle, loc_cQuery)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro Auditoria")
        ENDTRY
    ENDPROC

ENDDEFINE

