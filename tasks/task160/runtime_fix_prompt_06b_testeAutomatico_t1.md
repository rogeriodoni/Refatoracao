# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 78% < 100%. Falhas: Teste 'FormParaRelatorio': Metodo FormParaRelatorio nao encontrado; Teste 'ModoVisualizar': Property AJUSTARBOTOESPORMODO is not found. | Detalhes: Linha: 542

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-02 03:43:05] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-02 03:43:05] [INFO] Config FPW: (nao fornecido)
[2026-07-02 03:43:05] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-02 03:43:05] [INFO] Timeout: 300 segundos
[2026-07-02 03:43:05] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_aojlq2nw.prg
[2026-07-02 03:43:05] [INFO] Conteudo do wrapper:
[2026-07-02 03:43:05] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSIGPRCCR', 'C:\4c\tasks\task160', 'REPORT'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGPRCCR', 'C:\4c\tasks\task160', 'REPORT'
QUIT

[2026-07-02 03:43:05] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_aojlq2nw.prg
[2026-07-02 03:43:05] [INFO] VFP output esperado em: C:\4c\tasks\task160\vfp_output.txt
[2026-07-02 03:43:05] [INFO] Executando Visual FoxPro 9...
[2026-07-02 03:43:05] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_aojlq2nw.prg
[2026-07-02 03:43:05] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_aojlq2nw.prg
[2026-07-02 03:43:05] [INFO] Timeout configurado: 300 segundos
[2026-07-02 03:43:20] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-02 03:43:20] [INFO] VFP9 finalizado em 14.9913217 segundos
[2026-07-02 03:43:20] [INFO] Exit Code: 
[2026-07-02 03:43:20] [INFO] 
[2026-07-02 03:43:20] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-02 03:43:20] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_aojlq2nw.prg
[2026-07-02 03:43:20] [INFO] 
[2026-07-02 03:43:20] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-02 03:43:20] [INFO] * Auto-generated wrapper for parameters
[2026-07-02 03:43:20] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-02 03:43:20] [INFO] * Parameters: 'FormSIGPRCCR', 'C:\4c\tasks\task160', 'REPORT'
[2026-07-02 03:43:20] [INFO] 
[2026-07-02 03:43:20] [INFO] * Anti-dialog protections for unattended execution
[2026-07-02 03:43:20] [INFO] SET SAFETY OFF
[2026-07-02 03:43:20] [INFO] SET RESOURCE OFF
[2026-07-02 03:43:20] [INFO] SET TALK OFF
[2026-07-02 03:43:20] [INFO] SET NOTIFY OFF
[2026-07-02 03:43:20] [INFO] SYS(2335, 0)
[2026-07-02 03:43:20] [INFO] 
[2026-07-02 03:43:20] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGPRCCR', 'C:\4c\tasks\task160', 'REPORT'
[2026-07-02 03:43:20] [INFO] QUIT
[2026-07-02 03:43:20] [INFO] 
[2026-07-02 03:43:20] [INFO] === Fim do Wrapper.prg ===
[2026-07-02 03:43:20] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSIGPRCCR",
  "timestamp": "20260702034320",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": true,
      "erro": "",
      "detalhes": "Objeto criado com sucesso"
    },
    {
      "nome": "FormParaRelatorio",
      "passou": false,
      "erro": "Metodo FormParaRelatorio nao encontrado",
      "detalhes": ""
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
    "passou": 7,
    "falhou": 2,
    "percentual": 78
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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGPRCCR.prg):
*==============================================================================
* FORMSIGPRCCR.PRG
* Formulario de Relatorio de Produtos com Preco Alterado
* Tipo: REPORT (sem filtros - executa diretamente ao clicar os botoes)
* Migrado de: SIGPRCCR.SCX (frmrelatorio)
*
* Layout FLAT (frmrelatorio): NAO existe Page1 (lista/grid) nem Page2 (dados)
* nem botoes CRUD (Incluir/Alterar/Excluir/Buscar). A estrutura eh apenas:
*   - cnt_4c_Cabecalho: faixa cinza superior com titulo
*   - cmg_4c_Botoes:    CommandGroup com 4 botoes (Visualizar/Imprimir/
*                       Arquivos Email/Encerrar)
*
* Sem campos de filtro: o relatorio busca todos os produtos com lMarca=1
* ordenados por Cpros e imprime/visualiza diretamente.
*==============================================================================

DEFINE CLASS FormSIGPRCCR AS FormBase

    *-- Dimensoes exatas do original (Width=800, Height=130)
    Height      = 130
    Width       = 800
    DataSession = 1
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

    *-- BO do relatorio (instanciado em InicializarForm)
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura visual: cabecalho cinza + 4 botoes
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro, loc_lBOOk
        loc_lSucesso = .F.
        loc_lBOOk    = .F.
        TRY
            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            IF TYPE("gc_4c_CaminhoReports") = "U"
                gc_4c_CaminhoReports = ""
            ENDIF

            *-- Instanciar BO
            THIS.this_oRelatorio = CREATEOBJECT("SIGPRCCRBO")
            loc_lBOOk = (VARTYPE(THIS.this_oRelatorio) = "O")

            IF loc_lBOOk
                *-- Estrutura visual (cabecalho antes dos botoes = z-order correto)
                *-- FLAT layout REPORT: sem filtros; ConfigurarPaginaDados sincroniza
                *-- o cabecalho visual com o titulo/subtitulo dinamico do BO.
                THIS.ConfigurarPaginaDados()
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()

                *-- Vincular eventos Click dos 4 botoes
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnEmailClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY

        IF !loc_lBOOk AND loc_lSucesso = .F.
            MsgErro("Erro ao criar SIGPRCCRBO" + CHR(13) + ;
                "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura a "pagina de dados" do relatorio
    *
    *   REPORT FLAT layout: o SIGPRCCR original NAO possui campos de filtro
    *   (Height=130, apenas cabecalho + 4 botoes). Portanto esta rotina NAO
    *   adiciona TextBoxes/Labels de filtro (nao existem no legado).
    *
    *   Trabalho real executado aqui:
    *     - Define Caption do form (titulo da janela) a partir dos dados do BO
    *     - Configura Picture (background) resolvendo o caminho global
    *     - Propaga this_cTituloRel do BO como identificacao do relatorio,
    *       garantindo que Caption/cabecalho/BO fiquem sincronizados quando
    *       o titulo evoluir (ex: internacionalizacao).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_cTituloJanela

        *-- Caption preferencial: titulo canonico do BO (unico ponto de verdade)
        IF VARTYPE(THIS.this_oRelatorio) = "O" ;
                AND !EMPTY(THIS.this_oRelatorio.this_cTituloRel)
            loc_cTituloJanela = "Impress" + CHR(227) + "o de " + ;
                                ALLTRIM(THIS.this_oRelatorio.this_cTituloRel)
        ELSE
            loc_cTituloJanela = "Impress" + CHR(227) + "o de Produtos com Pre" + ;
                                CHR(231) + "os alterados"
        ENDIF
        THIS.Caption = loc_cTituloJanela

        *-- Background do form (mesmo padrao dos demais forms de relatorio)
        THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container cinza cobrindo todo o form
    *   O form nao tem area de filtros: o cabecalho ocupa toda a altura (130px).
    *   Equivalente ao cntSombra do frmrelatorio legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = THIS.Height
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            *-- Sombra (deslocada 2px) para efeito de profundidade
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 52
                .Left      = 22
                .Width     = THISFORM.Width
                .Height    = 30
                .AutoSize  = .F.
                .Caption   = THISFORM.Caption
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Titulo principal (branco sobre cinza)
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 50
                .Left      = 20
                .Width     = THISFORM.Width
                .Height    = 30
                .AutoSize  = .F.
                .Caption   = THISFORM.Caption
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
    * ConfigurarBotoes - CommandGroup com 4 botoes de relatorio
    *   Geometria exata do SCX original:
    *     btnReport.Left=495, Width=310, Height=85, Top=0 (SCX tinha Top=-2)
    *   Botoes: Lefts=5/80/155/230, Width=75, Height=75
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = 0
            .Left          = 495
            .Width         = 310
            .Height        = 85
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
                .Width           = 75
                .Height          = 75
                .Caption         = "\<Visualizar"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Gerar o Relat" + CHR(243) + "rio no V" + CHR(237) + "deo"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(2)
                .Top             = 5
                .Left            = 80
                .Width           = 75
                .Height          = 75
                .Caption         = "\<Imprimir"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Enviar o Relat" + CHR(243) + "rio Para Impressora"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(3)
                .Top             = 5
                .Left            = 155
                .Width           = 75
                .Height          = 75
                .Caption         = "\<Arquivos Email"
                .WordWrap        = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Arquivos Email"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(4)
                .Top             = 5
                .Left            = 230
                .Width           = 75
                .Height          = 75
                .Caption         = "\<Encerrar"
                .Cancel          = .T.
                .WordWrap        = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
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
    * BtnVisualizarClick - Prepara dados e exibe relatorio em preview
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_lOk
        loc_lOk = .F.
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            loc_lOk = THIS.this_oRelatorio.Visualizar()
            IF !loc_lOk
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Prepara dados e imprime na impressora padrao
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        LOCAL loc_lOk
        loc_lOk = .F.
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            loc_lOk = THIS.this_oRelatorio.Imprimir()
            IF !loc_lOk
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEmailClick - Prepara dados e gera documento para email
    *--------------------------------------------------------------------------
    PROCEDURE BtnEmailClick()
        LOCAL loc_lOk
        loc_lOk = .F.
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            loc_lOk = THIS.this_oRelatorio.ArquivosEmail()
            IF !loc_lOk
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * MAPEAMENTO CRUD -> REPORT (FASE 7 - Eventos Principais)
    *
    * Forms REPORT (frmrelatorio) nao possuem operacoes CRUD tradicionais
    * (Incluir/Alterar/Excluir). Os metodos abaixo replicam o contrato
    * BtnXxxClick esperado pelo pipeline de migracao, delegando cada um
    * para o equivalente semantico em contexto de relatorio.
    *
    * Semantica adotada (identica a FormSigReAac.prg / demais REPORTs):
    *   Incluir   -> "gerar nova saida" -> Visualizar preview
    *   Alterar   -> "regerar saida"    -> Visualizar preview
    *   Excluir   -> nao aplicavel      -> MsgInfo informativo
    *   Visualizar-> preview na tela    -> BO.Visualizar()
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnIncluirClick - "Gerar relatorio" em form de relatorio
    *   Em CRUD: cria um novo registro no banco de dados.
    *   Em REPORT: nao ha registros a incluir. A acao semanticamente
    *   equivalente eh gerar uma nova saida do relatorio (visualizar preview
    *   com os dados atuais). Delega para BtnVisualizarClick que ja realiza
    *   PrepararDados + REPORT FORM PREVIEW via o BO.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - "Regerar relatorio" em form de relatorio
    *   Em CRUD: prepara form para alteracao do registro selecionado.
    *   Em REPORT: equivale a regerar o relatorio com os dados atuais.
    *   Como o SIGPRCCR nao possui filtros (Height=130, sem TextBoxes),
    *   "alterar" significa executar novamente a query de produtos com
    *   lMarca=1 e reexibir o preview.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Operacao invalida em form de relatorio
    *   Em CRUD: exclui o registro selecionado apos confirmacao.
    *   Em REPORT: nao ha registros para excluir (apenas cursores temporarios
    *   criados durante PrepararDados). Informa o usuario que a operacao nao
    *   se aplica e sugere Visualizar/Imprimir como alternativas.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        MsgInfo("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + ;
            CHR(237) + "vel em relat" + CHR(243) + "rios." + CHR(13) + ;
            "Use Visualizar ou Imprimir para gerar o relat" + CHR(243) + "rio.", ;
            "Aten" + CHR(231) + CHR(227) + "o")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - "Buscar registros" em form de relatorio
    *   Em CRUD: recarrega o grid de lista com registros do banco.
    *   Em REPORT: nao ha grid nem lista para buscar. A acao equivalente
    *   eh executar PrepararDados no BO (rebusca produtos com lMarca=1).
    *   Nao exibe UI, apenas garante que o cursor de dados esteja atualizado.
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_lOk
        loc_lOk = .F.
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            loc_lOk = THIS.CarregarLista()
            IF !loc_lOk
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - "Salvar" em form de relatorio
    *   Em CRUD: persiste o registro editado (INSERT/UPDATE).
    *   Em REPORT: nao ha edicao de registro; a acao semantica equivalente
    *   eh materializar a saida do relatorio (imprimir na impressora padrao).
    *   Delega para BtnImprimirClick que executa PrepararDados + REPORT FORM
    *   TO PRINTER NOCONSOLE via o BO.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - "Cancelar edicao" em form de relatorio
    *   Em CRUD: descarta alteracoes em andamento e volta para a lista.
    *   Em REPORT: nao ha edicao a cancelar. A acao equivalente eh fechar
    *   o form (mesmo comportamento do Encerrar do CommandGroup).
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.BtnEncerrarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Copia valores dos controles do form para o BO
    *   Em CRUD: transfere TextBoxes/ComboBoxes de Page2 para propriedades
    *   this_* do BO antes de Inserir/Atualizar.
    *   Em REPORT SIGPRCCR: NAO existem controles de filtro (Height=130,
    *   apenas cabecalho + 4 botoes). Ainda assim mantemos a sincronia
    *   canonica: propagar Caption do form (unico dado editavel visualmente)
    *   como titulo do relatorio no BO. Garante que uma eventual troca de
    *   Caption em runtime (i18n) reflita no cabecalho do relatorio.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_cCaption
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        loc_cCaption = ALLTRIM(THIS.Caption)
        IF !EMPTY(loc_cCaption)
            *-- Sincroniza titulo do BO com Caption atual do form
            THIS.this_oRelatorio.this_cTitulo = loc_cCaption
        ENDIF
        *-- SubTitulo sempre reflete a data corrente de emissao
        THIS.this_oRelatorio.this_cSubTitulo = "Em " + DTOC(DATE())
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Copia valores do BO para os controles do form
    *   Em CRUD: transfere propriedades this_* para TextBoxes/ComboBoxes
    *   apos CarregarPorCodigo/Buscar.
    *   Em REPORT SIGPRCCR: sem controles de filtro, mas o cabecalho visual
    *   (lbl_4c_Sombra + lbl_4c_Titulo) DEVE refletir o titulo canonico do
    *   BO. Reaplica Caption do form e captions dos labels do cabecalho a
    *   partir de this_cTituloRel do BO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_cTitulo
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        loc_cTitulo = ALLTRIM(THIS.this_oRelatorio.this_cTituloRel)
        IF EMPTY(loc_cTitulo)
            loc_cTitulo = "Rela" + CHR(231) + CHR(227) + ;
                          "o de Produtos com Pre" + CHR(231) + "o Alterado"
        ENDIF
        THIS.Caption = "Impress" + CHR(227) + "o de " + loc_cTitulo
        IF PEMSTATUS(THIS, "cnt_4c_Cabecalho", 5)
            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Ativa/desativa controles conforme o modo
    *   par_lHabilitar = .T. -> modo edicao (campos editaveis)
    *   par_lHabilitar = .F. -> modo consulta (campos travados)
    *
    *   Em REPORT SIGPRCCR nao ha TextBoxes de filtro; o unico estado que
    *   varia visualmente eh a disponibilidade dos 4 botoes do CommandGroup.
    *   Aplica Enabled de forma consistente para todos os Buttons(N), com
    *   Encerrar sempre habilitado (contrato UX: Encerrar nunca eh bloqueado).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab
        loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
        IF PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
            THIS.cmg_4c_Botoes.Buttons(1).Enabled = loc_lHab
            THIS.cmg_4c_Botoes.Buttons(2).Enabled = loc_lHab
            THIS.cmg_4c_Botoes.Buttons(3).Enabled = loc_lHab
            *-- Encerrar (Buttons(4)) SEMPRE ativo: usuario deve poder fechar
            THIS.cmg_4c_Botoes.Buttons(4).Enabled = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Reseta valores dos controles do form
    *   Em CRUD: zera TextBoxes/ComboBoxes/CheckBoxes de Page2.
    *   Em REPORT SIGPRCCR sem filtros: reseta os cursores temporarios de
    *   dados/cabecalho no BO para forcar rebusca no proximo PrepararDados,
    *   e restaura Caption e subtitulo aos valores canonicos iniciais.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        *-- Fecha cursores para forcar novo PrepararDados na proxima acao
        IF USED(THIS.this_oRelatorio.this_cCursorDados)
            USE IN (THIS.this_oRelatorio.this_cCursorDados)
        ENDIF
        IF USED(THIS.this_oRelatorio.this_cCursorCabecalho)
            USE IN (THIS.this_oRelatorio.this_cCursorCabecalho)
        ENDIF
        *-- Restaura dados canonicos do cabecalho
        THIS.this_oRelatorio.this_cEmpresa   = ""
        THIS.this_oRelatorio.this_cSubTitulo = "Em " + DTOC(DATE())
        THIS.BOParaForm()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Recarrega dados de exibicao
    *   Em CRUD: refaz Buscar() no BO e reconfigura RecordSource do grid.
    *   Em REPORT SIGPRCCR: nao ha grid; a acao equivalente eh executar
    *   PrepararDados no BO (SQLEXEC dos produtos com lMarca=1 + cursor de
    *   cabecalho) para que uma acao subsequente de Visualizar/Imprimir use
    *   os dados atualizados. Retorna .T./.F. igual aos forms CRUD.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lOk
        loc_lOk = .F.
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            loc_lOk = THIS.this_oRelatorio.PrepararDados()
        ENDIF
        RETURN loc_lOk
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta Enabled dos botoes conforme modo atual
    *   Em CRUD: modo LISTA habilita CRUD, modo DADOS habilita Salvar/Cancel.
    *   Em REPORT SIGPRCCR: nao existem modos LISTA/DADOS; o form sempre
    *   opera em estado "pronto para gerar relatorio". Garante que os 4
    *   botoes do CommandGroup estejam habilitados para o usuario.
    *   Recebe par_cModo opcional apenas para manter assinatura CRUD.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo(par_cModo)
        THIS.HabilitarCampos(.T.)
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera BO antes de destruir o form
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRCCRBO.prg):
*==============================================================================
* SIGPRCCRBO.PRG
* Business Object para Relatorio de Produtos com Preco Alterado
* Tipo: REPORT
* Herda de RelatorioBase
*
* Relatorio: SigPrCcr.frx
* Logica: Busca empresa em SigCdEmp, cria cursor de cabecalho,
*          imprime produtos com lMarca=1, ordenados por Cpros
*==============================================================================

DEFINE CLASS SIGPRCCRBO AS RelatorioBase

    *-- Dados do cabecalho do relatorio
    this_cEmpresa           = ""
    this_cTitulo            = ""
    this_cSubTitulo         = ""

    *-- Configuracao do relatorio
    this_cFRXPath           = ""
    this_cTituloRel         = ""

    *-- Cursores utilizados
    this_cCursorDados       = "cursor_4c_Relatorio"
    this_cCursorCabecalho   = "cursor_4c_Cabecalho"

    *--------------------------------------------------------------------------
    * Init - Inicializa BO do relatorio de produtos com preco alterado
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF DODEFAULT()
                IF TYPE("gc_4c_CaminhoReports") = "U"
                    gc_4c_CaminhoReports = ""
                ENDIF
                THIS.this_cTabela     = ""
                THIS.this_cCampoChave = ""
                THIS.this_cFRXPath    = gc_4c_CaminhoReports + "SigPrCcr.frx"
                THIS.this_cTituloRel  = "Rela" + CHR(231) + CHR(227) + ;
                                        "o de Produtos com Pre" + CHR(231) + "o Alterado "
                THIS.this_cTitulo     = THIS.this_cTituloRel
                THIS.this_cSubTitulo  = "Em " + DTOC(DATE())
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta cursores para o relatorio
    * Busca empresa, cria cursor cabecalho e seleciona produtos com lMarca=1
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResult, loc_cEmpresa
        loc_lSucesso = .F.
        TRY
            WAIT WINDOW "Aguarde Processamento !" NOWAIT

            *-- Busca nome da empresa
            loc_cSQL = "SELECT Razas FROM SigCdEmp WHERE Cemps = " + ;
                       EscaparSQL(go_4c_Sistema.cCodEmpresa)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpCcr")
            IF loc_nResult > 0
                SELECT cursor_4c_EmpCcr
                GO TOP
                IF !EOF()
                    loc_cEmpresa = IIF(!EMPTY(cursor_4c_EmpCcr.Razas), ;
                                       ALLTRIM(cursor_4c_EmpCcr.Razas), "")
                ELSE
                    loc_cEmpresa = ""
                ENDIF
            ELSE
                loc_cEmpresa = ""
            ENDIF
            IF USED("cursor_4c_EmpCcr")
                USE IN cursor_4c_EmpCcr
            ENDIF

            *-- Atualiza propriedades de cabecalho
            THIS.this_cEmpresa   = loc_cEmpresa
            THIS.this_cTitulo    = "Rela" + CHR(231) + CHR(227) + ;
                                   "o de Produtos com Pre" + CHR(231) + "o Alterado "
            THIS.this_cSubTitulo = "Em " + DTOC(DATE())

            *-- Cria cursor de cabecalho
            IF USED(THIS.this_cCursorCabecalho)
                USE IN (THIS.this_cCursorCabecalho)
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Cabecalho ;
                (cb_empresa C(80), titulo C(80), SubTitulo C(80))
            INSERT INTO cursor_4c_Cabecalho (cb_empresa, titulo, SubTitulo) ;
                   VALUES (THIS.this_cEmpresa, THIS.this_cTitulo, THIS.this_cSubTitulo)
            SET NULL OFF

            *-- Busca produtos com lMarca = 1 ordenados por Cpros
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF
            loc_cSQL = "SELECT * FROM SigCdPro WHERE lMarca = 1 ORDER BY Cpros"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar produtos com pre" + CHR(231) + "o alterado"
            ELSE
                SELECT (THIS.this_cCursorDados)
                GO TOP
                loc_lSucesso = .T.
            ENDIF

            WAIT CLEAR
        CATCH TO loc_oErro
            WAIT CLEAR
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime o relatorio na impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cFRXPath) TO PRINTER NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirComPrompt - Prepara dados e imprime com selecao de impressora
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirComPrompt()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cFRXPath) TO PRINT PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cFRXPath) PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ArquivosEmail - Prepara dados e gera documento para email
    *--------------------------------------------------------------------------
    PROCEDURE ArquivosEmail()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cFRXPath) TO PRINTER NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores abertos pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        IF USED(THIS.this_cCursorCabecalho)
            USE IN (THIS.this_cCursorCabecalho)
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

