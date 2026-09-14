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
[06/06/2026 08:02:34 PM] InicializarDados: Connection handle is invalid.
[06/06/2026 08:02:34 PM] Erro: Inventário: 0


### LOG DA ETAPA (06b_testeAutomatico):
[2026-06-06 20:02:24] [INFO] === VFP EXECUTOR v2.0 ===
[2026-06-06 20:02:24] [INFO] Config FPW: (nao fornecido)
[2026-06-06 20:02:24] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-06-06 20:02:24] [INFO] Timeout: 300 segundos
[2026-06-06 20:02:24] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_kyqz3d5y.prg
[2026-06-06 20:02:24] [INFO] Conteudo do wrapper:
[2026-06-06 20:02:24] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSigReIr1', 'C:\4c\tasks\task131', 'REPORT'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigReIr1', 'C:\4c\tasks\task131', 'REPORT'
QUIT

[2026-06-06 20:02:24] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_kyqz3d5y.prg
[2026-06-06 20:02:24] [INFO] VFP output esperado em: C:\4c\tasks\task131\vfp_output.txt
[2026-06-06 20:02:24] [INFO] Executando Visual FoxPro 9...
[2026-06-06 20:02:24] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_kyqz3d5y.prg
[2026-06-06 20:02:24] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_kyqz3d5y.prg
[2026-06-06 20:02:24] [INFO] Timeout configurado: 300 segundos
[2026-06-06 20:02:34] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-06-06 20:02:34] [INFO] VFP9 finalizado em 10.6961285 segundos
[2026-06-06 20:02:34] [INFO] Exit Code: 
[2026-06-06 20:02:34] [INFO] 
[2026-06-06 20:02:34] [INFO] Arquivos temporarios preservados para inspecao:
[2026-06-06 20:02:34] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_kyqz3d5y.prg
[2026-06-06 20:02:34] [INFO] 
[2026-06-06 20:02:34] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-06-06 20:02:34] [INFO] * Auto-generated wrapper for parameters
[2026-06-06 20:02:34] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-06-06 20:02:34] [INFO] * Parameters: 'FormSigReIr1', 'C:\4c\tasks\task131', 'REPORT'
[2026-06-06 20:02:34] [INFO] 
[2026-06-06 20:02:34] [INFO] * Anti-dialog protections for unattended execution
[2026-06-06 20:02:34] [INFO] SET SAFETY OFF
[2026-06-06 20:02:34] [INFO] SET RESOURCE OFF
[2026-06-06 20:02:34] [INFO] SET TALK OFF
[2026-06-06 20:02:34] [INFO] SET NOTIFY OFF
[2026-06-06 20:02:34] [INFO] SYS(2335, 0)
[2026-06-06 20:02:34] [INFO] 
[2026-06-06 20:02:34] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigReIr1', 'C:\4c\tasks\task131', 'REPORT'
[2026-06-06 20:02:34] [INFO] QUIT
[2026-06-06 20:02:34] [INFO] 
[2026-06-06 20:02:34] [INFO] === Fim do Wrapper.prg ===
[2026-06-06 20:02:34] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSigReIr1",
  "timestamp": "20260606200234",
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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReIr1.prg):
*==============================================================================
* FORMSIGREIR1.PRG
* Relat" + CHR(243) + "rio de Balan" + CHR(231) + "o (Invent" + CHR(225) + "rio)
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREIR1.SCX (frmrelatorio)
* Tarefa: task131
*
* Filtros:
*   - Tipo de Relat" + CHR(243) + "rio (5 op" + CHR(231) + CHR(245) + "es):
*       1=Resumo p/Produto, 2=Resumo Geral, 3=Anal" + CHR(237) + "tico,
*       4=Etiqueta, 5=Estoque x Leitura
*   - Tipo Anal" + CHR(237) + "tico (Produto / Local) - ativo apenas quando tipo=3
*   - Produto (c" + CHR(243) + "digo + descri" + CHR(231) + CHR(227) + "o - SigCdPro) - modo Produto
*   - Local   (c" + CHR(243) + "digo + descri" + CHR(231) + CHR(227) + "o - SigPrLcl) - modo Local
*   - Tipo Diferen" + CHR(231) + "a (Todos / Com Diferen" + CHR(231) + "a) - ativo apenas tipo=1
*   - Tipo Leitura (Leitura / Releitura) - ativo apenas tipo=3
*   - Ordem (Produto / Grupo) - ativo apenas tipo=1
*   - Pre" + CHR(231) + "o Custo / Pre" + CHR(231) + "o Venda (Sim/N" + CHR(227) + "o)
*   - Descri" + CHR(231) + CHR(227) + "o do Produto / C" + CHR(243) + "digo de Barras / Localiza" + CHR(231) + CHR(227) + "o
*   - Imprimir Imagem - ativo apenas tipo=4 ou 5
*==============================================================================

DEFINE CLASS FormSigReIr1 AS FormBase

    Height      = 600
    Width       = 1000
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
    this_nNumBalanco   = 0

    *--------------------------------------------------------------------------
    * Init - Aceita NumBalanco e delega para FormBase.Init() -> InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_nNumBalanco)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF PCOUNT() >= 1 AND VARTYPE(par_nNumBalanco) = "N"
            THIS.this_nNumBalanco = par_nNumBalanco
        ENDIF
        loc_lSucesso = DODEFAULT()
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura do formul" + CHR(225) + "rio de relat" + CHR(243) + "rio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            SET DATE TO BRITISH
            SET CENTURY ON

            THIS.Caption = "Invent" + CHR(225) + "rio n" + CHR(186) + " " + TRANSFORM(THIS.this_nNumBalanco)

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            THIS.this_oRelatorio = CREATEOBJECT("SigReIr1BO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SigReIr1BO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
            ELSE
                THIS.this_oRelatorio.this_nNumBalanco = THIS.this_nNumBalanco

                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")

                IF THIS.this_oRelatorio.InicializarDados()
                    THIS.AplicarRegraGesInd()
                    THIS.AtualizarEstadoControles()
                    THIS.Visible = .T.
                    loc_lSucesso = .T.
                ELSE
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro() + CHR(13) + ;
                        "Invent" + CHR(225) + "rio: " + TRANSFORM(THIS.this_nNumBalanco), "Erro")
                ENDIF
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
    * ConfigurarCabecalho - Container escuro superior com t" + CHR(237) + "tulo
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
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = THIS.Caption
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
                .Caption   = THIS.Caption
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
    * ConfigurarBotoes - CommandGroup com 4 bot" + CHR(245) + "es do relat" + CHR(243) + "rio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = 0
            .Left          = 727
            .Width         = 273
            .Height        = 80
            .ButtonCount   = 4
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderColor   = RGB(136, 189, 188)
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.

            WITH .Buttons(1)
                .Top             = 5
                .Left            = 5
                .Width           = 65
                .Height          = 70
                .Caption         = "Visualizar"
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Visualizar Relat" + CHR(243) + "rio no V" + CHR(237) + "deo"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(2)
                .Top             = 5
                .Left            = 71
                .Width           = 65
                .Height          = 70
                .Caption         = "Imprimir"
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Imprimir Relat" + CHR(243) + "rio"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(3)
                .Top             = 5
                .Left            = 137
                .Width           = 65
                .Height          = 70
                .Caption         = "Excel"
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_excel_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Exportar para Excel"
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
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "[Esc] Encerrar"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com 1 p" + CHR(225) + "gina (Filtros)
    *   Form REPORT usa layout FLAT: sem page de lista + page de dados CRUD.
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
    * ConfigurarPaginaLista - Adiciona controles de filtro na Page1
    *   Posi" + CHR(231) + CHR(245) + "es originais SIGREIR1 (800x347) adaptadas:
    *   Top na Page = Top original (coordenadas do SCX original)
    *   Esquerda mantida (form 800->1000 adiciona margem direita)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- Label "Relat" + CHR(243) + "rio :"
        loc_oPg.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPg.lbl_4c_Label1
            .Top       = 88
            .Left      = 89
            .Width     = 58
            .Height    = 15
            .Caption   = "Relat" + CHR(243) + "rio :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup TipoRelatorio (5 op" + CHR(231) + CHR(245) + "es)
        *   Original: top=84, left=140, width=245, height=62
        loc_oPg.AddObject("obj_4c_TipoRelatorio", "OptionGroup")
        loc_oPg.obj_4c_TipoRelatorio.ButtonCount = 5
        WITH loc_oPg.obj_4c_TipoRelatorio
            .Top           = 84
            .Left          = 140
            .Width         = 280
            .Height        = 62
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .Value         = 1
            .Visible       = .T.
        ENDWITH
        WITH loc_oPg.obj_4c_TipoRelatorio.Buttons(1)
            .Caption   = "Resumo p/ Produto"
            .Left      = 5
            .Top       = 5
            .Width     = 115
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.obj_4c_TipoRelatorio.Buttons(2)
            .Caption   = "Resumo Geral"
            .Left      = 156
            .Top       = 5
            .Width     = 100
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.obj_4c_TipoRelatorio.Buttons(3)
            .Caption   = "Anal" + CHR(237) + "tico"
            .Left      = 5
            .Top       = 24
            .Width     = 65
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.obj_4c_TipoRelatorio.Buttons(4)
            .Caption   = "Etiqueta"
            .Left      = 156
            .Top       = 24
            .Width     = 65
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.obj_4c_TipoRelatorio.Buttons(5)
            .Caption   = "Estoque x Leitura"
            .Left      = 5
            .Top       = 43
            .Width     = 110
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Linha separadora (Shape3: top=150)
        loc_oPg.AddObject("shp_4c_Shape3", "Shape")
        WITH loc_oPg.shp_4c_Shape3
            .Top       = 150
            .Left      = 13
            .Height    = 2
            .Width     = 620
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Label "Tipo :" (para TipoAnalitico) (top=162)
        loc_oPg.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPg.lbl_4c_Label4
            .Top       = 162
            .Left      = 112
            .Width     = 35
            .Height    = 15
            .Caption   = "Tipo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup TipoAnalitico (2 op" + CHR(231) + CHR(245) + "es: Produto, Local)
        *   Original: top=157, left=141, width=133, height=25
        loc_oPg.AddObject("obj_4c_TipoAnalitico", "OptionGroup")
        loc_oPg.obj_4c_TipoAnalitico.ButtonCount = 2
        WITH loc_oPg.obj_4c_TipoAnalitico
            .Top           = 157
            .Left          = 141
            .Width         = 146
            .Height        = 25
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .Value         = 1
            .Visible       = .T.
        ENDWITH
        WITH loc_oPg.obj_4c_TipoAnalitico.Buttons(1)
            .Caption   = "Produto"
            .Left      = 5
            .Top       = 5
            .Width     = 62
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.obj_4c_TipoAnalitico.Buttons(2)
            .Caption   = "Local"
            .Left      = 86
            .Top       = 5
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- CheckBox "Imprimir Imagem" (top=160, left=295)
        loc_oPg.AddObject("chk_4c_ChkImpImg", "CheckBox")
        WITH loc_oPg.chk_4c_ChkImpImg
            .Top           = 160
            .Left          = 295
            .Width         = 110
            .Height        = 15
            .Caption       = "Imprimir Imagem"
            .Value         = 0
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackStyle     = 0
            .Alignment     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- Label "Produto :" (top=186, left=94)
        loc_oPg.AddObject("lbl_4c_Lbl_codigo", "Label")
        WITH loc_oPg.lbl_4c_Lbl_codigo
            .Top       = 186
            .Left      = 94
            .Width     = 50
            .Height    = 15
            .Caption   = "Produto :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox c" + CHR(243) + "digo produto (get_cd_codigo -> txt_4c__cd_codigo)
        *   Original: top=181, left=147, width=108, MaxLength=14
        loc_oPg.AddObject("txt_4c__cd_codigo", "TextBox")
        WITH loc_oPg.txt_4c__cd_codigo
            .Top               = 181
            .Left              = 147
            .Width             = 108
            .Height            = 24
            .Value             = ""
            .MaxLength         = 14
            .Format            = "!"
            .FontName          = "Tahoma"
            .FontSize          = 8
            .BackColor         = RGB(255, 255, 255)
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(255, 255, 255)
            .BorderColor       = RGB(36, 84, 155)
            .SpecialEffect     = 1
            .Enabled           = .F.
            .Themes            = .F.
            .Visible           = .T.
        ENDWITH

        *-- TextBox descri" + CHR(231) + CHR(227) + "o produto (get_ds_codigo -> txt_4c__ds_codigo)
        *   Original: top=181, left=257, width=237, MaxLength=40
        loc_oPg.AddObject("txt_4c__ds_codigo", "TextBox")
        WITH loc_oPg.txt_4c__ds_codigo
            .Top               = 181
            .Left              = 257
            .Width             = 237
            .Height            = 24
            .Value             = ""
            .MaxLength         = 40
            .Format            = "!"
            .FontName          = "Tahoma"
            .FontSize          = 8
            .BackColor         = RGB(255, 255, 255)
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(255, 255, 255)
            .BorderColor       = RGB(36, 84, 155)
            .SpecialEffect     = 1
            .Enabled           = .F.
            .Themes            = .F.
            .Visible           = .T.
        ENDWITH

        *-- Label "Local :" (top=212, left=108)
        loc_oPg.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPg.lbl_4c_Label5
            .Top       = 212
            .Left      = 108
            .Width     = 38
            .Height    = 15
            .Caption   = "Local :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox c" + CHR(243) + "digo local (Get_Local -> txt_4c_Local)
        *   Original: top=207, left=147, width=80, MaxLength=10
        loc_oPg.AddObject("txt_4c_Local", "TextBox")
        WITH loc_oPg.txt_4c_Local
            .Top               = 207
            .Left              = 147
            .Width             = 80
            .Height            = 24
            .Value             = ""
            .MaxLength         = 10
            .FontName          = "Tahoma"
            .FontSize          = 8
            .BackColor         = RGB(255, 255, 255)
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(255, 255, 255)
            .BorderColor       = RGB(36, 84, 155)
            .SpecialEffect     = 1
            .Enabled           = .F.
            .Themes            = .F.
            .Visible           = .T.
        ENDWITH

        *-- TextBox descri" + CHR(231) + CHR(227) + "o local (get_Dlocal -> txt_4c__Dlocal)
        *   Original: top=207, left=229, width=237, MaxLength=20
        loc_oPg.AddObject("txt_4c__Dlocal", "TextBox")
        WITH loc_oPg.txt_4c__Dlocal
            .Top               = 207
            .Left              = 229
            .Width             = 237
            .Height            = 24
            .Value             = ""
            .MaxLength         = 20
            .FontName          = "Tahoma"
            .FontSize          = 8
            .BackColor         = RGB(255, 255, 255)
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(255, 255, 255)
            .BorderColor       = RGB(36, 84, 155)
            .SpecialEffect     = 1
            .Enabled           = .F.
            .Themes            = .F.
            .Visible           = .T.
        ENDWITH

        *-- Label "Itens :" (top=242, left=107)
        loc_oPg.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPg.lbl_4c_Label2
            .Top       = 242
            .Left      = 107
            .Width     = 38
            .Height    = 15
            .Caption   = "Itens :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup TipoDiferenca (Todos / Com Diferen" + CHR(231) + "a) - default=2
        *   Original: top=237, left=141, width=178, height=25; Init set value=2
        loc_oPg.AddObject("obj_4c_TipoDiferenca", "OptionGroup")
        loc_oPg.obj_4c_TipoDiferenca.ButtonCount = 2
        WITH loc_oPg.obj_4c_TipoDiferenca
            .Top           = 237
            .Left          = 141
            .Width         = 190
            .Height        = 25
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .Value         = 2
            .Visible       = .T.
        ENDWITH
        WITH loc_oPg.obj_4c_TipoDiferenca.Buttons(1)
            .Caption   = "Todos"
            .Left      = 5
            .Top       = 5
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.obj_4c_TipoDiferenca.Buttons(2)
            .Caption   = "Com Diferen" + CHR(231) + "a"
            .Left      = 85
            .Top       = 5
            .Width     = 95
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Label "Ordem :" (top=242, left=422)
        loc_oPg.AddObject("lbl_4c_LblOrdem", "Label")
        WITH loc_oPg.lbl_4c_LblOrdem
            .Top       = 242
            .Left      = 422
            .Width     = 48
            .Height    = 15
            .Caption   = "Ordem :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup TipoOrdem (Produto / Grupo)
        *   Original: top=236, left=471, width=137, height=27
        loc_oPg.AddObject("obj_4c_TipoOrdem", "OptionGroup")
        loc_oPg.obj_4c_TipoOrdem.ButtonCount = 2
        WITH loc_oPg.obj_4c_TipoOrdem
            .Top           = 236
            .Left          = 471
            .Width         = 147
            .Height        = 27
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .Value         = 1
            .Visible       = .T.
        ENDWITH
        WITH loc_oPg.obj_4c_TipoOrdem.Buttons(1)
            .Caption   = "Produto"
            .Left      = 5
            .Top       = 5
            .Width     = 62
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.obj_4c_TipoOrdem.Buttons(2)
            .Caption   = "Grupo"
            .Left      = 85
            .Top       = 5
            .Width     = 52
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Label "Leitura :" (top=266, left=99)
        loc_oPg.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPg.lbl_4c_Label3
            .Top       = 266
            .Left      = 99
            .Width     = 46
            .Height    = 15
            .Caption   = "Leitura :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup TipoLeitura (Leitura / Releitura)
        *   Original: top=261, left=141, width=151, height=25
        loc_oPg.AddObject("obj_4c_TipoLeitura", "OptionGroup")
        loc_oPg.obj_4c_TipoLeitura.ButtonCount = 2
        WITH loc_oPg.obj_4c_TipoLeitura
            .Top           = 261
            .Left          = 141
            .Width         = 165
            .Height        = 25
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .Value         = 1
            .Visible       = .T.
        ENDWITH
        WITH loc_oPg.obj_4c_TipoLeitura.Buttons(1)
            .Caption   = "Leitura"
            .Left      = 5
            .Top       = 5
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.obj_4c_TipoLeitura.Buttons(2)
            .Caption   = "Releitura"
            .Left      = 85
            .Top       = 5
            .Width     = 70
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Label "C" + CHR(243) + "digo de Barras :" (top=266, left=372)
        loc_oPg.AddObject("lbl_4c_LblBarras", "Label")
        WITH loc_oPg.lbl_4c_LblBarras
            .Top       = 266
            .Left      = 372
            .Width     = 97
            .Height    = 15
            .Caption   = "C" + CHR(243) + "digo de Barras :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup optgBarras (Sim / N" + CHR(227) + "o) - default=1 (Sim)
        *   Original: top=260, left=471, width=131, height=27
        loc_oPg.AddObject("obj_4c_OptgBarras", "OptionGroup")
        loc_oPg.obj_4c_OptgBarras.ButtonCount = 2
        WITH loc_oPg.obj_4c_OptgBarras
            .Top           = 260
            .Left          = 471
            .Width         = 145
            .Height        = 27
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .Value         = 1
            .Visible       = .T.
        ENDWITH
        WITH loc_oPg.obj_4c_OptgBarras.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 5
            .Width     = 45
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.obj_4c_OptgBarras.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 85
            .Top       = 5
            .Width     = 45
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Label "Pre" + CHR(231) + "o Custo :" (top=290, left=74)
        loc_oPg.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPg.lbl_4c_Label6
            .Top       = 290
            .Left      = 74
            .Width     = 72
            .Height    = 15
            .Caption   = "Pre" + CHR(231) + "o Custo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup optgTpCusto (Sim / N" + CHR(227) + "o) - default=1 (Sim)
        *   Original: top=284, left=141, width=131, height=27
        loc_oPg.AddObject("obj_4c_OptgTpCusto", "OptionGroup")
        loc_oPg.obj_4c_OptgTpCusto.ButtonCount = 2
        WITH loc_oPg.obj_4c_OptgTpCusto
            .Top           = 284
            .Left          = 141
            .Width         = 145
            .Height        = 27
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .Value         = 1
            .Visible       = .T.
        ENDWITH
        WITH loc_oPg.obj_4c_OptgTpCusto.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 5
            .Width     = 45
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.obj_4c_OptgTpCusto.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 85
            .Top       = 5
            .Width     = 45
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Label "Pre" + CHR(231) + "o Venda :" (top=290, left=394)
        loc_oPg.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPg.lbl_4c_Label7
            .Top       = 290
            .Left      = 394
            .Width     = 74
            .Height    = 15
            .Caption   = "Pre" + CHR(231) + "o Venda :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup optgTpVenda (Sim / N" + CHR(227) + "o) - default=1 (Sim)
        *   Original: top=284, left=471, width=131, height=27
        loc_oPg.AddObject("obj_4c_OptgTpVenda", "OptionGroup")
        loc_oPg.obj_4c_OptgTpVenda.ButtonCount = 2
        WITH loc_oPg.obj_4c_OptgTpVenda
            .Top           = 284
            .Left          = 471
            .Width         = 145
            .Height        = 27
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .Value         = 1
            .Visible       = .T.
        ENDWITH
        WITH loc_oPg.obj_4c_OptgTpVenda.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 5
            .Width     = 45
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.obj_4c_OptgTpVenda.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 85
            .Top       = 5
            .Width     = 45
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Label "Descri" + CHR(231) + CHR(227) + "o do Produto :" (top=314, left=30)
        loc_oPg.AddObject("lbl_4c_LblDescricao", "Label")
        WITH loc_oPg.lbl_4c_LblDescricao
            .Top       = 314
            .Left      = 30
            .Width     = 115
            .Height    = 15
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o do Produto :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup optgDescricao (Sim / N" + CHR(227) + "o) - default=2 (N" + CHR(227) + "o)
        *   Original: top=308, left=141, width=131, height=27, Value=2
        loc_oPg.AddObject("obj_4c_OptgDescricao", "OptionGroup")
        loc_oPg.obj_4c_OptgDescricao.ButtonCount = 2
        WITH loc_oPg.obj_4c_OptgDescricao
            .Top           = 308
            .Left          = 141
            .Width         = 145
            .Height        = 27
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .Value         = 2
            .Visible       = .T.
        ENDWITH
        WITH loc_oPg.obj_4c_OptgDescricao.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 5
            .Width     = 45
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.obj_4c_OptgDescricao.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 85
            .Top       = 5
            .Width     = 45
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Label "Localiza" + CHR(231) + CHR(227) + "o :" (top=314, left=400)
        loc_oPg.AddObject("lbl_4c_LblLocalizacao", "Label")
        WITH loc_oPg.lbl_4c_LblLocalizacao
            .Top       = 314
            .Left      = 400
            .Width     = 72
            .Height    = 15
            .Caption   = "Localiza" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup optgLocalizacao (Sim / N" + CHR(227) + "o) - default=2 (N" + CHR(227) + "o)
        *   Original: top=308, left=471, width=131, height=27, Value=2
        loc_oPg.AddObject("obj_4c_OptgLocalizacao", "OptionGroup")
        loc_oPg.obj_4c_OptgLocalizacao.ButtonCount = 2
        WITH loc_oPg.obj_4c_OptgLocalizacao
            .Top           = 308
            .Left          = 471
            .Width         = 145
            .Height        = 27
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .Value         = 2
            .Visible       = .T.
        ENDWITH
        WITH loc_oPg.obj_4c_OptgLocalizacao.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 5
            .Width     = 45
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.obj_4c_OptgLocalizacao.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 85
            .Top       = 5
            .Width     = 45
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - BINDEVENTs dos controles interativos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- TipoRelatorio e TipoAnalitico disparam atualiza" + CHR(231) + CHR(227) + "o de estado
        BINDEVENT(loc_oPg.obj_4c_TipoRelatorio, "InteractiveChange", THIS, "TipoRelatorioChange")
        BINDEVENT(loc_oPg.obj_4c_TipoAnalitico, "InteractiveChange", THIS, "TipoAnaliticoChange")

        *-- F4=115, ENTER=13, TAB=9
        BINDEVENT(loc_oPg.txt_4c__cd_codigo, "KeyPress", THIS, "TeclaCdCodigo")
        BINDEVENT(loc_oPg.txt_4c__ds_codigo, "KeyPress", THIS, "TeclaDsCodigo")
        BINDEVENT(loc_oPg.txt_4c_Local,      "KeyPress", THIS, "TeclaLocal")
        BINDEVENT(loc_oPg.txt_4c__Dlocal,    "KeyPress", THIS, "TeclaDLocal")

        BINDEVENT(loc_oPg.txt_4c__cd_codigo, "DblClick", THIS, "AbrirBuscaCdCodigo")
        BINDEVENT(loc_oPg.txt_4c__ds_codigo, "DblClick", THIS, "AbrirBuscaDsCodigo")
        BINDEVENT(loc_oPg.txt_4c_Local,      "DblClick", THIS, "AbrirBuscaLocal")
        BINDEVENT(loc_oPg.txt_4c__Dlocal,    "DblClick", THIS, "AbrirBuscaDLocal")
    ENDPROC

    *==========================================================================
    * ATUALIZA" + CHR(199) + CHR(195) + "O DE ESTADO DOS CONTROLES
    *==========================================================================

    *--------------------------------------------------------------------------
    * TipoRelatorioChange - Habilita/desabilita controles por tipo de relat" + CHR(243) + "rio
    *   Original: TipoRelatorio.InteractiveChange
    *--------------------------------------------------------------------------
    PROCEDURE TipoRelatorioChange()
        LOCAL loc_oPg, loc_nTp, loc_nTpAnal
        TRY
            loc_oPg    = THIS.pgf_4c_Paginas.Page1
            loc_nTp    = loc_oPg.obj_4c_TipoRelatorio.Value
            loc_nTpAnal = loc_oPg.obj_4c_TipoAnalitico.Value

            *-- TipoDiferenca: apenas Resumo por Produto (1)
            loc_oPg.obj_4c_TipoDiferenca.SetAll("Enabled", (loc_nTp = 1), "OptionButton")

            *-- TipoLeitura e TipoAnalitico: apenas Anal" + CHR(237) + "tico (3)
            loc_oPg.obj_4c_TipoLeitura.SetAll("Enabled",   (loc_nTp = 3), "OptionButton")
            loc_oPg.obj_4c_TipoAnalitico.SetAll("Enabled", (loc_nTp = 3), "OptionButton")

            *-- TipoOrdem: apenas Resumo por Produto (1)
            loc_oPg.obj_4c_TipoOrdem.SetAll("Enabled",     (loc_nTp = 1), "OptionButton")

            *-- OptgTpCusto: Resumo por Produto (1) ou Estoque x Leitura (5)
            loc_oPg.obj_4c_OptgTpCusto.SetAll("Enabled",    INLIST(loc_nTp, 1, 5), "OptionButton")

            *-- OptgTpVenda: apenas Resumo por Produto (1)
            loc_oPg.obj_4c_OptgTpVenda.SetAll("Enabled",    (loc_nTp = 1), "OptionButton")

            *-- OptgDescricao: Resumo por Produto (1) ou Etiqueta (4)
            loc_oPg.obj_4c_OptgDescricao.SetAll("Enabled",  INLIST(loc_nTp, 1, 4), "OptionButton")

            *-- OptgBarras: apenas Resumo por Produto (1)
            loc_oPg.obj_4c_OptgBarras.SetAll("Enabled",     (loc_nTp = 1), "OptionButton")

            *-- OptgLocalizacao: apenas Resumo por Produto (1)
            loc_oPg.obj_4c_OptgLocalizacao.SetAll("Enabled", (loc_nTp = 1), "OptionButton")

            *-- Campos produto: apenas Anal" + CHR(237) + "tico (3) + modo Produto (1)
            loc_oPg.txt_4c__cd_codigo.Enabled = (loc_nTp = 3 AND loc_nTpAnal = 1)
            loc_oPg.txt_4c__ds_codigo.Enabled = (loc_nTp = 3 AND loc_nTpAnal = 1)

            *-- Campos local: apenas Anal" + CHR(237) + "tico (3) + modo Local (2)
            loc_oPg.txt_4c_Local.Enabled   = (loc_nTp = 3 AND loc_nTpAnal = 2)
            loc_oPg.txt_4c__Dlocal.Enabled = (loc_nTp = 3 AND loc_nTpAnal = 2)

            *-- chkImpImg: apenas Etiqueta (4) ou Estoque x Leitura (5)
            IF !INLIST(loc_nTp, 4, 5)
                loc_oPg.chk_4c_ChkImpImg.Value = 0
            ENDIF
            loc_oPg.chk_4c_ChkImpImg.Enabled = INLIST(loc_nTp, 4, 5)

            THIS.AtualizarReadOnly()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro TipoRelatorioChange")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TipoAnaliticoChange - Atualiza campos de c" + CHR(243) + "digo/local por modo anal" + CHR(237) + "tico
    *   Original: TipoAnalitico.InteractiveChange (impl" + CHR(237) + "cito no legado)
    *--------------------------------------------------------------------------
    PROCEDURE TipoAnaliticoChange()
        LOCAL loc_oPg, loc_nTp, loc_nTpAnal
        TRY
            loc_oPg    = THIS.pgf_4c_Paginas.Page1
            loc_nTp    = loc_oPg.obj_4c_TipoRelatorio.Value
            loc_nTpAnal = loc_oPg.obj_4c_TipoAnalitico.Value

            loc_oPg.txt_4c__cd_codigo.Enabled = (loc_nTp = 3 AND loc_nTpAnal = 1)
            loc_oPg.txt_4c__ds_codigo.Enabled = (loc_nTp = 3 AND loc_nTpAnal = 1)
            loc_oPg.txt_4c_Local.Enabled      = (loc_nTp = 3 AND loc_nTpAnal = 2)
            loc_oPg.txt_4c__Dlocal.Enabled    = (loc_nTp = 3 AND loc_nTpAnal = 2)

            THIS.AtualizarReadOnly()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro TipoAnaliticoChange")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarReadOnly - L" + CHR(243) + "gica When original dos campos de descri" + CHR(231) + CHR(227) + "o
    *   get_ds_codigo.When: Return(Empty(Get_Cd_Codigo.Value))
    *   get_Dlocal.When:    Return(Empty(Get_Local.Value))
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarReadOnly()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            loc_oPg.txt_4c__ds_codigo.ReadOnly = !EMPTY(ALLTRIM(loc_oPg.txt_4c__cd_codigo.Value))
            loc_oPg.txt_4c__Dlocal.ReadOnly    = !EMPTY(ALLTRIM(loc_oPg.txt_4c_Local.Value))
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AtualizarReadOnly")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarRegraGesInd - Oculta controles extras quando GesInd = 1
    *   Original: If CsSigCdPam.GesInd = 1 -> ocultar TipoOrdem/Descricao/Barras/Localiz
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarRegraGesInd()
        LOCAL loc_oPg
        TRY
            IF !USED("CsSigCdPam")
                RETURN
            ENDIF
            SELECT CsSigCdPam
            GO TOP
            IF !EOF() AND CsSigCdPam.GesInd = 1
                loc_oPg = THIS.pgf_4c_Paginas.Page1
                loc_oPg.obj_4c_TipoOrdem.Visible       = .F.
                loc_oPg.obj_4c_OptgDescricao.Visible   = .F.
                loc_oPg.obj_4c_OptgBarras.Visible      = .F.
                loc_oPg.obj_4c_OptgLocalizacao.Visible = .F.
                loc_oPg.lbl_4c_LblOrdem.Visible        = .F.
                loc_oPg.lbl_4c_LblDescricao.Visible    = .F.
                loc_oPg.lbl_4c_LblBarras.Visible       = .F.
                loc_oPg.lbl_4c_LblLocalizacao.Visible  = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AplicarRegraGesInd")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Copia valores dos controles para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            WITH THIS.this_oRelatorio
                .this_nTipoRelatorio  = loc_oPg.obj_4c_TipoRelatorio.Value
                .this_nTipoAnalitico  = loc_oPg.obj_4c_TipoAnalitico.Value
                .this_nTipoDiferenca  = loc_oPg.obj_4c_TipoDiferenca.Value
                .this_nTipoLeitura    = loc_oPg.obj_4c_TipoLeitura.Value
                .this_nTipoOrdem      = loc_oPg.obj_4c_TipoOrdem.Value
                .this_cCodProduto     = ALLTRIM(loc_oPg.txt_4c__cd_codigo.Value)
                .this_cDesProduto     = ALLTRIM(loc_oPg.txt_4c__ds_codigo.Value)
                .this_cLocal          = ALLTRIM(loc_oPg.txt_4c_Local.Value)
                .this_cDesLocal       = ALLTRIM(loc_oPg.txt_4c__Dlocal.Value)
                .this_nTpCusto        = loc_oPg.obj_4c_OptgTpCusto.Value
                .this_nTpVenda        = loc_oPg.obj_4c_OptgTpVenda.Value
                .this_nDescricao      = loc_oPg.obj_4c_OptgDescricao.Value
                .this_nBarras         = loc_oPg.obj_4c_OptgBarras.Value
                .this_nLocalizacao    = loc_oPg.obj_4c_OptgLocalizacao.Value
                .this_lImprimirImagem = (loc_oPg.chk_4c_ChkImpImg.Value = 1)
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro FormParaRelatorio")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BOT" + CHR(213) + "ES DE A" + CHR(199) + CHR(195) + "O
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualiza relat" + CHR(243) + "rio em preview
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        TRY
            THIS.FormParaRelatorio()
            THIS.this_oRelatorio.Visualizar()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Imprime relat" + CHR(243) + "rio com di" + CHR(225) + "logo de impressora
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        TRY
            THIS.FormParaRelatorio()
            THIS.this_oRelatorio.Imprimir()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Excel n" + CHR(227) + "o dispon" + CHR(237) + "vel (relat" + CHR(243) + "rio de balan" + CHR(231) + "o usa FRX pr" + CHR(243) + "prio)
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        MsgAviso("Exporta" + CHR(231) + CHR(227) + "o para Excel n" + CHR(227) + "o dispon" + CHR(237) + ;
            "vel neste relat" + CHR(243) + "rio." + CHR(13) + ;
            "Use Visualizar ou Imprimir para gerar o relat" + CHR(243) + "rio.", ;
            "Excel")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Fecha o formul" + CHR(225) + "rio
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * HANDLERS DE TECLADO - KeyPress via BINDEVENT
    * F4=115, ENTER=13, TAB=9
    *==========================================================================

    PROCEDURE TeclaCdCodigo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCdCodigo()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdCodigo()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsCodigo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDsCodigo()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDsCodigo()
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

    PROCEDURE TeclaDLocal(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDLocal()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDLocal()
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUPS - PRODUTO (SigCdPro, campos CPros e DPros)
    *==========================================================================

    *--------------------------------------------------------------------------
    * AbrirBuscaCdCodigo - Lookup de produto pelo c" + CHR(243) + "digo (CPros)
    *   Original: get_cd_codigo.Valid -> fwbuscaext SigCdPro CPros
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaCdCodigo()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c__cd_codigo.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdPro", "cursor_4c_BuscaPro", "CPros", loc_cValor, ;
            "Produtos", .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c__cd_codigo.Value = ALLTRIM(cursor_4c_BuscaPro.CPros)
                loc_oPg.txt_4c__ds_codigo.Value = ALLTRIM(cursor_4c_BuscaPro.DPros)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPro")
                        loc_oPg.txt_4c__cd_codigo.Value = ALLTRIM(cursor_4c_BuscaPro.CPros)
                        loc_oPg.txt_4c__ds_codigo.Value = ALLTRIM(cursor_4c_BuscaPro.DPros)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaPro")
            USE IN cursor_4c_BuscaPro
        ENDIF
        THIS.AtualizarReadOnly()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaDsCodigo - Lookup de produto pela descri" + CHR(231) + CHR(227) + "o (DPros)
    *   Original: get_ds_codigo.Valid -> fwbuscaext SigCdPro DPros
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaDsCodigo()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c__ds_codigo.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdPro", "cursor_4c_BuscaPro", "DPros", loc_cValor, ;
            "Produtos", .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c__ds_codigo.Value = ALLTRIM(cursor_4c_BuscaPro.DPros)
                loc_oPg.txt_4c__cd_codigo.Value = ALLTRIM(cursor_4c_BuscaPro.CPros)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPro")
                        loc_oPg.txt_4c__ds_codigo.Value = ALLTRIM(cursor_4c_BuscaPro.DPros)
                        loc_oPg.txt_4c__cd_codigo.Value = ALLTRIM(cursor_4c_BuscaPro.CPros)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaPro")
            USE IN cursor_4c_BuscaPro
        ENDIF
        THIS.AtualizarReadOnly()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCdCodigo - Valida c" + CHR(243) + "digo digitado e preenche descri" + CHR(231) + CHR(227) + "o
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarCdCodigo()
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c__cd_codigo.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c__ds_codigo.Value = ""
            THIS.AtualizarReadOnly()
            RETURN
        ENDIF
        loc_cSQL    = "SELECT CPros, DPros FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProVal")
        IF loc_nResult > 0
            SELECT cursor_4c_ProVal
            IF !EOF()
                loc_oPg.txt_4c__ds_codigo.Value = ALLTRIM(cursor_4c_ProVal.DPros)
            ELSE
                loc_oPg.txt_4c__ds_codigo.Value = ""
                THIS.AbrirBuscaCdCodigo()
            ENDIF
        ELSE
            loc_oPg.txt_4c__ds_codigo.Value = ""
            THIS.AbrirBuscaCdCodigo()
        ENDIF
        IF USED("cursor_4c_ProVal")
            USE IN cursor_4c_ProVal
        ENDIF
        THIS.AtualizarReadOnly()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDsCodigo - Valida descri" + CHR(231) + CHR(227) + "o digitada e preenche c" + CHR(243) + "digo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDsCodigo()
        LOCAL loc_cValor, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c__ds_codigo.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c__cd_codigo.Value = ""
            THIS.AtualizarReadOnly()
            RETURN
        ENDIF
        THIS.AbrirBuscaDsCodigo()
        THIS.AtualizarReadOnly()
    ENDPROC

    *==========================================================================
    * LOOKUPS - LOCAL (SigPrLcl, campos codigos e descricaos)
    *==========================================================================

    *--------------------------------------------------------------------------
    * AbrirBuscaLocal - Lookup de local pelo c" + CHR(243) + "digo (codigos)
    *   Original: Get_Local.Valid -> fwbuscaext SigPrLcl codigos
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaLocal()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Local.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigPrLcl", "cursor_4c_BuscaLocal", "codigos", loc_cValor, ;
            "Locais", .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_Local.Value   = ALLTRIM(cursor_4c_BuscaLocal.codigos)
                loc_oPg.txt_4c__Dlocal.Value = ALLTRIM(cursor_4c_BuscaLocal.descricaos)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLocal")
                        loc_oPg.txt_4c_Local.Value   = ALLTRIM(cursor_4c_BuscaLocal.codigos)
                        loc_oPg.txt_4c__Dlocal.Value = ALLTRIM(cursor_4c_BuscaLocal.descricaos)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaLocal")
            USE IN cursor_4c_BuscaLocal
        ENDIF
        THIS.AtualizarReadOnly()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaDLocal - Lookup de local pela descri" + CHR(231) + CHR(227) + "o (descricaos)
    *   Original: get_Dlocal.Valid -> fwbuscaext SigPrLcl descricaos
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaDLocal()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c__Dlocal.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigPrLcl", "cursor_4c_BuscaLocal", "descricaos", loc_cValor, ;
            "Locais", .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c__Dlocal.Value = ALLTRIM(cursor_4c_BuscaLocal.descricaos)
                loc_oPg.txt_4c_Local.Value   = ALLTRIM(cursor_4c_BuscaLocal.codigos)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLocal")
                        loc_oPg.txt_4c__Dlocal.Value = ALLTRIM(cursor_4c_BuscaLocal.descricaos)
                        loc_oPg.txt_4c_Local.Value   = ALLTRIM(cursor_4c_BuscaLocal.codigos)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaLocal")
            USE IN cursor_4c_BuscaLocal
        ENDIF
        THIS.AtualizarReadOnly()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarLocal - Valida c" + CHR(243) + "digo de local digitado e preenche descri" + CHR(231) + CHR(227) + "o
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarLocal()
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Local.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c__Dlocal.Value = ""
            THIS.AtualizarReadOnly()
            RETURN
        ENDIF
        loc_cSQL    = "SELECT codigos, descricaos FROM SigPrLcl WHERE codigos = " + EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LclVal")
        IF loc_nResult > 0
            SELECT cursor_4c_LclVal
            IF !EOF()
                loc_oPg.txt_4c__Dlocal.Value = ALLTRIM(cursor_4c_LclVal.descricaos)
            ELSE
                loc_oPg.txt_4c__Dlocal.Value = ""
                THIS.AbrirBuscaLocal()
            ENDIF
        ELSE
            loc_oPg.txt_4c__Dlocal.Value = ""
            THIS.AbrirBuscaLocal()
        ENDIF
        IF USED("cursor_4c_LclVal")
            USE IN cursor_4c_LclVal
        ENDIF
        THIS.AtualizarReadOnly()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDLocal - Valida descri" + CHR(231) + CHR(227) + "o de local digitada e preenche c" + CHR(243) + "digo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDLocal()
        LOCAL loc_cValor, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c__Dlocal.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_Local.Value = ""
            THIS.AtualizarReadOnly()
            RETURN
        ENDIF
        THIS.AbrirBuscaDLocal()
        THIS.AtualizarReadOnly()
    ENDPROC

    *==========================================================================
    * COMPATIBILIDADE COM FORMBASE
    *==========================================================================

    PROCEDURE AtualizarEstadoControles()
        THIS.TipoRelatorioChange()
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Restaura filtros para valores padrao (chamado por FormBase)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
                RETURN
            ENDIF
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            loc_oPg.obj_4c_TipoRelatorio.Value   = 1
            loc_oPg.obj_4c_TipoAnalitico.Value   = 1
            loc_oPg.obj_4c_TipoDiferenca.Value   = 2
            loc_oPg.obj_4c_TipoLeitura.Value     = 1
            loc_oPg.obj_4c_TipoOrdem.Value       = 1
            loc_oPg.obj_4c_OptgTpCusto.Value     = 1
            loc_oPg.obj_4c_OptgTpVenda.Value     = 1
            loc_oPg.obj_4c_OptgDescricao.Value   = 2
            loc_oPg.obj_4c_OptgBarras.Value      = 1
            loc_oPg.obj_4c_OptgLocalizacao.Value = 2
            loc_oPg.chk_4c_ChkImpImg.Value       = 0
            loc_oPg.txt_4c__cd_codigo.Value      = ""
            loc_oPg.txt_4c__ds_codigo.Value      = ""
            loc_oPg.txt_4c_Local.Value           = ""
            loc_oPg.txt_4c__Dlocal.Value         = ""
            THIS.TipoRelatorioChange()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita controles de filtro conforme estado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        TRY
            THIS.TipoRelatorioChange()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro HabilitarCampos")
        ENDTRY
    ENDPROC

    PROCEDURE CarregarLista()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF VARTYPE(loc_oPg) = "O" AND PEMSTATUS(loc_oPg, "txt_4c__cd_codigo", 5)
                loc_oPg.txt_4c__cd_codigo.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN .T.
    ENDPROC

    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_oPgf, loc_oPg
        TRY
            loc_oPgf = THIS.pgf_4c_Paginas
            IF VARTYPE(loc_oPgf) != "O"
                RETURN
            ENDIF
            loc_oPgf.ActivePage = 1
            loc_oPg = loc_oPgf.Pages(1)
            IF VARTYPE(loc_oPg) = "O" AND PEMSTATUS(loc_oPg, "txt_4c__cd_codigo", 5)
                loc_oPg.txt_4c__cd_codigo.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AlternarPagina")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg
        TRY
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                RETURN
            ENDIF
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            WITH THIS.this_oRelatorio
                loc_oPg.obj_4c_TipoRelatorio.Value   = .this_nTipoRelatorio
                loc_oPg.obj_4c_TipoAnalitico.Value   = .this_nTipoAnalitico
                loc_oPg.obj_4c_TipoDiferenca.Value   = .this_nTipoDiferenca
                loc_oPg.obj_4c_TipoLeitura.Value     = .this_nTipoLeitura
                loc_oPg.obj_4c_TipoOrdem.Value       = .this_nTipoOrdem
                loc_oPg.txt_4c__cd_codigo.Value      = .this_cCodProduto
                loc_oPg.txt_4c__ds_codigo.Value      = .this_cDesProduto
                loc_oPg.txt_4c_Local.Value           = .this_cLocal
                loc_oPg.txt_4c__Dlocal.Value         = .this_cDesLocal
                loc_oPg.obj_4c_OptgTpCusto.Value     = .this_nTpCusto
                loc_oPg.obj_4c_OptgTpVenda.Value     = .this_nTpVenda
                loc_oPg.obj_4c_OptgDescricao.Value   = .this_nDescricao
                loc_oPg.obj_4c_OptgBarras.Value      = .this_nBarras
                loc_oPg.obj_4c_OptgLocalizacao.Value = .this_nLocalizacao
                loc_oPg.chk_4c_ChkImpImg.Value       = .this_lImprimirImagem
            ENDWITH
            THIS.TipoRelatorioChange()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BOParaForm")
        ENDTRY
    ENDPROC

    PROCEDURE AjustarBotoesPorModo()
        TRY
            IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
                THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.
                THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
                THIS.cmg_4c_Botoes.Buttons(3).Enabled = .T.
                THIS.cmg_4c_Botoes.Buttons(4).Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE BtnIncluirClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnAlterarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnExcluirClick()
        MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + ;
            "vel em relat" + CHR(243) + "rios." + CHR(13) + ;
            "Use Visualizar ou Imprimir para gerar o relat" + CHR(243) + "rio.", ;
            "Aten" + CHR(231) + CHR(227) + "o")
    ENDPROC

    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.BtnSairClick()
    ENDPROC

    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera refer" + CHR(234) + "ncia ao BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigReIr1BO.prg):
*==============================================================================
* SIGREIR1BO.PRG
* Business Object para Relatorio de Balanco (Inventario)
* Formulario original: SIGREIR1 (frmrelatorio)
*
* Herda de RelatorioBase (NAO BusinessBase)
* Tipos de relatorio:
*   1 = Resumo por Produto
*   2 = Resumo Geral
*   3 = Analitico
*   4 = Etiqueta
*   5 = Estoque x Leitura
*
* FASE 2: Adicionados PrepararDados, InicializarDados, Visualizar, Imprimir,
*         ConverteMoe, ProcessarResumoGeral e metodos auxiliares
*==============================================================================

DEFINE CLASS SigReIr1BO AS RelatorioBase

    *-- Parametro do balanco (numero do inventario a processar)
    this_nNumBalanco     = 0

    *-- Tipo de relatorio selecionado (TipoRelatorio.Value)
    *-- 1=Resumo p/Produto, 2=Resumo Geral, 3=Analitico, 4=Etiqueta, 5=Estoque x Leitura
    this_nTipoRelatorio  = 1

    *-- Tipo analitico (TipoAnalitico.Value): 1=Produto, 2=Local
    this_nTipoAnalitico  = 1

    *-- Tipo de ordem (TipoOrdem.Value): 1=Produto, 2=Grupo
    this_nTipoOrdem      = 1

    *-- Tipo de diferenca (TipoDiferenca.Value): 1=Todos, 2=Com Diferenca
    this_nTipoDiferenca  = 2

    *-- Tipo de leitura (TipoLeitura.Value): 1=Leitura, 2=Releitura
    this_nTipoLeitura    = 1

    *-- Produto filtro (Get_Cd_Codigo / Get_Ds_Codigo)
    this_cCodProduto     = ""
    this_cDesProduto     = ""

    *-- Local filtro (Get_Local / get_Dlocal)
    this_cLocal          = ""
    this_cDesLocal       = ""

    *-- OptGTpCusto.Value: 1=Sim (exibir preco custo), 2=Nao
    this_nTpCusto        = 1

    *-- OptGTpVenda.Value: 1=Sim (exibir preco venda), 2=Nao
    this_nTpVenda        = 1

    *-- OptGDescricao.Value: 1=Sim, 2=Nao (padrao Nao - original Value=2)
    this_nDescricao      = 2

    *-- OptGBarras.Value: 1=Sim (exibir cod. barras), 2=Nao (padrao Sim)
    this_nBarras         = 1

    *-- OptGLocalizacao.Value: 1=Sim, 2=Nao (padrao Nao - original Value=2)
    this_nLocalizacao    = 2

    *-- chkImpImg.Value: imprimir imagem do produto no relatorio
    this_lImprimirImagem = .F.

    *-- Derivado de SigCdBal.trtporpeso: tratar quantidades por peso
    this_lTrataPeso      = .F.

    *-- Calculado durante processamento: layout horizontal (> 120 chars)
    this_lHorizontal     = .F.

    *-- Titulo gerado durante processamento
    this_cTitulo         = ""

    *-- Saldo e saldo por peso do produto (modo Analitico)
    this_nSaldo          = 0
    this_nSaldoPs        = 0

    *-- Cursor principal de dados
    this_cCursorDados    = "cursor_4c_Dados"

    *-- Cache para ConverteMoe (0=inativo, 1=verificar, 2=tabelas carregadas)
    this_nChkConversao1  = 0

    *--------------------------------------------------------------------------
    * Init - Inicializa Business Object de Relatorio de Balanco
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna numero do balanco para auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nNumBalanco)
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarDados - Carrega cursores mestres necessarios
    * Deve ser chamado pelo Form apos definir this_nNumBalanco
    *--------------------------------------------------------------------------
    PROCEDURE InicializarDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT GesInd, TpInstalas, moedaps FROM SigCdPam", "CsSigCdPam")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha CsSigCdPam"
            ELSE
                SELECT CsSigCdPam
                GO TOP

                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT CEmps, Razas FROM SigCdEmp WHERE CEmps = " + ;
                    EscaparSQL(go_4c_Sistema.cCodEmpresa), "CrSigCdEmp")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha CrSigCdEmp"
                ELSE
                    SELECT CrSigCdEmp
                    GO TOP

                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT Codigos, Descrs FROM SigCdGcr", "CrSigCdGcr")
                    IF loc_nResult < 1
                        THIS.this_cMensagemErro = "Falha CrSigCdGcr"
                    ELSE
                        SELECT CrSigCdGcr
                        INDEX ON Codigos TAG Codigos
                        GO TOP

                        loc_cSQL = "SELECT * FROM SigCdBal WHERE Emps = " + ;
                                   EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                                   " AND Codigos = " + TRANSFORM(THIS.this_nNumBalanco)
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CsSigCdBal")
                        IF loc_nResult < 1
                            THIS.this_cMensagemErro = "Falha CsSigCdBal"
                        ELSE
                            SELECT CsSigCdBal
                            GO TOP
                            IF !EOF()
                                IF VARTYPE(CsSigCdBal.trtporpeso) = "L"
                                    THIS.this_lTrataPeso = CsSigCdBal.trtporpeso
                                ELSE
                                    IF VARTYPE(CsSigCdBal.trtporpeso) = "L"
                                        THIS.this_lTrataPeso = CsSigCdBal.trtporpeso
                                    ELSE
                                        IF VARTYPE(CsSigCdBal.trtporpeso) = "L"
                                            THIS.this_lTrataPeso = CsSigCdBal.trtporpeso
                                        ELSE
                                            IF VARTYPE(CsSigCdBal.trtporpeso) = "L"
                                                THIS.this_lTrataPeso = CsSigCdBal.trtporpeso
                                            ELSE
                                                IF VARTYPE(CsSigCdBal.trtporpeso) = "L"
                                                    THIS.this_lTrataPeso = CsSigCdBal.trtporpeso
                                                ELSE
                                                    THIS.this_lTrataPeso = (NVL(CsSigCdBal.trtporpeso, 0) = 1)
                                                ENDIF
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                            loc_lSucesso = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "InicializarDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Coordena processamento do relatorio de balanco
    * Equivale ao procedure "processamento" do form original
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_nTpRelatorio, loc_nNumBal, loc_lcBrancos
        LOCAL loc_cRazao, loc_nResult
        LOCAL loc_cGrupos, loc_cContas, loc_dDataInis, loc_dDataFims
        LOCAL loc_cLocalIs, loc_cLocalFs, loc_cIForIs, loc_cIForFs
        LOCAL loc_cCGruIs, loc_cCGruFs, loc_cCGGruIs, loc_cCGGruFs
        LOCAL loc_nPrecoIs, loc_nPrecoFs, loc_lEncerras

        loc_lSucesso = .F.
        TRY
            *-- Declara variaveis PUBLIC acessadas pelo REPORT FORM .FRX
            PUBLIC lnNumBal, _Empresa, _DProduto, _Saldo, _Leitura, _TipoDif, _Titulo
            PUBLIC _TipoLeitura, _TipoAnal, lnTpOrdem, _Produto, _Local, lcDescricao
            PUBLIC llHorizontal, lnVenda, lnCusto, _TotalnLido, _TotalnEsto, _SaldoPs
            PUBLIC llTrataPeso

            loc_nTpRelatorio = THIS.this_nTipoRelatorio
            loc_nNumBal      = THIS.this_nNumBalanco

            *-- Popula variaveis PUBLIC
            _TipoAnal    = THIS.this_nTipoAnalitico
            lnTpOrdem    = THIS.this_nTipoOrdem
            _TipoDif     = THIS.this_nTipoDiferenca
            _TipoLeitura = THIS.this_nTipoLeitura
            lnCusto      = THIS.this_nTpCusto
            lnVenda      = THIS.this_nTpVenda
            lnNumBal     = loc_nNumBal
            llHorizontal = .F.
            _Produto     = ALLTRIM(THIS.this_cCodProduto)
            _Local       = ALLTRIM(THIS.this_cLocal)
            _DProduto    = "Produto : " + ALLTRIM(THIS.this_cCodProduto) + ;
                           " - " + ALLTRIM(THIS.this_cDesProduto)
            _Leitura     = ""
            _Saldo       = 0
            _SaldoPs     = 0
            _TotalnLido  = 0
            _TotalnEsto  = 0

            *-- Garante cursores mestres carregados
            IF !USED("CsSigCdBal")
                IF !THIS.InicializarDados()
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            llTrataPeso = THIS.this_lTrataPeso

            *-- Monta nome da empresa
            loc_cRazao = ""
            IF USED("CrSigCdEmp")
                SELECT CrSigCdEmp
                GO TOP
                IF !EOF()
                    loc_cRazao = ALLTRIM(CrSigCdEmp.Razas)
                ENDIF
            ENDIF
            _Empresa = ALLTRIM(go_4c_Sistema.cCodEmpresa) + " - " + loc_cRazao

            *-- Cursor cabecalho de imagem
            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF
            CREATE CURSOR CsCabecalho (ImpImagem L(1), TcLinhas M(4))
            INSERT INTO CsCabecalho (ImpImagem) VALUES (THIS.this_lImprimirImagem)

            *-- Cursor relatorio tipo 5
            IF USED("csRelatorio5")
                USE IN csRelatorio5
            ENDIF
            CREATE CURSOR csRelatorio5 (Ps C(20), Mercs C(3), CGrus C(3), CPros C(14), ;
                CBars N(14), CodCors C(4), CodTams C(4), Dpros C(40), Custos N(16,6), ;
                MoeCusFs C(3), Qtds N(16,6), FigJpgs M(4) NULL, OrdImg C(11), ;
                ImpCustos N(1), Totais C(250), Saldos N(16,6), Lidos N(16,6), ;
                Relidos N(16,6), SaldoPs N(16,6), LidoPs N(16,6), RelidoPs N(16,6))
            INDEX ON Ps + CPros + CodCors + CodTams + STR(Cbars, 14) TAG Ordem

            *-- Imagem em branco para relatorios com imagem
            loc_lcBrancos = ADDBS(gc_4c_CaminhoBase) + "BrJpg.JPG"
            IF USED("CrBranco")
                USE IN CrBranco
            ENDIF
            CREATE CURSOR CrBranco (Branco M)
            SELECT CrBranco
            APPEND BLANK
            IF FILE(loc_lcBrancos)
                APPEND MEMO Branco FROM (loc_lcBrancos) OVERWRITE
            ENDIF
            COPY MEMO CrBranco.Branco TO SYS(2023) + "\FBRANCOS.JPG"

            *-- Extrai campos do SigCdBal
            SELECT CsSigCdBal
            GO TOP
            loc_cGrupos   = ALLTRIM(NVL(CsSigCdBal.Grupos,   ""))
            loc_cContas   = ALLTRIM(NVL(CsSigCdBal.Contas,   ""))
            loc_dDataInis = NVL(CsSigCdBal.DataInis, {})
            loc_dDataFims = NVL(CsSigCdBal.DataFims, {})
            loc_cLocalIs  = ALLTRIM(NVL(CsSigCdBal.LocalIs,  ""))
            loc_cLocalFs  = ALLTRIM(NVL(CsSigCdBal.LocalFs,  ""))
            loc_cIForIs   = ALLTRIM(NVL(CsSigCdBal.IForIs,   ""))
            loc_cIForFs   = ALLTRIM(NVL(CsSigCdBal.IForFs,   ""))
            loc_cCGruIs   = ALLTRIM(NVL(CsSigCdBal.CGruIs,   ""))
            loc_cCGruFs   = ALLTRIM(NVL(CsSigCdBal.CGruFs,   ""))
            loc_cCGGruIs  = ALLTRIM(NVL(CsSigCdBal.CGGruIs,  ""))
            loc_cCGGruFs  = ALLTRIM(NVL(CsSigCdBal.CGGruFs,  ""))
            loc_nPrecoIs  = NVL(CsSigCdBal.PrecoIs, 0)
            loc_nPrecoFs  = NVL(CsSigCdBal.PrecoFs, 0)
            loc_lEncerras = NVL(CsSigCdBal.Encerras, .F.)
            IF VARTYPE(CsSigCdBal.trtporpeso) = "L"
                THIS.this_lTrataPeso = CsSigCdBal.trtporpeso
            ELSE
                IF VARTYPE(CsSigCdBal.trtporpeso) = "L"
                    THIS.this_lTrataPeso = CsSigCdBal.trtporpeso
                ELSE
                    IF VARTYPE(CsSigCdBal.trtporpeso) = "L"
                        THIS.this_lTrataPeso = CsSigCdBal.trtporpeso
                    ELSE
                        IF VARTYPE(CsSigCdBal.trtporpeso) = "L"
                            THIS.this_lTrataPeso = CsSigCdBal.trtporpeso
                        ELSE
                            IF VARTYPE(CsSigCdBal.trtporpeso) = "L"
                                THIS.this_lTrataPeso = CsSigCdBal.trtporpeso
                            ELSE
                                THIS.this_lTrataPeso = (NVL(CsSigCdBal.trtporpeso, 0) = 1)
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
            llTrataPeso          = THIS.this_lTrataPeso

            *-- Prepara cursor de filtros
            IF !THIS.PrepararCabecalhoFiltros(loc_cGrupos, loc_cContas, ;
                    loc_dDataInis, loc_dDataFims, loc_cLocalIs, loc_cLocalFs, ;
                    loc_cIForIs, loc_cIForFs, loc_cCGruIs, loc_cCGruFs, ;
                    loc_cCGGruIs, loc_cCGGruFs, loc_nPrecoIs, loc_nPrecoFs)
                loc_lSucesso = .F.
            ENDIF

            *-- Limpa cursores de relatorio anteriores
            IF USED("CrSMoeda")
                USE IN CrSMoeda
            ENDIF
            IF USED("CsRelatorio")
                USE IN CsRelatorio
            ENDIF

            *-- Processa por tipo de relatorio
            DO CASE
                CASE INLIST(loc_nTpRelatorio, 1, 2, 5)
                    IF !THIS.ProcessarResumo(loc_nTpRelatorio, loc_nNumBal, loc_lEncerras)
                        loc_lSucesso = .F.
                    ENDIF

                CASE loc_nTpRelatorio = 3
                    IF !THIS.ProcessarAnalitico(loc_nNumBal)
                        loc_lSucesso = .F.
                    ENDIF

                CASE loc_nTpRelatorio = 4
                    IF !THIS.ProcessarEtiqueta(loc_nNumBal)
                        loc_lSucesso = .F.
                    ENDIF
            ENDCASE

            *-- Processamento adicional para Estoque x Leitura
            IF loc_nTpRelatorio = 5
                THIS.ProcessarEstoqueXLeitura()
            ENDIF

            *-- Posiciona cursor correto para o REPORT FORM
            DO CASE
                CASE loc_nTpRelatorio = 2
                    IF USED("crRel1")
                        SELECT crRel1
                        GO TOP
                    ENDIF

                CASE loc_nTpRelatorio = 5
                    IF USED("csRelatorio5")
                        SELECT csRelatorio5
                        GO TOP
                    ENDIF

                OTHERWISE
                    IF USED("CsRelatorio")
                        SELECT CsRelatorio
                        GO TOP
                        IF lnTpOrdem = 2
                            INDEX ON CGrus + IFors + CPros + Ps TAG Ord1
                            SET ORDER TO Ord1
                        ELSE
                            SET ORDER TO (IIF(loc_nTpRelatorio = 1, "Chave1", ORDER("CsRelatorio")))
                        ENDIF
                        IF loc_nTpRelatorio = 1 .AND. THIS.this_nLocalizacao = 1 .AND. USED("CsResult")
                            SELECT CsResult
                            GO TOP
                        ELSE
                            SELECT CsRelatorio
                            GO TOP
                        ENDIF
                    ENDIF
            ENDCASE

            THIS.this_lHorizontal = llHorizontal
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararCabecalhoFiltros - Cria cursor CsFiltro com dados do cabecalho
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararCabecalhoFiltros(par_cGrupos, par_cContas, ;
            par_dDataInis, par_dDataFims, par_cLocalIs, par_cLocalFs, ;
            par_cIForIs, par_cIForFs, par_cCGruIs, par_cCGruFs, ;
            par_cCGGruIs, par_cCGGruFs, par_nPrecoIs, par_nPrecoFs)
        LOCAL loc_lSucesso, loc_lcDsGrupo, loc_lcDsConta, loc_nResult
        LOCAL loc_cDataInis, loc_cDataFims
        LOCAL loc_FGrupo, loc_FEstoque, loc_FPeriodo, loc_FLocal
        LOCAL loc_FIFor, loc_FCGru, loc_FCGGru, loc_FPreco

        loc_lSucesso  = .F.
        loc_lcDsGrupo = ""
        loc_lcDsConta = ""
        TRY
            *-- Descricao do grupo
            IF !EMPTY(par_cGrupos) .AND. USED("CrSigCdGcr")
                IF SEEK(par_cGrupos, "CrSigCdGcr", "Codigos")
                    loc_lcDsGrupo = ALLTRIM(CrSigCdGcr.descrs)
                ENDIF
            ENDIF

            *-- Descricao da conta
            IF !EMPTY(par_cContas)
                IF USED("TmpCli")
                    USE IN TmpCli
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT iclis, rclis FROM SigCdCli WHERE iclis = " + ;
                    EscaparSQL(par_cContas), "TmpCli")
                IF loc_nResult >= 1
                    SELECT TmpCli
                    GO TOP
                    IF !EOF()
                        loc_lcDsConta = ALLTRIM(TmpCli.RClis)
                    ENDIF
                ELSE
                    THIS.this_cMensagemErro = "Falha TmpCli"
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            IF USED("CsFiltro")
                USE IN CsFiltro
            ENDIF
            CREATE CURSOR CsFiltro (FGrupo C(50), FEstoque C(80), FPeriodo C(60) NULL, ;
                                    FLocal C(60), FIFor C(60), FCGru C(60), FCGGru C(60), FPreco C(60))

            loc_cDataInis = DTOC(par_dDataInis)
            loc_cDataFims = DTOC(par_dDataFims)

            loc_FGrupo   = IIF(!EMPTY(par_cGrupos), ;
                           "     Grupo: " + par_cGrupos + IIF(!EMPTY(loc_lcDsGrupo), " - " + loc_lcDsGrupo, ""), "")
            loc_FEstoque = IIF(!EMPTY(par_cContas), ;
                           "   Estoque: " + par_cContas + IIF(!EMPTY(loc_lcDsConta), " - " + loc_lcDsConta, ""), "")
            loc_FPeriodo = IIF(!EMPTY(loc_cDataInis + loc_cDataFims), ;
                           "   Periodo: " + loc_cDataInis + " " + CHR(224) + " " + loc_cDataFims, "")
            loc_FLocal   = IIF(!EMPTY(par_cLocalIs + par_cLocalFs), ;
                           "     Local: " + par_cLocalIs + " " + CHR(224) + " " + par_cLocalFs, "")
            loc_FIFor    = IIF(!EMPTY(par_cIForIs + par_cIForFs), ;
                           "Fornecedor: " + par_cIForIs + " " + CHR(224) + " " + par_cIForFs, "")
            loc_FCGru    = IIF(!EMPTY(par_cCGruIs + par_cCGruFs), ;
                           "     Grupo: " + par_cCGruIs + " " + CHR(224) + " " + par_cCGruFs, "")
            loc_FCGGru   = IIF(!EMPTY(par_cCGGruIs + par_cCGGruFs), ;
                           "Gde. Grupo: " + par_cCGGruIs + " " + CHR(224) + " " + par_cCGGruFs, "")
            loc_FPreco   = IIF(par_nPrecoIs + par_nPrecoFs > 0, ;
                           "     Pre" + CHR(231) + "o: " + STR(par_nPrecoIs,9,2) + ;
                           " " + CHR(224) + " " + STR(par_nPrecoFs,9,2), "")

            INSERT INTO CsFiltro ;
                (FGrupo, FEstoque, FPeriodo, FLocal, FIFor, FCGru, FCGGru, FPreco) ;
                VALUES (loc_FGrupo, loc_FEstoque, loc_FPeriodo, loc_FLocal, ;
                        loc_FIFor,  loc_FCGru,    loc_FCGGru,   loc_FPreco)

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "PrepararCabecalhoFiltros")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarResumo - Tipos 1 (Resumo Produto), 2 (Geral), 5 (Estoque x Leitura)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarResumo(par_nTpRelatorio, par_nNumBal, par_lEncerras)
        LOCAL loc_lSucesso, loc_nResult, loc_lStrQuery, loc_cOrd
        LOCAL loc_lDecimals, loc_lcFixed, loc_lcEscape, loc_lcTalk
        LOCAL loc_nApu, loc_nEst, loc_nFal, loc_nSob
        LOCAL loc_nValor, loc_nValorPs
        LOCAL loc_nCusto, loc_nVenda, loc_nDescricao, loc_nBarras, loc_nLocali
        LOCAL loc_TcCabecs, loc_TcTraco1s, loc_TcLinhas
        LOCAL loc_nValCusto, loc_llOk, loc_nResEti

        loc_lSucesso = .F.
        loc_nCusto   = THIS.this_nTpCusto
        loc_nVenda   = THIS.this_nTpVenda
        loc_nDescricao = THIS.this_nDescricao
        loc_nBarras    = THIS.this_nBarras
        loc_nLocali    = THIS.this_nLocalizacao
        TRY
            _Titulo = "Relat" + CHR(243) + "rio Resumido do Invent" + CHR(225) + ;
                      "rio n" + CHR(186) + " " + ALLTRIM(STR(par_nNumBal))
            IF par_nTpRelatorio = 5
                _Titulo = "Relat" + CHR(243) + "rio de Estoque x Leitura do Invent" + ;
                          CHR(225) + "rio n" + CHR(186) + " " + ALLTRIM(STR(par_nNumBal))
            ENDIF
            THIS.this_cTitulo = _Titulo

            loc_lDecimals = SET("Decimals")
            loc_lcFixed   = SET("Fixed")
            loc_lcEscape  = SET("Escape")
            loc_lcTalk    = SET("Talk")
            SET ESCAPE OFF
            SET TALK ON
            SET DECIMALS TO 2
            SET FIXED ON

            *-- Carrega cursor Base de SigIvTrB + SigCdPro
            loc_lStrQuery = "SELECT a.Emps,a.Codigos,a.CPros,a.CodCors,a.CodTams,a.Grupos," + ;
                "a.Contas,a.Saldos,a.Lidos,a.Relidos," + ;
                "b.CustoFs,b.MoeCusFs,b.PVens,b.MoeVs,b.FVendas,b.MoePVs,b.DPros," + ;
                "b.IFors,b.Mercs,b.CGrus,b.CBars,b.Reffs,b.CUnis,b.PesoMs," + ;
                "b.Pvens AS upVens,b.CustoFS AS uCustoFS,b.Linhas," + ;
                "c.Etiqs,d.TpCustos AS TpCus,'" + SPACE(10) + "' AS Localis," + ;
                "a.Saldops,a.Lidos AS PLidos,a.Lidops,a.Relidops,b.FigJpgs " + ;
                "FROM SigIvTrB a,SigCdPro b " + ;
                "LEFT JOIN SigCdUni c ON c.CUnis=b.CUnis " + ;
                "LEFT JOIN SigCdLin d ON d.Linhas=b.Linhas " + ;
                "WHERE a.Emps=" + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                " AND a.Codigos=" + TRANSFORM(par_nNumBal) + ;
                " AND b.CPros=a.CPros " + ;
                "ORDER BY a.CPros,a.CIdChaves"
            loc_nResult = SQLEXEC(gnConnHandle, loc_lStrQuery, "Base")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha Base"
                loc_lSucesso = .F.
            ENDIF
            SELECT Base
            GO TOP

            *-- Se balanco nao encerrado, processa historico de SigIvTrH
            IF !par_lEncerras
                SELECT Base
                INDEX ON CPros + CodCors + CodTams + Contas TAG CPros
                REPLACE ALL Lidos WITH 0, Relidos WITH 0, PLidos WITH 0, ;
                            Lidops WITH 0, Relidops WITH 0
                GO TOP

                loc_lStrQuery = "SELECT CPros,CodCors,CodTams,Contas,CBars,Tipos,Qtds," + ;
                    "Localis,Pesos,PesReals " + ;
                    "FROM SigIvTrH " + ;
                    "WHERE Codigos=" + TRANSFORM(par_nNumBal) + ;
                    " AND Emps=" + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                    " ORDER BY CIdChaves"
                loc_nResult = SQLEXEC(gnConnHandle, loc_lStrQuery, "CrTmpHist")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha CrTmpHist"
                    loc_lSucesso = .F.
                ENDIF

                SELECT CrTmpHist
                GO TOP
                SCAN
                    SELECT Base
                    IF !SEEK(CrTmpHist.CPros + CrTmpHist.CodCors + CrTmpHist.CodTams + ;
                             CrTmpHist.Contas, "Base", "CPros")
                        INSERT INTO Base (CPros,CodCors,CodTams,Contas,Emps,Codigos,Localis) ;
                            VALUES (CrTmpHist.CPros, CrTmpHist.CodCors, CrTmpHist.CodTams, ;
                                    CrTmpHist.Contas, go_4c_Sistema.cCodEmpresa, ;
                                    par_nNumBal, CrTmpHist.Localis)
                    ENDIF

                    loc_llOk = .T.
                    IF !EMPTY(CrTmpHist.CBars)
                        loc_nResEti = SQLEXEC(gnConnHandle, ;
                            "SELECT TOP 1 CBars FROM SigIvTrE WHERE CBars=" + ;
                            TRANSFORM(CrTmpHist.CBars), "CrTmpEti")
                        IF loc_nResEti < 1 .OR. EOF("CrTmpEti")
                            loc_nResEti = SQLEXEC(gnConnHandle, ;
                                "SELECT TOP 1 CBars FROM SigCdPro WHERE CBars=" + ;
                                TRANSFORM(CrTmpHist.CBars), "CsTmpPro")
                            IF loc_nResEti < 1 .OR. EOF("CsTmpPro")
                                loc_llOk = .F.
                            ENDIF
                        ENDIF
                    ENDIF

                    IF loc_llOk
                        SELECT Base
                        IF INLIST(CrTmpHist.Tipos, 1, 3)
                            REPLACE Lidos  WITH Lidos  + CrTmpHist.Qtds  IN Base
                            REPLACE PLidos WITH PLidos + CrTmpHist.Pesos IN Base
                            REPLACE Lidops WITH Lidops + CrTmpHist.Pesos IN Base
                        ELSE
                            REPLACE ReLidos  WITH ReLidos  + CrTmpHist.Qtds  IN Base
                            REPLACE ReLidops WITH ReLidops + CrTmpHist.Pesos IN Base
                        ENDIF
                    ENDIF
                    SELECT CrTmpHist
                ENDSCAN
            ENDIF

            IF INLIST(par_nTpRelatorio, 1, 5)
                loc_cOrd = IIF(THIS.this_nTipoOrdem = 1, "a.CPros", "a.CGrus,a.IFors,a.CPros")

                SELECT Base
                GO TOP

                SELECT a.Emps,a.Codigos,a.CPros,a.CodCors,a.CodTams,a.Grupos,a.Contas, ;
                    a.Saldos,a.Lidos,a.Relidos,a.CustoFs, ;
                    a.MoeCusFs,a.MoeVs,a.FVendas,a.MoePVs,a.DPros,a.IFors,a.CGrus,a.Mercs, ;
                    a.CBars,a.CUnis,a.PesoMs,a.Etiqs,a.TpCus, ;
                    a.uCustoFs,a.uPVens,a.Linhas,a.Reffs, ;
                    VAL(STR(a.PVens * (a.Saldos  - IIF(EMPTY(a.Relidos), a.Lidos, a.Relidos )),16,2)) AS PVens, ;
                    VAL(STR(a.PVens * (a.Saldops - IIF(EMPTY(a.Relidops),a.Lidops,a.Relidops)),16,2)) AS PVenPesos, ;
                    loc_nCusto AS TpCustos, loc_nVenda AS TpVendas, ;
                    SPACE(175) AS TcCabecs, SPACE(175) AS TcTraco1s, SPACE(175) AS TcLinhas, ;
                    a.Localis, "1" AS Ps, "1" AS Od, SPACE(8) AS OrdImg, ;
                    a.SaldoPs, a.Plidos, a.Lidops, a.Relidops, a.FigJpgs ;
                FROM Base a ;
                ORDER BY &loc_cOrd ;
                INTO CURSOR CsBase READWRITE

                SELECT CsBase
                GO TOP
                SELECT * FROM CsBase INTO CURSOR CsRelatorio READWRITE

                *-- Corrige custo por tipo e calcula valor x saldo
                SELECT CsRelatorio
                GO TOP
                SCAN
                    loc_nValCusto = CsRelatorio.CustoFs
                    IF NVL(CsRelatorio.TpCus, "") = "2"
                        loc_nValCusto = loc_nValCusto * CsRelatorio.PesoMs
                    ENDIF
                    IF NVL(CsRelatorio.Etiqs, "") = "S"
                        REPLACE CBars WITH 0
                    ENDIF
                    REPLACE CustoFs WITH loc_nValCusto * ;
                        (CsRelatorio.Saldos - IIF(EMPTY(CsRelatorio.Relidos), ;
                         CsRelatorio.Lidos, CsRelatorio.Relidos))
                ENDSCAN

                *-- Totaliza por moeda
                SELECT a.Moecusfs AS Moedas, ;
                       VAL(STR(SUM(a.CustoFs),16,2)) AS CustoFs, ;
                       0000000000000000.00 AS PVens, 0000000000000000.00 AS PVenPesos ;
                  FROM CsRelatorio a WHERE TpCustos = 1 GROUP BY a.Moecusfs ;
                UNION ALL ;
                SELECT a.MoeVs AS Moedas, 0000000000000000.00 AS CustoFs, ;
                       VAL(STR(SUM(a.PVens),16,2)) AS PVens, ;
                       VAL(STR(SUM(a.PVenPesos),16,2)) AS PVenPesos ;
                  FROM CsRelatorio a WHERE TpVendas = 1 GROUP BY a.MoeVs ;
                 ORDER BY 1 INTO CURSOR crSMoeda

                *-- Monta linhas do relatorio no SCAN
                loc_nApu = 0
                loc_nEst = 0
                loc_nFal = 0
                loc_nSob = 0

                SELECT CsRelatorio
                IF THIS.this_nTipoOrdem = 1
                    INDEX ON Ps + CPros TAG Chave1
                ELSE
                    INDEX ON Ps + CGrus + IFors + CPros TAG Chave1
                ENDIF
                SET ORDER TO
                GO TOP

                SCAN
                    loc_TcCabecs = PADC("Produto",14) + " " + ;
                        IIF(loc_nDescricao=1, PADC("Descri"+CHR(231)+CHR(227)+"o do Produto",40)+" ","") + ;
                        IIF(loc_nBarras=1, PADC("Barras",10)+" ","") + ;
                        PADC("Apurado",9) + " " + PADC("Estoque",9) + " " + ;
                        IIF(loc_nDescricao=1 .AND. loc_nLocali=1 .AND. loc_nBarras=1 .AND. ;
                            loc_nVenda=1 .AND. loc_nCusto=1, ;
                            PADC("Diferenca(+/-)",14), PADC("Falta",9)+" "+PADC("Sobra",9)) + " " + ;
                        IIF(CsRelatorio.TpCustos=1, PADC("Pre"+CHR(231)+"o Custo",15)+" ","") + ;
                        IIF(CsRelatorio.TpVendas=1, PADC("Pre"+CHR(231)+"o Venda",15)+" ","") + ;
                        IIF(CsRelatorio.TpVendas=1, PADC("Fator Venda",13)+" ","") + ;
                        IIF(THIS.this_lTrataPeso, ;
                            PADC("Peso Apur",9)+" "+PADC("Peso Estq",9)+" "+ ;
                            PADC("Falta",9)+" "+PADC("Sobra",9), "")

                    loc_TcTraco1s = REPLICATE("_",14) + " " + ;
                        IIF(loc_nDescricao=1, REPLICATE("_",40)+" ","") + ;
                        IIF(loc_nBarras=1, REPLICATE("_",10)+" ","") + ;
                        REPLICATE("_",9)+" "+REPLICATE("_",9)+" " + ;
                        IIF(loc_nDescricao=1 .AND. loc_nLocali=1 .AND. loc_nBarras=1 .AND. ;
                            loc_nVenda=1 .AND. loc_nCusto=1, ;
                            REPLICATE("_",14), REPLICATE("_",9)+" "+REPLICATE("_",9)) + " " + ;
                        IIF(CsRelatorio.TpCustos=1, REPLICATE("_",15)+" ","") + ;
                        IIF(CsRelatorio.TpVendas=1, REPLICATE("_",15)+" ","") + ;
                        IIF(CsRelatorio.TpVendas=1, REPLICATE("_",13)+" ","") + ;
                        IIF(THIS.this_lTrataPeso, ;
                            REPLICATE("_",9)+" "+REPLICATE("_",9)+" "+ ;
                            REPLICATE("_",9)+" "+REPLICATE("_",9), "")

                    loc_nValor   = CsRelatorio.Saldos - ;
                                   IIF(EMPTY(CsRelatorio.ReLidos), CsRelatorio.Lidos, CsRelatorio.ReLidos)
                    loc_nValorPs = CsRelatorio.SaldoPs - ;
                                   IIF(EMPTY(CsRelatorio.ReLidoPs), CsRelatorio.LidoPs, CsRelatorio.ReLidoPs)

                    loc_TcLinhas = PADR(CsRelatorio.CPros,15) + ;
                        IIF(loc_nDescricao=1, PADR(CsRelatorio.DPros,40),"") + " " + ;
                        IIF(loc_nBarras=1, PADR(STR(CsRelatorio.CBars),10)+" ","") + ;
                        TRANSFORM(IIF(EMPTY(CsRelatorio.ReLidos),CsRelatorio.Lidos,CsRelatorio.Relidos),"99,999.99")+" "+ ;
                        TRANSFORM(CsRelatorio.Saldos,"99,999.99")+" " + ;
                        IIF(loc_nDescricao=1 .AND. loc_nLocali=1 .AND. loc_nBarras=1 .AND. ;
                            loc_nVenda=1 .AND. loc_nCusto=1, ;
                            TRANSFORM(ABS(loc_nValor),"@Z 999,999.99") + ;
                            IIF(loc_nValor>0," (+)"," (-)") + " ", ;
                            TRANSFORM(IIF(loc_nValor>0,ABS(loc_nValor),0),"@Z 99,999.99")+" "+ ;
                            TRANSFORM(IIF(loc_nValor<0,ABS(loc_nValor),0),"@Z 99,999.99")+" ")

                    loc_TcLinhas = loc_TcLinhas + ;
                        IIF(CsRelatorio.TpCustos=1, TRANSFORM(CsRelatorio.CustoFs,"9,999,999.99"),"") + ;
                        IIF(CsRelatorio.TpCustos=1, PADR(CsRelatorio.MoeCusfs,3)+" ","") + ;
                        IIF(CsRelatorio.TpVendas=1, TRANSFORM(CsRelatorio.PVens,"9,999,999.99"),"") + ;
                        IIF(CsRelatorio.TpVendas=1, PADR(CsRelatorio.MoeVs,3)+" ","") + ;
                        IIF(CsRelatorio.TpVendas=1, TRANSFORM(CsRelatorio.FVendas,"@Z 999,999.99"),"") + ;
                        IIF(CsRelatorio.TpVendas=1, PADR(CsRelatorio.MoePVs,3)+" ","") + ;
                        IIF(THIS.this_lTrataPeso, ;
                            TRANSFORM(IIF(EMPTY(CsRelatorio.ReLidoPs),CsRelatorio.LidoPs,CsRelatorio.RelidoPs),"9,999.999")+" "+ ;
                            TRANSFORM(CsRelatorio.SaldoPs,"9,999.999")+" "+ ;
                            TRANSFORM(IIF(loc_nValorPs>0,ABS(loc_nValorPs),0),"@Z 9,999.999")+" "+ ;
                            TRANSFORM(IIF(loc_nValorPs<0,ABS(loc_nValorPs),0),"@Z 9,999.999"), "")

                    REPLACE TcCabecs WITH loc_TcCabecs, ;
                            TcTraco1s WITH loc_TcTraco1s, ;
                            TcLinhas WITH loc_TcLinhas

                    IF (_TipoDif=1 .OR. Ps="2") .OR. ;
                       (Saldos # IIF(EMPTY(ReLidos),Lidos,ReLidos))
                        loc_nApu = loc_nApu + IIF(EMPTY(CsRelatorio.ReLidos),CsRelatorio.Lidos,CsRelatorio.Relidos)
                        loc_nEst = loc_nEst + CsRelatorio.Saldos
                        loc_nFal = loc_nFal + IIF(loc_nValor>0, ABS(loc_nValor), 0)
                        loc_nSob = loc_nSob + IIF(loc_nValor<0, ABS(loc_nValor), 0)
                    ENDIF

                    IF LEN(ALLTRIM(loc_TcCabecs)) > 120
                        llHorizontal = .T.
                    ENDIF
                ENDSCAN

                IF (loc_nApu + loc_nEst + loc_nFal + loc_nSob > 0)
                    LOCAL loc_TcTotal
                    loc_TcTotal = loc_TcTraco1s + CHR(13) + CHR(10) + ;
                        PADR("",15) + IIF(loc_nDescricao=1, PADR("",39), "") + " " + ;
                        IIF(loc_nBarras=1, PADR("",14)+" ","") + ;
                        TRANSFORM(loc_nApu,"99,999.99")+" " + ;
                        TRANSFORM(loc_nEst,"99,999.99")+" " + ;
                        TRANSFORM(loc_nFal,"99,999.99")+" " + ;
                        TRANSFORM(loc_nSob,"99,999.99")+" "
                    REPLACE TcLinhas WITH loc_TcTotal IN csCabecalho
                ENDIF

                *-- Com localizacao: cria CsResult com locais por produto
                IF loc_nLocali = 1
                    LOCAL loc_nLocQtd, loc_lFirst, loc_nCntHi
                    CREATE CURSOR CsResult (CPros C(14), CGrus C(3), IFors C(10), ;
                        TcCabecs C(180), Lidos N(12,2), ReLidos N(12,2), Saldos N(16,2), ;
                        TpCustos N(16,2), TpVendas N(16,2), FVendas N(10,2), ;
                        TcTraco1s C(180), TcLinhas M, Ps C(1), LidoPs N(12,2), ReLidoPs N(12,2))
                    SELECT CsRelatorio
                    GO TOP
                    SCAN
                        LOCAL loc_cPros, loc_TcL2
                        loc_cPros = CsRelatorio.CPros
                        loc_TcL2  = CsRelatorio.TcLinhas
                        INSERT INTO CsResult ;
                            (CPros,CGrus,IFors,TcCabecs,Lidos,ReLidos,Saldos, ;
                             TpCustos,TpVendas,FVendas,TcTraco1s,TcLinhas,Ps,LidoPs,ReLidoPs) ;
                            VALUES (CsRelatorio.CPros, CsRelatorio.CGrus, CsRelatorio.IFors, ;
                                    CsRelatorio.TcCabecs, CsRelatorio.Lidos, CsRelatorio.ReLidos, ;
                                    CsRelatorio.Saldos, CsRelatorio.TpCustos, CsRelatorio.TpVendas, ;
                                    CsRelatorio.FVendas, CsRelatorio.TcTraco1s, loc_TcL2, ;
                                    CsRelatorio.Ps, CsRelatorio.LidoPs, CsRelatorio.ReLidoPs)
                        loc_lFirst  = .T.
                        loc_nCntHi  = 1
                        loc_nResult = SQLEXEC(gnConnHandle, ;
                            "SELECT DISTINCT Localis FROM SigIvTrH " + ;
                            "WHERE Emps=" + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                            " AND codigos=" + TRANSFORM(par_nNumBal) + ;
                            " AND Tipos=" + ALLTRIM(STR(THIS.this_nTipoLeitura)) + ;
                            " AND CPros=" + EscaparSQL(loc_cPros), "CsLocalis")
                        IF loc_nResult >= 1
                            SELECT CsLocalis
                            COUNT TO loc_nLocQtd
                            GO TOP
                            DO WHILE !EOF("CsLocalis")
                                IF !EMPTY(CsLocalis.Localis) .OR. ;
                                   (loc_nLocQtd > 1 .AND. EMPTY(CsLocalis.Localis))
                                    loc_TcL2 = IIF(loc_lFirst, ;
                                        RTRIM(loc_TcL2) + CHR(13) + CHR(10) + ;
                                        SPACE(11) + CsLocalis.Localis, ;
                                        loc_TcL2 + IIF(loc_nCntHi=1,"",", ") + CsLocalis.Localis)
                                    loc_nCntHi = loc_nCntHi + 1
                                    IF loc_nCntHi > IIF(llHorizontal, 17, 13)
                                        loc_TcL2   = loc_TcL2 + "," + CHR(13) + CHR(10) + SPACE(11)
                                        loc_nCntHi = 1
                                    ENDIF
                                    loc_lFirst = .F.
                                ENDIF
                                SKIP
                            ENDDO
                            SELECT CsResult
                            REPLACE TcLinhas WITH loc_TcL2
                        ENDIF
                        SELECT CsRelatorio
                    ENDSCAN
                ENDIF

                *-- Insere totais por moeda no final de CsRelatorio
                SELECT Moedas, SUM(CustoFs) AS CustoFs, SUM(Pvens) AS PVens ;
                  FROM crSMoeda GROUP BY Moedas INTO CURSOR TmpMoeda READWRITE

                SELECT TmpMoeda
                GO TOP
                SCAN
                    INSERT INTO CsRelatorio (TcCabecs, TcTraco1s, TcLinhas, Ps, CGrus, IFors) ;
                        VALUES ( ;
                            PADC(PADC("Moeda",5)+" " + ;
                                IIF(loc_nCusto=1,PADC("Pre"+CHR(231)+"o de Custo",17)+" ","") + ;
                                IIF(loc_nVenda=1,PADC("Pre"+CHR(231)+"o Venda",17)+" ",""),165), ;
                            PADC(REPLICATE("_",5)+" " + ;
                                IIF(loc_nCusto=1,REPLICATE("_",17)+" ","") + ;
                                IIF(loc_nVenda=1,REPLICATE("_",17)+" ",""),165), ;
                            PADC(PADR(TmpMoeda.Moedas,6) + ;
                                IIF(loc_nCusto=1,TRANSFORM(TmpMoeda.CustoFs,"99,999,999,999.99")+" ","") + ;
                                IIF(loc_nVenda=1,TRANSFORM(TmpMoeda.PVens,"99,999,999,999.99")+" ",""),165), ;
                            "2", REPLICATE(CHR(254),3), REPLICATE(CHR(254),10))
                ENDSCAN
            ELSE
                *-- Tipo 2: Resumo Geral
                THIS.ProcessarResumoGeral()
            ENDIF

            SET ESCAPE &loc_lcEscape.
            SET TALK   &loc_lcTalk.
            SET DECIMALS TO (loc_lDecimals)
            SET FIXED &loc_lcFixed.

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ProcessarResumo")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarResumoGeral - Cria cursor crRel1 para o tipo 2 (Resumo Geral)
    * Equivale ao procedure "mProcResumoGeral" do form original
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarResumoGeral()
        LOCAL loc_lSucesso, loc_lcMoedaP, loc_nResult
        LOCAL loc_nQtdPosEst, loc_nQtdDivMaior, loc_nQtdDivMenor, loc_nQtdInv
        LOCAL loc_nPesoPosEst, loc_nPesoDivMaior, loc_nPesoDivMenor, loc_nPesoInv
        LOCAL loc_nVlCPosEst, loc_nVlCDivMaior, loc_nVlCDivMenor, loc_nVlCInv
        LOCAL loc_nVlVPosEst, loc_nVlVDivMaior, loc_nVlVDivMenor, loc_nVlVInv
        LOCAL loc_cTitulo1s, loc_cEmpresaNome, loc_nValor1, loc_nValor2
        LOCAL loc_nEst1, loc_nEstP1, loc_nInv1, loc_nInvP1, loc_nDif1, loc_nDifP1

        loc_lSucesso = .F.
        THIS.this_nChkConversao1 = 1
        TRY
            SELECT CsSigCdBal
            GO TOP
            loc_lcMoedaP = ""
            IF USED("CsSigCdPam")
                SELECT CsSigCdPam
                GO TOP
                IF !EOF()
                    loc_lcMoedaP = ALLTRIM(NVL(CsSigCdPam.moedaps, ""))
                ENDIF
            ENDIF

            loc_cEmpresaNome = ""
            IF USED("CrSigCdEmp")
                SELECT CrSigCdEmp
                GO TOP
                IF !EOF()
                    loc_cEmpresaNome = ALLTRIM(CrSigCdEmp.Razas)
                ENDIF
            ENDIF

            SELECT CsSigCdBal
            GO TOP
            loc_cTitulo1s = "Resumo Geral do Invent" + CHR(225) + "rio N" + CHR(186) + " " + ;
                            ALLTRIM(STR(CsSigCdBal.codigos))

            CREATE CURSOR crRel1 (cEmpresas C(50), cTitulo1s C(254), cTitulo2s C(254), ;
                                  cTitulo3s C(254), cPs1s C(2), cLinha1s C(254))
            SET ORDER TO ("") IN crRel1

            *-- Descricao do grupo e conta
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Descrs FROM SigCdGcr WHERE Codigos=" + ;
                EscaparSQL(ALLTRIM(CsSigCdBal.Grupos)) + " ORDER BY 1", "crTmpGccr1")
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Rclis FROM SigCdCli WHERE Iclis=" + ;
                EscaparSQL(ALLTRIM(CsSigCdBal.Contas)) + " ORDER BY 1", "crTmpCli1")

            IF USED("crTmpGccr1")
                SELECT crTmpGccr1
                GO TOP
                IF !EOF() .AND. !EMPTY(crTmpGccr1.Descrs)
                    loc_cTitulo1s = loc_cTitulo1s + CHR(13) + ;
                        " Grupo: " + ALLTRIM(CsSigCdBal.Grupos) + "-" + ALLTRIM(crTmpGccr1.Descrs)
                ENDIF
            ENDIF
            IF USED("crTmpCli1")
                SELECT crTmpCli1
                GO TOP
                IF !EOF() .AND. !EMPTY(crTmpCli1.Rclis)
                    loc_cTitulo1s = loc_cTitulo1s + CHR(13) + ;
                        " Conta: " + ALLTRIM(CsSigCdBal.Contas) + "-" + ALLTRIM(crTmpCli1.Rclis)
                ENDIF
            ENDIF

            *-- Produtos com precos para conversao
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT cPros,pVens,MoeVs,99999999.99 AS nVendConv1s," + ;
                "CustoFs,MoeCusFs,99999999.99 AS nCustConv1s " + ;
                "FROM SigCdPro ORDER BY 1", "crSigCdPro")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha crSigCdPro"
                loc_lSucesso = .F.
            ENDIF
            SELECT crSigCdPro
            INDEX ON cpros TAG cpros
            GO TOP

            SCAN
                loc_nValor1 = THIS.ConverteMoe(loc_lcMoedaP, crSigCdPro.Moevs, crSigCdPro.pVens, DATE())
                loc_nValor2 = THIS.ConverteMoe(loc_lcMoedaP, crSigCdPro.MoeCusFs, crSigCdPro.CustoFs, DATE())
                REPLACE nVendConv1s WITH loc_nValor1, nCustConv1s WITH loc_nValor2 IN crSigCdPro
            ENDSCAN

            *-- Inicializa totalizadores
            loc_nQtdPosEst    = 0
            loc_nQtdDivMaior  = 0
            loc_nQtdDivMenor  = 0
            loc_nQtdInv       = 0
            loc_nPesoPosEst   = 0
            loc_nPesoDivMaior = 0
            loc_nPesoDivMenor = 0
            loc_nPesoInv      = 0
            loc_nVlCPosEst    = 0
            loc_nVlCDivMaior  = 0
            loc_nVlCDivMenor  = 0
            loc_nVlCInv       = 0
            loc_nVlVPosEst    = 0
            loc_nVlVDivMaior  = 0
            loc_nVlVDivMenor  = 0
            loc_nVlVInv       = 0

            SELECT Base
            SET ORDER TO ("") IN Base
            GO TOP

            SCAN
                = SEEK(Base.cpros, "crSigCdPro", "cPros")

                loc_nEst1 = Base.saldos
                loc_nInv1 = IIF(EMPTY(Base.Relidos), Base.Lidos, Base.Relidos)
                loc_nDif1 = (Base.saldos - loc_nInv1)

                loc_nQtdPosEst = (loc_nQtdPosEst + loc_nEst1)
                loc_nVlCPosEst = (loc_nVlCPosEst + (loc_nEst1 * crSigCdPro.nCustConv1s))
                loc_nVlVPosEst = (loc_nVlVPosEst + (loc_nEst1 * crSigCdPro.nVendConv1s))

                IF loc_nDif1 < 0
                    loc_nQtdDivMaior = (loc_nQtdDivMaior + ABS(loc_nDif1))
                    loc_nVlCDivMaior = (loc_nVlCDivMaior + (ABS(loc_nDif1) * crSigCdPro.nCustConv1s))
                    loc_nVlVDivMaior = (loc_nVlVDivMaior + (ABS(loc_nDif1) * crSigCdPro.nVendConv1s))
                ENDIF
                IF loc_nDif1 > 0
                    loc_nQtdDivMenor = (loc_nQtdDivMenor + loc_nDif1)
                    loc_nVlCDivMenor = (loc_nVlCDivMenor + (loc_nDif1 * crSigCdPro.nCustConv1s))
                    loc_nVlVDivMenor = (loc_nVlVDivMenor + (loc_nDif1 * crSigCdPro.nVendConv1s))
                ENDIF
                loc_nQtdInv = (loc_nQtdInv + loc_nInv1)
                loc_nVlCInv = (loc_nVlCInv + (loc_nInv1 * crSigCdPro.nCustConv1s))
                loc_nVlVInv = (loc_nVlVInv + (loc_nInv1 * crSigCdPro.nVendConv1s))

                loc_nEstP1 = Base.saldoPs
                loc_nInvP1 = IIF(EMPTY(Base.RelidoPs), Base.LidoPs, Base.RelidoPs)
                loc_nDifP1 = (Base.saldoPs - loc_nInvP1)

                loc_nPesoPosEst = (loc_nPesoPosEst + loc_nEstP1)
                IF loc_nDifP1 < 0
                    loc_nPesoDivMaior = (loc_nPesoDivMaior + ABS(loc_nDifP1))
                ENDIF
                IF loc_nDifP1 > 0
                    loc_nPesoDivMenor = (loc_nPesoDivMenor + loc_nDifP1)
                ENDIF
                loc_nPesoInv = (loc_nPesoInv + loc_nInvP1)
            ENDSCAN

            *-- Insere linhas no cursor crRel1
            LOCAL loc_cEmp, loc_cTit2, loc_cTit3, loc_cPs, loc_cLin
            loc_cEmp  = ALLTRIM(go_4c_Sistema.cCodEmpresa) + " - " + loc_cEmpresaNome
            loc_cTit2 = ""
            loc_cTit3 = ""
            loc_cPs   = "11"
            loc_cLin  = PADR("Topicos",30) + ;
                IIF(THIS.this_lTrataPeso, PADL("Pesos",10), "") + ;
                PADL("Quant.",15) + PADL("Venda R$",18) + PADL("Custo R$",18)

            INSERT INTO crRel1 (cEmpresas,cTitulo1s,cTitulo2s,cTitulo3s,cPs1s,cLinha1s) ;
                VALUES (loc_cEmp, loc_cTitulo1s, loc_cTit2, loc_cTit3, loc_cPs, loc_cLin)

            loc_cLin = ""
            INSERT INTO crRel1 (cEmpresas,cTitulo1s,cTitulo2s,cTitulo3s,cPs1s,cLinha1s) ;
                VALUES (loc_cEmp, loc_cTitulo1s, loc_cTit2, loc_cTit3, loc_cPs, loc_cLin)

            loc_cLin = PADR("Posi"+CHR(231)+CHR(227)+"o Estoque",30) + ;
                IIF(THIS.this_lTrataPeso, PADL(TRANSFORM(loc_nPesoPosEst,"999,999.999"),10),"") + ;
                PADL(TRANSFORM(loc_nQtdPosEst,"999,999"),10) + ;
                PADL(TRANSFORM(loc_nVlVPosEst,"999,999,999.99"),18) + ;
                PADL(TRANSFORM(loc_nVlCPosEst,"999,999,999.99"),18)
            INSERT INTO crRel1 (cEmpresas,cTitulo1s,cTitulo2s,cTitulo3s,cPs1s,cLinha1s) ;
                VALUES (loc_cEmp, loc_cTitulo1s, loc_cTit2, loc_cTit3, loc_cPs, loc_cLin)

            loc_cLin = PADR("Divergencia (+) ",30) + ;
                IIF(THIS.this_lTrataPeso, PADL(TRANSFORM(loc_nPesoDivMaior,"999,999.999"),10),"") + ;
                PADL(TRANSFORM(loc_nQtdDivMaior,"999,999"),10) + ;
                PADL(TRANSFORM(loc_nVlVDivMaior,"999,999,999.99"),18) + ;
                PADL(TRANSFORM(loc_nVlCDivMaior,"999,999,999.99"),18)
            INSERT INTO crRel1 (cEmpresas,cTitulo1s,cTitulo2s,cTitulo3s,cPs1s,cLinha1s) ;
                VALUES (loc_cEmp, loc_cTitulo1s, loc_cTit2, loc_cTit3, loc_cPs, loc_cLin)

            loc_cLin = PADR("Divergencia (-) ",30) + ;
                IIF(THIS.this_lTrataPeso, PADL(TRANSFORM(loc_nPesoDivMenor,"999,999.999"),10),"") + ;
                PADL(TRANSFORM(loc_nQtdDivMenor,"999,999"),10) + ;
                PADL(TRANSFORM(loc_nVlVDivMenor,"999,999,999.99"),18) + ;
                PADL(TRANSFORM(loc_nVlCDivMenor,"999,999,999.99"),18)
            INSERT INTO crRel1 (cEmpresas,cTitulo1s,cTitulo2s,cTitulo3s,cPs1s,cLinha1s) ;
                VALUES (loc_cEmp, loc_cTitulo1s, loc_cTit2, loc_cTit3, loc_cPs, loc_cLin)

            loc_cLin = PADR("Total Inventariado ",30) + ;
                IIF(THIS.this_lTrataPeso, PADL(TRANSFORM(loc_nPesoInv,"999,999.999"),10),"") + ;
                PADL(TRANSFORM(loc_nQtdInv,"999,999"),10) + ;
                PADL(TRANSFORM(loc_nVlVInv,"999,999,999.99"),18) + ;
                PADL(TRANSFORM(loc_nVlCInv,"999,999,999.99"),18)
            INSERT INTO crRel1 (cEmpresas,cTitulo1s,cTitulo2s,cTitulo3s,cPs1s,cLinha1s) ;
                VALUES (loc_cEmp, loc_cTitulo1s, loc_cTit2, loc_cTit3, loc_cPs, loc_cLin)

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ProcessarResumoGeral")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarAnalitico - Tipo 3: consulta SigIvTrH para relatorio analitico
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarAnalitico(par_nNumBal)
        LOCAL loc_lSucesso, loc_nResult, loc_lStrQuery

        loc_lSucesso = .F.
        TRY
            _Saldo   = 0
            _SaldoPs = 0

            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Emps,Codigos,CPros,Saldos,SaldoPs FROM SigIvTrB " + ;
                "WHERE Emps=" + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                " AND Codigos=" + TRANSFORM(par_nNumBal) + ;
                " AND CPros=" + EscaparSQL(_Produto), "CsSaldo")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha CsSaldo"
                loc_lSucesso = .F.
            ENDIF
            SELECT CsSaldo
            GO TOP
            IF !EOF()
                _Saldo   = CsSaldo.Saldos
                _SaldoPs = CsSaldo.SaldoPs
            ENDIF
            THIS.this_nSaldo   = _Saldo
            THIS.this_nSaldoPs = _SaldoPs

            loc_lStrQuery = "SELECT *,' ' AS PS,SPACE(8) AS OrdImg,SPACE(40) AS Reffs " + ;
                            "FROM SigIvTrH " + ;
                            "WHERE Emps=" + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                            " AND Codigos=" + TRANSFORM(par_nNumBal) + ;
                            " AND Tipos=" + ALLTRIM(STR(THIS.this_nTipoLeitura)) + ;
                            IIF(THIS.this_nTipoAnalitico = 1, ;
                                " AND CPros=" + EscaparSQL(_Produto), ;
                                " AND Localis=" + EscaparSQL(_Local)) + ;
                            " ORDER BY " + IIF(THIS.this_nTipoAnalitico=1, ;
                                "Tipos,CPros,Datas", "Tipos,Localis,Datas")
            loc_nResult = SQLEXEC(gnConnHandle, loc_lStrQuery, "CsRelatorio")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha CsRelatorio (Analitico)"
                loc_lSucesso = .F.
            ENDIF

            _Titulo = "Relat" + CHR(243) + "rio Anal" + CHR(237) + "tico do Invent" + ;
                      CHR(225) + "rio n" + CHR(186) + " " + ALLTRIM(STR(par_nNumBal))
            THIS.this_cTitulo = _Titulo
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ProcessarAnalitico")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarEtiqueta - Tipo 4: consulta SigIvTrE e SigIvTrH para etiquetas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarEtiqueta(par_nNumBal)
        LOCAL loc_lSucesso, loc_nResult, loc_lStrQuery, loc_lcPro, loc_lcFoto

        loc_lSucesso = .F.
        TRY
            _TotalnLido = 0
            _TotalnEsto = 0

            loc_lStrQuery = "SELECT a.Emps,a.Codigos,a.CBars,a.CPros,a.Contas," + ;
                "b.DPros,b.CGrus,b.Sgrus,b.pvens,b.Reffs " + ;
                "FROM SigIvTrE a INNER JOIN SigCdPro b ON a.Cpros=b.Cpros " + ;
                "WHERE a.Emps=" + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                " AND a.Codigos=" + TRANSFORM(par_nNumBal) + ;
                " AND a.CBars<>0 ORDER BY a.CidChaves"
            loc_nResult = SQLEXEC(gnConnHandle, loc_lStrQuery, "CsEtiqueta")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha CsEtiqueta"
                loc_lSucesso = .F.
            ENDIF
            SELECT CsEtiqueta
            INDEX ON CBars TAG CBars
            GO TOP

            loc_lStrQuery = "SELECT a.Emps,a.Codigos,a.CBars,a.CPros,a.Contas," + ;
                "b.DPros,b.CGrus,b.Sgrus,b.pvens,b.Reffs " + ;
                "FROM SigIvTrH a INNER JOIN SigCdPro b ON a.Cpros=b.Cpros " + ;
                "WHERE a.Emps=" + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                " AND a.Codigos=" + TRANSFORM(par_nNumBal) + ;
                " AND a.CBars<>0 ORDER BY a.CIdChaves"
            loc_nResult = SQLEXEC(gnConnHandle, loc_lStrQuery, "CsHistorico")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha CsHistorico"
                loc_lSucesso = .F.
            ENDIF
            SELECT CsHistorico
            INDEX ON CBars TAG CBars
            GO TOP

            CREATE CURSOR CsRelatorio (Contas C(10), CBars N(14), CPros C(14), Tipos C(20), ;
                PS C(1), OrdImg C(8), Reffs C(40), Dpros C(40), Cgrus C(3), Sgrus C(6), Pvens N(11,2))
            INDEX ON Tipos + CPros + STR(CBars,14) TAG TpProBar

            SELECT CsEtiqueta
            SCAN
                IF !SEEK(CsEtiqueta.CBars, "CsHistorico", "CBars")
                    INSERT INTO CsRelatorio (Contas,CBars,CPros,Tipos,Dpros,Cgrus,Sgrus,Pvens,Reffs) ;
                        VALUES (CsEtiqueta.Contas, CsEtiqueta.CBars, CsEtiqueta.CPros, ;
                                "N"+CHR(227)+"o Lido", ;
                                CsEtiqueta.Dpros, CsEtiqueta.Cgrus, CsEtiqueta.Sgrus, ;
                                CsEtiqueta.Pvens, CsEtiqueta.Reffs)
                    _TotalnLido = _TotalnLido + 1
                ENDIF
            ENDSCAN

            SELECT CsHistorico
            SCAN
                IF !SEEK(CsHistorico.Cbars, "CsEtiqueta", "CBars")
                    INSERT INTO CsRelatorio (Contas,CBars,CPros,Tipos,Dpros,Cgrus,Sgrus,Pvens,Reffs) ;
                        VALUES (CsHistorico.Contas, CsHistorico.CBars, CsHistorico.CPros, ;
                                "N"+CHR(227)+"o est"+CHR(225)+" no Estoque", ;
                                CsHistorico.Dpros, CsHistorico.Cgrus, CsHistorico.Sgrus, ;
                                CsHistorico.Pvens, CsHistorico.Reffs)
                    _TotalnEsto = _TotalnEsto + 1
                ENDIF
            ENDSCAN

            _Titulo = "Relat"+CHR(243)+"rio de C"+CHR(243)+"digos de Barras do Invent"+ ;
                      CHR(225)+"rio n"+CHR(186)+" "+ALLTRIM(STR(par_nNumBal))
            THIS.this_cTitulo = _Titulo

            *-- Gera imagens se solicitado
            IF THIS.this_lImprimirImagem
                SELECT CsRelatorio
                SCAN
                    loc_lcPro = CsRelatorio.CPros
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT FigJpgs FROM SigCdPro WHERE CPros=" + ;
                        EscaparSQL(loc_lcPro), "LocalPro")
                    IF loc_nResult >= 1
                        SELECT LocalPro
                        GO TOP
                        IF !EOF() .AND. !EMPTY(LocalPro.FigJpgs) .AND. !ISNULL(LocalPro.FigJpgs)
                            REPLACE OrdImg WITH "F" + PADL(RECNO("CsRelatorio"),7,"0") IN CsRelatorio
                            loc_lcFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(LocalPro.FigJpgs, ;
                                "data:image/png;base64,",""), ;
                                "data:image/jpeg;base64,",""), ;
                                "data:image/jpg;base64,",""),14)
                            STRTOFILE(loc_lcFoto, SYS(2023)+"\F"+PADL(RECNO("CsRelatorio"),7,"0")+".Jpg")
                        ELSE
                            REPLACE OrdImg WITH "FBRANCOS" IN CsRelatorio
                        ENDIF
                    ENDIF
                    SELECT CsRelatorio
                ENDSCAN
                GO TOP IN CsRelatorio
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ProcessarEtiqueta")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarEstoqueXLeitura - Tipo 5: preenche csRelatorio5 a partir de CsRelatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarEstoqueXLeitura()
        LOCAL loc_lSucesso, loc_nVal, loc_cPss, loc_cMoe, loc_cPro, loc_lcFoto, loc_lcDir

        loc_lSucesso = .F.
        TRY
            SELECT csRelatorio
            SCAN
                loc_nVal = csRelatorio.Saldos - ;
                           IIF(EMPTY(csRelatorio.ReLidos), csRelatorio.Lidos, csRelatorio.ReLidos)
                loc_cPss = IIF(loc_nVal > 0, "N"+CHR(227)+"o Lido - Falta", "Sem Estoque - Sobra")
                loc_cMoe = IIF(EMPTY(csRelatorio.MoeCusFs), "???", csRelatorio.MoeCusFs)

                INSERT INTO csRelatorio5 (Ps,Mercs,CGrus,CPros,CBars,CodCors,CodTams, ;
                    Dpros,Custos,MoeCusFs,Qtds,FigJpgs,ImpCustos, ;
                    Saldos,Lidos,Relidos,SaldoPs,LidoPs,RelidoPs) ;
                    VALUES (loc_cPss, csRelatorio.Mercs, csRelatorio.CGrus, csRelatorio.CPros, ;
                            csRelatorio.CBars, csRelatorio.CodCors, csRelatorio.CodTams, ;
                            csRelatorio.DPros, csRelatorio.CustoFs, loc_cMoe, ABS(loc_nVal), ;
                            csRelatorio.FigJpgs, THIS.this_nTpCusto, csRelatorio.Saldos, ;
                            csRelatorio.Lidos, csRelatorio.Relidos, csRelatorio.SaldoPs, ;
                            csRelatorio.LidoPs, csRelatorio.RelidoPs)
            ENDSCAN

            SELECT Ps, MoeCusFs, SUM(Custos) AS Custos FROM csRelatorio5 ;
              GROUP BY Ps, MoeCusFs INTO CURSOR crTotais

            SELECT crTotais
            SCAN
                UPDATE csRelatorio5 SET Totais = ALLTRIM(Totais) + ;
                    IIF(EMPTY(Totais),"", " | ") + ;
                    ALLTRIM(crTotais.MoeCusFs) + " = " + ALLTRIM(STR(crTotais.Custos,12,2)) ;
                 WHERE Ps = crTotais.Ps
            ENDSCAN

            IF THIS.this_lImprimirImagem
                SELECT csRelatorio5
                SCAN
                    IF EMPTY(csRelatorio5.FigJpgs)
                        REPLACE OrdImg WITH "FBRANCOS" IN csRelatorio5
                    ELSE
                        loc_cPro  = STRTRAN(STRTRAN(ALLTRIM(csRelatorio5.CPros), "/", ""), " ", "")
                        loc_lcDir = SYS(2023) + "\F" + ALLTRIM(loc_cPro) + ".Jpg"
                        REPLACE OrdImg WITH "F" + ALLTRIM(loc_cPro) IN csRelatorio5
                        loc_lcFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(csRelatorio5.FigJpgs, ;
                            "data:image/png;base64,",""), ;
                            "data:image/jpeg;base64,",""), ;
                            "data:image/jpg;base64,",""),14)
                        STRTOFILE(loc_lcFoto, loc_lcDir)
                    ENDIF
                ENDSCAN
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ProcessarEstoqueXLeitura")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConverteMoe - Converte valor entre moedas usando tabelas SigCdMoe/SigCdCot
    * Equivale ao procedure "convertemoe" do form original
    *--------------------------------------------------------------------------
    PROCEDURE ConverteMoe(par_cMoedaConv, par_cMoedaBase, par_nValor, par_dData)
        LOCAL loc_nRetorno, loc_nResult, loc_cMoedaQ, loc_nQtdeQ
        LOCAL loc_nCotacaoConv, loc_nCotacaoBase

        loc_nRetorno = 0

        IF THIS.this_nChkConversao1 = 0
            RETURN loc_nRetorno
        ENDIF

        par_cMoedaConv = PADR(NVL(par_cMoedaConv, ""), 3)
        par_cMoedaBase = PADR(NVL(par_cMoedaBase, ""), 3)
        par_nValor     = NVL(par_nValor, 0)
        IF VARTYPE(par_dData) != "D"
            par_dData = DATE()
        ENDIF

        *-- Na primeira chamada: verifica existencia das tabelas de moeda
        IF THIS.this_nChkConversao1 = 1
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT a.cmoes FROM SigCdMoe a " + ;
                "INNER JOIN SigCdCot b ON b.cmoes=a.cmoes WHERE 0=1", "crChkTbl1")
            THIS.this_nChkConversao1 = IIF(USED("crChkTbl1"), 2, 0)
            IF USED("crChkTbl1")
                USE IN crChkTbl1
            ENDIF
        ENDIF

        IF THIS.this_nChkConversao1 = 2
            *-- Carrega cursores de moeda se nao carregados
            IF !USED("crSigCdMoe")
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT a.cmoes,a.cotas,a.moeqs,a.qtdeqs FROM SigCdMoe a ORDER BY 1", ;
                    "crSigCdMoe")
                IF USED("crSigCdMoe")
                    SELECT crSigCdMoe
                    INDEX ON cmoes TAG cmoes
                ENDIF
            ENDIF
            IF !USED("crSigCdCot")
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT a.cmoes,a.datas,a.horas,a.valos FROM SigCdCot a " + ;
                    "ORDER BY 1 ASC,2 DESC,3 DESC", "crSigCdCot")
                IF USED("crSigCdCot")
                    SELECT crSigCdCot
                    INDEX ON cmoes + DTOS(datas) + horas TAG cmoedata
                ENDIF
            ENDIF

            *-- Cotacao da moeda de origem
            IF USED("crSigCdMoe") .AND. SEEK(par_cMoedaConv, "crSigCdMoe", "cmoes") ;
               .AND. !EMPTY(crSigCdMoe.Moeqs)
                loc_cMoedaQ = crSigCdMoe.moeqs
                loc_nQtdeQ  = IIF(crSigCdMoe.Qtdeqs = 0, 1, crSigCdMoe.Qtdeqs)
            ELSE
                loc_cMoedaQ = par_cMoedaConv
                loc_nQtdeQ  = 1
            ENDIF
            loc_nCotacaoConv = THIS.CarregarCambio(loc_cMoedaQ, par_dData) * loc_nQtdeQ

            *-- Cotacao da moeda base
            IF USED("crSigCdMoe") .AND. SEEK(par_cMoedaBase, "crSigCdMoe", "cmoes") ;
               .AND. !EMPTY(crSigCdMoe.Moeqs)
                loc_cMoedaQ = crSigCdMoe.moeqs
                loc_nQtdeQ  = IIF(crSigCdMoe.Qtdeqs = 0, 1, crSigCdMoe.Qtdeqs)
            ELSE
                loc_cMoedaQ = par_cMoedaBase
                loc_nQtdeQ  = 1
            ENDIF
            loc_nCotacaoBase = THIS.CarregarCambio(loc_cMoedaQ, par_dData) * loc_nQtdeQ

            IF loc_nCotacaoConv > 0
                loc_nRetorno = ROUND((par_nValor / loc_nCotacaoConv * loc_nCotacaoBase), 2)
            ENDIF
        ENDIF

        RETURN loc_nRetorno
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCambio - Retorna cotacao da moeda para a data especificada
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarCambio(par_cMoeda, par_dData)
        LOCAL loc_nCotacao, loc_cChave

        loc_nCotacao = 1
        IF USED("crSigCdCot") .AND. !EMPTY(par_cMoeda)
            loc_cChave = PADR(par_cMoeda, 3) + DTOS(par_dData)
            IF SEEK(loc_cChave, "crSigCdCot", "cmoedata")
                loc_nCotacao = IIF(crSigCdCot.valos = 0, 1, crSigCdCot.valos)
            ENDIF
        ENDIF
        RETURN loc_nCotacao
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em tela (preview)
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                THIS.ExibirRelatorio(.F.)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                THIS.ExibirRelatorio(.T.)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExibirRelatorio - Executa REPORT FORM (preview ou impressora)
    * par_lImprimir = .T.: envia para impressora; .F.: preview na tela
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExibirRelatorio(par_lImprimir)
        LOCAL loc_nTp
        loc_nTp = THIS.this_nTipoRelatorio

        llTrataPeso = THIS.this_lTrataPeso

        DO CASE
            CASE loc_nTp = 1
                IF THIS.this_lHorizontal
                    IF par_lImprimir
                        REPORT FORM SigReBld TO PRINTER PROMPT NOCONSOLE ;
                            FOR IIF(_TipoDif=1 OR ps="2", .T., ;
                            IIF(!llTrataPeso,(Saldos#IIF(EMPTY(ReLidos),Lidos,ReLidos)), ;
                            ((Saldos#IIF(EMPTY(ReLidos),Lidos,ReLidos)) OR ;
                            (Saldops#IIF(EMPTY(ReLidops),Lidops,ReLidops)))))
                    ELSE
                        REPORT FORM SigReBld NOCONSOLE PREVIEW ;
                            FOR IIF(_TipoDif=1 OR ps="2", .T., ;
                            IIF(!llTrataPeso,(Saldos#IIF(EMPTY(ReLidos),Lidos,ReLidos)), ;
                            ((Saldos#IIF(EMPTY(ReLidos),Lidos,ReLidos)) OR ;
                            (Saldops#IIF(EMPTY(ReLidops),Lidops,ReLidops)))))
                    ENDIF
                ELSE
                    IF par_lImprimir
                        REPORT FORM SigReBdp TO PRINTER PROMPT NOCONSOLE ;
                            FOR IIF(_TipoDif=1 OR ps="2", .T., ;
                            IIF(!llTrataPeso,(Saldos#IIF(EMPTY(ReLidos),Lidos,ReLidos)), ;
                            ((Saldos#IIF(EMPTY(ReLidos),Lidos,ReLidos)) OR ;
                            (Saldops#IIF(EMPTY(ReLidops),Lidops,ReLidops)))))
                    ELSE
                        REPORT FORM SigReBdp NOCONSOLE PREVIEW ;
                            FOR IIF(_TipoDif=1 OR ps="2", .T., ;
                            IIF(!llTrataPeso,(Saldos#IIF(EMPTY(ReLidos),Lidos,ReLidos)), ;
                            ((Saldos#IIF(EMPTY(ReLidos),Lidos,ReLidos)) OR ;
                            (Saldops#IIF(EMPTY(ReLidops),Lidops,ReLidops)))))
                    ENDIF
                ENDIF

            CASE loc_nTp = 2
                IF par_lImprimir
                    REPORT FORM SigReBrg TO PRINTER PROMPT NOCONSOLE
                ELSE
                    REPORT FORM SigReBrg NOCONSOLE PREVIEW
                ENDIF

            CASE loc_nTp = 3
                IF par_lImprimir
                    REPORT FORM SigReBla TO PRINTER PROMPT NOCONSOLE
                ELSE
                    REPORT FORM SigReBla NOCONSOLE PREVIEW
                ENDIF

            CASE loc_nTp = 4
                IF THIS.this_nDescricao = 1
                    IF par_lImprimir
                        REPORT FORM SigReBlc TO PRINTER PROMPT NOCONSOLE
                    ELSE
                        REPORT FORM SigReBlc NOCONSOLE PREVIEW
                    ENDIF
                ELSE
                    IF par_lImprimir
                        REPORT FORM SigReBle TO PRINTER PROMPT NOCONSOLE
                    ELSE
                        REPORT FORM SigReBle NOCONSOLE PREVIEW
                    ENDIF
                ENDIF

            CASE loc_nTp = 5
                IF THIS.this_lImprimirImagem
                    IF par_lImprimir
                        REPORT FORM SigReBel TO PRINTER PROMPT NOCONSOLE ;
                            FOR IIF(!llTrataPeso, ;
                            (Saldos#IIF(EMPTY(ReLidos),Lidos,ReLidos)), ;
                            ((Saldos#IIF(EMPTY(ReLidos),Lidos,ReLidos)) OR ;
                            (SaldoPs#IIF(EMPTY(ReLidoPs),LidoPs,ReLidoPs))))
                    ELSE
                        REPORT FORM SigReBel NOCONSOLE PREVIEW ;
                            FOR IIF(!llTrataPeso, ;
                            (Saldos#IIF(EMPTY(ReLidos),Lidos,ReLidos)), ;
                            ((Saldos#IIF(EMPTY(ReLidos),Lidos,ReLidos)) OR ;
                            (SaldoPs#IIF(EMPTY(ReLidoPs),LidoPs,ReLidoPs))))
                    ENDIF
                ELSE
                    IF par_lImprimir
                        REPORT FORM SigReBe1 TO PRINTER PROMPT NOCONSOLE ;
                            FOR IIF(!llTrataPeso, ;
                            (Saldos#IIF(EMPTY(ReLidos),Lidos,ReLidos)), ;
                            ((Saldos#IIF(EMPTY(ReLidos),Lidos,ReLidos)) OR ;
                            (SaldoPs#IIF(EMPTY(ReLidoPs),LidoPs,ReLidoPs))))
                    ELSE
                        REPORT FORM SigReBe1 NOCONSOLE PREVIEW ;
                            FOR IIF(!llTrataPeso, ;
                            (Saldos#IIF(EMPTY(ReLidos),Lidos,ReLidos)), ;
                            ((Saldos#IIF(EMPTY(ReLidos),Lidos,ReLidos)) OR ;
                            (SaldoPs#IIF(EMPTY(ReLidoPs),LidoPs,ReLidoPs))))
                    ENDIF
                ENDIF
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro do ultimo processamento
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera variaveis PUBLIC criadas para o REPORT FORM
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF TYPE("lnNumBal") = "N"
            RELEASE lnNumBal, _Empresa, _DProduto, _Saldo, _Leitura, _TipoDif, _Titulo
            RELEASE _TipoLeitura, _TipoAnal, lnTpOrdem, _Produto, _Local, lcDescricao
            RELEASE llHorizontal, lnVenda, lnCusto, _TotalnLido, _TotalnEsto, _SaldoPs
            RELEASE llTrataPeso
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

