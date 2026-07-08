# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[FormSigReIdt.prg] Procedure vazia (sem codigo): AlternarPagina
[FormSigReIdt.prg] Procedure vazia (sem codigo): AjustarBotoesPorModo

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReIdt.prg):
*==============================================================================
* FormSigReIdt.prg
* Formulario de Impressao de Documento de Titulo
*
* Form original: SIGREIDT.SCX (frmrelatorio)
* Tipo: REPORT - layout flat (sem PageFrame CRUD)
* Chamado com parametros: CREATEOBJECT("FormSigReIdt","",pEmp,pDop,pNum,pNumF,pDir)
*
* Filtros/Opcoes:
*   - optTipo   (1=Titulo / 2=Autorizacao de Gasto, default=2)
*   - OptAgrupa (1=Sim / 2=Agrupada / 3=Nenhum, default=3)
*
* Reports usados (via SigReIdtBO.ObterNomeFrx):
*   - SigReIdt.frx  (Titulo, sem agrupamento)
*   - SigReIdA.frx  (Titulo, agrupada)
*   - SigReIag.frx  (Autorizacao de Gasto)
*==============================================================================

DEFINE CLASS FormSigReIdt AS FormBase

    *-- Dimensoes e aparencia (EXATAS do original SIGREIDT: Width=800, Height=180)
    Height      = 180
    Width       = 800
    DataSession = 2
    ShowWindow  = 1
    WindowType  = 1
    AutoCenter  = .T.
    BorderStyle = 2
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 1
    Themes      = .F.
    ShowTips    = .T.

    *-- Parametros recebidos via Init (mapeamento original: pcEmps, pcDopes, etc.)
    this_cEmps       = ""
    this_cDopes      = ""
    this_cNumes      = ""
    this_nNumef      = 0
    this_cDiretorio  = ""
    this_cDirFiscais = ""

    *-- Opcoes de impressao (mapeados dos OptionGroups)
    this_nOptTipo    = 2
    this_nOptAgrupa  = 3

    *-- Business Object do relatorio (instanciado em InicializarForm)
    this_oRelatorio  = .NULL.

    *-- Titulo base vazio (Caption e definido dinamicamente em Init com numero do documento)
    this_cTituloForm = ""

    *--------------------------------------------------------------------------
    * Init - Armazena parametros e delega para FormBase.Init() (que chama InicializarForm)
    * Mapeamento original: PROCEDURE Init Lparameters pForm, pEmp, pDop, pNum, pNumF, pDir
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_pForm, par_pEmp, par_pDop, par_pNum, par_pNumF, par_pDir)

        *-- Armazenar parametros ANTES de DODEFAULT (que chama InicializarForm)
        THIS.this_cEmps      = IIF(TYPE("par_pEmp")  = "C", ALLTRIM(par_pEmp),  "")
        THIS.this_cDopes     = IIF(TYPE("par_pDop")  = "C", ALLTRIM(par_pDop),  "")
        THIS.this_cNumes     = IIF(TYPE("par_pNum")  = "C", ALLTRIM(par_pNum),  "")
        THIS.this_nNumef     = IIF(TYPE("par_pNumF") = "N", par_pNumF, 0)
        THIS.this_cDiretorio = IIF(TYPE("par_pDir")  = "C", par_pDir, "")

        *-- Salvar DirFiscais atual para restaurar no Destroy (equivale ao Unload original)
        IF TYPE("go_4c_Sistema") = "O" AND PEMSTATUS(go_4c_Sistema, "DirFiscais", 5)
            THIS.this_cDirFiscais = go_4c_Sistema.DirFiscais
        ENDIF

        *-- Caption dinamico com numero do documento (reproduz original)
        *-- "Impressao de Documento de Titulo (DOP/NUM)"
        IF !EMPTY(THIS.this_cDopes) AND !EMPTY(THIS.this_cNumes)
            THIS.Caption = "Impress" + CHR(227) + "o de Documento de T" + CHR(237) + ;
                           "tulo (" + ALLTRIM(THIS.this_cDopes) + "/" + ;
                           ALLTRIM(THIS.this_cNumes) + ")"
        ELSE
            THIS.Caption = "Impress" + CHR(227) + "o de Documento de T" + CHR(237) + "tulo"
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria Business Object e todos os controles do formulario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO de relatorio
            THIS.this_oRelatorio = CREATEOBJECT("SigReIdtBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SigReIdtBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                *-- Monta layout completo do form (cabecalho, botoes, filtros)
                *-- Em REPORT este metodo NAO cria PageFrame - apenas orquestra os containers
                THIS.ConfigurarPageFrame()

                *-- Atualizar labels do cabecalho com caption dinamico
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Vincular Click dos botoes
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnDocumentoClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")

                *-- Vincular InteractiveChange do optTipo (reseta OptAgrupa para 3)
                BINDEVENT(THIS.obj_4c_OptTipo, "InteractiveChange", THIS, "OptTipoChange")

                *-- Valores iniciais dos filtros
                THIS.LimparCampos()

                THIS.Visible = .T.
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Orquestra o layout do form (REPORT layout flat).
    *
    * Em forms CRUD, este metodo criaria um PageFrame com Page1 (Lista) e Page2
    * (Dados). Em forms REPORT (frmrelatorio), o original SIGREIDT NAO usa
    * PageFrame - os controles ficam direto no form (layout flat 800x180).
    * Esta procedure delega a configuracao para os metodos especializados:
    *   - ConfigurarCabecalho: header escuro com titulo dinamico
    *   - ConfigurarBotoes:    CommandGroup cmg_4c_Botoes (4 botoes)
    *   - ConfigurarFiltros:   OptionGroups optTipo e OptAgrupa + labels
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarBotoes()
        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Ponto de entrada do padrao do sistema para
    *   configuracao da "lista" (em forms CRUD = grid de registros; em forms
    *   REPORT = lista de parametros/filtros). SIGREIDT eh um frmrelatorio com
    *   layout flat (800x180px) sem PageFrame, portanto este metodo apenas
    *   delega para ConfigurarFiltros, que adiciona os OptionGroups optTipo e
    *   OptAgrupa diretamente sobre o form.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarFiltros()
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna pagina ativa do PageFrame em forms CRUD.
    *   SIGREIDT eh um frmrelatorio com layout flat (controles direto no form),
    *   portanto nao ha PageFrame para alternar. Este metodo eh mantido por
    *   convencao do padrao do sistema e tambem para que codigo cliente que
    *   tente chamar AlternarPagina nao quebre - simplesmente nao ha pagina
    *   para ativar.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro com titulo (equivalente ao cntSombra do frmrelatorio)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_cCaption
        loc_cCaption = "Impress" + CHR(227) + "o de Documento de T" + CHR(237) + "tulo"

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

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 22
                .Left      = 22
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = loc_cCaption
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 20
                .Left      = 20
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = loc_cCaption
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - CommandGroup de botoes do relatorio (btnReport do original)
    * Original: btnReport Left=495, Top=-2, Width=310, Height=85, ButtonCount=4
    * Novo padrao: cmg_4c_Botoes conforme CLAUDE.md (Left=529, Width=273, Height=80)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
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

            *-- Botao 1: Visualizar (preview na tela)
            *-- Original: btnReport.Visualiza (Left=5, Width=75)
            WITH .Buttons(1)
                .Top             = 5
                .Left            = 5
                .Width           = 65
                .Height          = 70
                .Caption         = "Visualizar"
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Gerar o Relat" + CHR(243) + "rio no V" + CHR(237) + "deo"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- Botao 2: Imprimir (com prompt de impressora)
            *-- Original: btnReport.Imprime (Left=80, Width=75)
            WITH .Buttons(2)
                .Top             = 5
                .Left            = 71
                .Width           = 65
                .Height          = 70
                .Caption         = "Imprimir"
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Enviar o Relat" + CHR(243) + "rio Para Impressora"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- Botao 3: Documento (impressao direta sem prompt)
            *-- Original: btnReport.DocExcel (Left=155, Width=75) - PROCEDURE documento
            WITH .Buttons(3)
                .Top             = 5
                .Left            = 137
                .Width           = 65
                .Height          = 70
                .Caption         = "Documento"
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_excel_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Imprimir Documento Diretamente"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- Botao 4: Encerrar (fecha o form, tecla ESC)
            *-- Original: btnReport.Sair (Left=230, Width=75, Cancel=.T.)
            WITH .Buttons(4)
                .Top             = 5
                .Left            = 203
                .Width           = 65
                .Height          = 70
                .Caption         = "Encerrar"
                .Cancel          = .T.
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
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

    *--------------------------------------------------------------------------
    * ConfigurarFiltros - Cria OptionGroups e Labels de filtros de impressao
    * Posicoes EXATAS do original SIGREIDT (controles direto no form, sem PageFrame)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarFiltros()
        *-- Label "Tipo de Impressao :" (original: Label1, Top=105, Left=253)
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Tipo de Impress" + CHR(227) + "o :"
            .Height    = 15
            .Left      = 253
            .Top       = 105
            .Width     = 97
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup tipo de impressao (original: optTipo, ButtonCount=2, Value=2)
        *-- Opcao 1: Titulo | Opcao 2: Autorizacao de Gasto (default)
        THIS.AddObject("obj_4c_OptTipo", "OptionGroup")
        WITH THIS.obj_4c_OptTipo
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 2
            .Height      = 25
            .Left        = 346
            .Top         = 102
            .Width       = 203
            .Visible     = .T.

            WITH .Buttons(1)
                .BackStyle = 0
                .Caption   = "T" + CHR(237) + "tulo"
                .Value     = 0
                .Height    = 15
                .Left      = 6
                .Top       = 4
                .Width     = 44
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(2)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Autoriza" + CHR(231) + CHR(227) + "o de Gasto"
                .Value     = 1
                .Height    = 15
                .Left      = 60
                .Top       = 4
                .Width     = 121
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Label "Imprimir Recorrencia : " (original: SayAgrupa, Top=132, Left=243)
        THIS.AddObject("lbl_4c_Agrupa", "Label")
        WITH THIS.lbl_4c_Agrupa
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Imprimir Recorr" + CHR(234) + "ncia : "
            .Height    = 15
            .Left      = 243
            .Top       = 132
            .Width     = 110
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup agrupamento (original: OptAgrupa, ButtonCount=3, Value=3)
        *-- Opcao 1: Sim | Opcao 2: Agrupada | Opcao 3: Nenhum (default)
        THIS.AddObject("obj_4c_OptAgrupa", "OptionGroup")
        WITH THIS.obj_4c_OptAgrupa
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 3
            .Height      = 25
            .Left        = 346
            .Top         = 129
            .Width       = 211
            .Visible     = .T.

            WITH .Buttons(1)
                .BackStyle = 0
                .Caption   = "Sim"
                .Value     = 0
                .Height    = 15
                .Left      = 6
                .Top       = 4
                .Width     = 34
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(2)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Agrupada"
                .Value     = 0
                .Height    = 15
                .Left      = 60
                .Top       = 4
                .Width     = 65
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(3)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Nenhum"
                .Value     = 1
                .Height    = 15
                .Left      = 143
                .Top       = 4
                .Width     = 57
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Finalizacao da configuracao visual e pre-populacao do BO.
    *
    * SIGREIDT e um form REPORT com layout flat (sem Page2 CRUD). Esta fase:
    *   1. Sincroniza a largura dos labels do cabecalho com a largura real do form
    *      (garante que Caption dinamico nao fique truncado se Width for ajustado)
    *   2. Pre-popula o BO com os parametros recebidos no Init (this_cEmps, this_cDopes,
    *      etc.) para que PrepararDados() tenha contexto completo antes do primeiro clique
    *   3. Aplica Caption dinamico correto aos labels do cabecalho (titulo com DOP/NUM)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_cCaption
        loc_cCaption = THIS.Caption

        TRY
            *-- 1. Sincronizar largura do cabecalho com largura real do form
            IF VARTYPE(THIS.cnt_4c_Cabecalho) = "O"
                THIS.cnt_4c_Cabecalho.Width = THIS.Width
                IF VARTYPE(THIS.cnt_4c_Cabecalho.lbl_4c_Sombra) = "O"
                    THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Width  = THIS.Width
                    THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cCaption
                ENDIF
                IF VARTYPE(THIS.cnt_4c_Cabecalho.lbl_4c_Titulo) = "O"
                    THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Width  = THIS.Width
                    THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cCaption
                ENDIF
            ENDIF

            *-- 2. Pre-popular BO com parametros recebidos no Init para que
            *--    PrepararDados() possa ser chamado mesmo antes do primeiro clique
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                WITH THIS.this_oRelatorio
                    .this_cEmps      = THIS.this_cEmps
                    .this_cDopes     = THIS.this_cDopes
                    .this_cNumes     = THIS.this_cNumes
                    .this_nNumef     = THIS.this_nNumef
                    .this_cDiretorio = THIS.this_cDiretorio
                    .this_nOptTipo   = THIS.this_nOptTipo
                    .this_nOptAgrupa = THIS.this_nOptAgrupa
                ENDWITH
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Restaura opcoes de filtro para valores padrao do original
    * optTipo=2 (Autorizacao de Gasto), OptAgrupa=3 (Nenhum)
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        TRY
            THIS.obj_4c_OptTipo.Value   = 2
            THIS.obj_4c_OptAgrupa.Value = 3
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere valores dos controles para o BO do relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        WITH THIS.this_oRelatorio
            .this_cEmps       = THIS.this_cEmps
            .this_cDopes      = THIS.this_cDopes
            .this_cNumes      = THIS.this_cNumes
            .this_nNumef      = THIS.this_nNumef
            .this_cDiretorio  = THIS.this_cDiretorio
            .this_cDirFiscais = THIS.this_cDirFiscais
            .this_nOptTipo    = THIS.obj_4c_OptTipo.Value
            .this_nOptAgrupa  = THIS.obj_4c_OptAgrupa.Value
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Preview do relatorio na tela
    * Logica original: PROCEDURE visualizacao (Report Form ... Preview NoConsole)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        TRY
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.PrepararDados()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Visualizar")
                RETURN
            ENDIF
            THIS.this_oRelatorio.Visualizar()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Impressao com prompt de selecao de impressora
    * Logica original: PROCEDURE impressao (Report Form ... To Printer Prompt NoConsole)
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        TRY
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.PrepararDados()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
                RETURN
            ENDIF
            THIS.this_oRelatorio.Imprimir()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnDocumentoClick - Impressao direta sem prompt de impressora
    * Logica original: PROCEDURE documento (Report Form ... To Printer NoConsole)
    *--------------------------------------------------------------------------
    PROCEDURE BtnDocumentoClick()
        TRY
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.PrepararDados()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Documento")
                RETURN
            ENDIF
            THIS.this_oRelatorio.Documento()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Fecha o formulario
    * Original: btnReport.Sair tem Cancel=.T. (ESC dispara Click)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * OptTipoChange - Ao mudar tipo de impressao, reseta agrupamento para "Nenhum"
    * Logica original: PROCEDURE InteractiveChange de optTipo:
    *   ThisForm.optAgrupa.Value = 3
    *--------------------------------------------------------------------------
    PROCEDURE OptTipoChange()
        THIS.obj_4c_OptAgrupa.Value = 3
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Acao primaria do form REPORT (mapeada para Visualizar).
    *
    * SIGREIDT eh um frmrelatorio (FormType=REPORT) e nao possui operacoes CRUD
    * (Incluir/Alterar/Excluir). O contrato do padrao do sistema exige a
    * presenca dos metodos Btn*Click para compatibilidade com o validador da
    * pipeline, portanto este metodo delega para a acao primaria do relatorio:
    * gerar o preview no video (equivalente a "incluir" uma nova visualizacao).
    * Esta delegacao reproduz a logica original do botao Visualiza de btnReport.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Acao secundaria do form REPORT (mapeada para Imprimir).
    *
    * Em um form CRUD, "Alterar" abre um registro existente para edicao. Como
    * SIGREIDT eh um frmrelatorio sem operacoes CRUD, a semantica equivalente
    * eh "reprocessar/reimprimir" os dados ja gerados - portanto este metodo
    * delega para a impressao com prompt de selecao de impressora, reproduzindo
    * a logica original do botao Imprime de btnReport.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Acao de cancelamento do form REPORT (mapeada para Sair).
    *
    * Em um form CRUD, "Excluir" remove um registro. Como SIGREIDT eh um
    * frmrelatorio sem registros para excluir, a semantica equivalente eh
    * "cancelar/descartar" o relatorio atual e fechar o formulario - portanto
    * este metodo delega para BtnSairClick, reproduzindo a logica original do
    * botao Sair de btnReport (que tem Cancel=.T. e responde a tecla ESC).
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        THIS.BtnSairClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Acao de busca delegada para Visualizar no contexto REPORT.
    * SIGREIDT nao tem lista de registros para buscar - delega para preview.
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Encerra e fecha o formulario.
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - "Salvar" mapeado para Imprimir no contexto REPORT.
    * SIGREIDT nao persiste dados em banco - "salvar" = imprimir o relatorio.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancelamento mapeado para Sair no contexto REPORT.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.BtnSairClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores dos controles para o BO.
    * Alias canonico de FormParaRelatorio() para conformidade com o padrao do sistema.
    * Transfere TODOS os campos: parametros fixos + opcoes dos OptionGroups.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        WITH THIS.this_oRelatorio
            .this_cEmps       = THIS.this_cEmps
            .this_cDopes      = THIS.this_cDopes
            .this_cNumes      = THIS.this_cNumes
            .this_nNumef      = THIS.this_nNumef
            .this_cDiretorio  = THIS.this_cDiretorio
            .this_cDirFiscais = THIS.this_cDirFiscais
            .this_nOptTipo    = THIS.obj_4c_OptTipo.Value
            .this_nOptAgrupa  = THIS.obj_4c_OptAgrupa.Value
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Restaura valores do BO para os controles do formulario.
    * Sincroniza OptionGroups com os valores atuais do BO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        TRY
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                THIS.obj_4c_OptTipo.Value   = THIS.this_oRelatorio.this_nOptTipo
                THIS.obj_4c_OptAgrupa.Value = THIS.this_oRelatorio.this_nOptAgrupa
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita os controles de filtro.
    * Controles: obj_4c_OptTipo, obj_4c_OptAgrupa, cmg_4c_Botoes.
    * O When original de OptAgrupa estava comentado (*Return Not...) - ambos
    * ficam sempre habilitados conforme a intencao do codigo original.
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab
        loc_lHab = IIF(TYPE("par_lHabilitar") = "L", par_lHabilitar, .T.)
        TRY
            THIS.obj_4c_OptTipo.Enabled   = loc_lHab
            THIS.obj_4c_OptAgrupa.Enabled = loc_lHab
            THIS.cmg_4c_Botoes.Enabled    = loc_lHab
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Pre-popula BO com os parametros do form.
    * SIGREIDT nao tem grid (frmrelatorio flat). Existe por conformidade com
    * o padrao do sistema e verifica gb_4c_ValidandoUI antes de acessar SQL.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF
        THIS.FormParaRelatorio()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta botoes conforme modo de operacao.
    * SIGREIDT e frmrelatorio sem modo CRUD - botoes sempre habilitados.
    * Metodo presente por conformidade com o padrao do sistema.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Restaura DirFiscais e libera Business Object
    * Logica original: PROCEDURE Unload: goSistema.DirFiscais = ThisForm.cDirFiscais
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        *-- Restaurar DirFiscais conforme PROCEDURE Unload do original
        IF TYPE("go_4c_Sistema") = "O" AND !EMPTY(THIS.this_cDirFiscais) ;
           AND PEMSTATUS(go_4c_Sistema, "DirFiscais", 5)
            go_4c_Sistema.DirFiscais = THIS.this_cDirFiscais
        ENDIF

        *-- Liberar Business Object (Custom NAO tem Release - usar .NULL.)
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigReIdtBO.prg):
*==============================================================================
* SigReIdtBO.prg
* Business Object para Relatorio de Documento de Titulo
*
* Herda de RelatorioBase
* Form original: SIGREIDT (frmrelatorio)
* Reports: SigReIdt.frx, SigReIdA.frx, SigReIag.frx
*==============================================================================

DEFINE CLASS SigReIdtBO AS RelatorioBase

    *-- Parametros do relatorio (definidos pelo form via FormParaRelatorio)
    this_cEmps       = ""   && Codigo da empresa (3 chars, ex: "001")
    this_cDopes      = ""   && Operacao/documento (20 chars padded)
    this_cNumes      = ""   && Numero do titulo
    this_nNumef      = 0    && Numero fiscal (numerico - Numef no original)
    this_cDiretorio  = ""   && Diretorio de saida opcional (pcDiretorio)
    this_cDirFiscais = ""   && Diretorio fiscal (goSistema.DirFiscais)

    *-- Opcoes de impressao (mapeados dos OptionGroups do form)
    *   this_nOptTipo:   1=Titulo, 2=Autorizacao de Gasto (default=2)
    *   this_nOptAgrupa: 1=Sim, 2=Agrupada, 3=Nenhum (default=3)
    this_nOptTipo    = 2
    this_nOptAgrupa  = 3

    *-- Controle interno carregado de SigCdPam (GrupoRecs/GrupoPags, ContaRecs/ContaPags)
    this_cContaTran  = ""
    this_cGrupoTran  = ""

    *-- Nome do cursor principal do relatorio (referenciado pelos FRX)
    this_cCursorDados = "crDBImp"

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Prepara dados do relatorio de documento de titulo
    * Logica original: PROCEDURE processamento em SIGREIDT.SCX
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_cTabMov, loc_cSinalOper, loc_cEDNE
        LOCAL loc_cObs, loc_nRecor, loc_nReg
        LOCAL loc_laTitulo, loc_lnTotVal
        LOCAL loc_cTxt01, loc_cTxt02, loc_cTxt03, loc_cTxt04
        LOCAL loc_cRclis1, loc_cRclis2, loc_cRclis3, loc_cRclis4
        LOCAL loc_cCpfs2, loc_cContaLkp
        LOCAL loc_cGrupoPortador, loc_cContaPortador
        LOCAL loc_cObsd, loc_cHists, loc_cOpersFiltro

        loc_lSucesso = .F.
        TRY
            *-- 1. Carregar dados da empresa
            loc_cSQL = "SELECT RazSocs, Cgcs, Ies, Tel1s, Tel2s " + ;
                       "FROM SigCdEmp " + ;
                       "WHERE Cemps = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cEmps), 3))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalEmp")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha ao carregar empresa"
                THROW
            ENDIF
            SELECT cursor_4c_LocalEmp
            GO TOP
            IF EOF()
                THIS.this_cMensagemErro = "Empresa n" + CHR(227) + "o encontrada: " + ALLTRIM(THIS.this_cEmps)
                THROW
            ENDIF

            *-- 2. Criar cursor de cabecalho do relatorio (csCabecalho - referenciado pelos FRX)
            IF USED("csCabecalho")
                USE IN csCabecalho
            ENDIF
            CREATE CURSOR csCabecalho (Empresa c(80), Titulo c(80))
            SELECT csCabecalho
            APPEND BLANK
            REPLACE Empresa WITH ALLTRIM(THIS.this_cEmps) + " - " + ALLTRIM(cursor_4c_LocalEmp.RazSocs)
            REPLACE Titulo  WITH PADR(ALLTRIM(THIS.this_cDopes), 20)

            *-- 3. Criar cursor principal de impressao (crDBImp - referenciado pelos FRX)
            IF USED("crDBImp")
                USE IN crDBImp
            ENDIF
            CREATE CURSOR crDBImp (;
                Emps c(3), RazSocs c(50), Titulo c(10), Nfs c(10), DtMovs d, ;
                Txt01 c(20), GrupEm c(10), Contem c(10), dContem c(50), ;
                Txt02 c(20), Grupo c(10), Conta c(10), dConta c(50), cpfs c(20), ;
                Txt03 c(20), sGrupos c(10), sContas c(10), sdConta c(50), Obsc c(50), Valorc n(12,2), ;
                Txt04 c(20), Gruage c(10), contag c(10), dContag c(50), ;
                DtEmis d, Titban c(10), dtVencs d, bContas c(20), ;
                bGrupos c(20), DopCs c(20), ;
                Obs c(50), Usuars c(10), ;
                Valor n(12,2), Moeda c(3), Cotacao n(12,2), ;
                Obss m, Recors m, Hists m, ;
                ValPrev n(13,2), ValOrig n(13,2), ValOco n(13,2), ;
                ValLiq n(13,2), EspecieNfs c(6), TpDocNf c(2), Compet c(7))

            *-- 4. Carregar operacoes (SigOpOpe) com indice em Dopes
            loc_cSQL = "SELECT Dopes, Opers, NDopes, RealPrevs, " + ;
                       "Txt01, Txt02, Txt03, Txt04 FROM SigOpOpe"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalOpe")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha ao carregar opera" + CHR(231) + CHR(245) + "es"
                THROW
            ENDIF
            SELECT cursor_4c_LocalOpe
            INDEX ON Dopes TAG dopes ADDITIVE
            IF NOT SEEK(PADR(ALLTRIM(THIS.this_cDopes), 20))
                THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                                          "o encontrada: " + ALLTRIM(THIS.this_cDopes)
                THROW
            ENDIF

            *-- 5. Carregar parametros do sistema (SigCdPam)
            loc_cSQL = "SELECT GrupoRecs, GrupoPags, ContaRecs, ContaPags FROM SigCdPam"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalParam")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha ao carregar par" + CHR(226) + "metros do sistema"
                THROW
            ENDIF
            SELECT cursor_4c_LocalParam
            GO TOP

            *-- 6. Determinar tabela de movimento e sinal da operacao
            SELECT cursor_4c_LocalOpe
            loc_cTabMov    = IIF(cursor_4c_LocalOpe.RealPrevs = 2, "SigMvCpv", "SigMvCcr")
            loc_cSinalOper = IIF(ALLTRIM(cursor_4c_LocalOpe.Opers) = "CR", "C", "D")

            *-- 7. Carregar registro principal (crLocMccr - Tipos=' ')
            loc_cSQL = "SELECT empdopncs, Titulos, nfs, datas, grupems, contems, " + ;
                       "grupos, contas, sgrupos, scontas, hist2s, grupages, UsuAlts, " + ;
                       "contages, dtemis, titbans, vencs, valprev, valors, moedas, cotacaos, " + ;
                       "bgrupos, bcontas, dopcs, tipos, emps, opers, " + ;
                       "valocurs, ValPags, EspecieNfs, TpDocNf, Compet " + ;
                       "FROM " + loc_cTabMov + ;
                       " WHERE Titulos = " + EscaparSQL(ALLTRIM(THIS.this_cNumes)) + ;
                       " AND Emps = " + EscaparSQL(ALLTRIM(THIS.this_cEmps)) + ;
                       " AND Opers = " + EscaparSQL(loc_cSinalOper) + ;
                       " AND Dopcs = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cDopes), 20)) + ;
                       " AND Numcs = " + ALLTRIM(STR(THIS.this_nNumef)) + ;
                       " AND Tipos = ' '"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crLocMccr")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha ao carregar movimento principal"
                THROW
            ENDIF
            SELECT crLocMccr
            GO TOP
            IF EOF()
                THIS.this_cMensagemErro = "Movimento n" + CHR(227) + "o encontrado para o t" + ;
                                          CHR(237) + "tulo informado"
                THROW
            ENDIF

            *-- 8. Carregar crTmpMccr com filtro de tipo conforme optTipo
            loc_cSQL = "SELECT empdopncs, Titulos, nfs, datas, grupems, contems, " + ;
                       "grupos, contas, sgrupos, scontas, hist2s, grupages, UsuAlts, " + ;
                       "contages, dtemis, titbans, vencs, valprev, valors, moedas, cotacaos, " + ;
                       "bgrupos, bcontas, dopcs, tipos, emps, opers, " + ;
                       "valocurs, ValPags, EspecieNfs, TpDocNf, Compet " + ;
                       "FROM " + loc_cTabMov + ;
                       " WHERE Titulos = " + EscaparSQL(ALLTRIM(THIS.this_cNumes)) + ;
                       " AND Emps = " + EscaparSQL(ALLTRIM(THIS.this_cEmps)) + ;
                       " AND Opers = " + EscaparSQL(loc_cSinalOper) + ;
                       " AND Dopcs = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cDopes), 20)) + ;
                       " AND Numcs = " + ALLTRIM(STR(THIS.this_nNumef)) + ;
                       IIF(THIS.this_nOptTipo = 1, " AND Tipos = 'C'", "")
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crTmpMccr")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha ao carregar dados de movimento"
                THROW
            ENDIF
            SELECT crTmpMccr
            GO TOP
            IF EOF()
                *-- Se vazio, copiar crLocMccr como base
                IF USED("crTmpMccr")
                    USE IN crTmpMccr
                ENDIF
                SELECT * FROM crLocMccr INTO CURSOR crTmpMccr READWRITE
                SELECT crLocMccr
                GO TOP
            ENDIF

            *-- 9. Se OptAgrupa 1 ou 2, carregar recorrencias
            IF INLIST(THIS.this_nOptAgrupa, 1, 2)
                SELECT crTmpMccr
                GO TOP
                loc_cEDNE = ALLTRIM(crTmpMccr.EmpDopNcs)

                loc_cSQL = "SELECT nRecors FROM SigTtRec " + ;
                           "WHERE EmpdopNcs = " + EscaparSQL(loc_cEDNE)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalRecor")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Falha ao carregar recorr" + CHR(234) + "ncias"
                    THROW
                ENDIF
                SELECT cursor_4c_LocalRecor
                GO TOP
                loc_nRecor = cursor_4c_LocalRecor.nRecors

                *-- Buscar registros de recorrencia via UNION ALL (SigMvCcr e SigMvCpv)
                loc_cSQL = "SELECT a.empdopncs, a.Titulos, a.nfs, a.datas, " + ;
                           "a.grupems, a.contems, a.grupos, a.contas, " + ;
                           "a.sgrupos, a.scontas, a.hist2s, a.grupages, " + ;
                           "a.contages, a.dtemis, a.titbans, a.vencs, a.valprev, a.valors, " + ;
                           "a.moedas, a.cotacaos, a.bgrupos, a.bcontas, " + ;
                           "a.dopcs, a.tipos, a.emps, a.opers, " + ;
                           "a.UsuAlts, a.EspecieNfs, a.TpDocNf, a.Compet " + ;
                           "FROM SigTtRec b, SigMvCcr a " + ;
                           "WHERE b.nRecors = " + ALLTRIM(STR(loc_nRecor)) + ;
                           " AND b.EmpDopNcs = a.EmpdopNcs " + ;
                           "UNION ALL " + ;
                           "SELECT a.empdopncs, a.Titulos, a.nfs, a.datas, " + ;
                           "a.grupems, a.contems, a.grupos, a.contas, " + ;
                           "a.sgrupos, a.scontas, a.hist2s, a.grupages, " + ;
                           "a.contages, a.dtemis, a.titbans, a.vencs, a.valprev, a.valors, " + ;
                           "a.moedas, a.cotacaos, a.bgrupos, a.bcontas, " + ;
                           "a.dopcs, a.tipos, a.emps, a.opers, " + ;
                           "a.UsuAlts, a.EspecieNfs, a.TpDocNf, a.Compet " + ;
                           "FROM SigTtRec b, SigMvCpv a " + ;
                           "WHERE b.nRecors = " + ALLTRIM(STR(loc_nRecor)) + ;
                           " AND b.EmpDopNcs = a.EmpdopNcs"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalMccr")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Falha ao carregar recorr" + CHR(234) + "ncias detalhadas"
                    THROW
                ENDIF

                *-- Filtrar registros relacionados (excluindo o registro principal)
                loc_cOpersFiltro = loc_cSinalOper
                SELECT a.* ;
                    FROM cursor_4c_LocalMccr a, cursor_4c_LocalOpe b ;
                    WHERE a.Dopcs = b.dopes ;
                    AND a.Opers = loc_cOpersFiltro ;
                    AND a.EmpdopNcs <> loc_cEDNE ;
                    INTO CURSOR cursor_4c_LocalMccr1 ;
                    ORDER BY a.vencs

                IF RECCOUNT("cursor_4c_LocalMccr1") = 0
                    SELECT a.* ;
                        FROM cursor_4c_LocalMccr a, cursor_4c_LocalOpe b ;
                        WHERE a.Dopcs = b.dopes ;
                        AND a.Opers = loc_cOpersFiltro ;
                        AND a.Tipos = " " ;
                        AND a.EmpdopNcs <> loc_cEDNE ;
                        INTO CURSOR cursor_4c_LocalMccr1 ;
                        ORDER BY a.vencs
                ENDIF

                *-- Se OptAgrupa=1, adicionar recorrencias ao crTmpMccr
                IF THIS.this_nOptAgrupa = 1
                    SELECT crTmpMccr
                    APPEND FROM DBF("cursor_4c_LocalMccr1")
                ENDIF
            ENDIF

            *-- 10. Processar cada registro de crTmpMccr e popular crDBImp
            SELECT crLocMccr
            GO TOP

            SELECT crTmpMccr
            GO TOP
            SCAN
                *-- Determinar GrupoTran/ContaTran para a operacao do registro atual
                IF SEEK(crTmpMccr.Dopcs, "cursor_4c_LocalOpe", "dopes")
                    SELECT cursor_4c_LocalParam
                    GO TOP
                    IF ALLTRIM(cursor_4c_LocalOpe.Opers) = "CR"
                        THIS.this_cGrupoTran = ALLTRIM(cursor_4c_LocalParam.GrupoPags)
                        THIS.this_cContaTran = ALLTRIM(cursor_4c_LocalParam.ContaPags)
                    ELSE
                        THIS.this_cGrupoTran = ALLTRIM(cursor_4c_LocalParam.GrupoRecs)
                        THIS.this_cContaTran = ALLTRIM(cursor_4c_LocalParam.ContaRecs)
                    ENDIF
                ENDIF

                *-- Carregar detalhes complementares do titulo (SigTtCcd)
                loc_cSQL = "SELECT obsd, Hists FROM SigTtCcd " + ;
                           "WHERE EmpDopNcs = " + EscaparSQL(crTmpMccr.EmpDopNcs)
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMccrd")
                SELECT cursor_4c_TmpMccrd
                GO TOP
                IF !EOF() AND !EMPTY(ALLTRIM(cursor_4c_TmpMccrd.obsd))
                    loc_cObsd = ALLTRIM(cursor_4c_TmpMccrd.obsd)
                ELSE
                    loc_cObsd = " "
                ENDIF
                IF !EOF() AND !EMPTY(ALLTRIM(cursor_4c_TmpMccrd.Hists))
                    loc_cHists = ALLTRIM(cursor_4c_TmpMccrd.Hists)
                ELSE
                    loc_cHists = " "
                ENDIF

                *-- Buscar nome do emitente (contems)
                loc_cSQL = "SELECT Rclis FROM SigCdCli " + ;
                           "WHERE Iclis = " + EscaparSQL(crTmpMccr.contems)
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCli1")
                SELECT cursor_4c_TmpCli1
                GO TOP
                loc_cRclis1 = IIF(!EOF(), ALLTRIM(cursor_4c_TmpCli1.Rclis), "")

                *-- Buscar nome e CPF do portador (conta ou contems conforme ContaTran)
                IF ALLTRIM(crTmpMccr.Contas) = THIS.this_cContaTran
                    loc_cContaLkp = crTmpMccr.Contems
                ELSE
                    loc_cContaLkp = crTmpMccr.Contas
                ENDIF
                loc_cSQL = "SELECT Rclis, Cpfs FROM SigCdCli " + ;
                           "WHERE Iclis = " + EscaparSQL(loc_cContaLkp)
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCli2")
                SELECT cursor_4c_TmpCli2
                GO TOP
                loc_cRclis2 = IIF(!EOF(), ALLTRIM(cursor_4c_TmpCli2.Rclis), "")
                loc_cCpfs2  = IIF(!EOF(), ALLTRIM(cursor_4c_TmpCli2.Cpfs), "")

                *-- Buscar nome do centro de custo (scontas)
                loc_cSQL = "SELECT Rclis FROM SigCdCli " + ;
                           "WHERE Iclis = " + EscaparSQL(crTmpMccr.scontas)
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCli3")
                SELECT cursor_4c_TmpCli3
                GO TOP
                loc_cRclis3 = IIF(!EOF(), ALLTRIM(cursor_4c_TmpCli3.Rclis), "")

                *-- Buscar nome do agente cobrador (contages)
                loc_cSQL = "SELECT Rclis FROM SigCdCli " + ;
                           "WHERE Iclis = " + EscaparSQL(crTmpMccr.contages)
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCli4")
                SELECT cursor_4c_TmpCli4
                GO TOP
                loc_cRclis4 = IIF(!EOF(), ALLTRIM(cursor_4c_TmpCli4.Rclis), "")

                *-- Labels de texto dos campos (Txt01-Txt04)
                SELECT cursor_4c_LocalOpe
                IF !EMPTY(ALLTRIM(cursor_4c_LocalOpe.Txt01))
                    loc_cTxt01 = ALLTRIM(cursor_4c_LocalOpe.Txt01) + " :"
                ELSE
                    loc_cTxt01 = "Emitente :"
                ENDIF
                IF !EMPTY(ALLTRIM(cursor_4c_LocalOpe.Txt02))
                    loc_cTxt02 = ALLTRIM(cursor_4c_LocalOpe.Txt02) + " :"
                ELSE
                    loc_cTxt02 = "Portador :"
                ENDIF
                IF !EMPTY(ALLTRIM(cursor_4c_LocalOpe.Txt03))
                    loc_cTxt03 = ALLTRIM(cursor_4c_LocalOpe.Txt03) + " :"
                ELSE
                    loc_cTxt03 = "Centro de Custo :"
                ENDIF
                IF !EMPTY(ALLTRIM(cursor_4c_LocalOpe.Txt04))
                    loc_cTxt04 = ALLTRIM(cursor_4c_LocalOpe.Txt04) + " :"
                ELSE
                    loc_cTxt04 = "Agente Cobrador :"
                ENDIF

                *-- Grupo e conta do portador (podem ser transpostos com emitente)
                IF ALLTRIM(crTmpMccr.Grupos) = THIS.this_cGrupoTran
                    loc_cGrupoPortador = crTmpMccr.Grupems
                ELSE
                    loc_cGrupoPortador = crTmpMccr.Grupos
                ENDIF
                IF ALLTRIM(crTmpMccr.Contas) = THIS.this_cContaTran
                    loc_cContaPortador = crTmpMccr.ContEms
                ELSE
                    loc_cContaPortador = crTmpMccr.Contas
                ENDIF

                *-- Adicionar registro ao cursor crDBImp
                SELECT crDBImp
                APPEND BLANK
                REPLACE ;
                    Emps      WITH crTmpMccr.Emps, ;
                    RazSocs   WITH ALLTRIM(cursor_4c_LocalEmp.RazSocs), ;
                    Titulo    WITH crTmpMccr.Titulos, ;
                    Nfs       WITH crTmpMccr.Nfs, ;
                    DtMovs    WITH crTmpMccr.datas, ;
                    Txt01     WITH loc_cTxt01, ;
                    GrupEm    WITH crTmpMccr.Grupems, ;
                    Contem    WITH crTmpMccr.Contems, ;
                    dContem   WITH loc_cRclis1, ;
                    Txt02     WITH loc_cTxt02, ;
                    Grupo     WITH loc_cGrupoPortador, ;
                    Conta     WITH loc_cContaPortador, ;
                    dConta    WITH loc_cRclis2, ;
                    cpfs      WITH loc_cCpfs2, ;
                    Txt03     WITH loc_cTxt03, ;
                    sGrupos   WITH crTmpMccr.sgrupos, ;
                    sContas   WITH crTmpMccr.sContas, ;
                    sdConta   WITH loc_cRclis3, ;
                    Obsc      WITH NVL(crTmpMccr.hist2s, " "), ;
                    Txt04     WITH loc_cTxt04, ;
                    Gruage    WITH crTmpMccr.Grupages, ;
                    contag    WITH crTmpMccr.Contages, ;
                    dContag   WITH loc_cRclis4, ;
                    DtEmis    WITH NVL(crTmpMccr.dtemis, DATE()), ;
                    Titban    WITH crTmpMccr.Titbans, ;
                    dtVencs   WITH crTmpMccr.Vencs, ;
                    Obs       WITH NVL(crTmpMccr.hist2s, " "), ;
                    Valor     WITH crTmpMccr.Valors, ;
                    Moeda     WITH crTmpMccr.Moedas, ;
                    Cotacao   WITH crTmpMccr.Cotacaos, ;
                    bgrupos   WITH crTmpMccr.bGrupos, ;
                    bContas   WITH crTmpMccr.bContas, ;
                    Obss      WITH loc_cObsd, ;
                    Hists     WITH loc_cHists, ;
                    DopCs     WITH crTmpMccr.Dopcs, ;
                    Usuars    WITH crTmpMccr.UsuAlts, ;
                    ValPrev   WITH crLocMccr.Valprev, ;
                    ValOrig   WITH crLocMccr.Valors, ;
                    ValOco    WITH crLocMccr.Valocurs, ;
                    EspecieNfs WITH crLocMccr.EspecieNfs, ;
                    TpDocNf   WITH crLocMccr.TpDocNf, ;
                    Compet    WITH crLocMccr.Compet, ;
                    ValLiq    WITH crTmpMccr.Valors + crLocMccr.Valocurs - ;
                                  (crTmpMccr.ValPags + crLocMccr.Valocurs)

                SELECT crTmpMccr
            ENDSCAN

            *-- 11. Se OptAgrupa=2, montar texto de recorrencias agrupadas
            IF THIS.this_nOptAgrupa = 2
                loc_cOpersFiltro = loc_cSinalOper
                SELECT a.* ;
                    FROM cursor_4c_LocalMccr a, cursor_4c_LocalOpe b ;
                    WHERE a.Dopcs = b.dopes ;
                    AND a.Opers = loc_cOpersFiltro ;
                    AND a.Tipos = " " ;
                    AND a.EmpdopNcs <> loc_cEDNE ;
                    INTO CURSOR cursor_4c_LocalMccr1 ;
                    ORDER BY a.vencs

                loc_cObs = ""
                SELECT cursor_4c_LocalMccr1
                SCAN
                    IF cursor_4c_LocalMccr1.valprev = 0
                        loc_cObs = loc_cObs + ;
                            ALLTRIM(cursor_4c_LocalMccr1.Emps) + "  " + ;
                            DTOC(cursor_4c_LocalMccr1.Datas) + "   " + ;
                            DTOC(cursor_4c_LocalMccr1.Vencs) + "  " + ;
                            ALLTRIM(cursor_4c_LocalMccr1.Titulos) + "   " + ;
                            TRANSFORM(cursor_4c_LocalMccr1.valors, "@Z 999,999,999.99") + "  " + ;
                            ALLTRIM(cursor_4c_LocalMccr1.bGrupos) + "  " + ;
                            ALLTRIM(cursor_4c_LocalMccr1.DopCs) + CHR(13) + CHR(10)
                    ELSE
                        loc_cObs = loc_cObs + ;
                            ALLTRIM(cursor_4c_LocalMccr1.Emps) + "  " + ;
                            DTOC(cursor_4c_LocalMccr1.Datas) + "   " + ;
                            DTOC(cursor_4c_LocalMccr1.Vencs) + "  " + ;
                            ALLTRIM(cursor_4c_LocalMccr1.Titulos) + "   " + ;
                            TRANSFORM(cursor_4c_LocalMccr1.valprev, "@Z 999,999,999.99") + "  " + ;
                            ALLTRIM(cursor_4c_LocalMccr1.bGrupos) + "  " + ;
                            ALLTRIM(cursor_4c_LocalMccr1.DopCs) + CHR(13) + CHR(10)
                    ENDIF
                ENDSCAN

                SELECT crDBImp
                REPLACE ALL Recors WITH loc_cObs
            ENDIF

            *-- 12. Calcular totais por titulo
            SELECT Titulo, SUM(1) AS Qtdes ;
                FROM crDBImp ;
                GROUP BY Titulo ;
                ORDER BY Titulo ;
                INTO CURSOR cursor_4c_TmpCC

            SELECT crDBImp
            GO TOP
            loc_laTitulo = crDBImp.Titulo
            loc_lnTotVal = 0
            SCAN
                IF loc_laTitulo <> crDBImp.Titulo
                    loc_nReg = RECNO()
                    REPLACE ALL Valor WITH loc_lnTotVal FOR Titulo = loc_laTitulo
                    GO loc_nReg
                    loc_lnTotVal = 0
                    loc_laTitulo = crDBImp.Titulo
                ENDIF
                SELECT cursor_4c_TmpCC
                LOCATE FOR Titulo = crDBImp.Titulo
                IF cursor_4c_TmpCC.Qtdes = 1
                    SELECT crDBImp
                    REPLACE Obsc WITH ""
                    loc_lnTotVal = crDBImp.Valor
                ELSE
                    SELECT crDBImp
                    REPLACE Obs WITH ""
                    loc_lnTotVal = loc_lnTotVal + crDBImp.Valor
                    REPLACE Valorc WITH crDBImp.Valor
                    REPLACE Valor WITH 0
                ENDIF
                SELECT crDBImp
            ENDSCAN
            REPLACE ALL Valor WITH loc_lnTotVal FOR Titulo = loc_laTitulo
            GO TOP

            *-- 13. Atualizar DirFiscais se diretorio alternativo informado
            IF !EMPTY(ALLTRIM(THIS.this_cDiretorio))
                goSistema.DirFiscais = THIS.this_cDiretorio
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            IF EMPTY(THIS.this_cMensagemErro)
                THIS.this_cMensagemErro = loc_oErro.Message
            ENDIF
            MsgErro(THIS.this_cMensagemErro, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterNomeFrx - Retorna caminho do FRX conforme opcoes de impressao
    * Logica original: procedures visualizacao/impressao/documento em SIGREIDT.SCX
    *--------------------------------------------------------------------------
    FUNCTION ObterNomeFrx()
        LOCAL loc_cFrx
        IF THIS.this_nOptTipo = 1
            IF THIS.this_nOptAgrupa = 2
                loc_cFrx = gc_4c_CaminhoReports + "SigReIdA"
            ELSE
                loc_cFrx = gc_4c_CaminhoReports + "SigReIdt"
            ENDIF
        ELSE
            loc_cFrx = gc_4c_CaminhoReports + "SigReIag"
        ENDIF
        RETURN loc_cFrx
    ENDFUNC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe relatorio em preview na tela
    * Logica original: PROCEDURE visualizacao em SIGREIDT.SCX
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_cFrx
        loc_cFrx = THIS.ObterNomeFrx()
        IF !EMPTY(loc_cFrx) AND FILE(loc_cFrx + ".frx")
            REPORT FORM (loc_cFrx) PREVIEW NOCONSOLE
        ELSE
            MsgAviso("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
                     "o encontrado: " + ALLTRIM(loc_cFrx), "Visualizar")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime relatorio com prompt de selecao de impressora
    * Logica original: PROCEDURE impressao em SIGREIDT.SCX
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_cFrx
        loc_cFrx = THIS.ObterNomeFrx()
        IF !EMPTY(loc_cFrx) AND FILE(loc_cFrx + ".frx")
            REPORT FORM (loc_cFrx) TO PRINTER PROMPT NOCONSOLE
        ELSE
            MsgAviso("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
                     "o encontrado: " + ALLTRIM(loc_cFrx), "Imprimir")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Documento - Imprime relatorio sem prompt
    * Logica original: PROCEDURE documento em SIGREIDT.SCX
    *--------------------------------------------------------------------------
    PROCEDURE Documento()
        LOCAL loc_cFrx
        loc_cFrx = THIS.ObterNomeFrx()
        IF !EMPTY(loc_cFrx) AND FILE(loc_cFrx + ".frx")
            REPORT FORM (loc_cFrx) TO PRINTER NOCONSOLE
        ELSE
            MsgAviso("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
                     "o encontrado: " + ALLTRIM(loc_cFrx), "Documento")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna a mensagem de erro atual
    *--------------------------------------------------------------------------
    FUNCTION ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDFUNC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de cursores e recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("crDBImp")
            USE IN crDBImp
        ENDIF
        IF USED("csCabecalho")
            USE IN csCabecalho
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

