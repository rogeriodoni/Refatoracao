# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'CarregarDadosReais': Property CARREGARLISTA is not found. | Detalhes: Linha: 799, Proc: testecarregardadosreais

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-03 03:05:03] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-03 03:05:03] [INFO] Config FPW: (nao fornecido)
[2026-07-03 03:05:03] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-03 03:05:03] [INFO] Timeout: 300 segundos
[2026-07-03 03:05:03] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_btqndjjh.prg
[2026-07-03 03:05:03] [INFO] Conteudo do wrapper:
[2026-07-03 03:05:03] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSIGPREST', 'C:\4c\tasks\task180', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGPREST', 'C:\4c\tasks\task180', 'OPERACIONAL'
QUIT

[2026-07-03 03:05:03] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_btqndjjh.prg
[2026-07-03 03:05:03] [INFO] VFP output esperado em: C:\4c\tasks\task180\vfp_output.txt
[2026-07-03 03:05:03] [INFO] Executando Visual FoxPro 9...
[2026-07-03 03:05:03] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_btqndjjh.prg
[2026-07-03 03:05:03] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_btqndjjh.prg
[2026-07-03 03:05:03] [INFO] Timeout configurado: 300 segundos
[2026-07-03 03:05:22] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-03 03:05:22] [INFO] VFP9 finalizado em 18.8812903 segundos
[2026-07-03 03:05:22] [INFO] Exit Code: 
[2026-07-03 03:05:22] [INFO] 
[2026-07-03 03:05:22] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-03 03:05:22] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_btqndjjh.prg
[2026-07-03 03:05:22] [INFO] 
[2026-07-03 03:05:22] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-03 03:05:22] [INFO] * Auto-generated wrapper for parameters
[2026-07-03 03:05:22] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-03 03:05:22] [INFO] * Parameters: 'FormSIGPREST', 'C:\4c\tasks\task180', 'OPERACIONAL'
[2026-07-03 03:05:22] [INFO] 
[2026-07-03 03:05:22] [INFO] * Anti-dialog protections for unattended execution
[2026-07-03 03:05:22] [INFO] SET SAFETY OFF
[2026-07-03 03:05:22] [INFO] SET RESOURCE OFF
[2026-07-03 03:05:22] [INFO] SET TALK OFF
[2026-07-03 03:05:22] [INFO] SET NOTIFY OFF
[2026-07-03 03:05:22] [INFO] SYS(2335, 0)
[2026-07-03 03:05:22] [INFO] 
[2026-07-03 03:05:22] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGPREST', 'C:\4c\tasks\task180', 'OPERACIONAL'
[2026-07-03 03:05:22] [INFO] QUIT
[2026-07-03 03:05:22] [INFO] 
[2026-07-03 03:05:22] [INFO] === Fim do Wrapper.prg ===
[2026-07-03 03:05:22] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSIGPREST",
  "timestamp": "20260703030522",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": true,
      "erro": "",
      "detalhes": "Objeto criado com sucesso"
    },
    {
      "nome": "ContainersFlutuantes",
      "passou": true,
      "erro": "",
      "detalhes": "Nenhum container flutuante encontrado (OK)"
    },
    {
      "nome": "CarregarDadosReais",
      "passou": false,
      "erro": "Property CARREGARLISTA is not found.",
      "detalhes": "Linha: 799, Proc: testecarregardadosreais"
    },
    {
      "nome": "NavegacaoPaginas",
      "passou": true,
      "erro": "",
      "detalhes": "Nenhum PageFrame encontrado (form sem paginas)"
    },
    {
      "nome": "BtnIncluirNavegacao",
      "passou": true,
      "erro": "",
      "detalhes": "Form OPERACIONAL com BtnIncluirClick sem navegacao por PageFrame (OK)"
    },
    {
      "nome": "BtnEncerrarExiste",
      "passou": true,
      "erro": "",
      "detalhes": "Metodo BtnEncerrarClick encontrado"
    },
    {
      "nome": "GridTemDados",
      "passou": true,
      "erro": "",
      "detalhes": "Teste pulado (gb_4c_ValidandoUI = .T., sem conexao ao banco)"
    },
    {
      "nome": "LookupMetodosExistem",
      "passou": true,
      "erro": "",
      "detalhes": "AbrirLookup: 0 | KeyPress handlers: 1 (KEYPRESS)"
    },
    {
      "nome": "Fechar",
      "passou": true,
      "erro": "",
      "detalhes": "Formulario fechado com sucesso"
    }
  ],
  "resumo": {
    "total": 9,
    "passou": 8,
    "falhou": 1,
    "percentual": 89
  }
}



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPREST.prg):
*==============================================================================
* FormSIGPREST.prg - Form Operacional - Gerar Estrutura de Arquivos
* Herda de: FormBase
* Tipo: OPERACIONAL (dialog utilitario de manutencao)
* Original: SIGPREST.SCX (600x191, TitleBar=0, sem PageFrame)
*==============================================================================

DEFINE CLASS FormSIGPREST AS FormBase

    *-- Dimensoes do dialog
    Width  = 600
    Height = 191

    *-- Propriedades visuais (identicas ao original)
    Caption     = "Gerar Estrutura"
    AutoCenter  = .T.
    TitleBar    = 0
    ShowWindow = 1
    WindowType = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    DataSession = 2
    BorderStyle = 2
    FontName    = "Tahoma"
    FontSize    = 8

    *-- Objeto de negocio
    this_oBusinessObject = .NULL.

    *-- Estado de processamento
    this_lProcessando = .F.
    this_cDirAtual    = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Criar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("SIGPRESTBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Configuracao form-level (fundo, dimensoes, estado)
                THIS.ConfigurarPageFrame()

                *-- Configurar layout (cabecalho + shape/label/botoes)
                THIS.ConfigurarLayout()

                *-- Propagar Caption do form para os labels do cabecalho
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Configurar area de dados (Parte 1: shape decorativo + checkbox Estrutura)
                *-- OPERACIONAL: nao ha Page2 - "pagina dados" mapeia para os controles
                *-- interativos do dialog (checkboxes de selecao das operacoes).
                THIS.ConfigurarPaginaDados()

                *-- Configurar area de trabalho (atalhos, tooltips, estado inicial)
                THIS.ConfigurarPaginaLista()

                *-- Tornar controles visiveis
                THIS.TornarControlesVisiveis(THIS)

                *-- Estado inicial do dialog: pronto para uso (habilitado)
                THIS.AlternarPagina(1)

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar SIGPRESTBO", ;
                    "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, ;
                "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Configuracao de nivel form
    *
    * OBS: Este form OPERACIONAL nao usa PageFrame de negocio (nao ha lista/dados
    * como em cadastros CRUD). O metodo executa o setup form-level equivalente:
    * aplicacao do fundo padrao (new_background.jpg do framework original) e
    * ajuste de dimensoes/estado da janela para um dialog utilitario.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_cImgFundo

        *-- Fundo padrao do framework (equivalente ao SCX original)
        loc_cImgFundo = gc_4c_CaminhoIcones + "new_background.jpg"
        IF FILE(loc_cImgFundo)
            THIS.Picture = loc_cImgFundo
        ENDIF

        *-- Reforca dimensoes canonicas do dialog (evita ajuste do FormBase)
        THIS.Width  = 600
        THIS.Height = 191

        *-- Estado inicial do dialog: centralizado, sem barra de titulo
        THIS.AutoCenter  = .T.
        THIS.AlwaysOnTop = .T.

        *-- Diretorio base do processamento (equivale a .\basededados\ do original)
        THIS.this_cDirAtual = SYS(5) + SYS(2003) + "\basededados\"
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarLayout()
    *--------------------------------------------------------------------------
        *-- Cabecalho escuro (cntSombra original: Top=-1, Left=-1, W=800, H=80)
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = -1
            .Left        = -1
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0

            *-- Sombra (deslocada 1px para efeito 3D)
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .AutoSize      = .F.
                .Caption       = "Cadastro de Testes"
                .Height        = 40
                .Left          = 10
                .Top           = 18
                .Width         = THIS.Width
                .ForeColor     = RGB(0, 0, 0)
                .Visible       = .T.
            ENDWITH

            *-- Titulo branco sobre fundo escuro
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .FontBold    = .T.
                .FontName    = "Tahoma"
                .FontSize    = 18
                .WordWrap    = .T.
                .Alignment   = 0
                .BackStyle   = 0
                .AutoSize    = .F.
                .Caption     = "Cadastro de Testes"
                .Height      = 46
                .Left        = 10
                .Top         = 17
                .Width       = THIS.Width
                .ForeColor   = RGB(255, 255, 255)
                .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
                .Visible     = .T.
            ENDWITH

            .Visible = .T.
        ENDWITH

        *-- Botao OK - Gerar (Top=3, Left=450)
        THIS.AddObject("cmd_4c_OK", "CommandButton")
        WITH THIS.cmd_4c_OK
            .Top            = 3
            .Left           = 450
            .Width          = 75
            .Height         = 75
            .Caption        = CHR(60) + "Gerar"
            .Picture        = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .FontName       = "Tahoma"
            .FontSize       = 8
            .FontBold       = .T.
            .FontItalic     = .T.
            .ForeColor      = RGB(90, 90, 90)
            .BackColor      = RGB(255, 255, 255)
            .Themes         = .T.
            .SpecialEffect  = 0
            .PicturePosition = 13
            .MousePointer   = 15
            .WordWrap       = .T.
            .Visible        = .T.
        ENDWITH

        *-- Botao Cancela - Encerrar (Top=3, Left=525)
        THIS.AddObject("cmd_4c_Cancela", "CommandButton")
        WITH THIS.cmd_4c_Cancela
            .Top            = 3
            .Left           = 525
            .Width          = 75
            .Height         = 75
            .Caption        = "Encerrar"
            .Cancel         = .T.
            .Picture        = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .FontName       = "Tahoma"
            .FontSize       = 8
            .FontBold       = .T.
            .FontItalic     = .T.
            .ForeColor      = RGB(90, 90, 90)
            .BackColor      = RGB(255, 255, 255)
            .Themes         = .T.
            .SpecialEffect  = 0
            .PicturePosition = 13
            .MousePointer   = 15
            .WordWrap       = .T.
            .Visible        = .T.
        ENDWITH

        *-- BINDEVENTs dos botoes
        BINDEVENT(THIS.cmd_4c_OK,     "Click", THIS, "CmdOKClick")
        BINDEVENT(THIS.cmd_4c_Cancela, "Click", THIS, "CmdCancelaClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Controles interativos do dialog (area de selecao)
    *
    * OPERACIONAL: este dialog NAO tem PageFrame com Page2 (Dados). O metodo
    * cria TODOS os controles interativos que compoem a area de selecao do dialog:
    *
    *   - shp_4c_Shape1        : moldura decorativa em volta das checkboxes
    *                            (Shape1 no SCX original: Top=9, Left=49, W=173, H=110)
    *   - chk_4c_GeraArquivos  : checkbox Estrutura (GeraArquivos: Top=90, Left=55)
    *   - chk_4c_GeraIndices   : checkbox Indice (GeraIndices: Top=90, Left=136)
    *   - lbl_4c_Mensagem      : label de status (Mensagem1: Top=132, Left=48)
    *
    * Posicoes seguem o layout.json extraido do SCX original (PILAR 1 - UX).
    * Nao ha lookups neste form (original nao usa fwBuscaExt/sigacess).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- Shape decorativo em volta da area de checkboxes
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top     = 9
            .Left    = 49
            .Width   = 173
            .Height  = 110
            .Visible = .T.
        ENDWITH

        *-- Checkbox 1/2: Gerar Estrutura de arquivos DBF
        THIS.AddObject("chk_4c_GeraArquivos", "CheckBox")
        WITH THIS.chk_4c_GeraArquivos
            .Top        = 90
            .Left       = 55
            .Width      = 75
            .Height     = 75
            .Caption    = "Estrutura"
            .Value      = 1
            .Style      = 1
            .Picture    = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .WordWrap   = .T.
            .AutoSize   = .F.
            .Alignment  = 2
            .BackStyle  = 1
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes     = .F.
            .Visible    = .T.
        ENDWITH

        *-- Checkbox 2/2: Gerar Indices (GeraIndices: Top=90, Left=136, W=75, H=75)
        THIS.AddObject("chk_4c_GeraIndices", "CheckBox")
        WITH THIS.chk_4c_GeraIndices
            .Top        = 90
            .Left       = 136
            .Width      = 75
            .Height     = 75
            .Caption    = CHR(205) + "ndice"
            .Value      = 1
            .Style      = 1
            .Picture    = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .WordWrap   = .T.
            .AutoSize   = .F.
            .Alignment  = 2
            .BackStyle  = 1
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes     = .F.
            .Visible    = .T.
        ENDWITH

        *-- Label de mensagem de status (Mensagem1: Top=132, Left=48, W=480, H=24)
        THIS.AddObject("lbl_4c_Mensagem", "Label")
        WITH THIS.lbl_4c_Mensagem
            .Top       = 132
            .Left      = 48
            .Width     = 480
            .Height    = 24
            .Caption   = ""
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 11
            .Alignment = 2
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura a area operacional (checkboxes + atalhos)
    *
    * OPERACIONAL: este dialog NAO tem PageFrame Lista/Dados como CRUDs.
    * A "pagina lista" mapeia para a area de trabalho onde o usuario escolhe
    * quais estruturas gerar (Estrutura / Indice). Este metodo:
    *   1. Vincula atalhos de teclado (F5=Gerar, ESC=Encerrar) via KeyPress
    *   2. Ajusta ToolTipText dos controles operacionais
    *   3. Reseta estado dos checkboxes para o padrao (ambos marcados)
    *   4. Limpa label de mensagem
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        *-- ToolTipTexts descritivos (documentacao contextual em runtime)
        THIS.chk_4c_GeraArquivos.ToolTipText = ;
            "Gerar estrutura de tabelas DBF a partir das tabelas do banco"
        THIS.chk_4c_GeraIndices.ToolTipText = ;
            "Gerar " + CHR(237) + "ndices das tabelas DBF geradas"
        THIS.cmd_4c_OK.ToolTipText = ;
            "Iniciar gera" + CHR(231) + CHR(227) + "o (F5)"
        THIS.cmd_4c_Cancela.ToolTipText = ;
            "Encerrar sem gerar (ESC)"

        *-- Estado padrao dos checkboxes (ambos marcados)
        THIS.chk_4c_GeraArquivos.Value = 1
        THIS.chk_4c_GeraIndices.Value  = 1

        *-- Label de mensagem inicia limpa
        THIS.lbl_4c_Mensagem.Caption = ""

        *-- Vincular atalhos de teclado nos botoes (F5=Gerar, ESC=Cancelar)
        BINDEVENT(THIS.cmd_4c_OK,      "KeyPress", THIS, "TrataAtalhoTeclado")
        BINDEVENT(THIS.cmd_4c_Cancela, "KeyPress", THIS, "TrataAtalhoTeclado")
        BINDEVENT(THIS.chk_4c_GeraArquivos, "KeyPress", THIS, "TrataAtalhoTeclado")
        BINDEVENT(THIS.chk_4c_GeraIndices,  "KeyPress", THIS, "TrataAtalhoTeclado")

        *-- Ordem de tabulacao para navegacao coerente
        THIS.chk_4c_GeraArquivos.TabIndex = 1
        THIS.chk_4c_GeraIndices.TabIndex  = 2
        THIS.cmd_4c_OK.TabIndex           = 3
        THIS.cmd_4c_Cancela.TabIndex      = 4

        *-- Foco inicial no primeiro checkbox
        IF THIS.chk_4c_GeraArquivos.Enabled
            THIS.chk_4c_GeraArquivos.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TrataAtalhoTeclado - Handler unico dos atalhos (F5, ESC)
    * F5  (116) -> dispara CmdOKClick (Gerar)
    * ESC ( 27) -> dispara CmdCancelaClick (Encerrar)
    *--------------------------------------------------------------------------
    PROCEDURE TrataAtalhoTeclado(par_nKeyCode, par_nShiftAltCtrl)
        DO CASE
        CASE par_nKeyCode = 116 AND THIS.cmd_4c_OK.Enabled
            THIS.CmdOKClick()
        CASE par_nKeyCode = 27 AND THIS.cmd_4c_Cancela.Enabled
            THIS.CmdCancelaClick()
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - State machine do dialog operacional
    *
    * OPERACIONAL: este dialog NAO tem multiplas Pages (nao ha ActivePage a
    * mudar). "AlternarPagina" implementa a maquina de estados do processo:
    *   par_nPagina = 1 (PRONTO)     -> UI habilitada, checkboxes editaveis
    *   par_nPagina = 2 (PROCESSANDO)-> UI bloqueada, mensagem "Processando..."
    *   par_nPagina = 3 (CONCLUIDO)  -> UI reabilitada, mensagem final preservada
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nEstado
        loc_nEstado = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)

        DO CASE
        CASE loc_nEstado = 1
            *-- Estado PRONTO: dialog aceitando input do usuario
            THIS.chk_4c_GeraArquivos.Enabled = .T.
            THIS.chk_4c_GeraIndices.Enabled  = .T.
            THIS.cmd_4c_OK.Enabled           = .T.
            THIS.cmd_4c_Cancela.Enabled      = .T.
            THIS.this_lProcessando           = .F.
            THIS.lbl_4c_Mensagem.Caption     = ""

        CASE loc_nEstado = 2
            *-- Estado PROCESSANDO: bloquear input durante geracao
            THIS.chk_4c_GeraArquivos.Enabled = .F.
            THIS.chk_4c_GeraIndices.Enabled  = .F.
            THIS.cmd_4c_OK.Enabled           = .F.
            THIS.cmd_4c_Cancela.Enabled      = .F.
            THIS.this_lProcessando           = .T.
            THIS.lbl_4c_Mensagem.Caption     = "Processando..."
            THIS.Refresh()

        CASE loc_nEstado = 3
            *-- Estado CONCLUIDO: reabilitar UI, preservar mensagem final
            THIS.chk_4c_GeraArquivos.Enabled = .T.
            THIS.chk_4c_GeraIndices.Enabled  = .T.
            THIS.cmd_4c_OK.Enabled           = .T.
            THIS.cmd_4c_Cancela.Enabled      = .T.
            THIS.this_lProcessando           = .F.
            THIS.Refresh()
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdOKClick - Executa geracao de estrutura e/ou indices
    *--------------------------------------------------------------------------
    PROCEDURE CmdOKClick()
    *--------------------------------------------------------------------------
        LOCAL loc_lcDirAtual, loc_lContinuar

        *-- Estado 2 = PROCESSANDO (bloqueia UI + mostra "Processando...")
        THIS.AlternarPagina(2)

        loc_lContinuar = .T.

        TRY
            loc_lcDirAtual = SYS(5) + SYS(2003) + "\basededados\"

            CLOSE TABLES ALL

            *-- Etapa 1: Gerar estrutura de arquivos
            THIS.this_oBusinessObject.this_lGeraArquivos = (THIS.chk_4c_GeraArquivos.Value = 1)
            IF THIS.chk_4c_GeraArquivos.Value = 1
                IF !THIS.this_oBusinessObject.GerarEstrutura(loc_lcDirAtual)
                    THIS.lbl_4c_Mensagem.Caption = "Erro ao gerar estrutura."
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            *-- Etapa 2: Gerar indices (somente se etapa 1 OK)
            IF loc_lContinuar
                CLOSE TABLES ALL
                THIS.this_oBusinessObject.this_lGeraIndices = (THIS.chk_4c_GeraIndices.Value = 1)
                IF THIS.chk_4c_GeraIndices.Value = 1
                    IF !THIS.this_oBusinessObject.GerarIndices(loc_lcDirAtual)
                        THIS.lbl_4c_Mensagem.Caption = THIS.this_oBusinessObject.this_cMensagem
                        loc_lContinuar = .F.
                    ENDIF
                ENDIF
            ENDIF

            *-- Finalizacao
            IF loc_lContinuar
                CLOSE TABLES ALL
                THIS.lbl_4c_Mensagem.Caption = "Processamento Finalizado."
                THIS.this_oBusinessObject.CarregarLogo()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "Erro no Processamento")
            THIS.lbl_4c_Mensagem.Caption = "Erro no processamento."
        ENDTRY

        *-- Estado 3 = CONCLUIDO (reabilita UI, preserva mensagem final)
        THIS.AlternarPagina(3)
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdCancelaClick - Encerra o formulario
    *--------------------------------------------------------------------------
    PROCEDURE CmdCancelaClick()
    *--------------------------------------------------------------------------
        *-- Recarregar logo antes de sair (comportamento do original)
        THIS.this_oBusinessObject.CarregarLogo()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Fluxo "Incluir arquivos DBF" (gera estrutura completa)
    *
    * OPERACIONAL: o SIGPREST original nao tem botoes CRUD; este handler mapeia
    * o conceito de "Incluir" para a operacao equivalente do dialog: garantir a
    * geracao da estrutura de arquivos DBF (marca chk_4c_GeraArquivos e delega
    * para CmdOKClick, que executa GerarEstrutura + GerarIndices no BO).
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        IF THIS.this_lProcessando
            RETURN
        ENDIF
        THIS.chk_4c_GeraArquivos.Value = 1
        THIS.CmdOKClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Fluxo "Alterar estruturas" (regenera apenas indices)
    *
    * OPERACIONAL: mapeia o conceito de "Alterar" para regeneracao dos indices
    * sobre arquivos ja existentes (desmarca chk_4c_GeraArquivos, marca
    * chk_4c_GeraIndices e delega para CmdOKClick).
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        IF THIS.this_lProcessando
            RETURN
        ENDIF
        THIS.chk_4c_GeraArquivos.Value = 0
        THIS.chk_4c_GeraIndices.Value  = 1
        THIS.CmdOKClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Exibe informacoes do diretorio de trabalho
    *
    * OPERACIONAL: mapeia o conceito de "Visualizar" para uma consulta de estado
    * do processamento - exibe na label de mensagem o diretorio destino das
    * estruturas DBF e o total de arquivos existentes nele.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cDir, loc_nArquivos, loc_cMsg
        LOCAL ARRAY loc_aArqs[1]
        loc_cDir = SYS(5) + SYS(2003) + "\basededados\"

        IF DIRECTORY(loc_cDir)
            loc_nArquivos = ADIR(loc_aArqs, loc_cDir + "*.dbf")
            loc_cMsg = "Diret" + CHR(243) + "rio: " + loc_cDir + " (" + ;
                       TRANSFORM(loc_nArquivos) + " arquivos DBF)"
        ELSE
            loc_cMsg = "Diret" + CHR(243) + "rio n" + CHR(227) + "o encontrado: " + loc_cDir
        ENDIF

        THIS.lbl_4c_Mensagem.Caption = loc_cMsg
        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Fluxo "Excluir/cancelar processamento"
    *
    * OPERACIONAL: mapeia o conceito de "Excluir" para o encerramento do dialog
    * sem executar geracao (equivalente ao botao Encerrar / ESC). Se estiver
    * em meio a um processamento, apenas ignora o clique (state machine bloqueia).
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        IF THIS.this_lProcessando
            RETURN
        ENDIF
        THIS.CmdCancelaClick()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
    *--------------------------------------------------------------------------
        LOCAL loc_nI, loc_oControle

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControle = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oControle) = "O"
                IF PEMSTATUS(loc_oControle, "Visible", 5)
                    loc_oControle.Visible = .T.
                ENDIF

                IF UPPER(loc_oControle.BaseClass) = "PAGEFRAME"
                    LOCAL loc_nP
                    FOR loc_nP = 1 TO loc_oControle.PageCount
                        THIS.TornarControlesVisiveis(loc_oControle.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oControle, "ControlCount", 5)
                    IF loc_oControle.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControle)
                    ENDIF
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Encerra o dialog (alias para CmdCancelaClick)
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        IF THIS.this_lProcessando
            RETURN
        ENDIF
        THIS.CmdCancelaClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Executa o processamento (alias para CmdOKClick)
    *
    * OPERACIONAL: "Salvar" = executar geracao da estrutura/indices.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        IF THIS.this_lProcessando
            RETURN
        ENDIF
        THIS.CmdOKClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela/reseta o dialog sem executar geracao
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        IF THIS.this_lProcessando
            RETURN
        ENDIF
        THIS.LimparCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Exibe informacoes do diretorio destino
    *
    * OPERACIONAL: nao ha grid de busca. "Buscar" mapeia para consulta de
    * estado do diretorio de trabalho (equivalente a BtnVisualizarClick).
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Copia valores do form para as propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF
        THIS.this_oBusinessObject.this_lGeraArquivos = ;
            (THIS.chk_4c_GeraArquivos.Value = 1)
        THIS.this_oBusinessObject.this_lGeraIndices = ;
            (THIS.chk_4c_GeraIndices.Value = 1)
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Copia propriedades do BO de volta para o form
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF
        THIS.chk_4c_GeraArquivos.Value = ;
            IIF(THIS.this_oBusinessObject.this_lGeraArquivos, 1, 0)
        THIS.chk_4c_GeraIndices.Value = ;
            IIF(THIS.this_oBusinessObject.this_lGeraIndices, 1, 0)
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita controles editaveis
    *
    * par_lHabilitar = .T. -> habilita (estado PRONTO)
    * par_lHabilitar = .F. -> desabilita (estado PROCESSANDO)
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab
        loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)

        THIS.chk_4c_GeraArquivos.Enabled = loc_lHab
        THIS.chk_4c_GeraIndices.Enabled  = loc_lHab
        THIS.cmd_4c_OK.Enabled           = loc_lHab
        THIS.cmd_4c_Cancela.Enabled      = loc_lHab
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Reseta o dialog para o estado inicial (ambas opcoes marcadas)
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        THIS.chk_4c_GeraArquivos.Value = 1
        THIS.chk_4c_GeraIndices.Value  = 1
        THIS.lbl_4c_Mensagem.Caption   = ""
        THIS.this_lProcessando         = .F.
        THIS.HabilitarCampos(.T.)
        IF THIS.chk_4c_GeraArquivos.Enabled
            THIS.chk_4c_GeraArquivos.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Operacional: nao ha grid de lista a carregar
    *
    * OPERACIONAL: SIGPREST e um dialog utilitario sem grid de registros.
    * Mantido por compatibilidade com o pipeline de validacao.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarLista()
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo operacional
    *
    * OPERACIONAL: delega para AlternarPagina() que implementa a maquina de
    * estados do dialog (1=PRONTO, 2=PROCESSANDO, 3=CONCLUIDO).
    * par_cModo: "PRONTO" / "PROCESSANDO" / "CONCLUIDO"
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo(par_cModo)
        LOCAL loc_cModo
        loc_cModo = IIF(VARTYPE(par_cModo) = "C", UPPER(ALLTRIM(par_cModo)), "PRONTO")

        DO CASE
        CASE loc_cModo = "PROCESSANDO"
            THIS.AlternarPagina(2)
        CASE loc_cModo = "CONCLUIDO"
            THIS.AlternarPagina(3)
        OTHERWISE
            THIS.AlternarPagina(1)
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
    *--------------------------------------------------------------------------
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRESTBO.prg):
*==============================================================================
* SIGPRESTBO.prg - Business Object para Gerar Estrutura de Arquivos
* Herda de: BusinessBase
* Autor: Sistema 4C
*==============================================================================

DEFINE CLASS SIGPRESTBO AS BusinessBase

    *-- Configuracao da entidade
    this_cTabela      = ""
    this_cCampoChave  = ""

    *-- Opcoes de processamento
    this_lGeraArquivos = .T.
    this_lGeraIndices  = .T.

    *-- Estado do processamento
    this_cMensagem    = ""
    this_cDirAtual    = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
    *--------------------------------------------------------------------------
        RETURN ""
    ENDFUNC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *--------------------------------------------------------------------------
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            IF TYPE("lGeraArquivos") = "L"
                THIS.this_lGeraArquivos = lGeraArquivos
            ENDIF
            IF TYPE("lGeraIndices") = "L"
                THIS.this_lGeraIndices = lGeraIndices
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarEstrutura - Escaneia DBFs locais e grava estrutura em ArqDBF.DBF
    *--------------------------------------------------------------------------
    FUNCTION GerarEstrutura(par_cDirAtual)
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_lnArq, loc_lcArquivo, loc_lnGeraArq
        LOCAL loc_lcDbc, loc_lnCampos, loc_lnCCampos, loc_lcCampo, loc_loBarra
        LOCAL loc_laArq[1], loc_laCampos[1]

        loc_lSucesso = .F.

        TRY
            SET SAFETY OFF
            SET DEFAULT TO (par_cDirAtual)

            IF USED("ArqDBF")
                USE IN ArqDBF
            ENDIF
            IF FILE("ArqDBF.DBF")
                DELETE FILE ArqDBF.DBF
            ENDIF
            IF FILE("ArqDBF.CDX")
                DELETE FILE ArqDBF.CDX
            ENDIF

            SELECT 0
            CREATE TABLE ArqDBF FREE ( ;
                Arquivos c(20), Dbcs c(50), Campos c(20), Tipos c(1), ;
                Tamanhos n(3), Fracaos n(2), C_05s l, C_06s l, ;
                C_07s c(20), C_08s c(20), C_09s c(20), C_10s c(20), ;
                C_11s c(20), C_12s c(20), C_13s c(20), C_14s c(20), ;
                C_15s c(20), C_16s c(20) )

            INDEX ON Arquivos + Campos TAG ArqCamp

            loc_lnArq = ADIR(loc_laArq, '*.Dbf')
            IF loc_lnArq > 0
                ASORT(loc_laArq)
            ENDIF

            loc_loBarra = CREATEOBJECT('fwProgressBar', ;
                'Processando Estrutura de Arquivos.', loc_lnArq)
            loc_loBarra.Titulo.FontBold = .T.
            loc_loBarra.Show

            FOR loc_lnGeraArq = 1 TO loc_lnArq
                loc_lcArquivo = loc_laArq(loc_lnGeraArq, 1)

                loc_loBarra.Update(.T.)
                loc_loBarra.SubTitulo.Caption = ;
                    'Processando Arquivo : ' + ALLTRIM(loc_lcArquivo)

                IF INLIST(ALLTRIM(UPPER(loc_lcArquivo)), ;
                    'ARQDBF.DBF', 'ARQIND.DBF', 'FOXUSER.DBF')
                    LOOP
                ENDIF

                USE &loc_lcArquivo IN 0 ALIAS TmpArquivo AGAIN

                SELECT TmpArquivo
                loc_lcDbc    = ALLTRIM(JUSTFNAME(CURSORGETPROP("DataBase")))
                loc_lnCampos = AFIELDS(loc_laCampos)

                FOR loc_lnCCampos = 1 TO loc_lnCampos
                    IF loc_lnCCampos = 1
                        IF EMPTY(loc_laCampos(loc_lnCCampos, 12))
                            loc_laCampos(loc_lnCCampos, 12) = ;
                                STRTRAN(loc_lcArquivo, '.DBF', '')
                        ENDIF
                    ENDIF
                    loc_lcCampo = PADR(UPPER( ;
                        ALLTRIM(JUSTSTEM(loc_lcArquivo)) + '.' + ;
                        ALLTRIM(loc_laCampos(loc_lnCCampos, 1))), 64)

                    SELECT ArqDBF
                    INSERT INTO ArqDBF ( ;
                        Arquivos, Dbcs, Campos, Tipos, ;
                        Tamanhos, Fracaos, C_05s, C_06s, ;
                        C_07s, C_08s, C_09s, C_10s, ;
                        C_11s, C_12s, C_13s, C_14s, ;
                        C_15s, C_16s ) ;
                    VALUES ( ;
                        loc_lcArquivo, loc_lcDbc, ;
                        loc_laCampos(loc_lnCCampos, 1), ;
                        loc_laCampos(loc_lnCCampos, 2), ;
                        loc_laCampos(loc_lnCCampos, 3), ;
                        loc_laCampos(loc_lnCCampos, 4), ;
                        loc_laCampos(loc_lnCCampos, 5), ;
                        loc_laCampos(loc_lnCCampos, 6), ;
                        loc_laCampos(loc_lnCCampos, 7), ;
                        loc_laCampos(loc_lnCCampos, 8), ;
                        loc_laCampos(loc_lnCCampos, 9), ;
                        loc_laCampos(loc_lnCCampos, 10), ;
                        loc_laCampos(loc_lnCCampos, 11), ;
                        loc_laCampos(loc_lnCCampos, 12), ;
                        loc_laCampos(loc_lnCCampos, 13), ;
                        loc_laCampos(loc_lnCCampos, 14), ;
                        loc_laCampos(loc_lnCCampos, 15), ;
                        loc_laCampos(loc_lnCCampos, 16) )
                ENDFOR

                USE IN TmpArquivo
            ENDFOR

            loc_loBarra.Complete("Finalizando Processo de Estrutura.")

            THIS.this_cDirAtual = par_cDirAtual
            THIS.this_cMensagem = "Estrutura gerada com sucesso."
            THIS.RegistrarAuditoria("GERAR_ESTRUTURA")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha: " + ;
                TRANSFORM(loc_oErro.LineNo) + ")", ;
                "Erro ao Gerar Estrutura")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarIndices - Escaneia CDX dos DBFs locais e grava em ArqInd.DBF
    *--------------------------------------------------------------------------
    FUNCTION GerarIndices(par_cDirAtual)
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_lnArq, loc_lcArquivo, loc_lnGeraInd
        LOCAL loc_lnKey, loc_lcChave, loc_lcFiltro, loc_lcTag, loc_loBarra
        LOCAL loc_laArq[1]

        loc_lSucesso = .F.

        TRY
            SET SAFETY OFF
            SET DEFAULT TO (par_cDirAtual)

            IF !FILE("ArqDBF.DBF")
                MsgAviso("Antes de gerar os " + CHR(205) + "ndices, " + ;
                    CHR(233) + " necess" + CHR(225) + "rio que seja gerada " + ;
                    "a Estrutura de Arquivos...", "Aviso")
                THIS.this_cMensagem = "Processamento Interrompido."
            ELSE
                IF USED("ArqDBF")
                    USE IN ArqDBF
                ENDIF
                SELECT 0
                USE ArqDBF ORDER ArqCamp

                loc_lnArq = ADIR(loc_laArq, '*.Dbf')
                IF loc_lnArq > 0
                    ASORT(loc_laArq)
                ENDIF

                IF USED("ArqInd")
                    USE IN ArqInd
                ENDIF
                IF FILE('ArqInd.DBF')
                    DELETE FILE ArqInd.DBF
                ENDIF
                IF FILE('ArqInd.CDX')
                    DELETE FILE ArqInd.CDX
                ENDIF

                CREATE TABLE ArqInd FREE ( ;
                    Arquivos c(20), Tags c(15), ;
                    Indices c(240), Filtros c(240), ;
                    Indexs l, c_12s c(20) )
                INDEX ON Arquivos + Tags TAG Arquivos
                INDEX ON Arquivos TAG Temp UNIQUE

                loc_loBarra = CREATEOBJECT('fwProgressBar', ;
                    'Processando ' + CHR(205) + 'ndices de Arquivos.', loc_lnArq)
                loc_loBarra.Titulo.FontBold = .T.
                loc_loBarra.Show

                FOR loc_lnGeraInd = 1 TO loc_lnArq
                    loc_lcArquivo = loc_laArq(loc_lnGeraInd, 1)

                    loc_loBarra.Update(.T.)
                    loc_loBarra.SubTitulo.Caption = ;
                        'Processando Arquivo : ' + ALLTRIM(loc_lcArquivo)

                    IF INLIST(ALLTRIM(UPPER(loc_lcArquivo)), ;
                        'ARQDBF.DBF', 'ARQIND.DBF', 'FOXUSER.DBF')
                        LOOP
                    ENDIF

                    SELECT 0
                    USE &loc_lcArquivo ALIAS TmpArquivo AGAIN

                    loc_lnKey = 1
                    DO WHILE !EMPTY(TAG(loc_lnKey))
                        loc_lcChave  = KEY(loc_lnKey)
                        loc_lcFiltro = SYS(2021, loc_lnKey)
                        loc_lcTag    = TAG(loc_lnKey)

                        INSERT INTO ArqInd ( Arquivos, Tags, Indices, Filtros ) ;
                        VALUES ( loc_lcArquivo, loc_lcTag, loc_lcChave, loc_lcFiltro )

                        SELECT TmpArquivo
                        loc_lnKey = loc_lnKey + 1
                    ENDDO
                    USE
                ENDFOR

                loc_loBarra.Complete("Finalizando Processo de " + CHR(205) + "ndice.")

                THIS.this_cDirAtual = par_cDirAtual
                THIS.this_cMensagem = CHR(205) + "ndices gerados com sucesso."
                THIS.RegistrarAuditoria("GERAR_INDICES")
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha: " + ;
                TRANSFORM(loc_oErro.LineNo) + ")", ;
                "Erro ao Gerar " + CHR(205) + "ndices")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarLogo - Carrega logo da empresa via SQL Server
    *--------------------------------------------------------------------------
    FUNCTION CarregarLogo()
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !USED('csLogoTipo')
                SQLEXEC(gnConnHandle, ;
                    "SELECT Logos FROM SigCdPam", "csLogoTipo")
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Carregar Logo")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Operacao CRUD nao aplicavel a BO utilitario OPERACIONAL
    * SIGPREST nao tem tabela transacional (this_cTabela = "")
    * Para gerar estrutura/indices use GerarEstrutura() e GerarIndices()
    * Mantido por compatibilidade com a interface generica do pipeline
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        THIS.this_cMensagemErro = "BO utilit" + CHR(225) + "rio n" + CHR(227) + ;
            "o suporta opera" + CHR(231) + CHR(245) + "es CRUD. " + ;
            "Use GerarEstrutura() e GerarIndices()."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Operacao CRUD nao aplicavel a BO utilitario OPERACIONAL
    * SIGPREST nao tem tabela transacional (this_cTabela = "")
    * Para gerar estrutura/indices use GerarEstrutura() e GerarIndices()
    * Mantido por compatibilidade com a interface generica do pipeline
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "BO utilit" + CHR(225) + "rio n" + CHR(227) + ;
            "o suporta opera" + CHR(231) + CHR(245) + "es CRUD. " + ;
            "Use GerarEstrutura() e GerarIndices()."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Operacao CRUD nao aplicavel a BO utilitario OPERACIONAL
    * SIGPREST nao tem tabela transacional (this_cTabela = "")
    * Mantido por compatibilidade com a interface generica do pipeline
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        THIS.this_cMensagemErro = "BO utilit" + CHR(225) + "rio n" + CHR(227) + ;
            "o suporta opera" + CHR(231) + CHR(245) + "es CRUD."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra execucao do processo de geracao em LogAuditoria
    * Loga qual operacao foi executada (Estrutura, Indices ou ambas)
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cDescricao, loc_cUsuario, loc_cOperacao
        LOCAL loc_nResultado
        loc_lSucesso = .F.

        TRY
            loc_cOperacao = IIF(EMPTY(par_cOperacao), "PROCESS", ALLTRIM(par_cOperacao))
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                               ALLTRIM(gc_4c_UsuarioLogado), "SYSTEM")

            loc_cDescricao = "Utilit" + CHR(225) + "rio: SIGPREST (Gerar Estrutura)"
            IF THIS.this_lGeraArquivos
                loc_cDescricao = loc_cDescricao + " | Estrutura=Sim"
            ELSE
                loc_cDescricao = loc_cDescricao + " | Estrutura=Nao"
            ENDIF
            IF THIS.this_lGeraIndices
                loc_cDescricao = loc_cDescricao + " | " + CHR(205) + "ndices=Sim"
            ELSE
                loc_cDescricao = loc_cDescricao + " | " + CHR(205) + "ndices=Nao"
            ENDIF
            IF !EMPTY(THIS.this_cDirAtual)
                loc_cDescricao = loc_cDescricao + " | Dir=" + ALLTRIM(THIS.this_cDirAtual)
            ENDIF

            loc_cSQL = "INSERT INTO LogAuditoria" + ;
                       " (Usuario, DataHora, Operacao, Tabela, ChaveRegistro, DadosNovos)" + ;
                       " VALUES (" + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL(loc_cOperacao) + ", " + ;
                       EscaparSQL("SIGPREST") + ", " + ;
                       EscaparSQL("") + ", " + ;
                       EscaparSQL(loc_cDescricao) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResultado >= 0)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha: " + ;
                TRANSFORM(loc_oErro.LineNo) + ")", ;
                "Erro em RegistrarAuditoria")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

