# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'CarregarDadosReais': Property CARREGARLISTA is not found. | Detalhes: Linha: 799, Proc: testecarregardadosreais

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-03 12:06:08] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-03 12:06:08] [INFO] Config FPW: (nao fornecido)
[2026-07-03 12:06:08] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-03 12:06:08] [INFO] Timeout: 300 segundos
[2026-07-03 12:06:08] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_saq535dm.prg
[2026-07-03 12:06:08] [INFO] Conteudo do wrapper:
[2026-07-03 12:06:08] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSigPrGloT', 'C:\4c\tasks\task188', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigPrGloT', 'C:\4c\tasks\task188', 'OPERACIONAL'
QUIT

[2026-07-03 12:06:08] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_saq535dm.prg
[2026-07-03 12:06:08] [INFO] VFP output esperado em: C:\4c\tasks\task188\vfp_output.txt
[2026-07-03 12:06:08] [INFO] Executando Visual FoxPro 9...
[2026-07-03 12:06:08] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_saq535dm.prg
[2026-07-03 12:06:08] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_saq535dm.prg
[2026-07-03 12:06:08] [INFO] Timeout configurado: 300 segundos
[2026-07-03 12:06:28] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-03 12:06:28] [INFO] VFP9 finalizado em 20.3944766 segundos
[2026-07-03 12:06:28] [INFO] Exit Code: 
[2026-07-03 12:06:28] [INFO] 
[2026-07-03 12:06:28] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-03 12:06:28] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_saq535dm.prg
[2026-07-03 12:06:28] [INFO] 
[2026-07-03 12:06:28] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-03 12:06:28] [INFO] * Auto-generated wrapper for parameters
[2026-07-03 12:06:28] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-03 12:06:28] [INFO] * Parameters: 'FormSigPrGloT', 'C:\4c\tasks\task188', 'OPERACIONAL'
[2026-07-03 12:06:28] [INFO] 
[2026-07-03 12:06:28] [INFO] * Anti-dialog protections for unattended execution
[2026-07-03 12:06:28] [INFO] SET SAFETY OFF
[2026-07-03 12:06:28] [INFO] SET RESOURCE OFF
[2026-07-03 12:06:28] [INFO] SET TALK OFF
[2026-07-03 12:06:28] [INFO] SET NOTIFY OFF
[2026-07-03 12:06:28] [INFO] SYS(2335, 0)
[2026-07-03 12:06:28] [INFO] 
[2026-07-03 12:06:28] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSigPrGloT', 'C:\4c\tasks\task188', 'OPERACIONAL'
[2026-07-03 12:06:28] [INFO] QUIT
[2026-07-03 12:06:28] [INFO] 
[2026-07-03 12:06:28] [INFO] === Fim do Wrapper.prg ===
[2026-07-03 12:06:28] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSigPrGloT",
  "timestamp": "20260703120628",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": true,
      "erro": "",
      "detalhes": "Objeto criado com sucesso"
    },
    {
      "nome": "ContainersFlutuantes",
      "passou": true,
      "erro": "",
      "detalhes": "Nenhum container flutuante encontrado (OK)"
    },
    {
      "nome": "CarregarDadosReais",
      "passou": false,
      "erro": "Property CARREGARLISTA is not found.",
      "detalhes": "Linha: 799, Proc: testecarregardadosreais"
    },
    {
      "nome": "NavegacaoPaginas",
      "passou": true,
      "erro": "",
      "detalhes": "2/2 paginas navegadas com sucesso"
    },
    {
      "nome": "BtnIncluirNavegacao",
      "passou": true,
      "erro": "",
      "detalhes": "Form OPERACIONAL com BtnIncluirClick e PageFrame - navegacao Page2 nao aplicavel"
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGloT.prg):
*==============================================================================
* FormSigPrGloT.prg - Processamento Global por Tipo
* Tipo: OPERACIONAL
* Herda de: FormBase
* Legado: SigPrGloT.SCX (form placeholder)
*==============================================================================

DEFINE CLASS FormSigPrGloT AS FormBase

    Width        = 1000
    Height       = 600
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    BorderStyle  = 2
    DataSession  = 2
    ClipControls = .F.
    Themes       = .F.
    Caption      = "Processamento Global por Tipo"
    FontName     = "Tahoma"
    FontSize     = 8

    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"
    this_cTituloForm     = "Processamento Global por Tipo"

    *--------------------------------------------------------------------------
    * Init - delega para FormBase (que chama InicializarForm)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - cria BO, PageFrame e containers base
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            SET DATE TO BRITISH
            SET CENTURY ON

            THIS.this_oBusinessObject = CREATEOBJECT("SigPrGloTBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar SigPrGloTBO.", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                THIS.TornarControlesVisiveis(THIS)
                THIS.CarregarLista()
                THIS.AjustarBotoesPorModo()

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar formul" + CHR(225) + "rio: " + ;
                    loc_oErro.Message + " [Ln:" + TRANSFORM(loc_oErro.LineNo) + ;
                    " Proc:" + loc_oErro.Procedure + "]", "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com Page1 (Lista) e Page2 (Dados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        WITH THIS.pgf_4c_Paginas
            .PageCount   = 2
            .Top         = -29
            .Left        = 0
            .Width       = THIS.Width
            .Height      = THIS.Height + 29
            .Tabs        = .F.
            .BorderWidth = 0
            .Themes      = .F.
            .Page1.Caption = "Lista"
            .Page2.Caption = "Dados"
            .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Page1 com Cabecalho, Botoes CRUD e Grid
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Container Cabecalho (cinza opaco, Top=2+29=31)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100,100,100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .AutoSize   = .F.
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 16
                .BackStyle  = 0
                .Alignment  = 0
                .Height     = 40
                .Left       = 10
                .Top        = 15
                .Width      = THISFORM.Width - 20
                .ForeColor  = RGB(0,0,0)
                .Caption    = THISFORM.this_cTituloForm
                .Visible    = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .AutoSize   = .F.
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 16
                .BackStyle  = 0
                .Alignment  = 0
                .Height     = 46
                .Left       = 10
                .Top        = 18
                .Width      = THISFORM.Width - 20
                .ForeColor  = RGB(255,255,255)
                .Caption    = THISFORM.this_cTituloForm
                .Visible    = .T.
            ENDWITH
        ENDWITH

        *-- Container Botoes CRUD (lado direito, Top=0+29=29)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle   = 1
            .BackColor   = RGB(53,53,53)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("cmd_4c_Incluir", "CommandButton")
            WITH .cmd_4c_Incluir
                .Top             = 5
                .Left            =  542
                .Width           = 75
                .Height          = 75
                .Caption         = "Incluir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90,90,90)
                .BackColor       = RGB(255,255,255)
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
            ENDWITH

            .AddObject("cmd_4c_Visualizar", "CommandButton")
            WITH .cmd_4c_Visualizar
                .Top             = 5
                .Left            =  542
                .Width           = 75
                .Height          = 75
                .Caption         = "Visualizar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90,90,90)
                .BackColor       = RGB(255,255,255)
                .Themes          = .F.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Enabled         = .F.
            ENDWITH

            .AddObject("cmd_4c_Alterar", "CommandButton")
            WITH .cmd_4c_Alterar
                .Top             = 5
                .Left            =  542
                .Width           = 75
                .Height          = 75
                .Caption         = "Alterar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90,90,90)
                .BackColor       = RGB(255,255,255)
                .Themes          = .F.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Enabled         = .F.
            ENDWITH

            .AddObject("cmd_4c_Excluir", "CommandButton")
            WITH .cmd_4c_Excluir
                .Top             = 5
                .Left            =  542
                .Width           = 75
                .Height          = 75
                .Caption         = "Excluir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90,90,90)
                .BackColor       = RGB(255,255,255)
                .Themes          = .F.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Enabled         = .F.
            ENDWITH

            .AddObject("cmd_4c_Buscar", "CommandButton")
            WITH .cmd_4c_Buscar
                .Top             = 5
                .Left            =  542
                .Width           = 75
                .Height          = 75
                .Caption         = "Buscar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90,90,90)
                .BackColor       = RGB(255,255,255)
                .Themes          = .F.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
            ENDWITH
        ENDWITH

        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")

        *-- Container Encerrar (padrao canonico: Left=917, Width=90)
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH .cmd_4c_Encerrar
                .Top             = 5
                .Left            = 917
                .Width           = 75
                .Height          = 75
                .Caption         = "Encerrar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90,90,90)
                .BackColor       = RGB(255,255,255)
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
            ENDWITH
        ENDWITH

        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de Lista (Top=88+29=117)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 26
            .Width              = 890
            .Height             = 468
            .FontName           = "Verdana"
            .FontSize           = 8
            .ForeColor          = RGB(90,90,90)
            .BackColor          = RGB(255,255,255)
            .GridLineColor      = RGB(238,238,238)
            .HighlightBackColor = RGB(255,255,255)
            .HighlightForeColor = RGB(15,41,104)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 2
            .ReadOnly           = .T.
            .ColumnCount        = 2
            .Column1.Width      = 150
            .Column2.Width      = 740
        ENDWITH

        BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Page2: Cabecalho, Botoes, Encerrar e campos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho Page2 (cinza opaco, Top=2+29=31)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = THISFORM.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100,100,100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 16
                .BackStyle = 0
                .Alignment = 0
                .Height    = 40
                .Left      = 10
                .Top       = 15
                .Width     = THISFORM.Width - 20
                .ForeColor = RGB(0,0,0)
                .Caption   = THISFORM.this_cTituloForm
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 16
                .BackStyle = 0
                .Alignment = 0
                .Height    = 46
                .Left      = 10
                .Top       = 18
                .Width     = THISFORM.Width - 20
                .ForeColor = RGB(255,255,255)
                .Caption   = THISFORM.this_cTituloForm
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- Container Botoes de Acao (Confirmar/Cancelar) - Top=4+29=33
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("cmd_4c_Confirmar", "CommandButton")
            WITH .cmd_4c_Confirmar
                .Top             = 5
                .Left            = 5
                .Width           = 75
                .Height          = 75
                .Caption         = "Confirmar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90,90,90)
                .BackColor       = RGB(255,255,255)
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
            ENDWITH

            .AddObject("cmd_4c_Cancelar", "CommandButton")
            WITH .cmd_4c_Cancelar
                .Top             = 5
                .Left            = 80
                .Width           = 75
                .Height          = 75
                .Caption         = "Encerrar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90,90,90)
                .BackColor       = RGB(255,255,255)
                .Themes          = .F.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
            ENDWITH
        ENDWITH

        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, ;
                  "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, ;
                  "Click", THIS, "BtnCancelarClick")

        *-- Container Encerrar Page2 (padrao canonico: Left=917, Width=90)
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH .cmd_4c_Encerrar
                .Top             = 5
                .Left            = 917
                .Width           = 75
                .Height          = 75
                .Caption         = "Encerrar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90,90,90)
                .BackColor       = RGB(255,255,255)
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
            ENDWITH
        ENDWITH

        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, ;
                  "Click", THIS, "BtnEncerrarClick")

        *-- FASE 5: Primeiro campo (50% dos campos) - Tipo
        loc_oPagina.AddObject("lbl_4c_Tipo", "Label")
        WITH loc_oPagina.lbl_4c_Tipo
            .Top       = 145
            .Left      = 30
            .Width     = 80
            .Height    = 18
            .Caption   = "Tipo:"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Tipos", "TextBox")
        WITH loc_oPagina.txt_4c_Tipos
            .Top         = 142
            .Left        = 115
            .Width       = 100
            .Height      = 22
            .Value       = ""
            .MaxLength   = 10
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255,255,255)
            .ForeColor   = RGB(0,0,128)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Descrs", "Label")
        WITH loc_oPagina.lbl_4c_Descrs
            .Top       = 175
            .Left      = 30
            .Width     = 80
            .Height    = 18
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o:"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Descrs", "TextBox")
        WITH loc_oPagina.txt_4c_Descrs
            .Top         = 172
            .Left        = 115
            .Width       = 400
            .Height      = 22
            .Value       = ""
            .MaxLength   = 60
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255,255,255)
            .ForeColor   = RGB(0,0,128)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - torna todos os controles visiveis recursivamente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_nP, loc_oCtrl

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oCtrl = par_oContainer.Controls(loc_i)

            IF VARTYPE(loc_oCtrl) != "O"
                LOOP
            ENDIF

            IF PEMSTATUS(loc_oCtrl, "Visible", 5)
                loc_oCtrl.Visible = .T.
            ENDIF

            IF UPPER(loc_oCtrl.BaseClass) = "PAGEFRAME"
                FOR loc_nP = 1 TO loc_oCtrl.PageCount
                    THIS.TornarControlesVisiveis(loc_oCtrl.Pages(loc_nP))
                ENDFOR
            ENDIF

            IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                THIS.TornarControlesVisiveis(loc_oCtrl)
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - alterna entre Page1 (Lista) e Page2 (Dados)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        THIS.pgf_4c_Paginas.ActivePage = par_nPagina
        IF par_nPagina = 1
            THIS.this_cModoAtual = "LISTA"
            THIS.AjustarBotoesPorModo()
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - popula cursor_4c_Lista e vincula ao grid
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarLista()
        LOCAL loc_lSucesso, loc_oErro, loc_oGrid
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Lista")
                USE IN cursor_4c_Lista
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_Lista ;
                (Tipos C(10) NULL, Descrs C(60) NULL)
            SET NULL OFF

            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
            loc_oGrid.ColumnCount            = 2
            loc_oGrid.RecordSource           = "cursor_4c_Lista"
            loc_oGrid.Column1.ControlSource  = "cursor_4c_Lista.Tipos"
            loc_oGrid.Column2.ControlSource  = "cursor_4c_Lista.Descrs"
            loc_oGrid.Column1.Header1.Caption = "Tipo"
            loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

            THIS.FormatarGridLista(loc_oGrid)
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar lista: " + loc_oErro.Message + ;
                    " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * FormatarGridLista - aplica formatacao visual ao grid
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - habilita/desabilita botoes conforme dados
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lTemRegistro, loc_oBotoes
        loc_oBotoes     = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
        loc_lTemRegistro = .F.

        IF USED("cursor_4c_Lista")
            loc_lTemRegistro = (RECCOUNT("cursor_4c_Lista") > 0) AND !EOF("cursor_4c_Lista")
        ENDIF

        loc_oBotoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
        loc_oBotoes.cmd_4c_Alterar.Enabled    = loc_lTemRegistro
        loc_oBotoes.cmd_4c_Excluir.Enabled    = loc_lTemRegistro
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - vai para Page2 em modo INCLUIR
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.HabilitarCampos(.T.)
        THIS.pgf_4c_Paginas.ActivePage = 2
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - vai para Page2 em modo VISUALIZAR
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        IF !USED("cursor_4c_Lista") OR RECCOUNT("cursor_4c_Lista") = 0 OR EOF("cursor_4c_Lista")
            MsgAviso("Selecione um registro para visualizar.", "Aviso")
            RETURN
        ENDIF
        THIS.this_cModoAtual = "VISUALIZAR"
        THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Lista")
        THIS.BOParaForm()
        THIS.HabilitarCampos(.F.)
        THIS.pgf_4c_Paginas.ActivePage = 2
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - vai para Page2 em modo ALTERAR
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        IF !USED("cursor_4c_Lista") OR RECCOUNT("cursor_4c_Lista") = 0 OR EOF("cursor_4c_Lista")
            MsgAviso("Selecione um registro para alterar.", "Aviso")
            RETURN
        ENDIF
        THIS.this_cModoAtual = "ALTERAR"
        THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Lista")
        THIS.this_oBusinessObject.EditarRegistro()
        THIS.BOParaForm()
        THIS.HabilitarCampos(.T.)
        THIS.pgf_4c_Paginas.ActivePage = 2
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - confirma e exclui registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        IF !USED("cursor_4c_Lista") OR RECCOUNT("cursor_4c_Lista") = 0
            MsgAviso("Selecione um registro para excluir.", "Aviso")
            RETURN
        ENDIF

        LOCAL loc_lConfirma
        loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro?", ;
                                    "Confirmar Exclus" + CHR(227) + "o")
        IF loc_lConfirma
            IF THIS.this_oBusinessObject.Excluir()
                THIS.CarregarLista()
                THIS.AjustarBotoesPorModo()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - filtra lista pelo texto informado
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_cBusca, loc_oErro
        loc_cBusca = INPUTBOX("Digite o texto para busca:", ;
                              "Buscar", "")
        IF EMPTY(ALLTRIM(loc_cBusca))
            THIS.CarregarLista()
            THIS.AjustarBotoesPorModo()
        ELSE
            IF USED("cursor_4c_Lista")
                TRY
                    SELECT cursor_4c_Lista
                    LOCATE FOR UPPER(ALLTRIM(loc_cBusca)) $ UPPER(ALLTRIM(Descrs))
                    IF EOF()
                        MsgAviso("Nenhum registro encontrado para: " + loc_cBusca, "Buscar")
                        GO TOP IN cursor_4c_Lista
                    ENDIF
                CATCH TO loc_oErro
                    MsgErro("Erro na busca: " + loc_oErro.Message, "Erro")
                ENDTRY
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - salva dados (Inserir ou Atualizar conforme modo)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.FormParaBO()
        IF THIS.this_oBusinessObject.Salvar()
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - cancela edicao e volta para Lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - transfere dados do form para o BO
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        WITH THIS.this_oBusinessObject
            .this_cTipos  = ALLTRIM(loc_oPagina.txt_4c_Tipos.Value)
            .this_cDescrs = ALLTRIM(loc_oPagina.txt_4c_Descrs.Value)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - transfere dados do BO para o form
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        WITH THIS.this_oBusinessObject
            loc_oPagina.txt_4c_Tipos.Value  = ALLTRIM(.this_cTipos)
            loc_oPagina.txt_4c_Descrs.Value = ALLTRIM(.this_cDescrs)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - habilita ou desabilita campos conforme modo
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.txt_4c_Tipos.Enabled  = par_lHabilitar
        loc_oPagina.txt_4c_Descrs.Enabled = par_lHabilitar
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - limpa todos os campos da Page2
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.txt_4c_Tipos.Value  = ""
        loc_oPagina.txt_4c_Descrs.Value = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - libera BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrGloTBO.prg):
*====================================================================
* SigPrGloTBO.prg
*
* Business Object para SigPrGloT (Formulario Operacional)
* Herda de BusinessBase
*====================================================================

DEFINE CLASS SigPrGloTBO AS BusinessBase

	*-- Propriedades da entidade
	this_cMensagemErro = ""
	this_cTipos        = ""
	this_cDescrs       = ""

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()

		THIS.this_cTabela     = ""
		THIS.this_cCampoChave = "Tipos"

		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria do registro atual
	*====================================================================
	PROTECTED FUNCTION ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cTipos)
	ENDFUNC

	*====================================================================
	* ValidarDados - Valida dados antes de Inserir/Atualizar
	*====================================================================
	PROTECTED FUNCTION ValidarDados()
		IF EMPTY(ALLTRIM(THIS.this_cTipos))
			MsgAviso("Informe o Tipo.", ;
			         "Valida" + CHR(231) + CHR(227) + "o")
			RETURN .F.
		ENDIF
		IF EMPTY(ALLTRIM(THIS.this_cDescrs))
			MsgAviso("Informe a Descri" + CHR(231) + CHR(227) + "o.", ;
			         "Valida" + CHR(231) + CHR(227) + "o")
			RETURN .F.
		ENDIF
		RETURN .T.
	ENDFUNC

	*====================================================================
	* CarregarDoCursor - Carrega propriedades a partir de cursor
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_cTipos  = TratarNulo(Tipos,  "C")
			THIS.this_cDescrs = TratarNulo(Descrs, "C")
			RETURN .T.
		ENDIF
		RETURN .F.
	ENDPROC

	*====================================================================
	* Inserir - Form operacional sem tabela de destino
	*====================================================================
	FUNCTION Inserir()
		LOCAL loc_lSucesso, loc_oErro
		loc_lSucesso = .F.

		TRY
			IF THIS.ValidarDados()
				THIS.RegistrarAuditoria("I")
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* Atualizar - Form operacional sem tabela de destino
	*====================================================================
	FUNCTION Atualizar()
		LOCAL loc_lSucesso, loc_oErro
		loc_lSucesso = .F.

		TRY
			IF THIS.ValidarDados()
				THIS.RegistrarAuditoria("A")
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

ENDDEFINE

