# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 56% < 100%. Falhas: Teste 'CarregarLista': Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc); Teste 'ModoIncluir': Property ALTERNARPAGINA is not found. | Detalhes: Linha: 412; Teste 'ModoVisualizar': Property AJUSTARBOTOESPORMODO is not found. | Detalhes: Linha: 542; Teste 'BtnIncluirNavegacao': BtnIncluirClick nao navegou para Page2 (ActivePage=1)

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[02/08/2026 02:52:00] Erro: Erro em ConfigurarPaginaLista:File 'isobject.prg' does not exist.
[02/08/2026 02:52:00] Erro: Erro em ConfigurarPgFicha:Error with Column7 - CurrentControl : Expression evaluated to an illegal value.
[02/08/2026 02:52:00] Erro: Erro em ConfigurarPgCompl:File 'isobject.prg' does not exist.
[02/08/2026 02:52:00] Erro: Erro em ConfigurarPaginaDados:File 'isobject.prg' does not exist.
[02/08/2026 02:52:00] Erro: Erro ao buscar grupos:Connection handle is invalid.Linha: 192
[02/08/2026 02:52:01] Erro: Erro ao buscar grupos:Connection handle is invalid.Linha: 192
[02/08/2026 02:52:01] Aviso: Selecione um grupo na lista.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-02 02:51:07] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-02 02:51:07] [INFO] Config FPW: (nao fornecido)
[2026-08-02 02:51:07] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-02 02:51:07] [INFO] Timeout: 300 segundos
[2026-08-02 02:51:07] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_xizxwbz0.prg
[2026-08-02 02:51:07] [INFO] Conteudo do wrapper:
[2026-08-02 02:51:07] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormFct', 'C:\4c\tasks\task415', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormFct', 'C:\4c\tasks\task415', 'CRUD'
QUIT

[2026-08-02 02:51:07] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_xizxwbz0.prg
[2026-08-02 02:51:07] [INFO] VFP output esperado em: C:\4c\tasks\task415\vfp_output.txt
[2026-08-02 02:51:07] [INFO] Executando Visual FoxPro 9...
[2026-08-02 02:51:07] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_xizxwbz0.prg
[2026-08-02 02:51:07] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_xizxwbz0.prg
[2026-08-02 02:51:07] [INFO] Timeout configurado: 300 segundos
[2026-08-02 02:52:01] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-02 02:52:01] [INFO] VFP9 finalizado em 53.3735115 segundos
[2026-08-02 02:52:01] [INFO] Exit Code: 
[2026-08-02 02:52:01] [INFO] 
[2026-08-02 02:52:01] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-02 02:52:01] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_xizxwbz0.prg
[2026-08-02 02:52:01] [INFO] 
[2026-08-02 02:52:01] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-02 02:52:01] [INFO] * Auto-generated wrapper for parameters
[2026-08-02 02:52:01] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-02 02:52:01] [INFO] * Parameters: 'FormFct', 'C:\4c\tasks\task415', 'CRUD'
[2026-08-02 02:52:01] [INFO] 
[2026-08-02 02:52:01] [INFO] * Anti-dialog protections for unattended execution
[2026-08-02 02:52:01] [INFO] SET SAFETY OFF
[2026-08-02 02:52:01] [INFO] SET RESOURCE OFF
[2026-08-02 02:52:01] [INFO] SET TALK OFF
[2026-08-02 02:52:01] [INFO] SET NOTIFY OFF
[2026-08-02 02:52:01] [INFO] SYS(2335, 0)
[2026-08-02 02:52:01] [INFO] 
[2026-08-02 02:52:01] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormFct', 'C:\4c\tasks\task415', 'CRUD'
[2026-08-02 02:52:01] [INFO] QUIT
[2026-08-02 02:52:01] [INFO] 
[2026-08-02 02:52:01] [INFO] === Fim do Wrapper.prg ===
[2026-08-02 02:52:01] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormFct",
  "timestamp": "20260802025201",
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
      "passou": false,
      "erro": "BtnIncluirClick nao navegou para Page2 (ActivePage=1)",
      "detalhes": ""
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
      "detalhes": "AbrirLookup: 0 | KeyPress handlers: 2 (KEYPRESS, KEYPRESSCTPDADOS)"
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
    "passou": 5,
    "falhou": 4,
    "percentual": 56
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormFct.prg):
*==============================================================================
* FormFct.prg - Cadastro de Ficha Tecnica / Perfis
* Arquitetura: FormBase -> FctBO -> DataAccess (SQL Server)
* nTipo: 0=Produtos (SigCdGrp/SigCdPsg)  1=Contas (SigCdGcr)  2=Movimentacoes (SigCdOpe)
*==============================================================================

DEFINE CLASS FormFct AS FormBase

    Height      = 600
    Width       = 1000
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    Caption     = "Cadastro de Ficha Tecnica"
    DataSession = 1

    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"
    this_nTipo           = 0

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
    LPARAMETERS pcTipo
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            THIS.this_nTipo = IIF(TYPE("pcTipo") <> "C", 0, IIF(pcTipo == "C", 1, 2))
            DO CASE
            CASE THIS.this_nTipo = 1
                THIS.Caption = "Cadastro de Perfil de Contas"
            CASE THIS.this_nTipo = 2
                THIS.Caption = "Configura" + CHR(231) + CHR(227) + "o de Movimenta" + CHR(231) + CHR(227) + "o"
            OTHERWISE
                THIS.Caption = "Cadastro de Ficha T" + CHR(233) + "cnica"
            ENDCASE
            loc_lResultado = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar FormFct:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("FctBO")
            IF VARTYPE(THIS.this_oBusinessObject) <> "O" OR ISNULL(THIS.this_oBusinessObject)
                MsgErro("Erro ao criar FctBO.", "Erro")
            ELSE
                THIS.this_oBusinessObject.this_nTipo = THIS.this_nTipo
                THIS.this_oBusinessObject.CriarCursores()
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.CarregarLista()
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em InicializarForm (FormFct):" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
    *--------------------------------------------------------------------------
        LOCAL loc_aCursores, loc_n
        TRY
            DIMENSION loc_aCursores(5)
            loc_aCursores(1) = "cursor_4c_BuscaCCars"
            loc_aCursores(2) = "cursor_4c_BuscaCTits"
            loc_aCursores(3) = "cursor_4c_BuscaGrp"
            loc_aCursores(4) = "cursor_4c_CopiaFtc"
            loc_aCursores(5) = "cursor_4c_BuscaSGrp"
            FOR loc_n = 1 TO 5
                IF USED(loc_aCursores(loc_n))
                    USE IN (loc_aCursores(loc_n))
                ENDIF
            ENDFOR
            IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !ISNULL(THIS.this_oBusinessObject)
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao destruir FormFct:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            THIS.AddObject("pgf_4c_Paginas", "PageFrame")
            WITH THIS.pgf_4c_Paginas
                .Top       = -29
                .Left      = 0
                .Width     = THIS.Width
                .Height    = THIS.Height + 29
                .Tabs      = .F.
                .PageCount = 2
                .Page1.Caption = "Lista"
                .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
                .Page2.Caption = "Dados"
                .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
                .Visible   = .T.
            ENDWITH
            THIS.ConfigurarPaginaLista()
            THIS.ConfigurarPaginaDados()
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em ConfigurarPageFrame:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_oPag
        loc_lResultado = .F.
        TRY
            loc_oPag = THIS.pgf_4c_Paginas.Page1

            loc_oPag.AddObject("cnt_4c_Cabecalho", "Container")
            WITH loc_oPag.cnt_4c_Cabecalho
                .Top       = 30
                .Left      = 0
                .Width     = THIS.Width
                .Height    = 30
                .BackStyle = 1
                .BackColor = RGB(64, 64, 64)
                .Visible   = .T.
                .AddObject("lbl_4c_Titulo", "Label")
                WITH .lbl_4c_Titulo
                    .Top       = 0
                    .Left      = 0
                    .Width     = THIS.Width
                    .Height    = 30
                    .AutoSize  = .F.
                    .BackStyle = 0
                    .ForeColor = RGB(255, 255, 255)
                    .FontSize  = 12
                    .FontBold  = .T.
                    DO CASE
                    CASE THIS.this_nTipo = 1
                        .Caption = "  Perfis de Contas"
                    CASE THIS.this_nTipo = 2
                        .Caption = "  Movimenta" + CHR(231) + CHR(227) + "o"
                    OTHERWISE
                        .Caption = "  Fichas T" + CHR(233) + "cnicas de Produtos"
                    ENDCASE
                    .Visible   = .T.
                ENDWITH
            ENDWITH

            loc_oPag.AddObject("cnt_4c_Botoes", "Container")
            WITH loc_oPag.cnt_4c_Botoes
                .Top       = 29
                .Left      =  542
                .Width     = 390
                .Height    = 85
                .BackStyle = 1
                .BackColor = RGB(53, 53, 53)
                .Visible   = .T.
                .AddObject("cmd_4c_Incluir", "CommandButton")
                WITH .cmd_4c_Incluir
                    .Top             = 5
                    .Left            =  542
                    .Width           = 75
                    .Height          = 75
                    .Caption         = "Incluir"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
                    .PicturePosition = 13
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
                    .Top             = 5
                    .Left            =  542
                    .Width           = 75
                    .Height          = 75
                    .Caption         = "Visualizar"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
                    .PicturePosition = 13
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
                    .Top             = 5
                    .Left            =  542
                    .Width           = 75
                    .Height          = 75
                    .Caption         = "Alterar"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
                    .PicturePosition = 13
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
                    .Top             = 5
                    .Left            =  542
                    .Width           = 75
                    .Height          = 75
                    .Caption         = "Excluir"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                    .PicturePosition = 13
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
                    .Top             = 5
                    .Left            =  542
                    .Width           = 75
                    .Height          = 75
                    .Caption         = "Buscar"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
                    .PicturePosition = 13
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

            loc_oPag.AddObject("cnt_4c_Saida", "Container")
            WITH loc_oPag.cnt_4c_Saida
                .Top       = 29
                .Left      = 917
                .Width     = 90
                .Height    = 85
                .BackStyle = 0
                .Visible   = .T.
                .AddObject("cmd_4c_Encerrar", "CommandButton")
                WITH .cmd_4c_Encerrar
                    .Top             = 5
                    .Left            = 917
                    .Width           = 75
                    .Height          = 75
                    .Caption         = "Encerrar"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                    .PicturePosition = 13
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

            loc_oPag.AddObject("shp_4c_Legenda", "Shape")
            WITH loc_oPag.shp_4c_Legenda
                .Top         = 123
                .Left        = 696
                .Width       = 20
                .Height      = 16
                .BackStyle   = 1
                .BackColor   = RGB(255, 255, 187)
                .BorderStyle = 1
                .Visible     = .T.
            ENDWITH

            loc_oPag.AddObject("lbl_4c_LegendaFicha", "Label")
            WITH loc_oPag.lbl_4c_LegendaFicha
                .Top       = 126
                .Left      = 719
                .Width     = 200
                .Height    = 18
                .AutoSize  = .F.
                .BackStyle = 0
                .Caption   = "Ficha T" + CHR(233) + "cnica Criada"
                .Visible   = .T.
            ENDWITH

            loc_oPag.AddObject("grd_4c_Lista", "Grid")
            loc_oPag.grd_4c_Lista.ColumnCount = 4
            WITH loc_oPag.grd_4c_Lista
                .Top          = 152
                .Left         = 11
                .Width        = 941
                .Height       = 470
                .RecordSource = "crDados"
                .ReadOnly     = .T.
                .GridLines    = 1
                .HeaderHeight = 18
                .DeleteMark   = .F.
                .RecordMark   = .F.
                .Visible      = .T.
                WITH .Column1
                    .ControlSource = "crDados.CGrus"
                    DO CASE
                    CASE THIS.this_nTipo = 1
                        .Width           = 100
                        .Header1.Caption = "Grupo"
                    CASE THIS.this_nTipo = 2
                        .Width           = 100
                        .Header1.Caption = "Grupo"
                    OTHERWISE
                        .Width           = 80
                        .Header1.Caption = "Grupo"
                    ENDCASE
                    .ReadOnly = .T.
                ENDWITH
                WITH .Column2
                    .ControlSource   = "crDados.SGrus"
                    .Width           = IIF(THIS.this_nTipo = 0, 100, 0)
                    .Header1.Caption = "Subgrupo"
                    .ReadOnly        = .T.
                ENDWITH
                WITH .Column3
                    .ControlSource = "crDados.DGrus"
                    DO CASE
                    CASE THIS.this_nTipo = 1
                        .Width           = 641
                        .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o do Grupo"
                    CASE THIS.this_nTipo = 2
                        .Width           = 641
                        .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o do Grupo"
                    OTHERWISE
                        .Width           = 403
                        .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o do Grupo"
                    ENDCASE
                    .ReadOnly = .T.
                ENDWITH
                WITH .Column4
                    .ControlSource   = "crDados.DSGru"
                    .Width           = IIF(THIS.this_nTipo = 0, 358, 0)
                    .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o do Subgrupo"
                    .ReadOnly        = .T.
                ENDWITH
            ENDWITH
            loc_oPag.grd_4c_Lista.SetAll("DynamicBackColor", ;
                "IIF(EMPTY(crDados.TemDados), RGB(255,255,255), RGB(255,255,187))", "Column")

            BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
            BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
            BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
            BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
            BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
            BINDEVENT(loc_oPag.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
            BINDEVENT(loc_oPag.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")

            THIS.TornarControlesVisiveis(loc_oPag)
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em ConfigurarPaginaLista:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_oPag
        loc_lResultado = .F.
        TRY
            loc_oPag = THIS.pgf_4c_Paginas.Page2

            loc_oPag.AddObject("cnt_4c_BotoesAcao", "Container")
            WITH loc_oPag.cnt_4c_BotoesAcao
                .Top       = 38
                .Left      = 820
                .Width     = 160
                .Height    = 85
                .BackStyle = 1
                .BackColor = RGB(255, 255, 255)
                .Visible   = .T.
                .AddObject("cmd_4c_Confirmar", "CommandButton")
                WITH .cmd_4c_Confirmar
                    .Top             = 5
                    .Left            = 5
                    .Width           = 70
                    .Height          = 75
                    .Caption         = "Confirmar"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                    .PicturePosition = 13
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
                    .Top             = 5
                    .Left            = 80
                    .Width           = 75
                    .Height          = 75
                    .Caption         = "Encerrar"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                    .PicturePosition = 13
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

            loc_oPag.AddObject("pgf_4c_SubPaginas", "PageFrame")
            WITH loc_oPag.pgf_4c_SubPaginas
                .Top       = 152
                .Left      = 0
                .Width     = THIS.Width
                .Height    = 477
                .Tabs      = .T.
                .PageCount = 2
                .Page1.Caption = "Ficha T" + CHR(233) + "cnica"
                .Page2.Caption = "Complementos"
                .Visible   = .T.
            ENDWITH

            THIS.ConfigurarPgFicha()
            THIS.ConfigurarPgCompl()

            BINDEVENT(loc_oPag.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
            BINDEVENT(loc_oPag.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

            THIS.TornarControlesVisiveis(loc_oPag)
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em ConfigurarPaginaDados:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPgFicha()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_oPg
        loc_lResultado = .F.
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1

            loc_oPg.AddObject("lbl_4c_LabelGrupo", "Label")
            WITH loc_oPg.lbl_4c_LabelGrupo
                .Top      = 20
                .Left     = 55
                .Width    = 40
                .Height   = 18
                .AutoSize = .F.
                .Caption  = "Grupo :"
                .Visible  = .T.
            ENDWITH

            loc_oPg.AddObject("txt_4c_CGrus", "TextBox")
            WITH loc_oPg.txt_4c_CGrus
                .Top           = 17
                .Left          = 98
                .Width         = 80
                .Height        = 20
                .Enabled       = .F.
                .ControlSource = "crFichaCab.CGrus"
                .Visible       = .T.
            ENDWITH

            loc_oPg.AddObject("txt_4c_DGrus", "TextBox")
            WITH loc_oPg.txt_4c_DGrus
                .Top           = 17
                .Left          = 180
                .Width         = 290
                .Height        = 20
                .Enabled       = .F.
                .ControlSource = "crFichaCab.DGrus"
                .Visible       = .T.
            ENDWITH

            loc_oPg.AddObject("lbl_4c_LabelSGrus", "Label")
            WITH loc_oPg.lbl_4c_LabelSGrus
                .Top      = 45
                .Left     = 25
                .Width    = 70
                .Height   = 18
                .AutoSize = .F.
                .Caption  = "Sub-grupo :"
                .Visible  = (THIS.this_nTipo = 0)
            ENDWITH

            loc_oPg.AddObject("txt_4c_SGrus", "TextBox")
            WITH loc_oPg.txt_4c_SGrus
                .Top           = 42
                .Left          = 98
                .Width         = 80
                .Height        = 20
                .Enabled       = .F.
                .ControlSource = "crFichaCab.SGrus"
                .Visible       = (THIS.this_nTipo = 0)
            ENDWITH

            loc_oPg.AddObject("txt_4c_DSGru", "TextBox")
            WITH loc_oPg.txt_4c_DSGru
                .Top           = 42
                .Left          = 180
                .Width         = 290
                .Height        = 20
                .Enabled       = .F.
                .ControlSource = "crFichaCab.DSGru"
                .Visible       = (THIS.this_nTipo = 0)
            ENDWITH

            loc_oPg.AddObject("lbl_4c_LabelChkDims", "Label")
            WITH loc_oPg.lbl_4c_LabelChkDims
                .Top      = 10
                .Left     = 620
                .Width    = 105
                .Height   = 18
                .AutoSize = .F.
                .Caption  = "Dimens" + CHR(245) + "es :"
                .Visible  = (THIS.this_nTipo = 0)
            ENDWITH

            loc_oPg.AddObject("opt_4c_NChkDims", "OptionGroup")
            WITH loc_oPg.opt_4c_NChkDims
                .Top           = 10
                .Left          = 729
                .Width         = 180
                .Height        = 16
                .ButtonCount   = 2
                .Value         = 1
                .ControlSource = "crFichaCab.nChkDims"
                .Visible       = (THIS.this_nTipo = 0)
                WITH .Buttons(1)
                    .Caption   = "Sim"
                    .Width     = 50
                    .BackStyle = 0
                ENDWITH
                WITH .Buttons(2)
                    .Caption   = "N" + CHR(227) + "o"
                    .Left      = 55
                    .Width     = 60
                    .BackStyle = 0
                ENDWITH
            ENDWITH

            loc_oPg.AddObject("lbl_4c_LabelChkTems", "Label")
            WITH loc_oPg.lbl_4c_LabelChkTems
                .Top      = 29
                .Left     = 620
                .Width    = 105
                .Height   = 18
                .AutoSize = .F.
                .Caption  = "Tempos :"
                .Visible  = (THIS.this_nTipo = 0)
            ENDWITH

            loc_oPg.AddObject("opt_4c_NChkTems", "OptionGroup")
            WITH loc_oPg.opt_4c_NChkTems
                .Top           = 29
                .Left          = 729
                .Width         = 180
                .Height        = 16
                .ButtonCount   = 2
                .Value         = 1
                .ControlSource = "crFichaCab.nChkTems"
                .Visible       = (THIS.this_nTipo = 0)
                WITH .Buttons(1)
                    .Caption   = "Sim"
                    .Width     = 50
                    .BackStyle = 0
                ENDWITH
                WITH .Buttons(2)
                    .Caption   = "N" + CHR(227) + "o"
                    .Left      = 55
                    .Width     = 60
                    .BackStyle = 0
                ENDWITH
            ENDWITH

            loc_oPg.AddObject("lbl_4c_LabelChkPess", "Label")
            WITH loc_oPg.lbl_4c_LabelChkPess
                .Top      = 49
                .Left     = 620
                .Width    = 105
                .Height   = 18
                .AutoSize = .F.
                .Caption  = "Pessoas :"
                .Visible  = (THIS.this_nTipo = 0)
            ENDWITH

            loc_oPg.AddObject("opt_4c_NChkPess", "OptionGroup")
            WITH loc_oPg.opt_4c_NChkPess
                .Top           = 49
                .Left          = 729
                .Width         = 180
                .Height        = 16
                .ButtonCount   = 2
                .Value         = 1
                .ControlSource = "crFichaCab.nChkPess"
                .Visible       = (THIS.this_nTipo = 0)
                WITH .Buttons(1)
                    .Caption   = "Sim"
                    .Width     = 50
                    .BackStyle = 0
                ENDWITH
                WITH .Buttons(2)
                    .Caption   = "N" + CHR(227) + "o"
                    .Left      = 55
                    .Width     = 60
                    .BackStyle = 0
                ENDWITH
            ENDWITH

            loc_oPg.AddObject("grd_4c_Fichas", "Grid")
            loc_oPg.grd_4c_Fichas.ColumnCount = 9
            WITH loc_oPg.grd_4c_Fichas
                .Top          = 75
                .Left         = 12
                .Width        = 933
                .Height       = 309
                .HeaderHeight = 18
                .RecordSource = "crFichaTec"
                .ReadOnly     = .F.
                .GridLines    = 1
                .DeleteMark   = .F.
                .RecordMark   = .F.
                .Visible      = .T.
                WITH .Column1
                    .Width           = 200
                    .ControlSource   = "crFichaTec.CCars"
                    .Header1.Caption = "Grupo Caracter" + CHR(237) + "sticas"
                ENDWITH
                WITH .Column2
                    .Width           = 200
                    .ControlSource   = "crFichaTec.CTits"
                    .Header1.Caption = "T" + CHR(237) + "tulo Caracter" + CHR(237) + "sticas"
                ENDWITH
                WITH .Column3
                    .Width           = 50
                    .ControlSource   = "crFichaTec.COrds"
                    .Header1.Caption = "Ordem"
                    .Text1.InputMask = "999"
                ENDWITH
                WITH .Column4
                    .Width           = 50
                    .ControlSource   = "crFichaTec.CLins"
                    .Header1.Caption = "Linhas"
                    .Text1.InputMask = "99"
                ENDWITH
                WITH .Column5
                    .Width           = 50
                    .ControlSource   = "crFichaTec.Maxs"
                    .Header1.Caption = "M" + CHR(225) + "ximo"
                ENDWITH
                WITH .Column6
                    .Width           = 50
                    .ControlSource   = "crFichaTec.Mins"
                    .Header1.Caption = "M" + CHR(237) + "nimo"
                ENDWITH
                WITH .Column7
                    .Width          = 243
                    .ControlSource  = "crFichaTec.nChkCxas"
                    .Header1.Caption = "Digita" + CHR(231) + CHR(227) + "o"
                    .Sparse         = .F.
                    .CurrentControl = "opt_4c_NChkCxas"
                    .AddObject("opt_4c_NChkCxas", "OptionGroup")
                    WITH .opt_4c_NChkCxas
                        .ButtonCount = 3
                        .Value       = 1
                        .Height      = 16
                        .Width       = 241
                        WITH .Buttons(1)
                            .Caption   = "Maiusculo"
                            .Width     = 74
                            .BackStyle = 0
                        ENDWITH
                        WITH .Buttons(2)
                            .Caption   = "Minusculo"
                            .Left      = 80
                            .Width     = 74
                            .BackStyle = 0
                        ENDWITH
                        WITH .Buttons(3)
                            .Caption   = "Livre"
                            .Left      = 160
                            .BackStyle = 0
                        ENDWITH
                    ENDWITH
                ENDWITH
                WITH .Column8
                    .Width           = 25
                    .ControlSource   = "crFichaTec.cSelecaos"
                    .Header1.Caption = "S"
                ENDWITH
                WITH .Column9
                    .Width           = 25
                    .ControlSource   = "crFichaTec.cTpDados"
                    .Header1.Caption = "T"
                ENDWITH
            ENDWITH

            loc_oPg.AddObject("cmd_4c_ApagarLinha", "CommandButton")
            WITH loc_oPg.cmd_4c_ApagarLinha
                .Top     = 235
                .Left    = 949
                .Width   = 40
                .Height  = 40
                .Caption = ""
                .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .Themes  = .T.
                .Visible = .F.
            ENDWITH

            loc_oPg.AddObject("cmd_4c_Respostas", "CommandButton")
            WITH loc_oPg.cmd_4c_Respostas
                .Top     = 194
                .Left    = 949
                .Width   = 40
                .Height  = 40
                .Caption = ""
                .Picture = gc_4c_CaminhoIcones + "geral_selecionar_26.jpg"
                .Themes  = .T.
                .Visible = (THIS.this_nTipo = 0)
            ENDWITH

            loc_oPg.AddObject("cmd_4c_CopiaFicha", "CommandButton")
            WITH loc_oPg.cmd_4c_CopiaFicha
                .Top     = 392
                .Left    = 29
                .Width   = 40
                .Height  = 40
                .Caption = ""
                .Picture = gc_4c_CaminhoIcones + "geral_subnivel_26.jpg"
                .Themes  = .T.
                .Visible = .F.
            ENDWITH

            loc_oPg.AddObject("cnt_4c_CopiarAcesso", "Container")
            WITH loc_oPg.cnt_4c_CopiarAcesso
                .Top       = 389
                .Left      = 8
                .Width     = 409
                .Height    = 58
                .BackStyle = 0
                .Visible   = .F.
                .AddObject("lbl_4c_CpyGrupo", "Label")
                WITH .lbl_4c_CpyGrupo
                    .Top      = 7
                    .Left     = 34
                    .Width    = 40
                    .Height   = 18
                    .AutoSize = .F.
                    .Caption  = "Grupo :"
                    .Visible  = .T.
                ENDWITH
                .AddObject("lbl_4c_CpySubgrupo", "Label")
                WITH .lbl_4c_CpySubgrupo
                    .Top      = 32
                    .Left     = 17
                    .Width    = 60
                    .Height   = 18
                    .AutoSize = .F.
                    .Caption  = "Sub-grupo :"
                    .Visible  = (THIS.this_nTipo = 0)
                ENDWITH
                .AddObject("txt_4c_CpyCGrus", "TextBox")
                WITH .txt_4c_CpyCGrus
                    .Top     = 5
                    .Left    = 76
                    .Width   = 80
                    .Height  = 20
                    .Visible = .T.
                ENDWITH
                .AddObject("txt_4c_CpyDGrus", "TextBox")
                WITH .txt_4c_CpyDGrus
                    .Top     = 5
                    .Left    = 158
                    .Width   = 150
                    .Height  = 20
                    .Enabled = .F.
                    .Visible = .T.
                ENDWITH
                .AddObject("txt_4c_CpySGrus", "TextBox")
                WITH .txt_4c_CpySGrus
                    .Top     = 30
                    .Left    = 76
                    .Width   = 80
                    .Height  = 20
                    .Visible = (THIS.this_nTipo = 0)
                ENDWITH
                .AddObject("txt_4c_CpyDSGru", "TextBox")
                WITH .txt_4c_CpyDSGru
                    .Top     = 30
                    .Left    = 158
                    .Width   = 150
                    .Height  = 20
                    .Enabled = .F.
                    .Visible = (THIS.this_nTipo = 0)
                ENDWITH
                .AddObject("cmd_4c_ConfirmarCopia", "CommandButton")
                WITH .cmd_4c_ConfirmarCopia
                    .Top     = 10
                    .Left    = 316
                    .Width   = 40
                    .Height  = 40
                    .Caption = ""
                    .Picture = gc_4c_CaminhoIcones + "geral_duplicar_26.jpg"
                    .Themes  = .T.
                    .Visible = .T.
                ENDWITH
                .AddObject("cmd_4c_CancelarCopia", "CommandButton")
                WITH .cmd_4c_CancelarCopia
                    .Top     = 10
                    .Left    = 356
                    .Width   = 40
                    .Height  = 40
                    .Caption = ""
                    .Picture = gc_4c_CaminhoIcones + "cadastro_sair_32.jpg"
                    .Themes  = .T.
                    .Visible = .T.
                ENDWITH
            ENDWITH

            BINDEVENT(loc_oPg.grd_4c_Fichas.Column1.Text1, "Valid",    THIS, "ValidCCarsGrid")
            BINDEVENT(loc_oPg.grd_4c_Fichas.Column2.Text1, "Valid",    THIS, "ValidCTitsGrid")
            BINDEVENT(loc_oPg.grd_4c_Fichas.Column9.Text1, "KeyPress", THIS, "KeyPressCTpDados")
            BINDEVENT(loc_oPg.cmd_4c_ApagarLinha,  "Click", THIS, "BtnApagarLinhaClick")
            BINDEVENT(loc_oPg.cmd_4c_Respostas,    "Click", THIS, "BtnRespostasClick")
            BINDEVENT(loc_oPg.cmd_4c_CopiaFicha,   "Click", THIS, "BtnCopiaFichaClick")
            BINDEVENT(loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyCGrus,      "KeyPress", THIS, "ValidCpyCGrus")
            BINDEVENT(loc_oPg.cnt_4c_CopiarAcesso.cmd_4c_ConfirmarCopia, "Click", THIS, "BtnConfirmarCopiaClick")
            BINDEVENT(loc_oPg.cnt_4c_CopiarAcesso.cmd_4c_CancelarCopia,  "Click", THIS, "BtnCancelarCopiaClick")
            BINDEVENT(loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpySGrus,      "KeyPress", THIS, "ValidCpySGrus")
            BINDEVENT(loc_oPg.grd_4c_Fichas.Column8.Text1, "Valid", THIS, "ValidCSelecaos")
            BINDEVENT(loc_oPg.grd_4c_Fichas.Column9.Text1, "Valid", THIS, "ValidCTpDados")

            THIS.TornarControlesVisiveis(loc_oPg)
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em ConfigurarPgFicha:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPgCompl()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_oPg
        loc_lResultado = .F.
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page2

            loc_oPg.AddObject("lbl_4c_LabelImagem", "Label")
            WITH loc_oPg.lbl_4c_LabelImagem
                .Top      = 63
                .Left     = 328
                .Width    = 200
                .Height   = 18
                .AutoSize = .F.
                .Caption  = "Imagem da Impress" + CHR(227) + "o :"
                .Visible  = (THIS.this_nTipo = 0)
            ENDWITH

            loc_oPg.AddObject("opt_4c_NChkImps", "OptionGroup")
            WITH loc_oPg.opt_4c_NChkImps
                .Top           = 58
                .Left          = 442
                .Width         = 165
                .Height        = 16
                .ButtonCount   = 2
                .Value         = 1
                .ControlSource = "crFichaCab.nChkImps"
                .Visible       = (THIS.this_nTipo = 0)
                WITH .Buttons(1)
                    .Caption   = "Produtos"
                    .Width     = 70
                    .BackStyle = 0
                ENDWITH
                WITH .Buttons(2)
                    .Caption   = "Ficha T" + CHR(233) + "cnica"
                    .Left      = 75
                    .Width     = 90
                    .BackStyle = 0
                ENDWITH
            ENDWITH

            loc_oPg.AddObject("chk_4c_NFixFigs", "CheckBox")
            WITH loc_oPg.chk_4c_NFixFigs
                .Top           = 50
                .Left          = 617
                .Width         = 40
                .Height        = 40
                .Style         = 1
                .Caption       = ""
                .Picture       = gc_4c_CaminhoIcones + "geral_lock_on_34.jpg"
                .ControlSource = "crFichaCab.nFixFigs"
                .Themes        = .T.
                .Visible       = (THIS.this_nTipo = 0)
            ENDWITH

            loc_oPg.AddObject("img_4c_FigTec", "Image")
            WITH loc_oPg.img_4c_FigTec
                .Top     = 94
                .Left    = 301
                .Width   = 334
                .Height  = 228
                .Stretch = 1
                .Visible = .F.
            ENDWITH

            loc_oPg.AddObject("cmd_4c_Figura", "CommandButton")
            WITH loc_oPg.cmd_4c_Figura
                .Top     = 326
                .Left    = 592
                .Width   = 40
                .Height  = 40
                .Caption = ""
                .Picture = gc_4c_CaminhoIcones + "geral_picture_26.jpg"
                .Themes  = .T.
                .Visible = .F.
            ENDWITH

            loc_oPg.AddObject("cmd_4c_VoltarFicha", "CommandButton")
            WITH loc_oPg.cmd_4c_VoltarFicha
                .Top     = 326
                .Left    = 634
                .Width   = 40
                .Height  = 40
                .Caption = ""
                .Picture = gc_4c_CaminhoIcones + "a_arrow1.bmp"
                .Themes  = .T.
                .Visible = .T.
            ENDWITH

            BINDEVENT(loc_oPg.cmd_4c_Figura,      "Click", THIS, "BtnFiguraClick")
            BINDEVENT(loc_oPg.cmd_4c_VoltarFicha, "Click", THIS, "BtnVoltarFichaClick")

            THIS.TornarControlesVisiveis(loc_oPg)
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em ConfigurarPgCompl:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            THIS.this_oBusinessObject.Buscar("")
            IF USED("crDados")
                THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar lista:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE IrParaLista()
    *--------------------------------------------------------------------------
        THIS.this_cModoAtual = "LISTA"
        THIS.pgf_4c_Paginas.Visible = .T.
        THIS.pgf_4c_Paginas.ActivePage = 1
        IF USED("crDados")
            THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF par_nPagina = 1
                THIS.IrParaLista()
                loc_lResultado = .T.
            ELSE
                IF par_nPagina = 2
                THIS.pgf_4c_Paginas.ActivePage = 2
                loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em AlternarPagina:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDados()
    *--------------------------------------------------------------------------
    LPARAMETERS par_cModo
        LOCAL loc_lResultado, loc_cCGrus, loc_cSGrus, loc_cDGrus, loc_cDSGru
        LOCAL loc_lReadOnly, loc_oPg, loc_oPg2, loc_cArqTemp, loc_cExt
        loc_lResultado = .F.
        TRY
            IF !USED("crDados") OR RECCOUNT("crDados") = 0
                MsgAviso("Selecione um registro na lista.", "Aviso")
            ELSE
                SELECT crDados
                IF EOF()
                    MsgAviso("Selecione um registro na lista.", "Aviso")
                ELSE
                    loc_cCGrus = ALLTRIM(crDados.CGrus)
                    loc_cSGrus = ALLTRIM(crDados.SGrus)
                    loc_cDGrus = ALLTRIM(crDados.DGrus)
                    loc_cDSGru = ALLTRIM(crDados.DSGru)

            THIS.this_cModoAtual = par_cModo
            THIS.this_oBusinessObject.CarregarFicha(loc_cCGrus, loc_cSGrus, ;
                loc_cDGrus, loc_cDSGru, par_cModo)

            IF par_cModo = "ALTERAR"
                THIS.this_oBusinessObject.CarregarFiltroGrupos()
            ENDIF

            loc_lReadOnly = (par_cModo = "VISUALIZAR" OR par_cModo = "EXCLUIR")
            THIS.HabilitarCampos(!loc_lReadOnly)
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
            loc_oPg.grd_4c_Fichas.ReadOnly     = loc_lReadOnly
            loc_oPg.cmd_4c_ApagarLinha.Visible  = (par_cModo = "ALTERAR")
            loc_oPg.cmd_4c_CopiaFicha.Visible   = (par_cModo = "ALTERAR")
            loc_oPg.cnt_4c_CopiarAcesso.Visible = .F.

            loc_oPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page2
            loc_oPg2.cmd_4c_Figura.Visible = (par_cModo = "ALTERAR")

            IF USED("crFichaCab") AND !EOF("crFichaCab")
                IF !EMPTY(crFichaCab.mFicTecs)
                    loc_cArqTemp = SYS(2023) + "\FigTec_" + SYS(3) + ".jpg"
                    STRTOFILE(crFichaCab.mFicTecs, loc_cArqTemp)
                    IF FILE(loc_cArqTemp)
                        loc_oPg2.img_4c_FigTec.Picture = loc_cArqTemp
                        loc_oPg2.img_4c_FigTec.Visible = .T.
                    ELSE
                        loc_oPg2.img_4c_FigTec.Visible = .F.
                    ENDIF
                ELSE
                    loc_oPg2.img_4c_FigTec.Picture = ""
                    loc_oPg2.img_4c_FigTec.Visible = .F.
                ENDIF
            ENDIF

                THIS.pgf_4c_Paginas.ActivePage = 2
                THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.ActivePage = 1
                loc_oPg.grd_4c_Fichas.Refresh()
                loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar dados:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF !USED("crDados") OR RECCOUNT("crDados") = 0
                MsgAviso("Selecione um grupo na lista.", "Aviso")
            ELSE
                SELECT crDados
                IF EOF()
                    MsgAviso("Selecione um grupo na lista.", "Aviso")
                ELSE
                    IF !EMPTY(ALLTRIM(crDados.TemDados))
                    MsgAviso("Este grupo j" + CHR(225) + " possui ficha t" + CHR(233) + ;
                        "cnica. Use Alterar para modificar.", "Aviso")
                ELSE
                    loc_lResultado = THIS.CarregarDados("ALTERAR")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao incluir ficha:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
    *--------------------------------------------------------------------------
        THIS.CarregarDados("VISUALIZAR")
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
    *--------------------------------------------------------------------------
        THIS.CarregarDados("ALTERAR")
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
    *--------------------------------------------------------------------------
        THIS.CarregarDados("EXCLUIR")
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cBusca
        loc_lResultado = .F.
        TRY
            loc_cBusca = INPUTBOX("Descri" + CHR(231) + CHR(227) + "o:", "Buscar", "")
            THIS.this_oBusinessObject.Buscar(loc_cBusca)
            IF USED("crDados")
                THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
    *--------------------------------------------------------------------------
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarClick()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            DO CASE
            CASE THIS.this_cModoAtual = "VISUALIZAR"
                THIS.IrParaLista()
                loc_lResultado = .T.

            CASE THIS.this_cModoAtual = "ALTERAR"
                IF THIS.this_oBusinessObject.ValidarFichaTec()
                    IF THIS.this_oBusinessObject.AtualizarGrupoFicha("ALTERAR")
                        THIS.CarregarLista()
                        THIS.IrParaLista()
                        loc_lResultado = .T.
                    ENDIF
                ENDIF

            CASE THIS.this_cModoAtual = "EXCLUIR"
                IF THIS.this_oBusinessObject.VerificarExcluirFicha()
                    IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da ficha t" + ;
                            CHR(233) + "cnica?", "Confirmar")
                        IF THIS.this_oBusinessObject.AtualizarGrupoFicha("EXCLUIR")
                            THIS.CarregarLista()
                            THIS.IrParaLista()
                            loc_lResultado = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDCASE
        CATCH TO loc_oErro
            MsgErro("Erro ao confirmar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
    *--------------------------------------------------------------------------
        THIS.IrParaLista()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnApagarLinhaClick()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED("crFichaTec")
                SELECT crFichaTec
                IF !EOF() AND RECCOUNT() > 0
                    IF MsgConfirma("Apagar esta linha da ficha t" + CHR(233) + "cnica?", "Confirmar")
                        DELETE
                        PACK
                        SELECT crFichaTec
                        GO TOP
                        IF EOF()
                            THIS.this_oBusinessObject.AdicionarLinhaFicha()
                            SELECT crFichaTec
                            GO TOP
                        ENDIF
                        THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1.grd_4c_Fichas.Refresh()
                        loc_lResultado = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao apagar linha:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnRespostasClick()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cFormFte, loc_cCCars, loc_cCTits, loc_cCGrus, loc_cSGrus
        loc_lResultado = .F.
        TRY
            loc_cFormFte = gc_4c_CaminhoForms + "cadastros\FormFte.prg"
            IF !FILE(loc_cFormFte)
                MsgAviso("Formul" + CHR(225) + "rio de respostas n" + CHR(227) + ;
                    "o dispon" + CHR(237) + "vel.", "Aviso")
            ELSE
                IF USED("crFichaTec")
                    SELECT crFichaTec
                    IF !EOF()
                        loc_cCCars = ALLTRIM(crFichaTec.CCars)
                        loc_cCTits = ALLTRIM(crFichaTec.CTits)
                        IF EMPTY(loc_cCCars)
                            MsgAviso("Selecione uma caracter" + CHR(237) + "stica na grade.", "Aviso")
                        ELSE
                            SELECT crFichaCab
                            loc_cCGrus = ALLTRIM(crFichaCab.CGrus)
                            loc_cSGrus = ALLTRIM(crFichaCab.SGrus)
                            DO FORM (gc_4c_CaminhoForms + "cadastros\FormFte") ;
                                WITH loc_cCGrus, loc_cSGrus, loc_cCCars, loc_cCTits
                            loc_lResultado = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao abrir respostas:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnCopiaFichaClick()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_oPg
        loc_lResultado = .F.
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
            IF loc_oPg.cnt_4c_CopiarAcesso.Visible
                loc_oPg.cnt_4c_CopiarAcesso.Visible = .F.
            ELSE
                loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyCGrus.Value = ""
                loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyDGrus.Value = ""
                loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpySGrus.Value = ""
                loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyDSGru.Value = ""
                loc_oPg.cnt_4c_CopiarAcesso.Visible = .T.
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao alternar c" + CHR(243) + "pia:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarCopiaClick()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_oPg, loc_cCGrusSrc, loc_cSGrusSrc
        LOCAL loc_cSql, loc_nSql
        loc_lResultado = .F.
        TRY
            loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
            loc_cCGrusSrc = ALLTRIM(loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyCGrus.Value)
            loc_cSGrusSrc = ALLTRIM(loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpySGrus.Value)
            IF EMPTY(loc_cCGrusSrc)
                MsgAviso("Informe o grupo de origem.", "Aviso")
            ELSE
                loc_cSql = "SELECT CCars, CTits, COrds, CLins, Maxs, Mins, " + ;
                           "nChkCxas, cSelecaos, cTpDados " + ;
                           "FROM SigCdFtc WHERE CGrus = " + EscaparSQL(loc_cCGrusSrc)
                IF THIS.this_nTipo = 0 AND !EMPTY(loc_cSGrusSrc)
                    loc_cSql = loc_cSql + " AND SGrus = " + EscaparSQL(loc_cSGrusSrc)
                ENDIF
                loc_cSql = loc_cSql + " ORDER BY COrds"

                IF USED("cursor_4c_CopiaFtc")
                    USE IN cursor_4c_CopiaFtc
                ENDIF
                loc_nSql = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_CopiaFtc")
                IF loc_nSql <= 0
                    MsgErro("Erro ao buscar ficha de origem.", "Erro")
                ELSE
                    IF RECCOUNT("cursor_4c_CopiaFtc") = 0
                        USE IN cursor_4c_CopiaFtc
                        MsgAviso("Grupo de origem n" + CHR(227) + "o possui ficha t" + ;
                            CHR(233) + "cnica.", "Aviso")
                    ELSE
                        SELECT crFichaTec
                        ZAP
                        SELECT cursor_4c_CopiaFtc
                        SCAN
                            SELECT crFichaTec
                            APPEND BLANK
                            REPLACE crFichaTec.CCars     WITH ALLTRIM(cursor_4c_CopiaFtc.CCars)
                            REPLACE crFichaTec.CTits     WITH ALLTRIM(cursor_4c_CopiaFtc.CTits)
                            REPLACE crFichaTec.COrds     WITH cursor_4c_CopiaFtc.COrds
                            REPLACE crFichaTec.CLins     WITH cursor_4c_CopiaFtc.CLins
                            REPLACE crFichaTec.Maxs      WITH cursor_4c_CopiaFtc.Maxs
                            REPLACE crFichaTec.Mins      WITH cursor_4c_CopiaFtc.Mins
                            REPLACE crFichaTec.nChkCxas  WITH cursor_4c_CopiaFtc.nChkCxas
                            REPLACE crFichaTec.cSelecaos WITH cursor_4c_CopiaFtc.cSelecaos
                            REPLACE crFichaTec.cTpDados  WITH cursor_4c_CopiaFtc.cTpDados
                            SELECT cursor_4c_CopiaFtc
                        ENDSCAN
                        USE IN cursor_4c_CopiaFtc

                        THIS.this_oBusinessObject.AdicionarLinhaFicha()
                        loc_oPg.cnt_4c_CopiarAcesso.Visible = .F.
                        loc_oPg.grd_4c_Fichas.Refresh()
                        loc_lResultado = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao copiar ficha:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarCopiaClick()
    *--------------------------------------------------------------------------
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
        loc_oPg.cnt_4c_CopiarAcesso.Visible = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnFiguraClick()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cArqFig, loc_cConteudo, loc_cArqTemp, loc_cExt, loc_oPg2
        loc_lResultado = .F.
        TRY
            loc_cArqFig = GETPICT("jpg,bmp", "Selecione a imagem da ficha t" + CHR(233) + "cnica")
            IF !EMPTY(loc_cArqFig) AND FILE(loc_cArqFig)
                loc_cConteudo = FILETOSTR(loc_cArqFig)
                IF USED("crFichaCab")
                    SELECT crFichaCab
                    REPLACE crFichaCab.mFicTecs WITH loc_cConteudo
                ENDIF
                loc_cExt     = LOWER(JUSTEXT(loc_cArqFig))
                loc_cArqTemp = SYS(2023) + "\FigTec_" + SYS(3) + "." + loc_cExt
                STRTOFILE(loc_cConteudo, loc_cArqTemp)
                IF FILE(loc_cArqTemp)
                    loc_oPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page2
                    loc_oPg2.img_4c_FigTec.Picture = loc_cArqTemp
                    loc_oPg2.img_4c_FigTec.Visible = .T.
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar figura:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnVoltarFichaClick()
    *--------------------------------------------------------------------------
        THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ValidCCarsGrid()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cCCars, loc_nSql, loc_oForm
        loc_lResultado = .T.
        TRY
            IF USED("crFichaTec")
                SELECT crFichaTec
                IF !EOF()
                    loc_cCCars = ALLTRIM(crFichaTec.CCars)
                    IF !EMPTY(loc_cCCars)
                        IF USED("cursor_4c_BuscaCCars")
                            USE IN cursor_4c_BuscaCCars
                        ENDIF
                        loc_nSql = SQLEXEC(gnConnHandle, ;
                            "SELECT CCars, DCars FROM SigCrRaP WHERE CCars = " + EscaparSQL(loc_cCCars), ;
                            "cursor_4c_BuscaCCars")
                        IF loc_nSql > 0 AND RECCOUNT("cursor_4c_BuscaCCars") > 0
                            USE IN cursor_4c_BuscaCCars
                        ELSE
                            IF USED("cursor_4c_BuscaCCars")
                                USE IN cursor_4c_BuscaCCars
                            ENDIF
                            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                                "SigCrRaP", "cursor_4c_BuscaCCars", "CCars", loc_cCCars, ;
                                "Caracter" + CHR(237) + "sticas")
                            IF !ISNULL(loc_oForm)
                                IF !loc_oForm.this_lAchouRegistro
                                    loc_oForm.mAddColuna("CCars", "", "C" + CHR(243) + "digo")
                                    loc_oForm.mAddColuna("DCars", "", "Descri" + CHR(231) + CHR(227) + "o")
                                    loc_oForm.Show()
                                ENDIF
                                IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaCCars")
                                    SELECT crFichaTec
                                    REPLACE crFichaTec.CCars WITH ALLTRIM(cursor_4c_BuscaCCars.CCars)
                                    USE IN cursor_4c_BuscaCCars
                                ELSE
                                    SELECT crFichaTec
                                    REPLACE crFichaTec.CCars WITH ""
                                    IF USED("cursor_4c_BuscaCCars")
                                        USE IN cursor_4c_BuscaCCars
                                    ENDIF
                                ENDIF
                                loc_oForm.Release()
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ValidCCarsGrid:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ValidCTitsGrid()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cCTits, loc_nSql, loc_oForm
        loc_lResultado = .T.
        TRY
            IF USED("crFichaTec")
                SELECT crFichaTec
                IF !EOF()
                    loc_cCTits = ALLTRIM(crFichaTec.CTits)
                    IF !EMPTY(loc_cCTits)
                        IF USED("cursor_4c_BuscaCTits")
                            USE IN cursor_4c_BuscaCTits
                        ENDIF
                        loc_nSql = SQLEXEC(gnConnHandle, ;
                            "SELECT CTits, DTits FROM SigPrCpP WHERE CTits = " + EscaparSQL(loc_cCTits), ;
                            "cursor_4c_BuscaCTits")
                        IF loc_nSql > 0 AND RECCOUNT("cursor_4c_BuscaCTits") > 0
                            USE IN cursor_4c_BuscaCTits
                        ELSE
                            IF USED("cursor_4c_BuscaCTits")
                                USE IN cursor_4c_BuscaCTits
                            ENDIF
                            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                                "SigPrCpP", "cursor_4c_BuscaCTits", "CTits", loc_cCTits, ;
                                "T" + CHR(237) + "tulos")
                            IF !ISNULL(loc_oForm)
                                IF !loc_oForm.this_lAchouRegistro
                                    loc_oForm.mAddColuna("CTits", "", "C" + CHR(243) + "digo")
                                    loc_oForm.mAddColuna("DTits", "", "Descri" + CHR(231) + CHR(227) + "o")
                                    loc_oForm.Show()
                                ENDIF
                                IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaCTits")
                                    SELECT crFichaTec
                                    REPLACE crFichaTec.CTits WITH ALLTRIM(cursor_4c_BuscaCTits.CTits)
                                    USE IN cursor_4c_BuscaCTits
                                ELSE
                                    SELECT crFichaTec
                                    REPLACE crFichaTec.CTits WITH ""
                                    IF USED("cursor_4c_BuscaCTits")
                                        USE IN cursor_4c_BuscaCTits
                                    ENDIF
                                ENDIF
                                loc_oForm.Release()
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ValidCTitsGrid:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE KeyPressCTpDados(par_nKeyCode, par_nShiftAltCtrl)
    *--------------------------------------------------------------------------
    LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF par_nKeyCode = 13 AND THIS.this_cModoAtual = "ALTERAR"
                IF USED("crFichaTec")
                    SELECT crFichaTec
                    IF !EOF() AND RECNO() = RECCOUNT()
                        THIS.this_oBusinessObject.AdicionarLinhaFicha()
                        THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1.grd_4c_Fichas.Refresh()
                    ENDIF
                ENDIF
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em KeyPressCTpDados:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ValidCpyCGrus(par_nKeyCode, par_nShiftAltCtrl)
    *--------------------------------------------------------------------------
    LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
    IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
        RETURN
    ENDIF
        LOCAL loc_lResultado, loc_oPg, loc_cCGrus, loc_cTabela, loc_oForm, loc_lEncontrado
        loc_lResultado  = .T.
        loc_lEncontrado = .F.
        TRY
            loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
            loc_cCGrus = ALLTRIM(loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyCGrus.Value)
            IF EMPTY(loc_cCGrus)
                loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyDGrus.Value = ""
                loc_lEncontrado = .T.
            ELSE
                IF USED("crSigCdGrpFilter")
                    SELECT crSigCdGrpFilter
                    LOCATE FOR ALLTRIM(crSigCdGrpFilter.CGrus) = loc_cCGrus
                    IF !EOF()
                        loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyDGrus.Value = ALLTRIM(crSigCdGrpFilter.DGrus)
                        loc_lEncontrado = .T.
                    ENDIF
                ENDIF
            ENDIF
            IF !loc_lEncontrado
                DO CASE
                CASE THIS.this_nTipo = 1
                    loc_cTabela = "SigCdGcr"
                CASE THIS.this_nTipo = 2
                    loc_cTabela = "SigCdOpe"
                OTHERWISE
                    loc_cTabela = "SigCdGrp"
                ENDCASE

                IF USED("cursor_4c_BuscaGrp")
                    USE IN cursor_4c_BuscaGrp
                ENDIF
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    loc_cTabela, "cursor_4c_BuscaGrp", "CGrus", loc_cCGrus, "Grupos")
                IF !ISNULL(loc_oForm)
                    IF !loc_oForm.this_lAchouRegistro
                        loc_oForm.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
                        loc_oForm.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oForm.Show()
                    ENDIF
                    IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
                        loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyCGrus.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
                        loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyDGrus.Value = ALLTRIM(cursor_4c_BuscaGrp.DGrus)
                        USE IN cursor_4c_BuscaGrp
                    ELSE
                        loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyCGrus.Value = ""
                        loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyDGrus.Value = ""
                        IF USED("cursor_4c_BuscaGrp")
                            USE IN cursor_4c_BuscaGrp
                        ENDIF
                    ENDIF
                    loc_oForm.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ValidCpyCGrus:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ValidCpySGrus(par_nKeyCode, par_nShiftAltCtrl)
    *--------------------------------------------------------------------------
    LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
    IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
        RETURN
    ENDIF
        LOCAL loc_lResultado, loc_oPg, loc_cSGrus, loc_cCGrus, loc_oForm, loc_nSql
        loc_lResultado = .T.
        TRY
            loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
            loc_cCGrus = ALLTRIM(loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyCGrus.Value)
            loc_cSGrus = ALLTRIM(loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpySGrus.Value)
            IF EMPTY(loc_cSGrus)
                loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyDSGru.Value = ""
            ELSE
                IF USED("cursor_4c_BuscaSGrp")
                    USE IN cursor_4c_BuscaSGrp
                ENDIF
                loc_nSql = SQLEXEC(gnConnHandle, ;
                    "SELECT Codigos, Descricaos FROM SigCdPsg" + ;
                    " WHERE CGrus = " + EscaparSQL(loc_cCGrus) + ;
                    " AND Codigos = " + EscaparSQL(loc_cSGrus), ;
                    "cursor_4c_BuscaSGrp")
                IF loc_nSql > 0 AND RECCOUNT("cursor_4c_BuscaSGrp") > 0
                    SELECT cursor_4c_BuscaSGrp
                    loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpySGrus.Value = ALLTRIM(cursor_4c_BuscaSGrp.Codigos)
                    loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyDSGru.Value = ALLTRIM(cursor_4c_BuscaSGrp.Descricaos)
                    USE IN cursor_4c_BuscaSGrp
                ELSE
                    IF USED("cursor_4c_BuscaSGrp")
                        USE IN cursor_4c_BuscaSGrp
                    ENDIF
                    loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                        "SigCdPsg", "cursor_4c_BuscaSGrp", "Codigos", loc_cSGrus, ;
                        "Sub-grupos")
                    IF VARTYPE(loc_oForm) = "O"
                        IF !loc_oForm.this_lAchouRegistro
                            loc_oForm.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
                            loc_oForm.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                            loc_oForm.Show()
                        ENDIF
                        IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaSGrp")
                            SELECT cursor_4c_BuscaSGrp
                            loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpySGrus.Value = ALLTRIM(cursor_4c_BuscaSGrp.Codigos)
                            loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyDSGru.Value = ALLTRIM(cursor_4c_BuscaSGrp.Descricaos)
                            USE IN cursor_4c_BuscaSGrp
                        ELSE
                            loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpySGrus.Value = ""
                            loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyDSGru.Value = ""
                            IF USED("cursor_4c_BuscaSGrp")
                                USE IN cursor_4c_BuscaSGrp
                            ENDIF
                        ENDIF
                        loc_oForm.Release()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ValidCpySGrus:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ValidCSelecaos()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cValor
        loc_lResultado = .T.
        TRY
            IF USED("crFichaTec")
                SELECT crFichaTec
                IF !EOF()
                    loc_cValor = ALLTRIM(crFichaTec.cSelecaos)
                    IF !EMPTY(loc_cValor) AND !INLIST(loc_cValor, "S", "N")
                        MsgAviso("Tipos de Sele" + CHR(231) + CHR(227) + "o v" + CHR(225) + ;
                            "lidos: S ou N !", "Aten" + CHR(231) + CHR(227) + "o")
                        REPLACE crFichaTec.cSelecaos WITH " "
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ValidCSelecaos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ValidCTpDados()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cValor
        loc_lResultado = .T.
        TRY
            IF USED("crFichaTec")
                SELECT crFichaTec
                IF !EOF()
                    loc_cValor = ALLTRIM(crFichaTec.cTpDados)
                    IF !EMPTY(loc_cValor) AND !INLIST(loc_cValor, "C", "D", "N")
                        MsgAviso("Tipo de dado inv" + CHR(225) + "lido." + CHR(13) + ;
                            "Usar: C - Caracter, D - Data, N - Num" + CHR(233) + "rico !", ;
                            "Aten" + CHR(231) + CHR(227) + "o")
                        REPLACE crFichaTec.cTpDados WITH " "
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ValidCTpDados:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
    *--------------------------------------------------------------------------
        LOCAL loc_oPg, loc_oPg2
        TRY
            loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page2
            IF PEMSTATUS(loc_oPg, "opt_4c_NChkDims", 5) AND THIS.this_nTipo = 0
                loc_oPg.opt_4c_NChkDims.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg, "opt_4c_NChkTems", 5) AND THIS.this_nTipo = 0
                loc_oPg.opt_4c_NChkTems.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg, "opt_4c_NChkPess", 5) AND THIS.this_nTipo = 0
                loc_oPg.opt_4c_NChkPess.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "opt_4c_NChkImps", 5) AND THIS.this_nTipo = 0
                loc_oPg2.opt_4c_NChkImps.Enabled = par_lHabilitar
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_NFixFigs", 5) AND THIS.this_nTipo = 0
                loc_oPg2.chk_4c_NFixFigs.Enabled = par_lHabilitar
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em HabilitarCampos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
    *--------------------------------------------------------------------------
        LOCAL loc_nI, loc_oCtrl, loc_cNome, loc_nP
        IF ISNULL(par_oContainer) OR !ISOBJECT(par_oContainer)
            RETURN
        ENDIF
        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oCtrl = par_oContainer.Controls(loc_nI)
            loc_cNome = UPPER(ALLTRIM(loc_oCtrl.Name))
            *-- Paineis flutuantes: preservar Visible=.F. mas processar filhos internos
            IF INLIST(loc_cNome, "CNT_4C_CABECALHO", "CNT_4C_COPIARACESSO", ;
                    "CMD_4C_APAGARLINHA", "CMD_4C_COPIAFICHA", ;
                    "IMG_4C_FIGTEC", "CMD_4C_FIGURA")
                IF PEMSTATUS(loc_oCtrl, "PageCount", 5)
                    FOR loc_nP = 1 TO loc_oCtrl.PageCount
                        THIS.TornarControlesVisiveis(loc_oCtrl.Pages(loc_nP))
                    ENDFOR
                ELSE
                    IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oCtrl)
                    ENDIF
                ENDIF
                LOOP
            ENDIF
            loc_oCtrl.Visible = .T.
            IF PEMSTATUS(loc_oCtrl, "PageCount", 5)
                FOR loc_nP = 1 TO loc_oCtrl.PageCount
                    THIS.TornarControlesVisiveis(loc_oCtrl.Pages(loc_nP))
                ENDFOR
            ELSE
                IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oCtrl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Consolida dados dos controles bound ao BO/cursor
    *   Os TextBox/OptionGroup/CheckBox estao com ControlSource direto para
    *   crFichaCab/crFichaTec (padrao SCX legado). Este metodo garante que
    *   o registro corrente esteja gravado no cursor antes de operacoes.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            *-- ControlSource faz binding bidirecional automatico: qualquer
            *-- alteracao na tela ja esta gravada no cursor. Aqui garantimos
            *-- apenas que os cursores estao posicionados corretamente para
            *-- que o BO acesse o registro correto no Salvar/Excluir.
            IF USED("crFichaCab")
                SELECT crFichaCab
                IF !EOF() AND !BOF()
                    GO RECNO()
                ENDIF
            ENDIF
            IF USED("crFichaTec")
                SELECT crFichaTec
                IF !EOF() AND !BOF()
                    GO RECNO()
                ENDIF
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em FormParaBO:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Atualiza controles da tela com dados dos cursores do BO
    *   Refresh dos containers/grids que exibem crFichaCab e crFichaTec.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_lResultado, loc_oPg, loc_oPg2
        loc_lResultado = .F.
        TRY
            loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page2

            IF USED("crFichaTec")
                SELECT crFichaTec
                GO TOP
                loc_oPg.grd_4c_Fichas.Refresh()
            ENDIF

            *-- Refresh dos OptionGroups bound (nChkDims/nChkTems/nChkPess/nChkImps)
            IF PEMSTATUS(loc_oPg, "opt_4c_NChkDims", 5)
                loc_oPg.opt_4c_NChkDims.Refresh()
            ENDIF
            IF PEMSTATUS(loc_oPg, "opt_4c_NChkTems", 5)
                loc_oPg.opt_4c_NChkTems.Refresh()
            ENDIF
            IF PEMSTATUS(loc_oPg, "opt_4c_NChkPess", 5)
                loc_oPg.opt_4c_NChkPess.Refresh()
            ENDIF
            IF PEMSTATUS(loc_oPg2, "opt_4c_NChkImps", 5)
                loc_oPg2.opt_4c_NChkImps.Refresh()
            ENDIF
            IF PEMSTATUS(loc_oPg2, "chk_4c_NFixFigs", 5)
                loc_oPg2.chk_4c_NFixFigs.Refresh()
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em BOParaForm:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Zera os cursores crFichaCab / crFichaTec e reseta a UI
    *   Chamado quando cancela uma operacao ou volta para lista.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_lResultado, loc_oPg, loc_oPg2
        loc_lResultado = .F.
        TRY
            IF USED("crFichaCab")
                SELECT crFichaCab
                ZAP
            ENDIF
            IF USED("crFichaTec")
                SELECT crFichaTec
                ZAP
            ENDIF

            loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page2

            *-- Fecha painel de copia se estiver aberto
            IF PEMSTATUS(loc_oPg, "cnt_4c_CopiarAcesso", 5)
                loc_oPg.cnt_4c_CopiarAcesso.Visible = .F.
                loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyCGrus.Value = ""
                loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyDGrus.Value = ""
                loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpySGrus.Value = ""
                loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyDSGru.Value = ""
            ENDIF

            *-- Limpa a imagem da ficha tecnica
            IF PEMSTATUS(loc_oPg2, "img_4c_FigTec", 5)
                loc_oPg2.img_4c_FigTec.Picture = ""
                loc_oPg2.img_4c_FigTec.Visible = .F.
            ENDIF

            *-- Refresh dos grids/controles bound
            loc_oPg.grd_4c_Fichas.Refresh()

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em LimparCampos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta visibilidade/estado dos botoes conforme
    *   o modo atual (LISTA/VISUALIZAR/ALTERAR/EXCLUIR).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo(par_cModo)
        LOCAL loc_lResultado, loc_oPg, loc_oPg2, loc_lAlterar, loc_lLeitura
        loc_lResultado = .F.
        TRY
            IF VARTYPE(par_cModo) <> "C"
                par_cModo = THIS.this_cModoAtual
            ENDIF
            loc_lAlterar = (par_cModo == "ALTERAR")
            loc_lLeitura = (par_cModo == "VISUALIZAR" OR par_cModo == "EXCLUIR")

            loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page2

            *-- Botoes de manipulacao da grade so aparecem em ALTERAR
            IF PEMSTATUS(loc_oPg, "cmd_4c_ApagarLinha", 5)
                loc_oPg.cmd_4c_ApagarLinha.Visible = loc_lAlterar
            ENDIF
            IF PEMSTATUS(loc_oPg, "cmd_4c_CopiaFicha", 5)
                loc_oPg.cmd_4c_CopiaFicha.Visible = loc_lAlterar
            ENDIF

            *-- Botao de figura na pagina complementar
            IF PEMSTATUS(loc_oPg2, "cmd_4c_Figura", 5)
                loc_oPg2.cmd_4c_Figura.Visible = loc_lAlterar
            ENDIF

            *-- Grade em modo leitura quando visualiza/exclui
            IF PEMSTATUS(loc_oPg, "grd_4c_Fichas", 5)
                loc_oPg.grd_4c_Fichas.ReadOnly = loc_lLeitura OR !loc_lAlterar
            ENDIF

            *-- Fecha painel de copia
            IF PEMSTATUS(loc_oPg, "cnt_4c_CopiarAcesso", 5)
                loc_oPg.cnt_4c_CopiarAcesso.Visible = .F.
            ENDIF

            *-- Habilita/desabilita campos de configuracao (OptionGroups + CheckBox)
            THIS.HabilitarCampos(loc_lAlterar)

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em AjustarBotoesPorModo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\FctBO.prg):
*==============================================================================
* FctBO.prg - Business Object para Cadastro de Ficha Tecnica / Perfis
* Tabela principal: SigCdFtc (linhas de ficha tecnica por CGrus+SGrus)
* Cabecalho do grupo: SigCdGrp (pnTipo=0), SigCdGcr (pnTipo=1), SigCdOpe (pnTipo=2)
*==============================================================================
DEFINE CLASS FctBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Identificacao do grupo selecionado (cabecalho da ficha tecnica)
    *--------------------------------------------------------------------------
    this_cCGrus    = ""   && Codigo do grupo (chave 1)
    this_cDGrus    = ""   && Descricao do grupo
    this_cSGrus    = ""   && Codigo do subgrupo (chave 2)
    this_cDSGru    = ""   && Descricao do subgrupo

    *--------------------------------------------------------------------------
    * Flags do cabecalho (vem de SigCdGrp quando pnTipo=0)
    * nChkDims: Dimensoes Obrigatorias (1=Sim, 2=Nao)
    * nChkPess: Peso Obrigatorio        (1=Sim, 2=Nao)
    * nChkTems: Tempo Instal Obrigatorio (1=Sim, 2=Nao)
    * nChkImps: Impressao (1=Produtos, 2=Ficha Tecnica)
    * nFixFigs: Figuras Fixas (0/1)
    *--------------------------------------------------------------------------
    this_nChkDims  = 1    && Dimensoes Obrigatorias
    this_nChkPess  = 1    && Peso Obrigatorio
    this_nChkTems  = 1    && Tempo de Instalacao Obrigatorio
    this_nChkImps  = 1    && Tipo de impressao
    this_nFixFigs  = 0    && Figuras fixas (checkbox)
    this_mFicTecs  = ""   && Imagem tecnica (memo/binario)

    *--------------------------------------------------------------------------
    * Tipo de formulario
    * 0 = Ficha Tecnica de Produtos (SigCdGrp/SigCdPsg)
    * 1 = Perfil de Contas           (SigCdGcr)
    * 2 = Configuracao de Movimentacao (SigCdOpe)
    *--------------------------------------------------------------------------
    this_nTipo     = 0    && Tipo (0=Produtos, 1=Contas, 2=Movimentacoes)

    *--------------------------------------------------------------------------
    * Controle de cursor principal do grid (SigCdFtc)
    *--------------------------------------------------------------------------
    this_cCursorDados = "crFichaTec"

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()

            IF loc_lResultado
                THIS.this_cTabela     = "SigCdFtc"
                THIS.this_cCampoChave = "cIdChaves"
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao inicializar FctBO:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        LOCAL loc_oErro
        TRY
            IF USED("crDados")
                USE IN crDados
            ENDIF
            IF USED("crFichaCab")
                USE IN crFichaCab
            ENDIF
            IF USED("crFichaTec")
                USE IN crFichaTec
            ENDIF
            IF USED("crSigCdFtc")
                USE IN crSigCdFtc
            ENDIF
            IF USED("crSigCdGrp")
                USE IN crSigCdGrp
            ENDIF
            IF USED("crSigCdGrpFilter")
                USE IN crSigCdGrpFilter
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao destruir FctBO:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        DODEFAULT()
    ENDPROC

    *==========================================================================
    * CriarCursores - Cria os cursores de trabalho necessarios
    *==========================================================================
    PROCEDURE CriarCursores()
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("crDados")
                USE IN crDados
            ENDIF
            IF USED("crFichaCab")
                USE IN crFichaCab
            ENDIF
            IF USED("crFichaTec")
                USE IN crFichaTec
            ENDIF
            IF USED("crSigCdFtc")
                USE IN crSigCdFtc
            ENDIF
            IF USED("crSigCdGrp")
                USE IN crSigCdGrp
            ENDIF

            SET NULL ON
            CREATE CURSOR crDados (CGrus C(20), DGrus C(30), SGrus C(6), DSGru C(20), TemDados C(20))
            INDEX ON CGrus + SGrus TAG Col1
            INDEX ON SGrus + CGrus TAG Col2
            INDEX ON DGrus + CGrus TAG Col3
            INDEX ON DSGru + SGrus TAG Col4
            SET ORDER TO Col1 IN crDados

            CREATE CURSOR crFichaCab (CGrus C(20), DGrus C(30), SGrus C(6), DSGru C(20), ;
                nChkDims N(1), nChkPess N(1), nChkTems N(1), nChkImps N(1), ;
                nFixFigs N(1), mFicTecs M NULL)

            CREATE CURSOR crFichaTec (CGrus C(20), SGrus C(6), CCars C(20), CTits C(20), ;
                COrds N(3), CLins N(2), Maxs N(3), Mins N(3), ;
                nChkCxas N(1), cSelecaos C(1), cTpDados C(1))

            CREATE CURSOR crSigCdGrp (CGrus C(20), DGrus C(30), Mercs C(3), ;
                Margems N(9,6), Apagar C(1))
            SET NULL OFF

            loc_lResultado = .T.

        CATCH TO loException
            MsgErro("Erro ao criar cursores:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Buscar - Carrega a lista de grupos/contas/movimentacoes na grade principal
    *==========================================================================
    FUNCTION Buscar(par_cFiltro)
    *==========================================================================
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                IF !USED("crDados")
                    SET NULL ON
                    CREATE CURSOR crDados (CGrus C(20), DGrus C(30), SGrus C(6), DSGru C(20), TemDados C(20))
                    SET NULL OFF
                ENDIF
                loc_lResultado = .T.
            ENDIF

            IF USED("crDados")
                ZAP IN crDados
            ELSE
                THIS.CriarCursores()
            ENDIF

            DO CASE
            CASE THIS.this_nTipo = 0
                loc_cSQL = "SELECT CGrus, DGrus, FTecSubs" + ;
                    " FROM SigCdGrp" + ;
                    " ORDER BY CGrus, DGrus"

            CASE THIS.this_nTipo = 1
                loc_cSQL = "SELECT Codigos, Descrs, 0 AS FTecSubs" + ;
                    " FROM SigCdGcr WHERE FichaTecs = 1" + ;
                    " ORDER BY Codigos, Descrs"

            CASE THIS.this_nTipo = 2
                loc_cSQL = "SELECT a.Dopes, a.TitOpes, 0 AS FTecSubs" + ;
                    " FROM SigCdOpe a" + ;
                    " LEFT JOIN SigOpCdc b ON a.Dopes = b.Dopes" + ;
                    " WHERE b.OpeInatvs IN (0,2)" + ;
                    " ORDER BY a.Dopes, a.TitOpes"
            ENDCASE

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crLocalGru")
            IF loc_nResult < 1
                MsgErro("Erro ao carregar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                SELECT crLocalGru
                SCAN
                    LOCAL loc_cGrupo, loc_cDescGrupo, loc_nFTecSubs
                    loc_cGrupo    = ALLTRIM(crLocalGru.CGrus)
                    loc_cDescGrupo = ""
                    loc_nFTecSubs  = 0

                    DO CASE
                    CASE THIS.this_nTipo = 0
                        loc_cDescGrupo = ALLTRIM(crLocalGru.DGrus)
                        loc_nFTecSubs  = NVL(crLocalGru.FTecSubs, 0)
                    CASE THIS.this_nTipo = 1
                        loc_cGrupo     = ALLTRIM(crLocalGru.Codigos)
                        loc_cDescGrupo = ALLTRIM(crLocalGru.Descrs)
                    CASE THIS.this_nTipo = 2
                        loc_cGrupo     = ALLTRIM(crLocalGru.Dopes)
                        loc_cDescGrupo = ALLTRIM(crLocalGru.TitOpes)
                    ENDCASE

                    INSERT INTO crDados (CGrus, DGrus, SGrus, DSGru, TemDados) ;
                        VALUES (loc_cGrupo, loc_cDescGrupo, "", "", "")

                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT DISTINCT CGrus FROM SigCdFtc" + ;
                        " WHERE CGrus = " + EscaparSQL(loc_cGrupo) + ;
                        " AND SGrus = SPACE(6) AND nTipos = " + ;
                        FormatarNumeroSQL(THIS.this_nTipo), "crTmpFtc")
                    IF loc_nResult >= 1
                        GO TOP IN crTmpFtc
                        IF !EOF("crTmpFtc")
                            SELECT crDados
                            GO BOTTOM IN crDados
                            REPLACE TemDados WITH loc_cGrupo IN crDados
                        ENDIF
                        IF USED("crTmpFtc")
                            USE IN crTmpFtc
                        ENDIF
                    ENDIF

                    IF THIS.this_nTipo = 0 AND loc_nFTecSubs = 1
                        loc_nResult = SQLEXEC(gnConnHandle, ;
                            "SELECT CGrus, Codigos, Descricaos FROM SigCdPsg" + ;
                            " WHERE CGrus = " + EscaparSQL(loc_cGrupo) + ;
                            " ORDER BY CGrus, Codigos, Descricaos", "crLocalSGru")
                        IF loc_nResult >= 1
                            SELECT crLocalSGru
                            SCAN
                                INSERT INTO crDados (CGrus, DGrus, SGrus, DSGru, TemDados) ;
                                    VALUES (loc_cGrupo, loc_cDescGrupo, ;
                                        ALLTRIM(crLocalSGru.Codigos), ;
                                        ALLTRIM(crLocalSGru.Descricaos), "")

                                loc_nResult = SQLEXEC(gnConnHandle, ;
                                    "SELECT DISTINCT CGrus, SGrus FROM SigCdFtc" + ;
                                    " WHERE CGrus = " + EscaparSQL(loc_cGrupo) + ;
                                    " AND SGrus = " + EscaparSQL(ALLTRIM(crLocalSGru.Codigos)) + ;
                                    " AND nTipos = 0", "crTmpSGru")
                                IF loc_nResult >= 1
                                    GO TOP IN crTmpSGru
                                    IF !EOF("crTmpSGru")
                                        SELECT crDados
                                        GO BOTTOM IN crDados
                                        REPLACE TemDados WITH ;
                                            loc_cGrupo + ALLTRIM(crLocalSGru.Codigos) IN crDados
                                    ENDIF
                                    IF USED("crTmpSGru")
                                        USE IN crTmpSGru
                                    ENDIF
                                ENDIF
                            ENDSCAN
                            IF USED("crLocalSGru")
                                USE IN crLocalSGru
                            ENDIF
                        ENDIF
                    ENDIF

                    SELECT crLocalGru
                ENDSCAN

                IF USED("crLocalGru")
                    USE IN crLocalGru
                ENDIF

                GO TOP IN crDados
                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao buscar grupos:" + CHR(13) + loException.Message + ;
                CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarFicha - Carrega crFichaCab e crFichaTec para um grupo/subgrupo
    * par_cCGrus  - Codigo do grupo
    * par_cSGrus  - Codigo do subgrupo (vazio para grupo raiz)
    * par_cDGrus  - Descricao do grupo
    * par_cDSGru  - Descricao do subgrupo
    * par_cModo   - "ALTERAR" / "VISUALIZAR" / "EXCLUIR"
    *==========================================================================
    FUNCTION CarregarFicha(par_cCGrus, par_cSGrus, par_cDGrus, par_cDSGru, par_cModo)
    *==========================================================================
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_nOrd
        loc_lResultado = .F.

        TRY
            IF USED("crFichaCab")
                ZAP IN crFichaCab
            ENDIF
            IF USED("crFichaTec")
                ZAP IN crFichaTec
            ENDIF

            THIS.this_cCGrus = ALLTRIM(par_cCGrus)
            THIS.this_cSGrus = ALLTRIM(par_cSGrus)
            THIS.this_cDGrus = ALLTRIM(par_cDGrus)
            THIS.this_cDSGru = ALLTRIM(par_cDSGru)

            DO CASE
            CASE THIS.this_nTipo = 0
                loc_cSQL = "SELECT a.CGrus, a.nChkDims, a.nChkPess, a.nChkTems," + ;
                    " a.nChkImps, a.nFixFigs, a.mFicTecs" + ;
                    " FROM SigCdGrp a" + ;
                    " WHERE a.CGrus = " + EscaparSQL(THIS.this_cCGrus)

            CASE THIS.this_nTipo = 1
                loc_cSQL = "SELECT a.Codigos AS CGrus, 2 AS nChkDims, 2 AS nChkPess," + ;
                    " 2 AS nChkTems, 2 AS nChkImps, 2 AS nFixFigs, '' AS mFicTecs" + ;
                    " FROM SigCdGcr a" + ;
                    " WHERE a.Codigos = " + EscaparSQL(THIS.this_cCGrus)

            CASE THIS.this_nTipo = 2
                loc_cSQL = "SELECT a.Dopes AS CGrus, 2 AS nChkDims, 2 AS nChkPess," + ;
                    " 2 AS nChkTems, 2 AS nChkImps, 2 AS nFixFigs, '' AS mFicTecs" + ;
                    " FROM SigCdOpe a" + ;
                    " WHERE a.Dopes = " + EscaparSQL(THIS.this_cCGrus)
            ENDCASE

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crLocalGruFicha")
            IF loc_nResult < 1
                MsgErro("Erro ao acessar cadastro de grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                GO TOP IN crLocalGruFicha
                IF EOF("crLocalGruFicha")
                    MsgAviso("O grupo " + CHR(34) + THIS.this_cCGrus + CHR(34) + ;
                        " n" + CHR(227) + "o foi encontrado!" + CHR(13) + ;
                        "O grupo pode ter sido exclu" + CHR(237) + "do. Reinicie a opera" + ;
                        CHR(231) + CHR(227) + "o.", "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    INSERT INTO crFichaCab (CGrus, DGrus, SGrus, DSGru, nChkDims, ;
                        nChkPess, nChkTems, nChkImps, nFixFigs, mFicTecs) ;
                        VALUES (THIS.this_cCGrus, THIS.this_cDGrus, THIS.this_cSGrus, ;
                        THIS.this_cDSGru, NVL(crLocalGruFicha.nChkDims, 1), ;
                        NVL(crLocalGruFicha.nChkPess, 1), ;
                        NVL(crLocalGruFicha.nChkTems, 1), ;
                        NVL(crLocalGruFicha.nChkImps, 1), ;
                        NVL(crLocalGruFicha.nFixFigs, 0), ;
                        NVL(crLocalGruFicha.mFicTecs, ""))

                    THIS.this_nChkDims = NVL(crLocalGruFicha.nChkDims, 1)
                    THIS.this_nChkPess = NVL(crLocalGruFicha.nChkPess, 1)
                    THIS.this_nChkTems = NVL(crLocalGruFicha.nChkTems, 1)
                    THIS.this_nChkImps = NVL(crLocalGruFicha.nChkImps, 1)
                    THIS.this_nFixFigs = NVL(crLocalGruFicha.nFixFigs, 0)
                    THIS.this_mFicTecs = NVL(crLocalGruFicha.mFicTecs, "")

                    loc_cSQL = "SELECT a.*" + ;
                        " FROM SigCdFtc a" + ;
                        " WHERE a.CGrus = " + EscaparSQL(THIS.this_cCGrus) + ;
                        " AND a.SGrus = " + EscaparSQL(THIS.this_cSGrus) + ;
                        " ORDER BY a.COrds"

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crLocalCFTec")
                    IF loc_nResult < 1
                        MsgErro("Erro ao carregar ficha t" + CHR(233) + "cnica:" + ;
                            CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ELSE
                        loc_nOrd = 1
                        SELECT crLocalCFTec
                        SCAN
                            INSERT INTO crFichaTec (COrds, CGrus, SGrus, CCars, CTits, ;
                                CLins, Maxs, Mins, nChkCxas, cSelecaos, cTpDados) ;
                                VALUES (loc_nOrd, THIS.this_cCGrus, THIS.this_cSGrus, ;
                                NVL(crLocalCFTec.CCars, ""), NVL(crLocalCFTec.CTits, ""), ;
                                NVL(crLocalCFTec.CLins, 0), NVL(crLocalCFTec.Maxs, 0), ;
                                NVL(crLocalCFTec.Mins, 0), NVL(crLocalCFTec.nChkCxas, 0), ;
                                NVL(crLocalCFTec.cSelecaos, " "), ;
                                NVL(crLocalCFTec.cTpDados, " "))
                            loc_nOrd = loc_nOrd + 1
                        ENDSCAN

                        IF USED("crLocalCFTec")
                            USE IN crLocalCFTec
                        ENDIF

                        IF ALLTRIM(par_cModo) == "ALTERAR"
                            INSERT INTO crFichaTec (COrds, CGrus, SGrus) ;
                                VALUES (loc_nOrd, THIS.this_cCGrus, THIS.this_cSGrus)
                        ENDIF

                        GO TOP IN crFichaCab
                        GO TOP IN crFichaTec
                        GO BOTTOM IN crFichaTec

                        loc_lResultado = .T.
                    ENDIF
                ENDIF

                IF USED("crLocalGruFicha")
                    USE IN crLocalGruFicha
                ENDIF
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao carregar ficha:" + CHR(13) + loException.Message + ;
                CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarFiltroGrupos - Carrega crSigCdGrpFilter para lookup no container de copia
    *==========================================================================
    FUNCTION CarregarFiltroGrupos()
    *==========================================================================
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("crSigCdGrpFilter")
                USE IN crSigCdGrpFilter
            ENDIF

            DO CASE
            CASE THIS.this_nTipo = 0
                loc_cSQL = "SELECT CGrus, DGrus, Mercs, Margems, 'S' AS Apagar" + ;
                    " FROM SigCdGrp"

            CASE THIS.this_nTipo = 1
                loc_cSQL = "SELECT Codigos AS CGrus, Descrs AS DGrus," + ;
                    " '   ' AS Mercs, 0 AS Margems, 'S' AS Apagar FROM SigCdGcr"

            CASE THIS.this_nTipo = 2
                loc_cSQL = "SELECT Dopes AS CGrus, TitOpes AS DGrus," + ;
                    " '   ' AS Mercs, 0 AS Margems, 'S' AS Apagar FROM SigCdOpe"
            ENDCASE

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdGrpFilter")
            IF loc_nResult < 1
                MsgErro("Erro ao carregar filtro de grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                SELECT crSigCdGrpFilter
                IF RECCOUNT("crSigCdGrpFilter") > 0
                    INDEX ON CGrus TAG CGrus
                    INDEX ON DGrus TAG DGrus
                ENDIF
                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao carregar filtro de grupos:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AdicionarLinhaFicha - Adiciona linha em branco no final do crFichaTec
    *==========================================================================
    FUNCTION AdicionarLinhaFicha()
    *==========================================================================
        LOCAL loc_lResultado, loc_nProxOrd
        loc_lResultado = .F.

        TRY
            IF !USED("crFichaTec") OR !USED("crFichaCab")
                loc_lResultado = .F.
            ENDIF

            loc_nProxOrd = RECCOUNT("crFichaTec") + 1

            SELECT crFichaTec
            GO BOTTOM IN crFichaTec
            IF !EOF("crFichaTec")
                loc_nProxOrd = NVL(crFichaTec.COrds, 0) + 1
            ENDIF

            INSERT INTO crFichaTec (COrds, CGrus, SGrus) ;
                VALUES (loc_nProxOrd, THIS.this_cCGrus, THIS.this_cSGrus)

            GO BOTTOM IN crFichaTec
            loc_lResultado = .T.

        CATCH TO loException
            MsgErro("Erro ao adicionar linha:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ValidarFichaTec - Valida o conteudo da grade antes de gravar
    *==========================================================================
    FUNCTION ValidarFichaTec()
    *==========================================================================
        LOCAL loc_lResultado, loc_cMensagem
        loc_lResultado = .F.

        TRY
            IF !USED("crFichaTec")
                MsgErro("Cursor de ficha t" + CHR(233) + "cnica n" + CHR(227) + ;
                    "o encontrado!", "Erro")
                loc_lResultado = .F.
            ENDIF

            IF USED("crSigCdFtc")
                ZAP IN crSigCdFtc
            ELSE
                SET NULL ON
                CREATE CURSOR crSigCdFtc (COrds N(3), CGrus C(20), SGrus C(6), ;
                    CCars C(20), CTits C(20), CLins N(2), Maxs N(3), Mins N(3), ;
                    nChkCxas N(1), cSelecaos C(1), cIdChaves C(50), ;
                    nTipos N(1), cTpDados C(1))
                SET NULL OFF
            ENDIF

            SELECT crFichaTec
            SCAN
                IF !EMPTY(ALLTRIM(crFichaTec.CCars)) AND ;
                   !EMPTY(ALLTRIM(crFichaTec.CTits)) AND ;
                   crFichaTec.CLins >= 1
                    INSERT INTO crSigCdFtc (COrds, CGrus, SGrus, CCars, CTits, ;
                        CLins, Maxs, Mins, nChkCxas, cSelecaos, cIdChaves, ;
                        nTipos, cTpDados) ;
                        VALUES (crFichaTec.COrds, crFichaTec.CGrus, crFichaTec.SGrus, ;
                        crFichaTec.CCars, crFichaTec.CTits, crFichaTec.CLins, ;
                        crFichaTec.Maxs, crFichaTec.Mins, crFichaTec.nChkCxas, ;
                        NVL(crFichaTec.cSelecaos, " "), ;
                        LEFT(SYS(2015) + SYS(2015) + PADL(TRANSFORM(crFichaTec.COrds),5,"0"), 50), ;
                        THIS.this_nTipo, ;
                        NVL(crFichaTec.cTpDados, " "))
                ENDIF
            ENDSCAN

            IF RECCOUNT("crSigCdFtc") < 1
                MsgAviso("N" + CHR(227) + "o h" + CHR(225) + ;
                    " nenhum registro v" + CHR(225) + "lido na grade de ficha t" + ;
                    CHR(233) + "cnica!", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ENDIF

            SELECT CCars, CTits, SUM(1) AS Totas ;
                FROM crSigCdFtc ;
                GROUP BY CCars, CTits ;
                INTO CURSOR csItensCheck

            SELECT csItensCheck
            SCAN
                IF csItensCheck.Totas > 1
                    MsgAviso("O Grupo e o T" + CHR(237) + "tulo " + CHR(34) + ;
                        ALLTRIM(csItensCheck.CCars) + " / " + ;
                        ALLTRIM(csItensCheck.CTits) + CHR(34) + ;
                        " est" + CHR(225) + " duplicado!", ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                    IF USED("csItensCheck")
                        USE IN csItensCheck
                    ENDIF
                    loc_lResultado = .F.
                ENDIF
            ENDSCAN
            IF USED("csItensCheck")
                USE IN csItensCheck
            ENDIF

            SELECT COrds, SUM(1) AS Totas ;
                FROM crSigCdFtc ;
                GROUP BY COrds ;
                INTO CURSOR csOrdsCheck

            SELECT csOrdsCheck
            SCAN
                IF csOrdsCheck.Totas > 1
                    MsgAviso("A ordem de apresenta" + CHR(231) + CHR(227) + "o " + ;
                        CHR(34) + ALLTRIM(STR(csOrdsCheck.COrds)) + CHR(34) + ;
                        " est" + CHR(225) + " duplicada!", ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                    IF USED("csOrdsCheck")
                        USE IN csOrdsCheck
                    ENDIF
                    loc_lResultado = .F.
                ENDIF
            ENDSCAN
            IF USED("csOrdsCheck")
                USE IN csOrdsCheck
            ENDIF

            loc_lResultado = .T.

        CATCH TO loException
            MsgErro("Erro ao validar ficha:" + CHR(13) + loException.Message + ;
                CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * VerificarExcluirFicha - Verifica se e possivel excluir a ficha tecnica
    *==========================================================================
    FUNCTION VerificarExcluirFicha()
    *==========================================================================
        LOCAL loc_lResultado, loc_nResult, loc_cSQL
        loc_lResultado = .T.

        TRY
            IF !USED("crSigCdFtc") OR RECCOUNT("crSigCdFtc") < 1
                loc_lResultado = .T.
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT * FROM SigCdFtc" + ;
                " WHERE CGrus = " + EscaparSQL(THIS.this_cCGrus) + ;
                " AND SGrus = " + EscaparSQL(THIS.this_cSGrus), "crVerFtc")

            IF loc_nResult >= 1
                SELECT crVerFtc
                SCAN
                    LOCAL loc_cCCars, loc_cCTits, loc_cMsgProd
                    loc_cCCars = ALLTRIM(crVerFtc.CCars)
                    loc_cCTits = ALLTRIM(crVerFtc.CTits)

                    IF !EMPTY(loc_cCCars) AND !EMPTY(loc_cCTits)
                        loc_nResult = SQLEXEC(gnConnHandle, ;
                            "SELECT DISTINCT a.CPros FROM SigCdPft a, SigCdPro b" + ;
                            " WHERE a.CCars = " + EscaparSQL(loc_cCCars) + ;
                            " AND a.CTits = " + EscaparSQL(loc_cCTits) + ;
                            " AND a.CPros = b.CPros" + ;
                            " AND b.CGrus = " + EscaparSQL(THIS.this_cCGrus) + ;
                            " AND b.SGrus = " + EscaparSQL(THIS.this_cSGrus) + ;
                            " ORDER BY a.CPros", "crVerProd")
                        IF loc_nResult >= 1 AND RECCOUNT("crVerProd") > 0
                            GO TOP IN crVerProd
                            IF RECCOUNT("crVerProd") = 1
                                loc_cMsgProd = "O produto " + CHR(34) + ;
                                    ALLTRIM(crVerProd.CPros) + CHR(34) + " est" + CHR(225) + " "
                            ELSE
                                loc_cMsgProd = "Existem produtos que est" + CHR(227) + "o "
                            ENDIF
                            loc_cMsgProd = loc_cMsgProd + "utilizando o" + CHR(13) + ;
                                "Grupo de Caracter" + CHR(237) + "sticas: " + loc_cCCars + ;
                                " e o T" + CHR(237) + "tulo: " + loc_cCTits + "."
                            MsgErro(loc_cMsgProd, "Imposs" + CHR(237) + "vel Excluir")
                            IF USED("crVerProd")
                                USE IN crVerProd
                            ENDIF
                            loc_lResultado = .F.
                        ENDIF
                        IF USED("crVerProd")
                            USE IN crVerProd
                        ENDIF

                        IF loc_lResultado
                            loc_nResult = SQLEXEC(gnConnHandle, ;
                                "SELECT DISTINCT GruCarTits FROM SigCdFtr" + ;
                                " WHERE GruCarTits = " + ;
                                EscaparSQL(THIS.this_cCGrus + THIS.this_cSGrus + loc_cCCars + loc_cCTits), ;
                                "crVerResp")
                            IF loc_nResult >= 1 AND RECCOUNT("crVerResp") > 0
                                MsgErro("A Caracter" + CHR(237) + "stica " + CHR(34) + ;
                                    loc_cCCars + CHR(34) + " com o T" + CHR(237) + ;
                                    "tulo " + CHR(34) + loc_cCTits + CHR(34) + CHR(13) + ;
                                    "possui respostas cadastradas! Exclua as respostas primeiro!", ;
                                    "Imposs" + CHR(237) + "vel Excluir")
                                IF USED("crVerResp")
                                    USE IN crVerResp
                                ENDIF
                                loc_lResultado = .F.
                            ENDIF
                            IF USED("crVerResp")
                                USE IN crVerResp
                            ENDIF
                        ENDIF
                    ENDIF

                    IF !loc_lResultado
                        GO BOTTOM IN crVerFtc
                    ENDIF
                ENDSCAN
                IF USED("crVerFtc")
                    USE IN crVerFtc
                ENDIF
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao verificar depend" + CHR(234) + "ncias:" + CHR(13) + ;
                loException.Message + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AtualizarGrupoFicha - Atualiza flags do grupo e salva ficha tecnica
    * par_cModo - "ALTERAR" ou "EXCLUIR"
    *==========================================================================
    FUNCTION AtualizarGrupoFicha(par_cModo)
    *==========================================================================
        LOCAL loc_lResultado, loc_nResult, loc_cSQL
        loc_lResultado = .F.

        IF !INLIST(ALLTRIM(par_cModo), "ALTERAR", "EXCLUIR")
            MsgErro("Modo inv" + CHR(225) + "lido: " + ALLTRIM(par_cModo), "Erro")
            RETURN .F.
        ENDIF

        TRY
            IF ALLTRIM(par_cModo) == "ALTERAR"
                loc_lResultado = THIS.Atualizar()
            ELSE
                loc_lResultado = THIS.ExecutarExclusao()
            ENDIF

            IF loc_lResultado
                IF USED("crDados")
                    SELECT crDados
                    IF ALLTRIM(par_cModo) == "ALTERAR"
                        REPLACE TemDados WITH THIS.this_cCGrus + THIS.this_cSGrus IN crDados
                    ELSE
                        REPLACE TemDados WITH "" IN crDados
                    ENDIF
                ENDIF
                THIS.RegistrarAuditoria(par_cModo)
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao atualizar ficha:" + CHR(13) + loException.Message + ;
                CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
    *==========================================================================
        RETURN ALLTRIM(THIS.this_cCGrus) + "/" + ALLTRIM(THIS.this_cSGrus)
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCGrus   = ALLTRIM(TratarNulo(CGrus, "C"))
                THIS.this_cDGrus   = ALLTRIM(TratarNulo(DGrus, "C"))
                THIS.this_cSGrus   = ALLTRIM(TratarNulo(SGrus, "C"))
                THIS.this_cDSGru   = ALLTRIM(TratarNulo(DSGru, "C"))
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE Inserir()
    *==========================================================================
        RETURN .T.
    ENDPROC

    *==========================================================================
    * Atualizar - Salva a ficha tecnica no banco:
    *   1. DELETE registros antigos de SigCdFtc
    *   2. Se pnTipo=0: UPDATE flags em SigCdGrp
    *   3. INSERT novos registros de crSigCdFtc em SigCdFtc
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
    *==========================================================================
        LOCAL loc_lResultado, loc_nResult, loc_cSQL
        loc_lResultado = .F.

        TRY
            IF THIS.this_nTipo = 0
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT * FROM SigCdGrp WHERE CGrus = " + ;
                    EscaparSQL(THIS.this_cCGrus), "crLocalGruUpd")
                IF loc_nResult < 1 OR EOF("crLocalGruUpd")
                    MsgErro("O grupo " + CHR(34) + THIS.this_cCGrus + CHR(34) + ;
                        " foi exclu" + CHR(237) + "do durante o processo. Reinicie!", "Erro")
                    IF USED("crLocalGruUpd")
                        USE IN crLocalGruUpd
                    ENDIF
                    loc_lResultado = .F.
                ENDIF
                IF USED("crLocalGruUpd")
                    USE IN crLocalGruUpd
                ENDIF

                IF !USED("crFichaCab")
                    MsgErro("Cursor de cabe" + CHR(231) + "alho n" + CHR(227) + "o encontrado!", "Erro")
                    loc_lResultado = .F.
                ENDIF

                GO TOP IN crFichaCab
                loc_cSQL = "UPDATE SigCdGrp SET" + ;
                    " nChkDims = " + FormatarNumeroSQL(crFichaCab.nChkDims) + "," + ;
                    " nChkPess = " + FormatarNumeroSQL(crFichaCab.nChkPess) + "," + ;
                    " nChkTems = " + FormatarNumeroSQL(crFichaCab.nChkTems) + "," + ;
                    " nChkImps = " + FormatarNumeroSQL(crFichaCab.nChkImps) + "," + ;
                    " nFixFigs = " + FormatarNumeroSQL(crFichaCab.nFixFigs) + "," + ;
                    " mFicTecs = " + IIF(EMPTY(crFichaCab.mFicTecs), "NULL", ;
                        EscaparSQL(crFichaCab.mFicTecs)) + ;
                    " WHERE CGrus = " + EscaparSQL(THIS.this_cCGrus)

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult < 1
                    MsgErro("Erro ao atualizar grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    loc_lResultado = .F.
                ENDIF
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, ;
                "DELETE FROM SigCdFtc" + ;
                " WHERE CGrus = " + EscaparSQL(THIS.this_cCGrus) + ;
                " AND SGrus = " + EscaparSQL(THIS.this_cSGrus))
            IF loc_nResult < 1
                MsgErro("Erro ao excluir ficha anterior:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ENDIF

            IF USED("crSigCdFtc") AND RECCOUNT("crSigCdFtc") > 0
                SELECT crSigCdFtc
                SCAN
                    loc_cSQL = "INSERT INTO SigCdFtc" + ;
                        " (COrds, CGrus, SGrus, CCars, CTits, CLins, Maxs, Mins," + ;
                        " nChkCxas, cSelecaos, cIdChaves, nTipos, cTpDados) VALUES (" + ;
                        FormatarNumeroSQL(crSigCdFtc.COrds) + ", " + ;
                        EscaparSQL(crSigCdFtc.CGrus) + ", " + ;
                        EscaparSQL(crSigCdFtc.SGrus) + ", " + ;
                        EscaparSQL(crSigCdFtc.CCars) + ", " + ;
                        EscaparSQL(crSigCdFtc.CTits) + ", " + ;
                        FormatarNumeroSQL(crSigCdFtc.CLins) + ", " + ;
                        FormatarNumeroSQL(crSigCdFtc.Maxs) + ", " + ;
                        FormatarNumeroSQL(crSigCdFtc.Mins) + ", " + ;
                        FormatarNumeroSQL(crSigCdFtc.nChkCxas) + ", " + ;
                        EscaparSQL(NVL(crSigCdFtc.cSelecaos, " ")) + ", " + ;
                        "CONVERT(VARCHAR(50), NEWID()), " + ;
                        FormatarNumeroSQL(crSigCdFtc.nTipos) + ", " + ;
                        EscaparSQL(NVL(crSigCdFtc.cTpDados, " ")) + ")"

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResult < 1
                        MsgErro("Erro ao inserir linha da ficha:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                        loc_lResultado = .F.
                    ENDIF
                ENDSCAN
            ENDIF

            loc_lResultado = .T.

        CATCH TO loException
            MsgErro("Erro ao salvar ficha t" + CHR(233) + "cnica:" + CHR(13) + ;
                loException.Message + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
    *==========================================================================
        LOCAL loc_lResultado, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "DELETE FROM SigCdFtc" + ;
                " WHERE CGrus = " + EscaparSQL(THIS.this_cCGrus) + ;
                " AND SGrus = " + EscaparSQL(THIS.this_cSGrus))
            IF loc_nResult < 1
                MsgErro("Erro ao excluir ficha t" + CHR(233) + "cnica:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao excluir ficha:" + CHR(13) + loException.Message + ;
                CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

