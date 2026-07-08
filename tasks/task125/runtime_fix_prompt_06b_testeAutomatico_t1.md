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
[06/06/2026 02:17:56 PM] Erro: Connection handle is invalid.
[06/06/2026 02:17:56 PM] Erro de Inicialização: Connection handle is invalid.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-06-06 14:17:46] [INFO] === VFP EXECUTOR v2.0 ===
[2026-06-06 14:17:46] [INFO] Config FPW: (nao fornecido)
[2026-06-06 14:17:46] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-06-06 14:17:46] [INFO] Timeout: 300 segundos
[2026-06-06 14:17:46] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_v1t4by05.prg
[2026-06-06 14:17:46] [INFO] Conteudo do wrapper:
[2026-06-06 14:17:46] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigreinr', 'C:\4c\tasks\task125', 'REPORT'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigreinr', 'C:\4c\tasks\task125', 'REPORT'
QUIT

[2026-06-06 14:17:46] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_v1t4by05.prg
[2026-06-06 14:17:46] [INFO] VFP output esperado em: C:\4c\tasks\task125\vfp_output.txt
[2026-06-06 14:17:46] [INFO] Executando Visual FoxPro 9...
[2026-06-06 14:17:46] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_v1t4by05.prg
[2026-06-06 14:17:46] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_v1t4by05.prg
[2026-06-06 14:17:46] [INFO] Timeout configurado: 300 segundos
[2026-06-06 14:17:56] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-06-06 14:17:56] [INFO] VFP9 finalizado em 9.7789915 segundos
[2026-06-06 14:17:56] [INFO] Exit Code: 
[2026-06-06 14:17:56] [INFO] 
[2026-06-06 14:17:56] [INFO] Arquivos temporarios preservados para inspecao:
[2026-06-06 14:17:56] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_v1t4by05.prg
[2026-06-06 14:17:56] [INFO] 
[2026-06-06 14:17:56] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-06-06 14:17:56] [INFO] * Auto-generated wrapper for parameters
[2026-06-06 14:17:56] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-06-06 14:17:56] [INFO] * Parameters: 'Formsigreinr', 'C:\4c\tasks\task125', 'REPORT'
[2026-06-06 14:17:56] [INFO] 
[2026-06-06 14:17:56] [INFO] * Anti-dialog protections for unattended execution
[2026-06-06 14:17:56] [INFO] SET SAFETY OFF
[2026-06-06 14:17:56] [INFO] SET RESOURCE OFF
[2026-06-06 14:17:56] [INFO] SET TALK OFF
[2026-06-06 14:17:56] [INFO] SET NOTIFY OFF
[2026-06-06 14:17:56] [INFO] SYS(2335, 0)
[2026-06-06 14:17:56] [INFO] 
[2026-06-06 14:17:56] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigreinr', 'C:\4c\tasks\task125', 'REPORT'
[2026-06-06 14:17:56] [INFO] QUIT
[2026-06-06 14:17:56] [INFO] 
[2026-06-06 14:17:56] [INFO] === Fim do Wrapper.prg ===
[2026-06-06 14:17:56] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formsigreinr",
  "timestamp": "20260606141756",
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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreinr.prg):
*==============================================================================
* FORMSIGREINR.PRG
* Relatorio de Inventario - Formulario de Filtros
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREINR.SCX (frmrelatorio)
*
* Filtros:
*   - TipoRelatorio: 8 opcoes (Resumido/Analitico/Etiqueta/Ocorrencia/etc.)
*   - TipoAnalitico: Produto/Local/Etiqueta (apenas TipoRel=2)
*   - TipoDiferenca: Todos/Com Diferenca (apenas TipoRel=1)
*   - TipoLeitura: Leitura/Releitura (apenas TipoRel=2)
*   - txt_4c_CodProduto / txt_4c_DsProduto : Busca F4 em SigCdPro
*   - txt_4c_CodLocal / txt_4c_DsLocal     : Busca F4 em SigPrLcl
*   - txt_4c_Barra                         : Codigo de barras (TipoAnal=3)
*   - grd_4c_Operacaos                     : Grid de ocorrencias (TipoRel=4)
*
* Chamado com parametro:
*   DO FORM SIGREINR WITH lnNumBal
*
* Posicoes originais: Width=800, Height=461
* PageFrame.Top=85; posicao em Page1 = Top_original - 85
*==============================================================================

DEFINE CLASS Formsigreinr AS FormBase

    Height      = 461
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
    this_nNumBal       = 0

    *--------------------------------------------------------------------------
    * Init - Armazena parametro, inicializa form via FormBase.Init()
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_nNumBal)
        THIS.this_nNumBal = IIF(VARTYPE(par_nNumBal) = "N", par_nNumBal, 0)
        IF !DODEFAULT()
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura visual e carrega dados iniciais
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            THIS.Caption = " Invent" + CHR(225) + "rio n" + CHR(186) + ;
                " " + ALLTRIM(STR(THIS.this_nNumBal))

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            THIS.this_oRelatorio = CREATEOBJECT("sigreinrBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar sigreinrBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                IF !THIS.this_oRelatorio.InicializarDadosBasicos(THIS.this_nNumBal)
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                        "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarPageFrame()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
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
    * ConfigurarCabecalho - Container escuro superior com titulo e botoes
    *   cnt_4c_Cabecalho: Top=0, Left=0, Width=800, Height=80
    *   cmg_4c_Botoes: Left=529, Width=271, 4 botoes (Visualizar/Imprimir/Excel/Encerrar)
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
                    .Top             = 5
                    .Left            = 5
                    .Width           = THIS.Width
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
                    .ToolTipText     = "Gerar o Relat" + CHR(243) + "rio no V" + CHR(237) + "deo"
                    .Themes          = .F.
                    .Visible         = .T.
                ENDWITH

                WITH .Buttons(2)
                    .Top             = 5
                    .Left            = 71
                    .Width           = THIS.Width
                    .Height          = 70
                    .Caption         = "Imprimir"
                    .FontName        = "Tahoma"
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .FontSize        = 8
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
                    .PicturePosition = 13
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .ToolTipText     = "Enviar o Relat" + CHR(243) + "rio Para Impressora"
                    .Themes          = .F.
                    .Visible         = .T.
                ENDWITH

                WITH .Buttons(3)
                    .Top             = 5
                    .Left            = 137
                    .Width           = THIS.Width
                    .Height          = 70
                    .Caption         = "Doc. Excel"
                    .FontName        = "Tahoma"
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .FontSize        = 8
                    .BackColor       = RGB(255, 255, 255)
                    .ForeColor       = RGB(90, 90, 90)
                    .Picture         = gc_4c_CaminhoIcones + "relatorio_excel_26.jpg"
                    .PicturePosition = 13
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .ToolTipText     = "Gerar documento para Excel"
                    .Themes          = .F.
                    .Visible         = .T.
                ENDWITH

                WITH .Buttons(4)
                    .Top             = 5
                    .Left            = 203
                    .Width           = THIS.Width
                    .Height          = 70
                    .Caption         = "Encerrar"
                    .Cancel          = .T.
                    .FontName        = "Tahoma"
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .FontSize        = 8
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
        ENDWITH

        loc_oCmg = loc_oCab.cmg_4c_Botoes
        BINDEVENT(loc_oCmg.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oCmg.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(loc_oCmg.Buttons(3), "Click", THIS, "BtnGerarExcelClick")
        BINDEVENT(loc_oCmg.Buttons(4), "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com 1 pagina (Filtros)
    *   Form: Width=800, Height=461
    *   Cabecalho Height=80; PageFrame.Top=85, Height=461-85=376, Width=802
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
    * ConfigurarPaginaLista - Todos os controles de filtro na Page1
    *   Posicoes em Page1 = Top_original - 85 (altura do cabecalho)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrd
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Rotulo "Relatorio :" (Say1: Top=86 -> Page1: 1)
        loc_oPagina.AddObject("lbl_4c_TipoRel", "Label")
        WITH loc_oPagina.lbl_4c_TipoRel
            .Top       = 1
            .Left      = 77
            .Width     = 55
            .Height    = 15
            .Caption   = "Relat" + CHR(243) + "rio :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup TipoRelatorio (TipoRelat?rio: Top=82 -> Page1: 0)
        *   8 opcoes: Resumido/Analitico/Etiqueta/Ocorrencia/ConsultaEtiqueta/RelacaoComBarra/EstoqueXLeitura/EtiquetaPorEstoque
        loc_oPagina.AddObject("optg_4c_TipoRel", "OptionGroup")
        WITH loc_oPagina.optg_4c_TipoRel
            .AutoSize      = .F.
            .ButtonCount   = 8
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 1
            .Height        = 62
            .Left          = 131
            .SpecialEffect = 1
            .Top           = 0
            .Width         = 370
            .Visible       = .T.

            WITH .Buttons(1)
                .Caption   = "Resumido"
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 15
                .Left      = 5
                .Top       = 5
                .Width     = 64
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Anal" + CHR(237) + "tico"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 15
                .Left      = 99
                .Top       = 5
                .Width     = 58
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "Etiqueta"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 15
                .Left      = 224
                .Top       = 5
                .Width     = 58
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(4)
                .Caption   = "Ocorr" + CHR(234) + "ncia"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 15
                .Left      = 5
                .Top       = 22
                .Width     = 70
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(5)
                .Caption   = "Consulta Etiqueta"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 15
                .Left      = 99
                .Top       = 22
                .Width     = 103
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(6)
                .Caption   = "Rela" + CHR(231) + CHR(227) + "o c/Barra"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 15
                .Left      = 224
                .Top       = 22
                .Width     = 94
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(7)
                .Caption   = "Estoque x Leitura"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 15
                .Left      = 5
                .Top       = 39
                .Width     = 102
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(8)
                .Caption   = "Etiqueta por Estoque"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 15
                .Left      = 224
                .Top       = 38
                .Width     = 119
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
        ENDWITH
        BINDEVENT(loc_oPagina.optg_4c_TipoRel, "InteractiveChange", THIS, "MudouTipoRelatorio")

        *-- Rotulo "Tipo :" (Say4: Top=140 -> Page1: 55)
        loc_oPagina.AddObject("lbl_4c_TipoAnal", "Label")
        WITH loc_oPagina.lbl_4c_TipoAnal
            .Top       = 55
            .Left      = 100
            .Width     = 32
            .Height    = 15
            .Caption   = "Tipo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup TipoAnalitico (Top=135 -> Page1: 50)
        loc_oPagina.AddObject("optg_4c_TipoAnal", "OptionGroup")
        WITH loc_oPagina.optg_4c_TipoAnal
            .AutoSize      = .T.
            .ButtonCount   = 3
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 1
            .Height        = 25
            .Left          = 131
            .SpecialEffect = 1
            .Top           = 50
            .Width         = 287
            .Visible       = .T.

            WITH .Buttons(1)
                .Caption   = "Produto"
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 15
                .Left      = 5
                .Top       = 5
                .Width     = 56
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Local"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 15
                .Left      = 99
                .Top       = 5
                .Width     = 42
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "Etiqueta"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 15
                .Left      = 224
                .Top       = 5
                .Width     = 58
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
        ENDWITH
        BINDEVENT(loc_oPagina.optg_4c_TipoAnal, "InteractiveChange", THIS, "MudouTipoAnalitico")

        *-- Rotulo "Produto :" (lbl_codigo: Top=168 -> Page1: 83)
        loc_oPagina.AddObject("lbl_4c_Produto", "Label")
        WITH loc_oPagina.lbl_4c_Produto
            .Top       = 83
            .Left      = 82
            .Width     = 50
            .Height    = 15
            .Caption   = "Produto :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo Produto (get_cd_codigo: Top=163 -> Page1: 78)
        loc_oPagina.AddObject("txt_4c_CodProduto", "TextBox")
        WITH loc_oPagina.txt_4c_CodProduto
            .Top                = 78
            .Left               = 137
            .Width              = 108
            .Height             = 25
            .Value              = ""
            .MaxLength          = 14
            .FontName           = "Tahoma"
            .FontSize           = 8
            .Format             = "!"
            .SpecialEffect      = 1
            .BorderStyle        = 1
            .ForeColor          = RGB(0, 0, 0)
            .BackColor          = RGB(255, 255, 255)
            .DisabledBackColor  = RGB(255, 255, 255)
            .Enabled            = .F.
            .Visible            = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_CodProduto, "KeyPress",  THIS, "TeclaCodProduto")
        BINDEVENT(loc_oPagina.txt_4c_CodProduto, "DblClick",  THIS, "AbrirBuscaCodProduto")
        BINDEVENT(loc_oPagina.txt_4c_CodProduto, "KeyPress", THIS, "ValidarCodProduto")

        *-- TextBox Descricao Produto (get_ds_codigo: Top=163 -> Page1: 78)
        loc_oPagina.AddObject("txt_4c_DsProduto", "TextBox")
        WITH loc_oPagina.txt_4c_DsProduto
            .Top                = 78
            .Left               = 247
            .Width              = 290
            .Height             = 25
            .Value              = ""
            .MaxLength          = 40
            .FontName           = "Tahoma"
            .FontSize           = 8
            .Format             = "!"
            .SpecialEffect      = 1
            .BorderStyle        = 1
            .ForeColor          = RGB(0, 0, 0)
            .BackColor          = RGB(255, 255, 255)
            .DisabledBackColor  = RGB(255, 255, 255)
            .Enabled            = .F.
            .Visible            = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DsProduto, "KeyPress",  THIS, "TeclaDsProduto")
        BINDEVENT(loc_oPagina.txt_4c_DsProduto, "DblClick",  THIS, "AbrirBuscaDsProduto")
        BINDEVENT(loc_oPagina.txt_4c_DsProduto, "KeyPress", THIS, "ValidarDsProduto")

        *-- Rotulo "Local :" (Say5: Top=195 -> Page1: 110)
        loc_oPagina.AddObject("lbl_4c_Local", "Label")
        WITH loc_oPagina.lbl_4c_Local
            .Top       = 110
            .Left      = 96
            .Width     = 36
            .Height    = 15
            .Caption   = "Local :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo Local (Get_Local: Top=190 -> Page1: 105)
        loc_oPagina.AddObject("txt_4c_CodLocal", "TextBox")
        WITH loc_oPagina.txt_4c_CodLocal
            .Top                = 105
            .Left               = 137
            .Width              = 108
            .Height             = 25
            .Value              = ""
            .MaxLength          = 10
            .FontName           = "Tahoma"
            .FontSize           = 8
            .Alignment          = 3
            .SpecialEffect      = 1
            .ForeColor          = RGB(0, 0, 0)
            .BackColor          = RGB(255, 255, 255)
            .DisabledBackColor  = RGB(255, 255, 255)
            .Enabled            = .F.
            .Visible            = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_CodLocal, "KeyPress",  THIS, "TeclaCodLocal")
        BINDEVENT(loc_oPagina.txt_4c_CodLocal, "DblClick",  THIS, "AbrirBuscaCodLocal")
        BINDEVENT(loc_oPagina.txt_4c_CodLocal, "KeyPress", THIS, "ValidarCodLocal")

        *-- TextBox Descricao Local (get_Dlocal: Top=190 -> Page1: 105)
        loc_oPagina.AddObject("txt_4c_DsLocal", "TextBox")
        WITH loc_oPagina.txt_4c_DsLocal
            .Top                = 105
            .Left               = 247
            .Width              = 290
            .Height             = 25
            .Value              = ""
            .MaxLength          = 20
            .FontName           = "Tahoma"
            .FontSize           = 8
            .Alignment          = 3
            .SpecialEffect      = 1
            .ForeColor          = RGB(0, 0, 0)
            .BackColor          = RGB(255, 255, 255)
            .DisabledBackColor  = RGB(255, 255, 255)
            .Enabled            = .F.
            .Visible            = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DsLocal, "KeyPress",  THIS, "TeclaDsLocal")
        BINDEVENT(loc_oPagina.txt_4c_DsLocal, "DblClick",  THIS, "AbrirBuscaDsLocal")
        BINDEVENT(loc_oPagina.txt_4c_DsLocal, "KeyPress", THIS, "ValidarDsLocal")

        *-- Rotulo "Etiqueta :" (Say8: Top=222 -> Page1: 137)
        loc_oPagina.AddObject("lbl_4c_Etiqueta", "Label")
        WITH loc_oPagina.lbl_4c_Etiqueta
            .Top       = 137
            .Left      = 80
            .Width     = 52
            .Height    = 15
            .Caption   = "Etiqueta :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Barra (Get_Barra: Top=217 -> Page1: 132)
        loc_oPagina.AddObject("txt_4c_Barra", "TextBox")
        WITH loc_oPagina.txt_4c_Barra
            .Top                = 132
            .Left               = 137
            .Width              = 108
            .Height             = 25
            .Value              = 0
            .InputMask          = "99999999999999"
            .Format             = "!"
            .FontName           = "Tahoma"
            .FontSize           = 8
            .BorderStyle        = 1
            .SpecialEffect      = 1
            .ForeColor          = RGB(0, 0, 0)
            .BackColor          = RGB(255, 255, 255)
            .DisabledBackColor  = RGB(255, 255, 255)
            .Enabled            = .F.
            .Visible            = .T.
        ENDWITH

        *-- Rotulo "Itens :" (Say2: Top=249 -> Page1: 164)
        loc_oPagina.AddObject("lbl_4c_Itens", "Label")
        WITH loc_oPagina.lbl_4c_Itens
            .Top       = 164
            .Left      = 95
            .Width     = 37
            .Height    = 15
            .Caption   = "Itens :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup TipoDiferenca (TipoDiferen?a: Top=244 -> Page1: 159)
        loc_oPagina.AddObject("optg_4c_TipoDif", "OptionGroup")
        WITH loc_oPagina.optg_4c_TipoDif
            .AutoSize      = .T.
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 2
            .Height        = 25
            .Left          = 131
            .SpecialEffect = 1
            .Top           = 159
            .Width         = 168
            .Visible       = .T.

            WITH .Buttons(1)
                .Caption   = "Todos"
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 15
                .Left      = 5
                .Top       = 5
                .Width     = 47
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Com Diferen" + CHR(231) + "a"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 15
                .Left      = 75
                .Top       = 5
                .Width     = 88
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
        ENDWITH

        *-- Rotulo "Leitura :" (Say3: Top=271 -> Page1: 186)
        loc_oPagina.AddObject("lbl_4c_Leitura", "Label")
        WITH loc_oPagina.lbl_4c_Leitura
            .Top       = 186
            .Left      = 87
            .Width     = 45
            .Height    = 15
            .Caption   = "Leitura :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup TipoLeitura (Top=266 -> Page1: 181)
        loc_oPagina.AddObject("optg_4c_TipoLeitura", "OptionGroup")
        WITH loc_oPagina.optg_4c_TipoLeitura
            .AutoSize      = .T.
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 1
            .Height        = 25
            .Left          = 131
            .SpecialEffect = 1
            .Top           = 181
            .Width         = 141
            .Visible       = .T.

            WITH .Buttons(1)
                .Caption   = "Leitura"
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 15
                .Left      = 5
                .Top       = 5
                .Width     = 51
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Releitura"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 15
                .Left      = 75
                .Top       = 5
                .Width     = 61
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
        ENDWITH

        *-- Rotulo "Preco Custo :" (Say6: Top=294 -> Page1: 209)
        loc_oPagina.AddObject("lbl_4c_TpCusto", "Label")
        WITH loc_oPagina.lbl_4c_TpCusto
            .Top       = 209
            .Left      = 62
            .Width     = 70
            .Height    = 15
            .Caption   = "Pre" + CHR(231) + "o Custo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .F.
        ENDWITH

        *-- OptionGroup TipoCusto (optgTpCusto: Top=288 -> Page1: 203)
        loc_oPagina.AddObject("optg_4c_TpCusto", "OptionGroup")
        WITH loc_oPagina.optg_4c_TpCusto
            .AutoSize      = .T.
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 2
            .Height        = 27
            .Left          = 131
            .Top           = 203
            .Width         = 121
            .Visible       = .F.

            WITH .Buttons(1)
                .Caption   = "\<Sim"
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 17
                .Left      = 5
                .Top       = 5
                .Width     = 40
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "\<N" + CHR(227) + "o"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 17
                .Left      = 75
                .Top       = 5
                .Width     = 41
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
        ENDWITH

        *-- Rotulo "Preco Venda :" (Say7: Top=319 -> Page1: 234)
        loc_oPagina.AddObject("lbl_4c_TpVenda", "Label")
        WITH loc_oPagina.lbl_4c_TpVenda
            .Top       = 234
            .Left      = 60
            .Width     = 72
            .Height    = 15
            .Caption   = "Pre" + CHR(231) + "o Venda :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup TipoVenda (optgTpVenda: Top=313 -> Page1: 228)
        loc_oPagina.AddObject("optg_4c_TpVenda", "OptionGroup")
        WITH loc_oPagina.optg_4c_TpVenda
            .AutoSize      = .T.
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 1
            .Height        = 27
            .Left          = 131
            .Top           = 228
            .Width         = 121
            .Visible       = .T.

            WITH .Buttons(1)
                .Caption   = "\<Sim"
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 17
                .Left      = 5
                .Top       = 5
                .Width     = 40
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "\<N" + CHR(227) + "o"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 17
                .Left      = 75
                .Top       = 5
                .Width     = 41
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
        ENDWITH

        *-- Rotulo "Foto :" (Say9: Top=343 -> Page1: 258)
        loc_oPagina.AddObject("lbl_4c_Foto", "Label")
        WITH loc_oPagina.lbl_4c_Foto
            .Top       = 258
            .Left      = 98
            .Width     = 34
            .Height    = 15
            .Caption   = "Foto :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Foto (OptFoto: Top=337 -> Page1: 252)
        loc_oPagina.AddObject("optg_4c_Foto", "OptionGroup")
        WITH loc_oPagina.optg_4c_Foto
            .AutoSize      = .T.
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 2
            .Height        = 27
            .Left          = 131
            .Top           = 252
            .Width         = 121
            .Visible       = .T.

            WITH .Buttons(1)
                .Caption   = "\<Sim"
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 17
                .Left      = 5
                .Top       = 5
                .Width     = 40
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "\<N" + CHR(227) + "o"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 17
                .Left      = 75
                .Top       = 5
                .Width     = 41
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
        ENDWITH

        *-- Rotulo "Etiquetas Faltando :" (Say10: Top=367 -> Page1: 282)
        loc_oPagina.AddObject("lbl_4c_Etiq", "Label")
        WITH loc_oPagina.lbl_4c_Etiq
            .Top       = 282
            .Left      = 30
            .Width     = 102
            .Height    = 15
            .Caption   = "Etiquetas Faltando :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Etiquetas (OptEtiq: Top=361 -> Page1: 276)
        loc_oPagina.AddObject("optg_4c_Etiq", "OptionGroup")
        WITH loc_oPagina.optg_4c_Etiq
            .AutoSize      = .T.
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 2
            .Height        = 27
            .Left          = 131
            .Top           = 276
            .Width         = 121
            .Visible       = .T.

            WITH .Buttons(1)
                .Caption   = "\<Sim"
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 17
                .Left      = 5
                .Top       = 5
                .Width     = 40
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "\<N" + CHR(227) + "o"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 17
                .Left      = 75
                .Top       = 5
                .Width     = 41
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
        ENDWITH

        *-- Rotulo "Mostrar Observacao :" (lblObs: Top=390 -> Page1: 305)
        loc_oPagina.AddObject("lbl_4c_Obs", "Label")
        WITH loc_oPagina.lbl_4c_Obs
            .Top       = 305
            .Left      = 22
            .Width     = 110
            .Height    = 15
            .Caption   = "Mostrar Observa" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Observacao (OptObs: Top=384 -> Page1: 299)
        loc_oPagina.AddObject("optg_4c_Obs", "OptionGroup")
        WITH loc_oPagina.optg_4c_Obs
            .AutoSize      = .T.
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 2
            .Height        = 27
            .Left          = 131
            .Top           = 299
            .Width         = 121
            .Visible       = .T.

            WITH .Buttons(1)
                .Caption   = "\<Sim"
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 17
                .Left      = 5
                .Top       = 5
                .Width     = 40
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "\<N" + CHR(227) + "o"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 17
                .Left      = 75
                .Top       = 5
                .Width     = 41
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
        ENDWITH

        *-- Rotulo "Mostrar Colecao :" (Say12: Top=411 -> Page1: 326)
        loc_oPagina.AddObject("lbl_4c_Colecao", "Label")
        WITH loc_oPagina.lbl_4c_Colecao
            .Top       = 326
            .Left      = 42
            .Width     = 90
            .Height    = 15
            .Caption   = "Mostrar Cole" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Colecao (OptCtg: Top=405 -> Page1: 320)
        loc_oPagina.AddObject("optg_4c_Ctg", "OptionGroup")
        WITH loc_oPagina.optg_4c_Ctg
            .AutoSize      = .T.
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 2
            .Height        = 27
            .Left          = 130
            .Top           = 320
            .Width         = 121
            .Visible       = .T.

            WITH .Buttons(1)
                .Caption   = "\<Sim"
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 17
                .Left      = 5
                .Top       = 5
                .Width     = 40
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "\<N" + CHR(227) + "o"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 17
                .Left      = 75
                .Top       = 5
                .Width     = 41
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
        ENDWITH

        *-- Rotulo "Mostrar Categoria :" (Say13: Top=433 -> Page1: 348)
        loc_oPagina.AddObject("lbl_4c_Ctg", "Label")
        WITH loc_oPagina.lbl_4c_Ctg
            .Top       = 348
            .Left      = 33
            .Width     = 99
            .Height    = 15
            .Caption   = "Mostrar Categoria :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Categoria (OptCol: Top=427 -> Page1: 342)
        loc_oPagina.AddObject("optg_4c_Col", "OptionGroup")
        WITH loc_oPagina.optg_4c_Col
            .AutoSize      = .T.
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .Value         = 2
            .Height        = 27
            .Left          = 130
            .Top           = 342
            .Width         = 121
            .Visible       = .T.

            WITH .Buttons(1)
                .Caption   = "\<Sim"
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 17
                .Left      = 5
                .Top       = 5
                .Width     = 40
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "\<N" + CHR(227) + "o"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .BackStyle = 0
                .Height    = 17
                .Left      = 75
                .Top       = 5
                .Width     = 41
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
        ENDWITH

        *-- Rotulo "Ocorrencias" (Say11: Top=227 -> Page1: 142, Left=348)
        loc_oPagina.AddObject("lbl_4c_Ocorrencias", "Label")
        WITH loc_oPagina.lbl_4c_Ocorrencias
            .Top       = 142
            .Left      = 348
            .Width     = 72
            .Height    = 15
            .Caption   = "Ocorr" + CHR(234) + "ncias"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .F.
        ENDWITH

        *-- Grid Operacoes (grdOperacaos: Top=242 -> Page1: 157, Left=348)
        *   ColumnCount e RecordSource definidos ANTES do WITH para que colunas existam
        loc_oPagina.AddObject("grd_4c_Operacaos", "Grid")
        loc_oPagina.grd_4c_Operacaos.ColumnCount  = 3
        loc_oPagina.grd_4c_Operacaos.RecordSource = "CsOperacaos"
        WITH loc_oPagina.grd_4c_Operacaos
            .Top               = 157
            .Left              = 348
            .Width             = 340
            .Height            = 201
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .HeaderHeight      = 0
            .RecordMark        = .F.
            .ScrollBars        = 2
            .GridLineColor     = RGB(238, 238, 238)
            .FontName          = "Tahoma"
            .Visible           = .F.
        ENDWITH

        loc_oPagina.grd_4c_Operacaos.Column1.Width         = 15
        loc_oPagina.grd_4c_Operacaos.Column1.Movable       = .F.
        loc_oPagina.grd_4c_Operacaos.Column1.Resizable     = .F.
        loc_oPagina.grd_4c_Operacaos.Column1.Sparse        = .F.

        loc_oPagina.grd_4c_Operacaos.Column2.Width         = 80
        loc_oPagina.grd_4c_Operacaos.Column2.Movable       = .F.
        loc_oPagina.grd_4c_Operacaos.Column2.Resizable     = .F.
        loc_oPagina.grd_4c_Operacaos.Column2.ReadOnly      = .T.
        loc_oPagina.grd_4c_Operacaos.Column2.ControlSource = "CsOperacaos.Codigos"

        loc_oPagina.grd_4c_Operacaos.Column3.Width         = 220
        loc_oPagina.grd_4c_Operacaos.Column3.Movable       = .F.
        loc_oPagina.grd_4c_Operacaos.Column3.Resizable     = .F.
        loc_oPagina.grd_4c_Operacaos.Column3.ReadOnly      = .T.
        loc_oPagina.grd_4c_Operacaos.Column3.ControlSource = "CsOperacaos.Descrs"

        *-- Adiciona CheckBox na Column1 para marcar ocorrencias
        loc_oPagina.grd_4c_Operacaos.Column1.AddObject("chk_4c_Marca", "CheckBox")
        WITH loc_oPagina.grd_4c_Operacaos.Column1.chk_4c_Marca
            .AutoSize      = .T.
            .Alignment     = 0
            .Caption       = ""
            .BackStyle     = 0
            .Visible       = .T.
        ENDWITH
        loc_oPagina.grd_4c_Operacaos.Column1.CurrentControl  = "chk_4c_Marca"
        loc_oPagina.grd_4c_Operacaos.Column1.ControlSource   = "CsOperacaos.Marcas"
        BINDEVENT(loc_oPagina.grd_4c_Operacaos.Column1.chk_4c_Marca, ;
            "Click", THIS, "CliqueCheckOperacao")

        *-- Botao Selecionar Tudo (SelTudo: Top=279 -> Page1: 194, Left=696)
        loc_oPagina.AddObject("cmd_4c_SelTudo", "CommandButton")
        WITH loc_oPagina.cmd_4c_SelTudo
            .Top          = 194
            .Left         = 696
            .Width        = 40
            .Height       = 40
            .Caption      = ""
            .FontName     = "Verdana"
            .FontSize     = 8
            .WordWrap     = .T.
            .Picture      = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .TabStop      = .F.
            .ToolTipText  = "Seleciona Tudo"
            .ForeColor    = RGB(36, 84, 155)
            .BackColor    = RGB(255, 255, 255)
            .Themes       = .F.
            .Visible      = .F.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_SelTudo, "Click", THIS, "CliqueSelTudo")

        *-- Botao Cancela Tudo (apaga: Top=320 -> Page1: 235, Left=696)
        loc_oPagina.AddObject("cmd_4c_Apaga", "CommandButton")
        WITH loc_oPagina.cmd_4c_Apaga
            .Top          = 235
            .Left         = 696
            .Width        = 40
            .Height       = 40
            .Caption      = ""
            .FontName     = "Verdana"
            .FontSize     = 8
            .WordWrap     = .T.
            .Picture      = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .TabStop      = .F.
            .ToolTipText  = "Cancela Tudo"
            .ForeColor    = RGB(36, 84, 155)
            .BackColor    = RGB(255, 255, 255)
            .Themes       = .F.
            .Visible      = .F.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Apaga, "Click", THIS, "CliqueApaga")

        *-- Controle de acesso via fChecaAcesso
        THIS.AplicarAcessoControles()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Nao aplicavel para form de relatorio (stub)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarAcessoControles - Controla visibilidade conforme perfil do usuario
    *   fChecaAcesso("SIGREINR", "CUSTO") -> mostra/oculta optg_4c_TpCusto
    *   fChecaAcesso("SIGREINR", "RELATORIO") -> controla opcoes do TipoRel
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarAcessoControles()
        LOCAL loc_oPg, loc_lCusto, loc_lRelatorio, loc_oErro
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        TRY
            loc_lCusto     = fChecaAcesso("SIGREINR", "CUSTO")
            loc_lRelatorio = fChecaAcesso("SIGREINR", "RELATORIO")
        CATCH TO loc_oErro
            loc_lCusto     = .F.
            loc_lRelatorio = .T.
        ENDTRY

        *-- Custo: visivel apenas se tem acesso
        loc_oPg.lbl_4c_TpCusto.Visible    = loc_lCusto
        loc_oPg.optg_4c_TpCusto.Visible   = loc_lCusto
        IF !loc_lCusto
            loc_oPg.optg_4c_TpCusto.Value = 2
        ENDIF
        THIS.this_oRelatorio.this_lPermissaoCusto = loc_lCusto

        *-- Relatorio completo: oculta opcoes restrictas se sem acesso
        IF !loc_lRelatorio
            loc_oPg.optg_4c_TipoRel.Buttons(2).Visible = .F.
            loc_oPg.optg_4c_TipoRel.Buttons(4).Visible = .F.
            loc_oPg.optg_4c_TipoRel.Buttons(5).Visible = .F.
            loc_oPg.optg_4c_TipoRel.Buttons(6).Visible = .F.
            loc_oPg.optg_4c_TipoRel.Buttons(7).Visible = .F.
        ENDIF
        THIS.this_oRelatorio.this_lPermissaoRelatorio = loc_lRelatorio
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere valores dos controles para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPg, loc_oErro
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        TRY
            WITH THIS.this_oRelatorio
                .this_nTipoRel    = loc_oPg.optg_4c_TipoRel.Value
                .this_nTipoDif    = loc_oPg.optg_4c_TipoDif.Value
                .this_nTipoLeitura = loc_oPg.optg_4c_TipoLeitura.Value
                .this_nTipoAnal   = loc_oPg.optg_4c_TipoAnal.Value
                .this_cProduto    = ALLTRIM(loc_oPg.txt_4c_CodProduto.Value)
                .this_cDsProduto  = ALLTRIM(loc_oPg.txt_4c_DsProduto.Value)
                .this_cLocal      = ALLTRIM(loc_oPg.txt_4c_CodLocal.Value)
                .this_cDsLocal    = ALLTRIM(loc_oPg.txt_4c_DsLocal.Value)
                .this_nBarra      = TRANSFORM(loc_oPg.txt_4c_Barra.Value)
                .this_nOptTpCusto = loc_oPg.optg_4c_TpCusto.Value
                .this_nOptTpVenda = loc_oPg.optg_4c_TpVenda.Value
                .this_nOptFoto    = loc_oPg.optg_4c_Foto.Value
                .this_nOptEtiq    = loc_oPg.optg_4c_Etiq.Value
                .this_nOptObs     = loc_oPg.optg_4c_Obs.Value
                .this_nOptCtg     = loc_oPg.optg_4c_Ctg.Value
                .this_nOptCol     = loc_oPg.optg_4c_Col.Value
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormParaRelatorio")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Delega validacao ao BO (apos FormParaRelatorio)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarFiltros()
        RETURN THIS.this_oRelatorio.ValidarFiltros()
    ENDPROC

    *==========================================================================
    * CONTROLE DE ESTADO - INTERACTIVIDADE DOS FILTROS
    *==========================================================================

    *--------------------------------------------------------------------------
    * MudouTipoRelatorio - Atualiza estado dos controles conforme TipoRel
    *   Espelha TipoRelat?rio.InteractiveChange do legado
    *--------------------------------------------------------------------------
    PROCEDURE MudouTipoRelatorio()
        LOCAL loc_nTipo, loc_oPg, loc_lPermCusto
        loc_oPg   = THIS.pgf_4c_Paginas.Page1
        loc_nTipo = loc_oPg.optg_4c_TipoRel.Value

        *-- TipoDiferenca: apenas TipoRel=1
        loc_oPg.optg_4c_TipoDif.SetAll("Enabled", (loc_nTipo = 1), "OptionButton")

        *-- TipoLeitura e TipoAnalitico: apenas TipoRel=2
        loc_oPg.optg_4c_TipoLeitura.SetAll("Enabled", (loc_nTipo = 2), "OptionButton")
        loc_oPg.optg_4c_TipoAnal.SetAll("Enabled", (loc_nTipo = 2), "OptionButton")

        *-- TpCusto e TpVenda: apenas TipoRel=1, e se tem permissao
        loc_lPermCusto = THIS.this_oRelatorio.this_lPermissaoCusto
        loc_oPg.optg_4c_TpCusto.SetAll("Enabled", (loc_nTipo = 1 AND loc_lPermCusto), "OptionButton")
        loc_oPg.optg_4c_TpVenda.SetAll("Enabled", (loc_nTipo = 1), "OptionButton")

        *-- Foto e Etiq: apenas TipoRel=1
        loc_oPg.optg_4c_Foto.SetAll("Enabled", (loc_nTipo = 1), "OptionButton")
        loc_oPg.optg_4c_Etiq.SetAll("Enabled", (loc_nTipo = 1), "OptionButton")

        *-- Campos Produto/Local/Barra: apenas TipoRel=2
        loc_oPg.txt_4c_CodProduto.Enabled = (loc_nTipo = 2 AND loc_oPg.optg_4c_TipoAnal.Value = 1)
        loc_oPg.txt_4c_DsProduto.Enabled  = (loc_nTipo = 2 AND loc_oPg.optg_4c_TipoAnal.Value = 1)
        loc_oPg.txt_4c_CodLocal.Enabled   = (loc_nTipo = 2 AND loc_oPg.optg_4c_TipoAnal.Value = 2)
        loc_oPg.txt_4c_DsLocal.Enabled    = (loc_nTipo = 2 AND loc_oPg.optg_4c_TipoAnal.Value = 2)
        loc_oPg.txt_4c_Barra.Enabled      = (loc_nTipo = 2 AND loc_oPg.optg_4c_TipoAnal.Value = 3)

        *-- Grid de ocorrencias: apenas TipoRel=4
        loc_oPg.grd_4c_Operacaos.Visible   = (loc_nTipo = 4)
        loc_oPg.cmd_4c_Apaga.Visible       = (loc_nTipo = 4)
        loc_oPg.cmd_4c_SelTudo.Visible     = (loc_nTipo = 4)
        loc_oPg.lbl_4c_Ocorrencias.Visible = (loc_nTipo = 4)

        *-- Obs/Colecao/Categoria: apenas TipoRel=1 ou 3
        loc_oPg.lbl_4c_Obs.Visible      = INLIST(loc_nTipo, 1, 3)
        loc_oPg.optg_4c_Obs.Visible     = INLIST(loc_nTipo, 1, 3)
        loc_oPg.lbl_4c_Colecao.Visible  = INLIST(loc_nTipo, 1, 3)
        loc_oPg.optg_4c_Ctg.Visible     = INLIST(loc_nTipo, 1, 3)
        loc_oPg.lbl_4c_Ctg.Visible      = INLIST(loc_nTipo, 1, 3)
        loc_oPg.optg_4c_Col.Visible     = INLIST(loc_nTipo, 1, 3)

        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * MudouTipoAnalitico - Atualiza campos de filtro conforme TipoAnal
    *   Espelha TipoAnal?tico.InteractiveChange do legado
    *--------------------------------------------------------------------------
    PROCEDURE MudouTipoAnalitico()
        LOCAL loc_nAnal, loc_oPg
        loc_oPg   = THIS.pgf_4c_Paginas.Page1
        loc_nAnal = loc_oPg.optg_4c_TipoAnal.Value

        loc_oPg.txt_4c_CodProduto.Enabled = (loc_nAnal = 1)
        loc_oPg.txt_4c_DsProduto.Enabled  = (loc_nAnal = 1)
        loc_oPg.txt_4c_CodLocal.Enabled   = (loc_nAnal = 2)
        loc_oPg.txt_4c_DsLocal.Enabled    = (loc_nAnal = 2)
        loc_oPg.txt_4c_Barra.Enabled      = (loc_nAnal = 3)

        DO CASE
            CASE loc_nAnal = 1
                loc_oPg.txt_4c_CodProduto.SetFocus()
            CASE loc_nAnal = 2
                loc_oPg.txt_4c_CodLocal.SetFocus()
            OTHERWISE
                loc_oPg.txt_4c_Barra.SetFocus()
        ENDCASE
    ENDPROC

    *==========================================================================
    * LOOKUPS - PRODUTO
    *==========================================================================

    PROCEDURE TeclaCodProduto(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaCodProduto()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsProduto(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaDsProduto()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaCodProduto()
        LOCAL loc_oPg, loc_cValor, loc_oForm, loc_nResult, loc_nBarra
        LOCAL lnbarra_val, lcpros_val
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CodProduto.Value)

        *-- Se valor e numerico, pode ser codigo de barras -> busca em SigOpEtq
        loc_nBarra = VAL(loc_cValor)
        IF loc_nBarra > 0
            lnbarra_val = loc_nBarra
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "Select CPros From SigOpEtq Where CBars = ?lnbarra_val", ;
                "cursor_4c_EtqLkp")
            IF loc_nResult > 0
                SELECT cursor_4c_EtqLkp
                GO TOP
                IF !EOF()
                    loc_cValor = ALLTRIM(cursor_4c_EtqLkp.CPros)
                ENDIF
                USE IN cursor_4c_EtqLkp
            ENDIF
        ENDIF

        *-- Busca direta por codigo na SigCdPro
        lcpros_val  = loc_cValor
        loc_nResult = SQLEXEC(gnConnHandle, ;
            "Select cpros,dpros From SigCdPro Where cpros = ?lcpros_val", ;
            "cursor_4c_ProLkp")
        IF loc_nResult > 0
            SELECT cursor_4c_ProLkp
            GO TOP
            IF !EOF()
                loc_oPg.txt_4c_CodProduto.Value = ALLTRIM(cursor_4c_ProLkp.cpros)
                loc_oPg.txt_4c_DsProduto.Value  = ALLTRIM(cursor_4c_ProLkp.dpros)
                USE IN cursor_4c_ProLkp
                RETURN
            ENDIF
            USE IN cursor_4c_ProLkp
        ENDIF

        *-- Nao encontrado: abre FormBuscaAuxiliar
        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdPro", "cursor_4c_ProBusca", "cpros", loc_cValor, "Produtos")
        IF ISNULL(loc_oForm)
            RETURN
        ENDIF
        IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
        ENDIF
        IF loc_oForm.this_lSelecionou AND USED("cursor_4c_ProBusca")
            loc_oPg.txt_4c_CodProduto.Value = ALLTRIM(cursor_4c_ProBusca.cpros)
            loc_oPg.txt_4c_DsProduto.Value  = ALLTRIM(cursor_4c_ProBusca.dpros)
        ELSE
            loc_oPg.txt_4c_CodProduto.Value = ""
            loc_oPg.txt_4c_DsProduto.Value  = ""
        ENDIF
        IF USED("cursor_4c_ProBusca")
            USE IN cursor_4c_ProBusca
        ENDIF
        loc_oForm.Release()
    ENDPROC

    PROCEDURE AbrirBuscaDsProduto()
        LOCAL loc_oPg, loc_cValor, loc_oForm
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsProduto.Value)

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdPro", "cursor_4c_ProBusca", "dpros", loc_cValor, "Produtos")
        IF ISNULL(loc_oForm)
            RETURN
        ENDIF
        IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
            loc_oForm.Show()
        ENDIF
        IF loc_oForm.this_lSelecionou AND USED("cursor_4c_ProBusca")
            loc_oPg.txt_4c_CodProduto.Value = ALLTRIM(cursor_4c_ProBusca.cpros)
            loc_oPg.txt_4c_DsProduto.Value  = ALLTRIM(cursor_4c_ProBusca.dpros)
        ELSE
            loc_oPg.txt_4c_CodProduto.Value = ""
            loc_oPg.txt_4c_DsProduto.Value  = ""
        ENDIF
        IF USED("cursor_4c_ProBusca")
            USE IN cursor_4c_ProBusca
        ENDIF
        loc_oForm.Release()
    ENDPROC

    PROCEDURE ValidarCodProduto(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor, lcpros_val, loc_nResult
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CodProduto.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_DsProduto.Value = ""
            RETURN
        ENDIF
        lcpros_val  = loc_cValor
        loc_nResult = SQLEXEC(gnConnHandle, ;
            "Select cpros,dpros From SigCdPro Where cpros = ?lcpros_val", ;
            "cursor_4c_ProVal")
        IF loc_nResult > 0
            SELECT cursor_4c_ProVal
            GO TOP
            IF !EOF()
                loc_oPg.txt_4c_CodProduto.Value = ALLTRIM(cursor_4c_ProVal.cpros)
                loc_oPg.txt_4c_DsProduto.Value  = ALLTRIM(cursor_4c_ProVal.dpros)
            ELSE
                THIS.AbrirBuscaCodProduto()
            ENDIF
            USE IN cursor_4c_ProVal
        ENDIF
    ENDPROC

    PROCEDURE ValidarDsProduto(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsProduto.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_CodProduto.Value = ""
            loc_oPg.txt_4c_DsProduto.Value  = ""
            RETURN
        ENDIF
        THIS.AbrirBuscaDsProduto()
    ENDPROC

    *==========================================================================
    * LOOKUPS - LOCAL
    *==========================================================================

    PROCEDURE TeclaCodLocal(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaCodLocal()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsLocal(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaDsLocal()
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaCodLocal()
        LOCAL loc_oPg, loc_cValor, loc_oForm
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CodLocal.Value)

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigPrLcl", "cursor_4c_LclBusca", "codigos", loc_cValor, "Locais")
        IF ISNULL(loc_oForm)
            RETURN
        ENDIF
        IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("codigos",     "", "C" + CHR(243) + "digo")
            loc_oForm.mAddColuna("descricaos",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.Show()
        ENDIF
        IF loc_oForm.this_lSelecionou AND USED("cursor_4c_LclBusca")
            loc_oPg.txt_4c_CodLocal.Value = ALLTRIM(cursor_4c_LclBusca.codigos)
            loc_oPg.txt_4c_DsLocal.Value  = ALLTRIM(cursor_4c_LclBusca.descricaos)
        ELSE
            loc_oPg.txt_4c_CodLocal.Value = ""
            loc_oPg.txt_4c_DsLocal.Value  = ""
        ENDIF
        IF USED("cursor_4c_LclBusca")
            USE IN cursor_4c_LclBusca
        ENDIF
        loc_oForm.Release()
    ENDPROC

    PROCEDURE AbrirBuscaDsLocal()
        LOCAL loc_oPg, loc_cValor, loc_oForm
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsLocal.Value)

        loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigPrLcl", "cursor_4c_LclBusca", "descricaos", loc_cValor, "Locais")
        IF ISNULL(loc_oForm)
            RETURN
        ENDIF
        IF !loc_oForm.this_lAchouRegistro
            loc_oForm.mAddColuna("descricaos",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oForm.mAddColuna("codigos",     "", "C" + CHR(243) + "digo")
            loc_oForm.Show()
        ENDIF
        IF loc_oForm.this_lSelecionou AND USED("cursor_4c_LclBusca")
            loc_oPg.txt_4c_CodLocal.Value = ALLTRIM(cursor_4c_LclBusca.codigos)
            loc_oPg.txt_4c_DsLocal.Value  = ALLTRIM(cursor_4c_LclBusca.descricaos)
        ELSE
            loc_oPg.txt_4c_CodLocal.Value = ""
            loc_oPg.txt_4c_DsLocal.Value  = ""
        ENDIF
        IF USED("cursor_4c_LclBusca")
            USE IN cursor_4c_LclBusca
        ENDIF
        loc_oForm.Release()
    ENDPROC

    PROCEDURE ValidarCodLocal(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor, lcodigos_val, loc_nResult
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CodLocal.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_DsLocal.Value = ""
            RETURN
        ENDIF
        lcodigos_val = loc_cValor
        loc_nResult  = SQLEXEC(gnConnHandle, ;
            "Select codigos,descricaos From SigPrLcl Where codigos = ?lcodigos_val", ;
            "cursor_4c_LclVal")
        IF loc_nResult > 0
            SELECT cursor_4c_LclVal
            GO TOP
            IF !EOF()
                loc_oPg.txt_4c_CodLocal.Value = ALLTRIM(cursor_4c_LclVal.codigos)
                loc_oPg.txt_4c_DsLocal.Value  = ALLTRIM(cursor_4c_LclVal.descricaos)
            ELSE
                THIS.AbrirBuscaCodLocal()
            ENDIF
            USE IN cursor_4c_LclVal
        ENDIF
    ENDPROC

    PROCEDURE ValidarDsLocal(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cValor
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsLocal.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_CodLocal.Value = ""
            loc_oPg.txt_4c_DsLocal.Value  = ""
            RETURN
        ENDIF
        THIS.AbrirBuscaDsLocal()
    ENDPROC

    *==========================================================================
    * GRID OCORRENCIAS
    *==========================================================================

    PROCEDURE CliqueCheckOperacao()
        IF USED("CsOperacaos")
            SELECT CsOperacaos
            REPLACE Marcas WITH IIF(CsOperacaos.Marcas = 0, 1, 0) IN CsOperacaos
            THIS.pgf_4c_Paginas.Page1.grd_4c_Operacaos.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE CliqueSelTudo()
        IF USED("CsOperacaos")
            SELECT CsOperacaos
            UPDATE CsOperacaos SET Marcas = 1
            GO TOP
            THIS.pgf_4c_Paginas.Page1.grd_4c_Operacaos.Refresh()
            THIS.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE CliqueApaga()
        IF USED("CsOperacaos")
            SELECT CsOperacaos
            UPDATE CsOperacaos SET Marcas = 0
            GO TOP
            THIS.pgf_4c_Paginas.Page1.grd_4c_Operacaos.Refresh()
            THIS.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * ACOES DOS BOTOES DO RELATORIO
    *==========================================================================

    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro
        TRY
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.ValidarFiltros()
                MsgAviso(THIS.this_oRelatorio.ObterMensagemErro(), ;
                    "Campo Obrigat" + CHR(243) + "rio")
                RETURN
            ENDIF
            IF !THIS.this_oRelatorio.PrepararDados()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro no Processamento")
                RETURN
            ENDIF
            IF !THIS.this_oRelatorio.Visualizar()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                    "Erro na Visualiza" + CHR(231) + CHR(227) + "o")
            ELSE
                THIS.this_oRelatorio.RegistrarAuditoria("VISUALIZAR")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    PROCEDURE BtnImprimirClick()
        LOCAL loc_oErro
        TRY
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.ValidarFiltros()
                MsgAviso(THIS.this_oRelatorio.ObterMensagemErro(), ;
                    "Campo Obrigat" + CHR(243) + "rio")
                RETURN
            ENDIF
            IF !THIS.this_oRelatorio.PrepararDados()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro no Processamento")
                RETURN
            ENDIF
            IF !THIS.this_oRelatorio.Imprimir(.T.)
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro na Impress" + CHR(227) + "o")
            ELSE
                THIS.this_oRelatorio.RegistrarAuditoria("IMPRIMIR")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    PROCEDURE BtnGerarExcelClick()
        LOCAL loc_oErro
        TRY
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.ValidarFiltros()
                MsgAviso(THIS.this_oRelatorio.ObterMensagemErro(), ;
                    "Campo Obrigat" + CHR(243) + "rio")
                RETURN
            ENDIF
            IF !THIS.this_oRelatorio.PrepararDados()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro no Processamento")
                RETURN
            ENDIF
            IF !THIS.this_oRelatorio.Imprimir(.F.)
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro ao Gerar Documento")
            ELSE
                THIS.this_oRelatorio.RegistrarAuditoria("EXCEL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * MAPEAMENTO CRUD -> REPORT (aliases para compatibilidade com pipeline)
    *==========================================================================

    PROCEDURE BtnIncluirClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnAlterarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnExcluirClick()
        MsgInfo("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + ;
            CHR(237) + "vel em relat" + CHR(243) + "rios." + CHR(13) + ;
            "Use Visualizar ou Imprimir.", "Aten" + CHR(231) + CHR(227) + "o")
    ENDPROC

    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    PROTECTED PROCEDURE BOParaForm()
        RETURN .T.
    ENDPROC

    PROCEDURE HabilitarCampos(par_lHabilitar)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Restaura valores padrao dos controles
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPg, loc_oErro
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            loc_oPg.txt_4c_CodProduto.Value    = ""
            loc_oPg.txt_4c_DsProduto.Value     = ""
            loc_oPg.txt_4c_CodLocal.Value      = ""
            loc_oPg.txt_4c_DsLocal.Value       = ""
            loc_oPg.txt_4c_Barra.Value         = 0
            loc_oPg.optg_4c_TipoRel.Value      = 1
            loc_oPg.optg_4c_TipoDif.Value      = 2
            loc_oPg.optg_4c_TipoLeitura.Value  = 1
            loc_oPg.optg_4c_TipoAnal.Value     = 1
            loc_oPg.optg_4c_TpCusto.Value      = 2
            loc_oPg.optg_4c_TpVenda.Value      = 1
            loc_oPg.optg_4c_Foto.Value         = 2
            loc_oPg.optg_4c_Etiq.Value         = 2
            loc_oPg.optg_4c_Obs.Value          = 2
            loc_oPg.optg_4c_Ctg.Value          = 2
            loc_oPg.optg_4c_Col.Value          = 2
            THIS.MudouTipoRelatorio()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    PROCEDURE AjustarBotoesPorModo()
        TRY
            IF VARTYPE(THIS.cnt_4c_Cabecalho) = "O"
                IF PEMSTATUS(THIS.cnt_4c_Cabecalho, "cmg_4c_Botoes", 5)
                    THIS.cnt_4c_Cabecalho.cmg_4c_Botoes.Buttons(1).Enabled = .T.
                    THIS.cnt_4c_Cabecalho.cmg_4c_Botoes.Buttons(2).Enabled = .T.
                    THIS.cnt_4c_Cabecalho.cmg_4c_Botoes.Buttons(3).Enabled = .T.
                    THIS.cnt_4c_Cabecalho.cmg_4c_Botoes.Buttons(4).Enabled = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE AlternarPagina(par_nPagina)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera referencia ao BO (Custom nao tem Release, usar .NULL.)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigreinrBO.prg):
*==============================================================================
* SIGREINRBO.PRG
* Business Object para Relatorio de Inventario (SIGREINR)
* Herda de: RelatorioBase
*==============================================================================

DEFINE CLASS sigreinrBO AS RelatorioBase

    this_nNumBal         = 0
    this_nTipoRel        = 1

    *-- Tipo diferenca: 1=Todos, 2=Com Diferenca
    this_nTipoDif        = 2

    *-- Tipo leitura: 1=Leitura, 2=Releitura
    this_nTipoLeitura    = 1

    *-- Tipo analitico: 1=Produto, 2=Local, 3=Etiqueta/Barras
    this_nTipoAnal       = 1

    this_cProduto        = ""
    this_cDsProduto      = ""
    this_cLocal          = ""
    this_cDsLocal        = ""
    this_nBarra          = 0

    *-- Opcoes de impressao (1=Sim 2=Nao)
    this_nOptTpCusto     = 2
    this_nOptTpVenda     = 1
    this_nOptFoto        = 2
    this_nOptEtiq        = 2
    this_nOptObs         = 2
    this_nOptCtg         = 2
    this_nOptCol         = 2

    this_lTrataPeso      = .F.
    this_cEmpresa        = ""
    this_cTitulo         = ""
    this_lHorizontal     = .F.
    this_nTotalLido      = 0
    this_nTotalEsto      = 0
    this_nSaldo          = 0
    this_nSaldoPs        = 0

    *-- CsRelatorio: nome do cursor de saida (referenciado pelos FRX legados)
    this_cCursorDados    = "CsRelatorio"

    *-- Controle de acesso (setado pelo Form via fChecaAcesso)
    this_lBalcTrats      = .F.
    this_lPermissaoCusto     = .F.
    this_lPermissaoRelatorio = .T.

    this_cMensagemErro   = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarDadosBasicos - Carrega cursores SQL necessarios para o form
    * Chamado por Form.InicializarForm() com o numero do balanco
    *--------------------------------------------------------------------------
    PROCEDURE InicializarDadosBasicos(par_nNumBal)
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL, loc_oErro
        LOCAL lcEmpr, loc_cTmp
        loc_lSucesso = .F.

        THIS.this_nNumBal = par_nNumBal

        TRY
            lcEmpr = go_4c_Sistema.cCodEmpresa

            *-- CsFiltro
            IF USED("CsFiltro")
                USE IN CsFiltro
            ENDIF
            CREATE CURSOR CsFiltro (FGrupo c(50), FEstoque c(80), FPeriodo c(60), ;
                FLocal c(60), FIFor c(60), FCGru c(60), FCGGru c(60), FPreco c(60), ;
                CObs M, llVisCtg l, llVisCol l)

            *-- CsSigCdPam
            IF USED("CsSigCdPam")
                USE IN CsSigCdPam
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, "Select BalcTrats From SigCdPam", ;
                "cursor_4c_PamTmp")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + CHR(227) + "o (CsSigCdPam)"
                loc_lSucesso = .F.
            ENDIF
            SELECT * FROM cursor_4c_PamTmp INTO CURSOR CsSigCdPam READWRITE
            USE IN cursor_4c_PamTmp
            SELECT CsSigCdPam
            GO TOP
            IF !EOF()
                IF VARTYPE(CsSigCdPam.BalcTrats) = "L"
                    THIS.this_lBalcTrats = CsSigCdPam.BalcTrats
                ELSE
                    IF VARTYPE(CsSigCdPam.BalcTrats) = "L"
                        THIS.this_lBalcTrats = CsSigCdPam.BalcTrats
                    ELSE
                        IF VARTYPE(CsSigCdPam.BalcTrats) = "L"
                            THIS.this_lBalcTrats = CsSigCdPam.BalcTrats
                        ELSE
                            IF VARTYPE(CsSigCdPam.BalcTrats) = "L"
                                THIS.this_lBalcTrats = CsSigCdPam.BalcTrats
                            ELSE
                                THIS.this_lBalcTrats = (NVL(CsSigCdPam.BalcTrats, 0) = 1)
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

            *-- CsSigCdBal
            IF USED("CsSigCdBal")
                USE IN CsSigCdBal
            ENDIF
            loc_cSQL = "Select * From SigCdBal Where Emps = ?lcEmpr And Codigos = ?par_nNumBal"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BalTmp")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + CHR(227) + "o (CsSigCdBal)"
                loc_lSucesso = .F.
            ENDIF
            SELECT * FROM cursor_4c_BalTmp INTO CURSOR CsSigCdBal READWRITE
            USE IN cursor_4c_BalTmp

            *-- CrSigCdEmp
            IF USED("CrSigCdEmp")
                USE IN CrSigCdEmp
            ENDIF
            loc_cSQL = "Select CEmps,Razas From SigCdEmp Where CEmps = ?lcEmpr"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigCdEmp")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + CHR(227) + "o (CrSigCdEmp)"
                loc_lSucesso = .F.
            ENDIF
            SELECT CrSigCdEmp
            GO TOP
            IF !EOF()
                THIS.this_cEmpresa = ALLTRIM(CrSigCdEmp.CEmps) + ;
                    IIF(!EMPTY(CrSigCdEmp.Razas), " - " + ALLTRIM(CrSigCdEmp.Razas), "")
            ENDIF

            *-- CrSigCdGcr
            IF USED("CrSigCdGcr")
                USE IN CrSigCdGcr
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "Select Codigos,Descrs From SigCdGcr", "CrSigCdGcr")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + CHR(227) + "o (CrSigCdGcr)"
                loc_lSucesso = .F.
            ENDIF
            SELECT CrSigCdGcr
            INDEX ON Codigos TAG Codigos
            GO TOP

            *-- CsOperacaos - grid de ocorrencias (TipoRel=4), precisa ser READWRITE
            IF USED("CsOperacaos")
                USE IN CsOperacaos
            ENDIF
            loc_cSQL = [Select 0 As Marcas,Codigos,Descrs From SigBaOco Where Tipos = 'O' Order By Codigos]
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeTmp")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + CHR(227) + "o (CsOperacaos)"
                loc_lSucesso = .F.
            ENDIF
            SELECT * FROM cursor_4c_OpeTmp INTO CURSOR CsOperacaos READWRITE
            USE IN cursor_4c_OpeTmp
            SELECT CsOperacaos
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Processa dados conforme tipo de relatorio
    * Equivalente ao PROCEDURE processamento do legado
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL, loc_oErro
        LOCAL lnNumBal, lcEmpr, lnTpCusto, lnTpVenda
        LOCAL lnDecimals, lcFixed, lcEscape, lcTalk
        LOCAL lcDsGrupo, lcDsConta, lcDataInis, lcDataFims
        LOCAL llImpObs, llMostraCtg, llMostraCol, lnTcLinhas
        LOCAL lcpro, lcSql, lcBarra, lcCampoTc, lcCodigo, lcDirectory, lcFoto
        LOCAL lnValor, lnValPesos, lnCusto, lnRegs, lnRega, llOk
        LOCAL lcpros_val, lnbarra_val, lclocal_val, lnTipoL1, lnTipoL3
        LOCAL lcpro_prev, lnBarra_prev
        loc_lSucesso = .F.

        TRY
            lnNumBal    = THIS.this_nNumBal
            lcEmpr      = go_4c_Sistema.cCodEmpresa
            lnTpCusto   = THIS.this_nOptTpCusto
            lnTpVenda   = THIS.this_nOptTpVenda
            llImpObs    = (THIS.this_nOptObs = 1)
            llMostraCtg = (THIS.this_nOptCtg = 1)
            llMostraCol = (THIS.this_nOptCol = 1)
            THIS.this_lHorizontal = .F.

            *-- Garante CsSigCdBal carregado
            IF !USED("CsSigCdBal")
                loc_cSQL = "Select * From SigCdBal Where Emps = ?lcEmpr And Codigos = ?lnNumBal"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BalTmp2")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + CHR(227) + "o (CsSigCdBal)"
                    loc_lSucesso = .F.
                ENDIF
                SELECT * FROM cursor_4c_BalTmp2 INTO CURSOR CsSigCdBal READWRITE
                USE IN cursor_4c_BalTmp2
            ENDIF

            SELECT CsSigCdBal
            GO TOP
            SCATTER MEMVAR MEMO

            THIS.this_lTrataPeso = (m.trtporpeso = 1)

            *-- Descricao do grupo
            lcDsGrupo = ""
            IF USED("CrSigCdGcr") AND !EMPTY(m.Grupos)
                IF SEEK(m.Grupos, "CrSigCdGcr", "Codigos")
                    lcDsGrupo = ALLTRIM(CrSigCdGcr.descrs)
                ENDIF
            ENDIF

            *-- Descricao da conta/estoque
            lcDsConta = ""
            IF !EMPTY(m.Contas)
                LOCAL lccontas_val
                lccontas_val = ALLTRIM(m.Contas)
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "Select iclis,rclis From SigCdCli Where iclis = ?lccontas_val", "TmpCli")
                IF loc_nResult > 0
                    SELECT TmpCli
                    GO TOP
                    IF !EOF()
                        lcDsConta = ALLTRIM(TmpCli.RClis)
                    ENDIF
                    USE IN TmpCli
                ENDIF
            ENDIF

            *-- Monta cabecalho de filtros
            lcDataInis  = IIF(EMPTY(m.DataInis), "", DTOC(m.DataInis))
            lcDataFims  = IIF(EMPTY(m.DataFims), "", DTOC(m.DataFims))
            m.FGrupo    = IIF(!EMPTY(m.Grupos),  "     Grupo: " + ALLTRIM(m.Grupos) + IIF(!EMPTY(lcDsGrupo), " - " + lcDsGrupo, ""), "")
            m.FEstoque  = IIF(!EMPTY(m.Contas),  "   Estoque: " + ALLTRIM(m.Contas) + IIF(!EMPTY(lcDsConta), " - " + lcDsConta, ""), "")
            m.FPeriodo  = IIF(!EMPTY(lcDataInis + lcDataFims), "   Periodo: " + lcDataInis + " - " + lcDataFims, "")
            m.FLocal    = IIF(!EMPTY(m.LocalIs + m.LocalFs),  "     Local: " + m.LocalIs + " - " + m.LocalFs, "")
            m.FIFor     = IIF(!EMPTY(m.IForIs + m.IForFs),   "Fornecedor: " + m.IForIs + " - " + m.IForFs, "")
            m.FCGru     = IIF(!EMPTY(m.CGruIs + m.CGruFs),   "     Grupo: " + m.CGruIs + " - " + m.CGruFs, "")
            m.FCGGru    = IIF(!EMPTY(m.CGGruIs + m.CGGruFs), "Gde. Grupo: " + m.CGGruIs + " - " + m.CGGruFs, "")
            m.FPreco    = IIF(m.PrecoIs + m.PrecoFs > 0, "     Pre" + CHR(231) + "o: " + ;
                STR(m.PrecoIs, 9, 2) + " - " + STR(m.PrecoFs, 9, 2), "")
            m.CObs      = ""
            m.llVisCtg  = llMostraCtg
            m.llVisCol  = llMostraCol

            IF llImpObs
                m.CObs = IIF(EMPTY(m.Obs), "", "Observa" + CHR(231) + CHR(227) + "o: " + ALLTRIM(m.Obs))
            ENDIF

            IF USED("CsFiltro")
                SELECT CsFiltro
                INSERT INTO CsFiltro FROM MEMVAR
            ENDIF

            IF USED("CrSMoeda")
                USE IN CrSMoeda
            ENDIF
            IF USED("CsRelatorio")
                USE IN CsRelatorio
            ENDIF

            DO CASE

            *==================================================================
            CASE THIS.this_nTipoRel = 1

                THIS.this_cTitulo = "Relat" + CHR(243) + "rio Resumido do Invent" + CHR(225) + "rio n" + ;
                    CHR(186) + " " + ALLTRIM(STR(lnNumBal)) + " - " + ;
                    IIF(THIS.this_nTipoDif = 1, "Todos", "Com Diferen" + CHR(231) + "a")

                lnDecimals = SET("Decimals")
                lcFixed    = SET("Fixed")
                lcEscape   = SET("Escape")
                lcTalk     = SET("Talk")

                SET ESCAPE OFF
                SET TALK ON
                SET DECIMALS TO 2
                SET FIXED ON

                WAIT WINDOW "Aguarde! Selecionando Produtos..." NOWAIT

                loc_cSQL = [Select a.*,b.CustoFs,b.MoeCusFs,b.PVens As PPVens,b.Moevs,b.FVendas,b.MoePVs,b.Linhas,b.Reffs, ] + ;
                    [ltrim(rtrim(isnull(b.Colecoes,'')))+'-'+ltrim(rtrim(isnull(d.descs,''))) as Colecoes,] + ;
                    [ltrim(rtrim(isnull(b.Categoria,'')))+'-' +ltrim(rtrim(isnull(e.descs,''))) as Categoria,] + ;
                    [b.PesoMs,Space(200) as Obs, c.TpCustos As TpCus ]

                IF THIS.this_nOptFoto = 1
                    loc_cSQL = loc_cSQL + [, b.dPros, b.FigJpgs ]
                ENDIF

                loc_cSQL = loc_cSQL + ;
                    [From SigIvTrB a, SigCdPro b ] + ;
                    [Left Join SigCdLin c On c.Linhas = b.Linhas ] + ;
                    [left Join sigcdctg e on b.categoria = e.cods ] + ;
                    [left Join SigCdCol d on b.Colecoes = d.colecoes ] + ;
                    [Where a.Emps = ?lcEmpr And a.Codigos = ?lnNumBal And b.CPros = a.CPros ] + ;
                    [Order By a.CIdChaves ]

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BaseTmp") < 1
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + CHR(227) + "o (Base)"
                    loc_lSucesso = .F.
                ENDIF
                SELECT * FROM cursor_4c_BaseTmp INTO CURSOR Base READWRITE
                USE IN cursor_4c_BaseTmp

                SELECT Base
                GO TOP
                INDEX ON CPros + CodCors + CodTams + Contas TAG CPros
                REPLACE ALL Lidos WITH 0, ReLidos WITH 0, Lidops WITH 0, ReLidops WITH 0

                lcSql = [Select CPros, CodCors, CodTams, Contas, CBars, Tipos, Qtds, Pesos, PesReals, ] + ;
                    [IsNull(Obs, Space(200)) as Obs ] + ;
                    [From SigIvTrH ] + ;
                    [Where Codigos = ?lnNumBal And Emps = ?lcEmpr Order By CIdChaves ]

                IF SQLEXEC(gnConnHandle, lcSql, "crTmpHist") < 1
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + CHR(227) + "o (crTmpHist)"
                    loc_lSucesso = .F.
                ENDIF

                SELECT crTmpHist
                WAIT WINDOW "Aguarde!!! Processando Produtos Lidos/Relidos..." NOWAIT
                SCAN
                    IF !SEEK(crTmpHist.CPros + crTmpHist.CodCors + crTmpHist.CodTams + ;
                        crTmpHist.Contas, "Base", "CPros")
                        INSERT INTO Base (CPros, CodCors, CodTams, Contas, Emps, Codigos, Obs) ;
                            VALUES (crTmpHist.CPros, crTmpHist.CodCors, crTmpHist.CodTams, ;
                                crTmpHist.Contas, lcEmpr, lnNumBal, crTmpHist.Obs)
                    ELSE
                        REPLACE Obs WITH crTmpHist.Obs IN Base
                    ENDIF

                    llOk = .T.
                    IF !EMPTY(crTmpHist.CBars)
                        lnbarra_val = crTmpHist.CBars
                        lcSql = [Select * from SigIvTrE Where Cbars = ] + ;
                            STR(crTmpHist.CBars, 14) + [ And Codigos = ?lnNumBal ]
                        IF SQLEXEC(gnConnHandle, lcSql, "CrTmpEti") > 0
                            IF EOF("CrTmpEti")
                                IF SQLEXEC(gnConnHandle, ;
                                    "Select * From SigOpEtq Where CBars = ?lnbarra_val", "CsTmpEti") > 0
                                    IF EOF("CsTmpEti")
                                        IF SQLEXEC(gnConnHandle, ;
                                            "Select * From SigCdPro Where CBars = ?lnbarra_val", "CrTmpEti") > 0
                                            IF EOF("CrTmpEti")
                                                llOk = .F.
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF

                    IF llOk
                        IF INLIST(crTmpHist.Tipos, 1, 3)
                            REPLACE Lidos  WITH Lidos  + crTmpHist.Qtds  IN Base
                            REPLACE Lidops WITH Lidops + crTmpHist.Pesos IN Base
                        ELSE
                            REPLACE ReLidos  WITH ReLidos  + crTmpHist.Qtds  IN Base
                            REPLACE ReLidops WITH ReLidops + crTmpHist.Pesos IN Base
                        ENDIF
                    ENDIF

                    SELECT crTmpHist
                ENDSCAN
                WAIT CLEAR

                SELECT Base
                GO TOP

                SELECT a.*, ;
                    VAL(STR(a.PPVens * (a.Saldos - IIF(EMPTY(a.ReLidos), a.Lidos, a.ReLidos)), 16, 2)) AS PVens, ;
                    VAL(STR(a.PPVens * (a.Saldops - IIF(EMPTY(a.ReLidops), a.Lidops, a.ReLidops)), 16, 2)) AS PVenPesos, ;
                    lnTpCusto AS TpCustos, lnTpVenda AS TpVendas, ;
                    Space(200) AS TcCabecs, Space(200) AS TcTraco1s, ;
                    Space(200) AS TcLinhas, Space(200) AS TcLinhas1, Space(200) AS TcLinhas2, ;
                    Space(200) AS TcLinhas3, Space(200) AS TcLinhas4, ;
                    "1" AS Ps, Space(11) AS OrdImg ;
                FROM Base a ;
                ORDER BY a.Contas, a.CPros, a.CodCors, a.CodTams ;
                INTO CURSOR CsBase READWRITE

                WAIT WINDOW "Aguarde! Calculando Custos..." NOWAIT

                lnTcLinhas = 1

                SELECT * FROM CsBase INTO CURSOR CsRelatorio READWRITE
                SELECT CsRelatorio
                GO TOP
                SCAN
                    lnCusto = CsRelatorio.CustoFs
                    IF NVL(CsRelatorio.TpCus, "") = "2"
                        lnCusto = CsRelatorio.PesoMs * CsRelatorio.CustoFs
                    ENDIF
                    REPLACE CsRelatorio.CustoFs WITH ;
                        lnCusto * (CsRelatorio.Saldos - IIF(EMPTY(CsRelatorio.ReLidos), ;
                        CsRelatorio.Lidos, CsRelatorio.ReLidos))

                    IF THIS.this_nOptFoto = 1
                        IF EMPTY(CsRelatorio.FigJpgs) OR ISNULL(CsRelatorio.FigJpgs)
                            REPLACE OrdImg WITH "FBRANCOS" IN CsRelatorio
                        ELSE
                            lcCodigo    = ALLTRIM(CsRelatorio.cPros)
                            lcCodigo    = STRTRAN(lcCodigo, "/", "")
                            lcCodigo    = STRTRAN(lcCodigo, " ", "")
                            lcDirectory = SYS(2023) + "\F" + ALLTRIM(lcCodigo) + ".Jpg"
                            REPLACE OrdImg WITH "F" + ALLTRIM(lcCodigo) IN CsRelatorio
                            lcFoto = STRTRAN(STRTRAN(STRTRAN(CsRelatorio.FigJpgs, ;
                                "data:image/png;base64,", ""), ;
                                "data:image/jpeg;base64,", ""), ;
                                "data:image/jpg;base64,", "")
                            STRTOFILE(STRCONV(lcFoto, 14), lcDirectory)
                        ENDIF
                    ENDIF

                    IF THIS.this_nOptEtiq = 1
                        lcpros_val = CsRelatorio.cPros
                        IF (IIF(EMPTY(CsRelatorio.ReLidos), CsRelatorio.Lidos, CsRelatorio.ReLidos) > ;
                            CsRelatorio.Saldos) OR ;
                            (IIF(EMPTY(CsRelatorio.ReLidops), CsRelatorio.Lidops, CsRelatorio.ReLidops) > ;
                            CsRelatorio.Saldops)
                            lcSql = [Select cBars from SigIvTrH Where cPros = '] + lcpros_val + ;
                                [' And Codigos = ] + STR(lnNumBal) + ;
                                [ And not cBars in (Select cBars from SigIvTre Where cPros = '] + ;
                                lcpros_val + [' And Codigos = ] + STR(lnNumBal) + [)]
                        ELSE
                            lcSql = [Select cBars from SigIvTrE Where cPros = '] + lcpros_val + ;
                                [' And Codigos = ] + STR(lnNumBal) + ;
                                [ And not cBars in (Select cBars from SigIvTrH Where cPros = '] + ;
                                lcpros_val + [' And Codigos = ] + STR(lnNumBal) + [)]
                        ENDIF
                        SQLEXEC(gnConnHandle, lcSql, "crBarras")
                        SELECT crBarras
                        GO TOP
                        SCAN
                            SELECT CsRelatorio
                            IF THIS.this_nOptFoto = 1
                                lcCampoTc = "TcLinhas" + STR(lnTcLinhas, 1)
                                lcBarra = ALLTRIM(STR(crBarras.cBars, 14)) + ", "
                                IF lnTcLinhas < 5
                                    IF LEN(ALLTRIM(&lcCampoTc)) + LEN(lcBarra) > 146
                                        lnTcLinhas = lnTcLinhas + 1
                                        lcCampoTc = "TcLinhas" + STR(lnTcLinhas, 1)
                                    ENDIF
                                    REPLACE &lcCampoTc WITH ALLTRIM(&lcCampoTc) + lcBarra
                                ENDIF
                            ENDIF
                            SELECT crBarras
                        ENDSCAN
                        SELECT CsRelatorio
                    ENDIF
                ENDSCAN

                *-- Totais por moeda
                SELECT a.Moecusfs AS Moedas, ;
                    VAL(STR(SUM(a.CustoFs), 16, 2)) AS CustoFs, ;
                    0000000000000000.00 AS PVens, ;
                    0000000000000000.00 AS PVenPesos ;
                FROM CsBase a ;
                WHERE lnTpCusto = 1 ;
                GROUP BY a.Moecusfs ;
                UNION ALL ;
                SELECT a.MoeVs AS Moedas, ;
                    0000000000000000.00 AS CustoFs, ;
                    VAL(STR(SUM(a.PVens), 16, 2)) AS PVens, ;
                    VAL(STR(SUM(a.PVenPesos), 16, 2)) AS PVenPesos ;
                FROM CsBase a ;
                WHERE lnTpVenda = 1 ;
                GROUP BY a.MoeVs ;
                ORDER BY 1 ;
                INTO CURSOR crSMoeda READWRITE

                WAIT WINDOW "Aguarde! Finalizando o processamento..." NOWAIT

                SELECT CsRelatorio
                INDEX ON Ps + Contas + CPros + CodCors + CodTams TAG Chave1
                SET ORDER TO "" IN CsRelatorio
                GO TOP

                SCAN
                    m.TcCabecs = PADR(PADC("Produto", IIF(THIS.this_nOptFoto = 1, 41, 14)) + " " + ;
                        PADC("Cor/Tam", 09) + " " + ;
                        PADC("Apurado", 10) + " " + ;
                        PADC("Estoque", 11) + " " + ;
                        PADC("Sobra", 10) + " " + ;
                        PADC("Falta", 10) + " " + ;
                        IIF(llMostraCtg, PADC("Colecoes", 30) + " ", "") + ;
                        IIF(llMostraCol, PADC("Categoria", 20) + " ", "") + ;
                        IIF(CsRelatorio.TpCustos = 1, PADC("Pre" + CHR(231) + "o Custo", 14) + " ", "") + ;
                        IIF(CsRelatorio.TpVendas = 1, PADC("Pre" + CHR(231) + "o Venda", 14) + " ", "") + ;
                        IIF(CsRelatorio.TpVendas = 1, PADC("Fator Venda", 14) + " ", "") + ;
                        IIF(THIS.this_lTrataPeso, PADC("Peso Apur", 9) + " " + ;
                            PADC("Peso Estq", 9) + " " + ;
                            PADC("Sobra", 10) + " " + ;
                            PADC("Falta", 10), "") + " " + ;
                        PADC("Observa" + CHR(231) + CHR(227) + "o", 10), 220)

                    m.TcTraco1s = PADR(REPLICATE("_", IIF(THIS.this_nOptFoto = 1, 41, 14)) + " " + ;
                        REPLICATE("_", 09) + " " + ;
                        REPLICATE("_", 10) + " " + ;
                        REPLICATE("_", 11) + " " + ;
                        REPLICATE("_", 10) + " " + ;
                        REPLICATE("_", 10) + " " + ;
                        IIF(llMostraCtg, REPLICATE("_", 30) + " ", "") + ;
                        IIF(llMostraCol, REPLICATE("_", 20) + " ", "") + ;
                        IIF(CsRelatorio.TpCustos = 1, REPLICATE("_", 14) + " ", "") + ;
                        IIF(CsRelatorio.TpVendas = 1, REPLICATE("_", 14) + " ", "") + ;
                        IIF(CsRelatorio.TpVendas = 1, REPLICATE("_", 14) + " ", "") + ;
                        IIF(THIS.this_lTrataPeso, REPLICATE("_", 9) + " " + ;
                            REPLICATE("_", 9) + " " + ;
                            REPLICATE("_", 10) + " " + ;
                            REPLICATE("_", 10), "") + " " + ;
                        REPLICATE("_", 10), 220)

                    lnValor    = CsRelatorio.Saldos - ;
                        IIF(EMPTY(CsRelatorio.ReLidos), CsRelatorio.Lidos, CsRelatorio.ReLidos)
                    lnValPesos = CsRelatorio.Saldops - ;
                        IIF(EMPTY(CsRelatorio.ReLidops), CsRelatorio.Lidops, CsRelatorio.ReLidops)

                    SET DECIMALS TO 3

                    m.TcLinhas = PADR(PADR(CsRelatorio.CPros, 14) + " " + ;
                        IIF(THIS.this_nOptFoto = 1, PADR(CsRelatorio.DPros, 25) + " ", "") + ;
                        CsRelatorio.CodCors + "/" + CsRelatorio.CodTams + " " + ;
                        TRANSFORM(IIF(EMPTY(CsRelatorio.ReLidos), CsRelatorio.Lidos, ;
                            CsRelatorio.ReLidos), "999999.999") + " " + ;
                        TRANSFORM(CsRelatorio.Saldos, "9999999.999") + " " + ;
                        TRANSFORM(IIF(lnValor < 0, ABS(lnValor), 0), "@Z 999999.999") + " " + ;
                        TRANSFORM(IIF(lnValor > 0, ABS(lnValor), 0), "@Z 999999.999") + " " + ;
                        IIF(llMostraCtg, PADR(CsRelatorio.Categoria, 30) + " ", "") + ;
                        IIF(llMostraCol, PADR(CsRelatorio.Colecoes, 20) + " ", "") + ;
                        IIF(CsRelatorio.TpCustos = 1, ;
                            TRANSFORM(CsRelatorio.CustoFs, "99999999.99") + " ", "") + ;
                        IIF(CsRelatorio.TpCustos = 1, PADR(CsRelatorio.MoeCusFs, 3), "") + ;
                        IIF(CsRelatorio.TpVendas = 1, ;
                            TRANSFORM(CsRelatorio.PVens, "99999999.99") + " ", "") + ;
                        IIF(CsRelatorio.TpVendas = 1, PADR(CsRelatorio.MoeVs, 3), "") + ;
                        IIF(CsRelatorio.TpVendas = 1, ;
                            TRANSFORM(CsRelatorio.FVendas, "@Z 99999999.99") + " ", "") + ;
                        IIF(CsRelatorio.TpVendas = 1, PADR(CsRelatorio.MoePVs, 3), "") + ;
                        IIF(THIS.this_lTrataPeso, ;
                            TRANSFORM(IIF(EMPTY(CsRelatorio.ReLidops), CsRelatorio.Lidops, ;
                                CsRelatorio.ReLidops), " 9999.999") + " " + ;
                            TRANSFORM(CsRelatorio.Saldops, " 9999.999") + " " + ;
                            TRANSFORM(IIF(lnValPesos < 0, ABS(lnValPesos), 0), "@Z   9999.999") + " " + ;
                            TRANSFORM(IIF(lnValPesos > 0, ABS(lnValPesos), 0), "@Z   9999.999"), "") + ;
                        " " + ALLTRIM(CsRelatorio.Obs), 220)

                    GATHER MEMVAR FIELDS TcCabecs, TcTraco1s, TcLinhas

                    IF LEN(ALLTRIM(m.TcCabecs)) > 120
                        THIS.this_lHorizontal = .T.
                    ENDIF
                    IF !EMPTY(ALLTRIM(CsRelatorio.Obs))
                        THIS.this_lHorizontal = .T.
                    ENDIF

                    SET DECIMALS TO 2
                ENDSCAN

                *-- Etiquetas sem foto
                IF THIS.this_nOptFoto <> 1 AND THIS.this_nOptEtiq = 1
                    SELECT CsRelatorio
                    lnRegs = RECCOUNT()
                    lnRega = 1
                    GO TOP
                    DO WHILE lnRegs >= lnRega
                        lcpros_val = CsRelatorio.cPros
                        IF (IIF(EMPTY(CsRelatorio.ReLidos), CsRelatorio.Lidos, CsRelatorio.ReLidos) > ;
                            CsRelatorio.Saldos) OR ;
                            (IIF(EMPTY(CsRelatorio.ReLidops), CsRelatorio.Lidops, CsRelatorio.ReLidops) > ;
                            CsRelatorio.Saldops)
                            lcSql = [Select cBars from SigIvTrH Where cPros = '] + lcpros_val + ;
                                [' And Codigos = ] + STR(lnNumBal) + ;
                                [ And not cBars in (Select cBars from SigIvTre Where cPros = '] + ;
                                lcpros_val + [' And Codigos = ] + STR(lnNumBal) + [)]
                        ELSE
                            lcSql = [Select cBars from SigIvTrE Where cPros = '] + lcpros_val + ;
                                [' And Codigos = ] + STR(lnNumBal) + ;
                                [ And not cBars in (Select cBars from SigIvTrH Where cPros = '] + ;
                                lcpros_val + [' And Codigos = ] + STR(lnNumBal) + [)]
                        ENDIF
                        SQLEXEC(gnConnHandle, lcSql, "crBarras")
                        SELECT crBarras
                        GO TOP
                        IF !EOF()
                            SELECT CsRelatorio
                            SCATTER MEMVAR
                            m.TcLinhas = ""
                            SELECT crBarras
                            SCAN
                                lcBarra = ALLTRIM(STR(crBarras.cBars, 14)) + ", "
                                IF LEN(m.TcLinhas) + LEN(lcBarra) > 114
                                    SELECT CsRelatorio
                                    APPEND BLANK
                                    GATHER MEMVAR
                                    m.TcLinhas = ""
                                ENDIF
                                m.TcLinhas = m.TcLinhas + lcBarra
                                SELECT crBarras
                            ENDSCAN
                            SELECT CsRelatorio
                            APPEND BLANK
                            GATHER MEMVAR
                        ENDIF
                        SELECT CsRelatorio
                        GO lnRega
                        SKIP
                        lnRega = lnRega + 1
                    ENDDO
                ENDIF

                *-- Totais consolidados por moeda
                SELECT CrSMoeda
                GO TOP
                SELECT Moedas, SUM(CustoFs) AS CustoFs, SUM(PVens) AS PVens, ;
                    SUM(PVenPesos) AS PVenPesos ;
                FROM crSMoeda ;
                GROUP BY Moedas ;
                INTO CURSOR TmpMoeda READWRITE

                SELECT TmpMoeda
                GO TOP
                SCAN
                    SCATTER MEMVAR
                    INSERT INTO CsRelatorio (TcCabecs, TcTraco1s, TcLinhas, Ps) ;
                        VALUES (PADC(PADC("Moeda", 5) + " " + ;
                            IIF(lnTpCusto = 1, PADC("Pre" + CHR(231) + "o de Custo", 17) + " ", "") + ;
                            IIF(lnTpVenda = 1, PADC("Pre" + CHR(231) + "o Venda", 17) + " ", ""), 115), ;
                            PADC(REPLICATE("_", 5) + " " + ;
                            IIF(lnTpCusto = 1, REPLICATE("_", 17) + " ", "") + ;
                            IIF(lnTpVenda = 1, REPLICATE("_", 17) + " ", ""), 115), ;
                            PADC(PADR(m.Moedas, 6) + ;
                            IIF(lnTpCusto = 1, TRANSFORM(m.CustoFs, "99,999,999,999.99") + " ", "") + ;
                            IIF(lnTpVenda = 1, TRANSFORM(m.PVens, "99,999,999,999.99") + " ", ""), 115), ;
                            "2")
                    SELECT TmpMoeda
                ENDSCAN

                SET ESCAPE &lcEscape.
                SET TALK &lcTalk.
                SET DECIMALS TO lnDecimals
                SET FIXED &lcFixed.

                WAIT CLEAR

            *==================================================================
            CASE THIS.this_nTipoRel = 2

                WAIT WINDOW "Aguarde! Verificando Saldo..." NOWAIT
                THIS.this_nSaldo   = 0
                THIS.this_nSaldoPs = 0

                lcpros_val = THIS.this_cProduto
                loc_cSQL = [Select Emps,Codigos,CPros,Saldos,SaldoPs From SigIvTrB ] + ;
                    [Where Emps = ?lcEmpr And Codigos = ?lnNumBal And CPros = ?lcpros_val ] + ;
                    [Order By CIdChaves ]
                IF SQLEXEC(gnConnHandle, loc_cSQL, "Saldo") < 1
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + CHR(227) + "o (Saldo)"
                    loc_lSucesso = .F.
                ENDIF
                SELECT Saldo
                GO TOP
                IF !EOF()
                    THIS.this_nSaldo   = Saldo.Saldos
                    THIS.this_nSaldoPs = Saldo.SaldoPs
                ENDIF

                WAIT WINDOW "Aguarde! Selecionando Hist" + CHR(243) + "ricos..." NOWAIT

                lnTipoL1   = THIS.this_nTipoLeitura
                lnTipoL3   = THIS.this_nTipoLeitura + 2
                lcpros_val = THIS.this_cProduto
                lclocal_val = THIS.this_cLocal
                lnbarra_val = THIS.this_nBarra

                loc_cSQL = [Select * From SigIvTrH ] + ;
                    [Where Emps = ?lcEmpr And Codigos = ?lnNumBal ]

                DO CASE
                    CASE THIS.this_nTipoAnal = 1
                        loc_cSQL = loc_cSQL + [And CPros = ?lcpros_val ]
                    CASE THIS.this_nTipoAnal = 2
                        loc_cSQL = loc_cSQL + [And Localis = ?lclocal_val ]
                    OTHERWISE
                        loc_cSQL = loc_cSQL + [And CBars = ] + ALLTRIM(STR(lnbarra_val, 14))
                ENDCASE

                loc_cSQL = loc_cSQL + [And (Tipos = ?lnTipoL1 Or Tipos = ?lnTipoL3) ] + ;
                    [Order By Tipos,CPros,CodCors,CodTams,Contas,Datas,CIdChaves ]

                IF SQLEXEC(gnConnHandle, loc_cSQL, "CsRelatorio") < 1
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + CHR(227) + "o (CsRelatorio)"
                    loc_lSucesso = .F.
                ENDIF
                SELECT CsRelatorio
                INDEX ON CBars TAG CBars
                GO TOP

                THIS.this_cTitulo = "Relat" + CHR(243) + "rio Anal" + CHR(237) + "tico do Invent" + ;
                    CHR(225) + "rio n" + CHR(186) + " " + ALLTRIM(STR(lnNumBal)) + " - " + ;
                    IIF(THIS.this_nTipoDif = 1, "Todos", "Com Diferen" + CHR(231) + "a")

                WAIT CLEAR

            *==================================================================
            CASE INLIST(THIS.this_nTipoRel, 3, 5, 8)

                WAIT WINDOW "Aguarde! Selecionando Etiquetas..." NOWAIT

                loc_cSQL = [Select a.*, IsNull(b.cbars_old,0) as cbars_old, c.localizas, Space(200) as Obs ] + ;
                    [From SigIvTrE a ] + ;
                    [left join SigOpEta b on a.cbars = b.cbars_new ] + ;
                    [left join SigOpEtq c on a.cbars = c.cbars ] + ;
                    [Where a.Emps = ?lcEmpr And a.Codigos = ?lnNumBal ] + ;
                    [Order By a.CPros,a.CBars,a.CIdChaves ]

                IF SQLEXEC(gnConnHandle, loc_cSQL, "CsEtiqueta") < 1
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + CHR(227) + "o (CsEtiqueta)"
                    loc_lSucesso = .F.
                ENDIF
                SELECT CsEtiqueta
                INDEX ON CBars TAG CBars
                GO TOP

                WAIT WINDOW "Aguarde! Selecionando Hist" + CHR(243) + "ricos..." NOWAIT

                loc_cSQL = [Select a.*, IsNull(b.cbars_old,0) as cbars_old, c.localizas ] + ;
                    [From SigIvTrH a ] + ;
                    [left join SigOpEta b on a.cbars = b.cbars_new ] + ;
                    [left join SigOpEtq c on a.cbars = c.cbars ] + ;
                    [Where a.Emps = ?lcEmpr And a.Codigos = ?lnNumBal ] + ;
                    [Order By a.CIdChaves ]

                IF SQLEXEC(gnConnHandle, loc_cSQL, "CsHistorico") < 1
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + CHR(227) + "o (CsHistorico)"
                    loc_lSucesso = .F.
                ENDIF
                SELECT CsHistorico
                INDEX ON CBars TAG CBars
                GO TOP

                CREATE CURSOR CsRelatorio (Emps c(3), Grupos c(10), Contas c(10), CBars n(14), ;
                    CPros c(14), Tipos c(20), Datas D, DPros c(70), Reffs c(40), ;
                    Colecoes c(50), Categoria c(50), pLocals c(10), cbars_old n(10), ;
                    CodTams c(3), Localizas c(10), Obs c(200))
                INDEX ON CBars TAG CBars
                INDEX ON Tipos + Contas + CPros + STR(CBars, 14) TAG TpProBar

                THIS.this_nTotalLido = 0
                THIS.this_nTotalEsto = 0

                WAIT CLEAR
                WAIT WINDOW "Verificando Etiquetas..." NOWAIT

                SELECT CsEtiqueta
                GO TOP
                SCAN
                    IF CsEtiqueta.CBars <> 0 AND !SEEK(CsEtiqueta.CBars, "CsHistorico", "CBars")
                        IF USED("TmpPro")
                            USE IN TmpPro
                        ENDIF
                        lcpros_val = CsEtiqueta.CPros
                        loc_cSQL = [Select a.CPros,a.DPros,a.Reffs,] + ;
                            [ltrim(rtrim(a.Colecoes))+'-'+ltrim(rtrim(b.descs)) as Colecoes, ] + ;
                            [ltrim(rtrim(a.Categoria))+'-' +ltrim(rtrim(c.descs)) as Categoria ] + ;
                            [From SigCdPro a ] + ;
                            [Join SigCdCol b on a.Colecoes = b.colecoes ] + ;
                            [Join SigCdCtg c on a.categoria = c.cods ] + ;
                            [Where CPros = ?lcpros_val ]
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpPro") < 1
                            THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + CHR(227) + "o (TmpPro)"
                            loc_lSucesso = .F.
                        ENDIF
                        SELECT TmpPro
                        GO TOP
                        INSERT INTO CsRelatorio (Emps, Grupos, Contas, CBars, CPros, Tipos, ;
                            Datas, DPros, Reffs, Categoria, Colecoes, pLocals, cbars_old, ;
                            CodTams, Localizas, Obs) ;
                            VALUES (CsEtiqueta.Emps, CsEtiqueta.Grupos, CsEtiqueta.Contas, ;
                                CsEtiqueta.CBars, CsEtiqueta.CPros, ;
                                "N" + CHR(227) + "o Lido", ;
                                NVL(CsEtiqueta.Datas, {}), TmpPro.DPros, TmpPro.Reffs, ;
                                TmpPro.Categoria, TmpPro.Colecoes, CsEtiqueta.Locals, ;
                                CsEtiqueta.cbars_old, CsEtiqueta.CodTams, ;
                                NVL(CsEtiqueta.localizas, ""), CsEtiqueta.Obs)
                        THIS.this_nTotalLido = THIS.this_nTotalLido + 1
                    ENDIF
                    SELECT CsEtiqueta
                ENDSCAN

                IF THIS.this_nTipoRel = 8
                    WAIT WINDOW "Verificando Hist" + CHR(243) + "ricos..." NOWAIT
                    SELECT CsHistorico
                    GO TOP
                    SCAN
                        IF CsHistorico.CBars <> 0 AND !SEEK(CsHistorico.CBars, "CsEtiqueta", "CBars") AND ;
                            !SEEK(CsHistorico.CBars, "CsRelatorio", "CBars")

                            lnbarra_val = CsHistorico.CBars
                            loc_cSQL = [Select Empos,Grupos,Contas From SigOpEtq Where Cbars = ] + ;
                                STR(CsHistorico.CBars, 14)
                            IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpProEtq") < 1
                                THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + CHR(227) + "o (TmpProEtq)"
                                loc_lSucesso = .F.
                            ENDIF
                            SELECT TmpProEtq
                            GO TOP

                            lcpros_val = CsHistorico.CPros
                            loc_cSQL = [Select a.CPros,a.DPros,a.Reffs,] + ;
                                [ltrim(rtrim(a.Colecoes))+'-'+ltrim(rtrim(b.descs)) as Colecoes, ] + ;
                                [ltrim(rtrim(a.Categoria))+'-' +ltrim(rtrim(c.descs)) as Categoria ] + ;
                                [From SigCdPro a ] + ;
                                [Join SigCdCol b on a.Colecoes = b.colecoes ] + ;
                                [Join SigCdCtg c on a.categoria = c.cods ] + ;
                                [Where CPros = ?lcpros_val ]
                            IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpPro") < 1
                                THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + CHR(227) + "o (TmpPro)"
                                loc_lSucesso = .F.
                            ENDIF
                            SELECT TmpPro
                            GO TOP

                            INSERT INTO CsRelatorio (Emps, Grupos, Contas, CBars, CPros, Tipos, ;
                                Reffs, Categoria, Colecoes, pLocals, cbars_old, CodTams, Localizas) ;
                                VALUES (TmpProEtq.Empos, TmpProEtq.Grupos, TmpProEtq.Contas, ;
                                    CsHistorico.CBars, CsHistorico.CPros, ;
                                    "N" + CHR(227) + "o est" + CHR(225) + " no Estoque", ;
                                    TmpPro.Reffs, TmpPro.Categoria, TmpPro.Colecoes, ;
                                    CsHistorico.Locals, CsHistorico.cbars_old, ;
                                    CsHistorico.CodTams, NVL(CsHistorico.localizas, ""))
                            THIS.this_nTotalEsto = THIS.this_nTotalEsto + 1
                        ENDIF
                        SELECT CsHistorico
                    ENDSCAN
                ENDIF

                THIS.this_cTitulo = "Relat" + CHR(243) + "rio de C" + CHR(243) + "digos de Barras do Invent" + ;
                    CHR(225) + "rio n" + CHR(186) + " " + ALLTRIM(STR(lnNumBal)) + " - " + ;
                    IIF(THIS.this_nTipoDif = 1, "Todos", "Com Diferen" + CHR(231) + "a")

            *==================================================================
            CASE THIS.this_nTipoRel = 4

                WAIT WINDOW "Aguarde! Selecionando Hist" + CHR(243) + "ricos..." NOWAIT

                loc_cSQL = [Select * From SigIvTrH ] + ;
                    [Where Emps = ?lcEmpr And Codigos = ?lnNumBal Order By CIdChaves ]
                IF SQLEXEC(gnConnHandle, loc_cSQL, "CsHistorico") < 1
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + CHR(227) + "o (CsHistorico)"
                    loc_lSucesso = .F.
                ENDIF
                SELECT CsHistorico
                INDEX ON CBars TAG CBars
                GO TOP

                SELECT CsOperacaos
                GO TOP

                WAIT WINDOW "Aguarde! Selecionando Tratamentos..." NOWAIT

                loc_cSQL = [Select * From SigIvTrT Where Emps = ?lcEmpr And Codigos = ?lnNumBal Order By CIdChaves ]
                IF SQLEXEC(gnConnHandle, loc_cSQL, "CsTratam") < 1
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + CHR(227) + "o (CsTratam)"
                    loc_lSucesso = .F.
                ENDIF
                SELECT CsTratam
                GO TOP

                IF EOF()
                    SELECT a.* FROM CsHistorico a, CsOperacaos b ;
                        WHERE "O" + a.Ocors = "O" + b.Codigos AND b.Marcas = 1 ;
                        INTO CURSOR Selecao
                ELSE
                    SELECT a.Barras AS CBars, a.Ocorrencia AS Ocors, a.Obs, ;
                        a.PesReals, Space(10) AS Localis ;
                        FROM CsTratam a, CsOperacaos b ;
                        WHERE "O" + a.Ocorrencia = "O" + b.Codigos AND b.Marcas = 1 ;
                        INTO CURSOR Selecao
                ENDIF

                CREATE CURSOR CsRelatorio (CBars n(14), Ocors c(10), Obs m NULL, ;
                    PesReals n(9, 2), Localis c(10), Reffs c(40), ;
                    Categoria c(50), Colecoes c(50))
                INDEX ON Ocors + STR(CBars) TAG CBars

                WAIT CLEAR
                WAIT WINDOW "Verificando Ocorr" + CHR(234) + "ncias..." NOWAIT

                SELECT Selecao
                GO TOP
                SCAN
                    SCATTER MEMVAR MEMO
                    INSERT INTO CsRelatorio FROM MEMVAR
                    IF EMPTY(m.Localis)
                        = SEEK(Selecao.CBars, "CsHistorico", "CBars")
                        REPLACE CsRelatorio.Localis WITH CsHistorico.Localis
                    ENDIF
                    SELECT Selecao
                ENDSCAN
                WAIT CLEAR

                THIS.this_cTitulo = "Relat" + CHR(243) + "rio de Ocorr" + CHR(234) + "ncias do Invent" + ;
                    CHR(225) + "rio n" + CHR(186) + " " + ALLTRIM(STR(lnNumBal)) + " - " + ;
                    IIF(THIS.this_nTipoDif = 1, "Todos", "Com Diferen" + CHR(231) + "a")

            *==================================================================
            CASE THIS.this_nTipoRel = 6

                WAIT WINDOW "Aguarde! Selecionando Barras..." NOWAIT

                lcSql = [Select a.emps,a.cpros,a.cbars,a.codcors,b.cproeqs,b.dpros,b.pesometal, ] + ;
                    [b.pvens,c.cgrus,c.dcompos,c.qtds, b.tComps as primeiro, b.tcomps as Ultimo, b.Reffs, a.Pesos, ] + ;
                    [ltrim(rtrim(b.Colecoes))+'-'+ltrim(rtrim(d.descs)) as Colecoes,] + ;
                    [ltrim(rtrim(b.Categoria))+'-' +ltrim(rtrim(e.descs)) as Categoria ] + ;
                    [From SigIvTrE a ] + ;
                    [left Join SigCdPro b on a.cpros = b.cpros ] + ;
                    [left Join SigPrCpo c on a.cpros = c.cpros ] + ;
                    [left Join SigCdCol d on b.Colecoes = d.colecoes ] + ;
                    [left Join sigcdctg e on b.categoria = e.cods ] + ;
                    [Where a.Emps = '] + lcEmpr + [' And a.Codigos = ] + STR(lnNumBal) + [ ] + ;
                    [Order By a.cpros,a.cbars,c.cgrus ]

                IF SQLEXEC(gnConnHandle, lcSql, "cursor_4c_Barra6Tmp") < 1
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + CHR(227) + "o (CsRelatorio Tipo6)"
                    loc_lSucesso = .F.
                ENDIF
                SELECT * FROM cursor_4c_Barra6Tmp INTO CURSOR CsRelatorio READWRITE
                USE IN cursor_4c_Barra6Tmp

                SELECT CsRelatorio
                INDEX ON Cpros + STR(CBars) + cGrus TAG Produto
                UPDATE CsRelatorio SET Primeiro = .F., Ultimo = .F., ;
                    cgrus = NVL(cgrus, " "), ;
                    Dcompos = NVL(dCompos, " "), ;
                    Qtds = NVL(Qtds, 0)

                SCAN
                    lcpro_prev   = cpros
                    lnBarra_prev = CBars
                    REPLACE Primeiro WITH .T.
                    SCAN WHILE Cpros = lcpro_prev AND CBars = lnBarra_prev
                    ENDSCAN
                    SKIP -1
                    REPLACE Ultimo WITH .T.
                ENDSCAN
                GO TOP

                WAIT CLEAR

                THIS.this_cTitulo = "Relat" + CHR(243) + "rio C/Barra do Invent" + CHR(225) + ;
                    "rio n" + CHR(186) + " " + ALLTRIM(STR(lnNumBal))

            *==================================================================
            CASE THIS.this_nTipoRel = 7

                THIS.this_cTitulo = "Relat" + CHR(243) + "rio de Estoque x Leitura do Invent" + ;
                    CHR(225) + "rio n" + CHR(186) + " " + ALLTRIM(STR(lnNumBal))

                lcSql = [Select 'N] + CHR(227) + [o Lido - Falta   ' as Ps, d.Mercs, d.CGrus, ] + ;
                    [e.CPros, e.CBars, e.CodCors, e.CodTams, d.Dpros, ] + ;
                    [d.CustoFs * e.Qtds as Custos, d.MoeCusFs, e.Qtds, d.FigJpgs, Space(11) AS OrdImg ] + ;
                    [From SigIvTre e ] + ;
                    [Left Join SigCdPro d On e.CPros = d.CPros ] + ;
                    [Where (e.CBars <> 0 And e.CBars Not In ] + ;
                    [       (Select h1.CBars From SigIvTrh h1 Where h1.CBars <> 0)) Or ] + ;
                    [      (e.CBars = 0 And e.CPros Not In ] + ;
                    [       (Select h1.CPros From SigIvTrh h1 Where h1.CBars = 0)) ] + ;
                    [Union All ] + ;
                    [Select 'Sem Estoque - Sobra' as Ps, d.Mercs, d.CGrus, ] + ;
                    [e.CPros, e.CBars, e.CodCors, e.CodTams, d.Dpros, ] + ;
                    [d.CustoFs * e.Qtds as Custos, d.MoeCusFs, e.Qtds, d.FigJpgs, Space(11) AS OrdImg ] + ;
                    [From SigIvTrh e ] + ;
                    [Left Join SigCdPro d On e.CPros = d.CPros ] + ;
                    [Where (e.CBars <> 0 And e.CBars Not In ] + ;
                    [       (Select h1.CBars From SigIvTre h1 Where h1.CBars <> 0)) Or ] + ;
                    [      (e.CBars = 0 And e.CPros Not In ] + ;
                    [       (Select h1.CPros From SigIvTre h1 Where h1.CBars = 0)) ] + ;
                    [Order By 1, 2, 3, 4, 5]

                IF SQLEXEC(gnConnHandle, lcSql, "cursor_4c_Rel7Tmp") < 1
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + CHR(227) + "o (CsRelatorio Tipo7)"
                    loc_lSucesso = .F.
                ENDIF
                SELECT * FROM cursor_4c_Rel7Tmp INTO CURSOR CsRelatorio READWRITE
                USE IN cursor_4c_Rel7Tmp

                SELECT CsRelatorio
                SCAN
                    IF EMPTY(CsRelatorio.FigJpgs)
                        REPLACE OrdImg WITH "FBRANCOS" IN CsRelatorio
                    ELSE
                        lcpro = STRTRAN(STRTRAN(ALLTRIM(CsRelatorio.CPros), "/", ""), " ", "")
                        lcDirectory = SYS(2023) + "\F" + ALLTRIM(lcpro) + ".Jpg"
                        REPLACE OrdImg WITH "F" + ALLTRIM(lcpro) IN CsRelatorio
                        lcFoto = STRTRAN(STRTRAN(STRTRAN(CsRelatorio.FigJpgs, ;
                            "data:image/png;base64,", ""), ;
                            "data:image/jpeg;base64,", ""), ;
                            "data:image/jpg;base64,", "")
                        STRTOFILE(STRCONV(lcFoto, 14), lcDirectory)
                    ENDIF
                ENDSCAN

            ENDCASE

            *-- Libera cursores intermediarios
            IF USED("Base")
                USE IN Base
            ENDIF
            IF USED("Saldo")
                USE IN Saldo
            ENDIF
            IF USED("CsEtiqueta")
                USE IN CsEtiqueta
            ENDIF
            IF USED("CsHistorico")
                USE IN CsHistorico
            ENDIF
            IF USED("CsTratam")
                USE IN CsTratam
            ENDIF
            IF USED("Selecao")
                USE IN Selecao
            ENDIF
            IF USED("crTmpHist")
                USE IN crTmpHist
            ENDIF

            *-- Ordenacao final do cursor de saida
            IF USED("CsRelatorio")
                SELECT CsRelatorio
                DO CASE
                    CASE THIS.this_nTipoRel = 1
                        SET ORDER TO Chave1 IN CsRelatorio
                    CASE THIS.this_nTipoRel = 5
                        SET ORDER TO CBars IN CsRelatorio
                    CASE THIS.this_nTipoRel = 7
                        *-- ordem definida no SELECT
                    OTHERWISE
                        SET ORDER TO ORDER("CsRelatorio")
                ENDCASE
                GO TOP
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe relatorio em preview (equivalente a PROCEDURE visualizacao)
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro, lcApagar
        loc_lSucesso = .F.

        IF !USED("CsRelatorio")
            THIS.this_cMensagemErro = "Execute PrepararDados() antes de Visualizar()"
            RETURN .F.
        ENDIF

        TRY
            PUBLIC _TipoDif_INV, _lTrataPeso_INV
            _TipoDif_INV    = THIS.this_nTipoDif
            _lTrataPeso_INV = THIS.this_lTrataPeso

            SELECT CsRelatorio
            GO TOP

            DO CASE
                CASE THIS.this_nTipoRel = 1
                    IF THIS.this_nOptFoto = 1
                        REPORT FORM SigReBrf PREVIEW NOCONSOLE ;
                            FOR IIF(_TipoDif_INV = 1 OR ps == "2", .T., ;
                                IIF(!_lTrataPeso_INV, ;
                                    (Saldos # IIF(EMPTY(ReLidos), Lidos, ReLidos)), ;
                                    ((Saldos # IIF(EMPTY(ReLidos), Lidos, ReLidos)) OR ;
                                    (Saldops # IIF(EMPTY(ReLidops), Lidops, ReLidops)))))
                    ELSE
                        IF THIS.this_lHorizontal
                            REPORT FORM SigReBlh PREVIEW NOCONSOLE ;
                                FOR IIF(_TipoDif_INV = 1 OR ps == "2", .T., ;
                                    IIF(!_lTrataPeso_INV, ;
                                        (Saldos # IIF(EMPTY(ReLidos), Lidos, ReLidos)), ;
                                        ((Saldos # IIF(EMPTY(ReLidos), Lidos, ReLidos)) OR ;
                                        (Saldops # IIF(EMPTY(ReLidops), Lidops, ReLidops)))))
                        ELSE
                            REPORT FORM SigReBlr PREVIEW NOCONSOLE ;
                                FOR IIF(_TipoDif_INV = 1 OR ps == "2", .T., ;
                                    IIF(!_lTrataPeso_INV, ;
                                        (Saldos # IIF(EMPTY(ReLidos), Lidos, ReLidos)), ;
                                        ((Saldos # IIF(EMPTY(ReLidos), Lidos, ReLidos)) OR ;
                                        (Saldops # IIF(EMPTY(ReLidops), Lidops, ReLidops)))))
                        ENDIF
                    ENDIF

                CASE THIS.this_nTipoRel = 2
                    REPORT FORM SigReBla PREVIEW NOCONSOLE

                CASE THIS.this_nTipoRel = 3
                    IF THIS.this_lBalcTrats
                        REPORT FORM SigReBe2 PREVIEW NOCONSOLE
                    ELSE
                        REPORT FORM SigReBle PREVIEW NOCONSOLE
                    ENDIF

                CASE THIS.this_nTipoRel = 4
                    REPORT FORM SigReBlo PREVIEW NOCONSOLE

                CASE THIS.this_nTipoRel = 5
                    DO FORM SigOpEtq WITH THIS

                CASE THIS.this_nTipoRel = 6
                    REPORT FORM SigReBlb PREVIEW NOCONSOLE

                CASE THIS.this_nTipoRel = 7
                    REPORT FORM SigReBel PREVIEW NOCONSOLE

                CASE THIS.this_nTipoRel = 8
                    REPORT FORM SigReBl3 PREVIEW NOCONSOLE
            ENDCASE

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        IF USED("CsRelatorio")
            USE IN CsRelatorio
        ENDIF
        lcApagar = SYS(2023) + "\F*.Jpg"
        ERASE &lcApagar.
        RELEASE _TipoDif_INV, _lTrataPeso_INV

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime relatorio
    * par_lComPrompt: .T.=abre dialogo de impressora, .F.=imprime silencioso
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir(par_lComPrompt)
        LOCAL loc_lSucesso, loc_oErro, lcApagar
        loc_lSucesso = .F.

        IF !USED("CsRelatorio")
            THIS.this_cMensagemErro = "Execute PrepararDados() antes de Imprimir()"
            RETURN .F.
        ENDIF

        TRY
            PUBLIC _TipoDif_INV, _lTrataPeso_INV
            _TipoDif_INV    = THIS.this_nTipoDif
            _lTrataPeso_INV = THIS.this_lTrataPeso

            SELECT CsRelatorio
            GO TOP

            DO CASE
                CASE THIS.this_nTipoRel = 1
                    IF THIS.this_nOptFoto = 1
                        IF par_lComPrompt
                            REPORT FORM SigReBrf TO PRINTER PROMPT NOCONSOLE ;
                                FOR IIF(_TipoDif_INV = 1 OR ps == "2", .T., ;
                                    ((Saldos # IIF(EMPTY(ReLidos), Lidos, ReLidos)) OR ;
                                    (Saldops # IIF(EMPTY(ReLidops), Lidops, ReLidops))))
                        ELSE
                            REPORT FORM SigReBrf TO PRINTER NOCONSOLE ;
                                FOR IIF(_TipoDif_INV = 1 OR ps == "2", .T., ;
                                    ((Saldos # IIF(EMPTY(ReLidos), Lidos, ReLidos)) OR ;
                                    (Saldops # IIF(EMPTY(ReLidops), Lidops, ReLidops))))
                        ENDIF
                    ELSE
                        IF THIS.this_lHorizontal
                            IF par_lComPrompt
                                REPORT FORM SigReBlh TO PRINTER PROMPT NOCONSOLE ;
                                    FOR IIF(_TipoDif_INV = 1 OR ps == "2", .T., ;
                                        ((Saldos # IIF(EMPTY(ReLidos), Lidos, ReLidos)) OR ;
                                        (Saldops # IIF(EMPTY(ReLidops), Lidops, ReLidops))))
                            ELSE
                                REPORT FORM SigReBlh TO PRINTER NOCONSOLE ;
                                    FOR IIF(_TipoDif_INV = 1 OR ps == "2", .T., ;
                                        ((Saldos # IIF(EMPTY(ReLidos), Lidos, ReLidos)) OR ;
                                        (Saldops # IIF(EMPTY(ReLidops), Lidops, ReLidops))))
                            ENDIF
                        ELSE
                            IF par_lComPrompt
                                REPORT FORM SigReBlr TO PRINTER PROMPT NOCONSOLE ;
                                    FOR IIF(_TipoDif_INV = 1 OR ps == "2", .T., ;
                                        ((Saldos # IIF(EMPTY(ReLidos), Lidos, ReLidos)) OR ;
                                        (Saldops # IIF(EMPTY(ReLidops), Lidops, ReLidops))))
                            ELSE
                                REPORT FORM SigReBlr TO PRINTER NOCONSOLE ;
                                    FOR IIF(_TipoDif_INV = 1 OR ps == "2", .T., ;
                                        ((Saldos # IIF(EMPTY(ReLidos), Lidos, ReLidos)) OR ;
                                        (Saldops # IIF(EMPTY(ReLidops), Lidops, ReLidops))))
                            ENDIF
                        ENDIF
                    ENDIF

                CASE THIS.this_nTipoRel = 2
                    IF par_lComPrompt
                        REPORT FORM SigReBla TO PRINTER PROMPT NOCONSOLE
                    ELSE
                        REPORT FORM SigReBla TO PRINTER NOCONSOLE
                    ENDIF

                CASE THIS.this_nTipoRel = 3
                    IF THIS.this_lBalcTrats
                        IF par_lComPrompt
                            REPORT FORM SigReBe2 TO PRINTER PROMPT NOCONSOLE
                        ELSE
                            REPORT FORM SigReBe2 TO PRINTER NOCONSOLE
                        ENDIF
                    ELSE
                        IF par_lComPrompt
                            REPORT FORM SigReBle TO PRINTER PROMPT NOCONSOLE
                        ELSE
                            REPORT FORM SigReBle TO PRINTER NOCONSOLE
                        ENDIF
                    ENDIF

                CASE THIS.this_nTipoRel = 4
                    IF par_lComPrompt
                        REPORT FORM SigReBlo TO PRINTER PROMPT NOCONSOLE
                    ELSE
                        REPORT FORM SigReBlo TO PRINTER NOCONSOLE
                    ENDIF

                CASE THIS.this_nTipoRel = 5
                    DO FORM SigOpEtq WITH THIS

                CASE THIS.this_nTipoRel = 6
                    IF par_lComPrompt
                        REPORT FORM SigReBlb TO PRINTER PROMPT NOCONSOLE
                    ELSE
                        REPORT FORM SigReBlb TO PRINTER NOCONSOLE
                    ENDIF

                CASE THIS.this_nTipoRel = 7
                    IF par_lComPrompt
                        REPORT FORM SigReBel TO PRINTER PROMPT NOCONSOLE
                    ELSE
                        REPORT FORM SigReBel TO PRINTER NOCONSOLE
                    ENDIF

                CASE THIS.this_nTipoRel = 8
                    IF par_lComPrompt
                        REPORT FORM SigReBl3 TO PRINTER PROMPT NOCONSOLE
                    ELSE
                        REPORT FORM SigReBl3 TO PRINTER NOCONSOLE
                    ENDIF
            ENDCASE

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        IF USED("CsRelatorio")
            USE IN CsRelatorio
        ENDIF
        lcApagar = SYS(2023) + "\F*.Jpg"
        ERASE &lcApagar.
        RELEASE _TipoDif_INV, _lTrataPeso_INV

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida campos obrigatorios antes de processar
    * Retorna .T. se valido, .F. com mensagem se invalido
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFiltros()
        IF THIS.this_nTipoRel = 2
            DO CASE
                CASE THIS.this_nTipoAnal = 1 AND EMPTY(THIS.this_cProduto)
                    THIS.this_cMensagemErro = "Produto Inv" + CHR(225) + "lido !!!"
                    RETURN .F.
                CASE THIS.this_nTipoAnal = 2 AND EMPTY(THIS.this_cLocal)
                    THIS.this_cMensagemErro = "Local Inv" + CHR(225) + "lido !!!"
                    RETURN .F.
            ENDCASE
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Nao aplicavel para relatorio
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem do ultimo erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("CsRelatorio")
            USE IN CsRelatorio
        ENDIF
        IF USED("CsFiltro")
            USE IN CsFiltro
        ENDIF
        IF USED("CsSigCdBal")
            USE IN CsSigCdBal
        ENDIF
        IF USED("CsSigCdPam")
            USE IN CsSigCdPam
        ENDIF
        IF USED("CrSigCdEmp")
            USE IN CrSigCdEmp
        ENDIF
        IF USED("CrSigCdGcr")
            USE IN CrSigCdGcr
        ENDIF
        IF USED("CsOperacaos")
            USE IN CsOperacaos
        ENDIF
        IF USED("CrSMoeda")
            USE IN CrSMoeda
        ENDIF
        IF USED("CsBase")
            USE IN CsBase
        ENDIF
        IF USED("TmpMoeda")
            USE IN TmpMoeda
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

