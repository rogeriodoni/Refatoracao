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
[04/06/2026 02:33:09 PM] SIGREEGGBO.Init: Connection handle is invalid.
[04/06/2026 02:33:09 PM] Erro: Erro ao criar SIGREEGGBOVARTYPE retornou: L


### LOG DA ETAPA (06b_testeAutomatico):
[2026-06-04 14:33:04] [INFO] === VFP EXECUTOR v2.0 ===
[2026-06-04 14:33:04] [INFO] Config FPW: (nao fornecido)
[2026-06-04 14:33:04] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-06-04 14:33:04] [INFO] Timeout: 300 segundos
[2026-06-04 14:33:04] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_gmoncuo4.prg
[2026-06-04 14:33:04] [INFO] Conteudo do wrapper:
[2026-06-04 14:33:04] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSIGREEGG', 'C:\4c\tasks\task085', 'REPORT'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGREEGG', 'C:\4c\tasks\task085', 'REPORT'
QUIT

[2026-06-04 14:33:04] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_gmoncuo4.prg
[2026-06-04 14:33:04] [INFO] VFP output esperado em: C:\4c\tasks\task085\vfp_output.txt
[2026-06-04 14:33:04] [INFO] Executando Visual FoxPro 9...
[2026-06-04 14:33:04] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_gmoncuo4.prg
[2026-06-04 14:33:04] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_gmoncuo4.prg
[2026-06-04 14:33:04] [INFO] Timeout configurado: 300 segundos
[2026-06-04 14:33:09] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-06-04 14:33:09] [INFO] VFP9 finalizado em 5.288143 segundos
[2026-06-04 14:33:09] [INFO] Exit Code: 
[2026-06-04 14:33:09] [INFO] 
[2026-06-04 14:33:09] [INFO] Arquivos temporarios preservados para inspecao:
[2026-06-04 14:33:09] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_gmoncuo4.prg
[2026-06-04 14:33:09] [INFO] 
[2026-06-04 14:33:09] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-06-04 14:33:09] [INFO] * Auto-generated wrapper for parameters
[2026-06-04 14:33:09] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-06-04 14:33:09] [INFO] * Parameters: 'FormSIGREEGG', 'C:\4c\tasks\task085', 'REPORT'
[2026-06-04 14:33:09] [INFO] 
[2026-06-04 14:33:09] [INFO] * Anti-dialog protections for unattended execution
[2026-06-04 14:33:09] [INFO] SET SAFETY OFF
[2026-06-04 14:33:09] [INFO] SET RESOURCE OFF
[2026-06-04 14:33:09] [INFO] SET TALK OFF
[2026-06-04 14:33:09] [INFO] SET NOTIFY OFF
[2026-06-04 14:33:09] [INFO] SYS(2335, 0)
[2026-06-04 14:33:09] [INFO] 
[2026-06-04 14:33:09] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGREEGG', 'C:\4c\tasks\task085', 'REPORT'
[2026-06-04 14:33:09] [INFO] QUIT
[2026-06-04 14:33:09] [INFO] 
[2026-06-04 14:33:09] [INFO] === Fim do Wrapper.prg ===
[2026-06-04 14:33:09] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSIGREEGG",
  "timestamp": "20260604143309",
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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREEGG.prg):
*==============================================================================
* FORMSIGREEGG.PRG
* Relatorio: Posicao de Estoque por Grande Grupo
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREEGG.SCX (frmrelatorio)
*
* Filtros (Page1 do PageFrame):
*   - Empresa       (codigo + descricao - SigCdEmp)
*   - Grupo Estoque (codigo + descricao - SigCdGcr)
*   - Conta Estoque (codigo + descricao - SigCdCli)
*   - Grande Grupo  (codigo + descricao - SigCdGpr)
*   - Data Posicao  (data unica)
*   - Opcao Custo   (OptionGroup: Sim=1 / Nao=2, default=2)
*   - Moeda         (codigo + descricao - SigCdMoe)
*
* Relatorio FRX: SigReEgg.frx
*==============================================================================

DEFINE CLASS FormSIGREEGG AS FormBase

    Height      = 380
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
    * InicializarForm - Cria estrutura do formulario de relatorio:
    *   1. Instancia SIGREEGGBO e carrega cursor de empresas
    *   2. Monta cabecalho escuro + CommandGroup de botoes
    *   3. PageFrame com Page1 (filtros) e Page2 (placeholder)
    *   4. Adiciona campos de filtro na Page1
    *   5. Pre-preenche campos com valores iniciais
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Posi" + CHR(231) + CHR(227) + ;
                "o de Estoque por Grande Grupo"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            THIS.this_oRelatorio = CREATEOBJECT("SIGREEGGBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SIGREEGGBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.LimparCampos()

                THIS.Visible = .T.
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar FormSIGREEGG:" + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro com titulo do relatorio
    *   Equivalente ao cntSombra/lblSombra/lblTitulo do framework frmrelatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Top       = 17
            .Left      = 12
            .AutoSize  = .T.
            .Caption   = "Posi" + CHR(231) + CHR(227) + ;
                "o de Estoque por Grande Grupo"
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Top       = 20
            .Left      = 10
            .AutoSize  = .T.
            .Caption   = "Posi" + CHR(231) + CHR(227) + ;
                "o de Estoque por Grande Grupo"
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - CommandGroup com 4 botoes de relatorio
    *   Geometria EXATA do framework frmrelatorio (btnReport):
    *   Left=526->529, Top=4->0, ButtonCount=4
    *   Buttons: Visualizar/Imprimir/Excel/Encerrar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
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
            .Picture         = gc_4c_CaminhoIcones + "ideo.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
        ENDWITH

        WITH THIS.cmg_4c_Botoes.Buttons(2)
            .Top             = 5
            .Left            = 71
            .Width           = 65
            .Height          = 70
            .Caption         = "Imprimir"
            .Picture         = gc_4c_CaminhoIcones + "impressora.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
        ENDWITH

        WITH THIS.cmg_4c_Botoes.Buttons(3)
            .Top             = 5
            .Left            = 137
            .Width           = 65
            .Height          = 70
            .Caption         = "Excel"
            .Picture         = gc_4c_CaminhoIcones + "excel.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
        ENDWITH

        WITH THIS.cmg_4c_Botoes.Buttons(4)
            .Top             = 5
            .Left            = 203
            .Width           = 65
            .Height          = 70
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "otao_encerrar.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Cancel          = .T.
        ENDWITH

        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com 2 paginas
    *   Page1 = filtros do relatorio
    *   Page2 = placeholder (padrao do sistema)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        loc_oPgf.PageCount = 2

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

        loc_oPgf.Page2.Caption   = "Dados"
        loc_oPgf.Page2.FontName  = "Tahoma"
        loc_oPgf.Page2.FontSize  = 8
        loc_oPgf.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPgf.Page2.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page2.ForeColor = RGB(90, 90, 90)

        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Carrega cursor de empresas em memoria
    *   Equivalente ao Init() do original que carregava CrSigCdEmp via poDataMgr
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_nResult
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        TRY
            IF USED("cursor_4c_SigCdEmp")
                USE IN cursor_4c_SigCdEmp
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT cemps, razas, ativas FROM SigCdEmp ORDER BY cemps", ;
                "cursor_4c_SigCdEmp")
            IF loc_nResult > 0
                SELECT cursor_4c_SigCdEmp
                INDEX ON cemps TAG cemps ADDITIVE
                GO TOP
            ELSE
                MsgAviso("Falha ao carregar empresas." + CHR(13) + ;
                    "Valida" + CHR(231) + CHR(227) + "o de empresa usar" + ;
                    CHR(225) + " consulta direta.", "Aviso")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Campos de filtro em Page1
    *   Tops ajustados: Top_page = Top_original - 85 (PageFrame.Top=85)
    *   Empresa(23), GrEstoque(48), Estoque(75), GGrupo(102),
    *   DataPos(129), OptCusto(155), Moeda(158)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- EMPRESA (original Say5.top=111->26, getEmpresa.top=108->23, getDesEmpresa.top=108->23)
        loc_oPagina.AddObject("lbl_4c_Empresa", "Label")
        WITH loc_oPagina.lbl_4c_Empresa
            .Top       = 26
            .Left      = 214
            .AutoSize  = .T.
            .Caption   = "Empresa :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Empresa", "TextBox")
        WITH loc_oPagina.txt_4c_Empresa
            .Top       = 23
            .Left      = 267
            .Width     = 31
            .Height    = 23
            .MaxLength = 3
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DesEmpresa", "TextBox")
        WITH loc_oPagina.txt_4c_DesEmpresa
            .Top       = 23
            .Left      = 300
            .Width     = 290
            .Height    = 23
            .MaxLength = 40
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- GRUPO DE ESTOQUE (Say2.top=138->53, get_Cd_GrEstoque.top=133->48, get_Ds_GrEstoque.top=133->48)
        loc_oPagina.AddObject("lbl_4c_GrEstoque", "Label")
        WITH loc_oPagina.lbl_4c_GrEstoque
            .Top       = 53
            .Left      = 169
            .AutoSize  = .T.
            .Caption   = "Grupo de Estoque :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_CdGrEstoque", "TextBox")
        WITH loc_oPagina.txt_4c_CdGrEstoque
            .Top       = 48
            .Left      = 267
            .Width     = 80
            .Height    = 23
            .MaxLength = 10
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DsGrEstoque", "TextBox")
        WITH loc_oPagina.txt_4c_DsGrEstoque
            .Top       = 48
            .Left      = 349
            .Width     = 150
            .Height    = 23
            .MaxLength = 20
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- CONTA DE ESTOQUE (lbl_estoque.top=165->80, get_cd_estoque.top=160->75, get_ds_estoque.top=160->75)
        loc_oPagina.AddObject("lbl_4c_Estoque", "Label")
        WITH loc_oPagina.lbl_4c_Estoque
            .Top       = 80
            .Left      = 216
            .AutoSize  = .T.
            .Caption   = "Estoque :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_CdEstoque", "TextBox")
        WITH loc_oPagina.txt_4c_CdEstoque
            .Top       = 75
            .Left      = 267
            .Width     = 80
            .Height    = 23
            .MaxLength = 10
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DsEstoque", "TextBox")
        WITH loc_oPagina.txt_4c_DsEstoque
            .Top       = 75
            .Left      = 349
            .Width     = 290
            .Height    = 23
            .MaxLength = 40
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- GRANDE GRUPO (lbl_codigo.top=192->107, get_cd_ggrupo.top=187->102, get_ds_ggrupo.top=187->102)
        loc_oPagina.AddObject("lbl_4c_GGrupo", "Label")
        WITH loc_oPagina.lbl_4c_GGrupo
            .Top       = 107
            .Left      = 188
            .AutoSize  = .T.
            .Caption   = "Grande Grupo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_CdGGrupo", "TextBox")
        WITH loc_oPagina.txt_4c_CdGGrupo
            .Top       = 102
            .Left      = 267
            .Width     = 80
            .Height    = 23
            .MaxLength = 10
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DsGGrupo", "TextBox")
        WITH loc_oPagina.txt_4c_DsGGrupo
            .Top       = 102
            .Left      = 349
            .Width     = 290
            .Height    = 23
            .MaxLength = 40
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- DATA DE POSICAO (lbl_periodo.top=219->134, get_datapos.top=214->129)
        loc_oPagina.AddObject("lbl_4c_DataPos", "Label")
        WITH loc_oPagina.lbl_4c_DataPos
            .Top       = 134
            .Left      = 232
            .AutoSize  = .T.
            .Caption   = "Data :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DataPos", "TextBox")
        WITH loc_oPagina.txt_4c_DataPos
            .Top       = 129
            .Left      = 267
            .Width     = 80
            .Height    = 23
            .Value     = {}
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        *-- CUSTO label (Say1.top=246->161)
        loc_oPagina.AddObject("lbl_4c_Custo", "Label")
        WITH loc_oPagina.lbl_4c_Custo
            .Top       = 161
            .Left      = 227
            .AutoSize  = .T.
            .Caption   = "Custo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OPT CUSTO (opt_custo.top=240->155; Value=2 = Nao por padrao)
        loc_oPagina.AddObject("obj_4c_OptCusto", "OptionGroup")
        WITH loc_oPagina.obj_4c_OptCusto
            .Top           = 155
            .Left          = 268
            .Width         = 103
            .Height        = 27
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 2
            .SpecialEffect = 0
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH
        WITH loc_oPagina.obj_4c_OptCusto.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 5
            .Width     = 34
            .Height    = 15
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPagina.obj_4c_OptCusto.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 57
            .Top       = 5
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- MOEDA (lbl_moeda.top=246->161, get_cd_moeda.top=243->158, get_ds_moeda.top=243->158)
        loc_oPagina.AddObject("lbl_4c_Moeda", "Label")
        WITH loc_oPagina.lbl_4c_Moeda
            .Top       = 161
            .Left      = 394
            .AutoSize  = .T.
            .Caption   = "Moeda : "
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_CdMoeda", "TextBox")
        WITH loc_oPagina.txt_4c_CdMoeda
            .Top       = 158
            .Left      = 441
            .Width     = 31
            .Height    = 23
            .MaxLength = 3
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(0, 0, 0)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DsMoeda", "TextBox")
        WITH loc_oPagina.txt_4c_DsMoeda
            .Top       = 158
            .Left      = 474
            .Width     = 115
            .Height    = 23
            .MaxLength = 15
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- BINDEVENTs: DblClick e KeyPress para campos de filtro com lookup
        BINDEVENT(loc_oPagina.txt_4c_Empresa,     "DblClick", THIS, "AbrirBuscaEmpresa")
        BINDEVENT(loc_oPagina.txt_4c_Empresa,     "KeyPress", THIS, "TeclaEmpresa")
        BINDEVENT(loc_oPagina.txt_4c_DesEmpresa,  "DblClick", THIS, "AbrirBuscaEmpresa")
        BINDEVENT(loc_oPagina.txt_4c_DesEmpresa,  "KeyPress", THIS, "TeclaDesEmpresa")
        BINDEVENT(loc_oPagina.txt_4c_CdGrEstoque, "DblClick", THIS, "AbrirBuscaGrEstoque")
        BINDEVENT(loc_oPagina.txt_4c_CdGrEstoque, "KeyPress", THIS, "TeclaCdGrEstoque")
        BINDEVENT(loc_oPagina.txt_4c_DsGrEstoque, "DblClick", THIS, "AbrirBuscaGrEstoque")
        BINDEVENT(loc_oPagina.txt_4c_DsGrEstoque, "KeyPress", THIS, "TeclaDsGrEstoque")
        BINDEVENT(loc_oPagina.txt_4c_CdEstoque,   "DblClick", THIS, "AbrirBuscaEstoque")
        BINDEVENT(loc_oPagina.txt_4c_CdEstoque,   "KeyPress", THIS, "TeclaCdEstoque")
        BINDEVENT(loc_oPagina.txt_4c_DsEstoque,   "DblClick", THIS, "AbrirBuscaEstoque")
        BINDEVENT(loc_oPagina.txt_4c_DsEstoque,   "KeyPress", THIS, "TeclaDsEstoque")
        BINDEVENT(loc_oPagina.txt_4c_CdGGrupo,    "DblClick", THIS, "AbrirBuscaGGrupo")
        BINDEVENT(loc_oPagina.txt_4c_CdGGrupo,    "KeyPress", THIS, "TeclaCdGGrupo")
        BINDEVENT(loc_oPagina.txt_4c_DsGGrupo,    "DblClick", THIS, "AbrirBuscaGGrupo")
        BINDEVENT(loc_oPagina.txt_4c_DsGGrupo,    "KeyPress", THIS, "TeclaDsGGrupo")
        BINDEVENT(loc_oPagina.txt_4c_DataPos,     "KeyPress", THIS, "TeclaDataPos")
        BINDEVENT(loc_oPagina.txt_4c_CdMoeda,     "DblClick", THIS, "AbrirBuscaMoeda")
        BINDEVENT(loc_oPagina.txt_4c_CdMoeda,     "KeyPress", THIS, "TeclaCdMoeda")
        BINDEVENT(loc_oPagina.txt_4c_DsMoeda,     "DblClick", THIS, "AbrirBuscaMoeda")
        BINDEVENT(loc_oPagina.txt_4c_DsMoeda,     "KeyPress", THIS, "TeclaDsMoeda")
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Inicializa campos com valores padrao
    *   DataPos = DATA() (conforme Init() do BO); opt_custo = 2 (Nao)
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
                RETURN
            ENDIF
            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            loc_oPagina.txt_4c_Empresa.Value     = ""
            loc_oPagina.txt_4c_DesEmpresa.Value  = ""
            loc_oPagina.txt_4c_CdGrEstoque.Value = ""
            loc_oPagina.txt_4c_DsGrEstoque.Value = ""
            loc_oPagina.txt_4c_CdEstoque.Value   = ""
            loc_oPagina.txt_4c_DsEstoque.Value   = ""
            loc_oPagina.txt_4c_CdGGrupo.Value    = ""
            loc_oPagina.txt_4c_DsGGrupo.Value    = ""
            loc_oPagina.txt_4c_CdMoeda.Value     = ""
            loc_oPagina.txt_4c_DsMoeda.Value     = ""
            loc_oPagina.obj_4c_OptCusto.Value    = 2

            IF VARTYPE(THIS.this_oRelatorio) = "O"
                loc_oPagina.txt_4c_DataPos.Value = THIS.this_oRelatorio.this_dDataPos
            ELSE
                loc_oPagina.txt_4c_DataPos.Value = DATE()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Navega para pagina solicitada no PageFrame
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O" AND ;
           VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND ;
           par_nPagina <= THIS.pgf_4c_Paginas.PageCount
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
        ENDIF
    ENDPROC

    *==========================================================================
    * HANDLERS DE TECLADO - Empresa
    *==========================================================================

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
    * HANDLERS DE TECLADO - Grupo de Estoque
    *==========================================================================

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
    * HANDLERS DE TECLADO - Conta de Estoque
    *==========================================================================

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
    * HANDLERS DE TECLADO - Grande Grupo
    *==========================================================================

    PROCEDURE TeclaCdGGrupo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaGGrupo()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdGGrupo()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsGGrupo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.AbrirBuscaGGrupo()
        ENDIF
    ENDPROC

    *==========================================================================
    * HANDLERS DE TECLADO - Data de Posicao e Moeda
    *==========================================================================

    PROCEDURE TeclaDataPos(par_nKeyCode, par_nShiftAltCtrl)
        *-- Campo de data: sem acao especial de tecla
    ENDPROC

    PROCEDURE TeclaCdMoeda(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaMoeda()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdMoeda()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsMoeda(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.AbrirBuscaMoeda()
        ENDIF
    ENDPROC

    *==========================================================================
    * VALIDACAO + LOOKUP - Empresa (SigCdEmp)
    *   Equivale ao fAcessoEmpresa(Usuar,'C',...) do original getEmpresa.Valid
    *==========================================================================

    PROCEDURE ValidarEmpresa()
        LOCAL loc_cCodigo, loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_Empresa.Value)
            IF EMPTY(loc_cCodigo)
                loc_oPagina.txt_4c_DesEmpresa.Value = ""
                RETURN
            ENDIF
            IF USED("cursor_4c_SigCdEmp") AND ;
               SEEK(loc_cCodigo, "cursor_4c_SigCdEmp", "cemps")
                loc_oPagina.txt_4c_Empresa.Value    = ALLTRIM(cursor_4c_SigCdEmp.cemps)
                loc_oPagina.txt_4c_DesEmpresa.Value = ALLTRIM(cursor_4c_SigCdEmp.razas)
            ELSE
                MsgAviso("Empresa n" + CHR(227) + "o encontrada.", "Empresa")
                loc_oPagina.txt_4c_Empresa.Value    = ""
                loc_oPagina.txt_4c_DesEmpresa.Value = ""
                THIS.AbrirBuscaEmpresa()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE AbrirBuscaEmpresa()
        LOCAL loc_oBusca, loc_cValor, loc_oPagina, loc_cCursor
        loc_cCursor = "cursor_4c_SigreEggEmpBusca"
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_Empresa.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", loc_cCursor, "cemps", loc_cValor, ;
                "Selecionar Empresa", "")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("cemps", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("razas", "", "Raz" + CHR(227) + "o Social")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    loc_oPagina.txt_4c_Empresa.Value    = ALLTRIM(cemps)
                    loc_oPagina.txt_4c_DesEmpresa.Value = ALLTRIM(razas)
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
    * VALIDACAO + LOOKUP - Grupo de Estoque (SigCdGcr)
    *   Equivale ao fAcessoContab(Usuar,'C',...) do original get_Cd_GrEstoque.Valid
    *==========================================================================

    PROCEDURE ValidarCdGrEstoque()
        LOCAL loc_cCodigo, loc_cSQL, loc_nResult, loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_CdGrEstoque.Value)
            IF EMPTY(loc_cCodigo)
                loc_oPagina.txt_4c_DsGrEstoque.Value = ""
                loc_oPagina.txt_4c_CdEstoque.Value   = ""
                loc_oPagina.txt_4c_DsEstoque.Value   = ""
                RETURN
            ENDIF
            loc_cSQL = "SELECT TOP 1 codigos, descs FROM SigCdGcr WHERE codigos = " + ;
                       EscaparSQL(loc_cCodigo)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigreEggGcrVal")
            IF loc_nResult > 0 AND !EOF("cursor_4c_SigreEggGcrVal")
                SELECT cursor_4c_SigreEggGcrVal
                loc_oPagina.txt_4c_CdGrEstoque.Value = ALLTRIM(cursor_4c_SigreEggGcrVal.codigos)
                loc_oPagina.txt_4c_DsGrEstoque.Value = ALLTRIM(cursor_4c_SigreEggGcrVal.descs)
            ELSE
                MsgAviso("Grupo de Estoque n" + CHR(227) + "o encontrado.", ;
                         "Grupo de Estoque")
                loc_oPagina.txt_4c_CdGrEstoque.Value = ""
                loc_oPagina.txt_4c_DsGrEstoque.Value = ""
                THIS.AbrirBuscaGrEstoque()
            ENDIF
            IF USED("cursor_4c_SigreEggGcrVal")
                USE IN cursor_4c_SigreEggGcrVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE AbrirBuscaGrEstoque()
        LOCAL loc_oBusca, loc_cValor, loc_oPagina, loc_cCursor
        loc_cCursor = "cursor_4c_SigreEggGcrBusca"
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_CdGrEstoque.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", loc_cCursor, "codigos", loc_cValor, ;
                "Selecionar Grupo de Estoque", "")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    loc_oPagina.txt_4c_CdGrEstoque.Value = ALLTRIM(codigos)
                    loc_oPagina.txt_4c_DsGrEstoque.Value = ALLTRIM(descs)
                    loc_oPagina.txt_4c_CdEstoque.Value   = ""
                    loc_oPagina.txt_4c_DsEstoque.Value   = ""
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
    * VALIDACAO + LOOKUP - Conta de Estoque (SigCdCli)
    *   Equivale ao fAcessoContas(Usuar,grupo,'C',...) do original get_cd_estoque.Valid
    *   Se houver GrEstoque selecionado, filtra SigCdCli pelo grupo (iclis LIKE grupo%)
    *==========================================================================

    PROCEDURE ValidarCdEstoque()
        LOCAL loc_cCodigo, loc_cGrupo, loc_cSQL, loc_nResult, loc_oPagina, loc_cFiltro
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_CdEstoque.Value)
            IF EMPTY(loc_cCodigo)
                loc_oPagina.txt_4c_DsEstoque.Value = ""
                RETURN
            ENDIF
            loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_CdGrEstoque.Value)
            loc_cFiltro = ""
            IF !EMPTY(loc_cGrupo)
                loc_cFiltro = " AND iclis LIKE " + EscaparSQL(loc_cGrupo + "%")
            ENDIF
            loc_cSQL = "SELECT TOP 1 iclis, rclis FROM SigCdCli WHERE iclis = " + ;
                       EscaparSQL(loc_cCodigo) + loc_cFiltro
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigreEggCliVal")
            IF loc_nResult > 0 AND !EOF("cursor_4c_SigreEggCliVal")
                SELECT cursor_4c_SigreEggCliVal
                loc_oPagina.txt_4c_CdEstoque.Value = ALLTRIM(cursor_4c_SigreEggCliVal.iclis)
                loc_oPagina.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_SigreEggCliVal.rclis)
            ELSE
                MsgAviso("Conta de Estoque n" + CHR(227) + "o encontrada.", ;
                         "Conta de Estoque")
                loc_oPagina.txt_4c_CdEstoque.Value = ""
                loc_oPagina.txt_4c_DsEstoque.Value = ""
                THIS.AbrirBuscaEstoque()
            ENDIF
            IF USED("cursor_4c_SigreEggCliVal")
                USE IN cursor_4c_SigreEggCliVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE AbrirBuscaEstoque()
        LOCAL loc_oBusca, loc_cValor, loc_oPagina, loc_cCursor, loc_cGrupo, loc_cFiltro
        loc_cCursor = "cursor_4c_SigreEggCliBusca"
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_CdEstoque.Value)
            loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_CdGrEstoque.Value)
            loc_cFiltro = ""
            IF !EMPTY(loc_cGrupo)
                loc_cFiltro = "iclis LIKE " + EscaparSQL(loc_cGrupo + "%")
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", loc_cCursor, "iclis", loc_cValor, ;
                "Selecionar Conta de Estoque", loc_cFiltro)
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("rclis", "", "Nome")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    loc_oPagina.txt_4c_CdEstoque.Value = ALLTRIM(iclis)
                    loc_oPagina.txt_4c_DsEstoque.Value = ALLTRIM(rclis)
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
    * VALIDACAO + LOOKUP - Grande Grupo (SigCdGpr)
    *   Equivale ao fwBuscaExt('SigCdGpr','TmpGGrupo','codigos',...) do original
    *==========================================================================

    PROCEDURE ValidarCdGGrupo()
        LOCAL loc_cCodigo, loc_cSQL, loc_nResult, loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_CdGGrupo.Value)
            IF EMPTY(loc_cCodigo)
                loc_oPagina.txt_4c_DsGGrupo.Value = ""
                RETURN
            ENDIF
            loc_cSQL = "SELECT TOP 1 codigos, descs FROM SigCdGpr WHERE codigos = " + ;
                       EscaparSQL(loc_cCodigo)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigreEggGprVal")
            IF loc_nResult > 0 AND !EOF("cursor_4c_SigreEggGprVal")
                SELECT cursor_4c_SigreEggGprVal
                loc_oPagina.txt_4c_CdGGrupo.Value = ALLTRIM(cursor_4c_SigreEggGprVal.codigos)
                loc_oPagina.txt_4c_DsGGrupo.Value = ALLTRIM(cursor_4c_SigreEggGprVal.descs)
            ELSE
                MsgAviso("Grande Grupo n" + CHR(227) + "o encontrado.", "Grande Grupo")
                loc_oPagina.txt_4c_CdGGrupo.Value = ""
                loc_oPagina.txt_4c_DsGGrupo.Value = ""
                THIS.AbrirBuscaGGrupo()
            ENDIF
            IF USED("cursor_4c_SigreEggGprVal")
                USE IN cursor_4c_SigreEggGprVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE AbrirBuscaGGrupo()
        LOCAL loc_oBusca, loc_cValor, loc_oPagina, loc_cCursor
        loc_cCursor = "cursor_4c_SigreEggGprBusca"
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_CdGGrupo.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGpr", loc_cCursor, "codigos", loc_cValor, ;
                "Selecionar Grande Grupo", "")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    loc_oPagina.txt_4c_CdGGrupo.Value = ALLTRIM(codigos)
                    loc_oPagina.txt_4c_DsGGrupo.Value = ALLTRIM(descs)
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
    * VALIDACAO + LOOKUP - Moeda (SigCdMoe)
    *   Equivale ao fwBuscaExt('SigCdMoe','crListaRemota','CMoes',...) do original
    *==========================================================================

    PROCEDURE ValidarCdMoeda()
        LOCAL loc_cCodigo, loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_CdMoeda.Value)
            IF EMPTY(loc_cCodigo)
                loc_oPagina.txt_4c_DsMoeda.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE AbrirBuscaMoeda()
        LOCAL loc_oBusca, loc_cValor, loc_oPagina, loc_cCursor
        loc_cCursor = "cursor_4c_SigreEggMoeBusca"
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_CdMoeda.Value)

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", loc_cCursor, "CMoes", loc_cValor, ;
                "Selecionar Moeda", "")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    loc_oPagina.txt_4c_CdMoeda.Value = ALLTRIM(CMoes)
                    loc_oPagina.txt_4c_DsMoeda.Value = ALLTRIM(DMoes)
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
    * TRANSFERENCIA FORM -> BO
    *==========================================================================

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Copia valores dos controles para as propriedades do BO
    *   Equivale ao PROCEDURE processamento do original (leitura dos campos)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            WITH THIS.this_oRelatorio
                .this_cEmpresa     = ALLTRIM(loc_oPagina.txt_4c_Empresa.Value)
                .this_cDesEmpresa  = ALLTRIM(loc_oPagina.txt_4c_DesEmpresa.Value)
                .this_cCdGrEstoque = ALLTRIM(loc_oPagina.txt_4c_CdGrEstoque.Value)
                .this_cDsGrEstoque = ALLTRIM(loc_oPagina.txt_4c_DsGrEstoque.Value)
                .this_cCdEstoque   = ALLTRIM(loc_oPagina.txt_4c_CdEstoque.Value)
                .this_cDsEstoque   = ALLTRIM(loc_oPagina.txt_4c_DsEstoque.Value)
                .this_cCdGGrupo    = ALLTRIM(loc_oPagina.txt_4c_CdGGrupo.Value)
                .this_cDsGGrupo    = ALLTRIM(loc_oPagina.txt_4c_DsGGrupo.Value)
                .this_dDataPos     = loc_oPagina.txt_4c_DataPos.Value
                .this_nOptCusto    = loc_oPagina.obj_4c_OptCusto.Value
                .this_cCdMoeda     = ALLTRIM(loc_oPagina.txt_4c_CdMoeda.Value)
                .this_cDsMoeda     = ALLTRIM(loc_oPagina.txt_4c_DsMoeda.Value)
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * VALIDACAO ANTES DE GERAR O RELATORIO
    *==========================================================================

    *--------------------------------------------------------------------------
    * ValidarCampos - Valida filtros antes de gerar o relatorio
    *   Equivale ao bloco If !(This.Value = 3) em btnReport.Click do original:
    *   1. GrEstoque valido em SigCdGcr (se informado)
    *   2. Estoque valido em SigCdCli (se informado)
    *   3. GGrupo valido em SigCdGpr (se informado)
    *   4. Data de posicao nao vazia
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCampos()
        LOCAL loc_lResultado, loc_oPagina, loc_cCodigo, loc_cSQL, loc_nResult
        loc_lResultado = .T.
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            *-- Valida Grupo de Estoque (se informado)
            loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_CdGrEstoque.Value)
            IF !EMPTY(loc_cCodigo)
                loc_cSQL    = "SELECT TOP 1 codigos FROM SigCdGcr WHERE codigos = " + ;
                              EscaparSQL(loc_cCodigo)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigreEggGcrChk")
                IF loc_nResult < 1 OR EOF("cursor_4c_SigreEggGcrChk")
                    MsgErro("Grupo de Estoque Inv" + CHR(225) + "lido.", "")
                    IF USED("cursor_4c_SigreEggGcrChk")
                        USE IN cursor_4c_SigreEggGcrChk
                    ENDIF
                    loc_oPagina.txt_4c_CdGrEstoque.SetFocus()
                    loc_lResultado = .F.
                ENDIF
                IF USED("cursor_4c_SigreEggGcrChk")
                    USE IN cursor_4c_SigreEggGcrChk
                ENDIF
            ENDIF

            *-- Valida Conta de Estoque (se informada)
            IF loc_lResultado
                loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_CdEstoque.Value)
                IF !EMPTY(loc_cCodigo)
                    loc_cSQL    = "SELECT TOP 1 iclis FROM SigCdCli WHERE iclis = " + ;
                                  EscaparSQL(loc_cCodigo)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigreEggCliChk")
                    IF loc_nResult < 1 OR EOF("cursor_4c_SigreEggCliChk")
                        MsgErro("Conta de Estoque Inv" + CHR(225) + "lida.", "")
                        IF USED("cursor_4c_SigreEggCliChk")
                            USE IN cursor_4c_SigreEggCliChk
                        ENDIF
                        loc_oPagina.txt_4c_CdEstoque.SetFocus()
                        loc_lResultado = .F.
                    ENDIF
                    IF USED("cursor_4c_SigreEggCliChk")
                        USE IN cursor_4c_SigreEggCliChk
                    ENDIF
                ENDIF
            ENDIF

            *-- Valida Grande Grupo (se informado)
            IF loc_lResultado
                loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_CdGGrupo.Value)
                IF !EMPTY(loc_cCodigo)
                    loc_cSQL    = "SELECT TOP 1 codigos FROM SigCdGpr WHERE codigos = " + ;
                                  EscaparSQL(loc_cCodigo)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigreEggGprChk")
                    IF loc_nResult < 1 OR EOF("cursor_4c_SigreEggGprChk")
                        MsgErro("Grande Grupo Inv" + CHR(225) + "lido.", "")
                        IF USED("cursor_4c_SigreEggGprChk")
                            USE IN cursor_4c_SigreEggGprChk
                        ENDIF
                        loc_oPagina.txt_4c_CdGGrupo.SetFocus()
                        loc_lResultado = .F.
                    ENDIF
                    IF USED("cursor_4c_SigreEggGprChk")
                        USE IN cursor_4c_SigreEggGprChk
                    ENDIF
                ENDIF
            ENDIF

            *-- Valida data de posicao (obrigatoria)
            IF loc_lResultado AND EMPTY(loc_oPagina.txt_4c_DataPos.Value)
                MsgErro("Data inv" + CHR(225) + "lida !", "")
                loc_oPagina.txt_4c_DataPos.SetFocus()
                loc_lResultado = .F.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ACOES DOS BOTOES DO RELATORIO
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Preview na tela
    *   Equivale ao btnReport.Visualiza.Click -> PROCEDURE visualizacao do original
    *--------------------------------------------------------------------------
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

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Envia para impressora com prompt
    *   Equivale ao btnReport.Imprime.Click -> PROCEDURE impressao do original
    *--------------------------------------------------------------------------
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

    *--------------------------------------------------------------------------
    * BtnExcelClick - Exporta cursor_4c_Relatorio para XLS
    *   Equivale ao btnReport.DocExcel (Button 3) do original
    *   Nota: original Button 3 pulava validacoes; aqui mantenho validacao
    *   pois sem dados validos nao ha relatorio a exportar
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        LOCAL loc_cArquivo
        TRY
            IF !THIS.ValidarCampos()
                RETURN
            ENDIF
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.PrepararDados()
                MsgErro(THIS.this_oRelatorio.this_cMensagemErro, ;
                        "Relat" + CHR(243) + "rio")
                RETURN
            ENDIF
            IF !USED("cursor_4c_Relatorio") OR RECCOUNT("cursor_4c_Relatorio") = 0
                MsgAviso("Nenhum dado encontrado para os filtros selecionados.", "Excel")
                RETURN
            ENDIF
            SELECT cursor_4c_Relatorio
            loc_cArquivo = PUTFILE("Salvar como...", "RelPosicaoEstoqueGGrupo", "xls")
            IF EMPTY(loc_cArquivo)
                RETURN
            ENDIF
            COPY TO (loc_cArquivo) TYPE XL5
            MsgInfo("Arquivo exportado com sucesso:" + CHR(13) + loc_cArquivo, "Excel")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *   Equivale ao btnReport.Sair (Cancel=.T., ESC tambem fecha) do original
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * STUBS DE COMPATIBILIDADE COM FormBase (form REPORT nao usa CRUD)
    *==========================================================================

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
    * CICLO DE VIDA DO FORM
    *==========================================================================

    *--------------------------------------------------------------------------
    * Destroy - Libera cursor de empresas e BO de relatorio
    *   Equivale ao PROCEDURE Release do original
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_SigCdEmp")
            USE IN cursor_4c_SigCdEmp
        ENDIF
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGREEGGBO.prg):
*==============================================================================
* SIGREEGGBO.PRG
* BO do Relatorio: Posicao de Estoque por Grande Grupo
*
* Herda de: RelatorioBase
* Origem: SIGREEGG.SCX (frmrelatorio)
* Relatorio FRX: SigReEgg.frx
*
* Filtros do relatorio:
*   - Empresa (codigo + descricao)
*   - Grupo de Estoque (codigo + descricao via fAcessoContab)
*   - Conta de Estoque (codigo + descricao via fAcessoContas)
*   - Grande Grupo (codigo + descricao via SigCdGpr)
*   - Data de Posicao (data unica)
*   - Opcao de Custo (1=Sim / 2=Nao, default=2)
*   - Moeda (codigo + descricao via SigCdMoe)
*
* Cursores de referencia carregados no Init():
*   cursor_4c_SigCdEmp  - empresas (cemps, razas, ativas)
*
* Cursor de resultado produzido por PrepararDados():
*   cursor_4c_Relatorio - dados agrupados para REPORT FORM SigReEgg
*
* Cursor de cabecalho produzido por GerarCabecalho():
*   CsCabecalho - nomeempresa, titulo1, titulo2, periodo, impetiq, Impcusto
*==============================================================================

DEFINE CLASS SIGREEGGBO AS RelatorioBase

    *-- Filtros do relatorio
    this_cEmpresa       = ""
    this_cDesEmpresa    = ""
    this_cCdGrEstoque   = ""
    this_cDsGrEstoque   = ""
    this_cCdEstoque     = ""
    this_cDsEstoque     = ""
    this_cCdGGrupo      = ""
    this_cDsGGrupo      = ""
    this_dDataPos       = {}
    this_nOptCusto      = 2
    this_cCdMoeda       = ""
    this_cDsMoeda       = ""

    *-- Nome do cursor de resultado
    this_cCursorDados   = "cursor_4c_Relatorio"

    *--------------------------------------------------------------------------
    * Init - Configura BO e carrega cursor de empresas para processamento
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_nResult

        loc_lSucesso = .F.
        TRY
            DODEFAULT()

            THIS.this_dDataPos    = DATE()
            THIS.this_nOptCusto   = 2
            THIS.this_cTabela     = "SigMvEst"
            THIS.this_cCampoChave = ""

            *-- Carregar empresas (usadas em Processar/ProcessarEmpresa)
            IF USED("cursor_4c_SigCdEmp")
                USE IN cursor_4c_SigCdEmp
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT cemps, razas, ativas FROM SigCdEmp", ;
                "cursor_4c_SigCdEmp")

            IF loc_nResult >= 1
                SELECT cursor_4c_SigCdEmp
                INDEX ON cemps TAG cemps
                GO TOP
            ELSE
                THIS.this_cMensagemErro = "Falha ao carregar cadastro de empresas"
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SIGREEGGBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Orquestra toda a preparacao do relatorio:
    *   1. Valida filtros
    *   2. Gera cabecalho
    *   3. Processa dados por empresa
    * Equivalente aos metodos processamento + processa do legado SIGREEGG.
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.
        TRY
            IF !THIS.ValidarFiltros()
                loc_lSucesso = .F.
            ELSE
                IF !THIS.GerarCabecalho()
                    loc_lSucesso = .F.
                ELSE
                    IF !THIS.Processar()
                        loc_lSucesso = .F.
                    ELSE
                        IF USED(THIS.this_cCursorDados)
                            SELECT (THIS.this_cCursorDados)
                            GO TOP
                        ENDIF
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida os filtros antes de processar
    * Equivalente as validacoes em btnReport.Click do legado SIGREEGG.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFiltros()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_nCount

        loc_lSucesso = .F.
        TRY
            *-- Validar data de posicao (obrigatoria)
            IF EMPTY(THIS.this_dDataPos)
                THIS.this_cMensagemErro = "Data inv" + CHR(225) + "lida!"
                loc_lSucesso = .F.
            ELSE
                loc_lSucesso = .T.
            ENDIF

            *-- Validar Grupo de Estoque (se preenchido)
            IF loc_lSucesso AND !EMPTY(ALLTRIM(THIS.this_cCdGrEstoque))
                loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigCdGcr" + ;
                    " WHERE codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCdGrEstoque))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValGrEst")
                IF loc_nResult >= 1
                    SELECT cursor_4c_ValGrEst
                    loc_nCount = NVL(cursor_4c_ValGrEst.nExiste, 0)
                    USE IN cursor_4c_ValGrEst
                    IF loc_nCount = 0
                        THIS.this_cMensagemErro = "Grupo de Estoque Inv" + ;
                            CHR(225) + "lido."
                        loc_lSucesso = .F.
                    ENDIF
                ELSE
                    USE IN cursor_4c_ValGrEst
                ENDIF
            ENDIF

            *-- Validar Conta de Estoque (se preenchida)
            IF loc_lSucesso AND !EMPTY(ALLTRIM(THIS.this_cCdEstoque))
                loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigCdCli" + ;
                    " WHERE iclis = " + EscaparSQL(ALLTRIM(THIS.this_cCdEstoque))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValEst")
                IF loc_nResult >= 1
                    SELECT cursor_4c_ValEst
                    loc_nCount = NVL(cursor_4c_ValEst.nExiste, 0)
                    USE IN cursor_4c_ValEst
                    IF loc_nCount = 0
                        THIS.this_cMensagemErro = "Conta de Estoque Inv" + ;
                            CHR(225) + "lida."
                        loc_lSucesso = .F.
                    ENDIF
                ELSE
                    USE IN cursor_4c_ValEst
                ENDIF
            ENDIF

            *-- Validar Grande Grupo (se preenchido)
            IF loc_lSucesso AND !EMPTY(ALLTRIM(THIS.this_cCdGGrupo))
                loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigCdGpr" + ;
                    " WHERE codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCdGGrupo))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValGGrp")
                IF loc_nResult >= 1
                    SELECT cursor_4c_ValGGrp
                    loc_nCount = NVL(cursor_4c_ValGGrp.nExiste, 0)
                    USE IN cursor_4c_ValGGrp
                    IF loc_nCount = 0
                        THIS.this_cMensagemErro = "Grande Grupo Inv" + ;
                            CHR(225) + "lido."
                        loc_lSucesso = .F.
                    ENDIF
                ELSE
                    USE IN cursor_4c_ValGGrp
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "ValidarFiltros")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarCabecalho - Cria cursor CsCabecalho para o relatorio FRX.
    * Equivalente ao bloco inicial de PROCEDURE processamento do legado.
    *--------------------------------------------------------------------------
    PROCEDURE GerarCabecalho()
        LOCAL loc_lSucesso, loc_cNomeEmpresa, loc_cTitulo1, loc_cTitulo2
        LOCAL loc_cPeriodo, loc_llImpEtiq, loc_llImpCusto
        LOCAL loc_cEmpresa, loc_cGrupo, loc_cEstoque, loc_cGGrp
        LOCAL loc_ldDataPos

        loc_lSucesso = .F.
        TRY
            loc_cEmpresa  = ALLTRIM(THIS.this_cEmpresa)
            loc_cGrupo    = ALLTRIM(THIS.this_cCdGrEstoque)
            loc_cEstoque  = ALLTRIM(THIS.this_cCdEstoque)
            loc_cGGrp     = ALLTRIM(THIS.this_cCdGGrupo)
            loc_ldDataPos = THIS.this_dDataPos

            *-- Nome da empresa logada
            loc_cNomeEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            IF USED("cursor_4c_SigCdEmp")
                SELECT cursor_4c_SigCdEmp
                IF SEEK(go_4c_Sistema.cCodEmpresa, "cursor_4c_SigCdEmp", "cemps")
                    loc_cNomeEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa) + ;
                        " - " + ALLTRIM(cursor_4c_SigCdEmp.razas)
                ENDIF
            ENDIF

            *-- Titulos do relatorio
            loc_cTitulo1 = "Posi" + CHR(231) + CHR(227) + "o de Estoque por Grande Grupo"

            loc_cTitulo2 = "Grupo: " + IIF(EMPTY(loc_cGrupo), "Todos", ;
                loc_cGrupo + " - " + ALLTRIM(THIS.this_cDsGrEstoque)) + ;
                " / Estoque: " + IIF(EMPTY(loc_cEstoque), "Todos", ;
                loc_cEstoque + " - " + ALLTRIM(THIS.this_cDsEstoque)) + ;
                " / Grande Grupo: " + IIF(EMPTY(loc_cGGrp), "Todos", loc_cGGrp)

            loc_cPeriodo   = "Estoque Existente em " + DTOC(loc_ldDataPos)
            loc_llImpEtiq  = (loc_ldDataPos = DATE())
            loc_llImpCusto = (THIS.this_nOptCusto = 1)

            *-- Criar cursor CsCabecalho
            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF

            CREATE CURSOR CsCabecalho ;
                (nomeempresa C(80), titulo1 C(80), titulo2 C(150), ;
                 periodo C(80), impetiq L, Impcusto L)

            INSERT INTO CsCabecalho (nomeempresa, titulo1, titulo2, periodo, impetiq, Impcusto) ;
                VALUES (loc_cNomeEmpresa, loc_cTitulo1, loc_cTitulo2, ;
                        loc_cPeriodo, loc_llImpEtiq, loc_llImpCusto)

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "GerarCabecalho")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Processar - Orquestra o processamento por empresa.
    * Se empresa vazia: itera todas as empresas ativas de cursor_4c_SigCdEmp.
    * Se empresa especificada: processa apenas ela.
    * Acumula resultados em cursor_4c_Relatorio.
    * Equivalente ao corpo de PROCEDURE processamento do legado.
    *--------------------------------------------------------------------------
    PROCEDURE Processar()
        LOCAL loc_lSucesso, loc_llInicio, loc_llProcessa
        LOCAL loc_cEmpresa, loc_cGrupo, loc_cEstoque, loc_cGGrp, loc_cCodEmp

        loc_lSucesso = .F.
        loc_llInicio = .T.

        TRY
            loc_cEmpresa = ALLTRIM(THIS.this_cEmpresa)
            loc_cGrupo   = ALLTRIM(THIS.this_cCdGrEstoque)
            loc_cEstoque = ALLTRIM(THIS.this_cCdEstoque)
            loc_cGGrp    = ALLTRIM(THIS.this_cCdGGrupo)

            *-- Fechar cursor de relatorio anterior
            IF USED("cursor_4c_Relatorio")
                USE IN cursor_4c_Relatorio
            ENDIF

            IF EMPTY(loc_cEmpresa)
                *-- Processar todas as empresas ativas (exceto 999 e ESC)
                IF !USED("cursor_4c_SigCdEmp")
                    THIS.this_cMensagemErro = "Cursor de empresas n" + CHR(227) + "o dispon" + CHR(237) + "vel"
                    loc_lSucesso = .F.
                ENDIF
                SELECT cursor_4c_SigCdEmp
                GO TOP
                SCAN
                    loc_cCodEmp = ALLTRIM(cursor_4c_SigCdEmp.cemps)
                    IF cursor_4c_SigCdEmp.ativas = 1 ;
                            AND loc_cCodEmp <> "999" ;
                            AND loc_cCodEmp <> "ESC"
                        loc_llProcessa = THIS.ProcessarEmpresa(loc_cCodEmp, ;
                            loc_cGrupo, loc_cEstoque, loc_cGGrp)
                        IF !loc_llProcessa
                            loc_lSucesso = .F.
                        ENDIF
                        IF loc_llInicio
                            SELECT * FROM CsRel INTO CURSOR cursor_4c_Relatorio READWRITE
                            loc_llInicio = .F.
                        ELSE
                            SELECT CsRel
                            GO TOP
                            SCAN
                                SCATTER MEMO MEMVAR
                                INSERT INTO cursor_4c_Relatorio FROM MEMVAR
                                SELECT CsRel
                            ENDSCAN
                        ENDIF
                    ENDIF
                    SELECT cursor_4c_SigCdEmp
                ENDSCAN
            ELSE
                *-- Processar empresa unica
                loc_llProcessa = THIS.ProcessarEmpresa(loc_cEmpresa, ;
                    loc_cGrupo, loc_cEstoque, loc_cGGrp)
                IF !loc_llProcessa
                    loc_lSucesso = .F.
                ENDIF
                SELECT * FROM CsRel INTO CURSOR cursor_4c_Relatorio READWRITE
            ENDIF

            IF USED("cursor_4c_Relatorio")
                SELECT cursor_4c_Relatorio
                GO TOP
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Processar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarEmpresa - Executa as queries de estoque/etiquetas para uma empresa,
    * constroi os cursores intermediarios e gera o cursor CsRel agrupado.
    * Equivalente a PROCEDURE processa do legado SIGREEGG.
    *
    * Parametros:
    *   par_cEmpEst  - Codigo da empresa (3 chars)
    *   par_cGruEst  - Grupo de estoque (10 chars, pode ser vazio)
    *   par_cEstEst  - Conta de estoque (10 chars, pode ser vazio)
    *   par_cGGrupo  - Grande grupo (3 chars, pode ser vazio)
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarEmpresa(par_cEmpEst, par_cGruEst, par_cEstEst, par_cGGrupo)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_cEmpIni, loc_cEmpFin, loc_cGruIni, loc_cGruFin, loc_cEstIni, loc_cEstFin
        LOCAL loc_cFiltro, loc_cFilEti, loc_cDataPosSQL
        LOCAL loc_ldDataPos, loc_lnCotCus, loc_lnSQtds, loc_lnCot, loc_lnCus
        LOCAL loc_cEGEs, loc_cSQLHis

        loc_lSucesso  = .F.
        loc_ldDataPos = THIS.this_dDataPos

        TRY
            *-- Formatar data/hora SQL: 'YYYY-MM-DD 23:59:59'
            loc_cDataPosSQL = "'" + ;
                PADL(YEAR(loc_ldDataPos),  4, "0") + "-" + ;
                PADL(MONTH(loc_ldDataPos), 2, "0") + "-" + ;
                PADL(DAY(loc_ldDataPos),   2, "0") + " 23:59:59'"

            *-- Cotacao da moeda selecionada na data de posicao
            loc_lnCotCus = 1
            IF !EMPTY(ALLTRIM(THIS.this_cCdMoeda))
                loc_lnCotCus = fBuscarCotacao(ALLTRIM(THIS.this_cCdMoeda), ;
                    loc_ldDataPos, gnConnHandle)
                IF loc_lnCotCus = 0
                    loc_lnCotCus = 1
                ENDIF
            ENDIF

            *-- Faixas de filtro (PADR garante comprimento fixo para BETWEEN/=)
            loc_cEmpIni = IIF(!EMPTY(ALLTRIM(par_cEmpEst)), ;
                PADR(ALLTRIM(par_cEmpEst), 3), SPACE(3))
            loc_cEmpFin = IIF(!EMPTY(ALLTRIM(par_cEmpEst)), ;
                PADR(ALLTRIM(par_cEmpEst), 3), REPLICATE(CHR(254), 3))
            loc_cGruIni = IIF(!EMPTY(ALLTRIM(par_cGruEst)), ;
                PADR(ALLTRIM(par_cGruEst), 10), SPACE(10))
            loc_cGruFin = IIF(!EMPTY(ALLTRIM(par_cGruEst)), ;
                PADR(ALLTRIM(par_cGruEst), 10), REPLICATE(CHR(254), 10))
            loc_cEstIni = IIF(!EMPTY(ALLTRIM(par_cEstEst)), ;
                PADR(ALLTRIM(par_cEstEst), 10), SPACE(10))
            loc_cEstFin = IIF(!EMPTY(ALLTRIM(par_cEstEst)), ;
                PADR(ALLTRIM(par_cEstEst), 10), REPLICATE(CHR(254), 10))

            *-- Filtro principal: empgruests = emp(3) + grupos(10) + estos(10)
            IF !EMPTY(ALLTRIM(par_cEmpEst)) AND ;
               !EMPTY(ALLTRIM(par_cGruEst)) AND ;
               !EMPTY(ALLTRIM(par_cEstEst))
                loc_cFiltro = "a.empgruests = '" + ;
                    PADR(ALLTRIM(par_cEmpEst), 3) + ;
                    PADR(ALLTRIM(par_cGruEst), 10) + ;
                    PADR(ALLTRIM(par_cEstEst), 10) + "'"
            ELSE
                loc_cFiltro = "a.empgruests BETWEEN '" + ;
                    loc_cEmpIni + loc_cGruIni + loc_cEstIni + ;
                    "' AND '" + ;
                    loc_cEmpFin + loc_cGruFin + loc_cEstFin + "'"
            ENDIF

            *-- Filtro etiquetas: usa colunas separadas (empos, grupos, contas)
            loc_cFilEti = "a.empos BETWEEN '" + ;
                    loc_cEmpIni + "' AND '" + loc_cEmpFin + "'" + ;
                " AND a.grupos BETWEEN '" + ;
                    loc_cGruIni + "' AND '" + loc_cGruFin + "'" + ;
                " AND a.contas BETWEEN '" + ;
                    loc_cEstIni + "' AND '" + loc_cEstFin + "'"
            IF loc_ldDataPos <> DATE()
                loc_cFilEti = loc_cFilEti + " AND a.datas <= " + loc_cDataPosSQL
            ENDIF

            *-- Fechar cursor temporario anterior
            IF USED("TmpEst")
                USE IN TmpEst
            ENDIF

            *-- Query principal: SigMvEst com joins SigCdPro, SigCdGrp, SigCdGpr
            loc_cSQL = "SELECT a.cidchaves, a.emps, a.grupos, a.estos, a.cpros," + ;
                " a.sqtds AS saldo," + ;
                " c.mercs AS ggrupo, b.CustoFs, b.MoeCusFs, b.cUnis, d.Descs" + ;
                " FROM SigMvEst a" + ;
                " INNER JOIN SigCdPro b ON b.cpros = a.cpros" + ;
                " INNER JOIN SigCdGrp c ON c.cgrus = b.cgrus" + ;
                " LEFT JOIN SigCdGpr d ON d.Codigos = c.Mercs" + ;
                " WHERE " + loc_cFiltro
            IF !EMPTY(ALLTRIM(par_cGGrupo))
                loc_cSQL = loc_cSQL + ;
                    " AND c.mercs = '" + ALLTRIM(par_cGGrupo) + "'"
            ENDIF
            loc_cSQL = loc_cSQL + ;
                " GROUP BY a.cidchaves, a.emps, a.grupos, a.estos, a.cpros," + ;
                " a.sqtds, c.mercs, b.CustoFs, b.MoeCusFs, d.Descs, b.cUnis"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpEst")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao selecionar produtos do estoque"
                loc_lSucesso = .F.
            ENDIF

            *-- Se data diferente de hoje: recalcular saldo historico a partir de SigMvHst
            IF loc_ldDataPos <> DATE()
                SELECT TmpEst
                GO TOP
                SCAN
                    IF EMPTY(TmpEst.emps) OR EMPTY(TmpEst.grupos) OR EMPTY(TmpEst.estos)
                        DELETE
                        LOOP
                    ENDIF

                    loc_lnSQtds = 0

                    *-- Chave composta: emps(3) + grupos(10) + estos(10) = 23 chars
                    loc_cEGEs = PADR(ALLTRIM(TmpEst.emps), 3) + ;
                        PADR(ALLTRIM(TmpEst.grupos), 10) + ;
                        PADR(ALLTRIM(TmpEst.estos), 10)

                    IF USED("TmpHis")
                        USE IN TmpHis
                    ENDIF

                    loc_cSQLHis = "SELECT TOP 1 EmpGruEsts, Cpros, CidChaves, Sqtds" + ;
                        " FROM SigMvHst" + ;
                        " WHERE EmpGruEsts = " + EscaparSQL(loc_cEGEs) + ;
                        " AND CPros = " + EscaparSQL(ALLTRIM(TmpEst.cpros)) + ;
                        " AND Datas <= " + loc_cDataPosSQL + ;
                        " ORDER BY EmpGruEsts ASC, Cpros ASC, CidChaves DESC"

                    IF SQLEXEC(gnConnHandle, loc_cSQLHis, "TmpHis") >= 1
                        SELECT TmpHis
                        GO TOP
                        IF !EOF()
                            loc_lnSQtds = TmpHis.SQtds
                        ENDIF
                    ENDIF

                    SELECT TmpEst
                    REPLACE TmpEst.saldo WITH loc_lnSQtds
                ENDSCAN

                IF USED("TmpHis")
                    USE IN TmpHis
                ENDIF
            ENDIF

            *-- Agrupar TmpEst -> CsEst
            IF USED("CsEst")
                USE IN CsEst
            ENDIF

            SELECT MAX(emps) AS emps, grupos, estos, ggrupo, ;
                PADR(NVL(Descs, ""), 40) AS descs, MoeCusFs, cUnis, ;
                SUM(saldo) AS saldo, SUM(0.000) AS etiqs, ;
                SUM(CustoFs * saldo) AS CustoFs ;
                FROM TmpEst ;
                GROUP BY 2, 3, 4, 5, 6, 7 ;
                INTO CURSOR CsEst READWRITE

            IF USED("TmpEst")
                USE IN TmpEst
            ENDIF

            *-- Se data = hoje: buscar etiquetas de SigOpEtq
            IF loc_ldDataPos = DATE()
                IF USED("TmpEti")
                    USE IN TmpEti
                ENDIF

                loc_cSQL = "SELECT a.cbars, a.empos, a.grupos, a.contas, a.cpros," + ;
                    " a.qtds AS etiqs, c.mercs AS ggrupo," + ;
                    " d.Descs, b.CustoFs, b.MoeCusFs, b.cUnis" + ;
                    " FROM SigOpEtq a" + ;
                    " INNER JOIN SigCdPro b ON b.cpros = a.cpros" + ;
                    " INNER JOIN SigCdGrp c ON c.cgrus = b.cgrus" + ;
                    " LEFT JOIN SigCdGpr d ON d.Codigos = c.Mercs" + ;
                    " WHERE " + loc_cFilEti
                IF !EMPTY(ALLTRIM(par_cGGrupo))
                    loc_cSQL = loc_cSQL + ;
                        " AND c.mercs = '" + ALLTRIM(par_cGGrupo) + "'"
                ENDIF
                loc_cSQL = loc_cSQL + ;
                    " GROUP BY a.cbars, a.empos, a.grupos, a.contas, a.cpros," + ;
                    " a.qtds, c.mercs, d.Descs, b.CustoFs, b.MoeCusFs, b.cUnis"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpEti")

                IF loc_nResult >= 1
                    IF USED("CsEti")
                        USE IN CsEti
                    ENDIF
                    SELECT MAX(empos) AS emps, grupos, contas AS estos, ggrupo, ;
                        PADR(NVL(Descs, ""), 40) AS descs, MoeCusFs, cUnis, ;
                        SUM(0.000) AS saldo, SUM(etiqs) AS etiqs, ;
                        SUM(0.000) AS CustoFs ;
                        FROM TmpEti ;
                        WHERE !EMPTY(grupos) AND !EMPTY(contas) ;
                        GROUP BY 2, 3, 4, 5, 6, 7 ;
                        INTO CURSOR CsEti READWRITE
                ENDIF

                IF USED("TmpEti")
                    USE IN TmpEti
                ENDIF
            ENDIF

            *-- Montar TmpRelatorio: UNION ALL CsEst + CsEti (ou apenas CsEst)
            IF USED("TmpRelatorio")
                USE IN TmpRelatorio
            ENDIF

            IF loc_ldDataPos = DATE() AND USED("CsEti")
                SELECT * FROM CsEst ;
                UNION ALL ;
                SELECT * FROM CsEti ;
                INTO CURSOR TmpRelatorio READWRITE
            ELSE
                SELECT * FROM CsEst INTO CURSOR TmpRelatorio READWRITE
            ENDIF

            IF USED("CsEst")
                USE IN CsEst
            ENDIF
            IF USED("CsEti")
                USE IN CsEti
            ENDIF

            *-- Converter custo para moeda selecionada (se opt_custo = 1)
            IF THIS.this_nOptCusto = 1 AND !EMPTY(ALLTRIM(THIS.this_cCdMoeda))
                SELECT TmpRelatorio
                SCAN
                    loc_lnCot = fBuscarCotacao(ALLTRIM(TmpRelatorio.MoeCusFs), ;
                        loc_ldDataPos, gnConnHandle)
                    IF loc_lnCot = 0
                        loc_lnCot = 1
                    ENDIF
                    loc_lnCus = TmpRelatorio.CustoFs * loc_lnCot / loc_lnCotCus
                    REPLACE TmpRelatorio.CustoFs WITH loc_lnCus, ;
                            TmpRelatorio.MoeCusFs WITH PADR(ALLTRIM(THIS.this_cCdMoeda), 3)
                ENDSCAN
            ENDIF

            *-- UNION ALL final com 3 tipos: detalhe(1), total grupo(2), total empresa(3)
            IF USED("CsRel")
                USE IN CsRel
            ENDIF

            IF THIS.this_nOptCusto = 1
                SELECT 1 AS Tps, Emps, Grupos, Estos, GGrupo, ;
                        Grupos AS GrupoI, Estos AS EstoI, GGrupo AS GGrupoI, ;
                        cUnis, Descs, MoeCusFs, ;
                        SUM(Saldo) AS Saldo, SUM(Etiqs) AS Etiqs, ;
                        SUM(CustoFs) AS CustoFS, .F. AS ImpLinha ;
                    FROM TmpRelatorio ;
                    GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ;
                UNION ALL ;
                SELECT 2 AS Tps, Emps, Grupos, SPACE(10) AS Estos, ;
                        "   " AS GGrupo, SPACE(10) AS GrupoI, ;
                        SPACE(10) AS EstoI, "   " AS GGrupoI, ;
                        cUnis, PADR("Total Grupo", 40) AS Descs, MoeCusFs, ;
                        SUM(Saldo) AS Saldo, SUM(Etiqs) AS Etiqs, ;
                        SUM(CustoFs) AS CustoFS, .F. AS ImpLinha ;
                    FROM TmpRelatorio ;
                    GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ;
                UNION ALL ;
                SELECT 3 AS Tps, Emps, REPLICATE(CHR(254), 10) AS Grupos, ;
                        SPACE(10) AS Estos, "   " AS GGrupo, ;
                        SPACE(10) AS GrupoI, SPACE(10) AS EstoI, ;
                        "   " AS GGrupoI, cUnis, ;
                        PADR("Total Empresa", 40) AS Descs, MoeCusFs, ;
                        SUM(Saldo) AS Saldo, SUM(Etiqs) AS Etiqs, ;
                        SUM(CustoFs) AS CustoFS, .F. AS ImpLinha ;
                    FROM TmpRelatorio ;
                    GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ;
                    INTO CURSOR CsRel ORDER BY 2, 3, 1, 5, 9, 11 READWRITE
            ELSE
                SELECT 1 AS Tps, Emps, Grupos, Estos, GGrupo, ;
                        Grupos AS GrupoI, Estos AS EstoI, GGrupo AS GGrupoI, ;
                        cUnis, Descs, " " AS MoeCusFs, 0 AS CustoFs, ;
                        SUM(Saldo) AS Saldo, SUM(Etiqs) AS Etiqs, ;
                        .F. AS ImpLinha ;
                    FROM TmpRelatorio ;
                    GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ;
                UNION ALL ;
                SELECT 2 AS Tps, Emps, Grupos, SPACE(10) AS Estos, ;
                        "   " AS GGrupo, SPACE(10) AS GrupoI, ;
                        SPACE(10) AS EstoI, "   " AS GGrupoI, ;
                        cUnis, PADR("Total Grupo", 40) AS Descs, " " AS MoeCusFs, ;
                        0 AS CustoFS, SUM(Saldo) AS Saldo, ;
                        SUM(Etiqs) AS Etiqs, .F. AS ImpLinha ;
                    FROM TmpRelatorio ;
                    GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ;
                UNION ALL ;
                SELECT 3 AS Tps, Emps, REPLICATE(CHR(254), 10) AS Grupos, ;
                        SPACE(10) AS Estos, "   " AS GGrupo, ;
                        SPACE(10) AS GrupoI, SPACE(10) AS EstoI, ;
                        "   " AS GGrupoI, cUnis, ;
                        PADR("Total Empresa", 40) AS Descs, " " AS MoeCusFs, ;
                        0 AS CustoFS, SUM(Saldo) AS Saldo, ;
                        SUM(Etiqs) AS Etiqs, .F. AS ImpLinha ;
                    FROM TmpRelatorio ;
                    GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ;
                    INTO CURSOR CsRel ORDER BY 2, 3, 1, 5, 9, 11 READWRITE
            ENDIF

            IF USED("TmpRelatorio")
                USE IN TmpRelatorio
            ENDIF

            *-- Remover linhas com saldo = 0 (e etiqs = 0 se for hoje)
            IF loc_ldDataPos = DATE()
                DELETE FROM CsRel WHERE saldo = 0 AND etiqs = 0
            ELSE
                DELETE FROM CsRel WHERE saldo = 0
            ENDIF

            *-- Marcar ImpLinha: linha anterior a cada "Total ..." recebe .T.
            SELECT CsRel
            GO TOP
            LOCAL loc_nVz, loc_cDescAtual
            loc_nVz = 1
            DO WHILE !EOF()
                IF loc_nVz = 1
                    LOCATE FOR Descs = "Total "
                ELSE
                    CONTINUE
                ENDIF
                IF !EOF()
                    SKIP -1
                    IF !DELETED()
                        REPLACE ImpLinha WITH .T.
                    ENDIF
                    SKIP
                    loc_cDescAtual = Descs
                    DO WHILE Descs = loc_cDescAtual AND !EOF()
                        SKIP
                    ENDDO
                    IF !EOF()
                        SKIP -1
                    ENDIF
                ENDIF
                loc_nVz = 2
            ENDDO

            SELECT CsRel
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "ProcessarEmpresa")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview na tela.
    * Equivalente a PROCEDURE visualizacao do legado SIGREEGG.
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_cRelPath, loc_lSucesso

        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ELSE
                loc_cRelPath = IIF(TYPE("gc_4c_CaminhoReports") = "C", ;
                    gc_4c_CaminhoReports, "") + "SigReEgg"
                REPORT FORM &loc_cRelPath PREVIEW NOCONSOLE
                IF USED("CsCabecalho")
                    USE IN CsCabecalho
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora com prompt.
    * Equivalente a PROCEDURE impressao do legado SIGREEGG.
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_cRelPath, loc_lSucesso

        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ELSE
                loc_cRelPath = IIF(TYPE("gc_4c_CaminhoReports") = "C", ;
                    gc_4c_CaminhoReports, "") + "SigReEgg"
                REPORT FORM &loc_cRelPath TO PRINTER PROMPT NOCONSOLE
                IF USED("CsCabecalho")
                    USE IN CsCabecalho
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - NAO APLICAVEL a Relatorios.
    * Stub para compatibilidade com pipeline de validacao (Fase 2).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - NAO APLICAVEL a Relatorios.
    * Relatorios sao somente-leitura. Use Imprimir() ou Visualizar().
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada em relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - NAO APLICAVEL a Relatorios.
    * Relatorios sao somente-leitura. Use Imprimir() ou Visualizar().
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada em relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro atual
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursoresIntermedios - Fecha todos os cursores temporarios
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursoresIntermedios()
        LOCAL loc_aCursores[8], loc_i

        loc_aCursores[1] = "TmpEst"
        loc_aCursores[2] = "TmpEti"
        loc_aCursores[3] = "TmpHis"
        loc_aCursores[4] = "TmpRelatorio"
        loc_aCursores[5] = "CsEst"
        loc_aCursores[6] = "CsEti"
        loc_aCursores[7] = "CsRel"
        loc_aCursores[8] = "CsCabecalho"

        FOR loc_i = 1 TO ALEN(loc_aCursores)
            IF USED(loc_aCursores[loc_i])
                USE IN (loc_aCursores[loc_i])
            ENDIF
        NEXT
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores de referencia e intermediarios
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.LimparCursoresIntermedios()

        IF USED("cursor_4c_SigCdEmp")
            USE IN cursor_4c_SigCdEmp
        ENDIF
        IF USED("cursor_4c_Relatorio")
            USE IN cursor_4c_Relatorio
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE

