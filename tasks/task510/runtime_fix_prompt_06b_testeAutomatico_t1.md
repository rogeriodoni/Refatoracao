# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 67% < 100%. Falhas: Teste 'CarregarLista': Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc); Teste 'ModoIncluir': Property ALTERNARPAGINA is not found. | Detalhes: Linha: 429; Teste 'ModoVisualizar': Property AJUSTARBOTOESPORMODO is not found. | Detalhes: Linha: 559

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-23 08:14:36] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-23 08:14:36] [INFO] Config FPW: (nao fornecido)
[2026-08-23 08:14:36] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-23 08:14:36] [INFO] Timeout: 300 segundos
[2026-08-23 08:14:36] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_dwlie0el.prg
[2026-08-23 08:14:36] [INFO] Conteudo do wrapper:
[2026-08-23 08:14:36] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormReg', 'C:\4c\tasks\task510', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormReg', 'C:\4c\tasks\task510', 'CRUD'
QUIT

[2026-08-23 08:14:36] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_dwlie0el.prg
[2026-08-23 08:14:36] [INFO] VFP output esperado em: C:\4c\tasks\task510\vfp_output.txt
[2026-08-23 08:14:36] [INFO] Executando Visual FoxPro 9...
[2026-08-23 08:14:36] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_dwlie0el.prg
[2026-08-23 08:14:36] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_dwlie0el.prg
[2026-08-23 08:14:36] [INFO] Timeout configurado: 300 segundos
[2026-08-23 08:16:12] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-23 08:16:12] [INFO] VFP9 finalizado em 95.9943897 segundos
[2026-08-23 08:16:12] [INFO] Exit Code: 
[2026-08-23 08:16:12] [INFO] 
[2026-08-23 08:16:12] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-23 08:16:12] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_dwlie0el.prg
[2026-08-23 08:16:12] [INFO] 
[2026-08-23 08:16:12] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-23 08:16:12] [INFO] * Auto-generated wrapper for parameters
[2026-08-23 08:16:12] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-23 08:16:12] [INFO] * Parameters: 'FormReg', 'C:\4c\tasks\task510', 'CRUD'
[2026-08-23 08:16:12] [INFO] 
[2026-08-23 08:16:12] [INFO] * Anti-dialog protections for unattended execution
[2026-08-23 08:16:12] [INFO] SET SAFETY OFF
[2026-08-23 08:16:12] [INFO] SET RESOURCE OFF
[2026-08-23 08:16:12] [INFO] SET TALK OFF
[2026-08-23 08:16:12] [INFO] SET NOTIFY OFF
[2026-08-23 08:16:12] [INFO] SYS(2335, 0)
[2026-08-23 08:16:12] [INFO] 
[2026-08-23 08:16:12] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormReg', 'C:\4c\tasks\task510', 'CRUD'
[2026-08-23 08:16:12] [INFO] QUIT
[2026-08-23 08:16:12] [INFO] 
[2026-08-23 08:16:12] [INFO] === Fim do Wrapper.prg ===
[2026-08-23 08:16:12] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormReg",
  "timestamp": "20260823081612",
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
      "detalhes": "Linha: 429"
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
      "detalhes": "AbrirLookup: 1 (ABRIRLOOKUPCANONICO) | KeyPress handlers: 1 (KEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormReg.prg):
*==============================================================================
* FormReg.prg - Formulario de Cadastro de Regioes
* Migrado de: SigCdReg.SCX (frmcadastro)
* COMPLETO: Todas as 8 fases implementadas
*==============================================================================

DEFINE CLASS FormReg AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: valores EXATOS do original)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Regioes"
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

    *==========================================================================
    * Init - Inicializa o formulario
    * REGRA CRITICA: Apenas RETURN DODEFAULT()
    * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Configura estrutura completa do formulario
    * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Caption com acento (CHR(245) = o-tilde)
            THIS.Caption = "Cadastro de Regi" + CHR(245) + "es"

            THIS.this_oBusinessObject = CREATEOBJECT("RegBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar RegBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormReg.InicializarForm")
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
            MostrarErro("Erro ao inicializar FormReg:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormReg.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * Top=-29 para esconder abas; controles compensam +29 no Top
    *==========================================================================
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

    *==========================================================================
    * ConfigurarPaginaLista - Configura Page1 com containers principais
    * Legado: cntSombra Top=1, Grupo_op Left=544/Top=-1, Grupo_Saida Left=919
    * Compensacao PageFrame +29: Tops ajustados
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (cntSombra no legado: Top=1 + 29 = 30 -> canonico 31)
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

        *-- Container Botoes CRUD (Grupo_op: Left=544, Top=-1+29=28 -> canonico 29)
        *-- Fase 4 adiciona os 5 botoes CRUD neste container
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        =  542
            .Width       = 385
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Container Saida canonico (Left=917, Width=90, Height=85)
        *-- Grupo_Saida legado: Left=919, Top=-1 -> canonico prevalece
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
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

        *-- Grid de listagem (Top=117 = 88+29 compensacao PageFrame, Left=26, Width=890)
        *-- Colunas: regiaos (Regioes), descs (Descricao) - de SigCdReg via cursor_4c_Dados
        *-- RecordSource e ColumnCount FORA do WITH (Problem 36: evita Unknown member COLUMN1)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oPagina.grd_4c_Lista.RecordSource = ""
        loc_oPagina.grd_4c_Lista.ColumnCount  = 2
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 26
            .Width              = 890
            .Height             = 498
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
            .Column1.Width              = 100
            .Column2.Width              = 400
            .Column1.Header1.Caption    = ""
            .Column2.Header1.Caption    = ""
        ENDWITH
        BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Configura Page2: botoes + campos basicos + label Municipios
    * Legado: Grupo_Salva Left=843, Top=-4+29=25
    * Fase 5: Confirmar/Cancelar + txt/lbl Codigo + txt/lbl Descricao + lbl Municipios
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container BotoesAcao (Grupo_Salva no legado: Left=843, Top=-4+29=25)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 25
            .Left        = 843
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar (cadastro_salvar_60.jpg - Problem 16: icone correto)
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

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
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
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

        *-- Label Codigo (Say2 legado: Top=86+29=115, Left=53)
        loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
        WITH loc_oPagina.lbl_4c_Codigo
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 115
            .Left      = 53
            .Width     = 50
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo (Get_codigo legado: Top=82+29=111, Left=97, Width=80, Height=23)
        *-- MaxLength=10 conforme SigCdReg.regiaos char(10)
        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Value     = ""
            .Top       = 111
            .Left      = 97
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 10
            .ReadOnly  = .F.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Codigo, "KeyPress", THIS, "ValidarCodigo")

        *-- Label Descricao (Say1 legado: Top=86+29=115, Left=210)
        loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
        WITH loc_oPagina.lbl_4c_Descricao
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 115
            .Left      = 210
            .Width     = 60
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- TextBox Descricao (Get_Desc legado: Top=82+29=111, Left=267, Width=150)
        *-- MaxLength=30 conforme SigCdReg.descs char(30)
        loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
        WITH loc_oPagina.txt_4c_Descricao
            .Value     = ""
            .Top       = 111
            .Left      = 267
            .Width     = 150
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 30
            .ReadOnly  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Label Municipios (Say3 legado: Top=128+29=157, Left=54, Width=189, Height=15)
        loc_oPagina.AddObject("lbl_4c_Municipios", "Label")
        WITH loc_oPagina.lbl_4c_Municipios
            .Caption   = "Munic" + CHR(237) + "pios pertencentes a regi" + CHR(227) + "o"
            .Top       = 157
            .Left      = 54
            .Width     = 189
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Label Vendedores (Say4 legado: Top=128+29=157, Left=498, Width=213, Height=15)
        loc_oPagina.AddObject("lbl_4c_Vendedores", "Label")
        WITH loc_oPagina.lbl_4c_Vendedores
            .Caption   = "Vendedores respons" + CHR(225) + "veis pela regi" + CHR(227) + "o"
            .Top       = 157
            .Left      = 498
            .Width     = 213
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Grid Municipios (GradMuni legado: Top=146+29=175, Left=51, Width=358, Height=438)
        *-- RecordSource e ColumnCount FORA do WITH (Problem 36: evita Unknown member COLUMN1)
        *-- ControlSource definido em RebindGridsDetalhe() apos criacao do cursor crMuni
        loc_oPagina.AddObject("grd_4c_Municipios", "Grid")
        loc_oPagina.grd_4c_Municipios.RecordSource = ""
        loc_oPagina.grd_4c_Municipios.ColumnCount  = 2
        WITH loc_oPagina.grd_4c_Municipios
            .Top                = 175
            .Left               = 51
            .Width              = 358
            .Height             = 438
            .FontName           = "Tahoma"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .RecordMark         = .F.
            .DeleteMark         = .F.
            .HeaderHeight       = 20
            .RowHeight          = 18
            .ScrollBars         = 2
            .GridLines          = 3
            .AllowHeaderSizing  = .F.
            .AllowRowSizing     = .F.
            .Column1.Width               = 24
            .Column2.Width               = 312
            .Column1.Header1.Caption     = "UF"
            .Column2.Header1.Caption     = "Munic" + CHR(237) + "pio"
            .Visible            = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.grd_4c_Municipios, "AfterRowColChange", THIS, ;
            "GradMuniAfterRowColChange")

        *-- Botao Inserir Municipio (inserir legado: Top=324+29=353, Left=414, 45x45)
        loc_oPagina.AddObject("cmd_4c_InserirMun", "CommandButton")
        WITH loc_oPagina.cmd_4c_InserirMun
            .Top             = 353
            .Left            = 414
            .Width           = 40
            .Height          = 40
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 14
            .SpecialEffect   = 0
            .MousePointer    = 15
            .ToolTipText     = "Inserir Munic" + CHR(237) + "pio"
            .Themes          = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_InserirMun, "Click", THIS, "BtnInserirMunClick")

        *-- Botao Excluir Municipio (excluir legado: Top=369+29=398, Left=414, 45x45)
        loc_oPagina.AddObject("cmd_4c_ExcluirMun", "CommandButton")
        WITH loc_oPagina.cmd_4c_ExcluirMun
            .Top             = 398
            .Left            = 414
            .Width           = 40
            .Height          = 40
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .PicturePosition = 14
            .SpecialEffect   = 0
            .MousePointer    = 15
            .ToolTipText     = "Excluir Munic" + CHR(237) + "pio"
            .Themes          = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_ExcluirMun, "Click", THIS, "BtnExcluirMunClick")

        *-- Grid Vendedores (GradVend legado: Top=146+29=175, Left=497, Width=402, Height=438)
        *-- RecordSource e ColumnCount FORA do WITH (Problem 36)
        *-- ControlSource definido em RebindGridsDetalhe() apos criacao do cursor crVend
        loc_oPagina.AddObject("grd_4c_Vendedores", "Grid")
        loc_oPagina.grd_4c_Vendedores.RecordSource = ""
        loc_oPagina.grd_4c_Vendedores.ColumnCount  = 2
        WITH loc_oPagina.grd_4c_Vendedores
            .Top                = 175
            .Left               = 497
            .Width              = 402
            .Height             = 438
            .FontName           = "Tahoma"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .RecordMark         = .F.
            .DeleteMark         = .F.
            .HeaderHeight       = 20
            .RowHeight          = 18
            .ScrollBars         = 2
            .GridLines          = 3
            .AllowHeaderSizing  = .F.
            .AllowRowSizing     = .F.
            .Column1.Width               = 90
            .Column2.Width               = 290
            .Column1.Header1.Caption     = "C" + CHR(243) + "digo"
            .Column2.Header1.Caption     = "Nome do Vendedor"
            .Visible            = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.grd_4c_Vendedores, "AfterRowColChange", THIS, ;
            "GradVendAfterRowColChange")

        *-- Botao Inserir Vendedor (InserirV legado: Top=324+29=353, Left=903, 45x45)
        loc_oPagina.AddObject("cmd_4c_InserirVend", "CommandButton")
        WITH loc_oPagina.cmd_4c_InserirVend
            .Top             = 353
            .Left            = 903
            .Width           = 40
            .Height          = 40
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 14
            .SpecialEffect   = 0
            .MousePointer    = 15
            .ToolTipText     = "Inserir Vendedor"
            .Themes          = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_InserirVend, "Click", THIS, "BtnInserirVendClick")

        *-- Botao Excluir Vendedor (ExcluirV legado: Top=369+29=398, Left=903, 45x45)
        loc_oPagina.AddObject("cmd_4c_ExcluirVend", "CommandButton")
        WITH loc_oPagina.cmd_4c_ExcluirVend
            .Top             = 398
            .Left            = 903
            .Width           = 40
            .Height          = 40
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .PicturePosition = 14
            .SpecialEffect   = 0
            .MousePointer    = 15
            .ToolTipText     = "Excluir Vendedor"
            .Themes          = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_ExcluirVend, "Click", THIS, "BtnExcluirVendClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega dados no grid da Page1
    * BO.Buscar() cria cursor_4c_Dados com: regiaos, descs, skchaves
    * ControlSource APOS RecordSource (Problem 36) + headers reconfigurados (Problem 32)
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oGrid
        loc_lSucesso = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lSucesso = .T.
            ELSE
                IF THIS.this_oBusinessObject.Buscar("")
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                    *-- RecordSource e ColumnCount antes das colunas (Problem 36)
                    loc_oGrid.ColumnCount = 2
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.ColumnCount  = 2

                    *-- ControlSource APOS RecordSource
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.regiaos"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"

                    loc_oGrid.Column1.Width = 100
                    loc_oGrid.Column2.Width = 400

                    *-- Reconfigurar headers: VFP9 os reseta ao mudar RecordSource (Problem 32)
                    loc_oGrid.Column1.Header1.Caption = ""
                    loc_oGrid.Column2.Header1.Caption = ""

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_oGrid.Refresh()
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormReg.CarregarLista")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * Itera Pages de PageFrames E Controls de Containers
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                *-- Trata PageFrame: itera Pages explicitamente
                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                *-- Recursao para containers com ControlCount
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
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    * Ao voltar para Page1 recarrega o grid automaticamente
    *==========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR !INLIST(par_nPagina, 1, 2)
                loc_lSucesso = .F.
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina
                IF par_nPagina = 1
                    THIS.CarregarLista()
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormReg.AlternarPagina")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Prepara form para incluir nova regiao
    * Metodos de Page2 (LimparCampos/HabilitarCampos/AjustarBotoesPorModo) sao
    * guardados com PEMSTATUS pois sao adicionados em fase posterior
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.this_cModoAtual = "INCLUIR"
            IF PEMSTATUS(THIS, "LimparCampos", 5)
                THIS.LimparCampos()
            ENDIF
            IF PEMSTATUS(THIS, "HabilitarCampos", 5)
                THIS.HabilitarCampos(.T.)
            ENDIF
            IF PEMSTATUS(THIS, "AjustarBotoesPorModo", 5)
                THIS.AjustarBotoesPorModo()
            ENDIF
            THIS.pgf_4c_Paginas.ActivePage = 2
        CATCH TO loException
            MostrarErro(loException, "FormReg.BtnIncluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Visualiza regiao selecionada (somente leitura)
    * Tambem ativado pelo DblClick no grid
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 ;
               OR EOF("cursor_4c_Dados")
                MsgAviso("Selecione uma regi" + CHR(227) + "o na lista.", "Visualizar")
            ELSE
                SELECT cursor_4c_Dados
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.regiaos)
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
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormReg.BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Carrega regiao selecionada para edicao
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 ;
               OR EOF("cursor_4c_Dados")
                MsgAviso("Selecione uma regi" + CHR(227) + "o na lista.", "Alterar")
            ELSE
                SELECT cursor_4c_Dados
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.regiaos)
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
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormReg.BtnAlterarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Exclui regiao selecionada apos confirmacao
    * Totalmente funcional: BO.CarregarPorCodigo + Excluir + CarregarLista
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo
        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 ;
               OR EOF("cursor_4c_Dados")
                MsgAviso("Selecione uma regi" + CHR(227) + "o na lista.", "Excluir")
            ELSE
                SELECT cursor_4c_Dados
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.regiaos)
                IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da regi" + ;
                               CHR(227) + "o '" + loc_cCodigo + "'?", "Excluir")
                    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                        IF THIS.this_oBusinessObject.Excluir()
                            MsgInfo("Regi" + CHR(227) + "o exclu" + CHR(237) + ;
                                    "da com sucesso!", "Excluir")
                            THIS.CarregarLista()
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormReg.BtnExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Abre FormBuscaAuxiliar para selecionar regiao na lista
    * Posiciona o grid no registro selecionado apos a busca
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cCodigo
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdReg", "cursor_4c_BuscaReg", "regiaos", "", ;
                "Buscar Regi" + CHR(245) + "es")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("regiaos", "", "Regi" + CHR(245) + "es")
                    loc_oBusca.mAddColuna("descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaReg")
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaReg.regiaos)
                    IF USED("cursor_4c_Dados")
                        SELECT cursor_4c_Dados
                        LOCATE FOR ALLTRIM(regiaos) = loc_cCodigo
                        THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
                    ENDIF
                ENDIF

                IF USED("cursor_4c_BuscaReg")
                    USE IN cursor_4c_BuscaReg
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormReg.BtnBuscarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Salva regiao: validacao fora do TRY, FormParaBO + Salvar()
    * BO.Inserir() gera skchaves e chama InserirFilhos (crMuni+crVend)
    * BO.Atualizar() rebuilda SigCdRgi a partir de crMuni+crVend
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lSucesso, loc_oPagina2
        loc_lSucesso = .F.
        loc_oPagina2 = THIS.pgf_4c_Paginas.Page2

        *-- Validacoes FORA do TRY (REGRA CRITICA - Problem 16)
        IF EMPTY(ALLTRIM(loc_oPagina2.txt_4c_Codigo.Value))
            MsgAviso("C" + CHR(243) + "digo da regi" + CHR(227) + "o " + ;
                     CHR(233) + " obrigat" + CHR(243) + "rio.", "Salvar")
            loc_oPagina2.txt_4c_Codigo.SetFocus
            RETURN
        ENDIF
        IF EMPTY(ALLTRIM(loc_oPagina2.txt_4c_Descricao.Value))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o da regi" + CHR(227) + ;
                     "o " + CHR(233) + " obrigat" + CHR(243) + "ria.", "Salvar")
            loc_oPagina2.txt_4c_Descricao.SetFocus
            RETURN
        ENDIF

        TRY
            THIS.FormParaBO()
            loc_lSucesso = THIS.this_oBusinessObject.Salvar()
            IF loc_lSucesso
                MsgInfo("Regi" + CHR(227) + "o salva com sucesso!", "Salvar")
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormReg.BtnSalvarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela edicao e retorna para a lista
    * AlternarPagina(1) ja chama CarregarLista() automaticamente
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        TRY
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
        CATCH TO loException
            MostrarErro(loException, "FormReg.BtnCancelarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarCodigo - Verifica duplicidade ao sair de txt_4c_Codigo (INCLUIR)
    * Ativado via BINDEVENT LostFocus
    *==========================================================================
    PROCEDURE ValidarCodigo
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_cCodigo, loc_oPagina2, loc_cSQL, loc_nResult
        loc_oPagina2 = THIS.pgf_4c_Paginas.Page2
        loc_cCodigo  = ALLTRIM(loc_oPagina2.txt_4c_Codigo.Value)

        TRY
            IF !EMPTY(loc_cCodigo) AND THIS.this_cModoAtual = "INCLUIR"
                loc_cSQL    = "SELECT COUNT(*) AS qtde FROM SigCdReg" + ;
                              " WHERE regiaos = " + EscaparSQL(loc_cCodigo)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkReg")
                IF loc_nResult > 0 AND USED("cursor_4c_ChkReg")
                    SELECT cursor_4c_ChkReg
                    IF cursor_4c_ChkReg.qtde > 0
                        MsgAviso("Regi" + CHR(227) + "o '" + loc_cCodigo + ;
                                 "' j" + CHR(225) + " cadastrada!", "Validar")
                        loc_oPagina2.txt_4c_Codigo.Value = ""
                        loc_oPagina2.txt_4c_Codigo.SetFocus
                    ENDIF
                ENDIF
                IF USED("cursor_4c_ChkReg")
                    USE IN cursor_4c_ChkReg
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FormReg.ValidarCodigo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere valores do formulario para o Business Object
    * Chamado antes de Salvar(); crMuni e crVend ja refletem estado dos grids
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina2
        loc_oPagina2 = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.this_cRegiaos = ;
            ALLTRIM(loc_oPagina2.txt_4c_Codigo.Value)
        THIS.this_oBusinessObject.this_cDescs   = ;
            ALLTRIM(loc_oPagina2.txt_4c_Descricao.Value)
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere Business Object para o formulario
    * Carrega tambem crMuni e crVend via BO (usados pelos grids da Fase 6)
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina2, loc_cSkChaves
        loc_oPagina2  = THIS.pgf_4c_Paginas.Page2
        loc_cSkChaves = ALLTRIM(THIS.this_oBusinessObject.this_cSkChaves)

        loc_oPagina2.txt_4c_Codigo.Value    = ;
            ALLTRIM(THIS.this_oBusinessObject.this_cRegiaos)
        loc_oPagina2.txt_4c_Descricao.Value = ;
            ALLTRIM(THIS.this_oBusinessObject.this_cDescs)

        *-- Carrega cursores para os grids (Fase 6 vincula RecordSource)
        THIS.this_oBusinessObject.BuscarMunicipios(loc_cSkChaves)
        THIS.this_oBusinessObject.BuscarVendedores(loc_cSkChaves)

        *-- Rebind grids apos recreacao dos cursores (Problem 36/32)
        THIS.RebindGridsDetalhe()
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa campos da Page2 e recria cursores vazios
    * crMuni e crVend vazios (1 linha em branco) prontos para o usuario preencher
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina2
        loc_oPagina2 = THIS.pgf_4c_Paginas.Page2

        loc_oPagina2.txt_4c_Codigo.Value    = ""
        loc_oPagina2.txt_4c_Descricao.Value = ""

        *-- Reinicializa cursores de detalhe vazios (BuscarMunicipios("") cria cursor + 1 blank)
        IF USED("crMuni")
            USE IN crMuni
        ENDIF
        IF USED("crVend")
            USE IN crVend
        ENDIF
        THIS.this_oBusinessObject.BuscarMunicipios("")
        THIS.this_oBusinessObject.BuscarVendedores("")
        THIS.RebindGridsDetalhe()
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita campos da Page2 conforme modo
    * par_lHabilitar: .T. = editavel (INCLUIR/ALTERAR), .F. = readonly (VISUALIZAR)
    * Codigo somente editavel no INCLUIR; no ALTERAR eh readonly (chave primaria)
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina2
        loc_oPagina2 = THIS.pgf_4c_Paginas.Page2

        *-- Codigo: editavel apenas no INCLUIR (chave nao pode mudar no ALTERAR)
        loc_oPagina2.txt_4c_Codigo.ReadOnly = ;
            !par_lHabilitar OR THIS.this_cModoAtual = "ALTERAR"
        loc_oPagina2.txt_4c_Descricao.ReadOnly = !par_lHabilitar

        *-- Grids e botoes de detalhe (Fase 6)
        IF PEMSTATUS(loc_oPagina2, "grd_4c_Municipios", 5)
            loc_oPagina2.grd_4c_Municipios.ReadOnly = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPagina2, "grd_4c_Vendedores", 5)
            loc_oPagina2.grd_4c_Vendedores.ReadOnly = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPagina2, "cmd_4c_InserirMun", 5)
        ENDIF
        IF PEMSTATUS(loc_oPagina2, "cmd_4c_InserirVend", 5)
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme this_cModoAtual
    * VISUALIZAR: Confirmar disabled; INCLUIR/ALTERAR: ambos enabled
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPagina2, loc_lEditando
        loc_oPagina2  = THIS.pgf_4c_Paginas.Page2
        loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        WITH loc_oPagina2.cnt_4c_BotoesAcao
            .cmd_4c_Confirmar.Enabled = loc_lEditando
            .cmd_4c_Cancelar.Enabled  = .T.
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * Destroy - Libera recursos ao fechar o formulario
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("crMuni")
            USE IN crMuni
        ENDIF
        IF USED("crVend")
            USE IN crVend
        ENDIF

        DODEFAULT()
    ENDPROC

    *==========================================================================
    * RebindGridsDetalhe - Revincula grids apos recreacao dos cursores crMuni/crVend
    * Problem 36: RecordSource/ColumnCount fora de WITH
    * Problem 32: headers precisam ser re-especificados apos mudar RecordSource
    *==========================================================================
    PROTECTED PROCEDURE RebindGridsDetalhe()
        LOCAL loc_oPagina2, loc_oGridMuni, loc_oGridVend, loc_oErro
        loc_oPagina2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF PEMSTATUS(loc_oPagina2, "grd_4c_Municipios", 5) AND USED("crMuni")
                loc_oGridMuni = loc_oPagina2.grd_4c_Municipios
                loc_oGridMuni.RecordSource = ""
                loc_oGridMuni.RecordSource = "crMuni"
                loc_oGridMuni.ColumnCount  = 2
                loc_oGridMuni.Column1.ControlSource   = "crMuni.uf"
                loc_oGridMuni.Column2.ControlSource   = "crMuni.munici"
                loc_oGridMuni.Column1.Width            = 24
                loc_oGridMuni.Column2.Width            = 312
                loc_oGridMuni.Column1.Header1.Caption  = "UF"
                loc_oGridMuni.Column2.Header1.Caption  = "Munic" + CHR(237) + "pio"
                loc_oGridMuni.Refresh()
            ENDIF

            IF PEMSTATUS(loc_oPagina2, "grd_4c_Vendedores", 5) AND USED("crVend")
                loc_oGridVend = loc_oPagina2.grd_4c_Vendedores
                loc_oGridVend.RecordSource = ""
                loc_oGridVend.RecordSource = "crVend"
                loc_oGridVend.ColumnCount  = 2
                loc_oGridVend.Column1.ControlSource   = "crVend.iclis"
                loc_oGridVend.Column2.ControlSource   = "crVend.vend"
                loc_oGridVend.Column1.Width            = 90
                loc_oGridVend.Column2.Width            = 290
                loc_oGridVend.Column1.Header1.Caption  = "C" + CHR(243) + "digo"
                loc_oGridVend.Column2.Header1.Caption  = "Nome do Vendedor"
                loc_oGridVend.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao vincular grids de detalhe")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GradMuniAfterRowColChange - Valida celula ao navegar no grid de Municipios
    * PUBLIC: BINDEVENT exige metodo publico
    * par_nColIndex: coluna ANTERIOR ao movimento (1=saiu da coluna UF, 2=saiu da coluna Municipio)
    *==========================================================================
    PROCEDURE GradMuniAfterRowColChange(par_nColIndex)
        LOCAL loc_oErro
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        IF !USED("crMuni") OR EOF("crMuni")
            RETURN
        ENDIF
        TRY
            DO CASE
                CASE par_nColIndex = 1
                    THIS.ValidarUFMuni()
                CASE par_nColIndex = 2
                    THIS.ValidarMuniMuni()
            ENDCASE
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar munic" + CHR(237) + "pio")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarUFMuni - Valida e normaliza campo UF no cursor crMuni
    * Lookup exato em SigCdUfs; se nao encontrado, abre FormBuscaAuxiliar (picker)
    *==========================================================================
    PROTECTED PROCEDURE ValidarUFMuni()
        LOCAL loc_lResultado, loc_cUF, loc_nResult, loc_oBusca, loc_oErro
        loc_lResultado = .T.

        TRY
            loc_cUF = ALLTRIM(crMuni.uf)
            IF !EMPTY(loc_cUF)
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 estados, descrs FROM SigCdUfs " + ;
                    "WHERE estados = " + EscaparSQL(loc_cUF), ;
                    "cursor_4c_UfLocal")
                IF loc_nResult > 0 AND USED("cursor_4c_UfLocal") AND !EOF("cursor_4c_UfLocal")
                    REPLACE crMuni.uf WITH ALLTRIM(cursor_4c_UfLocal.estados) IN crMuni
                    IF USED("cursor_4c_UfLocal")
                        USE IN cursor_4c_UfLocal
                    ENDIF
                ELSE
                    IF USED("cursor_4c_UfLocal")
                        USE IN cursor_4c_UfLocal
                    ENDIF
                    *-- Nao encontrado: abre picker com todos os estados
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT estados, descrs FROM SigCdUfs ORDER BY estados", ;
                        "cursor_4c_UfLocal")
                    IF loc_nResult > 0 AND USED("cursor_4c_UfLocal")
                        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                        loc_oBusca.this_cCursorDestino = "cursor_4c_UfLocal"
                        loc_oBusca.DefinirCursor("cursor_4c_UfLocal", "estados", "descrs", ;
                            "Selecionar UF")
                        loc_oBusca.Mostrar()
                        IF loc_oBusca.this_lSelecionou
                            REPLACE crMuni.uf WITH ;
                                ALLTRIM(loc_oBusca.cCodigoSelecionado) IN crMuni
                        ELSE
                            REPLACE crMuni.uf WITH "" IN crMuni
                            loc_lResultado = .F.
                        ENDIF
                        loc_oBusca.Release()
                        loc_oBusca = .NULL.
                        IF USED("cursor_4c_UfLocal")
                            USE IN cursor_4c_UfLocal
                        ENDIF
                    ELSE
                        MsgErro("Erro ao consultar estados.", "Erro UF")
                        REPLACE crMuni.uf WITH "" IN crMuni
                        loc_lResultado = .F.
                    ENDIF
                ENDIF
            ENDIF
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Municipios", 5)
                THIS.pgf_4c_Paginas.Page2.grd_4c_Municipios.Refresh()
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_UfLocal")
                USE IN cursor_4c_UfLocal
            ENDIF
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.Release()
                loc_oBusca = .NULL.
            ENDIF
            MsgErro(loc_oErro.Message, "Erro ao validar UF")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ValidarMuniMuni - Valida e normaliza campo munici no cursor crMuni
    * Lookup em SigCdMun filtrado pela UF corrente; atualiza crMuni.codibges
    *==========================================================================
    PROTECTED PROCEDURE ValidarMuniMuni()
        LOCAL loc_lResultado, loc_cMuni, loc_cUF, loc_nResult, loc_cSQL
        LOCAL loc_oBusca, loc_oErro
        loc_lResultado = .T.

        TRY
            loc_cMuni = ALLTRIM(crMuni.munici)
            loc_cUF   = ALLTRIM(crMuni.uf)

            IF !EMPTY(loc_cMuni)
                *-- Busca exata/parcial em SigCdMun filtrada pela UF
                loc_cSQL = "SELECT TOP 1 m.codigos AS codibges, m.descs AS munici" + ;
                    " FROM SigCdMun m" + ;
                    " INNER JOIN SigCdUfs u ON u.ufibges = m.ufibges"
                IF !EMPTY(loc_cUF)
                    loc_cSQL = loc_cSQL + " WHERE u.estados = " + EscaparSQL(loc_cUF) + ;
                        " AND m.codigos = " + EscaparSQL(loc_cMuni)
                ELSE
                    loc_cSQL = loc_cSQL + ;
                        " WHERE m.codigos = " + EscaparSQL(loc_cMuni)
                ENDIF
                loc_cSQL = loc_cSQL + " ORDER BY m.descs"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MuniLocal")
                IF loc_nResult > 0 AND USED("cursor_4c_MuniLocal") AND !EOF("cursor_4c_MuniLocal")
                    REPLACE crMuni.codibges WITH ;
                        ALLTRIM(cursor_4c_MuniLocal.codibges) IN crMuni
                    REPLACE crMuni.munici WITH ;
                        ALLTRIM(cursor_4c_MuniLocal.munici) IN crMuni
                    IF USED("cursor_4c_MuniLocal")
                        USE IN cursor_4c_MuniLocal
                    ENDIF
                    THIS.ValidarDuplicadosMuni()
                ELSE
                    IF USED("cursor_4c_MuniLocal")
                        USE IN cursor_4c_MuniLocal
                    ENDIF
                    *-- Nao encontrado: abre picker filtrado pela UF
                    loc_cSQL = "SELECT m.codigos AS codibges, m.descs AS munici" + ;
                        " FROM SigCdMun m" + ;
                        " INNER JOIN SigCdUfs u ON u.ufibges = m.ufibges"
                    IF !EMPTY(loc_cUF)
                        loc_cSQL = loc_cSQL + " WHERE u.estados = " + EscaparSQL(loc_cUF)
                    ENDIF
                    loc_cSQL = loc_cSQL + " ORDER BY m.descs"

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MuniLocal")
                    IF loc_nResult > 0 AND USED("cursor_4c_MuniLocal")
                        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                        loc_oBusca.this_cCursorDestino = "cursor_4c_MuniLocal"
                        loc_oBusca.DefinirCursor("cursor_4c_MuniLocal", "codibges", "munici", ;
                            "Selecionar Munic" + CHR(237) + "pio")
                        loc_oBusca.Mostrar()
                        IF loc_oBusca.this_lSelecionou
                            REPLACE crMuni.codibges WITH ;
                                ALLTRIM(loc_oBusca.cCodigoSelecionado) IN crMuni
                            REPLACE crMuni.munici WITH ;
                                ALLTRIM(loc_oBusca.cDescricaoSelecionada) IN crMuni
                            THIS.ValidarDuplicadosMuni()
                        ELSE
                            REPLACE crMuni.codibges WITH "" IN crMuni
                            REPLACE crMuni.munici   WITH "" IN crMuni
                            loc_lResultado = .F.
                        ENDIF
                        loc_oBusca.Release()
                        loc_oBusca = .NULL.
                        IF USED("cursor_4c_MuniLocal")
                            USE IN cursor_4c_MuniLocal
                        ENDIF
                    ELSE
                        MsgAviso("Nenhum munic" + CHR(237) + "pio encontrado.", ;
                            "Munic" + CHR(237) + "pio")
                        REPLACE crMuni.codibges WITH "" IN crMuni
                        REPLACE crMuni.munici   WITH "" IN crMuni
                        loc_lResultado = .F.
                    ENDIF
                ENDIF
            ENDIF
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Municipios", 5)
                THIS.pgf_4c_Paginas.Page2.grd_4c_Municipios.Refresh()
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_MuniLocal")
                USE IN cursor_4c_MuniLocal
            ENDIF
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.Release()
                loc_oBusca = .NULL.
            ENDIF
            MsgErro(loc_oErro.Message, "Erro ao validar munic" + CHR(237) + "pio")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ValidarDuplicadosMuni - Avisa se ha municipios duplicados em crMuni
    *==========================================================================
    PROTECTED PROCEDURE ValidarDuplicadosMuni()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .T.

        TRY
            IF USED("crMuni")
                SELECT codibges FROM crMuni ;
                    WHERE !EMPTY(ALLTRIM(codibges)) ;
                    GROUP BY codibges ;
                    HAVING SUM(1) > 1 ;
                    INTO CURSOR cursor_4c_DupMuni NOFILTER
                IF !EOF("cursor_4c_DupMuni")
                    MsgAviso("Munic" + CHR(237) + "pio duplicado detectado na lista.")
                    loc_lResultado = .F.
                ENDIF
                IF USED("cursor_4c_DupMuni")
                    USE IN cursor_4c_DupMuni
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_DupMuni")
                USE IN cursor_4c_DupMuni
            ENDIF
            MsgErro(loc_oErro.Message, "Erro ao verificar duplicados de munic" + CHR(237) + "pios")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * GradVendAfterRowColChange - Valida celula ao navegar no grid de Vendedores
    * PUBLIC: BINDEVENT exige metodo publico
    * par_nColIndex: coluna ANTERIOR ao movimento (1=saiu da coluna Codigo/iclis)
    *==========================================================================
    PROCEDURE GradVendAfterRowColChange(par_nColIndex)
        LOCAL loc_oErro
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        IF !USED("crVend") OR EOF("crVend")
            RETURN
        ENDIF
        TRY
            IF par_nColIndex = 1
                THIS.ValidarCodigoVend()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar vendedor")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarCodigoVend - Valida e normaliza campo iclis no cursor crVend
    * Lookup em SigCdCli; preenche automaticamente crVend.vend (razaos)
    *==========================================================================
    PROTECTED PROCEDURE ValidarCodigoVend()
        LOCAL loc_lResultado, loc_cIclis, loc_nResult, loc_oBusca, loc_cSQL, loc_oErro
        loc_lResultado = .T.

        TRY
            loc_cIclis = ALLTRIM(crVend.iclis)
            IF !EMPTY(loc_cIclis)
                *-- Busca exata em SigCdCli
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 iclis, razaos FROM SigCdCli " + ;
                    "WHERE iclis = " + EscaparSQL(loc_cIclis), ;
                    "cursor_4c_VendLocal")
                IF loc_nResult > 0 AND USED("cursor_4c_VendLocal") AND !EOF("cursor_4c_VendLocal")
                    REPLACE crVend.iclis WITH ALLTRIM(cursor_4c_VendLocal.iclis) IN crVend
                    REPLACE crVend.vend  WITH ALLTRIM(cursor_4c_VendLocal.razaos) IN crVend
                    IF USED("cursor_4c_VendLocal")
                        USE IN cursor_4c_VendLocal
                    ENDIF
                    THIS.ValidarDuplicadosVend()
                ELSE
                    IF USED("cursor_4c_VendLocal")
                        USE IN cursor_4c_VendLocal
                    ENDIF
                    *-- Nao encontrado exato: busca parcial por codigo ou nome
                    loc_cSQL = "SELECT iclis, razaos FROM SigCdCli " + ;
                        "WHERE iclis LIKE " + EscaparSQL(loc_cIclis + "%") + ;
                        " ORDER BY iclis"
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VendLocal")
                    IF loc_nResult <= 0 OR !USED("cursor_4c_VendLocal") OR ;
                            EOF("cursor_4c_VendLocal")
                        IF USED("cursor_4c_VendLocal")
                            USE IN cursor_4c_VendLocal
                        ENDIF
                        *-- Fallback: mostra todos os clientes
                        loc_nResult = SQLEXEC(gnConnHandle, ;
                            "SELECT iclis, razaos FROM SigCdCli ORDER BY iclis", ;
                            "cursor_4c_VendLocal")
                    ENDIF
                    IF loc_nResult > 0 AND USED("cursor_4c_VendLocal")
                        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                        loc_oBusca.this_cCursorDestino = "cursor_4c_VendLocal"
                        loc_oBusca.DefinirCursor("cursor_4c_VendLocal", "iclis", "razaos", ;
                            "Selecionar Vendedor")
                        loc_oBusca.Mostrar()
                        IF loc_oBusca.this_lSelecionou
                            REPLACE crVend.iclis WITH ;
                                ALLTRIM(loc_oBusca.cCodigoSelecionado) IN crVend
                            REPLACE crVend.vend  WITH ;
                                ALLTRIM(loc_oBusca.cDescricaoSelecionada) IN crVend
                            THIS.ValidarDuplicadosVend()
                        ELSE
                            REPLACE crVend.iclis WITH "" IN crVend
                            REPLACE crVend.vend  WITH "" IN crVend
                            loc_lResultado = .F.
                        ENDIF
                        loc_oBusca.Release()
                        loc_oBusca = .NULL.
                        IF USED("cursor_4c_VendLocal")
                            USE IN cursor_4c_VendLocal
                        ENDIF
                    ELSE
                        MsgAviso("Nenhum vendedor encontrado.")
                        REPLACE crVend.iclis WITH "" IN crVend
                        REPLACE crVend.vend  WITH "" IN crVend
                        loc_lResultado = .F.
                    ENDIF
                ENDIF
            ENDIF
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Vendedores", 5)
                THIS.pgf_4c_Paginas.Page2.grd_4c_Vendedores.Refresh()
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_VendLocal")
                USE IN cursor_4c_VendLocal
            ENDIF
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.Release()
                loc_oBusca = .NULL.
            ENDIF
            MsgErro(loc_oErro.Message, "Erro ao validar vendedor")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ValidarDuplicadosVend - Avisa se ha vendedores duplicados em crVend
    *==========================================================================
    PROTECTED PROCEDURE ValidarDuplicadosVend()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .T.

        TRY
            IF USED("crVend")
                SELECT iclis FROM crVend ;
                    WHERE !EMPTY(ALLTRIM(iclis)) ;
                    GROUP BY iclis ;
                    HAVING SUM(1) > 1 ;
                    INTO CURSOR cursor_4c_DupVend NOFILTER
                IF !EOF("cursor_4c_DupVend")
                    MsgAviso("Vendedor duplicado detectado na lista.")
                    loc_lResultado = .F.
                ENDIF
                IF USED("cursor_4c_DupVend")
                    USE IN cursor_4c_DupVend
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_DupVend")
                USE IN cursor_4c_DupVend
            ENDIF
            MsgErro(loc_oErro.Message, "Erro ao verificar duplicados de vendedores")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnInserirMunClick - Adiciona linha em branco ao cursor crMuni
    * PUBLIC: BINDEVENT exige metodo publico
    *==========================================================================
    PROCEDURE BtnInserirMunClick()
        LOCAL loc_oErro
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        IF !USED("crMuni")
            RETURN
        ENDIF
        TRY
            SELECT crMuni
            APPEND BLANK
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Municipios", 5)
                THIS.pgf_4c_Paginas.Page2.grd_4c_Municipios.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao inserir munic" + CHR(237) + "pio:" + CHR(13) + ;
                loc_oErro.Message, "FormReg.BtnInserirMunClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirMunClick - Remove linha atual do cursor crMuni
    * PUBLIC: BINDEVENT exige metodo publico
    *==========================================================================
    PROCEDURE BtnExcluirMunClick()
        LOCAL loc_oErro
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        IF !USED("crMuni") OR EOF("crMuni")
            RETURN
        ENDIF
        IF !MsgConfirma("Excluir o munic" + CHR(237) + "pio selecionado?")
            RETURN
        ENDIF
        TRY
            DELETE IN crMuni
            SELECT crMuni
            PACK
            IF RECCOUNT("crMuni") = 0
                APPEND BLANK
            ENDIF
            IF RECCOUNT("crMuni") > 0
                GO BOTTOM IN crMuni
            ENDIF
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Municipios", 5)
                THIS.pgf_4c_Paginas.Page2.grd_4c_Municipios.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao excluir munic" + CHR(237) + "pio:" + CHR(13) + ;
                loc_oErro.Message, "FormReg.BtnExcluirMunClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnInserirVendClick - Adiciona linha em branco ao cursor crVend
    * PUBLIC: BINDEVENT exige metodo publico
    *==========================================================================
    PROCEDURE BtnInserirVendClick()
        LOCAL loc_oErro
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        IF !USED("crVend")
            RETURN
        ENDIF
        TRY
            SELECT crVend
            APPEND BLANK
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Vendedores", 5)
                THIS.pgf_4c_Paginas.Page2.grd_4c_Vendedores.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao inserir vendedor:" + CHR(13) + ;
                loc_oErro.Message, "FormReg.BtnInserirVendClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirVendClick - Remove linha atual do cursor crVend
    * PUBLIC: BINDEVENT exige metodo publico
    *==========================================================================
    PROCEDURE BtnExcluirVendClick()
        LOCAL loc_oErro
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        IF !USED("crVend") OR EOF("crVend")
            RETURN
        ENDIF
        IF !MsgConfirma("Excluir o vendedor selecionado?")
            RETURN
        ENDIF
        TRY
            DELETE IN crVend
            SELECT crVend
            PACK
            IF RECCOUNT("crVend") = 0
                APPEND BLANK
            ENDIF
            IF RECCOUNT("crVend") > 0
                GO BOTTOM IN crVend
            ENDIF
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Vendedores", 5)
                THIS.pgf_4c_Paginas.Page2.grd_4c_Vendedores.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao excluir vendedor:" + CHR(13) + ;
                loc_oErro.Message, "FormReg.BtnExcluirVendClick")
        ENDTRY
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\RegBO.prg):
*====================================================================
* RegBO.prg
*
* Business Object para Cadastro de Regioes
* Tabela principal : SigCdReg (regiaos, descs, skchaves)
* Tabela filha     : SigCdRgi (municipios tipos='M' e vendedores tipos='C')
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS RegBO AS BusinessBase

    *-- ----------------------------------------------------------------
    *-- Propriedades da entidade principal (SigCdReg)
    *-- ----------------------------------------------------------------
    this_cRegiaos   = ""    && regiaos  char(10)  - PK
    this_cDescs     = ""    && descs    char(30)
    this_cSkChaves  = ""    && skchaves char(20)  - chave UUID (liga SigCdRgi)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdReg"
            THIS.this_cCampoChave = "regiaos"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "RegBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cRegiaos  = TratarNulo(regiaos,  "C")
                THIS.this_cDescs    = TratarNulo(descs,    "C")
                THIS.this_cSkChaves = TratarNulo(skchaves, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "RegBO.CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Seleciona todas as regioes para o grid de listagem
    * par_cFiltro: filtro opcional (nao usado - mantido por padrao)
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT regiaos, descs, skchaves" + ;
                       " FROM SigCdReg" + ;
                       " ORDER BY regiaos"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult < 0
                MsgErro("Erro ao buscar regi" + CHR(245) + "es: " + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "RegBO.Buscar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega uma regiao pelo codigo (PK)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cRegiaos)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT regiaos, descs, skchaves" + ;
                       " FROM SigCdReg" + ;
                       " WHERE regiaos = " + EscaparSQL(ALLTRIM(par_cRegiaos))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult < 0
                MsgErro("Erro ao carregar regi" + CHR(227) + "o: " + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "RegBO.CarregarPorCodigo")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * BuscarMunicipios - Carrega municipios da regiao no crMuni
    * par_cSkChaves: skchaves da regiao
    *====================================================================
    PROCEDURE BuscarMunicipios(par_cSkChaves)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED("crMuni")
                USE IN crMuni
            ENDIF

            IF EMPTY(ALLTRIM(par_cSkChaves))
                *-- Regiao nova: criar cursor vazio com linha em branco
                SET NULL ON
                CREATE CURSOR crMuni (skchaves C(20), pkChaves C(20), ;
                    codibges C(7), tipos C(1), iclis C(10), munici C(40), uf C(2))
                SET NULL OFF
                APPEND BLANK
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT DISTINCT a.skchaves, a.pkChaves, a.codibges, a.tipos," + ;
                           " c.descs AS munici, d.estados AS uf" + ;
                           " FROM SigCdRgi a" + ;
                           " LEFT JOIN sigcdmun c ON c.codigos = a.codibges" + ;
                           " LEFT JOIN sigcdufs d ON d.ufibges = c.ufibges" + ;
                           " WHERE a.skchaves = " + EscaparSQL(ALLTRIM(par_cSkChaves)) + ;
                           " AND a.tipos = 'M'" + ;
                           " ORDER BY c.descs"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MuniTemp")
                IF loc_nResult < 0
                    MsgErro("Erro ao carregar munic" + CHR(237) + "pios: " + CapturarErroSQL(), "Erro SQL")
                ELSE
                    SET NULL ON
                    CREATE CURSOR crMuni (skchaves C(20), pkChaves C(20), ;
                        codibges C(7), tipos C(1), iclis C(10), munici C(40), uf C(2))
                    SET NULL OFF

                    IF RECCOUNT("cursor_4c_MuniTemp") > 0
                        APPEND FROM DBF("cursor_4c_MuniTemp")
                    ENDIF

                    IF RECCOUNT("crMuni") = 0
                        APPEND BLANK
                    ENDIF

                    GO TOP IN crMuni
                    loc_lSucesso = .T.
                ENDIF

                IF USED("cursor_4c_MuniTemp")
                    USE IN cursor_4c_MuniTemp
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "RegBO.BuscarMunicipios")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * BuscarVendedores - Carrega vendedores/clientes da regiao no crVend
    * par_cSkChaves: skchaves da regiao
    *====================================================================
    PROCEDURE BuscarVendedores(par_cSkChaves)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED("crVend")
                USE IN crVend
            ENDIF

            IF EMPTY(ALLTRIM(par_cSkChaves))
                *-- Regiao nova: criar cursor vazio com linha em branco
                SET NULL ON
                CREATE CURSOR crVend (skchaves C(20), pkChaves C(20), ;
                    codibges C(7), tipos C(1), iclis C(10), vend C(50))
                SET NULL OFF
                APPEND BLANK
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT DISTINCT a.skchaves, a.pkChaves, a.codibges, a.tipos," + ;
                           " a.iclis, c.razaos AS vend" + ;
                           " FROM SigCdRgi a" + ;
                           " LEFT JOIN sigcdcli c ON c.iclis = a.iclis" + ;
                           " WHERE a.skchaves = " + EscaparSQL(ALLTRIM(par_cSkChaves)) + ;
                           " AND a.tipos = 'C'" + ;
                           " ORDER BY c.razaos"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VendTemp")
                IF loc_nResult < 0
                    MsgErro("Erro ao carregar vendedores: " + CapturarErroSQL(), "Erro SQL")
                ELSE
                    SET NULL ON
                    CREATE CURSOR crVend (skchaves C(20), pkChaves C(20), ;
                        codibges C(7), tipos C(1), iclis C(10), vend C(50))
                    SET NULL OFF

                    IF RECCOUNT("cursor_4c_VendTemp") > 0
                        APPEND FROM DBF("cursor_4c_VendTemp")
                    ENDIF

                    IF RECCOUNT("crVend") = 0
                        APPEND BLANK
                    ENDIF

                    GO TOP IN crVend
                    loc_lSucesso = .T.
                ENDIF

                IF USED("cursor_4c_VendTemp")
                    USE IN cursor_4c_VendTemp
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "RegBO.BuscarVendedores")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * InserirFilhos - Insere registros em SigCdRgi a partir de crMuni e crVend
    * par_cSkChaves: skchaves da regiao (recem gerado ou existente)
    *====================================================================
    PROTECTED PROCEDURE InserirFilhos(par_cSkChaves)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cPkChaves
        loc_lSucesso = .T.
        TRY
            *-- Inserir municipios do crMuni (tipos='M', codibges nao vazio)
            IF USED("crMuni")
                SELECT crMuni
                GO TOP
                SCAN
                    IF !EMPTY(ALLTRIM(crMuni.codibges)) .AND. !DELETED()
                        loc_cPkChaves = fUniqueIds()
                        loc_cSQL = "INSERT INTO SigCdRgi" + ;
                                   " (pkChaves, skchaves, codibges, tipos, iclis)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(loc_cPkChaves) + ", " + ;
                                   EscaparSQL(ALLTRIM(par_cSkChaves)) + ", " + ;
                                   EscaparSQL(ALLTRIM(crMuni.codibges)) + ", 'M', '')"
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsMuni")
                        IF USED("cursor_4c_InsMuni")
                            USE IN cursor_4c_InsMuni
                        ENDIF
                        IF loc_nResult < 0
                            MsgErro("Erro ao inserir munic" + CHR(237) + "pio: " + ;
                                    CapturarErroSQL(), "Erro SQL")
                            loc_lSucesso = .F.
                            EXIT
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF

            *-- Inserir vendedores do crVend (tipos='C', iclis nao vazio)
            IF loc_lSucesso AND USED("crVend")
                SELECT crVend
                GO TOP
                SCAN
                    IF !EMPTY(ALLTRIM(crVend.iclis)) .AND. !DELETED()
                        loc_cPkChaves = fUniqueIds()
                        loc_cSQL = "INSERT INTO SigCdRgi" + ;
                                   " (pkChaves, skchaves, codibges, tipos, iclis)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(loc_cPkChaves) + ", " + ;
                                   EscaparSQL(ALLTRIM(par_cSkChaves)) + ", '', 'C', " + ;
                                   EscaparSQL(ALLTRIM(crVend.iclis)) + ")"
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsVend")
                        IF USED("cursor_4c_InsVend")
                            USE IN cursor_4c_InsVend
                        ENDIF
                        IF loc_nResult < 0
                            MsgErro("Erro ao inserir vendedor: " + CapturarErroSQL(), "Erro SQL")
                            loc_lSucesso = .F.
                            EXIT
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "RegBO.InserirFilhos")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - INSERT na tabela SigCdReg + filhos em SigCdRgi
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cSkChaves
        loc_lSucesso = .F.
        TRY
            *-- Gerar chave UUID para skchaves
            loc_cSkChaves = fUniqueIds()
            THIS.this_cSkChaves = loc_cSkChaves

            loc_cSQL = "INSERT INTO SigCdReg (regiaos, descs, skchaves)" + ;
                       " VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cRegiaos)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDescs)) + ", " + ;
                       EscaparSQL(loc_cSkChaves) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsReg")
            IF USED("cursor_4c_InsReg")
                USE IN cursor_4c_InsReg
            ENDIF

            IF loc_nResult < 0
                MsgErro("Erro ao inserir regi" + CHR(227) + "o:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = THIS.InserirFilhos(loc_cSkChaves)
                IF loc_lSucesso
                    THIS.RegistrarAuditoria("INSERT")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "RegBO.Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - UPDATE em SigCdReg + rebuild de SigCdRgi
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            *-- Atualizar descricao (regiaos nao pode ser alterado)
            loc_cSQL = "UPDATE SigCdReg" + ;
                       " SET descs = " + EscaparSQL(ALLTRIM(THIS.this_cDescs)) + ;
                       " WHERE regiaos = " + EscaparSQL(ALLTRIM(THIS.this_cRegiaos))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdReg")
            IF USED("cursor_4c_UpdReg")
                USE IN cursor_4c_UpdReg
            ENDIF

            IF loc_nResult < 0
                MsgErro("Erro ao atualizar regi" + CHR(227) + "o:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- Remover todos os filhos existentes e reinserir
                loc_cSQL = "DELETE FROM SigCdRgi" + ;
                           " WHERE skchaves = " + EscaparSQL(ALLTRIM(THIS.this_cSkChaves))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelRgi")
                IF USED("cursor_4c_DelRgi")
                    USE IN cursor_4c_DelRgi
                ENDIF

                IF loc_nResult < 0
                    MsgErro("Erro ao remover municipios/vendedores:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                ELSE
                    loc_lSucesso = THIS.InserirFilhos(ALLTRIM(THIS.this_cSkChaves))
                    IF loc_lSucesso
                        THIS.RegistrarAuditoria("UPDATE")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "RegBO.Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - DELETE de SigCdRgi + SigCdReg
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            *-- Excluir filhos primeiro (integridade referencial)
            loc_cSQL = "DELETE FROM SigCdRgi" + ;
                       " WHERE skchaves = " + EscaparSQL(ALLTRIM(THIS.this_cSkChaves))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelRgi")
            IF USED("cursor_4c_DelRgi")
                USE IN cursor_4c_DelRgi
            ENDIF

            IF loc_nResult < 0
                MsgErro("Erro ao excluir municipios/vendedores:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- Excluir regiao principal
                loc_cSQL = "DELETE FROM SigCdReg" + ;
                           " WHERE regiaos = " + EscaparSQL(ALLTRIM(THIS.this_cRegiaos))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelReg")
                IF USED("cursor_4c_DelReg")
                    USE IN cursor_4c_DelReg
                ENDIF

                IF loc_nResult < 0
                    MsgErro("Erro ao excluir regi" + CHR(227) + "o:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                ELSE
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "RegBO.ExecutarExclusao")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cRegiaos)
    ENDPROC

ENDDEFINE

