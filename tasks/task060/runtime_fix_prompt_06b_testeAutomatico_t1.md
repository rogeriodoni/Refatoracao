# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'BtnIncluirNavegacao': BtnIncluirClick nao navegou para Page2 (ActivePage=1)

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[05/17/26 05:09:41 PM] CarregarMoedaPadrao: Connection handle is invalid.
[05/17/26 05:09:41 PM] CarregarCaptionsOpcao: Connection handle is invalid.
[05/17/26 05:09:41 PM] CarregarCursoresBase: Connection handle is invalid.
[05/17/26 05:09:41 PM] Erro ao Visualizar: Connection handle is invalid.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-05-17 17:09:38] [INFO] === VFP EXECUTOR v2.0 ===
[2026-05-17 17:09:38] [INFO] Config FPW: (nao fornecido)
[2026-05-17 17:09:38] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-05-17 17:09:38] [INFO] Timeout: 300 segundos
[2026-05-17 17:09:38] [INFO] Wrapper PRG criado para parametros: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_xiptgzuy.prg
[2026-05-17 17:09:38] [INFO] Conteudo do wrapper:
[2026-05-17 17:09:38] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigrecom', 'C:\4c\tasks\task060', 'REPORT'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigrecom', 'C:\4c\tasks\task060', 'REPORT'
QUIT

[2026-05-17 17:09:38] [INFO] Comando VFP: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_xiptgzuy.prg
[2026-05-17 17:09:38] [INFO] VFP output esperado em: C:\4c\tasks\task060\vfp_output.txt
[2026-05-17 17:09:38] [INFO] Executando Visual FoxPro 9...
[2026-05-17 17:09:38] [INFO] Comando completo: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_xiptgzuy.prg
[2026-05-17 17:09:38] [INFO] Executando: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_xiptgzuy.prg
[2026-05-17 17:09:38] [INFO] Timeout configurado: 300 segundos
[2026-05-17 17:09:41] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-05-17 17:09:41] [INFO] VFP9 finalizado em 2.9441905 segundos
[2026-05-17 17:09:41] [INFO] Exit Code: 
[2026-05-17 17:09:41] [INFO] 
[2026-05-17 17:09:41] [INFO] Arquivos temporarios preservados para inspecao:
[2026-05-17 17:09:41] [INFO]   Wrapper.prg: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_xiptgzuy.prg
[2026-05-17 17:09:41] [INFO] 
[2026-05-17 17:09:41] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-05-17 17:09:41] [INFO] * Auto-generated wrapper for parameters
[2026-05-17 17:09:41] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-05-17 17:09:41] [INFO] * Parameters: 'Formsigrecom', 'C:\4c\tasks\task060', 'REPORT'
[2026-05-17 17:09:41] [INFO] 
[2026-05-17 17:09:41] [INFO] * Anti-dialog protections for unattended execution
[2026-05-17 17:09:41] [INFO] SET SAFETY OFF
[2026-05-17 17:09:41] [INFO] SET RESOURCE OFF
[2026-05-17 17:09:41] [INFO] SET TALK OFF
[2026-05-17 17:09:41] [INFO] SET NOTIFY OFF
[2026-05-17 17:09:41] [INFO] SYS(2335, 0)
[2026-05-17 17:09:41] [INFO] 
[2026-05-17 17:09:41] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigrecom', 'C:\4c\tasks\task060', 'REPORT'
[2026-05-17 17:09:41] [INFO] QUIT
[2026-05-17 17:09:41] [INFO] 
[2026-05-17 17:09:41] [INFO] === Fim do Wrapper.prg ===
[2026-05-17 17:09:41] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formsigrecom",
  "timestamp": "20260517170941",
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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrecom.prg):
*==============================================================================
* FORMSIGRECOM.PRG
* Relatorio de Comissao - Formulario de Filtros
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGRECOM.SCX (frmrelatorio)
*
* Filtros:
*   - Periodo : txt_4c_DtInicial / txt_4c_DtFinal
*   - Moeda   : txt_4c_CdMoeda (c=3) + txt_4c_DsMoeda (c=15)
*   - Vendedor: txt_4c_Vendedor (c=10)
*   - Opcao   : opt_4c_NrOpcao  (3 botoes, captions de SigCdPac)
*   - Tipo    : opt_4c_Tipo     (4: Analitico/Sintetico/Resumo/AnalMedias)
*   - Quebra  : opt_4c_Quebras  (2: Datas / Datas+Operacoes)
*   - ValBase : opt_4c_Base     (3: Itens/Movimentacao/Movimentacao S/ST)
*   - Ordem   : opt_4c_Ordem   (6 opcoes, so visivel quando Tipo=4, hidden)
*
* Dimensoes originais: Width=800, Height=300
* Cabecalho Top=0, Height=80
* PageFrame Top=85, Height=215 (300-85)
* Page1.Top = Top_original - 85
*==============================================================================

DEFINE CLASS Formsigrecom AS FormBase

    Height      = 300
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

    *-- BO de relatorio (instanciado em InicializarForm)
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
            THIS.Caption = "Relat" + CHR(243) + "rio de Comiss" + CHR(227) + "o"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            IF TYPE("gc_4c_CaminhoReports") = "U"
                gc_4c_CaminhoReports = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            THIS.this_oRelatorio = CREATEOBJECT("sigrecomBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar sigrecomBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarPageFrame()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.LimparCampos()
                THIS.InicializarOpcoes()
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
    * ConfigurarCabecalho - Container escuro superior com titulo e botoes
    *   BackColor=RGB(100,100,100) = cinza medio do framework (cntSombra)
    *   cmg_4c_Botoes: CommandGroup 4 botoes (Visualizar/Imprimir/DocExcel/Sair)
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
                .Caption   = "Relat" + CHR(243) + "rio de Comiss" + CHR(227) + "o"
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
                .Caption   = "Relat" + CHR(243) + "rio de Comiss" + CHR(227) + "o"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Botoes de relatorio (framework frmrelatorio: cmg_4c_Botoes)
            *-- Left=529 Width=273 canonico frmrelatorio; FontName=Comic Sans MS; Width=65 por botao
            .AddObject("cmg_4c_Botoes", "CommandGroup")
            WITH .cmg_4c_Botoes
                .Top           = 0
                .Left          = 529
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
                    .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
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
                    .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
                    .PicturePosition = 13
                    .FontName        = "Tahoma"
                    .FontSize        = 8
                    .FontBold        = .T.
                    .FontItalic      = .T.
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
                    .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
                    .PicturePosition = 13
                    .FontName        = "Tahoma"
                    .FontSize        = 8
                    .FontBold        = .T.
                    .FontItalic      = .T.
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
                    .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
                    .PicturePosition = 13
                    .Cancel          = .T.
                    .FontName        = "Tahoma"
                    .FontSize        = 8
                    .FontBold        = .T.
                    .FontItalic      = .T.
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
    * ConfigurarPageFrame - PageFrame com 1 pagina (Filtros)
    *   Form: Width=800, Height=300
    *   Cabecalho Height=80; PageFrame Top=85, Height=215, Width=802
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        loc_oPgf.PageCount = 1
        loc_oPgf.Top       = 85
        loc_oPgf.Left      = -1
        loc_oPgf.Width     = THIS.Width + 2
        loc_oPgf.Height    = THIS.Height - 85
        loc_oPgf.Tabs      = .F.

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
    * ConfigurarPaginaLista - Controles de filtro na Page1
    *   Posicoes: Top_page1 = Top_original - 85
    *   Controles de data, moeda, vendedor e grupos de opcao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oCtrl
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Periodo
        loc_oPagina.AddObject("lbl_4c_Periodo", "Label")
        WITH loc_oPagina.lbl_4c_Periodo
            .Top       = 7
            .Left      = 215
            .Width     = 46
            .Height    = 18
            .Caption   = "Per" + CHR(237) + "odo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oPagina.txt_4c_DtInicial
            .Top         = 3
            .Left        = 264
            .Width       = 80
            .Height      = 23
            .Value       = {}
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(0, 0, 0)
            .Format      = "K"
            .MaxLength   = 10
            .SpecialEffect = 1
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DtInicial, "KeyPress", THIS, "TeclaDataInicial")

        loc_oPagina.AddObject("lbl_4c_PeriodoA", "Label")
        WITH loc_oPagina.lbl_4c_PeriodoA
            .Top       = 8
            .Left      = 348
            .Width     = 8
            .Height    = 18
            .Caption   = CHR(224)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DtFinal", "TextBox")
        WITH loc_oPagina.txt_4c_DtFinal
            .Top         = 3
            .Left        = 360
            .Width       = 80
            .Height      = 23
            .Value       = {}
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(0, 0, 0)
            .Format      = "K"
            .MaxLength   = 10
            .SpecialEffect = 1
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DtFinal, "KeyPress", THIS, "TeclaDataFinal")

        *-- Moeda
        loc_oPagina.AddObject("lbl_4c_Moeda", "Label")
        WITH loc_oPagina.lbl_4c_Moeda
            .Top       = 32
            .Left      = 219
            .Width     = 42
            .Height    = 18
            .Caption   = "Moeda :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_CdMoeda", "TextBox")
        WITH loc_oPagina.txt_4c_CdMoeda
            .Top           = 28
            .Left          = 264
            .Width         = 31
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .Format        = "K!"
            .MaxLength     = 3
            .SpecialEffect = 1
            .BorderStyle   = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_CdMoeda, "KeyPress", THIS, "TeclaCdMoeda")
        BINDEVENT(loc_oPagina.txt_4c_CdMoeda, "KeyPress", THIS, "ValidarCdMoeda")

        loc_oPagina.AddObject("txt_4c_DsMoeda", "TextBox")
        WITH loc_oPagina.txt_4c_DsMoeda
            .Top           = 28
            .Left          = 297
            .Width         = 115
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .Format        = "K!"
            .MaxLength     = 15
            .SpecialEffect = 1
            .BorderStyle   = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DsMoeda, "KeyPress", THIS, "TeclaDsMoeda")
        BINDEVENT(loc_oPagina.txt_4c_DsMoeda, "KeyPress", THIS, "ValidarDsMoeda")

        *-- Vendedor
        loc_oPagina.AddObject("lbl_4c_Vendedor", "Label")
        WITH loc_oPagina.lbl_4c_Vendedor
            .Top       = 56
            .Left      = 205
            .Width     = 56
            .Height    = 18
            .Caption   = "Vendedor :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Vendedor", "TextBox")
        WITH loc_oPagina.txt_4c_Vendedor
            .Top           = 53
            .Left          = 264
            .Width         = 80
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .InputMask     = "!!!!!!!!!!"
            .SpecialEffect = 1
            .BorderStyle   = 1
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Vendedor, "KeyPress",  THIS, "TeclaVendedor")
        BINDEVENT(loc_oPagina.txt_4c_Vendedor, "KeyPress", THIS, "ValidarVendedor")

        *-- Opcao (titulos dinamicos de SigCdPac)
        loc_oPagina.AddObject("lbl_4c_Opcao", "Label")
        WITH loc_oPagina.lbl_4c_Opcao
            .Top       = 84
            .Left      = 220
            .Width     = 40
            .Height    = 18
            .Caption   = "Op" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("opt_4c_NrOpcao", "OptionGroup")
        WITH loc_oPagina.opt_4c_NrOpcao
            .Top         = 80
            .Left        = 259
            .Width       = 220
            .Height      = 23
            .ButtonCount = 3
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 3
            .Visible     = .T.

            WITH .Buttons(1)
                .Caption   = "Sim"
                .Top       = 4
                .Left      = 5
                .Width     = 34
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Top       = 4
                .Left      = 82
                .Width     = 37
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(3)
                .Caption   = "Ambos"
                .Top       = 4
                .Left      = 157
                .Width     = 50
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Tipo (Analitico/Sintetico/Resumo/Analise Medias)
        loc_oPagina.AddObject("lbl_4c_Tipo", "Label")
        WITH loc_oPagina.lbl_4c_Tipo
            .Top       = 107
            .Left      = 231
            .Width     = 25
            .Height    = 18
            .Caption   = "Tipo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("opt_4c_Tipo", "OptionGroup")
        WITH loc_oPagina.opt_4c_Tipo
            .Top         = 103
            .Left        = 259
            .Width       = 356
            .Height      = 23
            .ButtonCount = 4
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.

            WITH .Buttons(1)
                .Caption   = "Anal" + CHR(237) + "tico"
                .Top       = 4
                .Left      = 5
                .Width     = 67
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "Sint" + CHR(233) + "tico"
                .Top       = 4
                .Left      = 82
                .Width     = 68
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Verdana"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(3)
                .Caption   = "Resumo"
                .Top       = 4
                .Left      = 157
                .Width     = 65
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Verdana"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(4)
                .Caption   = "An" + CHR(225) + "lise M" + CHR(233) + "dias"
                .Top       = 3
                .Left      = 234
                .Width     = 103
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Verdana"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH
        BINDEVENT(loc_oPagina.opt_4c_Tipo, "Click", THIS, "ClickOptTipo")

        *-- Quebra (Datas / Datas+Operacoes)
        loc_oPagina.AddObject("lbl_4c_Quebra", "Label")
        WITH loc_oPagina.lbl_4c_Quebra
            .Top       = 130
            .Left      = 215
            .Width     = 42
            .Height    = 18
            .Caption   = "Quebra :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("opt_4c_Quebras", "OptionGroup")
        WITH loc_oPagina.opt_4c_Quebras
            .Top         = 126
            .Left        = 259
            .Width       = 220
            .Height      = 23
            .ButtonCount = 2
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.

            WITH .Buttons(1)
                .Caption   = "Datas"
                .Top       = 4
                .Left      = 5
                .Width     = 46
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "Datas + Opera" + CHR(231) + CHR(245) + "es"
                .Top       = 4
                .Left      = 82
                .Width     = 112
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Valor Base (Itens / Movimentacao / Movimentacao S/ST)
        loc_oPagina.AddObject("lbl_4c_Base", "Label")
        WITH loc_oPagina.lbl_4c_Base
            .Top       = 152
            .Left      = 201
            .Width     = 56
            .Height    = 18
            .Caption   = "Valor Base :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("opt_4c_Base", "OptionGroup")
        WITH loc_oPagina.opt_4c_Base
            .Top         = 148
            .Left        = 259
            .Width       = 364
            .Height      = 23
            .ButtonCount = 3
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.

            WITH .Buttons(1)
                .Caption   = "Itens"
                .Top       = 4
                .Left      = 5
                .Width     = 43
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
                .Top       = 4
                .Left      = 82
                .Width     = 87
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(3)
                .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o S/ST"
                .Top       = 3
                .Left      = 198
                .Width     = 139
                .Height    = 17
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Ordens (so visivel quando Tipo=4; hidden por padrao)
        loc_oPagina.AddObject("lbl_4c_Ordem", "Label")
        WITH loc_oPagina.lbl_4c_Ordem
            .Top       = 172
            .Left      = 216
            .Width     = 40
            .Height    = 18
            .Caption   = "Ordens :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .F.
        ENDWITH

        loc_oPagina.AddObject("opt_4c_Ordem", "OptionGroup")
        WITH loc_oPagina.opt_4c_Ordem
            .Top         = 173
            .Left        = 260
            .Width       = 292
            .Height      = 37
            .ButtonCount = 6
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Enabled     = .F.
            .Visible     = .F.

            WITH .Buttons(1)
                .Caption   = "Vendedor"
                .Top       = 1
                .Left      = 4
                .Width     = 64
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "Qtde Pe" + CHR(231) + "as"
                .Top       = 1
                .Left      = 100
                .Width     = 73
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(3)
                .Caption   = "M" + CHR(233) + "dia Pe" + CHR(231) + "as"
                .Top       = 1
                .Left      = 196
                .Width     = 77
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(4)
                .Caption   = "Qtde Opers"
                .Top       = 17
                .Left      = 4
                .Width     = 83
                .Height    = 17
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(5)
                .Caption   = "M" + CHR(233) + "dia Opers"
                .Top       = 17
                .Left      = 100
                .Width     = 83
                .Height    = 17
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(6)
                .Caption   = "Comiss" + CHR(227) + "o"
                .Top       = 17
                .Left      = 196
                .Width     = 83
                .Height    = 17
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Nao utilizado em form REPORT (sem Page2 de edicao)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarOpcoes - Carrega captions dinamicos de SigCdPac e acesso
    *   Chamado apos LimparCampos para sobrescrever os defaults do opt_4c_NrOpcao
    *--------------------------------------------------------------------------
    PROCEDURE InicializarOpcoes()
        LOCAL loc_oPagina, loc_oErro

        TRY
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                THIS.this_oRelatorio.CarregarCaptionsOpcao()
            ENDIF

            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            IF VARTYPE(THIS.this_oRelatorio) = "O"
                WITH loc_oPagina.opt_4c_NrOpcao
                    IF !EMPTY(THIS.this_oRelatorio.this_cTitOpcS)
                        .Buttons(1).Caption = THIS.this_oRelatorio.this_cTitOpcS
                    ENDIF
                    IF !EMPTY(THIS.this_oRelatorio.this_cTitOpcN)
                        .Buttons(2).Caption = THIS.this_oRelatorio.this_cTitOpcN
                    ENDIF
                    IF !EMPTY(THIS.this_oRelatorio.this_cTitOpcA)
                        .Buttons(3).Caption = THIS.this_oRelatorio.this_cTitOpcA
                    ENDIF
                ENDWITH
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "InicializarOpcoes")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Inicializa filtros com valores padrao
    *   Moeda padrao: R (Real) com descricao buscada do banco
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPagina, loc_cDsReal, loc_oErro

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_cDsReal = ""

            IF VARTYPE(THIS.this_oRelatorio) = "O"
                loc_cDsReal = THIS.this_oRelatorio.CarregarMoedaPadrao("R")
            ENDIF

            WITH loc_oPagina
                .txt_4c_DtInicial.Value  = DATE()
                .txt_4c_DtFinal.Value    = DATE()
                .txt_4c_CdMoeda.Value    = "R"
                .txt_4c_DsMoeda.Value    = loc_cDsReal
                .txt_4c_Vendedor.Value   = ""
                .txt_4c_Vendedor.Enabled = .T.
                .opt_4c_NrOpcao.Value    = 3
                .opt_4c_Tipo.Value       = 1
                .opt_4c_Quebras.Value    = 1
                .opt_4c_Base.Value       = 1
                .opt_4c_Ordem.Value      = 1
                .lbl_4c_Ordem.Visible    = .F.
                .opt_4c_Ordem.Visible    = .F.
                .opt_4c_Ordem.Enabled    = .F.
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Ativa a pagina informada (forms REPORT tem so Page1)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina, loc_oErro, loc_oPagina
        TRY
            loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)
            IF loc_nPagina < 1 OR loc_nPagina > THIS.pgf_4c_Paginas.PageCount
                loc_nPagina = 1
            ENDIF
            THIS.pgf_4c_Paginas.ActivePage = loc_nPagina
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            IF PEMSTATUS(loc_oPagina, "txt_4c_DtInicial", 5)
                loc_oPagina.txt_4c_DtInicial.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Alternar P" + CHR(225) + "gina")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Copia valores do form para o BO antes de processar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            .this_dDtInicial = loc_oPagina.txt_4c_DtInicial.Value
            .this_dDtFinal   = loc_oPagina.txt_4c_DtFinal.Value
            .this_cCdMoeda   = ALLTRIM(loc_oPagina.txt_4c_CdMoeda.Value)
            .this_cDsMoeda   = ALLTRIM(loc_oPagina.txt_4c_DsMoeda.Value)
            .this_cVendedor  = ALLTRIM(loc_oPagina.txt_4c_Vendedor.Value)
            .this_nNrOpcao   = loc_oPagina.opt_4c_NrOpcao.Value
            .this_nTipo      = loc_oPagina.opt_4c_Tipo.Value
            .this_nQuebra    = loc_oPagina.opt_4c_Quebras.Value
            .this_nBase      = loc_oPagina.opt_4c_Base.Value
            .this_nOrdem     = loc_oPagina.opt_4c_Ordem.Value
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Preview do relatorio na tela
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro, loc_lContinuar
        loc_lContinuar = .T.
        TRY
            IF EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c_DtInicial.Value) OR ;
               EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c_DtFinal.Value)
                MsgAviso("Informe o per" + CHR(237) + "odo.", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                loc_lContinuar = .F.
            ENDIF
            IF loc_lContinuar
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.Visualizar()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                            "Erro ao Visualizar")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Imprime relatorio com dialogo de impressora
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        LOCAL loc_oErro, loc_lContinuar
        loc_lContinuar = .T.
        TRY
            IF EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c_DtInicial.Value) OR ;
               EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c_DtFinal.Value)
                MsgAviso("Informe o per" + CHR(237) + "odo.", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                loc_lContinuar = .F.
            ENDIF
            IF loc_lContinuar
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.Imprimir()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                            "Erro ao Imprimir")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnGerarExcelClick - Doc. Excel (impressao direta sem dialogo)
    *   SIGRECOM nao tem export Excel no legado; acao mapeada para impressao
    *--------------------------------------------------------------------------
    PROCEDURE BtnGerarExcelClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * ClickOptTipo - Mostra/oculta optOrdem conforme selecao de Tipo
    *   Tipo=4 (Analise Medias): exibe ordem; opcao Base "Itens" proibida
    *--------------------------------------------------------------------------
    PROCEDURE ClickOptTipo()
        LOCAL loc_oPagina, loc_oErro

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            IF loc_oPagina.opt_4c_Tipo.Value = 4
                loc_oPagina.lbl_4c_Ordem.Visible = .T.
                loc_oPagina.opt_4c_Ordem.Visible = .T.
                loc_oPagina.opt_4c_Ordem.Enabled = .T.
                IF loc_oPagina.opt_4c_Base.Value = 1
                    loc_oPagina.opt_4c_Base.Value = 2
                ENDIF
            ELSE
                loc_oPagina.lbl_4c_Ordem.Visible = .F.
                loc_oPagina.opt_4c_Ordem.Visible = .F.
                loc_oPagina.opt_4c_Ordem.Enabled = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ClickOptTipo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDataInicial / TeclaDataFinal - KeyPress em campos de data
    *   Campos de data nao precisam de lookup
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDataInicial(par_nKeyCode, par_nShiftAltCtrl)
    ENDPROC

    PROCEDURE TeclaDataFinal(par_nKeyCode, par_nShiftAltCtrl)
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaCdMoeda - KeyPress em txt_4c_CdMoeda
    *   F4(115)/F5(116): abre lookup de moeda por codigo
    *   ENTER(13)/TAB(9): valida codigo digitado
    *--------------------------------------------------------------------------
    PROCEDURE TeclaCdMoeda(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaMoeda("cmoes")
        ENDIF
        IF INLIST(par_nKeyCode, 13, 9)
            THIS.ValidarCdMoeda()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDsMoeda - KeyPress em txt_4c_DsMoeda
    *   ENTER(13)/TAB(9): abre lookup de moeda por descricao
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDsMoeda(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 9)
            THIS.ValidarDsMoeda()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaVendedor - KeyPress em txt_4c_Vendedor
    *   F4(115)/F5(116): abre lookup de vendedor
    *   ESC(27) com campo vazio: fecha o formulario (comportamento original)
    *--------------------------------------------------------------------------
    PROCEDURE TeclaVendedor(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaVendedor()
        ENDIF
        IF par_nKeyCode = 27 AND ;
           EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c_Vendedor.Value)
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCdMoeda - Busca moeda pelo codigo e preenche descricao (LostFocus)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCdMoeda(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oErro
        loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CdMoeda.Value)

        TRY
            IF EMPTY(loc_cValor)
                THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value = ""
            ELSE
                loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe " + ;
                           "WHERE cmoes = " + EscaparSQL(PADR(loc_cValor, 3))
                IF USED("cursor_4c_MoeVal")
                    USE IN cursor_4c_MoeVal
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeVal")
                IF loc_nResult > 0 AND !EOF("cursor_4c_MoeVal")
                    SELECT cursor_4c_MoeVal
                    THIS.pgf_4c_Paginas.Page1.txt_4c_CdMoeda.Value = ;
                        ALLTRIM(cursor_4c_MoeVal.cmoes)
                    THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value = ;
                        ALLTRIM(cursor_4c_MoeVal.dmoes)
                ELSE
                    THIS.pgf_4c_Paginas.Page1.txt_4c_CdMoeda.Value = ""
                    THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value = ""
                    THIS.AbrirBuscaMoeda("cmoes")
                ENDIF
                IF USED("cursor_4c_MoeVal")
                    USE IN cursor_4c_MoeVal
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarCdMoeda")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDsMoeda - Busca moeda pela descricao e preenche codigo (LostFocus)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDsMoeda(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor, loc_oErro
        loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value)

        TRY
            IF EMPTY(loc_cValor)
                THIS.pgf_4c_Paginas.Page1.txt_4c_CdMoeda.Value = ""
                THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value = ""
            ELSE
                THIS.AbrirBuscaMoeda("dmoes")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarDsMoeda")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarVendedor - Valida codigo de vendedor contra SigCdUsu (LostFocus)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarVendedor(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oErro, loc_lEncontrou
        loc_cValor    = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Vendedor.Value)
        loc_lEncontrou = .F.

        TRY
            IF !EMPTY(loc_cValor)
                loc_cSQL = "SELECT a.usuarios, a.NComps FROM SigCdUsu a " + ;
                           "WHERE NOT a.cAtivos = 'N' " + ;
                           "AND NOT a.Senhas = '" + SPACE(6) + "'"
                IF USED("cursor_4c_UsuVal")
                    USE IN cursor_4c_UsuVal
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UsuVal")
                IF loc_nResult > 0
                    SELECT cursor_4c_UsuVal
                    LOCATE FOR ALLTRIM(cursor_4c_UsuVal.usuarios) == ALLTRIM(loc_cValor)
                    IF !EOF("cursor_4c_UsuVal")
                        THIS.pgf_4c_Paginas.Page1.txt_4c_Vendedor.Value = ;
                            ALLTRIM(cursor_4c_UsuVal.usuarios)
                        loc_lEncontrou = .T.
                    ENDIF
                ENDIF
                IF USED("cursor_4c_UsuVal")
                    USE IN cursor_4c_UsuVal
                ENDIF
                IF !loc_lEncontrou
                    THIS.pgf_4c_Paginas.Page1.txt_4c_Vendedor.Value = ""
                    THIS.AbrirBuscaVendedor()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarVendedor")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaMoeda - Abre FormBuscaAuxiliar para selecao de moeda
    *   par_cCampoBusca: "cmoes" (busca por codigo) ou "dmoes" (por descricao)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaMoeda(par_cCampoBusca)
        LOCAL loc_oBusca, loc_oErro, loc_cCampo, loc_cValor, loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        TRY
            loc_cCampo = IIF(LOWER(ALLTRIM(par_cCampoBusca)) = "dmoes", "dmoes", "cmoes")
            IF loc_cCampo = "cmoes"
                loc_cValor = ALLTRIM(loc_oPagina.txt_4c_CdMoeda.Value)
            ELSE
                loc_cValor = ALLTRIM(loc_oPagina.txt_4c_DsMoeda.Value)
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", ;
                "cursor_4c_BuscaMoe", ;
                loc_cCampo, ;
                loc_cValor, ;
                "Selecionar Moeda")

            IF VARTYPE(loc_oBusca) != "O"
                MsgErro("Erro ao criar janela de busca de Moeda.", "Erro")
            ELSE
                IF loc_cCampo = "cmoes"
                    loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                ELSE
                    loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
                ENDIF
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou
                    IF USED("cursor_4c_BuscaMoe")
                        SELECT cursor_4c_BuscaMoe
                        loc_oPagina.txt_4c_CdMoeda.Value = ALLTRIM(cursor_4c_BuscaMoe.cmoes)
                        loc_oPagina.txt_4c_DsMoeda.Value = ALLTRIM(cursor_4c_BuscaMoe.dmoes)
                    ENDIF
                ELSE
                    IF loc_cCampo = "cmoes"
                        loc_oPagina.txt_4c_CdMoeda.Value = ""
                    ENDIF
                    loc_oPagina.txt_4c_DsMoeda.Value = ""
                ENDIF

                IF USED("cursor_4c_BuscaMoe")
                    USE IN cursor_4c_BuscaMoe
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaMoeda")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaVendedor - Abre FormBuscaAuxiliar para selecao de vendedor
    *   Filtra apenas usuarios ativos (cAtivos <> 'N' e Senhas preenchida)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaVendedor()
        LOCAL loc_oBusca, loc_oErro, loc_cValor, loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_Vendedor.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdUsu", ;
                "cursor_4c_BuscaUsu", ;
                "usuarios", ;
                loc_cValor, ;
                "Selecionar Vendedor")

            IF VARTYPE(loc_oBusca) != "O"
                MsgErro("Erro ao criar janela de busca de Vendedor.", "Erro")
            ELSE
                loc_oBusca.mAddColuna("usuarios", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("NComps", "", "Nome")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou
                    IF USED("cursor_4c_BuscaUsu")
                        SELECT cursor_4c_BuscaUsu
                        loc_oPagina.txt_4c_Vendedor.Value = ;
                            ALLTRIM(cursor_4c_BuscaUsu.usuarios)
                    ENDIF
                ENDIF

                IF USED("cursor_4c_BuscaUsu")
                    USE IN cursor_4c_BuscaUsu
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaVendedor")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera referencia ao BO
    *   RelatorioBase herda de Custom (sem Release()) - usar .NULL. para liberar
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * Aliases de interface CRUD - exigidos pelo pipeline multi-fase (Fase 8)
    *   Forms REPORT nao possuem Buscar/Encerrar/Salvar como botoes proprios
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    PROCEDURE BtnConsultarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick / BtnAlterarClick / BtnExcluirClick
    *   Forms REPORT nao tem operacoes CRUD; delegam para visualizacao
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnAlterarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnExcluirClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO / BOParaForm - Aliases para a interface generica FormBase
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg, loc_oErro
        TRY
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                loc_oPg = THIS.pgf_4c_Paginas.Page1
                WITH THIS.this_oRelatorio
                    IF !EMPTY(.this_dDtInicial)
                        loc_oPg.txt_4c_DtInicial.Value = .this_dDtInicial
                    ENDIF
                    IF !EMPTY(.this_dDtFinal)
                        loc_oPg.txt_4c_DtFinal.Value = .this_dDtFinal
                    ENDIF
                    IF !EMPTY(.this_cCdMoeda)
                        loc_oPg.txt_4c_CdMoeda.Value = .this_cCdMoeda
                    ENDIF
                    IF !EMPTY(.this_cDsMoeda)
                        loc_oPg.txt_4c_DsMoeda.Value = .this_cDsMoeda
                    ENDIF
                    loc_oPg.txt_4c_Vendedor.Value  = .this_cVendedor
                    loc_oPg.opt_4c_NrOpcao.Value   = .this_nNrOpcao
                    loc_oPg.opt_4c_Tipo.Value       = .this_nTipo
                    loc_oPg.opt_4c_Quebras.Value    = .this_nQuebra
                    loc_oPg.opt_4c_Base.Value       = .this_nBase
                    loc_oPg.opt_4c_Ordem.Value      = .this_nOrdem
                ENDWITH
                THIS.ClickOptTipo()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita os campos de filtro
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg, loc_lHab, loc_oErro
        TRY
            loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
            loc_oPg  = THIS.pgf_4c_Paginas.Page1
            IF VARTYPE(loc_oPg) = "O"
                IF PEMSTATUS(loc_oPg, "txt_4c_DtInicial", 5)
                    loc_oPg.txt_4c_DtInicial.ReadOnly = !loc_lHab
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DtFinal", 5)
                    loc_oPg.txt_4c_DtFinal.ReadOnly = !loc_lHab
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_CdMoeda", 5)
                    loc_oPg.txt_4c_CdMoeda.ReadOnly = !loc_lHab
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DsMoeda", 5)
                    loc_oPg.txt_4c_DsMoeda.ReadOnly = !loc_lHab
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_Vendedor", 5)
                    loc_oPg.txt_4c_Vendedor.Enabled = loc_lHab
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Forms REPORT nao tem grid CRUD
    *   Mantido para compatibilidade com o pipeline (validador de Fase 8)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Em forms REPORT todos os botoes ficam habilitados
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oCmg, loc_oErro, loc_nI
        TRY
            IF VARTYPE(THIS.cnt_4c_Cabecalho) = "O" AND ;
               PEMSTATUS(THIS.cnt_4c_Cabecalho, "cmg_4c_Botoes", 5)
                loc_oCmg = THIS.cnt_4c_Cabecalho.cmg_4c_Botoes
                FOR loc_nI = 1 TO loc_oCmg.ButtonCount
                    loc_oCmg.Buttons(loc_nI).Enabled = .T.
                ENDFOR
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigrecomBO.prg):
*==============================================================================
* SIGRECOMBO.PRG
* Business Object para Relatorio de Comissao
* Herda de: RelatorioBase
*
* Filtros:
*   - Periodo (data inicial / data final)
*   - Moeda (codigo + descricao)
*   - Vendedor
*   - Tipo (Analitico / Sintetico / Resumo / Analise Medias)
*   - Opcao  (Sim / Nao / Ambos - titulos dinamicos de SigCdPac)
*   - Quebra (Datas / Datas + Operacoes)
*   - Valor Base (Itens / Movimentacao / Movimentacao S/ST)
*   - Ordem  (so visivel/usavel quando tipo=4)
*==============================================================================

DEFINE CLASS sigrecomBO AS RelatorioBase

    *-- Propriedades base (RelatorioBase)
    this_cTabela     = "SigMvCab"
    this_cCampoChave = ""

    *--------------------------------------------------------------------------
    * FILTROS DO RELATORIO
    *--------------------------------------------------------------------------

    *-- Periodo
    this_dDtInicial  = {}
    this_dDtFinal    = {}

    *-- Moeda (codigo CHAR(3) + descricao CHAR(15))
    this_cCdMoeda    = ""
    this_cDsMoeda    = ""

    *-- Vendedor (CHAR(10), habilitado conforme fChecaAcesso)
    this_cVendedor   = ""

    *-- Tipo: 1=Analitico 2=Sintetico 3=Resumo 4=Analise Medias
    this_nTipo       = 1

    *-- Opcao: 1=Sim 2=Nao 3=Ambos (titulos dinamicos de SigCdPac)
    this_nNrOpcao    = 3

    *-- Quebra: 1=Datas 2=Datas+Operacoes
    this_nQuebra     = 1

    *-- Valor Base: 1=Itens 2=Movimentacao 3=Movimentacao S/ST
    this_nBase       = 1

    *-- Ordem (so usado quando tipo=4):
    *   1=Vendedor 2=Qtde Pecas 3=Media Pecas
    *   4=Qtde Opers 5=Media Opers 6=Comissao
    this_nOrdem      = 1

    *--------------------------------------------------------------------------
    * CAPTIONS DINAMICOS DAS OPCOES (carregados de SigCdPac em InicializarForm)
    *--------------------------------------------------------------------------
    this_cTitOpcS    = ""
    this_cTitOpcN    = ""
    this_cTitOpcA    = ""

    *--------------------------------------------------------------------------
    * CONTROLE DE ACESSO
    *--------------------------------------------------------------------------
    *-- .T. se o usuario tem permissao para filtrar por vendedor (fChecaAcesso)
    this_lVendedorEnabled = .T.

    *--------------------------------------------------------------------------
    * DADOS DO CABECALHO DO RELATORIO (preenchidos em PrepararDados)
    *--------------------------------------------------------------------------
    this_cNmEmpresa  = ""
    this_cTitulo     = ""

    *--------------------------------------------------------------------------
    * CONTROLE DE VISIBILIDADE
    *--------------------------------------------------------------------------
    *-- say7 e optOrdem ficam ocultos exceto quando this_nTipo = 4
    this_lExibeOrdem   = .F.

    *-- Taxa mensal JM (armazenada para acesso dos helpers de calculo)
    this_lnTaxaMensal  = 0

    *==========================================================================
    * Init - Construtor
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            THIS.this_cTabela     = "SigMvCab"
            THIS.this_cCampoChave = ""

            THIS.this_dDtInicial  = DATE()
            THIS.this_dDtFinal    = DATE()
            THIS.this_cCdMoeda    = "R  "
            THIS.this_cDsMoeda    = ""
            THIS.this_cVendedor   = ""
            THIS.this_nTipo       = 1
            THIS.this_nNrOpcao    = 3
            THIS.this_nQuebra     = 1
            THIS.this_nBase       = 1
            THIS.this_nOrdem      = 1

            *-- Captions padrao (serao sobrescritos com dados de SigCdPac no Form)
            THIS.this_cTitOpcS    = "Sim"
            THIS.this_cTitOpcN    = "N" + CHR(227) + "o"
            THIS.this_cTitOpcA    = "Ambos"

            THIS.this_lVendedorEnabled = .T.
            THIS.this_lExibeOrdem      = .F.
            THIS.this_lnTaxaMensal     = 0

            THIS.this_cNmEmpresa  = ""
            THIS.this_cTitulo     = ""

            loc_lSucesso = DODEFAULT()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * PrepararDados - Processa dados para impressao/visualizacao do relatorio
    * Equivale ao metodo 'processamento' do form legado SIGRECOM
    *==========================================================================
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErr
        LOCAL loc_ldDtI, loc_ldDtF, loc_lcCdMoeda, loc_lcDsMoeda
        LOCAL loc_lnNrOpcao, loc_lnTip, loc_lnBas
        LOCAL loc_lcNmEmpresa, loc_lcNmTitulo
        LOCAL loc_lcJm, loc_lnTm, loc_nResult, loc_cSQL, loc_lcEdn, loc_lnOrdem

        loc_lSucesso = .F.

        *-- Captura filtros das propriedades
        loc_ldDtI     = THIS.this_dDtInicial
        loc_ldDtF     = THIS.this_dDtFinal
        loc_lcCdMoeda = THIS.this_cCdMoeda
        loc_lcDsMoeda = ALLTRIM(THIS.this_cDsMoeda)
        loc_lnNrOpcao = THIS.this_nNrOpcao
        loc_lnTip     = THIS.this_nTipo
        loc_lnBas     = THIS.this_nBase

        *-- Validacoes (fora do TRY - RETURN .F. permitido aqui)
        IF EMPTY(loc_ldDtI) OR EMPTY(loc_ldDtF)
            THIS.this_cMensagemErro = "Informe o per" + CHR(237) + "odo."
            RETURN .F.
        ENDIF
        IF loc_ldDtI > loc_ldDtF
            THIS.this_cMensagemErro = "Data inicial maior que data final."
            RETURN .F.
        ENDIF
        IF !THIS.CarregarCursoresBase()
            RETURN .F.
        ENDIF

        TRY
            *-- Nome da empresa
            loc_lcNmEmpresa = ""
            SELECT crSigCdEmp
            GO TOP
            IF !EOF()
                loc_lcNmEmpresa = ALLTRIM(crSigCdEmp.razas)
            ENDIF

            *-- Titulo do relatorio
            loc_lcNmTitulo = "Comiss" + CHR(227) + "o em " + ;
                             PROPER(loc_lcDsMoeda) + ;
                             " de " + DTOC(loc_ldDtI) + ;
                             " " + CHR(224) + " " + DTOC(loc_ldDtF) + " - " + ;
                             IIF(loc_lnTip = 1, "Anal" + CHR(237) + "tico", ;
                                 IIF(loc_lnTip = 2, "Sint" + CHR(233) + "tico", ;
                                     IIF(loc_lnTip = 3, "Resumido", ;
                                         "An" + CHR(225) + "lise de M" + CHR(233) + "dias"))) + ;
                             " - " + ;
                             IIF(loc_lnBas = 1, "Base Itens", ;
                                 "Base Movimenta" + CHR(231) + CHR(227) + "o")

            *-- Cursor dbcabecalho (referenciado pelos FRX)
            IF USED("dbcabecalho")
                USE IN dbcabecalho
            ENDIF
            CREATE CURSOR dbcabecalho (NomeEmpresa c(80), Titulo c(80))
            INSERT INTO dbcabecalho (NomeEmpresa, Titulo) VALUES (loc_lcNmEmpresa, loc_lcNmTitulo)
            THIS.this_cNmEmpresa = loc_lcNmEmpresa
            THIS.this_cTitulo    = loc_lcNmTitulo

            *-- Taxa mensal JM para calculo de valor a vista
            loc_lcJm = "JM "
            loc_lnTm = THIS.BuscarCambio({}, loc_ldDtF, SPACE(3), loc_lcJm)
            THIS.this_lnTaxaMensal = loc_lnTm

            *-- Cursor Parcela (schema de SigMvPar + colunas de acumulacao)
            IF USED("Parcela")
                USE IN Parcela
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 0 a.cotfpgs, a.Empdopnums, a.dopes, " + ;
                "a.fpags, a.moefpgs, a.valos, a.datas, a.vencs, " + ;
                "CAST(a.valos AS DECIMAL(14,4)) AS ValoAvs, " + ;
                "CAST(a.valos AS DECIMAL(14,4)) AS Devols, " + ;
                "CAST('' AS VARCHAR(6)) AS Tipo " + ;
                "FROM SigMvPar a WHERE 1=0", "Parcela")
            IF loc_nResult < 1
                CREATE CURSOR Parcela ;
                    (cotfpgs n(14,4), Empdopnums c(29), dopes c(20), ;
                     fpags c(6), moefpgs c(3), valos n(14,4), ;
                     datas d, vencs d, ValoAvs n(14,4), Devols n(14,4), Tipo c(6))
            ENDIF
            SELECT Parcela
            INDEX ON Tipo + fpags TAG Tipo
            INDEX ON fpags TAG fpags

            *-- Cursor crAnalitico (acumulador de comissoes por vendedor)
            IF USED("crAnalitico")
                USE IN crAnalitico
            ENDIF
            CREATE CURSOR crAnalitico ;
                (Vends c(10), NVends c(50), Comis n(9,4), Valos n(12,4), ;
                 Datas d, EmpDopNums c(29), ContaDs c(10), RClis c(40), ;
                 Notas c(6), Dopes c(20))
            DO CASE
                CASE (loc_lnTip = 1 OR loc_lnTip = 4)
                    INDEX ON Vends + DTOS(Datas) + EmpDopNums TAG VendDatas
                CASE (loc_lnTip = 2)
                    INDEX ON Vends TAG VendDatas
                OTHERWISE
                    INDEX ON Vends + DTOS(Datas) + Dopes TAG VendDatas
            ENDCASE

            *== LOOP 1: Operacoes de venda (vendas=1) ==
            SELECT crSigCdOpe
            SET ORDER TO ordes
            GO TOP
            SCAN FOR crSigCdOpe.vendas = 1 AND crSigCdOpe.calcfecs <> 1
                THIS.SelecionaEest()
                SELECT crSigMvCab
                SCAN
                    IF (loc_lnNrOpcao = 1 AND EMPTY(crSigMvCab.notas)) OR ;
                       (loc_lnNrOpcao = 2 AND !EMPTY(crSigMvCab.notas))
                        LOOP
                    ENDIF
                    IF loc_lnBas = 1
                        THIS.CalcBase(1)
                    ELSE
                        THIS.SelecionaPar(1)
                    ENDIF
                    SELECT crSigMvCab
                ENDSCAN
                SELECT crSigCdOpe
            ENDSCAN

            *== LOOP 2: Caixas entrada (caixas=1, copers=1, nao-venda) ==
            SELECT crSigCdOpe
            SET ORDER TO ordes
            GO TOP
            SCAN FOR crSigCdOpe.caixas = 1 AND crSigCdOpe.copers = 1 AND ;
                     crSigCdOpe.vendas <> 1 AND crSigCdOpe.calcfecs <> 1
                THIS.SelecionaEest()
                SELECT crSigMvCab
                SCAN
                    IF (loc_lnNrOpcao = 1 AND EMPTY(crSigMvCab.notas)) OR ;
                       (loc_lnNrOpcao = 2 AND !EMPTY(crSigMvCab.notas))
                        LOOP
                    ENDIF
                    IF loc_lnBas = 1
                        THIS.CalcBase(1)
                    ELSE
                        THIS.SelecionaPar(1)
                    ENDIF
                    SELECT crSigMvCab
                ENDSCAN
                SELECT crSigCdOpe
            ENDSCAN

            *== LOOP 3: Caixas saidas (caixas=1, copers=2, nao-venda, subtrair) ==
            SELECT crSigCdOpe
            SET ORDER TO ordes
            GO TOP
            SCAN FOR crSigCdOpe.caixas = 1 AND crSigCdOpe.copers = 2 AND ;
                     crSigCdOpe.vendas <> 1 AND crSigCdOpe.calcfecs <> 1
                THIS.SelecionaEest()
                SELECT crSigMvCab
                SCAN
                    IF (loc_lnNrOpcao = 1 AND EMPTY(crSigMvCab.notas)) OR ;
                       (loc_lnNrOpcao = 2 AND !EMPTY(crSigMvCab.notas))
                        LOOP
                    ENDIF
                    IF loc_lnBas = 1
                        THIS.CalcBase(-1)
                    ELSE
                        THIS.SelecionaPar(-1)
                    ENDIF
                    SELECT crSigMvCab
                ENDSCAN
                SELECT crSigCdOpe
            ENDSCAN

            *== LOOP 4: calcfecs saidas (copers=2, calcfecs=1, subtrair) ==
            SELECT crSigCdOpe
            SET ORDER TO ordes
            GO TOP
            SCAN FOR crSigCdOpe.copers = 2 AND crSigCdOpe.calcfecs = 1
                THIS.SelecionaEest()
                SELECT crSigMvCab
                SCAN
                    IF (loc_lnNrOpcao = 1 AND EMPTY(crSigMvCab.notas)) OR ;
                       (loc_lnNrOpcao = 2 AND !EMPTY(crSigMvCab.notas))
                        LOOP
                    ENDIF
                    IF loc_lnBas = 1
                        THIS.CalcBase(-1)
                    ELSE
                        THIS.SelecionaPar(-1)
                    ENDIF
                    SELECT crSigMvCab
                ENDSCAN
                SELECT crSigCdOpe
            ENDSCAN

            *== POS-PROCESSAMENTO: Tipo=1 - Substitui EmpDopNums pela NF ==
            IF loc_lnTip = 1
                SELECT crAnalitico
                SET ORDER TO
                SCAN
                    IF USED("LocalSub")
                        USE IN LocalSub
                    ENDIF
                    loc_cSQL = ;
                        "SELECT a.EmpDopNums, a.Codigos, a.Emps, " + ;
                        "o.Dopes, RIGHT(a.Codigos, 6) AS Numes " + ;
                        "FROM SigMvPec a, SigMvCab b, SigCdOpe o " + ;
                        "WHERE a.EmpDopNums = b.EmpDopNums " + ;
                        "AND LEFT(a.Codigos, 3) = o.NDopes " + ;
                        "AND a.EmpDopNums = '" + ALLTRIM(crAnalitico.EmpDopNums) + "' " + ;
                        "AND a.EmpDopNums NOT IN (" + ;
                        "SELECT n.EmpDopNums FROM SigMvNfi n " + ;
                        "WHERE n.EmpDopNums = '" + ALLTRIM(crAnalitico.EmpDopNums) + "')"
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "LocalSub") >= 1
                        SELECT LocalSub
                        GO TOP IN LocalSub
                        IF !EOF("LocalSub")
                            loc_lcEdn = ALLTRIM(LocalSub.Emps) + ;
                                        ALLTRIM(LocalSub.Dopes) + ;
                                        STR(INT(VAL(ALLTRIM(LocalSub.Numes))), 6)
                            IF USED("LocalNF")
                                USE IN LocalNF
                            ENDIF
                            loc_cSQL = ;
                                "SELECT b.NFis, b.EmpDopNums " + ;
                                "FROM SigMvNfi b " + ;
                                "WHERE b.EmpDopNums = " + EscaparSQL(loc_lcEdn)
                            IF SQLEXEC(gnConnHandle, loc_cSQL, "LocalNF") >= 1
                                SELECT LocalNF
                                GO TOP IN LocalNF
                                IF !EOF("LocalNF")
                                    REPLACE EmpDopNums WITH LocalNF.EmpDopNums, ;
                                            Notas      WITH LocalNF.NFis ;
                                            IN crAnalitico
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                    SELECT crAnalitico
                ENDSCAN
            ENDIF

            *== POS-PROCESSAMENTO: Tipo=4 - Analise de Medias ==
            IF loc_lnTip = 4
                loc_lnOrdem = THIS.this_nOrdem

                IF USED("crMedia")
                    USE IN crMedia
                ENDIF
                SELECT *, 0.000 AS qtds FROM crAnalitico INTO CURSOR crMedia READWRITE
                SELECT crMedia
                SET ORDER TO
                SCAN
                    IF USED("LocalItn")
                        USE IN LocalItn
                    ENDIF
                    loc_cSQL = "SELECT SUM(qtds) AS Qtds FROM SigMvItn " + ;
                               "WHERE EmpDopNums = '" + ;
                               ALLTRIM(crMedia.EmpDopNums) + "' " + ;
                               "GROUP BY EmpDopNums"
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "LocalItn") >= 1
                        SELECT LocalItn
                        GO TOP IN LocalItn
                        IF !EOF("LocalItn")
                            REPLACE Qtds WITH LocalItn.Qtds IN crMedia
                        ENDIF
                    ENDIF
                    SELECT crMedia
                ENDSCAN

                *-- Agrupar por vendedor
                IF USED("cursor_4c_MedAgr")
                    USE IN cursor_4c_MedAgr
                ENDIF
                SELECT Vends, SUM(valos) AS valos, ;
                       COUNT(EmpDopNums) AS Vendas, ;
                       SUM(Qtds) AS Qtds, SUM(comis) AS comis ;
                       FROM crMedia ;
                       GROUP BY Vends ;
                       INTO CURSOR cursor_4c_MedAgr READWRITE

                *-- Calcular medias e ordenar pela opcao escolhida (coluna numerica)
                IF USED("crMedia")
                    USE IN crMedia
                ENDIF
                DO CASE
                    CASE loc_lnOrdem = 1
                        SELECT Vends, Qtds, ;
                               IIF(Qtds = 0, 0.0, valos / Qtds) AS MediaPecas, ;
                               Vendas, ;
                               IIF(Vendas = 0, 0.0, valos / Vendas) AS MediaOpers, ;
                               comis, valos ;
                               FROM cursor_4c_MedAgr ORDER BY 1 ;
                               INTO CURSOR crMedia READWRITE
                    CASE loc_lnOrdem = 2
                        SELECT Vends, Qtds, ;
                               IIF(Qtds = 0, 0.0, valos / Qtds) AS MediaPecas, ;
                               Vendas, ;
                               IIF(Vendas = 0, 0.0, valos / Vendas) AS MediaOpers, ;
                               comis, valos ;
                               FROM cursor_4c_MedAgr ORDER BY 2 ;
                               INTO CURSOR crMedia READWRITE
                    CASE loc_lnOrdem = 3
                        SELECT Vends, Qtds, ;
                               IIF(Qtds = 0, 0.0, valos / Qtds) AS MediaPecas, ;
                               Vendas, ;
                               IIF(Vendas = 0, 0.0, valos / Vendas) AS MediaOpers, ;
                               comis, valos ;
                               FROM cursor_4c_MedAgr ORDER BY 3 ;
                               INTO CURSOR crMedia READWRITE
                    CASE loc_lnOrdem = 4
                        SELECT Vends, Qtds, ;
                               IIF(Qtds = 0, 0.0, valos / Qtds) AS MediaPecas, ;
                               Vendas, ;
                               IIF(Vendas = 0, 0.0, valos / Vendas) AS MediaOpers, ;
                               comis, valos ;
                               FROM cursor_4c_MedAgr ORDER BY 4 ;
                               INTO CURSOR crMedia READWRITE
                    CASE loc_lnOrdem = 5
                        SELECT Vends, Qtds, ;
                               IIF(Qtds = 0, 0.0, valos / Qtds) AS MediaPecas, ;
                               Vendas, ;
                               IIF(Vendas = 0, 0.0, valos / Vendas) AS MediaOpers, ;
                               comis, valos ;
                               FROM cursor_4c_MedAgr ORDER BY 5 ;
                               INTO CURSOR crMedia READWRITE
                    OTHERWISE
                        SELECT Vends, Qtds, ;
                               IIF(Qtds = 0, 0.0, valos / Qtds) AS MediaPecas, ;
                               Vendas, ;
                               IIF(Vendas = 0, 0.0, valos / Vendas) AS MediaOpers, ;
                               comis, valos ;
                               FROM cursor_4c_MedAgr ORDER BY 6 ;
                               INTO CURSOR crMedia READWRITE
                ENDCASE

                IF USED("cursor_4c_MedAgr")
                    USE IN cursor_4c_MedAgr
                ENDIF
                SELECT crMedia
                GO TOP

            ELSE
                SELECT crAnalitico
                SET ORDER TO VendDatas
                GO TOP IN crAnalitico
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            MsgErro(loc_oErr.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * SelecionaEest - Seleciona SigMvCab para a operacao atual (crSigCdOpe)
    * Equivale ao metodo 'selecionaeest' do form legado SIGRECOM
    *==========================================================================
    PROCEDURE SelecionaEest()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_lcVend

        loc_lSucesso = .F.
        loc_lcVend   = ALLTRIM(THIS.this_cVendedor)

        loc_cSQL = ;
            "SELECT Emps, Dopes, Datas, Numes, Notas, Valos, " + ;
            "GrVends, Vends, EmpDopNums, ContaDs " + ;
            "FROM SigMvCab " + ;
            "WHERE EmpDopNums BETWEEN '" + ;
            go_4c_Sistema.cCodEmpresa + crSigCdOpe.Dopes + STR(0, 6) + ;
            "' AND '" + ;
            go_4c_Sistema.cCodEmpresa + crSigCdOpe.Dopes + STR(999999, 6) + "' " + ;
            "AND Datas BETWEEN " + FormatarDataSQL(THIS.this_dDtInicial) + ;
            " AND " + FormatarDataSQL(THIS.this_dDtFinal) + ;
            IIF(EMPTY(loc_lcVend), "", " AND Vends = " + EscaparSQL(loc_lcVend)) + ;
            " ORDER BY Emps, Dopes, Datas, Numes, Notas, " + ;
            "Valos, GrVends, Vends, EmpDopNums, ContaDs"

        IF USED("crSigMvCab")
            USE IN crSigMvCab
        ENDIF

        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigMvCab")
        IF loc_nResult < 1
            MsgErro("Falha na Conex" + CHR(227) + "o (crSigMvCab)", "Erro")
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * CalcBase - Calcula comissao com base nos itens de venda (Base = Itens)
    * Equivale ao metodo 'calcbase' do form legado SIGRECOM
    * par_nMlt: +1 (entrada) ou -1 (saida/devolucao)
    *==========================================================================
    PROCEDURE CalcBase(par_nMlt)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_lcMoe, loc_lnTip, loc_lcDop
        LOCAL loc_lcNvends, loc_lnComFPag, loc_lnCot, loc_lnComi
        LOCAL loc_lnCotMoeV, loc_lnCotMoePag, loc_lcCta, loc_lcEdn

        loc_lSucesso = .T.
        loc_lcMoe    = THIS.this_cCdMoeda
        loc_lnTip    = THIS.this_nTipo

        IF crSigCdOpe.CComis <> 1
            RETURN .T.
        ENDIF

        *-- Totais de itens por moeda, excluindo servicos
        loc_cSQL = ;
            "SELECT a.MoeVs, SUM(a.Totas + a.ValRats) AS Valos " + ;
            "FROM SigMvItn a, SigCdPro b, SigCdGrp c " + ;
            "WHERE a.EmpDopNums = '" + ALLTRIM(crSigMvCab.EmpDopNums) + "' " + ;
            "AND a.CPros = b.CPros " + ;
            "AND b.CGrus = c.CGrus " + ;
            "GROUP BY a.MoeVs " + ;
            "ORDER BY a.MoeVs"

        IF USED("LocalItens")
            USE IN LocalItens
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "LocalItens")
        IF loc_nResult < 1
            MsgErro("Falha na Conex" + CHR(227) + "o (LocalItens)", "Erro")
            RETURN .F.
        ENDIF

        SELECT LocalItens
        SCAN
            *-- Verifica/recarrega dados do vendedor (cache por IClis+Grupos)
            IF !USED("crSigCdCli") OR ;
               (USED("crSigCdCli") AND ;
                (crSigCdCli.IClis + crSigCdCli.Grupos <> ;
                 PADR(crSigMvCab.Vends, 10) + PADR(crSigMvCab.Grvends, 10)))

                loc_cSQL = ;
                    "SELECT Grupos, IClis, RClis, Comis, CCargs " + ;
                    "FROM SigCdCli " + ;
                    "WHERE IClis = '" + PADR(crSigMvCab.Vends, 10) + "' " + ;
                    "AND Grupos = '" + PADR(crSigMvCab.Grvends, 10) + "' " + ;
                    "ORDER BY Grupos, IClis, RClis, Comis, CCargs"

                IF USED("crSigCdCli")
                    USE IN crSigCdCli
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdCli")
                IF loc_nResult < 1
                    MsgErro("Falha na Conex" + CHR(227) + "o (crSigCdCli)", "Erro")
                    RETURN .F.
                ENDIF
                GO TOP IN crSigCdCli
            ENDIF

            loc_lcNvends  = ALLTRIM(crSigCdCli.Rclis)
            loc_lnComFPag = crSigCdCli.Comis

            *-- Se usa encargos, substitui comissao pela tabela de encargos
            IF crSigCdOpe.ComCargs = 1
                SELECT crSigCdCrg
                SEEK crSigCdCli.CCargs
                IF !EOF()
                    loc_lnComFPag = crSigCdCrg.Comis
                ENDIF
            ENDIF

            *-- Posiciona crAnalitico para o vendedor/data/operacao atual
            SELECT crAnalitico
            SET ORDER TO VendDatas
            loc_lcDop = crSigMvCab.Dopes

            DO CASE
                CASE (loc_lnTip = 1 OR loc_lnTip = 4)
                    SEEK crSigMvCab.Vends + DTOS(crSigMvCab.Datas) + crSigMvCab.EmpDopNums
                CASE (loc_lnTip = 2)
                    SEEK crSigMvCab.Vends
                OTHERWISE
                    *-- Tipo 3: apanha NF do subnivel
                    IF USED("LocalSub")
                        USE IN LocalSub
                    ENDIF
                    loc_cSQL = ;
                        "SELECT a.EmpDopNums, a.Codigos, a.Emps, " + ;
                        "o.Dopes, RIGHT(a.Codigos, 6) AS Numes " + ;
                        "FROM SigMvPec a, SigMvCab b, SigCdOpe o " + ;
                        "WHERE a.EmpDopNums = b.EmpDopNums " + ;
                        "AND LEFT(a.Codigos, 3) = o.NDopes " + ;
                        "AND a.EmpDopNums = '" + ALLTRIM(crSigMvCab.EmpDopNums) + "' " + ;
                        "AND a.EmpDopNums NOT IN (" + ;
                        "SELECT n.EmpDopNums FROM SigMvNfi n " + ;
                        "WHERE n.EmpDopNums = '" + ALLTRIM(crSigMvCab.EmpDopNums) + "')"
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "LocalSub") >= 1
                        SELECT LocalSub
                        GO TOP IN LocalSub
                        IF !EOF("LocalSub")
                            loc_lcEdn = ALLTRIM(LocalSub.Emps) + ;
                                        ALLTRIM(LocalSub.Dopes) + ;
                                        STR(INT(VAL(ALLTRIM(LocalSub.Numes))), 6)
                            IF USED("LocalNF")
                                USE IN LocalNF
                            ENDIF
                            loc_cSQL = ;
                                "SELECT b.NFis, b.EmpDopNums " + ;
                                "FROM SigMvNfi b " + ;
                                "WHERE b.EmpDopNums = " + EscaparSQL(loc_lcEdn)
                            IF SQLEXEC(gnConnHandle, loc_cSQL, "LocalNF") >= 1
                                SELECT LocalNF
                                GO TOP IN LocalNF
                                IF !EOF("LocalNF")
                                    loc_lcDop = LocalSub.Dopes
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                    SELECT crAnalitico
                    SEEK crSigMvCab.Vends + DTOS(crSigMvCab.Datas) + loc_lcDop
            ENDCASE

            *-- Adiciona novo registro se nao encontrado
            IF EOF("crAnalitico")
                APPEND BLANK IN crAnalitico

                IF USED("LocalCli")
                    USE IN LocalCli
                ENDIF
                loc_lcCta = ""
                loc_cSQL = "SELECT RClis FROM SigCdCli " + ;
                           "WHERE IClis = '" + ALLTRIM(crSigMvCab.ContaDs) + "'"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "LocalCli") >= 1
                    SELECT LocalCli
                    GO TOP
                    IF !EOF("LocalCli")
                        loc_lcCta = ALLTRIM(LocalCli.RClis)
                    ENDIF
                ENDIF

                REPLACE Vends  WITH crSigMvCab.Vends, ;
                        NVends WITH loc_lcNvends ;
                        IN crAnalitico

                IF (loc_lnTip = 1 OR loc_lnTip = 4)
                    REPLACE Datas      WITH crSigMvCab.Datas, ;
                            EmpDopNums WITH crSigMvCab.EmpDopNums, ;
                            Notas      WITH crSigMvCab.Notas, ;
                            ContaDs    WITH crSigMvCab.ContaDs, ;
                            RClis      WITH loc_lcCta ;
                            IN crAnalitico
                ENDIF

                IF (loc_lnTip = 3)
                    REPLACE Datas WITH crSigMvCab.Datas, ;
                            Dopes WITH loc_lcDop ;
                            IN crAnalitico
                ENDIF
            ENDIF

            *-- Calcula conversao de moeda e acumula comissao
            loc_lnCot = 1
            IF crSigCdOpe.Cmoes <> LocalItens.MoeVs
                loc_lnCotMoeV   = THIS.BuscarCotacao(ALLTRIM(LocalItens.MoeVs), crSigMvCab.Datas)
                loc_lnCotMoePag = THIS.BuscarCotacao(ALLTRIM(loc_lcMoe), crSigMvCab.Datas)
                IF loc_lnCotMoePag <> 0
                    loc_lnCot = loc_lnCotMoeV / loc_lnCotMoePag
                ENDIF
            ENDIF

            loc_lnComi = ((LocalItens.Valos * loc_lnCot) / 100) * loc_lnComFPag
            REPLACE Valos WITH Valos + ((LocalItens.Valos * loc_lnCot) * par_nMlt), ;
                    Comis WITH Comis + (loc_lnComi * par_nMlt) ;
                    IN crAnalitico

            SELECT LocalItens
        ENDSCAN

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * SelecionaPar - Calcula comissao com base nas parcelas (Base = Movimentacao)
    * Equivale ao metodo 'selecionapar' do form legado SIGRECOM
    * par_nMlt: +1 (entrada) ou -1 (saida/devolucao)
    *==========================================================================
    PROCEDURE SelecionaPar(par_nMlt)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_lcCdMoeda, loc_lnTip, loc_lnBas
        LOCAL loc_lnIcmss, loc_lnPar, loc_lnTm
        LOCAL loc_lnVpar, loc_lnVparav, loc_lnDt, loc_lnTd
        LOCAL loc_lnDesconto, loc_lnPorc
        LOCAL loc_lcNvends, loc_lnComFPag
        LOCAL loc_lcDop, loc_lcEdn, loc_lcCta
        LOCAL loc_lnCotFpg, loc_lnCotMoe, loc_lnCotFpg2, loc_lnCotMoeDt, loc_lnComi

        loc_lSucesso  = .T.
        loc_lcCdMoeda = THIS.this_cCdMoeda
        loc_lnTip     = THIS.this_nTipo
        loc_lnBas     = THIS.this_nBase
        loc_lnIcmss   = 0

        *-- Taxa mensal JM para calculo de valor a vista
        loc_lnTm = THIS.BuscarCambio({}, THIS.this_dDtFinal, SPACE(3), "JM ")

        *-- Parcelas do movimento atual, com troco negativo
        loc_cSQL = ;
            "SELECT a.cotfpgs, a.Empdopnums, a.dopes, a.fpags, " + ;
            "a.moefpgs, " + ;
            "CASE WHEN b.trocos = 1 THEN -a.valos ELSE a.valos END AS valos, " + ;
            "a.datas, a.vencs " + ;
            "FROM SigMvPar a, SigOpFp b " + ;
            "WHERE a.Empdopnums = '" + ;
            go_4c_Sistema.cCodEmpresa + ;
            crSigMvCab.Dopes + STR(crSigMvCab.Numes, 6) + "' " + ;
            "AND a.FPags = b.FPags " + ;
            "ORDER BY a.Empdopnums, a.dopes, a.fpags, " + ;
            "a.moefpgs, valos, a.datas, a.vencs"

        IF USED("crSigMvPar")
            USE IN crSigMvPar
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigMvPar")
        IF loc_nResult < 1
            MsgErro("Falha na Conex" + CHR(227) + "o (crSigMvPar)", "Erro")
            RETURN .F.
        ENDIF

        *-- Busca ICMSS se base for Movimentacao S/ST
        IF loc_lnBas = 3
            IF USED("crNfi")
                USE IN crNfi
            ENDIF
            loc_cSQL = "SELECT a.icmss FROM SigMvNfi a " + ;
                       "WHERE a.Empdopnums = '" + ;
                       ALLTRIM(crSigMvCab.EmpDopNums) + "'"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crNfi") >= 1
                SELECT crNfi
                GO TOP
                IF !EOF()
                    loc_lnIcmss = crNfi.icmss
                ENDIF
            ENDIF
            loc_lnPar   = RECCOUNT("crSigMvPar")
            loc_lnIcmss = loc_lnIcmss / IIF(loc_lnPar = 0, 1, loc_lnPar)
        ENDIF

        *-- Processa cada parcela
        SELECT crSigMvPar
        SCAN
            *-- Localiza ou cria entrada na Parcela (por fpags)
            SELECT Parcela
            SET ORDER TO fpags
            SEEK crSigMvPar.fpags
            IF EOF()
                APPEND BLANK
                REPLACE fpags WITH crSigMvPar.fpags IN Parcela
            ENDIF

            *-- Calcula valor na moeda de destino
            loc_lnCotFpg = THIS.BuscarCotacao(ALLTRIM(crSigMvPar.moefpgs), DATE())
            loc_lnCotMoe = THIS.BuscarCotacao(ALLTRIM(loc_lcCdMoeda), DATE())
            IF loc_lnCotMoe <> 0
                loc_lnVpar = crSigMvPar.valos * loc_lnCotFpg / loc_lnCotMoe
            ELSE
                loc_lnVpar = crSigMvPar.valos
            ENDIF

            *-- Ajusta sinal conforme tipo de operacao da parcela
            IF SEEK(crSigMvPar.dopes, "crSigCdOpe", "dopes")
                IF crSigCdOpe.copers = 2
                    loc_lnVpar = loc_lnVpar * (-1)
                ENDIF
            ENDIF

            *-- Acumula na Parcela (entradas vs devolu??es)
            IF par_nMlt > 0
                REPLACE valos  WITH valos  + loc_lnVpar IN Parcela
            ELSE
                REPLACE Devols WITH Devols + loc_lnVpar IN Parcela
            ENDIF

            *-- Calculo do valor a vista por antecipacao de pagamento
            loc_lnVparav = loc_lnVpar
            loc_lnDt     = crSigMvPar.datas - crSigMvPar.vencs
            IF loc_lnDt < 0
                IF loc_lnTm <> 0
                    loc_lnTd = ((1 + loc_lnTm / 100) ^ (1 / 30) - 1) * 100
                    loc_lnTd = INT(loc_lnTd * 100 + 0.5) / 100
                ELSE
                    loc_lnTd = 0
                ENDIF
                IF loc_lnTd <> 0
                    loc_lnDesconto = (1 + loc_lnTd / 100) ^ (-1 * loc_lnDt)
                    loc_lnPorc     = (1 - 1 / loc_lnDesconto) * 100
                    loc_lnPorc     = INT(loc_lnPorc * 100 + 0.5) / 100
                    loc_lnVparav   = loc_lnVpar * (1 - (loc_lnPorc / 100))
                    loc_lnVparav   = INT(loc_lnVparav * 100 + 0.5) / 100
                ENDIF
            ENDIF

            *-- Desconto adicional da forma de pagamento
            SELECT crSigOpFp
            SEEK crSigMvPar.FPags
            IF !EOF() AND !EMPTY(crSigOpFp.Descs)
                loc_lnVparav = loc_lnVparav - loc_lnVparav * crSigOpFp.Descs / 100
            ENDIF

            *-- Acumula valor a vista e classifica tipo na Parcela
            SELECT Parcela
            IF par_nMlt > 0
                REPLACE ValoAvs WITH ValoAvs + loc_lnVparav IN Parcela
            ELSE
                REPLACE ValoAvs WITH ValoAvs - loc_lnVparav IN Parcela
            ENDIF
            IF USED("crSigOpFp") AND !EOF("crSigOpFp")
                REPLACE Tipo WITH THIS.VerTpPag(crSigOpFp.Infos) IN Parcela
            ENDIF

            *-- Calcula comissao se operacao configurada para tal
            IF crSigCdOpe.ccomis = 1
                loc_cSQL = ;
                    "SELECT Grupos, IClis, RClis, Comis, CCargs " + ;
                    "FROM SigCdCli " + ;
                    "WHERE IClis = '" + PADR(crSigMvCab.Vends, 10) + "' " + ;
                    "AND Grupos = '" + PADR(crSigMvCab.Grvends, 10) + "' " + ;
                    "ORDER BY Grupos, IClis, RClis, Comis, CCargs"

                IF USED("crSigCdCli")
                    USE IN crSigCdCli
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdCli")
                IF loc_nResult < 1
                    MsgErro("Falha na Conex" + CHR(227) + "o (crSigCdCli)", "Erro")
                    RETURN .F.
                ENDIF
                SELECT crSigCdCli
                GO TOP

                IF !EMPTY(crSigCdCli.Comis)
                    loc_lnComFPag = crSigCdCli.Comis
                ELSE
                    *-- Usa comissao da forma de pagamento
                    SELECT crSigOpFp
                    SEEK crSigMvPar.FPags
                    loc_lnComFPag = IIF(EOF("crSigOpFp"), 0, crSigOpFp.fpcomiss)
                    SELECT crSigCdCli
                ENDIF

                loc_lcNvends = ALLTRIM(crSigCdCli.Rclis)

                IF crSigCdOpe.ComCargs = 1
                    SELECT crSigCdCrg
                    SEEK crSigCdCli.CCargs
                    IF !EOF()
                        loc_lnComFPag = crSigCdCrg.Comis
                    ENDIF
                ENDIF

                *-- Posiciona crAnalitico
                SELECT crAnalitico
                SET ORDER TO VendDatas
                loc_lcDop = crSigMvCab.Dopes

                DO CASE
                    CASE (loc_lnTip = 1 OR loc_lnTip = 4)
                        SEEK crSigMvCab.Vends + DTOS(crSigMvCab.Datas) + crSigMvCab.EmpDopNums
                    CASE (loc_lnTip = 2)
                        SEEK crSigMvCab.Vends
                    OTHERWISE
                        IF USED("LocalSub")
                            USE IN LocalSub
                        ENDIF
                        loc_cSQL = ;
                            "SELECT a.EmpDopNums, a.Codigos, a.Emps, " + ;
                            "o.Dopes, RIGHT(a.Codigos, 6) AS Numes " + ;
                            "FROM SigMvPec a, SigMvCab b, SigCdOpe o " + ;
                            "WHERE a.EmpDopNums = b.EmpDopNums " + ;
                            "AND LEFT(a.Codigos, 3) = o.NDopes " + ;
                            "AND a.EmpDopNums = '" + ALLTRIM(crSigMvCab.EmpDopNums) + "' " + ;
                            "AND a.EmpDopNums NOT IN (" + ;
                            "SELECT n.EmpDopNums FROM SigMvNfi n " + ;
                            "WHERE n.EmpDopNums = '" + ALLTRIM(crSigMvCab.EmpDopNums) + "')"
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "LocalSub") >= 1
                            SELECT LocalSub
                            GO TOP IN LocalSub
                            IF !EOF("LocalSub")
                                loc_lcEdn = ALLTRIM(LocalSub.Emps) + ;
                                            ALLTRIM(LocalSub.Dopes) + ;
                                            STR(INT(VAL(ALLTRIM(LocalSub.Numes))), 6)
                                IF USED("LocalNF")
                                    USE IN LocalNF
                                ENDIF
                                loc_cSQL = ;
                                    "SELECT b.NFis, b.EmpDopNums " + ;
                                    "FROM SigMvNfi b " + ;
                                    "WHERE b.EmpDopNums = " + EscaparSQL(loc_lcEdn)
                                IF SQLEXEC(gnConnHandle, loc_cSQL, "LocalNF") >= 1
                                    SELECT LocalNF
                                    GO TOP IN LocalNF
                                    IF !EOF("LocalNF")
                                        loc_lcDop = LocalSub.Dopes
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                        SELECT crAnalitico
                        SEEK crSigMvCab.Vends + DTOS(crSigMvCab.Datas) + loc_lcDop
                ENDCASE

                IF EOF("crAnalitico")
                    APPEND BLANK IN crAnalitico

                    IF USED("LocalCli")
                        USE IN LocalCli
                    ENDIF
                    loc_lcCta = ""
                    loc_cSQL = "SELECT RClis FROM SigCdCli " + ;
                               "WHERE IClis = '" + ALLTRIM(crSigMvCab.ContaDs) + "'"
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "LocalCli") >= 1
                        SELECT LocalCli
                        GO TOP
                        IF !EOF("LocalCli")
                            loc_lcCta = ALLTRIM(LocalCli.RClis)
                        ENDIF
                    ENDIF

                    REPLACE Vends  WITH crSigMvCab.Vends, ;
                            NVends WITH loc_lcNvends ;
                            IN crAnalitico

                    IF (loc_lnTip = 1 OR loc_lnTip = 4)
                        REPLACE Datas      WITH crSigMvCab.Datas, ;
                                EmpDopNums WITH crSigMvCab.EmpDopNums, ;
                                Notas      WITH crSigMvCab.Notas, ;
                                ContaDs    WITH crSigMvCab.ContaDs, ;
                                RClis      WITH loc_lcCta ;
                                IN crAnalitico
                    ENDIF

                    IF (loc_lnTip = 3)
                        REPLACE Datas WITH crSigMvCab.Datas, ;
                                Dopes WITH loc_lcDop ;
                                IN crAnalitico
                    ENDIF
                ENDIF

                *-- Calcula comissao usando cotacao da parcela
                loc_lnCotFpg2  = IIF(crSigMvPar.cotfpgs <> 0, crSigMvPar.cotfpgs, ;
                                     THIS.BuscarCotacao(ALLTRIM(crSigMvPar.moefpgs), ;
                                                        crSigMvCab.Datas))
                loc_lnCotMoeDt = THIS.BuscarCotacao(ALLTRIM(loc_lcCdMoeda), crSigMvCab.Datas)

                IF loc_lnCotMoeDt <> 0
                    loc_lnComi = (crSigMvPar.valos - loc_lnIcmss) * ;
                                 loc_lnCotFpg2 / loc_lnCotMoeDt / 100 * loc_lnComFPag
                    REPLACE Valos WITH Valos - loc_lnIcmss + ;
                            ((crSigMvPar.valos * loc_lnCotFpg2 / loc_lnCotMoeDt) * par_nMlt), ;
                            Comis WITH Comis + (loc_lnComi * par_nMlt) ;
                            IN crAnalitico
                ENDIF
            ENDIF

            SELECT crSigMvPar
        ENDSCAN

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarCursoresBase - Carrega cursores de referencia para o processamento
    * Equivale aos AddCursor/ReQuery do Init() do form legado SIGRECOM
    *==========================================================================
    PROCEDURE CarregarCursoresBase()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_oErr, loc_lFalhou

        loc_lSucesso = .F.
        loc_lFalhou  = .F.

        TRY
            *-- SigCdOpe (operacoes de venda/caixa)
            IF !loc_lFalhou
                IF USED("crSigCdOpe")
                    USE IN crSigCdOpe
                ENDIF
                loc_cSQL = ;
                    "SELECT ordes, dopes, cmoes, copers, ccomis, comcargs, " + ;
                    "vendas, calcfecs, relfechas, caixas, ndopes " + ;
                    "FROM SigCdOpe " + ;
                    "ORDER BY ordes"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdOpe")
                IF loc_nResult < 1
                    loc_lFalhou = .T.
                    THIS.this_cMensagemErro = "Falha ao carregar SigCdOpe"
                    MsgErro("Falha ao carregar SigCdOpe", "Erro")
                ELSE
                    SELECT crSigCdOpe
                    INDEX ON ordes TAG ordes
                    INDEX ON dopes TAG dopes
                ENDIF
            ENDIF

            *-- SigCdEmp (dados da empresa)
            IF !loc_lFalhou
                IF USED("crSigCdEmp")
                    USE IN crSigCdEmp
                ENDIF
                loc_cSQL = "SELECT cemps, razas FROM SigCdEmp " + ;
                           "WHERE cemps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdEmp")
                IF loc_nResult < 1
                    loc_lFalhou = .T.
                    THIS.this_cMensagemErro = "Falha ao carregar SigCdEmp"
                    MsgErro("Falha ao carregar SigCdEmp", "Erro")
                ENDIF
            ENDIF

            *-- SigCdMoe (cadastro de moedas)
            IF !loc_lFalhou
                IF USED("crSigCdMoe")
                    USE IN crSigCdMoe
                ENDIF
                loc_cSQL = ;
                    "SELECT cmoes, dmoes, cotas, datatrans, fmults, nordrels, " + ;
                    "disfpres, valadics, grumoes, moeqs, qtdeqs, submoes " + ;
                    "FROM SigCdMoe " + ;
                    "ORDER BY cmoes"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdMoe")
                IF loc_nResult < 1
                    loc_lFalhou = .T.
                    THIS.this_cMensagemErro = "Falha ao carregar SigCdMoe"
                    MsgErro("Falha ao carregar SigCdMoe", "Erro")
                ELSE
                    SELECT crSigCdMoe
                    INDEX ON cmoes TAG cmoes
                    INDEX ON dmoes TAG dmoes
                ENDIF
            ENDIF

            *-- SigCdCot (cotacoes de moeda - indexado por moeda+data)
            IF !loc_lFalhou
                IF USED("crSigCdCot")
                    USE IN crSigCdCot
                ENDIF
                loc_cSQL = ;
                    "SELECT cmoes, datas, horas, valos, cidchaves, usuars, dtalts " + ;
                    "FROM SigCdCot " + ;
                    "ORDER BY cmoes, datas"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdCot")
                IF loc_nResult < 1
                    loc_lFalhou = .T.
                    THIS.this_cMensagemErro = "Falha ao carregar SigCdCot"
                    MsgErro("Falha ao carregar SigCdCot", "Erro")
                ELSE
                    SELECT crSigCdCot
                    INDEX ON PADR(cmoes, 3) + DTOS(datas) TAG CMOEDATA
                ENDIF
            ENDIF

            *-- SigOpFp (formas de pagamento)
            IF !loc_lFalhou
                IF USED("crSigOpFp")
                    USE IN crSigOpFp
                ENDIF
                loc_cSQL = ;
                    "SELECT Fpags, Descs, Infos, FPComiss, trocos " + ;
                    "FROM SigOpFp " + ;
                    "ORDER BY Fpags"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigOpFp")
                IF loc_nResult < 1
                    loc_lFalhou = .T.
                    THIS.this_cMensagemErro = "Falha ao carregar SigOpFp"
                    MsgErro("Falha ao carregar SigOpFp", "Erro")
                ELSE
                    SELECT crSigOpFp
                    INDEX ON FPags TAG FPags
                ENDIF
            ENDIF

            *-- SigCdCrg (tabela de encargos/cargas de comissao)
            IF !loc_lFalhou
                IF USED("crSigCdCrg")
                    USE IN crSigCdCrg
                ENDIF
                loc_cSQL = "SELECT CCargs, Comis FROM SigCdCrg ORDER BY CCargs"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdCrg")
                IF loc_nResult < 1
                    loc_lFalhou = .T.
                    THIS.this_cMensagemErro = "Falha ao carregar SigCdCrg"
                    MsgErro("Falha ao carregar SigCdCrg", "Erro")
                ELSE
                    SELECT crSigCdCrg
                    INDEX ON CCargs TAG CCargs
                ENDIF
            ENDIF

            IF !loc_lFalhou
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            MsgErro(loc_oErr.Message, "CarregarCursoresBase")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarCaptionsOpcao - Carrega titulos dinamicos de opt_nr_opcao
    * Le SigCdPac e seta this_cTitOpcS / this_cTitOpcN / this_cTitOpcA
    *==========================================================================
    PROCEDURE CarregarCaptionsOpcao()
        LOCAL loc_cSQL, loc_nResult, loc_oErr

        TRY
            loc_cSQL = "SELECT TitOpcS, TitOpcN, TitOpcA FROM SigCdPac"
            IF USED("cursor_4c_CdPac")
                USE IN cursor_4c_CdPac
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CdPac")
            IF loc_nResult >= 1
                SELECT cursor_4c_CdPac
                GO TOP
                IF !EOF()
                    IF !EMPTY(cursor_4c_CdPac.TitOpcS)
                        THIS.this_cTitOpcS = ALLTRIM(cursor_4c_CdPac.TitOpcS)
                    ENDIF
                    IF !EMPTY(cursor_4c_CdPac.TitOpcN)
                        THIS.this_cTitOpcN = ALLTRIM(cursor_4c_CdPac.TitOpcN)
                    ENDIF
                    IF !EMPTY(cursor_4c_CdPac.TitOpcA)
                        THIS.this_cTitOpcA = ALLTRIM(cursor_4c_CdPac.TitOpcA)
                    ENDIF
                ENDIF
                USE IN cursor_4c_CdPac
            ENDIF
        CATCH TO loc_oErr
            MsgErro(loc_oErr.Message, "CarregarCaptionsOpcao")
        ENDTRY

        RETURN .T.
    ENDPROC

    *==========================================================================
    * CarregarMoedaPadrao - Retorna descricao de uma moeda pelo codigo
    * par_cCdMoeda: codigo da moeda (ex: 'R  ')
    *==========================================================================
    FUNCTION CarregarMoedaPadrao(par_cCdMoeda)
        LOCAL loc_cDesc, loc_cSQL, loc_nResult, loc_oErr

        loc_cDesc = ""

        TRY
            loc_cSQL = "SELECT DMoes FROM SigCdMoe " + ;
                       "WHERE cmoes = " + EscaparSQL(PADR(ALLTRIM(par_cCdMoeda), 3))
            IF USED("cursor_4c_MoeDsc")
                USE IN cursor_4c_MoeDsc
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeDsc")
            IF loc_nResult >= 1
                SELECT cursor_4c_MoeDsc
                GO TOP
                IF !EOF()
                    loc_cDesc = ALLTRIM(cursor_4c_MoeDsc.DMoes)
                ENDIF
                USE IN cursor_4c_MoeDsc
            ENDIF
        CATCH TO loc_oErr
            MsgErro(loc_oErr.Message, "CarregarMoedaPadrao")
        ENDTRY

        RETURN loc_cDesc
    ENDPROC

    *==========================================================================
    * BuscarCotacao - Retorna cotacao de moeda em determinada data
    * Equivale a fBuscarCotacao() do framework legado
    * Usa crSigCdCot (indexado por CMOEDATA = PADR(cmoes,3)+DTOS(datas))
    *==========================================================================
    FUNCTION BuscarCotacao(par_cMoeda, par_dData)
        LOCAL loc_nValor, loc_oErr

        loc_nValor = 1

        TRY
            IF USED("crSigCdCot") AND !EMPTY(par_cMoeda)
                SELECT crSigCdCot
                SET ORDER TO CMOEDATA
                SET NEAR ON
                IF SEEK(PADR(ALLTRIM(par_cMoeda), 3) + DTOS(par_dData))
                    IF crSigCdCot.valos <> 0
                        loc_nValor = crSigCdCot.valos
                    ENDIF
                ENDIF
                SET NEAR OFF
            ENDIF
        CATCH TO loc_oErr
            loc_nValor = 1
        ENDTRY

        RETURN loc_nValor
    ENDPROC

    *==========================================================================
    * BuscarCambio - Retorna taxa especial de cambio (ex: JM = taxa mensal)
    * Equivale a fBuscarCambio() do framework legado
    * par_dIgnorado: data ignorada (compatibilidade com assinatura original)
    * par_dData:     data de referencia para busca
    * par_cEspaco:   parametro auxiliar (geralmente SPACE(3))
    * par_cTipo:     codigo da taxa (ex: 'JM ')
    *==========================================================================
    FUNCTION BuscarCambio(par_dIgnorado, par_dData, par_cEspaco, par_cTipo)
        LOCAL loc_nTaxa, loc_oErr

        loc_nTaxa = 0

        TRY
            IF USED("crSigCdCot") AND !EMPTY(par_cTipo)
                SELECT crSigCdCot
                SET ORDER TO CMOEDATA
                SET NEAR ON
                IF SEEK(PADR(ALLTRIM(par_cTipo), 3) + DTOS(par_dData))
                    loc_nTaxa = crSigCdCot.valos
                ENDIF
                SET NEAR OFF
            ENDIF
        CATCH TO loc_oErr
            loc_nTaxa = 0
        ENDTRY

        RETURN loc_nTaxa
    ENDPROC

    *==========================================================================
    * VerTpPag - Classifica tipo de pagamento pelo campo Infos de SigOpFp
    * Equivale a fVerTpPag() do framework legado
    *==========================================================================
    FUNCTION VerTpPag(par_cInfos)
        RETURN PADR(ALLTRIM(par_cInfos), 6)
    ENDPROC

    *==========================================================================
    * Imprimir - Executa PrepararDados e envia relatorio para impressora
    *==========================================================================
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_lcSep, loc_lcPto, loc_oErr

        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.PrepararDados()
            IF loc_lSucesso
                loc_lcSep = SET("Separator")
                loc_lcPto = SET("Point")
                SET POINT TO ","
                SET SEPARATOR TO "."

                DO CASE
                    CASE THIS.this_nTipo = 1
                        IF THIS.this_nQuebra = 1
                            REPORT FORM (gc_4c_CaminhoReports + "SigReCo1") ;
                                   TO PRINTER PROMPT NOCONSOLE
                        ELSE
                            REPORT FORM (gc_4c_CaminhoReports + "SigReCo2") ;
                                   TO PRINTER PROMPT NOCONSOLE
                        ENDIF
                    CASE THIS.this_nTipo = 2
                        REPORT FORM (gc_4c_CaminhoReports + "SigReCo3") ;
                               TO PRINTER PROMPT NOCONSOLE
                    CASE THIS.this_nTipo = 4
                        REPORT FORM (gc_4c_CaminhoReports + "SigReCo5") ;
                               TO PRINTER PROMPT NOCONSOLE
                    OTHERWISE
                        REPORT FORM (gc_4c_CaminhoReports + "SigReCo4") ;
                               TO PRINTER PROMPT NOCONSOLE
                ENDCASE

                SET POINT TO (loc_lcPto)
                SET SEPARATOR TO (loc_lcSep)
            ENDIF

        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            MsgErro(loc_oErr.Message, "Imprimir")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Visualizar - Executa PrepararDados e exibe preview do relatorio
    *==========================================================================
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_lcSep, loc_lcPto, loc_oErr

        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.PrepararDados()
            IF loc_lSucesso
                loc_lcSep = SET("Separator")
                loc_lcPto = SET("Point")
                SET POINT TO ","
                SET SEPARATOR TO "."

                DO CASE
                    CASE THIS.this_nTipo = 1
                        IF THIS.this_nQuebra = 1
                            REPORT FORM (gc_4c_CaminhoReports + "SigReCo1") ;
                                   PREVIEW NOCONSOLE
                        ELSE
                            REPORT FORM (gc_4c_CaminhoReports + "SigReCo2") ;
                                   PREVIEW NOCONSOLE
                        ENDIF
                    CASE THIS.this_nTipo = 2
                        REPORT FORM (gc_4c_CaminhoReports + "SigReCo3") ;
                               PREVIEW NOCONSOLE
                    CASE THIS.this_nTipo = 4
                        REPORT FORM (gc_4c_CaminhoReports + "SigReCo5") ;
                               PREVIEW NOCONSOLE
                    OTHERWISE
                        REPORT FORM (gc_4c_CaminhoReports + "SigReCo4") ;
                               PREVIEW NOCONSOLE
                ENDCASE

                SET POINT TO (loc_lcPto)
                SET SEPARATOR TO (loc_lcSep)
            ENDIF

        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            MsgErro(loc_oErr.Message, "Visualizar")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterMensagemErro - Retorna mensagem de erro do ultimo processamento
    *==========================================================================
    FUNCTION ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave logica do relatorio (tabela+periodo)
    * Usada por RegistrarAuditoria para identificar a execucao do relatorio
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ALLTRIM(THIS.this_cTabela) + "|" + ;
                     DTOS(THIS.this_dDtInicial) + "|" + ;
                     DTOS(THIS.this_dDtFinal) + "|" + ;
                     ALLTRIM(THIS.this_cCdMoeda) + "|" + ;
                     "TIPO" + TRANSFORM(THIS.this_nTipo)
        RETURN loc_cChave
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega filtros do relatorio a partir de um cursor de
    * parametros (uso opcional para restaurar configuracao salva pelo usuario)
    * par_cAliasCursor: alias do cursor com colunas DtInicial, DtFinal, CdMoeda,
    *                   Vendedor, Tipo, NrOpcao, Quebra, Base, Ordem
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErr, loc_cAlias

        loc_lSucesso = .F.

        IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor de par" + CHR(226) + "metros n" + ;
                                      CHR(227) + "o dispon" + CHR(237) + "vel: " + ;
                                      TRANSFORM(par_cAliasCursor)
            RETURN .F.
        ENDIF

        loc_cAlias = par_cAliasCursor

        TRY
            SELECT (loc_cAlias)
            IF !EOF()
                IF TYPE(loc_cAlias + ".DtInicial") = "D"
                    THIS.this_dDtInicial = EVALUATE(loc_cAlias + ".DtInicial")
                ENDIF
                IF TYPE(loc_cAlias + ".DtFinal") = "D"
                    THIS.this_dDtFinal = EVALUATE(loc_cAlias + ".DtFinal")
                ENDIF
                IF TYPE(loc_cAlias + ".CdMoeda") = "C"
                    THIS.this_cCdMoeda = EVALUATE(loc_cAlias + ".CdMoeda")
                ENDIF
                IF TYPE(loc_cAlias + ".DsMoeda") = "C"
                    THIS.this_cDsMoeda = EVALUATE(loc_cAlias + ".DsMoeda")
                ENDIF
                IF TYPE(loc_cAlias + ".Vendedor") = "C"
                    THIS.this_cVendedor = EVALUATE(loc_cAlias + ".Vendedor")
                ENDIF
                IF TYPE(loc_cAlias + ".Tipo") = "N"
                    THIS.this_nTipo = EVALUATE(loc_cAlias + ".Tipo")
                ENDIF
                IF TYPE(loc_cAlias + ".NrOpcao") = "N"
                    THIS.this_nNrOpcao = EVALUATE(loc_cAlias + ".NrOpcao")
                ENDIF
                IF TYPE(loc_cAlias + ".Quebra") = "N"
                    THIS.this_nQuebra = EVALUATE(loc_cAlias + ".Quebra")
                ENDIF
                IF TYPE(loc_cAlias + ".Base") = "N"
                    THIS.this_nBase = EVALUATE(loc_cAlias + ".Base")
                ENDIF
                IF TYPE(loc_cAlias + ".Ordem") = "N"
                    THIS.this_nOrdem = EVALUATE(loc_cAlias + ".Ordem")
                ENDIF
                THIS.this_lExibeOrdem = (THIS.this_nTipo = 4)
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Cursor de par" + CHR(226) + ;
                                          "metros vazio"
            ENDIF
        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            MsgErro(loc_oErr.Message, "CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - Registra execucao do relatorio em LogAuditoria
    * Para relatorios, "Inserir" significa registrar uma nova execucao,
    * permitindo rastreamento de quem rodou qual relatorio e quando
    *==========================================================================
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_oErr

        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.RegistrarAuditoria("REPORT_RUN")
            IF !loc_lSucesso
                THIS.this_cMensagemErro = "Falha ao registrar execu" + ;
                                          CHR(231) + CHR(227) + "o do relat" + ;
                                          CHR(243) + "rio em LogAuditoria"
            ENDIF
        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            MsgErro(loc_oErr.Message, "Inserir")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Registra reexecucao do relatorio em LogAuditoria
    * Para relatorios, "Atualizar" significa registrar uma reexecucao
    * (ex: usuario alterou filtros e gerou novamente)
    *==========================================================================
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_oErr

        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.RegistrarAuditoria("REPORT_RERUN")
            IF !loc_lSucesso
                THIS.this_cMensagemErro = "Falha ao registrar reexecu" + ;
                                          CHR(231) + CHR(227) + "o do relat" + ;
                                          CHR(243) + "rio em LogAuditoria"
            ENDIF
        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            MsgErro(loc_oErr.Message, "Atualizar")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * RegistrarAuditoria - Registra operacao do relatorio em LogAuditoria
    * par_cOperacao: "REPORT_RUN", "REPORT_RERUN", "REPORT_PREVIEW", etc.
    *==========================================================================
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cChave, loc_cUsuario, loc_cSQL, loc_nResult, loc_oErr

        loc_lSucesso = .F.

        TRY
            loc_cChave = THIS.ObterChavePrimaria()

            IF EMPTY(loc_cChave)
                THIS.this_cMensagemErro = "Chave de auditoria vazia"
                loc_lSucesso = .F.
            ENDIF

            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                               gc_4c_UsuarioLogado, "SISTEMA")

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cTabela)) + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       "GETDATE())"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)

            IF !loc_lSucesso
                THIS.this_cMensagemErro = "SQLEXEC falhou ao inserir em LogAuditoria"
            ENDIF

        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Destroy - Fecha cursores abertos e limpa recursos
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_aCursores(13), loc_nI
        loc_aCursores(1)  = "crSigCdOpe"
        loc_aCursores(2)  = "crSigCdEmp"
        loc_aCursores(3)  = "crSigCdMoe"
        loc_aCursores(4)  = "crSigCdCot"
        loc_aCursores(5)  = "crSigOpFp"
        loc_aCursores(6)  = "crSigCdCrg"
        loc_aCursores(7)  = "crAnalitico"
        loc_aCursores(8)  = "Parcela"
        loc_aCursores(9)  = "dbcabecalho"
        loc_aCursores(10) = "crMedia"
        loc_aCursores(11) = "crSigMvCab"
        loc_aCursores(12) = "crSigMvPar"
        loc_aCursores(13) = "crSigCdCli"
        FOR loc_nI = 1 TO 13
            IF USED(loc_aCursores(loc_nI))
                USE IN (loc_aCursores(loc_nI))
            ENDIF
        NEXT
        DODEFAULT()
    ENDPROC

ENDDEFINE

