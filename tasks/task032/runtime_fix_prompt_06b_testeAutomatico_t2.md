# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 2/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'BtnIncluirNavegacao': BtnIncluirClick nao navegou para Page2 (ActivePage=1)

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[05/16/26 07:24:44 AM] Erro: Connection handle is invalid.
[05/16/26 07:24:44 AM] Erro: File does not exist.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-05-16 07:22:26] [INFO] === VFP EXECUTOR v2.0 ===
[2026-05-16 07:22:26] [INFO] Config FPW: (nao fornecido)
[2026-05-16 07:22:26] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-05-16 07:22:26] [INFO] Timeout: 300 segundos
[2026-05-16 07:22:26] [INFO] Wrapper PRG criado para parametros: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_1ttyp1xr.prg
[2026-05-16 07:22:26] [INFO] Conteudo do wrapper:
[2026-05-16 07:22:26] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigreapp', 'C:\4c\tasks\task032', 'REPORT'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigreapp', 'C:\4c\tasks\task032', 'REPORT'
QUIT

[2026-05-16 07:22:26] [INFO] Comando VFP: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_1ttyp1xr.prg
[2026-05-16 07:22:26] [INFO] VFP output esperado em: C:\4c\tasks\task032\vfp_output.txt
[2026-05-16 07:22:26] [INFO] Executando Visual FoxPro 9...
[2026-05-16 07:22:26] [INFO] Comando completo: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_1ttyp1xr.prg
[2026-05-16 07:22:26] [INFO] Executando: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_1ttyp1xr.prg
[2026-05-16 07:22:26] [INFO] Timeout configurado: 300 segundos
[2026-05-16 07:22:28] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-05-16 07:22:28] [INFO] VFP9 finalizado em 1.7339789 segundos
[2026-05-16 07:22:28] [INFO] Exit Code: 
[2026-05-16 07:22:28] [INFO] 
[2026-05-16 07:22:28] [INFO] Arquivos temporarios preservados para inspecao:
[2026-05-16 07:22:28] [INFO]   Wrapper.prg: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_1ttyp1xr.prg
[2026-05-16 07:22:28] [INFO] 
[2026-05-16 07:22:28] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-05-16 07:22:28] [INFO] * Auto-generated wrapper for parameters
[2026-05-16 07:22:28] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-05-16 07:22:28] [INFO] * Parameters: 'Formsigreapp', 'C:\4c\tasks\task032', 'REPORT'
[2026-05-16 07:22:28] [INFO] 
[2026-05-16 07:22:28] [INFO] * Anti-dialog protections for unattended execution
[2026-05-16 07:22:28] [INFO] SET SAFETY OFF
[2026-05-16 07:22:28] [INFO] SET RESOURCE OFF
[2026-05-16 07:22:28] [INFO] SET TALK OFF
[2026-05-16 07:22:28] [INFO] SET NOTIFY OFF
[2026-05-16 07:22:28] [INFO] SYS(2335, 0)
[2026-05-16 07:22:28] [INFO] 
[2026-05-16 07:22:28] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigreapp', 'C:\4c\tasks\task032', 'REPORT'
[2026-05-16 07:22:28] [INFO] QUIT
[2026-05-16 07:22:28] [INFO] 
[2026-05-16 07:22:28] [INFO] === Fim do Wrapper.prg ===
[2026-05-16 07:22:28] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-05-16 07:24:42] [INFO] === VFP EXECUTOR v2.0 ===
[2026-05-16 07:24:42] [INFO] Config FPW: (nao fornecido)
[2026-05-16 07:24:42] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-05-16 07:24:42] [INFO] Timeout: 300 segundos
[2026-05-16 07:24:42] [INFO] Wrapper PRG criado para parametros: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_efpemlv2.prg
[2026-05-16 07:24:42] [INFO] Conteudo do wrapper:
[2026-05-16 07:24:42] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigreapp', 'C:\4c\tasks\task032', 'REPORT'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigreapp', 'C:\4c\tasks\task032', 'REPORT'
QUIT

[2026-05-16 07:24:42] [INFO] Comando VFP: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_efpemlv2.prg
[2026-05-16 07:24:42] [INFO] VFP output esperado em: C:\4c\tasks\task032\vfp_output.txt
[2026-05-16 07:24:42] [INFO] Executando Visual FoxPro 9...
[2026-05-16 07:24:42] [INFO] Comando completo: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_efpemlv2.prg
[2026-05-16 07:24:42] [INFO] Executando: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_efpemlv2.prg
[2026-05-16 07:24:42] [INFO] Timeout configurado: 300 segundos
[2026-05-16 07:24:45] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-05-16 07:24:45] [INFO] VFP9 finalizado em 2.4134753 segundos
[2026-05-16 07:24:45] [INFO] Exit Code: 
[2026-05-16 07:24:45] [INFO] 
[2026-05-16 07:24:45] [INFO] Arquivos temporarios preservados para inspecao:
[2026-05-16 07:24:45] [INFO]   Wrapper.prg: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_efpemlv2.prg
[2026-05-16 07:24:45] [INFO] 
[2026-05-16 07:24:45] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-05-16 07:24:45] [INFO] * Auto-generated wrapper for parameters
[2026-05-16 07:24:45] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-05-16 07:24:45] [INFO] * Parameters: 'Formsigreapp', 'C:\4c\tasks\task032', 'REPORT'
[2026-05-16 07:24:45] [INFO] 
[2026-05-16 07:24:45] [INFO] * Anti-dialog protections for unattended execution
[2026-05-16 07:24:45] [INFO] SET SAFETY OFF
[2026-05-16 07:24:45] [INFO] SET RESOURCE OFF
[2026-05-16 07:24:45] [INFO] SET TALK OFF
[2026-05-16 07:24:45] [INFO] SET NOTIFY OFF
[2026-05-16 07:24:45] [INFO] SYS(2335, 0)
[2026-05-16 07:24:45] [INFO] 
[2026-05-16 07:24:45] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigreapp', 'C:\4c\tasks\task032', 'REPORT'
[2026-05-16 07:24:45] [INFO] QUIT
[2026-05-16 07:24:45] [INFO] 
[2026-05-16 07:24:45] [INFO] === Fim do Wrapper.prg ===
[2026-05-16 07:24:45] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formsigreapp",
  "timestamp": "20260516072444",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": true,
      "erro": "",
      "detalhes": "Objeto criado com sucesso"
    },
    {
      "nome": "FormParaRelatorio",
      "passou": true,
      "erro": "",
      "detalhes": "Metodo FormParaRelatorio encontrado"
    },
    {
      "nome": "BotoesRelatorio",
      "passou": true,
      "erro": "",
      "detalhes": "Visualizar=SIM Imprimir=SIM"
    },
    {
      "nome": "ModoVisualizar",
      "passou": true,
      "erro": "",
      "detalhes": "Modo VISUALIZAR configurado"
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
      "detalhes": "AbrirLookup: 0 | KeyPress handlers: 12 (CLACHECKKEYPRESS, EMPCHECKKEYPRESS, KEYPRESS, TIPOCHECKKEYPRESS, TXTCONTAKEYPRESS, TXTDCONTAKEYPRESS, TXTDGRUPOKEYPRESS, TXTDJOBSKEYPRESS, TXTGRUPOKEYPRESS, TXTJOBSKEYPRESS, TXTMOEDACDKEYPRESS, TXTMOEDADSKEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreapp.prg):
*==============================================================================
* FORMSIGREAPP.PRG
* Formulario de Relatorio de Analise a Pagar / Receber
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREAPP.SCX (frmrelatorio)
*
* Dimensoes: Width=1300, Height=700
* Cabecalho: cnt_4c_Cabecalho Top=0, Height=80, BackColor=RGB(100,100,100)
* Filtros: pgf_4c_Paginas.Page1 (Top=85, Height=615, Tabs=.F.)
* Coordenadas de controles em Page1 = Top_original - 85
*
* BO: sigreappBO (herda RelatorioBase)
* Cursores: cursor_4c_SigCdEmp, cursor_4c_SigOpOpe, cursor_4c_SigCdClc,
*           cursor_4c_SigCdCot (carregados em CarregarCursores)
*==============================================================================

DEFINE CLASS Formsigreapp AS FormBase

    Height      = 700
    Width       = 1300
    DataSession = 2
    ShowWindow  = 1
    WindowType  = 1
    AutoCenter  = .T.
    BorderStyle = 2
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    ShowTips    = .T.

    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura visual do formulario de relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            THIS.Caption = "Relat" + CHR(243) + "rio de An" + CHR(225) + "lise a Pagar / Receber"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            IF TYPE("gc_4c_CaminhoReports") = "U"
                gc_4c_CaminhoReports = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            THIS.this_oRelatorio = CREATEOBJECT("sigreappBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar sigreappBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarPageFrame()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.ConfigurarFiltros()
                IF !THIS.CarregarCursores()
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarGrids()
                THIS.LimparCampos()
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container cinza superior com titulo e 4 botoes
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab, loc_oCmg
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = THIS.cnt_4c_Cabecalho

        WITH loc_oCab
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 22
                .Left      = 22
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = ""
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 20
                .Left      = 20
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = ""
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("cmg_4c_Botoes", "CommandGroup")
            WITH .cmg_4c_Botoes
                .Top           = 0
                .Left          = 1026
                .Width         = THIS.Width
                .Height        = 80
                .ButtonCount   = 4
                .BackStyle     = 0
                .BorderColor   = RGB(136, 189, 188)
                .SpecialEffect = 1
                .Themes        = .F.
                .Visible       = .T.

                WITH .Buttons(1)
                    .Caption         = "Visualizar"
                    .Top             = 5
                    .Left            = 5
                    .Width           = THIS.Width
                    .Height          = 70
                    .Picture         = gc_4c_CaminhoIcones + "ideo.jpg"
                    .PicturePosition = 13
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .Themes          = .F.
                ENDWITH

                WITH .Buttons(2)
                    .Caption         = "Imprimir"
                    .Top             = 5
                    .Left            = 71
                    .Width           = THIS.Width
                    .Height          = 70
                    .Picture         = gc_4c_CaminhoIcones + "impressora.jpg"
                    .PicturePosition = 13
                    .FontName        = "Tahoma"
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .FontSize        = 8
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .Themes          = .F.
                ENDWITH

                WITH .Buttons(3)
                    .Caption         = "Doc. Excel"
                    .Top             = 5
                    .Left            = 137
                    .Width           = THIS.Width
                    .Height          = 70
                    .Picture         = gc_4c_CaminhoIcones + "excel.jpg"
                    .PicturePosition = 13
                    .FontName        = "Tahoma"
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .FontSize        = 8
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .Themes          = .F.
                ENDWITH

                WITH .Buttons(4)
                    .Caption         = "Sair"
                    .Top             = 5
                    .Left            = 203
                    .Width           = THIS.Width
                    .Height          = 70
                    .Picture         = gc_4c_CaminhoIcones + "otao_encerrar.jpg"
                    .PicturePosition = 13
                    .Cancel          = .T.
                    .FontName        = "Tahoma"
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .FontSize        = 8
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .Themes          = .F.
                ENDWITH
            ENDWITH
        ENDWITH

        loc_oCmg = loc_oCab.cmg_4c_Botoes
        BINDEVENT(loc_oCmg.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oCmg.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(loc_oCmg.Buttons(3), "Click", THIS, "BtnGerarExcelClick")
        BINDEVENT(loc_oCmg.Buttons(4), "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame plano (sem abas) com 1 pagina de filtros
    * Top=85, Height=615 (700-85), Width=1302
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        loc_oPgf.PageCount   = 1
        loc_oPgf.Top         = 85
        loc_oPgf.Left        = -1
        loc_oPgf.Width       = THIS.Width + 2
        loc_oPgf.Height      = THIS.Height - 85
        loc_oPgf.Tabs        = .F.

        loc_oPgf.Page1.Caption   = "Filtros"
        loc_oPgf.Page1.FontName  = "Tahoma"
        loc_oPgf.Page1.FontSize  = 8
        loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarFiltros - Adiciona todos os controles de filtro em Page1
    * Coordenadas: Top_page1 = Top_original - 85
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarFiltros()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        *-- Tipo de relatorio (Analitico/Sintetico/Fluxo de Caixa)
        loc_oPg1.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPg1.lbl_4c_Label2
            .Top       = 20
            .Left      = 64
            .Width     = 35
            .Height    = 15
            .Caption   = "Tipo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("obj_4c_Opt_AnaSi", "OptionGroup")
        WITH loc_oPg1.obj_4c_Opt_AnaSi
            .Top         = 13
            .Left        = 92
            .Width       = 265
            .Height      = 29
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption   = "Anal" + CHR(237) + "tico"
                .Value     = 1
                .Top       = 6
                .Left      = 5
                .Width     = 58
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Sint" + CHR(233) + "tico"
                .Value     = 0
                .Top       = 6
                .Left      = 76
                .Width     = 59
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "Fluxo de Caixa"
                .Top       = 6
                .Left      = 151
                .Width     = 89
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Periodo (DtInicial / DtFinal)
        loc_oPg1.AddObject("lbl_4c_LblPeriodo", "Label")
        WITH loc_oPg1.lbl_4c_LblPeriodo
            .Top       = 44
            .Left      = 29
            .Width     = 80
            .Height    = 15
            .Caption   = "Vencimento :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oPg1.txt_4c_DtInicial
            .Top           = 40
            .Left          = 98
            .Width         = 80
            .Height        = 24
            .Value         = {}
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        loc_oPg1.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPg1.lbl_4c_Label3
            .Top       = 45
            .Left      = 183
            .Width     = 18
            .Height    = 15
            .Caption   = "at" + CHR(233)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("txt_4c_DtFinal", "TextBox")
        WITH loc_oPg1.txt_4c_DtFinal
            .Top           = 40
            .Left          = 208
            .Width         = 80
            .Height        = 24
            .Value         = {}
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Tipo de data (Vencimento/Emissao/Lancamento)
        loc_oPg1.AddObject("obj_4c_OptDatas", "OptionGroup")
        WITH loc_oPg1.obj_4c_OptDatas
            .Top         = 39
            .Left        = 287
            .Width       = 265
            .Height      = 29
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption   = "Vencimento"
                .Value     = 1
                .Top       = 6
                .Left      = 5
                .Width     = 73
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Emiss" + CHR(227) + "o"
                .Value     = 0
                .Top       = 6
                .Left      = 91
                .Width     = 56
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "Lan" + CHR(231) + "amento"
                .Top       = 6
                .Left      = 159
                .Width     = 76
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Saldo Inicial
        loc_oPg1.AddObject("lbl_4c_Label10", "Label")
        WITH loc_oPg1.lbl_4c_Label10
            .Top       = 44
            .Left      = 584
            .Width     = 80
            .Height    = 15
            .Caption   = "Saldo Inicial :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("txt_4c_Saldo", "TextBox")
        WITH loc_oPg1.txt_4c_Saldo
            .Top           = 40
            .Left          = 652
            .Width         = 148
            .Height        = 24
            .Value         = 0
            .Alignment     = 1
            .Format        = "K"
            .InputMask     = "999999999999.99"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Saldos (Informado/Data Inicial/Data Atual)
        loc_oPg1.AddObject("obj_4c_OptSaldos", "OptionGroup")
        WITH loc_oPg1.obj_4c_OptSaldos
            .Top         = 40
            .Left        = 798
            .Width       = 265
            .Height      = 29
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption   = "Informado"
                .Value     = 1
                .Top       = 6
                .Left      = 5
                .Width     = 68
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Data Inicial"
                .Value     = 0
                .Top       = 6
                .Left      = 87
                .Width     = 71
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "Data Atual"
                .Top       = 6
                .Left      = 176
                .Width     = 69
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Grupo contabil
        loc_oPg1.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPg1.lbl_4c_Label5
            .Top       = 72
            .Left      = 55
            .Width     = 40
            .Height    = 15
            .Caption   = "Grupo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPg1.txt_4c_Grupo
            .Top           = 67
            .Left          = 98
            .Width         = 80
            .Height        = 24
            .Value         = ""
            .Format        = "K"
            .MaxLength     = 10
            .FontName      = "Tahoma"
            .FontSize      = 9
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.txt_4c_Grupo, "KeyPress", THIS, "TxtGrupoKeyPress")

        loc_oPg1.AddObject("txt_4c_DGrupo", "TextBox")
        WITH loc_oPg1.txt_4c_DGrupo
            .Top           = 67
            .Left          = 181
            .Width         = 301
            .Height        = 24
            .Value         = ""
            .Format        = "K"
            .MaxLength     = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.txt_4c_DGrupo, "When",  THIS, "DGrupoWhen")
        BINDEVENT(loc_oPg1.txt_4c_DGrupo, "KeyPress", THIS, "TxtDGrupoKeyPress")

        *-- Juros
        loc_oPg1.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPg1.lbl_4c_Label6
            .Top       = 71
            .Left      = 614
            .Width     = 40
            .Height    = 15
            .Caption   = "Juros :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("obj_4c_Opt_Juros", "OptionGroup")
        WITH loc_oPg1.obj_4c_Opt_Juros
            .Top         = 68
            .Left        = 646
            .Width       = 91
            .Height      = 23
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 2
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption   = "Sim"
                .Value     = 0
                .Top       = 5
                .Left      = 5
                .Width     = 38
                .Height    = 17
                .AutoSize  = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Value     = 1
                .Top       = 5
                .Left      = 48
                .Width     = 38
                .Height    = 17
                .AutoSize  = .F.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH
        BINDEVENT(loc_oPg1.obj_4c_Opt_Juros, "Click", THIS, "JurosOptClick")

        loc_oPg1.AddObject("txt_4c__Juros", "TextBox")
        WITH loc_oPg1.txt_4c__Juros
            .Top           = 67
            .Left          = 749
            .Width         = 51
            .Height        = 24
            .Value         = 0
            .Alignment     = 1
            .Format        = "K"
            .InputMask     = "99.99"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.txt_4c__Juros, "When", THIS, "JurosWhen")

        loc_oPg1.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPg1.lbl_4c_Label7
            .Top       = 72
            .Left      = 802
            .Width     = 40
            .Height    = 15
            .Caption   = "% m" + CHR(234) + "s"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Pagamentos / Recebimentos
        loc_oPg1.AddObject("chk_4c_Ck_Pagamentos", "CheckBox")
        WITH loc_oPg1.chk_4c_Ck_Pagamentos
            .Top       = 74
            .Left      = 889
            .Width     = 90
            .Height    = 15
            .Caption   = "Pagamentos"
            .Value     = 0
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.chk_4c_Ck_Pagamentos, "InteractiveChange", THIS, "PagamentosChange")

        loc_oPg1.AddObject("chk_4c_Ck_Recebimentos", "CheckBox")
        WITH loc_oPg1.chk_4c_Ck_Recebimentos
            .Top       = 97
            .Left      = 889
            .Width     = 100
            .Height    = 15
            .Caption   = "Recebimentos"
            .Value     = 0
            .BackStyle = 0
            .Alignment = 0
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.chk_4c_Ck_Recebimentos, "InteractiveChange", THIS, "RecebimentosChange")

        *-- Conta contabil
        loc_oPg1.AddObject("lbl_4c_Lbl_estoque", "Label")
        WITH loc_oPg1.lbl_4c_Lbl_estoque
            .Top       = 99
            .Left      = 55
            .Width     = 40
            .Height    = 15
            .Caption   = "Conta :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oPg1.txt_4c_Conta
            .Top           = 94
            .Left          = 98
            .Width         = 80
            .Height        = 24
            .Value         = ""
            .Format        = "K"
            .MaxLength     = 10
            .FontName      = "Tahoma"
            .FontSize      = 9
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.txt_4c_Conta, "KeyPress", THIS, "TxtContaKeyPress")

        loc_oPg1.AddObject("txt_4c_DConta", "TextBox")
        WITH loc_oPg1.txt_4c_DConta
            .Top           = 94
            .Left          = 181
            .Width         = 301
            .Height        = 24
            .Value         = ""
            .Format        = "K"
            .MaxLength     = 40
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.txt_4c_DConta, "When",  THIS, "DContaWhen")
        BINDEVENT(loc_oPg1.txt_4c_DConta, "KeyPress", THIS, "TxtDContaKeyPress")

        *-- Moeda
        loc_oPg1.AddObject("lbl_4c_Lbl_fator", "Label")
        WITH loc_oPg1.lbl_4c_Lbl_fator
            .Top       = 98
            .Left      = 608
            .Width     = 50
            .Height    = 15
            .Caption   = "Moeda :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("txt_4c__cd_moeda", "TextBox")
        WITH loc_oPg1.txt_4c__cd_moeda
            .Top           = 94
            .Left          = 652
            .Width         = 31
            .Height        = 24
            .Value         = ""
            .Format        = "K"
            .MaxLength     = 3
            .FontName      = "Tahoma"
            .FontSize      = 9
            .ForeColor     = RGB(0, 0, 0)
            .BackStyle     = 1
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Alignment     = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.txt_4c__cd_moeda, "KeyPress",   THIS, "TxtMoedaCdKeyPress")

        loc_oPg1.AddObject("txt_4c__ds_moeda", "TextBox")
        WITH loc_oPg1.txt_4c__ds_moeda
            .Top           = 94
            .Left          = 685
            .Width         = 115
            .Height        = 24
            .Value         = ""
            .Format        = "K"
            .MaxLength     = 15
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.txt_4c__ds_moeda, "When",      THIS, "MoedaDsWhen")
        BINDEVENT(loc_oPg1.txt_4c__ds_moeda, "KeyPress",   THIS, "TxtMoedaDsKeyPress")

        *-- Job (centro de custo)
        loc_oPg1.AddObject("lbl_4c_Label11", "Label")
        WITH loc_oPg1.lbl_4c_Label11
            .Top       = 125
            .Left      = 67
            .Width     = 30
            .Height    = 15
            .Caption   = "Job :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("txt_4c__Jobs", "TextBox")
        WITH loc_oPg1.txt_4c__Jobs
            .Top           = 120
            .Left          = 98
            .Width         = 80
            .Height        = 24
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Margin        = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.txt_4c__Jobs, "KeyPress", THIS, "TxtJobsKeyPress")

        loc_oPg1.AddObject("txt_4c_DJobs", "TextBox")
        WITH loc_oPg1.txt_4c_DJobs
            .Top           = 120
            .Left          = 181
            .Width         = 301
            .Height        = 24
            .Value         = ""
            .MaxLength     = 40
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Margin        = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.txt_4c_DJobs, "When",  THIS, "DJobsWhen")
        BINDEVENT(loc_oPg1.txt_4c_DJobs, "KeyPress", THIS, "TxtDJobsKeyPress")

        *-- Numero da operacao
        loc_oPg1.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oPg1.lbl_4c_Label9
            .Top       = 125
            .Left      = 607
            .Width     = 50
            .Height    = 15
            .Caption   = "C" + CHR(243) + "digo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("txt_4c__Numes", "TextBox")
        WITH loc_oPg1.txt_4c__Numes
            .Top           = 121
            .Left          = 653
            .Width         = 80
            .Height        = 24
            .Value         = 0
            .Format        = "K"
            .MaxLength     = 10
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- Autorizados
        loc_oPg1.AddObject("lbl_4c_Label12", "Label")
        WITH loc_oPg1.lbl_4c_Label12
            .Top       = 150
            .Left      = 27
            .Width     = 70
            .Height    = 15
            .Caption   = "Autoriza" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("obj_4c_OptAutorizados", "OptionGroup")
        WITH loc_oPg1.obj_4c_OptAutorizados
            .Top         = 145
            .Left        = 92
            .Width       = 310
            .Height      = 27
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption   = "Todos"
                .Top       = 5
                .Left      = 5
                .Width     = 56
                .Height    = 17
                .AutoSize  = .F.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Autorizados"
                .Top       = 6
                .Left      = 63
                .Width     = 75
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "N" + CHR(227) + "o Autorizados"
                .Top       = 6
                .Left      = 154
                .Width     = 97
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCursores - Carrega cursores SQL necessarios para grids e BO
    * Deve ser chamado ANTES de ConfigurarGrids (grids referenciam cursores)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarCursores()
        LOCAL loc_nRes, loc_lSucesso, loc_lContinuar, loc_cMoeda, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            CREATE CURSOR cursor_4c_SigCdCot (CMoes c(3), Datas d, Valos n(15,6))
            CREATE CURSOR cursor_4c_SigCdMoe (CMoes c(3), DMoes c(40))
            INDEX ON CMoes TAG CMoes
            CREATE CURSOR cursor_4c_SigCdEmp (Imps n(1), cEmps c(3), Razas c(80))
            INDEX ON cEmps TAG cEmps
            CREATE CURSOR cursor_4c_SigOpOpe (Imps n(1), Dopes c(20), Opers c(2), RealPrevs n(2))
            INDEX ON Dopes TAG Dopes
            CREATE CURSOR cursor_4c_SigCdClc (Imps n(1), Codigos c(10), Descs c(60))
            RETURN .T.
        ENDIF

        TRY
            *-- Cotacoes de moeda (indexado para BuscarCambio no BO)
            IF loc_lContinuar
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT CMoes, Datas, Valos FROM SigCdCot ORDER BY CMoes, Datas", ;
                    "cursor_4c_SigCdCot")
                IF loc_nRes > 0
                    SELECT cursor_4c_SigCdCot
                    INDEX ON CMoes + DTOS(Datas) TAG CMoeData
                ENDIF
            ENDIF

            *-- Moedas (indexado para lookup de descricao)
            IF loc_lContinuar
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes", ;
                    "cursor_4c_SigCdMoe")
                IF loc_nRes > 0
                    SELECT cursor_4c_SigCdMoe
                    INDEX ON CMoes TAG CMoes
                ENDIF
            ENDIF

            *-- Empresas
            IF loc_lContinuar
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT 1 as Imps, cEmps, Razas FROM SigCdEmp ORDER BY cEmps", ;
                    "cursor_4c_SigCdEmp")
                IF loc_nRes < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (SigCdEmp)", "Erro")
                    loc_lContinuar = .F.
                ELSE
                    SELECT cursor_4c_SigCdEmp
                    INDEX ON cEmps TAG cEmps
                ENDIF
            ENDIF

            *-- Operacoes de Titulo (inclui linha em branco para exibir opcao "nenhuma")
            IF loc_lContinuar
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT 1 as Imps, Dopes, Opers, RealPrevs FROM SigOpOpe ORDER BY Dopes", ;
                    "cursor_4c_SigOpOpe")
                IF loc_nRes < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (SigOpOpe)", "Erro")
                    loc_lContinuar = .F.
                ELSE
                    INSERT INTO cursor_4c_SigOpOpe (Imps, Dopes, Opers) ;
                        VALUES (0, SPACE(20), "C")
                    GO TOP IN cursor_4c_SigOpOpe
                    SELECT cursor_4c_SigOpOpe
                    INDEX ON Dopes TAG Dopes
                ENDIF
            ENDIF

            *-- Classificacoes (SigCdClc, inclui linha EM BRANCO marcada)
            IF loc_lContinuar
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT 1 as Imps, Codigos, Descs FROM SigCdClc ORDER BY Codigos", ;
                    "cursor_4c_SigCdClc")
                IF loc_nRes < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (SigCdClc)", "Erro")
                    loc_lContinuar = .F.
                ELSE
                    INSERT INTO cursor_4c_SigCdClc (Imps, Codigos, Descs) ;
                        VALUES (1, SPACE(10), "EM BRANCO")
                    GO TOP IN cursor_4c_SigCdClc
                ENDIF
            ENDIF

            *-- Moeda padrao (SigCdPam)
            IF loc_lContinuar
                loc_nRes = SQLEXEC(gnConnHandle, "SELECT Moedaps FROM SigCdPam", ;
                    "cursor_4c_SigCdPam")
                IF loc_nRes > 0 AND !EOF("cursor_4c_SigCdPam") AND ;
                   !EMPTY(cursor_4c_SigCdPam.Moedaps)
                    loc_cMoeda = ALLTRIM(cursor_4c_SigCdPam.Moedaps)
                    THIS.pgf_4c_Paginas.Page1.txt_4c__cd_moeda.Value = loc_cMoeda
                    IF SEEK(loc_cMoeda, "cursor_4c_SigCdMoe", "CMoes")
                        THIS.pgf_4c_Paginas.Page1.txt_4c__ds_moeda.Value = ;
                            ALLTRIM(cursor_4c_SigCdMoe.DMoes)
                    ENDIF
                    IF VARTYPE(THIS.this_oRelatorio) = "O"
                        LOCAL loc_nCotacao
                        loc_nCotacao = THIS.this_oRelatorio.BuscarCambio(loc_cMoeda)
                        THIS.this_oRelatorio.this_nVlCotacao = ;
                            IIF(loc_nCotacao = 0, 1, loc_nCotacao)
                    ENDIF
                ENDIF
                IF USED("cursor_4c_SigCdPam")
                    USE IN cursor_4c_SigCdPam
                ENDIF
            ENDIF

            IF loc_lContinuar
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ao Carregar Dados")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ConfigurarGrids - Cria os tres grids apos cursores ja carregados
    * grd_4c_Emps (Empresas), grd_4c_Tipo (Operacoes), grd_4c_Cla (Classificacoes)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrids()
        LOCAL loc_oPg1, loc_oGrd
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        *======================================================================
        *-- GRID EMPRESAS
        *======================================================================
        loc_oPg1.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPg1.lbl_4c_Label1
            .Top       = 181
            .Left      = 24
            .Width     = 60
            .Height    = 15
            .Caption   = "Empresas"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("chk_4c_Ck_MarcaEmp", "CheckBox")
        WITH loc_oPg1.chk_4c_Ck_MarcaEmp
            .Top       = 198
            .Left      = 25
            .Width     = 13
            .Height    = 16
            .Caption   = ""
            .Value     = 1
            .Alignment = 0
            .Centered  = .F.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.chk_4c_Ck_MarcaEmp, "Click", THIS, "MarcaEmpClick")

        loc_oPg1.AddObject("grd_4c_Emps", "Grid")
        loc_oGrd = loc_oPg1.grd_4c_Emps
        WITH loc_oGrd
            .Top               = 197
            .Left              = 24
            .Width             = 331
            .Height            = 394
            .ColumnCount       = 3
            .FontName          = "Tahoma"
            .FontSize          = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .RowHeight         = 17
            .ScrollBars        = 2
            .GridLineColor     = RGB(238, 238, 238)
            .ReadOnly          = .F.
            .RecordSource      = "cursor_4c_SigCdEmp"
            .Visible           = .T.
        ENDWITH
        loc_oGrd.Column1.ControlSource = "cursor_4c_SigCdEmp.Imps"
        loc_oGrd.Column2.ControlSource = "cursor_4c_SigCdEmp.cEmps"
        loc_oGrd.Column3.ControlSource = "cursor_4c_SigCdEmp.Razas"

        WITH loc_oGrd.Column1
            .Width         = 17
            .ControlSource = "cursor_4c_SigCdEmp.Imps"
            .FontName      = "Courier New"
            .Movable       = .F.
            .Resizable     = .F.
            .ReadOnly      = .F.
            .Sparse        = .F.
        ENDWITH
        loc_oGrd.Column1.Header1.Caption  = ""
        loc_oGrd.Column1.Header1.ForeColor = RGB(90, 90, 90)
        loc_oGrd.Column1.AddObject("Check1", "CheckBox")
        WITH loc_oGrd.Column1.Check1
            .Alignment = 0
            .Caption   = ""
            .AutoSize  = .T.
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
        loc_oGrd.Column1.CurrentControl = "Check1"
        BINDEVENT(loc_oGrd.Column1.Check1, "MouseDown", THIS, "EmpCheckMouseDown")
        BINDEVENT(loc_oGrd.Column1.Check1, "MouseUp",   THIS, "EmpCheckMouseUp")
        BINDEVENT(loc_oGrd.Column1.Check1, "Click",     THIS, "EmpCheckClick")
        BINDEVENT(loc_oGrd.Column1.Check1, "KeyPress",  THIS, "EmpCheckKeyPress")

        WITH loc_oGrd.Column2
            .Width         = 27
            .ControlSource = "cursor_4c_SigCdEmp.cEmps"
            .FontName      = "Courier New"
            .Movable       = .F.
            .Resizable     = .F.
            .ReadOnly      = .T.
        ENDWITH
        loc_oGrd.Column2.Header1.Caption   = "Emp."
        loc_oGrd.Column2.Header1.Alignment = 2
        loc_oGrd.Column2.Header1.ForeColor = RGB(90, 90, 90)
        loc_oGrd.Column2.Text1.ForeColor   = RGB(0, 0, 0)

        WITH loc_oGrd.Column3
            .Width         = 263
            .ControlSource = "cursor_4c_SigCdEmp.Razas"
            .FontName      = "Courier New"
            .Movable       = .F.
            .Resizable     = .F.
            .ReadOnly      = .T.
        ENDWITH
        loc_oGrd.Column3.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
        loc_oGrd.Column3.Header1.Alignment = 2
        loc_oGrd.Column3.Header1.ForeColor = RGB(90, 90, 90)
        loc_oGrd.Column3.Text1.ForeColor   = RGB(0, 0, 0)

        *======================================================================
        *-- GRID OPERACOES DE TITULO
        *======================================================================
        loc_oPg1.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPg1.lbl_4c_Label4
            .Top       = 181
            .Left      = 369
            .Width     = 120
            .Height    = 15
            .Caption   = "Opera" + CHR(231) + CHR(245) + "es de T" + CHR(237) + "tulo"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("chk_4c_Ck_MarcaOpe", "CheckBox")
        WITH loc_oPg1.chk_4c_Ck_MarcaOpe
            .Top       = 198
            .Left      = 371
            .Width     = 13
            .Height    = 16
            .Caption   = ""
            .Value     = 1
            .Alignment = 0
            .Centered  = .F.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.chk_4c_Ck_MarcaOpe, "Click", THIS, "MarcaOpeClick")

        loc_oPg1.AddObject("grd_4c_Tipo", "Grid")
        loc_oGrd = loc_oPg1.grd_4c_Tipo
        WITH loc_oGrd
            .Top               = 197
            .Left              = 369
            .Width             = 323
            .Height            = 394
            .ColumnCount       = 2
            .FontName          = "Tahoma"
            .FontSize          = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .HeaderHeight      = 17
            .RowHeight         = 17
            .ScrollBars        = 2
            .GridLineColor     = RGB(238, 238, 238)
            .ReadOnly          = .F.
            .RecordSource      = "cursor_4c_SigOpOpe"
            .Visible           = .T.
        ENDWITH
        loc_oGrd.Column1.ControlSource = "cursor_4c_SigOpOpe.Imps"
        loc_oGrd.Column2.ControlSource = "cursor_4c_SigOpOpe.Dopes"

        WITH loc_oGrd.Column1
            .Width         = 17
            .ControlSource = "cursor_4c_SigOpOpe.Imps"
            .Alignment     = 0
            .FontName      = "Courier New"
            .Movable       = .F.
            .Resizable     = .F.
            .ReadOnly      = .F.
            .Sparse        = .F.
            .Enabled       = .T.
        ENDWITH
        loc_oGrd.Column1.Header1.Caption  = ""
        loc_oGrd.Column1.Header1.ForeColor = RGB(90, 90, 90)
        loc_oGrd.Column1.AddObject("check12", "CheckBox")
        WITH loc_oGrd.Column1.check12
            .Alignment = 0
            .Caption   = ""
            .AutoSize  = .T.
            .BackStyle = 0
            .Enabled   = .T.
            .Visible   = .T.
        ENDWITH
        loc_oGrd.Column1.CurrentControl = "check12"
        BINDEVENT(loc_oGrd.Column1.check12, "MouseDown", THIS, "TipoCheckMouseDown")
        BINDEVENT(loc_oGrd.Column1.check12, "MouseUp",   THIS, "TipoCheckMouseUp")
        BINDEVENT(loc_oGrd.Column1.check12, "Click",     THIS, "TipoCheckClick")
        BINDEVENT(loc_oGrd.Column1.check12, "KeyPress",  THIS, "TipoCheckKeyPress")

        WITH loc_oGrd.Column2
            .Width         = 283
            .ControlSource = "cursor_4c_SigOpOpe.Dopes"
            .FontName      = "Courier New"
            .Movable       = .F.
            .Resizable     = .F.
            .ReadOnly      = .T.
            .Enabled       = .T.
        ENDWITH
        loc_oGrd.Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
        loc_oGrd.Column2.Header1.Alignment = 2
        loc_oGrd.Column2.Header1.ForeColor = RGB(90, 90, 90)
        loc_oGrd.Column2.Text1.ForeColor   = RGB(0, 0, 0)
        loc_oGrd.Column2.Text1.BackColor   = RGB(255, 255, 255)
        loc_oGrd.Column2.Text1.ReadOnly    = .T.

        *======================================================================
        *-- GRID CLASSIFICACOES
        *======================================================================
        loc_oPg1.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPg1.lbl_4c_Label8
            .Top       = 180
            .Left      = 706
            .Width     = 95
            .Height    = 15
            .Caption   = "Classifica" + CHR(231) + CHR(245) + "es"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("chk_4c_Ck_MarcaCla", "CheckBox")
        WITH loc_oPg1.chk_4c_Ck_MarcaCla
            .Top       = 198
            .Left      = 708
            .Width     = 13
            .Height    = 16
            .Caption   = ""
            .Value     = 1
            .Alignment = 0
            .Centered  = .F.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.chk_4c_Ck_MarcaCla, "Click", THIS, "MarcaClaClick")

        loc_oPg1.AddObject("grd_4c_Cla", "Grid")
        loc_oGrd = loc_oPg1.grd_4c_Cla
        WITH loc_oGrd
            .Top               = 197
            .Left              = 706
            .Width             = 574
            .Height            = 394
            .ColumnCount       = 3
            .FontName          = "Tahoma"
            .FontSize          = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .RowHeight         = 17
            .ScrollBars        = 2
            .GridLineColor     = RGB(238, 238, 238)
            .ReadOnly          = .F.
            .RecordSource      = "cursor_4c_SigCdClc"
            .Visible           = .T.
        ENDWITH
        loc_oGrd.Column1.ControlSource = "cursor_4c_SigCdClc.Imps"
        loc_oGrd.Column2.ControlSource = "cursor_4c_SigCdClc.Codigos"
        loc_oGrd.Column3.ControlSource = "cursor_4c_SigCdClc.Descs"

        WITH loc_oGrd.Column1
            .Width         = 19
            .ControlSource = "cursor_4c_SigCdClc.Imps"
            .FontName      = "Courier New"
            .Movable       = .F.
            .Resizable     = .F.
            .ReadOnly      = .F.
            .Sparse        = .F.
        ENDWITH
        loc_oGrd.Column1.Header1.Caption  = ""
        loc_oGrd.Column1.Header1.ForeColor = RGB(90, 90, 90)
        loc_oGrd.Column1.AddObject("check13", "CheckBox")
        WITH loc_oGrd.Column1.check13
            .Alignment = 0
            .Caption   = ""
            .AutoSize  = .T.
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
        loc_oGrd.Column1.CurrentControl = "check13"
        BINDEVENT(loc_oGrd.Column1.check13, "MouseDown", THIS, "ClaCheckMouseDown")
        BINDEVENT(loc_oGrd.Column1.check13, "MouseUp",   THIS, "ClaCheckMouseUp")
        BINDEVENT(loc_oGrd.Column1.check13, "Click",     THIS, "ClaCheckClick")
        BINDEVENT(loc_oGrd.Column1.check13, "KeyPress",  THIS, "ClaCheckKeyPress")

        WITH loc_oGrd.Column2
            .Width         = 80
            .ControlSource = "cursor_4c_SigCdClc.Codigos"
            .FontName      = "Courier New"
            .Movable       = .F.
            .Resizable     = .F.
            .ReadOnly      = .T.
        ENDWITH
        loc_oGrd.Column2.Header1.Caption   = "C" + CHR(243) + "digo"
        loc_oGrd.Column2.Header1.Alignment = 2
        loc_oGrd.Column2.Header1.ForeColor = RGB(90, 90, 90)
        loc_oGrd.Column2.Text1.ForeColor   = RGB(0, 0, 0)
        loc_oGrd.Column2.Text1.ReadOnly    = .F.

        WITH loc_oGrd.Column3
            .Width         = 452
            .ControlSource = "cursor_4c_SigCdClc.Descs"
            .FontName      = "Courier New"
            .Movable       = .F.
            .Resizable     = .F.
            .ReadOnly      = .T.
        ENDWITH
        loc_oGrd.Column3.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
        loc_oGrd.Column3.Header1.Alignment = 2
        loc_oGrd.Column3.Header1.ForeColor = RGB(90, 90, 90)
        loc_oGrd.Column3.Text1.ForeColor   = RGB(0, 0, 0)
        loc_oGrd.Column3.Text1.BackColor   = RGB(255, 255, 255)
        loc_oGrd.Column3.Text1.ReadOnly    = .T.

    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoControles - Report form: sem estado CRUD, ajusta botoes
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarEstadoControles()
        THIS.AjustarBotoesPorModo()
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Reseta todos os filtros para valores padrao
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        loc_oPg1.txt_4c_DtInicial.Value          = DATE()
        loc_oPg1.txt_4c_DtFinal.Value            = DATE()
        loc_oPg1.txt_4c__Numes.Value             = 0
        loc_oPg1.txt_4c_Saldo.Value              = 0
        loc_oPg1.txt_4c__Juros.Value             = 0
        loc_oPg1.txt_4c_Grupo.Value              = ""
        loc_oPg1.txt_4c_DGrupo.Value             = ""
        loc_oPg1.txt_4c_Conta.Value              = ""
        loc_oPg1.txt_4c_DConta.Value             = ""
        loc_oPg1.txt_4c__Jobs.Value              = ""
        loc_oPg1.txt_4c_DJobs.Value              = ""
        loc_oPg1.obj_4c_Opt_AnaSi.Value          = 1
        loc_oPg1.obj_4c_OptDatas.Value           = 1
        loc_oPg1.obj_4c_OptSaldos.Value          = 1
        loc_oPg1.obj_4c_OptAutorizados.Value     = 1
        loc_oPg1.obj_4c_Opt_Juros.Value          = 2
        loc_oPg1.chk_4c_Ck_Pagamentos.Value     = 0
        loc_oPg1.chk_4c_Ck_Recebimentos.Value   = 0
        THIS.HabObjs(.F.)
    ENDPROC

    *--------------------------------------------------------------------------
    * HabObjs - Habilita/desabilita controles conforme modo PagRec
    * par_lPagRec: .T. = modo pagamento/recebimento, .F. = modo normal
    *--------------------------------------------------------------------------
    PROCEDURE HabObjs(par_lPagRec)
        LOCAL loc_oPg1, loc_cLabel
        loc_oPg1   = THIS.pgf_4c_Paginas.Page1
        loc_cLabel = IIF(loc_oPg1.chk_4c_Ck_Pagamentos.Value = 1, ;
            "Pagamento:", "Recebimento:")
        loc_oPg1.txt_4c__Numes.Enabled     = par_lPagRec
        loc_oPg1.obj_4c_Opt_AnaSi.Enabled  = !par_lPagRec
        loc_oPg1.lbl_4c_LblPeriodo.Caption = IIF(par_lPagRec, loc_cLabel, "Vencimento :")
        loc_oPg1.obj_4c_Opt_Juros.Enabled  = !par_lPagRec
        loc_oPg1.txt_4c__Juros.Enabled     = !par_lPagRec
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere valores do formulario para o BO
    *--------------------------------------------------------------------------
    PROCEDURE FormParaRelatorio()
        LOCAL loc_oPg1, loc_oBO
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        loc_oBO  = THIS.this_oRelatorio

        loc_oBO.this_dDtInicial      = loc_oPg1.txt_4c_DtInicial.Value
        loc_oBO.this_dDtFinal        = loc_oPg1.txt_4c_DtFinal.Value
        loc_oBO.this_nOptAnaSi       = loc_oPg1.obj_4c_Opt_AnaSi.Value
        loc_oBO.this_nOptDatas       = loc_oPg1.obj_4c_OptDatas.Value
        loc_oBO.this_nOptSaldos      = loc_oPg1.obj_4c_OptSaldos.Value
        loc_oBO.this_nOptAutorizados = loc_oPg1.obj_4c_OptAutorizados.Value
        loc_oBO.this_nOptJuros       = loc_oPg1.obj_4c_Opt_Juros.Value
        loc_oBO.this_nJuros          = loc_oPg1.txt_4c__Juros.Value
        loc_oBO.this_nSaldo          = loc_oPg1.txt_4c_Saldo.Value
        loc_oBO.this_cGrupo          = PADR(ALLTRIM(loc_oPg1.txt_4c_Grupo.Value), 10)
        loc_oBO.this_cDGrupo         = ALLTRIM(loc_oPg1.txt_4c_DGrupo.Value)
        loc_oBO.this_cConta          = PADR(ALLTRIM(loc_oPg1.txt_4c_Conta.Value), 10)
        loc_oBO.this_cDConta         = ALLTRIM(loc_oPg1.txt_4c_DConta.Value)
        loc_oBO.this_cCdMoeda        = ALLTRIM(loc_oPg1.txt_4c__cd_moeda.Value)
        loc_oBO.this_cDsMoeda        = ALLTRIM(loc_oPg1.txt_4c__ds_moeda.Value)
        loc_oBO.this_cJobs           = PADR(ALLTRIM(loc_oPg1.txt_4c__Jobs.Value), 10)
        loc_oBO.this_cDJobs          = ALLTRIM(loc_oPg1.txt_4c_DJobs.Value)
        loc_oBO.this_nNumes          = loc_oPg1.txt_4c__Numes.Value
        loc_oBO.this_nPagamentos     = loc_oPg1.chk_4c_Ck_Pagamentos.Value
        loc_oBO.this_nRecebimentos   = loc_oPg1.chk_4c_Ck_Recebimentos.Value
    ENDPROC

    *==========================================================================
    * HANDLERS DE BOTOES
    *==========================================================================

    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        IF EMPTY(loc_oPg1.txt_4c_DtInicial.Value) OR ;
           EMPTY(loc_oPg1.txt_4c_DtFinal.Value)
            MsgAviso("Informe o per" + CHR(237) + "odo inicial e final.")
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        THIS.this_oRelatorio.Visualizar()
    ENDPROC

    PROCEDURE BtnImprimirClick()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        IF EMPTY(loc_oPg1.txt_4c_DtInicial.Value) OR ;
           EMPTY(loc_oPg1.txt_4c_DtFinal.Value)
            MsgAviso("Informe o per" + CHR(237) + "odo inicial e final.")
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        THIS.this_oRelatorio.Imprimir()
    ENDPROC

    PROCEDURE BtnGerarExcelClick()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        IF EMPTY(loc_oPg1.txt_4c_DtInicial.Value) OR ;
           EMPTY(loc_oPg1.txt_4c_DtFinal.Value)
            MsgAviso("Informe o per" + CHR(237) + "odo inicial e final.")
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        THIS.this_oRelatorio.ExportarExcel()
    ENDPROC

    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * HANDLERS CRUD (form REPORT - delegam para acoes equivalentes do relatorio)
    *==========================================================================

    PROCEDURE BtnIncluirClick()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        IF EMPTY(loc_oPg1.txt_4c_DtInicial.Value) OR ;
           EMPTY(loc_oPg1.txt_4c_DtFinal.Value)
            MsgAviso("Informe o per" + CHR(237) + "odo inicial e final.")
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        THIS.this_oRelatorio.Visualizar()
    ENDPROC

    PROCEDURE BtnAlterarClick()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        IF EMPTY(loc_oPg1.txt_4c_DtInicial.Value) OR ;
           EMPTY(loc_oPg1.txt_4c_DtFinal.Value)
            MsgAviso("Informe o per" + CHR(237) + "odo inicial e final.")
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        THIS.this_oRelatorio.Imprimir()
    ENDPROC

    PROCEDURE BtnExcluirClick()
        THIS.LimparCampos()
        THIS.pgf_4c_Paginas.Page1.txt_4c_DtInicial.SetFocus()
    ENDPROC

    *==========================================================================
    * HANDLERS MARCAR/DESMARCAR TODOS (checkboxes acima de cada grid)
    *==========================================================================

    PROCEDURE MarcaEmpClick()
        LOCAL loc_nImps
        loc_nImps = IIF(THIS.pgf_4c_Paginas.Page1.chk_4c_Ck_MarcaEmp.Value = 1, 1, 0)
        REPLACE ALL Imps WITH loc_nImps IN cursor_4c_SigCdEmp
        THIS.pgf_4c_Paginas.Page1.grd_4c_Emps.Refresh()
    ENDPROC

    PROCEDURE MarcaOpeClick()
        LOCAL loc_nImps
        loc_nImps = IIF(THIS.pgf_4c_Paginas.Page1.chk_4c_Ck_MarcaOpe.Value = 1, 1, 0)
        REPLACE ALL Imps WITH loc_nImps IN cursor_4c_SigOpOpe
        THIS.pgf_4c_Paginas.Page1.grd_4c_Tipo.Refresh()
    ENDPROC

    PROCEDURE MarcaClaClick()
        LOCAL loc_nImps
        loc_nImps = IIF(THIS.pgf_4c_Paginas.Page1.chk_4c_Ck_MarcaCla.Value = 1, 1, 0)
        REPLACE ALL Imps WITH loc_nImps IN cursor_4c_SigCdClc
        THIS.pgf_4c_Paginas.Page1.grd_4c_Cla.Refresh()
    ENDPROC

    *==========================================================================
    * HANDLERS CHECKBOX DO GRID EMPRESAS
    *==========================================================================

    PROCEDURE EmpCheckMouseDown(par_nButton, par_nShift, par_nX, par_nY)
        LOCAL loc_nImps
        loc_nImps = IIF(cursor_4c_SigCdEmp.Imps = 0, 1, 0)
        REPLACE Imps WITH loc_nImps IN cursor_4c_SigCdEmp
        THIS.pgf_4c_Paginas.Page1.grd_4c_Emps.Refresh()
        NODEFAULT
    ENDPROC

    PROCEDURE EmpCheckMouseUp(par_nButton, par_nShift, par_nX, par_nY)
        NODEFAULT
    ENDPROC

    PROCEDURE EmpCheckClick()
        NODEFAULT
    ENDPROC

    PROCEDURE EmpCheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32)
            LOCAL loc_nImps
            loc_nImps = IIF(cursor_4c_SigCdEmp.Imps = 1, 0, 1)
            REPLACE Imps WITH loc_nImps IN cursor_4c_SigCdEmp
            THIS.pgf_4c_Paginas.Page1.grd_4c_Emps.Refresh()
            NODEFAULT
        ENDIF
    ENDPROC

    *==========================================================================
    * HANDLERS CHECKBOX DO GRID TIPO (OPERACOES)
    *==========================================================================

    PROCEDURE TipoCheckMouseDown(par_nButton, par_nShift, par_nX, par_nY)
        LOCAL loc_nImps
        loc_nImps = IIF(cursor_4c_SigOpOpe.Imps = 0, 1, 0)
        REPLACE Imps WITH loc_nImps IN cursor_4c_SigOpOpe
        THIS.pgf_4c_Paginas.Page1.grd_4c_Tipo.Refresh()
        NODEFAULT
    ENDPROC

    PROCEDURE TipoCheckMouseUp(par_nButton, par_nShift, par_nX, par_nY)
        NODEFAULT
    ENDPROC

    PROCEDURE TipoCheckClick()
        NODEFAULT
    ENDPROC

    PROCEDURE TipoCheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32)
            LOCAL loc_nImps
            loc_nImps = IIF(cursor_4c_SigOpOpe.Imps = 1, 0, 1)
            REPLACE Imps WITH loc_nImps IN cursor_4c_SigOpOpe
            THIS.pgf_4c_Paginas.Page1.grd_4c_Tipo.Refresh()
            NODEFAULT
        ENDIF
    ENDPROC

    *==========================================================================
    * HANDLERS CHECKBOX DO GRID CLASSIFICACOES
    *==========================================================================

    PROCEDURE ClaCheckMouseDown(par_nButton, par_nShift, par_nX, par_nY)
        LOCAL loc_nImps
        loc_nImps = IIF(cursor_4c_SigCdClc.Imps = 0, 1, 0)
        REPLACE Imps WITH loc_nImps IN cursor_4c_SigCdClc
        THIS.pgf_4c_Paginas.Page1.grd_4c_Cla.Refresh()
        NODEFAULT
    ENDPROC

    PROCEDURE ClaCheckMouseUp(par_nButton, par_nShift, par_nX, par_nY)
        NODEFAULT
    ENDPROC

    PROCEDURE ClaCheckClick()
        NODEFAULT
    ENDPROC

    PROCEDURE ClaCheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32)
            LOCAL loc_nImps
            loc_nImps = IIF(cursor_4c_SigCdClc.Imps = 1, 0, 1)
            REPLACE Imps WITH loc_nImps IN cursor_4c_SigCdClc
            THIS.pgf_4c_Paginas.Page1.grd_4c_Cla.Refresh()
            NODEFAULT
        ENDIF
    ENDPROC

    *==========================================================================
    * HANDLERS MODO PAGREC E JUROS
    *==========================================================================

    PROCEDURE PagamentosChange()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        IF loc_oPg1.chk_4c_Ck_Pagamentos.Value = 1
            loc_oPg1.chk_4c_Ck_Recebimentos.Value = 0
        ENDIF
        THIS.HabObjs((loc_oPg1.chk_4c_Ck_Pagamentos.Value = 1) OR ;
            (loc_oPg1.chk_4c_Ck_Recebimentos.Value = 1))
    ENDPROC

    PROCEDURE RecebimentosChange()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        IF loc_oPg1.chk_4c_Ck_Recebimentos.Value = 1
            loc_oPg1.chk_4c_Ck_Pagamentos.Value = 0
        ENDIF
        THIS.HabObjs((loc_oPg1.chk_4c_Ck_Pagamentos.Value = 1) OR ;
            (loc_oPg1.chk_4c_Ck_Recebimentos.Value = 1))
    ENDPROC

    PROCEDURE JurosOptClick()
        IF THIS.pgf_4c_Paginas.Page1.obj_4c_Opt_Juros.Value = 2
            THIS.pgf_4c_Paginas.Page1.txt_4c__Juros.Value = 0
        ENDIF
    ENDPROC

    FUNCTION JurosWhen()
        RETURN (THIS.pgf_4c_Paginas.Page1.obj_4c_Opt_Juros.Value = 1)
    ENDFUNC

    *==========================================================================
    * LOOKUP MOEDA
    *==========================================================================

    PROCEDURE TxtMoedaCdKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR ;
           par_nKeyCode = 115 OR par_nKeyCode = 116
            LOCAL loc_cValor, loc_nRes, loc_nCotacao
            loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c__cd_moeda.Value)
            IF EMPTY(loc_cValor)
                THIS.pgf_4c_Paginas.Page1.txt_4c__ds_moeda.Value = ""
                THIS.this_oRelatorio.this_nVlCotacao = 1
            ELSE
                IF SEEK(loc_cValor, "cursor_4c_SigCdMoe", "CMoes")
                    THIS.pgf_4c_Paginas.Page1.txt_4c__cd_moeda.Value = ALLTRIM(cursor_4c_SigCdMoe.CMoes)
                    THIS.pgf_4c_Paginas.Page1.txt_4c__ds_moeda.Value = ALLTRIM(cursor_4c_SigCdMoe.DMoes)
                    loc_nCotacao = THIS.this_oRelatorio.BuscarCambio(loc_cValor)
                    THIS.this_oRelatorio.this_nVlCotacao = IIF(loc_nCotacao = 0, 1, loc_nCotacao)
                ELSE
                    THIS.AbrirBuscaMoeda()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    FUNCTION MoedaDsWhen()
        RETURN EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c__cd_moeda.Value)
    ENDFUNC

    PROCEDURE TxtMoedaDsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR ;
           par_nKeyCode = 115 OR par_nKeyCode = 116
            LOCAL loc_cValor
            loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c__ds_moeda.Value)
            IF EMPTY(loc_cValor)
                THIS.pgf_4c_Paginas.Page1.txt_4c__cd_moeda.Value = ""
                THIS.pgf_4c_Paginas.Page1.txt_4c__ds_moeda.Value = ""
            ELSE
                THIS.AbrirBuscaMoeda()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaMoeda()
        LOCAL loc_oForm, loc_cValor, loc_cMoedaSel, loc_nCotacao
        loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c__cd_moeda.Value)
        IF EMPTY(loc_cValor)
            loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c__ds_moeda.Value)
        ENDIF

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdMoe", "cursor_4c_BuscaMoeda", "CMoes", loc_cValor, ;
            "Busca de Moeda")
        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF

        IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
            THIS.pgf_4c_Paginas.Page1.txt_4c__cd_moeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.CMoes)
            THIS.pgf_4c_Paginas.Page1.txt_4c__ds_moeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.DMoes)
            loc_cMoedaSel = ALLTRIM(cursor_4c_BuscaMoeda.CMoes)
            loc_nCotacao  = THIS.this_oRelatorio.BuscarCambio(loc_cMoedaSel)
            THIS.this_oRelatorio.this_nVlCotacao = IIF(loc_nCotacao = 0, 1, loc_nCotacao)
        ELSE
            IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou
                THIS.pgf_4c_Paginas.Page1.txt_4c__cd_moeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.CMoes)
                THIS.pgf_4c_Paginas.Page1.txt_4c__ds_moeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.DMoes)
                loc_cMoedaSel = ALLTRIM(cursor_4c_BuscaMoeda.CMoes)
                loc_nCotacao  = THIS.this_oRelatorio.BuscarCambio(loc_cMoedaSel)
                THIS.this_oRelatorio.this_nVlCotacao = IIF(loc_nCotacao = 0, 1, loc_nCotacao)
            ELSE
                THIS.pgf_4c_Paginas.Page1.txt_4c__cd_moeda.Value = ""
                THIS.pgf_4c_Paginas.Page1.txt_4c__ds_moeda.Value = ""
                THIS.this_oRelatorio.this_nVlCotacao = 1
            ENDIF
            ENDIF
        ENDIF

        IF USED("cursor_4c_BuscaMoeda")
            USE IN cursor_4c_BuscaMoeda
        ENDIF
        loc_oForm.Release()
    ENDPROC

    *==========================================================================
    * LOOKUP GRUPO / DGRUPO
    *==========================================================================

    PROCEDURE TxtGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR ;
           par_nKeyCode = 115 OR par_nKeyCode = 116
            LOCAL loc_cValor, loc_nRes
            loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value)
            IF EMPTY(loc_cValor)
                THIS.pgf_4c_Paginas.Page1.txt_4c_DGrupo.Value = ""
            ELSE
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cValor), ;
                    "cursor_4c_ValidaGrupo")
                IF loc_nRes > 0 AND !EOF("cursor_4c_ValidaGrupo")
                    THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_ValidaGrupo.Codigos)
                    THIS.pgf_4c_Paginas.Page1.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_ValidaGrupo.Descrs)
                ELSE
                    THIS.AbrirBuscaGrupo()
                ENDIF
                IF USED("cursor_4c_ValidaGrupo")
                    USE IN cursor_4c_ValidaGrupo
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    FUNCTION DGrupoWhen()
        RETURN EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value)
    ENDFUNC

    PROCEDURE TxtDGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR ;
           par_nKeyCode = 115 OR par_nKeyCode = 116
            LOCAL loc_cValor
            loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DGrupo.Value)
            IF EMPTY(loc_cValor)
                THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value = ""
            ELSE
                THIS.AbrirBuscaGrupo()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaGrupo()
        LOCAL loc_oForm, loc_cValor
        loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value)

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", loc_cValor, ;
            "Busca de Grupo Cont" + CHR(225) + "bil")
        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF

        IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
            THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
            THIS.pgf_4c_Paginas.Page1.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Descrs)
        ELSE
            IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou
                THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
                THIS.pgf_4c_Paginas.Page1.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Descrs)
            ELSE
                THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value  = ""
                THIS.pgf_4c_Paginas.Page1.txt_4c_DGrupo.Value = ""
            ENDIF
            ENDIF
        ENDIF

        IF USED("cursor_4c_BuscaGrupo")
            USE IN cursor_4c_BuscaGrupo
        ENDIF
        loc_oForm.Release()
    ENDPROC

    *==========================================================================
    * LOOKUP CONTA / DCONTA
    *==========================================================================

    PROCEDURE TxtContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR ;
           par_nKeyCode = 115 OR par_nKeyCode = 116
            LOCAL loc_cValor, loc_cGrupo, loc_nRes, loc_cSQL
            loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Conta.Value)
            IF EMPTY(loc_cValor)
                THIS.pgf_4c_Paginas.Page1.txt_4c_DConta.Value = ""
            ELSE
                loc_cGrupo = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Grupo.Value)
                loc_cSQL   = "SELECT IClis, RClis FROM SigCdCli WHERE IClis = " + ;
                    EscaparSQL(PADR(loc_cValor, 10))
                IF !EMPTY(loc_cGrupo)
                    loc_cSQL = loc_cSQL + " AND Grupos = " + EscaparSQL(loc_cGrupo)
                ENDIF
                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaConta")
                IF loc_nRes > 0 AND !EOF("cursor_4c_ValidaConta")
                    THIS.pgf_4c_Paginas.Page1.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_ValidaConta.IClis)
                    THIS.pgf_4c_Paginas.Page1.txt_4c_DConta.Value = ALLTRIM(cursor_4c_ValidaConta.RClis)
                ELSE
                    THIS.AbrirBuscaConta()
                ENDIF
                IF USED("cursor_4c_ValidaConta")
                    USE IN cursor_4c_ValidaConta
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    FUNCTION DContaWhen()
        RETURN EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c_Conta.Value)
    ENDFUNC

    PROCEDURE TxtDContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR ;
           par_nKeyCode = 115 OR par_nKeyCode = 116
            LOCAL loc_cValor
            loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DConta.Value)
            IF EMPTY(loc_cValor)
                THIS.pgf_4c_Paginas.Page1.txt_4c_Conta.Value = ""
            ELSE
                THIS.AbrirBuscaConta()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaConta()
        LOCAL loc_oForm, loc_cValor
        loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Conta.Value)

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", "cursor_4c_BuscaConta", "IClis", loc_cValor, ;
            "Busca de Conta")
        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF

        IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
            THIS.pgf_4c_Paginas.Page1.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
            THIS.pgf_4c_Paginas.Page1.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
        ELSE
            IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("RClis", "", "Nome")
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou
                THIS.pgf_4c_Paginas.Page1.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
                THIS.pgf_4c_Paginas.Page1.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
            ELSE
                THIS.pgf_4c_Paginas.Page1.txt_4c_Conta.Value  = ""
                THIS.pgf_4c_Paginas.Page1.txt_4c_DConta.Value = ""
            ENDIF
            ENDIF
        ENDIF

        IF USED("cursor_4c_BuscaConta")
            USE IN cursor_4c_BuscaConta
        ENDIF
        loc_oForm.Release()
    ENDPROC

    *==========================================================================
    * LOOKUP JOBS / DJOBS
    *==========================================================================

    PROCEDURE TxtJobsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR ;
           par_nKeyCode = 115 OR par_nKeyCode = 116
            LOCAL loc_cValor, loc_nRes
            loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c__Jobs.Value)
            IF EMPTY(loc_cValor)
                THIS.pgf_4c_Paginas.Page1.txt_4c_DJobs.Value = ""
            ELSE
                loc_nRes = SQLEXEC(gnConnHandle, ;
                    "SELECT IClis, RClis FROM SigCdCli WHERE IClis = " + ;
                    EscaparSQL(PADR(loc_cValor, 10)), ;
                    "cursor_4c_ValidaJobs")
                IF loc_nRes > 0 AND !EOF("cursor_4c_ValidaJobs")
                    THIS.pgf_4c_Paginas.Page1.txt_4c__Jobs.Value = ALLTRIM(cursor_4c_ValidaJobs.IClis)
                    THIS.pgf_4c_Paginas.Page1.txt_4c_DJobs.Value = ALLTRIM(cursor_4c_ValidaJobs.RClis)
                ELSE
                    THIS.AbrirBuscaJobs()
                ENDIF
                IF USED("cursor_4c_ValidaJobs")
                    USE IN cursor_4c_ValidaJobs
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    FUNCTION DJobsWhen()
        RETURN EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c__Jobs.Value)
    ENDFUNC

    PROCEDURE TxtDJobsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR ;
           par_nKeyCode = 115 OR par_nKeyCode = 116
            LOCAL loc_cValor
            loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DJobs.Value)
            IF EMPTY(loc_cValor)
                THIS.pgf_4c_Paginas.Page1.txt_4c__Jobs.Value = ""
            ELSE
                THIS.AbrirBuscaJobs()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaJobs()
        LOCAL loc_oForm, loc_cValor
        loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c__Jobs.Value)

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", "cursor_4c_BuscaJobs", "IClis", loc_cValor, ;
            "Busca de Job")
        IF VARTYPE(loc_oForm) != "O"
            RETURN
        ENDIF

        IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
            THIS.pgf_4c_Paginas.Page1.txt_4c__Jobs.Value = ALLTRIM(cursor_4c_BuscaJobs.IClis)
            THIS.pgf_4c_Paginas.Page1.txt_4c_DJobs.Value = ALLTRIM(cursor_4c_BuscaJobs.RClis)
        ELSE
            IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("RClis", "", "Nome")
            loc_oForm.Show()
            IF loc_oForm.this_lSelecionou
                THIS.pgf_4c_Paginas.Page1.txt_4c__Jobs.Value = ALLTRIM(cursor_4c_BuscaJobs.IClis)
                THIS.pgf_4c_Paginas.Page1.txt_4c_DJobs.Value = ALLTRIM(cursor_4c_BuscaJobs.RClis)
            ELSE
                THIS.pgf_4c_Paginas.Page1.txt_4c__Jobs.Value = ""
                THIS.pgf_4c_Paginas.Page1.txt_4c_DJobs.Value = ""
            ENDIF
            ENDIF
        ENDIF

        IF USED("cursor_4c_BuscaJobs")
            USE IN cursor_4c_BuscaJobs
        ENDIF
        loc_oForm.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura conteudo de Page1 (grids de selecao)
    * Em forms REPORT, Page1 hospeda os filtros e os 3 grids de selecao
    * (Empresas, Operacoes, Classificacoes). Esta procedure encapsula a
    * configuracao desses grids, delegando para ConfigurarGrids().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        THIS.ConfigurarGrids()
        loc_oPg1.grd_4c_Emps.Visible    = .T.
        loc_oPg1.grd_4c_Tipo.Visible    = .T.
        loc_oPg1.grd_4c_Cla.Visible     = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura conteudo de pagina de dados
    * Em forms REPORT (frmrelatorio) NAO existe Page2 (Dados): todos os
    * filtros estao em Page1 e ja foram configurados por ConfigurarFiltros().
    * Este metodo existe para manter compatibilidade com a API de forms CRUD
    * e satisfaz validacoes do pipeline de migracao multi-fase.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- Form REPORT usa layout FLAT com apenas Page1 contendo todos os filtros.
        *-- Os campos de filtro sao adicionados em ConfigurarFiltros() que ja foi
        *-- chamado durante InicializarForm(). Portanto nao ha controles adicionais
        *-- a configurar nesta pagina.
        IF THIS.pgf_4c_Paginas.PageCount >= 1
            THIS.pgf_4c_Paginas.Page1.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Define a pagina ativa do PageFrame
    * Em forms REPORT este form usa uma unica pagina (Page1) que contem
    * todos os filtros e grids. Mantido por compatibilidade com a API de
    * forms de cadastro.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina
        loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)
        IF loc_nPagina < 1 OR loc_nPagina > THIS.pgf_4c_Paginas.PageCount
            loc_nPagina = 1
        ENDIF
        THIS.pgf_4c_Paginas.ActivePage = loc_nPagina
        THIS.pgf_4c_Paginas.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Para forms REPORT: equivale a Visualizar (preview)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        IF EMPTY(loc_oPg1.txt_4c_DtInicial.Value) OR ;
           EMPTY(loc_oPg1.txt_4c_DtFinal.Value)
            MsgAviso("Informe o per" + CHR(237) + "odo inicial e final.")
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        THIS.this_oRelatorio.Visualizar()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Para forms REPORT: equivale a Imprimir
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        IF EMPTY(loc_oPg1.txt_4c_DtInicial.Value) OR ;
           EMPTY(loc_oPg1.txt_4c_DtFinal.Value)
            MsgAviso("Informe o per" + CHR(237) + "odo inicial e final.")
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        THIS.this_oRelatorio.Imprimir()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Para forms REPORT: delega para FormParaRelatorio
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Para forms REPORT: grids ja carregados em CarregarCursores
    * Filtros de tela nao precisam ser recarregados a partir do BO.
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            THIS.pgf_4c_Paginas.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita todos os filtros; aplica regra PagRec via HabObjs
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos()
        LOCAL loc_oPg1, loc_lPagRec
        loc_oPg1    = THIS.pgf_4c_Paginas.Page1
        loc_lPagRec = (loc_oPg1.chk_4c_Ck_Pagamentos.Value = 1) OR ;
                      (loc_oPg1.chk_4c_Ck_Recebimentos.Value = 1)
        loc_oPg1.txt_4c_DtInicial.Enabled         = .T.
        loc_oPg1.txt_4c_DtFinal.Enabled           = .T.
        loc_oPg1.txt_4c_Saldo.Enabled             = .T.
        loc_oPg1.txt_4c_Grupo.Enabled             = .T.
        loc_oPg1.txt_4c_DGrupo.Enabled            = .T.
        loc_oPg1.txt_4c_Conta.Enabled             = .T.
        loc_oPg1.txt_4c_DConta.Enabled            = .T.
        loc_oPg1.txt_4c__cd_moeda.Enabled         = .T.
        loc_oPg1.txt_4c__ds_moeda.Enabled         = .T.
        loc_oPg1.txt_4c__Jobs.Enabled             = .T.
        loc_oPg1.txt_4c_DJobs.Enabled             = .T.
        loc_oPg1.obj_4c_OptDatas.Enabled          = .T.
        loc_oPg1.obj_4c_OptSaldos.Enabled         = .T.
        loc_oPg1.obj_4c_OptAutorizados.Enabled    = .T.
        loc_oPg1.chk_4c_Ck_Pagamentos.Enabled    = .T.
        loc_oPg1.chk_4c_Ck_Recebimentos.Enabled  = .T.
        THIS.HabObjs(loc_lPagRec)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Para forms REPORT: cursores ja carregados em CarregarCursores
    * Retorna .T. para compatibilidade com o ciclo de vida do FormBase
    *--------------------------------------------------------------------------
    FUNCTION CarregarLista()
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Para forms REPORT: botoes sempre habilitados
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        IF VARTYPE(THIS.cnt_4c_Cabecalho) = "O"
            WITH THIS.cnt_4c_Cabecalho.cmg_4c_Botoes
                .Buttons(1).Enabled = .T.
                .Buttons(2).Enabled = .T.
                .Buttons(3).Enabled = .T.
                .Buttons(4).Enabled = .T.
            ENDWITH
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera referencia ao BO e cursores da sessao privada
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigreappBO.prg):
*==============================================================================
* SIGREAPPBO.PRG
* Business Object para Relatorio de Analise a Pagar / Receber
*
* Herda de: RelatorioBase
* Formulario origem: SIGREAPP.SCX (frmrelatorio)
*==============================================================================

DEFINE CLASS sigreappBO AS RelatorioBase

    *-- Filtros de data
    this_dDtInicial     = {}
    this_dDtFinal       = {}

    *-- Filtros de tipo de analise
    this_nOptAnaSi      = 1     && 1=Analitico, 2=Sintetico, 3=Fluxo de Caixa
    this_nOptDatas      = 1     && 1=Vencimento, 2=Emissao, 3=Lancamento
    this_nOptSaldos     = 1     && 1=Informado, 2=Data Inicial, 3=Data Atual
    this_nOptAutorizados = 1    && 1=Todos, 2=Autorizados, 3=Nao Autorizados
    this_nOptJuros      = 2     && 1=Sim, 2=Nao

    *-- Filtros de grupo contabil
    this_cGrupo         = ""    && Codigo do grupo (MaxLength=10)
    this_cDGrupo        = ""    && Descricao do grupo (MaxLength=20)

    *-- Filtros de conta contabil
    this_cConta         = ""    && Codigo da conta (MaxLength=10)
    this_cDConta        = ""    && Descricao da conta (MaxLength=40)

    *-- Filtro de numero de operacao
    this_nNumes         = 0     && Numero da operacao (0=todos)

    *-- Filtro de juros
    this_nJuros         = 0     && Taxa de juros % mes (InputMask=99.99)

    *-- Filtros de pagamento/recebimento
    this_nPagamentos    = 0     && CheckBox value: 0=desmarcado, 1=marcado
    this_nRecebimentos  = 0     && CheckBox value: 0=desmarcado, 1=marcado

    *-- Filtro de saldo inicial
    this_nSaldo         = 0     && Saldo inicial informado

    *-- Filtros de moeda
    this_cCdMoeda       = ""    && Codigo da moeda (MaxLength=3)
    this_cDsMoeda       = ""    && Descricao da moeda (MaxLength=15)

    *-- Filtros de Job (centro de custo)
    this_cJobs          = ""    && Codigo do job (MaxLength=10, padded)
    this_cDJobs         = ""    && Descricao do job (MaxLength=40)

    *-- Propriedades de runtime (estado interno)
    this_nVlCotacao     = 1     && Taxa de cotacao da moeda selecionada
    this_cSaldos1       = ""    && Label do saldo para cabecalho do relatorio
    this_cSaldos2       = ""    && Valor do saldo para cabecalho do relatorio

    *--------------------------------------------------------------------------
    * Init - Inicializa BO com valores padrao dos filtros
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF !DODEFAULT()
                loc_lSucesso = .F.
            ENDIF

            *-- Valores padrao identicos ao Init() original do SIGREAPP
            THIS.this_dDtInicial     = DATE()
            THIS.this_dDtFinal       = DATE()
            THIS.this_nNumes         = 0
            THIS.this_nVlCotacao     = 1
            THIS.this_nOptAnaSi      = 1
            THIS.this_nOptDatas      = 1
            THIS.this_nOptSaldos     = 1
            THIS.this_nOptAutorizados = 1
            THIS.this_nOptJuros      = 2  && Default: Nao calcular juros
            THIS.this_nJuros         = 0
            THIS.this_nPagamentos    = 0
            THIS.this_nRecebimentos  = 0
            THIS.this_nSaldo         = 0
            THIS.this_cCdMoeda       = ""
            THIS.this_cDsMoeda       = ""
            THIS.this_cGrupo         = ""
            THIS.this_cDGrupo        = ""
            THIS.this_cConta         = ""
            THIS.this_cDConta        = ""
            THIS.this_cJobs          = ""
            THIS.this_cDJobs         = ""
            THIS.this_cSaldos1       = ""
            THIS.this_cSaldos2       = ""

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos e cursores temporarios do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL ARRAY loc_aCursores[16]
        LOCAL loc_nI

        loc_aCursores[1]  = "crCabecalho"
        loc_aCursores[2]  = "crDados"
        loc_aCursores[3]  = "crDados1"
        loc_aCursores[4]  = "crDados2"
        loc_aCursores[5]  = "crDados3"
        loc_aCursores[6]  = "crRel"
        loc_aCursores[7]  = "crEmps"
        loc_aCursores[8]  = "crProcessar"
        loc_aCursores[9]  = "crPrevs"
        loc_aCursores[10] = "LocalPrev"
        loc_aCursores[11] = "LocalSaldos"
        loc_aCursores[12] = "crTmpPar"
        loc_aCursores[13] = "crTmpPrIt"
        loc_aCursores[14] = "crTmpPrBx"
        loc_aCursores[15] = "crTmpMccr"
        loc_aCursores[16] = "crParcPag"

        FOR loc_nI = 1 TO 16
            IF USED(loc_aCursores[loc_nI])
                USE IN (loc_aCursores[loc_nI])
            ENDIF
        ENDFOR

        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro
    *--------------------------------------------------------------------------
    FUNCTION ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarCambio - Busca taxa de cambio (substitui fBuscarCambio legado)
    * par_cMoeda: codigo da moeda (3 chars); retorna taxa ou 1 se nao encontrar
    *--------------------------------------------------------------------------
    FUNCTION BuscarCambio(par_cMoeda)
        LOCAL loc_cChave

        IF EMPTY(par_cMoeda) OR PADR(ALLTRIM(par_cMoeda), 3) = SPACE(3)
            RETURN 1
        ENDIF

        IF USED("cursor_4c_SigCdCot")
            loc_cChave = PADR(ALLTRIM(par_cMoeda), 3) + DTOS(DATE())
            IF SEEK(loc_cChave, "cursor_4c_SigCdCot", "CMoeData")
                RETURN cursor_4c_SigCdCot.Valos
            ENDIF
        ENDIF

        RETURN 1
    ENDFUNC

    *--------------------------------------------------------------------------
    * NCalcJuros - Calcula juros compostos sobre valor vencido
    * par_ldDataVenc: data de vencimento (Date)
    * par_nVlrBase : valor base para calculo
    *--------------------------------------------------------------------------
    FUNCTION NCalcJuros(par_ldDataVenc, par_nVlrBase)
        LOCAL loc_nVlrJuros, loc_nDias, loc_nJurosDia

        loc_nVlrJuros = 0

        IF THIS.this_nJuros <= 0 OR THIS.this_nOptJuros <> 1
            RETURN 0
        ENDIF

        loc_nJurosDia = ROUND((((1 + THIS.this_nJuros / 100) ^ (1/30)) - 1) * 100, 9)

        IF par_ldDataVenc < DATE()
            loc_nDias = DATE() - par_ldDataVenc
            loc_nVlrJuros = ROUND(par_nVlrBase * (((1 + loc_nJurosDia / 100) ^ (loc_nDias)) - 1), 2)
        ENDIF

        RETURN loc_nVlrJuros
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscaSaldos - Busca saldos iniciais de contas contabeis
    * Retorna: saldo total acumulado (numeric)
    * Efeito colateral: preenche this_cSaldos1 e this_cSaldos2
    *--------------------------------------------------------------------------
    FUNCTION BuscaSaldos()
        LOCAL loc_cQuery, loc_nResult, loc_nRet, loc_cDataPat, loc_ldData

        loc_nRet = 0
        THIS.this_cSaldos1 = "Saldo Inicial :" + CHR(13)
        THIS.this_cSaldos2 = " " + CHR(13)

        TRY
            loc_ldData   = IIF(THIS.this_nOptSaldos = 2, THIS.this_dDtInicial, DATE())
            loc_cDataPat = "'" + DTOS(loc_ldData) + " 23:59:59'"

            loc_cQuery = "Select c.Grupos, c.Contas, d.RClis, c.Datas, c.Saldos " + ;
                         "From SigMvCcr c, SigCdCli d " + ;
                         "Where c.cIdChaves In (" + ;
                         "Select Max(b.cIdChaves) as cIdChaves " + ;
                         "From SigCdGcr a, SigMvCcr b " + ;
                         "Where a.Coletors = 11 And " + ;
                         "a.Codigos = b.Grupos And " + ;
                         "b.Datas <= " + loc_cDataPat + " " + ;
                         "Group By b.Grupos, b.Contas) And " + ;
                         "c.Contas = d.IClis And " + ;
                         "Not c.Saldos = 0"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "LocalSaldos")
            IF loc_nResult < 1
                MsgErro("Favor Reinicializar o Processo!!!", ;
                        "Falha na Conex" + CHR(227) + CHR(227) + "o (LocalSaldos)")
                loc_lResultado = 0
            ENDIF

            SELECT LocalSaldos
            GO TOP IN LocalSaldos
            IF EOF("LocalSaldos")
                THIS.this_cSaldos1 = "Saldo Inicial :"
                THIS.this_cSaldos2 = "0,00 (Nenhuma Conta Com Saldo Configurada Nos Grupos de Contas)"
            ELSE
                SCAN
                    THIS.this_cSaldos1 = THIS.this_cSaldos1 + ;
                                         TRANSFORM(LocalSaldos.Saldos, "9,999,999,999.99") + ;
                                         " = " + CHR(13)
                    THIS.this_cSaldos2 = THIS.this_cSaldos2 + ;
                                         ALLTRIM(LocalSaldos.Contas) + ;
                                         " / " + ALLTRIM(LocalSaldos.RClis) + CHR(13)
                    loc_nRet = loc_nRet + LocalSaldos.Saldos
                ENDSCAN
            ENDIF
            USE IN LocalSaldos

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_nRet
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessaPagRec - Prepara dados para relatorio de Pagamentos/Recebimentos
    * Chamado por PrepararDados() quando this_nPagamentos=1 ou this_nRecebimentos=1
    *--------------------------------------------------------------------------
    PROCEDURE ProcessaPagRec()
        LOCAL loc_lSucesso, loc_cDopes, loc_cQuery, loc_nResult
        LOCAL loc_ldDataIni, loc_ldDataFin, loc_cGrupo, loc_cConta, loc_nCodOper
        LOCAL loc_cDataIni, loc_cDataFin, loc_cEmpresa, loc_cTitulo, loc_cPeriodo
        LOCAL loc_lcEDN

        loc_lSucesso = .F.

        TRY
            loc_cDopes    = PADR(IIF(THIS.this_nPagamentos = 1, "PAGAMENTO", "RECEBIMENTO"), 20)
            loc_ldDataIni = THIS.this_dDtInicial
            loc_ldDataFin = THIS.this_dDtFinal
            loc_cGrupo    = ALLTRIM(THIS.this_cGrupo)
            loc_cConta    = ALLTRIM(THIS.this_cConta)
            loc_nCodOper  = THIS.this_nNumes

            loc_cDataIni = "'" + DTOS(loc_ldDataIni) + "'"
            loc_cDataFin = "'" + DTOS(loc_ldDataFin) + " 23:59:59'"

            CREATE CURSOR crDados(Vencs d(8), Emps c(3), Numes n(6), Datas d(8), ;
                                  Titulos c(10), Debito n(12,2), Credito n(12,2), ;
                                  Acerto n(12,2), Moeda c(3), Hists c(100), ;
                                  Hist2s c(40), CondPag m(4), VlrPago m(4), nTotPago n(12,2))
            INDEX ON Emps + STR(Numes, 6) TAG OrdRel

            IF loc_nCodOper <= 0
                loc_cQuery = "Select a.Emps, a.Numes, a.EmpDopNums, a.DataRcs, a.Dopes " + ;
                             "from SigCdPgr a " + ;
                             "Inner Join SigCdPgc b on b.EmpDopNums = a.EmpDopNums " + ;
                             "where a.Dopes = " + EscaparSQL(loc_cDopes) + ;
                             " and a.DataRcs between " + loc_cDataIni + " and " + loc_cDataFin + ;
                             " And b.Grupos = '" + loc_cGrupo + "'" + ;
                             IIF(!EMPTY(loc_cConta), " And b.Contas = '" + loc_cConta + "'", "") + ;
                             " Order by a.EmpDopNums"
            ELSE
                loc_cQuery = "Select Emps, Numes, EmpDopNums, DataRcs, Dopes " + ;
                             "from SigCdPgr where Dopes = " + EscaparSQL(loc_cDopes) + ;
                             " and Numes = " + STR(loc_nCodOper, 6)
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "crDados1")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + CHR(227) + "o (crDados1)"
                MsgErro(THIS.this_cMensagemErro, "Erro")
                loc_lSucesso = .F.
            ENDIF

            CREATE CURSOR crCabecalho(Empresa c(80), Titulo c(80), Periodo c(80))

            loc_cEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa) + " - "
            IF USED("cursor_4c_SigCdEmp")
                IF SEEK(go_4c_Sistema.cCodEmpresa, "cursor_4c_SigCdEmp", "cEmps")
                    loc_cEmpresa = loc_cEmpresa + ALLTRIM(cursor_4c_SigCdEmp.Razas)
                ENDIF
            ENDIF

            loc_cTitulo = "Relat" + CHR(243) + "rio de An" + CHR(225) + "lise " + CHR(224) + ;
                          " Pagar/Receber - " + ;
                          IIF(loc_cDopes = PADR("PAGAMENTO", 20), "Pagamentos", "Recebimentos")

            IF loc_nCodOper <= 0
                loc_cPeriodo = IIF(loc_cDopes = PADR("PAGAMENTO", 20), "Pagamentos", "Recebimentos") + ;
                               " de : " + DTOC(loc_ldDataIni) + " " + CHR(224) + " " + DTOC(loc_ldDataFin)
                loc_cPeriodo = loc_cPeriodo + " - Grupo: " + ALLTRIM(loc_cGrupo) + ;
                               IIF(!EMPTY(loc_cConta), " - Conta: " + loc_cConta, "")
            ELSE
                loc_cPeriodo = IIF(loc_cDopes = PADR("PAGAMENTO", 20), "Pagamento", "Recebimento") + ;
                               ": N" + CHR(186) + " " + STR(loc_nCodOper, 6)
            ENDIF

            INSERT INTO crCabecalho(Empresa, Titulo, Periodo) ;
                             VALUES (loc_cEmpresa, loc_cTitulo, loc_cPeriodo)

            SELECT crDados1
            GO TOP IN crDados1
            SCAN
                loc_cQuery = "Select a.Acertos, a.Contas, a.Datas, a.Hists, a.Moedas, " + ;
                             "a.Nopers, a.Opers, a.Tipos, a.Valos, a.Vencs, a.Empos, b.RClis " + ;
                             "from SigCdPit a " + ;
                             "Inner Join SigCdCli b on b.Iclis = a.Contas " + ;
                             "Where EmpDopNums = '" + ALLTRIM(crDados1.EmpDopNums) + "'"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "crTmpPrIt")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (crTmpPrIt)"
                    MsgErro(THIS.this_cMensagemErro, "Erro")
                    loc_lSucesso = .F.
                ENDIF

                LOCAL loc_nValos, loc_nAcerto, loc_cMoeda, loc_cHists, loc_cHist2s
                LOCAL loc_ldVencs2, loc_cTitulo2
                loc_nValos   = 0
                loc_nAcerto  = 0
                loc_cMoeda   = ""
                loc_cHists   = ""
                loc_cHist2s  = ""
                loc_ldVencs2 = CTOD("")
                loc_cTitulo2 = ""

                loc_lcEDN = crDados1.Emps + crDados1.Dopes + STR(crDados1.Numes, 6)
                loc_cQuery = "Select Valos, VPags, Emps, Dopes, Numes, FPags, MoeFpgs, Vencs " + ;
                             "from SigMvPar where EmpDopNums = '" + ALLTRIM(loc_lcEDN) + "'"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "crParcPag")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (crParcPag)"
                    MsgErro(THIS.this_cMensagemErro, "Erro")
                    loc_lSucesso = .F.
                ENDIF
                SELECT crParcPag

                SELECT crTmpPrIt
                SCAN
                    IF loc_nCodOper <= 0 AND !EMPTY(loc_cConta) AND loc_cConta <> crTmpPrIt.Contas
                        LOOP
                    ENDIF

                    loc_cQuery = "Select Valors, ValPags, Moedas, Hists, Hist2s, Vencs, Titulos " + ;
                                 "from SigMvCcr where Emps = '" + ALLTRIM(crTmpPrIt.Empos) + "'" + ;
                                 " and Nopers = " + STR(crTmpPrIt.Nopers, 9)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "crTmpMccr")
                    IF loc_nResult < 1
                        THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (crTmpMccr)"
                        MsgErro(THIS.this_cMensagemErro, "Erro")
                        loc_lSucesso = .F.
                    ENDIF

                    loc_cQuery = "Select Valos, VPags, Emps, Dopes, Numes, FPags, MoeFpgs, Vencs " + ;
                                 "from SigMvPar where Emps = '" + ALLTRIM(crTmpPrIt.Empos) + "'" + ;
                                 " and Nopers = " + STR(crTmpPrIt.Nopers, 9)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "crTmpPar")
                    IF loc_nResult < 1
                        THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (crTmpPar)"
                        MsgErro(THIS.this_cMensagemErro, "Erro")
                        loc_lSucesso = .F.
                    ENDIF
                    SELECT crTmpPar

                    loc_cQuery = "Select Valos, FPags from SigCdPbx where Nopers = " + ;
                                 STR(crTmpPrIt.Nopers, 9) + ;
                                 " And EmpDopNums = '" + ALLTRIM(crDados1.EmpDopNums) + "'"
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "crTmpPrBx")
                    IF loc_nResult < 1
                        THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (crTmpPrBx)"
                        MsgErro(THIS.this_cMensagemErro, "Erro")
                        loc_lSucesso = .F.
                    ENDIF
                    SELECT crTmpPrBx

                    loc_cTitulo2  = IIF(!EOF("crTmpMccr"), crTmpMccr.Titulos, "")
                    loc_cHist2s   = IIF(!EOF("crTmpMccr"), crTmpMccr.Hist2s, "")

                    DO CASE
                        CASE crTmpPrIt.Tipos = "C"
                            SELECT crTmpMccr
                            IF !EOF("crTmpMccr")
                                loc_nValos   = crTmpMccr.Valors - crTmpMccr.ValPags + crTmpPrIt.Acertos
                                loc_nAcerto  = crTmpPrIt.Acertos
                                loc_cMoeda   = crTmpMccr.Moedas
                                loc_cHists   = crTmpMccr.Hists
                                loc_cHist2s  = crTmpMccr.Hist2s
                                loc_ldVencs2 = TTOD(crTmpMccr.Vencs)
                            ENDIF

                        CASE crTmpPrIt.Tipos = "P"
                            SELECT crTmpPar
                            IF EOF("crTmpPar")
                                SELECT crTmpMccr
                                IF !EOF("crTmpMccr")
                                    loc_nValos   = crTmpMccr.Valors - crTmpMccr.ValPags + crTmpPrIt.Acertos
                                    loc_nAcerto  = crTmpPrIt.Acertos
                                    loc_cMoeda   = crTmpMccr.Moedas
                                    loc_cHists   = crTmpMccr.Hists
                                    loc_cHist2s  = crTmpMccr.Hist2s
                                    loc_ldVencs2 = TTOD(crTmpMccr.Vencs)
                                ENDIF
                            ELSE
                                loc_nValos   = crTmpPar.Valos - crTmpPar.VPags + crTmpPrIt.Acertos
                                loc_nAcerto  = crTmpPrIt.Acertos
                                loc_cMoeda   = crTmpPar.MoeFpgs
                                loc_ldVencs2 = TTOD(crTmpPar.Vencs)
                                loc_cHists   = ALLTRIM(crTmpPar.FPags) + " " + crTmpPar.Emps + ;
                                               ALLTRIM(crTmpPar.Dopes) + " " + ;
                                               ALLTRIM(STR(crTmpPar.Numes, 6))
                                IF !EOF("crTmpMccr")
                                    SELECT crTmpMccr
                                    loc_cHists  = crTmpMccr.Hists
                                    loc_cHist2s = crTmpMccr.Hist2s
                                ENDIF
                            ENDIF

                        CASE crTmpPrIt.Tipos = "M"
                            loc_nValos   = crTmpPrIt.Valos
                            loc_nAcerto  = crTmpPrIt.Acertos
                            loc_cMoeda   = crTmpPrIt.Moedas
                            loc_ldVencs2 = TTOD(crTmpPrIt.Vencs)
                            loc_cHists   = crTmpPrIt.Hists
                    ENDCASE

                    LOCAL loc_nDebito2, loc_nCredito2
                    loc_nDebito2  = IIF(crTmpPrIt.Opers = "D", 0, loc_nValos)
                    loc_nCredito2 = IIF(crTmpPrIt.Opers = "C", 0, loc_nValos)

                    loc_cHists = loc_cHists + IIF(!EMPTY(loc_cHist2s), CHR(13) + loc_cHist2s, "")

                    LOCAL loc_cCondFinal, loc_cVlPagoFinal, loc_nTotPagoFinal
                    loc_cCondFinal    = ""
                    loc_cVlPagoFinal  = ""
                    loc_nTotPagoFinal = 0

                    SELECT crTmpPrBx
                    SCAN
                        loc_cCondFinal   = loc_cCondFinal + ;
                                           IIF(!EMPTY(loc_cCondFinal), CHR(13), "") + crTmpPrBx.FPags
                        loc_cVlPagoFinal = loc_cVlPagoFinal + ;
                                           IIF(!EMPTY(loc_cVlPagoFinal), CHR(13), "") + ;
                                           TRANSFORM(crTmpPrBx.Valos, "9,999,999.99")
                        loc_nTotPagoFinal = loc_nTotPagoFinal + crTmpPrBx.Valos
                    ENDSCAN

                    INSERT INTO crDados(Emps, Numes, Datas, Titulos, Vencs, Debito, ;
                                        Credito, Acerto, Moeda, Hists, Hist2s, ;
                                        CondPag, VlrPago, nTotPago) ;
                                 VALUES (crDados1.Emps, crDados1.Numes, crTmpPrIt.Datas, ;
                                         loc_cTitulo2, loc_ldVencs2, loc_nDebito2, ;
                                         loc_nCredito2, loc_nAcerto, loc_cMoeda, ;
                                         loc_cHists, loc_cHist2s, loc_cCondFinal, ;
                                         loc_cVlPagoFinal, loc_nTotPagoFinal)
                ENDSCAN
            ENDSCAN

            SELECT crDados
            GO TOP IN crDados

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Prepara cursores de dados para o relatorio
    * Override de RelatorioBase.PrepararDados()
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_lPagRec, loc_cCpoDt, loc_ldDataIni, loc_ldDataFin
        LOCAL loc_cGrupo, loc_cConta, loc_cJob, loc_cDesJob, loc_nSaldo, loc_nAut
        LOCAL loc_cQuery, loc_nResult, loc_cDataIni, loc_cDataFin
        LOCAL loc_cEmpresa, loc_cTitulo, loc_cPeriodo, loc_cMoeda, loc_cDatas
        LOCAL loc_cSaldo, loc_nCtRef, loc_nColuna, loc_cDesJob1
        LOCAL loc_ldVct, loc_nSdD, loc_nSdT, loc_nValFC, loc_nCtRFC

        loc_lSucesso = .F.

        TRY
            loc_ldDataIni = THIS.this_dDtInicial
            loc_ldDataFin = THIS.this_dDtFinal
            loc_cCpoDt    = IIF(THIS.this_nOptDatas = 1, "Vencs", ;
                               IIF(THIS.this_nOptDatas = 2, "DtEmis", "Datas"))
            loc_cGrupo    = ALLTRIM(THIS.this_cGrupo)
            loc_cConta    = ALLTRIM(THIS.this_cConta)
            loc_lPagRec   = (THIS.this_nPagamentos = 1) OR (THIS.this_nRecebimentos = 1)
            loc_nSaldo    = THIS.this_nSaldo
            loc_nAut      = THIS.this_nOptAutorizados
            loc_cJob      = PADR(ALLTRIM(THIS.this_cJobs), 10)
            loc_cDesJob   = IIF(!EMPTY(loc_cJob), ;
                               CHR(13) + CHR(10) + "Job : " + ALLTRIM(loc_cJob) + ;
                               " - " + THIS.this_cDJobs, "")

            IF loc_lPagRec
                loc_lSucesso = THIS.ProcessaPagRec()
                loc_lSucesso = loc_lSucesso
            ENDIF

            loc_cDataIni = "'" + DTOS(loc_ldDataIni) + "'"
            loc_cDataFin = "'" + DTOS(loc_ldDataFin) + " 23:59:59'"

            CREATE CURSOR crCabecalho (Empresa c(80), Titulo c(180), SubTitulo c(180), ;
                                       Periodo c(180), nQtdEmp n(2), ;
                                       cEmp1 c(3), cEmp2 c(3), cEmp3 c(3), cEmp4 c(3), ;
                                       cEmp5 c(3), cEmp6 c(3), cEmp7 c(3), cEmp8 c(3), ;
                                       cEmp9 c(3), SaldoFinal n(15,2), SaldoIni n(15,2), ;
                                       SaldosCab1 m, SaldosCab2 m)

            THIS.this_cSaldos1 = ""
            THIS.this_cSaldos2 = ""
            loc_cSaldo = ""

            IF (THIS.this_nOptAnaSi = 1)
                loc_cSaldo = IIF(!EMPTY(loc_nSaldo), ;
                                 " - Saldo Inicial : " + ;
                                 ALLTRIM(TRANSFORM(loc_nSaldo, "999,999,999.99")), "")
            ELSE
                IF INLIST(THIS.this_nOptSaldos, 2, 3)
                    loc_nSaldo = THIS.BuscaSaldos()
                ELSE
                    THIS.this_cSaldos1 = "Saldo Inicial : "
                    THIS.this_cSaldos2 = ALLTRIM(TRANSFORM(loc_nSaldo, "999,999,999.99"))
                ENDIF
            ENDIF

            loc_cEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa) + " - "
            IF USED("cursor_4c_SigCdEmp")
                IF SEEK(go_4c_Sistema.cCodEmpresa, "cursor_4c_SigCdEmp", "cEmps")
                    loc_cEmpresa = loc_cEmpresa + ALLTRIM(cursor_4c_SigCdEmp.Razas)
                ENDIF
            ENDIF

            loc_cTitulo  = "Relat" + CHR(243) + "rio de An" + CHR(225) + "lise a Pagar / Receber"
            loc_cMoeda   = IIF(EMPTY(THIS.this_cCdMoeda), "", ;
                               " - Moeda : " + ALLTRIM(THIS.this_cCdMoeda) + ;
                               " - " + ALLTRIM(THIS.this_cDsMoeda))
            loc_cDatas   = IIF(THIS.this_nOptDatas = 1, "Vencimentos", ;
                               IIF(THIS.this_nOptDatas = 2, ;
                                   "Emiss" + CHR(245) + "es", ;
                                   "Lan" + CHR(231) + "amentos"))
            loc_cDesJob1 = ""
            loc_cPeriodo = loc_cDatas + " de : " + DTOC(loc_ldDataIni) + ;
                           " " + CHR(224) + " " + DTOC(loc_ldDataFin) + ;
                           loc_cMoeda + loc_cSaldo + loc_cDesJob

            INSERT INTO crCabecalho (Empresa, Titulo, SubTitulo, Periodo, ;
                                     SaldoIni, SaldosCab1, SaldosCab2) ;
                             VALUES  (loc_cEmpresa, loc_cTitulo, loc_cDesJob1, ;
                                     loc_cPeriodo, loc_nSaldo, ;
                                     THIS.this_cSaldos1, THIS.this_cSaldos2)

            *-- Query principal: movimentos a pagar/receber em SigMvCcr
            loc_cQuery = "Select a.Emps, a.DopCs, a.Nopers, a.EmpDopNums, a.Contas, " + ;
                         "a.Titulos, a.Vencs, a.Opers, a.Hists, a.EspecieNFs, " + ;
                         "a.Valors as VlOrig, a.ValPags, (a.Valors-a.ValPags) as Valors, " + ;
                         "b.RClis, b.Codigos, a.Moedas " + ;
                         "From SigMvCcr a Inner Join SigCdCli b on b.iClis = a.Contas " + ;
                         "Where a." + loc_cCpoDt + " BetWeen " + loc_cDataIni + ;
                         " and " + loc_cDataFin

            IF !EMPTY(loc_cGrupo)
                loc_cQuery = loc_cQuery + " And a.Grupos = '" + loc_cGrupo + "'"
            ENDIF
            IF !EMPTY(loc_cConta)
                loc_cQuery = loc_cQuery + " And a.Contas = '" + loc_cConta + "'"
            ENDIF
            loc_cQuery = loc_cQuery + ;
                         " And (a.Valors-a.ValPags) > 0" + ;
                         " And a.Pagos = 1" + ;
                         " And a.ContaPgs <> 2" + ;
                         " And a.Tipos <> 'C'"
            IF THIS.this_nOptAnaSi = 3
                loc_cQuery = loc_cQuery + " And a.Tipos <> 'X'"
            ENDIF
            IF loc_nAut > 1
                loc_cQuery = loc_cQuery + " And " + ;
                             IIF(loc_nAut = 2, "Not ", "") + ;
                             "a.UsuConfs = Space(10)"
            ENDIF
            IF !EMPTY(loc_cJob)
                loc_cQuery = loc_cQuery + " And a.Jobs = '" + loc_cJob + "'"
            ENDIF
            loc_cQuery = loc_cQuery + ;
                         " Order By a.Emps, a.DopCs, a.Contas, a." + loc_cCpoDt

            loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "crDados1")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (crDados1)"
                MsgErro(THIS.this_cMensagemErro, "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Verificar operacoes de previsao selecionadas pelo usuario
            SELECT * ;
              FROM cursor_4c_SigOpOpe ;
             WHERE RealPrevs = 2 AND Imps = 1 ;
              INTO CURSOR crPrevs

            SELECT crPrevs
            GO TOP IN crPrevs
            IF !EOF("crPrevs")
                *-- Incluir movimentos de previsao (SigMvCpv)
                loc_cQuery = "Select a.Emps, a.DopCs, a.Nopers, a.EmpDopNums, a.Contas, " + ;
                             "a.Titulos, a.Vencs, a.Opers, a.Hists, a.EspecieNFs, " + ;
                             "a.Valors as VlOrig, a.ValPags, (a.Valors-a.ValPags) as Valors, " + ;
                             "b.RClis, b.Codigos, a.Moedas " + ;
                             "From SigMvCpv a Inner Join SigCdCli b on b.iClis = a.Contas " + ;
                             "Where a." + loc_cCpoDt + " Between " + loc_cDataIni + ;
                             " and " + loc_cDataFin

                IF !EMPTY(loc_cGrupo)
                    loc_cQuery = loc_cQuery + " And a.Grupos = '" + loc_cGrupo + "'"
                ENDIF
                IF !EMPTY(loc_cConta)
                    loc_cQuery = loc_cQuery + " And a.Contas = '" + loc_cConta + "'"
                ENDIF
                loc_cQuery = loc_cQuery + ;
                             " And (a.Valors-a.ValPags) > 0" + ;
                             " And a.Pagos = 1" + ;
                             " And a.ContaPgs <> 2" + ;
                             " And a.Tipos <> 'C'"
                IF THIS.this_nOptAnaSi = 3
                    loc_cQuery = loc_cQuery + " And a.Tipos <> 'X'"
                ENDIF
                IF loc_nAut > 1
                    loc_cQuery = loc_cQuery + " And " + ;
                                 IIF(loc_nAut = 2, "Not ", "") + ;
                                 "a.UsuConfs = Space(10)"
                ENDIF
                IF !EMPTY(loc_cJob)
                    loc_cQuery = loc_cQuery + " And a.Jobs = '" + loc_cJob + "'"
                ENDIF
                loc_cQuery = loc_cQuery + ;
                             " Order By a.Emps, a.DopCs, a.Contas, a." + loc_cCpoDt

                loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "LocalPrev")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (LocalPrev)"
                    MsgErro(THIS.this_cMensagemErro, "Erro")
                    loc_lSucesso = .F.
                ENDIF

                SELECT a.* ;
                  FROM crDados1 a ;
                 INNER JOIN cursor_4c_SigCdEmp b ON b.cEmps = a.Emps ;
                 INNER JOIN cursor_4c_SigOpOpe c ON c.Dopes = a.DopCs ;
                 INNER JOIN cursor_4c_SigCdClc d ON d.Codigos = a.Codigos ;
                 WHERE (b.Imps = 1) AND (c.Imps = 1) AND (d.Imps = 1) AND ;
                       a.Opers = LEFT(c.Opers, 1) ;
                 UNION ALL ;
                SELECT e.* ;
                  FROM LocalPrev e ;
                 INNER JOIN cursor_4c_SigCdEmp f ON f.cEmps = e.Emps ;
                 INNER JOIN cursor_4c_SigOpOpe g ON g.Dopes = e.DopCs ;
                 INNER JOIN cursor_4c_SigCdClc h ON h.Codigos = e.Codigos ;
                 WHERE (f.Imps = 1) AND (g.Imps = 1) AND (h.Imps = 1) AND ;
                       e.Opers = LEFT(g.Opers, 1) INTO CURSOR crDados2
            ELSE
                SELECT a.* ;
                  FROM crDados1 a ;
                 INNER JOIN cursor_4c_SigCdEmp b ON b.cEmps = a.Emps ;
                 INNER JOIN cursor_4c_SigOpOpe c ON c.Dopes = a.DopCs ;
                 INNER JOIN cursor_4c_SigCdClc d ON d.Codigos = a.Codigos ;
                 WHERE (b.Imps = 1) AND (c.Imps = 1) AND (d.Imps = 1) AND ;
                       a.Opers = LEFT(c.Opers, 1) INTO CURSOR crDados2
            ENDIF

            *-- Filtrar por parcelas pagas e montar crDados final
            SELECT * FROM crDados2 WHERE 0=1 INTO CURSOR crDados READWRITE

            SELECT crDados2
            GO TOP IN crDados2
            SCAN
                LOCAL loc_ldVenc, loc_cQry, loc_nTmpResult, loc_nVPags
                IF !EMPTY(crDados2.EmpDopNums) AND crDados2.ValPags <= 0
                    loc_ldVenc = TTOD(crDados2.Vencs)
                    loc_cQry = "Select vPags from SigMvPar where empdopnums = '" + ;
                               ALLTRIM(crDados2.EmpDopNums) + ;
                               "' and Vencs = '" + DTOS(loc_ldVenc) + "'"
                    loc_nTmpResult = SQLEXEC(gnConnHandle, loc_cQry, "crTmpPar")
                    loc_nVPags = IIF(loc_nTmpResult > 0 AND !EOF("crTmpPar"), crTmpPar.VPags, 0)
                    IF (crDados2.VlOrig - loc_nVPags) > 0 OR loc_nTmpResult <= 0 OR EOF("crTmpPar")
                        SELECT crDados2
                        SCATTER MEMVAR MEMO
                        IF loc_nTmpResult > 0 AND !EOF("crTmpPar")
                            m.Valors = (m.VlOrig - IIF(crTmpPar.vPags > m.VlOrig, m.VlOrig, crTmpPar.vPags))
                        ENDIF
                        INSERT INTO crDados FROM MEMVAR
                    ENDIF
                ELSE
                    SELECT crDados2
                    SCATTER MEMVAR MEMO
                    INSERT INTO crDados FROM MEMVAR
                ENDIF
            ENDSCAN

            *-- Processar de acordo com o tipo de analise selecionado
            DO CASE
                CASE (THIS.this_nOptAnaSi = 1) && Analitico
                    CREATE CURSOR crRel(Emps c(3), DopCs c(20), Titulos c(10), ;
                                        Conta c(10), NomeConta c(50), Vencs d(8), ;
                                        Debito n(14,2), Credito n(14,2), VlJuros n(14,2), ;
                                        VlTotal n(14,2), EmpDopNums c(29), ;
                                        OpDopCs c(2), OpLanc c(1))

                    SELECT crDados
                    GO TOP IN crDados
                    SCAN
                        LOCAL loc_bFound, loc_nVlJuros2, loc_nValorConv2
                        loc_bFound = SEEK(crDados.DopCs, "cursor_4c_SigOpOpe", "Dopes")

                        loc_nVlJuros2   = 0
                        loc_nValorConv2 = crDados.Valors

                        IF loc_bFound AND !EOF("cursor_4c_SigOpOpe")
                            IF (cursor_4c_SigOpOpe.Opers == "CR" AND crDados.Opers = "C") OR ;
                               (cursor_4c_SigOpOpe.Opers == "DB" AND crDados.Opers = "D")
                                loc_nVlJuros2 = THIS.NCalcJuros(TTOD(crDados.Vencs), crDados.Valors)
                            ENDIF
                        ENDIF

                        loc_nCtRef = THIS.BuscarCambio(crDados.Moedas)
                        IF THIS.this_nVlCotacao > 0
                            loc_nValorConv2 = loc_nValorConv2 * loc_nCtRef / THIS.this_nVlCotacao
                        ENDIF

                        APPEND BLANK IN crRel
                        REPLACE Emps       WITH crDados.Emps, ;
                                DopCs      WITH crDados.DopCs, ;
                                Titulos    WITH crDados.Titulos, ;
                                Conta      WITH crDados.Contas, ;
                                EmpDopNums WITH IIF(EMPTY(SUBSTR(crDados.EmpDopNums, 4, 1)), "", crDados.EmpDopNums), ;
                                NomeConta  WITH crDados.RClis, ;
                                Vencs      WITH TTOD(crDados.Vencs), ;
                                Debito     WITH IIF(crDados.Opers = "D", loc_nValorConv2, 0), ;
                                Credito    WITH IIF(crDados.Opers = "C", loc_nValorConv2, 0), ;
                                VlJuros    WITH loc_nVlJuros2, ;
                                VlTotal    WITH loc_nValorConv2 + loc_nVlJuros2, ;
                                OpDopCs    WITH IIF(loc_bFound AND !EOF("cursor_4c_SigOpOpe"), ;
                                                    cursor_4c_SigOpOpe.Opers, ""), ;
                                OpLanc     WITH crDados.Opers IN crRel
                    ENDSCAN
                    SELECT crRel
                    INDEX ON DTOS(Vencs) TAG OrdRel

                CASE (THIS.this_nOptAnaSi = 2) && Sintetico
                    CREATE CURSOR crRel(Conta c(10), NomeConta c(50), ;
                                        nVlrEmp1 n(14,2), nVlrEmp2 n(14,2), nVlrEmp3 n(14,2), ;
                                        nVlrEmp4 n(14,2), nVlrEmp5 n(14,2), nVlrEmp6 n(14,2), ;
                                        nVlrEmp7 n(14,2), nVlrEmp8 n(14,2), nVlrEmp9 n(14,2), ;
                                        VlTotal n(14,2))
                    INDEX ON Conta TAG Conta

                    CREATE CURSOR crEmps(Coluna n(2), Emps c(3))
                    INDEX ON Emps TAG Emps

                    loc_nColuna = 1

                    SELECT crDados
                    GO TOP IN crDados
                    SCAN
                        LOCAL loc_bFound2, loc_nValorConv3, loc_nVlJuros3, loc_nVlrAtu
                        LOCAL loc_cCampoEmp, loc_cCampoVal, loc_nVlCampo
                        loc_bFound2 = SEEK(crDados.DopCs, "cursor_4c_SigOpOpe", "Dopes")

                        IF !SEEK(crDados.Contas, "crRel", "Conta")
                            APPEND BLANK IN crRel
                            REPLACE Conta     WITH crDados.Contas, ;
                                    NomeConta WITH crDados.RClis IN crRel
                        ENDIF

                        loc_nValorConv3 = crDados.Valors
                        loc_nCtRef = THIS.BuscarCambio(crDados.Moedas)
                        IF THIS.this_nVlCotacao > 0
                            loc_nValorConv3 = loc_nValorConv3 * loc_nCtRef / THIS.this_nVlCotacao
                        ENDIF

                        loc_nVlJuros3 = 0
                        IF loc_bFound2 AND !EOF("cursor_4c_SigOpOpe")
                            IF (cursor_4c_SigOpOpe.Opers == "CR" AND crDados.Opers = "C") OR ;
                               (cursor_4c_SigOpOpe.Opers == "DB" AND crDados.Opers = "D")
                                loc_nVlJuros3 = THIS.NCalcJuros(TTOD(crDados.Vencs), loc_nValorConv3)
                            ENDIF
                        ENDIF

                        loc_nVlrAtu = loc_nValorConv3 + loc_nVlJuros3

                        IF !SEEK(crDados.Emps, "crEmps", "Emps")
                            INSERT INTO crEmps(Coluna, Emps) VALUES (loc_nColuna, crDados.Emps)
                            loc_cCampoEmp = "cEmp" + ALLTRIM(STR(loc_nColuna))
                            REPLACE &loc_cCampoEmp WITH crDados.Emps IN crCabecalho
                            loc_nColuna = loc_nColuna + 1
                        ENDIF

                        loc_cCampoVal = "nVlrEmp" + ALLTRIM(STR(crEmps.Coluna))
                        loc_nVlCampo  = IIF(crDados.Opers = "D", loc_nVlrAtu, loc_nVlrAtu * -1)

                        REPLACE &loc_cCampoVal WITH &loc_cCampoVal + loc_nVlCampo, ;
                                VlTotal WITH VlTotal + loc_nVlCampo IN crRel
                    ENDSCAN

                    REPLACE nQtdEmp WITH loc_nColuna - 1 IN crCabecalho

                    SELECT crRel
                    INDEX ON NomeConta TAG OrdRel

                OTHERWISE && Fluxo de Caixa
                    SELECT "" as GrpSaldos, TTOD(Vencs) as Vencs, Titulos, Hists, ;
                           EspecieNFs, Moedas, Valors, Opers, ;
                           9999999999.99 as SaldoDia, 9999999999.99 as SaldoTot, ;
                           9999999999.99 as Debitos,  9999999999.99 as Creditos ;
                      FROM crDados ;
                     ORDER BY Vencs, Titulos, Hists, EspecieNFs, Moedas, Valors ;
                      INTO CURSOR crProcessar READWRITE

                    UPDATE crProcessar SET SaldoDia = 0, SaldoTot = 0, Debitos = 0, Creditos = 0

                    loc_ldVct = CTOD("01/01/1900")
                    loc_nSdD  = 0
                    loc_nSdT  = loc_nSaldo

                    SELECT crProcessar
                    SCAN
                        IF (loc_ldVct <> crProcessar.Vencs)
                            loc_nSdD = 0
                        ENDIF
                        loc_ldVct = crProcessar.Vencs

                        loc_nValFC  = ABS(crProcessar.Valors)
                        loc_nCtRFC  = THIS.BuscarCambio(crProcessar.Moedas)
                        IF THIS.this_nVlCotacao > 0
                            loc_nValFC = loc_nValFC * loc_nCtRFC / THIS.this_nVlCotacao
                        ENDIF

                        loc_nSdD = loc_nSdD + (loc_nValFC * IIF(crProcessar.Opers = "D", 1, -1))
                        loc_nSdT = loc_nSdT + (loc_nValFC * IIF(crProcessar.Opers = "D", 1, -1))

                        REPLACE Debitos  WITH IIF(crProcessar.Opers = "D", loc_nValFC, 0), ;
                                Creditos WITH IIF(crProcessar.Opers = "C", loc_nValFC, 0), ;
                                SaldoDia WITH loc_nSdD, ;
                                SaldoTot WITH loc_nSdT IN crProcessar
                    ENDSCAN

                    SELECT crProcessar
                    GO TOP IN crProcessar
            ENDCASE

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_lPagRec

        loc_lSucesso = .F.

        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            loc_lPagRec = (THIS.this_nPagamentos = 1) OR (THIS.this_nRecebimentos = 1)

            IF (THIS.this_nOptAnaSi = 3)
                REPORT FORM SigReAp4 PREVIEW NOCONSOLE
            ELSE
                IF !loc_lPagRec
                    IF (THIS.this_nOptAnaSi = 1)
                        REPORT FORM SigReAp1 PREVIEW NOCONSOLE
                    ELSE
                        REPORT FORM SigReAp2 PREVIEW NOCONSOLE
                    ENDIF
                ELSE
                    REPORT FORM SigReAp3 PREVIEW NOCONSOLE
                ENDIF
            ENDIF

            THIS.RegistrarAuditoria("VISUALIZAR")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime com dialogo de selecao de impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_lPagRec

        loc_lSucesso = .F.

        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            loc_lPagRec = (THIS.this_nPagamentos = 1) OR (THIS.this_nRecebimentos = 1)

            IF (THIS.this_nOptAnaSi = 3)
                REPORT FORM SigReAp4 TO PRINTER PROMPT NOCONSOLE
            ELSE
                IF !loc_lPagRec
                    IF (THIS.this_nOptAnaSi = 1)
                        REPORT FORM SigReAp1 TO PRINTER PROMPT NOCONSOLE
                    ELSE
                        REPORT FORM SigReAp2 TO PRINTER PROMPT NOCONSOLE
                    ENDIF
                ELSE
                    REPORT FORM SigReAp3 TO PRINTER PROMPT NOCONSOLE
                ENDIF
            ENDIF

            THIS.RegistrarAuditoria("IMPRIMIR")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirSemDialogo - Prepara dados e imprime diretamente (sem dialogo)
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirSemDialogo()
        LOCAL loc_lSucesso, loc_lPagRec

        loc_lSucesso = .F.

        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            loc_lPagRec = (THIS.this_nPagamentos = 1) OR (THIS.this_nRecebimentos = 1)

            IF (THIS.this_nOptAnaSi = 3)
                REPORT FORM SigReAp4 TO PRINTER NOCONSOLE
            ELSE
                IF !loc_lPagRec
                    IF (THIS.this_nOptAnaSi = 1)
                        REPORT FORM SigReAp1 TO PRINTER NOCONSOLE
                    ELSE
                        REPORT FORM SigReAp2 TO PRINTER NOCONSOLE
                    ENDIF
                ELSE
                    REPORT FORM SigReAp3 TO PRINTER NOCONSOLE
                ENDIF
            ENDIF

            THIS.RegistrarAuditoria("IMPRIMIR")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExportarExcel - Prepara dados e delega exportacao para Excel ao DODEFAULT
    * Para Fluxo de Caixa (opt=3): cria crDados3 com colunas do crProcessar
    *--------------------------------------------------------------------------
    PROCEDURE ExportarExcel()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            IF THIS.this_nOptAnaSi = 3
                SELECT crDados
                GO TOP IN crDados

                SELECT grpsaldos, vencs, titulos, hists, especienfs, ;
                       valors, opers, debitos, creditos, saldodia, saldotot, moedas ;
                  FROM crProcessar ;
                 WHERE 0=0 INTO CURSOR crDados3 READWRITE

                SELECT crDados3
                GO TOP IN crDados3
            ENDIF

            DODEFAULT()

            THIS.RegistrarAuditoria("EXPORTAR")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave de auditoria da execucao do relatorio
    * Compoe identificador unico com empresa + filtros principais + periodo
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave, loc_cEmpresa, loc_cTipo

        loc_cEmpresa = IIF(TYPE("go_4c_Sistema.cCodEmpresa") = "C", ;
                           ALLTRIM(go_4c_Sistema.cCodEmpresa), "TODAS")

        DO CASE
            CASE THIS.this_nPagamentos = 1
                loc_cTipo = "PAG"
            CASE THIS.this_nRecebimentos = 1
                loc_cTipo = "REC"
            CASE THIS.this_nOptAnaSi = 1
                loc_cTipo = "ANALITICO"
            CASE THIS.this_nOptAnaSi = 2
                loc_cTipo = "SINTETICO"
            OTHERWISE
                loc_cTipo = "FLUXOCAIXA"
        ENDCASE

        loc_cChave = loc_cEmpresa + "/" + loc_cTipo + "/" + ;
                     DTOC(THIS.this_dDtInicial) + "/" + ;
                     DTOC(THIS.this_dDtFinal)

        IF !EMPTY(THIS.this_cGrupo)
            loc_cChave = loc_cChave + "/G:" + ALLTRIM(THIS.this_cGrupo)
        ENDIF

        IF !EMPTY(THIS.this_cConta)
            loc_cChave = loc_cChave + "/C:" + ALLTRIM(THIS.this_cConta)
        ENDIF

        IF THIS.this_nNumes > 0
            loc_cChave = loc_cChave + "/N:" + ALLTRIM(STR(THIS.this_nNumes, 6))
        ENDIF

        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra execucao do relatorio na tabela LogAuditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            loc_cChave   = THIS.ObterChavePrimaria()
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                               gc_4c_UsuarioLogado, "SISTEMA")

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL("SIGREAPP") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(loc_cUsuario) + ", GETDATE())"

            SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Aviso: falha ao registrar auditoria - " + ;
                                       loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir / Atualizar / CarregarDoCursor
    *
    * Operacoes nao aplicaveis a BOs de relatorio. Sao implementadas aqui
    * apenas para manter o contrato uniforme com BusinessBase (auditoria,
    * dispatchers genericos, validadores automatizados) e para sinalizar
    * explicitamente a restricao.
    *
    * Para relatorios, o fluxo correto eh:
    *   - PrepararDados() monta os cursores de saida via SQLEXEC sobre o
    *     periodo filtrado (crCabecalho, crRel, crProcessar, crDados)
    *   - Imprimir() / Visualizar() / ExportarExcel() consomem esses cursores
    *     atraves dos .FRX SigReAp1/SigReAp2/SigReAp3/SigReAp4
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: BO de relat" + CHR(243) + "rio n" + CHR(227) + ;
            "o insere registros. Use PrepararDados()/Imprimir()/Visualizar()."
        RETURN .F.
    ENDPROC

    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: BO de relat" + CHR(243) + "rio n" + CHR(227) + ;
            "o atualiza registros. Use PrepararDados()/Imprimir()/Visualizar()."
        RETURN .F.
    ENDPROC

    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: BO de relat" + CHR(243) + "rio processa o per" + ;
            CHR(237) + "odo inteiro em PrepararDados(), n" + CHR(227) + ;
            "o registro a registro."
        RETURN .F.
    ENDPROC

ENDDEFINE

