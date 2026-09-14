# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'ModoVisualizar': Property AJUSTARBOTOESPORMODO is not found. | Detalhes: Linha: 542

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-06-06 02:21:23] [INFO] === VFP EXECUTOR v2.0 ===
[2026-06-06 02:21:23] [INFO] Config FPW: (nao fornecido)
[2026-06-06 02:21:23] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-06-06 02:21:23] [INFO] Timeout: 300 segundos
[2026-06-06 02:21:23] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_znpsv5gj.prg
[2026-06-06 02:21:23] [INFO] Conteudo do wrapper:
[2026-06-06 02:21:23] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigrehpr', 'C:\4c\tasks\task114', 'REPORT'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigrehpr', 'C:\4c\tasks\task114', 'REPORT'
QUIT

[2026-06-06 02:21:23] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_znpsv5gj.prg
[2026-06-06 02:21:23] [INFO] VFP output esperado em: C:\4c\tasks\task114\vfp_output.txt
[2026-06-06 02:21:23] [INFO] Executando Visual FoxPro 9...
[2026-06-06 02:21:23] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_znpsv5gj.prg
[2026-06-06 02:21:23] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_znpsv5gj.prg
[2026-06-06 02:21:23] [INFO] Timeout configurado: 300 segundos
[2026-06-06 02:21:32] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-06-06 02:21:32] [INFO] VFP9 finalizado em 8.3141868 segundos
[2026-06-06 02:21:32] [INFO] Exit Code: 
[2026-06-06 02:21:32] [INFO] 
[2026-06-06 02:21:32] [INFO] Arquivos temporarios preservados para inspecao:
[2026-06-06 02:21:32] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_znpsv5gj.prg
[2026-06-06 02:21:32] [INFO] 
[2026-06-06 02:21:32] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-06-06 02:21:32] [INFO] * Auto-generated wrapper for parameters
[2026-06-06 02:21:32] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-06-06 02:21:32] [INFO] * Parameters: 'Formsigrehpr', 'C:\4c\tasks\task114', 'REPORT'
[2026-06-06 02:21:32] [INFO] 
[2026-06-06 02:21:32] [INFO] * Anti-dialog protections for unattended execution
[2026-06-06 02:21:32] [INFO] SET SAFETY OFF
[2026-06-06 02:21:32] [INFO] SET RESOURCE OFF
[2026-06-06 02:21:32] [INFO] SET TALK OFF
[2026-06-06 02:21:32] [INFO] SET NOTIFY OFF
[2026-06-06 02:21:32] [INFO] SYS(2335, 0)
[2026-06-06 02:21:32] [INFO] 
[2026-06-06 02:21:32] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigrehpr', 'C:\4c\tasks\task114', 'REPORT'
[2026-06-06 02:21:32] [INFO] QUIT
[2026-06-06 02:21:32] [INFO] 
[2026-06-06 02:21:32] [INFO] === Fim do Wrapper.prg ===
[2026-06-06 02:21:32] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formsigrehpr",
  "timestamp": "20260606022131",
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
      "passou": false,
      "erro": "Property AJUSTARBOTOESPORMODO is not found.",
      "detalhes": "Linha: 542"
    },
    {
      "nome": "BtnIncluirNavegacao",
      "passou": true,
      "erro": "",
      "detalhes": "Form REPORT com BtnIncluirClick sem navegacao por PageFrame (OK)"
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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrehpr.prg):
*==============================================================================
* FORMSIGREHPR.PRG
* Formulario: Relat CHR(243)rio de Hist CHR(243)rico de Produtos
* Herda de: FormBase
* Tipo: REPORT (frmrelatorio - layout FLAT, sem PageFrame)
* BO: sigrehprBO
* FRX: SigRehp1.frx (sem peso) / SigRehp2.frx (com peso)
* Migrado de: sigrehpr.SCX (Width=800, Height=320)
*==============================================================================

DEFINE CLASS Formsigrehpr AS FormBase

    *-- Dimensoes exatas do original
    Height       = 320
    Width        = 800
    DataSession  = 2
    ShowWindow   = 1
    WindowType   = 1
    BorderStyle  = 2
    AutoCenter   = .T.
    ControlBox   = .F.
    ClipControls = .T.
    MaxButton    = .F.
    MinButton    = .F.
    TitleBar     = 0
    Themes       = .F.
    FontName     = "Tahoma"
    FontSize     = 8

    *-- Propriedades customizadas
    this_oRelatorio = .NULL.
    this_cTipo      = "REFERENCIA"

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria BO, configura interface e inicializa campos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            THIS.Caption = "Relat" + CHR(243) + "rio de Hist" + CHR(243) + ;
                           "rico de Produtos"

            IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                    MsgErro("Conex" + CHR(227) + "o com banco de dados inv" + ;
                            CHR(225) + "lida.", "Formsigrehpr.InicializarForm")
                    loc_lSucesso = .F.
                ELSE
                    THIS.this_oRelatorio = CREATEOBJECT("sigrehprBO")
                    IF VARTYPE(THIS.this_oRelatorio) != "O"
                        MsgErro("Erro ao criar BO do relat" + CHR(243) + "rio.", ;
                                "Formsigrehpr.InicializarForm")
                        loc_lSucesso = .F.
                    ELSE
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ELSE
                loc_lSucesso = .T.
            ENDIF

            IF loc_lSucesso
                THIS.ConfigurarCabecalho()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.ConfigurarBotoesRelatorio()
                THIS.ConfigurarFiltrosTipo()
                THIS.ConfigurarFiltrosGrEstoque()
                THIS.ConfigurarFiltrosEstoque()
                THIS.ConfigurarFiltrosCodigo()
                THIS.ConfigurarFiltrosPeriodo()
                THIS.ConfigurarFiltrosCdBarra()
                THIS.ConfigurarFiltrosEmpresa()
                THIS.ConfigurarFiltrosOpcoes()
                THIS.ConfigurarEventos()
                THIS.InicializarCampos()
                THIS.AtualizarHabilitacaoCampos()
                THIS.Visible = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigrehpr.InicializarForm")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoControles - Override para REPORT (sem logica CRUD)
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarEstadoControles()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro com titulo branco (replica cntSombra)
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
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Top       = 20
            .Left      = 14
            .AutoSize  = .T.
            .Caption   = "Relat" + CHR(243) + "rio de Hist" + CHR(243) + ;
                         "rico de Produtos"
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Top       = 17
            .Left      = 12
            .AutoSize  = .T.
            .Caption   = "Relat" + CHR(243) + "rio de Hist" + CHR(243) + ;
                         "rico de Produtos"
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesRelatorio - Botoes Visualizar/Imprimir/Excel/Encerrar
    * Posicao original: btnReport.Left=531, Top=0
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesRelatorio()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = 0
            .Left          = 529
            .Width         = 273
            .Height        = 80
            .ButtonCount   = 4
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderColor   = RGB(136, 189, 188)
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        WITH THIS.cmg_4c_Botoes.Buttons(1)
            .Top             = 5
            .Left            = 5
            .Width           = 65
            .Height          = 70
            .Caption         = "Visualizar"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")

        WITH THIS.cmg_4c_Botoes.Buttons(2)
            .Top             = 5
            .Left            = 71
            .Width           = 65
            .Height          = 70
            .Caption         = "Imprimir"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "cadastro_imprimir_60.jpg"
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")

        WITH THIS.cmg_4c_Botoes.Buttons(3)
            .Top             = 5
            .Left            = 137
            .Width           = 65
            .Height          = 70
            .Caption         = "Excel"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excel_60.jpg"
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")

        WITH THIS.cmg_4c_Botoes.Buttons(4)
            .Top             = 5
            .Left            = 203
            .Width           = 65
            .Height          = 70
            .Caption         = "Encerrar"
            .Cancel          = .T.
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarFiltrosTipo - opt_nr_tipo: Referencia / Codigo de Barras / Geral
    * Original: Left=264, Top=85, Width=360, Height=22, ButtonCount=3
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarFiltrosTipo()
        THIS.AddObject("opt_4c_NrTipo", "OptionGroup")
        WITH THIS.opt_4c_NrTipo
            .ButtonCount   = 3
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 1
            .Height        = 22
            .Left          = 264
            .Top           = 85
            .Width         = 362
            .SpecialEffect = 0
            .AutoSize      = .F.
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        WITH THIS.opt_4c_NrTipo.Buttons(1)
            .Caption   = "\<Refer" + CHR(234) + "ncia"
            .Left      = 5
            .Top       = 4
            .Width     = 70
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
            .Value     = 1
            .Visible   = .T.
        ENDWITH

        WITH THIS.opt_4c_NrTipo.Buttons(2)
            .Caption   = "\<C" + CHR(243) + "digo de Barras"
            .Left      = 90
            .Top       = 4
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        WITH THIS.opt_4c_NrTipo.Buttons(3)
            .Caption   = "\<Geral Por Refer" + CHR(234) + "ncia"
            .Left      = 216
            .Top       = 4
            .Width     = 136
            .Height    = 17
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarFiltrosGrEstoque - Say2 + get_Cd_GrEstoque + get_Ds_GrEstoque
    * Original: Say2 L=169,T=115; CdGr L=269,T=110,W=80; DsGr L=351,T=110,W=150
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarFiltrosGrEstoque()
        THIS.AddObject("lbl_4c_GrEstoque", "Label")
        WITH THIS.lbl_4c_GrEstoque
            .Caption   = "Grupo de Estoque :"
            .Left      = 169
            .Top       = 118
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_CdGrEstoque", "TextBox")
        WITH THIS.txt_4c_CdGrEstoque
            .Value         = SPACE(10)
            .Left          = 269
            .Top           = 110
            .Width         = 80
            .Height        = 25
            .MaxLength     = 10
            .Format        = "K!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DsGrEstoque", "TextBox")
        WITH THIS.txt_4c_DsGrEstoque
            .Value     = SPACE(20)
            .Left      = 351
            .Top       = 110
            .Width     = 150
            .Height    = 25
            .MaxLength = 20
            .Format    = "K!"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarFiltrosEstoque - lbl_estoque + get_cd_estoque + get_ds_estoque
    * Original: lbl L=216,T=142; cd L=269,T=137,W=80; ds L=351,T=137,W=290
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarFiltrosEstoque()
        THIS.AddObject("lbl_4c_Estoque", "Label")
        WITH THIS.lbl_4c_Estoque
            .Caption   = "Estoque :"
            .Left      = 216
            .Top       = 145
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_CdEstoque", "TextBox")
        WITH THIS.txt_4c_CdEstoque
            .Value         = SPACE(10)
            .Left          = 269
            .Top           = 137
            .Width         = 80
            .Height        = 25
            .MaxLength     = 10
            .Format        = "K!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DsEstoque", "TextBox")
        WITH THIS.txt_4c_DsEstoque
            .Value     = SPACE(40)
            .Left      = 351
            .Top       = 137
            .Width     = 290
            .Height    = 25
            .MaxLength = 40
            .Format    = "K!"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarFiltrosCodigo - lbl_codigo + get_cd_codigo + get_ds_codigo
    * Original: lbl L=222,T=169; cd L=269,T=164,W=108; ds L=379,T=164,W=290
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarFiltrosCodigo()
        THIS.AddObject("lbl_4c_Codigo", "Label")
        WITH THIS.lbl_4c_Codigo
            .Caption   = "C" + CHR(243) + "digo :"
            .Left      = 222
            .Top       = 172
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_CdCodigo", "TextBox")
        WITH THIS.txt_4c_CdCodigo
            .Value         = SPACE(14)
            .Left          = 269
            .Top           = 164
            .Width         = 108
            .Height        = 25
            .MaxLength     = 14
            .Format        = "K!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DsCodigo", "TextBox")
        WITH THIS.txt_4c_DsCodigo
            .Value     = SPACE(40)
            .Left      = 379
            .Top       = 164
            .Width     = 290
            .Height    = 25
            .MaxLength = 40
            .Format    = "K!"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarFiltrosPeriodo - lbl_periodo + dt_inicial + "a" + dt_final
    * Original: lbl L=219,T=196; ini L=269,T=191,W=80; "a" L=354; fin L=366,W=80
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarFiltrosPeriodo()
        THIS.AddObject("lbl_4c_Periodo", "Label")
        WITH THIS.lbl_4c_Periodo
            .Caption   = "Per" + CHR(237) + "odo :"
            .Left      = 219
            .Top       = 199
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DtInicial", "TextBox")
        WITH THIS.txt_4c_DtInicial
            .Value     = DATE()
            .Left      = 269
            .Top       = 191
            .Width     = 80
            .Height    = 25
            .MaxLength = 10
            .Format    = "K"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_PeriodoA", "Label")
        WITH THIS.lbl_4c_PeriodoA
            .Caption   = CHR(224)
            .Left      = 354
            .Top       = 199
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DtFinal", "TextBox")
        WITH THIS.txt_4c_DtFinal
            .Value     = DATE()
            .Left      = 366
            .Top       = 191
            .Width     = 80
            .Height    = 25
            .MaxLength = 10
            .Format    = "K"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarFiltrosCdBarra - Say1 + Get_cd_barra
    * Original: Say1 L=173,T=223; barra L=269,T=218,W=108,InputMask=9999999999999
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarFiltrosCdBarra()
        THIS.AddObject("lbl_4c_CdBarra", "Label")
        WITH THIS.lbl_4c_CdBarra
            .Caption   = "C" + CHR(243) + "digo de Barras :"
            .Left      = 173
            .Top       = 226
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_CdBarra", "TextBox")
        WITH THIS.txt_4c_CdBarra
            .Value         = 0
            .Left          = 269
            .Top           = 218
            .Width         = 108
            .Height        = 25
            .MaxLength     = 14
            .InputMask     = "9999999999999"
            .Format        = "K"
            .Alignment     = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarFiltrosEmpresa - Say5 + getEmpresa + getDesEmpresa
    * Original: Say5 L=214,T=248; Empresa L=269,T=245,W=31; DesEmpresa L=302,W=290
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarFiltrosEmpresa()
        THIS.AddObject("lbl_4c_Empresa", "Label")
        WITH THIS.lbl_4c_Empresa
            .Caption   = "Empresa :"
            .Left      = 214
            .Top       = 251
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_CdEmpresa", "TextBox")
        WITH THIS.txt_4c_CdEmpresa
            .Value     = ""
            .Left      = 269
            .Top       = 245
            .Width     = 31
            .Height    = 25
            .MaxLength = 3
            .Format    = "K!"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DsEmpresa", "TextBox")
        WITH THIS.txt_4c_DsEmpresa
            .Value     = ""
            .Left      = 302
            .Top       = 245
            .Width     = 290
            .Height    = 25
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarFiltrosOpcoes - Say3 + Opt_imp_medio + Say4 + optObs
    * Original: Say3 L=156,T=273; ImpMedio L=327,T=267; Say4 L=157,T=293; Obs L=327,T=287
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarFiltrosOpcoes()
        THIS.AddObject("lbl_4c_ImpMedio", "Label")
        WITH THIS.lbl_4c_ImpMedio
            .Caption   = "Imprime Custo M" + CHR(233) + "dio do \<Produto  :"
            .Left      = 156
            .Top       = 276
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("opt_4c_ImpMedio", "OptionGroup")
        WITH THIS.opt_4c_ImpMedio
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 1
            .Height        = 23
            .Left          = 327
            .Top           = 267
            .Width         = 97
            .SpecialEffect = 0
            .AutoSize      = .F.
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        WITH THIS.opt_4c_ImpMedio.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 4
            .Width     = 34
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
            .Value     = 1
            .Visible   = .T.
        ENDWITH

        WITH THIS.opt_4c_ImpMedio.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 51
            .Top       = 4
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_OptObs", "Label")
        WITH THIS.lbl_4c_OptObs
            .Caption   = "Imprime Observa" + CHR(231) + CHR(227) + "o do \<Hist" + ;
                         CHR(243) + "rico :"
            .Left      = 157
            .Top       = 296
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("opt_4c_OptObs", "OptionGroup")
        WITH THIS.opt_4c_OptObs
            .ButtonCount   = 3
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 2
            .Height        = 25
            .Left          = 327
            .Top           = 287
            .Width         = 185
            .SpecialEffect = 0
            .AutoSize      = .F.
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        WITH THIS.opt_4c_OptObs.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 5
            .Width     = 34
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        WITH THIS.opt_4c_OptObs.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 51
            .Top       = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
            .Value     = 1
            .Visible   = .T.
        ENDWITH

        WITH THIS.opt_4c_OptObs.Buttons(3)
            .Caption   = "C/Documento"
            .Left      = 92
            .Top       = 5
            .Width     = 83
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarEventos - BINDEVENT para todos os controles interativos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEventos()
        BINDEVENT(THIS.opt_4c_NrTipo,      "InteractiveChange", THIS, "TipoAlterado")

        BINDEVENT(THIS.txt_4c_CdGrEstoque, "DblClick",  THIS, "AbrirBuscaGrEstoque")
        BINDEVENT(THIS.txt_4c_CdGrEstoque, "KeyPress",  THIS, "TeclaCdGrEstoque")

        BINDEVENT(THIS.txt_4c_DsGrEstoque, "DblClick",  THIS, "AbrirBuscaGrEstoque")
        BINDEVENT(THIS.txt_4c_DsGrEstoque, "KeyPress",  THIS, "TeclaDsGrEstoque")

        BINDEVENT(THIS.txt_4c_CdEstoque,   "DblClick",  THIS, "AbrirBuscaEstoque")
        BINDEVENT(THIS.txt_4c_CdEstoque,   "KeyPress",  THIS, "TeclaCdEstoque")

        BINDEVENT(THIS.txt_4c_DsEstoque,   "DblClick",  THIS, "AbrirBuscaEstoque")
        BINDEVENT(THIS.txt_4c_DsEstoque,   "KeyPress",  THIS, "TeclaDsEstoque")

        BINDEVENT(THIS.txt_4c_CdCodigo,    "DblClick",  THIS, "AbrirBuscaCodigo")
        BINDEVENT(THIS.txt_4c_CdCodigo,    "KeyPress",  THIS, "TeclaCdCodigo")

        BINDEVENT(THIS.txt_4c_DsCodigo,    "DblClick",  THIS, "AbrirBuscaCodigo")
        BINDEVENT(THIS.txt_4c_DsCodigo,    "KeyPress",  THIS, "TeclaDsCodigo")

        BINDEVENT(THIS.txt_4c_CdBarra,     "KeyPress",  THIS, "TeclaCdBarra")

        BINDEVENT(THIS.txt_4c_CdEmpresa,   "DblClick",  THIS, "AbrirBuscaEmpresa")
        BINDEVENT(THIS.txt_4c_CdEmpresa,   "KeyPress",  THIS, "TeclaEmpresa")

        BINDEVENT(THIS.txt_4c_DsEmpresa,   "DblClick",  THIS, "AbrirBuscaEmpresa")
        BINDEVENT(THIS.txt_4c_DsEmpresa,   "KeyPress",  THIS, "TeclaDesEmpresa")
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarCampos - Define valores iniciais equivalentes ao Init do original
    * Original: opt_nr_tipo=1, datas=DATE(), barra=0, empresa da empresa logada
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarCampos()
        THIS.opt_4c_NrTipo.Value      = 1
        THIS.txt_4c_CdGrEstoque.Value = SPACE(10)
        THIS.txt_4c_DsGrEstoque.Value = SPACE(20)
        THIS.txt_4c_CdEstoque.Value   = SPACE(10)
        THIS.txt_4c_DsEstoque.Value   = SPACE(40)
        THIS.txt_4c_CdCodigo.Value    = SPACE(14)
        THIS.txt_4c_DsCodigo.Value    = SPACE(40)
        THIS.txt_4c_DtInicial.Value   = DATE()
        THIS.txt_4c_DtFinal.Value     = DATE()
        THIS.txt_4c_CdBarra.Value     = 0
        THIS.opt_4c_ImpMedio.Value    = 1
        THIS.opt_4c_OptObs.Value      = 2
        THIS.this_cTipo               = "REFERENCIA"

        THIS.CarregarEmpresaLogada()
        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarEmpresaLogada - Busca empresa da sessao atual (equivale _Empr+Requery)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarEmpresaLogada()
        LOCAL loc_cCod, loc_cDs, loc_nResult
        loc_cCod = ""
        loc_cDs  = ""
        IF VARTYPE(go_4c_Sistema) = "O" AND !ISNULL(go_4c_Sistema)
            loc_cCod = ALLTRIM(go_4c_Sistema.cCodEmpresa)
        ENDIF
        IF !EMPTY(loc_cCod) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 cemps, razas FROM SigCdEmp WHERE cemps = " + ;
                EscaparSQL(loc_cCod), ;
                "cursor_4c_SigrehprEmpLg")
            IF loc_nResult > 0 AND !EOF("cursor_4c_SigrehprEmpLg")
                SELECT cursor_4c_SigrehprEmpLg
                loc_cDs = ALLTRIM(cursor_4c_SigrehprEmpLg.razas)
            ENDIF
            IF USED("cursor_4c_SigrehprEmpLg")
                USE IN cursor_4c_SigrehprEmpLg
            ENDIF
        ENDIF
        THIS.txt_4c_CdEmpresa.Value = loc_cCod
        THIS.txt_4c_DsEmpresa.Value = loc_cDs
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarHabilitacaoCampos - Habilita/desabilita campos por tipo
    * Equivale aos When events do original
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarHabilitacaoCampos()
        LOCAL loc_lRef, loc_lBarra, loc_lGeral
        loc_lRef   = (THIS.this_cTipo = "REFERENCIA")
        loc_lBarra = (THIS.this_cTipo = "CODIGO DE BARRA")
        loc_lGeral = (THIS.this_cTipo = "GERAL")

        THIS.txt_4c_CdGrEstoque.Enabled = !loc_lBarra
        THIS.txt_4c_DsGrEstoque.Enabled = !loc_lBarra
        THIS.txt_4c_CdEstoque.Enabled   = !loc_lBarra
        THIS.txt_4c_DsEstoque.Enabled   = !loc_lBarra
        THIS.txt_4c_CdCodigo.Enabled    = loc_lRef
        THIS.txt_4c_DsCodigo.Enabled    = loc_lRef
        THIS.txt_4c_CdBarra.Enabled     = loc_lBarra
        THIS.txt_4c_CdEmpresa.Enabled   = loc_lGeral
        THIS.txt_4c_DsEmpresa.Enabled   = loc_lGeral

        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere controles para o BO antes de gerar relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oRel
        loc_oRel = THIS.this_oRelatorio
        IF VARTYPE(loc_oRel) != "O"
            RETURN
        ENDIF
        WITH loc_oRel
            .this_nOptTipo     = THIS.opt_4c_NrTipo.Value
            .this_cEmpresa     = PADR(ALLTRIM(THIS.txt_4c_CdEmpresa.Value), 3)
            .this_cDesEmpresa  = ALLTRIM(THIS.txt_4c_DsEmpresa.Value)
            .this_cCdGrEstoque = PADR(ALLTRIM(THIS.txt_4c_CdGrEstoque.Value), 10)
            .this_cDsGrEstoque = ALLTRIM(THIS.txt_4c_DsGrEstoque.Value)
            .this_cCdEstoque   = PADR(ALLTRIM(THIS.txt_4c_CdEstoque.Value), 10)
            .this_cDsEstoque   = ALLTRIM(THIS.txt_4c_DsEstoque.Value)
            .this_cCdCodigo    = PADR(ALLTRIM(THIS.txt_4c_CdCodigo.Value), 14)
            .this_cDsCodigo    = ALLTRIM(THIS.txt_4c_DsCodigo.Value)
            .this_dDtInicial   = THIS.txt_4c_DtInicial.Value
            .this_dDtFinal     = THIS.txt_4c_DtFinal.Value
            .this_nCdBarra     = THIS.txt_4c_CdBarra.Value
            .this_nImpMedio    = THIS.opt_4c_ImpMedio.Value
            .this_nOptObs      = THIS.opt_4c_OptObs.Value
            .this_cTipo        = THIS.this_cTipo
        ENDWITH
    ENDPROC

    *==========================================================================
    * ACOES DOS BOTOES
    *==========================================================================

    PROCEDURE BtnVisualizarClick()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Visualizar()
            IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Visualizar")
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE BtnImprimirClick()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Imprimir()
            IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE BtnExcelClick()
        MsgInfo("Exporta" + CHR(231) + CHR(227) + "o Excel n" + CHR(227) + ;
                "o dispon" + CHR(237) + "vel para este relat" + CHR(243) + "rio.", ;
                "Excel")
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * TROCA DE TIPO DE RELATORIO
    * Equivale ao opt_nr_tipo.Valid do original
    *==========================================================================

    PROCEDURE TipoAlterado()
        LOCAL loc_nTipo
        loc_nTipo = THIS.opt_4c_NrTipo.Value

        DO CASE
        CASE loc_nTipo = 1
            THIS.this_cTipo           = "REFERENCIA"
            THIS.txt_4c_CdBarra.Value = 0
            THIS.CarregarEmpresaLogada()

        CASE loc_nTipo = 2
            THIS.this_cTipo                 = "CODIGO DE BARRA"
            THIS.txt_4c_DsGrEstoque.Value   = ""
            THIS.txt_4c_CdGrEstoque.Value   = ""
            THIS.txt_4c_CdEstoque.Value     = ""
            THIS.txt_4c_DsEstoque.Value     = ""
            THIS.txt_4c_CdCodigo.Value      = ""
            THIS.txt_4c_DsCodigo.Value      = ""
            THIS.txt_4c_CdBarra.Value       = 0
            THIS.CarregarEmpresaLogada()

        CASE loc_nTipo = 3
            THIS.this_cTipo            = "GERAL"
            THIS.txt_4c_CdBarra.Value  = 0
            THIS.txt_4c_CdCodigo.Value = ""
            THIS.txt_4c_DsCodigo.Value = ""
        ENDCASE

        THIS.AtualizarHabilitacaoCampos()
    ENDPROC

    *==========================================================================
    * GRUPO DE ESTOQUE - SigCdGcr (codigos/descrs) - equivale fAcessoContab
    *==========================================================================

    PROCEDURE ValidarCdGrEstoque()
        LOCAL loc_cCodigo, loc_nResult
        TRY
            loc_cCodigo = ALLTRIM(THIS.txt_4c_CdGrEstoque.Value)
            IF EMPTY(loc_cCodigo)
                THIS.txt_4c_DsGrEstoque.Value = ""
                THIS.txt_4c_CdEstoque.Value   = ""
                THIS.txt_4c_DsEstoque.Value   = ""
                RETURN
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 codigos, descrs FROM SigCdGcr WHERE codigos = " + ;
                EscaparSQL(loc_cCodigo), ;
                "cursor_4c_SigrehprGcrVl")
            IF loc_nResult > 0 AND !EOF("cursor_4c_SigrehprGcrVl")
                SELECT cursor_4c_SigrehprGcrVl
                THIS.txt_4c_CdGrEstoque.Value = ALLTRIM(cursor_4c_SigrehprGcrVl.codigos)
                THIS.txt_4c_DsGrEstoque.Value = ALLTRIM(cursor_4c_SigrehprGcrVl.descrs)
            ELSE
                MsgAviso("Grupo de Estoque n" + CHR(227) + "o encontrado.", ;
                         "Grupo de Estoque")
                THIS.txt_4c_CdGrEstoque.Value = ""
                THIS.txt_4c_DsGrEstoque.Value = ""
                THIS.AbrirBuscaGrEstoque()
            ENDIF
            IF USED("cursor_4c_SigrehprGcrVl")
                USE IN cursor_4c_SigrehprGcrVl
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE ValidarDsGrEstoque()
        LOCAL loc_cDescr
        loc_cDescr = ALLTRIM(THIS.txt_4c_DsGrEstoque.Value)
        IF EMPTY(loc_cDescr)
            THIS.txt_4c_CdGrEstoque.Value = ""
            THIS.txt_4c_CdEstoque.Value   = ""
            THIS.txt_4c_DsEstoque.Value   = ""
            RETURN
        ENDIF
        THIS.AbrirBuscaGrEstoque()
    ENDPROC

    PROCEDURE AbrirBuscaGrEstoque()
        LOCAL loc_oBusca, loc_cValor, loc_cCursor
        loc_cCursor = "cursor_4c_SigrehprGcrBs"
        TRY
            loc_cValor = ALLTRIM(THIS.txt_4c_CdGrEstoque.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", loc_cCursor, "codigos", loc_cValor, ;
                "Selecionar Grupo de Estoque", "")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    THIS.txt_4c_CdGrEstoque.Value = ALLTRIM(codigos)
                    THIS.txt_4c_DsGrEstoque.Value = ALLTRIM(descrs)
                    THIS.txt_4c_CdEstoque.Value   = ""
                    THIS.txt_4c_DsEstoque.Value   = ""
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

    PROCEDURE TeclaCdGrEstoque(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaGrEstoque()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdGrEstoque()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsGrEstoque(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.AbrirBuscaGrEstoque()
        ENDIF
    ENDPROC

    *==========================================================================
    * CONTA DE ESTOQUE - SigCdCli (iclis/rclis) - equivale fAcessoContas
    *==========================================================================

    PROCEDURE ValidarCdEstoque()
        LOCAL loc_cCodigo, loc_cGrupo, loc_cFiltro, loc_nResult
        TRY
            loc_cCodigo = ALLTRIM(THIS.txt_4c_CdEstoque.Value)
            IF EMPTY(loc_cCodigo)
                THIS.txt_4c_DsEstoque.Value = ""
                RETURN
            ENDIF
            loc_cGrupo  = ALLTRIM(THIS.txt_4c_CdGrEstoque.Value)
            loc_cFiltro = ""
            IF !EMPTY(loc_cGrupo)
                loc_cFiltro = " AND grupos = " + EscaparSQL(PADR(loc_cGrupo, 10))
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 iclis, rclis FROM SigCdCli WHERE iclis = " + ;
                EscaparSQL(loc_cCodigo) + loc_cFiltro, ;
                "cursor_4c_SigrehprCliVl")
            IF loc_nResult > 0 AND !EOF("cursor_4c_SigrehprCliVl")
                SELECT cursor_4c_SigrehprCliVl
                THIS.txt_4c_CdEstoque.Value = ALLTRIM(cursor_4c_SigrehprCliVl.iclis)
                THIS.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_SigrehprCliVl.rclis)
            ELSE
                MsgAviso("Conta de Estoque n" + CHR(227) + "o encontrada.", ;
                         "Conta de Estoque")
                THIS.txt_4c_CdEstoque.Value = ""
                THIS.txt_4c_DsEstoque.Value = ""
                THIS.AbrirBuscaEstoque()
            ENDIF
            IF USED("cursor_4c_SigrehprCliVl")
                USE IN cursor_4c_SigrehprCliVl
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE ValidarDsEstoque()
        LOCAL loc_cDescr
        loc_cDescr = ALLTRIM(THIS.txt_4c_DsEstoque.Value)
        IF EMPTY(loc_cDescr)
            THIS.txt_4c_CdEstoque.Value = ""
            RETURN
        ENDIF
        THIS.AbrirBuscaEstoque()
    ENDPROC

    PROCEDURE AbrirBuscaEstoque()
        LOCAL loc_oBusca, loc_cValor, loc_cCursor, loc_cGrupo, loc_cFiltro
        loc_cCursor = "cursor_4c_SigrehprCliBs"
        TRY
            loc_cValor  = ALLTRIM(THIS.txt_4c_CdEstoque.Value)
            loc_cGrupo  = ALLTRIM(THIS.txt_4c_CdGrEstoque.Value)
            loc_cFiltro = ""
            IF !EMPTY(loc_cGrupo)
                loc_cFiltro = "grupos = " + EscaparSQL(PADR(loc_cGrupo, 10))
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", loc_cCursor, "iclis", loc_cValor, ;
                "Selecionar Conta de Estoque", loc_cFiltro)
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("rclis", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    THIS.txt_4c_CdEstoque.Value = ALLTRIM(iclis)
                    THIS.txt_4c_DsEstoque.Value = ALLTRIM(rclis)
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

    PROCEDURE TeclaCdEstoque(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEstoque()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdEstoque()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsEstoque(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.AbrirBuscaEstoque()
        ENDIF
    ENDPROC

    *==========================================================================
    * CODIGO DO PRODUTO - SigCdPro (cpros/dpros) - equivale fwBuscaExt
    *==========================================================================

    PROCEDURE ValidarCdCodigo()
        LOCAL loc_cCodigo, loc_nResult
        TRY
            loc_cCodigo = ALLTRIM(THIS.txt_4c_CdCodigo.Value)
            IF EMPTY(loc_cCodigo)
                THIS.txt_4c_DsCodigo.Value = ""
                RETURN
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 cpros, dpros FROM SigCdPro WHERE cpros = " + ;
                EscaparSQL(loc_cCodigo), ;
                "cursor_4c_SigrehprProVl")
            IF loc_nResult > 0 AND !EOF("cursor_4c_SigrehprProVl")
                SELECT cursor_4c_SigrehprProVl
                THIS.txt_4c_CdCodigo.Value = ALLTRIM(cursor_4c_SigrehprProVl.cpros)
                THIS.txt_4c_DsCodigo.Value = ALLTRIM(cursor_4c_SigrehprProVl.dpros)
            ELSE
                MsgAviso("Produto n" + CHR(227) + "o encontrado.", "Produto")
                THIS.txt_4c_CdCodigo.Value = ""
                THIS.txt_4c_DsCodigo.Value = ""
                THIS.AbrirBuscaCodigo()
            ENDIF
            IF USED("cursor_4c_SigrehprProVl")
                USE IN cursor_4c_SigrehprProVl
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE ValidarDsCodigo()
        LOCAL loc_cDescr
        loc_cDescr = ALLTRIM(THIS.txt_4c_DsCodigo.Value)
        IF EMPTY(loc_cDescr)
            THIS.txt_4c_CdCodigo.Value = ""
            RETURN
        ENDIF
        THIS.AbrirBuscaCodigo()
    ENDPROC

    PROCEDURE AbrirBuscaCodigo()
        LOCAL loc_oBusca, loc_cValor, loc_cCursor
        loc_cCursor = "cursor_4c_SigrehprProBs"
        TRY
            loc_cValor = ALLTRIM(THIS.txt_4c_CdCodigo.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPro", loc_cCursor, "cpros", loc_cValor, ;
                "Selecionar Produto", "")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    THIS.txt_4c_CdCodigo.Value = ALLTRIM(cpros)
                    THIS.txt_4c_DsCodigo.Value = ALLTRIM(dpros)
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

    PROCEDURE TeclaCdCodigo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCodigo()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdCodigo()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsCodigo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.AbrirBuscaCodigo()
        ENDIF
    ENDPROC

    *==========================================================================
    * CODIGO DE BARRAS - SigOpEtq / SigCdPro
    * Equivale ao Get_cd_barra.Valid do original (busca em SigOpEtq e SigCdPro)
    *==========================================================================

    PROCEDURE ValidarCdBarra()
        LOCAL loc_cCdBarra, loc_nResult, loc_cCpros
        TRY
            loc_cCdBarra = ALLTRIM(STR(THIS.txt_4c_CdBarra.Value, 14))

            IF EMPTY(loc_cCdBarra) OR THIS.txt_4c_CdBarra.Value = 0
                THIS.txt_4c_CdCodigo.Value = ""
                THIS.txt_4c_DsCodigo.Value = ""
                RETURN
            ENDIF

            *-- 1. Buscar em SigOpEtq por cbars
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 cpros FROM SigOpEtq WHERE cbars = " + ;
                ALLTRIM(STR(THIS.txt_4c_CdBarra.Value, 14)), ;
                "cursor_4c_SigrehprEtqVl")
            IF loc_nResult < 1
                MsgErro("Falha na conex" + CHR(227) + "o ao validar c" + CHR(243) + ;
                        "digo de barras.", "ValidarCdBarra")
                RETURN
            ENDIF

            SELECT cursor_4c_SigrehprEtqVl
            GO TOP
            IF !EOF("cursor_4c_SigrehprEtqVl")
                *-- Encontrado em SigOpEtq: buscar produto pelo cpros
                loc_cCpros = ALLTRIM(cursor_4c_SigrehprEtqVl.cpros)
                IF USED("cursor_4c_SigrehprEtqVl")
                    USE IN cursor_4c_SigrehprEtqVl
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 cpros, dpros FROM SigCdPro WHERE cpros = " + ;
                    EscaparSQL(loc_cCpros), ;
                    "cursor_4c_SigrehprProVl2")
                IF loc_nResult > 0 AND !EOF("cursor_4c_SigrehprProVl2")
                    SELECT cursor_4c_SigrehprProVl2
                    THIS.txt_4c_CdCodigo.Value = ALLTRIM(cursor_4c_SigrehprProVl2.cpros)
                    THIS.txt_4c_DsCodigo.Value = ALLTRIM(cursor_4c_SigrehprProVl2.dpros)
                ENDIF
                IF USED("cursor_4c_SigrehprProVl2")
                    USE IN cursor_4c_SigrehprProVl2
                ENDIF
            ELSE
                *-- Nao encontrado em SigOpEtq: buscar em SigCdPro por cbars
                IF USED("cursor_4c_SigrehprEtqVl")
                    USE IN cursor_4c_SigrehprEtqVl
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 cpros FROM SigCdPro WHERE cbars = " + ;
                    ALLTRIM(STR(THIS.txt_4c_CdBarra.Value, 14)), ;
                    "cursor_4c_SigrehprPrvVl")
                IF loc_nResult < 1
                    MsgErro("Falha na conex" + CHR(227) + "o ao validar c" + CHR(243) + ;
                            "digo de barras.", "ValidarCdBarra")
                ELSE
                    SELECT cursor_4c_SigrehprPrvVl
                    GO TOP
                    IF EOF("cursor_4c_SigrehprPrvVl")
                        MsgAviso("C" + CHR(243) + "digo de Barra n" + CHR(227) + ;
                                 "o cadastrado!", "C" + CHR(243) + "digo de Barras")
                        THIS.txt_4c_CdCodigo.Value = ""
                        THIS.txt_4c_DsCodigo.Value = ""
                    ELSE
                        IF USED("cursor_4c_SigrehprPrvVl")
                            USE IN cursor_4c_SigrehprPrvVl
                        ENDIF
                        loc_nResult = SQLEXEC(gnConnHandle, ;
                            "SELECT TOP 1 cpros, dpros FROM SigCdPro WHERE cbars = " + ;
                            ALLTRIM(STR(THIS.txt_4c_CdBarra.Value, 14)), ;
                            "cursor_4c_SigrehprProVl3")
                        IF loc_nResult > 0 AND !EOF("cursor_4c_SigrehprProVl3")
                            SELECT cursor_4c_SigrehprProVl3
                            THIS.txt_4c_CdCodigo.Value = ALLTRIM(cursor_4c_SigrehprProVl3.cpros)
                            THIS.txt_4c_DsCodigo.Value = ALLTRIM(cursor_4c_SigrehprProVl3.dpros)
                        ENDIF
                        IF USED("cursor_4c_SigrehprProVl3")
                            USE IN cursor_4c_SigrehprProVl3
                        ENDIF
                    ENDIF
                    IF USED("cursor_4c_SigrehprPrvVl")
                        USE IN cursor_4c_SigrehprPrvVl
                    ENDIF
                ENDIF
            ENDIF

            IF USED("cursor_4c_SigrehprEtqVl")
                USE IN cursor_4c_SigrehprEtqVl
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE TeclaCdBarra(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdBarra()
        ENDIF
    ENDPROC

    *==========================================================================
    * EMPRESA - SigCdEmp (cemps/razas) - equivale fAcessoEmpresa
    *==========================================================================

    PROCEDURE ValidarEmpresa()
        LOCAL loc_cCodigo, loc_nResult
        TRY
            loc_cCodigo = ALLTRIM(THIS.txt_4c_CdEmpresa.Value)
            IF EMPTY(loc_cCodigo)
                THIS.txt_4c_DsEmpresa.Value = ""
                RETURN
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 cemps, razas FROM SigCdEmp WHERE cemps = " + ;
                EscaparSQL(loc_cCodigo), ;
                "cursor_4c_SigrehprEmpVl")
            IF loc_nResult > 0 AND !EOF("cursor_4c_SigrehprEmpVl")
                SELECT cursor_4c_SigrehprEmpVl
                THIS.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_SigrehprEmpVl.cemps)
                THIS.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_SigrehprEmpVl.razas)
            ELSE
                MsgAviso("Empresa n" + CHR(227) + "o encontrada.", "Empresa")
                THIS.txt_4c_CdEmpresa.Value = ""
                THIS.txt_4c_DsEmpresa.Value = ""
                THIS.AbrirBuscaEmpresa()
            ENDIF
            IF USED("cursor_4c_SigrehprEmpVl")
                USE IN cursor_4c_SigrehprEmpVl
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE ValidarDesEmpresa()
        LOCAL loc_cDescr
        loc_cDescr = ALLTRIM(THIS.txt_4c_DsEmpresa.Value)
        IF THIS.this_cTipo = "GERAL" AND !EMPTY(loc_cDescr)
            THIS.AbrirBuscaEmpresa()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaEmpresa()
        LOCAL loc_oBusca, loc_cValor, loc_cCursor
        loc_cCursor = "cursor_4c_SigrehprEmpBs"
        TRY
            loc_cValor = ALLTRIM(THIS.txt_4c_CdEmpresa.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", loc_cCursor, "cemps", loc_cValor, ;
                "Selecionar Empresa", "")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("cemps", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("razas", "", "Raz" + CHR(227) + "o Social")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    THIS.txt_4c_CdEmpresa.Value = ALLTRIM(cemps)
                    THIS.txt_4c_DsEmpresa.Value = ALLTRIM(razas)
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

    PROCEDURE TeclaEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpresa()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarEmpresa()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDesEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.AbrirBuscaEmpresa()
        ENDIF
    ENDPROC

    *==========================================================================
    * COMPATIBILIDADE COM PIPELINE CRUD - Formularios REPORT (frmrelatorio)
    *
    * Forms REPORT possuem layout FLAT (todos os controles direto no Form),
    * sem PageFrame de Lista/Dados como nos forms CRUD (frmcadastro).
    * Os controles equivalentes a "lista de filtros" sao adicionados em
    * InicializarForm() via ConfigurarFiltros*() e os botoes de acao via
    * ConfigurarBotoesRelatorio() (CommandGroup com Visualizar/Imprimir/Excel/Encerrar).
    *
    * Os metodos abaixo existem para compatibilidade com o pipeline de migracao
    * e com BINDEVENTs eventualmente herdados de FormBase.
    *==========================================================================

    PROTECTED PROCEDURE ConfigurarPaginaLista()
        *-- REPORT FLAT: equivalente ja configurado em InicializarForm()
        *-- (ConfigurarFiltros* + ConfigurarBotoesRelatorio).
        RETURN
    ENDPROC

    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- REPORT FLAT: nao ha Page2 de edicao de dados.
        *-- Todos os campos de parametro (filtros) sao adicionados diretamente
        *-- ao form em InicializarForm() via ConfigurarFiltros*().
        *-- Este metodo existe para compatibilidade com FormBase.
        RETURN
    ENDPROC

    PROCEDURE AlternarPagina(par_nPagina)
        *-- REPORT FLAT: nao ha PageFrame para alternar. Mantem foco no
        *-- primeiro controle editavel dependendo do tipo selecionado.
        LOCAL loc_oErro
        TRY
            DO CASE
            CASE THIS.this_cTipo = "REFERENCIA"
                IF THIS.txt_4c_CdGrEstoque.Enabled
                    THIS.txt_4c_CdGrEstoque.SetFocus()
                ENDIF
            CASE THIS.this_cTipo = "CODIGO DE BARRA"
                IF THIS.txt_4c_CdBarra.Enabled
                    THIS.txt_4c_CdBarra.SetFocus()
                ENDIF
            CASE THIS.this_cTipo = "GERAL"
                IF THIS.txt_4c_CdEmpresa.Enabled
                    THIS.txt_4c_CdEmpresa.SetFocus()
                ENDIF
            ENDCASE
        CATCH TO loc_oErro
        ENDTRY
    ENDPROC

    *==========================================================================
    * EVENTOS PRINCIPAIS - Compatibilidade com pipeline CRUD
    *
    * Form REPORT (frmrelatorio) NAO possui operacoes CRUD (Incluir/Alterar/
    * Excluir). Acoes reais sao: Visualizar (preview), Imprimir (papel), Excel
    * (exportacao) e Encerrar (fechar).
    *
    * Os metodos abaixo existem para compatibilidade com o pipeline de migracao
    * e delegam para a acao equivalente do form REPORT:
    *   BtnIncluirClick    -> BtnVisualizarClick (gerar/visualizar relatorio)
    *   BtnAlterarClick    -> BtnVisualizarClick (regerar com novos filtros)
    *   BtnVisualizarClick -> ja implementado acima (preview na tela)
    *   BtnExcluirClick    -> limpa os filtros para nova consulta
    *==========================================================================

    PROCEDURE BtnIncluirClick()
        *-- REPORT: "Incluir" equivale a gerar/visualizar um novo relatorio
        *-- com base nos filtros atuais. Delega para Visualizar.
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnAlterarClick()
        *-- REPORT: "Alterar" equivale a regerar o relatorio com filtros
        *-- atualizados. Delega para Visualizar.
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnExcluirClick()
        *-- REPORT: nao ha exclusao de registros. A acao equivalente eh
        *-- limpar os filtros para preparar nova consulta.
        LOCAL loc_oErro
        TRY
            THIS.opt_4c_NrTipo.Value      = 1
            THIS.this_cTipo               = "REFERENCIA"
            THIS.txt_4c_CdGrEstoque.Value = SPACE(10)
            THIS.txt_4c_DsGrEstoque.Value = SPACE(20)
            THIS.txt_4c_CdEstoque.Value   = SPACE(10)
            THIS.txt_4c_DsEstoque.Value   = SPACE(40)
            THIS.txt_4c_CdCodigo.Value    = SPACE(14)
            THIS.txt_4c_DsCodigo.Value    = SPACE(40)
            THIS.txt_4c_DtInicial.Value   = DATE()
            THIS.txt_4c_DtFinal.Value     = DATE()
            THIS.txt_4c_CdBarra.Value     = 0
            THIS.opt_4c_ImpMedio.Value    = 1
            THIS.opt_4c_OptObs.Value      = 2
            THIS.CarregarEmpresaLogada()
            THIS.AtualizarHabilitacaoCampos()
            THIS.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CONSOLIDACAO FASE 8: Metodos finais e compatibilidade com pipeline
    *==========================================================================

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa todos os campos de filtro (retorna ao estado inicial)
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oErro
        TRY
            THIS.opt_4c_NrTipo.Value      = 1
            THIS.this_cTipo               = "REFERENCIA"
            THIS.txt_4c_CdGrEstoque.Value = SPACE(10)
            THIS.txt_4c_DsGrEstoque.Value = SPACE(20)
            THIS.txt_4c_CdEstoque.Value   = SPACE(10)
            THIS.txt_4c_DsEstoque.Value   = SPACE(40)
            THIS.txt_4c_CdCodigo.Value    = SPACE(14)
            THIS.txt_4c_DsCodigo.Value    = SPACE(40)
            THIS.txt_4c_DtInicial.Value   = DATE()
            THIS.txt_4c_DtFinal.Value     = DATE()
            THIS.txt_4c_CdBarra.Value     = 0
            THIS.opt_4c_ImpMedio.Value    = 1
            THIS.opt_4c_OptObs.Value      = 2
            THIS.CarregarEmpresaLogada()
            THIS.AtualizarHabilitacaoCampos()
            THIS.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos conforme tipo de relatorio
    * Delega para AtualizarHabilitacaoCampos (implementacao completa)
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos()
        THIS.AtualizarHabilitacaoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Form REPORT nao tem lista CRUD; atualiza habilitacao
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        THIS.AtualizarHabilitacaoCampos()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Form REPORT nao tem modos CRUD; noop
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Alias de FormParaRelatorio para compatibilidade com pipeline
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Form REPORT nao carrega registros do BO de volta aos campos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - REPORT: buscar = visualizar relatorio com filtros atuais
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - REPORT: salvar = gerar e imprimir relatorio
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - REPORT: cancelar = encerrar formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.BtnEncerrarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos (NAO usar .Release() em Custom/BO)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigrehprBO.prg):
*==============================================================================
* SIGREHPRBO.PRG
* Business Object para Relatorio de Historico de Produtos (SIGREHPR)
*
* Herda de: RelatorioBase
* Tabelas: SigMvHst, SigMvEst, SigCdPro, SigCdEmp, SigCdGrp, SigCdPam
*           SigMvCab, SigCdNec, SigOpEtq, SigCdUni, SigPdMvf, SigMvPec
*==============================================================================

DEFINE CLASS sigrehprBO AS RelatorioBase

    *-- Identificacao
    this_cTabela          = "SigMvHst"
    this_cCampoChave      = ""

    *-- Modo de filtragem
    *-- Valores possiveis: 'REFERENCIA', 'CODIGO DE BARRA', 'GERAL'
    this_cTipo            = "REFERENCIA"
    this_nOptTipo         = 1     && 1=Referencia, 2=Codigo de Barras, 3=Geral por Referencia

    *-- Filtro: Grupo de Estoque (SigCdGrp)
    this_cCdGrEstoque     = ""    && cgrus / MaxLength 10
    this_cDsGrEstoque     = ""    && dgrus / MaxLength 20

    *-- Filtro: Estoque (SigCdEst)
    this_cCdEstoque       = ""    && MaxLength 10
    this_cDsEstoque       = ""    && MaxLength 40

    *-- Filtro: Produto (SigCdPro)
    this_cCdCodigo        = ""    && cpros / MaxLength 14
    this_cDsCodigo        = ""    && dpros / MaxLength 40

    *-- Filtro: Periodo
    this_dDtInicial       = {}
    this_dDtFinal         = {}

    *-- Filtro: Codigo de Barras (SigOpEtq.cbars / SigCdPro.cbars)
    this_nCdBarra         = 0

    *-- Filtro: Empresa (SigCdEmp)
    this_cEmpresa         = ""    && cemps / MaxLength 3
    this_cDesEmpresa      = ""    && razas

    *-- Opcoes de impressao
    this_nOptObs          = 2     && 1=Sim, 2=Nao, 3=C/Documento
    this_nImpMedio        = 1     && 1=Sim, 2=Nao

    *-- Dados calculados para cabecalho do relatorio
    this_cNomeEmpresa     = ""    && SigCdEmp.razas (empresa selecionada)
    this_cTitulo1         = ""    && Titulo principal fixo
    this_cTitulo2         = ""    && Subtitulo (grupo/estoque/empresa filtrados)
    this_cPeriodo         = ""    && Periodo formatado "dd/mm/aa a dd/mm/aa"

    *-- Cursors de saida
    this_cCursorDados     = "CsRelatorio"    && Cursor com registros do historico
    this_cCursorCabecalho = "CsCabecalho"    && Cursor com dados de cabecalho para FRX

    *--------------------------------------------------------------------------
    * Init - Inicializa propriedades com valores padrao
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_dDtInicial  = DATE()
            THIS.this_dDtFinal    = DATE()
            THIS.this_cTipo       = "REFERENCIA"
            THIS.this_nOptTipo    = 1
            THIS.this_nOptObs     = 2
            THIS.this_nImpMedio   = 1
            THIS.this_cEmpresa    = go_4c_Sistema.cCodEmpresa
            THIS.this_cTitulo1    = "Hist" + CHR(243) + "rico de Produtos"
            loc_lSucesso          = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Nao aplicavel para relatorio
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Coordena preparacao dos dados conforme modo de filtragem
    * Popula CsCabecalho e CsRelatorio (modo 3) ou CrSigMvHst (modo 1/2)
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        PRIVATE ldDtInicial, ldDtFinal
        LOCAL loc_lSucesso, loc_nResult
        LOCAL loc_cEmp, loc_cGrEst, loc_cCdEstoque, loc_cDsEstoque
        LOCAL loc_cCdCodigo, loc_cDsCodigo, loc_nCdBarra, loc_nImpMedio
        LOCAL loc_lObs
        LOCAL loc_cTitulo2Grp, loc_cTitulo2Est, loc_cTitulo2Emp

        loc_lSucesso = .F.

        TRY
            THIS.this_cMensagemErro = ""
            THIS.LimparCursors()

            *-- Capturar filtros das propriedades
            loc_cEmp       = PADR(ALLTRIM(THIS.this_cEmpresa), 3)
            loc_cGrEst     = PADR(ALLTRIM(THIS.this_cCdGrEstoque), 10)
            loc_cCdEstoque = PADR(ALLTRIM(THIS.this_cCdEstoque), 10)
            loc_cDsEstoque = THIS.this_cDsEstoque
            loc_cCdCodigo  = PADR(THIS.this_cCdCodigo, 14)
            loc_cDsCodigo  = THIS.this_cDsCodigo
            loc_nCdBarra   = THIS.this_nCdBarra
            loc_nImpMedio  = THIS.this_nImpMedio
            loc_lObs       = INLIST(THIS.this_nOptObs, 1, 3)

            *-- Converter datas para DATETIME com hora (necessario para BETWEEN em SigMvHst.datas)
            ldDtInicial = EVALUATE([{^] + ;
                TRANSFORM((DTOS(MAX(THIS.this_dDtInicial, CTOD('01/01/1900'))) + '000000'), ;
                '@R 9999-99-99 99:99:99') + [}])
            ldDtFinal = EVALUATE([{^] + ;
                TRANSFORM((DTOS(MAX(THIS.this_dDtFinal, CTOD('01/01/1900'))) + '235959'), ;
                '@R 9999-99-99 99:99:99') + [}])

            *-- Buscar nome da empresa selecionada
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT cemps, razas FROM SigCdEmp WHERE cemps = " + EscaparSQL(loc_cEmp), ;
                "cursor_4c_CrEmpSrh")
            IF loc_nResult > 0
                SELECT cursor_4c_CrEmpSrh
                GO TOP
                IF !EOF()
                    THIS.this_cNomeEmpresa = ALLTRIM(cursor_4c_CrEmpSrh.razas)
                ENDIF
                USE IN cursor_4c_CrEmpSrh
            ENDIF

            *-- Montar periodo formatado
            THIS.this_cPeriodo = "Per" + CHR(237) + "odo: " + ;
                DTOC(THIS.this_dDtInicial) + " " + CHR(224) + " " + DTOC(THIS.this_dDtFinal)

            *-- Montar titulo2 (grupo / estoque / empresa filtrados)
            loc_cTitulo2Grp = IIF(EMPTY(loc_cGrEst), "", ;
                ALLTRIM(THIS.this_cCdGrEstoque) + " - " + ALLTRIM(THIS.this_cDsGrEstoque))
            loc_cTitulo2Est = IIF(EMPTY(loc_cCdEstoque), "", ;
                IIF(EMPTY(loc_cGrEst), "", CHR(13)) + ;
                ALLTRIM(THIS.this_cCdEstoque) + " - " + ALLTRIM(THIS.this_cDsEstoque))
            loc_cTitulo2Emp = IIF(EMPTY(loc_cEmp), "", ;
                " / " + ALLTRIM(THIS.this_cEmpresa) + " - " + ALLTRIM(THIS.this_cDesEmpresa))
            THIS.this_cTitulo2 = loc_cTitulo2Grp + loc_cTitulo2Est + loc_cTitulo2Emp

            *-- Buscar tabela de unidades de medida (usada para verificar peso)
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT cunis, cestos FROM SigCdUni", ;
                "CrTmpUni")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao buscar unidades de medida"
            ELSE
                SELECT CrTmpUni
                INDEX ON cunis TAG cunis

                DO CASE
                CASE THIS.this_nOptTipo = 3
                    loc_lSucesso = THIS.PrepararDadosGeral(loc_cEmp, loc_cGrEst, ;
                        loc_cCdEstoque, loc_lObs, loc_nImpMedio)
                OTHERWISE
                    loc_lSucesso = THIS.PrepararDadosRef(loc_cEmp, loc_cGrEst, ;
                        loc_cCdEstoque, loc_cCdCodigo, loc_cDsCodigo, ;
                        loc_nCdBarra, loc_lObs, loc_nImpMedio)
                ENDCASE
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDadosGeral - Modo 3: Geral Por Referencia
    * Cruza SigMvEst com SigMvHst para todos os produtos do estoque filtrado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDadosGeral(par_cEmp, par_cGrEst, par_cCdEstoque, par_lObs, par_nImpMedio)
        LOCAL loc_nResult, loc_lSucesso, loc_lErro
        LOCAL loc_cCodPro, loc_cEmpDopNums, loc_cEmpDnps
        LOCAL loc_cGrupoos, loc_cContaos, loc_cGrupods, loc_cContads
        LOCAL loc_cCunis, loc_cDpros

        loc_lSucesso = .F.
        loc_lErro    = .F.

        *-- Cursor de cabecalho (modo 3: sem Produto/Unidade)
        IF USED("CsCabecalho")
            USE IN CsCabecalho
        ENDIF
        CREATE CURSOR CsCabecalho (;
            NomeEmpresa C(80), Titulo1 C(80), Titulo2 C(80), Periodo C(80), ;
            Opcao N(1), Obs L, ImpMedio L, ImpPeso L, TRACO L)
        INSERT INTO CsCabecalho (NomeEmpresa, Titulo1, Titulo2, Periodo, Opcao, Obs, ImpMedio, ImpPeso) ;
            VALUES (THIS.this_cNomeEmpresa, THIS.this_cTitulo1, THIS.this_cTitulo2, ;
                    THIS.this_cPeriodo, 3, par_lObs, (par_nImpMedio = 1), .F.)

        *-- Selecionar posicoes de estoque (SigMvEst JOIN SigCdPro)
        IF USED("TmpEst")
            USE IN TmpEst
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, ;
            "SELECT a.emps, a.grupos, a.estos, a.cpros, a.codcors, a.codtams, " + ;
            "a.spesos, b.cunis, b.cunips " + ;
            "FROM SigMvEst a, SigCdPro b " + ;
            "WHERE a.emps = " + EscaparSQL(par_cEmp) + ;
            " AND a.grupos = " + EscaparSQL(par_cGrEst) + ;
            " AND a.estos = " + EscaparSQL(par_cCdEstoque) + ;
            " AND a.cpros = b.cpros", ;
            "TmpEst")
        IF loc_nResult < 1
            THIS.this_cMensagemErro = "Erro ao selecionar dados do estoque"
            RETURN .F.
        ENDIF
        SELECT TmpEst
        INDEX ON emps   TAG emps
        INDEX ON grupos TAG grupos
        INDEX ON estos  TAG estos
        INDEX ON cpros  TAG cpros

        *-- Selecionar historico de movimentos (SigMvHst) com parametros de data
        IF USED("TmpHis")
            USE IN TmpHis
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, ;
            "SELECT emps, grupos, estos, dopes, numes, empgruests, empdopnums, " + ;
            "cpros, datas, qtds, sqtds, opers, codbarras, unitmeds, moedmeds, " + ;
            "obs, CidChaves, pesos, spesos " + ;
            "FROM SigMvHst " + ;
            "WHERE empgruests = " + EscaparSQL(par_cEmp + par_cGrEst + par_cCdEstoque) + ;
            " AND datas BETWEEN ?ldDtInicial AND ?ldDtFinal " + ;
            "ORDER BY emps, grupos, estos, cpros, CidChaves", ;
            "TmpHis")
        IF loc_nResult < 1
            THIS.this_cMensagemErro = "Erro ao selecionar hist" + CHR(243) + "rico (geral)"
            RETURN .F.
        ENDIF
        SELECT TmpHis
        INDEX ON empgruests TAG empgruests
        INDEX ON cpros      TAG cpros

        *-- JOIN local VFP: TmpEst x TmpHis -> CsRelatorio (READWRITE para REPLACE em seguida)
        IF USED("CsRelatorio")
            USE IN CsRelatorio
        ENDIF
        SELECT a.cpros, b.datas, a.codcors, a.codtams, a.estos, a.grupos, ;
               b.emps, b.dopes, b.numes, b.empdopnums, b.qtds, b.opers, ;
               b.sqtds, b.codbarras, b.unitmeds, b.moedmeds, b.obs, ;
               SPACE(40) AS dpros, SPACE(3)  AS cunis, ;
               SPACE(10) AS grupoos, SPACE(10) AS contaos, ;
               SPACE(10) AS grupods, SPACE(10) AS contads, ;
               b.CidChaves, b.pesos, b.spesos, a.cunips ;
        FROM TmpEst a, TmpHis b ;
        WHERE a.emps + a.grupos + a.estos = b.empgruests AND a.cpros = b.cpros ;
        ORDER BY b.emps, a.grupos, a.estos, a.cpros, a.codcors, a.codtams, b.CidChaves ;
        INTO CURSOR CsRelatorio READWRITE

        *-- Enriquecer cada registro com descricoes e grupos contabeis
        SELECT CsRelatorio
        GO TOP
        SCAN
            IF loc_lErro
                EXIT
            ENDIF

            loc_cCodPro     = CsRelatorio.cpros
            loc_cEmpDopNums = CsRelatorio.empdopnums
            loc_cEmpDnps    = LEFT(CsRelatorio.empdopnums, 23) + ;
                              STR(VAL(RIGHT(CsRelatorio.empdopnums, 6)), 10)
            loc_cGrupoos    = ""
            loc_cContaos    = ""
            loc_cGrupods    = ""
            loc_cContads    = ""
            loc_cCunis      = ""
            loc_cDpros      = ""

            *-- Buscar grupos contabeis em SigMvCab
            IF USED("TprMvCab")
                USE IN TprMvCab
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT grupoos, contaos, grupods, contads FROM SigMvCab " + ;
                "WHERE empdopnums = " + EscaparSQL(loc_cEmpDopNums), ;
                "TprMvCab")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao buscar movimento contabil"
                loc_lErro = .T.
            ELSE
                SELECT TprMvCab
                GO TOP
                IF !EOF()
                    loc_cGrupoos = ALLTRIM(TprMvCab.grupoos)
                    loc_cContaos = ALLTRIM(TprMvCab.contaos)
                    loc_cGrupods = ALLTRIM(TprMvCab.grupods)
                    loc_cContads = ALLTRIM(TprMvCab.contads)
                    USE IN TprMvCab
                ELSE
                    USE IN TprMvCab
                    *-- Fallback: buscar em SigCdNec usando chave composta longa
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT grupoos, contaos, grupods, contads FROM SigCdNec " + ;
                        "WHERE empdnps = " + EscaparSQL(loc_cEmpDnps), ;
                        "TprMvCab")
                    IF loc_nResult < 1
                        THIS.this_cMensagemErro = "Erro ao buscar NEC"
                        loc_lErro = .T.
                    ELSE
                        SELECT TprMvCab
                        GO TOP
                        IF !EOF()
                            loc_cGrupoos = ALLTRIM(TprMvCab.grupoos)
                            loc_cContaos = ALLTRIM(TprMvCab.contaos)
                            loc_cGrupods = ALLTRIM(TprMvCab.grupods)
                            loc_cContads = ALLTRIM(TprMvCab.contads)
                        ENDIF
                        USE IN TprMvCab
                    ENDIF
                ENDIF
            ENDIF

            IF !loc_lErro
                *-- Buscar descricao e unidade do produto
                IF USED("TmpPro")
                    USE IN TmpPro
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT cpros, dpros, cunis FROM SigCdPro WHERE cpros = " + ;
                    EscaparSQL(loc_cCodPro), ;
                    "TmpPro")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Erro ao buscar produto"
                    loc_lErro = .T.
                ELSE
                    SELECT TmpPro
                    GO TOP
                    IF !EOF()
                        loc_cCunis = ALLTRIM(TmpPro.cunis)
                        loc_cDpros = ALLTRIM(TmpPro.dpros)
                    ENDIF
                    USE IN TmpPro
                ENDIF
            ENDIF

            IF !loc_lErro
                SELECT CsRelatorio
                REPLACE CsRelatorio.grupoos WITH loc_cGrupoos
                REPLACE CsRelatorio.contaos WITH loc_cContaos
                REPLACE CsRelatorio.grupods WITH loc_cGrupods
                REPLACE CsRelatorio.contads WITH loc_cContads
                REPLACE CsRelatorio.cunis   WITH loc_cCunis
                REPLACE CsRelatorio.dpros   WITH loc_cDpros

                *-- Verificar se unidade e de peso (cestos='3') para flag ImpPeso
                IF SEEK(loc_cCunis, "CrTmpUni")
                    IF CrTmpUni.cestos = '3'
                        SELECT CsCabecalho
                        GO TOP
                        REPLACE CsCabecalho.ImpPeso WITH .T.
                        SELECT CsRelatorio
                    ELSE
                        REPLACE CsRelatorio.pesos  WITH 0
                        REPLACE CsRelatorio.spesos WITH 0
                    ENDIF
                ENDIF
            ENDIF

        ENDSCAN

        IF loc_lErro
            RETURN .F.
        ENDIF

        SELECT CsRelatorio
        GO TOP

        loc_lSucesso = .T.
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDadosRef - Modo 1 (Referencia) e Modo 2 (Codigo de Barra)
    * Processa SigMvHst para um produto especifico ou por codigo de barras
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDadosRef(par_cEmp, par_cGrEst, par_cCdEstoque, ;
                                          par_cCdCodigo, par_cDsCodigo, ;
                                          par_nCdBarra, par_lObs, par_nImpMedio)
        LOCAL loc_nResult, loc_lSucesso, loc_lErro
        LOCAL loc_cUnidade, loc_cGrupo, loc_cProduto, loc_cNmCodigo, loc_cCdBarra
        LOCAL loc_cWhereHis, loc_cOrderBy, loc_cSQL
        LOCAL loc_nTipoEstos, loc_lImpPeso, loc_lImpMedio
        LOCAL loc_cCorIni, loc_cCorFim, loc_cTamIni, loc_cTamFim
        LOCAL loc_cEmpDopNums, loc_cEmpDnps, loc_cNota, loc_lPrimeira
        LOCAL loc_lOpExiste, loc_cNop
        LOCAL loc_nNdope, loc_nNume, loc_cDopePeca, loc_cEDN, loc_cNotaPeca

        loc_lSucesso  = .F.
        loc_lErro     = .F.
        loc_cNmCodigo = ALLTRIM(par_cCdCodigo) + " - " + ALLTRIM(par_cDsCodigo)
        loc_cCdBarra  = ALLTRIM(STR(par_nCdBarra, 8))

        *-- Buscar dados do produto em SigCdPro
        IF USED("CrSigCdPro")
            USE IN CrSigCdPro
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, ;
            "SELECT cunis, cgrus, cpros, dpros, cunips FROM SigCdPro " + ;
            "WHERE cpros = " + EscaparSQL(par_cCdCodigo), ;
            "CrSigCdPro")
        IF loc_nResult < 1
            THIS.this_cMensagemErro = "Erro ao buscar produto"
            RETURN .F.
        ENDIF
        SELECT CrSigCdPro
        GO TOP
        IF EOF()
            THIS.this_cMensagemErro = "Produto n" + CHR(227) + "o encontrado: " + ALLTRIM(par_cCdCodigo)
            RETURN .F.
        ENDIF
        loc_cUnidade = "Unid: " + ALLTRIM(CrSigCdPro.cunis)
        loc_cGrupo   = ALLTRIM(CrSigCdPro.cgrus)

        *-- Buscar tipo de estoque do grupo (SigCdGrp.tipoestos)
        IF USED("CrSigCdGrp")
            USE IN CrSigCdGrp
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, ;
            "SELECT tipoestos FROM SigCdGrp WHERE cgrus = " + EscaparSQL(loc_cGrupo), ;
            "CrSigCdGrp")
        IF loc_nResult < 1
            THIS.this_cMensagemErro = "Erro ao buscar grupo de estoque"
            RETURN .F.
        ENDIF
        SELECT CrSigCdGrp
        GO TOP
        loc_nTipoEstos = 0
        IF !EOF()
            loc_nTipoEstos = CrSigCdGrp.tipoestos
        ENDIF

        *-- Montar WHERE e ORDER BY conforme modo e tipo de estoque
        loc_cCorIni = SPACE(4)
        loc_cCorFim = REPLICATE(CHR(254), 4)
        loc_cTamIni = SPACE(2)
        loc_cTamFim = REPLICATE(CHR(254), 2)

        DO CASE
        CASE THIS.this_nOptTipo = 1  && Referencia por produto
            loc_cProduto  = "Produto: " + loc_cNmCodigo
            loc_cWhereHis = "empgruests = " + ;
                EscaparSQL(par_cEmp + par_cGrEst + par_cCdEstoque) + ;
                " AND cpros = " + EscaparSQL(par_cCdCodigo)

            DO CASE
            CASE loc_nTipoEstos = 2  && Codigo/Cor
                loc_cWhereHis = loc_cWhereHis + ;
                    " AND codcors BETWEEN " + EscaparSQL(loc_cCorIni) + ;
                    " AND " + EscaparSQL(loc_cCorFim) + ;
                    " AND datas BETWEEN ?ldDtInicial AND ?ldDtFinal"
                loc_cOrderBy = "emps, grupos, estos, codcors, CidChaves, opers"
            CASE loc_nTipoEstos = 3  && Codigo/Tamanho
                loc_cWhereHis = loc_cWhereHis + ;
                    " AND codtams BETWEEN " + EscaparSQL(loc_cTamIni) + ;
                    " AND " + EscaparSQL(loc_cTamFim) + ;
                    " AND datas BETWEEN ?ldDtInicial AND ?ldDtFinal"
                loc_cOrderBy = "emps, grupos, estos, codtams, CidChaves, opers"
            CASE loc_nTipoEstos = 4  && Codigo/Cor/Tamanho
                loc_cWhereHis = loc_cWhereHis + ;
                    " AND codcors BETWEEN " + EscaparSQL(loc_cCorIni) + ;
                    " AND " + EscaparSQL(loc_cCorFim) + ;
                    " AND codtams BETWEEN " + EscaparSQL(loc_cTamIni) + ;
                    " AND " + EscaparSQL(loc_cTamFim) + ;
                    " AND datas BETWEEN ?ldDtInicial AND ?ldDtFinal"
                loc_cOrderBy = "emps, grupos, estos, codcors, codtams, CidChaves, opers"
            OTHERWISE  && Apenas codigo simples
                loc_cWhereHis = loc_cWhereHis + ;
                    " AND datas BETWEEN ?ldDtInicial AND ?ldDtFinal"
                loc_cOrderBy = "emps, grupos, estos, CidChaves, opers"
            ENDCASE

        CASE THIS.this_nOptTipo = 2  && Codigo de Barra
            loc_cProduto  = "Produto: (" + loc_cCdBarra + ") / " + loc_cNmCodigo
            loc_cWhereHis = "emps = " + EscaparSQL(par_cEmp) + ;
                            " AND codbarras = " + TRANSFORM(par_nCdBarra) + ;
                            " AND datas BETWEEN ?ldDtInicial AND ?ldDtFinal"
            loc_cOrderBy  = "emps, codbarras, CidChaves"
        ENDCASE

        *-- Verificar se unidade e de peso para ImpPeso do cabecalho
        loc_lImpPeso = .F.
        IF SEEK(ALLTRIM(CrSigCdPro.cunis), "CrTmpUni")
            loc_lImpPeso = (CrTmpUni.cestos = '3')
        ENDIF

        *-- Cursor de cabecalho (modo 1/2: com Produto e Unidade)
        IF USED("CsCabecalho")
            USE IN CsCabecalho
        ENDIF
        CREATE CURSOR CsCabecalho (;
            NomeEmpresa C(80), Titulo1 C(80), Titulo2 C(80), Periodo C(80), ;
            Produto C(80), Unidade C(20), Opcao N(1), Obs L, ImpPeso L, ;
            ImpMedio L, TRACO L)
        loc_lImpMedio = (par_nImpMedio = 1)
        INSERT INTO CsCabecalho ;
            (NomeEmpresa, Titulo1, Titulo2, Periodo, Produto, Unidade, ;
             Opcao, Obs, ImpPeso, ImpMedio, Traco) ;
            VALUES (THIS.this_cNomeEmpresa, THIS.this_cTitulo1, THIS.this_cTitulo2, ;
                    THIS.this_cPeriodo, loc_cProduto, loc_cUnidade, ;
                    THIS.this_nOptTipo, par_lObs, loc_lImpPeso, loc_lImpMedio, par_lObs)

        *-- Query principal em SigMvHst com placeholders para campos enriquecidos
        IF USED("CrSigMvHst")
            USE IN CrSigMvHst
        ENDIF
        loc_cSQL = "SELECT emps, grupos, estos, cpros, codcors, codtams, " + ;
                   "CidChaves, codbarras, dopes, numes, qtds, opers, sqtds, " + ;
                   "unitmeds, moedmeds, obs, empdopnums, empos, datas, " + ;
                   "SPACE(10) AS grupoos, SPACE(10) AS grupods, " + ;
                   "SPACE(10) AS contaos, SPACE(10) AS contads, " + ;
                   "pesos, spesos, " + ;
                   "SPACE(40) AS dpros, SPACE(3) AS cunis, SPACE(3) AS cunips " + ;
                   "FROM SigMvHst " + ;
                   "WHERE " + loc_cWhereHis + ;
                   " ORDER BY " + loc_cOrderBy
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigMvHst")
        IF loc_nResult < 1
            THIS.this_cMensagemErro = "Erro ao selecionar hist" + CHR(243) + "rico"
            RETURN .F.
        ENDIF

        *-- Enriquecer registros com descricoes, grupos contabeis e observacoes
        SELECT CrSigMvHst
        GO TOP
        SCAN
            IF loc_lErro
                EXIT
            ENDIF

            loc_cEmpDopNums = CrSigMvHst.empos + CrSigMvHst.dopes + STR(CrSigMvHst.numes, 6)
            loc_cEmpDnps    = CrSigMvHst.empos + CrSigMvHst.dopes + STR(CrSigMvHst.numes, 10)
            loc_cNota       = ""

            *-- Substituir campos de descricao com dados do produto ja carregado
            SELECT CrSigMvHst
            REPLACE CrSigMvHst.dpros  WITH ALLTRIM(CrSigCdPro.dpros)
            REPLACE CrSigMvHst.cunis  WITH ALLTRIM(CrSigCdPro.cunis)
            REPLACE CrSigMvHst.cunips WITH ALLTRIM(CrSigCdPro.cunips)

            *-- Buscar grupos contabeis em SigMvCab
            IF USED("TprMvCab")
                USE IN TprMvCab
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT grupoos, contaos, grupods, contads, Notas FROM SigMvCab " + ;
                "WHERE empdopnums = " + EscaparSQL(loc_cEmpDopNums), ;
                "TprMvCab")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao buscar movimento contabil"
                loc_lErro = .T.
            ELSE
                SELECT TprMvCab
                GO TOP
                IF !EOF()
                    loc_cNota = ALLTRIM(TprMvCab.Notas)
                    SELECT CrSigMvHst
                    REPLACE CrSigMvHst.grupoos WITH ALLTRIM(TprMvCab.grupoos)
                    REPLACE CrSigMvHst.contaos WITH ALLTRIM(TprMvCab.contaos)
                    REPLACE CrSigMvHst.grupods WITH ALLTRIM(TprMvCab.grupods)
                    REPLACE CrSigMvHst.contads WITH ALLTRIM(TprMvCab.contads)
                    USE IN TprMvCab
                ELSE
                    USE IN TprMvCab
                    *-- Fallback: SigCdNec com chave composta longa
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT grupoos, contaos, grupods, contads FROM SigCdNec " + ;
                        "WHERE empdnps = " + EscaparSQL(loc_cEmpDnps), ;
                        "TprMvCab")
                    IF loc_nResult < 1
                        THIS.this_cMensagemErro = "Erro ao buscar NEC"
                        loc_lErro = .T.
                    ELSE
                        SELECT TprMvCab
                        GO TOP
                        IF !EOF()
                            SELECT CrSigMvHst
                            REPLACE CrSigMvHst.grupoos WITH ALLTRIM(TprMvCab.grupoos)
                            REPLACE CrSigMvHst.contaos WITH ALLTRIM(TprMvCab.contaos)
                            REPLACE CrSigMvHst.grupods WITH ALLTRIM(TprMvCab.grupods)
                            REPLACE CrSigMvHst.contads WITH ALLTRIM(TprMvCab.contads)
                        ENDIF
                        USE IN TprMvCab
                    ENDIF
                ENDIF
            ENDIF

            *-- Processar observacao com documento (optObs = 3 = C/Documento)
            IF !loc_lErro AND THIS.this_nOptObs = 3
                IF EMPTY(loc_cNota)
                    *-- Verificar se documento e operacao de producao (SigCdOpd)
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT TOP 1 Dopps FROM SigCdOpd " + ;
                        "WHERE Dopps = " + EscaparSQL(CrSigMvHst.dopes), ;
                        "cursor_4c_CkOpd")
                    loc_lOpExiste = (loc_nResult > 0 AND !EOF("cursor_4c_CkOpd"))
                    IF USED("cursor_4c_CkOpd")
                        USE IN cursor_4c_CkOpd
                    ENDIF

                    IF loc_lOpExiste
                        *-- Buscar ordens de producao vinculadas (SigPdMvf)
                        IF USED("cursor_4c_Mfas")
                            USE IN cursor_4c_Mfas
                        ENDIF
                        loc_nResult = SQLEXEC(gnConnHandle, ;
                            "SELECT Nops FROM SigPdMvf " + ;
                            "WHERE Emps = " + EscaparSQL(CrSigMvHst.empos) + ;
                            " AND Dopps = " + EscaparSQL(CrSigMvHst.dopes) + ;
                            " AND Numps = " + TRANSFORM(CrSigMvHst.numes), ;
                            "cursor_4c_Mfas")
                        IF loc_nResult < 1
                            THIS.this_cMensagemErro = "Erro ao buscar OPs de produ" + CHR(231) + CHR(227) + "o"
                            loc_lErro = .T.
                        ELSE
                            *-- Deduplicar OPs (varias linhas podem apontar para mesma OP)
                            IF USED("cursor_4c_Ops")
                                USE IN cursor_4c_Ops
                            ENDIF
                            SET NULL ON
                            CREATE CURSOR cursor_4c_Ops (Nops C(6))
                            SET NULL OFF
                            INDEX ON Nops TAG Nops

                            SELECT cursor_4c_Mfas
                            GO TOP
                            SCAN
                                SET DECIMALS TO 0
                                loc_cNop = STR(INT(cursor_4c_Mfas.Nops / 10000), 6)
                                SET DECIMALS TO 2
                                SELECT cursor_4c_Ops
                                IF !SEEK(loc_cNop)
                                    APPEND BLANK
                                    REPLACE Nops WITH loc_cNop
                                ENDIF
                                SELECT cursor_4c_Mfas
                            ENDSCAN

                            *-- Montar texto de observacao concatenando numeros de OP
                            loc_lPrimeira = .T.
                            SELECT cursor_4c_Ops
                            GO TOP
                            SCAN
                                loc_cNota = loc_cNota + ;
                                    IIF(loc_lPrimeira, "Ref. OP: ", " / ") + ;
                                    ALLTRIM(cursor_4c_Ops.Nops)
                                loc_lPrimeira = .F.
                            ENDSCAN

                            IF !EMPTY(loc_cNota)
                                SELECT CrSigMvHst
                                REPLACE CrSigMvHst.obs WITH loc_cNota
                            ENDIF

                            IF USED("cursor_4c_Mfas")
                                USE IN cursor_4c_Mfas
                            ENDIF
                            IF USED("cursor_4c_Ops")
                                USE IN cursor_4c_Ops
                            ENDIF
                        ENDIF

                    ELSE
                        *-- Nao e OP: buscar pecas no SigMvPec
                        IF USED("cursor_4c_EstPe")
                            USE IN cursor_4c_EstPe
                        ENDIF
                        loc_nResult = SQLEXEC(gnConnHandle, ;
                            "SELECT Emps, Dopes, Numes, Codigos FROM SigMvPec " + ;
                            "WHERE Emps = " + EscaparSQL(CrSigMvHst.empos) + ;
                            " AND Dopes = " + EscaparSQL(CrSigMvHst.dopes) + ;
                            " AND Numes = " + TRANSFORM(CrSigMvHst.numes), ;
                            "cursor_4c_EstPe")
                        IF loc_nResult < 1
                            THIS.this_cMensagemErro = "Erro ao buscar pe" + CHR(231) + "as"
                            loc_lErro = .T.
                        ELSE
                            loc_lPrimeira = .T.
                            SELECT cursor_4c_EstPe
                            GO TOP
                            SCAN
                                IF loc_lErro
                                    EXIT
                                ENDIF

                                loc_cDopePeca = ALLTRIM(cursor_4c_EstPe.Dopes)
                                loc_cEDN = cursor_4c_EstPe.Emps + ;
                                           loc_cDopePeca + ;
                                           STR(cursor_4c_EstPe.Numes, 6)

                                *-- Buscar nota fiscal em SigMvCab
                                IF USED("cursor_4c_Est2")
                                    USE IN cursor_4c_Est2
                                ENDIF
                                loc_nResult = SQLEXEC(gnConnHandle, ;
                                    "SELECT Notas FROM SigMvCab " + ;
                                    "WHERE empdopnums = " + EscaparSQL(loc_cEDN), ;
                                    "cursor_4c_Est2")
                                IF loc_nResult > 0
                                    SELECT cursor_4c_Est2
                                    GO TOP
                                    IF !EOF()
                                        loc_cNotaPeca = ALLTRIM(cursor_4c_Est2.Notas)
                                        IF !EMPTY(loc_cNotaPeca)
                                            SELECT CrSigMvHst
                                            REPLACE CrSigMvHst.obs WITH ;
                                                IIF(loc_lPrimeira, ;
                                                    "Ref. N.F.: ", ;
                                                    CrSigMvHst.obs + " / ") + ;
                                                loc_cNotaPeca
                                            loc_lPrimeira = .F.
                                        ENDIF
                                    ENDIF
                                    USE IN cursor_4c_Est2
                                ENDIF

                                SELECT cursor_4c_EstPe
                            ENDSCAN

                            IF USED("cursor_4c_EstPe")
                                USE IN cursor_4c_EstPe
                            ENDIF
                        ENDIF
                    ENDIF
                ELSE
                    *-- Nota da NF ja preenchida: substituir observacao diretamente
                    SELECT CrSigMvHst
                    REPLACE CrSigMvHst.obs WITH "Ref. N.F.: " + loc_cNota
                ENDIF
            ENDIF

            SELECT CrSigMvHst
        ENDSCAN

        IF loc_lErro
            RETURN .F.
        ENDIF

        *-- Cursor auxiliar de configuracao para o relatorio FRX
        IF USED("TempCab")
            USE IN TempCab
        ENDIF
        CREATE CURSOR TempCab (ImpMedio L)
        loc_lImpMedio = (par_nImpMedio = 1)
        INSERT INTO TempCab (ImpMedio) VALUES (loc_lImpMedio)

        *-- Cursor de estrutura auxiliar (referenciado pelo relatorio FRX)
        IF USED("TmpHist")
            USE IN TmpHist
        ENDIF
        CREATE CURSOR TmpHist (;
            CPros C(14), CodCors C(4), CodTams C(4), Datas D, ;
            Numes N(6,0), Dopes C(20), Qtds N(12,3), Opers C(1), ;
            SQtds N(12,3), UnitMeds N(16,6), MoedMeds C(3), Codbarras N(8,0))

        SELECT CrSigMvHst
        GO TOP

        loc_lSucesso = .T.
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Pre-visualizacao do relatorio na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                *-- Posicionar cursor de dados correto no inicio
                IF THIS.this_nOptTipo = 3
                    IF USED("CsRelatorio")
                        SELECT CsRelatorio
                        GO TOP
                    ENDIF
                ELSE
                    IF USED("CrSigMvHst")
                        SELECT CrSigMvHst
                        GO TOP
                    ENDIF
                ENDIF

                *-- Escolher relatorio: SigRehp1 (sem coluna peso) ou SigRehp2 (com peso)
                IF USED("CsCabecalho")
                    SELECT CsCabecalho
                    GO TOP
                    IF !EOF()
                        IF !CsCabecalho.ImpPeso
                            REPORT FORM (gc_4c_CaminhoReports + "SigRehp1") PREVIEW NOCONSOLE
                        ELSE
                            REPORT FORM (gc_4c_CaminhoReports + "SigRehp2") PREVIEW NOCONSOLE
                        ENDIF
                    ENDIF
                    USE IN CsCabecalho
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Envia relatorio para impressora com dialogo de selecao
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF THIS.this_nOptTipo = 3
                    IF USED("CsRelatorio")
                        SELECT CsRelatorio
                        GO TOP
                    ENDIF
                ELSE
                    IF USED("CrSigMvHst")
                        SELECT CrSigMvHst
                        GO TOP
                    ENDIF
                ENDIF

                IF USED("CsCabecalho")
                    SELECT CsCabecalho
                    GO TOP
                    IF !EOF()
                        IF !CsCabecalho.ImpPeso
                            REPORT FORM (gc_4c_CaminhoReports + "SigRehp1") ;
                                TO PRINTER PROMPT NOCONSOLE
                        ELSE
                            REPORT FORM (gc_4c_CaminhoReports + "SigRehp2") ;
                                TO PRINTER PROMPT NOCONSOLE
                        ENDIF
                    ENDIF
                    USE IN CsCabecalho
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna descricao do ultimo erro ocorrido
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursors - Fecha todos os cursores abertos por este BO
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursors()
        LOCAL loc_aCursors[19], loc_nI
        loc_aCursors[1]  = "CsRelatorio"
        loc_aCursors[2]  = "CsCabecalho"
        loc_aCursors[3]  = "CrTmpUni"
        loc_aCursors[4]  = "TmpEst"
        loc_aCursors[5]  = "TmpHis"
        loc_aCursors[6]  = "TprMvCab"
        loc_aCursors[7]  = "TmpPro"
        loc_aCursors[8]  = "CrSigCdPro"
        loc_aCursors[9]  = "CrSigCdGrp"
        loc_aCursors[10] = "CrSigMvHst"
        loc_aCursors[11] = "TempCab"
        loc_aCursors[12] = "TmpHist"
        loc_aCursors[13] = "cursor_4c_CrEmpSrh"
        loc_aCursors[14] = "cursor_4c_Mfas"
        loc_aCursors[15] = "cursor_4c_Ops"
        loc_aCursors[16] = "cursor_4c_EstPe"
        loc_aCursors[17] = "cursor_4c_Ope"
        loc_aCursors[18] = "cursor_4c_Est2"
        loc_aCursors[19] = "cursor_4c_CkOpd"
        FOR loc_nI = 1 TO 19
            IF USED(loc_aCursors[loc_nI])
                USE IN (loc_aCursors[loc_nI])
            ENDIF
        ENDFOR
    ENDPROC

ENDDEFINE

