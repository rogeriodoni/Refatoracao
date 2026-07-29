# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 78% < 100%. Falhas: Teste 'ModoIncluir': Property ALTERNARPAGINA is not found. | Detalhes: Linha: 412; Teste 'ModoVisualizar': Property AJUSTARBOTOESPORMODO is not found. | Detalhes: Linha: 542

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-29 04:45:05] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-29 04:45:05] [INFO] Config FPW: (nao fornecido)
[2026-07-29 04:45:05] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-29 04:45:05] [INFO] Timeout: 300 segundos
[2026-07-29 04:45:05] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_esxlcqly.prg
[2026-07-29 04:45:05] [INFO] Conteudo do wrapper:
[2026-07-29 04:45:05] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formcmp', 'C:\4c\tasks\task373', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formcmp', 'C:\4c\tasks\task373', 'CRUD'
QUIT

[2026-07-29 04:45:05] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_esxlcqly.prg
[2026-07-29 04:45:05] [INFO] VFP output esperado em: C:\4c\tasks\task373\vfp_output.txt
[2026-07-29 04:45:05] [INFO] Executando Visual FoxPro 9...
[2026-07-29 04:45:05] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_esxlcqly.prg
[2026-07-29 04:45:05] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_esxlcqly.prg
[2026-07-29 04:45:05] [INFO] Timeout configurado: 300 segundos
[2026-07-29 04:45:46] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-29 04:45:46] [INFO] VFP9 finalizado em 40.7107601 segundos
[2026-07-29 04:45:46] [INFO] Exit Code: 
[2026-07-29 04:45:46] [INFO] 
[2026-07-29 04:45:46] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-29 04:45:46] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_esxlcqly.prg
[2026-07-29 04:45:46] [INFO] 
[2026-07-29 04:45:46] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-29 04:45:46] [INFO] * Auto-generated wrapper for parameters
[2026-07-29 04:45:46] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-29 04:45:46] [INFO] * Parameters: 'Formcmp', 'C:\4c\tasks\task373', 'CRUD'
[2026-07-29 04:45:46] [INFO] 
[2026-07-29 04:45:46] [INFO] * Anti-dialog protections for unattended execution
[2026-07-29 04:45:46] [INFO] SET SAFETY OFF
[2026-07-29 04:45:46] [INFO] SET RESOURCE OFF
[2026-07-29 04:45:46] [INFO] SET TALK OFF
[2026-07-29 04:45:46] [INFO] SET NOTIFY OFF
[2026-07-29 04:45:46] [INFO] SYS(2335, 0)
[2026-07-29 04:45:46] [INFO] 
[2026-07-29 04:45:46] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formcmp', 'C:\4c\tasks\task373', 'CRUD'
[2026-07-29 04:45:46] [INFO] QUIT
[2026-07-29 04:45:46] [INFO] 
[2026-07-29 04:45:46] [INFO] === Fim do Wrapper.prg ===
[2026-07-29 04:45:46] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formcmp",
  "timestamp": "20260729044546",
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
      "detalhes": "0 registros em cursor_4c_Dados"
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
    "passou": 7,
    "falhou": 2,
    "percentual": 78
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

### FORM (C:\4c\projeto\app\forms\cadastros\Formcmp.prg):
*------------------------------------------------------------------------------
* Formcmp.prg - Formulario de Cadastro de Compra Para
* Tabela: SigCdCmp | PK: cods
* Fase 3/8: Estrutura Base + Completa
*------------------------------------------------------------------------------

DEFINE CLASS Formcmp AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Compra Para"
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

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = DODEFAULT()
        CATCH TO loException
            MostrarErro(loException, "Formcmp.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configura estrutura completa do formulario
    * Chamado pelo FormBase.Init() - NAO chamar diretamente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Criar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("cmpBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar cmpBO", "Erro")
            ELSE
                *-- Configurar PageFrame com 2 paginas e containers base
                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                *-- Carregar dados iniciais (pula se validando UI sem conexao SQL)
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                *-- Estado inicial
                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual           = "LISTA"

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "Formcmp.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * e os containers base de cada pagina
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPg1, loc_oPg2

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
            ENDWITH

            loc_oPg1 = THIS.pgf_4c_Paginas.Page1
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            WITH loc_oPg1
                .Caption   = "Lista"
                .Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
                .BackColor = RGB(240, 240, 240)
            ENDWITH

            WITH loc_oPg2
                .Caption   = "Dados"
                .Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
                .BackColor = RGB(240, 240, 240)
            ENDWITH

            *-- Containers estruturais da Page1
            THIS.ConfigurarContainersPage1(loc_oPg1)

            *-- Containers estruturais da Page2
            THIS.ConfigurarContainersPage2(loc_oPg2)

        CATCH TO loException
            MostrarErro(loException, "Formcmp.ConfigurarPageFrame")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainersPage1 - Cria containers base da Page1 (Lista)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainersPage1(par_oPagina)

        TRY
            *-- Container cabecalho (cntSombra no legado)
            *-- Top = 2 + 29 (compensacao PageFrame.Top=-29)
            par_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
            WITH par_oPagina.cnt_4c_Cabecalho
                .Top         = 31
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BackColor   = RGB(100, 100, 100)
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

            par_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
            WITH par_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
                .Caption   = THIS.Caption
                .Top       = 15
                .Left      = 10
                .Width     = 769
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            par_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
            WITH par_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
                .Caption   = THIS.Caption
                .Top       = 18
                .Left      = 10
                .Width     = 769
                .Height    = 46
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            *-- Container botoes CRUD (Grupo_op no legado)
            *-- Grupo_op.Left=342 no original, Left=542 canonico para form 1000px
            *-- Top = -1 + 29 (compensacao) = 28, usar canonico 29
            par_oPagina.AddObject("cnt_4c_Botoes", "Container")
            WITH par_oPagina.cnt_4c_Botoes
                .Top         = 29
                .Left        = 542
                .Width       = 390
                .Height      = 85
                .BackStyle   = 0
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

            *-- Container saida - PADRAO CANONICO (prevalece sobre PILAR 1)
            *-- Left=917, Width=90 canonico (CLAUDE.md regra #10)
            par_oPagina.AddObject("cnt_4c_Saida", "Container")
            WITH par_oPagina.cnt_4c_Saida
                .Top         = 29
                .Left        = 917
                .Width       = 90
                .Height      = 85
                .BackStyle   = 0
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

        CATCH TO loException
            MostrarErro(loException, "Formcmp.ConfigurarContainersPage1")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainersPage2 - Cria containers base da Page2 (Dados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainersPage2(par_oPagina)

        TRY
            *-- Container botoes salvar/cancelar (Grupo_Salva no legado)
            *-- Grupo_Salva.Top=17 + 29 = 46, Left=611 (original)
            par_oPagina.AddObject("cnt_4c_Salva", "Container")
            WITH par_oPagina.cnt_4c_Salva
                .Top         = 46
                .Left        = 611
                .Width       = 160
                .Height      = 85
                .BackStyle = 1
                .BackColor = RGB(255, 255, 255)
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

        CATCH TO loException
            MostrarErro(loException, "Formcmp.ConfigurarContainersPage2")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Adiciona botoes CRUD, Encerrar e Grid na Page1
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
            loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Botao Incluir
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
                .AutoSize        = .F.
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
                .Visible         = .T.
            ENDWITH
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

            *-- Botao Alterar
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
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

            *-- Botao Excluir
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
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

            *-- Botao Buscar (procurar no legado)
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
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

            *-- Botao Encerrar (PADRAO CANONICO: cnt_4c_Saida, Width=75, Caption="Encerrar")
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
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH
            BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

            *-- Cursor placeholder com mesmos campos de cursor_4c_Dados retornado por Buscar()
            SET NULL ON
            CREATE CURSOR cursor_4c_Dados (cods C(10), descs C(60))
            SET NULL OFF

            *-- Grid de lista
            *-- Top = 117 (canonico: 88+29), Left = 12
            loc_oPagina.AddObject("grd_4c_Lista", "Grid")
            WITH loc_oPagina.grd_4c_Lista
                .Top                = 117
                .Left               = 12
                .Width              = 937
                .Height             = 470
                .FontName           = "Verdana"
                .FontSize           = 8
                .ForeColor          = RGB(90, 90, 90)
                .BackColor          = RGB(255, 255, 255)
                .GridLineColor      = RGB(238, 238, 238)
                .GridLines          = 3
                .HighlightBackColor = RGB(255, 255, 255)
                .HighlightForeColor = RGB(15, 41, 104)
                .HighlightStyle     = 2
                .DeleteMark         = .F.
                .RecordMark         = .F.
                .RowHeight          = 16
                .ScrollBars         = 2
                .Visible            = .T.
            ENDWITH

            *-- RecordSource e ColumnCount FORA do WITH (evita "Unknown member COLUMN1")
            loc_oPagina.grd_4c_Lista.ColumnCount  = 2
            loc_oPagina.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
            loc_oPagina.grd_4c_Lista.ColumnCount  = 2

            *-- ControlSources APOS RecordSource (evita auto-bind por ordem de campos)
            WITH loc_oPagina.grd_4c_Lista
                .Column1.ControlSource   = "cursor_4c_Dados.cods"
                .Column1.Width           = 90
                .Column1.Header1.Caption = "C" + CHR(243) + "digo"

                .Column2.ControlSource   = "cursor_4c_Dados.descs"
                .Column2.Width           = 337
                .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            ENDWITH

            THIS.FormatarGridLista(loc_oPagina.grd_4c_Lista)
            THIS.TornarControlesVisiveis(loc_oPagina)

        CATCH TO loException
            MostrarErro(loException, "Formcmp.ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Adiciona botoes Confirmar/Cancelar e campos na Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2

            *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
            loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Botao Confirmar (Salvar) em cnt_4c_Salva
            loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
            WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
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
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH
            BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

            *-- Botao Cancelar em cnt_4c_Salva
            loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
            WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
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
                .Visible         = .T.
            ENDWITH
            BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

            *-- Campo 1: Codigo (Get_codigo)
            *-- Say1: Top=124+29=153, Left=215, ForeColor=90,90,90
            loc_oPagina.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oPagina.lbl_4c_Label1
                .Caption   = "C" + CHR(243) + "digo :"
                .Top       = 153
                .Left      = 215
                .Height    = 17
                .Width     = 45
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Alignment = 1
                .Visible   = .T.
            ENDWITH

            *-- Get_codigo: Top=121+29=150, Left=263, Width=84, Height=23
            loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
            WITH loc_oPagina.txt_4c_Codigo
                .Value         = ""
                .Top           = 150
                .Left          = 263
                .Width         = 84
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .SpecialEffect = 1
                .Visible       = .T.
            ENDWITH

            *-- Campo 2: Descricao (Get_desc)
            *-- Say2: Top=149+29=178, Left=202, ForeColor=90,90,90
            loc_oPagina.AddObject("lbl_4c_Label2", "Label")
            WITH loc_oPagina.lbl_4c_Label2
                .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
                .Top       = 178
                .Left      = 202
                .Height    = 17
                .Width     = 58
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Alignment = 1
                .Visible   = .T.
            ENDWITH

            *-- Get_desc: Top=146+29=175, Left=263, Width=240, Height=23
            loc_oPagina.AddObject("txt_4c_Desc", "TextBox")
            WITH loc_oPagina.txt_4c_Desc
                .Value         = ""
                .Top           = 175
                .Left          = 263
                .Width         = 240
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .SpecialEffect = 1
                .Visible       = .T.
            ENDWITH

            THIS.TornarControlesVisiveis(loc_oPagina)

        CATCH TO loException
            MostrarErro(loException, "Formcmp.ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega dados no Grid da Page1
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        *-- Pula se validando UI sem conexao SQL (RETURN fora do TRY - Regra 1)
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

            IF !THIS.this_oBusinessObject.Buscar("")
                loc_lResultado = .F.
            ELSE
                *-- Reconectar ControlSources apos ZAP+APPEND (evita reset de headers)
                WITH loc_oGrid
                    .Column1.ControlSource   = "cursor_4c_Dados.cods"
                    .Column1.Width           = 90
                    .Column1.Header1.Caption = "C" + CHR(243) + "digo"

                    .Column2.ControlSource   = "cursor_4c_Dados.descs"
                    .Column2.Width           = 337
                    .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                ENDWITH

                loc_oGrid.Refresh()
                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MostrarErro(loException, "Formcmp.CarregarLista")
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

        *-- Validacao FORA do TRY (Regra 1: nunca RETURN dentro de TRY/CATCH)
        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.this_cModoAtual = "LISTA"
                THIS.CarregarLista()
            ENDIF

            loc_lResultado = .T.

        CATCH TO loException
            MostrarErro(loException, "Formcmp.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores do Form para o BO antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.this_cCodigo    = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
        THIS.this_oBusinessObject.this_cDescricao = ALLTRIM(loc_oPg2.txt_4c_Desc.Value)
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere valores do BO para o Form apos carregar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_Codigo.Value = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
        loc_oPg2.txt_4c_Desc.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cDescricao)
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa valores dos campos da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_Codigo.Value = ""
        loc_oPg2.txt_4c_Desc.Value   = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos editaveis
    * txt_4c_Codigo: apenas em INCLUIR (no legado Get_codigo.When retorna .F. em ALTERAR)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Codigo apenas habilitado em INCLUIR (readonly em ALTERAR/VISUALIZAR)
        loc_oPg2.txt_4c_Codigo.Enabled = par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR"
        loc_oPg2.txt_4c_Desc.Enabled   = par_lHabilitar

        *-- Botoes de acao
        IF VARTYPE(loc_oPg2.cnt_4c_Salva) = "O"
            loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = par_lHabilitar
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme o modo atual
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg1, loc_oPg2, loc_lEdicao
        loc_oPg1   = THIS.pgf_4c_Paginas.Page1
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        *-- Botoes Page1 desabilitados enquanto estiver em edicao
        IF VARTYPE(loc_oPg1.cnt_4c_Botoes) = "O"
            WITH loc_oPg1.cnt_4c_Botoes
                .cmd_4c_Incluir.Enabled    = !loc_lEdicao
                .cmd_4c_Visualizar.Enabled = !loc_lEdicao
                .cmd_4c_Alterar.Enabled    = !loc_lEdicao
                .cmd_4c_Excluir.Enabled    = !loc_lEdicao
                .cmd_4c_Buscar.Enabled     = !loc_lEdicao
                .Visible     = .T.
            ENDWITH
        ENDIF

        *-- Confirmar habilitado apenas em edicao
        IF VARTYPE(loc_oPg2.cnt_4c_Salva) = "O"
            loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = loc_lEdicao
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * EVENTOS CRUD - Page1
    *--------------------------------------------------------------------------

    PROCEDURE BtnIncluirClick()
        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.LimparCampos()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
            *-- Foco no codigo (INSERIR: Get_Codigo.SetFocus no legado)
            IF VARTYPE(THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo) = "O"
                THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.SetFocus()
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "Formcmp.BtnIncluirClick")
        ENDTRY
    ENDPROC

    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        *-- Validacao FORA do TRY (Regra 1: nunca RETURN dentro de TRY/CATCH)
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um registro para visualizar.")
            RETURN
        ENDIF

        TRY
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)

            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                THIS.BOParaForm()
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.HabilitarCampos(.F.)
                THIS.AlternarPagina(2)
                *-- Foco no Confirmar (Salva.SetFocus no legado - modo consulta)
                IF VARTYPE(THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva) = "O"
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva.cmd_4c_Confirmar.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "Formcmp.BtnVisualizarClick")
        ENDTRY
    ENDPROC

    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        *-- Validacao FORA do TRY (Regra 1: nunca RETURN dentro de TRY/CATCH)
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um registro para alterar.")
            RETURN
        ENDIF

        TRY
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)

            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.BOParaForm()
                THIS.this_cModoAtual = "ALTERAR"
                THIS.HabilitarCampos(.T.)
                THIS.AlternarPagina(2)
                *-- Foco na descricao (ALTERAR: Get_Desc.SetFocus no legado)
                IF VARTYPE(THIS.pgf_4c_Paginas.Page2.txt_4c_Desc) = "O"
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Desc.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "Formcmp.BtnAlterarClick")
        ENDTRY
    ENDPROC

    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        *-- Validacoes FORA do TRY (Regra 1: nunca RETURN dentro de TRY/CATCH)
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um registro para excluir.")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro '" + loc_cCodigo + "'?", ;
                        "Excluir Compra Para")
            RETURN
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "Formcmp.BtnExcluirClick")
        ENDTRY
    ENDPROC

    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cFiltro
        loc_cFiltro = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCmp", "cursor_4c_BuscaCmp", "cods", "", ;
                "Buscar Compra Para")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCmp")
                    SELECT cursor_4c_BuscaCmp
                    loc_cFiltro = "cods = " + EscaparSQL(ALLTRIM(cursor_4c_BuscaCmp.cods))
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaCmp")
                USE IN cursor_4c_BuscaCmp
            ENDIF

            IF !EMPTY(loc_cFiltro)
                THIS.this_oBusinessObject.Buscar(loc_cFiltro)
                THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
            ENDIF

        CATCH TO loException
            MostrarErro(loException, "Formcmp.BtnBuscarClick")
        ENDTRY
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        TRY
            THIS.Release()
        CATCH TO loException
            MostrarErro(loException, "Formcmp.BtnEncerrarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * EVENTOS Page2
    *--------------------------------------------------------------------------

    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPg2, loc_cCodigo, loc_cDescricao

        *-- Validacoes FORA do TRY (evita problema de RETURN dentro de TRY)
        loc_oPg2      = THIS.pgf_4c_Paginas.Page2
        loc_cCodigo   = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
        loc_cDescricao = ALLTRIM(loc_oPg2.txt_4c_Desc.Value)

        IF EMPTY(loc_cCodigo)
            MsgAviso("C" + CHR(243) + "digo inv" + CHR(225) + "lido!")
            loc_oPg2.txt_4c_Codigo.SetFocus()
            RETURN
        ENDIF

        IF EMPTY(loc_cDescricao)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o obrigat" + CHR(243) + "ria!")
            loc_oPg2.txt_4c_Desc.SetFocus()
            RETURN
        ENDIF

        TRY
            THIS.FormParaBO()

            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Registro salvo com sucesso!")
                THIS.AlternarPagina(1)
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "Formcmp.BtnSalvarClick")
        ENDTRY
    ENDPROC

    PROCEDURE BtnCancelarClick()
        TRY
            THIS.LimparCampos()
            THIS.AlternarPagina(1)
        CATCH TO loException
            MostrarErro(loException, "Formcmp.BtnCancelarClick")
        ENDTRY
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
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
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
    * Destroy - Libera recursos ao fechar o formulario
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF USED("cursor_4c_BuscaCmp")
                USE IN cursor_4c_BuscaCmp
            ENDIF

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "Formcmp.Destroy")
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\cmpBO.prg):
*==============================================================================
* cmpBO.prg - Business Object para Compra Para
* Data: 2026-07-29
* Tabela: SigCdCmp | PK: cods
*==============================================================================

DEFINE CLASS cmpBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento com campos da tabela SigCdCmp)
    this_cCodigo    = ""    && cods       CHAR - C" + CHR(243) + "digo (PK)
    this_cDescricao = ""    && descs      CHAR - Descri" + CHR(231) + CHR(227) + "o
    this_cIdChaves  = ""    && cIdChaves  CHAR - Chave " + CHR(250) + "nica UUID

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdCmp"
        THIS.this_cCampoChave = "cods"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigo    = TratarNulo(cods,      "C")
                THIS.this_cDescricao = TratarNulo(descs,     "C")
                THIS.this_cIdChaves  = TratarNulo(cIdChaves, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "cmpBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida campos obrigatorios antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido, loc_nResultado, loc_cSQL
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cCodigo))
            MsgAviso("C" + CHR(243) + "digo obrigat" + CHR(243) + "rio!")
            loc_lValido = .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cDescricao))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o obrigat" + CHR(243) + "ria!")
            loc_lValido = .F.
        ENDIF

        *-- Verificar duplicidade apenas em novo registro
        IF loc_lValido AND THIS.this_lNovoRegistro
            loc_cSQL = "SELECT cods FROM SigCdCmp WHERE cods = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkDup")
            IF loc_nResultado >= 0
                IF USED("cursor_4c_ChkDup") AND RECCOUNT("cursor_4c_ChkDup") > 0
                    MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!")
                    loc_lValido = .F.
                ENDIF
                IF USED("cursor_4c_ChkDup")
                    USE IN cursor_4c_ChkDup
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigCdCmp
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cIdChaves
        loc_lSucesso = .F.

        TRY
            loc_cIdChaves = ALLTRIM(fUniqueIds())

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdCmp (cods, descs, cIdChaves)
                VALUES (
                    <<EscaparSQL(THIS.this_cCodigo)>>,
                    <<EscaparSQL(THIS.this_cDescricao)>>,
                    <<EscaparSQL(loc_cIdChaves)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.this_cIdChaves = loc_cIdChaves
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir compra para:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "cmpBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigCdCmp
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdCmp
                SET descs = <<EscaparSQL(THIS.this_cDescricao)>>
                WHERE cods = <<EscaparSQL(THIS.this_cCodigo)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar compra para:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "cmpBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigCdCmp
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                DELETE FROM SigCdCmp WHERE cods = <<EscaparSQL(THIS.this_cCodigo)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir compra para:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "cmpBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com cods, descs
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Sem conexao: criar cursor vazio para nao bloquear o grid
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (cods C(10), descs C(60))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ENDIF

            loc_cSQL = "SELECT cods, descs FROM SigCdCmp"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY cods"

            *-- Protecao de grid: se cursor ja esta aberto (grid vinculado), usar ZAP+APPEND
            IF USED("cursor_4c_Dados")
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                IF loc_nResultado >= 0
                    SELECT cursor_4c_Dados
                    ZAP
                    APPEND FROM DBF("cursor_4c_DadosTmp")
                    IF USED("cursor_4c_DadosTmp")
                        USE IN cursor_4c_DadosTmp
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar compra para:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar compra para:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "cmpBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT cods, descs, cIdChaves
                FROM SigCdCmp
                WHERE cods = <<EscaparSQL(par_cCodigo)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Compra Para n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar compra para:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "cmpBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

