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
[05/17/26 12:53:38 AM] Erro: Erro ao inicializar Formsigrecmc:Linha: 137Connection handle is invalid.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-05-17 00:53:36] [INFO] === VFP EXECUTOR v2.0 ===
[2026-05-17 00:53:36] [INFO] Config FPW: (nao fornecido)
[2026-05-17 00:53:36] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-05-17 00:53:36] [INFO] Timeout: 300 segundos
[2026-05-17 00:53:36] [INFO] Wrapper PRG criado para parametros: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_002hwudp.prg
[2026-05-17 00:53:36] [INFO] Conteudo do wrapper:
[2026-05-17 00:53:36] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigrecmc', 'C:\4c\tasks\task052', 'REPORT'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigrecmc', 'C:\4c\tasks\task052', 'REPORT'
QUIT

[2026-05-17 00:53:36] [INFO] Comando VFP: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_002hwudp.prg
[2026-05-17 00:53:36] [INFO] VFP output esperado em: C:\4c\tasks\task052\vfp_output.txt
[2026-05-17 00:53:36] [INFO] Executando Visual FoxPro 9...
[2026-05-17 00:53:36] [INFO] Comando completo: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_002hwudp.prg
[2026-05-17 00:53:36] [INFO] Executando: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_002hwudp.prg
[2026-05-17 00:53:36] [INFO] Timeout configurado: 300 segundos
[2026-05-17 00:53:38] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-05-17 00:53:38] [INFO] VFP9 finalizado em 2.1822569 segundos
[2026-05-17 00:53:38] [INFO] Exit Code: 
[2026-05-17 00:53:38] [INFO] 
[2026-05-17 00:53:38] [INFO] Arquivos temporarios preservados para inspecao:
[2026-05-17 00:53:38] [INFO]   Wrapper.prg: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_002hwudp.prg
[2026-05-17 00:53:38] [INFO] 
[2026-05-17 00:53:38] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-05-17 00:53:38] [INFO] * Auto-generated wrapper for parameters
[2026-05-17 00:53:38] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-05-17 00:53:38] [INFO] * Parameters: 'Formsigrecmc', 'C:\4c\tasks\task052', 'REPORT'
[2026-05-17 00:53:38] [INFO] 
[2026-05-17 00:53:38] [INFO] * Anti-dialog protections for unattended execution
[2026-05-17 00:53:38] [INFO] SET SAFETY OFF
[2026-05-17 00:53:38] [INFO] SET RESOURCE OFF
[2026-05-17 00:53:38] [INFO] SET TALK OFF
[2026-05-17 00:53:38] [INFO] SET NOTIFY OFF
[2026-05-17 00:53:38] [INFO] SYS(2335, 0)
[2026-05-17 00:53:38] [INFO] 
[2026-05-17 00:53:38] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigrecmc', 'C:\4c\tasks\task052', 'REPORT'
[2026-05-17 00:53:38] [INFO] QUIT
[2026-05-17 00:53:39] [INFO] 
[2026-05-17 00:53:39] [INFO] === Fim do Wrapper.prg ===
[2026-05-17 00:53:39] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formsigrecmc",
  "timestamp": "20260517005338",
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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrecmc.prg):
*==============================================================================
* FORMSIGRECMC.PRG
* Relat" + CHR(243) + "rio de Clientes que Mais/Menos/N" + CHR(227) + "o
* Compram em Valores e Quantidades
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGRECMC.SCX (frmrelatorio)
*
* Layout FLAT: controles diretamente na Page1 do PageFrame
* Form: Width=800, Height=500
*==============================================================================

DEFINE CLASS Formsigrecmc AS FormBase

    *-- Dimensoes e aparencia (EXATAS do original SIGRECMC.SCX)
    Height      = 500
    Width       = 800
    DataSession = 2
    ShowWindow  = 1
    WindowType  = 1
    AutoCenter  = .T.
    BorderStyle = 2
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    ShowTips    = .T.

    *-- BO de relatorio
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Relat" + CHR(243) + "rio de Clientes que Mais/Menos/N" + ;
                CHR(227) + "o Compram em Valores e Quantidades"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            THIS.this_oRelatorio = CREATEOBJECT("sigrecmcBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar sigrecmcBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                IF !THIS.this_oRelatorio.CarregarDadosIniciais()
                    MsgErro(THIS.this_oRelatorio.this_cMensagemErro, "Erro")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                IF !THIS.this_oRelatorio.CarregarTiposOperacao()
                    MsgErro(THIS.this_oRelatorio.this_cMensagemErro, "Erro")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaDados()
                THIS.ConfigurarGrade()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarBINDEVENTs()
                THIS.AlternarPagina(1)

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.LimparCampos()
                ENDIF

                THIS.Visible = .T.
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar Formsigrecmc:" + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho
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
            .Caption   = THIS.Caption
            .FontName  = "Tahoma"
            .FontSize  = 12
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
            .Caption   = THIS.Caption
            .FontName  = "Tahoma"
            .FontSize  = 12
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - CommandGroup com 4 botoes (Visualizar/Imprimir/Excel/Encerrar)
    * Left=528 (equivalente ao btnReport.Left=525 do original)
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
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
            .Visible         = .T.
        ENDWITH

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
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
            .Visible         = .T.
        ENDWITH

        WITH THIS.cmg_4c_Botoes.Buttons(3)
            .Top             = 5
            .Left            = 137
            .Width           = 65
            .Height          = 70
            .Caption         = "Doc Excel"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .Picture         = gc_4c_CaminhoIcones + "relatorio_excel_26.jpg"
            .Visible         = .T.
        ENDWITH

        WITH THIS.cmg_4c_Botoes.Buttons(4)
            .Top             = 5
            .Left            = 203
            .Width           = 65
            .Height          = 70
            .Caption         = "Encerrar"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .Cancel          = .T.
            .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
            .Visible         = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - 1 pagina, abaixo do cabecalho
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
    * ConfigurarPaginaDados - Cria todos os controles de filtro na Page1
    * Coordenadas: original - 85 (Page1 comeca em Top=85 do form)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- Botao Graficos (cmdGgrafico1: Top=84, Left=12, W=116, H=51)
        loc_oPg.AddObject("cmd_4c_Graficos", "CommandButton")
        WITH loc_oPg.cmd_4c_Graficos
            .Top             = 0
            .Left            = 12
            .Width           = 116
            .Height          = 51
            .Caption         = "Gr" + CHR(225) + "ficos"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .PicturePosition = 1
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .Enabled         = .F.
            .Visible         = .T.
        ENDWITH

        *-- Empresa (Say8: Left=41, Top=144->59; Get_Empresa: L=96, T=141->56, W=33, H=21)
        loc_oPg.AddObject("lbl_4c_Empresa", "Label")
        WITH loc_oPg.lbl_4c_Empresa
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Empresa :"
            .Left      = 41
            .Top       = 59
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Empresa", "TextBox")
        WITH loc_oPg.txt_4c_Empresa
            .Height        = 21
            .Left          = 96
            .Top           = 56
            .Width         = 33
            .MaxLength     = 10
            .Format        = "K"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DEmpresa", "TextBox")
        WITH loc_oPg.txt_4c_DEmpresa
            .Height        = 21
            .Left          = 131
            .Top           = 56
            .Width         = 365
            .MaxLength     = 40
            .Format        = "K"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Movimentacao (lbl_dopes: L=13, T=169->84; get_nm_operacao: L=96, T=164->79)
        loc_oPg.AddObject("lbl_4c_DopEs", "Label")
        WITH loc_oPg.lbl_4c_DopEs
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
            .Left      = 13
            .Top       = 84
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_NmOperacao", "TextBox")
        WITH loc_oPg.txt_4c_NmOperacao
            .Height        = 25
            .Left          = 96
            .Top           = 79
            .Width         = 156
            .MaxLength     = 20
            .Format        = "K!"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Periodo (lbl_periodo: L=46, T=196->111; get_dt_inicial: L=96, T=191->106)
        loc_oPg.AddObject("lbl_4c_Periodo", "Label")
        WITH loc_oPg.lbl_4c_Periodo
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Per" + CHR(237) + "odo :"
            .Left      = 46
            .Top       = 111
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oPg.txt_4c_DtInicial
            .Height        = 25
            .Left          = 96
            .Top           = 106
            .Width         = 84
            .Format        = "K"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
            .Value         = DATE()
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_PeriodoA", "Label")
        WITH loc_oPg.lbl_4c_PeriodoA
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = CHR(224)
            .Left      = 189
            .Top       = 110
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DtFinal", "TextBox")
        WITH loc_oPg.txt_4c_DtFinal
            .Height        = 25
            .Left          = 206
            .Top           = 106
            .Width         = 84
            .Format        = "K"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
            .Value         = DATE()
            .Visible       = .T.
        ENDWITH

        *-- Moeda (lbl_moeda: L=50, T=222->137; get_moeda: L=96, T=218->133)
        loc_oPg.AddObject("lbl_4c_Moeda", "Label")
        WITH loc_oPg.lbl_4c_Moeda
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Moeda :"
            .Left      = 50
            .Top       = 137
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Moeda", "TextBox")
        WITH loc_oPg.txt_4c_Moeda
            .Height        = 25
            .Left          = 96
            .Top           = 133
            .Width         = 31
            .MaxLength     = 3
            .Format        = "K!"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_MoedaDesc", "TextBox")
        WITH loc_oPg.txt_4c_MoedaDesc
            .Height        = 25
            .Left          = 129
            .Top           = 133
            .Width         = 154
            .MaxLength     = 15
            .Format        = "K!"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Quantidade/Minimo (Say2: L=26, T=250->165; Get_Qtde: L=96, T=245->160)
        loc_oPg.AddObject("lbl_4c_Quantidade", "Label")
        WITH loc_oPg.lbl_4c_Quantidade
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Quantidade :"
            .Left      = 26
            .Top       = 165
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Qtde", "TextBox")
        WITH loc_oPg.txt_4c_Qtde
            .Height        = 25
            .Left          = 96
            .Top           = 160
            .Width         = 53
            .Format        = "K"
            .Alignment     = 3
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
            .Value         = 50
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_Minimo", "Label")
        WITH loc_oPg.lbl_4c_Minimo
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "M" + CHR(237) + "nimo :"
            .Left      = 162
            .Top       = 165
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_QtMin", "TextBox")
        WITH loc_oPg.txt_4c_QtMin
            .Height        = 25
            .Left          = 206
            .Top           = 160
            .Width         = 53
            .Format        = "K"
            .Alignment     = 3
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- Conta (lbl_estoque: L=53, T=276->191; getCdEstoque: L=96, T=272->187)
        loc_oPg.AddObject("lbl_4c_Conta", "Label")
        WITH loc_oPg.lbl_4c_Conta
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Conta :"
            .Left      = 53
            .Top       = 191
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_CdConta", "TextBox")
        WITH loc_oPg.txt_4c_CdConta
            .Height        = 25
            .Left          = 96
            .Top           = 187
            .Width         = 108
            .MaxLength     = 10
            .Format        = "K"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DsConta", "TextBox")
        WITH loc_oPg.txt_4c_DsConta
            .Height        = 25
            .Left          = 206
            .Top           = 187
            .Width         = 290
            .MaxLength     = 40
            .Format        = "K"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Vendedor (Say4: L=36, T=303->218; getCdVendedor: L=96, T=299->214)
        loc_oPg.AddObject("lbl_4c_Vendedor1", "Label")
        WITH loc_oPg.lbl_4c_Vendedor1
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Vendedor :"
            .Left      = 36
            .Top       = 218
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_CdVendedor", "TextBox")
        WITH loc_oPg.txt_4c_CdVendedor
            .Height        = 25
            .Left          = 96
            .Top           = 214
            .Width         = 108
            .MaxLength     = 10
            .Format        = "K"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DsVendedor", "TextBox")
        WITH loc_oPg.txt_4c_DsVendedor
            .Height        = 25
            .Left          = 206
            .Top           = 214
            .Width         = 290
            .MaxLength     = 40
            .Format        = "K"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Produto (lbl_codigo: L=44, T=330->245; get_cd_codigo: L=96, T=326->241)
        loc_oPg.AddObject("lbl_4c_Produto", "Label")
        WITH loc_oPg.lbl_4c_Produto
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Produto :"
            .Left      = 44
            .Top       = 245
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_CdProduto", "TextBox")
        WITH loc_oPg.txt_4c_CdProduto
            .Height        = 25
            .Left          = 96
            .Top           = 241
            .Width         = 108
            .MaxLength     = 14
            .Format        = "K!"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DsProduto", "TextBox")
        WITH loc_oPg.txt_4c_DsProduto
            .Height        = 25
            .Left          = 206
            .Top           = 241
            .Width         = 290
            .MaxLength     = 40
            .Format        = "K!"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Themes        = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Ordem (Say1: L=50, T=363->278; opt_ordem: L=93, T=356->271)
        loc_oPg.AddObject("lbl_4c_Ordem", "Label")
        WITH loc_oPg.lbl_4c_Ordem
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Ordem :"
            .Left      = 50
            .Top       = 278
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("ogp_4c_Ordem", "OptionGroup")
        WITH loc_oPg.ogp_4c_Ordem
            .AutoSize      = .T.
            .ButtonCount   = 3
            .BackStyle     = 0
            .BorderStyle   = 0
            .Height        = 62
            .Left          = 93
            .SpecialEffect = 0
            .Top           = 271
            .Width         = 107
            .Value         = 1
            .Visible       = .T.
        ENDWITH
        WITH loc_oPg.ogp_4c_Ordem.Buttons(1)
            .Caption   = "Mais Compram"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 5
            .Top       = 5
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.ogp_4c_Ordem.Buttons(2)
            .Caption   = "Menos Compram"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 5
            .Top       = 23
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.ogp_4c_Ordem.Buttons(3)
            .Caption   = "N" + CHR(227) + "o Compram"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 5
            .Top       = 42
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- chkCidade (L=227, T=362->277)
        loc_oPg.AddObject("chk_4c_Cidade", "CheckBox")
        WITH loc_oPg.chk_4c_Cidade
            .Left      = 227
            .Top       = 277
            .Height    = 15
            .Width     = 70
            .Caption   = "Cidades"
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Value     = 0
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- chkComparativo (L=227, T=380)
        loc_oPg.AddObject("chk_4c_Comparativo", "CheckBox")
        WITH loc_oPg.chk_4c_Comparativo
            .Left      = 227
            .Top       = 380
            .Height    = 15
            .Width     = 90
            .Caption   = "Comparativo"
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Value     = 0
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container1 com ChkDadosCli e chkValor (L=224, T=396->311, W=313, H=20)
        loc_oPg.AddObject("cnt_4c_OpcoesDados", "Container")
        WITH loc_oPg.cnt_4c_OpcoesDados
            .Top         = 311
            .Left        = 224
            .Width       = 313
            .Height      = 20
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPg.cnt_4c_OpcoesDados.AddObject("chk_4c_DadosCli", "CheckBox")
        WITH loc_oPg.cnt_4c_OpcoesDados.chk_4c_DadosCli
            .Top       = 2
            .Left      = 3
            .Height    = 15
            .Width     = 110
            .Caption   = "Dados do Cliente"
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Value     = 0
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPg.cnt_4c_OpcoesDados.AddObject("chk_4c_Valor", "CheckBox")
        WITH loc_oPg.cnt_4c_OpcoesDados.chk_4c_Valor
            .Top       = 2
            .Left      = 148
            .Height    = 15
            .Width     = 70
            .Caption   = "Com Valor"
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Value     = 0
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- Selecao (Say6: L=45, T=423->338)
        loc_oPg.AddObject("lbl_4c_Selecao", "Label")
        WITH loc_oPg.lbl_4c_Selecao
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Sele" + CHR(231) + CHR(227) + "o :"
            .Left      = 45
            .Top       = 338
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Opt_selrel (L=93, T=417->332, H=27, W=220, ButtonCount=2)
        loc_oPg.AddObject("ogp_4c_SelRel", "OptionGroup")
        WITH loc_oPg.ogp_4c_SelRel
            .AutoSize      = .T.
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .Height        = 27
            .Left          = 93
            .SpecialEffect = 0
            .Top           = 332
            .Width         = 225
            .Value         = 1
            .Visible       = .T.
        ENDWITH
        WITH loc_oPg.ogp_4c_SelRel.Buttons(1)
            .Caption   = "Valor"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 5
            .Top       = 6
            .Width     = 82
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.ogp_4c_SelRel.Buttons(2)
            .Caption   = "Quantidade"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 133
            .Top       = 5
            .Width     = 82
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Comparativo label (Say5: L=21, T=447->362)
        loc_oPg.AddObject("lbl_4c_LblCompara", "Label")
        WITH loc_oPg.lbl_4c_LblCompara
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Comparativo :"
            .Left      = 21
            .Top       = 362
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Opt_Compara (L=93, T=441->356, H=26, W=217, ButtonCount=2)
        loc_oPg.AddObject("ogp_4c_Compara", "OptionGroup")
        WITH loc_oPg.ogp_4c_Compara
            .AutoSize      = .T.
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .Height        = 26
            .Left          = 93
            .SpecialEffect = 0
            .Top           = 356
            .Width         = 222
            .Value         = 1
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        WITH loc_oPg.ogp_4c_Compara.Buttons(1)
            .Caption   = "Cliente"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 5
            .Top       = 6
            .Width     = 51
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.ogp_4c_Compara.Buttons(2)
            .Caption   = "Classifica" + CHR(231) + CHR(227) + "o"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 133
            .Top       = 5
            .Width     = 79
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Vendedor label 2 (Say7: L=36, T=470->385)
        loc_oPg.AddObject("lbl_4c_Vendedor2", "Label")
        WITH loc_oPg.lbl_4c_Vendedor2
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Vendedor :"
            .Left      = 36
            .Top       = 385
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Opt_MovCad (L=93, T=465->380, H=25, W=200, ButtonCount=2)
        loc_oPg.AddObject("ogp_4c_MovCad", "OptionGroup")
        WITH loc_oPg.ogp_4c_MovCad
            .AutoSize      = .T.
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .Height        = 25
            .Left          = 93
            .SpecialEffect = 0
            .Top           = 380
            .Width         = 200
            .Value         = 1
            .Visible       = .T.
        ENDWITH
        WITH loc_oPg.ogp_4c_MovCad.Buttons(1)
            .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 5
            .Top       = 5
            .AutoSize  = .T.
            .Value     = 1
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.ogp_4c_MovCad.Buttons(2)
            .Caption   = "Cadastro"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Left      = 133
            .Top       = 5
            .AutoSize  = .T.
            .Value     = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrade - Grid para tipos de operacao (GrdTipo original)
    * GrdTipo: Left=503, Top=141->56, W=228, H=218
    * cmd_4c_SelTudo: L=735, T=204; cmd_4c_Apaga: L=735, T=248
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrade()
        LOCAL loc_oPg, loc_oGrd
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        loc_oPg.AddObject("grd_4c_Dados", "Grid")
        loc_oGrd = loc_oPg.grd_4c_Dados
        WITH loc_oGrd
            .Top          = 56
            .Left         = 503
            .Width        = 228
            .Height       = 218
            .ColumnCount  = 2
            .AllowRowSizing = .F.
            .DeleteMark   = .F.
            .GridLines    = 3
            .HeaderHeight = 0
            .RowHeight    = 18
            .ScrollBars   = 2
            .RecordMark   = .F.
            .GridLineColor = RGB(255, 255, 255)
            .Themes       = .F.
            .Visible      = .T.
        ENDWITH

        *-- Column1: CheckBox para nMarca (Width=20, Sparse=.F.)
        WITH loc_oGrd.Column1
            .Width         = 20
            .Sparse        = .F.
            .Enabled       = .T.
        ENDWITH
        loc_oGrd.Column1.AddObject("chk_4c_Mark", "CheckBox")
        WITH loc_oGrd.Column1.chk_4c_Mark
            .Caption   = ""
            .Alignment = 2
            .BackStyle = 0
            .Themes    = .F.
        ENDWITH
        loc_oGrd.Column1.CurrentControl = "chk_4c_Mark"

        *-- Column2: TextBox para Descri (Width=205, ReadOnly=.T.)
        WITH loc_oGrd.Column2
            .Width    = 205
            .ReadOnly = .T.
            .Enabled  = .T.
        ENDWITH
        WITH loc_oGrd.Column2.Text1
            .BorderStyle = 0
            .ReadOnly    = .T.
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        *-- Vincular grid ao cursor CrSigCdTom
        IF USED("CrSigCdTom")
            loc_oGrd.RecordSource              = "CrSigCdTom"
            loc_oGrd.Column1.ControlSource     = "CrSigCdTom.nMarca"
            loc_oGrd.Column2.ControlSource     = "CrSigCdTom.Descri"
        ENDIF

        *-- Botao Selecionar todos (SelTudo: L=735, T=204, W=45, H=45)
        loc_oPg.AddObject("cmd_4c_SelTudo", "CommandButton")
        WITH loc_oPg.cmd_4c_SelTudo
            .Top           = 204
            .Left          = 735
            .Width         = 45
            .Height        = 45
            .Caption       = ""
            .FontName      = "Verdana"
            .FontSize      = 8
            .ForeColor     = RGB(36, 84, 155)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .TabStop       = .F.
            .ToolTipText   = "Selecionar"
            .Visible       = .T.
        ENDWITH

        *-- Botao Desmarcar (apaga: L=735, T=248, W=45, H=45)
        loc_oPg.AddObject("cmd_4c_Apaga", "CommandButton")
        WITH loc_oPg.cmd_4c_Apaga
            .Top           = 248
            .Left          = 735
            .Width         = 45
            .Height        = 45
            .Caption       = ""
            .FontName      = "Verdana"
            .FontSize      = 8
            .ForeColor     = RGB(36, 84, 155)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .TabStop       = .F.
            .ToolTipText   = "Desmarcar"
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Container "Aguarde!!!" durante processamento
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        loc_oPg.AddObject("cnt_4c_Mensagem", "Container")
        WITH loc_oPg.cnt_4c_Mensagem
            .Top         = 150
            .Left        = 175
            .Width       = 473
            .Height      = 56
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .F.
        ENDWITH

        loc_oPg.cnt_4c_Mensagem.AddObject("lbl_4c_LblMensagem", "Label")
        WITH loc_oPg.cnt_4c_Mensagem.lbl_4c_LblMensagem
            .Top       = 18
            .Left      = 20
            .Width     = 445
            .Height    = 22
            .Caption   = "Aguarde!!!"
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Alignment = 2
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Inicializa campos com valores padrao do BO
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        IF VARTYPE(THIS.this_oRelatorio) = "O"
            loc_oPg.txt_4c_Empresa.Value    = THIS.this_oRelatorio.this_cEmpresa
            loc_oPg.txt_4c_DEmpresa.Value   = THIS.this_oRelatorio.this_cDEmpresa
            loc_oPg.txt_4c_Moeda.Value      = THIS.this_oRelatorio.this_cMoedaPadrao
            loc_oPg.txt_4c_MoedaDesc.Value  = THIS.this_oRelatorio.this_cMoedaDesc
        ELSE
            loc_oPg.txt_4c_Empresa.Value    = ""
            loc_oPg.txt_4c_DEmpresa.Value   = ""
            loc_oPg.txt_4c_Moeda.Value      = ""
            loc_oPg.txt_4c_MoedaDesc.Value  = ""
        ENDIF

        loc_oPg.txt_4c_NmOperacao.Value             = ""
        loc_oPg.txt_4c_DtInicial.Value              = DATE()
        loc_oPg.txt_4c_DtFinal.Value                = DATE()
        loc_oPg.txt_4c_Qtde.Value                   = 50
        loc_oPg.txt_4c_QtMin.Value                  = 0
        loc_oPg.txt_4c_CdConta.Value                = ""
        loc_oPg.txt_4c_DsConta.Value                = ""
        loc_oPg.txt_4c_CdVendedor.Value             = ""
        loc_oPg.txt_4c_DsVendedor.Value             = ""
        loc_oPg.txt_4c_CdProduto.Value              = ""
        loc_oPg.txt_4c_DsProduto.Value              = ""
        loc_oPg.ogp_4c_Ordem.Value                  = 1
        loc_oPg.ogp_4c_SelRel.Value                 = 1
        loc_oPg.ogp_4c_Compara.Value                = 1
        loc_oPg.ogp_4c_MovCad.Value                 = 1
        loc_oPg.chk_4c_Cidade.Value                 = 0
        loc_oPg.chk_4c_Comparativo.Value            = 0
        loc_oPg.cnt_4c_OpcoesDados.chk_4c_DadosCli.Value = 0
        loc_oPg.cnt_4c_OpcoesDados.chk_4c_Valor.Value    = 0
        loc_oPg.ogp_4c_Compara.Enabled              = .F.
        loc_oPg.cmd_4c_Graficos.Enabled             = .F.
        loc_oPg.grd_4c_Dados.Enabled                = .T.
        loc_oPg.cmd_4c_SelTudo.Enabled              = .T.
        loc_oPg.cmd_4c_Apaga.Enabled                = .T.
        THIS.AjustarCamposMoeda()
        THIS.AjustarCamposProduto()
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O" AND ;
           VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND ;
           par_nPagina <= THIS.pgf_4c_Paginas.PageCount
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBINDEVENTs
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBINDEVENTs()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        BINDEVENT(THIS.cmg_4c_Botoes, "Click", THIS, "CmgBotoesClick")

        BINDEVENT(loc_oPg.txt_4c_Empresa,     "KeyPress", THIS, "TxtEmpresaKeyPress")
        BINDEVENT(loc_oPg.txt_4c_DEmpresa,    "KeyPress", THIS, "TxtDEmpresaKeyPress")
        BINDEVENT(loc_oPg.txt_4c_NmOperacao,  "KeyPress", THIS, "TxtNmOperacaoKeyPress")
        BINDEVENT(loc_oPg.txt_4c_DtInicial,   "KeyPress", THIS, "TxtDtInicialKeyPress")
        BINDEVENT(loc_oPg.txt_4c_DtFinal,     "KeyPress", THIS, "TxtDtFinalKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Moeda,       "KeyPress", THIS, "TxtMoedaKeyPress")
        BINDEVENT(loc_oPg.txt_4c_MoedaDesc,   "KeyPress", THIS, "TxtMoedaDescKeyPress")
        BINDEVENT(loc_oPg.txt_4c_CdConta,     "KeyPress", THIS, "TxtCdContaKeyPress")
        BINDEVENT(loc_oPg.txt_4c_DsConta,     "KeyPress", THIS, "TxtDsContaKeyPress")
        BINDEVENT(loc_oPg.txt_4c_CdVendedor,  "KeyPress", THIS, "TxtCdVendedorKeyPress")
        BINDEVENT(loc_oPg.txt_4c_DsVendedor,  "KeyPress", THIS, "TxtDsVendedorKeyPress")
        BINDEVENT(loc_oPg.txt_4c_CdProduto,   "KeyPress", THIS, "TxtCdProdutoKeyPress")
        BINDEVENT(loc_oPg.txt_4c_DsProduto,   "KeyPress", THIS, "TxtDsProdutoKeyPress")

        *-- DblClick para campos com lookup
        BINDEVENT(loc_oPg.txt_4c_Empresa,    "DblClick", THIS, "TxtEmpresaDblClick")
        BINDEVENT(loc_oPg.txt_4c_DEmpresa,   "DblClick", THIS, "TxtDEmpresaDblClick")
        BINDEVENT(loc_oPg.txt_4c_NmOperacao, "DblClick", THIS, "TxtNmOperacaoDblClick")
        BINDEVENT(loc_oPg.txt_4c_Moeda,      "DblClick", THIS, "TxtMoedaDblClick")
        BINDEVENT(loc_oPg.txt_4c_MoedaDesc,  "DblClick", THIS, "TxtMoedaDescDblClick")
        BINDEVENT(loc_oPg.txt_4c_CdConta,    "DblClick", THIS, "TxtCdContaDblClick")
        BINDEVENT(loc_oPg.txt_4c_DsConta,    "DblClick", THIS, "TxtDsContaDblClick")
        BINDEVENT(loc_oPg.txt_4c_CdVendedor, "DblClick", THIS, "TxtCdVendedorDblClick")
        BINDEVENT(loc_oPg.txt_4c_DsVendedor, "DblClick", THIS, "TxtDsVendedorDblClick")
        BINDEVENT(loc_oPg.txt_4c_CdProduto,  "DblClick", THIS, "TxtCdProdutoDblClick")
        BINDEVENT(loc_oPg.txt_4c_DsProduto,  "DblClick", THIS, "TxtDsProdutoDblClick")

        BINDEVENT(loc_oPg.ogp_4c_Ordem,  "InteractiveChange", THIS, "OgpOrdemInteractiveChange")
        BINDEVENT(loc_oPg.ogp_4c_SelRel, "Click",             THIS, "OgpSelRelClick")
        BINDEVENT(loc_oPg.ogp_4c_MovCad, "InteractiveChange", THIS, "OgpMovCadInteractiveChange")

        BINDEVENT(loc_oPg.chk_4c_Cidade,       "Click", THIS, "ChkCidadeClick")
        BINDEVENT(loc_oPg.chk_4c_Comparativo,  "Click", THIS, "ChkComparativoClick")
        BINDEVENT(loc_oPg.cnt_4c_OpcoesDados.chk_4c_DadosCli, "Click", THIS, "ChkDadosCliClick")
        BINDEVENT(loc_oPg.cnt_4c_OpcoesDados.chk_4c_Valor,    "Click", THIS, "ChkValorClick")

        BINDEVENT(loc_oPg.cmd_4c_SelTudo, "Click", THIS, "CmdSelTudoClick")
        BINDEVENT(loc_oPg.cmd_4c_Apaga,   "Click", THIS, "CmdApagaClick")
        BINDEVENT(loc_oPg.cmd_4c_Graficos,"Click", THIS, "CmdGraficosClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarCamposMoeda - Habilita/desabilita desc moeda conforme opt_selrel
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarCamposMoeda()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF VARTYPE(loc_oPg) = "O"
            LOCAL loc_lValor
            loc_lValor = (loc_oPg.ogp_4c_SelRel.Value = 1)
            loc_oPg.txt_4c_Moeda.Enabled     = loc_lValor
            loc_oPg.txt_4c_MoedaDesc.Enabled = loc_lValor
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarCamposProduto - Quando produto preenchido, SelRel = Quantidade
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarCamposProduto()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF VARTYPE(loc_oPg) = "O"
            LOCAL loc_lTemProduto
            loc_lTemProduto = !EMPTY(ALLTRIM(loc_oPg.txt_4c_CdProduto.Value))
            IF loc_lTemProduto
                loc_oPg.ogp_4c_SelRel.Value   = 2
                loc_oPg.ogp_4c_SelRel.Enabled = .F.
            ELSE
                loc_oPg.ogp_4c_SelRel.Enabled = .T.
            ENDIF
            THIS.AjustarCamposMoeda()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere filtros do form para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            .this_cEmpresa    = ALLTRIM(loc_oPg.txt_4c_Empresa.Value)
            .this_cDEmpresa   = ALLTRIM(loc_oPg.txt_4c_DEmpresa.Value)
            .this_cNmOperacao = ALLTRIM(loc_oPg.txt_4c_NmOperacao.Value)
            .this_dDtInicial  = loc_oPg.txt_4c_DtInicial.Value
            .this_dDtFinal    = loc_oPg.txt_4c_DtFinal.Value
            .this_cMoeda      = ALLTRIM(loc_oPg.txt_4c_Moeda.Value)
            .this_cMoedaDesc  = ALLTRIM(loc_oPg.txt_4c_MoedaDesc.Value)
            .this_nQtde       = loc_oPg.txt_4c_Qtde.Value
            .this_nQtMin      = loc_oPg.txt_4c_QtMin.Value
            .this_cCdConta    = ALLTRIM(loc_oPg.txt_4c_CdConta.Value)
            .this_cDsConta    = ALLTRIM(loc_oPg.txt_4c_DsConta.Value)
            .this_cCdVendedor = ALLTRIM(loc_oPg.txt_4c_CdVendedor.Value)
            .this_cDsVendedor = ALLTRIM(loc_oPg.txt_4c_DsVendedor.Value)
            .this_cCdProduto  = ALLTRIM(loc_oPg.txt_4c_CdProduto.Value)
            .this_cDsProduto  = ALLTRIM(loc_oPg.txt_4c_DsProduto.Value)
            .this_nOrdem      = loc_oPg.ogp_4c_Ordem.Value
            .this_nOptSelRel  = loc_oPg.ogp_4c_SelRel.Value
            .this_nOptCompara = loc_oPg.ogp_4c_Compara.Value
            .this_nOptMovCad  = loc_oPg.ogp_4c_MovCad.Value
            .this_nComparativo = loc_oPg.chk_4c_Comparativo.Value
            .this_nChkCidade  = loc_oPg.chk_4c_Cidade.Value
            .this_nChkDadosCli = loc_oPg.cnt_4c_OpcoesDados.chk_4c_DadosCli.Value
            .this_nChkValor   = loc_oPg.cnt_4c_OpcoesDados.chk_4c_Valor.Value
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            loc_oPg.txt_4c_Empresa.Value    = NVL(.this_cEmpresa,    "")
            loc_oPg.txt_4c_DEmpresa.Value   = NVL(.this_cDEmpresa,   "")
            loc_oPg.txt_4c_NmOperacao.Value = NVL(.this_cNmOperacao, "")
            loc_oPg.txt_4c_DtInicial.Value  = IIF(EMPTY(.this_dDtInicial), DATE(), .this_dDtInicial)
            loc_oPg.txt_4c_DtFinal.Value    = IIF(EMPTY(.this_dDtFinal),   DATE(), .this_dDtFinal)
            loc_oPg.txt_4c_Moeda.Value      = NVL(.this_cMoeda,      "")
            loc_oPg.txt_4c_MoedaDesc.Value  = NVL(.this_cMoedaDesc,  "")
            loc_oPg.txt_4c_Qtde.Value       = NVL(.this_nQtde,  50)
            loc_oPg.txt_4c_QtMin.Value      = NVL(.this_nQtMin,  0)
            loc_oPg.txt_4c_CdConta.Value    = NVL(.this_cCdConta,    "")
            loc_oPg.txt_4c_DsConta.Value    = NVL(.this_cDsConta,    "")
            loc_oPg.txt_4c_CdVendedor.Value = NVL(.this_cCdVendedor, "")
            loc_oPg.txt_4c_DsVendedor.Value = NVL(.this_cDsVendedor, "")
            loc_oPg.txt_4c_CdProduto.Value  = NVL(.this_cCdProduto,  "")
            loc_oPg.txt_4c_DsProduto.Value  = NVL(.this_cDsProduto,  "")
            loc_oPg.ogp_4c_Ordem.Value      = IIF(.this_nOrdem >= 1 AND .this_nOrdem <= 3, .this_nOrdem, 1)
            loc_oPg.ogp_4c_SelRel.Value     = IIF(.this_nOptSelRel >= 1 AND .this_nOptSelRel <= 2, .this_nOptSelRel, 1)
            loc_oPg.ogp_4c_Compara.Value    = IIF(.this_nOptCompara >= 1 AND .this_nOptCompara <= 2, .this_nOptCompara, 1)
            loc_oPg.ogp_4c_MovCad.Value     = IIF(.this_nOptMovCad >= 1 AND .this_nOptMovCad <= 2, .this_nOptMovCad, 1)
            loc_oPg.chk_4c_Comparativo.Value = NVL(.this_nComparativo, 0)
            loc_oPg.chk_4c_Cidade.Value      = NVL(.this_nChkCidade,   0)
            loc_oPg.cnt_4c_OpcoesDados.chk_4c_DadosCli.Value = NVL(.this_nChkDadosCli, 0)
            loc_oPg.cnt_4c_OpcoesDados.chk_4c_Valor.Value    = NVL(.this_nChkValor,    0)
        ENDWITH
        THIS.AjustarCamposMoeda()
        THIS.AjustarCamposProduto()
    ENDPROC

    *==========================================================================
    * HANDLERS DOS BOTOES PRINCIPAIS
    *==========================================================================

    PROCEDURE CmgBotoesClick()
        LOCAL loc_nBotao
        loc_nBotao = THIS.cmg_4c_Botoes.Value
        DO CASE
        CASE loc_nBotao = 1
            THIS.BtnVisualizarClick()
        CASE loc_nBotao = 2
            THIS.BtnImprimirClick()
        CASE loc_nBotao = 3
            THIS.BtnExcelClick()
        CASE loc_nBotao = 4
            THIS.BtnEncerrarClick()
        ENDCASE
    ENDPROC

    PROCEDURE BtnVisualizarClick()
        THIS.FormParaRelatorio()
        IF THIS.this_oRelatorio.ValidarFiltros()
            THIS.MostrarAguarde()
            THIS.this_oRelatorio.Visualizar()
            THIS.OcultarAguarde()
        ELSE
            MsgAviso(THIS.this_oRelatorio.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
        ENDIF
    ENDPROC

    PROCEDURE BtnImprimirClick()
        THIS.FormParaRelatorio()
        IF THIS.this_oRelatorio.ValidarFiltros()
            THIS.MostrarAguarde()
            THIS.this_oRelatorio.Imprimir()
            THIS.OcultarAguarde()
        ELSE
            MsgAviso(THIS.this_oRelatorio.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
        ENDIF
    ENDPROC

    PROCEDURE BtnExcelClick()
        MsgInfo("Fun" + CHR(231) + CHR(227) + "o Excel n" + CHR(227) + ;
            "o dispon" + CHR(237) + "vel neste relat" + CHR(243) + "rio.", "Informa" + CHR(231) + CHR(227) + "o")
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    PROCEDURE BtnCancelarClick()
        THIS.BtnEncerrarClick()
    ENDPROC

    PROCEDURE BtnIncluirClick()
        THIS.LimparCampos()
    ENDPROC

    PROCEDURE BtnAlterarClick()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF VARTYPE(loc_oPg) = "O"
            loc_oPg.txt_4c_NmOperacao.SetFocus()
        ENDIF
    ENDPROC

    PROCEDURE BtnExcluirClick()
        THIS.LimparCampos()
    ENDPROC

    *==========================================================================
    * HANDLERS DE AGUARDE
    *==========================================================================

    PROCEDURE MostrarAguarde()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF VARTYPE(loc_oPg.cnt_4c_Mensagem) = "O"
            loc_oPg.cnt_4c_Mensagem.Visible = .T.
            loc_oPg.cnt_4c_Mensagem.Refresh()
            THIS.Refresh()
            DOEVENTS
        ENDIF
    ENDPROC

    PROCEDURE OcultarAguarde()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF VARTYPE(loc_oPg.cnt_4c_Mensagem) = "O"
            loc_oPg.cnt_4c_Mensagem.Visible = .F.
        ENDIF
    ENDPROC

    *==========================================================================
    * HANDLERS DE OPTIONGROUPS E CHECKBOXES
    *==========================================================================

    *-- opt_ordem.InteractiveChange: Value=3 (Nao Compram) -> MovCad=2, Cidade=0
    PROCEDURE OgpOrdemInteractiveChange()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF loc_oPg.ogp_4c_Ordem.Value = 3
            loc_oPg.ogp_4c_MovCad.Value    = 2
            loc_oPg.chk_4c_Cidade.Value    = 0
        ENDIF
    ENDPROC

    *-- Opt_selrel.Click: Valor -> habilita moeda; Quantidade -> desabilita
    PROCEDURE OgpSelRelClick()
        THIS.AjustarCamposMoeda()
        THIS.Refresh()
    ENDPROC

    *-- Opt_MovCad.InteractiveChange: Value=1 (Movimentacao) -> Ordem=1
    PROCEDURE OgpMovCadInteractiveChange()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF loc_oPg.ogp_4c_MovCad.Value = 1
            loc_oPg.ogp_4c_Ordem.Value = 1
        ENDIF
    ENDPROC

    *-- Comparativo.Click
    PROCEDURE ChkComparativoClick()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        LOCAL loc_lComparativo
        loc_lComparativo = (loc_oPg.chk_4c_Comparativo.Value = 1)
        IF loc_lComparativo AND loc_oPg.ogp_4c_SelRel.Value = 1
            loc_oPg.ogp_4c_Compara.Enabled  = .T.
            loc_oPg.cmd_4c_Graficos.Enabled = .T.
        ELSE
            loc_oPg.ogp_4c_Compara.Enabled  = .F.
            loc_oPg.cmd_4c_Graficos.Enabled = .F.
        ENDIF
        IF loc_lComparativo
            loc_oPg.chk_4c_Cidade.Value = 0
        ENDIF
        loc_oPg.cnt_4c_OpcoesDados.chk_4c_DadosCli.Value = 0
        loc_oPg.cnt_4c_OpcoesDados.chk_4c_Valor.Value    = 0
    ENDPROC

    *-- chkCidade.Click
    PROCEDURE ChkCidadeClick()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF loc_oPg.chk_4c_Cidade.Value = 1
            loc_oPg.chk_4c_Comparativo.Value = 0
            IF loc_oPg.ogp_4c_Ordem.Value = 3
                loc_oPg.ogp_4c_Ordem.Value = 1
            ENDIF
        ENDIF
        loc_oPg.cnt_4c_OpcoesDados.chk_4c_DadosCli.Value = 0
        loc_oPg.cnt_4c_OpcoesDados.chk_4c_Valor.Value    = 0
        loc_oPg.ogp_4c_Compara.Enabled  = .F.
        loc_oPg.cmd_4c_Graficos.Enabled = .F.
    ENDPROC

    *-- ChkDadosCli.Click
    PROCEDURE ChkDadosCliClick()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF loc_oPg.cnt_4c_OpcoesDados.chk_4c_DadosCli.Value = 1
            loc_oPg.cmd_4c_Graficos.Enabled  = .F.
            loc_oPg.chk_4c_Cidade.Value      = 0
            loc_oPg.chk_4c_Comparativo.Value = 0
            loc_oPg.ogp_4c_Compara.Enabled   = .F.
        ENDIF
    ENDPROC

    *-- ChkValor.Click
    PROCEDURE ChkValorClick()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF loc_oPg.cnt_4c_OpcoesDados.chk_4c_Valor.Value = 1
            loc_oPg.cmd_4c_Graficos.Enabled             = .F.
            loc_oPg.chk_4c_Cidade.Value                 = 0
            loc_oPg.chk_4c_Comparativo.Value            = 0
            loc_oPg.cnt_4c_OpcoesDados.chk_4c_DadosCli.Value = 1
            loc_oPg.ogp_4c_Compara.Enabled              = .F.
        ENDIF
    ENDPROC

    *==========================================================================
    * HANDLERS DOS BOTOES DA GRADE
    *==========================================================================

    PROCEDURE CmdSelTudoClick()
        IF USED("CrSigCdTom")
            SELECT CrSigCdTom
            REPLACE ALL CrSigCdTom.nMarca WITH 1
            GO TOP
            THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE CmdApagaClick()
        IF USED("CrSigCdTom")
            SELECT CrSigCdTom
            REPLACE ALL CrSigCdTom.nMarca WITH 0
            GO TOP
            THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE CmdGraficosClick()
        MsgInfo("Gr" + CHR(225) + "ficos n" + CHR(227) + "o dispon" + CHR(237) + ;
            "vel nesta vers" + CHR(227) + "o.", "Informa" + CHR(231) + CHR(227) + "o")
    ENDPROC

    *==========================================================================
    * KEYPRESS HANDLERS
    *==========================================================================

    PROCEDURE TxtEmpresaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            LOCAL loc_cValor
            loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value)
            IF EMPTY(loc_cValor)
                THIS.pgf_4c_Paginas.Page1.txt_4c_DEmpresa.Value = ""
            ELSE
                THIS.AbrirBuscaEmpresa("C")
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TxtDEmpresaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            LOCAL loc_cValor
            loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DEmpresa.Value)
            IF EMPTY(loc_cValor)
                THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value = ""
            ELSE
                THIS.AbrirBuscaEmpresa("D")
            ENDIF
        ENDIF
    ENDPROC

    *-- NmOperacao: Valid logic - quando preenchido, desabilita grade e botoes selecao
    PROCEDURE TxtNmOperacaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            LOCAL loc_cValor, loc_oPg
            loc_oPg  = THIS.pgf_4c_Paginas.Page1
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_NmOperacao.Value)
            IF !EMPTY(loc_cValor)
                THIS.AbrirBuscaOperacao()
                loc_oPg.grd_4c_Dados.Enabled   = .F.
                loc_oPg.cmd_4c_Apaga.Enabled   = .F.
                loc_oPg.cmd_4c_SelTudo.Enabled = .F.
            ELSE
                loc_oPg.grd_4c_Dados.Enabled   = .T.
                loc_oPg.cmd_4c_Apaga.Enabled   = .T.
                loc_oPg.cmd_4c_SelTudo.Enabled = .T.
            ENDIF
        ENDIF
    ENDPROC

    *-- DtInicial: valida intervalo maximo de 6 anos
    PROCEDURE TxtDtInicialKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_dDti, loc_dDtf
        loc_oPg  = THIS.pgf_4c_Paginas.Page1
        loc_dDti = loc_oPg.txt_4c_DtInicial.Value
        loc_dDtf = loc_oPg.txt_4c_DtFinal.Value
        IF VARTYPE(loc_dDti) = "D" AND VARTYPE(loc_dDtf) = "D"
            IF (YEAR(loc_dDtf) - YEAR(loc_dDti)) >= 6
                MsgAviso("O per" + CHR(237) + "odo n" + CHR(227) + "o pode passar de 6 anos!!", ;
                    "Aten" + CHR(231) + CHR(227) + "o!!")
                THIS.cmg_4c_Botoes.Buttons(1).Enabled = .F.
                THIS.cmg_4c_Botoes.Buttons(2).Enabled = .F.
                THIS.cmg_4c_Botoes.Buttons(3).Enabled = .F.
            ELSE
                THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.
                THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
                THIS.cmg_4c_Botoes.Buttons(3).Enabled = .T.
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TxtDtFinalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_dDti, loc_dDtf
        loc_oPg  = THIS.pgf_4c_Paginas.Page1
        loc_dDti = loc_oPg.txt_4c_DtInicial.Value
        loc_dDtf = loc_oPg.txt_4c_DtFinal.Value
        IF VARTYPE(loc_dDti) = "D" AND VARTYPE(loc_dDtf) = "D"
            IF (YEAR(loc_dDtf) - YEAR(loc_dDti)) >= 6
                MsgAviso("O per" + CHR(237) + "odo n" + CHR(227) + "o pode passar de 6 anos!!", ;
                    "Aten" + CHR(231) + CHR(227) + "o!!")
                THIS.cmg_4c_Botoes.Buttons(1).Enabled = .F.
                THIS.cmg_4c_Botoes.Buttons(2).Enabled = .F.
                THIS.cmg_4c_Botoes.Buttons(3).Enabled = .F.
            ELSE
                THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.
                THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
                THIS.cmg_4c_Botoes.Buttons(3).Enabled = .T.
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TxtMoedaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            LOCAL loc_cValor
            loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Moeda.Value)
            IF EMPTY(loc_cValor)
                THIS.pgf_4c_Paginas.Page1.txt_4c_Moeda.Value     = ""
                THIS.pgf_4c_Paginas.Page1.txt_4c_MoedaDesc.Value = ""
            ELSE
                THIS.AbrirBuscaMoeda("C")
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TxtMoedaDescKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            LOCAL loc_cValor
            loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_MoedaDesc.Value)
            IF EMPTY(loc_cValor)
                THIS.pgf_4c_Paginas.Page1.txt_4c_Moeda.Value     = ""
                THIS.pgf_4c_Paginas.Page1.txt_4c_MoedaDesc.Value = ""
            ELSE
                THIS.AbrirBuscaMoeda("D")
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TxtCdContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            LOCAL loc_cValor
            loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CdConta.Value)
            IF EMPTY(loc_cValor)
                THIS.pgf_4c_Paginas.Page1.txt_4c_DsConta.Value = ""
            ELSE
                THIS.AbrirBuscaConta("C")
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TxtDsContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            LOCAL loc_cValor
            loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DsConta.Value)
            IF EMPTY(loc_cValor)
                THIS.pgf_4c_Paginas.Page1.txt_4c_CdConta.Value = ""
            ELSE
                THIS.AbrirBuscaConta("D")
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TxtCdVendedorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            LOCAL loc_cValor
            loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CdVendedor.Value)
            IF EMPTY(loc_cValor)
                THIS.pgf_4c_Paginas.Page1.txt_4c_DsVendedor.Value = ""
            ELSE
                THIS.AbrirBuscaVendedor("C")
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TxtDsVendedorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            LOCAL loc_cValor
            loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DsVendedor.Value)
            IF EMPTY(loc_cValor)
                THIS.pgf_4c_Paginas.Page1.txt_4c_CdVendedor.Value = ""
            ELSE
                THIS.AbrirBuscaVendedor("D")
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TxtCdProdutoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            LOCAL loc_cValor
            loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_CdProduto.Value)
            IF EMPTY(loc_cValor)
                THIS.pgf_4c_Paginas.Page1.txt_4c_DsProduto.Value = ""
                THIS.AjustarCamposProduto()
            ELSE
                THIS.AbrirBuscaProduto("C")
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TxtDsProdutoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            LOCAL loc_cValor
            loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DsProduto.Value)
            IF EMPTY(loc_cValor)
                THIS.pgf_4c_Paginas.Page1.txt_4c_CdProduto.Value = ""
                THIS.AjustarCamposProduto()
            ELSE
                THIS.AbrirBuscaProduto("D")
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * DBLCLICK HANDLERS
    *==========================================================================

    PROCEDURE TxtEmpresaDblClick()
        THIS.AbrirBuscaEmpresa("C")
    ENDPROC

    PROCEDURE TxtDEmpresaDblClick()
        THIS.AbrirBuscaEmpresa("D")
    ENDPROC

    PROCEDURE TxtNmOperacaoDblClick()
        THIS.AbrirBuscaOperacao()
    ENDPROC

    PROCEDURE TxtMoedaDblClick()
        THIS.AbrirBuscaMoeda("C")
    ENDPROC

    PROCEDURE TxtMoedaDescDblClick()
        THIS.AbrirBuscaMoeda("D")
    ENDPROC

    PROCEDURE TxtCdContaDblClick()
        THIS.AbrirBuscaConta("C")
    ENDPROC

    PROCEDURE TxtDsContaDblClick()
        THIS.AbrirBuscaConta("D")
    ENDPROC

    PROCEDURE TxtCdVendedorDblClick()
        THIS.AbrirBuscaVendedor("C")
    ENDPROC

    PROCEDURE TxtDsVendedorDblClick()
        THIS.AbrirBuscaVendedor("D")
    ENDPROC

    PROCEDURE TxtCdProdutoDblClick()
        THIS.AbrirBuscaProduto("C")
    ENDPROC

    PROCEDURE TxtDsProdutoDblClick()
        THIS.AbrirBuscaProduto("D")
    ENDPROC

    *==========================================================================
    * METODOS DE LOOKUP (FormBuscaAuxiliar)
    *==========================================================================

    PROTECTED PROCEDURE AbrirBuscaEmpresa(par_cTipo)
        LOCAL loc_oBusca, loc_oPg, loc_cValor, loc_cCampo
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF par_cTipo = "C"
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_Empresa.Value)
            loc_cCampo = "cemps"
        ELSE
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_DEmpresa.Value)
            loc_cCampo = "razas"
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", "cursor_4c_BuscaEmpresa", loc_cCampo, ;
            loc_cValor, "Empresa")
        IF VARTYPE(loc_oBusca) != "O"
            RETURN
        ENDIF
        loc_oBusca.mAddColuna("cemps", "", "C" + CHR(243) + "digo")
        loc_oBusca.mAddColuna("razas", "", "Raz" + CHR(227) + "o Social")
        loc_oBusca.Show()

        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpresa")
            SELECT cursor_4c_BuscaEmpresa
            IF !EOF()
                loc_oPg.txt_4c_Empresa.Value  = ALLTRIM(cemps)
                loc_oPg.txt_4c_DEmpresa.Value = ALLTRIM(razas)
            ENDIF
        ENDIF
        IF USED("cursor_4c_BuscaEmpresa")
            USE IN cursor_4c_BuscaEmpresa
        ENDIF
        loc_oBusca.Release()
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaOperacao()
        LOCAL loc_oBusca, loc_oPg, loc_cValor
        loc_oPg   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_NmOperacao.Value)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdOpe", "cursor_4c_BuscaOpe", "dopes", ;
            loc_cValor, "Opera" + CHR(231) + CHR(227) + "o")
        IF VARTYPE(loc_oBusca) != "O"
            RETURN
        ENDIF
        loc_oBusca.mAddColuna("dopes", "", "C" + CHR(243) + "digo")
        loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
        loc_oBusca.Show()

        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpe")
            SELECT cursor_4c_BuscaOpe
            IF !EOF()
                loc_oPg.txt_4c_NmOperacao.Value = ALLTRIM(dopes)
            ENDIF
        ENDIF
        IF USED("cursor_4c_BuscaOpe")
            USE IN cursor_4c_BuscaOpe
        ENDIF
        loc_oBusca.Release()
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaMoeda(par_cTipo)
        LOCAL loc_oBusca, loc_oPg, loc_cValor, loc_cCampo
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF par_cTipo = "C"
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_Moeda.Value)
            loc_cCampo = "cmoes"
        ELSE
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_MoedaDesc.Value)
            loc_cCampo = "dmoes"
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdMoe", "cursor_4c_BuscaMoeda", loc_cCampo, ;
            loc_cValor, "Moeda")
        IF VARTYPE(loc_oBusca) != "O"
            RETURN
        ENDIF
        loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
        loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
        loc_oBusca.Show()

        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
            SELECT cursor_4c_BuscaMoeda
            IF !EOF()
                loc_oPg.txt_4c_Moeda.Value     = ALLTRIM(cmoes)
                loc_oPg.txt_4c_MoedaDesc.Value = ALLTRIM(dmoes)
            ENDIF
        ENDIF
        IF USED("cursor_4c_BuscaMoeda")
            USE IN cursor_4c_BuscaMoeda
        ENDIF
        loc_oBusca.Release()
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaConta(par_cTipo)
        LOCAL loc_oBusca, loc_oPg, loc_cValor, loc_cCampo
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF par_cTipo = "C"
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_CdConta.Value)
            loc_cCampo = "iclis"
        ELSE
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsConta.Value)
            loc_cCampo = "rclis"
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", "cursor_4c_BuscaConta", loc_cCampo, ;
            loc_cValor, "Conta/Cliente")
        IF VARTYPE(loc_oBusca) != "O"
            RETURN
        ENDIF
        loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
        loc_oBusca.mAddColuna("rclis", "", "Nome")
        loc_oBusca.Show()

        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
            SELECT cursor_4c_BuscaConta
            IF !EOF()
                loc_oPg.txt_4c_CdConta.Value = ALLTRIM(iclis)
                loc_oPg.txt_4c_DsConta.Value = ALLTRIM(rclis)
            ENDIF
        ENDIF
        IF USED("cursor_4c_BuscaConta")
            USE IN cursor_4c_BuscaConta
        ENDIF
        loc_oBusca.Release()
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaVendedor(par_cTipo)
        LOCAL loc_oBusca, loc_oPg, loc_cValor, loc_cCampo
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF par_cTipo = "C"
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_CdVendedor.Value)
            loc_cCampo = "iclis"
        ELSE
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsVendedor.Value)
            loc_cCampo = "rclis"
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", "cursor_4c_BuscaVendedor", loc_cCampo, ;
            loc_cValor, "Vendedor")
        IF VARTYPE(loc_oBusca) != "O"
            RETURN
        ENDIF
        loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
        loc_oBusca.mAddColuna("rclis", "", "Nome")
        loc_oBusca.Show()

        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaVendedor")
            SELECT cursor_4c_BuscaVendedor
            IF !EOF()
                loc_oPg.txt_4c_CdVendedor.Value = ALLTRIM(iclis)
                loc_oPg.txt_4c_DsVendedor.Value = ALLTRIM(rclis)
            ENDIF
        ENDIF
        IF USED("cursor_4c_BuscaVendedor")
            USE IN cursor_4c_BuscaVendedor
        ENDIF
        loc_oBusca.Release()
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaProduto(par_cTipo)
        LOCAL loc_oBusca, loc_oPg, loc_cValor, loc_cCampo
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF par_cTipo = "C"
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_CdProduto.Value)
            loc_cCampo = "cpros"
        ELSE
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsProduto.Value)
            loc_cCampo = "dpros"
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdPro", "cursor_4c_BuscaProduto", loc_cCampo, ;
            loc_cValor, "Produto")
        IF VARTYPE(loc_oBusca) != "O"
            RETURN
        ENDIF
        loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
        loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
        loc_oBusca.Show()

        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProduto")
            SELECT cursor_4c_BuscaProduto
            IF !EOF()
                loc_oPg.txt_4c_CdProduto.Value = ALLTRIM(cpros)
                loc_oPg.txt_4c_DsProduto.Value = ALLTRIM(dpros)
            ENDIF
        ENDIF
        IF USED("cursor_4c_BuscaProduto")
            USE IN cursor_4c_BuscaProduto
        ENDIF
        loc_oBusca.Release()
        THIS.AjustarCamposProduto()
    ENDPROC

    *==========================================================================
    * COMPATIBILIDADE API CRUD
    *==========================================================================

    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    PROCEDURE CarregarLista()
        THIS.AlternarPagina(1)
        THIS.OcultarAguarde()
        THIS.AjustarCamposMoeda()
        THIS.AjustarCamposProduto()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Alias de BtnVisualizarClick (preview do relatorio)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos de filtro
    * par_lHabilitar: .T. = habilita, .F. = desabilita
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF VARTYPE(loc_oPg) != "O"
            RETURN
        ENDIF

        loc_oPg.txt_4c_Empresa.Enabled    = par_lHabilitar
        loc_oPg.txt_4c_DEmpresa.Enabled   = par_lHabilitar
        loc_oPg.txt_4c_NmOperacao.Enabled = par_lHabilitar
        loc_oPg.txt_4c_DtInicial.Enabled  = par_lHabilitar
        loc_oPg.txt_4c_DtFinal.Enabled    = par_lHabilitar
        loc_oPg.txt_4c_Qtde.Enabled       = par_lHabilitar
        loc_oPg.txt_4c_QtMin.Enabled      = par_lHabilitar
        loc_oPg.txt_4c_CdConta.Enabled    = par_lHabilitar
        loc_oPg.txt_4c_DsConta.Enabled    = par_lHabilitar
        loc_oPg.txt_4c_CdVendedor.Enabled = par_lHabilitar
        loc_oPg.txt_4c_DsVendedor.Enabled = par_lHabilitar
        loc_oPg.txt_4c_CdProduto.Enabled  = par_lHabilitar
        loc_oPg.txt_4c_DsProduto.Enabled  = par_lHabilitar
        loc_oPg.ogp_4c_Ordem.Enabled      = par_lHabilitar
        loc_oPg.ogp_4c_SelRel.Enabled     = par_lHabilitar
        loc_oPg.ogp_4c_MovCad.Enabled     = par_lHabilitar
        loc_oPg.chk_4c_Cidade.Enabled     = par_lHabilitar
        loc_oPg.chk_4c_Comparativo.Enabled = par_lHabilitar
        loc_oPg.grd_4c_Dados.Enabled      = par_lHabilitar
        loc_oPg.cmd_4c_SelTudo.Enabled    = par_lHabilitar
        loc_oPg.cmd_4c_Apaga.Enabled      = par_lHabilitar

        IF par_lHabilitar
            THIS.AjustarCamposMoeda()
            THIS.AjustarCamposProduto()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos botoes do CommandGroup
    * Para form REPORT: botoes de imprimir/visualizar sempre habilitados
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        IF VARTYPE(THIS.cmg_4c_Botoes) != "O"
            RETURN
        ENDIF
        *-- Botoes 1(Visualizar) 2(Imprimir) 3(Excel) 4(Encerrar) sempre ativos
        THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.
        THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
        THIS.cmg_4c_Botoes.Buttons(3).Enabled = .T.
        THIS.cmg_4c_Botoes.Buttons(4).Enabled = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        IF USED("CrSigCdTom")
            USE IN CrSigCdTom
        ENDIF
        IF USED("CrSigCdPam")
            USE IN CrSigCdPam
        ENDIF
        IF USED("CrSigCdEmp")
            USE IN CrSigCdEmp
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigrecmcBO.prg):
*==============================================================================
* SIGRECMCBO.PRG
* Business Object para Relatorio de Clientes que Mais/Menos/Nao Compram
* em Valores e Quantidades
*
* Herda de RelatorioBase
* Formulario original: SIGRECMC.SCX (frmrelatorio)
*==============================================================================

DEFINE CLASS sigrecmcBO AS RelatorioBase

    *-- Filtro: empresa
    this_cEmpresa    = ""
    this_cDEmpresa   = ""

    *-- Filtro: operacao/movimentacao (get_nm_operacao - MaxLength=20)
    this_cNmOperacao = ""

    *-- Filtro: periodo
    this_dDtInicial  = {}
    this_dDtFinal    = {}

    *-- Filtro: moeda (get_moeda MaxLength=3, get_moeda_desc MaxLength=15)
    this_cMoeda      = ""
    this_cMoedaDesc  = ""

    *-- Filtro: quantidades (numericos - Get_Qtde, Get_QtMin)
    this_nQtde       = 0
    this_nQtMin      = 0

    *-- Filtro: conta/estoque (getCdEstoque MaxLength=10, getDsEstoque MaxLength=40)
    this_cCdConta    = ""
    this_cDsConta    = ""

    *-- Filtro: vendedor (getCdVendedor MaxLength=10, getDsVendedor MaxLength=40)
    this_cCdVendedor = ""
    this_cDsVendedor = ""

    *-- Filtro: produto (get_cd_codigo MaxLength=14, get_ds_codigo MaxLength=40)
    this_cCdProduto  = ""
    this_cDsProduto  = ""

    *-- Opcoes de relatorio (option groups)
    *   this_nOrdem: 1=Mais Compram, 2=Menos Compram, 3=Nao Compram
    this_nOrdem      = 1
    *   this_nOptSelRel: 1=Valor, 2=Quantidade
    this_nOptSelRel  = 1
    *   this_nOptCompara: 1=Cliente, 2=Classificacao
    this_nOptCompara = 1
    *   this_nOptMovCad: 1=Movimentacao, 2=Cadastro
    this_nOptMovCad  = 1

    *-- Checkboxes (0=desmarcado, 1=marcado)
    this_nComparativo = 0
    this_nChkCidade   = 0
    this_nChkDadosCli = 0
    this_nChkValor    = 0

    *-- Dados auxiliares carregados pelo form no Init
    *   Moeda e grupo padrao vindos de SigCdPam
    this_cMoedaPadrao = ""
    this_cGrPadClis   = ""

    *-- Cabecalho do relatorio (preenchidos em PrepararDados)
    this_cNmEmpresa = ""
    this_cNmTitulo  = ""
    this_cNmPeriodo = ""
    *   "Valor" ou "Quantidade" - controlado por this_nOptSelRel
    this_cTipoRel   = ""

    *-- Cursor de saida dos dados processados
    this_cCursorDados = "cursor_4c_Dados"

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida filtros antes de gerar o relatorio
    * Equivale ao mchkvalid() legado
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFiltros()

        IF EMPTY(THIS.this_dDtInicial)
            THIS.this_cMensagemErro = "Data inicial inv" + CHR(225) + "lida !"
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.this_dDtFinal)
            THIS.this_cMensagemErro = "Data final inv" + CHR(225) + "lida !"
            RETURN .F.
        ENDIF

        IF THIS.this_dDtInicial > THIS.this_dDtFinal
            THIS.this_cMensagemErro = "Data inicial maior que data final !"
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.this_cMoeda) AND THIS.this_nOptSelRel = 1
            THIS.this_cMensagemErro = "Moeda Inv" + CHR(225) + "lida." + CHR(13) + ;
                "Informe o tipo de moeda"
            RETURN .F.
        ENDIF

        IF (YEAR(THIS.this_dDtFinal) - YEAR(THIS.this_dDtInicial)) > 5 AND ;
            THIS.this_nComparativo = 1
            THIS.this_cMensagemErro = "Intervalo m" + CHR(225) + "ximo de anos " + ;
                "para comparativo " + CHR(233) + " 6 !"
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDadosIniciais - Carrega SigCdPam, SigCdEmp e moeda padrao
    * Equivale ao Init() legado
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDadosIniciais()
        LOCAL loc_nResult

        IF USED("CrSigCdPam")
            USE IN CrSigCdPam
        ENDIF

        loc_nResult = SQLEXEC(gnConnHandle, ;
            "SELECT moedaps, GrPadClis FROM SigCdPam", "CrSigCdPam")
        IF loc_nResult < 1
            THIS.this_cMensagemErro = "Falha de Conex" + CHR(227) + "o ao carregar " + ;
                "par" + CHR(226) + "metros"
            RETURN .F.
        ENDIF

        SELECT CrSigCdPam
        GO TOP
        THIS.this_cMoedaPadrao = ALLTRIM(CrSigCdPam.moedaps)
        THIS.this_cGrPadClis   = ALLTRIM(CrSigCdPam.GrPadClis)
        THIS.this_cMoeda       = ALLTRIM(CrSigCdPam.moedaps)
        THIS.this_cEmpresa     = go_4c_Sistema.cCodEmpresa

        IF USED("CrSigCdEmp")
            USE IN CrSigCdEmp
        ENDIF

        loc_nResult = SQLEXEC(gnConnHandle, ;
            "SELECT cemps, razas FROM SigCdEmp WHERE cemps = " + ;
            EscaparSQL(go_4c_Sistema.cCodEmpresa), "CrSigCdEmp")
        IF loc_nResult < 1
            THIS.this_cMensagemErro = "Falha de Conex" + CHR(227) + "o ao carregar empresa"
            RETURN .F.
        ENDIF

        SELECT CrSigCdEmp
        GO TOP
        IF !EOF()
            THIS.this_cNmEmpresa = ALLTRIM(CrSigCdEmp.razas)
            THIS.this_cDEmpresa  = ALLTRIM(CrSigCdEmp.razas)
        ENDIF

        IF !EMPTY(THIS.this_cMoedaPadrao)
            IF USED("cursor_4c_MoePad")
                USE IN cursor_4c_MoePad
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT cmoes, dmoes FROM SigCdMoe WHERE cmoes = " + ;
                EscaparSQL(THIS.this_cMoedaPadrao), "cursor_4c_MoePad")
            IF loc_nResult > 0
                SELECT cursor_4c_MoePad
                GO TOP
                IF !EOF()
                    THIS.this_cMoedaDesc = ALLTRIM(cursor_4c_MoePad.dmoes)
                ENDIF
                USE IN cursor_4c_MoePad
            ENDIF
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarTiposOperacao - Carrega cursor CrSigCdTom para o grid do form
    * O form vincula seu grd_4c_Dados a este cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarTiposOperacao()
        LOCAL loc_nResult

        IF USED("CrSigCdTom")
            USE IN CrSigCdTom
        ENDIF

        loc_nResult = SQLEXEC(gnConnHandle, ;
            "SELECT 0 AS nMarca, codigos, " + ;
            "STR(codigos,2) + '-' + descrs AS Descri FROM SigCdTom", ;
            "CrSigCdTom")
        IF loc_nResult < 1
            THIS.this_cMensagemErro = "Falha ao carregar tipos de opera" + ;
                CHR(231) + CHR(227) + "o"
            RETURN .F.
        ENDIF

        SELECT CrSigCdTom
        INDEX ON codigos TAG codigos
        GO TOP
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * checaIBGE - Retorna codigo IBGE de um municipio/UF
    * Equivale ao checaibge() legado
    *--------------------------------------------------------------------------
    PROCEDURE checaIBGE(par_cMun, par_cUF)
        LOCAL loc_nRtC, loc_lcSQL, loc_nResult

        loc_nRtC = 9999999

        loc_lcSQL = "SELECT a.Codigos FROM SigCdMun a, SigCdUfs b " + ;
            "WHERE a.Descs = " + EscaparSQL(PADR(UPPER(par_cMun), 40)) + ;
            " AND a.UFIBGEs = b.UFIBGEs AND b.Estados = " + EscaparSQL(par_cUF)

        loc_nResult = SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_IBGE")
        IF loc_nResult < 1
            RETURN loc_nRtC
        ENDIF

        SELECT cursor_4c_IBGE
        GO TOP
        IF !EOF()
            loc_nRtC = INT(VAL(cursor_4c_IBGE.Codigos))
        ENDIF
        USE IN cursor_4c_IBGE

        RETURN loc_nRtC
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarCotacao - Retorna cotacao de uma moeda em determinada data
    * Tenta chamar fBuscarCotacao legado; retorna 1 se nao disponivel
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BuscarCotacao(par_cMoeda, par_dData)
        LOCAL loc_nCotacao
        loc_nCotacao = 1
        TRY
            loc_nCotacao = fBuscarCotacao(par_cMoeda, par_dData, gnConnHandle)
        CATCH
            loc_nCotacao = 1
        ENDTRY
        RETURN IIF(loc_nCotacao = 0, 1, loc_nCotacao)
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa processamento completo do relatorio
    * Traduz o processamento() legado (~760 linhas)
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso
        LOCAL loc_lcEmp, loc_lcNmOperacao, loc_ldDtInicial, loc_ldFinal
        LOCAL loc_lcMoeda, loc_lnOrdem, loc_lcCconta, loc_lcDconta
        LOCAL loc_lcCVendedor, loc_lcDVendedor, loc_lnQtde, loc_lnQtMin
        LOCAL loc_lcProduto, loc_lnOptComp, loc_lnOptMovCad
        LOCAL loc_lnCid, loc_lnDad, loc_lnVal, loc_lnCompa
        LOCAL loc_lcNmEmpresa, loc_lcNmTitulo, loc_lcNmPeriodo, loc_lcTipo
        LOCAL loc_ldtInicial, loc_ldtFinal
        LOCAL loc_lnAnox, loc_lcStrAno1, loc_lcSql, loc_lnQueryOk
        LOCAL loc_ln_ValTot, loc_lcConta, loc_lnCota1, loc_lnCota2
        LOCAL loc_lcTipoOpe, loc_lcCodigo, loc_lcNome
        LOCAL loc_lcClaCo, loc_lcCGrupo, loc_lcContaV, loc_lcNomeRep, loc_lcDclaco
        LOCAL loc_lBdOk, loc_lErroBD, loc_lnConta, loc_lnMax, loc_lcLista
        LOCAL loc_lcGrava, loc_lcCampo, loc_lcCompra, loc_lcTagVal, loc_lcTagQtd
        LOCAL loc_lcVend, x

        loc_lSucesso = .F.

        TRY
            * Copia filtros de THIS para locais
            loc_lcEmp        = ALLTRIM(THIS.this_cEmpresa)
            loc_lcNmOperacao = ALLTRIM(THIS.this_cNmOperacao)
            loc_ldDtInicial  = THIS.this_dDtInicial
            loc_ldFinal      = THIS.this_dDtFinal
            loc_lcMoeda      = ALLTRIM(THIS.this_cMoeda)
            loc_lnOrdem      = THIS.this_nOrdem
            loc_lcCconta     = ALLTRIM(THIS.this_cCdConta)
            loc_lcDconta     = ALLTRIM(THIS.this_cDsConta)
            loc_lcCVendedor  = ALLTRIM(THIS.this_cCdVendedor)
            loc_lcDVendedor  = ALLTRIM(THIS.this_cDsVendedor)
            loc_lnQtde       = THIS.this_nQtde
            loc_lnQtMin      = THIS.this_nQtMin
            loc_lcProduto    = ALLTRIM(THIS.this_cCdProduto)
            loc_lnOptComp    = THIS.this_nOptCompara
            loc_lnOptMovCad  = THIS.this_nOptMovCad
            loc_lnCid        = THIS.this_nChkCidade
            loc_lnDad        = THIS.this_nChkDadosCli
            loc_lnVal        = THIS.this_nChkValor
            loc_lnCompa      = THIS.this_nComparativo

            * Formata datas como DATETIME para binding ODBC via ?variavel
            loc_ldtInicial = EVALUATE([{^] + ;
                TRANSFORM((DTOS(MAX(loc_ldDtInicial, CTOD("01/01/1900"))) + ;
                "000000"), "@R 9999-99-99 99:99:99") + [}])
            loc_ldtFinal = EVALUATE([{^] + ;
                TRANSFORM((DTOS(MAX(loc_ldFinal, CTOD("01/01/1900"))) + ;
                "235959"), "@R 9999-99-99 99:99:99") + [}])

            * Dados da empresa (CrSigCdEmp carregado em CarregarDadosIniciais)
            IF USED("CrSigCdEmp")
                SELECT CrSigCdEmp
                GO TOP
                loc_lcNmEmpresa = IIF(!EMPTY(CrSigCdEmp.razas), ALLTRIM(CrSigCdEmp.razas), "")
            ELSE
                loc_lcNmEmpresa = THIS.this_cNmEmpresa
            ENDIF

            loc_lcNmTitulo = "Relat" + CHR(243) + "rio de Clientes que " + ;
                IIF(loc_lnOrdem = 1, "Mais", ;
                    IIF(loc_lnOrdem = 2, "Menos", "N" + CHR(227) + "o")) + ;
                " Compram " + PROPER(ALLTRIM(loc_lcNmOperacao) + " ")

            loc_lcNmPeriodo = "Per" + CHR(237) + "odo : " + ;
                DTOC(loc_ldDtInicial) + " " + CHR(224) + " " + DTOC(loc_ldFinal) + " " + ;
                IIF(EMPTY(loc_lcCconta), "", ;
                    "  \ Conta " + ALLTRIM(loc_lcCconta) + " " + ALLTRIM(loc_lcDconta)) + ;
                IIF(EMPTY(loc_lcCVendedor), "", ;
                    CHR(13) + "Vendedor " + ALLTRIM(loc_lcCVendedor) + ;
                    " " + ALLTRIM(loc_lcDVendedor)) + ;
                IIF(EMPTY(loc_lcProduto), "", " \ Produto: " + loc_lcProduto) + ;
                " \ Moeda: [" + loc_lcMoeda + "]"

            loc_lcTipo = IIF(THIS.this_nOptSelRel = 1, "Valor", "Quantidade")

            THIS.this_cNmEmpresa = loc_lcNmEmpresa
            THIS.this_cNmTitulo  = loc_lcNmTitulo
            THIS.this_cNmPeriodo = loc_lcNmPeriodo
            THIS.this_cTipoRel   = loc_lcTipo

            * Numero de anos do periodo (maximo 6)
            loc_lnAnox = MIN((YEAR(loc_ldFinal) - YEAR(loc_ldDtInicial)) + 1, 6)

            *-- Cursor de cabecalho para FRX
            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF
            CREATE CURSOR CsCabecalho ( ;
                nm_empresa    C(80),  nm_titulo     C(254), nm_periodo    C(254), ;
                nm_tipo       C(10),  nm_Comparativo N(1),  nm_OptComp    N(1), ;
                nm_Ano1       C(14),  nm_ano2       C(14),  nm_ano3       C(14), ;
                nm_Ano4       C(14),  nm_ano5       C(14),  nm_ano6       C(14))

            INSERT INTO CsCabecalho ;
                (nm_empresa, nm_titulo, nm_periodo, nm_tipo, nm_Comparativo, nm_OptComp) ;
                VALUES (loc_lcNmEmpresa, loc_lcNmTitulo, loc_lcNmPeriodo, ;
                        loc_lcTipo, loc_lnCompa, loc_lnOptComp)

            loc_lcStrAno1 = ""
            SELECT CsCabecalho
            FOR x = 1 TO loc_lnAnox
                loc_lcStrAno1 = loc_lcStrAno1 + ;
                    TRANSFORM(YEAR(loc_ldDtInicial) + x - 1, "@L 9999")
                loc_lcGrava = "nm_ano" + ALLTRIM(STR(x, 2))
                REPLACE &loc_lcGrava. WITH PADC(STR(YEAR(loc_ldDtInicial) + x - 1, 4), 14)
            ENDFOR

            *-- Cursor de resultado principal (TmpResult compativel com FRX legado)
            IF USED("TmpResult")
                USE IN TmpResult
            ENDIF
            CREATE CURSOR TmpResult ( ;
                ordem     N(5),  ciclis    C(10),  crclis    C(50), ;
                nValcomp  N(12,2), nqtde   N(12,2), cunis    C(3), ;
                ncompras  N(6), ;
                nValAno1  N(12,2), nValAno2  N(12,2), nValAno3  N(12,2), ;
                nValAno4  N(12,2), nValAno5  N(12,2), nValAno6  N(12,2), ;
                nQtdAno1  N(12,2), nQtdAno2  N(12,2), nQtdAno3  N(12,2), ;
                nQtdAno4  N(12,2), nQtdAno5  N(12,2), nQtdAno6  N(12,2), ;
                nCompra1  N(5),  nCompra2  N(5),  nCompra3  N(5), ;
                nCompra4  N(5),  nCompra5  N(5),  nCompra6  N(5), ;
                clacos    C(10), ;
                ordem1    N(4),  ordem2    N(4),  ordem3    N(4), ;
                ordem4    N(4),  ordem5    N(4),  ordem6    N(4), ;
                cStrAno1s C(64), cTitulo1s C(64), cTitulo2s C(64), ;
                cTitulo3s C(64), cTitulo4s C(64), cEmpresas C(64), ;
                MaxOrdem  N(4),  Quebras   C(50))

            INDEX ON ciclis                   TAG iclis
            INDEX ON ciclis + cunis           TAG cunis
            INDEX ON Quebras + STR(ordem, 4)  TAG impressao
            INDEX ON nValComp                 TAG nValAsc ASCENDING
            INDEX ON nValComp                 TAG nValDes DESCENDING
            INDEX ON nQtde                    TAG nQtdAsc ASCENDING
            INDEX ON nQtde                    TAG nQtdDes DESCENDING
            INDEX ON nValAno1                 TAG nVal1
            INDEX ON nValAno2                 TAG nVal2
            INDEX ON nValAno3                 TAG nVal3
            INDEX ON nValAno4                 TAG nVal4
            INDEX ON nValAno5                 TAG nVal5
            INDEX ON nValAno6                 TAG nVal6
            INDEX ON nQtdAno1                 TAG nQtd1
            INDEX ON nQtdAno2                 TAG nQtd2
            INDEX ON nQtdAno3                 TAG nQtd3
            INDEX ON nQtdAno4                 TAG nQtd4
            INDEX ON nQtdAno5                 TAG nQtd5
            INDEX ON nQtdAno6                 TAG nQtd6

            loc_lBdOk = .T.

            * ================================================================
            * PROCESSAMENTO POR VALOR
            * ================================================================
            IF THIS.this_nOptSelRel = 1

                loc_lcSql = ;
                    "SELECT a.emps,a.dopes,a.numes,a.empdopnums,a.datas,a.valos," + ;
                    "a.contads,a.contaos," + ;
                    "b.tipoops,b.valpres,b.cmoes,b.caixas,b.copers,b.opers," + ;
                    "b.destinos,b.origems,a.vends " + ;
                    "FROM SigMvCab a, SigCdOpe b " + ;
                    "WHERE a.datas Between ?loc_ldtInicial And ?loc_ldtFinal " + ;
                    "AND a.dopes = b.dopes"
                IF !EMPTY(loc_lcEmp)
                    loc_lcSql = loc_lcSql + " AND a.emps = " + EscaparSQL(loc_lcEmp)
                ENDIF
                IF !EMPTY(loc_lcNmOperacao)
                    loc_lcSql = loc_lcSql + " AND a.dopes = " + EscaparSQL(loc_lcNmOperacao)
                ENDIF
                IF !EMPTY(loc_lcCconta)
                    loc_lcSql = loc_lcSql + ;
                        " AND (a.contaos = " + EscaparSQL(loc_lcCconta) + ;
                        " OR contads = " + EscaparSQL(loc_lcCconta) + ")"
                ENDIF

                IF USED("CrSigMvCab")
                    USE IN CrSigMvCab
                ENDIF
                loc_lnQueryOk = SQLEXEC(gnConnHandle, loc_lcSql, "CrSigMvCab")
                IF loc_lnQueryOk < 1
                    THIS.this_cMensagemErro = "Falha de Conex" + CHR(227) + "o ao " + ;
                        "carregar movimentos"
                    loc_lBdOk = .F.
                ENDIF

                *-- Agrega representantes de venda (SigMvEtv)
                IF loc_lBdOk AND !EMPTY(loc_lcCVendedor)
                    loc_lcSql = ;
                        "SELECT a.emps,a.dopes,a.numes,a.empdopnums,a.datas,a.valos," + ;
                        "a.contads,a.contaos," + ;
                        "b.tipoops,b.valpres,b.cmoes,b.caixas,b.copers,b.opers," + ;
                        "b.destinos,b.origems,e.contas as vends " + ;
                        "FROM SigMvCab a, SigCdOpe b, SigMvEtv e " + ;
                        "WHERE a.datas Between ?loc_ldtInicial And ?loc_ldtFinal " + ;
                        "AND a.dopes = b.dopes AND a.empdopnums = e.empdopnums"
                    IF !EMPTY(loc_lcEmp)
                        loc_lcSql = loc_lcSql + " AND a.emps = " + EscaparSQL(loc_lcEmp)
                    ENDIF
                    IF !EMPTY(loc_lcNmOperacao)
                        loc_lcSql = loc_lcSql + " AND a.dopes = " + EscaparSQL(loc_lcNmOperacao)
                    ENDIF
                    IF !EMPTY(loc_lcCconta)
                        loc_lcSql = loc_lcSql + ;
                            " AND (a.contaos = " + EscaparSQL(loc_lcCconta) + ;
                            " OR contads = " + EscaparSQL(loc_lcCconta) + ")"
                    ENDIF
                    IF USED("cursor_4c_VendX")
                        USE IN cursor_4c_VendX
                    ENDIF
                    loc_lnQueryOk = SQLEXEC(gnConnHandle, loc_lcSql, "cursor_4c_VendX")
                    IF loc_lnQueryOk > 0
                        SELECT cursor_4c_VendX
                        GO TOP
                        SCAN
                            SCATTER MEMVAR MEMO
                            INSERT INTO CrSigMvCab FROM MEMVAR
                        ENDSCAN
                        USE IN cursor_4c_VendX
                    ELSE
                        THIS.this_cMensagemErro = "Falha de Conex" + CHR(227) + ;
                            "o ao carregar representantes"
                        loc_lBdOk = .F.
                    ENDIF
                ENDIF

                *-- Lista de clientes para "Nao Compram"
                IF loc_lBdOk AND loc_lnOrdem = 3
                    IF USED("CrSigCdPam")
                        SELECT CrSigCdPam
                        GO TOP
                        loc_lcSql = "SELECT a.Iclis,a.Rclis,a.ContaVens," + ;
                            "b.Rclis as dVends FROM SigCdCli a " + ;
                            "LEFT JOIN SigCdCli b ON a.ContaVens = b.Iclis " + ;
                            "WHERE a.Grupos = " + EscaparSQL(ALLTRIM(THIS.this_cGrPadClis))
                    ELSE
                        loc_lcSql = "SELECT a.Iclis,a.Rclis,a.ContaVens," + ;
                            "b.Rclis as dVends FROM SigCdCli a " + ;
                            "LEFT JOIN SigCdCli b ON a.ContaVens = b.Iclis " + ;
                            "WHERE 1=1"
                    ENDIF
                    IF USED("TmpCliente")
                        USE IN TmpCliente
                    ENDIF
                    loc_lnQueryOk = SQLEXEC(gnConnHandle, loc_lcSql, "TmpCliente")
                    IF loc_lnQueryOk < 1
                        THIS.this_cMensagemErro = "Falha de Conex" + CHR(227) + ;
                            "o ao carregar clientes"
                        loc_lBdOk = .F.
                    ENDIF
                ENDIF

                *-- SCAN de movimentos de VALOR
                IF loc_lBdOk
                    loc_lErroBD = .F.
                    SELECT CrSigMvCab
                    GO TOP

                    SCAN WHILE !loc_lErroBD
                        *-- Checa tipo de operacao se sem filtro de operacao
                        IF EMPTY(loc_lcNmOperacao)
                            IF ISNULL(CrSigMvCab.TipoOps)
                                LOOP
                            ENDIF
                            loc_lcTipoOpe = ALLTRIM(CrSigMvCab.TipoOps)
                            IF USED("CrSigCdTom")
                                SELECT CrSigCdTom
                                GO TOP
                                =SEEK(loc_lcTipoOpe, "CrSigCdTom", "codigos")
                                IF EOF() OR CrSigCdTom.nMarca = 0
                                    SELECT CrSigMvCab
                                    LOOP
                                ENDIF
                            ENDIF
                        ENDIF

                        *-- Calcula valor total do movimento (com conversao de moeda)
                        loc_ln_ValTot = 0
                        IF INLIST(NVL(CrSigMvCab.valpres, 0), 1, 3)
                            *-- Soma itens do SigMvMov (tipo com detalhe de itens)
                            IF USED("TmpEstMo")
                                USE IN TmpEstMo
                            ENDIF
                            loc_lcSql = "SELECT emps,dopes,numes,valtots,moeds " + ;
                                "FROM SigMvMov " + ;
                                "WHERE emps = " + EscaparSQL(ALLTRIM(CrSigMvCab.emps)) + ;
                                " AND dopes = " + EscaparSQL(ALLTRIM(CrSigMvCab.dopes)) + ;
                                " AND numes = " + ALLTRIM(STR(CrSigMvCab.numes))
                            loc_lnQueryOk = SQLEXEC(gnConnHandle, loc_lcSql, "TmpEstMo")
                            IF loc_lnQueryOk < 1
                                loc_lErroBD = .T.
                            ELSE
                                SELECT TmpEstMo
                                GO TOP
                                IF !EOF()
                                    SCAN
                                        loc_lnCota1 = THIS.BuscarCotacao( ;
                                            ALLTRIM(TmpEstMo.moeds), CrSigMvCab.datas)
                                        loc_lnCota2 = THIS.BuscarCotacao( ;
                                            loc_lcMoeda, CrSigMvCab.datas)
                                        IF loc_lnCota2 <> 0
                                            loc_ln_ValTot = loc_ln_ValTot + ;
                                                TmpEstMo.valtots * (loc_lnCota1 / loc_lnCota2)
                                        ENDIF
                                    ENDSCAN
                                ELSE
                                    SELECT CrSigMvCab
                                    LOOP
                                ENDIF
                            ENDIF
                        ELSE
                            *-- Valor direto do cabecalho
                            IF !EMPTY(CrSigMvCab.cmoes)
                                loc_lnCota1 = THIS.BuscarCotacao( ;
                                    ALLTRIM(CrSigMvCab.cmoes), CrSigMvCab.datas)
                                loc_lnCota2 = THIS.BuscarCotacao( ;
                                    loc_lcMoeda, CrSigMvCab.datas)
                                IF loc_lnCota2 <> 0
                                    loc_ln_ValTot = CrSigMvCab.valos * ;
                                        (loc_lnCota1 / loc_lnCota2)
                                ENDIF
                            ELSE
                                loc_lnCota2 = THIS.BuscarCotacao( ;
                                    loc_lcMoeda, CrSigMvCab.datas)
                                IF loc_lnCota2 <> 0
                                    loc_ln_ValTot = CrSigMvCab.valos / loc_lnCota2
                                ENDIF
                            ENDIF

                            IF ISNULL(CrSigMvCab.caixas)
                                SELECT CrSigMvCab
                                LOOP
                            ENDIF

                            DO CASE
                                CASE CrSigMvCab.caixas = 1
                                    DO CASE
                                        CASE NVL(CrSigMvCab.copers, 0) = 1
                                            loc_ln_ValTot = ABS(loc_ln_ValTot)
                                        CASE NVL(CrSigMvCab.copers, 0) = 2
                                            loc_ln_ValTot = ABS(loc_ln_ValTot) * (-1)
                                        OTHERWISE
                                            SELECT CrSigMvCab
                                            LOOP
                                    ENDCASE
                                CASE CrSigMvCab.caixas <> 1
                                    DO CASE
                                        CASE NVL(CrSigMvCab.opers, 0) = 1
                                            loc_ln_ValTot = ABS(loc_ln_ValTot) * (-1)
                                        CASE NVL(CrSigMvCab.opers, 0) = 2
                                            loc_ln_ValTot = ABS(loc_ln_ValTot)
                                        CASE NVL(CrSigMvCab.opers, 0) = 3
                                            loc_ln_ValTot = 0
                                            IF USED("TprMvCabi")
                                                USE IN TprMvCabi
                                            ENDIF
                                            loc_lcSql = "SELECT emps,dopes,numes,totas " + ;
                                                "FROM SigMvItn WHERE empdopnums = " + ;
                                                EscaparSQL(ALLTRIM(CrSigMvCab.empdopnums))
                                            loc_lnQueryOk = SQLEXEC(gnConnHandle, ;
                                                loc_lcSql, "TprMvCabi")
                                            IF loc_lnQueryOk < 1
                                                loc_lErroBD = .T.
                                            ELSE
                                                SELECT TprMvCabi
                                                GO TOP
                                                IF !EOF()
                                                    SCAN
                                                        IF !EMPTY(CrSigMvCab.cmoes)
                                                            loc_lnCota1 = THIS.BuscarCotacao( ;
                                                                ALLTRIM(CrSigMvCab.cmoes), ;
                                                                CrSigMvCab.datas)
                                                            loc_lnCota2 = THIS.BuscarCotacao( ;
                                                                loc_lcMoeda, CrSigMvCab.datas)
                                                            IF loc_lnCota2 <> 0
                                                                loc_ln_ValTot = loc_ln_ValTot + ;
                                                                    TprMvCabi.totas * ;
                                                                    (loc_lnCota1 / loc_lnCota2)
                                                            ENDIF
                                                        ELSE
                                                            loc_lnCota2 = THIS.BuscarCotacao( ;
                                                                loc_lcMoeda, CrSigMvCab.datas)
                                                            IF loc_lnCota2 <> 0
                                                                loc_ln_ValTot = loc_ln_ValTot + ;
                                                                    TprMvCabi.totas / loc_lnCota2
                                                            ENDIF
                                                        ENDIF
                                                    ENDSCAN
                                                ELSE
                                                    SELECT CrSigMvCab
                                                    LOOP
                                                ENDIF
                                            ENDIF
                                        OTHERWISE
                                            SELECT CrSigMvCab
                                            LOOP
                                    ENDCASE
                            ENDCASE
                        ENDIF

                        IF loc_lErroBD
                            EXIT
                        ENDIF

                        SELECT CrSigMvCab
                        IF loc_lnOptMovCad = 1 AND ;
                            !EMPTY(loc_lcCVendedor) AND ;
                            CrSigMvCab.Vends # loc_lcCVendedor
                            LOOP
                        ENDIF

                        *-- Determina conta do cliente pelo tipo de operacao
                        DO CASE
                            CASE NVL(CrSigMvCab.caixas,0)=1 AND NVL(CrSigMvCab.copers,0)=1
                                loc_lcConta = ALLTRIM(CrSigMvCab.contads)
                            CASE NVL(CrSigMvCab.caixas,0)=1 AND NVL(CrSigMvCab.copers,0)=2
                                loc_lcConta = ALLTRIM(CrSigMvCab.contaos)
                            CASE NVL(CrSigMvCab.destinos, 0) = 1
                                loc_lcConta = ALLTRIM(CrSigMvCab.contads)
                            CASE NVL(CrSigMvCab.origems, 0) = 1
                                loc_lcConta = ALLTRIM(CrSigMvCab.contaos)
                            OTHERWISE
                                loc_lcConta = SPACE(10)
                        ENDCASE

                        IF USED("TmpCli")
                            USE IN TmpCli
                        ENDIF
                        loc_lcSql = "SELECT iclis,rclis,codigos,grupos," + ;
                            "contavens,cidas,estas,tabds FROM SigCdCli " + ;
                            "WHERE iclis = " + EscaparSQL(loc_lcConta)
                        loc_lnQueryOk = SQLEXEC(gnConnHandle, loc_lcSql, "TmpCli")
                        IF loc_lnQueryOk < 1
                            loc_lErroBD = .T.
                            EXIT
                        ENDIF

                        SELECT TmpCli
                        GO TOP
                        IF loc_lnOptMovCad=2 AND !EMPTY(loc_lcCVendedor) AND ;
                            TmpCli.ContaVens # loc_lcCVendedor
                            SELECT CrSigMvCab
                            LOOP
                        ENDIF

                        *-- Determina codigo e nome para agrupamento
                        IF loc_lnCid = 1
                            loc_lcCodigo = PADL(STR(THIS.checaIBGE( ;
                                ALLTRIM(TmpCli.Cidas), ALLTRIM(TmpCli.Estas)), 10), 10)
                            loc_lcNome   = "(" + ALLTRIM(TmpCli.Estas) + ") " + ;
                                ALLTRIM(TmpCli.Cidas)
                        ELSE
                            loc_lcCodigo = loc_lcConta
                            loc_lcNome   = ALLTRIM(TmpCli.rclis)
                            loc_lcClaCo  = ALLTRIM(TmpCli.codigos)
                            loc_lcCGrupo = ALLTRIM(TmpCli.grupos)
                            loc_lcContaV = IIF(loc_lnOptMovCad = 1, ;
                                ALLTRIM(CrSigMvCab.Vends), ALLTRIM(TmpCli.contavens))

                            IF USED("TmpClaCo")
                                USE IN TmpClaCo
                            ENDIF
                            loc_lcSql = "SELECT codigos,descs,grupos FROM SigCdClc " + ;
                                "WHERE codigos = " + EscaparSQL(loc_lcClaCo) + ;
                                " AND grupos = " + EscaparSQL(loc_lcCGrupo)
                            loc_lnQueryOk = SQLEXEC(gnConnHandle, loc_lcSql, "TmpClaCo")
                            IF loc_lnQueryOk < 1
                                loc_lErroBD = .T.
                                EXIT
                            ENDIF

                            IF USED("TmpCli")
                                USE IN TmpCli
                            ENDIF
                            loc_lcSql = "SELECT iclis,rclis FROM SigCdCli " + ;
                                "WHERE iclis = " + EscaparSQL(loc_lcContaV)
                            loc_lnQueryOk = SQLEXEC(gnConnHandle, loc_lcSql, "TmpCli")
                            IF loc_lnQueryOk < 1
                                loc_lErroBD = .T.
                                EXIT
                            ENDIF
                            SELECT TmpCli
                            GO TOP
                            loc_lcNomeRep = ALLTRIM(TmpCli.iclis) + " - " + ;
                                ALLTRIM(TmpCli.rclis)
                            SELECT TmpClaCo
                            GO TOP
                            loc_lcDclaco = ALLTRIM(TmpClaCo.codigos) + " - " + ;
                                ALLTRIM(TmpClaCo.descs)

                            IF USED("TmpCli")
                                USE IN TmpCli
                            ENDIF
                            loc_lcSql = "SELECT iclis,rclis,codigos,grupos,tabds " + ;
                                "FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_lcConta)
                            loc_lnQueryOk = SQLEXEC(gnConnHandle, loc_lcSql, "TmpCli")
                            IF loc_lnQueryOk < 1
                                loc_lErroBD = .T.
                                EXIT
                            ENDIF
                            SELECT TmpCli
                            GO TOP
                            loc_lcCGrupo = ALLTRIM(TmpCli.grupos)
                            loc_lcClaCo  = ALLTRIM(TmpCli.codigos)

                            IF loc_lnCompa = 1
                                IF loc_lnOptComp = 1
                                    loc_lcCodigo = loc_lcConta
                                    loc_lcNome   = ALLTRIM(TmpCli.rclis)
                                ELSE
                                    IF USED("TmpClaCo")
                                        USE IN TmpClaCo
                                    ENDIF
                                    loc_lcSql = "SELECT codigos,descs FROM SigCdClc " + ;
                                        "WHERE codigos = " + EscaparSQL(loc_lcClaCo) + ;
                                        " AND grupos = " + EscaparSQL(loc_lcCGrupo)
                                    loc_lnQueryOk = SQLEXEC(gnConnHandle, loc_lcSql, "TmpClaCo")
                                    IF loc_lnQueryOk < 1
                                        loc_lErroBD = .T.
                                        EXIT
                                    ENDIF
                                    SELECT TmpClaCo
                                    GO TOP
                                    loc_lcCodigo = ALLTRIM(TmpClaCo.codigos)
                                    loc_lcNome   = ALLTRIM(TmpClaCo.descs)
                                ENDIF
                            ENDIF
                        ENDIF

                        *-- Agrega no TmpResult
                        IF !EMPTY(loc_lcCodigo)
                            SELECT TmpResult
                            SET ORDER TO iclis
                            =SEEK(loc_lcCodigo, "TmpResult", "iclis")
                            IF EOF("TmpResult")
                                APPEND BLANK IN TmpResult
                                REPLACE ciclis WITH loc_lcCodigo, ;
                                        cRClis WITH loc_lcNome IN TmpResult
                                IF loc_lnCid = 0
                                    REPLACE Clacos WITH loc_lcClaCo, ;
                                        cTitulo1s WITH "Cliente : " + ;
                                            ALLTRIM(loc_lcCodigo) + " - " + ;
                                            ALLTRIM(loc_lcNome), ;
                                        cTitulo2s WITH "Representante: " + ;
                                            loc_lcNomeRep, ;
                                        cTitulo3s WITH "Tabela : " + ;
                                            ALLTRIM(TmpCli.tabds), ;
                                        cTitulo4s WITH "Classifica" + CHR(231) + ;
                                            CHR(227) + "o: " + loc_lcDclaco ;
                                        IN TmpResult
                                ENDIF
                            ENDIF

                            REPLACE TmpResult.nValComp WITH TmpResult.nValComp + loc_ln_ValTot
                            REPLACE TmpResult.nCompras WITH TmpResult.nCompras + 1

                            FOR x = 1 TO loc_lnAnox
                                IF YEAR(CrSigMvCab.datas) = (YEAR(loc_ldDtInicial) + x - 1)
                                    loc_lcGrava  = "nValAno" + STR(x, 1)
                                    loc_lcCompra = "nCompra" + STR(x, 1)
                                    REPLACE &loc_lcGrava.  WITH &loc_lcGrava.  + loc_ln_ValTot
                                    REPLACE &loc_lcCompra. WITH &loc_lcCompra. + 1
                                    EXIT
                                ENDIF
                            ENDFOR
                        ENDIF

                        SELECT CrSigMvCab
                    ENDSCAN && WHILE !loc_lErroBD

                    IF loc_lErroBD
                        THIS.this_cMensagemErro = "Falha de Conex" + CHR(227) + ;
                            "o ao processar movimentos de valor"
                        loc_lBdOk = .F.
                    ENDIF
                ENDIF && loc_lBdOk

            ELSE

            * ================================================================
            * PROCESSAMENTO POR QUANTIDADE
            * ================================================================

                loc_lcSql = ;
                    "SELECT a.contads,a.contaos,a.vends,b.emps,b.dopes,b.numes,b.cunis," + ;
                    "b.qtds,a.datas,c.tipoops,c.caixas,c.copers,c.destinos,c.origems " + ;
                    "FROM SigMvCab a, SigMvItn b, SigCdOpe c " + ;
                    "WHERE a.datas Between ?loc_ldtInicial And ?loc_ldtFinal"
                IF !EMPTY(loc_lcEmp)
                    loc_lcSql = loc_lcSql + " AND a.emps = " + EscaparSQL(loc_lcEmp)
                ENDIF
                IF !EMPTY(loc_lcNmOperacao)
                    loc_lcSql = loc_lcSql + " AND a.dopes = " + EscaparSQL(loc_lcNmOperacao)
                ENDIF
                IF !EMPTY(loc_lcCconta)
                    loc_lcSql = loc_lcSql + ;
                        " AND a.contads = " + EscaparSQL(loc_lcCconta) + ;
                        " AND a.contaos = " + EscaparSQL(loc_lcCconta)
                ENDIF
                loc_lcSql = loc_lcSql + " AND a.empdopnums = b.empdopnums"
                IF !EMPTY(loc_lcProduto)
                    loc_lcSql = loc_lcSql + " AND b.cpros = " + EscaparSQL(loc_lcProduto)
                ENDIF
                loc_lcSql = loc_lcSql + ;
                    " AND a.dopes = c.dopes ORDER BY a.emps,a.dopes,a.numes,b.cunis"

                IF USED("TmpQuant")
                    USE IN TmpQuant
                ENDIF
                loc_lnQueryOk = SQLEXEC(gnConnHandle, loc_lcSql, "TmpQuant")
                IF loc_lnQueryOk < 1
                    THIS.this_cMensagemErro = "Falha de Conex" + CHR(227) + "o ao " + ;
                        "carregar quantidades"
                    loc_lBdOk = .F.
                ENDIF

                *-- Agrega representantes de venda
                IF loc_lBdOk AND !EMPTY(loc_lcCVendedor)
                    loc_lcSql = ;
                        "SELECT a.contads,a.contaos,e.contas as vends," + ;
                        "b.emps,b.dopes,b.numes,b.cunis," + ;
                        "b.qtds,a.datas,c.tipoops,c.caixas,c.copers,c.destinos,c.origems " + ;
                        "FROM SigMvCab a, SigMvItn b, SigCdOpe c, SigMvEtv e " + ;
                        "WHERE a.datas Between ?loc_ldtInicial And ?loc_ldtFinal"
                    IF !EMPTY(loc_lcEmp)
                        loc_lcSql = loc_lcSql + " AND a.emps = " + EscaparSQL(loc_lcEmp)
                    ENDIF
                    IF !EMPTY(loc_lcNmOperacao)
                        loc_lcSql = loc_lcSql + " AND a.dopes = " + EscaparSQL(loc_lcNmOperacao)
                    ENDIF
                    IF !EMPTY(loc_lcCconta)
                        loc_lcSql = loc_lcSql + ;
                            " AND a.contads = " + EscaparSQL(loc_lcCconta) + ;
                            " AND a.contaos = " + EscaparSQL(loc_lcCconta)
                    ENDIF
                    loc_lcSql = loc_lcSql + ;
                        " AND a.empdopnums = b.empdopnums"
                    IF !EMPTY(loc_lcProduto)
                        loc_lcSql = loc_lcSql + " AND b.cpros = " + EscaparSQL(loc_lcProduto)
                    ENDIF
                    loc_lcSql = loc_lcSql + ;
                        " AND a.dopes = c.dopes AND a.empdopnums = e.empdopnums" + ;
                        " ORDER BY a.emps,a.dopes,a.numes,b.cunis"
                    IF USED("cursor_4c_VendX")
                        USE IN cursor_4c_VendX
                    ENDIF
                    loc_lnQueryOk = SQLEXEC(gnConnHandle, loc_lcSql, "cursor_4c_VendX")
                    IF loc_lnQueryOk > 0
                        SELECT cursor_4c_VendX
                        GO TOP
                        SCAN
                            SCATTER MEMVAR MEMO
                            INSERT INTO TmpQuant FROM MEMVAR
                        ENDSCAN
                        USE IN cursor_4c_VendX
                    ELSE
                        THIS.this_cMensagemErro = "Falha de Conex" + CHR(227) + ;
                            "o ao carregar representantes"
                        loc_lBdOk = .F.
                    ENDIF
                ENDIF

                *-- Lista de clientes para "Nao Compram"
                IF loc_lBdOk AND loc_lnOrdem = 3
                    IF USED("CrSigCdPam")
                        SELECT CrSigCdPam
                        GO TOP
                        loc_lcSql = "SELECT a.Iclis,a.Rclis,a.ContaVens," + ;
                            "b.Rclis as dVends FROM SigCdCli a " + ;
                            "LEFT JOIN SigCdCli b ON a.ContaVens = b.Iclis " + ;
                            "WHERE a.Grupos = " + EscaparSQL(ALLTRIM(THIS.this_cGrPadClis))
                    ELSE
                        loc_lcSql = "SELECT a.Iclis,a.Rclis,a.ContaVens," + ;
                            "b.Rclis as dVends FROM SigCdCli a " + ;
                            "LEFT JOIN SigCdCli b ON a.ContaVens = b.Iclis " + ;
                            "WHERE 1=1"
                    ENDIF
                    IF USED("TmpCliente")
                        USE IN TmpCliente
                    ENDIF
                    loc_lnQueryOk = SQLEXEC(gnConnHandle, loc_lcSql, "TmpCliente")
                    IF loc_lnQueryOk < 1
                        THIS.this_cMensagemErro = "Falha de Conex" + CHR(227) + ;
                            "o ao carregar clientes"
                        loc_lBdOk = .F.
                    ENDIF
                ENDIF

                *-- SCAN de movimentos de QUANTIDADE
                IF loc_lBdOk
                    loc_lErroBD = .F.
                    SELECT TmpQuant
                    GO TOP

                    SCAN WHILE !loc_lErroBD
                        *-- Checa tipo de operacao
                        IF EMPTY(loc_lcNmOperacao)
                            IF ISNULL(TmpQuant.TipoOps)
                                LOOP
                            ENDIF
                            loc_lcTipoOpe = ALLTRIM(TmpQuant.TipoOps)
                            IF USED("CrSigCdTom")
                                SELECT CrSigCdTom
                                GO TOP
                                =SEEK(loc_lcTipoOpe, "CrSigCdTom", "codigos")
                                IF EOF() OR CrSigCdTom.nMarca = 0
                                    SELECT TmpQuant
                                    LOOP
                                ENDIF
                            ENDIF
                            SELECT TmpQuant
                        ENDIF

                        IF ISNULL(TmpQuant.caixas)
                            LOOP
                        ENDIF

                        DO CASE
                            CASE TmpQuant.caixas=1 AND NVL(TmpQuant.copers,0)=1
                                loc_lcConta = ALLTRIM(TmpQuant.contads)
                            CASE TmpQuant.caixas=1 AND NVL(TmpQuant.copers,0)=2
                                loc_lcConta = ALLTRIM(TmpQuant.contaos)
                            CASE NVL(TmpQuant.destinos, 0) = 1
                                loc_lcConta = ALLTRIM(TmpQuant.contads)
                            CASE NVL(TmpQuant.origems, 0) = 1
                                loc_lcConta = ALLTRIM(TmpQuant.contaos)
                            OTHERWISE
                                loc_lcConta = SPACE(10)
                        ENDCASE

                        IF USED("TmpCli")
                            USE IN TmpCli
                        ENDIF
                        loc_lcSql = "SELECT iclis,rclis,codigos,grupos," + ;
                            "contavens,cidas,estas,tabds FROM SigCdCli " + ;
                            "WHERE iclis = " + EscaparSQL(loc_lcConta)
                        loc_lnQueryOk = SQLEXEC(gnConnHandle, loc_lcSql, "TmpCli")
                        IF loc_lnQueryOk < 1
                            loc_lErroBD = .T.
                            EXIT
                        ENDIF
                        SELECT TmpCli
                        GO TOP

                        IF loc_lnCid = 1
                            loc_lcCodigo = PADL(STR(THIS.checaIBGE( ;
                                ALLTRIM(TmpCli.Cidas), ALLTRIM(TmpCli.Estas)), 10), 10)
                            loc_lcNome   = "(" + ALLTRIM(TmpCli.Estas) + ") " + ;
                                ALLTRIM(TmpCli.Cidas)
                        ELSE
                            loc_lcCodigo = loc_lcConta
                            loc_lcNome   = ALLTRIM(TmpCli.rclis)
                            loc_lcClaCo  = ALLTRIM(TmpCli.codigos)
                            loc_lcCGrupo = ALLTRIM(TmpCli.grupos)
                            loc_lcContaV = IIF(loc_lnOptMovCad=1, ;
                                ALLTRIM(TmpQuant.Vends), ALLTRIM(TmpCli.contavens))

                            IF loc_lnOptMovCad=1 AND !EMPTY(loc_lcCVendedor) AND ;
                                TmpQuant.Vends # loc_lcCVendedor
                                SELECT TmpQuant
                                LOOP
                            ENDIF
                            IF loc_lnOptMovCad=2 AND !EMPTY(loc_lcCVendedor) AND ;
                                TmpCli.ContaVens # loc_lcCVendedor
                                SELECT TmpQuant
                                LOOP
                            ENDIF

                            IF USED("TmpClaCo")
                                USE IN TmpClaCo
                            ENDIF
                            loc_lcSql = "SELECT codigos,descs,grupos FROM SigCdClc " + ;
                                "WHERE codigos = " + EscaparSQL(loc_lcClaCo) + ;
                                " AND grupos = " + EscaparSQL(loc_lcCGrupo)
                            loc_lnQueryOk = SQLEXEC(gnConnHandle, loc_lcSql, "TmpClaCo")
                            IF loc_lnQueryOk < 1
                                loc_lErroBD = .T.
                                EXIT
                            ENDIF

                            IF USED("TmpCli")
                                USE IN TmpCli
                            ENDIF
                            loc_lcSql = "SELECT iclis,rclis FROM SigCdCli " + ;
                                "WHERE iclis = " + EscaparSQL(loc_lcContaV)
                            loc_lnQueryOk = SQLEXEC(gnConnHandle, loc_lcSql, "TmpCli")
                            IF loc_lnQueryOk < 1
                                loc_lErroBD = .T.
                                EXIT
                            ENDIF
                            SELECT TmpCli
                            GO TOP
                            loc_lcNomeRep = ALLTRIM(TmpCli.iclis) + " - " + ;
                                ALLTRIM(TmpCli.rclis)
                            SELECT TmpClaCo
                            GO TOP
                            loc_lcDclaco = ALLTRIM(TmpClaCo.codigos) + " - " + ;
                                ALLTRIM(TmpClaCo.descs)

                            IF USED("TmpCli")
                                USE IN TmpCli
                            ENDIF
                            loc_lcSql = "SELECT iclis,rclis,codigos,grupos,tabds " + ;
                                "FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_lcConta)
                            loc_lnQueryOk = SQLEXEC(gnConnHandle, loc_lcSql, "TmpCli")
                            IF loc_lnQueryOk < 1
                                loc_lErroBD = .T.
                                EXIT
                            ENDIF
                            SELECT TmpCli
                            GO TOP
                            loc_lcCGrupo = ALLTRIM(TmpCli.grupos)
                            loc_lcClaCo  = ALLTRIM(TmpCli.codigos)

                            IF loc_lnCompa = 1
                                IF loc_lnOptComp = 1
                                    loc_lcCodigo = loc_lcConta
                                    loc_lcNome   = ALLTRIM(TmpCli.rclis)
                                ELSE
                                    IF USED("TmpClaCo")
                                        USE IN TmpClaCo
                                    ENDIF
                                    loc_lcSql = "SELECT codigos,descs FROM SigCdClc " + ;
                                        "WHERE codigos = " + EscaparSQL(loc_lcClaCo) + ;
                                        " AND grupos = " + EscaparSQL(loc_lcCGrupo)
                                    loc_lnQueryOk = SQLEXEC(gnConnHandle, loc_lcSql, "TmpClaCo")
                                    IF loc_lnQueryOk < 1
                                        loc_lErroBD = .T.
                                        EXIT
                                    ENDIF
                                    SELECT TmpClaCo
                                    GO TOP
                                    loc_lcCodigo = ALLTRIM(TmpClaCo.codigos)
                                    loc_lcNome   = ALLTRIM(TmpClaCo.descs)
                                ENDIF
                            ENDIF
                        ENDIF

                        *-- Agrega quantidade no TmpResult
                        SELECT TmpQuant
                        IF TmpQuant.Qtds > 0 AND !EMPTY(loc_lcCodigo)
                            SELECT TmpResult
                            SET ORDER TO cunis
                            IF loc_lnCompa = 1
                                =SEEK(loc_lcCodigo, "TmpResult", "cunis")
                            ELSE
                                =SEEK(loc_lcCodigo + ALLTRIM(TmpQuant.cunis), "TmpResult", "cunis")
                            ENDIF

                            IF EOF("TmpResult")
                                APPEND BLANK IN TmpResult
                                REPLACE ciclis WITH loc_lcCodigo, ;
                                        cRClis WITH loc_lcNome, ;
                                        CUnis  WITH ALLTRIM(TmpQuant.CUnis) IN TmpResult
                                IF loc_lnCid = 0
                                    REPLACE Clacos WITH loc_lcClaCo, ;
                                        cTitulo1s WITH "Cliente : " + ;
                                            ALLTRIM(loc_lcCodigo) + " - " + ;
                                            ALLTRIM(loc_lcNome), ;
                                        cTitulo2s WITH "Representante: " + ;
                                            loc_lcNomeRep, ;
                                        cTitulo3s WITH "Tabela : " + ;
                                            ALLTRIM(TmpCli.tabds), ;
                                        cTitulo4s WITH "Classifica" + CHR(231) + ;
                                            CHR(227) + "o: " + loc_lcDclaco ;
                                        IN TmpResult
                                ENDIF
                            ENDIF

                            REPLACE TmpResult.nqtde WITH TmpResult.nqtde + TmpQuant.qtds

                            FOR x = 1 TO loc_lnAnox
                                IF YEAR(TmpQuant.datas) = (YEAR(loc_ldDtInicial) + x - 1)
                                    loc_lcGrava = "nQtdAno" + STR(x, 1)
                                    REPLACE &loc_lcGrava. WITH &loc_lcGrava. + TmpQuant.qtds
                                    EXIT
                                ENDIF
                            ENDFOR
                        ENDIF

                        SELECT TmpQuant
                    ENDSCAN && WHILE !loc_lErroBD

                    IF loc_lErroBD
                        THIS.this_cMensagemErro = "Falha de Conex" + CHR(227) + ;
                            "o ao processar quantidades"
                        loc_lBdOk = .F.
                    ENDIF
                ENDIF && loc_lBdOk

            ENDIF && this_nOptSelRel = 1 / ELSE

            * ================================================================
            * POS-PROCESSAMENTO: ORDENACAO E RANKING
            * ================================================================
            IF loc_lBdOk
                SELECT TmpResult
                GO TOP
                DELETE FOR EMPTY(ciclis) AND loc_lnOptComp = 2 AND loc_lnCompa = 1

                *-- Calcula ranking por ano (1 a 6)
                FOR x = 1 TO 6
                    loc_lcTagVal = "nVal" + STR(x, 1)
                    loc_lcTagQtd = "nQtd" + STR(x, 1)

                    IF loc_lnOrdem = 1  && Mais Compram
                        IF THIS.this_nOptSelRel = 1
                            SET ORDER TO TAG &loc_lcTagVal DESCENDING
                        ELSE
                            SET ORDER TO TAG &loc_lcTagQtd DESCENDING
                        ENDIF
                    ELSE  && Menos Compram
                        IF THIS.this_nOptSelRel = 1
                            SET ORDER TO TAG &loc_lcTagVal ASCENDING
                        ELSE
                            SET ORDER TO TAG &loc_lcTagQtd ASCENDING
                        ENDIF
                    ENDIF

                    loc_lnConta = 0
                    SELECT TmpResult
                    GO TOP
                    SCAN
                        loc_lnConta = loc_lnConta + 1
                        loc_lcGrava  = "TmpResult.Ordem" + STR(x, 1)
                        loc_lcTagVal = "nValAno" + STR(x, 1)
                        loc_lcTagQtd = "nQtdAno" + STR(x, 1)
                        REPLACE &loc_lcGrava. WITH loc_lnConta
                        IF (THIS.this_nOptSelRel = 1 AND &loc_lcTagVal. = 0) OR ;
                           (THIS.this_nOptSelRel = 2 AND &loc_lcTagQtd. = 0)
                            loc_lnConta = loc_lnConta - 1
                        ENDIF
                    ENDSCAN
                ENDFOR

                *-- MaxOrdem por registro
                SELECT TmpResult
                GO TOP
                SCAN
                    loc_lnMax = 0
                    loc_lnMax = MAX(loc_lnMax, TmpResult.ordem1)
                    loc_lnMax = MAX(loc_lnMax, TmpResult.ordem2)
                    loc_lnMax = MAX(loc_lnMax, TmpResult.ordem3)
                    loc_lnMax = MAX(loc_lnMax, TmpResult.ordem4)
                    loc_lnMax = MAX(loc_lnMax, TmpResult.ordem5)
                    loc_lnMax = MAX(loc_lnMax, TmpResult.ordem6)
                    REPLACE TmpResult.maxordem WITH loc_lnMax
                ENDSCAN

                *-- Ordem final global
                SELECT TmpResult
                IF loc_lnOrdem = 1  && Mais compram
                    IF THIS.this_nOptSelRel = 1
                        SET ORDER TO TAG nValDes
                    ELSE
                        SET ORDER TO TAG nQtdDes
                    ENDIF
                ELSE  && Menos compram
                    IF THIS.this_nOptSelRel = 1
                        SET ORDER TO TAG nValAsc
                    ELSE
                        SET ORDER TO TAG nQtdAsc
                    ENDIF
                ENDIF

                SELECT TmpResult
                loc_lnConta = 0
                SCAN
                    loc_lnConta = loc_lnConta + 1
                    REPLACE TmpResult.ordem     WITH loc_lnConta
                    REPLACE TmpResult.cStrAno1s WITH loc_lcStrAno1
                    REPLACE TmpResult.cEmpresas WITH loc_lcNmEmpresa
                ENDSCAN

                *-- Aplica filtro de valor/quantidade minimo
                IF loc_lnQtMin <> 0
                    IF THIS.this_nOptSelRel = 1
                        DELETE FOR TmpResult.nValComp < loc_lnQtMin
                    ELSE
                        DELETE FOR TmpResult.nqtde < loc_lnQtMin
                    ENDIF
                    GO TOP
                ENDIF

                *-- Aplica limite de quantidade de registros (exceto Nao Compram)
                IF loc_lnQtde <> 0 AND loc_lnOrdem <> 3
                    DELETE FOR TmpResult.ordem > loc_lnQtde
                ENDIF

                *-- "Nao Compram": substitui TmpResult pelos clientes ausentes
                IF loc_lnOrdem = 3
                    IF USED("cursor_4c_Selecao")
                        USE IN cursor_4c_Selecao
                    ENDIF
                    SELECT * FROM TmpCliente ;
                        WHERE Iclis NOT IN (SELECT cIclis FROM TmpResult) ;
                        ORDER BY ContaVens, Iclis ;
                        INTO CURSOR cursor_4c_Selecao READWRITE

                    IF !EMPTY(loc_lcCVendedor)
                        DELETE FROM cursor_4c_Selecao WHERE ContaVens <> loc_lcCVendedor
                    ENDIF

                    ZAP IN TmpResult
                    loc_lnConta = 0
                    SELECT cursor_4c_Selecao
                    GO TOP
                    loc_lcVend = SPACE(10)
                    SCAN
                        SCATTER MEMVAR
                        IF m.ContaVens <> loc_lcVend
                            loc_lnConta = 0
                            loc_lcVend  = m.ContaVens
                        ENDIF
                        loc_lnConta = loc_lnConta + 1
                        INSERT INTO TmpResult (Quebras, ciclis, cRclis, Ordem) ;
                            VALUES (m.ContaVens + " - " + NVL(m.Dvends, ""), ;
                                    m.Iclis, m.Rclis, loc_lnConta)
                    ENDSCAN

                    IF USED("cursor_4c_Selecao")
                        USE IN cursor_4c_Selecao
                    ENDIF
                ENDIF

                *-- "Dados do Cliente" (relatorio SigReCm3): amplia TmpResult com dados CLI
                IF loc_lnDad = 1 AND RECCOUNT("TmpResult") > 0
                    SELECT TmpResult
                    GO TOP
                    loc_lcLista = " AND iclis in ('"
                    SCAN
                        loc_lcLista = loc_lcLista + ALLTRIM(TmpResult.ciclis) + "',"
                    ENDSCAN
                    loc_lcLista = SUBSTR(loc_lcLista, 1, LEN(loc_lcLista) - 2) + ") "

                    IF !EMPTY(loc_lcLista)
                        IF USED("crCli")
                            USE IN crCli
                        ENDIF
                        loc_lnQueryOk = SQLEXEC(gnConnHandle, ;
                            "SELECT iclis,rclis,razaos,cidas,estas," + ;
                            "contato,emails,tel1s FROM SigCdCli WHERE 1=1 " + ;
                            loc_lcLista, "crCli")
                        IF loc_lnQueryOk > 0
                            SELECT a.*, b.* FROM TmpResult a, crCli b ;
                                WHERE a.ciclis = b.iclis ;
                                INTO CURSOR TmpResult READWRITE
                            IF USED("crCli")
                                USE IN crCli
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF

                *-- Ordena final por impressao
                SELECT TmpResult
                INDEX ON Quebras + STR(ordem, 4) TAG impressao
                SET ORDER TO impressao
                GO TOP

                loc_lSucesso = .T.
            ENDIF && loc_lBdOk
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime relatorio para a impressora
    * Seleciona FRX baseado em Comparativo e Dados do Cliente
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_cFRX, loc_cCaminho
        loc_lSucesso = .F.

        IF !THIS.PrepararDados()
            MsgErro(THIS.ObterMensagemErro(), "Erro ao preparar relat" + CHR(243) + "rio")
            RETURN .F.
        ENDIF

        TRY
            loc_cCaminho = gc_4c_CaminhoReports

            IF THIS.this_nComparativo = 1
                loc_cFRX = loc_cCaminho + "SigReCm2.frx"
            ELSE
                IF THIS.this_nChkDadosCli = 1
                    loc_cFRX = loc_cCaminho + "SigReCm3.frx"
                ELSE
                    loc_cFRX = loc_cCaminho + "SigReCm1.frx"
                ENDIF
            ENDIF

            IF FILE(loc_cFRX)
                REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
            ELSE
                MsgAviso("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
                    "o encontrado: " + loc_cFRX, "Aviso")
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao imprimir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe preview do relatorio na tela
    * Seleciona FRX baseado em Comparativo e Dados do Cliente
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_cFRX, loc_cCaminho
        loc_lSucesso = .F.

        IF !THIS.PrepararDados()
            MsgErro(THIS.ObterMensagemErro(), "Erro ao preparar relat" + CHR(243) + "rio")
            RETURN .F.
        ENDIF

        TRY
            loc_cCaminho = gc_4c_CaminhoReports

            IF THIS.this_nComparativo = 1
                loc_cFRX = loc_cCaminho + "SigReCm2.frx"
            ELSE
                IF THIS.this_nChkDadosCli = 1
                    loc_cFRX = loc_cCaminho + "SigReCm3.frx"
                ELSE
                    loc_cFRX = loc_cCaminho + "SigReCm1.frx"
                ENDIF
            ENDIF

            IF FILE(loc_cFRX)
                REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
            ELSE
                MsgAviso("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
                    "o encontrado: " + loc_cFRX, "Aviso")
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao visualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega valores de filtros a partir de cursor
    * Util para restaurar parametros salvos de execucao anterior do relatorio
    * Mapeia TODAS as colunas correspondentes aos filtros
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_aCampos, loc_nQtdCampos, loc_nIdx, loc_cNomeCampo

        loc_lSucesso = .F.

        IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor inv" + CHR(225) + "lido ou n" + ;
                CHR(227) + "o aberto: " + par_cAliasCursor
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAliasCursor)
            IF EOF()
                THIS.this_cMensagemErro = "Cursor vazio: " + par_cAliasCursor
                loc_lSucesso = .F.
            ENDIF

            *-- Coleta lista de campos disponiveis no cursor
            DIMENSION loc_aCampos[1]
            loc_nQtdCampos = AFIELDS(loc_aCampos, par_cAliasCursor)

            *-- Mapeia cada campo do cursor para a propriedade THIS.this_* correspondente
            FOR loc_nIdx = 1 TO loc_nQtdCampos
                loc_cNomeCampo = UPPER(ALLTRIM(loc_aCampos[loc_nIdx, 1]))

                DO CASE
                    CASE loc_cNomeCampo == "EMPRESA" OR loc_cNomeCampo == "EMPS" OR loc_cNomeCampo == "CEMPS"
                        THIS.this_cEmpresa = TratarNulo(EVALUATE(par_cAliasCursor + "." + ;
                            loc_aCampos[loc_nIdx, 1]), "C")
                    CASE loc_cNomeCampo == "DEMPRESA" OR loc_cNomeCampo == "RAZAS"
                        THIS.this_cDEmpresa = TratarNulo(EVALUATE(par_cAliasCursor + "." + ;
                            loc_aCampos[loc_nIdx, 1]), "C")
                    CASE loc_cNomeCampo == "NMOPERACAO" OR loc_cNomeCampo == "DOPES"
                        THIS.this_cNmOperacao = TratarNulo(EVALUATE(par_cAliasCursor + "." + ;
                            loc_aCampos[loc_nIdx, 1]), "C")
                    CASE loc_cNomeCampo == "DTINICIAL" OR loc_cNomeCampo == "DATA_INI"
                        THIS.this_dDtInicial = TratarNulo(EVALUATE(par_cAliasCursor + "." + ;
                            loc_aCampos[loc_nIdx, 1]), "D")
                    CASE loc_cNomeCampo == "DTFINAL" OR loc_cNomeCampo == "DATA_FIM"
                        THIS.this_dDtFinal = TratarNulo(EVALUATE(par_cAliasCursor + "." + ;
                            loc_aCampos[loc_nIdx, 1]), "D")
                    CASE loc_cNomeCampo == "MOEDA" OR loc_cNomeCampo == "CMOES"
                        THIS.this_cMoeda = TratarNulo(EVALUATE(par_cAliasCursor + "." + ;
                            loc_aCampos[loc_nIdx, 1]), "C")
                    CASE loc_cNomeCampo == "MOEDADESC" OR loc_cNomeCampo == "DMOES"
                        THIS.this_cMoedaDesc = TratarNulo(EVALUATE(par_cAliasCursor + "." + ;
                            loc_aCampos[loc_nIdx, 1]), "C")
                    CASE loc_cNomeCampo == "QTDE"
                        THIS.this_nQtde = TratarNulo(EVALUATE(par_cAliasCursor + "." + ;
                            loc_aCampos[loc_nIdx, 1]), "N")
                    CASE loc_cNomeCampo == "QTMIN"
                        THIS.this_nQtMin = TratarNulo(EVALUATE(par_cAliasCursor + "." + ;
                            loc_aCampos[loc_nIdx, 1]), "N")
                    CASE loc_cNomeCampo == "CDCONTA" OR loc_cNomeCampo == "CDESTOQUE"
                        THIS.this_cCdConta = TratarNulo(EVALUATE(par_cAliasCursor + "." + ;
                            loc_aCampos[loc_nIdx, 1]), "C")
                    CASE loc_cNomeCampo == "DSCONTA" OR loc_cNomeCampo == "DSESTOQUE"
                        THIS.this_cDsConta = TratarNulo(EVALUATE(par_cAliasCursor + "." + ;
                            loc_aCampos[loc_nIdx, 1]), "C")
                    CASE loc_cNomeCampo == "CDVENDEDOR"
                        THIS.this_cCdVendedor = TratarNulo(EVALUATE(par_cAliasCursor + "." + ;
                            loc_aCampos[loc_nIdx, 1]), "C")
                    CASE loc_cNomeCampo == "DSVENDEDOR"
                        THIS.this_cDsVendedor = TratarNulo(EVALUATE(par_cAliasCursor + "." + ;
                            loc_aCampos[loc_nIdx, 1]), "C")
                    CASE loc_cNomeCampo == "CDPRODUTO" OR loc_cNomeCampo == "CPROS"
                        THIS.this_cCdProduto = TratarNulo(EVALUATE(par_cAliasCursor + "." + ;
                            loc_aCampos[loc_nIdx, 1]), "C")
                    CASE loc_cNomeCampo == "DSPRODUTO" OR loc_cNomeCampo == "DPROS"
                        THIS.this_cDsProduto = TratarNulo(EVALUATE(par_cAliasCursor + "." + ;
                            loc_aCampos[loc_nIdx, 1]), "C")
                    CASE loc_cNomeCampo == "ORDEM"
                        THIS.this_nOrdem = TratarNulo(EVALUATE(par_cAliasCursor + "." + ;
                            loc_aCampos[loc_nIdx, 1]), "N")
                    CASE loc_cNomeCampo == "OPTSELREL"
                        THIS.this_nOptSelRel = TratarNulo(EVALUATE(par_cAliasCursor + "." + ;
                            loc_aCampos[loc_nIdx, 1]), "N")
                    CASE loc_cNomeCampo == "OPTCOMPARA"
                        THIS.this_nOptCompara = TratarNulo(EVALUATE(par_cAliasCursor + "." + ;
                            loc_aCampos[loc_nIdx, 1]), "N")
                    CASE loc_cNomeCampo == "OPTMOVCAD"
                        THIS.this_nOptMovCad = TratarNulo(EVALUATE(par_cAliasCursor + "." + ;
                            loc_aCampos[loc_nIdx, 1]), "N")
                    CASE loc_cNomeCampo == "COMPARATIVO"
                        THIS.this_nComparativo = TratarNulo(EVALUATE(par_cAliasCursor + "." + ;
                            loc_aCampos[loc_nIdx, 1]), "N")
                    CASE loc_cNomeCampo == "CHKCIDADE"
                        THIS.this_nChkCidade = TratarNulo(EVALUATE(par_cAliasCursor + "." + ;
                            loc_aCampos[loc_nIdx, 1]), "N")
                    CASE loc_cNomeCampo == "CHKDADOSCLI"
                        THIS.this_nChkDadosCli = TratarNulo(EVALUATE(par_cAliasCursor + "." + ;
                            loc_aCampos[loc_nIdx, 1]), "N")
                    CASE loc_cNomeCampo == "CHKVALOR"
                        THIS.this_nChkValor = TratarNulo(EVALUATE(par_cAliasCursor + "." + ;
                            loc_aCampos[loc_nIdx, 1]), "N")
                ENDCASE
            ENDFOR

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar do cursor: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna identificador unico da execucao do relatorio
    * Para relatorios, a "chave" e a combinacao filtros + data de geracao
    * Usado para auditoria e log de execucao
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = "SIGRECMC|" + ;
            ALLTRIM(THIS.this_cEmpresa) + "|" + ;
            DTOC(THIS.this_dDtInicial) + "|" + ;
            DTOC(THIS.this_dDtFinal) + "|" + ;
            ALLTRIM(STR(THIS.this_nOrdem)) + "|" + ;
            ALLTRIM(STR(THIS.this_nOptSelRel)) + "|" + ;
            ALLTRIM(THIS.this_cMoeda)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra execucao do relatorio na tabela LogAuditoria
    * Operacoes possiveis: VISUALIZAR, IMPRIMIR, EXPORTAR
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cChave, loc_cUsuario

        loc_lSucesso = .F.

        IF EMPTY(par_cOperacao)
            RETURN .F.
        ENDIF

        TRY
            loc_cChave   = THIS.ObterChavePrimaria()
            loc_cUsuario = IIF(VARTYPE(gc_4c_UsuarioLogado) = "C", ;
                ALLTRIM(gc_4c_UsuarioLogado), "SISTEMA")

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                "(Usuario, DataHora, Tabela, Operacao, ChaveRegistro, DadosNovos) " + ;
                "VALUES (" + ;
                EscaparSQL(loc_cUsuario) + ", " + ;
                "GETDATE(), " + ;
                EscaparSQL("SIGRECMC") + ", " + ;
                EscaparSQL(ALLTRIM(par_cOperacao)) + ", " + ;
                EscaparSQL(LEFT(loc_cChave, 100)) + ", " + ;
                EscaparSQL("Relat" + CHR(243) + "rio Clientes Mais/Menos/N" + ;
                    CHR(227) + "o Compram - " + ;
                    "Per" + CHR(237) + "odo: " + DTOC(THIS.this_dDtInicial) + ;
                    " a " + DTOC(THIS.this_dDtFinal)) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha ao registrar auditoria"
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro auditoria: " + loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

