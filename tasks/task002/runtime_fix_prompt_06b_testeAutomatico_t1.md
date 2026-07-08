# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 40% < 100%. Falhas: Teste 'CarregarLista': Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc); Teste 'ModoIncluir': Property ALTERNARPAGINA is not found. | Detalhes: Linha: 408; Teste 'ModoVisualizar': Property AJUSTARBOTOESPORMODO is not found. | Detalhes: Linha: 538

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-03-30 20:35:19] [INFO] === VFP EXECUTOR v2.0 ===
[2026-03-30 20:35:19] [INFO] Config FPW: (nao fornecido)
[2026-03-30 20:35:19] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-03-30 20:35:19] [INFO] Timeout: 300 segundos
[2026-03-30 20:35:19] [INFO] Wrapper PRG criado para parametros: C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_wqnfygpo.prg
[2026-03-30 20:35:19] [INFO] Conteudo do wrapper:
[2026-03-30 20:35:19] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormDepartamento', 'C:\4c\tasks\task002', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormDepartamento', 'C:\4c\tasks\task002', 'CRUD'
QUIT

[2026-03-30 20:35:19] [INFO] Comando VFP: C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_wqnfygpo.prg
[2026-03-30 20:35:19] [INFO] VFP output esperado em: C:\4c\tasks\task002\vfp_output.txt
[2026-03-30 20:35:19] [INFO] Executando Visual FoxPro 9...
[2026-03-30 20:35:19] [INFO] Comando completo: VFP9.EXE -T C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_wqnfygpo.prg
[2026-03-30 20:35:19] [INFO] Executando: VFP9.EXE -T C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_wqnfygpo.prg
[2026-03-30 20:35:19] [INFO] Timeout configurado: 300 segundos
[2026-03-30 20:35:20] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-03-30 20:35:20] [INFO] VFP9 finalizado em 1.4327665 segundos
[2026-03-30 20:35:20] [INFO] Exit Code: 
[2026-03-30 20:35:20] [INFO] 
[2026-03-30 20:35:20] [INFO] Arquivos temporarios preservados para inspecao:
[2026-03-30 20:35:20] [INFO]   Wrapper.prg: C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_wqnfygpo.prg
[2026-03-30 20:35:20] [INFO] 
[2026-03-30 20:35:20] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-03-30 20:35:20] [INFO] * Auto-generated wrapper for parameters
[2026-03-30 20:35:20] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-03-30 20:35:20] [INFO] * Parameters: 'FormDepartamento', 'C:\4c\tasks\task002', 'CRUD'
[2026-03-30 20:35:20] [INFO] 
[2026-03-30 20:35:20] [INFO] * Anti-dialog protections for unattended execution
[2026-03-30 20:35:20] [INFO] SET SAFETY OFF
[2026-03-30 20:35:20] [INFO] SET RESOURCE OFF
[2026-03-30 20:35:21] [INFO] SET TALK OFF
[2026-03-30 20:35:21] [INFO] SET NOTIFY OFF
[2026-03-30 20:35:21] [INFO] SYS(2335, 0)
[2026-03-30 20:35:21] [INFO] 
[2026-03-30 20:35:21] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormDepartamento', 'C:\4c\tasks\task002', 'CRUD'
[2026-03-30 20:35:21] [INFO] QUIT
[2026-03-30 20:35:21] [INFO] 
[2026-03-30 20:35:21] [INFO] === Fim do Wrapper.prg ===
[2026-03-30 20:35:21] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormDepartamento",
  "timestamp": "20260330203520",
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
      "detalhes": "Linha: 408"
    },
    {
      "nome": "ModoVisualizar",
      "passou": false,
      "erro": "Property AJUSTARBOTOESPORMODO is not found.",
      "detalhes": "Linha: 538"
    },
    {
      "nome": "Fechar",
      "passou": true,
      "erro": "",
      "detalhes": "Formulario fechado com sucesso"
    }
  ],
  "resumo": {
    "total": 5,
    "passou": 2,
    "falhou": 3,
    "percentual": 40
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormDepartamento.prg):
*==============================================================================
* FormDepartamento.prg - Formulario de Cadastro de Departamentos
* Data: 2026-03-30
* Tabela: SigCdDpt | PK: codigos
* Legado: SIGCDDPT.SCX (frmcadastro)
*==============================================================================

DEFINE CLASS FormDepartamento AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Departamentos"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    TitleBar    = 0
    ClipControls = .F.
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades do formulario
    this_oBusinessObject = .NULL.
    this_cMensagemErro   = ""    && OBRIGATORIO - nao herdado de FormBase

    *--------------------------------------------------------------------------
    * Init - Inicializacao do formulario
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        *-- DODEFAULT() ja chama InicializarForm() atraves do FormBase.Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configuracao inicial do formulario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Criar instancia do Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("DepartamentoBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar Business Object DepartamentoBO", ;
                            "Erro Cr" + CHR(237) + "tico")
                loc_lSucesso = .F.
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Pula CarregarLista() se estiver validando UI (sem conexao SQL)
                IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    IF !THIS.CarregarLista()
                        *-- Se falhar ao carregar, nao impede abertura
                    ENDIF
                ENDIF

                THIS.pgf_4c_Paginas.Visible   = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormDepartamento:" + CHR(13) + ;
                        "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                        loException.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Configura o PageFrame principal
    * PageFrame.Top=-29 oculta abas; controles compensam +29 no Top
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .Top       = -29
            .Left      = 0
            .Width     = 1003
            .Height    = 600
            .PageCount = 2
            .Tabs      = .F.
            .Visible   = .T.

            *-- Page1 - Lista
            .Page1.Caption   = "Lista"
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)

            *-- Page2 - Dados
            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura Page1 (Lista)
    * Compensacao PageFrame.Top=-29: todos os controles Top += 29
    * Grade: 3 colunas do legado (codigos, Descricaos, Diretors)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Container cabecalho escuro (Top_original=0 -> 29 com compensacao)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 29
            .Left        = 0
            .Width       = 1020
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(53, 53, 53)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = "Cadastro de Departamentos"
            .Top       = 20
            .Left      = 20
            .Width     = 450
            .Height    = 30
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        *-- Container botoes CRUD (Top=29 com compensacao, alinhado a direita)
        *-- 6 botoes x ~72px cada = 432px; container Width=450
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 450
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir (F2)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 65
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Botao Visualizar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 77
            .Width           = 65
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Botao Alterar (F3)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 149
            .Width           = 65
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Botao Excluir (F4)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 221
            .Width           = 65
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Botao Buscar (F5)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 293
            .Width           = 65
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Botao Encerrar (ESC)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 375
            .Width           = 65
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grade de lista (legado: 3 colunas codigos/Descricaos/Diretors)
        *-- Top_original=83 + 29 = 112 com compensacao do PageFrame
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top         = 112
            .Left        = 30
            .Width       = 941
            .Height      = 455
            .GridLines   = 3
            .RowHeight   = 18
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ColumnCount = -1
            .RecordMark  = .F.
            .DeleteMark  = .F.
            .Visible     = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2 (Dados)
    * Compensacao PageFrame.Top=-29: todos os controles Top += 29
    * Posicoes originais do legado + 29px (compensacao do PageFrame)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Container cabecalho escuro (igual ao da Page1)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 29
            .Left        = 0
            .Width       = 1020
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(53, 53, 53)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = "Cadastro de Departamentos"
            .Top       = 20
            .Left      = 20
            .Width     = 450
            .Height    = 30
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        *-- Container botoes de acao (Salvar/Cancelar)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 29
            .Left        = 542
            .Width       = 145
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Salvar (F10)
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Salvar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar
            .Caption         = "Salvar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 65
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")

        *-- Botao Cancelar (ESC)
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Caption         = "Cancelar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 75
            .Width           = 65
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *======================================================================
        * CAMPOS - Primeira metade (Codigo, Descricao, Diretor)
        * Posicao original do legado + 29px compensacao PageFrame
        *======================================================================

        *-- Label "Codigo :" (original Top=158 -> 187 com compensacao)
        loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
        WITH loc_oPagina.lbl_4c_Codigo
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 187
            .Left      = 377
            .Width     = 42
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo (original Top=152 -> 181, Left=421, Width=80)
        loc_oPagina.AddObject("txt_4c_Codigos", "TextBox")
        WITH loc_oPagina.txt_4c_Codigos
            .Value         = ""
            .Top           = 181
            .Left          = 421
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .MaxLength     = 10
            .InputMask     = ""
            .SpecialEffect = 0
            .Enabled       = .T.
            .Visible       = .T.
        ENDWITH

        *-- Label "Descricao :" (original Top=181 -> 210 com compensacao)
        loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
        WITH loc_oPagina.lbl_4c_Descricao
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 210
            .Left      = 364
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Descricao (original Top=177 -> 206, Left=421, Width=290, Height=23)
        loc_oPagina.AddObject("txt_4c_Descricaos", "TextBox")
        WITH loc_oPagina.txt_4c_Descricaos
            .Value         = ""
            .Top           = 206
            .Left          = 421
            .Width         = 290
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .MaxLength     = 40
            .InputMask     = ""
            .SpecialEffect = 0
            .Enabled       = .T.
            .Visible       = .T.
        ENDWITH

        *-- Label "Diretor :" (original Top=206 -> 235 com compensacao)
        loc_oPagina.AddObject("lbl_4c_Diretor", "Label")
        WITH loc_oPagina.lbl_4c_Diretor
            .Caption   = "Diretor :"
            .Top       = 235
            .Left      = 377
            .Width     = 42
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Diretores (original Top=202 -> 231, Left=421, Width=80, Height=23)
        *-- Tem lookup F4: SigCdUsu (Usuarios=codigo, NComps=nome)
        loc_oPagina.AddObject("txt_4c_Diretores", "TextBox")
        WITH loc_oPagina.txt_4c_Diretores
            .Value         = ""
            .Top           = 231
            .Left          = 421
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .MaxLength     = 10
            .InputMask     = ""
            .SpecialEffect = 0
            .Enabled       = .T.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Diretores, "KeyPress", THIS, "DiretoresKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Diretores, "DblClick", THIS, "DiretoresDblClick")

        *-- Label "Obriga Subclas. Encerramento :" (original Top=231 -> 260 com compensacao)
        loc_oPagina.AddObject("lbl_4c_Subclas", "Label")
        WITH loc_oPagina.lbl_4c_Subclas
            .Caption   = "Obriga Subclas. Encerramento :"
            .Top       = 260
            .Left      = 265
            .Width     = 154
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup nchksubs (original Top=228 -> 257, Left=416, Width=109, ButtonCount=2)
        loc_oPagina.AddObject("opt_4c_Subclas", "OptionGroup")
        WITH loc_oPagina.opt_4c_Subclas
            .ButtonCount = 2
            .Top         = 257
            .Left        = 421
            .Width       = 109
            .Height      = 24
            .BorderStyle = 0
            .Value       = 2
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_Subclas.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 3
            .Width     = 42
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.opt_4c_Subclas.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 55
            .Top       = 3
            .Width     = 42
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- Label "Tipo :" (original Top=249 -> 278 com compensacao)
        loc_oPagina.AddObject("lbl_4c_Tipo", "Label")
        WITH loc_oPagina.lbl_4c_Tipo
            .Caption   = "Tipo :"
            .Top       = 278
            .Left      = 390
            .Width     = 29
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup nchktipos (original Top=246 -> 275, Left=416, Width=109, ButtonCount=2)
        loc_oPagina.AddObject("opt_4c_Tipos", "OptionGroup")
        WITH loc_oPagina.opt_4c_Tipos
            .ButtonCount = 2
            .Top         = 275
            .Left        = 421
            .Width       = 109
            .Height      = 24
            .BorderStyle = 0
            .Value       = 2
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_Tipos.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 3
            .Width     = 42
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.opt_4c_Tipos.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 55
            .Top       = 3
            .Width     = 42
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- Label "Automatico:" (original Top=267 -> 296 com compensacao)
        loc_oPagina.AddObject("lbl_4c_Autos", "Label")
        WITH loc_oPagina.lbl_4c_Autos
            .Caption   = "Autom" + CHR(225) + "tico:"
            .Top       = 296
            .Left      = 359
            .Width     = 60
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup autos (original Top=264 -> 293, Left=416, Width=109, ButtonCount=2)
        *-- optAutos.Value=2 no INSERIR (legado: OptAutos.Value=2 quando pcEscolha='INSERIR')
        loc_oPagina.AddObject("opt_4c_Autos", "OptionGroup")
        WITH loc_oPagina.opt_4c_Autos
            .ButtonCount = 2
            .Top         = 293
            .Left        = 421
            .Width       = 109
            .Height      = 24
            .BorderStyle = 0
            .Value       = 2
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_Autos.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 3
            .Width     = 42
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.opt_4c_Autos.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 55
            .Top       = 3
            .Width     = 42
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega dados no Grid da Page1
    * Colunas do legado: codigos(80), Descricaos(290), Diretors(80)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                IF THIS.this_oBusinessObject.Buscar("")
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                    *-- RecordSource e ColumnCount FORA de WITH (Problema 36)
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.ColumnCount  = 3

                    *-- Configurar colunas APOS RecordSource (Problema 48/32)
                    WITH loc_oGrid
                        .Column1.ControlSource   = "cursor_4c_Dados.codigos"
                        .Column1.Width           = 80
                        .Column1.Header1.Caption = "C" + CHR(243) + "digo"
                        .Column1.Alignment       = 2

                        .Column2.ControlSource   = "cursor_4c_Dados.descricaos"
                        .Column2.Width           = 290
                        .Column2.Header1.Caption = "Departamento"
                        .Column2.Alignment       = 0

                        .Column3.ControlSource   = "cursor_4c_Dados.diretors"
                        .Column3.Width           = 80
                        .Column3.Header1.Caption = "Diretor"
                        .Column3.Alignment       = 0
                    ENDWITH

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ELSE
                    loc_lResultado = .F.
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro em CarregarLista:" + CHR(13) + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (1=Lista) e Page2 (2=Dados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.CarregarLista()
            ENDIF

            loc_lResultado = .T.

        CATCH TO loException
            MostrarErro("Erro em AlternarPagina:" + CHR(13) + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Novo registro: prepara BO, limpa campos, vai p/ Page2
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Carrega registro selecionado em modo somente leitura
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro na lista.", "Visualizar")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.BOParaForm()
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.pgf_4c_Paginas.ActivePage = 2
        ELSE
            MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Visualizar")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Carrega registro selecionado para edicao
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro na lista.", "Alterar")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.BOParaForm()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.pgf_4c_Paginas.ActivePage = 2
        ELSE
            MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Alterar")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Confirma e exclui o registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_lConfirma
        loc_cCodigo  = ""
        loc_lConfirma = .F.

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um registro na lista.", "Excluir")
            RETURN
        ENDIF

        loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro " + ;
                                    CHR(34) + loc_cCodigo + CHR(34) + "?", ;
                                    "Confirmar Exclus" + CHR(227) + "o")
        IF !loc_lConfirma
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            IF THIS.this_oBusinessObject.Excluir()
                MsgSucesso("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso")
                THIS.CarregarLista()
            ENDIF
        ELSE
            MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Excluir")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Recarrega a lista (equivalente ao Procurar do legado)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Salvar registro (Inserir ou Atualizar)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        IF !THIS.ValidarCampos()
            RETURN
        ENDIF

        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgSucesso("Registro salvo com sucesso!", "Sucesso")
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Descarta edicao e volta para a lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores do Form para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.this_cCodigo    = ALLTRIM(loc_oPg2.txt_4c_Codigos.Value)
        THIS.this_oBusinessObject.this_cDescricao = ALLTRIM(loc_oPg2.txt_4c_Descricaos.Value)
        THIS.this_oBusinessObject.this_cDiretor   = ALLTRIM(loc_oPg2.txt_4c_Diretores.Value)
        *-- OptionGroups: Value=1 -> Sim (DB=1), Value=2 -> Nao (DB=0)
        THIS.this_oBusinessObject.this_nChkSubs  = IIF(loc_oPg2.opt_4c_Subclas.Value = 1, 1, 0)
        THIS.this_oBusinessObject.this_nChkTipos = IIF(loc_oPg2.opt_4c_Tipos.Value  = 1, 1, 0)
        THIS.this_oBusinessObject.this_nAutos    = IIF(loc_oPg2.opt_4c_Autos.Value  = 1, 1, 0)
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere valores do BO para o Form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_Codigos.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
        loc_oPg2.txt_4c_Descricaos.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescricao)
        loc_oPg2.txt_4c_Diretores.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cDiretor)
        *-- OptionGroups: DB=1 -> Sim (Value=1), DB=0 -> Nao (Value=2)
        loc_oPg2.opt_4c_Subclas.Value = IIF(THIS.this_oBusinessObject.this_nChkSubs  = 1, 1, 2)
        loc_oPg2.opt_4c_Tipos.Value   = IIF(THIS.this_oBusinessObject.this_nChkTipos = 1, 1, 2)
        loc_oPg2.opt_4c_Autos.Value   = IIF(THIS.this_oBusinessObject.this_nAutos    = 1, 1, 2)
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa valores dos campos da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_Codigos.Value    = ""
        loc_oPg2.txt_4c_Descricaos.Value = ""
        loc_oPg2.txt_4c_Diretores.Value  = ""
        *-- OptionGroups: resetar para Nao (Value=2) como padrao (legado: OptAutos.Value=2 no INSERIR)
        loc_oPg2.opt_4c_Subclas.Value = 2
        loc_oPg2.opt_4c_Tipos.Value   = 2
        loc_oPg2.opt_4c_Autos.Value   = 2
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos conforme modo e par_lHabilitar
    * Codigo: editavel apenas em INCLUIR (When = INSERIR/PROCURAR no legado)
    * Descricao/Diretor: editaveis em INCLUIR e ALTERAR
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_lCodigoEdit
        loc_oPg2       = THIS.pgf_4c_Paginas.Page2
        loc_lCodigoEdit = par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")

        loc_oPg2.txt_4c_Codigos.Enabled    = loc_lCodigoEdit
        loc_oPg2.txt_4c_Descricaos.Enabled = par_lHabilitar
        loc_oPg2.txt_4c_Diretores.Enabled  = par_lHabilitar
        loc_oPg2.opt_4c_Subclas.Enabled    = par_lHabilitar
        loc_oPg2.opt_4c_Tipos.Enabled      = par_lHabilitar
        loc_oPg2.opt_4c_Autos.Enabled      = par_lHabilitar
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCampos - Valida campos obrigatorios antes de salvar
    * codigos e descricaos sao obrigatorios (validacao do legado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarCampos()
        LOCAL loc_oPg2, loc_lValido
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Codigos.Value))
            MsgAviso("O C" + CHR(243) + "digo precisa ser Informado...", "Valida" + CHR(231) + CHR(227) + "o")
            loc_oPg2.txt_4c_Codigos.SetFocus
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(loc_oPg2.txt_4c_Descricaos.Value))
            MsgAviso("A Descri" + CHR(231) + CHR(227) + "o precisa ser Informada...", "Valida" + CHR(231) + CHR(227) + "o")
            loc_oPg2.txt_4c_Descricaos.SetFocus
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oBotoesAcao, loc_lEmEdicao
        loc_oBotoesAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
        loc_lEmEdicao   = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        *-- Salvar: habilitado apenas em INCLUIR e ALTERAR
        IF PEMSTATUS(loc_oBotoesAcao, "cmd_4c_Salvar", 5)
            loc_oBotoesAcao.cmd_4c_Salvar.Enabled = loc_lEmEdicao
        ENDIF

        *-- Cancelar: sempre habilitado em Page2
        IF PEMSTATUS(loc_oBotoesAcao, "cmd_4c_Cancelar", 5)
            loc_oBotoesAcao.cmd_4c_Cancelar.Enabled = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
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

                *-- Trata containers com ControlCount
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Formata visual do grid da lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * DiretoresKeyPress - Handler de KeyPress para txt_4c_Diretores
    * F4 (nKeyCode=63) abre lookup de usuarios (SigCdUsu)
    *--------------------------------------------------------------------------
    PROCEDURE DiretoresKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 63
            THIS.AbrirLookupDiretor()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DiretoresDblClick - Handler de DblClick para txt_4c_Diretores
    *--------------------------------------------------------------------------
    PROCEDURE DiretoresDblClick()
        THIS.AbrirLookupDiretor()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupDiretor - Abre FormBuscaAuxiliar para selecionar diretor
    * Tabela: SigCdUsu | Codigo: Usuarios | Descricao: NComps
    * Filtro: Not cAtivos='N' (somente usuarios ativos)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupDiretor()
        LOCAL loc_oBusca, loc_cValorAtual, loc_oPg2
        loc_oPg2       = THIS.pgf_4c_Paginas.Page2
        loc_cValorAtual = ALLTRIM(loc_oPg2.txt_4c_Diretores.Value)
        loc_oBusca     = .NULL.

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdUsu", "cursor_4c_BuscaDiretor", "Usuarios", loc_cValorAtual, ;
                "Sele" + CHR(231) + CHR(227) + "o", .T., .F., "Not cAtivos='N'")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    *-- Registro exato encontrado, usa direto
                    IF USED("cursor_4c_BuscaDiretor")
                        SELECT cursor_4c_BuscaDiretor
                        loc_oPg2.txt_4c_Diretores.Value = ALLTRIM(cursor_4c_BuscaDiretor.Usuarios)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    *-- Nao encontrou exato, mostrar grid para selecao
                    loc_oBusca.mAddColuna("Usuarios", "", "Diretor")
                    loc_oBusca.mAddColuna("NComps",   "", "Nome")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDiretor")
                        SELECT cursor_4c_BuscaDiretor
                        loc_oPg2.txt_4c_Diretores.Value = ALLTRIM(cursor_4c_BuscaDiretor.Usuarios)
                    ENDIF
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro no lookup de Diretor:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaDiretor")
            USE IN cursor_4c_BuscaDiretor
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Liberacao de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND ;
           !ISNULL(THIS.this_oBusinessObject)
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\DepartamentoBO.prg):
*==============================================================================
* DepartamentoBO.prg - Business Object para Cadastro de Departamentos
* Tabela: SigCdDpt
* Herda de: BusinessBase
*==============================================================================
DEFINE CLASS DepartamentoBO AS BusinessBase

    *-- Propriedades da tabela SigCdDpt
    this_cCodigo    = ""    && codigos   char(10)
    this_cDescricao = ""    && descricaos char(40)
    this_cDiretor   = ""    && diretors  char(10)
    this_nChkSubs   = 0     && nchksubs  numeric(1,0) - Obriga Subclas. Encerramento
    this_nChkTipos  = 0     && nchktipos numeric(1,0) - Tipo
    this_nAutos     = 0     && autos     numeric(1,0) - Automatico

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO configurando tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdDpt"
        THIS.this_cCampoChave = "codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros na tabela SigCdDpt
    * par_cFiltro: filtro adicional WHERE (opcional)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_cFiltro) != "C"
            par_cFiltro = ""
        ENDIF

        TRY
            loc_cSQL = "SELECT codigos, Descricaos, Diretors, nChkSubs, nChkTipos, autos" + ;
                       " FROM SigCdDpt"
            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY codigos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar departamentos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pelo codigo
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, Descricaos, Diretors, nChkSubs, nChkTipos, autos" + ;
                       " FROM SigCdDpt" + ;
                       " WHERE codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Departamento n" + CHR(227) + "o encontrado!", "Busca")
                ENDIF
                USE IN cursor_4c_Carrega
            ELSE
                MsgErro("Erro ao carregar departamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo    = TratarNulo(codigos,    "C")
            THIS.this_cDescricao = TratarNulo(Descricaos, "C")
            THIS.this_cDiretor   = TratarNulo(Diretors,   "C")
            THIS.this_nChkSubs   = TratarNulo(nChkSubs,   "N")
            THIS.this_nChkTipos  = TratarNulo(nChkTipos,  "N")
            THIS.this_nAutos     = TratarNulo(autos,       "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigCdDpt
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_cSQLCheck, loc_nResultado, loc_lSucesso, loc_nExiste, loc_lAbortou
        loc_lSucesso = .F.
        loc_lAbortou = .F.

        TRY
            *-- Verificar se codigo ja existe
            loc_cSQLCheck = "SELECT COUNT(*) AS nExiste FROM SigCdDpt WHERE codigos = " + ;
                            EscaparSQL(ALLTRIM(THIS.this_cCodigo))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQLCheck, "cursor_4c_ChkCod")
            IF loc_nResultado >= 0
                SELECT cursor_4c_ChkCod
                loc_nExiste = cursor_4c_ChkCod.nExiste
                USE IN cursor_4c_ChkCod
                IF loc_nExiste > 0
                    MsgAviso("C" + CHR(243) + "digo do Departamento j" + CHR(225) + " Cadastrado!", "Aviso")
                    loc_lAbortou = .T.
                ENDIF
            ENDIF

            *-- Se autos=1, verificar se ja existe outro registro automatico
            IF !loc_lAbortou AND THIS.this_nAutos = 1
                loc_cSQLCheck = "SELECT COUNT(*) AS nExiste FROM SigCdDpt" + ;
                                " WHERE autos = 1 AND codigos <> " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQLCheck, "cursor_4c_ChkAuto")
                IF loc_nResultado >= 0
                    SELECT cursor_4c_ChkAuto
                    loc_nExiste = cursor_4c_ChkAuto.nExiste
                    USE IN cursor_4c_ChkAuto
                    IF loc_nExiste > 0
                        MsgAviso("J" + CHR(225) + " existe registro com c" + CHR(243) + "digo autom" + CHR(225) + "tico!", "Aviso")
                        loc_lAbortou = .T.
                    ENDIF
                ENDIF
            ENDIF

            IF !loc_lAbortou
                loc_cSQL = "INSERT INTO SigCdDpt (codigos, Descricaos, Diretors, nChkSubs, nChkTipos, autos)" + ;
                           " VALUES (" + ;
                           EscaparSQL(ALLTRIM(THIS.this_cCodigo))    + ", " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cDescricao)) + ", " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cDiretor))   + ", " + ;
                           FormatarNumeroSQL(THIS.this_nChkSubs)     + ", " + ;
                           FormatarNumeroSQL(THIS.this_nChkTipos)    + ", " + ;
                           FormatarNumeroSQL(THIS.this_nAutos)       + ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao inserir departamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigCdDpt
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_cSQLCheck, loc_nResultado, loc_lSucesso, loc_nExiste, loc_lAbortou
        loc_lSucesso = .F.
        loc_lAbortou = .F.

        TRY
            *-- Se autos=1, verificar se ja existe outro registro automatico
            IF THIS.this_nAutos = 1
                loc_cSQLCheck = "SELECT COUNT(*) AS nExiste FROM SigCdDpt" + ;
                                " WHERE autos = 1 AND codigos <> " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQLCheck, "cursor_4c_ChkAuto")
                IF loc_nResultado >= 0
                    SELECT cursor_4c_ChkAuto
                    loc_nExiste = cursor_4c_ChkAuto.nExiste
                    USE IN cursor_4c_ChkAuto
                    IF loc_nExiste > 0
                        MsgAviso("J" + CHR(225) + " existe registro com c" + CHR(243) + "digo autom" + CHR(225) + "tico!", "Aviso")
                        loc_lAbortou = .T.
                    ENDIF
                ENDIF
            ENDIF

            IF !loc_lAbortou
                loc_cSQL = "UPDATE SigCdDpt SET" + ;
                           " Descricaos = " + EscaparSQL(ALLTRIM(THIS.this_cDescricao)) + "," + ;
                           " Diretors   = " + EscaparSQL(ALLTRIM(THIS.this_cDiretor))   + "," + ;
                           " nChkSubs   = " + FormatarNumeroSQL(THIS.this_nChkSubs)     + "," + ;
                           " nChkTipos  = " + FormatarNumeroSQL(THIS.this_nChkTipos)    + "," + ;
                           " autos      = " + FormatarNumeroSQL(THIS.this_nAutos)       + ;
                           " WHERE codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao atualizar departamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigCdDpt
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdDpt WHERE codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir departamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

