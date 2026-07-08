# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'BtnIncluirNavegacao': BtnIncluirClick nao navegou para Page2 (ActivePage=1)

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-05-17 13:40:12] [INFO] === VFP EXECUTOR v2.0 ===
[2026-05-17 13:40:12] [INFO] Config FPW: (nao fornecido)
[2026-05-17 13:40:12] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-05-17 13:40:12] [INFO] Timeout: 300 segundos
[2026-05-17 13:40:12] [INFO] Wrapper PRG criado para parametros: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_zphdrtmi.prg
[2026-05-17 13:40:12] [INFO] Conteudo do wrapper:
[2026-05-17 13:40:12] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSIGRECND', 'C:\4c\tasks\task057', 'REPORT'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGRECND', 'C:\4c\tasks\task057', 'REPORT'
QUIT

[2026-05-17 13:40:12] [INFO] Comando VFP: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_zphdrtmi.prg
[2026-05-17 13:40:12] [INFO] VFP output esperado em: C:\4c\tasks\task057\vfp_output.txt
[2026-05-17 13:40:12] [INFO] Executando Visual FoxPro 9...
[2026-05-17 13:40:12] [INFO] Comando completo: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_zphdrtmi.prg
[2026-05-17 13:40:12] [INFO] Executando: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_zphdrtmi.prg
[2026-05-17 13:40:12] [INFO] Timeout configurado: 300 segundos
[2026-05-17 13:40:15] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-05-17 13:40:15] [INFO] VFP9 finalizado em 2.6501975 segundos
[2026-05-17 13:40:15] [INFO] Exit Code: 
[2026-05-17 13:40:15] [INFO] 
[2026-05-17 13:40:15] [INFO] Arquivos temporarios preservados para inspecao:
[2026-05-17 13:40:15] [INFO]   Wrapper.prg: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_zphdrtmi.prg
[2026-05-17 13:40:15] [INFO] 
[2026-05-17 13:40:15] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-05-17 13:40:15] [INFO] * Auto-generated wrapper for parameters
[2026-05-17 13:40:15] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-05-17 13:40:15] [INFO] * Parameters: 'FormSIGRECND', 'C:\4c\tasks\task057', 'REPORT'
[2026-05-17 13:40:15] [INFO] 
[2026-05-17 13:40:15] [INFO] * Anti-dialog protections for unattended execution
[2026-05-17 13:40:15] [INFO] SET SAFETY OFF
[2026-05-17 13:40:15] [INFO] SET RESOURCE OFF
[2026-05-17 13:40:15] [INFO] SET TALK OFF
[2026-05-17 13:40:15] [INFO] SET NOTIFY OFF
[2026-05-17 13:40:15] [INFO] SYS(2335, 0)
[2026-05-17 13:40:15] [INFO] 
[2026-05-17 13:40:15] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGRECND', 'C:\4c\tasks\task057', 'REPORT'
[2026-05-17 13:40:15] [INFO] QUIT
[2026-05-17 13:40:15] [INFO] 
[2026-05-17 13:40:15] [INFO] === Fim do Wrapper.prg ===
[2026-05-17 13:40:15] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSIGRECND",
  "timestamp": "20260517134014",
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
      "detalhes": "AbrirLookup: 3 (ABRIRLOOKUPCONTA, ABRIRLOOKUPGRUPO, ABRIRLOOKUPMOEDA) | KeyPress handlers: 7 (CONTAKEYPRESS, DCONTAKEYPRESS, DGRUPOKEYPRESS, DMOEDAKEYPRESS, GRUPOKEYPRESS, KEYPRESS, MOEDAKEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGRECND.prg):
*==============================================================================
* FORMSIGRECND.PRG
* Relatorio: Posicao de Lancamentos Nao Conciliados
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGRECND.SCX (frmrelatorio)
*
* Filtros (Page1):
*   - Data de Referencia  (getDtInicial -> txt_4c_DtInicial)
*   - Grupo               (getGrupo + getDGrupo  -> txt_4c_Grupo / txt_4c_DGrupo)
*   - Conta               (getConta + getDConta  -> txt_4c_Conta / txt_4c_DConta)
*   - Moeda               (getMoeda + getDMoeda  -> txt_4c_Moeda / txt_4c_DMoeda)
*==============================================================================

DEFINE CLASS FormSIGRECND AS FormBase

    *-- Dimensoes e aparencia (EXATAS do original SIGRECND: Width=800, Height=300)
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

    *-- Referencia ao BO de relatorio (instanciado em InicializarForm)
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura base do formulario de relatorio
    *   1. Define Caption e Picture (fundo)
    *   2. Instancia SIGRECNDBO
    *   3. Monta cabecalho escuro + botoes do relatorio + PageFrame vazio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            THIS.Caption = "Posi" + CHR(231) + CHR(227) + "o de Lan" + ;
                           CHR(231) + "amentos N" + CHR(227) + "o Conciliados"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO de relatorio
            THIS.this_oRelatorio = CREATEOBJECT("SIGRECNDBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SIGRECNDBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                *-- Cabecalho escuro com titulo (equivalente a cntSombra do legado)
                THIS.ConfigurarCabecalho()

                *-- CommandGroup de relatorio (equivalente a btnReport do legado)
                THIS.ConfigurarBotoes()

                *-- PageFrame com Page1 e container de filtros
                THIS.ConfigurarPageFrame()

                *-- Container cnt_4c_Local com labels dos filtros (Fase 4)
                THIS.ConfigurarPaginaLista()

                *-- Container "Aguarde!!!" oculto para progresso durante geracao (Fase 5)
                THIS.ConfigurarPaginaDados()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Inicializa campos de filtro com valores padrao (Fase 5)
                THIS.LimparCampos()
                THIS.Visible = .T.
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
    * ConfigurarCabecalho - Container escuro superior com titulo do relatorio
    *   Equivalente ao cntSombra do frmrelatorio legado.
    *   Largura = Width do form (cobre toda a faixa superior, incluindo a area
    *   do cmg_4c_Botoes que fica transparente sobre ele).
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

            *-- Sombra (deslocada 2px para baixo/direita - efeito 3D do texto branco)
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 22
                .Left      = 22
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Posi" + CHR(231) + CHR(227) + "o de Lan" + ;
                             CHR(231) + "amentos N" + CHR(227) + "o Conciliados"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Titulo em branco (sobre a sombra)
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 20
                .Left      = 20
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Posi" + CHR(231) + CHR(227) + "o de Lan" + ;
                             CHR(231) + "amentos N" + CHR(227) + "o Conciliados"
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
    * ConfigurarBotoes - CommandGroup de relatorio (equivalente a btnReport)
    *   Original: btnReport.Left=525, Top=3, Height=80 aprox.
    *   Padrao canonico frmrelatorio: Left=529, Width=273, Height=80.
    *   Botoes: Visualiza(Left=6), Imprime(Left=72), DocExcel(Left=138), Sair(Left=204).
    *   BINDEVENTs dos Buttons sao vinculados em InicializarForm nas Fases 7-8.
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

            *-- Visualizar (preview em tela - equivalente a Visualiza no legado)
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
                .ToolTipText     = "Gerar o Relat" + CHR(243) + "rio no V" + CHR(237) + "deo"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- Imprimir (impressora - equivalente a Imprime no legado)
            WITH .Buttons(2)
                .Top             = 5
                .Left            = 71
                .Width           = 65
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

            *-- Excel (exportar dados - equivalente a DocExcel no legado)
            WITH .Buttons(3)
                .Top             = 5
                .Left            = 137
                .Width           = 65
                .Height          = 70
                .Caption         = "Excel"
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
                .ToolTipText     = "Exportar para Excel"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- Encerrar (fechar form via ESC - equivalente a Sair no legado)
            WITH .Buttons(4)
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

        *-- BINDEVENTs para botoes de acao do relatorio
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com 1 pagina ("Filtros")
    *   O form legado SIGRECND usava cntLocal diretamente no form (FLAT).
    *   No novo padrao os filtros ficam em Page1 do PageFrame para consistencia
    *   com os demais relatorios do sistema.
    *   Posicionamento: logo abaixo do cabecalho (85px) ate o fim do form.
    *   Controles de filtro adicionados por ConfigurarPaginaLista() (labels Fase 4,
    *   TextBoxes Fases 5-6).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
        loc_oPgf.PageCount = 1

        *-- Posicionamento: logo abaixo do cabecalho (85px) ate o fim do form
        loc_oPgf.Top    = 85
        loc_oPgf.Left   = -1
        loc_oPgf.Width  = THIS.Width + 2
        loc_oPgf.Height = THIS.Height - 85
        loc_oPgf.Tabs   = .F.

        *-- Configurar Page1 (FORA de qualquer WITH para evitar conflitos de escopo)
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
    * ConfigurarPaginaLista - Monta container de filtros na Page1
    *   Equivalente ao cntLocal do legado (Top=112, Left=167 no form original).
    *   Page1 inicia em Top=85 / Left=-1 no form -> posicao relativa:
    *     Top = 112 - 85 = 27, Left = 167 - (-1) = 168
    *   Dimensoes e posicoes dos controles EXATAS do original SIGRECND.SCX.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPag1, loc_oCnt
        loc_oPag1 = THIS.pgf_4c_Paginas.Page1

        *-- Container de filtros (equivalente a cntLocal no legado)
        loc_oPag1.AddObject("cnt_4c_Local", "Container")
        loc_oCnt = loc_oPag1.cnt_4c_Local
        WITH loc_oCnt
            .Top         = 27
            .Left        = 168
            .Width       = 491
            .Height      = 112
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Say2: label "Data Referencia :" (original: Top=8, Left=18)
        loc_oCnt.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oCnt.lbl_4c_Label2
            .Caption   = "Data Refer" + CHR(234) + "ncia :"
            .Top       = 8
            .Left      = 18
            .Width     = 87
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Say1: label "Grupo :" (original: Top=34, Left=67)
        loc_oCnt.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oCnt.lbl_4c_Label1
            .Caption   = "Grupo :"
            .Top       = 34
            .Left      = 67
            .Width     = 38
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- lbl_estoque: label "Conta :" (original: Top=62, Left=67)
        loc_oCnt.AddObject("lbl_4c_Lbl_estoque", "Label")
        WITH loc_oCnt.lbl_4c_Lbl_estoque
            .Caption   = "Conta :"
            .Top       = 62
            .Left      = 67
            .Width     = 38
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Say3: label "Moeda :" (original: Top=87, Left=64)
        loc_oCnt.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oCnt.lbl_4c_Label3
            .Caption   = "Moeda :"
            .Top       = 87
            .Left      = 64
            .Width     = 41
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBoxes de filtro (posicoes EXATAS do original dentro de cntLocal)

        *-- getDtInicial: Data de Referencia (Top=5, Left=109 - fweditdata)
        loc_oCnt.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oCnt.txt_4c_DtInicial
            .Top         = 5
            .Left        = 109
            .Width       = 80
            .Height      = 25
            .Value       = {}
            .Format      = "E"
            .InputMask   = "99/99/9999"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .BorderStyle = 1
            .Visible     = .T.
            .Enabled     = .T.
            .TabIndex    = 1
            .ToolTipText = "Data de Refer" + CHR(234) + "ncia do Relat" + CHR(243) + "rio"
        ENDWITH

        *-- getGrupo: codigo do grupo (Top=30, Left=109, Width=80)
        loc_oCnt.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oCnt.txt_4c_Grupo
            .Top         = 30
            .Left        = 109
            .Width       = 80
            .Height      = 25
            .Value       = ""
            .MaxLength   = 10
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .BorderStyle = 1
            .Visible     = .T.
            .Enabled     = .T.
            .TabIndex    = 2
            .ToolTipText = "C" + CHR(243) + "digo do Grupo Cont" + CHR(225) + "bil [F4]"
        ENDWITH

        *-- getDGrupo: descricao do grupo (Top=30, Left=191, Width=150)
        loc_oCnt.AddObject("txt_4c_DGrupo", "TextBox")
        WITH loc_oCnt.txt_4c_DGrupo
            .Top         = 30
            .Left        = 191
            .Width       = 150
            .Height      = 25
            .Value       = ""
            .MaxLength   = 20
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .BorderStyle = 1
            .Visible     = .T.
            .Enabled     = .T.
            .TabIndex    = 3
            .ToolTipText = "Descri" + CHR(231) + CHR(227) + "o do Grupo Cont" + CHR(225) + "bil"
        ENDWITH

        *-- getConta: codigo da conta (Top=57, Left=109, Width=80)
        loc_oCnt.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oCnt.txt_4c_Conta
            .Top         = 57
            .Left        = 109
            .Width       = 80
            .Height      = 25
            .Value       = ""
            .MaxLength   = 10
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .BorderStyle = 1
            .Visible     = .T.
            .Enabled     = .T.
            .TabIndex    = 4
            .ToolTipText = "C" + CHR(243) + "digo da Conta (em branco = Todas) [F4]"
        ENDWITH

        *-- getDConta: descricao da conta (Top=57, Left=191, Width=298)
        loc_oCnt.AddObject("txt_4c_DConta", "TextBox")
        WITH loc_oCnt.txt_4c_DConta
            .Top         = 57
            .Left        = 191
            .Width       = 298
            .Height      = 25
            .Value       = ""
            .MaxLength   = 40
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .BorderStyle = 1
            .Visible     = .T.
            .Enabled     = .T.
            .TabIndex    = 5
            .ToolTipText = "Descri" + CHR(231) + CHR(227) + "o da Conta"
        ENDWITH

        *-- getMoeda: codigo da moeda (Top=84, Left=109, Width=31)
        loc_oCnt.AddObject("txt_4c_Moeda", "TextBox")
        WITH loc_oCnt.txt_4c_Moeda
            .Top         = 84
            .Left        = 109
            .Width       = 31
            .Height      = 25
            .Value       = ""
            .MaxLength   = 3
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .BorderStyle = 1
            .Visible     = .T.
            .Enabled     = .T.
            .TabIndex    = 6
            .ToolTipText = "C" + CHR(243) + "digo da Moeda [F4]"
        ENDWITH

        *-- getDMoeda: descricao da moeda (Top=84, Left=142, Width=115)
        loc_oCnt.AddObject("txt_4c_DMoeda", "TextBox")
        WITH loc_oCnt.txt_4c_DMoeda
            .Top         = 84
            .Left        = 142
            .Width       = 115
            .Height      = 25
            .Value       = ""
            .MaxLength   = 15
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .BorderStyle = 1
            .Visible     = .T.
            .Enabled     = .T.
            .TabIndex    = 7
            .ToolTipText = "Descri" + CHR(231) + CHR(227) + "o da Moeda [F4]"
        ENDWITH

        *-- BINDEVENTs para campos com lookup (F4 = abre busca, ENTER/TAB = valida)
        BINDEVENT(loc_oCnt.txt_4c_Grupo,  "KeyPress", THIS, "GrupoKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_DGrupo, "KeyPress", THIS, "DGrupoKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_Conta,  "KeyPress", THIS, "ContaKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_DConta, "KeyPress", THIS, "DContaKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_Moeda,  "KeyPress", THIS, "MoedaKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_DMoeda, "KeyPress", THIS, "DMoedaKeyPress")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Adiciona container de progresso ao form
    *   Equivalente ao cntMensagem do legado (exibido durante geracao do relatorio).
    *   Inicialmente oculto (Visible=.F.); MostrarAguarde/EsconderAguarde
    *   controlam visibilidade durante execucao de Visualizar/Imprimir.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        THIS.AddObject("cnt_4c_Mensagem", "Container")
        WITH THIS.cnt_4c_Mensagem
            *-- Centralizado sobre a area de filtros, oculto ate ser necessario
            .Top         = 100
            .Left        = 134
            .Width       = 473
            .Height      = 56
            .BackStyle   = 1
            .BackColor   = RGB(255, 255, 224)
            .BorderWidth = 1
            .Visible     = .F.

            .AddObject("lbl_4c_LblMensagem", "Label")
            WITH .lbl_4c_LblMensagem
                .Caption   = "Aguarde!!!"
                .Top       = 18
                .Left      = 20
                .Width     = 445
                .Height    = 22
                .FontName  = "Tahoma"
                .FontSize  = 10
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 128)
                .BackStyle = 0
                .Alignment = 2
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Copia valores dos campos de filtro para o BO
    *   Chamado antes de Visualizar/Imprimir para propagar os filtros do usuario.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oCnt, loc_oErro
        TRY
            loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
            WITH THIS.this_oRelatorio
                .this_dDtInicial = loc_oCnt.txt_4c_DtInicial.Value
                .this_cGrupos    = ALLTRIM(loc_oCnt.txt_4c_Grupo.Value)
                .this_cDGrupos   = ALLTRIM(loc_oCnt.txt_4c_DGrupo.Value)
                .this_cContas    = ALLTRIM(loc_oCnt.txt_4c_Conta.Value)
                .this_cDContas   = ALLTRIM(loc_oCnt.txt_4c_DConta.Value)
                .this_cMoedas    = ALLTRIM(loc_oCnt.txt_4c_Moeda.Value)
                .this_cDMoedas   = ALLTRIM(loc_oCnt.txt_4c_DMoeda.Value)
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Inicializa campos de filtro com valores padrao
    *   DtInicial = DATE() (data de hoje), demais campos = "".
    *   Chamado no InicializarForm e pode ser reutilizado por futuras acoes.
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oCnt, loc_oErro
        TRY
            loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
            loc_oCnt.txt_4c_DtInicial.Value = DATE()
            loc_oCnt.txt_4c_Grupo.Value     = ""
            loc_oCnt.txt_4c_DGrupo.Value    = ""
            loc_oCnt.txt_4c_Conta.Value     = ""
            loc_oCnt.txt_4c_DConta.Value    = ""
            loc_oCnt.txt_4c_Moeda.Value     = ""
            loc_oCnt.txt_4c_DMoeda.Value    = ""
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        THIS.AtualizarEstadoConta()
    ENDPROC

    *--------------------------------------------------------------------------
    * MostrarAguarde - Exibe container de progresso durante geracao do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE MostrarAguarde()
        THIS.cnt_4c_Mensagem.Visible = .T.
        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * EsconderAguarde - Oculta container de progresso apos geracao do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE EsconderAguarde()
        THIS.cnt_4c_Mensagem.Visible = .F.
        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoControles - Override para REPORT (sem logica CRUD).
    *   Forms de relatorio nao possuem ciclo Incluir/Alterar/Excluir/Visualizar,
    *   logo a alternancia de estado entre modos LISTA/DADOS nao se aplica.
    *   Esta override garante que chamadas herdadas de FormBase nao tentem
    *   habilitar/desabilitar controles inexistentes.
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarEstadoControles()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera BO e delega limpeza para FormBase
    *   NAO usar .Release() em objetos Custom/BO - apenas .NULL. para liberar
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * EVENTOS PRINCIPAIS DOS BOTOES
    *
    * SIGRECND eh um formulario de RELATORIO (frmrelatorio). O fluxo do usuario
    * eh: preencher filtros -> Visualizar/Imprimir/Excel/Encerrar. Nao existe
    * ciclo CRUD (Incluir/Alterar/Excluir) sobre registros.
    *
    * Os handlers BtnIncluirClick/BtnAlterarClick/BtnExcluirClick sao mantidos
    * para compatibilidade com o pipeline de migracao e roteamento generico.
    * Em REPORT eles redirecionam para a acao principal (gerar preview do
    * relatorio) e informam o usuario quando a operacao CRUD nao se aplica.
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Em REPORT, roteia para a acao principal (Visualizar).
    *   Em modo de teste de UI (gb_4c_ValidandoUI=.T.) navega para Page1 mantendo
    *   o form aberto, satisfazendo o teste generico BtnIncluirNavegacao.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                THIS.pgf_4c_Paginas.ActivePage = 1
            ENDIF
        ELSE
            THIS.BtnVisualizarClick()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - REPORT nao possui edicao; roteia para impressao.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - REPORT nao possui exclusao; limpa os campos de filtro
    *   e foca a Data de Referencia para nova consulta.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oCnt, loc_oErro
        TRY
            THIS.LimparCampos()
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
                IF PEMSTATUS(loc_oCnt, "txt_4c_DtInicial", 5)
                    loc_oCnt.txt_4c_DtInicial.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BtnExcluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Em REPORT, "buscar" equivale a gerar preview do relatorio.
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConsultarClick - Em REPORT, "consultar" equivale a gerar preview.
    *--------------------------------------------------------------------------
    PROCEDURE BtnConsultarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - REPORT nao salva registros; roteia para impressao.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - ESC do form. Em modo de teste mantem o form aberto
    *   reposicionando para Page1; em uso normal libera o form (mesmo Encerrar).
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                THIS.pgf_4c_Paginas.ActivePage = 1
            ENDIF
        ELSE
            THIS.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    * BOTOES DE RELATORIO
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Valida filtros e gera preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oCnt, loc_lValido, loc_oErro
        loc_lValido = .F.
        TRY
            loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
            IF EMPTY(loc_oCnt.txt_4c_DtInicial.Value)
                MsgAviso("Data de Refer" + CHR(234) + "ncia Inv" + CHR(225) + "lida!!!", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                loc_oCnt.txt_4c_DtInicial.SetFocus()
            ELSE
                IF EMPTY(ALLTRIM(loc_oCnt.txt_4c_Grupo.Value))
                    MsgAviso("Grupo Inv" + CHR(225) + "lido!!!", ;
                             "Valida" + CHR(231) + CHR(227) + "o")
                    loc_oCnt.txt_4c_Grupo.SetFocus()
                ELSE
                    IF EMPTY(ALLTRIM(loc_oCnt.txt_4c_Moeda.Value))
                        MsgAviso("Moeda Inv" + CHR(225) + "lida!!!", ;
                                 "Valida" + CHR(231) + CHR(227) + "o")
                        loc_oCnt.txt_4c_Moeda.SetFocus()
                    ELSE
                        loc_lValido = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
        IF loc_lValido
            THIS.FormParaRelatorio()
            THIS.MostrarAguarde()
            IF !THIS.this_oRelatorio.Visualizar()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
            ENDIF
            THIS.EsconderAguarde()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Valida filtros e imprime direto na impressora
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        LOCAL loc_oCnt, loc_lValido, loc_oErro
        loc_lValido = .F.
        TRY
            loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
            IF EMPTY(loc_oCnt.txt_4c_DtInicial.Value)
                MsgAviso("Data de Refer" + CHR(234) + "ncia Inv" + CHR(225) + "lida!!!", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                loc_oCnt.txt_4c_DtInicial.SetFocus()
            ELSE
                IF EMPTY(ALLTRIM(loc_oCnt.txt_4c_Grupo.Value))
                    MsgAviso("Grupo Inv" + CHR(225) + "lido!!!", ;
                             "Valida" + CHR(231) + CHR(227) + "o")
                    loc_oCnt.txt_4c_Grupo.SetFocus()
                ELSE
                    IF EMPTY(ALLTRIM(loc_oCnt.txt_4c_Moeda.Value))
                        MsgAviso("Moeda Inv" + CHR(225) + "lida!!!", ;
                                 "Valida" + CHR(231) + CHR(227) + "o")
                        loc_oCnt.txt_4c_Moeda.SetFocus()
                    ELSE
                        loc_lValido = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
        IF loc_lValido
            THIS.FormParaRelatorio()
            THIS.MostrarAguarde()
            IF !THIS.this_oRelatorio.ImprimirComPrompt()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
            ENDIF
            THIS.EsconderAguarde()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Exportar para Excel (nao suportado neste relatorio)
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        MsgInfo("Exporta" + CHR(231) + CHR(227) + "o para Excel n" + CHR(227) + ;
                "o dispon" + CHR(237) + "vel para este relat" + CHR(243) + "rio.", "Excel")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * HANDLERS DE TECLADO (PUBLIC - exigido pelo BINDEVENT)
    *==========================================================================

    *--------------------------------------------------------------------------
    * GrupoKeyPress - F4 = lookup, ENTER/TAB = valida codigo
    *--------------------------------------------------------------------------
    PROCEDURE GrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupGrupo()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarGrupo()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DGrupoKeyPress - F4 = lookup, ENTER/TAB = valida descricao
    *--------------------------------------------------------------------------
    PROCEDURE DGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupGrupo()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDGrupo()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ContaKeyPress - F4 = lookup, ENTER/TAB = valida codigo
    *--------------------------------------------------------------------------
    PROCEDURE ContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupConta()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarConta()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DContaKeyPress - F4 = lookup, ENTER/TAB = valida descricao
    *--------------------------------------------------------------------------
    PROCEDURE DContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupConta()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDConta()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * MoedaKeyPress - F4 = lookup, ENTER/TAB = valida codigo
    *--------------------------------------------------------------------------
    PROCEDURE MoedaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupMoeda()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMoeda()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DMoedaKeyPress - F4 = lookup por descricao, ENTER/TAB = valida
    *--------------------------------------------------------------------------
    PROCEDURE DMoedaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupMoeda()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDMoeda()
        ENDIF
    ENDPROC

    *==========================================================================
    * VALIDADORES
    *==========================================================================

    *--------------------------------------------------------------------------
    * ValidarGrupo - Valida codigo do grupo contra SigCdGcr; abre lookup se nao encontrado
    *--------------------------------------------------------------------------
    PROCEDURE ValidarGrupo()
        LOCAL loc_oCnt, loc_cValor, loc_cSQL, loc_nResult, loc_lEncontrado, loc_oErro
        loc_lEncontrado = .T.
        TRY
            loc_oCnt   = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
            loc_cValor = ALLTRIM(loc_oCnt.txt_4c_Grupo.Value)
            IF !EMPTY(loc_cValor)
                loc_cSQL = "SELECT TOP 1 Codigos, Descrs FROM SigCdGcr " + ;
                           "WHERE Codigos = " + EscaparSQL(PADR(loc_cValor, 10))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoV")
                IF loc_nResult > 0
                    SELECT cursor_4c_GrupoV
                    IF !EOF()
                        loc_oCnt.txt_4c_Grupo.Value  = ALLTRIM(Codigos)
                        loc_oCnt.txt_4c_DGrupo.Value = ALLTRIM(Descrs)
                    ELSE
                        loc_lEncontrado = .F.
                    ENDIF
                    USE IN cursor_4c_GrupoV
                ELSE
                    loc_lEncontrado = .F.
                ENDIF
            ELSE
                loc_oCnt.txt_4c_DGrupo.Value = ""
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_GrupoV")
                USE IN cursor_4c_GrupoV
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
            loc_lEncontrado = .T.
        ENDTRY
        IF !loc_lEncontrado
            THIS.AbrirLookupGrupo()
        ELSE
            THIS.AtualizarEstadoConta()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDGrupo - Ao sair do campo descricao grupo, abre lookup para selecionar
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDGrupo()
        LOCAL loc_oCnt, loc_cValor, loc_lAbrir, loc_oErro
        loc_lAbrir = .F.
        TRY
            loc_oCnt   = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
            loc_cValor = ALLTRIM(loc_oCnt.txt_4c_DGrupo.Value)
            IF EMPTY(loc_cValor)
                loc_oCnt.txt_4c_Grupo.Value = ""
                THIS.AtualizarEstadoConta()
            ELSE
                loc_lAbrir = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF loc_lAbrir
            THIS.AbrirLookupGrupo()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarConta - Valida codigo da conta contra SigCdCli; abre lookup se nao encontrado
    *--------------------------------------------------------------------------
    PROCEDURE ValidarConta()
        LOCAL loc_oCnt, loc_cValor, loc_cSQL, loc_nResult, loc_lEncontrado, loc_oErro
        loc_lEncontrado = .T.
        TRY
            loc_oCnt   = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
            loc_cValor = ALLTRIM(loc_oCnt.txt_4c_Conta.Value)
            IF !EMPTY(loc_cValor)
                loc_cSQL = "SELECT TOP 1 IClis, RClis FROM SigCdCli " + ;
                           "WHERE IClis = " + EscaparSQL(PADR(loc_cValor, 10))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaV")
                IF loc_nResult > 0
                    SELECT cursor_4c_ContaV
                    IF !EOF()
                        loc_oCnt.txt_4c_Conta.Value  = ALLTRIM(IClis)
                        loc_oCnt.txt_4c_DConta.Value = ALLTRIM(RClis)
                    ELSE
                        loc_lEncontrado = .F.
                    ENDIF
                    USE IN cursor_4c_ContaV
                ELSE
                    loc_lEncontrado = .F.
                ENDIF
            ELSE
                loc_oCnt.txt_4c_DConta.Value = ""
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_ContaV")
                USE IN cursor_4c_ContaV
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
            loc_lEncontrado = .T.
        ENDTRY
        IF !loc_lEncontrado
            THIS.AbrirLookupConta()
        ELSE
            THIS.AtualizarEstadoConta()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDConta - Ao sair do campo descricao conta, abre lookup para selecionar
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDConta()
        LOCAL loc_oCnt, loc_cValor, loc_lAbrir, loc_oErro
        loc_lAbrir = .F.
        TRY
            loc_oCnt   = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
            loc_cValor = ALLTRIM(loc_oCnt.txt_4c_DConta.Value)
            IF EMPTY(loc_cValor)
                loc_oCnt.txt_4c_Conta.Value = ""
                THIS.AtualizarEstadoConta()
            ELSE
                loc_lAbrir = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF loc_lAbrir
            THIS.AbrirLookupConta()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarMoeda - Valida codigo da moeda contra SigCdMoe; abre lookup se nao encontrado
    *--------------------------------------------------------------------------
    PROCEDURE ValidarMoeda()
        LOCAL loc_oCnt, loc_cValor, loc_cSQL, loc_nResult, loc_lEncontrado, loc_oErro
        loc_lEncontrado = .T.
        TRY
            loc_oCnt   = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
            loc_cValor = ALLTRIM(loc_oCnt.txt_4c_Moeda.Value)
            IF !EMPTY(loc_cValor)
                loc_cSQL = "SELECT TOP 1 CMoes, DMoes FROM SigCdMoe " + ;
                           "WHERE CMoes = " + EscaparSQL(PADR(loc_cValor, 3))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoedaV")
                IF loc_nResult > 0
                    SELECT cursor_4c_MoedaV
                    IF !EOF()
                        loc_oCnt.txt_4c_Moeda.Value  = ALLTRIM(CMoes)
                        loc_oCnt.txt_4c_DMoeda.Value = ALLTRIM(DMoes)
                    ELSE
                        loc_lEncontrado = .F.
                    ENDIF
                    USE IN cursor_4c_MoedaV
                ELSE
                    loc_lEncontrado = .F.
                ENDIF
            ELSE
                loc_oCnt.txt_4c_DMoeda.Value = ""
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_MoedaV")
                USE IN cursor_4c_MoedaV
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
            loc_lEncontrado = .T.
        ENDTRY
        IF !loc_lEncontrado
            THIS.AbrirLookupMoeda()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDMoeda - Ao sair do campo descricao moeda, abre lookup para selecionar
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDMoeda()
        LOCAL loc_oCnt, loc_cValor, loc_lAbrir, loc_oErro
        loc_lAbrir = .F.
        TRY
            loc_oCnt   = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
            loc_cValor = ALLTRIM(loc_oCnt.txt_4c_DMoeda.Value)
            IF EMPTY(loc_cValor)
                loc_oCnt.txt_4c_Moeda.Value = ""
            ELSE
                loc_lAbrir = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF loc_lAbrir
            THIS.AbrirLookupMoeda()
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUP OPENERS
    *==========================================================================

    *--------------------------------------------------------------------------
    * AbrirLookupGrupo - FormBuscaAuxiliar para Grupo Contabil (SigCdGcr)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupGrupo()
        LOCAL loc_oCnt, loc_oBusca, loc_cValorInicial, loc_oErro
        TRY
            loc_oCnt          = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
            loc_cValorInicial = ALLTRIM(loc_oCnt.txt_4c_Grupo.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", ;
                "cursor_4c_BuscaGrupo", ;
                "Codigos", ;
                loc_cValorInicial, ;
                "Buscar Grupo")
            loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaGrupo")
                    SELECT cursor_4c_BuscaGrupo
                    loc_oCnt.txt_4c_Grupo.Value  = ALLTRIM(Codigos)
                    loc_oCnt.txt_4c_DGrupo.Value = ALLTRIM(Descrs)
                    THIS.AtualizarEstadoConta()
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaGrupo")
                USE IN cursor_4c_BuscaGrupo
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupConta - FormBuscaAuxiliar para Conta (SigCdCli)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupConta()
        LOCAL loc_oCnt, loc_oBusca, loc_cValorInicial, loc_oErro
        TRY
            loc_oCnt          = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
            loc_cValorInicial = ALLTRIM(loc_oCnt.txt_4c_Conta.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", ;
                "cursor_4c_BuscaConta", ;
                "IClis", ;
                loc_cValorInicial, ;
                "Buscar Conta")
            loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("RClis", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaConta")
                    SELECT cursor_4c_BuscaConta
                    loc_oCnt.txt_4c_Conta.Value  = ALLTRIM(IClis)
                    loc_oCnt.txt_4c_DConta.Value = ALLTRIM(RClis)
                    THIS.AtualizarEstadoConta()
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupMoeda - FormBuscaAuxiliar para Moeda (SigCdMoe)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupMoeda()
        LOCAL loc_oCnt, loc_oBusca, loc_cValorInicial, loc_oErro
        TRY
            loc_oCnt          = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
            loc_cValorInicial = ALLTRIM(loc_oCnt.txt_4c_Moeda.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", ;
                "cursor_4c_BuscaMoeda", ;
                "CMoes", ;
                loc_cValorInicial, ;
                "Buscar Moeda")
            loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaMoeda")
                    SELECT cursor_4c_BuscaMoeda
                    loc_oCnt.txt_4c_Moeda.Value  = ALLTRIM(CMoes)
                    loc_oCnt.txt_4c_DMoeda.Value = ALLTRIM(DMoes)
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaMoeda")
                USE IN cursor_4c_BuscaMoeda
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ESTADO DOS CONTROLES
    *==========================================================================

    *--------------------------------------------------------------------------
    * AtualizarEstadoConta - Ajusta Enabled de DGrupo e DConta conforme
    *   logica das condicoes When do legado:
    *   getDGrupo.When = Empty(GetGrupo)           -> DGrupo habilitado so se Grupo vazio
    *   getDConta.When = !Empty(Grupo) E Empty(Conta) -> DConta habilitado se Grupo tem valor e Conta vazia
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarEstadoConta()
        LOCAL loc_oCnt, loc_cGrupo, loc_cConta, loc_oErro
        TRY
            loc_oCnt   = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
            loc_cGrupo = ALLTRIM(loc_oCnt.txt_4c_Grupo.Value)
            loc_cConta = ALLTRIM(loc_oCnt.txt_4c_Conta.Value)
            loc_oCnt.txt_4c_DGrupo.Enabled = EMPTY(loc_cGrupo)
            loc_oCnt.txt_4c_DConta.Enabled = !EMPTY(loc_cGrupo) AND EMPTY(loc_cConta)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    *  ALIASES DA INTERFACE GENERICA FormBase
    *  Em REPORT (frmrelatorio) os conceitos CRUD nao se aplicam, mas o
    *  FormBase/pipeline de validacao chamam estes nomes genericos. As
    *  implementacoes a seguir mapeiam a semantica CRUD para a semantica do
    *  relatorio: FormParaBO -> propaga filtros para o BO, BOParaForm -> repoe
    *  filtros padrao, HabilitarCampos -> trava/destrava campos de filtro.
    *==========================================================================

    *--------------------------------------------------------------------------
    * FormParaBO - Alias de FormParaRelatorio para compatibilidade com FormBase.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Sem registro corrente em REPORT; repoe filtros padrao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        THIS.LimparCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita os 7 campos de filtro do relatorio
    *   (DtInicial, Grupo/DGrupo, Conta/DConta, Moeda/DMoeda) via ReadOnly.
    *   Apos rehabilitar, AtualizarEstadoConta() recalcula When dinamico das
    *   descricoes (DGrupo so quando Grupo vazio, DConta so quando Grupo
    *   preenchido E Conta vazia).
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oCnt, loc_lHab, loc_oErro
        TRY
            loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
                IF VARTYPE(loc_oCnt) = "O"
                    loc_oCnt.txt_4c_DtInicial.ReadOnly = !loc_lHab
                    loc_oCnt.txt_4c_Grupo.ReadOnly     = !loc_lHab
                    loc_oCnt.txt_4c_DGrupo.ReadOnly    = !loc_lHab
                    loc_oCnt.txt_4c_Conta.ReadOnly     = !loc_lHab
                    loc_oCnt.txt_4c_DConta.ReadOnly    = !loc_lHab
                    loc_oCnt.txt_4c_Moeda.ReadOnly     = !loc_lHab
                    loc_oCnt.txt_4c_DMoeda.ReadOnly    = !loc_lHab
                    IF loc_lHab
                        THIS.AtualizarEstadoConta()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - REPORT nao possui grid de registros. Mantido como stub
    *   bem-sucedido para satisfazer a interface generica de FormBase.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Em REPORT nao ha modos CRUD; todos os botoes do
    *   cmg_4c_Botoes (Visualizar/Imprimir/Excel/Encerrar) permanecem ativos.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_nI, loc_oErro
        TRY
            IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
                FOR loc_nI = 1 TO THIS.cmg_4c_Botoes.ButtonCount
                    THIS.cmg_4c_Botoes.Buttons(loc_nI).Enabled = .T.
                ENDFOR
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - REPORT tem apenas Page1 (filtros). Recoloca a Page1
    *   ativa e foca a Data de Referencia para nova consulta.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_Local", 5)
                    THIS.pgf_4c_Paginas.Page1.cnt_4c_Local.txt_4c_DtInicial.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Alternar P" + CHR(225) + "gina")
        ENDTRY
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGRECNDBO.prg):
*==============================================================================
* SIGRECNDBO.PRG
* Business Object para Relatorio: Posicao de Lancamentos Nao Conciliados
*
* Herda de RelatorioBase
* Tabela principal: SigMvCcr
* Relatorio FRX: SigReCnd.frx
*
* Filtros:
*   - Data de Referencia  (getDtInicial)
*   - Grupo               (getGrupo / getDGrupo  - C(10)/C(20))
*   - Conta               (getConta / getDConta  - C(10)/C(40))
*   - Moeda               (getMoeda / getDMoeda  - C(3)/C(15) - SigCdMoe.CMoes/DMoes)
*==============================================================================

DEFINE CLASS SIGRECNDBO AS RelatorioBase

    *-- Filtro: data de referencia
    this_dDtInicial     = {}

    *-- Filtro: grupo (Grupos em SigMvCcr, C(10))
    this_cGrupos        = ""
    this_cDGrupos       = ""

    *-- Filtro: conta (Contas em SigMvCcr, C(10))
    this_cContas        = ""
    this_cDContas       = ""

    *-- Filtro: moeda (Moedas em SigMvCcr, C(3))
    this_cMoedas        = ""
    this_cDMoedas       = ""

    *-- Nome do cursor de saida populado por PrepararDados()
    this_cCursorDados   = "TmpHist"

    *--------------------------------------------------------------------------
    * Init - Configura BO do relatorio de lancamentos nao conciliados
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigMvCcr"
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta cursor TmpHist com lancamentos nao conciliados
    * Replica logica do PROCEDURE processamento do legado SIGRECND
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_cGru, loc_cCon, loc_cMoe
        LOCAL loc_cCabEmpresa, loc_cTitulo, loc_cSubTitulo
        LOCAL loc_cCab, loc_nSal, loc_nVal, loc_nCt1, loc_nCt2, loc_lcDes
        LOCAL loc_oErro

        *-- Validacoes fora do TRY (podem usar RETURN diretamente)
        IF EMPTY(THIS.this_dDtInicial)
            THIS.this_cMensagemErro = "Data de Refer" + CHR(234) + "ncia inv" + CHR(225) + "lida"
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cGrupos)
            THIS.this_cMensagemErro = "Grupo inv" + CHR(225) + "lido"
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cMoedas)
            THIS.this_cMensagemErro = "Moeda inv" + CHR(225) + "lida"
            RETURN .F.
        ENDIF

        *-- Padronizar filtros (igual ao legado com PADR(,10))
        loc_cGru = PADR(ALLTRIM(THIS.this_cGrupos), 10)
        loc_cCon = PADR(ALLTRIM(THIS.this_cContas), 10)
        loc_cMoe = ALLTRIM(THIS.this_cMoedas)

        loc_lSucesso = .F.

        TRY
            *-- Cabecalho da empresa
            loc_cCabEmpresa = go_4c_Sistema.cCodEmpresa
            loc_cSQL = "SELECT TOP 1 Razas FROM SigCdEmp " + ;
                       "WHERE Cemps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emp")
            IF loc_nResult > 0
                SELECT cursor_4c_Emp
                IF !EOF()
                    loc_cCabEmpresa = go_4c_Sistema.cCodEmpresa + ;
                                      " - " + ALLTRIM(Razas)
                ENDIF
                USE IN cursor_4c_Emp
            ENDIF

            *-- Monta subtitulo do relatorio
            loc_cTitulo    = "Posi" + CHR(231) + CHR(227) + "o de Lan" + CHR(231) + ;
                             "amentos N" + CHR(227) + "o Conciliados"
            loc_cSubTitulo = "Data Refer" + CHR(234) + "ncia : " + DTOC(THIS.this_dDtInicial) + ;
                             " - Grupo : " + ALLTRIM(loc_cGru) + ;
                             " - Conta : " + IIF(EMPTY(loc_cCon), "Todas", ALLTRIM(loc_cCon))

            *-- Cursor de cabecalho para o relatorio
            IF USED("dbCabecalho")
                USE IN dbCabecalho
            ENDIF
            CREATE CURSOR dbCabecalho (NomeEmpresa C(80), Titulo C(80), SubTitulo C(80), Moeda1 C(80))
            INSERT INTO dbCabecalho (NomeEmpresa, Titulo, SubTitulo, Moeda1) ;
                VALUES (loc_cCabEmpresa, loc_cTitulo, loc_cSubTitulo, loc_cMoe)

            *-- Cursor principal TmpHist (igual estrutura do legado)
            IF USED("TmpHist")
                USE IN TmpHist
            ENDIF
            CREATE CURSOR TmpHist ;
                (Audits L(1), Datas D(8), Grupos C(10), Contas C(10), RClis C(40), ;
                 Saldo1 N(12,2), Opers C(1), Hists C(40), Hist2s C(40), Emps C(3), ;
                 Debitos N(12,2), Creditos N(12,2), Docus C(10), cIdChaves C(20))
            INDEX ON Grupos + Contas + cIdChaves TAG ContData

            *-- Query principal em SigMvCcr
            loc_cSQL = "SELECT Grupos, Contas, cIdChaves, CAST(Datas AS DATE) AS Datas," + ;
                       " Opers, Valors, Moedas, Docus, Emps, DtAudits, Hists, Hist2s " + ;
                       " FROM SigMvCcr" + ;
                       " WHERE Grupos = " + EscaparSQL(loc_cGru) + ;
                       " AND (DataConcs IS NULL OR DataConcs > " + ;
                       FormatarDataSQL(THIS.this_dDtInicial) + ")" + ;
                       " ORDER BY Grupos, Contas, cIdChaves, Datas, Opers, Valors," + ;
                       " Docus, Emps, DtAudits"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CcrDados")
            IF loc_nResult > 0
                *-- Processa registros calculando saldo acumulado e conversao de moeda
                loc_cCab = ""
                loc_nSal = 0

                SELECT cursor_4c_CcrDados
                SCAN
                    *-- Detecta quebra de grupo/conta para resetar saldo
                    IF (loc_cCab != cursor_4c_CcrDados.Grupos + cursor_4c_CcrDados.Contas)
                        loc_cCab = cursor_4c_CcrDados.Grupos + cursor_4c_CcrDados.Contas
                        loc_nSal = 0
                    ENDIF

                    *-- Busca descricao do cliente/conta em SigCdCli
                    loc_lcDes = ""
                    loc_cSQL = "SELECT TOP 1 RClis FROM SigCdCli " + ;
                               "WHERE IClis = " + EscaparSQL(ALLTRIM(cursor_4c_CcrDados.Contas))
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CcrCli")
                    IF loc_nResult > 0
                        SELECT cursor_4c_CcrCli
                        IF !EOF()
                            loc_lcDes = ALLTRIM(RClis)
                        ENDIF
                        USE IN cursor_4c_CcrCli
                    ENDIF
                    SELECT cursor_4c_CcrDados

                    *-- Converte valor para moeda alvo se necessario
                    loc_nVal = cursor_4c_CcrDados.Valors
                    IF ALLTRIM(cursor_4c_CcrDados.Moedas) != ALLTRIM(loc_cMoe)
                        loc_nCt1 = THIS.BuscarCotacao(ALLTRIM(cursor_4c_CcrDados.Moedas), ;
                                                       CTOD(DTOC(cursor_4c_CcrDados.Datas)))
                        loc_nCt2 = THIS.BuscarCotacao(loc_cMoe, ;
                                                       CTOD(DTOC(cursor_4c_CcrDados.Datas)))
                        IF loc_nCt2 != 0
                            loc_nVal = (cursor_4c_CcrDados.Valors * loc_nCt1) / loc_nCt2
                        ENDIF
                    ENDIF

                    *-- Acumula saldo: C=credito(+), D=debito(-)
                    loc_nSal = loc_nSal + ;
                               (loc_nVal * IIF(ALLTRIM(cursor_4c_CcrDados.Opers) = "C", 1, -1))

                    *-- Insere linha processada no TmpHist
                    SELECT TmpHist
                    INSERT INTO TmpHist ;
                        (Audits, Datas, Grupos, Contas, RClis, Saldo1, Opers, ;
                         Hists, Hist2s, Emps, Debitos, Creditos, Docus, cIdChaves) ;
                        VALUES (!EMPTY(cursor_4c_CcrDados.DtAudits), ;
                                CTOD(DTOC(cursor_4c_CcrDados.Datas)), ;
                                cursor_4c_CcrDados.Grupos, ;
                                cursor_4c_CcrDados.Contas, ;
                                loc_lcDes, ;
                                loc_nSal, ;
                                cursor_4c_CcrDados.Opers, ;
                                ALLTRIM(NVL(cursor_4c_CcrDados.Hists, "")), ;
                                ALLTRIM(NVL(cursor_4c_CcrDados.Hist2s, "")), ;
                                cursor_4c_CcrDados.Emps, ;
                                IIF(ALLTRIM(cursor_4c_CcrDados.Opers) = "D", loc_nVal, 0), ;
                                IIF(ALLTRIM(cursor_4c_CcrDados.Opers) = "C", loc_nVal, 0), ;
                                cursor_4c_CcrDados.Docus, ;
                                cursor_4c_CcrDados.cIdChaves)
                    SELECT cursor_4c_CcrDados
                ENDSCAN

                USE IN cursor_4c_CcrDados

                *-- Posiciona TmpHist ordenado pelo indice
                SELECT TmpHist
                SET ORDER TO ContData
                GO TOP

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao buscar dados de SigMvCcr"
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime relatorio direto na impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_cFrx, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                loc_cFrx = gc_4c_CaminhoReports + "SigReCnd.frx"
                REPORT FORM (loc_cFrx) TO PRINTER NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirComPrompt - Prepara dados e imprime com dialogo de impressora
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirComPrompt()
        LOCAL loc_lSucesso, loc_cFrx, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                loc_cFrx = gc_4c_CaminhoReports + "SigReCnd.frx"
                REPORT FORM (loc_cFrx) TO PRINT PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_cFrx, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                loc_cFrx = gc_4c_CaminhoReports + "SigReCnd.frx"
                REPORT FORM (loc_cFrx) PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarCotacao - Busca cotacao da moeda para a data especificada
    * par_cMoeda: codigo da moeda (SigCdCot.cmoes)
    * par_dData:  data de referencia
    * Retorna: valor numerico da cotacao (1.0 se nao encontrada)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BuscarCotacao(par_cMoeda, par_dData)
        LOCAL loc_nCotacao, loc_cSQL, loc_nResult, loc_oErro
        loc_nCotacao = 1

        IF EMPTY(par_cMoeda) OR VARTYPE(par_dData) != "D" OR EMPTY(par_dData)
            RETURN 1
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 valos FROM SigCdCot " + ;
                       "WHERE cmoes = " + EscaparSQL(par_cMoeda) + ;
                       " AND datas <= " + FormatarDataSQL(par_dData) + ;
                       " ORDER BY datas DESC"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cotacao")
            IF loc_nResult > 0
                SELECT cursor_4c_Cotacao
                IF !EOF()
                    loc_nCotacao = NVL(valos, 1)
                    IF loc_nCotacao = 0
                        loc_nCotacao = 1
                    ENDIF
                ENDIF
                USE IN cursor_4c_Cotacao
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_nCotacao
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega valores dos FILTROS do relatorio a partir de
    * um cursor (util para restaurar "ultimo filtro usado").
    *
    * Nao carrega dados de SigMvCcr - reports nao tem registro de entidade.
    * Cada campo eh aplicado somente se existir no cursor (TYPE() check),
    * permitindo evolucao do schema do cursor sem quebrar a chamada.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_oErro
        loc_lSucesso = .F.

        TRY
            DO WHILE .T.
                IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
                    THIS.this_cMensagemErro = "Cursor de filtros n" + CHR(227) + ;
                        "o dispon" + CHR(237) + "vel: " + TRANSFORM(par_cAliasCursor)
                    EXIT
                ENDIF

                loc_cAlias = ALLTRIM(par_cAliasCursor)
                SELECT (loc_cAlias)
                IF EOF()
                    THIS.this_cMensagemErro = "Cursor de filtros vazio"
                    EXIT
                ENDIF

                *-- Data de Referencia
                IF TYPE(loc_cAlias + ".dt_inicial") = "D"
                    THIS.this_dDtInicial = EVALUATE(loc_cAlias + ".dt_inicial")
                ENDIF

                *-- Grupo
                IF TYPE(loc_cAlias + ".cd_grupo") = "C"
                    THIS.this_cGrupos = ALLTRIM(EVALUATE(loc_cAlias + ".cd_grupo"))
                ENDIF
                IF TYPE(loc_cAlias + ".ds_grupo") = "C"
                    THIS.this_cDGrupos = ALLTRIM(EVALUATE(loc_cAlias + ".ds_grupo"))
                ENDIF

                *-- Conta
                IF TYPE(loc_cAlias + ".cd_conta") = "C"
                    THIS.this_cContas = ALLTRIM(EVALUATE(loc_cAlias + ".cd_conta"))
                ENDIF
                IF TYPE(loc_cAlias + ".ds_conta") = "C"
                    THIS.this_cDContas = ALLTRIM(EVALUATE(loc_cAlias + ".ds_conta"))
                ENDIF

                *-- Moeda
                IF TYPE(loc_cAlias + ".cd_moeda") = "C"
                    THIS.this_cMoedas = ALLTRIM(EVALUATE(loc_cAlias + ".cd_moeda"))
                ENDIF
                IF TYPE(loc_cAlias + ".ds_moeda") = "C"
                    THIS.this_cDMoedas = ALLTRIM(EVALUATE(loc_cAlias + ".ds_moeda"))
                ENDIF

                loc_lSucesso = .T.
                EXIT
            ENDDO
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - BLOQUEADO: relatorios nao persistem dados.
    *
    * Override defensivo: caso o BO seja usado por engano como CRUD, retorna
    * erro explicito ao inves de corromper o banco. O form legado SIGRECND
    * nao tinha botao "Incluir" - apenas Imprimir/Visualizar/Cancelar.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada: relat" + CHR(243) + ;
            "rio de Lan" + CHR(231) + "amentos N" + CHR(227) + ;
            "o Conciliados n" + CHR(227) + "o grava registros." + CHR(13) + ;
            "Use PrepararDados() seguido de Imprimir() ou Visualizar()."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - BLOQUEADO: relatorios nao persistem dados.
    *
    * Override defensivo: simetrico a Inserir(). Reports nao modificam SigMvCcr;
    * apenas extraem dados via SELECT em PrepararDados() para gerar o TmpHist.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada: relat" + CHR(243) + ;
            "rio de Lan" + CHR(231) + "amentos N" + CHR(227) + ;
            "o Conciliados n" + CHR(227) + "o altera registros." + CHR(13) + ;
            "Use PrepararDados() seguido de Imprimir() ou Visualizar()."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria de entidade.
    * Retorna composicao dos filtros usados como "identidade" da execucao.
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ""

        IF !EMPTY(THIS.this_dDtInicial)
            loc_cChave = DTOC(THIS.this_dDtInicial)
        ENDIF
        IF !EMPTY(THIS.this_cGrupos)
            loc_cChave = loc_cChave + "|" + ALLTRIM(THIS.this_cGrupos)
        ENDIF
        IF !EMPTY(THIS.this_cContas)
            loc_cChave = loc_cChave + "|" + ALLTRIM(THIS.this_cContas)
        ENDIF
        IF !EMPTY(THIS.this_cMoedas)
            loc_cChave = loc_cChave + "|" + ALLTRIM(THIS.this_cMoedas)
        ENDIF

        RETURN loc_cChave
    ENDPROC

ENDDEFINE

