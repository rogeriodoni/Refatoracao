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
[2026-08-05 18:53:48] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-05 18:53:48] [INFO] Config FPW: (nao fornecido)
[2026-08-05 18:53:48] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-05 18:53:48] [INFO] Timeout: 300 segundos
[2026-08-05 18:53:48] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_chzboova.prg
[2026-08-05 18:53:48] [INFO] Conteudo do wrapper:
[2026-08-05 18:53:48] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formfnl', 'C:\4c\tasks\task420', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formfnl', 'C:\4c\tasks\task420', 'CRUD'
QUIT

[2026-08-05 18:53:48] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_chzboova.prg
[2026-08-05 18:53:48] [INFO] VFP output esperado em: C:\4c\tasks\task420\vfp_output.txt
[2026-08-05 18:53:48] [INFO] Executando Visual FoxPro 9...
[2026-08-05 18:53:48] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_chzboova.prg
[2026-08-05 18:53:48] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_chzboova.prg
[2026-08-05 18:53:48] [INFO] Timeout configurado: 300 segundos
[2026-08-05 18:54:44] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-05 18:54:44] [INFO] VFP9 finalizado em 55.978533 segundos
[2026-08-05 18:54:44] [INFO] Exit Code: 
[2026-08-05 18:54:44] [INFO] 
[2026-08-05 18:54:44] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-05 18:54:44] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_chzboova.prg
[2026-08-05 18:54:44] [INFO] 
[2026-08-05 18:54:44] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-05 18:54:44] [INFO] * Auto-generated wrapper for parameters
[2026-08-05 18:54:44] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-05 18:54:44] [INFO] * Parameters: 'Formfnl', 'C:\4c\tasks\task420', 'CRUD'
[2026-08-05 18:54:44] [INFO] 
[2026-08-05 18:54:44] [INFO] * Anti-dialog protections for unattended execution
[2026-08-05 18:54:44] [INFO] SET SAFETY OFF
[2026-08-05 18:54:44] [INFO] SET RESOURCE OFF
[2026-08-05 18:54:44] [INFO] SET TALK OFF
[2026-08-05 18:54:44] [INFO] SET NOTIFY OFF
[2026-08-05 18:54:44] [INFO] SYS(2335, 0)
[2026-08-05 18:54:44] [INFO] 
[2026-08-05 18:54:44] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formfnl', 'C:\4c\tasks\task420', 'CRUD'
[2026-08-05 18:54:44] [INFO] QUIT
[2026-08-05 18:54:44] [INFO] 
[2026-08-05 18:54:44] [INFO] === Fim do Wrapper.prg ===
[2026-08-05 18:54:44] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formfnl",
  "timestamp": "20260805185444",
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
      "detalhes": "AbrirLookup: 2 (ABRIRLOOKUPRELGERPORCODIGO, ABRIRLOOKUPRELGERPORDESCRICAO) | KeyPress handlers: 3 (CODRELGERKEYPRESS, DESRELGERKEYPRESS, KEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\cadastros\Formfnl.prg):
*==============================================================================
* Formfnl.prg - Formulario de Cadastro de Tabela de Finalizacoes
* Migrado de: SIGCDFNL.SCX (frmcadastro)
* Tabela: SigFiNal (PK composta: imps + ordems)
*==============================================================================

DEFINE CLASS Formfnl AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: Height/Width/Caption EXATOS do original)
    Height      = 600
    Width       = 1000
    Caption     = "Tabela de Finalizacoes"   && acento setado em InicializarForm via CHR()
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
            THIS.Caption = "Tabela de Finaliza" + CHR(231) + CHR(245) + "es"

            THIS.this_oBusinessObject = CREATEOBJECT("fnlBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar fnlBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "Formfnl.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar Formfnl:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "Formfnl.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * Top=-29 esconde as abas; controles internos compensam +29 no Top
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
    * ConfigurarPaginaLista - Configura Page1 (Lista): cabecalho, botoes e grid
    * Posicoes do original (compensacao +29 aplicada):
    *   cntSombra.Top=1 -> cnt_4c_Cabecalho.Top=30
    *   Grupo_op.Top=-1 -> cnt_4c_Botoes.Top=28  (Left=542 canonico)
    *   Grupo_Saida.Top=-1 -> cnt_4c_Saida.Top=28 (Left=917 canonico)
    *   Grade original Top=88 -> grd_4c_Lista.Top=117
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (cntSombra no legado)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 30
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Caption   = ""
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
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Caption   = ""
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
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- Container Botoes CRUD (Grupo_op no legado) - Left=542 canonico, Top=28
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 28
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle   = 1
            .BackColor   = RGB(53, 53, 53)
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
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
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
        ENDWITH

        *-- Container Saida - padrao canonico: Left=917, Width=90
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 28
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
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH
        ENDWITH

        *-- Grid da lista (Grade no legado: Top=88, Left=12, Width=940)
        *-- Com compensacao +29: Top=117. Width=890 (canonico).
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oPagina.grd_4c_Lista.RecordSource = ""
        loc_oPagina.grd_4c_Lista.ColumnCount  = 4
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 2
            .Width              = 890
            .Height             = 492
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

        *-- BINDEVENTs dos botoes CRUD
        WITH loc_oPagina.cnt_4c_Botoes
            BINDEVENT(.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
            BINDEVENT(.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
            BINDEVENT(.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
            BINDEVENT(.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
            BINDEVENT(.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Configura Page2 (Dados)
    * Fase 5: botoes Confirmar/Cancelar + primeiros 50% dos campos
    * Fase 6: segundo 50% (Opc_fixo, Vincs, RelGerencial)
    *
    * Posicoes do original (compensacao +29 aplicada):
    *   Grupo_Salva.Top=4+29=33, Left=842
    *   Campos: Top_original + 29
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Salvar/Cancelar (Grupo_Salva no legado: Top=4+29=33, Left=842)
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
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
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
        ENDWITH

        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *-- === FASE 5: PRIMEIROS 50% DOS CAMPOS ===

        *-- Label Impressora (Say6 original: top=129, left=181 -> +29: top=158)
        loc_oPagina.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPagina.lbl_4c_Label6
            .Caption   = "Impressora :"
            .Top       = 158
            .Left      = 181
            .Width     = 68
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- ComboBox Impressora (Cmb_Imp original: top=125, left=249 -> +29: top=154)
        loc_oPagina.AddObject("cbo_4c_Cmb_Imp", "ComboBox")
        WITH loc_oPagina.cbo_4c_Cmb_Imp
            .Top           = 154
            .Left          = 249
            .Width         = 105
            .Height        = 24
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Style         = 2
            .Visible       = .T.
        ENDWITH

        *-- Label Codigo finalizador (Say32 original: top=154, left=202 -> +29: top=183)
        loc_oPagina.AddObject("lbl_4c_Label32", "Label")
        WITH loc_oPagina.lbl_4c_Label32
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 183
            .Left      = 202
            .Width     = 44
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo finalizador (Get_finalz original: top=151, left=249 -> +29: top=180)
        loc_oPagina.AddObject("txt_4c_Finalz", "TextBox")
        WITH loc_oPagina.txt_4c_Finalz
            .Value         = 0
            .InputMask     = "99"
            .Top           = 180
            .Left          = 249
            .Width         = 24
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Label Ordem Finalizadora (Say1 original: top=179, left=143 -> +29: top=208)
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "Ordem Finalizadora :"
            .Top       = 208
            .Left      = 143
            .Width     = 103
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Ordem finalizadora (Get_ordem original: top=176, left=249 -> +29: top=205)
        loc_oPagina.AddObject("txt_4c_Ordem", "TextBox")
        WITH loc_oPagina.txt_4c_Ordem
            .Value         = 0
            .InputMask     = "99"
            .Top           = 205
            .Left          = 249
            .Width         = 24
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Label Descricao (Say2 original: top=203, left=189 -> +29: top=232)
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 232
            .Left      = 189
            .Width     = 57
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Descricao (Get_descr original: top=200, left=249 -> +29: top=229)
        loc_oPagina.AddObject("txt_4c_Descr", "TextBox")
        WITH loc_oPagina.txt_4c_Descr
            .Value         = ""
            .MaxLength     = 40
            .Top           = 229
            .Left          = 249
            .Width         = 290
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Popula ComboBox de Impressoras (lista fixa identica ao legado)
        IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
            THIS.CarregarComboImpressora()
        ENDIF

        *-- === FASE 6: CAMPOS RESTANTES ===

        *-- Label Fixo (Say3 original: top=230, left=215 -> +29: top=259)
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "Fixo :"
            .Top       = 259
            .Left      = 215
            .Width     = 30
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Fixo (Opc_fixo original: top=225, left=249 -> +29: top=254)
        *-- Value=2 default = "Nao". ControlSource era crSigFiNal.nfixos (1=Sim, 2=Nao)
        loc_oPagina.AddObject("opt_4c_Opc_fixo", "OptionGroup")
        WITH loc_oPagina.opt_4c_Opc_fixo
            .ButtonCount = 2
            .Value       = 2
            .Top         = 254
            .Left        = 249
            .BackStyle   = 0
            .BorderStyle = 0
            .AutoSize    = .T.
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_Opc_fixo.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.opt_4c_Opc_fixo.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 47
            .Top       = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- Label Vinculado (Say4 original: top=255, left=162 -> +29: top=284)
        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Caption   = "Vinculado (S/N) :"
            .Top       = 284
            .Left      = 162
            .Width     = 85
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Vinculado (Get_Vincs original: top=252, left=249, width=17 -> +29: top=281)
        *-- Aceita apenas 'S' ou 'N' (Valid no original)
        loc_oPagina.AddObject("txt_4c_Vincs", "TextBox")
        WITH loc_oPagina.txt_4c_Vincs
            .Value         = "N"
            .MaxLength     = 1
            .Top           = 281
            .Left          = 249
            .Width         = 17
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Label Relatorio Gerencial (Say5 original: top=280, left=145 -> +29: top=309)
        loc_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPagina.lbl_4c_Label5
            .Caption   = "Relat" + CHR(243) + "rio Gerencial :"
            .Top       = 309
            .Left      = 145
            .Width     = 100
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo Rel. Gerencial (GetCodRelGer original: top=277, left=249, width=24 -> +29: top=306)
        loc_oPagina.AddObject("txt_4c_CodRelGer", "TextBox")
        WITH loc_oPagina.txt_4c_CodRelGer
            .Value         = 0
            .InputMask     = "99"
            .Top           = 306
            .Left          = 249
            .Width         = 24
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- TextBox Descricao Rel. Gerencial (GetDesRelGer original: top=277, left=275, width=272 -> +29: top=306)
        loc_oPagina.AddObject("txt_4c_DesRelGer", "TextBox")
        WITH loc_oPagina.txt_4c_DesRelGer
            .Value         = ""
            .MaxLength     = 50
            .Top           = 306
            .Left          = 275
            .Width         = 272
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- BINDEVENTs para validacao de Vincs (S/N)
        BINDEVENT(loc_oPagina.txt_4c_Vincs, "KeyPress", THIS, "ValidarVincs")

        *-- BINDEVENTs para lookup de Rel. Gerencial (LostFocus + F4)
        BINDEVENT(loc_oPagina.txt_4c_CodRelGer, "KeyPress", THIS, "CodRelGerLostFocus")
        BINDEVENT(loc_oPagina.txt_4c_CodRelGer, "KeyPress",  THIS, "CodRelGerKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_DesRelGer, "KeyPress", THIS, "DesRelGerLostFocus")
        BINDEVENT(loc_oPagina.txt_4c_DesRelGer, "KeyPress",  THIS, "DesRelGerKeyPress")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * CarregarLista - Carrega dados no Grid da Page1 via BO
    * Cursor: crSigFiNal (SigFiNal LEFT JOIN SigFiRlg)
    * Colunas: imps, ordems, descrs, descs
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

                    loc_oGrid.RecordSource = "crSigFiNal"
                    loc_oGrid.ColumnCount  = 4

                    WITH loc_oGrid
                        .Column1.ControlSource   = "crSigFiNal.imps"
                        .Column1.Width           = 160
                        .Column1.Header1.Caption = "Impressora"

                        .Column2.ControlSource   = "crSigFiNal.ordems"
                        .Column2.Width           = 80
                        .Column2.Header1.Caption = "Ordem"

                        .Column3.ControlSource   = "crSigFiNal.descrs"
                        .Column3.Width           = 350
                        .Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

                        .Column4.ControlSource   = "crSigFiNal.descs"
                        .Column4.Width           = 250
                        .Column4.Header1.Caption = "Rel. Gerencial"
                    ENDWITH

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message, ;
                "Formfnl.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * Percorre Pages de PageFrames e Controls de Containers
    *===========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
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
    * FormatarGridLista - Aplica formatacao visual ao grid da lista
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *===========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    * Ao voltar para lista (par_nPagina=1) recarrega os dados
    *===========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        THIS.pgf_4c_Paginas.ActivePage = par_nPagina

        IF par_nPagina = 1
            THIS.CarregarLista()
        ENDIF

        loc_lResultado = .T.
        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Abre Page2 para inclusao de novo registro
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
        IF VARTYPE(THIS.pgf_4c_Paginas.Page2.cbo_4c_Cmb_Imp) = "O"
            THIS.pgf_4c_Paginas.Page2.cbo_4c_Cmb_Imp.SetFocus
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Abre Page2 em modo somente leitura para o registro selecionado
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cImps, loc_nOrdems
        loc_cImps   = ""
        loc_nOrdems = 0

        IF !USED("crSigFiNal") OR EOF("crSigFiNal") OR RECCOUNT("crSigFiNal") = 0
            MsgAviso("Nenhum registro selecionado.", "Visualizar")
            RETURN
        ENDIF

        SELECT crSigFiNal
        loc_cImps   = ALLTRIM(crSigFiNal.imps)
        loc_nOrdems = crSigFiNal.ordems

        IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cImps, loc_nOrdems)
            RETURN
        ENDIF

        THIS.BOParaForm()
        THIS.this_cModoAtual = "VISUALIZAR"
        THIS.HabilitarCampos(.F.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Abre Page2 para edicao do registro selecionado
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cImps, loc_nOrdems
        loc_cImps   = ""
        loc_nOrdems = 0

        IF !USED("crSigFiNal") OR EOF("crSigFiNal") OR RECCOUNT("crSigFiNal") = 0
            MsgAviso("Nenhum registro selecionado.", "Alterar")
            RETURN
        ENDIF

        SELECT crSigFiNal
        loc_cImps   = ALLTRIM(crSigFiNal.imps)
        loc_nOrdems = crSigFiNal.ordems

        IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cImps, loc_nOrdems)
            RETURN
        ENDIF

        THIS.this_oBusinessObject.EditarRegistro()
        THIS.BOParaForm()
        THIS.this_cModoAtual = "ALTERAR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
        IF VARTYPE(THIS.pgf_4c_Paginas.Page2.txt_4c_Ordem) = "O"
            THIS.pgf_4c_Paginas.Page2.txt_4c_Ordem.SetFocus
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Confirma e exclui o registro selecionado na lista
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cImps, loc_nOrdems, loc_cDescrs
        loc_cImps   = ""
        loc_nOrdems = 0
        loc_cDescrs = ""

        IF !USED("crSigFiNal") OR EOF("crSigFiNal") OR RECCOUNT("crSigFiNal") = 0
            MsgAviso("Nenhum registro selecionado.", "Excluir")
            RETURN
        ENDIF

        SELECT crSigFiNal
        loc_cImps   = ALLTRIM(crSigFiNal.imps)
        loc_nOrdems = crSigFiNal.ordems
        loc_cDescrs = ALLTRIM(crSigFiNal.descrs)

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o de:" + CHR(13) + loc_cDescrs, "Excluir")
            RETURN
        ENDIF

        IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cImps, loc_nOrdems)
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.Excluir()
            MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Excluir")
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Recarrega lista com todos os registros (limpa filtro)
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Salva o registro (INSERT ou UPDATE)
    * Validacoes: Impressora obrigatoria, Ordem obrigatoria,
    *             Ordem nao duplicada (INSERT), Codigo nao duplicado (INSERT)
    * Gera: ncodfinzs se 0 (INSERT)
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lSucesso, loc_oPg2, loc_cImps, loc_nOrdems, loc_nFinalz
        loc_lSucesso = .F.
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_cImps   = ""
        loc_nOrdems = 0
        loc_nFinalz = 0

        *-- Validacoes FORA do TRY para permitir RETURN direto
        IF VARTYPE(loc_oPg2.cbo_4c_Cmb_Imp) = "O"
            loc_cImps = ALLTRIM(loc_oPg2.cbo_4c_Cmb_Imp.Value)
        ENDIF

        IF EMPTY(loc_cImps)
            MsgAviso("Selecione a Impressora.", "Confirmar")
            IF VARTYPE(loc_oPg2.cbo_4c_Cmb_Imp) = "O"
                loc_oPg2.cbo_4c_Cmb_Imp.SetFocus
            ENDIF
            RETURN
        ENDIF

        IF VARTYPE(loc_oPg2.txt_4c_Ordem) = "O"
            loc_nOrdems = loc_oPg2.txt_4c_Ordem.Value
        ENDIF

        IF loc_nOrdems <= 0
            MsgAviso("Informe a Ordem Finalizadora.", "Confirmar")
            IF VARTYPE(loc_oPg2.txt_4c_Ordem) = "O"
                loc_oPg2.txt_4c_Ordem.SetFocus
            ENDIF
            RETURN
        ENDIF

        IF THIS.this_cModoAtual = "INCLUIR"
            *-- Valida Imps+Ordems nao duplicados
            IF THIS.this_oBusinessObject.ValidarOrdemDuplicada(loc_cImps, loc_nOrdems)
                MsgAviso("Ordem j" + CHR(225) + " cadastrada!", "Confirmar")
                IF VARTYPE(loc_oPg2.txt_4c_Ordem) = "O"
                    loc_oPg2.txt_4c_Ordem.SetFocus
                ENDIF
                RETURN
            ENDIF

            *-- Gera ncodfinzs se o usuario nao informou
            IF VARTYPE(loc_oPg2.txt_4c_Finalz) = "O"
                loc_nFinalz = loc_oPg2.txt_4c_Finalz.Value
            ENDIF
            IF loc_nFinalz <= 0
                loc_nFinalz = THIS.this_oBusinessObject.GerarProximoNcodFinzs(loc_cImps)
                IF VARTYPE(loc_oPg2.txt_4c_Finalz) = "O"
                    loc_oPg2.txt_4c_Finalz.Value = loc_nFinalz
                ENDIF
            ENDIF

            *-- Valida Imps+ncodfinzs nao duplicados
            IF THIS.this_oBusinessObject.ValidarCodigoDuplicado(loc_cImps, loc_nFinalz)
                MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!", "Confirmar")
                IF VARTYPE(loc_oPg2.txt_4c_Finalz) = "O"
                    loc_oPg2.txt_4c_Finalz.SetFocus
                ENDIF
                RETURN
            ENDIF
        ENDIF

        TRY
            THIS.FormParaBO()

            loc_lSucesso = THIS.this_oBusinessObject.Salvar()

            IF loc_lSucesso
                MsgInfo("Registro salvo com sucesso!", "Confirmar")
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao salvar:" + CHR(13) + loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), "Formfnl.BtnSalvarClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancela operacao e retorna para a lista
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
        THIS.CarregarLista()
    ENDPROC

    *===========================================================================
    * CarregarComboImpressora - Popula cbo_4c_Cmb_Imp com lista fixa de impressoras
    * Lista identica ao AddItem() do SIGCDFNL.Init no legado
    *===========================================================================
    PROTECTED PROCEDURE CarregarComboImpressora()
        LOCAL loc_oCbo
        loc_oCbo = THIS.pgf_4c_Paginas.Page2.cbo_4c_Cmb_Imp

        IF VARTYPE(loc_oCbo) != "O"
            RETURN
        ENDIF

        loc_oCbo.Clear()
        loc_oCbo.AddItem("DATAREGIS   ")
        loc_oCbo.AddItem("SWEDA       ")
        loc_oCbo.AddItem("BEMATECH    ")
        loc_oCbo.AddItem("BEMA8501    ")
        loc_oCbo.AddItem("NDATAREGIS  ")
        loc_oCbo.AddItem("EPSON       ")
        loc_oCbo.AddItem("DARUMA      ")
        loc_oCbo.AddItem("S/IMPRESSORA")
        loc_oCbo.AddItem("NSWEDA      ")
        loc_oCbo.AddItem("Em Branco   ")
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita ou desabilita campos editaveis da Page2
    * Usa TYPE() + PEMSTATUS() como guards para seguranca multi-fase
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Campos Fase 5
        IF VARTYPE(loc_oPg2.cbo_4c_Cmb_Imp) = "O"
            loc_oPg2.cbo_4c_Cmb_Imp.Enabled = par_lHabilitar
        ENDIF
        IF VARTYPE(loc_oPg2.txt_4c_Finalz) = "O"
            loc_oPg2.txt_4c_Finalz.Enabled  = par_lHabilitar
        ENDIF
        IF VARTYPE(loc_oPg2.txt_4c_Ordem) = "O"
            loc_oPg2.txt_4c_Ordem.Enabled   = par_lHabilitar
        ENDIF
        IF VARTYPE(loc_oPg2.txt_4c_Descr) = "O"
            loc_oPg2.txt_4c_Descr.Enabled   = par_lHabilitar
        ENDIF

        *-- Campos Fase 6 (adicionados por ConfigurarPaginaDados Parte 2)
        IF PEMSTATUS(loc_oPg2, "opt_4c_Opc_fixo", 5)
            loc_oPg2.opt_4c_Opc_fixo.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Vincs", 5)
            loc_oPg2.txt_4c_Vincs.Enabled    = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_CodRelGer", 5)
            loc_oPg2.txt_4c_CodRelGer.Enabled = par_lHabilitar AND ;
                INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_DesRelGer", 5)
            loc_oPg2.txt_4c_DesRelGer.Enabled = par_lHabilitar AND ;
                INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
        ENDIF
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa todos os campos da Page2 para inclusao
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF VARTYPE(loc_oPg2.cbo_4c_Cmb_Imp) = "O"
            loc_oPg2.cbo_4c_Cmb_Imp.Value = ""
        ENDIF
        IF VARTYPE(loc_oPg2.txt_4c_Finalz) = "O"
            loc_oPg2.txt_4c_Finalz.Value = 0
        ENDIF
        IF VARTYPE(loc_oPg2.txt_4c_Ordem) = "O"
            loc_oPg2.txt_4c_Ordem.Value = 0
        ENDIF
        IF VARTYPE(loc_oPg2.txt_4c_Descr) = "O"
            loc_oPg2.txt_4c_Descr.Value = ""
        ENDIF

        *-- Campos Fase 6
        IF PEMSTATUS(loc_oPg2, "opt_4c_Opc_fixo", 5)
            loc_oPg2.opt_4c_Opc_fixo.Value = 2
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Vincs", 5)
            loc_oPg2.txt_4c_Vincs.Value = "N"
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_CodRelGer", 5)
            loc_oPg2.txt_4c_CodRelGer.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_DesRelGer", 5)
            loc_oPg2.txt_4c_DesRelGer.Value = ""
        ENDIF
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes de acao conforme modo
    * Padrao canonico: Confirmar disabled em VISUALIZAR, Cancelar sempre ativo
    *===========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2, loc_lPodeEditar
        loc_oPg2        = THIS.pgf_4c_Paginas.Page2
        loc_lPodeEditar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        IF VARTYPE(loc_oPg2.cnt_4c_BotoesAcao) = "O"
            WITH loc_oPg2.cnt_4c_BotoesAcao
                IF VARTYPE(.cmd_4c_Confirmar) = "O"
                    .cmd_4c_Confirmar.Enabled = loc_lPodeEditar
                ENDIF
                IF VARTYPE(.cmd_4c_Cancelar) = "O"
                    .cmd_4c_Cancelar.Enabled = .T.
                ENDIF
                .Visible     = .T.
            ENDWITH
        ENDIF
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere valores dos campos do Form para o BO
    * Chamado antes de Salvar()
    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Campos Fase 5
        IF VARTYPE(loc_oPg2.cbo_4c_Cmb_Imp) = "O"
            THIS.this_oBusinessObject.this_cImps     = ALLTRIM(loc_oPg2.cbo_4c_Cmb_Imp.Value)
        ENDIF
        IF VARTYPE(loc_oPg2.txt_4c_Finalz) = "O"
            THIS.this_oBusinessObject.this_nCodFinzs = loc_oPg2.txt_4c_Finalz.Value
        ENDIF
        IF VARTYPE(loc_oPg2.txt_4c_Ordem) = "O"
            THIS.this_oBusinessObject.this_nOrdems   = loc_oPg2.txt_4c_Ordem.Value
        ENDIF
        IF VARTYPE(loc_oPg2.txt_4c_Descr) = "O"
            THIS.this_oBusinessObject.this_cDescrs   = ALLTRIM(loc_oPg2.txt_4c_Descr.Value)
        ENDIF

        *-- Campos Fase 6
        IF PEMSTATUS(loc_oPg2, "opt_4c_Opc_fixo", 5)
            THIS.this_oBusinessObject.this_nFixos   = loc_oPg2.opt_4c_Opc_fixo.Value
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Vincs", 5)
            THIS.this_oBusinessObject.this_cVincs   = ALLTRIM(loc_oPg2.txt_4c_Vincs.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_CodRelGer", 5)
            THIS.this_oBusinessObject.this_nRelGers = loc_oPg2.txt_4c_CodRelGer.Value
        ENDIF
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere valores do BO para os campos do Form
    * Chamado apos CarregarPorCodigo() em Visualizar/Alterar
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Campos Fase 5
        IF VARTYPE(loc_oPg2.cbo_4c_Cmb_Imp) = "O"
            loc_oPg2.cbo_4c_Cmb_Imp.Value = ALLTRIM(THIS.this_oBusinessObject.this_cImps)
        ENDIF
        IF VARTYPE(loc_oPg2.txt_4c_Finalz) = "O"
            loc_oPg2.txt_4c_Finalz.Value  = THIS.this_oBusinessObject.this_nCodFinzs
        ENDIF
        IF VARTYPE(loc_oPg2.txt_4c_Ordem) = "O"
            loc_oPg2.txt_4c_Ordem.Value   = THIS.this_oBusinessObject.this_nOrdems
        ENDIF
        IF VARTYPE(loc_oPg2.txt_4c_Descr) = "O"
            loc_oPg2.txt_4c_Descr.Value   = THIS.this_oBusinessObject.this_cDescrs
        ENDIF

        *-- Campos Fase 6
        IF PEMSTATUS(loc_oPg2, "opt_4c_Opc_fixo", 5)
            loc_oPg2.opt_4c_Opc_fixo.Value  = THIS.this_oBusinessObject.this_nFixos
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Vincs", 5)
            loc_oPg2.txt_4c_Vincs.Value      = THIS.this_oBusinessObject.this_cVincs
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_CodRelGer", 5)
            loc_oPg2.txt_4c_CodRelGer.Value  = THIS.this_oBusinessObject.this_nRelGers
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_DesRelGer", 5)
            loc_oPg2.txt_4c_DesRelGer.Value  = THIS.this_oBusinessObject.this_cDescs
        ENDIF

        THIS.AtualizarEstadoDesRelGer()
    ENDPROC

    *===========================================================================
    * ValidarVincs - Handler LostFocus para txt_4c_Vincs
    * Valida que o valor eh apenas 'S' ou 'N' (Get_Vincs.Valid no original)
    *===========================================================================
    PROCEDURE ValidarVincs(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cValor
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cValor = ""

        IF VARTYPE(loc_oPg2.txt_4c_Vincs) = "O"
            loc_cValor = UPPER(ALLTRIM(loc_oPg2.txt_4c_Vincs.Value))
            IF !EMPTY(loc_cValor) AND !INLIST(loc_cValor, "S", "N")
                MsgAviso("Vinculado deve ser S ou N.", "Vinculado")
                loc_oPg2.txt_4c_Vincs.Value = "N"
                loc_oPg2.txt_4c_Vincs.SetFocus
            ELSE
                IF !EMPTY(loc_cValor)
                loc_oPg2.txt_4c_Vincs.Value = loc_cValor
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * CodRelGerKeyPress - Handler KeyPress para txt_4c_CodRelGer
    * Abre lookup via F4 (keycode 28 no VFP9)
    *===========================================================================
    PROCEDURE CodRelGerKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupRelGerPorCodigo()
        ENDIF
    ENDPROC

    *===========================================================================
    * DesRelGerKeyPress - Handler KeyPress para txt_4c_DesRelGer
    * Abre lookup via F4 (keycode 28 no VFP9)
    *===========================================================================
    PROCEDURE DesRelGerKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupRelGerPorDescricao()
        ENDIF
    ENDPROC

    *===========================================================================
    * CodRelGerLostFocus - Handler LostFocus para txt_4c_CodRelGer
    * Busca SigFiRlg por Ordems; se nao encontrado, abre picker.
    * Equivale ao GetCodRelGer.Valid do original.
    *===========================================================================
    PROCEDURE CodRelGerLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_nCod, loc_cImps, loc_cSQL, loc_nResult
        loc_oPg2  = THIS.pgf_4c_Paginas.Page2
        loc_nCod  = 0
        loc_cImps = ""

        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF

        IF VARTYPE(loc_oPg2.txt_4c_CodRelGer) = "O"
            loc_nCod = loc_oPg2.txt_4c_CodRelGer.Value
        ENDIF

        IF loc_nCod = 0
            IF VARTYPE(loc_oPg2.txt_4c_DesRelGer) = "O"
                loc_oPg2.txt_4c_DesRelGer.Value = ""
            ENDIF
            THIS.AtualizarEstadoDesRelGer()
            RETURN
        ENDIF

        IF VARTYPE(loc_oPg2.cbo_4c_Cmb_Imp) = "O"
            loc_cImps = ALLTRIM(loc_oPg2.cbo_4c_Cmb_Imp.Value)
        ENDIF

        IF EMPTY(loc_cImps)
            RETURN
        ENDIF

        loc_cSQL    = "SELECT Ordems, Descrs FROM SigFiRlg WHERE Imps = " + ;
            EscaparSQL(loc_cImps)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "csTmpRelgBusca")

        IF loc_nResult > 0 AND USED("csTmpRelgBusca")
            SELECT csTmpRelgBusca
            LOCATE FOR Ordems = loc_nCod

            IF !EOF("csTmpRelgBusca")
                IF VARTYPE(loc_oPg2.txt_4c_DesRelGer) = "O"
                    loc_oPg2.txt_4c_DesRelGer.Value = ALLTRIM(csTmpRelgBusca.Descrs)
                ENDIF
            ELSE
                IF USED("csTmpRelgBusca")
                    USE IN csTmpRelgBusca
                ENDIF
                THIS.AbrirLookupRelGerPorCodigo()
                THIS.AtualizarEstadoDesRelGer()
                RETURN
            ENDIF
        ENDIF

        IF USED("csTmpRelgBusca")
            USE IN csTmpRelgBusca
        ENDIF
        THIS.AtualizarEstadoDesRelGer()
    ENDPROC

    *===========================================================================
    * DesRelGerLostFocus - Handler LostFocus para txt_4c_DesRelGer
    * Busca SigFiRlg por Descrs; se nao encontrado, abre picker.
    * Equivale ao GetDesRelGer.Valid do original.
    * Ativo apenas quando CodRelGer estiver vazio (When do original).
    *===========================================================================
    PROCEDURE DesRelGerLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cDes, loc_cImps, loc_cSQL, loc_nResult
        loc_oPg2  = THIS.pgf_4c_Paginas.Page2
        loc_cDes  = ""
        loc_cImps = ""

        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF

        *-- So valida se CodRelGer estiver vazio (When original: Empty(GetCodRelGer.Value))
        IF VARTYPE(loc_oPg2.txt_4c_CodRelGer) = "O"
            IF loc_oPg2.txt_4c_CodRelGer.Value <> 0
                RETURN
            ENDIF
        ENDIF

        IF VARTYPE(loc_oPg2.txt_4c_DesRelGer) = "O"
            loc_cDes = ALLTRIM(loc_oPg2.txt_4c_DesRelGer.Value)
        ENDIF

        IF EMPTY(loc_cDes)
            IF VARTYPE(loc_oPg2.txt_4c_CodRelGer) = "O"
                loc_oPg2.txt_4c_CodRelGer.Value = 0
            ENDIF
            RETURN
        ENDIF

        IF VARTYPE(loc_oPg2.cbo_4c_Cmb_Imp) = "O"
            loc_cImps = ALLTRIM(loc_oPg2.cbo_4c_Cmb_Imp.Value)
        ENDIF

        IF EMPTY(loc_cImps)
            RETURN
        ENDIF

        loc_cSQL    = "SELECT Ordems, Descrs FROM SigFiRlg WHERE Imps = " + ;
            EscaparSQL(loc_cImps)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "csTmpRelgBusca")

        IF loc_nResult > 0 AND USED("csTmpRelgBusca")
            SELECT csTmpRelgBusca
            LOCATE FOR UPPER(ALLTRIM(Descrs)) = UPPER(loc_cDes)

            IF !EOF("csTmpRelgBusca")
                IF VARTYPE(loc_oPg2.txt_4c_CodRelGer) = "O"
                    loc_oPg2.txt_4c_CodRelGer.Value = csTmpRelgBusca.Ordems
                ENDIF
                IF VARTYPE(loc_oPg2.txt_4c_DesRelGer) = "O"
                    loc_oPg2.txt_4c_DesRelGer.Value = ALLTRIM(csTmpRelgBusca.Descrs)
                ENDIF
            ELSE
                IF USED("csTmpRelgBusca")
                    USE IN csTmpRelgBusca
                ENDIF
                THIS.AbrirLookupRelGerPorDescricao()
                THIS.AtualizarEstadoDesRelGer()
                RETURN
            ENDIF
        ENDIF

        IF USED("csTmpRelgBusca")
            USE IN csTmpRelgBusca
        ENDIF
        THIS.AtualizarEstadoDesRelGer()
    ENDPROC

    *===========================================================================
    * AbrirLookupRelGerPorCodigo - Picker de Rel. Gerencial a partir do campo codigo
    * Tabela: SigFiRlg. Filtrado por Imps do combo.
    * Equivale ao fwBuscaInt com Ordems+Descrs do GetCodRelGer.Valid original.
    *===========================================================================
    PROCEDURE AbrirLookupRelGerPorCodigo()
        LOCAL loc_oPg2, loc_cImps, loc_oBusca, loc_cSQL, loc_nResult
        loc_oPg2  = THIS.pgf_4c_Paginas.Page2
        loc_cImps = ""

        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF

        IF VARTYPE(loc_oPg2.cbo_4c_Cmb_Imp) = "O"
            loc_cImps = ALLTRIM(loc_oPg2.cbo_4c_Cmb_Imp.Value)
        ENDIF

        IF EMPTY(loc_cImps)
            MsgAviso("Selecione a Impressora antes de buscar o Relat" + CHR(243) + ;
                "rio Gerencial.", "Lookup")
            RETURN
        ENDIF

        loc_cSQL    = "SELECT Ordems, Descrs FROM SigFiRlg WHERE Imps = " + ;
            EscaparSQL(loc_cImps)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "csTmpRelgLkp")

        IF loc_nResult <= 0 OR !USED("csTmpRelgLkp") OR RECCOUNT("csTmpRelgLkp") = 0
            IF USED("csTmpRelgLkp")
                USE IN csTmpRelgLkp
            ENDIF
            MsgAviso("Nenhum Relat" + CHR(243) + "rio Gerencial para a impressora selecionada.", ;
                "Lookup")
            RETURN
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")

        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.this_cCursorDestino = "csTmpRelgLkp"
            loc_oBusca.this_cTitulo        = "Rel. Gerencial"
            loc_oBusca.mAddColuna("Ordems", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou AND USED("csTmpRelgLkp")
                SELECT csTmpRelgLkp
                IF VARTYPE(loc_oPg2.txt_4c_CodRelGer) = "O"
                    loc_oPg2.txt_4c_CodRelGer.Value = csTmpRelgLkp.Ordems
                ENDIF
                IF VARTYPE(loc_oPg2.txt_4c_DesRelGer) = "O"
                    loc_oPg2.txt_4c_DesRelGer.Value = ALLTRIM(csTmpRelgLkp.Descrs)
                ENDIF
            ELSE
                IF !loc_oBusca.this_lSelecionou
                IF VARTYPE(loc_oPg2.txt_4c_CodRelGer) = "O"
                    loc_oPg2.txt_4c_CodRelGer.Value = 0
                ENDIF
                IF VARTYPE(loc_oPg2.txt_4c_DesRelGer) = "O"
                    loc_oPg2.txt_4c_DesRelGer.Value = ""
                ENDIF
                ENDIF
            ENDIF

            loc_oBusca.Release()
        ENDIF

        IF USED("csTmpRelgLkp")
            USE IN csTmpRelgLkp
        ENDIF
    ENDPROC

    *===========================================================================
    * AbrirLookupRelGerPorDescricao - Picker de Rel. Gerencial a partir da descricao
    * Mesma tabela SigFiRlg, colunas reordenadas: Descrs primeiro.
    * Equivale ao fwBuscaInt com Descrs+Ordems do GetDesRelGer.Valid original.
    *===========================================================================
    PROCEDURE AbrirLookupRelGerPorDescricao()
        LOCAL loc_oPg2, loc_cImps, loc_oBusca, loc_cSQL, loc_nResult
        loc_oPg2  = THIS.pgf_4c_Paginas.Page2
        loc_cImps = ""

        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF

        IF VARTYPE(loc_oPg2.cbo_4c_Cmb_Imp) = "O"
            loc_cImps = ALLTRIM(loc_oPg2.cbo_4c_Cmb_Imp.Value)
        ENDIF

        IF EMPTY(loc_cImps)
            MsgAviso("Selecione a Impressora antes de buscar o Relat" + CHR(243) + ;
                "rio Gerencial.", "Lookup")
            RETURN
        ENDIF

        loc_cSQL    = "SELECT Ordems, Descrs FROM SigFiRlg WHERE Imps = " + ;
            EscaparSQL(loc_cImps)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "csTmpRelgLkp")

        IF loc_nResult <= 0 OR !USED("csTmpRelgLkp") OR RECCOUNT("csTmpRelgLkp") = 0
            IF USED("csTmpRelgLkp")
                USE IN csTmpRelgLkp
            ENDIF
            MsgAviso("Nenhum Relat" + CHR(243) + "rio Gerencial para a impressora selecionada.", ;
                "Lookup")
            RETURN
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")

        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.this_cCursorDestino = "csTmpRelgLkp"
            loc_oBusca.this_cTitulo        = "Rel. Gerencial"
            loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.mAddColuna("Ordems", "", "C" + CHR(243) + "digo")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou AND USED("csTmpRelgLkp")
                SELECT csTmpRelgLkp
                IF VARTYPE(loc_oPg2.txt_4c_CodRelGer) = "O"
                    loc_oPg2.txt_4c_CodRelGer.Value = csTmpRelgLkp.Ordems
                ENDIF
                IF VARTYPE(loc_oPg2.txt_4c_DesRelGer) = "O"
                    loc_oPg2.txt_4c_DesRelGer.Value = ALLTRIM(csTmpRelgLkp.Descrs)
                ENDIF
            ELSE
                IF !loc_oBusca.this_lSelecionou
                IF VARTYPE(loc_oPg2.txt_4c_CodRelGer) = "O"
                    loc_oPg2.txt_4c_CodRelGer.Value = 0
                ENDIF
                IF VARTYPE(loc_oPg2.txt_4c_DesRelGer) = "O"
                    loc_oPg2.txt_4c_DesRelGer.Value = ""
                ENDIF
                ENDIF
            ENDIF

            loc_oBusca.Release()
        ENDIF

        IF USED("csTmpRelgLkp")
            USE IN csTmpRelgLkp
        ENDIF
    ENDPROC

    *===========================================================================
    * AtualizarEstadoDesRelGer - Habilita/desabilita txt_4c_DesRelGer conforme
    * o valor de txt_4c_CodRelGer (When do original: Empty(GetCodRelGer.Value))
    *===========================================================================
    PROTECTED PROCEDURE AtualizarEstadoDesRelGer()
        LOCAL loc_oPg2, loc_lCodVazio
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_lCodVazio = .T.

        IF VARTYPE(loc_oPg2.txt_4c_CodRelGer) = "O"
            loc_lCodVazio = (loc_oPg2.txt_4c_CodRelGer.Value = 0)
        ENDIF

        IF VARTYPE(loc_oPg2.txt_4c_DesRelGer) = "O"
            loc_oPg2.txt_4c_DesRelGer.Enabled = loc_lCodVazio AND ;
                INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
        ENDIF
    ENDPROC

    *===========================================================================
    * Destroy - Libera recursos do formulario
    *===========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        IF USED("crSigFiNal")
            USE IN crSigFiNal
        ENDIF
        IF USED("csTmpRelgBusca")
            USE IN csTmpRelgBusca
        ENDIF
        IF USED("csTmpRelgLkp")
            USE IN csTmpRelgLkp
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\fnlBO.prg):
*==============================================================================
* fnlBO.prg - Business Object para Tabela de Finalizacoes (SigFiNal)
* Herda de: BusinessBase
* Tabela: SigFiNal (PK composta: imps + ordems)
*==============================================================================

DEFINE CLASS fnlBO AS BusinessBase

    *-- Propriedades da tabela SigFiNal
    this_cImps       = ""   && char(20) - Impressora (PK parte 1)
    this_nOrdems     = 0    && numeric(2,0) - Ordem finalizadora
    this_cDescrs     = ""   && char(40) - Descricao
    this_nCodFinzs   = 0    && numeric(2,0) - Codigo finalizador
    this_nFixos      = 2    && numeric(1,0) - Fixo (1=Sim, 2=Nao)
    this_cVincs      = "N"  && char(1) - Vinculado (S/N)
    this_nRelGers    = 0    && numeric(1,0) - FK SigFiRlg.ordems
    this_cDescs      = ""   && alias SigFiRlg.descrs (nao coluna real - lookup display)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigFiNal"
        THIS.this_cCampoChave = "imps"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cImps) + STR(THIS.this_nOrdems, 2, 0)
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cImps       = TratarNulo(imps,       "C")
            THIS.this_nOrdems     = TratarNulo(ordems,     "N")
            THIS.this_cDescrs     = TratarNulo(descrs,     "C")
            THIS.this_nCodFinzs   = TratarNulo(ncodfinzs,  "N")
            THIS.this_nFixos      = TratarNulo(nfixos,     "N")
            THIS.this_cVincs      = TratarNulo(vincs,      "C")
            THIS.this_nRelGers    = TratarNulo(nrelgers,   "N")
            *-- descs vem do JOIN; se coluna existir no cursor, carregar
            IF TYPE("descs") != "U"
                THIS.this_cDescs  = TratarNulo(descs,      "C")
            ELSE
                THIS.this_cDescs  = ""
            ENDIF
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.imps, a.ordems, a.descrs," + ;
                       " a.nfixos, a.ncodfinzs, a.vincs, a.nrelgers," + ;
                       " b.descrs AS descs" + ;
                       " FROM SigFiNal a" + ;
                       " LEFT JOIN SigFiRlg b ON b.ordems = a.nrelgers AND b.imps = a.imps"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.imps, a.ordems"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crSigFiNal")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar finalizacoes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cImps, par_nOrdems)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.imps, a.ordems, a.descrs," + ;
                       " a.nfixos, a.ncodfinzs, a.vincs, a.nrelgers," + ;
                       " b.descrs AS descs" + ;
                       " FROM SigFiNal a" + ;
                       " LEFT JOIN SigFiRlg b ON b.ordems = a.nrelgers AND b.imps = a.imps" + ;
                       " WHERE a.imps = " + EscaparSQL(par_cImps) + ;
                       " AND a.ordems = " + FormatarNumeroSQL(par_nOrdems)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CarregaFnl")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_CarregaFnl") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_CarregaFnl")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar finalizacao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_CarregaFnl")
            USE IN cursor_4c_CarregaFnl
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarRelGerencial - Busca registros de SigFiRlg para lookup de Rel. Gerencial
    *--------------------------------------------------------------------------
    PROCEDURE BuscarRelGerencial(par_cImps, par_cCursorDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        IF EMPTY(par_cCursorDestino)
            par_cCursorDestino = "cursor_4c_RelGer"
        ENDIF

        TRY
            loc_cSQL = "SELECT ordems, descrs FROM SigFiRlg" + ;
                       " WHERE imps = " + EscaparSQL(par_cImps) + ;
                       " ORDER BY ordems"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, par_cCursorDestino)

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar Rel. Gerencial:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigFiNal" + ;
                       " (imps, ordems, descrs, nfixos, ncodfinzs, vincs, nrelgers)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cImps) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nOrdems) + ", " + ;
                       EscaparSQL(THIS.this_cDescrs) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nFixos) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCodFinzs) + ", " + ;
                       EscaparSQL(THIS.this_cVincs) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nRelGers) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir finalizacao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigFiNal SET" + ;
                       " imps = "      + EscaparSQL(THIS.this_cImps) + ", " + ;
                       " ordems = "    + FormatarNumeroSQL(THIS.this_nOrdems) + ", " + ;
                       " descrs = "    + EscaparSQL(THIS.this_cDescrs) + ", " + ;
                       " nfixos = "    + FormatarNumeroSQL(THIS.this_nFixos) + ", " + ;
                       " ncodfinzs = " + FormatarNumeroSQL(THIS.this_nCodFinzs) + ", " + ;
                       " vincs = "     + EscaparSQL(THIS.this_cVincs) + ", " + ;
                       " nrelgers = "  + FormatarNumeroSQL(THIS.this_nRelGers) + ;
                       " WHERE imps = " + EscaparSQL(THIS.this_cImps) + ;
                       " AND ordems = " + FormatarNumeroSQL(THIS.this_nOrdems)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar finalizacao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigFiNal WHERE imps = " + ;
                       EscaparSQL(THIS.this_cImps) + ;
                       " AND ordems = " + FormatarNumeroSQL(THIS.this_nOrdems)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir finalizacao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarOrdemDuplicada - Verifica se Imps+Ordems ja existe (INSERT)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarOrdemDuplicada(par_cImps, par_nOrdems)
        LOCAL loc_cSQL, loc_nResultado, loc_lDuplicado
        loc_lDuplicado = .F.

        TRY
            loc_cSQL = "SELECT * FROM SigFiNal WHERE imps = " + ;
                       EscaparSQL(par_cImps) + ;
                       " AND ordems = " + FormatarNumeroSQL(par_nOrdems)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldOrd")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_VldOrd") > 0
                loc_lDuplicado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_VldOrd")
            USE IN cursor_4c_VldOrd
        ENDIF

        RETURN loc_lDuplicado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCodigoDuplicado - Verifica se Imps+ncodfinzs ja existe (INSERT)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCodigoDuplicado(par_cImps, par_nCodFinzs)
        LOCAL loc_cSQL, loc_nResultado, loc_lDuplicado
        loc_lDuplicado = .F.

        TRY
            loc_cSQL = "SELECT * FROM SigFiNal WHERE imps = " + ;
                       EscaparSQL(par_cImps) + ;
                       " AND ncodfinzs = " + FormatarNumeroSQL(par_nCodFinzs)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldCod")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_VldCod") > 0
                loc_lDuplicado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_VldCod")
            USE IN cursor_4c_VldCod
        ENDIF

        RETURN loc_lDuplicado
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarProximoNcodFinzs - Proximo codigo finalizador disponivel por impressora
    * Substitui fGerUniqueKey('SigFiNal') do legado
    *--------------------------------------------------------------------------
    PROCEDURE GerarProximoNcodFinzs(par_cImps)
        LOCAL loc_nResultado, loc_nProximo
        loc_nProximo = 1

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT ISNULL(MAX(ncodfinzs), 0) + 1 AS Proximo FROM SigFiNal" + ;
                " WHERE imps = " + EscaparSQL(par_cImps), ;
                "cursor_4c_ProxCod")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ProxCod") > 0
                SELECT cursor_4c_ProxCod
                loc_nProximo = cursor_4c_ProxCod.Proximo
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao gerar pr" + CHR(243) + "ximo c" + CHR(243) + "digo:" + ;
                CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_ProxCod")
            USE IN cursor_4c_ProxCod
        ENDIF

        RETURN loc_nProximo
    ENDPROC

ENDDEFINE

