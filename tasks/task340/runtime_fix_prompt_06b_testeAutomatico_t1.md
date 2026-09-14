# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'CarregarDadosReais': No PARAMETER statement is found. | Detalhes: Linha: 570, Proc: montagrade

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-19 01:21:33] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-19 01:21:33] [INFO] Config FPW: (nao fornecido)
[2026-07-19 01:21:33] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-19 01:21:33] [INFO] Timeout: 300 segundos
[2026-07-19 01:21:33] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_aayhjnux.prg
[2026-07-19 01:21:33] [INFO] Conteudo do wrapper:
[2026-07-19 01:21:33] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSIGPRVTX', 'C:\4c\tasks\task340', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGPRVTX', 'C:\4c\tasks\task340', 'OPERACIONAL'
QUIT

[2026-07-19 01:21:33] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_aayhjnux.prg
[2026-07-19 01:21:33] [INFO] VFP output esperado em: C:\4c\tasks\task340\vfp_output.txt
[2026-07-19 01:21:33] [INFO] Executando Visual FoxPro 9...
[2026-07-19 01:21:33] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_aayhjnux.prg
[2026-07-19 01:21:33] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_aayhjnux.prg
[2026-07-19 01:21:33] [INFO] Timeout configurado: 300 segundos
[2026-07-19 01:22:05] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-19 01:22:05] [INFO] VFP9 finalizado em 32.2068859 segundos
[2026-07-19 01:22:05] [INFO] Exit Code: 
[2026-07-19 01:22:05] [INFO] 
[2026-07-19 01:22:05] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-19 01:22:05] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_aayhjnux.prg
[2026-07-19 01:22:05] [INFO] 
[2026-07-19 01:22:05] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-19 01:22:05] [INFO] * Auto-generated wrapper for parameters
[2026-07-19 01:22:05] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-19 01:22:05] [INFO] * Parameters: 'FormSIGPRVTX', 'C:\4c\tasks\task340', 'OPERACIONAL'
[2026-07-19 01:22:05] [INFO] 
[2026-07-19 01:22:05] [INFO] * Anti-dialog protections for unattended execution
[2026-07-19 01:22:05] [INFO] SET SAFETY OFF
[2026-07-19 01:22:05] [INFO] SET RESOURCE OFF
[2026-07-19 01:22:05] [INFO] SET TALK OFF
[2026-07-19 01:22:05] [INFO] SET NOTIFY OFF
[2026-07-19 01:22:05] [INFO] SYS(2335, 0)
[2026-07-19 01:22:05] [INFO] 
[2026-07-19 01:22:05] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGPRVTX', 'C:\4c\tasks\task340', 'OPERACIONAL'
[2026-07-19 01:22:05] [INFO] QUIT
[2026-07-19 01:22:05] [INFO] 
[2026-07-19 01:22:05] [INFO] === Fim do Wrapper.prg ===
[2026-07-19 01:22:05] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSIGPRVTX",
  "timestamp": "20260719012205",
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
      "erro": "No PARAMETER statement is found.",
      "detalhes": "Linha: 570, Proc: montagrade"
    },
    {
      "nome": "NavegacaoPaginas",
      "passou": true,
      "erro": "",
      "detalhes": "Nenhum PageFrame encontrado (form sem paginas)"
    },
    {
      "nome": "BtnIncluirNavegacao",
      "passou": true,
      "erro": "",
      "detalhes": "Form OPERACIONAL com BtnIncluirClick sem navegacao por PageFrame (OK)"
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
      "detalhes": "AbrirLookup: 0 | KeyPress handlers: 2 (FORMKEYPRESS, KEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRVTX.prg):
*==============================================================================
* FormSIGPRVTX.prg - Importacao de SKUs via planilha Excel (VTX)
* Tipo: OPERACIONAL (flat - sem PageFrame)
* Migrado de SIGPRVTX.SCX
* Tabela: sigprvtx | PK: cidchaves | Cursor grade: cursor_4c_Grade
*==============================================================================
DEFINE CLASS FormSIGPRVTX AS FormBase

    *-- Propriedades visuais (identicas ao legado SIGPRVTX, escaladas 800->1000)
    Width        = 1000
    Height       = 600
    AutoCenter   = .T.
    TitleBar     = 0
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Closable     = .F.
    ShowTips     = .T.
    KeyPreview   = .T.
    BorderStyle  = 2
    DataSession  = 1
    WindowType   = 1
    ShowWindow   = 1
    FontName     = "Tahoma"
    FontSize     = 8

    this_oBusinessObject = .NULL.

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
    *==========================================================================
        THIS.BackColor = RGB(100, 100, 100)
        THIS.SetAll("FontName", "Tahoma")
        THIS.SetAll("FontSize", 8)
        IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro, loc_cTitulo
        loc_lSucesso = .F.

        TRY
            *-- Cursor placeholder da grade (mesma estrutura usada em MontaGrade)
            SET NULL ON
            CREATE CURSOR cursor_4c_Grade (;
                skuid    C(10)  NULL, ;
                nomesku  C(100) NULL, ;
                skuativo C(3)   NULL, ;
                refsku   C(40)  NULL)
            SET NULL OFF
            SELECT cursor_4c_Grade
            INDEX ON skuid TAG skuid
            GO TOP

            *-- Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("SIGPRVTXBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar SIGPRVTXBO", "Erro")
            ENDIF

            *-- Aparencia base do form (fundo new_background)
            THIS.ConfigurarPageFrame()

            *-- Cabecalho cinza escuro com titulo (equivalente ao cntSombra legado)
            THIS.ConfigurarCabecalho()

            *-- Botoes principais topo-direito: Salvar + Encerrar
            THIS.ConfigurarBotoesPrincipais()

            *-- Area de entrada de dados: shape + label + textbox planilha + botao selecionar
            *-- (equivalente conceitual a "Page2/Dados" para form OPERACIONAL flat)
            THIS.ConfigurarPaginaDados()

            *-- Area de resultado/lista: grid de SKUs importados + botoes Limpar/Processar
            THIS.ConfigurarPaginaLista()

            *-- Tornar controles visiveis (AddObject cria com Visible=.F.)
            THIS.TornarControlesVisiveis()

            *-- Titulo do formulario (CHR: Importacao = Importa+231+227+o)
            loc_cTitulo = "Importa" + CHR(231) + CHR(227) + "o de SKUs (VTX)"
            THIS.Caption = loc_cTitulo
            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo

            *-- BINDEVENT para KeyPress no nivel do form (ESC fecha)
            BINDEVENT(THIS, "KeyPress", THIS, "FormKeyPress")

            *-- Conecta grade ao cursor vazio inicial
            THIS.MontaGrade()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
    *==========================================================================
        LOCAL loc_oCab
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
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .AutoSize   = .F.
            .FontName   = "Tahoma"
            .FontSize   = 18
            .FontBold   = .T.
            .WordWrap   = .T.
            .BackStyle  = 0
            .Caption    = ""
            .Height     = 40
            .Left       = 10
            .Top        = 18
            .Width      = THIS.Width - 20
            .ForeColor  = RGB(0, 0, 0)
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .AutoSize   = .F.
            .FontName   = "Tahoma"
            .FontSize   = 18
            .FontBold   = .T.
            .WordWrap   = .T.
            .BackStyle  = 0
            .Caption    = ""
            .Height     = 46
            .Left       = 10
            .Top        = 17
            .Width      = THIS.Width - 20
            .ForeColor  = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesPrincipais()
    *-- Equivalente ao Grupo_Botao legado (cmdok=Salvar + cmdsair=Encerrar)
    *-- Posicionado no topo-direito: Left=840, Width=160, right=1000
    *==========================================================================
        LOCAL loc_oCmg
        THIS.AddObject("cmg_4c_Principal", "CommandGroup")
        loc_oCmg = THIS.cmg_4c_Principal

        WITH loc_oCmg
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Height        = 85
            .Left          = 840
            .Top           = -2
            .Width         = 160
            WITH .Buttons(1)
                .Top        = 5
                .Left       = 5
                .Height     = 75
                .Width      = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Tahoma"
                .FontSize   = 8
                .WordWrap   = .T.
                .Picture    = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .Caption    = "\<Salvar"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
            ENDWITH
            WITH .Buttons(2)
                .Top        = 5
                .Left       = 80
                .Height     = 75
                .Width      = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Tahoma"
                .FontSize   = 8
                .WordWrap   = .T.
                .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Caption    = "Encerrar"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
            ENDWITH
        ENDWITH

        *-- BINDEVENT para click do CommandGroup principal
        BINDEVENT(THIS.cmg_4c_Principal, "Click", THIS, "CmgPrincipalClick")
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
    *==========================================================================
        LOCAL loc_nI, loc_oObjeto, loc_oParent

        IF PCOUNT() < 1 OR VARTYPE(par_oContainer) != "O"
            loc_oParent = THIS
        ELSE
            loc_oParent = par_oContainer
        ENDIF

        FOR loc_nI = 1 TO loc_oParent.ControlCount
            loc_oObjeto = loc_oParent.Controls(loc_nI)
            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
    *-- Area de entrada de dados: shape decorativo + label "Planilha:" +
    *-- textbox do caminho da planilha + botao "..." para selecionar arquivo.
    *-- Form OPERACIONAL flat (sem PageFrame): esta e a metade "input"
    *-- do layout do legado SIGPRVTX (Shape1 + Say4 + GetPlanilha + cmdgetp).
    *==========================================================================
        LOCAL loc_oBtn

        *-- Shape decorativo ao redor da area de selecao de planilha
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top           = 82
            .Left          = 38
            .Width         = 632
            .Height        = 52
            .Curvature     = 0
            .SpecialEffect = 1
            .FillStyle     = 1
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderColor   = RGB(136, 189, 188)
        ENDWITH

        *-- Label "Planilha:" (Say4 legado: top=84, left=133)
        THIS.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.lbl_4c_Label4
            .Top       = 87
            .Left      = 166
            .Width     = 61
            .Height    = 15
            .Caption   = "Planilha:"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
        ENDWITH

        *-- TextBox para caminho da planilha (GetPlanilha legado: top=101, left=133, w=336)
        THIS.AddObject("txt_4c_Planilha", "TextBox")
        WITH THIS.txt_4c_Planilha
            .Top         = 105
            .Left        = 166
            .Width       = 420
            .Height      = 23
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ReadOnly    = .T.
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
        ENDWITH

        *-- Botao para selecionar arquivo (cmdgetp legado: top=86, left=471, w=65, h=44)
        THIS.AddObject("cmd_4c_GetPlanilha", "CommandButton")
        loc_oBtn = THIS.cmd_4c_GetPlanilha
        WITH loc_oBtn
            .Top             = 89
            .Left            = 589
            .Width           = 81
            .Height          = 44
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "geral_pasta_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_pasta_26.jpg"
            .FontName        = "Verdana"
            .FontSize        = 8
            .Themes          = .T.
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(36, 84, 155)
            .ToolTipText     = "Selecionar planilha Excel"
            .MousePointer    = 15
        ENDWITH

        *-- Vincula evento do botao de selecao de arquivo (integracao area Dados)
        BINDEVENT(THIS.cmd_4c_GetPlanilha, "Click", THIS, "CmdGetPlanilhaClick")
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
    *-- Area de resultado/lista: grade de SKUs importados + botoes Processar/Limpar.
    *-- Form OPERACIONAL flat (sem PageFrame): esta e a metade "resultado"
    *-- do layout do legado SIGPRVTX (Grade + cmdProcessar + cmdLimpar).
    *==========================================================================
        LOCAL loc_oGrid, loc_oBtn

        *-- Botao Limpar (cmdLimpar legado: top=3, left=498, w=75, h=75)
        THIS.AddObject("cmd_4c_Limpar", "CommandButton")
        loc_oBtn = THIS.cmd_4c_Limpar
        WITH loc_oBtn
            .Top             = 3
            .Left            = 623
            .Width           = 75
            .Height          = 75
            .Caption         = "\<Limpar"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .WordWrap        = .T.
            .Picture         = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
            .MousePointer    = 15
            .SpecialEffect   = 0
            .ToolTipText     = "Limpar grade e campo planilha"
        ENDWITH

        *-- Botao Processar/Importar (cmdProcessar legado: top=3, left=573, w=75, h=75)
        THIS.AddObject("cmd_4c_Processar", "CommandButton")
        loc_oBtn = THIS.cmd_4c_Processar
        WITH loc_oBtn
            .Top             = 3
            .Left            = 716
            .Width           = 75
            .Height          = 75
            .Caption         = "\<Processar"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .WordWrap        = .T.
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
            .MousePointer    = 15
            .SpecialEffect   = 0
            .ToolTipText     = "Importar planilha Excel para a grade"
        ENDWITH

        *-- Grade principal (Grade legado: top=133, left=30, w=725, h=435)
        THIS.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = THIS.grd_4c_Dados
        WITH loc_oGrid
            .Top                = 138
            .Left               = 12
            .Width              = 976
            .Height             = 450
            .ColumnCount        = 4
            .RecordMark         = .F.
            .DeleteMark         = .F.
            .ReadOnly           = .T.
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .RowHeight          = 16
            .ScrollBars         = 2
            .FontName           = "Tahoma"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
        ENDWITH

        *-- Vincula eventos dos botoes de acao da area lista/resultado
        BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "CmdProcessarClick")
        BINDEVENT(THIS.cmd_4c_Limpar,    "Click", THIS, "CmdLimparClick")
    ENDPROC

    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
    *-- Form OPERACIONAL flat: sem alternancia de paginas
    *==========================================================================
        RETURN
    ENDPROC

    *==========================================================================
    PROCEDURE CmgPrincipalClick()
    *-- Handler: Buttons(1)=Salvar/Processar DB, Buttons(2)=Encerrar
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro, loc_nBotao
        loc_nBotao = THIS.cmg_4c_Principal.Value

        IF loc_nBotao = 1
            TRY
                IF !USED("cursor_4c_Grade") OR RECCOUNT("cursor_4c_Grade") = 0
                    MsgAviso("Nenhum registro para atualiza" + CHR(231) + CHR(227) + "o.", ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    IF MsgConfirma("Deseja atualizar as informa" + CHR(231) + CHR(245) + "es?")
                        loc_lSucesso = THIS.this_oBusinessObject.ProcessarGrade("cursor_4c_Grade")
                        IF loc_lSucesso
                            THIS.LimpaGrade()
                            MsgInfo("Dados atualizados com sucesso.", "Sucesso")
                        ELSE
                            MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
                                "Aten" + CHR(231) + CHR(227) + "o")
                        ENDIF
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
            ENDTRY
        ELSE
            THIS.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE CmdGetPlanilhaClick()
    *-- Abre dialogo de selecao de arquivo Excel (cmdgetp.Click legado)
    *==========================================================================
        LOCAL loc_cArquivo
        loc_cArquivo = GETFILE("xls", "Planilha", "Importar")
        IF !EMPTY(loc_cArquivo)
            THIS.txt_4c_Planilha.Value = loc_cArquivo
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE CmdProcessarClick()
    *-- Importa planilha para cursor_4c_Grade e atualiza grade
    *==========================================================================
        IF EMPTY(THIS.txt_4c_Planilha.Value)
            MsgAviso("Planilha n" + CHR(227) + "o informada.", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        IF THIS.ImportarPlanilha(THIS.txt_4c_Planilha.Value)
            THIS.MontaGrade()
            THIS.txt_4c_Planilha.Value = ""
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE CmdLimparClick()
    *-- Limpa grade e campo planilha (cmdLimpar.Click legado)
    *==========================================================================
        THIS.LimpaGrade()
        IF VARTYPE(THIS.txt_4c_Planilha) = "O"
            THIS.txt_4c_Planilha.Value = ""
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ImportarPlanilha(par_cArquivo)
    *-- Le arquivo Excel via ImpExcelDriver e popula cursor_4c_Grade
    *-- Replica logica do metodo Processamento() do form legado SIGPRVTX
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cSkuId, loc_cNomeSku, loc_cSkuAtivo, loc_cRefSku
        loc_lSucesso = .F.

        TRY
            IF !FILE(par_cArquivo)
                MsgAviso("Arquivo n" + CHR(227) + "o encontrado:" + CHR(13) + par_cArquivo, ;
                    "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                *-- Fecha cursores de execucao anterior
                IF USED("Planilha")
                    USE IN Planilha
                ENDIF
                IF USED("xlResults")
                    USE IN xlResults
                ENDIF

                *-- Limpa cursor da grade antes de reimportar
                IF USED("cursor_4c_Grade")
                    SELECT cursor_4c_Grade
                    ZAP
                ENDIF

                *-- ImpExcelDriver (Framework) cria cursor xlResults com os dados do XLS
                IF ImpExcelDriver(par_cArquivo)
                    IF USED("xlResults")
                        *-- Copia xlResults para cursor Planilha com nome fixo
                        SELECT * FROM xlResults INTO CURSOR Planilha READWRITE
                        IF USED("xlResults")
                            USE IN xlResults
                        ENDIF

                        SELECT Planilha
                        GO TOP
                        SCAN
                            loc_cSkuId    = ALLTRIM(NVL(TRANSFORM(skuid),    ""))
                            loc_cNomeSku  = ALLTRIM(NVL(TRANSFORM(nomesku),  ""))
                            loc_cSkuAtivo = ALLTRIM(NVL(TRANSFORM(skuativo), ""))
                            loc_cRefSku   = ALLTRIM(NVL(TRANSFORM(refsku),   ""))

                            IF !EMPTY(loc_cSkuId)
                                *-- Inserir somente se nao houver duplicata por skuid
                                IF !SEEK(loc_cSkuId, "cursor_4c_Grade", "skuid")
                                    INSERT INTO cursor_4c_Grade ;
                                        (skuid, nomesku, skuativo, refsku) ;
                                        VALUES (;
                                            LEFT(loc_cSkuId,    10), ;
                                            LEFT(loc_cNomeSku, 100), ;
                                            LEFT(loc_cSkuAtivo,  3), ;
                                            LEFT(loc_cRefSku,   40))
                                ENDIF
                                SELECT Planilha
                            ENDIF
                        ENDSCAN

                        USE IN Planilha
                        SELECT cursor_4c_Grade
                        GO TOP
                        loc_lSucesso = .T.
                    ELSE
                        MsgErro("Erro ao criar cursor da planilha (xlResults n" + ;
                            CHR(227) + "o foi criado).", "Erro")
                    ENDIF
                ELSE
                    MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel ler a planilha." + ;
                        CHR(13) + "Verifique se o arquivo n" + CHR(227) + "o est" + ;
                        CHR(225) + " em uso por outro processo.", "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE MontaGrade()
    *-- Conecta grd_4c_Dados ao cursor_4c_Grade e (re)define colunas+cabecalhos
    *-- Equivalente ao metodo MontaGrade() do form legado SIGPRVTX
    *==========================================================================
        LOCAL loc_oGrid
        IF VARTYPE(THIS.grd_4c_Dados) != "O"
            RETURN
        ENDIF
        IF !USED("cursor_4c_Grade")
            RETURN
        ENDIF

        loc_oGrid = THIS.grd_4c_Dados
        loc_oGrid.RecordSource = ""
        SELECT cursor_4c_Grade
        GO TOP
        loc_oGrid.ColumnCount  = 4
        loc_oGrid.RecordSource = "cursor_4c_Grade"

        WITH loc_oGrid
            .Column1.ControlSource    = "cursor_4c_Grade.skuid"
            .Column1.Width            = 94
            .Column1.ReadOnly         = .T.
            .Column1.Movable          = .F.
            .Column1.Resizable        = .F.
            .Column1.Header1.Caption  = "SKU ID"
            .Column1.Header1.FontName = "Tahoma"
            .Column1.Header1.FontBold = .T.

            .Column2.ControlSource    = "cursor_4c_Grade.nomesku"
            .Column2.Width            = 539
            .Column2.ReadOnly         = .T.
            .Column2.Movable          = .F.
            .Column2.Resizable        = .F.
            .Column2.Header1.Caption  = "Nome SKU"
            .Column2.Header1.FontName = "Tahoma"
            .Column2.Header1.FontBold = .T.

            .Column3.ControlSource    = "cursor_4c_Grade.skuativo"
            .Column3.Width            = 94
            .Column3.ReadOnly         = .T.
            .Column3.Movable          = .F.
            .Column3.Resizable        = .F.
            .Column3.Header1.Caption  = "SKU Ativo"
            .Column3.Header1.FontName = "Tahoma"
            .Column3.Header1.FontBold = .T.

            .Column4.ControlSource    = "cursor_4c_Grade.refsku"
            .Column4.Width            = 249
            .Column4.ReadOnly         = .T.
            .Column4.Header1.Caption  = "Referencia SKU"
            .Column4.Header1.FontName = "Tahoma"
            .Column4.Header1.FontBold = .T.

            .Refresh()
        ENDWITH
    ENDPROC

    *==========================================================================
    PROCEDURE LimpaGrade()
    *-- Zap cursor_4c_Grade e reconecta grade (LimpaGrade() do legado)
    *==========================================================================
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.RecordSource = ""
        ENDIF

        IF USED("cursor_4c_Grade")
            SELECT cursor_4c_Grade
            ZAP
        ENDIF

        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.ColumnCount  = 4
            THIS.grd_4c_Dados.RecordSource = "cursor_4c_Grade"
            WITH THIS.grd_4c_Dados
                .Column1.ControlSource = "cursor_4c_Grade.skuid"
                .Column2.ControlSource = "cursor_4c_Grade.nomesku"
                .Column3.ControlSource = "cursor_4c_Grade.skuativo"
                .Column4.ControlSource = "cursor_4c_Grade.refsku"
                .Refresh()
            ENDWITH
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE FormKeyPress(par_nKeyCode, par_nShiftAltCtrl)
    *-- Handler de KeyPress do form: ESC fecha o formulario
    *==========================================================================
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 27
            THIS.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE BtnIncluirClick()
    *-- Acao INCLUIR (form OPERACIONAL VTX): importar novo lote de SKUs da
    *-- planilha Excel para a grade. Se nao ha planilha selecionada, abre o
    *-- dialogo de selecao antes de importar.
    *==========================================================================
        LOCAL loc_cArquivo
        IF VARTYPE(THIS.txt_4c_Planilha) != "O"
            RETURN
        ENDIF

        IF EMPTY(THIS.txt_4c_Planilha.Value)
            loc_cArquivo = GETFILE("xls", "Planilha", "Importar")
            IF EMPTY(loc_cArquivo)
                RETURN
            ENDIF
            THIS.txt_4c_Planilha.Value = loc_cArquivo
        ENDIF

        IF THIS.ImportarPlanilha(THIS.txt_4c_Planilha.Value)
            THIS.MontaGrade()
            THIS.txt_4c_Planilha.Value = ""
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE BtnAlterarClick()
    *-- Acao ALTERAR (form OPERACIONAL VTX): persistir a grade importada no
    *-- banco (equivalente ao Buttons(1) de Grupo_Botao legado - DELETE + INSERT
    *-- em SigPrVtx). Corresponde ao "Salvar" do CommandGroup principal.
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro, loc_lProsseguir
        loc_lSucesso   = .F.
        loc_lProsseguir = .F.

        TRY
            IF !USED("cursor_4c_Grade") OR RECCOUNT("cursor_4c_Grade") = 0
                MsgAviso("Nenhum registro para atualiza" + CHR(231) + CHR(227) + "o.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF MsgConfirma("Deseja atualizar as informa" + CHR(231) + CHR(245) + "es?")
                    loc_lProsseguir = .T.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                loc_lSucesso = THIS.this_oBusinessObject.ProcessarGrade("cursor_4c_Grade")
                IF loc_lSucesso
                    THIS.LimpaGrade()
                    MsgInfo("Dados atualizados com sucesso.", "Sucesso")
                ELSE
                    MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE BtnVisualizarClick()
    *-- Acao VISUALIZAR (form OPERACIONAL VTX): recarrega a grade a partir dos
    *-- SKUs ja persistidos em SigPrVtx (equivalente a "refresh" do estado
    *-- atual do banco). Popula cursor_4c_Grade via BO e reata o grid.
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgAviso("Business Object n" + CHR(227) + "o inicializado.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                *-- Fecha cursor local para o BO poder recria-lo com dados do banco
                IF USED("cursor_4c_Grade") AND VARTYPE(THIS.grd_4c_Dados) = "O"
                    THIS.grd_4c_Dados.RecordSource = ""
                    SELECT cursor_4c_Grade
                    USE
                ENDIF

                loc_lSucesso = THIS.this_oBusinessObject.CarregarGrade("cursor_4c_Grade")
                IF loc_lSucesso
                    THIS.MontaGrade()
                    IF USED("cursor_4c_Grade") AND RECCOUNT("cursor_4c_Grade") = 0
                        MsgAviso("Nenhum SKU cadastrado em SigPrVtx.", ;
                            "Aten" + CHR(231) + CHR(227) + "o")
                    ENDIF
                ELSE
                    MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE BtnExcluirClick()
    *-- Acao EXCLUIR (form OPERACIONAL VTX): limpa a grade importada e o campo
    *-- de planilha. Nao apaga registros do banco - apenas descarta o lote em
    *-- staging que ainda nao foi persistido (equivalente ao botao Limpar).
    *==========================================================================
        IF !USED("cursor_4c_Grade") OR RECCOUNT("cursor_4c_Grade") = 0
            MsgAviso("Grade j" + CHR(225) + " est" + CHR(225) + " vazia.", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        IF !MsgConfirma("Deseja limpar a grade importada?")
            RETURN
        ENDIF

        THIS.LimpaGrade()
        IF VARTYPE(THIS.txt_4c_Planilha) = "O"
            THIS.txt_4c_Planilha.Value = ""
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE BtnBuscarClick()
    *-- Busca/recarrega registros do banco (SKUs ja persistidos em sigprvtx)
    *==========================================================================
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    PROCEDURE BtnEncerrarClick()
    *-- Fecha o formulario
    *==========================================================================
        THIS.Release()
    ENDPROC

    *==========================================================================
    PROCEDURE BtnSalvarClick()
    *-- Salva a grade importada no banco (DELETE + INSERT em sigprvtx)
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro

        TRY
            IF !USED("cursor_4c_Grade") OR RECCOUNT("cursor_4c_Grade") = 0
                MsgAviso("Nenhum registro para atualiza" + CHR(231) + CHR(227) + "o.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF MsgConfirma("Deseja atualizar as informa" + CHR(231) + CHR(245) + "es?")
                    loc_lSucesso = THIS.this_oBusinessObject.ProcessarGrade("cursor_4c_Grade")
                    IF loc_lSucesso
                        THIS.LimparCampos()
                        MsgInfo("Dados atualizados com sucesso.", "Sucesso")
                    ELSE
                        MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
                            "Aten" + CHR(231) + CHR(227) + "o")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE BtnCancelarClick()
    *-- Cancela importacao em andamento: limpa grade e campo de planilha
    *==========================================================================
        IF USED("cursor_4c_Grade") AND RECCOUNT("cursor_4c_Grade") > 0
            IF !MsgConfirma("Deseja cancelar a importa" + CHR(231) + CHR(227) + "o e limpar a grade?")
                RETURN
            ENDIF
        ENDIF
        THIS.LimparCampos()
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarLista()
    *-- Carrega os SKUs ja persistidos em sigprvtx para exibicao na grade
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgAviso("Business Object n" + CHR(227) + "o inicializado.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF VARTYPE(THIS.grd_4c_Dados) = "O"
                    THIS.grd_4c_Dados.RecordSource = ""
                ENDIF

                IF USED("cursor_4c_Grade")
                    SELECT cursor_4c_Grade
                    USE
                ENDIF

                loc_lSucesso = THIS.this_oBusinessObject.CarregarGrade("cursor_4c_Grade")
                IF loc_lSucesso
                    THIS.MontaGrade()
                    IF USED("cursor_4c_Grade") AND RECCOUNT("cursor_4c_Grade") = 0
                        MsgAviso("Nenhum SKU cadastrado em sigprvtx.", ;
                            "Aten" + CHR(231) + CHR(227) + "o")
                    ENDIF
                ELSE
                    MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
    *-- Popula o BO com dados do formulario (OPERACIONAL: informa cursor da grade)
    *==========================================================================
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_cPlanilha = THIS.txt_4c_Planilha.Value
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
    *-- Atualiza formulario com dados do BO (OPERACIONAL: reconecta grade)
    *==========================================================================
        THIS.MontaGrade()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
    *-- Habilita ou desabilita campos de entrada (form OPERACIONAL: sempre ativo)
    *==========================================================================
        LOCAL loc_lHab
        IF PCOUNT() < 1
            loc_lHab = .T.
        ELSE
            loc_lHab = par_lHabilitar
        ENDIF

        IF VARTYPE(THIS.txt_4c_Planilha) = "O"
            THIS.txt_4c_Planilha.ReadOnly = !loc_lHab
        ENDIF
        IF VARTYPE(THIS.cmd_4c_GetPlanilha) = "O"
            THIS.cmd_4c_GetPlanilha.Enabled = loc_lHab
        ENDIF
        IF VARTYPE(THIS.cmd_4c_Processar) = "O"
            THIS.cmd_4c_Processar.Enabled = loc_lHab
        ENDIF
        IF VARTYPE(THIS.cmd_4c_Limpar) = "O"
            THIS.cmd_4c_Limpar.Enabled = loc_lHab
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
    *-- Limpa campo de planilha e esvazia a grade
    *==========================================================================
        IF VARTYPE(THIS.txt_4c_Planilha) = "O"
            THIS.txt_4c_Planilha.Value = ""
        ENDIF
        THIS.LimpaGrade()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
    *-- Form OPERACIONAL flat: sem modos (INCLUIR/ALTERAR/VISUALIZAR)
    *-- Todos os botoes permanecem habilitados
    *==========================================================================
        THIS.HabilitarCampos(.T.)
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        IF USED("cursor_4c_Grade")
            USE IN cursor_4c_Grade
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRVTXBO.prg):
*==============================================================================
* SIGPRVTXBO.prg - Business Object para FormSIGPRVTX
* Importacao de planilha Excel para atualizacao de SKUs (sigprvtx)
* Data: 2026-07-19
* Tabela principal: sigprvtx | PK: cidchaves
* Tabela auxiliar: SigCdPac (leitura de sigkeys)
*==============================================================================
DEFINE CLASS SIGPRVTXBO AS BusinessBase

    *-- -----------------------------------------------------------------------
    *-- CHAVE DE CONFIGURACAO (SigCdPac.sigkeys - lida no Init do Form)
    *-- -----------------------------------------------------------------------
    this_cSigKey        = ""    && sigkeys char(3) - chave de pacote de config

    *-- -----------------------------------------------------------------------
    *-- CAMINHO DA PLANILHA SELECIONADA
    *-- -----------------------------------------------------------------------
    this_cPlanilha      = ""    && Caminho completo do arquivo .xls selecionado

    *-- -----------------------------------------------------------------------
    *-- CAMPOS DA TABELA sigprvtx (PK + campos da planilha + demais colunas)
    *-- -----------------------------------------------------------------------
    this_cCidChaves     = ""    && cidchaves char(20)  NOT NULL - PK (fUniqueIds)
    this_cNomeSku       = ""    && nomesku   char(100) NOT NULL
    this_cRefSku        = ""    && refsku    char(40)  NOT NULL
    this_cSkuAtivo      = ""    && skuativo  char(3)   NOT NULL
    this_cSkuId         = ""    && skuid     char(10)  NOT NULL
    this_cCpros         = ""    && cpros     char(14)  NOT NULL
    this_cDescritivo    = ""    && descritivo char(45) NOT NULL
    this_cTamanho       = ""    && tamanho   char(4)   NOT NULL
    this_nQtd           = 0     && qtd       numeric(11,3) NOT NULL
    this_nBxQtd         = 0     && bxqtd     numeric(11,3) NOT NULL
    this_lChkAtuStock   = .F.   && chkatustock bit NULL
    this_nPvens         = 0     && pvens     numeric(11,5) NOT NULL
    this_nPrecode       = 0     && precode   numeric(11,5) NOT NULL
    this_lCkVtexUp      = .F.   && ckvtexup  bit NULL
    this_lCkAtuDesc     = .F.   && ckAtudesc bit NULL
    this_nVtexProdId    = 0     && vtexProdId int NULL

    *-- -----------------------------------------------------------------------
    *-- NOME DO CURSOR DA GRADE (padrao OPERACIONAL - cursor_4c_Grade)
    *-- -----------------------------------------------------------------------
    this_cCursorDados   = "cursor_4c_Grade"

    *--------------------------------------------------------------------------
    * Init - Configura BO: tabela e campo-chave da sigprvtx
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "sigprvtx"
            THIS.this_cCampoChave = "cidchaves"

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna cidchaves do registro corrente
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cSkuId      = ALLTRIM(NVL(skuid, ""))
                THIS.this_cNomeSku    = ALLTRIM(NVL(nomesku, ""))
                THIS.this_cSkuAtivo   = ALLTRIM(NVL(skuativo, ""))
                THIS.this_cRefSku     = ALLTRIM(NVL(refsku, ""))
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Cursor " + par_cAliasCursor + ;
                    " n" + CHR(227) + "o est" + CHR(225) + " em uso"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere um registro na tabela sigprvtx
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.

        TRY
            THIS.this_cCidChaves = fUniqueIds()

            loc_cSQL = "INSERT INTO sigprvtx " + ;
                "(cidchaves, nomesku, refsku, skuativo, skuid, " + ;
                "cpros, descritivo, tamanho, qtd, bxqtd, " + ;
                "chkatustock, pvens, precode, ckvtexup, ckAtudesc, vtexProdId) " + ;
                "VALUES (" + ;
                EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cNomeSku, 100)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cRefSku, 40)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cSkuAtivo, 3)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cSkuId, 10)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cCpros, 14)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cDescritivo, 45)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cTamanho, 4)) + ", " + ;
                FormatarNumeroSQL(THIS.this_nQtd, 3) + ", " + ;
                FormatarNumeroSQL(THIS.this_nBxQtd, 3) + ", " + ;
                IIF(THIS.this_lChkAtuStock, "1", "NULL") + ", " + ;
                FormatarNumeroSQL(THIS.this_nPvens, 5) + ", " + ;
                FormatarNumeroSQL(THIS.this_nPrecode, 5) + ", " + ;
                IIF(THIS.this_lCkVtexUp, "1", "NULL") + ", " + ;
                IIF(THIS.this_lCkAtuDesc, "1", "NULL") + ", " + ;
                IIF(THIS.this_nVtexProdId = 0, "NULL", FormatarNumeroSQL(THIS.this_nVtexProdId, 0)) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 1
                THIS.RegistrarAuditoria("I")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir registro em sigprvtx (SKU: " + ;
                    ALLTRIM(THIS.this_cSkuId) + ")"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela sigprvtx
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE sigprvtx SET " + ;
                "nomesku = "     + EscaparSQL(LEFT(THIS.this_cNomeSku, 100)) + ", " + ;
                "refsku = "      + EscaparSQL(LEFT(THIS.this_cRefSku, 40)) + ", " + ;
                "skuativo = "    + EscaparSQL(LEFT(THIS.this_cSkuAtivo, 3)) + ", " + ;
                "skuid = "       + EscaparSQL(LEFT(THIS.this_cSkuId, 10)) + ", " + ;
                "cpros = "       + EscaparSQL(LEFT(THIS.this_cCpros, 14)) + ", " + ;
                "descritivo = "  + EscaparSQL(LEFT(THIS.this_cDescritivo, 45)) + ", " + ;
                "tamanho = "     + EscaparSQL(LEFT(THIS.this_cTamanho, 4)) + ", " + ;
                "qtd = "         + FormatarNumeroSQL(THIS.this_nQtd, 3) + ", " + ;
                "bxqtd = "       + FormatarNumeroSQL(THIS.this_nBxQtd, 3) + ", " + ;
                "chkatustock = " + IIF(THIS.this_lChkAtuStock, "1", "NULL") + ", " + ;
                "pvens = "       + FormatarNumeroSQL(THIS.this_nPvens, 5) + ", " + ;
                "precode = "     + FormatarNumeroSQL(THIS.this_nPrecode, 5) + ", " + ;
                "ckvtexup = "    + IIF(THIS.this_lCkVtexUp, "1", "NULL") + ", " + ;
                "ckAtudesc = "   + IIF(THIS.this_lCkAtuDesc, "1", "NULL") + ", " + ;
                "vtexProdId = "  + IIF(THIS.this_nVtexProdId = 0, "NULL", ;
                                      FormatarNumeroSQL(THIS.this_nVtexProdId, 0)) + ;
                " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 1
                THIS.RegistrarAuditoria("A")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar registro em sigprvtx (cidchaves: " + ;
                    ALLTRIM(THIS.this_cCidChaves) + ")"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGrade - Popula o cursor da grade com os registros ja persistidos
    *                 em sigprvtx (usado por BtnVisualizarClick / refresh).
    *                 Cria cursor local com as 4 colunas do grid (skuid,
    *                 nomesku, skuativo, refsku) via SQLEXEC intermediario e
    *                 depois REPLICA em cursor local com nome canonico.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarGrade(par_cCursorGrade)
        LOCAL loc_lSucesso, loc_cSQL, loc_cCursorTmp
        loc_lSucesso   = .F.
        loc_cCursorTmp = "cursor_4c_GradeTmp"

        TRY
            loc_cSQL = "SELECT skuid, nomesku, skuativo, refsku FROM sigprvtx"

            IF USED(loc_cCursorTmp)
                USE IN (loc_cCursorTmp)
            ENDIF

            SET NULL ON
            IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTmp) >= 0
                *-- (Re)cria cursor com nome canonico e ordem/estrutura
                *-- identicas ao placeholder do form (protege ColumnCount/tags)
                IF USED(par_cCursorGrade)
                    SELECT (par_cCursorGrade)
                    USE
                ENDIF

                CREATE CURSOR (par_cCursorGrade) (;
                    skuid    C(10)  NULL, ;
                    nomesku  C(100) NULL, ;
                    skuativo C(3)   NULL, ;
                    refsku   C(40)  NULL)
                SELECT (par_cCursorGrade)
                INDEX ON skuid TAG skuid

                SELECT (loc_cCursorTmp)
                GO TOP
                SCAN
                    INSERT INTO (par_cCursorGrade) ;
                        (skuid, nomesku, skuativo, refsku) VALUES ( ;
                            NVL(skuid, ""), ;
                            NVL(nomesku, ""), ;
                            NVL(skuativo, ""), ;
                            NVL(refsku, ""))
                    SELECT (loc_cCursorTmp)
                ENDSCAN

                IF USED(loc_cCursorTmp)
                    USE IN (loc_cCursorTmp)
                ENDIF

                SELECT (par_cCursorGrade)
                GO TOP
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao consultar sigprvtx"
            ENDIF
            SET NULL OFF
        CATCH TO loc_oErro
            SET NULL OFF
            IF USED(loc_cCursorTmp)
                USE IN (loc_cCursorTmp)
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarGrade - Deleta todos os registros de sigprvtx e reinsere a
    *                  partir do cursor da grade (replica logica cmdok.Click)
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarGrade(par_cCursorGrade)
        LOCAL loc_lSucesso, loc_lTransacao, loc_cSQL
        loc_lSucesso = .F.
        loc_lTransacao = .F.

        TRY
            IF !USED(par_cCursorGrade)
                THIS.this_cMensagemErro = "Cursor " + par_cCursorGrade + ;
                    " n" + CHR(227) + "o est" + CHR(225) + " em uso"
            ELSE
                SELECT (par_cCursorGrade)
                GO TOP

                IF RECCOUNT(par_cCursorGrade) = 0
                    THIS.this_cMensagemErro = "Nenhum registro para atualiza" + ;
                        CHR(231) + CHR(227) + "o"
                ELSE
                    SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
                    loc_lTransacao = .T.

                    loc_cSQL = "DELETE FROM sigprvtx"
                    loc_lSucesso = (SQLEXEC(gnConnHandle, loc_cSQL) >= 1)

                    IF loc_lSucesso
                        SELECT (par_cCursorGrade)
                        GO TOP

                        SCAN WHILE loc_lSucesso
                            IF THIS.CarregarDoCursor(par_cCursorGrade)
                                IF !THIS.Inserir()
                                    loc_lSucesso = .F.
                                ENDIF
                            ELSE
                                loc_lSucesso = .F.
                            ENDIF
                            SELECT (par_cCursorGrade)
                        ENDSCAN

                        IF loc_lSucesso
                            SQLEXEC(gnConnHandle, "COMMIT")
                            loc_lTransacao = .F.
                        ENDIF
                    ELSE
                        THIS.this_cMensagemErro = "Falha ao excluir registros de sigprvtx"
                    ENDIF
                ENDIF
            ENDIF

            IF !loc_lSucesso AND loc_lTransacao
                SQLEXEC(gnConnHandle, "ROLLBACK")
            ENDIF
        CATCH TO loc_oErro
            IF loc_lTransacao
                SQLEXEC(gnConnHandle, "ROLLBACK")
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

