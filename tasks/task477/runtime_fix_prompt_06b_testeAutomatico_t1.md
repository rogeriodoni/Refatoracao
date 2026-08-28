# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 78% < 100%. Falhas: Teste 'CarregarLista': Property CARREGARLISTA is not found. | Detalhes: Linha: 350; Teste 'ModoVisualizar': Property AJUSTARBOTOESPORMODO is not found. | Detalhes: Linha: 559

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-22 01:45:06] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-22 01:45:06] [INFO] Config FPW: (nao fornecido)
[2026-08-22 01:45:06] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-22 01:45:06] [INFO] Timeout: 300 segundos
[2026-08-22 01:45:06] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_twmoh21u.prg
[2026-08-22 01:45:06] [INFO] Conteudo do wrapper:
[2026-08-22 01:45:06] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormOcb', 'C:\4c\tasks\task477', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormOcb', 'C:\4c\tasks\task477', 'CRUD'
QUIT

[2026-08-22 01:45:06] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_twmoh21u.prg
[2026-08-22 01:45:06] [INFO] VFP output esperado em: C:\4c\tasks\task477\vfp_output.txt
[2026-08-22 01:45:06] [INFO] Executando Visual FoxPro 9...
[2026-08-22 01:45:06] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_twmoh21u.prg
[2026-08-22 01:45:06] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_twmoh21u.prg
[2026-08-22 01:45:06] [INFO] Timeout configurado: 300 segundos
[2026-08-22 01:46:24] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-22 01:46:24] [INFO] VFP9 finalizado em 78.5504155 segundos
[2026-08-22 01:46:24] [INFO] Exit Code: 
[2026-08-22 01:46:24] [INFO] 
[2026-08-22 01:46:24] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-22 01:46:24] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_twmoh21u.prg
[2026-08-22 01:46:24] [INFO] 
[2026-08-22 01:46:24] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-22 01:46:24] [INFO] * Auto-generated wrapper for parameters
[2026-08-22 01:46:24] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-22 01:46:24] [INFO] * Parameters: 'FormOcb', 'C:\4c\tasks\task477', 'CRUD'
[2026-08-22 01:46:24] [INFO] 
[2026-08-22 01:46:24] [INFO] * Anti-dialog protections for unattended execution
[2026-08-22 01:46:24] [INFO] SET SAFETY OFF
[2026-08-22 01:46:24] [INFO] SET RESOURCE OFF
[2026-08-22 01:46:24] [INFO] SET TALK OFF
[2026-08-22 01:46:24] [INFO] SET NOTIFY OFF
[2026-08-22 01:46:24] [INFO] SYS(2335, 0)
[2026-08-22 01:46:24] [INFO] 
[2026-08-22 01:46:24] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormOcb', 'C:\4c\tasks\task477', 'CRUD'
[2026-08-22 01:46:24] [INFO] QUIT
[2026-08-22 01:46:24] [INFO] 
[2026-08-22 01:46:24] [INFO] === Fim do Wrapper.prg ===
[2026-08-22 01:46:24] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormOcb",
  "timestamp": "20260822014624",
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
      "erro": "Property CARREGARLISTA is not found.",
      "detalhes": "Linha: 350"
    },
    {
      "nome": "ModoIncluir",
      "passou": true,
      "erro": "",
      "detalhes": "Page2 ativada com sucesso"
    },
    {
      "nome": "ModoVisualizar",
      "passou": false,
      "erro": "Property AJUSTARBOTOESPORMODO is not found.",
      "detalhes": "Linha: 559"
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
      "detalhes": "AbrirLookup: 2 (ABRIRLOOKUPCANONICO, ABRIRLOOKUPGRCONTABIL) | KeyPress handlers: 2 (GRCONTABILLOOKUPKEYPRESS, KEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormOcb.prg):
*==============================================================================
* FormOcb.prg - Formulario de Cadastro de Ocorrencias do Balanco
* Migrado de: SigCdOcb.SCX (frmcadastro)
* Tabela: SigBaOco
*==============================================================================

DEFINE CLASS FormOcb AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Ocorr" + CHR(234) + "ncias do Balan" + CHR(231) + "o"
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

    *===========================================================================
    * Init - Inicializa o formulario
    * REGRA CRITICA: Apenas RETURN DODEFAULT()
    * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
    *===========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *===========================================================================
    * InicializarForm - Configura estrutura completa
    * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
    *===========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("OcbBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar OcbBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormOcb.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormOcb:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormOcb.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * Top=-29 para esconder abas; controles compensam +29 no Top
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
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)

            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaLista - Configura Page1 com cabecalho, botoes CRUD e grid
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (cntSombra no legado: Top=2+29=31)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
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

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
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

        *-- Container Botoes CRUD (Grupo_op no legado: Left=344, Top=-1+29=28)
        *-- Canonico: Left=542, Width=390
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 28
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Botao Buscar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container Saida/Encerrar (canonico: Left=917, Top=28, Width=90, Height=85)
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 28
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Encerrar
        loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
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
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de lista (framework: Top=88+29=117, Left=26, Width=890)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oPagina.grd_4c_Lista.ColumnCount = 9

        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 26
            .Width              = 890
            .Height             = 455
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

            .Column1.Width  = 35
            .Column2.Width  = 80
            .Column3.Width  = 285
            .Column4.Width  = 65
            .Column5.Width  = 65
            .Column6.Width  = 65
            .Column7.Width  = 65
            .Column8.Width  = 45
            .Column9.Width  = 90
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Configura Page2: botoes + primeira metade dos campos
    * Tops = valores originais (layout.json) + 29 (compensacao PageFrame.Top=-29)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container BotoesAcao - Salvar/Cancelar (Grupo_Salva no legado)
        *-- Canonico: Top=33 (4+29), Left=842, Width=160, Height=85
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Salvar (Confirmar)
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Salvar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
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
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")

        *-- Botao Cancelar
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
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
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- =====================================================================
        *-- CAMPOS - Primeira Metade (50%)
        *-- =====================================================================

        *-- Grupo 1: GetTipos (tipos char 1: O/J) - original Top=187 -> 187+29=216
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "Tipos (O/J) :"
            .Top       = 219
            .Left      = 222
            .Width     = 62
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Caption   = "< O >corr" + CHR(234) + "ncia  < J >ustificativa"
            .Top       = 219
            .Left      = 316
            .Width     = 161
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Tipos", "TextBox")
        WITH loc_oPagina.txt_4c_Tipos
            .Value     = ""
            .Top       = 216
            .Left      = 288
            .Width     = 17
            .Height    = 23
            .MaxLength = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Tipos, "KeyPress", THIS, "ValidarTipos")

        *-- Grupo 2: getCodigos (codigos char 10) - original Top=213 -> 213+29=242
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 245
            .Left      = 242
            .Width     = 42
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Codigos", "TextBox")
        WITH loc_oPagina.txt_4c_Codigos
            .Value     = ""
            .Top       = 242
            .Left      = 288
            .Width     = 80
            .Height    = 23
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Grupo 3: getDescrs (descrs char 40) - original Top=239 -> 239+29=268
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 271
            .Left      = 229
            .Width     = 55
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Descrs", "TextBox")
        WITH loc_oPagina.txt_4c_Descrs
            .Value     = ""
            .Top       = 268
            .Left      = 288
            .Width     = 290
            .Height    = 23
            .MaxLength = 40
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Grupo 4: Get_Apura (apuras char 1: S/N) - original Top=265 -> 265+29=294
        loc_oPagina.AddObject("lbl_4c_Label15", "Label")
        WITH loc_oPagina.lbl_4c_Label15
            .Caption   = "Apura" + CHR(231) + CHR(227) + "o :"
            .Top       = 297
            .Left      = 229
            .Width     = 55
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label14", "Label")
        WITH loc_oPagina.lbl_4c_Label14
            .Caption   = "<S>im  <N>" + CHR(227) + "o"
            .Top       = 298
            .Left      = 316
            .Width     = 75
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Apura", "TextBox")
        WITH loc_oPagina.txt_4c_Apura
            .Value     = ""
            .Top       = 294
            .Left      = 288
            .Width     = 17
            .Height    = 23
            .MaxLength = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Apura, "KeyPress", THIS, "ValidarApura")

        *-- =====================================================================
        *-- CAMPOS - Segunda Metade (50%) - Fase 6
        *-- =====================================================================

        *-- Grupo 5: Get_Lanca (lancas char 1: S/N) - original Top=291 -> 291+29=320
        loc_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPagina.lbl_4c_Label5
            .Caption   = "Lan" + CHR(231) + "a C/C :"
            .Top       = 323
            .Left      = 226
            .Width     = 58
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPagina.lbl_4c_Label8
            .Caption   = "<S>im  <N>" + CHR(227) + "o"
            .Top       = 324
            .Left      = 316
            .Width     = 75
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Lanca", "TextBox")
        WITH loc_oPagina.txt_4c_Lanca
            .Value     = ""
            .Top       = 320
            .Left      = 288
            .Width     = 17
            .Height    = 23
            .MaxLength = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Lanca, "KeyPress", THIS, "ValidarLanca")

        *-- Grupo 6: GetOper (opers char 2: DB/CR/DF/NL) - original Top=317 -> 317+29=346
        loc_oPagina.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPagina.lbl_4c_Label6
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
            .Top       = 349
            .Left      = 228
            .Width     = 56
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPagina.lbl_4c_Label7
            .Caption   = "<DB>D" + CHR(233) + "bito <CR>cr" + CHR(233) + ;
                         "dito <DF>Diferen" + CHR(231) + "a <NL>Nulo"
            .Top       = 349
            .Left      = 316
            .Width     = 258
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Oper", "TextBox")
        WITH loc_oPagina.txt_4c_Oper
            .Value     = ""
            .Top       = 346
            .Left      = 288
            .Width     = 27
            .Height    = 23
            .MaxLength = 2
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Oper, "KeyPress", THIS, "ValidarOper")

        *-- Grupo 7: GetGrContabil (grupos char 10) - original Top=343 -> 343+29=372 - LOOKUP SigCdGcr
        loc_oPagina.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oPagina.lbl_4c_Label9
            .Caption   = "Gr.Cont" + CHR(225) + "bil :"
            .Top       = 376
            .Left      = 221
            .Width     = 63
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_GrContabil", "TextBox")
        WITH loc_oPagina.txt_4c_GrContabil
            .Value     = ""
            .Top       = 372
            .Left      = 288
            .Width     = 80
            .Height    = 23
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_GrContabil, "KeyPress", THIS, "GrContabilLookupKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_GrContabil, "DblClick", THIS, "GrContabilLookupDblClick")
        BINDEVENT(loc_oPagina.txt_4c_GrContabil, "KeyPress",    THIS, "ValidarGrContabil")

        *-- Grupo 8: GetAutos (autos char 1: S/N) - original Top=369 -> 369+29=398
        loc_oPagina.AddObject("lbl_4c_Label10", "Label")
        WITH loc_oPagina.lbl_4c_Label10
            .Caption   = "Autom" + CHR(225) + "tico :"
            .Top       = 401
            .Left      = 221
            .Width     = 63
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label11", "Label")
        WITH loc_oPagina.lbl_4c_Label11
            .Caption   = "<S>im  <N>" + CHR(227) + "o"
            .Top       = 402
            .Left      = 316
            .Width     = 75
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Autos", "TextBox")
        WITH loc_oPagina.txt_4c_Autos
            .Value     = ""
            .Top       = 398
            .Left      = 288
            .Width     = 17
            .Height    = 23
            .MaxLength = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Autos, "KeyPress", THIS, "ValidarAutos")
        BINDEVENT(loc_oPagina.txt_4c_Autos, "KeyPress", THIS, "AutosLostFocus")

        *-- Grupo 9: GetOperac (operacaos char 1: E/S) - original Top=395 -> 395+29=424
        *-- When: habilitado apenas quando Autos = "S"
        loc_oPagina.AddObject("lbl_4c_Label12", "Label")
        WITH loc_oPagina.lbl_4c_Label12
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
            .Top       = 427
            .Left      = 228
            .Width     = 56
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label13", "Label")
        WITH loc_oPagina.lbl_4c_Label13
            .Caption   = "<E>ntrada  <S>a" + CHR(237) + "da"
            .Top       = 428
            .Left      = 316
            .Width     = 104
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Operac", "TextBox")
        WITH loc_oPagina.txt_4c_Operac
            .Value     = ""
            .Top       = 424
            .Left      = 288
            .Width     = 17
            .Height    = 23
            .MaxLength = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Operac, "KeyPress", THIS, "ValidarOperac")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * CarregarLista - Carrega dados no Grid da Page1
    *===========================================================================
    PROTECTED FUNCTION CarregarLista()
        LOCAL loc_lSucesso, loc_oGrid
        loc_lSucesso = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lSucesso = .T.
            ELSE
                IF THIS.this_oBusinessObject.Buscar("")
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                    loc_oGrid.ColumnCount = 9
                    loc_oGrid.RecordSource = "cursor_4c_Dados"

                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.tipos"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.codigos"
                    loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.descrs"
                    loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.apuras"
                    loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.lancas"
                    loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.opers"
                    loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.autos"
                    loc_oGrid.Column8.ControlSource = "cursor_4c_Dados.operacaos"
                    loc_oGrid.Column9.ControlSource = "cursor_4c_Dados.grupos"

                    loc_oGrid.Column1.Header1.Caption = "Tipo"
                    loc_oGrid.Column2.Header1.Caption = "C" + CHR(243) + "digo"
                    loc_oGrid.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                    loc_oGrid.Column4.Header1.Caption = "Apura" + CHR(231) + CHR(227) + "o"
                    loc_oGrid.Column5.Header1.Caption = "Lan" + CHR(231) + "a C/C"
                    loc_oGrid.Column6.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
                    loc_oGrid.Column7.Header1.Caption = "Autom" + CHR(225) + "tico"
                    loc_oGrid.Column8.Header1.Caption = "Op."
                    loc_oGrid.Column9.Header1.Caption = "Gr.Cont" + CHR(225) + "bil"

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao carregar lista:" + CHR(13) + loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), "FormOcb.CarregarLista")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *===========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    *===========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    LOCAL loc_nP
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
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    *===========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        THIS.pgf_4c_Paginas.ActivePage = par_nPagina

        IF par_nPagina = 1
            THIS.CarregarLista()
        ENDIF

        RETURN .T.
    ENDPROC

    *===========================================================================
    * FormatarGridLista - Aplica formatacao visual ao grid
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Abre lookup para localizar registro na lista
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca
        loc_oBusca = .NULL.

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigBaOco", "cursor_4c_Busca", "tipos", "", ;
                "Ocorr" + CHR(234) + "ncias do Balan" + CHR(231) + "o")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("tipos",   "", "Tipo")
                loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca") AND USED("cursor_4c_Dados")
                    SELECT cursor_4c_Dados
                    LOCATE FOR ALLTRIM(tipos) = ALLTRIM(cursor_4c_Busca.tipos) .AND. ALLTRIM(codigos) = ALLTRIM(cursor_4c_Busca.codigos)
                    IF FOUND()
                        THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.SetFocus
                        THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao buscar:" + CHR(13) + loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), "FormOcb.BtnBuscarClick")
        ENDTRY

        IF USED("cursor_4c_Busca")
            USE IN cursor_4c_Busca
        ENDIF
        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca = .NULL.
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Prepara inclusao de novo registro
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.LimparCampos()
        THIS.HabilitarCampos(.T.)
        THIS.AlternarPagina(2)
        THIS.pgf_4c_Paginas.Page2.txt_4c_Tipos.SetFocus()
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Carrega registro selecionado para visualizacao
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro para visualizar.", "")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(codigos)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Tipos.SetFocus()
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Carrega registro selecionado para edicao
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro para alterar.", "")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(codigos)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Descrs.SetFocus()
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Confirma e executa exclusao do registro selecionado
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro para excluir.", "")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCodigo = ALLTRIM(codigos)

        IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro '" + ;
                loc_cCodigo + "'?", "Confirmar Exclus" + CHR(227) + "o")
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Valida, transfere form->BO e salva
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        IF !THIS.FormParaBO()
            RETURN
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Registro salvo com sucesso!", "")
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao salvar:" + CHR(13) + loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), "FormOcb.BtnSalvarClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancela edicao e retorna para lista
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere valores dos campos do form para o BO (50% fase 5)
    * Segunda metade adicionada na Fase 6
    *===========================================================================
    PROTECTED FUNCTION FormParaBO()
        LOCAL loc_oPagina, loc_cCodigos, loc_cTipos, loc_cApuras
        LOCAL loc_cLancas, loc_cOpers, loc_cAutos, loc_cOperacaos
        loc_oPagina    = THIS.pgf_4c_Paginas.Page2

        loc_cCodigos   = ALLTRIM(loc_oPagina.txt_4c_Codigos.Value)
        loc_cTipos     = UPPER(ALLTRIM(loc_oPagina.txt_4c_Tipos.Value))
        loc_cApuras    = UPPER(ALLTRIM(loc_oPagina.txt_4c_Apura.Value))
        loc_cLancas    = UPPER(ALLTRIM(loc_oPagina.txt_4c_Lanca.Value))
        loc_cOpers     = UPPER(ALLTRIM(loc_oPagina.txt_4c_Oper.Value))
        loc_cAutos     = UPPER(ALLTRIM(loc_oPagina.txt_4c_Autos.Value))
        loc_cOperacaos = UPPER(ALLTRIM(loc_oPagina.txt_4c_Operac.Value))

        IF EMPTY(loc_cCodigos)
            MsgAviso("Obrigat" + CHR(243) + "rio informar o C" + CHR(243) + "digo!", "")
            loc_oPagina.txt_4c_Codigos.SetFocus()
            RETURN .F.
        ENDIF

        IF !INLIST(loc_cTipos, "O", "J")
            MsgAviso("Tipo inv" + CHR(225) + "lido." + CHR(13) + ;
                "Use O (Ocorr" + CHR(234) + "ncia) ou J (Justificativa).", "")
            loc_oPagina.txt_4c_Tipos.SetFocus()
            RETURN .F.
        ENDIF

        IF !EMPTY(loc_cApuras) AND !INLIST(loc_cApuras, "S", "N")
            MsgAviso("Apura" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida." + CHR(13) + ;
                "Use S (Sim) ou N (N" + CHR(227) + "o).", "")
            loc_oPagina.txt_4c_Apura.SetFocus()
            RETURN .F.
        ENDIF

        IF !EMPTY(loc_cLancas) AND !INLIST(loc_cLancas, "S", "N")
            MsgAviso("Lan" + CHR(231) + "a C/C inv" + CHR(225) + "lido." + CHR(13) + ;
                "Use S (Sim) ou N (N" + CHR(227) + "o).", "")
            loc_oPagina.txt_4c_Lanca.SetFocus()
            RETURN .F.
        ENDIF

        IF !EMPTY(loc_cOpers) AND !INLIST(loc_cOpers, "DB", "CR", "DF", "NL")
            MsgAviso("Opera" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida." + CHR(13) + ;
                "Use DB/CR/DF/NL.", "")
            loc_oPagina.txt_4c_Oper.SetFocus()
            RETURN .F.
        ENDIF

        IF !EMPTY(loc_cAutos) AND !INLIST(loc_cAutos, "S", "N")
            MsgAviso("Autom" + CHR(225) + "tico inv" + CHR(225) + "lido." + CHR(13) + ;
                "Use S (Sim) ou N (N" + CHR(227) + "o).", "")
            loc_oPagina.txt_4c_Autos.SetFocus()
            RETURN .F.
        ENDIF

        IF loc_cAutos = "S" AND !EMPTY(loc_cOperacaos) AND !INLIST(loc_cOperacaos, "E", "S")
            MsgAviso("Opera" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida." + CHR(13) + ;
                "Use E (Entrada) ou S (Sa" + CHR(237) + "da).", "")
            loc_oPagina.txt_4c_Operac.SetFocus()
            RETURN .F.
        ENDIF

        THIS.this_oBusinessObject.this_cCodigos   = loc_cCodigos
        THIS.this_oBusinessObject.this_cTipos     = loc_cTipos
        THIS.this_oBusinessObject.this_cDescrs    = ALLTRIM(loc_oPagina.txt_4c_Descrs.Value)
        THIS.this_oBusinessObject.this_cApuras    = loc_cApuras
        THIS.this_oBusinessObject.this_cLancas    = loc_cLancas
        THIS.this_oBusinessObject.this_cOpers     = loc_cOpers
        THIS.this_oBusinessObject.this_cGrupos    = ALLTRIM(loc_oPagina.txt_4c_GrContabil.Value)
        THIS.this_oBusinessObject.this_cAutos     = loc_cAutos
        THIS.this_oBusinessObject.this_cOperacaos = IIF(loc_cAutos = "S", loc_cOperacaos, "")

        RETURN .T.
    ENDFUNC

    *===========================================================================
    * BOParaForm - Transfere valores do BO para os campos do form (50% fase 5)
    * Segunda metade adicionada na Fase 6
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina, loc_cAutos
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cAutos  = ALLTRIM(THIS.this_oBusinessObject.this_cAutos)

        loc_oPagina.txt_4c_Codigos.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cCodigos)
        loc_oPagina.txt_4c_Tipos.Value      = ALLTRIM(THIS.this_oBusinessObject.this_cTipos)
        loc_oPagina.txt_4c_Descrs.Value     = ALLTRIM(THIS.this_oBusinessObject.this_cDescrs)
        loc_oPagina.txt_4c_Apura.Value      = ALLTRIM(THIS.this_oBusinessObject.this_cApuras)
        loc_oPagina.txt_4c_Lanca.Value      = ALLTRIM(THIS.this_oBusinessObject.this_cLancas)
        loc_oPagina.txt_4c_Oper.Value       = ALLTRIM(THIS.this_oBusinessObject.this_cOpers)
        loc_oPagina.txt_4c_GrContabil.Value = ALLTRIM(THIS.this_oBusinessObject.this_cGrupos)
        loc_oPagina.txt_4c_Autos.Value      = loc_cAutos
        loc_oPagina.txt_4c_Operac.Value     = ALLTRIM(THIS.this_oBusinessObject.this_cOperacaos)

        *-- GetOperac.When: habilitado apenas quando Autos = "S"
        loc_oPagina.txt_4c_Operac.Enabled = (loc_cAutos = "S")
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa os campos do form (50% fase 5)
    * Segunda metade adicionada na Fase 6
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.txt_4c_Tipos.Value      = ""
        loc_oPagina.txt_4c_Codigos.Value    = ""
        loc_oPagina.txt_4c_Descrs.Value     = ""
        loc_oPagina.txt_4c_Apura.Value      = ""
        loc_oPagina.txt_4c_Lanca.Value      = ""
        loc_oPagina.txt_4c_Oper.Value       = ""
        loc_oPagina.txt_4c_GrContabil.Value = ""
        loc_oPagina.txt_4c_Autos.Value      = ""
        loc_oPagina.txt_4c_Operac.Value     = ""
        loc_oPagina.txt_4c_Operac.Enabled   = .F.
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita/desabilita campos conforme modo (50% fase 5)
    * Segunda metade adicionada na Fase 6
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina, loc_lReadOnly, loc_cAutos
        loc_oPagina   = THIS.pgf_4c_Paginas.Page2
        loc_lReadOnly = !par_lHabilitar
        loc_cAutos    = UPPER(ALLTRIM(loc_oPagina.txt_4c_Autos.Value))

        *-- Codigo: editavel apenas em INCLUIR (When do original)
        loc_oPagina.txt_4c_Codigos.ReadOnly    = !(par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
        loc_oPagina.txt_4c_Tipos.ReadOnly      = loc_lReadOnly
        loc_oPagina.txt_4c_Descrs.ReadOnly     = loc_lReadOnly
        loc_oPagina.txt_4c_Apura.ReadOnly      = loc_lReadOnly
        loc_oPagina.txt_4c_Lanca.ReadOnly      = loc_lReadOnly
        loc_oPagina.txt_4c_Oper.ReadOnly       = loc_lReadOnly
        loc_oPagina.txt_4c_GrContabil.ReadOnly = loc_lReadOnly
        loc_oPagina.txt_4c_Autos.ReadOnly      = loc_lReadOnly

        *-- GetOperac.When: habilitado/desabilitado por Autos e por modo de edicao
        loc_oPagina.txt_4c_Operac.Enabled  = par_lHabilitar AND (loc_cAutos = "S")
        loc_oPagina.txt_4c_Operac.ReadOnly = loc_lReadOnly

        *-- Salvar desabilitado em VISUALIZAR
        loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar.Enabled   = ;
            par_lHabilitar AND THIS.this_cModoAtual != "VISUALIZAR"
        loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
    ENDPROC

    *===========================================================================
    * ValidarTipos - Handler Valid do txt_4c_Tipos (O=Ocorrencia J=Justificativa)
    *===========================================================================
    PROCEDURE ValidarTipos
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_oPagina, loc_cValor
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cValor  = UPPER(ALLTRIM(loc_oPagina.txt_4c_Tipos.Value))

        IF !EMPTY(loc_cValor) AND !INLIST(loc_cValor, "O", "J")
            MsgAviso("Tipo inv" + CHR(225) + "lido." + CHR(13) + ;
                "Use O (Ocorr" + CHR(234) + "ncia) ou J (Justificativa).", "")
            RETURN .F.
        ENDIF

        IF !EMPTY(loc_cValor)
            loc_oPagina.txt_4c_Tipos.Value = loc_cValor
        ENDIF

        RETURN .T.
    ENDPROC

    *===========================================================================
    * ValidarApura - Handler Valid do txt_4c_Apura (S=Sim N=Nao)
    *===========================================================================
    PROCEDURE ValidarApura
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_oPagina, loc_cValor
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cValor  = UPPER(ALLTRIM(loc_oPagina.txt_4c_Apura.Value))

        IF !EMPTY(loc_cValor) AND !INLIST(loc_cValor, "S", "N")
            MsgAviso("Apura" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida." + CHR(13) + ;
                "Use S (Sim) ou N (N" + CHR(227) + "o).", "")
            RETURN .F.
        ENDIF

        IF !EMPTY(loc_cValor)
            loc_oPagina.txt_4c_Apura.Value = loc_cValor
        ENDIF

        RETURN .T.
    ENDPROC

    *===========================================================================
    * ValidarLanca - Handler Valid do txt_4c_Lanca (S=Sim N=Nao)
    *===========================================================================
    PROCEDURE ValidarLanca
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_oPagina, loc_cValor
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cValor  = UPPER(ALLTRIM(loc_oPagina.txt_4c_Lanca.Value))

        IF !EMPTY(loc_cValor) AND !INLIST(loc_cValor, "S", "N")
            MsgAviso("Lan" + CHR(231) + "a C/C inv" + CHR(225) + "lido." + CHR(13) + ;
                "Use S (Sim) ou N (N" + CHR(227) + "o).", "")
            RETURN .F.
        ENDIF

        IF !EMPTY(loc_cValor)
            loc_oPagina.txt_4c_Lanca.Value = loc_cValor
        ENDIF

        RETURN .T.
    ENDPROC

    *===========================================================================
    * ValidarOper - Handler Valid do txt_4c_Oper (DB/CR/DF/NL)
    *===========================================================================
    PROCEDURE ValidarOper
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_oPagina, loc_cValor
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cValor  = UPPER(ALLTRIM(loc_oPagina.txt_4c_Oper.Value))

        IF !EMPTY(loc_cValor) AND !INLIST(loc_cValor, "DB", "CR", "DF", "NL")
            MsgAviso("Opera" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida." + CHR(13) + ;
                "Use DB (D" + CHR(233) + "bito), CR (Cr" + CHR(233) + "dito), " + ;
                "DF (Diferen" + CHR(231) + "a) ou NL (Nulo).", "")
            RETURN .F.
        ENDIF

        IF !EMPTY(loc_cValor)
            loc_oPagina.txt_4c_Oper.Value = loc_cValor
        ENDIF

        RETURN .T.
    ENDPROC

    *===========================================================================
    * ValidarAutos - Handler Valid do txt_4c_Autos (S=Sim N=Nao)
    *===========================================================================
    PROCEDURE ValidarAutos
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_oPagina, loc_cValor
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cValor  = UPPER(ALLTRIM(loc_oPagina.txt_4c_Autos.Value))

        IF !EMPTY(loc_cValor) AND !INLIST(loc_cValor, "S", "N")
            MsgAviso("Autom" + CHR(225) + "tico inv" + CHR(225) + "lido." + CHR(13) + ;
                "Use S (Sim) ou N (N" + CHR(227) + "o).", "")
            RETURN .F.
        ENDIF

        IF !EMPTY(loc_cValor)
            loc_oPagina.txt_4c_Autos.Value = loc_cValor
        ENDIF

        RETURN .T.
    ENDPROC

    *===========================================================================
    * AutosLostFocus - Handler LostFocus do txt_4c_Autos
    * Atualiza habilitacao de txt_4c_Operac conforme Autos = "S"
    * Replica o When do legado: GetOperac.When = (GetAutos.Value = "S")
    *===========================================================================
    PROCEDURE AutosLostFocus
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_oPagina, loc_cAutos, loc_lHabilitar
        loc_oPagina  = THIS.pgf_4c_Paginas.Page2
        loc_cAutos   = UPPER(ALLTRIM(loc_oPagina.txt_4c_Autos.Value))
        loc_lHabilitar = (loc_cAutos = "S") AND THIS.this_cModoAtual != "VISUALIZAR" AND ;
                         THIS.this_cModoAtual != "LISTA"

        loc_oPagina.txt_4c_Operac.Enabled = loc_lHabilitar

        IF !loc_lHabilitar
            loc_oPagina.txt_4c_Operac.Value = ""
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarOperac - Handler Valid do txt_4c_Operac (E=Entrada S=Saida)
    *===========================================================================
    PROCEDURE ValidarOperac
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_oPagina, loc_cValor
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cValor  = UPPER(ALLTRIM(loc_oPagina.txt_4c_Operac.Value))

        IF !EMPTY(loc_cValor) AND !INLIST(loc_cValor, "E", "S")
            MsgAviso("Opera" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida." + CHR(13) + ;
                "Use E (Entrada) ou S (Sa" + CHR(237) + "da).", "")
            RETURN .F.
        ENDIF

        IF !EMPTY(loc_cValor)
            loc_oPagina.txt_4c_Operac.Value = loc_cValor
        ENDIF

        RETURN .T.
    ENDPROC

    *===========================================================================
    * ValidarGrContabil - Handler Valid do txt_4c_GrContabil
    * Valida o grupo contabil digitado contra SigCdGcr
    *===========================================================================
    PROCEDURE ValidarGrContabil
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_oPagina, loc_cValor, loc_nResult
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_GrContabil.Value)

        IF EMPTY(loc_cValor)
            RETURN .T.
        ENDIF

        loc_nResult = SQLEXEC(gnConnHandle, ;
            "SELECT Codigos FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cValor), ;
            "cursor_4c_ValGcr")

        IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ValGcr") > 0
            IF USED("cursor_4c_ValGcr")
                USE IN cursor_4c_ValGcr
            ENDIF
            RETURN .T.
        ENDIF

        IF USED("cursor_4c_ValGcr")
            USE IN cursor_4c_ValGcr
        ENDIF

        THIS.AbrirLookupGrContabil()
        RETURN .T.
    ENDPROC

    *===========================================================================
    * GrContabilLookupKeyPress - Handler KeyPress F4 no txt_4c_GrContabil
    *===========================================================================
    PROCEDURE GrContabilLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupGrContabil()
        ENDIF
    ENDPROC

    *===========================================================================
    * GrContabilLookupDblClick - Handler DblClick no txt_4c_GrContabil
    *===========================================================================
    PROCEDURE GrContabilLookupDblClick()
        THIS.AbrirLookupGrContabil()
    ENDPROC

    *===========================================================================
    * AbrirLookupGrContabil - Abre FormBuscaAuxiliar para SigCdGcr
    * Original: fwBuscaExt para SigCdGcr / Codigos / Descrs
    *===========================================================================
    PROCEDURE AbrirLookupGrContabil()
        LOCAL loc_oPagina, loc_oBusca, loc_cCodigo, loc_cValorAtual
        loc_oPagina   = THIS.pgf_4c_Paginas.Page2

        IF !loc_oPagina.txt_4c_GrContabil.Enabled
            RETURN
        ENDIF

        loc_cValorAtual = ALLTRIM(loc_oPagina.txt_4c_GrContabil.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGcr", "Codigos", loc_cValorAtual, ;
                "Grupo Cont" + CHR(225) + "bil")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaGcr.Codigos)
                    loc_oPagina.txt_4c_GrContabil.Value = loc_cCodigo
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao buscar grupo cont" + CHR(225) + "bil:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), "FormOcb.AbrirLookupGrContabil")
        ENDTRY

        IF USED("cursor_4c_BuscaGcr")
            USE IN cursor_4c_BuscaGcr
        ENDIF
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Habilita/desabilita botoes CRUD conforme contexto
    * Chamado apos carregar lista para refletir estado de disponibilidade
    *===========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPagina, loc_lTemRegistro
        loc_oPagina    = THIS.pgf_4c_Paginas.Page1
        loc_lTemRegistro = USED("cursor_4c_Dados") AND ;
                           RECCOUNT("cursor_4c_Dados") > 0 AND ;
                           !EOF("cursor_4c_Dados")

        WITH loc_oPagina.cnt_4c_Botoes
            .cmd_4c_Incluir.Enabled    = .T.
            .cmd_4c_Visualizar.Enabled = loc_lTemRegistro
            .cmd_4c_Alterar.Enabled    = loc_lTemRegistro
            .cmd_4c_Excluir.Enabled    = loc_lTemRegistro
            .cmd_4c_Buscar.Enabled     = loc_lTemRegistro
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *===========================================================================
    * Destroy - Libera recursos
    *===========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\OcbBO.prg):
*==============================================================================
* OcbBO.prg - Business Object para Ocorrencias do Balanco
* Tabela: SigBaOco
*==============================================================================

DEFINE CLASS OcbBO AS BusinessBase

    *-- Propriedades da entidade (mapeadas de SigBaOco)
    this_cCodigos   = ""    && codigos   char(10) - PK
    this_cDescrs    = ""    && descrs    char(40)
    this_cTipos     = ""    && tipos     char(1) - "O" ou "J"
    this_cApuras    = ""    && apuras    char(1) - "S" ou "N"
    this_cLancas    = ""    && lancas    char(1) - "S" ou "N"
    this_cOpers     = ""    && opers     char(2) - "DB","CR","DF","NL"
    this_cAutos     = ""    && autos     char(1) - "S" ou "N"
    this_cOperacaos = ""    && operacaos char(1) - "E" ou "S"
    this_cGrupos    = ""    && grupos    char(10) - FK SigCdGcr

    *==========================================================================
    * Init - Inicializa o Business Object
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigBaOco"
        THIS.this_cCampoChave = "codigos"
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigos)
    ENDFUNC

    *==========================================================================
    * Buscar - SELECT com filtro opcional (cursor_4c_Dados)
    *==========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descrs, tipos, apuras, lancas," + ;
                       " opers, autos, operacaos, grupos" + ;
                       " FROM SigBaOco"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY codigos"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar ocorr" + CHR(234) + "ncias:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pelo PK
    *==========================================================================
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descrs, tipos, apuras, lancas," + ;
                       " opers, autos, operacaos, grupos" + ;
                       " FROM SigBaOco" + ;
                       " WHERE codigos = " + EscaparSQL(par_cCodigo)

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

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo), "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades this_
    *==========================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigos    = TratarNulo(codigos,    "C")
            THIS.this_cDescrs     = TratarNulo(descrs,     "C")
            THIS.this_cTipos      = TratarNulo(tipos,      "C")
            THIS.this_cApuras     = TratarNulo(apuras,     "C")
            THIS.this_cLancas     = TratarNulo(lancas,     "C")
            THIS.this_cOpers      = TratarNulo(opers,      "C")
            THIS.this_cAutos      = TratarNulo(autos,      "C")
            THIS.this_cOperacaos  = TratarNulo(operacaos,  "C")
            THIS.this_cGrupos     = TratarNulo(grupos,     "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Inserir - INSERT INTO SigBaOco (PROTECTED - chamado por Salvar)
    *==========================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigBaOco" + ;
                       " (codigos, descrs, tipos, apuras, lancas," + ;
                       "  opers, autos, operacaos, grupos)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigos)   + ", " + ;
                       EscaparSQL(THIS.this_cDescrs)    + ", " + ;
                       EscaparSQL(THIS.this_cTipos)     + ", " + ;
                       EscaparSQL(THIS.this_cApuras)    + ", " + ;
                       EscaparSQL(THIS.this_cLancas)    + ", " + ;
                       EscaparSQL(THIS.this_cOpers)     + ", " + ;
                       EscaparSQL(THIS.this_cAutos)     + ", " + ;
                       EscaparSQL(THIS.this_cOperacaos) + ", " + ;
                       EscaparSQL(THIS.this_cGrupos)    + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir ocorr" + CHR(234) + "ncia:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Atualizar - UPDATE SigBaOco (PROTECTED - chamado por Salvar)
    *==========================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigBaOco SET" + ;
                       " descrs    = " + EscaparSQL(THIS.this_cDescrs)    + ", " + ;
                       " tipos     = " + EscaparSQL(THIS.this_cTipos)     + ", " + ;
                       " apuras    = " + EscaparSQL(THIS.this_cApuras)    + ", " + ;
                       " lancas    = " + EscaparSQL(THIS.this_cLancas)    + ", " + ;
                       " opers     = " + EscaparSQL(THIS.this_cOpers)     + ", " + ;
                       " autos     = " + EscaparSQL(THIS.this_cAutos)     + ", " + ;
                       " operacaos = " + EscaparSQL(THIS.this_cOperacaos) + ", " + ;
                       " grupos    = " + EscaparSQL(THIS.this_cGrupos)    + ;
                       " WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar ocorr" + CHR(234) + "ncia:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ExecutarExclusao - DELETE FROM SigBaOco (PROTECTED - chamado por Excluir)
    *==========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigBaOco" + ;
                       " WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir ocorr" + CHR(234) + "ncia:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

