# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 2/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'LookupMetodosExistem': Campos de lookup encontrados mas nenhum metodo AbrirLookup existe | Detalhes: AbrirLookup: 0 | KeyPress handlers: 9 (CONTACOLKEYPRESS, CORCOLKEYPRESS, EMPCOLKEYPRESS, GRUPOCOLKEYPRESS, KEYPRESS, LOCALCOLKEYPRESS, PRODUTOCODKEYPRESS, PRODUTODESCKEYPRESS, TAMANHOCOLKEYPRESS) | Campos lookup: 1 | SEM lookup: txt_4c_Cgru

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-01 11:58:39] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-01 11:58:39] [INFO] Config FPW: (nao fornecido)
[2026-08-01 11:58:39] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-01 11:58:39] [INFO] Timeout: 300 segundos
[2026-08-01 11:58:39] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_i3en4nso.prg
[2026-08-01 11:58:39] [INFO] Conteudo do wrapper:
[2026-08-01 11:58:39] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormEmn', 'C:\4c\tasks\task403', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormEmn', 'C:\4c\tasks\task403', 'CRUD'
QUIT

[2026-08-01 11:58:39] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_i3en4nso.prg
[2026-08-01 11:58:39] [INFO] VFP output esperado em: C:\4c\tasks\task403\vfp_output.txt
[2026-08-01 11:58:39] [INFO] Executando Visual FoxPro 9...
[2026-08-01 11:58:39] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_i3en4nso.prg
[2026-08-01 11:58:39] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_i3en4nso.prg
[2026-08-01 11:58:39] [INFO] Timeout configurado: 300 segundos
[2026-08-01 11:59:28] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-01 11:59:28] [INFO] VFP9 finalizado em 49.1446786 segundos
[2026-08-01 11:59:28] [INFO] Exit Code: 
[2026-08-01 11:59:28] [INFO] 
[2026-08-01 11:59:28] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-01 11:59:28] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_i3en4nso.prg
[2026-08-01 11:59:28] [INFO] 
[2026-08-01 11:59:28] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-01 11:59:28] [INFO] * Auto-generated wrapper for parameters
[2026-08-01 11:59:28] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-01 11:59:28] [INFO] * Parameters: 'FormEmn', 'C:\4c\tasks\task403', 'CRUD'
[2026-08-01 11:59:28] [INFO] 
[2026-08-01 11:59:28] [INFO] * Anti-dialog protections for unattended execution
[2026-08-01 11:59:28] [INFO] SET SAFETY OFF
[2026-08-01 11:59:28] [INFO] SET RESOURCE OFF
[2026-08-01 11:59:28] [INFO] SET TALK OFF
[2026-08-01 11:59:28] [INFO] SET NOTIFY OFF
[2026-08-01 11:59:28] [INFO] SYS(2335, 0)
[2026-08-01 11:59:28] [INFO] 
[2026-08-01 11:59:28] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormEmn', 'C:\4c\tasks\task403', 'CRUD'
[2026-08-01 11:59:28] [INFO] QUIT
[2026-08-01 11:59:28] [INFO] 
[2026-08-01 11:59:28] [INFO] === Fim do Wrapper.prg ===
[2026-08-01 11:59:28] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-08-01 12:02:33] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-01 12:02:33] [INFO] Config FPW: (nao fornecido)
[2026-08-01 12:02:33] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-01 12:02:33] [INFO] Timeout: 300 segundos
[2026-08-01 12:02:33] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_dprtqbvo.prg
[2026-08-01 12:02:33] [INFO] Conteudo do wrapper:
[2026-08-01 12:02:33] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormEmn', 'C:\4c\tasks\task403', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormEmn', 'C:\4c\tasks\task403', 'CRUD'
QUIT

[2026-08-01 12:02:33] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_dprtqbvo.prg
[2026-08-01 12:02:33] [INFO] VFP output esperado em: C:\4c\tasks\task403\vfp_output.txt
[2026-08-01 12:02:33] [INFO] Executando Visual FoxPro 9...
[2026-08-01 12:02:33] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_dprtqbvo.prg
[2026-08-01 12:02:33] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_dprtqbvo.prg
[2026-08-01 12:02:33] [INFO] Timeout configurado: 300 segundos
[2026-08-01 12:03:28] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-01 12:03:28] [INFO] VFP9 finalizado em 54.6384397 segundos
[2026-08-01 12:03:28] [INFO] Exit Code: 
[2026-08-01 12:03:28] [INFO] 
[2026-08-01 12:03:28] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-01 12:03:28] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_dprtqbvo.prg
[2026-08-01 12:03:28] [INFO] 
[2026-08-01 12:03:28] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-01 12:03:28] [INFO] * Auto-generated wrapper for parameters
[2026-08-01 12:03:28] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-01 12:03:28] [INFO] * Parameters: 'FormEmn', 'C:\4c\tasks\task403', 'CRUD'
[2026-08-01 12:03:28] [INFO] 
[2026-08-01 12:03:28] [INFO] * Anti-dialog protections for unattended execution
[2026-08-01 12:03:28] [INFO] SET SAFETY OFF
[2026-08-01 12:03:28] [INFO] SET RESOURCE OFF
[2026-08-01 12:03:28] [INFO] SET TALK OFF
[2026-08-01 12:03:28] [INFO] SET NOTIFY OFF
[2026-08-01 12:03:28] [INFO] SYS(2335, 0)
[2026-08-01 12:03:28] [INFO] 
[2026-08-01 12:03:28] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormEmn', 'C:\4c\tasks\task403', 'CRUD'
[2026-08-01 12:03:28] [INFO] QUIT
[2026-08-01 12:03:28] [INFO] 
[2026-08-01 12:03:28] [INFO] === Fim do Wrapper.prg ===
[2026-08-01 12:03:28] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormEmn",
  "timestamp": "20260801120328",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": true,
      "erro": "",
      "detalhes": "Objeto criado com sucesso"
    },
    {
      "nome": "CarregarLista",
      "passou": true,
      "erro": "",
      "detalhes": "1 registros em cursor_4c_Lista"
    },
    {
      "nome": "ModoIncluir",
      "passou": true,
      "erro": "",
      "detalhes": "Page2 ativada com sucesso"
    },
    {
      "nome": "ModoVisualizar",
      "passou": true,
      "erro": "",
      "detalhes": "Modo VISUALIZAR configurado"
    },
    {
      "nome": "BtnIncluirNavegacao",
      "passou": true,
      "erro": "",
      "detalhes": "BtnIncluirClick navegou para Page2 | BtnCancelarClick retornou para Page1"
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
      "passou": false,
      "erro": "Campos de lookup encontrados mas nenhum metodo AbrirLookup existe",
      "detalhes": "AbrirLookup: 0 | KeyPress handlers: 9 (CONTACOLKEYPRESS, CORCOLKEYPRESS, EMPCOLKEYPRESS, GRUPOCOLKEYPRESS, KEYPRESS, LOCALCOLKEYPRESS, PRODUTOCODKEYPRESS, PRODUTODESCKEYPRESS, TAMANHOCOLKEYPRESS) | Campos lookup: 1 | SEM lookup: txt_4c_Cgru"
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormEmn.prg):
*==============================================================================
* FormEmn.prg - Formulario de Estoque Alvo (Minimo por Produto/Empresa)
* Legado: SIGCDEMN (frmcadastro)
* Herda de: FormBase
*==============================================================================

DEFINE CLASS FormEmn AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais (PILAR 1 - UX Fidelity)
    *--------------------------------------------------------------------------
    Height      = 600
    Width       = 1000
    Caption     = "Estoque Alvo"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *--------------------------------------------------------------------------
    * Propriedades do formulario
    *--------------------------------------------------------------------------
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"    && LISTA / INCLUIR / ALTERAR / VISUALIZAR

    *-- Modo externo: form chamado com produto fixado por outro form
    this_cProdutoExterno = ""         && Codigo do produto externo (se aplicavel)
    this_lProdutoFixo    = .F.        && .T. quando produto foi fixado externamente
    this_cEscolha        = ""         && INSERIR / ALTERAR / PROCURAR / VISUALIZAR (legado)

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * InicializarForm - Chamado automaticamente pelo FormBase.Init()
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("EmnBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    THIS.CarregarLista()
                ENDIF

                loc_lResultado = .T.
            ELSE
                MsgErro("Falha ao criar EmnBO.", "FormEmn.InicializarForm")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.InicializarForm")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPg1, loc_oPg2

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .PageCount  = 2
            .Top        = -29
            .Left       = 0
            .Width      = THIS.Width
            .Height     = THIS.Height + 29
            .Tabs       = .F.
            .Visible    = .T.

            .Page1.BackColor = RGB(100, 100, 100)
            .Page2.BackColor = RGB(100, 100, 100)
        ENDWITH

        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Imagem de fundo (legado: new_background.jpg)
        loc_oPg1.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
        loc_oPg2.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

        THIS.ConfigurarPaginaLista(loc_oPg1)
        THIS.ConfigurarPaginaDados(loc_oPg2)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Cria containers base na Page1 (Lista)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista(par_oPagina)

        *-- Cabecalho escuro com titulo (cntSombra legado)
        *-- Compensacao PageFrame: cntSombra.Top=1 + 29 = 30
        par_oPagina.AddObject("cnt_4c_Sombra", "Container")
        WITH par_oPagina.cnt_4c_Sombra
            .Top         = 30
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        par_oPagina.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
        WITH par_oPagina.cnt_4c_Sombra.lbl_4c_Sombra
            .Top       = 15
            .Left      = 10
            .Width     = THIS.Width - 12
            .Height    = 40
            .Caption   = THIS.Caption
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPagina.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
        WITH par_oPagina.cnt_4c_Sombra.lbl_4c_Titulo
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width - 12
            .Height    = 46
            .Caption   = THIS.Caption
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container de botoes CRUD (Grupo_op legado)
        *-- Grupo_op.Top=-1 + 29 = 28, Left=544
        par_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH par_oPagina.cnt_4c_Botoes
            .Top         = 28
            .Left        =  542
            .Width       = 385
            .Height      = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir (Inserir legado: Top=5, Left=5)
        par_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH par_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(par_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Botao Visualizar (Consultar legado: Top=5, Left=80)
        par_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH par_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(par_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Botao Alterar (Top=5, Left=155)
        par_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH par_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(par_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Botao Excluir (Top=5, Left=230)
        par_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH par_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(par_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Botao Buscar (Procurar legado: Top=5, Left=305)
        par_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH par_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(par_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container de saida - padrao canonico (Grupo_Saida legado)
        par_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH par_oPagina.cnt_4c_Saida
            .Top         = 28
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        par_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH par_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(par_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid da lista (Pagina.Lista.Grade legado: Top=121, Left=12, Width=939, Height=470)
        *-- Compensacao PageFrame: Top=121 + 29 = 150
        par_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH par_oPagina.grd_4c_Lista
            .Top               = 150
            .Left              = 12
            .Width             = 939
            .Height            = 435
            .FontName          = "Verdana"
            .FontSize          = 8
            .ForeColor         = RGB(90, 90, 90)
            .BackColor         = RGB(255, 255, 255)
            .GridLineColor     = RGB(238, 238, 238)
            .GridLines         = 3
            .RowHeight         = 16
            .HeaderHeight      = 20
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ScrollBars        = 2
            .HighlightStyle    = 2
            .HighlightBackColor = RGB(15, 41, 104)
            .HighlightForeColor = RGB(255, 255, 255)
            .ReadOnly          = .T.
            .AllowCellSelection = .F.
            .AllowHeaderSizing = .F.
            .ColumnCount       = 5
            .Visible           = .T.
        ENDWITH

        BINDEVENT(par_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnAlterarClick")

        THIS.TornarControlesVisiveis(par_oPagina)
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega registros na grid da Page1 (cursor CrProdutos)
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                IF USED("cursor_4c_Lista")
                    USE IN cursor_4c_Lista
                ENDIF
                CREATE CURSOR cursor_4c_Lista (cpros C(14), dpros C(65), ifors C(10), reffs C(20), sgrus C(3))
                INSERT INTO cursor_4c_Lista VALUES ("", "", "", "", "")
                GO TOP IN cursor_4c_Lista
                loc_lResultado = .T.
            ELSE
                IF VARTYPE(THIS.this_oBusinessObject) <> "O"
                    MsgErro("Business Object nao inicializado.", "FormEmn.CarregarLista")
                ELSE
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                    IF !THIS.this_oBusinessObject.Buscar("")
                        loc_lResultado = .F.
                    ELSE
                        *-- Configurar RecordSource + colunas
                        loc_oGrid.RecordSource = "CrProdutos"

                        loc_oGrid.Column1.ControlSource   = "CrProdutos.cpros"
                        loc_oGrid.Column1.Width           = 100
                        loc_oGrid.Column1.Header1.Caption = ""
                        loc_oGrid.Column1.Header1.Alignment = 2
                        loc_oGrid.Column1.Header1.FontName  = "Tahoma"
                        loc_oGrid.Column1.Header1.FontSize  = 8
                        loc_oGrid.Column1.Header1.ForeColor = RGB(90, 90, 90)

                        loc_oGrid.Column2.ControlSource   = "CrProdutos.dpros"
                        loc_oGrid.Column2.Width           = 430
                        loc_oGrid.Column2.Header1.Caption = "Produto"
                        loc_oGrid.Column2.Header1.Alignment = 2
                        loc_oGrid.Column2.Header1.FontName  = "Tahoma"
                        loc_oGrid.Column2.Header1.FontSize  = 8
                        loc_oGrid.Column2.Header1.ForeColor = RGB(90, 90, 90)

                        loc_oGrid.Column3.ControlSource   = "CrProdutos.ifors"
                        loc_oGrid.Column3.Width           = 100
                        loc_oGrid.Column3.Header1.Caption = ""
                        loc_oGrid.Column3.Header1.Alignment = 2
                        loc_oGrid.Column3.Header1.FontName  = "Tahoma"
                        loc_oGrid.Column3.Header1.FontSize  = 8
                        loc_oGrid.Column3.Header1.ForeColor = RGB(90, 90, 90)

                        loc_oGrid.Column4.ControlSource   = "CrProdutos.reffs"
                        loc_oGrid.Column4.Width           = 150
                        loc_oGrid.Column4.Header1.Caption = ""
                        loc_oGrid.Column4.Header1.Alignment = 2
                        loc_oGrid.Column4.Header1.FontName  = "Tahoma"
                        loc_oGrid.Column4.Header1.FontSize  = 8
                        loc_oGrid.Column4.Header1.ForeColor = RGB(90, 90, 90)

                        loc_oGrid.Column5.ControlSource   = "CrProdutos.sgrus"
                        loc_oGrid.Column5.Width           = 140
                        loc_oGrid.Column5.Header1.Caption = ""
                        loc_oGrid.Column5.Header1.Alignment = 2
                        loc_oGrid.Column5.Header1.FontName  = "Tahoma"
                        loc_oGrid.Column5.Header1.FontSize  = 8
                        loc_oGrid.Column5.Header1.ForeColor = RGB(90, 90, 90)

                        THIS.FormatarGridLista(loc_oGrid)
                        loc_oGrid.Refresh()

                        loc_lResultado = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) <> "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.this_cModoAtual = "LISTA"
                THIS.CarregarLista()
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Inicia inclusao de novo registro
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.NovoRegistro()
            ENDIF

            THIS.this_cEscolha   = "INSERIR"
            THIS.this_cModoAtual = "INCLUIR"

            IF PEMSTATUS(THIS, "LimparCampos", 5)
                THIS.LimparCampos()
            ENDIF
            IF PEMSTATUS(THIS, "HabilitarCampos", 5)
                THIS.HabilitarCampos(.T.)
            ENDIF

            THIS.pgf_4c_Paginas.ActivePage = 2
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.BtnIncluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Visualiza registro selecionado (somente leitura)
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCPros, loc_lProsseguir
        loc_cCPros      = ""
        loc_lProsseguir = .T.

        TRY
            IF !USED("CrProdutos") OR EOF("CrProdutos")
                MsgAviso("Nenhum registro selecionado.", "Visualizar")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                SELECT CrProdutos
                loc_cCPros = ALLTRIM(CrProdutos.cpros)
                IF EMPTY(loc_cCPros)
                    MsgAviso("Produto inv" + CHR(225) + "lido.", "Visualizar")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir AND VARTYPE(THIS.this_oBusinessObject) <> "O"
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir AND !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCPros)
                MsgErro("Falha ao carregar produto " + loc_cCPros, "Visualizar")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                THIS.this_cEscolha   = "PROCURAR"
                THIS.this_cModoAtual = "VISUALIZAR"

                IF PEMSTATUS(THIS, "BOParaForm", 5)
                    THIS.BOParaForm()
                ENDIF
                IF PEMSTATUS(THIS, "HabilitarCampos", 5)
                    THIS.HabilitarCampos(.F.)
                ENDIF

                THIS.pgf_4c_Paginas.ActivePage = 2
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Altera registro selecionado
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCPros, loc_lProsseguir
        loc_cCPros      = ""
        loc_lProsseguir = .T.

        TRY
            IF !USED("CrProdutos") OR EOF("CrProdutos")
                MsgAviso("Nenhum registro selecionado.", "Alterar")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                SELECT CrProdutos
                loc_cCPros = ALLTRIM(CrProdutos.cpros)
                IF EMPTY(loc_cCPros)
                    MsgAviso("Produto inv" + CHR(225) + "lido.", "Alterar")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir AND VARTYPE(THIS.this_oBusinessObject) <> "O"
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir AND !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCPros)
                MsgErro("Falha ao carregar produto " + loc_cCPros, "Alterar")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.this_cEscolha   = "ALTERAR"
                THIS.this_cModoAtual = "ALTERAR"

                IF PEMSTATUS(THIS, "BOParaForm", 5)
                    THIS.BOParaForm()
                ENDIF
                IF PEMSTATUS(THIS, "HabilitarCampos", 5)
                    THIS.HabilitarCampos(.T.)
                ENDIF

                THIS.pgf_4c_Paginas.ActivePage = 2
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.BtnAlterarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Exclui registro selecionado
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCPros, loc_lConfirma, loc_lProsseguir
        loc_cCPros      = ""
        loc_lConfirma   = .F.
        loc_lProsseguir = .T.

        TRY
            IF !USED("CrProdutos") OR EOF("CrProdutos")
                MsgAviso("Nenhum registro selecionado.", "Excluir")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                SELECT CrProdutos
                loc_cCPros = ALLTRIM(CrProdutos.cpros)
                IF EMPTY(loc_cCPros)
                    MsgAviso("Produto inv" + CHR(225) + "lido.", "Excluir")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do produto " + loc_cCPros + " ?", "Excluir")
                IF !loc_lConfirma
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir AND VARTYPE(THIS.this_oBusinessObject) <> "O"
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir AND !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCPros)
                MsgErro("Falha ao carregar produto " + loc_cCPros, "Excluir")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Registro exclu" + CHR(237) + "do com sucesso.", "Excluir")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.BtnExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Abre FormBuscaAuxiliar para localizar produto
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cCPros
        loc_cCPros = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPro", "cursor_4c_BuscaProd", "cpros", "", ;
                "Buscar Produto")

            IF VARTYPE(loc_oBusca) <> "O"
                RETURN
            ENDIF

            IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
            ENDIF

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
                loc_cCPros = ALLTRIM(cursor_4c_BuscaProd.cpros)
            ENDIF

            IF USED("cursor_4c_BuscaProd")
                USE IN cursor_4c_BuscaProd
            ENDIF

            loc_oBusca.Release()

            IF !EMPTY(loc_cCPros)
                *-- Recarrega lista filtrando pelo produto selecionado
                IF VARTYPE(THIS.this_oBusinessObject) = "O"
                    IF THIS.this_oBusinessObject.Buscar(loc_cCPros)
                        THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.BtnBuscarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Cria containers e campos na Page2 (Dados)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados(par_oPagina)

        *-- Cabecalho escuro com titulo (padrao nova arquitetura em Page2)
        *-- Top = 1 + 29 = 30
        par_oPagina.AddObject("cnt_4c_Sombra", "Container")
        WITH par_oPagina.cnt_4c_Sombra
            .Top         = 30
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        par_oPagina.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
        WITH par_oPagina.cnt_4c_Sombra.lbl_4c_Sombra
            .Top       = 15
            .Left      = 10
            .Width     = THIS.Width - 12
            .Height    = 40
            .Caption   = THIS.Caption
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPagina.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
        WITH par_oPagina.cnt_4c_Sombra.lbl_4c_Titulo
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width - 12
            .Height    = 46
            .Caption   = THIS.Caption
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container de botoes Salvar/Cancelar (Grupo_Salva legado)
        *-- Grupo_Salva.Top=8 + 29 = 37, Left=820
        par_oPagina.AddObject("cnt_4c_Salva", "Container")
        WITH par_oPagina.cnt_4c_Salva
            .Top         = 37
            .Left        = 820
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar/Salvar (Left=5, Top=5, Width=75, Height=75)
        par_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH par_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botao Cancelar (Left=80, Top=5, Width=75, Height=75)
        par_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH par_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *--------------------------------------------------------------------------
        *-- CAMPOS DA LINHA 1: Produto (Say1 + get_produto + getDpro)
        *-- Compensacao PageFrame +29: top=17->46, top=14->43
        *--------------------------------------------------------------------------

        *-- Label "Produto :" (Say1: top=17+29=46, left=199, width=47, height=15)
        par_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH par_oPagina.lbl_4c_Label1
            .Caption   = "Produto :"
            .Top       = 46
            .Left      = 199
            .Width     = 47
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo Produto (get_produto: top=14+29=43, left=251, width=108, height=23)
        *-- Lookup SigCdPro por cpros (quando INSERIR); readonly em outros modos
        par_oPagina.AddObject("txt_4c_Produto", "TextBox")
        WITH par_oPagina.txt_4c_Produto
            .Top       = 43
            .Left      = 251
            .Width     = 108
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- TextBox Descricao Produto (getDpro: top=14+29=43, left=361, width=360, height=23)
        *-- Lookup SigCdPro por dpros (quando INSERIR); readonly em outros modos
        par_oPagina.AddObject("txt_4c_Dpro", "TextBox")
        WITH par_oPagina.txt_4c_Dpro
            .Top       = 43
            .Left      = 361
            .Width     = 360
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Value     = ""
            .ReadOnly  = .F.
            .Visible   = .T.
        ENDWITH

        *--------------------------------------------------------------------------
        *-- CAMPOS DA LINHA 2: Grupo + Situacao
        *-- Compensacao PageFrame +29: top=44->73, top=40->69, top=38->67
        *--------------------------------------------------------------------------

        *-- Label "Grupo :" (Say8: top=44+29=73, left=208, width=38, height=15)
        par_oPagina.AddObject("lbl_4c_Label8", "Label")
        WITH par_oPagina.lbl_4c_Label8
            .Caption   = "Grupo :"
            .Top       = 73
            .Left      = 208
            .Width     = 38
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo Grupo (getCgru: top=40+29=69, left=251, width=31, height=23)
        *-- When=.F. -> sempre readonly (preenchido automaticamente pelo produto)
        par_oPagina.AddObject("txt_4c_Cgru", "TextBox")
        WITH par_oPagina.txt_4c_Cgru
            .Top       = 69
            .Left      = 251
            .Width     = 31
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Value     = ""
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Descricao Grupo (getDgru: top=40+29=69, left=284, width=150, height=23)
        *-- When=.F. -> sempre readonly
        par_oPagina.AddObject("txt_4c_Dgru", "TextBox")
        WITH par_oPagina.txt_4c_Dgru
            .Top       = 69
            .Left      = 284
            .Width     = 150
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Value     = ""
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Label "Situacao :" (Say19: top=44+29=73, left=456)
        par_oPagina.AddObject("lbl_4c_Label19", "Label")
        WITH par_oPagina.lbl_4c_Label19
            .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
            .Top       = 73
            .Left      = 456
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Situacao (Opc_situacao: top=38+29=67, left=504, width=117, height=25)
        *-- When=.F. -> sempre desabilitado (informativo)
        par_oPagina.AddObject("obj_4c_Opc_situacao", "OptionGroup")
        WITH par_oPagina.obj_4c_Opc_situacao
            .ButtonCount = 2
            .Width       = 117
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Enabled     = .F.
            .Visible     = .T.
            .Top         = 67
            .Left        = 504

            WITH .Buttons(1)
                .Caption   = "Ativa"
                .Left      = 5
                .Top       = 5
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "Inativa"
                .Left      = 63
                .Top       = 5
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
        ENDWITH

        *--------------------------------------------------------------------------
        *-- CAMPOS DA LINHA 3: Fornecedor
        *-- Compensacao PageFrame +29: top=69->98, top=66->95
        *--------------------------------------------------------------------------

        *-- Label "Fornecedor :" (Say11: top=69+29=98, left=182, width=64, height=15)
        par_oPagina.AddObject("lbl_4c_Label11", "Label")
        WITH par_oPagina.lbl_4c_Label11
            .Caption   = "Fornecedor :"
            .Top       = 98
            .Left      = 182
            .Width     = 64
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo Fornecedor (getIfor: top=66+29=95, left=251, width=80, height=23)
        *-- When=PROCURAR: habilitado apenas no modo busca (ReadOnly nos demais)
        par_oPagina.AddObject("txt_4c_Ifor", "TextBox")
        WITH par_oPagina.txt_4c_Ifor
            .Top       = 95
            .Left      = 251
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Value     = ""
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Nome Fornecedor (getDfor: top=66+29=95, left=333, width=290, height=23)
        *-- When=.F. -> sempre readonly
        par_oPagina.AddObject("txt_4c_Dfor", "TextBox")
        WITH par_oPagina.txt_4c_Dfor
            .Top       = 95
            .Left      = 333
            .Width     = 290
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Value     = ""
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *-- BINDEVENTs para botoes Confirmar / Cancelar
        BINDEVENT(par_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(par_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *--------------------------------------------------------------------------
        *-- LINHA 4: Referencia Fornecedor + Qtde Minima
        *-- Compensacao PageFrame +29: top=95->124, top=92->121
        *--------------------------------------------------------------------------

        *-- Label "Ref. Fornecedor :" (Say12: top=95+29=124, left=158, w=88, h=15)
        par_oPagina.AddObject("lbl_4c_Label12", "Label")
        WITH par_oPagina.lbl_4c_Label12
            .Caption   = "Ref. Fornecedor :"
            .Top       = 124
            .Left      = 158
            .Width     = 88
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Ref. Fornecedor (getRefs: top=92+29=121, left=251, w=150, h=23)
        *-- When=PROCURAR: apenas no modo busca; readonly nos demais modos
        par_oPagina.AddObject("txt_4c_Refs", "TextBox")
        WITH par_oPagina.txt_4c_Refs
            .Top       = 121
            .Left      = 251
            .Width     = 150
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Value     = ""
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Label "Qtde Minima :" (Say13: top=95+29=124, left=470, w=68, h=15)
        par_oPagina.AddObject("lbl_4c_Label13", "Label")
        WITH par_oPagina.lbl_4c_Label13
            .Caption   = "Qtde M" + CHR(237) + "nima :"
            .Top       = 124
            .Left      = 470
            .Width     = 68
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Qtde Minima (getQmin: top=92+29=121, left=543, w=80, h=23)
        *-- ReadOnly - calculado automaticamente pelo sistema
        par_oPagina.AddObject("txt_4c_Qmin", "TextBox")
        WITH par_oPagina.txt_4c_Qmin
            .Top       = 121
            .Left      = 543
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Value     = 0
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *--------------------------------------------------------------------------
        *-- Grid de itens (gradei: top=125+29=154, left=146, w=692, h=436, 8 colunas)
        *-- Colunas: emps, qmins, codtams, codcores, grupos, contas, locals, qideal
        *--------------------------------------------------------------------------
        par_oPagina.AddObject("grd_4c_GradeI", "Grid")
        WITH par_oPagina.grd_4c_GradeI
            .Top                = 154
            .Left               = 146
            .Width              = 692
            .Height             = 436
            .FontName           = "Verdana"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .GridLines          = 3
            .RowHeight          = 18
            .HeaderHeight       = 22
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .ScrollBars         = 3
            .HighlightStyle     = 2
            .HighlightBackColor = RGB(15, 41, 104)
            .HighlightForeColor = RGB(255, 255, 255)
            .AllowCellSelection = .T.
            .AllowHeaderSizing  = .F.
            .Visible            = .T.
        ENDWITH

        *-- ColumnCount FORA do WITH (Problem 36 - cria Text1 imediatamente)
        par_oPagina.grd_4c_GradeI.ColumnCount = 8

        *-- Configurar colunas (ControlSource sera setado em ConfigurarRecordSourceGrid)
        WITH par_oPagina.grd_4c_GradeI
            .Column1.Width            = 45
            .Column1.Header1.Caption  = "Emp"
            .Column1.Header1.Alignment = 2
            .Column1.ReadOnly         = .F.
            .Column1.Sparse           = .F.

            .Column2.Width            = 90
            .Column2.Header1.Caption  = "Qtde. M" + CHR(237) + "nima"
            .Column2.Header1.Alignment = 2
            .Column2.ReadOnly         = .F.
            .Column2.Sparse           = .F.

            .Column3.Width            = 70
            .Column3.Header1.Caption  = "Tamanho"
            .Column3.Header1.Alignment = 2
            .Column3.ReadOnly         = .F.
            .Column3.Sparse           = .F.

            .Column4.Width            = 55
            .Column4.Header1.Caption  = "Cor"
            .Column4.Header1.Alignment = 2
            .Column4.ReadOnly         = .F.
            .Column4.Sparse           = .F.

            .Column5.Width            = 85
            .Column5.Header1.Caption  = "Grupo"
            .Column5.Header1.Alignment = 2
            .Column5.ReadOnly         = .F.
            .Column5.Sparse           = .F.

            .Column6.Width            = 85
            .Column6.Header1.Caption  = "Conta"
            .Column6.Header1.Alignment = 2
            .Column6.ReadOnly         = .F.
            .Column6.Sparse           = .F.

            .Column7.Width            = 85
            .Column7.Header1.Caption  = "Local"
            .Column7.Header1.Alignment = 2
            .Column7.ReadOnly         = .F.
            .Column7.Sparse           = .F.

            .Column8.Width            = 90
            .Column8.Header1.Caption  = "Estoque Alvo"
            .Column8.Header1.Alignment = 2
            .Column8.ReadOnly         = .F.
            .Column8.Sparse           = .F.
        ENDWITH

        *-- BINDEVENTs do grid e suas colunas
        BINDEVENT(par_oPagina.grd_4c_GradeI, "AfterRowColChange", THIS, "GradeIAfterRowColChange")
        BINDEVENT(par_oPagina.grd_4c_GradeI.Column1.Text1, "KeyPress",  THIS, "EmpColKeyPress")
        BINDEVENT(par_oPagina.grd_4c_GradeI.Column1.Text1, "KeyPress", THIS, "EmpColLostFocus")
        BINDEVENT(par_oPagina.grd_4c_GradeI.Column2.Text1, "KeyPress", THIS, "QtdeColLostFocus")
        BINDEVENT(par_oPagina.grd_4c_GradeI.Column3.Text1, "KeyPress",  THIS, "TamanhoColKeyPress")
        BINDEVENT(par_oPagina.grd_4c_GradeI.Column3.Text1, "DblClick",  THIS, "TamanhoColDblClick")
        BINDEVENT(par_oPagina.grd_4c_GradeI.Column4.Text1, "KeyPress",  THIS, "CorColKeyPress")
        BINDEVENT(par_oPagina.grd_4c_GradeI.Column4.Text1, "DblClick",  THIS, "CorColDblClick")
        BINDEVENT(par_oPagina.grd_4c_GradeI.Column5.Text1, "KeyPress",  THIS, "GrupoColKeyPress")
        BINDEVENT(par_oPagina.grd_4c_GradeI.Column5.Text1, "DblClick",  THIS, "GrupoColDblClick")
        BINDEVENT(par_oPagina.grd_4c_GradeI.Column6.Text1, "KeyPress",  THIS, "ContaColKeyPress")
        BINDEVENT(par_oPagina.grd_4c_GradeI.Column6.Text1, "DblClick",  THIS, "ContaColDblClick")
        BINDEVENT(par_oPagina.grd_4c_GradeI.Column7.Text1, "KeyPress",  THIS, "LocalColKeyPress")
        BINDEVENT(par_oPagina.grd_4c_GradeI.Column7.Text1, "DblClick",  THIS, "LocalColDblClick")
        BINDEVENT(par_oPagina.grd_4c_GradeI.Column7.Text1, "KeyPress", THIS, "LocalColLostFocus")
        BINDEVENT(par_oPagina.grd_4c_GradeI.Column8.Text1, "KeyPress", THIS, "QIdealColLostFocus")

        *--------------------------------------------------------------------------
        *-- Botao Excluir linha do grid (btnExcluir: top=313+29=342, left=843, w=45, h=45)
        *-- Standalone com icone - usar Themes=.T. + DisabledPicture (Problem 29)
        *--------------------------------------------------------------------------
        par_oPagina.AddObject("cmd_4c_BtnExcluir", "CommandButton")
        WITH par_oPagina.cmd_4c_BtnExcluir
            .Caption         = ""
            .Top             = 342
            .Left            = 843
            .Width           = 45
            .Height          = 45
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 0
            .ToolTipText     = "Excluir linha"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Enabled         = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(par_oPagina.cmd_4c_BtnExcluir, "Click", THIS, "BtnExcluirLinhaClick")

        *--------------------------------------------------------------------------
        *-- PARTE INFERIOR: "Retiravel :" + OptionGroup optRetiras
        *-- Compensacao PageFrame +29: top=569->598, top=563->592
        *--------------------------------------------------------------------------

        *-- Label "Retiravel :" (Say2: top=569+29=598, left=156)
        par_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH par_oPagina.lbl_4c_Label2
            .Caption   = "Retir" + CHR(225) + "vel :"
            .Top       = 598
            .Left      = 156
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Retiravel (optRetiras: top=563+29=592, left=207, w=168, h=27, 3 botoes)
        *-- When=.F. no legado: display-only, atualizado via GradeIAfterRowColChange
        par_oPagina.AddObject("obj_4c_OptRetiras", "OptionGroup")
        WITH par_oPagina.obj_4c_OptRetiras
            .ButtonCount = 3
            .Width       = 168
            .Height      = 27
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Enabled     = .F.
            .Visible     = .T.
            .Top         = 592
            .Left        = 207

            WITH .Buttons(1)
                .Caption   = "Sim"
                .Left      = 5
                .Top       = 5
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Left      = 50
                .Top       = 5
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH

            WITH .Buttons(3)
                .Caption   = "Produto"
                .Left      = 100
                .Top       = 5
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
        ENDWITH

        *-- BINDEVENTs para lookup de produto (get_produto / getDpro) -- apenas em modo INSERIR
        BINDEVENT(par_oPagina.txt_4c_Produto, "KeyPress", THIS, "ProdutoCodKeyPress")
        BINDEVENT(par_oPagina.txt_4c_Produto, "DblClick", THIS, "ProdutoCodDblClick")
        BINDEVENT(par_oPagina.txt_4c_Dpro,    "KeyPress", THIS, "ProdutoDescKeyPress")
        BINDEVENT(par_oPagina.txt_4c_Dpro,    "DblClick", THIS, "ProdutoDescDblClick")

        THIS.TornarControlesVisiveis(par_oPagina)
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * Containers flutuantes que iniciam ocultos sao preservados (cnt_4c_Copia)
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_cNome

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                loc_cNome = UPPER(loc_oObjeto.Name)

                *-- Preservar containers flutuantes que devem iniciar ocultos
                IF INLIST(loc_cNome, "CNT_4C_COPIA")
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                *-- Trata PageFrame - itera Pages
                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    LOCAL loc_nP
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                *-- Recursao em containers
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * FormatarGridLista - Formata visual do grid da lista
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            *-- Limpar cursores do BO
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF

            IF USED("CrSigCdMin")
                USE IN CrSigCdMin
            ENDIF
            IF USED("CrProdutos")
                USE IN CrProdutos
            ENDIF
            IF USED("CsCabec")
                USE IN CsCabec
            ENDIF
            IF USED("CsCopia")
                USE IN CsCopia
            ENDIF

            loc_lResultado = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.Destroy")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Salva itens da grade e retorna para Page1
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        TRY
            LOCAL loc_cCPros, loc_lTemLinhas
            loc_cCPros     = ""
            loc_lTemLinhas = .F.

            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Produto", 5)
                loc_cCPros = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Produto.Value)
            ENDIF

            IF EMPTY(loc_cCPros)
                MsgAviso("Informe o produto antes de salvar.", "Salvar")
            ELSE
                IF USED("CrSigCdMin")
                    SELECT CrSigCdMin
                    SCAN FOR !DELETED()
                        IF !EMPTY(ALLTRIM(CrSigCdMin.emps))
                            loc_lTemLinhas = .T.
                            EXIT
                        ENDIF
                    ENDSCAN
                ENDIF

                IF !loc_lTemLinhas
                    MsgAviso("Inclua pelo menos um item na grade antes de salvar.", "Salvar")
                ELSE
                    THIS.FormParaBO()
                    IF THIS.this_oBusinessObject.Salvar()
                        MsgInfo("Registros salvos com sucesso.", "Salvar")
                        THIS.AlternarPagina(1)
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.BtnSalvarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela edicao e retorna para Page1
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        TRY
            THIS.AlternarPagina(1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.BtnCancelarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormParaBO - Sincroniza campos do form para o BO
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        TRY
            LOCAL loc_oPg2
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            THIS.this_oBusinessObject.this_cCPros = ALLTRIM(loc_oPg2.txt_4c_Produto.Value)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.FormParaBO")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BOParaForm - Popula campos do form a partir do BO (modos VISUALIZAR/ALTERAR)
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        TRY
            LOCAL loc_oPg2, loc_oBO
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            loc_oBO  = THIS.this_oBusinessObject

            loc_oPg2.txt_4c_Produto.Value = loc_oBO.this_cCPros
            loc_oPg2.txt_4c_Dpro.Value    = loc_oBO.this_cDPros
            loc_oPg2.txt_4c_Cgru.Value    = loc_oBO.this_cCGrus
            loc_oPg2.txt_4c_Dgru.Value    = loc_oBO.this_cDGrus
            loc_oPg2.txt_4c_Ifor.Value    = loc_oBO.this_cIFors
            loc_oPg2.txt_4c_Dfor.Value    = loc_oBO.this_cRClis
            loc_oPg2.txt_4c_Refs.Value    = loc_oBO.this_cReffs
            loc_oPg2.txt_4c_Qmin.Value    = loc_oBO.this_nQMins

            loc_oPg2.obj_4c_Opc_situacao.Value = IIF(loc_oBO.this_nSituas = 1, 1, 2)

            THIS.CarregarGrade(loc_oBO.this_cCPros)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.BOParaForm")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita campos conforme modo de edicao
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        TRY
            LOCAL loc_oPg2, loc_lProdutoEdit
            loc_oPg2         = THIS.pgf_4c_Paginas.Page2
            loc_lProdutoEdit = (THIS.this_cModoAtual = "INCLUIR")

            loc_oPg2.txt_4c_Produto.ReadOnly = !loc_lProdutoEdit
            loc_oPg2.txt_4c_Dpro.ReadOnly    = !loc_lProdutoEdit

            loc_oPg2.txt_4c_Cgru.ReadOnly = .T.
            loc_oPg2.txt_4c_Dgru.ReadOnly = .T.
            loc_oPg2.txt_4c_Ifor.ReadOnly = .T.
            loc_oPg2.txt_4c_Dfor.ReadOnly = .T.
            loc_oPg2.txt_4c_Refs.ReadOnly = .T.
            loc_oPg2.txt_4c_Qmin.ReadOnly = .T.

            loc_oPg2.grd_4c_GradeI.ReadOnly                = !par_lHabilitar
            loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = par_lHabilitar
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.HabilitarCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa todos os campos da Page2
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        TRY
            LOCAL loc_oPg2
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            loc_oPg2.txt_4c_Produto.Value = ""
            loc_oPg2.txt_4c_Dpro.Value    = ""
            loc_oPg2.txt_4c_Cgru.Value    = ""
            loc_oPg2.txt_4c_Dgru.Value    = ""
            loc_oPg2.txt_4c_Ifor.Value    = ""
            loc_oPg2.txt_4c_Dfor.Value    = ""
            loc_oPg2.txt_4c_Refs.Value    = ""
            loc_oPg2.txt_4c_Qmin.Value    = 0

            loc_oPg2.obj_4c_Opc_situacao.Value = 1
            loc_oPg2.obj_4c_OptRetiras.Value   = 1

            THIS.CriarCursorGridVazio("")
            THIS.ConfigurarRecordSourceGrid()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.LimparCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarGrade - Carrega itens do grid para o produto especificado
    *==========================================================================
    PROTECTED PROCEDURE CarregarGrade(par_cCPros)
        TRY
            THIS.pgf_4c_Paginas.Page2.grd_4c_GradeI.RecordSource = ""

            IF !THIS.this_oBusinessObject.BuscarItens(par_cCPros)
                THIS.CriarCursorGridVazio(par_cCPros)
            ENDIF

            THIS.ConfigurarRecordSourceGrid()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.CarregarGrade")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarRecordSourceGrid - Vincula CrSigCdMin ao grid e seta ControlSources
    * Deve ser chamado APOS qualquer mudanca no cursor (Problem 48)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarRecordSourceGrid()
        TRY
            LOCAL loc_oGrid, loc_oBO
            loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_GradeI
            loc_oBO   = THIS.this_oBusinessObject

            loc_oGrid.RecordSource = "CrSigCdMin"

            *-- ControlSources APOS RecordSource (Problem 48 - RecordSource reseta bindings)
            loc_oGrid.Column1.ControlSource = "CrSigCdMin.emps"
            loc_oGrid.Column2.ControlSource = "CrSigCdMin.qmins"
            loc_oGrid.Column3.ControlSource = "CrSigCdMin.codtams"
            loc_oGrid.Column4.ControlSource = "CrSigCdMin.codcores"
            loc_oGrid.Column5.ControlSource = "CrSigCdMin.grupos"
            loc_oGrid.Column6.ControlSource = "CrSigCdMin.contas"
            loc_oGrid.Column7.ControlSource = "CrSigCdMin.locals"
            loc_oGrid.Column8.ControlSource = "CrSigCdMin.qideal"

            *-- Resetar headers (RecordSource pode ter limpo as captions)
            loc_oGrid.Column1.Header1.Caption = "Emp"
            loc_oGrid.Column2.Header1.Caption = "Qtde. M" + CHR(237) + "nima"
            loc_oGrid.Column3.Header1.Caption = "Tamanho"
            loc_oGrid.Column4.Header1.Caption = "Cor"
            loc_oGrid.Column5.Header1.Caption = "Grupo"
            loc_oGrid.Column6.Header1.Caption = "Conta"
            loc_oGrid.Column7.Header1.Caption = "Local"
            loc_oGrid.Column8.Header1.Caption = "Estoque Alvo"

            *-- Habilitar/desabilitar colunas Tamanho e Cor conforme flags do produto
            loc_oGrid.Column3.ReadOnly = !loc_oBO.this_lTemTam
            loc_oGrid.Column4.ReadOnly = !loc_oBO.this_lTemCor

            loc_oGrid.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.ConfigurarRecordSourceGrid")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CriarCursorGridVazio - Cria cursor CrSigCdMin com estrutura completa e
    *                        uma linha em branco para entrada de dados
    *==========================================================================
    PROTECTED PROCEDURE CriarCursorGridVazio(par_cCPros)
        TRY
            IF USED("CrSigCdMin")
                USE IN CrSigCdMin
            ENDIF

            SET NULL ON
            CREATE CURSOR CrSigCdMin ( ;
                cpros    C(14), emps     C(3),   locals   C(10), ;
                qmins    N(8,2), codtams  C(4),   codcores C(4),  ;
                ordems   C(1),  cidchaves C(20),  contas   C(10), ;
                grupos   C(10), qideal   N(7,2),  retiras  N(1,0), ;
                pideal   N(7,3), pmins    N(7,3),  dpros    C(65), ;
                ifors    C(10), reffs    C(20),  cgrus    C(3),  ;
                situas   N(1,0), rclis    C(50),  dgrus    C(20))
            SET NULL OFF

            INSERT INTO CrSigCdMin ;
                (cpros,      emps, locals, qmins, codtams, codcores, ;
                 ordems,     cidchaves, contas, grupos, qideal, ;
                 retiras,    pideal, pmins) ;
                VALUES ;
                (par_cCPros, "",   "",    0,     "",      "",       ;
                 " ",        "",   "",    "",    0,       ;
                 1,          0,    0)

            GO TOP IN CrSigCdMin
        CATCH TO loc_oErro
            SET NULL OFF
            MsgErro(loc_oErro.Message, "FormEmn.CriarCursorGridVazio")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AdicionarLinhaGrid - Insere nova linha vazia no cursor do grid
    *==========================================================================
    PROTECTED PROCEDURE AdicionarLinhaGrid()
        IF !USED("CrSigCdMin")
            RETURN
        ENDIF

        TRY
            LOCAL loc_cCPros, loc_oGrid
            loc_cCPros = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Produto.Value)

            INSERT INTO CrSigCdMin ;
                (cpros,      emps, locals, qmins, codtams, codcores, ;
                 ordems,     cidchaves, contas, grupos, qideal, ;
                 retiras,    pideal, pmins) ;
                VALUES ;
                (loc_cCPros, "",   "",    0,     "",      "",       ;
                 " ",        "",   "",    "",    0,       ;
                 1,          0,    0)

            loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_GradeI
            SELECT CrSigCdMin
            GO BOTTOM
            loc_oGrid.Refresh()
            loc_oGrid.ActivateCell(RECCOUNT("CrSigCdMin"), 1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.AdicionarLinhaGrid")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarDadosProduto - Popula cabecalho ao selecionar produto novo
    *==========================================================================
    PROTECTED PROCEDURE CarregarDadosProduto(par_cCPros)
        IF EMPTY(ALLTRIM(par_cCPros))
            RETURN
        ENDIF

        LOCAL loc_cSQL, loc_nRes
        loc_cSQL = ""
        loc_nRes = 0

        TRY
            loc_cSQL = "SELECT a.cpros, a.dpros, a.cgrus, a.ifors, a.reffs, a.situas," + ;
                " b.rclis, g.dgrus" + ;
                " FROM SigCdPro a" + ;
                " LEFT JOIN SigCdCli b ON b.iclis = a.ifors" + ;
                " LEFT JOIN SigCdGrp g ON g.cgrus = a.cgrus" + ;
                " WHERE a.cpros = " + EscaparSQL(ALLTRIM(par_cCPros))

            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdDados")

            IF loc_nRes > 0 AND USED("cursor_4c_ProdDados") AND RECCOUNT("cursor_4c_ProdDados") > 0
                SELECT cursor_4c_ProdDados
                GO TOP

                LOCAL loc_oPg2, loc_oBO, loc_nSituas
                loc_oPg2    = THIS.pgf_4c_Paginas.Page2
                loc_oBO     = THIS.this_oBusinessObject
                loc_nSituas = TratarNulo(cursor_4c_ProdDados.situas, "N")

                loc_oPg2.txt_4c_Produto.Value = ALLTRIM(TratarNulo(cursor_4c_ProdDados.cpros, "C"))
                loc_oPg2.txt_4c_Dpro.Value    = ALLTRIM(TratarNulo(cursor_4c_ProdDados.dpros, "C"))
                loc_oPg2.txt_4c_Cgru.Value    = ALLTRIM(TratarNulo(cursor_4c_ProdDados.cgrus, "C"))
                loc_oPg2.txt_4c_Dgru.Value    = ALLTRIM(TratarNulo(cursor_4c_ProdDados.dgrus, "C"))
                loc_oPg2.txt_4c_Ifor.Value    = ALLTRIM(TratarNulo(cursor_4c_ProdDados.ifors, "C"))
                loc_oPg2.txt_4c_Dfor.Value    = ALLTRIM(TratarNulo(cursor_4c_ProdDados.rclis, "C"))
                loc_oPg2.txt_4c_Refs.Value    = ALLTRIM(TratarNulo(cursor_4c_ProdDados.reffs, "C"))
                loc_oPg2.obj_4c_Opc_situacao.Value = IIF(loc_nSituas = 1, 1, 2)

                loc_oBO.this_cCPros  = ALLTRIM(TratarNulo(cursor_4c_ProdDados.cpros, "C"))
                loc_oBO.this_cDPros  = ALLTRIM(TratarNulo(cursor_4c_ProdDados.dpros, "C"))
                loc_oBO.this_cCGrus  = ALLTRIM(TratarNulo(cursor_4c_ProdDados.cgrus, "C"))
                loc_oBO.this_cIFors  = ALLTRIM(TratarNulo(cursor_4c_ProdDados.ifors, "C"))
                loc_oBO.this_nSituas = loc_nSituas

                loc_oBO.BuscarFlags(ALLTRIM(par_cCPros))
                THIS.CriarCursorGridVazio(ALLTRIM(par_cCPros))
                THIS.ConfigurarRecordSourceGrid()
            ELSE
                MsgAviso("Produto n" + CHR(227) + "o encontrado: " + ALLTRIM(par_cCPros), "Produto")
                THIS.pgf_4c_Paginas.Page2.txt_4c_Produto.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.CarregarDadosProduto")
        ENDTRY

        IF USED("cursor_4c_ProdDados")
            USE IN cursor_4c_ProdDados
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirLookupProdutoCodigo - FormBuscaAuxiliar em SigCdPro por cpros
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupProdutoCodigo()
        LOCAL loc_oBusca, loc_cCPros, loc_cValorAtual
        loc_cCPros      = ""
        loc_cValorAtual = ""

        TRY
            loc_cValorAtual = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Produto.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPro", "cursor_4c_BuscaProd", "cpros", loc_cValorAtual, ;
                "Buscar Produto")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
                    loc_cCPros = ALLTRIM(cursor_4c_BuscaProd.cpros)
                ENDIF

                IF USED("cursor_4c_BuscaProd")
                    USE IN cursor_4c_BuscaProd
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF !EMPTY(loc_cCPros)
                THIS.CarregarDadosProduto(loc_cCPros)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.AbrirLookupProdutoCodigo")
        ENDTRY
    ENDPROC

    PROCEDURE ProdutoCodKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.this_cModoAtual = "INCLUIR" AND par_nKeyCode = 115
            THIS.AbrirLookupProdutoCodigo()
        ENDIF
    ENDPROC

    PROCEDURE ProdutoCodDblClick()
        IF THIS.this_cModoAtual = "INCLUIR"
            THIS.AbrirLookupProdutoCodigo()
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirLookupProdutoDescricao - FormBuscaAuxiliar em SigCdPro por dpros
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupProdutoDescricao()
        LOCAL loc_oBusca, loc_cCPros, loc_cValorAtual
        loc_cCPros      = ""
        loc_cValorAtual = ""

        TRY
            loc_cValorAtual = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Dpro.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPro", "cursor_4c_BuscaProdD", "dpros", loc_cValorAtual, ;
                "Buscar Produto")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProdD")
                    loc_cCPros = ALLTRIM(cursor_4c_BuscaProdD.cpros)
                ENDIF

                IF USED("cursor_4c_BuscaProdD")
                    USE IN cursor_4c_BuscaProdD
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF !EMPTY(loc_cCPros)
                THIS.CarregarDadosProduto(loc_cCPros)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.AbrirLookupProdutoDescricao")
        ENDTRY
    ENDPROC

    PROCEDURE ProdutoDescKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF THIS.this_cModoAtual = "INCLUIR" AND par_nKeyCode = 115
            THIS.AbrirLookupProdutoDescricao()
        ENDIF
    ENDPROC

    PROCEDURE ProdutoDescDblClick()
        IF THIS.this_cModoAtual = "INCLUIR"
            THIS.AbrirLookupProdutoDescricao()
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirLookupEmpresa - FormBuscaAuxiliar em SigCdEmp por Cemps
    * Substitui fAcessoEmpresa() (funcao do framework legado nao portada)
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupEmpresa()
        IF !USED("CrSigCdMin") OR EOF("CrSigCdMin")
            RETURN
        ENDIF

        LOCAL loc_oBusca, loc_cCemps, loc_cValorAtual
        loc_cCemps      = ""
        loc_cValorAtual = ""

        TRY
            loc_cValorAtual = ALLTRIM(CrSigCdMin.emps)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", "cursor_4c_BuscaEmp", "Cemps", loc_cValorAtual, ;
                "Buscar Empresa")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                    loc_cCemps = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                ENDIF

                IF USED("cursor_4c_BuscaEmp")
                    USE IN cursor_4c_BuscaEmp
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF !EMPTY(loc_cCemps)
                IF USED("CrSigCdMin") AND !EOF("CrSigCdMin")
                    REPLACE CrSigCdMin.emps WITH loc_cCemps
                    THIS.pgf_4c_Paginas.Page2.grd_4c_GradeI.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.AbrirLookupEmpresa")
        ENDTRY
    ENDPROC

    PROCEDURE EmpColKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupEmpresa()
        ENDIF
    ENDPROC

    PROCEDURE EmpColLostFocus(par_nKeyCode, par_nShiftAltCtrl)
    ENDPROC

    PROCEDURE QtdeColLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        TRY
            IF USED("CrSigCdMin") AND !EOF("CrSigCdMin")
                IF CrSigCdMin.qmins < 0
                    MsgAviso("Quantidade m" + CHR(237) + "nima n" + CHR(227) + "o pode ser negativa.", "Quantidade")
                    REPLACE CrSigCdMin.qmins WITH 0
                    THIS.pgf_4c_Paginas.Page2.grd_4c_GradeI.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.QtdeColLostFocus")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirLookupTamanho - FormBuscaAuxiliar em SigCdTam por cods/descs
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupTamanho()
        IF !USED("CrSigCdMin") OR EOF("CrSigCdMin")
            RETURN
        ENDIF

        LOCAL loc_oBusca, loc_cCods, loc_cValorAtual
        loc_cCods       = ""
        loc_cValorAtual = ""

        TRY
            loc_cValorAtual = ALLTRIM(CrSigCdMin.codtams)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdTam", "cursor_4c_BuscaTam", "cods", loc_cValorAtual, ;
                "Buscar Tamanho")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTam")
                    loc_cCods = ALLTRIM(cursor_4c_BuscaTam.cods)
                ENDIF

                IF USED("cursor_4c_BuscaTam")
                    USE IN cursor_4c_BuscaTam
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF !EMPTY(loc_cCods)
                IF USED("CrSigCdMin") AND !EOF("CrSigCdMin")
                    REPLACE CrSigCdMin.codtams WITH loc_cCods
                    THIS.pgf_4c_Paginas.Page2.grd_4c_GradeI.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.AbrirLookupTamanho")
        ENDTRY
    ENDPROC

    PROCEDURE TamanhoColKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupTamanho()
        ENDIF
    ENDPROC

    PROCEDURE TamanhoColDblClick()
        THIS.AbrirLookupTamanho()
    ENDPROC

    *==========================================================================
    * AbrirLookupCor - FormBuscaAuxiliar em SigCdCor por cods/descs
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupCor()
        IF !USED("CrSigCdMin") OR EOF("CrSigCdMin")
            RETURN
        ENDIF

        LOCAL loc_oBusca, loc_cCods, loc_cValorAtual
        loc_cCods       = ""
        loc_cValorAtual = ""

        TRY
            loc_cValorAtual = ALLTRIM(CrSigCdMin.codcores)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCor", "cursor_4c_BuscaCor", "cods", loc_cValorAtual, ;
                "Buscar Cor")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCor")
                    loc_cCods = ALLTRIM(cursor_4c_BuscaCor.cods)
                ENDIF

                IF USED("cursor_4c_BuscaCor")
                    USE IN cursor_4c_BuscaCor
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF !EMPTY(loc_cCods)
                IF USED("CrSigCdMin") AND !EOF("CrSigCdMin")
                    REPLACE CrSigCdMin.codcores WITH loc_cCods
                    THIS.pgf_4c_Paginas.Page2.grd_4c_GradeI.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.AbrirLookupCor")
        ENDTRY
    ENDPROC

    PROCEDURE CorColKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupCor()
        ENDIF
    ENDPROC

    PROCEDURE CorColDblClick()
        THIS.AbrirLookupCor()
    ENDPROC

    *==========================================================================
    * AbrirLookupGrupo - FormBuscaAuxiliar em SigCdGcr por Codigos/Descrs
    * Substitui fAcessoContab() (funcao do framework legado nao portada)
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupGrupo()
        IF !USED("CrSigCdMin") OR EOF("CrSigCdMin")
            RETURN
        ENDIF

        LOCAL loc_oBusca, loc_cCodigos, loc_cValorAtual
        loc_cCodigos    = ""
        loc_cValorAtual = ""

        TRY
            loc_cValorAtual = ALLTRIM(CrSigCdMin.grupos)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGrp", "Codigos", loc_cValorAtual, ;
                "Buscar Grupo")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
                    loc_cCodigos = ALLTRIM(cursor_4c_BuscaGrp.Codigos)
                ENDIF

                IF USED("cursor_4c_BuscaGrp")
                    USE IN cursor_4c_BuscaGrp
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF !EMPTY(loc_cCodigos)
                IF USED("CrSigCdMin") AND !EOF("CrSigCdMin")
                    REPLACE CrSigCdMin.grupos WITH loc_cCodigos
                    THIS.pgf_4c_Paginas.Page2.grd_4c_GradeI.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.AbrirLookupGrupo")
        ENDTRY
    ENDPROC

    PROCEDURE GrupoColKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupGrupo()
        ENDIF
    ENDPROC

    PROCEDURE GrupoColDblClick()
        THIS.AbrirLookupGrupo()
    ENDPROC

    *==========================================================================
    * AbrirLookupConta - FormBuscaAuxiliar em SigCdCli por iclis/rclis
    * Substitui fAcessoContas() (funcao do framework legado nao portada)
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupConta()
        IF !USED("CrSigCdMin") OR EOF("CrSigCdMin")
            RETURN
        ENDIF

        LOCAL loc_oBusca, loc_cIclis, loc_cValorAtual
        loc_cIclis      = ""
        loc_cValorAtual = ""

        TRY
            loc_cValorAtual = ALLTRIM(CrSigCdMin.contas)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaCli", "iclis", loc_cValorAtual, ;
                "Buscar Conta")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("rclis", "", "Raz" + CHR(227) + "o Social")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
                    loc_cIclis = ALLTRIM(cursor_4c_BuscaCli.iclis)
                ENDIF

                IF USED("cursor_4c_BuscaCli")
                    USE IN cursor_4c_BuscaCli
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF !EMPTY(loc_cIclis)
                IF USED("CrSigCdMin") AND !EOF("CrSigCdMin")
                    REPLACE CrSigCdMin.contas WITH loc_cIclis
                    THIS.pgf_4c_Paginas.Page2.grd_4c_GradeI.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.AbrirLookupConta")
        ENDTRY
    ENDPROC

    PROCEDURE ContaColKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupConta()
        ENDIF
    ENDPROC

    PROCEDURE ContaColDblClick()
        THIS.AbrirLookupConta()
    ENDPROC

    *==========================================================================
    * AbrirLookupLocal - FormBuscaAuxiliar em SigPrLcl (filtro Tipos=3)
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupLocal()
        IF !USED("CrSigCdMin") OR EOF("CrSigCdMin")
            RETURN
        ENDIF

        LOCAL loc_oBusca, loc_cCodigos, loc_cValorAtual
        loc_cCodigos    = ""
        loc_cValorAtual = ""

        TRY
            loc_cValorAtual = ALLTRIM(CrSigCdMin.locals)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigPrLcl", "cursor_4c_BuscaLcl", "Codigos", loc_cValorAtual, ;
                "Buscar Local", .F., .T., "Tipos = 3")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLcl")
                    loc_cCodigos = ALLTRIM(cursor_4c_BuscaLcl.Codigos)
                ENDIF

                IF USED("cursor_4c_BuscaLcl")
                    USE IN cursor_4c_BuscaLcl
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF !EMPTY(loc_cCodigos)
                IF USED("CrSigCdMin") AND !EOF("CrSigCdMin")
                    REPLACE CrSigCdMin.locals WITH loc_cCodigos
                    THIS.pgf_4c_Paginas.Page2.grd_4c_GradeI.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.AbrirLookupLocal")
        ENDTRY
    ENDPROC

    PROCEDURE LocalColKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupLocal()
        ENDIF
    ENDPROC

    PROCEDURE LocalColDblClick()
        THIS.AbrirLookupLocal()
    ENDPROC

    PROCEDURE LocalColLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        IF !USED("CrSigCdMin") OR EOF("CrSigCdMin")
            RETURN
        ENDIF

        TRY
            IF !EMPTY(ALLTRIM(CrSigCdMin.emps)) AND !EMPTY(ALLTRIM(CrSigCdMin.locals))
                LOCAL loc_lTemVazia
                loc_lTemVazia = .F.

                SELECT CrSigCdMin
                SCAN FOR !DELETED()
                    IF EMPTY(ALLTRIM(CrSigCdMin.emps))
                        loc_lTemVazia = .T.
                        EXIT
                    ENDIF
                ENDSCAN

                IF !loc_lTemVazia
                    THIS.AdicionarLinhaGrid()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.LocalColLostFocus")
        ENDTRY
    ENDPROC

    PROCEDURE QIdealColLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        TRY
            IF USED("CrSigCdMin") AND !EOF("CrSigCdMin")
                IF CrSigCdMin.qideal < 0
                    MsgAviso("Estoque Alvo n" + CHR(227) + "o pode ser negativo.", "Estoque Alvo")
                    REPLACE CrSigCdMin.qideal WITH 0
                    THIS.pgf_4c_Paginas.Page2.grd_4c_GradeI.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.QIdealColLostFocus")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GradeIAfterRowColChange - Atualiza flags de coluna e OptRetiras ao mudar linha
    *==========================================================================
    PROCEDURE GradeIAfterRowColChange(par_nColIndex)

        IF !USED("CrSigCdMin") OR EOF("CrSigCdMin")
            RETURN
        ENDIF

        TRY
            LOCAL loc_oGrid, loc_oPg2, loc_oBO, loc_nRetiras
            loc_oBO   = THIS.this_oBusinessObject
            loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_GradeI
            loc_oPg2  = THIS.pgf_4c_Paginas.Page2

            *-- Manter ReadOnly de Tamanho/Cor conforme flags do produto
            loc_oGrid.Column3.ReadOnly = !loc_oBO.this_lTemTam
            loc_oGrid.Column4.ReadOnly = !loc_oBO.this_lTemCor

            *-- Sincronizar OptionGroup Retiravel com linha corrente
            loc_nRetiras = TratarNulo(CrSigCdMin.retiras, "N")
            IF loc_nRetiras < 1 OR loc_nRetiras > 3
                loc_nRetiras = 3
            ENDIF
            loc_oPg2.obj_4c_OptRetiras.Value = loc_nRetiras

            *-- Habilitar excluir linha apenas se empresa preenchida e modo edicao
            loc_oPg2.cmd_4c_BtnExcluir.Enabled = ;
                (!EMPTY(ALLTRIM(CrSigCdMin.emps)) AND THIS.this_cModoAtual <> "VISUALIZAR")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.GradeIAfterRowColChange")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        TRY
            LOCAL loc_oPg1, loc_oPg2, loc_lEdicao
            loc_oPg1    = THIS.pgf_4c_Paginas.Page1
            loc_oPg2    = THIS.pgf_4c_Paginas.Page2
            loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

            loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = .T.
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = .T.
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = .T.
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = .T.
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = .T.

            loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = loc_lEdicao
            loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
            loc_oPg2.cmd_4c_BtnExcluir.Visible             = loc_lEdicao

            THIS.HabilitarCampos(loc_lEdicao)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirLinhaClick - Exclui a linha corrente do cursor CrSigCdMin
    *==========================================================================
    PROCEDURE BtnExcluirLinhaClick()
        IF !USED("CrSigCdMin") OR EOF("CrSigCdMin")
            RETURN
        ENDIF
        IF EMPTY(ALLTRIM(CrSigCdMin.emps))
            RETURN
        ENDIF

        TRY
            LOCAL loc_lConfirma
            loc_lConfirma = MsgConfirma("Excluir esta linha da grade?", "Excluir Linha")

            IF loc_lConfirma
                SELECT CrSigCdMin
                DELETE
                PACK
                THIS.ConfigurarRecordSourceGrid()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormEmn.BtnExcluirLinhaClick")
        ENDTRY
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\EmnBO.prg):
*==============================================================================
* EmnBO.prg - Business Object para Estoque Alvo (Minimo por Produto/Empresa)
* Tabela: SigCdMin
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS EmnBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades do cabecalho do produto (SigCdPro + lookups)
    *--------------------------------------------------------------------------
    this_cCPros     = ""    && Codigo do produto          char(14)
    this_cDPros     = ""    && Descricao do produto
    this_cCGrus     = ""    && Codigo do grupo do produto
    this_cDGrus     = ""    && Descricao do grupo do produto
    this_cIFors     = ""    && Codigo do fornecedor
    this_cRClis     = ""    && Razao social do fornecedor
    this_cReffs     = ""    && Referencia do fornecedor
    this_nQMins     = 0     && Quantidade minima geral   numeric(8,2)
    this_nSituas    = 1     && Situacao: 1=Ativo, 2=Inativo

    *--------------------------------------------------------------------------
    * Propriedades de um item do grid (linha de SigCdMin)
    *--------------------------------------------------------------------------
    this_cCidChaves = ""    && Chave unica / PRIMARY KEY  char(20)
    this_cEmps      = ""    && Empresa                    char(3)
    this_cLocals    = ""    && Local                      char(10)
    this_nQMinsItem = 0     && Quantidade minima          numeric(8,2)
    this_cCodTams   = ""    && Codigo do tamanho          char(4)
    this_cCodCores  = ""    && Codigo da cor              char(4)
    this_cOrdems    = ""    && Ordem                      char(1)
    this_cContas    = ""    && Conta                      char(10)
    this_cGrupos    = ""    && Grupo                      char(10)
    this_nQIdeal    = 0     && Quantidade ideal            numeric(7,2)
    this_nRetiras   = 1     && Retiravel: 1=Sim, 2=Nao, 3=Produto  numeric(1,0)
    this_nPIdeal    = 0     && Preco ideal                numeric(7,3)
    this_nPMins     = 0     && Preco minimo               numeric(7,3)

    *--------------------------------------------------------------------------
    * Flags de produto (determinam habilitacao de colunas na grade)
    *--------------------------------------------------------------------------
    this_lTemCor    = .F.   && Produto tem variacoes de cor
    this_lTemTam    = .F.   && Produto tem variacoes de tamanho
    this_nTipoEstos = 0     && Tipo de estoque do grupo do produto

    *--------------------------------------------------------------------------
    * Controle de modo externo (form chamado por outro form)
    *--------------------------------------------------------------------------
    this_cProdutoExterno = ""   && Codigo do produto fixado externamente
    this_cModoExterno    = ""   && Modo de operacao externo (INSERIR/ALTERAR)

    *--------------------------------------------------------------------------
    * Cursor principal do grid (preserva nome legado para compatibilidade)
    *--------------------------------------------------------------------------
    this_cCursorGrid  = "CrSigCdMin"   && Cursor do grid de minimos por empresa
    this_cCursorLista = "CrProdutos"   && Cursor da lista de produtos (Page1)

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdMin"
            THIS.this_cCampoChave = "cidchaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    FUNCTION ObterChavePrimaria()
    *==========================================================================
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *==========================================================================
    * GerarChaveUnica - Gera cidchaves unico usando NEWID() do SQL Server
    *==========================================================================
    FUNCTION GerarChaveUnica()
        LOCAL loc_cChave, loc_nRes
        loc_cChave = ""

        TRY
            loc_nRes = SQLEXEC(gnConnHandle, ;
                "SELECT LEFT(REPLACE(CONVERT(varchar(36),NEWID()),'-',''),20) AS id", ;
                "cursor_4c_NewId")
            IF loc_nRes > 0 AND USED("cursor_4c_NewId") AND RECCOUNT("cursor_4c_NewId") > 0
                SELECT cursor_4c_NewId
                GO TOP
                loc_cChave = ALLTRIM(cursor_4c_NewId.id)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.GerarChaveUnica")
        ENDTRY

        IF USED("cursor_4c_NewId")
            USE IN cursor_4c_NewId
        ENDIF

        IF EMPTY(loc_cChave)
            loc_cChave = LEFT(DTOS(DATE()) + STRTRAN(TRANSFORM(SECONDS()), ".", "") + SYS(2015), 20)
        ENDIF

        RETURN loc_cChave
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades a partir de um cursor de SigCdMin
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor) AND RECCOUNT(par_cAliasCursor) > 0
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
                THIS.this_cCPros     = TratarNulo(cpros,     "C")
                THIS.this_cEmps      = TratarNulo(emps,      "C")
                THIS.this_cLocals    = TratarNulo(locals,    "C")
                THIS.this_nQMinsItem = TratarNulo(qmins,     "N")
                THIS.this_cCodTams   = TratarNulo(codtams,   "C")
                THIS.this_cCodCores  = TratarNulo(codcores,  "C")
                THIS.this_cOrdems    = TratarNulo(ordems,    "C")
                THIS.this_cContas    = TratarNulo(contas,    "C")
                THIS.this_cGrupos    = TratarNulo(grupos,    "C")
                THIS.this_nQIdeal    = TratarNulo(qideal,    "N")
                THIS.this_nRetiras   = TratarNulo(retiras,   "N")
                THIS.this_nPIdeal    = TratarNulo(pideal,    "N")
                THIS.this_nPMins     = TratarNulo(pmins,     "N")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Buscar - Lista produtos que possuem estoque alvo configurado
    *          Retorna cursor CrProdutos para a grade da Page1
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nRes
        loc_lResultado = .F.

        IF USED("CrProdutos")
            USE IN CrProdutos
        ENDIF

        TRY
            loc_cSQL = "SELECT a.cpros, b.dpros, b.ifors, b.reffs, b.sgrus" + ;
                " FROM SigCdMin a" + ;
                " INNER JOIN SigCdPro b ON b.cpros = a.cpros"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE a.cpros = " + EscaparSQL(ALLTRIM(par_cFiltro))
            ENDIF

            loc_cSQL = loc_cSQL + " GROUP BY a.cpros, b.dpros, b.ifors, b.reffs, b.sgrus"

            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "CrProdutos")

            IF loc_nRes > 0
                SELECT CrProdutos
                GO TOP
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar produtos: " + CapturarErroSQL(), "EmnBO.Buscar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.Buscar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BuscarItens - Carrega grid de itens para um produto especifico
    *               Retorna cursor CrSigCdMin (com colunas do JOIN)
    *               Tambem cria CsCabec e seta flags lTemCor/lTemTam
    *==========================================================================
    PROCEDURE BuscarItens(par_cCPros)
        LOCAL loc_lResultado, loc_cSQL, loc_nRes
        loc_lResultado = .F.

        IF USED("CrSigCdMin")
            USE IN CrSigCdMin
        ENDIF
        IF USED("CsCabec")
            USE IN CsCabec
        ENDIF

        TRY
            loc_cSQL = "SELECT a.cpros, a.emps, a.locals, a.qmins, a.codtams, a.codcores," + ;
                " a.ordems, a.cidchaves, a.contas, a.grupos, a.qideal, a.retiras," + ;
                " a.pideal, a.pmins," + ;
                " b.dpros, b.ifors, b.reffs, b.cgrus, b.situas, c.rclis, g.dgrus" + ;
                " FROM SigCdMin a" + ;
                " INNER JOIN SigCdPro b ON b.cpros = a.cpros" + ;
                " LEFT JOIN SigCdCli c ON c.iclis = b.ifors" + ;
                " LEFT JOIN SigCdGrp g ON g.cgrus = b.cgrus" + ;
                " WHERE a.cpros = " + EscaparSQL(ALLTRIM(par_cCPros)) + ;
                " ORDER BY a.emps, a.codtams, a.codcores"

            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigCdMin")

            IF loc_nRes > 0
                SELECT CrSigCdMin
                GO TOP

                *-- Criar CsCabec com dados de cabecalho do produto
                THIS.CarregarCabecalho()

                *-- Atualizar flags de cor/tamanho
                THIS.BuscarFlags(par_cCPros)

                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar itens do produto: " + CapturarErroSQL(), "EmnBO.BuscarItens")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.BuscarItens")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BuscarFlags - Carrega flags lTemCor/lTemTam de SigCdPro x SigCdGrp
    *==========================================================================
    PROCEDURE BuscarFlags(par_cCPros)
        LOCAL loc_lResultado, loc_cSQL, loc_nRes
        loc_lResultado = .F.

        THIS.this_lTemCor    = .F.
        THIS.this_lTemTam    = .F.
        THIS.this_nTipoEstos = 0

        IF EMPTY(ALLTRIM(par_cCPros))
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT b.cores, b.tams, b.tipoestos" + ;
                " FROM SigCdPro a" + ;
                " INNER JOIN SigCdGrp b ON b.cgrus = a.cgrus" + ;
                " WHERE a.cpros = " + EscaparSQL(ALLTRIM(par_cCPros))

            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Flags")

            IF loc_nRes > 0 AND USED("cursor_4c_Flags") AND RECCOUNT("cursor_4c_Flags") > 0
                SELECT cursor_4c_Flags
                GO TOP
                THIS.this_nTipoEstos = TratarNulo(tipoestos, "N")
                THIS.this_lTemCor    = INLIST(THIS.this_nTipoEstos, 2, 4) OR (TratarNulo(cores, "N") = 1)
                THIS.this_lTemTam    = INLIST(THIS.this_nTipoEstos, 3, 4) OR (TratarNulo(tams,  "N") = 1)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.BuscarFlags")
        ENDTRY

        IF USED("cursor_4c_Flags")
            USE IN cursor_4c_Flags
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarCabecalho - Cria cursor CsCabec com dados de cabecalho do produto
    *                     a partir do CrSigCdMin ja carregado
    *==========================================================================
    PROTECTED PROCEDURE CarregarCabecalho()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED("CsCabec")
            USE IN CsCabec
        ENDIF

        TRY
            IF USED("CrSigCdMin") AND RECCOUNT("CrSigCdMin") > 0
                SELECT DISTINCT cpros, dpros, cgrus, dgrus, ifors, rclis, reffs, qmins, qideal, situas ;
                    FROM CrSigCdMin ;
                    INTO CURSOR CsCabec READWRITE
                GO TOP IN CsCabec
            ELSE
                CREATE CURSOR CsCabec ( ;
                    cpros    C(14), dpros C(65), cgrus  C(3), ;
                    dgrus    C(20), ifors C(10), rclis  C(50), ;
                    reffs    C(20), qmins N(8,2), qideal N(7,2), ;
                    situas   N(1,0))
                INSERT INTO CsCabec (cpros, dpros, cgrus, dgrus, ifors, rclis, reffs, qmins, qideal, situas) ;
                    VALUES (SPACE(14), SPACE(65), SPACE(3), SPACE(20), SPACE(10), SPACE(50), SPACE(20), 0, 0, 1)
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.CarregarCabecalho")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega propriedades de cabecalho para um produto
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCPros)
        LOCAL loc_lResultado, loc_cSQL, loc_nRes
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cCPros))
                loc_lResultado = .F.
            ENDIF

            loc_cSQL = "SELECT a.cpros, b.dpros, b.ifors, b.reffs, b.cgrus, b.situas," + ;
                " c.rclis, g.dgrus, a.qmins, a.qideal" + ;
                " FROM SigCdMin a" + ;
                " INNER JOIN SigCdPro b ON b.cpros = a.cpros" + ;
                " LEFT JOIN SigCdCli c ON c.iclis = b.ifors" + ;
                " LEFT JOIN SigCdGrp g ON g.cgrus = b.cgrus" + ;
                " WHERE a.cpros = " + EscaparSQL(ALLTRIM(par_cCPros)) + ;
                " GROUP BY a.cpros, b.dpros, b.ifors, b.reffs, b.cgrus, b.situas, c.rclis, g.dgrus, a.qmins, a.qideal"

            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cabec")

            IF loc_nRes > 0 AND USED("cursor_4c_Cabec") AND RECCOUNT("cursor_4c_Cabec") > 0
                SELECT cursor_4c_Cabec
                GO TOP
                THIS.this_cCPros    = ALLTRIM(TratarNulo(cpros,  "C"))
                THIS.this_cDPros    = ALLTRIM(TratarNulo(dpros,  "C"))
                THIS.this_cIFors    = ALLTRIM(TratarNulo(ifors,  "C"))
                THIS.this_cReffs    = ALLTRIM(TratarNulo(reffs,  "C"))
                THIS.this_cCGrus    = ALLTRIM(TratarNulo(cgrus,  "C"))
                THIS.this_nSituas   = TratarNulo(situas, "N")
                THIS.this_cRClis    = ALLTRIM(TratarNulo(rclis,  "C"))
                THIS.this_cDGrus    = ALLTRIM(TratarNulo(dgrus,  "C"))
                THIS.this_nQMins    = TratarNulo(qmins,  "N")
                THIS.this_nQIdeal   = TratarNulo(qideal, "N")
                THIS.this_lNovoRegistro = .F.
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.CarregarPorCodigo")
        ENDTRY

        IF USED("cursor_4c_Cabec")
            USE IN cursor_4c_Cabec
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * SalvarGrid - Salva todos os itens do grid no SQL Server
    *              Estrategia: DELETE todos os itens do produto, INSERT novos
    *              Apenas linhas com emps preenchido sao salvas
    *==========================================================================
    PROTECTED PROCEDURE SalvarGrid(par_cCPros)
        LOCAL loc_lResultado, loc_nRes, loc_lTransacao
        LOCAL loc_cSQL, loc_cCidChaves
        loc_lResultado = .F.
        loc_lTransacao = .F.

        IF EMPTY(ALLTRIM(par_cCPros))
            MsgAviso("C" + CHR(243) + "digo do produto inv" + CHR(225) + "lido para SalvarGrid.")
            RETURN .F.
        ENDIF

        IF !USED("CrSigCdMin")
            MsgErro("Cursor CrSigCdMin n" + CHR(227) + "o encontrado.", "EmnBO.SalvarGrid")
            RETURN .F.
        ENDIF

        TRY
            *-- Iniciar transacao
            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
            loc_lTransacao = .T.

            *-- Deletar todos os registros existentes para este produto
            loc_nRes = SQLEXEC(gnConnHandle, ;
                "DELETE FROM SigCdMin WHERE cpros = " + EscaparSQL(ALLTRIM(par_cCPros)), ;
                "cursor_4c_Del")
            IF USED("cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF

            IF loc_nRes < 0
                MsgErro("Erro ao excluir registros antigos: " + CapturarErroSQL(), "EmnBO.SalvarGrid")
            ELSE
                *-- Inserir linhas validas do cursor local
                loc_lResultado = .T.
                SELECT CrSigCdMin
                GO TOP

                SCAN FOR !DELETED()
                    IF !EMPTY(ALLTRIM(CrSigCdMin.emps))
                        *-- Gerar cidchaves se necessario
                        loc_cCidChaves = ALLTRIM(CrSigCdMin.cidchaves)
                        IF EMPTY(loc_cCidChaves)
                            loc_cCidChaves = THIS.GerarChaveUnica()
                        ENDIF

                        loc_cSQL = "INSERT INTO SigCdMin" + ;
                            " (cpros, emps, locals, qmins, codtams, codcores," + ;
                            " ordems, cidchaves, contas, grupos, qideal, retiras, pideal, pmins)" + ;
                            " VALUES (" + ;
                            EscaparSQL(ALLTRIM(CrSigCdMin.cpros))    + ", " + ;
                            EscaparSQL(ALLTRIM(CrSigCdMin.emps))     + ", " + ;
                            EscaparSQL(LEFT(ALLTRIM(CrSigCdMin.locals),   10)) + ", " + ;
                            FormatarNumeroSQL(CrSigCdMin.qmins)      + ", " + ;
                            EscaparSQL(LEFT(ALLTRIM(CrSigCdMin.codtams),   4)) + ", " + ;
                            EscaparSQL(LEFT(ALLTRIM(CrSigCdMin.codcores),  4)) + ", " + ;
                            EscaparSQL(LEFT(ALLTRIM(CrSigCdMin.ordems),    1)) + ", " + ;
                            EscaparSQL(LEFT(loc_cCidChaves,               20)) + ", " + ;
                            EscaparSQL(LEFT(ALLTRIM(CrSigCdMin.contas),   10)) + ", " + ;
                            EscaparSQL(LEFT(ALLTRIM(CrSigCdMin.grupos),   10)) + ", " + ;
                            FormatarNumeroSQL(CrSigCdMin.qideal)     + ", " + ;
                            FormatarNumeroSQL(CrSigCdMin.retiras)    + ", " + ;
                            FormatarNumeroSQL(CrSigCdMin.pideal)     + ", " + ;
                            FormatarNumeroSQL(CrSigCdMin.pmins)      + ;
                            ")"

                        loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
                        IF USED("cursor_4c_Ins")
                            USE IN cursor_4c_Ins
                        ENDIF

                        IF loc_nRes < 0
                            MsgErro("Erro ao inserir item: " + CapturarErroSQL(), "EmnBO.SalvarGrid")
                            loc_lResultado = .F.
                            EXIT
                        ENDIF
                    ENDIF
                ENDSCAN

                IF loc_lResultado
                    SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                    loc_lTransacao = .F.
                    THIS.RegistrarAuditoria("SAVE")
                ELSE
                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                    loc_lTransacao = .F.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " | Linha: " + TRANSFORM(loc_oErro.LineNo), "EmnBO.SalvarGrid")
            loc_lResultado = .F.
        ENDTRY

        IF loc_lTransacao
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Inserir - Chamado pelo BusinessBase.Salvar() para novo produto
    *           Delega para SalvarGrid
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = THIS.SalvarGrid(THIS.this_cCPros)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.Inserir")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Atualizar - Chamado pelo BusinessBase.Salvar() para produto existente
    *             Delega para SalvarGrid
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = THIS.SalvarGrid(THIS.this_cCPros)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.Atualizar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Exclui TODOS os itens SigCdMin de um produto
    *                    Chamado via BusinessBase.Excluir()
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nRes
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCPros))
                MsgAviso("C" + CHR(243) + "digo do produto inv" + CHR(225) + "lido.")
            ELSE
                loc_cSQL = "DELETE FROM SigCdMin WHERE cpros = " + EscaparSQL(ALLTRIM(THIS.this_cCPros))
                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Exc")

                IF USED("cursor_4c_Exc")
                    USE IN cursor_4c_Exc
                ENDIF

                IF loc_nRes >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao excluir: " + CapturarErroSQL(), "EmnBO.ExecutarExclusao")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ProcessarCopia - Cria cursor CsCopia com comparacao de itens entre empresas
    *                  Cores Vermelho(0/naoexiste-dest) Preto(0/existe) Azul(2/naoexiste-orig)
    *==========================================================================
    PROCEDURE ProcessarCopia(par_cEmpO, par_cEmpD, par_cCPros)
        LOCAL loc_lResultado, loc_cSQL, loc_nRes
        LOCAL loc_cFiltroO, loc_cFiltroD, loc_cFiltroProd
        loc_lResultado = .F.

        IF USED("CsCopia")
            USE IN CsCopia
        ENDIF

        TRY
            IF EMPTY(ALLTRIM(par_cEmpO)) OR EMPTY(ALLTRIM(par_cEmpD))
                MsgErro("Empresas Origem e Destino s" + CHR(227) + "o obrigat" + CHR(243) + "rias.", "EmnBO.ProcessarCopia")
            ELSE
                loc_cFiltroO   = EscaparSQL(PADR(ALLTRIM(par_cEmpO), 3))
                loc_cFiltroD   = EscaparSQL(PADR(ALLTRIM(par_cEmpD), 3))
                loc_cFiltroProd = ""
                IF !EMPTY(ALLTRIM(par_cCPros))
                    loc_cFiltroProd = " AND a.cpros = " + EscaparSQL(PADR(ALLTRIM(par_cCPros), 14))
                ENDIF

                *-- Itens que existem na Origem mas NAO no Destino (marcas=1, existes=0)
                loc_cSQL = "SELECT CAST(1 AS int) AS marcas, CAST(0 AS int) AS existes," + ;
                    " a.cpros, a.emps, a.locals, a.qmins, a.qideal, a.codtams, a.codcores," + ;
                    " a.cidchaves, a.grupos, a.contas" + ;
                    " FROM SigCdMin a" + ;
                    " WHERE a.emps = " + loc_cFiltroO + loc_cFiltroProd + ;
                    " AND (a.cpros + a.codtams + a.codcores) NOT IN" + ;
                    " (SELECT b.cpros + b.codtams + b.codcores FROM SigCdMin b WHERE b.emps = " + loc_cFiltroD + ")" + ;
                    " UNION ALL" + ;
                    " SELECT CAST(0 AS int) AS marcas, CAST(1 AS int) AS existes," + ;
                    " a.cpros, a.emps, a.locals, a.qmins, a.qideal, a.codtams, a.codcores," + ;
                    " a.cidchaves, a.grupos, a.contas" + ;
                    " FROM SigCdMin a" + ;
                    " WHERE a.emps = " + loc_cFiltroO + loc_cFiltroProd + ;
                    " AND a.cpros + a.codtams + a.codcores IN" + ;
                    " (SELECT b.cpros + b.codtams + b.codcores FROM SigCdMin b WHERE b.emps = " + loc_cFiltroD + ")" + ;
                    " UNION ALL" + ;
                    " SELECT CAST(0 AS int) AS marcas, CAST(2 AS int) AS existes," + ;
                    " a.cpros, a.emps, a.locals, a.qmins, a.qideal, a.codtams, a.codcores," + ;
                    " a.cidchaves, a.grupos, a.contas" + ;
                    " FROM SigCdMin a" + ;
                    " WHERE a.emps = " + loc_cFiltroD + loc_cFiltroProd + ;
                    " AND a.cpros + a.codtams + a.codcores NOT IN" + ;
                    " (SELECT b.cpros + b.codtams + b.codcores FROM SigCdMin b WHERE b.emps = " + loc_cFiltroO + ")"

                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "CsCopia")

                IF loc_nRes > 0
                    SELECT CsCopia
                    GO TOP
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao processar c" + CHR(243) + "pia: " + CapturarErroSQL(), "EmnBO.ProcessarCopia")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.ProcessarCopia")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CopiarItens - Copia itens marcados de CsCopia para empresa destino
    *               Apenas linhas marcas=1 E existes=0 sao copiadas
    *==========================================================================
    PROCEDURE CopiarItens(par_cEmpD)
        LOCAL loc_lResultado, loc_nRes, loc_nCopias, loc_nTotal
        LOCAL loc_cSQL, loc_cCidChaves, loc_lTransacao
        loc_lResultado = .F.
        loc_nCopias    = 0
        loc_nTotal     = 0
        loc_lTransacao = .F.

        TRY
            IF !USED("CsCopia") OR RECCOUNT("CsCopia") = 0
                MsgErro("Cursor CsCopia vazio. Execute ProcessarCopia primeiro.", "EmnBO.CopiarItens")
            ELSE
                IF EMPTY(ALLTRIM(par_cEmpD))
                MsgErro("Empresa Destino inv" + CHR(225) + "lida.", "EmnBO.CopiarItens")
            ELSE
                SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
                loc_lTransacao = .T.
                loc_lResultado = .T.

                SELECT CsCopia
                COUNT FOR !DELETED() TO loc_nTotal
                GO TOP

                SCAN FOR !DELETED() AND CsCopia.marcas = 1 AND CsCopia.existes = 0
                    loc_cCidChaves = THIS.GerarChaveUnica()

                    loc_cSQL = "INSERT INTO SigCdMin" + ;
                        " (cpros, emps, locals, qmins, qideal, codtams, codcores," + ;
                        " cidchaves, contas, grupos, ordems, retiras, pideal, pmins)" + ;
                        " VALUES (" + ;
                        EscaparSQL(ALLTRIM(CsCopia.cpros))               + ", " + ;
                        EscaparSQL(PADR(ALLTRIM(par_cEmpD), 3))          + ", " + ;
                        EscaparSQL(LEFT(ALLTRIM(CsCopia.locals),  10))   + ", " + ;
                        FormatarNumeroSQL(CsCopia.qmins)                 + ", " + ;
                        FormatarNumeroSQL(CsCopia.qideal)                + ", " + ;
                        EscaparSQL(LEFT(ALLTRIM(CsCopia.codtams), 4))    + ", " + ;
                        EscaparSQL(LEFT(ALLTRIM(CsCopia.codcores), 4))   + ", " + ;
                        EscaparSQL(LEFT(loc_cCidChaves, 20))             + ", " + ;
                        EscaparSQL(LEFT(ALLTRIM(CsCopia.contas), 10))    + ", " + ;
                        EscaparSQL(LEFT(ALLTRIM(CsCopia.grupos), 10))    + ", " + ;
                        "' ', 1, 0, 0)"

                    loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Copia")
                    IF USED("cursor_4c_Copia")
                        USE IN cursor_4c_Copia
                    ENDIF

                    IF loc_nRes >= 0
                        loc_nCopias = loc_nCopias + 1
                    ELSE
                        MsgErro("Erro ao copiar item: " + CapturarErroSQL(), "EmnBO.CopiarItens")
                        loc_lResultado = .F.
                        EXIT
                    ENDIF
                ENDSCAN

                IF loc_lResultado
                    SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                    loc_lTransacao = .F.
                    MsgInfo("Foram copiados " + TRANSFORM(loc_nCopias) + " de " + ;
                        TRANSFORM(loc_nTotal) + " registros.")
                ELSE
                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                    loc_lTransacao = .F.
                ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.CopiarItens")
            loc_lResultado = .F.
        ENDTRY

        IF loc_lTransacao
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
        ENDIF

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

