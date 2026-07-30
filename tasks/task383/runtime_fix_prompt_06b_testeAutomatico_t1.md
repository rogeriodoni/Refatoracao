# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 0% < 100%. Falhas: Teste 'Instanciacao': CREATEOBJECT retornou valor nao-objeto

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[30/07/2026 01:29:30 AM] Erro: Erro em: Formcrf.InicializarForm | Linha: 637 | Property FORECOLOR is not found. | Detalhes: FORECOLOR | Procedure: configurarpaginadados


### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-30 01:28:47] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-30 01:28:47] [INFO] Config FPW: (nao fornecido)
[2026-07-30 01:28:47] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-30 01:28:47] [INFO] Timeout: 300 segundos
[2026-07-30 01:28:47] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_i0k3uk1z.prg
[2026-07-30 01:28:47] [INFO] Conteudo do wrapper:
[2026-07-30 01:28:47] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formcrf', 'C:\4c\tasks\task383', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formcrf', 'C:\4c\tasks\task383', 'CRUD'
QUIT

[2026-07-30 01:28:47] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_i0k3uk1z.prg
[2026-07-30 01:28:47] [INFO] VFP output esperado em: C:\4c\tasks\task383\vfp_output.txt
[2026-07-30 01:28:47] [INFO] Executando Visual FoxPro 9...
[2026-07-30 01:28:47] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_i0k3uk1z.prg
[2026-07-30 01:28:47] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_i0k3uk1z.prg
[2026-07-30 01:28:47] [INFO] Timeout configurado: 300 segundos
[2026-07-30 01:29:30] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-30 01:29:30] [INFO] VFP9 finalizado em 42.4621057 segundos
[2026-07-30 01:29:30] [INFO] Exit Code: 
[2026-07-30 01:29:30] [INFO] 
[2026-07-30 01:29:30] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-30 01:29:30] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_i0k3uk1z.prg
[2026-07-30 01:29:30] [INFO] 
[2026-07-30 01:29:30] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-30 01:29:30] [INFO] * Auto-generated wrapper for parameters
[2026-07-30 01:29:30] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-30 01:29:30] [INFO] * Parameters: 'Formcrf', 'C:\4c\tasks\task383', 'CRUD'
[2026-07-30 01:29:30] [INFO] 
[2026-07-30 01:29:30] [INFO] * Anti-dialog protections for unattended execution
[2026-07-30 01:29:30] [INFO] SET SAFETY OFF
[2026-07-30 01:29:30] [INFO] SET RESOURCE OFF
[2026-07-30 01:29:30] [INFO] SET TALK OFF
[2026-07-30 01:29:30] [INFO] SET NOTIFY OFF
[2026-07-30 01:29:30] [INFO] SYS(2335, 0)
[2026-07-30 01:29:30] [INFO] 
[2026-07-30 01:29:30] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formcrf', 'C:\4c\tasks\task383', 'CRUD'
[2026-07-30 01:29:30] [INFO] QUIT
[2026-07-30 01:29:30] [INFO] 
[2026-07-30 01:29:30] [INFO] === Fim do Wrapper.prg ===
[2026-07-30 01:29:30] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formcrf",
  "timestamp": "20260730012930",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": false,
      "erro": "CREATEOBJECT retornou valor nao-objeto",
      "detalhes": ""
    }
  ],
  "resumo": {
    "total": 1,
    "passou": 0,
    "falhou": 1,
    "percentual": 0
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

### FORM (C:\4c\projeto\app\forms\cadastros\Formcrf.prg):
*============================================================================
* Formcrf.prg - Formulario Contagem de Referencia (SIGCDCRF)
* Herda de FormBase
* Tabela principal: SigCdCrf (cabecalho), SigCdCri (itens)
* Fase 8/8 - COMPLETO: Todos os eventos e metodos auxiliares implementados
*============================================================================

DEFINE CLASS Formcrf AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais (PILAR 1 - UX fidelity)
    *--------------------------------------------------------------------------
    Height      = 600
    Width       = 1000
    Caption     = "Contagem de Refer" + CHR(234) + "ncia"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    ClipControls = .F.
    Themes      = .F.
    BorderStyle = 2
    DataSession = 2

    *--------------------------------------------------------------------------
    * Propriedades de estado do form
    *--------------------------------------------------------------------------
    this_cModoAtual   = "LISTA"
    this_cFiltroLista = ""

    *==========================================================================
    * Init - Apenas DODEFAULT (FormBase.Init chama InicializarForm)
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
        CATCH TO loException
            MostrarErro(loException, "Formcrf.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * InicializarForm - Inicializa BO e componentes visuais
    * Chamado pelo FormBase.Init() automaticamente
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            *-- Cria Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("crfBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar crfBO.", "Formcrf.InicializarForm")
            ELSE
                *-- Configura estrutura visual
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                *-- Propaga Caption para labels do cabecalho
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Carrega dados iniciais (pula durante ValidarUIFidelity)
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MostrarErro(loException, "Formcrf.InicializarForm")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria PageFrame com 2 paginas
    * Usa Top=-29 para esconder as abas (padrao frmcadastro)
    * TODOS os controles dentro das Pages devem compensar +29 no Top
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .PageCount  = 2
            .Top        = -29
            .Left       = 0
            .Width      = 1003
            .Height     = 635
            .Tabs       = .F.
            .Visible    = .T.
            .Page1.Caption = "Lista"
            .Page1.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            .Page2.Caption = "Dados"
            .Page2.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Page1: Cabecalho + Botoes CRUD + Grid
    * Top dos controles = Top_original + 29 (compensacao PageFrame)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container cabecalho cinza (cntSombra: Top=1, +29 = 30)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top           = 30
            .Left          = -1
            .Width         = 1004
            .Height        = 80
            .BackColor     = RGB(100, 100, 100)
            .BackStyle     = 1
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Visible       = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 15
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Caption   = "Contagem de Refer" + CHR(234) + "ncia"
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Caption   = "Contagem de Refer" + CHR(234) + "ncia"
            ENDWITH
        ENDWITH

        *-- Container botoes CRUD (Grupo_op: Left=543, Top=-1, +29 = 29)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top           = 29
            .Left          =  542
            .Width         = 390
            .Height        = 85
            .BackColor     = RGB(53, 53, 53)
            .BackStyle     = 1
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Visible       = .T.

            .AddObject("cmd_4c_Incluir", "CommandButton")
            WITH .cmd_4c_Incluir
                .Caption         = "Incluir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            =  542
                .Width           = 75
                .Height          = 75
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
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
            ENDWITH
        ENDWITH

        *-- Container saida - PADRAO CANONICO Left=917 (CLAUDE.md regra #10)
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
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
            ENDWITH
        ENDWITH

        *-- Container botoes especiais (cmdEspelho/Fecha/Abre: Top=82, +29 = 111)
        loc_oPagina.AddObject("cnt_4c_BotoesEspeciais", "Container")
        WITH loc_oPagina.cnt_4c_BotoesEspeciais
            .Top         = 111
            .Left        = 4
            .Width       = 340
            .Height      = 50
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.

            *-- Espelho: Left=14(abs) - 4(cnt.Left) = 10
            .AddObject("cmd_4c_Espelho", "CommandButton")
            WITH .cmd_4c_Espelho
                .Caption       = "Espelho"
                .Top           = 5
                .Left          = 10
                .Width         = 105
                .Height        = 40
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(220, 220, 220)
                .SpecialEffect = 0
                .MousePointer  = 15
            ENDWITH

            *-- Fechar contagem: Left=119(abs) - 4(cnt.Left) = 115
            .AddObject("cmd_4c_FecharContagem", "CommandButton")
            WITH .cmd_4c_FecharContagem
                .Caption       = "Fechar"
                .Top           = 5
                .Left          = 115
                .Width         = 105
                .Height        = 40
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(220, 220, 220)
                .Themes        = .F.
                .SpecialEffect = 0
                .MousePointer  = 15
            ENDWITH

            *-- Abrir contagem: Left=224(abs) - 4(cnt.Left) = 220
            .AddObject("cmd_4c_AbrirContagem", "CommandButton")
            WITH .cmd_4c_AbrirContagem
                .Caption       = "Abrir"
                .Top           = 5
                .Left          = 220
                .Width         = 105
                .Height        = 40
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(220, 220, 220)
                .Themes        = .F.
                .SpecialEffect = 0
                .MousePointer  = 15
            ENDWITH
        ENDWITH

        *-- Grid principal da lista (Grade na Page1: Top=162, Width=913, Height=400)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oPagina.grd_4c_Lista.ColumnCount = 5
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 162
            .Left               = 0
            .Width              = 913
            .Height             = 400
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
        ENDWITH

        *-- BINDEVENT: botoes CRUD
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")

        *-- BINDEVENT: botoes especiais
        BINDEVENT(loc_oPagina.cnt_4c_BotoesEspeciais.cmd_4c_Espelho,        "Click", THIS, "BtnEspelhoClick")
        BINDEVENT(loc_oPagina.cnt_4c_BotoesEspeciais.cmd_4c_FecharContagem, "Click", THIS, "BtnFecharContagemClick")
        BINDEVENT(loc_oPagina.cnt_4c_BotoesEspeciais.cmd_4c_AbrirContagem,  "Click", THIS, "BtnAbrirContagemClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Page2: Campos principais (Fase 5/8 - primeira metade)
    * Top dos controles = Top_original + 29 (compensacao PageFrame.Top=-29)
    * Fase 5: cnt_4c_Salva + labels + txt_4c_Codigo/Conta/DConta + Line1
    * Fase 6: lbl_4c_Label5/7 + txt_4c_Busca/TotQt/DContas + opt + grd + img + shp
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container botoes Confirmar/Cancelar (Grupo_Salva: Top=11+29=40, Left=817)
        loc_oPagina.AddObject("cnt_4c_Salva", "Container")
        WITH loc_oPagina.cnt_4c_Salva
            .Top           = 40
            .Left          = 817
            .Width         = 160
            .Height        = 85
            .BackStyle     = 0
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Visible       = .T.

            .AddObject("cmd_4c_Confirmar", "CommandButton")
            WITH .cmd_4c_Confirmar
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
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
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
            ENDWITH
        ENDWITH

        *-- Label Codigo (Label4: Top=68+29=97, Left=205, Width=45)
        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Top       = 97
            .Left      = 205
            .Width     = 45
            .Height    = 15
            .Caption   = "C" + CHR(243) + "digo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
        ENDWITH

        *-- TextBox getCods = txt_4c_Codigo (Top=63+29=92, Left=254, readonly - When=.F.)
        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Top       = 92
            .Left      = 254
            .Width     = 80
            .Height    = 24
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(224, 224, 224)
            .ReadOnly  = .T.
            .Enabled   = .F.
            .MaxLength = 10
            .Value     = ""
        ENDWITH

        *-- Label Vendedor (Label2: Top=95+29=124, Left=192)
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Top       = 124
            .Left      = 192
            .Width     = 58
            .Height    = 15
            .Caption   = "Vendedor :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
        ENDWITH

        *-- TextBox getConta = txt_4c_Conta (Top=90+29=119, Left=254 - Vendedor code)
        *-- When: InList(pcEscolha, INSERIR, CONSULTAR) -> editavel so em INCLUIR
        loc_oPagina.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oPagina.txt_4c_Conta
            .Top       = 119
            .Left      = 254
            .Width     = 80
            .Height    = 24
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .MaxLength = 20
            .Value     = ""
        ENDWITH

        *-- TextBox getDConta = txt_4c_DConta (Top=90+29=119, Left=336, Width=290 - nome readonly)
        loc_oPagina.AddObject("txt_4c_DConta", "TextBox")
        WITH loc_oPagina.txt_4c_DConta
            .Top       = 119
            .Left      = 336
            .Width     = 290
            .Height    = 24
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(224, 224, 224)
            .ReadOnly  = .T.
            .Enabled   = .F.
            .Value     = ""
        ENDWITH

        *-- Label Conta (Label1: Top=177+29=206, Left=209)
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Top       = 206
            .Left      = 209
            .Width     = 41
            .Height    = 15
            .Caption   = "Conta :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
        ENDWITH

        *-- Label Busca Produto (Label3: Top=126+29=155, Left=169)
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Top       = 155
            .Left      = 169
            .Width     = 81
            .Height    = 15
            .Caption   = "Busca Produto :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
        ENDWITH

        *-- Label Procurar (Say3: Top=126+29=155, Left=373)
        loc_oPagina.AddObject("lbl_4c_Say3", "Label")
        WITH loc_oPagina.lbl_4c_Say3
            .Top       = 155
            .Left      = 373
            .Width     = 43
            .Height    = 15
            .Caption   = "Procurar"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
        ENDWITH

        *-- Linha separadora (Line1: Top=117+29=146, Left=165, Width=668)
        loc_oPagina.AddObject("lin_4c_Line1", "Line")
        WITH loc_oPagina.lin_4c_Line1
            .Top       = 146
            .Left      = 165
            .Width     = 668
            .Height    = 0
            .ForeColor = RGB(180, 180, 180)
            .Visible   = .T.
        ENDWITH

        *-- Label Quantidade (Label5: Top=152+29=181, Left=182)
        loc_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPagina.lbl_4c_Label5
            .Top       = 181
            .Left      = 182
            .Width     = 68
            .Height    = 15
            .Caption   = "Quantidade :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
        ENDWITH

        *-- Label Descricao (Label7: Top=576+29=605, Left=196)
        loc_oPagina.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPagina.lbl_4c_Label7
            .Top       = 605
            .Left      = 196
            .Width     = 55
            .Height    = 15
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
        ENDWITH

        *-- TextBox getBusca = txt_4c_Busca (Top=122+29=151, Left=254, Width=108)
        *-- Busca por codigo de barras ou codigo de produto (conforme opt_4c_OptBusca)
        loc_oPagina.AddObject("txt_4c_Busca", "TextBox")
        WITH loc_oPagina.txt_4c_Busca
            .Top       = 151
            .Left      = 254
            .Width     = 108
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .MaxLength = 20
            .Value     = ""
        ENDWITH

        *-- TextBox TotQt = txt_4c_TotQt (Top=148+29=177, Left=254, Width=80)
        *-- Quantidade a registrar; LostFocus atualiza csSigCdCri.QtdCtg
        loc_oPagina.AddObject("txt_4c_TotQt", "TextBox")
        WITH loc_oPagina.txt_4c_TotQt
            .Top       = 177
            .Left      = 254
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Value     = 0
        ENDWITH

        *-- OptionGroup Opt_Busca (Top=122+29=151, Left=414, Width=117)
        *-- Buttons(1): busca por Cod.Barra; Buttons(2): busca por Produto
        loc_oPagina.AddObject("opt_4c_OptBusca", "OptionGroup")
        WITH loc_oPagina.opt_4c_OptBusca
            .Top         = 151
            .Left        = 414
            .Width       = 122
            .Height      = 23
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_OptBusca.Buttons(1)
            .Caption   = "C" + CHR(243) + "d.Barra"
            .BackStyle = 0
            .Left      = 5
            .Top       = 3
            .Width     = 55
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.opt_4c_OptBusca.Buttons(2)
            .Caption   = "Produto"
            .BackStyle = 0
            .Left      = 63
            .Top       = 3
            .Width     = 49
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- Grid GrdLoc = grd_4c_Dados (Top=174+29=203, Left=254, Width=477, Height=396)
        *-- Exibe csSigCdCri: Emps|QtdCtg(edit)|qtde|Grupos|Estos|Descr
        loc_oPagina.AddObject("grd_4c_Dados", "Grid")
        loc_oPagina.grd_4c_Dados.ColumnCount = 6
        WITH loc_oPagina.grd_4c_Dados
            .Top                = 203
            .Left               = 254
            .Width              = 477
            .Height             = 396
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

            .Column1.Header1.Caption = "Emp."
            .Column1.Width           = 40
            .Column1.ReadOnly        = .T.

            .Column2.Header1.Caption = "Qtde."
            .Column2.Width           = 60

            .Column3.Header1.Caption = "Estoque"
            .Column3.Width           = 60
            .Column3.ReadOnly        = .T.

            .Column4.Header1.Caption = "Grupo"
            .Column4.Width           = 60
            .Column4.ReadOnly        = .T.

            .Column5.Header1.Caption = "Conta"
            .Column5.Width           = 80
            .Column5.ReadOnly        = .T.

            .Column6.Header1.Caption = "Produto"
            .Column6.Width           = 177
            .Column6.ReadOnly        = .T.
        ENDWITH

        *-- Image ImgJpg (Top=242+29=271, Left=746 - inicialmente invisivel)
        loc_oPagina.AddObject("img_4c_ImgJpg", "Image")
        WITH loc_oPagina.img_4c_ImgJpg
            .Top     = 271
            .Left    = 746
            .Width   = 241
            .Height  = 217
            .Visible = .F.
        ENDWITH

        *-- Shape ShpFigura (borda da area de imagem: Top=239+29=268, Left=743)
        loc_oPagina.AddObject("shp_4c_ShpFigura", "Shape")
        WITH loc_oPagina.shp_4c_ShpFigura
            .Top         = 268
            .Left        = 743
            .Width       = 247
            .Height      = 224
            .BorderColor = RGB(180, 180, 180)
            .FillStyle   = 1
            .BackStyle   = 0
            .Visible     = .T.
        ENDWITH

        *-- TextBox getDContas = txt_4c_DContas (Top=571+29=600, Left=254, Width=356)
        *-- Descricao do produto selecionado no grid (readonly)
        loc_oPagina.AddObject("txt_4c_DContas", "TextBox")
        WITH loc_oPagina.txt_4c_DContas
            .Top       = 600
            .Left      = 254
            .Width     = 356
            .Height    = 24
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(224, 224, 224)
            .ReadOnly  = .T.
            .Enabled   = .F.
            .Value     = ""
        ENDWITH

        *-- BINDEVENT: botoes Confirmar/Cancelar
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *-- BINDEVENT: lookup Vendedor
        BINDEVENT(loc_oPagina.txt_4c_Conta, "KeyPress", THIS, "ValidarConta")

        *-- BINDEVENT: busca de produto, quantidade, grid e opcao de busca
        BINDEVENT(loc_oPagina.txt_4c_Busca,    "KeyPress",         THIS, "ValidarBusca")
        BINDEVENT(loc_oPagina.txt_4c_TotQt,    "KeyPress",         THIS, "ValidarQuantidade")
        BINDEVENT(loc_oPagina.grd_4c_Dados,    "AfterRowColChange", THIS, "GridDadosAfterRowColChange")
        BINDEVENT(loc_oPagina.opt_4c_OptBusca, "InteractiveChange", THIS, "OptBuscaChanged")

        THIS.TornarControlesVisiveis(loc_oPagina)

        *-- Imagem do produto permanece invisivel ate selecionar produto com foto
        loc_oPagina.img_4c_ImgJpg.Visible = .F.
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega dados no grid da Page1 (cursor_4c_Dados)
    * Reconfigura RecordSource, ControlSource e Headers apos cada carga
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                IF VARTYPE(THIS.this_oBusinessObject) = "O"
                IF THIS.this_oBusinessObject.Buscar(THIS.this_cFiltroLista)
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                    *-- RecordSource + ColumnCount FORA do WITH (evita "Unknown member COLUMN1")
                    loc_oGrid.ColumnCount = 3
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.ColumnCount  = 3

                    WITH loc_oGrid
                        .Column1.ControlSource   = "cursor_4c_Dados.Datas"
                        .Column1.Width           = 80
                        .Column1.Header1.Caption = "Data"

                        .Column2.ControlSource   = "cursor_4c_Dados.Vends"
                        .Column2.Width           = 90
                        .Column2.Header1.Caption = "Vendedor"

                        .Column3.ControlSource   = "cursor_4c_Dados.Cods"
                        .Column3.Width           = 80
                        .Column3.Header1.Caption = "C" + CHR(243) + "digo"
                    ENDWITH

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "Formcrf.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *==========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                MostrarErro("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + ;
                    TRANSFORM(par_nPagina), "Formcrf.AlternarPagina")
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina

                IF par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                    THIS.CarregarLista()
                ELSE
                    THIS.CarregarGridItens()
                ENDIF

                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "Formcrf.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos controles visiveis recursivamente
    * Itera Pages de PageFrames e Controls de Containers
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_CABECALHO")
                    LOOP
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

                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * FormatarGridLista - Formata visual do grid principal da lista
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Abre Page2 para nova contagem
    * Carrega parametros (GrPadVens) e produtos do estoque em csSigCdCri
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        IF !THIS.this_oBusinessObject.CarregarParametros()
            RETURN
        ENDIF

        THIS.this_oBusinessObject.NovoRegistro()
        THIS.this_oBusinessObject.this_cEmps = go_4c_Sistema.cCodEmpresa

        IF !THIS.this_oBusinessObject.CarregarProdutosEstoque()
            MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar " + ;
                     "produtos do estoque.")
            RETURN
        ENDIF

        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AlternarPagina(2)
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Abre Page2 em modo visualizacao (somente leitura)
    * Mostra apenas itens contados (par_lSoContados=.T.)
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCods

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") ;
                OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhuma contagem selecionada.")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCods = ALLTRIM(TratarNulo(Cods, "C"))

        IF EMPTY(loc_cCods)
            MsgAviso("C" + CHR(243) + "digo inv" + CHR(225) + "lido.")
            RETURN
        ENDIF

        IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCods)
            RETURN
        ENDIF

        IF !THIS.this_oBusinessObject.CarregarItensContagem(loc_cCods, .T.)
            RETURN
        ENDIF

        THIS.BOParaForm()
        THIS.this_cModoAtual = "VISUALIZAR"
        THIS.HabilitarCampos(.F.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Abre Page2 para edicao de contagem existente
    * Bloqueia se contagem esta encerrada (Conferido=1)
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCods, loc_nConferido

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") ;
                OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhuma contagem selecionada.")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCods      = ALLTRIM(TratarNulo(Cods,      "C"))
        loc_nConferido = TratarNulo(Conferido, "N")

        IF loc_nConferido = 1
            MsgAviso("Contagem J" + CHR(225) + " Encerrada!!!")
            RETURN
        ENDIF

        IF !THIS.this_oBusinessObject.CarregarParametros()
            RETURN
        ENDIF

        IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCods)
            RETURN
        ENDIF

        IF !THIS.this_oBusinessObject.CarregarItensContagem(loc_cCods, .F.)
            RETURN
        ENDIF

        THIS.this_oBusinessObject.EditarRegistro()
        THIS.BOParaForm()
        THIS.this_cModoAtual = "ALTERAR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Exclui contagem selecionada (cabecalho + itens)
    * Bloqueia se contagem encerrada; pede confirmacao antes de excluir
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCods, loc_nConferido

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") ;
                OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhuma contagem selecionada.")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCods      = ALLTRIM(TratarNulo(Cods,      "C"))
        loc_nConferido = TratarNulo(Conferido, "N")

        IF loc_nConferido = 1
            MsgAviso("Contagem J" + CHR(225) + " Encerrada. " + ;
                     "Reabra antes de excluir.")
            RETURN
        ENDIF

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o desta contagem?", ;
                        "Confirmar Exclus" + CHR(227) + "o")
            RETURN
        ENDIF

        IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCods)
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.Excluir()
            MsgInfo("Contagem exclu" + CHR(237) + "da com sucesso!")
            THIS.this_cFiltroLista = ""
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Filtra lista de contagens por codigo ou vendedor
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_cBusca, loc_cFiltro
        loc_cBusca = INPUTBOX("Pesquisar contagem (c" + CHR(243) + "digo ou vendedor):", ;
                               "Buscar Contagem", "")
        loc_cFiltro = ""
        IF !EMPTY(loc_cBusca)
            loc_cBusca  = ALLTRIM(loc_cBusca)
            loc_cFiltro = "a.Cods LIKE '%" + loc_cBusca + "%'" + ;
                          " OR a.Vends LIKE '%" + loc_cBusca + "%'" + ;
                          " OR b.Rclis LIKE '%" + loc_cBusca + "%'"
        ENDIF
        THIS.this_cFiltroLista = loc_cFiltro
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Salva contagem (Confirmar na Page2)
    * Valida vendedor, transfere Form->BO e chama Salvar()
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Validacao: Vendedor obrigatorio em INCLUIR/ALTERAR
        IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Conta.Value))
                MsgAviso("Vendedor obrigat" + CHR(243) + "rio!")
                loc_oPagina.txt_4c_Conta.SetFocus()
                RETURN
            ENDIF
        ENDIF

        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Contagem salva com sucesso!")
            THIS.this_cFiltroLista = ""
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela e volta para lista
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *==========================================================================
    * BtnEspelhoClick - Recarrega csSigCdCri com produtos do estoque (SigMvEst)
    * Bloqueia se contagem encerrada; pede confirmacao antes de recarregar
    *==========================================================================
    PROCEDURE BtnEspelhoClick()
        LOCAL loc_nConferido

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") ;
                OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhuma contagem selecionada.")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_nConferido = TratarNulo(Conferido, "N")

        IF loc_nConferido = 1
            MsgAviso("Contagem J" + CHR(225) + " Encerrada!!!")
            RETURN
        ENDIF

        IF !MsgConfirma("Deseja gerar espelho do estoque para esta contagem?", "Espelho")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarProdutosEstoque()
            MsgInfo("Espelho de estoque gerado com sucesso!")
            THIS.CarregarGridItens()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnFecharContagemClick - Encerra contagem (Conferido=1)
    * Pede confirmacao e bloqueia se ja encerrada
    *==========================================================================
    PROCEDURE BtnFecharContagemClick()
        LOCAL loc_cCods, loc_nConferido

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") ;
                OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhuma contagem selecionada.")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCods      = ALLTRIM(TratarNulo(Cods,      "C"))
        loc_nConferido = TratarNulo(Conferido, "N")

        IF loc_nConferido = 1
            MsgAviso("Contagem J" + CHR(225) + " Encerrada!!!")
            RETURN
        ENDIF

        IF !MsgConfirma("Esta Contagem ser" + CHR(225) + " Finalizada. " + ;
                        "Deseja encerrar a Contagem???", ;
                        "ATEN" + CHR(199) + CHR(195) + "O !!!")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.EncerrarContagem(loc_cCods)
            MsgInfo("Contagem encerrada com sucesso!")
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAbrirContagemClick - Reabre contagem encerrada (Conferido=0)
    * Pede confirmacao e bloqueia se ainda nao encerrada
    *==========================================================================
    PROCEDURE BtnAbrirContagemClick()
        LOCAL loc_cCods, loc_nConferido

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") ;
                OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhuma contagem selecionada.")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cCods      = ALLTRIM(TratarNulo(Cods,      "C"))
        loc_nConferido = TratarNulo(Conferido, "N")

        IF loc_nConferido = 0
            MsgAviso("Contagem N" + CHR(227) + "o est" + CHR(225) + " Encerrada!!!")
            RETURN
        ENDIF

        IF !MsgConfirma("Esta Contagem ser" + CHR(225) + " Aberta Novamente. " + ;
                        "Deseja Continuar a Contagem???", ;
                        "ATEN" + CHR(199) + CHR(195) + "O !!!")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.ReabrirContagem(loc_cCods)
            MsgInfo("Contagem reaberta com sucesso!")
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarConta - LostFocus do txt_4c_Conta: busca vendedor pelo codigo
    * Preenche txt_4c_DConta com nome; se multiplos resultados abre picker
    *==========================================================================
    PROCEDURE ValidarConta
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_oPagina, loc_cCodigo
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)

        IF EMPTY(loc_cCodigo)
            loc_oPagina.txt_4c_DConta.Value = ""
            THIS.this_oBusinessObject.this_cVends    = ""
            THIS.this_oBusinessObject.this_cDesVends = ""
            RETURN
        ENDIF

        IF !THIS.this_oBusinessObject.BuscarVendedores(loc_cCodigo, "Iclis")
            RETURN
        ENDIF

        IF !USED("cursor_4c_Vendedores") OR RECCOUNT("cursor_4c_Vendedores") = 0
            MsgAviso("Vendedor n" + CHR(227) + "o encontrado!")
            loc_oPagina.txt_4c_Conta.Value  = ""
            loc_oPagina.txt_4c_DConta.Value = ""
            IF USED("cursor_4c_Vendedores")
                USE IN cursor_4c_Vendedores
            ENDIF
            loc_oPagina.txt_4c_Conta.SetFocus()
            RETURN
        ENDIF

        IF RECCOUNT("cursor_4c_Vendedores") = 1
            SELECT cursor_4c_Vendedores
            GO TOP
            loc_oPagina.txt_4c_Conta.Value  = ALLTRIM(Iclis)
            loc_oPagina.txt_4c_DConta.Value = ALLTRIM(Rclis)
            THIS.this_oBusinessObject.this_cVends    = ALLTRIM(Iclis)
            THIS.this_oBusinessObject.this_cDesVends = ALLTRIM(Rclis)
            IF USED("cursor_4c_Vendedores")
                USE IN cursor_4c_Vendedores
            ENDIF
        ELSE
            THIS.AbrirBuscaVendedor(loc_cCodigo)
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirBuscaVendedor - Abre FormBuscaAuxiliar no cursor_4c_Vendedores
    * Chamado quando ha multiplos resultados no lookup de Vendedor
    *==========================================================================
    PROTECTED PROCEDURE AbrirBuscaVendedor(par_cValorInicial)
        LOCAL loc_oBusca, loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.BuscarVendedores(par_cValorInicial, "Iclis")

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")

        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.this_cCursorDestino = "cursor_4c_Vendedores"
            loc_oBusca.this_cTitulo        = "Selecionar Vendedor"
            loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Rclis", "", "Nome")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Vendedores")
                SELECT cursor_4c_Vendedores
                loc_oPagina.txt_4c_Conta.Value  = ALLTRIM(Iclis)
                loc_oPagina.txt_4c_DConta.Value = ALLTRIM(Rclis)
                THIS.this_oBusinessObject.this_cVends    = ALLTRIM(Iclis)
                THIS.this_oBusinessObject.this_cDesVends = ALLTRIM(Rclis)
            ELSE
                loc_oPagina.txt_4c_Conta.Value  = ""
                loc_oPagina.txt_4c_DConta.Value = ""
            ENDIF

            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_Vendedores")
            USE IN cursor_4c_Vendedores
        ENDIF
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere valores da Page2 para o Business Object
    * Campos de itens (grd_4c_Dados) gerenciados via csSigCdCri diretamente
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        TRY
            THIS.this_oBusinessObject.this_cVends    = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)
            THIS.this_oBusinessObject.this_cDesVends = ALLTRIM(loc_oPagina.txt_4c_DConta.Value)
            THIS.this_oBusinessObject.this_cEmps     = go_4c_Sistema.cCodEmpresa
        CATCH TO loException
            MostrarErro(loException, "Formcrf.FormParaBO")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere valores do Business Object para a Page2
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oPagina.txt_4c_Codigo.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cCods)
            loc_oPagina.txt_4c_Conta.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cVends)
            loc_oPagina.txt_4c_DConta.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cDesVends)
        CATCH TO loException
            MostrarErro(loException, "Formcrf.BOParaForm")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa valores dos campos da Page2
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oPagina.txt_4c_Codigo.Value   = ""
            loc_oPagina.txt_4c_Conta.Value    = ""
            loc_oPagina.txt_4c_DConta.Value   = ""
            loc_oPagina.txt_4c_Busca.Value    = ""
            loc_oPagina.txt_4c_TotQt.Value    = 0
            loc_oPagina.txt_4c_DContas.Value  = ""
            loc_oPagina.opt_4c_OptBusca.Value = 1
            loc_oPagina.img_4c_ImgJpg.Visible = .F.
            loc_oPagina.img_4c_ImgJpg.Picture = ""
        CATCH TO loException
            MostrarErro(loException, "Formcrf.LimparCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita campos editaveis da Page2
    * txt_4c_Codigo: sempre readonly
    * txt_4c_Conta: editavel so em INCLUIR
    * txt_4c_Busca/TotQt: editaveis em INCLUIR/ALTERAR
    * grd_4c_Dados.Column2 (QtdCtg): editavel em INCLUIR/ALTERAR
    * txt_4c_DContas: sempre readonly
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina, loc_lEditarConta
        loc_oPagina      = THIS.pgf_4c_Paginas.Page2
        loc_lEditarConta = par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR"

        TRY
            *-- txt_4c_Codigo: sempre readonly
            loc_oPagina.txt_4c_Codigo.ReadOnly  = .T.
            loc_oPagina.txt_4c_Codigo.Enabled   = .F.
            loc_oPagina.txt_4c_Codigo.BackColor = RGB(224, 224, 224)

            *-- txt_4c_Conta: editavel apenas no modo INCLUIR
            loc_oPagina.txt_4c_Conta.ReadOnly  = !loc_lEditarConta
            loc_oPagina.txt_4c_Conta.Enabled   = loc_lEditarConta
            loc_oPagina.txt_4c_Conta.BackColor = IIF(loc_lEditarConta, ;
                RGB(255, 255, 255), RGB(224, 224, 224))

            *-- txt_4c_DConta: sempre readonly (calculado do lookup)
            loc_oPagina.txt_4c_DConta.ReadOnly = .T.
            loc_oPagina.txt_4c_DConta.Enabled  = .F.

            *-- txt_4c_Busca: editavel em INCLUIR/ALTERAR
            loc_oPagina.txt_4c_Busca.ReadOnly  = !par_lHabilitar
            loc_oPagina.txt_4c_Busca.Enabled   = par_lHabilitar
            loc_oPagina.txt_4c_Busca.BackColor = IIF(par_lHabilitar, ;
                RGB(255, 255, 255), RGB(224, 224, 224))

            *-- txt_4c_TotQt: editavel em INCLUIR/ALTERAR
            loc_oPagina.txt_4c_TotQt.ReadOnly  = !par_lHabilitar
            loc_oPagina.txt_4c_TotQt.Enabled   = par_lHabilitar
            loc_oPagina.txt_4c_TotQt.BackColor = IIF(par_lHabilitar, ;
                RGB(255, 255, 255), RGB(224, 224, 224))

            *-- txt_4c_DContas: sempre readonly (descricao do produto selecionado)
            loc_oPagina.txt_4c_DContas.ReadOnly = .T.
            loc_oPagina.txt_4c_DContas.Enabled  = .F.

            *-- grd_4c_Dados.Column2 (QtdCtg): editavel em INCLUIR/ALTERAR
            IF PEMSTATUS(loc_oPagina, "grd_4c_Dados", 5)
                loc_oPagina.grd_4c_Dados.Column2.ReadOnly = !par_lHabilitar
            ENDIF

            *-- Botoes salva
            loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = par_lHabilitar
            loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.

        CATCH TO loException
            MostrarErro(loException, "Formcrf.HabilitarCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes de Page2 conforme modo
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPag2
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2

        TRY
            DO CASE
            CASE THIS.this_cModoAtual = "VISUALIZAR"
                loc_oPag2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = .F.
                loc_oPag2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
            CASE INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                loc_oPag2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = .T.
                loc_oPag2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
            ENDCASE
        CATCH TO loException
            *-- Silencioso
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarGridItens - Vincula grd_4c_Dados ao cursor csSigCdCri e formata
    * RecordSource e ColumnCount fora do WITH (Problema 36)
    * ControlSource e Headers redefinidos apos RecordSource (reset automatico)
    *==========================================================================
    PROTECTED PROCEDURE CarregarGridItens()
        LOCAL loc_oPagina, loc_oGrid, loc_cCursor
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        TRY
            IF PEMSTATUS(loc_oPagina, "grd_4c_Dados", 5)
                loc_oGrid   = loc_oPagina.grd_4c_Dados
                loc_cCursor = THIS.this_oBusinessObject.this_cCursorItens

                *-- RecordSource e ColumnCount FORA do WITH (evita "Unknown member COLUMN1")
                loc_oGrid.RecordSource = loc_cCursor
                loc_oGrid.ColumnCount  = 6

                WITH loc_oGrid
                    .Column1.ControlSource   = loc_cCursor + ".Emps"
                    .Column1.Width           = 40
                    .Column1.ReadOnly        = .T.
                    .Column1.Header1.Caption = "Emp."

                    .Column2.ControlSource   = loc_cCursor + ".QtdCtg"
                    .Column2.Width           = 60
                    .Column2.ReadOnly        = .F.
                    .Column2.Header1.Caption = "Qtde."

                    .Column3.ControlSource   = loc_cCursor + ".qtde"
                    .Column3.Width           = 60
                    .Column3.ReadOnly        = .T.
                    .Column3.Header1.Caption = "Estoque"

                    .Column4.ControlSource   = loc_cCursor + ".Grupos"
                    .Column4.Width           = 60
                    .Column4.ReadOnly        = .T.
                    .Column4.Header1.Caption = "Grupo"

                    .Column5.ControlSource   = loc_cCursor + ".Estos"
                    .Column5.Width           = 80
                    .Column5.ReadOnly        = .T.
                    .Column5.Header1.Caption = "Conta"

                    .Column6.ControlSource   = loc_cCursor + ".Descr"
                    .Column6.Width           = 177
                    .Column6.ReadOnly        = .T.
                    .Column6.Header1.Caption = "Produto"
                ENDWITH

                THIS.FormatarGridLista(loc_oGrid)
                loc_oGrid.Refresh()
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "Formcrf.CarregarGridItens")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarBusca - LostFocus de txt_4c_Busca
    * Busca produto em csSigCdCri por Cod.Barra (opt=1) ou Cpros (opt=2)
    * Posiciona cursor, atualiza txt_4c_DContas e foca txt_4c_TotQt
    *==========================================================================
    PROCEDURE ValidarBusca
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_oPagina, loc_cBusca, loc_nOpt, loc_nRecNo
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cBusca  = ALLTRIM(loc_oPagina.txt_4c_Busca.Value)
        loc_nOpt    = loc_oPagina.opt_4c_OptBusca.Value

        IF EMPTY(loc_cBusca) OR !USED("csSigCdCri")
            loc_oPagina.txt_4c_DContas.Value = ""
            RETURN
        ENDIF

        TRY
            IF loc_nOpt = 1
                SELECT RecNo() AS nRecNo FROM csSigCdCri ;
                    WHERE ALLTRIM(CBars) = m.loc_cBusca ;
                    INTO CURSOR csProcuraBusca
            ELSE
                SELECT RecNo() AS nRecNo FROM csSigCdCri ;
                    WHERE ALLTRIM(Cpros) = m.loc_cBusca ;
                    INTO CURSOR csProcuraBusca
            ENDIF

            IF USED("csProcuraBusca") AND !EOF("csProcuraBusca") AND RECCOUNT("csProcuraBusca") > 0
                SELECT csProcuraBusca
                GO TOP
                loc_nRecNo = nRecNo
                USE IN csProcuraBusca

                SELECT csSigCdCri
                GO loc_nRecNo
                loc_oPagina.txt_4c_DContas.Value = ALLTRIM(TratarNulo(Descr, "C"))
                loc_oPagina.grd_4c_Dados.Refresh()

                IF PEMSTATUS(loc_oPagina.txt_4c_TotQt, "SetFocus", 5)
                    loc_oPagina.txt_4c_TotQt.SetFocus()
                ENDIF
            ELSE
                IF USED("csProcuraBusca")
                    USE IN csProcuraBusca
                ENDIF
                MsgAviso("Produto n" + CHR(227) + "o encontrado.")
                loc_oPagina.txt_4c_DContas.Value = ""
                loc_oPagina.txt_4c_Busca.Value   = ""
                IF PEMSTATUS(loc_oPagina.txt_4c_Busca, "SetFocus", 5)
                    loc_oPagina.txt_4c_Busca.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loException
            IF USED("csProcuraBusca")
                USE IN csProcuraBusca
            ENDIF
            MostrarErro(loException, "Formcrf.ValidarBusca")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarQuantidade - LostFocus de txt_4c_TotQt
    * Grava QtdCtg no cursor csSigCdCri; limpa campos de busca e volta o foco
    *==========================================================================
    PROCEDURE ValidarQuantidade
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_oPagina, loc_nQtds, loc_cBusca, loc_nOpt
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_nQtds   = VAL(TRANSFORM(loc_oPagina.txt_4c_TotQt.Value))
        loc_cBusca  = ALLTRIM(loc_oPagina.txt_4c_Busca.Value)
        loc_nOpt    = loc_oPagina.opt_4c_OptBusca.Value

        IF EMPTY(loc_cBusca) OR !USED("csSigCdCri")
            RETURN
        ENDIF

        TRY
            IF loc_nOpt = 1
                UPDATE csSigCdCri SET QtdCtg = m.loc_nQtds ;
                    WHERE ALLTRIM(CBars) = m.loc_cBusca
            ELSE
                UPDATE csSigCdCri SET QtdCtg = m.loc_nQtds ;
                    WHERE ALLTRIM(Cpros) = m.loc_cBusca
            ENDIF

            loc_oPagina.txt_4c_Busca.Value    = ""
            loc_oPagina.txt_4c_TotQt.Value    = 0
            loc_oPagina.txt_4c_DContas.Value  = ""
            loc_oPagina.img_4c_ImgJpg.Visible = .F.
            loc_oPagina.img_4c_ImgJpg.Picture = ""
            loc_oPagina.grd_4c_Dados.Refresh()

            IF PEMSTATUS(loc_oPagina.txt_4c_Busca, "SetFocus", 5)
                loc_oPagina.txt_4c_Busca.SetFocus()
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "Formcrf.ValidarQuantidade")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GridDadosAfterRowColChange - AfterRowColChange do grd_4c_Dados
    * Atualiza descricao e imagem do produto ao navegar no grid
    *==========================================================================
    PROCEDURE GridDadosAfterRowColChange(par_nColIndex)
        LOCAL loc_oPagina, loc_cCpros, loc_cDescr
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF !USED("csSigCdCri") OR EOF("csSigCdCri")
            RETURN
        ENDIF

        TRY
            SELECT csSigCdCri
            loc_cCpros = ALLTRIM(TratarNulo(Cpros, "C"))
            loc_cDescr = ALLTRIM(TratarNulo(Descr, "C"))

            loc_oPagina.txt_4c_DContas.Value = loc_cDescr

            IF !EMPTY(loc_cCpros)
                THIS.CarregarImagemProduto(loc_cCpros)
            ELSE
                loc_oPagina.img_4c_ImgJpg.Visible = .F.
                loc_oPagina.img_4c_ImgJpg.Picture = ""
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "Formcrf.GridDadosAfterRowColChange")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarImagemProduto - Busca FigJpgs em SigCdPro e exibe na img_4c_ImgJpg
    * STRCONV(base64, 14) converte para binario uma unica vez + STRTOFILE salva temp
    *==========================================================================
    PROTECTED PROCEDURE CarregarImagemProduto(par_cCpros)
        LOCAL loc_oPagina, loc_cBase64, loc_cTmpFile, loc_cSQL, loc_nRetSQL
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_cSQL    = "SELECT FigJpgs FROM SigCdPro" + ;
                          " WHERE RTRIM(Cpros) = " + EscaparSQL(par_cCpros)
            loc_nRetSQL = SQLEXEC(gnConnHandle, loc_cSQL, "csImgProduto")

            IF loc_nRetSQL > 0 AND USED("csImgProduto") AND ;
                    !EOF("csImgProduto") AND !EMPTY(ALLTRIM(csImgProduto.FigJpgs))

                SELECT csImgProduto
                GO TOP
                loc_cBase64 = ALLTRIM(FigJpgs)

                IF "base64," $ loc_cBase64
                    loc_cBase64 = SUBSTR(loc_cBase64, AT("base64,", loc_cBase64) + 7)
                ENDIF

                IF !EMPTY(loc_cBase64)
                    loc_cTmpFile = SYS(2023) + "\4c_img_tmp.jpg"
                    STRTOFILE(STRCONV(loc_cBase64, 14), loc_cTmpFile)

                    IF FILE(loc_cTmpFile)
                        loc_oPagina.img_4c_ImgJpg.Picture = loc_cTmpFile
                        loc_oPagina.img_4c_ImgJpg.Visible = .T.
                    ELSE
                        loc_oPagina.img_4c_ImgJpg.Visible = .F.
                        loc_oPagina.img_4c_ImgJpg.Picture = ""
                    ENDIF
                ELSE
                    loc_oPagina.img_4c_ImgJpg.Visible = .F.
                    loc_oPagina.img_4c_ImgJpg.Picture = ""
                ENDIF
            ELSE
                loc_oPagina.img_4c_ImgJpg.Visible = .F.
                loc_oPagina.img_4c_ImgJpg.Picture = ""
            ENDIF

            IF USED("csImgProduto")
                USE IN csImgProduto
            ENDIF
        CATCH TO loException
            IF USED("csImgProduto")
                USE IN csImgProduto
            ENDIF
            loc_oPagina.img_4c_ImgJpg.Visible = .F.
            loc_oPagina.img_4c_ImgJpg.Picture = ""
            MostrarErro(loException, "Formcrf.CarregarImagemProduto")
        ENDTRY
    ENDPROC

    *==========================================================================
    * OptBuscaChanged - InteractiveChange do opt_4c_OptBusca
    * Limpa campo busca e foca nele ao trocar o tipo de pesquisa
    *==========================================================================
    PROCEDURE OptBuscaChanged()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oPagina.txt_4c_Busca.Value   = ""
            loc_oPagina.txt_4c_DContas.Value  = ""
            IF PEMSTATUS(loc_oPagina.txt_4c_Busca, "SetFocus", 5)
                loc_oPagina.txt_4c_Busca.SetFocus()
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "Formcrf.OptBuscaChanged")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Destroy - Libera recursos ao fechar o form
    *==========================================================================
    PROCEDURE Destroy()
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF USED("csSigCdCri")
                USE IN csSigCdCri
            ENDIF
            IF USED("cursor_4c_Vendedores")
                USE IN cursor_4c_Vendedores
            ENDIF
            IF USED("csImgProduto")
                USE IN csImgProduto
            ENDIF
            IF USED("csProcuraBusca")
                USE IN csProcuraBusca
            ENDIF

            SET SYSMENU TO DEFAULT
            RELEASE POPUPS popCadastros, popRelatorios, popMovimentos, popFinanceiro, popOperacional
            DO CriarMenuPrincipal

        CATCH TO loException
            *-- Silencioso no Destroy
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE

### BO (C:\4c\projeto\app\classes\crfBO.prg):
*============================================================================
* crfBO.prg - Business Object para Contagem de Referencia (SigCdCrf)
* Herda de BusinessBase
* Tabela principal: SigCdCrf (cabecalho da contagem)
* Tabela detalhe  : SigCdCri (itens/produtos da contagem)
*============================================================================

DEFINE CLASS crfBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades da tabela SigCdCrf (cabecalho da contagem)
    *--------------------------------------------------------------------------
    this_cCods      = ""    && PK: Codigo da contagem C(10) - gerado por fGerUniqueKey
    this_cEmps      = ""    && Empresa C(3)
    this_cVends     = ""    && Codigo do vendedor C(10) - FK SigCdCli.Iclis
    this_cDesVends  = ""    && Nome do vendedor - virtual do JOIN com SigCdCli.Rclis
    this_dDatas     = {}    && Data da contagem (Date)
    this_nConferido = 0     && Status: 0=contagem aberta, 1=contagem encerrada
    this_cIdChaves  = ""    && Identificador unico do cabecalho - gerado por fUniqueIds

    *--------------------------------------------------------------------------
    * Propriedades auxiliares para operacao
    *--------------------------------------------------------------------------
    this_cGrPadVens    = ""           && Grupo padrao de vendedores (de SigCdPam.GrPadVens)
    this_cCursorItens  = "csSigCdCri" && Cursor de trabalho (itens vindos de SigMvEst)
    this_cCursorSalvar = "crSigCdCri" && Cursor de gravacao (itens para SigCdCri)

    *==========================================================================
    * Init - Inicializa Business Object
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdCrf"
            THIS.this_cCampoChave = "Cods"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "crfBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCods)
    ENDFUNC

    *==========================================================================
    * Buscar - Lista contagens de referencia da empresa
    * par_cFiltro: filtro WHERE opcional (sem a palavra WHERE)
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados ;
                        (Cods C(10), Emps C(3), Vends C(10), Datas D, ;
                         Conferido N(1,0), cIdChaves C(10), DesVends C(50))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT a.Cods, a.Emps, a.Vends, a.Datas," + ;
                           " a.Conferido, a.cIdChaves, b.Rclis AS DesVends" + ;
                           " FROM SigCdCrf a" + ;
                           " LEFT JOIN SigCdCli b ON a.Vends = b.Iclis" + ;
                           " WHERE a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

                IF !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " AND (" + par_cFiltro + ")"
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY a.Datas DESC, a.Cods"

                IF USED("cursor_4c_Dados")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT cursor_4c_Dados
                        ZAP
                        SET NULL ON
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        SET NULL OFF
                        IF USED("cursor_4c_DadosTmp")
                            USE IN cursor_4c_DadosTmp
                        ENDIF
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar contagens:" + CHR(13) + CapturarErroSQL(), "crfBO.Buscar")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar contagens:" + CHR(13) + CapturarErroSQL(), "crfBO.Buscar")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "crfBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega contagem pelo codigo Cods
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.Cods, a.Emps, a.Vends, a.Datas," + ;
                       " a.Conferido, a.cIdChaves, b.Rclis AS DesVends" + ;
                       " FROM SigCdCrf a" + ;
                       " LEFT JOIN SigCdCli b ON a.Vends = b.Iclis" + ;
                       " WHERE a.Cods = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Contagem n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar contagem:" + CHR(13) + CapturarErroSQL(), "crfBO.CarregarPorCodigo")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "crfBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCods      = TratarNulo(Cods,      "C")
                THIS.this_cEmps      = TratarNulo(Emps,      "C")
                THIS.this_cVends     = TratarNulo(Vends,     "C")
                THIS.this_cDesVends  = TratarNulo(DesVends,  "C")
                THIS.this_dDatas     = TratarNulo(Datas,     "D")
                THIS.this_nConferido = TratarNulo(Conferido, "N")
                THIS.this_cIdChaves  = TratarNulo(cIdChaves, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "crfBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * GerarCodigoContagem - Gera proximo codigo numerico para SigCdCrf
    *==========================================================================
    PROTECTED FUNCTION GerarCodigoContagem()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_nProxId
        loc_lSucesso = .F.
        loc_nProxId  = 1

        TRY
            loc_cSQL = "SELECT ISNULL(MAX(CAST(LTRIM(RTRIM(Cods)) AS BIGINT)), 0) + 1" + ;
                       " AS NextID FROM SigCdCrf WHERE ISNUMERIC(Cods) = 1"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxId")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_MaxId") > 0
                SELECT cursor_4c_MaxId
                loc_nProxId = TratarNulo(NextID, "N")
                IF loc_nProxId < 1
                    loc_nProxId = 1
                ENDIF
            ENDIF

            IF USED("cursor_4c_MaxId")
                USE IN cursor_4c_MaxId
            ENDIF

            THIS.this_cCods     = PADL(ALLTRIM(STR(loc_nProxId, 10)), 10, " ")
            THIS.this_cIdChaves = SYS(2015)
            loc_lSucesso = .T.

        CATCH TO loException
            MostrarErro("Erro ao gerar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "crfBO.GerarCodigoContagem")
            IF USED("cursor_4c_MaxId")
                USE IN cursor_4c_MaxId
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Inserir - Insere cabecalho em SigCdCrf e itens de csSigCdCri em SigCdCri
    * Usa transacao explicita pois atualiza duas tabelas
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_lTransacao
        loc_lSucesso  = .F.
        loc_lTransacao = .F.

        TRY
            IF !THIS.GerarCodigoContagem()
                MostrarErro("Erro ao gerar c" + CHR(243) + "digo da contagem.", "crfBO.Inserir")
            ELSE
                THIS.this_dDatas     = DATE()
                THIS.this_nConferido = 0

                SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
                loc_lTransacao = .T.

                TEXT TO loc_cSQL TEXTMERGE NOSHOW
                    INSERT INTO SigCdCrf (Cods, Emps, Vends, Datas, cIdChaves, Conferido)
                    VALUES (
                        <<EscaparSQL(THIS.this_cCods)>>,
                        <<EscaparSQL(THIS.this_cEmps)>>,
                        <<EscaparSQL(THIS.this_cVends)>>,
                        <<FormatarDataSQL(THIS.this_dDatas)>>,
                        <<EscaparSQL(THIS.this_cIdChaves)>>,
                        <<FormatarNumeroSQL(THIS.this_nConferido, 0)>>
                    )
                ENDTEXT

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado < 0
                    MostrarErro("Erro ao inserir cabe" + CHR(231) + "alho:" + CHR(13) + CapturarErroSQL(), "crfBO.Inserir")
                ELSE
                    loc_lSucesso = THIS.SalvarItensContagem()

                    IF loc_lSucesso
                        SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                        loc_lTransacao = .F.
                        THIS.RegistrarAuditoria("INSERT")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "crfBO.Inserir")
        ENDTRY

        IF loc_lTransacao
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * SalvarItensContagem - Insere cada item de csSigCdCri em SigCdCri
    * Chamado dentro de transacao (Inserir/Atualizar)
    *==========================================================================
    PROTECTED FUNCTION SalvarItensContagem()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        LOCAL loc_cIdChave, loc_cEmps, loc_cGrupos, loc_cEstos
        LOCAL loc_cCpros, loc_nCBars, loc_nQtds, loc_nEstoque, loc_cDescr
        loc_lSucesso = .F.

        TRY
            IF !USED(THIS.this_cCursorItens)
                MostrarErro("Cursor de itens n" + CHR(227) + "o encontrado: " + THIS.this_cCursorItens, "crfBO.SalvarItensContagem")
            ELSE
                loc_lSucesso = .T.

                SELECT (THIS.this_cCursorItens)
                GO TOP

                SCAN WHILE loc_lSucesso
                    loc_cIdChave = SYS(2015)
                    loc_cEmps    = ALLTRIM(TratarNulo(Emps,   "C"))
                    loc_cGrupos  = ALLTRIM(TratarNulo(Grupos, "C"))
                    loc_cEstos   = ALLTRIM(TratarNulo(Estos,  "C"))
                    loc_cCpros   = ALLTRIM(TratarNulo(Cpros,  "C"))
                    loc_nCBars   = TratarNulo(CBars,   "N")
                    loc_nQtds    = TratarNulo(QtdCtg,  "N")
                    loc_nEstoque = TratarNulo(qtde,    "N")
                    loc_cDescr   = LEFT(ALLTRIM(TratarNulo(Descr, "C")), 60)

                    TEXT TO loc_cSQL TEXTMERGE NOSHOW
                        INSERT INTO SigCdCri (cIdChaves, Cods, Emps, Grupos, Estos, Cpros, CBars, Qtds, Estoque, Descr)
                        VALUES (
                            <<EscaparSQL(loc_cIdChave)>>,
                            <<EscaparSQL(THIS.this_cCods)>>,
                            <<EscaparSQL(loc_cEmps)>>,
                            <<EscaparSQL(loc_cGrupos)>>,
                            <<EscaparSQL(loc_cEstos)>>,
                            <<EscaparSQL(loc_cCpros)>>,
                            <<FormatarNumeroSQL(loc_nCBars, 0)>>,
                            <<FormatarNumeroSQL(loc_nQtds, 2)>>,
                            <<FormatarNumeroSQL(loc_nEstoque, 2)>>,
                            <<EscaparSQL(loc_cDescr)>>
                        )
                    ENDTEXT

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResultado < 0
                        MostrarErro("Erro ao salvar item [" + loc_cCpros + "]:" + CHR(13) + CapturarErroSQL(), "crfBO.SalvarItensContagem")
                        loc_lSucesso = .F.
                    ENDIF

                    SELECT (THIS.this_cCursorItens)
                ENDSCAN
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao salvar itens:" + CHR(13) + loException.Message, "crfBO.SalvarItensContagem")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Atualizar - Delete+reinsert em SigCdCrf e SigCdCri (mesmo padrao do legado)
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_lTransacao
        loc_lSucesso  = .F.
        loc_lTransacao = .F.

        TRY
            THIS.this_dDatas    = DATE()
            THIS.this_cIdChaves = SYS(2015)

            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
            loc_lTransacao = .T.

            *-- Exclui itens existentes
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "DELETE FROM SigCdCri WHERE Cods = " + EscaparSQL(THIS.this_cCods))

            IF loc_nResultado < 0
                MostrarErro("Erro ao excluir itens anteriores:" + CHR(13) + CapturarErroSQL(), "crfBO.Atualizar")
            ELSE
                *-- Exclui cabecalho existente
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "DELETE FROM SigCdCrf WHERE Cods = " + EscaparSQL(THIS.this_cCods))

                IF loc_nResultado < 0
                    MostrarErro("Erro ao excluir cabe" + CHR(231) + "alho anterior:" + CHR(13) + CapturarErroSQL(), "crfBO.Atualizar")
                ELSE
                    TEXT TO loc_cSQL TEXTMERGE NOSHOW
                        INSERT INTO SigCdCrf (Cods, Emps, Vends, Datas, cIdChaves, Conferido)
                        VALUES (
                            <<EscaparSQL(THIS.this_cCods)>>,
                            <<EscaparSQL(THIS.this_cEmps)>>,
                            <<EscaparSQL(THIS.this_cVends)>>,
                            <<FormatarDataSQL(THIS.this_dDatas)>>,
                            <<EscaparSQL(THIS.this_cIdChaves)>>,
                            <<FormatarNumeroSQL(THIS.this_nConferido, 0)>>
                        )
                    ENDTEXT

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResultado < 0
                        MostrarErro("Erro ao regravar cabe" + CHR(231) + "alho:" + CHR(13) + CapturarErroSQL(), "crfBO.Atualizar")
                    ELSE
                        loc_lSucesso = THIS.SalvarItensContagem()

                        IF loc_lSucesso
                            SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                            loc_lTransacao = .F.
                            THIS.RegistrarAuditoria("UPDATE")
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "crfBO.Atualizar")
        ENDTRY

        IF loc_lTransacao
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Exclui contagem (itens + cabecalho) com verificacao
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_nResultado, loc_lTransacao
        loc_lSucesso  = .F.
        loc_lTransacao = .F.

        TRY
            *-- Verifica se a contagem esta encerrada (nao pode excluir encerradas)
            IF THIS.this_nConferido = 1
                MsgAviso("Contagem J" + CHR(225) + " Encerrada. Reabra antes de excluir.")
            ELSE
                SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
                loc_lTransacao = .T.

                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "DELETE FROM SigCdCri WHERE Cods = " + EscaparSQL(THIS.this_cCods))

                IF loc_nResultado < 0
                    MostrarErro("Erro ao excluir itens:" + CHR(13) + CapturarErroSQL(), "crfBO.ExecutarExclusao")
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, ;
                        "DELETE FROM SigCdCrf WHERE Cods = " + EscaparSQL(THIS.this_cCods))

                    IF loc_nResultado >= 0
                        SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                        loc_lTransacao = .F.
                        THIS.RegistrarAuditoria("DELETE")
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao excluir contagem:" + CHR(13) + CapturarErroSQL(), "crfBO.ExecutarExclusao")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "crfBO.ExecutarExclusao")
        ENDTRY

        IF loc_lTransacao
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarParametros - Carrega grupo padrao de vendedores de SigCdPam
    *==========================================================================
    PROCEDURE CarregarParametros()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT GrPadVens FROM SigCdPam" + ;
                       " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Params")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Params") > 0
                SELECT cursor_4c_Params
                GO TOP
                THIS.this_cGrPadVens = ALLTRIM(TratarNulo(GrPadVens, "C"))

                IF EMPTY(THIS.this_cGrPadVens)
                    MostrarErro("O Grupo Padr" + CHR(227) + "o de Vendedores n" + CHR(227) + "o est" + ;
                                CHR(225) + " configurado nos Par" + CHR(226) + "metros do Sistema.", ;
                                "Configura" + CHR(231) + CHR(227) + "o Incorreta")
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                MostrarErro("Par" + CHR(226) + "metros do sistema n" + CHR(227) + "o encontrados.", "crfBO.CarregarParametros")
            ENDIF

            IF USED("cursor_4c_Params")
                USE IN cursor_4c_Params
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar par" + CHR(226) + "metros:" + CHR(13) + loException.Message, "crfBO.CarregarParametros")
            IF USED("cursor_4c_Params")
                USE IN cursor_4c_Params
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarProdutosEstoque - Carrega produtos de SigMvEst em csSigCdCri
    * Usado ao iniciar nova contagem (modo INSERIR)
    *==========================================================================
    PROCEDURE CarregarProdutosEstoque()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorItens)
                USE IN (THIS.this_cCursorItens)
            ENDIF

            loc_cSQL = "SELECT a.Emps, a.Grupos, a.Estos, a.cpros," + ;
                       " SUM(a.sqtds) AS qtde," + ;
                       " CONVERT(numeric(5,0), 0) AS QtdCtg," + ;
                       " b.dpros AS Descr, b.cbars AS CBars" + ;
                       " FROM SigMvEst a" + ;
                       " JOIN SigCdpro b ON a.CPros = b.Cpros" + ;
                       " JOIN SigCdCli c ON a.Estos = c.Iclis" + ;
                       " JOIN SigCtCtg d ON a.empgruests = d.empresa + d.grupos + d.contas" + ;
                       " WHERE a.emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                       " AND b.cunis = 'UN'" + ;
                       " GROUP BY a.Emps, a.Grupos, a.Estos, b.dpros, a.cpros, b.cbars" + ;
                       " HAVING SUM(a.sqtds) <> 0" + ;
                       " ORDER BY a.Emps, a.Grupos, a.Estos, a.cpros"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorItens)

            IF loc_nResultado >= 0
                SELECT (THIS.this_cCursorItens)
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar produtos do estoque:" + CHR(13) + CapturarErroSQL(), "crfBO.CarregarProdutosEstoque")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar estoque:" + CHR(13) + loException.Message, "crfBO.CarregarProdutosEstoque")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarItensContagem - Carrega produtos + mescla com itens de SigCdCri
    * Usado ao editar (ALTERAR) ou visualizar (CONSULTAR) contagem existente
    * par_cCodigo      : codigo da contagem (Cods)
    * par_lSoContados  : .T. = mostra apenas itens que foram contados (CONSULTAR)
    *==========================================================================
    PROCEDURE CarregarItensContagem(par_cCodigo, par_lSoContados)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorItens)
                USE IN (THIS.this_cCursorItens)
            ENDIF

            *-- Query unica: produtos do estoque com QtdCtg ja preenchida de SigCdCri
            loc_cSQL = "SELECT a.Emps, a.Grupos, a.Estos, a.cpros," + ;
                       " SUM(a.sqtds) AS qtde," + ;
                       " ISNULL(" + ;
                       "   (SELECT TOP 1 i.Qtds FROM SigCdCri i" + ;
                       "    WHERE i.Cods = " + EscaparSQL(par_cCodigo) + ;
                       "    AND i.Cpros = a.cpros AND i.Emps = a.Emps" + ;
                       "    AND i.Grupos = a.Grupos AND i.Estos = a.Estos), 0)" + ;
                       " AS QtdCtg," + ;
                       " b.dpros AS Descr, b.cbars AS CBars" + ;
                       " FROM SigMvEst a" + ;
                       " JOIN SigCdpro b ON a.CPros = b.Cpros" + ;
                       " JOIN SigCdCli c ON a.Estos = c.Iclis" + ;
                       " JOIN SigCtCtg d ON a.empgruests = d.empresa + d.grupos + d.contas" + ;
                       " WHERE a.emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                       " AND b.cunis = 'UN'" + ;
                       " GROUP BY a.Emps, a.Grupos, a.Estos, b.dpros, a.cpros, b.cbars" + ;
                       " HAVING SUM(a.sqtds) <> 0"

            IF par_lSoContados
                *-- CONSULTAR/Encerrada: filtra apenas itens que existem em SigCdCri
                loc_cSQL = loc_cSQL + ;
                           " AND EXISTS (SELECT 1 FROM SigCdCri cx" + ;
                           " WHERE cx.Cods = " + EscaparSQL(par_cCodigo) + ;
                           " AND cx.Cpros = a.cpros AND cx.Emps = a.Emps" + ;
                           " AND cx.Grupos = a.Grupos AND cx.Estos = a.Estos)"
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.Emps, a.Grupos, a.Estos, a.cpros"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorItens)

            IF loc_nResultado >= 0
                SELECT (THIS.this_cCursorItens)
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar itens da contagem:" + CHR(13) + CapturarErroSQL(), "crfBO.CarregarItensContagem")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar itens:" + CHR(13) + loException.Message, "crfBO.CarregarItensContagem")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * EncerrarContagem - Define Conferido=1 na contagem especificada
    *==========================================================================
    PROCEDURE EncerrarContagem(par_cCodigo)
        LOCAL loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "UPDATE SigCdCrf SET Conferido = 1" + ;
                " WHERE Cods = " + EscaparSQL(par_cCodigo) + ;
                " AND Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa))

            IF loc_nResultado >= 0
                THIS.this_nConferido = 1
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao encerrar contagem:" + CHR(13) + CapturarErroSQL(), "crfBO.EncerrarContagem")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao encerrar:" + CHR(13) + loException.Message, "crfBO.EncerrarContagem")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ReabrirContagem - Define Conferido=0 na contagem especificada
    *==========================================================================
    PROCEDURE ReabrirContagem(par_cCodigo)
        LOCAL loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "UPDATE SigCdCrf SET Conferido = 0" + ;
                " WHERE Cods = " + EscaparSQL(par_cCodigo) + ;
                " AND Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa))

            IF loc_nResultado >= 0
                THIS.this_nConferido = 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao reabrir contagem:" + CHR(13) + CapturarErroSQL(), "crfBO.ReabrirContagem")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao reabrir:" + CHR(13) + loException.Message, "crfBO.ReabrirContagem")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarVendedores - Pesquisa vendedores validos no grupo padrao
    * par_cValor: valor de busca inicial
    * par_cCampo: "Iclis" (por codigo) ou "Rclis" (por nome)
    *==========================================================================
    PROCEDURE BuscarVendedores(par_cValor, par_cCampo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cGrPadVens)
                THIS.CarregarParametros()
            ENDIF

            IF USED("cursor_4c_Vendedores")
                USE IN cursor_4c_Vendedores
            ENDIF

            loc_cSQL = "SELECT a.Iclis, a.Rclis, a.Grupos, a.Situas," + ;
                       " a.Cpfs, a.Inativas, a.ContaMats, a.Emps" + ;
                       " FROM SigCdCli a" + ;
                       " INNER JOIN SigCdGcr b ON a.Grupos = b.Codigos" + ;
                       " INNER JOIN SigCdAce c ON a.Iclis = c.Usuarios" + ;
                       " WHERE NOT b.Coletors = 10" + ;
                       " AND a.Grupos = " + EscaparSQL(THIS.this_cGrPadVens) + ;
                       " AND a.Inativas <> 2" + ;
                       " AND c.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                       " ORDER BY a.Iclis"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Vendedores")

            IF loc_nResultado >= 0
                SELECT cursor_4c_Vendedores
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar vendedores:" + CHR(13) + CapturarErroSQL(), "crfBO.BuscarVendedores")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar vendedores:" + CHR(13) + loException.Message, "crfBO.BuscarVendedores")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

