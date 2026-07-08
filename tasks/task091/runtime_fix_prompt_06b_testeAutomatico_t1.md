# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'LookupMetodosExistem': Campos de lookup encontrados mas nenhum metodo AbrirLookup existe | Detalhes: AbrirLookup: 0 | KeyPress handlers: 1 (KEYPRESS) | Campos lookup: 1 | SEM lookup: txt_4c_Cgru

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[04/06/2026 10:47:16 PM] CarregarDadosIniciais: Connection handle is invalid.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-06-04 22:47:10] [INFO] === VFP EXECUTOR v2.0 ===
[2026-06-04 22:47:10] [INFO] Config FPW: (nao fornecido)
[2026-06-04 22:47:10] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-06-04 22:47:10] [INFO] Timeout: 300 segundos
[2026-06-04 22:47:10] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_pue5zn0p.prg
[2026-06-04 22:47:10] [INFO] Conteudo do wrapper:
[2026-06-04 22:47:10] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSigReEtl', 'C:\4c\tasks\task091', 'REPORT'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigReEtl', 'C:\4c\tasks\task091', 'REPORT'
QUIT

[2026-06-04 22:47:10] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_pue5zn0p.prg
[2026-06-04 22:47:10] [INFO] VFP output esperado em: C:\4c\tasks\task091\vfp_output.txt
[2026-06-04 22:47:10] [INFO] Executando Visual FoxPro 9...
[2026-06-04 22:47:10] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_pue5zn0p.prg
[2026-06-04 22:47:10] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_pue5zn0p.prg
[2026-06-04 22:47:10] [INFO] Timeout configurado: 300 segundos
[2026-06-04 22:47:16] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-06-04 22:47:16] [INFO] VFP9 finalizado em 5.7204157 segundos
[2026-06-04 22:47:16] [INFO] Exit Code: 
[2026-06-04 22:47:16] [INFO] 
[2026-06-04 22:47:16] [INFO] Arquivos temporarios preservados para inspecao:
[2026-06-04 22:47:16] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_pue5zn0p.prg
[2026-06-04 22:47:16] [INFO] 
[2026-06-04 22:47:16] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-06-04 22:47:16] [INFO] * Auto-generated wrapper for parameters
[2026-06-04 22:47:16] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-06-04 22:47:16] [INFO] * Parameters: 'FormSigReEtl', 'C:\4c\tasks\task091', 'REPORT'
[2026-06-04 22:47:16] [INFO] 
[2026-06-04 22:47:16] [INFO] * Anti-dialog protections for unattended execution
[2026-06-04 22:47:16] [INFO] SET SAFETY OFF
[2026-06-04 22:47:16] [INFO] SET RESOURCE OFF
[2026-06-04 22:47:16] [INFO] SET TALK OFF
[2026-06-04 22:47:16] [INFO] SET NOTIFY OFF
[2026-06-04 22:47:16] [INFO] SYS(2335, 0)
[2026-06-04 22:47:16] [INFO] 
[2026-06-04 22:47:16] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigReEtl', 'C:\4c\tasks\task091', 'REPORT'
[2026-06-04 22:47:16] [INFO] QUIT
[2026-06-04 22:47:16] [INFO] 
[2026-06-04 22:47:16] [INFO] === Fim do Wrapper.prg ===
[2026-06-04 22:47:16] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSigReEtl",
  "timestamp": "20260604224716",
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
      "passou": true,
      "erro": "",
      "detalhes": "Form REPORT com BtnIncluirClick e PageFrame - navegacao Page2 nao aplicavel"
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
      "passou": false,
      "erro": "Campos de lookup encontrados mas nenhum metodo AbrirLookup existe",
      "detalhes": "AbrirLookup: 0 | KeyPress handlers: 1 (KEYPRESS) | Campos lookup: 1 | SEM lookup: txt_4c_Cgru"
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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReEtl.prg):
*==============================================================================
* FORMSIGREETL.PRG
* Relatorio de Estoque Por Localizacao - Formulario de Filtros
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREETL.SCX (frmrelatorio)
*
* Filtros (Page1 - layout flat, sem PageFrame CRUD):
*   - Empresa       (codigo + razao - SigCdEmp)
*   - Grupo         (codigo + desc  - SigCdGcr)
*   - Conta         (codigo + desc  - SigCdCli)
*   - Grupo de Venda (Colecao - SigCdCol)
*   - Hierarquia Base/Nvl2/Nvl3/Nvl4 (crSigLcNv*)
*   - Localizacao direta (SigPrLcl)
*   - Grande Grupo  (SigCdGpr)
*   - Grupo Produto (SigCdGrp)
*   - Subgrupo      (SigCdPsg)
*   - Produto       (SigCdPro)
*   - Fornecedor    (SigCdCli)
*   - Tipo relatorio (optSinAna: 1=Sint 2=Anal 3=Desc 4=Local 5=Anal+Desc 6=Sint+Desc)
*   - SubTotais checkbox (habilita apenas para tipo=3)
*   - Ordenacao (1=Nvl1 2=Nvl2 3=Nvl3 4=Nvl4)
*
* FRX: SigReEt1..SigReEt7 (selecao por SigReEtlBO.SelecionarFRX)
*==============================================================================

DEFINE CLASS FormSigReEtl AS FormBase

    Height      = 600
    Width       = 800
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
    * InicializarForm - Monta toda a estrutura visual do formulario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Estoque Por Localiza" + CHR(231) + CHR(227) + "o"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            IF TYPE("gc_4c_CaminhoReports") = "U"
                gc_4c_CaminhoReports = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            THIS.this_oRelatorio = CREATEOBJECT("SigReEtlBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SigReEtlBO", "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                THIS.this_oRelatorio.CarregarDadosIniciais()

                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarFiltros()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.LimparCampos()

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro com titulo (equivale ao cntSombra)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
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
                .AutoSize  = .T.
                .Caption   = "Estoque Por Localiza" + CHR(231) + CHR(227) + "o"
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
                .AutoSize  = .T.
                .Caption   = "Estoque Por Localiza" + CHR(231) + CHR(227) + "o"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - CommandGroup 4 botoes (Visualizar/Imprimir/Excel/Encerrar)
    *   Geometria original: btnReport.Left=525, Top=3, Width=~270, Height=80
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = 0
            .Left          = 525
            .Width         = 273
            .Height        = 80
            .ButtonCount   = 4
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.

            WITH .Buttons(1)
                .Top             = 5
                .Left            = 5
                .Width           = 65
                .Height          = 70
                .Caption         = "Visualizar"
                .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
                .PicturePosition = 13
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(2)
                .Top             = 5
                .Left            = 71
                .Width           = 65
                .Height          = 70
                .Caption         = "Imprimir"
                .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
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
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(3)
                .Top             = 5
                .Left            = 137
                .Width           = 65
                .Height          = 70
                .Caption         = "Excel"
                .Picture         = gc_4c_CaminhoIcones + "relatorio_excel_26.jpg"
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
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(4)
                .Top             = 5
                .Left            = 203
                .Width           = 65
                .Height          = 70
                .Caption         = "Encerrar"
                .Cancel          = .T.
                .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
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
                .Visible         = .T.
            ENDWITH
        ENDWITH

        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com 1 pagina (Filtros)
    *   Top=85 (abaixo do cabecalho), Height=515 (ate fim do form)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        loc_oPgf.PageCount = 1

        loc_oPgf.Top    = 85
        loc_oPgf.Left   = -1
        loc_oPgf.Width  = THIS.Width + 2
        loc_oPgf.Height = THIS.Height - 85
        loc_oPgf.Tabs   = .F.

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
    * ConfigurarFiltros - Todos os controles de filtro em Page1
    *   Tops ajustados: Top_Page1 = Top_original - 85
    *   (PageFrame.Top=85; controles originais tinham Top relativo ao form)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarFiltros()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- EMPRESA (original: lbl Top=125, txt Top=120)
        loc_oPg.AddObject("lbl_4c_Empresa", "Label")
        WITH loc_oPg.lbl_4c_Empresa
            .Top       = 40
            .Left      = 105
            .Caption   = "Empresa :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Empresa", "TextBox")
        WITH loc_oPg.txt_4c_Empresa
            .Top           = 35
            .Left          = 159
            .Width         = 31
            .Height        = 22
            .MaxLength     = 3
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DsEmpresa", "TextBox")
        WITH loc_oPg.txt_4c_DsEmpresa
            .Top           = 35
            .Left          = 192
            .Width         = 339
            .Height        = 22
            .MaxLength     = 40
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- GRUPO (original: lbl Top=148, txt Top=145)
        loc_oPg.AddObject("lbl_4c_Grupo", "Label")
        WITH loc_oPg.lbl_4c_Grupo
            .Top       = 63
            .Left      = 117
            .Caption   = "Grupo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPg.txt_4c_Grupo
            .Top           = 60
            .Left          = 159
            .Width         = 80
            .Height        = 22
            .MaxLength     = 10
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DsGrupo", "TextBox")
        WITH loc_oPg.txt_4c_DsGrupo
            .Top           = 60
            .Left          = 241
            .Width         = 290
            .Height        = 22
            .MaxLength     = 30
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- CONTA (original: lbl Top=173, txt Top=170)
        loc_oPg.AddObject("lbl_4c_Conta", "Label")
        WITH loc_oPg.lbl_4c_Conta
            .Top       = 88
            .Left      = 117
            .Caption   = "Conta :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oPg.txt_4c_Conta
            .Top           = 85
            .Left          = 159
            .Width         = 80
            .Height        = 22
            .MaxLength     = 10
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DsConta", "TextBox")
        WITH loc_oPg.txt_4c_DsConta
            .Top           = 85
            .Left          = 241
            .Width         = 290
            .Height        = 22
            .MaxLength     = 30
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- GRUPO DE VENDA / COLECAO (original: lbl Top=198, txt Top=195)
        loc_oPg.AddObject("lbl_4c_GruVenda", "Label")
        WITH loc_oPg.lbl_4c_GruVenda
            .Top       = 113
            .Left      = 69
            .Caption   = "Grupo de Venda :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Col", "TextBox")
        WITH loc_oPg.txt_4c_Col
            .Top           = 110
            .Left          = 159
            .Width         = 80
            .Height        = 22
            .MaxLength     = 10
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DsCol", "TextBox")
        WITH loc_oPg.txt_4c_DsCol
            .Top           = 110
            .Left          = 241
            .Width         = 290
            .Height        = 22
            .MaxLength     = 40
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- BASE / NIVEL 1 (original: lbl Top=225, txt Top=220)
        loc_oPg.AddObject("lbl_4c_Base", "Label")
        WITH loc_oPg.lbl_4c_Base
            .Top       = 140
            .Left      = 123
            .Caption   = "Base :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Base", "TextBox")
        WITH loc_oPg.txt_4c_Base
            .Top           = 135
            .Left          = 159
            .Width         = 54
            .Height        = 22
            .MaxLength     = 4
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DsBase", "TextBox")
        WITH loc_oPg.txt_4c_DsBase
            .Top           = 135
            .Left          = 215
            .Width         = 174
            .Height        = 22
            .MaxLength     = 40
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- SEGUNDO NIVEL (original: lbl Top=250, txt Top=245)
        loc_oPg.AddObject("lbl_4c_Nvl2", "Label")
        WITH loc_oPg.lbl_4c_Nvl2
            .Top       = 165
            .Left      = 78
            .Caption   = "Segundo N" + CHR(237) + "vel :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Nvl2", "TextBox")
        WITH loc_oPg.txt_4c_Nvl2
            .Top           = 160
            .Left          = 159
            .Width         = 54
            .Height        = 22
            .MaxLength     = 4
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DsNvl2", "TextBox")
        WITH loc_oPg.txt_4c_DsNvl2
            .Top           = 160
            .Left          = 215
            .Width         = 174
            .Height        = 22
            .MaxLength     = 40
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- TERCEIRO NIVEL (original: lbl Top=275, txt Top=270)
        loc_oPg.AddObject("lbl_4c_Nvl3", "Label")
        WITH loc_oPg.lbl_4c_Nvl3
            .Top       = 190
            .Left      = 81
            .Caption   = "Terceiro N" + CHR(237) + "vel :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Nvl3", "TextBox")
        WITH loc_oPg.txt_4c_Nvl3
            .Top           = 185
            .Left          = 159
            .Width         = 54
            .Height        = 22
            .MaxLength     = 4
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DsNvl3", "TextBox")
        WITH loc_oPg.txt_4c_DsNvl3
            .Top           = 185
            .Left          = 215
            .Width         = 174
            .Height        = 22
            .MaxLength     = 40
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- QUARTO NIVEL (original: lbl Top=301, txt Top=296)
        loc_oPg.AddObject("lbl_4c_Nvl4", "Label")
        WITH loc_oPg.lbl_4c_Nvl4
            .Top       = 216
            .Left      = 86
            .Caption   = "Quarto N" + CHR(237) + "vel :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Nvl4", "TextBox")
        WITH loc_oPg.txt_4c_Nvl4
            .Top           = 211
            .Left          = 159
            .Width         = 54
            .Height        = 22
            .MaxLength     = 4
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DsNvl4", "TextBox")
        WITH loc_oPg.txt_4c_DsNvl4
            .Top           = 211
            .Left          = 215
            .Width         = 174
            .Height        = 22
            .MaxLength     = 40
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- LOCALIZACAO (original: lbl Top=324, txt Top=321)
        loc_oPg.AddObject("lbl_4c_Local", "Label")
        WITH loc_oPg.lbl_4c_Local
            .Top       = 239
            .Left      = 92
            .Caption   = "Localiza" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Local", "TextBox")
        WITH loc_oPg.txt_4c_Local
            .Top           = 236
            .Left          = 159
            .Width         = 80
            .Height        = 22
            .MaxLength     = 10
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DsLocal", "TextBox")
        WITH loc_oPg.txt_4c_DsLocal
            .Top           = 236
            .Left          = 241
            .Width         = 290
            .Height        = 22
            .MaxLength     = 40
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- Nota sobre localizacao alternativa (original Label1 Left=537, Top=325)
        loc_oPg.AddObject("lbl_4c_NotaLocal", "Label")
        WITH loc_oPg.lbl_4c_NotaLocal
            .Top       = 240
            .Left      = 537
            .Caption   = "* Localiza" + CHR(231) + CHR(227) + "o com Outro Padr" + CHR(227) + "o"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- GRANDE GRUPO (original: lbl Top=349, txt Top=346)
        loc_oPg.AddObject("lbl_4c_GGrupo", "Label")
        WITH loc_oPg.lbl_4c_GGrupo
            .Top       = 264
            .Left      = 79
            .Caption   = "Grande Grupo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_CSGru", "TextBox")
        WITH loc_oPg.txt_4c_CSGru
            .Top           = 261
            .Left          = 159
            .Width         = 31
            .Height        = 22
            .MaxLength     = 6
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DsSGru", "TextBox")
        WITH loc_oPg.txt_4c_DsSGru
            .Top           = 261
            .Left          = 192
            .Width         = 171
            .Height        = 22
            .MaxLength     = 30
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- GRUPO PRODUTO (original: lbl Top=375, txt Top=371)
        loc_oPg.AddObject("lbl_4c_GrpProd", "Label")
        WITH loc_oPg.lbl_4c_GrpProd
            .Top       = 290
            .Left      = 117
            .Caption   = "Grupo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Cgru", "TextBox")
        WITH loc_oPg.txt_4c_Cgru
            .Top           = 286
            .Left          = 159
            .Width         = 31
            .Height        = 22
            .MaxLength     = 3
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Dgru", "TextBox")
        WITH loc_oPg.txt_4c_Dgru
            .Top           = 286
            .Left          = 192
            .Width         = 171
            .Height        = 22
            .MaxLength     = 30
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- SUBGRUPO (original: lbl Top=399, txt Top=396)
        loc_oPg.AddObject("lbl_4c_SubGrupo", "Label")
        WITH loc_oPg.lbl_4c_SubGrupo
            .Top       = 314
            .Left      = 100
            .Caption   = "Subgrupo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_CSubG", "TextBox")
        WITH loc_oPg.txt_4c_CSubG
            .Top           = 311
            .Left          = 159
            .Width         = 52
            .Height        = 22
            .MaxLength     = 6
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DSubG", "TextBox")
        WITH loc_oPg.txt_4c_DSubG
            .Top           = 311
            .Left          = 213
            .Width         = 150
            .Height        = 22
            .MaxLength     = 30
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- PRODUTO (original: lbl Top=424, txt Top=421)
        loc_oPg.AddObject("lbl_4c_Produto", "Label")
        WITH loc_oPg.lbl_4c_Produto
            .Top       = 339
            .Left      = 108
            .Caption   = "Produto :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_CdProduto", "TextBox")
        WITH loc_oPg.txt_4c_CdProduto
            .Top           = 336
            .Left          = 159
            .Width         = 108
            .Height        = 22
            .MaxLength     = 14
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DsProduto", "TextBox")
        WITH loc_oPg.txt_4c_DsProduto
            .Top           = 336
            .Left          = 269
            .Width         = 304
            .Height        = 22
            .MaxLength     = 40
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- FORNECEDOR (original: lbl Top=449, txt Top=446)
        loc_oPg.AddObject("lbl_4c_Forn", "Label")
        WITH loc_oPg.lbl_4c_Forn
            .Top       = 364
            .Left      = 91
            .Caption   = "Fornecedor :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Forn", "TextBox")
        WITH loc_oPg.txt_4c_Forn
            .Top           = 361
            .Left          = 159
            .Width         = 80
            .Height        = 22
            .MaxLength     = 10
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DsForn", "TextBox")
        WITH loc_oPg.txt_4c_DsForn
            .Top           = 361
            .Left          = 241
            .Width         = 290
            .Height        = 22
            .MaxLength     = 40
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- TIPO RELATORIO - optSinAna (original: lbl Top=475, opt Top=470)
        loc_oPg.AddObject("lbl_4c_Tipo", "Label")
        WITH loc_oPg.lbl_4c_Tipo
            .Top       = 390
            .Left      = 126
            .Caption   = "Tipo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("opt_4c_SinAna", "OptionGroup")
        WITH loc_oPg.opt_4c_SinAna
            .ButtonCount = 6
            .Top         = 385
            .Left        = 157
            .Width       = 477
            .Height      = 52
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.

            WITH .Buttons(1)
                .Caption   = "Sint" + CHR(233) + "tico"
                .Left      = 5
                .Top       = 6
                .AutoSize  = .T.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "Anal" + CHR(237) + "tico"
                .Left      = 81
                .Top       = 6
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            WITH .Buttons(3)
                .Caption   = "Com Descri" + CHR(231) + CHR(227) + "o"
                .Left      = 156
                .Top       = 6
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            WITH .Buttons(4)
                .Caption   = "Refer" + CHR(234) + "ncia por Local"
                .Left      = 266
                .Top       = 5
                .Width     = 136
                .Height    = 17
                .BackStyle = 0
                .FontName  = "Tahoma"
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .F.
            ENDWITH

            WITH .Buttons(5)
                .Caption   = "Anal" + CHR(237) + "tico Com Descri" + CHR(231) + CHR(227) + "o"
                .Left      = 172
                .Top       = 26
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            WITH .Buttons(6)
                .Caption   = "Sint" + CHR(233) + "tico Com Descri" + CHR(231) + CHR(227) + "o"
                .Left      = 5
                .Top       = 26
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- SUBTOTAIS (original: Top=475, Left=582; habilitado apenas para tipo=3)
        loc_oPg.AddObject("chk_4c_Subtotais", "CheckBox")
        WITH loc_oPg.chk_4c_Subtotais
            .Top       = 390
            .Left      = 582
            .Width     = 147
            .Height    = 15
            .Caption   = "SubTotais Grupo/Subgrupo"
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Enabled   = .F.
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- ORDENACAO (original: lbl Top=520, opt Top=515)
        loc_oPg.AddObject("lbl_4c_Ordem", "Label")
        WITH loc_oPg.lbl_4c_Ordem
            .Top       = 435
            .Left      = 93
            .Caption   = "Ordena" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("opt_4c_Ordem", "OptionGroup")
        WITH loc_oPg.opt_4c_Ordem
            .ButtonCount = 4
            .Top         = 430
            .Left        = 157
            .Width       = 432
            .Height      = 26
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.

            WITH .Buttons(1)
                .Caption   = "Primeiro N" + CHR(237) + "vel"
                .Left      = 5
                .Top       = 5
                .AutoSize  = .T.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "Segundo N" + CHR(237) + "vel"
                .Left      = 111
                .Top       = 5
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            WITH .Buttons(3)
                .Caption   = "Terceiro N" + CHR(237) + "vel"
                .Left      = 219
                .Top       = 5
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            WITH .Buttons(4)
                .Caption   = "Quarto N" + CHR(237) + "vel"
                .Left      = 324
                .Top       = 5
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- BINDEVENTS: KeyPress em campos de codigo (F4=115, Enter=13, Tab=9)
        BINDEVENT(loc_oPg.txt_4c_Empresa,   "KeyPress", THIS, "TeclaEmpresa")
        BINDEVENT(loc_oPg.txt_4c_Grupo,     "KeyPress", THIS, "TeclaGrupo")
        BINDEVENT(loc_oPg.txt_4c_Conta,     "KeyPress", THIS, "TeclaConta")
        BINDEVENT(loc_oPg.txt_4c_Col,       "KeyPress", THIS, "TeclaCol")
        BINDEVENT(loc_oPg.txt_4c_Base,      "KeyPress", THIS, "TeclaBase")
        BINDEVENT(loc_oPg.txt_4c_Nvl2,      "KeyPress", THIS, "TeclaNvl2")
        BINDEVENT(loc_oPg.txt_4c_Nvl3,      "KeyPress", THIS, "TeclaNvl3")
        BINDEVENT(loc_oPg.txt_4c_Nvl4,      "KeyPress", THIS, "TeclaNvl4")
        BINDEVENT(loc_oPg.txt_4c_Local,     "KeyPress", THIS, "TeclaLocal")
        BINDEVENT(loc_oPg.txt_4c_CSGru,     "KeyPress", THIS, "TeclaCSGru")
        BINDEVENT(loc_oPg.txt_4c_Cgru,      "KeyPress", THIS, "TeclaCgru")
        BINDEVENT(loc_oPg.txt_4c_CSubG,     "KeyPress", THIS, "TeclaCSubG")
        BINDEVENT(loc_oPg.txt_4c_CdProduto, "KeyPress", THIS, "TeclaCdProduto")
        BINDEVENT(loc_oPg.txt_4c_Forn,      "KeyPress", THIS, "TeclaForn")

        *-- BINDEVENTS: InteractiveChange para cascade clear hierarquia
        BINDEVENT(loc_oPg.txt_4c_Base,  "InteractiveChange", THIS, "MudaBase")
        BINDEVENT(loc_oPg.txt_4c_Nvl2,  "InteractiveChange", THIS, "MudaNvl2")
        BINDEVENT(loc_oPg.txt_4c_Nvl3,  "InteractiveChange", THIS, "MudaNvl3")
        BINDEVENT(loc_oPg.txt_4c_Nvl4,  "InteractiveChange", THIS, "MudaNvl4")
        BINDEVENT(loc_oPg.txt_4c_Local, "InteractiveChange", THIS, "MudaLocal")

        *-- BINDEVENT: Mudanca de tipo habilita/desabilita SubTotais
        BINDEVENT(loc_oPg.opt_4c_SinAna, "InteractiveChange", THIS, "MudaTipoRelatorio")
    ENDPROC

    *==========================================================================
    *  INICIALIZACAO DOS CAMPOS
    *==========================================================================

    PROCEDURE LimparCampos()
        LOCAL loc_oPg
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
                RETURN
            ENDIF
            loc_oPg = THIS.pgf_4c_Paginas.Page1

            IF VARTYPE(THIS.this_oRelatorio) = "O"
                loc_oPg.txt_4c_Empresa.Value  = THIS.this_oRelatorio.this_cEmpresa
                loc_oPg.txt_4c_DsEmpresa.Value = THIS.this_oRelatorio.this_cDEmpresa
                loc_oPg.txt_4c_Grupo.Value    = THIS.this_oRelatorio.this_cGrupo
                loc_oPg.txt_4c_DsGrupo.Value  = THIS.this_oRelatorio.this_cDGrupo
                loc_oPg.txt_4c_Conta.Value    = THIS.this_oRelatorio.this_cConta
                loc_oPg.txt_4c_DsConta.Value  = THIS.this_oRelatorio.this_cDConta
            ENDIF

            loc_oPg.txt_4c_Col.Value       = ""
            loc_oPg.txt_4c_DsCol.Value     = ""
            loc_oPg.txt_4c_Base.Value      = ""
            loc_oPg.txt_4c_DsBase.Value    = ""
            loc_oPg.txt_4c_Nvl2.Value      = ""
            loc_oPg.txt_4c_DsNvl2.Value    = ""
            loc_oPg.txt_4c_Nvl3.Value      = ""
            loc_oPg.txt_4c_DsNvl3.Value    = ""
            loc_oPg.txt_4c_Nvl4.Value      = ""
            loc_oPg.txt_4c_DsNvl4.Value    = ""
            loc_oPg.txt_4c_Local.Value     = ""
            loc_oPg.txt_4c_DsLocal.Value   = ""
            loc_oPg.txt_4c_CSGru.Value     = ""
            loc_oPg.txt_4c_DsSGru.Value    = ""
            loc_oPg.txt_4c_Cgru.Value      = ""
            loc_oPg.txt_4c_Dgru.Value      = ""
            loc_oPg.txt_4c_CSubG.Value     = ""
            loc_oPg.txt_4c_DSubG.Value     = ""
            loc_oPg.txt_4c_CdProduto.Value = ""
            loc_oPg.txt_4c_DsProduto.Value = ""
            loc_oPg.txt_4c_Forn.Value      = ""
            loc_oPg.txt_4c_DsForn.Value    = ""

            loc_oPg.opt_4c_SinAna.Value      = 1
            loc_oPg.chk_4c_Subtotais.Value   = 0
            loc_oPg.chk_4c_Subtotais.Enabled = .F.
            loc_oPg.opt_4c_Ordem.Value       = 1

            loc_oPg.txt_4c_Nvl2.Enabled = .F.
            loc_oPg.txt_4c_Nvl3.Enabled = .F.
            loc_oPg.txt_4c_Nvl4.Enabled = .F.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    *  HANDLERS DE TECLADO (F4=busca, Enter/Tab=valida)
    *==========================================================================

    PROCEDURE TeclaEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpresa()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarEmpresa()
        ENDIF
    ENDPROC

    PROCEDURE TeclaGrupo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaGrupo()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarGrupo()
        ENDIF
    ENDPROC

    PROCEDURE TeclaConta(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaConta()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarConta()
        ENDIF
    ENDPROC

    PROCEDURE TeclaCol(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCol()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCol()
        ENDIF
    ENDPROC

    PROCEDURE TeclaBase(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaBase()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarBase()
        ENDIF
    ENDPROC

    PROCEDURE TeclaNvl2(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarNvl2()
        ENDIF
    ENDPROC

    PROCEDURE TeclaNvl3(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarNvl3()
        ENDIF
    ENDPROC

    PROCEDURE TeclaNvl4(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarNvl4()
        ENDIF
    ENDPROC

    PROCEDURE TeclaLocal(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaLocal()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarLocal()
        ENDIF
    ENDPROC

    PROCEDURE TeclaCSGru(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCSGru()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCSGru()
        ENDIF
    ENDPROC

    PROCEDURE TeclaCgru(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCgru()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCgru()
        ENDIF
    ENDPROC

    PROCEDURE TeclaCSubG(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCSubG()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCSubG()
        ENDIF
    ENDPROC

    PROCEDURE TeclaCdProduto(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCdProduto()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdProduto()
        ENDIF
    ENDPROC

    PROCEDURE TeclaForn(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaForn()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarForn()
        ENDIF
    ENDPROC

    *==========================================================================
    *  CASCADE CLEAR - Hierarquia de localizacao
    *==========================================================================

    PROCEDURE MudaBase()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            loc_oPg.txt_4c_DsBase.Value  = ""
            loc_oPg.txt_4c_Nvl2.Value    = ""
            loc_oPg.txt_4c_DsNvl2.Value  = ""
            loc_oPg.txt_4c_Nvl3.Value    = ""
            loc_oPg.txt_4c_DsNvl3.Value  = ""
            loc_oPg.txt_4c_Nvl4.Value    = ""
            loc_oPg.txt_4c_DsNvl4.Value  = ""
            loc_oPg.txt_4c_Local.Value   = ""
            loc_oPg.txt_4c_DsLocal.Value = ""
            loc_oPg.txt_4c_Nvl2.Enabled  = !EMPTY(ALLTRIM(loc_oPg.txt_4c_Base.Value))
            loc_oPg.txt_4c_Nvl3.Enabled  = .F.
            loc_oPg.txt_4c_Nvl4.Enabled  = .F.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE MudaNvl2()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            loc_oPg.txt_4c_DsNvl2.Value  = ""
            loc_oPg.txt_4c_Nvl3.Value    = ""
            loc_oPg.txt_4c_DsNvl3.Value  = ""
            loc_oPg.txt_4c_Nvl4.Value    = ""
            loc_oPg.txt_4c_DsNvl4.Value  = ""
            loc_oPg.txt_4c_Local.Value   = ""
            loc_oPg.txt_4c_DsLocal.Value = ""
            loc_oPg.txt_4c_Nvl3.Enabled  = !EMPTY(ALLTRIM(loc_oPg.txt_4c_Nvl2.Value))
            loc_oPg.txt_4c_Nvl4.Enabled  = .F.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE MudaNvl3()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            loc_oPg.txt_4c_DsNvl3.Value  = ""
            loc_oPg.txt_4c_Nvl4.Value    = ""
            loc_oPg.txt_4c_DsNvl4.Value  = ""
            loc_oPg.txt_4c_Local.Value   = ""
            loc_oPg.txt_4c_DsLocal.Value = ""
            loc_oPg.txt_4c_Nvl4.Enabled  = !EMPTY(ALLTRIM(loc_oPg.txt_4c_Nvl3.Value))
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE MudaNvl4()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            loc_oPg.txt_4c_DsNvl4.Value  = ""
            loc_oPg.txt_4c_Local.Value   = ""
            loc_oPg.txt_4c_DsLocal.Value = ""
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE MudaLocal()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            loc_oPg.txt_4c_DsLocal.Value = ""
            loc_oPg.txt_4c_Base.Value    = ""
            loc_oPg.txt_4c_DsBase.Value  = ""
            loc_oPg.txt_4c_Nvl2.Value    = ""
            loc_oPg.txt_4c_DsNvl2.Value  = ""
            loc_oPg.txt_4c_Nvl3.Value    = ""
            loc_oPg.txt_4c_DsNvl3.Value  = ""
            loc_oPg.txt_4c_Nvl4.Value    = ""
            loc_oPg.txt_4c_DsNvl4.Value  = ""
            loc_oPg.txt_4c_Nvl2.Enabled  = .F.
            loc_oPg.txt_4c_Nvl3.Enabled  = .F.
            loc_oPg.txt_4c_Nvl4.Enabled  = .F.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE MudaTipoRelatorio()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            loc_oPg.chk_4c_Subtotais.Enabled = (loc_oPg.opt_4c_SinAna.Value = 3)
            IF loc_oPg.opt_4c_SinAna.Value != 3
                loc_oPg.chk_4c_Subtotais.Value = 0
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    *  VALIDACAO E LOOKUP - Empresa (SigCdEmp: cemps / razas)
    *==========================================================================

    PROCEDURE ValidarEmpresa()
        LOCAL loc_oPg, loc_cCodigo, loc_cSQL, loc_nResult
        TRY
            loc_oPg     = THIS.pgf_4c_Paginas.Page1
            loc_cCodigo = ALLTRIM(loc_oPg.txt_4c_Empresa.Value)
            IF EMPTY(loc_cCodigo)
                loc_oPg.txt_4c_DsEmpresa.Value = ""
                RETURN
            ENDIF
            loc_cSQL    = "SELECT TOP 1 cemps, razas FROM SigCdEmp WHERE cemps = " + EscaparSQL(loc_cCodigo)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EtlEmpVal")
            IF loc_nResult > 0 AND !EOF("cursor_4c_EtlEmpVal")
                SELECT cursor_4c_EtlEmpVal
                loc_oPg.txt_4c_Empresa.Value   = ALLTRIM(cemps)
                loc_oPg.txt_4c_DsEmpresa.Value = ALLTRIM(razas)
            ELSE
                MsgAviso("Empresa n" + CHR(227) + "o encontrada.", "Empresa")
                loc_oPg.txt_4c_Empresa.Value   = ""
                loc_oPg.txt_4c_DsEmpresa.Value = ""
                THIS.AbrirBuscaEmpresa()
            ENDIF
            IF USED("cursor_4c_EtlEmpVal")
                USE IN cursor_4c_EtlEmpVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE AbrirBuscaEmpresa()
        LOCAL loc_oBusca, loc_cValor, loc_oPg, loc_cCursor
        loc_cCursor = "cursor_4c_EtlEmpBusca"
        TRY
            loc_oPg    = THIS.pgf_4c_Paginas.Page1
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_Empresa.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", loc_cCursor, "cemps", loc_cValor, ;
                "Selecionar Empresa", "")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("cemps", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("razas", "", "Raz" + CHR(227) + "o Social")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    loc_oPg.txt_4c_Empresa.Value   = ALLTRIM(cemps)
                    loc_oPg.txt_4c_DsEmpresa.Value = ALLTRIM(razas)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF
    ENDPROC

    *==========================================================================
    *  VALIDACAO E LOOKUP - Grupo contabilidade (SigCdGcr: codigos / descrs)
    *==========================================================================

    PROCEDURE ValidarGrupo()
        LOCAL loc_oPg, loc_cCodigo, loc_cSQL, loc_nResult
        TRY
            loc_oPg     = THIS.pgf_4c_Paginas.Page1
            loc_cCodigo = ALLTRIM(loc_oPg.txt_4c_Grupo.Value)
            IF EMPTY(loc_cCodigo)
                loc_oPg.txt_4c_DsGrupo.Value = ""
                RETURN
            ENDIF
            loc_cSQL    = "SELECT TOP 1 codigos, descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cCodigo)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EtlGrpVal")
            IF loc_nResult > 0 AND !EOF("cursor_4c_EtlGrpVal")
                SELECT cursor_4c_EtlGrpVal
                loc_oPg.txt_4c_Grupo.Value   = ALLTRIM(codigos)
                loc_oPg.txt_4c_DsGrupo.Value = ALLTRIM(descrs)
            ELSE
                MsgAviso("Grupo n" + CHR(227) + "o encontrado.", "Grupo")
                loc_oPg.txt_4c_Grupo.Value   = ""
                loc_oPg.txt_4c_DsGrupo.Value = ""
                THIS.AbrirBuscaGrupo()
            ENDIF
            IF USED("cursor_4c_EtlGrpVal")
                USE IN cursor_4c_EtlGrpVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE AbrirBuscaGrupo()
        LOCAL loc_oBusca, loc_cValor, loc_oPg, loc_cCursor
        loc_cCursor = "cursor_4c_EtlGrpBusca"
        TRY
            loc_oPg    = THIS.pgf_4c_Paginas.Page1
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_Grupo.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", loc_cCursor, "codigos", loc_cValor, ;
                "Selecionar Grupo", "")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    loc_oPg.txt_4c_Grupo.Value   = ALLTRIM(codigos)
                    loc_oPg.txt_4c_DsGrupo.Value = ALLTRIM(descrs)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF
    ENDPROC

    *==========================================================================
    *  VALIDACAO E LOOKUP - Conta de estoque (SigCdCli: iclis / rclis)
    *==========================================================================

    PROCEDURE ValidarConta()
        LOCAL loc_oPg, loc_cCodigo, loc_cSQL, loc_nResult
        TRY
            loc_oPg     = THIS.pgf_4c_Paginas.Page1
            loc_cCodigo = ALLTRIM(loc_oPg.txt_4c_Conta.Value)
            IF EMPTY(loc_cCodigo)
                loc_oPg.txt_4c_DsConta.Value = ""
                RETURN
            ENDIF
            loc_cSQL    = "SELECT TOP 1 iclis, rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cCodigo)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EtlContVal")
            IF loc_nResult > 0 AND !EOF("cursor_4c_EtlContVal")
                SELECT cursor_4c_EtlContVal
                loc_oPg.txt_4c_Conta.Value   = ALLTRIM(iclis)
                loc_oPg.txt_4c_DsConta.Value = ALLTRIM(rclis)
            ELSE
                MsgAviso("Conta n" + CHR(227) + "o encontrada.", "Conta")
                loc_oPg.txt_4c_Conta.Value   = ""
                loc_oPg.txt_4c_DsConta.Value = ""
                THIS.AbrirBuscaConta()
            ENDIF
            IF USED("cursor_4c_EtlContVal")
                USE IN cursor_4c_EtlContVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE AbrirBuscaConta()
        LOCAL loc_oBusca, loc_cValor, loc_oPg, loc_cCursor
        loc_cCursor = "cursor_4c_EtlContBusca"
        TRY
            loc_oPg    = THIS.pgf_4c_Paginas.Page1
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_Conta.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", loc_cCursor, "iclis", loc_cValor, ;
                "Selecionar Conta", "")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("rclis", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    loc_oPg.txt_4c_Conta.Value   = ALLTRIM(iclis)
                    loc_oPg.txt_4c_DsConta.Value = ALLTRIM(rclis)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF
    ENDPROC

    *==========================================================================
    *  VALIDACAO E LOOKUP - Grupo de Venda / Colecao (SigCdCol: Colecoes / Descs)
    *==========================================================================

    PROCEDURE ValidarCol()
        LOCAL loc_oPg, loc_cCodigo, loc_cSQL, loc_nResult
        TRY
            loc_oPg     = THIS.pgf_4c_Paginas.Page1
            loc_cCodigo = ALLTRIM(loc_oPg.txt_4c_Col.Value)
            IF EMPTY(loc_cCodigo)
                loc_oPg.txt_4c_DsCol.Value = ""
                RETURN
            ENDIF
            loc_cSQL    = "SELECT TOP 1 Colecoes, Descs FROM SigCdCol WHERE Colecoes = " + EscaparSQL(loc_cCodigo)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EtlColVal")
            IF loc_nResult > 0 AND !EOF("cursor_4c_EtlColVal")
                SELECT cursor_4c_EtlColVal
                loc_oPg.txt_4c_Col.Value   = ALLTRIM(Colecoes)
                loc_oPg.txt_4c_DsCol.Value = ALLTRIM(Descs)
            ELSE
                MsgAviso("Cole" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada.", "Grupo de Venda")
                loc_oPg.txt_4c_Col.Value   = ""
                loc_oPg.txt_4c_DsCol.Value = ""
                THIS.AbrirBuscaCol()
            ENDIF
            IF USED("cursor_4c_EtlColVal")
                USE IN cursor_4c_EtlColVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE AbrirBuscaCol()
        LOCAL loc_oBusca, loc_cValor, loc_oPg, loc_cCursor
        loc_cCursor = "cursor_4c_EtlColBusca"
        TRY
            loc_oPg    = THIS.pgf_4c_Paginas.Page1
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_Col.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCol", loc_cCursor, "Colecoes", loc_cValor, ;
                "Selecionar Grupo de Venda", "")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Colecoes", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Descs",    "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    loc_oPg.txt_4c_Col.Value   = ALLTRIM(Colecoes)
                    loc_oPg.txt_4c_DsCol.Value = ALLTRIM(Descs)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF
    ENDPROC

    *==========================================================================
    *  VALIDACAO E LOOKUP - Base / Nivel 1 (SigLcNv1: Cods / Descs)
    *==========================================================================

    PROCEDURE ValidarBase()
        LOCAL loc_oPg, loc_cCodigo, loc_cSQL, loc_nResult
        TRY
            loc_oPg     = THIS.pgf_4c_Paginas.Page1
            loc_cCodigo = ALLTRIM(loc_oPg.txt_4c_Base.Value)
            IF EMPTY(loc_cCodigo)
                loc_oPg.txt_4c_DsBase.Value = ""
                loc_oPg.txt_4c_Nvl2.Enabled = .F.
                RETURN
            ENDIF
            loc_cSQL    = "SELECT TOP 1 Cods, Descs FROM SigLcNv1 WHERE Cods = " + EscaparSQL(loc_cCodigo)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EtlBaseVal")
            IF loc_nResult > 0 AND !EOF("cursor_4c_EtlBaseVal")
                SELECT cursor_4c_EtlBaseVal
                loc_oPg.txt_4c_Base.Value   = ALLTRIM(Cods)
                loc_oPg.txt_4c_DsBase.Value = ALLTRIM(Descs)
                loc_oPg.txt_4c_Nvl2.Enabled = .T.
            ELSE
                MsgAviso("Base n" + CHR(227) + "o encontrada.", "Base")
                loc_oPg.txt_4c_Base.Value   = ""
                loc_oPg.txt_4c_DsBase.Value = ""
                loc_oPg.txt_4c_Nvl2.Enabled = .F.
                THIS.AbrirBuscaBase()
            ENDIF
            IF USED("cursor_4c_EtlBaseVal")
                USE IN cursor_4c_EtlBaseVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE AbrirBuscaBase()
        LOCAL loc_oBusca, loc_cValor, loc_oPg, loc_cCursor
        loc_cCursor = "cursor_4c_EtlBaseBusca"
        TRY
            loc_oPg    = THIS.pgf_4c_Paginas.Page1
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_Base.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigLcNv1", loc_cCursor, "Cods", loc_cValor, ;
                "Selecionar Base", "")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    loc_oPg.txt_4c_Base.Value   = ALLTRIM(Cods)
                    loc_oPg.txt_4c_DsBase.Value = ALLTRIM(Descs)
                    loc_oPg.txt_4c_Nvl2.Enabled = .T.
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF
    ENDPROC

    *==========================================================================
    *  VALIDACAO - Nivel 2 (usa crSigLcNv2 em memoria: Cods=parent, Codigo=nvl2)
    *==========================================================================

    PROCEDURE ValidarNvl2()
        LOCAL loc_oPg, loc_cCodigo, loc_cParent, loc_lEncontrou
        loc_lEncontrou = .F.
        TRY
            loc_oPg     = THIS.pgf_4c_Paginas.Page1
            loc_cCodigo = ALLTRIM(loc_oPg.txt_4c_Nvl2.Value)
            loc_cParent = ALLTRIM(loc_oPg.txt_4c_Base.Value)
            IF EMPTY(loc_cCodigo)
                loc_oPg.txt_4c_DsNvl2.Value = ""
                loc_oPg.txt_4c_Nvl3.Enabled = .F.
                RETURN
            ENDIF
            IF EMPTY(loc_cParent)
                MsgAviso("Informe a Base antes do Segundo N" + CHR(237) + "vel.", "")
                loc_oPg.txt_4c_Nvl2.Value   = ""
                loc_oPg.txt_4c_DsNvl2.Value = ""
                RETURN
            ENDIF
            IF USED("crSigLcNv2")
                SELECT * FROM crSigLcNv2 ;
                    WHERE ALLTRIM(crSigLcNv2.Cods) = loc_cParent ;
                    INTO CURSOR cursor_4c_LocalNv2 READWRITE
                IF !EOF("cursor_4c_LocalNv2")
                    SELECT cursor_4c_LocalNv2
                    LOCATE FOR ALLTRIM(Codigo) = loc_cCodigo
                    IF FOUND()
                        loc_oPg.txt_4c_Nvl2.Value   = ALLTRIM(Codigo)
                        loc_oPg.txt_4c_DsNvl2.Value = ALLTRIM(Descs)
                        loc_oPg.txt_4c_Nvl3.Enabled = .T.
                        loc_lEncontrou = .T.
                    ENDIF
                ENDIF
                IF USED("cursor_4c_LocalNv2")
                    USE IN cursor_4c_LocalNv2
                ENDIF
            ENDIF
            IF !loc_lEncontrou
                MsgAviso("N" + CHR(237) + "vel 2 n" + CHR(227) + "o encontrado para a Base informada.", "")
                loc_oPg.txt_4c_Nvl2.Value   = ""
                loc_oPg.txt_4c_DsNvl2.Value = ""
                loc_oPg.txt_4c_Nvl3.Enabled = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    *  VALIDACAO - Nivel 3 (usa crSigLcNv3 em memoria)
    *==========================================================================

    PROCEDURE ValidarNvl3()
        LOCAL loc_oPg, loc_cCodigo, loc_cParent, loc_lEncontrou
        loc_lEncontrou = .F.
        TRY
            loc_oPg     = THIS.pgf_4c_Paginas.Page1
            loc_cCodigo = ALLTRIM(loc_oPg.txt_4c_Nvl3.Value)
            loc_cParent = ALLTRIM(loc_oPg.txt_4c_Nvl2.Value)
            IF EMPTY(loc_cCodigo)
                loc_oPg.txt_4c_DsNvl3.Value = ""
                loc_oPg.txt_4c_Nvl4.Enabled = .F.
                RETURN
            ENDIF
            IF EMPTY(loc_cParent)
                MsgAviso("Informe o Segundo N" + CHR(237) + "vel antes do Terceiro.", "")
                loc_oPg.txt_4c_Nvl3.Value   = ""
                loc_oPg.txt_4c_DsNvl3.Value = ""
                RETURN
            ENDIF
            IF USED("crSigLcNv3")
                SELECT * FROM crSigLcNv3 ;
                    WHERE ALLTRIM(crSigLcNv3.Cods) = loc_cParent ;
                    INTO CURSOR cursor_4c_LocalNv3 READWRITE
                IF !EOF("cursor_4c_LocalNv3")
                    SELECT cursor_4c_LocalNv3
                    LOCATE FOR ALLTRIM(Codigo) = loc_cCodigo
                    IF FOUND()
                        loc_oPg.txt_4c_Nvl3.Value   = ALLTRIM(Codigo)
                        loc_oPg.txt_4c_DsNvl3.Value = ALLTRIM(Descs)
                        loc_oPg.txt_4c_Nvl4.Enabled = .T.
                        loc_lEncontrou = .T.
                    ENDIF
                ENDIF
                IF USED("cursor_4c_LocalNv3")
                    USE IN cursor_4c_LocalNv3
                ENDIF
            ENDIF
            IF !loc_lEncontrou
                MsgAviso("N" + CHR(237) + "vel 3 n" + CHR(227) + "o encontrado para o N" + CHR(237) + "vel 2 informado.", "")
                loc_oPg.txt_4c_Nvl3.Value   = ""
                loc_oPg.txt_4c_DsNvl3.Value = ""
                loc_oPg.txt_4c_Nvl4.Enabled = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    *  VALIDACAO - Nivel 4 (usa crSigLcNv4 em memoria)
    *==========================================================================

    PROCEDURE ValidarNvl4()
        LOCAL loc_oPg, loc_cCodigo, loc_cParent, loc_lEncontrou
        loc_lEncontrou = .F.
        TRY
            loc_oPg     = THIS.pgf_4c_Paginas.Page1
            loc_cCodigo = ALLTRIM(loc_oPg.txt_4c_Nvl4.Value)
            loc_cParent = ALLTRIM(loc_oPg.txt_4c_Nvl3.Value)
            IF EMPTY(loc_cCodigo)
                loc_oPg.txt_4c_DsNvl4.Value = ""
                RETURN
            ENDIF
            IF EMPTY(loc_cParent)
                MsgAviso("Informe o Terceiro N" + CHR(237) + "vel antes do Quarto.", "")
                loc_oPg.txt_4c_Nvl4.Value   = ""
                loc_oPg.txt_4c_DsNvl4.Value = ""
                RETURN
            ENDIF
            IF USED("crSigLcNv4")
                SELECT * FROM crSigLcNv4 ;
                    WHERE ALLTRIM(crSigLcNv4.Cods) = loc_cParent ;
                    INTO CURSOR cursor_4c_LocalNv4 READWRITE
                IF !EOF("cursor_4c_LocalNv4")
                    SELECT cursor_4c_LocalNv4
                    LOCATE FOR ALLTRIM(Codigo) = loc_cCodigo
                    IF FOUND()
                        loc_oPg.txt_4c_Nvl4.Value   = ALLTRIM(Codigo)
                        loc_oPg.txt_4c_DsNvl4.Value = ALLTRIM(Descs)
                        loc_lEncontrou = .T.
                    ENDIF
                ENDIF
                IF USED("cursor_4c_LocalNv4")
                    USE IN cursor_4c_LocalNv4
                ENDIF
            ENDIF
            IF !loc_lEncontrou
                MsgAviso("N" + CHR(237) + "vel 4 n" + CHR(227) + "o encontrado para o N" + CHR(237) + "vel 3 informado.", "")
                loc_oPg.txt_4c_Nvl4.Value   = ""
                loc_oPg.txt_4c_DsNvl4.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    *  VALIDACAO E LOOKUP - Localizacao direta (SigPrLcl: Codigos / Descricaos)
    *==========================================================================

    PROCEDURE ValidarLocal()
        LOCAL loc_oPg, loc_cCodigo, loc_cSQL, loc_nResult
        TRY
            loc_oPg     = THIS.pgf_4c_Paginas.Page1
            loc_cCodigo = ALLTRIM(loc_oPg.txt_4c_Local.Value)
            IF EMPTY(loc_cCodigo)
                loc_oPg.txt_4c_DsLocal.Value = ""
                RETURN
            ENDIF
            loc_cSQL    = "SELECT TOP 1 Codigos, Descricaos FROM SigPrLcl WHERE Codigos = " + EscaparSQL(loc_cCodigo)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EtlLocalVal")
            IF loc_nResult > 0 AND !EOF("cursor_4c_EtlLocalVal")
                SELECT cursor_4c_EtlLocalVal
                loc_oPg.txt_4c_Local.Value   = ALLTRIM(Codigos)
                loc_oPg.txt_4c_DsLocal.Value = ALLTRIM(Descricaos)
            ELSE
                MsgAviso("Localiza" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada.", ;
                         "Localiza" + CHR(231) + CHR(227) + "o")
                loc_oPg.txt_4c_Local.Value   = ""
                loc_oPg.txt_4c_DsLocal.Value = ""
                THIS.AbrirBuscaLocal()
            ENDIF
            IF USED("cursor_4c_EtlLocalVal")
                USE IN cursor_4c_EtlLocalVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE AbrirBuscaLocal()
        LOCAL loc_oBusca, loc_cValor, loc_oPg, loc_cCursor
        loc_cCursor = "cursor_4c_EtlLocalBusca"
        TRY
            loc_oPg    = THIS.pgf_4c_Paginas.Page1
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_Local.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigPrLcl", loc_cCursor, "Codigos", loc_cValor, ;
                "Selecionar Localiza" + CHR(231) + CHR(227) + "o", "")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Codigos",    "", "Localiza" + CHR(231) + CHR(227) + "o")
                loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    loc_oPg.txt_4c_Local.Value   = ALLTRIM(Codigos)
                    loc_oPg.txt_4c_DsLocal.Value = ALLTRIM(Descricaos)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF
    ENDPROC

    *==========================================================================
    *  VALIDACAO E LOOKUP - Grande Grupo (SigCdGpr: codigos / descs)
    *==========================================================================

    PROCEDURE ValidarCSGru()
        LOCAL loc_oPg, loc_cCodigo, loc_cSQL, loc_nResult
        TRY
            loc_oPg     = THIS.pgf_4c_Paginas.Page1
            loc_cCodigo = ALLTRIM(loc_oPg.txt_4c_CSGru.Value)
            IF EMPTY(loc_cCodigo)
                loc_oPg.txt_4c_DsSGru.Value = ""
                RETURN
            ENDIF
            loc_cSQL    = "SELECT TOP 1 codigos, descs FROM SigCdGpr WHERE codigos = " + EscaparSQL(loc_cCodigo)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EtlGGrpVal")
            IF loc_nResult > 0 AND !EOF("cursor_4c_EtlGGrpVal")
                SELECT cursor_4c_EtlGGrpVal
                loc_oPg.txt_4c_CSGru.Value  = ALLTRIM(codigos)
                loc_oPg.txt_4c_DsSGru.Value = ALLTRIM(descs)
            ELSE
                MsgAviso("Grande Grupo n" + CHR(227) + "o encontrado.", "Grande Grupo")
                loc_oPg.txt_4c_CSGru.Value  = ""
                loc_oPg.txt_4c_DsSGru.Value = ""
                THIS.AbrirBuscaCSGru()
            ENDIF
            IF USED("cursor_4c_EtlGGrpVal")
                USE IN cursor_4c_EtlGGrpVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE AbrirBuscaCSGru()
        LOCAL loc_oBusca, loc_cValor, loc_oPg, loc_cCursor
        loc_cCursor = "cursor_4c_EtlGGrpBusca"
        TRY
            loc_oPg    = THIS.pgf_4c_Paginas.Page1
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_CSGru.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGpr", loc_cCursor, "codigos", loc_cValor, ;
                "Grandes Grupos", "")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    loc_oPg.txt_4c_CSGru.Value  = ALLTRIM(codigos)
                    loc_oPg.txt_4c_DsSGru.Value = ALLTRIM(descs)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF
    ENDPROC

    *==========================================================================
    *  VALIDACAO E LOOKUP - Grupo de Produto (SigCdGrp: CGrus / DGrus)
    *==========================================================================

    PROCEDURE ValidarCgru()
        LOCAL loc_oPg, loc_cCodigo, loc_cSQL, loc_nResult
        TRY
            loc_oPg     = THIS.pgf_4c_Paginas.Page1
            loc_cCodigo = ALLTRIM(loc_oPg.txt_4c_Cgru.Value)
            IF EMPTY(loc_cCodigo)
                loc_oPg.txt_4c_Dgru.Value = ""
                RETURN
            ENDIF
            loc_cSQL    = "SELECT TOP 1 CGrus, DGrus FROM SigCdGrp WHERE CGrus = " + EscaparSQL(loc_cCodigo)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EtlCgruVal")
            IF loc_nResult > 0 AND !EOF("cursor_4c_EtlCgruVal")
                SELECT cursor_4c_EtlCgruVal
                loc_oPg.txt_4c_Cgru.Value = ALLTRIM(CGrus)
                loc_oPg.txt_4c_Dgru.Value = ALLTRIM(DGrus)
            ELSE
                MsgAviso("Grupo de Produto n" + CHR(227) + "o encontrado.", "Grupo de Produto")
                loc_oPg.txt_4c_Cgru.Value = ""
                loc_oPg.txt_4c_Dgru.Value = ""
                THIS.AbrirBuscaCgru()
            ENDIF
            IF USED("cursor_4c_EtlCgruVal")
                USE IN cursor_4c_EtlCgruVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE AbrirBuscaCgru()
        LOCAL loc_oBusca, loc_cValor, loc_oPg, loc_cCursor
        loc_cCursor = "cursor_4c_EtlCgruBusca"
        TRY
            loc_oPg    = THIS.pgf_4c_Paginas.Page1
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_Cgru.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGrp", loc_cCursor, "CGrus", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o", "")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    loc_oPg.txt_4c_Cgru.Value = ALLTRIM(CGrus)
                    loc_oPg.txt_4c_Dgru.Value = ALLTRIM(DGrus)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF
    ENDPROC

    *==========================================================================
    *  VALIDACAO E LOOKUP - Subgrupo (SigCdPsg: Codigos / Descricaos)
    *==========================================================================

    PROCEDURE ValidarCSubG()
        LOCAL loc_oPg, loc_cCodigo, loc_cCgruFiltro, loc_cSQL, loc_nResult
        TRY
            loc_oPg         = THIS.pgf_4c_Paginas.Page1
            loc_cCodigo     = ALLTRIM(loc_oPg.txt_4c_CSubG.Value)
            loc_cCgruFiltro = ALLTRIM(loc_oPg.txt_4c_Cgru.Value)
            IF EMPTY(loc_cCodigo)
                loc_oPg.txt_4c_DSubG.Value = ""
                RETURN
            ENDIF
            IF EMPTY(loc_cCgruFiltro)
                loc_cSQL = "SELECT TOP 1 Codigos, Descricaos FROM SigCdPsg WHERE Codigos = " + ;
                           EscaparSQL(loc_cCodigo)
            ELSE
                loc_cSQL = "SELECT TOP 1 Codigos, Descricaos FROM SigCdPsg WHERE Codigos = " + ;
                           EscaparSQL(loc_cCodigo) + " AND CGrus = " + EscaparSQL(loc_cCgruFiltro)
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EtlSGrpVal")
            IF loc_nResult > 0 AND !EOF("cursor_4c_EtlSGrpVal")
                SELECT cursor_4c_EtlSGrpVal
                loc_oPg.txt_4c_CSubG.Value = ALLTRIM(Codigos)
                loc_oPg.txt_4c_DSubG.Value = ALLTRIM(Descricaos)
            ELSE
                MsgAviso("Subgrupo n" + CHR(227) + "o encontrado.", "Subgrupo")
                loc_oPg.txt_4c_CSubG.Value = ""
                loc_oPg.txt_4c_DSubG.Value = ""
                THIS.AbrirBuscaCSubG()
            ENDIF
            IF USED("cursor_4c_EtlSGrpVal")
                USE IN cursor_4c_EtlSGrpVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE AbrirBuscaCSubG()
        LOCAL loc_oBusca, loc_cValor, loc_oPg, loc_cCursor
        loc_cCursor = "cursor_4c_EtlSGrpBusca"
        TRY
            loc_oPg    = THIS.pgf_4c_Paginas.Page1
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_CSubG.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPsg", loc_cCursor, "Codigos", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o", "")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    loc_oPg.txt_4c_CSubG.Value = ALLTRIM(Codigos)
                    loc_oPg.txt_4c_DSubG.Value = ALLTRIM(Descricaos)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF
    ENDPROC

    *==========================================================================
    *  VALIDACAO E LOOKUP - Produto (SigCdPro: CPros / DPros)
    *==========================================================================

    PROCEDURE ValidarCdProduto()
        LOCAL loc_oPg, loc_cCodigo, loc_cSQL, loc_nResult
        TRY
            loc_oPg     = THIS.pgf_4c_Paginas.Page1
            loc_cCodigo = ALLTRIM(loc_oPg.txt_4c_CdProduto.Value)
            IF EMPTY(loc_cCodigo)
                loc_oPg.txt_4c_DsProduto.Value = ""
                RETURN
            ENDIF
            loc_cSQL    = "SELECT TOP 1 CPros, DPros FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCodigo)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EtlProVal")
            IF loc_nResult > 0 AND !EOF("cursor_4c_EtlProVal")
                SELECT cursor_4c_EtlProVal
                loc_oPg.txt_4c_CdProduto.Value = ALLTRIM(CPros)
                loc_oPg.txt_4c_DsProduto.Value = ALLTRIM(DPros)
            ELSE
                MsgAviso("Produto n" + CHR(227) + "o encontrado.", "Produto")
                loc_oPg.txt_4c_CdProduto.Value = ""
                loc_oPg.txt_4c_DsProduto.Value = ""
                THIS.AbrirBuscaCdProduto()
            ENDIF
            IF USED("cursor_4c_EtlProVal")
                USE IN cursor_4c_EtlProVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE AbrirBuscaCdProduto()
        LOCAL loc_oBusca, loc_cValor, loc_oPg, loc_cCursor
        loc_cCursor = "cursor_4c_EtlProBusca"
        TRY
            loc_oPg    = THIS.pgf_4c_Paginas.Page1
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_CdProduto.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPro", loc_cCursor, "CPros", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o", "")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    loc_oPg.txt_4c_CdProduto.Value = ALLTRIM(CPros)
                    loc_oPg.txt_4c_DsProduto.Value = ALLTRIM(DPros)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF
    ENDPROC

    *==========================================================================
    *  VALIDACAO E LOOKUP - Fornecedor (SigCdCli: iclis / rclis)
    *==========================================================================

    PROCEDURE ValidarForn()
        LOCAL loc_oPg, loc_cCodigo, loc_cSQL, loc_nResult
        TRY
            loc_oPg     = THIS.pgf_4c_Paginas.Page1
            loc_cCodigo = ALLTRIM(loc_oPg.txt_4c_Forn.Value)
            IF EMPTY(loc_cCodigo)
                loc_oPg.txt_4c_DsForn.Value = ""
                RETURN
            ENDIF
            loc_cSQL    = "SELECT TOP 1 iclis, rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cCodigo)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EtlFornVal")
            IF loc_nResult > 0 AND !EOF("cursor_4c_EtlFornVal")
                SELECT cursor_4c_EtlFornVal
                loc_oPg.txt_4c_Forn.Value   = ALLTRIM(iclis)
                loc_oPg.txt_4c_DsForn.Value = ALLTRIM(rclis)
            ELSE
                MsgAviso("Fornecedor n" + CHR(227) + "o encontrado.", "Fornecedor")
                loc_oPg.txt_4c_Forn.Value   = ""
                loc_oPg.txt_4c_DsForn.Value = ""
                THIS.AbrirBuscaForn()
            ENDIF
            IF USED("cursor_4c_EtlFornVal")
                USE IN cursor_4c_EtlFornVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE AbrirBuscaForn()
        LOCAL loc_oBusca, loc_cValor, loc_oPg, loc_cCursor
        loc_cCursor = "cursor_4c_EtlFornBusca"
        TRY
            loc_oPg    = THIS.pgf_4c_Paginas.Page1
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_Forn.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", loc_cCursor, "iclis", loc_cValor, ;
                "Selecionar Fornecedor", "")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("rclis", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    loc_oPg.txt_4c_Forn.Value   = ALLTRIM(iclis)
                    loc_oPg.txt_4c_DsForn.Value = ALLTRIM(rclis)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF
    ENDPROC

    *==========================================================================
    *  MAPEAMENTO FORM -> BO e VALIDACAO PRE-RELATORIO
    *==========================================================================

    PROCEDURE FormParaRelatorio()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            WITH THIS.this_oRelatorio
                .this_cEmpresa      = ALLTRIM(loc_oPg.txt_4c_Empresa.Value)
                .this_cDEmpresa     = ALLTRIM(loc_oPg.txt_4c_DsEmpresa.Value)
                .this_cGrupo        = ALLTRIM(loc_oPg.txt_4c_Grupo.Value)
                .this_cDGrupo       = ALLTRIM(loc_oPg.txt_4c_DsGrupo.Value)
                .this_cConta        = ALLTRIM(loc_oPg.txt_4c_Conta.Value)
                .this_cDConta       = ALLTRIM(loc_oPg.txt_4c_DsConta.Value)
                .this_cCol          = ALLTRIM(loc_oPg.txt_4c_Col.Value)
                .this_cDCol         = ALLTRIM(loc_oPg.txt_4c_DsCol.Value)
                .this_cBase         = ALLTRIM(loc_oPg.txt_4c_Base.Value)
                .this_cDBase        = ALLTRIM(loc_oPg.txt_4c_DsBase.Value)
                .this_cNvl2         = ALLTRIM(loc_oPg.txt_4c_Nvl2.Value)
                .this_cDNvl2        = ALLTRIM(loc_oPg.txt_4c_DsNvl2.Value)
                .this_cNvl3         = ALLTRIM(loc_oPg.txt_4c_Nvl3.Value)
                .this_cDNvl3        = ALLTRIM(loc_oPg.txt_4c_DsNvl3.Value)
                .this_cNvl4         = ALLTRIM(loc_oPg.txt_4c_Nvl4.Value)
                .this_cDNvl4        = ALLTRIM(loc_oPg.txt_4c_DsNvl4.Value)
                .this_cLocal        = ALLTRIM(loc_oPg.txt_4c_Local.Value)
                .this_cDLocal       = ALLTRIM(loc_oPg.txt_4c_DsLocal.Value)
                .this_cCSGru        = ALLTRIM(loc_oPg.txt_4c_CSGru.Value)
                .this_cDSGru        = ALLTRIM(loc_oPg.txt_4c_DsSGru.Value)
                .this_cCgru         = ALLTRIM(loc_oPg.txt_4c_Cgru.Value)
                .this_cDgru         = ALLTRIM(loc_oPg.txt_4c_Dgru.Value)
                .this_cCSubG        = ALLTRIM(loc_oPg.txt_4c_CSubG.Value)
                .this_cDSubG        = ALLTRIM(loc_oPg.txt_4c_DSubG.Value)
                .this_cCdProduto    = ALLTRIM(loc_oPg.txt_4c_CdProduto.Value)
                .this_cDsProduto    = ALLTRIM(loc_oPg.txt_4c_DsProduto.Value)
                .this_cForn         = ALLTRIM(loc_oPg.txt_4c_Forn.Value)
                .this_cDForn        = ALLTRIM(loc_oPg.txt_4c_DsForn.Value)
                .this_nTipoRelatorio = loc_oPg.opt_4c_SinAna.Value
                .this_nSubTotais    = IIF(loc_oPg.chk_4c_Subtotais.Value = 1, 1, 0)
                .this_nOrdem        = loc_oPg.opt_4c_Ordem.Value
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE ValidarCampos()
        LOCAL loc_lResultado, loc_oPg
        loc_lResultado = .T.
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1

            IF EMPTY(ALLTRIM(loc_oPg.txt_4c_Empresa.Value))
                MsgErro("Empresa Inv" + CHR(225) + "lida !!!", "")
                loc_oPg.txt_4c_Empresa.SetFocus()
                loc_lResultado = .F.
            ENDIF

            IF loc_lResultado AND EMPTY(ALLTRIM(loc_oPg.txt_4c_Grupo.Value))
                MsgErro("Grupo Inv" + CHR(225) + "lido !!!", "")
                loc_oPg.txt_4c_Grupo.SetFocus()
                loc_lResultado = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    *  ACOES DOS BOTOES DO RELATORIO
    *==========================================================================

    PROCEDURE BtnVisualizarClick()
        TRY
            IF !THIS.ValidarCampos()
                RETURN
            ENDIF
            THIS.FormParaRelatorio()
            THIS.this_oRelatorio.Visualizar()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE BtnImprimirClick()
        TRY
            IF !THIS.ValidarCampos()
                RETURN
            ENDIF
            THIS.FormParaRelatorio()
            THIS.this_oRelatorio.Imprimir()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE BtnExcelClick()
        LOCAL loc_cArquivo
        TRY
            IF !THIS.ValidarCampos()
                RETURN
            ENDIF
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.PrepararDados()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                        "Relat" + CHR(243) + "rio")
                RETURN
            ENDIF
            IF !USED("CsImpressao") OR RECCOUNT("CsImpressao") = 0
                MsgAviso("Nenhum dado encontrado para os filtros selecionados.", "Excel")
                RETURN
            ENDIF
            SELECT CsImpressao
            loc_cArquivo = PUTFILE("Salvar como...", "EstoqueLocalizacao", "xls")
            IF EMPTY(loc_cArquivo)
                RETURN
            ENDIF
            COPY TO (loc_cArquivo) TYPE XL5
            MsgInfo("Arquivo exportado com sucesso:" + CHR(13) + loc_cArquivo, "Excel")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    *  STUBS CRUD - Compatibilidade com FormBase (form REPORT nao usa CRUD)
    *==========================================================================

    PROCEDURE ConfigurarPaginaLista()
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            THIS.pgf_4c_Paginas.Visible = .T.
            THIS.pgf_4c_Paginas.ActivePage = 1
        ENDIF
        RETURN
    ENDPROC

    PROCEDURE ConfigurarPaginaDados()
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            THIS.pgf_4c_Paginas.Visible = .T.
            THIS.pgf_4c_Paginas.ActivePage = 1
        ENDIF
        RETURN
    ENDPROC

    PROCEDURE AlternarPagina(par_nPagina)
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O" AND ;
           VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND ;
           par_nPagina <= THIS.pgf_4c_Paginas.PageCount
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
        ENDIF
    ENDPROC

    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    PROCEDURE AjustarBotoesPorModo()
        RETURN
    ENDPROC

    PROCEDURE HabilitarCampos(par_lHabilitar)
        RETURN
    ENDPROC

    PROCEDURE FormParaBO()
        RETURN
    ENDPROC

    PROCEDURE BOParaForm()
        RETURN
    ENDPROC

    PROCEDURE BtnIncluirClick()
        THIS.AlternarPagina(2)
    ENDPROC

    PROCEDURE BtnAlterarClick()
        RETURN
    ENDPROC

    PROCEDURE BtnExcluirClick()
        RETURN
    ENDPROC

    PROCEDURE BtnSalvarClick()
        RETURN
    ENDPROC

    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    PROCEDURE BtnBuscarClick()
        RETURN
    ENDPROC

    *==========================================================================
    *  CICLO DE VIDA
    *==========================================================================

    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigReEtlBO.prg):
*==============================================================================
* SIGREETLBO.PRG
* Business Object para Relatorio de Estoque Por Localizacao (SigReEtl)
*
* Herda de RelatorioBase
* Relatorio: SigReEt1 a SigReEt7 (selecao por tipo)
*==============================================================================

DEFINE CLASS SigReEtlBO AS RelatorioBase

    *-- Identificacao
    this_cMensagemErro  = ""
    this_cCursorDados   = "cursor_4c_Dados"
    this_cFRXAtual      = ""

    *-- Filtros: Empresa
    this_cEmpresa       = ""
    this_cDEmpresa      = ""

    *-- Filtros: Grupo contabilidade / Conta de estoque
    this_cGrupo         = ""
    this_cDGrupo        = ""
    this_cConta         = ""
    this_cDConta        = ""

    *-- Filtros: Grupo de Venda (Colecao - SigCdCol)
    this_cCol           = ""
    this_cDCol          = ""

    *-- Filtros: Localizacao hierarquica (Base=Nvl1, Nvl2, Nvl3, Nvl4)
    this_cBase          = ""
    this_cDBase         = ""
    this_cNvl2          = ""
    this_cDNvl2         = ""
    this_cNvl3          = ""
    this_cDNvl3         = ""
    this_cNvl4          = ""
    this_cDNvl4         = ""

    *-- Filtros: Localizacao direta (SigPrLcl)
    this_cLocal         = ""
    this_cDLocal        = ""

    *-- Filtros: Grande Grupo (SigCdGpr)
    this_cCSGru         = ""
    this_cDSGru         = ""

    *-- Filtros: Grupo de Produto (SigCdGrp)
    this_cCgru          = ""
    this_cDgru          = ""

    *-- Filtros: Subgrupo (SigCdPsg)
    this_cCSubG         = ""
    this_cDSubG         = ""

    *-- Filtros: Produto (SigCdPro)
    this_cCdProduto     = ""
    this_cDsProduto     = ""

    *-- Filtros: Fornecedor
    this_cForn          = ""
    this_cDForn         = ""

    *-- Opcoes: Tipo de relatorio (optSinAna)
    *   1=Sintetico  2=Analitico  3=Com Descricao  4=Estoque por Localizacao
    *   5=Analitico Com Descricao  6=Sintetico Com Descricao
    this_nTipoRelatorio = 1

    *-- Opcoes: SubTotais Grupo/Subgrupo (Opt_Subt - checkbox 0/1)
    this_nSubTotais     = 0

    *-- Opcoes: Ordenacao (OptOrdem)
    *   1=Primeiro Nivel  2=Segundo Nivel  3=Terceiro Nivel  4=Quarto Nivel
    this_nOrdem         = 1

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro registrada
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDadosIniciais - Carrega empresa, grupo, conta e hierarquia de
    * localizacao. Chamado pelo Form.InicializarForm() apos criar o BO.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDadosIniciais()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL, loc_oErro
        LOCAL loc_cGrupoEsts, loc_cContaEsts, loc_lOK
        loc_lSucesso = .F.
        TRY
            loc_lOK = .T.

            *-- Empresa
            loc_cSQL = "SELECT cemps, razas FROM SigCdEmp WHERE cemps = " + ;
                       EscaparSQL(go_4c_Sistema.cCodEmpresa)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CrSigCdEmp")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar empresa"
                loc_lOK = .F.
            ENDIF

            IF loc_lOK
                SELECT cursor_4c_CrSigCdEmp
                GO TOP
                IF !EOF()
                    THIS.this_cEmpresa  = ALLTRIM(cursor_4c_CrSigCdEmp.cemps)
                    THIS.this_cDEmpresa = ALLTRIM(cursor_4c_CrSigCdEmp.razas)
                ENDIF

                *-- Parametros: Grupo e Conta de estoque
                loc_cGrupoEsts = ""
                loc_cContaEsts = ""
                loc_nResult = SQLEXEC(gnConnHandle, "SELECT grupoests, contaests FROM SigCdPam", "cursor_4c_CrSigCdPam")
                IF loc_nResult > 0
                    SELECT cursor_4c_CrSigCdPam
                    GO TOP
                    IF !EOF()
                        loc_cGrupoEsts = ALLTRIM(cursor_4c_CrSigCdPam.grupoests)
                        loc_cContaEsts = ALLTRIM(cursor_4c_CrSigCdPam.contaests)
                    ENDIF
                ENDIF

                *-- Grupo de estoque
                IF !EMPTY(loc_cGrupoEsts)
                    loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = " + ;
                               EscaparSQL(loc_cGrupoEsts)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpGccr")
                    IF loc_nResult > 0
                        SELECT cursor_4c_TmpGccr
                        GO TOP
                        IF !EOF()
                            THIS.this_cGrupo  = ALLTRIM(cursor_4c_TmpGccr.codigos)
                            THIS.this_cDGrupo = ALLTRIM(cursor_4c_TmpGccr.descrs)
                        ENDIF
                    ENDIF
                ENDIF

                *-- Conta de estoque
                IF !EMPTY(loc_cContaEsts)
                    loc_cSQL = "SELECT iclis, rclis FROM SigCdCli WHERE iclis = " + ;
                               EscaparSQL(loc_cContaEsts)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCli")
                    IF loc_nResult > 0
                        SELECT cursor_4c_TmpCli
                        GO TOP
                        IF !EOF()
                            THIS.this_cConta  = ALLTRIM(cursor_4c_TmpCli.iclis)
                            THIS.this_cDConta = ALLTRIM(cursor_4c_TmpCli.rclis)
                        ENDIF
                    ENDIF
                ENDIF

                *-- Hierarquia de localizacao (niveis 1 a 4)
                SQLEXEC(gnConnHandle, "SELECT * FROM SigLcNv1", "csNivel1")
                SQLEXEC(gnConnHandle, "SELECT * FROM SigLcNv2", "csNivel2")
                SQLEXEC(gnConnHandle, "SELECT * FROM SigLcNv3", "csNivel3")
                SQLEXEC(gnConnHandle, "SELECT * FROM SigLcNv4", "csNivel4")

                *-- Cria cursors expandidos com campo Codigo adicional
                SELECT csNivel1
                SELECT *, SPACE(4) AS Codigo FROM csNivel1 WHERE 1=0 INTO CURSOR crSigLcNv1 READWRITE

                SELECT csNivel2
                SELECT *, SPACE(4) AS Codigo FROM csNivel2 WHERE 1=0 INTO CURSOR crSigLcNv2 READWRITE

                SELECT csNivel3
                SELECT *, SPACE(4) AS Codigo FROM csNivel3 WHERE 1=0 INTO CURSOR crSigLcNv3 READWRITE

                SELECT csNivel4
                SELECT *, SPACE(4) AS Codigo FROM csNivel4 WHERE 1=0 INTO CURSOR crSigLcNv4 READWRITE

                *-- Processa hierarquia XML
                THIS.ReverterXML("csNivel2", "csNivel1", "crSigLcNv2")
                THIS.ReverterXML("csNivel3", "csNivel2", "crSigLcNv3")
                THIS.ReverterXML("csNivel4", "csNivel3", "crSigLcNv4")

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "CarregarDadosIniciais")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta clausulas WHERE e executa queries conforme filtros.
    * Popula CsImpressao (dados) e csCabecalho (cabecalho) para os FRX files.
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_lOK, loc_cWhere, loc_cWhere2
        LOCAL loc_cSQL, loc_cSQL2, loc_nResult, loc_cLocNew, loc_oErro
        LOCAL loc_cNvl3Local
        loc_lSucesso = .F.
        TRY
            loc_lOK = .T.
            THIS.this_cMensagemErro = ""

            *-- Localizacao hierarquica composta (Base+Nvl2+Nvl3+Nvl4)
            loc_cLocNew = ALLTRIM(THIS.this_cBase) + ALLTRIM(THIS.this_cNvl2) + ;
                          ALLTRIM(THIS.this_cNvl3) + ALLTRIM(THIS.this_cNvl4)

            *-- WHERE para SigOpEtq (alias a) com join SigCdPro (alias B)
            loc_cWhere = "a.empos = '" + ALLTRIM(THIS.this_cEmpresa) + ;
                         "' AND a.grupos = '" + ALLTRIM(THIS.this_cGrupo) + "' "
            IF !EMPTY(THIS.this_cConta)
                loc_cWhere = loc_cWhere + "AND a.contas = '" + ALLTRIM(THIS.this_cConta) + "' "
            ENDIF
            IF !EMPTY(THIS.this_cLocal)
                loc_cWhere = loc_cWhere + "AND a.localizas LIKE '" + ALLTRIM(THIS.this_cLocal) + "%' "
            ENDIF
            IF !EMPTY(loc_cLocNew)
                loc_cWhere = loc_cWhere + "AND a.localizas LIKE '" + loc_cLocNew + "%' "
            ENDIF
            IF !EMPTY(THIS.this_cCgru)
                loc_cWhere = loc_cWhere + "AND B.Cgrus = '" + ALLTRIM(THIS.this_cCgru) + "' "
            ENDIF
            IF !EMPTY(THIS.this_cCSGru)
                loc_cWhere = loc_cWhere + "AND B.Mercs = '" + ALLTRIM(THIS.this_cCSGru) + "' "
            ENDIF
            IF !EMPTY(THIS.this_cCSubG)
                loc_cWhere = loc_cWhere + "AND B.SGrus = '" + ALLTRIM(THIS.this_cCSubG) + "' "
            ENDIF
            IF !EMPTY(THIS.this_cCdProduto)
                loc_cWhere = loc_cWhere + "AND B.Cpros = '" + ALLTRIM(THIS.this_cCdProduto) + "' "
            ENDIF
            IF !EMPTY(THIS.this_cForn)
                loc_cWhere = loc_cWhere + "AND B.IFors = '" + ALLTRIM(THIS.this_cForn) + "' "
            ENDIF
            IF !EMPTY(THIS.this_cCol)
                loc_cWhere = loc_cWhere + "AND B.Colecoes = '" + ALLTRIM(THIS.this_cCol) + "' "
            ENDIF

            *-- WHERE para SigMvesl (alias a) com join SigCdPro (alias b)
            loc_cWhere2 = "a.emps = '" + ALLTRIM(THIS.this_cEmpresa) + ;
                          "' AND a.grupos = '" + ALLTRIM(THIS.this_cGrupo) + "' "
            IF !EMPTY(THIS.this_cConta)
                loc_cWhere2 = loc_cWhere2 + "AND a.estos = '" + ALLTRIM(THIS.this_cConta) + "' "
            ENDIF
            IF !EMPTY(THIS.this_cLocal)
                loc_cWhere2 = loc_cWhere2 + "AND a.locals LIKE '" + ALLTRIM(THIS.this_cLocal) + "%' "
            ENDIF
            IF !EMPTY(loc_cLocNew)
                loc_cWhere2 = loc_cWhere2 + "AND a.locals LIKE '" + loc_cLocNew + "%' "
            ENDIF
            IF !EMPTY(THIS.this_cCgru)
                loc_cWhere2 = loc_cWhere2 + "AND B.Cgrus = '" + ALLTRIM(THIS.this_cCgru) + "' "
            ENDIF
            IF !EMPTY(THIS.this_cCSGru)
                loc_cWhere2 = loc_cWhere2 + "AND B.Mercs = '" + ALLTRIM(THIS.this_cCSGru) + "' "
            ENDIF
            IF !EMPTY(THIS.this_cCSubG)
                loc_cWhere2 = loc_cWhere2 + "AND B.SGrus = '" + ALLTRIM(THIS.this_cCSubG) + "' "
            ENDIF
            IF !EMPTY(THIS.this_cCdProduto)
                loc_cWhere2 = loc_cWhere2 + "AND B.Cpros = '" + ALLTRIM(THIS.this_cCdProduto) + "' "
            ENDIF
            IF !EMPTY(THIS.this_cForn)
                loc_cWhere2 = loc_cWhere2 + "AND B.IFors = '" + ALLTRIM(THIS.this_cForn) + "' "
            ENDIF
            IF !EMPTY(THIS.this_cCol)
                loc_cWhere2 = loc_cWhere2 + "AND B.Colecoes = '" + ALLTRIM(THIS.this_cCol) + "' "
            ENDIF

            *-- Monta cabecalho do relatorio
            THIS.MontarCabecalho()

            *-- Executa query conforme tipo de relatorio
            DO CASE
            CASE INLIST(THIS.this_nTipoRelatorio, 1, 6)
                *-- Sintetico / Sintetico Com Descricao: UNION ALL de SigOpEtq + SigMvesl
                loc_cSQL = "SELECT localizas, COUNT(1) AS qtde, 1 AS agrupar, SPACE(100) AS Descrs " + ;
                    "FROM SigOpEtq A " + ;
                    "LEFT JOIN (SELECT Cpros,Cgrus,Mercs,Colecoes,SGrus,IFors FROM SigCdPro) B " + ;
                    "ON b.cpros = a.cpros " + ;
                    "WHERE " + loc_cWhere + "GROUP BY A.localizas"

                loc_cSQL2 = "SELECT a.locals, SUM(a.sqtds) AS qtde, 1 AS agrupar, SPACE(100) AS Descrs " + ;
                    "FROM SigMvesl a, SigCdpro b " + ;
                    "WHERE a.CPros = b.Cpros AND " + loc_cWhere2 + ;
                    "AND a.Locals NOT IN(" + ;
                    "SELECT localizas FROM SigOpEtq A " + ;
                    "LEFT JOIN (SELECT Cpros,Cgrus,Mercs,Colecoes,SGrus,IFors FROM SigCdPro) B " + ;
                    "ON b.cpros = a.cpros " + ;
                    "WHERE " + loc_cWhere + "GROUP BY A.localizas" + ;
                    ") GROUP BY a.locals ORDER BY 1"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL + " UNION ALL " + loc_cSQL2, "CsDados1")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Erro ao executar query sint" + CHR(233) + "tico"
                    loc_lOK = .F.
                ENDIF

                IF loc_lOK
                    SELECT localizas, SUM(qtde) AS qtde, 2 AS agrupar, Descrs ;
                        FROM CsDados1 ;
                        GROUP BY 1, 3, 4 ;
                        INTO CURSOR CsDados2 READWRITE

                    SELECT localizas, qtde, agrupar, Descrs ;
                        FROM CsDados1 ;
                        UNION ALL ;
                        SELECT localizas, qtde, agrupar, Descrs ;
                        FROM CsDados2 ;
                        INTO CURSOR CsImpressao READWRITE
                ENDIF

            CASE INLIST(THIS.this_nTipoRelatorio, 2, 5)
                *-- Analitico / Analitico Com Descricao
                loc_cSQL = "SELECT a.localizas, a.cpros, a.cbars, " + ;
                    "ISNULL(c.cbars_old,0) AS Cbars_old, 1 AS agrupar, SPACE(100) AS Descrs " + ;
                    "FROM SigOpEtq A " + ;
                    "LEFT JOIN SigOpEta c ON a.cbars = c.cbars_new " + ;
                    "LEFT JOIN (SELECT Cpros AS Cpros2,Cgrus,Mercs,Colecoes,Sgrus,IFors FROM SigCdPro) B " + ;
                    "ON b.Cpros2 = a.cpros " + ;
                    "WHERE " + loc_cWhere + ;
                    "GROUP BY A.localizas, A.cbars, A.Cpros, c.cbars_old"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CsImpressao")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Erro ao executar query anal" + CHR(237) + "tico"
                    loc_lOK = .F.
                ENDIF
                IF loc_lOK
                    SELECT CsImpressao
                    INDEX ON localizas + ALLTRIM(STR(cbars)) TAG idxcsimp
                ENDIF

            CASE THIS.this_nTipoRelatorio = 3
                *-- Com Descricao
                loc_cSQL = "SELECT a.Localizas, a.CPros, a.CBars, " + ;
                    "ISNULL(c.cbars_old,0) AS Cbars_old, " + ;
                    "b.DPros, b.Reffs, b.PVens, b.CGrus, b.SGrus, 1 AS Agrupar " + ;
                    "FROM SigOpEtq a " + ;
                    "LEFT JOIN SigOpEta c ON a.cbars = c.cbars_new " + ;
                    ", SigCdpro b " + ;
                    "WHERE a.CPros = b.Cpros AND " + loc_cWhere + ;
                    "GROUP BY a.Localizas, a.CBars, a.CPros, " + ;
                    "b.DPros, b.Reffs, b.PVens, b.CGrus, b.SGrus, c.cbars_old"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CsImpressao")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Erro ao executar query com descri" + CHR(231) + CHR(227) + "o"
                    loc_lOK = .F.
                ENDIF
                IF loc_lOK
                    IF THIS.this_nSubTotais = 0
                        SELECT CsImpressao
                        INDEX ON localizas + ALLTRIM(STR(cbars)) TAG idxcsimp
                    ELSE
                        SELECT CsImpressao
                        INDEX ON localizas + cgrus + sgrus TAG idxLGS
                    ENDIF
                ENDIF

            CASE THIS.this_nTipoRelatorio = 4
                *-- Estoque por Localizacao (SigMvesl)
                loc_cSQL = "SELECT a.*, b.DPros, b.Reffs, b.PVens, b.PCuss, b.CGrus, b.SGrus " + ;
                    "FROM SigMvesl a, SigCdpro b " + ;
                    "WHERE a.CPros = b.Cpros AND " + loc_cWhere2 + ;
                    "ORDER BY a.grupos, a.estos, a.locals, a.cpros"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CsImpressao")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Erro ao executar query estoque por localiza" + CHR(231) + CHR(227) + "o"
                    loc_lOK = .F.
                ENDIF
            ENDCASE

            IF loc_lOK
                SELECT CsImpressao
                GO TOP

                *-- Enriquece com descricoes de nivel 3 para tipos 5 e 6
                IF INLIST(THIS.this_nTipoRelatorio, 5, 6)
                    SELECT CsImpressao
                    SCAN
                        loc_cNvl3Local = SUBSTR(CsImpressao.localizas, 5, 2)
                        IF !EMPTY(loc_cNvl3Local) .AND. USED("csNivel3")
                            SELECT csNivel3
                            LOCATE FOR Cods = loc_cNvl3Local
                            IF FOUND()
                                REPLACE Descrs WITH csNivel3.Descs IN CsImpressao
                            ENDIF
                        ENDIF
                        SELECT CsImpressao
                    ENDSCAN
                ENDIF

                *-- Indexa para ordenacao por nivel
                SELECT CsImpressao
                INDEX ON localizas TAG localizas
                INDEX ON SUBSTR(localizas, 3, 2) TAG Nivel2s
                INDEX ON SUBSTR(localizas, 5, 2) TAG Nivel3s
                INDEX ON SUBSTR(localizas, 7, 4) TAG Nivel4s
                GO TOP

                *-- Define ordenacao conforme selecao do usuario
                DO CASE
                CASE THIS.this_nOrdem = 1
                    SET ORDER TO localizas
                CASE THIS.this_nOrdem = 2
                    SET ORDER TO Nivel2s
                CASE THIS.this_nOrdem = 3
                    SET ORDER TO Nivel3s
                CASE THIS.this_nOrdem = 4
                    SET ORDER TO Nivel4s
                ENDCASE
                GO TOP IN CsImpressao

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarCabecalho - Cria cursor csCabecalho com informacoes do relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarCabecalho()
        LOCAL loc_cTit, loc_cSub, loc_cSub2, loc_cCep, loc_cChr
        loc_cChr = CHR(13) + CHR(10)

        loc_cTit = "Relat" + CHR(243) + "rio de Estoque Por Localiza" + CHR(231) + CHR(227) + "o"

        loc_cSub = "Empresa: " + ALLTRIM(THIS.this_cEmpresa) + "-" + ALLTRIM(THIS.this_cDEmpresa) + loc_cChr + ;
            "Grupo: " + ALLTRIM(THIS.this_cGrupo) + "-" + ALLTRIM(THIS.this_cDGrupo) + loc_cChr + ;
            IIF(!EMPTY(THIS.this_cConta), ;
                "Conta: " + ALLTRIM(THIS.this_cConta) + "-" + ALLTRIM(THIS.this_cDConta) + loc_cChr, "") + ;
            "Localiza" + CHR(231) + CHR(227) + "o: " + ;
            IIF(EMPTY(THIS.this_cLocal), "Global", ALLTRIM(THIS.this_cLocal) + "-" + ALLTRIM(THIS.this_cDLocal))

        loc_cSub2 = "Grande Grupo: " + ;
            IIF(EMPTY(THIS.this_cCSGru), "Global", ALLTRIM(THIS.this_cCSGru) + "-" + ALLTRIM(THIS.this_cDSGru)) + loc_cChr + ;
            "Grupo Produto: " + ;
            IIF(EMPTY(THIS.this_cCgru), "Global", ALLTRIM(THIS.this_cCgru) + "-" + ALLTRIM(THIS.this_cDgru)) + loc_cChr + ;
            "Subgrupo: " + ;
            IIF(EMPTY(THIS.this_cCSubG), "Global", ALLTRIM(THIS.this_cCSubG) + "-" + ALLTRIM(THIS.this_cDSubG)) + loc_cChr + ;
            "Grupo de Venda: " + ;
            IIF(EMPTY(THIS.this_cCol), "Global", ALLTRIM(THIS.this_cCol) + "-" + ALLTRIM(THIS.this_cDCol)) + loc_cChr + ;
            "Fornecedor: " + ;
            IIF(EMPTY(THIS.this_cForn), "Global", ALLTRIM(THIS.this_cForn) + "-" + ALLTRIM(THIS.this_cDForn))

        loc_cCep = ALLTRIM(go_4c_Sistema.cCodEmpresa)
        IF USED("cursor_4c_CrSigCdEmp")
            SELECT cursor_4c_CrSigCdEmp
            GO TOP
            IF !EOF()
                IF !EMPTY(ALLTRIM(cursor_4c_CrSigCdEmp.razas))
                    loc_cCep = loc_cCep + "-" + ALLTRIM(cursor_4c_CrSigCdEmp.razas)
                ENDIF
            ENDIF
        ENDIF

        IF USED("csCabecalho")
            USE IN csCabecalho
        ENDIF
        CREATE CURSOR csCabecalho ;
            (titulo C(100), subtitulo C(150), subtitulo2 C(150), empresa C(80))
        INSERT INTO csCabecalho (titulo, subtitulo, subtitulo2, empresa) ;
            VALUES (loc_cTit, loc_cSub, loc_cSub2, loc_cCep)
    ENDPROC

    *--------------------------------------------------------------------------
    * SelecionarFRX - Retorna nome do FRX a executar conforme tipo e subtotais
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE SelecionarFRX()
        LOCAL loc_cFRX
        DO CASE
        CASE THIS.this_nTipoRelatorio = 1
            loc_cFRX = "SigReEt1"
        CASE THIS.this_nTipoRelatorio = 2
            loc_cFRX = "SigReEt2"
        CASE THIS.this_nTipoRelatorio = 3 .AND. THIS.this_nSubTotais = 0
            loc_cFRX = "SigReEt3"
        CASE THIS.this_nTipoRelatorio = 3 .AND. THIS.this_nSubTotais = 1
            loc_cFRX = "SigReEt5"
        CASE THIS.this_nTipoRelatorio = 4
            loc_cFRX = "SigReEt4"
        CASE THIS.this_nTipoRelatorio = 5
            loc_cFRX = "SigReEt6"
        CASE THIS.this_nTipoRelatorio = 6
            loc_cFRX = "SigReEt7"
        OTHERWISE
            loc_cFRX = "SigReEt1"
        ENDCASE
        RETURN loc_cFRX
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_cFRX, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cFRX = THIS.SelecionarFRX()
                REPORT FORM (loc_cFRX) TO PRINT PROMPT NOCONSOLE
                THIS.RegistrarAuditoria("IMPRIMIR")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe preview do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_cFRX, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cFRX = THIS.SelecionarFRX()
                REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
                THIS.RegistrarAuditoria("VISUALIZAR")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Documento - Prepara dados e imprime direto na impressora padrao (sem dialogo)
    *--------------------------------------------------------------------------
    PROCEDURE Documento()
        LOCAL loc_lSucesso, loc_cFRX, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cFRX = THIS.SelecionarFRX()
                REPORT FORM (loc_cFRX) TO PRINT NOCONSOLE
                THIS.RegistrarAuditoria("DOCUMENTO")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Documento")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna identificacao do relatorio executado.
    * Em BO de relatorio, compoe a chave com empresa+grupo+tipo para auditoria.
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ALLTRIM(THIS.this_cEmpresa) + "|" + ;
                     ALLTRIM(THIS.this_cGrupo) + "|" + ;
                     "T" + ALLTRIM(STR(THIS.this_nTipoRelatorio))
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra execucao do relatorio no LogAuditoria.
    * Reportos sao apenas-leitura: a auditoria captura quem rodou e quando.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cUsuario, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") == "C", ;
                               gc_4c_UsuarioLogado, "SISTEMA")
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Usuario, DataHora, Operacao, Tabela, ChaveRegistro) " + ;
                       "VALUES (" + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL("SigReEtl") + ", " + ;
                       EscaparSQL(THIS.ObterChavePrimaria()) + ")"
            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - NAO APLICAVEL para BO de relatorio.
    * Stub para compatibilidade com pipeline de migracao.
    * Relatorios obtem dados via PrepararDados() agregando multiplas tabelas
    * (SigOpEtq, SigMvesl, SigCdPro, SigCdEmp, SigCdPam, SigLcNv1..4).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        THIS.this_cMensagemErro = "CarregarDoCursor n" + CHR(227) + ;
                                  "o aplic" + CHR(225) + "vel para relat" + ;
                                  CHR(243) + "rio de Estoque por Localiza" + ;
                                  CHR(231) + CHR(227) + "o"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - NAO APLICAVEL para BO de relatorio (apenas leitura).
    * Stub para compatibilidade com pipeline de migracao.
    * A auditoria de execucao eh registrada por RegistrarAuditoria em
    * Imprimir() e Visualizar().
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Inserir n" + CHR(227) + ;
                                  "o aplic" + CHR(225) + ;
                                  "vel para relat" + CHR(243) + "rio"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - NAO APLICAVEL para BO de relatorio (apenas leitura).
    * Stub para compatibilidade com pipeline de migracao.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Atualizar n" + CHR(227) + ;
                                  "o aplic" + CHR(225) + ;
                                  "vel para relat" + CHR(243) + "rio"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ReverterXML - Processa hierarquia de localizacao a partir de dados XML.
    * Reproduz logica do procedimento reverterxml do form original SIGREETL.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ReverterXML(par_cCursor, par_cNivAnt, par_cCurDest)
        LOCAL loc_nOldSel, loc_cXML, loc_oErro
        loc_nOldSel = SELECT()
        TRY
            IF USED("cursor_4c_Aux")
                USE IN cursor_4c_Aux
            ENDIF

            SELECT (par_cCursor)
            SELECT cidchaves, Cods, Descs, 0 AS Marcas, SPACE(4) AS Codigo ;
                FROM (par_cCursor) ;
                WHERE 1=0 ;
                INTO CURSOR cursor_4c_Aux READWRITE

            SELECT (par_cCursor)
            GO TOP

            SCAN
                loc_cXML = NVL(&par_cCursor..Nivel, "")
                ZAP IN cursor_4c_Aux
                IF !EMPTY(loc_cXML)
                    = fXmlToCursor(loc_cXML, "cursor_4c_Aux", .F.)
                    SELECT cursor_4c_Aux
                    SCAN FOR cursor_4c_Aux.Marcas <> 0
                        SELECT (par_cCurDest)
                        APPEND BLANK
                        REPLACE Cods      WITH cursor_4c_Aux.Cods, ;
                                Descs     WITH &par_cCursor..Descs, ;
                                CidChaves WITH cursor_4c_Aux.CidChaves, ;
                                Codigo    WITH &par_cCursor..Cods
                        SELECT cursor_4c_Aux
                    ENDSCAN
                ENDIF
            ENDSCAN

            SELECT (par_cNivAnt)
            GO TOP

            IF USED("cursor_4c_Aux")
                USE IN cursor_4c_Aux
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ReverterXML")
        ENDTRY
        SELECT (loc_nOldSel)
    ENDPROC

ENDDEFINE

