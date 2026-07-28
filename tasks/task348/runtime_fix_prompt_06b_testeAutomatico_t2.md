# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 2/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'CarregarLista': Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc)

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[21/07/2026 08:56:44 PM] FormBAL.CarregarGrades: Connection handle is invalid.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-21 20:53:14] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-21 20:53:14] [INFO] Config FPW: (nao fornecido)
[2026-07-21 20:53:14] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-21 20:53:14] [INFO] Timeout: 300 segundos
[2026-07-21 20:53:14] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fyt5oqgg.prg
[2026-07-21 20:53:14] [INFO] Conteudo do wrapper:
[2026-07-21 20:53:14] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormBAL', 'C:\4c\tasks\task348', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormBAL', 'C:\4c\tasks\task348', 'CRUD'
QUIT

[2026-07-21 20:53:14] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fyt5oqgg.prg
[2026-07-21 20:53:14] [INFO] VFP output esperado em: C:\4c\tasks\task348\vfp_output.txt
[2026-07-21 20:53:14] [INFO] Executando Visual FoxPro 9...
[2026-07-21 20:53:14] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fyt5oqgg.prg
[2026-07-21 20:53:14] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fyt5oqgg.prg
[2026-07-21 20:53:14] [INFO] Timeout configurado: 300 segundos
[2026-07-21 20:53:49] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-21 20:53:49] [INFO] VFP9 finalizado em 34.8753568 segundos
[2026-07-21 20:53:49] [INFO] Exit Code: 
[2026-07-21 20:53:49] [INFO] 
[2026-07-21 20:53:49] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-21 20:53:49] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fyt5oqgg.prg
[2026-07-21 20:53:49] [INFO] 
[2026-07-21 20:53:49] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-21 20:53:49] [INFO] * Auto-generated wrapper for parameters
[2026-07-21 20:53:49] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-21 20:53:49] [INFO] * Parameters: 'FormBAL', 'C:\4c\tasks\task348', 'CRUD'
[2026-07-21 20:53:49] [INFO] 
[2026-07-21 20:53:49] [INFO] * Anti-dialog protections for unattended execution
[2026-07-21 20:53:49] [INFO] SET SAFETY OFF
[2026-07-21 20:53:49] [INFO] SET RESOURCE OFF
[2026-07-21 20:53:49] [INFO] SET TALK OFF
[2026-07-21 20:53:49] [INFO] SET NOTIFY OFF
[2026-07-21 20:53:49] [INFO] SYS(2335, 0)
[2026-07-21 20:53:49] [INFO] 
[2026-07-21 20:53:49] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormBAL', 'C:\4c\tasks\task348', 'CRUD'
[2026-07-21 20:53:49] [INFO] QUIT
[2026-07-21 20:53:49] [INFO] 
[2026-07-21 20:53:49] [INFO] === Fim do Wrapper.prg ===
[2026-07-21 20:53:49] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-07-21 20:56:04] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-21 20:56:04] [INFO] Config FPW: (nao fornecido)
[2026-07-21 20:56:04] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-21 20:56:04] [INFO] Timeout: 300 segundos
[2026-07-21 20:56:04] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_mu3ikpkv.prg
[2026-07-21 20:56:04] [INFO] Conteudo do wrapper:
[2026-07-21 20:56:04] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormBAL', 'C:\4c\tasks\task348', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormBAL', 'C:\4c\tasks\task348', 'CRUD'
QUIT

[2026-07-21 20:56:04] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_mu3ikpkv.prg
[2026-07-21 20:56:04] [INFO] VFP output esperado em: C:\4c\tasks\task348\vfp_output.txt
[2026-07-21 20:56:04] [INFO] Executando Visual FoxPro 9...
[2026-07-21 20:56:04] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_mu3ikpkv.prg
[2026-07-21 20:56:04] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_mu3ikpkv.prg
[2026-07-21 20:56:04] [INFO] Timeout configurado: 300 segundos
[2026-07-21 20:56:44] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-21 20:56:44] [INFO] VFP9 finalizado em 39.6717851 segundos
[2026-07-21 20:56:44] [INFO] Exit Code: 
[2026-07-21 20:56:44] [INFO] 
[2026-07-21 20:56:44] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-21 20:56:44] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_mu3ikpkv.prg
[2026-07-21 20:56:44] [INFO] 
[2026-07-21 20:56:44] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-21 20:56:44] [INFO] * Auto-generated wrapper for parameters
[2026-07-21 20:56:44] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-21 20:56:44] [INFO] * Parameters: 'FormBAL', 'C:\4c\tasks\task348', 'CRUD'
[2026-07-21 20:56:44] [INFO] 
[2026-07-21 20:56:44] [INFO] * Anti-dialog protections for unattended execution
[2026-07-21 20:56:44] [INFO] SET SAFETY OFF
[2026-07-21 20:56:44] [INFO] SET RESOURCE OFF
[2026-07-21 20:56:44] [INFO] SET TALK OFF
[2026-07-21 20:56:44] [INFO] SET NOTIFY OFF
[2026-07-21 20:56:44] [INFO] SYS(2335, 0)
[2026-07-21 20:56:44] [INFO] 
[2026-07-21 20:56:44] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormBAL', 'C:\4c\tasks\task348', 'CRUD'
[2026-07-21 20:56:44] [INFO] QUIT
[2026-07-21 20:56:44] [INFO] 
[2026-07-21 20:56:44] [INFO] === Fim do Wrapper.prg ===
[2026-07-21 20:56:44] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormBAL",
  "timestamp": "20260721205644",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": true,
      "erro": "",
      "detalhes": "Objeto criado com sucesso"
    },
    {
      "nome": "CarregarLista",
      "passou": false,
      "erro": "Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc)",
      "detalhes": ""
    },
    {
      "nome": "ModoIncluir",
      "passou": true,
      "erro": "",
      "detalhes": "Page2 ativada com sucesso"
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
      "detalhes": "BtnIncluirClick navegou para Page2 | BtnCancelarClick retornou para Page1"
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
      "detalhes": "AbrirLookup: 0 | KeyPress handlers: 21 (KEYPRESS, KEYPRESSCOLECOESF, KEYPRESSCOLECOESI, KEYPRESSCONTA, KEYPRESSCPROSF, KEYPRESSCPROSI, KEYPRESSFORNECFINAL, KEYPRESSFORNECINICIAL, KEYPRESSGGRUPOFINAL, KEYPRESSGGRUPOINICIAL, KEYPRESSGRUPO, KEYPRESSGRUPOFINAL, KEYPRESSGRUPOINICIAL, KEYPRESSLIN, KEYPRESSLIN2, KEYPRESSLOCALFINAL, KEYPRESSLOCALINICIAL, KEYPRESSSGRUSF, KEYPRESSSGRUSI, KEYPRESSUNIFIM, KEYPRESSUNIINI)"
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormBAL.prg):
*==============================================================================
* FormBAL.prg - Invent" + CHR(225) + "rio Processo (SIGCDBAL)
*
* Tabela: SIGCDBAL
* Tipo: OPERACIONAL (3 paginas: Lista, Dados, Leitura)
* BO: BALBO
*==============================================================================

DEFINE CLASS FormBAL AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Invent" + CHR(225) + "rio Processo"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    DataSession = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"
    this_cCidchavesSel   = ""

    *--------------------------------------------------------------------------
    * Init - APENAS retorna DODEFAULT (FormBase.Init chama InicializarForm)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configura estrutura completa
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            SET DATE TO BRITISH
            SET CENTURY ON

            THIS.this_oBusinessObject = CREATEOBJECT("BALBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar BALBO", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.InicializarForm")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com 3 Pages
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        WITH loc_oPgf
            .PageCount = 3
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .Tabs      = .F.
            .Visible   = .T.
            .Page1.Caption   = "Lista"
            .Page1.BackColor = RGB(100, 100, 100)
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.Caption   = "Dados"
            .Page2.BackColor = RGB(100, 100, 100)
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page3.Caption   = "Leitura"
            .Page3.BackColor = RGB(100, 100, 100)
            .Page3.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
        THIS.ConfigurarPaginaLeitura()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Cria Page1: lista de inventarios + botoes
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg1, loc_oCab, loc_oSaida

        loc_oPg1 = THIS.pgf_4c_Paginas.Page1

        *-- Container cabecalho (Top=2+29=31)
        loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = loc_oPg1.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .AutoSize  = .F.
            .Caption   = THIS.Caption
            .Top       = 15
            .Left      = 10
            .Width     = THIS.Width
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .AutoSize  = .F.
            .Caption   = THIS.Caption
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Container Encerrar (canonico: Top=29, Left=917, Width=90, Height=85)
        loc_oPg1.AddObject("cnt_4c_Saida", "Container")
        loc_oSaida = loc_oPg1.cnt_4c_Saida
        WITH loc_oSaida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oSaida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Linha 1 de botoes de acao (Top=83+29=112, Height=40)
        *-- Leitura (Left=11, Width=120)
        loc_oPg1.AddObject("cmd_4c_Leitura", "CommandButton")
        WITH loc_oPg1.cmd_4c_Leitura
            .Caption         = "Leitura"
            .Picture         = gc_4c_CaminhoIcones + "operacional_leitura_26.jpg"
            .PicturePosition = 13
            .Top             = 112
            .Left            = 11
            .Width           = 120
            .Height          = 40
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oPg1.cmd_4c_Leitura, "Click", THIS, "BtnLeituraClick")

        *-- Fecha (Left=131, Width=120)
        loc_oPg1.AddObject("cmd_4c_Fecha", "CommandButton")
        WITH loc_oPg1.cmd_4c_Fecha
            .Caption         = "Fecha"
            .Picture         = gc_4c_CaminhoIcones + "operacional_fechar_26.jpg"
            .PicturePosition = 13
            .Top             = 112
            .Left            = 131
            .Width           = 120
            .Height          = 40
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oPg1.cmd_4c_Fecha, "Click", THIS, "BtnFechaClick")

        *-- Consulta (Left=251, Width=120)
        loc_oPg1.AddObject("cmd_4c_Consulta", "CommandButton")
        WITH loc_oPg1.cmd_4c_Consulta
            .Caption         = "Consulta"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_26.jpg"
            .PicturePosition = 13
            .Top             = 112
            .Left            = 251
            .Width           = 120
            .Height          = 40
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oPg1.cmd_4c_Consulta, "Click", THIS, "BtnConsultaClick")

        *-- Exporta (Left=371, Width=120)
        loc_oPg1.AddObject("cmd_4c_Command1", "CommandButton")
        WITH loc_oPg1.cmd_4c_Command1
            .Caption         = "E" + CHR(120) + "porta"
            .Picture         = gc_4c_CaminhoIcones + "geral_excel_26.jpg"
            .PicturePosition = 13
            .Top             = 112
            .Left            = 371
            .Width           = 120
            .Height          = 40
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oPg1.cmd_4c_Command1, "Click", THIS, "BtnExportaClick")

        *-- Inventario/Etiqueta (Left=490, Width=120)
        loc_oPg1.AddObject("cmd_4c_Inventario", "CommandButton")
        WITH loc_oPg1.cmd_4c_Inventario
            .Caption         = "Etiqueta"
            .Picture         = gc_4c_CaminhoIcones + "operacional_etiqueta_26.jpg"
            .PicturePosition = 13
            .Top             = 112
            .Left            = 490
            .Width           = 120
            .Height          = 40
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oPg1.cmd_4c_Inventario, "Click", THIS, "BtnInventarioClick")

        *-- Linha 2: botoes filtro/acao (Top=124+29=153, Height=20)
        *-- Processo (Left=11, Width=63)
        loc_oPg1.AddObject("cmd_4c_Processo", "CommandButton")
        WITH loc_oPg1.cmd_4c_Processo
            .Caption       = "Processo"
            .Top           = 153
            .Left          = 11
            .Width         = 63
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPg1.cmd_4c_Processo, "Click", THIS, "BtnProcessoClick")

        *-- Periodo (Left=74, Width=153)
        loc_oPg1.AddObject("cmd_4c_Periodo", "CommandButton")
        WITH loc_oPg1.cmd_4c_Periodo
            .Caption       = "Per" + CHR(237) + "odo"
            .Top           = 153
            .Left          = 74
            .Width         = 153
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPg1.cmd_4c_Periodo, "Click", THIS, "BtnOrdenarPeriodoClick")

        *-- Estoque (Left=227, Width=142)
        loc_oPg1.AddObject("cmd_4c_Estoque", "CommandButton")
        WITH loc_oPg1.cmd_4c_Estoque
            .Caption       = "Estoque"
            .Top           = 153
            .Left          = 227
            .Width         = 142
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPg1.cmd_4c_Estoque, "Click", THIS, "BtnOrdenarEstoqueClick")

        *-- Local (Left=369, Width=162)
        loc_oPg1.AddObject("cmd_4c_Local", "CommandButton")
        WITH loc_oPg1.cmd_4c_Local
            .Caption       = "Local"
            .Top           = 153
            .Left          = 369
            .Width         = 162
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPg1.cmd_4c_Local, "Click", THIS, "BtnOrdenarLocalClick")

        *-- Grupo (Left=531, Width=68)
        loc_oPg1.AddObject("cmd_4c_Grupo", "CommandButton")
        WITH loc_oPg1.cmd_4c_Grupo
            .Caption       = "Grupo"
            .Top           = 153
            .Left          = 531
            .Width         = 68
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPg1.cmd_4c_Grupo, "Click", THIS, "BtnOrdenarGrupoClick")

        *-- GGrupo (Left=599, Width=68)
        loc_oPg1.AddObject("cmd_4c_GGrupo", "CommandButton")
        WITH loc_oPg1.cmd_4c_GGrupo
            .Caption       = "Gde.Grupo"
            .Top           = 153
            .Left          = 599
            .Width         = 68
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPg1.cmd_4c_GGrupo, "Click", THIS, "BtnOrdenarGGrupoClick")

        *-- Usuario (Left=667, Width=80)
        loc_oPg1.AddObject("cmd_4c_Usuario", "CommandButton")
        WITH loc_oPg1.cmd_4c_Usuario
            .Caption       = "Usu" + CHR(225) + "rio"
            .Top           = 153
            .Left          = 667
            .Width         = 80
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPg1.cmd_4c_Usuario, "Click", THIS, "BtnOrdenarUsuarioClick")

        *-- Grid listagem (Top=175, Left=12, Width=905, Height=390)
        *-- RecordSource e ColumnCount FORA do WITH (VFP9: colunas criadas em Columns())
        loc_oPg1.AddObject("grd_4c_Lista", "Grid")
        loc_oPg1.grd_4c_Lista.RecordSource = ""
        loc_oPg1.grd_4c_Lista.ColumnCount  = 8

        WITH loc_oPg1.grd_4c_Lista
            .Top                = 175
            .Left               = 12
            .Width              = 905
            .Height             = 390
            .FontName           = "Verdana"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 3
            .GridLines          = 3
            .ReadOnly           = .T.
            .Visible            = .T.
            .Column1.Width      = 55
            .Column2.Width      = 85
            .Column3.Width      = 85
            .Column4.Width      = 85
            .Column5.Width      = 70
            .Column6.Width      = 100
            .Column7.Width      = 100
            .Column8.Width      = 90
            .Column1.ReadOnly   = .T.
            .Column2.ReadOnly   = .T.
            .Column3.ReadOnly   = .T.
            .Column4.ReadOnly   = .T.
            .Column5.ReadOnly   = .T.
            .Column6.ReadOnly   = .T.
            .Column7.ReadOnly   = .T.
            .Column8.ReadOnly   = .T.
            .Column1.Header1.Caption = ""
            .Column2.Header1.Caption = ""
            .Column3.Header1.Caption = ""
            .Column4.Header1.Caption = ""
            .Column5.Header1.Caption = ""
            .Column6.Header1.Caption = ""
            .Column7.Header1.Caption = ""
            .Column8.Header1.Caption = ""
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPg1)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Cria Page2: parametros de filtro do inventario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg2, loc_oGrdGGrupo, loc_oGrdGrupo

        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Container botoes Confirmar/Cancelar (Top=29, Left=842)
        loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPg2.cnt_4c_BotoesAcao
            .Top         = 29
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPg2.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        loc_oPg2.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
        BINDEVENT(loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *-- LINHA 1: Codigo (Left=336, Top=68+29=97) + Data Base (Left=572, Top=97)
        *-- Say3: "Codigo :" (Top=101, Left=289, Width=42)
        loc_oPg2.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPg2.lbl_4c_Label3
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 101
            .Left      = 289
            .Width     = 42
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPg2.txt_4c_Codigo
            .Value         = 0
            .Top           = 97
            .Left          = 336
            .Width         = 82
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- Say15: "Data Base :" (Top=101, Left=500, Width=58)
        loc_oPg2.AddObject("lbl_4c_Label15", "Label")
        WITH loc_oPg2.lbl_4c_Label15
            .Caption   = "Data Base :"
            .Top       = 101
            .Left      = 500
            .Width     = 58
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_DBase", "TextBox")
        WITH loc_oPg2.txt_4c_DBase
            .Value         = {}
            .Top           = 97
            .Left          = 572
            .Width         = 81
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Format        = "D"
            .Visible       = .T.
        ENDWITH

        *-- LINHA 2: Grupo (Left=336, Top=94+29=123)
        *-- lbl_grupos: "Grupo :" (Top=127, Left=293, Width=38)
        loc_oPg2.AddObject("lbl_4c_Lbl_grupos", "Label")
        WITH loc_oPg2.lbl_4c_Lbl_grupos
            .Caption   = "Grupo :"
            .Top       = 127
            .Left      = 293
            .Width     = 38
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPg2.txt_4c_Grupo
            .Value         = ""
            .Top           = 123
            .Left          = 336
            .Width         = 82
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .MaxLength     = 10
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPg2.txt_4c_Grupo, "KeyPress", THIS, "KeyPressGrupo")

        *-- Get_DGrupo: descricao do grupo (Top=123, Left=421, Width=232)
        loc_oPg2.AddObject("txt_4c_DGrupo", "TextBox")
        WITH loc_oPg2.txt_4c_DGrupo
            .Value         = ""
            .Top           = 123
            .Left          = 421
            .Width         = 232
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(240, 240, 240)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- LINHA 3: Conta/Estoque (Left=336, Top=120+29=149)
        *-- Say12: "Estoque :" (Top=153, Left=283, Width=48)
        loc_oPg2.AddObject("lbl_4c_Label12", "Label")
        WITH loc_oPg2.lbl_4c_Label12
            .Caption   = "Estoque :"
            .Top       = 153
            .Left      = 283
            .Width     = 48
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oPg2.txt_4c_Conta
            .Value         = ""
            .Top           = 149
            .Left          = 336
            .Width         = 82
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .MaxLength     = 10
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPg2.txt_4c_Conta, "KeyPress", THIS, "KeyPressConta")

        *-- Get_DConta: descricao conta (Top=149, Left=421, Width=232)
        loc_oPg2.AddObject("txt_4c_DConta", "TextBox")
        WITH loc_oPg2.txt_4c_DConta
            .Value         = ""
            .Top           = 149
            .Left          = 421
            .Width         = 232
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(240, 240, 240)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- LINHA 4: Data (Top=146+29=175) - Get_DataFinal + Get_DataInicial
        *-- Say1: "Data :" (Top=180, Left=299, Width=32)
        loc_oPg2.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPg2.lbl_4c_Label1
            .Caption   = "Data :"
            .Top       = 180
            .Left      = 299
            .Width     = 32
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_DataFinal", "TextBox")
        WITH loc_oPg2.txt_4c_DataFinal
            .Value         = {}
            .Top           = 175
            .Left          = 336
            .Width         = 82
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Format        = "D"
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_DataInicial", "TextBox")
        WITH loc_oPg2.txt_4c_DataInicial
            .Value         = {}
            .Top           = 175
            .Left          = 571
            .Width         = 82
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Format        = "D"
            .Visible       = .F.
        ENDWITH

        *-- LINHA 5: Produto (Top=172+29=201)
        *-- Say19: "Produto :" (Top=205, Left=284, Width=47)
        loc_oPg2.AddObject("lbl_4c_Label19", "Label")
        WITH loc_oPg2.lbl_4c_Label19
            .Caption   = "Produto :"
            .Top       = 205
            .Left      = 284
            .Width     = 47
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_CProsI", "TextBox")
        WITH loc_oPg2.txt_4c_CProsI
            .Value         = ""
            .Top           = 201
            .Left          = 336
            .Width         = 108
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .MaxLength     = 14
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPg2.txt_4c_CProsI, "KeyPress", THIS, "KeyPressCProsI")

        *-- Say20: "a" separator (Top=205, Left=446, Width=14)
        loc_oPg2.AddObject("lbl_4c_Label20", "Label")
        WITH loc_oPg2.lbl_4c_Label20
            .Caption   = CHR(224)
            .Top       = 205
            .Left      = 446
            .Width     = 14
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_CProsF", "TextBox")
        WITH loc_oPg2.txt_4c_CProsF
            .Value         = ""
            .Top           = 201
            .Left          = 464
            .Width         = 108
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .MaxLength     = 14
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPg2.txt_4c_CProsF, "KeyPress", THIS, "KeyPressCProsF")

        *-- LINHA 6: Local (Top=198+29=227)
        *-- Say2: "Local :" (Top=231, Left=298, Width=33)
        loc_oPg2.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPg2.lbl_4c_Label2
            .Caption   = "Local :"
            .Top       = 231
            .Left      = 298
            .Width     = 33
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_LocalInicial", "TextBox")
        WITH loc_oPg2.txt_4c_LocalInicial
            .Value         = ""
            .Top           = 227
            .Left          = 336
            .Width         = 82
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .MaxLength     = 10
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPg2.txt_4c_LocalInicial, "KeyPress", THIS, "KeyPressLocalInicial")

        loc_oPg2.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPg2.lbl_4c_Label5
            .Caption   = CHR(224)
            .Top       = 231
            .Left      = 423
            .Width     = 14
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_LocalFinal", "TextBox")
        WITH loc_oPg2.txt_4c_LocalFinal
            .Value         = ""
            .Top           = 227
            .Left          = 443
            .Width         = 82
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .MaxLength     = 10
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPg2.txt_4c_LocalFinal, "KeyPress", THIS, "KeyPressLocalFinal")

        *-- LINHA 7: Fornecedor (Top=224+29=253)
        *-- Say6: "Fornecedor :" (Top=257, Left=267, Width=64)
        loc_oPg2.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPg2.lbl_4c_Label6
            .Caption   = "Fornecedor :"
            .Top       = 257
            .Left      = 267
            .Width     = 64
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_FornecInicial", "TextBox")
        WITH loc_oPg2.txt_4c_FornecInicial
            .Value         = ""
            .Top           = 253
            .Left          = 336
            .Width         = 82
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .MaxLength     = 10
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPg2.lbl_4c_Label7
            .Caption   = CHR(224)
            .Top       = 257
            .Left      = 423
            .Width     = 14
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_FornecFinal", "TextBox")
        WITH loc_oPg2.txt_4c_FornecFinal
            .Value         = ""
            .Top           = 253
            .Left          = 443
            .Width         = 82
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .MaxLength     = 10
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPg2.txt_4c_FornecInicial, "KeyPress", THIS, "KeyPressFornecInicial")
        BINDEVENT(loc_oPg2.txt_4c_FornecFinal,   "KeyPress", THIS, "KeyPressFornecFinal")

        *-- LINHA 8: Grande Grupo (Top=250+29=279)
        *-- Say13: "Grande Grupo :" (Top=283, Left=255, Width=76)
        loc_oPg2.AddObject("lbl_4c_Label13", "Label")
        WITH loc_oPg2.lbl_4c_Label13
            .Caption   = "Grande Grupo :"
            .Top       = 283
            .Left      = 255
            .Width     = 76
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_GGrupoInicial", "TextBox")
        WITH loc_oPg2.txt_4c_GGrupoInicial
            .Value         = ""
            .Top           = 279
            .Left          = 336
            .Width         = 34
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .MaxLength     = 3
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPg2.txt_4c_GGrupoInicial, "KeyPress", THIS, "KeyPressGGrupoInicial")

        loc_oPg2.AddObject("lbl_4c_Label14", "Label")
        WITH loc_oPg2.lbl_4c_Label14
            .Caption   = CHR(224)
            .Top       = 283
            .Left      = 423
            .Width     = 14
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_GGrupoFinal", "TextBox")
        WITH loc_oPg2.txt_4c_GGrupoFinal
            .Value         = ""
            .Top           = 279
            .Left          = 443
            .Width         = 34
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .MaxLength     = 3
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPg2.txt_4c_GGrupoFinal, "KeyPress", THIS, "KeyPressGGrupoFinal")

        *-- LINHA 9: Grupo Produto (Top=276+29=305)
        *-- Say8: "Grupo :" (Top=309, Left=293, Width=38)
        loc_oPg2.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPg2.lbl_4c_Label8
            .Caption   = "Grupo :"
            .Top       = 309
            .Left      = 293
            .Width     = 38
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_GrupoInicial", "TextBox")
        WITH loc_oPg2.txt_4c_GrupoInicial
            .Value         = ""
            .Top           = 305
            .Left          = 336
            .Width         = 34
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .MaxLength     = 3
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPg2.txt_4c_GrupoInicial, "KeyPress", THIS, "KeyPressGrupoInicial")

        loc_oPg2.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oPg2.lbl_4c_Label9
            .Caption   = CHR(224)
            .Top       = 309
            .Left      = 423
            .Width     = 14
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_GrupoFinal", "TextBox")
        WITH loc_oPg2.txt_4c_GrupoFinal
            .Value         = ""
            .Top           = 305
            .Left          = 443
            .Width         = 34
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .MaxLength     = 3
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPg2.txt_4c_GrupoFinal, "KeyPress", THIS, "KeyPressGrupoFinal")

        *-- LINHA 10: Subgrupo (Top=301+29=330)
        *-- Say23: "Subgrupo :" (Top=334, Left=276, Width=55)
        loc_oPg2.AddObject("lbl_4c_Label23", "Label")
        WITH loc_oPg2.lbl_4c_Label23
            .Caption   = "Subgrupo :"
            .Top       = 334
            .Left      = 276
            .Width     = 55
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_SGrusI", "TextBox")
        WITH loc_oPg2.txt_4c_SGrusI
            .Value         = ""
            .Top           = 330
            .Left          = 336
            .Width         = 52
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .MaxLength     = 6
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_Label24", "Label")
        WITH loc_oPg2.lbl_4c_Label24
            .Caption   = CHR(224)
            .Top       = 334
            .Left      = 423
            .Width     = 14
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_SGrusF", "TextBox")
        WITH loc_oPg2.txt_4c_SGrusF
            .Value         = ""
            .Top           = 330
            .Left          = 443
            .Width         = 52
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .MaxLength     = 6
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPg2.txt_4c_SGrusI, "KeyPress", THIS, "KeyPressSGrusI")
        BINDEVENT(loc_oPg2.txt_4c_SGrusF, "KeyPress", THIS, "KeyPressSGrusF")

        *-- LINHA 11: Preco (Top=326+29=355)
        *-- Say10: "Preco :" (Top=359, Left=295, Width=36)
        loc_oPg2.AddObject("lbl_4c_Label10", "Label")
        WITH loc_oPg2.lbl_4c_Label10
            .Caption   = "Pre" + CHR(231) + "o :"
            .Top       = 359
            .Left      = 295
            .Width     = 36
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_PrecoInicial", "TextBox")
        WITH loc_oPg2.txt_4c_PrecoInicial
            .Value         = 0
            .Top           = 355
            .Left          = 336
            .Width         = 82
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Format        = "K"
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_Label11", "Label")
        WITH loc_oPg2.lbl_4c_Label11
            .Caption   = CHR(224)
            .Top       = 359
            .Left      = 423
            .Width     = 14
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_PrecoFinal", "TextBox")
        WITH loc_oPg2.txt_4c_PrecoFinal
            .Value         = 0
            .Top           = 355
            .Left          = 443
            .Width         = 82
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Format        = "K"
            .Visible       = .T.
        ENDWITH

        *-- LINHA 12: Linha (Top=351+29=380)
        *-- Say17: "Linha :" (Top=384, Left=297, Width=34)
        loc_oPg2.AddObject("lbl_4c_Label17", "Label")
        WITH loc_oPg2.lbl_4c_Label17
            .Caption   = "Linha :"
            .Top       = 384
            .Left      = 297
            .Width     = 34
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Lin", "TextBox")
        WITH loc_oPg2.txt_4c_Lin
            .Value         = ""
            .Top           = 380
            .Left          = 336
            .Width         = 82
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .MaxLength     = 10
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPg2.txt_4c_Lin, "KeyPress", THIS, "KeyPressLin")

        loc_oPg2.AddObject("lbl_4c_Label18", "Label")
        WITH loc_oPg2.lbl_4c_Label18
            .Caption   = CHR(224)
            .Top       = 384
            .Left      = 423
            .Width     = 14
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Lin2", "TextBox")
        WITH loc_oPg2.txt_4c_Lin2
            .Value         = ""
            .Top           = 380
            .Left          = 443
            .Width         = 82
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .MaxLength     = 10
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPg2.txt_4c_Lin2, "KeyPress", THIS, "KeyPressLin2")

        *-- LINHA 13: Grupo de Venda/Colecao (Top=376+29=405)
        *-- Say22: "Grupo de Venda :" (Top=409, Left=245, Width=86)
        loc_oPg2.AddObject("lbl_4c_Label22", "Label")
        WITH loc_oPg2.lbl_4c_Label22
            .Caption   = "Grupo de Venda :"
            .Top       = 409
            .Left      = 245
            .Width     = 86
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_ColecoesI", "TextBox")
        WITH loc_oPg2.txt_4c_ColecoesI
            .Value         = ""
            .Top           = 405
            .Left          = 336
            .Width         = 82
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .MaxLength     = 10
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_Label21", "Label")
        WITH loc_oPg2.lbl_4c_Label21
            .Caption   = CHR(224)
            .Top       = 409
            .Left      = 423
            .Width     = 14
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_ColecoesF", "TextBox")
        WITH loc_oPg2.txt_4c_ColecoesF
            .Value         = ""
            .Top           = 405
            .Left          = 443
            .Width         = 82
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .MaxLength     = 10
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPg2.txt_4c_ColecoesI, "KeyPress", THIS, "KeyPressColecoesI")
        BINDEVENT(loc_oPg2.txt_4c_ColecoesF, "KeyPress", THIS, "KeyPressColecoesF")

        *-- LINHA 14: Unidade (Top=402+29=431)
        *-- Say26: "Unidade :" (Top=435, Left=283, Width=48)
        loc_oPg2.AddObject("lbl_4c_Label26", "Label")
        WITH loc_oPg2.lbl_4c_Label26
            .Caption   = "Unidade :"
            .Top       = 435
            .Left      = 283
            .Width     = 48
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c__UniIni", "TextBox")
        WITH loc_oPg2.txt_4c__UniIni
            .Value         = ""
            .Top           = 431
            .Left          = 336
            .Width         = 40
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .MaxLength     = 3
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPg2.txt_4c__UniIni, "KeyPress", THIS, "KeyPressUniIni")

        loc_oPg2.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPg2.lbl_4c_Label4
            .Caption   = CHR(224)
            .Top       = 435
            .Left      = 423
            .Width     = 14
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c__UniFim", "TextBox")
        WITH loc_oPg2.txt_4c__UniFim
            .Value         = ""
            .Top           = 431
            .Left          = 443
            .Width         = 40
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .MaxLength     = 3
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPg2.txt_4c__UniFim, "KeyPress", THIS, "KeyPressUniFim")

        *-- LINHA 15: Observacao 1 / Obs por peso (Top=427+29=456)
        *-- Say25: "Observacao 1:" (Top=460, Left=258, Width=73)
        loc_oPg2.AddObject("lbl_4c_Label25", "Label")
        WITH loc_oPg2.lbl_4c_Label25
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o 1:"
            .Top       = 460
            .Left      = 258
            .Width     = 73
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_ObsPes", "TextBox")
        WITH loc_oPg2.txt_4c_ObsPes
            .Value         = ""
            .Top           = 456
            .Left          = 336
            .Width         = 220
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- LINHA 16: Agrupa (OptionGroup, Top=453+29=482)
        *-- Say16: "Agrupa :" (Top=481, Left=287, Width=44)
        loc_oPg2.AddObject("lbl_4c_Label16", "Label")
        WITH loc_oPg2.lbl_4c_Label16
            .Caption   = "Agrupa :"
            .Top       = 481
            .Left      = 287
            .Width     = 44
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- Opt_Agrupa: 2 botoes (Top=482, Left=330, Width=263, Height=16)
        loc_oPg2.AddObject("obj_4c_Opt_Agrupa", "OptionGroup")
        WITH loc_oPg2.obj_4c_Opt_Agrupa
            .Value       = 1
            .ButtonCount = 2
            .Top         = 482
            .Left        = 330
            .Width       = 263
            .Height      = 16
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption   = "Sim"
                .Left      = 0
                .Top       = 0
                .Width     = 130
                .Height    = 16
                .AutoSize  = .F.
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Left      = 132
                .Top       = 0
                .Width     = 131
                .Height    = 16
                .AutoSize  = .F.
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .Themes    = .F.
            ENDWITH
        ENDWITH

        *-- LINHA 17: Cod Barras (OptionGroup, Top=469+29=498)
        *-- Say28: "Cod. Barras :" (Top=499, Left=265, Width=66)
        loc_oPg2.AddObject("lbl_4c_Label28", "Label")
        WITH loc_oPg2.lbl_4c_Label28
            .Caption   = "C" + CHR(243) + "d. Barras :"
            .Top       = 499
            .Left      = 265
            .Width     = 66
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- optFilBarra: 3 botoes (Top=498, Left=330, Width=209, Height=14)
        loc_oPg2.AddObject("obj_4c_OptFilBarra", "OptionGroup")
        WITH loc_oPg2.obj_4c_OptFilBarra
            .Value       = 1
            .ButtonCount = 3
            .Top         = 498
            .Left        = 330
            .Width       = 209
            .Height      = 14
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption   = "Padr" + CHR(227) + "o"
                .Left      = 0
                .Top       = 0
                .Width     = 68
                .Height    = 14
                .AutoSize  = .F.
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "EAN13"
                .Left      = 70
                .Top       = 0
                .Width     = 68
                .Height    = 14
                .AutoSize  = .F.
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "2 de 5"
                .Left      = 140
                .Top       = 0
                .Width     = 69
                .Height    = 14
                .AutoSize  = .F.
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .Themes    = .F.
            ENDWITH
        ENDWITH

        *-- LINHA 18: Checkboxes (Tratas, SepEstq, LeitGructa)
        *-- chk Tratas: "Tratamento por Peso" (Top=503+29=532)
        loc_oPg2.AddObject("chk_4c_Fwcheckbox2", "CheckBox")
        WITH loc_oPg2.chk_4c_Fwcheckbox2
            .Caption   = "Tratamento por Peso"
            .Value     = 0
            .Top       = 532
            .Left      = 336
            .Width     = 180
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- chk SepEstq: "Balanco Separado por Estoque" (Top=487+29=516)
        loc_oPg2.AddObject("chk_4c_Fwcheckbox1", "CheckBox")
        WITH loc_oPg2.chk_4c_Fwcheckbox1
            .Caption   = "Balan" + CHR(231) + "o Separado por Estoque"
            .Value     = 0
            .Top       = 516
            .Left      = 336
            .Width     = 220
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- chk LeitGructa: "Leitura somente do Grupo + Conta" (Top=519+29=548)
        loc_oPg2.AddObject("chk_4c_Fwcheckbox3", "CheckBox")
        WITH loc_oPg2.chk_4c_Fwcheckbox3
            .Caption   = "Leitura somente do Grupo + Conta do Invent" + CHR(225) + "rio"
            .Value     = 0
            .Top       = 548
            .Left      = 336
            .Width     = 310
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- LINHA 19: Observacao geral EditBox (Top=537+29=566)
        *-- Say27: "Observacao :" (Top=567, Left=264, Width=67)
        loc_oPg2.AddObject("lbl_4c_Label27", "Label")
        WITH loc_oPg2.lbl_4c_Label27
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
            .Top       = 567
            .Left      = 264
            .Width     = 67
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("obj_4c_GetObs", "EditBox")
        WITH loc_oPg2.obj_4c_GetObs
            .Value         = ""
            .Top           = 566
            .Left          = 335
            .Width         = 322
            .Height        = 60
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .ScrollBars    = 2
            .Visible       = .T.
        ENDWITH

        *-- COLUNA DIREITA: Grade Grande Grupo (Top=157+29=186, Left=683)
        *-- Label2: "Grande Grupo" (Top=169, Left=683, Width=80)
        loc_oPg2.AddObject("lbl_4c_label29", "Label")
        WITH loc_oPg2.lbl_4c_label29
            .Caption   = "Grande Grupo"
            .Top       = 169
            .Left      = 683
            .Width     = 80
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- grdGGrupo (Top=186, Left=683, Width=238, Height=147)
        loc_oPg2.AddObject("grd_4c_GGrupo", "Grid")
        loc_oPg2.grd_4c_GGrupo.RecordSource = ""
        loc_oPg2.grd_4c_GGrupo.ColumnCount  = 3

        loc_oGrdGGrupo = loc_oPg2.grd_4c_GGrupo
        WITH loc_oGrdGGrupo
            .Top                = 186
            .Left               = 683
            .Width              = 238
            .Height             = 147
            .FontName           = "Tahoma"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(200, 200, 200)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 17
            .ScrollBars         = 3
            .GridLines          = 3
            .ReadOnly           = .F.
            .Visible            = .T.
            .Column1.Width      = 30
            .Column2.Width      = 50
            .Column3.Width      = 150
            .Column1.Sparse     = .F.
            .Column2.ReadOnly   = .T.
            .Column3.ReadOnly   = .T.
            .Column1.Header1.Caption = ""
            .Column2.Header1.Caption = ""
            .Column3.Header1.Caption = ""
        ENDWITH

        *-- CheckBox em Column1 do grdGGrupo com propriedades explicitas
        loc_oGrdGGrupo.Column1.AddObject("chk_4c_Check1", "CheckBox")
        WITH loc_oGrdGGrupo.Column1.chk_4c_Check1
            .Caption   = ""
            .Alignment = 0
            .ReadOnly  = .F.
            .Visible   = .T.
            .Top       = 9
            .Left      = 2
            .Height    = 17
            .Width     = 22
        ENDWITH

        loc_oGrdGGrupo.Column1.CurrentControl = "chk_4c_Check1"

        *-- Botoes Selecionar/Desmarcar GGrupo (Top=212, Left=924, Width=45, Height=45)
        loc_oPg2.AddObject("cmd_4c_Command3", "CommandButton")
        WITH loc_oPg2.cmd_4c_Command3
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .PicturePosition = 13
            .Top             = 212
            .Left            = 924
            .Width           = 45
            .Height          = 45
            .ToolTipText     = "Selecionar Todos"
            .Themes          = .T.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oPg2.cmd_4c_Command3, "Click", THIS, "BtnSelecionarTodosGGrupoClick")

        loc_oPg2.AddObject("cmd_4c_Command4", "CommandButton")
        WITH loc_oPg2.cmd_4c_Command4
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .PicturePosition = 13
            .Top             = 257
            .Left            = 924
            .Width           = 45
            .Height          = 45
            .ToolTipText     = "Desmarcar Todos"
            .Themes          = .T.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oPg2.cmd_4c_Command4, "Click", THIS, "BtnDesmarcarTodosGGrupoClick")

        *-- COLUNA DIREITA: Grade Grupo Produto (Top=330+29=359, Left=683)
        *-- Label1: "Grupo Produto" (Top=342, Left=683, Width=84)
        loc_oPg2.AddObject("lbl_4c_label110", "Label")
        WITH loc_oPg2.lbl_4c_label110
            .Caption   = "Grupo Produto"
            .Top       = 342
            .Left      = 683
            .Width     = 84
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- grdgrupo (Top=359, Left=683, Width=238, Height=147)
        loc_oPg2.AddObject("grd_4c_Grupos", "Grid")
        loc_oPg2.grd_4c_Grupos.RecordSource = ""
        loc_oPg2.grd_4c_Grupos.ColumnCount  = 3

        loc_oGrdGrupo = loc_oPg2.grd_4c_Grupos
        WITH loc_oGrdGrupo
            .Top                = 359
            .Left               = 683
            .Width              = 238
            .Height             = 147
            .FontName           = "Tahoma"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(200, 200, 200)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 17
            .ScrollBars         = 3
            .GridLines          = 3
            .ReadOnly           = .F.
            .Visible            = .T.
            .Column1.Width      = 30
            .Column2.Width      = 50
            .Column3.Width      = 150
            .Column1.Sparse     = .F.
            .Column2.ReadOnly   = .T.
            .Column3.ReadOnly   = .T.
            .Column1.Header1.Caption = ""
            .Column2.Header1.Caption = ""
            .Column3.Header1.Caption = ""
        ENDWITH

        *-- CheckBox em Column1 do grdgrupo com propriedades explicitas
        loc_oGrdGrupo.Column1.AddObject("chk_4c_check12", "CheckBox")
        WITH loc_oGrdGrupo.Column1.chk_4c_check12
            .Caption   = ""
            .Alignment = 0
            .ReadOnly  = .F.
            .Visible   = .T.
            .Top       = 9
            .Left      = 2
            .Height    = 17
            .Width     = 22
        ENDWITH

        loc_oGrdGrupo.Column1.CurrentControl = "chk_4c_check12"

        *-- Botoes Selecionar/Desmarcar Grupos (Top=378, Left=924, Width=45, Height=45)
        loc_oPg2.AddObject("cmd_4c_Command1", "CommandButton")
        WITH loc_oPg2.cmd_4c_Command1
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .PicturePosition = 13
            .Top             = 378
            .Left            = 924
            .Width           = 45
            .Height          = 45
            .ToolTipText     = "Selecionar Todos"
            .Themes          = .T.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oPg2.cmd_4c_Command1, "Click", THIS, "BtnSelecionarTodosGrupoClick")

        loc_oPg2.AddObject("cmd_4c_Command2", "CommandButton")
        WITH loc_oPg2.cmd_4c_Command2
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .PicturePosition = 13
            .Top             = 424
            .Left            = 924
            .Width           = 45
            .Height          = 45
            .ToolTipText     = "Desmarcar Todos"
            .Themes          = .T.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oPg2.cmd_4c_Command2, "Click", THIS, "BtnDesmarcarTodosGrupoClick")

        THIS.TornarControlesVisiveis(loc_oPg2)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLeitura - Cria Page3: interface de leitura/escaneamento
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLeitura()
        LOCAL loc_oPg3, loc_oGrd

        loc_oPg3 = THIS.pgf_4c_Paginas.Page3

        *-- Container Encerrar (canonico: Top=29, Left=917)
        loc_oPg3.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPg3.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPg3.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPg3.cnt_4c_Saida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oPg3.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Botoes de acao leitura (Top=12+29=41): Gravar, Cancelar, TotalLocal, Ocorrencia, Imagem, LocalGravado
        *-- Gravar (Left=828)
        loc_oPg3.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPg3.cmd_4c_Confirmar
            .Caption         = "Gravar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top             = 41
            .Left            = 828
            .Width           = 75
            .Height          = 40
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oPg3.cmd_4c_Confirmar, "Click", THIS, "BtnGravarClick")

        *-- Cancelar (Left=903)
        loc_oPg3.AddObject("cmd_4c_Cancela", "CommandButton")
        WITH loc_oPg3.cmd_4c_Cancela
            .Caption         = "Cancelar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 41
            .Left            = 743
            .Width           = 75
            .Height          = 40
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH

        BINDEVENT(loc_oPg3.cmd_4c_Cancela, "Click", THIS, "BtnCancelaClick")

        *-- TotalLocal (Left=303)
        loc_oPg3.AddObject("cmd_4c_TotalLocal", "CommandButton")
        WITH loc_oPg3.cmd_4c_TotalLocal
            .Caption       = "Total Local"
            .Top           = 41
            .Left          = 303
            .Width         = 70
            .Height        = 40
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPg3.cmd_4c_TotalLocal, "Click", THIS, "BtnTotalLocalClick")

        *-- Ocorrencia (Left=378)
        loc_oPg3.AddObject("cmd_4c_Ocorrencia", "CommandButton")
        WITH loc_oPg3.cmd_4c_Ocorrencia
            .Caption       = "Ocorr" + CHR(234) + "ncia"
            .Top           = 41
            .Left          = 378
            .Width         = 70
            .Height        = 40
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPg3.cmd_4c_Ocorrencia, "Click", THIS, "BtnOcorrenciaClick")

        *-- Excluir item leitura (Left=453, visible=F inicialmente)
        loc_oPg3.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPg3.cmd_4c_Excluir
            .Caption       = "Excluir"
            .Top           = 41
            .Left          = 453
            .Width         = 70
            .Height        = 40
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .F.
        ENDWITH

        BINDEVENT(loc_oPg3.cmd_4c_Excluir, "Click", THIS, "BtnExcluirLeituraClick")

        *-- Imagem (Left=528)
        loc_oPg3.AddObject("cmd_4c_Imagem", "CommandButton")
        WITH loc_oPg3.cmd_4c_Imagem
            .Caption       = "Imagem"
            .Top           = 41
            .Left          = 528
            .Width         = 70
            .Height        = 40
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPg3.cmd_4c_Imagem, "Click", THIS, "BtnImagemClick")

        *-- LocalGravado (Left=603)
        loc_oPg3.AddObject("cmd_4c_LocalGravado", "CommandButton")
        WITH loc_oPg3.cmd_4c_LocalGravado
            .Caption       = "Local Gravado"
            .Top           = 41
            .Left          = 603
            .Width         = 70
            .Height        = 40
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPg3.cmd_4c_LocalGravado, "Click", THIS, "BtnLocalGravadoClick")

        *-- BtnExcluir (Left=754, excluir registro selecionado na grade)
        loc_oPg3.AddObject("cmd_4c_BtnExcluir", "CommandButton")
        WITH loc_oPg3.cmd_4c_BtnExcluir
            .Caption       = "Excluir"
            .Top           = 41
            .Left          = 754
            .Width         = 60
            .Height        = 40
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        BINDEVENT(loc_oPg3.cmd_4c_BtnExcluir, "Click", THIS, "BtnExcluirLeituraClick")

        *-- PAINEL ESQUERDO: caixas de contexto (Codigo, Grupo, Estoque)
        *-- Shape4 (fundo caixa Codigo): Top=137, Left=1, Width=92, Height=47
        loc_oPg3.AddObject("shp_4c_Shape4", "Shape")
        WITH loc_oPg3.shp_4c_Shape4
            .Top         = 137
            .Left        = 1
            .Width       = 92
            .Height      = 47
            .BorderColor = RGB(0, 0, 0)
            .BorderStyle = 1
            .FillColor   = RGB(230, 230, 230)
            .Visible     = .T.
        ENDWITH

        *-- Say9: " Codigo " (Top=141, Left=20, Width=46)
        loc_oPg3.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oPg3.lbl_4c_Label9
            .Caption   = " C" + CHR(243) + "digo "
            .Top       = 141
            .Left      = 20
            .Width     = 46
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Alignment = 2
            .Visible   = .T.
        ENDWITH

        *-- Get_Codigo leitura (Top=158, Left=6, Width=82, Height=20)
        loc_oPg3.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPg3.txt_4c_Codigo
            .Value         = 0
            .Top           = 158
            .Left          = 6
            .Width         = 82
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(230, 230, 230)
            .BorderStyle   = 0
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- Shape5 (fundo caixa Grupo): Top=183, Left=1, Width=92, Height=46
        loc_oPg3.AddObject("shp_4c_Shape5", "Shape")
        WITH loc_oPg3.shp_4c_Shape5
            .Top         = 183
            .Left        = 1
            .Width       = 92
            .Height      = 46
            .BorderColor = RGB(0, 0, 0)
            .BorderStyle = 1
            .FillColor   = RGB(230, 230, 230)
            .Visible     = .T.
        ENDWITH

        *-- lbl_grupos: " Grupo " (Top=187, Left=23, Width=42)
        loc_oPg3.AddObject("lbl_4c_Lbl_grupos", "Label")
        WITH loc_oPg3.lbl_4c_Lbl_grupos
            .Caption   = " Grupo "
            .Top       = 187
            .Left      = 23
            .Width     = 42
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Alignment = 2
            .Visible   = .T.
        ENDWITH

        *-- Get_Grupo leitura (Top=204, Left=6, Width=81, Height=20)
        loc_oPg3.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPg3.txt_4c_Grupo
            .Value         = ""
            .Top           = 204
            .Left          = 6
            .Width         = 81
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(230, 230, 230)
            .BorderStyle   = 0
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- Shape6 (fundo caixa Estoque): Top=228, Left=1, Width=92, Height=47
        loc_oPg3.AddObject("shp_4c_Shape6", "Shape")
        WITH loc_oPg3.shp_4c_Shape6
            .Top         = 228
            .Left        = 1
            .Width       = 92
            .Height      = 47
            .BorderColor = RGB(0, 0, 0)
            .BorderStyle = 1
            .FillColor   = RGB(230, 230, 230)
            .Visible     = .T.
        ENDWITH

        *-- Say12: " Estoque " (Top=231, Left=16, Width=53)
        loc_oPg3.AddObject("lbl_4c_Label12", "Label")
        WITH loc_oPg3.lbl_4c_Label12
            .Caption   = " Estoque "
            .Top       = 231
            .Left      = 16
            .Width     = 53
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Alignment = 2
            .Visible   = .T.
        ENDWITH

        *-- Get_Conta leitura (Top=248, Left=6, Width=81, Height=20)
        loc_oPg3.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oPg3.txt_4c_Conta
            .Value         = ""
            .Top           = 248
            .Left          = 6
            .Width         = 81
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(230, 230, 230)
            .BorderStyle   = 0
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- Shape7 (fundo caixa TipoLeitura): Top=274, Left=1, Width=92, Height=54
        loc_oPg3.AddObject("shp_4c_Shape7", "Shape")
        WITH loc_oPg3.shp_4c_Shape7
            .Top         = 274
            .Left        = 1
            .Width       = 92
            .Height      = 54
            .BorderColor = RGB(0, 0, 0)
            .BorderStyle = 1
            .FillColor   = RGB(230, 230, 230)
            .Visible     = .T.
        ENDWITH

        *-- TipoLeitura OptionGroup (Top=280, Left=-1, Width=80, ButtonCount=2)
        loc_oPg3.AddObject("obj_4c_TipoLeitura", "OptionGroup")
        WITH loc_oPg3.obj_4c_TipoLeitura
            .Value       = 1
            .ButtonCount = 2
            .Top         = 280
            .Left        = 0
            .Width       = 80
            .Height      = 42
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption   = "Qtd"
                .Left      = 0
                .Top       = 0
                .Width     = 80
                .Height    = 21
                .AutoSize  = .F.
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Cod.Barra"
                .Left      = 0
                .Top       = 21
                .Width     = 80
                .Height    = 21
                .AutoSize  = .F.
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Themes    = .F.
            ENDWITH
        ENDWITH

        *-- GradeLeitura (Top=136, Left=98, Width=641, Height=293)
        loc_oPg3.AddObject("grd_4c_Dados", "Grid")
        loc_oPg3.grd_4c_Dados.RecordSource = ""
        loc_oPg3.grd_4c_Dados.ColumnCount  = 8

        loc_oGrd = loc_oPg3.grd_4c_Dados
        WITH loc_oGrd
            .Top                = 136
            .Left               = 98
            .Width              = 641
            .Height             = 293
            .FontName           = "Tahoma"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(200, 200, 200)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 17
            .ScrollBars         = 3
            .GridLines          = 3
            .ReadOnly           = .T.
            .Visible            = .T.
            .Column1.Width      = 100
            .Column2.Width      = 90
            .Column3.Width      = 55
            .Column4.Width      = 70
            .Column5.Width      = 45
            .Column6.Width      = 45
            .Column7.Width      = 55
            .Column8.Width      = 75
            .Column1.ReadOnly   = .T.
            .Column2.ReadOnly   = .T.
            .Column3.ReadOnly   = .T.
            .Column4.ReadOnly   = .T.
            .Column5.ReadOnly   = .T.
            .Column6.ReadOnly   = .T.
            .Column7.ReadOnly   = .T.
            .Column8.ReadOnly   = .T.
            .Column1.Header1.Caption = "C" + CHR(243) + "d. Barra"
            .Column2.Header1.Caption = "Produto"
            .Column3.Header1.Caption = "Qtd(1)"
            .Column4.Header1.Caption = "Local"
            .Column5.Header1.Caption = "Cor"
            .Column6.Header1.Caption = "Tam"
            .Column7.Header1.Caption = "Qtd(2)"
            .Column8.Header1.Caption = "Barra"
        ENDWITH

        *-- ShpFigura (area imagem): Top=139, Left=744, Width=247, Height=224
        loc_oPg3.AddObject("shp_4c_ShpFigura", "Shape")
        WITH loc_oPg3.shp_4c_ShpFigura
            .Top         = 139
            .Left        = 744
            .Width       = 247
            .Height      = 224
            .BorderColor = RGB(150, 150, 150)
            .BorderStyle = 1
            .FillColor   = RGB(200, 200, 200)
            .Visible     = .T.
        ENDWITH

        *-- Imagem do produto (Top=142, Left=747, Width=241, Height=217, visible=F)
        loc_oPg3.AddObject("img_4c_ImgJpg", "Image")
        WITH loc_oPg3.img_4c_ImgJpg
            .Picture  = ""
            .Top      = 142
            .Left     = 747
            .Width    = 241
            .Height   = 217
            .Visible  = .F.
            .Stretch  = 2
        ENDWITH

        *-- CheckBox RepeteObs (Top=12+29=41, Left=679)
        loc_oPg3.AddObject("chk_4c_Chk_RepeteObs", "CheckBox")
        WITH loc_oPg3.chk_4c_Chk_RepeteObs
            .Caption   = "Repete Obs"
            .Value     = 0
            .Top       = 41
            .Left      = 679
            .Width     = 95
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        *-- PAINEL INFERIOR: campos de informacao do produto lido
        *-- Say17: "Lidos :" (Top=435, Left=418, Width=33)
        loc_oPg3.AddObject("lbl_4c_Label17", "Label")
        WITH loc_oPg3.lbl_4c_Label17
            .Caption   = "Lidos :"
            .Top       = 435
            .Left      = 418
            .Width     = 33
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg3.AddObject("txt_4c_Lidos", "TextBox")
        WITH loc_oPg3.txt_4c_Lidos
            .Value     = 0
            .Top       = 431
            .Left      = 453
            .Width     = 81
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(240, 240, 240)
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Say16: "Qtde :" (Top=435, Left=555, Width=37)
        loc_oPg3.AddObject("lbl_4c_Label16", "Label")
        WITH loc_oPg3.lbl_4c_Label16
            .Caption   = "Qtde :"
            .Top       = 435
            .Left      = 555
            .Width     = 37
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg3.AddObject("txt_4c_Qtde", "TextBox")
        WITH loc_oPg3.txt_4c_Qtde
            .Value     = 0
            .Top       = 431
            .Left      = 598
            .Width     = 81
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(240, 240, 240)
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Say11: "Conta :" (Top=461, Left=70, Width=38)
        loc_oPg3.AddObject("lbl_4c_Label11", "Label")
        WITH loc_oPg3.lbl_4c_Label11
            .Caption   = "Conta :"
            .Top       = 461
            .Left      = 70
            .Width     = 38
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg3.AddObject("txt_4c_Estoque", "TextBox")
        WITH loc_oPg3.txt_4c_Estoque
            .Value     = ""
            .Top       = 457
            .Left      = 112
            .Width     = 95
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(240, 240, 240)
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Say1: "Local :" (Top=461, Left=253, Width=33)
        loc_oPg3.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPg3.lbl_4c_Label1
            .Caption   = "Local :"
            .Top       = 461
            .Left      = 253
            .Width     = 33
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg3.AddObject("txt_4c_Local", "TextBox")
        WITH loc_oPg3.txt_4c_Local
            .Value     = ""
            .Top       = 457
            .Left      = 289
            .Width     = 91
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(240, 240, 240)
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Say8: "Total :" (Top=461, Left=392, Width=33)
        loc_oPg3.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPg3.lbl_4c_Label8
            .Caption   = "Total :"
            .Top       = 461
            .Left      = 392
            .Width     = 33
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg3.AddObject("txt_4c_Total", "TextBox")
        WITH loc_oPg3.txt_4c_Total
            .Value     = 0
            .Top       = 457
            .Left      = 427
            .Width     = 81
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(240, 240, 240)
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Say2: "Ocorrencia :" (Top=464, Left=558, Width=61)
        loc_oPg3.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPg3.lbl_4c_Label2
            .Caption   = "Ocorr" + CHR(234) + "ncia :"
            .Top       = 464
            .Left      = 558
            .Width     = 61
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg3.AddObject("txt_4c_Ocorr", "TextBox")
        WITH loc_oPg3.txt_4c_Ocorr
            .Value     = ""
            .Top       = 460
            .Left      = 625
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(240, 240, 240)
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Say4: "Produto :" (Top=487, Left=61, Width=47)
        loc_oPg3.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPg3.lbl_4c_Label4
            .Caption   = "Produto :"
            .Top       = 487
            .Left      = 61
            .Width     = 47
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg3.AddObject("txt_4c_Prod", "TextBox")
        WITH loc_oPg3.txt_4c_Prod
            .Value     = ""
            .Top       = 483
            .Left      = 112
            .Width     = 108
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(240, 240, 240)
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Say_CorTam: "Cor/Tam :" (Top=487, Left=236, Width=50)
        loc_oPg3.AddObject("lbl_4c__CorTam", "Label")
        WITH loc_oPg3.lbl_4c__CorTam
            .Caption   = "Cor/Tam :"
            .Top       = 487
            .Left      = 236
            .Width     = 50
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg3.AddObject("txt_4c_Cor", "TextBox")
        WITH loc_oPg3.txt_4c_Cor
            .Value     = ""
            .Top       = 483
            .Left      = 289
            .Width     = 38
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(240, 240, 240)
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *-- say_Barra: "/" (Top=486, Left=334, Width=4)
        loc_oPg3.AddObject("lbl_4c_Say_Barra", "Label")
        WITH loc_oPg3.lbl_4c_Say_Barra
            .Caption   = "/"
            .Top       = 486
            .Left      = 334
            .Width     = 4
            .Height    = 17
            .AutoSize  = .F.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg3.AddObject("txt_4c_Tam", "TextBox")
        WITH loc_oPg3.txt_4c_Tam
            .Value     = ""
            .Top       = 483
            .Left      = 342
            .Width     = 38
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(240, 240, 240)
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Say5: "Qtde :" (Top=487, Left=393, Width=33)
        loc_oPg3.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPg3.lbl_4c_Label5
            .Caption   = "Qtde :"
            .Top       = 487
            .Left      = 393
            .Width     = 33
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Get_Qtd: quantidade principal (Top=483, Left=427, Width=81)
        loc_oPg3.AddObject("txt_4c_Qtd", "TextBox")
        WITH loc_oPg3.txt_4c_Qtd
            .Value         = 0
            .Top           = 483
            .Left          = 427
            .Width         = 81
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Format        = "K"
            .Visible       = .T.
        ENDWITH

        *-- Unidade label (Top=486, Left=509, Width=20)
        loc_oPg3.AddObject("lbl_4c_Unidade", "Label")
        WITH loc_oPg3.lbl_4c_Unidade
            .Caption   = "Un"
            .Top       = 486
            .Left      = 509
            .Width     = 20
            .Height    = 17
            .AutoSize  = .F.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Say3: "Peso Real :" (Top=489, Left=564, Width=56)
        loc_oPg3.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPg3.lbl_4c_Label3
            .Caption   = "Peso Real :"
            .Top       = 489
            .Left      = 564
            .Width     = 56
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg3.AddObject("txt_4c_PReal", "TextBox")
        WITH loc_oPg3.txt_4c_PReal
            .Value     = 0
            .Top       = 485
            .Left      = 625
            .Width     = 61
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(240, 240, 240)
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Say13: "Linha :" (Top=511, Left=74, Width=34)
        loc_oPg3.AddObject("lbl_4c_Label13", "Label")
        WITH loc_oPg3.lbl_4c_Label13
            .Caption   = "Linha :"
            .Top       = 511
            .Left      = 74
            .Width     = 34
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg3.AddObject("txt_4c_Linha", "TextBox")
        WITH loc_oPg3.txt_4c_Linha
            .Value     = ""
            .Top       = 508
            .Left      = 112
            .Width     = 253
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(240, 240, 240)
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Say15: "Qtde :" (Top=511, Left=393, Width=33)
        loc_oPg3.AddObject("lbl_4c_Label15", "Label")
        WITH loc_oPg3.lbl_4c_Label15
            .Caption   = "Qtde :"
            .Top       = 511
            .Left      = 393
            .Width     = 33
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Get_Qtd2: quantidade secundaria (Top=508, Left=427, Width=81)
        loc_oPg3.AddObject("txt_4c_Qtd2", "TextBox")
        WITH loc_oPg3.txt_4c_Qtd2
            .Value         = 0
            .Top           = 508
            .Left          = 427
            .Width         = 81
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Format        = "K"
            .Visible       = .T.
        ENDWITH

        *-- UnidadeP label (Top=510, Left=508, Width=20)
        loc_oPg3.AddObject("lbl_4c_UnidadeP", "Label")
        WITH loc_oPg3.lbl_4c_UnidadeP
            .Caption   = "Un"
            .Top       = 510
            .Left      = 508
            .Width     = 20
            .Height    = 17
            .AutoSize  = .F.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Say10: "Descricao :" (Top=537, Left=53, Width=55)
        loc_oPg3.AddObject("lbl_4c_Label10", "Label")
        WITH loc_oPg3.lbl_4c_Label10
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 537
            .Left      = 53
            .Width     = 55
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg3.AddObject("txt_4c_Descr", "TextBox")
        WITH loc_oPg3.txt_4c_Descr
            .Value     = ""
            .Top       = 533
            .Left      = 112
            .Width     = 396
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(240, 240, 240)
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Say14: "Ref. Forn.:" (Top=563, Left=52, Width=56)
        loc_oPg3.AddObject("lbl_4c_Label14", "Label")
        WITH loc_oPg3.lbl_4c_Label14
            .Caption   = "Ref. Forn.:"
            .Top       = 563
            .Left      = 52
            .Width     = 56
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg3.AddObject("txt_4c_Reffs", "TextBox")
        WITH loc_oPg3.txt_4c_Reffs
            .Value     = ""
            .Top       = 559
            .Left      = 112
            .Width     = 150
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(240, 240, 240)
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Say7: "Cor Padrao :" (Top=563, Left=393, Width=63)
        loc_oPg3.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPg3.lbl_4c_Label7
            .Caption   = "Cor Padr" + CHR(227) + "o :"
            .Top       = 563
            .Left      = 393
            .Width     = 63
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg3.AddObject("txt_4c_CodCor", "TextBox")
        WITH loc_oPg3.txt_4c_CodCor
            .Value     = ""
            .Top       = 559
            .Left      = 470
            .Width     = 38
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(240, 240, 240)
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Say6: "Ultima Leitura :" (Top=589, Left=34, Width=74)
        loc_oPg3.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPg3.lbl_4c_Label6
            .Caption   = CHR(218) + "ltima Leitura :"
            .Top       = 589
            .Left      = 34
            .Width     = 74
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg3.AddObject("txt_4c_Ultima", "TextBox")
        WITH loc_oPg3.txt_4c_Ultima
            .Value     = ""
            .Top       = 585
            .Left      = 112
            .Width     = 396
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(240, 240, 240)
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Shape1 (painel info produto): Top=428+29=457
        loc_oPg3.AddObject("shp_4c_Shape1", "Shape")
        WITH loc_oPg3.shp_4c_Shape1
            .Top         = 457
            .Left        = 533
            .Width       = 195
            .Height      = 54
            .BorderColor = RGB(150, 150, 150)
            .BorderStyle = 1
            .FillColor   = RGB(200, 200, 200)
            .Visible     = .T.
        ENDWITH

        *-- obs leitura (EditBox, Top=513, Left=533, Width=456, Height=95)
        loc_oPg3.AddObject("obj_4c_Get_Obs", "EditBox")
        WITH loc_oPg3.obj_4c_Get_Obs
            .Value         = ""
            .Top           = 513
            .Left          = 533
            .Width         = 456
            .Height        = 95
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .ScrollBars    = 2
            .Visible       = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPg3)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega inventarios da empresa no grid da Page1
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                CREATE CURSOR cursor_4c_Dados (codigos N(4,0), cidchaves C(20), dtbases D, ;
                    datainis D, datafims D, encerras L, grupos C(10), contas C(10), usuars C(10))
                loc_lResultado = .T.
            ELSE
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                IF !THIS.this_oBusinessObject.Buscar("")
                    loc_lResultado = .F.
                ELSE
                    loc_oGrid.ColumnCount = 8
                    loc_oGrid.RecordSource              = "cursor_4c_Dados"
                    loc_oGrid.Column1.ControlSource     = "cursor_4c_Dados.codigos"
                    loc_oGrid.Column2.ControlSource     = "cursor_4c_Dados.dtbases"
                    loc_oGrid.Column3.ControlSource     = "cursor_4c_Dados.datainis"
                    loc_oGrid.Column4.ControlSource     = "cursor_4c_Dados.datafims"
                    loc_oGrid.Column5.ControlSource     = "cursor_4c_Dados.encerras"
                    loc_oGrid.Column6.ControlSource     = "cursor_4c_Dados.grupos"
                    loc_oGrid.Column7.ControlSource     = "cursor_4c_Dados.contas"
                    loc_oGrid.Column8.ControlSource     = "cursor_4c_Dados.usuars"
                    loc_oGrid.Refresh()
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre as paginas (1=Lista, 2=Dados, 3=Leitura)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.AlternarPagina")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere campos da Page2 (Dados) para o BO
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        LOCAL loc_oPg2, loc_oBO
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oBO  = THIS.this_oBusinessObject

        TRY
            WITH loc_oBO
                .this_dDtbases    = loc_oPg2.txt_4c_DBase.Value
                .this_cGrupos     = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)
                .this_cContas     = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)
                .this_dDatafims   = loc_oPg2.txt_4c_DataFinal.Value
                .this_dDatainis   = loc_oPg2.txt_4c_DataInicial.Value
                .this_cCprosi     = ALLTRIM(loc_oPg2.txt_4c_CProsI.Value)
                .this_cCprosf     = ALLTRIM(loc_oPg2.txt_4c_CProsF.Value)
                .this_cLocalis    = ALLTRIM(loc_oPg2.txt_4c_LocalInicial.Value)
                .this_cLocalfs    = ALLTRIM(loc_oPg2.txt_4c_LocalFinal.Value)
                .this_cIforis     = ALLTRIM(loc_oPg2.txt_4c_FornecInicial.Value)
                .this_cIforfs     = ALLTRIM(loc_oPg2.txt_4c_FornecFinal.Value)
                .this_cCggruis    = ALLTRIM(loc_oPg2.txt_4c_GGrupoInicial.Value)
                .this_cCggrufs    = ALLTRIM(loc_oPg2.txt_4c_GGrupoFinal.Value)
                .this_cCgruis     = ALLTRIM(loc_oPg2.txt_4c_GrupoInicial.Value)
                .this_cCgrufs     = ALLTRIM(loc_oPg2.txt_4c_GrupoFinal.Value)
                .this_cSgrusi     = ALLTRIM(loc_oPg2.txt_4c_SGrusI.Value)
                .this_cSgrusf     = ALLTRIM(loc_oPg2.txt_4c_SGrusF.Value)
                .this_nPrecois    = loc_oPg2.txt_4c_PrecoInicial.Value
                .this_nPrecofs    = loc_oPg2.txt_4c_PrecoFinal.Value
                .this_cColecoesi  = ALLTRIM(loc_oPg2.txt_4c_ColecoesI.Value)
                .this_cColecoesf  = ALLTRIM(loc_oPg2.txt_4c_ColecoesF.Value)
                .this_cCfinpsi    = ALLTRIM(loc_oPg2.txt_4c__UniIni.Value)
                .this_cCfinpsf    = ALLTRIM(loc_oPg2.txt_4c__UniFim.Value)
                .this_cObs        = ALLTRIM(loc_oPg2.obj_4c_GetObs.Value)
                .this_lTratas     = (loc_oPg2.chk_4c_Fwcheckbox2.Value = 1)
                .this_nSepestqs   = IIF(loc_oPg2.chk_4c_Fwcheckbox1.Value = 1, 1, 0)
                .this_nLeitgructa = IIF(loc_oPg2.chk_4c_Fwcheckbox3.Value = 1, 1, 0)
                .this_nAgrupas    = loc_oPg2.obj_4c_Opt_Agrupa.Value
                .this_nFilbarras  = loc_oPg2.obj_4c_OptFilBarra.Value - 1
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.FormParaBO")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere dados do BO para os campos da Page2 (Dados)
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_oBO
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oBO  = THIS.this_oBusinessObject

        TRY
            WITH loc_oBO
                loc_oPg2.txt_4c_Codigo.Value          = .this_nCodigos
                loc_oPg2.txt_4c_DBase.Value           = .this_dDtbases
                loc_oPg2.txt_4c_Grupo.Value           = ALLTRIM(.this_cGrupos)
                loc_oPg2.txt_4c_Conta.Value           = ALLTRIM(.this_cContas)
                loc_oPg2.txt_4c_DataFinal.Value       = .this_dDatafims
                loc_oPg2.txt_4c_DataInicial.Value     = .this_dDatainis
                loc_oPg2.txt_4c_CProsI.Value          = ALLTRIM(.this_cCprosi)
                loc_oPg2.txt_4c_CProsF.Value          = ALLTRIM(.this_cCprosf)
                loc_oPg2.txt_4c_LocalInicial.Value    = ALLTRIM(.this_cLocalis)
                loc_oPg2.txt_4c_LocalFinal.Value      = ALLTRIM(.this_cLocalfs)
                loc_oPg2.txt_4c_FornecInicial.Value   = ALLTRIM(.this_cIforis)
                loc_oPg2.txt_4c_FornecFinal.Value     = ALLTRIM(.this_cIforfs)
                loc_oPg2.txt_4c_GGrupoInicial.Value   = ALLTRIM(.this_cCggruis)
                loc_oPg2.txt_4c_GGrupoFinal.Value     = ALLTRIM(.this_cCggrufs)
                loc_oPg2.txt_4c_GrupoInicial.Value    = ALLTRIM(.this_cCgruis)
                loc_oPg2.txt_4c_GrupoFinal.Value      = ALLTRIM(.this_cCgrufs)
                loc_oPg2.txt_4c_SGrusI.Value          = ALLTRIM(.this_cSgrusi)
                loc_oPg2.txt_4c_SGrusF.Value          = ALLTRIM(.this_cSgrusf)
                loc_oPg2.txt_4c_PrecoInicial.Value    = .this_nPrecois
                loc_oPg2.txt_4c_PrecoFinal.Value      = .this_nPrecofs
                loc_oPg2.txt_4c_Lin.Value             = ""
                loc_oPg2.txt_4c_Lin2.Value            = ""
                loc_oPg2.txt_4c__UniIni.Value         = ALLTRIM(.this_cCfinpsi)
                loc_oPg2.txt_4c__UniFim.Value         = ALLTRIM(.this_cCfinpsf)
                loc_oPg2.txt_4c_ColecoesI.Value       = ALLTRIM(.this_cColecoesi)
                loc_oPg2.txt_4c_ColecoesF.Value       = ALLTRIM(.this_cColecoesf)
                loc_oPg2.obj_4c_GetObs.Value          = ALLTRIM(.this_cObs)
                loc_oPg2.chk_4c_Fwcheckbox2.Value    = .this_lTratas
                loc_oPg2.chk_4c_Fwcheckbox1.Value    = IIF(.this_nSepestqs = 1, 1, 0)
                loc_oPg2.chk_4c_Fwcheckbox3.Value    = IIF(.this_nLeitgructa = 1, 1, 0)
                loc_oPg2.obj_4c_Opt_Agrupa.Value      = IIF(.this_nAgrupas > 0, .this_nAgrupas, 1)
                loc_oPg2.obj_4c_OptFilBarra.Value     = IIF(.this_nFilbarras >= 0, .this_nFilbarras + 1, 1)
            ENDWITH

            THIS.CarregarDescricaoGrupo()
            THIS.CarregarDescricaoConta()
            THIS.CarregarGrades()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDescricaoGrupo - Preenche txt_4c_DGrupo com descricao do grupo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDescricaoGrupo()
        LOCAL loc_cGrupo, loc_cSQL, loc_nRes, loc_cDesc
        loc_cGrupo = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value)
        loc_cDesc  = ""

        TRY
            IF !EMPTY(loc_cGrupo)
                loc_cSQL = "SELECT TOP 1 descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cGrupo)
                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescGrp")
                IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_DescGrp") > 0
                    SELECT cursor_4c_DescGrp
                    loc_cDesc = ALLTRIM(cursor_4c_DescGrp.descrs)
                ENDIF
                IF USED("cursor_4c_DescGrp")
                    USE IN cursor_4c_DescGrp
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.CarregarDescricaoGrupo")
        ENDTRY

        THIS.pgf_4c_Paginas.Page2.txt_4c_DGrupo.Value = loc_cDesc
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDescricaoConta - Preenche txt_4c_DConta com descricao da conta
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDescricaoConta()
        LOCAL loc_cConta, loc_cSQL, loc_nRes, loc_cDesc
        loc_cConta = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Conta.Value)
        loc_cDesc  = ""

        TRY
            IF !EMPTY(loc_cConta)
                loc_cSQL = "SELECT TOP 1 DNoms FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cConta)
                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescCta")
                IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_DescCta") > 0
                    SELECT cursor_4c_DescCta
                    loc_cDesc = ALLTRIM(cursor_4c_DescCta.DNoms)
                ENDIF
                IF USED("cursor_4c_DescCta")
                    USE IN cursor_4c_DescCta
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.CarregarDescricaoConta")
        ENDTRY

        THIS.pgf_4c_Paginas.Page2.txt_4c_DConta.Value = loc_cDesc
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGrades - Carrega grdGGrupo (Grandes Grupos) e grd_4c_Grupos
    *--------------------------------------------------------------------------
    PROCEDURE CarregarGrades()
        LOCAL loc_cSQL, loc_nRes, loc_cMfilggrp, loc_cMfilgrupo
        loc_cMfilggrp  = ALLTRIM(THIS.this_oBusinessObject.this_cMfilggrp)
        loc_cMfilgrupo = ALLTRIM(THIS.this_oBusinessObject.this_cMfilgrupo)

        TRY
            *-- Carregar Grandes Grupos (SigCdGpr)
            IF USED("cursor_4c_GGruposTemp")
                USE IN cursor_4c_GGruposTemp
            ENDIF

            loc_cSQL = "SELECT 0 AS nMarcas, codigos AS GGrupos, descs AS Descricaos" + ;
                       " FROM SigCdGpr ORDER BY codigos"
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GGruposTemp")

            IF loc_nRes >= 0
                *-- Restaurar marcacoes salvas (formato: "cod1,cod2,cod3")
                IF !EMPTY(loc_cMfilggrp)
                    SELECT cursor_4c_GGruposTemp
                    SCAN
                        IF "," + ALLTRIM(cursor_4c_GGruposTemp.GGrupos) + "," $ "," + loc_cMfilggrp + ","
                            REPLACE nMarcas WITH 1 IN cursor_4c_GGruposTemp
                        ENDIF
                        SELECT cursor_4c_GGruposTemp
                    ENDSCAN
                ENDIF

                IF USED("cursor_4c_GGrupos")
                    SELECT cursor_4c_GGrupos
                    ZAP
                    APPEND FROM DBF("cursor_4c_GGruposTemp")
                    GO TOP
                    THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.Refresh()
                ELSE
                    SELECT * FROM cursor_4c_GGruposTemp INTO CURSOR cursor_4c_GGrupos READWRITE
                    THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.ColumnCount = 3
                    THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.RecordSource              = "cursor_4c_GGrupos"
                    THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.Column1.ControlSource     = "cursor_4c_GGrupos.nMarcas"
                    THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.Column2.ControlSource     = "cursor_4c_GGrupos.GGrupos"
                    THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.Column3.ControlSource     = "cursor_4c_GGrupos.Descricaos"
                    THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.Column1.Header1.Caption   = ""
                    THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.Column2.Header1.Caption   = ""
                    THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.Column3.Header1.Caption   = ""
                    THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.Refresh()
                ENDIF

                IF USED("cursor_4c_GGruposTemp")
                    USE IN cursor_4c_GGruposTemp
                ENDIF
            ENDIF

            *-- Carregar Grupos Produto (SigCdGrp)
            IF USED("cursor_4c_GruposProdTemp")
                USE IN cursor_4c_GruposProdTemp
            ENDIF

            loc_cSQL = "SELECT 0 AS nMarcas, cgrus AS Codigos, descs AS Descricaos" + ;
                       " FROM SigCdGrp ORDER BY cgrus"
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruposProdTemp")

            IF loc_nRes >= 0
                *-- Restaurar marcacoes salvas
                IF !EMPTY(loc_cMfilgrupo)
                    SELECT cursor_4c_GruposProdTemp
                    SCAN
                        IF "," + ALLTRIM(cursor_4c_GruposProdTemp.Codigos) + "," $ "," + loc_cMfilgrupo + ","
                            REPLACE nMarcas WITH 1 IN cursor_4c_GruposProdTemp
                        ENDIF
                        SELECT cursor_4c_GruposProdTemp
                    ENDSCAN
                ENDIF

                IF USED("cursor_4c_GruposProd")
                    SELECT cursor_4c_GruposProd
                    ZAP
                    APPEND FROM DBF("cursor_4c_GruposProdTemp")
                    GO TOP
                    THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.Refresh()
                ELSE
                    SELECT * FROM cursor_4c_GruposProdTemp INTO CURSOR cursor_4c_GruposProd READWRITE
                    THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.ColumnCount = 3
                    THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.RecordSource              = "cursor_4c_GruposProd"
                    THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.Column1.ControlSource     = "cursor_4c_GruposProd.nMarcas"
                    THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.Column2.ControlSource     = "cursor_4c_GruposProd.Codigos"
                    THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.Column3.ControlSource     = "cursor_4c_GruposProd.Descricaos"
                    THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.Column1.Header1.Caption   = ""
                    THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.Column2.Header1.Caption   = ""
                    THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.Column3.Header1.Caption   = ""
                    THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.Refresh()
                ENDIF

                IF USED("cursor_4c_GruposProdTemp")
                    USE IN cursor_4c_GruposProdTemp
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.CarregarGrades")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMfilGGrupo - Gera string CSV de grandes grupos marcados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterMfilGGrupo()
        LOCAL loc_cLista
        loc_cLista = ""

        TRY
            IF USED("cursor_4c_GGrupos")
                SELECT cursor_4c_GGrupos
                SCAN
                    IF cursor_4c_GGrupos.nMarcas = 1
                        loc_cLista = loc_cLista + IIF(EMPTY(loc_cLista), "", ",") + ALLTRIM(cursor_4c_GGrupos.GGrupos)
                    ENDIF
                    SELECT cursor_4c_GGrupos
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.ObterMfilGGrupo")
        ENDTRY

        RETURN loc_cLista
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMfilGrupo - Gera string CSV de grupos produto marcados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterMfilGrupo()
        LOCAL loc_cLista
        loc_cLista = ""

        TRY
            IF USED("cursor_4c_GruposProd")
                SELECT cursor_4c_GruposProd
                SCAN
                    IF cursor_4c_GruposProd.nMarcas = 1
                        loc_cLista = loc_cLista + IIF(EMPTY(loc_cLista), "", ",") + ALLTRIM(cursor_4c_GruposProd.Codigos)
                    ENDIF
                    SELECT cursor_4c_GruposProd
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.ObterMfilGrupo")
        ENDTRY

        RETURN loc_cLista
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGradeLeitura - Carrega historico de leituras do inventario
    *--------------------------------------------------------------------------
    PROCEDURE CarregarGradeLeitura()
        LOCAL loc_cSQL, loc_nRes, loc_nCodigos, loc_cEmps, loc_oGrd
        loc_nCodigos = THIS.this_oBusinessObject.this_nCodigos
        loc_cEmps    = ALLTRIM(THIS.this_oBusinessObject.this_cEmps)
        loc_oGrd     = THIS.pgf_4c_Paginas.Page3.grd_4c_Dados

        TRY
            IF USED("cursor_4c_HistoricoTemp")
                USE IN cursor_4c_HistoricoTemp
            ENDIF

            loc_cSQL = "SELECT a.cbars, a.cpros, a.qtds AS Qtds, a.localis, a.codcors," + ;
                       " a.codtams, a.pesreals AS Qtds2, ISNULL(b.cbars_old, 0) AS BarsOld" + ;
                       " FROM SigIvTrH a" + ;
                       " LEFT JOIN SigOpEta b ON a.cbars = b.cbars_new" + ;
                       " WHERE a.emps = " + EscaparSQL(loc_cEmps) + ;
                       " AND a.codigos = " + FormatarNumeroSQL(loc_nCodigos) + ;
                       " ORDER BY a.cidchaves"

            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_HistoricoTemp")

            IF loc_nRes >= 0
                IF USED("cursor_4c_Historico")
                    SELECT cursor_4c_Historico
                    ZAP
                    APPEND FROM DBF("cursor_4c_HistoricoTemp")
                    GO TOP
                    loc_oGrd.Refresh()
                ELSE
                    SELECT * FROM cursor_4c_HistoricoTemp INTO CURSOR cursor_4c_Historico READWRITE
                    loc_oGrd.ColumnCount = 8
                    loc_oGrd.RecordSource          = "cursor_4c_Historico"
                    loc_oGrd.Column1.ControlSource = "cursor_4c_Historico.cbars"
                    loc_oGrd.Column2.ControlSource = "cursor_4c_Historico.cpros"
                    loc_oGrd.Column3.ControlSource = "cursor_4c_Historico.Qtds"
                    loc_oGrd.Column4.ControlSource = "cursor_4c_Historico.localis"
                    loc_oGrd.Column5.ControlSource = "cursor_4c_Historico.codcors"
                    loc_oGrd.Column6.ControlSource = "cursor_4c_Historico.codtams"
                    loc_oGrd.Column7.ControlSource = "cursor_4c_Historico.Qtds2"
                    loc_oGrd.Column8.ControlSource = "cursor_4c_Historico.BarsOld"
                    loc_oGrd.Column1.Header1.Caption = "C" + CHR(243) + "d. Barra"
                    loc_oGrd.Column2.Header1.Caption = "Produto"
                    loc_oGrd.Column3.Header1.Caption = "Qtd(1)"
                    loc_oGrd.Column4.Header1.Caption = "Local"
                    loc_oGrd.Column5.Header1.Caption = "Cor"
                    loc_oGrd.Column6.Header1.Caption = "Tam"
                    loc_oGrd.Column7.Header1.Caption = "Qtd(2)"
                    loc_oGrd.Column8.Header1.Caption = "Barra"
                    loc_oGrd.Refresh()
                ENDIF

                IF USED("cursor_4c_HistoricoTemp")
                    USE IN cursor_4c_HistoricoTemp
                ENDIF

                THIS.AtualizarTotalLeitura()
            ELSE
                MsgErro("Erro ao carregar leituras:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.CarregarGradeLeitura")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarTotalLeitura - Atualiza contadores de lidos e quantidade
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarTotalLeitura()
        LOCAL loc_nLidos, loc_nQtde, loc_cSQL, loc_nRes

        TRY
            IF USED("cursor_4c_Historico")
                SELECT COUNT(*) AS Lidos, SUM(Qtds) AS Qtde FROM cursor_4c_Historico ;
                    INTO CURSOR cursor_4c_Totais READWRITE

                IF USED("cursor_4c_Totais")
                    SELECT cursor_4c_Totais
                    loc_nLidos = IIF(ISNULL(cursor_4c_Totais.Lidos), 0, cursor_4c_Totais.Lidos)
                    loc_nQtde  = IIF(ISNULL(cursor_4c_Totais.Qtde),  0, cursor_4c_Totais.Qtde)
                    USE IN cursor_4c_Totais
                ENDIF

                THIS.pgf_4c_Paginas.Page3.txt_4c_Lidos.Value = loc_nLidos
                THIS.pgf_4c_Paginas.Page3.txt_4c_Qtde.Value  = loc_nQtde
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.AtualizarTotalLeitura")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarLeitura - Configura Page3 para o inventario selecionado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarLeitura()
        LOCAL loc_oPg3, loc_oBO
        loc_oPg3 = THIS.pgf_4c_Paginas.Page3
        loc_oBO  = THIS.this_oBusinessObject

        TRY
            loc_oPg3.txt_4c_Codigo.Value = loc_oBO.this_nCodigos
            loc_oPg3.txt_4c_Grupo.Value  = ALLTRIM(loc_oBO.this_cGrupos)
            loc_oPg3.txt_4c_Conta.Value  = ALLTRIM(loc_oBO.this_cContas)

            THIS.LimparCamposLeitura()
            THIS.CarregarGradeLeitura()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.InicializarLeitura")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCamposLeitura - Limpa campos de entrada da leitura
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCamposLeitura()
        LOCAL loc_oPg3
        loc_oPg3 = THIS.pgf_4c_Paginas.Page3

        TRY
            loc_oPg3.txt_4c_Prod.Value   = ""
            loc_oPg3.txt_4c_Descr.Value  = ""
            loc_oPg3.txt_4c_Cor.Value    = ""
            loc_oPg3.txt_4c_Tam.Value    = ""
            loc_oPg3.txt_4c_Qtd.Value    = 0
            loc_oPg3.txt_4c_Qtd2.Value   = 0
            loc_oPg3.txt_4c_Local.Value  = ""
            loc_oPg3.txt_4c_Total.Value  = 0
            loc_oPg3.txt_4c_Ocorr.Value  = ""
            loc_oPg3.txt_4c_PReal.Value  = 0
            loc_oPg3.txt_4c_Linha.Value  = ""
            loc_oPg3.txt_4c_Reffs.Value  = ""
            loc_oPg3.txt_4c_CodCor.Value = ""
            loc_oPg3.txt_4c_Ultima.Value = ""
            IF !loc_oPg3.chk_4c_Chk_RepeteObs.Value
                loc_oPg3.obj_4c_Get_Obs.Value = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.LimparCamposLeitura")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterCidchavesSelecionado - Retorna cidchaves do registro selecionado no grid
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterCidchavesSelecionado()
        LOCAL loc_cCidchaves
        loc_cCidchaves = ""

        TRY
            IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
                SELECT cursor_4c_Dados
                loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.ObterCidchavesSelecionado")
        ENDTRY

        RETURN loc_cCidchaves
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCamposDados - Habilita/desabilita campos da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCamposDados(par_lHabilitar)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oPg2.txt_4c_DBase.ReadOnly         = !par_lHabilitar
            loc_oPg2.txt_4c_Grupo.ReadOnly          = !par_lHabilitar
            loc_oPg2.txt_4c_Conta.ReadOnly          = !par_lHabilitar
            loc_oPg2.txt_4c_DataFinal.ReadOnly      = !par_lHabilitar
            loc_oPg2.txt_4c_DataInicial.ReadOnly    = !par_lHabilitar
            loc_oPg2.txt_4c_CProsI.ReadOnly         = !par_lHabilitar
            loc_oPg2.txt_4c_CProsF.ReadOnly         = !par_lHabilitar
            loc_oPg2.txt_4c_LocalInicial.ReadOnly   = !par_lHabilitar
            loc_oPg2.txt_4c_LocalFinal.ReadOnly     = !par_lHabilitar
            loc_oPg2.txt_4c_FornecInicial.ReadOnly  = !par_lHabilitar
            loc_oPg2.txt_4c_FornecFinal.ReadOnly    = !par_lHabilitar
            loc_oPg2.txt_4c_GGrupoInicial.ReadOnly  = !par_lHabilitar
            loc_oPg2.txt_4c_GGrupoFinal.ReadOnly    = !par_lHabilitar
            loc_oPg2.txt_4c_GrupoInicial.ReadOnly   = !par_lHabilitar
            loc_oPg2.txt_4c_GrupoFinal.ReadOnly     = !par_lHabilitar
            loc_oPg2.txt_4c_SGrusI.ReadOnly         = !par_lHabilitar
            loc_oPg2.txt_4c_SGrusF.ReadOnly         = !par_lHabilitar
            loc_oPg2.txt_4c_PrecoInicial.ReadOnly   = !par_lHabilitar
            loc_oPg2.txt_4c_PrecoFinal.ReadOnly     = !par_lHabilitar
            loc_oPg2.txt_4c_Lin.ReadOnly            = !par_lHabilitar
            loc_oPg2.txt_4c_Lin2.ReadOnly           = !par_lHabilitar
            loc_oPg2.txt_4c_ColecoesI.ReadOnly      = !par_lHabilitar
            loc_oPg2.txt_4c_ColecoesF.ReadOnly      = !par_lHabilitar
            loc_oPg2.txt_4c__UniIni.ReadOnly        = !par_lHabilitar
            loc_oPg2.txt_4c__UniFim.ReadOnly        = !par_lHabilitar
            loc_oPg2.txt_4c_ObsPes.ReadOnly         = !par_lHabilitar
            loc_oPg2.obj_4c_GetObs.ReadOnly         = !par_lHabilitar
            loc_oPg2.grd_4c_GGrupo.ReadOnly         = !par_lHabilitar
            loc_oPg2.grd_4c_Grupos.ReadOnly         = !par_lHabilitar
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.HabilitarCamposDados")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCamposDados - Limpa campos da Page2
    *--------------------------------------------------------------------------
    PROCEDURE LimparCamposDados()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oPg2.txt_4c_Codigo.Value          = 0
            loc_oPg2.txt_4c_DBase.Value           = {}
            loc_oPg2.txt_4c_Grupo.Value           = ""
            loc_oPg2.txt_4c_DGrupo.Value          = ""
            loc_oPg2.txt_4c_Conta.Value           = ""
            loc_oPg2.txt_4c_DConta.Value          = ""
            loc_oPg2.txt_4c_DataFinal.Value       = {}
            loc_oPg2.txt_4c_DataInicial.Value     = {}
            loc_oPg2.txt_4c_CProsI.Value          = ""
            loc_oPg2.txt_4c_CProsF.Value          = ""
            loc_oPg2.txt_4c_LocalInicial.Value    = ""
            loc_oPg2.txt_4c_LocalFinal.Value      = ""
            loc_oPg2.txt_4c_FornecInicial.Value   = ""
            loc_oPg2.txt_4c_FornecFinal.Value     = ""
            loc_oPg2.txt_4c_GGrupoInicial.Value   = ""
            loc_oPg2.txt_4c_GGrupoFinal.Value     = ""
            loc_oPg2.txt_4c_GrupoInicial.Value    = ""
            loc_oPg2.txt_4c_GrupoFinal.Value      = ""
            loc_oPg2.txt_4c_SGrusI.Value          = ""
            loc_oPg2.txt_4c_SGrusF.Value          = ""
            loc_oPg2.txt_4c_PrecoInicial.Value    = 0
            loc_oPg2.txt_4c_PrecoFinal.Value      = 0
            loc_oPg2.txt_4c_Lin.Value             = ""
            loc_oPg2.txt_4c_Lin2.Value            = ""
            loc_oPg2.txt_4c_ColecoesI.Value       = ""
            loc_oPg2.txt_4c_ColecoesF.Value       = ""
            loc_oPg2.txt_4c__UniIni.Value         = ""
            loc_oPg2.txt_4c__UniFim.Value         = ""
            loc_oPg2.txt_4c_ObsPes.Value          = ""
            loc_oPg2.obj_4c_GetObs.Value          = ""
            loc_oPg2.chk_4c_Fwcheckbox1.Value    = 0
            loc_oPg2.chk_4c_Fwcheckbox2.Value    = 0
            loc_oPg2.chk_4c_Fwcheckbox3.Value    = 0
            loc_oPg2.obj_4c_Opt_Agrupa.Value      = 1
            loc_oPg2.obj_4c_OptFilBarra.Value     = 1
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.LimparCamposDados")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HANDLERS CRUD - Page1
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnProcessoClick - Cria novo inventario (Incluir)
    *--------------------------------------------------------------------------
    PROCEDURE BtnProcessoClick()
        TRY
            THIS.this_oBusinessObject.this_lNovoRegistro = .T.
            THIS.LimparCamposDados()
            THIS.HabilitarCamposDados(.T.)
            THIS.CarregarGrades()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.txt_4c_DBase.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.BtnProcessoClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnFechaClick - Encerra inventario selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnFechaClick()
        LOCAL loc_cCidchaves, loc_lConfirma

        TRY
            loc_cCidchaves = THIS.ObterCidchavesSelecionado()
            IF EMPTY(loc_cCidchaves)
                MsgAviso("Selecione um invent" + CHR(225) + "rio para encerrar.", "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF

            IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
                MsgAviso("Erro ao carregar invent" + CHR(225) + "rio.", "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF

            IF THIS.this_oBusinessObject.this_lEncerras
                MsgAviso("Invent" + CHR(225) + "rio j" + CHR(225) + " est" + CHR(225) + " encerrado.", "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF

            loc_lConfirma = MsgConfirma("Deseja encerrar o Invent" + CHR(225) + "rio " + ;
                            TRANSFORM(THIS.this_oBusinessObject.this_nCodigos) + "?", ;
                            "Confirmar Encerramento")

            IF loc_lConfirma
                IF THIS.this_oBusinessObject.AtualizarEncerramento(.T., DATE())
                    MsgInfo("Invent" + CHR(225) + "rio encerrado com sucesso!", "Sucesso")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.BtnFechaClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnLeituraClick - Abre pagina de leitura para inventario selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnLeituraClick()
        LOCAL loc_cCidchaves

        TRY
            loc_cCidchaves = THIS.ObterCidchavesSelecionado()
            IF EMPTY(loc_cCidchaves)
                MsgAviso("Selecione um invent" + CHR(225) + "rio para iniciar a leitura.", "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF

            IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
                MsgAviso("Erro ao carregar invent" + CHR(225) + "rio.", "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF

            IF THIS.this_oBusinessObject.this_lEncerras
                MsgAviso("Invent" + CHR(225) + "rio encerrado. N" + CHR(227) + "o " + ;
                         CHR(233) + " poss" + CHR(237) + "vel realizar leituras.", "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF

            THIS.this_cModoAtual = "LEITURA"
            THIS.InicializarLeitura()
            THIS.AlternarPagina(3)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.BtnLeituraClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConsultaClick - Recarrega lista / aplica filtro
    *--------------------------------------------------------------------------
    PROCEDURE BtnConsultaClick()
        TRY
            THIS.CarregarLista()
            THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.BtnConsultaClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExportaClick - Exporta dados do inventario para Excel
    *--------------------------------------------------------------------------
    PROCEDURE BtnExportaClick()
        LOCAL loc_cCidchaves, loc_cArquivo

        TRY
            loc_cCidchaves = THIS.ObterCidchavesSelecionado()
            IF EMPTY(loc_cCidchaves)
                MsgAviso("Selecione um invent" + CHR(225) + "rio para exportar.", "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF

            IF !USED("cursor_4c_Dados")
                MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " dados para exportar.", "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF

            loc_cArquivo = GETFILE("XLS", "Exportar Invent" + CHR(225) + "rio", "Salvar", 0, "Exportar")
            IF !EMPTY(loc_cArquivo)
                COPY TO (loc_cArquivo) TYPE XL5
                MsgInfo("Arquivo exportado com sucesso!", "Exportar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.BtnExportaClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnInventarioClick - Imprime etiquetas do inventario selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnInventarioClick()
        LOCAL loc_cCidchaves

        TRY
            loc_cCidchaves = THIS.ObterCidchavesSelecionado()
            IF EMPTY(loc_cCidchaves)
                MsgAviso("Selecione um invent" + CHR(225) + "rio.", "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF

            MsgInfo("Fun" + CHR(231) + CHR(227) + "o de etiquetas em desenvolvimento.", "Informa" + CHR(231) + CHR(227) + "o")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.BtnInventarioClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        TRY
            THIS.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.BtnEncerrarClick")
        ENDTRY
    ENDPROC

    *-- Handlers de ordenacao na lista
    PROCEDURE BtnOrdenarPeriodoClick()
        TRY
            IF USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.BtnOrdenarPeriodoClick")
        ENDTRY
    ENDPROC

    PROCEDURE BtnOrdenarEstoqueClick()
        TRY
            THIS.CarregarLista()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.BtnOrdenarEstoqueClick")
        ENDTRY
    ENDPROC

    PROCEDURE BtnOrdenarLocalClick()
        TRY
            THIS.CarregarLista()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.BtnOrdenarLocalClick")
        ENDTRY
    ENDPROC

    PROCEDURE BtnOrdenarGrupoClick()
        TRY
            THIS.CarregarLista()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.BtnOrdenarGrupoClick")
        ENDTRY
    ENDPROC

    PROCEDURE BtnOrdenarGGrupoClick()
        TRY
            THIS.CarregarLista()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.BtnOrdenarGGrupoClick")
        ENDTRY
    ENDPROC

    PROCEDURE BtnOrdenarUsuarioClick()
        TRY
            THIS.CarregarLista()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.BtnOrdenarUsuarioClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HANDLERS - Page2 (Dados)
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnConfirmarClick - Salva parametros do inventario
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_lResultado, loc_cGrupos, loc_cContas

        TRY
            loc_cGrupos = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value)

            *-- Validar grupo de estoque (obrigatorio)
            IF EMPTY(loc_cGrupos)
                MsgAviso("Grupo de Estoque obrigat" + CHR(243) + "rio.", "Valida" + CHR(231) + CHR(227) + "o")
                THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.SetFocus()
                RETURN
            ENDIF

            IF !THIS.this_oBusinessObject.ValidarGrupoEstoque(loc_cGrupos)
                MsgAviso("Grupo de Estoque Inv" + CHR(225) + "lido!!!", "Valida" + CHR(231) + CHR(227) + "o")
                THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.SetFocus()
                RETURN
            ENDIF

            *-- Validar conta (opcional mas se preenchida deve ser valida)
            loc_cContas = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Conta.Value)
            IF !EMPTY(loc_cContas) AND !THIS.this_oBusinessObject.ValidarConta(loc_cContas)
                MsgAviso("Conta de Estoque Inv" + CHR(225) + "lida!!!", "Valida" + CHR(231) + CHR(227) + "o")
                THIS.pgf_4c_Paginas.Page2.txt_4c_Conta.SetFocus()
                RETURN
            ENDIF

            *-- Transferir campos para BO
            THIS.FormParaBO()

            *-- Salvar XML das grades de grupos
            THIS.this_oBusinessObject.this_cMfilggrp  = THIS.ObterMfilGGrupo()
            THIS.this_oBusinessObject.this_cMfilgrupo = THIS.ObterMfilGrupo()

            *-- Salvar registro
            loc_lResultado = THIS.this_oBusinessObject.Salvar()

            IF loc_lResultado
                MsgInfo("Invent" + CHR(225) + "rio salvo com sucesso!", "Sucesso")
                THIS.this_cModoAtual = "LISTA"
                THIS.CarregarLista()
                THIS.AlternarPagina(1)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.BtnConfirmarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela edicao e volta para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        TRY
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.BtnCancelarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSelecionarTodosGGrupoClick - Marca todos os grandes grupos
    *--------------------------------------------------------------------------
    PROCEDURE BtnSelecionarTodosGGrupoClick()
        TRY
            IF USED("cursor_4c_GGrupos")
                SELECT cursor_4c_GGrupos
                REPLACE ALL nMarcas WITH 1
                THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.BtnSelecionarTodosGGrupoClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnDesmarcarTodosGGrupoClick - Desmarca todos os grandes grupos
    *--------------------------------------------------------------------------
    PROCEDURE BtnDesmarcarTodosGGrupoClick()
        TRY
            IF USED("cursor_4c_GGrupos")
                SELECT cursor_4c_GGrupos
                REPLACE ALL nMarcas WITH 0
                THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.BtnDesmarcarTodosGGrupoClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSelecionarTodosGrupoClick - Marca todos os grupos de produto
    *--------------------------------------------------------------------------
    PROCEDURE BtnSelecionarTodosGrupoClick()
        TRY
            IF USED("cursor_4c_GruposProd")
                SELECT cursor_4c_GruposProd
                REPLACE ALL nMarcas WITH 1
                THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.BtnSelecionarTodosGrupoClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnDesmarcarTodosGrupoClick - Desmarca todos os grupos de produto
    *--------------------------------------------------------------------------
    PROCEDURE BtnDesmarcarTodosGrupoClick()
        TRY
            IF USED("cursor_4c_GruposProd")
                SELECT cursor_4c_GruposProd
                REPLACE ALL nMarcas WITH 0
                THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.BtnDesmarcarTodosGrupoClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HANDLERS - Page3 (Leitura)
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnGravarClick - Salva item de leitura em SigIvTrH
    *--------------------------------------------------------------------------
    PROCEDURE BtnGravarClick()
        LOCAL loc_cSQL, loc_nRes, loc_lSucesso
        LOCAL loc_cProd, loc_cCodCor, loc_cCodTam, loc_nQtd, loc_nQtd2
        LOCAL loc_cLocal, loc_cObs, loc_nLidos, loc_cEmps, loc_nCodigos
        loc_lSucesso = .F.

        TRY
            loc_cProd    = ALLTRIM(THIS.pgf_4c_Paginas.Page3.txt_4c_Prod.Value)
            loc_cCodCor  = ALLTRIM(THIS.pgf_4c_Paginas.Page3.txt_4c_Cor.Value)
            loc_cCodTam  = ALLTRIM(THIS.pgf_4c_Paginas.Page3.txt_4c_Tam.Value)
            loc_nQtd     = THIS.pgf_4c_Paginas.Page3.txt_4c_Qtd.Value
            loc_nQtd2    = THIS.pgf_4c_Paginas.Page3.txt_4c_Qtd2.Value
            loc_cLocal   = ALLTRIM(THIS.pgf_4c_Paginas.Page3.txt_4c_Local.Value)
            loc_cObs     = ALLTRIM(THIS.pgf_4c_Paginas.Page3.obj_4c_Get_Obs.Value)
            loc_cEmps    = ALLTRIM(THIS.this_oBusinessObject.this_cEmps)
            loc_nCodigos = THIS.this_oBusinessObject.this_nCodigos

            IF EMPTY(loc_cProd)
                MsgAviso("Produto n" + CHR(227) + "o informado.", "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF

            IF loc_nQtd <= 0
                MsgAviso("Quantidade deve ser maior que zero.", "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF

            *-- Gerar UUID para cidchaves da leitura
            LOCAL loc_cCidchaves, loc_nResUuid
            loc_cCidchaves = ""
            loc_nResUuid = SQLEXEC(gnConnHandle, "SELECT LEFT(NEWID(), 20) AS novo_uuid", "cursor_4c_UuidH")
            IF loc_nResUuid >= 0 AND RECCOUNT("cursor_4c_UuidH") > 0
                SELECT cursor_4c_UuidH
                loc_cCidchaves = ALLTRIM(cursor_4c_UuidH.novo_uuid)
            ENDIF
            IF USED("cursor_4c_UuidH")
                USE IN cursor_4c_UuidH
            ENDIF

            IF EMPTY(loc_cCidchaves)
                MsgErro("Erro ao gerar chave " + CHR(250) + "nica para leitura.", "Erro")
                RETURN
            ENDIF

            *-- Obter cbars do produto (codigo de barras)
            LOCAL loc_cCbars, loc_nResCb
            loc_cCbars = ""
            loc_nResCb = SQLEXEC(gnConnHandle, "SELECT TOP 1 cbars FROM SigCdPro WHERE cpros = " + ;
                         EscaparSQL(loc_cProd), "cursor_4c_CBars")
            IF loc_nResCb >= 0 AND RECCOUNT("cursor_4c_CBars") > 0
                SELECT cursor_4c_CBars
                loc_cCbars = ALLTRIM(cursor_4c_CBars.cbars)
            ENDIF
            IF USED("cursor_4c_CBars")
                USE IN cursor_4c_CBars
            ENDIF

            loc_cSQL = "INSERT INTO SigIvTrH (cidchaves, emps, codigos, cbars, cpros," + ;
                       " codcors, codtams, qtds, pesreals, localis, obs)" + ;
                       " VALUES (" + ;
                       EscaparSQL(loc_cCidchaves) + "," + ;
                       EscaparSQL(loc_cEmps) + "," + ;
                       FormatarNumeroSQL(loc_nCodigos) + "," + ;
                       EscaparSQL(loc_cCbars) + "," + ;
                       EscaparSQL(loc_cProd) + "," + ;
                       EscaparSQL(loc_cCodCor) + "," + ;
                       EscaparSQL(loc_cCodTam) + "," + ;
                       FormatarNumeroSQL(loc_nQtd) + "," + ;
                       FormatarNumeroSQL(loc_nQtd2) + "," + ;
                       EscaparSQL(loc_cLocal) + "," + ;
                       EscaparSQL(loc_cObs) + ;
                       ")"

            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRes >= 0
                loc_lSucesso = .T.
                THIS.LimparCamposLeitura()
                THIS.CarregarGradeLeitura()
            ELSE
                MsgErro("Erro ao gravar leitura:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.BtnGravarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelaClick - Cancela leitura e volta para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelaClick()
        TRY
            THIS.this_cModoAtual = "LISTA"
            THIS.CarregarLista()
            THIS.AlternarPagina(1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.BtnCancelaClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnTotalLocalClick - Mostra totais por local de armazenamento
    *--------------------------------------------------------------------------
    PROCEDURE BtnTotalLocalClick()
        LOCAL loc_cSQL, loc_nRes, loc_nCodigos, loc_cEmps

        TRY
            loc_nCodigos = THIS.this_oBusinessObject.this_nCodigos
            loc_cEmps    = ALLTRIM(THIS.this_oBusinessObject.this_cEmps)

            IF USED("cursor_4c_TotalLocal")
                USE IN cursor_4c_TotalLocal
            ENDIF

            loc_cSQL = "SELECT localis AS Local, COUNT(*) AS Qtde_Itens, SUM(qtds) AS Total_Qtd" + ;
                       " FROM SigIvTrH" + ;
                       " WHERE emps = " + EscaparSQL(loc_cEmps) + ;
                       " AND codigos = " + FormatarNumeroSQL(loc_nCodigos) + ;
                       " GROUP BY localis ORDER BY localis"

            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TotalLocal")
            IF loc_nRes >= 0
                MsgInfo("Consulta de totais por local conclu" + CHR(237) + "da.", "Total Local")
            ELSE
                MsgErro("Erro ao calcular totais:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.BtnTotalLocalClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnOcorrenciaClick - Registra ocorrencia
    *--------------------------------------------------------------------------
    PROCEDURE BtnOcorrenciaClick()
        TRY
            MsgInfo("Fun" + CHR(231) + CHR(227) + "o de Ocorr" + CHR(234) + "ncia em desenvolvimento.", "Informa" + CHR(231) + CHR(227) + "o")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.BtnOcorrenciaClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImagemClick - Exibe imagem do produto selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnImagemClick()
        LOCAL loc_cProd, loc_cSQL, loc_nRes, loc_cImagem, loc_oPg3
        loc_oPg3 = THIS.pgf_4c_Paginas.Page3

        TRY
            loc_cProd = ALLTRIM(loc_oPg3.txt_4c_Prod.Value)
            IF EMPTY(loc_cProd)
                RETURN
            ENDIF

            loc_cSQL = "SELECT TOP 1 imagem FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cProd)
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImgProd")
            IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_ImgProd") > 0
                SELECT cursor_4c_ImgProd
                loc_cImagem = ALLTRIM(cursor_4c_ImgProd.imagem)
                IF !EMPTY(loc_cImagem) AND FILE(loc_cImagem)
                    loc_oPg3.img_4c_ImgJpg.Picture = loc_cImagem
                    loc_oPg3.img_4c_ImgJpg.Visible = .T.
                ELSE
                    loc_oPg3.img_4c_ImgJpg.Visible = .F.
                ENDIF
            ENDIF
            IF USED("cursor_4c_ImgProd")
                USE IN cursor_4c_ImgProd
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.BtnImagemClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnLocalGravadoClick - Exibe ultimo local gravado
    *--------------------------------------------------------------------------
    PROCEDURE BtnLocalGravadoClick()
        LOCAL loc_cSQL, loc_nRes, loc_cEmps, loc_nCodigos

        TRY
            loc_cEmps    = ALLTRIM(THIS.this_oBusinessObject.this_cEmps)
            loc_nCodigos = THIS.this_oBusinessObject.this_nCodigos

            loc_cSQL = "SELECT TOP 1 localis FROM SigIvTrH" + ;
                       " WHERE emps = " + EscaparSQL(loc_cEmps) + ;
                       " AND codigos = " + FormatarNumeroSQL(loc_nCodigos) + ;
                       " ORDER BY cidchaves DESC"

            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UltLocal")
            IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_UltLocal") > 0
                SELECT cursor_4c_UltLocal
                THIS.pgf_4c_Paginas.Page3.txt_4c_Local.Value = ALLTRIM(cursor_4c_UltLocal.localis)
            ENDIF
            IF USED("cursor_4c_UltLocal")
                USE IN cursor_4c_UltLocal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.BtnLocalGravadoClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirLeituraClick - Exclui registro de leitura selecionado na grade
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirLeituraClick()
        LOCAL loc_cCidchaves, loc_cSQL, loc_nRes, loc_lConfirma

        TRY
            IF !USED("cursor_4c_Historico") OR RECCOUNT("cursor_4c_Historico") = 0
                MsgAviso("Selecione uma leitura para excluir.", "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF

            SELECT cursor_4c_Historico
            loc_cCidchaves = ALLTRIM(cursor_4c_Historico.cbars)

            loc_lConfirma = MsgConfirma("Deseja excluir esta leitura?", "Confirmar Exclus" + CHR(227) + "o")

            IF loc_lConfirma
                loc_cSQL = "DELETE FROM SigIvTrH WHERE cbars = " + EscaparSQL(loc_cCidchaves) + ;
                           " AND emps = " + EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cEmps)) + ;
                           " AND codigos = " + FormatarNumeroSQL(THIS.this_oBusinessObject.this_nCodigos)

                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nRes >= 0
                    THIS.CarregarGradeLeitura()
                ELSE
                    MsgErro("Erro ao excluir leitura:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.BtnExcluirLeituraClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HANDLERS DE LOOKUP (KeyPress F4)
    *==========================================================================

    PROCEDURE KeyPressGrupo(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oForm, loc_cValor

        IF par_nKeyCode = 115 OR par_nKeyCode = 13
            TRY
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
                    "SigCdGcr", "Codigos", "descrs", "Grupo de Estoque", ;
                    "", THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value)
                IF VARTYPE(loc_oForm) = "O"
                    loc_oForm.Show()
                    IF !EMPTY(loc_oForm.this_cValorSelecionado)
                        THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
                        THIS.CarregarDescricaoGrupo()
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "FormBAL.KeyPressGrupo")
            ENDTRY
            par_nKeyCode = 0
        ENDIF

        IF par_nKeyCode = 9 OR par_nKeyCode = 13
            KEYBOARD CHR(9)
        ENDIF
    ENDPROC

    PROCEDURE KeyPressConta(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oForm

        IF par_nKeyCode = 115 OR par_nKeyCode = 13
            TRY
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
                    "SigCdCli", "IClis", "DNoms", "Conta de Estoque", ;
                    "", THIS.pgf_4c_Paginas.Page2.txt_4c_Conta.Value)
                IF VARTYPE(loc_oForm) = "O"
                    loc_oForm.Show()
                    IF !EMPTY(loc_oForm.this_cValorSelecionado)
                        THIS.pgf_4c_Paginas.Page2.txt_4c_Conta.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
                        THIS.CarregarDescricaoConta()
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "FormBAL.KeyPressConta")
            ENDTRY
            par_nKeyCode = 0
        ENDIF

        IF par_nKeyCode = 9 OR par_nKeyCode = 13
            KEYBOARD CHR(9)
        ENDIF
    ENDPROC

    PROCEDURE KeyPressCProsI(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oForm

        IF par_nKeyCode = 115 OR par_nKeyCode = 13
            TRY
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
                    "SigCdPro", "cpros", "dpros", "Produto Inicial", ;
                    "", THIS.pgf_4c_Paginas.Page2.txt_4c_CProsI.Value)
                IF VARTYPE(loc_oForm) = "O"
                    loc_oForm.Show()
                    IF !EMPTY(loc_oForm.this_cValorSelecionado)
                        THIS.pgf_4c_Paginas.Page2.txt_4c_CProsI.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "FormBAL.KeyPressCProsI")
            ENDTRY
            par_nKeyCode = 0
        ENDIF

        IF par_nKeyCode = 9 OR par_nKeyCode = 13
            KEYBOARD CHR(9)
        ENDIF
    ENDPROC

    PROCEDURE KeyPressCProsF(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oForm

        IF par_nKeyCode = 115 OR par_nKeyCode = 13
            TRY
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
                    "SigCdPro", "cpros", "dpros", "Produto Final", ;
                    "", THIS.pgf_4c_Paginas.Page2.txt_4c_CProsF.Value)
                IF VARTYPE(loc_oForm) = "O"
                    loc_oForm.Show()
                    IF !EMPTY(loc_oForm.this_cValorSelecionado)
                        THIS.pgf_4c_Paginas.Page2.txt_4c_CProsF.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "FormBAL.KeyPressCProsF")
            ENDTRY
            par_nKeyCode = 0
        ENDIF

        IF par_nKeyCode = 9 OR par_nKeyCode = 13
            KEYBOARD CHR(9)
        ENDIF
    ENDPROC

    PROCEDURE KeyPressLocalInicial(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oForm

        IF par_nKeyCode = 115 OR par_nKeyCode = 13
            TRY
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
                    "SigPrLcl", "codigos", "descs", "Local Inicial", ;
                    "", THIS.pgf_4c_Paginas.Page2.txt_4c_LocalInicial.Value)
                IF VARTYPE(loc_oForm) = "O"
                    loc_oForm.Show()
                    IF !EMPTY(loc_oForm.this_cValorSelecionado)
                        THIS.pgf_4c_Paginas.Page2.txt_4c_LocalInicial.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "FormBAL.KeyPressLocalInicial")
            ENDTRY
            par_nKeyCode = 0
        ENDIF

        IF par_nKeyCode = 9 OR par_nKeyCode = 13
            KEYBOARD CHR(9)
        ENDIF
    ENDPROC

    PROCEDURE KeyPressLocalFinal(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oForm

        IF par_nKeyCode = 115 OR par_nKeyCode = 13
            TRY
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
                    "SigPrLcl", "codigos", "descs", "Local Final", ;
                    "", THIS.pgf_4c_Paginas.Page2.txt_4c_LocalFinal.Value)
                IF VARTYPE(loc_oForm) = "O"
                    loc_oForm.Show()
                    IF !EMPTY(loc_oForm.this_cValorSelecionado)
                        THIS.pgf_4c_Paginas.Page2.txt_4c_LocalFinal.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "FormBAL.KeyPressLocalFinal")
            ENDTRY
            par_nKeyCode = 0
        ENDIF

        IF par_nKeyCode = 9 OR par_nKeyCode = 13
            KEYBOARD CHR(9)
        ENDIF
    ENDPROC

    PROCEDURE KeyPressGGrupoInicial(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oForm

        IF par_nKeyCode = 115 OR par_nKeyCode = 13
            TRY
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
                    "SigCdGpr", "codigos", "descs", "Grande Grupo Inicial", ;
                    "", THIS.pgf_4c_Paginas.Page2.txt_4c_GGrupoInicial.Value)
                IF VARTYPE(loc_oForm) = "O"
                    loc_oForm.Show()
                    IF !EMPTY(loc_oForm.this_cValorSelecionado)
                        THIS.pgf_4c_Paginas.Page2.txt_4c_GGrupoInicial.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "FormBAL.KeyPressGGrupoInicial")
            ENDTRY
            par_nKeyCode = 0
        ENDIF

        IF par_nKeyCode = 9 OR par_nKeyCode = 13
            KEYBOARD CHR(9)
        ENDIF
    ENDPROC

    PROCEDURE KeyPressGGrupoFinal(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oForm

        IF par_nKeyCode = 115 OR par_nKeyCode = 13
            TRY
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
                    "SigCdGpr", "codigos", "descs", "Grande Grupo Final", ;
                    "", THIS.pgf_4c_Paginas.Page2.txt_4c_GGrupoFinal.Value)
                IF VARTYPE(loc_oForm) = "O"
                    loc_oForm.Show()
                    IF !EMPTY(loc_oForm.this_cValorSelecionado)
                        THIS.pgf_4c_Paginas.Page2.txt_4c_GGrupoFinal.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "FormBAL.KeyPressGGrupoFinal")
            ENDTRY
            par_nKeyCode = 0
        ENDIF

        IF par_nKeyCode = 9 OR par_nKeyCode = 13
            KEYBOARD CHR(9)
        ENDIF
    ENDPROC

    PROCEDURE KeyPressGrupoInicial(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oForm

        IF par_nKeyCode = 115 OR par_nKeyCode = 13
            TRY
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
                    "SigCdGrp", "cgrus", "descs", "Grupo Inicial", ;
                    "", THIS.pgf_4c_Paginas.Page2.txt_4c_GrupoInicial.Value)
                IF VARTYPE(loc_oForm) = "O"
                    loc_oForm.Show()
                    IF !EMPTY(loc_oForm.this_cValorSelecionado)
                        THIS.pgf_4c_Paginas.Page2.txt_4c_GrupoInicial.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "FormBAL.KeyPressGrupoInicial")
            ENDTRY
            par_nKeyCode = 0
        ENDIF

        IF par_nKeyCode = 9 OR par_nKeyCode = 13
            KEYBOARD CHR(9)
        ENDIF
    ENDPROC

    PROCEDURE KeyPressGrupoFinal(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oForm

        IF par_nKeyCode = 115 OR par_nKeyCode = 13
            TRY
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
                    "SigCdGrp", "cgrus", "descs", "Grupo Final", ;
                    "", THIS.pgf_4c_Paginas.Page2.txt_4c_GrupoFinal.Value)
                IF VARTYPE(loc_oForm) = "O"
                    loc_oForm.Show()
                    IF !EMPTY(loc_oForm.this_cValorSelecionado)
                        THIS.pgf_4c_Paginas.Page2.txt_4c_GrupoFinal.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "FormBAL.KeyPressGrupoFinal")
            ENDTRY
            par_nKeyCode = 0
        ENDIF

        IF par_nKeyCode = 9 OR par_nKeyCode = 13
            KEYBOARD CHR(9)
        ENDIF
    ENDPROC

    PROCEDURE KeyPressLin(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oForm

        IF par_nKeyCode = 115 OR par_nKeyCode = 13
            TRY
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
                    "SigCdLin", "Linhas", "descs", "Linha Inicial", ;
                    "", THIS.pgf_4c_Paginas.Page2.txt_4c_Lin.Value)
                IF VARTYPE(loc_oForm) = "O"
                    loc_oForm.Show()
                    IF !EMPTY(loc_oForm.this_cValorSelecionado)
                        THIS.pgf_4c_Paginas.Page2.txt_4c_Lin.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "FormBAL.KeyPressLin")
            ENDTRY
            par_nKeyCode = 0
        ENDIF

        IF par_nKeyCode = 9 OR par_nKeyCode = 13
            KEYBOARD CHR(9)
        ENDIF
    ENDPROC

    PROCEDURE KeyPressLin2(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oForm

        IF par_nKeyCode = 115 OR par_nKeyCode = 13
            TRY
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
                    "SigCdLin", "Linhas", "descs", "Linha Final", ;
                    "", THIS.pgf_4c_Paginas.Page2.txt_4c_Lin2.Value)
                IF VARTYPE(loc_oForm) = "O"
                    loc_oForm.Show()
                    IF !EMPTY(loc_oForm.this_cValorSelecionado)
                        THIS.pgf_4c_Paginas.Page2.txt_4c_Lin2.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "FormBAL.KeyPressLin2")
            ENDTRY
            par_nKeyCode = 0
        ENDIF

        IF par_nKeyCode = 9 OR par_nKeyCode = 13
            KEYBOARD CHR(9)
        ENDIF
    ENDPROC

    PROCEDURE KeyPressUniIni(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oForm

        IF par_nKeyCode = 115 OR par_nKeyCode = 13
            TRY
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
                    "SigCdUni", "Cunis", "descs", "Unidade Inicial", ;
                    "", THIS.pgf_4c_Paginas.Page2.txt_4c__UniIni.Value)
                IF VARTYPE(loc_oForm) = "O"
                    loc_oForm.Show()
                    IF !EMPTY(loc_oForm.this_cValorSelecionado)
                        THIS.pgf_4c_Paginas.Page2.txt_4c__UniIni.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "FormBAL.KeyPressUniIni")
            ENDTRY
            par_nKeyCode = 0
        ENDIF

        IF par_nKeyCode = 9 OR par_nKeyCode = 13
            KEYBOARD CHR(9)
        ENDIF
    ENDPROC

    PROCEDURE KeyPressUniFim(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oForm

        IF par_nKeyCode = 115 OR par_nKeyCode = 13
            TRY
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
                    "SigCdUni", "Cunis", "descs", "Unidade Final", ;
                    "", THIS.pgf_4c_Paginas.Page2.txt_4c__UniFim.Value)
                IF VARTYPE(loc_oForm) = "O"
                    loc_oForm.Show()
                    IF !EMPTY(loc_oForm.this_cValorSelecionado)
                        THIS.pgf_4c_Paginas.Page2.txt_4c__UniFim.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "FormBAL.KeyPressUniFim")
            ENDTRY
            par_nKeyCode = 0
        ENDIF

        IF par_nKeyCode = 9 OR par_nKeyCode = 13
            KEYBOARD CHR(9)
        ENDIF
    ENDPROC

    PROCEDURE KeyPressFornecInicial(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oForm

        IF par_nKeyCode = 115 OR par_nKeyCode = 13
            TRY
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
                    "SigCdCli", "Iclis", "Rclis", "Fornecedor Inicial", ;
                    "", THIS.pgf_4c_Paginas.Page2.txt_4c_FornecInicial.Value)
                IF VARTYPE(loc_oForm) = "O"
                    loc_oForm.Show()
                    IF !EMPTY(loc_oForm.this_cValorSelecionado)
                        THIS.pgf_4c_Paginas.Page2.txt_4c_FornecInicial.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "FormBAL.KeyPressFornecInicial")
            ENDTRY
            par_nKeyCode = 0
        ENDIF

        IF par_nKeyCode = 9 OR par_nKeyCode = 13
            KEYBOARD CHR(9)
        ENDIF
    ENDPROC

    PROCEDURE KeyPressFornecFinal(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oForm

        IF par_nKeyCode = 115 OR par_nKeyCode = 13
            TRY
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
                    "SigCdCli", "Iclis", "Rclis", "Fornecedor Final", ;
                    "", THIS.pgf_4c_Paginas.Page2.txt_4c_FornecFinal.Value)
                IF VARTYPE(loc_oForm) = "O"
                    loc_oForm.Show()
                    IF !EMPTY(loc_oForm.this_cValorSelecionado)
                        THIS.pgf_4c_Paginas.Page2.txt_4c_FornecFinal.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "FormBAL.KeyPressFornecFinal")
            ENDTRY
            par_nKeyCode = 0
        ENDIF

        IF par_nKeyCode = 9 OR par_nKeyCode = 13
            KEYBOARD CHR(9)
        ENDIF
    ENDPROC

    PROCEDURE KeyPressSGrusI(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oForm

        IF par_nKeyCode = 115 OR par_nKeyCode = 13
            TRY
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
                    "SigCdPsg", "Codigos", "Descricaos", "Sub-Grupo Inicial", ;
                    "", THIS.pgf_4c_Paginas.Page2.txt_4c_SGrusI.Value)
                IF VARTYPE(loc_oForm) = "O"
                    loc_oForm.Show()
                    IF !EMPTY(loc_oForm.this_cValorSelecionado)
                        THIS.pgf_4c_Paginas.Page2.txt_4c_SGrusI.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "FormBAL.KeyPressSGrusI")
            ENDTRY
            par_nKeyCode = 0
        ENDIF

        IF par_nKeyCode = 9 OR par_nKeyCode = 13
            KEYBOARD CHR(9)
        ENDIF
    ENDPROC

    PROCEDURE KeyPressSGrusF(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oForm

        IF par_nKeyCode = 115 OR par_nKeyCode = 13
            TRY
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
                    "SigCdPsg", "Codigos", "Descricaos", "Sub-Grupo Final", ;
                    "", THIS.pgf_4c_Paginas.Page2.txt_4c_SGrusF.Value)
                IF VARTYPE(loc_oForm) = "O"
                    loc_oForm.Show()
                    IF !EMPTY(loc_oForm.this_cValorSelecionado)
                        THIS.pgf_4c_Paginas.Page2.txt_4c_SGrusF.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "FormBAL.KeyPressSGrusF")
            ENDTRY
            par_nKeyCode = 0
        ENDIF

        IF par_nKeyCode = 9 OR par_nKeyCode = 13
            KEYBOARD CHR(9)
        ENDIF
    ENDPROC

    PROCEDURE KeyPressColecoesI(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oForm

        IF par_nKeyCode = 115 OR par_nKeyCode = 13
            TRY
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
                    "SigCdCol", "Colecoes", "Descs", "Cole" + CHR(231) + CHR(227) + "o Inicial", ;
                    "", THIS.pgf_4c_Paginas.Page2.txt_4c_ColecoesI.Value)
                IF VARTYPE(loc_oForm) = "O"
                    loc_oForm.Show()
                    IF !EMPTY(loc_oForm.this_cValorSelecionado)
                        THIS.pgf_4c_Paginas.Page2.txt_4c_ColecoesI.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "FormBAL.KeyPressColecoesI")
            ENDTRY
            par_nKeyCode = 0
        ENDIF

        IF par_nKeyCode = 9 OR par_nKeyCode = 13
            KEYBOARD CHR(9)
        ENDIF
    ENDPROC

    PROCEDURE KeyPressColecoesF(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oForm

        IF par_nKeyCode = 115 OR par_nKeyCode = 13
            TRY
                loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
                    "SigCdCol", "Colecoes", "Descs", "Cole" + CHR(231) + CHR(227) + "o Final", ;
                    "", THIS.pgf_4c_Paginas.Page2.txt_4c_ColecoesF.Value)
                IF VARTYPE(loc_oForm) = "O"
                    loc_oForm.Show()
                    IF !EMPTY(loc_oForm.this_cValorSelecionado)
                        THIS.pgf_4c_Paginas.Page2.txt_4c_ColecoesF.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "FormBAL.KeyPressColecoesF")
            ENDTRY
            par_nKeyCode = 0
        ENDIF

        IF par_nKeyCode = 9 OR par_nKeyCode = 13
            KEYBOARD CHR(9)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Cria novo inventario
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        TRY
            THIS.this_oBusinessObject.this_lNovoRegistro = .T.
            THIS.LimparCamposDados()
            THIS.HabilitarCamposDados(.T.)
            THIS.CarregarGrades()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.txt_4c_DBase.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.BtnIncluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Abre inventario selecionado para edicao
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCidchaves
        TRY
            loc_cCidchaves = THIS.ObterCidchavesSelecionado()
            IF EMPTY(loc_cCidchaves)
                MsgAviso("Selecione um invent" + CHR(225) + "rio para alterar.", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
                    MsgAviso("Erro ao carregar invent" + CHR(225) + "rio.", "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    THIS.this_oBusinessObject.this_lNovoRegistro = .F.
                    THIS.BOParaForm()
                    THIS.CarregarGrades()
                    THIS.HabilitarCamposDados(.T.)
                    THIS.this_cModoAtual = "ALTERAR"
                    THIS.AlternarPagina(2)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.BtnAlterarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Abre inventario selecionado em modo leitura
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCidchaves
        TRY
            loc_cCidchaves = THIS.ObterCidchavesSelecionado()
            IF EMPTY(loc_cCidchaves)
                MsgAviso("Selecione um invent" + CHR(225) + "rio para visualizar.", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
                    MsgAviso("Erro ao carregar invent" + CHR(225) + "rio.", "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    THIS.BOParaForm()
                    THIS.CarregarGrades()
                    THIS.HabilitarCamposDados(.F.)
                    THIS.this_cModoAtual = "VISUALIZAR"
                    THIS.AlternarPagina(2)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Exclui inventario selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCidchaves, loc_lConfirma
        TRY
            loc_cCidchaves = THIS.ObterCidchavesSelecionado()
            IF EMPTY(loc_cCidchaves)
                MsgAviso("Selecione um invent" + CHR(225) + "rio para excluir.", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
                    MsgAviso("Erro ao carregar invent" + CHR(225) + "rio.", "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    loc_lConfirma = MsgConfirma("Deseja excluir o Invent" + CHR(225) + "rio " + ;
                                    TRANSFORM(THIS.this_oBusinessObject.this_nCodigos) + "?", ;
                                    "Confirmar Exclus" + CHR(227) + "o")
                    IF loc_lConfirma
                        IF THIS.this_oBusinessObject.Excluir()
                            MsgInfo("Invent" + CHR(225) + "rio exclu" + CHR(237) + "do com sucesso!", "Sucesso")
                            THIS.CarregarLista()
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.BtnExcluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles do container visiveis
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL i, loc_oControl

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        FOR i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(i)
            IF INLIST(UPPER(loc_oControl.Name), "CNT_4C_CABECALHO", "CNT_4C_SAIDA")
                LOOP
            ENDIF
            loc_oControl.Visible = .T.
            IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                THIS.TornarControlesVisiveis(loc_oControl)
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF USED("cursor_4c_GGrupos")
                USE IN cursor_4c_GGrupos
            ENDIF
            IF USED("cursor_4c_GGruposTemp")
                USE IN cursor_4c_GGruposTemp
            ENDIF
            IF USED("cursor_4c_GruposProd")
                USE IN cursor_4c_GruposProd
            ENDIF
            IF USED("cursor_4c_GruposProdTemp")
                USE IN cursor_4c_GruposProdTemp
            ENDIF
            IF USED("cursor_4c_Historico")
                USE IN cursor_4c_Historico
            ENDIF
            IF USED("cursor_4c_HistoricoTemp")
                USE IN cursor_4c_HistoricoTemp
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.Destroy")
        ENDTRY

        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Habilita/desabilita botoes conforme modo atual
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lModoEdicao, loc_oPage1
        TRY
            loc_lModoEdicao = (THIS.this_cModoAtual = "NOVO" OR THIS.this_cModoAtual = "EDICAO")
            loc_oPage1 = THIS.pgf_4c_Paginas.Page1
            IF VARTYPE(loc_oPage1.cmd_4c_Incluir) = "O"
                loc_oPage1.cmd_4c_Incluir.Enabled = !loc_lModoEdicao
            ENDIF
            IF VARTYPE(loc_oPage1.cmd_4c_Alterar) = "O"
                loc_oPage1.cmd_4c_Alterar.Enabled = !loc_lModoEdicao
            ENDIF
            IF VARTYPE(loc_oPage1.cmd_4c_Excluir) = "O"
                loc_oPage1.cmd_4c_Excluir.Enabled = !loc_lModoEdicao
            ENDIF
            IF VARTYPE(loc_oPage1.cmd_4c_Visualizar) = "O"
                loc_oPage1.cmd_4c_Visualizar.Enabled = !loc_lModoEdicao
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormBAL.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Delega a HabilitarCamposDados
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        THIS.HabilitarCamposDados(par_lHabilitar)
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Delega a LimparCamposDados
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        THIS.LimparCamposDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Alias para BtnConfirmarClick
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnConfirmarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Recarrega lista (form operacional sem busca dedicada)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\BALBO.prg):
*====================================================================
* BALBO.prg
*
* Business Object para Balanco de Inventario
* Tabela: SIGCDBAL
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS BALBO AS BusinessBase

	*-- Propriedades da entidade (SIGCDBAL)
	*-- PK
	this_cCidchaves  = ""   && cidchaves char(20) - PK (chave unica UUID)
	*-- Identificacao
	this_nCodigos    = 0    && codigos numeric(4,0) - codigo do balanco
	this_cEmps       = ""   && emps char(3) - empresa
	this_cUsuars     = ""   && usuars char(10) - usuario
	this_nNtrans     = 0    && ntrans numeric(6,0) - numero da transacao
	*-- Grupos de Estoque (conta + grupo)
	this_cGrupos     = ""   && grupos char(10) - grupo de estoque (SigCdGcr)
	this_cContas     = ""   && contas char(10) - conta de estoque (SigCdCli)
	*-- Datas
	this_dDtbases    = {}   && dtbases datetime - data base
	this_dDatainis   = {}   && datainis datetime - data inicial leitura
	this_dDatafims   = {}   && datafims datetime - data final leitura
	this_dDatatrans  = {}   && datatrans datetime - data transporte
	*-- Flags de controle
	this_lEncerras   = .F.  && encerras bit - balanco encerrado
	this_lTratas     = .F.  && tratas bit - tratamento especial
	this_nSepestqs   = 0    && sepestqs numeric(1,0) - separar por estoque
	this_nTrtporpeso = 0    && trtporpeso numeric(1,0) - tratar por peso
	this_nAgrupas    = 0    && agrupas numeric(1,0) - forma de agrupamento
	this_nLeitgructa = 0    && leitgructa numeric(1,0) - leitura somente grupo+conta
	this_nFilbarras  = 0    && filbarras numeric(1,0) - filtro tipo codigo de barras
	*-- Locais (filtros)
	this_cLocals     = ""   && locals char(10) - local (usado na leitura)
	this_cLocalis    = ""   && localis char(10) - local inicial (filtro)
	this_cLocalfs    = ""   && localfs char(10) - local final (filtro)
	*-- Fornecedores (filtros)
	this_cIforis     = ""   && iforis char(10) - fornecedor inicial
	this_cIforfs     = ""   && iforfs char(10) - fornecedor final
	*-- Preco (filtros)
	this_nPrecois    = 0    && precois numeric(8,2) - preco inicial
	this_nPrecofs    = 0    && precofs numeric(8,2) - preco final
	*-- Grupos de Produto (filtros)
	this_cCgruis     = ""   && cgruis char(3) - grupo produto inicial (SigCdGrp.cgrus)
	this_cCgrufs     = ""   && cgrufs char(3) - grupo produto final (SigCdGrp.cgrus)
	*-- Grandes Grupos (filtros)
	this_cCggruis    = ""   && cggruis char(3) - grande grupo inicial (SigCdGpr.codigos)
	this_cCggrufs    = ""   && cggrufs char(3) - grande grupo final (SigCdGpr.codigos)
	*-- Colecoes (filtros)
	this_cColecoesi  = ""   && colecoesi char(10) - colecao inicial (SigCdCol.colecoes)
	this_cColecoesf  = ""   && colecoesf char(10) - colecao final (SigCdCol.colecoes)
	*-- Produtos (filtros)
	this_cCprosi     = ""   && cprosi char(14) - produto inicial (SigCdPro.cpros)
	this_cCprosf     = ""   && cprosf char(14) - produto final (SigCdPro.cpros)
	*-- Subgrupos (filtros)
	this_cSgrusi     = ""   && sgrusi char(6) - subgrupo inicial (SigCdPsg.codigos)
	this_cSgrusf     = ""   && sgrusf char(6) - subgrupo final (SigCdPsg.codigos)
	*-- Unidades (filtros)
	this_cCfinpsi    = ""   && cfinpsi char(3) - unidade inicial (SigCdUni.cunis)
	this_cCfinpsf    = ""   && cfinpsf char(3) - unidade final (SigCdUni.cunis)
	*-- Memo/XML (filtros em grade)
	this_cMfilggrp   = ""   && mfilggrp text - XML marcacoes grandes grupos
	this_cMfilgrupo  = ""   && mfilgrupo text - XML marcacoes grupos produto
	this_cObs        = ""   && obs text - observacao geral

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SIGCDBAL"
		THIS.this_cCampoChave = "cidchaves"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCidchaves)
	ENDPROC

	*====================================================================
	* Buscar - Lista balancos de inventario da empresa atual
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cEmp
		loc_lSucesso = .F.
		loc_cEmp     = ALLTRIM(go_4c_Sistema.cCodEmpresa)

		TRY
			IF EMPTY(par_cFiltro)
				loc_cSQL = "SELECT codigos, cidchaves, emps, grupos, contas, dtbases," + ;
				           " datainis, datafims, datatrans, encerras, tratas, agrupas," + ;
				           " sepestqs, trtporpeso, leitgructa, filbarras, localis, localfs," + ;
				           " iforis, iforfs, cgruis, cgrufs, cggruis, cggrufs," + ;
				           " colecoesi, colecoesf, cprosi, cprosf, sgrusi, sgrusf," + ;
				           " cfinpsi, cfinpsf, precois, precofs, ntrans, locals, usuars" + ;
				           " FROM SIGCDBAL" + ;
				           " WHERE emps = " + EscaparSQL(loc_cEmp) + ;
				           " ORDER BY codigos, cidchaves"
			ELSE
				loc_cSQL = "SELECT codigos, cidchaves, emps, grupos, contas, dtbases," + ;
				           " datainis, datafims, datatrans, encerras, tratas, agrupas," + ;
				           " sepestqs, trtporpeso, leitgructa, filbarras, localis, localfs," + ;
				           " iforis, iforfs, cgruis, cgrufs, cggruis, cggrufs," + ;
				           " colecoesi, colecoesf, cprosi, cprosf, sgrusi, sgrusf," + ;
				           " cfinpsi, cfinpsf, precois, precofs, ntrans, locals, usuars" + ;
				           " FROM SIGCDBAL" + ;
				           " WHERE emps = " + EscaparSQL(loc_cEmp) + ;
				           " AND codigos = " + FormatarNumeroSQL(VAL(ALLTRIM(par_cFiltro))) + ;
				           " ORDER BY codigos, cidchaves"
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar invent" + CHR(225) + "rios:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao buscar invent" + CHR(225) + "rios:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega um balanco pelo cidchaves (PK UUID)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCidchaves)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT codigos, cidchaves, emps, grupos, contas, dtbases," + ;
			           " datainis, datafims, datatrans, encerras, tratas, agrupas," + ;
			           " sepestqs, trtporpeso, leitgructa, filbarras, localis, localfs," + ;
			           " iforis, iforfs, cgruis, cgrufs, cggruis, cggrufs," + ;
			           " colecoesi, colecoesf, cprosi, cprosf, sgrusi, sgrusf," + ;
			           " cfinpsi, cfinpsf, precois, precofs, ntrans, locals, usuars," + ;
			           " mfilggrp, mfilgrupo, obs" + ;
			           " FROM SIGCDBAL" + ;
			           " WHERE cidchaves = " + EscaparSQL(par_cCidchaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorNumero - Carrega balanco pelo numero (codigos + emps)
	*====================================================================
	PROCEDURE CarregarPorNumero(par_nCodigos, par_cEmps)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT codigos, cidchaves, emps, grupos, contas, dtbases," + ;
			           " datainis, datafims, datatrans, encerras, tratas, agrupas," + ;
			           " sepestqs, trtporpeso, leitgructa, filbarras, localis, localfs," + ;
			           " iforis, iforfs, cgruis, cgrufs, cggruis, cggrufs," + ;
			           " colecoesi, colecoesf, cprosi, cprosf, sgrusi, sgrusf," + ;
			           " cfinpsi, cfinpsf, precois, precofs, ntrans, locals, usuars," + ;
			           " mfilggrp, mfilgrupo, obs" + ;
			           " FROM SIGCDBAL" + ;
			           " WHERE codigos = " + FormatarNumeroSQL(par_nCodigos) + ;
			           " AND emps = " + EscaparSQL(par_cEmps)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_cCidchaves    = TratarNulo(cidchaves,    "C")
			THIS.this_nCodigos      = TratarNulo(codigos,      "N")
			THIS.this_cEmps         = TratarNulo(emps,         "C")
			THIS.this_cGrupos       = TratarNulo(grupos,       "C")
			THIS.this_cContas       = TratarNulo(contas,       "C")
			THIS.this_dDtbases      = TratarNulo(dtbases,      "D")
			THIS.this_dDatainis     = TratarNulo(datainis,     "D")
			THIS.this_dDatafims     = TratarNulo(datafims,     "D")
			THIS.this_dDatatrans    = TratarNulo(datatrans,    "D")
			THIS.this_lEncerras     = (TratarNulo(encerras,    "N") = 1)
			THIS.this_lTratas       = (TratarNulo(tratas,      "N") = 1)
			THIS.this_nAgrupas      = TratarNulo(agrupas,      "N")
			THIS.this_nSepestqs     = TratarNulo(sepestqs,     "N")
			THIS.this_nTrtporpeso   = TratarNulo(trtporpeso,   "N")
			THIS.this_nLeitgructa   = TratarNulo(leitgructa,   "N")
			THIS.this_nFilbarras    = TratarNulo(filbarras,     "N")
			THIS.this_cLocalis      = TratarNulo(localis,      "C")
			THIS.this_cLocalfs      = TratarNulo(localfs,      "C")
			THIS.this_cIforis       = TratarNulo(iforis,       "C")
			THIS.this_cIforfs       = TratarNulo(iforfs,       "C")
			THIS.this_cCgruis       = TratarNulo(cgruis,       "C")
			THIS.this_cCgrufs       = TratarNulo(cgrufs,       "C")
			THIS.this_cCggruis      = TratarNulo(cggruis,      "C")
			THIS.this_cCggrufs      = TratarNulo(cggrufs,      "C")
			THIS.this_cColecoesi    = TratarNulo(colecoesi,    "C")
			THIS.this_cColecoesf    = TratarNulo(colecoesf,    "C")
			THIS.this_cCprosi       = TratarNulo(cprosi,       "C")
			THIS.this_cCprosf       = TratarNulo(cprosf,       "C")
			THIS.this_cSgrusi       = TratarNulo(sgrusi,       "C")
			THIS.this_cSgrusf       = TratarNulo(sgrusf,       "C")
			THIS.this_cCfinpsi      = TratarNulo(cfinpsi,      "C")
			THIS.this_cCfinpsf      = TratarNulo(cfinpsf,      "C")
			THIS.this_nPrecois      = TratarNulo(precois,      "N")
			THIS.this_nPrecofs      = TratarNulo(precofs,      "N")
			THIS.this_nNtrans       = TratarNulo(ntrans,       "N")
			THIS.this_cLocals       = TratarNulo(locals,       "C")
			THIS.this_cUsuars       = TratarNulo(usuars,       "C")
			*-- Campos TEXT/memo (podem nao estar no cursor de listagem)
			IF PEMSTATUS(EVAL(par_cAliasCursor), "mfilggrp", 5) OR ;
			   !EMPTY(FIELD("mfilggrp", par_cAliasCursor))
				THIS.this_cMfilggrp  = TratarNulo(mfilggrp,   "C")
				THIS.this_cMfilgrupo = TratarNulo(mfilgrupo,  "C")
				THIS.this_cObs       = TratarNulo(obs,        "C")
			ENDIF
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* GerarProximoCodigo - Obtem proximo codigo disponivel para a empresa
	*====================================================================
	PROTECTED PROCEDURE GerarProximoCodigo(par_cEmps)
		LOCAL loc_cSQL, loc_nResultado, loc_nCodigo
		loc_nCodigo = 0

		TRY
			loc_cSQL = "SELECT ISNULL(MAX(codigos), 0) + 1 AS prox_cod" + ;
			           " FROM SIGCDBAL WHERE emps = " + EscaparSQL(par_cEmps)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProxCod")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ProxCod") > 0
				SELECT cursor_4c_ProxCod
				loc_nCodigo = cursor_4c_ProxCod.prox_cod
			ENDIF

			IF USED("cursor_4c_ProxCod")
				USE IN cursor_4c_ProxCod
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao gerar c" + CHR(243) + "digo:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_ProxCod")
				USE IN cursor_4c_ProxCod
			ENDIF
		ENDTRY

		RETURN loc_nCodigo
	ENDPROC

	*====================================================================
	* Inserir - INSERT na tabela SIGCDBAL
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nCodigo, loc_cEmp
		loc_lSucesso = .F.
		loc_cEmp     = ALLTRIM(go_4c_Sistema.cCodEmpresa)

		TRY
			*-- Gerar chave UUID e proximo codigo sequencial
			THIS.this_cCidchaves = ""
			loc_cSQL = "SELECT LEFT(NEWID(), 20) AS novo_uuid"
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Uuid")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Uuid") > 0
				SELECT cursor_4c_Uuid
				THIS.this_cCidchaves = ALLTRIM(cursor_4c_Uuid.novo_uuid)
			ENDIF
			IF USED("cursor_4c_Uuid")
				USE IN cursor_4c_Uuid
			ENDIF

			IF EMPTY(THIS.this_cCidchaves)
				MsgErro("Erro ao gerar chave " + CHR(250) + "nica.", "Erro")
				loc_lSucesso = .F.
			ENDIF

			loc_nCodigo = THIS.GerarProximoCodigo(loc_cEmp)
			IF loc_nCodigo = 0
				MsgErro("Erro ao gerar c" + CHR(243) + "digo do invent" + CHR(225) + "rio.", "Erro")
				loc_lSucesso = .F.
			ENDIF
			THIS.this_nCodigos = loc_nCodigo
			THIS.this_cEmps    = loc_cEmp
			THIS.this_cUsuars  = ALLTRIM(gc_4c_UsuarioLogado)

			loc_cSQL = "INSERT INTO SIGCDBAL (" + ;
			           " cidchaves, codigos, emps, grupos, contas, dtbases," + ;
			           " datainis, datafims, encerras, tratas, agrupas, sepestqs," + ;
			           " trtporpeso, leitgructa, filbarras, localis, localfs," + ;
			           " iforis, iforfs, cgruis, cgrufs, cggruis, cggrufs," + ;
			           " colecoesi, colecoesf, cprosi, cprosf, sgrusi, sgrusf," + ;
			           " cfinpsi, cfinpsf, precois, precofs, ntrans, locals, usuars" + ;
			           ") VALUES (" + ;
			           EscaparSQL(THIS.this_cCidchaves) + "," + ;
			           FormatarNumeroSQL(THIS.this_nCodigos) + "," + ;
			           EscaparSQL(THIS.this_cEmps) + "," + ;
			           EscaparSQL(THIS.this_cGrupos) + "," + ;
			           EscaparSQL(THIS.this_cContas) + "," + ;
			           FormatarDataSQL(THIS.this_dDtbases) + "," + ;
			           FormatarDataSQL(THIS.this_dDatainis) + "," + ;
			           FormatarDataSQL(THIS.this_dDatafims) + "," + ;
			           IIF(THIS.this_lEncerras, "1", "0") + "," + ;
			           IIF(THIS.this_lTratas, "1", "0") + "," + ;
			           FormatarNumeroSQL(THIS.this_nAgrupas) + "," + ;
			           FormatarNumeroSQL(THIS.this_nSepestqs) + "," + ;
			           FormatarNumeroSQL(THIS.this_nTrtporpeso) + "," + ;
			           FormatarNumeroSQL(THIS.this_nLeitgructa) + "," + ;
			           FormatarNumeroSQL(THIS.this_nFilbarras) + "," + ;
			           EscaparSQL(THIS.this_cLocalis) + "," + ;
			           EscaparSQL(THIS.this_cLocalfs) + "," + ;
			           EscaparSQL(THIS.this_cIforis) + "," + ;
			           EscaparSQL(THIS.this_cIforfs) + "," + ;
			           EscaparSQL(THIS.this_cCgruis) + "," + ;
			           EscaparSQL(THIS.this_cCgrufs) + "," + ;
			           EscaparSQL(THIS.this_cCggruis) + "," + ;
			           EscaparSQL(THIS.this_cCggrufs) + "," + ;
			           EscaparSQL(THIS.this_cColecoesi) + "," + ;
			           EscaparSQL(THIS.this_cColecoesf) + "," + ;
			           EscaparSQL(THIS.this_cCprosi) + "," + ;
			           EscaparSQL(THIS.this_cCprosf) + "," + ;
			           EscaparSQL(THIS.this_cSgrusi) + "," + ;
			           EscaparSQL(THIS.this_cSgrusf) + "," + ;
			           EscaparSQL(THIS.this_cCfinpsi) + "," + ;
			           EscaparSQL(THIS.this_cCfinpsf) + "," + ;
			           FormatarNumeroSQL(THIS.this_nPrecois) + "," + ;
			           FormatarNumeroSQL(THIS.this_nPrecofs) + "," + ;
			           FormatarNumeroSQL(THIS.this_nNtrans) + "," + ;
			           EscaparSQL(THIS.this_cLocals) + "," + ;
			           EscaparSQL(THIS.this_cUsuars) + ;
			           ")"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao inserir invent" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao inserir invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE na tabela SIGCDBAL
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SIGCDBAL SET" + ;
			           " grupos = " + EscaparSQL(THIS.this_cGrupos) + "," + ;
			           " contas = " + EscaparSQL(THIS.this_cContas) + "," + ;
			           " dtbases = " + FormatarDataSQL(THIS.this_dDtbases) + "," + ;
			           " datainis = " + FormatarDataSQL(THIS.this_dDatainis) + "," + ;
			           " datafims = " + FormatarDataSQL(THIS.this_dDatafims) + "," + ;
			           " encerras = " + IIF(THIS.this_lEncerras, "1", "0") + "," + ;
			           " tratas = " + IIF(THIS.this_lTratas, "1", "0") + "," + ;
			           " agrupas = " + FormatarNumeroSQL(THIS.this_nAgrupas) + "," + ;
			           " sepestqs = " + FormatarNumeroSQL(THIS.this_nSepestqs) + "," + ;
			           " trtporpeso = " + FormatarNumeroSQL(THIS.this_nTrtporpeso) + "," + ;
			           " leitgructa = " + FormatarNumeroSQL(THIS.this_nLeitgructa) + "," + ;
			           " filbarras = " + FormatarNumeroSQL(THIS.this_nFilbarras) + "," + ;
			           " localis = " + EscaparSQL(THIS.this_cLocalis) + "," + ;
			           " localfs = " + EscaparSQL(THIS.this_cLocalfs) + "," + ;
			           " iforis = " + EscaparSQL(THIS.this_cIforis) + "," + ;
			           " iforfs = " + EscaparSQL(THIS.this_cIforfs) + "," + ;
			           " cgruis = " + EscaparSQL(THIS.this_cCgruis) + "," + ;
			           " cgrufs = " + EscaparSQL(THIS.this_cCgrufs) + "," + ;
			           " cggruis = " + EscaparSQL(THIS.this_cCggruis) + "," + ;
			           " cggrufs = " + EscaparSQL(THIS.this_cCggrufs) + "," + ;
			           " colecoesi = " + EscaparSQL(THIS.this_cColecoesi) + "," + ;
			           " colecoesf = " + EscaparSQL(THIS.this_cColecoesf) + "," + ;
			           " cprosi = " + EscaparSQL(THIS.this_cCprosi) + "," + ;
			           " cprosf = " + EscaparSQL(THIS.this_cCprosf) + "," + ;
			           " sgrusi = " + EscaparSQL(THIS.this_cSgrusi) + "," + ;
			           " sgrusf = " + EscaparSQL(THIS.this_cSgrusf) + "," + ;
			           " cfinpsi = " + EscaparSQL(THIS.this_cCfinpsi) + "," + ;
			           " cfinpsf = " + EscaparSQL(THIS.this_cCfinpsf) + "," + ;
			           " precois = " + FormatarNumeroSQL(THIS.this_nPrecois) + "," + ;
			           " precofs = " + FormatarNumeroSQL(THIS.this_nPrecofs) + "," + ;
			           " locals = " + EscaparSQL(THIS.this_cLocals) + "," + ;
			           " usuars = " + EscaparSQL(THIS.this_cUsuars) + ;
			           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar invent" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao atualizar invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE do balanco e registros filhos
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nCodigos, loc_cEmps
		loc_lSucesso = .F.
		loc_nCodigos = THIS.this_nCodigos
		loc_cEmps    = ALLTRIM(THIS.this_cEmps)

		TRY
			*-- Remover registros filhos: SigIvTrB (balancos itens)
			loc_cSQL = "DELETE FROM SigIvTrB" + ;
			           " WHERE emps = " + EscaparSQL(loc_cEmps) + ;
			           " AND codigos = " + FormatarNumeroSQL(loc_nCodigos)
			SQLEXEC(gnConnHandle, loc_cSQL)

			*-- Remover registros filhos: SigIvTrH (historico de leitura)
			loc_cSQL = "DELETE FROM SigIvTrH" + ;
			           " WHERE emps = " + EscaparSQL(loc_cEmps) + ;
			           " AND codigos = " + FormatarNumeroSQL(loc_nCodigos)
			SQLEXEC(gnConnHandle, loc_cSQL)

			*-- Remover registros filhos: SigIvTrE (etiquetas)
			loc_cSQL = "DELETE FROM SigIvTrE" + ;
			           " WHERE emps = " + EscaparSQL(loc_cEmps) + ;
			           " AND codigos = " + FormatarNumeroSQL(loc_nCodigos)
			SQLEXEC(gnConnHandle, loc_cSQL)

			*-- Remover o balanco principal
			loc_cSQL = "DELETE FROM SIGCDBAL" + ;
			           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir invent" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao excluir invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* AtualizarEncerramento - Marca/desmarca balanco como encerrado
	*====================================================================
	PROCEDURE AtualizarEncerramento(par_lEncerrar, par_dDatafim)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SIGCDBAL SET" + ;
			           " encerras = " + IIF(par_lEncerrar, "1", "0") + "," + ;
			           " datafims = " + FormatarDataSQL(par_dDatafim) + ;
			           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.this_lEncerras  = par_lEncerrar
				THIS.this_dDatafims  = par_dDatafim
				THIS.RegistrarAuditoria("ENCERRAR")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao encerrar invent" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao encerrar invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* AtualizarTransporte - Marca balanco como transportado
	*====================================================================
	PROCEDURE AtualizarTransporte(par_dDataTrans)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SIGCDBAL SET" + ;
			           " datatrans = " + FormatarDataSQL(par_dDataTrans) + ;
			           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.this_dDatatrans = par_dDataTrans
				THIS.RegistrarAuditoria("TRANSPORTE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao registrar transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao registrar transporte:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* AtualizarFiltrosXML - Salva filtros de grade (mfilggrp, mfilgrupo)
	*====================================================================
	PROCEDURE AtualizarFiltrosXML(par_cMfilggrp, par_cMfilgrupo)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SIGCDBAL SET" + ;
			           " mfilggrp = " + EscaparSQL(par_cMfilggrp) + "," + ;
			           " mfilgrupo = " + EscaparSQL(par_cMfilgrupo) + ;
			           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.this_cMfilggrp  = par_cMfilggrp
				THIS.this_cMfilgrupo = par_cMfilgrupo
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao salvar filtros XML:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao salvar filtros XML:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ValidarGrupoEstoque - Verifica se grupo de estoque eh valido
	*====================================================================
	PROCEDURE ValidarGrupoEstoque(par_cGrupos)
		LOCAL loc_cSQL, loc_nResultado, loc_lValido
		loc_lValido = .F.

		TRY
			IF EMPTY(ALLTRIM(par_cGrupos))
				loc_lValido = .F.
			ENDIF

			loc_cSQL = "SELECT TOP 1 Codigos FROM SigCdGcr" + ;
			           " WHERE Codigos = " + EscaparSQL(ALLTRIM(par_cGrupos))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValGru")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ValGru") > 0
				loc_lValido = .T.
			ENDIF

			IF USED("cursor_4c_ValGru")
				USE IN cursor_4c_ValGru
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao validar grupo:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_ValGru")
				USE IN cursor_4c_ValGru
			ENDIF
		ENDTRY

		RETURN loc_lValido
	ENDPROC

	*====================================================================
	* ValidarConta - Verifica se conta de estoque eh valida
	*====================================================================
	PROCEDURE ValidarConta(par_cContas)
		LOCAL loc_cSQL, loc_nResultado, loc_lValido
		loc_lValido = .F.

		TRY
			IF EMPTY(ALLTRIM(par_cContas))
				loc_lValido = .T.
			ENDIF

			loc_cSQL = "SELECT TOP 1 IClis FROM SigCdCli" + ;
			           " WHERE IClis = " + EscaparSQL(ALLTRIM(par_cContas))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValCta")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ValCta") > 0
				loc_lValido = .T.
			ENDIF

			IF USED("cursor_4c_ValCta")
				USE IN cursor_4c_ValCta
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao validar conta:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_ValCta")
				USE IN cursor_4c_ValCta
			ENDIF
		ENDTRY

		RETURN loc_lValido
	ENDPROC

ENDDEFINE

