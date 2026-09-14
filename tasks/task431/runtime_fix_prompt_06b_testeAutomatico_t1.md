# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 67% < 100%. Falhas: Teste 'CarregarLista': Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc); Teste 'ModoIncluir': Property ALTERNARPAGINA is not found. | Detalhes: Linha: 412; Teste 'ModoVisualizar': Property AJUSTARBOTOESPORMODO is not found. | Detalhes: Linha: 542

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-06 06:25:11] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-06 06:25:11] [INFO] Config FPW: (nao fornecido)
[2026-08-06 06:25:11] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-06 06:25:11] [INFO] Timeout: 300 segundos
[2026-08-06 06:25:11] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_mr0c50st.prg
[2026-08-06 06:25:11] [INFO] Conteudo do wrapper:
[2026-08-06 06:25:11] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormFre', 'C:\4c\tasks\task431', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormFre', 'C:\4c\tasks\task431', 'CRUD'
QUIT

[2026-08-06 06:25:11] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_mr0c50st.prg
[2026-08-06 06:25:11] [INFO] VFP output esperado em: C:\4c\tasks\task431\vfp_output.txt
[2026-08-06 06:25:11] [INFO] Executando Visual FoxPro 9...
[2026-08-06 06:25:11] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_mr0c50st.prg
[2026-08-06 06:25:11] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_mr0c50st.prg
[2026-08-06 06:25:11] [INFO] Timeout configurado: 300 segundos
[2026-08-06 06:26:11] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-06 06:26:11] [INFO] VFP9 finalizado em 60.1308196 segundos
[2026-08-06 06:26:11] [INFO] Exit Code: 
[2026-08-06 06:26:11] [INFO] 
[2026-08-06 06:26:11] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-06 06:26:11] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_mr0c50st.prg
[2026-08-06 06:26:11] [INFO] 
[2026-08-06 06:26:11] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-06 06:26:11] [INFO] * Auto-generated wrapper for parameters
[2026-08-06 06:26:11] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-06 06:26:11] [INFO] * Parameters: 'FormFre', 'C:\4c\tasks\task431', 'CRUD'
[2026-08-06 06:26:11] [INFO] 
[2026-08-06 06:26:11] [INFO] * Anti-dialog protections for unattended execution
[2026-08-06 06:26:11] [INFO] SET SAFETY OFF
[2026-08-06 06:26:11] [INFO] SET RESOURCE OFF
[2026-08-06 06:26:11] [INFO] SET TALK OFF
[2026-08-06 06:26:11] [INFO] SET NOTIFY OFF
[2026-08-06 06:26:11] [INFO] SYS(2335, 0)
[2026-08-06 06:26:11] [INFO] 
[2026-08-06 06:26:11] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormFre', 'C:\4c\tasks\task431', 'CRUD'
[2026-08-06 06:26:11] [INFO] QUIT
[2026-08-06 06:26:11] [INFO] 
[2026-08-06 06:26:11] [INFO] === Fim do Wrapper.prg ===
[2026-08-06 06:26:11] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormFre",
  "timestamp": "20260806062611",
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
      "passou": false,
      "erro": "Property ALTERNARPAGINA is not found.",
      "detalhes": "Linha: 412"
    },
    {
      "nome": "ModoVisualizar",
      "passou": false,
      "erro": "Property AJUSTARBOTOESPORMODO is not found.",
      "detalhes": "Linha: 542"
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
    "passou": 6,
    "falhou": 3,
    "percentual": 67
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormFre.prg):
*==============================================================================
* FormFre.prg - Formulario: Cadastro de Fretes x Cidades
*==============================================================================
* Legado:  SigCdFre.SCX (frmcadastro)
* Tabelas: SigCdFrt (modo global, PK=cidas)
*          SigOpFrt (modo operacional, PK=cidchaves, filtrado por dopes)
* Uso:     Standalone -> CREATEOBJECT("FormFre")
*          Operacional -> CREATEOBJECT("FormFre", oParent, "DOPES")
*==============================================================================

DEFINE CLASS FormFre AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity, EXATO do legado)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Fretes x Cidades"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *-- Propriedades especificas do FormFre
    this_cDopes      = ""      && Tipo de operacao (vazio = modo global SigCdFrt)
    this_oParentForm = .NULL.  && Form pai desabilitado enquanto este esta aberto

    *===========================================================================
    * Init - Inicializa o formulario
    *   par_oParentForm: form pai a ser desabilitado (opcional)
    *   par_cOperacao:   tipo de operacao/dopes para modo operacional (opcional)
    * Captura parametros ANTES do DODEFAULT() pois InicializarForm() usa this_cDopes
    *===========================================================================
    PROCEDURE Init(par_oParentForm, par_cOperacao)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Capturar referencia ao form pai
            IF PCOUNT() >= 1 AND VARTYPE(par_oParentForm) = "O"
                THIS.this_oParentForm = par_oParentForm
            ENDIF

            *-- Capturar tipo de operacao (modo operacional)
            IF PCOUNT() >= 2 AND VARTYPE(par_cOperacao) = "C" AND !EMPTY(par_cOperacao)
                THIS.this_cDopes = ALLTRIM(par_cOperacao)
            ENDIF

            *-- Ajustar caption e variavel global pDopFrt (compatibilidade legado)
            IF !EMPTY(THIS.this_cDopes)
                THIS.Caption = "Frete por Cidade " + THIS.this_cDopes
            ENDIF

            PUBLIC pDopFrt
            pDopFrt = THIS.this_cDopes

            *-- FormBase.Init() chama THIS.InicializarForm() via DODEFAULT()
            loc_lSucesso = DODEFAULT()
        CATCH TO loException
            MostrarErro(loException, "FormFre.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * InicializarForm - Configura estrutura completa
    * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
    *===========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- 1. Criar BO e propagar modo operacional
            THIS.this_oBusinessObject = CREATEOBJECT("FreBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar FreBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormFre.InicializarForm")
            ELSE
                THIS.this_oBusinessObject.this_cDopes = THIS.this_cDopes

                *-- 2. Criar estrutura de paginas
                THIS.ConfigurarPageFrame()

                *-- 3. Propagar caption para labels do cabecalho
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.pgf_4c_Paginas.Visible   = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual           = "LISTA"

                *-- 4. Carregar cursor TmpCep e lista de registros
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarTmpCep()
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormFre:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormFre.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * Top=-29 esconde as abas; controles compensam +29 no Top
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
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
            .Page1.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
            .Page1.BackColor = RGB(255, 255, 255)

            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaLista - Configura Page1 (Lista)
    * Containers: cnt_4c_Cabecalho, cnt_4c_Botoes (5 botoes CRUD), cnt_4c_Saida (Encerrar)
    * Grid: grd_4c_Lista (grade no legado: Top=121, Left=12, Width=971, Height=470)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container cabecalho (cntSombra no legado: Top=1, compensado +29 = 30)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 30
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = THIS.Caption
            .Top       = 15
            .Left      = 10
            .Width     = THIS.Width - 20
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = THIS.Caption
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width - 20
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container botoes CRUD (Grupo_op no legado: Left=543, Top=-1, compensado +29 = 28)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 28
            .Left        =  542
            .Width       = 385
            .Height      = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir (Left=5)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
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
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Botao Visualizar (Left=80)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
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
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Botao Alterar (Left=155)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 155
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
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Botao Excluir (Left=230)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 230
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
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Botao Buscar (Left=305)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 305
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
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container saida canonico (CLAUDE.md regra #10 - Left=917, Width=90)
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Encerrar canonico (Left=5, Top=5, Width=75, Height=75, Caption="Encerrar")
        loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
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
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Botao "Aguarde" visivel apenas durante carga do TmpCep
        *-- (btnAguarde no legado: Top=266, Left=338, Height=72, Width=322, Visible=.F.)
        loc_oPagina.AddObject("cmd_4c_BtnAguarde", "CommandButton")
        WITH loc_oPagina.cmd_4c_BtnAguarde
            .Top           = 295
            .Left          = 338
            .Width         = 322
            .Height        = 72
            .Caption       = "Aguarde!  Atualizando  Tabela de Cidades . . ."
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 9
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .F.
            .Enabled       = .F.
        ENDWITH

        *-- Grid da lista (grade no legado: Top=121, Left=12, Width=971, Height=470)
        *-- Compensacao PageFrame +29: Top=150; Width=970 para nao ultrapassar borda
        *-- RecordSource/ColumnCount definidos FORA do WITH (Problema 36)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oPagina.grd_4c_Lista.RecordSource = ""
        loc_oPagina.grd_4c_Lista.ColumnCount  = 2
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 12
            .Width              = 970
            .Height             = 470
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .GridLines          = 3
            .RowHeight          = 16
            .ScrollBars         = 2
            .HighlightStyle     = 2
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .GridLineColor      = RGB(238, 238, 238)
            .BackColor          = RGB(255, 255, 255)
            .FontName           = "Verdana"
            .FontSize           = 8
            .Column1.Header1.Caption = "Cidade"
            .Column1.Width           = 400
            .Column2.Header1.Caption = "Valor do Frete"
            .Column2.Width           = 120
            .Column2.Alignment       = 1
        ENDWITH
        BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)

        *-- Garantir BtnAguarde oculto apos TornarControlesVisiveis
        loc_oPagina.cmd_4c_BtnAguarde.Visible = .F.
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Configura Page2 (Dados)
    * Grupo_Salva: Left=836, Top=-5, compensado +29 = 24
    * Campos fase5: lbl_4c_Cidade (Say7) + txt_4c_Cidade (GetCidade)
    * Campos fase6: lbl_4c_ValorFrete (Say2) + txt_4c_Frete (get_Frete)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container botoes Confirmar/Cancelar
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 24
            .Left        = 836
            .Width       = 161
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar (Grupo_Salva.Salva: Top=5, Left=5)
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
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
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        *-- Botao Cancelar (Grupo_Salva.Cancelar: Top=5, Left=81)
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 81
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
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- Label Cidade (Say7: Top=148, Left=314, compensado +29 = 177)
        loc_oPagina.AddObject("lbl_4c_Cidade", "Label")
        WITH loc_oPagina.lbl_4c_Cidade
            .Caption   = "Cidade :"
            .Top       = 177
            .Left      = 314
            .Width     = 55
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Cidade (GetCidade: Top=145, Left=359, Width=220, compensado +29 = 174)
        *-- ControlSource legado: crSigCdFrt.cidas | Format="K!" (uppercase)
        loc_oPagina.AddObject("txt_4c_Cidade", "TextBox")
        WITH loc_oPagina.txt_4c_Cidade
            .Value         = ""
            .Top           = 174
            .Left          = 359
            .Width         = 220
            .Height        = 25
            .MaxLength     = 30
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .ReadOnly      = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Cidade, "KeyPress", THIS, "ValidarCidade")

        *-- Label Valor do Frete (Say2: Top=176, Left=279, Height=15, Width=77, compensado +29 = 205)
        loc_oPagina.AddObject("lbl_4c_ValorFrete", "Label")
        WITH loc_oPagina.lbl_4c_ValorFrete
            .Caption   = "Valor do Frete :"
            .Top       = 205
            .Left      = 279
            .Width     = 77
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Valor do Frete (get_Frete: Top=171+29=200, Left=359, Width=100, Height=25)
        *-- Habilitado apenas em INCLUIR e ALTERAR (get_Frete.When do legado)
        loc_oPagina.AddObject("txt_4c_Frete", "TextBox")
        WITH loc_oPagina.txt_4c_Frete
            .Value         = 0
            .Top           = 200
            .Left          = 359
            .Width         = 100
            .Height        = 25
            .InputMask     = "999,999.99"
            .MaxLength     = 10
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .ReadOnly      = .F.
            .Visible       = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * CarregarTmpCep - Carrega cursor TmpCep com cidades do banco de dados
    * Substitui: poDataMg2.SqlExecute + CREATE CURSOR TmpCep do legado
    * Exibir btnAguarde durante carga (fidelidade UX ao legado)
    *===========================================================================
    PROTECTED PROCEDURE CarregarTmpCep()
        LOCAL loc_nResult, loc_oPagina

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            IF USED("TmpCep")
                USE IN TmpCep
            ENDIF

            *-- Exibir indicador de progresso (equivalente ao btnAguarde do legado)
            IF VARTYPE(loc_oPagina) = "O" AND ;
               PEMSTATUS(loc_oPagina, "cmd_4c_BtnAguarde", 5)
                loc_oPagina.cmd_4c_BtnAguarde.Visible = .T.
                THIS.Refresh()
            ENDIF

            *-- Tentar carregar cidades do banco Cep
            SET NULL ON
            CREATE CURSOR TmpCep (Cidades C(30))
            SET NULL OFF

            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT DISTINCT Cidades FROM Cep ORDER BY Cidades", ;
                "cursor_4c_TmpCepLoad")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_TmpCepLoad") > 0
                SELECT cursor_4c_TmpCepLoad
                SCAN
                    INSERT INTO TmpCep VALUES (ALLTRIM(cursor_4c_TmpCepLoad.Cidades))
                ENDSCAN
            ENDIF

            IF USED("cursor_4c_TmpCepLoad")
                USE IN cursor_4c_TmpCepLoad
            ENDIF

            *-- Indexar para busca rapida no lookup de GetCidade
            IF USED("TmpCep") AND RECCOUNT("TmpCep") > 0
                SELECT TmpCep
                INDEX ON Cidades TAG Cidades
            ENDIF

        CATCH TO loException
            *-- Em caso de falha, garantir cursor vazio (sem bloquear abertura do form)
            IF !USED("TmpCep")
                CREATE CURSOR TmpCep (Cidades C(30))
            ENDIF
            IF USED("cursor_4c_TmpCepLoad")
                USE IN cursor_4c_TmpCepLoad
            ENDIF
        ENDTRY

        *-- Ocultar indicador de progresso
        IF VARTYPE(loc_oPagina) = "O" AND ;
           PEMSTATUS(loc_oPagina, "cmd_4c_BtnAguarde", 5)
            loc_oPagina.cmd_4c_BtnAguarde.Visible = .F.
        ENDIF
    ENDPROC

    *===========================================================================
    * CarregarLista - Carrega dados no grid da Page1 via FreBO.Buscar()
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                IF VARTYPE(THIS.this_oBusinessObject) = "O"
                    IF THIS.this_oBusinessObject.Buscar("")
                        loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                        loc_oGrid.ColumnCount = 2
                        loc_oGrid.RecordSource          = "cursor_4c_Dados"
                        loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cidas"
                        loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.valors"
                        *-- Redefinir headers apos RecordSource (auto-bind os sobrescreve)
                        loc_oGrid.Column1.Header1.Caption = "Cidade"
                        loc_oGrid.Column1.Width           = 400
                        loc_oGrid.Column2.Header1.Caption = "Valor do Frete"
                        loc_oGrid.Column2.Width           = 120
                        loc_oGrid.Column2.Alignment       = 1
                        THIS.FormatarGridLista(loc_oGrid)
                        loc_lResultado = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormFre.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    *===========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP
        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oObjeto) = "O"
                IF INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_CABECALHO", "CNT_4C_BOTOESACAO")
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                    LOOP
                ENDIF
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF
                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *===========================================================================
    * FormatarGridLista - Formata visual do grid (fonte Verdana, igual ao legado)
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *===========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *===========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina
                IF par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                    THIS.CarregarLista()
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormFre.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere valores dos campos do Form para as propriedades do BO
    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPag2
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2

        TRY
            THIS.this_oBusinessObject.this_cCidade = ALLTRIM(loc_oPag2.txt_4c_Cidade.Value)
            THIS.this_oBusinessObject.this_nFrete  = loc_oPag2.txt_4c_Frete.Value
        CATCH TO loException
            MostrarErro(loException, "FormFre.FormParaBO")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere propriedades do BO para os campos do Form
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPag2
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oPag2.txt_4c_Cidade.Value = ALLTRIM(THIS.this_oBusinessObject.this_cCidade)
            loc_oPag2.txt_4c_Frete.Value  = THIS.this_oBusinessObject.this_nFrete
        CATCH TO loException
            MostrarErro(loException, "FormFre.BOParaForm")
        ENDTRY
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa todos os campos editaveis da Page2
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPag2
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oPag2.txt_4c_Cidade.Value = ""
            loc_oPag2.txt_4c_Frete.Value  = 0
        CATCH TO loException
            MostrarErro(loException, "FormFre.LimparCampos")
        ENDTRY
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita/desabilita campos conforme o modo atual
    *   Cidade:  editavel apenas em INCLUIR (e PK, nao altera em ALTERAR)
    *   Frete:   editavel em INCLUIR e ALTERAR (nao em VISUALIZAR)
    *   Confirmar: sempre habilitado (age como navegacao em VISUALIZAR)
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPag2, loc_lHabFrete
        loc_oPag2     = THIS.pgf_4c_Paginas.Page2
        loc_lHabFrete = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        TRY
            IF PEMSTATUS(loc_oPag2, "txt_4c_Cidade", 5)
                *-- Cidade editavel apenas em INCLUIR (e PK nao pode ser alterada)
                loc_oPag2.txt_4c_Cidade.ReadOnly = (THIS.this_cModoAtual != "INCLUIR")
            ENDIF

            IF PEMSTATUS(loc_oPag2, "txt_4c_Frete", 5)
                *-- Frete editavel em INCLUIR e ALTERAR, somente leitura em VISUALIZAR
                loc_oPag2.txt_4c_Frete.ReadOnly = !loc_lHabFrete
            ENDIF

            IF PEMSTATUS(loc_oPag2, "cnt_4c_BotoesAcao", 5)
                IF PEMSTATUS(loc_oPag2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                    *-- Confirmar sempre habilitado (em VISUALIZAR navega de volta para lista)
                    loc_oPag2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
                ENDIF
                IF PEMSTATUS(loc_oPag2.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
                    loc_oPag2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormFre.HabilitarCampos")
        ENDTRY
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Ajusta caption/estado dos botoes de acao conforme modo
    *   INCLUIR/ALTERAR: Confirmar = "Confirmar" (salva)
    *   VISUALIZAR:      Confirmar = "OK" (apenas navega de volta)
    *===========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPag2
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF PEMSTATUS(loc_oPag2, "cnt_4c_BotoesAcao", 5) AND ;
               PEMSTATUS(loc_oPag2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                IF THIS.this_cModoAtual = "VISUALIZAR"
                    loc_oPag2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Caption = "OK"
                ELSE
                    loc_oPag2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Caption = "Confirmar"
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormFre.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Prepara form para incluir novo registro
    * Legado: pcEscolha='INSERIR', GetCidade.SetFocus
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            IF PEMSTATUS(THIS, "LimparCampos", 5)
                THIS.LimparCampos()
            ENDIF
            THIS.this_cModoAtual = "INCLUIR"
            IF PEMSTATUS(THIS, "HabilitarCampos", 5)
                THIS.HabilitarCampos(.T.)
            ENDIF
            IF PEMSTATUS(THIS, "AjustarBotoesPorModo", 5)
                THIS.AjustarBotoesPorModo()
            ENDIF
            THIS.pgf_4c_Paginas.ActivePage = 2
            *-- Foco no campo Cidade (legado: GetCidade.SetFocus no INSERIR)
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Cidade", 5)
                THIS.pgf_4c_Paginas.Page2.txt_4c_Cidade.SetFocus()
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormFre.BtnIncluirClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Carrega registro selecionado em modo somente leitura
    * Legado: pcEscolha='PROCURAR', Grupo_salva.Salva.setfocus
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Nenhum registro selecionado.", "Visualizar")
            ELSE
                SELECT cursor_4c_Dados
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.cidas)

                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    THIS.this_cModoAtual = "VISUALIZAR"
                    IF PEMSTATUS(THIS, "BOParaForm", 5)
                        THIS.BOParaForm()
                    ENDIF
                    IF PEMSTATUS(THIS, "HabilitarCampos", 5)
                        THIS.HabilitarCampos(.F.)
                    ENDIF
                    IF PEMSTATUS(THIS, "AjustarBotoesPorModo", 5)
                        THIS.AjustarBotoesPorModo()
                    ENDIF
                    THIS.pgf_4c_Paginas.ActivePage = 2
                    *-- Foco no botao Confirmar (legado: Grupo_salva.Salva.setfocus)
                    IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "cnt_4c_BotoesAcao", 5) AND ;
                       PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
                        THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormFre.BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Carrega registro selecionado para alteracao
    * Legado: pcEscolha='ALTERAR', Get_Frete.SetFocus
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Nenhum registro selecionado.", "Alterar")
            ELSE
                SELECT cursor_4c_Dados
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.cidas)

                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    THIS.this_oBusinessObject.EditarRegistro()
                    THIS.this_cModoAtual = "ALTERAR"
                    IF PEMSTATUS(THIS, "BOParaForm", 5)
                        THIS.BOParaForm()
                    ENDIF
                    IF PEMSTATUS(THIS, "HabilitarCampos", 5)
                        THIS.HabilitarCampos(.T.)
                    ENDIF
                    IF PEMSTATUS(THIS, "AjustarBotoesPorModo", 5)
                        THIS.AjustarBotoesPorModo()
                    ENDIF
                    THIS.pgf_4c_Paginas.ActivePage = 2
                    *-- Foco no campo Frete (legado: Get_Frete.SetFocus no ALTERAR)
                    IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Frete", 5)
                        THIS.pgf_4c_Paginas.Page2.txt_4c_Frete.SetFocus()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormFre.BtnAlterarClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Confirma e exclui registro selecionado
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_cCidade
        loc_cCodigo = ""
        loc_cCidade = ""

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Nenhum registro selecionado.", "Excluir")
            ELSE
                SELECT cursor_4c_Dados
                loc_cCidade = ALLTRIM(cursor_4c_Dados.cidas)
                loc_cCodigo = loc_cCidade

                IF MsgConfirma("Excluir o frete da cidade " + CHR(34) + loc_cCidade + CHR(34) + "?", ;
                    "Confirmar Exclus" + CHR(227) + "o")
                    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                        IF THIS.this_oBusinessObject.Excluir()
                            MsgInfo("Frete exclu" + CHR(237) + "do com sucesso.", "Sucesso")
                            THIS.CarregarLista()
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormFre.BtnExcluirClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Filtra registros por cidade (INPUTBOX simples)
    * Legado: poDataMgr.AddCursor com filtro em Cidas
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_cFiltro, loc_oGrid
        loc_cFiltro = ""

        TRY
            loc_cFiltro = ALLTRIM(INPUTBOX("Buscar cidade:", "Busca de Fretes", ""))
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                    loc_oGrid.ColumnCount = 2
                    loc_oGrid.RecordSource          = "cursor_4c_Dados"
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cidas"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.valors"
                    *-- Redefinir headers apos RecordSource
                    loc_oGrid.Column1.Header1.Caption = "Cidade"
                    loc_oGrid.Column1.Width           = 400
                    loc_oGrid.Column2.Header1.Caption = "Valor do Frete"
                    loc_oGrid.Column2.Width           = 120
                    loc_oGrid.Column2.Alignment       = 1
                    THIS.FormatarGridLista(loc_oGrid)
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormFre.BtnBuscarClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    * Legado (Destroy): reabilita this_oParentForm.Enabled = .T.
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        TRY
            THIS.Release()
        CATCH TO loException
            MostrarErro(loException, "FormFre.BtnEncerrarClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * Destroy - Libera recursos e reabilita form pai
    *===========================================================================
    PROCEDURE Destroy()
        TRY
            *-- Reabilitar form pai (PROCEDURE Release do legado: oForm.Enabled = .T.)
            IF VARTYPE(THIS.this_oParentForm) = "O"
                THIS.this_oParentForm.Enabled = .T.
                THIS.this_oParentForm         = .NULL.
            ENDIF

            *-- Liberar BO
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF

            *-- Liberar cursor TmpCep (criado no CarregarTmpCep)
            IF USED("TmpCep")
                USE IN TmpCep
            ENDIF

        CATCH TO loException
            MostrarErro(loException, "FormFre.Destroy")
        ENDTRY

        DODEFAULT()
    ENDPROC

    *===========================================================================
    * ValidarCidade - Abre picker de cidades ao sair do campo txt_4c_Cidade
    * Legado: GetCidade.Valid - fwBuscaSel em TmpCep cursor local
    *===========================================================================
    PROCEDURE ValidarCidade
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        LOCAL loc_cCidade, loc_oBusca, loc_oPag2
        loc_cCidade = ""
        loc_oPag2   = THIS.pgf_4c_Paginas.Page2

        TRY
            IF !PEMSTATUS(loc_oPag2, "txt_4c_Cidade", 5)
                RETURN
            ENDIF

            loc_cCidade = ALLTRIM(loc_oPag2.txt_4c_Cidade.Value)

            IF EMPTY(loc_cCidade) OR !USED("TmpCep") OR RECCOUNT("TmpCep") = 0
                RETURN
            ENDIF

            *-- Lookup em TmpCep pre-carregado (FormBuscaAuxiliar Modo 2 - cursor local)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.this_cCursorDestino = "TmpCep"
                loc_oBusca.this_cTitulo        = "Cadastro de Cidades"
                loc_oBusca.mAddColuna("Cidades", "", "Cidade")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("TmpCep")
                    loc_oPag2.txt_4c_Cidade.Value = ALLTRIM(TmpCep.Cidades)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormFre.ValidarCidade")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Valida e salva o registro (INCLUIR/ALTERAR)
    * Legado: Grupo_Salva.Salva.Click
    *   - INSERIR: valida Cidade obrigatoria; valida Frete>0 (modo global)
    *   - ALTERAR: valida Frete>0 (modo global)
    *   - VISUALIZAR: apenas volta para lista
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPag2, loc_cCidade, loc_nFrete, loc_lSalvou
        loc_cCidade = ""
        loc_nFrete  = 0
        loc_lSalvou = .F.

        *-- VISUALIZAR: apenas retornar para lista sem salvar
        IF THIS.this_cModoAtual = "VISUALIZAR"
            THIS.AlternarPagina(1)
            RETURN
        ENDIF

        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF

        loc_oPag2 = THIS.pgf_4c_Paginas.Page2

        *-- Validacoes antes do TRY (CLAUDE.md Problema 16)
        *-- INCLUIR: Cidade e obrigatoria
        IF THIS.this_cModoAtual = "INCLUIR" AND PEMSTATUS(loc_oPag2, "txt_4c_Cidade", 5)
            loc_cCidade = ALLTRIM(loc_oPag2.txt_4c_Cidade.Value)
            IF EMPTY(loc_cCidade)
                MsgAviso("Cidade Inv" + CHR(225) + "lida!!!", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                loc_oPag2.txt_4c_Cidade.SetFocus()
                RETURN
            ENDIF
        ENDIF

        *-- Frete obrigatorio em modo global (pDopes vazio)
        IF PEMSTATUS(loc_oPag2, "txt_4c_Frete", 5)
            loc_nFrete = loc_oPag2.txt_4c_Frete.Value
        ENDIF
        IF EMPTY(THIS.this_oBusinessObject.this_cDopes) AND loc_nFrete <= 0
            MsgAviso("Valor do Frete Inv" + CHR(225) + "lido.", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            IF PEMSTATUS(loc_oPag2, "txt_4c_Frete", 5)
                loc_oPag2.txt_4c_Frete.SetFocus()
            ENDIF
            RETURN
        ENDIF

        TRY
            THIS.FormParaBO()
            loc_lSalvou = THIS.this_oBusinessObject.Salvar()
            IF loc_lSalvou
                MsgInfo("Frete salvo com sucesso.", "Sucesso")
                THIS.CarregarLista()
                THIS.AlternarPagina(1)
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormFre.BtnSalvarClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancela edicao e retorna para lista
    * Legado: Grupo_Salva.Cancelar.Click -> DoDefault() + mAtivapagina1
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        TRY
            THIS.this_cModoAtual = "LISTA"
            THIS.CarregarLista()
            THIS.AlternarPagina(1)
        CATCH TO loException
            MostrarErro(loException, "FormFre.BtnCancelarClick")
        ENDTRY
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\FreBO.prg):
*==============================================================================
* FreBO.prg - Business Object: Fretes por Cidade
*==============================================================================
* Tabelas:
*   SigCdFrt  - modo global (this_cDopes vazio): PK = cidas
*   SigOpFrt  - modo operacional (this_cDopes preenchido): chave composta cidas+dopes
*==============================================================================

DEFINE CLASS FreBO AS BusinessBase

    *-- Campos compartilhados (SigCdFrt e SigOpFrt)
    this_cCidade     = ""   && cidas       CHAR(30)       - nome da cidade
    this_nFrete      = 0    && valors      NUMERIC(11,2)  - valor do frete

    *-- Campos exclusivos modo operacional (SigOpFrt)
    this_cDopes      = ""   && dopes       CHAR(20)       - tipo de operacao (vazio = modo global)

    *===========================================================================
    * Init - Inicializa BO no modo global (SigCdFrt / PK = cidas)
    *        Para modo operacional: setar this_cDopes apos Init()
    *===========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdFrt"
            THIS.this_cCampoChave = "cidas"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "FreBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *   Ambos os modos: cidas (cidade)
    *===========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidade)
    ENDFUNC

    *===========================================================================
    * Buscar - Lista registros no cursor cursor_4c_Dados
    *   par_cFiltro: filtro opcional em cidas (LIKE)
    *===========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cDopes)
                *-- Modo global: SigCdFrt
                IF EMPTY(par_cFiltro)
                    loc_cSQL = "SELECT cidas, valors FROM SigCdFrt ORDER BY cidas"
                ELSE
                    loc_cSQL = "SELECT cidas, valors FROM SigCdFrt" + ;
                        " WHERE cidas LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
                        " ORDER BY cidas"
                ENDIF
            ELSE
                *-- Modo operacional: SigOpFrt filtrado por dopes
                IF EMPTY(par_cFiltro)
                    loc_cSQL = "SELECT cidas, dopes, valors FROM SigOpFrt" + ;
                        " WHERE dopes = " + EscaparSQL(THIS.this_cDopes) + ;
                        " ORDER BY cidas"
                ELSE
                    loc_cSQL = "SELECT cidas, dopes, valors FROM SigOpFrt" + ;
                        " WHERE dopes = " + EscaparSQL(THIS.this_cDopes) + ;
                        " AND cidas LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
                        " ORDER BY cidas"
                ENDIF
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar fretes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FreBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *===========================================================================
    * CarregarPorCodigo - Carrega registro por cidas no cursor cursor_4c_Carrega
    *   Modo global:      WHERE cidas = par_cCodigo
    *   Modo operacional: WHERE cidas = par_cCodigo AND dopes = this_cDopes
    *===========================================================================
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cDopes)
                loc_cSQL = "SELECT cidas, valors FROM SigCdFrt" + ;
                    " WHERE cidas = " + EscaparSQL(par_cCodigo)
            ELSE
                loc_cSQL = "SELECT cidas, dopes, valors FROM SigOpFrt" + ;
                    " WHERE cidas = " + EscaparSQL(par_cCodigo) + ;
                    " AND dopes = " + EscaparSQL(THIS.this_cDopes)
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FreBO.CarregarPorCodigo")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *===========================================================================
    * CarregarDoCursor - Mapeia cursor para propriedades do BO
    *===========================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidade = TratarNulo(cidas, "C")
                THIS.this_nFrete  = TratarNulo(valors, "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FreBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *===========================================================================
    * Inserir - INSERT em SigCdFrt (global) ou SigOpFrt (operacional) [PROTECTED]
    *===========================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cDopes)
                *-- Modo global: INSERT em SigCdFrt
                loc_cSQL = "INSERT INTO SigCdFrt (cidas, valors) VALUES (" + ;
                    EscaparSQL(THIS.this_cCidade) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nFrete) + ")"
            ELSE
                *-- Modo operacional: INSERT em SigOpFrt com chave composta cidas+dopes
                loc_cSQL = "INSERT INTO SigOpFrt (cidas, dopes, valors) VALUES (" + ;
                    EscaparSQL(THIS.this_cCidade) + ", " + ;
                    EscaparSQL(THIS.this_cDopes) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nFrete) + ")"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir frete:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FreBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *===========================================================================
    * Atualizar - UPDATE em SigCdFrt (global) ou SigOpFrt (operacional) [PROTECTED]
    *===========================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cDopes)
                *-- Modo global: UPDATE SigCdFrt por cidas (PK nao alteravel, so valors)
                loc_cSQL = "UPDATE SigCdFrt SET" + ;
                    " valors = " + FormatarNumeroSQL(THIS.this_nFrete) + ;
                    " WHERE cidas = " + EscaparSQL(THIS.this_cCidade)
            ELSE
                *-- Modo operacional: UPDATE SigOpFrt pela chave composta cidas+dopes
                loc_cSQL = "UPDATE SigOpFrt SET" + ;
                    " valors = " + FormatarNumeroSQL(THIS.this_nFrete) + ;
                    " WHERE cidas = " + EscaparSQL(THIS.this_cCidade) + ;
                    " AND dopes = " + EscaparSQL(THIS.this_cDopes)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar frete:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FreBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *===========================================================================
    * ExecutarExclusao - DELETE em SigCdFrt (global) ou SigOpFrt (operacional) [PROTECTED]
    *===========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cDopes)
                loc_cSQL = "DELETE FROM SigCdFrt WHERE cidas = " + EscaparSQL(THIS.this_cCidade)
            ELSE
                loc_cSQL = "DELETE FROM SigOpFrt" + ;
                    " WHERE cidas = " + EscaparSQL(THIS.this_cCidade) + ;
                    " AND dopes = " + EscaparSQL(THIS.this_cDopes)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir frete:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FreBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

