# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 2/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'CarregarLista': Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc)

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-22 01:26:52] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-22 01:26:52] [INFO] Config FPW: (nao fornecido)
[2026-07-22 01:26:52] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-22 01:26:52] [INFO] Timeout: 300 segundos
[2026-07-22 01:26:52] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_0ptu5sku.prg
[2026-07-22 01:26:52] [INFO] Conteudo do wrapper:
[2026-07-22 01:26:52] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormCAD', 'C:\4c\tasks\task352', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormCAD', 'C:\4c\tasks\task352', 'CRUD'
QUIT

[2026-07-22 01:26:52] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_0ptu5sku.prg
[2026-07-22 01:26:52] [INFO] VFP output esperado em: C:\4c\tasks\task352\vfp_output.txt
[2026-07-22 01:26:52] [INFO] Executando Visual FoxPro 9...
[2026-07-22 01:26:52] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_0ptu5sku.prg
[2026-07-22 01:26:52] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_0ptu5sku.prg
[2026-07-22 01:26:52] [INFO] Timeout configurado: 300 segundos
[2026-07-22 01:27:28] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-22 01:27:28] [INFO] VFP9 finalizado em 35.7997535 segundos
[2026-07-22 01:27:28] [INFO] Exit Code: 
[2026-07-22 01:27:28] [INFO] 
[2026-07-22 01:27:28] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-22 01:27:28] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_0ptu5sku.prg
[2026-07-22 01:27:28] [INFO] 
[2026-07-22 01:27:28] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-22 01:27:28] [INFO] * Auto-generated wrapper for parameters
[2026-07-22 01:27:28] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-22 01:27:28] [INFO] * Parameters: 'FormCAD', 'C:\4c\tasks\task352', 'CRUD'
[2026-07-22 01:27:28] [INFO] 
[2026-07-22 01:27:28] [INFO] * Anti-dialog protections for unattended execution
[2026-07-22 01:27:28] [INFO] SET SAFETY OFF
[2026-07-22 01:27:28] [INFO] SET RESOURCE OFF
[2026-07-22 01:27:28] [INFO] SET TALK OFF
[2026-07-22 01:27:28] [INFO] SET NOTIFY OFF
[2026-07-22 01:27:28] [INFO] SYS(2335, 0)
[2026-07-22 01:27:28] [INFO] 
[2026-07-22 01:27:28] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormCAD', 'C:\4c\tasks\task352', 'CRUD'
[2026-07-22 01:27:28] [INFO] QUIT
[2026-07-22 01:27:28] [INFO] 
[2026-07-22 01:27:28] [INFO] === Fim do Wrapper.prg ===
[2026-07-22 01:27:28] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-07-22 01:29:12] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-22 01:29:12] [INFO] Config FPW: (nao fornecido)
[2026-07-22 01:29:12] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-22 01:29:12] [INFO] Timeout: 300 segundos
[2026-07-22 01:29:12] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_owy1onhj.prg
[2026-07-22 01:29:12] [INFO] Conteudo do wrapper:
[2026-07-22 01:29:12] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormCAD', 'C:\4c\tasks\task352', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormCAD', 'C:\4c\tasks\task352', 'CRUD'
QUIT

[2026-07-22 01:29:12] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_owy1onhj.prg
[2026-07-22 01:29:12] [INFO] VFP output esperado em: C:\4c\tasks\task352\vfp_output.txt
[2026-07-22 01:29:12] [INFO] Executando Visual FoxPro 9...
[2026-07-22 01:29:12] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_owy1onhj.prg
[2026-07-22 01:29:12] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_owy1onhj.prg
[2026-07-22 01:29:12] [INFO] Timeout configurado: 300 segundos
[2026-07-22 01:29:53] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-22 01:29:53] [INFO] VFP9 finalizado em 40.6632779 segundos
[2026-07-22 01:29:53] [INFO] Exit Code: 
[2026-07-22 01:29:53] [INFO] 
[2026-07-22 01:29:53] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-22 01:29:53] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_owy1onhj.prg
[2026-07-22 01:29:53] [INFO] 
[2026-07-22 01:29:53] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-22 01:29:53] [INFO] * Auto-generated wrapper for parameters
[2026-07-22 01:29:53] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-22 01:29:53] [INFO] * Parameters: 'FormCAD', 'C:\4c\tasks\task352', 'CRUD'
[2026-07-22 01:29:53] [INFO] 
[2026-07-22 01:29:53] [INFO] * Anti-dialog protections for unattended execution
[2026-07-22 01:29:53] [INFO] SET SAFETY OFF
[2026-07-22 01:29:53] [INFO] SET RESOURCE OFF
[2026-07-22 01:29:53] [INFO] SET TALK OFF
[2026-07-22 01:29:53] [INFO] SET NOTIFY OFF
[2026-07-22 01:29:53] [INFO] SYS(2335, 0)
[2026-07-22 01:29:53] [INFO] 
[2026-07-22 01:29:53] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormCAD', 'C:\4c\tasks\task352', 'CRUD'
[2026-07-22 01:29:53] [INFO] QUIT
[2026-07-22 01:29:53] [INFO] 
[2026-07-22 01:29:53] [INFO] === Fim do Wrapper.prg ===
[2026-07-22 01:29:53] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormCAD",
  "timestamp": "20260722012953",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": true,
      "erro": "",
      "detalhes": "Objeto criado com sucesso"
    },
    {
      "nome": "CarregarLista",
      "passou": false,
      "erro": "Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc)",
      "detalhes": ""
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCAD.prg):
*==============================================================================
* FormCAD.prg - Formulario de Cadastros Gerais
* Migrado de: SIGCDCAD.SCX (frmcadastro)
*
* Formulario PARAMETRIZADO: recebe par_cTipoCads no Init para filtrar
* registros de SigCdCad por categoria (TipoCads).
*
* Fase 5/8 - Campos Page2: cnt_4c_Cabecalho, lbl_4c_LblCodCads, txt_4c_CodCads.
*==============================================================================

DEFINE CLASS FormCAD AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX fidelidade)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastros Gerais"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    DataSession = 2

    *-- Propriedades do negocio
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"
    this_cTipoCads       = ""   && Tipo/categoria do cadastro (par_cTipoCads)
    this_nMaxCodCads     = 20   && Tamanho maximo do codigo (par_nMaxCodCads)

    *==========================================================================
    * Init - Recebe tipo de cadastro e tamanho do codigo
    * par_cTipoCads: categoria (ex: "APONTAMTO", "CARGO")
    * par_nMaxCodCads: tamanho do campo codigo (1-20, default=20)
    *==========================================================================
    PROCEDURE Init(par_cTipoCads, par_nMaxCodCads)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Configurar tipo antes do DODEFAULT (que dispara InicializarForm)
            IF VARTYPE(par_cTipoCads) = "C" AND !EMPTY(par_cTipoCads)
                THIS.this_cTipoCads = ALLTRIM(UPPER(par_cTipoCads))
            ENDIF

            IF VARTYPE(par_nMaxCodCads) = "N" AND BETWEEN(par_nMaxCodCads, 1, 20)
                THIS.this_nMaxCodCads = par_nMaxCodCads
            ENDIF

            *-- Caption dinamico baseado no tipo
            THIS.Caption = PROPER(THIS.this_cTipoCads)
            IF PADR(UPPER(THIS.this_cTipoCads), 20) = PADR("APONTAMTO", 20)
                THIS.Caption = "Avalia" + CHR(231) + CHR(227) + "o"
            ENDIF

            loc_lSucesso = DODEFAULT()

        CATCH TO loException
            MsgErro("Erro ao inicializar FormCAD:" + CHR(13) + loException.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarForm - Configura estrutura completa (chamado pelo FormBase.Init)
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lBOOk
        loc_lSucesso = .F.
        loc_lBOOk    = .F.

        TRY
            *-- Criar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("CADBO")
            loc_lBOOk = (VARTYPE(THIS.this_oBusinessObject) = "O")

            IF !loc_lBOOk
                MsgErro("Erro ao criar CADBO", "FormCAD.InicializarForm")
            ELSE
                *-- Propagar tipo para o BO (todas as queries filtram por TipoCads)
                THIS.this_oBusinessObject.this_cTipoCads = THIS.this_cTipoCads

                *-- Montar estrutura visual
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                *-- Propagar Caption dinamico para labels do cabecalho (Page1 e Page2)
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Carregar dados iniciais (pula se ValidarUIFidelity estiver ativo)
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao configurar FormCAD:" + CHR(13) + loException.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria PageFrame com 2 paginas (Lista e Dados)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        TRY
            THIS.AddObject("pgf_4c_Paginas", "PageFrame")

            WITH THIS.pgf_4c_Paginas
                .PageCount = 2
                .Top       = -29
                .Left      = 0
                .Width     = THIS.Width
                .Height    = THIS.Height + 29
                .Tabs      = .F.
                .Visible   = .T.

                .Page1.Caption   = "Lista"
                .Page1.BackColor = RGB(100, 100, 100)
                .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

                .Page2.Caption   = "Dados"
                .Page2.BackColor = RGB(100, 100, 100)
                .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            ENDWITH

        CATCH TO loException
            MsgErro("Erro ao configurar PageFrame:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD e grid de registros
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid
        loc_oPagina = .NULL.
        loc_oGrid   = .NULL.

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
            loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Container cabecalho (cntSombra no legado: Top=1 -> comp +29 -> 30; usando 31)
            loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
            WITH loc_oPagina.cnt_4c_Cabecalho
                .Top         = 31
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BackColor   = RGB(100, 100, 100)
                .BorderWidth = 0
                .Visible     = .T.

                .AddObject("lbl_4c_Sombra", "Label")
                WITH .lbl_4c_Sombra
                    .Caption   = THIS.Caption
                    .Top       = 15
                    .Left      = 10
                    .Width     = THIS.Width
                    .Height    = 40
                    .FontName  = "Tahoma"
                    .FontSize  = 16
                    .FontBold  = .T.
                    .ForeColor = RGB(0, 0, 0)
                    .BackStyle = 0
                    .AutoSize  = .F.
                ENDWITH

                .AddObject("lbl_4c_Titulo", "Label")
                WITH .lbl_4c_Titulo
                    .Caption   = THIS.Caption
                    .Top       = 18
                    .Left      = 10
                    .Width     = THIS.Width
                    .Height    = 46
                    .FontName  = "Tahoma"
                    .FontSize  = 16
                    .FontBold  = .T.
                    .ForeColor = RGB(255, 255, 255)
                    .BackStyle = 0
                    .AutoSize  = .F.
                ENDWITH
            ENDWITH

            *-- Container botoes CRUD - LADO DIREITO (Grupo_op: Top=-1+29=28 -> 29 canonico)
            loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
            WITH loc_oPagina.cnt_4c_Botoes
                .Top         = 29
                .Left        = 542
                .Width       = 390
                .Height      = 85
                .BackColor   = RGB(53, 53, 53)
                .BackStyle   = 1
                .BorderWidth = 0
                .Visible     = .T.

                .AddObject("cmd_4c_Incluir", "CommandButton")
                WITH .cmd_4c_Incluir
                    .Caption         = "Incluir"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
                    .PicturePosition = 13
                    .Top             = 5
                    .Left            =  542
                    .Width           = 75
                    .Height          = 75
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .FontName        = "Tahoma"
                    .FontSize        = 8
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .AutoSize        = .F.
                ENDWITH

                .AddObject("cmd_4c_Visualizar", "CommandButton")
                WITH .cmd_4c_Visualizar
                    .Caption         = "Visualizar"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
                    .PicturePosition = 13
                    .Top             = 5
                    .Left            =  542
                    .Width           = 75
                    .Height          = 75
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .FontName        = "Tahoma"
                    .FontSize        = 8
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .Themes          = .F.
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .AutoSize        = .F.
                ENDWITH

                .AddObject("cmd_4c_Alterar", "CommandButton")
                WITH .cmd_4c_Alterar
                    .Caption         = "Alterar"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
                    .PicturePosition = 13
                    .Top             = 5
                    .Left            =  542
                    .Width           = 75
                    .Height          = 75
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .FontName        = "Tahoma"
                    .FontSize        = 8
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .Themes          = .F.
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .AutoSize        = .F.
                ENDWITH

                .AddObject("cmd_4c_Excluir", "CommandButton")
                WITH .cmd_4c_Excluir
                    .Caption         = "Excluir"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                    .PicturePosition = 13
                    .Top             = 5
                    .Left            =  542
                    .Width           = 75
                    .Height          = 75
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .FontName        = "Tahoma"
                    .FontSize        = 8
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .Themes          = .F.
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .AutoSize        = .F.
                ENDWITH

                .AddObject("cmd_4c_Buscar", "CommandButton")
                WITH .cmd_4c_Buscar
                    .Caption         = "Buscar"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
                    .PicturePosition = 13
                    .Top             = 5
                    .Left            =  542
                    .Width           = 75
                    .Height          = 75
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .FontName        = "Tahoma"
                    .FontSize        = 8
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .Themes          = .F.
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .AutoSize        = .F.
                ENDWITH
            ENDWITH

            *-- Container saida - CANONICO (Left=917, Width=90, cmd Width=75)
            loc_oPagina.AddObject("cnt_4c_Saida", "Container")
            WITH loc_oPagina.cnt_4c_Saida
                .Top         = 29
                .Left        = 917
                .Width       = 90
                .Height      = 85
                .BackStyle   = 0
                .BorderWidth = 0
                .Visible     = .T.

                .AddObject("cmd_4c_Encerrar", "CommandButton")
                WITH .cmd_4c_Encerrar
                    .Caption         = "Encerrar"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                    .PicturePosition = 13
                    .Top             = 5
                    .Left            = 917
                    .Width           = 75
                    .Height          = 75
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .FontName        = "Tahoma"
                    .FontSize        = 8
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .AutoSize        = .F.
                ENDWITH
            ENDWITH

            *-- Grid de lista (Grade no legado: Top=88+29=117)
            loc_oPagina.AddObject("grd_4c_Lista", "Grid")
            loc_oGrid = loc_oPagina.grd_4c_Lista

            IF !USED("cursor_4c_Dados")
                CREATE CURSOR cursor_4c_Dados (codcads C(20), descads C(40))
            ENDIF
            loc_oGrid.ColumnCount = 3
            loc_oGrid.RecordSource = "cursor_4c_Dados"
            loc_oGrid.ColumnCount  = 2

            WITH loc_oGrid
                .Top                = 117
                .Left               = 26
                .Width              = 890
                .Height             = 453
                .FontName           = "Verdana"
                .FontSize           = 8
                .ForeColor          = RGB(90, 90, 90)
                .BackColor          = RGB(255, 255, 255)
                .GridLineColor      = RGB(238, 238, 238)
                .HighlightBackColor = RGB(255, 255, 255)
                .HighlightForeColor = RGB(15, 41, 104)
                .HighlightStyle     = 2
                .DeleteMark         = .F.
                .RecordMark         = .F.
                .RowHeight          = 16
                .ScrollBars         = 2
                .GridLines          = 3
                .Visible            = .T.

                .Column1.ControlSource    = "cursor_4c_Dados.codcads"
                .Column1.Width            = 150
                .Column1.Header1.Caption  = "C" + CHR(243) + "digo"

                .Column2.ControlSource    = "cursor_4c_Dados.descads"
                .Column2.Width            = 738
                .Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
            ENDWITH

            *-- BINDEVENTs para botoes CRUD (metodos PUBLIC - sem PROTECTED)
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
            BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
            BINDEVENT(loc_oGrid, "DblClick", THIS, "BtnVisualizarClick")

            THIS.TornarControlesVisiveis(loc_oPagina)

        CATCH TO loException
            MsgErro("Erro ao configurar Page1:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Page2: botoes Salvar/Cancelar + campos CodCads
    * Fase 5: cnt_4c_Cabecalho, lbl_4c_LblCodCads, txt_4c_CodCads.
    * Fase 6: lbl_4c_Descricao, txt_4c_DesCads.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = .NULL.

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2

            *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
            loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Container botoes Salvar/Cancelar (Grupo_Salva: Top=9+29=38 -> canonico Left=842)
            loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
            WITH loc_oPagina.cnt_4c_BotoesAcao
                .Top         = 33
                .Left        = 842
                .Width       = 160
                .Height      = 85
                .BackStyle   = 0
                .Visible     = .T.

                .AddObject("cmd_4c_Confirmar", "CommandButton")
                WITH .cmd_4c_Confirmar
                    .Caption         = "Confirmar"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                    .PicturePosition = 13
                    .Top             = 5
                    .Left            = 5
                    .Width           = 75
                    .Height          = 75
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .FontName        = "Tahoma"
                    .FontSize        = 8
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .AutoSize        = .F.
                    .Enabled         = .F.
                ENDWITH

                .AddObject("cmd_4c_Cancelar", "CommandButton")
                WITH .cmd_4c_Cancelar
                    .Caption         = "Encerrar"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                    .PicturePosition = 13
                    .Top             = 5
                    .Left            = 80
                    .Width           = 75
                    .Height          = 75
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .FontName        = "Tahoma"
                    .FontSize        = 8
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .Themes          = .F.
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .AutoSize        = .F.
                ENDWITH
            ENDWITH

            *-- Container cabecalho na Page2 (espelha Page1 para consistencia visual)
            loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
            WITH loc_oPagina.cnt_4c_Cabecalho
                .Top         = 31
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BackColor   = RGB(100, 100, 100)
                .BorderWidth = 0
                .Visible     = .T.

                .AddObject("lbl_4c_Sombra", "Label")
                WITH .lbl_4c_Sombra
                    .Caption   = THIS.Caption
                    .Top       = 15
                    .Left      = 10
                    .Width     = THIS.Width
                    .Height    = 40
                    .FontName  = "Tahoma"
                    .FontSize  = 16
                    .FontBold  = .T.
                    .ForeColor = RGB(0, 0, 0)
                    .BackStyle = 0
                    .AutoSize  = .F.
                ENDWITH

                .AddObject("lbl_4c_Titulo", "Label")
                WITH .lbl_4c_Titulo
                    .Caption   = THIS.Caption
                    .Top       = 18
                    .Left      = 10
                    .Width     = THIS.Width
                    .Height    = 46
                    .FontName  = "Tahoma"
                    .FontSize  = 16
                    .FontBold  = .T.
                    .ForeColor = RGB(255, 255, 255)
                    .BackStyle = 0
                    .AutoSize  = .F.
                ENDWITH
            ENDWITH

            *-- lbl_4c_LblCodCads: exibe dinamicamente "TipoCads :" como label
            *-- Original: lblCodCads (TextBox-como-label), Top=154, Left=78, Width=268 -> +29 -> Top=183
            loc_oPagina.AddObject("lbl_4c_LblCodCads", "Label")
            WITH loc_oPagina.lbl_4c_LblCodCads
                .Caption   = THIS.Caption + " :"
                .Top       = 183
                .Left      = 78
                .Width     = 268
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .Alignment = 1
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_CodCads: campo codigo (CodCads)
            *-- Original: getCodCads, Top=153, Left=349, Width=(pTam*7)+10, Height=24 -> +29 -> Top=182
            *-- Width dinamica conforme this_nMaxCodCads (default=20 -> 150px)
            loc_oPagina.AddObject("txt_4c_CodCads", "TextBox")
            WITH loc_oPagina.txt_4c_CodCads
                .Value         = ""
                .Top           = 182
                .Left          = 349
                .Width         = (THIS.this_nMaxCodCads * 7) + 10
                .Height        = 24
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Format        = "K!"
                .MaxLength     = THIS.this_nMaxCodCads
                .SpecialEffect = 1
                .Enabled       = .T.
                .Visible       = .T.
            ENDWITH

            *-- lbl_4c_Descricao: label "Descricao :" para o campo descricao
            *-- Original: Say1, Top=185, Left=291 -> Top+29=214, Left=291
            loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
            WITH loc_oPagina.lbl_4c_Descricao
                .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
                .Top       = 214
                .Left      = 291
                .Width     = 55
                .Height    = 17
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .Alignment = 1
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_DesCads: campo descricao (DesCads)
            *-- Original: getDesCads, Top=180, Left=349, Width=290, Height=24 -> Top+29=209
            loc_oPagina.AddObject("txt_4c_DesCads", "TextBox")
            WITH loc_oPagina.txt_4c_DesCads
                .Value         = ""
                .Top           = 209
                .Left          = 349
                .Width         = 290
                .Height        = 24
                .FontName      = "Tahoma"
                .FontSize      = 8
                .MaxLength     = 40
                .SpecialEffect = 1
                .Enabled       = .T.
                .Visible       = .T.
            ENDWITH

            *-- BINDEVENTs para botoes da Page2
            BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
            BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

            THIS.TornarControlesVisiveis(loc_oPagina)

        CATCH TO loException
            MsgErro("Erro ao configurar Page2:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarLista - Busca registros e vincula ao grid da Page1
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.
        loc_oGrid      = .NULL.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        TRY
            IF !THIS.this_oBusinessObject.Buscar("")
                loc_lResultado = .F.
            ELSE
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                loc_oGrid.ColumnCount = 2
                loc_oGrid.RecordSource = "cursor_4c_Dados"

                loc_oGrid.Column1.ControlSource   = "cursor_4c_Dados.codcads"
                loc_oGrid.Column1.Width           = 150
                loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"

                loc_oGrid.Column2.ControlSource   = "cursor_4c_Dados.descads"
                loc_oGrid.Column2.Width           = 738
                loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

                THIS.FormatarGridLista(loc_oGrid)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao carregar lista:" + CHR(13) + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AlternarPagina - Navega entre Page1 (Lista) e Page2 (Dados)
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR !BETWEEN(par_nPagina, 1, 2)
                loc_lResultado = .F.
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina

                IF par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                    THIS.CarregarLista()
                ENDIF

                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Habilita/desabilita botoes conforme modo atual
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg1, loc_oPg2, loc_lEdicao
        loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        TRY
            loc_oPg1 = THIS.pgf_4c_Paginas.Page1
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            *-- Botoes da Page1: desabilitar durante edicao
            IF VARTYPE(loc_oPg1) = "O"
                IF PEMSTATUS(loc_oPg1, "cnt_4c_Botoes", 5)
                    loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = !loc_lEdicao
                    loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = !loc_lEdicao
                    loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = !loc_lEdicao
                    loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = !loc_lEdicao
                    loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = !loc_lEdicao
                ENDIF
            ENDIF

            *-- Botoes da Page2: Confirmar habilitado so em edicao
            IF VARTYPE(loc_oPg2) = "O"
                IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
                    loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEdicao
                    loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
                ENDIF
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao ajustar bot" + CHR(245) + "es:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Incluir novo registro
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.LimparCampos()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.pgf_4c_Paginas.ActivePage = 2
        CATCH TO loException
            MsgErro("Erro ao incluir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Visualizar registro selecionado (somente leitura)
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Nenhum registro selecionado.", "Aviso")
            ELSE
                SELECT cursor_4c_Dados
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.codcads)

                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    THIS.this_cModoAtual = "VISUALIZAR"
                    THIS.BOParaForm()
                    THIS.HabilitarCampos(.F.)
                    THIS.AjustarBotoesPorModo()
                    THIS.pgf_4c_Paginas.ActivePage = 2
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao visualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Alterar registro selecionado
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Nenhum registro selecionado.", "Aviso")
            ELSE
                SELECT cursor_4c_Dados
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.codcads)

                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    THIS.this_oBusinessObject.EditarRegistro()
                    THIS.this_cModoAtual = "ALTERAR"
                    THIS.BOParaForm()
                    THIS.HabilitarCampos(.T.)
                    THIS.AjustarBotoesPorModo()
                    THIS.pgf_4c_Paginas.ActivePage = 2
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao alterar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Excluir registro selecionado
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_cDesc, loc_lConfirma
        loc_cCodigo   = ""
        loc_cDesc     = ""
        loc_lConfirma = .F.

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Nenhum registro selecionado.", "Aviso")
            ELSE
                SELECT cursor_4c_Dados
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.codcads)
                loc_cDesc   = ALLTRIM(cursor_4c_Dados.descads)

                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    loc_lConfirma = MsgConfirma( ;
                        "Confirma a exclus" + CHR(227) + "o do registro:" + CHR(13) + CHR(13) + ;
                        "C" + CHR(243) + "digo: " + loc_cCodigo + CHR(13) + ;
                        "Descri" + CHR(231) + CHR(227) + "o: " + loc_cDesc, ;
                        "Confirmar Exclus" + CHR(227) + "o")

                    IF loc_lConfirma
                        IF THIS.this_oBusinessObject.Excluir()
                            MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", ;
                                "Exclus" + CHR(227) + "o")
                            THIS.CarregarLista()
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao excluir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Buscar/filtrar registros na lista
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_cFiltro, loc_oGrid
        loc_cFiltro = ""
        loc_oGrid   = .NULL.

        TRY
            loc_cFiltro = INPUTBOX( ;
                "Digite o termo para busca (c" + CHR(243) + "digo ou descri" + ;
                CHR(231) + CHR(227) + "o):", ;
                "Buscar", "")

            IF VARTYPE(loc_cFiltro) = "C"
                IF !THIS.this_oBusinessObject.Buscar(loc_cFiltro)
                    IF !EMPTY(loc_cFiltro)
                        MsgAviso("Nenhum registro encontrado.", "Busca")
                    ENDIF
                ELSE
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                    loc_oGrid.ColumnCount = 2
                    loc_oGrid.RecordSource = "cursor_4c_Dados"

                    loc_oGrid.Column1.ControlSource   = "cursor_4c_Dados.codcads"
                    loc_oGrid.Column1.Width           = 150
                    loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"

                    loc_oGrid.Column2.ControlSource   = "cursor_4c_Dados.descads"
                    loc_oGrid.Column2.Width           = 738
                    loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

                    THIS.FormatarGridLista(loc_oGrid)
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao buscar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fechar formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Salvar registro (Confirmar na Page2)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_cCodCads, loc_oPg2
        loc_cCodCads = ""
        loc_oPg2     = THIS.pgf_4c_Paginas.Page2

        *-- Validacoes FORA do TRY (podem usar RETURN)
        IF PEMSTATUS(loc_oPg2, "txt_4c_CodCads", 5)
            loc_cCodCads = ALLTRIM(loc_oPg2.txt_4c_CodCads.Value)
        ENDIF

        IF EMPTY(loc_cCodCads)
            MsgAviso("O C" + CHR(243) + "digo n" + CHR(227) + "o pode ficar em branco!", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            IF PEMSTATUS(loc_oPg2, "txt_4c_CodCads", 5)
                loc_oPg2.txt_4c_CodCads.SetFocus()
            ENDIF
            RETURN
        ENDIF

        *-- Em modo INCLUIR verificar duplicidade
        IF THIS.this_cModoAtual = "INCLUIR"
            IF THIS.this_oBusinessObject.VerificarDuplicidade(loc_cCodCads)
                MsgAviso("Este c" + CHR(243) + "digo j" + CHR(225) + ;
                    " existe para este tipo de cadastro!", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                IF PEMSTATUS(loc_oPg2, "txt_4c_CodCads", 5)
                    loc_oPg2.txt_4c_CodCads.SetFocus()
                ENDIF
                RETURN
            ENDIF
        ENDIF

        TRY
            THIS.FormParaBO()

            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Registro salvo com sucesso!", "Sucesso")
                THIS.AlternarPagina(1)
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao salvar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancelar edicao e voltar para lista
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *==========================================================================
    * FormatarGridLista - Aplica formatacao visual ao grid da lista
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        TRY
            WITH par_oGrid
                .FontName = "Verdana"
                .FontSize = 8
                .SetAll("ForeColor", RGB(90, 90, 90), "Column")
            ENDWITH
        CATCH TO loException
            MsgErro("Erro ao formatar grid:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP
        loc_nI = 0
        loc_nP = 0

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                *-- PageFrame: iterar Pages
                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                *-- Container: recursao nos filhos
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere valores dos campos do form para o BO
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF VARTYPE(loc_oPg2) = "O"
                IF PEMSTATUS(loc_oPg2, "txt_4c_CodCads", 5)
                    THIS.this_oBusinessObject.this_cCodCads = ;
                        PADR(ALLTRIM(loc_oPg2.txt_4c_CodCads.Value), 20)
                ENDIF
                IF PEMSTATUS(loc_oPg2, "txt_4c_DesCads", 5)
                    THIS.this_oBusinessObject.this_cDesCads = ;
                        PADR(ALLTRIM(loc_oPg2.txt_4c_DesCads.Value), 40)
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao ler campos:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere valores do BO para os campos do form
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF VARTYPE(loc_oPg2) = "O"
                IF PEMSTATUS(loc_oPg2, "txt_4c_CodCads", 5)
                    loc_oPg2.txt_4c_CodCads.Value = ALLTRIM(THIS.this_oBusinessObject.this_cCodCads)
                ENDIF
                IF PEMSTATUS(loc_oPg2, "txt_4c_DesCads", 5)
                    loc_oPg2.txt_4c_DesCads.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDesCads)
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao preencher campos:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita campos conforme modo
    * Regra legado getCodCads.When: CodCads so editavel em modo INCLUIR
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_lCodHabilitado
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- CodCads somente editavel em INCLUIR (regra When do legado)
        loc_lCodHabilitado = par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")

        TRY
            IF VARTYPE(loc_oPg2) = "O"
                IF PEMSTATUS(loc_oPg2, "txt_4c_CodCads", 5)
                    loc_oPg2.txt_4c_CodCads.Enabled = loc_lCodHabilitado
                ENDIF
                IF PEMSTATUS(loc_oPg2, "txt_4c_DesCads", 5)
                    loc_oPg2.txt_4c_DesCads.Enabled = par_lHabilitar
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao habilitar campos:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa valores dos campos da Page2
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF VARTYPE(loc_oPg2) = "O"
                IF PEMSTATUS(loc_oPg2, "txt_4c_CodCads", 5)
                    loc_oPg2.txt_4c_CodCads.Value = ""
                ENDIF
                IF PEMSTATUS(loc_oPg2, "txt_4c_DesCads", 5)
                    loc_oPg2.txt_4c_DesCads.Value = ""
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao limpar campos:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Destroy - Libera recursos
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\CADBO.prg):
*====================================================================
* CADBO.prg
*
* Business Object para Cadastros Gerais (SigCdCad)
* Herda de: BusinessBase
*
* PARAMETRIZADO: this_cTipoCads define a categoria de cadastro.
* Todas as queries filtram por TipoCads.
* Aberto pelo menu com par_cTipoCads e par_nMaxCodCads.
*====================================================================

DEFINE CLASS CADBO AS BusinessBase

    *-- Filtro de categoria (obrigatorio - definido pelo formulario chamador)
    this_cTipoCads   = ""   && tipocads char(20) - tipo/categoria do cadastro

    *-- Propriedades da entidade (SigCdCad)
    this_cPkChaves   = ""   && pkchaves char(20) - chave primaria (LEFT(NEWID(),20))
    this_cCodCads    = ""   && codcads char(20) - codigo do item
    this_cDesCads    = ""   && descads char(40) - descricao do item
    this_cTxtCads    = ""   && txtcads char(50) - texto adicional
    this_cUsuars     = ""   && usuars char(10) - usuario que incluiu
    this_dDtIncs     = {}   && dtincs datetime - data/hora de inclusao
    this_cUsuAlts    = ""   && usualts char(10) - usuario que alterou
    this_dDtAlts     = {}   && dtalts datetime - data/hora de alteracao

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdCad"
        THIS.this_cCampoChave = "pkchaves"
        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cPkChaves
    ENDPROC

    *====================================================================
    * LimparDados - Limpa propriedades (chamado por NovoRegistro)
    *====================================================================
    PROTECTED PROCEDURE LimparDados()
        THIS.this_cPkChaves = ""
        THIS.this_cCodCads  = ""
        THIS.this_cDesCads  = ""
        THIS.this_cTxtCads  = ""
        THIS.this_cUsuars   = ""
        THIS.this_dDtIncs   = {}
        THIS.this_cUsuAlts  = ""
        THIS.this_dDtAlts   = {}
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega dados do cursor para propriedades
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAliasCursor)
            THIS.this_cPkChaves = TratarNulo(pkchaves, "C")
            THIS.this_cCodCads  = TratarNulo(codcads,  "C")
            THIS.this_cDesCads  = TratarNulo(descads,  "C")
            THIS.this_cTxtCads  = TratarNulo(txtcads,  "C")
            THIS.this_cTipoCads = TratarNulo(tipocads, "C")
            THIS.this_cUsuars   = TratarNulo(usuars,   "C")
            THIS.this_cUsuAlts  = TratarNulo(usualts,  "C")
            IF !ISNULL(dtincs)
                THIS.this_dDtIncs = dtincs
            ENDIF
            IF !ISNULL(dtalts)
                THIS.this_dDtAlts = dtalts
            ENDIF
            THIS.this_lNovoRegistro = .F.
            loc_lResultado = .T.
        CATCH TO loException
            MsgErro("Erro ao carregar cursor: " + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * Buscar - Carrega lista de cadastros filtrada por TipoCads
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(THIS.this_cTipoCads)
            MsgErro("Tipo de cadastro n" + CHR(227) + "o definido.", "Erro")
            RETURN .F.
        ENDIF

        TRY
            IF EMPTY(par_cFiltro)
                loc_cSQL = "SELECT pkchaves, codcads, descads, tipocads, usuars, dtincs, usualts, dtalts" + ;
                           " FROM SigCdCad" + ;
                           " WHERE tipocads = " + EscaparSQL(PADR(THIS.this_cTipoCads, 20)) + ;
                           " ORDER BY codcads"
            ELSE
                loc_cSQL = "SELECT pkchaves, codcads, descads, tipocads, usuars, dtincs, usualts, dtalts" + ;
                           " FROM SigCdCad" + ;
                           " WHERE tipocads = " + EscaparSQL(PADR(THIS.this_cTipoCads, 20)) + ;
                           "   AND codcads LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
                           " ORDER BY codcads"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar cadastros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao buscar cadastros:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro por CodCads (chave de negocio)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodCads)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT pkchaves, codcads, descads, tipocads, txtcads," + ;
                       " usuars, dtincs, usualts, dtalts" + ;
                       " FROM SigCdCad" + ;
                       " WHERE tipocads = " + EscaparSQL(PADR(THIS.this_cTipoCads, 20)) + ;
                       "   AND codcads   = " + EscaparSQL(PADR(ALLTRIM(par_cCodCads), 20))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao carregar cadastro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * VerificarDuplicidade - Verifica se CodCads ja existe neste TipoCads
    *====================================================================
    PROCEDURE VerificarDuplicidade(par_cCodCads)
        LOCAL loc_cSQL, loc_nResultado, loc_lDuplicado
        loc_lDuplicado = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdCad" + ;
                       " WHERE tipocads = " + EscaparSQL(PADR(THIS.this_cTipoCads, 20)) + ;
                       "   AND codcads   = " + EscaparSQL(PADR(ALLTRIM(par_cCodCads), 20))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dup")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Dup") > 0
                SELECT cursor_4c_Dup
                loc_lDuplicado = (cursor_4c_Dup.qtd > 0)
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao verificar duplicidade:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Dup")
            USE IN cursor_4c_Dup
        ENDIF

        RETURN loc_lDuplicado
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro (PROTECTED - chamado por Salvar)
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cPkNovo
        loc_lSucesso = .F.
        loc_cPkNovo  = ""

        TRY
            *-- Gerar PK via SQL Server (NEWID nao existe em VFP)
            SQLEXEC(gnConnHandle, "SELECT LEFT(NEWID(),20) AS pk_novo", "cursor_4c_PkNovo")
            IF USED("cursor_4c_PkNovo") AND RECCOUNT("cursor_4c_PkNovo") > 0
                SELECT cursor_4c_PkNovo
                loc_cPkNovo = ALLTRIM(cursor_4c_PkNovo.pk_novo)
            ENDIF
            IF USED("cursor_4c_PkNovo")
                USE IN cursor_4c_PkNovo
            ENDIF

            IF !EMPTY(loc_cPkNovo)
                THIS.this_cPkChaves = loc_cPkNovo

                loc_cSQL = "INSERT INTO SigCdCad" + ;
                           " (pkchaves, tipocads, codcads, descads, txtcads, usuars, dtincs, usualts, dtalts)" + ;
                           " VALUES (" + ;
                           EscaparSQL(PADR(THIS.this_cPkChaves, 20)) + ", " + ;
                           EscaparSQL(PADR(THIS.this_cTipoCads, 20)) + ", " + ;
                           EscaparSQL(PADR(THIS.this_cCodCads,  20)) + ", " + ;
                           EscaparSQL(PADR(THIS.this_cDesCads,  40)) + ", " + ;
                           EscaparSQL(PADR(THIS.this_cTxtCads,  50)) + ", " + ;
                           EscaparSQL(PADR(gc_4c_UsuarioLogado, 10)) + ", " + ;
                           "GETDATE(), " + ;
                           EscaparSQL(SPACE(10)) + ", " + ;
                           "NULL" + ;
                           ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao inserir cadastro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MsgErro("Falha ao gerar chave prim" + CHR(225) + "ria.", "Erro")
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao inserir cadastro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente (PROTECTED - chamado por Salvar)
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdCad SET" + ;
                       " descads  = " + EscaparSQL(PADR(THIS.this_cDesCads, 40)) + "," + ;
                       " txtcads  = " + EscaparSQL(PADR(THIS.this_cTxtCads, 50)) + "," + ;
                       " usualts  = " + EscaparSQL(PADR(gc_4c_UsuarioLogado, 10)) + "," + ;
                       " dtalts   = GETDATE()" + ;
                       " WHERE tipocads = " + EscaparSQL(PADR(THIS.this_cTipoCads, 20)) + ;
                       "   AND codcads  = " + EscaparSQL(PADR(THIS.this_cCodCads,  20))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar cadastro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao atualizar cadastro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro (PROTECTED - chamado por Excluir)
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdCad" + ;
                       " WHERE tipocads = " + EscaparSQL(PADR(THIS.this_cTipoCads, 20)) + ;
                       "   AND codcads  = " + EscaparSQL(PADR(THIS.this_cCodCads,  20))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir cadastro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao excluir cadastro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * InicializarValoresPadrao - Hook chamado por NovoRegistro
    *====================================================================
    PROTECTED PROCEDURE InicializarValoresPadrao()
        THIS.this_cPkChaves = ""
        THIS.this_cCodCads  = ""
        THIS.this_cDesCads  = ""
        THIS.this_cTxtCads  = ""
        THIS.this_cUsuars   = ""
        THIS.this_dDtIncs   = {}
        THIS.this_cUsuAlts  = ""
        THIS.this_dDtAlts   = {}
    ENDPROC

ENDDEFINE

